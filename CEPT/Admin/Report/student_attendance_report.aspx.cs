using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_student_attendance_report : System.Web.UI.Page
{
    string course_code = "";
    string year_type = "";
    string semester = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        course_code = Request.QueryString.Get("c");
        year_type = Request.QueryString.Get("y");
        semester = Request.QueryString.Get("s");
        if (course_code == null && course_code == string.Empty)
        {
            Response.Redirect("~/Admin/Report/course_wise_attendance_dtl.aspx?autho=false");
        }
        else
        {
            hdn_code.Value = course_code;
            hdn_semester.Value = semester;
            hdn_year.Value = year_type;
        }
    }
}