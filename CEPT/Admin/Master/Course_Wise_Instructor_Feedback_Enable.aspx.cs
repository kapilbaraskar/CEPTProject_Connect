using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataTable = System.Data.DataTable;

public partial class Admin_Master_Course_Wise_Instructor_Feedback_Enable: System.Web.UI.Page
{
    WebService webService = new WebService();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    {
        try
        {

            string dts = webService.Get_instrctor_disable_for_feedback(hdn_semester.Value, hdn_year.Value, hdn_code.Value);//masters.get_attendance_user_dtl(course_code, semester, year_type);

            if (dts != "")
            {
                JavaScriptSerializer ser = new JavaScriptSerializer();
                List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(dts);
                DataTable dt = new DataTable();
                DataRow workRow;
                dt.Columns.Add("STUDENT_CODE");
                dt.Columns.Add("STUDENT_NAME");
                for (int k = 1; k <= Convert.ToInt32(data[0]["inst_count"].ToString()); k++)
                {
                    dt.Columns.Add(data[0]["instr_" + k].ToString().Replace("/E","").Replace("/D",""));
                }

                int i;
                int count = 0;
                for (i = 0; i <= data.Count; i++)
                {
                    count = count + 1;
                    workRow = dt.NewRow();
                    workRow[0] = data[i]["user_id"].ToString();
                    workRow[1] = data[i]["full_name"].ToString();
                    for (int u = 1; u <= Convert.ToInt32(data[0]["inst_count"].ToString()); u++)
                    {
                        String Status = data[i]["instr_" + u].ToString().Substring(data[i]["instr_" + u].ToString().Length - 1);
                        if (Status == "E")
                        {
                            workRow[1 + u] = "YES";
                        }
                        else { workRow[1 + u] = "NO"; }

                    }
                    dt.Rows.Add(workRow);
                    
                    if (count == data.Count)
                    {
                        using (XLWorkbook wb = new XLWorkbook())
                        {

                            wb.Worksheets.Add(dt, "FeedBack Instructor Enable");
                            Response.Clear();
                            Response.Buffer = true;
                            Response.Charset = "";
                            Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                            Response.AddHeader("content-disposition", "attachment;filename=FeedBack Instructor Enable.xlsx");
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
               
               
            }

        }
        catch (Exception ex)
        { }


    }
}