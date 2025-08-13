<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.Cart" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Shopping Cart - Flyora</title>
    <style>

.cart-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1rem;
    background: linear-gradient(135deg, #f5f7fa 0%, #e8f4f8 100%);
    min-height: 80vh;
}

.cart-header {
    text-align: center;
    margin-bottom: 3rem;
    padding: 2rem 0;
}

    .cart-header h1 {
        font-size: 2.8rem;
        font-weight: 700;
        color: #2c5aa0;
        margin-bottom: 0.5rem;
        text-shadow: 2px 2px 4px rgba(44, 90, 160, 0.1);
    }

    .cart-header p {
        font-size: 1.2rem;
        color: #666;
        max-width: 600px;
        margin: 0 auto;
    }

/* Message Styles */
.message-container {
    margin-bottom: 2rem;
}

.alert {
    border-radius: 15px;
    border: none;
    padding: 1.2rem 1.8rem;
    font-weight: 600;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
}

.alert-success {
    background: linear-gradient(45deg, #d4edda, #c3e6cb);
    color: #155724;
    border-left: 5px solid #28a745;
}

.alert-danger {
    background: linear-gradient(45deg, #f8d7da, #f1b0b7);
    color: #721c24;
    border-left: 5px solid #dc3545;
}

/* Cart Layout */
.cart-content {
    display: grid;
    grid-template-columns: 1fr 380px;
    gap: 2.5rem;
    align-items: start;
}

@media (max-width: 992px) {
    .cart-content {
        grid-template-columns: 1fr;
        gap: 2rem;
    }
}

/* Cart Items */
.cart-items {
    background: white;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
    overflow: hidden;
    border: 1px solid rgba(44, 90, 160, 0.1);
}

.cart-items-header {
    background: linear-gradient(135deg, #2c5aa0 0%, #1e3d6f 100%);
    color: white;
    padding: 1.5rem 2rem;
    font-size: 1.2rem;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.cart-item {
    padding: 2rem;
    border-bottom: 1px solid #f1f3f4;
    transition: all 0.3s ease;
    position: relative;
}

    .cart-item:hover {
        background-color: rgba(44, 90, 160, 0.02);
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(0,0,0,0.08);
    }

    .cart-item:last-child {
        border-bottom: none;
    }

.item-image {
    width: 100%;
    height: 140px;
    object-fit: cover;
    border-radius: 12px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
    transition: all 0.3s ease;
}

    .item-image:hover {
        transform: scale(1.05);
        box-shadow: 0 12px 30px rgba(0,0,0,0.2);
    }

.item-details h5 {
    color: #2c5aa0;
    font-weight: 700;
    margin-bottom: 0.8rem;
    font-size: 1.3rem;
}

.item-description {
    color: #666;
    margin-bottom: 1.2rem;
    line-height: 1.6;
    font-size: 0.95rem;
}

.travel-info {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
    background: rgba(44, 90, 160, 0.05);
    padding: 1rem;
    border-radius: 10px;
    border-left: 4px solid #2c5aa0;
}

.travel-info-item {
    display: flex;
    align-items: center;
    color: #495057;
    font-size: 0.9rem;
    font-weight: 500;
}

    .travel-info-item i {
        width: 20px;
        margin-right: 0.8rem;
        color: #2c5aa0;
        font-size: 1rem;
    }

.price-section {
    text-align: right;
    background: linear-gradient(145deg, #f8f9fa, #e9ecef);
    padding: 1.5rem;
    border-radius: 15px;
    border: 2px solid rgba(44, 90, 160, 0.1);
}

.price-per-person {
    color: #6c757d;
    font-size: 0.85rem;
    margin-bottom: 0.5rem;
    font-weight: 500;
}

.individual-price {
    color: #28a745;
    font-size: 1.2rem;
    font-weight: 700;
    margin-bottom: 0.8rem;
}

.total-price {
    color: #2c5aa0;
    font-size: 1.4rem;
    font-weight: 800;
    text-shadow: 1px 1px 2px rgba(44, 90, 160, 0.1);
}

.item-actions {
    margin-top: 1.5rem;
    display: flex;
    gap: 0.8rem;
    justify-content: flex-end;
}

.btn-edit {
    background: linear-gradient(45deg, #f8f9fa, #e9ecef);
    border: 2px solid #2c5aa0;
    color: #2c5aa0;
    padding: 0.6rem 1.2rem;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: 600;
    transition: all 0.3s ease;
    text-decoration: none;
}

    .btn-edit:hover {
        background: #2c5aa0;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(44, 90, 160, 0.3);
        text-decoration: none;
    }

.btn-remove {
    background: linear-gradient(45deg, #fff5f5, #fed7d7);
    border: 2px solid #dc3545;
    color: #dc3545;
    padding: 0.6rem 1.2rem;
    border-radius: 25px;
    font-size: 0.9rem;
    font-weight: 600;
    transition: all 0.3s ease;
    text-decoration: none;
}

    .btn-remove:hover {
        background: #dc3545;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(220, 53, 69, 0.3);
        text-decoration: none;
    }

/* Order Summary */
.order-summary {
    background: white;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
    position: sticky;
    top: 2rem;
    overflow: hidden;
    border: 1px solid rgba(44, 90, 160, 0.1);
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

.summary-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    color: #495057;
    font-weight: 500;
    padding: 0.5rem 0;
}

.summary-divider {
    border: none;
    height: 2px;
    background: linear-gradient(90deg, transparent, #2c5aa0, transparent);
    margin: 1.5rem 0;
}

.summary-total {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 1.4rem;
    font-weight: 800;
    color: #2c5aa0;
    margin-bottom: 2rem;
    padding: 1rem;
    background: linear-gradient(145deg, rgba(44, 90, 160, 0.05), rgba(44, 90, 160, 0.1));
    border-radius: 12px;
    border: 2px solid rgba(44, 90, 160, 0.2);
}

.total-amount {
    color: #28a745;
    text-shadow: 1px 1px 2px rgba(40, 167, 69, 0.1);
}

.checkout-actions {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.btn-checkout {
    background: linear-gradient(135deg, #2c5aa0 0%, #1e3d6f 100%);
    border: none;
    color: white;
    padding: 1.2rem 2rem;
    border-radius: 25px;
    font-size: 1.1rem;
    font-weight: 700;
    transition: all 0.3s ease;
    box-shadow: 0 8px 25px rgba(44, 90, 160, 0.3);
}

    .btn-checkout:hover {
        background: linear-gradient(135deg, #1e3d6f 0%, #4a90e2 100%);
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(44, 90, 160, 0.4);
        color: white;
    }

.btn-clear {
    background: white;
    border: 2px solid #6c757d;
    color: #6c757d;
    padding: 1rem 1.5rem;
    border-radius: 25px;
    font-size: 1rem;
    font-weight: 600;
    transition: all 0.3s ease;
}

    .btn-clear:hover {
        background: #6c757d;
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(108, 117, 125, 0.3);
    }

/* Empty Cart */
.empty-cart {
    text-align: center;
    padding: 4rem 2rem;
    background: white;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.1);
    border: 1px solid rgba(44, 90, 160, 0.1);
}

.empty-cart-icon {
    font-size: 5rem;
    color: rgba(44, 90, 160, 0.3);
    margin-bottom: 2rem;
    background: linear-gradient(45deg, #2c5aa0, #4a90e2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.empty-cart h3 {
    color: #2c5aa0;
    margin-bottom: 1rem;
    font-weight: 700;
    font-size: 1.8rem;
}

.empty-cart p {
    color: #666;
    margin-bottom: 2.5rem;
    font-size: 1.1rem;
    line-height: 1.6;
}

.btn-explore {
    background: linear-gradient(135deg, #2c5aa0 0%, #1e3d6f 100%);
    border: none;
    color: white;
    padding: 1.2rem 2.5rem;
    border-radius: 25px;
    font-size: 1.1rem;
    font-weight: 700;
    transition: all 0.3s ease;
    box-shadow: 0 8px 25px rgba(44, 90, 160, 0.3);
}

    .btn-explore:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(44, 90, 160, 0.4);
        color: white;
    }

/* Continue Shopping */
.continue-shopping {
    text-align: center;
    margin-top: 3rem;
}

.btn-continue {
    background: white;
    border: 2px solid #2c5aa0;
    color: #2c5aa0;
    padding: 1rem 2rem;
    border-radius: 25px;
    font-weight: 600;
    font-size: 1rem;
    transition: all 0.3s ease;
    text-decoration: none;
    box-shadow: 0 4px 15px rgba(44, 90, 160, 0.1);
}

    .btn-continue:hover {
        background: #2c5aa0;
        color: white;
        text-decoration: none;
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(44, 90, 160, 0.3);
    }

/* Enhanced Visual Effects */
.cart-item::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 4px;
    height: 100%;
    background: linear-gradient(135deg, #2c5aa0, #4a90e2);
    opacity: 0;
    transition: opacity 0.3s ease;
}

.cart-item:hover::before {
    opacity: 1;
}

/* Responsive Design */
@media (max-width: 768px) {
    .cart-container {
        padding: 1rem;
    }

    .cart-header h1 {
        font-size: 2.2rem;
    }

    .cart-header p {
        font-size: 1rem;
    }

    .cart-item {
        padding: 1.5rem;
    }

    .item-actions {
        justify-content: center;
        flex-wrap: wrap;
    }

    .price-section {
        text-align: center;
        margin-top: 1.5rem;
    }

    .travel-info {
        padding: 0.8rem;
    }

    .summary-body {
        padding: 1.5rem;
    }

    .btn-checkout, .btn-explore {
        padding: 1rem 1.5rem;
        font-size: 1rem;
    }
}

@media (max-width: 480px) {
    .cart-header h1 {
        font-size: 1.8rem;
    }

    .item-actions {
        flex-direction: column;
        align-items: center;
    }

    .btn-edit, .btn-remove {
        width: 100%;
        text-align: center;
        margin-bottom: 0.5rem;
    }

    .checkout-actions {
        gap: 0.8rem;
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