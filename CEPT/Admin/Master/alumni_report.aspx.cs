using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Ionic.Zip;
using System.IO;
using System.Data;
using BLL.Master;

public partial class Admin_Report_alumni_report : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            string directory_path = "C:/Ceptreg_Log/PDF/";

            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            string dept = hdn_drpdepartment.Value;
            string year = hdn_drpenrollmentyear.Value;
            string pro_code = hdn_drpprog.Value;
            string reg = hdn_reg_by.Value;

            DataTable dt_student_detail = objmaster.get_alumni_data_for_report(year, dept, pro_code, reg,"","");

            string delete_path = directory_path;
            string[] delete_filenames = Directory.GetFiles(delete_path);

            for (int i = 0; i < delete_filenames.Length; i++)
            {
                FileInfo file = new FileInfo(delete_filenames[i]);
                file.Delete();
            }

            for (int i = 0; i < dt_student_detail.Rows.Count; i++)
            {
                ReportPrinter obReportPrinter = new ReportPrinter();

                //obReportPrinter.PageFile = "https://" + str_path + "AluminPersonalDetailPDF.aspx?userid=" + dt_student_detail.Rows[i]["user_id"];
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "AluminPersonalDetailPDF.aspx?userid=" + dt_student_detail.Rows[i]["user_id"];

                obReportPrinter.MarginBottom = "0";

                obReportPrinter.GetPdf();

                FileStream fs = new FileStream(directory_path + dt_student_detail.Rows[i]["user_id"] + ".pdf", FileMode.Create);
                fs.Write(obReportPrinter.FileContent, 0, obReportPrinter.FileContent.Length);
                fs.Dispose();
            }

            string path = directory_path;
            string[] filenames = Directory.GetFiles(path);

            using (ZipFile zip = new ZipFile())
            {
                zip.AddFiles(filenames, "Alumni.zip");
                zip.Save(directory_path + "/Demo.zip");
                path = directory_path + "/Demo.zip";

                Response.ContentType = "application/zip";
                Response.AppendHeader("Content-Disposition", "attachment; filename=Alumni.zip");
                Response.TransmitFile(path);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Download_Form(object sender, EventArgs e)
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

            string userid = hdn_userid.Value;

            ReportPrinter obReportPrinter = new ReportPrinter();

            //obReportPrinter.PageFile = "https://" + str_path + "AluminPersonalDetailPDF.aspx?userid=" + userid;
            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "AluminPersonalDetailPDF.aspx?userid=" + userid;

            obReportPrinter.MarginBottom = "0";

            obReportPrinter.GetPdf();

            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", userid + ".pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}