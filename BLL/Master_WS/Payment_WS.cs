using BLL.Utilities1;
using Newtonsoft.Json;
using SFA;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Web;
using XSD.Masters_WS;


namespace BLL.Master_WS
{
    public class PaymentResponseData : ServerBase
    {
        public PaymentResponseData()
        {
            first_name = "";
            program_course_desc = "";
            transaction_id = "";
            pg_transaction_id = "";
            application_id = "";
            email_id = "";
            program_type_id = "";
            message = "";
            title = "";
            payment_mode = "";
        }

        public string title { get; set; }
        public string first_name { get; set; }
        public string program_course_desc { get; set; }
        public string transaction_id { get; set; }
        public string pg_transaction_id { get; set; }
        public string application_id { get; set; }
        public string email_id { get; set; }
        public string program_type_id { get; set; }
        public string message { get; set; }
        public string payment_mode { get; set; }
        public string user_id { get; set; }
        public string program_course_id { get; set; }

    }

    public class PaymentRes
    {
        public PaymentRes()
        {
            status = "paymentFail";
            data = new PaymentResponseData();
        }
        public string status { get; set; }
        public PaymentResponseData data { get; set; }
    }

    public class Payment : ServerBase
    {
        //public override SendReceiveJSon ProcessRequest(SendReceiveJSon receive_obj)
        //{
        //    switch (receive_obj.requestObjectInfo.ObjectProfile.MethodName)
        //    {
        //        case "SaveApplicationDetails":
        //            return SaveApplicationDetails(receive_obj);
        //        case "SaveApplicationDetailsByCash":
        //            return SaveApplicationDetailsByCash(receive_obj);
        //        default:
        //            return null;
        //    }
        //}

        #region <-- Entry in Payment Transaction Details -->
        public bool BeginPaymentTransaction(string UserId, Dictionary<string, object> courses_applied, ref string transaction_id, ref string message, string semester_code, string semester_type, string year_semester, decimal Amount, string department, string trans_code)
        {
            if (UserId == null || UserId == string.Empty)
            {
                message = "UserId not found";
                return false;
            }

            //if (courses_applied == null || courses_applied.Count == 0)
            //{
            //    message = "courses_applied not found";
            //    return false;
            //}

            decimal TotalAmount = Amount;

            try
            {


                DS_Payment_WS obj_DS_Payment = new DS_Payment_WS();





                if (DBConnection.State == ConnectionState.Closed) DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                Document obj_Document = new Document();
                // string transaction_doc_type = Constant.TRANSACTION_DOC_TYPE;
                string transaction_doc_no = "";
                string msg = "";

                //Generate Document No. for Transaction
                //byte result = obj_Document.GetNextDocumentNo(ref DBCommand, "1", "PT", DateTime.Today, ref transaction_doc_no, UserId, HttpContext.Current.Request.UserHostName, ref msg);
                //if (result != 1)
                //{
                //    DBCommand.Transaction.Rollback();
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    message = "Fail to generate doc number for payment transaction.";
                //    return false;
                //}

                if (!obj_Document.W_GetNextDocumentNo(ref DBCommand, "", "PT", UserId, "", ref transaction_doc_no, ref message))
                {

                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message = "Fail to generate doc number for payment transaction.";
                    return false;
                }


                transaction_id = trans_code + UserId + transaction_doc_no;
                DS_Payment_WS.ws_applicationpaymenttransactionRow TransactionRow = obj_DS_Payment.ws_applicationpaymenttransaction.Newws_applicationpaymenttransactionRow();
                TransactionRow.user_id = UserId;
                TransactionRow.transaction_id = trans_code + UserId + transaction_doc_no; 
                TransactionRow.current_sem_code = semester_code;
                TransactionRow.semester_type = semester_type;
                TransactionRow.year_semester = year_semester;
                TransactionRow.dept_id = department;
                TransactionRow.payment_send_flag = Constant.YES;
                TransactionRow.payment_return_flag = Constant.NO;
                TransactionRow.amount = TotalAmount; //Set Amount
                TransactionRow.status_is_active = Constant.STATUS_ACTIVE;
                TransactionRow.status_refund = Constant.NO;
                TransactionRow.status_is_payment_received = Constant.NO;
                TransactionRow.created_date = DateTime.Now;
                TransactionRow.created_by = HttpContext.Current.Session["UserId"].ToString();
                TransactionRow.created_host = HttpContext.Current.Request.UserHostName;

                obj_DS_Payment.ws_applicationpaymenttransaction.Addws_applicationpaymenttransactionRow(TransactionRow);

                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_DS_Payment.ws_applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obj_DS_Payment.ws_applicationpaymenttransaction.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message += " Fail to Update ApplicationPaymentTransaction Details.";
                    return false;
                }

                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                message = "Transaction Details Saved Successfully.";
                return true;
            }
            catch (Exception ex)
            {
                if (DBCommand.Transaction != null)
                    DBCommand.Transaction.Rollback();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                message = ex.Message;
                return false;
            }
        }
        #endregion

        #region <-- Payment Response From PaySeal (Check Payment = Success or Not) -->
        public string SavePaymentDetails(HttpRequest Request, ref PaymentRes paymentResponse)
        {
            string msg = "";
            Log.PaymentTransactionLog("Payment Response From Payseal : SavePaymentDetailsCall. ");

            PGResponse oPgResp = new PGResponse();
            EncryptionUtil lEncUtil = new EncryptionUtil();

            string astrResponseData = null;
            string strMerchantId, astrFileName = null;
            string strDigest = null;
            string astrsfaDigest = null;

            strMerchantId = HttpContext.Current.Session["MerchantId"].ToString();

            astrFileName = HttpContext.Current.Server.MapPath("~/Config/" + strMerchantId + ".key"); //"C://inetpub//wwwroot//CEPT//Config//00003692.key";

            if (Request.ServerVariables["REQUEST_METHOD"] == "POST")
            {
                astrResponseData = Request.Form["DATA"];
                strDigest = Request.Form["EncryptedData"];
                astrsfaDigest = lEncUtil.getHMAC(astrResponseData, astrFileName, strMerchantId);

                if (strDigest.Equals(astrsfaDigest))
                {
                    oPgResp.getResponse(astrResponseData);
                    Dictionary<string, object> res = new Dictionary<string, object>();
                    res["Response code"] = oPgResp.RespCode;
                    res["Response Message"] = oPgResp.RespMessage;
                    res["Merchant Txn Id"] = oPgResp.TxnId;

                    Log.PaymentTransactionLog("Payment Response From Payseal : Response Data : " + JsonConvert.SerializeObject(res));

                    if (oPgResp.RespCode == "0") //Successful Payment
                    {
                        string message = string.Empty;
                        string transactionId = oPgResp.TxnId;
                        paymentResponse.data.transaction_id = transactionId;
                        paymentResponse.data.pg_transaction_id = oPgResp.EPGTxnId;

                        //Update the application master details
                        bool result = PaymentSuccessSave(transactionId, oPgResp, ref paymentResponse, ref message);
                        if (result)
                        {
                            paymentResponse.status = "paymentSuccess";
                            msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                        }
                        else
                        {
                            paymentResponse.status = "paymentSuccessApplicationFail";
                            msg = "Your payment is done successfully . Please contact administratior with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                        }

                        Log.PaymentTransactionLog("Payment Response From Payseal : PaymentSuccessSave Method Response : " + result + ", Message : " + message);
                    }
                    else // "1" OR "2"
                    {
                        paymentResponse.status = "paymentFail";
                        paymentResponse.data.message = oPgResp.RespMessage;
                        msg = "Sorry!! Your payment is not done successfully. Error : " + oPgResp.RespMessage;
                        Log.PaymentTransactionLog("Payment Response From Payseal : " + msg);
                    }
                }
                else
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = "Signature mismatch";
                    Log.PaymentTransactionLog("Payment Response From Payseal : Error : Signature mismatch");
                }
            }

            //HttpContext.Current.Response.Write("<br>"); HttpContext.Current.Response.Write("<br>"); HttpContext.Current.Response.Write("<br>"); HttpContext.Current.Response.Write("<br>"); HttpContext.Current.Response.Write("<br>"); HttpContext.Current.Response.Write("<br>"); HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("MID : " + strMerchantId); HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("Response code        :  " + oPgResp.RespCode);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("\nResponse Message   :  " + oPgResp.RespMessage);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("\nMerchant Txn Id    :  " + oPgResp.TxnId);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("\nEpg Txn Id		 :  " + oPgResp.EPGTxnId);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("\nAuthId Code        :  " + oPgResp.AuthIdCode);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("RRN			         :  " + oPgResp.RRN);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("CVRESP Code	         :  " + oPgResp.CVRespCode);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("Cookie String	     :  " + oPgResp.Cookie);
            //HttpContext.Current.Response.Write("<br>");
            //HttpContext.Current.Response.Write("FDMS Score		     :  " + oPgResp.FDMSScore);
            //HttpContext.Current.Response.Write("<br>");

            //HttpContext.Current.Response.Write("FDMS Result          :  " + oPgResp.FDMSResult);
            return msg;
        }
        #endregion

