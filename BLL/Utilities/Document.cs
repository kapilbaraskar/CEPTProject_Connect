using System;
using System.Collections.Generic;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using BLL.Utilities;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;


namespace BLL.Utilities
{
    public class Document : ServerBase
    {
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

        private const int DOCUMENTNOPORTIONLENGTH = 6;

        #region For Sql Serevr
        //#region GetNextDocNo

        //public Boolean W_GetNextDocumentNo(ref IDbCommand comm, String sa_id, String DocumentType, String UserID, String HostName, ref String NextDocumentNo, ref String Message)
        //{
        //    sa_id = "01";

        //    comm.CommandText = " SELECT next_doc_no FROM next_doc_no WHERE " +
        //                        " company_id = @sa_id AND " +
        //                        " doc_type = @document_type";

        //    comm.Parameters.Clear();

        //    IDataParameter para1 = DBObjectFactory.GetParameterObject();
        //    para1.ParameterName = "@sa_id";
        //    para1.DbType = DbType.String;
        //    para1.Value = sa_id;
        //    comm.Parameters.Add(para1);

        //    IDataParameter para2 = DBObjectFactory.GetParameterObject();
        //    para2.ParameterName = "@document_type";
        //    para2.DbType = DbType.String;
        //    para2.Value = DocumentType;
        //    comm.Parameters.Add(para2);

        //    Object objRetVal = null;
        //    Decimal doc_no;
        //    //MessageBox.Show("Before getting the next document no");
        //    objRetVal = comm.ExecuteScalar();
        //    if (objRetVal != null)
        //        doc_no = Convert.ToDecimal(objRetVal);
        //    else
        //        doc_no = 0;

        //    if (doc_no <= 0)
        //    {
        //        Message = "An error occured while getting next document number for Document Type " + DocumentType + ".";
        //        return false;
        //    }

        //    //comm.CommandText = " UPDATE next_doc_no SET next_doc_no = next_doc_no + 1, " +
        //    //                    " last_modified_by = @UserId, last_modified_date = @AsOn," +
        //    //                    " last_modified_host = @HostName WHERE " +
        //    //                    " next_doc_no = @sa_id AND " +
        //    //                    " doc_type = @document_type AND next_doc_no = @doc_no";

        //    comm.CommandText = " UPDATE next_doc_no SET next_doc_no = next_doc_no + 1, " +
        //                     " last_modified_by = @UserId, last_modified_date = @AsOn," +
        //                     " last_modified_host = @HostName WHERE " +
        //                     " company_id = @sa_id AND " +
        //                     " doc_type = @document_type AND next_doc_no = @doc_no";

        //    IDataParameter para3 = DBObjectFactory.GetParameterObject();
        //    para3.ParameterName = "@doc_no";
        //    para3.DbType = DbType.Decimal;
        //    para3.Value = doc_no;
        //    comm.Parameters.Add(para3);

        //    IDataParameter para4 = DBObjectFactory.GetParameterObject();
        //    para4.ParameterName = "@UserId";
        //    para4.DbType = DbType.String;
        //    para4.Value = UserID;
        //    comm.Parameters.Add(para4);

        //    IDataParameter para5 = DBObjectFactory.GetParameterObject();
        //    para5.ParameterName = "@AsOn";
        //    para5.DbType = DbType.DateTime;
        //    para5.Value = DateTime.Now;
        //    comm.Parameters.Add(para5);

        //    IDataParameter para6 = DBObjectFactory.GetParameterObject();
        //    para6.ParameterName = "@HostName";
        //    para6.DbType = DbType.String;
        //    para6.Value = HostName;
        //    comm.Parameters.Add(para6);

        //    //MessageBox.Show("Before updating the document no");
        //    if (comm.ExecuteNonQuery() <= 0)
        //    {
        //        Message = "An error occured while Updating next document number for Document Type " + DocumentType + ".";
        //        return false;
        //    }

        //    NextDocumentNo = FormatDocumentNo(DocumentType, doc_no);
        //    //MessageBox.Show("Document no is " + NextDocumentNo);
        //    return true;
        //}

        //private String FormatDocumentNo(String DocumentType, Decimal doc_no)
        //{
        //    //temporarily we have applied following logic to generate ipd,opd and private services numbers
        //    //in future it will be customezed and for that we need one table for this parameters.

        //    //right now it will work as follow.
        //    //e.g. for ipd it will be I050600001
        //    //here I indicates this number is for Ipd
        //    //next 4 digits 0506 indicates year duration
        //    //and last 6 digits indicates sr.no.            
        //    String FormattedNo = "";
        //    //Document Type 1 char
        //    FormattedNo = DocumentType.Substring(0, 1);
        //    //Current Year 2 chars

