using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Script.Serialization;
using BLL.Master;

public partial class Student_LoanLetterPDF : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());
    BLL.Master.Masters objmst = new BLL.Master.Masters();
    string paraname = "loan_letter_pdf";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["uid"] != null)
        {
            string uid = Request["uid"].ToString();
            DataTable dt_stud_detail = get_Student_Detail(uid);
            DataTable dt_paramter = objmst.get_parameter_value(paraname);
            string str = string.Empty;

            if (dt_paramter != null)
            {
                str = dt_paramter.Rows[0]["disable_message"].ToString();
            }
            if (dt_stud_detail != null)
            {
                hdn_stud_detail.Value = GetJson1(dt_stud_detail);

                var str_program = string.Empty;
                string str_year_code = dt_stud_detail.Rows[0]["year_code"].ToString().Substring(1);
                int stud_year_code = Convert.ToInt32(str_year_code);
                if (str_year_code == "1") stud_year_code = 2013;

                if (dt_stud_detail.Rows[0]["prog_desc"] == "Landscape Architecture")
                {
                    str_program = "MASTERS IN LANDSCAPE ARCHITECTURE";
                }
                else if (dt_stud_detail.Rows[0]["prog_desc"] == "Landscape Design")
                {
                    str_program = "MASTERS IN LANSCAPE DESIGN";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "2" && dt_stud_detail.Rows[0]["prog_code"] == "1")
                { // FD UG
                    str_program = "BACHELOR OF INTERIOR DESIGN";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "4" && dt_stud_detail.Rows[0]["prog_code"] == "1" && stud_year_code >= 2016)
                { // FP UG
                    str_program = "BACHELOR OF URBAN DESIGN";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "4" && dt_stud_detail.Rows[0]["prog_code"] == "2" && stud_year_code == 2014)
                { // FP PG
                    str_program = "MASTER OF PLANNING";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "4" && dt_stud_detail.Rows[0]["prog_code"] == "2" && stud_year_code >= 2015)
                { // FP PG
                    str_program = "MASTER OF URBAN DESIGN";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "5" && dt_stud_detail.Rows[0]["prog_code"] == "1" && stud_year_code <= 2012)
                { // FT UG
                    str_program = "BACHELOR OF TECHNOLOGY(HONS. CIVIL-CONSTRUCTION)";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "5" && dt_stud_detail.Rows[0]["prog_code"] == "1" && stud_year_code >= 2013)
                { // FT UG
                    str_program = "BACHELOR OF CONSTRUCTION TECHNOLOGY";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "5" && dt_stud_detail.Rows[0]["prog_code"] == "2" && dt_stud_detail.Rows[0]["prog_level_code"] == "PT1")
                { // FT PG
                    str_program = "MASTER OF TECHNOLOGY (CONSTRUCTION ENGINEERING & MANAGEMENT)";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "5" && dt_stud_detail.Rows[0]["prog_code"] == "2" && dt_stud_detail.Rows[0]["prog_level_code"] == "PT2")
                { // FT PG
                    str_program = "MASTER OF TECHNOLOGY (GEOMATICS)";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "5" && dt_stud_detail.Rows[0]["prog_code"] == "2" && dt_stud_detail.Rows[0]["prog_level_code"] == "PT3")
                { // FT PG
                    str_program = "MASTER OF TECHNOLOGY (INFRASTRUCTURE ENGINEERING DESIGN)";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "5" && dt_stud_detail.Rows[0]["prog_code"] == "2" && dt_stud_detail.Rows[0]["prog_level_code"] == "PT4")
                { // FT PG
                    str_program = "MASTER OF TECHNOLOGY (STRUCTURAL ENGINEERING DESIGN)";
                }
                else if (dt_stud_detail.Rows[0]["dept_code"] == "5" && dt_stud_detail.Rows[0]["prog_code"] == "2" && dt_stud_detail.Rows[0]["prog_level_code"] == "PT5")
                { // FT PG
                    str_program = "MASTER OF TECHNOLOGY (BUILDING ENERGY PERFORMANCE)";
                }
                else if (dt_stud_detail.Rows[0]["prog_level_name"] == "")
                {
                    switch (dt_stud_detail.Rows[0]["prog_code"].ToString())
                    {
                        case "1": str_program = "BACHELOR OF " + dt_stud_detail.Rows[0]["dept_name"]; break;
                        case "2": str_program = "MASTER OF " + dt_stud_detail.Rows[0]["dept_name"]; break;
                    }
                }
                else
                {
                    str_program = dt_stud_detail.Rows[0]["prog_level_name"].ToString();
                }
                str = str.Replace("@@lbl_prog_name", str_program.ToLower());

                if (dt_stud_detail.Rows[0]["name_of_the_degree"] != "" && dt_stud_detail.Rows[0]["name_of_the_degree"] != string.Empty)
                {
                    str = str.Replace("@@lbl_prog_name", dt_stud_detail.Rows[0]["name_of_the_degree"].ToString().ToLower());
                }
                if (dt_stud_detail.Rows[0]["gender"].ToString().Trim() == "M")
                {
                    str = str.Replace("@@lbl_title", "Mr.");
                    str = str.Replace("@@lbl_his_her1", "his");
                    str = str.Replace("@@lbl_his_her2", "his");
                    str = str.Replace("@@lbl_his_her3", "His");
                    str = str.Replace("@@lbl_he_she1", "He");
                    str = str.Replace("@@lbl_he_she2", "he");
                    str = str.Replace("@@lbl_he_she3", "He");
                }
                else if (dt_stud_detail.Rows[0]["gender"].ToString().Trim() == "F")
                {
                    str = str.Replace("@@lbl_title", "Ms.");
                    str = str.Replace("@@lbl_his_her1", "her");
                    str = str.Replace("@@lbl_his_her2", "her");
                    str = str.Replace("@@lbl_his_her3", "Her");
                    str = str.Replace("@@lbl_he_she1", "She");
                    str = str.Replace("@@lbl_he_she2", "she");
                    str = str.Replace("@@lbl_he_she3", "She");
                }

                str = str.Replace("@@lbl_name", dt_stud_detail.Rows[0]["user_name"].ToString().Trim().ToLower());
                str = str.Replace("@@lbl_user_id", uid);
                str = str.Replace("@@lbl_dept_name1", dt_stud_detail.Rows[0]["dept_name"].ToString().Trim());
                str = str.Replace("@@lbl_dept_name2", dt_stud_detail.Rows[0]["dept_name"].ToString().Trim());

                if (dt_stud_detail.Rows[0]["prog_code"].ToString() == "1")
                {
                    str = str.Replace("@@lbl_total_year", "five");
                    if (dt_stud_detail.Rows[0]["year_code"].ToString().Trim() == "Y1")
                    {
                        str = str.Replace("@@lbl_apprx_grad_year", (2013 + 5).ToString());
                    }
                    else
                    {
                        str = str.Replace("@@lbl_apprx_grad_year", (Convert.ToInt32(dt_stud_detail.Rows[0]["year_code"].ToString().Substring(1, 4)) + 5).ToString());
                    }
                }
                else if (dt_stud_detail.Rows[0]["prog_code"].ToString() == "2")
                {
                    str = str.Replace("@@lbl_total_year", "two");
                    if (dt_stud_detail.Rows[0]["year_code"].ToString().Trim() == "Y1")
                    {
                        str = str.Replace("@@lbl_apprx_grad_year", (2013 + 2).ToString());
                    }
                    else
                    {
                        str = str.Replace("@@lbl_apprx_grad_year", (Convert.ToInt32(dt_stud_detail.Rows[0]["year_code"].ToString().Substring(1, 4)) + 2).ToString());
                    }
                }

                if (dt_stud_detail.Rows[0]["cur_sem"].ToString() == "M")
                {
                    str = str.Replace("@@lbl_prev_sem", "Spring " + dt_stud_detail.Rows[0]["cur_year"].ToString());
                    str = str.Replace("@@lbl_cur_sem", "Monsoon " + dt_stud_detail.Rows[0]["cur_year"].ToString());

                }
                else if (dt_stud_detail.Rows[0]["cur_sem"].ToString() == "S")
                {
                    str = str.Replace("@@lbl_prev_sem", "Monsoon " + (Convert.ToInt32(dt_stud_detail.Rows[0]["cur_year"].ToString()) - 1));
                    str = str.Replace("@@lbl_cur_sem", "Spring " + dt_stud_detail.Rows[0]["cur_year"].ToString());
                }

                if (dt_stud_detail.Rows[0]["discount_amount"].ToString() != "")
                {
                    str = str.Replace("@@lbl_fees1", dt_stud_detail.Rows[0]["discount_amount"].ToString());
                    str = str.Replace("@@lbl_fees2", dt_stud_detail.Rows[0]["discount_amount"].ToString());
                }
                else
                {
                    str = str.Replace("@@lbl_fees1", dt_stud_detail.Rows[0]["total_fees"].ToString());
                    str = str.Replace("@@lbl_fees2", dt_stud_detail.Rows[0]["total_fees"].ToString());
                }
                
                img_signature.Src = "../image/Dy_CFO.jpg";
            }
            div_content.InnerHtml = str;
            lbl_download_date.Text = DateTime.Now.ToString("MMMM dd,yyyy");
        }
    }
    public DataTable get_Student_Detail(string uid)
    {
        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = @"select user_mst.*,department_mst.dept_name,programme_mst.prog_name,cept_current_semester.sem_code as cur_sem,
                                cept_current_semester.year_code as cur_year,fees_bank_dtl.fees as total_fees,student_transcript_dtl.name_of_the_degree,
                                programme_level_mst.prog_level_name,student_discount_fees_dtl.amount as discount_amount 
                                from user_mst
                                inner join department_mst on department_mst.dept_code = user_mst.dept_code
                                inner join programme_mst on programme_mst.prog_code = user_mst.prog_code
                                inner join cept_current_semester on type_desc='all'
                                inner join fees_bank_dtl on fees_bank_dtl.semester_type = cept_current_semester.sem_code 
                                and fees_bank_dtl.year_semester = cept_current_semester.year_code and fees_bank_dtl.cancel_flag = 'N' 
		                        and fees_bank_dtl.dept_code = user_mst.dept_code and fees_bank_dtl.prog_code = user_mst.prog_code 
		                        and fees_bank_dtl.year_code = user_mst.year_code and fees_bank_dtl.gender = user_mst.gender

                                and (ISNULL(fees_bank_dtl.nationality,'') = (select  Case ISNULL(nationality,'I') 
								When 'I' Then '' when 'India' Then '' When 'Indian' Then ''  
								Else 'International'  End  as nationality from user_mst where user_type ='S' and user_id = '" + uid + @"'))

                                left join student_transcript_dtl on student_transcript_dtl.user_id=user_mst.user_id
                                left join student_discount_fees_dtl on student_discount_fees_dtl.user_id=user_mst.user_id 
                                    and student_discount_fees_dtl.semester_type = cept_current_semester.sem_code and student_discount_fees_dtl.year_semester = cept_current_semester.year_code 
                                    and student_discount_fees_dtl.cancel_flag = 'N' 
                                left join programme_level_mst on user_mst.prog_level_code=programme_level_mst.prog_level_code
                                where user_mst.user_id='" + uid + "'";
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
}