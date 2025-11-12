using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using BLL.Utilities1;
using System.IO;
using System.Data;
using Newtonsoft.Json;

public partial class BTG_PaymentResponseNetBankingTechnology : System.Web.UI.Page
{

    #region <-- Variable Declaration -->
    Log objLog = new Log();
    #endregion

    #region <-- Page Load -->
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Log.PaymentTransactionLog("Payment Response From Citrus. BTG ");

        

            if (!IsPostBack)
            {
                PaymentRes paymentResponse = new PaymentRes();

                try
                {
                    Payment objPayment = new Payment();

                    paymentResponse.data.payment_mode = "Netbanking";

                    string message = objPayment.BTG_SavePaymentDetails(Request, ref paymentResponse, "1b5f4a5d48d6c4a80218a6a105dbe34a1c4ea56a");

                    if (paymentResponse.status.Contains("paymentSuccess"))
                    {
                        Masters objGetMasterDetails = new Masters();
                        Dictionary<string, object> param = new Dictionary<string, object>();
                        if (paymentResponse.data.user_id != null && paymentResponse.data.user_id != string.Empty)
                        {
                            param["user_id"] = paymentResponse.data.user_id;
                            DataTable dt_BTG_payment_dtl = objGetMasterDetails.get_btg_payment_dtl(paymentResponse.data.user_id);

                            Mail objmail = new Mail();

                            string mail_status = objmail.SendEmailToBTG(dt_BTG_payment_dtl);

                            if (mail_status == "success")
                            {
                                Log.PaymentTransactionLog("Mail Sent to BTG Team : " + paymentResponse.data.user_id);
                            }
                            else
                            {
                                Log.PaymentTransactionLog("Mail not Sent to Team : " + paymentResponse.data.user_id);
                            }
                        }
                    }

                    templates.InnerHtml = File.ReadAllText(Server.MapPath("~/Scripts/Templates/PaymentResponseTemplates.htm"));
                }
                catch (Exception ex)
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Exception : " + ex.Message;
                    Log.ExceptionLog(ex.Message);
                }

                data.Value = JsonConvert.SerializeObject(paymentResponse);
            }
        }
        catch (Exception ex)
        {
            objLog.ExceptionLogEntry(ex.ToString());
            throw ex;
        }
    }
    #endregion
}