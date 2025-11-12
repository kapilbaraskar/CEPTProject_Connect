using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master_WS;

public partial class Student_Student_Feedback_form : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_type"].ToString() == "S")
        {
            //Response.Redirect("~/Student/Dashboard.aspx");
        }
        else if (Session["user_type"].ToString() == "E")
        {
            //Response.Redirect("~/Student/Dashboard.aspx");
        }

        Masters_WS objmaster = new Masters_WS();

        if (!IsPostBack)
        {
            string course_code = "";

            if (Request.QueryString["course_code"] != null)
            {
                course_code = Request.QueryString["course_code"].ToString();

                if (course_code != "")
                {
                    course_code = course_code.Split('~')[0];
                }
            }

            string current_ws_sem = "";
            string current_ws_year = "";

            DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();

            if (dt_ws_current_sem != null)
            {
                current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
            }

            DataTable get_feedback_disable_data = objmaster.get_feedback_disable_course_data(current_ws_sem, current_ws_year, course_code);

            if (get_feedback_disable_data != null)
            {
                Response.Redirect("~/student/Feedback_dashboard.aspx");
            }

            //if (Session["gender"].ToString() == "" || Session["agree_afidavite"].ToString() == "")
            //{
            //    Response.Redirect("~/student/Dashboard.aspx");
            //}

            if (Session["user_type"].ToString() != "S")
            {
                //if (Session["gender"].ToString() == "")
                //{
                //    Response.Redirect("~/student/Dashboard.aspx");
                //}

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
        }
    }
}