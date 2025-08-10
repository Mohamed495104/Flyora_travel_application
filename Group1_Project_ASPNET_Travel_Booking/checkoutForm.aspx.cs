using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                    Response.Redirect("~/Travel/Login.aspx");
                    return;
                }

                LoadBookingSummary();
            }
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
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading summary: " + ex.Message;
                lblMessage.Visible = true;
            }
        }

        private (string Destination, decimal Price)? GetDestinationInfo(int destinationId)
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

            return null;
        }

        protected void btnBook_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid || !chkTerms.Checked)
                return;

            if (Session["Cart"] == null || Session["UserID"] == null)
            {
                Response.Redirect("~/Travel/Login.aspx");
                return;
            }

            var cart = Session["Cart"] as List<CartItem>;
            int userId = Convert.ToInt32(Session["UserID"]);

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    foreach (var item in cart)
                    {
                        string insertQuery = @"INSERT INTO Bookings 
                            (UserID, DestinationID, BookingDate, TotalAmount, Status, NumTravelers, Address, PaymentOption)
                            VALUES 
                            (@UserID, @DestinationID, @BookingDate, @TotalAmount, @Status, @NumTravelers, @Address, @PaymentOption);
                            SELECT SCOPE_IDENTITY();";

                        SqlCommand cmd = new SqlCommand(insertQuery, conn);
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        cmd.Parameters.AddWithValue("@DestinationID", item.DestinationId);
                        cmd.Parameters.AddWithValue("@BookingDate", DateTime.Now);
                        cmd.Parameters.AddWithValue("@TotalAmount", GetDestinationPrice(item.DestinationId) * item.Travelers);
                        cmd.Parameters.AddWithValue("@Status", "Confirmed");
                        cmd.Parameters.AddWithValue("@NumTravelers", item.Travelers);
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                        cmd.Parameters.AddWithValue("@PaymentOption", ddlPayment.SelectedValue);

                        int bookingId = Convert.ToInt32(cmd.ExecuteScalar());

                        // Clear cart and redirect
                        Session["Cart"] = null;
                        Response.Redirect("~/BookingSuccess.aspx?BookingID=" + bookingId);
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error placing booking: " + ex.Message;
                lblMessage.Visible = true;
            }
        }

        private decimal GetDestinationPrice(int destinationId)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT Price FROM Destinations WHERE DestinationID = @DestinationID", conn);
                cmd.Parameters.AddWithValue("@DestinationID", destinationId);
                object result = cmd.ExecuteScalar();
                return result != null ? Convert.ToDecimal(result) : 0;
            }
        }

        // ✅ Updated to include travel dates
        public class CartItemDisplay
        {
            public int DestinationId { get; set; }
            public string Destination { get; set; }
            public DateTime DepartureDate { get; set; }
            public DateTime ReturnDate { get; set; }
            public int Travelers { get; set; }
            public decimal TotalPrice { get; set; }
        }
    }
}
