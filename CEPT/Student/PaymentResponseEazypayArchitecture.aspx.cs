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

public partial class Student_PaymentResponseEazypayArchitecture : System.Web.UI.Page
{
    #region <-- Variable Declaration -->
    
    Log objLog = new Log();
    
    #endregion

    #region <-- Page Load -->

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //Dictionary<string, string> dic_Request = new Dictionary<string, string>();

            //dic_Request["Response Code"] = "E000";
            //dic_Request["Unique Ref Number"] = "1606303505557";
            //dic_Request["Service Tax Amount"] = "0.00";
            //dic_Request["Processing Fee Amount"] = "0.01";
            //dic_Request["Total Amount"] = "1.01";
            //dic_Request["Transaction Amount"] = "1";
            //dic_Request["Transaction Date"] = "30-06-2016 12:11:26";
            //dic_Request["Interchange Value"] = "";
            //dic_Request["TDR"] = "";
            //dic_Request["Payment Mode"] = "ICICIBANK_DEBIT_CARD";
            //dic_Request["SubMerchantId"] = "12345";
            //dic_Request["ReferenceNo"] = "FCCFARpa1admin1P1617014778";
            //dic_Request["ID"] = "109828";
            //dic_Request["RS"] = "d5b64dcb2b975862cd6f7c716a3f3beec873c1e673793032490cc908b69b96f9a39e9de39ec1075b6424913934e38d7c5c36d7e6b63316d70c2b7b0827787701";
            //dic_Request["TPS"] = "null";

            //string[] str_request = Request.Params.ToString().Split('&');

            //for (int i = 0; i < str_request.Length; i++)
            //{
            //    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/temp.txt", "" + str_request[i] + Environment.NewLine);
            //}

            Log.PaymentTransactionLog("Payment Response From Eazypay. ");

            if (!IsPostBack)
            {
                PaymentRes paymentResponse = new PaymentRes();

                try
                {
                    paymentResponse.data.payment_mode = "Netbanking";

                    //paymentResponse.data.user_id = "pa1admin";
                    //paymentResponse.data.transaction_id = "FCCFARpa1admin1P1617014038";
                    //paymentResponse.status = "paymentSuccess";

                    //paymentResponse.data.program_course_id = "PTM0001";
                    if (Request["Response Code"] != null)
                    {
                        Log.PaymentTransactionLog("transaction id on cancel payment  : " + Request["Response Code"]);
                    }

                    if (Session["SessionId"] != null && Session["UserId"] != null)
                    {
                        Payment objPayment = new Payment();

                        string message = objPayment.SavePaymentDetails_Eazypay(Request, ref paymentResponse, "1");// 1 = Architecture

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

                            WebService obj_service = new WebService();

                            if (Session["installment_payment"] != null && Session["installment_payment"] == "Y")
                                obj_service.update_fees_installation_after_payment();
                            else
                                obj_service.save_user_fees_after_online_payment();
                        }
                    }
                    else
                    {
                        paymentResponse.status = "paymentFail";
                        paymentResponse.data.message = "Error !! Session Expired.";
                        Log.PaymentTransactionLog("Payment Response Eazypay : Session Expired. ");
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
                    if (Session["SessionId"] != null && Session["UserId"] != null && paymentResponse.status == "paymentFail" && Request["ReferenceNo"] != null)
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