using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ensure login tab is active by default
                ShowLoginTab();
            }
        }

        protected void lnkTab_Click(object sender, EventArgs e)
        {
            string tab = ((LinkButton)sender).CommandArgument;
            ClearAllValidators();

            if (tab == "Login")
            {
                ShowLoginTab();
            }
            else if (tab == "Register")
            {
                ShowRegisterTab();
            }
        }

        protected void lnkSwitchToRegister_Click(object sender, EventArgs e)
        {
            ClearAllValidators();
            ShowRegisterTab();
        }

        private void ShowLoginTab()
        {
            pnlLogin.CssClass = "tab-content active";
            pnlRegister.CssClass = "tab-content";
            lnkLoginTab.CssClass = "nav-link active";
            lnkRegisterTab.CssClass = "nav-link";
        }

        private void ShowRegisterTab()
        {
            pnlRegister.CssClass = "tab-content active";
            pnlLogin.CssClass = "tab-content";
            lnkRegisterTab.CssClass = "nav-link active";
            lnkLoginTab.CssClass = "nav-link";
        }

        private void ClearAllValidators()
        {
            // Clear all validation error messages
            Page.Validate();

            // Reset validation state
            foreach (BaseValidator validator in Page.Validators)
            {
                validator.IsValid = true;
            }

            // Hide error labels
            lblLoginError.Visible = false;
            lblRegError.Visible = false;

            
        }

      
    }
}