using System;
using System.Web.UI;

namespace Pets_Heaven_
{
    public partial class Services : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // ✅ Session Check
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }
    }
}
