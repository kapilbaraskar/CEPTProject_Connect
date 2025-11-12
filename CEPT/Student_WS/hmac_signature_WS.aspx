<%@ Page Language="C#" AutoEventWireup="true" %>

<%
    //string key = "f5fbd0ca0c26d458c9db6898768fe09caa5b2aff";

   // string key = "2a115ce5eca93b1f40437bf63d983f0a675f44eb";


    string key = "80f8c429f86390a54ced81128c266dd6ccb73797";
string merchantId = Request["merchantId"];
string orderAmount = Request["orderAmount"];
string merchantTxnId = Request["merchantTxnId"];
string currency = Request["currency"];

string data = merchantId + orderAmount + merchantTxnId + currency;
BLL.Utilities1.Log.PaymentTransactionLog("Request data :" + data);
try {
    string rqHMAC=CitrusPay.MerchantKit.Infrastructure.CitrusPaySignatureRequestor.GenerateHMAC(data, key);
    BLL.Utilities1.Log.PaymentTransactionLog("Request HMAC :" +rqHMAC);
%>
<%= rqHMAC %>
<%
}catch(Exception e){
		
}
%>
