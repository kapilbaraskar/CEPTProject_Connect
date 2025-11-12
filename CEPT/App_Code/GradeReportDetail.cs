using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;
using NReco.PdfGenerator;
using System.IO;

public class GradeReportDetail
{
    //BLL.Master.Masters objMaster = new BLL.Master.Masters();
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

    public DataTable get_Student_Detail(string uid, string sem, string year)
    {
        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select user_mst.*,UPPER(department_mst.dept_name)dept_name,UPPER(programme_mst.prog_name)prog_name,programme_level_mst.prog_level_name,student_transcript_dtl.name_of_the_degree,student_transcript_dtl.degree_code,degree_mst.degree_name from user_mst " +
                              " inner join department_mst on department_mst.dept_code = user_mst.dept_code" +
                              " inner join programme_mst on programme_mst.prog_code = user_mst.prog_code" +
                              " left join programme_level_mst on programme_level_mst.prog_level_code = user_mst.prog_level_code" +
                              " left join student_transcript_dtl on student_transcript_dtl.user_id=user_mst.user_id" +
                              " left join degree_mst on degree_mst.degree_code=student_transcript_dtl.degree_code " +
                              " where user_mst.user_id = '" + uid + "' and user_mst.cancel_flag='N' " +
                              " and department_mst.cancel_flag='N' and programme_mst.cancel_flag='N'";
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

    public DataTable get_Course_Detail(string uid, string sem, string year)
    {
        DataTable dt_course_detail = new DataTable();

        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select " +
                              " ROUND((ISNULL(exam_1_w,0)+ISNULL(exam_2_w,0)+ISNULL(exam_3_w,0)+ISNULL(exam_4_w,0)+ISNULL(exam_5_w,0)" +
                              " +ISNULL(exam_6_w,0)+ISNULL(exam_7_w,0)+ISNULL(exam_8_w,0)+ISNULL(exam_9_w,0)+ISNULL(exam_10_w,0)" +
                              " ),0) as Total ,(sca.course_type)c_type,(case sca.gpa_nongpa when '' then NULL else sca.gpa_nongpa end)gpa_nongpa,cm.* " +
                              " from student_exam_marks_dtl as sm" +
                              " inner join student_course_allocate_dtl as sca on sca.user_id=sm.student_code and sca.course_code=sm.course_code" +
                              " inner join course_mst as cm on cm.course_code=sm.course_code" +
                              " inner join grade_submit_detail as gsd on gsd.course_code=sm.course_code" +
                              " where sm.cancel_flag='N' and sm.semester_type='" + sem + "' and sm.year_semester='" + year + "' and sm.student_code='" + uid + "'" +
                              " and sca.cancel_flag='N' and sca.semester_type='" + sem + "' and sca.year_semester='" + year + "'" +
                              " and cm.cancel_flag='N' and cm.semester_type='" + sem + "' and cm.year_semester='" + year + "'" +
                              " and gsd.cancel_flag='N' and gsd.semester_type='" + sem + "' and gsd.year_semester='" + year + "' and gsd.ugpgoffice_approved='Y'" +
                              " order by c_type desc,gpa_nongpa,course_code";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_course_detail = new DataTable();

            da.Fill(dt_course_detail);
        }
        catch (Exception ex)
        {
        }

        if (dt_course_detail.Rows.Count <= 0)
            return null;
        else
            return dt_course_detail;
    }

    public DataTable get_WS_Course_Detail(string uid, string sem, string year)
    {
        if (sem == "S")
        {
            //int w_year;
            //if (int.TryParse(year, out w_year))
            //{
            //    year = (w_year + 1).ToString();
            //}
        }
        else if (sem == "M")
        {
            sem = "W";
        }

        //if (sem == "S")
        //{
        //    sem = "W";
        //}
        //else if (sem == "M")
        //{
        //    sem = "S";
        //}

        DataTable dt_course_detail = new DataTable();

        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select " +
                              " ROUND((ISNULL(exam_1_w,0)+ISNULL(exam_2_w,0)+ISNULL(exam_3_w,0)+ISNULL(exam_4_w,0)+ISNULL(exam_5_w,0)" +
                              " +ISNULL(exam_6_w,0)+ISNULL(exam_7_w,0)+ISNULL(exam_8_w,0)+ISNULL(exam_9_w,0)+ISNULL(exam_10_w,0)" +
                              " ),0) as Total ,absent_exam_1,absent_exam_2,absent_exam_3,absent_exam_4,absent_exam_5,"+
                              " absent_exam_6,absent_exam_7,absent_exam_8,absent_exam_9,absent_exam_10,(sca.course_type)c_type,sca.gpa_nongpa,cm.* " +
                              " from ws_student_exam_marks_dtl as sm" +
                              " inner join ws_student_course_allocate_dtl as sca on sca.user_id=sm.student_code and sca.course_code=sm.course_code" +
                              " inner join ws_course_mst as cm on cm.course_code=sm.course_code" +
                              " inner join ws_grade_submit_detail as gsd on gsd.course_code=sm.course_code" +
                              " where sm.cancel_flag='N' and sm.semester_type='" + sem + "' and sm.year_semester='" + year + "' and sm.student_code='" + uid + "'" +
                              " and sca.cancel_flag='N' and sca.semester_type='" + sem + "' and sca.year_semester='" + year + "'" +
                              " and cm.cancel_flag='N' and cm.semester_type='" + sem + "' and cm.year_semester='" + year + "'" +
                              " and gsd.cancel_flag='N' and gsd.semester_type='" + sem + "' and gsd.year_semester='" + year + "' and gsd.ugpgoffice_approved='Y'" +
                              " order by course_code";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_course_detail = new DataTable();

            da.Fill(dt_course_detail);
        }
        catch (Exception ex)
        {
        }

