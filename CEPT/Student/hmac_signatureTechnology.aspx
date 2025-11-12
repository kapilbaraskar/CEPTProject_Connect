<%@ Page Language="C#" AutoEventWireup="true" %>

<%
//string key = "a1281ada98d4d615d33badbb9aeecc427d14eb8d";
    string key = "1b5f4a5d48d6c4a80218a6a105dbe34a1c4ea56a";
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
