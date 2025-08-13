<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkoutForm.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.checkoutForm" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Checkout - Flyora</title>
    <style>
        /* Checkout Form Styles */
        .checkout-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1rem;
            background: linear-gradient(135deg, #f5f7fa 0%, #e8f4f8 100%);
            min-height: 80vh;
        }

        .checkout-header {
            text-align: center;
            margin-bottom: 3rem;
            padding: 2rem 0;
        }

            .checkout-header h2 {
                font-size: 2.8rem;
                font-weight: 700;
                color: #2c5aa0;
                margin-bottom: 0.5rem;
                text-shadow: 2px 2px 4px rgba(44, 90, 160, 0.1);
            }

            .checkout-header p {
                font-size: 1.2rem;
                color: #666;
                max-width: 600px;
                margin: 0 auto;
            }

        .checkout-layout {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 3rem;
            align-items: start;
        }

        @media (max-width: 992px) {
            .checkout-layout {
                grid-template-columns: 1fr;
                gap: 2rem;
            }
        }

        /* Booking Summary */
        .summary-section {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            border: 1px solid rgba(44, 90, 160, 0.1);
            position: sticky;
            top: 2rem;
        }

        .summary-header {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e3d6f 100%);
            color: white;
            padding: 1.5rem 2rem;
            font-size: 1.2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .summary-body {
            padding: 2rem;
        }

        .destination-card {
            background: linear-gradient(145deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid #2c5aa0;
        }

            .destination-card:last-child {
                margin-bottom: 0;
            }

            .destination-card h5 {
                color: #2c5aa0;
                font-weight: 700;
                margin-bottom: 1rem;
                font-size: 1.2rem;
            }

            .destination-card .card-text {
                color: #495057;
                line-height: 1.6;
                margin: 0;
            }

                .destination-card .card-text strong {
                    color: #28a745;
                }

        /* Form Section */
        .form-main {
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
            overflow: hidden;
            border: 1px solid rgba(44, 90, 160, 0.1);
        }

        .form-header {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e3d6f 100%);
            color: white;
            padding: 1.5rem 2rem;
            font-size: 1.2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-body {
            padding: 2.5rem;
        }

        .form-section {
            margin-bottom: 2.5rem;
        }

            .form-section h4 {
                color: #2c5aa0;
                font-weight: 700;
                margin-bottom: 1.5rem;
                font-size: 1.3rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid rgba(44, 90, 160, 0.2);
            }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

            .form-group label {
                color: #2c3e50;
                font-weight: 600;
                margin-bottom: 0.8rem;
                display: block;
                font-size: 1rem;
            }

        .form-control {
            width: 100%;
            padding: 1rem 1.2rem;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            color: #333;
        }

            .form-control:focus {
                border-color: #2c5aa0;
                box-shadow: 0 0 0 4px rgba(44, 90, 160, 0.1);
                outline: none;
                transform: translateY(-1px);
            }

        .validation-error {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.5rem;
            display: block;
            font-weight: 500;
        }

        /* Payment Section */
        .payment-options {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .payment-option {
            flex: 1;
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

            .payment-option:hover {
                border-color: #2c5aa0;
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(44, 90, 160, 0.15);
            }

            .payment-option.selected {
                border-color: #2c5aa0;
                background: rgba(44, 90, 160, 0.05);
                box-shadow: 0 8px 25px rgba(44, 90, 160, 0.2);
            }

            .payment-option input[type="radio"] {
                display: none;
            }

            .payment-option .payment-icon {
                font-size: 2rem;
                margin-bottom: 0.5rem;
                color: #2c5aa0;
            }

            .payment-option .payment-label {
                font-weight: 600;
                color: #333;
            }

        /* Card Details Section */
        .card-details {
            background: linear-gradient(145deg, rgba(44, 90, 160, 0.05), rgba(44, 90, 160, 0.1));
            border-radius: 15px;
            padding: 2rem;
            margin-top: 1.5rem;
            border: 2px solid rgba(44, 90, 160, 0.2);
            display: none;
        }

            .card-details.show {
                display: block;
                animation: slideDown 0.3s ease;
            }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card-type-selector {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .card-type {
            flex: 1;
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.8rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
        }

            .card-type:hover {
                border-color: #2c5aa0;
                transform: translateY(-1px);
            }

            .card-type.selected {
                border-color: #2c5aa0;
                background: rgba(44, 90, 160, 0.1);
            }

            .card-type input[type="radio"] {
                display: none;
            }

            .card-type .card-icon {
                font-size: 1.5rem;
                margin-bottom: 0.3rem;
            }

            .card-type .card-label {
                font-weight: 600;
                font-size: 0.9rem;
            }

        .card-number-group {
            position: relative;
        }

            .card-number-group .card-logo {
                position: absolute;
                right: 1rem;
                top: 50%;
                transform: translateY(-50%);
                font-size: 1.5rem;
                color: #666;
            }

        /* Terms Checkbox */
        .terms-section {
            background: rgba(44, 90, 160, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            margin: 2rem 0;
            border: 2px solid rgba(44, 90, 160, 0.1);
        }

        .custom-checkbox {
            display: flex;
            align-items: center;
            gap: 1rem;
            cursor: pointer;
        }

            .custom-checkbox input[type="checkbox"] {
                width: 20px;
                height: 20px;
                accent-color: #2c5aa0;
            }

            .custom-checkbox label {
                margin: 0;
                cursor: pointer;
                line-height: 1.5;
            }

        /* Submit Button */
        .submit-section {
            text-align: center;
            margin-top: 2rem;
        }

        .btn-book {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e3d6f 100%);
            border: none;
            color: white;
            padding: 1.2rem 3rem;
            border-radius: 25px;
            font-size: 1.2rem;
            font-weight: 700;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(44, 90, 160, 0.3);
            cursor: pointer;
        }

            .btn-book:hover {
                background: linear-gradient(135deg, #1e3d6f 0%, #4a90e2 100%);
                transform: translateY(-3px);
                box-shadow: 0 12px 35px rgba(44, 90, 160, 0.4);
            }

            .btn-book:disabled {
                background: #6c757d;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

        /* Alert Messages */
        .alert {
            border-radius: 12px;
            border: none;
            padding: 1.2rem 1.8rem;
            font-weight: 600;
            margin-top: 1.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .alert-danger {
            background: linear-gradient(45deg, #f8d7da, #f1b0b7);
            color: #721c24;
            border-left: 5px solid #dc3545;
        }

        .alert-success {
            background: linear-gradient(45deg, #d4edda, #c3e6cb);
            color: #155724;
            border-left: 5px solid #28a745;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .checkout-container {
                padding: 1rem;
            }

            .checkout-header h2 {
                font-size: 2.2rem;
            }

            .form-body, .summary-body {
                padding: 1.5rem;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .payment-options {
                flex-direction: column;
            }

            .card-type-selector {
                flex-direction: column;
            }

            .btn-book {
                padding: 1rem 2rem;
                font-size: 1.1rem;
            }
        }

        @media (max-width: 480px) {
            .checkout-header h2 {
                font-size: 1.8rem;
            }

            .card-details {
                padding: 1.5rem;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="checkout-container">
        <!-- Header Section -->
        <div class="checkout-header">
            <h2><i class="fas fa-credit-card me-3"></i>Checkout</h2>
            <p>Complete your booking with secure payment options</p>
        </div>

        <div class="checkout-layout">
            <!-- Main Form -->
            <div class="form-main">
                <div class="form-header">
                    <i class="fas fa-user-edit me-2"></i>Booking Details
                </div>
                
                <div class="form-body">
                    <!-- Traveler Information -->
                    <div class="form-section">
                        <h4><i class="fas fa-user me-2"></i>Traveler Information</h4>
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="txtFullName">Full Name *</label>
                                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" />
                                <asp:RequiredFieldValidator ID="rfvName" ControlToValidate="txtFullName" runat="server" 
                                    CssClass="validation-error" ErrorMessage="Please enter your full name" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revName" runat="server" ControlToValidate="txtFullName" 
                                    CssClass="validation-error" ErrorMessage="Name should contain only letters and spaces" 
                                    ValidationExpression="^[a-zA-Z\s]+$" Display="Dynamic" />
                            </div>

                            <div class="form-group">
                                <label for="txtEmail">Email Address *</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter your email" />
                                <asp:RequiredFieldValidator ID="rfvEmail" ControlToValidate="txtEmail" runat="server" 
                                    CssClass="validation-error" ErrorMessage="Email is required" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                                    CssClass="validation-error" ErrorMessage="Please enter a valid email address" 
                                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" Display="Dynamic" />
                            </div>

                            <div class="form-group">
                                <label for="txtPhone">Phone Number *</label>
                                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number" />
                                <asp:RequiredFieldValidator ID="rfvPhone" ControlToValidate="txtPhone" runat="server" 
                                    CssClass="validation-error" ErrorMessage="Phone number is required" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" 
                                    CssClass="validation-error" ErrorMessage="Please enter a valid phone number" 
                                    ValidationExpression="^[\+]?[1-9][\d]{0,15}$" Display="Dynamic" />
                            </div>

                            <div class="form-group" style="grid-column: span 2;">
                                <label for="txtAddress">Complete Address *</label>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" 
                                    Rows="3" placeholder="Enter your complete address" />
                                <asp:RequiredFieldValidator ID="rfvAddress" ControlToValidate="txtAddress" runat="server" 
                                    CssClass="validation-error" ErrorMessage="Address is required" Display="Dynamic" />
                            </div>
                        </div>
                    </div>

                    <!-- Payment Information -->
                    <div class="form-section">
                        <h4><i class="fas fa-credit-card me-2"></i>Payment Method</h4>
                        
                        <div class="payment-options">
                            <div class="payment-option" onclick="selectPayment('cash')">
                                <asp:RadioButton ID="rbCash" runat="server" GroupName="Payment" Value="Cash" ClientIDMode="Static" />
                                <div class="payment-icon"><i class="fas fa-money-bill-wave"></i></div>
                                <div class="payment-label">Cash on Arrival</div>
                            </div>
                            <div class="payment-option" onclick="selectPayment('card')">
                                <asp:RadioButton ID="rbCard" runat="server" GroupName="Payment" Value="Card" ClientIDMode="Static" />
                                <div class="payment-icon"><i class="fas fa-credit-card"></i></div>
                                <div class="payment-label">Credit/Debit Card</div>
                            </div>
                        </div>

                        <asp:CustomValidator ID="cvPayment" runat="server" ErrorMessage="Please select a payment method" 
                            CssClass="validation-error" ClientValidationFunction="validatePayment" Display="Dynamic" />

                        <!-- Card Details Section -->
                        <div id="cardDetails" class="card-details">
                            <h5 style="color: #2c5aa0; margin-bottom: 1.5rem;"><i class="fas fa-credit-card me-2"></i>Card Details</h5>
                            
                            <div class="card-type-selector">
                                <div class="card-type" onclick="selectCardType('credit')">
                                    <asp:RadioButton ID="rbCredit" runat="server" GroupName="CardType" Value="Credit" ClientIDMode="Static" />
                                    <div class="card-icon" style="color: #2c5aa0;"><i class="fas fa-credit-card"></i></div>
                                    <div class="card-label">Credit Card</div>
                                </div>
                                <div class="card-type" onclick="selectCardType('debit')">
                                    <asp:RadioButton ID="rbDebit" runat="server" GroupName="CardType" Value="Debit" ClientIDMode="Static" />
                                    <div class="card-icon" style="color: #28a745;"><i class="fas fa-money-check-alt"></i></div>
                                    <div class="card-label">Debit Card</div>
                                </div>
                            </div>

                            <asp:CustomValidator ID="cvCardType" runat="server" ErrorMessage="Please select card type" 
                                CssClass="validation-error" ClientValidationFunction="validateCardType" Display="Dynamic" />

                            <div class="form-grid">
                                <div class="form-group" style="grid-column: span 2;">
                                    <label for="txtCardNumber">Card Number *</label>
                                    <div class="card-number-group">
                                        <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" 
                                            placeholder="1234 5678 9012 3456" MaxLength="19" />
                                        <div class="card-logo"><i class="fas fa-credit-card"></i></div>
                                    </div>
                                    <asp:RequiredFieldValidator ID="rfvCardNumber" ControlToValidate="txtCardNumber" runat="server" 
                                        CssClass="validation-error" ErrorMessage="Card number is required" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revCardNumber" runat="server" ControlToValidate="txtCardNumber" 
                                        CssClass="validation-error" ErrorMessage="Please enter a valid card number (16 digits)" 
                                        ValidationExpression="^\d{4}\s\d{4}\s\d{4}\s\d{4}$" Display="Dynamic" />
                                </div>

                                <div class="form-group">
                                    <label for="txtCardHolder">Cardholder Name *</label>
                                    <asp:TextBox ID="txtCardHolder" runat="server" CssClass="form-control" 
                                        placeholder="Name on card" />
                                    <asp:RequiredFieldValidator ID="rfvCardHolder" ControlToValidate="txtCardHolder" runat="server" 
                                        CssClass="validation-error" ErrorMessage="Cardholder name is required" Display="Dynamic" />
                                </div>

                                <div class="form-group">
                                    <label for="txtExpiryDate">Expiry Date *</label>
                                    <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control" 
                                        placeholder="MM/YY" MaxLength="5" />
                                    <asp:RequiredFieldValidator ID="rfvExpiry" ControlToValidate="txtExpiryDate" runat="server" 
                                        CssClass="validation-error" ErrorMessage="Expiry date is required" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revExpiry" runat="server" ControlToValidate="txtExpiryDate" 
                                        CssClass="validation-error" ErrorMessage="Please enter valid expiry date (MM/YY)" 
                                        ValidationExpression="^(0[1-9]|1[0-2])\/([0-9]{2})$" Display="Dynamic" />
                                    <asp:CustomValidator ID="cvExpiry" runat="server" ControlToValidate="txtExpiryDate" 
                                        CssClass="validation-error" ErrorMessage="Card has expired" 
                                        ClientValidationFunction="validateExpiryDate" Display="Dynamic" />
                                </div>

                                <div class="form-group">
                                    <label for="txtCVV">CVV *</label>
                                    <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" 
                                        placeholder="123" MaxLength="4" />
                                    <asp:RequiredFieldValidator ID="rfvCVV" ControlToValidate="txtCVV" runat="server" 
                                        CssClass="validation-error" ErrorMessage="CVV is required" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revCVV" runat="server" ControlToValidate="txtCVV" 
                                        CssClass="validation-error" ErrorMessage="CVV must be 3-4 digits" 
                                        ValidationExpression="^[0-9]{3,4}$" Display="Dynamic" />
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Terms and Conditions -->
                    <div class="terms-section">
                        <div class="custom-checkbox">
                            <asp:CheckBox ID="chkTerms" runat="server" ClientIDMode="Static" />
                            <label for="chkTerms">
                                I agree to the <a href="#" style="color: #2c5aa0; font-weight: 600;">Terms and Conditions</a> 
                                and <a href="#" style="color: #2c5aa0; font-weight: 600;">Privacy Policy</a> *
                            </label>
                        </div>
                        <asp:CustomValidator ID="cvTerms" runat="server" ErrorMessage="You must accept the terms and conditions" 
                            CssClass="validation-error" ClientValidationFunction="validateTerms" Display="Dynamic" />
                    </div>

                    <!-- Submit Button -->
                    <div class="submit-section">
                        <asp:Button ID="btnBook" runat="server" Text="Complete Booking" 
                            CssClass="btn-book" OnClick="btnBook_Click" OnClientClick="return validateForm();" />
                    </div>

                    <!-- Messages -->
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-danger" 
                        Visible="false" style="display: block; margin-top: 1.5rem;"></asp:Label>
                </div>
            </div>

            <!-- Booking Summary -->
            <div class="summary-section">
                <div class="summary-header">
                    <i class="fas fa-clipboard-list me-2"></i>Booking Summary
                </div>
                <div class="summary-body">
                    <asp:Panel ID="pnlSummary" runat="server">
                        <asp:Repeater ID="rptSummary" runat="server">
                            <ItemTemplate>
                                <div class="destination-card">
                                    <h5><%# Eval("Destination") %></h5>
                                    <div class="card-text">
                                        <div style="margin-bottom: 0.5rem;">
                                            <i class="fas fa-calendar-alt" style="color: #2c5aa0; margin-right: 0.5rem;"></i>
                                            <%# Eval("DepartureDate", "{0:MMM dd, yyyy}") %> - <%# Eval("ReturnDate", "{0:MMM dd, yyyy}") %>
                                        </div>
                                        <div style="margin-bottom: 0.5rem;">
                                            <i class="fas fa-users" style="color: #2c5aa0; margin-right: 0.5rem;"></i>
                                            <%# Eval("Travelers") %> Traveler(s)
                                        </div>
                                        <div>
                                            <strong>Total: <%# Eval("TotalPrice", "{0:C}") %></strong>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Payment method selection
        function selectPayment(type) {
            document.querySelectorAll('.payment-option').forEach(option => {
                option.classList.remove('selected');
            });

            if (type === 'cash') {
                document.getElementById('rbCash').checked = true;
                document.querySelector('.payment-option').classList.add('selected');
                document.getElementById('cardDetails').classList.remove('show');
            } else {
                document.getElementById('rbCard').checked = true;
                document.querySelectorAll('.payment-option')[1].classList.add('selected');
                document.getElementById('cardDetails').classList.add('show');
            }
        }

        // Card type selection
        function selectCardType(type) {
            document.querySelectorAll('.card-type').forEach(cardType => {
                cardType.classList.remove('selected');
            });

            if (type === 'credit') {
                document.getElementById('rbCredit').checked = true;
                document.querySelector('.card-type').classList.add('selected');
            } else {
                document.getElementById('rbDebit').checked = true;
                document.querySelectorAll('.card-type')[1].classList.add('selected');
            }
        }

        // Card number formatting
        document.addEventListener('DOMContentLoaded', function () {
            const cardNumberInput = document.getElementById('<%= txtCardNumber.ClientID %>');
            const expiryInput = document.getElementById('<%= txtExpiryDate.ClientID %>');
            
            if (cardNumberInput) {
                cardNumberInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
                    let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;
                    if (formattedValue.length <= 19) {
                        e.target.value = formattedValue;
                    }
                });
            }
            
            if (expiryInput) {
                expiryInput.addEventListener('input', function(e) {
                    let value = e.target.value.replace(/\D/g, '');
                    if (value.length >= 2) {
                        value = value.substring(0, 2) + '/' + value.substring(2, 4);
                    }
                    e.target.value = value;
                });
            }
        });

        // Validation functions
        function validatePayment(source, args) {
            args.IsValid = document.getElementById('rbCash').checked || document.getElementById('rbCard').checked;
        }

        function validateCardType(source, args) {
            if (document.getElementById('rbCard').checked) {
                args.IsValid = document.getElementById('rbCredit').checked || document.getElementById('rbDebit').checked;
            } else {
                args.IsValid = true;
            }
        }

        function validateExpiryDate(source, args) {
            if (document.getElementById('rbCard').checked && args.Value) {
                const parts = args.Value.split('/');
                if (parts.length === 2) {
                    const month = parseInt(parts[0], 10);
                    const year = parseInt('20' + parts[1], 10);
                    const expiry = new Date(year, month - 1);
                    const today = new Date();
                    today.setDate(1);
                    args.IsValid = expiry >= today;
                } else {
                    args.IsValid = false;
                }
            } else {
                args.IsValid = true;
            }
        }

        function validateTerms(source, args) {
            args.IsValid = document.getElementById('chkTerms').checked;
        }

        function validateForm() {
            // Check if card payment is selected and validate card fields
            if (document.getElementById('rbCard').checked) {
                const cardNumber = document.getElementById('<%= txtCardNumber.ClientID %>').value;
                const cardHolder = document.getElementById('<%= txtCardHolder.ClientID %>').value;
                const expiryDate = document.getElementById('<%= txtExpiryDate.ClientID %>').value;
                const cvv = document.getElementById('<%= txtCVV.ClientID %>').value;

                if (!cardNumber || !cardHolder || !expiryDate || !cvv) {
                    alert('Please fill in all card details');
                    return false;
                }

                if (!(document.getElementById('rbCredit').checked || document.getElementById('rbDebit').checked)) {
                    alert('Please select card type');
                    return false;
                }
            }

            if (!document.getElementById('chkTerms').checked) {
                alert('Please accept the terms and conditions');
                return false;
            }

            return true;
        }
    </script>
</asp:Content>