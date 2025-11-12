using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Scholarship_amount_dtl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_sem.Value = Request.QueryString["s"];
        hdn_year.Value = Request.QueryString["y"];
       // hdn_inst_no.Value = Request.QueryString["i"];
        hdn_user_id.Value = Request.QueryString["c"];
    }
}