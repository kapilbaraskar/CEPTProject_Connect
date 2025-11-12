using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Course_Information : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_utype.Value = Session["user_type"].ToString();

            if (Session["user_type"].ToString() != "A")
            {
                if (Session["user_type"].ToString() == "S")
                {
                    Response.Redirect("~/Student/Dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "I")
                {
                    Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                }
            }
        }
    }

    protected void Download_OutLine(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "")
            {
                string str_path = HttpContext.Current.Request.Url.Authority;

                for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 3); i++)
                {
                    str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
                }

                string student_code = Session["UserId"].ToString();
                string course_code = hdn_course_code.Value;
                string sem_code = hdn_sem_code.Value;
                string year_code = hdn_year_code.Value;

                ReportPrinter obReportPrinter = new ReportPrinter();

                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Student/OutLinePDF.aspx?course_id=" + course_code + "&sem_code=" + sem_code + "&year_code=" + year_code;

                obReportPrinter.MarginBottom = "0";

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

    //protected void Download_All_OutLine(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        if (Session["UserId"] != null && Session["UserId"].ToString() != "")
    //        {
    //            string str_path = HttpContext.Current.Request.Url.Authority;

    //            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 3); i++)
    //            {
    //                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
    //            }

    //            string student_code = Session["UserId"].ToString();
    //            string course_code = hdn_all_course_code.Value;
    //            string sem_code = hdn_sem_code.Value;
    //            string year_code = hdn_year_code.Value;

    //            ReportPrinter obReportPrinter = new ReportPrinter();

    //            //obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Student/OutLinePDF.aspx?course_id=" + course_code + "&sem_code=" + sem_code + "&year_code=" + year_code;
    //            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Student/Outlinepdfdownload.aspx?course_id=" + course_code + "&sem_code=" + sem_code + "&year_code=" + year_code;

    //            obReportPrinter.MarginBottom = "0";

    //            obReportPrinter.GetPdf();

    //            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
    //            {
    //                HttpContext.Current.Response.ContentType = "application/octet-stream";
    //                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "OutLine" + student_code + ".pdf"));
    //                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

}