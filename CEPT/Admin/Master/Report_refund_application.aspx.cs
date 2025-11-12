using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_refund_application : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Download_Student_RefundForm(object sender, EventArgs e)
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

            //Dictionary<string, object> Filter_criteria = ser.Deserialize<Dictionary<string, object>>(hdn_userid.Value);

            string userid = hdn_userid.Value;
          

            //Dictionary<string, object> sessionData = new Dictionary<string, object>();
            //foreach (string key in Session.Keys)
            //{
            //    sessionData[key] = Session[key];
            //}

            //DataTable dt_student_detail = get_student_code(sem, year, dept_code, prog_code);

            //DataRow[] dr = dt_student_detail.Select("user_id='" + student_code + "'");

            ReportPrinter obReportPrinter = new ReportPrinter();

            //obReportPrinter.PageFile = "https://" + str_path + "RefundformPDF.aspx?userid=" + userid;
            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "RefundformPDF.aspx?userid=" + userid;

            //if (dr.Length > 0)
            //{
            //    int student_year_code = Convert.ToInt32((dr[0]["year_code"].ToString()).Substring(1));
            //    if (student_year_code < 2014)
            //    {
            //        obReportPrinter.FooterFile = "https://" + str_path + "Footer_grade_table.htm";
            //        obReportPrinter.MarginBottom = "13";
            //    }
            //    else
            //    {
            //        obReportPrinter.MarginBottom = "0";
            //    }
            //}

            obReportPrinter.MarginBottom = "0";

            obReportPrinter.GetPdf();

            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "CancleApplication_"+userid+".pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}