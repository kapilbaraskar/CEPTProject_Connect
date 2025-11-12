using System;
using System.Data;
using System.Collections.Generic;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace BLL.ExtraUtility
{
    /// <summary>
    /// Sets DateFormat in each column or Selected Columns of DataTable if DataType is "System.DateTime".
    /// </summary>
    public class DateFormat
    {
        /// <summary>
        /// Sets DateFormat in "DD/MM/YYYY".
        /// Parameters : DataTable
        /// Date Format Converts in to "DD/MM/YYYY" from "MM/DD/YYYY" or "MM/DD/YYYY HH:MM:SS tt"
        /// Returns DataTable Converted in DD/MM/YYYY fomrat iff any column contains "System.DataTime format."
        /// otherwise returns as it is.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <returns></returns>
        public DataTable DDMMYYYY(DataTable dtDataTable)
        {
            DataTable dtNewDataTable = new DataTable();
            if (dtDataTable != null)
            {
                for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                {
                    dtNewDataTable.Columns.Add(dtDataTable.Columns[currentColumn].ColumnName);
                    if (dtDataTable.Columns[currentColumn].DataType.ToString() != "System.DateTime")
                        dtNewDataTable.Columns[currentColumn].DataType = dtDataTable.Columns[currentColumn].DataType;
                }
                for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
                {
                    dtNewDataTable.Rows.Add();
                    for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                    {
                        if (dtDataTable.Columns[currentColumn].DataType == System.Type.GetType("System.DateTime"))
                        {
                            String SetDateFormat = "";
                            if (dtDataTable.Rows[currentRow][currentColumn].ToString() != string.Empty)
                            {
                                DateTime GetDateFormat = Convert.ToDateTime(dtDataTable.Rows[currentRow][currentColumn].ToString());
                                SetDateFormat = GetDateFormat.ToString("dd/MM/yyyy");
                                dtNewDataTable.Rows[currentRow][currentColumn] = SetDateFormat;
                            }
                            else
                            {
                                dtNewDataTable.Rows[currentRow][currentColumn] = null;
                            }
                        }
                        else
                        {
                            dtNewDataTable.Rows[currentRow][currentColumn] = dtDataTable.Rows[currentRow][currentColumn];
                        }
                    }
                }
            }
            return dtNewDataTable;
        }

        /// <summary>
        /// Sets DateFormat in "DD/MM/YYYY HH:MM".
        /// Parameters : DataTable, Columns List(Data Type must be DateTime)
        /// Date Format Converts in to "DD/MM/YYYY HH:MM:SS tt" from "MM/DD/YYYY" or "MM/DD/YYYY HH:MM:SS tt"
        /// Converts only Listed Column values in "DD/MM/YYYY HH:MM:SS tt" format.
        /// Returns DataTable Converted in "DD/MM/YYYY HH:MM:SS tt" fomrat iff any column contains "System.DataTime format."
        /// otherwise returns as it is.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="Columns"></param>
        /// <returns></returns>
        public DataTable DD_MM_YYYY_HH_MM(DataTable dtDataTable, String[] Columns)
        {
            #region Comment
            //DataTable dtNewDataTable = new DataTable();
            //try
            //{
            //    for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
            //    {
            //        dtNewDataTable.Columns.Add(dtDataTable.Columns[currentColumn].ColumnName);
            //    }

            //    for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
            //    {
            //        dtNewDataTable.Rows.Add();
            //        for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
            //        {
            //            if (dtDataTable.Columns[currentColumn].DataType == System.Type.GetType("System.DateTime"))
            //            {
            //                DateTime SetDateFormat;
            //                if (dtDataTable.Rows[currentRow][currentColumn].ToString() != String.Empty)
            //                {
            //                    try
            //                    {
            //                        SetDateFormat = Convert.ToDateTime(dtDataTable.Rows[currentRow][currentColumn].ToString());
            //                    }
            //                    catch (Exception ex)
            //                    {
            //                        continue;
            //                    }
            //                    if (SetDateFormat.ToString() != String.Empty || SetDateFormat.ToString() != "")
            //                    {
            //                        String GetDateFormat = SetDateFormat.ToString("dd/MM/yyyy hh:mm tt");
            //                        dtNewDataTable.Rows[currentRow][currentColumn] = GetDateFormat.ToString();
            //                    }
            //                    else
            //                    {
            //                        dtNewDataTable.Columns[currentColumn].AllowDBNull = true;
            //                        dtNewDataTable.Rows[currentRow][currentColumn] = null;
            //                    }
            //                }
            //            }
            //            else
            //            {
            //                dtNewDataTable.Rows[currentRow][currentColumn] = dtDataTable.Rows[currentRow][currentColumn];
            //            }
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //}
            //return dtNewDataTable;
            #endregion
            DataTable dtNewDataTable = new DataTable();
            try
            {   
                for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                {
                    dtNewDataTable.Columns.Add(dtDataTable.Columns[currentColumn].ColumnName);
                }
                for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
                {
                    dtNewDataTable.Rows.Add(dtDataTable.Rows[currentRow].ItemArray);
                    for (int currentColumn = 0; currentColumn < Columns.Length; currentColumn++)
                    {
                        String SetDateFormat;
                        if (Columns[currentColumn].ToString() != string.Empty || Columns[currentColumn].ToString() != "")
                        {
                            SetDateFormat = dtDataTable.Rows[currentRow][Columns[currentColumn].ToString()].ToString();
                            if (SetDateFormat != String.Empty || SetDateFormat != "")
                            {
                                DateTime DateTmp = Convert.ToDateTime(SetDateFormat);
                                //String GetDateFormat = SetDateFormat.ToString("dd/MM/yyyy hh:mm tt");
                                dtNewDataTable.Rows[currentRow][Columns[currentColumn].ToString()] = DateTmp.ToString("dd/MM/yyyy hh:mm tt");
                            }
                            else
                            {
                                dtDataTable.Columns[currentColumn].AllowDBNull = true;
                                //dtNewDataTable.Rows[currentRow][Columns[currentColumn]] = dtDataTable.Rows[currentRow][Columns[currentColumn]];
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return dtNewDataTable;
        }

        /// <summary>
        /// Sets DateFormat in "MM/DD/YYYY".
        /// Parameters : DataTable
        /// Date Format Converts in to "MM/DD/YYYY" from "MM/DD/YYYY HH:MM:SS tt"
        /// Returns DataTable Converted in "MM/DD/YYYY" fomrat iff any column contains "System.DataTime format."
        /// otherwise returns as it is.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <returns></returns>
        public DataTable MMDDYYYY(DataTable dtDataTable)
        {
            DataTable dtNewDataTable = new DataTable();
            try
            {   
                for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                {
                    dtNewDataTable.Columns.Add(dtDataTable.Columns[currentColumn].ColumnName);
                }
                for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
                {
                    dtNewDataTable.Rows.Add();
                    for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                    {
                        if (dtDataTable.Columns[currentColumn].DataType == System.Type.GetType("System.DateTime"))
                        {
                            String SetDateFormat = "";
                            if (dtDataTable.Rows[currentRow][currentColumn].ToString() != string.Empty)
                            {
                                DateTime GetDateFormat = Convert.ToDateTime(dtDataTable.Rows[currentRow][currentColumn].ToString());
                                SetDateFormat = GetDateFormat.ToString("MM/dd/yyyy");
                                dtNewDataTable.Rows[currentRow][currentColumn] = SetDateFormat;
                            }
                            else
                            {
                                dtNewDataTable.Columns[currentColumn].AllowDBNull = true;
                                dtNewDataTable.Rows[currentRow][currentColumn] = null;
                            }

                        }
                        else
                        {
                            dtNewDataTable.Rows[currentRow][currentColumn] = dtDataTable.Rows[currentRow][currentColumn];
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return dtNewDataTable;
        }

        /// <summary>
        /// Sets DateFormat in "MM/DD/YYYY HH:MM".
        /// Parameters : DataTable, Columns List(Format must be "DD/MM/YYYY" or "DD/MM/YYYY HH:MM:SS tt")
        /// Date Format Converts in to "MM/DD/YYYY HH:MM:SS tt" from "DD/MM/YYYY" or "DD/MM/YYYY HH:MM:SS tt"
        /// Converts only Listed Column values in "MM/DD/YYYY HH:MM" format from DataTable.
        /// Returns DataTable Converted in "MM/DD/YYYY HH:MM:SS tt" fomrat iff any column contains Date format in "DD/MM/YYYY"
        /// Otherwise returns as it is.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="Columns"></param>
        /// <returns></returns>
        public DataTable MM_DD_YYYY_HH_MM(DataTable dtDataTable, String[] Columns)
        {
            try
            {
                for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
                {
                    for (int currentColumn = 0; currentColumn < Columns.Length; currentColumn++)
                    {
                        String SetDateFormat = null;
                        if (Columns[currentColumn].ToString() != string.Empty || Columns[currentColumn].ToString() != "")
                        {
                            SetDateFormat = dtDataTable.Rows[currentRow][Columns[currentColumn].ToString()].ToString();
                            if (SetDateFormat != String.Empty || SetDateFormat != "")
                            {
                                DateTime GetDateFormat = Convert.ToDateTime(SetDateFormat.Substring(3, 2) + "/" + SetDateFormat.Substring(0, 2) + "/" + SetDateFormat.Substring(6));
                                dtDataTable.Rows[currentRow][Columns[currentColumn].ToString()] = GetDateFormat.ToString();
                            }
                            else
                            {
                                //Convert.ChangeType(dtDataTable.Columns[currentColumn], typeof(DateTime));
                                dtDataTable.Columns[currentColumn].AllowDBNull = true;
                                dtDataTable.Rows[currentRow][Columns[currentColumn]] = null;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            }
            return dtDataTable;
        }

        /// <summary>
        /// Gets DateTime System DateTime format from format "DD/MM/YYYY"
        /// </summary>
        /// <param name="Date"></param>
        /// <returns></returns>
        public DateTime ConvertMMDDYYYY(String Date)
        {
            DateTime ReturnDate;

            ReturnDate = Convert.ToDateTime(Convert.ToInt32(Date.Substring(3, 2)) + "/" + Convert.ToInt32(Date.Substring(0, 2)) + "/" + Convert.ToInt32(Date.Substring(6)));

            return ReturnDate;
        }

        /// <summary>
        /// Sets DateFormat in "DD/MM/YYYY".
        /// Parameters : DataTable, Columns List(Data Type must be DateTime)
        /// Date Format Converts in to "DD/MM/YYYY HH:MM:SS tt" from "MM/DD/YYYY" or "MM/DD/YYYY HH:MM:SS tt"
        /// Converts only Listed Column values in "DD/MM/YYYY HH:MM:SS tt" format.
        /// Returns DataTable Converted in DD/MM/YYYY HH:MM:SS tt fomrat iff any column contains "System.DataTime format."
        /// otherwise returns as it is.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="Columns"></param>
        /// <returns></returns>
        public DataTable DDMMYYYY(DataTable dtDataTable, String[] Columns)
        {
            DataTable dtNewDataTable = new DataTable();

            try
            {
                for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                {
                    dtNewDataTable.Columns.Add(dtDataTable.Columns[currentColumn].ColumnName);
                }
                for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
                {
                    dtNewDataTable.Rows.Add(dtDataTable.Rows[currentRow].ItemArray);
                    for (int currentColumn = 0; currentColumn < Columns.Length; currentColumn++)
                    {
                        String SetDateFormat;
                        if (Columns[currentColumn].ToString() != string.Empty || Columns[currentColumn].ToString() != "")
                        {
                            SetDateFormat = dtDataTable.Rows[currentRow][Columns[currentColumn].ToString()].ToString();
                            if (SetDateFormat.ToString() != String.Empty || SetDateFormat.ToString() != "")
                            {
                                DateTime DateTmp = Convert.ToDateTime(SetDateFormat);
                                //String GetDateFormat = SetDateFormat.ToString("dd/MM/yyyy");
                                dtNewDataTable.Rows[currentRow][Columns[currentColumn].ToString()] = DateTmp.ToString("dd/MM/yyyy");
                            }
                            else
                            {
                                dtDataTable.Columns[currentColumn].AllowDBNull = true;
                                //dtDataTable.Rows[currentRow][Columns[currentColumn]] = dtDataTable.Rows[currentRow][Columns[currentColumn]];
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
            
            }
            return dtNewDataTable;
        }

        /// <summary>
        /// Sets DateFormat in "DD/MM/YYYY".
        /// Parameters : DataTable, Columns List(Data Type must be DateTime)
        /// Date Format Converts in to "DD/MM/YYYY HH:MM:SS tt" from "MM/DD/YYYY" or "MM/DD/YYYY HH:MM:SS tt"
        /// Converts only Listed Column values in "DD/MM/YYYY HH:MM:SS tt" format.
        /// Returns DataTable Converted in DD/MM/YYYY HH:MM:SS tt fomrat iff any column contains "System.DataTime format."
        /// otherwise returns as it is.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="Columns"></param>
        /// <returns></returns>
        public DataTable MMMYYYY(DataTable dtDataTable, String[] Columns)
        {
            DataTable dtNewDataTable = new DataTable();

            try
            {
                for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                {
                    dtNewDataTable.Columns.Add(dtDataTable.Columns[currentColumn].ColumnName);
                }
                for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
                {
                    dtNewDataTable.Rows.Add(dtDataTable.Rows[currentRow].ItemArray);
                    for (int currentColumn = 0; currentColumn < Columns.Length; currentColumn++)
                    {
                        String SetDateFormat;
                        if (Columns[currentColumn].ToString() != string.Empty || Columns[currentColumn].ToString() != "")
                        {
                            SetDateFormat = dtDataTable.Rows[currentRow][Columns[currentColumn].ToString()].ToString();
                            if (SetDateFormat.ToString() != String.Empty || SetDateFormat.ToString() != "")
                            {
                                DateTime DateTmp = Convert.ToDateTime(SetDateFormat);
                                //String GetDateFormat = SetDateFormat.ToString("dd/MM/yyyy");
                                dtNewDataTable.Rows[currentRow][Columns[currentColumn].ToString()] = DateTmp.ToString("MMM/yyyy");
                            }
                            else
                            {
                                dtDataTable.Columns[currentColumn].AllowDBNull = true;
                                //dtDataTable.Rows[currentRow][Columns[currentColumn]] = dtDataTable.Rows[currentRow][Columns[currentColumn]];
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return dtNewDataTable;
        }

        /// <summary>
        /// Sets DateFormat(24 hour) in "DD/MM/YYYY HH:MM".
        /// Parameters : DataTable, Columns List(Data Type must be DateTime)
        /// Date Format Converts in to "DD/MM/YYYY HH:MM:SS" from "MM/DD/YYYY" or "MM/DD/YYYY HH:MM:SS tt"
        /// Converts only Listed Column values in "DD/MM/YYYY HH:MM" format.
        /// Returns DataTable Converted in DD/MM/YYYY HH:MM:SS fomrat iff any column contains "System.DataTime format."
        /// otherwise returns as it is.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="Columns"></param>
        /// <returns></returns>
        public DataTable DD_MM_YYYY_HH_MM_24(DataTable dtDataTable, String[] Columns)
        {
            DataTable dtNewDataTable = new DataTable();
            try
            {
                for (int currentColumn = 0; currentColumn < dtDataTable.Columns.Count; currentColumn++)
                {
                    dtNewDataTable.Columns.Add(dtDataTable.Columns[currentColumn].ColumnName);
                }
                for (int currentRow = 0; currentRow < dtDataTable.Rows.Count; currentRow++)
                {
                    dtNewDataTable.Rows.Add(dtDataTable.Rows[currentRow].ItemArray);
                    for (int currentColumn = 0; currentColumn < Columns.Length; currentColumn++)
                    {
                        String SetDateFormat;
                        if (Columns[currentColumn].ToString() != string.Empty || Columns[currentColumn].ToString() != "")
                        {
                            SetDateFormat = dtDataTable.Rows[currentRow][Columns[currentColumn].ToString()].ToString();
                            if (SetDateFormat != String.Empty || SetDateFormat != "")
                            {
                                DateTime DateTmp = Convert.ToDateTime(SetDateFormat);
                                dtNewDataTable.Rows[currentRow][Columns[currentColumn].ToString()] = DateTmp.ToString("dd/MM/yyyy HH:mm");
                            }
                            else
                            {
                                dtDataTable.Columns[currentColumn].AllowDBNull = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            { }
            return dtNewDataTable;
        }

    }
}
