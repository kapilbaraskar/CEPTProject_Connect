using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_Cross_Registration_PG_UG_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_type"].ToString() != "A")
        {


            if (Session["user_type"].ToString() == "S" || Session["user_type"].ToString() == "E")
            {
                Response.Redirect("~/Student/Dashboard.aspx?autho=false");
            }
            else if (Session["user_type"].ToString() == "I")
            {
                Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
            }
            else if (Session["user_type"].ToString() == "A1")
            {
                Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
            }


        }
    }

    
}