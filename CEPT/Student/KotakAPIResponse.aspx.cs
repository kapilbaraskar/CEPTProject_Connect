using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Utilities1;
using BLL.Master;
using System.IO;
using System.Data;
using Newtonsoft.Json;
using CCA.Util;
using System.Collections.Specialized;
using System.Web.Script.Serialization;

public partial class Student_KotakAPIResponse : System.Web.UI.Page
{
    #region <-- Variable Declaration -->

    Log objLog = new Log();
    Payment obj_payment = new Payment();

    #endregion

    #region <-- Page Load -->

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string API_Response = "";

            if (Application["EncResponse"] != null)
            {
                API_Response = Application["EncResponse"].ToString();
                Log.PaymentTransactionLog("1. Payment Encrypt Response From Kotak API. " + API_Response);
                Application["EncResponse"] = "";
            }

            string dept_code = "";
            string UID = "";

            //Log.PaymentTransactionLog("---Start----Without-----Session-----------------------------------" + DateTime.Now + "-----------------------------------------------------");

            //if (Session["dept_code"] != null)
            //{
            //    dept_code = Session["dept_code"].ToString();
            //}

            string workingKey = obj_payment.Get_Kotak_working_Key(dept_code);

            CCACrypto ccaCrypto = new CCACrypto();

            //API_Response = "d960a5ecc1964d5f09adf8648c5d5b781d312194cd041b30335ae4038ab23f4a67b25ce1908f407493c5b9d0dd26ffa05c4327fd1b4b97fa6390464d01f2c00f4daeb0386bfb7ee02ef6b2618c69f1b61ac61ea959ee6cfddd14c5d9bc0feafffc3464dd5ece8a8a1cb66f3e3745362c290bc99a9a73d136ca812ec1649825fe5562682ad46823b4ebc2c1362619cda8b2d730bc198751c713934baaca19578dcf7fa74069888438772729fc605b80071c8a1011b7443d409bbad0d47d03ef596df92020d763b635242a8b0a53a2f4835f2e2f0851b441f3d141d617fd4a8c4aedcb3ce754d4d45ab9869b7426c8c11b9dd6ac870c2a5a122dec205cba2f476300bdddf40629192f447c832917cc7189397b03d3ea55937489ce8875ee567a2a9ee6fffdb2701f81af780a99333e3ac7a4b3257dcb8c82a2e3648ccd31d56ea3e8d3c2c7c794fed04d940ec123f5ac5c439e17e93b13bb6257ae3e0b4d0c1a708db2485d2ada7768848beec542f4dc6aef083556a8fab8cd82b048d94b09f8b4ca0a4e8ad22f3b648ec345d15b937aad47b44ca13a538d3b303a15652fbbacd50113a4848989131a3a90683abfa7bf33271df3cbc56af2db15f6755bc2c9d2ea139712fa6857b96de10927f4a0adb76dbd78d7344d539a3b054a83484a21f96675cc0322533dbfb7935abe21644b69277528576b2e36c49ac464da388a9b71c2d607830538c9228514cfe340cfc37bbd7919568d5e7e522e938cc6e2b8fb8d39ae38dd0d969faee34b14ac0b1ccf64ab13062e76a6e7ea9bb7207fc9b68cc775793246206ae29c5c87d33aa2a3e861624cf98c5c1da68b63280ba087667411821eb6b45fbcb112f61b6ad8621b3551fc03f1b8b6db616326b72e6063e5142d373fc944a5ca2d1f52a56e38812b035f6607c64aabbcd77c01cb5ac3350a41197d518fa599aef072635c6cac524bad4302a1a9206dda45574bb9593372f369795a1e671df89fda1a00bdaca71d9b9b81361f925e8618ac6750a4469a84ccd2bb0d10e17caac7dd1de51f6cd4b45eff718a6ec745d37c6e7e9d3196d19c1527f686cfcf4ee3560b570e101ef4ca6099a9ac4950afa02b74d61c4a3412a9f28b499dee56f4fca9b4ba7ed71ee2cf43ba526d5d93ed14a8216ece4a5db72a7bae148f9ea22e24b212bd80556f62d18549a72c200f7323a77db73417dd99ced8fc390597f4331544710e23bcc3d20404e4fdbc580d7bf746ca10f15b3fda4a9fd4b455b2a5beaedb31beffad47f8ea1ab0998f60d66c1a8675d274380c97612fdae798378ffb340550838663a2937e99dc891110af7a3421a2dde97bcecda2ba3435f4f5535bb3fe3f7256bb53a02e052acd71a57c6fc1587a1d4e8aadc2edcbdb5071c36c69cba1fe512083343e3e23f7820be3ddba4d0fe06bd21edefc8fca2973d8e3da73aea10978a66a4bf15f46a8ec68a44679df1ec9d488b2a3eec4e6c32b16ee654f366fb4a927ff9050a4155819121cf8962cf691ad3861f356b70e337329a0a1085339d944274221e1eac1886cf211b1190266019dd3c3cc2b4f637300299c98e3b6e0a010b39648007597478f00f8cdf603d75fb38ce98e4fab1125579a4e74d5fcd7e336d8256e61e7fc14b8d4";
            
