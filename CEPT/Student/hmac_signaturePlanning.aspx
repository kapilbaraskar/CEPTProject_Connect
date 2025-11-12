<%@ Page Language="C#" AutoEventWireup="true" %>

<%
    //string key = "0f46ed93f6da4e3ed22aab714cdc5beb648d6c89";
    string key = "6669e4d4d8249af1d69caf25cfaf66e4075bae4e";
string merchantId = Request["merchantId"];
string orderAmount = Request["orderAmount"];
string merchantTxnId = Request["merchantTxnId"];
string currency = Request["currency"];

string data = merchantId + orderAmount + merchantTxnId + currency;
try {
%>
<%= CitrusPay.MerchantKit.Infrastructure.CitrusPaySignatureRequestor.GenerateHMAC(data, key)%>
<%
}catch(Exception e){
		
}
%>
