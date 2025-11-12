using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BLL.ExtraUtility
{
    /// <summary>
    /// Sets DataTable in Group Values
    /// </summary>
    public class GroupByDataTable
    {
        public DataTable RemoveValuesBasedOnGroupColumns(DataTable dt, String[] Columns)
        {
            int curRow = 0;
            DataRow[] dr;
            int firstFlag = 0;

            String selectClause = "";

            for (; curRow < dt.Rows.Count - 1; )
            {
                selectClause = "";
                for (int curCol = 0; curCol < Columns.Length; curCol++)
                {
                    if (curCol == 0)
                        selectClause += Columns[curCol] + "='" + dt.Rows[curRow][Columns[curCol]].ToString() + "' ";
                    else
                        selectClause += " AND " + Columns[curCol] + "='" + dt.Rows[curRow][Columns[curCol]].ToString() + "'";
                }

                //for (int i = 0; i < dt.Rows.Count - 1; i++)
                //{
                //    if (dt.Rows[i][Columns[0]].ToString() == dt.Rows[i + 1][Columns[0]].ToString())
                //    {

                //    }
                //}

                dr = dt.Select(selectClause);
                //dr = dt.Select("" + Col1 + "='" + dt.Rows[curRow][Col1].ToString() + "' AND " + Col2 + "='" + dt.Rows[curRow][Col2].ToString() + "' AND " + Col3 + "='" + dt.Rows[curRow][Col3].ToString() + "'");
                {
                    if (firstFlag == 0)
                        for (int curDR = (curRow + 1); curDR < dr.Length + (curRow); curDR++)
                        {
                            for (int curCol = 0; curCol < Columns.Length; curCol++)
                                dt.Rows[curDR][Columns[curCol]] = "";
                            firstFlag = 1;
                        }
                    else
                        for (int curDR = (curRow + 1); curDR < dr.Length + (curRow); curDR++)
                        {
                            for (int curCol = 0; curCol < Columns.Length; curCol++)
                                dt.Rows[curDR][Columns[curCol]] = "";
                            firstFlag = 1;
                        }
                }
                if (dr.Length > 0)
                    curRow += dr.Length;
                else
                    curRow++;
            }
            return dt;
        }

        public DataTable RemoveValuesBasedOnGroupColumns1(DataTable dt, String[] Columns)
        {
            int flgCheck = 0;
            if (!dt.Columns.Contains("isChecked"))
                dt.Columns.Add("isChecked");

            for (int curRow = 0; curRow < dt.Rows.Count - 1; curRow++)
                dt.Rows[curRow]["isChecked"] = "N";

            for (int curRow = 0; curRow < dt.Rows.Count - 1; curRow++)
            {
                if (dt.Rows[curRow]["isChecked"].ToString() == "N")
                    for (int curRow1 = curRow; curRow1 < dt.Rows.Count - 1; curRow1++)
                    {
                        for (int curColumn = 0; curColumn < Columns.Length; curColumn++)
                        {
                            if (dt.Rows[curRow][Columns[curColumn]].ToString() == dt.Rows[curRow1 + 1][Columns[curColumn]].ToString())
                            {
                                flgCheck = 1;
                            }
                            else
                            {
                                flgCheck = 0;
                                break;
                            }
                        }
                        if (flgCheck == 1)
                        {
                            for (int curCol = 0; curCol < Columns.Length; curCol++)
                                dt.Rows[curRow1 + 1][Columns[curCol]] = DBNull.Value;
                            dt.Rows[curRow1 + 1]["isChecked"] = "Y";
                        }
                    }
            }

            if (dt.Columns.Contains("isChecked"))
                dt.Columns.Remove("isChecked");

            return dt;
        }

        //made by prem, sanket. not used now.
        public DataTable RemoveValuesBasedOnGroupOld(DataTable dt, String[] Columns)
        {
            while (Columns.Length >= 1)
            {
                dt = RemoveValuesBasedOnGroupColumns1(dt, Columns);

                String[] newColumns = new String[Columns.Length - 1];
                for (int curColumn = 0; curColumn < newColumns.Length; curColumn++)
                    newColumns[curColumn] = Columns[curColumn];
                Columns = newColumns;
            }

            return dt;
        }

        //made by jigar.
        public DataTable RemoveValuesBasedOnGroup(DataTable dt, String[] Columns)
        {
            String[,] GroupColumn = new String[Columns.Length, 2];
            for (int i = 0; i < Columns.Length; i++)
            {
                GroupColumn[i, 0] = String.Empty;
                GroupColumn[i, 1] = "0"; //for set 'None' data not defined, or not found. brand, hq, division
            }

            Boolean previous_group_changed = true;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                for (int j = 0; j < Columns.Length; j++)
                {
                    if (dt.Rows[i][Columns[j]].ToString() == GroupColumn[j, 0] && previous_group_changed)
                    {
                        //data is not defined. so set to None.
                        if (dt.Rows[i][Columns[j]].ToString().Trim() == String.Empty && GroupColumn[j, 1] == "0")
                        {
                            dt.Rows[i][Columns[j]] = "None";
                            GroupColumn[j, 1] = "1";
                        }
                        else //data is repeated, so clear that data.
                            dt.Rows[i][Columns[j]] = DBNull.Value;
                    }
                    else
                    {
                        GroupColumn[j, 0] = dt.Rows[i][Columns[j]].ToString();
                        //data is not defined. so set to None.
                        if (dt.Rows[i][Columns[j]].ToString().Trim() == String.Empty && GroupColumn[j, 1] == "0")
                        {
                            dt.Rows[i][Columns[j]] = "None";
                            GroupColumn[j, 1] = "1";
                        }
                        else
                            GroupColumn[j, 1] = "0";

                        previous_group_changed = false;
                    }
                }
                previous_group_changed = true;
            }

            return dt;
        }

        public DataTable DeleteRepeatedRowsBasedOnGroupColumns(DataTable dt, String[] Columns, Keep objKeep)
        {
            if (dt != null)
            {
                int flgCheck = 0;
                if (!dt.Columns.Contains("isChecked"))
                    dt.Columns.Add("isChecked");

                for (int curRow = 0; curRow < dt.Rows.Count - 1; curRow++)
                    dt.Rows[curRow]["isChecked"] = "N";

                for (int curRow = 0; curRow < dt.Rows.Count - 1; curRow++)
                {
                    if (dt.Rows[curRow]["isChecked"].ToString() == "N")
                        for (int curRow1 = curRow; curRow1 < dt.Rows.Count - 1; curRow1++)
                        {
                            for (int curColumn = 0; curColumn < Columns.Length; curColumn++)
                            {
                                if (dt.Rows[curRow][Columns[curColumn]].ToString() == dt.Rows[curRow1 + 1][Columns[curColumn]].ToString())
                                    flgCheck = 1;
                                else
                                {
                                    flgCheck = 0;
                                    break;
                                }
                            }
                            if (flgCheck == 1)
                            {
                                if (objKeep == Keep.FIRST)
                                    dt.Rows[curRow1 + 1]["isChecked"] = "Y";
                                else
                                    dt.Rows[curRow1]["isChecked"] = "Y";
                            }
                        }
                }

                dt.DefaultView.RowFilter = "isChecked = 'N'";
                dt = dt.DefaultView.ToTable();

                if (dt.Columns.Contains("isChecked"))
                    dt.Columns.Remove("isChecked");
            }
            return dt;
        }

        public DataTable DeleteRowsWhenValueIsBlankBasedOnGroupColumns(DataTable dt, String[] Columns)
        {
            int flgCheck = 0;
            if (!dt.Columns.Contains("isChecked"))
                dt.Columns.Add("isChecked");

            for (int curRow = 0; curRow < dt.Rows.Count - 1; curRow++)
                dt.Rows[curRow]["isChecked"] = "N";

            for (int curRow = 0; curRow < dt.Rows.Count - 1; curRow++)
            {
                if (dt.Rows[curRow]["isChecked"].ToString() == "N")
                {
                    //for (int curRow1 = curRow; curRow1 < dt.Rows.Count - 1; curRow1++)
                    //{
                    for (int curColumn = 0; curColumn < Columns.Length; curColumn++)
                    {
                        if (dt.Rows[curRow][Columns[curColumn]].ToString() == "")
                            flgCheck = 1;
                        else
                        {
                            flgCheck = 0;
                            break;
                        }
                    }
                    if (flgCheck == 1)
                        dt.Rows[curRow]["isChecked"] = "Y";
                    //}
                }
            }

            dt.DefaultView.RowFilter = "isChecked = 'N'";
            dt = dt.DefaultView.ToTable();

            if (dt.Columns.Contains("isChecked"))
                dt.Columns.Remove("isChecked");

            return dt;
        }

        /// <summary>
        /// Following Function Removes the repeated values in particular coumn(s) from Datatable.
        /// If we want to display the data on browser and there is repeated values in columns in datatable
        /// then use the following function to remove the repeated values for display purpose.
        /// That means this function makes group.
        /// </summary>
        public DataTable GroupByColumn(DataTable dt, String[] Columns)
        {
            if (dt != null)
            {
                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    if (dt.Rows[j][Columns[0].ToString()].ToString() != "")
                    {
                        String Match = dt.Rows[j][Columns[0].ToString()].ToString();
                        for (int i = j + 1; i < dt.Rows.Count; i++)
                        {
                            if (Match == dt.Rows[i][Columns[0].ToString()].ToString())
                            {
                                for (int setNull = 0; setNull < Columns.Length; setNull++)
                                {
                                    if (Columns[setNull] != null)
                                        dt.Rows[i][Columns[setNull].ToString()] = DBNull.Value;
                                }
                            }
                        }
                    }
                }
            }
            return dt;
        }

        /// <summary>
        /// Following Function Removes the repeated Rows from Datatable.
        /// If we want to display the data on browser and there is repeated rows in datatable
        /// then use the following function to remove the repeated rows for display purpose.
        /// That means this function makes unique rows depending on ColumnName Passed.
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="Column"></param>
        /// <returns></returns>
        public DataTable DeleteRepeatedRows(DataTable dt, String Column)
        {
            dt.Columns.Add("temp_cancel_flag");
            //for (int curRow = 0; curRow < dt.Rows.Count; curRow++)
            //{
            //    for (int chkRow = curRow + 1; chkRow < dt.Rows.Count; chkRow++)
            //    {
            //        if (curRow != chkRow)
            //        {
            //            if (dt.Rows[chkRow][Column.ToString()].ToString() == String.Empty)
            //            {
            //                dt.Rows[chkRow]["temp_cancel_flag"] = "Y";
            //            }
            //        }
            //    }
            //}
            for (int curRow = 0; curRow < dt.Rows.Count; curRow++)
            {
                if ((curRow + 1) < dt.Rows.Count - 1)
                    for (int curValue = curRow + 1; dt.Rows[curValue][Column].ToString() == String.Empty; curValue++)
                    {
                        dt.Rows[curValue]["temp_cancel_flag"] = "Y";
                        if (curValue >= dt.Rows.Count - 1)
                            break;
                    }
            }
            dt.DefaultView.RowFilter = "temp_cancel_flag IS NULL";
            dt.Columns.Remove("temp_cancel_flag");
            return dt.DefaultView.ToTable();
        }

        /// <summary>
        /// Following Function Removes the repeated Rows from Datatable.
        /// If we want to display the data on browser and there is repeated rows in datatable
        /// then use the following function to remove the repeated rows for display purpose.
        /// That means this function makes unique rows depending on ColumnName Passed.
        /// </summary>
        /// <param name="dt"></param>
        /// <param name="Column"></param>
        /// <returns></returns>
        public DataTable DeleteRepeated(DataTable dt, String Column)
        {
            if (!dt.Columns.Contains("temp_cancel_flag"))
                dt.Columns.Add("temp_cancel_flag");
            for (int curRow = 0; curRow < dt.Rows.Count; curRow++)
            {
                for (int chkRow = curRow + 1; chkRow < dt.Rows.Count; chkRow++)
                {
                    if (curRow != chkRow)
                    {
                        if (dt.Rows[curRow][Column.ToString()].ToString() == dt.Rows[chkRow][Column.ToString()].ToString())
                        {
                            dt.Rows[chkRow]["temp_cancel_flag"] = "Y";
                        }
                    }
                }
            }
            dt.DefaultView.RowFilter = "temp_cancel_flag IS NULL";
            dt.Columns.Remove("temp_cancel_flag");
            return dt.DefaultView.ToTable();
        }

        //Added by Sanket for Group by till only next row
        public DataTable GroupByNextRow(DataTable dt, String[] Columns)
        {
            DataTable dtNewDataTable = new DataTable();
            if (dt != null)
            {
                for (int currentColumn = 0; currentColumn < dt.Columns.Count; currentColumn++)
                    dtNewDataTable.Columns.Add(dt.Columns[currentColumn].ColumnName);

                for (int currentRow = 0; currentRow < dt.Rows.Count; currentRow++)
                {
                    dtNewDataTable.Rows.Add();
                    for (int currentColumn = 0; currentColumn < dt.Columns.Count; currentColumn++)
                        dtNewDataTable.Rows[currentRow][currentColumn] = dt.Rows[currentRow][currentColumn].ToString();
                }


                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    if (dtNewDataTable.Rows[j][Columns[0].ToString()].ToString() != "")
                    {
                        String Match = dtNewDataTable.Rows[j][Columns[0].ToString()].ToString();
                        if (Match != "" || Match != String.Empty)
                            for (int i = j + 1; i < dt.Rows.Count; i++)
                            {
                                if (Match == dtNewDataTable.Rows[i][Columns[0].ToString()].ToString())
                                {
                                    for (int setNull = 0; setNull < Columns.Length; setNull++)
                                    {
                                        if (Columns[setNull] != null)
                                            dtNewDataTable.Rows[i][Columns[setNull].ToString()] = null;
                                    }
                                }
                                else
                                {
                                    break;
                                }
                            }
                    }
                }
            }
            return dtNewDataTable;
        }

        public int findLastIndex(DataTable dtData, string columnName, string value)
        {
            int lastIndex = 0;
            for (int curRow = dtData.Rows.Count - 1; curRow >= 0; curRow--)
            {
                if (dtData.Rows[curRow][columnName].ToString() == value)
                {
                    lastIndex = curRow;
                    break;
                }
            }
            return lastIndex;
        }

        public enum Keep
        {
            FIRST, LAST
        }

        #region NOT IN USE
        /// <summary>
        /// Following Function Removes the repeated Rows from Datatable.
        /// If we want to display the data on browser and there is repeated rows in datatable
        /// then use the following function to remove the repeated rows for display purpose.
        /// That means this function makes unique rows according to columnsNames passed.
        /// </summary>
        public DataTable DeleteRepeatedRows(DataTable dt, String[] Columns, String Value)
        {
            int row = 0;
            DataTable dtTemp = null;
            if (dt != null)
            {
                dtTemp = dt.Copy();
                for (int curRow = 0; curRow < dt.Rows.Count; curRow++)
                {
                    if (dt.Rows[curRow][Columns[0].ToString()].ToString() != Value)
                    {
                        dtTemp.Rows.RemoveAt(row);
                        row--;
                    }
                    row++;
                }
            }
            return dtTemp;
        }
        #endregion
    }
}
