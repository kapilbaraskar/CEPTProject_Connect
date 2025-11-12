using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Feedback_dashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //Response.Redirect("~/Student/Dashboard.aspx");

            if (Session["user_type"].ToString() == "S")
            {
                //Response.Redirect("~/Student/Dashboard.aspx");
            }
            else if (Session["user_type"].ToString() == "E")
            {
                //Response.Redirect("~/Student/Dashboard.aspx");
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
            //else
            //{
            //    if (Session["user_dept"].ToString() == "F")
            //    {
            //        Response.Redirect("~/Student/student_dashboard.aspx");
            //    }
            //}
        }
    }
}