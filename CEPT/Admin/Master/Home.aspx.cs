using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
        hdn_user_type.Value = HttpContext.Current.Session["user_type"].ToString();
        hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
        hdn_is_submit.Value = HttpContext.Current.Session["is_submit"].ToString();

        if (!IsPostBack)
        {
            if (Request.QueryString["param"] != null && Request.QueryString["param"].ToString() == "true" && Request.QueryString["msg"] != null)
            {
                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();

                hdn_msg.Value = encode.DecryptData(Request.QueryString["msg"].ToString());
            }
        }
    }
}