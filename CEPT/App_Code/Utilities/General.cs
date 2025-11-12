using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

/// <summary>
/// Summary description for General
/// </summary>
public class General
{
	public General()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    public void ClearText(ControlCollection controls, bool check)
    {
        //this is user defined function to clear text box and dropdown
        foreach (Control control in controls)
        {
            if (control is TextBox)
            {

                if (((TextBox)control).Text == "DD/MM/YYYY")
                    break;
                else if (((TextBox)control).Text == "DD/MM/YYYY HH:MM")
                    break;
                else if (((TextBox)control).Text == "HH:MM")
                    break;
                else
                    ((TextBox)control).Text = "";

            }
            if (control is DropDownList)
            {
                if (((DropDownList)control).Items.Count > 0)
                    ((DropDownList)control).SelectedIndex = 0;
            }
            if (control.Controls != null && true)
            {
                ClearText(control.Controls, true);
            }
        }

    }

    /*Added by sanket on 09/01/2009
    * This function is used to 
    */
    public DataTable MergeColumnToDatatable(DataTable dtGeneral, DataTable dtFindIn, String[] PrimaryColumns, String[] NewAddedColumns)
    {
        if (dtGeneral != null)
        {
            int NoOfPrimaryColumns = PrimaryColumns.Length;
            int NoOfAddedColumns = NewAddedColumns.Length;
            String Query = "";

            DataRow[] dr;
            for (int NewColCnt = 0; NewColCnt < NoOfAddedColumns; NewColCnt++)
            {
                dtGeneral.Columns.Add(NewAddedColumns[NewColCnt].ToString());
                for (int curRow = 0; curRow < dtGeneral.Rows.Count; curRow++)
                    dtGeneral.Rows[curRow][NewAddedColumns[NewColCnt].ToString()] = "0.00";
            }

            if (dtFindIn != null)
            {
                for (int RowCnt = 0; RowCnt < dtGeneral.Rows.Count; RowCnt++)
                {
                    Query = "";
                    for (int PriColCnt = 0; PriColCnt < NoOfPrimaryColumns; PriColCnt++)
                    {
                        Query += "" + PrimaryColumns[PriColCnt].ToString() + "='" + dtGeneral.Rows[RowCnt][PrimaryColumns[PriColCnt].ToString()].ToString() + "' AND ";
                    }
                    Query = Query.Substring(0, Query.Length - 4);
                    dr = dtFindIn.Select(Query);
                    if (dr.Length > 0)
                    {
                        int TempIndex = 0;
                        TempIndex = dtFindIn.Rows.IndexOf(dr[0]);
                        for (int NewColCnt = 0; NewColCnt < NoOfAddedColumns; NewColCnt++)
                        {
                            dtGeneral.Rows[RowCnt][NewAddedColumns[NewColCnt].ToString()] = dtFindIn.Rows[TempIndex][NewAddedColumns[NewColCnt].ToString()].ToString();
                        }
                    }
                    else
                    {
                        for (int NewColCnt = 0; NewColCnt < NoOfAddedColumns; NewColCnt++)
                        {
                            dtGeneral.Rows[RowCnt][NewAddedColumns[NewColCnt].ToString()] = "0";
                        }
                    }
                }
            }
        }
        return dtGeneral;
    }

