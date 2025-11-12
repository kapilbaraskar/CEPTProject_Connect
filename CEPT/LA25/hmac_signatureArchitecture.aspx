<%@ Page Language="C#" AutoEventWireup="true" %>

<%
    //string key = "f5fbd0ca0c26d458c9db6898768fe09caa5b2aff";

    string key = "c047a9a794057c3bf1026adc40ebcbb5a19bc5c8";
    string merchantId = Request["merchantId"];
    string orderAmount = Request["orderAmount"];
    string merchantTxnId = Request["merchantTxnId"];
    string currency = Request["currency"];

    string data = merchantId + orderAmount + merchantTxnId + currency;
    BLL.Utilities1.Log.PaymentTransactionLog("Request data :" + data);
    try
    {
        string rqHMAC = CitrusPay.MerchantKit.Infrastructure.CitrusPaySignatureRequestor.GenerateHMAC(data, key);
        BLL.Utilities1.Log.PaymentTransactionLog("Request HMAC :" + rqHMAC);
%>
<%= rqHMAC %>
<%
}
catch (Exception e)
{

}
%>
