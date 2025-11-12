using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_frmcoursemaster : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_utype.Value = Session["user_type"].ToString();
            hdn_c.Value = Request.QueryString["c"];
            hdn_s.Value = Request.QueryString["s"];
            hdn_y.Value = Request.QueryString["y"];
        }
    }
}