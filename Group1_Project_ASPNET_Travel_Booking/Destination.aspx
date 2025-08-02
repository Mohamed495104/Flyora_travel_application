<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Destination.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Destination" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="destinations">
        <div class="section-header">
            <h2>All Destinations</h2>
            <p>Explore our hand-picked destinations trending this season with the best deals and unforgettable experiences.</p>
        </div>

        <asp:SqlDataSource ID="SqlDataSourceCategories" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT CategoryID, CategoryName, Description FROM Categories ORDER BY CategoryName">
        </asp:SqlDataSource>

        <asp:Repeater ID="rptCategories" runat="server" DataSourceID="SqlDataSourceCategories">
            <ItemTemplate>
                <div class="category-section">
                    <h3><%# Eval("CategoryName") %></h3>
                    <p><%# Eval("Description") %></p>
                    <!-- Hidden field to store CategoryID for use in ControlParameter -->
                    <asp:HiddenField ID="hfCategoryID" runat="server" Value='<%# Eval("CategoryID") %>' />

                    <asp:SqlDataSource ID="SqlDataSourceDestinations" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                        SelectCommand="SELECT DestinationID, Destination, Description, Price, AvailableSeats, CategoryID, DepartureDate, ReturnDate, ImageURL 
                            FROM Destinations WHERE CategoryID = @CategoryID">
                        <SelectParameters>
                            <asp:ControlParameter Name="CategoryID" Type="Int32" ControlID="hfCategoryID" PropertyName="Value" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                    <asp:ListView ID="lvDestinations" runat="server" 
                        DataSourceID="SqlDataSourceDestinations"
                        DataKeyNames="DestinationID" 
                        OnItemCommand="lvDestinations_ItemCommand">
                        <LayoutTemplate>
                            <div class="destinations-grid">
                                <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="destination-card">
                                <div class="card-image" style="background-image: url('<%# ResolveUrl(Eval("ImageURL").ToString()) %>');">
                                    <div class="price-tag"><%# Eval("Price", "From {0:C}") %></div>
                                </div>
                                <div class="card-content">
                                    <h4><%# Eval("Destination") %></h4>
                                    <p><%# Eval("Description") %></p>
                                    <asp:Button ID="btnViewDestination" runat="server" 
                                        Text="View Details"
                                        CssClass="btn btn-primary mt-2" 
                                        CommandName="Book" 
                                        CommandArgument='<%# Eval("DestinationID") %>' />
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </section>
</asp:Content>