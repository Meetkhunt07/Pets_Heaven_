using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Pets_Heaven_
{
    public partial class Contact : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Session Check
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string message = txtMessage.Text.Trim();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO ContactUs (FullName, Email, Message, SubmittedDate) VALUES (@Name, @Email, @Message, GETDATE())";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Message", message);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            // Show success message
            ScriptManager.RegisterStartupScript(this, GetType(), "ContactSuccess",
     "Swal.fire('Thank you!', 'Your message has been sent successfully!', 'success');", true);


            // Clear the fields
            txtName.Text = "";
            txtEmail.Text = "";
            txtMessage.Text = "";
        }
    }
}
