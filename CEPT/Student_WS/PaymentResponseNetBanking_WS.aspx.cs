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
using System.Net.Mail;
using System.Configuration;

public partial class Student_PaymentResponseNetBankingArchitecture : System.Web.UI.Page
{
    #region <-- Variable Declaration -->
    Log objLog = new Log();
    #endregion

    #region <-- Page Load -->
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Log.PaymentTransactionLog("Payment Response From Citrus. ");

            if (!IsPostBack)
            {
                PaymentRes paymentResponse = new PaymentRes();

                try
                {
                    paymentResponse.data.payment_mode = "Netbanking";

                    if (Session["SessionId"] != null && Session["UserId"] != null)
                    {
                        Payment objPayment = new Payment();



                        string message = objPayment.SavePaymentDetails(Request, ref paymentResponse, "80f8c429f86390a54ced81128c266dd6ccb73797");



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
                                    Log.PaymentTransactionLog("dtCandidatePersonalDetails is not null");

                                    paymentResponse.data.title = "";
                                    paymentResponse.data.first_name = dtCandidatePersonalDetails.Rows[0]["user_name"].ToString();

                                    //clsRegistration objclsRegistration = new clsRegistration();

                                    //DataTable dtApplicant = objclsRegistration.GetApplicantDetails(param);

                                    //if (dtApplicant != null && dtApplicant.Rows.Count > 0)
                                    //{
                                    paymentResponse.data.email_id = dtCandidatePersonalDetails.Rows[0]["mail"].ToString();
                                    // }

                                    try
                                    {
                                        string Message = "";

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

                                        string TomailIds = dtCandidatePersonalDetails.Rows[0]["mail"].ToString().Trim().ToLower();

                                        Log.PaymentTransactionLog("Mail id : " + TomailIds);

                                        mail.From = new MailAddress(sending_email, sending_email, System.Text.Encoding.UTF8);


                                        mail.To.Add(TomailIds);
                                        mail.Subject = "Registration Details - CEPT";

                                        Message = "Dear, " + dtCandidatePersonalDetails.Rows[0]["user_name"].ToString() + "";
                                        Message += "<br /><p>Thanks for appliying in at CEPT University.</p>";
                                        Message += "<br />Your Merchant(CEPT) Order Number : " + paymentResponse.data.transaction_id + "";
                                        Message += "<br />Your Transaction Reference Number :  " + paymentResponse.data.pg_transaction_id + "";
                                        Message += "<br />Your Student Code  :  " + paymentResponse.data.user_id + "";


                                        Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                                        mail.Body = Message.ToString();
                                        mail.IsBodyHtml = true;

                                        SmtpServer.Send(mail);

                                        Log.PaymentTransactionLog("Mail Send to Student : " + paymentResponse.data.user_id);
                                    }
                                    catch (Exception ex)
                                    {
                                        Log.PaymentTransactionLog("Mail not Send to Student : " + paymentResponse.data.user_id);
                                        
                                    }
                                }
                                else
                                {
                                    

                                    Log.PaymentTransactionLog("dtCandidatePersonalDetails is null");
                                }
                            }


                            WebService_WS obj_service = new WebService_WS();
                            obj_service.save_ws_user_fees_after_online_payment();
                        }
                    }
                    else
                    {
                        paymentResponse.status = "paymentFail";
                        paymentResponse.data.message = "Error !! Session Expired.";
                        Log.PaymentTransactionLog("Payment Response Citrus : Session Expired. ");
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