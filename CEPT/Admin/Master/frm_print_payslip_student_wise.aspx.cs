using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;

public partial class Admin_Master_frm_print_payslip_student_wise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Download_ICICI_Payslip(object sender, EventArgs e)
    {
        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            BLL.Master.Masters objmaster = new BLL.Master.Masters();
            int amount = 0;

            Dictionary<string, string> dict_drp_value = ser.Deserialize<Dictionary<string, string>>(hdn_drp_value.Value);

            DataTable user_data = objmaster.Get_ws_instructor_data(dict_drp_value["stud_code"]);

            if (user_data != null)
            {
                string str_path = HttpContext.Current.Request.Url.Authority;

                for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 3); i++)
                {
                    str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
                }

                ReportPrinter obReportPrinter = new ReportPrinter();

                if (Int32.TryParse(dict_drp_value["amount"].ToString(), out amount))
                {
                    obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "student/Fees_installment_pay_in_slip2.aspx?user_id=" + user_data.Rows[0]["user_id"].ToString() + "&user_type=" + user_data.Rows[0]["user_type"].ToString() + "&gender=" + user_data.Rows[0]["gender"].ToString() + "&semester_code=&amount=" + amount;// +user_data.Rows[0]["user_id"].ToString();
                }
                else
                {
                    obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "student/Fees_installment_pay_in_slip2.aspx?user_id=" + user_data.Rows[0]["user_id"].ToString() + "&user_type=" + user_data.Rows[0]["user_type"].ToString() + "&gender=" + user_data.Rows[0]["gender"].ToString() + "&semester_code=";// +user_data.Rows[0]["user_id"].ToString();
                }

                obReportPrinter.MarginTop = "0";
                obReportPrinter.MarginRight = "0";
                obReportPrinter.MarginBottom = "0";
                obReportPrinter.MarginLeft = "0";

                obReportPrinter.PageWidth = 0;
                obReportPrinter.PageHeight = 0;

                obReportPrinter.GetPdf();

                if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                {
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "ICICI_Payslip.pdf"));
                    HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}