/*
 * Group Members: Greeshma Prasad (9042892), Mary Jain (9019215), Swedha (8995269), Mohammad Ijas (8917822)

 */
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class BookingSuccess : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string bookingId = Request.QueryString["BookingID"];

                if (!string.IsNullOrEmpty(bookingId))
                {
                    LoadBookingDetails(bookingId);
                }
                else
                {
                    lblError.Text = "Invalid booking ID.";
                    lblError.Visible = true;
                }
            }
        }

        private void LoadBookingDetails(string bookingId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT B.BookingID, B.BookingDate, B.TotalAmount, B.Status, 
                                            B.NumTravelers, B.Address, B.PaymentOption,
                                            D.Destination
                                     FROM Bookings B
                                     INNER JOIN Destinations D ON B.DestinationID = D.DestinationID
                                     WHERE B.BookingID = @BookingID";

                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@BookingID", bookingId);

                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        lblBookingID.Text = reader["BookingID"].ToString();
                        lblDestination.Text = reader["Destination"].ToString();
                        lblAmount.Text = Convert.ToDecimal(reader["TotalAmount"]).ToString("C");
                        lblStatus.Text = reader["Status"].ToString();
                        lblTravelers.Text = reader["NumTravelers"].ToString();
                        lblPayment.Text = reader["PaymentOption"].ToString();
                        lblAddress.Text = reader["Address"].ToString();
                        lblDate.Text = Convert.ToDateTime(reader["BookingDate"]).ToString("MMMM dd, yyyy");
                    }
                    else
                    {
                        lblError.Text = "Booking not found.";
                        lblError.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error loading booking details: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}
