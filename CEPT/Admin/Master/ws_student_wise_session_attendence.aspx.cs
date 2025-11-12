using BLL.Master;
using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_ws_student_wise_session_attendence : System.Web.UI.Page
{
    string course_code = "";
    string year_type = "";
    string semester = "";
    Masters masters = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        course_code = Request.QueryString.Get("c");
        year_type = Request.QueryString.Get("y");
        semester = Request.QueryString.Get("s");
        if (course_code == null && course_code == string.Empty)
        {
            Response.Redirect("~/Admin/Master/Student_wise_enter_attendance.aspx?autho=false");
        }
        else
        {
            hdn_code.Value = course_code;
            hdn_semester.Value = semester;
            hdn_year.Value = year_type;
        }
        JavaScriptSerializer ser = new JavaScriptSerializer();
        Dictionary<string, object> sessionData = new Dictionary<string, object>();
        foreach (string key in Session.Keys)
        {
            sessionData[key] = Session[key];
        }

        hdn_session.Value = ser.Serialize(sessionData);
    }

    protected void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dts = masters.ws_get_session_date_wise_dtl(course_code, semester, year_type);
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

                //dt.Columns.Add("STUDENT_CODE");
                //dt.Columns.Add("SESSION_NAME");
                //dt.Columns.Add("SESSION_DATE");
                //dt.Columns.Add("SESSION_ATTENDED");

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