        //    String year = System.DateTime.Today.Year.ToString();
        //    FormattedNo += year.Substring(2);
        //    year = System.DateTime.Today.AddYears(1).Year.ToString().Substring(2);
        //    //next year 2 chars
        //    FormattedNo += year;

        //    int LengthOfCurrentDocNo = doc_no.ToString().Length;
        //    for (int i = 1; i <= DOCUMENTNOPORTIONLENGTH - LengthOfCurrentDocNo; i++)
        //        FormattedNo += "0";
        //    FormattedNo += doc_no.ToString();

        //    return FormattedNo;
        //}

        //#endregion

        //#region GetNextDocNo_FinancialYearWise

        //public Boolean W_GetNextDocumentNo_financial(ref IDbCommand comm, String sa_id, String DocumentType, String UserID, String HostName, ref String NextDocumentNo, ref String Message, DateTime docdate)
        //{
        //    //string company = sa_id;
        //    // sa_id = "01";

        //    string query = @"select * from year_definition where startdate <= '" + docdate + "' and enddate >= '" + docdate + "'";
        //    //string query = @"select * from year_Definition where flag='Y'";
        //  //  string connectionString = @"Server=mitesh\sqlexpress;Database=cadlive11-4-2012;Integrated Security=True;Pooling=False";
        //  //  string connectionString = @"Server=CONTADMIN;Initial Catalog=cadlive;Persist Security Info=True;User ID=sa;Password=Adanipmc2011$;Max Pool Size=200";

        //    string connectionString = ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ConnectionString;
        //  //  conn.ConnectionString = connString;
        //   /SqlConnection myConnection = new SqlConnection(connectionString);


        //    SqlDataAdapter ad = new SqlDataAdapter(query, myConnection);

        //    DataSet ds1 = new DataSet();

        //    ad.Fill(ds1);
        //    DataTable dtdoc = ds1.Tables[0];
        //    String sr_no1 = "";
        //    String yeardef = "";
        //    if (dtdoc != null)
        //    {
        //        if (dtdoc.Rows.Count > 0)
        //        {
        //            //DateTime stdt = Convert.ToDateTime(dtdoc.Rows[0]["startdate"].ToString());

        //            //DateTime enddt = Convert.ToDateTime(dtdoc.Rows[0]["enddate"].ToString());

        //            yeardef = dtdoc.Rows[0]["year"].ToString();
        //            sr_no1 = dtdoc.Rows[0]["sr_number"].ToString();
        //        }
        //        else
        //        {
        //            Message = "There is No Financial Year Entered in the System";
        //            return false;
        //        }
        //    }
        //    else
        //    {
        //        Message = "There is No Financial Year Entered in the System";
        //        return false;

        //    }
        //    comm.CommandText = " SELECT next_doc_no FROM next_doc_no WHERE " +
        //                        " company_id = @sa_id AND " +
        //                        " doc_type = @document_type AND year_defin=@sr_no1";

        //    comm.Parameters.Clear();

        //    IDataParameter para1 = DBObjectFactory.GetParameterObject();
        //    para1.ParameterName = "@sa_id";
        //    para1.DbType = DbType.String;
        //    para1.Value = sa_id;
        //    comm.Parameters.Add(para1);

        //    IDataParameter para2 = DBObjectFactory.GetParameterObject();
        //    para2.ParameterName = "@document_type";
        //    para2.DbType = DbType.String;
        //    para2.Value = DocumentType;
        //    comm.Parameters.Add(para2);

        //    IDataParameter para31 = DBObjectFactory.GetParameterObject();
        //    para31.ParameterName = "@sr_no1";
        //    para31.DbType = DbType.String;
        //    para31.Value = sr_no1;
        //    comm.Parameters.Add(para31);

        //    Object objRetVal = null;
        //    Decimal doc_no;
        //    //MessageBox.Show("Before getting the next document no");
        //    objRetVal = comm.ExecuteScalar();
        //    if (objRetVal != null)
        //        doc_no = Convert.ToDecimal(objRetVal);
        //    else
        //        doc_no = 0;

        //    if (doc_no <= 0)
        //    {
        //        Message = "An error occured while getting next document number for Document Type " + DocumentType + ".";
        //        return false;
        //    }

        //    //comm.CommandText = " UPDATE next_doc_no SET next_doc_no = next_doc_no + 1, " +
        //    //                    " last_modified_by = @UserId, last_modified_date = @AsOn," +
        //    //                    " last_modified_host = @HostName WHERE " +
        //    //                    " next_doc_no = @sa_id AND " +
        //    //                    " doc_type = @document_type AND next_doc_no = @doc_no";

