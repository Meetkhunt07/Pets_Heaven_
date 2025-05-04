using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Pets_Heaven_
{
    public partial class Login : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            lblMessage.Visible = false;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string query = "SELECT UserID, FullName, Email, UserType FROM Users WHERE Email = @Email AND Password = @Password";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text.Trim());

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        Session["UserID"] = dr["UserID"].ToString();
                        Session["FullName"] = dr["FullName"].ToString();
                        Session["Email"] = dr["Email"].ToString();
                        Session["UserType"] = dr["UserType"].ToString();

                        if (dr["UserType"].ToString() == "Admin")
                            Response.Redirect("Dashboard.aspx");
                        else
                            Response.Redirect("Home_page.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "❌ Invalid email or password.";
                        lblMessage.Visible = true;
                    }
                }
            }
        }
    }
}
