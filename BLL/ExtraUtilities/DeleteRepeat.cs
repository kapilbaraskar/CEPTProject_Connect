using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BLL.ExtraUtility
{
    public class DeleteRepeat
    {
        /// <summary>
        /// Following Function Removes the Rows from Datatable iff values are same in particular column.
        /// If we want to display the data on browser and there is repeated rows in datatable
        /// then use the following function to remove the repeated rows for display purpose.
        /// That means this function makes unique rows.
        /// </summary>
        public DataTable RemoveRepeatedRows(DataTable dt, String[] Columns)
        {
            //Delete Rows where particular Column(s) contains the repeated values in same column.
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
                                    dt.Rows.RemoveAt(i);
                            }
                        }
                    }
                }
            }
            return dt;
        }

        /// <summary>
        /// Hides blank items from DropDownList
        /// Following function is used when DropDownList Contains Blank ItemList and you don't want to display it.
        /// </summary>
        /// <param name="cmbDropDownList"></param>
        /// <returns></returns>
        public DropDownList RemoveBlankItems(DropDownList cmbDropDownList)
        {
            for (int curItem = 0; curItem < cmbDropDownList.Items.Count; curItem++)
            {
                //This Loop Removes the Balnk Items from DropDownList.
                if (cmbDropDownList.Items[curItem].ToString() == "")
                {
                    cmbDropDownList.Items[curItem].Enabled = false;
                }
            }
            return cmbDropDownList;
        }
    }
}
