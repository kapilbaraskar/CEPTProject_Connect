using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ws_course_budget_dtl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_course_code.Value = Request.QueryString["c"];
            hdn_sem.Value = Request.QueryString["s"];
            hdn_year.Value = Request.QueryString["y"];
        }
    }
}