<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Admin" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- No inline styles needed - everything is in Site.css -->
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="admin-hero">
        <div class="container">
            <h1>🚀 Travel Admin Portal</h1>
            <p>Manage destinations, categories, and bookings for Flyora Travel</p>
        </div>
    </section>

    <!-- Main Admin Container -->
    <div class="admin-container">
        <!-- Statistics Dashboard -->
        <div class="stats-grid">
            <div class="stats-card">
                <div class="stats-number">
                    <asp:Label ID="lblTotalDestinations" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stats-label">Total Destinations</div>
            </div>
            <div class="stats-card">
                <div class="stats-number">
                    <asp:Label ID="lblTotalCategories" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stats-label">Categories</div>
            </div>
            <div class="stats-card">
                <div class="stats-number">
                    <asp:Label ID="lblTotalBookings" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stats-label">Total Bookings</div>
            </div>
            <div class="stats-card">
                <div class="stats-number">
                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                </div>
                <div class="stats-label">Registered Users</div>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <asp:Panel ID="pnlMessage" runat="server" Visible="false">
            <asp:Label ID="lblMessage" runat="server" CssClass="alert-admin"></asp:Label>
        </asp:Panel>

        <!-- Admin Tabs -->
        <div class="admin-tabs">
            <div class="tab-navigation">
                <div class="tab-buttons">
                    <asp:LinkButton ID="lnkDestinationsTab" runat="server" CssClass="tab-btn active" 
                        OnClick="lnkTab_Click" CommandArgument="Destinations" CausesValidation="false">
                        🗺️ Destinations
                    </asp:LinkButton>
                    <asp:LinkButton ID="lnkCategoriesTab" runat="server" CssClass="tab-btn" 
                        OnClick="lnkTab_Click" CommandArgument="Categories" CausesValidation="false">
                        🏷️ Categories
                    </asp:LinkButton>
                </div>
            </div>

            <!-- Destinations Tab -->
            <asp:Panel ID="pnlDestinations" runat="server" CssClass="tab-content" Visible="true">
                <!-- Add New Destination Form -->
                <div class="form-section">
                    <h4>✨ Add New Destination</h4>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Destination Name</label>
                            <asp:TextBox ID="txtDestinationName" runat="server" CssClass="form-control" placeholder="Enter destination name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDestinationName" runat="server" 
                                ControlToValidate="txtDestinationName" 
                                ErrorMessage="Destination name is required" 
                                CssClass="validation-error" 
                                ValidationGroup="DestinationGroup" />
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <asp:TextBox ID="txtDestinationDescription" runat="server" CssClass="form-control" 
                                TextMode="MultiLine" Rows="3" placeholder="Enter destination description"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDestinationDescription" runat="server" 
                                ControlToValidate="txtDestinationDescription" 
                                ErrorMessage="Description is required" 
                                CssClass="validation-error" 
                                ValidationGroup="DestinationGroup" />
                        </div>

           <div class="form-group">
    <label>Category</label>
    <div class="custom-dropdown-wrapper">
        <asp:DropDownList ID="ddlDestinationCategory" runat="server" 
            CssClass="form-control dropdown-override">
        </asp:DropDownList>
    </div>
