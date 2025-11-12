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

public partial class Admin_Report_course_wise_attendance_dtl : System.Web.UI.Page
{
    string course_code = "";
    string year_type = "";
    string semester = "";
    Masters masters = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        course_code = hdn_code.Value;
        year_type = hdn_year.Value;
        semester = hdn_semester.Value;
    }

    protected void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dts = masters.get_attendance_user_dtl(course_code, semester, year_type);
            if (dts != null)
            {
                DataTable dt = new DataTable();
                DataRow workRow;
                dt.Columns.Add("STUDENT CODE");
                dt.Columns.Add("STUDENT NAME");
                dt.Columns.Add("NO OF SESSION ATTENDED");
                dt.Columns.Add("ATTENDED PERCENTAGE");
                int i;
                foreach (DataRow dr in dts.Rows)
                {
                    for (i = 0; i < 1; i++)
                    {
                        workRow = dt.NewRow();
                        workRow[0] = dr[1].ToString();
                        workRow[1] = dr[20].ToString();
                        workRow[2] = dr[21].ToString();
                        workRow[3] = dr[22].ToString();
                        dt.Rows.Add(workRow);
                    }
                }

                using (XLWorkbook wb = new XLWorkbook())
                {
                    var ws = wb.Worksheets.Add(dt, "Course Wise Attendace Report");

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

    protected void btndownloadattendancestatus_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dts = masters.get_session_date_wise_dtl(course_code, semester, year_type);
            if (dts != null)
            {
                DataTable dt = new DataTable();
                DataRow workRow;

                foreach (DataColumn column in dts.Columns)
                {
                    dt.Columns.Add(column.ColumnName);


                }
                //Remove Column 
                dt.Columns.RemoveAt(0);
                dt.Columns.RemoveAt(0);
                dt.Columns.RemoveAt(0);
                dt.Columns.RemoveAt(0);

                dts.Columns.RemoveAt(0);
                dts.Columns.RemoveAt(0);
                dts.Columns.RemoveAt(0);
                dts.Columns.RemoveAt(0);
                dt.Columns["sca_user_id"].ColumnName = "Student_code";

                int i;
                foreach (DataRow dr in dts.Rows)
                {
                    for (i = 0; i < 1; i++)
                    {

                        workRow = dt.NewRow();
                        for (int k = 0; k < dts.Columns.Count; k++)
                        {
                            workRow[k] = dr[k].ToString();
                        }
                        dt.Rows.Add(workRow);
                    }
                }

                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt, "Session Wise Attendace");
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Course Wise Attendace.xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);
                        Response.Flush();
                        Response.End();
                    }
                }
            }

        }
        catch (Exception ex)
        { }
    }
}