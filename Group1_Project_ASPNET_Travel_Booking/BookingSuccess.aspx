<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BookingSuccess.aspx.cs" Inherits="Group1_Project_ASPNET_Travel_Booking.BookingSuccess" MasterPageFile="~/Site1.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Success Hero Section -->
    <section class="success-hero">
        <div class="success-animation">
            <div class="checkmark-circle">
                <div class="checkmark"></div>
            </div>
        </div>
        <div class="container">
            <div class="success-content text-center">
                <h1 class="success-title">Booking Confirmed!</h1>
                <p class="success-subtitle">Your amazing journey awaits! We've sent confirmation details to your email.</p>
                <div class="professional-badges">
                    <div class="success-badge">
                        <span class="badge-text">Confirmed</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    

    <!-- Booking Details Section -->
    <section class="booking-details-section">
        <div class="container">
            <asp:Panel ID="pnlBooking" runat="server" CssClass="booking-card">
                <div class="booking-header">
                    <div class="booking-header-content">
                        <h3 class="booking-title">Your Booking Summary</h3>
                        <div class="booking-id-badge">
                            <span class="booking-id-label">Booking ID</span>
                            <asp:Label ID="lblBookingID" runat="server" CssClass="booking-id-value" />
                        </div>
                    </div>
                </div>

                <div class="booking-body">
                    <div class="booking-details-grid">
                        <!-- Destination Card -->
                        <div class="detail-card destination-card">
                            <div class="detail-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
                                </svg>
                            </div>
                            <div class="detail-content">
                                <h5 class="detail-title">Destination</h5>
                                <asp:Label ID="lblDestination" runat="server" CssClass="detail-value" />
                            </div>
                        </div>

                        <!-- Travelers Card -->
                        <div class="detail-card travelers-card">
                            <div class="detail-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M16 4c0-1.11.89-2 2-2s2 .89 2 2-.89 2-2 2-2-.89-2-2zm4 18v-6h2.5l-2.54-7.63A2.996 2.996 0 0 0 17.09 7h-2.18c-1.3 0-2.52.84-2.93 2.08L9 15.5v.5h2v6h2v-6h2v6h3zm-12.5-11c.83 0 1.5-.67 1.5-1.5S8.33 8 7.5 8 6 8.67 6 9.5 6.67 11 7.5 11zm1.5 1h-3C4.67 12 4 12.67 4 14v4h2v6h3v-6h2v-4c0-1.33-.67-2-2-2z"/>
                                </svg>
                            </div>
                            <div class="detail-content">
                                <h5 class="detail-title">Travelers</h5>
                                <asp:Label ID="lblTravelers" runat="server" CssClass="detail-value" />
                            </div>
                        </div>

                        <!-- Amount Card -->
                        <div class="detail-card amount-card">
                            <div class="detail-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M11.8 10.9c-2.27-.59-3-1.2-3-2.15 0-1.09 1.01-1.85 2.7-1.85 1.78 0 2.44.85 2.5 2.1h2.21c-.07-1.72-1.12-3.3-3.21-3.81V3h-3v2.16c-1.94.42-3.5 1.68-3.5 3.61 0 2.31 1.91 3.46 4.7 4.13 2.5.6 3 1.48 3 2.41 0 .69-.49 1.79-2.7 1.79-2.06 0-2.87-.92-2.98-2.1h-2.2c.12 2.19 1.76 3.42 3.68 3.83V21h3v-2.15c1.95-.37 3.5-1.5 3.5-3.55 0-2.84-2.43-3.81-4.7-4.4z"/>
                                </svg>
                            </div>
                            <div class="detail-content">
                                <h5 class="detail-title">Total Amount</h5>
                                <asp:Label ID="lblAmount" runat="server" CssClass="detail-value amount-value" />
                            </div>
                        </div>

                        <!-- Payment Card -->
                        <div class="detail-card payment-card">
                            <div class="detail-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"/>
                                </svg>
                            </div>
                            <div class="detail-content">
                                <h5 class="detail-title">Payment Method</h5>
                                <asp:Label ID="lblPayment" runat="server" CssClass="detail-value" />
                            </div>
                        </div>

                        <!-- Date Card -->
                        <div class="detail-card date-card">
                            <div class="detail-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"/>
                                </svg>
                            </div>
                            <div class="detail-content">
                                <h5 class="detail-title">Booking Date</h5>
                                <asp:Label ID="lblDate" runat="server" CssClass="detail-value" />
                            </div>
                        </div>

                        <!-- Status Card -->
                        <div class="detail-card status-card">
                            <div class="detail-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
                                </svg>
                            </div>
                            <div class="detail-content">
                                <h5 class="detail-title">Status</h5>
                                <asp:Label ID="lblStatus" runat="server" CssClass="status-badge" />
                            </div>
                        </div>
                    </div>

                    <!-- Address Section -->
                    <div class="address-section">
                        <div class="address-card">
                            <div class="address-icon">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/>
                                </svg>
                            </div>
                            <div class="address-content">
                                <h5 class="address-title">Billing Address</h5>
                                <asp:Label ID="lblAddress" runat="server" CssClass="address-value" />
                            </div>
                        </div>
                    </div>

                    <!-- Next Steps Section -->
                    <div class="next-steps-section">
                        <div class="next-steps-header">
                            <h4 class="next-steps-title">What's Next?</h4>
                        </div>
                        <div class="steps-grid">
                            <div class="step-item">
                                <div class="step-number">1</div>
                                <div class="step-content">
                                    <h6>Confirmation Email</h6>
                                    <p>Check your email for detailed booking information and e-tickets.</p>
                                </div>
                            </div>
                            <div class="step-item">
                                <div class="step-number">2</div>
                                <div class="step-content">
                                    <h6>Prepare Documents</h6>
                                    <p>Ensure your travel documents are ready and valid for your destination.</p>
                                </div>
                            </div>
                            <div class="step-item">
                                <div class="step-number">3</div>
                                <div class="step-content">
                                    <h6>Pack & Enjoy</h6>
                                    <p>Start packing and get ready for your amazing adventure!</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="booking-footer">
                    <div class="footer-actions">
                        <a href="<%= ResolveUrl("~/Travel/Default") %>" class="btn btn-home">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor" class="btn-icon">
                                <path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/>
                            </svg>
                            Return to Home
                        </a>
                     
                    </div>
                    <div class="support-info">
                        <p class="support-text">Need help? Contact our support team at <strong>support@flyora.com</strong></p>
                    </div>
                </div>
            </asp:Panel>

            <asp:Label ID="lblError" runat="server" CssClass="error-message" Visible="false" />
        </div>
    </section>

    <!-- Additional CSS for this page -->
    <style>
        /* Success Hero Section */
        .success-hero {
            background: linear-gradient(135deg, #2c5aa0 0%, #1e3d6f 100%);
            color: white;
            padding: 80px 0 60px 0;
            position: relative;
            overflow: hidden;
            text-align: center;
        }

        .success-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" fill="rgba(255,255,255,0.1)"><polygon points="0,0 1000,0 1000,100 0,80"/></svg>');
            background-size: cover;
        }

        .success-animation {
            position: relative;
            z-index: 2;
            margin-bottom: 2rem;
        }

        .checkmark-circle {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border: 3px solid rgba(255, 255, 255, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            animation: pulse 2s infinite;
        }

        .checkmark {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: #28a745;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
        }

        .checkmark::after {
            content: '✓';
            color: white;
            font-size: 2rem;
            font-weight: bold;
            animation: checkmarkDraw 1s ease-in-out;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        @keyframes checkmarkDraw {
            0% { transform: scale(0) rotate(180deg); opacity: 0; }
            100% { transform: scale(1) rotate(0deg); opacity: 1; }
        }

        .success-content {
            position: relative;
            z-index: 2;
        }

        .success-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            background: linear-gradient(45deg, #fff, #e3f2fd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .success-subtitle {
            font-size: 1.3rem;
            margin-bottom: 2rem;
            opacity: 0.95;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        .professional-badges {
            display: flex;
            justify-content: center;
            margin-top: 1rem;
        }

        .success-badge {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border-radius: 50px;
            padding: 0.8rem 2rem;
            border: 2px solid rgba(255, 255, 255, 0.3);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .badge-text {
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Booking Details Section */
        .booking-details-section {
            padding: 60px 0;
            background: linear-gradient(135deg, #f8fafc 0%, #e3f2fd 100%);
            min-height: 60vh;
        }

        .booking-card {
            background: white;
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.1);
            overflow: hidden;
            max-width: 1000px;
            margin: 0 auto;
        }

        .booking-header {
            background: linear-gradient(135deg, #2c5aa0, #4a90e2);
            color: white;
            padding: 2.5rem;
        }

        .booking-header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .booking-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin: 0;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }

        .booking-id-badge {
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            border-radius: 50px;
            padding: 0.8rem 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .booking-id-label {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-right: 0.5rem;
        }

        .booking-id-value {
            font-weight: 700;
            font-size: 1.1rem;
        }

        .booking-body {
            padding: 2.5rem;
        }

        /* Details Grid */
        .booking-details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2.5rem;
        }

        .detail-card {
            background: linear-gradient(135deg, #f8fafc, #ffffff);
            border-radius: 15px;
            padding: 1.5rem;
            border: 1px solid rgba(44, 90, 160, 0.1);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .detail-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(44, 90, 160, 0.1);
            border-color: rgba(44, 90, 160, 0.2);
        }

        .detail-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2c5aa0, #4a90e2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            flex-shrink: 0;
            box-shadow: 0 8px 25px rgba(44, 90, 160, 0.2);
        }

        .detail-icon svg {
            width: 24px;
            height: 24px;
        }

        .detail-content {
            flex: 1;
        }

        .detail-title {
            font-size: 0.9rem;
            color: #666;
            margin: 0 0 0.3rem 0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }

        .detail-value {
            font-size: 1.2rem;
            font-weight: 700;
            color: #2c5aa0;
            margin: 0;
        }

        .amount-value {
            font-size: 1.5rem;
            color: #28a745;
        }

        .status-badge {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }

        /* Address Section */
        .address-section {
            margin-bottom: 2.5rem;
        }

        .address-card {
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            border-radius: 15px;
            padding: 2rem;
            display: flex;
            align-items: flex-start;
            gap: 1rem;
            border: 1px solid rgba(44, 90, 160, 0.1);
        }

        .address-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2c5aa0, #4a90e2);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            flex-shrink: 0;
            box-shadow: 0 8px 25px rgba(44, 90, 160, 0.2);
        }

        .address-icon svg {
            width: 24px;
            height: 24px;
        }

        .address-title {
            font-size: 1rem;
            color: #2c5aa0;
            margin: 0 0 0.5rem 0;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .address-value {
            font-size: 1.1rem;
            color: #333;
            line-height: 1.6;
            margin: 0;
        }

        /* Next Steps Section */
        .next-steps-section {
            background: linear-gradient(135deg, #f8fafc, #e8f4f8);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .next-steps-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .next-steps-title {
            font-size: 1.5rem;
            color: #2c5aa0;
            font-weight: 700;
            margin: 0;
        }

        .steps-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .step-item {
            display: flex;
            gap: 1rem;
            align-items: flex-start;
        }

        .step-number {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2c5aa0, #4a90e2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            flex-shrink: 0;
            box-shadow: 0 6px 20px rgba(44, 90, 160, 0.3);
        }

        .step-content h6 {
            font-size: 1rem;
            color: #2c5aa0;
            margin: 0 0 0.3rem 0;
            font-weight: 700;
        }

        .step-content p {
            font-size: 0.9rem;
            color: #666;
            margin: 0;
            line-height: 1.5;
        }

        /* Footer Section */
        .booking-footer {
            background: linear-gradient(135deg, #f8fafc, #e9ecef);
            padding: 2rem 2.5rem;
            border-top: 1px solid #e2e8f0;
        }

        .footer-actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .btn {
            padding: 0.8rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
            font-size: 1rem;
        }

        .btn-home {
            background: linear-gradient(135deg, #2c5aa0, #4a90e2);
            color: white;
            box-shadow: 0 8px 25px rgba(44, 90, 160, 0.3);
        }

        .btn-home:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(44, 90, 160, 0.4);
            color: white;
            text-decoration: none;
        }

        .btn-print {
            background: linear-gradient(135deg, #6c757d, #5a6268);
            color: white;
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
        }

        .btn-print:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(108, 117, 125, 0.4);
        }

        .btn-icon {
            width: 20px;
            height: 20px;
        }

        .support-info {
            text-align: center;
        }

        .support-text {
            color: #666;
            margin: 0;
            font-size: 0.95rem;
        }

        /* Error Message */
        .error-message {
            background: linear-gradient(135deg, #f8d7da, #f1b0b7);
            color: #721c24;
            border: none;
            border-radius: 15px;
            padding: 1.5rem;
            margin-top: 2rem;
            text-align: center;
            font-weight: 600;
            box-shadow: 0 10px 30px rgba(220, 53, 69, 0.2);
            border-left: 5px solid #dc3545;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .success-title {
                font-size: 2.5rem;
            }

            .success-subtitle {
                font-size: 1.1rem;
            }

            .booking-header-content {
                flex-direction: column;
                text-align: center;
            }

            .booking-body {
                padding: 1.5rem;
            }

            .booking-details-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .detail-card {
                padding: 1rem;
            }

            .address-card {
                padding: 1.5rem;
            }

            .next-steps-section {
                padding: 1.5rem;
            }

            .steps-grid {
                grid-template-columns: 1fr;
            }

            .booking-footer {
                padding: 1.5rem;
            }

            .footer-actions {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }

            .professional-badges {
                margin-top: 1rem;
            }

            .success-badge {
                padding: 0.6rem 1.5rem;
            }

            .badge-text {
                font-size: 1rem;
            }
        }

        @media (max-width: 480px) {
            .success-hero {
                padding: 60px 0 40px 0;
            }

            .success-title {
                font-size: 2rem;
            }

            .checkmark-circle {
                width: 100px;
                height: 100px;
            }

            .checkmark {
                width: 50px;
                height: 50px;
            }

            .checkmark::after {
                font-size: 1.5rem;
            }

            .booking-details-section {
                padding: 40px 0;
            }
        }

        /* Print Styles */
        @media print {
            .success-hero,
            .booking-footer,
            .next-steps-section {
                display: none !important;
            }

            .booking-card {
                box-shadow: none;
                border: 1px solid #ddd;
            }

            .detail-card {
                break-inside: avoid;
                box-shadow: none;
                border: 1px solid #eee;
            }
        }
    </style>
</asp:Content>