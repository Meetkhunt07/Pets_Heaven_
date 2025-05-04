<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Medical.aspx.cs" Inherits="Pets_Heaven_.Medical" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Medical Products - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    
    <!-- Fonts and SweetAlert2 -->
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

        .navbar {
            background-color: #16a085;
            padding: 0.6rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .navbar h1 {
            color: white;
            font-size: 22px;
            margin: 0;
        }

        .menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 26px;
            color: white;
            cursor: pointer;
        }

        .links {
            display: flex;
            gap: 12px;
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

        @media screen and (max-width: 768px) {
            .menu-toggle { display: block; }

            .links {
                display: none;
                flex-direction: column;
                width: 100%;
                margin-top: 10px;
            }

            .links a {
                width: 100%;
                padding: 12px;
                background-color: #14876d;
            }

            .links.show { display: flex; }
        }

        .main-title {
            text-align: center;
            font-size: 2rem;
            margin: 2rem 0 1.5rem;
        }

        .search-bar {
            text-align: center;
            margin-bottom: 30px;
        }

        .search-box {
            padding: 10px;
            width: 250px;
            max-width: 90%;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .btn-buy {
            padding: 10px 16px;
            background-color: #16a085;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 6px;
            margin-left: 10px;
        }

        .btn-buy:hover {
            background-color: #138f75;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            padding: 0 2rem 4rem 2rem;
            max-width: 1200px;
            margin: auto;
        }

        .card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 16px rgba(0,0,0,0.12);
            text-align: center;
            padding: 2rem;
        }

        .card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .card h3 {
            margin: 0.5rem 0;
            font-size: 20px;
        }

        .card p {
            margin: 0.3rem 0;
        }

        .card .price {
            font-weight: bold;
        }

        .pagination {
            text-align: center;
            margin: 40px 0;
        }

        .pagination a {
            display: inline-block;
            background-color: #16a085;
            color: white;
            padding: 8px 14px;
            margin: 4px;
            border-radius: 6px;
            text-decoration: none;
        }

        .pagination a:hover {
            background-color: #138f75;
        }

        .pagination a.current {
            background-color: black;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- NAVIGATION -->
        <div class="navbar">
            <h1>🐾 Pets Heaven</h1>
            <button class="menu-toggle" type="button" onclick="toggleMenu()">☰</button>
            <div class="links" id="navLinks">
                <a href="Home_page.aspx">🏠 Home</a>
                <a href="About.aspx">ℹ️ About</a>
                <a href="Pets.aspx">🐶 Pets</a>
                <a href="Accessories.aspx">🦴 Accessories</a>
                <a href="Clothing.aspx">👕 Clothing</a>
                <a href="Medical.aspx" class="active">🩺 Medical</a>
                <a href="Services.aspx">💼 Services</a>
                <a href="Contact.aspx">📞 Contact</a>
                <a href="Cart.aspx">🛒 Cart</a>
                <a href="Profile.aspx">👤 Profile</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- PAGE TITLE -->
        <h2 class="main-title">Medical Products for Pets</h2>

        <!-- SEARCH -->
        <div class="search-bar">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search medical items..." />
            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-buy" OnClick="btnSearch_Click" />
        </div>

        <!-- PRODUCT CARDS -->
        <div class="card-container">
            <asp:Repeater ID="rptMedical" runat="server">
                <ItemTemplate>
                    <div class="card">
                        <img src='<%# ResolveUrl(Convert.ToString(Eval("ImageURL"))) %>' alt="Medical Item" />
                        <h3><%# Eval("ProductName") %></h3>
                        <p><%# Eval("Description") %></p>
                        <p class="price">Price: ₹<%# Eval("Price", "{0:N2}") %></p>
                        <asp:Button ID="btnAddToCart" runat="server" CssClass="btn-buy" Text="Add to cart"
                            CommandArgument='<%# Eval("ProductID") %>' OnCommand="btnAddToCart_Command" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- PAGINATION -->
        <div class="pagination">
            <asp:Literal ID="litPaging" runat="server" />
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
    </form>

    <script>
        function toggleMenu() {
            document.getElementById("navLinks").classList.toggle("show");
        }
    </script>
</body>
</html>
