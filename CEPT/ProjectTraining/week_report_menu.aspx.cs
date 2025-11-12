using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using BLL.Master;
using iTextSharp.text.pdf;
using iTextSharp.text;
using BLL.Utilities;
using System.Web.Script.Serialization;

public partial class ProjectTraining_week_report_pdf : System.Web.UI.Page
{
    string PageNumber;
    string user_id;
    string jsondata = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Masters objmaster = new Masters();
      
          
          //user_id = "UC5211";
    }

    //protected void Page_preinit(object sender, EventArgs e)
    //{
    //    this.MasterPageFile = "";

    //    //user_id = "UC5211";
    //}


    protected void print_timesheet(Object sender, EventArgs e)
    {
        PageNumber = hdn_data.Value;

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
        //obReportPrinter.PageFile = "https://" + str_path + "week_reoprt_pdf.aspx?user_id=" + UserId + "&PageNumber=" + PageNumber;
        obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "week_reoprt_pdf.aspx?user_id=" + UserId + "&PageNumber=" + PageNumber;
        obReportPrinter.MarginBottom = "0";
        obReportPrinter.GetPdf();
        Random rd = new Random();
        int n = rd.Next();

        if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
        {

            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "weekly_timesheet_NO="+PageNumber+".pdf"));
            HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
        }


    }

    public string GetJson1(DataTable dt)
    {

        JavaScriptSerializer ser = new JavaScriptSerializer();
        ser.MaxJsonLength = Int32.MaxValue;
        List<Dictionary<string, string>> dataRows = new List<Dictionary<string, string>>(); // will contain datarows as dictionary objects

        //Convert DataTable to List<Dictionary<string, string>> data structure
        foreach (DataRow VDataRow in dt.Rows)
        {
            var Row = new Dictionary<string, string>(); // DataRow as key-value pairs where key=columnName and value=fieldValue 
            foreach (DataColumn Column in dt.Columns)
            {

                Row.Add(Column.ColumnName, VDataRow[Column].ToString());

            }
            dataRows.Add(Row);
        }
        return ser.Serialize(dataRows); // convert list to JSON string 

    }
}