using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_FoundationGradeReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_uid.Value = Request.QueryString["uid"];
        hdn_sem.Value = Request.QueryString["sem"];
        hdn_year.Value = Request.QueryString["year"];

        GradeReportDetail grd = new GradeReportDetail();
        string stud_detail = "";
        string course_detail = "";
        string ws_course_detail = "";
        string credit_detail = "";

        DataTable dt_stud_detail = grd.get_Student_Detail(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);
        DataTable dt_course_detail = grd.get_Course_Detail(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);
        DataTable dt_grade_range = grd.get_Grade_Range(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);
        DataTable dt_ws_course_detail = grd.get_WS_Course_Detail(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);
        DataTable dt_ws_grade_range = grd.get_WS_Grade_Range(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);

        DataTable dt_course_grade_detail = grd.Calculate_grade(dt_stud_detail, dt_course_detail, dt_grade_range);
        DataTable dt_ws_course_grade_detail = grd.WS_Calculate_grade(dt_stud_detail, dt_ws_course_detail, dt_ws_grade_range);
        DataTable dt_credit_detail = grd.Calculate_credits(dt_course_grade_detail, dt_ws_course_grade_detail);

        if (dt_stud_detail != null)
        {
            stud_detail = grd.GetJson1(dt_stud_detail);
        }

        if (dt_course_grade_detail != null)
        {
            course_detail = grd.GetJson1(dt_course_grade_detail);
        }

        if (dt_ws_course_grade_detail != null)
        {
            ws_course_detail = grd.GetJson1(dt_ws_course_grade_detail);
        }

        if (dt_credit_detail != null)
        {
            credit_detail = grd.GetJson1(dt_credit_detail);
        }

        hdn_stud_detail.Value = stud_detail;
        hdn_course_detail.Value = course_detail;
        hdn_ws_course_detail.Value = ws_course_detail;
        hdn_credit_detail.Value = credit_detail;
    }
}