using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace Pets_Heaven_
{
    public partial class ManageOrders : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadOrders();
        }

        private void LoadOrders(string keyword = "")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"
                    SELECT O.OrderID, U.FullName, O.TotalAmount, O.PaymentMethod, O.OrderStatus, O.OrderDate
                    FROM Orders O
                    INNER JOIN Users U ON O.UserID = U.UserID";

                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    query += " WHERE U.FullName LIKE @Keyword OR CAST(O.OrderID AS NVARCHAR) LIKE @Keyword";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    cmd.Parameters.AddWithValue("@Keyword", "%" + keyword + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvOrders.DataSource = dt;
                gvOrders.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadOrders(txtSearch.Text.Trim());
        }

        protected void gvOrders_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvOrders.EditIndex = e.NewEditIndex;
            LoadOrders(txtSearch.Text.Trim());
        }

        protected void gvOrders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvOrders.EditIndex = -1;
            LoadOrders(txtSearch.Text.Trim());
        }

        protected void gvOrders_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int orderId = Convert.ToInt32(gvOrders.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvOrders.Rows[e.RowIndex];

            string payment = ((DropDownList)row.FindControl("ddlPaymentMethod")).SelectedValue;
            string status = ((DropDownList)row.FindControl("ddlStatus")).SelectedValue;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Orders SET PaymentMethod=@PaymentMethod, OrderStatus=@OrderStatus WHERE OrderID=@OrderID", con);
                cmd.Parameters.AddWithValue("@PaymentMethod", payment);
                cmd.Parameters.AddWithValue("@OrderStatus", status);
                cmd.Parameters.AddWithValue("@OrderID", orderId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            gvOrders.EditIndex = -1;
            LoadOrders(txtSearch.Text.Trim());
            litScript.Text = "<script>Swal.fire('Updated!','Order updated successfully.','success');</script>";

        }

        protected void gvOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int orderId = Convert.ToInt32(gvOrders.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Orders WHERE OrderID=@OrderID", con);
                cmd.Parameters.AddWithValue("@OrderID", orderId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            LoadOrders(txtSearch.Text.Trim());
            litScript.Text = "<script>Swal.fire('Deleted!','Order deleted successfully.','success');</script>";

        }
    }
}
