using System;
using System.Collections.Generic;
using System.Text;
using BLL.Utilities;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace BLL.ExtraUtility
{
    /// <summary>
    /// This function is older version. New one is "BindDropDown.cs"
    /// </summary>
    public class ddlDataBind
    {
        public void BindDropDownList(DataTable dtDataTable, DropDownList ddlDropDownList, String DataTextField, String DataValueField)
        {
            ddlDropDownList.AppendDataBoundItems = true;
            ddlDropDownList.Items.Clear();
            ddlDropDownList.Items.Add(new ListItem("", ""));
            ddlDropDownList.DataSource = dtDataTable;
            if (dtDataTable.Columns.Contains(DataTextField))
                ddlDropDownList.DataTextField = DataTextField;
            else
                return;
            if (dtDataTable.Columns.Contains(DataValueField))
                ddlDropDownList.DataValueField = DataValueField;
            ddlDropDownList.DataBind();
        }

        public void BindDropDownList(DataTable dtDataTable, DropDownList ddlDropDownList, String DataTextField1, String DataTextField2, String DataValueField)
        {
            dtDataTable.Columns.Add("DataText");
            for (int curRow = 0; curRow < dtDataTable.Rows.Count; curRow++)
            {
                dtDataTable.Rows[curRow]["DataText"] = dtDataTable.Rows[curRow][DataTextField1] + " - " + dtDataTable.Rows[curRow][DataTextField2];
            }

            ddlDropDownList.AppendDataBoundItems = true;
            ddlDropDownList.Items.Clear();
            ddlDropDownList.Items.Add(new ListItem("", ""));
            ddlDropDownList.DataSource = dtDataTable;
            if (dtDataTable.Columns.Contains("DataText"))
                ddlDropDownList.DataTextField = "DataText";
            else
                return;
            if (dtDataTable.Columns.Contains(DataValueField))
                ddlDropDownList.DataValueField = DataValueField;
            ddlDropDownList.DataBind();
        }
    }
}