        #region <-- Payment Response From Citrus (Check Payment = Success or Not) -->
        public string SavePaymentDetails(HttpRequest Request, ref PaymentRes paymentResponse, string key)
        {
            string msg = "";
            Log.PaymentTransactionLog("Payment Response From Citrus : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Request["pgRespCode"];
            res["Response Message"] = Request["TxMsg"];
            res["Merchant Txn Id"] = Request["TxId"];

            Log.PaymentTransactionLog("Payment Response From Citrus : Response Data : " + JsonConvert.SerializeObject(res));

            //String key = "a071ad4f6cf52cf1bebcd9405601d41adf61e23e";
            //key = "7519744baa01df256b5531003917cb6c33c1515a";

            //Get Net Banking Key
            // key = GetNetbankingKey(HttpContext.Current.Session["MerchantId"].ToString());
            String data = "";

            String pgRespCode = Request["pgRespCode"]; //0 = Success,1,2,3

            String TxId = Request["TxId"]; //Merchant Transaction ID
            String TxMsg = Request["TxMsg"]; //Success or failure message
            String TxRefNo = Request["TxRefNo"]; //Citruspay Transaction Id for payment
            String TxStatus = Request["TxStatus"]; //Transaction Status (SUCCESS, FAIL)
            String pgTxnId = Request["pgTxnNo"]; //Gateway transaction id

            String amount = Request["amount"];

            String issuerRefNo = Request["issuerRefNo"];
            String authIdCode = Request["authIdCode"];
            String firstName = Request["firstName"];
            String lastName = Request["lastName"];

            String zipCode = Request["addressZip"];
            String reqSignature = Request["signature"]; //"HMAC signature of response data to validate the response data on merchant end See details at Response Signature Section."

            String signature = "";
            bool flag = true;
            if (TxId != null)
            {
                data += TxId;
            }
            if (TxStatus != null)
            {
                data += TxStatus;
            }
            if (amount != null)
            {
                data += amount;
            }
            if (pgTxnId != null)
            {
                data += pgTxnId;
            }
            if (issuerRefNo != null)
            {
                data += issuerRefNo;
            }
            if (authIdCode != null)
            {
                data += authIdCode;
            }
            if (firstName != null)
            {
                data += firstName;
            }
            if (lastName != null)
            {
                data += lastName;
            }
            if (pgRespCode != null)
            {
                data += pgRespCode;
            }
            if (zipCode != null)
            {
                data += zipCode;
            }
            BLL.Utilities1.Log.PaymentTransactionLog("Response data :" + data);
            signature = CitrusPay.MerchantKit.Infrastructure.CitrusPaySignatureRequestor.GenerateHMAC(data, key);
            BLL.Utilities1.Log.PaymentTransactionLog("Response HMAC :" + signature);
            if (reqSignature != null && !signature.Equals(reqSignature))
            {
                flag = false;

                Log.PaymentTransactionLog("Payment Response From Citrus : Signature missmatch. ");
            }
            if (flag)
            {

                string message = string.Empty;
                string transactionId = Request["TxId"];

                if (pgRespCode == "0")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = pgTxnId;

                    //Save Transaction Details
                    bool result = PaymentSuccessSave(transactionId, Request, ref paymentResponse, ref message);

                    Log.PaymentTransactionLog("Payment Response From Citrus : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result)
                    {
                        paymentResponse.status = "paymentSuccess";

                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";


                    }
                    else
                    {
                        paymentResponse.status = "paymentSuccessApplicationFail";

                        msg = "Your payment is done successfully but transaction details not saved. Please contact administratior with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }

                }
                else // "1" OR "2"
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }

                //Response.Write("Application Generated : " + result.ToString());

                //Response.Write(Request["TxId"] == null ? "" : Request["TxId"]);

                //Response.Write(Request["TxRefNo"] == null ? "" : Request["TxRefNo"]);

                //Response.Write(Request["pgTxnNo"] == null ? "" : Request["pgTxnNo"]);

                //Response.Write(Request["TxStatus"] == null ? "" : Request["TxStatus"]); //

                //Response.Write(Request["amount"] == null ? "" : Request["amount"]);

                //if (Request["TxMsg"] != null)
                //{
                //    Response.Write(Request["TxMsg"] == null ? "" : Request["TxMsg"]);
                //}
                //else if (Request["mandatoryErrorMsg"] != null)
                //{
                //    Response.Write(Request["mandatoryErrorMsg"]);
                //}
                //else if (Request["paidTxnExists"] != null)
                //{
                //    Response.Write(Request["paidTxnExists"]);
                //}
            }
            else
            {
                paymentResponse.status = "paymentFail";
                paymentResponse.data.message = "Response signature is not matched with request.";
                msg = "Sorry!! Your payment is not done successfully. Error : Response signature is not matched with request.";
            }
            Log.PaymentTransactionLog("Message : " + msg);
            return msg;
        }
        #endregion

        #region <-- Payment Response from PaySeal (Card) - Update Transaction Master and Add Row in Application Mst -->
        public bool PaymentSuccessSave(string transactionId, PGResponse oPgResp, ref PaymentRes paymentResponse, ref string message)
        {
            Masters_WS objGetMasterDetails = new Masters_WS();

            //Get Application Master Details for Transaction Id
            //DataTable dtApplicationDetails = objGetMasterDetails.GetApplicationDetails(transactionId);
            //if (dtApplicationDetails != null && dtApplicationDetails.Rows.Count > 0)
            //{
            //    //Already Exist Transaction Id
            //    message += "Tansaction Id Already Exist in ApplicationMst : " + transactionId;
            //    return false;
            //}
            //else
            //{
            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");
            DataTable dtTranDetail = GetTransactionDetails(transactionId);



            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());
            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                Log.PaymentTransactionLog("In if condition");
                DS_Payment_WS obDS_Payment = new DS_Payment_WS();



                obDS_Payment.EnforceConstraints = false;
                DataRow TranRow = dtTranDetail.Rows[0];
                // string program_course_id = TranRow["program_course_id"].ToString();
                string user_id = TranRow["user_id"].ToString();

                paymentResponse.data.user_id = user_id;

                TranRow["payment_response_code"] = oPgResp.RespCode;
                TranRow["payment_response_msg"] = oPgResp.RespMessage;
                TranRow["payment_transaction_reference_id"] = oPgResp.EPGTxnId;
                TranRow["payment_authorization_code"] = oPgResp.AuthIdCode;
                TranRow["payment_root_transaction_reference_no"] = oPgResp.RRN;
                TranRow["payment_cv_response_code"] = oPgResp.CVRespCode;

                TranRow["payment_return_flag"] = Constant.YES;
                TranRow["status_is_payment_received"] = Constant.YES;

                TranRow["last_modified_date"] = DateTime.Now;
                TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                obDS_Payment.ws_applicationpaymenttransaction.ImportRow(TranRow);

                DBConnection.Open();

                //Begin Transaction.
                DBCommand.Transaction = DBConnection.BeginTransaction();
                // generate application

                //DataTable course_detail = objGetMasterDetails.GetProgramCourseDetails(program_course_id);
                //if (!(course_detail != null && course_detail.Rows.Count > 0))
                //{
                //    message = "Course Detail Not Found.";
                //    return false;
                //}

                //DataRow CourseDetailRow = course_detail.Rows[0];
                //string ProgramTypeId = CourseDetailRow["program_type_id"].ToString();
                //string ProgramFacultyId = CourseDetailRow["program_faculty_id"].ToString();

                //paymentResponse.data.program_course_id = program_course_id;
                //paymentResponse.data.program_course_desc = CourseDetailRow["program_course_desc"].ToString();
                //paymentResponse.data.program_type_id = CourseDetailRow["program_type_id"].ToString();

                //string AppDocType = objGetMasterDetails.GetApplicationDocType(ProgramTypeId, ProgramFacultyId);
                //Document objDoc = new Document();
                //string application_id = "";
                //message = "";

                //byte result = objDoc.GetNextDocumentNo(ref DBCommand, "1", AppDocType, DateTime.Today, ref application_id, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, ref message);
                //if (result != 1)
                //{
                //    DBCommand.Transaction.Rollback();
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    message += "Fail To Generate Application ID.";
                //    return false;
                //}

                //YearMst obYearMst = new YearMst();
                //string YearCode = "";

                //result = obYearMst.GetPeriodYear(ref DBCommand, "1", DateTime.Today, ref YearCode, ref message);
                //if (result != 1)
                //{
                //    DBCommand.Transaction.Rollback();
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    message += "Period year not found.";
                //    return false;
                //}

                //DS_Payment.ApplicationMstRow obApplicationMstRow = obDS_Payment.ApplicationMst.NewApplicationMstRow();

                //obApplicationMstRow.application_id = application_id;
                //obApplicationMstRow.transaction_id = transactionId;
                //obApplicationMstRow.program_course_id = program_course_id;
                //obApplicationMstRow.program_type_id = ProgramTypeId;
                //obApplicationMstRow.program_faculty_id = ProgramFacultyId;
                //obApplicationMstRow.year_code = YearCode;
                //obApplicationMstRow.status = Constant.STATUS_ACTIVE;
                //obApplicationMstRow.is_admin_approved = Constant.NO;
                //obApplicationMstRow.user_id = HttpContext.Current.Session["UserId"].ToString();
                //obApplicationMstRow.created_by = HttpContext.Current.Session["UserId"].ToString();
                //obApplicationMstRow.created_date = DateTime.Now;
                //obApplicationMstRow.created_host = HttpContext.Current.Request.UserHostName;

                //obDS_Payment.ApplicationMst.AddApplicationMstRow(obApplicationMstRow);

                try
                {
                    obDS_Payment.EnforceConstraints = true;
                }
                catch (ConstraintException ce)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message += ce.Message;
                    Log.ExceptionLog(ce.Message + Environment.NewLine + ce.StackTrace);
                    return false;
                }
                catch (Exception ex)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message += ex.Message;
                    Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                    return false;
                }

                //Update Transaction Master
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ws_applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ws_applicationpaymenttransaction.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message += " Fail to Update Transaction Details.";
                    return false;
                }

                //Save Application Master
                //objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ApplicationMst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                //if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ApplicationMst.Rows.Count)
                //{
                //    DBCommand.Transaction.Rollback();
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    message += " Fail to Save Application Details.";
                //    return false;
                //}

                //message += "Application Generated successfully with ID : " + application_id + ", txnID : " + transactionId;
                message += "Application Generated successfully with ID : txnID : " + transactionId;
                paymentResponse.data.application_id = "";
                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return true;
            }
            else
            {
                Log.PaymentTransactionLog("In Else Condition");
                message += "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
            // }
        }

        public DataTable GetTransactionDetails(string transaction_id)
        {
            Log.PaymentTransactionLog("GetTransactionDetails method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";


                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from  ws_applicationpaymenttransaction  where  transaction_id ='" + transaction_id + "'";
                BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);






                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);
                DataSet ds = new DataSet();
                try
                {
                    DBDataAdpterObject.Fill(ds);
                    if (ds.Tables[0].Rows.Count <= 0)
                    {
                        BLL.Utilities1.Log.PaymentTransactionLog("row not found");
                        return null;
                    }
                    else
                    {

                        BLL.Utilities1.Log.PaymentTransactionLog("successful" + ds.Tables[0].Rows[0]["transaction_id"].ToString());
                        dt = ds.Tables[0];
                        BLL.Utilities1.Log.PaymentTransactionLog("successful1" + dt.Rows[0]["transaction_id"].ToString());
                        return dt;

                    }

                }
                catch (Exception ex)
                {
                    BLL.Utilities1.Log.PaymentTransactionLog("Error" + ex.ToString());
                    return null;
                }
            }
            catch (Exception ex)
            {
                BLL.Utilities1.Log.PaymentTransactionLog("Error1" + ex.ToString());
                return null;
            }
        }
        #endregion

        #region <-- Payment Response from Citrus (Net Banking) - Update Transaction Master and Add Row in Application Mst -->
        internal bool PaymentSuccessSave(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters_WS objGetMasterDetails = new Masters_WS();

            ////Get Application Master Details for Transaction Id
            //DataTable dtApplicationDetails = objGetMasterDetails.GetApplicationDetails(transactionId);
            //if (dtApplicationDetails != null && dtApplicationDetails.Rows.Count > 0)
            //{
            //    //Already Exist Transaction Id
            //    message += "Tansaction Id Already Exist in ApplicationMst : " + transactionId;
            //    return false;
            //}
            //else
            //{
            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");
            DataTable dtTranDetail = GetTransactionDetails(transactionId);
            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());
            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {

                try
                {

               
                Log.PaymentTransactionLog("In if condition");
                DS_Payment_WS obDS_Payment = new DS_Payment_WS();

                obDS_Payment.EnforceConstraints = false;
                DataRow TranRow = dtTranDetail.Rows[0];
                //  string program_course_id = TranRow["program_course_id"].ToString();
                user_id = TranRow["user_id"].ToString();
                Log.PaymentTransactionLog("In if condition" + user_id);
                paymentResponse.data.user_id = user_id;

                TranRow["payment_return_flag"] = Constant.YES;
                TranRow["payment_response_code"] = Request["pgRespCode"];
                TranRow["payment_response_msg"] = Request["TxMsg"];
                TranRow["payment_transaction_reference_id"] = Request["pgTxnNo"];
                TranRow["payment_authorization_code"] = Request["authIdCode"];
                TranRow["Citrus_PaymentMode"] = Request["paymentMode"];
                TranRow["Citrus_TxRefNo"] = Request["TxRefNo"];
                TranRow["Citrus_TxGateway"] = Request["TxGateway"];
                TranRow["Citrus_IssuerRefNo"] = Request["issuerCode"];
                TranRow["Citrus_TxStatus"] = Request["TxStatus"];

                TranRow["status_is_payment_received"] = Constant.YES;

                //TranRow["last_modified_date"] = DateTime.Now;
                //TranRow["last_modified_by"] = user_id;
                //TranRow["last_modified_host"] = "";

                obDS_Payment.ws_applicationpaymenttransaction.ImportRow(TranRow);
                Log.PaymentTransactionLog("row imported");

                DBConnection.Open();
                Log.PaymentTransactionLog("connection open");
                //Begin Transaction.
                DBCommand.Transaction = DBConnection.BeginTransaction();
                Log.PaymentTransactionLog("connection Begin");
                // generate application

                //DataTable course_detail = objGetMasterDetails.GetProgramCourseDetails(program_course_id);
                //if (!(course_detail != null && course_detail.Rows.Count > 0))
                //{
                //    message = "Course Detail Not Found.";
                //    return false;
                //}

                //DataRow CourseDetailRow = course_detail.Rows[0];
                //string ProgramTypeId = CourseDetailRow["program_type_id"].ToString();
                //string ProgramFacultyId = CourseDetailRow["program_faculty_id"].ToString();

                //paymentResponse.data.program_course_id = program_course_id;
                //paymentResponse.data.program_course_desc = CourseDetailRow["program_course_desc"].ToString();
                //paymentResponse.data.program_type_id = CourseDetailRow["program_type_id"].ToString();

                //string AppDocType = objGetMasterDetails.GetApplicationDocType(ProgramTypeId, ProgramFacultyId);
                //Document objDoc = new Document();
                //string application_id = "";
                //message = "";
                //byte result = objDoc.GetNextDocumentNo(ref DBCommand, "1", AppDocType, DateTime.Today, ref application_id, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, ref message);

                //if (result != 1)
                //{
                //    DBCommand.Transaction.Rollback();
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    message += "Fail To Generate Application ID.";
                //    return false;
                //}

                //YearMst obYearMst = new YearMst();
                //string YearCode = "";

                //result = obYearMst.GetPeriodYear(ref DBCommand, "1", DateTime.Today, ref YearCode, ref message);
                //if (result != 1)
                //{
                //    DBCommand.Transaction.Rollback();
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    message += "Period year not found.";
                //    return false;
                //}

                //DS_Payment.ApplicationMstRow obApplicationMstRow = obDS_Payment.ApplicationMst.NewApplicationMstRow();

                //obApplicationMstRow.application_id = application_id;
                //obApplicationMstRow.transaction_id = transactionId;
                //obApplicationMstRow.program_course_id = program_course_id;
                //obApplicationMstRow.program_type_id = ProgramTypeId;
                //obApplicationMstRow.program_faculty_id = ProgramFacultyId;
                //obApplicationMstRow.year_code = YearCode;
                //obApplicationMstRow.status = Constant.STATUS_ACTIVE;
                //obApplicationMstRow.is_admin_approved = Constant.NO;
                //obApplicationMstRow.user_id = user_id;
                //obApplicationMstRow.created_by = HttpContext.Current.Session["UserId"].ToString();
                //obApplicationMstRow.created_date = DateTime.Now;
                //obApplicationMstRow.created_host = HttpContext.Current.Request.UserHostName;

                //obDS_Payment.ApplicationMst.AddApplicationMstRow(obApplicationMstRow);

                try
                {
                    obDS_Payment.EnforceConstraints = true;
                }
                catch (ConstraintException ce)
                {
                    Log.PaymentTransactionLog("1" + ce.ToString());
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message = ce.Message;
                    Log.ExceptionLog(ce.Message + Environment.NewLine + ce.StackTrace);
                    return false;
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("2" + ex.ToString());
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message = ex.Message;
                    Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                    return false;
                }

                //Update Transaction Master
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ws_applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ws_applicationpaymenttransaction.Rows.Count)
                {
                    Log.PaymentTransactionLog("rollback");
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    message += " Fail to Update Transaction Details.";
                    return false;
                }

                //Save Application Master
                //objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ApplicationMst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                //if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ApplicationMst.Rows.Count)
                //{
                //    DBCommand.Transaction.Rollback();
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    message += " Fail to Save Application Details.";
                //    return false;
                //}

                //   message += "Application Generated successfully with ID : " + application_id + ", txnID : " + transactionId;
                message += "Application Generated successfully with ID :  txnID : " + transactionId;
                paymentResponse.data.application_id = "";
                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            
                }
                catch (Exception ex)
                {

                    Log.PaymentTransactionLog("nada" + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
            //  }
        }
        #endregion

        #region <-- Get Net Banking Key Based on MID -->
        private string GetNetbankingKey(string MID)
        {
            //return "96012687";

            //Cept Faculty of Architecture : 00212232
            //fafinance@cept.ac.in  DY5DNM2LI611HU95O891
            //b3cfda91892faaf791437990f604bc7f24ad99b9

            //Cept Faculty of Planning : 00212233 
            //fpfinance@cept.ac.in   7GIJIBCZFA42KPWI0T85
            //0b906338a162d33077279a52e248f4b3ccf70ebf

            //Cept Faculty of Design : 00212234 
            //fdfinance@cept.ac.in   XRSH0B954IDJ2GRQNHP6
            //3d509f30d9538f4063bf3dd96d89d8e5e8c20f01

            //Cept Faculty of Technology : 00212235 
            //ftfinance@cept.ac.in O78U25FBECC0OFW180I0
            //c85e4a6e773e496ccbbc95aa367fae844baf2aab

            //Cept Faculty of Management : 00212236
            //fmfinance@cept.ac.in AU1H6DYLRRNXB76M9G4M
            //e05fe1db9623e79f58a500d87075fbb01168a107

            string key = "";

            switch (MID)
            {
                case "00212232": //Faculty of Architecture
                    key = "b3cfda91892faaf791437990f604bc7f24ad99b9";
                    break;
                case "00212233": //Faculty of Planning
                    key = "0b906338a162d33077279a52e248f4b3ccf70ebf";
                    break;
                case "00212235": //Faculty of Technology
                    key = "c85e4a6e773e496ccbbc95aa367fae844baf2aab";
                    break;
                case "00212234": //Faculty of Design
                    key = "3d509f30d9538f4063bf3dd96d89d8e5e8c20f01";
                    break;
                case "00212236": //Faculty of Management
                    key = "e05fe1db9623e79f58a500d87075fbb01168a107";
                    break;
                default:
                    key = "";
                    break;
            }

            return key;
        }
        #endregion

        #region <-- Get Response Page according to Faculty for Card -->
        public static string GetResponsePage(string FacultyId)
        {
            //return "PaymentResponse.aspx";
            //Cept Faculty of Architecture : 00212232
            //
            //Cept Faculty of Planning : 00212233
            //
            //Cept Faculty of Design : 00212234
            //
            //Cept Faculty of Technology : 00212235
            //
            //Cept Faculty of Management : 00212236

            string ResPage = "";

            switch (FacultyId)
            {
                case "PFM0001": //Faculty of Architecture
                    ResPage = "PaymentResponseCardArchitecture.aspx";
                    break;
                case "PFM0002": //Faculty of Planning
                    ResPage = "PaymentResponseCardPlanning.aspx";
                    break;
                case "PFM0003": //Faculty of Technology
                    ResPage = "PaymentResponseCardTechnology.aspx";
                    break;
                case "PFM0004": //Faculty of Design
                    ResPage = "PaymentResponseCardDesign.aspx";
                    break;
                case "PFM0005": //Faculty of Management
                    ResPage = "PaymentResponseCardManagement.aspx";
                    break;
                default:
                    ResPage = "";
                    break;
            }

            return ResPage;
        }
        #endregion

        #region <-- Get Application Amount based on Program Type and Reservation Category -->
        public static decimal ApplicationAmount(string ProgramTypeId, string candidateReservation)
        {
            decimal formAmount = 0;

            if (ProgramTypeId == "PTM0001") //UG
            {
                switch (candidateReservation)
                {
                    case "C000000001": //SC
                    case "C000000002": //ST
                    case "C000000003": //OBC
                    case "C000000006": //SEBC
                        formAmount = 300;
                        break;
                    default:
                        formAmount = 500;
                        break;
                }
            }
            else if (ProgramTypeId == "PTM0002") //PG
            {
                switch (candidateReservation)
                {
                    case "C000000001": //SC
                    case "C000000002": //ST
                    case "C000000003": //OBC
                    case "C000000006": //SEBC
                        formAmount = 1500;
                        break;
                    default:
                        formAmount = 2000;
                        break;
                }
            }
            else if (ProgramTypeId == "PTM0003") //PHD
            {
                switch (candidateReservation)
                {
                    case "C000000001": //SC
                    case "C000000002": //ST
                    case "C000000003": //OBC
                    case "C000000006": //SEBC
                        formAmount = 1500;
                        break;
                    default:
                        formAmount = 2000;
                        break;
                }
            }

            return formAmount;
        }
        #endregion

        #region <-- Get Merchant Id based on Faculty -->
        public static string GetMerchantId(string FacultyId)
        {
            //return "96012687";
            //Cept Faculty of Architecture : 00212232
            //
            //Cept Faculty of Planning : 00212233
            //
            //Cept Faculty of Design : 00212234
            //
            //Cept Faculty of Technology : 00212235
            //
            //Cept Faculty of Management : 00212236

         ///////   string MID = "https://sandbox.citruspay.com/21zzilqhkd";

            string MID = "https://www.citruspay.com/ceptuniv";

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        MID = "https://sandbox.citruspay.com/azd40oysiz";
            //        break;
            //    case "4": //Faculty of Planning
            //        MID = "https://sandbox.citruspay.com/dxni4p67j1";
            //        break;
            //    case "5": //Faculty of Technology
            //        MID = "https://sandbox.citruspay.com/qv72qn6qfi";
            //        break;
            //    case "2": //Faculty of Design
            //        MID = "https://sandbox.citruspay.com/dn5f8ss67h";
            //        break;
            //    case "3": //Faculty of Management
            //        MID = "";
            //        break;
            //    default:
            //        MID = "";
            //        break;
            //}

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        MID = "https://www.citruspay.com/ceptarchitecture";
            //        break;
            //    case "2": //Faculty of Design
            //        MID = "https://www.citruspay.com/ceptdesign";
            //        break;
            //    case "3": //Faculty of Management
            //        MID = "https://www.citruspay.com/ceptdesign";
            //        break;
            //    case "4": //Faculty of Planning
            //        MID = "https://www.citruspay.com/ceptplanning";
            //        break;
            //    case "5": //Faculty of Technology
            //        MID = "https://www.citruspay.com/cepttechnology";
            //        break;
               
            //    default:
            //        MID = "";
            //        break;
            //}

            return MID;
        }
        #endregion
        #region <-- Get Faculty page -->
        public static string Get_hmac_url(string FacultyId)
        {
            //return "96012687";
            //Cept Faculty of Architecture : 00212232
            //
            //Cept Faculty of Planning : 00212233
            //
            //Cept Faculty of Design : 00212234
            //
            //Cept Faculty of Technology : 00212235
            //
            //Cept Faculty of Management : 00212236

            string url = "hmac_signature_WS.aspx";

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        url = "hmac_signatureArchitecture.aspx";
            //        break;
            //    case "2": //Faculty of Design
            //        url = "hmac_signatureDesign.aspx";
            //        break;
            //    case "3": //Faculty of Management
            //        url = "hmac_signatureManagement.aspx";
            //        break;

            //    case "4": //Faculty of Planning
            //        url = "hmac_signaturePlanning.aspx";
            //        break;
            //    case "5": //Faculty of Technology
            //        url = "hmac_signatureTechnology.aspx";
            //        break;

            //    default:
            //        url = "";
            //        break;
            //}

            return url;
        }
        #endregion

        #region <-- Get Faculty page -->
        public static string Get_return_url(string FacultyId)
        {
            //return "96012687";
            //Cept Faculty of Architecture : 00212232
            //
            //Cept Faculty of Planning : 00212233
            //
            //Cept Faculty of Design : 00212234
            //
            //Cept Faculty of Technology : 00212235
            //
            //Cept Faculty of Management : 00212236

            string url = "PaymentResponseNetBanking_WS.aspx";

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        url = "PaymentResponseNetBankingArchitecture.aspx";
            //        break;
            //    case "2": //Faculty of Design
            //        url = "PaymentResponseNetBankingDesign.aspx";
            //        break;
            //    case "3": //Faculty of Management
            //        url = "PaymentResponseNetBankingManagement.aspx";
            //        break;

            //    case "4": //Faculty of Planning
            //        url = "PaymentResponseNetBankingPlanning.aspx";
            //        break;
            //    case "5": //Faculty of Technology
            //        url = "PaymentResponseNetBankingTechnology.aspx";
            //        break;

            //    default:
            //        url = "";
            //        break;
            //}

            return url;
        }
        #endregion

        #region <-- Call Payment Gateway Page (My Application, Submit And Pay Button) -->
        public bool RedirectToPaymentGateway(Dictionary<string, object> Param, ref string message, string user_id, decimal Amount, string semester_code, string semester_type, string year_semester, string department, string trans_code, ref string transaction_id)
        {
            transaction_id = "";
            string program_course_id = "";
            string program_faculty_id = "";
            string program_type_id = "";
            //  string user_id = "";


            program_faculty_id = department;
            //if (Param.Keys.Contains("program_course_id") && Param["program_course_id"] != null && Param["program_course_id"].ToString() != string.Empty)
            //    program_course_id = Param["program_course_id"].ToString();
            //else
            //{
            //    message = "program_course_id not found in parameter";
            //    return;
            //}

            //if (Param.Keys.Contains("program_faculty_id") && Param["program_faculty_id"] != null && Param["program_faculty_id"].ToString() != string.Empty)
            //    program_faculty_id = Param["program_faculty_id"].ToString();
            //else
            //{
            //    message = "program_faculty_id not found in parameter";
            //    return;
            //}

            //if (Param.Keys.Contains("program_type_id") && Param["program_type_id"] != null && Param["program_type_id"].ToString() != string.Empty)
            //    program_type_id = Param["program_type_id"].ToString();
            //else
            //{
            //    message = "program_type_id not found in parameter";
            //    return;
            //}

            //if (Param.Keys.Contains("user_id") && Param["user_id"] != null && Param["user_id"].ToString() != string.Empty)
            //    user_id = Param["user_id"].ToString();
            //else
            //{
            //    message = "user_id not found in parameter";
            //    return;
            //}

            //if (program_course_id != string.Empty && program_faculty_id != string.Empty && program_type_id != string.Empty)
            //{
            Log.PaymentTransactionLog("btnMakePayment_Click : CourseId : " + program_course_id + ", UserId : " + user_id);
            //decimal TotalAmount = 0;
            //  GetMasterDetails objGetMasterDetails = new GetMasterDetails();

            Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
            ObjParam.Add("user_id", user_id);

            //Get Candidate Details (Check Reservation Category)
            //    DataTable dtCandidateDtls = objGetMasterDetails.GetCandidatePersonalDetails(ObjParam);
            //if (dtCandidateDtls != null && dtCandidateDtls.Rows.Count > 0)
            //{
            //Candidate Reservation Category
            //string candidateReservation = dtCandidateDtls.Rows[0]["reservation"].ToString();
            //if (candidateReservation != string.Empty && candidateReservation != null)
            //{

            //decimal Amount;
            string MerchantId = "";

            ////Get Total Amount based on Program Type and Reservation
            //Amount = Payment.ApplicationAmount(program_type_id, candidateReservation);

            //Get Merchant Id for Faculty
            MerchantId = Payment.GetMerchantId(program_faculty_id);

            if (MerchantId != "")
            {
                //  Param["amount"] = Amount;

                HttpContext.Current.Session["MerchantId"] = MerchantId;

                string msg = string.Empty;

                //Entry in Payment Transaction Details
                bool result = BeginPaymentTransaction(user_id, Param, ref transaction_id, ref msg, semester_code, semester_type, year_semester, Amount, department, trans_code);


                Log.PaymentTransactionLog("BeginPaymentTransaction : TxnId : " + transaction_id + " , UserId = " + user_id);
                if (result)
                {

                    return true;
                    //Redirect to payment gateway site
                    //  SubmitRequest(transaction_id, user_id, MerchantId, Amount, Payment.GetResponsePage(program_faculty_id));
                }
                else
                {
                    message = "Fail to begin payment transaction. Error : " + msg;
                    return false;
                }
            }
            else
            {
                message = "MerchantId Not Found.";
                return false;
            }
            //}
            // }
            //  }
        }
        #endregion

        #region <-- Set the Merchant Details and Transfer to Payment Gateway -->
        public void SubmitRequest(String TransactionNo, string UserId, string MerchantId, decimal Amount, string ReturnPage)
        {
            PGResponse objPGResponse = new PGResponse();
            CustomerDetails oCustomer = new CustomerDetails();
            SessionDetail oSession = new SessionDetail();
            AirLineTransaction oAirLine = new AirLineTransaction();
            MerchanDise oMerchanDise = new MerchanDise();

            SFA.CardInfo objCardInfo = new SFA.CardInfo();

            SFA.Merchant objMerchant = new SFA.Merchant();

            ShipToAddress objShipToAddress = new ShipToAddress();
            BillToAddress oBillToAddress = new BillToAddress();
            ShipToAddress oShipToAddress = new ShipToAddress();
            MPIData objMPI = new MPIData();
            PGReserveData oPGreservData = new PGReserveData();
            Address oHomeAddress = new Address();
            Address oOfficeAddress = new Address();
            // For getting unique MerchantTxnID 
            // Only for testing purpose. 
            // In actual scenario the merchant has to pass his transactionID
            DateTime oldTime = new DateTime(1970, 01, 01, 00, 00, 00);
            DateTime currentTime = DateTime.Now;
            TimeSpan structTimespan = currentTime - oldTime;
            //string lMrtTxnID = ((long)structTimespan.TotalMilliseconds).ToString();

            #region Get Response URL
            string returnURL = HttpContext.Current.Request.Url.ToString();

            string finalURL = returnURL.Substring(0, returnURL.LastIndexOf('/') + 1) + ReturnPage;
            #endregion

            //Setting Merchant Details
            //objMerchant.setMerchantDetails("00003692", "00003692", "00003692", "", lMrtTxnID, "Ord123", finalURL, "POST", "INR", "INV123", "req.Sale", "1.00", "GMT+05:30", "ASP.NET64", "true", "ASP.NET64", "ASP.NET64", "ASP.NET64");
            objMerchant.setMerchantDetails(MerchantId, MerchantId, MerchantId, "", TransactionNo, TransactionNo, finalURL, "POST", "INR", TransactionNo, "req.Sale", Amount.ToString(), "GMT+05:30", "Ext1", "true", "Ext3", "Ext4", "Ext5");

            // Setting BillToAddress Details
            //oBillToAddress.setAddressDetails("CID", "Maha Lakshmi", "Aline 1", "Aline2", "Aline3", "Pune", "MH", "48927489", "IND", "tester@opussoft.com");

            // Setting ShipToAddress Details
            //oShipToAddress.setAddressDetails("$23@#|", "<script>", "Add 3", "City", "State", "443543", "IND", "tester@opussoft.com");

            //Setting MPI datails.
            // objMPI.setMPIRequestDetails ("1000","INR10.00","356","2","2 shirts","","","","0","","image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/vnd.ms-powerpoint, application/vnd.ms-excel, application/msword, application/x-shockwave-flash, */*","Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.0)");

            // Setting Name home/office Address Details 
            // Order of Parameters =>        AddLine1, AddLine2,      AddLine3,   City,   State ,  Zip,          Country, Email id
            //oHomeAddress.setAddressDetails("2Sandeep", "Uttam Corner", "Chinchwad", "Pune", "state", "4385435873", "IND", "test@test.com");

            // Order of Parameters =>        AddLine1, AddLine2,      AddLine3,   City,   State ,  Zip,          Country, Email id
            //oOfficeAddress.setAddressDetails("2Opus", "MayFairTowers", "Wakdewadi", "Pune", "state", "4385435873", "IND", "test@test.com");

            // Stting  Customer Details 
            // Order of Parameters =>  First Name,LastName ,Office Address Object,Home Address Object,Mobile No,RegistrationDate, flag for matching bill to address and ship to address 
            //oCustomer.setCustomerDetails("Sandeep", "patil", oOfficeAddress, oHomeAddress, "9423203297", "13-06-2007", "Y");

            //Setting Merchant Dise Details 
            // Order of Parameters =>       Item Purchased,Quantity,Brand,ModelNumber,Buyers Name,flag value for matching CardName and BuyerName
            //oMerchanDise.setMerchanDiseDetails("Computer", "2", "Intel", "P4", "Sandeep Patil", "Y");

            //Setting  Session Details        
            // Order of Parameters =>     Remote Address, Cookies Value            Browser Country,Browser Local Language,Browser Local Lang Variant,Browser User Agent'
            //oSession.setSessionDetails(getRemoteAddr(), getSecureCookie(Request), "", Request.ServerVariables["HTTP_ACCEPT_LANGUAGE"], "", Request.ServerVariables["HTTP_USER_AGENT"]);

            //Settingr AirLine Transaction Details  
            //Order of Parameters =>               Booking Date,FlightDate,Flight   Time,Flight Number,Passenger Name,Number Of Tickets,flag for matching card name and customer name,PNR,sector from,sector to'
            // oAirLine.setAirLineTransactionDetails("10-06-2007", "22-06-2007", "13:20", "119", "Sandeep", "1", "Y", "25c", "Pune", "Mumbai");

            SFAClient objSFAClient = new SFAClient(HttpContext.Current.Server.MapPath("~/Config/"));
            objPGResponse = objSFAClient.postSSL(objMPI, objMerchant, oBillToAddress, oShipToAddress, oPGreservData, oCustomer, oSession, oAirLine, oMerchanDise);

            if (objPGResponse.RedirectionUrl != "" & objPGResponse.RedirectionUrl != null)
            {
                string strResponseURL = objPGResponse.RedirectionUrl;
                Log.PaymentTransactionLog("Call Payment Gateway : TxnId : " + TransactionNo + " , UserId : " + HttpContext.Current.Session["UserId"].ToString() + ", Key Path : " + HttpContext.Current.Server.MapPath("~/Config/") + "" + ", ResponseUrl : " + finalURL + ",Amount : " + Amount.ToString());
                HttpContext.Current.Response.Redirect(strResponseURL, false);
            }
            else
            {
                Log.PaymentTransactionLog("Call Payment Gateway Fail : TxnId : " + TransactionNo + " , UserId : " + HttpContext.Current.Session["UserId"].ToString());
                HttpContext.Current.Response.Write("Response Code:" + objPGResponse.RespCode);
                HttpContext.Current.Response.Write("Response message:" + objPGResponse.RespMessage);
            }

            //responselbl.Text=response;
        }
        #endregion

        #region <-- Admin - Save Application Details (Generate Application) -->
        //private SendReceiveJSon SaveApplicationDetails(SendReceiveJSon receive_obj)
        //{
        //    SendReceiveJSon send_obj = new SendReceiveJSon();
        //    string message = string.Empty;
        //    string transactionId = string.Empty;

        //    Dictionary<String, Object> ObjParam = receive_obj.requestObjectInfo.OpArgs;

        //    send_obj.responseObjectInfo.transactionType = "Save";

        //    try
        //    {
        //        //Get Transaction Id
        //        if (ObjParam.ContainsKey("transaction_id") && ObjParam["transaction_id"] != null && ObjParam["transaction_id"].ToString().Trim() != string.Empty)
        //        {
        //            transactionId = ObjParam["transaction_id"].ToString().Trim();

        //            GetMasterDetails objGetMasterDetails = new GetMasterDetails();

        //            //Get Application Master Details for Transaction Id
        //            DataTable dtApplicationDetails = objGetMasterDetails.GetApplicationDetails(transactionId);
        //            if (dtApplicationDetails != null && dtApplicationDetails.Rows.Count > 0)
        //            {
        //                //Already Exist Transaction Id
        //                message += "Tansaction Id Already Exist in ApplicationMst : " + transactionId;
        //                send_obj.responseObjectInfo.Status = 2;
        //                send_obj.responseObjectInfo.Message = message;
        //                return send_obj;
        //            }
        //            else
        //            {
        //                //Get Transaction Details for Transaction Id
        //                DataTable dtTranDetail = objGetMasterDetails.GetTransactionDetails(transactionId);

        //                //Update the application master details
        //                if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
        //                {
        //                    DS_Payment obDS_Payment = new DS_Payment();

        //                    obDS_Payment.EnforceConstraints = false;
        //                    DataRow TranRow = dtTranDetail.Rows[0];

        //                    string program_course_id = TranRow["program_course_id"].ToString();
        //                    string user_id = TranRow["user_id"].ToString();

        //                    TranRow["payment_response_code"] = 0;
        //                    TranRow["payment_response_msg"] = "Transaction Successful";

        //                    if (ObjParam["payment_transaction_reference_id"].ToString().Trim() != string.Empty)
        //                    {
        //                        TranRow["payment_transaction_reference_id"] = ObjParam["payment_transaction_reference_id"].ToString().Trim();
        //                    }
        //                    if (ObjParam["payment_authorization_code"].ToString().Trim() != string.Empty)
        //                    {
        //                        TranRow["payment_authorization_code"] = ObjParam["payment_authorization_code"].ToString().Trim();
        //                    }
        //                    if (ObjParam["payment_root_transaction_reference_no"].ToString().Trim() != string.Empty)
        //                    {
        //                        TranRow["payment_root_transaction_reference_no"] = ObjParam["payment_root_transaction_reference_no"].ToString().Trim();
        //                    }

        //                    TranRow["payment_return_flag"] = Constant.YES;
        //                    TranRow["status_is_payment_received"] = Constant.YES;

        //                    TranRow["last_modified_date"] = DateTime.Now;
        //                    TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
        //                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

        //                    obDS_Payment.ApplicationPaymentTransaction.ImportRow(TranRow);

        //                    DBConnection.Open();

        //                    //Begin Transaction.
        //                    DBCommand.Transaction = DBConnection.BeginTransaction();

        //                    DataTable course_detail = objGetMasterDetails.GetProgramCourseDetails(program_course_id);
        //                    if (!(course_detail != null && course_detail.Rows.Count > 0))
        //                    {
        //                        message += "Course Detail Not Found.";
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    DataRow CourseDetailRow = course_detail.Rows[0];
        //                    string ProgramTypeId = CourseDetailRow["program_type_id"].ToString();
        //                    string ProgramFacultyId = CourseDetailRow["program_faculty_id"].ToString();

        //                    string AppDocType = objGetMasterDetails.GetApplicationDocType(ProgramTypeId, ProgramFacultyId);

        //                    //Generate Application Id
        //                    Document objDoc = new Document();
        //                    string application_id = string.Empty;

        //                    byte result = objDoc.GetNextDocumentNo(ref DBCommand, "1", AppDocType, DateTime.Today, ref application_id, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, ref message);
        //                    if (result != 1)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail To Generate Application Id.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Get Year Code
        //                    YearMst obYearMst = new YearMst();
        //                    string YearCode = string.Empty;

        //                    result = obYearMst.GetPeriodYear(ref DBCommand, "1", DateTime.Today, ref YearCode, ref message);
        //                    if (result != 1)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Period Year Not Found.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    #region Set Application Master Entry

        //                    DS_Payment.ApplicationMstRow obApplicationMstRow = obDS_Payment.ApplicationMst.NewApplicationMstRow();

        //                    obApplicationMstRow.application_id = application_id;
        //                    obApplicationMstRow.transaction_id = transactionId;
        //                    obApplicationMstRow.program_course_id = program_course_id;
        //                    obApplicationMstRow.program_type_id = ProgramTypeId;
        //                    obApplicationMstRow.program_faculty_id = ProgramFacultyId;
        //                    obApplicationMstRow.year_code = YearCode;
        //                    obApplicationMstRow.status = Constant.STATUS_ACTIVE;
        //                    obApplicationMstRow.is_admin_approved = Constant.NO;
        //                    obApplicationMstRow.user_id = user_id;
        //                    obApplicationMstRow.created_by = HttpContext.Current.Session["UserId"].ToString();
        //                    obApplicationMstRow.created_date = DateTime.Now;
        //                    obApplicationMstRow.created_host = HttpContext.Current.Request.UserHostName;

        //                    obDS_Payment.ApplicationMst.AddApplicationMstRow(obApplicationMstRow);

        //                    #endregion

        //                    #region Set Admin Activity Log Entry (AdminActivityLog)

        //                    //Generat Document Number                          
        //                    string LogId = string.Empty;

        //                    result = objDoc.GetNextDocumentNo(ref DBCommand, "1", Constant.ADMIN_ACTIVITY_LOG, DateTime.Today, ref LogId, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, ref message);
        //                    if (result != 1)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail To Generate Admin Activity Log Id.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    DS_Payment.AdminActivityLogRow rowLog = obDS_Payment.AdminActivityLog.NewAdminActivityLogRow();
        //                    rowLog.log_id = LogId;
        //                    rowLog.user_id = HttpContext.Current.Session["UserId"].ToString();
        //                    rowLog.candidate_id = user_id;
        //                    rowLog.program_course_id = program_course_id;
        //                    rowLog.program_type_id = ProgramTypeId;
        //                    rowLog.program_faculty_id = ProgramFacultyId;
        //                    rowLog.remark = "Application Generated Successfully With Id : " + application_id + ", Transaction Id : " + transactionId;
        //                    rowLog.created_date = DateTime.Now;
        //                    rowLog.created_by = HttpContext.Current.Session["UserId"].ToString();
        //                    rowLog.created_host = HttpContext.Current.Request.UserHostName;
        //                    obDS_Payment.AdminActivityLog.AddAdminActivityLogRow(rowLog);

        //                    #endregion

        //                    try
        //                    {
        //                        obDS_Payment.EnforceConstraints = true;
        //                    }
        //                    catch (ConstraintException ce)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        message += ce.Message;
        //                        Log.ExceptionLog(ce.Message + Environment.NewLine + ce.StackTrace);
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }
        //                    catch (Exception ex)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        message += ex.Message;
        //                        Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Update Transaction Master
        //                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ApplicationPaymentTransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
        //                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ApplicationPaymentTransaction.Rows.Count)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail to Update Transaction Details.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Save Application Master
        //                    objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ApplicationMst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
        //                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ApplicationMst.Rows.Count)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail to Save Application Details.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Update Admin Activity Log
        //                    objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.AdminActivityLog, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly);
        //                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.AdminActivityLog.Rows.Count)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail to Save Admin Log Details.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    message += "Application Generated Successfully with Id : " + application_id + ", Transaction Id : " + transactionId;
        //                    DBCommand.Transaction.Commit();
        //                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                    send_obj.responseObjectInfo.Status = 1;
        //                    send_obj.responseObjectInfo.Message = message;
        //                    return send_obj;
        //                }
        //                else
        //                {
        //                    message += "Tansaction Not Found with Id : " + transactionId;
        //                    send_obj.responseObjectInfo.Status = 2;
        //                    send_obj.responseObjectInfo.Message = message;
        //                    return send_obj;
        //                }
        //            }
        //        }
        //        else
        //        {
        //            message += "Transaction Id Not in Parameters.";
        //            send_obj.responseObjectInfo.Status = 2;
        //            send_obj.responseObjectInfo.Message = message;
        //            return send_obj;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        if (DBCommand.Transaction != null)
        //            DBCommand.Transaction.Rollback();
        //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //        send_obj.responseObjectInfo.Status = 2;
        //        send_obj.responseObjectInfo.Message = ex.Message;
        //        Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
        //    }

        //    return send_obj;
        //}
        #endregion

        #region <-- Admin - Save Application Details (Generate Application By Cash Collection Counter) -->
        //private SendReceiveJSon SaveApplicationDetailsByCash(SendReceiveJSon receive_obj)
        //{
        //    SendReceiveJSon send_obj = new SendReceiveJSon();
        //    string message = string.Empty;
        //    string transactionId = string.Empty;

        //    Dictionary<String, Object> ObjParam = receive_obj.requestObjectInfo.OpArgs;

        //    send_obj.responseObjectInfo.transactionType = "Save";

        //    try
        //    {
        //        //Get Transaction Id
        //        if (ObjParam.ContainsKey("transaction_id") && ObjParam["transaction_id"] != null && ObjParam["transaction_id"].ToString().Trim() != string.Empty)
        //        {
        //            transactionId = ObjParam["transaction_id"].ToString().Trim();

        //            GetMasterDetails objGetMasterDetails = new GetMasterDetails();

        //            //Get Application Master Details for Transaction Id
        //            DataTable dtApplicationDetails = objGetMasterDetails.GetApplicationDetails(transactionId);
        //            if (dtApplicationDetails != null && dtApplicationDetails.Rows.Count > 0)
        //            {
        //                //Already Exist Transaction Id
        //                message += "Tansaction Id Already Exist in ApplicationMst : " + transactionId;
        //                send_obj.responseObjectInfo.Status = 2;
        //                send_obj.responseObjectInfo.Message = message;
        //                return send_obj;
        //            }
        //            else
        //            {
        //                //Get Transaction Details for Transaction Id
        //                DataTable dtTranDetail = objGetMasterDetails.GetTransactionDetails(transactionId);

        //                //Update the Application Mst Details
        //                if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
        //                {
        //                    DS_Payment obDS_Payment = new DS_Payment();

        //                    obDS_Payment.EnforceConstraints = false;
        //                    DataRow TranRow = dtTranDetail.Rows[0];

        //                    string program_course_id = TranRow["program_course_id"].ToString();
        //                    string user_id = TranRow["user_id"].ToString();

        //                    TranRow["payment_response_code"] = 0;
        //                    TranRow["payment_response_msg"] = "Transaction Successful";

        //                    TranRow["payment_return_flag"] = Constant.YES;
        //                    TranRow["status_is_payment_received"] = Constant.YES;

        //                    if (ObjParam["cash_collect_token_id"].ToString().Trim() != string.Empty)
        //                    {
        //                        TranRow["cash_collect_token_id"] = ObjParam["cash_collect_token_id"].ToString().Trim();
        //                    }

        //                    TranRow["payment_mode"] = Constant.PAYMENT_MODE_CASH;
        //                    TranRow["cash_collected_by"] = HttpContext.Current.Session["UserId"].ToString();

        //                    TranRow["last_modified_date"] = DateTime.Now;
        //                    TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
        //                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

        //                    obDS_Payment.ApplicationPaymentTransaction.ImportRow(TranRow);

        //                    DBConnection.Open();

        //                    //Begin Transaction.
        //                    DBCommand.Transaction = DBConnection.BeginTransaction();

        //                    DataTable course_detail = objGetMasterDetails.GetProgramCourseDetails(program_course_id);
        //                    if (!(course_detail != null && course_detail.Rows.Count > 0))
        //                    {
        //                        message += "Course Detail Not Found.";
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    DataRow CourseDetailRow = course_detail.Rows[0];
        //                    string ProgramTypeId = CourseDetailRow["program_type_id"].ToString();
        //                    string ProgramFacultyId = CourseDetailRow["program_faculty_id"].ToString();

        //                    string AppDocType = objGetMasterDetails.GetApplicationDocType(ProgramTypeId, ProgramFacultyId);

        //                    //Generate Application Id
        //                    Document objDoc = new Document();
        //                    string application_id = string.Empty;

        //                    byte result = objDoc.GetNextDocumentNo(ref DBCommand, "1", AppDocType, DateTime.Today, ref application_id, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, ref message);
        //                    if (result != 1)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail To Generate Application Id.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Get Year Code
        //                    YearMst obYearMst = new YearMst();
        //                    string YearCode = string.Empty;

        //                    result = obYearMst.GetPeriodYear(ref DBCommand, "1", DateTime.Today, ref YearCode, ref message);
        //                    if (result != 1)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Period Year Not Found.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    #region Set Application Master Entry

        //                    DS_Payment.ApplicationMstRow obApplicationMstRow = obDS_Payment.ApplicationMst.NewApplicationMstRow();

        //                    obApplicationMstRow.application_id = application_id;
        //                    obApplicationMstRow.transaction_id = transactionId;
        //                    obApplicationMstRow.program_course_id = program_course_id;
        //                    obApplicationMstRow.program_type_id = ProgramTypeId;
        //                    obApplicationMstRow.program_faculty_id = ProgramFacultyId;
        //                    obApplicationMstRow.year_code = YearCode;
        //                    obApplicationMstRow.status = Constant.STATUS_ACTIVE;
        //                    obApplicationMstRow.is_admin_approved = Constant.NO;
        //                    obApplicationMstRow.user_id = user_id;
        //                    obApplicationMstRow.created_by = HttpContext.Current.Session["UserId"].ToString();
        //                    obApplicationMstRow.created_date = DateTime.Now;
        //                    obApplicationMstRow.created_host = HttpContext.Current.Request.UserHostName;

        //                    obDS_Payment.ApplicationMst.AddApplicationMstRow(obApplicationMstRow);

        //                    #endregion

        //                    #region Set Admin Activity Log Entry (AdminActivityLog)

        //                    //Generat Document Number                          
        //                    string LogId = string.Empty;

        //                    result = objDoc.GetNextDocumentNo(ref DBCommand, "1", Constant.ADMIN_ACTIVITY_LOG, DateTime.Today, ref LogId, HttpContext.Current.Session["UserId"].ToString(), HttpContext.Current.Request.UserHostName, ref message);
        //                    if (result != 1)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail To Generate Admin Activity Log Id.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    DS_Payment.AdminActivityLogRow rowLog = obDS_Payment.AdminActivityLog.NewAdminActivityLogRow();
        //                    rowLog.log_id = LogId;
        //                    rowLog.user_id = HttpContext.Current.Session["UserId"].ToString();
        //                    rowLog.candidate_id = user_id;
        //                    rowLog.program_course_id = program_course_id;
        //                    rowLog.program_type_id = ProgramTypeId;
        //                    rowLog.program_faculty_id = ProgramFacultyId;
        //                    rowLog.remark = "Application Generated Successfully With Id : " + application_id + ", Transaction Id : " + transactionId;
        //                    rowLog.created_date = DateTime.Now;
        //                    rowLog.created_by = HttpContext.Current.Session["UserId"].ToString();
        //                    rowLog.created_host = HttpContext.Current.Request.UserHostName;
        //                    obDS_Payment.AdminActivityLog.AddAdminActivityLogRow(rowLog);

        //                    #endregion

        //                    try
        //                    {
        //                        obDS_Payment.EnforceConstraints = true;
        //                    }
        //                    catch (ConstraintException ce)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        message += ce.Message;
        //                        Log.ExceptionLog(ce.Message + Environment.NewLine + ce.StackTrace);
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }
        //                    catch (Exception ex)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        message += ex.Message;
        //                        Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Update Transaction Master
        //                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ApplicationPaymentTransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
        //                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ApplicationPaymentTransaction.Rows.Count)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail to Update Transaction Details.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Save Application Master
        //                    objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.ApplicationMst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
        //                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.ApplicationMst.Rows.Count)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail to Save Application Details.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    //Update Admin Activity Log
        //                    objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.AdminActivityLog, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly);
        //                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.AdminActivityLog.Rows.Count)
        //                    {
        //                        DBCommand.Transaction.Rollback();
        //                        message += "Fail to Save Admin Log Details.";
        //                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                        send_obj.responseObjectInfo.Status = 2;
        //                        send_obj.responseObjectInfo.Message = message;
        //                        return send_obj;
        //                    }

        //                    message += "Application Generated Successfully with Id : " + application_id + ", Transaction Id : " + transactionId;
        //                    DBCommand.Transaction.Commit();
        //                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //                    send_obj.responseObjectInfo.Status = 1;
        //                    send_obj.responseObjectInfo.Message = message;
        //                    return send_obj;
        //                }
        //                else
        //                {
        //                    message += "Tansaction Not Found with Id : " + transactionId;
        //                    send_obj.responseObjectInfo.Status = 2;
        //                    send_obj.responseObjectInfo.Message = message;
        //                    return send_obj;
        //                }
        //            }
        //        }
        //        else
        //        {
        //            message += "Transaction Id Not in Parameters.";
        //            send_obj.responseObjectInfo.Status = 2;
        //            send_obj.responseObjectInfo.Message = message;
        //            return send_obj;
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        if (DBCommand.Transaction != null)
        //            DBCommand.Transaction.Rollback();
        //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //        send_obj.responseObjectInfo.Status = 2;
        //        send_obj.responseObjectInfo.Message = ex.Message;
        //        Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
        //    }

        //    return send_obj;
        //}
        #endregion

       
    }
}