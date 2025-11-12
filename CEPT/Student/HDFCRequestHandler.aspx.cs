using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_HDFCRequestHandler : System.Web.UI.Page
{
    public string strEncRequest = "";
    public string strAccessCode = "";
    public string strHDFCReqUrl = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["hdfc_request_url"] != null)
        {
            strHDFCReqUrl = Session["hdfc_request_url"].ToString();
            Session["hdfc_request_url"] = null;
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