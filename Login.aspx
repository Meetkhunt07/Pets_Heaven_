<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Pets_Heaven_.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Pets Heaven</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@500;700&display=swap" rel="stylesheet" />
    <style>
        body {
            background-color: #f1f7f5;
            font-family: 'Quicksand', sans-serif;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        .login-box {
            background-color: white;
            padding: 40px 30px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .login-box h2 {
            margin: 0 0 30px;
            color: black;
            font-size: 26px;
            font-weight: bold;
            text-align: center;
        }

        .login-box .paw-icon {
            font-size: 30px;
            color: #16a085;
            text-align: center;
            margin-bottom: 10px;
        }

        .form-group {
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 600;
            font-size: 15px;
            margin-bottom: 6px;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 14px;
            font-family: 'Quicksand', sans-serif;
            box-sizing: border-box;
        }

        .toggle-eye {
            position: absolute;
            right: 15px;
            top: 38px;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 16px;
            color: gray;
        }

        .toggle-container {
            position: relative;
        }

        .btn-login {
            background-color: #16a085;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-login:hover {
            background-color: #138f75;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }

        .register-link a {
            color: #007bff;
            text-decoration: none;
        }

        .register-link a:hover {
            text-decoration: underline;
        }

        .validation {
            color: red;
            font-size: 13px;
            margin-top: 6px;
        }

        @media screen and (max-width: 480px) {
            .login-box {
                padding: 30px 20px;
            }

            .login-box h2 {
                font-size: 22px;
            }

            .form-group label {
                font-size: 14px;
            }

            .form-control {
                font-size: 13px;
                padding: 10px;
            }

            .btn-login {
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
            <div class="login-box">
                <div class="paw-icon">🐾</div>
                <h2>Pets Heaven<br />Login</h2>

                <!-- Email Field -->
                <div class="form-group">
                    <label for="txtEmail">Email ID</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email ID" />
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="* Email is required" CssClass="validation" Display="Dynamic" />
                </div>

                <!-- Password Field -->
                <div class="form-group toggle-container">
                    <label for="txtPassword">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter Password" />
                    <span class="toggle-eye" onclick="togglePassword()">👁️</span>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="* Password is required" CssClass="validation" Display="Dynamic" />
                </div>

                <!-- Message Label -->
                <asp:Label ID="lblMessage" runat="server" CssClass="validation" Visible="false" />

                <!-- Login Button -->
                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />

                <!-- Register Link -->
                <div class="register-link">
                    Don’t have an account? <a href="Registration.aspx">Sign Up</a>
                </div>
            </div>
        </div>

        <script>
            function togglePassword() {
                var pwd = document.getElementById('<%= txtPassword.ClientID %>');
                if (pwd.type === "password") {
                    pwd.type = "text";
                } else {
                    pwd.type = "password";
                }
            }
        </script>
    </form>
</body>
</html>
