using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_vertical_studio_preferences_report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["user_type"] != null && Session["user_type"] != "")
        { 
            hdn_user_type.Value = Session["user_type"].ToString();
        }
       

    }
}