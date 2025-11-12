using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_WS_SWS_Course_Cancel_Students : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_c.Value = Request.QueryString["c"];
            hdn_s.Value = Request.QueryString["s"];
            hdn_y.Value = Request.QueryString["y"];
        }
    }
}