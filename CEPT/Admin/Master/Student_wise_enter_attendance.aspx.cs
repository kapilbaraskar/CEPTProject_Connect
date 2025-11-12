using BLL.Master;
using BLL.Utilities;
using ClosedXML.Excel;
using Microsoft.Office.Interop.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataTable = System.Data.DataTable;

public partial class Admin_Master_Student_wise_enter_attendance_ : System.Web.UI.Page
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
        if(course_code == null && course_code == string.Empty)
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
            DataTable dts = masters.get_attendance_user_dtl(course_code, semester, year_type);
            if (dts != null)
            {
                DataTable dt = new DataTable();
                DataRow workRow;
                dt.Columns.Add("STUDENT_CODE");
                dt.Columns.Add("NO_OF_SESSION_ATTENDED");
                int i;
                foreach (DataRow dr in dts.Rows)
                {
                    for (i = 0; i < 1; i++)
                    {
                        workRow = dt.NewRow();
                        workRow[0] = dr[1].ToString();
                        dt.Rows.Add(workRow);
                    }
                }

                using (XLWorkbook wb = new XLWorkbook())
                {
                    wb.Worksheets.Add(dt, "Course Wise Attendace");
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