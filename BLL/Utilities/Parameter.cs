using System;
using System.Data;
using System.Collections.Generic;
using System.Text;
using XSD.General;
  
namespace BLL.Utilities
{
    class Parameter
    {
        ////Darshak function
        //public DataTable GetParameters(IDbDataAdapter adapter, String ParameterName, DateTime From_Date, DateTime To_Date)
        //{            
        //    DataSet ds = new DataSet();           
        //    adapter.SelectCommand.CommandText = "SELECT param_key,param_value FROM param_mst WHERE(param_code = @parameter )";// AND( parameter_mst.start_date <= @from_date ) AND( parameter_mst.end_date >= @to_date OR parameter_mst.end_date IS NULL)";

        //    IDataParameter parma1 = DBObjectFactory.GetParameterObject();
        //    parma1.ParameterName = "@parameter";  
        //    parma1.DbType = DbType.String;
        //    parma1.Value = ParameterName;

        //    adapter.SelectCommand.Parameters.Clear();
        //    adapter.SelectCommand.Parameters.Add(parma1);
           
        //    adapter.Fill(ds);
            
        //    if (ds.Tables[0].Rows.Count > 0)
        //        return ds.Tables[0];
        //    else
        //        return null;            

        //}
        
        public static DS_Parameter_mst.DT_ParameterMasterDataTable GetParameters(ref IDbDataAdapter Adapter, String ParameterName)
        {
            DS_Parameter_mst ds = new DS_Parameter_mst();

            //Query Change by sanket on 14/08/2008
            Adapter.SelectCommand.CommandText = "SELECT parameter,code,description FROM parameter_mst WHERE(parameter = @parameter) ORDER BY code";// AND( parameter_mst.start_date <= @from_date ) AND( parameter_mst.end_date >= @to_date OR parameter_mst.end_date IS NULL)";

            IDataParameter parma1 = DBObjectFactory.GetParameterObject();
            parma1.ParameterName = "@parameter";
            parma1.DbType = DbType.String;
            parma1.Value = ParameterName;

            Adapter.TableMappings.Clear();
            Adapter.TableMappings.Add("Table", ds.DT_ParameterMaster.TableName);
            Adapter.SelectCommand.Parameters.Clear();
            Adapter.SelectCommand.Parameters.Add(parma1);

            try
            {
                Adapter.Fill(ds);
            }
            catch
            {
                return null;
            }

            if (ds.DT_ParameterMaster.Rows.Count > 0)
                return ds.DT_ParameterMaster;
            else
                return null;
        }
        public static byte GetParameter(String[] ParameterKey, ref IDbDataAdapter objDataAdapter, ref DS_Parameter_mst param_mst, ref String msg)
        {            
            String ParameterKeyList = "";
            for (int i = 0; i < ParameterKey.Length; i++)
            {
                ParameterKeyList += "'" + ParameterKey[i] + "'";
                if (i < ParameterKey.Length - 1)
                    ParameterKeyList += ",";
            }
            //objDataAdapter.SelectCommand.CommandText = "SELECT * FROM param_mst WHERE param_key in (" + ParameterKeyList + ")";
            objDataAdapter.SelectCommand.CommandText = "SELECT * FROM parameter_mst WHERE code in (" + ParameterKeyList + ")";

            objDataAdapter.SelectCommand.Parameters.Clear();

            objDataAdapter.TableMappings.Clear();
            objDataAdapter.TableMappings.Add("Table", param_mst.DT_ParameterMaster.TableName);
            objDataAdapter.Fill(param_mst);            
            msg = "Parameters retrieved successfully.";
            return 1;
        }
    }
}
