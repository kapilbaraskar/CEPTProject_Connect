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



public partial class ProjectTraining_car_report_print : System.Web.UI.Page, System.Web.SessionState.IRequiresSessionState
{
    string PageNumber;
    string user_id ;

    protected void Page_Load(object sender, EventArgs e)
    {
        string json_data_for_timesheet = "";
        string json_data_actual = "";

        
        Masters objmaster = new Masters();

          PageNumber = Request.QueryString["page_number"];
          user_id = Request.QueryString["user_id"];

        string current_project_sem = "";
        string current_project_year = "";
        string date = System.DateTime.Now.GetDateTimeFormats()[7].ToString();
        date_text.InnerText = date;
        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");

        if (dt_ws_current_sem != null)
        {
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }


         
        DataTable timesheet_data = objmaster.get_timesheet_sp_for_report(current_project_sem, current_project_year, user_id, PageNumber);
        DataTable actual_data = objmaster.get_planned_actual_data(current_project_sem, current_project_year, user_id, PageNumber);

        json_data_for_timesheet = GetJson1(timesheet_data);
        json_data_actual = GetJson1(actual_data);


        hdn_actual_data.Value = json_data_actual;
        hdn_timesheet_data.Value = json_data_for_timesheet;
      
  

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