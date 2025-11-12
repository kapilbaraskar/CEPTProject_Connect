using BLL.Master;
using BLL.Utilities1;
using CCA.Util;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PaymentResponseKotakReconciliationDEN : System.Web.UI.Page
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
            
            string workingKey = obj_payment.Get_Kotak_working_Key(dept_code);

            CCACrypto ccaCrypto = new CCACrypto();

            Log.PaymentTransactionLog("Start. Recon Encrpted Response From Kotak Neft-Rtgs : " + Request.Form["encResp"].ToString());

            string encResponse = ccaCrypto.Decrypt(Request.Form["encResp"].ToString().Trim(), workingKey); //19062019

            //string encResponse = "order_id=FCCPFTucadmin4P1920055287&tracking_id=308005259297&bank_ref_no=1563172303714&order_status=Success&failure_message=&payment_mode=Credit Card&card_name=Visa&status_code=null&status_message=Y&currency=INR&amount=151000.00&billing_name=Mayur Panchal&billing_address=B-902, Safal Pegasus, Opp. Venus Atlantis&billing_city=Ahmedabad&billing_state=Gujarat&billing_zip=380015&billing_country=India&billing_tel=9157379787&billing_email=mpanchal2707@gmail.com&delivery_name=Mayur Panchal&delivery_address=B-902, Safal Pegasus, Opp. Venus Atlantis&delivery_city=Ahmedabad&delivery_state=Gujarat&delivery_zip=380015&delivery_country=India&delivery_tel=9157379787&merchant_param1=ucadmin&merchant_param2=ddd&merchant_param3=5&merchant_param4=#4#1#Y#S#Y2018&merchant_param5=&vault=N&offer_type=null&offer_code=null&discount_value=0.0&mer_amount=151000.00&sub_account_id=CEPTFTK&eci_value=null&retry=N&response_code=0&billing_notes=Test&trans_date=15/07/2019 12:01:56&bin_country=RUSSIAN FEDERATION";

            NameValueCollection Params = new NameValueCollection();
            Log.PaymentTransactionLog("-=-=-=-=-=-=-=-=-=-=----------------------------------------------------------------------------------------------");
            Log.PaymentTransactionLog("Start. Recon - Response From Kotak Neft-Rtgs : " + encResponse);

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

            Log.PaymentTransactionLog("Con. Recon - Response From Kotak Neft-Rtgs : " + encResponse);

            string[] merchant_param4 = Params["merchant_param4"].ToString().Split('#');

            string year_code = merchant_param4[0].Trim();
            string semester_code = merchant_param4[1].Trim();
            string cur_installment = merchant_param4[2].Trim();
            string installment_payment = merchant_param4[3].Trim();
            string user_type = merchant_param4[4].Trim();
            string year_code_2 = merchant_param4[5].Trim();

            if (year_code == "-") year_code = "";

            Log.PaymentTransactionLog("End. Recon - Response From Kotak Neft-Rtgs : " + merchant_param4 + year_code + semester_code + cur_installment + installment_payment + user_type + year_code_2);
            Log.PaymentTransactionLog("-=-=-=-=-=-=-=-=-=-----------------------------------------------------------------------------------------------");

        }
        catch (Exception Ex)
        {
            Log.PaymentTransactionLog("Error : " + DateTime.Now + Ex.ToString());
        }
    }
    #endregion
}