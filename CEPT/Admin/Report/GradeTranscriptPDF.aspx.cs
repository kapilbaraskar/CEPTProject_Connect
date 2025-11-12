using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

public partial class Admin_Report_GradeTranscriptPDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_uid.Value = Request.QueryString["uid"];
        hdn_sem.Value = Request.QueryString["sem"];
        hdn_year.Value = Request.QueryString["year"];

        GradeReportDetail grd = new GradeReportDetail();
        
        string stud_detail = "";
        string transcript_detail = "";
        JavaScriptSerializer ser = new JavaScriptSerializer();
        List<Dictionary<string, string>> lst_course_detail = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> lst_dic_tran_sem_year = new List<Dictionary<string, string>>();

        DataTable dt_stud_detail = grd.get_Student_Detail(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);
        DataTable dt_transcript_detail = get_Student_transcript_dtl(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);

        if (dt_stud_detail != null)
        {
            stud_detail = grd.GetJson1(dt_stud_detail);
        }
        if (dt_transcript_detail != null)
        {
            transcript_detail = grd.GetJson1(dt_transcript_detail);
        }

        lst_dic_tran_sem_year.Add(new Dictionary<string, string>());
        lst_dic_tran_sem_year[0]["sem_code"] = hdn_sem.Value;
        lst_dic_tran_sem_year[0]["year_code"] = hdn_year.Value;

        for (int i = 0; i < 3; i++)
        {
            lst_dic_tran_sem_year.Add(new Dictionary<string, string>());

            if (lst_dic_tran_sem_year[i]["sem_code"] == "M")
            {
                lst_dic_tran_sem_year[i + 1]["sem_code"] = "S";
                //lst_dic_tran_sem_year[i + 1]["year_code"] = lst_dic_tran_sem_year[i]["year_code"];
                lst_dic_tran_sem_year[i + 1]["year_code"] = (Convert.ToInt32(lst_dic_tran_sem_year[i]["year_code"]) + 1).ToString();
            }
            else if (lst_dic_tran_sem_year[i]["sem_code"] == "S")
            {
                lst_dic_tran_sem_year[i + 1]["sem_code"] = "M";
                //lst_dic_tran_sem_year[i + 1]["year_code"] = (Convert.ToInt32(lst_dic_tran_sem_year[i]["year_code"]) + 1).ToString();
                lst_dic_tran_sem_year[i + 1]["year_code"] = lst_dic_tran_sem_year[i]["year_code"];
            }
        }

        for (int i = 0; i < lst_dic_tran_sem_year.Count; i++)
        {
            string course_detail = "";
            string ws_course_detail = "";
            string credit_detail = "";

            DataTable dt_course_detail = grd.get_Course_Detail(hdn_uid.Value, lst_dic_tran_sem_year[i]["sem_code"], lst_dic_tran_sem_year[i]["year_code"]);
            DataTable dt_grade_range = grd.get_Grade_Range(hdn_uid.Value, lst_dic_tran_sem_year[i]["sem_code"], lst_dic_tran_sem_year[i]["year_code"]);
            DataTable dt_ws_course_detail = grd.get_WS_Course_Detail(hdn_uid.Value, lst_dic_tran_sem_year[i]["sem_code"], lst_dic_tran_sem_year[i]["year_code"]);

            DataTable dt_course_grade_detail = grd.Calculate_grade(dt_stud_detail, dt_course_detail, dt_grade_range);
            DataTable dt_credit_detail = grd.Calculate_credits(dt_course_grade_detail, dt_ws_course_detail);

            if (dt_course_grade_detail != null)
            {
                if (dt_course_grade_detail.Select("remarks='PASS'").Length > 0)
                {
                    dt_course_grade_detail = dt_course_grade_detail.Select("remarks='PASS'").CopyToDataTable();
                    course_detail = grd.GetJson1(dt_course_grade_detail);
                }
            }

            if (dt_ws_course_detail != null)
            {
                if (dt_ws_course_detail.Select("Total>49").Length > 0)
                {
                    dt_ws_course_detail = dt_ws_course_detail.Select("Total>49").CopyToDataTable();
                    ws_course_detail = grd.GetJson1(dt_ws_course_detail);
                }
            }

            if (dt_credit_detail != null)
            {
                credit_detail = grd.GetJson1(dt_credit_detail);
            }

            Dictionary<string, string> dic_course_detail = new Dictionary<string, string>();

            dic_course_detail["course_detail"] = course_detail;
            dic_course_detail["ws_course_detail"] = ws_course_detail;
            dic_course_detail["credit_detail"] = credit_detail;

            lst_course_detail.Add(dic_course_detail);
        }

        hdn_stud_detail.Value = stud_detail;
        hdn_transcript_detail.Value = transcript_detail;
        if (lst_course_detail.Count > 0)
        {
            hdn_course_detail.Value = ser.Serialize(lst_course_detail);
        }
        else
        {
            hdn_course_detail.Value = "";
        }
        //hdn_ws_course_detail.Value = ser.Serialize(lst_course_detail);
        //hdn_credit_detail.Value = credit_detail;
    }

    public DataTable get_Student_transcript_dtl(string uid, string sem, string year)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select * from student_transcript_dtl where user_id = '" + uid + "' ";
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


