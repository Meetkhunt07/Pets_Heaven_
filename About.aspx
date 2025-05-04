<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Pets_Heaven_.About" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About Us - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
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

        .about-container {
            background-color: white;
            max-width: 850px;
            margin: 60px auto;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.08);
        }

        .about-container h1 {
            text-align: center;
            font-size: 2rem;
            color: #111;
            margin-bottom: 20px;
        }

        .about-container p {
            font-size: 1rem;
            line-height: 1.7;
            color: #333;
            margin-bottom: 16px;
        }

        .footer {
            background-color: #16a085;
            color: white;
            padding: 2rem;
            text-align: center;
            margin-top: 60px;
        }

        .footer p, .footer a {
            color: white;
            margin: 5px 0;
            display: block;
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
        <!-- NAVIGATION BAR -->
        <div class="navbar">
            <h1>🐾 Pets Heaven</h1>
            <button class="menu-toggle" type="button" onclick="toggleMenu()">☰</button>
            <div class="links" id="navLinks">
                <a href="Home_page.aspx">🏠 Home</a>
                <a href="About.aspx" class="active">ℹ️ About</a>
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

        <!-- ABOUT SECTION -->
        <div class="about-container">
            <h1>About Pets Heaven</h1>
            <p>
                Welcome to <strong>Pets Heaven</strong>, your one-stop destination for all your pet needs! Founded with love and passion for animals, our mission is to make the lives of pets and their owners happier, healthier, and easier.
            </p>
            <p>
                We offer a wide range of high-quality products and services including pet adoption, medical care, grooming, clothing, and accessories. Our dedicated team ensures that every pet feels special and every customer feels valued.
            </p>
            <p>
                Whether you’re a proud pet parent or planning to become one, Pets Heaven is here to support you with the best care, products, and advice. Because at Pets Heaven, pets aren’t just animals—they’re family.
            </p>
            <p>
                Thank you for trusting us and being a part of the Pets Heaven family. 🐾
            </p>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <h4>Contact Us</h4>
            <p><i class="fa fa-map-marker-alt"></i> 123 Pet Street, Surat, Gujarat, India</p>
            <p><i class="fa fa-phone-alt"></i> +91 98765 43210</p>
            <p><i class="fa fa-envelope"></i> petsheaven41@gmail.com</p>
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
