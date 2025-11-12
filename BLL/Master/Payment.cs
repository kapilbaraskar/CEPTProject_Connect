///#define localpaymnet
#define livepaymnet
using BLL.Utilities1;
using CCA.Util;
using Newtonsoft.Json;
using SFA;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using XSD.Masters;


//using BLL.Utilities;


namespace BLL.Master
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

        Masters objMaster = new Masters(); // Master Class Object

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
                DS_Payment obj_DS_Payment = new DS_Payment();

                if (DBConnection.State == ConnectionState.Closed) DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                Document obj_Document = new Document();
                //string transaction_doc_type = Constant.TRANSACTION_DOC_TYPE;
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

                transaction_id = trans_code + transaction_doc_no;
                DS_Payment.applicationpaymenttransactionRow TransactionRow = obj_DS_Payment.applicationpaymenttransaction.NewapplicationpaymenttransactionRow();
                TransactionRow.user_id = UserId;
                TransactionRow.transaction_id = trans_code + transaction_doc_no;
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
                //TransactionRow.TransactionPaymentModeType = SessionMaster.PaymentMode;

                if (HttpContext.Current.Session["cur_installment"] != null)
                {
                    TransactionRow.cash_collected_by = HttpContext.Current.Session["cur_installment"].ToString();
                }

                obj_DS_Payment.applicationpaymenttransaction.AddapplicationpaymenttransactionRow(TransactionRow);

                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_DS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obj_DS_Payment.applicationpaymenttransaction.Rows.Count)
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
                    //Newtonsoft.Json.
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
            //Newtonsoft.Json.
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
            Masters objGetMasterDetails = new Masters();

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
                DS_Payment obDS_Payment = new DS_Payment();



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

                obDS_Payment.applicationpaymenttransaction.ImportRow(TranRow);

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
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.applicationpaymenttransaction.Rows.Count)
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
                SqlSelect = "SELECT * from  applicationpaymenttransaction  where  transaction_id ='" + transaction_id + "'";
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

        public DataTable GetTransactionDetailsByUserId(string transaction_id, string user_id)
        {
            Log.PaymentTransactionLog("GetTransactionDetails method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                //BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from  applicationpaymenttransaction  where  transaction_id ='" + transaction_id + "' and user_id ='" + user_id + "'";
                //BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);

                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                //BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);
                DataSet ds = new DataSet();
                try
                {
                    DBDataAdpterObject.Fill(ds);
                    if (ds.Tables[0].Rows.Count <= 0)
                    {
                        //BLL.Utilities1.Log.PaymentTransactionLog("row not found");
                        return null;
                    }
                    else
                    {

                        //BLL.Utilities1.Log.PaymentTransactionLog("successful" + ds.Tables[0].Rows[0]["transaction_id"].ToString());
                        dt = ds.Tables[0];
                        //BLL.Utilities1.Log.PaymentTransactionLog("successful1" + dt.Rows[0]["transaction_id"].ToString());
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
            Masters objGetMasterDetails = new Masters();

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
                    DS_Payment obDS_Payment = new DS_Payment();

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

                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                    //TranRow["last_modified_date"] = DateTime.Now;
                    //TranRow["last_modified_by"] = user_id;
                    //TranRow["last_modified_host"] = "";

                    obDS_Payment.applicationpaymenttransaction.ImportRow(TranRow);
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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.applicationpaymenttransaction.Rows.Count)
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

                    Log.PaymentTransactionLog("" + ex.ToString());
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

            string MID = "";

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

            switch (FacultyId)
            {
                case "1": //Faculty of Architecture
                    MID = "https://www.citruspay.com/ceptarchitecture";
                    break;
                case "2": //Faculty of Design
                    MID = "https://www.citruspay.com/ceptdesign";
                    break;
                case "3": //Faculty of Management
                    MID = "https://www.citruspay.com/ceptdesign";
                    break;
                case "4": //Faculty of Planning
                    MID = "https://www.citruspay.com/ceptplanning";
                    break;
                case "5": //Faculty of Technology
                    MID = "https://www.citruspay.com/cepttechnology";
                    break;

                default:
                    MID = "";
                    break;
            }

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

            string url = "";

            switch (FacultyId)
            {
                case "1": //Faculty of Architecture
                    url = "hmac_signatureArchitecture.aspx";
                    break;
                case "2": //Faculty of Design
                    url = "hmac_signatureDesign.aspx";
                    break;
                case "3": //Faculty of Management
                    url = "hmac_signatureManagement.aspx";
                    break;

                case "4": //Faculty of Planning
                    url = "hmac_signaturePlanning.aspx";
                    break;
                case "5": //Faculty of Technology
                    url = "hmac_signatureTechnology.aspx";
                    break;

                default:
                    url = "";
                    break;
            }

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

            string url = "";

            switch (FacultyId)
            {
                case "1": //Faculty of Architecture
                    url = "PaymentResponseNetBankingArchitecture.aspx";
                    break;
                case "2": //Faculty of Design
                    url = "PaymentResponseNetBankingDesign.aspx";
                    break;
                case "3": //Faculty of Management
                    url = "PaymentResponseNetBankingManagement.aspx";
                    break;

                case "4": //Faculty of Planning
                    url = "PaymentResponseNetBankingPlanning.aspx";
                    break;
                case "5": //Faculty of Technology
                    url = "PaymentResponseNetBankingTechnology.aspx";
                    break;

                default:
                    url = "";
                    break;
            }

            return url;
        }
        #endregion

        #region <-- Get Payment Installation Faculty page -->
        public static string Get_payment_installation_return_url(string FacultyId)
        {
            string url = "";

            switch (FacultyId)
            {
                case "1": //Faculty of Architecture
                    url = "PaymentResponseArchitecture.aspx";
                    break;
                case "2": //Faculty of Design
                    url = "PaymentResponseDesign.aspx";
                    break;
                case "3": //Faculty of Management
                    url = "PaymentResponseManagement.aspx";
                    break;
                case "4": //Faculty of Planning
                    url = "PaymentResponsePlanning.aspx";
                    break;
                case "5": //Faculty of Technology
                    url = "PaymentResponseTechnology.aspx";
                    break;
                default:
                    url = "";
                    break;
            }
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
            //Log.PaymentTransactionLog("btnMakePayment_Click : CourseId : " + program_course_id + ", UserId : " + user_id);
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

        #region <-- SID Payment Gateway -->

        public bool SID_RedirectToPaymentGateway(Dictionary<string, object> Param, ref string message, string user_id, decimal Amount, string semester_code, string semester_type, string year_semester, string department, string trans_code, ref string transaction_id)
        {
            transaction_id = "";
            string program_course_id = "";
            string program_faculty_id = "";
            string program_type_id = "";

            program_faculty_id = department;

            Log.PaymentTransactionLog("btnMakePayment_Click : CourseId : " + program_course_id + ", UserId : " + user_id);

            Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
            ObjParam.Add("user_id", user_id);

            string MerchantId = "";

            MerchantId = Payment.GetMerchantId(program_faculty_id);

            if (MerchantId != "")
            {
                HttpContext.Current.Session["MerchantId"] = MerchantId;

                string msg = string.Empty;

                //Entry in Payment Transaction Details
                bool result = SID_BeginPaymentTransaction(user_id, Param, ref transaction_id, ref msg, semester_code, semester_type, year_semester, Amount, department, trans_code);

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
        }

        public bool SID_BeginPaymentTransaction(string UserId, Dictionary<string, object> courses_applied, ref string transaction_id, ref string message, string semester_code, string semester_type, string year_semester, decimal Amount, string department, string trans_code)
        {
            if (UserId == null || UserId == string.Empty)
            {
                message = "UserId not found";
                return false;
            }

            decimal TotalAmount = Amount;

            try
            {
                DS_Payment obj_DS_Payment = new DS_Payment();

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

                transaction_id = trans_code + transaction_doc_no;
                DS_Payment.applicationpaymenttransactionRow TransactionRow = obj_DS_Payment.applicationpaymenttransaction.NewapplicationpaymenttransactionRow();
                TransactionRow.user_id = UserId;
                TransactionRow.transaction_id = trans_code + transaction_doc_no;
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

                obj_DS_Payment.applicationpaymenttransaction.AddapplicationpaymenttransactionRow(TransactionRow);

                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_DS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obj_DS_Payment.applicationpaymenttransaction.Rows.Count)
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

        public string SID_SavePaymentDetails(HttpRequest Request, ref PaymentRes paymentResponse, string key)
        {
            string msg = "";
            Log.PaymentTransactionLog("Payment Response From Citrus : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Request["pgRespCode"];
            res["Response Message"] = Request["TxMsg"];
            res["Merchant Txn Id"] = Request["TxId"];

            Log.PaymentTransactionLog("Payment Response From Citrus : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
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
                    bool result = SID_PaymentSuccessSave(transactionId, Request, ref paymentResponse, ref message);

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

                    bool result = SID_PaymentFailSave(transactionId, Request, ref paymentResponse, ref message);
                }
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

        internal bool SID_PaymentSuccessSave(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");

            DataTable dtTranDetail = Get_SID_TransactionDetails(transactionId);

            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DSC_SID_Registration obDS_Payment = new DSC_SID_Registration();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];

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

                    TranRow["last_modified_by"] = TranRow["user_id"].ToString();
                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_host"] = Request.UserHostName;

                    obDS_Payment.sid_registration_paymenttransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");

                    // generate application
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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.sid_registration_paymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.sid_registration_paymenttransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("" + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
        }

        internal bool SID_PaymentFailSave(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");

            DataTable dtTranDetail = Get_SID_TransactionDetails(transactionId);

            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DSC_SID_Registration obDS_Payment = new DSC_SID_Registration();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];

                    user_id = TranRow["user_id"].ToString();
                    Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;

                    TranRow["payment_response_code"] = Request["pgRespCode"];
                    TranRow["payment_response_msg"] = Request["TxMsg"];
                    TranRow["payment_transaction_reference_id"] = Request["pgTxnNo"];
                    TranRow["Citrus_TxRefNo"] = Request["TxRefNo"];

                    TranRow["last_modified_by"] = TranRow["user_id"].ToString();
                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_host"] = Request.UserHostName;

                    obDS_Payment.sid_registration_paymenttransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");

                    // generate application
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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.sid_registration_paymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.sid_registration_paymenttransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("" + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
        }

        public DataTable Get_SID_TransactionDetails(string transaction_id)
        {
            Log.PaymentTransactionLog("GetTransactionDetails method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from sid_registration_paymenttransaction where transaction_id ='" + transaction_id + "'";
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

        #region <-- LA25 Payment Gateway -->

        public bool LA25_RedirectToPaymentGateway(Dictionary<string, object> Param, ref string message, string user_id, decimal Amount, string semester_code, string semester_type, string year_semester, string department, string trans_code, ref string transaction_id)
        {
            transaction_id = "";
            string program_course_id = "";
            string program_faculty_id = "";
            string program_type_id = "";

            program_faculty_id = department;

            Log.PaymentTransactionLog("btnMakePayment_Click : CourseId : " + program_course_id + ", UserId : " + user_id);

            Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
            ObjParam.Add("user_id", user_id);

            string MerchantId = "";

            MerchantId = Payment.GetMerchantId(program_faculty_id);

            if (MerchantId != "")
            {
                HttpContext.Current.Session["MerchantId"] = MerchantId;

                string msg = string.Empty;

                //Entry in Payment Transaction Details
                bool result = LA25_BeginPaymentTransaction(user_id, Param, ref transaction_id, ref msg, semester_code, semester_type, year_semester, Amount, department, trans_code);

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
        }

        public bool LA25_BeginPaymentTransaction(string UserId, Dictionary<string, object> courses_applied, ref string transaction_id, ref string message, string semester_code, string semester_type, string year_semester, decimal Amount, string department, string trans_code)
        {
            if (UserId == null || UserId == string.Empty)
            {
                message = "UserId not found";
                return false;
            }

            decimal TotalAmount = Amount;

            try
            {
                DS_Payment obj_DS_Payment = new DS_Payment();

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

                transaction_id = trans_code + transaction_doc_no;
                DS_Payment.applicationpaymenttransactionRow TransactionRow = obj_DS_Payment.applicationpaymenttransaction.NewapplicationpaymenttransactionRow();
                TransactionRow.user_id = UserId;
                TransactionRow.transaction_id = trans_code + transaction_doc_no;
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

                obj_DS_Payment.applicationpaymenttransaction.AddapplicationpaymenttransactionRow(TransactionRow);

                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_DS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obj_DS_Payment.applicationpaymenttransaction.Rows.Count)
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

        public string LA25_SavePaymentDetails(HttpRequest Request, ref PaymentRes paymentResponse, string key)
        {
            string msg = "";
            Log.PaymentTransactionLog("Payment Response From Citrus : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Request["pgRespCode"];
            res["Response Message"] = Request["TxMsg"];
            res["Merchant Txn Id"] = Request["TxId"];

            Log.PaymentTransactionLog("Payment Response From Citrus : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
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
                    bool result = LA25_PaymentSuccessSave(transactionId, Request, ref paymentResponse, ref message);

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

                    bool result = LA25_PaymentFailSave(transactionId, Request, ref paymentResponse, ref message);
                }
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

        internal bool LA25_PaymentSuccessSave(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");

            DataTable dtTranDetail = Get_LA25_TransactionDetails(transactionId);

            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DSC_LA25_Registration obDS_Payment = new DSC_LA25_Registration();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];

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

                    TranRow["last_modified_by"] = TranRow["user_id"].ToString();
                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_host"] = Request.UserHostName;

                    obDS_Payment.LA25_registration_paymenttransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");

                    // generate application
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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.LA25_registration_paymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.LA25_registration_paymenttransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("" + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
        }

        internal bool LA25_PaymentFailSave(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");

            DataTable dtTranDetail = Get_LA25_TransactionDetails(transactionId);

            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DSC_LA25_Registration obDS_Payment = new DSC_LA25_Registration();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];

                    user_id = TranRow["user_id"].ToString();
                    Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;

                    TranRow["payment_response_code"] = Request["pgRespCode"];
                    TranRow["payment_response_msg"] = Request["TxMsg"];
                    TranRow["payment_transaction_reference_id"] = Request["pgTxnNo"];
                    TranRow["Citrus_TxRefNo"] = Request["TxRefNo"];

                    TranRow["last_modified_by"] = TranRow["user_id"].ToString();
                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_host"] = Request.UserHostName;

                    obDS_Payment.LA25_registration_paymenttransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");

                    // generate application
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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.LA25_registration_paymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.LA25_registration_paymenttransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("" + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
        }

        public DataTable Get_LA25_TransactionDetails(string transaction_id)
        {
            Log.PaymentTransactionLog("GetTransactionDetails method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from LA25_registration_paymenttransaction where transaction_id ='" + transaction_id + "'";
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

        #region BTG Payment Getway

        public bool BTG_RedirectToPaymentGateway(Dictionary<string, object> Param, ref string message, string user_id, decimal Amount, string semester_code, string semester_type, string year_semester, string department, string trans_code, ref string transaction_id)
        {
            transaction_id = "";
            string program_course_id = "";
            string program_faculty_id = "";
            string program_type_id = "";

            program_faculty_id = department;

            Log.PaymentTransactionLog("btnMakePayment_Click : CourseId : " + program_course_id + ", UserId : " + user_id);

            Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
            ObjParam.Add("user_id", user_id);

            string MerchantId = "";

            MerchantId = Payment.GetMerchantId(program_faculty_id);

            if (MerchantId != "")
            {
                HttpContext.Current.Session["MerchantId"] = MerchantId;

                string msg = string.Empty;

                //Entry in Payment Transaction Details
                bool result = BTG_BeginPaymentTransaction(user_id, Param, ref transaction_id, ref msg, semester_code, semester_type, year_semester, Amount, department, trans_code);

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
        }

        public bool BTG_BeginPaymentTransaction(string UserId, Dictionary<string, object> courses_applied, ref string transaction_id, ref string message, string semester_code, string semester_type, string year_semester, decimal Amount, string department, string trans_code)
        {
            if (UserId == null || UserId == string.Empty)
            {
                message = "UserId not found";
                return false;
            }

            decimal TotalAmount = Amount;

            try
            {
                DS_Payment obj_DS_Payment = new DS_Payment();

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

                transaction_id = trans_code + transaction_doc_no;
                DS_Payment.applicationpaymenttransactionRow TransactionRow = obj_DS_Payment.applicationpaymenttransaction.NewapplicationpaymenttransactionRow();
                TransactionRow.user_id = UserId;
                TransactionRow.transaction_id = trans_code + transaction_doc_no;
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

                obj_DS_Payment.applicationpaymenttransaction.AddapplicationpaymenttransactionRow(TransactionRow);

                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_DS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obj_DS_Payment.applicationpaymenttransaction.Rows.Count)
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

        public string BTG_SavePaymentDetails(HttpRequest Request, ref PaymentRes paymentResponse, string key)
        {
            string msg = "";
            Log.PaymentTransactionLog("Payment Response From Citrus : SavePaymentDetailsCall BTG ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Request["pgRespCode"];
            res["Response Message"] = Request["TxMsg"];
            res["Merchant Txn Id"] = Request["TxId"];

            Log.PaymentTransactionLog("Payment Response From Citrus : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
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

                Log.PaymentTransactionLog("Payment Response From Citrus : Signature missmatch. BTG ");
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
                    bool result = BTG_PaymentSuccessSave(transactionId, Request, ref paymentResponse, ref message);

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

                    bool result = BTG_PaymentFailSave(transactionId, Request, ref paymentResponse, ref message);
                }
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

        internal bool BTG_PaymentSuccessSave(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");

            DataTable dtTranDetail = Get_BTG_TransactionDetails(transactionId);
            DBConnection.Open();
            DBCommand.Transaction = DBConnection.BeginTransaction();
            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());
            BLL.Utilities.BLReturnObject objBLReturnObject = new BLL.Utilities.BLReturnObject();
            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    DSC_BTG_Registration obDS_Payment = new DSC_BTG_Registration();
                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];
                    user_id = TranRow["user_id"].ToString();
                    paymentResponse.data.user_id = user_id;

                    if (TranRow["team_id"].ToString() == "1")
                    {
                        String DocNo = "";
                        BLL.Utilities.Document objDocument = new BLL.Utilities.Document();

                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "01", "BTGTN", user_id, "1.1.1", ref DocNo, ref message))
                        {
                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return false;
                        }

                        TranRow["team_id"] = DocNo.Substring(8);
                    }

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

                    TranRow["last_modified_by"] = TranRow["user_id"].ToString();
                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_host"] = Request.UserHostName;

                    obDS_Payment.BTG_payment_dtl.ImportRow(TranRow);


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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.BTG_payment_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.BTG_payment_dtl.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("" + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
        }

        internal bool BTG_PaymentFailSave(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Get Transaction Details for Transaction Id
            Log.PaymentTransactionLog("PaymentSuccessSave method");

            DataTable dtTranDetail = Get_BTG_TransactionDetails(transactionId);

            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the application master details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DSC_BTG_Registration obDS_Payment = new DSC_BTG_Registration();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];

                    user_id = TranRow["user_id"].ToString();
                    Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;

                    TranRow["payment_response_code"] = Request["pgRespCode"];
                    TranRow["payment_response_msg"] = Request["TxMsg"];
                    TranRow["payment_transaction_reference_id"] = Request["pgTxnNo"];
                    TranRow["Citrus_TxRefNo"] = Request["TxRefNo"];

                    TranRow["last_modified_by"] = TranRow["user_id"].ToString();
                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_host"] = Request.UserHostName;

                    obDS_Payment.BTG_payment_dtl.ImportRow(TranRow);
                    //  Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    //  Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    //  Log.PaymentTransactionLog("connection Begin");

                    // generate application
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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.BTG_payment_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.BTG_payment_dtl.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("" + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
        }

        public DataTable Get_BTG_TransactionDetails(string transaction_id)
        {
            Log.PaymentTransactionLog("GetTransactionDetails method BTG");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from BTG_payment_dtl where transaction_id ='" + transaction_id + "'";
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

        #region <-- Eazypay Payment Gateway -->

        public string Get_eazypay_encrypted_url(ref Dictionary<string, object> dic_payment_dtl)
        {
            try
            {
                string str_req_url_plaintext = "https://eazypay.icicibank.com/EazyPG";
                str_req_url_plaintext += "?merchantid=" + dic_payment_dtl["merchant_id"];
                str_req_url_plaintext += "&mandatory fields=" + dic_payment_dtl["mandatory_field"].ToString();
                str_req_url_plaintext += "&optional fields=";
                str_req_url_plaintext += "&returnurl=" + dic_payment_dtl["return_url"].ToString();
                str_req_url_plaintext += "&Reference No=" + dic_payment_dtl["reference_no"].ToString();
                str_req_url_plaintext += "&submerchantid=" + dic_payment_dtl["sub_merchant_id"].ToString();
                str_req_url_plaintext += "&transaction amount=" + dic_payment_dtl["transaction_amount"];
                str_req_url_plaintext += "&paymode=" + dic_payment_dtl["paymode"].ToString();

                BLL.Utilities1.Log.PaymentTransactionLog("PaymentURL PlainText URL" + str_req_url_plaintext);


                string str_key = Get_Eazypay_AESKEY(dic_payment_dtl["faculty"].ToString());

                dic_payment_dtl["mandatory_field"] = Encrypt_AES(dic_payment_dtl["mandatory_field"].ToString(), str_key);
                dic_payment_dtl["optional_field"] = Encrypt_AES(dic_payment_dtl["optional_field"].ToString(), str_key);
                dic_payment_dtl["return_url"] = Encrypt_AES(dic_payment_dtl["return_url"].ToString(), str_key);
                dic_payment_dtl["reference_no"] = Encrypt_AES(dic_payment_dtl["reference_no"].ToString(), str_key);
                dic_payment_dtl["sub_merchant_id"] = Encrypt_AES(dic_payment_dtl["sub_merchant_id"].ToString(), str_key);
                dic_payment_dtl["transaction_amount"] = Encrypt_AES(dic_payment_dtl["transaction_amount"].ToString(), str_key);
                dic_payment_dtl["paymode"] = Encrypt_AES(dic_payment_dtl["paymode"].ToString(), str_key);
                
                string str_req_url = "https://eazypay.icicibank.com/EazyPG";
                str_req_url += "?merchantid=" + dic_payment_dtl["merchant_id"];
                str_req_url += "&mandatory fields=" + dic_payment_dtl["mandatory_field"];
                str_req_url += "&optional fields=";
                str_req_url += "&returnurl=" + dic_payment_dtl["return_url"];
                str_req_url += "&Reference No=" + dic_payment_dtl["reference_no"];
                str_req_url += "&submerchantid=" + dic_payment_dtl["sub_merchant_id"];
                str_req_url += "&transaction amount=" + dic_payment_dtl["transaction_amount"];
                str_req_url += "&paymode=" + dic_payment_dtl["paymode"];


                BLL.Utilities1.Log.PaymentTransactionLog("PaymentURL Encrypted URL" + str_req_url);
                return str_req_url;
            }
            catch (Exception ex)
            {

            }

            return "";
        }

        public string Get_Eazypay_MerchantId(string FacultyId)
        {
            string MID = "";

            switch (FacultyId)
            {
                case "1": //Faculty of Architecture
                    MID = "109828";
                    break;
                case "2": //Faculty of Design
                    MID = "109955";
                    break;
                case "3": //Faculty of Management
                    MID = "109954";
                    break;
                case "4": //Faculty of Planning
                    MID = "109956";
                    break;
                case "5": //Faculty of Technology
                    MID = "109957";
                    break;

                default:
                    MID = "";
                    break;
            }

            return MID;
        }

        public string Get_Eazypay_AESKEY(string FacultyId)
        {
            string key = "";

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        //key = "1000671898201019";
            //        key = "1000672598201019";
            //        break;
            //    case "2": //Faculty of Design
            //        //key = "1000672199501019";
            //        key = "1000672599501019";
            //        break;
            //    case "3": //Faculty of Management
            //        //key = "1000242099501046";
            //        key = "1000242599501046";
            //        break;
            //    case "4": //Faculty of Planning
            //        //key = "1000672099501019";
            //        key = "1000672599501019";
            //        break;
            //    case "5": //Faculty of Technology
            //        //key = "1000672199501019";
            //        key = "1000672599501019";
            //        break;
            //
            //    default:
            //        key = "";
            //        break;
            //}

            return key = "3800243178901046";//Testing Purpose
        }

        public string Get_Eazypay_return_url(string FacultyId)
        {
            string return_url = "";

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        return_url = "PaymentResponseEazypayArchitecture.aspx";
            //        break;
            //    case "2": //Faculty of Design
            //        return_url = "PaymentResponseEazypayDesign.aspx";
            //        break;
            //    case "3": //Faculty of Management
            //        return_url = "PaymentResponseEazypayManagement.aspx";
            //        break;
            //    case "4": //Faculty of Planning
            //        return_url = "PaymentResponseEazypayPlanning.aspx";
            //        break;
            //    case "5": //Faculty of Technology
            //        return_url = "PaymentResponseEazypayTechnology.aspx";
            //        break;
            //
            //    default:
            //        return_url = "";
            //        break;
            //}

            return return_url = "EazypayRequestHandler.aspx";
        }

        public string Get_Installment_Eazypay_return_url(string FacultyId)
        {
            string return_url = "";

            switch (FacultyId)
            {
                case "1": //Faculty of Architecture
                    return_url = "PaymentInstallmentEazypayArchitecture.aspx";
                    break;
                case "2": //Faculty of Design
                    return_url = "PaymentInstallmentEazypayDesign.aspx";
                    break;
                case "3": //Faculty of Management
                    return_url = "PaymentInstallmentEazypayManagement.aspx";
                    break;
                case "4": //Faculty of Planning
                    return_url = "PaymentInstallmentEazypayPlanning.aspx";
                    break;
                case "5": //Faculty of Technology
                    return_url = "PaymentInstallmentEazypayTechnology.aspx";
                    break;

                default:
                    return_url = "";
                    break;
            }

            return return_url;
        }

        public string Encrypt_AES(string str_input, string str_key)
        {
            byte[] input = System.Text.Encoding.UTF8.GetBytes(str_input);
            byte[] key = System.Text.Encoding.UTF8.GetBytes(str_key);

            var aesAlg = new AesManaged
            {
                KeySize = 128,
                Key = key,
                BlockSize = 128,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7,
                IV = new byte[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
            };

            ICryptoTransform encryptor = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV);
            var final_block = encryptor.TransformFinalBlock(input, 0, input.Length);

            string str_encrypted = Convert.ToBase64String(final_block);

            //if (str_encrypted.IndexOf('\0') > 0) str_encrypted = str_encrypted.Substring(0, str_encrypted.IndexOf('\0'));

            return str_encrypted;
        }

        public string Decrypt_AES(string str_input, string str_key)
        {
            //byte[] input = System.Text.Encoding.UTF8.GetBytes(str_input);
            byte[] input = Convert.FromBase64String(str_input);
            byte[] key = System.Text.Encoding.UTF8.GetBytes(str_key);

            var aesAlg = new AesManaged
            {
                KeySize = 128,
                Key = key,
                BlockSize = 128,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7,
                IV = new byte[] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
            };

            ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);
            //return decryptor.TransformFinalBlock(input, 0, input.Length);

            using (MemoryStream msDecrypt = new MemoryStream(input))
            {
                using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                {
                    using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                    {
                        // Read the decrypted bytes from the decrypting stream
                        // and place them in a string.
                        string str_decrypted = srDecrypt.ReadToEnd();

                        if (str_decrypted.IndexOf('\0') > 0) str_decrypted = str_decrypted.Substring(0, str_decrypted.IndexOf('\0'));

                        return str_decrypted;
                    }
                }
            }

            return "";
        }

        public string SavePaymentDetails_Eazypay(HttpRequest Request, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            Log.PaymentTransactionLog("Payment Response From Eazypay : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Request["Response Code"];
            res["Response Message"] = Request["TxMsg"];
            res["Merchant Txn Id"] = Request["ReferenceNo"];

            Log.PaymentTransactionLog("Payment Response From Eazypay : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
            String data = "";

            String pgRespCode = Request["Response Code"]; //E000 = Success,1,2,3
            String TxId = Request["ReferenceNo"]; //Merchant Transaction ID
            String pgTxnId = Request["ID"]; //Gateway transaction id

            String TxMsg = Request["Response Code"] == "E000" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Request["Unique Ref Number"]; //Eazypay Transaction Id for payment
            String TxStatus = Request["Response Code"] == "E000" ? "SUCCESS" : "FAIL"; //Transaction Status (SUCCESS, FAIL)

            String reqSignature = Request["RS"]; //"SHA512 signature of response data to validate the response data on merchant end See details at Response Signature Section."

            String signature = "";
            bool flag = true;
            string AESkey = Get_Eazypay_AESKEY(faculty);

            //data = Request["ID"] +
            //            "|" + Request["Response Code"] +
            //            "|" + Request["Unique Ref Number"] +
            //            "|" + Request["Service Tax Amount"] +
            //            "|" + Request["Processing Fee Amount"] +
            //            "|" + Request["Total Amount"] +
            //            "|" + Request["Transaction Amount"] +
            //            "|" + Request["Transaction Date"] +
            //            "|" + Request["Interchange Value"] +
            //            "|" + Request["TDR"] +
            //            "|" + Request["Payment Mode"] +
            //            "|" + Request["SubMerchantId"] +
            //            "|" + Request["ReferenceNo"] +
            //            "|" + Request["TPS"] +
            //            "|" + AESkey;

            data = Request["ID"] +
                             "|" + (Request["Response Code"] ?? "") +
                             "|" + (Request["Unique Ref Number"] ?? "") +
                             "|" + (Request["Service Tax Amount"] ?? "") +
                             "|" + (Request["Processing Fee Amount"] ?? "") +
                             "|" + (Request["Total Amount"] ?? "") +
                             "|" + (Request["Transaction Amount"] ?? "") +
                             "|" + (Request["Transaction Date"] ?? "") +
                             "|" + (Request["Interchange Value"] ?? "") +
                             "|" + (Request["TDR"] ?? "") +
                             "|" + (Request["Payment Mode"] ?? "") +
                             "|" + (Request["SubMerchantId"] ?? "") +
                             "|" + (Request["ReferenceNo"] ?? "") +
                             "|" + (Request["TPS"] ?? "") +
                             "|" + AESkey;

            BLL.Utilities1.Log.PaymentTransactionLog("Response data :" + data);

            SHA512 sha512 = new SHA512Managed();
            byte[] signature_byte = sha512.ComputeHash(System.Text.Encoding.UTF8.GetBytes(data));
            foreach (byte x in signature_byte)
            {
                signature += String.Format("{0:x2}", x);
            }

            BLL.Utilities1.Log.PaymentTransactionLog("Response HMAC :" + signature);
            BLL.Utilities1.Log.PaymentTransactionLog("Response reqSignature :" + reqSignature);

            if (reqSignature != null && !signature.Equals(reqSignature))
            {
                flag = false;

                Log.PaymentTransactionLog("Payment Response From Eazypay : Signature missmatch. ");
            }

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Request["ReferenceNo"];

                if (pgRespCode == "E000")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    bool result = PaymentSuccessSave_Eazypay(transactionId, Request, ref paymentResponse, ref message);

                    Log.PaymentTransactionLog("Payment Response From Citrus : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result)
                    {
                        Log.PaymentTransactionLog("Payment Response From Eazypay Result : PaymentSuccessSave Method Response : " + result);
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference. status is " + paymentResponse.status;
                    }
                    else
                    {
                        Log.PaymentTransactionLog("Payment Response From Eazypay Result : paymentSuccessApplicationFail Method Response : " + result);
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

        internal bool PaymentSuccessSave_Eazypay(string transactionId, HttpRequest Request, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            Log.PaymentTransactionLog("PaymentSuccessSave_Eazypay method");
            DataTable dtTranDetail = GetTransactionDetails(transactionId);
            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the Transaction details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DS_Payment obDS_Payment = new DS_Payment();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];
                    //  string program_course_id = TranRow["program_course_id"].ToString();
                    user_id = TranRow["user_id"].ToString();
                    Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;
                    TranRow["payment_return_flag"] = Constant.YES;
                    TranRow["payment_response_code"] = Request["Response Code"] == "E000" ? "0" : Request["Response Code"];
                    TranRow["payment_response_msg"] = Request["Response Code"] == "E000" ? "Transaction Successful" : null;
                    TranRow["payment_transaction_reference_id"] = Request["Unique Ref Number"];
                    TranRow["payment_authorization_code"] = Request["SubMerchantId"];
                    TranRow["Citrus_PaymentMode"] = Request["Payment Mode"];
                    TranRow["Citrus_TxRefNo"] = Request["Unique Ref Number"];
                    TranRow["Citrus_TxGateway"] = "Eazypay";
                    //TranRow["Citrus_IssuerRefNo"] = Request["issuerCode"];
                    TranRow["Citrus_TxStatus"] = Request["Response Code"] == "E000" ? "SUCCESS" : null;
                    TranRow["status_is_payment_received"] = Constant.YES;
                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_by"] = user_id;//HttpContext.Current.Session["UserId"].ToString();
                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;
                    obDS_Payment.applicationpaymenttransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");
                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");
                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");
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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.applicationpaymenttransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();

                }
                catch (Exception ex)
                {

                    Log.PaymentTransactionLog("" + ex.ToString());
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

        #region <-- HDFC Payment Gateway -->

        public string Get_HDFC_MerchantId(string FacultyId)
        {
            //string MID = "154943";// uncomment bcoz it is working before.
            string MID = "222299";// test hdfc cc avenue

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        MID = "154943";
            //        break;
            //    case "2": //Faculty of Design
            //        MID = "154943";
            //        break;
            //    case "3": //Faculty of Management
            //        MID = "154943";
            //        break;
            //    case "4": //Faculty of Planning
            //        MID = "154943";
            //        break;
            //    case "5": //Faculty of Technology
            //        MID = "154943";
            //        break;

            //    default:
            //        MID = "";
            //        break;
            //}

            return MID;
        }

        public string Get_HDFC_working_Key(string FacultyId)
        {
            //string working_Key = "6C25A7D260B19684521A2A9C591E54B0";// uncomment bcoz it is working before.
            string working_Key = "989CB92B9D65911C57D06909D0AAA5B0";// test hdfc cc avenue

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        working_Key = "6C25A7D260B19684521A2A9C591E54B0";
            //        break;
            //    case "2": //Faculty of Design
            //        working_Key = "6C25A7D260B19684521A2A9C591E54B0";
            //        break;
            //    case "3": //Faculty of Management
            //        working_Key = "6C25A7D260B19684521A2A9C591E54B0";
            //        break;
            //    case "4": //Faculty of Planning
            //        working_Key = "6C25A7D260B19684521A2A9C591E54B0";
            //        break;
            //    case "5": //Faculty of Technology
            //        working_Key = "6C25A7D260B19684521A2A9C591E54B0";
            //        break;

            //    default:
            //        working_Key = "";
            //        break;
            //}

            return working_Key;
        }

        public string Get_HDFC_access_code(string FacultyId)
        {
            //string access_code = "AVQG01EK30BF03GQFB";// uncomment bcoz it is working before.
            string access_code = "AVCQ02GF76BJ37QCJB";// test hdfc cc avenue

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        access_code = "AVQG01EK30BF03GQFB";
            //        break;
            //    case "2": //Faculty of Design
            //        access_code = "AVQG01EK30BF03GQFB";
            //        break;
            //    case "3": //Faculty of Management
            //        access_code = "AVQG01EK30BF03GQFB";
            //        break;
            //    case "4": //Faculty of Planning
            //        access_code = "AVQG01EK30BF03GQFB";
            //        break;
            //    case "5": //Faculty of Technology
            //        access_code = "AVQG01EK30BF03GQFB";
            //        break;

            //    default:
            //        access_code = "";
            //        break;
            //}

            return access_code;
        }

        public string Get_HDFC_request_url(string FacultyId)
        {
            string HDFC_request_url = "https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction";

            return HDFC_request_url;
        }

        public string Get_HDFC_return_url(string FacultyId)
        {
            string return_url = "PaymentResponseHDFC.aspx";

            //switch (FacultyId)
            //{
            //    case "1": //Faculty of Architecture
            //        return_url = "PaymentResponseHDFC.aspx";
            //        break;
            //    case "2": //Faculty of Design
            //        return_url = "PaymentResponseHDFC.aspx";
            //        break;
            //    case "3": //Faculty of Management
            //        return_url = "PaymentResponseHDFC.aspx";
            //        break;
            //    case "4": //Faculty of Planning
            //        return_url = "PaymentResponseHDFC.aspx";
            //        break;
            //    case "5": //Faculty of Technology
            //        return_url = "PaymentResponseHDFC.aspx";
            //        break;
            //    default:
            //        return_url = "";
            //        break;
            //}

            return return_url;
        }

        public string Get_HDFC_encrypted_request(ref Dictionary<string, object> dic_payment_dtl)
        {
            try
            {
                string working_key = Get_HDFC_working_Key(dic_payment_dtl["merchant_param3"].ToString());

                string str_req = "";

                str_req += "merchant_id=" + dic_payment_dtl["merchant_id"] + "&";
                str_req += "order_id=" + dic_payment_dtl["order_id"] + "&";
                str_req += "amount=" + dic_payment_dtl["amount"] + "&";
                str_req += "currency=" + dic_payment_dtl["currency"] + "&";
                str_req += "redirect_url=" + dic_payment_dtl["redirect_url"] + "&";
                str_req += "cancel_url=" + dic_payment_dtl["cancel_url"] + "&";
                str_req += "language=" + dic_payment_dtl["language"] + "&";
                str_req += "merchant_param1=" + dic_payment_dtl["merchant_param1"] + "&";
                str_req += "merchant_param2=" + dic_payment_dtl["merchant_param2"] + "&";
                str_req += "merchant_param3=" + dic_payment_dtl["merchant_param3"];

                Log.PaymentTransactionLog("Payment Request For HDFC : " + str_req);

                CCACrypto ccaCrypto = new CCACrypto();

                string str_encr_req = ccaCrypto.Encrypt(str_req, working_key);

                return str_encr_req;
            }
            catch (Exception ex)
            {

            }

            return "";
        }

        public string SavePaymentDetails_HDFC(NameValueCollection Params, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            Log.PaymentTransactionLog("Payment Response From HDFC : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Params["order_status"];
            res["Response Message"] = Params["status_message"];
            res["Merchant Txn Id"] = Params["order_id"];

            Log.PaymentTransactionLog("Payment Response From HDFC : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
            String data = "";

            String pgRespCode = Params["order_status"]; //Success,Failure,Aborted,Invalid

            String TxMsg = Params["order_status"] == "Success" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Params["tracking_id"]; //HDFC Transaction Id for payment

            bool flag = true;

            for (int i = 0; i < Params.Count; i++)
            {
                data = Params.Keys[i] + " = " + Params[i] + " || ";
            }

            BLL.Utilities1.Log.PaymentTransactionLog("HDFC Response data :: " + data);

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Params["order_id"];

                if (pgRespCode == "Success")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    string result = PaymentSuccessSave_HDFC(transactionId, Params, ref paymentResponse, ref message);

                    Log.PaymentTransactionLog("Payment Response From HDFC : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result == "true")
                    {
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                    }
                    else if (result == "false")
                    {
                        paymentResponse.status = "paymentSuccessApplicationFail";
                        msg = "Your payment is done successfully but transaction details not saved. Please contact administratior with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }
                    else if (result == "payment_done")
                    {
                        paymentResponse.status = "paymentAlreadySuccess";
                        paymentResponse.data.message = "Already Payment is done for this Transaction ID.";
                        msg = "Already Payment is done for this Transaction ID.";
                    }
                    else if (result == "payment_error")
                    {
                        paymentResponse.status = "paymentFailedError";
                        paymentResponse.data.message = "Tansaction ID Not match with your User ID.";
                        msg = "Tansaction ID Not match with your User ID.";
                    }

                }
                else // "Failure" OR "Aborted" OR "Invalid"
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }
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

        internal string PaymentSuccessSave_HDFC(string transactionId, NameValueCollection Params, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            Log.PaymentTransactionLog("PaymentSuccessSave_HDFC method");

            //DataTable dtTranDetail = GetTransactionDetails(transactionId);

            DataTable dtTranDetail = GetTransactionDetailsByUserId(transactionId, HttpContext.Current.Session["UserId"].ToString());

            string user_id = "";
            if (dtTranDetail != null)
            {
                BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());

                Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

                if (dtTranDetail.Rows[0]["payment_response_code"].ToString() != "0")
                {

                    //Update the Transaction details
                    if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
                    {
                        try
                        {
                            Log.PaymentTransactionLog("In if condition");
                            DS_Payment obDS_Payment = new DS_Payment();

                            obDS_Payment.EnforceConstraints = false;
                            DataRow TranRow = dtTranDetail.Rows[0];
                            //string program_course_id = TranRow["program_course_id"].ToString();
                            user_id = TranRow["user_id"].ToString();
                            Log.PaymentTransactionLog("In if condition" + user_id);
                            paymentResponse.data.user_id = user_id;

                            string res_code = "";
                            if (Params["order_status"] == "Success") res_code = "0";
                            else if (Params["order_status"] == "Failure") res_code = "1";
                            else if (Params["order_status"] == "Aborted") res_code = "2";
                            else res_code = "3";

                            TranRow["payment_return_flag"] = Constant.YES;
                            TranRow["payment_response_code"] = res_code;
                            TranRow["payment_response_msg"] = res_code == "0" ? "Transaction Successful" : Params["order_status"] + " - " + Params["status_message"];
                            TranRow["payment_transaction_reference_id"] = Params["tracking_id"];
                            TranRow["payment_authorization_code"] = Params["bank_ref_no"];
                            TranRow["Citrus_PaymentMode"] = Params["payment_mode"];
                            TranRow["Citrus_TxRefNo"] = Params["bank_ref_no"];
                            TranRow["Citrus_TxGateway"] = "HDFC";
                            TranRow["Citrus_TxStatus"] = res_code == "0" ? "SUCCESS" : null;

                            TranRow["status_is_payment_received"] = Constant.YES;

                            TranRow["last_modified_date"] = DateTime.Now;
                            TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                            TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                            obDS_Payment.applicationpaymenttransaction.ImportRow(TranRow);
                            Log.PaymentTransactionLog("row imported");

                            DBConnection.Open();
                            Log.PaymentTransactionLog("connection open");

                            //Begin Transaction.
                            DBCommand.Transaction = DBConnection.BeginTransaction();
                            Log.PaymentTransactionLog("connection Begin");

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
                                return "false";
                            }
                            catch (Exception ex)
                            {
                                Log.PaymentTransactionLog("2" + ex.ToString());
                                DBCommand.Transaction.Rollback();
                                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                                message = ex.Message;
                                Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                                return "false";
                            }

                            //Update Transaction Master
                            BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                            if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.applicationpaymenttransaction.Rows.Count)
                            {
                                Log.PaymentTransactionLog("rollback");
                                DBCommand.Transaction.Rollback();
                                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                                message += " Fail to Update Transaction Details.";
                                return "false";
                            }

                            message += "Application Generated successfully with ID :  txnID : " + transactionId;
                            paymentResponse.data.application_id = "";
                            DBCommand.Transaction.Commit();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        }
                        catch (Exception ex)
                        {
                            Log.PaymentTransactionLog("HDFC :: " + ex.ToString());
                        }
                        return "true";
                    }
                    else
                    {
                        message = "Tansaction Not Found with ID : " + transactionId;
                        return "false";
                    }
                }
                else
                {
                    message = "Already Payment is done for this Transaction ID : " + transactionId;
                    return "payment_done";
                }
            }
            else
            {
                message = "Tansaction ID Not match with your User ID. Transaction ID : " + transactionId;
                return "payment_error";
            }
            //}
        }

        #endregion

        #region <-- Kotak Payment Gateway -->
        /// <summary>
        /// Mid Changes
        /// </summary>
        /// <param name="FacultyId"></param>
        /// <returns></returns>
        public string Get_Kotak_MerchantId(string FacultyId)
        {
            string MID = "156254";

            return MID;
        }

        public string Get_Kotak_Sub_Account_Id(string FacultyId)
        {
            string SubID = "";

            switch (FacultyId)
            {
                case "1": //Faculty of Architecture
                    SubID = "CEPTFAK";
                    break;
                case "2": //Faculty of Design
                    SubID = "CEPTFDK";
                    break;
                case "3": //Faculty of Management
                    SubID = "CEPTFMK";
                    break;
                case "4": //Faculty of Planning
                    SubID = "CEPTFPK";
                    break;
                case "5": //Faculty of Technology
                    SubID = "CEPTFTK";
                    break;

                default:
                    SubID = "";
                    break;
            }

            return SubID;
        }

        public string Get_Kotak_working_Key(string FacultyId)
        {
            //string working_Key = "F5FD52F6E65590CD103397D5D43C8758"; // For Testing Server http://27.109.12.252:81
            //string working_Key = "09F878FAD659E94E7484753CADA2A535"; // For Testing Server http://104.211.138.53/
            #if localpaymnet

            string working_Key = "09F878FAD659E94E7484753CADA2A535"; // For Testing Server http://104.211.138.53/
            #endif

            //1 changes 

            #if livepaymnet
            string working_Key = "60249ADD0A338AD803B3AD704BA93BEA";//Live Server
            #endif
            return working_Key;
        }

        public string Get_Kotak_access_code(string FacultyId)
        {
            //string access_code = "AVVK01EK31CL81KVLC"; // For Testing Server http://27.109.12.252:81

            #if localpaymnet
            string access_code = "AVTD03HL58BF43DTFB"; // For Testing Server http://104.211.138.53/
            #endif
            //2 changes 
            #if livepaymnet
            string access_code = "AVTZ74EK52CE68ZTEC";//Live Server
            #endif
            // string access_code = "AVTZ74EK52CE68ZTEC";


            return access_code;
        }

        public string Get_Kotak_request_url(string FacultyId)
        {
            //string Kotak_request_url = "https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction"; // For Testing Server http://27.109.12.252:81
#if localpaymnet

            string Kotak_request_url = "https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction"; // For Testing Server http://104.211.138.53/
#endif

            //3 changes 

#if livepaymnet
            string Kotak_request_url = "https://secure.ccavenue.com/transaction/transaction.do?command=initiateTransaction";//Live Server

#endif
            return Kotak_request_url;
        }

        public string Get_Kotak_return_url(string FacultyId)
        {
            string return_url = "PaymentResponseKotak.aspx";

            return return_url;
        }

        public string Get_Kotak_encrypted_request(ref Dictionary<string, object> dic_payment_dtl)
        {
            try
            {
                string working_key = Get_Kotak_working_Key(dic_payment_dtl["merchant_param3"].ToString());
                string sub_account_id = Get_Kotak_Sub_Account_Id(dic_payment_dtl["merchant_param3"].ToString());

                if (dic_payment_dtl.Keys.Contains("is_hostel") && dic_payment_dtl["is_hostel"] != null && dic_payment_dtl["is_hostel"].ToString() == "Y")
                {
                    sub_account_id = "CEPTHST";
                }

                if (dic_payment_dtl.Keys.Contains("is_smartcard") && dic_payment_dtl["is_smartcard"] != null && dic_payment_dtl["is_smartcard"].ToString() == "Y")
                {
                    sub_account_id = "CEPTCUK";
                }
                if (dic_payment_dtl.Keys.Contains("is_swscoursepayment") && dic_payment_dtl["is_swscoursepayment"] != null && dic_payment_dtl["is_swscoursepayment"].ToString() == "Y")
                {
                    #if livepaymnet
                                    sub_account_id = "CEPTCUK";
                    #endif
                    #if localpaymnet
                                        sub_account_id = "CEPTFAK";
                    #endif
                }

                string str_req = "";

                str_req += "merchant_id=" + dic_payment_dtl["merchant_id"] + "&";
                str_req += "sub_account_id=" + sub_account_id + "&";
                str_req += "order_id=" + dic_payment_dtl["order_id"] + "&";
                str_req += "amount=" + dic_payment_dtl["amount"] + "&";
                str_req += "currency=" + dic_payment_dtl["currency"] + "&";
                str_req += "redirect_url=" + dic_payment_dtl["redirect_url"] + "&";
                str_req += "cancel_url=" + dic_payment_dtl["cancel_url"] + "&";
                //str_req += "ignore_payment_option=OPTNBK&";
                if (dic_payment_dtl.Keys.Contains("is_swscoursepayment") && dic_payment_dtl["is_swscoursepayment"] != null && dic_payment_dtl["is_swscoursepayment"].ToString() == "Y")
                {
                  str_req += "ignore_payment_option=OPTNEFT&";
                }
                str_req += "language=" + dic_payment_dtl["language"] + "&";
                str_req += "merchant_param1=" + dic_payment_dtl["merchant_param1"] + "&";
                str_req += "merchant_param2=" + dic_payment_dtl["merchant_param2"] + "&";
                str_req += "merchant_param3=" + dic_payment_dtl["merchant_param3"] + "&";
                str_req += "merchant_param4=" + dic_payment_dtl["merchant_param4"];

                Log.PaymentTransactionLog("Payment Request Kotak : " + str_req);

                CCACrypto ccaCrypto = new CCACrypto();

                string str_encr_req = ccaCrypto.Encrypt(str_req, working_key);

                return str_encr_req;
            }
            catch (Exception ex)
            {

            }

            return "";
        }

        public string Get_Kotak_encrypted_request_to_check_order_status(string transaction_id)
        {
            try
            {
                string working_key = Get_Kotak_working_Key("");
                
                string str_req = "";

                str_req += "{'reference_no': '','order_no': '" + transaction_id + "'}";//309006674815
                //str_req += "{'reference_no': '110216358501','order_no': 'FCCFARPAD201651P2122095809'}";//309006674815

                //str_req += "{\"reference_no\":\"\",\"order_no\":\""+ transaction_id +"\"}";

                Log.PaymentTransactionLog("Payment Request Kotak API : " + str_req);

                CCACrypto ccaCrypto = new CCACrypto();

                string str_encr_req = ccaCrypto.Encrypt(str_req, working_key);
               

                return str_encr_req;
            }
            catch (Exception ex)
            {
                return "";
            }

            return "";
        }

        public string DecryptResponse(string enc_response)
        {
            try
            {
                CCACrypto ccaCrypto = new CCACrypto();

                string working_key = Get_Kotak_working_Key("");

                string decResponse = ccaCrypto.Decrypt(enc_response, working_key);

                Log.PaymentTransactionLog("Payment Response Kotak : " + decResponse);

                return decResponse;
            }
            catch (Exception ex)
            {
                Log.PaymentTransactionLog("ZZZ. Error Payment Response From Kotak API. " + ex.ToString());
                return "";
            }

            return "";
        }

        public string SavePaymentDetails_Kotak(NameValueCollection Params, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            //Log.PaymentTransactionLog("Payment Response From Kotak : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Params["order_status"];
            res["Response Message"] = Params["status_message"];
            res["Merchant Txn Id"] = Params["order_id"];

            //Log.PaymentTransactionLog("Payment Response From Kotak : Response Data : " + JsonConvert.SerializeObject(res));

            String data = "";

            String pgRespCode = Params["order_status"]; //Success,Failure,Aborted,Invalid

            String TxMsg = Params["order_status"] == "Success" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Params["tracking_id"]; //Kotak Transaction Id for payment

            bool flag = true;

            for (int i = 0; i < Params.Count; i++)
            {
                data = Params.Keys[i] + " = " + Params[i] + " || ";
            }

            //BLL.Utilities1.Log.PaymentTransactionLog("Kotak Response data :: " + data);

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Params["order_id"];

                if (pgRespCode == "Success")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    string result = PaymentSuccessSave_Kotak(transactionId, Params, ref paymentResponse, ref message);

                    //Log.PaymentTransactionLog("Payment Response From Kotak : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result == "true")
                    {
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                    }
                    else if (result == "false")
                    {
                        paymentResponse.status = "paymentSuccessApplicationFail";
                        msg = "Your payment is done successfully but transaction details not saved. Please contact administratior with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }
                    else if (result == "payment_done")
                    {
                        paymentResponse.status = "paymentAlreadySuccess";
                        paymentResponse.data.message = "Already Payment is done for this Transaction ID.";
                        msg = "Already Payment is done for this Transaction ID.";
                    }
                    else if (result == "payment_error")
                    {
                        paymentResponse.status = "paymentFailedError";
                        paymentResponse.data.message = "Tansaction ID Not match with your User ID.";
                        msg = "Tansaction ID Not match with your User ID.";
                    }
                }
                else // "Failure" OR "Aborted" OR "Invalid"
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }
            }
            else
            {
                paymentResponse.status = "paymentFail";
                paymentResponse.data.message = "Response signature is not matched with request.";
                msg = "Sorry!! Your payment is not done successfully. Error : Response signature is not matched with request.";
            }

            //Log.PaymentTransactionLog("Message : " + msg);
            return msg;
        }

        internal string PaymentSuccessSave_Kotak(string transactionId, NameValueCollection Params, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Log.PaymentTransactionLog("PaymentSuccessSave_Kotak method");

            //DataTable dtTranDetail = GetTransactionDetails(transactionId);

            DataTable dtTranDetail = GetTransactionDetailsByUserId(transactionId, Params["merchant_param1"].ToString());//HttpContext.Current.Session["UserId"].ToString()

            string user_id = "";
            if (dtTranDetail != null)
            {
                //BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
                //Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

                if (dtTranDetail.Rows[0]["payment_response_code"].ToString() != "0")
                {
                    //Update the Transaction details
                    if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
                    {
                        try
                        {
                            //Log.PaymentTransactionLog("In if condition");
                            DS_Payment obDS_Payment = new DS_Payment();

                            obDS_Payment.EnforceConstraints = false;
                            DataRow TranRow = dtTranDetail.Rows[0];
                            //string program_course_id = TranRow["program_course_id"].ToString();
                            user_id = TranRow["user_id"].ToString();
                            //Log.PaymentTransactionLog("In if condition" + user_id);
                            paymentResponse.data.user_id = user_id;

                            string res_code = "";
                            if (Params["order_status"] == "Success") res_code = "0";
                            else if (Params["order_status"] == "Failure") res_code = "1";
                            else if (Params["order_status"] == "Aborted") res_code = "2";
                            else res_code = "3";

                            TranRow["payment_return_flag"] = Constant.YES;
                            TranRow["payment_response_code"] = res_code;
                            TranRow["payment_response_msg"] = res_code == "0" ? "Transaction Successful" : Params["order_status"] + " - " + Params["status_message"];
                            TranRow["payment_transaction_reference_id"] = Params["tracking_id"];
                            TranRow["payment_authorization_code"] = Params["bank_ref_no"];
                            TranRow["Citrus_PaymentMode"] = Params["payment_mode"];
                            TranRow["Citrus_TxRefNo"] = Params["bank_ref_no"];
                            TranRow["Citrus_TxGateway"] = "Kotak";
                            TranRow["Citrus_TxStatus"] = res_code == "0" ? "SUCCESS" : null;

                            TranRow["status_is_payment_received"] = Constant.YES;

                            TranRow["last_modified_date"] = DateTime.Now;
                            TranRow["last_modified_by"] = user_id;// HttpContext.Current.Session["UserId"].ToString();
                            TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                            obDS_Payment.applicationpaymenttransaction.ImportRow(TranRow);
                            //Log.PaymentTransactionLog("row imported");

                            DBConnection.Open();
                            //Log.PaymentTransactionLog("connection open");

                            //Begin Transaction.
                            DBCommand.Transaction = DBConnection.BeginTransaction();
                            //Log.PaymentTransactionLog("connection Begin");

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
                                return "false";
                            }
                            catch (Exception ex)
                            {
                                Log.PaymentTransactionLog("2" + ex.ToString());
                                DBCommand.Transaction.Rollback();
                                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                                message = ex.Message;
                                Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                                return "false";
                            }

                            //Update Transaction Master
                            BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                            if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.applicationpaymenttransaction.Rows.Count)
                            {
                                Log.PaymentTransactionLog("rollback");
                                DBCommand.Transaction.Rollback();
                                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                                message += " Fail to Update Transaction Details.";
                                return "false";
                            }

                            message += "Application Generated successfully with ID :  txnID : " + transactionId;
                            paymentResponse.data.application_id = "";
                            DBCommand.Transaction.Commit();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            
                            //Start 12 03 2020 Mahroofbhai Call
                            bool accepted_fine = objMaster.success_fine_paid_online(dtTranDetail.Rows[0]["cash_collected_by"].ToString(), dtTranDetail.Rows[0]["user_id"].ToString(), dtTranDetail.Rows[0]["semester_type"].ToString(), dtTranDetail.Rows[0]["year_semester"].ToString());
                            //End 12 03 2020 Mahroofbhai Call
                        }
                        catch (Exception ex)
                        {
                            Log.PaymentTransactionLog("Kotak :: " + ex.ToString());
                        }
                        return "true";
                    }
                    else
                    {
                        message = "Tansaction Not Found with ID : " + transactionId;
                        return "false";
                    }
                }
                else
                {
                    message = "Already Payment is done for this Transaction ID : " + transactionId;
                    return "payment_done";
                }
            }
            else
            {
                message = "Tansaction ID Not match with your User ID. Transaction ID : " + transactionId;
                return "payment_error";
            }
            //}
        }

#endregion

        //Added by mayur 18/12/2020
        #region <-- Kotak Payment Gateway For API -->

        public string SavePaymentDetails_Kotak_API(Dictionary<string, object> Params, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            //Log.PaymentTransactionLog("Payment Response From Kotak : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Params["order_status"];
            res["Response Message"] = Params["order_status"];
            res["Merchant Txn Id"] = Params["order_no"];//order_id

            Log.PaymentTransactionLog("Payment Response From Kotak: Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
            String data = "";

            String pgRespCode = Params["order_status"].ToString(); //Success,Failure,Aborted,Invalid

            String TxMsg = Params["order_status"].ToString() == "Success" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Params["reference_no"].ToString(); //Kotak Transaction Id for payment//tracking_id

            bool flag = true;

            //for (int i = 0; i < Params.Count; i++)
            //{
            //    data = Params.Keys[i] + " = " + Params[i] + " || ";
            //}

            //BLL.Utilities1.Log.PaymentTransactionLog("Kotak Response data :: " + data);

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Params["order_no"].ToString();//order_id

                if (pgRespCode == "Success")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    string result = PaymentSuccessSave_Kotak_API(transactionId, Params, ref paymentResponse, ref message);
                    Log.PaymentTransactionLog("Result Status" + result);
                    Log.PaymentTransactionLog("Payment Response From Kotak : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result == "true")
                    {
                        Log.PaymentTransactionLog("1 paymentSuccess");
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                    }
                    else if (result == "false")
                    {
                        Log.PaymentTransactionLog("2 paymentSuccessApplicationFail");

                        paymentResponse.status = "paymentSuccessApplicationFail";
                        msg = "Your payment is done successfully but transaction details not saved. Please contact administratior with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }
                    else if (result == "payment_done")
                    {
                        Log.PaymentTransactionLog("3 paymentAlreadySuccess");
                        paymentResponse.status = "paymentAlreadySuccess";
                        paymentResponse.data.message = "Already Payment is done for this Transaction ID.";
                        msg = "Already Payment is done for this Transaction ID.";
                    }
                    else if (result == "payment_error")
                    {
                        Log.PaymentTransactionLog("4 paymentFailedError");
                        paymentResponse.status = "paymentFailedError";
                        paymentResponse.data.message = "Tansaction ID Not match with your User ID.";
                        msg = "Tansaction ID Not match with your User ID.";
                    }
                }
                else // "Failure" OR "Aborted" OR "Invalid"
                {
                    Log.PaymentTransactionLog("5 paymentFail");
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }
            }
            else
            {
                Log.PaymentTransactionLog("Else Condition paymentFail");
                paymentResponse.status = "paymentFail";
                paymentResponse.data.message = "Response signature is not matched with request.";
                msg = "Sorry!! Your payment is not done successfully. Error : Response signature is not matched with request.";
            }

            Log.PaymentTransactionLog("Message : " + msg);
            return msg;
        }

        internal string PaymentSuccessSave_Kotak_API(string transactionId, Dictionary<string, object> Params, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Log.PaymentTransactionLog("PaymentSuccessSave_Kotak_API method");

            //DataTable dtTranDetail = GetTransactionDetails(transactionId);

            DataTable dtTranDetail = GetTransactionDetailsByUserId(transactionId, Params["merchant_param1"].ToString());//HttpContext.Current.Session["UserId"].ToString()

            string user_id = "";
            if (dtTranDetail != null)
            {
                //BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
                //Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

                if (dtTranDetail.Rows[0]["payment_response_code"].ToString() != "0")
                {
                    //Update the Transaction details
                    if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
                    {
                        try
                        {
                            //Log.PaymentTransactionLog("In if condition");
                            DS_Payment obDS_Payment = new DS_Payment();

                            obDS_Payment.EnforceConstraints = false;
                            DataRow TranRow = dtTranDetail.Rows[0];
                            //string program_course_id = TranRow["program_course_id"].ToString();
                            user_id = TranRow["user_id"].ToString();
                            //Log.PaymentTransactionLog("In if condition" + user_id);
                            paymentResponse.data.user_id = user_id;

                            string res_code = "";
                            if (Params["order_status"].ToString() == "Success") res_code = "0";
                            else if (Params["order_status"].ToString() == "Failure") res_code = "1";
                            else if (Params["order_status"].ToString() == "Aborted") res_code = "2";
                            else if (Params["order_status"].ToString() == "Unsuccessful") res_code = "4";
                            else res_code = "3";

                            TranRow["payment_return_flag"] = Constant.YES;
                            TranRow["payment_response_code"] = res_code;
                            TranRow["payment_response_msg"] = res_code == "0" ? "Transaction Successful" : Params["order_status"] + " - " + Params["status_message"];
                            TranRow["payment_transaction_reference_id"] = Params["reference_no"];//tracking_id
                            TranRow["payment_authorization_code"] = Params["order_bank_ref_no"];//bank_ref_no
                            TranRow["Citrus_PaymentMode"] = Params["order_card_name"];//payment_mode
                            TranRow["Citrus_TxRefNo"] = Params["order_bank_ref_no"];//bank_ref_no
                            TranRow["Citrus_TxGateway"] = "Kotak API";
                            TranRow["Citrus_TxStatus"] = res_code == "0" ? "SUCCESS" : null;

                            TranRow["status_is_payment_received"] = Constant.YES;

                            TranRow["last_modified_date"] = DateTime.Now;
                            TranRow["last_modified_by"] = user_id;// HttpContext.Current.Session["UserId"].ToString();
                            TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                            obDS_Payment.applicationpaymenttransaction.ImportRow(TranRow);
                            //Log.PaymentTransactionLog("row imported");

                            DBConnection.Open();
                            //Log.PaymentTransactionLog("connection open");

                            //Begin Transaction.
                            DBCommand.Transaction = DBConnection.BeginTransaction();
                            //Log.PaymentTransactionLog("connection Begin");

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
                                return "false";
                            }
                            catch (Exception ex)
                            {
                                Log.PaymentTransactionLog("2" + ex.ToString());
                                DBCommand.Transaction.Rollback();
                                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                                message = ex.Message;
                                Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                                return "false";
                            }

                            //Update Transaction Master
                            BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                            if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.applicationpaymenttransaction.Rows.Count)
                            {
                                Log.PaymentTransactionLog("rollback");
                                DBCommand.Transaction.Rollback();
                                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                                message += " Fail to Update Transaction Details.";
                                return "false";
                            }

                            message += "Application Generated successfully with ID :  txnID : " + transactionId;
                            paymentResponse.data.application_id = "";
                            DBCommand.Transaction.Commit();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            
                            //Start 12 03 2020 Mahroofbhai Call
                            bool accepted_fine = objMaster.success_fine_paid_online(dtTranDetail.Rows[0]["cash_collected_by"].ToString(), dtTranDetail.Rows[0]["user_id"].ToString(), dtTranDetail.Rows[0]["semester_type"].ToString(), dtTranDetail.Rows[0]["year_semester"].ToString());
                            //End 12 03 2020 Mahroofbhai Call
                        }
                        catch (Exception ex)
                        {
                            Log.PaymentTransactionLog("Kotak :: " + ex.ToString());
                        }
                        return "true";
                    }
                    else
                    {
                        message = "Tansaction Not Found with ID : " + transactionId;
                        return "false";
                    }
                }
                else
                {
                    message = "Already Payment is done for this Transaction ID : " + transactionId;
                    return "payment_done";
                }
            }
            else
            {
                message = "Tansaction ID Not match with your User ID. Transaction ID : " + transactionId;
                return "payment_error";
            }
            //}
        }

#endregion

        //Added by mayur 15062019
        #region <-- Kotak Payment Gateway For NEFT/RTGS -->

        public string Get_Kotak_MerchantId_neft_rtgs()
        {
            string MID = "156254";

            return MID;
        }

        public string Get_Kotak_access_code_neft_rtgs()
        {
            string access_code = "AVVK01EK31CL81KVLC"; // For Testing Server http://27.109.12.252:81
            //string access_code = "AVTZ74EK52CE68ZTEC";

            return access_code;
        }

        public string Get_Kotak_request_url_neft_rtgs()
        {
            string Kotak_request_url = "https://logintest.ccavenue.com/apis/servlet/DoWebTrans"; // For Testing Server http://27.109.12.252:81

            return Kotak_request_url;
        }

        public string Get_Kotak_working_Key_neft_rtgs()
        {

            string working_Key = "F5FD52F6E65590CD103397D5D43C8758"; // For Testing Server http://27.109.12.252:81
            //string working_Key = "60249ADD0A338AD803B3AD704BA93BEA";

            return working_Key;
        }

        public string Get_Kotak_encrypted_request_neft_rtgs(string reference_no, string order_no)
        {
            try
            {
                string working_key = Get_Kotak_working_Key_neft_rtgs();//Need to Assign access code as given in pdf

                string str_req = "{ 'order_List': [ { 'reference_no':'" + reference_no + "', 'order_no': '" + order_no + "'}]}";

                CCACrypto ccaCrypto = new CCACrypto();

                string str_encr_req = ccaCrypto.Encrypt(str_req, working_key);

                return str_encr_req;
            }
            catch (Exception ex)
            {

            }

            return "";
        }

        public string Get_Kotak_return_url_neft_rtgs()
        {
            string return_url = "PaymentResponseKotakNR.aspx";

            return return_url;
        }

        public string SavePaymentDetails_Kotak_Neft_Rtgs(NameValueCollection Params, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            //Log.PaymentTransactionLog("Payment Response From Kotak : SavePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Params["order_status"];
            res["Response Message"] = Params["status_message"];
            res["Merchant Txn Id"] = Params["order_id"];

            //Log.PaymentTransactionLog("Payment Response From Kotak : Response Data : " + JsonConvert.SerializeObject(res));

            String data = "";

            String pgRespCode = Params["order_status"]; //Success,Failure,Aborted,Invalid

            String TxMsg = Params["order_status"] == "Success" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Params["tracking_id"]; //Kotak Transaction Id for payment

            bool flag = true;

            for (int i = 0; i < Params.Count; i++)
            {
                data = Params.Keys[i] + " = " + Params[i] + " || ";
            }

            //BLL.Utilities1.Log.PaymentTransactionLog("Kotak Response data :: " + data);

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Params["order_id"];

                if (pgRespCode == "Success")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    bool result = PaymentSuccessSave_Kotak_Neft_Rtgs(transactionId, Params, ref paymentResponse, ref message);

                    //Log.PaymentTransactionLog("Payment Response From Kotak : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result)
                    {
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                    }
                    else
                    {
                        paymentResponse.status = "paymentSuccessApplicationFail";
                        msg = "Your payment is done successfully but transaction details not saved. Please contact administrator with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }
                }
                else // "Failure" OR "Aborted" OR "Invalid"
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }
            }
            else
            {
                paymentResponse.status = "paymentFail";
                paymentResponse.data.message = "Response signature is not matched with request.";
                msg = "Sorry!! Your payment is not done successfully. Error : Response signature is not matched with request.";
            }

            //Log.PaymentTransactionLog("Message : " + msg);
            return msg;
        }

        internal bool PaymentSuccessSave_Kotak_Neft_Rtgs(string transactionId, NameValueCollection Params, ref PaymentRes paymentResponse, ref string message)
        {
            Masters objGetMasterDetails = new Masters();

            //Log.PaymentTransactionLog("PaymentSuccessSave_Kotak method");
            DataTable dtTranDetail = GetTransactionDetails(transactionId);
            string user_id = "";
            //BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            //Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the Transaction details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    //Log.PaymentTransactionLog("In if condition");
                    DS_Payment obDS_Payment = new DS_Payment();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];
                    //string program_course_id = TranRow["program_course_id"].ToString();
                    user_id = TranRow["user_id"].ToString();
                    //Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;

                    string res_code = "";
                    if (Params["order_status"] == "Success") res_code = "0";
                    else if (Params["order_status"] == "Failure") res_code = "1";
                    else if (Params["order_status"] == "Aborted") res_code = "2";
                    else res_code = "3";

                    TranRow["payment_return_flag"] = Constant.YES;
                    TranRow["payment_response_code"] = res_code;
                    TranRow["payment_response_msg"] = res_code == "0" ? "Transaction Successful" : Params["order_status"] + " - " + Params["status_message"];
                    TranRow["payment_transaction_reference_id"] = Params["tracking_id"];
                    TranRow["payment_authorization_code"] = Params["bank_ref_no"];
                    TranRow["Citrus_PaymentMode"] = Params["payment_mode"];
                    TranRow["Citrus_TxRefNo"] = Params["bank_ref_no"];
                    TranRow["Citrus_TxGateway"] = "Kotak";
                    TranRow["Citrus_TxStatus"] = res_code == "0" ? "SUCCESS" : null;

                    TranRow["status_is_payment_received"] = Constant.YES;

                    TranRow["last_modified_date"] = DateTime.Now;
                    TranRow["last_modified_by"] = "Kotak Neft Rtgs";
                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                    obDS_Payment.applicationpaymenttransaction.ImportRow(TranRow);
                    //Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    //Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    //Log.PaymentTransactionLog("connection Begin");

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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.applicationpaymenttransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Transaction Details.";
                        return false;
                    }

                    message += "Application Generated successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();

                    //Start 12 03 2020 Mahroofbhai Call
                    bool accepted_fine = objMaster.success_fine_paid_online(dtTranDetail.Rows[0]["cash_collected_by"].ToString(), dtTranDetail.Rows[0]["user_id"].ToString(), dtTranDetail.Rows[0]["semester_type"].ToString(), dtTranDetail.Rows[0]["year_semester"].ToString());
                    //End 12 03 2020 Mahroofbhai Call
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("Kotak :: " + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
            //}
        }

        public DataTable getTransactionDetailsforNEFTRTGS(string transaction_id) {//04 07 2020 Mayur

            //Log.PaymentTransactionLog("GetTransactionDetails method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";


                //BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = @"select * from applicationpaymenttransaction apt "
                            + " inner join user_mst um on um.user_id = apt.user_id and um.cancel_flag = 'N' and um.user_status_flag = 'A' and status = 'A' "
                            + " where apt.transaction_id = '" + transaction_id + "'";

                //BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);

                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                //BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);
                DataSet ds = new DataSet();
                try
                {
                    DBDataAdpterObject.Fill(ds);
                    if (ds.Tables[0].Rows.Count <= 0)
                    {
                        //BLL.Utilities1.Log.PaymentTransactionLog("row not found");
                        return null;
                    }
                    else
                    {

                        //BLL.Utilities1.Log.PaymentTransactionLog("successful" + ds.Tables[0].Rows[0]["transaction_id"].ToString());
                        dt = ds.Tables[0];
                        //BLL.Utilities1.Log.PaymentTransactionLog("successful1" + dt.Rows[0]["transaction_id"].ToString());
                        return dt;

                    }

                }
                catch (Exception ex)
                {
                    //BLL.Utilities1.Log.PaymentTransactionLog("Error" + ex.ToString());
                    return null;
                }
            }
            catch (Exception ex)
            {
                //BLL.Utilities1.Log.PaymentTransactionLog("Error1" + ex.ToString());
                return null;
            }
        }

#endregion
        //Added by mayur 15062019

        #region Hostel Fees Payment

        public DataTable GetHostelTransactionDetails(string transaction_id)
        {
            Log.PaymentTransactionLog("GetHostelTransactionDetails Method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from hostelFeesPaymentTransaction where transaction_id='" + transaction_id + "'";
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

        public string SaveHostelPaymentDetails_Kotak(NameValueCollection Params, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            Log.PaymentTransactionLog("Hostel Payment Response From Kotak : SaveHostelPaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Params["order_status"];
            res["Response Message"] = Params["status_message"];
            res["Merchant Txn Id"] = Params["order_id"];

            Log.PaymentTransactionLog("Hostel Payment Response From Kotak : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
            String data = "";

            String pgRespCode = Params["order_status"]; //Success,Failure,Aborted,Invalid

            String TxMsg = Params["order_status"] == "Success" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Params["tracking_id"]; //Kotak Transaction Id for payment

            bool flag = true;

            for (int i = 0; i < Params.Count; i++)
            {
                data = Params.Keys[i] + " = " + Params[i] + " || ";
            }

            BLL.Utilities1.Log.PaymentTransactionLog("Kotak Response data :: " + data);

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Params["order_id"];

                if (pgRespCode == "Success")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    bool result = HostelPaymentSuccessSave_Kotak(transactionId, Params, ref paymentResponse, ref message);

                    Log.PaymentTransactionLog("Payment Response From Kotak : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result)
                    {
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                    }
                    else
                    {
                        paymentResponse.status = "paymentSuccessApplicationFail";
                        msg = "Your payment is done successfully but transaction details not saved. Please contact administrator with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }
                }
                else // "Failure" OR "Aborted" OR "Invalid"
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }
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

        internal bool HostelPaymentSuccessSave_Kotak(string transactionId, NameValueCollection Params, ref PaymentRes paymentResponse, ref string message)
        {
            Log.PaymentTransactionLog("HostelPaymentSuccessSave_Kotak method");
            DataTable dtTranDetail = GetHostelTransactionDetails(transactionId);
            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the Transaction details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DSC_HostelFeesPayment obDS_Payment = new DSC_HostelFeesPayment();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];
                    //string program_course_id = TranRow["program_course_id"].ToString();
                    user_id = TranRow["user_id"].ToString();
                    Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;

                    string res_code = "";
                    if (Params["order_status"] == "Success") res_code = "0";
                    else if (Params["order_status"] == "Failure") res_code = "1";
                    else if (Params["order_status"] == "Aborted") res_code = "2";
                    else res_code = "3";

                    TranRow["payment_return_flag"] = Constant.YES;
                    TranRow["payment_response_code"] = res_code;
                    TranRow["payment_response_msg"] = res_code == "0" ? "Transaction Successful" : Params["order_status"] + " - " + Params["status_message"];
                    TranRow["payment_transaction_reference_id"] = Params["tracking_id"];
                    TranRow["payment_authorization_code"] = Params["bank_ref_no"];
                    TranRow["Citrus_PaymentMode"] = Params["payment_mode"];
                    TranRow["Citrus_TxRefNo"] = Params["bank_ref_no"];
                    TranRow["Citrus_TxGateway"] = "Kotak";
                    TranRow["Citrus_TxStatus"] = res_code == "0" ? "SUCCESS" : null;

                    TranRow["status_is_payment_received"] = Constant.YES;

                    TranRow["last_modified_date"] = DateTime.Now;
                    //TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                    TranRow["last_modified_by"] = user_id;
                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                    obDS_Payment.hostelFeesPaymentTransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");

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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.hostelFeesPaymentTransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.hostelFeesPaymentTransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update Hostel Transaction Details.";
                        return false;
                    }

                    message += "Hostel fees paid successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("Kotak Hostel :: " + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
            //}
        }

#endregion

        #region SmartCard Payment

        public DataTable GetSmartcardTransactionDetails(string transaction_id)
        {
            Log.PaymentTransactionLog("GetSmartcardTransactionDetails Method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from smartcardPaymentTransaction where transaction_id='" + transaction_id + "'";
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

        public string SavesmartcardPaymentDetails_Kotak(NameValueCollection Params, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            Log.PaymentTransactionLog("SmartCard Payment Response From Kotak : SaveSmartcardPaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Params["order_status"];
            res["Response Message"] = Params["status_message"];
            res["Merchant Txn Id"] = Params["order_id"];

            Log.PaymentTransactionLog("SmartCard Payment Response From Kotak : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
            String data = "";

            String pgRespCode = Params["order_status"]; //Success,Failure,Aborted,Invalid

            String TxMsg = Params["order_status"] == "Success" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Params["tracking_id"]; //Kotak Transaction Id for payment

            bool flag = true;

            for (int i = 0; i < Params.Count; i++)
            {
                data = Params.Keys[i] + " = " + Params[i] + " || ";
            }

            BLL.Utilities1.Log.PaymentTransactionLog("Kotak Response data :: " + data);

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Params["order_id"];

                if (pgRespCode == "Success")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    bool result = SmartCardPaymentSuccessSave_Kotak(transactionId, Params, ref paymentResponse, ref message);

                    Log.PaymentTransactionLog("Payment Response From Kotak : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result)
                    {
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                    }
                    else
                    {
                        paymentResponse.status = "paymentSuccessApplicationFail";
                        msg = "Your payment is done successfully but transaction details not saved. Please contact administrator with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }
                }
                else // "Failure" OR "Aborted" OR "Invalid"
                {
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }
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

        internal bool SmartCardPaymentSuccessSave_Kotak(string transactionId, NameValueCollection Params, ref PaymentRes paymentResponse, ref string message)
        {
            Log.PaymentTransactionLog("SmartCardPaymentSuccessSave_Kotak method");
            DataTable dtTranDetail = GetSmartcardTransactionDetails(transactionId);
            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the Transaction details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    DSC_HostelFeesPayment obDS_Payment = new DSC_HostelFeesPayment();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];
                    //string program_course_id = TranRow["program_course_id"].ToString();
                    user_id = TranRow["user_id"].ToString();
                    Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;

                    string res_code = "";
                    if (Params["order_status"] == "Success") res_code = "0";
                    else if (Params["order_status"] == "Failure") res_code = "1";
                    else if (Params["order_status"] == "Aborted") res_code = "2";
                    else res_code = "3";

                    TranRow["payment_return_flag"] = Constant.YES;
                    TranRow["payment_response_code"] = res_code;
                    TranRow["payment_response_msg"] = res_code == "0" ? "Transaction Successful" : Params["order_status"] + " - " + Params["status_message"];
                    TranRow["payment_transaction_reference_id"] = Params["tracking_id"];
                    TranRow["payment_authorization_code"] = Params["bank_ref_no"];
                    TranRow["Citrus_PaymentMode"] = Params["payment_mode"];
                    TranRow["Citrus_TxRefNo"] = Params["bank_ref_no"];
                    TranRow["Citrus_TxGateway"] = "Kotak";
                    TranRow["Citrus_TxStatus"] = res_code == "0" ? "SUCCESS" : null;

                    TranRow["status_is_payment_received"] = Constant.YES;

                    TranRow["last_modified_date"] = DateTime.Now;
                    //TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                    TranRow["last_modified_by"] = user_id;
                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                    obDS_Payment.smartcardPaymentTransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");

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
                    BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obDS_Payment.smartcardPaymentTransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                    if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != obDS_Payment.smartcardPaymentTransaction.Rows.Count)
                    {
                        Log.PaymentTransactionLog("rollback");
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        message += " Fail to Update SmartCard Transaction Details.";
                        return false;
                    }

                    message += "SmartCard fees paid successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("Kotak SmartCard :: " + ex.ToString());
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
            //}
        }

#endregion

        #region SWS Course Payment

        public DataTable GetSWSCourseTransactionDetails(string transaction_id)
        {
            Log.PaymentTransactionLog("GetSWSCourseTransactionDetails Method");
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from ws_applicationpaymenttransaction where transaction_id='" + transaction_id + "'";
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

        public string SaveSWSCoursePaymentDetails_Kotak(NameValueCollection Params, ref PaymentRes paymentResponse, string faculty)
        {
            string msg = "";
            Log.PaymentTransactionLog("SWS Course Payment Response From Kotak : SaveSWSCoursePaymentDetailsCall ");

            Dictionary<string, object> res = new Dictionary<string, object>();
            res["Response code"] = Params["order_status"];
            res["Response Message"] = Params["status_message"];
            res["Merchant Txn Id"] = Params["order_id"];

            Log.PaymentTransactionLog("SWSCourse Payment Response From Kotak : Response Data : " + JsonConvert.SerializeObject(res));
            //Newtonsoft.Json.
            String data = "";

            String pgRespCode = Params["order_status"]; //Success,Failure,Aborted,Invalid
            Log.PaymentTransactionLog("pgRespCode" + pgRespCode);
            String TxMsg = Params["order_status"] == "Success" ? "Success" : "Failure"; //Success or failure message
            String TxRefNo = Params["tracking_id"]; //Kotak Transaction Id for payment

            bool flag = true;

            for (int i = 0; i < Params.Count; i++)
            {
                data = Params.Keys[i] + " = " + Params[i] + " || ";
            }

            BLL.Utilities1.Log.PaymentTransactionLog("Kotak Response data :: " + data);

            if (flag)
            {
                string message = string.Empty;
                string transactionId = Params["order_id"];
                DataTable dtTranDetail = GetSWSCourseTransactionDetails(transactionId);
                if (pgRespCode == "Success")
                {
                    paymentResponse.data.transaction_id = transactionId;
                    paymentResponse.data.pg_transaction_id = TxRefNo;

                    //Save Transaction Details
                    bool result = SWSCoursePaymentSuccessSave_Kotak(transactionId, Params, ref paymentResponse, ref message);

                    Log.PaymentTransactionLog("Payment Response From Kotak : PaymentSuccessSave Method Response : " + result + ", Message : " + message);

                    if (result)
                    {
                        bool status = objMaster.sws_course_allocation_dtl(dtTranDetail.Rows[0]["user_id"].ToString(), transactionId);
                        Log.PaymentTransactionLog("paymentSuccess");
                        paymentResponse.status = "paymentSuccess";
                        msg = "Payment Done Successfully. Your Payment Transaction Id : " + transactionId + ". Please note it for future reference.";
                    }
                    else
                    {
                        Log.PaymentTransactionLog("PaymentSuccessApplicationFail");
                        bool status = objMaster.sws_course_allocation_dtl(dtTranDetail.Rows[0]["user_id"].ToString(), transactionId);
                        paymentResponse.status = "paymentSuccessApplicationFail";
                        msg = "Your payment is done successfully but transaction details not saved. Please contact administrator with  Payment Transaction Id. Your Payment Transaction Id : " + transactionId + ".";
                    }
                    
                  
                }
                else // "Failure" OR "Aborted" OR "Invalid"
                {
                    Log.PaymentTransactionLog("paymentFail");
                    paymentResponse.status = "paymentFail";
                    paymentResponse.data.message = TxMsg;
                    msg = "Sorry!! Your payment is not done successfully. Error : " + TxMsg;
                }
            }
            else
            {
                Log.PaymentTransactionLog("2 .paymentFail");
                paymentResponse.status = "paymentFail";
                paymentResponse.data.message = "Response signature is not matched with request.";
                msg = "Sorry!! Your payment is not done successfully. Error : Response signature is not matched with request.";
            }

            Log.PaymentTransactionLog("Message : " + msg);
            return msg;
        }

        internal bool SWSCoursePaymentSuccessSave_Kotak(string transactionId, NameValueCollection Params, ref PaymentRes paymentResponse, ref string message)
        {
            Log.PaymentTransactionLog("SWSCoursePaymentSuccessSave_Kotak method");
            DataTable dtTranDetail = GetSWSCourseTransactionDetails(transactionId);
            string user_id = "";
            BLL.Utilities1.Log.PaymentTransactionLog(dtTranDetail.Rows[0]["transaction_id"].ToString());
            Log.PaymentTransactionLog(dtTranDetail.Rows.Count.ToString());

            //Update the Transaction details
            if (dtTranDetail != null && dtTranDetail.Rows.Count > 0)
            {
                try
                {
                    Log.PaymentTransactionLog("In if condition");
                    XSD.Masters_WS.DS_Payment_WS obDS_Payment = new XSD.Masters_WS.DS_Payment_WS();

                    obDS_Payment.EnforceConstraints = false;
                    DataRow TranRow = dtTranDetail.Rows[0];
                    //string program_course_id = TranRow["program_course_id"].ToString();
                    user_id = TranRow["user_id"].ToString();
                    Log.PaymentTransactionLog("In if condition" + user_id);
                    paymentResponse.data.user_id = user_id;

                    string res_code = "";
                    if (Params["order_status"] == "Success") res_code = "0";
                    else if (Params["order_status"] == "Failure") res_code = "1";
                    else if (Params["order_status"] == "Aborted") res_code = "2";
                    else res_code = "3";

                    TranRow["payment_return_flag"] = Constant.YES;
                    TranRow["payment_response_code"] = res_code;
                    TranRow["payment_response_msg"] = res_code == "0" ? "Transaction Successful" : Params["order_status"] + " - " + Params["status_message"];
                    TranRow["payment_transaction_reference_id"] = Params["tracking_id"];
                    TranRow["payment_authorization_code"] = Params["bank_ref_no"];
                    TranRow["Citrus_PaymentMode"] = Params["payment_mode"];
                    TranRow["Citrus_TxRefNo"] = Params["bank_ref_no"];
                    TranRow["Citrus_TxGateway"] = "Kotak";
                    TranRow["Citrus_TxStatus"] = res_code == "0" ? "SUCCESS" : null;

                    TranRow["status_is_payment_received"] = Constant.YES;

                    TranRow["last_modified_date"] = DateTime.Now;
                    //TranRow["last_modified_by"] = HttpContext.Current.Session["UserId"].ToString();
                    TranRow["last_modified_by"] = user_id;
                    TranRow["last_modified_host"] = HttpContext.Current.Request.UserHostName;

                    obDS_Payment.ws_applicationpaymenttransaction.ImportRow(TranRow);
                    Log.PaymentTransactionLog("row imported");

                    DBConnection.Open();
                    Log.PaymentTransactionLog("connection open");

                    //Begin Transaction.
                    DBCommand.Transaction = DBConnection.BeginTransaction();
                    Log.PaymentTransactionLog("connection Begin");

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
                        message += " Fail to Update SWSCourse Transaction Details.";
                        return false;
                    }
                    Log.PaymentTransactionLog("SWSCourse fees paid successfully with ID :  txnID : " + transactionId);
                    message += "SWSCourse fees paid successfully with ID :  txnID : " + transactionId;
                    paymentResponse.data.application_id = "";
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    //Enable not working code
                    //bool status = objMaster.sws_course_allocation_dtl(user_id, transactionId);

                }
                catch (Exception ex)
                {
                    Log.PaymentTransactionLog("SWS Kotak Status :: " + ex.ToString());
                    return false;
                }
                return true;
            }
            else
            {
                message = "Tansaction Not Found with ID : " + transactionId;
                return false;
            }
            //}
        }

#endregion



    }
}