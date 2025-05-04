<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="Pets_Heaven_.Dashboard" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - Pets Heaven</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <style>
        html, body {
            margin: 0;
            padding: 0;
            font-family: 'Quicksand', sans-serif;
            color: black;
            background-color: #ffffff;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            overflow-x: hidden;
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
            position: relative;
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

        .dashboard-container {
            flex: 1;
            max-width: 1100px;
            margin: 40px auto;
            padding: 30px 15px;
        }

        .dashboard-container h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }

        .card-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 2rem;
            justify-content: center;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 6px 14px rgba(0,0,0,0.08);
            text-align: center;
            flex: 1 1 220px;
            max-width: 240px;
        }

        .card h3 {
            font-size: 1.3rem;
            color: #16a085;
            margin-bottom: 10px;
        }

        .card i {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: #2471a3;
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

            .card {
                width: 90%;
            }
        }
    </style>

    <script type="text/javascript">
        function toggleMenu() {
            var links = document.getElementById('navLinks');
            if (links.classList.contains('show')) {
                links.classList.remove('show');
            } else {
                links.classList.add('show');
            }
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
                <a href="Dashboard.aspx" class="active">📊 Dashboard</a>
                <a href="ManagePets.aspx">🐶 Pets</a>
                <a href="ManageAccessories.aspx">🦴 Accessories</a>
                <a href="ManageClothing.aspx">👕 Clothing</a>
                <a href="ManageMedical.aspx">🩺 Medical</a>
                <a href="ManageOrders.aspx">🧾 Orders</a>
                <a href="Manage_User.aspx">👥 Users</a>
                <a href="ManageContactUs.aspx">📩 Contact</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <!-- DASHBOARD -->
        <div class="dashboard-container">
            <h2>Welcome, Admin!</h2>

            <!-- CARDS ROW -->
            <div class="card-grid">
                <div class="card">
                    <i class="fas fa-users"></i>
                    <h3>Total Users</h3>
                    <asp:Label ID="lblUsers" runat="server" Font-Bold="true" Font-Size="X-Large" />
                </div>
                <div class="card">
                    <i class="fas fa-box-open"></i>
                    <h3>Total Products</h3>
                    <asp:Label ID="lblProducts" runat="server" Font-Bold="true" Font-Size="X-Large" />
                </div>
                <div class="card">
                    <i class="fas fa-tags"></i>
                    <h3>Total Categories</h3>
                    <asp:Label ID="lblCategories" runat="server" Font-Bold="true" Font-Size="X-Large" />
                </div>
                <div class="card">
                    <i class="fas fa-shopping-cart"></i>
                    <h3>Total Orders</h3>
                    <asp:Label ID="lblOrders" runat="server" Font-Bold="true" Font-Size="X-Large" />
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <div class="footer">
            <p>© 2025 Pets Heaven Admin Panel. All rights reserved.</p>
        </div>
    </form>
</body>
</html>
