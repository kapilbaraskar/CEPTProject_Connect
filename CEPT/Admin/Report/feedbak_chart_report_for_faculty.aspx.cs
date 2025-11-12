using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;
using Newtonsoft.Json;
using XSD.Masters;
using System.Web.Script.Serialization;
using BLL.Utilities;
using System.Web.Services;

public partial class Admin_Report_feedbak_chart_report_for_faculty : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    DS_Feedback_calculation obj_feedback_calculation = new DS_Feedback_calculation();
    string jsondata = "";
    BLReturnObject objBLReturnObject = new BLReturnObject();
    string feedback_year = "2015";

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Request.QueryString["user_id"] != null && Request.QueryString["course_code"] != null && Request.QueryString["sem_code"] != null && Request.QueryString["year_code"] != null)
        //{
        //   // string result = print_faculty_report_latest(Request.QueryString["year_code"].ToString(), Request.QueryString["sem_code"].ToString(), "", Request.QueryString["course_code"].ToString(), "", Request.QueryString["user_id"].ToString());

        //  //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "mess", "generatechart('" + result + "');", true);

        //  //  return;
        //}
        //else
        //{
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mess", "alert('Some problem in feeedback report');", true);
        //    return;
        //}
    }

    [System.Web.Services.WebMethod]
    public static string GetCurrentTime(string name)
    {

      
        return "Hello " + name + Environment.NewLine + "The Current Time is: "
            + DateTime.Now.ToString();
    }

    [WebMethod]
    public static string print_faculty_report_latest_new(string year_code, string sem_code, string course_type, string course_code, string dept_code, string selected_instructor)
    {
        return "Hello";
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