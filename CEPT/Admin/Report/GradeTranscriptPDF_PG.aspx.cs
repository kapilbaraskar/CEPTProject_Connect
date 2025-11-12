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

public partial class Admin_Report_GradeTranscriptPDF_PG : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["user_type"] == null)
            {
                if (Application["Name"] == "Page Name")
                {
                    Application["Name"] = "";
                }
                else
                {
                    Response.Redirect("~/Login.aspx?autho=false");
                }
            }
            else if (Session["user_type"].ToString() != "FA" && Session["user_type"].ToString() != "A1")
            {
                Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            }
        }

        hdn_uid.Value = Request.QueryString["uid"];
        hdn_sem.Value = Request.QueryString["sem"];
        hdn_year.Value = Request.QueryString["year"];
        if (Request.QueryString["new_tab"].ToString() != "")
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

        for (int i = 0; i < 5; i++)
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