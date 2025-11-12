using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class reset_password : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["reset_flag"] == "R")
        {

        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }

        if (Session["UserId"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

    }
}