//public class GradeTranscriptDetail
//{
//    //BLL.Master.Masters objMaster = new BLL.Master.Masters();
//    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

//    public DataTable get_Student_Detail(string uid, string sem, string year)
//    {
//        DataTable dt_stud_detail = new DataTable();
//        try
//        {
//            SqlCommand cmd = con.CreateCommand();

//            cmd.CommandText = "select user_mst.*,UPPER(department_mst.dept_name)dept_name,UPPER(programme_mst.prog_name)prog_name,programme_level_mst.prog_level_name from user_mst " +
//                              " inner join department_mst on department_mst.dept_code = user_mst.dept_code" +
//                              " inner join programme_mst on programme_mst.prog_code = user_mst.prog_code" +
//                              " left join programme_level_mst on programme_level_mst.prog_level_code = user_mst.prog_level_code" +
//                              " where user_mst.user_id = '" + uid + "' and user_mst.cancel_flag='N' " +
//                              " and department_mst.cancel_flag='N' and programme_mst.cancel_flag='N'";
//            cmd.CommandType = CommandType.Text;

//            SqlDataAdapter da = new SqlDataAdapter(cmd);

//            dt_stud_detail = new DataTable();

//            da.Fill(dt_stud_detail);
//        }
//        catch (Exception ex)
//        {
//        }

//        if (dt_stud_detail.Rows.Count <= 0)
//            return null;
//        else
//            return dt_stud_detail;
//    }

//    public DataTable get_Course_Detail(string uid, string sem, string year)
//    {
//        DataTable dt_course_detail = new DataTable();

//        try
//        {
//            SqlCommand cmd = con.CreateCommand();

//            cmd.CommandText = "select " +
//                              " ROUND((ISNULL(exam_1_w,0)+ISNULL(exam_2_w,0)+ISNULL(exam_3_w,0)+ISNULL(exam_4_w,0)+ISNULL(exam_5_w,0)" +
//                              " +ISNULL(exam_6_w,0)+ISNULL(exam_7_w,0)+ISNULL(exam_8_w,0)+ISNULL(exam_9_w,0)+ISNULL(exam_10_w,0)" +
//                              " ),0) as Total ,(sca.course_type)c_type,(case sca.gpa_nongpa when '' then NULL else sca.gpa_nongpa end)gpa_nongpa,cm.* " +
//                              " from student_exam_marks_dtl as sm" +
//                              " inner join student_course_allocate_dtl as sca on sca.user_id=sm.student_code and sca.course_code=sm.course_code" +
//                              " inner join course_mst as cm on cm.course_code=sm.course_code" +
//                              " inner join grade_submit_detail as gsd on gsd.course_code=sm.course_code" +
//                              " where sm.cancel_flag='N' and sm.semester_type='" + sem + "' and sm.year_semester='" + year + "' and sm.student_code='" + uid + "'" +
//                              " and sca.cancel_flag='N' and sca.semester_type='" + sem + "' and sca.year_semester='" + year + "'" +
//                              " and cm.cancel_flag='N' and cm.semester_type='" + sem + "' and cm.year_semester='" + year + "'" +
//                              " and gsd.cancel_flag='N' and gsd.semester_type='" + sem + "' and gsd.year_semester='" + year + "' and gsd.ugpgoffice_approved='Y'" +
//                              " order by c_type desc,gpa_nongpa,course_code";

//            cmd.CommandType = CommandType.Text;

//            SqlDataAdapter da = new SqlDataAdapter(cmd);

//            dt_course_detail = new DataTable();

//            da.Fill(dt_course_detail);
//        }
//        catch (Exception ex)
//        {
//        }

//        if (dt_course_detail.Rows.Count <= 0)
//            return null;
//        else
//            return dt_course_detail;
//    }

//    public DataTable get_WS_Course_Detail(string uid, string sem, string year)
//    {
//        if (sem == "S")
//        {
//            int w_year;
//            if (int.TryParse(year, out w_year))
//            {
//                year = (w_year + 1).ToString();
//            }
//        }
//        else if (sem == "M")
//        {
//            sem = "W";
//        }

