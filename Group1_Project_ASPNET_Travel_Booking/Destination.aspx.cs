/*
 * Group Members: Greeshma Prasad (9042892), Mary Jain (9019215), Swedha (8995269), Mohammad Ijas (8917822)
 */
using System;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class Destination : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void lvDestinations_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Book")
            {
                string destinationId = e.CommandArgument.ToString();
                Response.Redirect($"~/Travel/DestinationDetail?DestinationID={destinationId}");
            }
        }
    }
}