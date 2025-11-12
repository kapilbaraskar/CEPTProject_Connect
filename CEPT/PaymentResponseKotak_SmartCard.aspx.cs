using BLL.Master;
using BLL.Utilities1;
using CCA.Util;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PaymentResponseKotak_SmartCard : System.Web.UI.Page
{
    #region <-- Variable Declaration -->

    Log objLog = new Log();
    Payment obj_payment = new Payment();

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string dept_code = "";
            string UID = "";

            //if (Session["dept_code"] != null)
            //{
            //    dept_code = Session["dept_code"].ToString();
            //}

            string workingKey = obj_payment.Get_Kotak_working_Key(dept_code);

            CCACrypto ccaCrypto = new CCACrypto();

            string encResponse = ccaCrypto.Decrypt(Request.Form["encResp"], workingKey);

            NameValueCollection Params = new NameValueCollection();

            string[] segments = encResponse.Split('&');

            foreach (string seg in segments)
            {
                string[] parts = seg.Split('=');
                if (parts.Length > 0)
                {
                    string Key = parts[0].Trim();
                    string Value = parts[1].Trim();
                    Params.Add(Key, Value);
                }
            }

            Log.PaymentTransactionLog("SmartCard Fees Payment Response From Kotak. " + encResponse);

            if (!IsPostBack)
            {
                PaymentRes paymentResponse = new PaymentRes();

                UID = Params["merchant_param1"].ToString();

                try
                {
                    paymentResponse.data.payment_mode = "Netbanking";

                    if (Params["order_status"] != null)
                    {
                        Log.PaymentTransactionLog("SmartCard Fees Payment transaction id on cancel payment  : " + Params["order_status"]);
                    }

                    //if (Session["SessionId"] != null && Session["UserId"] != null)
                    if (UID != null)
                    {
                        Payment objPayment = new Payment();

                        string message = objPayment.SavesmartcardPaymentDetails_Kotak(Params, ref paymentResponse, Params["merchant_param3"]);

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
                                        DataTable dt_transaction_data = objGetMasterDetails.get_smartcardTransactionsDetail_for_mail_send(paymentResponse.data.transaction_id);

                                        Dictionary<string, string> email_data = new Dictionary<string, string>();

                                        email_data["student_email"] = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();
                                        email_data["user_name"] = dtCandidatePersonalDetails.Rows[0]["user_name"].ToString().Trim().ToLower();
                                        //   email_data["program_name"] = "Cept Faculty of Architecture";
                                        email_data["program_name"] = "";

                                        if (dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString() != "")
                                        {
                                            email_data["program_name"] = dtCandidatePersonalDetails.Rows[0]["prog_level_name"].ToString();
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
                                        email_data["pg_type"] = "Kotak";

                                        string TomailIds = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();

                                        Log.PaymentTransactionLog("Mail id : " + dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower());

                                        Mail objmail = new Mail();

                                        string mail_status = objmail.SendEmailOnSmartCardfeesPaymentSuccess(email_data);

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

                            //WebService obj_service = new WebService();

                            //if (Session["installment_payment"] != null && Session["installment_payment"] == "Y")
                            //    obj_service.update_fees_installation_after_payment();
                            //else
                            //    obj_service.save_user_fees_after_online_payment();
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
                        //DataTable dtCandidatePersonalDetails = objGetMasterDetails.retrieve_student_data_for_modification(Session["UserId"].ToString());
                        DataTable dtCandidatePersonalDetails = objGetMasterDetails.retrieve_student_data_for_modification(UID);
                        DataTable dt_transaction_data = objGetMasterDetails.get_smartcardTransactionsDetail_for_mail_send(Request["ReferenceNo"].ToString());

                        Dictionary<string, string> dic_payment_fail_dtl = new Dictionary<string, string>();

                        dic_payment_fail_dtl["transaction_id"] = "";
                        dic_payment_fail_dtl["user_id"] = "";
                        dic_payment_fail_dtl["amount"] = "";
                        dic_payment_fail_dtl["transaction_date"] = "";

                        if (Request["ReferenceNo"] != null) dic_payment_fail_dtl["transaction_id"] = Request["ReferenceNo"].ToString();
                        //if (Session["UserId"] != null) dic_payment_fail_dtl["user_id"] = Session["UserId"].ToString();
                        if (UID != null) dic_payment_fail_dtl["user_id"] = UID;
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
                        //string mail_status = objmail.SendEmailOnfeesPaymentFail(dic_payment_fail_dtl);
                        string mail_status = objmail.SendEmailOnSmartCardfeesPaymentFail(dic_payment_fail_dtl);

                    }
                }
                catch (Exception ex)
                {
                }

                #endregion

                paymentResponse.data.payment_mode = Params["amount"];

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