using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Authenticated_Pages_NFA_AMENDEMENT_Print : System.Web.UI.Page
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
        //Control ctrl = (Control)Session["ctrl"];
        
        //PrintHelper.PrintWebControl(ctrl);
       
    }
}