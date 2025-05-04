<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Pets_Heaven_.Profile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Profile - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <!-- Fonts + Icons + Alerts -->
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

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

        /* NAVBAR STYLES */
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

        /* PROFILE BOX STYLES */
        .profile-container {
            max-width: 600px;
            background-color: white;
            margin: 50px auto;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }

        .profile-container h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
        }

        .profile-info label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }

        .profile-info input[type="text"],
        .input {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .profile-image {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
        }

        .profile-image img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #16a085;
        }

        .edit-btn {
            position: absolute;
            right: 0;
            top: 0;
            background-color: #16a085;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-update,
        .btn-back {
            margin-top: 20px;
            background-color: #16a085;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .edit-btn:hover,
        .btn-update:hover,
        .btn-back:hover {
            background-color: #138f75;
        }

        /* FOOTER STYLES */
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
    </style>

    <script>
        function toggleMenu() {
            document.getElementById("navLinks").classList.toggle("show");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- ✅ NAVIGATION BAR -->
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
                <a href="Cart.aspx">🛒 Cart</a>
                <a href="Profile.aspx" class="active">👤 Profile</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- ✅ PROFILE BOX -->
        <div class="profile-container">
            <h2>Your Profile</h2>

            <div class="profile-image">
                <img src="Images/default-user.png" alt="User Image" />
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="edit-btn" OnClick="btnEdit_Click" />
            </div>

            <div class="profile-info">
                <label>Full Name:</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="input" ReadOnly="true" />

                <label>Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="input" ReadOnly="true" />

                <label>Mobile:</label>
                <asp:TextBox ID="txtMobile" runat="server" CssClass="input" ReadOnly="true" />

                <label>Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="input" ReadOnly="true" />

                <!-- Update & Back Buttons -->
                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn-update" Visible="false" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn-back" Visible="false" OnClick="btnBack_Click" />
            </div>
        </div>

        <!-- ✅ FOOTER -->
        <div class="footer">
            <h4>Contact Us</h4>
            <p><i class="fa fa-map-marker-alt"></i> 123 Pet Street, Surat, Gujarat, India</p>
            <p><i class="fa fa-phone-alt"></i> +91 98765 43210</p>
            <p><i class="fa fa-envelope"></i> petsheaven41@gmail.com</p>
            <hr />
            <p>© 2025 Pets Heaven. All rights reserved.</p>
        </div>
    </form>
</body>
</html>
