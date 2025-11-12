using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using System.Data;


public partial class Admin_Master_frm_personal_details : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {
            hdn_user_name.Value = Session["UserName"].ToString();
            hdn_user_type.Value = Session["designation"].ToString();
            DataTable dt_check_rights = objmaster.get_personal_details_rights(Session["UserId"].ToString());

            if (dt_check_rights == null)
            {
              //  Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            }

            if (Session["UserId"].ToString() != "178" && Session["UserId"].ToString() != "23" && Session["UserId"].ToString() != "47" && Session["UserId"].ToString() != "140" && Session["UserId"].ToString() != "33" && Session["UserId"].ToString() != "243")
            {
               
            }
        }
    }
}