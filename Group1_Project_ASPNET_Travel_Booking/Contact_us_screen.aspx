<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact_us_screen.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Contact_us_screen" MasterPageFile="~/Site1.Master" %>



<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="contact-section py-5">
        <section class="hero-about">

            <div class="hero-content">
                <h1 class="hero-title">Contact our friendly team</h1>
                <h2 >Explore the world together with us</h2>


            </div>
        </section>
        <div class="container">
            <div class="row">
            
                <div class="col-md-4 mb-4">
                    <h3 class="text-primary">Get in Touch</h3>
                    <p class="text-muted">We’d love to hear from you! Reach out to us for any inquiries or support.</p>
                    <ul class="list-unstyled">
                        <li class="mb-3"><i class="fas fa-map-marker-alt"></i>123 Travel Lane, Toronto, ON</li>
                        <li class="mb-3"><i class="fas fa-phone"></i>+1 (416) 555-1234</li>
                        <li class="mb-3"><i class="fas fa-envelope"></i>support@flyora.com</li>
                        <li><i class="fas fa-clock"></i>Mon-Fri: 9 AM - 6 PM EDT</li>
                    </ul>
                </div>

              
                <div class="col-md-8">
                    <h3 class="text-primary">Send Us a Message</h3>
                    <div class="card p-4 shadow-sm">
                        <form id="contactForm" class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <asp:Label ID="lblName" runat="server" Text="Name" AssociatedControlID="txtName"></asp:Label>
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Your Name" required></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required" CssClass="text-danger" />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <asp:Label ID="lblEmail" runat="server" Text="Email" AssociatedControlID="txtEmail"></asp:Label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Your Email" TextMode="Email" required></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" CssClass="text-danger" />
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="text-danger" />
                                </div>
                            </div>
                            <div class="mb-3">
                                <asp:Label ID="lblSubject" runat="server" Text="Subject" AssociatedControlID="txtSubject"></asp:Label>
                                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Subject" required></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ControlToValidate="txtSubject" ErrorMessage="Subject is required" CssClass="text-danger" />
                            </div>
                            <div class="mb-3">
                                <asp:Label ID="lblMessage" runat="server" Text="Message" AssociatedControlID="txtMessage"></asp:Label>
                                <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" placeholder="Your Message" required></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ControlToValidate="txtMessage" ErrorMessage="Message is required" CssClass="text-danger" />
                            </div>
                            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary" />
                        </form>
                    </div>
                </div>
            </div>

           
            <div class="row mt-5">
                <div class="col-12">
                    <h3 class="text-primary">Our Location</h3>
                    <div class="map-placeholder" style="height: 300px; border-radius: 10px; text-align: center; padding-top: 120px; padding-bottom:50px; margin-bottom:100px">
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