        if (dt_course_detail.Rows.Count <= 0)
            return null;
        else
            return dt_course_detail;
    }

    public DataTable get_Grade_Range(string uid, string sem, string year)
    {
        DataTable dt_grade_range = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select * from course_wise_grade_range where semester_type='" + sem + "' and year_semester='" + year + "' and cancel_flag='N'";
            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_grade_range = new DataTable();

            da.Fill(dt_grade_range);

        }
        catch (Exception ex)
        {
        }

        if (dt_grade_range.Rows.Count <= 0)
            return null;
        else
            return dt_grade_range;
    }

    public DataTable get_WS_Grade_Range(string uid, string sem, string year)
    {
        if (sem == "S")
        {
        }
        else if (sem == "M")
        {
            sem = "W";
        }

        DataTable dt_grade_range = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select * from ws_course_wise_grade_range where semester_type='" + sem + "' and year_semester='" + year + "' and cancel_flag='N'";
            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_grade_range = new DataTable();

            da.Fill(dt_grade_range);

        }
        catch (Exception ex)
        {
        }

        if (dt_grade_range.Rows.Count <= 0)
            return null;
        else
            return dt_grade_range;
    }

    public DataTable Calculate_grade(DataTable dt_stud_detail, DataTable dt_course_detail, DataTable dt_grade_range)
    {
        if (dt_stud_detail != null && dt_course_detail != null && dt_stud_detail.Rows.Count > 0 && dt_course_detail.Rows.Count > 0)
        {
            try
            {
                int year = Convert.ToInt32((dt_stud_detail.Rows[0]["year_code"].ToString()).Substring(1));

                dt_course_detail.Columns.Add("grade");
                dt_course_detail.Columns.Add("grade_point");
                dt_course_detail.Columns.Add("remarks");

                for (int i = 0; i < dt_course_detail.Rows.Count; i++)
                {
                    double subject_marks = Convert.ToDouble(dt_course_detail.Rows[i]["Total"].ToString());

                    string str_course = dt_course_detail.Rows[i]["course_code"].ToString();
                    DataRow[] course_range = dt_grade_range.Select("course_code = '" + str_course + "'");
                    bool gpa_less_9_flag = false;

                    if (course_range[0]["A_plus_from"].ToString() == "87")
                    {
                        gpa_less_9_flag = true;
                    }

                    if (dt_course_detail.Rows[i]["c_type"].ToString() == "E" && dt_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N" || dt_course_detail.Rows[i]["c_type"].ToString() == "M" && dt_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                    {
                        if (year >= 2018)
                        {
                            if (subject_marks < 55)
                            {
                                dt_course_detail.Rows[i]["grade"] = "NP";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "FAIL";
                            }
                            else if (subject_marks >= 55)
                            {
                                dt_course_detail.Rows[i]["grade"] = "P";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "PASS";
                            }
                        }
                        else
                        {
                            if (subject_marks < 50)
                            {
                                dt_course_detail.Rows[i]["grade"] = "NP";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "FAIL";
                            }
                            else if (subject_marks >= 50)
                            {
                                dt_course_detail.Rows[i]["grade"] = "P";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "PASS";
                            }
                        }
                    }
                    else if (year >= 2018)
                    {
                        dt_course_detail.Rows[i]["remarks"] = "PASS";
                        if (subject_marks < 55)
                        {
                            dt_course_detail.Rows[i]["grade"] = "F";
                            dt_course_detail.Rows[i]["grade_point"] = "0";
                            dt_course_detail.Rows[i]["remarks"] = "FAIL";
                        }
                        else if (subject_marks >= 90)
                        {
                            dt_course_detail.Rows[i]["grade"] = "O";
                            dt_course_detail.Rows[i]["grade_point"] = "5.0";
                        }
                        else if (subject_marks >= 80)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A";
                            dt_course_detail.Rows[i]["grade_point"] = "4.0";
                        }
                        else if (subject_marks >= 65)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B";
                            dt_course_detail.Rows[i]["grade_point"] = "3.0";
                        }
                        else if (subject_marks >= 55)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C";
                            dt_course_detail.Rows[i]["grade_point"] = "2.0";
                        }
                    }
                    else if (year < 2014 || gpa_less_9_flag)
                    {
                        dt_course_detail.Rows[i]["remarks"] = "PASS";
                        if (subject_marks < 50)
                        {
                            dt_course_detail.Rows[i]["grade"] = "F";
                            dt_course_detail.Rows[i]["grade_point"] = "0";
                            dt_course_detail.Rows[i]["remarks"] = "FAIL";
                        }
                        else if (subject_marks >= 87)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A+";

                            if (Convert.ToInt32(dt_course_detail.Rows[i]["year_semester"].ToString()) >= 2018)
                                dt_course_detail.Rows[i]["grade_point"] = "4.3";
                            else
                                dt_course_detail.Rows[i]["grade_point"] = "4.0";
                        }
                        else if (subject_marks >= 83)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A";
                            dt_course_detail.Rows[i]["grade_point"] = "4.0";
                        }
                        else if (subject_marks >= 80)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A-";
                            dt_course_detail.Rows[i]["grade_point"] = "3.67";
                        }
                        else if (subject_marks >= 77)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B+";
                            dt_course_detail.Rows[i]["grade_point"] = "3.33";
                        }
                        else if (subject_marks >= 73)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B";
                            dt_course_detail.Rows[i]["grade_point"] = "3.0";
                        }
                        else if (subject_marks >= 70)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B-";
                            dt_course_detail.Rows[i]["grade_point"] = "2.67";
                        }
                        else if (subject_marks >= 67)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C+";
                            dt_course_detail.Rows[i]["grade_point"] = "2.33";
                        }
                        else if (subject_marks >= 63)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C";
                            dt_course_detail.Rows[i]["grade_point"] = "2.0";
                        }
                        else if (subject_marks >= 60)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C-";
                            dt_course_detail.Rows[i]["grade_point"] = "1.67";
                        }
                        else if (subject_marks >= 57)
                        {
                            dt_course_detail.Rows[i]["grade"] = "D+";
                            dt_course_detail.Rows[i]["grade_point"] = "1.33";
                        }
                        else if (subject_marks >= 53)
                        {
                            dt_course_detail.Rows[i]["grade"] = "D";
                            dt_course_detail.Rows[i]["grade_point"] = "1.0";
                        }
                        else if (subject_marks >= 50)
                        {
                            dt_course_detail.Rows[i]["grade"] = "D-";
                            dt_course_detail.Rows[i]["grade_point"] = "0.67";
                        }
                    }
                    else
                    {
                        if (dt_grade_range != null)
                        {
                            //string str_course = dt_course_detail.Rows[i]["course_code"].ToString();
                            //DataRow[] course_range = dt_grade_range.Select("course_code = '" + str_course + "'");

                            if (course_range.Length > 0)
                            {
                                dt_course_detail.Rows[i]["remarks"] = "PASS";
                                if (subject_marks < 50)
                                {
                                    dt_course_detail.Rows[i]["grade"] = "F";
                                    dt_course_detail.Rows[i]["grade_point"] = "0";
                                    dt_course_detail.Rows[i]["remarks"] = "FAIL";
                                }
                                else if (subject_marks >= 90)
                                {
                                    dt_course_detail.Rows[i]["grade"] = "A+";
                                    dt_course_detail.Rows[i]["grade_point"] = "4.3";
                                }
                                else if (course_range[0]["SD"].ToString() == System.DBNull.Value.ToString())
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B-";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
                                }
                                else if (Convert.ToDouble(course_range[0]["SD"].ToString()) == 0)
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B-";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["A_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "A";
                                    dt_course_detail.Rows[i]["grade_point"] = "4.0";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["A_minus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "A-";
                                    dt_course_detail.Rows[i]["grade_point"] = "3.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_plus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B+";
                                    dt_course_detail.Rows[i]["grade_point"] = "3.3";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B";
                                    dt_course_detail.Rows[i]["grade_point"] = "3.0";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_minus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B-";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_plus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "C+";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.3";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "C";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.0";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_minus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "C-";
                                    dt_course_detail.Rows[i]["grade_point"] = "1.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["D_plus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "D+";
                                    dt_course_detail.Rows[i]["grade_point"] = "1.3";
                                }
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

            }
        }

        return dt_course_detail;
    }

    public DataTable WS_Calculate_grade(DataTable dt_stud_detail, DataTable dt_course_detail, DataTable dt_grade_range)
    {
        if (dt_stud_detail != null && dt_course_detail != null && dt_stud_detail.Rows.Count > 0 && dt_course_detail.Rows.Count > 0)
        {
            try
            {
                int year = Convert.ToInt32((dt_stud_detail.Rows[0]["year_code"].ToString()).Substring(1));

                dt_course_detail.Columns.Add("grade");
                dt_course_detail.Columns.Add("grade_point");
                dt_course_detail.Columns.Add("remarks");

                for (int i = 0; i < dt_course_detail.Rows.Count; i++)
                {
                    double subject_marks = Convert.ToDouble(dt_course_detail.Rows[i]["Total"].ToString());

                    string str_course = dt_course_detail.Rows[i]["course_code"].ToString();
                    DataRow[] course_range = dt_grade_range.Select("course_code = '" + str_course + "'");
                    bool gpa_less_9_flag = false;

                    if (course_range[0]["grade_type"].ToString() != "R")
                    {
                        gpa_less_9_flag = true;
                    }

                    if (dt_course_detail.Rows[i]["c_type"].ToString() == "E" && dt_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N" || dt_course_detail.Rows[i]["c_type"].ToString() == "M" && dt_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                    {
                        if (year >= 2018)
                        {
                            if (subject_marks < 55)
                            {
                                dt_course_detail.Rows[i]["grade"] = "NP";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "FAIL";
                            }
                            else if (subject_marks >= 55)
                            {
                                dt_course_detail.Rows[i]["grade"] = "P";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "PASS";
                            }
                        }
                        else
                        {
                            if (subject_marks < 50)
                            {
                                dt_course_detail.Rows[i]["grade"] = "NP";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "FAIL";
                            }
                            else if (subject_marks >= 50)
                            {
                                dt_course_detail.Rows[i]["grade"] = "P";
                                dt_course_detail.Rows[i]["grade_point"] = "NA";
                                dt_course_detail.Rows[i]["remarks"] = "PASS";
                            }
                        }
                    }
                    else if (year >= 2018)
                    {
                        dt_course_detail.Rows[i]["remarks"] = "PASS";

                        if (subject_marks < 55)
                        {
                            dt_course_detail.Rows[i]["grade"] = "F";
                            dt_course_detail.Rows[i]["grade_point"] = "0";
                            dt_course_detail.Rows[i]["remarks"] = "FAIL";
                        }
                        else if (subject_marks >= 90)
                        {
                            dt_course_detail.Rows[i]["grade"] = "O";
                            dt_course_detail.Rows[i]["grade_point"] = "5.0";
                        }
                        else if (subject_marks >= 80)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A";
                            dt_course_detail.Rows[i]["grade_point"] = "4.0";
                        }
                        else if (subject_marks >= 65)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B";
                            dt_course_detail.Rows[i]["grade_point"] = "3.0";
                        }
                        else if (subject_marks >= 55)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C";
                            dt_course_detail.Rows[i]["grade_point"] = "2.0";
                        }
                    }
                    else if (gpa_less_9_flag)
                    {
                        dt_course_detail.Rows[i]["remarks"] = "PASS";
                        if (subject_marks < 50)
                        {
                            dt_course_detail.Rows[i]["grade"] = "F";
                            dt_course_detail.Rows[i]["grade_point"] = "0";
                            dt_course_detail.Rows[i]["remarks"] = "FAIL";
                        }
                        else if (subject_marks >= 87)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A+";

                            if (dt_course_detail.Rows[i]["semester_type"].ToString() == "W" && dt_course_detail.Rows[i]["year_semester"].ToString() == "2017")
                                dt_course_detail.Rows[i]["grade_point"] = "4.3";
                            else if (Convert.ToInt32(dt_course_detail.Rows[i]["year_semester"].ToString()) >= 2018)
                                dt_course_detail.Rows[i]["grade_point"] = "4.3";
                            else
                                dt_course_detail.Rows[i]["grade_point"] = "4.0";
                        }
                        else if (subject_marks >= 83)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A";
                            dt_course_detail.Rows[i]["grade_point"] = "4.0";
                        }
                        else if (subject_marks >= 80)
                        {
                            dt_course_detail.Rows[i]["grade"] = "A-";
                            dt_course_detail.Rows[i]["grade_point"] = "3.67";
                        }
                        else if (subject_marks >= 77)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B+";
                            dt_course_detail.Rows[i]["grade_point"] = "3.33";
                        }
                        else if (subject_marks >= 73)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B";
                            dt_course_detail.Rows[i]["grade_point"] = "3.0";
                        }
                        else if (subject_marks >= 70)
                        {
                            dt_course_detail.Rows[i]["grade"] = "B-";
                            dt_course_detail.Rows[i]["grade_point"] = "2.67";
                        }
                        else if (subject_marks >= 67)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C+";
                            dt_course_detail.Rows[i]["grade_point"] = "2.33";
                        }
                        else if (subject_marks >= 63)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C";
                            dt_course_detail.Rows[i]["grade_point"] = "2.0";
                        }
                        else if (subject_marks >= 60)
                        {
                            dt_course_detail.Rows[i]["grade"] = "C-";
                            dt_course_detail.Rows[i]["grade_point"] = "1.67";
                        }
                        else if (subject_marks >= 57)
                        {
                            dt_course_detail.Rows[i]["grade"] = "D+";
                            dt_course_detail.Rows[i]["grade_point"] = "1.33";
                        }
                        else if (subject_marks >= 53)
                        {
                            dt_course_detail.Rows[i]["grade"] = "D";
                            dt_course_detail.Rows[i]["grade_point"] = "1.0";
                        }
                        else if (subject_marks >= 50)
                        {
                            dt_course_detail.Rows[i]["grade"] = "D-";
                            dt_course_detail.Rows[i]["grade_point"] = "0.67";
                        }
                    }
                    else
                    {
                        if (dt_grade_range != null)
                        {
                            //string str_course = dt_course_detail.Rows[i]["course_code"].ToString();
                            //DataRow[] course_range = dt_grade_range.Select("course_code = '" + str_course + "'");

                            if (course_range.Length > 0)
                            {
                                dt_course_detail.Rows[i]["remarks"] = "PASS";
                                if (subject_marks < 50)
                                {
                                    dt_course_detail.Rows[i]["grade"] = "F";
                                    dt_course_detail.Rows[i]["grade_point"] = "0";
                                    dt_course_detail.Rows[i]["remarks"] = "FAIL";
                                }
                                else if (subject_marks >= 90)
                                {
                                    dt_course_detail.Rows[i]["grade"] = "A+";
                                    dt_course_detail.Rows[i]["grade_point"] = "4.3";
                                }
                                else if (course_range[0]["SD"].ToString() == System.DBNull.Value.ToString())
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B-";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
                                }
                                else if (Convert.ToDouble(course_range[0]["SD"].ToString()) == 0)
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B-";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["A_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "A";
                                    dt_course_detail.Rows[i]["grade_point"] = "4.0";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["A_minus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "A-";
                                    dt_course_detail.Rows[i]["grade_point"] = "3.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_plus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B+";
                                    dt_course_detail.Rows[i]["grade_point"] = "3.3";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B";
                                    dt_course_detail.Rows[i]["grade_point"] = "3.0";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["B_minus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "B-";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_plus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "C+";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.3";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "C";
                                    dt_course_detail.Rows[i]["grade_point"] = "2.0";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["C_minus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "C-";
                                    dt_course_detail.Rows[i]["grade_point"] = "1.7";
                                }
                                else if (subject_marks >= Convert.ToDouble(course_range[0]["D_plus_from"].ToString()))
                                {
                                    dt_course_detail.Rows[i]["grade"] = "D+";
                                    dt_course_detail.Rows[i]["grade_point"] = "1.3";
                                }
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

            }
        }

        return dt_course_detail;
    }

    public DataTable Calculate_credits(DataTable dt_course_grade_detail, DataTable dt_ws_course_detail)
    {
        DataTable dt_credit_detail = new DataTable();
        dt_credit_detail.Columns.Add("total_credit");
        dt_credit_detail.Columns.Add("core_credit");
        dt_credit_detail.Columns.Add("m_gpa_credit");//new added
        dt_credit_detail.Columns.Add("m_ngpa_credit");//new added
        dt_credit_detail.Columns.Add("elective_credit");
        dt_credit_detail.Columns.Add("gpa_credit");
        dt_credit_detail.Columns.Add("ngpa_credit");
        dt_credit_detail.Columns.Add("semester_marks_avg");
        dt_credit_detail.Columns.Add("grade_point_avg");
        dt_credit_detail.Columns.Add("grade_point_ratio");
        dt_credit_detail.Columns.Add("sws_credit");
        dt_credit_detail.Columns.Add("sws_m_gpa_credit");//new added
        dt_credit_detail.Columns.Add("sws_m_ngpa_credit");//new added
        dt_credit_detail.Columns.Add("sws_gpa_credit");//new added
        dt_credit_detail.Columns.Add("sws_ngpa_credit");//new added

        if (dt_course_grade_detail != null)
        {
            if (dt_course_grade_detail.Rows.Count > 0)
            {
                DataRow dr = dt_credit_detail.NewRow();
                dr["total_credit"] = "0";
                
                dr["core_credit"] = "0";
                dr["m_gpa_credit"] = "0";//new added
                dr["m_ngpa_credit"] = "0";//new added

                dr["elective_credit"] = "0";
                dr["gpa_credit"] = "0";
                dr["ngpa_credit"] = "0";
                


                dr["semester_marks_avg"] = "0";
                dr["grade_point_avg"] = "0";
                dr["grade_point_ratio"] = "0";

                dr["sws_credit"] = "0";

                dr["sws_m_gpa_credit"] = "0";//new added
                dr["sws_m_ngpa_credit"] = "0";//new added

                dr["sws_gpa_credit"] = "0";//new added
                dr["sws_ngpa_credit"] = "0";//new added

                double total_gpa_marks = 0;
                double gpa_multiplication = 0;
                double total_gpa_credit = 0;

                for (int i = 0; i < dt_course_grade_detail.Rows.Count; i++)
                {
                    if (dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP001" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP002" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP003" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP004" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP005" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP006" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP007"
                        || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP008" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP009" || dt_course_grade_detail.Rows[i]["course_code"].ToString() == "CFP010")
                    {
                        if (Convert.ToInt32(dt_course_grade_detail.Rows[i]["year_semester"].ToString()) >= 2024)
                        {
                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                            }

                            if (dt_course_grade_detail.Rows[i]["c_type"].ToString() == "M")
                            {
                                if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                {
                                    dr["core_credit"] = Convert.ToInt32(dr["core_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                }

                                if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                                {
                                    if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                    {
                                        dr["m_ngpa_credit"] = Convert.ToInt32(dr["m_ngpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                    }
                                }
                                else if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                                {
                                    if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                    {
                                        dr["m_gpa_credit"] = Convert.ToInt32(dr["m_gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                        //dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());

                                        total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
                                        total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                        gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
                                    }
                                }
                            }
                            else if (dt_course_grade_detail.Rows[i]["c_type"].ToString() == "E")
                            {
                                if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                {
                                    dr["elective_credit"] = Convert.ToInt32(dr["elective_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                }

                                if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                                {
                                    if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                    {
                                        dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());

                                        total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
                                        total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                        gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
                                    }
                                }
                                else if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                                {
                                    if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                    {
                                        dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                    }
                                }
                            }
                        }
                    }
                    else
                    {
                        if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                        {
                            dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                        }

                        if (dt_course_grade_detail.Rows[i]["c_type"].ToString() == "M")
                        {
                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["core_credit"] = Convert.ToInt32(dr["core_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                            }

                            if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                            {
                                if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                {
                                    dr["m_ngpa_credit"] = Convert.ToInt32(dr["m_ngpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                }
                            }
                            else if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                            {
                                if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                {
                                    dr["m_gpa_credit"] = Convert.ToInt32(dr["m_gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                    //dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());

                                    total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
                                    total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                    gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
                                }
                            }
                        }
                        else if (dt_course_grade_detail.Rows[i]["c_type"].ToString() == "E")
                        {
                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["elective_credit"] = Convert.ToInt32(dr["elective_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                            }

                            if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                            {
                                if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                {
                                    dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());

                                    total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
                                    total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                    gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
                                }
                            }
                            else if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                            {
                                if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                                {
                                    dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["course_credits"].ToString());
                                }
                            }
                        }
                    }
                }

                if (dt_ws_course_detail != null)
                {
                    if (dt_ws_course_detail.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt_ws_course_detail.Rows.Count; i++)
                        {
                            if (dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());

                                if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M")
                                {
                                    if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                                    {
                                        dr["sws_m_gpa_credit"] = Convert.ToInt32(dr["sws_m_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                    else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                                    {
                                        dr["sws_m_ngpa_credit"] = Convert.ToInt32(dr["sws_m_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                }
                                else if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "E")
                                {
                                    if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                                    {
                                        dr["sws_gpa_credit"] = Convert.ToInt32(dr["sws_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                    else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                                    {
                                        dr["sws_ngpa_credit"] = Convert.ToInt32(dr["sws_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                }
                            }

                            //if (Convert.ToInt32(dt_ws_course_detail.Rows[i]["Total"]) > 49)
                            //{
                            //    dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //    //dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //    dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //}

                            if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")//dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M" && 
                            {
                                total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                                total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                            }

                            //else if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "E" && dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                            //{
                            //    total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                            //    total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //    gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                            //}
                        }
                    }
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["semester_marks_avg"] = "-";
                }
                else
                {
                    dr["semester_marks_avg"] = total_gpa_marks / total_gpa_credit;
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["grade_point_avg"] = "-";
                }
                else
                {
                    dr["grade_point_avg"] = gpa_multiplication / total_gpa_credit;
                }

                dt_credit_detail.Rows.Add(dr);
            }
        }
        else if (dt_ws_course_detail != null)
        {
            if (dt_ws_course_detail.Rows.Count > 0)
            {
                DataRow dr = dt_credit_detail.NewRow();
                dr["total_credit"] = "0";
                dr["core_credit"] = "0";
                dr["m_gpa_credit"] = "0";//new added
                dr["m_ngpa_credit"] = "0";//new added

                dr["elective_credit"] = "0";
                dr["gpa_credit"] = "0";
                dr["ngpa_credit"] = "0";

                dr["semester_marks_avg"] = "0";
                dr["grade_point_avg"] = "0";
                dr["grade_point_ratio"] = "0";
                dr["sws_credit"] = "0";

                dr["sws_m_gpa_credit"] = "0";//new added
                dr["sws_m_ngpa_credit"] = "0";//new added

                dr["sws_gpa_credit"] = "0";//new added
                dr["sws_ngpa_credit"] = "0";//new added

                double total_gpa_marks = 0;
                double gpa_multiplication = 0;
                double total_gpa_credit = 0;

                for (int i = 0; i < dt_ws_course_detail.Rows.Count; i++)
                {
                    //if (Convert.ToInt32(dt_ws_course_detail.Rows[i]["Total"]) > 49)
                    //{
                    //    dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //    //dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //    dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //}

                    if (dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                    {
                        dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                        dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());

                        if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M")
                        {
                            if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                            {
                                dr["sws_m_gpa_credit"] = Convert.ToInt32(dr["sws_m_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                            else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                            {
                                dr["sws_m_ngpa_credit"] = Convert.ToInt32(dr["sws_m_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                        }
                        else if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "E")
                        {
                            if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                            {
                                dr["sws_gpa_credit"] = Convert.ToInt32(dr["sws_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                            else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                            {
                                dr["sws_ngpa_credit"] = Convert.ToInt32(dr["sws_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                        }
                    }
                    
                    if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")//dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M" && 
                    {
                        total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                        total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                        gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                    }

                    //if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M")
                    //{
                    //    if (dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                    //    {
                    //        total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                    //        total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //        gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                    //    }
                    //}
                    //else if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "E" && dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                    //{
                    //    total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                    //    total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //    gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                    //}
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["semester_marks_avg"] = "-";
                }
                else
                {
                    dr["semester_marks_avg"] = total_gpa_marks / total_gpa_credit;
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["grade_point_avg"] = "-";
                }
                else
                {
                    dr["grade_point_avg"] = gpa_multiplication / total_gpa_credit;
                }

                dt_credit_detail.Rows.Add(dr);
            }
        }

        if (dt_credit_detail.Rows.Count <= 0)
            return null;
        else
            return dt_credit_detail;
    }

    public DataTable Calculate_credits_CGPA(DataTable dt_course_grade_detail, DataTable dt_ws_course_detail)
    {
        DataTable dt_credit_detail = new DataTable();
        dt_credit_detail.Columns.Add("total_credit");
        dt_credit_detail.Columns.Add("core_credit");
        dt_credit_detail.Columns.Add("m_gpa_credit");//new added
        dt_credit_detail.Columns.Add("m_ngpa_credit");//new added
        dt_credit_detail.Columns.Add("elective_credit");
        dt_credit_detail.Columns.Add("gpa_credit");
        dt_credit_detail.Columns.Add("ngpa_credit");
        dt_credit_detail.Columns.Add("semester_marks_avg");
        dt_credit_detail.Columns.Add("grade_point_avg");
        dt_credit_detail.Columns.Add("grade_point_ratio");
        dt_credit_detail.Columns.Add("sws_credit");
        dt_credit_detail.Columns.Add("sws_m_gpa_credit");//new added
        dt_credit_detail.Columns.Add("sws_m_ngpa_credit");//new added
        dt_credit_detail.Columns.Add("sws_gpa_credit");//new added
        dt_credit_detail.Columns.Add("sws_ngpa_credit");//new added
        dt_credit_detail.Columns.Add("gpa_multiplication");//new added
        dt_credit_detail.Columns.Add("total_gpa_credit");//new added

        if (dt_course_grade_detail != null)
        {
            if (dt_course_grade_detail.Rows.Count > 0)
            {
                DataRow dr = dt_credit_detail.NewRow();
                dr["total_credit"] = "0";

                dr["core_credit"] = "0";
                dr["m_gpa_credit"] = "0";//new added
                dr["m_ngpa_credit"] = "0";//new added

                dr["elective_credit"] = "0";
                dr["gpa_credit"] = "0";
                dr["ngpa_credit"] = "0";



                dr["semester_marks_avg"] = "0";
                dr["grade_point_avg"] = "0";
                dr["grade_point_ratio"] = "0";

                dr["sws_credit"] = "0";

                dr["sws_m_gpa_credit"] = "0";//new added
                dr["sws_m_ngpa_credit"] = "0";//new added

                dr["sws_gpa_credit"] = "0";//new added
                dr["sws_ngpa_credit"] = "0";//new added

                double total_gpa_marks = 0;
                double gpa_multiplication = 0;
                double total_gpa_credit = 0;

                for (int i = 0; i < dt_course_grade_detail.Rows.Count; i++)
                {
                    if (dt_course_grade_detail.Rows[i]["user_id"].ToString() == "PA100117")
                    {
                        
                    }

                    if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                    {
                        dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());
                    }

                    if (dt_course_grade_detail.Rows[i]["course_type"].ToString() == "M")
                    {
                        if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                        {
                            dr["core_credit"] = Convert.ToInt32(dr["core_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());
                        }

                        if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                        {
                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["m_ngpa_credit"] = Convert.ToInt32(dr["m_ngpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());
                            }
                        }
                        else if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                        {
                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["m_gpa_credit"] = Convert.ToInt32(dr["m_gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());
                                //dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());

                                total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
                                total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["credits"].ToString());
                                gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
                            }
                        }
                    }
                    else if (dt_course_grade_detail.Rows[i]["course_type"].ToString() == "E")
                    {
                        if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                        {
                            dr["elective_credit"] = Convert.ToInt32(dr["elective_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());
                        }

                        if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                        {
                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["gpa_credit"] = Convert.ToInt32(dr["gpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());

                                total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["Total"].ToString()));
                                total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_course_grade_detail.Rows[i]["credits"].ToString());
                                gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_course_grade_detail.Rows[i]["credits"].ToString()) * Convert.ToDouble(dt_course_grade_detail.Rows[i]["grade_point"].ToString()));
                            }
                        }
                        else if (dt_course_grade_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                        {
                            if (dt_course_grade_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_course_grade_detail.Rows[i]["credits"].ToString());
                            }
                        }
                    }
                }

                if (dt_ws_course_detail != null)
                {
                    if (dt_ws_course_detail.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt_ws_course_detail.Rows.Count; i++)
                        {
                            if (dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                            {
                                dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());

                                if (dt_ws_course_detail.Rows[i]["course_type"].ToString() == "M")
                                {
                                    if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                                    {
                                        dr["sws_m_gpa_credit"] = Convert.ToInt32(dr["sws_m_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                    else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                                    {
                                        dr["sws_m_ngpa_credit"] = Convert.ToInt32(dr["sws_m_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                }
                                else if (dt_ws_course_detail.Rows[i]["course_type"].ToString() == "E")
                                {
                                    if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                                    {
                                        dr["sws_gpa_credit"] = Convert.ToInt32(dr["sws_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                    else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                                    {
                                        dr["sws_ngpa_credit"] = Convert.ToInt32(dr["sws_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                    }
                                }
                            }

                            //if (Convert.ToInt32(dt_ws_course_detail.Rows[i]["Total"]) > 49)
                            //{
                            //    dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //    //dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //    dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //}

                            if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")//dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M" && 
                            {
                                total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                                total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                                gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                            }

                            //else if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "E" && dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                            //{
                            //    total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                            //    total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            //    gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                            //}
                        }
                    }
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["semester_marks_avg"] = "-";
                }
                else
                {
                    dr["semester_marks_avg"] = total_gpa_marks / total_gpa_credit;
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["grade_point_avg"] = "-";
                }
                else
                {
                    dr["gpa_multiplication"] = gpa_multiplication;
                    dr["total_gpa_credit"] = total_gpa_credit;
                    dr["grade_point_avg"] = gpa_multiplication / total_gpa_credit;
                }

                dt_credit_detail.Rows.Add(dr);
            }
        }
        else if (dt_ws_course_detail != null)
        {
            if (dt_ws_course_detail.Rows.Count > 0)
            {
                DataRow dr = dt_credit_detail.NewRow();
                dr["total_credit"] = "0";
                dr["core_credit"] = "0";
                dr["m_gpa_credit"] = "0";//new added
                dr["m_ngpa_credit"] = "0";//new added

                dr["elective_credit"] = "0";
                dr["gpa_credit"] = "0";
                dr["ngpa_credit"] = "0";

                dr["semester_marks_avg"] = "0";
                dr["grade_point_avg"] = "0";
                dr["grade_point_ratio"] = "0";
                dr["sws_credit"] = "0";

                dr["sws_m_gpa_credit"] = "0";//new added
                dr["sws_m_ngpa_credit"] = "0";//new added

                dr["sws_gpa_credit"] = "0";//new added
                dr["sws_ngpa_credit"] = "0";//new added

                double total_gpa_marks = 0;
                double gpa_multiplication = 0;
                double total_gpa_credit = 0;

                for (int i = 0; i < dt_ws_course_detail.Rows.Count; i++)
                {
                    //if (Convert.ToInt32(dt_ws_course_detail.Rows[i]["Total"]) > 49)
                    //{
                    //    dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //    //dr["ngpa_credit"] = Convert.ToInt32(dr["ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //    dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //}

                    if (dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                    {
                        dr["total_credit"] = Convert.ToInt32(dr["total_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                        dr["sws_credit"] = Convert.ToInt32(dr["sws_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());

                        if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M")
                        {
                            if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                            {
                                dr["sws_m_gpa_credit"] = Convert.ToInt32(dr["sws_m_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                            else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                            {
                                dr["sws_m_ngpa_credit"] = Convert.ToInt32(dr["sws_m_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                        }
                        else if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "E")
                        {
                            if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G")
                            {
                                dr["sws_gpa_credit"] = Convert.ToInt32(dr["sws_gpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                            else if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "N")
                            {
                                dr["sws_ngpa_credit"] = Convert.ToInt32(dr["sws_ngpa_credit"].ToString()) + Convert.ToInt32(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                            }
                        }
                    }

                    if (dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")//dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M" && 
                    {
                        total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                        total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                        gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                    }

                    //if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "M")
                    //{
                    //    if (dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                    //    {
                    //        total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                    //        total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //        gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                    //    }
                    //}
                    //else if (dt_ws_course_detail.Rows[i]["c_type"].ToString() == "E" && dt_ws_course_detail.Rows[i]["gpa_nongpa"].ToString() == "G" && dt_ws_course_detail.Rows[i]["remarks"].ToString() == "PASS")
                    //{
                    //    total_gpa_marks = total_gpa_marks + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["Total"].ToString()));
                    //    total_gpa_credit = total_gpa_credit + Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString());
                    //    gpa_multiplication = gpa_multiplication + (Convert.ToDouble(dt_ws_course_detail.Rows[i]["course_credits"].ToString()) * Convert.ToDouble(dt_ws_course_detail.Rows[i]["grade_point"].ToString()));
                    //}
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["semester_marks_avg"] = "-";
                }
                else
                {
                    dr["semester_marks_avg"] = total_gpa_marks / total_gpa_credit;
                }

                //if (dr["gpa_credit"].ToString() == "0")
                if (total_gpa_credit.ToString() == "0")
                {
                    dr["grade_point_avg"] = "-";
                }
                else
                {
                    dr["grade_point_avg"] = gpa_multiplication / total_gpa_credit;
                }

                dt_credit_detail.Rows.Add(dr);
            }
        }

        if (dt_credit_detail.Rows.Count <= 0)
            return null;
        else
            return dt_credit_detail;
    }

    public string GetJson1(DataTable dt)
    {

        JavaScriptSerializer ser = new JavaScriptSerializer();
        ser.MaxJsonLength = Int32.MaxValue;
        List<Dictionary<string, string>> dataRows = new List<Dictionary<string, string>>(); // will contain datarows as dictionary objects

        //Convert DataTable to List<Dictionary<string, string>> data structure
        foreach (DataRow VDataRow in dt.Rows)
        {
            var Row = new Dictionary<string, string>(); // DataRow as key-value pairs where key=columnName and value=fieldValue 
            foreach (DataColumn Column in dt.Columns)
            {

                Row.Add(Column.ColumnName, VDataRow[Column].ToString());

            }
            dataRows.Add(Row);
        }
        return ser.Serialize(dataRows); // convert list to JSON string 

    }


    public DataTable CourseData(DataTable Courses)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());
        DataTable CoursesDT = new DataTable();
        try
        {
            if (Courses != null && Courses.Rows.Count > 0)
            {
                for (int i = 0; i < Courses.Rows.Count; i++)
                {
                    SqlCommand cmd = con.CreateCommand();
                    cmd.CommandText = @"SELECT 
                                        	'SM' Type,
                                        	ISNULL(CM.course_code,'') AS course_code,
                                        	ISNULL(course_credits,'') AS course_credits,
                                        	ISNULL(course_name,'') AS course_name,
                                        	ISNULL(gpa_ngpa,'') AS gpa_ngpa,
                                        	ISNULL(course_outline,'') AS course_outline,
                                        	ISNULL(eval_method5,'') AS eval_method5,	
                                        	CASE WHEN CM.semester_type='S' THEN 'Spring Semester' ELSE 'Monsoon Semester' END AS Semester,
                                        	'Faculty of ' + (SELECT dept_name FROM department_mst WHERE dept_code=(SELECT TOP 1 dept_code FROM department_wise_course_dtl DWCD WITH(NOLOCK) WHERE DWCD.course_code=CM.course_code)) DepartmentName,
                                        	ISNULL(CM.year_semester,'') AS year_semester,                                        	
                                        	ISNULL(week1,'') + 'SplitStringFromHere' + 
						                    ISNULL(week2,'') + 'SplitStringFromHere' +
						                    ISNULL(week3,'') + 'SplitStringFromHere' +
						                    ISNULL(week4,'') + 'SplitStringFromHere' +
						                    ISNULL(week5,'') + 'SplitStringFromHere' +
						                    ISNULL(week6,'') + 'SplitStringFromHere' +
						                    ISNULL(week7,'') + 'SplitStringFromHere' +
						                    ISNULL(week8,'') + 'SplitStringFromHere' +
						                    ISNULL(week9,'') + 'SplitStringFromHere' +
						                    ISNULL(week10,'') + 'SplitStringFromHere' +
						                    ISNULL(week11,'') + 'SplitStringFromHere' +
						                    ISNULL(week12,'') + 'SplitStringFromHere' +
						                    ISNULL(week13,'') + 'SplitStringFromHere' +
						                    ISNULL(week14,'') + 'SplitStringFromHere' +
						                    ISNULL(week15,'') + 'SplitStringFromHere' +
						                    ISNULL(week16,'') AS methodology,
                                            	(SELECT  type_name FROM course_type_mst WHERE type_code = DWCD.course_typology) AS Typology
                                        FROM course_mst CM WITH(NOLOCK)
                                        LEFT JOIN department_wise_course_dtl DWCD WITH(NOLOCK) ON DWCD.course_code = CM.course_code AND DWCD.semester_type = CM.semester_type AND DWCD.year_semester = CM.year_semester
                                        WHERE
                                            CM.course_code = '" + Courses.Rows[i]["course_code"] + @"' AND
                                            CM.semester_type = '" + Courses.Rows[i]["semester_type"] + @"' AND
                                            CM.year_semester = '" + Courses.Rows[i]["year_semester"] + @"'
                                        UNION
                                        SELECT
                                            'WS' Type,
                                        	WSCM.course_code,
                                        	MAX(WSCM.course_credits)course_credits,
                                        	MAX(WSCM.course_name)course_name,
                                        	MAX(WSCM.gpa_status)gpa_ngpa,
                                        	MAX(WSCM.course_desc) course_outline ,
                                        	MAX(WSCP.learning_outcomes) eval_method5,
                                        	CASE WHEN MAX(WSCM.semester_type) = 'W' THEN 'Winter Semester' ELSE 'Summer Semester' END AS Semester,
                                        	'Faculty of ' + (SELECT dept_name FROM department_mst DM WHERE DM.dept_code = MAX(WSCM.dept_code)) DepartmentName,
                                        	ISNULL(MAX(WSCM.year_semester), '') AS year_semester,
                                         	(SELECT STUFF((SELECT '~' + WSCWWP.methodology FROM ws_course_wise_workplan WSCWWP WITH(NOLOCK) WHERE WSCM.course_code = WSCWWP.course_code AND MAX(WSCM.year_semester) = WSCWWP.year_semester AND MAX(WSCM.semester_type) = WSCWWP.semester_type ORDER BY workplan_date ASC FOR XML PATH('')), 1, 1, '')) as methodology,
                                        	'-' AS Typology
                                        FROM ws_course_mst WSCM WITH(NOLOCK)
                                        LEFT JOIN ws_course_proposal WSCP WITH(NOLOCK) ON WSCM.course_code = WSCP.ws_course_code AND WSCM.year_semester = WSCP.year_semester AND WSCM.semester_type = WSCP.semester_type
                                        WHERE
                                            WSCM.course_code = '" + Courses.Rows[i]["course_code"] + @"' AND
                                            WSCM.semester_type = '" + Courses.Rows[i]["semester_type"] + @"' AND
                                            WSCM.year_semester = '" + Courses.Rows[i]["year_semester"] + @"'
                                        GROUP BY WSCM.course_code";
                    cmd.CommandType = CommandType.Text;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(CoursesDT);
                }
            }
            return CoursesDT;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public string PrintPdf(string Html, string student, string Sem, string Year)
    {
        var HtmlString = @" <html>
                                <head>
                                    <link href='../DesignCss/bootstrap.min.css' rel='stylesheet' type='text/css'/>
                                    <style type='text/css'>table, th, td {border: 1px solid #e9e9e9;border-collapse: collapse;padding: 8px;} .align_text {text-align: justify;} tr {page-break-inside: avoid;}</style>
                                </head>
                                <body style='font-family: Helvetica;font-size: 18px;color: #333333;'>
                                    <div class='' id='my_outline' runat='server'>
                                        <div class='' id='my_print_outline' runat='server' style='margin-bottom: 150px;'>
                                            " + Html + @"
                                        </div>
                                    </div>
                                </body>
                            </html>";
        HtmlString = HtmlString.Replace("­", "").Replace(" ", " ").Replace("¢", "&#162;").Replace("£", "&#163;").Replace("§", "&#167;").Replace("©", "&#169;").Replace("«", "&#171;").Replace("»", "&#187;").Replace("®", "&#174;").Replace("°", "&#176;").Replace("±", "&#177;").Replace("¶", "&#182;").Replace("·", "&#183;").Replace("½", "&#188;").Replace("–", "&#8211;").Replace("—", "&#8212;").Replace("‘", "&#8216;").Replace("’", "&#8217;").Replace("‚", "&#8218	").Replace("“", "&#8220;").Replace("”", "&#8221;").Replace("„", "&#8222;").Replace("†", "&#8224;").Replace("‡", "&#8225;").Replace("•", "&#8226;").Replace("…", "&#8230;").Replace("€", "&#8364;").Replace("™", "&#8482;").Replace("≈", "&#8776;").Replace("≠", "&#8800;").Replace("≤", "&#8804;").Replace("≥", "&#8805;").Replace("′", "&#8242;").Replace("″", "&#8243;");
        // .Replace("′", "&#8242;").Replace("″", "&#8243;").Replace(">", "&#062;").Replace("<", "&#060;")
        var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
        var margins = new PageMargins();
        margins.Top = 25;
        margins.Bottom = 25;
        margins.Left = 25;
        margins.Right = 25;
        htmlToPdf.Margins = margins;
        htmlToPdf.Size = NReco.PdfGenerator.PageSize.A4;
        var pdfBytes = htmlToPdf.GeneratePdf(HtmlString);
        var PDfFilepath = HttpContext.Current.Server.MapPath("~/OutLinePdfs/");
        string currentTime = DateTime.Now.ToString("Time(hh:mm tt)-Date(dd-MM-yyyy)");
        FileStream fs = new FileStream(PDfFilepath + "\\StudentCourseOutline_" + student + "_" + Sem + "_" + Year + ".pdf", FileMode.Create);
        fs.Write(pdfBytes, 0, pdfBytes.Length);
        fs.Dispose();
        fs.Close();
        string FilePath = "/OutLinePdfs/StudentCourseOutline_" + student + "_" + Sem + "_" + Year + ".pdf";
        string FileName = "StudentCourseOutline_" + student + "_" + Sem + "_" + Year + ".pdf";
        return "{\"Status\":\"1\",\"FilePath\":\"" + FilePath + "\",\"FileName\":\"" + FileName + "\"}";
    }
}
