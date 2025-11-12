using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_TA_Application : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        
            hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
            string designation_value = HttpContext.Current.Session["designation"].ToString();
            hdn_icode.Value = Request.QueryString["ic"];
            hdn_icode_ex.Value = Request.QueryString["ie"];

            if (designation_value == "TA")
            {
            
                Response.Redirect("~/Admin/Master/Existing_TA_Application.aspx?ic=" + Session["UserId"].ToString() + "&type=tutor");
            }
            else if(designation_value != "TA" && designation_value != "temp") 
            {
            Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            }
        
    }
}