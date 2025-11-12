using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_Master_Student_wise_marks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        DataTable dt_course_detail = new DataTable();

        if (Session["user_type"].ToString() == "I2" || Session["user_type"].ToString() == "PC" || Session["user_type"].ToString() == "D")
        {
            if (Session["designation"].ToString() == "TA")
            {
                dt_course_detail = get_Course_Detail_TA(HttpContext.Current.Session["UserId"].ToString(), Request.QueryString["c"], Request.QueryString["s"], Request.QueryString["y"]);
            }
            else
            {
                if (Session["userid"].ToString() == "I2122002443" && Request.QueryString["s"].ToString() == "S" && Request.QueryString["y"].ToString() == "2023")
                {
                    dt_course_detail = get_Course_Detail_TA(HttpContext.Current.Session["UserId"].ToString(), Request.QueryString["c"], Request.QueryString["s"], Request.QueryString["y"]);
                }
                else 
                {
                    dt_course_detail = get_Course_Detail(HttpContext.Current.Session["UserId"].ToString(), Request.QueryString["s"], Request.QueryString["y"]);
                }
                
            }
        }
        else if (Session["user_type"].ToString() == "FA")
        {
            dt_course_detail = get_Course_Detail_FA(HttpContext.Current.Session["UserId"].ToString(), Request.QueryString["s"], Request.QueryString["y"]);
        }

        if (!IsPostBack)
        {
            if (dt_course_detail == null)
            {
                Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=false");
            }
            if (Session["user_type"].ToString() == "A1")
            {
                Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=false");
            }
            else if (Session["user_type"].ToString() == "S")
            {
                Response.Redirect("~/Student/Dashboard.aspx");
            }
            else if (Session["user_type"].ToString() == "I2" || Session["user_type"].ToString() == "PC" || Session["user_type"].ToString() == "D")
            {
                DataRow[] dr = dt_course_detail.Select("course_code='" + Request.QueryString["c"] + "'");

                if (dr.Length <= 0)
                {
                    Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=false");
                }
                else if (dr.Length > 0)
                {
                    if (dr[0]["faculty_approval"].ToString() == "Approved")
                    {
                        Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=app");
                    }
                }
            }

            else if (Session["user_type"].ToString() == "FA")
            {
                DataRow[] dr = dt_course_detail.Select("course_code='" + Request.QueryString["c"] + "'");

                if (dr.Length <= 0)
                {
                    Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=false");
                }
                else if (dr.Length > 0)
                {
                    if (dr[0]["faculty_approval"].ToString() == "Approved" && dr[0]["progcoordinate_approval"].ToString() == "Approved")
                    {
                        Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=app");
                    }
                }
            }
        }

        hdn_c.Value = Request.QueryString["c"];
        hdn_s.Value = Request.QueryString["s"];
        hdn_y.Value = Request.QueryString["y"];

        JavaScriptSerializer ser = new JavaScriptSerializer();
        Dictionary<string, object> sessionData = new Dictionary<string, object>();
        foreach (string key in Session.Keys)
        {
            sessionData[key] = Session[key];
        }

        hdn_session.Value = ser.Serialize(sessionData);
    }

    public DataTable get_Course_Detail(string user_id, string sem_code, string year_code)
    {
        string stud_detail = "";
        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select res3.*, " +
                            " (case grade_submit_detail.faculty_approved when 'Y' then 'Approved' else '' end) as 'faculty_approval', " +
                            " (case grade_submit_detail.progcoordinate_approved when 'Y' then 'Approved' else '' end) as 'progcoordinate_approval', " +
                            " (case grade_submit_detail.ugpgoffice_approved when 'Y' then 'Approved' else '' end) as 'ugpg_approval', " +
                            " (case grade_submit_detail.dean_approved when 'Y' then 'Approved' else '' end) as 'dean_approval' " +
                            " from " +
                            " ( select res1.* from ( " +
                            " select exams.course_code,exams.course_name,exams.total_exams,students.total_students from" +
                            " (select course_mst.course_code,course_mst.course_name,exams1.total_exams from course_mst " +
                                " left join(select course_code,COUNT(exam_code)total_exams from exam_master" +
                                            " where semester_type='" + sem_code + "' and year_semester='" + year_code + "' and cancel_flag='N'" +
                                            " group by course_code" +
                                        " )exams1" +
                                " on course_mst.course_code=exams1.course_code" +
                                " where course_mst.semester_type='" + sem_code + "' and course_mst.year_semester='" + year_code + "' and cancel_flag='N'" +
                            " )exams" +
                            " left join " +
                                " (SELECT course_code,COUNT(user_id)total_students" +
                                    " FROM student_course_allocate_dtl" +
                                    " where semester_type='" + sem_code + "' and year_semester='" + year_code + "'and cancel_flag = 'N'" +
                                    " group by course_code" +
                                " )students" +
                            " on exams.course_code=students.course_code" +
                            " )res1 " +
                            " inner join " +
                            " (" +
                                " select course_wise_instructor.*,instructor_mst.user_id,instructor_mst.instructor_name " +
                                " from course_wise_instructor" +
                                " inner join instructor_mst on instructor_mst.instructor_code=course_wise_instructor.instructor_code" +
                                " where instructor_mst.user_id='" + user_id + "' and course_wise_instructor.semester_type = '" + sem_code + "'" +
                                " and course_wise_instructor.year_semester = '" + year_code + "'" +
                            " )res2" +
                            " on res1.course_code = res2.course_code " +
                            " )res3 " +
                            " left join grade_submit_detail on grade_submit_detail.course_code = res3.course_code and grade_submit_detail.semester_type='" + sem_code + "' and grade_submit_detail.year_semester='" + year_code + "' " +
                            " order by res3.course_code";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_stud_detail = new DataTable();

            da.Fill(dt_stud_detail);
        }
        catch (Exception ex)
        {
        }

        if (dt_stud_detail.Rows.Count <= 0)
            return null;
        else
            return dt_stud_detail;
    }

    public DataTable get_Course_Detail_TA(string user_id, string c_code, string sem_code, string year_code)
    {
        string stud_detail = "";
        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select res3.*, " +
                            " (case grade_submit_detail.faculty_approved when 'Y' then 'Approved' else '' end) as 'faculty_approval', " +
                            " (case grade_submit_detail.progcoordinate_approved when 'Y' then 'Approved' else '' end) as 'progcoordinate_approval', " +
                            " (case grade_submit_detail.ugpgoffice_approved when 'Y' then 'Approved' else '' end) as 'ugpg_approval', " +
                            " (case grade_submit_detail.dean_approved when 'Y' then 'Approved' else '' end) as 'dean_approval' " +
                            " from " +
                            " ( select res1.* from ( " +
                            " select exams.course_code,exams.course_name,exams.total_exams,students.total_students from" +
                            " (select course_mst.course_code,course_mst.course_name,exams1.total_exams from course_mst " +
                                " left join(select course_code,COUNT(exam_code)total_exams from exam_master" +
                                            " where semester_type='" + sem_code + "' and year_semester='" + year_code + "' and cancel_flag='N'" +
                                            " group by course_code" +
                                        " )exams1" +
                                " on course_mst.course_code=exams1.course_code" +
                                " where course_mst.semester_type='" + sem_code + "' and course_mst.year_semester='" + year_code + "' and cancel_flag='N'" +
                            " )exams" +
                            " left join " +
                                " (SELECT course_code,COUNT(user_id)total_students" +
                                    " FROM student_course_allocate_dtl" +
                                    " where semester_type='" + sem_code + "' and year_semester='" + year_code + "'and cancel_flag = 'N'" +
                                    " group by course_code" +
                                " )students" +
                            " on exams.course_code=students.course_code" +
                            " )res1 " +
                            " inner join " +
                            " (" +
                                " select course_wise_TA.*,instructor_mst.user_id,instructor_mst.instructor_name " +
                                " from course_wise_TA" +
                                " inner join instructor_mst on instructor_mst.instructor_code=course_wise_TA.instructor_code" +
                                " where instructor_mst.user_id='" + user_id + "' and course_wise_TA.semester_type = '" + sem_code + "'" +
                                " and course_wise_TA.year_semester = '" + year_code + "'" +
                            " )res2" +
                            " on res1.course_code = res2.course_code " +
                            " )res3 " +
                            " left join grade_submit_detail on grade_submit_detail.course_code = res3.course_code and grade_submit_detail.semester_type='" + sem_code + "' and grade_submit_detail.year_semester='" + year_code + "' " +
                            " inner join department_wise_course_dtl on department_wise_course_dtl.course_code = res3.course_code and department_wise_course_dtl.semester_type='" + sem_code + "' and department_wise_course_dtl.year_semester='" + year_code + "' and department_wise_course_dtl.dept_code = '4' and res3.course_code='" + c_code + "'" +
                            " order by res3.course_code";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_stud_detail = new DataTable();

            da.Fill(dt_stud_detail);
        }
        catch (Exception ex)
        {
        }

        if (dt_stud_detail.Rows.Count <= 0)
            return null;
        else
            return dt_stud_detail;
    }

    public DataTable get_Course_Detail_FA(string user_id, string sem_code, string year_code)
    {
        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select res1.*, " +
                            " (case grade_submit_detail.faculty_approved when 'Y' then 'Approved' else '' end) as 'faculty_approval', " +
                            " (case grade_submit_detail.progcoordinate_approved when 'Y' then 'Approved' else '' end) as 'progcoordinate_approval', " +
                            " (case grade_submit_detail.ugpgoffice_approved when 'Y' then 'Approved' else '' end) as 'ugpg_approval'," +
                            " (case grade_submit_detail.dean_approved when 'Y' then 'Approved' else '' end) as 'dean_approval' " +
                            " from " +
                            " ( select exams.course_code,exams.course_name,exams.total_exams,students.total_students from" +
                            " (select course_mst.course_code,course_mst.course_name,exams1.total_exams from course_mst " +
                                " left join(select course_code,COUNT(exam_code)total_exams from exam_master" +
                                            " where semester_type='" + sem_code + "' and year_semester='" + year_code + "' and cancel_flag='N'" +
                                            " group by course_code" +
                                        " )exams1" +
                                " on course_mst.course_code=exams1.course_code" +
                                " where course_mst.semester_type='" + sem_code + "' and course_mst.year_semester='" + year_code + "' and cancel_flag='N'" +
                            " )exams" +
                            " left join " +
                                " (SELECT course_code,COUNT(user_id)total_students" +
                //" FROM student_wise_course_dtl" +
                                    " FROM student_course_allocate_dtl" +
                                    " where semester_type='" + sem_code + "' and year_semester='" + year_code + "'and cancel_flag = 'N'" +
                                    " group by course_code" +
                                " )students" +
                            " on exams.course_code=students.course_code" +
                            " )res1 " +
                            " left join grade_submit_detail on grade_submit_detail.course_code = res1.course_code and grade_submit_detail.semester_type='" + sem_code + "' and grade_submit_detail.year_semester='" + year_code + "' " +
                            " inner join (SELECT distinct course_mst.course_code" +
                                " FROM course_mst  " +
                                " inner join department_wise_course_dtl as dwc on dwc.course_code = course_mst.course_code " +
                                " inner join department_wise_user_dtl on department_wise_user_dtl.dept_code = dwc.dept_code" +
                                " where course_mst.cancel_flag='N' and course_mst.semester_type = '" + sem_code + "' and course_mst.year_semester = '" + year_code + "' " +
                                " and dwc.semester_type = '" + sem_code + "' and dwc.year_semester = '" + year_code + "'  " +
                                " and department_wise_user_dtl.user_id='" + user_id + "' and department_wise_user_dtl.user_type='FA' and department_wise_user_dtl.semester_type = '" + sem_code + "' and department_wise_user_dtl.year_semester = '" + year_code + "' " +
                            " )d on d.course_code = res1.course_code " +
                            " order by res1.course_code";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_stud_detail = new DataTable();

            da.Fill(dt_stud_detail);
        }
        catch (Exception ex)
        {
        }

        if (dt_stud_detail.Rows.Count <= 0)
            return null;
        else
            return dt_stud_detail;
    }

}