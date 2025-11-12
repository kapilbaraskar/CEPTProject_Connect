using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BLL.ExtraUtility;

namespace BLL.ExtraUtility
{
    /// <summary>
    /// Bind Data with DropDownList.
    /// </summary>
    public class BindDropDown
    {
        #region VAERIABLE DECLARATION
        GroupByDataTable objGroupByDataTable = new GroupByDataTable();
        #endregion

        /// <summary>
        /// Binds DataTable with DropDownList
        /// Parameters : 1). DataTable (Which contains data to bind with DropDownList)
        ///              2). DropDownList (In which Data are Bind)
        ///              3). DataTextField (Column name of DataTable as DataTextField)
        ///              4). DataValueField (Column name of DataTable as DataValueField)
        /// Following function used to reduce the rewrite of code to bind DropDownList.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="cmbDropDownList"></param>
        /// <param name="DataTextField"></param>
        /// <param name="DataValueField"></param>
        public void BindDropDownList(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField, String DataValueField)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField) && dtDataTable.Columns.Contains(DataValueField))
                {
                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    cmbDropDownList.Items.Add(new ListItem("", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = DataTextField;
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
                else
                    return;
            }
        }

        /// <summary>
        /// Binds DataTable with DropDownList
        /// Parameters : 1). DataTable (Which contains data to bind with DropDownList)
        ///              2). DropDownList (In which Data are Bind)
        ///              3). DataTextField1 (Column name of DataTable as DataTextField)
        ///              4). DataTextField2 (Column name of DataTable as DataTextField)
        ///              5). DataValueField (Column name of DataTable as DataValueField)
        /// Both DataTextField1 & DataTextField2 are merged by hyphen(-) and treated as single String.
        /// then, merged text binded with DropDownList as DataTextField.
        /// so two columns will be shown in DropDownList.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="cmbDropDownList"></param>
        /// <param name="DataTextField1"></param>
        /// <param name="DataTextField2"></param>
        /// <param name="DataValueField"></param>
        public void BindDropDownList(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField1, String DataTextField2, String DataValueField)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField1) && dtDataTable.Columns.Contains(DataTextField2) && dtDataTable.Columns.Contains(DataValueField))
                {
                    if (!dtDataTable.Columns.Contains("DataText"))
                        dtDataTable.Columns.Add("DataText");
                    for (int curRow = 0; curRow < dtDataTable.Rows.Count; curRow++)
                    {
                        dtDataTable.Rows[curRow]["DataText"] = dtDataTable.Rows[curRow][DataTextField1] + " - " + dtDataTable.Rows[curRow][DataTextField2];
                    }

                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    cmbDropDownList.Items.Add(new ListItem("", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = "DataText";
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
            }
            dtDataTable = null;
        }

        /// <summary>
        /// Binds DataTable with DropDownList
        /// This function works same as First one function in this class.
        /// only difference is it adds ("--Select--", "-1") as first Item.
        /// Parameters : 1). DataTable (Which contains data to bind with DropDownList)
        ///              2). DropDownList (In which Data are Bind)
        ///              3). DataTextField (Column name of DataTable as DataTextField)
        ///              4). DataValueField (Column name of DataTable as DataValueField)
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="cmbDropDownList"></param>
        /// <param name="DataTextField"></param>
        /// <param name="DataValueField"></param>
        /// <param name="Select"></param>
        public void BindDropDownList(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField, String DataValueField, Boolean Select)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField) && dtDataTable.Columns.Contains(DataValueField))
                {
                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    cmbDropDownList.Items.Add(new ListItem("--Select--", "-1"));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = DataTextField;
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
                else
                    return;
            }
        }

        /// <summary>
        /// Binds DataTable with DropDownList
        /// Following function is important when you don't want to display 
        /// repeated values in DataTextField or DataValueField.
        /// This function removes repeated values iff you want to remove.
        /// Parameters : 1). DataTable (Which contains data to bind with DropDownList)
        ///              2). DropDownList (In which Data are Bind)
        ///              3). DataTextField1 (Column name of DataTable as DataTextField)
        ///              4). DataTextField2 (Column name of DataTable as DataTextField)
        ///              5). DataValueField (Column name of DataTable as DataValueField)
        ///              6). rowsMode - Used when you want to make all Rows unique.
        ///                         : DISTINCT - Makes Rows unique
        ///                         : ALL - Keeps Rows as it is.
        ///              7). field (which field(DataTextField1 or DataValueField) you want to make unique ?)
        /// Both DataTextField1 & DataTextField2 are merged by hyphen(-) and treated as single String.
        /// then, merged text binded with DropDownList as DataTextField.
        /// so two columns will be shown in DropDownList.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="cmbDropDownList"></param>
        /// <param name="DataTextField1"></param>
        /// <param name="DataTextField2"></param>
        /// <param name="DataValueField"></param>
        /// <param name="rowsMode"></param>
        /// <param name="field"></param>
        public void BindDropDownList(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField1, String DataTextField2, String DataValueField, RowsMode rowsMode, Field field)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField1) && dtDataTable.Columns.Contains(DataTextField2) && dtDataTable.Columns.Contains(DataValueField))
                {
                    if (rowsMode == RowsMode.DISTINCT)
                    {
                        //Following function is used to create Columns in group.
                        if (field.ToString() == "DataTextField")
                            dtDataTable = objGroupByDataTable.DeleteRepeated(dtDataTable.Copy(), DataTextField1);
                        if (field.ToString() == "DataVlaueField")
                            dtDataTable = objGroupByDataTable.DeleteRepeated(dtDataTable.Copy(), DataValueField);
                    }

                    dtDataTable.Columns.Add("DataText");
                    for (int curRow = 0; curRow < dtDataTable.Rows.Count; curRow++)
                    {
                        dtDataTable.Rows[curRow]["DataText"] = dtDataTable.Rows[curRow][DataTextField1] + " - " + dtDataTable.Rows[curRow][DataTextField2];
                    }

                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    cmbDropDownList.Items.Add(new ListItem("", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = "DataText";
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
            }
        }

        /// <summary>
        /// Binds DataTable with DropDownList
        /// Following function works same as above one.
        /// </summary>
        /// <param name="dtDataTable"></param>
        /// <param name="cmbDropDownList"></param>
        /// <param name="DataTextField1"></param>
        /// <param name="DataValueField"></param>
        /// <param name="rowsMode"></param>
        /// <param name="field"></param>
        public void BindDropDownList(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField, String DataValueField, RowsMode rowsMode, Field field)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField) && dtDataTable.Columns.Contains(DataValueField))
                {
                    if (rowsMode == RowsMode.DISTINCT)
                    {
                        //Following function is used to create Columns in group.
                        if (field.ToString() == "DataTextField")
                            dtDataTable = objGroupByDataTable.DeleteRepeated(dtDataTable.Copy(), DataTextField);
                        if (field.ToString() == "DataVlaueField")
                            dtDataTable = objGroupByDataTable.DeleteRepeated(dtDataTable.Copy(), DataValueField);
                    }

                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    cmbDropDownList.Items.Add(new ListItem("", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = DataTextField;
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
            }
        }

        public void BindDropDownList(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField, String DataValueField, FirstIndexAS objFirstIndexAS)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField) && dtDataTable.Columns.Contains(DataValueField))
                {
                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    if (objFirstIndexAS == FirstIndexAS.ALL)
                        cmbDropDownList.Items.Add(new ListItem("--ALL--", ""));
                    else if (objFirstIndexAS == FirstIndexAS.BLANK)
                        cmbDropDownList.Items.Add(new ListItem("", ""));
                    //else if (objFirstIndexAS == FirstIndexAS.NONE)
                    //    cmbDropDownList.Items.Add(new ListItem("--NONE--", ""));
                    else if (objFirstIndexAS == FirstIndexAS.SELECT)
                        cmbDropDownList.Items.Add(new ListItem("--SELECT--", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = DataTextField;
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
                else
                    return;
            }
        }

        public void BindDropDownList(DataTable dtDataTable, ListBox cmbDropDownList, String DataTextField, String DataValueField, FirstIndexAS objFirstIndexAS)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField) && dtDataTable.Columns.Contains(DataValueField))
                {
                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    if (objFirstIndexAS == FirstIndexAS.ALL)
                        cmbDropDownList.Items.Add(new ListItem("--ALL--", ""));
                    else if (objFirstIndexAS == FirstIndexAS.BLANK)
                        cmbDropDownList.Items.Add(new ListItem("", ""));
                    //else if (objFirstIndexAS == FirstIndexAS.NONE)
                    //    cmbDropDownList.Items.Add(new ListItem("--NONE--", ""));
                    else if (objFirstIndexAS == FirstIndexAS.SELECT)
                        cmbDropDownList.Items.Add(new ListItem("--SELECT--", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = DataTextField;
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
                else
                    return;
            }
        }

        public void BindDropDownListForUser(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField1, String DataTextField2, String DataTextField3, String DataValueField)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField1) && dtDataTable.Columns.Contains(DataTextField2) && dtDataTable.Columns.Contains(DataValueField) && dtDataTable.Columns.Contains(DataTextField3))
                {
                    if (!dtDataTable.Columns.Contains("DataText"))
                        dtDataTable.Columns.Add("DataText");
                    for (int curRow = 0; curRow < dtDataTable.Rows.Count; curRow++)
                    {
                        dtDataTable.Rows[curRow]["DataText"] = dtDataTable.Rows[curRow][DataTextField1] + " - " + dtDataTable.Rows[curRow][DataTextField2] + "  (" + dtDataTable.Rows[curRow][DataTextField3] + ")";
                    }

                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    cmbDropDownList.Items.Add(new ListItem("", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = "DataText";
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
            }
            dtDataTable = null;
        }

        public void BindDropDownList(DataTable dtDataTable, DropDownList cmbDropDownList, String DataTextField1, String DataTextField2, String DataValueField, FirstIndexAS objFirstIndexAS)
        {
            if (dtDataTable != null)
            {
                if (dtDataTable.Columns.Contains(DataTextField1) && dtDataTable.Columns.Contains(DataTextField2) && dtDataTable.Columns.Contains(DataValueField))
                {
                    if (!dtDataTable.Columns.Contains("DataText"))
                        dtDataTable.Columns.Add("DataText");
                    for (int curRow = 0; curRow < dtDataTable.Rows.Count; curRow++)
                    {
                        dtDataTable.Rows[curRow]["DataText"] = dtDataTable.Rows[curRow][DataTextField1] + " - " + dtDataTable.Rows[curRow][DataTextField2];
                    }

                    cmbDropDownList.AppendDataBoundItems = true;
                    cmbDropDownList.Items.Clear();
                    if (objFirstIndexAS == FirstIndexAS.ALL)
                        cmbDropDownList.Items.Add(new ListItem("--ALL--", ""));
                    else if (objFirstIndexAS == FirstIndexAS.BLANK)
                        cmbDropDownList.Items.Add(new ListItem("", ""));
                    //else if (objFirstIndexAS == FirstIndexAS.NONE)
                    //    cmbDropDownList.Items.Add(new ListItem("--NONE--", ""));
                    else if (objFirstIndexAS == FirstIndexAS.SELECT)
                        cmbDropDownList.Items.Add(new ListItem("--SELECT--", ""));
                    cmbDropDownList.DataSource = dtDataTable;
                    cmbDropDownList.DataTextField = "DataText";
                    cmbDropDownList.DataValueField = DataValueField;
                    cmbDropDownList.DataBind();
                }
            }
            dtDataTable = null;
        }

        /// <summary>
        /// Following function fills years in DropDownList.
        /// Pass the DropDown as parameter in which year will be filled.
        /// Pass the no of Items as parameter. Means that fills total no of items.
        ///     e.g. If you pass NoOfItems = 10;
        ///          then following function fills total 10 Items(years).
        ///          starts from current year - (10/2).
        ///          so it results as :
        ///                             2003-2004 (Starts from)
        ///                             2004-2005
        ///                             2005-2006
        ///                             2006-2007
        ///                             2007-2008
        ///                             2008-2009 (Current Year)
        ///                             2009-2010
        ///                             2010-2011 and so on...
        /// </summary>
        /// <param name="cmbDropDownList"></param>
        /// <param name="NoOfItems"></param>
        public void FillFinancialYear(DropDownList cmbDropDownList, int NoOfItems)
        {
            cmbDropDownList.Items.Clear();
            cmbDropDownList.Items.Add(new ListItem("", ""));
            for (int Year = NoOfItems - 1; Year >= 0; Year--)
            {
                cmbDropDownList.Items.Add((DateTime.Today.Year - Year + (NoOfItems / 2) - 1).ToString() + "-" + (DateTime.Today.Year - Year + (NoOfItems / 2)).ToString());
            }
        }

        /// <summary>
        /// Following function fills years in DropDownList.
        /// Pass the DropDown as parameter in which year will be filled.
        /// Pass the no of Items as parameter. Means that fills total no of items.
        ///     e.g. If you pass NoOfItems = 10;
        ///          then following function fills total 10 Items(years).
        ///          starts from current year - (10/2).
        ///          so it results as :
        ///                             2003 (Starts from)
        ///                             2004
        ///                             2005
        ///                             2006
        ///                             2007
        ///                             2008 (Current Year)
        ///                             2009
        ///                             2010 and so on...
        /// </summary>
        /// <param name="cmbDropDownList"></param>
        /// <param name="NoOfItems"></param>
        public void FillYears(DropDownList cmbDropDownList, int NoOfItems)
        {
            cmbDropDownList.Items.Clear();
            cmbDropDownList.Items.Add(new ListItem("", ""));
            for (int Year = NoOfItems; Year >= 0; Year--)
            {
                cmbDropDownList.Items.Add((DateTime.Today.Year - Year + (NoOfItems / 2)).ToString());
            }
        }

        public void FillYears(DropDownList cmbDropDownList, int NoOfItems, YearMode objYearMode)
        {
            cmbDropDownList.Items.Clear();
            cmbDropDownList.Items.Add(new ListItem("", ""));
            if (objYearMode == YearMode.FUTURE)
            {
                for (int Year = 0; Year <= NoOfItems; Year++)
                {
                    cmbDropDownList.Items.Add((DateTime.Today.Year + Year).ToString());
                }
            }
            if (objYearMode == YearMode.PAST)
            {
                for (int Year = NoOfItems; Year >= 0; Year--)
                {
                    cmbDropDownList.Items.Add((DateTime.Today.Year - Year).ToString());
                }
            }
        }

        /// <summary>
        /// Following function fills all months in DropDownList.
        /// Pass the DropDown as parameter in which all months will be filled.
        /// Here Months are filled as DataTextField and Nos(1, 2, 3,... , 12) as DataValueField.
        /// </summary>
        /// <param name="cmbDropDownList"></param>
        public void FillMonths(DropDownList cmbDropDownList)
        {
            cmbDropDownList.Items.Clear();
            cmbDropDownList.Items.Add(new ListItem("", ""));
            cmbDropDownList.Items.Add(new ListItem("January", "01"));
            cmbDropDownList.Items.Add(new ListItem("February", "02"));
            cmbDropDownList.Items.Add(new ListItem("March", "03"));
            cmbDropDownList.Items.Add(new ListItem("April", "04"));
            cmbDropDownList.Items.Add(new ListItem("May", "05"));
            cmbDropDownList.Items.Add(new ListItem("June", "06"));
            cmbDropDownList.Items.Add(new ListItem("July", "07"));
            cmbDropDownList.Items.Add(new ListItem("August", "08"));
            cmbDropDownList.Items.Add(new ListItem("September", "09"));
            cmbDropDownList.Items.Add(new ListItem("October", "10"));
            cmbDropDownList.Items.Add(new ListItem("November", "11"));
            cmbDropDownList.Items.Add(new ListItem("December", "12"));
        }
    }

    public enum FirstIndexAS
    {
        BLANK,
        ALL,
        NONE,
        SELECT
    }

    public enum RowsMode
    {
        DISTINCT,//DistinctRows
        ALL //All Rows
    }

    public enum Field
    {
        DataTextField,
        DataValueField
    }

    public enum YearMode
    {
        FUTURE,
        PAST
    }
}
