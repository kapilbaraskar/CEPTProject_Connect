using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_Faculty_report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_user_type.Value = Session["user_type"].ToString();
            //hdn_designation_type.Value = Session["designation"].ToString();
        }
    }
}