        //    comm.CommandText = " UPDATE next_doc_no SET next_doc_no = next_doc_no + 1, " +
        //                     " last_modified_by = @UserId, last_modified_date = @AsOn," +
        //                     " last_modified_host = @HostName WHERE " +
        //                     " company_id = @sa_id AND " +
        //                     " doc_type = @document_type AND next_doc_no = @doc_no AND year_defin=@sr_no1";

        //    IDataParameter para3 = DBObjectFactory.GetParameterObject();
        //    para3.ParameterName = "@doc_no";
        //    para3.DbType = DbType.Decimal;
        //    para3.Value = doc_no;
        //    comm.Parameters.Add(para3);

        //    IDataParameter para4 = DBObjectFactory.GetParameterObject();
        //    para4.ParameterName = "@UserId";
        //    para4.DbType = DbType.String;
        //    para4.Value = UserID;
        //    comm.Parameters.Add(para4);

        //    IDataParameter para5 = DBObjectFactory.GetParameterObject();
        //    para5.ParameterName = "@AsOn";
        //    para5.DbType = DbType.DateTime;
        //    para5.Value = DateTime.Now;
        //    comm.Parameters.Add(para5);

        //    IDataParameter para6 = DBObjectFactory.GetParameterObject();
        //    para6.ParameterName = "@HostName";
        //    para6.DbType = DbType.String;
        //    para6.Value = HostName;
        //    comm.Parameters.Add(para6);

        //    //MessageBox.Show("Before updating the document no");
        //    if (comm.ExecuteNonQuery() <= 0)
        //    {
        //        Message = "An error occured while Updating next document number for Document Type " + DocumentType + ".";
        //        return false;
        //    }

        //  //  comm.Transaction.Commit();

        //    //comm.Connection.Open();
        //    NextDocumentNo = FormatDocumentNo_financial(DocumentType, doc_no, sa_id, yeardef);
        //    //MessageBox.Show("Document no is " + NextDocumentNo);
        //    if (NextDocumentNo == "No")
        //    {
        //        return false;
        //    }
        //    else
        //    {
        //        return true;
        //    }
        //}

        //private String FormatDocumentNo_financial(String DocumentType, Decimal doc_no, String sa_id,  String yearprifix)
        //{
        //    //temporarily we have applied following logic to generate ipd,opd and private services numbers
        //    //in future it will be customezed and for that we need one table for this parameters.

        //    //right now it will work as follow.
        //    //e.g. for ipd it will be I050600001
        //    //here I indicates this number is for Ipd
        //    //next 4 digits 0506 indicates year duration
        //    //and last 6 digits indicates sr.no.            
        //    String FormattedNo = "";
        //    //Document Type 1 char

        //    FormattedNo = DocumentType.Substring(0, 1);
        //    //Current Year 2 chars
        //    //string qury = "SELECT finyear FROM next_doc_no WHERE company_id='" + sa_id + "' AND doc_type='" + DocumentType + "'";
        //    ////string qury = @"SELECT finyear FROM next_doc_no WHERE " +
        //    ////                    " company_id = '" + sa_id + "' AND " +
        //    ////                    " doc_type = '" + DocumentType + "'";
        //    //string connectionString = @"Server=mitesh\sqlexpress;Database=cadlive4-4-2012;Integrated Security=True;Pooling=False";
        //    //SqlConnection myConnection = new SqlConnection(connectionString);
        //    //myConnection.Open();
        //    //SqlDataAdapter ad1 = new SqlDataAdapter(qury, myConnection);
        //    //DataSet ds12 = new DataSet();
        //    //ad1.Fill(ds12);
        //    //DataTable dtdoc1 = ds12.Tables[0];
        //    //string yearnext = dtdoc1.Rows[0]["finyear"].ToString();


        //    //  DateTime year = Convert.ToDateTime(System.DateTime.Today.Date.ToString());




        //    //if (yeardef != yearnext)
        //    //{

        //    //    string quyupdate = @"update next_doc_no SET next_doc_no=next_doc_no + 1  where doc_type='" + DocumentType + "' and company_id='" + sa_id + "' and year_defin='" + sr_no1 + "'";
        //    //    SqlCommand cmd = new SqlCommand(quyupdate, myConnection);

