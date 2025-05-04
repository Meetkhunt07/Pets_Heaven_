using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Pets_Heaven_
{
    public partial class ManageContactUs : System.Web.UI.Page
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
                LoadContactMessages();
            }
        }

        private void LoadContactMessages(string search = "")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "SELECT * FROM ContactUs";

                if (!string.IsNullOrEmpty(search))
                {
                    query += " WHERE FullName LIKE @search OR Email LIKE @search";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(search))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvContactUs.DataSource = dt;
                gvContactUs.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            LoadContactMessages(keyword);
        }

        protected void gvContactUs_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int contactId = Convert.ToInt32(gvContactUs.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM ContactUs WHERE ContactID = @id", con);
                cmd.Parameters.AddWithValue("@id", contactId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            LoadContactMessages(txtSearch.Text.Trim());
            litScript.Text = "<script>Swal.fire('Deleted!', 'Contact entry removed successfully.', 'success');</script>";
        }
    }
}
