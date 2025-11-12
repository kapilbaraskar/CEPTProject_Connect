<%@ Page Language="C#" AutoEventWireup="true"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta HTTP-EQUIV="Content-Type" CONTENT="text/html;CHARSET=iso-8859-1">
<title>Response</title>
<link href="css/default.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div id="page-header">
		<div class="page-wrap">
			<div class="logo-wrapper">
				<a href="/citruspay-admin-site/"> <img height="32" width="81"
					src="images/logo_citrus.png" alt="Citrus" />
				</a>
			</div>
		</div>
	</div>
	<div id="page-client-logo">&#160;</div>
	<div id="page-wrapper">
		<div class="box-white">
			<div class="page-content">
				<!-- content goes here -->
				<div>
					<h3>Transaction Response</h3>
					<ul class="tbl-wrapper clearfix" id="chkoutPageUserPramList">
						<li class="tbl-header">
							<div class="tbl-col col-1">Txn Id</div>
							<div class="tbl-col col-3">Txn Ref No</div>
							<div class="tbl-col col-3">PG Txn Id</div>
							<div class="tbl-col col-3">Txn Status</div>
							<div class="tbl-col col-3">Txn Amount</div>
							<div class="tbl-col col-6">Txn Message</div>
						</li>
                        <%
                            String key = "f5fbd0ca0c26d458c9db6898768fe09caa5b2aff";
						String data="";
						String txnId=Request["TxId"];
						String txnStatus=Request["TxStatus"]; 
						String amount=Request["amount"]; 
						String pgTxnId=Request["pgTxnNo"];
						String issuerRefNo=Request["issuerRefNo"]; 
						String authIdCode=Request["authIdCode"];
						String firstName=Request["firstName"];
						String lastName=Request["lastName"];
						String pgRespCode=Request["pgRespCode"];
                        String zipCode = Request["addressZip"];
						String reqSignature=Request["signature"];
						
						String signature="";
						bool flag = true;
						if (txnId != null) {
							data += txnId;
						}
						if (txnStatus != null) {
							data += txnStatus;
						}
						if (amount != null) {
							data += amount;
						}
						if (pgTxnId != null) {
							data += pgTxnId;
						}
						if (issuerRefNo != null) {
							data += issuerRefNo;
						}
						if (authIdCode != null) {
							data += authIdCode;
						}
						if (firstName != null) {
							data += firstName;
						}
						if (lastName != null) {
							data += lastName;
						}
						if (pgRespCode != null) {
							data += pgRespCode;
						}
						if (zipCode != null) {
							data += zipCode;
						}
                        
                        signature = CitrusPay.MerchantKit.Infrastructure.CitrusPaySignatureRequestor.GenerateHMAC(data, key);
                        BLL.Utilities1.Log.PaymentTransactionLog("Response reqSignature HMAC :" + reqSignature);
                        BLL.Utilities1.Log.PaymentTransactionLog("Response HMAC :" + signature);
						if(reqSignature !=null && !signature.Equals(reqSignature)){
								flag = false;
						}
						if(flag){  
                            
                           %>

						<li>
							<div class="tbl-col col-1">
								<%
									Response.Write(Request["TxId"] == null ? "" : Request["TxId"]);
								%>
							</div>
							<div class="tbl-col col-3">
								<%
									Response.Write(Request["TxRefNo"] == null ? "" : Request["TxRefNo"]);
								%>
							</div>
							<div class="tbl-col col-3">
								<%
									Response.Write(Request["pgTxnNo"] == null ? "" : Request["pgTxnNo"]);
								%>
							</div>
							
							<div class="tbl-col col-3">
								<%
									Response.Write(Request["TxStatus"] == null ? "" : Request["TxStatus"]);
								%>
							</div>
							<div class="tbl-col col-3">
								<%
									Response.Write(Request["amount"] == null ? "" : Request["amount"]);
								%>
							</div>
							<div class="tbl-col col-6">
								<%
									if(Request["TxMsg"] != null){
										Response.Write(Request["TxMsg"] == null ? "" : Request["TxMsg"]);
									}else if(Request["mandatoryErrorMsg"]  != null){
										Response.Write(Request["mandatoryErrorMsg"] );
									}else if(Request["paidTxnExists"] !=null){
										Response.Write(Request["paidTxnExists"] );
									}
								%>
							</div>

						</li>
                        <%
							}else{
						%>
						<li>
							<div class="tbl-col col-6">Request Signature Error
                            
                            </div>

						</li>
						<%
							}
						%>

					</ul>				
					<br/>
					<br/>							
					<ul class="form-wrapper add-merchant clearfix"">
						<li class="clearfix"><label>First Name: </label> <%
                                                                             Response.Write(Request["firstName"] == null ? "" : Request["firstName"]);
 %></li>
						<li class="clearfix"><label>Last Name: </label> <%
                                                                            Response.Write(Request["lastName"] == null ? "" : Request["lastName"]);
 %></li>
						<li class="clearfix"><label>Email: </label> <%
                                                                        Response.Write(Request["email"] == null ? "" : Request["email"]);
 %></li>
						<li class="clearfix"><label>Address:  </label> <%
                                                                           Response.Write(Request["addressStreet1"] == null ? "" : Request["addressStreet1"]);
                                                                           Response.Write(Request["addressStreet2"] == null ? "" : Request["addressStreet2"]);
 %></li>
						<li class="clearfix"><label>City: </label> <%
                                                                       Response.Write(Request["addressCity"] == null ? "" : Request["addressCity"]);
 %></li>
						<li class="clearfix"><label>State: </label> <%
                                                                        Response.Write(Request["addressState"] == null ? "" : Request["addressState"]);
 %></li>
						<li class="clearfix"><label>Country: </label> <%
                                                                          Response.Write(Request["addressCountry"] == null ? "" : Request["addressCountry"]);
 %></li>
						<li class="clearfix"><label>Zip Code: </label> <%
                                                                           Response.Write(Request["addressZip"] == null ? "" : Request["addressZip"]);
 %></li>
 <li class="clearfix"><label>Mobile No: </label> <%
                                                                           Response.Write(Request["mobileNo"] == null ? "" : Request["mobileNo"]);
 %></li>
					</ul>

				</div>
				<!-- end content -->
			</div>
		</div>
	</div>
	<div
		style="padding-left: 800px; padding-bottom: 20px; padding-top: 20px;">
		<div>Copyrights © 2012 Citrus.</div>
	</div>
</body>
</html>