        //    //    cmd.ExecuteNonQuery();
        //    //   // doc_no = 1;
        //    //}
        //    //string quyupdate = @"update next_doc_no SET next_doc_no=next_doc_no + 1  where doc_type='" + DocumentType + "' and company_id='" + sa_id + "' and year_defin='" + srno + "'";
        //    //SqlCommand cmd = new SqlCommand(quyupdate, myConnection);

        //    //cmd.ExecuteNonQuery();
        //    FormattedNo += yearprifix;
        //    FormattedNo += sa_id;
        //    int LengthOfCurrentDocNo = doc_no.ToString().Length;
        //    for (int i = 1; i < DOCUMENTNOPORTIONLENGTH - LengthOfCurrentDocNo; i++)
        //        FormattedNo += "0";
        //    FormattedNo += doc_no.ToString();



        //    //String year = System.DateTime.Today.Year.ToString();
        //    //FormattedNo += year.Substring(2);
        //    //year = System.DateTime.Today.AddYears(1).Year.ToString().Substring(2);
        //    ////next year 2 chars
        //    //FormattedNo += year;

        //    return FormattedNo;
        //    //int LengthOfCurrentDocNo = doc_no.ToString().Length;
        //    //for (int i = 1; i <= DOCUMENTNOPORTIONLENGTH - LengthOfCurrentDocNo; i++)
        //    //    FormattedNo += "0";
        //    //FormattedNo += doc_no.ToString();

        //    //return FormattedNo;
        //}

        //#endregion
       #endregion


        #region For MySql Serevr
        #region GetNextDocNo

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
            if (DocumentType == "DRP")
            { NextDocumentNo = DRPFormatDocumentNo(DocumentType, doc_no); }
            
            else { NextDocumentNo = FormatDocumentNo(DocumentType, doc_no); }
                
            //MessageBox.Show("Document no is " + NextDocumentNo);
            return true;
        }

        public Boolean W_GetNextDocumentNo_only_number(ref IDbCommand comm, String sa_id, String DocumentType, String UserID, String HostName, ref String NextDocumentNo, ref String Message)
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

            NextDocumentNo = FormatDocumentNoonly_number("", doc_no);
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

        private String DRPFormatDocumentNo(String DocumentType, Decimal doc_no)
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
            FormattedNo = DocumentType;
            //Current Year 2 chars

            int LengthOfCurrentDocNo = doc_no.ToString().Length;
            for (int i = 1; i <= DOCUMENTNOPORTIONLENGTH - LengthOfCurrentDocNo; i++)
                FormattedNo += "0";
            FormattedNo += doc_no.ToString();

