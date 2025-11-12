using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using BLL.Master;
public partial class Student_Fees_payment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Redirect("~/Student/Dashboard.aspx?fees=c");
        if (Session["UserId"] != null)
        {
            hdn_user_id.Value = Session["UserId"].ToString();
        }

        Masters objmaster = new Masters();
        DataTable dt_cur_sem = new DataTable();

        DataTable dt_foundation_fees_sem_dtl_user = objmaster.Get_fees_sem_dtl_of_foundation_student(Session["UserId"].ToString());
        
        if (dt_foundation_fees_sem_dtl_user != null)
        {
            if (dt_foundation_fees_sem_dtl_user.Rows[0]["cur_foundation_sem"].ToString() == "1")
            {
                dt_cur_sem = objmaster.Get_cept_current_sem_data("CFP 1st Sem Fees");
                hdn_fond.Value = "Y";
            }
            else if (dt_foundation_fees_sem_dtl_user.Rows[0]["cur_foundation_sem"].ToString() == "2")
            {
                dt_cur_sem = objmaster.Get_cept_current_sem_data("CFP 2nd Sem Fees");
                hdn_fond.Value = "Y";
            }
        }
        else
        {
            dt_cur_sem = objmaster.Get_cept_current_sem_data("fees_installment");
            hdn_fond.Value = "N";
        }

        fees_sem.Value = dt_cur_sem.Rows[0]["sem_code"].ToString();
        fees_year.Value = dt_cur_sem.Rows[0]["year_code"].ToString();

        hdn_year_code.Value = Session["year_code"].ToString();
        hdn_prog_code.Value = Session["prog_code"].ToString();
        hdn_dept_code.Value = Session["dept_code"].ToString();
        hdn_created_by.Value = Session["created_by"].ToString();

        if (Session["UserId"] != null && Session["dept_code"] != null)
        {
            switch (Session["dept_code"].ToString())
            {
                case "1":
                    hdn_yes_virtual_acc.Value = "CEPTFACM" + Session["UserId"].ToString();
                    break;
                case "2":
                    hdn_yes_virtual_acc.Value = "CEPTFDCM" + Session["UserId"].ToString();
                    break;
                case "3":
                    hdn_yes_virtual_acc.Value = "CEPTFMCM" + Session["UserId"].ToString();
                    break;
                case "4":
                    hdn_yes_virtual_acc.Value = "CEPTFPCM" + Session["UserId"].ToString();
                    break;
                case "5":
                    hdn_yes_virtual_acc.Value = "CEPTFTCM" + Session["UserId"].ToString();
                    break;
            }
        }
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

            ReportPrinter obReportPrinter = new ReportPrinter();

            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Fees_installment_pay_in_slip2.aspx?user_id=" + Session["UserId"].ToString() + "&user_type=" + Session["user_type"].ToString() + "&gender=" + Session["gender"].ToString() + "&semester_code=" + Session["semester_code"].ToString();

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

    protected void Send_Response(object sender, EventArgs e) 
    {
        Application["EncResponse"] = KotakAPIEncReponse.Value;
        Response.Redirect("~/Student/KotakAPIResponse.aspx");
        Server.Transfer("YourPage.aspx");
    }

    //protected void Download_Bank_Instruction(object sender, EventArgs e)06 03 2020 Email Mahroofbhai Stops
    //{
    //    try
    //    {
    //        string str_path = HttpContext.Current.Request.Url.Authority;

    //        for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
    //        {
    //            str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
    //        }

    //        JavaScriptSerializer ser = new JavaScriptSerializer();

    //        string student_code = Session["UserId"].ToString();

    //        ReportPrinter obReportPrinter = new ReportPrinter();

    //        obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Fees_payment_YesBank_offline.aspx?user_id=" + student_code + "&accountno=" + hdn_yes_virtual_acc.Value;

    //        obReportPrinter.GetPdf();

    //        if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
    //        {
    //            HttpContext.Current.Response.ContentType = "application/octet-stream";
    //            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "YesBank_" + student_code + ".pdf"));
    //            HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}
}