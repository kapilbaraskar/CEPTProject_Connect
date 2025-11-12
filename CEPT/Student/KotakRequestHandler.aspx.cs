using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_KotakRequestHandler : System.Web.UI.Page
{
    public string strEncRequest = "";
    public string strAccessCode = "";
    public string strKotakReqUrl = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["kotak_request_url"] != null)
        {
            strKotakReqUrl = Session["kotak_request_url"].ToString();
            Session["kotak_request_url"] = null;
        }

        if (Session["encRequest"] != null)
        {
            strEncRequest = Session["encRequest"].ToString();
            Session["encRequest"] = null;
        }

        if (Session["access_code"] != null)
        {
            strAccessCode = Session["access_code"].ToString();
            Session["access_code"] = null;
        }
    }
}