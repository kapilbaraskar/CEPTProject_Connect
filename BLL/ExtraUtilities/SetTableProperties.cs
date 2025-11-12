using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace BLL.ExtraUtility
{
    public class SetTableProperties
    {
        /// <summary>
        /// Following all three functions extends the property of DataTable.
        /// These functions sets the property of columns as HiddenProperty, PrimaryKey and ReadOnly Property.
        /// This function enxtends the property of DataTable as HiddenProperty.
        /// </summary>
        /// <param name="ColumnNames">String Array which contains ColumnName(s) of DataTable whose property we want to extend as HIDDEN
        /// </param>        
        /// <param name="dtDataTable">DataTable whose property we want to extend.</param>
        /// <returns>DataTable with extended property will be returned.</returns>
        public DataTable SetHidddenExtendedProperties(String[] ColumnNames, DataTable dtDataTable)
        {
            for (int curColumn = 0; curColumn < ColumnNames.Length; curColumn++)
            {
                if (ColumnNames[curColumn] != null && dtDataTable.Columns[ColumnNames[curColumn].ToString()].ExtendedProperties["Hidden"] == null)
                    dtDataTable.Columns[ColumnNames[curColumn].ToString()].ExtendedProperties.Add("Hidden", "H");
            }
            return dtDataTable;
        }

        // This function enxtends the property of DataTable as PrimaryKey.
        // <param name="DataColumn">
        // DataColumn Array which contains Column(s) of DataTable whose property we want to set as PrimaryKey
        // </param>
        public DataTable SetPrimaryKeys(DataColumn[] Keys, DataTable dtDataTable)
        {
            for (int curColumn = 0; curColumn < Keys.Length; curColumn++)
            {
                if (Keys[curColumn] != null)
                    Keys[curColumn] = dtDataTable.Columns[Keys[curColumn].ToString()];
            }
            dtDataTable.PrimaryKey = Keys;
            return dtDataTable;
        }

        //This function enxtends the property of DataTable as ReadOnly Property.
        //<param name="ColumnNames">
        //String Array which contains ColumnName(s) of DataTable whose property we want to extend as ReadOnly.
        //</param>
        public DataTable SetReadOnlyProperty(String[] ColumnNames, DataTable dtDataTable)
        {
            for (int curColumn = 0; curColumn < ColumnNames.Length; curColumn++)
            {
                if (ColumnNames[curColumn] != null && dtDataTable.Columns[ColumnNames[curColumn].ToString()].ReadOnly == false)
                    dtDataTable.Columns[ColumnNames[curColumn].ToString()].ReadOnly = true;
            }
            return dtDataTable;
        }
    }
}
