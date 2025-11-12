using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class MasterPageDesign : System.Web.UI.MasterPage
{
    Masters objmaster = new Masters();
    string str;

    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Redirect("~/Site_maintenance.htm");

        ViewState["prog_code"] = Session["prog_code"].ToString();

        if (Session["UserId"] != null)
        {
            if (Session["reset_flag"] == "R")
            {
                Response.Redirect("~/reset_password.aspx");
            }
            else
            {
                str = Session["UserId"].ToString();
                hdnuserid.Value = str;
                hdnusertype.Value = Session["user_type"].ToString();
                hdnuserprog.Value = Session["prog_code"].ToString();
            }
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }

        DataTable dtus = new DataTable();
        dtus = objmaster.userMaster(str);
        
        if (dtus != null)
        {
            //lblusername.Attributes.Add("style", "text-decoration:blink");
            if (dtus.Rows[0]["user_type"].ToString() == "V")
            {
                div_admin.Style.Add("display","none");
                DataTable dtuservendor = objmaster.GetVendorname(str);
                if (dtuservendor != null)
                {
                    lblusername.Text = dtuservendor.Rows[0]["user_name"].ToString();
                    //Lblusaernameanother.Text = "CEPT UNIVERSITY";
                }
            }
            else
            {
                div_admin1.Style.Add("display", "none");

                if (dtus.Rows[0]["user_type"].ToString() == "A")
                {
                    admin_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "S")
                {
                    student_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "E")
                {
                    external_menu.Style.Add("display", "none");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "I")
                {
                    it_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "A1")
                {
                    admin1_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "A2")
                {
                    admin2_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "PC")
                {
                    Prog_Coord.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "I2")
                {
                    faculty.Style.Add("display", "block");
                }
                  
                else if (dtus.Rows[0]["user_type"].ToString() == "F")
                {
                    Finance.Style.Add("display", "block");
                }
                lblusername.Text = dtus.Rows[0]["user_name"].ToString();

                ////if (Session["prog_code"].ToString() == "1" && Session["year_code"].ToString() == "Y2016")
                ////{
                //    fees_installment_menu.Style.Add("display", "block");
                //    fees_installment_menu1.Style.Add("display", "block");
                ////}
                ////else
                ////{
                ////    fees_installment_menu.Style.Add("display", "none");
                ////    fees_installment_menu1.Style.Add("display", "none");
                ////}
                //Lblusaernameanother.Text = "CEPT UNIVERSITY";
            }
        }

        DataTable dt_param_dtl = objmaster.get_parameter_screen_rights_dtl();
        DataTable get_choice_preference_dtl = objmaster.Get_choice_edit_student_dtl(str);
        DataTable SWS_registrtion_allow_after_registration = objmaster.SWS_allow_registration_for_particular_student(str);
        
        //if (SWS_registrtion_allow_after_registration == null)
        //{
        //    BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
        //    string encodedMsg = encode.EncryptData("You have not been allocated any courses in the current regular semester. So please contact summer winter office.");
        //    Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
        //}
        if (dt_param_dtl != null && !Request.Url.AbsolutePath.Contains("Student/Dashboard.aspx"))
        {
            for (int i = 0; i < dt_param_dtl.Rows.Count; i++)
            {
                if (SWS_registrtion_allow_after_registration != null && SWS_registrtion_allow_after_registration.Rows[0]["cancel_flag"].ToString() == "P" && ("student/sws_credit_choice.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower() || "student/sws_course_selection.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower()))
                {
                    dt_param_dtl.Rows[i]["TimeStatus"] = "True";
                }
                if (Request.Url.AbsolutePath.ToLower().Contains(dt_param_dtl.Rows[i]["page_path"].ToString().ToLower()) && dt_param_dtl.Rows[i]["user_type"].ToString() == Session["user_type"].ToString() && dt_param_dtl.Rows[i]["TimeStatus"].ToString() == "False")
                {
                    BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                    string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                    Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                }

                else if (Request.Url.AbsolutePath.ToLower().Contains(dt_param_dtl.Rows[i]["page_path"].ToString().ToLower()) && dt_param_dtl.Rows[i]["parameter_value"].ToString() == "E" && dt_param_dtl.Rows[i]["user_type"].ToString() == Session["user_type"].ToString())
                {
                    //SW_Connect_Course_Registration 

                    if ("student/student_instruction.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower())
                    {
                        if (SWS_registrtion_allow_after_registration != null)
                        {
                            DataTable dt = objmaster.Get_Datetime_wise_parameter_dtl("student_instruction", "S");
                            if (dt == null)
                            {

                                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                            }
                            else
                            {
                                DateTime dateTime = DateTime.Now;
                                string current_time = dateTime.ToString("dd-MM-yyyy");
                                DataTable dt_current_sem = objmaster.Get_ws_cept_current_sem_data();
                                hdnswssemcode.Value = dt_current_sem.Rows[0]["sem_code"].ToString();
                                hdnswsyearcode.Value = dt_current_sem.Rows[0]["year_code"].ToString();
                                if (current_time == dt.Rows[0]["sws_start_date"].ToString())
                                {
                                    hdnswsStartDatestatus.Value = "True";
                                }
                                else { hdnswsStartDatestatus.Value = "False"; }

                                //DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status(Session["UserId"].ToString());
                                DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status_new(Session["UserId"].ToString());
                                DataTable ws_reg_manually_data = objmaster.Get_sws_Payment_page_manually_dtl(Session["UserId"].ToString());
                                DataTable ws_reg_allocated_course_dtl = objmaster.SWs_get_pre_allocated_course(Session["UserId"].ToString(), dt_current_sem.Rows[0]["sem_code"].ToString(), dt_current_sem.Rows[0]["year_code"].ToString());

                                if (ws_reg_data != null)
                                {
                                    if (ws_reg_data.Rows[0]["status"].ToString() == "R")
                                    {
                                        Response.Redirect("~/Student/sws_payment_dtl.aspx");
                                    }

                                    //if (ws_reg_manually_data != null)
                                    //{
                                    //Response.Redirect("~/Student/sws_payment_dtl.aspx");
                                    //}
                                    //BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                    //string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                    //Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                                }
                                else if (ws_reg_allocated_course_dtl != null)
                                {
                                    //Response.Redirect("~/Student/sws_course_selection.aspx");
                                    //Response.Redirect("~/Student/sws_course_selection.aspx");
                                }
                            }
                        }
                        else
                        {
                            BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                            //string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                            string encodedMsg = encode.EncryptData("You have not been allocated any courses in the current regular semester. So please contact summer winter office.");
                            Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                        }

                    }
                    else if ("student/sws_credit_choice.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower())
                    {
                        if (SWS_registrtion_allow_after_registration != null)
                        {


                            DataTable dt = new DataTable();
                            if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "E")
                            {
                                dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration_EX", "E");
                            }
                            else if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "S")
                            {
                                if (SWS_registrtion_allow_after_registration != null && SWS_registrtion_allow_after_registration.Rows[0]["cancel_flag"].ToString() == "P")
                                {
                                    dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Request_base_Course_Registration", "S");
                                }
                                else 
                                {
                                    dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration_one", "S"); 
                                }
                                //dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration", "S");
                            }

                            if (dt == null)
                            {

                                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                            }
                            else
                            {
                                DateTime dateTime = DateTime.Now;
                                string current_time = dateTime.ToString("dd-MM-yyyy");
                                DataTable dt_current_sem = objmaster.Get_ws_cept_current_sem_data();
                                hdnswssemcode.Value = dt_current_sem.Rows[0]["sem_code"].ToString();
                                hdnswsyearcode.Value = dt_current_sem.Rows[0]["year_code"].ToString();
                                if (current_time == dt.Rows[0]["sws_start_date"].ToString())
                                {
                                    hdnswsStartDatestatus.Value = "True";
                                }
                                else { hdnswsStartDatestatus.Value = "False"; }

                                //DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status(Session["UserId"].ToString());
                                DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status_new(Session["UserId"].ToString());
                                DataTable ws_reg_manually_data = objmaster.Get_sws_Payment_page_manually_dtl(Session["UserId"].ToString());
                                DataTable ws_reg_allocated_course_dtl = objmaster.SWs_get_pre_allocated_course(Session["UserId"].ToString(), dt_current_sem.Rows[0]["sem_code"].ToString(), dt_current_sem.Rows[0]["year_code"].ToString());

                                if (ws_reg_data != null)
                                {
                                    if (ws_reg_data.Rows[0]["status"].ToString() == "R")
                                    {
                                        //Response.Redirect("~/Student/sws_credit_choice.aspx");
                                        Response.Redirect("~/Student/sws_payment_dtl.aspx");
                                    }
                                }
                                else if (ws_reg_allocated_course_dtl != null)
                                {
                                    
                                }
                            }
                        }
                        else if (SWS_registrtion_allow_after_registration ==  null && Session["user_type"].ToString().ToUpper().Trim().ToString() == "E")
                        {
                            DataTable dt = new DataTable();
                            if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "E")
                            {
                                dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration_EX", "E");
                            }
                            else if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "S")
                            {
                                dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration", "S");
                            }

                            if (dt == null)
                            {

                                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                            }
                            else
                            {
                                DateTime dateTime = DateTime.Now;
                                string current_time = dateTime.ToString("dd-MM-yyyy");
                                DataTable dt_current_sem = objmaster.Get_ws_cept_current_sem_data();
                                hdnswssemcode.Value = dt_current_sem.Rows[0]["sem_code"].ToString();
                                hdnswsyearcode.Value = dt_current_sem.Rows[0]["year_code"].ToString();
                                if (current_time == dt.Rows[0]["sws_start_date"].ToString())
                                {
                                    hdnswsStartDatestatus.Value = "True";
                                }
                                else { hdnswsStartDatestatus.Value = "False"; }

                                //DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status(Session["UserId"].ToString());
                                DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status_new(Session["UserId"].ToString());
                                DataTable ws_reg_manually_data = objmaster.Get_sws_Payment_page_manually_dtl(Session["UserId"].ToString());
                                DataTable ws_reg_allocated_course_dtl = objmaster.SWs_get_pre_allocated_course(Session["UserId"].ToString(), dt_current_sem.Rows[0]["sem_code"].ToString(), dt_current_sem.Rows[0]["year_code"].ToString());

                                if (ws_reg_data != null)
                                {
                                    if (ws_reg_data.Rows[0]["status"].ToString() == "R")
                                    {
                                        //Response.Redirect("~/Student/sws_credit_choice.aspx");
                                        Response.Redirect("~/Student/sws_payment_dtl.aspx");
                                    }
                                }
                                else if (ws_reg_allocated_course_dtl != null)
                                {

                                }
                            }
                        }
                        
                        else
                        {
                            BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                            string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                            Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                        }
                    }
                    else if ("student/sws_course_selection.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower())
                    {
                        if (SWS_registrtion_allow_after_registration != null)
                        {

                            DataTable dt = new DataTable();
                            if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "E")
                            {
                                dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration_EX_one", "E");
                            }
                            else if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "S")
                            {
                                if (SWS_registrtion_allow_after_registration != null && SWS_registrtion_allow_after_registration.Rows[0]["cancel_flag"].ToString() == "P")
                                {
                                    dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Request_base_Course_Registration", "S");
                                }
                                else { dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration_one", "S"); }
                                
                            }


                            if (dt == null)
                            {

                                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                            }
                            else
                            {
                                DateTime dateTime = DateTime.Now;
                                string current_time = dateTime.ToString("dd-MM-yyyy");
                                DataTable dt_current_sem = objmaster.Get_ws_cept_current_sem_data();
                                hdnswssemcode.Value = dt_current_sem.Rows[0]["sem_code"].ToString();
                                hdnswsyearcode.Value = dt_current_sem.Rows[0]["year_code"].ToString();
                                if (current_time == dt.Rows[0]["sws_start_date"].ToString())
                                {
                                    hdnswsStartDatestatus.Value = "True";
                                }
                                else { hdnswsStartDatestatus.Value = "False"; }
                                DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status_new(Session["UserId"].ToString());
                                DataTable ws_reg_manually_data = objmaster.Get_sws_Payment_page_manually_dtl(Session["UserId"].ToString());
                                DataTable ws_reg_allocated_course_dtl = objmaster.SWs_get_pre_allocated_course(Session["UserId"].ToString(), dt_current_sem.Rows[0]["sem_code"].ToString(), dt_current_sem.Rows[0]["year_code"].ToString());

                                if (ws_reg_data != null)
                                {
                                    if (ws_reg_data.Rows[0]["status"].ToString() == "R")
                                    {
                                        //Response.Redirect("~/Student/sws_credit_choice.aspx");
                                        Response.Redirect("~/Student/sws_payment_dtl.aspx");
                                    }
                                }
                                else if (ws_reg_allocated_course_dtl != null)
                                {
                                    //Response.Redirect("~/Student/sws_course_selection.aspx");
                                    //Response.Redirect("~/Student/sws_course_selection.aspx");
                                }
                            }
                        }

                        else if (SWS_registrtion_allow_after_registration == null && Session["user_type"].ToString().ToUpper().Trim().ToString() == "E") 
                        {

                            DataTable dt = new DataTable();
                            if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "E")
                            {
                                dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration_EX_one", "E");
                            }
                            else if (Session["user_type"].ToString().ToUpper().Trim().ToString() == "S")
                            {
                                dt = objmaster.Get_Datetime_wise_parameter_dtl("SW_Connect_Course_Registration_one", "S");
                            }


                            if (dt == null)
                            {

                                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                            }
                            else
                            {
                                DateTime dateTime = DateTime.Now;
                                string current_time = dateTime.ToString("dd-MM-yyyy");
                                DataTable dt_current_sem = objmaster.Get_ws_cept_current_sem_data();
                                hdnswssemcode.Value = dt_current_sem.Rows[0]["sem_code"].ToString();
                                hdnswsyearcode.Value = dt_current_sem.Rows[0]["year_code"].ToString();
                                if (current_time == dt.Rows[0]["sws_start_date"].ToString())
                                {
                                    hdnswsStartDatestatus.Value = "True";
                                }
                                else { hdnswsStartDatestatus.Value = "False"; }
                                DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status_new(Session["UserId"].ToString());
                                DataTable ws_reg_manually_data = objmaster.Get_sws_Payment_page_manually_dtl(Session["UserId"].ToString());
                                DataTable ws_reg_allocated_course_dtl = objmaster.SWs_get_pre_allocated_course(Session["UserId"].ToString(), dt_current_sem.Rows[0]["sem_code"].ToString(), dt_current_sem.Rows[0]["year_code"].ToString());

                                if (ws_reg_data != null)
                                {
                                    if (ws_reg_data.Rows[0]["status"].ToString() == "R")
                                    {
                                        //Response.Redirect("~/Student/sws_credit_choice.aspx");
                                        Response.Redirect("~/Student/sws_payment_dtl.aspx");
                                    }
                                }
                                else if (ws_reg_allocated_course_dtl != null)
                                {
                                    //Response.Redirect("~/Student/sws_course_selection.aspx");
                                    //Response.Redirect("~/Student/sws_course_selection.aspx");
                                }
                            }


                        }


                        else
                        {
                            BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                            string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                            Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                        }

                    }
                    

                }

                else if (Request.Url.AbsolutePath.ToLower().Contains(dt_param_dtl.Rows[i]["page_path"].ToString().ToLower()) && dt_param_dtl.Rows[i]["parameter_value"].ToString() == "D" && dt_param_dtl.Rows[i]["user_type"].ToString() == Session["user_type"].ToString())
                {
                    if ("student/vertical_studio_preferences.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower())
                    {
                        //Allow for View Vertical Studio Preferences Submission Data
                    }
                    //changes
                    //else if ("student/sws_mandatory_course_dtl.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower())
                    //{
                    //    DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status(Session["UserId"].ToString());
                    //    DataTable ws_reg_manually_data = objmaster.Get_sws_Payment_page_manually_dtl(Session["UserId"].ToString());
                    //    if (ws_reg_data == null)
                    //    {
                    //        if (ws_reg_manually_data != null)
                    //        {
                    //            Response.Redirect("~/Student/sws_payment_dtl.aspx");
                    //        }
                    //        BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                    //        string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                    //        Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                    //    }
                    //}
                    else if (get_choice_preference_dtl != null && "student/level3_choice_reg.aspx" == dt_param_dtl.Rows[i]["page_path"].ToString().ToLower() && get_choice_preference_dtl.Rows[0]["edit_status"].ToString() == "Y")
                    {

                    }
                    else
                    {
                        BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();

                        string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());

                        Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                    }
                }
            }

            if (Request.Url.AbsolutePath.Contains("Student/hostel_fees_payment.aspx"))
            {
                
                DataRow[] dr_use = dt_param_dtl.Select("parameter_name ='hostel_fess_enable_disable'");
                if (Session["gender"].ToString() == "F" && (dr_use[0]["parameter_value"].ToString() == "E" || dr_use[0]["parameter_value"].ToString() == "G"))
                {

                }
                else if (Session["gender"].ToString() == "M" && (dr_use[0]["parameter_value"].ToString() == "E" || dr_use[0]["parameter_value"].ToString() == "B"))
                {

                }
                else if (dr_use[0]["parameter_value"].ToString() == "E" ) 
                {

                }
                else 
                {
                    BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();

                    string encodedMsg = encode.EncryptData(dr_use[0]["disable_message"].ToString());

                    Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                }
            }
           
            //if (Request.Url.AbsolutePath.Contains("student/sws_mandatory_course_dtl.aspx"))
            //{
            //    DataTable ws_reg_data = objmaster.Get_sws_reg_course_dtl_check_status(Session["UserId"].ToString());
            //    DataTable ws_reg_manually_data = objmaster.Get_sws_Payment_page_manually_dtl(Session["UserId"].ToString());
            //    if (ws_reg_data == null)
            //    {
            //        if (ws_reg_manually_data != null)
            //        {
            //            Response.Redirect("~/Student/sws_payment_dtl.aspx");
            //        }
                    
            //    }
            //}
        }

        

        string page_name = "Student/Student_Feedback_form.aspx";

        if (Request.Url.AbsolutePath.ToLower().Contains(page_name.ToLower()))
        {
            DataTable dt_cfp_status = objmaster.get_student_foundation_active_status(Session["UserId"].ToString());

            if (dt_cfp_status == null)
            {
                DataTable dt_feedback_Regular = objmaster.get_parameter_value("Feedback for Regular Students");
                if (dt_feedback_Regular.Rows[0]["parameter_value"].ToString() == "D")
                {
                    BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();

                    string encodedMsg = encode.EncryptData(dt_feedback_Regular.Rows[0]["disable_message"].ToString());

                    Response.Redirect("~/Student/Dashboard.aspx?param=true&msg=" + encodedMsg);
                }
            }
            else
            {
                //CFP Students
            }
        }
    }

    protected override void OnInit(EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            if (Request.Cookies["cept_login"] != null)
            {
                Session["UserId"] = Request.Cookies["cept_login"].Values["user_id"];
                Session["UserName"] = Request.Cookies["cept_login"].Values["user_name"];
                Session["user_type"] = Request.Cookies["cept_login"].Values["user_type"];
                Session["dept_code"] = Request.Cookies["cept_login"].Values["dept_code"];
                Session["prog_code"] = Request.Cookies["cept_login"].Values["prog_code"];
                Session["semester_code"] = Request.Cookies["cept_login"].Values["semester_code"];
                Session["year_code"] = Request.Cookies["cept_login"].Values["year_code"];
                Session["prog_level_code"] = Request.Cookies["cept_login"].Values["prog_level_code"];
                Session["gender"] = Request.Cookies["cept_login"].Values["gender"];

                if (Session["user_type"].ToString() == "A")
                {
                    admin_menu.Style.Add("display", "block");
                }
                if (Session["user_type"].ToString() == "A1")
                {
                    admin1_menu.Style.Add("display", "block");
                }
                if (Session["user_type"].ToString() == "A2")
                {
                    admin2_menu.Style.Add("display", "block");
                }
                else if (Session["user_type"].ToString() == "S")
                {
                    student_menu.Style.Add("display", "block");
                }
                else if (Session["user_type"].ToString() == "E")
                {
                    external_menu.Style.Add("display", "none");
                }
                else if (Session["user_type"].ToString() == "I")
                {
                    it_menu.Style.Add("display", "block");
                }

                ////if (Session["prog_code"].ToString() == "1" && Session["year_code"].ToString() == "Y2016")
                ////{
                //    fees_installment_menu.Style.Add("display", "block");
                //    fees_installment_menu1.Style.Add("display", "block");
                ////}
                ////else
                ////{
                ////    fees_installment_menu.Style.Add("display", "none");
                ////    fees_installment_menu1.Style.Add("display", "none");
                ////}
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        if (Session["UserId"] != null)
        {
            lblusername.Text =  Session["UserName"].ToString();
            //Lblusaernameanother.Text = "CEPT UNIVERSITY";

            ////if (Session["prog_code"].ToString() == "1" && Session["year_code"].ToString() == "Y2016")
            ////{
            //    fees_installment_menu.Style.Add("display", "block");
            //    fees_installment_menu1.Style.Add("display", "block");
            ////}
            ////else
            ////{
            ////    fees_installment_menu.Style.Add("display", "none");
            ////    fees_installment_menu1.Style.Add("display", "none");
            ////}
        }
    }

}
