<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Insert_Products.aspx.cs" Inherits="Pets_Heaven_.Insert_Products" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Insert Product - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Quicksand', sans-serif;
            background-color: #ffffff;
            color: #212f3d;
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
        }

        .nav-links a.active {
            background-color: white;
            color: black !important;
        }

        .nav-links a:hover:not(.active) {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px 20px;
            background-color: #f2f2f2;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        }

        h2 {
            text-align: center;
            color: black;
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        .input-box {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 10px;
            font-size: 16px;
        }

        .btn {
            background-color: black;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #333;
        }

        .footer {
            background-color: #000;
            color: white;
            text-align: center;
            padding: 1.2rem;
            margin-top: auto;
        }

        .validation {
            color: red;
            font-size: 13px;
            margin-bottom: 10px;
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
        <!-- NAVIGATION -->
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
                <a href="ManageContactUs.aspx">📩 Contact</a>
                <a href="Insert_Products.aspx" class="active">➕ Insert</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- CONTENT -->
        <div class="container">
            <h2>Add New Product</h2>

            <label>Product Name</label>
            <asp:TextBox ID="txtName" runat="server" CssClass="input-box" />
            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />

            <label>Description</label>
            <asp:TextBox ID="txtDesc" runat="server" CssClass="input-box" TextMode="MultiLine" Rows="3" />
            <asp:RequiredFieldValidator ID="rfvDesc" runat="server" ControlToValidate="txtDesc"
                ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />

            <label>Price</label>
            <asp:TextBox ID="txtPrice" runat="server" CssClass="input-box" />
            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice"
                ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />

            <label>Stock Quantity</label>
            <asp:TextBox ID="txtStock" runat="server" CssClass="input-box" />
            <asp:RequiredFieldValidator ID="rfvStock" runat="server" ControlToValidate="txtStock"
                ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />

            <label>Image Upload</label>
            <asp:FileUpload ID="fuImage" runat="server" CssClass="input-box" />
            <asp:CustomValidator ID="cvImage" runat="server" CssClass="validation" OnServerValidate="cvImage_ServerValidate"
                ErrorMessage="Only JPG, PNG, JPEG images are allowed." Display="Dynamic" />

            <asp:Button ID="btnInsert" runat="server" Text="Insert Product" CssClass="btn" OnClick="btnInsert_Click" />
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <p>© 2025 Pets Heaven Admin Panel. All rights reserved.</p>
        </div>
        <asp:Literal ID="litScript" runat="server" />
    </form>
</body>
</html>
