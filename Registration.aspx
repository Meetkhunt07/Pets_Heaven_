<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Pets_Heaven_.Registation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: 'Quicksand', sans-serif;
            background-color: #f1f7f5;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .register-container {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        .register-container h2 {
            color: black;
            font-size: 26px;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            font-size: 15px;
        }

        .form-group input,
        .form-control,
        textarea {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 14px;
            font-family: 'Quicksand', sans-serif;
            box-sizing: border-box;
        }

        .validation {
            color: #c0392b;
            font-size: 13px;
            margin-top: 6px;
            display: block;
        }

        .toggle-eye {
            position: absolute;
            top: 38px;
            right: 15px;
            cursor: pointer;
            font-size: 16px;
            color: gray;
        }

        .btn-register {
            width: 100%;
            padding: 12px;
            background-color: #16a085;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-register:hover {
            background-color: #138f75;
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .login-link a {
            color: #007bff;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        /* ✅ Modal message style for errors */
        .modal-body .form-label.text-dark {
            color: #c0392b;
            font-size: 15px;
            padding: 10px 15px;
            border: 1px solid #e74c3c;
            background-color: #fdecea;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .modal-body .form-label.text-dark::before {
            content: "❌";
            font-size: 16px;
        }

        @media screen and (max-width: 480px) {
            .register-container {
                padding: 30px 20px;
            }

            .register-container h2 {
                font-size: 22px;
            }

            .form-group label {
                font-size: 14px;
            }

            .form-group input,
            .form-control,
            textarea {
                font-size: 13px;
                padding: 10px;
            }

            .btn-register {
                font-size: 15px;
                padding: 10px;
            }

            .toggle-eye {
                top: 36px;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="register-container">
                <h2>Create Your Account</h2>

                <div class="form-group">
                    <label for="txtFullName">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtFullName" ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label for="txtEmail">Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                        ValidationExpression="^[\w\.-]+@[\w\.-]+\.\w{2,4}$" ErrorMessage="* Invalid email" CssClass="validation" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    <span class="toggle-eye" onclick="togglePassword('txtPassword')">👁️</span>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    <span class="toggle-eye" onclick="togglePassword('txtConfirmPassword')">👁️</span>
                    <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirmPassword" ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />
                    <asp:CompareValidator ID="cvPassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                        ErrorMessage="* Passwords do not match" CssClass="validation" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label for="txtMobile">Mobile</label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" />
                    <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ControlToValidate="txtMobile" ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />
                    <asp:RegularExpressionValidator ID="revMobile" runat="server" ControlToValidate="txtMobile"
                        ValidationExpression="^\d{10}$" ErrorMessage="* Must be 10 digits" CssClass="validation" Display="Dynamic" />
                </div>

                <div class="form-group">
                    <label for="txtAddress">Address</label>
                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                    <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" ErrorMessage="* Required" CssClass="validation" Display="Dynamic" />
                </div>

                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-register" OnClick="btnRegister_Click" />

                <div class="login-link">
                    Already have an account? <a href="Login.aspx">Login here</a>
                </div>
            </div>
        </div>

        <!-- ✅ Bootstrap Modal -->
        <div class="modal fade" id="modalMsg" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Registration</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <asp:Label ID="lblMessage" runat="server" CssClass="form-label text-dark" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-success" data-bs-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function togglePassword(id) {
                var input = document.getElementById(id);
                input.type = input.type === "password" ? "text" : "password";
            }
        </script>
    </form>
</body>
</html>
