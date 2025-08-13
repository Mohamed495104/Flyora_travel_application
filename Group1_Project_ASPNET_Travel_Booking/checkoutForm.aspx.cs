/*
 * Group Members: Greeshma Prasad (9042892), Mary Jain (9019215), Swedha (8995269), Mohammad Ijas (8917822)
 */
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Globalization;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class checkoutForm : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Redirect if not logged in or no cart
                if (Session["UserID"] == null || Session["Cart"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                LoadBookingSummary();
                InitializeForm();
            }
        }

        private void InitializeForm()
        {
            // Set default payment method to cash
            rbCash.Checked = true;

            // Disable card validators initially
            DisableCardValidators();
        }

        private void LoadBookingSummary()
        {
            try
            {
                var cart = Session["Cart"] as List<CartItem>;
                if (cart != null && cart.Count > 0)
                {
                    var displayItems = new List<CartItemDisplay>();
                    foreach (var item in cart)
                    {
                        var destination = GetDestinationInfo(item.DestinationId);
                        if (destination != null)
                        {
                            displayItems.Add(new CartItemDisplay
                            {
                                DestinationId = item.DestinationId,
                                Destination = destination.Value.Destination,
                                DepartureDate = item.DepartureDate,
                                ReturnDate = item.ReturnDate,
                                Travelers = item.Travelers,
                                TotalPrice = destination.Value.Price * item.Travelers
                            });
                        }
                    }

                    rptSummary.DataSource = displayItems;
                    rptSummary.DataBind();
                }
                else
                {
                    // No items in cart, redirect to destinations
                    Response.Redirect("~/Destination.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading summary: " + ex.Message, "danger");
            }
        }

        private (string Destination, decimal Price)? GetDestinationInfo(int destinationId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT Destination, Price FROM Destinations WHERE DestinationID = @DestinationID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@DestinationID", destinationId);

                    conn.Open();
                    var reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        return (reader["Destination"].ToString(), Convert.ToDecimal(reader["Price"]));
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error retrieving destination info: " + ex.Message, "danger");
            }

            return null;
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear any previous messages
                lblMessage.Visible = false;

                
                string selectedPaymentMethod = GetSelectedPaymentMethod();
                if (selectedPaymentMethod == "Card")
                {
                    EnableCardValidators();
                }
                else
                {
                    DisableCardValidators();
                }

                // Validate page before processing
                if (!Page.IsValid)
                {
                    ShowMessage("Please correct the validation errors and try again.", "danger");
                    return;
                }

                // Custom validation
                if (!ValidateCustomFields())
                {
                    return;
                }

                // Check session validity
                if (Session["Cart"] == null || Session["UserID"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                    return;
                }

                var cart = Session["Cart"] as List<CartItem>;
                int userId = Convert.ToInt32(Session["UserID"]);

                if (cart == null || cart.Count == 0)
                {
                    ShowMessage("Your cart is empty. Please add items to your cart first.", "danger");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlTransaction transaction = conn.BeginTransaction();

                    try
                    {
                        string paymentMethod = GetSelectedPaymentMethod();
                        string cardType = GetSelectedCardType();
                        int bookingId = 0;

                        
                        var firstItem = cart[0];

                        // Get destination price
                        decimal destinationPrice = GetDestinationPrice(firstItem.DestinationId, conn, transaction);
                        if (destinationPrice == 0)
                        {
                            throw new Exception("Invalid destination or price not found.");
                        }

                        decimal totalAmount = destinationPrice * firstItem.Travelers;

                        // Insert booking record
                        string insertQuery = @"INSERT INTO Bookings 
                            (UserID, DestinationID, BookingDate, TotalAmount, Status, NumTravelers, 
                             FullName, Email, Phone, Address, PaymentOption, CardType, CardLastFour)
                            VALUES 
                            (@UserID, @DestinationID, @BookingDate, @TotalAmount, @Status, @NumTravelers,
                             @FullName, @Email, @Phone, @Address, @PaymentOption, @CardType, @CardLastFour);
                            SELECT SCOPE_IDENTITY();";

                        SqlCommand cmd = new SqlCommand(insertQuery, conn, transaction);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@DestinationID", firstItem.DestinationId);
                        cmd.Parameters.AddWithValue("@BookingDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                        cmd.Parameters.AddWithValue("@Status", "Confirmed");
                        cmd.Parameters.AddWithValue("@NumTravelers", firstItem.Travelers);
                        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@PaymentOption", paymentMethod);
                        cmd.Parameters.AddWithValue("@CardType", cardType ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@CardLastFour", GetCardLastFour() ?? (object)DBNull.Value);

                        object result = cmd.ExecuteScalar();
                        if (result != null)
                        {
                            bookingId = Convert.ToInt32(result);
                        }

                        if (bookingId > 0)
                        {
                            // Commit transaction
                            transaction.Commit();

                            // Clear cart
                            Session["Cart"] = null;

                            // Redirect to success page
                            Response.Redirect("~/BookingSuccess.aspx?BookingID=" + bookingId, false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }
                        else
                        {
                            transaction.Rollback();
                            ShowMessage("Error creating booking. Please try again.", "danger");
                        }
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        ShowMessage("Transaction error: " + ex.Message, "danger");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error processing booking: " + ex.Message, "danger");
            }
        }

        private bool ValidateCustomFields()
        {
            bool isValid = true;

            // Validate terms acceptance
            if (!chkTerms.Checked)
            {
                ShowMessage("You must accept the terms and conditions.", "danger");
                isValid = false;
            }

            // Validate payment method selection
            string paymentMethod = GetSelectedPaymentMethod();
            if (string.IsNullOrEmpty(paymentMethod))
            {
                ShowMessage("Please select a payment method.", "danger");
                isValid = false;
            }

            // If card payment is selected, validate card details
            if (paymentMethod == "Card")
            {
                if (!ValidateCardDetails())
                {
                    isValid = false;
                }
            }

            // Validate name (letters and spaces only)
            if (string.IsNullOrWhiteSpace(txtFullName.Text) || !Regex.IsMatch(txtFullName.Text.Trim(), @"^[a-zA-Z\s]+$"))
            {
                ShowMessage("Name should contain only letters and spaces.", "danger");
                isValid = false;
            }

            // Validate phone number
            if (string.IsNullOrWhiteSpace(txtPhone.Text) || !Regex.IsMatch(txtPhone.Text.Trim(), @"^[\+]?[1-9][\d]{0,15}$"))
            {
                ShowMessage("Please enter a valid phone number.", "danger");
                isValid = false;
            }

            // Validate email format
            if (string.IsNullOrWhiteSpace(txtEmail.Text) || !Regex.IsMatch(txtEmail.Text.Trim(), @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                ShowMessage("Please enter a valid email address.", "danger");
                isValid = false;
            }

            // Validate address
            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                ShowMessage("Address is required.", "danger");
                isValid = false;
            }

            return isValid;
        }

        private bool ValidateCardDetails()
        {
            // Check if card type is selected
            string cardType = GetSelectedCardType();
            if (string.IsNullOrEmpty(cardType))
            {
                ShowMessage("Please select a card type (Credit or Debit).", "danger");
                return false;
            }

            // Validate card number format (16 digits with spaces)
            string cardNumber = txtCardNumber.Text.Trim();
            if (string.IsNullOrWhiteSpace(cardNumber) || !Regex.IsMatch(cardNumber, @"^\d{4}\s\d{4}\s\d{4}\s\d{4}$"))
            {
                ShowMessage("Please enter a valid 16-digit card number.", "danger");
                return false;
            }

            // Validate cardholder name
            if (string.IsNullOrWhiteSpace(txtCardHolder.Text))
            {
                ShowMessage("Cardholder name is required.", "danger");
                return false;
            }

            // Validate expiry date format and future date
            string expiryDate = txtExpiryDate.Text.Trim();
            if (string.IsNullOrWhiteSpace(expiryDate) || !Regex.IsMatch(expiryDate, @"^(0[1-9]|1[0-2])\/([0-9]{2})$"))
            {
                ShowMessage("Please enter expiry date in MM/YY format.", "danger");
                return false;
            }

            // Check if card is not expired
            if (!IsCardNotExpired(expiryDate))
            {
                ShowMessage("The card has expired. Please use a valid card.", "danger");
                return false;
            }

            // Validate CVV
            if (string.IsNullOrWhiteSpace(txtCVV.Text) || !Regex.IsMatch(txtCVV.Text.Trim(), @"^[0-9]{3,4}$"))
            {
                ShowMessage("CVV must be 3-4 digits.", "danger");
                return false;
            }

            return true;
        }

        private bool IsCardNotExpired(string expiryDate)
        {
            try
            {
                var parts = expiryDate.Split('/');
                if (parts.Length == 2)
                {
                    int month = int.Parse(parts[0]);
                    int year = int.Parse("20" + parts[1]);

                    var expiry = new DateTime(year, month, 1).AddMonths(1).AddDays(-1);
                    return expiry >= DateTime.Today;
                }
            }
            catch
            {
                return false;
            }
            return false;
        }

        private string GetSelectedPaymentMethod()
        {
            if (rbCash.Checked) return "Cash on Arrival";
            if (rbCard.Checked) return "Card";
            return null;
        }

        private string GetSelectedCardType()
        {
            if (rbCard.Checked)
            {
                if (rbCredit.Checked) return "Credit Card";
                if (rbDebit.Checked) return "Debit Card";
            }
            return null;
        }

        private string GetCardLastFour()
        {
            if (rbCard.Checked && !string.IsNullOrWhiteSpace(txtCardNumber.Text))
            {
                string cardNumber = txtCardNumber.Text.Replace(" ", "");
                if (cardNumber.Length >= 4)
                {
                    // Return only the last 4 digits to fit in char(4) column
                    return cardNumber.Substring(cardNumber.Length - 4);
                }
            }
            return null;
        }

        private decimal GetDestinationPrice(int destinationId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    return GetDestinationPrice(destinationId, conn, null);
                }
            }
            catch
            {
                return 0;
            }
        }

        private decimal GetDestinationPrice(int destinationId, SqlConnection conn, SqlTransaction transaction)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("SELECT Price FROM Destinations WHERE DestinationID = @DestinationID", conn, transaction);
                cmd.Parameters.AddWithValue("@DestinationID", destinationId);
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToDecimal(result) : 0;
            }
            catch
            {
                return 0;
            }
        }

        private void ShowMessage(string message, string type)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert alert-" + type;
            lblMessage.Visible = true;
        }

        private void DisableCardValidators()
        {
            
            rfvCardNumber.Enabled = false;
            revCardNumber.Enabled = false;
            rfvCardHolder.Enabled = false;
            rfvExpiry.Enabled = false;
            revExpiry.Enabled = false;
            cvExpiry.Enabled = false;
            rfvCVV.Enabled = false;
            revCVV.Enabled = false;
            cvCardType.Enabled = false;
        }

        private void EnableCardValidators()
        {
            
            rfvCardNumber.Enabled = true;
            revCardNumber.Enabled = true;
            rfvCardHolder.Enabled = true;
            rfvExpiry.Enabled = true;
            revExpiry.Enabled = true;
            cvExpiry.Enabled = true;
            rfvCVV.Enabled = true;
            revCVV.Enabled = true;
            cvCardType.Enabled = true;
        }

       
        public class CartItemDisplay
        {
            public int DestinationId { get; set; }
            public string Destination { get; set; }
            public DateTime DepartureDate { get; set; }
            public DateTime ReturnDate { get; set; }
            public int Travelers { get; set; }
            public decimal TotalPrice { get; set; }
            public string FormattedDates
            {
                get
                {
                    return $"{DepartureDate:MMM dd, yyyy} - {ReturnDate:MMM dd, yyyy}";
                }
            }
            public string TravelerText
            {
                get
                {
                    return Travelers == 1 ? "1 Traveler" : $"{Travelers} Travelers";
                }
            }
        }
    }
}