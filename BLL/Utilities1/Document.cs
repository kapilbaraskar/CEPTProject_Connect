using MySql.Data.MySqlClient;
using System;
using System.Data;
using System.Data.SqlClient;
using BLL.ExtraUtilities1;

namespace BLL.Utilities1
{
    public class Document : ServerBase
    {
        #region Variable Declaration
        IDbDataAdapter adapter = null;
        private const int DOCUMENTNOPORTIONLENGTH = 6;
        #endregion

        #region Constructor & Destructor.
        public Document()
        {
        }
        ~Document()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }
        #endregion

        public Byte GetNextDocumentNo(ref IDbCommand command, String CompanyId, String DocType, DateTime DocDate, ref String DocNo, String UserId, String HostIp, ref String Message)
        {
            Byte result;
            DocTypeMst objDocTypeMst = new DocTypeMst();
            String PeriodYear = String.Empty;

            if (CompanyId == null || CompanyId.Trim() == String.Empty)
                CompanyId = "ALL";

            adapter = new SqlDataAdapter((SqlCommand)command);

            //Check Next Doc No is yearly depended or not
            Boolean IsYearDepended = false;
            result = objDocTypeMst.IsDocType_YearDepended(ref adapter, CompanyId, DocType, ref IsYearDepended, ref Message);
            if (result != 1)
                return result;
            if (IsYearDepended)
            {
                //Retrieve PeriodYear.
                YearMst objYearMst = new YearMst();
                result = objYearMst.GetPeriodYear(ref command, CompanyId, DocDate, ref PeriodYear, ref Message);
                if (result != 1)
                    return result;
            }
            else
                PeriodYear = "ALL";

            adapter.SelectCommand.Parameters.Clear();
            //Retrieve the Next doc No for the given doc type and period year.            
            String SQLSelect = "SELECT    next_doc_no, length, doc_prefix, year_prefix " +
                               "FROM     NextDocNumber " +
                               "WHERE (doc_type = @DocType) AND (period_year = @PeriodYear)";
            if (CompanyId != null && CompanyId.Trim() != String.Empty)
            {
                SQLSelect += " AND (company_id = @CompanyId)";
                command.Parameters.Add(DBObjectFactory.MakeParameter("@CompanyId", DbType.String, CompanyId));
            }

            adapter.SelectCommand.CommandText = SQLSelect;
            adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@DocType", DbType.String, DocType));
            adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@PeriodYear", DbType.String, PeriodYear));
            adapter.TableMappings.Clear();
            adapter.TableMappings.Add("Table", "nextdocno");
            DataSet ds = new DataSet();
            adapter.Fill(ds);

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                int TempDocNo = Convert.ToInt32(ds.Tables[0].Rows[0]["next_doc_no"].ToString());
                int MaxLength = Convert.ToInt32(ds.Tables[0].Rows[0]["length"].ToString());
                String DocPrefix = ds.Tables[0].Rows[0]["doc_prefix"].ToString();
                String YearPrefix = ds.Tables[0].Rows[0]["year_prefix"].ToString();

                command.Parameters.Clear();
                String SQLUpdate = "UPDATE NextDocNumber SET next_doc_no=@NextDocNo, last_modified_date=@LastModifiedDate, last_modified_by=@LastModifiedBy, last_modified_host=@LastModifiedHost " +
                                   "WHERE doc_type=@DocType AND period_year=@PeriodYear";

                if (CompanyId != null && CompanyId != string.Empty)
                {
                    SQLUpdate += " AND company_id = @CompanyId";
                    command.Parameters.Add(DBObjectFactory.MakeParameter("@CompanyId", DbType.String, CompanyId));
                }

                command.CommandText = SQLUpdate;
                command.Parameters.Add(DBObjectFactory.MakeParameter("@NextDocNo", DbType.Int32, TempDocNo + 1));
                command.Parameters.Add(DBObjectFactory.MakeParameter("@LastModifiedDate", DbType.DateTime, DateTime.Now));
                command.Parameters.Add(DBObjectFactory.MakeParameter("@LastModifiedBy", DbType.String, UserId));
                command.Parameters.Add(DBObjectFactory.MakeParameter("@LastModifiedHost", DbType.String, HostIp));
                command.Parameters.Add(DBObjectFactory.MakeParameter("@DocType", DbType.String, DocType));
                command.Parameters.Add(DBObjectFactory.MakeParameter("@PeriodYear", DbType.String, PeriodYear));

                try
                {
                    if (command.ExecuteNonQuery() <= 0)
                    {
                        Message = "No Document Number Defined for the Transaction DocType : " + DocType;
                        return 2;
                    }
                }
                catch (Exception ex)
                {
                    Message = "Error Updating the Document Number" + Environment.NewLine + ex.Message;
                    Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                    DocNo = null;
                    return 2;
                }

                //Append zeros at the begining of the docno to make it formated DocNo            
                int Length = TempDocNo.ToString().Length;

                int TempCalc = MaxLength - Length;

                String Zeros = String.Empty;
                for (int i = 1; i <= TempCalc; i++)
                    Zeros += "0";

                DocNo = DocPrefix + YearPrefix + Zeros + TempDocNo;
                result = 1;
            }
            else
            {
                Message = "No Document Number Defined for the Transaction DocType : " + DocType;
                result = 2;
            }

