using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Clearance_Status : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Download_CC(object sender, EventArgs e)
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

                string user_id = hdn_user_id.Value;
                string sem_code = hdn_sem_code.Value;
                string year_code = hdn_year_code.Value;

                ReportPrinter obReportPrinter = new ReportPrinter();

                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Student/DownloadClearanceCertificatePDF.aspx?user_id=" + user_id + "&sem_code=" + sem_code + "&year_code=" + year_code;

                obReportPrinter.MarginBottom = "0";

                obReportPrinter.GetPdf();

                if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                {
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "Clearance_Certificate" + "_" + user_id + "_" + sem_code + "_" + year_code + ".pdf"));
                    HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}