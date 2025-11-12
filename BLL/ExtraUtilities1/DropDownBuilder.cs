using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BLL.Utilities1;
using System.Collections;
using System.Data;

namespace BLL.ExtraUtilities1
{
    public class DropDownBuilder : ServerBase
    {
        public override SendReceiveJSon ProcessRequest(SendReceiveJSon receive_obj)
        {
            switch (receive_obj.requestObjectInfo.ObjectProfile.MethodName)
            {
                case "GetItems":
                    return GetItems(receive_obj);
                default:
                    return null;
            }
        }

        private SendReceiveJSon GetItems(SendReceiveJSon receive_obj)
        {
            SendReceiveJSon send_obj = new SendReceiveJSon();
            send_obj.responseObjectInfo.transactionType = "GetItems";
            String Message = String.Empty;

            ArrayList typeList = (ArrayList)receive_obj.requestObjectInfo.OpArgs["drpTypeList"];
            
            Dictionary<string, object> returnData = new Dictionary<string, object>();

            foreach (string type in typeList)
            {
                var ColumnNameslist = new List<string>();
                var ColumnValueslist = new List<string>();

                Dictionary<string, object> opArgs = (Dictionary<string, object>)((Dictionary<string, object>)(receive_obj.requestObjectInfo.OpArgs["filterOption"]))[type];

                foreach (string key in opArgs.Keys)
                {
                    ColumnNameslist.Add(key);
                    ColumnValueslist.Add(opArgs[key].ToString());
                }

                var ColumnNames = ColumnNameslist.ToArray();
                var ColumnValues = ColumnValueslist.ToArray();

                returnData[type] = GetDropDownList(ref DBDataAdpterObject, type, ColumnNames, ColumnValues, ref Message);
            }

            send_obj.responseObjectInfo.Status = 1;
            send_obj.responseObjectInfo.Message = Message;
            send_obj.responseObjectInfo.dt_ReturnedTables = returnData;

            return send_obj;
        }

        DataTable GetDropDownList(ref IDbDataAdapter adapter, string DropdownType, string[] ColumnNames, string[] ColumnValues, ref string Message)
        {
            adapter.SelectCommand.Parameters.Clear();
            string TableName = "";

            String SQLSelect = "";
            List<int> skip = new List<int>();

            switch (DropdownType)
            {
                case "reservation":
                    TableName = "ReservationCategory";
                    SQLSelect = "SELECT ReservationCategory.category_id AS id, ReservationCategory.category_desc AS value FROM ReservationCategory  WHERE 1=1 ";
                    break;   
                case "other_nationality":
                    TableName = "CountryMst";
                    SQLSelect = "SELECT CountryMst.id AS id, CountryMst.name AS value FROM CountryMst  WHERE 1=1 AND CountryMst.id <> 'IN' ORDER BY CountryMst.name ";
                    break;
                case "education_exam_board":
                    TableName = "BoardNameMst";
                    SQLSelect = "SELECT BoardNameMst.board_id AS id, BoardNameMst.board_name AS value FROM BoardNameMst  WHERE 1=1 ";
                    break;
                case "education_state_name":
                    TableName = "StateMst";
                    SQLSelect = "SELECT StateMst.state_code AS id, StateMst.state_name AS value FROM StateMst  WHERE 1=1 ";
                    break;
                case "program_type":
                    TableName = "ProgramTypeMst";
                    SQLSelect = "SELECT ProgramTypeMst.program_type_id AS id, ProgramTypeMst.program_type_desc AS value FROM ProgramTypeMst  WHERE 1=1 ";
                    break;
                case "program_faculty_type":
                    TableName = "ProgramFacultyTypeMst";
                    SQLSelect = "SELECT ProgramFacultyTypeMst.program_faculty_id AS id, ProgramFacultyTypeMst.program_faculty_desc AS value FROM ProgramFacultyTypeMst  WHERE 1=1 ";
                    break;
                case "education_degree_type":
                    TableName = "EducationDegreeTypeMst";
                    SQLSelect = "SELECT EducationDegreeTypeMst.degree_type_id AS id, EducationDegreeTypeMst.degree_type_name AS value FROM EducationDegreeTypeMst  WHERE 1=1 ";
                    break;
                case "selectUser":
                    TableName = "ApplicantRegistrationMaster";
                    SQLSelect = @"SELECT     user_id AS id, email_id AS value
                                  FROM         ApplicantRegistrationMaster
                                  WHERE     (status = 'A') AND (user_type = 'C') AND (validate = 'Y') AND (CONVERT(VARCHAR(10), created_date, 101) = CONVERT(VARCHAR(10), GETDATE(), 101))
                                  ORDER BY created_date DESC ";
                    break;
                default:
                    break;
            }

            if (ColumnNames != null && ColumnValues != null && ColumnNames.Length > 0 && ColumnValues.Length > 0 && ColumnValues.Length == ColumnNames.Length)
            {
                for (int i = 0; i < ColumnNames.Length; i++)
                {                    
                    if (skip.Contains(i))
                        continue;
                    SQLSelect += " AND " + TableName + "." + ColumnNames[i] + "=@" + ColumnNames[i];

                    adapter.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@" + ColumnNames[i], DbType.String, ColumnValues[i]));
                }
            }

            adapter.SelectCommand.CommandText = SQLSelect;
            adapter.TableMappings.Clear();

            DataSet ds = new DataSet();
            adapter.Fill(ds);

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                Message = "";
                return ds.Tables[0];
            }
            else
            {
                Message = "";
                return null;
            }
        }
    }
}