</div>

                        <div class="form-group">
                            <label>Price ($)</label>
                            <asp:TextBox ID="txtDestinationPrice" runat="server" CssClass="form-control" 
                                placeholder="0.00" TextMode="Number" step="0.01"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDestinationPrice" runat="server" 
                                ControlToValidate="txtDestinationPrice" 
                                ErrorMessage="Price is required" 
                                CssClass="validation-error" 
                                ValidationGroup="DestinationGroup" />
                        </div>
                        <div class="form-group">
                            <label>Available Seats</label>
                            <asp:TextBox ID="txtAvailableSeats" runat="server" CssClass="form-control" 
                                placeholder="0" TextMode="Number"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAvailableSeats" runat="server" 
                                ControlToValidate="txtAvailableSeats" 
                                ErrorMessage="Available seats is required" 
                                CssClass="validation-error" 
                                ValidationGroup="DestinationGroup" />
                        </div>
                        <div class="form-group">
                            <label>Departure Date</label>
                            <asp:TextBox ID="txtDepartureDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDepartureDate" runat="server" 
                                ControlToValidate="txtDepartureDate" 
                                ErrorMessage="Departure date is required" 
                                CssClass="validation-error" 
                                ValidationGroup="DestinationGroup" />
                        </div>
                        <div class="form-group">
                            <label>Return Date</label>
                            <asp:TextBox ID="txtReturnDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Image Upload</label>
                            <div class="file-upload-wrapper">
                                <asp:FileUpload ID="fuDestinationImage" runat="server" CssClass="file-upload-input" />
                                <label for="<%= fuDestinationImage.ClientID %>" class="file-upload-label">
                                    📷 Choose Image File
                                </label>
                            </div>
                        </div>
                    </div>
                    <div style="text-align: center;">
                        <asp:Button ID="btnAddDestination" runat="server" Text="✈️ Add Destination" 
                            CssClass="btn-admin-primary" ValidationGroup="DestinationGroup" 
                            OnClick="btnAddDestination_Click" />
                    </div>
                </div>

                <!-- Destinations GridView -->
                <div class="gridview-container">
                    <div class="gridview-header">
                        <h4>🎯 Manage Destinations</h4>
                    </div>
                    <div style="overflow-x: auto;">
                        <asp:GridView ID="gvDestinations" runat="server" 
                            CssClass="table"
                            AutoGenerateColumns="False" 
                            DataKeyNames="DestinationID"
                            OnRowEditing="gvDestinations_RowEditing"
                            OnRowUpdating="gvDestinations_RowUpdating"
                            OnRowCancelingEdit="gvDestinations_RowCancelingEdit"
                            OnRowDeleting="gvDestinations_RowDeleting"
                            AllowPaging="True" PageSize="8"
                            OnPageIndexChanging="gvDestinations_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="DestinationID" HeaderText="ID" ReadOnly="True" ItemStyle-Width="60px" />
                                <asp:TemplateField HeaderText="Image" ItemStyle-Width="100px">
                                    <ItemTemplate>
                                        <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Destination") %>' class="image-preview" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Destination") %>' class="image-preview" />
                                        <asp:FileUpload ID="fuEditImage" runat="server" CssClass="form-control mt-2" style="font-size: 0.8rem;" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Destination">
                                    <ItemTemplate>
                                        <strong><%# Eval("Destination") %></strong>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEditDestination" runat="server" Text='<%# Bind("Destination") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <%# Eval("Description").ToString().Length > 50 ? Eval("Description").ToString().Substring(0, 50) + "..." : Eval("Description") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEditDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" TextMode="MultiLine" Rows="2" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Price">
                                    <ItemTemplate>
                                        <span style="color: #28a745; font-weight: 600;"><%# Eval("Price", "{0:C}") %></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEditPrice" runat="server" Text='<%# Bind("Price") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Seats">
                                    <ItemTemplate>
                                        <span style="color: #007bff; font-weight: 600;"><%# Eval("AvailableSeats") %></span>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEditSeats" runat="server" Text='<%# Bind("AvailableSeats") %>' CssClass="form-control" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions" ItemStyle-Width="160px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit" Text="✏️ Edit" CssClass="btn-grid btn-edit" />
                                        <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" Text="🗑️ Delete" CssClass="btn-grid btn-delete" 
                                            OnClientClick="return confirm('Are you sure you want to delete this destination?');" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update" Text="💾 Update" CssClass="btn-grid btn-update" />
                                        <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel" Text="❌ Cancel" CssClass="btn-grid btn-delete" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>

            <!-- Categories Tab -->
            <asp:Panel ID="pnlCategories" runat="server" CssClass="tab-content" Visible="false">
                <!-- Add New Category Form -->
                <div class="form-section">
                    <h4>✨ Add New Category</h4>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Category Name</label>
                            <asp:TextBox ID="txtCategoryName" runat="server" CssClass="form-control" placeholder="Enter category name"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" 
                                ControlToValidate="txtCategoryName" 
                                ErrorMessage="Category name is required" 
                                CssClass="validation-error" 
                                ValidationGroup="CategoryGroup" />
                        </div>
                        <div class="form-group">
                            <label>Description</label>
                            <asp:TextBox ID="txtCategoryDescription" runat="server" CssClass="form-control" 
                                TextMode="MultiLine" Rows="3" placeholder="Enter category description"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCategoryDescription" runat="server" 
                                ControlToValidate="txtCategoryDescription" 
                                ErrorMessage="Description is required" 
                                CssClass="validation-error" 
                                ValidationGroup="CategoryGroup" />
                        </div>
                    </div>
                    <div style="text-align: center;">
                        <asp:Button ID="btnAddCategory" runat="server" Text="🏷️ Add Category" 
                            CssClass="btn-admin-primary" ValidationGroup="CategoryGroup" 
                            OnClick="btnAddCategory_Click" />
                    </div>
                </div>

                <!-- Categories GridView -->
                <div class="gridview-container">
                    <div class="gridview-header">
                        <h4>🎯 Manage Categories</h4>
                    </div>
                    <div style="overflow-x: auto;">
                        <asp:GridView ID="gvCategories" runat="server" 
                            CssClass="table"
                            AutoGenerateColumns="False" 
                            DataKeyNames="CategoryID"
                            OnRowEditing="gvCategories_RowEditing"
                            OnRowUpdating="gvCategories_RowUpdating"
                            OnRowCancelingEdit="gvCategories_RowCancelingEdit"
                            OnRowDeleting="gvCategories_RowDeleting"
                            AllowPaging="True" PageSize="10"
                            OnPageIndexChanging="gvCategories_PageIndexChanging">
                            <Columns>
                                <asp:BoundField DataField="CategoryID" HeaderText="ID" ReadOnly="True" ItemStyle-Width="80px" />
                                <asp:TemplateField HeaderText="Category Name">
                                    <ItemTemplate>
                                        <strong style="color: #2c5aa0;"><%# Eval("CategoryName") %></strong>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEditCategoryName" runat="server" Text='<%# Bind("CategoryName") %>' CssClass="form-control" />
                                        <asp:RequiredFieldValidator ID="rfvEditCategoryName" runat="server" 
                                            ControlToValidate="txtEditCategoryName" 
                                            ErrorMessage="Category name is required" 
                                            CssClass="validation-error" 
                                            ValidationGroup="EditCategoryGroup" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Description">
                                    <ItemTemplate>
                                        <%# Eval("Description") %>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtEditCategoryDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control" TextMode="MultiLine" Rows="3" />
                                        <asp:RequiredFieldValidator ID="rfvEditCategoryDescription" runat="server" 
                                            ControlToValidate="txtEditCategoryDescription" 
                                            ErrorMessage="Description is required" 
                                            CssClass="validation-error" 
                                            ValidationGroup="EditCategoryGroup" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Actions" ItemStyle-Width="160px">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnEditCategory" runat="server" CommandName="Edit" Text="✏️ Edit" CssClass="btn-grid btn-edit" />
                                        <asp:LinkButton ID="btnDeleteCategory" runat="server" CommandName="Delete" Text="🗑️ Delete" CssClass="btn-grid btn-delete" 
                                            OnClientClick="return confirm('Are you sure you want to delete this category? This will also delete all destinations in this category.');" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:LinkButton ID="btnUpdateCategory" runat="server" CommandName="Update" Text="💾 Update" CssClass="btn-grid btn-update" ValidationGroup="EditCategoryGroup" />
                                        <asp:LinkButton ID="btnCancelCategory" runat="server" CommandName="Cancel" Text="❌ Cancel" CssClass="btn-grid btn-delete" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>

    <script>
        // File upload label update with animation
        document.addEventListener('DOMContentLoaded', function () {
            const fileInputs = document.querySelectorAll('.file-upload-input');
            fileInputs.forEach(function (input) {
                input.addEventListener('change', function () {
                    const label = this.nextElementSibling;
                    const fileName = this.files[0] ? this.files[0].name : '📷 Choose Image File';
                    label.innerHTML = fileName;
                    label.style.background = 'linear-gradient(45deg, #a8e6cf, #dcedc1)'; 
                    setTimeout(() => {
                        label.style.background = 'linear-gradient(45deg, #f8f9fa, #dee2e6)'; 
                    }, 2000);
                });
            });
        });

        // Auto-hide alerts after 5 seconds with fade effect
        setTimeout(function () {
            const alerts = document.querySelectorAll('.alert-admin');
            alerts.forEach(function (alert) {
                alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                alert.style.opacity = '0';
                alert.style.transform = 'translateY(-20px)';
                setTimeout(function () {
                    alert.style.display = 'none';
                }, 500);
            });
        }, 5000);

        // Add smooth animations to stats cards
        function animateStats() {
            const statsNumbers = document.querySelectorAll('.stats-number');
            statsNumbers.forEach(function (stat) {
                const finalValue = parseInt(stat.textContent);
                let currentValue = 0;
                const increment = finalValue / 50;
                const timer = setInterval(() => {
                    currentValue += increment;
                    if (currentValue >= finalValue) {
                        stat.textContent = finalValue;
                        clearInterval(timer);
                    } else {
                        stat.textContent = Math.floor(currentValue);
                    }
                }, 30);
            });
        }

        // Run animation on page load
        window.addEventListener('load', animateStats);
    </script>
</asp:Content>