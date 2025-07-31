using System;
using System.Web.UI.WebControls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class DestinationDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.QueryString["DestinationID"]))
                {
                    Response.Redirect("~/Travel/Destination");
                }
            }
        }

        protected void dvDestination_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                AddToCart();
            }
        }

        protected void dvDestination_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                ShowMessage("Travel dates updated successfully! You can now proceed to book.", "alert-success");
                // Optionally redirect to booking page
                // Response.Redirect("~/Booking/BookingForm.aspx?DestinationID=" + Request.QueryString["DestinationID"]);
            }
            else
            {
                ShowMessage("Error updating travel dates: " + e.Exception.Message, "alert-danger");
                e.ExceptionHandled = true;
            }
        }

        private void AddToCart()
        {
            try
            {
                DetailsView dv = dvDestination;
                int destinationId = Convert.ToInt32(Request.QueryString["DestinationID"]);

                // Get values from EditItemTemplate controls
                TextBox txtDepartureDate = dv.FindControl("txtDepartureDate") as TextBox;
                TextBox txtReturnDate = dv.FindControl("txtReturnDate") as TextBox;
                DropDownList ddlTravelers = dv.FindControl("ddlTravelers") as DropDownList;

                DateTime departureDate = DateTime.Parse(txtDepartureDate.Text);
                DateTime returnDate = DateTime.Parse(txtReturnDate.Text);
                int travelers = Convert.ToInt32(ddlTravelers.SelectedValue);

                // Validate dates
                if (departureDate < DateTime.Today)
                {
                    ShowMessage("Departure date cannot be in the past.", "alert-danger");
                    return;
                }

                // Add to cart
                AddToCartSession(destinationId, departureDate, returnDate, travelers);
                ShowMessage($"Destination added to cart for {travelers} traveler(s)! Departure: {departureDate:MMM dd, yyyy}, Return: {returnDate:MMM dd, yyyy}", "alert-success");
            }
            catch (Exception ex)
            {
                ShowMessage("Error adding to cart: " + ex.Message, "alert-danger");
            }
        }

        private void AddToCartSession(int destinationId, DateTime departureDate, DateTime returnDate, int travelers)
        {
            if (Session["Cart"] == null)
            {
                Session["Cart"] = new System.Collections.Generic.List<CartItem>();
            }

            var cart = (System.Collections.Generic.List<CartItem>)Session["Cart"];

            var existingItem = cart.Find(x => x.DestinationId == destinationId);
            if (existingItem != null)
            {
                existingItem.DepartureDate = departureDate;
                existingItem.ReturnDate = returnDate;
                existingItem.Travelers = travelers;
            }
            else
            {
                cart.Add(new CartItem
                {
                    DestinationId = destinationId,
                    DepartureDate = departureDate,
                    ReturnDate = returnDate,
                    Travelers = travelers,
                    AddedDate = DateTime.Now
                });
            }

            Session["Cart"] = cart;
        }

        private void ShowMessage(string message, string alertClass)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = $"alert {alertClass} d-block mt-3";
            lblMessage.Visible = true;
        }
    }

    public class CartItem
    {
        public int DestinationId { get; set; }
        public DateTime DepartureDate { get; set; }
        public DateTime ReturnDate { get; set; }
        public int Travelers { get; set; }
        public DateTime AddedDate { get; set; }
    }
}