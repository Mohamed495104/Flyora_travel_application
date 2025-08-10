<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingSuccess.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.BookingSuccess" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="destinations py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-success fw-bold">🎉 Booking Confirmed!</h2>
                <p class="lead text-muted">Thank you for booking with Flyora! Your travel plan is now ready.</p>
            </div>

            <asp:Panel ID="pnlBooking" runat="server" CssClass="card shadow-lg p-4 border-0">
                <h4 class="mb-3 text-primary">Booking Summary</h4>
                <dl class="row">
                    <dt class="col-sm-4">Booking ID:</dt>
                    <dd class="col-sm-8"><asp:Label ID="lblBookingID" runat="server" CssClass="fw-bold" /></dd>

                    <dt class="col-sm-4">Destination:</dt>
                    <dd class="col-sm-8"><asp:Label ID="lblDestination" runat="server" /></dd>

                    <dt class="col-sm-4">Travelers:</dt>
                    <dd class="col-sm-8"><asp:Label ID="lblTravelers" runat="server" /></dd>

                    <dt class="col-sm-4">Total Amount:</dt>
                    <dd class="col-sm-8"><asp:Label ID="lblAmount" runat="server" /></dd>

                    <dt class="col-sm-4">Payment Option:</dt>
                    <dd class="col-sm-8"><asp:Label ID="lblPayment" runat="server" /></dd>

                    <dt class="col-sm-4">Address:</dt>
                    <dd class="col-sm-8"><asp:Label ID="lblAddress" runat="server" /></dd>

                    <dt class="col-sm-4">Booking Date:</dt>
                    <dd class="col-sm-8"><asp:Label ID="lblDate" runat="server" /></dd>

                    <dt class="col-sm-4">Status:</dt>
                   <dd class="col-sm-8"><asp:Label ID="lblStatus" runat="server" CssClass="badge bg-success" /></dd>

                </dl>

                <div class="text-end mt-4">
                    <a href="~/Default.aspx" class="btn btn-outline-primary">Return to Home</a>
                </div>
            </asp:Panel>

            <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block mt-4" Visible="false" />
        </div>
    </section>
</asp:Content>
