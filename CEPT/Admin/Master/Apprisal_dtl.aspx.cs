using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.IO;

public partial class Admin_Master_Apprisal_dtl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }
    
    protected void btndownloadpdf_Click(object sender, EventArgs e)
    {
        try
        {
            //string str_path = HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.Url.Segments[0] + HttpContext.Current.Request.Url.Segments[1] + HttpContext.Current.Request.Url.Segments[2] + HttpContext.Current.Request.Url.Segments[3];
           
            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            string userid = hdn_user_id.Value;
            string path = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Apprisal_pdf.aspx?c=" + hdn_user_id.Value + "&y=" + hdn_year.Value + "&u=" + Session["user_type"].ToString() + "&w=c";
            GeneratePdfFromUrl(path, userid, hdn_year.Value);

            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "HideLoader", "<script>hideLoader();</script>;", false);

            //ReportPrinter obReportPrinter = new ReportPrinter();
            //obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Apprisal_pdf.aspx?c=" + hdn_user_id.Value + "&y=" + hdn_year.Value + "&u=" + Session["user_type"].ToString() + "&w=c";
            //
            //obReportPrinter.HeaderFile = Server.MapPath("~/Admin/Master/Header_print_letter.htm");
            //obReportPrinter.MarginBottom = "25";
            //obReportPrinter.MarginLeft = "20";
            //obReportPrinter.MarginRight = "20";
            //obReportPrinter.MarginTop = "20";
            //obReportPrinter.HeaderHeight = 0;
            //obReportPrinter.FooterHeight = 0;
            //obReportPrinter.GetPdf();
            //
            //if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            //{
            //    HttpContext.Current.Response.ContentType = "application/octet-stream";
            //    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", userid + ".pdf"));
            //    HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            //}
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "ScriptManager1", "hideLoader();", true);
            throw ex;
        }
    }

    public void btndownloadpdf_without_Click(object sender, EventArgs e)
    {
        try
        {
            //string str_path = HttpContext.Current.Request.Url.Authority + HttpContext.Current.Request.Url.Segments[0] + HttpContext.Current.Request.Url.Segments[1] + HttpContext.Current.Request.Url.Segments[2] + HttpContext.Current.Request.Url.Segments[3];

            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            string userid = hdn_user_id.Value;

            string path = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Apprisal_pdf.aspx?c=" + hdn_user_id.Value + "&y=" + hdn_year.Value + "&u=" + Session["user_type"].ToString() + "&w=w";
            GeneratePdfFromUrl(path, userid, hdn_year.Value);
            
           
           


            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), "ScriptManager1", "hideLoader();", true);
            //ReportPrinter obReportPrinter = new ReportPrinter();
            //obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Apprisal_pdf.aspx?c=" + hdn_user_id.Value + "&y=" + hdn_year.Value + "&u=" + Session["user_type"].ToString() + "&w=w";
            //obReportPrinter.HeaderFile = Server.MapPath("~/Admin/Master/Header_print_letter.htm");
            //obReportPrinter.MarginBottom = "25";
            //obReportPrinter.MarginLeft = "20";
            //obReportPrinter.MarginRight = "20";
            //obReportPrinter.MarginTop = "20";
            //obReportPrinter.HeaderHeight = 0;
            //obReportPrinter.FooterHeight = 0;
            //obReportPrinter.GetPdf();
            //
            //if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            //{
            //    HttpContext.Current.Response.ContentType = "application/octet-stream";
            //    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", userid + ".pdf"));
            //    HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            //}
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "HideLoader", "hideLoader();", true);
            
            throw ex;
        }
        
    }

    public void GeneratePdfFromUrl(string path, string Userid, string year)
    {
        try
        {
        string url = path;
        string outputFilePath = HttpContext.Current.Server.MapPath("~/GeneratedPdfs/" + year + "_" + Userid + ".pdf");
        string outputDirectory = Path.GetDirectoryName(outputFilePath);
        if (!Directory.Exists(outputDirectory))
        {
            Directory.CreateDirectory(outputDirectory);
        }

        ConvertHtmlToPdf(url, outputFilePath);

            // Return the PDF as a download
         ServePdfFile(outputFilePath, Userid);
        //HttpContext.Current.Response.ContentType = "application/pdf";
        //HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", Userid + "SelfEvaluation.pdf"));
        //HttpContext.Current.Response.WriteFile(outputFilePath);
        //HttpContext.Current.Response.End();
        }
        catch (Exception ex)
        {

            throw;
        }
    }
    public static void ConvertHtmlToPdf(string url, string outputFilePath)
    {
        string wkhtmlPath = HttpContext.Current.Server.MapPath("~/bin/wkhtmltopdf.exe");
        // string arguments = String.Format("--margin-top 16mm --margin-bottom 21mm --margin-left 16mm --margin-right 21mm \"{0}\" \"{1}\"", url, outputFilePath);
        // string arguments = String.Format("--margin-top 0.63in --margin-bottom 0.83in --margin-left 0.60in --margin-right 0.80in \"{0}\" \"{1}\"", url, outputFilePath);

        string arguments = String.Format("--page-size A4 --margin-top 16mm --margin-bottom 21mm --margin-left 16mm --margin-right 21mm \"{0}\" \"{1}\"", url, outputFilePath);
        //string arguments = String.Format("--page-width 8.5in --page-height 11in --margin-top 0.63in --margin-bottom 0.83in --margin-left 0.3in --margin-right 0.83in \"{0}\" \"{1}\"", url, outputFilePath);

        var processStartInfo = new ProcessStartInfo
        {
            FileName = wkhtmlPath,
            Arguments = arguments,
            UseShellExecute = false,
            RedirectStandardOutput = true,
            RedirectStandardError = true,
            CreateNoWindow = true
            
        };
        try
        {
            using (var process = new Process())
            {
                process.StartInfo = processStartInfo;
                process.Start();

                // Read the output and error for debugging purposes
                string output = process.StandardOutput.ReadToEnd();
                string error = process.StandardError.ReadToEnd();

                process.WaitForExit();

                // Log the output and error for debugging
                Console.WriteLine("wkhtmltopdf Output: " + output);
                Console.WriteLine("wkhtmltopdf Error: " + error);

                if (process.ExitCode != 0)
                {
                    // Log the detailed error
                    Console.WriteLine("Command Line: " + processStartInfo.FileName + " " + arguments);
                    throw new Exception("wkhtmltopdf conversion failed: " + error);
                }
                else
                {
                    Console.WriteLine("PDF generated successfully at: " + outputFilePath);
                }
            }
        }
        catch (Exception ex)
        {
            // Log the detailed exception message
            Console.WriteLine("An error occurred: " + ex.Message);
            // Include stack trace or additional logging if necessary
        }

    }

    private void ServePdfFile(string filePath, string Userid)
    {
        HttpContext.Current.Response.ContentType = "application/pdf";
        HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", Userid + "_SelfEvaluation.pdf"));
        HttpContext.Current.Response.TransmitFile(filePath);
        HttpContext.Current.Response.Flush();
        HttpContext.Current.ApplicationInstance.CompleteRequest();
    }
}