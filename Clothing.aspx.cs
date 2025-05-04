using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pets_Heaven_
{
    public partial class Clothing : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;
        int PageSize = 9;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadClothing(1);
        }

        private void LoadClothing(int pageIndex)
        {
            string keyword = txtSearch.Text.Trim();
            int start = (pageIndex - 1) * PageSize;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"
                    SELECT * FROM (
                        SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS RowNum, * 
                        FROM Products 
                        WHERE CategoryID = 3 AND ProductName LIKE @Search
                    ) AS Paged
                    WHERE RowNum BETWEEN @Start + 1 AND @Start + @PageSize;

                    SELECT COUNT(*) FROM Products WHERE CategoryID = 3 AND ProductName LIKE @Search;
                ";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Search", "%" + keyword + "%");
                cmd.Parameters.AddWithValue("@Start", start);
                cmd.Parameters.AddWithValue("@PageSize", PageSize);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);

                rptClothing.DataSource = ds.Tables[0];
                rptClothing.DataBind();

                int totalRecords = Convert.ToInt32(ds.Tables[1].Rows[0][0]);
                GeneratePaging(totalRecords, pageIndex);
            }
        }

        private void GeneratePaging(int totalRecords, int currentPage)
        {
            int totalPages = (int)Math.Ceiling((double)totalRecords / PageSize);
            StringBuilder sb = new StringBuilder();

            for (int i = 1; i <= totalPages; i++)
            {
                if (i == currentPage)
                    sb.Append($"<a href='Clothing.aspx?page={i}' class='current'>{i}</a>");
                else
                    sb.Append($"<a href='Clothing.aspx?page={i}'>{i}</a>");
            }

            if (currentPage < totalPages)
            {
                sb.Append($"<a href='Clothing.aspx?page={currentPage + 1}'>&raquo;Next</a>");
            }

            litPaging.Text = sb.ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadClothing(1);
        }

        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            if (!IsPostBack && int.TryParse(Request.QueryString["page"], out int page))
            {
                LoadClothing(page);
            }
        }

        protected void btnAddToCart_Command(object sender, CommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"
                    IF EXISTS (SELECT 1 FROM AddToCart WHERE ProductID = @ProductID AND UserID = @UserID)
                        UPDATE AddToCart SET Quantity = Quantity + 1 WHERE ProductID = @ProductID AND UserID = @UserID
                    ELSE
                        INSERT INTO AddToCart (ProductID, UserID, Quantity, AddedDate)
                        VALUES (@ProductID, @UserID, 1, GETDATE())";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "ClothingAdded",
     "Swal.fire('Added!', 'Item added to cart!', 'success');", true);

        }
    }
}
