<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagePets.aspx.cs" Inherits="Pets_Heaven_.ManagePets" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Pets - Pets Heaven Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        /* -- KEEPING YOUR ORIGINAL CSS UNCHANGED -- */
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
            margin-bottom: 20px;
            font-size: 24px;
            color: white;
        }
        .btn-add {
            background-color: black;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            float: right;
            margin-bottom: 20px;
            display: inline-block;
        }
        .search-box {
            margin-bottom: 20px;
        }
        .search-box input[type="text"] {
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
        .grid img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }
        .btn {
            text-decoration: none;
            padding: 6px 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-family: 'Quicksand', sans-serif;
        }
        .btn-edit {
            background-color: black;
            color: white;
        }
        .btn-delete {
            background-color: crimson;
            color: white;
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
            .btn-add {
                float: none;
                width: 100%;
                text-align: center;
                margin-top: 10px;
            }
        }
    </style>

    <script type="text/javascript">
        function toggleMenu() {
            document.getElementById("navLinks").classList.toggle("show");
        }

        function showSuccessAlert(msg) {
            Swal.fire({
                icon: 'success',
                title: msg,
                showConfirmButton: false,
                timer: 1800
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="navbar">
            <div class="navbar-title">👨‍💻 Pets Heaven Admin</div>
            <button type="button" class="nav-toggle" onclick="toggleMenu()">☰</button>
            <div class="nav-links" id="navLinks">
                <a href="Dashboard.aspx">📊 Dashboard</a>
                <a href="ManagePets.aspx" class="active">🐶 Pets</a>
                <a href="ManageAccessories.aspx">🦴 Accessories</a>
                <a href="ManageClothing.aspx">👕 Clothing</a>
                <a href="ManageMedical.aspx">🩺 Medical</a>
                <a href="ManageOrders.aspx">🧾 Orders</a>
                <a href="Manage_User.aspx">👥 Users</a>
                <a href="ManageContactUs.aspx">📩 Contact</a>
                <a href="Logout.aspx">🚪 Logout</a>
            </div>
        </div>

        <div class="container">
            <h2>Manage Pet Products</h2>

            <div class="search-box">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search by name..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <a class="btn-add" href="Insert_Products.aspx?cat=1">+ Add New Pet</a>

            <asp:GridView ID="gvPets" runat="server" AutoGenerateColumns="False" CssClass="grid"
                OnRowEditing="gvPets_RowEditing"
                OnRowUpdating="gvPets_RowUpdating"
                OnRowCancelingEdit="gvPets_RowCancelingEdit"
                OnRowDeleting="gvPets_RowDeleting"
                DataKeyNames="ProductID">
                <Columns>
                    <asp:BoundField DataField="ProductID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="ProductName" HeaderText="Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹{0:N2}" />
                    <asp:BoundField DataField="StockQuantity" HeaderText="Stock" />
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <img src='<%# ResolveUrl(Convert.ToString(Eval("ImageURL"))) %>' alt="Pet" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:FileUpload ID="fuImage" runat="server" />
                            <asp:HiddenField ID="hdnOldImage" runat="server" Value='<%# Bind("ImageURL") %>' />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True"
                        ControlStyle-CssClass="btn btn-edit" />
                </Columns>
            </asp:GridView>
        </div>

        <div class="footer">
            <p>© 2025 Pets Heaven Admin Panel. All rights reserved.</p>
        </div>

        <%-- ALERT TRIGGER SCRIPT FROM BACKEND --%>
        <asp:Literal ID="litScript" runat="server" />
    </form>
</body>
</html>
