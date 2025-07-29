<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Default" MasterPageFile="~/Site1.Master" %>

<%@ MasterType VirtualPath="~/Site1.Master" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">


    <div>
        <section class="hero">

            <div class="hero-content">
                <h1 class="hero-title">Discover the world, one trip at a time</h1>
                <asp:Button ID="btnHeroBook" runat="server" Text="Book Now" CssClass="hero-btn" />

            </div>

        </section>
        <section class="destinations">
        <div class="section-header">
            <h2>Popular Destinations You'll Love</h2>
            <p>Explore our hand-picked destinations trending this season with the best deals and unforgettable experiences.</p>
        </div>

        <div class="destinations-grid">
            <!-- Paris Card -->
            <div class="destination-card">
                <div class="card-image" style="background-image: url('<%= ResolveUrl("~/Images/paris.jpg") %>');">
                    <div class="price-tag">Romantic city vibes From $1199</div>
                </div>
                <div class="card-content">
                    <h3>Paris, France</h3>
                    <p>Experience the city of love with its iconic landmarks, world-class cuisine, and romantic atmosphere.</p>
                </div>
            </div>

            <!-- Bali Card -->
            <div class="destination-card">
                <div class="card-image" style="background-image: url('<%= ResolveUrl("~/Images/bali.jpg") %>');"
>
                    <div class="price-tag">Tropical island escape From $1350</div>
                </div>
                <div class="card-content">
                    <h3>Bali, Indonesia</h3>
                    <p>Discover pristine beaches, ancient temples, and vibrant culture in this tropical paradise.</p>
                </div>
            </div>

            <!-- Dubai Card -->
            <div class="destination-card">
                <div class="card-image" style="background-image: url('<%= ResolveUrl("~/Images/dubai.jpg") %>');"
>
                    <div class="price-tag">Luxury urban oasis From $1499</div>
                </div>
                <div class="card-content">
                    <h3>Dubai, UAE</h3>
                    <p>Experience luxury shopping, ultramodern architecture, and world-class entertainment.</p>
                </div>
            </div>

            <!-- Singapore Card -->
            <div class="destination-card">
                <div class="card-image" style="background-image: url('<%= ResolveUrl("~/Images/singapore.jpg") %>');"
>
                    <div class="price-tag">Modern city paradise From $1410</div>
                </div>
                <div class="card-content">
                    <h3>Singapore</h3>
                    <p>A modern metropolis blending diverse cultures, innovative architecture, and incredible cuisine.</p>
                </div>
            </div>
             <div class="destination-card">
     <div class="card-image" style="background-image: url('<%= ResolveUrl("~/Images/singapore.jpg") %>');">
         <div class="price-tag">Modern city paradise From $1410</div>
     </div>
     <div class="card-content">
         <h3>Singapore</h3>
         <p>A modern metropolis blending diverse cultures, innovative architecture, and incredible cuisine.</p>
     </div>
 </div>
        </div>
    </section>
    </div>
</asp:Content>
