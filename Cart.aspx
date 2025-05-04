<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="Pets_Heaven_.Cart" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Your Cart - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        * { box-sizing: border-box; }

        body {
            font-family: 'Quicksand', sans-serif;
            background-color: #f4f8f4;
            margin: 0;
            padding: 0;
            color: black;
        }

        /* NAVIGATION BAR */
        .navbar {
            background-color: #16a085;
            padding: 0.6rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            position: relative;
        }

        .navbar h1 {
            margin: 0;
            color: white;
            font-size: 22px;
        }

        .menu-toggle {
            display: none;
            font-size: 26px;
            background: none;
            border: none;
            color: white;
            cursor: pointer;
        }

        .links {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-weight: bold;
        }

        .navbar a:hover {
            background-color: #138f75;
        }

        .navbar a.active {
            background-color: white;
            color: #16a085;
        }

        /* MAIN CONTAINER */
        .container {
            max-width: 1100px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
            display: flex;
            flex-wrap: wrap;
            gap: 40px;
        }

        .left-section, .right-section {
            flex: 1 1 45%;
        }

        h2 {
            text-align: center;
            color: #16a085;
            font-size: 1.8rem;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 10px;
        }

        .input-box {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }

        .btn {
            padding: 8px 16px;
            background-color: #16a085;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 8px;
        }

        .btn:hover {
            background-color: #138f75;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .cart-table th, .cart-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        .cart-table th {
            background-color: #16a085;
            color: white;
        }

        .qty-box {
            display: inline-block;
            padding: 6px 12px;
            background-color: #eee;
            border-radius: 6px;
            min-width: 40px;
        }

        .total {
            text-align: right;
            font-size: 1.2rem;
            margin-top: 20px;
            font-weight: bold;
        }

        .process-btn {
            width: 100%;
            padding: 14px;
            background-color: #16a085;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 20px;
        }

        .process-btn:hover {
            background-color: #138f75;
        }

        .footer {
            background-color: #16a085;
            color: white;
            padding: 2rem;
            text-align: center;
            margin-top: 60px;
        }

        .footer hr {
            margin: 1.5rem auto;
            width: 80%;
            border-color: rgba(255, 255, 255, 0.2);
        }

        /* RESPONSIVE */
        @media screen and (max-width: 768px) {
            .menu-toggle {
                display: block;
            }

            .links {
                display: none;
                flex-direction: column;
                width: 100%;
                margin-top: 10px;
            }

                .links.show {
                    display: flex;
                }

                .links a {
                    width: 100%;
                    padding: 12px;
                    background-color: #14876d;
                    font-size: 14px;
                }

            .contact-container {
                margin: 30px 15px;
                padding: 20px;
            }

                .contact-container h2 {
                    font-size: 1.6rem;
                }

            .btn-submit {
                font-size: 0.95rem;
                padding: 10px 20px;
            }
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- NAVIGATION BAR -->
        <div class="navbar">
            <h1>🐾 Pets Heaven</h1>
            <button class="menu-toggle" type="button" onclick="toggleMenu()">☰</button>
            <div class="links" id="navLinks">
                <a href="Home_page.aspx">🏠 Home</a>
                <a href="About.aspx">ℹ️ About</a>
                <a href="Pets.aspx">🐶 Pets</a>
                <a href="Accessories.aspx">🦴 Accessories</a>
                <a href="Clothing.aspx">👕 Clothing</a>
                <a href="Medical.aspx">🩺 Medical</a>
                <a href="Services.aspx">💼 Services</a>
                <a href="Contact.aspx">📞 Contact</a>
                <a href="Cart.aspx" class="active">🛒 Cart</a>
                <a href="Profile.aspx">👤 Profile</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- CART CONTAINER -->
        <div class="container">
            <!-- USER SECTION -->
            <div class="left-section">
                <h2>User Details</h2>

                <label>Full Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="input-box" ReadOnly="true" />

                <label>Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input-box" ReadOnly="true" />

                <label>Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="input-box" TextMode="MultiLine" Rows="3" />
                <asp:Button ID="btnUpdateAddress" runat="server" Text="Update Address" CssClass="btn" OnClick="btnUpdateAddress_Click" />

                <label>Payment Method:</label>
                <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="input-box">
                    <asp:ListItem Text="Cash" Value="Cash" />
                    <asp:ListItem Text="Online" Value="Online" />
                </asp:DropDownList>
            </div>

            <!-- CART SECTION -->
            <div class="right-section">
                <h2>Your Cart</h2>

                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" CssClass="cart-table" OnRowCommand="gvCart_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹{0:N2}" />
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:Button ID="btnDec" runat="server" CommandName="DecreaseQty" CommandArgument='<%# Eval("CartID") %>' Text="−" CssClass="btn" />
                                <span class="qty-box"><%# Eval("Quantity") %></span>
                                <asp:Button ID="btnInc" runat="server" CommandName="IncreaseQty" CommandArgument='<%# Eval("CartID") %>' Text="+" CssClass="btn" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Subtotal">
                            <ItemTemplate>
                                ₹<%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Remove">
                            <ItemTemplate>
                                <asp:Button ID="btnRemove" runat="server" CommandName="RemoveItem" CommandArgument='<%# Eval("CartID") %>' Text="Remove" CssClass="btn" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <asp:Label ID="lblTotal" runat="server" CssClass="total" />
                <asp:Button ID="btnCheckout" runat="server" Text="Process to Order" CssClass="process-btn" OnClick="btnCheckout_Click" />
            </div>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <h4>Contact Us</h4>
            <p>📍 123 Pet Street, Surat, Gujarat, India</p>
            <p>📞 +91 98765 43210</p>
            <p>📧 petsheaven41@gmail.com</p>
            <hr />
            <p>© 2025 Pets Heaven. All rights reserved.</p>
        </div>

        <!-- JS for Mobile Navigation Toggle -->
        <script>
            function toggleMenu() {
                document.getElementById("navLinks").classList.toggle("show");
            }
        </script>
    </form>
</body>
</html>
