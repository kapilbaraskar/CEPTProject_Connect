using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class Admin_Master_Print_pay_slip_by_admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Download_ICICI_Payslip(object sender, EventArgs e)
    {
        try
        {
            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string,string> dict_drp_value = ser.Deserialize<Dictionary<string,string>>(hdn_drp_value.Value);

            ReportPrinter obReportPrinter = new ReportPrinter();

            //obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Fees_installment_pay_in_slip_admin.aspx?semester=" + dict_drp_value["semester"].ToString() + "&year_code=" + dict_drp_value["year_code"].ToString() + "&installment_no=" + dict_drp_value["installment_no"].ToString();
            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Print_fees_installment_pay_in_slip_admin.aspx?semester=" + dict_drp_value["semester"].ToString() + "&year_code=" + dict_drp_value["year_code"].ToString() + "&installment_no=" + dict_drp_value["installment_no"].ToString();

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
        catch (Exception ex)
        {
            throw ex;
        }
    }
}