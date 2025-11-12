using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Student_Wise_Commit_Grade : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            //string str_path = HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.Url.Segments[0] + HttpContext.Current.Request.Url.Segments[1] + HttpContext.Current.Request.Url.Segments[2] + HttpContext.Current.Request.Url.Segments[3];

            string directory_path = "C:/Ceptreg_Log/Grade_Report/";

            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object> Filter_criteria = ser.Deserialize<Dictionary<string, object>>(hdn_filter.Value);

            string sem = Filter_criteria["sem_code"].ToString();
            string year = Filter_criteria["year"].ToString();
            string dept_code = Filter_criteria["dept"].ToString();
            string prog_code = Filter_criteria["prog"].ToString();

            string dept_name = "Other";
            string prog_name = "UG";

            DataTable dt_student_detail = get_student_code(sem, year, dept_code, prog_code);

            Dictionary<string, object> sessionData = new Dictionary<string, object>();
            foreach (string key in Session.Keys)
            {
                sessionData[key] = Session[key];
            }

            if (dt_student_detail.Rows.Count > 0)
            {
                switch (dept_code)
                {
                    case "1":
                        dept_name = "Architecture";
                        break;
                    case "2":
                        dept_name = "Design";
                        break;
                    case "3":
                        dept_name = "Management";
                        break;
                    case "4":
                        dept_name = "Planning";
                        break;
                    case "5":
                        dept_name = "Technology";
                        break;
                }
                switch (prog_code)
                {
                    case "1":
                        prog_name = "UG";
                        break;
                    case "2":
                        prog_name = "PG";
                        break;
                    case "3":
                        prog_name = "Doctoral";
                        break;
                }

                string delete_path = directory_path + dept_name + "/" + prog_name + "/";
                string[] delete_filenames = Directory.GetFiles(delete_path);

                for (int i = 0; i < delete_filenames.Length; i++)
                {
                    FileInfo file = new FileInfo(delete_filenames[i]);
                    file.Delete();
                }

                //HttpContext.Current.Request.Url.Authority.ToString();

                for (int i = 0; i < dt_student_detail.Rows.Count; i++)
                {
                    ReportPrinter obReportPrinter = new ReportPrinter();

                    //obReportPrinter.PageFile = "https://" + str_path + "GradeReportPDF2.aspx?uid=" + dt_student_detail.Rows[i]["user_id"] + "&sem=" + sem + "&year=" + year;
                    obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "GradeReportPDF2.aspx?uid=" + dt_student_detail.Rows[i]["user_id"] + "&sem=" + sem + "&year=" + year;
                    //obReportPrinter.PageFile = "https://localhost:57545/CEPT/Admin/Report/GradeReportPDF2.aspx?uid=" + dt_student_detail.Rows[i]["user_id"] + "&sem=" + sem + "&year=" + year;
                    //obReportPrinter.PageFile = "https://registration.cept.ac.in/ceptregtest1/Admin/Report/GradeReportPDF2.aspx?uid=" + dt_student_detail.Rows[i]["user_id"] + "&sem=" + sem + "&year=" + year;

                    //obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";
                    //obReportPrinter.FooterFile = "https://" + str_path + "Footer.html";
                    obReportPrinter.FooterFile = Server.MapPath("~/Admin/Report/Footer.html");

                    //obReportPrinter.MarginBottom = "0";

                    obReportPrinter.GetPdf();

                    ////Document doc = new iTextSharp.text.Document();
                    ////PdfWriter.GetInstance(doc,new FileStream("D:/tempPDF.pdf",FileMode.Create));
                    ////doc.Open();
                    ////doc.Add(new Paragraph("This is PDF File..."));
                    //////doc.Add();
                    ////doc.Close();

                    //FileStream fs = new FileStream("D:/a/" + dept_name + "/" + prog_name + "/GradeReport_" + sem + year + " _ " + dt_student_detail.Rows[i]["user_id"] + ".pdf", FileMode.Create);
                    FileStream fs = new FileStream(directory_path + dept_name + "/" + prog_name + "/GradeReport_" + sem + year + " _ " + dt_student_detail.Rows[i]["user_id"] + ".pdf", FileMode.Create);
                    fs.Write(obReportPrinter.FileContent, 0, obReportPrinter.FileContent.Length);
                    fs.Dispose();
                }

                //string path = "D:/a/" + dept_name + "/" + prog_name + "/";
                string path = directory_path + dept_name + "/" + prog_name + "/";
                string[] filenames = Directory.GetFiles(path);

                using (ZipFile zip = new ZipFile())
                {
                    //zip.AddFiles(filenames, "files");
                    zip.AddFiles(filenames, "GradeReport" + sem + year + "_" + dept_name + "_" + prog_name + ".zip");
                    //zip.Save("D:/a/" + dept_name + "/" + prog_name + "/DemoZip.zip");
                    zip.Save(directory_path + dept_name + "/" + prog_name + "/DemoZip.zip");
                    //path = "D:/a/" + dept_name + "/" + prog_name + "/DemoZip.zip";
                    path = directory_path + dept_name + "/" + prog_name + "/DemoZip.zip";

                    Response.ContentType = "application/zip";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=GradeReport" + sem + year + "_" + dept_name + "_" + prog_name + ".zip");
                    Response.TransmitFile(path);
                }

            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

        //try
        //{
        //    ReportPrinter[] obReportPrinter = { new ReportPrinter(), new ReportPrinter(), new ReportPrinter() };
        //    JavaScriptSerializer ser = new JavaScriptSerializer();

        //    //Dictionary<string, object> dicParam = ser.Deserialize<Dictionary<string, object>>(hfParameters.Value);

        //    //string appPath = dicParam["appPath"].ToString();
        //    //string appPath = "https://localhost:17757/Pages/MyApplications.aspx";

        //    //string root = "https://localhost:17757/Pages";
        //    //root = "https://localhost:17757/PDF/";
        //    //string url = "CreatePDFPHD.aspx?ReportPDF=1&ProgramType=PTM0003&ProgramFaculty=PFM0001&Course=PCM0018";

        //    //dynamic courseDetail = dicParam["courseDetail"];

        //    //Session["program_course_id"] = courseDetail["program_course_id"].ToString();
        //    //Session["program_faculty_id"] = courseDetail["program_faculty_id"].ToString();
        //    //Session["program_type_id"] = courseDetail["program_type_id"].ToString();
        //    //string userid = Session["UserId"].ToString();
        //    //string application_id = (courseDetail["application_id"] != null && courseDetail["application_id"].ToString() != string.Empty) ? courseDetail["application_id"].ToString() : "";
        //    //string amount = (courseDetail["amount"] != null && courseDetail["amount"].ToString() != string.Empty) ? courseDetail["amount"].ToString() : "";
        //    Dictionary<string, object> sessionData = new Dictionary<string, object>();

        //    foreach (string key in Session.Keys)
        //    {
        //        sessionData[key] = Session[key];
        //    }

        //    for (int i = 0; i < 3; i++)
        //    {
        //        //obReportPrinter.PageFile = root + url + "&session=" + ser.Serialize(sessionData) + "&application_id=" + application_id + "&amount=" + amount + "&user_id=" + userid; // "CreatePDFPG.aspx?ReportPDF=1&session=" + ser.Serialize(sessionData) + "&ProgramType=" + Request.QueryString["ProgramType"] + "&ProgramFaculty=" + Request.QueryString["ProgramFaculty"] + "&Course=" + Request.QueryString["Course"];
        //        obReportPrinter[i].PageFile = "https://localhost:3787/CEPT/Admin/Report/GradeReportPDF2.aspx?uid=UA1413&sem=S&year=2013";
        //        //obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";

        //        obReportPrinter[i].GetPdf();

        //        if (obReportPrinter[i].FileContent != null && obReportPrinter[i].FileContent.Length > 0)
        //        {
        //            HttpContext.Current.Response.ContentType = "application/octet-stream";
        //            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "Application" + i + DateTime.Now.ToString("MM.dd.yyyy HH.mm.ss") + ".pdf"));
        //            HttpContext.Current.Response.BinaryWrite(obReportPrinter[i].FileContent);
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    throw ex;
        //}
    }


    protected void Download_Student_Grade_Report(object sender, EventArgs e)
    {
        try
        {
            //string str_path = HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.Url.Segments[0] + HttpContext.Current.Request.Url.Segments[1] + HttpContext.Current.Request.Url.Segments[2] + HttpContext.Current.Request.Url.Segments[3];

            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object> Filter_criteria = ser.Deserialize<Dictionary<string, object>>(hdn_filter.Value);

            string sem = Filter_criteria["sem_code"].ToString();
            string year = Filter_criteria["year"].ToString();
            string dept_code = Filter_criteria["dept"].ToString();
            string prog_code = Filter_criteria["prog"].ToString();
            string student_code = Filter_criteria["student_code"].ToString();

            Dictionary<string, object> sessionData = new Dictionary<string, object>();
            foreach (string key in Session.Keys)
            {
                sessionData[key] = Session[key];
            }

            ReportPrinter obReportPrinter = new ReportPrinter();

            //obReportPrinter.PageFile = "https://" + str_path + "GradeReportPDF2.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "GradeReportPDF2.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
            //obReportPrinter.PageFile = "https://localhost:57545/CEPT/Admin/Report/GradeReportPDF2.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
            //obReportPrinter.PageFile = "https://registration.cept.ac.in/ceptregtest1/Admin/Report/GradeReportPDF2.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;

            //obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";
            //obReportPrinter.FooterFile = "https://" + str_path + "Footer.html";
            obReportPrinter.FooterFile = Server.MapPath("~/Admin/Report/Footer.html");

            //obReportPrinter.MarginBottom = "0";

            obReportPrinter.GetPdf();

            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "GradeReport_" + sem + year + " _ " + student_code + ".pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    public DataTable get_student_code(string sem, string year, string dept_code, string prog_code)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

        DataTable dt_stud_detail = new DataTable();
        try
        {
            SqlCommand cmd = con.CreateCommand();

            cmd.CommandText = "select distinct um.* from student_course_allocate_dtl as sca" +
                              " inner join user_mst as um on um.user_id=sca.user_id" +
                              " where sca.cancel_flag='N' and sca.semester_type='" + sem + "' and sca.year_semester='" + year + "'" +
                              " and um.cancel_flag='N' and um.user_status_flag='A'" +
                              " and um.dept_code='" + dept_code + "' and um.prog_code='" + prog_code + "'";

            cmd.CommandType = CommandType.Text;

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            dt_stud_detail = new DataTable();

            da.Fill(dt_stud_detail);

            da.Dispose();
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