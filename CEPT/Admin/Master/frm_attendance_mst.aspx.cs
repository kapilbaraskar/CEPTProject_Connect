using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using Microsoft.Reporting.WebForms;
using System.Data;

using BLL.Master;

public partial class Admin_Master_frm_attendance_mst : System.Web.UI.Page
{
    //private ReportDataSource[] ReportDataSourceArray;
    //private ReportParameter[] ReportParameterArray;

    //Masters obj = new Masters();
    protected override void OnInit(EventArgs e)
    {
       // HiddenField hdn = (HiddenField)Master.FindControl("hdnuserid");
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            //string k = null;

            //if (string.IsNullOrEmpty(k))
            //{

            //}

            //string a = Convert.ToString(k);

            //string b = k.ToString();

            //int i = 0;

            // a = Convert.ToString(i);

            // b = i.ToString();

            string str1="9009";
            string str2=null;
            string str3="9009.9090800";
            string str4="90909809099090909900900909090909"; 
            int finalResult;
            bool output;
            output = int.TryParse(str1,out finalResult); // 9009
            output = int.TryParse(str2,out finalResult); // 0
            output = int.TryParse(str3,out finalResult); // 0
            output = int.TryParse(str4, out finalResult); // 0 
        }
        catch (Exception ex)
        {


        }

        //DataTable dt1 = obj.Get_area_data();

        //ReportDataSource datasource1 = new ReportDataSource("DataSet1", dt1);
       
        //ReportViewer1.LocalReport.DataSources.Clear();
        //ReportViewer1.LocalReport.DataSources.Add(datasource1);
    
        //ReportViewer1.LocalReport.Refresh();
    
        //  Timer1.Interval = 10000;

    }
    //protected void Timer1_Tick(object sender, EventArgs e)
    //{
    //    lbl_time.Text = DateTime.Now.ToString("hh:mm tt");
    //}
}