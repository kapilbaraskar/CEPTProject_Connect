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

public partial class PaymentResponseKotakDEN : System.Web.UI.Page
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
            string dept_code = "";

            //if (Session["dept_code"] != null) 19062019
            //{
            //    dept_code = Session["dept_code"].ToString();
            //}

            string workingKey = obj_payment.Get_Kotak_working_Key(dept_code);

            CCACrypto ccaCrypto = new CCACrypto();

            Log.PaymentTransactionLog("0. Encrpted Response From Kotak Neft-Rtgs : " + Request.Form["encResp"].ToString());

            string encResponse = ccaCrypto.Decrypt(Request.Form["encResp"].ToString().Trim(), workingKey); //19062019

            //string encResponse = "order_id=FCCFARPG1908591P2021084608&tracking_id=109037984085&bank_ref_no=NEFT254951602&order_status=Success&payment_mode=NEFT-RTGS&card_name=Kotak Mahindra Bank&status_message=&currency=INR&amount=189000.00&transaction_date=15-12-2020 00:00:00";
            
            //string encResponse = "order_id=FCCFARPG1805171P2021070668&tracking_id=109892757125&bank_ref_no=NEFT221190668&order_status=Success&payment_mode=NEFT-RTGS&card_name=Kotak Mahindra Bank&status_message=&currency=INR&amount=1.00&transaction_date=04-07-2020 00:00:00";

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

            Log.PaymentTransactionLog("1. Response From Kotak Neft-Rtgs : " + encResponse);

            //string[] merchant_param4 = Params["merchant_param4"].ToString().Split('#');

            //string year_code = merchant_param4[0].Trim();
            //string semester_code = merchant_param4[1].Trim();
            //string cur_installment= merchant_param4[2].Trim();
            //string installment_payment = merchant_param4[3].Trim();
            //string user_type = merchant_param4[4].Trim();
            //string year_code_2 = merchant_param4[5].Trim();

            string year_code = "-";
            if (year_code == "-") year_code = "";

            DataTable dtTransactionDetails = obj_payment.getTransactionDetailsforNEFTRTGS(Params["order_id"].ToString().Trim());

            string semester_code = dtTransactionDetails.Rows[0]["current_sem_code"].ToString();
            string cur_installment= dtTransactionDetails.Rows[0]["cash_collected_by"].ToString();
            string installment_payment = "Y";
            string user_type = dtTransactionDetails.Rows[0]["user_type"].ToString();
            string year_code_2 = dtTransactionDetails.Rows[0]["year_code"].ToString();

            Params.Add("merchant_param1", dtTransactionDetails.Rows[0]["user_id"].ToString());
            Params.Add("merchant_param3", dtTransactionDetails.Rows[0]["dept_code"].ToString());

            //Log.PaymentTransactionLog("--------------------------------------------------------------------------------------------------------");

            //Log.PaymentTransactionLog("2. Response From Kotak Neft-Rtgs : " + encResponse);
            
            //Log.PaymentTransactionLog("Payment Response From Kotak Neft Rtgs.");

            if (!IsPostBack)
            {
                PaymentRes paymentResponse = new PaymentRes();

                try
                {
                    paymentResponse.data.payment_mode = "NeftRtgs";//Netbanking

                    if (Params["order_status"] != null)
                    {
                        //Log.PaymentTransactionLog("transaction id on cancel payment  : " + Params["order_status"]);
                    }

                    //if (Session["SessionId"] != null && Session["UserId"] != null) 19062019
                    //{
                    Payment objPayment = new Payment();

                    string message = objPayment.SavePaymentDetails_Kotak_Neft_Rtgs(Params, ref paymentResponse, Params["merchant_param3"]);

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

                                    //Log.PaymentTransactionLog("Mail id : " + dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower());
                                    Mail objmail = new Mail();
                                    string mail_status = objmail.SendEmailOnfeesPaymentSuccess(email_data);

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

                        if (installment_payment == "Y")//Session["installment_payment"] != null && 
                            obj_service.update_fees_installation_after_payment_neft_rtgs(Params["merchant_param1"].ToString(), user_type, year_code, semester_code, cur_installment, Params["merchant_param3"].ToString(), year_code_2);// Do Something 20062019
                        else
                            obj_service.save_user_fees_after_online_payment_neft_rtgs(Params["merchant_param1"].ToString(), year_code, semester_code, Params["merchant_param3"].ToString(), year_code_2);// Do Something 20062019
                    }
                    //}19062019
                    //else
                    //{
                    //    paymentResponse.status = "paymentFail";
                    //    paymentResponse.data.message = "Error !! Session Expired.";
                    //    Log.PaymentTransactionLog("Payment Response Kotak : Session Expired. ");
                    //}19062019
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
                    if (paymentResponse.status == "paymentFail" && Request["ReferenceNo"] != null)//Session["SessionId"] != null && Session["UserId"] != null && 19062019
                    {
                        Masters objGetMasterDetails = new Masters();
                        DataTable dtCandidatePersonalDetails = objGetMasterDetails.retrieve_student_data_for_modification(Params["merchant_param1"].ToString());
                        DataTable dt_transaction_data = objGetMasterDetails.get_transactionsdetail_for_mail_send(Request["ReferenceNo"].ToString());

                        Dictionary<string, string> dic_payment_fail_dtl = new Dictionary<string, string>();

                        dic_payment_fail_dtl["transaction_id"] = "";
                        dic_payment_fail_dtl["user_id"] = "";
                        dic_payment_fail_dtl["amount"] = "";
                        dic_payment_fail_dtl["transaction_date"] = "";

                        if (Request["ReferenceNo"] != null) dic_payment_fail_dtl["transaction_id"] = Request["ReferenceNo"].ToString();
                        dic_payment_fail_dtl["user_id"] = Params["merchant_param1"].ToString();//if (Session["UserId"] != null) before it is removed 19062019
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

    #endregion
}