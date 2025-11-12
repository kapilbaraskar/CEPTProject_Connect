using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_Master_HR_TA_PrintLetter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                //if (Request.QueryString["session"] != null)
                //{
                //    ReportPrinter.SetSession(Request.QueryString["session"]);
                //}

                string directory_path = "C:/Ceptreg_Log/";
                System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "Inside Print Letter : " + Environment.NewLine);

                lbl_month_year.Text = DateTime.Now.ToLongDateString().ToString().Split(',')[1].Split(' ')[1] + " " + DateTime.Now.Year.ToString();

                string month = "";
                if (DateTime.Now.Month < 10) month = "0" + DateTime.Now.Month.ToString();
                else month = DateTime.Now.Month.ToString();
                //lbl_date.Text = DateTime.Now.Day.ToString() + "-" + DateTime.Now.ToLongDateString().ToString().Split(',')[1].Split(' ')[1] + "-" + DateTime.Now.Year.ToString();
                lbl_date.Text = DateTime.Now.Day.ToString() + "/" + month + "/" + DateTime.Now.Year.ToString();

                string instructor_code = Request.QueryString["iid"].ToString();
                string dept_name = Request.QueryString["idept"].ToString();
                string sem_code = Request.QueryString["sc"].ToString();
                string year_code = Request.QueryString["yc"].ToString();
                string str_profs = "";

                lbl_short_dept.Text = dept_name[0].ToString();

                if (instructor_code != "")
                {
                    DataTable dt_instructor_detail = get_instructor_detail(instructor_code, dept_name, sem_code, year_code);

                    DataTable dt_prog_coordinator_detail = get_program_coordinator_detail(sem_code, year_code);

                    if (dt_instructor_detail != null)
                    {
                        lbl_sr_no.Text = get_sr_no(sem_code, year_code);

                        if (Convert.ToInt32(lbl_sr_no.Text) < 10) lbl_sr_no.Text = "0" + lbl_sr_no.Text;

                        if (dt_instructor_detail.Rows[0]["title"].ToString() != "")
                        {
                            lbl_to_title.Text = dt_instructor_detail.Rows[0]["title"].ToString();
                            lbl_title.Text = dt_instructor_detail.Rows[0]["title"].ToString();
                        }
                        else
                        {
                            lbl_to_title.Text = "Mr./Ms.";
                            lbl_title.Text = "Mr./Ms.";
                        }

                        string[] str_address = dt_instructor_detail.Rows[0]["address"].ToString().Split(',');

                        for (int i = 0; i < dt_instructor_detail.Rows[0]["address"].ToString().Split(',').Length; i++)
                        {
                            //lbl_address.Text = lbl_address.Text + str_address[i] + "<br />";
                            lbl_address.Text = lbl_address.Text + System.Threading.Thread.CurrentThread.CurrentCulture.TextInfo.ToTitleCase(str_address[i].ToLower()) + "<br />";
                        }

                        lbl_to_instructor_name.Text = dt_instructor_detail.Rows[0]["instructor_name"].ToString();
                        lbl_instructor_name.Text = dt_instructor_detail.Rows[0]["instructor_name"].ToString();
                        lbl_sub_dept.Text = dt_instructor_detail.Rows[0]["dept_name"].ToString();
                        lbl_dept.Text = dt_instructor_detail.Rows[0]["dept_name"].ToString();

                        // spn_dept.InnerHtml = dt_instructor_detail.Rows[0]["dept_name"].ToString(); //comment By Ananth

                        if (dt_instructor_detail.Rows[0]["rate_wise_designation"].ToString() != "")
                        {
                            lbl_sub_vfdesignation.Text = dt_instructor_detail.Rows[0]["rate_wise_designation"].ToString();
                            lbl_vfdesignation.Text = dt_instructor_detail.Rows[0]["rate_wise_designation"].ToString();
                        }
                        else
                        {
                            lbl_sub_vfdesignation.Text = "Faculty";
                            lbl_vfdesignation.Text = "Faculty";
                        }

                        string str_sincere_prof = "";
                        string str_sincere_dean_dept = "";
                        string str_signature = "";
                        string lbl_sincerely_dean_dir = "Dean";
                        switch (dt_instructor_detail.Rows[0]["dept_name"].ToString())
                        {
                            case "Architecture":
                                str_sincere_prof = "Prof. Anjali Yagnik";
                                //str_sincere_dean_dept = "Dean, Faculty of Architecture";
                                str_sincere_dean_dept = "Faculty of Architecture";
                                str_signature = "../../image/signature_FA.jpg?t=1";
                                break;
                            case "Design":
                                //str_sincere_prof = "Prof. Krishna Shastri";
                                //str_sincere_prof = "Prof. A. Srivathsan";
                                str_sincere_prof = "Prof. Anand Belhe";
                                //str_sincere_dean_dept = "Dean, Faculty of Design";
                                str_sincere_dean_dept = "Faculty of Design";
                                str_signature = "../../image/signature_FD.jpg?t=1";
                                break;
                            case "Management":
                                str_sincere_prof = "Prof. Chirayu Bhatt";
								lbl_sincerely_dean_dir = "Acting Dean";
                                //str_sincere_dean_dept = "Dean, Faculty of Management";
                                str_sincere_dean_dept = "Faculty of Management";
                                str_signature = "../../image/signature_FM.png?t=1";
                                break;
                            case "Planning":
                                //str_sincere_prof = "Prof. Darshini Mahadevia";
                                //str_sincere_prof = "Prof. Vidyadhar Phatak";
                                str_sincere_prof = "Mona Iyer, PhD";
								lbl_sincerely_dean_dir = "Acting Dean";
                                //str_sincere_dean_dept = "Dean, Faculty of Planning";
                                str_sincere_dean_dept = "Faculty of Planning";
                                str_signature = "../../image/signature_FP.jpg?t=1";
                                break;
                            case "Technology":
                                //str_sincere_prof = "Prof. Anjana Vyas";
                                //str_sincere_prof = "Prof. A. Srivathsan";
                                str_sincere_prof = "Prof. Aanal Shah";
								lbl_sincerely_dean_dir = "Acting Dean";
                                //str_sincere_dean_dept = "Dean, Faculty of Technology";
                                str_sincere_dean_dept = "Faculty of Technology";
                                str_signature = "../../image/signature_FT.jpg?t=1";
                                break;
                        }

                        if (dt_instructor_detail.Rows[0]["dept_code"].ToString() == "10" || dt_instructor_detail.Rows[0]["prog_level_code"].ToString() == "PHD" || dt_instructor_detail.Rows[0]["prog_code"].ToString() == "3")
                        {
                            str_sincere_prof = "Dr. Rutul Joshi";
                            str_sincere_dean_dept = "Head, Doctoral Office";
                            str_signature = "../../image/signature_doctoral.png?t=1";
                            lbl_sincerely_dean_dir = "";
                        }
                        else {
                         //   if (dt_instructor_detail.Rows[0]["dept_name"].ToString() != "Planning")
                         //   {
                         //       lbl_sincerely_dean_dir = "Dean / Director";
                         //   }
                        }

                        lbl_sincerely_professor.Text = str_sincere_prof;
                        lbl_sincerely_dean_dept.Text = str_sincere_dean_dept;
                        lbl_sincerely_dean_director.Text = lbl_sincerely_dean_dir;

                        img_signature.Src = str_signature;


                        string str_div_html = "", str_prog_co_html = " <table style='width: 90%;'>";
                        double total_remuneration = 0;

                        int highest_weeks = 0;

                        for (int i = 0; i < dt_instructor_detail.Rows.Count; i++)
                        {
                            string str_total = "";

                            int current_weeks = Convert.ToInt32(dt_instructor_detail.Rows[i]["total_weeks"].ToString());
                            if (highest_weeks <= current_weeks) { highest_weeks = current_weeks; }

                            if (dt_instructor_detail.Rows[i]["total_hrs_in_semester"].ToString() != "" && dt_instructor_detail.Rows[i]["rate_band"].ToString() != "")
                            {
                                str_total = (Convert.ToDouble(dt_instructor_detail.Rows[i]["total_hrs_in_semester"].ToString()) * Convert.ToDouble(dt_instructor_detail.Rows[i]["rate_band"].ToString())).ToString();
                                total_remuneration = total_remuneration + Convert.ToDouble(str_total);
                            }
                            string first12week = "";
                            string lastremainingweek = "";
                            string firstweek = "";
                            string lastweek = "";

                            if (Convert.ToDouble(dt_instructor_detail.Rows[i]["total_weeks"].ToString()) > 12)
                            {
                                first12week = (Convert.ToDouble(12) * Convert.ToDouble(dt_instructor_detail.Rows[i]["total_hrs"].ToString())).ToString();
                                lastremainingweek = (Convert.ToDouble(dt_instructor_detail.Rows[i]["total_hrs_in_semester"].ToString()) - Convert.ToDouble(first12week)).ToString();
                                firstweek = "12";
                                lastweek = (Convert.ToDouble(dt_instructor_detail.Rows[i]["total_weeks"].ToString()) - Convert.ToDouble(12)).ToString();
                            }
                            else
                            {
                                first12week = (Convert.ToDouble(dt_instructor_detail.Rows[i]["total_weeks"].ToString()) * Convert.ToDouble(dt_instructor_detail.Rows[i]["total_hrs"].ToString())).ToString();
                                lastremainingweek = "0";
                                firstweek = dt_instructor_detail.Rows[i]["total_weeks"].ToString();
                                lastweek = "0";
                            }

                            dt_instructor_detail.Rows[i]["type_name"] = dt_instructor_detail.Rows[i]["is_tutorial"].ToString() == "Y" ? "Tutorial" : dt_instructor_detail.Rows[i]["type_name"].ToString();

                            DataTable dt_co_tutor_course = get_co_tutor_course_wise_instructor(dt_instructor_detail.Rows[i]["instructor_code"].ToString(), dt_instructor_detail.Rows[i]["course_code"].ToString(), sem_code, year_code);

                            if (dt_co_tutor_course != null)
                            {
                                for (int j = 0; j < dt_co_tutor_course.Rows.Count; j++)
                                {
                                    if (str_profs != "")
                                        str_profs += ", ";

                                    str_profs += "Prof. " + dt_co_tutor_course.Rows[j]["user_name"].ToString();
                                }
                            }

                            //str_div_html = str_div_html + "<table class='table table-bordered'>" +
                            //                "<tr>" +
                            //                    "<td style='width: 203px;'><b>Course Code</b></td>" +
                            //                    "<td style='width: 120px;'>" + dt_instructor_detail.Rows[i]["course_code"].ToString() + "</td>" +
                            //                    "<td style='width: 200px;'><b>Course Name</b></td>" +
                            //                    "<td colspan='3'>" + dt_instructor_detail.Rows[i]["course_name"].ToString() + "</td>" +
                            //                "</tr>" +
                            //                "<tr>" +
                            //                    "<td style='width: 203px;'><b>Course Type</b></td>" +
                            //                    "<td style='width: 120px;'>" + dt_instructor_detail.Rows[i]["type_name"].ToString() + "</td>" +
                            //                    "<td style='width: 200px;'><b>Course Credits</b></td>" +
                            //                    "<td style='width: 25px;'>" + dt_instructor_detail.Rows[i]["course_credits"].ToString() + "</td>" +
                            //                    "<td style='width: 207px;'><b>Contact Hours per week</b></td>" +
                            //                    "<td style='width: 50px;'>" + dt_instructor_detail.Rows[i]["total_contact_hrs"].ToString() + "</td>" +
                            //                "</tr>" +
                            //                "<tr style='display: none;'>" +
                            //                    "<td><b>Preparatory Hours per week</b></td>" +
                            //                    "<td>" + dt_instructor_detail.Rows[i]["total_preparation_hrs"].ToString() + "</td>" +
                            //                    "<td><b>Total no. of Hours per week</b></td>" +
                            //                    "<td>" + dt_instructor_detail.Rows[i]["total_hrs"].ToString() + "</td>" +
                            //                    "<td><b>Total no. of weeks(semester)</b></td>" +
                            //                    "<td>" + dt_instructor_detail.Rows[i]["total_weeks"].ToString() + "</td>" +
                            //                "</tr>" +
                            //                "<tr>" +
                            //                    "<td><b>Hours for remuneration</b></td>" +
                            //                    "<td>" + dt_instructor_detail.Rows[i]["total_hrs_in_semester"].ToString() + "</td>" +
                            //                    "<td><b>Hourly Rate</b></td>" +
                            //                    "<td>" + dt_instructor_detail.Rows[i]["rate_band"].ToString() + "</td>" +
                            //                    "<td><b>Total (Rs.)</b></td>" +
                            //    //"<td>" + str_total + "</td>" +
                            //    //"<td>" + Math.Round(Convert.ToDouble(str_total),2).ToString() + "</td>" +
                            //                    "<td>" + Convert.ToInt32(Convert.ToDouble(str_total)).ToString() + "</td>" +
                            //                "</tr>" +
                            //            "</table>";

                            int total_hrs = 0;

                            if (dt_instructor_detail.Rows[i]["additional_hours"].ToString() != "")
                            {
                                total_hrs = Convert.ToInt32(dt_instructor_detail.Rows[i]["additional_hours"].ToString()) + Convert.ToInt32(dt_instructor_detail.Rows[i]["total_hrs_in_semester"].ToString());
                                str_total = (Convert.ToDouble(str_total) + (Convert.ToDouble(dt_instructor_detail.Rows[i]["additional_hours"].ToString()) * Convert.ToDouble(dt_instructor_detail.Rows[i]["rate_band"].ToString()))).ToString();
                                total_remuneration = total_remuneration + (Convert.ToDouble(dt_instructor_detail.Rows[i]["additional_hours"].ToString()) * Convert.ToDouble(dt_instructor_detail.Rows[i]["rate_band"].ToString()));
                            }
                            else
                            {
                                total_hrs = Convert.ToInt32(dt_instructor_detail.Rows[i]["total_hrs_in_semester"].ToString());
                            }

                            str_div_html = str_div_html + "<table class='table table-bordered clsCourseTable'>" +
                                            "<tr>" +
                                               "<td style='width: 25%;'><b>Course Code</b></td>" +
                                               "<td style='width: 25%;'>" + dt_instructor_detail.Rows[i]["course_code"].ToString() + "</td>" +
                                            "</tr>" +
                                            "<tr>" +
                                               "<td style='width: 25%;'><b>Hours per Semester</b></td>" +
                                               "<td style='width: 25%;'>" + total_hrs + "</td>" + //Convert.ToInt32(dt_instructor_detail.Rows[i]["total_hrs_in_semester"].ToString())
                                            "</tr>" +
                                            "<tr>" +
                                               "<td style='width: 25%;'><b>Rate per Hour</b></td>" +
                                               "<td style='width: 25%;'>Rs. " + dt_instructor_detail.Rows[i]["rate_band"].ToString() + "</td>" +
                                            "</tr>" +
                                            "<tr>" +
                                               "<td style='width: 25%;'><b>Total Professional Fees for Semester</b></td>" +
                                               "<td style='width: 75%;' colspan='3'>Rs. " + Convert.ToInt32(Convert.ToDouble(str_total)).ToString() + "</td>" +
                                            "</tr>" +
                                            "</table><p class='cls_p_pgbreak' style='page-break-before: always; display: none;'>&nbsp;</p><div class='cls_div_pgbreak'></div>";
                            //if (i == 0)
                            //{
                            //    str_div_html = str_div_html + "<p id='table1' style='page-break-before: always;display:none;'>&nbsp;</p>";
                            //}

                            if (dt_prog_coordinator_detail != null)
                            {
                                DataRow[] dr = null;
                                if (dt_instructor_detail.Rows[i]["prog_level_code"].ToString() != "")
                                {
                                    dr = dt_prog_coordinator_detail.Select("dept_code ='" + dt_instructor_detail.Rows[i]["dept_code"].ToString() + "' and prog_code ='" + dt_instructor_detail.Rows[i]["prog_code"].ToString() + "' and prog_level_code ='" + dt_instructor_detail.Rows[i]["prog_level_code"].ToString() + "'");
                                }
                                else
                                {
                                    dr = dt_prog_coordinator_detail.Select("dept_code ='" + dt_instructor_detail.Rows[i]["dept_code"].ToString() + "' and prog_code ='" + dt_instructor_detail.Rows[i]["prog_code"].ToString() + "' ");
                                }


                                if (dr.Length > 0)
                                {
                                    string prog_name = dt_instructor_detail.Rows[i]["prog_name"].ToString();

                                    if (dt_instructor_detail.Rows[i]["prog_level_desc"].ToString() != "")
                                    {
                                        prog_name += " - " + dt_instructor_detail.Rows[i]["prog_level_desc"].ToString();
                                    }

                                    for (int k = 0; k < dr.Length; k++)
                                    {
                                        if (!str_prog_co_html.Contains(dr[k]["user_name"].ToString()))
                                        {
                                            if (dr[k]["letter_label"].ToString() != "")
                                            {
                                                if (dr[k]["letter_label"].ToString() == "PCO")
                                                {
                                                    str_prog_co_html = str_prog_co_html + "<tr><td <td style='border: none; width: 165px;'>Program Cord</td>";
                                                }
                                                else if (dr[k]["letter_label"].ToString() == "PCH")
                                                {
                                                    str_prog_co_html = str_prog_co_html + "<tr><td <td style='border: none; width: 165px;'>Program Chair</td>";
                                                }
                                            }
                                            else if(dr[k]["mail"].ToString() == "kadam@cept.ac.in" && dr[k]["prog_level_code"].ToString() == "UP2")
                                            {
                                                str_prog_co_html = str_prog_co_html + "<tr><td <td style='border: none; width: 165px;'>Program Cord</td>";
                                            }
                                            else
                                            {
                                                str_prog_co_html = str_prog_co_html + "<tr><td <td style='border: none; width: 165px;'>Program Chair</td>";
                                            }

                                            str_prog_co_html = str_prog_co_html + "<td style='border: none; width: 10px;'>:</td>" +
                                                              "<td style='border: none; width: 350px;'>" + dr[k]["user_name"].ToString() + "( " + prog_name + " )</td>" +
                                                            "<td>Email</td>" +
                                                            "<td style='border: none; width: 10px'>:</td>" +
                                                            "<td>" + dr[k]["mail"].ToString() + "</td>" +
                                                        "</tr>";
                                        }

                                    }
                                }

                            }
                        }

                        weeks.Text = highest_weeks.ToString();

                        div_course_detail.InnerHtml = str_div_html;

                        if (Request.QueryString["FA_name"] != null)
                        {
                            str_prog_co_html = str_prog_co_html + "<tr>" +
                                                             "<td <td style='border: none; width: 165px;'>Faculty Admin</td>" +
                                                             "<td style='border: none; width: 10px;'>:</td>" +
                                                               "<td style='border: none; width: 350px;'>" + Request.QueryString["FA_name"] + "</td>" +
                                                             "<td>Email</td>" +
                                                             "<td style='border: none; width: 10px'>:</td>" +
                                                             "<td>" + Request.QueryString["FA_mail"] + "</td>" +
                                                         "</tr>";
                        }



                        div_prog_coordinator.InnerHtml = str_prog_co_html + "</table>";
                        if (total_remuneration != 0)
                        {
                            //lbl_total_remuneration.Text = Math.Round(total_remuneration,2).ToString();
                            //lbl_total_remuneration.Text = Convert.ToInt32(total_remuneration).ToString();
                            //int amount = Convert.ToInt32(total_remuneration.ToString());
                            int amount = Convert.ToInt32(total_remuneration);
                            //lbl_total_remuneration_in_words.Text = convert_number(amount) + " Only";
                        }
                    }
                }

                System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "End Print Letter : " + Environment.NewLine);

                //spn_profs.InnerHtml += (str_profs == "") ? "Professor" : str_profs;
            }
            catch (Exception ex)
            {
                string directory_path = "C:/Ceptreg_Log/";
                System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "New Course_code : " + ex.ToString() + Environment.NewLine);
            }
        }
    }

    //public DataTable get_instructor_detail(string instructor_code, string dept_name, string sem_code, string year_code)
    //{
    //    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

    //    DataTable dt_stud_detail = new DataTable();
    //    try
    //    {
    //        SqlCommand cmd = con.CreateCommand();

    //        cmd.CommandText = " select instructor_workload_detail.instructor_code,instructor_mst.title,instructor_mst.instructor_name,instructor_mst.designation,instructor_mst.rate_wise_designation, instructor_workload_detail.total_weeks, " +
    //                            " instructor_workload_detail.total_contact_hrs, instructor_workload_detail.total_preparation_hrs,  instructor_workload_detail.total_hrs, " +
    //                            " instructor_workload_detail.total_hrs_in_semester,instructor_mst.total_experiance, instructor_mst.highest_qualification," +

    //                            //" (case ISNULL(instructor_mst.alternate_band,'') when '' then instructor_mst.rate_band else instructor_mst.alternate_band end)rate_band," +
    //                            " (case ISNULL(instructor_workload_detail.alternate_band,'') when '' then (case ISNULL(instructor_mst.alternate_band,'') "+
    //                                " when '' then instructor_mst.rate_band else instructor_mst.alternate_band end) else instructor_workload_detail.alternate_band end)rate_band, " +

    //                            " instructor_mst.address,instructor_workload_detail.justification, course_mst.course_code,course_mst.course_name,course_mst.course_credits, " +
    //                            " department_wise_course_dtl.dept_code,department_mst.dept_name,department_wise_course_dtl.prog_code,programme_mst.prog_name," +
    //                            " department_wise_course_dtl.course_typology,course_type_mst.type_name,course_type_mst.prep_hr_per_week " +
    //                            " from instructor_workload_detail " +
    //                            " inner join course_mst on course_mst.course_code = instructor_workload_detail.course_code" +
    //                            " inner join department_wise_course_dtl on department_wise_course_dtl.course_code = instructor_workload_detail.course_code" +
    //                            " inner join instructor_mst on instructor_mst.instructor_code = instructor_workload_detail.instructor_code " +
    //                            " left join course_type_mst on course_type_mst.type_code = department_wise_course_dtl.course_typology" +
    //                            " left join department_mst on department_mst.dept_code = department_wise_course_dtl.dept_code" +
    //                            " left join programme_mst on programme_mst.prog_code = department_wise_course_dtl.prog_code" +
    //                            " where instructor_workload_detail.semester_type = '" + sem_code + "' and instructor_workload_detail.year_semester = '" + year_code + "' " +
    //                            " and instructor_workload_detail.instructor_code = '" + instructor_code + "'" +
    //                            " and course_mst.semester_type = '" + sem_code + "' and course_mst.year_semester = '" + year_code + "' " +
    //                            " and department_wise_course_dtl.semester_type = '" + sem_code + "' and department_wise_course_dtl.year_semester = '" + year_code + "' " +
    //                            " and department_mst.dept_name = '" + dept_name + "' and instructor_workload_detail.cancel_flag = 'N'  and instructor_mst.cancel_flag = 'N' " +
    //                            " order by course_mst.course_code";

    //        cmd.CommandType = CommandType.Text;

    //        SqlDataAdapter da = new SqlDataAdapter(cmd);

    //        dt_stud_detail = new DataTable();

    //        da.Fill(dt_stud_detail);
    //    }
    //    catch (Exception ex)
    //    {
    //    }

    //    if (dt_stud_detail.Rows.Count <= 0)
    //        return null;
    //    else
    //        return dt_stud_detail;

    //}

    public DataTable get_instructor_detail(string instructor_code, string dept_name, string sem_code, string year_code)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = " select instructor_workload_detail.instructor_code,instructor_mst.title,instructor_mst.instructor_name,instructor_mst.designation,instructor_mst.rate_wise_designation, instructor_workload_detail.total_weeks, " +
                                " instructor_workload_detail.total_contact_hrs, instructor_workload_detail.total_preparation_hrs,  instructor_workload_detail.total_hrs, " +
                                " instructor_workload_detail.total_hrs_in_semester,instructor_mst.total_experiance, instructor_mst.highest_qualification," +

                                //" (case ISNULL(instructor_mst.alternate_band,'') when '' then instructor_mst.rate_band else instructor_mst.alternate_band end)rate_band," +

                                //" (case ISNULL(instructor_workload_detail.alternate_band,'') when '' then (case ISNULL(instructor_mst.alternate_band,'') " +
                //" when '' then instructor_mst.rate_band else instructor_mst.alternate_band end) else instructor_workload_detail.alternate_band end)rate_band, " +
                                " (case ISNULL(instructor_workload_detail.alternate_band,'') when '' then instructor_workload_detail.rate_band else instructor_workload_detail.alternate_band end )rate_band, " +

                                " instructor_mst.address,instructor_workload_detail.justification, course_mst.course_code,course_mst.course_name,course_mst.course_credits, " +
                                " department_wise_course_dtl.dept_code,department_mst.dept_name,department_wise_course_dtl.prog_code,programme_mst.prog_name," +
                                " department_wise_course_dtl.course_typology,course_type_mst.type_name,course_type_mst.prep_hr_per_week,department_wise_course_dtl.prog_level_code, " +
                                " programme_level_mst.prog_level_desc,instructor_workload_detail.is_tutorial,instructor_workload_detail.additional_hours " +
                                " from instructor_workload_detail " +
                                " inner join course_mst on course_mst.course_code = instructor_workload_detail.course_code" +
                                " inner join department_wise_course_dtl on department_wise_course_dtl.course_code = instructor_workload_detail.course_code" +
                                " inner join instructor_mst on instructor_mst.instructor_code = instructor_workload_detail.instructor_code " +
                                " left join course_type_mst on course_type_mst.type_code = department_wise_course_dtl.course_typology" +
                                " left join department_mst on department_mst.dept_code = department_wise_course_dtl.dept_code" +
                                " left join programme_mst on programme_mst.prog_code = department_wise_course_dtl.prog_code" +
                                " left join programme_level_mst on  programme_level_mst.prog_level_code = department_wise_course_dtl.prog_level_code " +
                                " where instructor_workload_detail.semester_type = '" + sem_code + "' and instructor_workload_detail.year_semester = '" + year_code + "' " +
                                " and instructor_workload_detail.instructor_code = '" + instructor_code + "'" +
                                " and course_mst.semester_type = '" + sem_code + "' and course_mst.year_semester = '" + year_code + "' " +
                                " and department_wise_course_dtl.semester_type = '" + sem_code + "' and department_wise_course_dtl.year_semester = '" + year_code + "' " +
                                " and department_mst.dept_name = '" + dept_name + "' and instructor_workload_detail.cancel_flag = 'N'  and instructor_mst.cancel_flag = 'N' " +
                                " and instructor_workload_detail.hr_approved='Y' and instructor_workload_detail.admin_approved='Y' " +
                                " order by course_mst.course_code";

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

    public DataTable get_program_coordinator_detail(string sem_code, string year_code)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = " select programme_coordinator_dtl.*,user_mst.user_name,user_mst.mail from programme_coordinator_dtl " +
                              "  inner join user_mst on programme_coordinator_dtl.user_id = user_mst.user_id " +
                              "  where semester_type ='" + sem_code + "' and year_semester ='" + year_code + "' and programme_coordinator_dtl.cancel_flag ='N'  and user_mst.user_status_flag ='A' and user_mst.user_id not in ('I1617000688','I1617000689') ";

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

    public DataTable get_co_tutor_course_wise_instructor(string instructor_code, string course_code, string sem_code, string year_code)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

        DataTable dt_co_tutor = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = " select  course_wise_instructor.*,user_mst.user_name,user_mst.mail from course_wise_instructor " +
                              "  inner join user_mst on  course_wise_instructor.instructor_code = user_mst.user_id " +
                              "  where course_wise_instructor.semester_type ='" + sem_code + "' and course_wise_instructor.year_semester ='" + year_code + "' and course_wise_instructor.cancel_flag ='N'  and user_mst.user_status_flag ='A' and course_wise_instructor.course_code ='" + course_code + "' and course_wise_instructor.instructor_code not in ('" + instructor_code + "')";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_co_tutor = new DataTable();

            da.Fill(dt_co_tutor);
        }
        catch (Exception ex)
        {
        }

        if (dt_co_tutor.Rows.Count <= 0)
            return null;
        else
            return dt_co_tutor;

    }


    public string get_sr_no(string sem_code, string year_code)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

        DataTable dt_sr_no = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            string sem_year = sem_code + "_" + year_code;
            cmd.CommandText = " select * from next_doc_no where doc_type='PLSRNO' and company_id='" + sem_year + "'";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_sr_no = new DataTable();

            da.Fill(dt_sr_no);

            cmd.Dispose();
            con.Close();
            con.Dispose();
        }
        catch (Exception ex)
        {
        }

        if (dt_sr_no.Rows.Count <= 0)
        {
            return insert_sr_no_row(sem_code, year_code);
        }
        else
        {
            string sr_no = dt_sr_no.Rows[0]["next_doc_no"].ToString();
            update_sr_no_row(sem_code, year_code, sr_no);
            return (Convert.ToInt32(sr_no) + 1).ToString();
        }

        return "";
    }

    public string insert_sr_no_row(string sem_code, string year_code)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());
        int insert_result = -1;

        try
        {
            SqlCommand cmd = con.CreateCommand();

            string sem_year = sem_code + "_" + year_code;
            //cmd.CommandText = " select * from next_doc_no where doc_type='PLSRNO' and company_id='" + sem_year + "'";
            cmd.CommandText = "insert into next_doc_no(company_id,doc_type,next_doc_no,description,year,year_define,o_c_flag,created_by,created_date,created_host,last_modified_by,last_modified_date,last_modified_host)" +
                                "values('" + sem_year + "','PLSRNO','1','HR Print Letter Serial Number',null,'2',null,'kamlesh','2014-02-14 12:29:47.0000000','10.0.0.0',null,null,null)";

            cmd.CommandType = CommandType.Text;

            con.Open();

            insert_result = cmd.ExecuteNonQuery();

            cmd.Dispose();
            con.Close();
            con.Dispose();
        }
        catch (Exception ex)
        {
        }

        if (insert_result <= 0)
            return "";
        else
            return "1";

        return "";
    }

    public void update_sr_no_row(string sem_code, string year_code, string sr_no)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());
        int insert_result = -1;

        try
        {
            SqlCommand cmd = con.CreateCommand();

            string sem_year = sem_code + "_" + year_code;
            //cmd.CommandText = " select * from next_doc_no where doc_type='PLSRNO' and company_id='" + sem_year + "'";
            cmd.CommandText = "update next_doc_no set next_doc_no='" + (Convert.ToInt32(sr_no) + 1) + "' where doc_type='PLSRNO' and company_id='" + sem_year + "'";

            cmd.CommandType = CommandType.Text;

            con.Open();

            insert_result = cmd.ExecuteNonQuery();

            cmd.Dispose();
            con.Close();
            con.Dispose();
        }
        catch (Exception ex)
        {
        }

        //if (insert_result <= 0)
        //    return "";
        //else
        //    return "1";

        //return "";
    }

    public string convert_number(Int32 number)
    {
        if ((number < 0) || (number > 999999999))
        {
            return "Number is out of range";
        }
        int Gn = number / 10000000;  /* Crore */

        number -= Gn * 10000000;

        int kn = number / 100000;     /* lakhs */

        number -= kn * 100000;

        int Hn = number / 1000;      /* thousand */

        number -= Hn * 1000;

        int Dn = number / 100;       /* Tens (deca) */

        number = number % 100;               /* Ones */

        int tn = number / 10;

        int one = number % 10;

        var res = "";

        if (Gn > 0)
        {
            res += (convert_number(Gn) + " Crore");
        }
        if (kn > 0)
        {
            res += (((res == "") ? "" : " ") + convert_number(kn) + " Lakhs");
        }
        if (Hn > 0)
        {
            res += (((res == "") ? "" : " ") + convert_number(Hn) + " Thousand");
        }

        if (Dn > 0)
        {
            res += (((res == "") ? "" : " ") + convert_number(Dn) + " hundred");
        }


        string[] ones = { "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eightteen", "Nineteen" };
        string[] tens = { "", "", "Twenty", "Thirty", "Fourty", "Fifty", "Sixty", "Seventy", "Eigthy", "Ninety" };

        if (tn > 0 || one > 0)
        {
            if (!(res == ""))
            {
                res += " and ";
            }
            if (tn < 2)
            {
                res += ones[tn * 10 + one];
            }
            else
            {
                res += tens[tn];
                if (one > 0)
                {
                    res += ("-" + ones[one]);
                }
            }
        }

        if (res == "")
        {
            res = "zero";
        }
        return res;
    }
}