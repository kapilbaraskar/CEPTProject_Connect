using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_CreateInstPDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_icode.Value = Request.QueryString["ic"].ToString();
        hdn_isem.Value = Request.QueryString["is"].ToString();
        hdn_iyear.Value = Request.QueryString["iy"].ToString();
    }
}