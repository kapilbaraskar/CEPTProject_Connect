using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class Admin_Master_Alumni_verification : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Session["user_type"].ToString() == "AL")
        {
           
        }
        else
        {
            string user_id = HttpContext.Current.Session["UserId"].ToString();

            Masters objmaster = new Masters();

            DataTable dt = objmaster.get_alumini_verifications_rights(user_id);

            if (dt == null)
            {
                Response.Redirect("Home.aspx");
            }
        }
        

       
    }
}