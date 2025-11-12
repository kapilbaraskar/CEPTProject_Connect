
namespace BLL.Utilities1
{
    public class SessionMst : ServerBase
    {
        //public String RegisterNewSession(String UserId, String HostIp, String SessionId, ref String Message)
        //{
        //    try
        //    {
        //        DBConnection.Open();

        //        String SQLSelect = "SELECT * " +
        //                           "FROM sessionmst " +
        //                           "WHERE UserId=@UserId AND HostIp=@HostIp AND SessionId=@SessionId AND  IsActive='Y'";

        //        DBDataAdpterObject.SelectCommand.CommandText = SQLSelect;
        //        MySql.Data.MySqlClient.MySqlCommandBuilder Builder = new MySql.Data.MySqlClient.MySqlCommandBuilder((MySql.Data.MySqlClient.MySqlDataAdapter)DBDataAdpterObject);
        //        DBDataAdpterObject.SelectCommand.Parameters.Clear();

        //        DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@UserId", System.Data.DbType.String, UserId));
        //        DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@HostIp", System.Data.DbType.String, HostIp));
        //        DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@SessionId", System.Data.DbType.String, SessionId));
        //        DataSet ds = new DataSet();
        //        DBDataAdpterObject.TableMappings.Clear();
        //        DBDataAdpterObject.TableMappings.Add("Table", "sessionmst");
        //        DBDataAdpterObject.Fill(ds);
        //        if (ds.Tables[0].Rows.Count <= 0)
        //        {
        //            lock (typeof(SessionMst))
        //            {

        //                DataRow dr = ds.Tables[0].NewRow();

        //                dr["UserId"] = UserId;
        //                dr["HostIp"] = HostIp;
        //                dr["SessionId"] = SessionId;
        //                dr["CreateDateTime"] = DateTime.Now;
        //                dr["LastActivityDateTime"] = DateTime.Now;
        //                dr["IsActive"] = "Y";
        //                ds.Tables[0].Rows.Add(dr);


        //                DBCommand.Transaction = DBConnection.BeginTransaction();


        //                if (DBDataAdpterObject.Update(ds) <= 0)
        //                {
        //                    DBCommand.Transaction.Rollback();
        //                    Message = "Unable to generate New Session for User : " + UserId + " HostIp : " + HostIp;
        //                    return null;
        //                }
        //                else
        //                {
        //                    DBCommand.Transaction.Commit();
        //                    Message = "New Session generated successfully for User : " + UserId + " HostIp : " + HostIp;
        //                    return SessionId;
        //                }
        //            }
        //        }
        //        else //Session already exists in SessionMst
        //        {
        //            ds.Tables[0].Rows[0]["CreateDateTime"] = DateTime.Now;
        //            ds.Tables[0].Rows[0]["LastActivityDateTime"] = DateTime.Now;
        //            ds.Tables[0].Rows[0]["IsActive"] = "Y";

        //            ds.Tables[0].PrimaryKey = new DataColumn[] { ds.Tables[0].Columns["SrNo"], ds.Tables[0].Columns["CompanyId"], ds.Tables[0].Columns["UserId"], ds.Tables[0].Columns["SessionId"] };

        //            DBCommand.Transaction = DBConnection.BeginTransaction();


        //            if (DBDataAdpterObject.Update(ds) <= 0)
        //            {
        //                DBCommand.Transaction.Rollback();
        //                Message = "Session already exists, Unable to update Last Activity DateTime for User : " + UserId + " HostIp : " + HostIp;
        //                return null;
        //            }
        //            else
        //            {
        //                DBCommand.Transaction.Commit();
        //                Message = "Session already exists, Last Activity DateTime updated successfully for User : " + UserId + " HostIp : " + HostIp;
        //                return ds.Tables[0].Rows[0]["SessionId"].ToString();
        //            }
        //        }
        //    }
        //    catch (DBConcurrencyException ex)
        //    {
        //        DBCommand.Transaction.Rollback();
        //        Message = "An Error occurred, while generate new Session.";
        //        Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
        //        return null;
        //    }
        //    catch (Exception ex)
        //    {
        //        DBCommand.Transaction.Rollback();
        //        Message = "An Error occurred, while generate new Session.";
        //        Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
        //        return null;
        //    }
        //    finally
        //    {
        //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //    }
        //}

        //public Boolean DeactivateSession(String UserId, String HostIp, string SessionId, ref String Message)
        //{
        //    try
        //    {

        //        DBConnection.Open();


        //        String SQLSelect = "SELECT * " +
        //                           "FROM sessionmst " +
        //                           "WHERE  UserId=@UserId AND HostIp=@HostIp AND IsActive='Y' AND SessionId=@SessionId";
        //        DBDataAdpterObject.SelectCommand.CommandText = SQLSelect;
        //        MySql.Data.MySqlClient.MySqlCommandBuilder Builder = new MySql.Data.MySqlClient.MySqlCommandBuilder((MySql.Data.MySqlClient.MySqlDataAdapter)DBDataAdpterObject);
        //        DBDataAdpterObject.SelectCommand.Parameters.Clear();

        //        DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@UserId", System.Data.DbType.String, UserId));
        //        DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@HostIp", System.Data.DbType.String, HostIp));
        //        DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@SessionId", System.Data.DbType.String, SessionId));
        //        DataSet ds = new DataSet();
        //        DBDataAdpterObject.TableMappings.Clear();
        //        DBDataAdpterObject.TableMappings.Add("Table", "sessionmst");
        //        DBDataAdpterObject.Fill(ds);
        //        if (ds.Tables[0].Rows.Count > 0)
        //        {

        //            ds.Tables[0].AcceptChanges();

        //            ds.Tables[0].Rows[0].Delete();

        //            DBCommand.Transaction = DBConnection.BeginTransaction();

        //            if (DBDataAdpterObject.Update(ds) <= 0)
        //            {
        //                DBCommand.Transaction.Rollback();
        //                Message = "Unable to deactivete session for SessionId : " + SessionId + " User : " + UserId + " HostIp : " + HostIp;
        //                return false;
        //            }
        //            else
        //            {
        //                DBCommand.Transaction.Commit();
        //                Message = "Session deactiveted successfully for SessionId : " + SessionId + " User : " + UserId + " HostIp : " + HostIp;

        //                return true;
        //            }
        //        }
        //        else
        //            return true;

        //    }
        //    catch (Exception ex)
        //    {
        //        Message = "Unable to deactivete session for SessionId : " + SessionId + " User : " + UserId + " HostIp : " + HostIp;
        //        Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
        //        return false;
        //    }
        //}
    }
}