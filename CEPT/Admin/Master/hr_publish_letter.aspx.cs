using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Ionic.Zip;
using BLL.Master;

public partial class Admin_Master_hr_publish_letter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["user_type"].ToString() == "S")
            {
                Response.Redirect("~/Student/Dashboard.aspx");
            }

            
        }
    }

    protected void Btn_Print_Letters_All_Click(object sender, EventArgs e)
    {
        try
        {
            string directory_path = "C:/Ceptreg_Log/Appointment_Letter/";

            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object>[] All_Instructor_data = ser.Deserialize<Dictionary<string, object>[]>(hdn_All_instructor.Value);

            //Dictionary<string, object> sessionData = new Dictionary<string, object>();
            //foreach (string key in Session.Keys)
            //{
            //    sessionData[key] = Session[key];
            //}

            if (All_Instructor_data.Length > 0)
            {
                string[] delete_filenames = Directory.GetFiles(directory_path);

                for (int i = 0; i < delete_filenames.Length; i++)
                {
                    FileInfo file = new FileInfo(delete_filenames[i]);
                    file.Delete();
                }

                for (int i = 0; i < All_Instructor_data.Length; i++)
                {
                    if (All_Instructor_data[i]["admin_approved"].ToString() == "Approved" && All_Instructor_data[i]["rateband_approved"].ToString() == "Approved")
                    {
                        Masters objmaster = new Masters();
                        DataTable dt_doctoral_dtl = objmaster.get_VF_doctoral_detail(hdn_sem.Value, hdn_year.Value, All_Instructor_data[i]["instructor_code"].ToString());

                        ReportPrinter obReportPrinter = new ReportPrinter();

                        //obReportPrinter.PageFile = "https://" + str_path + "HR_PrintLetter.aspx?iid=" + All_Instructor_data[i]["instructor_code"] + "&idept=" + All_Instructor_data[i]["dept_name"] + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                        if (hdn_usrType.Value == "VF")
                        {
                            if (dt_doctoral_dtl != null && dt_doctoral_dtl.Rows.Count > 0)
                            {
                                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_PrintLetter_phd.aspx?iid=" + All_Instructor_data[i]["instructor_code"] + "&idept=" + All_Instructor_data[i]["dept_name"] + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                            }
                            else
                            {
                                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_PrintLetter.aspx?iid=" + All_Instructor_data[i]["instructor_code"] + "&idept=" + All_Instructor_data[i]["dept_name"] + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                            }
                        }
                        else if (hdn_usrType.Value == "TA" || hdn_usrType.Value == "AA")
                        {
                            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_TA_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                        }
                        //obReportPrinter.HeaderFile = "https://" + str_path + "Header_print_letter.htm";
                        obReportPrinter.HeaderFile = Server.MapPath("~/Admin/Master/Header_print_letter.htm");
                        //obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";
                        //obReportPrinter.FooterFile = "https://" + str_path + "Footer_print_letter.htm";
                        obReportPrinter.FooterFile = Server.MapPath("~/Admin/Master/Footer_print_letter.htm");

                        obReportPrinter.MarginTop = "11";
                        obReportPrinter.MarginBottom = "6";
                        obReportPrinter.MarginLeft = "0";
                        obReportPrinter.MarginRight = "0";
                        obReportPrinter.HeaderHeight = 70;
                        obReportPrinter.FooterHeight = 45;

                        obReportPrinter.GetPdf();

                        FileStream fs = new FileStream(directory_path + "" + All_Instructor_data[i]["instructor_code"] + "_" + All_Instructor_data[i]["instructor_name"].ToString() + "_" + All_Instructor_data[i]["dept_name"] + ".pdf", FileMode.Create);
                        fs.Write(obReportPrinter.FileContent, 0, obReportPrinter.FileContent.Length);
                        fs.Dispose();
                    }
                }

                string[] filenames = Directory.GetFiles(directory_path);

                using (ZipFile zip = new ZipFile())
                {
                    zip.AddFiles(filenames, "Visiting_Faculty_Appointment_Letter.zip");

                    zip.Save(directory_path + "VisitingFacultyZip.zip");

                    Response.ContentType = "application/zip";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=VisitingFacultyZip.zip");
                    Response.TransmitFile(directory_path + "VisitingFacultyZip.zip");
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Btn_Print_Letter_Click(object sender, EventArgs e)
    {
        try
        {
            string str_path = HttpContext.Current.Request.Url.Authority;

            for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
            {
                str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            //Dictionary<string, object> sessionData = new Dictionary<string, object>();
            //foreach (string key in Session.Keys)
            //{
            //    sessionData[key] = Session[key];
            //}

            Masters objmaster = new Masters();

            DataTable dt_doctoral_dtl = objmaster.get_VF_doctoral_detail(hdn_sem.Value, hdn_year.Value, hdn_instructor.Value);

            string userType = objmaster.get_user_type_for_letter_TA_AA(hdn_sem.Value, hdn_year.Value, hdn_instructor.Value);
            
            ReportPrinter obReportPrinter = new ReportPrinter();

            //obReportPrinter.PageFile = "https://" + str_path + "HR_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&session=" + ser.Serialize(sessionData);
            //obReportPrinter.PageFile = "https://" + str_path + "HR_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
            if (hdn_tea_letter.Value == "TEA")
            {
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_TEA_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
            }
            else if (hdn_usrType.Value == "VF")
            {
                if (dt_doctoral_dtl != null && dt_doctoral_dtl.Rows.Count > 0 && hdn_prog_code.Value == "3")
                {
                    obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_PrintLetter_phd.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                }
                else
                {
                    obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                }
            }
            else if (userType == "TA")
            {
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_TA_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
            }
            else if (userType == "AA")
            {
                obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_AA_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
            }
            string directory_path = "C:/Ceptreg_Log/";
            //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "Inside Publish Letter : PagePath : " + obReportPrinter.PageFile + Environment.NewLine);

            //obReportPrinter.HeaderFile = "https://" + str_path + "Header_print_letter.htm";
            obReportPrinter.HeaderFile = Server.MapPath("~/Admin/Master/Header_print_letter.htm");
            //obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";
            //obReportPrinter.FooterFile = "https://" + str_path + "Footer_print_letter.htm";
            obReportPrinter.FooterFile = Server.MapPath("~/Admin/Master/Footer_print_letter.htm");

            obReportPrinter.MarginTop = "11";
            obReportPrinter.MarginBottom = "6";
            obReportPrinter.MarginLeft = "0";
            obReportPrinter.MarginRight = "0";
            obReportPrinter.HeaderHeight = 70;
            obReportPrinter.FooterHeight = 45;

            obReportPrinter.GetPdf();

            //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "Inside Publish Letter : FileContent : " + obReportPrinter.FileContent + Environment.NewLine);

            if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
            {
                //System.IO.File.AppendAllText(@"" + directory_path + "temp.txt", "Inside Publish Letter : ContentLength : " + obReportPrinter.FileContent.Length + Environment.NewLine);

                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "" + hdn_instructor_name.Value.Replace(' ', '_') + "_" + hdn_dept.Value + ".pdf"));
                HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
            }

            hdn_instructor.Value = "";
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void Btn_Send_Mail_Click(object sender, EventArgs e)
    {
        try
        {
            string res = send_Appointment_mail_to_visiting_faculty(hdn_instructor.Value);

            //hdn_instructor.Value = "";

            //ClientScript.RegisterStartupScript(GetType(), "id", "demoFunction()", true);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    public string send_Appointment_mail_to_visiting_faculty(string instructor_list)
    {
        Masters objmaster = new Masters();
        Mail obj_mailcs = new Mail();

        var user_id = HttpContext.Current.Session["UserId"].ToString();
        var user_type = HttpContext.Current.Session["user_type"].ToString();

        try
        {
            if (user_type == "HR")
            {
                JavaScriptSerializer ser = new JavaScriptSerializer();

                //Dictionary<string,object> request_data = ser.Deserialize<Dictionary<string,object>>(instructor_list);

                Dictionary<string, object>[] dic_instructor_list = ser.Deserialize<Dictionary<string, object>[]>(instructor_list);

                if (dic_instructor_list.Length > 0)
                {
                    DataTable dt_instructor_mst_data = objmaster.Get_All_instructor_mst_data();

                    string directory_path = "C:/Ceptreg_Log/Send_Appointment_Letter/";

                    string str_path = HttpContext.Current.Request.Url.Authority;

                    for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
                    {
                        str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
                    }

                    string[] delete_filenames = Directory.GetFiles(directory_path);

                    for (int i = 0; i < delete_filenames.Length; i++)
                    {
                        FileInfo file = new FileInfo(delete_filenames[i]);
                        file.Delete();
                    }

                    //Dictionary<string, object> sessionData = new Dictionary<string, object>();
                    //foreach (string key in Session.Keys)
                    //{
                    //    sessionData[key] = Session[key];
                    //}

                    if (dt_instructor_mst_data != null)
                    {
                        for (int i = 0; i < dic_instructor_list.Length; i++)
                        {
                            DataRow[] dr = dt_instructor_mst_data.Select("instructor_code = '" + dic_instructor_list[i]["instructor_code"] + "'");

                            if (dr.Length > 0)
                            {
                                if (dr[0]["mail"].ToString() != "")
                                {
                                    dic_instructor_list[i]["status"] = "False";
                                    dic_instructor_list[i]["destination_mail"] = dr[0]["mail"].ToString();

                                    DataTable dt_doctoral_dtl = objmaster.get_VF_doctoral_detail(hdn_sem.Value, hdn_year.Value, dic_instructor_list[i]["instructor_code"].ToString());

                                    ReportPrinter obReportPrinter = new ReportPrinter();

                                    //obReportPrinter.PageFile = "https://" + str_path + "HR_PrintLetter.aspx?iid=" + dic_instructor_list[i]["instructor_code"] + "&idept=" + dic_instructor_list[i]["dept_name"] + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                                    if (hdn_usrType.Value == "VF")
                                    {
                                        if (dt_doctoral_dtl != null && dt_doctoral_dtl.Rows.Count > 0)
                                        {
                                            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_PrintLetter_phd.aspx?iid=" + dic_instructor_list[i]["instructor_code"] + "&idept=" + dic_instructor_list[i]["dept_name"] + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                                        }
                                        else
                                        {
                                            obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_PrintLetter.aspx?iid=" + dic_instructor_list[i]["instructor_code"] + "&idept=" + dic_instructor_list[i]["dept_name"] + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                                        }
                                    }
                                    else if (hdn_usrType.Value == "TA" || hdn_usrType.Value == "AA")
                                    {
                                        obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "HR_TA_PrintLetter.aspx?iid=" + hdn_instructor.Value + "&idept=" + hdn_dept.Value + "&sc=" + hdn_sem.Value + "&yc=" + hdn_year.Value + "&FA_name=" + Session["UserName"].ToString() + "&FA_mail=" + Session["email"].ToString();
                                    }
                                    //obReportPrinter.HeaderFile = "https://" + str_path + "Header_print_letter.htm";
                                    obReportPrinter.HeaderFile = Server.MapPath("~/Admin/Master/Header_print_letter.htm");
                                    //obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";
                                    //obReportPrinter.FooterFile = "https://" + str_path + "Footer_print_letter.htm";
                                    obReportPrinter.FooterFile = Server.MapPath("~/Admin/Master/Footer_print_letter.htm");

                                    obReportPrinter.MarginTop = "11";
                                    obReportPrinter.MarginBottom = "6";
                                    obReportPrinter.MarginLeft = "0";
                                    obReportPrinter.MarginRight = "0";
                                    obReportPrinter.HeaderHeight = 70;
                                    obReportPrinter.FooterHeight = 45;

                                    obReportPrinter.GetPdf();

                                    if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                                    {
                                        FileStream fs = new FileStream(directory_path + "" + dic_instructor_list[i]["instructor_code"] + "_" + dr[0]["first_name"].ToString() + ".pdf", FileMode.Create);
                                        fs.Write(obReportPrinter.FileContent, 0, obReportPrinter.FileContent.Length);
                                        fs.Dispose();

                                        dic_instructor_list[i]["attachment_path"] = directory_path + "" + dic_instructor_list[i]["instructor_code"] + "_" + dr[0]["first_name"].ToString() + ".pdf";
                                        dic_instructor_list[i]["attachment_name"] = "" + dic_instructor_list[i]["instructor_code"] + "_" + dr[0]["first_name"].ToString() + ".pdf";

                                        dic_instructor_list[i]["status"] = "True";
                                    }
                                }
                                else
                                {
                                    dic_instructor_list[i]["status"] = "False";
                                }
                            }
                            else
                            {
                                dic_instructor_list[i]["status"] = "False";
                            }
                            dic_instructor_list[i]["hdn_user_type"] = hdn_usrType.Value;
                        }

                        string res = obj_mailcs.Send_Appointment_Mail_to_visiting_faculty(dic_instructor_list, null);
                    }
                }
                else
                {
                    return "No Instructor found to Send Mail.";
                }

            }
            else
            {
                return "You are not Authorized to Send Mails.";
            }
        }
        catch (Exception ex)
        {
            return "Problem in Send Mails.";
        }
        return "";
    }
}