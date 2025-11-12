using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_VF_Finance_Report_Print_new : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_sem.Value = Request.QueryString["sem"];
        hdn_year.Value = Request.QueryString["year"];
        hdn_dept.Value = Request.QueryString["dept"];
        hdn_prog.Value = Request.QueryString["prog"];
    }
}