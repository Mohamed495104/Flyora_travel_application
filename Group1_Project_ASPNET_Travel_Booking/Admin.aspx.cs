/*
 * Group Members: Greeshma Prasad (123456), Mary Jain (9019215), Swedha (8995269), Mohammad Ijas (345678)
 * Travel Booking Admin Panel
 */

using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    /// <summary>
    /// </summary>
    public partial class Admin : System.Web.UI.Page
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        /// <summary>
        /// Page load with admin authentication and data loading
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if user is admin
            if (Session["Role"] == null || Session["Role"].ToString().ToLower() != "admin")
            {
                // Store redirect data
                Session["RedirectAfterLogin"] = Request.Url.PathAndQuery;
                Response.Redirect("~/Travel/Login", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Only load data on first visit (not on button clicks)
            if (!IsPostBack)
            {
                // Activate the "Destinations" tab by default
                lnkDestinationsTab.CssClass = "tab-btn active";
                pnlDestinations.Visible = true;
                pnlCategories.Visible = false;

                // Load data
                LoadStatistics();
                LoadCategories();
                BindDestinations();
                BindCategoriesGrid();
            }
        }

        /// <summary>
        /// Pre-render event to ensure panel visibility with inline styles (CSS override fix)
        /// </summary>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            // Ensure panel visibility overrides any conflicting CSS
            if (pnlCategories.Visible)
            {
                pnlCategories.Attributes["style"] = "display: block !important;";
            }
            else
            {
                pnlCategories.Attributes["style"] = "display: none !important;";
            }

            if (pnlDestinations.Visible)
            {
                pnlDestinations.Attributes["style"] = "display: block !important;";
            }
            else
            {
                pnlDestinations.Attributes["style"] = "display: none !important;";
            }
        }

        #region Authentication

        /// <summary>
        /// Checks if current user has admin privileges
        /// </summary>
        private bool IsUserAdmin()
        {
            if (Session["UserID"] != null && Session["Role"] != null)
            {
                string role = Session["Role"].ToString().ToLower();
                return role == "admin";
            }
            return false;
        }

        #endregion

        #region Statistics Dashboard

        /// <summary>
        /// Loads real-time statistics for dashboard
        /// </summary>
        private void LoadStatistics()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get destinations count
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Destinations", conn);
                    lblTotalDestinations.Text = cmd.ExecuteScalar().ToString();

                    // Get categories count
                    cmd = new SqlCommand("SELECT COUNT(*) FROM Categories", conn);
                    lblTotalCategories.Text = cmd.ExecuteScalar().ToString();

                    // Get bookings count
                    cmd = new SqlCommand("SELECT COUNT(*) FROM Bookings", conn);
                    lblTotalBookings.Text = cmd.ExecuteScalar().ToString();

                    // Get users count
                    cmd = new SqlCommand("SELECT COUNT(*) FROM Users", conn);
                    lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading statistics: " + ex.Message, "alert-danger");
            }
        }

        #endregion

        #region Tab Management

        /// <summary>
        /// Enhanced tab switching with proper visibility control
        /// </summary>
        protected void lnkTab_Click(object sender, EventArgs e)
        {
            try
            {
                LinkButton lnk = (LinkButton)sender;
                string tabName = lnk.CommandArgument;

                // Reset all tab styles and visibility
                lnkDestinationsTab.CssClass = "tab-btn";
                lnkCategoriesTab.CssClass = "tab-btn";
                pnlDestinations.Visible = false;
                pnlCategories.Visible = false;

                // Activate selected tab
                switch (tabName)
                {
                    case "Destinations":
                        lnkDestinationsTab.CssClass = "tab-btn active";
                        pnlDestinations.Visible = true;
                        BindDestinations();
                        break;

                    case "Categories":
                        lnkCategoriesTab.CssClass = "tab-btn active";
                        pnlCategories.Visible = true;
                        BindCategoriesGrid();
                        break;

                    default:
                        // Default to destinations if unknown
                        lnkDestinationsTab.CssClass = "tab-btn active";
                        pnlDestinations.Visible = true;
                        BindDestinations();
                        break;
                }

                ShowMessage($"Switched to {tabName} tab", "alert-info");
            }
            catch (Exception ex)
            {
                ShowMessage($"Error switching tabs: {ex.Message}", "alert-danger");
            }
        }

        #endregion

        #region Category Management

        /// <summary>
        /// Loads categories for dropdown with enhanced error handling
        /// </summary>
        private void LoadCategories()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter("SELECT CategoryID, CategoryName FROM Categories ORDER BY CategoryName", conn);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    ddlDestinationCategory.DataSource = dt;
                    ddlDestinationCategory.DataTextField = "CategoryName";
                    ddlDestinationCategory.DataValueField = "CategoryID";
                    ddlDestinationCategory.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading categories: " + ex.Message, "alert-danger");
            }
        }

        /// <summary>
        /// Adds new category with enhanced validation
        /// </summary>
        protected void btnAddCategory_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string categoryName = txtCategoryName.Text.Trim();
                    string description = txtCategoryDescription.Text.Trim();

                    // Enhanced validation
                    if (CategoryNameExists(categoryName))
                    {
                        ShowMessage("Category name already exists! Please choose a different name.", "alert-danger");
                        return;
                    }

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = "INSERT INTO Categories (CategoryName, Description) VALUES (@Name, @Description)";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Name", categoryName);
                        cmd.Parameters.AddWithValue("@Description", description);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    ShowMessage($"🎉 Category '{categoryName}' added successfully!", "alert-success");
                    ClearCategoryForm();
                    BindCategoriesGrid();
                    LoadCategories();
                    LoadStatistics();
                }
                catch (Exception ex)
                {
                    ShowMessage("❌ Error adding category: " + ex.Message, "alert-danger");
                }
            }
        }

        /// <summary>
        /// Binds categories to GridView using DataTable for pagination support
        /// </summary>
        private void BindCategoriesGrid()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlDataAdapter adapter = new SqlDataAdapter("SELECT CategoryID, CategoryName, Description FROM Categories ORDER BY CategoryName", conn);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvCategories.DataSource = dt;
                    gvCategories.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading categories grid: " + ex.Message, "alert-danger");
            }
        }

        /// <summary>
        /// Category GridView editing events
        /// </summary>
        protected void gvCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCategories.EditIndex = e.NewEditIndex;
            BindCategoriesGrid();
        }

        protected void gvCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int categoryId = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvCategories.Rows[e.RowIndex];

                TextBox txtName = (TextBox)row.FindControl("txtEditCategoryName");
                TextBox txtDesc = (TextBox)row.FindControl("txtEditCategoryDescription");

                string newName = txtName.Text.Trim();

                // Check for duplicate names (excluding current category)
                if (CategoryNameExists(newName, categoryId))
                {
                    ShowMessage("Category name already exists! Please choose a different name.", "alert-danger");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "UPDATE Categories SET CategoryName = @Name, Description = @Description WHERE CategoryID = @ID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", newName);
                    cmd.Parameters.AddWithValue("@Description", txtDesc.Text.Trim());
                    cmd.Parameters.AddWithValue("@ID", categoryId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                gvCategories.EditIndex = -1;
                BindCategoriesGrid();
                LoadCategories(); // Refresh dropdown
                ShowMessage($"✅ Category '{newName}' updated successfully!", "alert-success");
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error updating category: " + ex.Message, "alert-danger");
            }
        }

        protected void gvCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCategories.EditIndex = -1;
            BindCategoriesGrid();
        }

        protected void gvCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int categoryId = Convert.ToInt32(gvCategories.DataKeys[e.RowIndex].Value);
                string categoryName = ""; 

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get category name for confirmation message
                    SqlCommand cmdName = new SqlCommand("SELECT CategoryName FROM Categories WHERE CategoryID = @ID", conn);
                    cmdName.Parameters.AddWithValue("@ID", categoryId);
                    categoryName = cmdName.ExecuteScalar()?.ToString(); // Assign the value

                    // remove related data first
                    SqlCommand cmd = new SqlCommand("DELETE FROM Cart WHERE DestinationID IN (SELECT DestinationID FROM Destinations WHERE CategoryID = @ID)", conn);
                    cmd.Parameters.AddWithValue("@ID", categoryId);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("DELETE FROM Bookings WHERE DestinationID IN (SELECT DestinationID FROM Destinations WHERE CategoryID = @ID)", conn);
                    cmd.Parameters.AddWithValue("@ID", categoryId);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("DELETE FROM Destinations WHERE CategoryID = @ID", conn);
                    cmd.Parameters.AddWithValue("@ID", categoryId);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("DELETE FROM Categories WHERE CategoryID = @ID", conn);
                    cmd.Parameters.AddWithValue("@ID", categoryId);
                    cmd.ExecuteNonQuery();
                }

                BindCategoriesGrid();
                LoadCategories();
                BindDestinations(); // Refresh destinations
                LoadStatistics();
                ShowMessage($"🗑️ Category '{categoryName}' and all related destinations deleted successfully!", "alert-success");
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error deleting category: " + ex.Message, "alert-danger");
            }
        }

        protected void gvCategories_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvCategories.PageIndex = e.NewPageIndex;
            BindCategoriesGrid();
        }

        #endregion

        #region Destination Management

        /// <summary>
        /// Enhanced destination addition with image upload and validation
        /// </summary>
        protected void btnAddDestination_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    string imageUrl = "Images/default-destination.jpg";

                    // Enhanced image upload with validation
                    if (fuDestinationImage.HasFile)
                    {
                        if (ValidateAndSaveImage(fuDestinationImage, out imageUrl))
                        {
                            // Image saved successfully
                        }
                        else
                        {
                            return; // Validation failed, error message already shown
                        }
                    }

                    // Enhanced data validation
                    decimal price = decimal.Parse(txtDestinationPrice.Text);
                    int seats = int.Parse(txtAvailableSeats.Text);
                    DateTime departure = DateTime.Parse(txtDepartureDate.Text);
                    DateTime? returnDate = string.IsNullOrEmpty(txtReturnDate.Text) ? null : (DateTime?)DateTime.Parse(txtReturnDate.Text);

                    if (!ValidateDateRange(departure, returnDate))
                    {
                        return; // Date validation failed
                    }

                    using (SqlConnection conn = new SqlConnection(connectionString))
                    {
                        string query = @"INSERT INTO Destinations (Destination, Description, Price, AvailableSeats, CategoryID, DepartureDate, ReturnDate, ImageURL) 
                                       VALUES (@Destination, @Description, @Price, @Seats, @CategoryID, @Departure, @Return, @ImageURL)";

                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@Destination", txtDestinationName.Text.Trim());
                        cmd.Parameters.AddWithValue("@Description", txtDestinationDescription.Text.Trim());
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Seats", seats);
                        cmd.Parameters.AddWithValue("@CategoryID", int.Parse(ddlDestinationCategory.SelectedValue));
                        cmd.Parameters.AddWithValue("@Departure", departure);
                        cmd.Parameters.AddWithValue("@Return", returnDate ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@ImageURL", imageUrl);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    ClearDestinationForm();
                    BindDestinations();
                    LoadStatistics();
                    ShowMessage($"🎉 Destination '{txtDestinationName.Text}' added successfully!", "alert-success");
                }
                catch (Exception ex)
                {
                    ShowMessage("❌ Error adding destination: " + ex.Message, "alert-danger");
                }
            }
        }

        /// <summary>
        /// Enhanced destination binding with error handling
        /// </summary>
        private void BindDestinations()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"SELECT d.DestinationID, d.Destination, d.Description, d.Price, 
                           d.AvailableSeats, d.DepartureDate, d.ReturnDate, d.ImageURL, 
                           c.CategoryName, d.CategoryID
                           FROM Destinations d 
                           INNER JOIN Categories c ON d.CategoryID = c.CategoryID 
                           ORDER BY d.Destination";

                    SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    gvDestinations.DataSource = dt;
                    gvDestinations.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading destinations: " + ex.Message, "alert-danger");
            }
        }

        /// <summary>
        /// Destination GridView events with enhanced functionality
        /// </summary>
        protected void gvDestinations_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvDestinations.EditIndex = e.NewEditIndex;
            BindDestinations();
        }

        protected void gvDestinations_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int destinationId = Convert.ToInt32(gvDestinations.DataKeys[e.RowIndex].Value);
                GridViewRow row = gvDestinations.Rows[e.RowIndex];

                TextBox txtDest = (TextBox)row.FindControl("txtEditDestination");
                TextBox txtDesc = (TextBox)row.FindControl("txtEditDescription");
                TextBox txtPrice = (TextBox)row.FindControl("txtEditPrice");
                TextBox txtSeats = (TextBox)row.FindControl("txtEditSeats");
                FileUpload fuEdit = (FileUpload)row.FindControl("fuEditImage");

                string imageUrl = GetCurrentImageUrl(destinationId);

                // Handle image update
                if (fuEdit != null && fuEdit.HasFile)
                {
                    if (!ValidateAndSaveImage(fuEdit, out imageUrl))
                    {
                        return; // Image validation failed
                    }
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Destinations SET Destination = @Destination, Description = @Description, 
                                   Price = @Price, AvailableSeats = @Seats, ImageURL = @ImageURL WHERE DestinationID = @ID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Destination", txtDest.Text.Trim());
                    cmd.Parameters.AddWithValue("@Description", txtDesc.Text.Trim());
                    cmd.Parameters.AddWithValue("@Price", decimal.Parse(txtPrice.Text));
                    cmd.Parameters.AddWithValue("@Seats", int.Parse(txtSeats.Text));
                    cmd.Parameters.AddWithValue("@ImageURL", imageUrl);
                    cmd.Parameters.AddWithValue("@ID", destinationId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                gvDestinations.EditIndex = -1;
                BindDestinations();
                ShowMessage($"✅ Destination '{txtDest.Text}' updated successfully!", "alert-success");
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error updating destination: " + ex.Message, "alert-danger");
            }
        }

        protected void gvDestinations_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvDestinations.EditIndex = -1;
            BindDestinations();
        }

        protected void gvDestinations_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int destinationId = Convert.ToInt32(gvDestinations.DataKeys[e.RowIndex].Value);
                string destName = ""; 

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // Get destination name for confirmation
                    SqlCommand cmdName = new SqlCommand("SELECT Destination FROM Destinations WHERE DestinationID = @ID", conn);
                    cmdName.Parameters.AddWithValue("@ID", destinationId);
                    destName = cmdName.ExecuteScalar()?.ToString(); 

                    // Cascade delete
                    SqlCommand cmd = new SqlCommand("DELETE FROM Cart WHERE DestinationID = @ID", conn);
                    cmd.Parameters.AddWithValue("@ID", destinationId);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("DELETE FROM Bookings WHERE DestinationID = @ID", conn);
                    cmd.Parameters.AddWithValue("@ID", destinationId);
                    cmd.ExecuteNonQuery();

                    cmd = new SqlCommand("DELETE FROM Destinations WHERE DestinationID = @ID", conn);
                    cmd.Parameters.AddWithValue("@ID", destinationId);
                    cmd.ExecuteNonQuery();
                }

                BindDestinations();
                LoadStatistics();
                ShowMessage($"🗑️ Destination '{destName}' deleted successfully!", "alert-success");
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error deleting destination: " + ex.Message, "alert-danger");
            }
        }

        protected void gvDestinations_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDestinations.PageIndex = e.NewPageIndex;
            BindDestinations();
        }

        #endregion

        #region Enhanced Utility Methods

        /// <summary>
        /// Enhanced image validation and saving with proper error handling
        /// </summary>
        private bool ValidateAndSaveImage(FileUpload fileUpload, out string imageUrl)
        {
            imageUrl = "Images/default-destination.jpg";

            try
            {
                string fileName = fileUpload.FileName;
                string extension = Path.GetExtension(fileName).ToLower();

                // Validate file type
                if (extension != ".jpg" && extension != ".jpeg" && extension != ".png" && extension != ".gif")
                {
                    ShowMessage("❌ Please upload a valid image file (JPG, JPEG, PNG, GIF)", "alert-danger");
                    return false;
                }

                // Validate file size (5MB limit)
                if (fileUpload.PostedFile.ContentLength > 5242880)
                {
                    ShowMessage("❌ Image file size must be less than 5MB", "alert-danger");
                    return false;
                }

                // Save file with unique name
                string uniqueName = Guid.NewGuid().ToString() + extension;
                string uploadPath = Server.MapPath("~/Images/");

                // Create directory if it doesn't exist
                if (!Directory.Exists(uploadPath))
                {
                    Directory.CreateDirectory(uploadPath);
                }

                string fullPath = Path.Combine(uploadPath, uniqueName);
                fileUpload.SaveAs(fullPath);
                imageUrl = "Images/" + uniqueName;

                return true;
            }
            catch (Exception ex)
            {
                ShowMessage("❌ Error saving image: " + ex.Message, "alert-danger");
                return false;
            }
        }

        /// <summary>
        /// Gets current image URL for a destination
        /// </summary>
        private string GetCurrentImageUrl(int destinationId)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    SqlCommand cmd = new SqlCommand("SELECT ImageURL FROM Destinations WHERE DestinationID = @ID", conn);
                    cmd.Parameters.AddWithValue("@ID", destinationId);
                    conn.Open();

                    object result = cmd.ExecuteScalar();
                    return result?.ToString() ?? "Images/default-destination.jpg";
                }
            }
            catch
            {
                return "Images/default-destination.jpg";
            }
        }

        /// <summary>
        /// message display 
        private void ShowMessage(string message, string cssClass)
        {
            lblMessage.Text = message;
            lblMessage.CssClass = "alert-admin " + cssClass;
            pnlMessage.Visible = true;
        }

        /// <summary>
        /// Validates date ranges for travel bookings
        /// </summary>
        private bool ValidateDateRange(DateTime departureDate, DateTime? returnDate)
        {
            if (departureDate < DateTime.Today)
            {
                ShowMessage("❌ Departure date must be in the future", "alert-danger");
                return false;
            }

            if (returnDate.HasValue && returnDate.Value <= departureDate)
            {
                ShowMessage("❌ Return date must be after departure date", "alert-danger");
                return false;
            }

            return true;
        }

        /// <summary>
        /// Checks if category name already exists
        /// </summary>
        private bool CategoryNameExists(string categoryName, int excludeId = 0)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM Categories WHERE LOWER(CategoryName) = LOWER(@Name) AND CategoryID != @ExcludeId";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Name", categoryName);
                    cmd.Parameters.AddWithValue("@ExcludeId", excludeId);
                    conn.Open();
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
            catch
            {
                return false;
            }
        }

        /// <summary>
        /// Clears form fields after successful operations
        /// </summary>
        private void ClearCategoryForm()
        {
            txtCategoryName.Text = "";
            txtCategoryDescription.Text = "";
        }

        private void ClearDestinationForm()
        {
            txtDestinationName.Text = "";
            txtDestinationDescription.Text = "";
            txtDestinationPrice.Text = "";
            txtAvailableSeats.Text = "";
            txtDepartureDate.Text = "";
            txtReturnDate.Text = "";
            ddlDestinationCategory.SelectedIndex = 0;
        }

        #endregion
    }
}