<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Login" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <section class="hero-login">
        <div class="hero-content">
            <h1 class="hero-title">Login/Register</h1>
            <h2>Start your journey with us</h2>
        </div>
    </section>
    <section class="login-section">
        <div class="container">
            <div class="form-card">
                <ul class="nav nav-tabs justify-content-center mb-4" role="tablist">
                    <li class="nav-item">
                        <asp:LinkButton ID="lnkLoginTab" runat="server" CssClass="nav-link active" OnClick="lnkTab_Click" CommandArgument="Login" CausesValidation="false">Login</asp:LinkButton>
                    </li>
                    <li class="nav-item">
                        <asp:LinkButton ID="lnkRegisterTab" runat="server" CssClass="nav-link" OnClick="lnkTab_Click" CommandArgument="Register" CausesValidation="false">Register</asp:LinkButton>
                    </li>
                </ul>

                <!-- Login Tab -->
                <asp:Panel ID="pnlLogin" runat="server" CssClass="tab-content active">
                    <h3 class="text-center text-primary mb-4">Welcome Back</h3>
                    <form id="loginForm" defaultbutton="btnLogin">
                        <div class="form-group mb-3">
                            <asp:Label ID="lblLoginEmail" runat="server" Text="Email" AssociatedControlID="txtLoginEmail"></asp:Label>
                            <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="form-control" placeholder="Enter Email" TextMode="Email" required></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLoginEmail" runat="server" ControlToValidate="txtLoginEmail" ErrorMessage="Email is required" CssClass="error-message" ValidationGroup="LoginGroup" />
                        </div>
                        <div class="form-group mb-3">
                            <asp:Label ID="lblLoginPassword" runat="server" Text="Password" AssociatedControlID="txtLoginPassword"></asp:Label>
                            <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password" required></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLoginPassword" runat="server" ControlToValidate="txtLoginPassword" ErrorMessage="Password is required" CssClass="error-message" ValidationGroup="LoginGroup" />
                        </div>

                        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary w-100" ValidationGroup="LoginGroup" />
                        <asp:Label ID="lblLoginError" runat="server" CssClass="error-message text-center d-block mt-2" Visible="false"></asp:Label>
                    </form>
                    <p class="text-center mt-3">
                        <asp:LinkButton ID="lnkSwitchToRegister" runat="server" CssClass="text-primary" OnClick="lnkSwitchToRegister_Click" CausesValidation="false">Need an account? Register here</asp:LinkButton>
                    </p>
                </asp:Panel>

                <!-- Register Tab -->
                <asp:Panel ID="pnlRegister" runat="server" CssClass="tab-content">
                    <h3 class="text-center text-primary mb-4">Create an Account</h3>
                    <form id="registerForm" defaultbutton="btnRegister">
                        <div class="form-group mb-3">
                            <asp:Label ID="lblRegName" runat="server" Text="Name" AssociatedControlID="txtRegName"></asp:Label>
                            <asp:TextBox ID="txtRegName" runat="server" CssClass="form-control" placeholder="Enter Name" required></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvRegName" runat="server" ControlToValidate="txtRegName" ErrorMessage="Name is required" CssClass="error-message" ValidationGroup="RegisterGroup" />
                        </div>
                        <div class="form-group mb-3">
                            <asp:Label ID="lblRegEmail" runat="server" Text="Email" AssociatedControlID="txtRegEmail"></asp:Label>
                            <asp:TextBox ID="txtRegEmail" runat="server" CssClass="form-control" placeholder="Enter Email" TextMode="Email" required></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvRegEmail" runat="server" ControlToValidate="txtRegEmail" ErrorMessage="Email is required" CssClass="error-message" ValidationGroup="RegisterGroup" />
                            <asp:RegularExpressionValidator ID="revRegEmail" runat="server" ControlToValidate="txtRegEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-message" ValidationGroup="RegisterGroup" />
                        </div>
                        <div class="form-group mb-3">
                            <asp:Label ID="lblRegPassword" runat="server" Text="Password" AssociatedControlID="txtRegPassword"></asp:Label>
                            <asp:TextBox ID="txtRegPassword" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password" required></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvRegPassword" runat="server" ControlToValidate="txtRegPassword" ErrorMessage="Password is required" CssClass="error-message" ValidationGroup="RegisterGroup" />
                        </div>
                        <div class="form-group mb-3">
                            <asp:Label ID="lblRegRole" runat="server" Text="Role" AssociatedControlID="ddlRole"></asp:Label>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control form-control-lg">
                                <asp:ListItem Value="User">User</asp:ListItem>
                                <asp:ListItem Value="Admin">Admin</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvRegRole" runat="server" ControlToValidate="ddlRole" ErrorMessage="Role is required" CssClass="error-message" InitialValue="" ValidationGroup="RegisterGroup" />
                        </div>
                        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary w-100" ValidationGroup="RegisterGroup" />
                        <asp:Label ID="lblRegError" runat="server" CssClass="error-message text-center d-block mt-2" Visible="false"></asp:Label>
                    </form>
                </asp:Panel>
            </div>
        </div>
    </section>
</asp:Content>
