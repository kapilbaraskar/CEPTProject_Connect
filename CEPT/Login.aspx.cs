using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class test_login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Redirect("~/Site_maintenance.htm");

        if (Request.Params.Get("logout") == "2")
        {
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            Response.Buffer = true;
            Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
            Response.Expires = -1500;
            Response.CacheControl = "no-cache";
            Response.Cache.SetCacheability(HttpCacheability.NoCache);

            HttpCookie User_Details = Request.Cookies.Get("cept_login");

            if (User_Details != null)
            {
                User_Details = new HttpCookie("cept_login");
                User_Details.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(User_Details);
            }

            //HttpCookie session_cookie = Request.Cookies.Get("s_dtl");

            //if (session_cookie != null)
            //{
            //    session_cookie = new HttpCookie("s_dtl");
            //    session_cookie.Values.Add("s_start", "");
            //    Response.Cookies.Add(session_cookie);
            //}

           // string loggedOutPageUrl = "Login.aspx";
           // Response.Write("<script language='javascript'>");
           // Response.Write("function ClearHistory()");
           // Response.Write("{");
           // Response.Write(" var backlen=history.length;");
           // Response.Write(" history.go(-backlen);");
           //// Response.Write(" window.location.href='" + loggedOutPageUrl + "'; ");
           // Response.Write("}");
           // Response.Write("</script>");


            //Response.Cache.SetAllowResponseInBrowserHistory(false);
            //Response.Cache.SetCacheability(HttpCacheability.NoCache);
            //Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
            //Response.Cache.SetNoStore();
            //Response.Flush();
            //string strDisAbleBackButton;
            //strDisAbleBackButton = "<script language=javascript>\n";
            //strDisAbleBackButton += "window.history.forward(1);\n";
            //strDisAbleBackButton += "\n</script>";
            // ClientScript.RegisterClientScriptBlock(this.Page.GetType(), "clientScript", strDisAbleBackButton);

           // Page.ClientScript.RegisterStartupScript(this.GetType(), "clearHistory", "ClearHistory();", true);

        }
        else if (!IsPostBack)
        {
            if (Request.Cookies["cept_login"] != null)
            {
                Session["UserId"] = Request.Cookies["cept_login"].Values["user_id"];
                Session["UserName"] = Request.Cookies["cept_login"].Values["user_name"];
                Session["user_type"] = Request.Cookies["cept_login"].Values["user_type"];
                Session["dept_code"] = Request.Cookies["cept_login"].Values["dept_code"];
                Session["prog_code"] = Request.Cookies["cept_login"].Values["prog_code"];
                Session["semester_code"] = Request.Cookies["cept_login"].Values["semester_code"];
                Session["year_code"] = Request.Cookies["cept_login"].Values["year_code"];
                Session["prog_level_code"] = Request.Cookies["cept_login"].Values["prog_level_code"];
                Session["gender"] = Request.Cookies["cept_login"].Values["gender"];
            }
        }
    }
}