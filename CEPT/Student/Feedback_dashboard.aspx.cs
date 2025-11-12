using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class Student_Feedback_dashboard : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["year_code"].ToString() == "Y2016")
        {
            //Response.Redirect("~/Student/Dashboard.aspx", false);
        }
        else
        {
            //  string b = "";
        }
     //   Response.Redirect("~/Student/Dashboard.aspx");

        if (!IsPostBack)
        {
            try
            {
                if (Session["UserId"].ToString() != "")
                {
                    string mail = objmaster.Get_user_mail(Session["UserId"].ToString());

                    if (mail != "")
                    {
                        DataTable dt_multipel_email = objmaster.Get_multiple_same_email_user(mail);

                        if (dt_multipel_email != null)
                        { 
                            if (dt_multipel_email.Rows.Count > 1)
                            {
                                string url = "~/student/select_program.aspx";
                                Response.Redirect(url, false);
                            }
                        }
                    }
                }

                if (Session["user_type"].ToString() != "S")
                {

                    if (Session["user_type"].ToString() == "I")
                    {
                        Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                    }
                    else if (Session["user_type"].ToString() == "A")
                    {
                        Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                    }
                    else if (Session["user_type"].ToString() == "A1")
                    {
                        Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                    }

                }
                else
                {
                    if (Session["user_dept"].ToString() == "F")
                    {
                        if (HttpContext.Current.Session["prog_level_code"].ToString() == "PT555555")
                        {
                            Response.Redirect("~/student/Fees_dashboard.aspx", false);
                        }
                    }
                }
            }
            catch (Exception)
            {

                Response.Redirect("~/Login.aspx?logout=2");
            }
        }
    }
}