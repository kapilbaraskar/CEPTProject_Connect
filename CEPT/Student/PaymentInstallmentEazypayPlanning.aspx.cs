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

public partial class Student_PaymentInstallmentEazypayPlanning : System.Web.UI.Page
{
    #region <-- Variable Declaration -->
    Log objLog = new Log();
    #endregion

    #region <-- Page Load -->
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Log.PaymentTransactionLog("Payment Response From Eazypay. ");

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

                    if (Session["SessionId"] != null && Session["UserId"] != null)
                    {
                        Payment objPayment = new Payment();

                        string message = objPayment.SavePaymentDetails_Eazypay(Request, ref paymentResponse, "4");// 4 = Planning

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
                                    paymentResponse.data.email_id = dtCandidatePersonalDetails.Rows[0]["mail"].ToString();

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
                                            email_data["program_name"] = "Faculty of Planning";
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
                            //obj_service.save_user_fees_after_online_payment();
                            obj_service.update_fees_installation_after_payment();
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