<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Cart" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Shopping Cart - Flyora</title>
    <style>
       /* Modern Cart Styles */
.cart-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1rem;
}

.cart-header {
    text-align: center;
    margin-bottom: 3rem;
}

    .cart-header h1 {
        font-size: 2.5rem;
        font-weight: 700;
        color: #2c3e50;
        margin-bottom: 0.5rem;
    }

    .cart-header p {
        font-size: 1.1rem;
        color: #6c757d;
    }

/* Message Styles */
.message-container {
    margin-bottom: 2rem;
}

.alert {
    border-radius: 8px;
    border: none;
    padding: 1rem 1.5rem;
    font-weight: 500;
}

.alert-success {
    background-color: #d4edda;
    color: #155724;
    border-left: 4px solid #28a745;
}

.alert-danger {
    background-color: #f8d7da;
    color: #721c24;
    border-left: 4px solid #dc3545;
}

/* Cart Layout */
.cart-content {
    display: grid;
    grid-template-columns: 1fr 350px;
    gap: 2rem;
    align-items: start;
}

@media (max-width: 992px) {
    .cart-content {
        grid-template-columns: 1fr;
        gap: 1.5rem;
    }
}

/* Cart Items */
.cart-items {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    overflow: hidden;
}

.cart-items-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 1.25rem 1.5rem;
    font-size: 1.1rem;
    font-weight: 600;
}

.cart-item {
    padding: 1.5rem;
    border-bottom: 1px solid #e9ecef;
    transition: background-color 0.3s ease;
}

    .cart-item:hover {
        background-color: #f8f9fa;
    }

    .cart-item:last-child {
        border-bottom: none;
    }

