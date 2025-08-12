
/*
 * Group Members: Greeshma Prasad (9042892), Mary Jain (9019215), Swedha (8995269), Mohammad Ijas (8917822)
 */
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateUIBasedOnLoginStatus();
            }
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            UpdateUIBasedOnLoginStatus();
        }

        private void UpdateUIBasedOnLoginStatus()
        {
            if (Master.IsUserLoggedIn)
            {
                pnlLoggedInHero.Visible = true;
                pnlNotLoggedInHero.Visible = false;
                lblHeroUsername.Text = Master.CurrentUsername;
                btnHeroBook.Text = "Book Your Next Trip";
            }
            else
            {
                pnlLoggedInHero.Visible = false;
                pnlNotLoggedInHero.Visible = true;
                btnHeroBook.Text = "Sign Up & Book Now";
            }
        }

        protected void btnHeroBook_Click(object sender, EventArgs e)
        {
            if (Master.IsUserLoggedIn)
            {

            }
            else
            {
                Response.Redirect("~/Travel/Login");
            }
        }

        protected void lvDestinations_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Book")
            {
                string actualDestinationId = e.CommandArgument.ToString();
                Response.Redirect($"~/Travel/DestinationDetail?DestinationID={actualDestinationId}");
            }
        }
    }
}