            return FormattedNo;
        }

        private String FormatDocumentNoonly_number(String DocumentType, Decimal doc_no)
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
       //     FormattedNo = DocumentType.Substring(0, 1);
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

        #endregion

        #region GetNextDocNo_FinancialYearWise

        public Boolean W_GetNextDocumentNo_financial(ref IDbCommand comm, String sa_id, String DocumentType, String UserID, String HostName, ref String NextDocumentNo, ref String Message, DateTime docdate)
        {
            //string company = sa_id;
            // sa_id = "01";

            string query = @"select * from year_definition where startdate <= '" + docdate + "' and enddate >= '" + docdate + "'";
            //string query = @"select * from year_Definition where flag='Y'";
          //  string connectionString = @"Server=mitesh\sqlexpress;Database=cadlive11-4-2012;Integrated Security=True;Pooling=False";
          //  string connectionString = @"Server=CONTADMIN;Initial Catalog=cadlive;Persist Security Info=True;User ID=sa;Password=Adanipmc2011$;Max Pool Size=200";

            string connectionString = ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ConnectionString;
          //  conn.ConnectionString = connString;
            MySqlConnection myConnection = new MySqlConnection(connectionString);


            MySqlDataAdapter ad = new MySqlDataAdapter(query, myConnection);

            DataSet ds1 = new DataSet();

            ad.Fill(ds1);
            DataTable dtdoc = ds1.Tables[0];
            String sr_no1 = "";
            String yeardef = "";
            if (dtdoc != null)
            {
                if (dtdoc.Rows.Count > 0)
                {
                    //DateTime stdt = Convert.ToDateTime(dtdoc.Rows[0]["startdate"].ToString());

                    //DateTime enddt = Convert.ToDateTime(dtdoc.Rows[0]["enddate"].ToString());

                    yeardef = dtdoc.Rows[0]["year"].ToString();
                    sr_no1 = dtdoc.Rows[0]["sr_number"].ToString();
                }
                else
                {
                    Message = "There is No Financial Year Entered in the System";
                    return false;
                }
            }
            else
            {
                Message = "There is No Financial Year Entered in the System";
                return false;

            }
            comm.CommandText = " SELECT next_doc_no FROM next_doc_no WHERE " +
                                " company_id = @sa_id AND " +
                                " doc_type = @document_type AND year_defin=@sr_no1";

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

            IDataParameter para31 = DBObjectFactory.GetParameterObject();
            para31.ParameterName = "@sr_no1";
            para31.DbType = DbType.String;
            para31.Value = sr_no1;
            comm.Parameters.Add(para31);

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
                             " doc_type = @document_type AND next_doc_no = @doc_no AND year_defin=@sr_no1";

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

          //  comm.Transaction.Commit();

            //comm.Connection.Open();
            NextDocumentNo = FormatDocumentNo_financial(DocumentType, doc_no, sa_id, yeardef);
            //MessageBox.Show("Document no is " + NextDocumentNo);
            if (NextDocumentNo == "No")
            {
                return false;
            }
            else
            {
                return true;
            }
        }

        private String FormatDocumentNo_financial(String DocumentType, Decimal doc_no, String sa_id, String yearprifix)
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
            //string qury = "SELECT finyear FROM next_doc_no WHERE company_id='" + sa_id + "' AND doc_type='" + DocumentType + "'";
            ////string qury = @"SELECT finyear FROM next_doc_no WHERE " +
            ////                    " company_id = '" + sa_id + "' AND " +
            ////                    " doc_type = '" + DocumentType + "'";
            //string connectionString = @"Server=mitesh\sqlexpress;Database=cadlive4-4-2012;Integrated Security=True;Pooling=False";
            //SqlConnection myConnection = new SqlConnection(connectionString);
            //myConnection.Open();
            //SqlDataAdapter ad1 = new SqlDataAdapter(qury, myConnection);
            //DataSet ds12 = new DataSet();
            //ad1.Fill(ds12);
            //DataTable dtdoc1 = ds12.Tables[0];
            //string yearnext = dtdoc1.Rows[0]["finyear"].ToString();


            //  DateTime year = Convert.ToDateTime(System.DateTime.Today.Date.ToString());




            //if (yeardef != yearnext)
            //{

            //    string quyupdate = @"update next_doc_no SET next_doc_no=next_doc_no + 1  where doc_type='" + DocumentType + "' and company_id='" + sa_id + "' and year_defin='" + sr_no1 + "'";
            //    SqlCommand cmd = new SqlCommand(quyupdate, myConnection);

            //    cmd.ExecuteNonQuery();
            //   // doc_no = 1;
            //}
            //string quyupdate = @"update next_doc_no SET next_doc_no=next_doc_no + 1  where doc_type='" + DocumentType + "' and company_id='" + sa_id + "' and year_defin='" + srno + "'";
            //SqlCommand cmd = new SqlCommand(quyupdate, myConnection);

            //cmd.ExecuteNonQuery();
            FormattedNo += yearprifix;
            FormattedNo += sa_id;
            int LengthOfCurrentDocNo = doc_no.ToString().Length;
            for (int i = 1; i < DOCUMENTNOPORTIONLENGTH - LengthOfCurrentDocNo; i++)
                FormattedNo += "0";
            FormattedNo += doc_no.ToString();



            //String year = System.DateTime.Today.Year.ToString();
            //FormattedNo += year.Substring(2);
            //year = System.DateTime.Today.AddYears(1).Year.ToString().Substring(2);
            ////next year 2 chars
            //FormattedNo += year;

            return FormattedNo;
            //int LengthOfCurrentDocNo = doc_no.ToString().Length;
            //for (int i = 1; i <= DOCUMENTNOPORTIONLENGTH - LengthOfCurrentDocNo; i++)
            //    FormattedNo += "0";
            //FormattedNo += doc_no.ToString();

            //return FormattedNo;
        }

        #endregion
        #endregion

        #region Document Types
        public static string GetIssueByHoldDocType()
        {
            return "I1020";
        }

        public static string GetIssueByBatchTransferDocType()
        {
            return "I1040";
        }

        public static string GetStockAdjustmentDocType()
        {
            return "S2022";
        }

        public static string GetReceiptDocType(string Transaction_Type)
        {
            switch (Transaction_Type)
            {
                case Constant.TT_MANUAL_RECEIPT_NEW://New MANUAL RECEIPT
                    return "S1570";
            }
            return null;
        }

        public static String GetReceiptByReleaseDocType()
        {
            return "S1580";
        }

        public static String GetReceiptByGoodsReturnDocType()
        {
            return "S1590";
        }

        public static String GetReceiptByBatchTransferDocType()
        {
            return "S1600";
        }
        #endregion
    }
}
