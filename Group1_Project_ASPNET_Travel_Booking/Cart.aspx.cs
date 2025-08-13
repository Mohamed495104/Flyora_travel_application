/*
 * Group Members: Greeshma Prasad (9042892), Mary Jain (9019215), Swedha (8995269), Mohammad Ijas (8917822)
 */
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class Cart : System.Web.UI.Page
    {
        private string connectionString = WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCartItems();
            }
        }

        private void LoadCartItems()
        {
            try
            {
                List<CartItemDisplay> cartItems = GetCartItemsWithDetails();

                if (cartItems.Count > 0)
                {
                    pnlCartItems.Visible = true;
                    pnlEmptyCart.Visible = false;

                    rptCartItems.DataSource = cartItems;
                    rptCartItems.DataBind();

                    UpdateCartSummary(cartItems);
                }
                else
                {
                    pnlCartItems.Visible = false;
                    pnlEmptyCart.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading cart: " + ex.Message, "alert-danger");
                pnlCartItems.Visible = false;
                pnlEmptyCart.Visible = true;
            }
        }

        private List<CartItemDisplay> GetCartItemsWithDetails()
        {
            List<CartItemDisplay> cartItemsDisplay = new List<CartItemDisplay>();

            try
            {
                if (Session["Cart"] != null)
                {
                    var sessionCart = (List<CartItem>)Session["Cart"];

                    foreach (var cartItem in sessionCart)
                    {
                        var displayItem = GetDestinationDetails(cartItem);
                        if (displayItem != null)
                        {
                            cartItemsDisplay.Add(displayItem);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error retrieving cart items: " + ex.Message, "alert-danger");
            }

            return cartItemsDisplay;
        }

        private CartItemDisplay GetDestinationDetails(CartItem cartItem)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT DestinationID, Destination, Description, Price, AvailableSeats, DepartureDate, ReturnDate, ImageURL FROM Destinations WHERE DestinationID = @DestinationID";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@DestinationID", cartItem.DestinationId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        decimal price = Convert.ToDecimal(reader["Price"]);
                        return new CartItemDisplay
                        {
                            DestinationId = cartItem.DestinationId,
                            Destination = reader["Destination"].ToString(),
                            Description = reader["Description"].ToString(),
                            Price = price,
                            ImageURL = reader["ImageURL"].ToString(),
                            DepartureDate = cartItem.DepartureDate,
                            ReturnDate = cartItem.ReturnDate,
                            Travelers = cartItem.Travelers,
                            TotalPrice = price * cartItem.Travelers,
                            AddedDate = cartItem.AddedDate
                        };
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error retrieving destination details: " + ex.Message, "alert-danger");
            }

            return null;
        }

        private void UpdateCartSummary(List<CartItemDisplay> cartItems)
        {
            try
            {
                int itemCount = cartItems.Count;
                int totalTravelers = cartItems.Sum(x => x.Travelers);
                decimal subtotal = cartItems.Sum(x => x.TotalPrice);
                decimal taxRate = 0.13m; // 13% HST
                decimal tax = subtotal * taxRate;
                decimal grandTotal = subtotal + tax;

                lblItemCount.Text = itemCount.ToString();
                lblTotalTravelers.Text = totalTravelers.ToString();
                lblSubtotal.Text = subtotal.ToString("C");
                lblTax.Text = tax.ToString("C");
                lblGrandTotal.Text = grandTotal.ToString("C");
            }
            catch (Exception ex)
            {
                ShowMessage("Error calculating totals: " + ex.Message, "alert-danger");
            }
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            try
            {
                int destinationId = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "Remove")
                {
                    RemoveFromCart(destinationId);
                    LoadCartItems();
                    ShowMessage("Item removed from cart successfully!", "alert-success");

                    // Refresh the master page cart count
                    RefreshMasterPageCartCount();
                }
                else if (e.CommandName == "Update")
                {
                    // Redirect to destination detail page for editing
                    Response.Redirect($"~/DestinationDetail.aspx?DestinationID={destinationId}");

                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error processing request: " + ex.Message, "alert-danger");
            }
        }

        private void RemoveFromCart(int destinationId)
        {
            try
            {
                if (Session["Cart"] != null)
                {
                    var cart = (List<CartItem>)Session["Cart"];
                    cart.RemoveAll(x => x.DestinationId == destinationId);
                    Session["Cart"] = cart;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error removing item from cart: " + ex.Message, "alert-danger");
            }
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            try
            {
                Session["Cart"] = null;
                LoadCartItems();
                ShowMessage("Cart cleared successfully!", "alert-info");

                // Refresh the master page cart count
                RefreshMasterPageCartCount();
            }
            catch (Exception ex)
            {
                ShowMessage("Error clearing cart: " + ex.Message, "alert-danger");
            }
        }

        protected void btnProceedToCheckout_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if user is logged in
                if (Session["UserID"] == null)
                {
                    ShowMessage("Please login to proceed with booking.", "alert-warning");

                    try
                    {
                        
                        string loginUrl = Page.GetRouteUrl("Login", null);
                        if (!string.IsNullOrEmpty(loginUrl))
                        {
                            Response.Redirect(loginUrl, false);
                            Context.ApplicationInstance.CompleteRequest();
                            return;
                        }
                    }
                    catch { }

                    try
                    {
                       
                        Response.Redirect("~/Travel/Login", false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }
                    catch { }

                    try
                    {
                        
                        Response.Redirect("~/Login.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                        return;
                    }
                    catch { }

                    
                    Response.Write("<script>window.location.href = '/Travel/Login';</script>");
                    return;
                }

                // Check if cart has items
                if (Session["Cart"] == null || ((List<CartItem>)Session["Cart"]).Count == 0)
                {
                    ShowMessage("Your cart is empty. Please add destinations to proceed.", "alert-warning");
                    return;
                }

                // Redirect to checkout form
                Response.Redirect("~/checkoutForm.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("Error proceeding to checkout: " + ex.Message, "alert-danger");
            }
        }


        private void RefreshMasterPageCartCount()
        {
            try
            {
                if (Master is Site1 masterPage)
                {
                    masterPage.RefreshNavigation();
                }
            }
            catch (Exception)
            {
               
            }
        }

        private void ShowMessage(string message, string alertClass)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = $"alert {alertClass} d-block";
            lblMessage.Visible = true;
        }
    }

    // Extended CartItem class for display purposes
    public class CartItemDisplay : CartItem
    {
        public string Destination { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public string ImageURL { get; set; }
        public decimal TotalPrice { get; set; }
    }
}