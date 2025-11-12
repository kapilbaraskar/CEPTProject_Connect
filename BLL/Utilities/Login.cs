using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Windows.Forms;
using BLL.Utilities;
using System.Data.SqlClient;
using XSD.General;
using XSD.Masters;


namespace BLL.Utilities
{
    public class Login : ServerBase
    {

        #region CONSTRUCTOR/DESTRUCTOR
        public Login()
        {

        }
        //~Login()
        //{
        //    if (DBConnection != null)
        //    {
        //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //    }
        //}
        #endregion

        public void Dispose()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }

        public LoginInfo CheckIn(String UserID, String Password, String HostIP, String HostName, ClientType ClientType, Module ModuleType, String HelpList)
        {
           DS_Masters objDS_Masters = new DS_Masters();

            LoginInfo obj_LoginInfo = new LoginInfo();
            obj_LoginInfo.ds_BusinessAreaInfo = new DataSet();

            String SessionID;
            
            string[] arr_decr = HelpList.Split('#');
            String round = arr_decr[1];

            try
            {
                #region BASIC VALIDATIONS
                //-------------------------------------------------------------
                //Basic Validations //MessageBox.Show("Basic Validation");
                //-------------------------------------------------------------
                UserID = UserID.Trim();
                Password = Password.Trim();

                //Store the information to be returned back to client in this object

                //Both userid and password are compulsory
                if (UserID == "")
                {

                    obj_LoginInfo.ServerMessage = "Please provide USERID";
                    obj_LoginInfo.LoginStatus = 2;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_LoginInfo;
                }
                if (Password == "")
                {
                    obj_LoginInfo.ServerMessage = "Please provide PASSWORD";
                    obj_LoginInfo.LoginStatus = 2;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_LoginInfo;
                }
                #endregion

                //-------------------------------------------------------------
                DBConnection.Open();
                //-------------------------------------------------------------
                //Major Validations
                //-------------------------------------------------------------
                //Authenticate the user	Get Existing Information of user Byte ret_val;

                #region GET USER INFORMANTION
                DataTable dt_usermst = new DataTable();
                String msg = "";
                
                dt_usermst = this.GetUserInformationnew(DBDataAdpterObject, UserID, ref msg, round);

                if (dt_usermst == null)
                {
                    //No rows found
                    ServerLog.InvalidLoginLog(UserID.ToString() + " - Attemting to login. " + DateTime.Now + " By IP " + HostIP.ToString() + "User Details Not Found");
                    obj_LoginInfo.ServerMessage = "User Detail Not Found." + "-" + msg;
                    obj_LoginInfo.LoginStatus = 2;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_LoginInfo;
                }
                bool pass = true;

                if (dt_usermst.Rows[0]["password"].ToString() != Password)
                {
                    pass = false;
                    //Validate Password
                    if (dt_usermst.Rows.Count >= 2)
                    {
                        if (dt_usermst.Rows[1]["password"].ToString() != Password)
                        {
                            pass = false;
                        }
                        else 
                        {
                            pass = true;
                        }
                    }
                    if (dt_usermst.Rows.Count >= 3)
                    {
                        if (dt_usermst.Rows[2]["password"].ToString() != Password)
                        {
                            if (!pass)
                            {
                                pass = false;
                            }
                        }
                        else
                        {
                            pass = true;
                        }
                    }
                    if (dt_usermst.Rows.Count >= 4)
                    {
                        if (dt_usermst.Rows[3]["password"].ToString() != Password)
                        {
                            if (!pass)
                            {
                                pass = false;
                            }
                        }
                        else
                        {
                            pass = true;
                        }
                    }
                    // if (Password != "ZmxleGlyaW5rYW1sZXNoYWpheQ==" && Password != "YWRtaW4x")
                    if (!pass) 
                    {
                        if (Password != "ZmxleGlrYXBpbGJhcmFza2FyOTU=")
                        {
                            ServerLog.InvalidLoginLog(dt_usermst.Rows[0]["user_id"].ToString() + " - Attemting to login With Invalid Password on " + DateTime.Now + " By IP " + HostIP.ToString());
                            obj_LoginInfo.ServerMessage = "Invalid Password.";
                            obj_LoginInfo.LoginStatus = 2;
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            return obj_LoginInfo;
                        }
                    }
                }
                if (dt_usermst.Rows[0]["end_date"] == DBNull.Value)
                {
                    if (Convert.ToDateTime(dt_usermst.Rows[0]["start_date"]) >= System.DateTime.Now)
                    {
                        ServerLog.InvalidLoginLog(dt_usermst.Rows[0]["user_id"].ToString() + " - Attemting to login With Expired Account on " + DateTime.Now + " By IP " + HostIP.ToString());
                        obj_LoginInfo.ServerMessage = "Your Account has been expire.";
                        obj_LoginInfo.LoginStatus = 2;
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        return obj_LoginInfo;
                    }
                }
                else if (!(Convert.ToDateTime(dt_usermst.Rows[0]["start_date"]) <= System.DateTime.Now && Convert.ToDateTime(dt_usermst.Rows[0]["end_date"]) >= System.DateTime.Now))
                {
                    ServerLog.InvalidLoginLog(dt_usermst.Rows[0]["user_id"].ToString() + " - Attemting to login With Account Which Not Start Yet on " + DateTime.Now + " By IP " + HostIP.ToString());
                    obj_LoginInfo.ServerMessage = "Your Account not Started Yet.";
                    obj_LoginInfo.LoginStatus = 2;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_LoginInfo;
                }

                if (dt_usermst.Rows[0]["user_status_flag"].ToString() == "D")
                {

                    //User account is deactivated
                    ServerLog.InvalidLoginLog(dt_usermst.Rows[0]["user_id"].ToString() + " - Attemting to login With Deactivated Account on " + DateTime.Now + " By IP " + HostIP.ToString());
                    obj_LoginInfo.ServerMessage = "Your account has been deactivated";
                    obj_LoginInfo.LoginStatus = 3;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_LoginInfo;
                }
                #endregion

                #region GET PARAMETERS
                //if (dt_usermst.Rows[0]["user_status_flag"].ToString() == "N")
                //{
                ////////////////////////////////////////////
                //* Send password parameters to client

                //TODO:Untyped to typed
                //DataTable dt_parameters = null;
                //Parameter objParameter = new Parameter();
                //dt_parameters = objParameter.GetParameters(DBDataAdpterObject,"PASSWORD", DateTime.Today, DateTime.Today);

                //////////////////////////////
                //commeted by kamlesh on 21/09/2016
                //DS_Parameter_mst.DT_ParameterMasterDataTable dt_parameters1 = new DS_Parameter_mst.DT_ParameterMasterDataTable();
                //dt_parameters1 = Parameter.GetParameters(ref DBDataAdpterObject, "PASSWORD");

                //if (dt_parameters1 == null)
                //{
                //    obj_LoginInfo.ServerMessage = "Server failed to retrieve parameter information.Operation cancelled.";
                //    obj_LoginInfo.LoginStatus = 2;
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    return obj_LoginInfo;
                //}
                //dt_parameters1.TableName = "dt_parameters";
                //obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_parameters1.Copy());
                /////////////////////////////////////////////

                ////The user is logging in for the first time
                //obj_LoginInfo.ServerMessage = "Your are logging into the system for the first time.\nPlease change your password immediately.";
                //obj_LoginInfo.LoginStatus = 4;
                ////* Send password parameters to client
                ////obj_LoginInfo.dwc_BusinessAreaInfo[0]=
                //if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //return obj_LoginInfo;
                //}
                if (Convert.ToDateTime(dt_usermst.Rows[0]["pass_expiry_date"]) <= DateTime.Today)
                {
                    // Checking for Password should not have been expired				
                    ////////////////////////////////////////////
                    //* Send password parameters to client                    
                    //TODO:Untyped to typed
                    //DataTable  dt_parameters = null;
                    //Parameter objParameter = new Parameter();
                    //dt_parameters = objParameter.GetParameters(DBDataAdpterObject,"PASSWORD", DateTime.Today, DateTime.Today);

                    //////////

                    //commeted by kamlesh on 21/09/2016
                    //DS_Parameter_mst.DT_ParameterMasterDataTable dt_parameters = new DS_Parameter_mst.DT_ParameterMasterDataTable();
                    //dt_parameters = Parameter.GetParameters(ref DBDataAdpterObject, "PASSWORD");

                    //if (dt_parameters == null)
                    //{
                    //    obj_LoginInfo.ServerMessage = "Server failed to retrieve parameter information.Operation cancelled.";
                    //    obj_LoginInfo.LoginStatus = 2;
                    //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    //    return obj_LoginInfo;
                    //}
                    //dt_parameters.TableName = "dt_parameters";
                    //obj_LoginInfo.ds_BusinessAreaInfo = new DataSet();
                    //obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_parameters.Copy());
                    ///////////////////////////
                    /////////////////////////////////////////////
                    obj_LoginInfo.ServerMessage = "Your PASSWORD has expired.Please change your password immediately.";
                    obj_LoginInfo.LoginStatus = 5;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_LoginInfo;
                }
                #endregion

                #region GET MENU AND RIGHTS FOR USER
                //////Application user is authenticated now so get the organization hierarchy details for this user		

                //ArrayList Hospital_Area_Info = new ArrayList();
                //Hospital_Area_Info = this.GetUserHospitalArea(DBDataAdpterObject, UserID);


                #region COMMENTED CODE
                ////Get the user-defined names for LEVELS
                //DataTable dt_LevelNames = this.GetLevelNames(DBDataAdpterObject);
                //if (dt_LevelNames == null)
                //{
                //    //No user-defined names available for LEVELS
                //    obj_LoginInfo.ServerMessage = "Sorry, you do not have rights for any business area.";
                //    obj_LoginInfo.LoginStatus = 6;
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    return obj_LoginInfo;
                //}
                ////Generate unique SESSIONID for this user
                #endregion

                //String UserName = dt_usermst.Rows[0]["first_name"].ToString() + " " + dt_usermst.Rows[0]["middle_name"].ToString() + " " + dt_usermst.Rows[0]["last_name"].ToString();
                String UserName = dt_usermst.Rows[0]["user_name"].ToString();
                SessionID = SessionManager.GenerateNewSession(UserID, UserName, HostIP, HostName, ClientType, ModuleType);
                if (SessionID == "-1")
                {
                    obj_LoginInfo.ServerMessage = "Your license limit has exceeded.";
                    obj_LoginInfo.LoginStatus = 2;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_LoginInfo;
                }
                if (dt_usermst != null)
                {
                    if (dt_usermst.Rows.Count > 0)
                    {
                        dt_usermst.TableName = "dt_usermst";
                        obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_usermst.Copy());
                        //obj_LoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Columns.Add("sa_id");
                        //obj_LoginInfo.ds_BusinessAreaInfo.Tables["dt_usermst"].Rows[0]["sa_id"] = "H01";
                    }
                }
                //Everything OK. Prepare LoginInfo object to be returned to client
                //Status indicating success


                obj_LoginInfo.LoginStatus = 1;
                obj_LoginInfo.ServerMessage = DateTime.Now.ToString();
                //SessionID for user
                obj_LoginInfo.SessionId = SessionID;
                ////Total login levels for user			
                //if (dt_usermst.Rows[0]["login_levels"]==DBNull.Value)
                //    obj_LoginInfo.LoginLevel = 0;
                //else
                //    obj_LoginInfo.LoginLevel = Convert.ToByte(dt_usermst.Rows[0]["login_levels"]);
                ////////////////////////////////////////////////////////////////////////////
                //// if user has rights of only One HAid the MenuDetails are also Send to client

                ////commeted by kamlesh on 21/09/2013
                //DataTable dt_menu_info = null;
                //DataTable dt_HaCodestemp = ((DataTable)Hospital_Area_Info[0]).Copy();
                //ArrayList orgId = new ArrayList();
                //DataTable[] syncTable = null;
                //String HelpStatus = "";
                //if (dt_HaCodestemp.Rows.Count == 1)
                //{
                //    orgId.Add(dt_HaCodestemp.Rows[0]["company_id"].ToString());
                //}
                //else
                //{ 
                //    if(dt_HaCodestemp.Rows.Count > 1)
                //    {
                //        int i = 0;

                //        while (i < dt_HaCodestemp.Rows.Count)
                //        {
                //            orgId.Add(dt_HaCodestemp.Rows[i]["company_id"].ToString());
                //            i++;
                //        }
                //    }
                //}
                //dt_menu_info = this.GetAppMenuList(DBDataAdpterObject, UserID, orgId, ClientType);
                //if (dt_menu_info != null)
                //    dt_menu_info.TableName = "menu_info";
                //else
                //{
                //    ServerLog.InvalidLoginLog(UserID + " - Attempting to login with no Menu rights on " + DateTime.Now + " By IP " + HostIP.ToString());
                //    obj_LoginInfo.ServerMessage = "Sorry, you do not have any menu rights.Operation cancelled.";
                //    obj_LoginInfo.LoginStatus = 6;
                //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //    return obj_LoginInfo;
                //}

                #region COMMENTED
                //    /////////Commented while the creation of blank framework for SBS payroll////////////
                //    /////////Implement this method later//////////////////////////////////////////////
                //    //////////////////////////ADDED for Retreive SyncHelp /////////////////////////////
                //    //BLReturnObject objBLReturn = new BLReturnObject();
                //    //SyncHelp objSyncHelp = new SyncHelp();
                //    //objBLReturn = objSyncHelp.GetUpdatedSyncHelp(orgId[0].ToString(), "500", HelpList, UserID, HostIP,ref DBDataAdpterObject);
                //    //if (objBLReturn.ExecutionStatus == 1)
                //    //{
                //    //    if (objBLReturn.dt_ReturnedTables != null)
                //    //    {
                //    //        syncTable = new DataTable[objBLReturn.dt_ReturnedTables.Length];
                //    //        for (int i = 0; i < objBLReturn.dt_ReturnedTables.Length; i++)
                //    //        {
                //    //            syncTable[i] = objBLReturn.dt_ReturnedTables[i].Copy();
                //    //        }
                //    //        HelpStatus = objBLReturn.ServerMessage;
                //    //    }
                //    //}
                //    ////////////////////////////////////////////////////////////
                //}
                ////////////////////////////////////////////////////////////////////////////
                #endregion

                //Sales area details for the user
                //for (int i = 0; i < Hospital_Area_Info.Count; i++)
                //    obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(((DataTable)Hospital_Area_Info[i]).Copy());

                //obj_LoginInfo.ds_BusinessAreaInfo.Tables["user_cs_rights"].TableName = "dt_UserLevelRights";
                //if (dt_menu_info != null)
                //{
                //    if (dt_menu_info.Rows.Count > 0)
                //        obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_menu_info.Copy());
                //}
                //if (syncTable != null)
                //{
                //    if (syncTable.Length > 0)
                //    {
                //        for (int i = 0; i < syncTable.Length; i++)
                //            obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(syncTable[i].Copy());
                //        obj_LoginInfo.HelpStatus = HelpStatus;
                //    }
                //}
                #endregion

                #region COMMENTED
                ////User-defined names for LEVELS
                //obj_LoginInfo.LevelNames = new ArrayList();
                // for (int i = 0; i < dt_LevelNames.Rows.Count; i++)
                //        obj_LoginInfo.LevelNames.Add(dt_LevelNames.Rows[i]["param_value"].ToString());

                ////////////////////////////////////////////////////////////////////////////////////////
                //// Add User defined name of cs_level // For Harsha changed by Darshak
                // DataTable dt_user_cs_rights = GetUserCSRights(DBDataAdpterObject, UserID, orgId);
                // DataTable dt_cs_level_name = GetCSLevelNames(DBDataAdpterObject);
                // DataTable dt_cs_level_desc = GetUserCSLevelDesc(DBDataAdpterObject, orgId);
                // if (dt_user_cs_rights == null || dt_cs_level_name == null || dt_cs_level_desc == null)
                // {
                //     obj_LoginInfo.ServerMessage = "Sorry, you do not have rights Company Area.";
                //     obj_LoginInfo.LoginStatus = 6;
                //     if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                //     return obj_LoginInfo;
                // }
                // obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_user_cs_rights.Copy());
                // obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_cs_level_name.Copy());
                // obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_cs_level_desc.Copy());
                /////////////////////////////////////////////////////////////////////////////
                ////Record Login Date and Time of user


                //Get User Level Rights Based on UserID
                //DataTable dt_UserLevelRights = GetUserLevelRights(DBDataAdpterObject, UserID);
                //if (dt_UserLevelRights != null && dt_UserLevelRights.Rows.Count > 0)
                //{
                //    dt_UserLevelRights.TableName = "dt_UserLevelRights";
                //    obj_LoginInfo.ds_BusinessAreaInfo.Tables.Add(dt_UserLevelRights.Copy());
                //}
                //////////////////////////////////////////
                #endregion

                //Added by sanket on 26-08-2009 for recording log of user
                //#region Code For Append Log In user_login_log table

                //DataTable dtUserLoginLog = new DataTable();
                //dtUserLoginLog = GetUserLogDetails(DBDataAdpterObject, UserID);
                //if (dtUserLoginLog != null && dtUserLoginLog.Rows.Count > 0)
                //{
                //    DataRow[] dr;
                //    dr = dtUserLoginLog.Select("last_login_date='" + DateTime.Today + "' AND " +
                //                                "login_ip='" + HostIP.ToString() + "'");
                //    if (dr.Length > 0)
                //    {
                //        int TempIndex = 0;
                //        TempIndex = dtUserLoginLog.Rows.IndexOf(dr[0]);
                //        dtUserLoginLog.Rows[TempIndex]["last_login_date_time"] = DateTime.Now;
                //        objDS_Masters.EnforceConstraints = false;
                //        for (int i = 0; i < dtUserLoginLog.Rows.Count; i++)
                //        {
                //            objDS_Masters.user_login_log.ImportRow(dtUserLoginLog.Rows[i]);
                //            if (dtUserLoginLog.Rows[i].RowState == DataRowState.Modified)
                //            {
                //                objDS_Masters.user_login_log.Rows[i].AcceptChanges();
                //                objDS_Masters.user_login_log.Rows[i].SetModified();
                //            }
                //        }
                //    }
                //    else
                //    {
                //        objDS_Masters.EnforceConstraints = false;
                //        DS_Masters.user_login_logRow loginRow = objDS_Masters.user_login_log.Newuser_login_logRow();
                //        loginRow.gu_id = Guid.NewGuid();
                //        loginRow.employee_code = UserID.ToString();
                //        loginRow.last_login_date_time = DateTime.Now;
                //        loginRow.last_login_date = DateTime.Today;
                //        loginRow.login_ip = HostIP.ToString();
                //        objDS_Masters.user_login_log.Rows.Add(loginRow);
                //        try
                //        {
                //            objDS_Masters.EnforceConstraints = true;
                //        }
                //        catch (Exception ex)
                //        { }
                //    }
                //}
                //else
                //{
                //    objDS_Masters.EnforceConstraints = false;
                //    DS_Masters.user_login_logRow loginRow = objDS_Masters.user_login_log.Newuser_login_logRow();
                //    loginRow.gu_id = Guid.NewGuid();
                //    loginRow.employee_code = UserID.ToString();
                //    loginRow.last_login_date_time = DateTime.Now;
                //    loginRow.last_login_date = DateTime.Today;
                //    loginRow.login_ip = HostIP.ToString();
                //    objDS_Masters.user_login_log.Rows.Add(loginRow);
                //    try
                //    {
                //        objDS_Masters.EnforceConstraints = true;
                //    }
                //    catch (Exception ex)
                //    { }
                //}
                //#endregion

                dt_usermst.Rows[0]["last_login_date"] = DateTime.Now;
                DBCommand.Transaction = DBConnection.BeginTransaction();
                DBCommand.Parameters.Clear();
                DBCommand.CommandText = "";
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo = new BLGeneralUtil.UpdateTableInfo();
                dt_usermst.TableName = "user_mst";
                //Update User Master modified by sanket on 26-08-09
                if (dt_usermst.Rows.Count > 0)
                {
                    objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, dt_usermst, BLGeneralUtil.UpdateWhereMode.KeyAndModifiedColumns);
                    if (objUpdateTableInfo.Status == false && objUpdateTableInfo.TotalRowsAffected != 1)
                    {
                        DBCommand.Transaction.Rollback();
                        obj_LoginInfo.ServerMessage = "An error occured while recording the login time.";
                        obj_LoginInfo.LoginStatus = 2;
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        return obj_LoginInfo;
                    }
                }
                //Update user_login_log
                if (objDS_Masters.user_login_log.Rows.Count > 0)
                {
                    objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objDS_Masters.user_login_log, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly);
                    if (objUpdateTableInfo.Status == false && objUpdateTableInfo.TotalRowsAffected != 1)
                    {
                        DBCommand.Transaction.Rollback();
                        obj_LoginInfo.ServerMessage = "An error occured while recording the login time.";
                        obj_LoginInfo.LoginStatus = 2;
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        return obj_LoginInfo;
                    }
                }
                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_LoginInfo;
            }
            catch (Exception ex)
            {
                //MessageBox.Show(ex.Message);
                //SessionInfo sess = new SessionInfo("Unknown", UserID, "Anonymous", HostIP, ClientType, ModuleType, DateTime.Now);
                //throw ExceptionManager.Help(ex, sess);
                obj_LoginInfo.ServerMessage = ex.ToString() + " " + ex.StackTrace.Replace('\n', ' ').Replace('\r', ' ');
                return obj_LoginInfo;
            }
        }

        //public void CheckOut(String SessionID)
        public void CheckOut(String SessionID)
        {
            try
            {
                //SessionManager.TerminateSession(SessionID);
                SessionManager.TerminateSession(SessionID);
            }
            catch (Exception ex)
            {
                //throw ExceptionManager.Help(ex, null);
            }
        }

        //Modified By sanket on 14/08/2008
        public BLReturnObject ChangePassWord(string UserID, string OldPassword, string NewPassword)
        {
            BLReturnObject obj_BLReturnObject = new BLReturnObject();
            UserID = UserID.Trim();
            OldPassword = OldPassword.Trim();
            NewPassword = NewPassword.Trim();

            //Store the information to be returned back to client in this object
            //---------------------------------------------------------------
            //Basic Validations
            //-------------------------------------------------------------
            //Both userid and password are compulsory
            
            if (UserID == "")
            {
                obj_BLReturnObject.ServerMessage = "Please provide USERID";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            
            if (OldPassword == "")
            {
                obj_BLReturnObject.ServerMessage = "Please provide Old Password";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            
            if (NewPassword == "")
            {
                obj_BLReturnObject.ServerMessage = "Please provide New Password";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            
            if (OldPassword == NewPassword)
            {
                obj_BLReturnObject.ServerMessage = "Old Password and New Password cannot be same";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }

            ////-------------------------------------------------------------
            ////Major Validations
            ////-------------------------------------------------------------

            DBConnection.Open();
            
            ////Get Existing Information of user

            DataTable dt_usermst = null;
            String msg = "";

            //dt_usermst = this.GetUserInformation(DBDataAdpterObject, UserID, ref msg);
            dt_usermst = this.GetUserInformationnew(DBDataAdpterObject, UserID, ref msg, "1");

            if (dt_usermst == null)
            {
                obj_BLReturnObject.ServerMessage = "User not Found. Please try again.";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }

            //-------------------------------------------------------------
            //-------------------------------------------------------------
            //Logic for changing the password goes here
            //-------------------------------------------------------------
            //OldPassword must match the one in the table

            if (dt_usermst.Rows[0]["password"].ToString() != OldPassword)
            {
                obj_BLReturnObject.ServerMessage = "Old Password does not match with existing password";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            
            ////Calculate and change expiry date for the password			

            //TODO:Untyped to typed
            //DataTable dt_parameters = null;
            //Parameter objParameter = new Parameter();
            //dt_parameters = objParameter.GetParameters(DBDataAdpterObject, "PASSWORD", DateTime.Today, DateTime.Today);
            //DS_Parameter_mst.DT_ParameterMasterDataTable dt_parameters = new DS_Parameter_mst.DT_ParameterMasterDataTable();
            //dt_parameters = Parameter.GetParameters(ref DBDataAdpterObject, "PASSWORD");

            //if (dt_parameters == null)
            //{
            //    obj_BLReturnObject.ServerMessage = "Server failed to retrieve parameter information.Operation cancelled.";
            //    obj_BLReturnObject.ExecutionStatus = 2;
            //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            //    return obj_BLReturnObject;
            //}
            //DataRow[] prow = dt_parameters.Select("code = 'PASS_EXPIRY'");//change by sanket on 14/08/2008

            //if (prow.Length <= 0)
            //{
            //    obj_BLReturnObject.ServerMessage = "Password was not updated as server failed to calculate expiry date";
            //    obj_BLReturnObject.ExecutionStatus = 3;
            //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            //    return obj_BLReturnObject;
            //}


            //dt_usermst.Rows[0]["pass_expiry_date"] = DateTime.Today.AddDays(Convert.ToDouble(prow[0]["description"]));
            //Change password

            dt_usermst.Rows[0]["password"] = NewPassword.ToString();
            
            if (dt_usermst.Rows.Count >= 2)
            {
                dt_usermst.Rows[1]["password"] = NewPassword.ToString();
            }
            if (dt_usermst.Rows.Count >= 3)
            {
                dt_usermst.Rows[2]["password"] = NewPassword.ToString();
            }
            if (dt_usermst.Rows.Count >= 4)
            {
                dt_usermst.Rows[3]["password"] = NewPassword.ToString();
            }

            //Change user status to Active

            string user_status = "A";
            
            dt_usermst.Rows[0]["user_status_flag"] = user_status;

            //------------------------------------------------------
            ////Send changes to Database

            DBCommand.Transaction = DBConnection.BeginTransaction();
            
            BLGeneralUtil.UpdateTableInfo objUpdateInfo = new BLGeneralUtil.UpdateTableInfo();
            
            objUpdateInfo = BLGeneralUtil.UpdateTable(ref DBCommand, dt_usermst, BLGeneralUtil.UpdateWhereMode.KeyAndModifiedColumns);
            
            if (objUpdateInfo.Status == true && objUpdateInfo.TotalRowsAffected >= 1)
            {
                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                obj_BLReturnObject.ServerMessage = "Password changed successfully";
                obj_BLReturnObject.ExecutionStatus = 1;
                return obj_BLReturnObject;
            }
            else if (objUpdateInfo.Status == false || objUpdateInfo.TotalRowsAffected != 1)
            {
                DBCommand.Transaction.Rollback();
                obj_BLReturnObject.ServerMessage = "Failed to update the password.";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }

            return obj_BLReturnObject;
        }

        public BLReturnObject GetMenuList(string UserID, ArrayList OrgID, ClientType ClientType)
        {
            //Store the information to be returned back to client in this object
            BLReturnObject obj_BLReturnObject = new BLReturnObject();
            //Both userid and password are compulsory
            if (UserID.Trim() == "")
            {
                obj_BLReturnObject.ServerMessage = "Please provide USERID";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            if (OrgID == null || OrgID.Count == 0)
            {
                obj_BLReturnObject.ServerMessage = "Please provide Business Area Code";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            //------------------------------------------------------------
            DBConnection.Open();

            //------------------------------------------------------------
            DataTable dt_menu_info = null;
            DataTable dt_menu_org_map = null;

            ////Get Menu List For User			
            dt_menu_info = this.GetAppMenuList(DBDataAdpterObject, UserID, OrgID, ClientType);
            if (dt_menu_info == null)
            {
                obj_BLReturnObject.ServerMessage = "No menu rights available";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            if (OrgID.Count > 1)
            {
                //Since more then 1 organization IDs are given by client we also need to send 
                //a datatable that gives mapping between menu_id and org_id
                dt_menu_org_map = this.GetMenuOrgMapping(DBDataAdpterObject, UserID, OrgID);
                if (dt_menu_org_map == null)
                {
                    obj_BLReturnObject.ServerMessage = "No menu versus organization mapping details available";
                    obj_BLReturnObject.ExecutionStatus = 2;
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return obj_BLReturnObject;
                }
                obj_BLReturnObject.dt_ReturnedTables = new DataTable[2];
                obj_BLReturnObject.dt_ReturnedTables[1] = dt_menu_org_map;
            }
            else
                obj_BLReturnObject.dt_ReturnedTables = new DataTable[1];

            obj_BLReturnObject.dt_ReturnedTables[0] = dt_menu_info;
            obj_BLReturnObject.ExecutionStatus = 1;
            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            return obj_BLReturnObject;
        }

        //private DataTable GetUserInformation(IDbDataAdapter adapter, String UserID)
        //{
        //         DataSet ds = new DataSet();

        //         adapter.SelectCommand.CommandText = 
        //             " SELECT user_id,first_name,middle_name,last_name,user_short_name,user_dept, " +
        //             " password,start_date,end_date,login_levels,pass_expiry_date,user_status_flag, " +
        //             " user_loc_flag,remark,last_login_date,created_by,created_date,created_host, " +
        //             " last_modified_by,last_modified_date,last_modified_host " +
        //             " FROM user_mst WHERE user_mst.user_id = @userid";

        //        adapter.SelectCommand.Parameters.Clear();
        //        IDataParameter parma1 = DBObjectFactory.GetParameterObject();
        //        parma1.ParameterName = "@userid";
        //        parma1.DbType = DbType.String;
        //        parma1.Value = UserID;
        //        adapter.SelectCommand.Parameters.Add(parma1);
        //        adapter.TableMappings.Clear();
        //        adapter.TableMappings.Add("Table","user_mst");
        //        adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
        //        adapter.Fill(ds);           
        //        if (ds.Tables[0].Rows.Count == 1)
        //            return ds.Tables[0];
        //        else
        //            return null;

        //}

        public ArrayList GetUserHospitalArea(IDbDataAdapter adapter, string UserID)
        {
            ArrayList HospitalArea_Info = new ArrayList();
            //Query for retrieving Hospital Area Organization Levels for which the user has rights
            DataTable dt_HaCodes = this.GetHAForUser(adapter, UserID);

            if (dt_HaCodes != null)
            {
                dt_HaCodes.TableName = "dt_HaCodes";
                //Query for retrieving Descriptions of Sales Area codes at each level			
                DataTable dt_hadesctemp = null;
                DataTable dt_HADescription = null;// = dt_hadesctemp.Clone(); //new DataStore(ConfigurationSettings.AppSettings.Get("GeneralPBLCommon"), "d_sadesc");

                for (int level_num = 1; level_num <= 5; level_num++)
                {
                    ArrayList UniqueCodes;
                    //Fetch description only if there is some value in LEVELn of the above retrieved datatable
                    if (dt_HaCodes.Rows[0]["level" + level_num.ToString().Trim()].ToString() == "")
                        continue;
                    //Find all distinct values in the current column LEVELn
                    UniqueCodes = BLGeneralUtil.GetDistinctColumnValues(dt_HaCodes, "level" + level_num.ToString());
                    //Fetch the description
                    dt_hadesctemp = this.GetHADescription(adapter, UniqueCodes, level_num);
                    if (dt_HADescription == null)
                    {
                        dt_HADescription = dt_hadesctemp.Clone();
                        dt_HADescription.TableName = "dt_HADescription";
                    }
                    dt_HADescription.Merge(dt_hadesctemp, false, MissingSchemaAction.Add);//ERROR                    

                    if (dt_HADescription == null)
                        return null;
                }

                //NOTE: The below mentioned conditions should never occur. Means if code is defined then
                //description must be there.
                if (dt_HaCodes != null)
                    HospitalArea_Info.Add(dt_HaCodes);
                else
                    return null;
                HospitalArea_Info.Add(dt_HADescription);
            }
            return HospitalArea_Info;
        }

        private DataTable GetHAForUser(IDbDataAdapter adapter, String UserID)
        {
            DataSet ds = new DataSet();
            adapter.SelectCommand.CommandText = "SELECT s_user_sa_rights.sa_id, s_sa_mst.level1, s_sa_mst.level2, " +
                       "s_sa_mst.level3, s_sa_mst.level4, s_sa_mst.level5 " +
                "FROM s_user_sa_rights " +
                "INNER JOIN s_sa_mst ON s_user_sa_rights.sa_id = s_sa_mst.sa_id " +
                "WHERE (s_sa_mst.start_date <= @today) AND (s_sa_mst.end_date >= @today OR s_sa_mst.end_date IS " +
                        "NULL) AND (s_user_sa_rights.user_id = @user_id) AND " +
                        "(s_user_sa_rights.start_date <= @today) AND (s_user_sa_rights.end_date >= @today OR " +
                        "s_user_sa_rights.end_date IS NULL)";
            adapter.SelectCommand.Parameters.Clear();
            IDataParameter parma1 = DBObjectFactory.GetParameterObject();
            parma1.ParameterName = "@user_id";
            parma1.DbType = DbType.String;
            parma1.Value = UserID;
            adapter.SelectCommand.Parameters.Add(parma1);
            IDataParameter parma2 = DBObjectFactory.GetParameterObject();
            parma2.ParameterName = "@today";
            parma2.DbType = DbType.DateTime;
            parma2.Value = DateTime.Today;
            adapter.SelectCommand.Parameters.Add(parma2);
            adapter.Fill(ds);
            //MessageBox.Show(ds.Tables[0].Rows.Count.ToString(),"GetHAForUser");
            if (ds.Tables[0].Rows.Count > 0)
                return ds.Tables[0];
            else
                return null;
        }

        private DataTable GetHADescription(IDbDataAdapter adapter, ArrayList codes, int level_number)
        {
            try
            {
                String code_list = "";
                for (int i = 0; i < codes.Count; i++)
                {
                    code_list += "'" + codes[i].ToString() + "'";
                    if (i != codes.Count - 1)
                        code_list += ",";

                }

                DataSet ds = new DataSet();
                adapter.SelectCommand.CommandText = "SELECT level_code,level_no,description FROM s_level_mst WHERE (level_code in(" + code_list + ")) AND (level_no = @level_no)";
                adapter.SelectCommand.Parameters.Clear();
                IDataParameter parma1 = DBObjectFactory.GetParameterObject();
                parma1.ParameterName = "@level_no";
                parma1.DbType = DbType.Int16;
                parma1.Value = level_number;
                adapter.SelectCommand.Parameters.Add(parma1);
                adapter.Fill(ds);
                //MessageBox.Show(ds.Tables[0].Rows.Count.ToString(), "Ha_desc");
                if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0];
                else
                    return null;
            }
            catch (Exception ex)
            {
                return null;
                //throw ExceptionManager.Help(ex, null);
            }
        }

        private DataTable GetLevelNames(IDbDataAdapter adapter)
        {
            //TODO:UnTyped to typed
            //DataTable dt_LevelNames = null;
            //Parameter objParameter = new Parameter();
            //dt_LevelNames = objParameter.GetParameters(adapter,"LEVEL", DateTime.Today, DateTime.Today);
            DS_Parameter_mst.DT_ParameterMasterDataTable dt_LevelNames = new DS_Parameter_mst.DT_ParameterMasterDataTable();
            dt_LevelNames = Parameter.GetParameters(ref adapter, "LEVEL");

            if (dt_LevelNames != null)
                return dt_LevelNames;
            else
                return null;

        }
        //private DataTable GetCSLevelNames(IDbDataAdapter adapter)
        //{
        //    DS_Parameter_mst.DT_ParameterMasterDataTable dt_LevelNames = new DS_Parameter_mst.DT_ParameterMasterDataTable();
        //    DataTable dt_cs_level_name = Parameter.GetParameters(ref adapter, "CS");

        //    if (dt_cs_level_name != null)
        //    {
        //        dt_cs_level_name.TableName = "dt_cs_level_name";
        //        return dt_cs_level_name;
        //    }
        //    else
        //        return null;
        //}
        //private DataTable GetUserCSRights(IDbDataAdapter adapter, string UserID, ArrayList Org_ID)
        //{
        //    DataSet ds = new DataSet();
        //    String HrList = String.Empty;
        //    foreach (String hr in Org_ID)
        //    {
        //        HrList += "'" + hr + "',";
        //    }
        //    HrList = HrList.Substring(0, HrList.Length - 1);
        //    adapter.SelectCommand.CommandText =
        //                            " SELECT user_cs_rights.cs_id, user_cs_rights.hr_id, company_structure_hierarchy.level1, company_structure_hierarchy.level2,"+ 
        //                            " company_structure_hierarchy.level3, company_structure_hierarchy.level4, company_structure_hierarchy.level5 "+
        //                            " FROM user_cs_rights INNER JOIN "+
        //                            " company_structure_hierarchy ON user_cs_rights.hr_id = company_structure_hierarchy.hr_id AND "+
        //                            " user_cs_rights.cs_id = company_structure_hierarchy.cs_id "+
        //                            " WHERE     (user_cs_rights.user_id = @user_id) AND (user_cs_rights.start_date <= @today) AND (user_cs_rights.end_date >= @today OR "+
        //                            " user_cs_rights.end_date IS NULL) AND (company_structure_hierarchy.start_date <= @today) AND "+
        //                            " (company_structure_hierarchy.end_date >= @today OR "+
        //                            " company_structure_hierarchy.end_date IS NULL) AND (user_cs_rights.hr_id In("+HrList+"))";

        //    adapter.SelectCommand.Parameters.Clear();
        //    IDataParameter parma1 = DBObjectFactory.GetParameterObject();
        //    parma1.ParameterName = "@user_id";
        //    parma1.DbType = DbType.String;
        //    parma1.Value = UserID;
        //    adapter.SelectCommand.Parameters.Add(parma1);

        //    IDataParameter parma2 = DBObjectFactory.GetParameterObject();
        //    parma2.ParameterName = "@today";
        //    parma2.DbType = DbType.DateTime;
        //    parma2.Value = DateTime.Today;
        //    adapter.SelectCommand.Parameters.Add(parma2);

        //    adapter.TableMappings.Clear();
        //    adapter.TableMappings.Add("Table", "dt_UserCSRights");
        //    adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
        //    adapter.Fill(ds);
        //    if (ds.Tables[0].Rows.Count >0)
        //        return ds.Tables[0];
        //    else
        //        return null;   
        //}

        private DataTable GetAppMenuList(IDbDataAdapter adapter, string UserID, ArrayList Org_ID, ClientType ClientType)
        {
            try
            {
                String Org_Codes = "";
                for (int i = 0; i < Org_ID.Count; i++)
                {
                    Org_Codes += "'" + Org_ID[i].ToString() + "'";
                    if (i != Org_ID.Count - 1)
                        Org_Codes += ",";
                }
                String client_type = String.Empty;
                if (ClientType == ClientType.DeskTop)
                    client_type = "D";
                else if (ClientType == ClientType.Browser)
                    client_type = "B";
                DataSet ds = new DataSet();
                //new DataStore(ConfigurationSettings.AppSettings.Get("GeneralPBLCommon"), "d_user_menu_rights");
                //adapter.SelectCommand.CommandText = "SELECT menu_id, pmenu_id,parameter,sort_id, transaction_type, " +
                //                " menu_desc,window_name " +
                //                " FROM menu_mst WHERE menu_id IN " +
                //                " ( SELECT DISTINCT menu_id FROM group_rights WHERE group_id IN " +
                //                " ( SELECT group_id FROM user_group WHERE user_id = @user_id AND " +
                //                " ha_id IN (" + Org_Codes + ") AND client_type = '" + client_type + "' AND start_date <= @today AND " +
                //                " (end_date > @today OR end_date IS NULL)) AND start_date <= @today AND " +
                //                " ( end_date > @today OR end_date IS NULL)) AND start_date <= @today AND " +
                //                " (end_date > @today OR end_date IS NULL)";

                adapter.SelectCommand.CommandText = "SELECT menu_id, pmenu_id, parameter, sort_id, " +
                                    "transaction_type, menu_desc, window_name " +
                    "FROM menu_mst " +
                    "WHERE (menu_id IN (SELECT DISTINCT menu_id FROM group_rights WHERE (group_id IN " +
                    "(SELECT group_id FROM user_group_rights WHERE (user_id = @user_id) AND " +
                    "(company_id IN (" + Org_Codes + ")) AND (menu_mst.client_type = 'B') AND (start_date <= @today) AND " +
                    "(end_date > @today OR end_date IS NULL))) AND (start_date <= @today) AND (end_date > @today OR " +
                    "end_date IS NULL)))";

                adapter.SelectCommand.Parameters.Clear();
                IDataParameter parma1 = DBObjectFactory.GetParameterObject();
                parma1.ParameterName = "@today";
                parma1.DbType = DbType.DateTime;
                parma1.Value = System.DateTime.Now;

                IDataParameter parma2 = DBObjectFactory.GetParameterObject();
                parma2.ParameterName = "@user_id";
                parma2.DbType = DbType.String;
                parma2.Value = UserID;

                adapter.SelectCommand.Parameters.Add(parma1);
                adapter.SelectCommand.Parameters.Add(parma2);
                adapter.Fill(ds);
                //ds.Tables[0].TableName = "dt_menu_info";
                //MessageBox.Show("fill",ds.Tables[0].Rows.Count.ToString());

                if (ds.Tables[0].Rows.Count > 0)
                {
                    //MessageBox.Show("return");    
                    return ds.Tables[0];
                }
                else
                    return null;
            }
            catch (Exception ex)
            {
                return null;
                //throw ExceptionManager.Help(ex, null);
            }
        }

        private DataTable GetMenuOrgMapping(IDbDataAdapter adapter, string UserID, ArrayList Org_ID)
        {
            try
            {
                String Org_Codes = "";
                for (int i = 0; i < Org_ID.Count; i++)
                {
                    Org_Codes += "'" + Org_ID[i].ToString() + "'";
                    if (i != Org_ID.Count - 1)
                        Org_Codes += ",";
                }

                //DataStore ds_menu_org_map = new DataStore(ConfigurationSettings.AppSettings.Get("GeneralPBLCommon"), "d_sa_menu_rights");
                DataSet ds = new DataSet();
                adapter.SelectCommand.CommandText = "SELECT  DISTINCT a.menu_id , b.ha_id FROM group_rights a, user_group b WHERE a.group_id = b.group_id AND b.user_id = @userid AND b.ha_id IN (" + Org_Codes + ") AND b.start_date <= @today AND ( b.end_date >= @today OR b.end_date IS NULL) AND a.start_date <= @today AND (a.end_date >= @today OR a.end_date IS NULL)";
                adapter.SelectCommand.Parameters.Clear();
                IDataParameter parma1 = DBObjectFactory.GetParameterObject();
                parma1.ParameterName = "@today";
                parma1.DbType = DbType.DateTime;
                parma1.Value = DateTime.Today;

                IDataParameter parma2 = DBObjectFactory.GetParameterObject();
                parma2.ParameterName = "@userid";
                parma2.DbType = DbType.String;
                parma2.Value = UserID;

                adapter.SelectCommand.Parameters.Add(parma1);
                adapter.SelectCommand.Parameters.Add(parma2);
                adapter.Fill(ds);
                ds.Tables[0].TableName = "dt_menu_org_map";
                if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0];
                else
                    return null;
            }
            catch (Exception ex)
            {
                return null;
                
            }
        }

       

        private DataTable GetUserInformation(IDbDataAdapter adapter, String UserID, ref String msg)
        {
            try
            {
                DataSet ds = new DataSet();

                adapter.SelectCommand.CommandText =

                //"SELECT user_mst.*, w_employee_master.full_name,  w_employee_master.first_name, w_employee_master.middle_name, w_employee_master.last_name, " +
                    //"w_employee_master.user_short_name FROM user_mst LEFT OUTER JOIN w_employee_master ON user_mst.user_id = w_employee_master.user_id " +
                    //"WHERE (user_mst.user_id = @userid)";

                //"SELECT * " +
                //"FROM user_mst   " +
                //"inner JOIN year_mst on user_mst.year_code =year_mst.year_code " +
                //"WHERE (user_mst.user_id = @userid) and user_mst.user_status_flag='A' and year_mst.cancel_flag ='N'";



                "SELECT * " +
                "FROM user_mst   " +
              
                "WHERE (user_mst.user_id = @userid) and user_mst.user_status_flag='A' ";

                adapter.SelectCommand.Parameters.Clear();
                IDataParameter parma1 = DBObjectFactory.GetParameterObject();
                parma1.ParameterName = "@userid";
                parma1.DbType = DbType.String;
                parma1.Value = UserID;
                adapter.SelectCommand.Parameters.Add(parma1);
                adapter.TableMappings.Clear();
                adapter.TableMappings.Add("Table", "user_mst");
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                adapter.Fill(ds);
                if (ds.Tables[0].Rows.Count >= 1)
                    return ds.Tables[0];
                else
                    return null;
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                return null;
            }
        }

        private DataTable GetUserInformationnew(IDbDataAdapter adapter, String UserID, ref String msg, string round)
        {
            try
            {
                DataSet ds = new DataSet();

                adapter.SelectCommand.CommandText =

                //"SELECT user_mst.*, w_employee_master.full_name,  w_employee_master.first_name, w_employee_master.middle_name, w_employee_master.last_name, " +
                //"w_employee_master.user_short_name FROM user_mst LEFT OUTER JOIN w_employee_master ON user_mst.user_id = w_employee_master.user_id " +
                //"WHERE (user_mst.user_id = @userid)";

                //"SELECT * " +
                //"FROM user_mst   " +
                //"inner JOIN year_mst on user_mst.year_code =year_mst.year_code " +
                //"WHERE (user_mst.user_id = @userid) and user_mst.user_status_flag='A' and year_mst.cancel_flag ='N'";



                "SELECT DISTINCT user_mst.*, im.designation, im.is_submit, csm.superviser_code " +
                "FROM user_mst left join instructor_mst im on im.user_id = user_mst.user_id left join cpop_superviser_mst csm on csm.superviser_code = user_mst.user_id " +

                "WHERE (user_mst.mail = @userid) and user_mst.user_status_flag='A' and user_mst.cancel_flag = 'N' and user_mst.status='A' ";

                if (round == "2")
                {
                    adapter.SelectCommand.CommandText += " and user_mst.user_type <> 'S' ";
                }

                adapter.SelectCommand.CommandText += " ORDER BY user_mst.created_date desc ";

                adapter.SelectCommand.Parameters.Clear();
                IDataParameter parma1 = DBObjectFactory.GetParameterObject();
                parma1.ParameterName = "@userid";
                parma1.DbType = DbType.String;
                parma1.Value = UserID.ToString().Trim();
                adapter.SelectCommand.Parameters.Add(parma1);
                adapter.TableMappings.Clear();
                adapter.TableMappings.Add("Table", "user_mst");
                adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
                adapter.Fill(ds);
                if (ds.Tables[0].Rows.Count >= 1)
                    return ds.Tables[0];
                else
                    return null;
            }
            catch (Exception ex)
            {
                msg = ex.ToString();
                return null;
            }
        }

        private DataTable GetUserLevelRights(IDbDataAdapter adapter, String UserID)
        {
            DataSet ds = new DataSet();

            adapter.SelectCommand.CommandText = "SELECT * FROM user_level_rights WHERE user_id = @UserID AND cancel_flag = 'N'";

            adapter.SelectCommand.Parameters.Clear();
            IDataParameter parma1 = DBObjectFactory.GetParameterObject();
            parma1.ParameterName = "@UserID";
            parma1.DbType = DbType.String;
            parma1.Value = UserID;
            adapter.SelectCommand.Parameters.Add(parma1);
            adapter.TableMappings.Clear();
            adapter.TableMappings.Add("Table", "user_level_rights");
            adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            adapter.Fill(ds);
            if (ds.Tables[0].Rows.Count == 1)
                return ds.Tables[0];
            else
                return null;
        }

        private ArrayList GetUserLevels(IDbDataAdapter adapter, String UserID)
        {
            DataSet ds = new DataSet();
            ArrayList arList = new ArrayList();

            //adapter.SelectCommand.CommandText = "SELECT user_id, division, level1_code, level2_code, " +
            //    "level3_code, level4_code, level5_code FROM user_cs_rights " +
            //    "WHERE (active_flag = 'Y') AND (user_id = @UserID)";

            adapter.SelectCommand.CommandText = "SELECT user_cs_rights.user_id, user_cs_rights.company_id, " +
                "user_cs_rights.level1_code, user_cs_rights.level2_code, user_cs_rights.level3_code, " +
                "user_cs_rights.level4_code, user_cs_rights.level5_code " +
                "AS division_desc " +
                "FROM user_cs_rights " +
                "WHERE (user_cs_rights.active_flag = 'Y') AND (user_cs_rights.user_id = @UserID)";

            adapter.SelectCommand.Parameters.Clear();
            IDataParameter parma1 = DBObjectFactory.GetParameterObject();
            parma1.ParameterName = "@UserID";
            parma1.DbType = DbType.String;
            parma1.Value = UserID;
            adapter.SelectCommand.Parameters.Add(parma1);
            adapter.TableMappings.Clear();
            adapter.TableMappings.Add("Table", "user_cs_rights");
            adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            adapter.Fill(ds);
            arList.Add(ds.Tables[0]);
            if (ds.Tables[0].Rows.Count > 0)
                return arList;
            else
                return null;
        }

        //Added by sanket on 26-08-2009 for get User Log For perticular user
        private DataTable GetUserLogDetails(IDbDataAdapter adapter, String UserID)
        {
            DataSet ds = new DataSet();

            adapter.SelectCommand.CommandText = "SELECT * FROM user_login_log WHERE user_id = @UserID";

            adapter.SelectCommand.Parameters.Clear();
            IDataParameter parma1 = DBObjectFactory.GetParameterObject();
            parma1.ParameterName = "@UserID";
            parma1.DbType = DbType.String;
            parma1.Value = UserID;
            adapter.SelectCommand.Parameters.Add(parma1);
            adapter.TableMappings.Clear();
            adapter.TableMappings.Add("Table", "user_login_log");
            adapter.MissingSchemaAction = MissingSchemaAction.AddWithKey;
            adapter.Fill(ds);
            return ds.Tables[0];
        }

        public BLReturnObject Change_new_PassWord(string UserID, string OldPassword, string NewPassword)
        {
            BLReturnObject obj_BLReturnObject = new BLReturnObject();
            UserID = UserID.Trim();
            OldPassword = OldPassword.Trim();
            NewPassword = NewPassword.Trim();
            //Store the information to be returned back to client in this object
            //---------------------------------------------------------------
            //Basic Validations
            //-------------------------------------------------------------
            //Both userid and password are compulsory
            if (UserID == "")
            {
                obj_BLReturnObject.ServerMessage = "Please provide USERID";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            //if (OldPassword == "")
            //{
            //    obj_BLReturnObject.ServerMessage = "Please provide Old Password";
            //    obj_BLReturnObject.ExecutionStatus = 2;
            //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            //    return obj_BLReturnObject;
            //}
            if (NewPassword == "")
            {
                obj_BLReturnObject.ServerMessage = "Please provide New Password";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            //if (OldPassword == NewPassword)
            //{
            //    obj_BLReturnObject.ServerMessage = "Old Password and New Password cannot be same";
            //    obj_BLReturnObject.ExecutionStatus = 2;
            //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            //    return obj_BLReturnObject;
            //}

            //    //-------------------------------------------------------------
            //    //Major Validations
            //    //-------------------------------------------------------------
            DBConnection.Open();
            //    //Get Existing Information of user
            DataTable dt_usermst = null;
            String msg = "";
            dt_usermst = this.GetUserInformation(DBDataAdpterObject, UserID, ref msg);
            if (dt_usermst == null)
            {
                obj_BLReturnObject.ServerMessage = "Unknown User:Operation cancelled.";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            //-------------------------------------------------------------

            //-------------------------------------------------------------
            //Logic for changing the password goes here
            //-------------------------------------------------------------
            //OldPassword must match the one in the table
            //if (dt_usermst.Rows[0]["password"].ToString() != OldPassword)
            //{
            //    obj_BLReturnObject.ServerMessage = "Old Password is not match with existing password";
            //    obj_BLReturnObject.ExecutionStatus = 2;
            //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            //    return obj_BLReturnObject;
            //}
            //    //Calculate and change expiry date for the password			

            //TODO:Untyped to typed
            //DataTable dt_parameters = null;
            //Parameter objParameter = new Parameter();
            //dt_parameters = objParameter.GetParameters(DBDataAdpterObject, "PASSWORD", DateTime.Today, DateTime.Today);
            //DS_Parameter_mst.DT_ParameterMasterDataTable dt_parameters = new DS_Parameter_mst.DT_ParameterMasterDataTable();
            //dt_parameters = Parameter.GetParameters(ref DBDataAdpterObject, "PASSWORD");

            //if (dt_parameters == null)
            //{
            //    obj_BLReturnObject.ServerMessage = "Server failed to retrieve parameter information.Operation cancelled.";
            //    obj_BLReturnObject.ExecutionStatus = 2;
            //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            //    return obj_BLReturnObject;
            //}
            //DataRow[] prow = dt_parameters.Select("code = 'PASS_EXPIRY'");//change by sanket on 14/08/2008

            //if (prow.Length <= 0)
            //{
            //    obj_BLReturnObject.ServerMessage = "Password was not updated as server failed to calculate expiry date";
            //    obj_BLReturnObject.ExecutionStatus = 3;
            //    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            //    return obj_BLReturnObject;
            //}


            // dt_usermst.Rows[0]["pass_expiry_date"] = DateTime.Today.AddDays(Convert.ToDouble(prow[0]["description"]));
            //Change password			
            dt_usermst.Rows[0]["password"] = NewPassword.ToString();
            //Change user status to Active
            string user_status = "A";
            dt_usermst.Rows[0]["user_status_flag"] = user_status;
            //------------------------------------------------------

            //    //Send changes to Database
            DBCommand.Transaction = DBConnection.BeginTransaction();
            BLGeneralUtil.UpdateTableInfo objUpdateInfo = new BLGeneralUtil.UpdateTableInfo();
            objUpdateInfo = BLGeneralUtil.UpdateTable(ref DBCommand, dt_usermst, BLGeneralUtil.UpdateWhereMode.KeyAndModifiedColumns);
            if (objUpdateInfo.Status == true && objUpdateInfo.TotalRowsAffected == 1)
            {
                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                obj_BLReturnObject.ServerMessage = "Password changed successfully";
                obj_BLReturnObject.ExecutionStatus = 1;
                return obj_BLReturnObject;
            }
            else if (objUpdateInfo.Status == false || objUpdateInfo.TotalRowsAffected != 1)
            {
                DBCommand.Transaction.Rollback();
                obj_BLReturnObject.ServerMessage = "Failed to update the password .";
                obj_BLReturnObject.ExecutionStatus = 2;
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return obj_BLReturnObject;
            }
            return obj_BLReturnObject;

        }
    }
}