            return result;
        }

        public Boolean W_GetNextDocumentNo(ref IDbCommand comm, String sa_id, String DocumentType, String UserID, String HostName, ref String NextDocumentNo, ref String Message)
        {
            sa_id = "01";

            comm.CommandText = " SELECT next_doc_no FROM next_doc_no WHERE " +
                                " company_id = @sa_id AND " +
                                " doc_type = @document_type";

            comm.Parameters.Clear();

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@sa_id";
            para1.DbType = DbType.String;
            para1.Value = sa_id;
            comm.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@document_type";
            para2.DbType = DbType.String;
            para2.Value = DocumentType;
            comm.Parameters.Add(para2);

            Object objRetVal = null;
            Decimal doc_no;
            //MessageBox.Show("Before getting the next document no");
            objRetVal = comm.ExecuteScalar();
            if (objRetVal != null)
                doc_no = Convert.ToDecimal(objRetVal);
            else
                doc_no = 0;

            if (doc_no <= 0)
            {
                Message = "An error occured while getting next document number for Document Type " + DocumentType + ".";
                return false;
            }

            //comm.CommandText = " UPDATE next_doc_no SET next_doc_no = next_doc_no + 1, " +
            //                    " last_modified_by = @UserId, last_modified_date = @AsOn," +
            //                    " last_modified_host = @HostName WHERE " +
            //                    " next_doc_no = @sa_id AND " +
            //                    " doc_type = @document_type AND next_doc_no = @doc_no";

            comm.CommandText = " UPDATE next_doc_no SET next_doc_no = next_doc_no + 1, " +
                             " last_modified_by = @UserId, last_modified_date = @AsOn," +
                             " last_modified_host = @HostName WHERE " +
                             " company_id = @sa_id AND " +
                             " doc_type = @document_type AND next_doc_no = @doc_no";

            IDataParameter para3 = DBObjectFactory.GetParameterObject();
            para3.ParameterName = "@doc_no";
            para3.DbType = DbType.Decimal;
            para3.Value = doc_no;
            comm.Parameters.Add(para3);

            IDataParameter para4 = DBObjectFactory.GetParameterObject();
            para4.ParameterName = "@UserId";
            para4.DbType = DbType.String;
            para4.Value = UserID;
            comm.Parameters.Add(para4);

            IDataParameter para5 = DBObjectFactory.GetParameterObject();
            para5.ParameterName = "@AsOn";
            para5.DbType = DbType.DateTime;
            para5.Value = DateTime.Now;
            comm.Parameters.Add(para5);

            IDataParameter para6 = DBObjectFactory.GetParameterObject();
            para6.ParameterName = "@HostName";
            para6.DbType = DbType.String;
            para6.Value = HostName;
            comm.Parameters.Add(para6);

            //MessageBox.Show("Before updating the document no");
            if (comm.ExecuteNonQuery() <= 0)
            {
                Message = "An error occured while Updating next document number for Document Type " + DocumentType + ".";
                return false;
            }

            NextDocumentNo = FormatDocumentNo(DocumentType, doc_no);
            //MessageBox.Show("Document no is " + NextDocumentNo);
            return true;
        }

        private String FormatDocumentNo(String DocumentType, Decimal doc_no)
        {
            //temporarily we have applied following logic to generate ipd,opd and private services numbers
            //in future it will be customezed and for that we need one table for this parameters.

            //right now it will work as follow.
            //e.g. for ipd it will be I050600001
            //here I indicates this number is for Ipd
            //next 4 digits 0506 indicates year duration
            //and last 6 digits indicates sr.no.            
            String FormattedNo = "";
            //Document Type 1 char
            FormattedNo = DocumentType.Substring(0, 1);
            //Current Year 2 chars

            String year = System.DateTime.Today.Year.ToString();
            FormattedNo += year.Substring(2);
            year = System.DateTime.Today.AddYears(1).Year.ToString().Substring(2);
            //next year 2 chars
            FormattedNo += year;

            int LengthOfCurrentDocNo = doc_no.ToString().Length;
            for (int i = 1; i <= DOCUMENTNOPORTIONLENGTH - LengthOfCurrentDocNo; i++)
                FormattedNo += "0";
            FormattedNo += doc_no.ToString();

            return FormattedNo;
        }
    }
}