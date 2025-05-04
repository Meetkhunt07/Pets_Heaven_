using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Pets_Heaven_
{
    public partial class Dashboard : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Session Check
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadDashboardStats();
            }
        }

        private void LoadDashboardStats()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();

                SqlCommand cmdUsers = new SqlCommand("SELECT COUNT(*) FROM Users WHERE UserType = 'Customer'", con);
                lblUsers.Text = cmdUsers.ExecuteScalar().ToString();

                SqlCommand cmdProducts = new SqlCommand("SELECT COUNT(*) FROM Products", con);
                lblProducts.Text = cmdProducts.ExecuteScalar().ToString();

                SqlCommand cmdCategories = new SqlCommand("SELECT COUNT(*) FROM Categories", con);
                lblCategories.Text = cmdCategories.ExecuteScalar().ToString();

                SqlCommand cmdOrders = new SqlCommand("SELECT COUNT(*) FROM Orders", con);
                lblOrders.Text = cmdOrders.ExecuteScalar().ToString();

                con.Close();
            }
        }
    }
}
