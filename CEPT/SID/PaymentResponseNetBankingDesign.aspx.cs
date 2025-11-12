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

public partial class SID_PaymentResponseNetBankingDesign : System.Web.UI.Page
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
                    Payment objPayment = new Payment();
                    
                    paymentResponse.data.payment_mode = "Netbanking";

                    string message = objPayment.SID_SavePaymentDetails(Request, ref paymentResponse, "e7168bf14d5e574138cfd98c0db880f6eae46cfa");

                    if (paymentResponse.status.Contains("paymentSuccess"))
                    {
                        Masters objGetMasterDetails = new Masters();
                        Dictionary<string, object> param = new Dictionary<string, object>();
                        if (paymentResponse.data.user_id != null && paymentResponse.data.user_id != string.Empty)
                        {
                            param["user_id"] = paymentResponse.data.user_id;
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