//        //if (sem == "S")
//        //{
//        //    sem = "W";
//        //}
//        //else if (sem == "M")
//        //{
//        //    sem = "S";
//        //}

//        DataTable dt_course_detail = new DataTable();

//        try
//        {
//            SqlCommand cmd = con.CreateCommand();

//            cmd.CommandText = "select " +
//                              " ROUND((ISNULL(exam_1_w,0)+ISNULL(exam_2_w,0)+ISNULL(exam_3_w,0)+ISNULL(exam_4_w,0)+ISNULL(exam_5_w,0)" +
//                              " +ISNULL(exam_6_w,0)+ISNULL(exam_7_w,0)+ISNULL(exam_8_w,0)+ISNULL(exam_9_w,0)+ISNULL(exam_10_w,0)" +
//                              " ),0) as Total ,(sca.course_type)c_type,sca.gpa_nongpa,cm.* " +
//                              " from ws_student_exam_marks_dtl as sm" +
//                              " inner join ws_student_course_allocate_dtl as sca on sca.user_id=sm.student_code and sca.course_code=sm.course_code" +
//                              " inner join ws_course_mst as cm on cm.course_code=sm.course_code" +
//                              " inner join ws_grade_submit_detail as gsd on gsd.course_code=sm.course_code" +
//                              " where sm.cancel_flag='N' and sm.semester_type='" + sem + "' and sm.year_semester='" + year + "' and sm.student_code='" + uid + "'" +
//                              " and sca.cancel_flag='N' and sca.semester_type='" + sem + "' and sca.year_semester='" + year + "'" +
//                              " and cm.cancel_flag='N' and cm.semester_type='" + sem + "' and cm.year_semester='" + year + "'" +
//                              " and gsd.cancel_flag='N' and gsd.semester_type='" + sem + "' and gsd.year_semester='" + year + "' and gsd.ugpgoffice_approved='Y'" +
//                              " order by course_code";

//            cmd.CommandType = CommandType.Text;

//            SqlDataAdapter da = new SqlDataAdapter(cmd);

//            dt_course_detail = new DataTable();

//            da.Fill(dt_course_detail);
//        }
//        catch (Exception ex)
//        {
//        }

//        if (dt_course_detail.Rows.Count <= 0)
//            return null;
//        else
//            return dt_course_detail;
//    }

//    public DataTable get_Grade_Range(string uid, string sem, string year)
//    {
//        DataTable dt_grade_range = new DataTable();
//        try
//        {
//            SqlCommand cmd = con.CreateCommand();

//            cmd.CommandText = "select * from course_wise_grade_range where semester_type='" + sem + "' and year_semester='" + year + "'";
//            cmd.CommandType = CommandType.Text;

//            SqlDataAdapter da = new SqlDataAdapter(cmd);

//            dt_grade_range = new DataTable();

//            da.Fill(dt_grade_range);

//        }
//        catch (Exception ex)
//        {
//        }

//        if (dt_grade_range.Rows.Count <= 0)
//            return null;
//        else
//            return dt_grade_range;
//    }

//    public DataTable Calculate_grade(DataTable dt_stud_detail, DataTable dt_course_detail, DataTable dt_grade_range)
//    {
//        if (dt_stud_detail != null && dt_course_detail != null && dt_stud_detail.Rows.Count > 0 && dt_course_detail.Rows.Count > 0)
//        {
//            try
//            {
//                int year = Convert.ToInt32((dt_stud_detail.Rows[0]["year_code"].ToString()).Substring(1));

//                dt_course_detail.Columns.Add("grade");
//                dt_course_detail.Columns.Add("grade_point");
//                dt_course_detail.Columns.Add("remarks");

//                for (int i = 0; i < dt_course_detail.Rows.Count; i++)
//                {
//                    double subject_marks = Convert.ToDouble(dt_course_detail.Rows[i]["Total"].ToString());

//                    string str_course = dt_course_detail.Rows[i]["course_code"].ToString();
//                    DataRow[] course_range = dt_grade_range.Select("course_code = '" + str_course + "'");
//                    bool gpa_less_9_flag = false;

//                    if (course_range[0]["A_plus_from"].ToString() == "87")
//                    {
//                        gpa_less_9_flag = true;
//                    }

