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
            if (Session["user_type"].ToString() != "S" || Session["user_type"].ToString() != "E")
            {
                if (HttpContext.Current.Session["term_condition"] == "")
                {
                    Response.Redirect("~/term_and_condition.aspx?autho=false");
                }

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

    //     Session["ctrl"] = conpanel;
    //    ClientScript.RegisterStartupScript(this.GetType(), "onclick", "<script language=javascript>window.open('Print.aspx','PrintMe','height=400px,width=900px,scrollbars=1');</script>");
    //}
}