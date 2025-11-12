<%@ Page Language="C#" AutoEventWireup="true" %>

<%
    //string key = "239fb259d583cf7643ec6bac4451001483ea08d0";
    string key = "e7168bf14d5e574138cfd98c0db880f6eae46cfa";
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
