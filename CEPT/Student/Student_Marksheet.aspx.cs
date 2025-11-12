using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using BLL.Master;
using System.IO;

public partial class Student_student_marksheet : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_year_code_foundation.Value = Session["year_code"].ToString();

        if (Session["user_dept"].ToString() == "F")
        {
            //   if (HttpContext.Current.Session["prog_level_code"].ToString() == "PD22222")
            // {
            if (Session["year_code"].ToString() == "Y2016")
            {
                Response.Redirect("~/student/Fees_dashboard.aspx", false);
            }

            //}

        }

    }

    protected void Download_Student_Grade_Report(object sender, EventArgs e)
    {
        try
        {
            string str_path = "";
            if (HttpContext.Current.Request.Url.Segments.Length == 3)
            {
                str_path = HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.Url.Segments[0] + "Admin/Report/";
            }
            else if (HttpContext.Current.Request.Url.Segments.Length == 4)
            {
                str_path = HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.Url.Segments[0] + HttpContext.Current.Request.Url.Segments[1] + "Admin/Report/";
            }



            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object> Filter_criteria = ser.Deserialize<Dictionary<string, object>>(hdn_filter.Value);

            string sem = Filter_criteria["sem_code"].ToString();
            string year = Filter_criteria["year"].ToString();
            //string student_code = Filter_criteria["student_code"].ToString();
            string student_code = HttpContext.Current.Session["UserId"].ToString();
            
            DataTable dt_blocklist_marksheet = objmaster.student_marksheet_blocklist_fees_not_paid(sem, year, student_code);

            if (dt_blocklist_marksheet == null)
            {
                Dictionary<string, object> sessionData = new Dictionary<string, object>();
                foreach (string key in Session.Keys)
                {
                    sessionData[key] = Session[key];
                }

                ReportPrinter obReportPrinter = new ReportPrinter();

                //obReportPrinter.PageFile = "https://" + str_path + "GradeReportPDF2.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year;
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "GradeReportPDF2.aspx?uid=" + student_code + "&sem=" + sem + "&year=" + year + "&type=S";
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
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /*Start - Mayur 21/09/2018*/
    protected void Download_OutLine(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "")
            {
                string str_path = HttpContext.Current.Request.Url.Authority;

                for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 2); i++)
                {
                    str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
                }

                string student_code = Session["UserId"].ToString();
                string course_code = hdn_course_code.Value;
                string sem_code = hdn_sem_code.Value;
                string year_code = hdn_year_code.Value;

                ReportPrinter obReportPrinter = new ReportPrinter();

                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Student/OutLinePDF.aspx?course_id=" + course_code + "&sem_code=" + sem_code + "&year_code=" + year_code;

                obReportPrinter.MarginBottom = "20";

                obReportPrinter.GetPdf();

                if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                {
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "OutLine" + student_code + ".pdf"));
                    HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /*End - Mayur 21/09/2018*/

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    //if (Request["export"] == "pdf")
    //    //{
    //        var strWr = new StringWriter();
    //        var htmlWr = new HtmlTextWriter(strWr);
    //        //base.Render(htmlWr);
    //        var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
    //        Response.ContentType = "application/pdf";
    //        htmlToPdf.GeneratePdf(strWr.ToString(), null, Response.OutputStream);
    //        Response.End();
    //    //}
    //}
}