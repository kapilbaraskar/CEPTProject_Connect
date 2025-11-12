using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_KotakRequestHandlerNR : System.Web.UI.Page
{
    public string strEncRequest = "";
    public string strAccessCode = "";
    public string strKotakReqUrl = "";
    public string command = "";
    public string request_type = "";
    public string response_type = "";
    public string version = "";

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

        command = "orderStatusTracker";
        request_type = "JSON";
        response_type = "JSON";
        version = "1.1";
    }
}