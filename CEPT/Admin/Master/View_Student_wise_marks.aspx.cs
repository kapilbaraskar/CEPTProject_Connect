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

public partial class Admin_Master_View_Student_wise_marks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DataTable dt_my_course_detail = new DataTable();
        DataTable dt_pc_course_detail = new DataTable();

        if (Session["user_type"].ToString() == "I2" || Session["user_type"].ToString() == "PC")
        {
            dt_my_course_detail = get_my_Course_Detail(HttpContext.Current.Session["UserId"].ToString(), Request.QueryString["s"], Request.QueryString["y"]);
        }
        if (Session["user_type"].ToString() == "PC")
        {
            dt_pc_course_detail = get_pc_Course_Detail(HttpContext.Current.Session["UserId"].ToString(), Request.QueryString["s"], Request.QueryString["y"]);
        }

        if (!IsPostBack)
        {
            if (Session["user_type"].ToString() == "S")
            {
                Response.Redirect("~/Student/Dashboard.aspx");
            }
            else if (Session["user_type"].ToString() == "I2")
            {
                DataRow[] dr = dt_my_course_detail.Select("course_code='" + Request.QueryString["c"] + "'");

                if (dr.Length <= 0)
                {
                    Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=false");
                }
            }
            else if (Session["user_type"].ToString() == "PC")
            {
                DataRow[] dr = dt_pc_course_detail.Select("course_code='" + Request.QueryString["c"] + "'");

                if (dr.Length <= 0)
                {
                    DataRow[] dr1 = dt_my_course_detail.Select("course_code='" + Request.QueryString["c"] + "'");

                    if (dr1.Length <= 0)
                    {
                        Response.Redirect("~/Admin/Master/Course_wise_entered_marks.aspx?autho=false");
                    }
                    else if (dr1.Length > 0)
                    {
                        hdn_pc.Value = "PCI2";
                    }
                }
            }
        }

        hdn_c.Value = Request.QueryString["c"];
        hdn_s.Value = Request.QueryString["s"];
        hdn_y.Value = Request.QueryString["y"];
    }

    public DataTable get_my_Course_Detail(string user_id, string sem_code, string year_code)
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

    public DataTable get_pc_Course_Detail(string user_id, string sem_code, string year_code)
    {
        string stud_detail = "";
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
                                    " FROM student_course_allocate_dtl" +
                                    " where semester_type='" + sem_code + "' and year_semester='" + year_code + "'and cancel_flag = 'N'" +
                                    " group by course_code" +
                                " )students" +
                            " on exams.course_code=students.course_code" +
                            " )res1 " +
                            " left join grade_submit_detail on grade_submit_detail.course_code = res1.course_code and grade_submit_detail.semester_type='" + sem_code + "' and grade_submit_detail.year_semester='" + year_code + "' " +

                            " inner join (SELECT distinct course_mst.course_code " +
                                        " FROM course_mst " +
                                        " inner join department_wise_course_dtl as dwc on dwc.course_code = course_mst.course_code" +
                                        " inner join programme_coordinator_dtl as pcd on pcd.dept_code = dwc.dept_code and pcd.prog_code=dwc.prog_code " +
                                        " where course_mst.cancel_flag='N' and course_mst.semester_type = '" + sem_code + "' and course_mst.year_semester = '" + year_code + "'" +
                                        " and dwc.semester_type = '" + sem_code + "' and dwc.year_semester = '" + year_code + "' " +
                                        " and pcd.user_id='" + user_id + "' and pcd.semester_type = '" + sem_code + "' and pcd.year_semester = '" + year_code + "'" +
                            " )pc on pc.course_code = res1.course_code" +

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