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

using Ionic.Zip;

using BLL.Master;
using System.Data;
using iTextSharp.text.pdf;
using iTextSharp.text;
using BLL.Utilities;


public partial class ProjectTraining_ProjectTraining : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

      
    }
    protected void print_proposal(Object sender, EventArgs e)
    {
        ServerLog.Log("start Printing");

        string str_path = HttpContext.Current.Request.Url.Authority;

        for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
        {
            str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
        }

        Masters objmaster = new Masters();

        string current_project_sem = "";
        string current_project_year = "";

        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");

        if (dt_ws_current_sem != null)
        {
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        string a = current_project_sem;
        string b = current_project_year;
        string UserId = Session["UserId"].ToString();
        string UserName = Session["UserName"].ToString();
        ReportPrinter obReportPrinter = new ReportPrinter();
        //obReportPrinter.PageFile = "https://" + str_path + "ProposalProject_pdf.aspx?UserId=" + UserId + "&sem_code=" + current_project_sem + "&year_code=" + current_project_year + "&UserName=" + UserName;
        obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "ProposalProject_pdf.aspx?UserId=" + UserId + "&sem_code=" + current_project_sem + "&year_code=" + current_project_year + "&UserName=" + UserName;
        obReportPrinter.MarginBottom = "0";
        obReportPrinter.GetPdf();
        Random rd = new Random();
        int n = rd.Next();

        if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length >0)
        {
            
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "Project_proposal_.pdf"));
            HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
        }


    }

}