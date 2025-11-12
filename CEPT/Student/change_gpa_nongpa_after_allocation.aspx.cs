using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_change_gpa_nongpa_after_allocation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Redirect("~/student/Dashboard.aspx");

        if (!IsPostBack)
        {
            //if (Session["gender"].ToString() == "" || Session["agree_afidavite"].ToString() == "")
            if (Session["gender"].ToString() == "")
            {
                Response.Redirect("~/student/Dashboard.aspx");
            }

            if (Session["user_type"].ToString() != "S")
            {
                if (Session["user_type"].ToString() == "I")
                {
                    Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "A")
                {
                    Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "A1")
                {
                    Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                }
            }
        }
    }
}