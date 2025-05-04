using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Pets_Heaven_
{
    public partial class Registation : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                lblMessage.Text = "";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    // 🔍 Check if email already exists
                    string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                    con.Open();
                    int exists = (int)checkCmd.ExecuteScalar();
                    con.Close();

                    if (exists > 0)
                    {
                        ShowModal("❌ Email already exists. Please use another one.");
                        return;
                    }

                    // ✅ Insert user if email is unique
                    string insertQuery = "INSERT INTO Users (FullName, Email, Password, Mobile, Address, UserType) VALUES (@FullName, @Email, @Password, @Mobile, @Address, 'Customer')";
                    SqlCommand cmd = new SqlCommand(insertQuery, con);
                    cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());
                    cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                    cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());

                    con.Open();
                    int result = cmd.ExecuteNonQuery();
                    con.Close();

                    if (result > 0)
                        ShowModal("✅ Registration successful.");
                    else
                        ShowModal("❌ Registration failed. Please try again.");
                }
            }
        }

        private void ShowModal(string msg)
        {
            lblMessage.Text = msg;
            string script = "var myModal = new bootstrap.Modal(document.getElementById('modalMsg')); myModal.show();";
            ScriptManager.RegisterStartupScript(this, GetType(), "Pop", script, true);
        }
    }
}
