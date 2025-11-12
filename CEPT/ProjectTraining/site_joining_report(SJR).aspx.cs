using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using System.Data;
using System.Web.Script.Serialization;


public partial class ProjectTraining_ProjectTraining : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
          Masters objmaster = new Masters();
          string current_project_sem ="";
          string  current_project_year = "";
          DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");
        if (dt_ws_current_sem != null)
        {
          current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
          current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        string user_id= Session["UserId"].ToString();
       DataTable event_mst_data = objmaster.check_proposal_submited(current_project_sem, current_project_year, user_id);
       if (event_mst_data != null)
       {

           if (event_mst_data.Rows.Count > 0)
           {
               DataRow row = event_mst_data.Rows[0];
               string is_approved = row["is_approved"].ToString();
               if (is_approved != "Y")
               {
                   ScriptManager.RegisterStartupScript(this, GetType(), "alert", "  redirect('Your Proposal Has Not Yet Been Accepted'); ", true);
               }
           }

       }

       else {
           ScriptManager.RegisterStartupScript(this, GetType(), "alert", "  redirect('Your Proposal Has Not Yet Been Accepted'); ", true);
       }
      
               
    }

    protected void print_proposal(Object sender, EventArgs e)
    {
        Masters objmaster = new Masters();
        string current_project_sem = "";
        string current_project_year = "";
        
        JavaScriptSerializer ser = new JavaScriptSerializer();
        Dictionary<string, string> data = ser.Deserialize<Dictionary<string, string>>(hdn_data.Value);


        string str_path = HttpContext.Current.Request.Url.Authority;

        for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
        {
            str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
        }


        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");
        if (dt_ws_current_sem != null)
        {
            
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }
        string UserName;
        string stud_cept_email="";
        string c ;
             if (data["user_id"] == "")
             {
                 c = Session["UserId"].ToString();
                 UserName = Session["UserName"].ToString();
                   stud_cept_email = Session["email"].ToString();
             }
             else
             {
                 c = data["user_id"];
                 UserName = data["user_name"];
             }
        ReportPrinter obReportPrinter = new ReportPrinter();
        //obReportPrinter.PageFile = "https://" + str_path + "pdf_SJr.html?UserId=" + c + "&sem_code=" + current_project_sem + "&year_code=" + current_project_year + "&UserName=" + UserName + "&stud_cept_email=" + stud_cept_email;
        obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "pdf_SJr.html?UserId=" + c + "&sem_code=" + current_project_sem + "&year_code=" + current_project_year + "&UserName=" + UserName + "&stud_cept_email=" + stud_cept_email;
        obReportPrinter.MarginBottom = "0";
        obReportPrinter.GetPdf();
        Random rd = new Random();
        int n = rd.Next();
        if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
        {
            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "" + c + " Site Join Report.pdf"));
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