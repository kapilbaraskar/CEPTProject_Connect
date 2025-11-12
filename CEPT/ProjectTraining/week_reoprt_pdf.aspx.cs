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
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;


public partial class ProjectTraining_week_reoprt_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
           Masters objmaster = new Masters();
        string PageNumber=Request.QueryString["PageNumber"];
        string user_id = Request.QueryString["user_id"];
        //string PageNumber = "1";
        //string user_id = "UC5211";
        string jsondata = "";
        Dictionary<string, string> user_details = new Dictionary<string, string>();

        string current_project_sem = "";
        string current_project_year = "";
        string current_project_sem_desc = "";
        DataTable user_data = objmaster.userMaster(user_id);
      
        

        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");

        if (dt_ws_current_sem != null)
        {
            current_project_sem_desc = dt_ws_current_sem.Rows[0]["sem_desc"].ToString();
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
            string year = current_project_year;
            string sem = current_project_sem;
            user_details.Add("user_name", user_data.Rows[0]["user_name"].ToString());
            user_details.Add("sem_code", current_project_sem_desc);
            user_details.Add("year_code", current_project_year);
            //user_details.Add("mail", user_data.Rows[0]["mail"].ToString());
            user_details.Add("user_id", user_data.Rows[0]["user_id"].ToString());
        }

        DataTable sjr_data = objmaster.Get_site_join_report(current_project_sem, current_project_year, user_id);

        user_details.Add("mail", sjr_data.Rows[0]["project_name"].ToString());

        user_details.Add("address", sjr_data.Rows[0]["address_from_communication"].ToString());

        DataTable week_data = objmaster.get_time_sheet_one_week(current_project_sem, current_project_year, user_id, PageNumber);

        jsondata = GetJson1(week_data);

        hdn_data.Value = jsondata;

        string json = JsonConvert.SerializeObject(user_details, Formatting.Indented);
        year_sem.Value = json;

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
