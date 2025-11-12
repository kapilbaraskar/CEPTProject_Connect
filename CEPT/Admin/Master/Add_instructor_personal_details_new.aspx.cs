using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Add_instructor_personal_details_new : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["i"] != null)
        {
            hdn_instructor.Value = Request.QueryString["i"];
        }
        else
        {
            hdn_instructor.Value = "";
        }
    }
}