using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Pets_Heaven_
{
    public partial class Manage_User : System.Web.UI.Page
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
                LoadUsers();
            }
        }

        private void LoadUsers(string keyword = "")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "SELECT * FROM Users";

                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    query += " WHERE FullName LIKE @Keyword OR Email LIKE @Keyword";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    cmd.Parameters.AddWithValue("@Keyword", "%" + keyword + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvUsers.DataSource = dt;
                gvUsers.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            LoadUsers(keyword);
        }

        protected void gvUsers_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            LoadUsers(txtSearch.Text.Trim());
        }

        protected void gvUsers_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvUsers.EditIndex = -1;
            LoadUsers(txtSearch.Text.Trim());
        }

        protected void gvUsers_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvUsers.Rows[e.RowIndex];
            string name = ((System.Web.UI.WebControls.TextBox)row.Cells[1].Controls[0]).Text;
            string email = ((System.Web.UI.WebControls.TextBox)row.Cells[2].Controls[0]).Text;
            string mobile = ((System.Web.UI.WebControls.TextBox)row.Cells[3].Controls[0]).Text;
            string address = ((System.Web.UI.WebControls.TextBox)row.Cells[4].Controls[0]).Text;
            string userType = ((System.Web.UI.WebControls.DropDownList)row.FindControl("ddlUserType")).SelectedValue;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "UPDATE Users SET FullName=@FullName, Email=@Email, Mobile=@Mobile, Address=@Address, UserType=@UserType WHERE UserID=@UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@FullName", name);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Mobile", mobile);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@UserType", userType);
                cmd.Parameters.AddWithValue("@UserID", userId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            gvUsers.EditIndex = -1;
            LoadUsers(txtSearch.Text.Trim());
            litScript.Text = "<script>Swal.fire('Updated!', 'User details updated successfully.', 'success');</script>";

        }

        protected void gvUsers_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "DELETE FROM Users WHERE UserID=@UserID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            LoadUsers(txtSearch.Text.Trim());
            litScript.Text = "<script>Swal.fire('Deleted!', 'User details deleted successfully.', 'success');</script>";

        }

        protected void gvUsers_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == System.Web.UI.WebControls.DataControlRowType.DataRow && e.Row.RowState.HasFlag(System.Web.UI.WebControls.DataControlRowState.Edit))
            {
                DropDownList ddl = (DropDownList)e.Row.FindControl("ddlUserType");
                HiddenField hdn = (HiddenField)e.Row.FindControl("hdnCurrentUserType");

                if (ddl != null && hdn != null)
                {
                    ddl.SelectedValue = hdn.Value;
                }
            }
        }
    }
}
