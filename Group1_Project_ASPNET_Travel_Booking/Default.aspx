<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Default" MasterPageFile="~/Site1.Master" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <section class="hero">
            <div class="hero-content">
               
                <asp:Panel ID="pnlLoggedInHero" runat="server" Visible="false">
                    <h1 class="hero-title">Welcome back,
                        <asp:Label ID="lblHeroUsername" runat="server"></asp:Label>!</h1>
                    <p class="hero-subtitle">Ready for your next adventure?</p>
                </asp:Panel>

               
                <asp:Panel ID="pnlNotLoggedInHero" runat="server" Visible="true">
                    <h1 class="hero-title">Discover the world, one trip at a time</h1>
                    <p class="hero-subtitle">Join thousands of travelers exploring amazing destinations</p>
                </asp:Panel>

                <asp:Button ID="btnHeroBook" runat="server" Text="Book Now" CssClass="hero-btn" OnClick="btnHeroBook_Click" />
            </div>
        </section>

        <section class="destinations">
            <div class="section-header">
                <h2>Popular Destinations You'll Love</h2>
                <p>Explore our hand-picked destinations trending this season with the best deals and unforgettable experiences.</p>
            </div>

            <asp:SqlDataSource ID="SqlDataSourceDestinations" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
                SelectCommand="SELECT TOP 6 DestinationID, Destination, Description, Price, AvailableSeats, CategoryID, DepartureDate, ReturnDate, ImageURL FROM Destinations"></asp:SqlDataSource>

            <asp:ListView ID="lvDestinations" runat="server" DataSourceID="SqlDataSourceDestinations"
                DataKeyNames="DestinationID" OnItemCommand="lvDestinations_ItemCommand">
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
                            <h3><%# Eval("Destination") %></h3>
                            <p><%# Eval("Description") %></p>
                            <asp:Button ID="btnBookDestination" runat="server" Text='<%# "Book " + Eval("Destination") %>'
                                CssClass="btn btn-primary mt-2" CommandName="Book" CommandArgument='<%# Eval("Destination") %>' />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
        </section>
    </div>
</asp:Content>
