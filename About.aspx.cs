using System;
using System.Web.UI;

namespace Pets_Heaven_
{
    public partial class About : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Session check to prevent unauthorized access
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}
