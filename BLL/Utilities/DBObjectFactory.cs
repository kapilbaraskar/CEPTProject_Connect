using System;
using System.Data;
using System.Data.OleDb;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections;
using System.Collections.Specialized;
using MySql.Data.MySqlClient;

namespace BLL.Utilities
{
    public class DBObjectFactory
    {
        //private static string connectionString = ConfigurationManager.AppSettings.Get("ConnectionString");
        private static string connectionString = ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ConnectionString;
        //private static string DataSourceType = ConfigurationManager.AppSettings.Get("CurrentDataBase");
        //private static string Provider = "MySql.Data.MySqlClient"; //Provider = ConfigurationManager.ConnectionStrings[0].ProviderName;
        private static string Provider = "System.Data.SqlClient";

        // private static string connectionString = "Data Source=MPRADEEP\\SQL2005;Initial Catalog=SBSSNDPortal;Persist Security Info=True;User ID=sa;Password=m_pradeep2411";
        // private static string Provider = "System.Data.SqlClient";

        public static IDbConnection GetConnectionObject()
        {
            string DataSourceType;

            DataSourceType = ConfigurationManager.AppSettings.Get("CurrentDataBase");
            switch (Provider)
            {
                //case "MySql.Data.MySqlClient":
                case "System.Data.SqlClient":
                    //return new OleDbConnection();
                    //return new MySql.Data.MySqlClient.MySqlConnection();
                    return new System.Data.SqlClient.SqlConnection();
                //case "ORACLE":
                //	return new OracleConnection();					
            }
            return null;
        }

        #region FOR WEB
        //Added by ketan on 21/07/2011

        public static IDbCommand GetCommandObject()
        {
            switch (Provider)
            {
                //case "MySql.Data.MySqlClient":
                case "System.Data.SqlClient":
                  //  return new SqlCommand();
                    //return new MySql.Data.MySqlClient.MySqlCommand();
                    return new System.Data.SqlClient.SqlCommand();
                //case "ORACLE":
                //	return new OracleCommand();
            }
            return null;
        }

        public static IDbDataAdapter GetDataAdapterObject(IDbCommand DBCommand)
        {
            switch (Provider)
            {
                //case "MySql.Data.MySqlClient":
                case "System.Data.SqlClient":
                    return new SqlDataAdapter((SqlCommand)DBCommand);
                    //return new MySql.Data.MySqlClient.MySqlDataAdapter((MySql.Data.MySqlClient.MySqlCommand)DBCommand);
                //case "ORACLE":
                //    return new OracleDataAdapter((OracleCommand)DBCommandObj);					
            }
            return null;
        }

        public static IDataParameter GetParameterObject()
        {
            switch (Provider)
            {
                //case "MySql.Data.MySqlClient":
                case "System.Data.SqlClient":
                    //return new MySql.Data.MySqlClient.MySqlParameter();
                    return new SqlParameter();
                //case "ORACLE":
                //	return new OracleParameter();
            }
            return null;
        }

        #endregion

        internal static object MakeParameter(string p, DbType dbType, string p_2)
        {
            throw new NotImplementedException();
        }

        public static IDataParameter MakeParameter_new(String ParameterName, DbType ParameterType, Object ParameterValue)
        {
            IDataParameter parameter = DBObjectFactory.GetParameterObject();
            parameter.ParameterName = ParameterName;
            parameter.DbType = ParameterType;
            parameter.Value = ParameterValue;
            return parameter;
        }
    }
}
