using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_student_medical_fintness_certificate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_type"].ToString() != "S")
        {
            Response.Redirect("~/Student/Dashboard.aspx");
        }
        else
        {
            string student_code = HttpContext.Current.Session["UserId"].ToString();
            hdn_stud_code.Value = student_code;
        }
    }
    protected void btnDownloadCertificate_Click(object sender, EventArgs e) 
    {
        try
        {
            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            

            Dictionary<string, object> sessionData = new Dictionary<string, object>();
            foreach (string key in Session.Keys)
            {
                sessionData[key] = Session[key];
            }

            ReportPrinter obReportPrinter = new ReportPrinter();

            //obReportPrinter.PageFile = "https://" + str_path + "HR_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value;
            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "medical_fitness_certificate.aspx?id=" + hdn_stud_code.Value;

            string directory_path = "C:/Ceptreg_Log/";

            obReportPrinter.HeaderFile = Server.MapPath("~/Admin/Master/Header_print_letter.htm");
            obReportPrinter.MarginTop = "11";
            obReportPrinter.MarginBottom = "6";
            obReportPrinter.MarginLeft = "25";
            obReportPrinter.MarginRight = "10";
            obReportPrinter.HeaderHeight = 8;
            obReportPrinter.FooterHeight = 8;

            obReportPrinter.GetPdf();
            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "Medical Fintness Certificate.pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}