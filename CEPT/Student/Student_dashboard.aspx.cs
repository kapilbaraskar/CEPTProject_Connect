using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;
using System.Web.Script.Serialization;

public partial class Student_Student_dashboard : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    //protected void Page_PreInit(object sender, EventArgs e)
    //{
    //    if (IsPostBack)
    //    {
    //    }
    //    //ViewState["aaa"] = txt_test.Text;
    //    //Page.Theme = "BlueTheme";
    //    //ViewState["value"] = "abc";
    //    //txt_test.EnableViewState = false;
    //}
    protected void Download_Student_outlet(object sender, EventArgs e)
    {
        try
        {

            string str_html = hdn_outline.Value;
            str_html = str_html.Replace("&lt;", "<");
            str_html = str_html.Replace("&rt;", ">");

            ReportPrinterFromHTML obReportPrinter = new ReportPrinterFromHTML();

            obReportPrinter.PageHTML = str_html;

            obReportPrinter.MarginBottom = "0";

            obReportPrinter.GetPdf();

            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "CourseOutline.pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    protected void Page_PreInit(object sender, EventArgs e)
    {
        //this.MasterPageFile = "~/AdminCEPT.master";
        if (IsPostBack)
        {
            //this.Load += new System.EventHandler(this.Page_Load);
        }
        //string a = txt.ID;
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            //this.Load += new System.EventHandler(this.Page_Load);
        }
    }

    protected void Page_InitComplete(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            //this.Load += new System.EventHandler(this.Page_Load);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //Label masterlbl = (Label)Master.FindControl("lblMaster");

        if (!IsPostBack)
        {
            try
            {
                if (Session["UserId"].ToString() != "")
                {
                    //payment_open.Style.Clear();
                    //payment_open.Style.Add("display", "block");

                    //if (Session["dept_code"].ToString() != "5")
                    //{
                    //    payment_open.Style.Clear();
                    //    payment_open.Style.Add("display","block");
                    //}
                    //else
                    //{
                    //    payment_closed.Style.Clear();
                    //    payment_closed.Style.Add("display", "block");
                    //}

                    if (Session["year_code"].ToString() == "Y2016")
                    {
                        //Response.Redirect("~/Student/Dashboard.aspx", false);
                    }
                    else
                    {
                        //string b = "";
                    }

                    string mail = objmaster.Get_user_mail(Session["UserId"].ToString());

                    if (mail != "")
                    {
                        DataTable dt_multipel_email = objmaster.Get_multiple_same_email_user(mail);

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

                //if (Session["user_dept"].ToString() != "F")
                //{
                //    if (Session["prog_level_code"].ToString() != "PD222222")
                //    {
                //        if (Session["is_personal_dtl_saved"].ToString() == "" || Session["agree_afidavite"].ToString() == "")
                //        {
                //            Response.Redirect("~/student/Dashboard.aspx", false);
                //        }
                //    }
                //}

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
                        if (HttpContext.Current.Session["prog_level_code"].ToString() == "PD222222")
                        {
                            Response.Redirect("~/student/Fees_dashboard.aspx", false);
                        }
                    }
                }

                DataTable dt_param_dtl = objmaster.get_parameter_value("registration_process");
                if (dt_param_dtl != null && dt_param_dtl.Rows[0]["parameter_value"].ToString() == "D")
                {
                    div_buttons.InnerHtml = "";
                    td_save_credit.InnerHtml = "";
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Login.aspx?logout=2");
            }
        }
    }
}