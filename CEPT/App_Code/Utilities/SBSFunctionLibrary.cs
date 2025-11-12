using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;
using System.Windows.Forms;
using System.IO;

/// <summary>
/// Summary description for SBSFunctionLibrary
/// </summary>
public class SBSFunctionLibrary
{
    public SBSFunctionLibrary()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static ArrayList GetDistinctColumnValues(DataTable dt, string ColumnName)
    {
        ArrayList UniqueValues = new ArrayList();
        if (dt != null)
        {

            string sortorder = ColumnName + " DESC";
            dt.DefaultView.Sort = sortorder;
            DataTable sorted_table = dt.DefaultView.ToTable();
            UniqueValues.Add(sorted_table.Rows[0][ColumnName].ToString());
            for (int i = 0; i < sorted_table.Rows.Count; i++)
            {
                if (sorted_table.Rows[i][ColumnName].ToString() == UniqueValues[UniqueValues.Count - 1].ToString())
                    continue;
                else
                    UniqueValues.Add(sorted_table.Rows[i][ColumnName].ToString());
            }

        }
        return UniqueValues;

    }

    public static DataTable getDistinctColumnValues(DataTable d_table, string ColumnName)
    {
        DataTable unique_dt = new DataTable();
        if (!SBSFunctionLibrary.IsNull(d_table, true))
        {
            unique_dt.Columns.Add(ColumnName, typeof(object));
            string sortorder = ColumnName + " DESC";
            d_table.DefaultView.Sort = sortorder;
            DataTable sorted_table = d_table.DefaultView.ToTable();

            DataRow dr = unique_dt.NewRow();

            if (sorted_table.Rows[0][ColumnName] == DBNull.Value || sorted_table.Rows[0][ColumnName].ToString() == "")
                return null;

            dr[ColumnName] = sorted_table.Rows[0][ColumnName].ToString();
            unique_dt.Rows.Add(dr);
            for (int i = 0; i < sorted_table.Rows.Count; i++)
            {
                if (sorted_table.Rows[i][ColumnName].ToString() == unique_dt.Rows[unique_dt.Rows.Count - 1][ColumnName].ToString())
                    continue;
                else
                {
                    DataRow row = unique_dt.NewRow();
                    row[ColumnName] = sorted_table.Rows[i][ColumnName].ToString();
                    if (row[ColumnName].ToString() != string.Empty)//added on 27-3-07
                        unique_dt.Rows.Add(row);
                }
            }

        }
        return unique_dt;
    }

    public static DataTable GetDistintColumnsRowValues(DataTable d_table, String ColumnName)
    {
        DataTable unique_dt = new DataTable();

        if (!SBSFunctionLibrary.IsNull(d_table, true))
        {
            unique_dt = d_table.Clone();

            DataTable temp = d_table.Copy();

            string sortorder = ColumnName + " DESC";
            //d_table.DefaultView.Sort = sortorder;
            //DataTable sorted_table = d_table.DefaultView.ToTable();
            //sorted table contains orginal data with DESC sort order.

            temp.DefaultView.Sort = sortorder;
            DataTable sorted_table = temp.DefaultView.ToTable();

            //DataRow dr = unique_dt.NewRow();
            //dr[ColumnName] = sorted_table.Rows[0][ColumnName].ToString();
            //unique_dt.Rows.Add(dr);


            unique_dt.ImportRow(sorted_table.Rows[0]);
            for (int i = 0; i < sorted_table.Rows.Count; i++)
            {
                if (sorted_table.Rows[i][ColumnName].ToString() == unique_dt.Rows[unique_dt.Rows.Count - 1][ColumnName].ToString())
                    continue;
                else
                {
                    //DataRow row = unique_dt.NewRow();
                    //row[ColumnName] = sorted_table.Rows[i][ColumnName].ToString();
                    //unique_dt.Rows.Add(row);

                    DataRow row = GetRow(d_table, ColumnName, sorted_table.Rows[i][ColumnName].ToString());
                    unique_dt.ImportRow(row);

                }
            }
        }
        return unique_dt;
    }

    public static DataRow GetRow(DataTable dt, string column, string value)
    {
        DataRow[] drow = dt.Select(column + "='" + value + "'");
        if (drow.Length > 0)
            return drow[0];
        return null;

    }

