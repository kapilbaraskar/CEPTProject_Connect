using System;
using System.Configuration;
using System.Data;

namespace BLL.Utilities1
{    
    public class ServerBase : IDisposable
    {
        protected IDbConnection DBConnection;
        protected IDbTransaction DBTransactionObject = null;
        protected IDbCommand DBCommand;
        protected IDbDataAdapter DBDataAdpterObject;
                
        public ServerBase()
        {
            DBConnection = DBObjectFactory.GetConnectionObject();
            DBConnection.ConnectionString = ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString();            
            DBCommand = DBObjectFactory.GetCommandObject();
            DBCommand.Connection = DBConnection;
            DBDataAdpterObject = DBObjectFactory.GetDataAdapterObject(DBCommand);
            DBDataAdpterObject.SelectCommand.CommandTimeout = 60;
        }

        ////Some time Error comes "Internal .Net Framework Data Provider error 1." while DBConnection.Close();. 
        ////So i implement IDisposable and write DBConnection.Close(); inside Dispose
        //~ServerBase()
        //{
        //    if(DBConnection != null)
        //    {
        //        //try
        //        {
        //            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //        }
        //        //catch { }
        //    }
        //}

        public void Dispose()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }

       
        public virtual SendReceiveJSon ProcessRequest(SendReceiveJSon receive_obj) { return null; }

        /*
        public void CompleteWork(SendReceiveJSon receive_obj, String ServerMessage)
        {
            lock (typeof(ServerBase))
            {
                try
                {
                    if (receive_obj.requestObjectInfo.GeneralArgs != null && receive_obj.requestObjectInfo.ObjectProfile != null)//code changed
                        Log.ClientRequestLog("CompanyId:" + receive_obj.requestObjectInfo.GeneralArgs.CompanyId + " SessionId:" + receive_obj.requestObjectInfo.GeneralArgs.SessionId + " UserId:" + receive_obj.requestObjectInfo.GeneralArgs.UserId + " MenuId:" + receive_obj.requestObjectInfo.ObjectProfile.MenuId + "TransactionType:" + receive_obj.requestObjectInfo.ObjectProfile.TransactionType + " ClassName:" + receive_obj.requestObjectInfo.ObjectProfile.ClassName + " MethodName:" + receive_obj.requestObjectInfo.ObjectProfile.MethodName);

                    if (DBConnection != null)
                    {
                        //Establish DataBase Connecton.
                        if (DBConnection.State == ConnectionState.Closed) DBConnection.Open();

                        //Begin Transaction.
                        DBCommand.Transaction = DBConnection.BeginTransaction();

                        DS_TransactionLog dS_TransactionLog = new DS_TransactionLog();
                        DS_TransactionLog.transactionlogRow row = dS_TransactionLog.transactionlog.NewtransactionlogRow();
                        row.TransactionDateTime = DateTime.Now;
                        //row.CompanyId = receive_obj.requestObjectInfo.GeneralArgs.CompanyId;
                        row.UserId = receive_obj.requestObjectInfo.GeneralArgs.UserId;
                        row.SessionId = receive_obj.requestObjectInfo.GeneralArgs.SessionId;
                        row.HostIp = receive_obj.requestObjectInfo.GeneralArgs.HostIp;
                        //row.MenuId = receive_obj.requestObjectInfo.ObjectProfile.MenuId;
                        //row.TransactionType = receive_obj.requestObjectInfo.ObjectProfile.TransactionType;
                        row.ClassName = receive_obj.requestObjectInfo.ObjectProfile.ClassName;
                        row.Method = receive_obj.requestObjectInfo.ObjectProfile.MethodName;
                        row.ServerMessage = ServerMessage;
                        row.Barcode = receive_obj.requestObjectInfo.OpArgs.ContainsKey("Barcode") ? receive_obj.requestObjectInfo.OpArgs["Barcode"].ToString() : "";
                        dS_TransactionLog.transactionlog.Rows.Add(row);

                        BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, dS_TransactionLog.transactionlog, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly);
                        if (!objUpdateTableInfo.Status || objUpdateTableInfo.TotalRowsAffected != dS_TransactionLog.transactionlog.Rows.Count)
                        {
                            DBCommand.Transaction.Rollback();
                        }
                        else
                        {
                            DBCommand.Transaction.Commit();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                    if (DBCommand.Transaction != null)//code changed
                        DBCommand.Transaction.Rollback();
                }
                finally
                {
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                }
            }
        }
        */
    }
}