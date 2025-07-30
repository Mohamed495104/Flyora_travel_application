<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Login" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  
    <asp:SqlDataSource ID="sqlDataSourceLogin" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT UserID, Username, Email, Role, CreatedAt FROM Users WHERE Email = @Email AND Password = @Password">
        <SelectParameters>
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

   
    <asp:SqlDataSource ID="sqlDataSourceRegister" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        InsertCommand="INSERT INTO Users (Username, Email, Password, Role, CreatedAt) VALUES (@Username, @Email, @Password, @Role, @CreatedAt)"
        SelectCommand="SELECT UserID, Username, Email, Role, CreatedAt FROM Users WHERE Email = @Email">
        <InsertParameters>
            <asp:Parameter Name="Username" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="Password" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="CreatedAt" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:Parameter Name="Email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    
    <asp:SqlDataSource ID="sqlDataSourceCheckEmail" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT COUNT(*) as EmailCount FROM Users WHERE Email = @Email">
        <SelectParameters>
            <asp:Parameter Name="Email" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

  
    <asp:SqlDataSource ID="sqlDataSourceCheckUsername" runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT COUNT(*) as UsernameCount FROM Users WHERE Username = @Username">
        <SelectParameters>
            <asp:Parameter Name="Username" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

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
                    <div class="form-group mb-3">
                        <asp:Label ID="lblLoginEmail" runat="server" Text="Email" AssociatedControlID="txtLoginEmail"></asp:Label>
                        <asp:TextBox ID="txtLoginEmail" runat="server" CssClass="form-control form-control-lg" placeholder="Enter Email" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLoginEmail" runat="server" ControlToValidate="txtLoginEmail" ErrorMessage="Email is required" CssClass="error-message" ValidationGroup="LoginGroup" />
                    </div>
                    <div class="form-group mb-3">
                        <asp:Label ID="lblLoginPassword" runat="server" Text="Password" AssociatedControlID="txtLoginPassword"></asp:Label>
                        <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="form-control form-control-lg" placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvLoginPassword" runat="server" ControlToValidate="txtLoginPassword" ErrorMessage="Password is required" CssClass="error-message" ValidationGroup="LoginGroup" />
                    </div>

                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary w-100" ValidationGroup="LoginGroup" OnClick="btnLogin_Click" />
                    <asp:Label ID="lblLoginError" runat="server" CssClass="error-message text-center d-block mt-2" Visible="false"></asp:Label>
                    
                    <p class="text-center mt-3">
                        <asp:LinkButton ID="lnkSwitchToRegister" runat="server" CssClass="text-primary" OnClick="lnkSwitchToRegister_Click" CausesValidation="false">Need an account? Register here</asp:LinkButton>
                    </p>
                </asp:Panel>

               
                <asp:Panel ID="pnlRegister" runat="server" CssClass="tab-content">
                    <h3 class="text-center text-primary mb-4">Create an Account</h3>
                    <div class="form-group mb-3">
                        <asp:Label ID="lblRegName" runat="server" Text="Username" AssociatedControlID="txtRegName"></asp:Label>
                        <asp:TextBox ID="txtRegName" runat="server" CssClass="form-control form-control-lg" placeholder="Enter Username"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRegName" runat="server" ControlToValidate="txtRegName" ErrorMessage="Username is required" CssClass="error-message" ValidationGroup="RegisterGroup" Display="Dynamic" />
                    </div>
                    <div class="form-group mb-3">
                        <asp:Label ID="lblRegEmail" runat="server" Text="Email" AssociatedControlID="txtRegEmail"></asp:Label>
                        <asp:TextBox ID="txtRegEmail" runat="server" CssClass="form-control form-control-lg" placeholder="Enter Email" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRegEmail" runat="server" ControlToValidate="txtRegEmail" ErrorMessage="Email is required" CssClass="error-message" ValidationGroup="RegisterGroup" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revRegEmail" runat="server" ControlToValidate="txtRegEmail" ErrorMessage="Invalid email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" CssClass="error-message" ValidationGroup="RegisterGroup" Display="Dynamic" />
                    </div>
                    <div class="form-group mb-3">
                        <asp:Label ID="lblRegPassword" runat="server" Text="Password" AssociatedControlID="txtRegPassword"></asp:Label>
                        <asp:TextBox ID="txtRegPassword" runat="server" CssClass="form-control form-control-lg" placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRegPassword" runat="server" ControlToValidate="txtRegPassword" ErrorMessage="Password is required" CssClass="error-message" ValidationGroup="RegisterGroup" Display="Dynamic" />
                    </div>
                    <div class="form-group mb-3">
                        <asp:Label ID="lblRegRole" runat="server" Text="Role" AssociatedControlID="ddlRole"></asp:Label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control form-control-lg">
                            <asp:ListItem Value="User" Selected="True">User</asp:ListItem>
                            <asp:ListItem Value="Admin">Admin</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary w-100" ValidationGroup="RegisterGroup" OnClick="btnRegister_Click" UseSubmitBehavior="true" />
                    <asp:Label ID="lblRegError" runat="server" CssClass="error-message text-center d-block mt-2" Visible="false"></asp:Label>
                </asp:Panel>
            </div>
        </div>
    </section>
</asp:Content>