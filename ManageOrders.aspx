<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageOrders.aspx.cs" Inherits="Pets_Heaven_.ManageOrders" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Orders - Pets Heaven Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        /* ✅ All your original CSS unchanged */
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Quicksand', sans-serif;
            background-color: #ffffff;
            color: black;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        form {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            background-color: #000;
            padding: 1rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .navbar-title {
            font-weight: bold;
            font-size: 20px;
            color: white;
        }

        .nav-toggle {
            display: none;
            font-size: 24px;
            background: none;
            border: none;
            color: white;
            cursor: pointer;
        }

        .nav-links {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

            .nav-links a {
                color: white;
                text-decoration: none;
                font-weight: 600;
                padding: 6px 12px;
                border-radius: 6px;
                font-size: 15px;
            }

                .nav-links a.active {
                    background-color: white;
                    color: black !important;
                }

                .nav-links a:hover:not(.active) {
                    background-color: rgba(255, 255, 255, 0.1);
                }

        .container {
            width: 90%;
            margin: 40px auto;
            padding: 30px 20px;
            background-color: #2c3e50;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
            color: #212f3d;
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
            color: white;
        }

        .search-bar {
            margin-bottom: 20px;
            text-align: left;
        }

            .search-bar input[type="text"] {
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                font-size: 14px;
                width: 260px;
            }

        .btn-search {
            background-color: black;
            color: white;
            border: none;
            padding: 10px 24px;
            font-size: 16px;
            border-radius: 6px;
            margin-left: 10px;
            cursor: pointer;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            color: #212f3d;
        }

            .grid th, .grid td {
                border: 1px solid #000;
                padding: 10px;
                text-align: center;
            }

            .grid th {
                background-color: #000;
                color: white;
            }

        .btn-delete, .btn-edit {
            text-decoration: none;
            padding: 6px 14px;
            border-radius: 5px;
            cursor: pointer;
        }

        .btn-delete {
            background-color: crimson;
            color: white;
            border: none;
        }

        .btn-edit {
            background-color: black;
            color: white;
            border: none;
        }

        .footer {
            background-color: #000;
            color: white;
            padding: 1rem;
            text-align: center;
            font-size: 14px;
            margin-top: auto;
        }

        @media screen and (max-width: 768px) {
            .nav-toggle {
                display: block;
            }

            .nav-links {
                flex-direction: column;
                display: none;
                width: 100%;
                margin-top: 10px;
            }

                .nav-links.show {
                    display: flex;
                }
        }
    </style>
    <script type="text/javascript">
        function toggleMenu() {
            document.getElementById("navLinks").classList.toggle("show");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <div class="navbar-title">👨‍💻 Pets Heaven Admin</div>
            <button type="button" class="nav-toggle" onclick="toggleMenu()">☰</button>
            <div class="nav-links" id="navLinks">
                <a href="Dashboard.aspx">📊 Dashboard</a>
                <a href="ManagePets.aspx">🐶 Pets</a>
                <a href="ManageAccessories.aspx">🦴 Accessories</a>
                <a href="ManageClothing.aspx">👕 Clothing</a>
                <a href="ManageMedical.aspx">🩺 Medical</a>
                <a href="ManageOrders.aspx" class="active">🧾 Orders</a>
                <a href="Manage_User.aspx">👥 Users</a>
                <a href="ManageContactUs.aspx">📩 Contact</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <div class="container">
            <h2>Manage Orders</h2>
            <div class="search-bar">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by customer name or order ID..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" CssClass="grid"
                DataKeyNames="OrderID"
                OnRowEditing="gvOrders_RowEditing"
                OnRowCancelingEdit="gvOrders_RowCancelingEdit"
                OnRowUpdating="gvOrders_RowUpdating"
                OnRowDeleting="gvOrders_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="OrderID" HeaderText="Order ID" ReadOnly="true" />
                    <asp:BoundField DataField="FullName" HeaderText="Customer Name" ReadOnly="true" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" DataFormatString="₹{0:N2}" ReadOnly="true" />
                    <asp:TemplateField HeaderText="Payment">
                        <ItemTemplate><%# Eval("PaymentMethod") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlPaymentMethod" runat="server">
                                <asp:ListItem Text="Cash" Value="Cash" />
                                <asp:ListItem Text="Online" Value="Online" />
                            </asp:DropDownList>
                            <asp:HiddenField ID="hdnPayment" runat="server" Value='<%# Bind("PaymentMethod") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate><%# Eval("OrderStatus") %></ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server">
                                <asp:ListItem Text="Pending" />
                                <asp:ListItem Text="Shipped" />
                                <asp:ListItem Text="Delivered" />
                            </asp:DropDownList>
                            <asp:HiddenField ID="hdnStatus" runat="server" Value='<%# Bind("OrderStatus") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="OrderDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" ReadOnly="true" />
                    <asp:CommandField ShowEditButton="True" EditText="Edit" ControlStyle-CssClass="btn-edit"
                        ShowDeleteButton="True" DeleteText="Delete"  />
                </Columns>
            </asp:GridView>
        </div>

        <!-- ✅ Alert Literal for backend SweetAlert injection -->
        <asp:Literal ID="litScript" runat="server" />

        <div class="footer">
            <p>© 2025 Pets Heaven Admin Panel. All rights reserved.</p>
        </div>
    </form>
</body>
</html>
