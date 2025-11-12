

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using BLL.Utilities;
using XSD.Masters;
using System.Reflection;


namespace BLL.Master
{
    public class Adani : ServerBase
    {
        Document objDocument = new Document();

        

        internal int a()
        {
            return 1;
        }


       

        public bool CheckDuplicate(String ColumnName, String TableName, String Value, String ColumnName2, String Value2)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "Select " + ColumnName + " from " + TableName + " where " + ColumnName + "= '" + Value + "'";

            // if where condition with second column
            if (ColumnName2 != "" && Value2 != "")
            {
                SqlSelect += " AND " + ColumnName2 + "= '" + Value2 + "'";
            }


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return false;
                else
                    return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }

    partial class  a
    {
        public void kamlesh(string a)
        { 
        
        }
    }
    partial class a
    {
        public void kamlesh()
        {

        }
    }
}
