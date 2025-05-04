using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pets_Heaven_
{
    public partial class ManagePets : System.Web.UI.Page
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
                LoadPets();
            }
        }

        private void LoadPets(string search = "")
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "SELECT * FROM Products WHERE CategoryID = 1";

                if (!string.IsNullOrEmpty(search))
                {
                    query += " AND ProductName LIKE @search";
                }

                SqlCommand cmd = new SqlCommand(query, con);
                if (!string.IsNullOrEmpty(search))
                {
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvPets.DataSource = dt;
                gvPets.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadPets(txtSearch.Text.Trim());
        }

        protected void gvPets_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPets.EditIndex = e.NewEditIndex;
            LoadPets(txtSearch.Text.Trim());
        }

        protected void gvPets_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPets.EditIndex = -1;
            LoadPets(txtSearch.Text.Trim());
        }

        protected void gvPets_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = gvPets.Rows[e.RowIndex];
            int productId = Convert.ToInt32(gvPets.DataKeys[e.RowIndex].Value);

            string name = ((TextBox)row.Cells[1].Controls[0]).Text;
            string description = ((TextBox)row.Cells[2].Controls[0]).Text;
            decimal price = Convert.ToDecimal(((TextBox)row.Cells[3].Controls[0]).Text);
            int stock = Convert.ToInt32(((TextBox)row.Cells[4].Controls[0]).Text);

            FileUpload fuImage = (FileUpload)row.FindControl("fuImage");
            HiddenField hdnOldImage = (HiddenField)row.FindControl("hdnOldImage");

            string imageUrl = hdnOldImage.Value;

            if (fuImage.HasFile)
            {
                string folderPath = Server.MapPath("~/Images/Pets/");
                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string fileName = Path.GetFileName(fuImage.FileName);
                fuImage.SaveAs(Path.Combine(folderPath, fileName));
                imageUrl = "Images/Pets/" + fileName;
            }

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand(@"UPDATE Products 
                    SET ProductName=@name, Description=@desc, Price=@price, 
                        StockQuantity=@stock, ImageURL=@img 
                    WHERE ProductID=@id", con);

                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@desc", description);
                cmd.Parameters.AddWithValue("@price", price);
                cmd.Parameters.AddWithValue("@stock", stock);
                cmd.Parameters.AddWithValue("@img", imageUrl);
                cmd.Parameters.AddWithValue("@id", productId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            gvPets.EditIndex = -1;
            LoadPets(txtSearch.Text.Trim());
            litScript.Text = "<script>Swal.fire('Updated!','Product updated successfully.','success');</script>";
        
        }

        protected void gvPets_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int productId = Convert.ToInt32(gvPets.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Products WHERE ProductID=@id", con);
                cmd.Parameters.AddWithValue("@id", productId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            LoadPets(txtSearch.Text.Trim());
            litScript.Text = "<script>Swal.fire('Deleted!','Product removed successfully.','success');</script>";
        }
        private void ShowAlert(string message, string type)
        {
            string color = type == "success" ? "#2ecc71" : "#e74c3c";
            string script = $@"
                Swal.fire({{
                    title: 'Success!',
                    text: '{message}',
                    icon: '{(type == "success" ? "success" : "error")}',
                    confirmButtonColor: '{color}'
                }});";
            ScriptManager.RegisterStartupScript(this, GetType(), "popup", script, true);
        }
    }
}
