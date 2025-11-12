using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["SessionID"] == null && Session["HostIP"] == null)
        {
            Session["SessionID"] = HttpContext.Current.Session.SessionID;
            Session["HostIP"] = HttpContext.Current.Request.UserHostName;
        }
    }

    [WebMethod]
    public static String GetUserID(string name)
    {
        try
        {
           HttpContext.Current.Session["UserID"] = name;
                   
            return "";
        }
        catch (Exception ex)
        {
                

            return null;

        }
    }


    
}