    /// <summary>
    /// Merge two tables.
    /// It can merge more then one columns based on primary columns.
    /// </summary>
    /// <param name="PrimaryColumns"></param>
    /// <param name="NewAddedColumns"></param>
    /// <param name="mergeExtraRows"></param>
    /// <param name="dtGeneral"></param>
    /// <param name="dtFindIn"></param>
    /// <returns></returns>
    public DataTable MergeColumnToDatatable(String[] PrimaryColumns, String[] NewAddedColumns, String[] mergeExtraRows, DataTable dtGeneral, DataTable dtFindIn, string defaultText, skipNULL SkipNULL)
    {
        if (dtGeneral != null)
        {
            int NoOfPrimaryColumns = PrimaryColumns.Length;
            int NoOfAddedColumns = NewAddedColumns.Length;
            int NoOfExtraRows = 0;
            if (mergeExtraRows != null)
                NoOfExtraRows = mergeExtraRows.Length;

            string colNames = "";
            for (int curColName = 0; curColName < PrimaryColumns.Length; curColName++)
                colNames += PrimaryColumns[curColName] + ",";
            if (colNames.Length > 0 && dtGeneral != null)
            {
                colNames = colNames.Substring(0, colNames.Length - 1);
                dtGeneral.DefaultView.Sort = colNames;
                dtGeneral = dtGeneral.DefaultView.ToTable();

                if (dtFindIn != null)
                {
                    dtFindIn.DefaultView.Sort = colNames;
                    dtFindIn = dtFindIn.DefaultView.ToTable();
                }
            }

            for (int NewColCnt = 0; NewColCnt < NoOfAddedColumns; NewColCnt++)
            {
                if (!dtGeneral.Columns.Contains(NewAddedColumns[NewColCnt].ToString()))
                    dtGeneral.Columns.Add(NewAddedColumns[NewColCnt].ToString());
                for (int curRow = 0; curRow < dtGeneral.Rows.Count; curRow++)
                {
                    if (defaultText == null)
                        dtGeneral.Rows[curRow][NewAddedColumns[NewColCnt].ToString()] = "0.00";
                    else
                        dtGeneral.Rows[curRow][NewAddedColumns[NewColCnt].ToString()] = defaultText;
                }
            }

            if (dtFindIn != null)
            {
                int flgCheck = 0;
                int flgIsExtra = 0;
                int flgIsGreater = 0;
                if (!dtGeneral.Columns.Contains("isChecked"))
                    dtGeneral.Columns.Add("isChecked");

                for (int RowCntFindIn = 0; RowCntFindIn < dtFindIn.Rows.Count; RowCntFindIn++)
                {
                    flgIsExtra = 0;
                    flgIsGreater = 0;

                    for (int RowCntGeneral = 0; RowCntGeneral < dtGeneral.Rows.Count; RowCntGeneral++)
                    {
                        if (dtGeneral.Rows[RowCntGeneral]["isChecked"].ToString() != "Y")
                        {
                            for (int curColumn = 0; curColumn < NoOfPrimaryColumns; curColumn++)
                            {
                                int isGreater = dtGeneral.Rows[RowCntGeneral][PrimaryColumns[curColumn]].ToString().CompareTo(dtFindIn.Rows[RowCntFindIn][PrimaryColumns[curColumn]].ToString());

                                if (isGreater == 1)
                                {
                                    flgIsGreater = 1;
                                    break;
                                }

                                if (dtGeneral.Rows[RowCntGeneral][PrimaryColumns[curColumn]].ToString() == dtFindIn.Rows[RowCntFindIn][PrimaryColumns[curColumn]].ToString())
                                {
                                    flgCheck = 1;
                                }
                                else
                                {
                                    flgCheck = 0;
                                    break;
                                }
                            }
                            if (flgIsGreater == 1)
                            {
                                //flgIsExtra = 1;
                                break;
                            }

                            if (flgCheck == 1)
                            {
                                flgIsExtra = 1;

                                for (int curCol = 0; curCol < NoOfPrimaryColumns; curCol++)
                                {
                                    if (SkipNULL == skipNULL.FALSE)
                                    {
                                        dtGeneral.Rows[RowCntGeneral][PrimaryColumns[curCol]] = dtFindIn.Rows[RowCntFindIn][PrimaryColumns[curCol]].ToString();
                                    }
                                    else
                                    {
                                        if (dtFindIn.Rows[RowCntFindIn][PrimaryColumns[curCol]].ToString() != "")
                                            dtGeneral.Rows[RowCntGeneral][PrimaryColumns[curCol]] = dtFindIn.Rows[RowCntFindIn][PrimaryColumns[curCol]].ToString();
                                    }
                                }
                                for (int NewColCnt = 0; NewColCnt < NoOfAddedColumns; NewColCnt++)
                                {
                                    if (SkipNULL == skipNULL.FALSE)
                                    {
                                        dtGeneral.Rows[RowCntGeneral][NewAddedColumns[NewColCnt].ToString()] = dtFindIn.Rows[RowCntFindIn][NewAddedColumns[NewColCnt].ToString()].ToString();
                                    }
                                    else
                                    {
                                        if (dtFindIn.Rows[RowCntFindIn][NewAddedColumns[NewColCnt].ToString()].ToString() != "")
                                            dtGeneral.Rows[RowCntGeneral][NewAddedColumns[NewColCnt].ToString()] = dtFindIn.Rows[RowCntFindIn][NewAddedColumns[NewColCnt].ToString()].ToString();
                                    }
                                }
                                dtGeneral.Rows[RowCntGeneral]["isChecked"] = "Y";
                            }
                        }
                    }

                    if (flgIsExtra == 0)
                    {
                        if (mergeExtraRows != null)
                        {
                            dtGeneral.Rows.Add();
                            for (int curCol = 0; curCol < NoOfPrimaryColumns; curCol++)
                                dtGeneral.Rows[dtGeneral.Rows.Count - 1][PrimaryColumns[curCol]] = dtFindIn.Rows[RowCntFindIn][PrimaryColumns[curCol]].ToString();
                            for (int NewColCnt = 0; NewColCnt < NoOfAddedColumns; NewColCnt++)
                                dtGeneral.Rows[dtGeneral.Rows.Count - 1][NewAddedColumns[NewColCnt]] = dtFindIn.Rows[RowCntFindIn][NewAddedColumns[NewColCnt]].ToString();
                            for (int ColMerge = 0; ColMerge < NoOfExtraRows; ColMerge++)
                                dtGeneral.Rows[dtGeneral.Rows.Count - 1][mergeExtraRows[ColMerge]] = dtFindIn.Rows[RowCntFindIn][mergeExtraRows[ColMerge]].ToString();
                        }
                    }
                }
            }

            if (dtGeneral.Columns.Contains("isChecked"))
                dtGeneral.Columns.Remove("isChecked");

            if (mergeExtraRows != null)
            {
                string colNamesMerge = "";
                for (int curColName = 0; curColName < mergeExtraRows.Length; curColName++)
                    colNamesMerge += mergeExtraRows[curColName] + ",";
                if (colNamesMerge.Length > 0 && dtGeneral != null)
                {
                    colNamesMerge = colNamesMerge.Substring(0, colNamesMerge.Length - 1);
                    dtGeneral.DefaultView.Sort = colNamesMerge;
                    dtGeneral = dtGeneral.DefaultView.ToTable();
                }
            }
        }
        return dtGeneral;
    }

   

   

    public enum skipNULL
    {
        TRUE,
        FALSE
    }
}