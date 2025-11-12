using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BLL.Utilities1;
using System.Data;
using System.Text;

namespace BLL.ExtraUtilities1
{
    public class YearMst : ServerBase
    {
        public Byte GetPeriodYear(ref IDbCommand command, String CompanyId, DateTime DocDate, ref String PeriodYear, ref String Message)
        {
            String SQLSelect = "SELECT    year_desc " +
                               "FROM     YearMst " +
                               "WHERE    (company_id = @CompanyId) AND (start_date <= @DocDate) AND (end_date >= @DocDate)";
            command.Parameters.Clear();
            command.CommandText = SQLSelect;
            command.Parameters.Add(DBObjectFactory.MakeParameter("@CompanyId", DbType.String, CompanyId));
            command.Parameters.Add(DBObjectFactory.MakeParameter("@DocDate", DbType.DateTime, DocDate));
            Object objPeriodYear = command.ExecuteScalar();
            if (objPeriodYear != null)
            {
                PeriodYear = objPeriodYear.ToString();
                return 1;
            }
            else
            {
                Message = "No Period Year is defined for the Transaction DocDate : " + DocDate.ToString("dd-MMM-yyyy");
                return 2;
            }
        }

        public Byte GetYearCode(ref IDbDataAdapter adapter, String CompanyId, DateTime FromDate, ref String YearCode, ref DateTime YearStartDate, ref DateTime PreviousMonthEndDate, ref String Message)
        {
            StringBuilder SQLSelect = new StringBuilder();
            SQLSelect.Append("SELECT    year_code, year_desc, start_date, end_date ");
            SQLSelect.Append("FROM     YearMst ");
            SQLSelect.Append("WHERE    (company_id = @CompanyId) AND (start_date <= @FromDate) AND (end_date >= @FromDate)");
            adapter.SelectCommand.Parameters.Clear();
            adapter.SelectCommand.CommandText = SQLSelect.ToString();
            adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@CompanyId", DbType.String, CompanyId));
            adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@FromDate", DbType.DateTime, FromDate));
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
            {
                YearCode = ds.Tables[0].Rows[0]["year_code"].ToString();
                YearStartDate = Convert.ToDateTime(ds.Tables[0].Rows[0]["start_date"].ToString());
                PreviousMonthEndDate = FromDate.AddDays(-1);
                Message = "Year detail retrieved successfully.";
                return 1;
            }
            else
            {
                Message = "Year detail not found.";
                return 2;
            }
        }
    }
}