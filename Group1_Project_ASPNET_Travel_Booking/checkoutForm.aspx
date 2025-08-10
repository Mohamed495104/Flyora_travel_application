<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkoutForm.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.checkoutForm" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="destinations">
        <div class="section-header text-center mb-5">
            <h2 class="display-4 fw-bold text-dark mb-3">Confirm & Book</h2>
            <p class="lead text-muted">Review your booking and provide traveler information to proceed.</p>
        </div>

        <div class="container">
            <!-- Booking Summary -->
            <asp:Panel ID="pnlSummary" runat="server" CssClass="mb-5">
                <h4 class="text-primary mb-3">Your Selected Destinations</h4>
                <asp:Repeater ID="rptSummary" runat="server">
                    <ItemTemplate>
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5 class="card-title text-dark"><%# Eval("Destination") %></h5>
                                <p class="card-text">
                                    Travel Dates: <%# Eval("DepartureDate", "{0:yyyy-MM-dd}") %> to <%# Eval("ReturnDate", "{0:yyyy-MM-dd}") %><br />
                                    Travelers: <%# Eval("Travelers") %><br />
                                    <strong>Total Price:</strong> <%# Eval("TotalPrice", "{0:C}") %>
                                </p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </asp:Panel>

            <!-- Traveler Info -->
            <asp:Panel ID="pnlForm" runat="server" CssClass="form-section">
                <h4 class="mb-4 text-primary">Traveler & Payment Details</h4>
                <div class="form-grid">

                    <div class="form-group">
                        <label for="txtFullName">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="txtFullName" runat="server" CssClass="validation-error" ErrorMessage="Please enter your full name" />
                    </div>

                    <div class="form-group">
                        <label for="txtEmail">Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" />
                        <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" runat="server" CssClass="validation-error" ErrorMessage="Email is required" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" CssClass="validation-error"
                            ErrorMessage="Invalid email format" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" />
                    </div>

                    <div class="form-group">
                        <label for="txtPhone">Phone</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" TextMode="Phone" />
                        <asp:RequiredFieldValidator ID="rfvPhone" ControlToValidate="txtPhone" runat="server" CssClass="validation-error" ErrorMessage="Phone number is required" />
                    </div>

                    <div class="form-group">
                        <label for="txtAddress">Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                        <asp:RequiredFieldValidator ID="rfvAddress" ControlToValidate="txtAddress" runat="server" CssClass="validation-error" ErrorMessage="Address is required" />
                    </div>

                    <div class="form-group">
                        <label for="ddlPayment">Payment Option</label>
                        <asp:DropDownList ID="ddlPayment" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Cash on Arrival" Value="Cash on Arrival" />
                            <asp:ListItem Text="Credit Card" Value="Credit Card" />
                        </asp:DropDownList>
                    </div>

                    <div class="form-group d-flex align-items-center gap-2 mt-2">
                        <asp:CheckBox ID="chkTerms" runat="server" />
                        <label for="chkTerms" class="mb-0">I accept the <a href="#">terms and conditions</a></label>
                        <asp:CustomValidator ID="cvTerms" runat="server"
                            ErrorMessage="You must accept the terms"
                            CssClass="validation-error"
                            ClientValidationFunction="validateTerms"
                            Display="Dynamic" />
                    </div>
                </div>

                <!-- Submit Button -->
                <asp:Button ID="btnBook" runat="server" Text="Confirm Booking" CssClass="btn btn-primary mt-4 px-4 py-2" OnClick="btnBook_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-danger d-block mt-3" Visible="false"></asp:Label>
            </asp:Panel>
        </div>
    </section>

    <script type="text/javascript">
        function validateTerms(source, args) {
            args.IsValid = document.getElementById('<%= chkTerms.ClientID %>').checked;
        }
    </script>
</asp:Content>
