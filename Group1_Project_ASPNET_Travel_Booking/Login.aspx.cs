using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
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

            // TEMPORARY DEBUG: Show all session values
            Debug.WriteLine("Session contents:");
            foreach (string key in Session.Keys)
            {
                Debug.WriteLine($"{key} = {Session[key]}");
            }
            if (!IsPostBack)
            {

                ViewState["ActiveTab"] = "Login";
                ShowLoginTab();
            }
            else
            {

                string activeTab = ViewState["ActiveTab"] as string ?? "Login";
                if (activeTab == "Register")
                {
                    ShowRegisterTab();
                }
                else
                {
                    ShowLoginTab();
                }
            }
        }

        protected void lnkTab_Click(object sender, EventArgs e)
        {
            string tab = ((LinkButton)sender).CommandArgument;
            ViewState["ActiveTab"] = tab;
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
            ViewState["ActiveTab"] = "Register";
            ClearAllValidators();
            ShowRegisterTab();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = txtLoginEmail.Text.Trim();
                string password = txtLoginPassword.Text.Trim();

                sqlDataSourceLogin.SelectParameters["Email"].DefaultValue = email;
                sqlDataSourceLogin.SelectParameters["Password"].DefaultValue = password;

                DataView dv = (DataView)sqlDataSourceLogin.Select(DataSourceSelectArguments.Empty);

                if (dv.Table.Rows.Count > 0)
                {
                    DataRow user = dv.Table.Rows[0];

                    // Store user information in session
                    Session["UserID"] = user["UserID"];
                    Session["Username"] = user["Username"];
                    Session["Email"] = user["Email"];
                    Session["Role"] = user["Role"];
                    Session.Timeout = 60;

                    string role = user["Role"].ToString().ToLower();
                    if (role == "admin")
                    {

                        Response.Redirect("~/Admin.aspx", false);
                        Context.ApplicationInstance.CompleteRequest();
                    }
                    else
                    {
                        Response.Redirect("~/Travel/Default");
                    }
                }
                else
                {
                    lblLoginError.Text = "Invalid email or password. Please try again.";
                    lblLoginError.Visible = true;
                }
            }
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {

                ViewState["ActiveTab"] = "Register";

                lblRegError.Visible = false;
                lblRegError.Text = "";


                ShowRegisterTab();


                Page.Validate("RegisterGroup");
                if (!Page.IsValid)
                {

                    return;
                }

                string username = txtRegName.Text.Trim();
                string email = txtRegEmail.Text.Trim();
                string password = txtRegPassword.Text.Trim();
                string role = ddlRole.SelectedValue;


                if (string.IsNullOrWhiteSpace(username))
                {
                    lblRegError.Text = "Username is required.";
                    lblRegError.Visible = true;
                    return;
                }

                if (string.IsNullOrWhiteSpace(email))
                {
                    lblRegError.Text = "Email is required.";
                    lblRegError.Visible = true;
                    return;
                }

                if (string.IsNullOrWhiteSpace(password))
                {
                    lblRegError.Text = "Password is required.";
                    lblRegError.Visible = true;
                    return;
                }

                if (string.IsNullOrWhiteSpace(role))
                {
                    lblRegError.Text = "Role is required.";
                    lblRegError.Visible = true;
                    return;
                }


                try
                {
                    sqlDataSourceCheckEmail.SelectParameters["Email"].DefaultValue = email;
                    DataView dvEmail = (DataView)sqlDataSourceCheckEmail.Select(DataSourceSelectArguments.Empty);

                    if (dvEmail != null && dvEmail.Table.Rows.Count > 0)
                    {
                        int emailCount = Convert.ToInt32(dvEmail.Table.Rows[0]["EmailCount"]);
                        if (emailCount > 0)
                        {
                            lblRegError.Text = "Email already exists. Please use a different email.";
                            lblRegError.Visible = true;
                            return;
                        }
                    }
                }
                catch (Exception emailEx)
                {
                    lblRegError.Text = "Error checking email: " + emailEx.Message;
                    lblRegError.Visible = true;
                    System.Diagnostics.Debug.WriteLine("Email check error: " + emailEx.Message);
                    return;
                }

                // Check if username already exists
                try
                {
                    sqlDataSourceCheckUsername.SelectParameters["Username"].DefaultValue = username;
                    DataView dvUsername = (DataView)sqlDataSourceCheckUsername.Select(DataSourceSelectArguments.Empty);

                    if (dvUsername != null && dvUsername.Table.Rows.Count > 0)
                    {
                        int usernameCount = Convert.ToInt32(dvUsername.Table.Rows[0]["UsernameCount"]);
                        if (usernameCount > 0)
                        {
                            lblRegError.Text = "Username already exists. Please choose a different username.";
                            lblRegError.Visible = true;
                            return;
                        }
                    }
                }
                catch (Exception usernameEx)
                {
                    lblRegError.Text = "Error checking username: " + usernameEx.Message;
                    lblRegError.Visible = true;

                    return;
                }


                try
                {

                    sqlDataSourceRegister.InsertParameters["Username"].DefaultValue = username;
                    sqlDataSourceRegister.InsertParameters["Email"].DefaultValue = email;
                    sqlDataSourceRegister.InsertParameters["Password"].DefaultValue = password;
                    sqlDataSourceRegister.InsertParameters["Role"].DefaultValue = role;
                    sqlDataSourceRegister.InsertParameters["CreatedAt"].DefaultValue = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");


                    int result = sqlDataSourceRegister.Insert();


                    sqlDataSourceRegister.SelectParameters["Email"].DefaultValue = email;
                    DataView dvNewUser = (DataView)sqlDataSourceRegister.Select(DataSourceSelectArguments.Empty);

                    if (dvNewUser != null && dvNewUser.Table.Rows.Count > 0)
                    {

                        DataRow newUser = dvNewUser.Table.Rows[0];

                        // Store user information in session
                        Session["UserID"] = newUser["UserID"];
                        Session["Username"] = newUser["Username"];
                        Session["Email"] = newUser["Email"];
                        Session["Role"] = newUser["Role"];


                        ClearRegistrationForm();


                        if (role == "admin")
                        {

                            Response.Redirect("~/Admin.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
                        else
                        {
                            Response.Redirect("~/Travel/Default");
                        }
                    }
                    else
                    {
                        lblRegError.Text = "Registration completed but user data could not be retrieved. Please try logging in.";
                        lblRegError.Visible = true;
                    }
                }
                catch (Exception insertEx)
                {
                    lblRegError.Text = "Registration failed during insert: " + insertEx.Message;
                    lblRegError.Visible = true;
                    System.Diagnostics.Debug.WriteLine("Insert error: " + insertEx.Message);
                    System.Diagnostics.Debug.WriteLine("Stack trace: " + insertEx.StackTrace);
                }
            }
            catch (Exception ex)
            {

                lblRegError.Text = "Registration failed: " + ex.Message;
                lblRegError.Visible = true;
                ShowRegisterTab();


            }
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

            foreach (BaseValidator validator in Page.Validators)
            {
                validator.IsValid = true;
            }


            lblLoginError.Visible = false;
            lblRegError.Visible = false;
        }

        private void ClearRegistrationForm()
        {
            txtRegName.Text = "";
            txtRegEmail.Text = "";
            txtRegPassword.Text = "";
            ddlRole.SelectedIndex = 0;
        }
    }
}