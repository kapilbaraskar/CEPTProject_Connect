using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class Student_Dashboard : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["param"] != null && Request.QueryString["param"].ToString() == "true" && Request.QueryString["msg"] != null)
            {
                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();

                HdnMsg.Value = encode.DecryptData(Request.QueryString["msg"].ToString());
            }

            try
            {
                //ViewState["prog_code"] = Session["prog_code"].ToString();

                if (Session["user_type"].ToString() == "E")
                {
                    Response.Redirect("~/Student_WS/Feedback_dashboard.aspx",false);
                }

                if (Session["UserId"].ToString() != "")
                {
                    string mail = objmaster.Get_user_mail(Session["UserId"].ToString());

                    if (mail != "")
                    {
                        DataTable dt_multipel_email = objmaster.Get_multiple_same_email_user(mail);

                        //ViewState["ajay"] = dt_multipel_email;

                        if (dt_multipel_email != null)
                        {
                            if (dt_multipel_email.Rows.Count > 1)
                            {
                                string url = "~/student/select_program.aspx";
                                Response.Redirect(url, false);
                            }

                        }
                    }
                }

                if (Session["user_type"].ToString() != "S")
                {
                    if (Session["user_type"].ToString() == "I")
                    {
                        Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                    }
                    else if (Session["user_type"].ToString() == "A")
                    {
                        Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                    }
                    else if (Session["user_type"].ToString() == "A1")
                    {
                        Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                    }
                }
                else
                {
                if (Session["user_dept"].ToString() == "F")
                    {
                        //if (HttpContext.Current.Session["prog_level_code"].ToString() == "PD22222")
                        //{
                            Response.Redirect("~/student/Fees_dashboard.aspx", false);
                        //}
                    }   
                }

                DataTable dt_param_dtl = objmaster.get_parameter_value("loan_letter_pdf");
                if (dt_param_dtl != null && dt_param_dtl.Rows[0]["parameter_value"].ToString() == "D")
                {
                    div_loan_letter.InnerHtml = "";
                }
                hdn_user_id.Value = Session["UserId"].ToString();
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Login.aspx?logout=2");
            }
        }
    }
    //protected void click_insurance(object sender, EventArgs e)
    //{
      
    //}
    protected void Download_Student_Loan_Letter(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "")
            {
                string str_path = HttpContext.Current.Request.Url.Authority;

                for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
                {
                    str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
                }

                string student_code = Session["UserId"].ToString();

                ReportPrinter obReportPrinter = new ReportPrinter();

                //obReportPrinter.PageFile = "https://" + str_path + "LoanLetterPDF.aspx?uid=" + student_code;
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "LoanLetterPDF.aspx?uid=" + student_code;

                //obReportPrinter.FooterFile = "https://" + str_path + "Footer_LoanLetter.html";
                obReportPrinter.FooterFile = Server.MapPath("~/Student/Footer_LoanLetter.html");

                //obReportPrinter.MarginTop = "2";
                //obReportPrinter.MarginBottom = "0";

                obReportPrinter.GetPdf();
                
                if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                {
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "LoanLetter_" + student_code + ".pdf"));
                    HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    /*Start - Mayur 17/09/2018*/
    protected void Download_OutLine(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "")
            {
                string str_path = HttpContext.Current.Request.Url.Authority;

                for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 2); i++)
                {
                    str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
                }

                string student_code = Session["UserId"].ToString();
                string course_code = hdn_course_code.Value;
                string sem_code = hdn_sem_code.Value;
                string year_code = hdn_year_code.Value;

                ReportPrinter obReportPrinter = new ReportPrinter();

                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "Student/OutLinePDF.aspx?course_id=" + course_code + "&sem_code=" + sem_code + "&year_code=" + year_code;

                obReportPrinter.MarginBottom = "0";

                obReportPrinter.GetPdf();

                if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                {
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "OutLine" + student_code + ".pdf"));
                    HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    /*End - Mayur 17/09/2018*/
}