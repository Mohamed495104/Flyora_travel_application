<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DestinationDetail.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.DestinationDetail" MasterPageFile="~/Site1.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="destinations">
        <div class="section-header text-center mb-5">
            <h2 class="display-4 fw-bold text-dark mb-3">Destination Details</h2>
            <p class="lead text-muted">Complete information about your selected destination with pricing and availability.</p>
        </div>
        <div class="container">
            <asp:DetailsView ID="dvDestination" runat="server" 
                DataSourceID="SqlDataSourceDestination" 
                DataKeyNames="DestinationID"
                CssClass="table table-striped table-bordered"
                AutoGenerateRows="False"
                DefaultMode="Edit">
                <Fields>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Destination") %>' class="img-fluid rounded mb-3" style="width: 100%; height: 400px; object-fit: cover;" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' alt='<%# Eval("Destination") %>' class="img-fluid rounded mb-3" style="width: 100%; height: 400px; object-fit: cover;" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Destination" HeaderText="Destination" ReadOnly="true" />
                    <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="true" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" ReadOnly="true" />
                    <asp:BoundField DataField="AvailableSeats" HeaderText="Available Seats" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Departure Date">
                        <ItemTemplate>
                            <%# Eval("DepartureDate", "{0:d}") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDepartureDate" runat="server" 
                                Text='<%# Bind("DepartureDate", "{0:yyyy-MM-dd}") %>' 
                                TextMode="Date" 
                                CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvDepartureDate" runat="server" 
                                ControlToValidate="txtDepartureDate" 
                                ErrorMessage="Departure date is required" 
                                CssClass="text-danger small d-block" 
                                ValidationGroup="CartValidation" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Return Date">
                        <ItemTemplate>
                            <%# Eval("ReturnDate", "{0:d}") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtReturnDate" runat="server" 
                                Text='<%# Bind("ReturnDate", "{0:yyyy-MM-dd}") %>' 
                                TextMode="Date" 
                                CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvReturnDate" runat="server" 
                                ControlToValidate="txtReturnDate" 
                                ErrorMessage="Return date is required" 
                                CssClass="text-danger small d-block" 
                                ValidationGroup="CartValidation" />
                            <asp:CompareValidator ID="cvReturnDate" runat="server" 
                                ControlToValidate="txtReturnDate" 
                                ControlToCompare="txtDepartureDate" 
                                Operator="GreaterThan" 
                                Type="Date" 
                                ErrorMessage="Return date must be after departure date" 
                                CssClass="text-danger small d-block" 
                                ValidationGroup="CartValidation" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Number of Travelers">
                        <ItemTemplate>
                            1
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlTravelers" runat="server" CssClass="form-select">
                                <asp:ListItem Value="1" Selected="True">1 Traveler</asp:ListItem>
                                <asp:ListItem Value="2">2 Travelers</asp:ListItem>
                                <asp:ListItem Value="3">3 Travelers</asp:ListItem>
                                <asp:ListItem Value="4">4 Travelers</asp:ListItem>
                                <asp:ListItem Value="5">5 Travelers</asp:ListItem>
                                <asp:ListItem Value="6">6+ Travelers</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class="text-center mt-4">
                                <asp:Button ID="btnBook" runat="server" Text="Book Now" CssClass="btn btn-primary me-3" PostBackUrl="~/Booking/BookingForm.aspx" />
                                <asp:Button ID="btnBack" runat="server" Text="Back to Destinations" CssClass="btn btn-secondary" PostBackUrl="~/Travel/Destination" />
                            </div>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <div class="text-center mt-4">
                                <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-success me-2" 
                                    CommandName="AddToCart" ValidationGroup="CartValidation" />
                                <asp:Button ID="btnUpdate" runat="server" Text="Update & Book Now" CssClass="btn btn-primary me-2" 
                                    CommandName="Update" ValidationGroup="CartValidation" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary me-2" 
                                    CommandName="Cancel" CausesValidation="false" />
                                <asp:Button ID="btnBack" runat="server" Text="Back to Destinations" CssClass="btn btn-outline-secondary" 
                                    PostBackUrl="~/Travel/Destination" CausesValidation="false" />
                            </div>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <EmptyDataTemplate>
                    <div class="text-center">
                        <p>Destination not found.</p>
                        <asp:Button ID="btnBack" runat="server" Text="Back to Destinations" CssClass="btn btn-secondary" PostBackUrl="~/Travel/Destination" />
                    </div>
                </EmptyDataTemplate>
            </asp:DetailsView>
            
            <!-- Success/Error Messages -->
            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-info d-block mt-3" Visible="false"></asp:Label>

            <asp:SqlDataSource ID="SqlDataSourceDestination" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT DestinationID, Destination, Description, Price, AvailableSeats, CategoryID, DepartureDate, ReturnDate, ImageURL FROM Destinations WHERE DestinationID = @DestinationID"
                UpdateCommand="UPDATE Destinations SET DepartureDate = @DepartureDate, ReturnDate = @ReturnDate WHERE DestinationID = @DestinationID">
                <SelectParameters>
                    <asp:QueryStringParameter Name="DestinationID" QueryStringField="DestinationID" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DestinationID" Type="Int32" />
                    <asp:Parameter Name="DepartureDate" Type="DateTime" />
                    <asp:Parameter Name="ReturnDate" Type="DateTime" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
    </section>
</asp:Content>