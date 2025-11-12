using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Reflection;

/// <summary>
/// Summary description for BasePage
/// </summary>
public class BasePage : System.Web.UI.Page
{
    public SBSMessageBox MessageBox;
    public BasePage()
    {
        
        base.Load += new EventHandler(BasePage_Load);
        MessageBox = new SBSMessageBox(this);
    }

    void BasePage_Load(object sender, EventArgs e)
    {
        if (!Temp.IsAuthenticationEnabled) return;
        object[] securityAttributes = this.GetType().GetCustomAttributes(typeof(SecurePageAttribute), true);
        if (securityAttributes.Length == 1)
        {
            if (!Convert.ToBoolean(Session["IsAuthenticated"]))
            {
                Session["after_login_redirect_page"] = Request.RawUrl;
                Response.Redirect("~/General/Login.aspx");
            }
        }
    }
}
[System.AttributeUsage(AttributeTargets.Class)]
public class SecurePageAttribute : System.Attribute
{
}

public static class Temp
{
    public static bool IsAuthenticationEnabled = true;
}