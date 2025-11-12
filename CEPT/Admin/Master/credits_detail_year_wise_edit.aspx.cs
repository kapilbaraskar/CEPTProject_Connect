using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_credits_detail_year_wise_edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_y.Value = Request.QueryString["y"];
            hdn_p.Value = Request.QueryString["p"];
            hdn_d.Value = Request.QueryString["d"];
            hdn_pl.Value = Request.QueryString["pl"];
        }
    }
}