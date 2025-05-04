<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageContactUs.aspx.cs" Inherits="Pets_Heaven_.ManageContactUs" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Contact Us - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        /* ✅ Your Original CSS (unchanged) */
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
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
            color: white;
        }

        .search-bar {
            margin-bottom: 20px;
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

            .btn-search:hover {
                background-color: #222;
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

        .btn-delete {
            background-color: crimson;
            color: white;
            border: none;
            padding: 6px 14px;
            border-radius: 5px;
            cursor: pointer;
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

        <!-- NAVIGATION BAR -->
        <div class="navbar">
            <div class="navbar-title">👨‍💻 Pets Heaven Admin</div>
            <button type="button" class="nav-toggle" onclick="toggleMenu()">☰</button>
            <div class="nav-links" id="navLinks">
                <a href="Dashboard.aspx">📊 Dashboard</a>
                <a href="ManagePets.aspx">🐶 Pets</a>
                <a href="ManageAccessories.aspx">🦴 Accessories</a>
                <a href="ManageClothing.aspx">👕 Clothing</a>
                <a href="ManageMedical.aspx">🩺 Medical</a>
                <a href="ManageOrders.aspx">🧾 Orders</a>
                <a href="Manage_User.aspx">👥 Users</a>
                <a href="ManageContactUs.aspx" class="active">📩 Contact</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- MAIN CONTENT -->
        <div class="container">
            <h2>Manage Contact Queries</h2>

            <div class="search-bar">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name or email..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <asp:GridView ID="gvContactUs" runat="server" AutoGenerateColumns="False" CssClass="grid"
                DataKeyNames="ContactID"
                OnRowDeleting="gvContactUs_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ContactID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Message" HeaderText="Message" />
                    <asp:BoundField DataField="SubmittedDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:CommandField ShowDeleteButton="True" DeleteText="Delete" ButtonType="Button" ControlStyle-CssClass="btn-delete" />
                </Columns>
            </asp:GridView>
        </div>

        <asp:Literal ID="litScript" runat="server" />

        <!-- FOOTER -->
        <div class="footer">
            <p>© 2025 Pets Heaven Admin Panel. All rights reserved.</p>
        </div>

    </form>
</body>
</html>