.item-image {
    width: 100%;
    height: 120px;
    object-fit: cover;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.item-details h5 {
    color: #2c3e50;
    font-weight: 600;
    margin-bottom: 0.5rem;
}

.item-description {
    color: #6c757d;
    margin-bottom: 1rem;
    line-height: 1.5;
}

.travel-info {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.travel-info-item {
    display: flex;
    align-items: center;
    color: #495057;
    font-size: 0.875rem;
}

    .travel-info-item i {
        width: 16px;
        margin-right: 0.5rem;
        color: #667eea;
    }

.price-section {
    text-align: right;
}

.price-per-person {
    color: #6c757d;
    font-size: 0.875rem;
    margin-bottom: 0.25rem;
}

.individual-price {
    color: #28a745;
    font-size: 1.1rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
}

.total-price {
    color: #2c3e50;
    font-size: 1.25rem;
    font-weight: 700;
}

.item-actions {
    margin-top: 1rem;
    display: flex;
    gap: 0.5rem;
    justify-content: flex-end;
}

.btn-edit {
    background: #f8f9fa;
    border: 1px solid #dee2e6;
    color: #495057;
    padding: 0.375rem 0.75rem;
    border-radius: 6px;
    font-size: 0.875rem;
    transition: all 0.3s ease;
}

    .btn-edit:hover {
        background: #e9ecef;
        border-color: #adb5bd;
        color: #495057;
    }

.btn-remove {
    background: #fff5f5;
    border: 1px solid #fed7d7;
    color: #c53030;
    padding: 0.375rem 0.75rem;
    border-radius: 6px;
    font-size: 0.875rem;
    transition: all 0.3s ease;
}

    .btn-remove:hover {
        background: #fed7d7;
        border-color: #fc8181;
        color: #c53030;
    }

/* Order Summary */
.order-summary {
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
    position: sticky;
    top: 2rem;
    overflow: hidden;
}

.summary-header {
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    color: white;
    padding: 1.25rem 1.5rem;
    font-size: 1.1rem;
    font-weight: 600;
}

.summary-body {
    padding: 1.5rem;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.75rem;
    color: #495057;
}

.summary-divider {
    border: none;
    height: 1px;
    background: #e9ecef;
    margin: 1rem 0;
}

.summary-total {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 1.25rem;
    font-weight: 700;
    color: #2c3e50;
    margin-bottom: 1.5rem;
}

.total-amount {
    color: #28a745;
}

.checkout-actions {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.btn-checkout {
    background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
    border: none;
    color: white;
    padding: 0.875rem 1.5rem;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    transition: all 0.3s ease;
}

    .btn-checkout:hover {
        background: linear-gradient(135deg, #38a169 0%, #2f855a 100%);
        transform: translateY(-1px);
        box-shadow: 0 4px 12px rgba(72, 187, 120, 0.3);
    }

.btn-clear {
    background: white;
    border: 1px solid #dc3545;
    color: #dc3545;
    padding: 0.75rem 1rem;
    border-radius: 8px;
    font-size: 0.9rem;
    transition: all 0.3s ease;
}

    .btn-clear:hover {
        background: #dc3545;
        color: white;
    }

/* Empty Cart */
.empty-cart {
    text-align: center;
    padding: 4rem 2rem;
    background: white;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.08);
}

.empty-cart-icon {
    font-size: 4rem;
    color: #dee2e6;
    margin-bottom: 1.5rem;
}

.empty-cart h3 {
    color: #6c757d;
    margin-bottom: 1rem;
}

.empty-cart p {
    color: #adb5bd;
    margin-bottom: 2rem;
}

.btn-explore {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    color: white;
    padding: 0.875rem 2rem;
    border-radius: 8px;
    font-size: 1rem;
    font-weight: 600;
    transition: all 0.3s ease;
}

    .btn-explore:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
    }

/* Continue Shopping */
.continue-shopping {
    text-align: center;
    margin-top: 2rem;
}

.btn-continue {
    background: white;
    border: 2px solid #667eea;
    color: #667eea;
    padding: 0.75rem 1.5rem;
    border-radius: 8px;
    font-weight: 500;
    transition: all 0.3s ease;
    text-decoration: none;
}

    .btn-continue:hover {
        background: #667eea;
        color: white;
        text-decoration: none;
    }

/* Responsive Design */
@media (max-width: 768px) {
    .cart-container {
        padding: 1rem;
    }

    .cart-header h1 {
        font-size: 2rem;
    }

    .cart-item {
        padding: 1rem;
    }

    .item-actions {
        justify-content: center;
    }

    .price-section {
        text-align: center;
        margin-top: 1rem;
    }
}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="cart-container">
        <!-- Header Section -->
        <div class="cart-header">
            <h1><i class="fas fa-shopping-cart me-3"></i> Your Travel Bookings</h1>
            <p>Review your selected destinations and proceed to booking</p>
        </div>

        <!-- Messages -->
        <div class="message-container">
            <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>
        </div>

        <!-- Cart Items Section -->
        <asp:Panel ID="pnlCartItems" runat="server" Visible="true">
            <div class="cart-content">
                <!-- Items List -->
                <div class="cart-items">
                    <div class="cart-items-header">
                        <i class="fas fa-list me-2"></i>Cart Items
                    </div>
                    
                    <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                        <ItemTemplate>
                            <div class="cart-item">
                                <div class="row align-items-center">
                                    <!-- Image -->
                                    <div class="col-md-3 mb-3 mb-md-0">
                                        <img src='<%# ResolveUrl(Eval("ImageURL").ToString()) %>' 
                                             alt='<%# Eval("Destination") %>' 
                                             class="item-image" />
                                    </div>
                                    
                                    <!-- Details -->
                                    <div class="col-md-5 mb-3 mb-md-0">
                                        <div class="item-details">
                                            <h5><%# Eval("Destination") %></h5>
                                            <p class="item-description"><%# Eval("Description") %></p>
                                            
                                            <div class="travel-info">
                                                <div class="travel-info-item">
                                                    <i class="fas fa-plane-departure"></i>
                                                    <strong>Departure:</strong>&nbsp;<%# Eval("DepartureDate", "{0:MMM dd, yyyy}") %>
                                                </div>
                                                <div class="travel-info-item">
                                                    <i class="fas fa-plane-arrival"></i>
                                                    <strong>Return:</strong>&nbsp;<%# Eval("ReturnDate", "{0:MMM dd, yyyy}") %>
                                                </div>
                                                <div class="travel-info-item">
                                                    <i class="fas fa-users"></i>
                                                    <strong>Travelers:</strong>&nbsp;<%# Eval("Travelers") %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Price and Actions -->
                                    <div class="col-md-4">
                                        <div class="price-section">
                                            <div class="price-per-person">Price per person</div>
                                            <div class="individual-price"><%# Eval("Price", "{0:C}") %></div>
                                            <div class="total-price">Total: <%# Eval("TotalPrice", "{0:C}") %></div>
                                            
                                            <div class="item-actions">
                                                <asp:LinkButton ID="btnUpdate" runat="server" 
                                                    CssClass="btn-edit"
                                                    CommandName="Update" 
                                                    CommandArgument='<%# Eval("DestinationId") %>'
                                                    ToolTip="Update dates and travelers">
                                                    <i class="fas fa-edit me-1"></i>Edit
                                                </asp:LinkButton>
                                                <asp:LinkButton ID="btnRemove" runat="server" 
                                                    CssClass="btn-remove"
                                                    CommandName="Remove" 
                                                    CommandArgument='<%# Eval("DestinationId") %>'
                                                    OnClientClick="return confirm('Remove this item from cart?');"
                                                    ToolTip="Remove from cart">
                                                    <i class="fas fa-trash me-1"></i>Remove
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>

                <!-- Order Summary -->
                <div class="order-summary">
                    <div class="summary-header">
                        <i class="fas fa-calculator me-2"></i>Order Summary
                    </div>
                    <div class="summary-body">
                        <div class="summary-row">
                            <span>Items in Cart:</span>
                            <span><asp:Label ID="lblItemCount" runat="server" Text="0"></asp:Label></span>
                        </div>
                        <div class="summary-row">
                            <span>Total Travelers:</span>
                            <span><asp:Label ID="lblTotalTravelers" runat="server" Text="0"></asp:Label></span>
                        </div>
                        
                        <hr class="summary-divider" />
                        
                        <div class="summary-row">
                            <span>Subtotal:</span>
                            <span><asp:Label ID="lblSubtotal" runat="server" Text="$0.00"></asp:Label></span>
                        </div>
                        <div class="summary-row">
                            <span>Tax (13% HST):</span>
                            <span><asp:Label ID="lblTax" runat="server" Text="$0.00"></asp:Label></span>
                        </div>
                        
                        <hr class="summary-divider" />
                        
                        <div class="summary-total">
                            <span>Grand Total:</span>
                            <span class="total-amount"><asp:Label ID="lblGrandTotal" runat="server" Text="$0.00"></asp:Label></span>
                        </div>
                        
                        <div class="checkout-actions">
                            <asp:Button ID="btnProceedToCheckout" runat="server" 
                                Text="Proceed to Checkout" 
                                CssClass="btn-checkout"
                                OnClick="btnProceedToCheckout_Click" />
                            <asp:Button ID="btnClearCart" runat="server" 
                                Text="Clear All Items" 
                                CssClass="btn-clear"
                                OnClick="btnClearCart_Click"
                                OnClientClick="return confirm('Clear all items from cart?');" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <!-- Empty Cart Section -->
        <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false">
            <div class="empty-cart">
                <div class="empty-cart-icon">
                    <i class="fas fa-shopping-cart"></i>
                </div>
                <h3>No Bookings</h3>
                <p>Discover amazing destinations and start planning your next adventure!</p>
                <asp:Button ID="btnStartShopping" runat="server" 
                    Text="Explore Destinations" 
                    CssClass="btn-explore"
                    PostBackUrl="~/Travel/Destination" />
            </div>
        </asp:Panel>

        <!-- Continue Shopping -->
        <div class="continue-shopping">
            <asp:LinkButton ID="lnkContinueShopping" runat="server" 
                CssClass="btn-continue"
                PostBackUrl="~/Travel/Destination">
                <i class="fas fa-arrow-left me-2"></i>Continue Shopping
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>