//                    if (dt_course_detail.Rows[i]["c_type"].ToString() == "E" && dt_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
//                    {
//                        if (subject_marks < 50)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "NP";
//                            dt_course_detail.Rows[i]["grade_point"] = "NA";
//                            dt_course_detail.Rows[i]["remarks"] = "FAIL";
//                        }
//                        else if (subject_marks >= 50)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "P";
//                            dt_course_detail.Rows[i]["grade_point"] = "NA";
//                            dt_course_detail.Rows[i]["remarks"] = "PASS";
//                        }
//                    }
//                    else if (year < 2014 || gpa_less_9_flag)
//                    {
//                        dt_course_detail.Rows[i]["remarks"] = "PASS";
//                        if (subject_marks < 50)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "F";
//                            dt_course_detail.Rows[i]["grade_point"] = "0";
//                            dt_course_detail.Rows[i]["remarks"] = "FAIL";
//                        }
//                        else if (subject_marks >= 87)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "A+";
//                            dt_course_detail.Rows[i]["grade_point"] = "4.00";
//                        }
//                        else if (subject_marks >= 83)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "A";
//                            dt_course_detail.Rows[i]["grade_point"] = "4.00";
//                        }
//                        else if (subject_marks >= 80)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "A-";
//                            dt_course_detail.Rows[i]["grade_point"] = "3.67";
//                        }
//                        else if (subject_marks >= 77)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "B+";
//                            dt_course_detail.Rows[i]["grade_point"] = "3.33";
//                        }
//                        else if (subject_marks >= 73)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "B";
//                            dt_course_detail.Rows[i]["grade_point"] = "3.00";
//                        }
//                        else if (subject_marks >= 70)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "B-";
//                            dt_course_detail.Rows[i]["grade_point"] = "2.67";
//                        }
//                        else if (subject_marks >= 67)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "C+";
//                            dt_course_detail.Rows[i]["grade_point"] = "2.33";
//                        }
//                        else if (subject_marks >= 63)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "C";
//                            dt_course_detail.Rows[i]["grade_point"] = "2.00";
//                        }
//                        else if (subject_marks >= 60)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "C-";
//                            dt_course_detail.Rows[i]["grade_point"] = "1.67";
//                        }
//                        else if (subject_marks >= 57)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "D+";
//                            dt_course_detail.Rows[i]["grade_point"] = "1.33";
//                        }
//                        else if (subject_marks >= 53)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "D";
//                            dt_course_detail.Rows[i]["grade_point"] = "1.00";
//                        }
//                        else if (subject_marks >= 50)
//                        {
//                            dt_course_detail.Rows[i]["grade"] = "D-";
//                            dt_course_detail.Rows[i]["grade_point"] = "0.67";
//                        }
//                    }
//                    else
//                    {
//                        if (dt_grade_range != null)
//                        {
//                            //string str_course = dt_course_detail.Rows[i]["course_code"].ToString();
//                            //DataRow[] course_range = dt_grade_range.Select("course_code = '" + str_course + "'");

//                            if (course_range.Length > 0)
//                            {
//                                dt_course_detail.Rows[i]["remarks"] = "PASS";
//                                if (subject_marks < 50)
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "F";
//                                    dt_course_detail.Rows[i]["grade_point"] = "0";
//                                    dt_course_detail.Rows[i]["remarks"] = "FAIL";
//                                }
//                                else if (subject_marks >= 90)
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "A+";
//                                    dt_course_detail.Rows[i]["grade_point"] = "4.3";
//                                }
//                                else if (course_range[0]["SD"].ToString() == System.DBNull.Value.ToString())
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "B-";
//                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
//                                }
//                                else if (Convert.ToDouble(course_range[0]["SD"].ToString()) == 0)
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "B-";
//                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["A_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "A";
//                                    dt_course_detail.Rows[i]["grade_point"] = "4.0";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["A_minus_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "A-";
//                                    dt_course_detail.Rows[i]["grade_point"] = "3.7";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_plus_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "B+";
//                                    dt_course_detail.Rows[i]["grade_point"] = "3.3";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "B";
//                                    dt_course_detail.Rows[i]["grade_point"] = "3.0";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_minus_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "B-";
//                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_plus_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "C+";
//                                    dt_course_detail.Rows[i]["grade_point"] = "2.3";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "C";
//                                    dt_course_detail.Rows[i]["grade_point"] = "2.0";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_minus_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "C-";
//                                    dt_course_detail.Rows[i]["grade_point"] = "1.7";
//                                }
//                                else if (subject_marks >= Convert.ToDouble(course_range[0]["D_plus_from"].ToString()))
//                                {
//                                    dt_course_detail.Rows[i]["grade"] = "D+";
//                                    dt_course_detail.Rows[i]["grade_point"] = "1.3";
//                                }
//                            }
//                        }
//                    }

//                }
//            }
//            catch (Exception ex)
//            {

