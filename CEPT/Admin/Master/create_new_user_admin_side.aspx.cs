using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_create_new_user_admin_side : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["c"].ToString() == "N" )
        {
            hdn_user_type.Value = Request.QueryString["c"].ToString();
        }
        else
        {
            hdn_user_type.Value = Request.QueryString["c"].ToString();
            hdn_user_id.Value = Request.QueryString["i"].ToString();
        }
    }
}