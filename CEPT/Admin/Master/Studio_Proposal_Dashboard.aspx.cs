using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Studio_Proposal_Dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_user_type.Value = HttpContext.Current.Session["user_type"].ToString();
        hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
        hdn_is_submit.Value = HttpContext.Current.Session["is_submit"].ToString();
    }
}