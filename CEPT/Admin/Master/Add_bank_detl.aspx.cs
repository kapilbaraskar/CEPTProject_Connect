using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Add_bank_detl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string desgination = Session["designation"].ToString();
            hdn_user_id.Value = Session["UserId"].ToString();
            hdn_studio_code.Value = Request.QueryString["studio_code"];
            hdn_c.Value = Request.QueryString["c"];
            hdn_s.Value = Request.QueryString["s"];
            hdn_y.Value = Request.QueryString["y"];
            hdn_bank.Value = Request.QueryString["b"];
            if (desgination.ToLower() == "instructor")
            {
                if (hdn_studio_code.Value.ToString() != "")
                {
                    Response.Redirect("~/Admin/Master/Studio_Brief_Details.aspx?studio_code=" + hdn_studio_code.Value.ToString() + "&s=" + hdn_s.Value.ToString() + "&y="+ hdn_y.Value.ToString());
                }
                else if (hdn_c.Value.ToString() != "")
                {
                    Response.Redirect("~/Admin/Master/Studio_Brief_Details.aspx?c=" + hdn_c.Value.ToString() + "&s=" + hdn_s.Value.ToString() + "&y=" + hdn_y.Value.ToString());
                }
            }
            else 
            {

            }
            
        }

    }
}