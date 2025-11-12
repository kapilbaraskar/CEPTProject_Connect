using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ws_vf_edit_workload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_ccode.Value = Request.QueryString["cc"];
        hdn_scode.Value = Request.QueryString["sc"];
        hdn_ycode.Value = Request.QueryString["yc"];
        hdn_type.Value = Request.QueryString["ct"];
    }
}