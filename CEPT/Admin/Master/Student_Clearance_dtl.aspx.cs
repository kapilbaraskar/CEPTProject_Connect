using BLL.Master;
using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Student_Clearance_dtl : System.Web.UI.Page
{

    Masters masters = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_download_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "")
            {
                string str_path = HttpContext.Current.Request.Url.Authority;

                for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 2); i++)
                {
                    str_path = str_path + HttpContext.Current.Request.Url.Segments[0];
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

    protected void btn_approved_Click(object sender, EventArgs e)
    {
        download_excel();
    }

    protected void btn_pending_Click(object sender, EventArgs e)
    {
        download_excel();
    }

    protected void btn_onhold_Click(object sender, EventArgs e)
    {
        download_excel();
    }

    public void download_excel() 
    {
        try
        {
            DataTable dts = masters.get_student_clearance_form_table_dtl_(hdn_sem_code.Value, hdn_year_code.Value, "");
            if (dts != null)
            {
                //DataTable dt = new DataTable();
                //DataRow workRow;
                //dt.Columns.Add("STUDENT CODE");
                //dt.Columns.Add("STUDENT NAME");
                //dt.Columns.Add("NO OF SESSION ATTENDED");
                //dt.Columns.Add("ATTENDED PERCENTAGE");
                //int i;
                //foreach (DataRow dr in dts.Rows)
                //{
                //    for (i = 0; i < 1; i++)
                //    {
                //        workRow = dt.NewRow();
                //        workRow[0] = dr[1].ToString();
                //        workRow[1] = dr[20].ToString();
                //        workRow[2] = dr[21].ToString();
                //        workRow[3] = dr[22].ToString();
                //        dt.Rows.Add(workRow);
                //    }
                //}

                using (XLWorkbook wb = new XLWorkbook())
                {
                    var ws = wb.Worksheets.Add(dts, "Clearance Status");

                    ws.Tables.FirstOrDefault().ShowAutoFilter = false;
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Course Wise Attendace Report.xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);

                        Response.Flush();
                        Response.End();
                        Response.Close();
                    }
                }
            }

        }
        catch (Exception ex)
        { }

    }
}