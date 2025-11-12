using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BLL.Utilities1;
using System.Text;
using System.Data;

namespace BLL.ExtraUtilities1
{
    public class GeneralOperations : ServerBase
    {
        public bool DeleteData(ref IDbCommand command, string TableName, Dictionary<string, object> WhereCriteria, ref string message)
        {
            StringBuilder sql = new StringBuilder();

            if (!(WhereCriteria.Keys.Count > 0)) { message = "please provide where criteria."; return false; }

            sql.Append("DELETE FROM " + TableName + " WHERE ");

            int i = 0;
            foreach (string key in WhereCriteria.Keys)
            {
                sql.Append("" + key + "='" + WhereCriteria[key].ToString() + "'");
                if (i < WhereCriteria.Keys.Count - 1)
                {
                    sql.Append(" AND ");
                }
                i++;
            }

            command.CommandText = sql.ToString();

            if (command.ExecuteNonQuery() >= 0)
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