using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_DRP_Request_form : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string inst_code = HttpContext.Current.Session["UserName"].ToString();
        hdn_inst_code.Value = inst_code;
        if (Request.QueryString["d"] != "" && Request.QueryString["d"] != null)
        {
            hdn_drp.Value = Request.QueryString["d"];
            hdn_sem.Value = Request.QueryString["s"];
            hdn_year.Value = Request.QueryString["y"];
            hdn_course.Value = Request.QueryString["c"];

        }
        

    }
}