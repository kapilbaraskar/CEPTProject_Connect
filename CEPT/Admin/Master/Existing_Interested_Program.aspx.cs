using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Existing_Interested_Program : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
        hdn_studio_code_paremeter.Value = Request.QueryString.Get("studio_code");

        if (Session["user_type"].ToString() != "I2" && Session["user_type"].ToString() != "PC")
        {
            Response.Redirect("~/Admin/Master/Home.aspx");
        }
        if (Session["superviser_code"].ToString() == "")
        {
            if (Session["is_submit"].ToString() == "N")
            {
                //Response.Redirect("~/Admin/Master/Home.aspx");
                Response.Redirect("~/Admin/Master/vf_edit_personal_detail.aspx?ie=" + HttpContext.Current.Session["UserId"].ToString() + "&type=tutor");
            }
        }
    }
}