            //string encResponse = ccaCrypto.Decrypt(API_Response, workingKey);
            string encResponse = obj_payment.DecryptResponse(API_Response.Trim());

            //NameValueCollection Params = new NameValueCollection();

            Log.PaymentTransactionLog("222. Payment Response From Kotak API. " + encResponse);

            JavaScriptSerializer ser = new JavaScriptSerializer();

            Dictionary<string, object> Params = ser.Deserialize<Dictionary<string, object>>(encResponse);

            string year_code = "-";
            if (year_code == "-") year_code = "";

            DataTable dtTransactionDetails = obj_payment.getTransactionDetailsforNEFTRTGS(Params["order_no"].ToString().Trim());//order_id

            string semester_code = dtTransactionDetails.Rows[0]["current_sem_code"].ToString();
            string cur_installment = dtTransactionDetails.Rows[0]["cash_collected_by"].ToString();
            string installment_payment = "Y";
            string user_type = dtTransactionDetails.Rows[0]["user_type"].ToString();
            string year_code_2 = dtTransactionDetails.Rows[0]["year_code"].ToString();
            UID = dtTransactionDetails.Rows[0]["user_id"].ToString();

            if (!IsPostBack)
            {
                PaymentRes paymentResponse = new PaymentRes();//Successful
                if (Params["order_status"].ToString() == "Shipped" || Params["order_status"].ToString() == "Successful")
                {
                    try
                    {
                        paymentResponse.data.payment_mode = "Netbanking";
                        //Log.PaymentTransactionLog("3. Payment Response From Kotak API. " + Params["order_status"].ToString());
                        Params["order_status"] = "Successful";

                        if (Params["order_status"] != null)
                        {
                            //Log.PaymentTransactionLog("transaction id on cancel payment  : " + Params["order_status"]);
                        }

                        //if (Session["SessionId"] != null && Session["UserId"] != null)
                        if (UID != null)
                        {
                            Payment objPayment = new Payment();
                            Params.Add("merchant_param1", UID);
                            Params.Add("merchant_param3", dtTransactionDetails.Rows[0]["dept_code"].ToString());
                            Params["order_status"] = Params["order_status"].ToString() == "Successful" ? "Success" : Params["order_status"].ToString(); //Success or failure message
                            
                            //Log.PaymentTransactionLog("4. Payment Response From Kotak API. " + Params["order_status"].ToString());

                            string message = objPayment.SavePaymentDetails_Kotak_API(Params, ref paymentResponse, Params["merchant_param3"].ToString());

                            //Log.PaymentTransactionLog("5. Payment Response From Kotak API. " + paymentResponse.status.Contains("paymentSuccess"));

                            if (paymentResponse.status.Contains("paymentSuccess"))
                            {
                                Masters objGetMasterDetails = new Masters();
                                Dictionary<string, object> param = new Dictionary<string, object>();
                                if (paymentResponse.data.user_id != null && paymentResponse.data.user_id != string.Empty)
                                {
                                    param["user_id"] = paymentResponse.data.user_id;

                                    DataTable dtCandidatePersonalDetails = objGetMasterDetails.retrieve_student_data_for_modification(paymentResponse.data.user_id);

                                    if (dtCandidatePersonalDetails != null && dtCandidatePersonalDetails.Rows.Count > 0)
                                    {
                                        paymentResponse.data.title = "";
                                        paymentResponse.data.first_name = dtCandidatePersonalDetails.Rows[0]["user_name"].ToString();

                                        //clsRegistration objclsRegistration = new clsRegistration();

                                        //DataTable dtApplicant = objclsRegistration.GetApplicantDetails(param);

                                        //if (dtApplicant != null && dtApplicant.Rows.Count > 0)
                                        //{
                                        paymentResponse.data.email_id = dtCandidatePersonalDetails.Rows[0]["mail"].ToString();
                                        // }

                                        #region Email
                                        try
                                        {

                                            DataTable dt_transaction_data = objGetMasterDetails.get_transactionsdetail_for_mail_send(paymentResponse.data.transaction_id);

                                            Dictionary<string, string> email_data = new Dictionary<string, string>();

                                            email_data["student_email"] = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();
                                            email_data["user_name"] = dtCandidatePersonalDetails.Rows[0]["user_name"].ToString().Trim().ToLower();
                                            email_data["year_code"] = dtCandidatePersonalDetails.Rows[0]["year_code"].ToString().Trim().ToLower();
                                            email_data["prog_code"] = dtCandidatePersonalDetails.Rows[0]["prog_code"].ToString().Trim().ToLower();
                                            email_data["dept_code"] = dtCandidatePersonalDetails.Rows[0]["dept_code"].ToString().Trim().ToLower();
                                            //   email_data["program_name"] = "Cept Faculty of Architecture";
                                            email_data["program_name"] = "";

                                            if (dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString() != "")
                                            {
                                                email_data["program_name"] = dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString();
                                                paymentResponse.data.program_course_desc = dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString();
                                            }
                                            else
                                            {
                                                email_data["program_name"] = "Faculty of Architecture";
                                            }

                                            email_data["transaction_id"] = paymentResponse.data.transaction_id;
                                            email_data["pg_transaction_id"] = paymentResponse.data.pg_transaction_id;
                                            email_data["user_id"] = paymentResponse.data.user_id;
                                            email_data["amount"] = "";
                                            email_data["transaction_date"] = "";
                                            if (dt_transaction_data != null)
                                            {
                                                email_data["pg_transaction_id"] = dt_transaction_data.Rows[0]["Citrus_TxRefNo"].ToString();
                                                email_data["amount"] = dt_transaction_data.Rows[0]["amount"].ToString();
                                                email_data["transaction_date"] = dt_transaction_data.Rows[0]["payment_return_date"].ToString();
                                            }
                                            
                                            email_data["pg_type"] = "Kotak API";

                                            string TomailIds = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();

                                            //Log.PaymentTransactionLog("Mail id : " + dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower());
                                            Mail objmail = new Mail();
                                            string mail_status = objmail.SendEmailOnfeesPaymentSuccess(email_data);
                                            //string mail_status = "success";

                                            if (mail_status == "success")
                                            {
                                                //Log.PaymentTransactionLog("Mail Sent to Student : " + paymentResponse.data.user_id);
                                            }
                                            else
                                            {
                                                Log.PaymentTransactionLog("Mail not Sent to Student : " + paymentResponse.data.user_id);
                                            }
                                        }
                                        catch (Exception ex)
                                        {
                                            Log.PaymentTransactionLog("Mail not Sent to Student  : " + paymentResponse.data.user_id + "-error : " + ex.ToString());

                                        }
                                        #endregion
                                    }
                                }

                                WebService obj_service = new WebService();

                                //Log.PaymentTransactionLog("0 : Before: " + Session["installment_payment"].ToString());

                                //if (Session["installment_payment"] != null && Session["installment_payment"].ToString() == "Y")
                                if (installment_payment == "Y")
                                    obj_service.update_fees_installation_after_payment_without_session(Params["merchant_param1"].ToString(), user_type, year_code, semester_code, cur_installment, Params["merchant_param3"].ToString(), year_code_2);// Do Something 15102020
                                else
                                    obj_service.save_user_fees_after_online_payment_without_session(Params["merchant_param1"].ToString(), year_code, semester_code, Params["merchant_param3"].ToString(), year_code_2);// Do Something 15102020

                                //obj_service.update_fees_installation_after_payment();
                                //obj_service.save_user_fees_after_online_payment();
                            }
                        }
                        else
                        {
                            paymentResponse.status = "paymentFail";
                            paymentResponse.data.message = "Error !! Session Expired.";
                            Log.PaymentTransactionLog("Payment Response Kotak : Session Expired. ");
                        }
                    }
                    catch (Exception ex)
                    {
                        paymentResponse.status = "paymentFail";
                        paymentResponse.data.message = "Exception : " + ex.Message;
                        Log.ExceptionLog(ex.Message);
                    }

                    #region Payment Fail Email

                    try
                    {
                        //if (Session["SessionId"] != null && Session["UserId"] != null && paymentResponse.status == "paymentFail" && Request["ReferenceNo"] != null)
                        if (UID != null && paymentResponse.status == "paymentFail" && Request["ReferenceNo"] != null)
                        {
                            Masters objGetMasterDetails = new Masters();
                            DataTable dtCandidatePersonalDetails = objGetMasterDetails.retrieve_student_data_for_modification(UID);//Session["UserId"].ToString()
                            DataTable dt_transaction_data = objGetMasterDetails.get_transactionsdetail_for_mail_send(Request["ReferenceNo"].ToString());

                            Dictionary<string, string> dic_payment_fail_dtl = new Dictionary<string, string>();

                            dic_payment_fail_dtl["transaction_id"] = "";
                            dic_payment_fail_dtl["user_id"] = "";
                            dic_payment_fail_dtl["amount"] = "";
                            dic_payment_fail_dtl["transaction_date"] = "";

                            if (Request["ReferenceNo"] != null) dic_payment_fail_dtl["transaction_id"] = Request["ReferenceNo"].ToString();
                            //if (Session["UserId"] != null) dic_payment_fail_dtl["user_id"] = Session["UserId"].ToString();
                            dic_payment_fail_dtl["user_id"] = UID;
                            dic_payment_fail_dtl["amount"] = dt_transaction_data.Rows[0]["amount"].ToString();
                            dic_payment_fail_dtl["transaction_date"] = dt_transaction_data.Rows[0]["created_date"].ToString();

                            dic_payment_fail_dtl["student_email"] = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();
                            dic_payment_fail_dtl["user_name"] = dtCandidatePersonalDetails.Rows[0]["user_name"].ToString().Trim().ToLower();

                            dic_payment_fail_dtl["program_name"] = "";

                            if (dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString() != "")
                            {
                                dic_payment_fail_dtl["program_name"] = dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString();
                            }
                            else
                            {
                                dic_payment_fail_dtl["program_name"] = "Faculty of Architecture";
                            }

                            //Send Mail
                            Mail objmail = new Mail();
                            string mail_status = objmail.SendEmailOnfeesPaymentFail(dic_payment_fail_dtl);
                        }
                    }
                    catch (Exception ex)
                    {
                    }

                    #endregion
                }
                else if (Params["order_status"].ToString() == "Awaited")
                {
                    paymentResponse.status = "paymentAwaited";
                    paymentResponse.data.transaction_id = Params["order_no"].ToString();//order_id
                    paymentResponse.data.pg_transaction_id = Params["reference_no"].ToString();//tracking_id
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Aborted")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction is cancelled by the User.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Auto-Cancelled")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction has not confirmed within 12 days hence auto cancelled by system.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Auto-Reversed")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Two identical transactions for same order number, both were successful at bank's end but we got response for only one of them, then next day during reconciliation we mark one of the transaction as auto reversed.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Invalid")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction sent to KOTAK with Invalid parameters, hence could not be processed further";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Cancelled")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction is cancelled by merchant.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Fraud")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "We update this during recon, the amount is different at bank’send and at KOTAK due to tampering.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Initiated")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction just arrived on billing shipping page and not processed further.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Refunded")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction is refunded.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Shipped")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction is confirmed.";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                else if (Params["order_status"].ToString() == "Unsuccessful")
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Transaction is not successful due to";
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }
                if (Params["order_status"].ToString() != "Successful")
                {
                    //Log.PaymentTransactionLog(DateTime.Now + "Payment Response Kotak API : " + Params["order_status"].ToString() + " " + paymentResponse.data.message);
                }

                paymentResponse.data.payment_mode = Params["order_amt"].ToString();//amount

                data.Value = JsonConvert.SerializeObject(paymentResponse);
            }
            templates.InnerHtml = File.ReadAllText(Server.MapPath("~/Scripts/Templates/PaymentResponseTemplates.htm"));
        }
        catch (Exception ex)
        {
            Log.PaymentTransactionLog(DateTime.Now + "KotakAPIResponse API Error: " + ex.ToString());
            objLog.ExceptionLogEntry("KotakAPIResponse API Error: " + ex.ToString());
            PaymentRes paymentResponse = new PaymentRes();
            paymentResponse.status = "paymentNotFound";
            data.Value = JsonConvert.SerializeObject(paymentResponse);
            templates.InnerHtml = File.ReadAllText(Server.MapPath("~/Scripts/Templates/PaymentResponseTemplates.htm"));
            //throw ex;
        }
    }

    #endregion
}