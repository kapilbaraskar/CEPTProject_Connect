using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

using BLL.Utilities;
using BLL.Master;
using System.Data;
using BLL.ExtraUtility;
using XSD.Masters;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Net.Mail;
using System.Data.OleDb;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System.Collections;
using System.Text.RegularExpressions;
using Newtonsoft.Json;
using System.Web.Security;
using iTextSharp.text;
using System.Diagnostics;

public partial class Admin_Report_feedback_faculty_member_report : System.Web.UI.Page
{

    // Master objmaster = new Master();
    BLL.Master.Masters objmaster = new BLL.Master.Masters();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["user_type"].ToString() != "A2")
            {


                if (Session["user_type"].ToString() == "S")
                {
                    Response.Redirect("~/Student/Dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "I")
                {
                    Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "A1" || Session["user_type"].ToString() == "A")
                {
                    Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                }

            }


        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {


        string semester = Request.Form["drpsemester"];

        string year = Request.Form["drpyear"];

        string course_code = Request.Form["drcourses"];

        string course_type = Request.Form["drp_course_type"];

        string dept_code = Request.Form["drpdepartment"];

        DataTable dt_course_data = objmaster.Get_course_data_type_wise(semester, year, course_type, course_code, dept_code);

        DataTable dt_instructor_data = objmaster.Get_all_instructor_code_for_course_code(course_code, semester, year);


        for (int i = 0; i < dt_course_data.Rows.Count; i++)
        {
            course_code = dt_course_data.Rows[i]["course_code"].ToString();

            DataRow[] dr_instructor = dt_instructor_data.Select("course_code = '" + dt_course_data.Rows[i]["course_code"].ToString() + "'");


            //////     JavaScriptSerializer ser = new JavaScriptSerializer();

            //////  //   ReportPrinter 
            //////     Dictionary<string, object> sessionData = new Dictionary<string, object>();

            //////     foreach (string key in Session.Keys)
            //////     {
            //////         sessionData[key] = Session[key];
            //////     }

            //////   //  obReportPrinter.SetSession(ser.Serialize(sessionData));

            for (int j = 0; j < dr_instructor.Length; j++)
            {

                ReportPrinter obReportPrinter = new ReportPrinter();

                obReportPrinter.PageFile = "http://localhost:17675/CEPT/Admin/Master/Download_feedback_PDF.aspx?course_code=" + course_code + "&instructor_code=" + dr_instructor[0]["instructor_code"] + "&semester_type=" + semester + "&year_semester=" + year;

                ////////    obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";
             //   System.Diagnostics.Process.Start("http://localhost:17675/CEPT/Admin/Master/Download_feedback_PDF.aspx?course_code=" + course_code + "&instructor_code=" + dr_instructor[0]["instructor_code"] + "&semester_type=" + semester + "&year_semester=" + year);


               //  Process myProcess = new Process();

                //try
                //{
                //    // true is the default, but it is important not to set it to false
                //    myProcess.StartInfo.UseShellExecute = true;
                //    myProcess.StartInfo.FileName = "http://localhost:17675/CEPT/Admin/Master/Download_feedback_PDF.aspx?course_code=" + course_code + "&instructor_code=" + dr_instructor[0]["instructor_code"] + "&semester_type=" + semester + "&year_semester=" + year;
                //    myProcess.Start();
                //}
                //catch (Exception ex)
                //{
                //    Console.WriteLine(ex.Message);
                //}
                
                //obReportPrinter.GetPdf();

                ////FileStream fs = new FileStream("D:/a/" + dept_name + "/" + dept_code + "/GradeReport_" + sem + year + " _ " + dt_student_detail.Rows[i]["user_id"] + ".pdf", FileMode.Create);
                //FileStream fs = new FileStream("D:/a/feedbackdemo.pdf", FileMode.Create);
                //fs.Write(obReportPrinter.FileContent, 0, obReportPrinter.FileContent.Length);
                //fs.Dispose();

           
                //URL url = new File("test.html").toURI().toURL();
                //WebClient webClient = new WebClient();
                //HtmlPage page = webClient.getPage(url);

                //OutputStream os = null;
                //try
                //{
                //    os = new FileOutputStream("test.pdf");

                //    ITextRenderer renderer = new ITextRenderer();
                //    renderer.setDocument(page, url.toString());
                //    renderer.layout();
                //    renderer.createPDF(os);
                //}
                //finally
                //    if (os != null) os.close();
                //}


                //if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                //{
                //    HttpContext.Current.Response.ContentType = "application/octet-stream";
                //    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "1004" + "_" + "107" + ".pdf"));
                //}
            }


        }

        string path = "D:/a/";
        string[] filenames = Directory.GetFiles(path);

        //using (ZipFile zip = new ZipFile())
        //{
        //    zip.AddFiles(filenames, "files");
        //    zip.Save("D:/a/" + dept_name + "/" + prog_name + "/DemoZip.zip");
        //    path = "D:/a/" + dept_name + "/" + prog_name + "/DemoZip.zip";

        //    Response.ContentType = "application/zip";
        //    Response.AppendHeader("Content-Disposition", "attachment; filename=GradeReport" + sem + year + "_" + dept_name + "_" + prog_name + ".zip");
        //    Response.TransmitFile(path);
        //}
    }
}