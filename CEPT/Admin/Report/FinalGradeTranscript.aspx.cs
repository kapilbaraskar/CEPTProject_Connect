using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Ionic.Zip;

public partial class Admin_Report_FinalGradeTranscript: System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["user_type"].ToString() == "S")
            {
                Response.Redirect("~/Student/Dashboard.aspx");
            }
        }
    }


    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string directory_path = "C:/Ceptreg_Log/Grade_Report_Final/";

    //        string str_path = HttpContext.Current.Request.Url.Authority;

    //        for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
    //        {
    //            str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
    //        }

    //        JavaScriptSerializer ser = new JavaScriptSerializer();

    //        Dictionary<string, object> Filter_criteria = ser.Deserialize<Dictionary<string, object>>(hdn_filter.Value);

    //        string sem = Filter_criteria["sem_code"].ToString();
    //        string year = Filter_criteria["year"].ToString();
    //        string dept_code = Filter_criteria["dept"].ToString();
    //        string prog_code = Filter_criteria["prog"].ToString();

    //        string dept_name = "Other";
    //        string prog_name = "UG";

    //        DataTable dt_student_detail = get_student_code(sem, year, dept_code, prog_code);

    //        Dictionary<string, object> sessionData = new Dictionary<string, object>();
    //        foreach (string key in Session.Keys)
    //        {
    //            sessionData[key] = Session[key];
    //        }

    //        if (dt_student_detail.Rows.Count > 0)
    //        {
    //            switch (dept_code)
    //            {
    //                case "1":
    //                    dept_name = "Architecture";
    //                    break;
    //                case "2":
    //                    dept_name = "Design";
    //                    break;
    //                case "3":
    //                    dept_name = "Management";
    //                    break;
    //                case "4":
    //                    dept_name = "Planning";
    //                    break;
    //                case "5":
    //                    dept_name = "Technology";
    //                    break;
    //            }
    //            switch (prog_code)
    //            {
    //                case "1":
    //                    prog_name = "UG";
    //                    break;
    //                case "2":
    //                    prog_name = "PG";
    //                    break;
    //                case "3":
    //                    prog_name = "Doctoral";
    //                    break;
    //            }

    //            string delete_path = directory_path + dept_name + "/" + prog_name + "/";
    //            string[] delete_filenames = Directory.GetFiles(delete_path);

    //            for (int i = 0; i < delete_filenames.Length; i++)
    //            {
    //                FileInfo file = new FileInfo(delete_filenames[i]);
    //                file.Delete();
    //            }

    //            for (int i = 0; i < dt_student_detail.Rows.Count; i++)
    //            {
    //                ReportPrinter obReportPrinter = new ReportPrinter();

    //                obReportPrinter.PageFile = "https://" + str_path + "GradeTranscriptPDF.aspx?uid=" + dt_student_detail.Rows[i]["user_id"] + "&sem=" + sem + "&year=" + year;

    //                //obReportPrinter.FooterFile = "https://" + str_path + "Footer.html";

    //                //int student_year_code = Convert.ToInt32((dt_student_detail.Rows[i]["year_code"].ToString()).Substring(1));
    //                //if (student_year_code < 2014)
    //                //{
    //                //    obReportPrinter.FooterFile = "https://" + str_path + "Footer_grade_table.htm";
    //                //    obReportPrinter.MarginBottom = "13";
    //                //}
    //                //else
    //                //{
    //                //    obReportPrinter.MarginBottom = "0";
    //                //}

    //                obReportPrinter.MarginTop = "2";
    //                obReportPrinter.MarginBottom = "0";

    //                obReportPrinter.GetPdf();

    //                FileStream fs = new FileStream(directory_path + dept_name + "/" + prog_name + "/Transcript_" + dt_student_detail.Rows[i]["user_id"] + ".pdf", FileMode.Create);
    //                fs.Write(obReportPrinter.FileContent, 0, obReportPrinter.FileContent.Length);
    //                fs.Dispose();
    //            }

    //            string path = directory_path + dept_name + "/" + prog_name + "/";
    //            string[] filenames = Directory.GetFiles(path);

    //            using (ZipFile zip = new ZipFile())
    //            {
    //                zip.AddFiles(filenames, "GradeReport" + sem + year + "_" + dept_name + "_" + prog_name + ".zip");
    //                zip.Save(directory_path + dept_name + "/" + prog_name + "/DemoZip.zip");
    //                path = directory_path + dept_name + "/" + prog_name + "/DemoZip.zip";

    //                Response.ContentType = "application/zip";
    //                Response.AppendHeader("Content-Disposition", "attachment; filename=GradeReport" + sem + year + "_" + dept_name + "_" + prog_name + ".zip");
    //                Response.TransmitFile(path);
    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}


    protected void Download_Student_Grade_Report(object sender, EventArgs e)
    {
        try
        {
            Application["Name"] = "Page Name";
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
            string directory_path = "C:/Ceptreg_Log/";

            string status = hdn_check.Value;

            if (status == "false")
            {
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "FinalTranscript.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year + "&new_tab=" + 'N';
               //obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "ProvisionalTranscript.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year + "&new_tab=" + 'N';
                obReportPrinter.Orientation = SelectPdf.PdfPageOrientation.Portrait;
                obReportPrinter.PaperSize = SelectPdf.PdfPageSize.A4;
                //obReportPrinter.FooterFile = Server.MapPath("~/Admin/Report/Footer.html");
                //obReportPrinter.FooterLine = "Note :  This is an electronically generated report and does not require an authorised signature.";


            }
            else 
            {
                if (prog_code == "1")
                {
                    //obReportPrinter.PageFile = "https://" + str_path + "GradeTranscriptPDF_UG.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
                    //obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "GradeTranscriptPDF_UG.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
                    obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "GradeTranscriptPDF_UG_10sem.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year + "&new_tab=" + 'N';
                    //obReportPrinter.Orientation = WkHtmlToXSharp.PdfOrientation.Landscape;
                    obReportPrinter.Orientation = SelectPdf.PdfPageOrientation.Landscape;
                    obReportPrinter.PaperSize = SelectPdf.PdfPageSize.Letter;
                    
                }
                else
                {
                    //obReportPrinter.PageFile = "https://" + str_path + "GradeTranscriptPDF.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
                    //obReportPrinter.PageFile = "https://" + str_path + "GradeTranscriptPDF_PG.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
                    obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "GradeTranscriptPDF_PG.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year + "&new_tab=" + 'N';
                    //obReportPrinter.Orientation = WkHtmlToXSharp.PdfOrientation.Landscape;
                    obReportPrinter.Orientation = SelectPdf.PdfPageOrientation.Landscape;
                }
            }

            //obReportPrinter.PageWidth = 1450;
            //obReportPrinter.MarginTop = "6";
            //obReportPrinter.MarginBottom = "0";
            //obReportPrinter.MarginLeft = "0";
            //obReportPrinter.MarginRight = "0";

            //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "1. Before GetPdf Transcript : FileContent : " + obReportPrinter.FileContent + Environment.NewLine);

            if (status == "true")
            {
                obReportPrinter.PageWidth = 1450;
                obReportPrinter.MarginTop = "6";
                obReportPrinter.MarginBottom = "0";
                obReportPrinter.MarginLeft = "0";
                obReportPrinter.MarginRight = "0";
            }
            else
            {
                obReportPrinter.MarginTop = "36";
                obReportPrinter.MarginBottom = "1";
                obReportPrinter.MarginLeft = "1.27";
                obReportPrinter.MarginRight = "1";
            }

            obReportPrinter.GetPdf();
            
            //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "After GetPdf Transcript : FileContent : " + obReportPrinter.FileContent + Environment.NewLine);
            
            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                string fileName = "Transcript_" + student_code + ".pdf";
                string filePath_new = Server.MapPath("~/Transcript/" + student_code + "/");
                if (!Directory.Exists(filePath_new))
                {
                    Directory.CreateDirectory(filePath_new);
                }
                string filePath = Path.Combine(filePath_new, fileName);
                File.WriteAllBytes(filePath, obReportPrinter.FileContent);

                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "Transcript_" + student_code + ".pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    //public DataTable get_student_code(string sem, string year, string dept_code, string prog_code)
    //{
    //    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString());

    //    DataTable dt_stud_detail = new DataTable();
    //    try
    //    {
    //        SqlCommand cmd = con.CreateCommand();

    //        cmd.CommandText = "select distinct um.* from student_course_allocate_dtl as sca" +
    //                          " inner join user_mst as um on um.user_id=sca.user_id" +
    //                          " where sca.cancel_flag='N' and sca.semester_type='" + sem + "' and sca.year_semester='" + year + "'" +
    //                          " and um.cancel_flag='N' and um.user_status_flag='A'" +
    //                          " and um.dept_code='" + dept_code + "' and um.prog_code='" + prog_code + "'";

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

}