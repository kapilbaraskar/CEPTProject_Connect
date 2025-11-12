using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_VF_TA_Authorize : System.Web.UI.Page
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

    protected void Btn_Print_Letter_Click(object sender, EventArgs e)
    {
        try
        {
            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object> sessionData = new Dictionary<string, object>();
            foreach (string key in Session.Keys)
            {
                sessionData[key] = Session[key];
            }

            ReportPrinter obReportPrinter = new ReportPrinter();

            //obReportPrinter.PageFile = "https://" + str_path + "HR_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value;
            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value;

            string directory_path = "C:/Ceptreg_Log/";
            //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "Inside Publish Letter : PagePath : " + obReportPrinter.PageFile + Environment.NewLine);

            //obReportPrinter.HeaderFile = "https://" + str_path + "Header_print_letter.htm";
            obReportPrinter.HeaderFile = Server.MapPath("~/Admin/Master/Header_print_letter.htm");
            //obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";
            //obReportPrinter.FooterFile = "https://" + str_path + "Footer_print_letter.htm";
            obReportPrinter.FooterFile = Server.MapPath("~/Admin/Master/Footer_print_letter.htm");

            obReportPrinter.MarginTop = "11";
            obReportPrinter.MarginBottom = "6";
            obReportPrinter.MarginLeft = "0";
            obReportPrinter.MarginRight = "0";
            obReportPrinter.HeaderHeight = 70;
            obReportPrinter.FooterHeight = 45;

            obReportPrinter.GetPdf();

            //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "Inside Publish Letter : FileContent : " + obReportPrinter.FileContent + Environment.NewLine);

            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "Inside Publish Letter : ContentLength : " + obReportPrinter.FileContent.Length + Environment.NewLine);

                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "" + hdn_instructor_name.Value.Replace(' ', '_') + "_" + hdn_dept.Value + ".pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }

            hdn_instructor.Value = "";

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/InstructorCVUpload/Document.zip");
            Response.ContentType = "application/xls";
            Response.AppendHeader("Content-Disposition", "attachment; filename=Document.zip");
            Response.TransmitFile(path);
            Response.Flush();
            Response.End();
        }
        catch (Exception ex)
        { throw; }
    }
}