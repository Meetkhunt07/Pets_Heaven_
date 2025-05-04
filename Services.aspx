<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Services.aspx.cs" Inherits="Pets_Heaven_.Services" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pet Services - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <style>
        * {
            box-sizing: border-box;
        }

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
            font-size: 22px;
            color: white;
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

        .main-title {
            text-align: center;
            font-size: 2rem;
            margin: 2rem 0 1.5rem;
        }

        .card-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            justify-content: center;
            gap: 2rem;
            padding: 0 2rem 4rem;
            max-width: 1100px;
            margin: auto;
        }

        .card {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
            text-align: center;
            padding: 2rem;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: scale(1.03);
        }

        .card i {
            font-size: 3rem;
            color: #16a085;
            margin-bottom: 1rem;
        }

        .card h3 {
            margin: 0.5rem 0;
            font-size: 20px;
        }

        .card p {
            margin: 0.3rem 0;
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

        .footer p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
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
                <a href="Services.aspx" class="active">💼 Services</a>
                <a href="Contact.aspx">📞 Contact</a>
                <a href="Cart.aspx">🛒 Cart</a>
                <a href="Profile.aspx">👤 Profile</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- PAGE TITLE -->
        <h2 class="main-title">Our Pet Services</h2>

        <!-- SERVICES SECTION -->
        <div class="card-container">
            <div class="card">
                <i class="fas fa-shower"></i>
                <h3>Grooming</h3>
                <p>Full-service grooming to keep your pet clean and fresh.</p>
            </div>
            <div class="card">
                <i class="fas fa-user-md"></i>
                <h3>Veterinary Care</h3>
                <p>On-site vet consultations, checkups, and emergency care.</p>
            </div>
            <div class="card">
                <i class="fas fa-dog"></i>
                <h3>Training</h3>
                <p>Professional obedience and behavior training sessions.</p>
            </div>
            <div class="card">
                <i class="fas fa-home"></i>
                <h3>Pet Boarding</h3>
                <p>Safe and cozy stay for your pets while you're away.</p>
            </div>
            <div class="card">
                <i class="fas fa-syringe"></i>
                <h3>Vaccination</h3>
                <p>Essential shots and boosters for all pet types.</p>
            </div>
            <div class="card">
                <i class="fas fa-paw"></i>
                <h3>Adoption Assistance</h3>
                <p>Helping loving families adopt rescued pets.</p>
            </div>
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