//            }
//        }

//        return dt_course_detail;
//    }

//    public DataTable Calculate_credits(DataTable dt_course_grade_detail, DataTable dt_ws_course_detail)
//    {
//        DataTable dt_credit_detail = new DataTable();
//        dt_credit_detail.Columns.Add("total_credit");
//        dt_credit_detail.Columns.Add("core_credit");
//        dt_credit_detail.Columns.Add("elective_credit");
//        dt_credit_detail.Columns.Add("gpa_credit");
//        dt_credit_detail.Columns.Add("ngpa_credit");
//        dt_credit_detail.Columns.Add("semester_marks_avg");
//        dt_credit_detail.Columns.Add("grade_point_avg");
//        dt_credit_detail.Columns.Add("grade_point_ratio");
//        dt_credit_detail.Columns.Add("sws_credit");

//        if (dt_course_grade_detail != null)
//        {
//            if (dt_course_grade_detail.Rows.Count > 0)
//            {
//                DataRow dr = dt_credit_detail.NewRow();
//                dr["total_credit"] = "0";
//                dr["core_credit"] = "0";
//                dr["elective_credit"] = "0";
//                dr["gpa_credit"] = "0";
//                dr["ngpa_credit"] = "0";
//                dr["semester_marks_avg"] = "0";
//                dr["grade_point_avg"] = "0";
//                dr["grade_point_ratio"] = "0";
//                dr["sws_credit"] = "0";

//                double total_gpa_marks = 0;
//                double gpa_multiplication = 0;
//                double total_gpa_credit = 0;

//                for (int i = 0; i < dt_course_grade_detail.Rows.Count; i++)
//                {
//                    if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
//                    {
//                        dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
//                    }

//                    if (dt_course_grade_detail.Rows[i]["c_type"].ToString() == "M")
//                    {
//                        if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
//                        {
//                            dr["core_credit"] = Convert.ToInt32(dr["core_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
//                            //dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());

//                            total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
//                            total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
//                            gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
//                        }
//                    }
//                    else if (dt_course_grade_detail.Rows[i]["c_type"].ToString() == "E")
//                    {
//                        if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
//                        {
//                            dr["elective_credit"] = Convert.ToInt32(dr["elective_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
//                        }

//                        if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
//                        {
//                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
//                            {
//                                dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());

//                                total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
//                                total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
//                                gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
//                            }
//                        }
//                        else if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
//                        {
//                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
//                            {
//                                dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
//                            }
//                        }
//                    }
//                }

//                if (dt_ws_course_detail != null)
//                {
//                    if (dt_ws_course_detail.Rows.Count > 0)
//                    {
//                        for (int i = 0; i < dt_ws_course_detail.Rows.Count; i++)
//                        {
//                            if (Convert.ToInt32(dt_ws_course_detail.Rows[i]["Total"]) > 49)
//                            {
//                                dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
//                                //dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
//                                dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
//                            }
//                        }
//                    }
//                }

//                //if (dr["gpa_credit"].ToString() == "0")
//                if (total_gpa_credit.ToString() == "0")
//                {
//                    dr["semester_marks_avg"] = "-";
//                }
//                else
//                {
//                    dr["semester_marks_avg"] = total_gpa_marks / total_gpa_credit;
//                }

//                //if (dr["gpa_credit"].ToString() == "0")
//                if (total_gpa_credit.ToString() == "0")
//                {
//                    dr["grade_point_avg"] = "-";
//                }
//                else
//                {
//                    dr["grade_point_avg"] = gpa_multiplication / total_gpa_credit;
//                }

//                dt_credit_detail.Rows.Add(dr);
//            }
//        }

//        if (dt_credit_detail.Rows.Count <= 0)
//            return null;
//        else
//            return dt_credit_detail;
//    }

//    public string GetJson1(DataTable dt)
//    {

//        JavaScriptSerializer ser = new JavaScriptSerializer();
//        ser.MaxJsonLength = Int32.MaxValue;
//        List<Dictionary<string, string>> dataRows = new List<Dictionary<string, string>>(); // will contain datarows as dictionary objects

//        //Convert DataTable to List<Dictionary<string, string>> data structure
//        foreach (DataRow VDataRow in dt.Rows)
//        {
//            var Row = new Dictionary<string, string>(); // DataRow as key-value pairs where key=columnName and value=fieldValue 
//            foreach (DataColumn Column in dt.Columns)
//            {

//                Row.Add(Column.ColumnName, VDataRow[Column].ToString());

//            }
//            dataRows.Add(Row);
//        }
//        return ser.Serialize(dataRows); // convert list to JSON string 

//    }
//}