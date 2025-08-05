using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UpdateNavigationBasedOnLoginStatus();
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            // Update navigation on every page load to ensure current state
            UpdateNavigationBasedOnLoginStatus();
        }

        private void UpdateNavigationBasedOnLoginStatus()
        {
            // Check if user is logged in by checking session
            if (Session["UserID"] != null && Session["Username"] != null)
            {
                // User is logged in
                pnlLoggedIn.Visible = true;
                pnlNotLoggedIn.Visible = false;

                // Display username
                lblUsername.Text = Session["Username"].ToString();

                // Optionally show role-based information
                if (Session["Role"] != null)
                {
                    string role = Session["Role"].ToString();
                    if (role.ToLower() == "admin")
                    {
                        lblUsername.Text += " (Admin)";
                        // Show admin dashboard link for admin users
                        pnlAdminLink.Visible = true;
                    }
                    else
                    {
                        // Hide admin dashboard link for regular users
                        pnlAdminLink.Visible = false;
                    }
                }
                else
                {
                    // Hide admin dashboard link if no role
                    pnlAdminLink.Visible = false;
                }
            }
            else
            {
                // User is not logged in
                pnlLoggedIn.Visible = false;
                pnlNotLoggedIn.Visible = true;
                // Hide admin dashboard link when not logged in
                pnlAdminLink.Visible = false;
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            try
            {
                // Clear all session variables
                Session.Clear();
                Session.Abandon();

                // Clear any authentication cookies if you're using them
                if (Request.Cookies["ASP.NET_SessionId"] != null)
                {
                    Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                    Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
                }

                // Update navigation to show logged out state
                UpdateNavigationBasedOnLoginStatus();

                // Redirect to home page or login page
                Response.Redirect("~/Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Default.aspx", false);
            }
        }

        // Public method to allow child pages to refresh navigation
        public void RefreshNavigation()
        {
            UpdateNavigationBasedOnLoginStatus();
        }

        public bool IsUserLoggedIn
        {
            get
            {
                return Session["UserID"] != null && Session["Username"] != null;
            }
        }

        public string CurrentUsername
        {
            get
            {
                return Session["Username"]?.ToString() ?? string.Empty;
            }
        }

        public string CurrentUserRole
        {
            get
            {
                return Session["Role"]?.ToString() ?? string.Empty;
            }
        }

        public string CurrentUserID
        {
            get
            {
                return Session["UserID"]?.ToString() ?? string.Empty;
            }
        }

        protected void lnkBookTrip_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                // User is logged in
                //Response.Redirect("~/Travel/Destination.aspx");
            }
            else
            {
                // User is not logged in
                Response.Redirect("~/Travel/Login");
            }
        }
    }
}