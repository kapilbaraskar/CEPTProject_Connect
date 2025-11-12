using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_frmcoursemaster_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_utype.Value = Session["user_type"].ToString();
            hdn_uid.Value = Session["userid"].ToString();
        }
    }
}