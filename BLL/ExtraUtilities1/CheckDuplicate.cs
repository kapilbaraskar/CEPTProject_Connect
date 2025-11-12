using System;
using System.Data;
using BLL.Utilities1;

namespace BLL.ExtraUtilities1
{
    public class CheckDuplicate
    {
        public bool CheckDuplicateData(ref IDbDataAdapter adapter, string TableName, string[] ColumnNames, string[] ColumnValues)
        {
            adapter.SelectCommand.Parameters.Clear();
            String SQLSelect = "";
            TableName = TableName.ToLower();
            SQLSelect = "SELECT * FROM " + TableName + " WHERE 1=1 ";

            if (ColumnNames != null && ColumnValues != null && ColumnNames.Length > 0 && ColumnValues.Length > 0 && ColumnValues.Length == ColumnNames.Length)
            {
                for (int i = 0; i < ColumnNames.Length; i++)
                {
                    SQLSelect += " AND " + ColumnNames[i] + "=@" + ColumnNames[i];
                    adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@" + ColumnNames[i], DbType.String, ColumnValues[i]));
                }
            }

            adapter.SelectCommand.CommandText = SQLSelect;
            adapter.TableMappings.Clear();
            adapter.TableMappings.Add("Table", TableName);
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                return true;
            }
            else
            {
                return false;
            }

        }
    }
}