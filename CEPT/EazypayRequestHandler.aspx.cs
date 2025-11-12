using BLL.Master;
using BLL.Utilities1;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EazypayRequestHandler : System.Web.UI.Page
{
    #region <-- Variable Declaration -->
    Log objLog = new Log();
    Payment obj_payment = new Payment();
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            string year_code = "-";
            string semester_code = "";
            string cur_installment = "";
            string installment_payment = "";
            string user_type = "";
            string year_code_2 = "";
            string dept_code = "";

            if (year_code == "-") year_code = "";

            Log.PaymentTransactionLog("Eazpay Reference No payment  : " + Request["ReferenceNo"]);
            DataTable dtTransactionDetails = obj_payment.getTransactionDetailsforNEFTRTGS(Request["ReferenceNo"].ToString().Trim());
            semester_code = dtTransactionDetails.Rows[0]["current_sem_code"].ToString();
            cur_installment = dtTransactionDetails.Rows[0]["cash_collected_by"].ToString();
            installment_payment = "Y";
            user_type = dtTransactionDetails.Rows[0]["user_type"].ToString();
            year_code_2 = dtTransactionDetails.Rows[0]["year_code"].ToString();
            dept_code = dtTransactionDetails.Rows[0]["dept_code"].ToString();

            Log.PaymentTransactionLog("Eazpay Reference current_sem_code  : " + semester_code);
            Log.PaymentTransactionLog("Eazpay Reference cur_installment  : " + cur_installment);
            Log.PaymentTransactionLog("Eazpay Reference user_type  : " + user_type);
            Log.PaymentTransactionLog("Eazpay Reference year_code_2  : " + year_code_2);
            Log.PaymentTransactionLog("Eazpay Reference dept_code  : " + dept_code);

            if (!IsPostBack)
            {
                PaymentRes paymentResponse = new PaymentRes();

                try
                {
                    paymentResponse.data.payment_mode = "Netbanking";
                    if (Request["Response Code"] != null)
                    {
                        Log.PaymentTransactionLog("transaction id on cancel payment  : " + Request["Response Code"]);
                    }


                    //if (Session["SessionId"] != null && Session["UserId"] != null)
                    //{
                        Payment objPayment = new Payment();

                        string message = objPayment.SavePaymentDetails_Eazypay(Request, ref paymentResponse, "15");// 2 = Design
                        Log.PaymentTransactionLog("Eazypay EazypayRequestHandler Page Result  : " + message);

                    if (paymentResponse.status.Contains("paymentSuccess"))
                    {
                        Log.PaymentTransactionLog("Eazypay EazypayRequestHandler Page Result  : paymentSuccess ");
                        
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
                                paymentResponse.data.email_id = dtCandidatePersonalDetails.Rows[0]["mail"].ToString();
                                #region Email
                                try
                                {

                                    DataTable dt_transaction_data = objGetMasterDetails.get_transactionsdetail_for_mail_send(paymentResponse.data.transaction_id);
                                    Dictionary<string, string> email_data = new Dictionary<string, string>();
                                    email_data["student_email"] = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();
                                    email_data["user_name"] = dtCandidatePersonalDetails.Rows[0]["user_name"].ToString().Trim().ToLower();
                                    email_data["program_name"] = "";

                                    if (dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString() != "")
                                    {
                                        email_data["program_name"] = dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString();
                                    }
                                    else
                                    {
                                        email_data["program_name"] = "Faculty of Design";
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
                                    email_data["pg_type"] = "Eazypay";

                                    string TomailIds = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();

                                    Log.PaymentTransactionLog("Mail id : " + dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower());
                                    Mail objmail = new Mail();
                                    string mail_status = objmail.SendEmailOnfeesPaymentSuccess(email_data);

                                    if (mail_status == "success")
                                    {
                                        Log.PaymentTransactionLog("Mail Sent to Student : " + paymentResponse.data.user_id);
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

                        Log.PaymentTransactionLog("Eazypay EazypayRequestHandler Page Call WebService ");
                        WebService obj_service = new WebService();
                        Log.PaymentTransactionLog("Eazypay EazypayRequestHandler Page Call installment_payment " + installment_payment);
                        //if (Session["installment_payment"] != null && Session["installment_payment"] == "Y")
                        if (installment_payment == "Y")
                        {
                            obj_service.update_fees_installation_after_payment_without_session(paymentResponse.data.user_id, user_type, year_code, semester_code, cur_installment, dept_code.ToString(), year_code_2);
                        }
                        else
                        {
                            obj_service.save_user_fees_after_online_payment();
                        }
                        Log.PaymentTransactionLog("Eazypay EazypayRequestHandler Page After Call WebService");
                    }
                    //}
                    //else
                    //{
                    //    paymentResponse.status = "paymentFail";
                    //    paymentResponse.data.message = "Error !! Session Expired.";
                    //    Log.PaymentTransactionLog("Payment Response Eazypay : Session Expired. ");
                    //}
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
                    if (paymentResponse.status == "paymentFail" && Request["ReferenceNo"] != null)
                    {
                        Masters objGetMasterDetails = new Masters();
                        DataTable dtCandidatePersonalDetails = objGetMasterDetails.retrieve_student_data_for_modification(Session["UserId"].ToString());
                        DataTable dt_transaction_data = objGetMasterDetails.get_transactionsdetail_for_mail_send(Request["ReferenceNo"].ToString());

                        Dictionary<string, string> dic_payment_fail_dtl = new Dictionary<string, string>();

                        dic_payment_fail_dtl["transaction_id"] = "";
                        dic_payment_fail_dtl["user_id"] = "";
                        dic_payment_fail_dtl["amount"] = "";
                        dic_payment_fail_dtl["transaction_date"] = "";

                        if (Request["ReferenceNo"] != null) dic_payment_fail_dtl["transaction_id"] = Request["ReferenceNo"].ToString();
                        if (Session["UserId"] != null) dic_payment_fail_dtl["user_id"] = Session["UserId"].ToString();
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
                            dic_payment_fail_dtl["program_name"] = "Faculty of Design";
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

                data.Value = JsonConvert.SerializeObject(paymentResponse);
            }
            templates.InnerHtml = File.ReadAllText(Server.MapPath("~/Scripts/Templates/PaymentResponseTemplates.htm"));
        }
        catch (Exception ex)
        {
            objLog.ExceptionLogEntry(ex.ToString());
            throw ex;
        }
    }
}