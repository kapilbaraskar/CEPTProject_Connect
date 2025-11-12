using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BLL.Utilities1;
using System.Data;

namespace BLL.ExtraUtilities1
{
    public class DocTypeMst : ServerBase
    {
        public Boolean IsYearDepended(ref IDbCommand command, String CompanyId, String DocType, ref String Message)
        {
            String SQLSelect = "SELECT    is_year_dependent " +
                               "FROM     DocTypeMst " +
                               "WHERE    (company_id = @CompanyId) AND (doc_type = @DocType) AND (status = 'A')";
            command.Parameters.Clear();
            command.CommandText = SQLSelect;
            command.Parameters.Add(DBObjectFactory.MakeParameter("@CompanyId", DbType.String, CompanyId));
            command.Parameters.Add(DBObjectFactory.MakeParameter("@DocType", DbType.String, DocType));
            Object objIsYearDepended = command.ExecuteScalar();
            if (objIsYearDepended != null)
            {
                if (objIsYearDepended.ToString() == Constant.YES)
                    return true;
                else
                    return false;
            }
            else
            {
                Message = "No Document Type is defined for the Transaction DocType : " + DocType;
                return false;
            }
        }

        public Byte IsDocType_YearDepended(ref IDbDataAdapter adapter, String CompanyId, String DocType, ref Boolean IsYearDepended, ref String Message)
        {
            Byte result;
            String SQLSelect = "SELECT    is_year_dependent " +
                               "FROM     DocTypeMst " +
                               "WHERE    (company_id = @CompanyId) AND (doc_type = @DocType) AND (status = 'A')";
            adapter.SelectCommand.Parameters.Clear();
            adapter.SelectCommand.CommandText = SQLSelect;
            adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@CompanyId", DbType.String, CompanyId));
            adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@DocType", DbType.String, DocType));
            adapter.TableMappings.Clear();
            adapter.TableMappings.Add("Table", "DocTypeMst");
            DataSet ds = new DataSet();
            adapter.Fill(ds);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                String strIsYearDepended = ds.Tables[0].Rows[0]["is_year_dependent"].ToString();
               
                if (strIsYearDepended != null && strIsYearDepended.Trim() != String.Empty)
                {
                    if (strIsYearDepended == Constant.YES)
                        IsYearDepended = true;
                    else
                        IsYearDepended = false;
                }
                else
                    IsYearDepended = false;

                result = 1;
            }
            else
            {
                Message = "No Document Type is defined for the Transaction DocType : " + DocType;
                result = 2;
            }

            return result;
        }
    }
}