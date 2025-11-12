using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Apprisal_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["c"] != null && Request.QueryString["c"] != "")
        {
            hdn_user_id.Value = Request.QueryString["c"].ToString();
            hdn_year.Value = Request.QueryString["y"].ToString();
            hdn_user_type.Value = Request.QueryString["u"].ToString();
            hdn_comment_type.Value = Request.QueryString["w"].ToString();
        }
    }

   

}