    public static DataTable TextFiletoDataTable(string inputfileName)
    {
        DataTable dt = new DataTable();
        if (inputfileName.Trim() == "")
        {
            //MessageBox.Show("Please Enter Filename", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            return dt;
        }
        else
        {
            if (File.Exists(inputfileName.Trim()))
            {
                StreamReader sr = File.OpenText(inputfileName.Trim());
                string input;

                int column = 0;
                input = sr.ReadLine();
                String[] column_name = input.Split('\t');

                while (column < column_name.Length)  //Extract ColumnName from firstline of TextFile
                {
                    dt.Columns.Add(column_name[column]);
                    column++;
                }

                int row = 0;
                while ((input = sr.ReadLine()) != null)  //Extract rows form textfile and separate column
                {
                    //int col;
                    dt.Rows.Add();
                    column_name = input.Split('\t');
                    for (column = 0; column < column_name.Length; column++)
                        dt.Rows[row][column] = column_name[column];
                    row++;
                }
                sr.Close();
                return dt;
            }
            else
            {
                MessageBox.Show(inputfileName + " File not exists", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return dt;
            }
        }
    }

    /// <summary>
    /// This Funtion Returns Lessthan/Equal 25 digits Employee Name. Which is Used mainly in Reports.
    /// </summary>
    /// <param name="employee_code">Employee Code</param>
    /// <param name="dtempmaster"> This table Contains employee first_name,middle_name,last_name And full name also.
    /// Suppose first_name,middle_name,last_name is Null And Full name is Not Null.
    /// That time this function use employee full name Other wise it use the first_name,middle_name,last_name
    ///  columns only.</param>
    /// <returns></returns>
    public static String GetEmployeeShortName(String employee_code, DataTable dtempmaster)
    {
        String employee_name = String.Empty;
        if (dtempmaster != null)
        {
            DataRow[] emp_row = dtempmaster.Select("employee_code='" + employee_code + "'");
            if (emp_row.Length > 0)
            {
                if (emp_row[0]["employee_first_name"] != DBNull.Value)
                    employee_name = emp_row[0]["employee_first_name"].ToString();
                if (emp_row[0]["employee_middle_name"] != DBNull.Value)
                {
                    String midName = emp_row[0]["employee_middle_name"].ToString();

                    if (midName.Length > 1)
                        employee_name += " " + midName.Substring(0, 1) + ".";
                    else
                        employee_name += " " + midName;
                }
                if (emp_row[0]["employee_last_name"] != DBNull.Value)
                    employee_name += " " + emp_row[0]["employee_last_name"].ToString();

                if (employee_name.Trim().Length == 0)
                {
                    if (emp_row[0]["employee_name"] != DBNull.Value)
                        employee_name = emp_row[0]["employee_name"].ToString();
                }

            }

            if (employee_name.Length > 20)
                employee_name = employee_name.Substring(0, 20).PadRight(20);
            else
                employee_name = employee_name.PadRight(20);

        }

        return employee_name;

    }

    public static Boolean IsNull(object val)
    {
        if (val == null || val == DBNull.Value)
            return true;
        return false;
    }

    public static Boolean IsNull(object val, Boolean SearchEmptyVal)
    {
        if (IsNull(val))
            return true;
        if (SearchEmptyVal)
        {
            if (val is String)
                if (val.ToString().Trim() == String.Empty)
                    return true;
            if (val is DataTable)
                if (((DataTable)val).Rows.Count == 0)
                    return true;
            if (val is DataSet)
                if (((DataSet)val).Tables.Count == 0)
                    return true;
            if (val is System.Collections.ArrayList)
                if (((System.Collections.ArrayList)val).Count == 0)
                    return true;
            if (val is Array)
                if (((Array)val).Length == 0)
                    return true;
        }
        return false;
    }
  
    public static String GetItemTypeDescription(String item_type)
    {
        if (item_type == SBSFunctionLibraryConstant.ITEM_TYPE_NORMAL)
            return "Normal Item";
        else if (item_type == SBSFunctionLibraryConstant.ITEM_TYPE_PRAMOTION_ARTICLE)
            return "Pramotional Articles";
        else if (item_type == SBSFunctionLibraryConstant.ITEM_TYPE_PHYSICIAN_SAMPLE)
            return "Physician Sample";
        else
            return String.Empty;
    }
 

    public static DataTable GetGenderDataTable()
    {
        DataTable dt = new DataTable();
        DataColumn code = new DataColumn("code", typeof(string));
        DataColumn desc = new DataColumn("description", typeof(string));

        dt.Columns.Add(code);
        dt.Columns.Add(desc);
        DataRow dr = dt.NewRow();
        dr["code"] = "M";
        dr["description"] = "MALE";
        dt.Rows.Add(dr);

        dr = dt.NewRow();
        dr["code"] = "F";
        dr["description"] = "FEMALE";
        dt.Rows.Add(dr);

        return dt;
    }
}