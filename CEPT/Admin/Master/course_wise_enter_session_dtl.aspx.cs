using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_course_wise_enter_session_dtl : System.Web.UI.Page
{
    string course_code = "";
    string year_type = "";
    string semester = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        course_code = Request.QueryString.Get("c");
        year_type = Request.QueryString.Get("y");
        semester = Request.QueryString.Get("s");
        if (course_code == null && course_code == string.Empty)
        {
            Response.Redirect("~/Admin/Master/course_wise_enter_session_dtl.aspx?autho=false");
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

            string path = Server.MapPath("~/ExcelFormatFiles/Date_Wise_Session.xlsx");
            if (File.Exists(path))
            {
                string filename = "Date_Wise_Session.xlsx";
                string ext = Path.GetExtension(path).Replace(".", "");
                Response.ContentType = "application/" + ext + "";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename);
                Response.TransmitFile(path);
                Response.Flush();
                Response.End();
            }

        }
        catch (Exception ex)
        {
            //    throw;
        }

    }
}