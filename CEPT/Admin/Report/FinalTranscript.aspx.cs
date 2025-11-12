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
using BLL.Master;

public partial class Admin_Report_FinalTranscript : System.Web.UI.Page
{
    Masters masters = new Masters();
    DataTable Get_convocation_year_data = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_uid.Value = Request.QueryString["uid"];
        hdn_sem.Value = Request.QueryString["sem"];
        hdn_year.Value = Request.QueryString["year"];
        if(Request.QueryString["new_tab"].ToString() != "" )
        {
            hdn_tab.Value = Request.QueryString["new_tab"].ToString();
        }
        
        

        GradeReportDetail grd = new GradeReportDetail();

        string stud_detail = "";
        string transcript_detail = "";
        JavaScriptSerializer ser = new JavaScriptSerializer();
        List<Dictionary<string, string>> lst_course_detail = new List<Dictionary<string, string>>();
        List<Dictionary<string, string>> lst_dic_tran_sem_year = new List<Dictionary<string, string>>();

        DataTable dt_stud_detail = grd.get_Student_Detail(hdn_uid.Value, hdn_sem.Value, hdn_year.Value);
        Get_convocation_year_data = null;
        Get_convocation_year_data = masters.Get_convocation_year_data(hdn_uid.Value);
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

        for (int i = 0; i < 15; i++)
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
            DataTable dt_ws_grade_range = grd.get_WS_Grade_Range(hdn_uid.Value, lst_dic_tran_sem_year[i]["sem_code"], lst_dic_tran_sem_year[i]["year_code"]);

            DataTable dt_course_grade_detail = grd.Calculate_grade(dt_stud_detail, dt_course_detail, dt_grade_range);
            DataTable dt_ws_course_grade_detail = grd.WS_Calculate_grade(dt_stud_detail, dt_ws_course_detail, dt_ws_grade_range);
            DataTable dt_credit_detail = grd.Calculate_credits(dt_course_grade_detail, dt_ws_course_grade_detail);
            bool cfp = false;

            if (dt_course_grade_detail != null)
            {
                if (dt_course_grade_detail.Select("course_code IN ('CFP001','CFP002','CFP003','CFP004','CFP005','CFP006','CFP007','CFP008','CFP009','CFP010')").Length > 0)
                {
                    cfp = true;
                    course_detail = grd.GetJson1(dt_course_grade_detail);
                }
                else if (dt_course_grade_detail.Select("remarks='PASS'").Length > 0)
                {
                    dt_course_grade_detail = dt_course_grade_detail.Select("remarks='PASS'").CopyToDataTable();
                    course_detail = grd.GetJson1(dt_course_grade_detail);
                }
            }

            if (dt_ws_course_detail != null)
            {
                if (dt_ws_course_detail.Select("remarks='PASS'").Length > 0)
                {
                    dt_ws_course_detail = dt_ws_course_detail.Select("remarks='PASS'").CopyToDataTable();
                    ws_course_detail = grd.GetJson1(dt_ws_course_detail);
                }
            }

            if (dt_credit_detail != null)
            {
                dt_credit_detail.Columns.Add("type");

                if (cfp)
                {
                    dt_credit_detail.Rows[0]["type"] = "F";
                    credit_detail = grd.GetJson1(dt_credit_detail);
                }
                else
                {
                    dt_credit_detail.Rows[0]["type"] = "R";
                    credit_detail = grd.GetJson1(dt_credit_detail);
                }
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

            //cmd.CommandText = "select student_transcript_convocation_date.completion_date,student_transcript_convocation_date.convocation_year,degree_mst.degree_name, student_transcript_dtl.* from student_transcript_dtl "
            //                 + "left join degree_mst on degree_mst.degree_code=student_transcript_dtl.degree_code "
            //                 + "left join student_transcript_convocation_date student_transcript_convocation_date on student_transcript_convocation_date.completion_date_code = student_transcript_dtl.completion_date_code "
            //                 + "where student_transcript_dtl.user_id = '" + uid + "' ";

            if (Get_convocation_year_data != null && Get_convocation_year_data.Rows[0]["completion_date_code"] != "" 
                && Convert.ToInt32(Get_convocation_year_data.Rows[0]["completion_date_code"].ToString().Substring(0,4)) >= Convert.ToInt32("2023"))
            {
                cmd.CommandText = "select student_transcript_completion_date.completion_date,student_transcript_completion_date.convocation_year,degree_mst.degree_name,"
                           + " UPPER(programme_level_mst.prog_level_name)prog_level_name, student_transcript_convocation_date.graduation_date,"
                           + " student_transcript_dtl.* from student_transcript_dtl "
                           + " left join degree_mst on degree_mst.degree_code=student_transcript_dtl.degree_code "
                           + " inner join user_mst on user_mst.user_id = student_transcript_dtl.user_id "
                           + " left join student_transcript_completion_date student_transcript_completion_date on student_transcript_completion_date.completion_date_code = student_transcript_dtl.completion_date_code and student_transcript_completion_date.prog_code = user_mst.prog_code "
                           + " left join programme_level_mst on programme_level_mst.prog_level_code = user_mst.prog_level_code "
                           //+" left join student_transcript_convocation_date on student_transcript_convocation_date.graduate_date_code = student_transcript_dtl.graduation_year "
                           + " left join student_transcript_convocation_date on student_transcript_convocation_date.graduate_date_code = student_transcript_dtl.graduation_date_code "
                           + " where student_transcript_dtl.user_id = '" + uid + "' ";
            }
            else 
            {
                cmd.CommandText = "select student_transcript_completion_date.completion_date,student_transcript_completion_date.convocation_year,degree_mst.degree_name,"
                           + " UPPER(programme_level_mst.prog_level_name)prog_level_name, student_transcript_convocation_date.graduation_date,"
                           + " student_transcript_dtl.* from student_transcript_dtl "
                           + " left join degree_mst on degree_mst.degree_code=student_transcript_dtl.degree_code "
                           + " left join student_transcript_completion_date student_transcript_completion_date on student_transcript_completion_date.completion_date_code = student_transcript_dtl.completion_date_code "
                           + " inner join user_mst on user_mst.user_id = student_transcript_dtl.user_id "
                           + " left join programme_level_mst on programme_level_mst.prog_level_code = user_mst.prog_level_code "
                           //+" left join student_transcript_convocation_date on student_transcript_convocation_date.graduate_date_code = student_transcript_dtl.graduation_year "
                           + " left join student_transcript_convocation_date on student_transcript_convocation_date.graduate_date_code = student_transcript_dtl.graduation_date_code "
                           + " where student_transcript_dtl.user_id = '" + uid + "' ";
            }

           

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