using BLL.Utilities1;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class EazypayPushNotification : System.Web.UI.Page
{
    Log objLog = new Log();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.Request.HttpMethod == "POST")
        {
            string key = "";
            Log.PaymentTransactionLog("PUSHNOTIFICATION  : Get Data");
            //string requestData = @"<XML><RT>Tran</RT><IcId>131390</IcId><TrnId>20020763351795</TrnId>
            //<PayMode>NET_BANKING_ICICI</PayMode>
            //<TrnDate>2020-02-07 12:29:21.0</TrnDate>
            //<SettleDT>NA</SettleDT>
            //<Status>Success</Status>
            //<ResponseCode>E000</ResponseCode>
            //<InitiateDT>07-Feb-20</InitiateDT>
            //<TranAmt>1</TranAmt>
            //<BaseAmt>1.0</BaseAmt>
            //<ProcFees>0.00</ProcFees>
            //<STax>0.0</STax>
            //<M_SGST>0</M_SGST>
            //<M_CGST>0</M_CGST>
            //<M_UTGST>0</M_UTGST>
            //<M_STCESS>0</M_STCESS>
            //<M_CTCESS>0</M_CTCESS>
            //<M_IGST>0.15</M_IGST>
            //<GSTState>DL</GSTState>
            //<BillingState>MH</BillingState>
            //<Remarks>Subject to realization</Remarks>
            //<HashVal>878c26cb621799f43b7cae344f15d3085dfa6112f50db14a102c39f2a2c3efbf3549603826d52216aa7766f1823efef64272b10a4843d9ec9b6c2fa69316092c</HashVal>
            //</XML>";

            string requestData = "";
            using (StreamReader reader = new StreamReader(HttpContext.Current.Request.InputStream))
            {
                requestData = reader.ReadToEnd();
            }
            Log.PaymentTransactionLog("Get Data " + requestData);
            if (!string.IsNullOrEmpty(requestData))
            {
                string decryptedText = DecryptFile(key, requestData);
                if (decryptedText != null)
                {
                    XmlDocument doc = new XmlDocument();
                    try
                    {
                        doc.LoadXml(decryptedText);
                        XmlNode trnIdNode = doc.SelectSingleNode("//TrnId");
                        string transactionId = (trnIdNode != null) ? trnIdNode.InnerText : string.Empty;

                        XmlNode statusNode = doc.SelectSingleNode("//Status");
                        string status = (statusNode != null) ? statusNode.InnerText : string.Empty;

                        XmlNode payModeNode = doc.SelectSingleNode("//PayMode");
                        string paymentMode = (payModeNode != null) ? payModeNode.InnerText : string.Empty;

                        XmlNode trnDateNode = doc.SelectSingleNode("//TrnDate");
                        string transactionDate = (trnDateNode != null) ? trnDateNode.InnerText : string.Empty;


                        XmlNode ResponseCodeNode = doc.SelectSingleNode("//ResponseCode");
                        string ResponseCodeDate = (ResponseCodeNode != null) ? trnDateNode.InnerText : string.Empty;

                        XmlNode remarkNode = doc.SelectSingleNode("//Remark");
                        string remark = (remarkNode != null) ? remarkNode.InnerText : string.Empty;
                        XmlNode tranAmtNode = doc.SelectSingleNode("//TranAmt");
                        decimal transactionAmount = (tranAmtNode != null) ? decimal.Parse(tranAmtNode.InnerText) : 0;
                        
                        
                        
                        Log.PaymentTransactionLog("PUSHNOTIFICATION  : Read Data");
                        Log.PaymentTransactionLog("PUSHNOTIFICATION transactionId : " + transactionId);
                        Log.PaymentTransactionLog("PUSHNOTIFICATION status : " + status);
                        Log.PaymentTransactionLog("PUSHNOTIFICATION paymentMode : " + paymentMode);
                        Log.PaymentTransactionLog("PUSHNOTIFICATION transactionDate : " + transactionDate);
                        Log.PaymentTransactionLog("PUSHNOTIFICATION transactionAmount : " + transactionAmount);
                        Log.PaymentTransactionLog("PUSHNOTIFICATION remark : " + remark);
                        Log.PaymentTransactionLog("PUSHNOTIFICATION ResponseCode : " + ResponseCodeDate);

                        ProcessNotification(transactionId, status, paymentMode, transactionDate, transactionAmount, ResponseCodeDate, remark);
                        Response.StatusCode = 200;
                        Response.Write("Notification processed successfully");
                        Response.End();
                    }
                    catch (Exception ex)
                    {
                        Response.StatusCode = 500;
                        Response.Write("Error processing notification: " + ex.Message);
                        Response.End();
                    }
                }
            }
            else
            {
                Log.PaymentTransactionLog("PUSHNOTIFICATION  : Empty request received");
                Response.StatusCode = 400;
                Response.Write("Empty request received");
                Response.End();
            }
        }
    }

    private void ProcessNotification(string transactionId, string status, string paymentMode, string transactionDate, decimal transactionAmount,string ResponseCode, string Remarks)
    {
        string query = "INSERT INTO IciciPushNotification (TransactionId, Status, PaymentMode, TransactionDate, TransactionAmount,created_date,ResponseCode,Remarks) " +
                   "VALUES (@TransactionId, @Status, @PaymentMode, @TransactionDate, @TransactionAmount,@created_date,@ResponseCode,@Remarks)";

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                // Add parameters to prevent SQL injection
                cmd.Parameters.AddWithValue("@TransactionId", transactionId);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
                cmd.Parameters.AddWithValue("@TransactionDate", transactionDate);
                cmd.Parameters.AddWithValue("@TransactionAmount", transactionAmount);
                cmd.Parameters.AddWithValue("@created_date", DateTime.Now);
                cmd.Parameters.AddWithValue("@ResponseCode", ResponseCode);
                cmd.Parameters.AddWithValue("@Remarks", Remarks);

                try
                {
                    Log.PaymentTransactionLog("PUSHNOTIFICATION Insert Data : TRUE");
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("PUSHNOTIFICATION Insert Data Exception: " + ex.Message);
                    // Handle exception (log it, rethrow, or manage as needed)

                    con.Close();
                    throw new Exception("Error processing payment notification", ex);
                }
            }
        }
    }


    public static string DecryptFile(string key, string inputParam)
    {
        try
        {
            key = "3800243178901046";
            // Convert the key to bytes
            byte[] raw = Encoding.UTF8.GetBytes(key);

            
            using (Aes aesCipher = Aes.Create())
            {
                aesCipher.Key = raw;
                aesCipher.Mode = CipherMode.ECB;
                aesCipher.Padding = PaddingMode.PKCS7;  
                byte[] base64Bytes = Convert.FromBase64String(inputParam);
                ICryptoTransform decryptor = aesCipher.CreateDecryptor(aesCipher.Key, null);
                byte[] plaintextBytes = decryptor.TransformFinalBlock(base64Bytes, 0, base64Bytes.Length);

                // Convert decrypted bytes to string and return
                return Encoding.UTF8.GetString(plaintextBytes);
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine("Error during decryption: " + ex.Message);
            return null;
        }
    }
}