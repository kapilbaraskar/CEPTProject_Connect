<%@ Page Language="C#" AutoEventWireup="true" %>

<%
string key = "a071ad4f6cf52cf1bebcd9405601d41adf61e23e";
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
