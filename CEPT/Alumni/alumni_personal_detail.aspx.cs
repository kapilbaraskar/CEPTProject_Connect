using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Alumni_alumni_personal_detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("~/Alumni/Alumni_Dashboard.aspx");

        if (Session["UserID"] != null && Session["email"] != null)
        {
            hdn_login_email.Value = Session["email"].ToString();
        }
    }
}