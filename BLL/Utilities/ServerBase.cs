using System;
using System.Data;
using System.Configuration;
using BLL.Utilities;

namespace BLL.Utilities 
{
    public class ServerBase : IDisposable
    {
        protected IDbConnection DBConnection;

        protected IDbConnection DBConnection1;

        #region FOR WEB USE
        //added by ketan on 21/07/2011
        protected IDbTransaction DBTransactionObject = null;
        protected IDbCommand DBCommand;
        protected IDbDataAdapter DBDataAdpterObject;
        #endregion

        public ServerBase()
        {
            
            DBConnection = DBObjectFactory.GetConnectionObject();
            DBConnection.ConnectionString = ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ToString();
            DBCommand = DBObjectFactory.GetCommandObject();
            DBCommand.Connection = DBConnection;
            DBDataAdpterObject = DBObjectFactory.GetDataAdapterObject(DBCommand);
            DBDataAdpterObject.SelectCommand.CommandTimeout = 60;
         
        }

        public void Dispose()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }

        //~ServerBase()
        //{
        //    if (DBConnection != null)
        //    {
        //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
        //    }
        //}


    }
}
