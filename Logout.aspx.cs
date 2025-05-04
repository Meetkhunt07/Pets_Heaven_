using System;
using System.Web;
using System.Web.UI;

namespace Pets_Heaven_
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            string userType = Session["UserType"] != null ? Session["UserType"].ToString() : "Customer";
            string cancelRedirectUrl = (userType == "Admin") ? "Dashboard.aspx" : "Home_page.aspx";

            // Only show SweetAlert if logout not confirmed
            if (!IsPostBack && Request.QueryString["confirm"] != "true")
            {
                string confirmScript = $@"
                    Swal.fire({{
                        title: 'Are you sure?',
                        text: 'Do you really want to logout?',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#d33',
                        cancelButtonColor: '#3085d6',
                        confirmButtonText: 'Yes, logout',
                        cancelButtonText: 'No, stay here'
                    }}).then((result) => {{
                        if (result.isConfirmed) {{
                            window.location.href = 'Logout.aspx?confirm=true';
                        }} else {{
                            window.location.href = '{cancelRedirectUrl}';
                        }}
                    }});";

                ScriptManager.RegisterStartupScript(this, GetType(), "logoutConfirm", confirmScript, true);
            }
            else if (Request.QueryString["confirm"] == "true")
            {
                Session.Clear();
                Session.Abandon();
                Response.Redirect("Login.aspx");
            }
        }
    }
}
