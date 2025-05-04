using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace Pets_Heaven_
{
    public partial class Insert_Products : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
                Response.Redirect("Login.aspx");
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            int categoryId = Convert.ToInt32(Request.QueryString["cat"]);
            string name = txtName.Text.Trim();
            string desc = txtDesc.Text.Trim();
            decimal price = Convert.ToDecimal(txtPrice.Text.Trim());
            int stock = Convert.ToInt32(txtStock.Text.Trim());
            string imagePath = "";

            if (fuImage.HasFile)
            {
                string ext = Path.GetExtension(fuImage.FileName).ToLower();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png")
                {
                    cvImage.IsValid = false;
                    return;
                }

                string fileName = Path.GetFileName(fuImage.FileName);
                string savePath = "~/Images/" + fileName;
                fuImage.SaveAs(Server.MapPath(savePath));
                imagePath = "Images/" + fileName;
            }

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "INSERT INTO Products (CategoryID, ProductName, Description, Price, StockQuantity, ImageURL) " +
                               "VALUES (@Cat, @Name, @Desc, @Price, @Stock, @Image)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Cat", categoryId);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Desc", desc);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Stock", stock);
                cmd.Parameters.AddWithValue("@Image", imagePath);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                litScript.Text = "<script>Swal.fire('Product Inserted Successfully!'); window.location='Insert_Products.aspx';</script>";
            }

           
        }

        protected void cvImage_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (fuImage.HasFile)
            {
                string ext = Path.GetExtension(fuImage.FileName).ToLower();
                args.IsValid = ext == ".jpg" || ext == ".jpeg" || ext == ".png";
            }
            else
            {
                args.IsValid = true; // allow empty if optional
            }
        }
    }
}
