<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Pets_Heaven_.Contact" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact Us - Pets Heaven</title>

    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background-color: #f4f8f4;
            margin: 0;
            padding: 0;
            color: black;
        }

        /* NAVBAR */
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

        /* CONTACT FORM */
        .contact-container {
            max-width: 700px;
            background-color: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
            margin: 50px auto;
        }

        .contact-container h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            color: black;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            color: #333;
            display: block;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="email"], textarea, .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1rem;
            font-family: 'Quicksand', sans-serif;
        }

        textarea {
            height: 120px;
            resize: vertical;
        }

        .btn-submit {
            background-color: #16a085;
            color: white;
            border: none;
            padding: 12px 24px;
            font-size: 1rem;
            border-radius: 8px;
            cursor: pointer;
            display: block;
            margin: auto;
            font-family: 'Quicksand', sans-serif;
        }

        .btn-submit:hover {
            background-color: #138f75;
        }

        /* FOOTER */
        .footer {
            background-color: #16a085;
            color: white;
            padding: 2rem;
            text-align: center;
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
        <!-- NAVBAR -->
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
                <a href="Contact.aspx" class="active">📞 Contact</a>
                <a href="Cart.aspx">🛒 Cart</a>
                <a href="Profile.aspx">👤 Profile</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- CONTACT FORM -->
        <div class="contact-container">
            <h2>Contact Us</h2>

            <div class="form-group">
                <label for="txtName">Full Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your full name" />
            </div>

            <div class="form-group">
                <label for="txtEmail">Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="Enter your email address" />
            </div>

            <div class="form-group">
                <label for="txtMessage">Message</label>
                <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" CssClass="form-control" placeholder="Type your message here..." />
            </div>

            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn-submit" OnClick="btnSubmit_Click" />
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
