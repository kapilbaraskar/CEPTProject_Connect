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

namespace BLL.General
{
    public class CreateDataTable
    {
        public DataTable CreateDataTableFromBrowser(String[] Columns, String[] DropDownValues, String[] TextBoxes)
        {
            //This Event Retrieves Data from Browser and Saves it into Database...
            DataTable dtDataTable = new DataTable();
            String[] Data = null;
            int curColumnNumber = 0;
            try
            {
                if (Columns != null)
                {
                    for (int currentColumn = 0; currentColumn < Columns.Length; currentColumn++)
                    {
                        dtDataTable.Columns.Add(Columns[currentColumn].ToString());
                    }
                }

                if (TextBoxes != null)
                {
                    Data = TextBoxes[0].Split(',');
                    for (int curRow = 0; curRow < Data.Length; curRow++)
                    {
                        dtDataTable.Rows.Add();
                    }
                }
                int curColumn = 0;

                if (DropDownValues != null)
                {
                    for (curColumn = 0; curColumn < DropDownValues.Length; curColumn++)
                    {
                        if (DropDownValues[curColumn] != null)
                        {
                            Data = DropDownValues[curColumn].Split(',');
                            for (int curRow = 0; curRow < Data.Length; curRow++)
                            {
                                dtDataTable.Rows[curRow][curColumn] = Data[curRow].ToString();
                            }
                            curColumnNumber++;
                        }
                    }
                }

                if (TextBoxes != null)
                {
                    int NoOfDropDowns = 0;
                    if (DropDownValues != null)
                    {
                        NoOfDropDowns = DropDownValues.Length;
                    }
                    for (curColumn = 0; curColumn < TextBoxes.Length; curColumn++)
                    {
                        Data = TextBoxes[curColumn].Split(',');
                        for (int curRow = 0; curRow < Data.Length; curRow++)
                        {
                            dtDataTable.Rows[curRow][curColumn + curColumnNumber] = Data[curRow].ToString();
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
            return dtDataTable;
        }
    }
}
