using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Serialization;

public partial class Admin_Master_user_upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string user = Session["UserId"].ToString();

        Dictionary<string, string> dic_session = new Dictionary<string, string>();

        dic_session["is_special_user"] = Session["is_special_user"].ToString();
        dic_session["start_date"] = Session["start_date"].ToString();
        dic_session["end_date"] = Session["end_date"].ToString();
        dic_session["SessionId"] = Session["SessionId"].ToString();
        dic_session["UserId"] = Session["UserId"].ToString();
        dic_session["UserName"] = Session["UserName"].ToString();
        dic_session["user_type"] = Session["user_type"].ToString();

        //["dept_code","prog_code","prog_level_code","user_type","year_code","student_code","gender","agree_afidavite","IsAuthenticated","UserLevelRights","UserMenuRights"]
        
        JavaScriptSerializer ser = new JavaScriptSerializer();
        
        hdn_session.Value = (ser.Serialize(dic_session));

        if (!IsPostBack)
        {
            if (Session["user_type"].ToString() != "A")
            {


                if (Session["user_type"].ToString() == "S")
                {
                    Response.Redirect("~/Student/Dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "I")
                {
                    Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                }
                //else if (Session["user_type"].ToString() == "A1")
                //{
                    //Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                //}
                //else if (Session["user_type"].ToString() == "PC")
                //{
                //    Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                //}
                else if (Session["user_type"].ToString() == "I2")
                {
                    Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                }

            }
        }
    }

    
}