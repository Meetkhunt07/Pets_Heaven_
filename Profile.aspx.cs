using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Pets_Heaven_
{
    public partial class Profile : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        private void LoadUserProfile()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "SELECT FullName, Email, Mobile, Address FROM Users WHERE UserID = @UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    txtName.Text = reader["FullName"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtMobile.Text = reader["Mobile"].ToString();
                    txtAddress.Text = reader["Address"].ToString();
                }
                con.Close();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            txtName.ReadOnly = false;
            txtEmail.ReadOnly = false;
            txtMobile.ReadOnly = false;
            txtAddress.ReadOnly = false;

            btnEdit.Visible = false;
            btnUpdate.Visible = true;
            btnBack.Visible = true;
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Reset inputs to readonly mode and hide buttons
            txtName.ReadOnly = true;
            txtEmail.ReadOnly = true;
            txtMobile.ReadOnly = true;
            txtAddress.ReadOnly = true;
            btnUpdate.Visible = false;
            btnBack.Visible = false;
            btnEdit.Visible = true;
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"UPDATE Users 
                                 SET FullName = @name, Email = @email, Mobile = @mobile, Address = @address 
                                 WHERE UserID = @id";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@mobile", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@id", userId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            txtName.ReadOnly = true;
            txtEmail.ReadOnly = true;
            txtMobile.ReadOnly = true;
            txtAddress.ReadOnly = true;

            btnEdit.Visible = true;
            btnUpdate.Visible = false;

            LoadUserProfile();
            ScriptManager.RegisterStartupScript(this, GetType(), "ProfileUpdate",
      "Swal.fire('Updated!', 'Your profile has been updated successfully.', 'success');", true);
        }
    }
}
