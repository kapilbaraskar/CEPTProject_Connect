using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_vertical_studio_preferences : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        try
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "")
            {
                DataTable dt = objmaster.get_parameter_value("vertical_studio_preferences");
                parameter_status.Value = dt.Rows[0]["parameter_value"].ToString();
            }
        }
        catch (Exception)
        {

           // throw;
        } 

    }
   
    protected void Download_OutLine(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "")
            {
                string str_path = HttpContext.Current.Request.Url.Authority;

                for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
                {
                    str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
                }

                string student_code = Session["UserId"].ToString();
                string course_code = hdn_course_code.Value;
                string sem_code = hdn_sem_code.Value;
                string year_code = hdn_year_code.Value;
                ReportPrinter obReportPrinter = new ReportPrinter(); //Outlline - Course_Code - SemYear.pdf
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "OutLinePDF.aspx?course_id=" + course_code + "&sem_code=" + sem_code + "&year_code=" + year_code;

                obReportPrinter.MarginBottom = "0";

                obReportPrinter.GetPdf();

                if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                {
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "Outlline-" + course_code +"-" + sem_code + year_code +".pdf"));
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