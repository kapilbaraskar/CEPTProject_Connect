using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_department_wise_ta_approved : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_user_type.Value = Session["user_type"].ToString();
            if (Session["designation"].ToString() == "TA")
            {
                Response.Redirect("~/Admin/Master/Home.aspx");
            }
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

    protected void hdn_download_Click(object sender, EventArgs e)
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

            ReportPrinter obReportPrinter = new ReportPrinter();

           
            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "CreateInstPDF.aspx?ic=" + userid + "&is=" + hdn_sem_code.Value + "&iy=" + hdn_year_code.Value;


            obReportPrinter.MarginBottom = "0";
            obReportPrinter.MarginLeft = "20";
            obReportPrinter.MarginRight = "20";
            obReportPrinter.MarginTop = "0";
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