using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Calender : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Response.Redirect("~/student/Dashboard.aspx");

            //if (Session["user_type"].ToString() == "S")
            //{
            //    Response.Redirect("~/Student/Dashboard.aspx");
            //}

            if (Session["year_code"].ToString() == "Y2016")
            {
                //Response.Redirect("~/Student/Dashboard.aspx", false);
            }
            else
            {
                //string b = "";
            }

            if (Session["gender"].ToString() == "" || Session["agree_afidavite"].ToString() == "")
            {
                //Response.Redirect("~/student/Dashboard.aspx");
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

    //protected void btn_print_Click(object sender, EventArgs e)
    //{
        //Session["ctrl"] = conpanel;
        //ClientScript.RegisterStartupScript(this.GetType(), "onclick", "<script language=javascript>window.open('Print.aspx','PrintMe','height=400px,width=900px,scrollbars=1');</script>");
    //}
}