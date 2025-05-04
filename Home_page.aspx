    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home_page.aspx.cs" Inherits="Pets_Heaven_.Home_page" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Quicksand', sans-serif;
            background-color: #f4f8f4;
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
            .menu-toggle {
                display: block;
            }

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

            .links.show {
                display: flex;
            }
        }

        .hero {
            text-align: center;
            padding: 80px 20px;
            background-color: #e0f8f4;
        }

        .hero h2 {
            font-size: 36px;
            margin-bottom: 15px;
        }

        .hero p {
            font-size: 18px;
            margin-bottom: 30px;
        }

        .btn-adopt {
            padding: 12px 24px;
            font-size: 16px;
            background-color: #16a085;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .btn-adopt:hover {
            background-color: #138f75;
        }

        .section {
            padding: 40px 20px;
            text-align: center;
        }

        .section h3 {
            font-size: 28px;
            margin-bottom: 30px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* Two cards per row */
            gap: 20px;
            max-width: 800px;
            margin: auto;
        }

        @media screen and (max-width: 600px) {
            .grid {
                grid-template-columns: 1fr; /* One card per row on mobile */
            }
        }

        .card {
            background-color: white;
            padding: 30px 20px;
            border-radius: 16px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
            text-align: center;
        }

        .card h4 {
            margin: 14px 0;
            font-size: 20px;
        }

        .card p {
            font-size: 15px;
            margin-bottom: 16px;
        }

        .card .btn {
            padding: 10px 20px;
            font-size: 15px;
            background-color: #16a085;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .card .btn:hover {
            background-color: #138f75;
        }

        .footer {
            background-color: #16a085;
            padding: 25px 20px;
            text-align: center;
            color: white;
            font-size: 14px;
            margin-top: 50px;
        }

        .footer p {
            margin: 6px 0;
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
                <a href="Home_page.aspx" class="active">🏠 Home</a>
                <a href="About.aspx">ℹ️ About</a>
                <a href="Pets.aspx">🐶 Pets</a>
                <a href="Accessories.aspx">🦴 Accessories</a>
                <a href="Clothing.aspx">👕 Clothing</a>
                <a href="Medical.aspx">🩺 Medical</a>
                <a href="Services.aspx">💼 Services</a>
                <a href="Contact.aspx">📞 Contact</a>
                <a href="Cart.aspx">🛒 Cart</a>
                <a href="Profile.aspx">👤 Profile</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- HERO SECTION -->
        <div class="hero">
            <h2>Welcome to Pets Heaven</h2>
            <p>Find your perfect furry companion and give them a loving forever home.</p>
            <button class="btn-adopt" type="button" onclick="location.href='Pets.aspx'">Adopt Now</button>
        </div>

        <!-- CATEGORY SECTION -->
        <div class="section">
            <h3>Explore Categories</h3>
            <div class="grid">
                <div class="card">
                    <h4>🐶 Pets</h4>
                    <p>View our adorable pets available for you.</p>
                    <button class="btn" type="button" onclick="location.href='Pets.aspx'">Explore</button>
                </div>
                <div class="card">
                    <h4>🦴 Accessories</h4>
                    <p>All accessories your pet needs.</p>
                    <button class="btn" type="button" onclick="location.href='Accessories.aspx'">Explore</button>
                </div>
                <div class="card">
                    <h4>🩺 Medical</h4>
                    <p>Health care products for your pets.</p>
                    <button class="btn" type="button" onclick="location.href='Medical.aspx'">Explore</button>
                </div>
                <div class="card">
                    <h4>👕 Clothing</h4>
                    <p>Trendy outfits for your pets.</p>
                    <button class="btn" type="button" onclick="location.href='Clothing.aspx'">Explore</button>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <p>📍 123 Pet Street, Surat, Gujarat, India</p>
            <p>📞 +91 98765 43210</p>
            <p>📧 petsheaven41@gmail.com</p>
            <p>&copy; 2025 Pets Heaven. All rights reserved.</p>
        </div>
    </form>

    <script>
        function toggleMenu() {
            document.getElementById("navLinks").classList.toggle("show");
        }
    </script>
</body>
</html>
