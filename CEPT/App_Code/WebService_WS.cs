using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using BLL;
using BLL.Utilities;
using BLL.Master_WS;
using System.Data;
using BLL.ExtraUtility;
using XSD.Masters_WS;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Net.Mail;
using System.Data.OleDb;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System.Collections;
using System.Text.RegularExpressions;
using Newtonsoft.Json;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService_WS : System.Web.Services.WebService
{
    #region Variable declaration

    Boolean isEmpty;
    Masters_WS objmaster = new Masters_WS(); // Master Class Object
    string jsondata = "";
    string[] json_array = new string[3];
    EncodingDecoding encoding_decoding = new EncodingDecoding();
    Mail_WS objmail = new Mail_WS();

    BLReturnObject objBLReturnObject = new BLReturnObject();
    BindDropDown objBindDropDown = new BindDropDown();
    Masters_WS objMaster = new Masters_WS();
    ExtraUtility objextra = new ExtraUtility();

    Document objDocument = new Document();
    Ds_Bill_Entry_Save obj_bill_entry = new Ds_Bill_Entry_Save();
    Ds_Student_Course_detail_WS obj_student = new Ds_Student_Course_detail_WS();

    Ds_Student_Course_detail_WS obj_student_new = new Ds_Student_Course_detail_WS();
    DSC_fees_status_WS obj_fees_status = new DSC_fees_status_WS();
    DSC_userdataupload_WS obj_userdataupload = new DSC_userdataupload_WS();
    DS_Feedback_Save_WS obj_feedback = new DS_Feedback_Save_WS();
    DS_Feedback_calculation_WS obj_feedback_calculation = new DS_Feedback_calculation_WS();
    DataTable user_mst = new DataTable();

    DataTable dt_error = new DataTable();

    string[] jsonarray = new string[2];
    DataTable dt_ws_current_sem = new DataTable();
    string current_ws_sem = "";
    string current_ws_year = "";
    string current_round = "";
   

    //public delegate void MyDLL_InternalStatus(int progress, string statustext);

    //public event MyDLL_InternalStatus a;

    DataRow dr_error;

    #endregion

    public WebService_WS()
    {
        dt_ws_current_sem = objmaster.Get_WS_current_sem_data();

        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
            current_round = dt_ws_current_sem.Rows[0]["round"].ToString();
        }

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod(EnableSession = true)]
    public string login_redirect()
    {
        DataTable dt_term_condition = objmaster.Get_term_condition_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        if (dt_term_condition == null)
        {
            return "term_condition";
        }

        if (HttpContext.Current.Session["user_type"].ToString() == "S" || HttpContext.Current.Session["user_type"].ToString() == "E")
        {
            return "student";
        }
        else if (HttpContext.Current.Session["user_type"].ToString() == "A")
        {
            return "admin";
        }
        else if (HttpContext.Current.Session["user_type"].ToString() == "A1" || HttpContext.Current.Session["user_type"].ToString() == "A2")
        {
            return "admin1";
        }
        else if (HttpContext.Current.Session["user_type"].ToString() == "I")
        {
            return "it";
        }
        else if (HttpContext.Current.Session["user_type"].ToString() == "F")
        {
            return "fianance";
        }

        return "";
    }

    [WebMethod(EnableSession = true)]
    public string LoginCheck(String username, string Password, bool remember_val)
    {
        EncryptPassword encrpt = new EncryptPassword();

        string pass = Password;
        //Password = encrpt.sbs_encrypt(Password.ToString().Trim());

        Password = encoding_decoding.encryptPassword(Password.ToString().Trim());
        Login objLogin = new BLL.Utilities.Login();
        LoginInfo objLoginInfo = objLogin.CheckIn(username.ToString().Trim(), Password, HttpContext.Current.Request.UserHostAddress, HttpContext.Current.Request.UserHostName, ClientType.Browser, Module.SND, "HelpList");
        if (objLoginInfo != null)
        {
            if (objLoginInfo.LoginStatus == 1)
            {
                try
                {
                    //Session["StartPeriod"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.Now.ToString("01/yyyy");
                    //Session["EndPeriod"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.DaysInMonth(System.DateTime.Now.Year, System.DateTime.Now.Month).ToString("00") + "/" + System.DateTime.Now.ToString("yyyy");
                    HttpContext.Current.Session["is_special_user"] = false;
                    if (objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["user_dept"].ToString().Trim() == "SpecialAdmin")
                        HttpContext.Current.Session["is_special_user"] = true;
                    HttpContext.Current.Session["start_date"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.Now.ToString("01/yyyy");
                    HttpContext.Current.Session["end_date"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.DaysInMonth(System.DateTime.Now.Year, System.DateTime.Now.Month).ToString("00") + "/" + System.DateTime.Now.ToString("yyyy");
                    HttpContext.Current.Session["SessionId"] = objLoginInfo.SessionId.ToString().Trim();
                    HttpContext.Current.Session["UserId"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["user_id"].ToString(); //txtUserName.Text.Trim();
                    Clientsession.Getuser_ID(Session["UserId"].ToString());
                    HttpContext.Current.Session["UserName"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["user_name"].ToString();
                    //  HttpContext.Current.Session["semester_code"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["semester_code"].ToString();
                    HttpContext.Current.Session["dept_code"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["dept_code"].ToString();
                    HttpContext.Current.Session["prog_code"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["prog_code"].ToString();
                    HttpContext.Current.Session["prog_level_code"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["prog_level_code"].ToString();
                    HttpContext.Current.Session["user_type"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["user_type"].ToString();
                    HttpContext.Current.Session["year_code"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["year_code"].ToString();
                    HttpContext.Current.Session["student_code"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["student_no"].ToString();
                    HttpContext.Current.Session["prof_details"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["prof_details"].ToString();
                    //HttpContext.Current.Session["company_code"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["company_code"].ToString();
                    //Session["sa_id"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["sa_id"].ToString();
                    //Session["owner_sa_id"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_UserLevelRights"].Rows[0]["division"].ToString();
                    ////Session["current_division"] = "'" + Session["owner_sa_id"].ToString() + "'";
                    //Session["division_desc"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_UserLevelRights"].Rows[0]["division_desc"].ToString();
                    HttpContext.Current.Session["IsAuthenticated"] = true;
                    HttpContext.Current.Session["SessionId"] = objLoginInfo.SessionId.ToString().Trim();
                    HttpContext.Current.Session["UserLevelRights"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_UserLevelRights"];
                    HttpContext.Current.Session["UserMenuRights"] = objLoginInfo.ds_BusinessAreaInfo.Tables["menu_info"];
                    HttpContext.Current.Session["country"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["country"].ToString();
                    //HttpContext.Current.Session["is_field_employee"] = objLoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["is_field_employee"].ToString();

                    if (HttpContext.Current.Session["user_type"].ToString() == "S" || HttpContext.Current.Session["user_type"].ToString() == "E")
                    {
                        //DataTable dt = objmaster.check_credit_choice_by_student("", "", HttpContext.Current.Session["UserId"].ToString(), "");

                        DataTable dt_term_condition = objmaster.Get_term_condition_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

                        if (dt_term_condition == null)
                        {
                            HttpContext.Current.Session["term_condition"] = "";
                            return "term_condition";
                        }
                        else
                        {
                            HttpContext.Current.Session["term_condition"] = "Y";
                        }

                        //if (dt != null)
                        //{
                        //    HttpContext.Current.Session["semester_code"] = dt.Rows[0]["semester_code"].ToString();
                        //}
                        //else
                        //{
                        //    HttpContext.Current.Session.RemoveAll();
                        //    HttpContext.Current.Session.Abandon();
                        //    return "Student Current Sem Detail not found in systems";
                        //}
                    }

                    if (remember_val == true)
                    {
                        HttpCookie cookie = new HttpCookie("cept_login");
                        cookie.Values.Add("user_id", HttpContext.Current.Session["UserId"].ToString());
                        cookie.Values.Add("user_name", HttpContext.Current.Session["UserName"].ToString());
                        cookie.Values.Add("user_type", HttpContext.Current.Session["user_type"].ToString());
                        cookie.Values.Add("dept_code", HttpContext.Current.Session["dept_code"].ToString());
                        cookie.Values.Add("prog_code", HttpContext.Current.Session["prog_code"].ToString());
                        cookie.Values.Add("semester_code", HttpContext.Current.Session["semester_code"].ToString());
                        cookie.Values.Add("year_code", HttpContext.Current.Session["year_code"].ToString());
                        cookie.Values.Add("prog_level_code", HttpContext.Current.Session["prog_level_code"].ToString());
                        cookie.Values.Add("country", HttpContext.Current.Session["country"].ToString());
                        cookie.Values.Add("prof_details", HttpContext.Current.Session["prof_details"].ToString());
                        cookie.Expires = DateTime.Now.AddDays(8);
                        HttpContext.Current.Response.Cookies.Add(cookie);
                    }

                    if (pass.ToLower() == "admin")
                    {
                        HttpContext.Current.Session["reset_flag"] = "R";
                        return "change_password";
                    }

                    if (HttpContext.Current.Session["user_type"].ToString() == "S" || HttpContext.Current.Session["user_type"].ToString() == "E")
                    {
                        return "student";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "A")
                    {
                        return "admin";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "A1")
                    {
                        return "admin1";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "I")
                    {
                        return "it";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "A2")
                    {
                        return "admin";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "F")
                    {
                        return "fianance";
                    }

                    return "";
                }
                catch (Exception ex)
                {
                    return "Error - " + ex.Message.ToString();
                }
            }
            else
            {
                return "Login status is 2" + objLoginInfo.ServerMessage + objLoginInfo.LoginStatus;
            }
        }
        else
        {
            return "Data not found";
        }
    }

    [WebMethod(EnableSession = true)]
    public string Registration(string password, string gender, string birthdate, string blood_grp, string country, string place_of_birth, string nationality, string local_address,
                               string per_adress, string mobile, string email, string alt_email, string resident_no, string acadamic_prog, string year_of_enr, string year_of_passing, string name_of_uni,
        string name_of_degree, string prof_exp, string add_of_university, string marks, string about_here, string first_name, string middel_name, string last_name, string other_country, string prof_details, string prof_name_of_organization, string bonafide_certificate, string degree_certificate_name, string letter_organization)
    {
        try
        {
            DataTable dt_user_mst_data = objmaster.get_all_user_mst_data();
            DataTable dt_year_data = objmaster.Get_year_data();

            if (dt_user_mst_data != null)
            {
                DataRow[] dr = dt_user_mst_data.Select("mail = '" + email.ToString().Trim() + "' or alternet_mail = '" + email.ToString().Trim() + "'");

                if (alt_email != "")
                {
                    DataRow[] dr1 = dt_user_mst_data.Select("mail = '" + alt_email.ToString().Trim() + "' or alternet_mail = '" + alt_email.ToString().Trim() + "'");

                    if (dr.Length > 0 || dr1.Length > 0)
                    {
                        return "Email";
                    }
                }
                else
                {
                    if (dr.Length > 0)
                    {
                        return "Email";
                    }
                }
            }

            EncryptPassword encrpt = new EncryptPassword();

            string pass = password;
            //Password = encrpt.sbs_encrypt(Password.ToString().Trim());

            password = encoding_decoding.encryptPassword(password.ToString().Trim());

            DSC_userdataupload_WS.user_mstRow user_row = obj_userdataupload.user_mst.Newuser_mstRow();
            user_row.doc_no = "1";
            user_row.user_id = "1";

            string fullname = first_name.ToString() + " " + middel_name.ToString() + " " + last_name.ToString();

            user_row.user_name = fullname.ToString();
            user_row.first_name = first_name.ToString();
            user_row.middle_name = middel_name.ToString();
            user_row.last_name = last_name.ToString();
            //user_row.user_type = user_mst.Rows[i]["user type"].ToString().Trim().Substring(0, 1);
            user_row.student_no = "1";

            user_row.user_type = "E";

            if (dt_year_data != null)
            {
                DataRow[] dr1 = dt_year_data.Select("year_Desc = '" + System.DateTime.Now.Year.ToString() + "'");
                if (dr1.Length > 0)
                {
                    user_row.year_code = dr1[0]["year_code"].ToString();
                    // user_row.year_code = "Y2014";
                }
            }

            //user_row.enrollment_no = user_mst.Rows[i]["Enrollment No"].ToString().Trim();

            user_row.enrollment_no = "";
            user_row.dept_code = "7";
            user_row.password = password.ToString();

            //////////////personal details ////////////////////
            //user_row.first_name = "";
            //user_row.middle_name = "";
            //user_row.last_name = "";

            user_row.full_name = fullname.ToString();
            user_row.gender = gender.ToString();

            //if (birthdate != "")
            //{
            //    user_row.dob = Convert.ToDateTime(birthdate.ToString().Trim());
            //}

            if (birthdate != "")
            {
                string date_of_birth = getdate(birthdate);
                user_row.dob = Convert.ToDateTime(date_of_birth.ToString());
            }

            user_row.blood_group = blood_grp.ToString();
            user_row.country = country.ToString();

            if (other_country != "")
            {
                user_row.other_county = other_country.ToString();
            }

            user_row.place_of_birth = place_of_birth.ToString();
            user_row.nationality = nationality.ToString();

            //////////Contact details /////////////////////

            user_row.address = per_adress.Replace('\n', ',').ToString();
            user_row.local_address = local_address.Replace('\n', ',').ToString();
            user_row.phone_no = resident_no.ToString();
            user_row.mobile_no = mobile.ToString();
            user_row.mail = email.ToString().Trim();
            user_row.alternet_mail = alt_email.ToString();

            ///////////Education details///////////

            user_row.academic_prog = acadamic_prog.ToString();
            user_row.year_of_Enrollment = year_of_enr.ToString();
            user_row.year_of_passing = year_of_passing.ToString();
            user_row.name_of_university = name_of_uni.ToString();
            user_row.full_name_of_degree = name_of_degree.ToString();
            user_row.prof_exp = prof_exp.ToString();
            user_row.prof_details = prof_details;
            user_row.prof_organization = prof_name_of_organization;
            user_row.address_of_university = add_of_university.Replace('\n', ',').ToString();
            user_row.marks = marks.ToString();
            user_row.about_here = about_here.Replace('\n', ',').ToString();

            //////////////////////

            user_row.start_date = System.DateTime.Now;
            //user_row.end_date = Convert.ToDateTime(user_mst.Rows[i]["End Date"].ToString().Trim());

            DateTime date = System.DateTime.Now;
            DateTime pass_exp_date = date.AddYears(8);

            user_row.pass_expiry_date = pass_exp_date;
            user_row.user_status_flag = "A";
            user_row.status = "A";

            //user_row.city = user_mst.Rows[i]["city"].ToString().Trim();
            //user_row.state = user_mst.Rows[i]["state"].ToString().Trim();
            //user_row.last_login_date = ;

            user_row.cancel_flag = "N";
            user_row.created_by = "";
            user_row.created_date = System.DateTime.Now;
            user_row.created_host = HttpContext.Current.Request.UserHostName;
            user_row.ws_semester_type = current_ws_sem.ToString();
            user_row.ws_year_semester = current_ws_year.ToString();

            //user_row.last_modified_by = context.Session["UserId"].ToString();
            //user_row.last_midified_date = System.DateTime.Now;
            //user_row.last_modified_host = HttpContext.Current.Request.UserHostName;

            obj_userdataupload.user_mst.Adduser_mstRow(user_row);

            DSC_userdataupload_WS.ws_student_certificate_dtlRow certi_row = obj_userdataupload.ws_student_certificate_dtl.Newws_student_certificate_dtlRow();

            certi_row.bonafide_certi_name = bonafide_certificate;
            certi_row.degree_certificate_name = degree_certificate_name;
            certi_row.letter_organization = letter_organization;
            certi_row.user_id = "1";
            certi_row.semester_type = current_ws_sem;
            certi_row.year_semester = current_ws_year;
            certi_row.cancel_flag = "N";
            certi_row.created_by = email;
            certi_row.created_date = System.DateTime.Now;
            certi_row.created_host = HttpContext.Current.Request.UserHostName;

            obj_userdataupload.ws_student_certificate_dtl.Addws_student_certificate_dtlRow(certi_row);

            objBLReturnObject = objMaster.Save_registration_data(obj_userdataupload, "2000", "", HttpContext.Current.Request.UserHostName);

            string Message = "";
            if (objBLReturnObject.ExecutionStatus == 1)
            {
                try
                {
                    string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
                    string sending_password = ConfigurationSettings.AppSettings["password"].ToString();
                    string host = ConfigurationSettings.AppSettings["host"].ToString();
                    int port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"].ToString());

                    SmtpClient SmtpServer = new SmtpClient();

                    SmtpServer.Credentials = new System.Net.NetworkCredential(sending_email, sending_password);
                    SmtpServer.Port = port;
                    SmtpServer.Host = host;
                    SmtpServer.EnableSsl = true;

                    MailMessage mail = new MailMessage();

                    string TomailIds = email.ToString().Trim().ToLower();

                    mail.From = new MailAddress(sending_email, sending_email, System.Text.Encoding.UTF8);
                    mail.To.Add(TomailIds);
                    mail.Subject = "Registration Details - CEPT";

                    Message = "Dear, " + first_name + " " + middel_name + " " + last_name;
                    Message += "<br /><p>Thanks for your Registration in CEPT University.</p>";
                    Message += "<br />" + objBLReturnObject.ServerMessage + "";
                    Message += "<br />Your Username is :  " + email + "";
                    Message += "<br />Your Password is :  " + pass + "";
                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    mail.Body = Message.ToString();
                    mail.IsBodyHtml = true;

                    SmtpServer.Send(mail);

                    SmtpClient SmtpServer1 = new SmtpClient();

                    SmtpServer1.Credentials = new System.Net.NetworkCredential(sending_email, sending_password);

                    SmtpServer1.Port = port;
                    SmtpServer1.Host = host;
                    SmtpServer1.EnableSsl = true;

                    MailMessage mail1 = new MailMessage();

                    string summer_email = ConfigurationSettings.AppSettings["summer_winter"].ToString();

                    mail1.From = new MailAddress(sending_email, sending_email, System.Text.Encoding.UTF8);
                    mail1.To.Add(summer_email);
                    mail1.Subject = "Registration Details - CEPT";

                    Message = "Dear, Admin ";
                    Message += "<br /><p>Following student has registered</p>";
                    Message += "<br />" + objBLReturnObject.ServerMessage + "";
                    Message += "<br />The registered student is :  " + first_name + " " + middel_name + " " + last_name;
                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    mail1.Body = Message.ToString();
                    mail1.IsBodyHtml = true;

                    SmtpServer1.Send(mail1);
                }
                catch (Exception ex)
                {
                    ServerLog.Log("Error in mail send For " + objBLReturnObject.ServerMessage);
                }
            }
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }

        return objBLReturnObject.ServerMessage;
    }

    [WebMethod(EnableSession = true)]
    public bool check_session()
    {
        if (HttpContext.Current.Session["UserId"] == null)
            return false;

        return true;
    }

    #region password

    [WebMethod(EnableSession = true)]
    public string Change_password(string Password, string oldPassword)
    {
        EncryptPassword encrpt = new EncryptPassword();

        string pass = Password;

        Password = encoding_decoding.encryptPassword(Password.ToString().Trim());

        //Password = encrpt.sbs_encrypt(Password.ToString().Trim());
        BLL.Utilities.Login objLogin = new BLL.Utilities.Login();

        if (oldPassword == "")
        {
            //oldPassword = encrpt.sbs_encrypt("admin");
            oldPassword = encoding_decoding.encryptPassword("admin");
        }

        if (Password.Trim() == oldPassword.Trim())
        {
            objBLReturnObject.ExecutionStatus = 2;
            objBLReturnObject.ServerMessage = "same";
            return objBLReturnObject.ServerMessage;
        }

        objBLReturnObject = objLogin.ChangePassWord(HttpContext.Current.Session["UserId"].ToString(), oldPassword, Password);

        if (objBLReturnObject != null)
        {
            if (objBLReturnObject.ExecutionStatus == 1)
            {
                try
                {
                    //Session["StartPeriod"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.Now.ToString("01/yyyy");
                    //Session["EndPeriod"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.DaysInMonth(System.DateTime.Now.Year, System.DateTime.Now.Month).ToString("00") + "/" + System.DateTime.Now.ToString("yyyy");

                    HttpContext.Current.Session["reset_flag"] = "C";

                    if (HttpContext.Current.Session["user_type"].ToString() == "S")
                    {
                        objBLReturnObject.ServerMessage = "student";
                        return objBLReturnObject.ServerMessage;
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "A")
                    {
                        return "admin";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "A1" || HttpContext.Current.Session["user_type"].ToString() == "A2")
                    {
                        return "admin1";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "I")
                    {
                        return "it";
                    }
                    else if (HttpContext.Current.Session["user_type"].ToString() == "I")
                    {
                        return "fianance";
                    }

                    return "";
                }
                catch (Exception ex)
                {
                    return "Fail";
                }
            }
            else
            {
                return "Fail";
            }
        }
        else
        {
            return "Fail";
        }
    }

    [WebMethod(EnableSession = true)]
    public string Change_new_password(string Password, string user_id)
    {
        EncryptPassword encrpt = new EncryptPassword();

        string pass = Password;

        Password = encoding_decoding.encryptPassword(Password.ToString().Trim());

        //Password = encrpt.sbs_encrypt(Password.ToString().Trim());
        BLL.Utilities.Login objLogin = new BLL.Utilities.Login();

        //if (oldPassword == "")
        //{
        //    //oldPassword = encrpt.sbs_encrypt("admin");
        //    oldPassword = encoding_decoding.encryptPassword("admin");
        //}

        //if (Password.Trim() == oldPassword.Trim())
        //{
        //    objBLReturnObject.ExecutionStatus = 2;
        //    objBLReturnObject.ServerMessage = "same";
        //    return objBLReturnObject.ServerMessage;
        //}

        objBLReturnObject = objLogin.Change_new_PassWord(user_id, "", Password);

        if (objBLReturnObject != null)
        {
            if (objBLReturnObject.ExecutionStatus == 1)
            {
                try
                {
                    //Session["StartPeriod"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.Now.ToString("01/yyyy");
                    //Session["EndPeriod"] = System.DateTime.Now.Month.ToString("00") + "/" + System.DateTime.DaysInMonth(System.DateTime.Now.Year, System.DateTime.Now.Month).ToString("00") + "/" + System.DateTime.Now.ToString("yyyy");

                    objBLReturnObject.ServerMessage = "success";
                    return objBLReturnObject.ServerMessage;
                }
                catch (Exception ex)
                {
                    return "Fail";
                }
            }
            else
            {
                return "Fail";
            }
        }
        else
        {
            return "Fail";
        }
    }

    [WebMethod(EnableSession = true)]
    public string save_changed_password(string oldPassword, string Password)
    {
        try
        {
            EncryptPassword encrpt = new EncryptPassword();

            //Password = encrpt.sbs_encrypt(Password.ToString().Trim());
            Password = encoding_decoding.encryptPassword(Password.ToString().Trim());
            BLL.Utilities.Login objLogin = new BLL.Utilities.Login();

            //oldPassword = encrpt.sbs_encrypt(oldPassword.ToString().Trim());
            oldPassword = encoding_decoding.encryptPassword(oldPassword.ToString().Trim());

            objBLReturnObject = objLogin.ChangePassWord(HttpContext.Current.Session["UserId"].ToString(), oldPassword, Password);
        }
        catch (Exception)
        {
            return "Problem in Change Password";
        }

        return objBLReturnObject.ServerMessage;
    }

    [WebMethod(EnableSession = true)]
    public string send_forgot_password(string email_id)
    {
        try
        {
            EncryptPassword encrpt = new EncryptPassword();
            DataTable dt_user = objmaster.get_all_user_mst_data();

            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();
            string host = ConfigurationSettings.AppSettings["host"].ToString();
            int port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"].ToString());
            string reset_password_link = ConfigurationSettings.AppSettings["reset_password"].ToString();
            string password = "";
            string user_id = "";

            if (dt_user != null)
            {
                DataRow[] dr = dt_user.Select("mail = '" + email_id.ToString().Trim().ToLower() + "'");

                if (dr.Length > 0)
                {
                    password = dr[0]["password"].ToString();
                    user_id = dr[0]["user_id"].ToString();

                    string Password = encoding_decoding.decryptPassword(password.ToString().Trim());

                    SmtpClient SmtpServer = new SmtpClient();

                    SmtpServer.Credentials = new System.Net.NetworkCredential(sending_email, sending_password);
                    SmtpServer.Port = port;
                    SmtpServer.Host = host;
                    SmtpServer.EnableSsl = true;

                    MailMessage mail = new MailMessage();

                    string TomailIds = email_id.ToString().Trim().ToLower();

                    mail.From = new MailAddress(sending_email, sending_email, System.Text.Encoding.UTF8);
                    mail.To.Add(TomailIds);
                    mail.Subject = "Forgot Password - CEPT";
                    mail.Body = "Your Reset password link : '" + reset_password_link + user_id + "'";
                    mail.IsBodyHtml = true;

                    SmtpServer.Send(mail);
                }
                else
                {
                    return "This email id is not match in master";
                }
            }
            else
            {
                return "no user data found in user master";
            }
        }
        catch (Exception)
        {
            return "Problem in Change Password";
        }

        return "Password is sent in your mail account";
    }

    #endregion

    public DataTable RemoveDuplicateRows(DataTable dTable, string colName)
    {
        Hashtable hTable = new Hashtable();
        ArrayList duplicateList = new ArrayList();

        foreach (DataRow drow in dTable.Rows)
        {
            if (hTable.Contains(drow[colName]))
                duplicateList.Add(drow);
            else
                hTable.Add(drow[colName], string.Empty);
        }

        foreach (DataRow dRow in duplicateList)
            dTable.Rows.Remove(dRow);

        return dTable;
    }

    public DataTable checkduplicatedata(DataTable dTable, string colName)
    {
        int errIndx = 0;
        Hashtable hTable = new Hashtable();
        Hashtable hTable1 = new Hashtable();
        ArrayList duplicateList = new ArrayList();
        ArrayList duplicateList1 = new ArrayList();

        foreach (DataRow drow in dTable.Rows)
        {
            if (hTable.Contains(drow[colName]))
                duplicateList.Add(drow);
            else
            {
                hTable.Add(drow[colName], string.Empty);
            }
        }

        foreach (DataRow dRow in duplicateList)
        {
            dr_error = dt_error.NewRow();

            if (colName.ToLower() == "area code" || colName.ToLower() == "area name")
            {
                dr_error["Excel_RowNo"] = "";
                dr_error["area_code"] = dRow[0];
                if (colName.ToLower() == "area code")
                {
                    dr_error["Remark"] = "Multiple Entry With Same Area code is found In Excel";
                }
                else if (colName == "area name")
                {
                    dr_error["Remark"] = "Multiple Entry With Same Area name is found In Excel";
                }
            }

            if (colName.ToLower() == "user id" || colName.ToLower() == "EMail ID")
            {
                dr_error["Excel_RowNo"] = "";
                dr_error["User_Id"] = dRow[0];
                if (colName.ToLower() == "user id")
                {
                    dr_error["Remark"] = "Multiple Entry With Same User Id is found In Excel";
                }
                else if (colName == "EMail ID")
                {
                    dr_error["Remark"] = "Multiple Entry With Same Email Id is found In Excel";
                }
            }

            dt_error.Rows.Add(dr_error);
        }

        return dt_error;
    }

    #region retrieve Get Data

    [WebMethod(EnableSession = true)]
    public string Get_time_table_data_for_student(string start_date, string end_date)
    {


        string semester = "";
        HttpContext.Current.Session["start_date"] = start_date;
        HttpContext.Current.Session["end_date"] = end_date;

        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();

        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }


        DataTable time_table_data = objmaster.Get_time_table_data_for_student(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        DataTable time_table_data_before_allocation = objmaster.Get_time_table_data_for_student_befor_allocation(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        if (time_table_data != null)
        {
            jsondata = GetJson1(time_table_data);
        }
        else
        {
            if (time_table_data_before_allocation != null)
            {
                jsondata = GetJson1(time_table_data_before_allocation);
            }
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string Get_course_data_for_student_selection()
    {
        DataTable course_data = objmaster.Get_course_data_for_student_selection();

        DataTable dt_mandatory = objmaster.Get_mandatory_course_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        DataTable dt_mandatory_instructor = objmaster.Get_mandatory_instructor_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        DataTable dt_mandatory_time_day = objmaster.Get_mandatory_time_days_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        DataTable dt_mandatory_area = objmaster.Get_mandatory_Area_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());






        if (course_data != null)
        {
            jsondata = GetJson1(course_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string get_saved_credit_choice_data()
    {
        string semester = "";
        if (HttpContext.Current.Session["semester_code"] != null)
        {
            semester = HttpContext.Current.Session["semester_code"].ToString();
        }



        DataTable dt = objmaster.check_credit_choice_by_student(semester, HttpContext.Current.Session["year_code"].ToString(), HttpContext.Current.Session["UserId"].ToString(), "");




        if (dt != null)
        {
            jsondata = GetJson1(dt);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string get_current_sem_data_for_student(string sem_code, string year_code, string dept_code)
    {


        DataTable dt = objmaster.check_credit_choice_by_student(sem_code, year_code, "", dept_code);




        if (dt != null)
        {
            jsondata = GetJson1(dt);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string get_user_data_for_pay_slip()
    {

        int re = 0;

        if (current_round != "1")
        {
            //if (current_round != "")
            //{

            //    DataTable dt = objmaster.get_student_for_next_round_registration(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString(), current_round);

            //    if (dt != null)
            //    {
            //        if (dt.Rows[0]["user_id"].ToString() == HttpContext.Current.Session["UserId"].ToString())
            //        {
            //            re = 1;
            //        }
            //    }
            //}
        }
        else
        {

            //if (HttpContext.Current.Session["dept_code"].ToString() == "7")
            //{
            //    re = 1;
            //}

            //if (HttpContext.Current.Session["dept_code"].ToString() == "1" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
            //{
            //    re = 1;
            //}

            //if (HttpContext.Current.Session["dept_code"].ToString() == "2" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
            //{
            //    re = 1;
            //}
        }

        if (re == 0)
        {
            return "Registration has been closed";
        }


        string semester = "";

        if (HttpContext.Current.Session["semester_code"] != null)
        {
            semester = HttpContext.Current.Session["semester_code"].ToString();
        }



        DataTable mandatory_time_day_data = objmaster.get_user_data_for_pay_slip(HttpContext.Current.Session["UserId"].ToString(), semester);

        if (mandatory_time_day_data != null)
        {
            jsondata = GetJson1(mandatory_time_day_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string[] get_saved_registerd_course()
    {
        string[] data = new string[2];
        string sem_code = "";
        string json = "";

        //DataTable dt = objmaster.check_credit_choice_by_student("", "", student, "");

        //if (dt != null)
        //{
        //    sem_code = dt.Rows[0]["semester_code"].ToString();
        //}
        //else
        //{
        //    return null;
        //}



        DataTable get_student_data = objmaster.Get_student_saved_current_sem_data_report(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        if (get_student_data != null)
        {
            jsondata = GetJson1(get_student_data);
        }

        DataTable get_assigned_data = objmaster.Get_student_assigned_current_sem_data_report_for_drop_course(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());
        if (get_assigned_data != null)
        {
            json = GetJson1(get_assigned_data);
        }


        data[0] = jsondata;
        data[1] = json;

        return data;
    }

    [WebMethod(EnableSession = true)]
    public string[] get_saved_registerd_course_for_drop_course(string flag)
    {
        string[] data = new string[2];
        string sem_code = "";
        string json = "";
        DataTable get_assigned_data = null;

        //DataTable dt = objmaster.check_credit_choice_by_student("", "", student, "");

        //if (dt != null)
        //{
        //    sem_code = dt.Rows[0]["semester_code"].ToString();
        //}
        //else
        //{
        //    return null;
        //}



        DataTable get_student_data = objmaster.Get_student_saved_current_sem_data_report(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        if (get_student_data != null)
        {
            jsondata = GetJson1(get_student_data);
        }

        if (flag == "C")
        {
            get_assigned_data = objmaster.Get_student_assigned_current_sem_data_report(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());
        }
        else
        {
            get_assigned_data = objmaster.Get_student_assigned_current_sem_data_report_for_drop_course(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        }

        if (get_assigned_data != null)
        {
            json = GetJson1(get_assigned_data);
        }


        data[0] = jsondata;
        data[1] = json;

        return data;
    }

    [WebMethod]
    public string Get_selected_transaction_data(string transaction_id)
    {

        DataTable dt_trasaction_data = objmaster.Get_selected_transaction_data(transaction_id);

        if (dt_trasaction_data != null)
        {
            if (dt_trasaction_data.Rows[0]["payment_transaction_reference_id"].ToString() != "")
            {
                return "already";
            }

            jsondata = GetJson1(dt_trasaction_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_Non_cept_registered_student(string sem_code, string year_code, string dept_code)
    {
        DataTable get_data = objmaster.get_Non_cept_registered_student(sem_code, year_code, dept_code);

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_student_passport_detail(string dept_code)
    {
        DataTable get_data = objmaster.get_student_passport_detail(dept_code);

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_total_allocate_seats_and_total_course_seats_data(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.get_total_allocate_seats_and_total_course_seats_data(sem_code, year_code);

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    #region Generel Methods

    [WebMethod]
    public string Get_faculty_data()
    {
        DataTable course_data = objmaster.Get_faculty_data();

        if (course_data != null)
        {
            jsondata = GetJson1(course_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_semester_data()
    {
        DataTable course_data = objmaster.Get_semester_data();

        if (course_data != null)
        {
            jsondata = GetJson1(course_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_department_data()
    {
        DataTable Get_department_data = objmaster.Get_department_data();

        if (Get_department_data != null)
        {
            jsondata = GetJson1(Get_department_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_year_data()
    {
        DataTable Get_year_data = objmaster.Get_year_data();

        if (Get_year_data != null)
        {
            jsondata = GetJson1(Get_year_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string get_all_student_data()
    {
        DataTable get_student_data = objmaster.get_all_student_data();

        if (get_student_data != null)
        {
            jsondata = GetJson1(get_student_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_student_data(string year_code, string dept_code, string prog_code)
    {
        DataTable Get_student_data = objmaster.Get_student_data_new(year_code, dept_code, prog_code);

        if (Get_student_data != null)
        {
            jsondata = GetJson1(Get_student_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_course_wise_instructor_data(string sem_code, string year_code, string course_code)
    {
        DataTable course_data = objmaster.Get_course_wise_instructor_data_for_feedback(sem_code, year_code, course_code);

        if (course_data != null)
        {
            jsondata = GetJson1(course_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_course_data(string sem_code, string year_code)
    {
        DataTable course_data = objmaster.Get_all_course_data(sem_code, year_code);

        if (course_data != null)
        {
            jsondata = GetJson1(course_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string GetAllDataForSWSFeedBack(string sem_code, string year_code, string dept_code)
    {
        DataTable course_data = objmaster.GetAllDataForSWSFeedBack(sem_code, year_code, dept_code);


        if (course_data != null)
        {
            string semester = "";
            string dep_name = "";
            if (sem_code == "S")
            {
                semester = "Summer";
            }
            else
            {
                semester = "Winter";
            }
            course_data.Columns.Add("pdfstatus");
            for (int i = 0; i < course_data.Rows.Count; i++)
            {

                switch (course_data.Rows[i]["dept_name"].ToString())
                {
                    case "Architecture":
                        dep_name = "FA";
                        break;
                    case "Design":
                        dep_name = "FD";
                        break;
                    case "Management":
                        dep_name = "FM";
                        break;
                    case "Planning":
                        dep_name = "FP";
                        break;
                    case "Technology":
                        dep_name = "FT";
                        break;
                    case "CEPT Foundation Program":
                        dep_name = "CFP";
                        break;
                    case "Doctoral Programs":
                        dep_name = "DP";
                        break;
                    default:
                        dep_name = "CFP";
                        break;

                }
                string filename = dep_name + "_" + course_data.Rows[i]["course_code"].ToString() + "_" + course_data.Rows[i]["instructor_name"].ToString().Replace("'", " ") + "_" + semester + "_" + year_code + ".pdf";
                if (File.Exists(Server.MapPath("~/SWSFeedbackPdf") + "\\" + filename))
                {
                    course_data.Rows[i]["pdfstatus"] = "Y";

                }
                else
                {
                    course_data.Rows[i]["pdfstatus"] = "N";
                }
            }
            jsondata = GetJson1(course_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_ws_course_data()
    {
        DataTable course_data = objmaster.Get_ws_all_course_data();

        if (course_data != null)
        {
            jsondata = GetJson1(course_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string get_ws_credit_choice()
    {
        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();

        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        DataTable get_data = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString());

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_country_data()
    {
        DataTable Get_country_data = objmaster.Get_country_data();

        if (Get_country_data != null)
        {
            jsondata = GetJson1(Get_country_data);
        }
        return jsondata;
    }

    //public static bool isEmail(string inputEmail)
    //{
    //    inputEmail = NulltoString(inputEmail);
    //    string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
    //          @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
    //          @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
    //    Regex re = new Regex(strRegex);
    //    if (re.IsMatch(inputEmail))
    //        return (true);
    //    else
    //        return (false);
    //} 

    #endregion

    #region mendatory methods

    [WebMethod(EnableSession = true)]
    public string Get_mandatory_course_data_for_student()
    {



        DataTable dt_saved_data = null;

        DataTable dt_mandatory = objmaster.Get_mandatory_course_data_for_student_new(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["prog_level_code"].ToString());

        DataTable dt_mandatory_instructor = objmaster.Get_mandatory_instructor_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        DataTable dt_mandatory_time_day = objmaster.Get_mandatory_time_days_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        DataTable dt_mandatory_area = objmaster.Get_mandatory_Area_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        //  DataTable dt_saved_data = objmaster.Get_saved_student_course_data(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        if (dt_mandatory != null)
        {


            for (int i = 0; i < dt_mandatory.Rows.Count; i++)
            {
                Ds_Student_Course_detail_WS.student_mandatory_courseRow student_mandatory = obj_student.student_mandatory_course.Newstudent_mandatory_courseRow();

                string course_code = dt_mandatory.Rows[i]["course_code"].ToString();
                student_mandatory.course_code = dt_mandatory.Rows[i]["course_code"].ToString();
                student_mandatory.course_name = dt_mandatory.Rows[i]["course_name"].ToString();
                student_mandatory.semester = dt_mandatory.Rows[i]["semester_code"].ToString();
                student_mandatory.credits = dt_mandatory.Rows[i]["course_credits"].ToString();
                student_mandatory.course_desc = dt_mandatory.Rows[i]["course_desc"].ToString();
                student_mandatory.prerequisite = dt_mandatory.Rows[i]["prerequisite"].ToString();

                if (dt_saved_data != null)
                {
                    DataRow[] dr = dt_saved_data.Select("course_code = '" + course_code + "' and course_type = 'M'");

                    if (dr.Length > 0)
                    {
                        if (dr[0]["doc_no"] != "")
                        {
                            student_mandatory.doc_no = dr[0]["doc_no"].ToString();
                        }
                    }
                }



                string instructor = "";
                string course_time = "";
                string time1 = "";
                string timing = "";
                string day = "";
                string area = "";
                string course_day = "";
                string day1 = "";


                if (dt_mandatory_instructor != null)
                {
                    DataRow[] dr_instructor = dt_mandatory_instructor.Select("course_code = '" + course_code + "'");

                    if (dr_instructor.Length > 0 && dr_instructor != null)
                    {
                        for (int j = 0; j < dr_instructor.Length; j++)
                        {
                            instructor += dr_instructor[j]["instructor_name"].ToString() + ", ";
                        }
                        if (instructor != String.Empty)
                        {
                            //student_mandatory.instructor = instructor.Substring(0, instructor.Length - 1);
                            student_mandatory.instructor = instructor.Trim().TrimEnd(',');
                        }

                    }
                }

                if (dt_mandatory_time_day != null)
                {
                    DataRow[] dr_time = dt_mandatory_time_day.Select("course_code = '" + course_code + "'");

                    if (dr_time.Length > 0 && dr_time != null)
                    {
                        for (int j = 0; j < dr_time.Length; j++)
                        {
                            timing = dr_time[j]["time"].ToString();

                            course_day = dr_time[j]["day_name"].ToString();

                            if (timing != time1 || course_day != day1)
                            {
                                course_time += dr_time[j]["time"].ToString() + ", ";

                            }
                            day += dr_time[j]["day_name"].ToString() + ", ";
                            time1 = dr_time[j]["time"].ToString();
                            day1 = dr_time[j]["day_name"].ToString();

                        }
                        if (course_time != String.Empty)
                        {
                            //student_mandatory.time = course_time.Substring(0, course_time.Length - 1);
                            student_mandatory.time = course_time.Trim().TrimEnd(',');
                        }
                        if (day != String.Empty)
                        {
                            //student_mandatory.days = day.Substring(0, day.Length - 1);
                            student_mandatory.days = day.Trim().TrimEnd(',');
                        }
                    }
                }

                if (dt_mandatory_area != null)
                {
                    DataRow[] dr_area = dt_mandatory_area.Select("course_code = '" + course_code + "'");

                    if (dr_area.Length > 0 && dr_area != null)
                    {
                        for (int j = 0; j < dr_area.Length; j++)
                        {
                            area += dr_area[j]["area_name"].ToString() + ",";
                        }
                        if (area != String.Empty)
                            student_mandatory.area = area.Substring(0, area.Length - 1);
                    }
                }

                obj_student.student_mandatory_course.Addstudent_mandatory_courseRow(student_mandatory);

            }
        }
        else
        {
            return "There are no mandatory courses available";
        }

        DataTable dt = obj_student.student_mandatory_course;

        if (dt != null)
        {
            jsondata = GetJson1(dt);
        }
        return jsondata;
        //    }
        //    else
        //    {
        //        return "fees not found";
        //    }
        //}
        //else
        //{

        //    return "fees not found";
        //}
    }

    [WebMethod(EnableSession = true)]
    public string Get_mandatory_time_day_data()
    {
        DataTable mandatory_time_day_data = objmaster.Get_mandatory_time_days_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        if (mandatory_time_day_data != null)
        {
            jsondata = GetJson1(mandatory_time_day_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string Get_saved_student_course_data()
    {
        string semester = "";

        if (HttpContext.Current.Session["semester_code"] != null)
        {
            semester = HttpContext.Current.Session["semester_code"].ToString();
        }

        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }


        DataTable get_saved_data = objmaster.Get_saved_student_course_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        if (get_saved_data != null)
        {
            jsondata = GetJson1(get_saved_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string Get_student_current_sem_data()
    {
        DataTable get_saved_data = objmaster.Get_student_current_sem_data(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        if (get_saved_data != null)
        {
            jsondata = GetJson1(get_saved_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string Get_student_saved_current_sem_data()
    {
        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }


        DataTable get_saved_data = objmaster.Get_student_saved_current_sem_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        if (get_saved_data != null)
        {
            jsondata = GetJson1(get_saved_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string[] Get_student_assigned_current_sem_data()
    {
        DataTable dt_already_published = objmaster.get_publish_allocation_data(current_ws_sem, current_ws_year);

        if (dt_already_published != null)
        {
            if (dt_already_published.Rows.Count > 0)
            {
                if (dt_already_published.Rows[0]["publish_flag"].ToString() == "Y")
                {

                    DataTable get_saved_data = objmaster.Get_student_assigned_current_sem_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

                    if (get_saved_data != null)
                    {
                        json_array[0] = GetJson1(get_saved_data);
                    }

                    DataTable get_allocation_agree_data = objmaster.Get_student_assigned_agree_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

                    if (get_allocation_agree_data != null)
                    {
                        json_array[1] = GetJson1(get_allocation_agree_data);
                    }

                }
                else
                {

                }
            }
            else
            {

            }

        }
        return json_array;
    }

    #endregion

    #region elective methods

    //[WebMethod(EnableSession = true)]
    //public string Get_elective_course_data_for_student()
    //{
    //    //  DataTable course_data = objmaster.Get_course_data_for_student_selection();

    //    //DataTable fees_status = objmaster.Get_fees_status_for_student(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

    //    //if (fees_status != null)
    //    //{

    //    //    if (fees_status.Rows[0]["fees_status"].ToString() == "H" || fees_status.Rows[0]["fees_status"].ToString() == "F")
    //    //    {


    //    string prof_details = "";

    //    if (HttpContext.Current.Session["prof_details"] != null)
    //    {
    //        prof_details = HttpContext.Current.Session["prof_details"].ToString();
    //    }

    //    DataTable dt_elective = objmaster.Get_ws_course_mst_data(current_ws_sem, current_ws_year, prof_details, current_round);

    //    //DataTable dt_elective_instructor = objmaster.Get_elective_instructor_data_for_student_new1(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["prog_level_code"].ToString());

    //    //DataTable dt_elective_time_day = objmaster.Get_elective_time_days_data_for_student_new1(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["prog_level_code"].ToString());

    //    //DataTable dt_elective_area = objmaster.Get_elective_Area_data_for_student_new1(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["prog_level_code"].ToString());

    //    //DataTable dt_saved_data = objmaster.Get_saved_student_course_data(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

    //    //   ServerLog.Log("Start method");

    //    DataTable dt_elective_instructor = objmaster.Get_ws_course_wise_instructor_data(current_ws_sem, current_ws_year);

    //    DataTable dt_elective_time_day = objmaster.Get_ws_course_wise_time_data(current_ws_sem, current_ws_year);

    //    DataTable dt_elective_area = null;


    //    DataTable total_allocate_seats_data = objmaster.Get_total_allocate_course_for_second_round(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

    //    DataTable dt_saved_data = objmaster.Get_saved_student_course_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);
    //    DataRow[] dr_total_allocate_data = null;
    //    int total_allocate_course = 0;
    //    int available_seats = 0;
    //    if (dt_elective != null)
    //    {


    //        for (int i = 0; i < dt_elective.Rows.Count; i++)
    //        {

    //            string course_code = dt_elective.Rows[i]["course_code"].ToString();
    //            total_allocate_course = 0;

    //            if (course_code == "S15FA005")
    //            {

    //            }

    //            available_seats = Convert.ToInt16(dt_elective.Rows[i]["available_seat"].ToString());

    //            if (total_allocate_seats_data != null)
    //            {
    //                dr_total_allocate_data = total_allocate_seats_data.Select("course_code = '" + course_code + "'");

    //                if (dr_total_allocate_data.Length > 0)
    //                {
    //                    total_allocate_course = Convert.ToInt16(dr_total_allocate_data[0]["total_course"]);

    //                }
    //            }

    //            if (total_allocate_course < available_seats)
    //            {

    //                Ds_Student_Course_detail.student_elective_courseRow student_elective = obj_student.student_elective_course.Newstudent_elective_courseRow();

    //                string instructor = "";
    //                string course_time = "";
    //                string time1 = "";
    //                string timing = "";
    //                string day = "";
    //                string area = "";
    //                string day1 = "";
    //                string course_day = "";
    //                string date = "";
    //                string date1 = "";
    //                string course_date = "";


    //                if (dt_elective_area != null)
    //                {

    //                    DataRow[] dr = dt_elective_area.Select("course_code = '" + course_code + "' and area_code = '33' ");


    //                    DataRow[] dr1 = dt_elective_area.Select("course_code = '" + course_code + "' and area_code = '11' ");

    //                    DataRow[] dr2 = dt_elective_area.Select("course_code = '" + course_code + "' and area_code = '34' ");

    //                    if (dr.Length > 0 && dr != null)
    //                    {
    //                        continue;
    //                    }
    //                    else
    //                    {

    //                        if (dr1.Length > 0 && dr1 != null)
    //                        {
    //                            continue;
    //                        }
    //                        else
    //                        {
    //                            if (dr2.Length > 0 && dr2 != null)
    //                            {
    //                                continue;
    //                            }
    //                            else
    //                            {

    //                                student_elective.department = dt_elective.Rows[i]["dept_name"].ToString();
    //                                student_elective.course_code = dt_elective.Rows[i]["course_code"].ToString();
    //                                student_elective.course_name = dt_elective.Rows[i]["course_name"].ToString();
    //                                student_elective.semester = dt_elective.Rows[i]["semester_code"].ToString();
    //                                student_elective.credits = dt_elective.Rows[i]["course_credits"].ToString();
    //                                student_elective.course_desc = dt_elective.Rows[i]["course_desc"].ToString();
    //                                student_elective.prerequisite = dt_elective.Rows[i]["prerequisite"].ToString();
    //                                student_elective.prerequisite_for_prof = dt_elective.Rows[i]["prerequisite_for_prof"].ToString();
    //                                student_elective.available_seats = Convert.ToString(Convert.ToDecimal(available_seats) - Convert.ToDecimal(total_allocate_course));

    //                                if (dt_saved_data != null)
    //                                {
    //                                    DataRow[] dr_elec = dt_saved_data.Select("course_code = '" + course_code + "' and course_type = 'E' and dept_code ='" + dt_elective.Rows[i]["dept_code"].ToString() + "'");

    //                                    if (dr_elec.Length > 0)
    //                                    {
    //                                        if (dr_elec[0]["doc_no"].ToString() != "")
    //                                        {
    //                                            student_elective.doc_no = dr_elec[0]["doc_no"].ToString();
    //                                        }

    //                                    }
    //                                }



    //                                DataRow[] dr_area = dt_elective_area.Select("course_code = '" + course_code + "' ");


    //                                for (int j = 0; j < dr_area.Length; j++)
    //                                {
    //                                    area += dr_area[j]["area_name"].ToString() + ", ";
    //                                }
    //                                if (area != String.Empty)
    //                                    student_elective.area = area.Trim().TrimEnd(',');

    //                            }
    //                        }

    //                    }
    //                }
    //                else
    //                {
    //                    student_elective.department = dt_elective.Rows[i]["dept_name"].ToString();
    //                    student_elective.course_code = dt_elective.Rows[i]["course_code"].ToString();
    //                    student_elective.course_name = dt_elective.Rows[i]["course_name"].ToString();
    //                    //  student_elective.semester = dt_elective.Rows[i]["semester_code"].ToString();
    //                    student_elective.credits = dt_elective.Rows[i]["course_credits"].ToString();
    //                    //  student_elective.course_desc = dt_elective.Rows[i]["course_desc"].ToString();
    //                    //   student_elective.prerequisite = dt_elective.Rows[i]["prerequisite"].ToString();
    //                    student_elective.fees = dt_elective.Rows[i]["fees"].ToString();
    //                    student_elective.prof_fees = dt_elective.Rows[i]["prof_fees"].ToString();
    //                    student_elective.available_seats = Convert.ToString(Convert.ToDecimal(available_seats) - Convert.ToDecimal(total_allocate_course));
    //                    student_elective.image_name = dt_elective.Rows[i]["image_name"].ToString();

    //                    student_elective.prerequisite = dt_elective.Rows[i]["prerequisite"].ToString();
    //                    student_elective.prerequisite_for_prof = dt_elective.Rows[i]["prerequisite_for_prof"].ToString();


    //                    if (dt_saved_data != null)
    //                    {
    //                        DataRow[] dr_elec = dt_saved_data.Select("course_code = '" + course_code + "' and course_type = 'E' and dept_code ='" + dt_elective.Rows[i]["dept_code"].ToString() + "'");

    //                        if (dr_elec.Length > 0)
    //                        {
    //                            if (dr_elec[0]["doc_no"].ToString() != "")
    //                            {
    //                                student_elective.doc_no = dr_elec[0]["doc_no"].ToString();
    //                            }

    //                        }
    //                    }
    //                    //if (dr.Length > 0)
    //                    //{
    //                    //    if (dr[0]["doc_no"] != "")
    //                    //    {
    //                    //        student_mandatory.doc_no = dr[0]["doc_no"].ToString();
    //                    //    }
    //                    //}
    //                }

    //                if (dt_elective_instructor != null)
    //                {
    //                    DataRow[] dr_instructor = dt_elective_instructor.Select("course_code = '" + course_code + "'");

    //                    if (dr_instructor.Length > 0 && dr_instructor != null)
    //                    {
    //                        for (int j = 0; j < dr_instructor.Length; j++)
    //                        {
    //                            instructor += dr_instructor[j]["instructor_name"].ToString() + ", ";
    //                        }
    //                        if (instructor != String.Empty)
    //                            student_elective.instructor = instructor.Trim().TrimEnd(',');
    //                    }
    //                }

    //                if (dt_elective_time_day != null)
    //                {
    //                    ServerLog.Log("dt_elective_time_day is not null");
    //                    DataRow[] dr_time = dt_elective_time_day.Select("course_code = '" + course_code + "'", "date ASC");

    //                    if (dr_time.Length > 0 && dr_time != null)
    //                    {
    //                        ServerLog.Log("dr_time is not null " + dr_time.Length);
    //                        for (int j = 0; j < dr_time.Length; j++)
    //                        {
    //                            ServerLog.Log("For Loop");

    //                            ServerLog.Log("" + j);

    //                            timing = dr_time[j]["time"].ToString();
    //                            course_day = dr_time[j]["day_name"].ToString();
    //                            date = dr_time[j]["date"].ToString();

    //                            if (timing != time1 || date != date1)
    //                            {
    //                                course_time += dr_time[j]["time"].ToString() + ", ";

    //                            }

    //                            //if (date != date1)
    //                            //{
    //                            if (date != date1)
    //                            {
    //                                if (dr_time[j]["city_name"].ToString() != "")
    //                                {
    //                                    course_date += dr_time[j]["date"].ToString() + "(" + dr_time[j]["city_name"].ToString() + ")" + ", ";
    //                                }
    //                                else
    //                                {
    //                                    course_date += dr_time[j]["date"].ToString() + ", ";
    //                                }
    //                            }



    //                            //  }

    //                            day += dr_time[j]["day_name"].ToString() + ", ";
    //                            date1 = dr_time[j]["date"].ToString();
    //                            time1 = dr_time[j]["time"].ToString();
    //                            day1 = dr_time[j]["day_name"].ToString();

    //                        }
    //                        if (course_time != String.Empty)
    //                            student_elective.time = course_time.Trim().TrimEnd(',');
    //                        if (day != String.Empty)
    //                            student_elective.days = day.Trim().TrimEnd(',');
    //                        if (course_date != String.Empty)
    //                            student_elective.date = course_date.Trim().TrimEnd(',');


    //                    }
    //                }
    //                else
    //                {
    //                    ServerLog.Log("dt_elective_time_day is  null");
    //                }




    //                obj_student.student_elective_course.Addstudent_elective_courseRow(student_elective);
    //            }
    //        }



    //        DataTable dt = obj_student.student_elective_course;

    //        DataTable dtOut = null;
    //        dt.DefaultView.Sort = "course_code";
    //        dtOut = dt.DefaultView.ToTable();

    //        if (dtOut.Rows.Count > 0)
    //        {
    //            jsondata = GetJson1(dtOut);
    //        }
    //        else
    //        {
    //            return "no data";
    //        }
    //    }
    //    else
    //    {
    //        return "no data";
    //    }

    //    //  }
    //    //    else
    //    //    {
    //    //        return "fees not found";
    //    //    }
    //    //}
    //    //else
    //    //{
    //    //    return "fees not found";
    //    //}
    //    return jsondata;
    //}

    [WebMethod(EnableSession = true)]
    public string Get_elective_course_data_for_student()
    {
        //  DataTable course_data = objmaster.Get_course_data_for_student_selection();

        //DataTable fees_status = objmaster.Get_fees_status_for_student(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        //if (fees_status != null)
        //{

        //    if (fees_status.Rows[0]["fees_status"].ToString() == "H" || fees_status.Rows[0]["fees_status"].ToString() == "F")
        //    {


        string prof_details = "";

        if (HttpContext.Current.Session["prof_details"] != null)
        {
            prof_details = HttpContext.Current.Session["prof_details"].ToString();
        }

        DataTable dt_elective = objmaster.Get_ws_course_mst_data(current_ws_sem, current_ws_year, prof_details, current_round);

        //DataTable dt_elective_instructor = objmaster.Get_elective_instructor_data_for_student_new1(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["prog_level_code"].ToString());

        //DataTable dt_elective_time_day = objmaster.Get_elective_time_days_data_for_student_new1(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["prog_level_code"].ToString());

        //DataTable dt_elective_area = objmaster.Get_elective_Area_data_for_student_new1(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["prog_level_code"].ToString());

        //DataTable dt_saved_data = objmaster.Get_saved_student_course_data(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

        //   ServerLog.Log("Start method");

        DataTable dt_elective_instructor = objmaster.Get_ws_course_wise_instructor_data(current_ws_sem, current_ws_year);

        DataTable dt_elective_time_day = objmaster.Get_ws_course_wise_time_data(current_ws_sem, current_ws_year);

        DataTable dt_elective_area = null;


        DataTable total_allocate_seats_data = objmaster.Get_total_allocate_course_for_second_round(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        DataTable dt_saved_data = objmaster.Get_saved_student_course_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);
        DataRow[] dr_total_allocate_data = null;
        int total_allocate_course = 0;
        int available_seats = 0;
        if (dt_elective != null)
        {


            for (int i = 0; i < dt_elective.Rows.Count; i++)
            {

                string course_code = dt_elective.Rows[i]["course_code"].ToString();
                total_allocate_course = 0;

                if (course_code == "S15FA005")
                {

                }

                available_seats = Convert.ToInt16(dt_elective.Rows[i]["available_seat"].ToString());

                if (total_allocate_seats_data != null)
                {
                    dr_total_allocate_data = total_allocate_seats_data.Select("course_code = '" + course_code + "'");

                    if (dr_total_allocate_data.Length > 0)
                    {
                        total_allocate_course = Convert.ToInt16(dr_total_allocate_data[0]["total_course"]);

                    }
                }

                if (total_allocate_course < available_seats)
                {

                    Ds_Student_Course_detail_WS.student_elective_courseRow student_elective = obj_student.student_elective_course.Newstudent_elective_courseRow();

                    string instructor = "";
                    string course_time = "";
                    string time1 = "";
                    string timing = "";
                    string day = "";
                    string area = "";
                    string day1 = "";
                    string course_day = "";
                    string date = "";
                    string date1 = "";
                    string course_date = "";


                    if (dt_elective_area != null)
                    {

                        DataRow[] dr = dt_elective_area.Select("course_code = '" + course_code + "' and area_code = '33' ");


                        DataRow[] dr1 = dt_elective_area.Select("course_code = '" + course_code + "' and area_code = '11' ");

                        DataRow[] dr2 = dt_elective_area.Select("course_code = '" + course_code + "' and area_code = '34' ");

                        if (dr.Length > 0 && dr != null)
                        {
                            continue;
                        }
                        else
                        {

                            if (dr1.Length > 0 && dr1 != null)
                            {
                                continue;
                            }
                            else
                            {
                                if (dr2.Length > 0 && dr2 != null)
                                {
                                    continue;
                                }
                                else
                                {

                                    student_elective.department = dt_elective.Rows[i]["dept_name"].ToString();
                                    student_elective.course_code = dt_elective.Rows[i]["course_code"].ToString();
                                    student_elective.course_name = dt_elective.Rows[i]["course_name"].ToString();
                                    student_elective.semester = dt_elective.Rows[i]["semester_code"].ToString();
                                    student_elective.credits = dt_elective.Rows[i]["course_credits"].ToString();
                                    student_elective.course_desc = dt_elective.Rows[i]["course_desc"].ToString();
                                    student_elective.prerequisite = dt_elective.Rows[i]["prerequisite"].ToString();
                                    student_elective.prerequisite_for_prof = dt_elective.Rows[i]["prerequisite_for_prof"].ToString();
                                    student_elective.available_seats = Convert.ToString(Convert.ToDecimal(available_seats) - Convert.ToDecimal(total_allocate_course));
                                    student_elective.is_international_travel_course = dt_elective.Rows[i]["is_international_travel_course"].ToString();

                                    if (dt_saved_data != null)
                                    {
                                        DataRow[] dr_elec = dt_saved_data.Select("course_code = '" + course_code + "' and course_type = 'E' and dept_code ='" + dt_elective.Rows[i]["dept_code"].ToString() + "'");

                                        if (dr_elec.Length > 0)
                                        {
                                            if (dr_elec[0]["doc_no"].ToString() != "")
                                            {
                                                student_elective.doc_no = dr_elec[0]["doc_no"].ToString();
                                            }

                                        }
                                    }



                                    DataRow[] dr_area = dt_elective_area.Select("course_code = '" + course_code + "' ");


                                    for (int j = 0; j < dr_area.Length; j++)
                                    {
                                        area += dr_area[j]["area_name"].ToString() + ", ";
                                    }
                                    if (area != String.Empty)
                                        student_elective.area = area.Trim().TrimEnd(',');

                                }
                            }

                        }
                    }
                    else
                    {
                        student_elective.department = dt_elective.Rows[i]["dept_name"].ToString();
                        student_elective.course_code = dt_elective.Rows[i]["course_code"].ToString();
                        student_elective.course_name = dt_elective.Rows[i]["course_name"].ToString();
                        //  student_elective.semester = dt_elective.Rows[i]["semester_code"].ToString();
                        student_elective.credits = dt_elective.Rows[i]["course_credits"].ToString();
                        //  student_elective.course_desc = dt_elective.Rows[i]["course_desc"].ToString();
                        //   student_elective.prerequisite = dt_elective.Rows[i]["prerequisite"].ToString();
                        student_elective.fees = dt_elective.Rows[i]["fees"].ToString();
                        student_elective.prof_fees = dt_elective.Rows[i]["prof_fees"].ToString();
                        student_elective.available_seats = Convert.ToString(Convert.ToDecimal(available_seats) - Convert.ToDecimal(total_allocate_course));
                        student_elective.image_name = dt_elective.Rows[i]["image_name"].ToString();

                        student_elective.prerequisite = dt_elective.Rows[i]["prerequisite"].ToString();
                        student_elective.prerequisite_for_prof = dt_elective.Rows[i]["prerequisite_for_prof"].ToString();
                        student_elective.is_international_travel_course = dt_elective.Rows[i]["is_international_travel_course"].ToString();


                        if (dt_saved_data != null)
                        {
                            DataRow[] dr_elec = dt_saved_data.Select("course_code = '" + course_code + "' and course_type = 'E' and dept_code ='" + dt_elective.Rows[i]["dept_code"].ToString() + "'");

                            if (dr_elec.Length > 0)
                            {
                                if (dr_elec[0]["doc_no"].ToString() != "")
                                {
                                    student_elective.doc_no = dr_elec[0]["doc_no"].ToString();
                                }

                            }
                        }
                        //if (dr.Length > 0)
                        //{
                        //    if (dr[0]["doc_no"] != "")
                        //    {
                        //        student_mandatory.doc_no = dr[0]["doc_no"].ToString();
                        //    }
                        //}
                    }

                    if (dt_elective_instructor != null)
                    {
                        DataRow[] dr_instructor = dt_elective_instructor.Select("course_code = '" + course_code + "'");

                        if (dr_instructor.Length > 0 && dr_instructor != null)
                        {
                            for (int j = 0; j < dr_instructor.Length; j++)
                            {
                                instructor += dr_instructor[j]["instructor_name"].ToString() + ", ";
                            }
                            if (instructor != String.Empty)
                                student_elective.instructor = instructor.Trim().TrimEnd(',');
                        }
                    }

                    if (dt_elective_time_day != null)
                    {
                        ServerLog.Log("dt_elective_time_day is not null");
                        DataRow[] dr_time = dt_elective_time_day.Select("course_code = '" + course_code + "'", "date ASC");

                        if (dr_time.Length > 0 && dr_time != null)
                        {
                            ServerLog.Log("dr_time is not null " + dr_time.Length);
                            for (int j = 0; j < dr_time.Length; j++)
                            {
                                ServerLog.Log("For Loop");

                                ServerLog.Log("" + j);

                                timing = dr_time[j]["time"].ToString();
                                course_day = dr_time[j]["day_name"].ToString();
                                date = dr_time[j]["date"].ToString();

                                if (timing != time1 || date != date1)
                                {
                                    course_time += dr_time[j]["time"].ToString() + ", ";

                                }

                                //if (date != date1)
                                //{
                                if (date != date1)
                                {
                                    if (dr_time[j]["city_name"].ToString() != "")
                                    {
                                        course_date += dr_time[j]["date"].ToString() + "(" + dr_time[j]["city_name"].ToString() + ")" + ", ";
                                    }
                                    else
                                    {
                                        course_date += dr_time[j]["date"].ToString() + ", ";
                                    }
                                }



                                //  }

                                day += dr_time[j]["day_name"].ToString() + ", ";
                                date1 = dr_time[j]["date"].ToString();
                                time1 = dr_time[j]["time"].ToString();
                                day1 = dr_time[j]["day_name"].ToString();

                            }
                            if (course_time != String.Empty)
                                student_elective.time = course_time.Trim().TrimEnd(',');
                            if (day != String.Empty)
                                student_elective.days = day.Trim().TrimEnd(',');
                            if (course_date != String.Empty)
                                student_elective.date = course_date.Trim().TrimEnd(',');


                        }
                    }
                    else
                    {
                        ServerLog.Log("dt_elective_time_day is  null");
                    }




                    obj_student.student_elective_course.Addstudent_elective_courseRow(student_elective);
                }
            }



            DataTable dt = obj_student.student_elective_course;

            DataTable dtOut = null;
            dt.DefaultView.Sort = "course_code";
            dtOut = dt.DefaultView.ToTable();

            if (dtOut.Rows.Count > 0)
            {
                jsondata = GetJson1(dtOut);
            }
            else
            {
                return "no data";
            }
        }
        else
        {
            return "no data";
        }

        //  }
        //    else
        //    {
        //        return "fees not found";
        //    }
        //}
        //else
        //{

        //    return "fees not found";
        //}
        return jsondata;


    }

    #endregion

    [WebMethod(EnableSession = true)]
    public string Check_time_validation(string mandatory_time, string elective_time, string course_code, string sem_code, string flag)
    {
        // Save Compliance Details in compliance_entry table.

        Masters_WS objmaster = new Masters_WS();

        int re = 0;
        String[] st = new String[6];
        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(mandatory_time);

            List<Dictionary<string, object>> elective_data = ser.Deserialize<List<Dictionary<string, object>>>(elective_time);

            //DataTable dt_mandatory_time_day = objmaster.Get_mandatory_time_days_data_for_student(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["prog_code"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

            DataTable dt_elective_time_day = objmaster.Get_ws_course_wise_time_data_for_check();

            Boolean flag1 = false;

            if (flag == "M")
            {

            }
            else
            {
                if (dt_elective_time_day != null)
                {
                    DataRow[] dr = dt_elective_time_day.Select("course_code = '" + course_code + "'");
                    if (dr.Length > 0 && dr != null)
                    {
                        for (int i = 0; i < elective_data.Count; i++)
                        {
                            if (course_code == elective_data[i]["course_code"].ToString())
                            {

                            }
                            else
                            {
                                DataRow[] dr_check = dt_elective_time_day.Select("course_code='" + elective_data[i]["course_code"].ToString() + "' ");

                                if (dr_check.Length > 0 && dr_check != null)
                                {
                                    for (int j = 0; j < dr.Length; j++)
                                    {
                                        DateTime last_from_date = Convert.ToDateTime(dr[j]["from_date"].ToString());
                                        DateTime last_to_date = Convert.ToDateTime(dr[j]["to_date"].ToString());

                                        string last_from_time = dr[j]["from_time"].ToString();
                                        string last_to_time = dr[j]["to_time"].ToString();
                                        string last_day_code = dr[j]["day_code"].ToString();

                                        for (int k = 0; k < dr_check.Length; k++)
                                        {
                                            DateTime from_date = Convert.ToDateTime(dr_check[k]["from_date"].ToString());
                                            DateTime to_date = Convert.ToDateTime(dr_check[k]["to_date"].ToString());

                                            string from_time = dr_check[k]["from_time"].ToString();
                                            string to_time = dr_check[k]["to_time"].ToString();
                                            string day_code = dr_check[k]["day_code"].ToString();

                                            if (last_from_date.Ticks > from_date.Ticks && last_from_date.Ticks < to_date.Ticks)
                                            {
                                                flag1 = true;
                                            }

                                            else if (last_to_date.Ticks > from_date.Ticks && last_to_date.Ticks < to_date.Ticks)
                                            {
                                                flag1 = true;
                                            }

                                            else if (from_date.Ticks > last_from_date.Ticks && from_date.Ticks < last_to_date.Ticks)
                                            {
                                                flag1 = true;
                                            }

                                            else if (to_date.Ticks > last_from_date.Ticks && to_date.Ticks < last_to_date.Ticks)
                                            {
                                                flag1 = true;
                                            }

                                            else if (last_from_date.Ticks == from_date.Ticks || last_to_date.Ticks == to_date.Ticks)
                                            {
                                                flag1 = true;
                                            }

                                            else if (last_from_date.Ticks == to_date.Ticks || last_to_date.Ticks == from_date.Ticks)
                                            {
                                                flag1 = true;
                                            }

                                            if (flag1 == true)
                                            {
                                                return "ok:This Course code " + course_code + " timing is Conflict with  Course code" + elective_data[i]["course_code"].ToString();

                                                //if (last_day_code == day_code)
                                                //{
                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_from_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                //    {
                                                //        return "ok:This Course code " + course_code + " timing is Conflict with  Course code" + elective_data[i]["course_code"].ToString();
                                                //    }

                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                //    {
                                                //        return "ok:This Course code " + course_code + " timing is Conflict with  Course code" + elective_data[i]["course_code"].ToString();
                                                //    }

                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) == Convert.ToDecimal(from_time.Replace(':', '.')))
                                                //    {
                                                //        return "ok:This Course code " + course_code + " timing is Conflict with  Course code" + elective_data[i]["course_code"].ToString();
                                                //    }

                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) == Convert.ToDecimal(to_time.Replace(':', '.')))
                                                //    {
                                                //        return "ok:This Course code " + course_code + " timing is Conflict with  Course code" + elective_data[i]["course_code"].ToString();
                                                //    }

                                                //    if (Convert.ToDecimal(from_time.Replace(':', '.')) > Convert.ToDecimal(last_from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(to_time.Replace(':', '.')))
                                                //    {
                                                //        return "ok:This Course code " + course_code + " timing is Conflict with  Course code" + elective_data[i]["course_code"].ToString();
                                                //    }
                                                //}
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            return "Error";
        }

        return "";
    }

    #region feedback

    [WebMethod(EnableSession = true)]
    public string Get_student_assigned_current_sem_data_for_feedback()
    {
        BLL.Master.Masters obj_master = new BLL.Master.Masters();
        DataTable cur_sem = obj_master.Get_cept_current_sem_data("ws_feedback");

        string cur_feedback_sem = "";
        string cur_feedback_year = "";

        if (cur_sem != null)
        {
            cur_feedback_sem = cur_sem.Rows[0]["sem_code"].ToString();
            cur_feedback_year = cur_sem.Rows[0]["year_code"].ToString();
        }

        DataTable get_saved_data = objmaster.Get_student_assigned_current_sem_data_for_feedback(HttpContext.Current.Session["UserId"].ToString(), cur_feedback_sem, cur_feedback_year, "''");

        if (get_saved_data != null)
        {
            jsondata = GetJson1(get_saved_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_instructor_code_for_course_code(string course_code)
    {
        BLL.Master.Masters obj_master = new BLL.Master.Masters();
        DataTable cur_sem = obj_master.Get_cept_current_sem_data("ws_feedback");

        string cur_feedback_sem = "";
        string cur_feedback_year = "";

        if (cur_sem != null)
        {
            cur_feedback_sem = cur_sem.Rows[0]["sem_code"].ToString();
            cur_feedback_year = cur_sem.Rows[0]["year_code"].ToString();
        }

        DataTable get_student_data = objmaster.Get_instructor_code_for_course_code(course_code, cur_feedback_sem, cur_feedback_year);

        if (get_student_data != null)
        {
            jsondata = GetJson1(get_student_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string[] Get_instructor_code_for_course_code_for_feedback(string course_code, string course_typology)
    {
        BLL.Master.Masters obj_master = new BLL.Master.Masters();
        DataTable cur_sem = obj_master.Get_cept_current_sem_data("ws_feedback");

        string cur_feedback_sem = "";
        string cur_feedback_year = "";

        if (cur_sem != null)
        {
            cur_feedback_sem = cur_sem.Rows[0]["sem_code"].ToString();
            cur_feedback_year = cur_sem.Rows[0]["year_code"].ToString();
        }

        string[] jsonarry = new string[3];

        DataTable get_student_data = objmaster.Get_instructor_code_for_course_code(course_code, cur_feedback_sem, cur_feedback_year);

        if (get_student_data != null)
        {
            jsonarry[0] = GetJson1(get_student_data);
        }

        DataTable get_feedback_instruction_data = objmaster.Get_feedback_instruction_mst_data(course_typology, cur_feedback_sem, cur_feedback_year);

        if (get_feedback_instruction_data != null)
        {
            jsonarry[1] = GetJson1(get_feedback_instruction_data);
        }

        DataTable get_saved_feedbcak_data = objmaster.Get_student_saved_feedback_data_for_submit(course_code, HttpContext.Current.Session["UserId"].ToString(), cur_feedback_sem, cur_feedback_year);

        if (get_saved_feedbcak_data != null)
        {
            jsonarry[2] = GetJson1(get_saved_feedbcak_data);
        }

        return jsonarry;
    }

    [WebMethod(EnableSession = true)]
    public string Get_feedback_status_report(string sem_code, string year_code)
    {
        DataTable get_student_data = objmaster.Get_feedback_status_report(sem_code, year_code);

        if (get_student_data != null)
        {
            jsondata = GetJson1(get_student_data);
        }

        return jsondata;
    }

    //[WebMethod(EnableSession = true)]
    //public string save_feedback_data(string table_data, string course_aspect, string course_suggestion, string course_travel, string course_travel_suggestion, string course_facility_workshop, string course_aspect_like_studio)
    //{
    //    // Save Compliance Details in compliance_entry table.


    //    int re = 0;

    //    try
    //    {

    //        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
    //        string current_ws_sem = "";
    //        string current_ws_year = "";


    //        if (dt_ws_current_sem != null)
    //        {
    //            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
    //            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
    //        }

    //        JavaScriptSerializer ser = new JavaScriptSerializer();
    //        //Dictionary<string, object> lst = new Dictionary<string, object>();
    //        //lst.Add("Demo", fees_data);

    //        DataTable dt_saved_data = null;

    //        List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(table_data);

    //        if (data.Count > 0)
    //        {
    //            dt_saved_data = objmaster.Get_student_saved_course_feedback_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year, data[0]["course_code"].ToString());
    //        }





    //        if (dt_saved_data == null)
    //        {
    //            for (int i = 0; i < data.Count; i++)
    //            {
    //                DS_Feedback_Save.ws_student_feedback_dtlRow feedboack_data = obj_feedback.ws_student_feedback_dtl.Newws_student_feedback_dtlRow();

    //                //DSC_fees_status.user_fees_statusRow user_fees = obj_fees_status.user_fees_status.Newuser_fees_statusRow();

    //                re = re + i;



    //                //if (dt != null)
    //                //{
    //                //    DataRow[] dr = dt.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

    //                //    if (dr.Length > 0)
    //                //    {
    //                //        user_fees.doc_no = dr[0]["doc_no"].ToString();
    //                //    }
    //                //    else
    //                //    {
    //                //        user_fees.doc_no = re.ToString();
    //                //    }
    //                //}
    //                //else
    //                //{
    //                //    user_fees.doc_no = re.ToString();
    //                //}
    //                feedboack_data.doc_no = re.ToString();
    //                feedboack_data.user_id = HttpContext.Current.Session["UserId"].ToString();
    //                feedboack_data.current_sem_code = "";
    //                feedboack_data.course_code = data[i]["course_code"].ToString();
    //                feedboack_data.course_type = data[i]["course_type"].ToString();
    //                feedboack_data.dept_code = HttpContext.Current.Session["dept_code"].ToString();
    //                feedboack_data.description = data[i]["description"].ToString();
    //                feedboack_data.sr_no = data[i]["sr_no"].ToString();
    //                feedboack_data.instructor_code = data[i]["instructor_code"].ToString();
    //                feedboack_data.instructor_code = data[i]["instructor_code"].ToString();
    //                feedboack_data.strongly_agree = data[i]["strongly_agree"].ToString();

    //                feedboack_data.releted_feedback = data[i]["releted_feedback"].ToString();

    //                feedboack_data.agree = data[i]["agree"].ToString();

    //                feedboack_data.neither_agree = data[i]["neither_agree"].ToString();

    //                feedboack_data.disagree = data[i]["disagree"].ToString();

    //                feedboack_data.strongly_disagree = data[i]["strongly_disagree"].ToString();

    //                feedboack_data.not_applicable = data[i]["not_applicable"].ToString();

    //                feedboack_data.course_aspect = course_aspect;
    //                feedboack_data.course_suggestion = course_suggestion;

    //                feedboack_data.course_travel = course_travel;
    //                feedboack_data.course_travel_suggestion = course_travel_suggestion;

    //                feedboack_data.course_facility_workshop = course_facility_workshop;
    //                feedboack_data.course_aspect_like_studio = course_aspect_like_studio;

    //                feedboack_data.cancel_flag = "N";

    //                feedboack_data.semester_type = current_ws_sem;
    //                feedboack_data.year_semester = current_ws_year;

    //                feedboack_data.created_by = HttpContext.Current.Session["UserId"].ToString();
    //                feedboack_data.created_date = System.DateTime.Now;
    //                feedboack_data.created_host = HttpContext.Current.Request.UserHostName;

    //                ////obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
    //                obj_feedback.ws_student_feedback_dtl.Addws_student_feedback_dtlRow(feedboack_data);

    //            }
    //        }
    //        //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
    //        objBLReturnObject = objMaster.save_feedback_data(obj_feedback, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
    //    }
    //    catch (Exception ex)
    //    {
    //        return "Problem in Save DATA.";
    //    }
    //    return objBLReturnObject.ServerMessage;

    //}

    [WebMethod(EnableSession = true)]
    public string save_feedback_data(string table_data, string course_aspect, string course_suggestion, string submit_status)
    {
        // Save Compliance Details in compliance_entry table.

        int re = 0;

        try
        {
            BLL.Master.Masters obj_master = new BLL.Master.Masters();
            DataTable cur_sem = obj_master.Get_cept_current_sem_data("ws_feedback");

            string cur_feedback_sem = "";
            string cur_feedback_year = "";

            if (cur_sem != null)
            {
                cur_feedback_sem = cur_sem.Rows[0]["sem_code"].ToString();
                cur_feedback_year = cur_sem.Rows[0]["year_code"].ToString();
            }

            //return "Feedback is closed for Winter 2016";

            JavaScriptSerializer ser = new JavaScriptSerializer();
            //Dictionary<string, object> lst = new Dictionary<string, object>();
            //lst.Add("Demo", fees_data);

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(table_data);

            for (int i = 0; i < data.Count; i++)
            {
                //DSC_fees_status.user_fees_statusRow user_fees = obj_fees_status.user_fees_status.Newuser_fees_statusRow();

                re = re + i;

                DataTable get_saved_feedbcak_data = objmaster.Get_student_saved_feedback_data_for_submit(data[i]["course_code"].ToString(), HttpContext.Current.Session["UserId"].ToString(), cur_feedback_sem, cur_feedback_year);

                if (obj_feedback.ws_student_feedback_dtl.Rows.Count > 0)
                {
                    DataRow[] dr_check = obj_feedback.ws_student_feedback_dtl.Select("sr_no = '" + data[i]["sr_no"].ToString() + "' and instructor_code = '" + data[i]["instructor_code"].ToString() + "' and releted_feedback = '" + data[i]["releted_feedback"].ToString() + "'");

                    if (dr_check.Length == 0)
                    {
                        DS_Feedback_Save_WS.ws_student_feedback_dtlRow feedboack_data = obj_feedback.ws_student_feedback_dtl.Newws_student_feedback_dtlRow();

                        feedboack_data.doc_no = re.ToString();
                        feedboack_data.user_id = HttpContext.Current.Session["UserId"].ToString();
                        feedboack_data.current_sem_code = "";
                        feedboack_data.course_code = data[i]["course_code"].ToString();
                        feedboack_data.course_type = data[i]["course_type"].ToString();
                        feedboack_data.dept_code = HttpContext.Current.Session["dept_code"].ToString();
                        feedboack_data.description = data[i]["description"].ToString();
                        feedboack_data.sr_no = data[i]["sr_no"].ToString();
                        feedboack_data.instructor_code = data[i]["instructor_code"].ToString();
                        feedboack_data.instructor_code = data[i]["instructor_code"].ToString();
                        feedboack_data.strongly_agree = data[i]["strongly_agree"].ToString();
                        feedboack_data.comments = data[i]["comments"].ToString();

                        feedboack_data.releted_feedback = data[i]["releted_feedback"].ToString();

                        feedboack_data.agree = data[i]["agree"].ToString();

                        feedboack_data.neither_agree = data[i]["neither_agree"].ToString();

                        feedboack_data.disagree = data[i]["disagree"].ToString();

                        feedboack_data.strongly_disagree = data[i]["strongly_disagree"].ToString();

                        feedboack_data.not_applicable = data[i]["not_applicable"].ToString();

                        feedboack_data.course_aspect = course_aspect;
                        feedboack_data.course_suggestion = course_suggestion;

                        feedboack_data.cancel_flag = "N";

                        feedboack_data.submit_status = submit_status;

                        feedboack_data.semester_type = cur_feedback_sem;
                        feedboack_data.year_semester = cur_feedback_year;

                        if (get_saved_feedbcak_data != null)
                        {
                            feedboack_data.created_by = get_saved_feedbcak_data.Rows[0]["created_by"].ToString();
                            feedboack_data.created_date = Convert.ToDateTime(get_saved_feedbcak_data.Rows[0]["created_date"].ToString());
                            feedboack_data.created_host = get_saved_feedbcak_data.Rows[0]["created_host"].ToString();

                            feedboack_data.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                            feedboack_data.last_modified_date = System.DateTime.Now;
                            feedboack_data.last_modified_host = HttpContext.Current.Request.UserHostName;
                        }
                        else
                        {
                            feedboack_data.created_by = HttpContext.Current.Session["UserId"].ToString();
                            feedboack_data.created_date = System.DateTime.Now;
                            feedboack_data.created_host = HttpContext.Current.Request.UserHostName;
                        }

                        ////obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
                        obj_feedback.ws_student_feedback_dtl.Addws_student_feedback_dtlRow(feedboack_data);
                    }
                }
                else
                {
                    DS_Feedback_Save_WS.ws_student_feedback_dtlRow feedboack_data = obj_feedback.ws_student_feedback_dtl.Newws_student_feedback_dtlRow();

                    feedboack_data.doc_no = re.ToString();
                    feedboack_data.user_id = HttpContext.Current.Session["UserId"].ToString();
                    feedboack_data.current_sem_code = "";
                    feedboack_data.course_code = data[i]["course_code"].ToString();
                    feedboack_data.course_type = data[i]["course_type"].ToString();
                    feedboack_data.dept_code = HttpContext.Current.Session["dept_code"].ToString();
                    feedboack_data.description = data[i]["description"].ToString();
                    feedboack_data.sr_no = data[i]["sr_no"].ToString();
                    feedboack_data.instructor_code = data[i]["instructor_code"].ToString();
                    feedboack_data.instructor_code = data[i]["instructor_code"].ToString();
                    feedboack_data.strongly_agree = data[i]["strongly_agree"].ToString();
                    feedboack_data.comments = data[i]["comments"].ToString();
                    feedboack_data.releted_feedback = data[i]["releted_feedback"].ToString();

                    feedboack_data.agree = data[i]["agree"].ToString();

                    feedboack_data.neither_agree = data[i]["neither_agree"].ToString();

                    feedboack_data.disagree = data[i]["disagree"].ToString();

                    feedboack_data.strongly_disagree = data[i]["strongly_disagree"].ToString();

                    feedboack_data.not_applicable = data[i]["not_applicable"].ToString();

                    feedboack_data.course_aspect = course_aspect;
                    feedboack_data.course_suggestion = course_suggestion;

                    feedboack_data.cancel_flag = "N";

                    feedboack_data.semester_type = cur_feedback_sem;
                    feedboack_data.year_semester = cur_feedback_year;

                    feedboack_data.submit_status = submit_status;

                    if (get_saved_feedbcak_data != null)
                    {
                        feedboack_data.created_by = get_saved_feedbcak_data.Rows[0]["created_by"].ToString();
                        feedboack_data.created_date = Convert.ToDateTime(get_saved_feedbcak_data.Rows[0]["created_date"].ToString());
                        feedboack_data.created_host = get_saved_feedbcak_data.Rows[0]["created_host"].ToString();

                        feedboack_data.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                        feedboack_data.last_modified_date = System.DateTime.Now;
                        feedboack_data.last_modified_host = HttpContext.Current.Request.UserHostName;
                    }
                    else
                    {
                        feedboack_data.created_by = HttpContext.Current.Session["UserId"].ToString();
                        feedboack_data.created_date = System.DateTime.Now;
                        feedboack_data.created_host = HttpContext.Current.Request.UserHostName;
                    }

                    obj_feedback.ws_student_feedback_dtl.Addws_student_feedback_dtlRow(feedboack_data);
                }
            }

            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            objBLReturnObject = objMaster.save_feedback_data(obj_feedback, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
            // return ex.ToString();
        }
        return objBLReturnObject.ServerMessage;
    }

    [WebMethod(EnableSession = true)]
    public string Get_student_saved_feedback_data()
    {
        BLL.Master.Masters obj_master = new BLL.Master.Masters();
        DataTable cur_sem = obj_master.Get_cept_current_sem_data("ws_feedback");

        string cur_feedback_sem = "";
        string cur_feedback_year = "";

        if (cur_sem != null)
        {
            cur_feedback_sem = cur_sem.Rows[0]["sem_code"].ToString();
            cur_feedback_year = cur_sem.Rows[0]["year_code"].ToString();
        }

        DataTable get_saved_data = objmaster.Get_student_saved_feedback_data(HttpContext.Current.Session["UserId"].ToString(), cur_feedback_sem, cur_feedback_year);

        if (get_saved_data != null)
        {
            jsondata = GetJson1(get_saved_data);
        }
        return jsondata;
    }

    #endregion

    #region Fess Status Methods

    [WebMethod]
    public string Get_user_userfees(string dept_code, string sem_code, string year_code, string prog_code)
    {
        DataTable Get_user_userfees = objmaster.Get_user_userfees(dept_code, sem_code, year_code, prog_code);

        if (Get_user_userfees != null)
        {
            jsondata = GetJson1(Get_user_userfees);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_current_WS_sem_year_data()
    {
        DataTable get_data = objmaster.Get_WS_current_sem_data();

        //  DataTable dt = objmaster.Getmymethod("","");

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_ws_user_userfees(string dept_code, string year_code, string prog_code)
    {
        string sem_code = "";
        DataTable Get_ws_user_userfees = objmaster.Get_ws_user_userfees(dept_code, sem_code, year_code, prog_code);

        if (Get_ws_user_userfees != null)
        {
            jsondata = GetJson1(Get_ws_user_userfees);
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_ws_student_fees_saved_data(string dept_code, string year_code)
    {

        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        DataTable Get_ws_student_fees_saved_data = objmaster.Get_ws_student_fees_saved_data(dept_code, year_code, current_ws_sem, current_ws_year);

        if (Get_ws_student_fees_saved_data != null)
        {
            jsondata = GetJson1(Get_ws_student_fees_saved_data);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string Get_fees_status()
    {
        string semester = "";

        if (HttpContext.Current.Session["semester_code"] != null)
        {
            semester = HttpContext.Current.Session["semester_code"].ToString();
        }

        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }


        DataTable fees_status = objmaster.Get_fees_status_for_student(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        if (fees_status != null)
        {
            jsondata = GetJson1(fees_status);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string Get_fees_amount_status()
    {


        string user_id = "";

        string message = "";
        string transaction_id = "";
        decimal amount = 0;

        string dept_code = "";

        Dictionary<string, object> obj_data = new Dictionary<string, object>();


        try
        {


            Dictionary<string, object> param = new Dictionary<string, object>();

            if (HttpContext.Current.Session["UserId"].ToString() != null)
            {
                user_id = HttpContext.Current.Session["UserId"].ToString();
            }


            if (HttpContext.Current.Session["dept_code"].ToString() != null)
            {
                dept_code = HttpContext.Current.Session["dept_code"].ToString();
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Your Faculty is not Found.";

                return JsonConvert.SerializeObject(obj_data);
            }

            if (user_id == "")
            {
                obj_data["status"] = false;
                obj_data["message"] = "User Id not found.please refresh your current page";

                return JsonConvert.SerializeObject(obj_data);
            }

            DataTable dt_check_allocate_data = objmaster.Get_student_assigned_current_sem_data(user_id, current_ws_sem, current_ws_year);

            if (dt_check_allocate_data != null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "You can not Payment your fees Course.Course allocation is already completed for current semester.";

                return JsonConvert.SerializeObject(obj_data);
            }

            DataTable get_data = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, user_id);

            if (get_data == null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "You can not payment your fees.You are not save your choice of credits.";

                return JsonConvert.SerializeObject(obj_data);
            }

            DataTable dt_check_registed_data = objmaster.Get_ws_student_registered(user_id, current_ws_sem, current_ws_year);

            if (dt_check_registed_data != null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "You can not payment your fees.You already registered your Course.";

                return JsonConvert.SerializeObject(obj_data);
            }

            string year_code = "";

            if (HttpContext.Current.Session["year_code"] != null)
            {
                year_code = HttpContext.Current.Session["year_code"].ToString();
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Your year of enrollment is not found in your master.";

                return JsonConvert.SerializeObject(obj_data);
            }



            string prof_details = "";

            if (HttpContext.Current.Session["prof_details"] != null)
            {
                prof_details = HttpContext.Current.Session["prof_details"].ToString();
            }

            DataTable fees_amount = objmaster.Get_fees_amount_for_student(year_code, current_ws_sem, current_ws_year, prof_details);

            decimal fees = 0;

            if (fees_amount != null)
            {
                fees = Convert.ToDecimal(fees_amount.Rows[0]["fees_amount"]);
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Fees is not found for current year and semester";

                return JsonConvert.SerializeObject(obj_data);
            }


            DataTable fees_status = objmaster.Get_fees_status_for_student(user_id, current_ws_sem, current_ws_year);

            if (get_data.Rows[0]["credit_choice"].ToString() != "")
            {
                if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > 12)
                {


                    obj_data["status"] = false;
                    obj_data["message"] = "credit choice is grater than 8 for selected student";

                    return JsonConvert.SerializeObject(obj_data);


                }
                else
                {

                    if (fees_status != null)
                    {

                        if (fees_status.Rows[0]["fees_type"].ToString() == "Y")
                        {
                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
                            {
                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
                                {

                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
                                    {
                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * fees) / 4;
                                    }
                                    else
                                    {
                                        amount = 0;
                                    }
                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees) / 4;
                                }
                            }
                            else
                            {

                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
                                {
                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
                                    {
                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * fees);
                                    }
                                    else
                                    {
                                        amount = 0;
                                    }

                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);
                                }
                            }
                        }
                        else
                        {

                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
                            {
                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
                                {
                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * fees) / 4;
                                }
                                else
                                {

                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees) / 4;
                                }


                            }
                            else
                            {

                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
                                {
                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * fees);
                                }
                                else
                                {

                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);

                                }


                            }
                        }
                    }
                    else
                    {
                        amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);

                    }

                }
            }


            obj_data["status"] = true;
            obj_data["message"] = message;
            obj_data["user_id"] = user_id;

            obj_data["amount"] = amount;


            return JsonConvert.SerializeObject(obj_data);

        }
        catch (Exception ex)
        {
            obj_data["status"] = false;

            obj_data["message"] = "Problem in Retrieve fees data for pay in slip";

            return JsonConvert.SerializeObject(obj_data);
        }



    }

    [WebMethod(EnableSession = true)]
    public string Get_total_credits_for_pay_slip()
    {
        string semester = "";

        if (HttpContext.Current.Session["semester_code"] != null)
        {
            semester = HttpContext.Current.Session["semester_code"].ToString();
        }
        if (true)
        {

        }


        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        DataTable fees_status = objmaster.Get_total_credits_for_pay_slip(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

        if (fees_status != null)
        {
            jsondata = GetJson1(fees_status);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string get_online_payment_transaction_id(string dept_code, string prog_code, string year_code, string sem_code, string year_code_alloc)
    {
        //DataTable dt = objmaster.Get_selected_transaction_data("", "", current_ws_sem, current_ws_year, year_code, dept_code, prog_code);
        DataTable dt = objmaster.Get_selected_transaction_data("", "", sem_code, year_code_alloc, year_code, dept_code, prog_code);

        if (dt != null)
        {
            jsondata = GetJson1(dt);
        }

        return jsondata;
    }

    //[WebMethod]
    //public string get_financial_report_data_SW(string dept_code, string semester, string year_code)
    //{
    //    DataTable get_data = objmaster.get_financial_report_data_WS(dept_code, semester, year_code);

    //    DataTable get_fees_data = objmaster.Get_manually_fees_status_WS(semester, year_code);

    //    DataTable get_fees_amount_pre_credit = objmaster.Get_fees_amount_pre_credit_WS(semester, year_code);

    //    DataTable get_online_fees_data = objmaster.Get_online_fees_status_WS(semester, year_code);

    //    DataTable get_credit_choice_data = objmaster.Get_WS_credit_choice_for_student_for_assign(semester, year_code);

    //    DataTable dt = new DataTable();

    //    dt.Columns.Add("code");
    //    dt.Columns.Add("credit_choice");
    //    dt.Columns.Add("name");
    //    dt.Columns.Add("year_desc");
    //    dt.Columns.Add("department_name");
    //    dt.Columns.Add("program");
    //    dt.Columns.Add("gender");
    //    //    dt.Columns.Add("elective_credits");
    //    dt.Columns.Add("waiver_credits");
    //    //   dt.Columns.Add("total_credits");
    //    dt.Columns.Add("semester_type");
    //    dt.Columns.Add("year_semester");
    //    dt.Columns.Add("fees_status");
    //    dt.Columns.Add("fees_date");
    //    dt.Columns.Add("payment_mode");
    //    dt.Columns.Add("payment_reference");

    //    //dt.Columns.Add("total_credits");

    //    string user_id = "";

    //    DataRow dr;

    //    Decimal total_credits = 0, credit_choice = 0, waiver_credits = 0;


    //    if (get_data != null)
    //    {

    //        for (int i = 0; i < get_data.Rows.Count; i++)
    //        {
    //            credit_choice = 0;
    //            waiver_credits = 0;

    //            string installmant_status = "";

    //            string a = get_data.Rows[i]["user_id"].ToString();

    //            if (a == "W1516000521")
    //            {

    //            }

    //            //    if (user_id != get_data.Rows[i]["user_id"].ToString())
    //            //  {
    //            dr = dt.NewRow();

    //            total_credits = 0;

    //            dr["code"] = get_data.Rows[i]["user_id"].ToString();
    //            dr["name"] = get_data.Rows[i]["user_name"].ToString();
    //            dr["year_desc"] = get_data.Rows[i]["year_desc"].ToString();
    //            dr["department_name"] = get_data.Rows[i]["dept_name"].ToString();
    //            dr["program"] = get_data.Rows[i]["prog_name"].ToString();
    //            dr["gender"] = get_data.Rows[i]["gender"].ToString();
    //            dr["year_semester"] = year_code;
    //            //  dr["elective_credits"] = "0";
    //            if (semester == "W")
    //            {
    //                dr["semester_type"] = "Winter";
    //            }
    //            else
    //            {
    //                dr["semester_type"] = "Summer";
    //            }


    //            DataRow[] dr_fees = get_fees_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

    //            DataRow[] dr_credit_choice = get_credit_choice_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

    //            if (dr_credit_choice.Length > 0)
    //            {
    //                dr["credit_choice"] = dr_credit_choice[0]["credit_choice"];
    //                credit_choice = Convert.ToDecimal(dr_credit_choice[0]["credit_choice"]);
    //            }

    //            if (dr_fees.Length > 0)
    //            {

    //                if (dr_fees[0]["waiver_credits"].ToString() != "")
    //                {
    //                    dr["waiver_credits"] = dr_fees[0]["waiver_credits"];
    //                    waiver_credits = Convert.ToDecimal(dr_fees[0]["waiver_credits"]);
    //                }
    //                else
    //                {
    //                    dr["waiver_credits"] = "0";
    //                    waiver_credits = 0;
    //                }

    //                if (dr_fees[0]["installmant_status"].ToString() != "")
    //                {
    //                    // dr["waiver_credits"] = dr_fees[0]["waiver_credits"];
    //                    installmant_status = dr_fees[0]["installmant_status"].ToString();
    //                }

    //                if (get_online_fees_data != null)
    //                {


    //                    DataRow[] dr_online_fees = get_online_fees_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

    //                    if (dr_online_fees.Length > 0)
    //                    {
    //                        dr["fees_date"] = dr_online_fees[0]["date"];
    //                        dr["payment_mode"] = "Online";
    //                        dr["payment_reference"] = dr_online_fees[0]["payment_transaction_reference_id"];

    //                        dr["fees_status"] = dr_online_fees[0]["amount"];
    //                    }
    //                    else
    //                    {

    //                        DataRow[] dr_fees_amount_per_credit;

    //                        if (get_data.Rows[i]["prof_details"].ToString() == "P")
    //                        {
    //                            dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='P'");
    //                        }
    //                        else
    //                        {
    //                            dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='S'");
    //                        }

    //                        dr["fees_date"] = dr_fees[0]["date"];
    //                        dr["payment_mode"] = "ICICI";
    //                        if (dr_fees_amount_per_credit.Length > 0)
    //                        {
    //                            if (waiver_credits > credit_choice)
    //                            {
    //                                dr["fees_status"] = 0;
    //                            }
    //                            else
    //                            {
    //                                if (installmant_status == "Y")
    //                                {
    //                                    dr["fees_status"] = ((credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"])) / 4;
    //                                }
    //                                else
    //                                {
    //                                    dr["fees_status"] = (credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"]);
    //                                }

    //                            }
    //                        }


    //                    }

    //                }
    //                else
    //                {
    //                    DataRow[] dr_fees_amount_per_credit;

    //                    if (get_data.Rows[i]["prof_details"].ToString() == "P")
    //                    {
    //                        dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='P'");
    //                    }
    //                    else
    //                    {
    //                        dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='S'");
    //                    }

    //                    dr["fees_date"] = dr_fees[0]["date"];
    //                    dr["payment_mode"] = "ICICI";
    //                    if (dr_fees_amount_per_credit.Length > 0)
    //                    {
    //                        if (waiver_credits > credit_choice)
    //                        {
    //                            dr["fees_status"] = 0;
    //                        }
    //                        else
    //                        {
    //                            if (installmant_status == "Y")
    //                            {
    //                                dr["fees_status"] = ((credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"])) / 4;
    //                            }
    //                            else
    //                            {
    //                                dr["fees_status"] = (credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"]);
    //                            }

    //                        }
    //                    }
    //                }
    //            }



    //            dt.Rows.Add(dr);


    //        }





    //        if (dt != null)
    //        {
    //            jsondata = GetJson1(dt);
    //        }
    //    }
    //    return jsondata;
    //}

    //[WebMethod(EnableSession = true)]
    //public string Create_online_payment()
    //{
    //    // Save Compliance Details in compliance_entry table.


    //    int re = 0;
    //    string user_id = "";
    //    string current_sem_code = "";
    //    string message = "";
    //    string transaction_id = "";
    //    decimal amount = 0, main_fees = 0, fees1 = 0, deposit = 0;

    //    string dept_code = "";

    //    string gender = "";

    //    string trans_code = "";

    //    Dictionary<string, object> obj_data = new Dictionary<string, object>();

    //    //obj_data["status"] = false;
    //    //obj_data["message"] = "You can not Pay Fees for Some CEPT University's reasons.";

    //    //return JsonConvert.SerializeObject(obj_data);

    //    try
    //    {


    //        Dictionary<string, object> param = new Dictionary<string, object>();

    //        if (HttpContext.Current.Session["UserId"].ToString() != null)
    //        {
    //            user_id = HttpContext.Current.Session["UserId"].ToString();
    //        }

    //        //if (HttpContext.Current.Session["semester_code"].ToString() != null)
    //        //{
    //        //    current_sem_code = HttpContext.Current.Session["semester_code"].ToString();
    //        //}

    //        //if (HttpContext.Current.Session["gender"].ToString() != null)
    //        //{
    //        //    gender = HttpContext.Current.Session["gender"].ToString();

    //        //    if (gender == "T")
    //        //    {
    //        //        gender = "F";
    //        //    }
    //        //}
    //        //else
    //        //{
    //        //    obj_data["status"] = false;
    //        //    obj_data["message"] = "Your Gender is not Found.";

    //        //    return JsonConvert.SerializeObject(obj_data);
    //        //}

    //        if (HttpContext.Current.Session["dept_code"].ToString() != null)
    //        {
    //            dept_code = HttpContext.Current.Session["dept_code"].ToString();
    //        }
    //        else
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "Your Faculty is not Found.";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }

    //        if (user_id == "")
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "User Id not found.please refresh your current page";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }


    //        string semester = "";

    //        //if (HttpContext.Current.Session["semester_code"] != "")
    //        //{
    //        //    semester = HttpContext.Current.Session["semester_code"].ToString();
    //        //}

    //        DataTable dt_check_allocate_data = objmaster.Get_student_assigned_current_sem_data(user_id, current_ws_sem, current_ws_year);


    //        if (dt_check_allocate_data != null)
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "You can not Payment your fees Course.Course allocation is already completed for current semester.";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }

    //        DataTable get_data = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, user_id);

    //        if (get_data == null)
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "You can not payment your fees.You are not save your choice of credits.";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }

    //        DataTable dt_check_registed_data = objmaster.Get_ws_student_registered(user_id, current_ws_sem, current_ws_year);


    //        if (dt_check_registed_data != null)
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "You can not payment your fees.You already registered your Course.";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }



    //        if (HttpContext.Current.Session["semester_code"] != null)
    //        {
    //            semester = HttpContext.Current.Session["semester_code"].ToString();
    //        }

    //        string year_code = "";

    //        if (HttpContext.Current.Session["year_code"] != null)
    //        {
    //            year_code = HttpContext.Current.Session["year_code"].ToString();
    //        }
    //        else
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "Your year of enrollment is not found in your master.";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }

    //        if (get_data == null)
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "You can not payment your fees.You are not save your choice of credits.";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }


    //        string prof_details = "";

    //        if (HttpContext.Current.Session["prof_details"] != null)
    //        {
    //            prof_details = HttpContext.Current.Session["prof_details"].ToString();
    //        }

    //        DataTable fees_amount = objmaster.Get_fees_amount_for_student(year_code, current_ws_sem, current_ws_year, prof_details);

    //        decimal fees = 0;

    //        if (fees_amount != null)
    //        {
    //            fees = Convert.ToDecimal(fees_amount.Rows[0]["fees_amount"]);
    //        }
    //        else
    //        {
    //            obj_data["status"] = false;
    //            obj_data["message"] = "Fees is not found for current year and semester";

    //            return JsonConvert.SerializeObject(obj_data);
    //        }


    //        DataTable fees_status = objmaster.Get_fees_status_for_student(user_id, current_ws_sem, current_ws_year);

    //        if (get_data.Rows[0]["credit_choice"].ToString() != "")
    //        {
    //            if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > 12)
    //            {



    //            }
    //            else
    //            {


    //                if (year_code != "Y2014")
    //                {

    //                    if (fees_status != null)
    //                    {


    //                       if (fees_status.Rows[0]["fees_type"].ToString() == "Y")
    //                        {
    //                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
    //                            {
    //                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
    //                                {



    //                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
    //                                    {



    //                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * 4500) / 4;
    //                                    }
    //                                    else
    //                                    {
    //                                        amount = 0;
    //                                    }



    //                                }
    //                                else
    //                                {

    //                                    //     $('.lbl_amount1').text((fees_status[0]["credit_choice"] * 4000) / 2);

    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 4500) / 4;

    //                                }


    //                            }
    //                            else
    //                            {

    //                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
    //                                {
    //                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
    //                                    {


    //                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * 4500);

    //                                        // $('.lbl_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));


    //                                    }
    //                                    else
    //                                    {
    //                                        //  $('.lbl_amount1').text(fees_status[0]["credit_choice"] * 4000);

    //                                        amount = 0;

    //                                    }


    //                                }
    //                                else
    //                                {
    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 4500);
    //                                }
    //                            }
    //                        }
    //                        else
    //                        {

    //                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
    //                            {
    //                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
    //                                {
    //                                    //   $('.lbl_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);

    //                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * 4500) / 4;
    //                                }
    //                                else
    //                                {

    //                                    // $('.lbl_amount1').text((fees_status[0]["credit_choice"] * 4000) / 2);

    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 4500) / 4;
    //                                }


    //                            }
    //                            else
    //                            {

    //                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
    //                                {

    //                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * 4500);
    //                                    //   $('.lbl_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));



    //                                }
    //                                else
    //                                {
    //                                    //  $('.lbl_amount1').text(fees_status[0]["credit_choice"] * 4000);

    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 4500);

    //                                }


    //                            }
    //                        }
    //                    }
    //                    else
    //                    {
    //                        amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 4500);

    //                        //        $('.lbl_amount1').text(fees_status[0]["credit_choice"] * 4000);


    //                    }
    //                }
    //                else
    //                {

    //                    if (fees_status != null)
    //                    {






    //                        if (fees_status.Rows[0]["fees_type"].ToString() == "Y")
    //                        {
    //                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
    //                            {
    //                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
    //                                {



    //                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
    //                                    {

    //                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * 5000) / 4;
    //                                    }
    //                                    else
    //                                    {
    //                                        amount = 0;
    //                                    }



    //                                }
    //                                else
    //                                {

    //                                    //     $('.lbl_amount1').text((fees_status[0]["credit_choice"] * 4000) / 2);

    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 5000) / 4;

    //                                }


    //                            }
    //                            else
    //                            {

    //                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
    //                                {
    //                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
    //                                    {


    //                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * 5000);

    //                                        // $('.lbl_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));


    //                                    }
    //                                    else
    //                                    {
    //                                        //  $('.lbl_amount1').text(fees_status[0]["credit_choice"] * 4000);

    //                                        amount = 0;

    //                                    }


    //                                }
    //                                else
    //                                {
    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 5000);
    //                                }
    //                            }
    //                        }
    //                        else
    //                        {

    //                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
    //                            {
    //                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
    //                                {
    //                                    //   $('.lbl_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);

    //                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * 5000) / 4;
    //                                }
    //                                else
    //                                {

    //                                    // $('.lbl_amount1').text((fees_status[0]["credit_choice"] * 4000) / 2);

    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 5000) / 4;
    //                                }


    //                            }
    //                            else
    //                            {

    //                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
    //                                {

    //                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * 5000);
    //                                    //   $('.lbl_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));



    //                                }
    //                                else
    //                                {
    //                                    //  $('.lbl_amount1').text(fees_status[0]["credit_choice"] * 4000);

    //                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 5000);

    //                                }


    //                            }
    //                        }
    //                    }
    //                    else
    //                    {
    //                        amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * 5000);

    //                        //        $('.lbl_amount1').text(fees_status[0]["credit_choice"] * 4000);


    //                    }
    //                }


    //            }
    //        }




    //        //DataTable dt_total_credits = objmaster.Get_total_credits_for_pay_slip(user_id, current_sem_code);



    //        //if (dt_total_credits != null)
    //        //{
    //        //   DataTable dt_user_fees_data = objmaster.get_user_data_for_pay_slip_new(user_id, semester, gender);

    //        //    if (dt_user_fees_data != null)
    //        //    {

    //        //        int total_credits = 0;
    //        //        if (dt_total_credits.Rows[0]["credits"].ToString() != "")
    //        //        {
    //        //            total_credits = Convert.ToInt16(dt_total_credits.Rows[0]["credits"]);
    //        //        }
    //        //        else
    //        //        {
    //        //            obj_data["status"] = false;
    //        //            obj_data["message"] = "Total Credits not found for current semester.Please First Save your course for Online payment";

    //        //            return JsonConvert.SerializeObject(obj_data);
    //        //        }

    //        //        if (dt_user_fees_data.Rows[0]["fees"].ToString() != "")
    //        //        {
    //        //            main_fees = Convert.ToDecimal(dt_user_fees_data.Rows[0]["fees"]);

    //        //            fees1 = Convert.ToDecimal(dt_user_fees_data.Rows[0]["fees1"]);

    //        //            deposit = Convert.ToDecimal(dt_user_fees_data.Rows[0]["deposit"]);
    //        //        }
    //        //        else
    //        //        {
    //        //            obj_data["status"] = false;
    //        //            obj_data["message"] = "Fees Data not found";

    //        //            return JsonConvert.SerializeObject(obj_data);
    //        //        }

    //        //        if (total_credits > 12)
    //        //        {


    //        //            amount = main_fees + fees1 + deposit;
    //        //        }
    //        //        else
    //        //        {
    //        //            amount = ((main_fees + fees1) / 2) + deposit;
    //        //        }

    //        //        trans_code = dt_user_fees_data.Rows[0]["bank_code"].ToString() + dt_user_fees_data.Rows[0]["user_id"].ToString() + semester;
    //        //    }
    //        //    else
    //        //    {
    //        //        obj_data["status"] = false;
    //        //        obj_data["message"] = "Fees Data not found";
    //        //        return JsonConvert.SerializeObject(obj_data);

    //        //    }
    //        //}
    //        //else
    //        //{
    //        //    obj_data["status"] = false;
    //        //    obj_data["message"] = "Your Total Credits not found";
    //        //    return JsonConvert.SerializeObject(obj_data);
    //        //}



    //        Payment objPayment = new Payment();

    //        bool result = objPayment.RedirectToPaymentGateway(param, ref message, user_id, amount, "", current_ws_sem, current_ws_year, dept_code, "WS", ref transaction_id);


    //        string hmac_url = Payment.Get_hmac_url(dept_code);

    //        string return_url = Payment.Get_return_url(dept_code);

    //        //  string base_url = "http://registration.cept.ac.in/cept/Student/";

    //        //   string base_url = "http://27.109.12.253//ceptws/Student/";

    //        string base_url = ConfigurationSettings.AppSettings["online_payment_base_url"].ToString();

    //        if (ConfigurationSettings.AppSettings["online_amount"].ToString() == "1")
    //        {
    //            amount = 1;
    //        }


    //        obj_data["status"] = result;
    //        obj_data["message"] = message;
    //        obj_data["user_id"] = user_id;

    //        obj_data["amount"] = amount;


    //        obj_data["transaction_id"] = transaction_id;
    //        obj_data["merchant_id"] = HttpContext.Current.Session["MerchantId"];
    //        obj_data["currency"] = "INR";
    //        obj_data["hmac_url"] = hmac_url;
    //        obj_data["return_url"] = base_url + return_url;

    //        return JsonConvert.SerializeObject(obj_data);

    //    }
    //    catch (Exception ex)
    //    {
    //        obj_data["status"] = false;

    //        obj_data["message"] = "Problem in Save DATA.";

    //        return JsonConvert.SerializeObject(obj_data);
    //    }

    //    string msg = "";



    //    return message;

    //}

    [WebMethod(EnableSession = true)]
    public string Create_online_payment()
    {
        // Save Compliance Details in compliance_entry table.



        string user_id = "";

        string message = "";
        string transaction_id = "";
        decimal amount = 0;

        string dept_code = "";

        int re = 0;


        Dictionary<string, object> obj_data = new Dictionary<string, object>();

        //obj_data["status"] = false;
        //obj_data["message"] = "You can not Pay Fees for Some CEPT University's reasons.";

        //return JsonConvert.SerializeObject(obj_data);

        try
        {


            Dictionary<string, object> param = new Dictionary<string, object>();

            if (HttpContext.Current.Session["UserId"].ToString() != null)
            {
                user_id = HttpContext.Current.Session["UserId"].ToString();
            }

            //if (transaction_id == "")
            //{
            //    obj_data["status"] = false;
            //    obj_data["message"] = "Registration has been closed for Summer 2015.";

            //    return JsonConvert.SerializeObject(obj_data);

            //}

            //if (HttpContext.Current.Session["semester_code"].ToString() != null)
            //{
            //    current_sem_code = HttpContext.Current.Session["semester_code"].ToString();
            //}

            //if (HttpContext.Current.Session["gender"].ToString() != null)
            //{
            //    gender = HttpContext.Current.Session["gender"].ToString();

            //    if (gender == "T")
            //    {
            //        gender = "F";
            //    }
            //}
            //else
            //{
            //    obj_data["status"] = false;
            //    obj_data["message"] = "Your Gender is not Found.";

            //    return JsonConvert.SerializeObject(obj_data);
            //}


            if (current_round != "1")
            {
                //if (current_round != "")
                //{

                //    DataTable dt = objmaster.get_student_for_next_round_registration(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString(), current_round);

                //    if (dt != null)
                //    {
                //        if (dt.Rows[0]["user_id"].ToString() == HttpContext.Current.Session["UserId"].ToString())
                //        {
                //            re = 1;
                //        }
                //    }
                //}
            }
            else
            {


                //if (HttpContext.Current.Session["dept_code"].ToString() == "7")
                //{
                //    re = 1;
                //}

                //if (HttpContext.Current.Session["dept_code"].ToString() == "1" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
                //{
                //    re = 1;
                //}

                //if (HttpContext.Current.Session["dept_code"].ToString() == "2" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
                //{
                //    re = 1;
                //}
            }

            if (re == 0)
            {
                obj_data["status"] = false;
                obj_data["message"] = "Registration has been closed for Summer 2016.";

                return JsonConvert.SerializeObject(obj_data);
            }

            if (HttpContext.Current.Session["dept_code"].ToString() != null)
            {
                dept_code = HttpContext.Current.Session["dept_code"].ToString();
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Your Faculty is not Found.";

                return JsonConvert.SerializeObject(obj_data);
            }

            if (user_id == "")
            {
                obj_data["status"] = false;
                obj_data["message"] = "User Id not found.please refresh your current page";

                return JsonConvert.SerializeObject(obj_data);
            }


            string semester = "";

            //if (HttpContext.Current.Session["semester_code"] != "")
            //{
            //    semester = HttpContext.Current.Session["semester_code"].ToString();
            //}

            DataTable dt_check_allocate_data = objmaster.Get_student_assigned_current_sem_data(user_id, current_ws_sem, current_ws_year);


            if (dt_check_allocate_data != null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "You can not Payment your fees Course.Course allocation is already completed for current semester.";

                return JsonConvert.SerializeObject(obj_data);
            }

            DataTable get_data = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, user_id);

            if (get_data == null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "You can not payment your fees.You are not save your choice of credits.";

                return JsonConvert.SerializeObject(obj_data);
            }

            DataTable dt_check_registed_data = objmaster.Get_ws_student_registered(user_id, current_ws_sem, current_ws_year);


            if (dt_check_registed_data != null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "You can not payment your fees.You already registered your Course.";

                return JsonConvert.SerializeObject(obj_data);
            }



            if (HttpContext.Current.Session["semester_code"] != null)
            {
                semester = HttpContext.Current.Session["semester_code"].ToString();
            }

            string year_code = "";

            if (HttpContext.Current.Session["year_code"] != null)
            {
                year_code = HttpContext.Current.Session["year_code"].ToString();
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Your year of enrollment is not found in your master.";

                return JsonConvert.SerializeObject(obj_data);
            }

            if (get_data == null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "You can not payment your fees.You are not save your choice of credits.";

                return JsonConvert.SerializeObject(obj_data);
            }


            string prof_details = "";

            if (HttpContext.Current.Session["prof_details"] != null)
            {
                prof_details = HttpContext.Current.Session["prof_details"].ToString();
            }

            DataTable fees_amount = objmaster.Get_fees_amount_for_student(year_code, current_ws_sem, current_ws_year, prof_details);

            decimal fees = 0;

            if (fees_amount != null)
            {
                fees = Convert.ToDecimal(fees_amount.Rows[0]["fees_amount"]);
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Fees is not found for current year and semester";

                return JsonConvert.SerializeObject(obj_data);
            }

            DataTable fees_status = objmaster.Get_fees_status_for_student(user_id, current_ws_sem, current_ws_year);

            if (get_data.Rows[0]["credit_choice"].ToString() != "")
            {
                if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > 12)
                {
                    obj_data["status"] = false;
                    obj_data["message"] = "credit choice is grater than 8 for selected student";

                    return JsonConvert.SerializeObject(obj_data);
                }
                else
                {

                    if (fees_status != null)
                    {
                        if (fees_status.Rows[0]["fees_type"].ToString() == "Y")
                        {
                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
                            {
                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
                                {

                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
                                    {
                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * fees) / 4;
                                    }
                                    else
                                    {
                                        amount = 0;
                                    }
                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees) / 4;
                                }
                            }
                            else
                            {
                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
                                {
                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
                                    {
                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * fees);
                                    }
                                    else
                                    {
                                        amount = 0;
                                    }
                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);
                                }
                            }
                        }
                        else
                        {

                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
                            {
                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
                                {
                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * fees) / 4;
                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees) / 4;
                                }
                            }
                            else
                            {
                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
                                {
                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * fees);
                                }
                                else
                                {

                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);

                                }
                            }
                        }
                    }
                    else
                    {
                        amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);

                    }

                }
            }




            //DataTable dt_total_credits = objmaster.Get_total_credits_for_pay_slip(user_id, current_sem_code);



            //if (dt_total_credits != null)
            //{
            //   DataTable dt_user_fees_data = objmaster.get_user_data_for_pay_slip_new(user_id, semester, gender);

            //    if (dt_user_fees_data != null)
            //    {

            //        int total_credits = 0;
            //        if (dt_total_credits.Rows[0]["credits"].ToString() != "")
            //        {
            //            total_credits = Convert.ToInt16(dt_total_credits.Rows[0]["credits"]);
            //        }
            //        else
            //        {
            //            obj_data["status"] = false;
            //            obj_data["message"] = "Total Credits not found for current semester.Please First Save your course for Online payment";

            //            return JsonConvert.SerializeObject(obj_data);
            //        }

            //        if (dt_user_fees_data.Rows[0]["fees"].ToString() != "")
            //        {
            //            main_fees = Convert.ToDecimal(dt_user_fees_data.Rows[0]["fees"]);

            //            fees1 = Convert.ToDecimal(dt_user_fees_data.Rows[0]["fees1"]);

            //            deposit = Convert.ToDecimal(dt_user_fees_data.Rows[0]["deposit"]);
            //        }
            //        else
            //        {
            //            obj_data["status"] = false;
            //            obj_data["message"] = "Fees Data not found";

            //            return JsonConvert.SerializeObject(obj_data);
            //        }

            //        if (total_credits > 12)
            //        {


            //            amount = main_fees + fees1 + deposit;
            //        }
            //        else
            //        {
            //            amount = ((main_fees + fees1) / 2) + deposit;
            //        }

            //        trans_code = dt_user_fees_data.Rows[0]["bank_code"].ToString() + dt_user_fees_data.Rows[0]["user_id"].ToString() + semester;
            //    }
            //    else
            //    {
            //        obj_data["status"] = false;
            //        obj_data["message"] = "Fees Data not found";
            //        return JsonConvert.SerializeObject(obj_data);

            //    }
            //}
            //else
            //{
            //    obj_data["status"] = false;
            //    obj_data["message"] = "Your Total Credits not found";
            //    return JsonConvert.SerializeObject(obj_data);
            //}

            Payment objPayment = new Payment();

            bool result = objPayment.RedirectToPaymentGateway(param, ref message, user_id, amount, "", current_ws_sem, current_ws_year, dept_code, "WS", ref transaction_id);


            string hmac_url = Payment.Get_hmac_url(dept_code);

            string return_url = Payment.Get_return_url(dept_code);

            //  string base_url = "http://registration.cept.ac.in/cept/Student/";

            //   string base_url = "http://27.109.12.253//ceptws/Student/";

            string base_url = ConfigurationSettings.AppSettings["online_payment_base_url"].ToString();

            //if (ConfigurationSettings.AppSettings["online_amount"].ToString() == "1")
            //{
            //    amount = 1;
            //}


            obj_data["status"] = result;
            obj_data["message"] = message;
            obj_data["user_id"] = user_id;

            obj_data["amount"] = amount;


            obj_data["transaction_id"] = transaction_id;
            obj_data["merchant_id"] = HttpContext.Current.Session["MerchantId"];
            obj_data["currency"] = "INR";
            obj_data["hmac_url"] = hmac_url;
            obj_data["return_url"] = base_url + return_url;

            return JsonConvert.SerializeObject(obj_data);

        }
        catch (Exception ex)
        {
            obj_data["status"] = false;

            obj_data["message"] = "Problem in Online payment";

            return JsonConvert.SerializeObject(obj_data);
        }

        string msg = "";



        return message;

    }

    [WebMethod(EnableSession = true)]
    public string get_user_data_for_pay_slip_for_manually_student_wise(string user_id, string year_code, string fees_type)
    {
        // Save Compliance Details in compliance_entry table.

        string transaction_id = "";

        decimal amount = 0;

        string student_name = "";

        Dictionary<string, object> obj_data = new Dictionary<string, object>();

        try
        {



            DataTable get_data = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, user_id);

            if (get_data == null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "choice of credits not found for selected student";

                return JsonConvert.SerializeObject(obj_data);
            }



            // GetTransactionDetails_studentwise

            string prof_details = "";

            DataTable user_mst_data = objmaster.userMaster(user_id);

            if (user_mst_data != null)
            {
                student_name = user_mst_data.Rows[0]["user_name"].ToString();

                prof_details = user_mst_data.Rows[0]["user_name"].ToString();
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "user data not found in master table";

                return JsonConvert.SerializeObject(obj_data);
            }

            if (fees_type == "online")
            {
                DataTable get_online_data = objmaster.GetTransactionDetails_studentwise(user_id, current_ws_sem, current_ws_year);

                if (get_online_data == null)
                {
                    obj_data["status"] = false;
                    obj_data["message"] = "Transaction details not found for selected student";

                    return JsonConvert.SerializeObject(obj_data);
                }
                else
                {
                    obj_data["status"] = true;
                    obj_data["amount"] = get_online_data.Rows[0]["amount"].ToString();
                    obj_data["student_name"] = student_name;
                    obj_data["transaction_id"] = get_online_data.Rows[0]["transaction_id"].ToString();

                    obj_data["created_date"] = get_online_data.Rows[0]["created_date"].ToString();

                    return JsonConvert.SerializeObject(obj_data);
                }
            }

            DataTable fees_amount = objmaster.Get_fees_amount_for_student(year_code, current_ws_sem, current_ws_year, prof_details);

            decimal fees = 0;

            if (fees_amount != null)
            {
                fees = Convert.ToDecimal(fees_amount.Rows[0]["fees_amount"]);
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Fees is not found for current year";

                return JsonConvert.SerializeObject(obj_data);
            }


            DataTable fees_status = objmaster.Get_fees_status_for_student(user_id, current_ws_sem, current_ws_year);

            if (get_data.Rows[0]["credit_choice"].ToString() != "")
            {
                if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > 12)
                {
                    obj_data["status"] = false;
                    obj_data["message"] = "credit choice is grater than 8 for selected student";

                    return JsonConvert.SerializeObject(obj_data);
                }
                else
                {
                    if (fees_status != null)
                    {
                        if (fees_status.Rows[0]["fees_type"].ToString() == "Y")
                        {
                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
                            {
                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
                                {
                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
                                    {
                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * fees) / 4;
                                    }
                                    else
                                    {
                                        amount = 0;
                                    }
                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees) / 4;
                                }
                            }
                            else
                            {

                                if (fees_status.Rows[0]["fees_waiver_credits"].ToString() != "")
                                {
                                    if (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) > Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString()))
                                    {
                                        amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["fees_waiver_credits"].ToString())) * fees);
                                    }
                                    else
                                    {
                                        amount = 0;
                                    }

                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);
                                }
                            }
                        }
                        else
                        {

                            if (fees_status.Rows[0]["installmant_status"].ToString() == "Y")
                            {
                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
                                {

                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * fees) / 4;
                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees) / 4;
                                }

                            }
                            else
                            {
                                if (fees_status.Rows[0]["waiver_credits"].ToString() != "")
                                {
                                    amount = ((Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) - Convert.ToDecimal(fees_status.Rows[0]["waiver_credits"])) * fees);
                                }
                                else
                                {
                                    amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);
                                }

                            }
                        }
                    }
                    else
                    {
                        amount = (Convert.ToDecimal(get_data.Rows[0]["credit_choice"]) * fees);
                    }


                }
            }

            obj_data["status"] = true;
            obj_data["amount"] = amount;
            obj_data["student_name"] = student_name;
            //   obj_data["transaction_id"] = transaction_id;


            return JsonConvert.SerializeObject(obj_data);

        }
        catch (Exception ex)
        {
            obj_data["status"] = false;

            obj_data["message"] = "Problem in generate payslip";

            return JsonConvert.SerializeObject(obj_data);
        }



    }

    [WebMethod]
    public string get_financial_report_data_SW(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.get_financial_report_data_WS("", sem_code, year_code);

        DataTable get_fees_amount_pre_credit = objmaster.Get_fees_amount_pre_credit_WS(sem_code, year_code);

        // DataTable get_online_fees_data = objmaster.Get_online_fees_status_WS(semester, year_code);

        //  DataTable get_credit_choice_data = objmaster.Get_WS_credit_choice_for_student_for_assign(semester, year_code);

        DataTable dt = new DataTable();

        dt.Columns.Add("code");
        dt.Columns.Add("credit_choice");
        dt.Columns.Add("name");
        dt.Columns.Add("year_desc");
        dt.Columns.Add("department_name");
        dt.Columns.Add("program");
        dt.Columns.Add("gender");
        //    dt.Columns.Add("elective_credits");
        dt.Columns.Add("waiver_credits");
        dt.Columns.Add("fees_waiver_credits");
        //   dt.Columns.Add("total_credits");
        //dt.Columns.Add("semester_type");
        //dt.Columns.Add("year_semester");
        dt.Columns.Add("fees_status");
        dt.Columns.Add("fees_date");
        //dt.Columns.Add("payment_mode");
        //dt.Columns.Add("payment_reference");

        //dt.Columns.Add("total_credits");



        DataRow dr;

        Decimal credit_choice = 0, waiver_credits = 0, fees_waiver_credits = 0;


        if (get_data != null)
        {

            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                credit_choice = 0;
                waiver_credits = 0;
                fees_waiver_credits = 0;

                string installmant_status = "";
                string fees_waiver_type = "N";

                dr = dt.NewRow();

                //total_credits = 0;

                dr["code"] = get_data.Rows[i]["user_id"].ToString();
                dr["name"] = get_data.Rows[i]["user_name"].ToString();
                dr["year_desc"] = get_data.Rows[i]["year_desc"].ToString();
                dr["department_name"] = get_data.Rows[i]["dept_name"].ToString();
                dr["program"] = get_data.Rows[i]["prog_name"].ToString();
                dr["gender"] = get_data.Rows[i]["gender"].ToString();
                dr["credit_choice"] = get_data.Rows[i]["credit_choice"].ToString();

                credit_choice = Convert.ToDecimal(get_data.Rows[i]["credit_choice"].ToString());
                // DataRow[] dr_credit_choice = get_credit_choice_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

                //if (dr_credit_choice.Length > 0)
                //{
                //    dr["credit_choice"] = dr_credit_choice[0]["credit_choice"];
                //    credit_choice = Convert.ToDecimal(dr_credit_choice[0]["credit_choice"]);
                //}



                if (get_data.Rows[i]["waiver_credits"].ToString() != "")
                {
                    dr["waiver_credits"] = get_data.Rows[i]["waiver_credits"];
                    waiver_credits = Convert.ToDecimal(get_data.Rows[i]["waiver_credits"]);
                }
                else
                {
                    dr["waiver_credits"] = "0";
                    waiver_credits = 0;
                }

                // Added 03 03 2020 Email Reports Amount Mismatch so

                if (get_data.Rows[i]["fees_type"].ToString() != "")
                {
                    fees_waiver_type = get_data.Rows[i]["fees_type"].ToString();
                }

                if (get_data.Rows[i]["fees_waiver_credits"].ToString() != "")
                {
                    dr["fees_waiver_credits"] = get_data.Rows[i]["fees_waiver_credits"];
                    fees_waiver_credits = Convert.ToDecimal(get_data.Rows[i]["fees_waiver_credits"]);
                }
                else
                {
                    dr["fees_waiver_credits"] = "0";
                    fees_waiver_credits = 0;
                }

                if (fees_waiver_type == "Y")
                {
                    waiver_credits = fees_waiver_credits;
                }
                // Added 03 03 2020 Email Reports Amount Mismatch so

                if (get_data.Rows[i]["installmant_status"].ToString() != "")
                {
                    // dr["waiver_credits"] = dr_fees[0]["waiver_credits"];
                    installmant_status = get_data.Rows[i]["installmant_status"].ToString();
                }

                DataRow[] dr_fees_amount_per_credit;

                if (get_data.Rows[i]["prof_details"].ToString() == "P")
                {
                    dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='P'");
                }
                else
                {
                    dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='S'");
                }

                dr["fees_date"] = get_data.Rows[i]["date"];
                //    dr["payment_mode"] = "ICICI";
                if (dr_fees_amount_per_credit.Length > 0)
                {
                    if (waiver_credits > credit_choice)
                    {
                        dr["fees_status"] = 0;
                    }
                    else
                    {
                        if (installmant_status == "Y")
                        {
                            dr["fees_status"] = ((credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"])) / 4;
                        }
                        else
                        {
                            dr["fees_status"] = (credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"]);
                        }

                    }
                }

                dt.Rows.Add(dr);
            }

            if (dt != null)
            {
                dt.DefaultView.Sort = "department_name,program desc";
                dt = dt.DefaultView.ToTable();

                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    [WebMethod]
    public string get_fees_consolidated_report(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.get_financial_report_data_for_manual_online_fees("", sem_code, year_code);

        DataTable get_fees_amount_pre_credit = objmaster.Get_fees_amount_pre_credit_WS(sem_code, year_code);

        DataTable get_online_fees_data = objmaster.get_successfully_paid_fees_details(sem_code, year_code);

        //DataTable get_credit_choice_data = objmaster.Get_WS_credit_choice_for_student_for_assign(semester, year_code);

        DataTable dt_allodate_data = objmaster.get_ws_allocate_course_data_new_for_report(sem_code, year_code, "");

        DataTable dt = new DataTable();

        dt.Columns.Add("code");
        dt.Columns.Add("credit_choice");
        dt.Columns.Add("name");
        dt.Columns.Add("transaction_id");
        dt.Columns.Add("new_transaction_id");
        dt.Columns.Add("Citrus_TxRefNo");
        dt.Columns.Add("year_desc");
        dt.Columns.Add("department_name");
        dt.Columns.Add("program");
        dt.Columns.Add("mail");
        dt.Columns.Add("mobile_no");
        dt.Columns.Add("gender");
        dt.Columns.Add("waiver_credits");
        dt.Columns.Add("fees_waiver_credits");
        dt.Columns.Add("fees_status");
        dt.Columns.Add("fees_date");
        dt.Columns.Add("payment_mode");
        dt.Columns.Add("allocate_course");
        dt.Columns.Add("allocate_credits");

        //dt.Columns.Add("elective_credits");
        //dt.Columns.Add("total_credits");
        //dt.Columns.Add("semester_type");
        //dt.Columns.Add("year_semester");
        //dt.Columns.Add("payment_reference");
        //dt.Columns.Add("total_credits");

        DataRow dr;

        Decimal credit_choice = 0, waiver_credits = 0, fees_waiver_credits = 0;


        if (get_data != null)
        {
            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                credit_choice = 0;
                waiver_credits = 0;
                fees_waiver_credits = 0;

                string installmant_status = "";
                string fees_waiver_type = "N";

                dr = dt.NewRow();

                //total_credits = 0;

                dr["code"] = get_data.Rows[i]["user_id"].ToString();
                dr["name"] = get_data.Rows[i]["user_name"].ToString();
                dr["year_desc"] = get_data.Rows[i]["year_desc"].ToString();
                dr["department_name"] = get_data.Rows[i]["dept_name"].ToString();
                dr["program"] = get_data.Rows[i]["prog_name"].ToString();
                dr["mail"] = get_data.Rows[i]["mail"].ToString();
                dr["mobile_no"] = get_data.Rows[i]["mobile_no"].ToString();
                dr["gender"] = get_data.Rows[i]["gender"].ToString();
                dr["credit_choice"] = get_data.Rows[i]["credit_choice"].ToString();

                if (get_data.Rows[i]["credit_choice"].ToString() != "")
                {
                    credit_choice = Convert.ToDecimal(get_data.Rows[i]["credit_choice"].ToString());
                }

                //DataRow[] dr_credit_choice = get_credit_choice_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

                //if (dr_credit_choice.Length > 0)
                //{
                //    dr["credit_choice"] = dr_credit_choice[0]["credit_choice"];
                //    credit_choice = Convert.ToDecimal(dr_credit_choice[0]["credit_choice"]);
                //}

                if (get_data.Rows[i]["waiver_credits"].ToString() != "")
                {
                    dr["waiver_credits"] = get_data.Rows[i]["waiver_credits"];
                    waiver_credits = Convert.ToDecimal(get_data.Rows[i]["waiver_credits"]);
                }
                else
                {
                    dr["waiver_credits"] = "0";
                    waiver_credits = 0;
                }

                if (get_data.Rows[i]["fees_type"].ToString() != "")
                {
                    fees_waiver_type = get_data.Rows[i]["fees_type"].ToString();
                }

                if (get_data.Rows[i]["fees_waiver_credits"].ToString() != "")
                {
                    dr["fees_waiver_credits"] = get_data.Rows[i]["fees_waiver_credits"];
                    fees_waiver_credits = Convert.ToDecimal(get_data.Rows[i]["fees_waiver_credits"]);
                }
                else
                {
                    dr["fees_waiver_credits"] = "0";
                    fees_waiver_credits = 0;
                }

                if (fees_waiver_type == "Y")
                {
                    waiver_credits = fees_waiver_credits;
                }

                if (get_data.Rows[i]["installmant_status"].ToString() != "")
                {
                    //dr["waiver_credits"] = dr_fees[0]["waiver_credits"];
                    installmant_status = get_data.Rows[i]["installmant_status"].ToString();
                }

                if (get_online_fees_data != null)
                {
                    DataRow[] dr_online_fees = get_online_fees_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

                    if (dr_online_fees.Length > 0)
                    {
                        dr["fees_date"] = dr_online_fees[0]["created_date"];

                        dr["transaction_id"] = "=\"" + dr_online_fees[0]["transaction_id"] + "\"";
                        dr["new_transaction_id"] = dr_online_fees[0]["payment_root_transaction_reference_no"];

                        if (dr_online_fees[0]["Citrus_TxRefNo"].ToString() != "")
                        {
                            dr["Citrus_TxRefNo"] = dr_online_fees[0]["Citrus_TxRefNo"];
                        }
                        else
                        {
                            dr["Citrus_TxRefNo"] = dr_online_fees[0]["payment_transaction_reference_id"];
                        }

                        dr["payment_mode"] = "Online";
                        
                        //dr["payment_reference"] = dr_online_fees[0]["payment_transaction_reference_id"];

                        if (dr_online_fees.Length > 1)
                        {
                            int total_amount = Convert.ToInt32(dr_online_fees[0]["amount"]) + Convert.ToInt32(dr_online_fees[1]["amount"]);
                            dr["fees_status"] = dr_online_fees[0]["amount"] + " + " + dr_online_fees[1]["amount"] + " = " + total_amount;
                            dr["transaction_id"] = "=\"" + dr_online_fees[0]["transaction_id"] + "\" , " + "=\"" + dr_online_fees[1]["transaction_id"] + "\" , ";
                            dr["Citrus_TxRefNo"] = dr_online_fees[0]["Citrus_TxRefNo"] + " , " + dr_online_fees[1]["Citrus_TxRefNo"];
                             
                        }
                        else 
                        {
                            dr["fees_status"] = dr_online_fees[0]["amount"];
                        }
                        
                    }
                    else
                    {
                        DataRow[] dr_fees_amount_per_credit;

                        if (get_data.Rows[i]["prof_details"].ToString() == "P")
                        {
                            dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='P'");
                        }
                        else
                        {
                            dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='S'");
                        }

                        dr["fees_date"] = get_data.Rows[i]["date"];
                        dr["payment_mode"] = "Manual";
                        //dr["allocate_credits"] = dr_online_fees[0]["credit"];

                        if (dr_fees_amount_per_credit.Length > 0)
                        {
                            if (waiver_credits > credit_choice)
                            {
                                dr["fees_status"] = 0;
                            }
                            else
                            {
                                if (installmant_status == "Y")
                                {
                                    dr["fees_status"] = ((credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"])) / 4;
                                }
                                else
                                {
                                    dr["fees_status"] = "0";
                                    //dr["fees_status"] = (credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"]);
                                }
                            }
                        }
                    }
                }
                else
                {
                    DataRow[] dr_fees_amount_per_credit;

                    if (get_data.Rows[i]["prof_details"].ToString() == "P")
                    {
                        dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='P'");
                    }
                    else
                    {
                        dr_fees_amount_per_credit = get_fees_amount_pre_credit.Select("year_desc = '" + get_data.Rows[i]["year_desc"].ToString() + "' and user_type ='S'");
                    }

                    dr["fees_date"] = get_data.Rows[i]["date"];
                    dr["payment_mode"] = "Manual";
                 
                    if (dr_fees_amount_per_credit.Length > 0)
                    {
                        if (waiver_credits > credit_choice)
                        {
                            dr["fees_status"] = 0;
                        }
                        else
                        {
                            if (installmant_status == "Y")
                            {
                                dr["fees_status"] = ((credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"])) / 4;
                            }
                            else
                            {
                                //dr["fees_status"] = (credit_choice - waiver_credits) * Convert.ToDecimal(dr_fees_amount_per_credit[0]["fees_amount"]);
                                dr["fees_status"] = "0";
                            }
                        }
                    }
                }

                if (dt_allodate_data != null)
                {
                    string allocate_course = "";
                    int allocate_credits = 0;

                    DataRow[] dr_allocate_course = dt_allodate_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

                    if (dr_allocate_course.Length > 0)
                    {
                        for (int k = 0; k < dr_allocate_course.Length; k++)
                        {
                            allocate_course += dr_allocate_course[k]["course_code"] + "-" + dr_allocate_course[k]["course_name"] + ", ";
                            allocate_credits += Convert.ToInt32(dr_allocate_course[k]["credits"]);
                        }

                        if (allocate_course != String.Empty)
                        {
                            //student_mandatory.instructor = instructor.Substring(0, instructor.Length - 1);
                            dr["allocate_course"] = allocate_course.Trim().TrimEnd(',');
                            dr["allocate_credits"] = allocate_credits;
                        }
                    }
                }

                dt.Rows.Add(dr);
            }

            if (dt != null)
            {
                dt.DefaultView.Sort = "department_name,program desc";
                dt = dt.DefaultView.ToTable();

                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    #endregion

    #region Report methods

    [WebMethod]
    public string Get_saved_selected_course_data_for_report(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.Get_saved_selected_course_data_for_report(sem_code, year_code);


        string code = "";

        if (get_data != null)
        {


            for (int i = 0; i < get_data.Rows.Count; i++)
            {

                String course_code = get_data.Rows[i]["course_code"].ToString();



                Ds_Student_Course_detail_WS.total_course_selected_reportRow total_report = obj_student.total_course_selected_report.Newtotal_course_selected_reportRow();

                DataRow[] dr = get_data.Select("course_code = '" + course_code + "'");

                if (code != course_code)
                {



                    if (dr.Length > 0)
                    {
                        total_report.course_code = course_code;
                        total_report.course_name = dr[0]["course_name"].ToString();
                        total_report.available_seat = dr[0]["available_seat"].ToString();
                        total_report.dept_name = dr[0]["dept_name"].ToString();
                        if (dr.Length == 1)
                        {


                            if (dr[0]["course_type"].ToString().Trim() == "M")
                            {
                                total_report.mandatory = dr[0]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.elective = dr[0]["total_course"].ToString();
                            }

                        }
                        else if (dr.Length == 2)
                        {
                            if (dr[0]["course_type"].ToString().Trim() == "M")
                            {
                                total_report.mandatory = dr[0]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.elective = dr[0]["total_course"].ToString();
                            }

                            if (dr[1]["course_type"] == "E")
                            {
                                total_report.elective = dr[1]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.mandatory = dr[1]["total_course"].ToString();
                            }
                        }
                    }


                    code = course_code;
                    obj_student.total_course_selected_report.Addtotal_course_selected_reportRow(total_report);
                }

            }


            DataTable dt = obj_student.total_course_selected_report;

            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    [WebMethod]
    public string Get_ws_saved_selected_course_data_for_report(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.Get_WS_saved_selected_course_data_for_report(sem_code, year_code);


        string code = "";

        if (get_data != null)
        {


            for (int i = 0; i < get_data.Rows.Count; i++)
            {

                String course_code = get_data.Rows[i]["course_code"].ToString();



                Ds_Student_Course_detail_WS.total_course_selected_reportRow total_report = obj_student.total_course_selected_report.Newtotal_course_selected_reportRow();

                DataRow[] dr = get_data.Select("course_code = '" + course_code + "'");

                if (code != course_code)
                {



                    if (dr.Length > 0)
                    {
                        total_report.course_code = course_code;
                        total_report.course_name = dr[0]["course_name"].ToString();
                        total_report.available_seat = dr[0]["available_seat"].ToString();
                        total_report.dept_name = dr[0]["dept_name"].ToString();
                        if (dr.Length == 1)
                        {


                            if (dr[0]["course_type"].ToString().Trim() == "M")
                            {
                                total_report.mandatory = dr[0]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.elective = dr[0]["total_course"].ToString();
                            }

                        }
                        else if (dr.Length == 2)
                        {
                            if (dr[0]["course_type"].ToString().Trim() == "M")
                            {
                                total_report.mandatory = dr[0]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.elective = dr[0]["total_course"].ToString();
                            }

                            if (dr[1]["course_type"] == "E")
                            {
                                total_report.elective = dr[1]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.mandatory = dr[1]["total_course"].ToString();
                            }
                        }
                    }


                    code = course_code;
                    obj_student.total_course_selected_report.Addtotal_course_selected_reportRow(total_report);
                }

            }


            DataTable dt = obj_student.total_course_selected_report;

            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    [WebMethod]
    public string get_allocate_course_data(string sem_code, string year_code, string dept_code)
    {
        DataTable get_data = objmaster.get_allocate_course_data_new(sem_code, "", dept_code);

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_ws_allocate_course_data(string sem_code, string year_code, string dept_code)
    {
        DataTable get_data = objmaster.get_ws_allocate_course_data_new(sem_code, year_code, dept_code);

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_ws_allocate_course_data_drop_by_student_from_popup(string sem_code, string year_code, string dept_code)
    {
        DataTable get_data = objmaster.get_ws_allocate_course_data_drop_by_student_from_popup(sem_code, year_code, dept_code);

        //get_data.Columns.Add("amount_paid");
        //get_data.Columns.Add("refund_amount");
        //get_data.Columns.Add("account_holder_name");
        //get_data.Columns.Add("bank_name");
        //get_data.Columns.Add("branch_name");
        //get_data.Columns.Add("branch_city");
        //get_data.Columns.Add("branch_state");
        //get_data.Columns.Add("account_type");
        //get_data.Columns.Add("ifsc_code");
        //get_data.Columns.Add("account_number");

        //  DataTable get_refund_data = objmaster.get_refund_data(sem_code, year_code);

        if (get_data != null)
        {
            //if (get_refund_data != null)
            //{

            //    for (int i = 0; i < get_data.Rows.Count; i++)
            //    {
            //        if (get_data.Rows[i]["user_id"].ToString() == "Y")
            //        {
            //            DataRow[] dr = get_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");
            //        }
            //    }

            //}

            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_registered_course_data_for_report(string sem_code, string year_code, string dept_code)
    {
        DataTable get_data = new DataTable();

        DataTable dt_allocate_data = objmaster.get_ws_allocate_course_data(sem_code, year_code, "");

        if (dt_allocate_data != null)
        {
            get_data = objmaster.get_registered_course_data_for_report_after_allocation(sem_code, year_code, dept_code);
        }
        else
        {
            get_data = objmaster.get_registered_course_data_for_report(sem_code, year_code, dept_code);
        }


        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_seats_dtl_of_course(string sem_code, string dept_code)
    {
        DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();

        string current_ws_sem = "";
        string current_ws_year = "";


        if (dt_ws_current_sem != null)
        {
            current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        DataTable get_data = objmaster.get_seats_dtl_of_course(current_ws_sem, dept_code, current_ws_year);

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string[] Get_all_student_data_for_manually_allocation(string year_code, string dept_code, string prog_code, string sem_code, string course_code)
    {
        string user_type = "";

        DataTable dt_WS_Course_dtl = objmaster.Get_WS_Course_dtl(sem_code, year_code, course_code);
        if (dt_WS_Course_dtl != null)
        {
            if (dt_WS_Course_dtl.Rows[0]["course_type"].ToString() == "HS")
            {
                user_type = "HS";
            }
        }

        DataTable Get_student_data = objmaster.Get_student_data_for_manually_allocation_new("", dept_code, prog_code, user_type);

        DataTable get_old_allocate_data = objmaster.get_ws_student_allcate_course_dtl_data(sem_code, year_code, course_code);
        DataTable get_Studnt_change_course_type = objmaster.Ws_Studnt_change_course_type(sem_code, year_code, course_code, dept_code, prog_code);

        if (Get_student_data != null)
        {
            Get_student_data.DefaultView.Sort = "user_id  asc";
            Get_student_data = Get_student_data.DefaultView.ToTable();

            json_array[0] = GetJson1(Get_student_data);
        }

        if (get_old_allocate_data != null)
        {
            json_array[1] = GetJson1(get_old_allocate_data);
        }
        if (get_Studnt_change_course_type != null)
        {
            json_array[2] = GetJson1(get_Studnt_change_course_type);
        }

        return json_array;
    }

    [WebMethod]
    public string Get_all_student_data_for_manually_printpayslip(string dept_code, string prog_code, string year_code)
    {
        DataTable Get_student_data = objmaster.Get_student_data_for_manually_allocation(year_code, dept_code, prog_code);

        if (Get_student_data != null)
        {
            Get_student_data.DefaultView.Sort = "user_id  asc";
            Get_student_data = Get_student_data.DefaultView.ToTable();

            jsondata = GetJson1(Get_student_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string Get_course_data_for_add_manually_before_allocation(string year_code, string sem_code, string course_code)
    {
        DataTable Get_student_data = objmaster.Get_course_data_for_add_manually_before_allocation(year_code, sem_code, course_code);

        if (Get_student_data != null)
        {
            Get_student_data.DefaultView.Sort = "user_id  asc";
            Get_student_data = Get_student_data.DefaultView.ToTable();

            jsondata = GetJson1(Get_student_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string Get_prority_wise_registered_data_with_pivot(string sem_code, string year_code)
    {
        DataTable Get_student_priority_data = objmaster.Get_prority_wise_registered_data_with_pivot(sem_code, year_code);

        if (Get_student_priority_data != null)
        {

            jsondata = GetJson1(Get_student_priority_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string remove_all_allocate_data(string sem_code, string year_code)
    {
        DataTable dt_already_allocated = objmaster.get_allocate_course_data(sem_code, year_code, "");
        string msg = "";

        if (dt_already_allocated == null)
        {
            msg = "No old Allocation found in system.";
        }
        else
        {
            Boolean get_data = objmaster.remove_all_allocate_data(sem_code, year_code);

            if (get_data == true)
            {
                msg = "Allocation Remove Succesfully for selected semester and year";
            }
            else
            {
                msg = "Problem in Remove data";
            }
        }

        return msg;
    }

    [WebMethod(EnableSession = true)]
    public string publish_allocation_data(string sem_code, string year_code)
    {
        DataTable dt_already_allocated = objmaster.get_allocate_course_data(sem_code, year_code, "");
        string msg = "";

        string flag = "N";

        if (dt_already_allocated != null)
        {
        }
        else
        {
            msg = "Allocation are not completed for selected semester and year.you can not publish it";
            return msg;
        }

        DataTable dt_already_published = objmaster.get_publish_allocation_data(sem_code, year_code);

        if (dt_already_published != null)
        {
            if (dt_already_published.Rows.Count > 0)
            {
                if (dt_already_published.Rows[0]["publish_flag"].ToString() == "Y")
                {
                    msg = "Allocation already published for selected semester and year";
                }
                else
                {
                    Boolean get_data = objmaster.update_published_allocation(sem_code, year_code, "admin", HttpContext.Current.Request.UserHostName);

                    if (get_data == true)
                    {
                        msg = "Allocation published Succesfully for selected semester and year";
                        flag = "Y";
                    }
                    else
                    {
                        msg = "Problem in Remove data";
                    }
                }
            }
            else
            {

            }
        }
        else
        {
            Boolean get_data = objmaster.insert_published_allocation(sem_code, year_code, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);

            if (get_data == true)
            {
                msg = "Allocation published Succesfully for selected semester and year";
                flag = "Y";
            }
            else
            {
                msg = "Problem in publish  data";
            }
        }

        if (flag == "Y")
        {
            DataTable dt_send_mail_data = objmaster.get_allocate_user_for_send_mail(sem_code, year_code);

            //DataRow[] dr = dt_send_mail_data.Select("dept_code ='1' and prog_code =''");
            string subject = "Course Allocation for SWS";
            //string path = "https://connect.cept.ac.in//image/popup_allocation_new.png";
            string path = "https://connect.cept.ac.in//image/sws_allocation_screen.png";

            string remark = "Dear Student,";

            //remark += "<br /><br />The allocation of courses for Winter School 2021 has been done. Please check your dashboard on http://sws.cept.ac.in and you will see the following note on the screen. <b>You will have to accept/drop the course.</b>";
            remark += "<br /><br />The allocation of courses for Summer School 2022 has been done. Please check your dashboard on http://sws.cept.ac.in and you will see the following note on the screen. <b>You will see the following on the screen.</b>";
            remark += "<br /><br /><img style='width:60%' src= " + path + " />";

            remark += "<br /><br /><b>NOTE: - After the deadline to drop courses (24 hours after allocation), SWS will examine the final registration in each course. In case a course is found to be unviable due to very few numbers of finally registered students, SWS will have to close such courses. Students registered in such courses being closed, will get the option of registering in any other open course for Summer School 2022 (on first come first serve basis) or to transfer their unused parked credits for future SWS cycle.</b>";

            //remark += "<br /><br /><b>If not clicked \"Accept / Drop\" Button, it will be considered \"Accepted\" after the 29th September Midnight.</b>";
            //remark += "<br /><br /><b>If not clicked \"Accept / Drop\" Button, It will be considered \"Accepted\" in 72 hours.</b>";
            remark += "<br /><br />For further queries, contact summer winter school office.";
            remark += "<br /><br />Regards,";
            remark += "<br />Summer Winter School";

            subject = "";
            remark = "";

            DataTable dt_email_data = objmaster.GetEmailTemplate("SWSAllocation", "email");
            
            if (dt_email_data != null)
            {
                subject = dt_email_data.Rows[0]["subject"].ToString();
                remark = dt_email_data.Rows[0]["body"].ToString();
            }

            objmail.sendmailforpublishnew(dt_send_mail_data, remark, subject);

            //<-------------- Send Mail Courses are Not Allocated ----------------->

            //DataTable dt_send_mail_data_not_allocate = objmaster.get_Student_not_allocate_Course_for_send_mail(sem_code, year_code);
            //
            //string subject_not_allocate = "Course Allocation for SWS";
            //
            //string remark_not_allocate = "Dear Student,";
            //
            //remark_not_allocate += "<br /><br />The allocation of courses for Winter School 2019 has been done. You have not been allotted the course as per your priority. Kindly contact SWS office regarding the same.</b>";
            //remark_not_allocate += "<br /><br />Regards,";
            //remark_not_allocate += "<br />Summer Winter School";
            //
            //objmail.sendmailforpublish(dt_send_mail_data_not_allocate, remark_not_allocate, subject_not_allocate);
        }

        return msg;
    }

    [WebMethod(EnableSession = true)]
    public string send_test_email()
    {
        //DataTable dt_send_mail_data = objmaster.get_allocate_user_for_send_mail(sem_code, year_code);
        //DataRow[] dr = dt_send_mail_data.Select("dept_code ='1' and prog_code =''");

        string subject = "Course Allocation for SWS";
        string path = "https://connect.cept.ac.in//image/popup_allocation_new.png";

        string remark = "Dear Students,";

        remark += "<br /><br />The allocation of courses for Summer School 2017 has been done.Please check your dashboard on http://sws.cept.ac.in and you will see the following note on screen.<b>You will have to accept/drop the course.</b>";
        remark += "<br /><br /><img style='width:60%' src= " + path + " />";
        remark += "<br /><br /><b>If not clicked \"Accept / Drop\" Button, it will be considered \"Accepted\" after the 12th March Midnight.</b>";
        remark += "<br /><br />For further queries, contact summer winter school office.";
        remark += "<br /><br />Regards,";
        remark += "<br />Summer Winter School";

        //string subject = "CEPT TEST";
        //string remark = "please Ignore this mail";

        objmail.send_test_mail(remark, subject);

        return "";
    }

    [WebMethod]
    public string get_total_offered_course_report()
    {
        DataTable get_data = objmaster.get_total_offered_course_report();
        DataTable dt = new DataTable();

        DataRow dr;
        dt.Columns.Add("no");
        dt.Columns.Add("mandatory");
        dt.Columns.Add("elective");
        dt.Columns.Add("total");

        if (get_data != null)
        {
            dr = dt.NewRow();

            dr["no"] = "No. of Courses";
            dr["mandatory"] = get_data.Rows[0]["course_code"].ToString();
            dr["elective"] = get_data.Rows[1]["course_code"].ToString();
            dr["total"] = Convert.ToInt32(get_data.Rows[0]["course_code"]) + Convert.ToInt32(get_data.Rows[1]["course_code"]);

            dt.Rows.Add(dr);

            dr = dt.NewRow();

            dr["no"] = "No. of Credit";
            dr["mandatory"] = get_data.Rows[0]["total_credits"].ToString();
            dr["elective"] = get_data.Rows[1]["total_credits"].ToString();
            dr["total"] = Convert.ToInt32(get_data.Rows[0]["total_credits"]) + Convert.ToInt32(get_data.Rows[1]["total_credits"]);

            dt.Rows.Add(dr);

            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }

        return jsondata;
    }

    [WebMethod]
    public string get_consolidates_data(string year_code, string semester, string dept_code, string prog_code)
    {
        DataTable get_data = objmaster.Get_ws_user_userfees(dept_code, "", "", prog_code);
        DataTable dt_all_allocated_data = objmaster.get_ws_allocate_course_data_new_for_report(semester, year_code, "");
        DataTable dt_fees_status = objmaster.Get_WS_fees_status_for_student_for_assign(semester, year_code);
        DataTable dt_credit_choice = objmaster.Get_WS_credit_choice_for_student_for_assign(semester, year_code);
        DataTable dt = new DataTable();

        DataRow dr;
        dt.Columns.Add("student_code");
        dt.Columns.Add("student_name");
        dt.Columns.Add("course_code1");
        dt.Columns.Add("course_name1");
        dt.Columns.Add("credits1");
        dt.Columns.Add("course_code2");
        dt.Columns.Add("course_name2");
        dt.Columns.Add("credits2");
        dt.Columns.Add("course_code3");
        dt.Columns.Add("course_name3");
        dt.Columns.Add("credits3");
        dt.Columns.Add("fees_status");
        dt.Columns.Add("waiver_credits");
        dt.Columns.Add("installment");
        dt.Columns.Add("registration_status");
        dt.Columns.Add("mobile_no");
        dt.Columns.Add("email");
        dt.Columns.Add("credit_choice");

        if (get_data != null)
        {
            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                dr = dt.NewRow();
                dr["mobile_no"] = "";
                dr["email"] = "";
                dr["student_code"] = get_data.Rows[i]["user_id"].ToString();
                dr["student_name"] = get_data.Rows[i]["user_name"].ToString();
                dr["mobile_no"] = get_data.Rows[i]["mobile_no"].ToString();
                dr["email"] = get_data.Rows[i]["mail"].ToString();
                dr["course_code1"] = "";
                dr["course_name1"] = "";
                dr["credits1"] = "";
                dr["course_code2"] = "";
                dr["course_name2"] = "";
                dr["credits2"] = "";
                dr["course_code3"] = "";
                dr["course_name3"] = "";
                dr["credits3"] = "";
                dr["credit_choice"] = "";

                if (get_data.Rows[i]["user_id"].ToString() == "UI2312")
                {
                }

                if (dt_all_allocated_data != null)
                {
                    DataRow[] dr_course = dt_all_allocated_data.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "'");

                    if (dr_course.Length > 0)
                    {
                        dr["course_code1"] = dr_course[0]["course_code"].ToString();
                        dr["course_name1"] = dr_course[0]["course_name"].ToString();
                        dr["credits1"] = dr_course[0]["credits"].ToString();
                        dr["registration_status"] = "Completed";

                        if (dr_course.Length == 2)
                        {
                            dr["course_code2"] = dr_course[1]["course_code"].ToString();
                            dr["course_name2"] = dr_course[1]["course_name"].ToString();
                            dr["credits2"] = dr_course[1]["credits"].ToString();
                        }

                        if (dr_course.Length == 3)
                        {
                            dr["course_code3"] = dr_course[2]["course_code"].ToString();
                            dr["course_name3"] = dr_course[2]["course_name"].ToString();
                            dr["credits3"] = dr_course[2]["credits"].ToString();
                        }
                    }
                }

                dr["fees_status"] = "";
                dr["waiver_credits"] = "";
                dr["installment"] = "";

                if (dt_fees_status != null)
                {
                    DataRow[] dr_fees = dt_fees_status.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "' and dept_code = '" + get_data.Rows[i]["dept_code"].ToString() + "'");

                    if (dr_fees.Length > 0)
                    {
                        if (dr_fees[0]["fees_status"].ToString() != "")
                        {
                            if (dr_fees[0]["fees_status"].ToString() == "Y")
                            {
                                dr["fees_status"] = "Fee Paid";
                            }
                            else
                            {
                                dr["fees_status"] = "Unpaid";
                            }
                        }
                        else
                        {
                            dr["fees_status"] = "Unpaid";
                        }

                        if (dr_fees[0]["waiver_credits"].ToString() != "")
                        {
                            dr["waiver_credits"] = dr_fees[0]["waiver_credits"].ToString();
                        }

                        if (dr_fees[0]["fees_type"].ToString() != "")
                        {
                            if (dr_fees[0]["fees_type"].ToString() == "Y" || dr_fees[0]["fees_type"].ToString() == "F")
                            {
                            }

                            //if (dr_fees[0]["fees_type"].ToString() == "I")
                            //{
                            //    dr["installment"] = "Yes";
                            //}
                        }

                        if (dr_fees[0]["installmant_status"].ToString() != "")
                        {
                            if (dr_fees[0]["installmant_status"].ToString() == "Y")
                            {
                                dr["installment"] = "Yes";
                            }
                        }
                    }
                }

                if (dt_credit_choice != null)
                {
                    DataRow[] dr_credit_choice = dt_credit_choice.Select("user_id = '" + get_data.Rows[i]["user_id"].ToString() + "' ");

                    if (dr_credit_choice.Length > 0)
                    {
                        dr["credit_choice"] = dr_credit_choice[0]["credit_choice"].ToString();
                    }
                }

                dt.Rows.Add(dr);
            }

            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }

        return jsondata;
    }

    [WebMethod]
    public string get_faculty_wise_total_course_report()
    {
        DataTable get_data = objmaster.get_faculty_wise_total_course_report();

        DataRow dr;

        Decimal total_course = 0;
        Decimal total_credits = 0;

        if (get_data != null)
        {
            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                total_course += Convert.ToDecimal(get_data.Rows[i]["course_code"]);
                total_credits += Convert.ToDecimal(get_data.Rows[i]["credits"]);
            }

            //dr = get_data.NewRow();
            //dr["course_code"] = total_course.ToString();
            //dr["credits"] = total_credits.ToString();
            //dr["dept_name"] = "Total";

            //get_data.Rows.Add(dr);

            if (get_data != null)
            {
                jsondata = GetJson1(get_data);
            }
        }

        return jsondata;
    }

    [WebMethod]
    public string get_faculty_type_wise_total_course_report()
    {
        DataTable get_data = objmaster.get_faculty_type_wise_total_course_report();

        DataTable dt = new DataTable();

        dt.Columns.Add("dept_name");
        dt.Columns.Add("mandatory_course");
        dt.Columns.Add("elective_course");
        dt.Columns.Add("total_course");
        dt.Columns.Add("mandatory_credits");
        dt.Columns.Add("elective_credits");
        dt.Columns.Add("total_credits");

        string dept_name = "";

        DataRow dr;

        Decimal total_mandatory_course = 0;
        Decimal total_elective_course = 0;
        Decimal total_total_course = 0;
        Decimal total_mandatory_credits = 0;
        Decimal total_elective_credits = 0;
        Decimal total_total_credits = 0;

        if (get_data != null)
        {
            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                if (dept_name != get_data.Rows[i]["dept_name"].ToString())
                {
                    dr = dt.NewRow();
                    dr["dept_name"] = get_data.Rows[i]["dept_name"].ToString();
                    dr["elective_course"] = get_data.Rows[i]["course_code"].ToString();
                    dr["elective_credits"] = get_data.Rows[i]["credits"].ToString();

                    dt.Rows.Add(dr);
                }
                else
                {
                    DataRow[] dr1 = dt.Select("dept_name = '" + get_data.Rows[i]["dept_name"].ToString() + "'");

                    if (dr1.Length > 0)
                    {
                        dr1[0]["mandatory_course"] = get_data.Rows[i]["course_code"].ToString();
                        dr1[0]["mandatory_credits"] = get_data.Rows[i]["credits"].ToString();
                        dr1[0]["total_course"] = Convert.ToInt32(dr1[0]["mandatory_course"]) + Convert.ToInt32(dr1[0]["elective_course"]);
                        dr1[0]["total_credits"] = Convert.ToInt32(dr1[0]["mandatory_credits"]) + Convert.ToInt32(dr1[0]["elective_credits"]);
                    }
                }

                dept_name = get_data.Rows[i]["dept_name"].ToString();
            }

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                total_mandatory_course += Convert.ToDecimal(dt.Rows[i]["mandatory_course"]);
                total_elective_course += Convert.ToDecimal(dt.Rows[i]["elective_course"]);
                total_total_course += Convert.ToDecimal(dt.Rows[i]["total_course"]);
                total_mandatory_credits += Convert.ToDecimal(dt.Rows[i]["mandatory_credits"]);
                total_elective_credits += Convert.ToDecimal(dt.Rows[i]["elective_credits"]);
                total_total_credits += Convert.ToDecimal(dt.Rows[i]["total_credits"]);
            }

            //dr = dt.NewRow();
            //dr["dept_name"] = "Total";
            //dr["elective_course"] = total_elective_course.ToString();
            //dr["elective_credits"] = total_elective_credits.ToString();
            //dr["mandatory_course"] = total_mandatory_course.ToString();
            //dr["mandatory_credits"] = total_mandatory_credits.ToString();
            //dr["total_course"] = total_total_course.ToString();
            //dr["total_credits"] = total_total_credits.ToString(); 
            //dt.Rows.Add(dr);

            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }

        return jsondata;
    }

    [WebMethod]
    public string get_course_type_offered_report()
    {
        DataTable get_data = objmaster.get_course_type_offered_report();
        Decimal total_course = 0;
        Decimal total_credits = 0;
        DataRow dr;

        if (get_data != null)
        {
            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                total_course += Convert.ToDecimal(get_data.Rows[i]["course_code"]);
                total_credits += Convert.ToDecimal(get_data.Rows[i]["course_credits"]);
            }

            //dr = get_data.NewRow();
            //dr["course_type"] = "Total";
            //dr["course_code"] = total_course.ToString();
            //dr["course_credits"] = total_credits.ToString();

            //get_data.Rows.Add(dr);

            if (get_data != null)
            {
                jsondata = GetJson1(get_data);
            }
        }

        return jsondata;
    }

    [WebMethod]
    public string get_course_type_various_offered_report()
    {
        DataTable get_data = objmaster.get_course_type_and_credits_offered_report();
        DataTable dt = new DataTable();

        //for (int i = 0; i < get_data.Rows.Count; i++)
        //{
        //    dt.Columns.Add(get_data.Rows[i]["course_type"].ToString());
        //}

        dt.Columns.Add("dept_name");
        dt.Columns.Add("lecture");
        dt.Columns.Add("seminar");
        dt.Columns.Add("studio");
        dt.Columns.Add("workshop");
        dt.Columns.Add("design_workshop");
        dt.Columns.Add("ghuided_research");
        dt.Columns.Add("independent_study");
        dt.Columns.Add("intership");
        dt.Columns.Add("total");

        Decimal total_FA = 0, total_FD = 0, total_FM = 0, total_FP = 0, total_FT = 0;
        Decimal total_credits = 0;
        DataRow dr;
        String deptname = "";
        Ds_Student_Course_detail_WS.course_types_creditsRow obj_course;

        if (get_data != null)
        {
            DataRow[] dr_fa = get_data.Select("dept_name = 'FA'");

            if (dr_fa.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;

                dr["dept_name"] = "FA";

                for (int i = 0; i < dr_fa.Length; i++)
                {
                    if (dr_fa[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }


                    if (dr_fa[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fa[i]["course_code"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_code"].ToString());
                    }
                }

                dr["total"] = total_FA.ToString();
                dt.Rows.Add(dr);
            }

            DataRow[] dr_fd = get_data.Select("dept_name = 'FD'");

            if (dr_fd.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;

                dr["dept_name"] = "FD";

                for (int i = 0; i < dr_fd.Length; i++)
                {
                    if (dr_fd[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }


                    if (dr_fd[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fd[i]["course_code"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_code"].ToString());
                    }
                }

                dr["total"] = total_FD.ToString();
                dt.Rows.Add(dr);
            }

            DataRow[] dr_fm = get_data.Select("dept_name = 'FM'");

            if (dr_fm.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;
                dr["dept_name"] = "FM";

                for (int i = 0; i < dr_fm.Length; i++)
                {
                    if (dr_fm[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fm[i]["course_code"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_code"].ToString());
                    }
                }

                dr["total"] = total_FM.ToString();
                dt.Rows.Add(dr);
            }

            DataRow[] dr_fp = get_data.Select("dept_name = 'FP'");

            if (dr_fp.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;
                dr["dept_name"] = "FP";

                for (int i = 0; i < dr_fp.Length; i++)
                {
                    if (dr_fp[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fp[i]["course_code"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_code"].ToString());
                    }
                }

                dr["total"] = total_FP.ToString();
                dt.Rows.Add(dr);
            }

            DataRow[] dr_ft = get_data.Select("dept_name = 'FT'");

            if (dr_ft.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;
                dr["dept_name"] = "FT";

                for (int i = 0; i < dr_ft.Length; i++)
                {
                    if (dr_ft[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_ft[i]["course_code"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_code"].ToString());
                    }
                }

                dr["total"] = total_FT.ToString();
                dt.Rows.Add(dr);
            }

            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }

        return jsondata;
    }

    [WebMethod]
    public string get_course_type_credit_various_offered_report()
    {
        DataTable get_data = objmaster.get_course_type_and_credits_offered_report();

        DataTable dt = new DataTable();


        dt.Columns.Add("dept_name");
        dt.Columns.Add("lecture");
        dt.Columns.Add("seminar");
        dt.Columns.Add("studio");
        dt.Columns.Add("workshop");
        dt.Columns.Add("design_workshop");
        dt.Columns.Add("ghuided_research");
        dt.Columns.Add("independent_study");
        dt.Columns.Add("intership");
        dt.Columns.Add("total");




        Decimal total_FA = 0, total_FD = 0, total_FM = 0, total_FP = 0, total_FT = 0;

        Decimal total_credits = 0;


        DataRow dr;


        string deptname = "";


        Ds_Student_Course_detail_WS.course_types_creditsRow obj_course;

        if (get_data != null)
        {


            DataRow[] dr_fa = get_data.Select("dept_name = 'FA'");

            if (dr_fa.Length > 0)
            {

                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;

                dr["dept_name"] = "FA";

                for (int i = 0; i < dr_fa.Length; i++)
                {
                    if (dr_fa[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fa[i]["course_credits"].ToString();

                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fa[i]["course_credits"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fa[i]["course_credits"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fa[i]["course_credits"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fa[i]["course_credits"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fa[i]["course_credits"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fa[i]["course_credits"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                    if (dr_fa[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fa[i]["course_credits"].ToString();
                        total_FA += Convert.ToDecimal(dr_fa[i]["course_credits"].ToString());
                    }

                }

                dr["total"] = total_FA.ToString();

                dt.Rows.Add(dr);

            }


            DataRow[] dr_fd = get_data.Select("dept_name = 'FD'");

            if (dr_fd.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;

                dr["dept_name"] = "FD";

                for (int i = 0; i < dr_fd.Length; i++)
                {
                    if (dr_fd[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fd[i]["course_credits"].ToString();

                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fd[i]["course_credits"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fd[i]["course_credits"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fd[i]["course_credits"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }


                    if (dr_fd[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fd[i]["course_credits"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fd[i]["course_credits"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fd[i]["course_credits"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }

                    if (dr_fd[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fd[i]["course_credits"].ToString();
                        total_FD += Convert.ToDecimal(dr_fd[i]["course_credits"].ToString());
                    }
                }

                dr["total"] = total_FD.ToString();

                dt.Rows.Add(dr);

            }

            DataRow[] dr_fm = get_data.Select("dept_name = 'FM'");

            if (dr_fm.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;
                dr["dept_name"] = "FM";

                for (int i = 0; i < dr_fm.Length; i++)
                {
                    if (dr_fm[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fm[i]["course_credits"].ToString();

                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fm[i]["course_credits"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fm[i]["course_credits"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fm[i]["course_credits"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fm[i]["course_credits"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fm[i]["course_credits"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fm[i]["course_credits"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }

                    if (dr_fm[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fm[i]["course_credits"].ToString();
                        total_FM += Convert.ToDecimal(dr_fm[i]["course_credits"].ToString());
                    }
                }

                dr["total"] = total_FM.ToString();

                dt.Rows.Add(dr);

            }

            DataRow[] dr_fp = get_data.Select("dept_name = 'FP'");

            if (dr_fp.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;
                dr["dept_name"] = "FP";

                for (int i = 0; i < dr_fp.Length; i++)
                {
                    if (dr_fp[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_fp[i]["course_credits"].ToString();

                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_fp[i]["course_credits"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_fp[i]["course_credits"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_fp[i]["course_credits"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_fp[i]["course_credits"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_fp[i]["course_credits"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_fp[i]["course_credits"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }

                    if (dr_fp[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_fp[i]["course_credits"].ToString();
                        total_FP += Convert.ToDecimal(dr_fp[i]["course_credits"].ToString());
                    }
                }

                dr["total"] = total_FP.ToString();

                dt.Rows.Add(dr);

            }

            DataRow[] dr_ft = get_data.Select("dept_name = 'FT'");

            if (dr_ft.Length > 0)
            {
                dr = dt.NewRow();

                dr["lecture"] = 0;
                dr["seminar"] = 0;
                dr["studio"] = 0;
                dr["workshop"] = 0;
                dr["design_workshop"] = 0;
                dr["ghuided_research"] = 0;
                dr["independent_study"] = 0;
                dr["intership"] = 0;
                dr["dept_name"] = "FT";

                for (int i = 0; i < dr_ft.Length; i++)
                {
                    if (dr_ft[i]["course_type"].ToString() == "lecture")
                    {
                        dr["lecture"] = dr_ft[i]["course_credits"].ToString();

                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "seminar")
                    {
                        dr["seminar"] = dr_ft[i]["course_credits"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "studio")
                    {
                        dr["studio"] = dr_ft[i]["course_credits"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "workshop")
                    {
                        dr["workshop"] = dr_ft[i]["course_credits"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "design_workshop")
                    {
                        dr["design_workshop"] = dr_ft[i]["course_credits"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "ghuided_research")
                    {
                        dr["ghuided_research"] = dr_ft[i]["course_credits"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "Independent Study")
                    {
                        dr["independent_study"] = dr_ft[i]["course_credits"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }

                    if (dr_ft[i]["course_type"].ToString() == "Internship")
                    {
                        dr["intership"] = dr_ft[i]["course_credits"].ToString();
                        total_FT += Convert.ToDecimal(dr_ft[i]["course_credits"].ToString());
                    }
                }

                dr["total"] = total_FT.ToString();

                dt.Rows.Add(dr);

            }


            //if (dr_fa)
            //{

            //}







            //dr = get_data.NewRow();
            //dr["course_type"] = "Total";
            //dr["course_code"] = total_course.ToString();
            //dr["course_credits"] = total_credits.ToString();

            //get_data.Rows.Add(dr);


            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    [WebMethod]
    public string get_registration_report_data(string dept_code, string semester)
    {
        DataTable get_data = objmaster.get_registration_report_data(dept_code, semester);


        DataTable dt = new DataTable();

        dt.Columns.Add("code");
        dt.Columns.Add("name");
        dt.Columns.Add("elective_course");
        dt.Columns.Add("elective_credits");
        dt.Columns.Add("mandatory_course");
        dt.Columns.Add("mandatory_credits");

        //dt.Columns.Add("total_credits");

        string user_id = "";

        DataRow dr;


        if (get_data != null)
        {

            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                if (user_id != get_data.Rows[i]["user_id"].ToString())
                {


                    if (get_data.Rows[i]["course_type"].ToString() == "E")
                    {
                        dr = dt.NewRow();



                        dr["code"] = get_data.Rows[i]["user_id"].ToString();
                        dr["name"] = get_data.Rows[i]["user_name"].ToString();
                        dr["elective_course"] = get_data.Rows[i]["course_code"].ToString();
                        dr["elective_credits"] = get_data.Rows[i]["credits"].ToString();


                        dt.Rows.Add(dr);
                    }
                    else
                    {
                        dr = dt.NewRow();



                        dr["code"] = get_data.Rows[i]["user_id"].ToString();
                        dr["name"] = get_data.Rows[i]["user_name"].ToString();
                        dr["mandatory_course"] = get_data.Rows[i]["course_code"].ToString();
                        dr["mandatory_credits"] = get_data.Rows[i]["credits"].ToString();


                        dt.Rows.Add(dr);
                    }


                }
                else
                {
                    DataRow[] dr1 = dt.Select("code = '" + get_data.Rows[i]["user_id"].ToString() + "'");

                    if (dr1.Length > 0)
                    {
                        dr1[0]["mandatory_course"] = get_data.Rows[i]["course_code"].ToString();
                        dr1[0]["mandatory_credits"] = get_data.Rows[i]["credits"].ToString();
                        //dr1[0]["total_course"] = Convert.ToInt32(dr1[0]["mandatory_course"]) + Convert.ToInt32(dr1[0]["elective_course"]);
                        //dr1[0]["total_credits"] = Convert.ToInt32(dr1[0]["mandatory_credits"]) + Convert.ToInt32(dr1[0]["elective_credits"]);

                    }

                }


                user_id = get_data.Rows[i]["user_id"].ToString();

            }





            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    [WebMethod]
    public string get_assigned_report_data(string dept_code, string semester)
    {
        DataTable get_data = objmaster.get_assigned_report_data(dept_code, semester);


        DataTable dt = new DataTable();

        dt.Columns.Add("code");
        dt.Columns.Add("name");
        dt.Columns.Add("elective_course");
        dt.Columns.Add("elective_credits");
        dt.Columns.Add("mandatory_course");
        dt.Columns.Add("mandatory_credits");

        //dt.Columns.Add("total_credits");

        string user_id = "";

        DataRow dr;


        if (get_data != null)
        {

            for (int i = 0; i < get_data.Rows.Count; i++)
            {
                if (user_id != get_data.Rows[i]["user_id"].ToString())
                {


                    if (get_data.Rows[i]["course_type"].ToString() == "E")
                    {
                        dr = dt.NewRow();



                        dr["code"] = get_data.Rows[i]["user_id"].ToString();
                        dr["name"] = get_data.Rows[i]["user_name"].ToString();
                        dr["elective_course"] = get_data.Rows[i]["course_code"].ToString();
                        dr["elective_credits"] = get_data.Rows[i]["credits"].ToString();


                        dt.Rows.Add(dr);
                    }
                    else
                    {
                        dr = dt.NewRow();



                        dr["code"] = get_data.Rows[i]["user_id"].ToString();
                        dr["name"] = get_data.Rows[i]["user_name"].ToString();
                        dr["mandatory_course"] = get_data.Rows[i]["course_code"].ToString();
                        dr["mandatory_credits"] = get_data.Rows[i]["credits"].ToString();


                        dt.Rows.Add(dr);
                    }


                }
                else
                {
                    DataRow[] dr1 = dt.Select("code = '" + get_data.Rows[i]["user_id"].ToString() + "'");

                    if (dr1.Length > 0)
                    {
                        dr1[0]["mandatory_course"] = get_data.Rows[i]["course_code"].ToString();
                        dr1[0]["mandatory_credits"] = get_data.Rows[i]["credits"].ToString();
                        //dr1[0]["total_course"] = Convert.ToInt32(dr1[0]["mandatory_course"]) + Convert.ToInt32(dr1[0]["elective_course"]);
                        //dr1[0]["total_credits"] = Convert.ToInt32(dr1[0]["mandatory_credits"]) + Convert.ToInt32(dr1[0]["elective_credits"]);

                    }

                }


                user_id = get_data.Rows[i]["user_id"].ToString();

            }





            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    [WebMethod]
    public string[] get_cross_registration__Faculty_report_data(string year_code, string semester)
    {



        try
        {


            string[] data = new string[2];

            string json = "";

            DataTable get_data = objmaster.get_assigned_cross_registration_faculty_report(year_code, semester);


            DataTable dt = new DataTable();
            DataTable dt_credit = new DataTable();

            dt.Columns.Add("Faculty");
            dt.Columns.Add("FA");
            dt.Columns.Add("FD");
            dt.Columns.Add("FM");
            dt.Columns.Add("FP");
            dt.Columns.Add("FT");

            dt_credit.Columns.Add("Faculty");
            dt_credit.Columns.Add("FA");
            dt_credit.Columns.Add("FD");
            dt_credit.Columns.Add("FM");
            dt_credit.Columns.Add("FP");
            dt_credit.Columns.Add("FT");



            string user_id = "";

            DataRow dr, dr_credits;




            if (get_data != null)
            {
                DataRow[] dr_fa = get_data.Select("user_dept = '1'");

                if (dr_fa.Length > 0)
                {

                    dr = dt.NewRow();
                    dr_credits = dt_credit.NewRow();

                    dr["Faculty"] = "FA";
                    dr_credits["Faculty"] = "FA";

                    dr["FA"] = 0;
                    dr["FD"] = 0;
                    dr["FM"] = 0;
                    dr["FP"] = 0;
                    dr["FT"] = 0;


                    dr_credits["FA"] = 0;
                    dr_credits["FD"] = 0;
                    dr_credits["FM"] = 0;
                    dr_credits["FP"] = 0;
                    dr_credits["FT"] = 0;

                    for (int i = 0; i < dr_fa.Length; i++)
                    {
                        if (dr_fa[i]["dept_code"].ToString() == "2")
                        {
                            dr["FD"] = dr_fa[i]["course_code"].ToString();

                            dr_credits["FD"] = dr_fa[i]["credits"].ToString();
                        }

                        if (dr_fa[i]["dept_code"].ToString() == "3")
                        {
                            dr["FM"] = dr_fa[i]["course_code"].ToString();
                            dr_credits["FM"] = dr_fa[i]["credits"].ToString();
                        }

                        if (dr_fa[i]["dept_code"].ToString() == "4")
                        {
                            dr["FP"] = dr_fa[i]["course_code"].ToString();
                            dr_credits["FP"] = dr_fa[i]["credits"].ToString();
                        }

                        if (dr_fa[i]["dept_code"].ToString() == "5")
                        {
                            dr["FT"] = dr_fa[i]["course_code"].ToString();
                            dr_credits["FT"] = dr_fa[i]["credits"].ToString();
                        }
                    }

                    dt.Rows.Add(dr);

                    dt_credit.Rows.Add(dr_credits);

                }

                DataRow[] dr_fd = get_data.Select("user_dept = '2'");

                if (dr_fd.Length > 0)
                {

                    dr = dt.NewRow();
                    dr_credits = dt_credit.NewRow();


                    dr["Faculty"] = "FD";
                    dr_credits["Faculty"] = "FD";

                    dr["FA"] = 0;
                    dr["FD"] = 0;
                    dr["FM"] = 0;
                    dr["FP"] = 0;
                    dr["FT"] = 0;


                    dr_credits["FA"] = 0;
                    dr_credits["FD"] = 0;
                    dr_credits["FM"] = 0;
                    dr_credits["FP"] = 0;
                    dr_credits["FT"] = 0;

                    for (int i = 0; i < dr_fd.Length; i++)
                    {
                        if (dr_fd[i]["dept_code"].ToString() == "1")
                        {
                            dr["FA"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FA"] = dr_fd[i]["credits"].ToString();
                        }

                        if (dr_fd[i]["dept_code"].ToString() == "3")
                        {
                            dr["FM"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FM"] = dr_fd[i]["credits"].ToString();
                        }

                        if (dr_fd[i]["dept_code"].ToString() == "4")
                        {
                            dr["FP"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FP"] = dr_fd[i]["credits"].ToString();
                        }

                        if (dr_fd[i]["dept_code"].ToString() == "5")
                        {
                            dr["FT"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FT"] = dr_fd[i]["credits"].ToString();
                        }
                    }

                    dt.Rows.Add(dr);

                    dt_credit.Rows.Add(dr_credits);

                }

                DataRow[] dr_fm = get_data.Select("user_dept = '3'");

                if (dr_fm.Length > 0)
                {

                    dr = dt.NewRow();
                    dr_credits = dt_credit.NewRow();


                    dr["Faculty"] = "FM";
                    dr_credits["Faculty"] = "FM";

                    dr["FA"] = 0;
                    dr["FD"] = 0;
                    dr["FM"] = 0;
                    dr["FP"] = 0;
                    dr["FT"] = 0;


                    dr_credits["FA"] = 0;
                    dr_credits["FD"] = 0;
                    dr_credits["FM"] = 0;
                    dr_credits["FP"] = 0;
                    dr_credits["FT"] = 0;

                    for (int i = 0; i < dr_fm.Length; i++)
                    {
                        if (dr_fm[i]["dept_code"].ToString() == "1")
                        {
                            dr["FA"] = dr_fm[i]["course_code"].ToString();
                            dr_credits["FA"] = dr_fm[i]["credits"].ToString();
                        }

                        if (dr_fm[i]["dept_code"].ToString() == "2")
                        {
                            dr["FD"] = dr_fm[i]["course_code"].ToString();
                            dr_credits["FD"] = dr_fm[i]["credits"].ToString();
                        }

                        if (dr_fm[i]["dept_code"].ToString() == "4")
                        {
                            dr["FP"] = dr_fm[i]["course_code"].ToString();
                            dr_credits["FP"] = dr_fm[i]["credits"].ToString();
                        }

                        if (dr_fm[i]["dept_code"].ToString() == "5")
                        {
                            dr["FT"] = dr_fm[i]["course_code"].ToString();
                            dr_credits["FT"] = dr_fm[i]["credits"].ToString();
                        }
                    }

                    dt.Rows.Add(dr);
                    dt_credit.Rows.Add(dr_credits);

                }

                DataRow[] dr_fp = get_data.Select("user_dept = '4'");

                if (dr_fp.Length > 0)
                {

                    dr = dt.NewRow();
                    dr_credits = dt_credit.NewRow();

                    dr["Faculty"] = "FP";
                    dr_credits["Faculty"] = "FP";

                    dr["FA"] = 0;
                    dr["FD"] = 0;
                    dr["FM"] = 0;
                    dr["FP"] = 0;
                    dr["FT"] = 0;


                    dr_credits["FA"] = 0;
                    dr_credits["FD"] = 0;
                    dr_credits["FM"] = 0;
                    dr_credits["FP"] = 0;
                    dr_credits["FT"] = 0;

                    for (int i = 0; i < dr_fp.Length; i++)
                    {
                        if (dr_fp[i]["dept_code"].ToString() == "1")
                        {
                            dr["FA"] = dr_fp[i]["course_code"].ToString();
                            dr_credits["FA"] = dr_fp[i]["credits"].ToString();
                        }

                        if (dr_fp[i]["dept_code"].ToString() == "2")
                        {
                            dr["FD"] = dr_fp[i]["course_code"].ToString();
                            dr_credits["FD"] = dr_fp[i]["credits"].ToString();
                        }

                        if (dr_fp[i]["dept_code"].ToString() == "3")
                        {
                            dr["FM"] = dr_fp[i]["course_code"].ToString();
                            dr_credits["FM"] = dr_fp[i]["credits"].ToString();
                        }

                        if (dr_fp[i]["dept_code"].ToString() == "5")
                        {
                            dr["FT"] = dr_fp[i]["course_code"].ToString();
                            dr_credits["FT"] = dr_fp[i]["credits"].ToString();
                        }
                    }

                    dt.Rows.Add(dr);

                    dt_credit.Rows.Add(dr_credits);

                }


                DataRow[] dr_ft = get_data.Select("user_dept = '5'");

                if (dr_ft.Length > 0)
                {

                    dr = dt.NewRow();
                    dr_credits = dt_credit.NewRow();

                    dr["Faculty"] = "FT";
                    dr_credits["Faculty"] = "FT";

                    dr["FA"] = 0;
                    dr["FD"] = 0;
                    dr["FM"] = 0;
                    dr["FP"] = 0;
                    dr["FT"] = 0;


                    dr_credits["FA"] = 0;
                    dr_credits["FD"] = 0;
                    dr_credits["FM"] = 0;
                    dr_credits["FP"] = 0;
                    dr_credits["FT"] = 0;

                    for (int i = 0; i < dr_ft.Length; i++)
                    {
                        if (dr_ft[i]["dept_code"].ToString() == "1")
                        {
                            dr["FA"] = dr_ft[i]["course_code"].ToString();
                            dr_credits["FA"] = dr_ft[i]["credits"].ToString();
                        }

                        if (dr_ft[i]["dept_code"].ToString() == "2")
                        {
                            dr["FD"] = dr_ft[i]["course_code"].ToString();
                            dr_credits["FD"] = dr_ft[i]["credits"].ToString();
                        }

                        if (dr_ft[i]["dept_code"].ToString() == "3")
                        {
                            dr["FM"] = dr_ft[i]["course_code"].ToString();
                            dr_credits["FM"] = dr_ft[i]["credits"].ToString();
                        }

                        if (dr_ft[i]["dept_code"].ToString() == "4")
                        {
                            dr["FP"] = dr_ft[i]["course_code"].ToString();
                            dr_credits["FP"] = dr_ft[i]["credits"].ToString();
                        }
                    }

                    dt.Rows.Add(dr);

                    dt_credit.Rows.Add(dr_credits);

                }




                if (dt != null)
                {
                    jsondata = GetJson1(dt);
                }

                if (dt_credit != null)
                {
                    json = GetJson1(dt_credit);
                }



            }
            else
            {

                return null;
            }

            data[0] = jsondata;
            data[1] = json;

            return data;

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    [WebMethod]
    public string[] get_cross_registration_PG_UG_report_data(string year_code, string semester)
    {



        try
        {


            string[] data = new string[2];

            string json = "";

            DataTable get_data = objmaster.get_assigned_cross_registration_PG_UG_report(year_code, semester);


            DataTable dt = new DataTable();
            DataTable dt_credit = new DataTable();

            dt.Columns.Add("Faculty");
            dt.Columns.Add("FA");
            dt.Columns.Add("FD");
            dt.Columns.Add("FM");
            dt.Columns.Add("FP");
            dt.Columns.Add("FT");

            dt_credit.Columns.Add("Faculty");
            dt_credit.Columns.Add("FA");
            dt_credit.Columns.Add("FD");
            dt_credit.Columns.Add("FM");
            dt_credit.Columns.Add("FP");
            dt_credit.Columns.Add("FT");



            string user_id = "";

            DataRow dr, dr_credits;




            if (get_data != null)
            {
                DataRow[] dr_fa = get_data.Select("prog_code = '1'");

                if (dr_fa.Length > 0)
                {

                    dr = dt.NewRow();
                    dr_credits = dt_credit.NewRow();

                    dr["Faculty"] = "PG Registration in UG Courses";
                    dr_credits["Faculty"] = "UG Registration in PG Courses";

                    dr["FA"] = 0;
                    dr["FD"] = 0;
                    dr["FM"] = 0;
                    dr["FP"] = 0;
                    dr["FT"] = 0;


                    dr_credits["FA"] = 0;
                    dr_credits["FD"] = 0;
                    dr_credits["FM"] = 0;
                    dr_credits["FP"] = 0;
                    dr_credits["FT"] = 0;

                    for (int i = 0; i < dr_fa.Length; i++)
                    {
                        if (dr_fa[i]["user_dept"].ToString() == "1")
                        {
                            dr["FA"] = dr_fa[i]["course_code"].ToString();

                            dr_credits["FA"] = dr_fa[i]["credits"].ToString();
                        }


                        if (dr_fa[i]["user_dept"].ToString() == "2")
                        {
                            dr["FD"] = dr_fa[i]["course_code"].ToString();

                            dr_credits["FD"] = dr_fa[i]["credits"].ToString();
                        }

                        if (dr_fa[i]["user_dept"].ToString() == "3")
                        {
                            dr["FM"] = dr_fa[i]["course_code"].ToString();
                            dr_credits["FM"] = dr_fa[i]["credits"].ToString();
                        }

                        if (dr_fa[i]["user_dept"].ToString() == "4")
                        {
                            dr["FP"] = dr_fa[i]["course_code"].ToString();
                            dr_credits["FP"] = dr_fa[i]["credits"].ToString();
                        }

                        if (dr_fa[i]["user_dept"].ToString() == "5")
                        {
                            dr["FT"] = dr_fa[i]["course_code"].ToString();
                            dr_credits["FT"] = dr_fa[i]["credits"].ToString();
                        }
                    }

                    dt.Rows.Add(dr);

                    dt_credit.Rows.Add(dr_credits);

                }

                DataRow[] dr_fd = get_data.Select("prog_code = '2'");

                if (dr_fd.Length > 0)
                {

                    dr = dt.NewRow();
                    dr_credits = dt_credit.NewRow();


                    dr["Faculty"] = "PG Registration in UG Courses";
                    dr_credits["Faculty"] = "UG Registration in PG Courses";

                    dr["FA"] = 0;
                    dr["FD"] = 0;
                    dr["FM"] = 0;
                    dr["FP"] = 0;
                    dr["FT"] = 0;


                    dr_credits["FA"] = 0;
                    dr_credits["FD"] = 0;
                    dr_credits["FM"] = 0;
                    dr_credits["FP"] = 0;
                    dr_credits["FT"] = 0;

                    for (int i = 0; i < dr_fd.Length; i++)
                    {
                        if (dr_fd[i]["user_dept"].ToString() == "1")
                        {
                            dr["FA"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FA"] = dr_fd[i]["credits"].ToString();
                        }
                        if (dr_fd[i]["user_dept"].ToString() == "2")
                        {
                            dr["FD"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FD"] = dr_fd[i]["credits"].ToString();
                        }



                        if (dr_fd[i]["user_dept"].ToString() == "3")
                        {
                            dr["FM"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FM"] = dr_fd[i]["credits"].ToString();
                        }

                        if (dr_fd[i]["user_dept"].ToString() == "4")
                        {
                            dr["FP"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FP"] = dr_fd[i]["credits"].ToString();
                        }

                        if (dr_fd[i]["user_dept"].ToString() == "5")
                        {
                            dr["FT"] = dr_fd[i]["course_code"].ToString();

                            dr_credits["FT"] = dr_fd[i]["credits"].ToString();
                        }
                    }

                    dt.Rows.Add(dr);

                    dt_credit.Rows.Add(dr_credits);

                }






                if (dt != null)
                {
                    jsondata = GetJson1(dt);
                }

                if (dt_credit != null)
                {
                    json = GetJson1(dt_credit);
                }



            }
            else
            {

                return null;
            }

            data[0] = jsondata;
            data[1] = json;

            return data;

        }
        catch (Exception ex)
        {

            throw ex;
        }


    }

    [WebMethod]
    public string get_successfully_paid_fees_details(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.get_successfully_paid_fees_details(sem_code, year_code);

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_registered_course_detail(string dept_code, string semester, string year_code)
    {
        DataTable get_data = objmaster.get_registered_course_detail(dept_code, semester, year_code);

        //DataTable dt = new DataTable();
        //dt.Columns.Add("course_code");
        //dt.Columns.Add("course_name");
        //dt.Columns.Add("elective_course");
        //dt.Columns.Add("priority1");
        //dt.Columns.Add("priority2");
        //dt.Columns.Add("priority3");
        //dt.Columns.Add("priority4");
        //dt.Columns.Add("priority5");
        //dt.Columns.Add("available_seat");
        ////dt.Columns.Add("total_credits");
        //string course_code = "";
        //DataRow dr;

        //if (get_data != null)
        //{
        //    for (int i = 0; i < get_data.Rows.Count; i++)
        //    {
        //        string a = get_data.Rows[i]["course_code"].ToString();
        //        if (course_code != get_data.Rows[i]["course_code"].ToString())
        //        {
        //            dr = dt.NewRow();
        //            dr["elective_course"] = "0";
        //            dr["priority1"] = "";
        //            dr["priority2"] = "";
        //            dr["priority3"] = "";
        //            dr["priority4"] = "";
        //            dr["priority5"] = "";
        //            dr["available_seat"] = "0";

        //            if (get_data.Rows[i]["course_type"].ToString() == "E")
        //            {
        //                dr["course_code"] = get_data.Rows[i]["course_code"].ToString();
        //                dr["course_name"] = get_data.Rows[i]["course_name"].ToString();
        //                dr["elective_course"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                dr["available_seat"] = get_data.Rows[i]["available_seat"].ToString();
        //                switch (get_data.Rows[i]["priority"].ToString())
        //                {
        //                    case "1":
        //                        dr["priority1"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                        break;
        //                    case "2":
        //                        dr["priority2"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                        break;
        //                    case "3":
        //                        dr["priority3"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                        break;
        //                    case "4":
        //                        dr["priority4"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                        break;
        //                    case "5":
        //                        dr["priority5"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                        break;
        //                }
        //                dt.Rows.Add(dr);
        //            }
        //        }
        //        else
        //        {
        //            DataRow[] dr1 = dt.Select("course_code = '" + get_data.Rows[i]["course_code"].ToString() + "'");
        //            if (dr1.Length > 0)
        //            {
        //                if (get_data.Rows[i]["course_type"].ToString() == "E")
        //                {
        //                    dr1[0]["elective_course"] = Convert.ToInt32(dr1[0]["elective_course"]) + Convert.ToInt32(get_data.Rows[i]["TotalStudent"].ToString());
        //                    switch (get_data.Rows[i]["priority"].ToString())
        //                    {
        //                        case "1":
        //                            dr1[0]["priority1"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                            break;
        //                        case "2":
        //                            dr1[0]["priority2"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                            break;
        //                        case "3":
        //                            dr1[0]["priority3"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                            break;
        //                        case "4":
        //                            dr1[0]["priority4"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                            break;
        //                        case "5":
        //                            dr1[0]["priority5"] = get_data.Rows[i]["TotalStudent"].ToString();
        //                            break;
        //                    }
        //                }
        //            }
        //        }
        //        course_code = get_data.Rows[i]["course_code"].ToString();
        //    }
        //    if (dt != null)
        //    {
        //        jsondata = GetJson1(dt);
        //    }
        //}

        if (get_data != null)
        {
            jsondata = GetJson1(get_data);
        }

        return jsondata;
    }

    #endregion

    #region priority report

    [WebMethod]
    public string get_priority_registration_report_course_wise(string sem_code, string year_code)
    {

        DataTable dt_priority = objmaster.get_total_first_priority_registration_report_course_wise(sem_code, year_code);

        DataTable dt_registered_priority = objmaster.get_registered_priority_course_wise(sem_code, year_code);

        DataTable dt_total_data = objmaster.get_priority_registration_report_course_wise(sem_code, year_code);

        DataTable dt = new DataTable();

        if (dt_priority != null)
        {


            dt.Columns.Add("course");
            dt.Columns.Add("course_code");

            dt.Columns.Add("p0");
            dt.Columns.Add("p0_name");
            dt.Columns.Add("p1");
            dt.Columns.Add("p1_name");
            dt.Columns.Add("p2");
            dt.Columns.Add("p2_name");
            dt.Columns.Add("p3");
            dt.Columns.Add("p3_name");
            dt.Columns.Add("p4");
            dt.Columns.Add("p4_name");
            dt.Columns.Add("p5");
            dt.Columns.Add("p5_name");
            dt.Columns.Add("p6");
            dt.Columns.Add("p6_name");
            dt.Columns.Add("p7");
            dt.Columns.Add("p7_name");
            dt.Columns.Add("p8");
            dt.Columns.Add("p8_name");
            dt.Columns.Add("p9");
            dt.Columns.Add("p9_name");

            DataRow dr;

            for (int i = 0; i < dt_priority.Rows.Count; i++)
            {
                for (int j = 0; j < Convert.ToInt16(dt_priority.Rows[i]["total"]); j++)
                {
                    dr = dt.NewRow();

                    dr["course"] = dt_priority.Rows[i]["course"];
                    dr["course_code"] = dt_priority.Rows[i]["course_code"];

                    dt.Rows.Add(dr);

                }
            }

            if (dt_total_data != null)
            {


                if (dt_registered_priority != null)
                {
                    for (int i = 0; i < dt_registered_priority.Rows.Count; i++)
                    {
                        DataRow[] dr_course = dt_total_data.Select("course_code  ='" + dt_registered_priority.Rows[i]["course_code"] + "' and priority ='" + dt_registered_priority.Rows[i]["priority"] + "'");

                        if (dr_course.Length > 0)
                        {
                            DataRow[] dr_dt = dt.Select("course_code = '" + dt_registered_priority.Rows[i]["course_code"] + "'  ");

                            if (dr_dt.Length > 0)
                            {
                                for (int k = 0; k < dr_course.Length; k++)
                                {
                                    dr_dt[k]["p" + dt_registered_priority.Rows[i]["priority"]] = dr_course[k]["user_id"].ToString();
                                    dr_dt[k]["p" + dt_registered_priority.Rows[i]["priority"] + "_name"] = dr_course[k]["user_name"].ToString();

                                    dt.AcceptChanges();
                                }
                            }
                        }
                    }
                }
            }

        }



        if (dt != null)
        {
            jsondata = GetJson1(dt);
        }

        return jsondata;
    }

    [WebMethod]
    public string get_priority_registration_report_student_wise(string sem_code, string year_code, string dept_code)
    {

        DataTable dt = objmaster.get_priority_registration_report_student_wise(sem_code, year_code, dept_code);

        if (dt != null)
        {
            jsondata = GetJson1(dt);
        }

        return jsondata;
    }

    #endregion

    //[WebMethod(EnableSession = true)]
    //public string Get_student_passport_detail()
    //{
    //    DataTable dt_student_passport_dtl = objmaster.Get_student_passport_detail(HttpContext.Current.Session["UserId"].ToString());

    //    if (dt_student_passport_dtl != null)
    //    {
    //        jsondata = GetJson1(dt_student_passport_dtl);
    //    }
    //    return jsondata;
    //}

    [WebMethod(EnableSession = true)]
    public string Get_student_passport_detailnew()
    {
        DataTable dt_student_passport_dtl = objmaster.Get_student_passport_detail(HttpContext.Current.Session["UserId"].ToString());

        if (dt_student_passport_dtl != null)
        {
            jsondata = GetJson1(dt_student_passport_dtl);
        }
        return jsondata;
    }

    #endregion

    #region Save method

    [WebMethod(EnableSession = true)]
    public string save_user_fees(string fees_data, string dept_code, string sem_code, string year_code)
    {
        // Save Compliance Details in compliance_entry table.


        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            //Dictionary<string, object> lst = new Dictionary<string, object>();
            //lst.Add("Demo", fees_data);



            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(fees_data);

            DataTable dt = objmaster.Get_student_fees_saved_data(dept_code, sem_code, year_code);

            for (int i = 0; i < data.Count; i++)
            {
                //Ds_Workflow.New_cad_workflow_mstRow cad_workflow = obj_workflow.New_cad_workflow_mst.NewNew_cad_workflow_mstRow();

                DSC_fees_status_WS.user_fees_statusRow user_fees = obj_fees_status.user_fees_status.Newuser_fees_statusRow();

                re = re + i;



                if (dt != null)
                {
                    DataRow[] dr = dt.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                    if (dr.Length > 0)
                    {
                        user_fees.doc_no = dr[0]["doc_no"].ToString();
                    }
                    else
                    {
                        user_fees.doc_no = re.ToString();
                    }
                }
                else
                {
                    user_fees.doc_no = re.ToString();
                }

                user_fees.user_id = data[i]["user_id"].ToString();


                user_fees.fees_status = data[i]["fees_status"].ToString();
                user_fees.semester_code = data[i]["sem_code"].ToString();
                user_fees.dept_code = data[i]["dept_code"].ToString();
                user_fees.year_code = data[i]["year_code"].ToString();
                user_fees.cancel_flag = "N";
                user_fees.created_by = HttpContext.Current.Session["UserId"].ToString();
                user_fees.created_date = System.DateTime.Now;
                user_fees.created_host = HttpContext.Current.Request.UserHostName;

                //obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
                obj_fees_status.user_fees_status.Adduser_fees_statusRow(user_fees);

            }
            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            //     objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_ws_user_fees(string fees_data, string dept_code, string year_code, string flag)
    {
        // Save Compliance Details in compliance_entry table.

        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            //Dictionary<string, object> lst = new Dictionary<string, object>();
            //lst.Add("Demo", fees_data);

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(fees_data);

            DataTable dt_user = objmaster.get_all_user_mst_data();

            DataRow[] dr_user = dt_user.Select("user_id = '" + data[0]["user_id"].ToString() + "'");

            if (dr_user.Length > 0)
            {
                dept_code = dr_user[0]["dept_code"].ToString();
            }

            DataTable dt = objmaster.Get_ws_student_fees_saved_data(dept_code, year_code, current_ws_sem, current_ws_year);

            for (int i = 0; i < data.Count; i++)
            {
                //Ds_Workflow.New_cad_workflow_mstRow cad_workflow = obj_workflow.New_cad_workflow_mst.NewNew_cad_workflow_mstRow();

                DSC_fees_status_WS.ws_user_fees_statusRow user_fees = obj_fees_status.ws_user_fees_status.Newws_user_fees_statusRow();

                re = re + i;

                user_fees.user_id = data[i]["user_id"].ToString();

                if (flag == "fees")
                {
                    user_fees.fees_status = data[i]["fees_status"].ToString();

                    if (dt != null)
                    {
                        DataRow[] dr = dt.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                        if (dr.Length > 0)
                        {
                            user_fees.doc_no = dr[0]["doc_no"].ToString();
                            user_fees.fees_type = dr[0]["fees_type"].ToString();
                            user_fees.installmant_status = dr[0]["installmant_status"].ToString();
                            user_fees.waiver_credits = dr[0]["waiver_credits"].ToString();
                            user_fees.fees_waiver_credits = dr[0]["fees_waiver_credits"].ToString();
                        }
                        else
                        {
                            user_fees.doc_no = re.ToString();
                        }
                    }
                    else
                    {
                        user_fees.doc_no = re.ToString();
                    }
                }
                else
                {
                    user_fees.fees_type = data[i]["fees_type"].ToString();
                    user_fees.installmant_status = data[i]["installment_status"].ToString();
                    user_fees.waiver_credits = data[i]["waiver_credits"].ToString();
                    user_fees.fees_waiver_credits = data[i]["fees_waiver_credits"].ToString();
                    if (dt != null)
                    {
                        DataRow[] dr = dt.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                        if (dr.Length > 0)
                        {
                            user_fees.doc_no = dr[0]["doc_no"].ToString();
                            user_fees.fees_status = dr[0]["fees_status"].ToString();
                            // user_fees.installmant_status = dr[0]["installmant_status"].ToString();
                        }
                        else
                        {
                            user_fees.doc_no = re.ToString();
                        }
                    }
                    else
                    {
                        user_fees.doc_no = re.ToString();
                    }
                }

                //user_fees.installment1 = data[i]["installment1"].ToString();
                //user_fees.installment2 = data[i]["installment2"].ToString();
                //user_fees.semester_code = data[i]["sem_code"].ToString();

                user_fees.dept_code = dept_code;
                user_fees.year_code = data[i]["year_code"].ToString();
                user_fees.semester_type = current_ws_sem.ToString();
                user_fees.year_type = current_ws_year.ToString();
                user_fees.cancel_flag = "N";
                user_fees.created_by = HttpContext.Current.Session["UserId"].ToString();
                user_fees.created_date = System.DateTime.Now;
                user_fees.created_host = HttpContext.Current.Request.UserHostName;

                obj_fees_status.ws_user_fees_status.Addws_user_fees_statusRow(user_fees);
            }

            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            objBLReturnObject = objMaster.save_ws_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }

        return objBLReturnObject.ServerMessage;
    }

    public string save_ws_user_fees_after_online_payment()
    {
        // Save Compliance Details in compliance_entry table.


        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            //Dictionary<string, object> lst = new Dictionary<string, object>();
            //lst.Add("Demo", fees_data);



            // List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(fees_data);



            ServerLog.InvalidLoginLog("Start method save_ws_user_fees_after_online_payment");




            DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
            string current_ws_sem = "";
            string current_ws_year = "";


            if (dt_ws_current_sem != null)
            {
                current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
            }

            DataTable dt_user = objmaster.get_all_user_mst_data();


            //DataRow[] dr_user = dt_user.Select("user_id = '" + HttpContext.Current.Session["UserId"].ToString() + "'");

            //if (dr_user.Length > 0)
            //{
            //    dept_code = dr_user[0]["dept_code"].ToString();
            //}

            DataTable dt = objmaster.Get_ws_student_fees_saved_data(HttpContext.Current.Session["dept_code"].ToString(), HttpContext.Current.Session["year_code"].ToString(), current_ws_sem, current_ws_year);




            //Ds_Workflow.New_cad_workflow_mstRow cad_workflow = obj_workflow.New_cad_workflow_mst.NewNew_cad_workflow_mstRow();

            DSC_fees_status_WS.ws_user_fees_statusRow user_fees = obj_fees_status.ws_user_fees_status.Newws_user_fees_statusRow();


            user_fees.user_id = HttpContext.Current.Session["UserId"].ToString();

            if (dt != null)
            {
                ServerLog.InvalidLoginLog("dt is not null");

                DataRow[] dr = dt.Select("user_id = '" + HttpContext.Current.Session["UserId"].ToString() + "'");

                if (dr.Length > 0)
                {


                    user_fees.doc_no = dr[0]["doc_no"].ToString();

                    user_fees.fees_type = dr[0]["fees_type"].ToString();
                    user_fees.installmant_status = dr[0]["installmant_status"].ToString();
                    user_fees.waiver_credits = dr[0]["waiver_credits"].ToString();
                    user_fees.fees_waiver_credits = dr[0]["fees_waiver_credits"].ToString();
                    user_fees.fees_status = "Y";
                }
                else
                {
                    user_fees.doc_no = re.ToString();
                }
            }
            else
            {
                ServerLog.InvalidLoginLog("dt is null");

                user_fees.doc_no = re.ToString();
            }





            user_fees.fees_status = "Y";


            //user_fees.installment1 = data[i]["installment1"].ToString();
            //user_fees.installment2 = data[i]["installment2"].ToString();


            // user_fees.semester_code = data[i]["sem_code"].ToString();
            user_fees.dept_code = HttpContext.Current.Session["dept_code"].ToString();
            user_fees.year_code = HttpContext.Current.Session["year_code"].ToString();

            user_fees.semester_type = current_ws_sem.ToString();
            user_fees.year_type = current_ws_year.ToString();
            user_fees.cancel_flag = "N";
            user_fees.created_by = HttpContext.Current.Session["UserId"].ToString();
            user_fees.created_date = System.DateTime.Now;
            user_fees.created_host = HttpContext.Current.Request.UserHostName;


            obj_fees_status.ws_user_fees_status.Addws_user_fees_statusRow(user_fees);


            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            objBLReturnObject = objMaster.save_ws_user_fees_for_online_payment(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {
            ServerLog.InvalidLoginLog("Error in Catch : " + ex.Message);
            return "Problem in Save DATA.";
        }
        ServerLog.InvalidLoginLog("return after save : " + objBLReturnObject.ServerMessage);
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_user_fees_test(string fees_data)
    {
        // Save Compliance Details in compliance_entry table.


        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            //Dictionary<string, object> lst = new Dictionary<string, object>();
            //lst.Add("Demo", fees_data);


            List<Array> data1 = ser.Deserialize<List<Array>>(fees_data);
            Dictionary<string, object> data2 = ser.Deserialize<Dictionary<string, object>>(fees_data);
            string inner = data2["fees_data"].ToString();
            KeyValuePair<string, object> inn = (KeyValuePair<string, object>)data2["fees_data"];
            Dictionary<string, object> data4 = ser.Deserialize<Dictionary<string, object>>(inner);

            // List<string> data3 = ser.Deserialize<List<string>>(inner);

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(fees_data);


            //foreach (KeyValuePair<string, dynamic> pair in data)
            //{
            //    string str = pair.Key[0];
            //}

            DataTable dt = objmaster.Get_student_fees_saved_data("", "", "");

            for (int i = 0; i < data.Count; i++)
            {

                //  var q = from d in data where d.Equals("demo") select data;


                //Ds_Workflow.New_cad_workflow_mstRow cad_workflow = obj_workflow.New_cad_workflow_mst.NewNew_cad_workflow_mstRow();

                DSC_fees_status_WS.user_fees_statusRow user_fees = obj_fees_status.user_fees_status.Newuser_fees_statusRow();

                re = re + i;



                if (dt != null)
                {
                    DataRow[] dr = dt.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                    if (dr.Length > 0)
                    {
                        user_fees.doc_no = dr[0]["doc_no"].ToString();
                    }
                    else
                    {
                        user_fees.doc_no = re.ToString();
                    }
                }
                else
                {
                    user_fees.doc_no = re.ToString();
                }

                user_fees.user_id = data[i]["user_id"].ToString();


                user_fees.fees_status = data[i]["fees_status"].ToString();
                user_fees.semester_code = data[i]["sem_code"].ToString();
                user_fees.dept_code = data[i]["dept_code"].ToString();
                user_fees.year_code = data[i]["year_code"].ToString();
                user_fees.cancel_flag = "N";
                user_fees.created_by = HttpContext.Current.Session["UserId"].ToString();
                user_fees.created_date = System.DateTime.Now;
                user_fees.created_host = HttpContext.Current.Request.UserHostName;

                //obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
                obj_fees_status.user_fees_status.Adduser_fees_statusRow(user_fees);

            }
            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            //  objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_student_current_sem(string current_sem_data)
    {
        // Save Compliance Details in compliance_entry table.

        string prog_code = "";
        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(current_sem_data);

            DataTable dt = objmaster.check_credit_choice_by_student("", data[0]["year_code"].ToString(), "", "");

            if (data.Count > 0)
            {
                prog_code = data[0]["prog_code"].ToString();
            }


            for (int i = 0; i < data.Count; i++)
            {
                //Ds_Workflow.New_cad_workflow_mstRow cad_workflow = obj_workflow.New_cad_workflow_mst.NewNew_cad_workflow_mstRow();

                Ds_Student_Course_detail_WS.student_current_sem_dtlRow student_current_sem = obj_student.student_current_sem_dtl.Newstudent_current_sem_dtlRow();

                re = re + i;


                student_current_sem.doc_no = re.ToString();

                student_current_sem.student_id = data[i]["user_id"].ToString();
                student_current_sem.student_code = data[i]["student_code"].ToString();

                if (dt != null)
                {
                    DataRow[] dr = dt.Select(" student_id = '" + data[i]["user_id"].ToString() + "'  and semester_code = '" + data[i]["sem_code"].ToString() + "' and dept_code = '" + data[i]["dept_code"].ToString() + "'");

                    if (dr.Length > 0)
                    {
                        student_current_sem.credit_choice = dr[0]["credit_choice"].ToString();
                    }
                }


                student_current_sem.semester_code = data[i]["sem_code"].ToString();
                student_current_sem.parent_sem_code = data[i]["parent_sem_code"].ToString();
                student_current_sem.year_code = data[i]["year_code"].ToString();
                student_current_sem.dept_code = data[i]["dept_code"].ToString();
                student_current_sem.prog_code = data[i]["prog_code"].ToString();
                student_current_sem.active_flag = "Y";
                student_current_sem.cancel_flag = "N";
                student_current_sem.created_by = HttpContext.Current.Session["UserId"].ToString();
                student_current_sem.created_date = System.DateTime.Now;
                student_current_sem.created_host = HttpContext.Current.Request.UserHostName;

                ////obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
                obj_student.student_current_sem_dtl.Addstudent_current_sem_dtlRow(student_current_sem);

            }
            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            objBLReturnObject = objMaster.save_student_current_sem(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, prog_code);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_student_term_and_condition()
    {
        // Save Compliance Details in compliance_entry table.

        string prog_code = "";
        int re = 0;

        try
        {
            DataTable dt_ws_current_sem = objmaster.Get_WS_current_sem_data();
            string current_ws_sem = "";
            string current_ws_year = "";


            if (dt_ws_current_sem != null)
            {
                current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
            }

            DSC_userdataupload_WS.ws_term_conditionRow term_condition = obj_userdataupload.ws_term_condition.Newws_term_conditionRow();

            term_condition.doc_no = "1";
            term_condition.user_id = HttpContext.Current.Session["UserId"].ToString();
            term_condition.term_condition = "Y";

            term_condition.semester_type = current_ws_sem.ToString();
            term_condition.year_semester = current_ws_year.ToString();
            term_condition.cancel_flag = "N";

            term_condition.created_by = HttpContext.Current.Session["UserId"].ToString();
            term_condition.created_date = System.DateTime.Now;
            term_condition.created_host = HttpContext.Current.Request.UserHostName;

            ////obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
            obj_userdataupload.ws_term_condition.Addws_term_conditionRow(term_condition);


            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            objBLReturnObject = objMaster.save_student_term_and_condition(obj_userdataupload, HttpContext.Current.Session["UserId"].ToString(), "", "");

            if (objBLReturnObject.ServerMessage == "ok")
            {
                HttpContext.Current.Session["term_condition"] = "Y";
            }
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_ws_student_current_sem(string current_sem_data)
    {
        // Save Compliance Details in compliance_entry table.

        string prog_code = "";
        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(current_sem_data);






            for (int i = 0; i < data.Count; i++)
            {


                // Ds_Student_Course_detail_WS.ws_curre student_current_sem = obj_student.student_current_sem_dtl.Newstudent_current_sem_dtlRow();
                Ds_Student_Course_detail_WS.ws_current_semesterRow student_current_sem = obj_student.ws_current_semester.Newws_current_semesterRow();
                //re = re + i;


                student_current_sem.doc_no = "1";

                student_current_sem.sem_code = data[i]["sem_code"].ToString();
                student_current_sem.year_code = data[i]["year_code"].ToString();

                if (data[i]["sem_code"].ToString() == "S")
                {
                    student_current_sem.sem_desc = "Summer";
                }
                else
                {
                    student_current_sem.sem_desc = "Winter";
                }

                student_current_sem.active_flag = "Y";

                student_current_sem.cancel_flag = "N";

                student_current_sem.created_by = HttpContext.Current.Session["UserId"].ToString();
                student_current_sem.created_date = System.DateTime.Now;
                student_current_sem.created_host = HttpContext.Current.Request.UserHostName;

                //////obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
                obj_student.ws_current_semester.Addws_current_semesterRow(student_current_sem);

            }
            //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            objBLReturnObject = objMaster.save_ws_student_current_sem(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, prog_code);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_course_seat_data(string course_seat_data)
    {
        //Save Compliance Details in compliance_entry table.

        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(course_seat_data);

            DataTable dt_course_data = objmaster.get_seats_dtl_of_course(current_ws_sem, "", current_ws_year);

            for (int i = 0; i < data.Count; i++)
            {
                //Ds_Workflow.New_cad_workflow_mstRow cad_workflow = obj_workflow.New_cad_workflow_mst.NewNew_cad_workflow_mstRow();

                Ds_Student_Course_detail_WS.ws_course_mstRow course_seat = obj_student.ws_course_mst.Newws_course_mstRow();

                DataRow[] dr = dt_course_data.Select("course_code = '" + data[i]["course_code"].ToString() + "'");

                DataRow TranRow = dr[0];

                TranRow["available_seat"] = data[i]["available_seat"].ToString();
                TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                TranRow["last_modified_date"] = System.DateTime.Now;
                TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                obj_student.ws_course_mst.ImportRow(TranRow);
            }

            objBLReturnObject = objMaster.save_increase_course_seats_data(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }

        return objBLReturnObject.ServerMessage;
    }

    //[WebMethod(EnableSession = true)]
    //public string Save_student_course_dtl(string mandatory_course, string elective_course, string status_flag)
    //{
    //    // Save Compliance Details in compliance_entry table.


    //    //string s = "kamlesh";
    //    //char[] cs = s.ToCharArray();
    //    //Char[] c = new Char[10];
    //    //for (int i = 0; i < cs.Length; i++)
    //    //{
    //    //    for (int j = i + 1; j < cs.Length; j++)
    //    //    {
    //    //        if (cs[i] > cs[j])
    //    //        {
    //    //            char temp = cs[i];
    //    //            cs[i] = cs[j];
    //    //            cs[j] = temp;
    //    //        }
    //    //    }
    //    //}

    //    //s = new string(cs);



    //    int re = 0;

    //    try
    //    {
    //        string semester = "";


    //        if (current_round != "1")
    //        {
    //            if (current_round != "")
    //            {

    //                DataTable dt = objmaster.get_student_for_next_round_registration(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString(), current_round);

    //                if (dt != null)
    //                {
    //                    if (dt.Rows[0]["user_id"].ToString() == HttpContext.Current.Session["UserId"].ToString())
    //                    {
    //                        re = 1;
    //                    }
    //                }
    //            }
    //        }
    //        else
    //        {

    //            if (HttpContext.Current.Session["dept_code"].ToString() == "7")
    //            {
    //                re = 1;
    //            }

    //            if (HttpContext.Current.Session["dept_code"].ToString() == "1" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
    //            {
    //                re = 1;
    //            }

    //            if (HttpContext.Current.Session["dept_code"].ToString() == "2" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
    //            {
    //                re = 1;
    //            }
    //        }


    //        if (re == 0)
    //        {
    //            return "Registration has been closed for Winter 2015.";
    //        }


    //        if (HttpContext.Current.Session["semester_code"] != null)
    //        {
    //            semester = HttpContext.Current.Session["semester_code"].ToString();
    //        }



    //        DataTable dt_ws_credit_choice = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString());

    //        if (dt_ws_credit_choice == null)
    //        {
    //            return "You can not Save & Register Course.You are not Save your choice of credits";
    //        }
    //        else
    //        {
    //            if (dt_ws_credit_choice.Rows[0]["credit_choice"].ToString() == "0")
    //            {
    //                return "You can not Save & Register Course.You are Save your choice of credits is : " + dt_ws_credit_choice.Rows[0]["credit_choice"].ToString();
    //            }
    //        }

    //        DataTable dt_check_allocate_data = objmaster.Get_student_assigned_current_sem_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);


    //        if (dt_check_allocate_data != null)
    //        {
    //            return "You can not Save & Register Course.Your Course allocation is already completed.";
    //        }

    //        DataTable dt_check_registed_data = objmaster.Get_ws_student_registered(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

    //        if (dt_check_registed_data != null)
    //        {
    //            return "You already registered your Course.";
    //        }

    //        if (status_flag == "R")
    //        {
    //            DataTable fees_status = objmaster.Get_fees_status_for_student(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

    //            if (fees_status != null)
    //            {
    //                if (fees_status.Rows[0]["fees_status"].ToString() == "Y")
    //                {

    //                }
    //                else
    //                {
    //                    return "You can not registered Course.Please submit your Fees for current semester.";
    //                }
    //            }
    //            else
    //            {
    //                return "You can not registered Course.Please submit your Fees for current semester.";
    //            }
    //        }

    //        JavaScriptSerializer ser = new JavaScriptSerializer();

    //        //  List<Dictionary<string, object>> mandatory_data = ser.Deserialize<List<Dictionary<string, object>>>(mandatory_course);
    //        List<Dictionary<string, object>> elective_data = ser.Deserialize<List<Dictionary<string, object>>>(elective_course);

    //        Decimal total_credits = 0;

    //        for (int i = 0; i < elective_data.Count; i++)
    //        {

    //            total_credits += Convert.ToDecimal(elective_data[i]["credits"].ToString());

    //        }

    //        if (total_credits > 25)
    //        {
    //            return "You can Select Maximum 25 Credits for save your courses.";
    //        }

    //        for (int i = 0; i < elective_data.Count; i++)
    //        {
    //            string flag = "N";

    //            //  count_credit += Convert.ToInt16(elective_data[i]["credits"].ToString());

    //            if (Convert.ToInt16(elective_data[i]["priority"].ToString()) == 1)
    //            {

    //            }
    //            else
    //            {
    //                for (int j = 0; j < elective_data.Count; j++)
    //                {
    //                    if (Convert.ToInt16(elective_data[i]["priority"].ToString()) - 1 == Convert.ToInt16(elective_data[j]["priority"].ToString()))
    //                    {
    //                        flag = "N";
    //                        break;
    //                    }
    //                    else
    //                    {
    //                        flag = "Y";
    //                    }
    //                }

    //                if (flag == "Y")
    //                {
    //                    return "You can not save/register your course.You have not select priority in sequence.please select priority in sequence.";
    //                }
    //            }
    //        }

    //        for (int i = 0; i < elective_data.Count; i++)
    //        {


    //            Ds_Student_Course_detail_WS.ws_student_wise_course_dtlRow save_student_course = obj_student.ws_student_wise_course_dtl.Newws_student_wise_course_dtlRow();

    //            re = re + i;

    //            save_student_course.doc_no = re.ToString();


    //            save_student_course.course_code = elective_data[i]["course_code"].ToString();

    //            save_student_course.user_id = HttpContext.Current.Session["UserId"].ToString();

    //            if (HttpContext.Current.Session["semester_code"] != null)
    //            {
    //                save_student_course.current_sem_code = HttpContext.Current.Session["semester_code"].ToString();
    //            }

    //            save_student_course.year_code = HttpContext.Current.Session["year_code"].ToString();
    //            save_student_course.course_type = "E";
    //            save_student_course.credits = elective_data[i]["credits"].ToString();
    //            save_student_course.gpa_nongpa = "N";
    //            save_student_course.priority = elective_data[i]["priority"].ToString();
    //            save_student_course.fees = elective_data[i]["fees"].ToString();

    //            DataTable dt = objmaster.Get_department_data();

    //            DataRow[] dr = dt.Select("dept_name = '" + elective_data[i]["department"].ToString() + "'");

    //            if (dr.Length > 0 && dr != null)
    //            {
    //                save_student_course.dept_code = dr[0]["dept_code"].ToString();

    //            }

    //            if (status_flag == "S")
    //            {
    //                save_student_course.status = "S";
    //            }
    //            else if (status_flag == "R")
    //            {
    //                save_student_course.status = "R";
    //            }



    //            save_student_course.semester_type = current_ws_sem.ToString();
    //            save_student_course.year_semester = current_ws_year.ToString();
    //            save_student_course.round = current_round;

    //            save_student_course.cancel_flag = "N";
    //            save_student_course.created_by = HttpContext.Current.Session["UserId"].ToString();
    //            save_student_course.created_date = System.DateTime.Now;
    //            save_student_course.created_host = HttpContext.Current.Request.UserHostName;


    //            obj_student.ws_student_wise_course_dtl.Addws_student_wise_course_dtlRow(save_student_course);

    //        }
    //        ////objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
    //        objBLReturnObject = objmaster.Save_ws_student_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), semester, HttpContext.Current.Request.UserHostName, current_ws_sem.ToString(), current_ws_year.ToString());
    //    }
    //    catch (Exception ex)
    //    {
    //        return "Problem in Save DATA.";
    //    }

    //    string msg = "";

    //    if (objBLReturnObject.ServerMessage == "Data Saved Successfully")
    //    {
    //        if (status_flag == "S")
    //        {
    //            msg = "Data Saved Successfully";
    //        }
    //        else if (status_flag == "R")
    //        {
    //            msg = "Data Registered Successfully";
    //        }
    //    }

    //    return msg;

    //}

    [WebMethod(EnableSession = true)]
    public string Save_student_course_dtl(string mandatory_course, string elective_course, string status_flag, string passport_detail)
    {
        // Save Compliance Details in compliance_entry table.


        //string s = "kamlesh";
        //char[] cs = s.ToCharArray();
        //Char[] c = new Char[10];
        //for (int i = 0; i < cs.Length; i++)
        //{
        //    for (int j = i + 1; j < cs.Length; j++)
        //    {
        //        if (cs[i] > cs[j])
        //        {
        //            char temp = cs[i];
        //            cs[i] = cs[j];
        //            cs[j] = temp;
        //        }
        //    }
        //}

        //s = new string(cs);



        int re = 0;

        try
        {
            string semester = "";


            if (current_round != "1")
            {
                //if (current_round != "")
                //{

                //    DataTable dt = objmaster.get_student_for_next_round_registration(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString(), current_round);

                //    if (dt != null)
                //    {
                //        if (dt.Rows[0]["user_id"].ToString() == HttpContext.Current.Session["UserId"].ToString())
                //        {
                //            re = 1;
                //        }
                //    }
                //}
            }
            else
            {

                //if (HttpContext.Current.Session["dept_code"].ToString() == "7")
                //{
                //    re = 1;
                //}

                //if (HttpContext.Current.Session["dept_code"].ToString() == "1" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
                //{
                //    re = 1;
                //}

                //if (HttpContext.Current.Session["dept_code"].ToString() == "2" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
                //{
                //    re = 1;
                //}
            }


            if (re == 0)
            {
                return "Registration has been closed for Summer 2016.";
            }

            if (HttpContext.Current.Session["semester_code"] != null)
            {
                semester = HttpContext.Current.Session["semester_code"].ToString();
            }

            DataTable dt_ws_credit_choice = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString());

            if (dt_ws_credit_choice == null)
            {
                return "You can not Save & Register Course.You are not Save your choice of credits";
            }
            else
            {
                if (dt_ws_credit_choice.Rows[0]["credit_choice"].ToString() == "0")
                {
                    return "You can not Save & Register Course.You are Save your choice of credits is : " + dt_ws_credit_choice.Rows[0]["credit_choice"].ToString();
                }
            }

            DataTable dt_check_allocate_data = objmaster.Get_student_assigned_current_sem_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);


            if (dt_check_allocate_data != null)
            {
                return "You can not Save & Register Course.Your Course allocation is already completed.";
            }

            DataTable dt_check_registed_data = objmaster.Get_ws_student_registered(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

            if (dt_check_registed_data != null)
            {
                return "You already registered your Course.";
            }

            if (status_flag == "R")
            {
                DataTable fees_status = objmaster.Get_fees_status_for_student(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

                if (fees_status != null)
                {
                    if (fees_status.Rows[0]["fees_status"].ToString() == "Y")
                    {

                    }
                    else
                    {
                        return "You can not registered Course.Please submit your Fees for current semester.";
                    }
                }
                else
                {
                    return "You can not registered Course.Please submit your Fees for current semester.";
                }
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            //  List<Dictionary<string, object>> mandatory_data = ser.Deserialize<List<Dictionary<string, object>>>(mandatory_course);
            List<Dictionary<string, object>> elective_data = ser.Deserialize<List<Dictionary<string, object>>>(elective_course);

            Decimal total_credits = 0;

            for (int i = 0; i < elective_data.Count; i++)
            {

                total_credits += Convert.ToDecimal(elective_data[i]["credits"].ToString());

            }

            if (total_credits > 25)
            {
                return "You can Select Maximum 25 Credits for save your courses.";
            }

            for (int i = 0; i < elective_data.Count; i++)
            {
                string flag = "N";

                //  count_credit += Convert.ToInt16(elective_data[i]["credits"].ToString());

                if (Convert.ToInt16(elective_data[i]["priority"].ToString()) == 1)
                {

                }
                else
                {
                    for (int j = 0; j < elective_data.Count; j++)
                    {
                        if (Convert.ToInt16(elective_data[i]["priority"].ToString()) - 1 == Convert.ToInt16(elective_data[j]["priority"].ToString()))
                        {
                            flag = "N";
                            break;
                        }
                        else
                        {
                            flag = "Y";
                        }
                    }

                    if (flag == "Y")
                    {
                        return "You can not save/register your course.You have not select priority in sequence.please select priority in sequence.";
                    }
                }
            }

            for (int i = 0; i < elective_data.Count; i++)
            {


                Ds_Student_Course_detail_WS.ws_student_wise_course_dtlRow save_student_course = obj_student.ws_student_wise_course_dtl.Newws_student_wise_course_dtlRow();

                re = re + i;

                save_student_course.doc_no = re.ToString();


                save_student_course.course_code = elective_data[i]["course_code"].ToString();

                save_student_course.user_id = HttpContext.Current.Session["UserId"].ToString();

                if (HttpContext.Current.Session["semester_code"] != null)
                {
                    save_student_course.current_sem_code = HttpContext.Current.Session["semester_code"].ToString();
                }

                save_student_course.year_code = HttpContext.Current.Session["year_code"].ToString();
                save_student_course.course_type = "E";
                save_student_course.credits = elective_data[i]["credits"].ToString();
                save_student_course.gpa_nongpa = "N";
                save_student_course.priority = elective_data[i]["priority"].ToString();
                save_student_course.fees = elective_data[i]["fees"].ToString();

                DataTable dt = objmaster.Get_department_data();

                DataRow[] dr = dt.Select("dept_name = '" + elective_data[i]["department"].ToString() + "'");

                if (dr.Length > 0 && dr != null)
                {
                    save_student_course.dept_code = dr[0]["dept_code"].ToString();

                }

                if (status_flag == "S")
                {
                    save_student_course.status = "S";
                }
                else if (status_flag == "R")
                {
                    save_student_course.status = "R";
                }



                save_student_course.semester_type = current_ws_sem.ToString();
                save_student_course.year_semester = current_ws_year.ToString();
                save_student_course.round = current_round;

                save_student_course.cancel_flag = "N";
                save_student_course.created_by = HttpContext.Current.Session["UserId"].ToString();
                save_student_course.created_date = System.DateTime.Now;
                save_student_course.created_host = HttpContext.Current.Request.UserHostName;
                save_student_course.is_cancel = "N";


                obj_student.ws_student_wise_course_dtl.Addws_student_wise_course_dtlRow(save_student_course);

            }
            ////objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            objBLReturnObject = objmaster.Save_ws_student_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), semester, HttpContext.Current.Request.UserHostName, current_ws_sem.ToString(), current_ws_year.ToString());
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }

        string msg = "";

        if (objBLReturnObject.ServerMessage == "Data Saved Successfully")
        {
            if (status_flag == "S")
            {
                msg = "Data Saved Successfully";
            }
            else if (status_flag == "R")
            {
                msg = "Data Registered Successfully";
            }

            DataTable dt_student_passport_dtl = objmaster.Get_student_passport_detail(HttpContext.Current.Session["UserId"].ToString());

            if (passport_detail != "")
            {
                JavaScriptSerializer ser = new JavaScriptSerializer();

                Dictionary<string, string> dic_student_passport_dtl = ser.Deserialize<Dictionary<string, string>>(passport_detail);

                if (dt_student_passport_dtl != null)
                {
                    objmaster.save_student_passport_detail(HttpContext.Current.Session["UserId"].ToString(), dic_student_passport_dtl, "U");
                }
                else if (dt_student_passport_dtl == null)
                {
                    objmaster.save_student_passport_detail(HttpContext.Current.Session["UserId"].ToString(), dic_student_passport_dtl, "I");
                }
            }
        }

        return msg;

    }

    [WebMethod(EnableSession = true)]
    public string save_data_for_allocation(string manually_data, string course_code, string sem_code, string year, string dept_code, string prog_code)
    {
        //Save Compliance Details in compliance_entry table.

        int re = 0;

        try
        {
            DataTable course_data = objmaster.Get_all_course_data(sem_code, year);
            DataTable user_data = objmaster.Get_student_data_new("", dept_code, prog_code);
            DataTable get_old_allocate_data = objmaster.get_ws_student_allcate_course_dtl_data(sem_code, year, course_code);

            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(manually_data);

            if (course_code != null)
            {
                for (int i = 0; i < data.Count; i++)
                {
                    if (data[i]["cancel_flag"].ToString() == "N")
                    {
                        Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow save_student_course = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                        if (get_old_allocate_data != null)
                        {
                            DataRow[] dr = get_old_allocate_data.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                            if (dr.Length > 0)
                            {
                                re = re + i;
                                save_student_course.doc_no = dr[0]["doc_no"].ToString();
                                save_student_course.cancel_flag = data[i]["cancel_flag"].ToString();
                            }
                            else
                            {
                                re = re + i;
                                save_student_course.doc_no = re.ToString();
                            }
                        }
                        else
                        {
                            re = re + i;
                            save_student_course.doc_no = re.ToString();
                        }

                        save_student_course.user_id = data[i]["user_id"].ToString();

                        if (user_data != null)
                        {
                            DataRow[] dr1 = user_data.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                            if (dr1.Length > 0)
                            {
                                save_student_course.year_code = dr1[0]["year_code"].ToString();
                            }
                        }

                        //DataTable dt = objmaster.check_credit_choice_by_student("", "", data[i]["user_id"].ToString(), "");

                        //if (dt != null)
                        //{
                        //    save_student_course.current_sem_code = dt.Rows[0]["semester_code"].ToString();
                        //}
                        //else
                        //{
                        //    return "semester detail not found of user : " + data[i]["user_id"].ToString();
                        //}

                        save_student_course.course_code = course_code;
                        if (course_data != null)
                        {
                            DataRow[] dr = course_data.Select("course_code = '" + course_code + "'");

                            if (dr.Length > 0)
                            {
                                //save_student_course.semester_code = dr[0]["semester_code"].ToString();
                                save_student_course.credits = dr[0]["course_credits"].ToString();
                                save_student_course.fees = dr[0]["fees"].ToString();
                                save_student_course.dept_code = dr[0]["dept_code"].ToString();
                                save_student_course.round = dr[0]["round"].ToString();
                                //if (data[i]["course_type"].ToString() == "E")
                                //{
                                //  save_student_course.gpa_nongpa = data[i]["gpa_nongpa"].ToString();
                                //}
                            }
                        }

                        save_student_course.course_type = data[i]["course_type"].ToString();
                        save_student_course.gpa_nongpa = data[i]["gpa_nongpa"].ToString();

                        save_student_course.semester_type = sem_code.ToString(); ;
                        save_student_course.year_semester = year.ToString();

                        save_student_course.cancel_flag = "N";
                        save_student_course.created_by = HttpContext.Current.Session["UserId"].ToString() + "- manually";
                        save_student_course.created_date = System.DateTime.Now;
                        save_student_course.created_host = HttpContext.Current.Request.UserHostName;

                        //obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
                        obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(save_student_course);
                    }
                    else
                    {
                        if (get_old_allocate_data != null)
                        {
                            DataRow[] dr1 = get_old_allocate_data.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                            if (dr1.Length > 0)
                            {
                                Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow save_student_course = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                                //re = re + i;

                                save_student_course.doc_no = dr1[0]["doc_no"].ToString();
                                save_student_course.cancel_flag = data[i]["cancel_flag"].ToString();
                                save_student_course.user_id = data[i]["user_id"].ToString();
                                save_student_course.year_code = dr1[0]["year_code"].ToString();
                                save_student_course.course_code = course_code;
                                //save_student_course.semester_code = dr[0]["semester_code"].ToString();
                                save_student_course.credits = dr1[0]["credits"].ToString();
                                save_student_course.fees = dr1[0]["fees"].ToString();
                                save_student_course.dept_code = dr1[0]["dept_code"].ToString();

                                save_student_course.course_type = dr1[0]["course_type"].ToString();
                                save_student_course.gpa_nongpa = dr1[0]["gpa_nongpa"].ToString();

                                save_student_course.semester_type = sem_code.ToString();
                                save_student_course.year_semester = year.ToString();
                                save_student_course.cancel_flag = "Y";
                                save_student_course.round = dr1[0]["round"].ToString();
                                save_student_course.created_by = dr1[0]["created_by"].ToString();
                                save_student_course.created_date = Convert.ToDateTime(dr1[0]["created_date"].ToString());
                                save_student_course.created_host = dr1[0]["created_host"].ToString();
                                save_student_course.last_modified_by = HttpContext.Current.Session["UserId"].ToString() + "- manually";
                                save_student_course.last_modified_date = System.DateTime.Now;
                                save_student_course.last_modified_host = HttpContext.Current.Request.UserHostName;

                                //obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
                                obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(save_student_course);
                            }
                        }
                    }
                }

                objBLReturnObject = objmaster.Save_assign_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), "manually", HttpContext.Current.Request.UserHostName);
            }
            else
            {
                return "error on course";
            }

            if (objBLReturnObject.ExecutionStatus == 1) 
            {
                dynamic get_status = objmaster.sws_course_manually_allocation_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), "manually", HttpContext.Current.Request.UserHostName);
            }

            ////objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }

        string msg = "";

        return objBLReturnObject.ServerMessage;
    }

    [WebMethod(EnableSession = true)]
    public string save_ws_data_before_allocation(string manually_data, string course_code, string sem_code, string year, string dept_code, string prog_code)
    {
        //Save Compliance Details in compliance_entry table.

        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(manually_data);

            DataTable get_student_data = objmaster.get_ws_student_course_dtl_data(sem_code, year, course_code);

            for (int i = 0; i < data.Count; i++)
            {
                if (get_student_data != null)
                {
                    //get_student_data.Select("");

                    DataRow[] dr = get_student_data.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                    if (dr.Length > 0)
                    {
                        re = i + 1;

                        Ds_Student_Course_detail_WS.ws_student_wise_course_dtlRow student_wise_course = obj_student.ws_student_wise_course_dtl.Newws_student_wise_course_dtlRow();

                        student_wise_course.doc_no = dr[0]["doc_no"].ToString();
                        student_wise_course.user_id = dr[0]["user_id"].ToString();
                        student_wise_course.year_code = dr[0]["year_code"].ToString();
                        student_wise_course.course_code = dr[0]["course_code"].ToString();
                        student_wise_course.semester_code = dr[0]["semester_code"].ToString();
                        student_wise_course.current_sem_code = dr[0]["current_sem_code"].ToString();

                        student_wise_course.course_type = data[i]["course_type"].ToString();
                        student_wise_course.gpa_nongpa = data[i]["gpa_nongpa"].ToString();

                        student_wise_course.credits = dr[0]["credits"].ToString();
                        student_wise_course.dept_code = dr[0]["dept_code"].ToString();
                        student_wise_course.fees = dr[0]["fees"].ToString();
                        student_wise_course.priority = dr[0]["priority"].ToString();
                        //student_wise_course.status = dr[i]["status"].ToString();
                        student_wise_course.semester_type = dr[0]["semester_type"].ToString();
                        student_wise_course.year_semester = dr[0]["year_semester"].ToString();
                        student_wise_course.round = dr[0]["round"].ToString();
                        student_wise_course.created_by = dr[0]["created_by"].ToString();
                        student_wise_course.created_date = Convert.ToDateTime(dr[0]["created_date"]);
                        student_wise_course.created_host = dr[0]["created_host"].ToString();
                        student_wise_course.cancel_flag = dr[0]["cancel_flag"].ToString();
                        student_wise_course.status = "A";

                        student_wise_course.course_number = dr[0]["course_number"].ToString();
                        student_wise_course.is_cancel = dr[0]["is_cancel"].ToString();

                        student_wise_course.last_modified_by = HttpContext.Current.Session["UserId"].ToString() + "- manually";
                        student_wise_course.last_modified_date = System.DateTime.Now;
                        student_wise_course.last_modified_host = HttpContext.Current.Request.UserHostName;

                        obj_student.ws_student_wise_course_dtl.Addws_student_wise_course_dtlRow(student_wise_course);

                        Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow student_course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                        student_course_allocation.doc_no = re.ToString();
                        student_course_allocation.user_id = dr[0]["user_id"].ToString();
                        student_course_allocation.year_code = dr[0]["year_code"].ToString();
                        student_course_allocation.course_code = dr[0]["course_code"].ToString();
                        student_course_allocation.semester_code = dr[0]["semester_code"].ToString();
                        student_course_allocation.current_sem_code = dr[0]["current_sem_code"].ToString();

                        student_course_allocation.course_type = data[i]["course_type"].ToString();
                        student_course_allocation.gpa_nongpa = data[i]["gpa_nongpa"].ToString();

                        student_course_allocation.credits = dr[0]["credits"].ToString();
                        student_course_allocation.dept_code = dr[0]["dept_code"].ToString();
                        student_course_allocation.fees = dr[0]["fees"].ToString();
                        student_course_allocation.priority = dr[0]["priority"].ToString();
                        student_course_allocation.semester_type = dr[0]["semester_type"].ToString();
                        student_course_allocation.year_semester = dr[0]["year_semester"].ToString();
                        student_course_allocation.round = dr[0]["round"].ToString();
                        student_course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString() + "- manually"; ;
                        student_course_allocation.created_date = System.DateTime.Now;
                        student_course_allocation.created_host = HttpContext.Current.Request.UserHostName;
                        student_course_allocation.cancel_flag = dr[0]["cancel_flag"].ToString();

                        //student_wise_course.status = "A";
                        //student_wise_course.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                        //student_wise_course.last_modified_date = System.DateTime.Now;
                        //student_wise_course.last_modified_host = HttpContext.Current.Request.UserHostName;

                        obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(student_course_allocation);
                    }
                }
            }

            objBLReturnObject = objmaster.save_ws_change_data_before_allocation(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);

            if (objBLReturnObject.ExecutionStatus == 2)
            {
                objBLReturnObject.ServerMessage = "Problem in update data " + objBLReturnObject.ServerMessage;
            }
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }

        return objBLReturnObject.ServerMessage;
    }

    //[WebMethod(EnableSession = true)]
    //public string Save_assign_course_dtl(string sem_code, string year_code)
    //{
    //     Save Compliance Details in compliance_entry table.


    //    int re = 0;

    //    try
    //    {

    //        DataTable dt_already_allocated = objmaster.get_allocate_course_data(sem_code,year_code);


    //        if (dt_already_allocated != null)
    //        {
    //            return "already";
    //        }


    //        DataTable dt_course = objmaster.get_course_seat_dtl(year_code);

    //        DataTable dt_all_saved_data = objmaster.get_all_course_dtl(sem_code, year_code);

    //        DataTable dt_total_course = objmaster.Get_saved_selected_course_data_for_report(sem_code, year_code);

    //        DataTable dt_mandatory = null;

    //        dt_all_saved_data.DefaultView.RowFilter = "course_type = 'M'";

    //        dt_mandatory = dt_all_saved_data.DefaultView.ToTable();


    //        for (int i = 0; i < dt_course.Rows.Count; i++)
    //        {
    //            string course_code = dt_course.Rows[i]["course_code"].ToString();

    //            int available_seats = Convert.ToInt32(dt_course.Rows[i]["available_seat"].ToString());

    //            DataRow[] dr_mandatory = dt_mandatory.Select("course_code = '" + course_code + "'");

    //            DataRow[] dr_total = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'M'");


    //            if (dr_mandatory.Length > 0)
    //            {
    //                if (dr_total.Length > 0)
    //                {

    //                    if (Convert.ToInt32(dr_total[0]["total_course"].ToString()) <= available_seats)
    //                    {


    //                    }
    //                    else
    //                    {

    //                        return "available_seat:" + course_code;
    //                    }
    //                }
    //            }

    //        }


    //        # region for mandatory allocation
    //        for (int i = 0; i < dt_course.Rows.Count; i++)
    //        {

    //            string course_code = dt_course.Rows[i]["course_code"].ToString();

    //            int available_seats = Convert.ToInt32(dt_course.Rows[i]["available_seat"].ToString());

    //            DataRow[] dr_mandatory = dt_mandatory.Select("course_code = '" + course_code + "'");

    //            DataRow[] dr_total = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'M'");


    //            if (dr_mandatory.Length > 0)
    //            {
    //                if (dr_total.Length > 0)
    //                {

    //                    if (Convert.ToInt32(dr_total[0]["total_course"].ToString()) <= available_seats)
    //                    {
    //                        for (int j = 0; j < dr_mandatory.Length; j++)
    //                        {

    //                            re = re + 1;
    //                            Ds_Student_Course_detail_WS.student_course_allocate_dtlRow course_allocation = obj_student.student_course_allocate_dtl.Newstudent_course_allocate_dtlRow();

    //                            course_allocation.doc_no = re.ToString();
    //                            course_allocation.user_id = dr_mandatory[j]["user_id"].ToString();
    //                            course_allocation.year_code = dr_mandatory[j]["year_code"].ToString();
    //                            course_allocation.course_code = dr_mandatory[j]["course_code"].ToString();
    //                            course_allocation.semester_code = dr_mandatory[j]["semester_code"].ToString();
    //                            course_allocation.current_sem_code = dr_mandatory[j]["current_sem_code"].ToString();
    //                            course_allocation.course_type = dr_mandatory[j]["course_type"].ToString();
    //                            course_allocation.credits = dr_mandatory[j]["credits"].ToString();
    //                            course_allocation.credits = dr_mandatory[j]["credits"].ToString();

    //                            course_allocation.cancel_flag = "N";
    //                            course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
    //                            course_allocation.created_date = System.DateTime.Now;
    //                            course_allocation.created_host = HttpContext.Current.Request.UserHostName;

    //                            obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
    //                            obj_student.student_course_allocate_dtl.Addstudent_course_allocate_dtlRow(course_allocation);
    //                        }
    //                    }
    //                    else
    //                    {

    //                    }
    //                }
    //            }

    //        }
    //        #endregion


    //        # region for Elective allocation

    //        DataTable dt_elective = null;

    //        dt_all_saved_data.DefaultView.RowFilter = "course_type = 'E'";

    //        dt_elective = dt_all_saved_data.DefaultView.ToTable();

    //        int total_allocated_Seat = 0;

    //        for (int priority = 1; priority <= 10; priority++)
    //        {
    //            int pr = priority;
    //            for (int i = 0; i < dt_course.Rows.Count; i++)
    //            {

    //                string course_code = dt_course.Rows[i]["course_code"].ToString();

    //                int available_seats = Convert.ToInt32(dt_course.Rows[i]["available_seat"].ToString());

    //                int seat_for_elective = 0;
    //                int total_mandatory_seat = 0;

    //                DataRow[] dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");

    //                DataRow[] dr_total = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'E'");

    //                DataRow[] dr_total_mandatory_seat = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'M'");

    //                if (dr_elective.Length > 0)
    //                {

    //                    if (dr_total.Length > 0)
    //                    {


    //                        if (dr_total_mandatory_seat.Length > 0)
    //                        {
    //                            seat_for_elective = available_seats - Convert.ToInt32(dr_total_mandatory_seat[0]["total_course"]);

    //                            total_mandatory_seat = Convert.ToInt32(dr_total_mandatory_seat[0]["total_course"]);
    //                        }
    //                        else
    //                        {
    //                            seat_for_elective = available_seats;



    //                        }

    //                        if (available_seats > total_mandatory_seat)
    //                        {

    //                            DataRow[] dr = obj_student.student_course_allocate_dtl.Select("course_code = '" + course_code + "'");

    //                            if (dr.Length > 0)
    //                            {
    //                                total_allocated_Seat = dr.Length;
    //                            }

    //                            if (available_seats > total_allocated_Seat)
    //                            {
    //                                int open_seat = available_seats - total_allocated_Seat;

    //                                if (open_seat > dr_elective.Length)
    //                                {
    //                                    for (int j = 0; j < dr_elective.Length; j++)
    //                                    {

    //                                        re = re + 1;
    //                                        Ds_Student_Course_detail_WS.student_course_allocate_dtlRow course_allocation = obj_student.student_course_allocate_dtl.Newstudent_course_allocate_dtlRow();

    //                                        course_allocation.doc_no = re.ToString();
    //                                        course_allocation.user_id = dr_elective[j]["user_id"].ToString();
    //                                        course_allocation.year_code = dr_elective[j]["year_code"].ToString();
    //                                        course_allocation.course_code = dr_elective[j]["course_code"].ToString();
    //                                        course_allocation.semester_code = dr_elective[j]["semester_code"].ToString();
    //                                        course_allocation.current_sem_code = dr_elective[j]["current_sem_code"].ToString();
    //                                        course_allocation.course_type = dr_elective[j]["course_type"].ToString();
    //                                        course_allocation.credits = dr_elective[j]["credits"].ToString();
    //                                        course_allocation.gpa_nongpa = dr_elective[j]["gpa_nongpa"].ToString();
    //                                        course_allocation.priority = dr_elective[j]["priority"].ToString();
    //                                        course_allocation.dept_code = dr_elective[j]["dept_code"].ToString();

    //                                        course_allocation.cancel_flag = "N";
    //                                        course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
    //                                        course_allocation.created_date = System.DateTime.Now;
    //                                        course_allocation.created_host = HttpContext.Current.Request.UserHostName;

    //                                        obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
    //                                        obj_student.student_course_allocate_dtl.Addstudent_course_allocate_dtlRow(course_allocation);
    //                                    }
    //                                }
    //                                else
    //                                {

    //                                    if (seat_for_elective >= Convert.ToInt32(dr_total[0]["total_course"]))
    //                                    {
    //                                        for (int j = 0; j < dr_elective.Length; j++)
    //                                        {

    //                                            re = re + 1;
    //                                            Ds_Student_Course_detail_WS.student_course_allocate_dtlRow course_allocation = obj_student.student_course_allocate_dtl.Newstudent_course_allocate_dtlRow();

    //                                            course_allocation.doc_no = re.ToString();
    //                                            course_allocation.user_id = dr_elective[j]["user_id"].ToString();
    //                                            course_allocation.year_code = dr_elective[j]["year_code"].ToString();
    //                                            course_allocation.course_code = dr_elective[j]["course_code"].ToString();
    //                                            course_allocation.semester_code = dr_elective[j]["semester_code"].ToString();
    //                                            course_allocation.current_sem_code = dr_elective[j]["current_sem_code"].ToString();
    //                                            course_allocation.course_type = dr_elective[j]["course_type"].ToString();
    //                                            course_allocation.credits = dr_elective[j]["credits"].ToString();
    //                                            course_allocation.gpa_nongpa = dr_elective[j]["gpa_nongpa"].ToString();
    //                                            course_allocation.priority = dr_elective[j]["priority"].ToString();
    //                                            course_allocation.dept_code = dr_elective[j]["dept_code"].ToString();

    //                                            course_allocation.cancel_flag = "N";
    //                                            course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
    //                                            course_allocation.created_date = System.DateTime.Now;
    //                                            course_allocation.created_host = HttpContext.Current.Request.UserHostName;

    //                                            //obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
    //                                            obj_student.student_course_allocate_dtl.Addstudent_course_allocate_dtlRow(course_allocation);
    //                                        }
    //                                    }
    //                                    else
    //                                    {



    //                                    Random rDom = new Random();
    //                                    int k = 0;
    //                                    for (int ctr = 1; ctr <= open_seat; ctr++)
    //                                    {
    //                                        k = rDom.Next(1, dr_elective.Length);

    //                                        re = re + 1;

    //                                        Ds_Student_Course_detail_WS.student_course_allocate_dtlRow course_allocation = obj_student.student_course_allocate_dtl.Newstudent_course_allocate_dtlRow();

    //                                        course_allocation.doc_no = re.ToString();
    //                                        course_allocation.user_id = dr_elective[k]["user_id"].ToString();
    //                                        course_allocation.year_code = dr_elective[k]["year_code"].ToString();
    //                                        course_allocation.course_code = dr_elective[k]["course_code"].ToString();
    //                                        course_allocation.semester_code = dr_elective[k]["semester_code"].ToString();
    //                                        course_allocation.current_sem_code = dr_elective[k]["current_sem_code"].ToString();
    //                                        course_allocation.course_type = dr_elective[k]["course_type"].ToString();
    //                                        course_allocation.credits = dr_elective[k]["credits"].ToString();
    //                                        course_allocation.gpa_nongpa = dr_elective[k]["gpa_nongpa"].ToString();
    //                                        course_allocation.priority = dr_elective[k]["priority"].ToString();
    //                                        course_allocation.dept_code = dr_elective[k]["dept_code"].ToString();

    //                                        course_allocation.cancel_flag = "N";
    //                                        course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
    //                                        course_allocation.created_date = System.DateTime.Now;
    //                                        course_allocation.created_host = HttpContext.Current.Request.UserHostName;


    //                                        obj_student.student_course_allocate_dtl.Addstudent_course_allocate_dtlRow(course_allocation);


    //                                    }


    //                                      }
    //                                }
    //                            }
    //                        }



    //                    }
    //                }



    //            }
    //        }
    //        #endregion

    //        Data.DataTable dt = new Data.DataTable("YourDataTable");
    //        Data.DataTable dtRandomRows = new Data.DataTable("RandomTable");
    //        dtRandomRows = dt.Clone;
    //        Random rDom = new Random();
    //        int i = 0;
    //        for (int ctr = 1; ctr <= 15; ctr++)
    //        {
    //            i = rDom.Next(1, 20);
    //            dtRandomRows.Rows.Add(dt.Rows(i));
    //        }
    //        dtRandomRows.AcceptChanges();


    //        //objBLReturnObject = objMaster.save_user_fees(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
    //        objBLReturnObject = objmaster.Save_assign_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Request.UserHostName);
    //    }
    //    catch (Exception ex)
    //    {
    //        return "Problem in Save DATA.";
    //    }
    //    return objBLReturnObject.ServerMessage;

    //}

    [WebMethod(EnableSession = true)]
    public string Save_assign_course_dtl(string sem_code, string year_code)
    {
        // Save Compliance Details in compliance_entry table.


        int re = 0;

        try
        {
            #region check course allocation is already completed or not

            DataTable dt_already_allocated = objmaster.get_ws_allocate_course_data(sem_code, year_code, "");


            //if (dt_already_allocated != null)
            //{
            //    return "already";
            //}
            #endregion

            #region retrieve all data for coursed

            DataTable dt_choice = objmaster.check_credit_choice_by_student(sem_code, "", "", "");

            DataTable dt_fees_status = objmaster.Get_WS_credit_choice_for_student_for_assign(sem_code, year_code);

            DataTable dt_course = objmaster.get_ws_course_seat_dtl(year_code, sem_code);

            DataTable dt_all_saved_data = objmaster.get_ws_all_course_dtl(sem_code, year_code);

            DataTable dt_total_course = objmaster.Get_WS_saved_selected_course_data_for_report(sem_code, year_code);

            DataTable dt_course_before_allocation = objmaster.get_data_before_allocation(sem_code, year_code);

            DataTable dt_mandatory = null;

            if (dt_all_saved_data == null)
            {
                return "No registered data found for allocation";
            }

            dt_all_saved_data.DefaultView.RowFilter = "course_type = 'M'";

            dt_mandatory = dt_all_saved_data.DefaultView.ToTable();
            int available_seats = 0;
            #endregion

            #region check available seat of course is less than mandatory course selection
            //for (int i = 0; i < dt_course.Rows.Count; i++)
            //{
            //    string course_code = dt_course.Rows[i]["course_code"].ToString();


            //    if (dt_course.Rows[i]["available_seat"].ToString() != "")
            //    {
            //        available_seats = Convert.ToInt32(dt_course.Rows[i]["available_seat"].ToString());
            //    }



            //    DataRow[] dr_mandatory = dt_mandatory.Select("course_code = '" + course_code + "'");

            //    DataRow[] dr_total = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'M'");


            //    if (dr_mandatory.Length > 0)
            //    {
            //        if (dr_total.Length > 0)
            //        {
            //            if (available_seats > 0)
            //            {



            //                if (Convert.ToInt32(dr_total[0]["total_course"].ToString()) <= available_seats)
            //                {


            //                }
            //                else
            //                {

            //                    return "available_seat:" + course_code;
            //                }
            //            }
            //        }
            //    }

            //}
            #endregion

            #region add Before Allocate data in  XSD datatable

            if (dt_course_before_allocation != null)
            {


                for (int i = 0; i < dt_course_before_allocation.Rows.Count; i++)
                {
                    #region add finel data in  XSD datatable


                    Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                    course_allocation.doc_no = dt_course_before_allocation.Rows[i]["doc_no"].ToString();
                    course_allocation.user_id = dt_course_before_allocation.Rows[i]["user_id"].ToString();
                    course_allocation.year_code = dt_course_before_allocation.Rows[i]["year_code"].ToString();
                    course_allocation.course_code = dt_course_before_allocation.Rows[i]["course_code"].ToString();
                    course_allocation.semester_code = dt_course_before_allocation.Rows[i]["semester_code"].ToString();
                    course_allocation.current_sem_code = dt_course_before_allocation.Rows[i]["current_sem_code"].ToString();
                    course_allocation.course_type = dt_course_before_allocation.Rows[i]["course_type"].ToString();
                    course_allocation.credits = dt_course_before_allocation.Rows[i]["credits"].ToString();
                    course_allocation.fees = dt_course_before_allocation.Rows[i]["fees"].ToString();
                    course_allocation.gpa_nongpa = dt_course_before_allocation.Rows[i]["gpa_nongpa"].ToString();//"N";
                    course_allocation.priority = dt_course_before_allocation.Rows[i]["priority"].ToString();
                    course_allocation.dept_code = dt_course_before_allocation.Rows[i]["dept_code"].ToString();
                    course_allocation.semester_type = current_ws_sem.ToString();
                    course_allocation.year_semester = current_ws_year.ToString();
                    course_allocation.cancel_flag = "N";
                    course_allocation.round = dt_course_before_allocation.Rows[i]["round"].ToString(); ;
                    course_allocation.created_by = dt_course_before_allocation.Rows[i]["created_by"].ToString();
                    course_allocation.created_date = Convert.ToDateTime(dt_course_before_allocation.Rows[i]["created_date"]);
                    course_allocation.created_host = dt_course_before_allocation.Rows[i]["created_host"].ToString();


                    obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(course_allocation);

                    #endregion
                }
            }
            #endregion

            # region for Elective allocation

            DataTable dt_elective = null;
            available_seats = 0;

            DataTable dt_all_elective_data = objmaster.get_ws_elective_all_course_data(sem_code, year_code);

            DataTable dt_course_time_day_data = objmaster.get_ws_course_time_day_data(sem_code, year_code);

            //filter elective course selected by student
            //dt_all_saved_data.DefaultView.RowFilter = "course_type = 'E'";

            dt_elective = dt_all_saved_data.Copy();

            int total_allocated_Seat = 0;

            if (dt_all_elective_data != null)
            {

                DataRow[] dr_zero_seats = dt_all_elective_data.Select("available_seat = '0'");

                if (dr_zero_seats.Length > 0)
                {

                    for (int i = 0; i < dr_zero_seats.Length; i++)
                    {
                        int pri = Convert.ToInt16(dr_zero_seats[i]["priority"]);

                        DataRow[] user_data = dt_elective.Select("course_code = '" + dr_zero_seats[i]["course_code"].ToString() + "' and priority = '" + pri + "'");

                        if (user_data.Length > 0)
                        {
                            for (int j = 0; j < user_data.Length; j++)
                            {

                                for (int l = 1; l < 5; l++)
                                {
                                    DataRow[] dr_not_add = dt_elective.Select("user_id = '" + user_data[j]["user_id"] + "'  and priority ='" + (pri + l) + "'");

                                    if (dr_not_add.Length > 0)
                                    {
                                        dr_not_add[0]["priority"] = (pri + l) - 1;

                                        dt_elective.AcceptChanges();


                                    }
                                }
                            }
                        }
                    }

                }




                //string[] priority_array = {"1","11","2","22","3","33","4","44","5","55"};
                //check priority wise Elective Course Allocation
                for (int priority = 1; priority <= 5; priority++)
                {
                    int pr = priority;
                    //check one bye one Elective Course Allocation priority wise
                    for (int i = 0; i < dt_all_elective_data.Rows.Count; i++)
                    {

                        string course_code = dt_all_elective_data.Rows[i]["course_code"].ToString();

                        if (dt_all_elective_data.Rows[i]["available_seat"].ToString() != "")
                        {
                            available_seats = Convert.ToInt32(dt_all_elective_data.Rows[i]["available_seat"].ToString());
                        }

                        int seat_for_elective = 0;
                        int total_mandatory_seat = 0;

                        //   DataRow[] dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");

                        DataRow[] dr_elective = null;

                        //  if (pr == Convert.ToInt16(dt_all_elective_data.Rows[i]["priority"]))
                        //   {
                        dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");
                        //  }
                        //  else
                        //  {
                        //    dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='12'");
                        // }

                        DataRow[] dr_total = dt_total_course.Select("course_code = '" + course_code + "'");

                        DataRow[] dr_total_mandatory_seat = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'E'");

                        if (dr_elective.Length > 0)
                        {

                            if (dr_total.Length > 0)
                            {


                                if (dr_total_mandatory_seat.Length > 0)
                                {
                                    seat_for_elective = available_seats - Convert.ToInt32(dr_total_mandatory_seat[0]["total_course"]);

                                    total_mandatory_seat = Convert.ToInt32(dr_total_mandatory_seat[0]["total_course"]);
                                }
                                else
                                {
                                    seat_for_elective = available_seats;



                                }

                                if (available_seats > 0)
                                {

                                    DataRow[] dr = obj_student.ws_student_course_allocate_dtl.Select("course_code = '" + course_code + "'");

                                    if (dr.Length > 0)
                                    {
                                        total_allocated_Seat = dr.Length;
                                    }
                                    else
                                    {
                                        total_allocated_Seat = 0;
                                    }

                                    if (available_seats > total_allocated_Seat)
                                    {
                                        int open_seat = available_seats - total_allocated_Seat;

                                        if (open_seat >= dr_elective.Length)
                                        {

                                            #region add Course if seat is more than course selection
                                            for (int j = 0; j < dr_elective.Length; j++)
                                            {
                                                #region check credit choice of student with total allocate choice of student
                                                int sum = 0;
                                                int sum1 = 0;
                                                int choice_credit = 0;

                                                //DataRow[] dr_check_choice_credit = dt_choice.Select("student_id = '" + dr_elective[j]["user_id"].ToString() + "'");

                                                //if (dr_check_choice_credit.Length > 0)
                                                //{

                                                //    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                //    {
                                                //        choice_credit = Convert.ToInt32(dr_check_choice_credit[0]["credit_choice"]);
                                                //    }
                                                //    else
                                                //    {
                                                //        choice_credit = 24;
                                                //    }
                                                //}

                                                //else
                                                //{
                                                //    choice_credit = 24;
                                                //}



                                                DataRow[] dr_check_choice_credit = dt_fees_status.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "'");

                                                if (dr_check_choice_credit.Length > 0)
                                                {
                                                    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                    {
                                                        choice_credit = Convert.ToInt16(dr_check_choice_credit[0]["credit_choice"]);
                                                    }
                                                    else
                                                    {
                                                        choice_credit = 8;
                                                    }

                                                }
                                                else
                                                {
                                                    choice_credit = 8;
                                                }


                                                DataRow[] dr_total_credit_selection = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "'");

                                                if (dr_total_credit_selection.Length > 0)
                                                {


                                                    for (int n = 0; n < dr_total_credit_selection.Length; n++)
                                                    {
                                                        sum += Convert.ToInt32(dr_total_credit_selection[n]["credits"]);
                                                    }
                                                    sum1 = sum + Convert.ToInt32(dr_elective[j]["credits"]);

                                                    if (sum1 <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {

                                                        continue;

                                                    }
                                                }
                                                else
                                                {
                                                    if (Convert.ToInt32(dr_elective[j]["credits"]) <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {
                                                        continue;

                                                    }

                                                }


                                                #endregion

                                                # region  check elective course timing conflict

                                                DataRow[] dr_check_timing_elective = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "'");
                                                string flag = "N";
                                                if (dr_check_timing_elective.Length > 0)
                                                {
                                                    if (dt_course_time_day_data != null)
                                                    {
                                                        DataRow[] dr_time_day_data = dt_course_time_day_data.Select(" course_code = '" + dr_elective[j]["course_code"] + "'");

                                                        if (dr_time_day_data.Length > 0)
                                                        {
                                                            for (int m = 0; m < dr_check_timing_elective.Length; m++)
                                                            {
                                                                DataRow[] dr_time_day_data1 = dt_course_time_day_data.Select(" course_code = '" + dr_check_timing_elective[m]["course_code"] + "'");

                                                                if (dr_time_day_data1.Length > 0)
                                                                {
                                                                    for (int a = 0; a < dr_time_day_data1.Length; a++)
                                                                    {
                                                                        DateTime last_from_date = Convert.ToDateTime(dr_time_day_data1[a]["from_date"].ToString());
                                                                        DateTime last_to_date = Convert.ToDateTime(dr_time_day_data1[a]["to_date"].ToString());


                                                                        string last_from_time = dr_time_day_data1[a]["from_time"].ToString();
                                                                        string last_to_time = dr_time_day_data1[a]["to_time"].ToString();
                                                                        string last_day_code = dr_time_day_data1[a]["day_code"].ToString();

                                                                        for (int b = 0; b < dr_time_day_data.Length; b++)
                                                                        {

                                                                            DateTime from_date = Convert.ToDateTime(dr_time_day_data[b]["from_date"].ToString());
                                                                            DateTime to_date = Convert.ToDateTime(dr_time_day_data[b]["to_date"].ToString());

                                                                            string from_time = dr_time_day_data[b]["from_time"].ToString();
                                                                            string to_time = dr_time_day_data[b]["to_time"].ToString();
                                                                            string day_code = dr_time_day_data[b]["day_code"].ToString();


                                                                            Boolean flag1 = false;

                                                                            if (last_from_date.Ticks > from_date.Ticks && last_from_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_to_date.Ticks > from_date.Ticks && last_to_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (from_date.Ticks > last_from_date.Ticks && from_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (to_date.Ticks > last_from_date.Ticks && to_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_from_date.Ticks == from_date.Ticks || last_to_date.Ticks == to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_from_date.Ticks == to_date.Ticks || last_to_date.Ticks == from_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }


                                                                            if (flag1 == true)
                                                                            {

                                                                                flag = "Y";
                                                                                break;

                                                                                //if (last_day_code == day_code)
                                                                                //{
                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_from_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }


                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }



                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) == Convert.ToDecimal(from_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) == Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(from_time.Replace(':', '.')) > Convert.ToDecimal(last_from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }
                                                                                //}
                                                                            }
                                                                        }
                                                                    }
                                                                }

                                                                if (flag == "Y")
                                                                {
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }

                                                }

                                                if (flag == "Y")
                                                {
                                                    continue;
                                                }

                                                #endregion

                                                #region add data in XSD datatable

                                                DataRow[] dr_total_credit_selection_new = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "' and course_code = '" + dr_elective[j]["course_code"] + "'");

                                                if (dr_total_credit_selection_new.Length == 0)
                                                {
                                                    DataTable dt_WS_Course_dtl_new = objmaster.Get_WS_Course_dtl(current_ws_sem.ToString(), current_ws_year.ToString(), dr_elective[j]["course_code"].ToString());

                                                    re = re + 1;
                                                    Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                                                    course_allocation.doc_no = re.ToString();
                                                    course_allocation.user_id = dr_elective[j]["user_id"].ToString();
                                                    course_allocation.year_code = dr_elective[j]["year_code"].ToString();
                                                    course_allocation.course_code = dr_elective[j]["course_code"].ToString();
                                                    course_allocation.semester_code = dr_elective[j]["semester_code"].ToString();
                                                    course_allocation.current_sem_code = dr_elective[j]["current_sem_code"].ToString();
                                                    course_allocation.course_type = dr_elective[j]["course_type"].ToString();
                                                    course_allocation.credits = dr_elective[j]["credits"].ToString();
                                                    course_allocation.fees = dr_elective[j]["fees"].ToString();
                                                    course_allocation.gpa_nongpa = dt_WS_Course_dtl_new.Rows[0]["gpa_status"].ToString();//"N";
                                                    course_allocation.priority = dr_elective[j]["priority"].ToString();
                                                    course_allocation.dept_code = dr_elective[j]["dept_code"].ToString();
                                                    course_allocation.semester_type = current_ws_sem.ToString();
                                                    course_allocation.year_semester = current_ws_year.ToString();
                                                    course_allocation.cancel_flag = "N";
                                                    course_allocation.round = current_round;
                                                    course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
                                                    course_allocation.created_date = System.DateTime.Now;
                                                    course_allocation.created_host = HttpContext.Current.Request.UserHostName;


                                                    obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(course_allocation);
                                                }
                                                #endregion
                                            }

                                            #region check if course is not assign to student update priority to one
                                            for (int j = 0; j < dr_elective.Length; j++)
                                            {
                                                DataRow[] dr_already_add = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"] + "' and course_code = '" + dr_elective[j]["course_code"] + "'  and priority ='" + pr + "'");

                                                if (dr_already_add.Length > 0)
                                                {

                                                }
                                                else
                                                {
                                                    for (int l = 1; l < 10; l++)
                                                    {
                                                        DataRow[] dr_not_add = dt_elective.Select("user_id = '" + dr_elective[j]["user_id"] + "'  and priority ='" + (pr + l) + "'");

                                                        if (dr_not_add.Length > 0)
                                                        {
                                                            dr_not_add[0]["priority"] = (pr + l) - 1;

                                                            dt_elective.AcceptChanges();


                                                        }
                                                    }

                                                }
                                            }
                                            #endregion

                                            #endregion

                                        }
                                        else
                                        {

                                            #region add randomly course allocation if student is more than seats

                                            Random rDom = new Random();
                                            int k = 0;
                                            string old = "";


                                            DataTable dt_random = new DataTable();
                                            dt_random.Columns.Add("random_no");
                                            DataRow row;
                                            int counter = 0;

                                            for (int ctr = 1; ctr <= open_seat; ctr++)
                                            {


                                                # region find randomly data from all data
                                                int choice_credit = 0;
                                                k = rDom.Next(0, dr_elective.Length);


                                                if (counter == dr_elective.Length)
                                                {
                                                    break;
                                                }

                                                if (dt_random.Rows.Count > 0)
                                                {
                                                    DataRow[] dr_random = dt_random.Select("random_no = '" + k + "'");

                                                    if (dr_random.Length > 0)
                                                    {
                                                        ctr = ctr - 1;
                                                        continue;
                                                    }
                                                    else
                                                    {
                                                        counter = counter + 1;
                                                    }
                                                }
                                                else
                                                {
                                                    counter = counter + 1;
                                                }

                                                row = dt_random.NewRow();
                                                row["random_no"] = k.ToString();

                                                dt_random.Rows.Add(row);

                                                #endregion

                                                #region check credit choice of student with total allocate choice of student

                                                int sum = 0;
                                                int sum1 = 0;

                                                //DataRow[] dr_check_choice_credit = dt_choice.Select("student_id = '" + dr_elective[k]["user_id"] + "'");


                                                //if (dr_check_choice_credit.Length > 0)
                                                //{

                                                //    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                //    {
                                                //        choice_credit = Convert.ToInt32(dr_check_choice_credit[0]["credit_choice"]);
                                                //    }
                                                //    else
                                                //    {
                                                //        choice_credit = 24;
                                                //    }
                                                //}
                                                //else
                                                //{
                                                //    choice_credit = 24;
                                                //}

                                                DataRow[] dr_check_choice_credit = dt_fees_status.Select("user_id = '" + dr_elective[k]["user_id"] + "'");


                                                if (dr_check_choice_credit.Length > 0)
                                                {
                                                    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                    {
                                                        choice_credit = Convert.ToInt16(dr_check_choice_credit[0]["credit_choice"]);
                                                    }
                                                    else
                                                    {
                                                        choice_credit = 8;
                                                    }

                                                }
                                                else
                                                {
                                                    choice_credit = 8;
                                                }





                                                DataRow[] dr_total_credit_selection = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[k]["user_id"].ToString() + "'");

                                                if (dr_total_credit_selection.Length > 0)
                                                {


                                                    for (int n = 0; n < dr_total_credit_selection.Length; n++)
                                                    {
                                                        sum += Convert.ToInt32(dr_total_credit_selection[n]["credits"]);
                                                    }

                                                    sum1 = sum + Convert.ToInt32(dr_elective[k]["credits"]);

                                                    if (sum1 <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {


                                                        ctr = ctr - 1;
                                                        continue;

                                                    }
                                                }
                                                else
                                                {

                                                    if (Convert.ToInt32(dr_elective[k]["credits"]) <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {
                                                        continue;

                                                    }
                                                }
                                                #endregion

                                                # region  check elective course timing conflict

                                                DataRow[] dr_check_timing_elective = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[k]["user_id"].ToString() + "' ");

                                                string flag = "N";

                                                if (dr_check_timing_elective.Length > 0)
                                                {
                                                    if (dt_course_time_day_data != null)
                                                    {
                                                        DataRow[] dr_time_day_data = dt_course_time_day_data.Select(" course_code = '" + dr_elective[k]["course_code"] + "'");

                                                        if (dr_time_day_data.Length > 0)
                                                        {
                                                            for (int m = 0; m < dr_check_timing_elective.Length; m++)
                                                            {
                                                                DataRow[] dr_time_day_data1 = dt_course_time_day_data.Select(" course_code = '" + dr_check_timing_elective[m]["course_code"] + "'");

                                                                if (dr_time_day_data1.Length > 0)
                                                                {
                                                                    for (int a = 0; a < dr_time_day_data1.Length; a++)
                                                                    {

                                                                        DateTime last_from_date = Convert.ToDateTime(dr_time_day_data1[a]["from_date"].ToString());
                                                                        DateTime last_to_date = Convert.ToDateTime(dr_time_day_data1[a]["to_date"].ToString());


                                                                        string last_from_time = dr_time_day_data1[a]["from_time"].ToString();
                                                                        string last_to_time = dr_time_day_data1[a]["to_time"].ToString();
                                                                        string last_day_code = dr_time_day_data1[a]["day_code"].ToString();

                                                                        for (int b = 0; b < dr_time_day_data.Length; b++)
                                                                        {
                                                                            DateTime from_date = Convert.ToDateTime(dr_time_day_data[b]["from_date"].ToString());
                                                                            DateTime to_date = Convert.ToDateTime(dr_time_day_data[b]["to_date"].ToString());

                                                                            string from_time = dr_time_day_data[b]["from_time"].ToString();
                                                                            string to_time = dr_time_day_data[b]["to_time"].ToString();
                                                                            string day_code = dr_time_day_data[b]["day_code"].ToString();

                                                                            Boolean flag1 = false;

                                                                            if (last_from_date.Ticks > from_date.Ticks && last_from_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_to_date.Ticks > from_date.Ticks && last_to_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (from_date.Ticks > last_from_date.Ticks && from_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (to_date.Ticks > last_from_date.Ticks && to_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_from_date.Ticks == from_date.Ticks || last_to_date.Ticks == to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_from_date.Ticks == to_date.Ticks || last_to_date.Ticks == from_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            if (flag1 == true)
                                                                            {
                                                                                flag = "Y";
                                                                                break;

                                                                                //if (last_day_code == day_code)
                                                                                //{
                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_from_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }


                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }



                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) == Convert.ToDecimal(from_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) == Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(from_time.Replace(':', '.')) > Convert.ToDecimal(last_from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }
                                                                                //}
                                                                            }
                                                                        }
                                                                    }
                                                                }

                                                                if (flag == "Y")
                                                                {
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }

                                                }

                                                if (flag == "Y")
                                                {
                                                    ctr = ctr - 1;
                                                    continue;
                                                }

                                                #endregion

                                                #region add finel data in  XSD datatable

                                                DataRow[] dr_total_credit_selection_new = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[k]["user_id"].ToString() + "' and course_code = '" + dr_elective[k]["course_code"] + "'");

                                                if (dr_total_credit_selection_new.Length == 0)
                                                {
                                                    DataTable dt_WS_Course_dtl_new = objmaster.Get_WS_Course_dtl(current_ws_sem.ToString(), current_ws_year.ToString(), dr_elective[k]["course_code"].ToString());

                                                    re = re + 1;

                                                    Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                                                    course_allocation.doc_no = re.ToString();
                                                    course_allocation.user_id = dr_elective[k]["user_id"].ToString();
                                                    course_allocation.year_code = dr_elective[k]["year_code"].ToString();
                                                    course_allocation.course_code = dr_elective[k]["course_code"].ToString();
                                                    course_allocation.semester_code = dr_elective[k]["semester_code"].ToString();
                                                    course_allocation.current_sem_code = dr_elective[k]["current_sem_code"].ToString();
                                                    course_allocation.course_type = dr_elective[k]["course_type"].ToString();
                                                    course_allocation.credits = dr_elective[k]["credits"].ToString();
                                                    course_allocation.fees = dr_elective[k]["fees"].ToString();
                                                    course_allocation.gpa_nongpa = dt_WS_Course_dtl_new.Rows[0]["gpa_status"].ToString();//"N";
                                                    course_allocation.priority = dr_elective[k]["priority"].ToString();
                                                    course_allocation.dept_code = dr_elective[k]["dept_code"].ToString();
                                                    course_allocation.semester_type = current_ws_sem.ToString();
                                                    course_allocation.year_semester = current_ws_year.ToString();
                                                    course_allocation.cancel_flag = "N";
                                                    course_allocation.round = current_round;
                                                    course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
                                                    course_allocation.created_date = System.DateTime.Now;
                                                    course_allocation.created_host = HttpContext.Current.Request.UserHostName;


                                                    obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(course_allocation);
                                                }
                                                #endregion

                                            }

                                            #region  check if course is not assign to student by randomly update priority to one
                                            for (int j = 0; j < dr_elective.Length; j++)
                                            {
                                                DataRow[] dr_already_add = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"] + "' and course_code = '" + dr_elective[j]["course_code"] + "' and  priority ='" + pr + "'");

                                                if (dr_already_add.Length > 0)
                                                {

                                                }
                                                else
                                                {
                                                    for (int l = 1; l < 10; l++)
                                                    {
                                                        DataRow[] dr_not_add = dt_elective.Select("user_id = '" + dr_elective[j]["user_id"] + "'  and priority ='" + (pr + l) + "'");

                                                        if (dr_not_add.Length > 0)
                                                        {
                                                            dr_not_add[0]["priority"] = (pr + l) - 1;

                                                            dt_elective.AcceptChanges();


                                                        }
                                                    }

                                                }
                                            }

                                            #endregion


                                            #endregion

                                        }
                                    }
                                }



                            }
                        }



                    }
                }
            }
            #endregion


            //for (int i = 0; i < obj_student.ws_student_course_allocate_dtl.Rows.Count; i++)
            //{

            //}

            //objBLReturnObject = objmaster.Save_assign_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Request.UserHostName);

            objBLReturnObject = objmaster.Save_ws_assign_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), "", HttpContext.Current.Request.UserHostName, current_ws_sem.ToString(), current_ws_year.ToString());
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string Save_assign_course_dtl_for_logic2(string sem_code, string year_code)
    {
        // Save Compliance Details in compliance_entry table.


        int re = 0;

        try
        {


            #region check course allocation is already completed or not

            DataTable dt_already_allocated = objmaster.get_ws_allocate_course_data(sem_code, year_code, "");


            //if (dt_already_allocated != null)
            //{
            //    return "already";
            //}
            #endregion

            #region retrieve all data for coursed
            DataTable dt_choice = objmaster.check_credit_choice_by_student(sem_code, "", "", "");

            DataTable dt_fees_status = objmaster.Get_WS_credit_choice_for_student_for_assign(sem_code, year_code);

            DataTable dt_course = objmaster.get_ws_course_seat_dtl(year_code, sem_code);

            DataTable dt_all_saved_data = objmaster.get_ws_all_course_dtl(sem_code, year_code);

            DataTable dt_total_course = objmaster.Get_WS_saved_selected_course_data_for_report(sem_code, year_code);

            DataTable dt_course_before_allocation = objmaster.get_data_before_allocation(sem_code, year_code);

            DataTable dt_mandatory = null;

            if (dt_all_saved_data == null)
            {
                return "No registered data found for allocation";
            }

            dt_all_saved_data.DefaultView.RowFilter = "course_type = 'M'";

            dt_mandatory = dt_all_saved_data.DefaultView.ToTable();
            int available_seats = 0;
            #endregion

            #region check available seat of course is less than mandatory course selection
            //for (int i = 0; i < dt_course.Rows.Count; i++)
            //{
            //    string course_code = dt_course.Rows[i]["course_code"].ToString();


            //    if (dt_course.Rows[i]["available_seat"].ToString() != "")
            //    {
            //        available_seats = Convert.ToInt32(dt_course.Rows[i]["available_seat"].ToString());
            //    }



            //    DataRow[] dr_mandatory = dt_mandatory.Select("course_code = '" + course_code + "'");

            //    DataRow[] dr_total = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'M'");


            //    if (dr_mandatory.Length > 0)
            //    {
            //        if (dr_total.Length > 0)
            //        {
            //            if (available_seats > 0)
            //            {



            //                if (Convert.ToInt32(dr_total[0]["total_course"].ToString()) <= available_seats)
            //                {


            //                }
            //                else
            //                {

            //                    return "available_seat:" + course_code;
            //                }
            //            }
            //        }
            //    }

            //}
            #endregion


            #region add Before Allocate data in  XSD datatable

            if (dt_course_before_allocation != null)
            {

                for (int i = 0; i < dt_course_before_allocation.Rows.Count; i++)
                {
                    #region add finel data in  XSD datatable


                    Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                    course_allocation.doc_no = dt_course_before_allocation.Rows[i]["doc_no"].ToString();
                    course_allocation.user_id = dt_course_before_allocation.Rows[i]["user_id"].ToString();
                    course_allocation.year_code = dt_course_before_allocation.Rows[i]["year_code"].ToString();
                    course_allocation.course_code = dt_course_before_allocation.Rows[i]["course_code"].ToString();
                    course_allocation.semester_code = dt_course_before_allocation.Rows[i]["semester_code"].ToString();
                    course_allocation.current_sem_code = dt_course_before_allocation.Rows[i]["current_sem_code"].ToString();
                    course_allocation.course_type = dt_course_before_allocation.Rows[i]["course_type"].ToString();
                    course_allocation.credits = dt_course_before_allocation.Rows[i]["credits"].ToString();
                    course_allocation.fees = dt_course_before_allocation.Rows[i]["fees"].ToString();
                    course_allocation.gpa_nongpa = dt_course_before_allocation.Rows[i]["gpa_nongpa"].ToString();//"N";
                    course_allocation.priority = dt_course_before_allocation.Rows[i]["priority"].ToString();
                    course_allocation.dept_code = dt_course_before_allocation.Rows[i]["dept_code"].ToString();
                    course_allocation.semester_type = current_ws_sem.ToString();
                    course_allocation.year_semester = current_ws_year.ToString();
                    course_allocation.cancel_flag = "N";
                    course_allocation.round = dt_course_before_allocation.Rows[i]["round"].ToString();
                    course_allocation.created_by = dt_course_before_allocation.Rows[i]["created_by"].ToString();
                    course_allocation.created_date = Convert.ToDateTime(dt_course_before_allocation.Rows[i]["created_date"]);
                    course_allocation.created_host = dt_course_before_allocation.Rows[i]["created_host"].ToString();


                    obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(course_allocation);

                    #endregion
                }
            }
            #endregion


            # region for Elective allocation

            DataTable dt_elective = null;
            available_seats = 0;


            DataTable dt_all_elective_data = objmaster.get_ws_elective_all_course_data(sem_code, year_code);

            DataTable dt_course_time_day_data = objmaster.get_ws_course_time_day_data(sem_code, year_code);

            //filter elective course selected by student
            //dt_all_saved_data.DefaultView.RowFilter = "course_type = 'E'";

            dt_elective = dt_all_saved_data.Copy();

            int total_allocated_Seat = 0;

            if (dt_all_elective_data != null)
            {

                DataRow[] dr_zero_seats = dt_all_elective_data.Select("available_seat = '0'");

                if (dr_zero_seats.Length > 0)
                {

                    for (int i = 0; i < dr_zero_seats.Length; i++)
                    {
                        int pri = Convert.ToInt16(dr_zero_seats[i]["priority"]);

                        DataRow[] user_data = dt_elective.Select("course_code = '" + dr_zero_seats[i]["course_code"].ToString() + "' and priority = '" + pri + "'");

                        if (user_data.Length > 0)
                        {
                            for (int j = 0; j < user_data.Length; j++)
                            {

                                for (int l = 1; l < 5; l++)
                                {
                                    DataRow[] dr_not_add = dt_elective.Select("user_id = '" + user_data[j]["user_id"] + "'  and priority ='" + (pri + l) + "'");

                                    if (dr_not_add.Length > 0)
                                    {
                                        dr_not_add[0]["priority"] = (pri + l) - 1;

                                        dt_elective.AcceptChanges();


                                    }
                                }
                            }
                        }
                    }

                }



                string[] priority_array = { "1", "11", "2", "22", "3", "33", "4", "44", "5", "55" };
                //check priority wise Elective Course Allocation
                for (int priority = 0; priority < priority_array.Length; priority++)
                {
                    int pr = Convert.ToInt16(priority_array[priority]);
                    //check one bye one Elective Course Allocation priority wise

                    for (int i = 0; i < dt_all_elective_data.Rows.Count; i++)
                    {

                        string course_code = dt_all_elective_data.Rows[i]["course_code"].ToString();

                        //if (course_code == "W14FA008")
                        //{

                        //}

                        if (dt_all_elective_data.Rows[i]["available_seat"].ToString() != "")
                        {
                            available_seats = Convert.ToInt32(dt_all_elective_data.Rows[i]["available_seat"].ToString());
                        }


                        int seat_for_elective = 0;
                        int total_mandatory_seat = 0;

                        //   DataRow[] dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");

                        DataRow[] dr_elective = null;

                        //if (pr == Convert.ToInt16(dt_all_elective_data.Rows[i]["priority"]))
                        //{
                        //    dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");
                        //}
                        //else
                        //{
                        //    if (pr == 11 || pr == 22 || pr == 33 || pr == 44 || pr == 55)
                        //    {
                        //        dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");
                        //    }
                        //    else
                        //    {

                        //        dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='12'");
                        //    }
                        //}


                        // if (pr == Convert.ToInt16(dt_all_elective_data.Rows[i]["priority"]))
                        // {
                        dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");
                        //  }
                        //else
                        //{
                        //    if (pr == 11 || pr == 22 || pr == 33 || pr == 44 || pr == 55)
                        //    {
                        //        dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='" + pr + "'");
                        //    }
                        //    else
                        //    {

                        //        dr_elective = dt_elective.Select("course_code = '" + course_code + "' and priority='12'");
                        //    }
                        //}

                        DataRow[] dr_total = dt_total_course.Select("course_code = '" + course_code + "'");

                        DataRow[] dr_total_mandatory_seat = dt_total_course.Select("course_code = '" + course_code + "' and course_type = 'E'");

                        if (dr_elective.Length > 0)
                        {

                            if (dr_total.Length > 0)
                            {


                                if (dr_total_mandatory_seat.Length > 0)
                                {
                                    seat_for_elective = available_seats - Convert.ToInt32(dr_total_mandatory_seat[0]["total_course"]);

                                    total_mandatory_seat = Convert.ToInt32(dr_total_mandatory_seat[0]["total_course"]);
                                }
                                else
                                {
                                    seat_for_elective = available_seats;



                                }

                                if (available_seats > 0)
                                {

                                    DataRow[] dr = obj_student.ws_student_course_allocate_dtl.Select("course_code = '" + course_code + "'");

                                    if (dr.Length > 0)
                                    {
                                        total_allocated_Seat = dr.Length;
                                    }
                                    else
                                    {
                                        total_allocated_Seat = 0;
                                    }

                                    if (available_seats > total_allocated_Seat)
                                    {
                                        int open_seat = available_seats - total_allocated_Seat;

                                        if (open_seat >= dr_elective.Length)
                                        {

                                            #region add Course if seat is more than course selection
                                            for (int j = 0; j < dr_elective.Length; j++)
                                            {



                                                #region check credit choice of student with total allocate choice of student
                                                int sum = 0;
                                                int sum1 = 0;
                                                int choice_credit = 0;

                                                //DataRow[] dr_check_choice_credit = dt_choice.Select("student_id = '" + dr_elective[j]["user_id"].ToString() + "'");

                                                //if (dr_check_choice_credit.Length > 0)
                                                //{

                                                //    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                //    {
                                                //        choice_credit = Convert.ToInt32(dr_check_choice_credit[0]["credit_choice"]);
                                                //    }
                                                //    else
                                                //    {
                                                //        choice_credit = 24;
                                                //    }
                                                //}

                                                //else
                                                //{
                                                //    choice_credit = 24;
                                                //}



                                                DataRow[] dr_check_choice_credit = dt_fees_status.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "'");

                                                if (dr_check_choice_credit.Length > 0)
                                                {
                                                    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                    {
                                                        choice_credit = Convert.ToInt16(dr_check_choice_credit[0]["credit_choice"]);
                                                    }
                                                    else
                                                    {
                                                        choice_credit = 8;
                                                    }

                                                }
                                                else
                                                {
                                                    choice_credit = 8;
                                                }



                                                if (dr_elective[j]["user_id"].ToString() == "PA102113")
                                                {

                                                }



                                                DataRow[] dr_total_credit_selection = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "'");

                                                if (dr_total_credit_selection.Length > 0)
                                                {


                                                    for (int n = 0; n < dr_total_credit_selection.Length; n++)
                                                    {
                                                        sum += Convert.ToInt32(dr_total_credit_selection[n]["credits"]);
                                                    }
                                                    sum1 = sum + Convert.ToInt32(dr_elective[j]["credits"]);

                                                    if (sum1 <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {

                                                        continue;

                                                    }
                                                }
                                                else
                                                {
                                                    //add on 12/10/2015 for check single registered course
                                                    if (Convert.ToInt32(dr_elective[j]["credits"]) <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {
                                                        continue;

                                                    }
                                                }
                                                #endregion

                                                # region  check elective course timing conflict

                                                DataRow[] dr_check_timing_elective = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "'");
                                                string flag = "N";
                                                if (dr_check_timing_elective.Length > 0)
                                                {
                                                    if (dt_course_time_day_data != null)
                                                    {
                                                        DataRow[] dr_time_day_data = dt_course_time_day_data.Select(" course_code = '" + dr_elective[j]["course_code"] + "'");

                                                        if (dr_time_day_data.Length > 0)
                                                        {
                                                            for (int m = 0; m < dr_check_timing_elective.Length; m++)
                                                            {
                                                                DataRow[] dr_time_day_data1 = dt_course_time_day_data.Select(" course_code = '" + dr_check_timing_elective[m]["course_code"] + "'");

                                                                if (dr_time_day_data1.Length > 0)
                                                                {
                                                                    for (int a = 0; a < dr_time_day_data1.Length; a++)
                                                                    {
                                                                        DateTime last_from_date = Convert.ToDateTime(dr_time_day_data1[a]["from_date"].ToString());
                                                                        DateTime last_to_date = Convert.ToDateTime(dr_time_day_data1[a]["to_date"].ToString());


                                                                        string last_from_time = dr_time_day_data1[a]["from_time"].ToString();
                                                                        string last_to_time = dr_time_day_data1[a]["to_time"].ToString();
                                                                        string last_day_code = dr_time_day_data1[a]["day_code"].ToString();

                                                                        for (int b = 0; b < dr_time_day_data.Length; b++)
                                                                        {

                                                                            DateTime from_date = Convert.ToDateTime(dr_time_day_data[b]["from_date"].ToString());
                                                                            DateTime to_date = Convert.ToDateTime(dr_time_day_data[b]["to_date"].ToString());

                                                                            string from_time = dr_time_day_data[b]["from_time"].ToString();
                                                                            string to_time = dr_time_day_data[b]["to_time"].ToString();
                                                                            string day_code = dr_time_day_data[b]["day_code"].ToString();


                                                                            Boolean flag1 = false;

                                                                            if (last_from_date.Ticks > from_date.Ticks && last_from_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_to_date.Ticks > from_date.Ticks && last_to_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (from_date.Ticks > last_from_date.Ticks && from_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (to_date.Ticks > last_from_date.Ticks && to_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_from_date.Ticks == from_date.Ticks || last_to_date.Ticks == to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_from_date.Ticks == to_date.Ticks || last_to_date.Ticks == from_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }


                                                                            if (flag1 == true)
                                                                            {

                                                                                flag = "Y";
                                                                                break;

                                                                                //if (last_day_code == day_code)
                                                                                //{
                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_from_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }


                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }



                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) == Convert.ToDecimal(from_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) == Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(from_time.Replace(':', '.')) > Convert.ToDecimal(last_from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }
                                                                                //}
                                                                            }
                                                                        }
                                                                    }
                                                                }

                                                                if (flag == "Y")
                                                                {
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }

                                                }

                                                if (flag == "Y")
                                                {
                                                    continue;
                                                }

                                                #endregion

                                                #region add data in XSD datatable


                                                DataRow[] dr_total_credit_selection_new = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"].ToString() + "' and course_code = '" + dr_elective[j]["course_code"] + "'");

                                                if (dr_total_credit_selection_new.Length == 0)
                                                {
                                                    DataTable dt_WS_Course_dtl_new = objmaster.Get_WS_Course_dtl(current_ws_sem.ToString(), current_ws_year.ToString(), dr_elective[j]["course_code"].ToString());

                                                    re = re + 1;
                                                    Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                                                    course_allocation.doc_no = re.ToString();
                                                    course_allocation.user_id = dr_elective[j]["user_id"].ToString();
                                                    course_allocation.year_code = dr_elective[j]["year_code"].ToString();
                                                    course_allocation.course_code = dr_elective[j]["course_code"].ToString();
                                                    course_allocation.semester_code = dr_elective[j]["semester_code"].ToString();
                                                    course_allocation.current_sem_code = dr_elective[j]["current_sem_code"].ToString();
                                                    course_allocation.course_type = dr_elective[j]["course_type"].ToString();
                                                    course_allocation.credits = dr_elective[j]["credits"].ToString();
                                                    course_allocation.fees = dr_elective[j]["fees"].ToString();
                                                    course_allocation.gpa_nongpa = dt_WS_Course_dtl_new.Rows[0]["gpa_status"].ToString();//"N";
                                                    course_allocation.priority = dr_elective[j]["priority"].ToString();
                                                    course_allocation.dept_code = dr_elective[j]["dept_code"].ToString();
                                                    course_allocation.semester_type = current_ws_sem.ToString();
                                                    course_allocation.year_semester = current_ws_year.ToString();
                                                    course_allocation.cancel_flag = "N";
                                                    course_allocation.round = current_round;
                                                    course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
                                                    course_allocation.created_date = System.DateTime.Now;
                                                    course_allocation.created_host = HttpContext.Current.Request.UserHostName;


                                                    obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(course_allocation);
                                                }
                                                #endregion
                                            }

                                            #region check if course is not assign to student update priority to one
                                            for (int j = 0; j < dr_elective.Length; j++)
                                            {
                                                DataRow[] dr_already_add = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"] + "' and course_code = '" + dr_elective[j]["course_code"] + "'  and priority ='" + pr + "'");

                                                if (dr_already_add.Length > 0)
                                                {

                                                }
                                                else
                                                {
                                                    for (int l = 1; l < 10; l++)
                                                    {
                                                        DataRow[] dr_not_add = dt_elective.Select("user_id = '" + dr_elective[j]["user_id"] + "'  and priority ='" + (pr + l) + "'");

                                                        if (dr_not_add.Length > 0)
                                                        {

                                                            if ((pr + l) - 1 == 1)
                                                            {
                                                                dr_not_add[0]["priority"] = 11;
                                                            }
                                                            else if ((pr + l) - 1 == 2)
                                                            {
                                                                dr_not_add[0]["priority"] = 22;
                                                            }
                                                            else if ((pr + l) - 1 == 3)
                                                            {
                                                                dr_not_add[0]["priority"] = 33;
                                                            }
                                                            else if ((pr + l) - 1 == 4)
                                                            {
                                                                dr_not_add[0]["priority"] = 44;
                                                            }
                                                            else if ((pr + l) - 1 == 5)
                                                            {
                                                                dr_not_add[0]["priority"] = 55;
                                                            }


                                                            dt_elective.AcceptChanges();


                                                        }
                                                    }

                                                }
                                            }
                                            #endregion

                                            #endregion

                                        }
                                        else
                                        {

                                            #region add randomly course allocation if student is more than seats

                                            Random rDom = new Random();
                                            int k = 0;
                                            string old = "";


                                            DataTable dt_random = new DataTable();
                                            dt_random.Columns.Add("random_no");
                                            DataRow row;
                                            int counter = 0;

                                            for (int ctr = 1; ctr <= open_seat; ctr++)
                                            {


                                                # region find randomly data from all data
                                                int choice_credit = 0;
                                                k = rDom.Next(0, dr_elective.Length);




                                                if (counter == dr_elective.Length)
                                                {
                                                    break;
                                                }

                                                if (dt_random.Rows.Count > 0)
                                                {
                                                    DataRow[] dr_random = dt_random.Select("random_no = '" + k + "'");

                                                    if (dr_random.Length > 0)
                                                    {
                                                        ctr = ctr - 1;
                                                        continue;
                                                    }
                                                    else
                                                    {
                                                        counter = counter + 1;
                                                    }
                                                }
                                                else
                                                {
                                                    counter = counter + 1;
                                                }

                                                row = dt_random.NewRow();
                                                row["random_no"] = k.ToString();

                                                dt_random.Rows.Add(row);

                                                #endregion

                                                #region check credit choice of student with total allocate choice of student

                                                int sum = 0;
                                                int sum1 = 0;

                                                //DataRow[] dr_check_choice_credit = dt_choice.Select("student_id = '" + dr_elective[k]["user_id"] + "'");


                                                //if (dr_check_choice_credit.Length > 0)
                                                //{

                                                //    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                //    {
                                                //        choice_credit = Convert.ToInt32(dr_check_choice_credit[0]["credit_choice"]);
                                                //    }
                                                //    else
                                                //    {
                                                //        choice_credit = 24;
                                                //    }
                                                //}
                                                //else
                                                //{
                                                //    choice_credit = 24;
                                                //}

                                                DataRow[] dr_check_choice_credit = dt_fees_status.Select("user_id = '" + dr_elective[k]["user_id"] + "'");


                                                if (dr_check_choice_credit.Length > 0)
                                                {
                                                    if (dr_check_choice_credit[0]["credit_choice"].ToString() != "")
                                                    {
                                                        choice_credit = Convert.ToInt16(dr_check_choice_credit[0]["credit_choice"]);
                                                    }
                                                    else
                                                    {
                                                        choice_credit = 8;
                                                    }

                                                }
                                                else
                                                {
                                                    choice_credit = 8;
                                                }





                                                DataRow[] dr_total_credit_selection = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[k]["user_id"].ToString() + "'");

                                                if (dr_total_credit_selection.Length > 0)
                                                {


                                                    for (int n = 0; n < dr_total_credit_selection.Length; n++)
                                                    {
                                                        sum += Convert.ToInt32(dr_total_credit_selection[n]["credits"]);
                                                    }

                                                    sum1 = sum + Convert.ToInt32(dr_elective[k]["credits"]);

                                                    if (sum1 <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {

                                                        ctr = ctr - 1;
                                                        continue;

                                                    }
                                                }
                                                else
                                                {

                                                    if (Convert.ToInt32(dr_elective[k]["credits"]) <= choice_credit)
                                                    {

                                                    }
                                                    else
                                                    {
                                                        continue;

                                                    }
                                                }
                                                #endregion

                                                # region  check elective course timing conflict

                                                DataRow[] dr_check_timing_elective = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[k]["user_id"].ToString() + "' ");

                                                string flag = "N";

                                                if (dr_check_timing_elective.Length > 0)
                                                {
                                                    if (dt_course_time_day_data != null)
                                                    {
                                                        DataRow[] dr_time_day_data = dt_course_time_day_data.Select(" course_code = '" + dr_elective[k]["course_code"] + "'");

                                                        if (dr_time_day_data.Length > 0)
                                                        {
                                                            for (int m = 0; m < dr_check_timing_elective.Length; m++)
                                                            {
                                                                DataRow[] dr_time_day_data1 = dt_course_time_day_data.Select(" course_code = '" + dr_check_timing_elective[m]["course_code"] + "'");

                                                                if (dr_time_day_data1.Length > 0)
                                                                {
                                                                    for (int a = 0; a < dr_time_day_data1.Length; a++)
                                                                    {

                                                                        DateTime last_from_date = Convert.ToDateTime(dr_time_day_data1[a]["from_date"].ToString());
                                                                        DateTime last_to_date = Convert.ToDateTime(dr_time_day_data1[a]["to_date"].ToString());


                                                                        string last_from_time = dr_time_day_data1[a]["from_time"].ToString();
                                                                        string last_to_time = dr_time_day_data1[a]["to_time"].ToString();
                                                                        string last_day_code = dr_time_day_data1[a]["day_code"].ToString();

                                                                        for (int b = 0; b < dr_time_day_data.Length; b++)
                                                                        {
                                                                            DateTime from_date = Convert.ToDateTime(dr_time_day_data[b]["from_date"].ToString());
                                                                            DateTime to_date = Convert.ToDateTime(dr_time_day_data[b]["to_date"].ToString());

                                                                            string from_time = dr_time_day_data[b]["from_time"].ToString();
                                                                            string to_time = dr_time_day_data[b]["to_time"].ToString();
                                                                            string day_code = dr_time_day_data[b]["day_code"].ToString();

                                                                            Boolean flag1 = false;

                                                                            if (last_from_date.Ticks > from_date.Ticks && last_from_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_to_date.Ticks > from_date.Ticks && last_to_date.Ticks < to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (from_date.Ticks > last_from_date.Ticks && from_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (to_date.Ticks > last_from_date.Ticks && to_date.Ticks < last_to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            else if (last_from_date.Ticks == from_date.Ticks || last_to_date.Ticks == to_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }
                                                                            else if (last_from_date.Ticks == to_date.Ticks || last_to_date.Ticks == from_date.Ticks)
                                                                            {
                                                                                flag1 = true;
                                                                            }

                                                                            if (flag1 == true)
                                                                            {
                                                                                flag = "Y";
                                                                                break;

                                                                                //if (last_day_code == day_code)
                                                                                //{
                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_from_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }


                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) < Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }



                                                                                //    if (Convert.ToDecimal(last_from_time.Replace(':', '.')) == Convert.ToDecimal(from_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(last_to_time.Replace(':', '.')) == Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }

                                                                                //    if (Convert.ToDecimal(from_time.Replace(':', '.')) > Convert.ToDecimal(last_from_time.Replace(':', '.')) && Convert.ToDecimal(last_to_time.Replace(':', '.')) > Convert.ToDecimal(to_time.Replace(':', '.')))
                                                                                //    {
                                                                                //        flag = "Y";
                                                                                //        break;
                                                                                //    }
                                                                                //}
                                                                            }
                                                                        }
                                                                    }
                                                                }

                                                                if (flag == "Y")
                                                                {
                                                                    break;
                                                                }
                                                            }
                                                        }
                                                    }

                                                }

                                                if (flag == "Y")
                                                {
                                                    ctr = ctr - 1;
                                                    continue;
                                                }

                                                #endregion

                                                #region add finel data in  XSD datatable

                                                DataRow[] dr_total_credit_selection_new1 = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[k]["user_id"].ToString() + "' and course_code = '" + dr_elective[k]["course_code"] + "'");

                                                if (dr_total_credit_selection_new1.Length == 0)
                                                {
                                                    DataTable dt_WS_Course_dtl_new = objmaster.Get_WS_Course_dtl(current_ws_sem.ToString(), current_ws_year.ToString(), dr_elective[k]["course_code"].ToString());

                                                    re = re + 1;

                                                    Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                                                    course_allocation.doc_no = re.ToString();
                                                    course_allocation.user_id = dr_elective[k]["user_id"].ToString();
                                                    course_allocation.year_code = dr_elective[k]["year_code"].ToString();
                                                    course_allocation.course_code = dr_elective[k]["course_code"].ToString();
                                                    course_allocation.semester_code = dr_elective[k]["semester_code"].ToString();
                                                    course_allocation.current_sem_code = dr_elective[k]["current_sem_code"].ToString();
                                                    course_allocation.course_type = dr_elective[k]["course_type"].ToString();
                                                    course_allocation.credits = dr_elective[k]["credits"].ToString();
                                                    course_allocation.fees = dr_elective[k]["fees"].ToString();
                                                    course_allocation.gpa_nongpa = dt_WS_Course_dtl_new.Rows[0]["gpa_status"].ToString();//"N";
                                                    course_allocation.priority = dr_elective[k]["priority"].ToString();
                                                    course_allocation.dept_code = dr_elective[k]["dept_code"].ToString();
                                                    course_allocation.semester_type = current_ws_sem.ToString();
                                                    course_allocation.year_semester = current_ws_year.ToString();
                                                    course_allocation.cancel_flag = "N";
                                                    course_allocation.round = current_round;
                                                    course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
                                                    course_allocation.created_date = System.DateTime.Now;
                                                    course_allocation.created_host = HttpContext.Current.Request.UserHostName;


                                                    obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(course_allocation);
                                                }
                                                #endregion

                                            }

                                            #region  check if course is not assign to student by randomly update priority to one
                                            for (int j = 0; j < dr_elective.Length; j++)
                                            {
                                                DataRow[] dr_already_add = obj_student.ws_student_course_allocate_dtl.Select("user_id = '" + dr_elective[j]["user_id"] + "' and course_code = '" + dr_elective[j]["course_code"] + "' and  priority ='" + pr + "'");

                                                if (dr_already_add.Length > 0)
                                                {

                                                }
                                                else
                                                {
                                                    for (int l = 1; l < 10; l++)
                                                    {
                                                        DataRow[] dr_not_add = dt_elective.Select("user_id = '" + dr_elective[j]["user_id"] + "'  and priority ='" + (pr + l) + "'");

                                                        if (dr_not_add.Length > 0)
                                                        {

                                                            if ((pr + l) - 1 == 1)
                                                            {
                                                                dr_not_add[0]["priority"] = 11;
                                                            }
                                                            else if ((pr + l) - 1 == 2)
                                                            {
                                                                dr_not_add[0]["priority"] = 22;
                                                            }
                                                            else if ((pr + l) - 1 == 3)
                                                            {
                                                                dr_not_add[0]["priority"] = 33;
                                                            }
                                                            else if ((pr + l) - 1 == 4)
                                                            {
                                                                dr_not_add[0]["priority"] = 44;
                                                            }
                                                            else if ((pr + l) - 1 == 5)
                                                            {
                                                                dr_not_add[0]["priority"] = 55;
                                                            }


                                                            dt_elective.AcceptChanges();


                                                        }
                                                    }

                                                }
                                            }

                                            #endregion


                                            #endregion

                                        }
                                    }
                                }



                            }
                        }



                    }
                }
            }
            #endregion


            //for (int i = 0; i < obj_student.ws_student_course_allocate_dtl.Rows.Count; i++)
            //{

            //}

            //objBLReturnObject = objmaster.Save_assign_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Request.UserHostName);

            objBLReturnObject = objmaster.Save_ws_assign_course_dtl(obj_student, HttpContext.Current.Session["UserId"].ToString(), "", HttpContext.Current.Request.UserHostName, current_ws_sem.ToString(), current_ws_year.ToString());
        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    //private void check_rendom(string values, int random, int count)
    //{
    //    for (int l = 0; l < values.Split(',').Length; l++)
    //    {
    //        if (Convert.ToInt32(values.Split(',')[l]) == random)
    //        {
    //            //k = rDom.Next(0, dr_elective.Length);
    //            check_rendom(values, new Random().Next(0, count), count);
    //        }
    //    }
    //}

    [WebMethod(EnableSession = true)]
    public string save_choice_credit_for_student(string creadit_choice)
    {
        // Save Compliance Details in compliance_entry table.




        try
        {



            DataTable dt_check = objmaster.check_allocation_completed_for_student(HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["year_code"].ToString(), HttpContext.Current.Session["UserId"].ToString());

            if (dt_check != null)
            {
                return "allocate";
            }


            DataTable dt = objmaster.check_credit_choice_by_student(HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Session["year_code"].ToString(), HttpContext.Current.Session["UserId"].ToString(), "");

            if (dt != null)
            {

                Ds_Student_Course_detail_WS.student_current_sem_dtlRow save_credit_choice = obj_student.student_current_sem_dtl.Newstudent_current_sem_dtlRow();

                save_credit_choice.doc_no = dt.Rows[0]["doc_no"].ToString();
                save_credit_choice.student_id = dt.Rows[0]["student_id"].ToString();
                save_credit_choice.student_code = dt.Rows[0]["student_code"].ToString();
                save_credit_choice.parent_sem_code = dt.Rows[0]["parent_sem_code"].ToString();
                save_credit_choice.dept_code = dt.Rows[0]["dept_code"].ToString();
                save_credit_choice.semester_code = dt.Rows[0]["semester_code"].ToString();
                save_credit_choice.year_code = dt.Rows[0]["year_code"].ToString();
                save_credit_choice.credit_choice = creadit_choice;
                save_credit_choice.active_flag = "Y";
                save_credit_choice.cancel_flag = "N";
                save_credit_choice.created_by = dt.Rows[0]["created_by"].ToString();

                if (dt.Rows[0]["created_date"].ToString() != "")
                {
                    save_credit_choice.created_date = Convert.ToDateTime(dt.Rows[0]["created_date"].ToString());
                }




                save_credit_choice.created_host = dt.Rows[0]["created_host"].ToString();

                save_credit_choice.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                save_credit_choice.last_modified_date = System.DateTime.Now;
                save_credit_choice.last_modified_host = HttpContext.Current.Request.UserHostName;


                obj_student.student_current_sem_dtl.Addstudent_current_sem_dtlRow(save_credit_choice);


                objBLReturnObject = objmaster.save_choice_credit_for_student(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString(), HttpContext.Current.Request.UserHostName);
            }
            else
            {

                return "There is no current semester detail found.";
            }







        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_credit_choice(string credit_choice)
    {
        // Save Compliance Details in compliance_entry table.


        int re = 0;

        if (re == 0)
        {
            return "Registration has been closed for Summer 2015.";
        }

        try
        {

            //if (current_round != "1")
            //{
            //    if (current_round != "")
            //    {
            //        DataTable dt1 = objmaster.get_student_for_next_round_registration(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString(), current_round);

            //        if (dt1 != null)
            //        {
            //            if (dt1.Rows[0]["user_id"].ToString() == HttpContext.Current.Session["UserId"].ToString())
            //            {
            //                re = 1;
            //            }
            //        }
            //    }
            //}
            //else
            //{

            //    if (HttpContext.Current.Session["dept_code"].ToString() == "7")
            //    {
            //        re = 1;
            //    }

            //    if (HttpContext.Current.Session["dept_code"].ToString() == "1" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
            //    {
            //        re = 1;
            //    }

            //    if (HttpContext.Current.Session["dept_code"].ToString() == "2" && HttpContext.Current.Session["prog_code"].ToString() == "1" && HttpContext.Current.Session["year_code"].ToString() == "Y2015")
            //    {
            //        re = 1;
            //    }
            //}

            if (re == 0)
            {
                return "Registration has been closed for Summer 2016.";
            }

            DataTable dt_fees_check = objmaster.Get_fees_status_for_student(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

            if (dt_fees_check != null)
            {
                if (dt_fees_check.Rows[0]["fees_status"].ToString() == "Y")
                {
                    return "You have already paid your fees.you can not change your choice of credits";
                }
            }

            if (Convert.ToDecimal(credit_choice) > 8)
            {
                return "You Can Save Maximum 8 choice of credit";
            }

            DataTable dt_check = objmaster.check_ws_allocation_completed_for_student(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString());

            if (dt_check != null)
            {
                return "completed";
            }

            DataTable dt = objmaster.check_ws_credit_choice_by_student(current_ws_sem, current_ws_year, HttpContext.Current.Session["UserId"].ToString());

            Ds_Student_Course_detail_WS.ws_credit_choiceRow save_credit_choice = obj_student.ws_credit_choice.Newws_credit_choiceRow();

            if (dt != null)
            {

                save_credit_choice.doc_no = dt.Rows[0]["doc_no"].ToString();
                save_credit_choice.user_id = dt.Rows[0]["user_id"].ToString();

                save_credit_choice.credit_choice = credit_choice;

                save_credit_choice.cancel_flag = "N";
                save_credit_choice.created_by = dt.Rows[0]["created_by"].ToString();

                if (dt.Rows[0]["created_date"].ToString() != "")
                {
                    save_credit_choice.created_date = Convert.ToDateTime(dt.Rows[0]["created_date"].ToString());
                }

                save_credit_choice.semester_type = dt.Rows[0]["semester_type"].ToString();
                save_credit_choice.year_semester = dt.Rows[0]["year_semester"].ToString();

                save_credit_choice.created_host = dt.Rows[0]["created_host"].ToString();

                save_credit_choice.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                save_credit_choice.last_modified_date = System.DateTime.Now;
                save_credit_choice.last_modified_host = HttpContext.Current.Request.UserHostName;

                obj_student.ws_credit_choice.Addws_credit_choiceRow(save_credit_choice);
            }
            else
            {

                save_credit_choice.doc_no = "1";
                save_credit_choice.user_id = HttpContext.Current.Session["UserId"].ToString();

                save_credit_choice.credit_choice = credit_choice;

                save_credit_choice.cancel_flag = "N";
                save_credit_choice.semester_type = current_ws_sem.ToString();
                save_credit_choice.year_semester = current_ws_year.ToString();

                save_credit_choice.created_by = HttpContext.Current.Session["UserId"].ToString();
                save_credit_choice.created_date = System.DateTime.Now;
                save_credit_choice.created_host = HttpContext.Current.Request.UserHostName;


                obj_student.ws_credit_choice.Addws_credit_choiceRow(save_credit_choice);
            }




            objBLReturnObject = objmaster.save_ws_choice_credit_for_student(obj_student, HttpContext.Current.Session["UserId"].ToString(), "", HttpContext.Current.Request.UserHostName);


        }
        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string Save_change_allocation_data(string course_data, string flag)
    {
        // Save Compliance Details in compliance_entry table.


        int re = 0;
        string sem_code = "";
        try
        {



            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(course_data);

            DataTable get_student_data = objmaster.get_student_course_dtl_data(HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Session["semester_code"].ToString());

            if (get_student_data != null)
            {
                if (data.Count > 0)
                {
                    //get_student_data.Select("");
                    for (int i = 0; i < get_student_data.Rows.Count; i++)
                    {
                        Ds_Student_Course_detail_WS.student_wise_course_dtlRow student_wise_course = obj_student.student_wise_course_dtl.Newstudent_wise_course_dtlRow();

                        student_wise_course.doc_no = get_student_data.Rows[i]["doc_no"].ToString();
                        student_wise_course.user_id = get_student_data.Rows[i]["user_id"].ToString();
                        student_wise_course.year_code = get_student_data.Rows[i]["year_code"].ToString();
                        student_wise_course.course_code = get_student_data.Rows[i]["course_code"].ToString();
                        student_wise_course.semester_code = get_student_data.Rows[i]["semester_code"].ToString();
                        student_wise_course.current_sem_code = get_student_data.Rows[i]["current_sem_code"].ToString();
                        student_wise_course.course_type = get_student_data.Rows[i]["course_type"].ToString();
                        student_wise_course.credits = get_student_data.Rows[i]["credits"].ToString();
                        student_wise_course.dept_code = get_student_data.Rows[i]["dept_code"].ToString();
                        student_wise_course.priority = get_student_data.Rows[i]["priority"].ToString();
                        student_wise_course.status = get_student_data.Rows[i]["status"].ToString();
                        student_wise_course.semester_type = get_student_data.Rows[i]["semester_type"].ToString();
                        student_wise_course.year_semester = get_student_data.Rows[i]["year_semester"].ToString();
                        student_wise_course.created_by = get_student_data.Rows[i]["created_by"].ToString();
                        student_wise_course.created_date = Convert.ToDateTime(get_student_data.Rows[i]["created_date"]);
                        student_wise_course.created_host = get_student_data.Rows[i]["created_host"].ToString();

                        student_wise_course.gpa_nongpa = get_student_data.Rows[i]["gpa_nongpa"].ToString();
                        student_wise_course.cancel_flag = get_student_data.Rows[i]["cancel_flag"].ToString();

                        student_wise_course.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                        student_wise_course.last_modified_date = System.DateTime.Now;
                        student_wise_course.last_modified_host = HttpContext.Current.Request.UserHostName;


                        for (int j = 0; j < data.Count; j++)
                        {
                            if (data[j]["course_code"].ToString() == get_student_data.Rows[i]["course_code"].ToString())
                            {
                                if (flag == "C")
                                {
                                    //student_wise_course.cancel_flag = data[j]["cancel_flag"].ToString();
                                }
                                else
                                {
                                    student_wise_course.gpa_nongpa = data[j]["gpa_nongpa"].ToString();
                                }

                            }
                        }

                        obj_student.student_wise_course_dtl.Addstudent_wise_course_dtlRow(student_wise_course);
                    }
                }

            }

            DataTable get_assigned_data = objmaster.get_student_course_allocate_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);
            if (get_assigned_data != null)
            {
                if (data.Count > 0)
                {
                    //get_student_data.Select("");
                    for (int i = 0; i < get_assigned_data.Rows.Count; i++)
                    {
                        Ds_Student_Course_detail_WS.student_course_allocate_dtlRow student_course_allocation = obj_student.student_course_allocate_dtl.Newstudent_course_allocate_dtlRow();

                        student_course_allocation.doc_no = get_assigned_data.Rows[i]["doc_no"].ToString();
                        student_course_allocation.user_id = get_assigned_data.Rows[i]["user_id"].ToString();
                        student_course_allocation.year_code = get_assigned_data.Rows[i]["year_code"].ToString();
                        student_course_allocation.course_code = get_assigned_data.Rows[i]["course_code"].ToString();
                        student_course_allocation.semester_code = get_assigned_data.Rows[i]["semester_code"].ToString();
                        student_course_allocation.current_sem_code = get_assigned_data.Rows[i]["current_sem_code"].ToString();
                        student_course_allocation.course_type = get_assigned_data.Rows[i]["course_type"].ToString();
                        student_course_allocation.credits = get_assigned_data.Rows[i]["credits"].ToString();
                        student_course_allocation.dept_code = get_assigned_data.Rows[i]["dept_code"].ToString();
                        student_course_allocation.priority = get_assigned_data.Rows[i]["priority"].ToString();
                        //    student_course_allocation.status = get_assigned_data.Rows[i]["status"].ToString();
                        student_course_allocation.semester_type = get_assigned_data.Rows[i]["semester_type"].ToString();
                        student_course_allocation.year_semester = get_assigned_data.Rows[i]["year_semester"].ToString();
                        student_course_allocation.created_by = get_assigned_data.Rows[i]["created_by"].ToString();
                        student_course_allocation.created_date = Convert.ToDateTime(get_assigned_data.Rows[i]["created_date"]);
                        student_course_allocation.created_host = get_assigned_data.Rows[i]["created_host"].ToString();

                        student_course_allocation.cancel_flag = get_assigned_data.Rows[i]["cancel_flag"].ToString();
                        student_course_allocation.gpa_nongpa = get_assigned_data.Rows[i]["gpa_nongpa"].ToString();

                        student_course_allocation.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                        student_course_allocation.last_modified_date = System.DateTime.Now;
                        student_course_allocation.last_modified_host = HttpContext.Current.Request.UserHostName;

                        for (int j = 0; j < data.Count; j++)
                        {
                            if (data[j]["doc_no"].ToString() == get_assigned_data.Rows[i]["doc_no"].ToString() && data[j]["course_code"].ToString() == get_assigned_data.Rows[i]["course_code"].ToString())
                            {
                                if (flag == "C")
                                {
                                    student_course_allocation.cancel_flag = data[j]["cancel_flag"].ToString();
                                }
                                else
                                {
                                    student_course_allocation.gpa_nongpa = data[j]["gpa_nongpa"].ToString();

                                }

                            }
                        }

                        obj_student.student_course_allocate_dtl.Addstudent_course_allocate_dtlRow(student_course_allocation);
                    }
                }
            }



            objBLReturnObject = objmaster.save_change_data_after_allocation(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);

            if (objBLReturnObject.ExecutionStatus == 2)
            {
                objBLReturnObject.ServerMessage = "Problem in update data " + objBLReturnObject.ServerMessage;
            }






        }
        catch (Exception ex)
        {
            return "Problem in update DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string save_reset_password(string reset_password)
    {
        EncryptPassword encrpt = new EncryptPassword();



        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(reset_password);

            string password = encoding_decoding.encryptPassword("admin");

            string department = data[0]["dept_code"].ToString();

            string year_code = data[0]["year_code"].ToString();

            DataTable dt = objmaster.Get_student_data(year_code, department);




            for (int i = 0; i < data.Count; i++)
            {


                DataTable dt_new = dt.Clone();
                DSC_userdataupload_WS.user_mstRow user_row = obj_userdataupload.user_mst.Newuser_mstRow();



                DataRow[] dr = dt.Select("user_id = '" + data[i]["user_id"].ToString() + "'");

                if (dr.Length > 0)
                {

                    user_row.doc_no = dr[0]["doc_no"].ToString();
                    user_row.user_id = dr[0]["user_id"].ToString();
                    user_row.user_name = dr[0]["user_name"].ToString();

                    user_row.student_no = dr[0]["student_no"].ToString();
                    user_row.user_type = dr[0]["user_type"].ToString();



                    //  user_row.enrollment_no = user_mst.Rows[i]["Enrollment No"].ToString().Trim();

                    user_row.enrollment_no = dr[0]["enrollment_no"].ToString();


                    user_row.dept_code = dr[0]["dept_code"].ToString();



                    user_row.year_code = dr[0]["year_code"].ToString();



                    user_row.prog_code = dr[0]["prog_code"].ToString();

                    user_row.password = password.ToString();

                    user_row.first_name = dr[0]["first_name"].ToString();
                    user_row.middle_name = dr[0]["middle_name"].ToString();
                    user_row.last_name = dr[0]["last_name"].ToString();
                    user_row.full_name = dr[0]["full_name"].ToString();
                    user_row.mail = dr[0]["mail"].ToString();
                    user_row.gender = dr[0]["gender"].ToString();
                    user_row.address = dr[0]["address"].ToString();
                    user_row.start_date = Convert.ToDateTime(dr[0]["start_date"]);
                    //    user_row.end_date = Convert.ToDateTime(user_mst.Rows[i]["End Date"].ToString().Trim());

                    DateTime date = Convert.ToDateTime(dr[0]["start_date"]);

                    DateTime pass_exp_date = date.AddYears(8);

                    user_row.pass_expiry_date = pass_exp_date;
                    user_row.user_status_flag = "A";
                    user_row.state = "A";
                    user_row.city = dr[0]["city"].ToString();
                    user_row.state = dr[0]["state"].ToString();
                    user_row.country = dr[0]["country"].ToString();
                    if (dr[0]["dob"].ToString() != "")
                    {
                        user_row.dob = Convert.ToDateTime(dr[0]["dob"]);
                    }


                    user_row.phone_no = dr[0]["phone_no"].ToString();
                    user_row.mobile_no = dr[0]["mobile_no"].ToString();
                    //    user_row.last_login_date = ;
                    user_row.cancel_flag = "N";

                    if (dr[0]["last_login_date"].ToString() != "")
                    {
                        user_row.last_login_date = Convert.ToDateTime(dr[0]["last_login_date"]);
                    }

                    if (dr[0]["created_by"].ToString() != "")
                    {
                        user_row.created_by = dr[0]["created_by"].ToString();
                    }

                    if (dr[0]["created_date"].ToString() != "")
                    {
                        user_row.created_date = Convert.ToDateTime(dr[0]["created_date"]);
                    }

                    user_row.cancel_flag = dr[0]["cancel_flag"].ToString();
                    user_row.created_host = dr[0]["created_host"].ToString();

                    user_row.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                    user_row.last_midified_date = System.DateTime.Now;
                    user_row.last_modified_host = HttpContext.Current.Request.UserHostName; ;

                    obj_userdataupload.user_mst.Adduser_mstRow(user_row);


                }
                else
                {


                }

            }


            objBLReturnObject = objmaster.save_rest_password(obj_userdataupload, "2000", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);


        }
        catch (Exception ex)
        {

            return "Problem in Save DATA.";
        }


        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string send_multiple_email(string email, string subject, string body)
    {
        EncryptPassword encrpt = new EncryptPassword();

        string msg = "";

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(email);


            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();

            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            string host = ConfigurationSettings.AppSettings["host"].ToString();

            int port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"].ToString());




            for (int i = 0; i < data.Count; i++)
            {

                try
                {
                    SmtpClient SmtpServer = new SmtpClient();

                    SmtpServer.Credentials = new System.Net.NetworkCredential(sending_email, sending_password);

                    SmtpServer.Port = port;
                    SmtpServer.Host = host;
                    SmtpServer.EnableSsl = true;
                    MailMessage mail = new MailMessage();

                    string TomailIds = data[i]["email_id"].ToString();

                    mail.From = new MailAddress(sending_email, sending_email, System.Text.Encoding.UTF8);


                    mail.To.Add(TomailIds);
                    mail.Subject = subject;
                    mail.Body = body;
                    mail.IsBodyHtml = true;

                    SmtpServer.Send(mail);


                }
                catch (Exception ex)
                {
                    msg += data[i]["user_id"].ToString() + ',';
                    continue;
                }


            }




            //   objBLReturnObject = objmaster.excel_data_uplad(obj_userdataupload, "2000", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);


        }
        catch (Exception ex)
        {

            return "Problem in Save DATA.";
        }

        if (msg != "")
        {
            msg = "Problem in sending mail for this user: " + msg.Substring(0, msg.Length - 1);
        }
        else
        {
            msg = "All mail send successfully";
        }


        return msg;

    }

    [WebMethod(EnableSession = true)]
    public string Save_transaction_details(string transactionId, string payment_ref_no, string citrus_ref_no, string auth_code)
    {
        DataTable dtTranDetail = objmaster.GetTransactionDetails(transactionId);

        if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
        {
            try
            {
                DS_Payment_WS obDS_Payment = new DS_Payment_WS();

                obDS_Payment.EnforceConstraints = false;
                DataRow TranRow = dtTranDetail.Rows[0];
                //string program_course_id = TranRow["program_course_id"].ToString();

                TranRow["payment_return_flag"] = "Y";
                TranRow["payment_response_code"] = "0";
                TranRow["payment_response_msg"] = "Transaction Successful";
                TranRow["payment_transaction_reference_id"] = payment_ref_no;
                TranRow["payment_authorization_code"] = auth_code;
                //TranRow["Citrus_PaymentMode"] = Request["paymentMode"];
                TranRow["Citrus_TxRefNo"] = citrus_ref_no;
                //TranRow["Citrus_TxGateway"] = Request["TxGateway"];
                //TranRow["Citrus_IssuerRefNo"] = Request["issuerCode"];
                TranRow["Citrus_TxStatus"] = "SUCCESS";
                TranRow["status_is_payment_received"] = "Y";
                TranRow["last_modified_date"] = DateTime.Now;
                TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                obDS_Payment.ws_applicationpaymenttransaction.ImportRow(TranRow);

                DS_Payment_WS.user_activity_logRow activity_row = obDS_Payment.user_activity_log.Newuser_activity_logRow();
                //HttpContext.Current.Request.UserHostName
                activity_row.activity_user = HttpContext.Current.Session["UserId"].ToString();
                activity_row.to_user = TranRow["user_id"].ToString();
                activity_row.activity_text = "Add online transaction details";
                activity_row.ref_no = transactionId;
                activity_row.screen_name = "Generate Online Application";
                activity_row.created_date = DateTime.Now;
                activity_row.created_host = HttpContext.Current.Request.UserHostName;

                obDS_Payment.user_activity_log.Adduser_activity_logRow(activity_row);

                objBLReturnObject = objMaster.Save_manually_Online_transaction_data(obDS_Payment, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
            }
            catch (Exception ex)
            {
                return ex.ToString();
            }
        }
        else
        {
            return "No data found for this Transaction Id";
        }

        return objBLReturnObject.ServerMessage;
    }

    [WebMethod(EnableSession = true)]
    public string save_course_allocation_agree_or_not(string course_data)
    {
        // Save Compliance Details in compliance_entry table.


        // Boolean status;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(course_data);



            DataTable get_assigned_data = objmaster.get_student_course_allocate_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);


            if (data.Count > 0)
            {
                //get_student_data.Select("");



                for (int j = 0; j < data.Count; j++)
                {


                    if (get_assigned_data != null)
                    {
                        DataRow[] dr = get_assigned_data.Select(" course_code = '" + data[j]["course_code"].ToString() + "' ");

                        if (dr.Length > 0)
                        {
                            DataRow Transrow = dr[0];

                            Transrow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString() + "-from popup";
                            Transrow["last_modified_date"] = System.DateTime.Now;
                            Transrow["last_modified_host"] = HttpContext.Current.Request.UserHostName;
                            Transrow["cancel_flag"] = data[j]["cancel_flag"].ToString();
                            Transrow["semester_code"] = "from popup";

                            obj_student.ws_student_course_allocate_dtl.ImportRow(Transrow);
                        }

                    }
                }


            }

            objBLReturnObject = objmaster.save_change_data_after_allocation(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);

            if (objBLReturnObject.ExecutionStatus == 2)
            {
                objBLReturnObject.ServerMessage = "Problem in update data : " + objBLReturnObject.ServerMessage;
            }
            else
            {

                objmaster.insert_allocation_agree_or_not_data("Y", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, current_ws_sem, current_ws_year);
            }

        }


        catch (Exception ex)
        {
            return "Problem in Save DATA.";
        }
        return objBLReturnObject.ServerMessage;

    }

    public string getdate(string date)
    {

        if (date != "")
        {
            String dst21 = date.ToString();

            string[] sdg21 = dst21.ToString().Split('/');
            string gh21 = sdg21[2].ToString() + "/" + sdg21[1].ToString() + "/" + sdg21[0].ToString();

            DateTime expiryto = Convert.ToDateTime(gh21);
            string expiry2 = expiryto.ToString();

            return expiry2;
        }
        else
        {
            return "";
        }




    }

    #endregion

    #region SWS Student Allocation

    [WebMethod(EnableSession = true)]
    public string Get_course_wise_allocation_dtl(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.Get_course_wise_allocation_dtl(sem_code, year_code);


        string code = "";

        if (get_data != null)
        {


            for (int i = 0; i < get_data.Rows.Count; i++)
            {

                String course_code = get_data.Rows[i]["course_code"].ToString();



                Ds_Student_Course_detail_WS.total_course_selected_reportRow total_report = obj_student.total_course_selected_report.Newtotal_course_selected_reportRow();

                DataRow[] dr = get_data.Select("course_code = '" + course_code + "'");

                if (code != course_code)
                {



                    if (dr.Length > 0)
                    {
                        total_report.course_code = course_code;
                        total_report.course_name = dr[0]["course_name"].ToString();
                        total_report.available_seat = dr[0]["available_seat"].ToString();
                        total_report.dept_name = dr[0]["dept_name"].ToString();
                        if (dr.Length == 1)
                        {


                            if (dr[0]["course_type"].ToString().Trim() == "M")
                            {
                                total_report.mandatory = dr[0]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.elective = dr[0]["total_course"].ToString();
                            }

                        }
                        else if (dr.Length == 2)
                        {
                            if (dr[0]["course_type"].ToString().Trim() == "M")
                            {
                                total_report.mandatory = dr[0]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.elective = dr[0]["total_course"].ToString();
                            }

                            if (dr[1]["course_type"] == "E")
                            {
                                total_report.elective = dr[1]["total_course"].ToString();

                            }
                            else
                            {
                                total_report.mandatory = dr[1]["total_course"].ToString();
                            }
                        }
                        total_report.final_allocation_status = dr[0]["final_allocation_status"].ToString();
                        total_report.allocated_user_id = dr[0]["allocated_user_id"].ToString();
                        total_report.registered_students = dr[0]["registered_students"].ToString();

                    }


                    code = course_code;
                    obj_student.total_course_selected_report.Addtotal_course_selected_reportRow(total_report);
                }

            }


            DataTable dt = obj_student.total_course_selected_report;

            if (dt != null)
            {
                jsondata = GetJson1(dt);
            }
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string Get_course_cancel_dtl(string sem_code, string year_code)
    {
        DataTable get_data = objmaster.Get_course_cancel_dtl(sem_code, year_code);

        if (get_data != null)
        {
           jsondata = GetJson1(get_data);
        }

        return jsondata;
    }


    [WebMethod(EnableSession = true)]
    public string SWS_Course_allocation(string course_code, string sem_code, string year)
    {
        //Save Compliance Details in compliance_entry table.

        int re = 0;

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            List<Dictionary<string, object>> data = ser.Deserialize<List<Dictionary<string, object>>>(course_code);

            for (int i = 0; i < data.Count; i++)
            {
                DataTable get_student_data = objmaster.get_ws_student_course_dtl_data(sem_code, year, data[i]["course_code"].ToString());
                if (get_student_data != null)
                {
                    for (int k = 0; k < get_student_data.Rows.Count; k++)
                    {
                        re = i + 1;

                        Ds_Student_Course_detail_WS.ws_student_wise_course_dtlRow student_wise_course = obj_student.ws_student_wise_course_dtl.Newws_student_wise_course_dtlRow();

                        student_wise_course.doc_no = get_student_data.Rows[k]["doc_no"].ToString();
                        student_wise_course.user_id = get_student_data.Rows[k]["user_id"].ToString();
                        student_wise_course.year_code = get_student_data.Rows[k]["year_code"].ToString();
                        student_wise_course.course_code = get_student_data.Rows[k]["course_code"].ToString();
                        student_wise_course.semester_code = get_student_data.Rows[k]["semester_code"].ToString();
                        student_wise_course.current_sem_code = get_student_data.Rows[k]["current_sem_code"].ToString();

                        student_wise_course.course_type = get_student_data.Rows[k]["course_type"].ToString();
                        student_wise_course.gpa_nongpa = get_student_data.Rows[k]["gpa_nongpa"].ToString();

                        student_wise_course.credits = get_student_data.Rows[k]["credits"].ToString();
                        student_wise_course.dept_code = get_student_data.Rows[k]["dept_code"].ToString();
                        student_wise_course.fees = get_student_data.Rows[k]["fees"].ToString();
                        student_wise_course.priority = get_student_data.Rows[k]["priority"].ToString();
                        //student_wise_course.status = dr[i]["status"].ToString();
                        student_wise_course.semester_type = get_student_data.Rows[k]["semester_type"].ToString();
                        student_wise_course.year_semester = get_student_data.Rows[k]["year_semester"].ToString();
                        student_wise_course.round = get_student_data.Rows[k]["round"].ToString();
                        student_wise_course.created_by = get_student_data.Rows[k]["created_by"].ToString();
                        student_wise_course.created_date = Convert.ToDateTime(get_student_data.Rows[k]["created_date"]);
                        student_wise_course.created_host = get_student_data.Rows[k]["created_host"].ToString();
                        student_wise_course.cancel_flag = get_student_data.Rows[k]["cancel_flag"].ToString();
                        student_wise_course.status = "A";

                        student_wise_course.course_number = get_student_data.Rows[k]["course_number"].ToString();
                        student_wise_course.is_cancel = get_student_data.Rows[k]["is_cancel"].ToString();

                        student_wise_course.last_modified_by = HttpContext.Current.Session["UserId"].ToString();
                        student_wise_course.last_modified_date = System.DateTime.Now;
                        student_wise_course.last_modified_host = HttpContext.Current.Request.UserHostName;

                        obj_student.ws_student_wise_course_dtl.Addws_student_wise_course_dtlRow(student_wise_course);

                        Ds_Student_Course_detail_WS.ws_student_course_allocate_dtlRow student_course_allocation = obj_student.ws_student_course_allocate_dtl.Newws_student_course_allocate_dtlRow();

                        student_course_allocation.doc_no = re.ToString();
                        student_course_allocation.user_id = get_student_data.Rows[k]["user_id"].ToString();
                        student_course_allocation.year_code = get_student_data.Rows[k]["year_code"].ToString();
                        student_course_allocation.course_code = get_student_data.Rows[k]["course_code"].ToString();
                        student_course_allocation.semester_code = get_student_data.Rows[k]["semester_code"].ToString();
                        student_course_allocation.current_sem_code = get_student_data.Rows[k]["current_sem_code"].ToString();

                        student_course_allocation.course_type = get_student_data.Rows[k]["course_type"].ToString();
                        student_course_allocation.gpa_nongpa = get_student_data.Rows[k]["gpa_nongpa"].ToString();

                        student_course_allocation.credits = get_student_data.Rows[k]["credits"].ToString();
                        student_course_allocation.dept_code = get_student_data.Rows[k]["dept_code"].ToString();
                        student_course_allocation.fees = get_student_data.Rows[k]["fees"].ToString();
                        student_course_allocation.priority = get_student_data.Rows[k]["priority"].ToString();
                        student_course_allocation.semester_type = get_student_data.Rows[k]["semester_type"].ToString();
                        student_course_allocation.year_semester = get_student_data.Rows[k]["year_semester"].ToString();
                        student_course_allocation.round = get_student_data.Rows[k]["round"].ToString();
                        student_course_allocation.created_by = HttpContext.Current.Session["UserId"].ToString();
                        student_course_allocation.created_date = System.DateTime.Now;
                        student_course_allocation.created_host = HttpContext.Current.Request.UserHostName;
                        student_course_allocation.cancel_flag = get_student_data.Rows[k]["cancel_flag"].ToString();

                        obj_student.ws_student_course_allocate_dtl.Addws_student_course_allocate_dtlRow(student_course_allocation);
                    }
                }
            }

            objBLReturnObject = objmaster.save_ws_change_data_before_allocation(obj_student, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);

            if (objBLReturnObject.ExecutionStatus == 2)
            {
                objBLReturnObject.ServerMessage = "Problem in update data " + objBLReturnObject.ServerMessage;
            }
        }
        catch (Exception ex)
        {
            return ex.ToString();
        }

        return objBLReturnObject.ServerMessage;
    }

    #endregion


    #region Upload Manually payslip

    [WebMethod(EnableSession = true)]
    public string[] check_manually_payslip_submit()
    {
        DataTable dt_user_upload_data = objmaster.get_user_upload_payslip_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);


        if (dt_user_upload_data != null)
        {
            jsonarray[0] = "Y";
        }

        DataTable dt_bank_branch_dtl = objmaster.get_bank_branch_dtl();

        if (dt_bank_branch_dtl != null)
        {
            jsonarray[1] = GetJson1(dt_bank_branch_dtl);


        }

        return jsonarray;
    }

    [WebMethod(EnableSession = true)]
    public string save_upload_manually_payslip_dtl(string manually_data)
    {
        // Save Compliance Details in compliance_entry table.

        int re = 0;

        try
        {

            DataTable dt_user_upload_data = objmaster.get_user_upload_payslip_data(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

            if (dt_user_upload_data != null)
            {
                return "you can not upload manually payslip.you are already submit your data.";
            }

            DataTable dt_fees_status_check = objmaster.Get_fees_status_for_student_for_fees_payment(HttpContext.Current.Session["UserId"].ToString(), current_ws_sem, current_ws_year);

            if (dt_fees_status_check != null)
            {
                return "you can not upload manually payslip your fees is already paid for current semester.";
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object> data = ser.Deserialize<Dictionary<string, object>>(manually_data);

            DSC_fees_status_WS.ws_user_uploaded_payslip_dtlRow user_fees = obj_fees_status.ws_user_uploaded_payslip_dtl.Newws_user_uploaded_payslip_dtlRow();


            user_fees.doc_no = "1";
            user_fees.user_id = HttpContext.Current.Session["UserId"].ToString();

            user_fees.mode_of_payment = data["mode_of_payment"].ToString();
            user_fees.branch_name = data["branch_name"].ToString();
            user_fees.bank_name = data["bank_name"].ToString();
            user_fees.dd_no = data["dd_no"].ToString();

            string date_of_dd = data["date_of_dd"].ToString();

            if (date_of_dd.ToString().Trim() != "")
            {
                String dst21 = date_of_dd.ToString();

                string[] sdg21 = dst21.ToString().Split('/');
                string gh21 = sdg21[2].ToString() + "/" + sdg21[1].ToString() + "/" + sdg21[0].ToString();

                DateTime expiryto = Convert.ToDateTime(gh21);
                String expiry2 = expiryto.ToString();

                user_fees.date_of_dd = Convert.ToDateTime(expiry2);

            }

            user_fees.amount = data["amount"].ToString();
            user_fees.uploadpayslippath = data["uploadpayslippath"].ToString();

            user_fees.cancel_flag = "N";
            user_fees.semester_type = current_ws_sem;
            user_fees.year_semester = current_ws_year;

            user_fees.is_admin_approved = "N";
            user_fees.created_by = HttpContext.Current.Session["UserId"].ToString();
            user_fees.created_date = System.DateTime.Now;
            user_fees.created_host = HttpContext.Current.Request.UserHostName;


            //obj_workflow.New_cad_workflow_mst.AddNew_cad_workflow_mstRow(user_fees);
            obj_fees_status.ws_user_uploaded_payslip_dtl.Addws_user_uploaded_payslip_dtlRow(user_fees);

            objBLReturnObject = objMaster.save_upload_manually_payslip_dtl(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
        }
        catch (Exception ex)
        {

            return "Problem in Save DATA." + ex.ToString();
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod]
    public string get_upload_manually_payslip_dtl(string dept_code, string year_of_allocation, string prog_code)
    {
        DataTable Get_user_userfees = objmaster.get_upload_manually_payslip_dtl(dept_code, prog_code, year_of_allocation, current_ws_sem, current_ws_year);

        if (Get_user_userfees != null)
        {
            jsondata = GetJson1(Get_user_userfees);
        }
        return jsondata;
    }

    [WebMethod(EnableSession = true)]
    public string accept_reject_payslip(string aceept_reject_data)
    {
        //Save Compliance Details in compliance_entry table.

        int re = 0;
        Dictionary<string, object> obj_data = new Dictionary<string, object>();

        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object> data = ser.Deserialize<Dictionary<string, object>>(aceept_reject_data);

            DataTable dt_fees_status_check = objmaster.Get_fees_status_for_student_for_fees_payment(data["user_id"].ToString(), current_ws_sem, current_ws_year);

            if (dt_fees_status_check != null)
            {
                obj_data["status"] = false;
                obj_data["message"] = "you can not accept/reject payslip.fees of this student is already paid for current semester.";

                return JsonConvert.SerializeObject(obj_data);
            }

            DataTable dt_user_upload_data = objmaster.get_user_upload_payslip_data(data["user_id"].ToString(), current_ws_sem, current_ws_year);

            if (dt_user_upload_data != null)
            {
                DataRow modify_row = dt_user_upload_data.Rows[0];

                modify_row["is_admin_approved"] = data["is_admin_approved"].ToString();
                modify_row["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                modify_row["last_modified_date"] = System.DateTime.Now;
                modify_row["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                if (data["is_admin_approved"].ToString() == "R")
                {
                    modify_row["remarks"] = data["remark"].ToString();
                }
                else
                {
                    DataTable dt = objmaster.Get_student_fees_saved_data_for_manually_accept(data["user_id"].ToString(), current_ws_sem, current_ws_year);

                    int total_credits = 0;
                    string fees_status = "Y";

                    if (dt != null)
                    {
                        DataRow modify_fees_row = dt.Rows[0];

                        modify_fees_row["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                        modify_fees_row["last_midified_date"] = System.DateTime.Now;
                        modify_fees_row["last_modified_host"] = HttpContext.Current.Request.UserHostName;
                        modify_fees_row["fees_status"] = fees_status;

                        obj_fees_status.ws_user_fees_status.ImportRow(modify_fees_row);
                    }
                    else
                    {
                        DSC_fees_status_WS.ws_user_fees_statusRow user_fees = obj_fees_status.ws_user_fees_status.Newws_user_fees_statusRow();

                        user_fees.doc_no = re.ToString();
                        user_fees.user_id = data["user_id"].ToString();
                        user_fees.fees_status = fees_status;
                        user_fees.cancel_flag = "N";
                        user_fees.semester_type = current_ws_sem;
                        user_fees.year_type = current_ws_year;
                        user_fees.dept_code = data["dept_code"].ToString();
                        user_fees.year_code = data["year_code"].ToString();
                        user_fees.installmant_status = "N";
                        user_fees.created_by = HttpContext.Current.Session["UserId"].ToString();
                        user_fees.created_date = System.DateTime.Now;
                        user_fees.created_host = HttpContext.Current.Request.UserHostName;

                        obj_fees_status.ws_user_fees_status.Addws_user_fees_statusRow(user_fees);
                    }
                }

                obj_fees_status.ws_user_uploaded_payslip_dtl.ImportRow(modify_row);
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = "Problem in retrieve user details.";

                return JsonConvert.SerializeObject(obj_data);
            }

            objBLReturnObject = objMaster.save_upload_manually_payslip_dtl(obj_fees_status, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);

            if (objBLReturnObject.ExecutionStatus == 1)
            {
                //string subject = "Manually Payslip Approve";

                string str_semester = "";

                if (current_ws_sem == "S") str_semester = "Summer School " + current_ws_year;
                else if (current_ws_sem == "W") str_semester = "Winter School " + current_ws_year;

                if (data["is_admin_approved"].ToString() == "A")
                {
                    string remark = "Dear " + dt_user_upload_data.Rows[0]["user_name"].ToString() + ",";

                    //remark += "<br /><br />Thank you for Paying fees for Winter School 2016.";
                    remark += "<br /><br />Thank you for Paying fees for " + str_semester + ".";
                    remark += "<br /><br />You have successfully paid " + dt_user_upload_data.Rows[0]["amount"].ToString() + " Rs.";
                    //remark += "<br /><br />Now you can login, select the courses and register for Summer School 2016.";
                    remark += "<br /><br />Note: *Subject to realization of credit of Cash/DD in our account.";
                    remark += "<br /><br />In case of any issues contact us at summerwinterschool@cept.ac.in";
                    remark += "<br /><br /><br />CEPT University!";

                    string message = objmail.Send_accept_reject_mail("donotreply@cept.ac.in", "vyujpnmbkllqrujz", data["mail"].ToString(), remark, "Acknowledgement for Pay in Slip");  //cept2014
                }
                else
                {
                    string remark = "Dear " + dt_user_upload_data.Rows[0]["user_name"].ToString() + ",";
                    remark += "<br /><br />Your payslip is not accepted for the following reason";
                    remark += "<br /><br />" + data["remark"].ToString();
                    remark += "<br /><br /><br />Regards,";
                    remark += "<br /><br />SWS Office";

                    string message = objmail.Send_accept_reject_mail("donotreply@cept.ac.in", "vyujpnmbkllqrujz", data["mail"].ToString(), remark, "Resend Pay in Slip");  //cept2014
                }

                obj_data["status"] = true;
                obj_data["message"] = "";

                return JsonConvert.SerializeObject(obj_data);
            }
            else
            {
                obj_data["status"] = false;
                obj_data["message"] = objBLReturnObject.ServerMessage;

                return JsonConvert.SerializeObject(obj_data);
            }
        }
        catch (Exception ex)
        {
            obj_data["status"] = false;
            obj_data["message"] = "Problem in Save DATA." + ex.ToString();

            return JsonConvert.SerializeObject(obj_data);
        }

        obj_data["status"] = false;
        obj_data["message"] = objBLReturnObject.ServerMessage;

        return JsonConvert.SerializeObject(obj_data);
    }

    #endregion

    #region Convert datatable To Json

    public string GetJson1(DataTable dt)
    {
        JavaScriptSerializer ser = new JavaScriptSerializer();
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

    #endregion

    #region Excel File upload

    [WebMethod(EnableSession = true)]
    public string ExcelFileToDatatable_uplad(String ExcelFileName, HttpContext context)
    {

        Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
        DataSet ds = new DataSet();

        String sConnectionString = String.Empty;

        dt_error.Columns.Add("Excel_RowNo");
        dt_error.Columns.Add("User_Id");
        dt_error.Columns.Add("Remark");


        string path = Server.MapPath("~/UploadFiles") + "\\" + ExcelFileName;

        OleDbConnection objConn = new OleDbConnection(sConnectionString);
        try
        {
            if (Path.GetExtension(ExcelFileName).ToLower() == ".xls")
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + "; Extended Properties=Excel 8.0;";
            else
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES\"";



            objConn.ConnectionString = sConnectionString;
            try
            {
                objConn.Open();
            }
            catch (Exception ex)
            {
                //FileStream fs = new FileStream("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", FileMode.Append, FileAccess.Write, FileShare.Write);
                //fs.Close();
                //StreamWriter sw = new StreamWriter("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", true, Encoding.ASCII);
                //sw.WriteLine(ex);
                //sw.Close();
            }

            DataTable tables = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            OleDbCommand cmd = new OleDbCommand();
            cmd.Connection = objConn;
            OleDbDataAdapter adp = new OleDbDataAdapter(cmd);

            if (tables != null && tables.Rows.Count > 0)
            {
                DataTable[] excelSheetTables = new DataTable[tables.Rows.Count];
                int CurrentTable = 0;
                foreach (DataRow dr in tables.Rows)
                {
                    //if (!dr["TABLE_NAME"].ToString().Contains("$"))



                    if (!dr["TABLE_NAME"].ToString().Contains("xlnm#_FilterDatabase") && !dr["TABLE_NAME"].ToString().EndsWith("_"))
                    {
                        cmd.CommandText = "select * from [" + dr["TABLE_NAME"].ToString() + "]";
                        excelSheetTables[CurrentTable] = new DataTable(dr["TABLE_NAME"].ToString());
                        adp.Fill(excelSheetTables[CurrentTable]);
                        CurrentTable++;
                    }

                }
                foreach (DataTable singleTable in excelSheetTables)
                {
                    if (singleTable != null)
                    {
                        ds.Tables.Add(singleTable);
                    }
                }


                DataTable dt_user_mst_data = objmaster.get_all_user_mst_data();

                DataTable dt_dept_data = objmaster.Get_department_data();

                DataTable dt_year_data = objmaster.Get_year_data();

                DataTable dt_prog_data = objmaster.Get_programme_data();



                user_mst = ds.Tables[0];

                for (int i = 0; i < user_mst.Rows.Count; i++)
                {
                    isEmpty = true;
                    for (int j = 0; j < user_mst.Columns.Count; j++)
                    {

                        if (string.IsNullOrEmpty(user_mst.Rows[i][j].ToString()) == false)
                        {

                            isEmpty = false;
                            break;
                        }
                    }
                    if (isEmpty == true)
                    {
                        user_mst.Rows.RemoveAt(i);
                        i--;
                    }




                }

                if (user_mst.Rows.Count == 0)
                {
                    return "null";
                }


                for (int j = 0; j < user_mst.Rows.Count; j++)
                {

                    if (user_mst.Rows[j]["user id"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = "";
                        dr_error["Remark"] = "User ID is null";
                        //user_mst.Rows[j].Delete();
                        dt_error.Rows.Add(dr_error);
                    }

                    else
                    {

                        if (dt_user_mst_data != null)
                        {
                            DataRow[] dr = dt_user_mst_data.Select("user_id = '" + user_mst.Rows[j]["user id"].ToString().Trim() + "'");

                            if (dr.Length > 0)
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                                dr_error["Remark"] = "User Id is already in Master table";
                                //user_mst.Rows[j].Delete();
                                dt_error.Rows.Add(dr_error);
                            }
                        }

                    }


                    if (user_mst.Rows[j]["user type"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "User type is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {
                        if (user_mst.Rows[j]["user type"].ToString().Trim().ToLower() == "admin"
                            || user_mst.Rows[j]["user type"].ToString().Trim().ToLower() == "student"
                            || user_mst.Rows[j]["user type"].ToString().Trim().ToLower() == "IT"
                            || user_mst.Rows[j]["user type"].ToString().Trim().ToLower() == "admin1")
                        {

                        }
                        else
                        {
                            dr_error = dt_error.NewRow();

                            dr_error["Excel_RowNo"] = Convert.ToString(j);
                            dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                            dr_error["Remark"] = "Enter Correct User Type (Admin,Admin1,Student or IT)";
                            //user_mst.Rows[j].Delete();
                            dt_error.Rows.Add(dr_error);
                        }
                    }


                    if (user_mst.Rows[j]["Student No"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "Student No is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {
                        if (dt_user_mst_data != null)
                        {
                            DataRow[] dr = dt_user_mst_data.Select("student_no = '" + user_mst.Rows[j]["Student No"].ToString().Trim() + "'");

                            if (dr.Length > 0)
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                                dr_error["Remark"] = "Student No is already in Master table";
                                //user_mst.Rows[j].Delete();
                                dt_error.Rows.Add(dr_error);
                            }
                        }
                    }

                    if (user_mst.Rows[j]["Department Name"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "Department Name is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {


                        if (dt_dept_data != null)
                        {
                            DataRow[] dr_dept = dt_dept_data.Select("dept_name = '" + user_mst.Rows[j]["Department Name"].ToString().Trim() + "'");

                            if (dr_dept.Length > 0)
                            {

                            }
                            else
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                                dr_error["Remark"] = "Department name is not available in master";

                                dt_error.Rows.Add(dr_error);
                            }
                        }
                        else
                        {

                            dr_error = dt_error.NewRow();

                            dr_error["Excel_RowNo"] = Convert.ToString(j);
                            dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                            dr_error["Remark"] = "Department name is not available in master";

                            dt_error.Rows.Add(dr_error);
                        }
                    }




                    if (user_mst.Rows[j]["year"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "year code is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {


                        if (dt_year_data != null)
                        {
                            DataRow[] dr_year = dt_year_data.Select("year_desc = '" + user_mst.Rows[j]["year"].ToString().Trim() + "'");

                            if (dr_year.Length > 0)
                            {

                            }
                            else
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                                dr_error["Remark"] = "Year is not available in master";

                                dt_error.Rows.Add(dr_error);
                            }
                        }
                        else
                        {

                            dr_error = dt_error.NewRow();

                            dr_error["Excel_RowNo"] = Convert.ToString(j);
                            dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                            dr_error["Remark"] = "Year is not available in master";

                            dt_error.Rows.Add(dr_error);
                        }
                    }



                    if (user_mst.Rows[j]["programme name"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "programme name code is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {


                        if (dt_prog_data != null)
                        {
                            DataRow[] dr_prog = dt_prog_data.Select("prog_name = '" + user_mst.Rows[j]["programme name"].ToString().Trim() + "'");

                            if (dr_prog.Length > 0)
                            {

                            }
                            else
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                                dr_error["Remark"] = "Programme Name is not available in master";

                                dt_error.Rows.Add(dr_error);
                            }
                        }
                        else
                        {

                            dr_error = dt_error.NewRow();

                            dr_error["Excel_RowNo"] = Convert.ToString(j);
                            dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                            dr_error["Remark"] = "Programme Name is not available in master";

                            dt_error.Rows.Add(dr_error);
                        }
                    }

                    if (user_mst.Rows[j]["First Name"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "First Name is null";

                        dt_error.Rows.Add(dr_error);
                    }

                    if (user_mst.Rows[j]["EMail ID"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "EMail ID is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {



                        Match match = regex.Match(user_mst.Rows[j]["EMail ID"].ToString());
                        if (match.Success)
                        {

                        }
                        else
                        {
                            dr_error = dt_error.NewRow();

                            dr_error["Excel_RowNo"] = Convert.ToString(j);
                            dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                            dr_error["Remark"] = "EMail ID is not in correct format";

                            dt_error.Rows.Add(dr_error);
                        }

                        if (dt_user_mst_data != null)
                        {
                            DataRow[] dr_email = dt_user_mst_data.Select("mail = '" + user_mst.Rows[j]["EMail ID"].ToString().Trim().ToLower() + "'");

                            if (dr_email.Length > 0)
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                                dr_error["Remark"] = "EMail ID is already in master table";

                                dt_error.Rows.Add(dr_error);

                            }

                        }

                    }

                    if (user_mst.Rows[j]["current_semester"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["User_Id"] = user_mst.Rows[j]["user id"];
                        dr_error["Remark"] = "Current Semester is null";

                        dt_error.Rows.Add(dr_error);
                    }



                }

                // user_mst.AcceptChanges();
                checkduplicatedata(user_mst, "User Id");
                checkduplicatedata(user_mst, "EMail ID");

                if (dt_error.Rows.Count > 0)
                {

                    jsondata = GetJson1(dt_error);

                    return jsondata;
                }

                int re = 0;
                bool flag = true;

                for (int i = 0; i < user_mst.Rows.Count; i++)
                {
                    re = re + 1;
                    DSC_userdataupload_WS.user_mstRow user_row = obj_userdataupload.user_mst.Newuser_mstRow();
                    user_row.doc_no = re.ToString();
                    user_row.user_id = user_mst.Rows[i]["User Id"].ToString().Trim();
                    user_row.user_name = user_mst.Rows[i]["First Name"].ToString().Trim();
                    //  user_row.user_type = user_mst.Rows[i]["user type"].ToString().Trim().Substring(0, 1);
                    user_row.student_no = user_mst.Rows[i]["Student No"].ToString().Trim();


                    if (user_mst.Rows[i]["user type"].ToString().Trim().ToLower() == "student")
                    {
                        user_row.user_type = "S";
                    }
                    else if (user_mst.Rows[i]["user type"].ToString().Trim().ToLower() == "admin")
                    {
                        user_row.user_type = "A";
                    }
                    else if (user_mst.Rows[i]["user type"].ToString().Trim().ToLower() == "admin1")
                    {
                        user_row.user_type = "A1";
                    }
                    else if (user_mst.Rows[i]["user type"].ToString().Trim().ToLower() == "IT")
                    {
                        user_row.user_type = "I";
                    }


                    //  user_row.enrollment_no = user_mst.Rows[i]["Enrollment No"].ToString().Trim();

                    user_row.enrollment_no = "";
                    DataTable dept_code = objmaster.department_code_upload(user_mst.Rows[0]["Department Name"].ToString().Trim());


                    DataRow[] dr_dept = dt_dept_data.Select("dept_name = '" + user_mst.Rows[0]["Department Name"].ToString().Trim() + "'");

                    if (dr_dept.Length > 0)
                    {
                        user_row.dept_code = dr_dept[0]["dept_code"].ToString().Trim();
                    }

                    DataRow[] dr_year = dt_year_data.Select("year_desc = '" + user_mst.Rows[0]["Year"].ToString().Trim() + "'");

                    if (dr_year.Length > 0)
                    {
                        user_row.year_code = dr_year[0]["year_code"].ToString().Trim();
                    }

                    DataRow[] dr_prog = dt_prog_data.Select("prog_name = '" + user_mst.Rows[0]["programme name"].ToString().Trim() + "'");

                    if (dr_prog.Length > 0)
                    {
                        user_row.prog_code = dr_prog[0]["prog_code"].ToString().Trim();
                    }


                    EncryptPassword encrpt = new EncryptPassword();
                    //String Password = encrpt.sbs_encrypt(dtUserMstInfo.Rows[0]["password"].ToString());

                    encrpt = new EncryptPassword();





                    //String NewPassword = encrpt.sbs_encrypt("admin");

                    String NewPassword = encoding_decoding.encryptPassword("admin");

                    user_row.password = NewPassword.ToString();

                    user_row.first_name = user_mst.Rows[i]["First Name"].ToString().Trim();
                    user_row.middle_name = user_mst.Rows[i]["Middle Name"].ToString().Trim();
                    user_row.last_name = user_mst.Rows[i]["Last name"].ToString().Trim();
                    user_row.full_name = user_mst.Rows[i]["First Name"].ToString().Trim() + ' ' + user_mst.Rows[i]["Middle Name"].ToString().Trim() + ' ' + user_mst.Rows[i]["Last name"].ToString().Trim();
                    user_row.mail = user_mst.Rows[i]["EMail ID"].ToString().Trim().ToLower();
                    user_row.gender = user_mst.Rows[i]["Gender"].ToString().Trim().Substring(0, 1);
                    user_row.address = user_mst.Rows[i]["Address"].ToString().Trim();
                    user_row.start_date = System.DateTime.Now;
                    //    user_row.end_date = Convert.ToDateTime(user_mst.Rows[i]["End Date"].ToString().Trim());

                    DateTime date = System.DateTime.Now;

                    DateTime pass_exp_date = date.AddYears(8);

                    user_row.pass_expiry_date = pass_exp_date;
                    user_row.user_status_flag = "A";
                    user_row.state = "A";
                    user_row.city = user_mst.Rows[i]["city"].ToString().Trim();
                    user_row.state = user_mst.Rows[i]["state"].ToString().Trim();
                    user_row.country = user_mst.Rows[i]["country"].ToString().Trim();
                    if (user_mst.Rows[i]["Birth Date"].ToString() != "")
                    {
                        user_row.dob = Convert.ToDateTime(user_mst.Rows[i]["Birth Date"].ToString().Trim());
                    }


                    user_row.phone_no = user_mst.Rows[i]["phone no"].ToString().Trim();
                    user_row.mobile_no = user_mst.Rows[i]["mobile no"].ToString().Trim();
                    //    user_row.last_login_date = ;
                    user_row.cancel_flag = "N";
                    user_row.created_by = context.Session["UserId"].ToString();
                    user_row.created_date = System.DateTime.Now;
                    user_row.created_host = HttpContext.Current.Request.UserHostName;
                    //user_row.last_modified_by = context.Session["UserId"].ToString();
                    //user_row.last_midified_date = System.DateTime.Now;
                    //user_row.last_modified_host = HttpContext.Current.Request.UserHostName;
                    obj_userdataupload.user_mst.Adduser_mstRow(user_row);


                }


                objBLReturnObject = objMaster.excel_data_uplad(obj_userdataupload, "2000", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);


            }
        }
        catch (Exception ex)
        {
            return "Problem in save data";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string ExcelFileToDatatable_uplad_area(String ExcelFileName, HttpContext context)
    {


        DataSet ds = new DataSet();
        //DataTable user_mst = new DataTable();
        DataTable area_mst = new DataTable();
        String sConnectionString = String.Empty;

        dt_error.Columns.Add("Excel_RowNo");
        dt_error.Columns.Add("area_code");
        dt_error.Columns.Add("Remark");


        string path = Server.MapPath("~/UploadFiles") + "\\" + ExcelFileName;

        OleDbConnection objConn = new OleDbConnection(sConnectionString);
        try
        {
            if (Path.GetExtension(ExcelFileName).ToLower() == ".xls")
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + "; Extended Properties=Excel 8.0;";
            else
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES\"";



            objConn.ConnectionString = sConnectionString;
            try
            {
                objConn.Open();
            }
            catch (Exception ex)
            {
                //FileStream fs = new FileStream("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", FileMode.Append, FileAccess.Write, FileShare.Write);
                //fs.Close();
                //StreamWriter sw = new StreamWriter("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", true, Encoding.ASCII);
                //sw.WriteLine(ex);
                //sw.Close();
            }

            DataTable tables = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            OleDbCommand cmd = new OleDbCommand();
            cmd.Connection = objConn;
            OleDbDataAdapter adp = new OleDbDataAdapter(cmd);

            if (tables != null && tables.Rows.Count > 0)
            {
                DataTable[] excelSheetTables = new DataTable[tables.Rows.Count];
                int CurrentTable = 0;
                foreach (DataRow dr in tables.Rows)
                {
                    //if (!dr["TABLE_NAME"].ToString().Contains("$"))



                    if (!dr["TABLE_NAME"].ToString().Contains("xlnm#_FilterDatabase") && !dr["TABLE_NAME"].ToString().EndsWith("_"))
                    {
                        cmd.CommandText = "select * from [" + dr["TABLE_NAME"].ToString() + "]";
                        excelSheetTables[CurrentTable] = new DataTable(dr["TABLE_NAME"].ToString());
                        adp.Fill(excelSheetTables[CurrentTable]);
                        CurrentTable++;
                    }

                }
                foreach (DataTable singleTable in excelSheetTables)
                {
                    if (singleTable != null)
                    {
                        ds.Tables.Add(singleTable);
                    }
                }

                area_mst = ds.Tables[0];

                for (int i = 0; i < area_mst.Rows.Count; i++)
                {
                    isEmpty = true;
                    for (int j = 0; j < area_mst.Columns.Count; j++)
                    {

                        if (string.IsNullOrEmpty(area_mst.Rows[i][j].ToString()) == false)
                        {

                            isEmpty = false;
                            break;
                        }
                    }
                    if (isEmpty == true)
                    {
                        area_mst.Rows.RemoveAt(i);
                        i--;
                    }
                }

                if (area_mst.Rows.Count == 0)
                {
                    return "null";
                }


                DataTable dt_area = objmaster.Get_area_data();


                for (int j = 0; j < area_mst.Rows.Count; j++)
                {

                    if (area_mst.Rows[j]["Area code"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["area_code"] = area_mst.Rows[j]["Area code"].ToString();
                        dr_error["Remark"] = "area code is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {

                        if (dt_area != null)
                        {
                            DataRow[] dr_area = dt_area.Select("area_code = '" + area_mst.Rows[j]["Area code"].ToString().Trim() + "'");

                            if (dr_area.Length > 0)
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["area_code"] = area_mst.Rows[j]["Area code"].ToString();
                                dr_error["Remark"] = "area code is already in master";

                                dt_error.Rows.Add(dr_error);
                            }
                        }
                    }



                    if (area_mst.Rows[j]["Area name"].ToString() == "")
                    {
                        dr_error = dt_error.NewRow();

                        dr_error["Excel_RowNo"] = Convert.ToString(j);
                        dr_error["area_code"] = area_mst.Rows[j]["Area code"].ToString();
                        dr_error["Remark"] = "area name is null";

                        dt_error.Rows.Add(dr_error);
                    }
                    else
                    {

                        if (dt_area != null)
                        {
                            DataRow[] dr_area_name = dt_area.Select("area_name = '" + area_mst.Rows[j]["Area name"].ToString().Trim() + "'");

                            if (dr_area_name.Length > 0)
                            {
                                dr_error = dt_error.NewRow();

                                dr_error["Excel_RowNo"] = Convert.ToString(j);
                                dr_error["area_code"] = area_mst.Rows[j]["Area code"].ToString();
                                dr_error["Remark"] = "area name is already in master";

                                dt_error.Rows.Add(dr_error);
                            }
                        }
                    }
                }




                // area_mst.AcceptChanges();
                checkduplicatedata(area_mst, "Area code");
                checkduplicatedata(area_mst, "Area name");

                if (dt_error.Rows.Count > 0)
                {
                    jsondata = GetJson1(dt_error);

                    return jsondata;
                }

                int re = 0;
                bool flag = true;
                for (int i = 0; i < area_mst.Rows.Count; i++)
                {
                    re = re + 1;
                    DSC_userdataupload_WS.area_mstRow area_row = obj_userdataupload.area_mst.Newarea_mstRow();
                    //  area_row.doc_no = re.ToString();
                    area_row.area_code = area_mst.Rows[i]["Area code"].ToString().Trim();
                    area_row.area_name = area_mst.Rows[i]["Area name"].ToString().Trim();
                    //DataTable year_code = objmaster.year_code_select(area_mst.Rows[0]["Year code"].ToString());
                    //if (year_code == null || year_code.Rows.Count == 0)
                    //{
                    //    flag = false;
                    //    break;
                    //}
                    area_row.year_code = "";
                    area_row.cancel_flag = "N";
                    area_row.created_by = HttpContext.Current.Session["UserId"].ToString();
                    area_row.created_date = System.DateTime.Now;
                    area_row.created_host = HttpContext.Current.Request.UserHostName;
                    area_row.last_modified_by = context.Session["UserId"].ToString();
                    area_row.last_modified_date = System.DateTime.Now;
                    area_row.last_modified_host = HttpContext.Current.Request.UserHostName;
                    obj_userdataupload.area_mst.Addarea_mstRow(area_row);
                }
                if (flag)
                    objBLReturnObject = objMaster.excel_data_uplad(obj_userdataupload, "2000", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
                else
                    return "please check upload excel data";
            }
        }
        catch (Exception ex)
        {
            return "Problem In Saving Data";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string ExcelFileToDatatable_course_upload(String ExcelFileName, HttpContext context)
    {


        DataSet ds = new DataSet();
        //DataTable user_mst = new DataTable();
        DataTable course_mst = new DataTable();
        String sConnectionString = String.Empty;

        string path = Server.MapPath("~/UploadFiles") + "\\" + ExcelFileName;

        OleDbConnection objConn = new OleDbConnection(sConnectionString);
        try
        {
            if (Path.GetExtension(ExcelFileName).ToLower() == ".xls")
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + "; Extended Properties=Excel 8.0;";
            else
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES\"";



            objConn.ConnectionString = sConnectionString;
            try
            {
                objConn.Open();
            }
            catch (Exception ex)
            {
                //FileStream fs = new FileStream("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", FileMode.Append, FileAccess.Write, FileShare.Write);
                //fs.Close();
                //StreamWriter sw = new StreamWriter("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", true, Encoding.ASCII);
                //sw.WriteLine(ex);
                //sw.Close();
            }

            DataTable tables = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            OleDbCommand cmd = new OleDbCommand();
            cmd.Connection = objConn;
            OleDbDataAdapter adp = new OleDbDataAdapter(cmd);

            if (tables != null && tables.Rows.Count > 0)
            {
                DataTable[] excelSheetTables = new DataTable[tables.Rows.Count];
                int CurrentTable = 0;
                foreach (DataRow dr in tables.Rows)
                {
                    //if (!dr["TABLE_NAME"].ToString().Contains("$"))



                    if (!dr["TABLE_NAME"].ToString().Contains("xlnm#_FilterDatabase") && !dr["TABLE_NAME"].ToString().EndsWith("_"))
                    {
                        cmd.CommandText = "select * from [" + dr["TABLE_NAME"].ToString() + "]";
                        excelSheetTables[CurrentTable] = new DataTable(dr["TABLE_NAME"].ToString());
                        adp.Fill(excelSheetTables[CurrentTable]);
                        CurrentTable++;
                    }

                }
                foreach (DataTable singleTable in excelSheetTables)
                {
                    if (singleTable != null)
                    {
                        ds.Tables.Add(singleTable);
                    }
                }

                course_mst = ds.Tables[0];
                for (int j = 0; j < course_mst.Rows.Count; j++)
                {

                    if (course_mst.Rows[j]["course_code"].ToString() == "")
                    {
                        course_mst.Rows[j].Delete();
                    }
                }
                course_mst.AcceptChanges();
                course_mst = RemoveDuplicateRows(course_mst, "course_code");
                int re = 0;
                bool flag = true;
                for (int i = 0; i < course_mst.Rows.Count; i++)
                {
                    re = re + 1;
                    DSC_userdataupload_WS.course_mstRow course_row = obj_userdataupload.course_mst.Newcourse_mstRow();
                    course_row.doc_no = re.ToString();
                    course_row.course_code = course_mst.Rows[i]["course_code"].ToString();
                    course_row.course_name = course_mst.Rows[i]["course_name"].ToString();
                    DataTable year_code = objmaster.year_code_select(course_mst.Rows[0]["year_code"].ToString());
                    if (year_code == null || year_code.Rows.Count == 0)
                    {
                        flag = false;
                        break;
                    }
                    course_row.year_code = year_code.Rows[0]["year_code"].ToString();
                    course_row.course_credits = course_mst.Rows[i]["course_credits"].ToString();
                    course_row.course_from_date = Convert.ToDateTime(course_mst.Rows[i]["course_from_date"].ToString());
                    course_row.course_end_date = Convert.ToDateTime(course_mst.Rows[i]["course_end_date"].ToString());
                    course_row.course_elegibility = course_mst.Rows[i]["course_elegibility"].ToString();
                    course_row.course_type = course_mst.Rows[i]["course_type"].ToString();
                    course_row.cancel_flag = "N";
                    course_row.created_by = HttpContext.Current.Session["UserId"].ToString();
                    course_row.created_date = System.DateTime.Now;
                    course_row.created_host = HttpContext.Current.Request.UserHostName;
                    course_row.last_modified_by = context.Session["UserId"].ToString();
                    course_row.last_modified_date = System.DateTime.Now;
                    course_row.last_modified_host = HttpContext.Current.Request.UserHostName;
                    obj_userdataupload.course_mst.Addcourse_mstRow(course_row);
                }
                if (flag)
                    objBLReturnObject = objMaster.excel_data_uplad(obj_userdataupload, "2000", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
                else
                    return "please check upload excel data";
            }
        }
        catch (Exception ex)
        {
            return "Problem In Saving Data";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string ExcelFileToDatatable_department_upload(String ExcelFileName, HttpContext context)
    {


        DataSet ds = new DataSet();
        //DataTable user_mst = new DataTable();
        DataTable dept_mst = new DataTable();
        String sConnectionString = String.Empty;

        string path = Server.MapPath("~/UploadFiles") + "\\" + ExcelFileName;

        OleDbConnection objConn = new OleDbConnection(sConnectionString);
        try
        {
            if (Path.GetExtension(ExcelFileName).ToLower() == ".xls")
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + "; Extended Properties=Excel 8.0;";
            else
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES\"";
            objConn.ConnectionString = sConnectionString;
            try
            {
                objConn.Open();
            }
            catch (Exception ex)
            {
                //FileStream fs = new FileStream("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", FileMode.Append, FileAccess.Write, FileShare.Write);
                //fs.Close();
                //StreamWriter sw = new StreamWriter("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", true, Encoding.ASCII);
                //sw.WriteLine(ex);
                //sw.Close();
            }

            DataTable tables = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            OleDbCommand cmd = new OleDbCommand();
            cmd.Connection = objConn;
            OleDbDataAdapter adp = new OleDbDataAdapter(cmd);

            if (tables != null && tables.Rows.Count > 0)
            {
                DataTable[] excelSheetTables = new DataTable[tables.Rows.Count];
                int CurrentTable = 0;
                foreach (DataRow dr in tables.Rows)
                {
                    //if (!dr["TABLE_NAME"].ToString().Contains("$"))



                    if (!dr["TABLE_NAME"].ToString().Contains("xlnm#_FilterDatabase") && !dr["TABLE_NAME"].ToString().EndsWith("_"))
                    {
                        cmd.CommandText = "select * from [" + dr["TABLE_NAME"].ToString() + "]";
                        excelSheetTables[CurrentTable] = new DataTable(dr["TABLE_NAME"].ToString());
                        adp.Fill(excelSheetTables[CurrentTable]);
                        CurrentTable++;
                    }

                }
                foreach (DataTable singleTable in excelSheetTables)
                {
                    if (singleTable != null)
                    {
                        ds.Tables.Add(singleTable);
                    }
                }

                dept_mst = ds.Tables[0];
                for (int j = 0; j < dept_mst.Rows.Count; j++)
                {

                    if (dept_mst.Rows[j]["dept_code"].ToString() == "")
                    {
                        dept_mst.Rows[j].Delete();
                    }
                }
                dept_mst.AcceptChanges();
                dept_mst = RemoveDuplicateRows(dept_mst, "dept_code");
                int re = 0;
                bool flag = true;
                for (int i = 0; i < dept_mst.Rows.Count; i++)
                {
                    re = re + 1;

                    DSC_userdataupload_WS.department_mstRow dept_row = obj_userdataupload.department_mst.Newdepartment_mstRow();
                    //     dept_row.doc_no = re.ToString();
                    dept_row.dept_code = dept_mst.Rows[i]["dept_code"].ToString();
                    dept_row.dept_name = dept_mst.Rows[i]["dept_name"].ToString();
                    DataTable year_code = objmaster.year_code_select(dept_mst.Rows[0]["year_code"].ToString());
                    if (year_code == null || year_code.Rows.Count == 0)
                    {
                        flag = false;
                        break;
                    }
                    dept_row.year_code = year_code.Rows[0]["year_code"].ToString();
                    dept_row.cancel_flag = "N";
                    dept_row.created_by = HttpContext.Current.Session["UserId"].ToString();
                    dept_row.created_date = System.DateTime.Now;
                    dept_row.created_host = HttpContext.Current.Request.UserHostName;
                    dept_row.last_modified_by = context.Session["UserId"].ToString();
                    dept_row.last_modified_date = System.DateTime.Now;
                    dept_row.last_modified_host = HttpContext.Current.Request.UserHostName;
                    obj_userdataupload.department_mst.Adddepartment_mstRow(dept_row);
                }
                if (flag)
                    objBLReturnObject = objMaster.excel_data_uplad(obj_userdataupload, "2000", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
                else
                    return "please check upload excel data";
            }
        }
        catch (Exception ex)
        {
            return "Problem In Saving Data";
        }
        return objBLReturnObject.ServerMessage;

    }

    [WebMethod(EnableSession = true)]
    public string ExcelFileToDatatable_uplad_instructor(String ExcelFileName, HttpContext context)
    {


        DataSet ds = new DataSet();
        //DataTable user_mst = new DataTable();
        DataTable instructor = new DataTable();
        String sConnectionString = String.Empty;

        string path = Server.MapPath("~/UploadFiles") + "\\" + ExcelFileName;

        OleDbConnection objConn = new OleDbConnection(sConnectionString);
        try
        {
            if (Path.GetExtension(ExcelFileName).ToLower() == ".xls")
                sConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + "; Extended Properties=Excel 8.0;";
            else
                sConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES\"";
            objConn.ConnectionString = sConnectionString;
            try
            {
                objConn.Open();
            }
            catch (Exception ex)
            {
                //FileStream fs = new FileStream("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", FileMode.Append, FileAccess.Write, FileShare.Write);
                //fs.Close();
                //StreamWriter sw = new StreamWriter("C:\\inetpub\\wwwroot\\adani\\CAS\\LogDetails\\log.txt", true, Encoding.ASCII);
                //sw.WriteLine(ex);
                //sw.Close();
            }

            DataTable tables = objConn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            OleDbCommand cmd = new OleDbCommand();
            cmd.Connection = objConn;
            OleDbDataAdapter adp = new OleDbDataAdapter(cmd);

            if (tables != null && tables.Rows.Count > 0)
            {
                DataTable[] excelSheetTables = new DataTable[tables.Rows.Count];
                int CurrentTable = 0;
                foreach (DataRow dr in tables.Rows)
                {
                    //if (!dr["TABLE_NAME"].ToString().Contains("$"))



                    if (!dr["TABLE_NAME"].ToString().Contains("xlnm#_FilterDatabase") && !dr["TABLE_NAME"].ToString().EndsWith("_"))
                    {
                        cmd.CommandText = "select * from [" + dr["TABLE_NAME"].ToString() + "]";
                        excelSheetTables[CurrentTable] = new DataTable(dr["TABLE_NAME"].ToString());
                        adp.Fill(excelSheetTables[CurrentTable]);
                        CurrentTable++;
                    }

                }
                foreach (DataTable singleTable in excelSheetTables)
                {
                    if (singleTable != null)
                    {
                        ds.Tables.Add(singleTable);
                    }
                }

                instructor = ds.Tables[0];
                for (int j = 0; j < instructor.Rows.Count; j++)
                {

                    if (instructor.Rows[j]["instructor_code"].ToString() == "")
                    {
                        instructor.Rows[j].Delete();
                    }
                }
                instructor.AcceptChanges();
                instructor = RemoveDuplicateRows(instructor, "instructor_code");
                int re = 0;
                bool flag = true;
                for (int i = 0; i < instructor.Rows.Count; i++)
                {
                    re = re + 1;

                    DSC_userdataupload_WS.instructor_mstRow instructor_row = obj_userdataupload.instructor_mst.Newinstructor_mstRow();
                    instructor_row.doc_no = re.ToString();
                    instructor_row.instructor_code = instructor.Rows[i]["instructor_code"].ToString();
                    instructor_row.instructor_name = instructor.Rows[i]["instructor_name"].ToString();
                    instructor_row.designation = instructor.Rows[i]["designation"].ToString();
                    instructor_row.address = instructor.Rows[i]["address"].ToString();
                    instructor_row.phone_no = instructor.Rows[i]["phone_no"].ToString();
                    instructor_row.mobile_no = instructor.Rows[i]["mobile_no"].ToString();
                    DataTable year_code = objmaster.year_code_select(instructor.Rows[0]["year_code"].ToString());
                    if (year_code == null || year_code.Rows.Count == 0)
                    {
                        flag = false;
                        break;
                    }
                    instructor_row.year_code = year_code.Rows[0]["year_code"].ToString();
                    // instructor_row.mail_id = instructor.Rows[i]["mail_id"].ToString();
                    instructor_row.dob = Convert.ToDateTime(instructor.Rows[i]["dob"].ToString());
                    instructor_row.join_date = Convert.ToDateTime(instructor.Rows[i]["join_date"].ToString());
                    instructor_row.end_date = Convert.ToDateTime(instructor.Rows[i]["end_date"].ToString());
                    instructor_row.gender = instructor.Rows[i]["gender"].ToString().Substring(0, 1);
                    instructor_row.cancel_flag = "N";
                    instructor_row.created_by = HttpContext.Current.Session["UserId"].ToString();
                    instructor_row.created_date = System.DateTime.Now;
                    instructor_row.created_host = HttpContext.Current.Request.UserHostName;
                    instructor_row.last_modified_by = context.Session["UserId"].ToString();
                    instructor_row.last_modified_date = System.DateTime.Now;
                    instructor_row.last_modified_host = HttpContext.Current.Request.UserHostName;
                    obj_userdataupload.instructor_mst.Addinstructor_mstRow(instructor_row);
                }
                if (flag)
                    objBLReturnObject = objMaster.excel_data_uplad(obj_userdataupload, "2000", HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
                else
                    return "please check upload excel data";
            }
        }
        catch (Exception ex)
        {
            return "Problem In Saving Data";
        }
        return objBLReturnObject.ServerMessage;

    }

    #endregion

    #region //feedback

    [WebMethod(EnableSession = true)]
    public string Get_student_assigned_current_sem_data_for_feedback_dashboard()
    {
        BLL.Master.Masters obj_master = new BLL.Master.Masters();
        DataTable cur_sem = obj_master.Get_cept_current_sem_data("ws_feedback");

        string cur_feedback_sem = "";
        string cur_feedback_year = "";

        if (cur_sem != null)
        {
            cur_feedback_sem = cur_sem.Rows[0]["sem_code"].ToString();
            cur_feedback_year = cur_sem.Rows[0]["year_code"].ToString();
        }

        DataTable dt_allocation_publish_dtl = objmaster.get_allocation_publish_dtl(cur_feedback_sem, cur_feedback_year);
        if (dt_allocation_publish_dtl == null)
        {
            return jsondata;
        }

        DataTable get_feedback_disable_data = objmaster.get_feedback_disable_course_data(cur_feedback_sem, cur_feedback_year, "");

        string disable_course = MakeInQueryString(get_feedback_disable_data, "course_code");

        DataTable get_saved_data = objmaster.Get_student_assigned_current_sem_data_for_feedback(HttpContext.Current.Session["UserId"].ToString(), cur_feedback_sem, cur_feedback_year, disable_course);

        if (get_saved_data != null)
        {
            get_saved_data.Columns.Add("Status");
        }

        DataTable get_saved_feedbcak_data = objmaster.Get_student_saved_feedback_data_for_Feedback_dashboard("", HttpContext.Current.Session["UserId"].ToString(), cur_feedback_sem, cur_feedback_year);

        if (get_saved_feedbcak_data != null)
        {
            for (int i = 0; i < get_saved_data.Rows.Count; i++)
            {
                //string[] course = get_saved_data.Rows[i]["course"].ToString().Split('-');

                string[] course = get_saved_data.Rows[i]["course_code"].ToString().Split('~');

                DataRow[] dr = get_saved_feedbcak_data.Select("course_code = '" + course[0] + "'");

                if (dr.Length > 0)
                {
                    if (dr[0]["submit_status"].ToString() == "N")
                    {
                        if (dr[0]["last_modified_date"].ToString() != "")
                        {
                            get_saved_data.Rows[i]["Status"] = "Saved but not Complete";
                        }
                        else
                        {
                            get_saved_data.Rows[i]["Status"] = "Saved but not Complete";
                        }
                    }
                    else
                    {
                        if (dr[0]["last_modified_date"].ToString() != "")
                        {
                            get_saved_data.Rows[i]["Status"] = "Completed on " + dr[0]["last_modified_date"];
                        }
                        else
                        {
                            get_saved_data.Rows[i]["Status"] = "Completed on " + dr[0]["created_date"];
                        }
                    }
                }
                else
                {
                    get_saved_data.Rows[i]["Status"] = "Incomplete";

                }
            }
        }
        else
        {
            if (get_saved_data != null)
            {
                for (int i = 0; i < get_saved_data.Rows.Count; i++)
                {
                    get_saved_data.Rows[i]["Status"] = "Incomplete";
                }
            }
        }

        if (get_saved_data != null)
        {
            jsondata = GetJson1(get_saved_data);
        }

        return jsondata;
    }

    public interface a
    {
    }

    public sealed class abc
    {
    }

    public static class ab
    {
    }

    //public struct ab
    //{ 

    //}

    public struct abcd
    {
    }
    //<Summery> Change Course FeedBack Chart Hright 550-650 </Summery> By NitinBhai(19012021) 
    [WebMethod(EnableSession = true)]
    public string print_faculty_report_latest(string year_code, string sem_code, string course_type, string course_code, string dept_code, string selected_instructor)
    {
        try
        {
            //if (course_code != "" && course_type == "")
            //{
            //    DataTable dt_get_course_type = objmaster.Get_course_data_type_wise(sem_code, year_code, "", course_code, dept_code);

            //    if (dt_get_course_type != null)
            //    {
            //        if (dt_get_course_type.Rows[0]["course_typology"].ToString() == "3" || dt_get_course_type.Rows[0]["course_typology"].ToString() == "4")
            //        {
            //            course_type = "lecture";
            //        }

            //        if (dt_get_course_type.Rows[0]["course_typology"].ToString() == "5" || dt_get_course_type.Rows[0]["course_typology"].ToString() == "6")
            //        {
            //            course_type = "seminar";
            //        }

            //        if (dt_get_course_type.Rows[0]["course_typology"].ToString() == "7")
            //        {
            //            course_type = "studio";
            //        }

            //        if (dt_get_course_type.Rows[0]["course_typology"].ToString() == "9" || dt_get_course_type.Rows[0]["course_typology"].ToString() == "1" || dt_get_course_type.Rows[0]["course_typology"].ToString() == "8")
            //        {
            //            course_type = "workshop";
            //        }
            //    }
            //}

            string type_code = "";
            string department = "";
            string pdf_print_name = "";

            string semester = "";
            decimal total_course = 0;
            decimal total_instructor = 0;

            decimal faculty = 0;
            decimal cross_faculty = 0;



            decimal first_course_medain = 0, second_course_median = 0, three_course_median = 0, four_course_median = 0, five_course_median = 0, six_course_median = 0;

            //decimal first_course_medain_avg = 0, second_course_median = 0, three_course_median = 0, four_course_median = 0, five_course_median = 0, six_course_median = 0;



            decimal architecture_per = 0, design_per = 0, management_per = 0, planning_per = 0, technology_per = 0;

            decimal architecture_student = 0, design_student = 0, management_student = 0, planning_student = 0, technology_student = 0;



            decimal first_instructor_medain = 0, second_instructor_median = 0, three_instructor_median = 0, four_instructor_median = 0, five_instructor_median = 0, six_instructor_median = 0;


            decimal overall_feedback_rating = 0;


            DataTable dt_find_overall_course_median = new DataTable();



            dt_find_overall_course_median.Columns.Add("median_course");




            DataTable dt_find_overall_instructor_median = new DataTable();


            dt_find_overall_instructor_median.Columns.Add("median_instructor");




            //if (course_type == "lecture")
            //{
            //    type_code = "('3','4')";
            //}
            //else if (course_type == "seminar")
            //{
            //    type_code = "('5','6')";
            //}
            //else if (course_type == "studio")
            //{
            //    type_code = "('7')";
            //}
            //else if (course_type == "workshop")
            //{
            //    type_code = "('9','1','8')";
            //}
            //else
            //{
            //    type_code = "('3','4','5','6','7','9','1','8')";
            //}

            if (sem_code == "W")
            {
                semester = "Winter";
            }
            if (sem_code == "S")
            {
                semester = "Summer";
            }
            #region Retrieve Data

            DataTable dt_course_data = objmaster.Get_course_data_type_wise(sem_code, year_code, type_code, course_code, dept_code);

            DataTable dt_instructor_data = objmaster.Get_course_wise_instructor_data_for_feedback(sem_code, year_code, course_code);

            DataTable dt_total_student_course = objmaster.Get_total_student_fill_feedback_course_wise(course_code, sem_code, year_code);

            DataTable dt_total_student_instructor = objmaster.Get_total_student_fill_feedback_instructor_course_wise(course_code, sem_code, year_code);

            DataTable dt_all_feedback_data = objmaster.Get_all_feedback_data(sem_code, year_code, type_code, course_code);

            DataTable registration_data = objmaster.Get_Chart_data_for_registration(sem_code, year_code);

            DataTable cross_registration_data = objmaster.Get_Chart_data_for_cross_registration(sem_code, year_code);

            DataTable median_course_data = objmaster.Get_feedback_median_data(sem_code, year_code);

            DataTable dt_all_comment_text = objmaster.Get_all_text_from_feedback(sem_code, year_code, type_code, course_code);

            DataTable dt_feedback_instruction_data = objmaster.Get_feedback_instruction_mst_data_report(type_code, sem_code, year_code);
            #endregion

            string table = "";

            //if (dt_course_data == null || dt_all_feedback_data == null)
            //{
            //    return "course";
            //}

            if (dt_all_feedback_data == null)
            {
                return "Nofeedback";
            }

            if (dt_course_data == null)
            {
                return "course";
            }

            if (dt_instructor_data == null)
            {
                return "Instructor";
            }

            DataTable dt_feedback_calculation = new DataTable();
            DataRow dr_new_instruction;

            dt_feedback_calculation.Columns.Add("course_code");
            dt_feedback_calculation.Columns.Add("course_typology");
            dt_feedback_calculation.Columns.Add("dept_code");
            dt_feedback_calculation.Columns.Add("description");
            dt_feedback_calculation.Columns.Add("sr_no");
            dt_feedback_calculation.Columns.Add("instructor_code");
            dt_feedback_calculation.Columns.Add("total_allocate_student");
            dt_feedback_calculation.Columns.Add("total_feedback");
            dt_feedback_calculation.Columns.Add("total_average1_student");
            dt_feedback_calculation.Columns.Add("average1");
            dt_feedback_calculation.Columns.Add("overall_average1");
            dt_feedback_calculation.Columns.Add("total_average2_student");
            dt_feedback_calculation.Columns.Add("total_average2_value");
            dt_feedback_calculation.Columns.Add("average2");
            dt_feedback_calculation.Columns.Add("overall_average2");

            dt_feedback_calculation.Columns.Add("architecture_student");
            dt_feedback_calculation.Columns.Add("architecture_percentage");
            dt_feedback_calculation.Columns.Add("design_student");
            dt_feedback_calculation.Columns.Add("design_percentage");
            dt_feedback_calculation.Columns.Add("management_student");
            dt_feedback_calculation.Columns.Add("management_percentage");
            dt_feedback_calculation.Columns.Add("planning_student");
            dt_feedback_calculation.Columns.Add("planning_percentage");
            dt_feedback_calculation.Columns.Add("technology_student");
            dt_feedback_calculation.Columns.Add("technology_percentage");

            dt_feedback_calculation.Columns.Add("related_feedback");

            dt_feedback_calculation.Columns.Add("cancel_flag");
            dt_feedback_calculation.Columns.Add("status");
            dt_feedback_calculation.Columns.Add("created_date");
            dt_feedback_calculation.Columns.Add("created_by");
            dt_feedback_calculation.Columns.Add("created_host");

            dt_feedback_calculation.Columns.Add("semester_type");
            dt_feedback_calculation.Columns.Add("year_semester");

            DataTable dt_feedback_avrage2 = new DataTable();
            dt_feedback_avrage2.Columns.Add("dept_code");
            dt_feedback_avrage2.Columns.Add("course_typology_name");
            dt_feedback_avrage2.Columns.Add("related_feedback");
            dt_feedback_avrage2.Columns.Add("total_average2_student");
            dt_feedback_avrage2.Columns.Add("total_average2_value");
            dt_feedback_avrage2.Columns.Add("sr_no");
            dt_feedback_avrage2.Columns.Add("average2");
            dt_feedback_avrage2.Columns.Add("overall_average2");
            dt_feedback_avrage2.Columns.Add("cancel_flag");
            dt_feedback_avrage2.Columns.Add("status");
            dt_feedback_avrage2.Columns.Add("created_date");
            dt_feedback_avrage2.Columns.Add("created_by");
            dt_feedback_avrage2.Columns.Add("created_host");

            dt_feedback_avrage2.Columns.Add("semester_type");
            dt_feedback_avrage2.Columns.Add("year_semester");

            DataRow dr_feedback_avrage2;

            for (int i = 0; i < dt_course_data.Rows.Count; i++)
            {
                total_course = 0;
                total_instructor = 0;

                pdf_print_name = "";
                faculty = 0;
                cross_faculty = 0;

                architecture_per = design_per = management_per = planning_per = technology_per = 0;

                architecture_student = design_student = management_student = planning_student = technology_student = 0;

                department = "";

                dt_find_overall_course_median.Clear();

                first_course_medain = second_course_median = three_course_median = four_course_median = five_course_median = six_course_median = 0;




                string course_typology = "";


                //if (dt_course_data.Rows[i]["course_typology"].ToString() == "3" || dt_course_data.Rows[i]["course_typology"].ToString() == "4")
                //{
                //    course_type = "lecture";
                //}

                //if (dt_course_data.Rows[i]["course_typology"].ToString() == "5" || dt_course_data.Rows[i]["course_typology"].ToString() == "6")
                //{
                //    course_type = "seminar";
                //}

                //if (dt_course_data.Rows[i]["course_typology"].ToString() == "7")
                //{
                //    course_type = "studio";
                //}

                //if (dt_course_data.Rows[i]["course_typology"].ToString() == "9" || dt_course_data.Rows[i]["course_typology"].ToString() == "1" || dt_course_data.Rows[i]["course_typology"].ToString() == "8")
                //{
                //    course_type = "workshop";
                //}


                string course = dt_course_data.Rows[i]["course_code"].ToString();

                if (course == "2032")
                {

                }

                course_code = course;
                //if (course_type == "seminar")
                //{
                //    course_typology = "('5','6')";
                //}

                //else if (course_type == "studio")
                //{
                //    course_typology = "('7')";
                //}

                //else if (course_type == "workshop")
                //{
                //    course_typology = "('9','1','8')";
                //}
                //else if (course_type == "lecture")
                //{
                //    course_typology = "('3','4')";
                //}

                string total_allocate_user = dt_course_data.Rows[i]["total_allocate_user"].ToString();


                switch (Convert.ToInt16(dt_course_data.Rows[i]["dept_code"].ToString()))
                {
                    case 1:
                        department = "Faculty of Architecture";
                        pdf_print_name = "FA";
                        dept_code = "1";
                        break;

                    case 2:
                        department = "Faculty of Design";
                        pdf_print_name = "FD";
                        dept_code = "2";
                        break;

                    case 3:
                        department = "Faculty of Management";
                        pdf_print_name = "FM";
                        dept_code = "3";
                        break;

                    case 4:
                        department = "Faculty of Planning";
                        pdf_print_name = "FP";
                        dept_code = "4";
                        break;

                    case 5:
                        department = "Faculty of Technology";
                        pdf_print_name = "FT";
                        dept_code = "5";
                        break;

                    case 6:
                        department = "Centre of Excellence in Urban Transport";
                        pdf_print_name = "FC";
                        dept_code = "6";
                        break;

                }

                DataRow[] dr_instructor;


                if (selected_instructor != "")
                {
                    dr_instructor = dt_instructor_data.Select("course_code = '" + course + "' and instructor_code ='" + selected_instructor + "'");
                }
                else
                {
                    dr_instructor = dt_instructor_data.Select("course_code = '" + course + "'");
                }

                DataRow[] dr_feedback_course;

                DataRow[] dr_median_course;

                DataRow[] dr_total_couse = null;

                if (dt_total_student_course != null)
                {
                    dr_total_couse = dt_total_student_course.Select("course_code = '" + course + "'");

                    if (dr_total_couse.Length > 0)
                    {
                        total_course = Convert.ToDecimal(dr_total_couse[0]["total_user"]);
                    }
                }

                ////  DataRow[] dr_instruction_course = dt_feedback_instruction_data.Select("course_typology_name = '" + course_type + "' and feedback_type = 'course'");

                DataRow[] dr_instruction_course = dt_feedback_instruction_data.Select(" feedback_type = 'course'");

                dr_feedback_course = dt_all_feedback_data.Select("course_code = '" + course + "' and  releted_feedback = 'course'");

                if (dr_feedback_course.Length > 0)
                {

                    if (dr_instruction_course.Length > 0)
                    {
                        for (int sr_no = 0; sr_no < dr_instruction_course.Length; sr_no++)
                        {


                            dr_new_instruction = dt_feedback_calculation.NewRow();

                            dr_new_instruction["course_code"] = course_code;
                            ////  dr_new_instruction["course_typology"] = dt_course_data.Rows[i]["course_typology"].ToString();

                            dr_new_instruction["course_typology"] = "";
                            dr_new_instruction["dept_code"] = dept_code;
                            dr_new_instruction["description"] = dr_instruction_course[sr_no]["feedback_instruction"].ToString();
                            dr_new_instruction["sr_no"] = dr_instruction_course[sr_no]["sr_no"].ToString();
                            dr_new_instruction["instructor_code"] = "";
                            dr_new_instruction["total_allocate_student"] = total_allocate_user;
                            dr_new_instruction["total_feedback"] = 0;
                            dr_new_instruction["total_average1_student"] = total_course;
                            dr_new_instruction["average1"] = 0;
                            dr_new_instruction["overall_average1"] = 0;
                            dr_new_instruction["total_average2_student"] = 0;
                            dr_new_instruction["total_average2_value"] = 0;
                            dr_new_instruction["average2"] = 0;
                            dr_new_instruction["overall_average2"] = 0;
                            dr_new_instruction["related_feedback"] = dr_instruction_course[sr_no]["feedback_type"].ToString();
                            dr_new_instruction["semester_type"] = sem_code;
                            dr_new_instruction["year_semester"] = year_code;

                            //  dr_new_instruction["sr_no"] = dr_instruction[sr_no]["sr_no"].ToString();

                            dt_feedback_calculation.Rows.Add(dr_new_instruction);

                        }
                    }
                }

                ////  DataRow[] dr_instruction_instructor = dt_feedback_instruction_data.Select("course_typology_name = '" + course_type + "' and feedback_type = 'instructor'");
                DataRow[] dr_instruction_instructor = dt_feedback_instruction_data.Select(" feedback_type = 'instructor'");

                if (dr_instruction_instructor.Length > 0)
                {
                    if (dr_instructor.Length > 0)
                    {

                        for (int j = 0; j < dr_instructor.Length; j++)
                        {

                            string instructor_code = dr_instructor[j]["instructor_code"].ToString();

                            DataRow[] dr1 = dt_total_student_instructor.Select("course_code = '" + course_code + "' and instructor_code = '" + instructor_code + "'");

                            if (dr1.Length > 0)
                            {
                                for (int sr_no = 0; sr_no < dr_instruction_instructor.Length; sr_no++)
                                {


                                    dr_new_instruction = dt_feedback_calculation.NewRow();

                                    dr_new_instruction["course_code"] = course_code;
                                    ////dr_new_instruction["course_typology"] = dt_course_data.Rows[i]["course_typology"].ToString();

                                    dr_new_instruction["course_typology"] = "";
                                    dr_new_instruction["dept_code"] = dept_code;
                                    dr_new_instruction["description"] = dr_instruction_instructor[sr_no]["feedback_instruction"].ToString();
                                    dr_new_instruction["sr_no"] = dr_instruction_instructor[sr_no]["sr_no"].ToString();
                                    dr_new_instruction["instructor_code"] = instructor_code;
                                    dr_new_instruction["total_allocate_student"] = total_allocate_user;
                                    dr_new_instruction["total_feedback"] = 0;
                                    dr_new_instruction["total_average1_student"] = total_course;
                                    dr_new_instruction["average1"] = 0;
                                    dr_new_instruction["overall_average1"] = 0;
                                    dr_new_instruction["total_average2_student"] = 0;
                                    dr_new_instruction["total_average2_value"] = 0;
                                    dr_new_instruction["average2"] = 0;
                                    dr_new_instruction["overall_average2"] = 0;
                                    dr_new_instruction["related_feedback"] = dr_instruction_instructor[sr_no]["feedback_type"].ToString();
                                    dr_new_instruction["semester_type"] = sem_code;
                                    dr_new_instruction["year_semester"] = year_code;
                                    //  dr_new_instruction["sr_no"] = dr_instruction[sr_no]["sr_no"].ToString();

                                    dt_feedback_calculation.Rows.Add(dr_new_instruction);

                                }
                            }
                        }
                    }
                }


                decimal first = 0;


                if (dt_all_feedback_data != null)
                {



                    #region course average

                    // dr_feedback_course = dt_all_feedback_data.Select("course_code = '" + course + "' and  instructor_code = ''");
                    dr_feedback_course = dt_all_feedback_data.Select("course_code = '" + course + "' and  releted_feedback = 'course'");


                    if (dr_feedback_course.Length > 0)
                    {
                        for (int k = 0; k < dr_feedback_course.Length; k++)
                        {

                            DataRow[] dr_get_feedback = dt_feedback_calculation.Select("sr_no = '" + dr_feedback_course[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback ='course'");

                            if (dr_get_feedback.Length > 0)
                            {


                                if (dr_feedback_course[k]["strongly_agree"].ToString() == "Y")
                                {
                                    dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 5;
                                }
                                if (dr_feedback_course[k]["agree"].ToString() == "Y")
                                {
                                    dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 4;
                                }
                                if (dr_feedback_course[k]["neither_agree"].ToString() == "Y")
                                {
                                    dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                }
                                if (dr_feedback_course[k]["disagree"].ToString() == "Y")
                                {
                                    dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 2;
                                }
                                if (dr_feedback_course[k]["strongly_disagree"].ToString() == "Y")
                                {
                                    dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 1;
                                }
                                if (dr_feedback_course[k]["not_applicable"].ToString() == "Y")
                                {
                                    dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                }

                                dt_feedback_calculation.AcceptChanges();
                            }



                        }
                    }

                    //For calculate average1 and average2 of course 


                    DataRow[] dr_get_feedback_course = dt_feedback_calculation.Select("course_code = '" + course_code + "' and related_feedback = 'course'");
                    decimal total_course_average2_overall = 0;
                    decimal total_course_average1_overall = 0;

                    if (dr_get_feedback_course.Length > 0)
                    {
                        for (int k = 0; k < dr_get_feedback_course.Length; k++)
                        {

                            DataRow[] dr_get_feedback_value = dt_feedback_calculation.Select("sr_no = '" + dr_get_feedback_course[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback = 'course'");

                            if (total_course > 0)
                            {
                                if (dr_get_feedback_value.Length > 0)
                                {

                                    dr_get_feedback_value[0]["average1"] = Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_course, 1, MidpointRounding.AwayFromZero);

                                    total_course_average1_overall += Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_course, 1, MidpointRounding.AwayFromZero);
                                }
                            }

                            ////dr_median_course = median_course_data.Select("releted_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and course_type IN " + course_typology + " and dept_code ='" + dept_code + "'");


                            ////DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");


                            dr_median_course = median_course_data.Select("releted_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and  dept_code ='" + dept_code + "'");


                            DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");


                            if (dr_average2.Length == 0)
                            {



                                decimal total = 0;
                                decimal median_number = 0;
                                Decimal total_course_median_value = 0;


                                if (dr_median_course.Length > 0)
                                {
                                    total = dr_median_course.Length;

                                    median_number = (total + 1) / 2;

                                    string[] split_data = median_number.ToString().Split('.');


                                    for (int n = 0; n < dr_median_course.Length; n++)
                                    {
                                        total_course_median_value += Convert.ToDecimal(dr_median_course[n]["number"]);
                                    }

                                    dr_get_feedback_value[0]["total_average2_student"] = total;
                                    dr_get_feedback_value[0]["total_average2_value"] = total_course_median_value;

                                    dr_get_feedback_value[0]["average2"] = Math.Round(total_course_median_value / total, 1, MidpointRounding.AwayFromZero);

                                    dr_feedback_avrage2 = dt_feedback_avrage2.NewRow();

                                    dr_feedback_avrage2["dept_code"] = dept_code;

                                    dr_feedback_avrage2["course_typology_name"] = course_type;
                                    dr_feedback_avrage2["related_feedback"] = "course";

                                    dr_feedback_avrage2["total_average2_student"] = total;
                                    dr_feedback_avrage2["sr_no"] = dr_feedback_course[k]["sr_no"];
                                    dr_feedback_avrage2["total_average2_value"] = total_course_median_value;
                                    dr_feedback_avrage2["average2"] = Math.Round(total_course_median_value / total, 1, MidpointRounding.AwayFromZero);

                                    total_course_average2_overall += Math.Round(total_course_median_value / total, 1, MidpointRounding.AwayFromZero);

                                    dt_feedback_avrage2.Rows.Add(dr_feedback_avrage2);

                                }
                            }
                            else
                            {
                                dr_get_feedback_value[0]["total_average2_student"] = dr_average2[0]["total_average2_student"];
                                dr_get_feedback_value[0]["total_average2_value"] = dr_average2[0]["total_average2_value"];

                                dr_get_feedback_value[0]["average2"] = dr_average2[0]["average2"];
                                dr_get_feedback_value[0]["overall_average2"] = dr_average2[0]["overall_average2"];
                            }

                            dt_feedback_calculation.AcceptChanges();

                        }
                    }



                    if (dr_get_feedback_course.Length > 0)
                    {
                        for (int k = 0; k < dr_get_feedback_course.Length; k++)
                        {
                            //DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");

                            DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");

                            if (total_course_average2_overall > 0)
                            {
                                if (dr_average2.Length > 0)
                                {
                                    dr_average2[0]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                                }

                                dr_get_feedback_course[k]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                                dr_get_feedback_course[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                            }
                            else
                            {
                                dr_get_feedback_course[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                            }
                        }

                        dt_feedback_calculation.AcceptChanges();
                    }
                    #endregion
                }

                #region  course data for pie chart

                DataRow[] dr_reg = null;
                DataRow[] dr_cross_reg = null;

                DataRow[] dr_cross_reg_chart = null;


                decimal total_reg = 0;
                decimal total_cross_reg = 0;



                if (Convert.ToDecimal(total_allocate_user) > 0)
                {

                    if (registration_data != null)
                    {
                        dr_reg = registration_data.Select("course_code = '" + course + "'");

                        total_reg = dr_reg.Length;



                        if (cross_registration_data != null)
                        {
                            dr_cross_reg = cross_registration_data.Select("course_code = '" + course + "'");

                            total_cross_reg = dr_cross_reg.Length;

                            if (dr_cross_reg.Length > 0)
                            {
                                cross_faculty = Math.Round((dr_cross_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));



                                for (int k = 1; k <= 5; k++)
                                {
                                    dr_cross_reg_chart = cross_registration_data.Select("course_code = '" + course + "' and dept_code = '" + k + "'");

                                    if (dr_cross_reg_chart.Length > 0)
                                    {
                                        switch (k)
                                        {
                                            case 1:
                                                architecture_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                architecture_student = dr_cross_reg_chart.Length;
                                                break;
                                            case 2:
                                                design_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                design_student = dr_cross_reg_chart.Length;
                                                break;
                                            case 3:
                                                management_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                management_student = dr_cross_reg_chart.Length;
                                                break;
                                            case 4:
                                                planning_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                planning_student = dr_cross_reg_chart.Length;
                                                break;
                                            case 5:
                                                technology_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                technology_student = dr_cross_reg_chart.Length;
                                                break;
                                        }
                                    }
                                }
                            }
                        }

                        if (dr_reg.Length > 0)
                        {
                            switch (Convert.ToInt16(dr_reg[0]["dept_code"]))
                            {
                                case 1:
                                    architecture_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                    architecture_student = total_reg;
                                    break;
                                case 2:
                                    design_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                    design_student = total_reg;
                                    break;
                                case 3:
                                    management_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                    management_student = total_reg;
                                    break;
                                case 4:
                                    planning_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                    planning_student = total_reg;
                                    break;
                                case 5:
                                    technology_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                    technology_student = total_reg;
                                    break;
                            }

                            faculty = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                        }


                    }

                    DataRow[] dr_get_feedback = dt_feedback_calculation.Select("course_code = '" + course_code + "'");

                    for (int k = 0; k < dr_get_feedback.Length; k++)
                    {
                        dr_get_feedback[k]["architecture_student"] = architecture_student;
                        dr_get_feedback[k]["architecture_percentage"] = architecture_per;

                        dr_get_feedback[k]["design_student"] = design_student;
                        dr_get_feedback[k]["design_percentage"] = design_per;

                        dr_get_feedback[k]["management_student"] = management_student;
                        dr_get_feedback[k]["management_percentage"] = management_per;

                        dr_get_feedback[k]["planning_student"] = planning_student;
                        dr_get_feedback[k]["planning_percentage"] = planning_per;

                        dr_get_feedback[k]["technology_student"] = technology_student;
                        dr_get_feedback[k]["technology_percentage"] = technology_per;

                        dt_feedback_calculation.AcceptChanges();

                    }

                }

                #endregion


                for (int j = 0; j < dr_instructor.Length; j++)
                {

                    total_instructor = 0;

                    dt_find_overall_instructor_median.Clear();

                    first_instructor_medain = second_instructor_median = three_instructor_median = four_instructor_median = five_instructor_median = six_instructor_median = 0;

                    overall_feedback_rating = 0;

                    string instructor_code = dr_instructor[j]["instructor_code"].ToString();

                    DataRow[] dr_get_feedback_instructor = dt_feedback_calculation.Select("course_code = '" + course_code + "' and related_feedback = 'instructor' and instructor_code = '" + instructor_code + "'");

                    if (dr_get_feedback_instructor.Length > 0)
                    {
                        if (dt_all_feedback_data != null)
                        {

                            DataRow[] dr_total_instructor = dt_total_student_instructor.Select("course_code ='" + course + "' and instructor_code = '" + instructor_code + "'");
                            DataRow[] dr_feedback_instructor = dt_all_feedback_data.Select("course_code = '" + course + "' and  instructor_code = '" + instructor_code + "'");


                            if (dr_total_instructor.Length > 0)
                            {
                                total_instructor = Convert.ToDecimal(dr_total_instructor[0]["total"]);
                            }



                            #region instructor average
                            if (dr_feedback_instructor.Length > 0)
                            {
                                for (int k = 0; k < dr_feedback_instructor.Length; k++)
                                {
                                    DataRow[] dr_get_feedback = dt_feedback_calculation.Select("sr_no = '" + dr_feedback_instructor[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback ='instructor' and instructor_code = '" + instructor_code + "'");

                                    if (dr_get_feedback.Length > 0)
                                    {
                                        if (dr_feedback_instructor[k]["strongly_agree"].ToString() == "Y")
                                        {
                                            dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 5;
                                        }
                                        if (dr_feedback_instructor[k]["agree"].ToString() == "Y")
                                        {
                                            dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 4;
                                        }
                                        if (dr_feedback_instructor[k]["neither_agree"].ToString() == "Y")
                                        {
                                            dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                        }
                                        if (dr_feedback_instructor[k]["disagree"].ToString() == "Y")
                                        {
                                            dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 2;
                                        }
                                        if (dr_feedback_instructor[k]["strongly_disagree"].ToString() == "Y")
                                        {
                                            dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 1;
                                        }
                                        if (dr_feedback_instructor[k]["not_applicable"].ToString() == "Y")
                                        {
                                            dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                        }

                                        dt_feedback_calculation.AcceptChanges();


                                    }


                                }


                            }

                            #endregion



                            #region instructor median



                            decimal total_course_average2_overall = 0;
                            decimal total_course_average1_overall = 0;
                            if (dr_get_feedback_instructor.Length > 0)
                            {
                                for (int k = 0; k < dr_get_feedback_instructor.Length; k++)
                                {
                                    decimal total = 0;

                                    Decimal total_instructor_median_value = 0;

                                    DataRow[] dr_get_feedback_value = dt_feedback_calculation.Select("sr_no = '" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback = 'instructor' and instructor_code = '" + instructor_code + "'");

                                    if (total_instructor > 0)
                                    {
                                        if (dr_get_feedback_value.Length > 0)
                                        {
                                            dr_get_feedback_value[0]["total_average1_student"] = total_instructor;
                                            dr_get_feedback_value[0]["average1"] = Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_instructor, 1, MidpointRounding.AwayFromZero);

                                            total_course_average1_overall += Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_instructor, 1, MidpointRounding.AwayFromZero);
                                        }
                                    }



                                    ////DataRow[] dr_instructor_median = median_course_data.Select(" sr_no = '" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_type IN " + course_typology + " and dept_code ='" + dept_code + "' and instructor_code <> '' ", "sr_no ASC,number ASC");

                                    ////DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");

                                    DataRow[] dr_instructor_median = median_course_data.Select(" sr_no = '" + dr_get_feedback_instructor[k]["sr_no"] + "' and  dept_code ='" + dept_code + "' and instructor_code <> '' ", "sr_no ASC,number ASC");

                                    DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");


                                    if (dr_average2.Length == 0)
                                    {
                                        if (dr_instructor_median.Length > 0)
                                        {
                                            total = dr_instructor_median.Length;

                                            for (int n = 0; n < dr_instructor_median.Length; n++)
                                            {
                                                total_instructor_median_value += Convert.ToDecimal(dr_instructor_median[n]["number"]);
                                            }

                                            dr_get_feedback_value[0]["total_average2_student"] = total;
                                            dr_get_feedback_value[0]["total_average2_value"] = total_instructor_median_value;

                                            dr_get_feedback_value[0]["average2"] = Math.Round(total_instructor_median_value / total, 1, MidpointRounding.AwayFromZero);

                                            dr_feedback_avrage2 = dt_feedback_avrage2.NewRow();

                                            dr_feedback_avrage2["dept_code"] = dept_code;

                                            dr_feedback_avrage2["course_typology_name"] = course_type;
                                            dr_feedback_avrage2["related_feedback"] = "instructor";

                                            dr_feedback_avrage2["total_average2_student"] = total;
                                            dr_feedback_avrage2["sr_no"] = dr_get_feedback_instructor[k]["sr_no"];
                                            dr_feedback_avrage2["total_average2_value"] = total_instructor_median_value;
                                            dr_feedback_avrage2["average2"] = Math.Round(total_instructor_median_value / total, 1, MidpointRounding.AwayFromZero);

                                            total_course_average2_overall += Math.Round(total_instructor_median_value / total, 1, MidpointRounding.AwayFromZero);

                                            dt_feedback_avrage2.Rows.Add(dr_feedback_avrage2);

                                        }
                                    }
                                    else
                                    {
                                        dr_get_feedback_value[0]["total_average2_student"] = dr_average2[0]["total_average2_student"];
                                        dr_get_feedback_value[0]["total_average2_value"] = dr_average2[0]["total_average2_value"];

                                        dr_get_feedback_value[0]["average2"] = dr_average2[0]["average2"];
                                        dr_get_feedback_value[0]["overall_average2"] = dr_average2[0]["overall_average2"];
                                        dr_get_feedback_value[0]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                    }

                                    dt_feedback_calculation.AcceptChanges();

                                }
                            }


                            if (dr_get_feedback_instructor.Length > 0)
                            {
                                for (int k = 0; k < dr_get_feedback_instructor.Length; k++)
                                {
                                    ////DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");

                                    DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");

                                    if (total_course_average2_overall > 0)
                                    {
                                        dr_average2[0]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero); ;
                                        dr_get_feedback_instructor[k]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                        dr_get_feedback_instructor[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                    }
                                    else
                                    {

                                        dr_get_feedback_instructor[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                    }
                                }

                                dt_feedback_calculation.AcceptChanges();
                            }

                            #endregion
                        }

                    }

                    # region create run time table for all Course

                    string div = "";

                    if (dr_get_feedback_instructor.Length > 0)
                    {


                        div = "<div style='page-break-after: always;'> " +

                             //"<table  width='100%'><tr><td style='vertical-align: bottom;'><img style='float: left;margin-top: 5px;margin-left: -11px;' src='../../image/logo_new.png'/></td ><td align='center' style ='font-size: 25px; font-weight: bold;vertical-align: super;height:50px;padding-top: 0px;'>STUDENT FEEDBACK</td><td style ='font-size: 20px; font-weight: bold;vertical-align: bottom;'><b style=' float: right;width: 160px;'>" + semester + " - " + DateTime.Now.Year.ToString() + " </b></td><tr/> </table>" +
                             //"<table  width='100%'><tr><td><img style='float: left;height:50px;' src='../../image/Capture.PNG'/></td ><td align='center' style ='font-size: 25px; font-weight: bold;padding-top: 0px;vertical-align: super;'>STUDENT FEEDBACK</td><td style ='font-size: 20px; font-weight: bold;text-align: right;vertical-align: super;'><b style=' width: 160px;'>" + semester + " - " + DateTime.Now.Year.ToString() + " </b></td><tr/> </table>" +
                             "<table  width='100%'><tr><td><img style='float: left;height:50px;' src='../../image/Capture.PNG'/></td ><td align='center' style ='font-size: 25px; font-weight: bold;padding-top: 0px;vertical-align: super;'>STUDENT FEEDBACK</td><td style ='font-size: 20px; font-weight: bold;text-align: right;vertical-align: super;'><b style=' width: 160px;'>" + semester + " - " + year_code + " </b></td><tr/> </table>" +

                            "<table style='margin-top: 5px;'  width='100%'><tr><td style ='font-size: 16px; font-weight: bold; '>COURSE TITLE : " + dt_course_data.Rows[i]["course_name"] + " <td/><td align='right' style ='  font-size: 16px; font-weight: bold'>COURSE CODE : " + course + "</td></tr></table>" +


                        "<div style='border : 1px solid'><table   style=' width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px; font: 10px arial, san serif; border-collapse: collapse; border:0px solid #000000' cellpadding='0' cellspacing='0'  id='tbl_lecture' width='100%'>  <thead> </thead><tbody>" +

                           "<tr>";

                        if (course_type == "lecture")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Lecture </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Lecture </td> ";
                        }
                        else if (course_type == "studio")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Studio </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Studio </td> ";
                        }
                        else if (course_type == "seminar")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Seminar </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Seminar </td> ";
                        }
                        else if (course_type == "workshop")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Workshop </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Workshop </td> ";
                        }


                        div = div + " <td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='12'> FACULTY : " + department + " </td>  <td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:1;  background-color: white; color: black; height: 18px;' colspan='14'>NO OF    STUDENTS : " + total_allocate_user + " </td></tr> " +
                                    " <tr><td colspan='12'></td> " +
                                    "<td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;  background-color: white; color: black; height: 18px;' colspan='8'>NO OF RESPONDENTS : " + total_course + " </td> </tr> " +
                                    "</tbody> </table>  </div>";

                        div = div + "<div class='course' style = 'border: 1px solid; margin-bottom: 5px; margin-top: 5px;'>  <div style = 'margin-left: 20px;' id='" + (course + '-' + instructor_code) + "'></div> <script type='text/javascript'> ";

                        DataRow[] dr_get_feedback_course = dt_feedback_calculation.Select("course_code = '" + course_code + "' and related_feedback = 'course'");

                        div = div + "var dataSource = [";
                        if (dr_get_feedback_course.Length > 0)
                        {
                            div = div + "{name: '<div style=\"font-size: 15px;\">Overall Rating of Course </div>  <div style=\"font-weight: bold; font-size: 17px;\">" + Convert.ToDecimal(dr_get_feedback_course[0]["overall_average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[0]["overall_average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[0]["overall_average2"]).ToString("0.0") + ")},";
                            for (int k = dr_get_feedback_course.Length - 1; k >= 0; k--)
                            {
                                if (k == 0)
                                {
                                    div = div + " {name: '<div style=\"font-size: 15px;\">" + dr_get_feedback_course[k]["description"].ToString().Replace("'", "\\'") + "</div> <div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average2"]).ToString("0.0") + ")}";
                                }
                                else
                                {
                                    div = div + " {name: '<div style=\"font-size: 15px;\">" + dr_get_feedback_course[k]["description"].ToString().Replace("'", "\\'") + " </div> <div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average2"]).ToString("0.0") + ")},";
                                }
                            }
                        }

                        div = div + "];" +

                           "var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1', label: {visible: false,  precision: 1, horizontalOffset : 40   }  }," +
                           " {  argumentField: 'name', name :'Average2',   valueField: 'median',type: 'scatter', label: {visible: true,precision: 1, position : 'inside'  } }" +
                           "];" +



                          " $('#" + (course + '-' + instructor_code) + "').dxChart({ " +
                          " size: { height: 650 },  dataSource: dataSource,   series: series,  rotated:true, palette: 'Default'," +
                          //" size: { height: 300,  width: 650 },  dataSource: dataSource,   series: series,  rotated:true, palette: 'Default'," +
                          " valueAxis: { position: 'top',   min: 1,    max: 7 ,  tickInterval: 1 ,  valueMarginsEnabled: false}," +
                          //  "  title: {text: 'Course Feedback',font: { color: 'steelblue', family: 'Zapf-Chancery, cursive', size: 25, weight: 400,  horizontalAlignment: 'left' }, position :'leftTop'   }," +

                          "  title: {text: '<div style=\"font-weight: bold; font-size: 19px;\">Course Feedback</div>',font: { horizontalAlignment: 'center' ,opacity: 2} , position :'centerTop'  }," +
                          "  commonSeriesSettings: { argumentField: 'state', type: 'bar',   hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',      label: {  visible: false,format: 'fixedPoint'   , precision: 1 }  },    " +
                          " legend: {visible : false, verticalAlignment: 'bottom',  horizontalAlignment: 'center'} });</script></div>";
                        //" commonSeriesSettings: { argumentField: 'state', type: 'bar',  hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',    label: {  visible: true,format: 'fixedPoint', precision: 1 } },  series: [  { valueField: 'average', name: 'Avg' } ]," +
                        //"title: 'Course Feedback', legend: {visible : false, verticalAlignment: 'bottom',  horizontalAlignment: 'center'}, valueAxis: { position: 'top', min: 0,   max: 5  }, pointClick: function (point) {   this.select(); } , rotated: true}); </script>" +

                        //"<hr noshade width='100%'  size='8' style='margin-top:10px'>";


                        if (dr_get_feedback_instructor.Length > 0)
                        {
                            div = div + "<div style='border : 1px solid'><table  style=' width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px; font: 10px arial, san serif; border-collapse: collapse; border:0px solid #000000' cellpadding='0' cellspacing='0'  id='tbl_lecture'  width='100%'>  <thead> </thead><tbody>" +
                           "<tr> <td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='14'> <b>INSTRUCTOR NAME: " + dr_instructor[j]["instructor_name"] + "</b> </td>" +
                           "<td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='14'> <b>NO OF RESPONDENTS : " + total_instructor + " </b> </td> </tr></tbody></table></div>";


                            div = div + " <div class='instructor' style = 'border: 1px solid;border-top: 0;'> <div  style = 'margin-left: 20px;' id='" + (course + '-' + instructor_code + '-' + 1) + "'></div> <script type='text/javascript'>" +
                                        "var dataSource = [";


                            div = div + "{name: '<div style=\"font-size: 15px;\">Overall Rating of Instructor</div> <div style=\"font-weight: bold; font-size: 17px;\">" + Convert.ToDecimal(dr_get_feedback_instructor[0]["overall_average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[0]["overall_average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[0]["overall_average2"]).ToString("0.0") + ")},";

                            for (int k = dr_get_feedback_instructor.Length - 1; k >= 0; k--)
                            {

                                int desc_length = dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'").Length;

                                string instructor_desc = "";


                                //if (desc_length >= 65)
                                //{
                                //    instructor_desc += dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'").Substring(0, 65) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br/>";
                                //    instructor_desc += dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'").Substring(66);
                                //}
                                //else
                                //{
                                instructor_desc = dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'");
                                //}

                                if (k == 0)
                                {
                                    div = div + " {name: '<div style=\"font-size: 15px;\">" + instructor_desc + "</div><div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")}";

                                    //  div = div + " {name: '" + instructor_desc + "', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")}";

                                }

                                else
                                {
                                    div = div + " {name: '<div style=\"font-size: 15px;\">" + instructor_desc + " </div><div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")},";

                                    //div = div + " {name: '" + instructor_desc + "', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")},";
                                }
                            }





                            div = div + "];" +
                               //"var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1',  label: {visible: true,  precision: 1, horizontalOffset : 40   } }," +
                               "var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1',  label: {visible: true,precision: 1, position : 'inside'    } }," +
                                " {  argumentField: 'name', name :'Average2', valueField: 'median',type: 'scatter', label: {visible: true,precision: 1, position : 'inside' } }" +
                             "];" +


                             " $('#" + (course + '-' + instructor_code + '-' + 1) + "').dxChart({ " +
                                 //" size: { height: 300,  width: 700 },  dataSource: dataSource,series: series, " +
                                 " size: {  height: 650 }, dataSource: dataSource,series: series, " +
                                " valueAxis: { position: 'top',   min: 1,    max: 7 ,  tickInterval: 1 ,  valueMarginsEnabled: false}," +
                               " commonSeriesSettings: { argumentField: 'state', type: 'bar',  hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',    label: {  visible: true,format: 'fixedPoint', precision: 1 } }, " +
                              "  title: {text: '<div style=\"font-weight: bold; font-size: 19px;\">Instructor Feedback</div>',font: {   horizontalAlignment: 'center' }   }," +
                         "legend: {visible : false, verticalAlignment: 'bottom',  horizontalAlignment: 'center' },  rotated: true}); </script></div> ";


                        }

                        // "<hr noshade width='100%'  size='8' style='margin-top:10px'>";
                        div = div + "<table style='border: 1px solid;width: 100%;border-collapse: collapse; margin-top:5px; font-size:14px'><tbody> " +
                               "  <tr style='font-size: 12px;'><td align='left' colspan='7' style='font-size: 15px; font-weight: bold; font-style: italic'>STUDENTS REGISTERED BY FACULTY</td></tr> " +

                                   "<tr><td style='  border: 1px solid;padding-left: 5px; font-style: italic'>Name Of Faculty</td> <td style=' border: 1px solid;padding-left: 5px;font-style: italic'>FA " +
                               "<td style='border: 1px solid;padding-left: 5px;font-style: italic'>FD</td> " +
                                "<td style='  border: 1px solid;padding-left: 5px;font-style: italic'>FM</td>" +
                                 "  </td> <td style='border: 1px solid;padding-left: 5px;font-style: italic'>FP</td>" +
                               "<td style='  border: 1px solid;padding-left: 5px;font-style: italic'>FT</td>" +

                               "<td style='border: 1px solid; font-style: italic'>Total</td>" +
                               "</tr>" +
                               " <tr style='border: 1px solid; '>" +
                                 "<td style=' border: 1px solid;padding-left: 5px;font-style: italic' >No. of Students</td> " +
                               "<td style=' border: 1px solid;padding-left: 5px;' >" + architecture_student + "</td> " +
                                "<td style=' border: 1px solid;padding-left: 5px;' >" + design_student + "</td> " +
                                 "<td style=' border: 1px solid;padding-left: 5px;' >" + management_student + "</td> " +
                                  "<td style=' border: 1px solid;padding-left: 5px;' >" + planning_student + "</td> " +
                                   "<td style=' border: 1px solid;padding-left: 5px;' >" + technology_student + "</td> " +
                                    "<td style=' border: 1px solid;padding-left: 5px;' >" + Convert.ToDecimal(total_reg + total_cross_reg) + "</td> " +
                               "</tr>" +
                               "<tr style='border: 1px solid;'> " +
                               "<td style=' border: 1px solid;padding-left: 5px;font-style: italic' >Percentage(%)</td> " +
                               "<td style='border: 1px solid;padding-left: 5px;'>" + architecture_per + "</td> " +
                                 "<td style='border: 1px solid;padding-left: 5px;'>" + design_per + "</td> " +
                                   "<td style='border: 1px solid;padding-left: 5px;'>" + management_per + "</td> " +
                                     "<td style='border: 1px solid;padding-left: 5px;'>" + planning_per + "</td> " +
                                       "<td style='border: 1px solid;padding-left: 5px;'>" + technology_per + "</td> " +
                                         "<td style='border: 1px solid;padding-left: 5px;'>100%</td> " +
                               "</tr> " +
                               "</tbody></table>";

                        div = div + "<div style ='font-size: 14px; font-style: italic'> " +
                            "<div style=' margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/cor_avg.png'/><b>Course Average(COR AVG):</b>This is the average of the total responses for this course. For example, for Studio IV,out of total 32 students 28 have responded, the Average represents the mean of all 28 responses.</div> " +
                            "<div style=' margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/avg1.png'/><b>Individual Average(IND AVG):</b>This is the average score of  the total responses for this instructor. For example, for Studio IV,out of total 32 students 28 have responded, the Average represents the mean of all 28 responses.</div> " +
                                    "<div style='margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/avg2.png'/><b>Faculty Average(FAC AVG):</b> This is the average of all responses for similar course type within the Faculty.For example,Faculty average of Studio IV offered by FA,represents the mean of all responses for Studio courses offered in FA during the given semester.</div> " +


                                      "</div>" +
                                    "<div style='font-weight: bold; font-size: 14px; margin-top: 2px;'>Scale: 1 = least agreement with the statement, 5 = most agreement with the statement</div>" +
                                    "</div>";


                        div = div + "<div style='page-break-after: always;'> " +


                            "<table style='margin-top: 5px;'  width='100%'><tr><td style ='font-size: 16px; font-weight: bold; '>COURSE TITLE : " + dt_course_data.Rows[i]["course_name"] + " <td/><td align='right' style ='  font-size: 16px; font-weight: bold'>COURSE CODE : " + course + "</td></tr></table>" +


                        "<div style='border : 1px solid'><table   style=' width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px; font: 10px arial, san serif; border-collapse: collapse; border:0px solid #000000' cellpadding='0' cellspacing='0'  id='tbl_lecture' width='100%'>  <thead> </thead><tbody>" +

                           "<tr>";

                        if (course_type == "lecture")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Lecture </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Lecture </td> ";
                        }
                        else if (course_type == "studio")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Studio </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Studio </td> ";
                        }
                        else if (course_type == "seminar")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Seminar </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Seminar </td> ";
                        }
                        else if (course_type == "workshop")
                        {
                            //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Workshop </b> </td> ";
                            div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Workshop </td> ";
                        }


                        div = div + " <td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='12'> FACULTY : " + department + " </td>  <td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:1;  background-color: white; color: black; height: 18px;' colspan='14'>NO OF    STUDENTS : " + total_allocate_user + " </td></tr> " +
                                    " <tr><td colspan='12'></td> " +
                                    "<td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;  background-color: white; color: black; height: 18px;' colspan='8'>NO OF RESPONDENTS : " + total_course + " </td> </tr> " +
                                    "</tbody> </table>  </div>";




                        if (dt_all_comment_text != null)
                        {

                            DataRow[] dr_text = dt_all_comment_text.Select("course_code = '" + course + "' and releted_feedback = 'course'");

                            if (dr_text.Length > 0)
                            {
                                string row = "";
                                int row_data = 0;

                                for (int m = 0; m < dr_text.Length; m++)
                                {
                                    //if (dr_text[m]["course_aspect"].ToString() != "")
                                    //{
                                    //    row_data = row_data + 1;
                                    //    row = row + "<tr><td style='border:1px solid #393939;border-bottom:0; padding-left: 5px; '>" + row_data + "</td><td style='border:1px solid #393939;border-bottom:0; padding-left: 5px;'>" + dr_text[m]["course_aspect"].ToString() + "</td></tr>";
                                    //}

                                    //if (dr_text[m]["course_suggestion"].ToString() != "")
                                    //{
                                    //    row_data = row_data + 1;
                                    //    row = row + "<tr><td style='border:1px solid #393939;border-bottom:0; padding-left: 5px;'>" + row_data + "</td><td style='border:1px solid #393939;border-bottom:0; padding-left: 5px;' >" + dr_text[m]["course_suggestion"].ToString() + "</td></tr>";
                                    //}


                                    if (dr_text[m]["comments"].ToString() != "")
                                    {
                                        row_data = row_data + 1;
                                        row = row + "<tr style='border: 1px solid;'><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;'><center>" + row_data + "</center></td><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;' >" + dr_text[m]["comments"].ToString() + "</td></tr>";
                                    }
                                }



                                div = div + "<div><p class='small' style='line-height: 12px; font-size: 20px;font-family: Segoe UI Light, Helvetica Neue Light, Segoe UI, Helvetica Neue, Trebuchet MS, Verdana;'><b> Course Comments </b></p> </div>" +
                                "<table style='font: 15px arial, san serif; border-collapse: collapse; border:1px solid;' cellpadding='0' cellspacing='0' id='tbl_lecture'  width='100%'> " +
                                 "<tbody><tr style='border: 1px solid;'><td style='border:1px solid; width: 42px; padding: 4px 7px;'><center> Sr No.</center></td> <td style='border:1px solid;'> <center>Comments </center> </td> </tr> " + row + "</tbody></table>";

                            }

                            dr_text = dt_all_comment_text.Select("course_code = '" + course + "' and releted_feedback = 'instructor' and instructor_code ='" + instructor_code + "'");


                            if (dr_text.Length > 0)
                            {
                                string row = "";
                                int row_data = 0;

                                for (int m = 0; m < dr_text.Length; m++)
                                {

                                    if (dr_text[m]["comments"].ToString() != "")
                                    {
                                        row_data = row_data + 1;
                                        row = row + "<tr style='border: 1px solid;'><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;'><center>" + row_data + "</center></td><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;' >" + dr_text[m]["comments"].ToString() + "</td></tr>";
                                    }
                                }


                                div = div + "<div><p class='small' style='line-height: 12px; font-size: 20px; font-family: Segoe UI Light, Helvetica Neue Light, Segoe UI, Helvetica Neue, Trebuchet MS, Verdana;'><b>Instructor Comments </b></p> </div>" +
                                    "<div style='font: 10px arial, san serif; font-size: 15px; font-style: italic;  color: black; height: 18px;' colspan='14'> <b>Instructor Name: " + dr_instructor[j]["instructor_name"] + "</b> </div>" +
                                "<table style='font: 15px arial, san serif; border-collapse: collapse; border:1px solid ' cellpadding='0' cellspacing='0' id='tbl_lecture'  width='100%'> " +
                                 "<tbody><tr style='border: 1px solid;'><td style='border:1px solid;border-bottom:0;width: 42px; padding: 4px 7px;'><center> Sr No.</center></td> <td style='border:1px solid;'> <center>Comments </center> </td> </tr> " + row + "</tbody></table>";

                            }
                        }

                        div = div + "<div style ='font-size: 15px;'>Comments are reproduced verbatim from the feedback received</div>";



                        div = div + " </div>";



                        ///  Boolean status = objmaster.Insert_feedback_chart_data(course_code, instructor_code, j + 1, div.Replace("'", "''"), sem_code, year_code);


                    }



                    table = table + div;



                    ////   //  HttpContext.Current.Session["Feedback_data"] = div;

                    //    BLL.ExtraUtilities1.ReportPrinter obReportPrinter = new BLL.ExtraUtilities1.ReportPrinter();

                    //////   ReportPrinter obReportPrinter = new ReportPrinter();
                    ////     JavaScriptSerializer ser = new JavaScriptSerializer();

                    ////  //   ReportPrinter 
                    ////     Dictionary<string, object> sessionData = new Dictionary<string, object>();

                    ////     foreach (string key in Session.Keys)
                    ////     {
                    ////         sessionData[key] = Session[key];
                    ////     }

                    ////   //  obReportPrinter.SetSession(ser.Serialize(sessionData));

                    //////  obReportPrinter.PageFile = "https://localhost:17675/CEPT/Admin/Master/Download_feedback_PDF.aspx?course_code=" + course_code + "&instructor_code=" + instructor_code + "&semester_type=" + current_ws_sem + "&year_semester=" + current_ws_year;

                    ////////////    obReportPrinter.FooterFile = root + "HeaderFooter/Footer.html";

                    //////     obReportPrinter.GetPdf();

                    //////     if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
                    //////     {
                    //////         HttpContext.Current.Response.ContentType = "application/octet-stream";
                    //////         HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", course_code + "_" + instructor_code + ".pdf"));
                    //////         HttpContext.Current.Response.BinaryWrite(obReportPrinter.FileContent);
                    //////     }

                    #endregion

                    //   pdf_print_name += "_" + course_code + "_" + dt_course_data.Rows[i]["course_name"] + "_" + dr_instructor[j]["instructor_name"] + "_" + semester + "_" + year_code;

                    pdf_print_name += "_" + course_code + "_" + dr_instructor[j]["instructor_name"] + "_" + semester + "_" + year_code;
                }


            }


            if (dt_feedback_calculation != null)
            {


                if (dt_feedback_calculation.Rows.Count > 0)
                {
                    for (int i = 0; i < dt_feedback_calculation.Rows.Count; i++)
                    {
                        DataRow feedback_calculation = dt_feedback_calculation.Rows[i];

                        feedback_calculation["cancel_flag"] = "N";
                        feedback_calculation["status"] = "Y";
                        feedback_calculation["created_date"] = System.DateTime.Now;
                        feedback_calculation["created_by"] = HttpContext.Current.Session["UserId"].ToString();
                        feedback_calculation["created_host"] = HttpContext.Current.Request.UserHostName;


                        obj_feedback_calculation.ws_feedback_calculation.ImportRow(feedback_calculation);
                    }
                }

                if (dt_feedback_avrage2 != null)
                {
                    if (dt_feedback_avrage2.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt_feedback_avrage2.Rows.Count; i++)
                        {
                            DataRow feedback_calculation_average2 = dt_feedback_avrage2.Rows[i];

                            feedback_calculation_average2["cancel_flag"] = "N";
                            feedback_calculation_average2["status"] = "Y";
                            feedback_calculation_average2["created_date"] = System.DateTime.Now;
                            feedback_calculation_average2["created_by"] = HttpContext.Current.Session["UserId"].ToString();
                            feedback_calculation_average2["created_host"] = HttpContext.Current.Request.UserHostName;

                            feedback_calculation_average2["semester_type"] = sem_code;
                            feedback_calculation_average2["year_semester"] = year_code;

                            obj_feedback_calculation.ws_feedback_calculation_average2.ImportRow(feedback_calculation_average2);
                        }
                    }
                }
            }


            objBLReturnObject = objMaster.save_feedback_calculation_data(obj_feedback_calculation, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);

            DataTable dt = new DataTable();

            dt.Columns.Add("table");

            dt.Columns.Add("message");

            DataRow dr;

            dr = dt.NewRow();

            dr["table"] = table;

            dr["message"] = "";

            if (objBLReturnObject.ExecutionStatus == 1)
            {
                dr["message"] = 1;
            }
            else
            {
                dr["message"] = objBLReturnObject.ServerMessage.ToString();
            }

            dt.Rows.Add(dr);



            //string s = "";
            //byte[] fileContent = Encoding.ASCII.GetBytes("<html><body>" + table + "</body></html>");

            //FileStream fs = File.Create(Server.MapPath("~/PDF/HTML/TempHtml.html"));
            //fs.Write(fileContent, 0, fileContent.Length);
            //fs.Flush();
            //fs.Close();

            ////if (Directory.Exists(HttpContext.Current.Server.MapPath(("~/PDF/") + jobid)))
            ////{

            ////}
            ////else
            ////{

            ////    //   Directory.CreateDirectory(HttpContext.Current.Server.MapPath("~/PDF/") + jobid);

            ////}


            //ReportPrinter obReportPrinter = new ReportPrinter();

            ////obReportPrinter.PathToSave = HttpContext.Current.Server.MapPath(("~/PDF/") + jobid + "/");
            //obReportPrinter.PathToSave = HttpContext.Current.Server.MapPath("~/UploadFiles/");
            //obReportPrinter.PageFile = Server.MapPath("~/PDF/HTML/TempHtml.html");

            //string pdf = obReportPrinter.GetPdf();

            //if (pdf != null)
            //{
            //    //HttpContext.Current.Response.ContentType = "application/octet-stream";
            //    //HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", pdf.Split('\\')[pdf.Split('\\').Length - 1]));
            //    //HttpContext.Current.Response.WriteFile(pdf);
            //}
            //return pdf.Split('\\')[pdf.Split('\\').Length - 1];


            jsondata = GetJson1(dt);

            Dictionary<string, string> return_data = new Dictionary<string, string>();

            return_data["div_data"] = jsondata;
            return_data["pdf_print_name"] = "";
            if (selected_instructor != "")
            {
                return_data["pdf_print_name"] = pdf_print_name;
            }

            JavaScriptSerializer ser = new JavaScriptSerializer();

            return ser.Serialize(return_data);

        }
        catch (Exception ex)
        {

            return ex.ToString();
        }
    }




    [WebMethod(EnableSession = true)]
    //[WebMethod]
    public string print_faculty_report_latest_new(string year_code, string sem_code, string course_type, string course_code, string dept_code, string selected_instructor)
    {
        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            Dictionary<string, string> return_data = new Dictionary<string, string>();
            //List<Dictionary<string, string>> course_data = ser.Deserialize<List<Dictionary<string, string>>>(course_code);

            //for (int p = 0; p < course_data.Count; p++)
            //{

                //course_code = course_data[p]["course_code"].ToString();
                //selected_instructor = course_data[p]["instructor_code"].ToString();

                string type_code = "";
                string department = "";
                string pdf_print_name = "";

                string semester = "";
                decimal total_course = 0;
                decimal total_instructor = 0;

                decimal faculty = 0;
                decimal cross_faculty = 0;

                decimal first_course_medain = 0, second_course_median = 0, three_course_median = 0, four_course_median = 0, five_course_median = 0, six_course_median = 0;

                //decimal first_course_medain_avg = 0, second_course_median = 0, three_course_median = 0, four_course_median = 0, five_course_median = 0, six_course_median = 0;
                decimal architecture_per = 0, design_per = 0, management_per = 0, planning_per = 0, technology_per = 0;

                decimal architecture_student = 0, design_student = 0, management_student = 0, planning_student = 0, technology_student = 0;

                decimal first_instructor_medain = 0, second_instructor_median = 0, three_instructor_median = 0, four_instructor_median = 0, five_instructor_median = 0, six_instructor_median = 0;


                decimal overall_feedback_rating = 0;

                DataTable dt_find_overall_course_median = new DataTable();

                dt_find_overall_course_median.Columns.Add("median_course");

                DataTable dt_find_overall_instructor_median = new DataTable();

                dt_find_overall_instructor_median.Columns.Add("median_instructor");

                if (sem_code == "W")
                {
                    semester = "Winter";
                }
                if (sem_code == "S")
                {
                    semester = "Summer";
                }
                #region Retrieve Data

                DataTable dt_course_data = objmaster.Get_course_data_type_wise(sem_code, year_code, type_code, course_code, dept_code);

                DataTable dt_instructor_data = objmaster.Get_course_wise_instructor_data_for_feedback(sem_code, year_code, course_code);

                DataTable dt_total_student_course = objmaster.Get_total_student_fill_feedback_course_wise(course_code, sem_code, year_code);

                DataTable dt_total_student_instructor = objmaster.Get_total_student_fill_feedback_instructor_course_wise(course_code, sem_code, year_code);

                DataTable dt_all_feedback_data = objmaster.Get_all_feedback_data(sem_code, year_code, type_code, course_code);

                DataTable registration_data = objmaster.Get_Chart_data_for_registration(sem_code, year_code);

                DataTable cross_registration_data = objmaster.Get_Chart_data_for_cross_registration(sem_code, year_code);

                DataTable median_course_data = objmaster.Get_feedback_median_data(sem_code, year_code);

                DataTable dt_all_comment_text = objmaster.Get_all_text_from_feedback(sem_code, year_code, type_code, course_code);

                DataTable dt_feedback_instruction_data = objmaster.Get_feedback_instruction_mst_data_report(type_code, sem_code, year_code);
                #endregion

                string table = "";

                //if (dt_course_data == null || dt_all_feedback_data == null)
                //{
                //    return "course";
                //}

                if (dt_all_feedback_data == null)
                {
                    return "Nofeedback";
                }

                if (dt_course_data == null)
                {
                    return "course";
                }

                if (dt_instructor_data == null)
                {
                    return "Instructor";
                }

                DataTable dt_feedback_calculation = new DataTable();
                DataRow dr_new_instruction;

                dt_feedback_calculation.Columns.Add("course_code");
                dt_feedback_calculation.Columns.Add("course_typology");
                dt_feedback_calculation.Columns.Add("dept_code");
                dt_feedback_calculation.Columns.Add("description");
                dt_feedback_calculation.Columns.Add("sr_no");
                dt_feedback_calculation.Columns.Add("instructor_code");
                dt_feedback_calculation.Columns.Add("total_allocate_student");
                dt_feedback_calculation.Columns.Add("total_feedback");
                dt_feedback_calculation.Columns.Add("total_average1_student");
                dt_feedback_calculation.Columns.Add("average1");
                dt_feedback_calculation.Columns.Add("overall_average1");
                dt_feedback_calculation.Columns.Add("total_average2_student");
                dt_feedback_calculation.Columns.Add("total_average2_value");
                dt_feedback_calculation.Columns.Add("average2");
                dt_feedback_calculation.Columns.Add("overall_average2");

                dt_feedback_calculation.Columns.Add("architecture_student");
                dt_feedback_calculation.Columns.Add("architecture_percentage");
                dt_feedback_calculation.Columns.Add("design_student");
                dt_feedback_calculation.Columns.Add("design_percentage");
                dt_feedback_calculation.Columns.Add("management_student");
                dt_feedback_calculation.Columns.Add("management_percentage");
                dt_feedback_calculation.Columns.Add("planning_student");
                dt_feedback_calculation.Columns.Add("planning_percentage");
                dt_feedback_calculation.Columns.Add("technology_student");
                dt_feedback_calculation.Columns.Add("technology_percentage");

                dt_feedback_calculation.Columns.Add("related_feedback");

                dt_feedback_calculation.Columns.Add("cancel_flag");
                dt_feedback_calculation.Columns.Add("status");
                dt_feedback_calculation.Columns.Add("created_date");
                dt_feedback_calculation.Columns.Add("created_by");
                dt_feedback_calculation.Columns.Add("created_host");

                dt_feedback_calculation.Columns.Add("semester_type");
                dt_feedback_calculation.Columns.Add("year_semester");

                DataTable dt_feedback_avrage2 = new DataTable();
                dt_feedback_avrage2.Columns.Add("dept_code");
                dt_feedback_avrage2.Columns.Add("course_typology_name");
                dt_feedback_avrage2.Columns.Add("related_feedback");
                dt_feedback_avrage2.Columns.Add("total_average2_student");
                dt_feedback_avrage2.Columns.Add("total_average2_value");
                dt_feedback_avrage2.Columns.Add("sr_no");
                dt_feedback_avrage2.Columns.Add("average2");
                dt_feedback_avrage2.Columns.Add("overall_average2");
                dt_feedback_avrage2.Columns.Add("cancel_flag");
                dt_feedback_avrage2.Columns.Add("status");
                dt_feedback_avrage2.Columns.Add("created_date");
                dt_feedback_avrage2.Columns.Add("created_by");
                dt_feedback_avrage2.Columns.Add("created_host");

                dt_feedback_avrage2.Columns.Add("semester_type");
                dt_feedback_avrage2.Columns.Add("year_semester");

                DataRow dr_feedback_avrage2;

                for (int i = 0; i < dt_course_data.Rows.Count; i++)
                {
                    total_course = 0;
                    total_instructor = 0;

                    pdf_print_name = "";
                    faculty = 0;
                    cross_faculty = 0;

                    architecture_per = design_per = management_per = planning_per = technology_per = 0;

                    architecture_student = design_student = management_student = planning_student = technology_student = 0;

                    department = "";

                    dt_find_overall_course_median.Clear();

                    first_course_medain = second_course_median = three_course_median = four_course_median = five_course_median = six_course_median = 0;

                    string course_typology = "";
                    string course = dt_course_data.Rows[i]["course_code"].ToString();

                    if (course == "2032")
                    {

                    }

                    course_code = course;
                    

                    string total_allocate_user = dt_course_data.Rows[i]["total_allocate_user"].ToString();


                    switch (Convert.ToInt16(dt_course_data.Rows[i]["dept_code"].ToString()))
                    {
                        case 1:
                            department = "Faculty of Architecture";
                            pdf_print_name = "FA";
                            dept_code = "1";
                            break;

                        case 2:
                            department = "Faculty of Design";
                            pdf_print_name = "FD";
                            dept_code = "2";
                            break;

                        case 3:
                            department = "Faculty of Management";
                            pdf_print_name = "FM";
                            dept_code = "3";
                            break;

                        case 4:
                            department = "Faculty of Planning";
                            pdf_print_name = "FP";
                            dept_code = "4";
                            break;

                        case 5:
                            department = "Faculty of Technology";
                            pdf_print_name = "FT";
                            dept_code = "5";
                            break;

                        case 6:
                            department = "Centre of Excellence in Urban Transport";
                            pdf_print_name = "FC";
                            dept_code = "6";
                            break;

                    }

                    DataRow[] dr_instructor;


                    if (selected_instructor != "")
                    {
                        dr_instructor = dt_instructor_data.Select("course_code = '" + course + "' and instructor_code ='" + selected_instructor + "'");
                    }
                    else
                    {
                        dr_instructor = dt_instructor_data.Select("course_code = '" + course + "'");
                    }

                    DataRow[] dr_feedback_course;

                    DataRow[] dr_median_course;

                    DataRow[] dr_total_couse = null;

                    if (dt_total_student_course != null)
                    {
                        dr_total_couse = dt_total_student_course.Select("course_code = '" + course + "'");

                        if (dr_total_couse.Length > 0)
                        {
                            total_course = Convert.ToDecimal(dr_total_couse[0]["total_user"]);
                        }
                    }

                    ////  DataRow[] dr_instruction_course = dt_feedback_instruction_data.Select("course_typology_name = '" + course_type + "' and feedback_type = 'course'");

                    DataRow[] dr_instruction_course = dt_feedback_instruction_data.Select(" feedback_type = 'course'");

                    dr_feedback_course = dt_all_feedback_data.Select("course_code = '" + course + "' and  releted_feedback = 'course'");

                    if (dr_feedback_course.Length > 0)
                    {

                        if (dr_instruction_course.Length > 0)
                        {
                            for (int sr_no = 0; sr_no < dr_instruction_course.Length; sr_no++)
                            {


                                dr_new_instruction = dt_feedback_calculation.NewRow();

                                dr_new_instruction["course_code"] = course_code;
                                ////  dr_new_instruction["course_typology"] = dt_course_data.Rows[i]["course_typology"].ToString();

                                dr_new_instruction["course_typology"] = "";
                                dr_new_instruction["dept_code"] = dept_code;
                                dr_new_instruction["description"] = dr_instruction_course[sr_no]["feedback_instruction"].ToString();
                                dr_new_instruction["sr_no"] = dr_instruction_course[sr_no]["sr_no"].ToString();
                                dr_new_instruction["instructor_code"] = "";
                                dr_new_instruction["total_allocate_student"] = total_allocate_user;
                                dr_new_instruction["total_feedback"] = 0;
                                dr_new_instruction["total_average1_student"] = total_course;
                                dr_new_instruction["average1"] = 0;
                                dr_new_instruction["overall_average1"] = 0;
                                dr_new_instruction["total_average2_student"] = 0;
                                dr_new_instruction["total_average2_value"] = 0;
                                dr_new_instruction["average2"] = 0;
                                dr_new_instruction["overall_average2"] = 0;
                                dr_new_instruction["related_feedback"] = dr_instruction_course[sr_no]["feedback_type"].ToString();
                                dr_new_instruction["semester_type"] = sem_code;
                                dr_new_instruction["year_semester"] = year_code;

                                //  dr_new_instruction["sr_no"] = dr_instruction[sr_no]["sr_no"].ToString();

                                dt_feedback_calculation.Rows.Add(dr_new_instruction);

                            }
                        }
                    }

                    ////  DataRow[] dr_instruction_instructor = dt_feedback_instruction_data.Select("course_typology_name = '" + course_type + "' and feedback_type = 'instructor'");
                    DataRow[] dr_instruction_instructor = dt_feedback_instruction_data.Select(" feedback_type = 'instructor'");

                    if (dr_instruction_instructor.Length > 0)
                    {
                        if (dr_instructor.Length > 0)
                        {

                            for (int j = 0; j < dr_instructor.Length; j++)
                            {

                                string instructor_code = dr_instructor[j]["instructor_code"].ToString();

                                DataRow[] dr1 = dt_total_student_instructor.Select("course_code = '" + course_code + "' and instructor_code = '" + instructor_code + "'");

                                if (dr1.Length > 0)
                                {
                                    for (int sr_no = 0; sr_no < dr_instruction_instructor.Length; sr_no++)
                                    {


                                        dr_new_instruction = dt_feedback_calculation.NewRow();

                                        dr_new_instruction["course_code"] = course_code;
                                        ////dr_new_instruction["course_typology"] = dt_course_data.Rows[i]["course_typology"].ToString();

                                        dr_new_instruction["course_typology"] = "";
                                        dr_new_instruction["dept_code"] = dept_code;
                                        dr_new_instruction["description"] = dr_instruction_instructor[sr_no]["feedback_instruction"].ToString();
                                        dr_new_instruction["sr_no"] = dr_instruction_instructor[sr_no]["sr_no"].ToString();
                                        dr_new_instruction["instructor_code"] = instructor_code;
                                        dr_new_instruction["total_allocate_student"] = total_allocate_user;
                                        dr_new_instruction["total_feedback"] = 0;
                                        dr_new_instruction["total_average1_student"] = total_course;
                                        dr_new_instruction["average1"] = 0;
                                        dr_new_instruction["overall_average1"] = 0;
                                        dr_new_instruction["total_average2_student"] = 0;
                                        dr_new_instruction["total_average2_value"] = 0;
                                        dr_new_instruction["average2"] = 0;
                                        dr_new_instruction["overall_average2"] = 0;
                                        dr_new_instruction["related_feedback"] = dr_instruction_instructor[sr_no]["feedback_type"].ToString();
                                        dr_new_instruction["semester_type"] = sem_code;
                                        dr_new_instruction["year_semester"] = year_code;
                                        //  dr_new_instruction["sr_no"] = dr_instruction[sr_no]["sr_no"].ToString();

                                        dt_feedback_calculation.Rows.Add(dr_new_instruction);

                                    }
                                }
                            }
                        }
                    }


                    decimal first = 0;


                    if (dt_all_feedback_data != null)
                    {



                        #region course average

                        // dr_feedback_course = dt_all_feedback_data.Select("course_code = '" + course + "' and  instructor_code = ''");
                        dr_feedback_course = dt_all_feedback_data.Select("course_code = '" + course + "' and  releted_feedback = 'course'");


                        if (dr_feedback_course.Length > 0)
                        {
                            for (int k = 0; k < dr_feedback_course.Length; k++)
                            {

                                DataRow[] dr_get_feedback = dt_feedback_calculation.Select("sr_no = '" + dr_feedback_course[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback ='course'");

                                if (dr_get_feedback.Length > 0)
                                {


                                    if (dr_feedback_course[k]["strongly_agree"].ToString() == "Y")
                                    {
                                        dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 5;
                                    }
                                    if (dr_feedback_course[k]["agree"].ToString() == "Y")
                                    {
                                        dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 4;
                                    }
                                    if (dr_feedback_course[k]["neither_agree"].ToString() == "Y")
                                    {
                                        dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                    }
                                    if (dr_feedback_course[k]["disagree"].ToString() == "Y")
                                    {
                                        dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 2;
                                    }
                                    if (dr_feedback_course[k]["strongly_disagree"].ToString() == "Y")
                                    {
                                        dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 1;
                                    }
                                    if (dr_feedback_course[k]["not_applicable"].ToString() == "Y")
                                    {
                                        dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                    }

                                    dt_feedback_calculation.AcceptChanges();
                                }



                            }
                        }

                        //For calculate average1 and average2 of course 


                        DataRow[] dr_get_feedback_course = dt_feedback_calculation.Select("course_code = '" + course_code + "' and related_feedback = 'course'");
                        decimal total_course_average2_overall = 0;
                        decimal total_course_average1_overall = 0;

                        if (dr_get_feedback_course.Length > 0)
                        {
                            for (int k = 0; k < dr_get_feedback_course.Length; k++)
                            {

                                DataRow[] dr_get_feedback_value = dt_feedback_calculation.Select("sr_no = '" + dr_get_feedback_course[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback = 'course'");

                                if (total_course > 0)
                                {
                                    if (dr_get_feedback_value.Length > 0)
                                    {

                                        dr_get_feedback_value[0]["average1"] = Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_course, 1, MidpointRounding.AwayFromZero);

                                        total_course_average1_overall += Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_course, 1, MidpointRounding.AwayFromZero);
                                    }
                                }

                                ////dr_median_course = median_course_data.Select("releted_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and course_type IN " + course_typology + " and dept_code ='" + dept_code + "'");


                                ////DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");


                                dr_median_course = median_course_data.Select("releted_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and  dept_code ='" + dept_code + "'");


                                DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");


                                if (dr_average2.Length == 0)
                                {



                                    decimal total = 0;
                                    decimal median_number = 0;
                                    Decimal total_course_median_value = 0;


                                    if (dr_median_course.Length > 0)
                                    {
                                        total = dr_median_course.Length;

                                        median_number = (total + 1) / 2;

                                        string[] split_data = median_number.ToString().Split('.');


                                        for (int n = 0; n < dr_median_course.Length; n++)
                                        {
                                            total_course_median_value += Convert.ToDecimal(dr_median_course[n]["number"]);
                                        }

                                        dr_get_feedback_value[0]["total_average2_student"] = total;
                                        dr_get_feedback_value[0]["total_average2_value"] = total_course_median_value;

                                        dr_get_feedback_value[0]["average2"] = Math.Round(total_course_median_value / total, 1, MidpointRounding.AwayFromZero);

                                        dr_feedback_avrage2 = dt_feedback_avrage2.NewRow();

                                        dr_feedback_avrage2["dept_code"] = dept_code;

                                        dr_feedback_avrage2["course_typology_name"] = course_type;
                                        dr_feedback_avrage2["related_feedback"] = "course";

                                        dr_feedback_avrage2["total_average2_student"] = total;
                                        dr_feedback_avrage2["sr_no"] = dr_feedback_course[k]["sr_no"];
                                        dr_feedback_avrage2["total_average2_value"] = total_course_median_value;
                                        dr_feedback_avrage2["average2"] = Math.Round(total_course_median_value / total, 1, MidpointRounding.AwayFromZero);

                                        total_course_average2_overall += Math.Round(total_course_median_value / total, 1, MidpointRounding.AwayFromZero);

                                        dt_feedback_avrage2.Rows.Add(dr_feedback_avrage2);

                                    }
                                }
                                else
                                {
                                    dr_get_feedback_value[0]["total_average2_student"] = dr_average2[0]["total_average2_student"];
                                    dr_get_feedback_value[0]["total_average2_value"] = dr_average2[0]["total_average2_value"];

                                    dr_get_feedback_value[0]["average2"] = dr_average2[0]["average2"];
                                    dr_get_feedback_value[0]["overall_average2"] = dr_average2[0]["overall_average2"];
                                }

                                dt_feedback_calculation.AcceptChanges();

                            }
                        }



                        if (dr_get_feedback_course.Length > 0)
                        {
                            for (int k = 0; k < dr_get_feedback_course.Length; k++)
                            {
                                //DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");

                                DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'course' and sr_no ='" + dr_get_feedback_course[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");

                                if (total_course_average2_overall > 0)
                                {
                                    if (dr_average2.Length > 0)
                                    {
                                        dr_average2[0]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                                    }

                                    dr_get_feedback_course[k]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                                    dr_get_feedback_course[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                                }
                                else
                                {
                                    dr_get_feedback_course[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_course.Length, 1, MidpointRounding.AwayFromZero);
                                }
                            }

                            dt_feedback_calculation.AcceptChanges();
                        }
                        #endregion
                    }

                    #region  course data for pie chart
                    DataRow[] dr_reg = null;
                    DataRow[] dr_cross_reg = null;
                    DataRow[] dr_cross_reg_chart = null;
                    decimal total_reg = 0;
                    decimal total_cross_reg = 0;
                    if (Convert.ToDecimal(total_allocate_user) > 0)
                    {

                        if (registration_data != null)
                        {
                            dr_reg = registration_data.Select("course_code = '" + course + "'");

                            total_reg = dr_reg.Length;
                            if (cross_registration_data != null)
                            {
                                dr_cross_reg = cross_registration_data.Select("course_code = '" + course + "'");

                                total_cross_reg = dr_cross_reg.Length;

                                if (dr_cross_reg.Length > 0)
                                {
                                    cross_faculty = Math.Round((dr_cross_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));



                                    for (int k = 1; k <= 5; k++)
                                    {
                                        dr_cross_reg_chart = cross_registration_data.Select("course_code = '" + course + "' and dept_code = '" + k + "'");

                                        if (dr_cross_reg_chart.Length > 0)
                                        {
                                            switch (k)
                                            {
                                                case 1:
                                                    architecture_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                    architecture_student = dr_cross_reg_chart.Length;
                                                    break;
                                                case 2:
                                                    design_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                    design_student = dr_cross_reg_chart.Length;
                                                    break;
                                                case 3:
                                                    management_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                    management_student = dr_cross_reg_chart.Length;
                                                    break;
                                                case 4:
                                                    planning_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                    planning_student = dr_cross_reg_chart.Length;
                                                    break;
                                                case 5:
                                                    technology_per = Math.Round((dr_cross_reg_chart.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                                    technology_student = dr_cross_reg_chart.Length;
                                                    break;
                                            }
                                        }
                                    }
                                }
                            }

                            if (dr_reg.Length > 0)
                            {
                                switch (Convert.ToInt16(dr_reg[0]["dept_code"]))
                                {
                                    case 1:
                                        architecture_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                        architecture_student = total_reg;
                                        break;
                                    case 2:
                                        design_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                        design_student = total_reg;
                                        break;
                                    case 3:
                                        management_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                        management_student = total_reg;
                                        break;
                                    case 4:
                                        planning_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                        planning_student = total_reg;
                                        break;
                                    case 5:
                                        technology_per = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                                        technology_student = total_reg;
                                        break;
                                }

                                faculty = Math.Round((dr_reg.Length * 100) / Convert.ToDecimal(total_reg + total_cross_reg));
                            }


                        }

                        DataRow[] dr_get_feedback = dt_feedback_calculation.Select("course_code = '" + course_code + "'");

                        for (int k = 0; k < dr_get_feedback.Length; k++)
                        {
                            dr_get_feedback[k]["architecture_student"] = architecture_student;
                            dr_get_feedback[k]["architecture_percentage"] = architecture_per;

                            dr_get_feedback[k]["design_student"] = design_student;
                            dr_get_feedback[k]["design_percentage"] = design_per;

                            dr_get_feedback[k]["management_student"] = management_student;
                            dr_get_feedback[k]["management_percentage"] = management_per;

                            dr_get_feedback[k]["planning_student"] = planning_student;
                            dr_get_feedback[k]["planning_percentage"] = planning_per;

                            dr_get_feedback[k]["technology_student"] = technology_student;
                            dr_get_feedback[k]["technology_percentage"] = technology_per;

                            dt_feedback_calculation.AcceptChanges();

                        }

                    }

                    #endregion


                    for (int j = 0; j < dr_instructor.Length; j++)
                    {

                        total_instructor = 0;

                        dt_find_overall_instructor_median.Clear();

                        first_instructor_medain = second_instructor_median = three_instructor_median = four_instructor_median = five_instructor_median = six_instructor_median = 0;

                        overall_feedback_rating = 0;

                        string instructor_code = dr_instructor[j]["instructor_code"].ToString();

                        DataRow[] dr_get_feedback_instructor = dt_feedback_calculation.Select("course_code = '" + course_code + "' and related_feedback = 'instructor' and instructor_code = '" + instructor_code + "'");

                        if (dr_get_feedback_instructor.Length > 0)
                        {
                            if (dt_all_feedback_data != null)
                            {

                                DataRow[] dr_total_instructor = dt_total_student_instructor.Select("course_code ='" + course + "' and instructor_code = '" + instructor_code + "'");
                                DataRow[] dr_feedback_instructor = dt_all_feedback_data.Select("course_code = '" + course + "' and  instructor_code = '" + instructor_code + "'");


                                if (dr_total_instructor.Length > 0)
                                {
                                    total_instructor = Convert.ToDecimal(dr_total_instructor[0]["total"]);
                                }
                                #region instructor average
                                if (dr_feedback_instructor.Length > 0)
                                {
                                    for (int k = 0; k < dr_feedback_instructor.Length; k++)
                                    {
                                        DataRow[] dr_get_feedback = dt_feedback_calculation.Select("sr_no = '" + dr_feedback_instructor[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback ='instructor' and instructor_code = '" + instructor_code + "'");

                                        if (dr_get_feedback.Length > 0)
                                        {
                                            if (dr_feedback_instructor[k]["strongly_agree"].ToString() == "Y")
                                            {
                                                dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 5;
                                            }
                                            if (dr_feedback_instructor[k]["agree"].ToString() == "Y")
                                            {
                                                dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 4;
                                            }
                                            if (dr_feedback_instructor[k]["neither_agree"].ToString() == "Y")
                                            {
                                                dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                            }
                                            if (dr_feedback_instructor[k]["disagree"].ToString() == "Y")
                                            {
                                                dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 2;
                                            }
                                            if (dr_feedback_instructor[k]["strongly_disagree"].ToString() == "Y")
                                            {
                                                dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 1;
                                            }
                                            if (dr_feedback_instructor[k]["not_applicable"].ToString() == "Y")
                                            {
                                                dr_get_feedback[0]["total_feedback"] = Convert.ToDecimal(dr_get_feedback[0]["total_feedback"]) + 3;
                                            }

                                            dt_feedback_calculation.AcceptChanges();


                                        }


                                    }


                                }

                                #endregion
                                #region instructor median
                                decimal total_course_average2_overall = 0;
                                decimal total_course_average1_overall = 0;
                                if (dr_get_feedback_instructor.Length > 0)
                                {
                                    for (int k = 0; k < dr_get_feedback_instructor.Length; k++)
                                    {
                                        decimal total = 0;

                                        Decimal total_instructor_median_value = 0;

                                        DataRow[] dr_get_feedback_value = dt_feedback_calculation.Select("sr_no = '" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_code = '" + course_code + "' and related_feedback = 'instructor' and instructor_code = '" + instructor_code + "'");

                                        if (total_instructor > 0)
                                        {
                                            if (dr_get_feedback_value.Length > 0)
                                            {
                                                dr_get_feedback_value[0]["total_average1_student"] = total_instructor;
                                                dr_get_feedback_value[0]["average1"] = Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_instructor, 1, MidpointRounding.AwayFromZero);

                                                total_course_average1_overall += Math.Round(Convert.ToDecimal(dr_get_feedback_value[0]["total_feedback"]) / total_instructor, 1, MidpointRounding.AwayFromZero);
                                            }
                                        }



                                        ////DataRow[] dr_instructor_median = median_course_data.Select(" sr_no = '" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_type IN " + course_typology + " and dept_code ='" + dept_code + "' and instructor_code <> '' ", "sr_no ASC,number ASC");

                                        ////DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");

                                        DataRow[] dr_instructor_median = median_course_data.Select(" sr_no = '" + dr_get_feedback_instructor[k]["sr_no"] + "' and  dept_code ='" + dept_code + "' and instructor_code <> '' ", "sr_no ASC,number ASC");

                                        DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");


                                        if (dr_average2.Length == 0)
                                        {
                                            if (dr_instructor_median.Length > 0)
                                            {
                                                total = dr_instructor_median.Length;

                                                for (int n = 0; n < dr_instructor_median.Length; n++)
                                                {
                                                    total_instructor_median_value += Convert.ToDecimal(dr_instructor_median[n]["number"]);
                                                }

                                                dr_get_feedback_value[0]["total_average2_student"] = total;
                                                dr_get_feedback_value[0]["total_average2_value"] = total_instructor_median_value;

                                                dr_get_feedback_value[0]["average2"] = Math.Round(total_instructor_median_value / total, 1, MidpointRounding.AwayFromZero);

                                                dr_feedback_avrage2 = dt_feedback_avrage2.NewRow();

                                                dr_feedback_avrage2["dept_code"] = dept_code;

                                                dr_feedback_avrage2["course_typology_name"] = course_type;
                                                dr_feedback_avrage2["related_feedback"] = "instructor";

                                                dr_feedback_avrage2["total_average2_student"] = total;
                                                dr_feedback_avrage2["sr_no"] = dr_get_feedback_instructor[k]["sr_no"];
                                                dr_feedback_avrage2["total_average2_value"] = total_instructor_median_value;
                                                dr_feedback_avrage2["average2"] = Math.Round(total_instructor_median_value / total, 1, MidpointRounding.AwayFromZero);

                                                total_course_average2_overall += Math.Round(total_instructor_median_value / total, 1, MidpointRounding.AwayFromZero);

                                                dt_feedback_avrage2.Rows.Add(dr_feedback_avrage2);

                                            }
                                        }
                                        else
                                        {
                                            dr_get_feedback_value[0]["total_average2_student"] = dr_average2[0]["total_average2_student"];
                                            dr_get_feedback_value[0]["total_average2_value"] = dr_average2[0]["total_average2_value"];

                                            dr_get_feedback_value[0]["average2"] = dr_average2[0]["average2"];
                                            dr_get_feedback_value[0]["overall_average2"] = dr_average2[0]["overall_average2"];
                                            dr_get_feedback_value[0]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                        }

                                        dt_feedback_calculation.AcceptChanges();

                                    }
                                }


                                if (dr_get_feedback_instructor.Length > 0)
                                {
                                    for (int k = 0; k < dr_get_feedback_instructor.Length; k++)
                                    {
                                        ////DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and course_typology_name = '" + course_type + "' and dept_code = '" + dept_code + "'");

                                        DataRow[] dr_average2 = dt_feedback_avrage2.Select("related_feedback = 'instructor' and sr_no ='" + dr_get_feedback_instructor[k]["sr_no"] + "' and  dept_code = '" + dept_code + "'");

                                        if (total_course_average2_overall > 0)
                                        {
                                            dr_average2[0]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero); ;
                                            dr_get_feedback_instructor[k]["overall_average2"] = Math.Round(total_course_average2_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                            dr_get_feedback_instructor[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                        }
                                        else
                                        {

                                            dr_get_feedback_instructor[k]["overall_average1"] = Math.Round(total_course_average1_overall / dr_get_feedback_instructor.Length, 1, MidpointRounding.AwayFromZero);
                                        }
                                    }

                                    dt_feedback_calculation.AcceptChanges();
                                }

                                #endregion
                            }

                        }

                        #region create run time table for all Course

                        string div = "";

                        if (dr_get_feedback_instructor.Length > 0)
                        {


                            div = "<div style='page-break-after: always;'> " +

                                 //"<table  width='100%'><tr><td style='vertical-align: bottom;'><img style='float: left;margin-top: 5px;margin-left: -11px;' src='../../image/logo_new.png'/></td ><td align='center' style ='font-size: 25px; font-weight: bold;vertical-align: super;height:50px;padding-top: 0px;'>STUDENT FEEDBACK</td><td style ='font-size: 20px; font-weight: bold;vertical-align: bottom;'><b style=' float: right;width: 160px;'>" + semester + " - " + DateTime.Now.Year.ToString() + " </b></td><tr/> </table>" +
                                 //"<table  width='100%'><tr><td><img style='float: left;height:50px;' src='../../image/Capture.PNG'/></td ><td align='center' style ='font-size: 25px; font-weight: bold;padding-top: 0px;vertical-align: super;'>STUDENT FEEDBACK</td><td style ='font-size: 20px; font-weight: bold;text-align: right;vertical-align: super;'><b style=' width: 160px;'>" + semester + " - " + DateTime.Now.Year.ToString() + " </b></td><tr/> </table>" +
                                 "<table  width='100%'><tr><td><img style='float: left;height:50px;' src='../../image/Capture.PNG'/></td ><td align='center' style ='font-size: 25px; font-weight: bold;padding-top: 0px;vertical-align: super;'>STUDENT FEEDBACK</td><td style ='font-size: 20px; font-weight: bold;text-align: right;vertical-align: super;'><b style=' width: 160px;'>" + semester + " - " + year_code + " </b></td><tr/> </table>" +

                                "<table style='margin-top: 5px;'  width='100%'><tr><td style ='font-size: 16px; font-weight: bold; '>COURSE TITLE : " + dt_course_data.Rows[i]["course_name"] + " <td/><td align='right' style ='  font-size: 16px; font-weight: bold'>COURSE CODE : " + course + "</td></tr></table>" +


                            "<div style='border : 1px solid'><table   style=' width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px; font: 10px arial, san serif; border-collapse: collapse; border:0px solid #000000' cellpadding='0' cellspacing='0'  id='tbl_lecture' width='100%'>  <thead> </thead><tbody>" +

                               "<tr>";

                            if (course_type == "lecture")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Lecture </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Lecture </td> ";
                            }
                            else if (course_type == "studio")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Studio </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Studio </td> ";
                            }
                            else if (course_type == "seminar")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Seminar </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Seminar </td> ";
                            }
                            else if (course_type == "workshop")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Workshop </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Workshop </td> ";
                            }


                            div = div + " <td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='12'> FACULTY : " + department + " </td>  <td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:1;  background-color: white; color: black; height: 18px;' colspan='14'>NO OF    STUDENTS : " + total_allocate_user + " </td></tr> " +
                                        " <tr><td colspan='12'></td> " +
                                        "<td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;  background-color: white; color: black; height: 18px;' colspan='8'>NO OF RESPONDENTS : " + total_course + " </td> </tr> " +
                                        "</tbody> </table>  </div>";

                            div = div + "<div class='course' style = 'border: 1px solid; margin-bottom: 5px; margin-top: 5px;'>  <div style = 'margin-left: 20px;' id='" + (course + '-' + instructor_code) + "'></div> <script type='text/javascript'> ";

                            DataRow[] dr_get_feedback_course = dt_feedback_calculation.Select("course_code = '" + course_code + "' and related_feedback = 'course'");

                            div = div + "var dataSource = [";
                            if (dr_get_feedback_course.Length > 0)
                            {
                                div = div + "{name: '<div style=\"font-size: 15px;\">Overall Rating of Course </div>  <div style=\"font-weight: bold; font-size: 17px;\">" + Convert.ToDecimal(dr_get_feedback_course[0]["overall_average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[0]["overall_average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[0]["overall_average2"]).ToString("0.0") + ")},";
                                for (int k = dr_get_feedback_course.Length - 1; k >= 0; k--)
                                {
                                    if (k == 0)
                                    {
                                        div = div + " {name: '<div style=\"font-size: 15px;\">" + dr_get_feedback_course[k]["description"].ToString().Replace("'", "\\'") + "</div> <div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average2"]).ToString("0.0") + ")}";
                                    }
                                    else
                                    {
                                        div = div + " {name: '<div style=\"font-size: 15px;\">" + dr_get_feedback_course[k]["description"].ToString().Replace("'", "\\'") + " </div> <div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_course[k]["average2"]).ToString("0.0") + ")},";
                                    }
                                }
                            }

                            div = div + "];" +

                               "var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1', label: {visible: false,  precision: 1, horizontalOffset : 40   }  }," +
                               " {  argumentField: 'name', name :'Average2',   valueField: 'median',type: 'scatter', label: {visible: true,precision: 1, position : 'inside'  } }" +
                               "];" +



                              " $('#" + (course + '-' + instructor_code) + "').dxChart({ " +
                              " size: { height: 650 },  dataSource: dataSource,   series: series,  rotated:true, palette: 'Default'," +
                              //" size: { height: 300,  width: 650 },  dataSource: dataSource,   series: series,  rotated:true, palette: 'Default'," +
                              " valueAxis: { position: 'top',   min: 1,    max: 7 ,  tickInterval: 1 ,  valueMarginsEnabled: false}," +
                              //  "  title: {text: 'Course Feedback',font: { color: 'steelblue', family: 'Zapf-Chancery, cursive', size: 25, weight: 400,  horizontalAlignment: 'left' }, position :'leftTop'   }," +

                              "  title: {text: '<div style=\"font-weight: bold; font-size: 19px;\">Course Feedback</div>',font: { horizontalAlignment: 'center' ,opacity: 2} , position :'centerTop'  }," +
                              "  commonSeriesSettings: { argumentField: 'state', type: 'bar',   hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',      label: {  visible: false,format: 'fixedPoint'   , precision: 1 }  },    " +
                              " legend: {visible : false, verticalAlignment: 'bottom',  horizontalAlignment: 'center'} });</script></div>";
                            //" commonSeriesSettings: { argumentField: 'state', type: 'bar',  hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',    label: {  visible: true,format: 'fixedPoint', precision: 1 } },  series: [  { valueField: 'average', name: 'Avg' } ]," +
                            //"title: 'Course Feedback', legend: {visible : false, verticalAlignment: 'bottom',  horizontalAlignment: 'center'}, valueAxis: { position: 'top', min: 0,   max: 5  }, pointClick: function (point) {   this.select(); } , rotated: true}); </script>" +

                            //"<hr noshade width='100%'  size='8' style='margin-top:10px'>";


                            if (dr_get_feedback_instructor.Length > 0)
                            {
                                div = div + "<div style='border : 1px solid'><table  style=' width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px; font: 10px arial, san serif; border-collapse: collapse; border:0px solid #000000' cellpadding='0' cellspacing='0'  id='tbl_lecture'  width='100%'>  <thead> </thead><tbody>" +
                               "<tr> <td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='14'> <b>INSTRUCTOR NAME: " + dr_instructor[j]["instructor_name"] + "</b> </td>" +
                               "<td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='14'> <b>NO OF RESPONDENTS : " + total_instructor + " </b> </td> </tr></tbody></table></div>";


                                div = div + " <div class='instructor' style = 'border: 1px solid;border-top: 0;'> <div  style = 'margin-left: 20px;' id='" + (course + '-' + instructor_code + '-' + 1) + "'></div> <script type='text/javascript'>" +
                                            "var dataSource = [";


                                div = div + "{name: '<div style=\"font-size: 15px;\">Overall Rating of Instructor</div> <div style=\"font-weight: bold; font-size: 17px;\">" + Convert.ToDecimal(dr_get_feedback_instructor[0]["overall_average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[0]["overall_average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[0]["overall_average2"]).ToString("0.0") + ")},";

                                for (int k = dr_get_feedback_instructor.Length - 1; k >= 0; k--)
                                {

                                    int desc_length = dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'").Length;

                                    string instructor_desc = "";


                                    //if (desc_length >= 65)
                                    //{
                                    //    instructor_desc += dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'").Substring(0, 65) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br/>";
                                    //    instructor_desc += dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'").Substring(66);
                                    //}
                                    //else
                                    //{
                                    instructor_desc = dr_get_feedback_instructor[k]["description"].ToString().Replace("'", "\\'");
                                    //}

                                    if (k == 0)
                                    {
                                        div = div + " {name: '<div style=\"font-size: 15px;\">" + instructor_desc + "</div><div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")}";

                                        //  div = div + " {name: '" + instructor_desc + "', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")}";

                                    }

                                    else
                                    {
                                        div = div + " {name: '<div style=\"font-size: 15px;\">" + instructor_desc + " </div><div style=\"font-weight: bold; font-size: 17px;\"><b>" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "</div>', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")},";

                                        //div = div + " {name: '" + instructor_desc + "', average: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average1"]).ToString("0.0") + "), median: parseFloat(" + Convert.ToDecimal(dr_get_feedback_instructor[k]["average2"]).ToString("0.0") + ")},";
                                    }
                                }

                                div = div + "];" +
                                   //"var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1',  label: {visible: true,  precision: 1, horizontalOffset : 40   } }," +
                                   "var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1',  label: {visible: true,precision: 1, position : 'inside'    } }," +
                                    " {  argumentField: 'name', name :'Average2', valueField: 'median',type: 'scatter', label: {visible: true,precision: 1, position : 'inside' } }" +
                                 "];" +


                                 " $('#" + (course + '-' + instructor_code + '-' + 1) + "').dxChart({ " +
                                     //" size: { height: 300,  width: 700 },  dataSource: dataSource,series: series, " +
                                     " size: {  height: 650 }, dataSource: dataSource,series: series, " +
                                    " valueAxis: { position: 'top',   min: 1,    max: 7 ,  tickInterval: 1 ,  valueMarginsEnabled: false}," +
                                   " commonSeriesSettings: { argumentField: 'state', type: 'bar',  hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',    label: {  visible: true,format: 'fixedPoint', precision: 1 } }, " +
                                  "  title: {text: '<div style=\"font-weight: bold; font-size: 19px;\">Instructor Feedback</div>',font: {   horizontalAlignment: 'center' }   }," +
                             "legend: {visible : false, verticalAlignment: 'bottom',  horizontalAlignment: 'center' },  rotated: true}); </script></div> ";


                            }

                            // "<hr noshade width='100%'  size='8' style='margin-top:10px'>";
                            div = div + "<table style='border: 1px solid;width: 100%;border-collapse: collapse; margin-top:5px; font-size:14px'><tbody> " +
                                   "  <tr style='font-size: 12px;'><td align='left' colspan='7' style='font-size: 15px; font-weight: bold; font-style: italic'>STUDENTS REGISTERED BY FACULTY</td></tr> " +

                                       "<tr><td style='  border: 1px solid;padding-left: 5px; font-style: italic'>Name Of Faculty</td> <td style=' border: 1px solid;padding-left: 5px;font-style: italic'>FA " +
                                   "<td style='border: 1px solid;padding-left: 5px;font-style: italic'>FD</td> " +
                                    "<td style='  border: 1px solid;padding-left: 5px;font-style: italic'>FM</td>" +
                                     "  </td> <td style='border: 1px solid;padding-left: 5px;font-style: italic'>FP</td>" +
                                   "<td style='  border: 1px solid;padding-left: 5px;font-style: italic'>FT</td>" +

                                   "<td style='border: 1px solid; font-style: italic'>Total</td>" +
                                   "</tr>" +
                                   " <tr style='border: 1px solid; '>" +
                                     "<td style=' border: 1px solid;padding-left: 5px;font-style: italic' >No. of Students</td> " +
                                   "<td style=' border: 1px solid;padding-left: 5px;' >" + architecture_student + "</td> " +
                                    "<td style=' border: 1px solid;padding-left: 5px;' >" + design_student + "</td> " +
                                     "<td style=' border: 1px solid;padding-left: 5px;' >" + management_student + "</td> " +
                                      "<td style=' border: 1px solid;padding-left: 5px;' >" + planning_student + "</td> " +
                                       "<td style=' border: 1px solid;padding-left: 5px;' >" + technology_student + "</td> " +
                                        "<td style=' border: 1px solid;padding-left: 5px;' >" + Convert.ToDecimal(total_reg + total_cross_reg) + "</td> " +
                                   "</tr>" +
                                   "<tr style='border: 1px solid;'> " +
                                   "<td style=' border: 1px solid;padding-left: 5px;font-style: italic' >Percentage(%)</td> " +
                                   "<td style='border: 1px solid;padding-left: 5px;'>" + architecture_per + "</td> " +
                                     "<td style='border: 1px solid;padding-left: 5px;'>" + design_per + "</td> " +
                                       "<td style='border: 1px solid;padding-left: 5px;'>" + management_per + "</td> " +
                                         "<td style='border: 1px solid;padding-left: 5px;'>" + planning_per + "</td> " +
                                           "<td style='border: 1px solid;padding-left: 5px;'>" + technology_per + "</td> " +
                                             "<td style='border: 1px solid;padding-left: 5px;'>100%</td> " +
                                   "</tr> " +
                                   "</tbody></table>";

                            div = div + "<div style ='font-size: 14px; font-style: italic'> " +
                                "<div style=' margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/cor_avg.png'/><b>Course Average(COR AVG):</b>This is the average of the total responses for this course. For example, for Studio IV,out of total 32 students 28 have responded, the Average represents the mean of all 28 responses.</div> " +
                                "<div style=' margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/avg1.png'/><b>Individual Average(IND AVG):</b>This is the average score of  the total responses for this instructor. For example, for Studio IV,out of total 32 students 28 have responded, the Average represents the mean of all 28 responses.</div> " +
                                        "<div style='margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/avg2.png'/><b>Faculty Average(FAC AVG):</b> This is the average of all responses for similar course type within the Faculty.For example,Faculty average of Studio IV offered by FA,represents the mean of all responses for Studio courses offered in FA during the given semester.</div> " +


                                          "</div>" +
                                        "<div style='font-weight: bold; font-size: 14px; margin-top: 2px;'>Scale: 1 = least agreement with the statement, 5 = most agreement with the statement</div>" +
                                        "</div>";


                            div = div + "<div style='page-break-after: always;'> " +


                                "<table style='margin-top: 5px;'  width='100%'><tr><td style ='font-size: 16px; font-weight: bold; '>COURSE TITLE : " + dt_course_data.Rows[i]["course_name"] + " <td/><td align='right' style ='  font-size: 16px; font-weight: bold'>COURSE CODE : " + course + "</td></tr></table>" +


                            "<div style='border : 1px solid'><table   style=' width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px; font: 10px arial, san serif; border-collapse: collapse; border:0px solid #000000' cellpadding='0' cellspacing='0'  id='tbl_lecture' width='100%'>  <thead> </thead><tbody>" +

                               "<tr>";

                            if (course_type == "lecture")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Lecture </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Lecture </td> ";
                            }
                            else if (course_type == "studio")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Studio </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Studio </td> ";
                            }
                            else if (course_type == "seminar")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Seminar </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Seminar </td> ";
                            }
                            else if (course_type == "workshop")
                            {
                                //div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> <b>  COURSE TYPE : Workshop </b> </td> ";
                                div = div + "<td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;   background-color: white; color: black; height: 18px;' colspan='14'> COURSE TYPE : Workshop </td> ";
                            }


                            div = div + " <td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='12'> FACULTY : " + department + " </td>  <td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:1;  background-color: white; color: black; height: 18px;' colspan='14'>NO OF    STUDENTS : " + total_allocate_user + " </td></tr> " +
                                        " <tr><td colspan='12'></td> " +
                                        "<td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0;  background-color: white; color: black; height: 18px;' colspan='8'>NO OF RESPONDENTS : " + total_course + " </td> </tr> " +
                                        "</tbody> </table>  </div>";




                            if (dt_all_comment_text != null)
                            {

                                DataRow[] dr_text = dt_all_comment_text.Select("course_code = '" + course + "' and releted_feedback = 'course'");

                                if (dr_text.Length > 0)
                                {
                                    string row = "";
                                    int row_data = 0;

                                    for (int m = 0; m < dr_text.Length; m++)
                                    {
                                        if (dr_text[m]["comments"].ToString() != "")
                                        {
                                            row_data = row_data + 1;
                                            row = row + "<tr style='border: 1px solid;'><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;'><center>" + row_data + "</center></td><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;' >" + dr_text[m]["comments"].ToString() + "</td></tr>";
                                        }
                                    }



                                    div = div + "<div><p class='small' style='line-height: 12px; font-size: 20px;font-family: Segoe UI Light, Helvetica Neue Light, Segoe UI, Helvetica Neue, Trebuchet MS, Verdana;'><b> Course Comments </b></p> </div>" +
                                    "<table style='font: 15px arial, san serif; border-collapse: collapse; border:1px solid;' cellpadding='0' cellspacing='0' id='tbl_lecture'  width='100%'> " +
                                     "<tbody><tr style='border: 1px solid;'><td style='border:1px solid; width: 42px; padding: 4px 7px;'><center> Sr No.</center></td> <td style='border:1px solid;'> <center>Comments </center> </td> </tr> " + row + "</tbody></table>";

                                }

                                dr_text = dt_all_comment_text.Select("course_code = '" + course + "' and releted_feedback = 'instructor' and instructor_code ='" + instructor_code + "'");


                                if (dr_text.Length > 0)
                                {
                                    string row = "";
                                    int row_data = 0;

                                    for (int m = 0; m < dr_text.Length; m++)
                                    {

                                        if (dr_text[m]["comments"].ToString() != "")
                                        {
                                            row_data = row_data + 1;
                                            row = row + "<tr style='border: 1px solid;'><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;'><center>" + row_data + "</center></td><td style='border:1px solid; padding-left: 5px; padding-top: 2px; padding-bottom: 2px;' >" + dr_text[m]["comments"].ToString() + "</td></tr>";
                                        }
                                    }


                                    div = div + "<div><p class='small' style='line-height: 12px; font-size: 20px; font-family: Segoe UI Light, Helvetica Neue Light, Segoe UI, Helvetica Neue, Trebuchet MS, Verdana;'><b>Instructor Comments </b></p> </div>" +
                                        "<div style='font: 10px arial, san serif; font-size: 15px; font-style: italic;  color: black; height: 18px;' colspan='14'> <b>Instructor Name: " + dr_instructor[j]["instructor_name"] + "</b> </div>" +
                                    "<table style='font: 15px arial, san serif; border-collapse: collapse; border:1px solid ' cellpadding='0' cellspacing='0' id='tbl_lecture'  width='100%'> " +
                                     "<tbody><tr style='border: 1px solid;'><td style='border:1px solid;border-bottom:0;width: 42px; padding: 4px 7px;'><center> Sr No.</center></td> <td style='border:1px solid;'> <center>Comments </center> </td> </tr> " + row + "</tbody></table>";

                                }
                            }

                            div = div + "<div style ='font-size: 15px;'>Comments are reproduced verbatim from the feedback received</div>";

                            div = div + " </div>";
                            ///  Boolean status = objmaster.Insert_feedback_chart_data(course_code, instructor_code, j + 1, div.Replace("'", "''"), sem_code, year_code);


                        }
                        table = table + div;
                        #endregion

                        //   pdf_print_name += "_" + course_code + "_" + dt_course_data.Rows[i]["course_name"] + "_" + dr_instructor[j]["instructor_name"] + "_" + semester + "_" + year_code;

                        pdf_print_name += "_" + course_code + "_" + dr_instructor[j]["instructor_name"] + "_" + semester + "_" + year_code;
                    }


                }


                if (dt_feedback_calculation != null)
                {


                    if (dt_feedback_calculation.Rows.Count > 0)
                    {
                        obj_feedback_calculation.ws_feedback_calculation.Clear();

                        for (int i = 0; i < dt_feedback_calculation.Rows.Count; i++)
                        {
                            DataRow feedback_calculation = dt_feedback_calculation.Rows[i];

                            feedback_calculation["cancel_flag"] = "N";
                            feedback_calculation["status"] = "Y";
                            feedback_calculation["created_date"] = System.DateTime.Now;
                            feedback_calculation["created_by"] = BLL.Master.SessionMaster.Createdby; //HttpContext.Current.Session["UserId"].ToString();
                            feedback_calculation["created_host"] = BLL.Master.SessionMaster.CreatedHost;//HttpContext.Current.Request.UserHostName;


                            obj_feedback_calculation.ws_feedback_calculation.ImportRow(feedback_calculation);
                        }
                    }

                    if (dt_feedback_avrage2 != null)
                    {
                        obj_feedback_calculation.ws_feedback_calculation_average2.Clear();
                        if (dt_feedback_avrage2.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt_feedback_avrage2.Rows.Count; i++)
                            {
                                DataRow feedback_calculation_average2 = dt_feedback_avrage2.Rows[i];

                                feedback_calculation_average2["cancel_flag"] = "N";
                                feedback_calculation_average2["status"] = "Y";
                                feedback_calculation_average2["created_date"] = System.DateTime.Now;
                                feedback_calculation_average2["created_by"] = BLL.Master.SessionMaster.Createdby; //HttpContext.Current.Session["UserId"].ToString();
                                feedback_calculation_average2["created_host"] = BLL.Master.SessionMaster.CreatedHost; //HttpContext.Current.Request.UserHostName;

                                feedback_calculation_average2["semester_type"] = sem_code;
                                feedback_calculation_average2["year_semester"] = year_code;

                                obj_feedback_calculation.ws_feedback_calculation_average2.ImportRow(feedback_calculation_average2);
                            }
                        }
                    }
                }


                //objBLReturnObject = objMaster.save_feedback_calculation_data(obj_feedback_calculation, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName);
                objBLReturnObject = objMaster.save_feedback_calculation_data(obj_feedback_calculation, BLL.Master.SessionMaster.Createdby, BLL.Master.SessionMaster.CreatedHost);

                DataTable dt = new DataTable();

                dt.Columns.Add("table");

                dt.Columns.Add("message");

                DataRow dr;

                dr = dt.NewRow();

                dr["table"] = table;

                dr["message"] = "";

                if (objBLReturnObject.ExecutionStatus == 1)
                {
                    dr["message"] = 1;
                }
                else
                {
                    dr["message"] = objBLReturnObject.ServerMessage.ToString();
                }

                dt.Rows.Add(dr);
                jsondata = GetJson1(dt);

                //return_data["div_data_" + p] = jsondata;
                return_data["div_data"] = jsondata;
                //return_data["pdf_print_name"] = "";
                if (selected_instructor != "")
                {
                    //return_data["pdf_print_name_" + p] = pdf_print_name;
                    return_data["pdf_print_name"] = pdf_print_name;
                }
                else if (pdf_print_name != "")
                {
                    //return_data["pdf_print_name_" + p] = pdf_print_name;
                    return_data["pdf_print_name"] = pdf_print_name;
                }
            //}



            return ser.Serialize(return_data);

        }
        catch (Exception ex)
        {

            return ex.ToString();
        }
    }

    [WebMethod(EnableSession = true)]
    public string SWSUploadPDFServer(string EncodeValue, string Filename)
    {
        try
        {
            byte[] bArray;
            string imgpath = Server.MapPath("~/image");
            var htmlToPdf = new NReco.PdfGenerator.HtmlToPdfConverter();
            byte[] newArray = new byte[EncodeValue.Length + 1];
            string[] split_id = EncodeValue.Split(',');
            int count = split_id.Length;
            for (int k = 0; k < count; k++)
            {
                newArray[k] = Convert.ToByte(split_id[k]);
            }
            string base64Decoded = System.Text.ASCIIEncoding.ASCII.GetString(newArray);
            base64Decoded = base64Decoded.Replace("../../image/Capture.PNG", "" + imgpath + "\\Capture.PNG");
            base64Decoded = base64Decoded.Replace("../../image/cor_avg.png", "" + imgpath + "\\cor_avg.png");
            base64Decoded = base64Decoded.Replace("../../image/avg1.png", "" + imgpath + "\\avg1.png");
            base64Decoded = base64Decoded.Replace("../../image/avg2.png", "" + imgpath + "\\avg2.png");
            var pdfBytes = htmlToPdf.GeneratePdf(base64Decoded);
            //string path = HttpContext.Current.Server.MapPath("~/FeedbackPdf");
            string path = Server.MapPath("~/SWSFeedbackPdf");

            path = path + "\\" + Filename + ".pdf";
            FileStream fs = new FileStream(path, FileMode.Create);
            fs.Write(pdfBytes, 0, pdfBytes.Length);
            fs.Dispose();
            fs.Close();
            return "1";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
    }


   
    



    #endregion

    [WebMethod(EnableSession = true)]
    public dynamic sws_deallocate_course(string course_code, string student_code, string sem_code, string year_code)
    {
        var user_id = HttpContext.Current.Session["UserId"].ToString();
        var user_type = HttpContext.Current.Session["user_type"].ToString();

        bool Get_date = objmaster.sws_deallocate_course(course_code, student_code, sem_code, year_code, user_id,user_type, HttpContext.Current.Request.UserHostName.ToString());

        if (Get_date == true)
        {
            return true;

        }
        return false;
    }

    [WebMethod(EnableSession = true)]
    public dynamic sws_update_student_course_type(string course_code, string student_code, string sem_code, string year_code, string course_type)
    {
        var user_id = HttpContext.Current.Session["UserId"].ToString();
        var user_type = HttpContext.Current.Session["user_type"].ToString();

        bool Get_date = objmaster.sws_update_student_course_type(course_code, student_code, sem_code, year_code, user_id, user_type, HttpContext.Current.Request.UserHostName.ToString(), course_type);

        if (Get_date == true)
        {
            return true;

        }
        return false;
    }

    #region Comman methods

    public static String MakeInQueryString(DataTable table, String column_name)
    {
        string in_query = "", column_value = "";

        if (table != null)
        {
            for (int i = 0; i < table.Rows.Count; i++)
            {
                column_value = table.Rows[i][column_name].ToString();
                if (!in_query.Contains("'" + column_value + "',"))
                    in_query += "'" + column_value + "',";
            }
        }

        if (in_query.Length > 0)
            in_query = in_query.Substring(0, in_query.Length - 1);
        if (in_query == String.Empty)
            in_query = "''";
        return in_query;
    }

    #endregion


    
}
