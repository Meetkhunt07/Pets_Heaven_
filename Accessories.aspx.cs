using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;

namespace Pets_Heaven_
{
    public partial class Accessories : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["PetsHeavenConn"].ConnectionString;
        int PageSize = 9;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadAccessories(GetPageIndex());
        }

        private int GetPageIndex()
        {
            int page = 1;
            if (int.TryParse(Request.QueryString["page"], out int parsedPage) && parsedPage > 0)
                page = parsedPage;
            return page;
        }

        private void LoadAccessories(int pageIndex)
        {
            string keyword = txtSearch.Text.Trim();
            int start = (pageIndex - 1) * PageSize;

            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = @"
                    SELECT * FROM (
                        SELECT ROW_NUMBER() OVER (ORDER BY ProductID) AS RowNum, * 
                        FROM Products 
                        WHERE CategoryID = 2 AND ProductName LIKE @Search
                    ) AS Paged
                    WHERE RowNum BETWEEN @Start + 1 AND @Start + @PageSize;

                    SELECT COUNT(*) FROM Products WHERE CategoryID = 2 AND ProductName LIKE @Search;";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Search", "%" + keyword + "%");
                cmd.Parameters.AddWithValue("@Start", start);
                cmd.Parameters.AddWithValue("@PageSize", PageSize);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);

                rptAccessories.DataSource = ds.Tables[0];
                rptAccessories.DataBind();

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
                    sb.Append($"<a class='current' href='Accessories.aspx?page={i}'>{i}</a>");
                else
                    sb.Append($"<a href='Accessories.aspx?page={i}'>{i}</a>");
            }

            if (currentPage < totalPages)
            {
                sb.Append($"<a href='Accessories.aspx?page={currentPage + 1}'>Next &raquo;</a>");
            }

            litPaging.Text = sb.ToString();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadAccessories(1);
        }

        protected void btnAddToCart_Command(object sender, System.Web.UI.WebControls.CommandEventArgs e)
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
                        VALUES (@ProductID, @UserID, 1, GETDATE());";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductID", productId);
                cmd.Parameters.AddWithValue("@UserID", userId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            ScriptManager.RegisterStartupScript(this, GetType(), "AddSuccess",
     "Swal.fire('Added!', 'Item added to cart.', 'success');", true);

            LoadAccessories(GetPageIndex()); // Refresh current page
        }
    }
}
