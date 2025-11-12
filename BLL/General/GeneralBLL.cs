using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.Data;

using BLL.Utilities;
using XSD;

namespace BLL.General
{
    public class GeneralBLL : ServerBase
    {
        #region VARIABLE DACLARATION
        String sa_id = null;
        #endregion

        #region Constructor & Destructor.
        public GeneralBLL()
        {
        }
        ~GeneralBLL()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }
        #endregion

        #region RETRIEVE
        public BLReturnObject GetProducts()
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            objBLReturnObject.ServerMessage = "";
            DataTable dtGeneral = new DataTable();
            objBLReturnObject.dt_ReturnedTables = new DataTable[1];

            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();
            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "SELECT item_code, item_desc FROM s_item_mst " +
                "WHERE (item_status = 'A') ORDER BY item_status";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet dsDataSet = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(dsDataSet);
                if (dsDataSet.Tables[0].Rows.Count <= 0)
                {
                    objBLReturnObject.ServerMessage = "There is no sales";
                    objBLReturnObject.ExecutionStatus = 2;
                }
                else
                {
                    objBLReturnObject.dt_ReturnedTables[0] = dsDataSet.Tables[0];
                    objBLReturnObject.ServerMessage = "List of Currently defined sales";
                    objBLReturnObject.ExecutionStatus = 1;
                }
            }
            catch (Exception e)
            {
                objBLReturnObject.ServerMessage = "An error occurred, while retrieving sales.\n" + e.Message;
                objBLReturnObject.ExecutionStatus = 2;
                DBConnection.Close();
            }
            //*****************************************************************************************
            /* CLOSE CONNECTION*/
            DBConnection.Close();
            //*****************************************************************************************
            return objBLReturnObject;
        }

        public BLReturnObject GetCustomers(String depo_code)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            objBLReturnObject.ServerMessage = "";
            DataTable dtGeneral = new DataTable();
            objBLReturnObject.dt_ReturnedTables = new DataTable[1];

            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();
            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "SELECT customer_code, customer_name FROM s_customer_mst " +
                "WHERE (status = 'A') ";

            if (depo_code != null)
            {
                SqlSelect += " AND (depo_code = @depo_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("depo_code", DbType.String, depo_code));
            }

            SqlSelect += " ORDER BY customer_code, customer_name";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet dsDataSet = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(dsDataSet);
                if (dsDataSet.Tables[0].Rows.Count <= 0)
                {
                    objBLReturnObject.ServerMessage = "There is no sales";
                    objBLReturnObject.ExecutionStatus = 2;
                }
                else
                {
                    objBLReturnObject.dt_ReturnedTables[0] = dsDataSet.Tables[0];
                    objBLReturnObject.ServerMessage = "List of Currently defined sales";
                    objBLReturnObject.ExecutionStatus = 1;
                }
            }
            catch (Exception e)
            {
                objBLReturnObject.ServerMessage = "An error occurred, while retrieving sales.\n" + e.Message;
                objBLReturnObject.ExecutionStatus = 2;
                DBConnection.Close();
            }
            //*****************************************************************************************
            /* CLOSE CONNECTION*/
            DBConnection.Close();
            //*****************************************************************************************
            return objBLReturnObject;
        }

        public BLReturnObject GetAllCustomers(String depo_code)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            objBLReturnObject.ServerMessage = "";
            DataTable dtGeneral = new DataTable();
            objBLReturnObject.dt_ReturnedTables = new DataTable[1];

            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();
            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "SELECT customer_code, customer_name FROM s_customer_mst "; //+
            //"WHERE (status = 'A') ";

            if (depo_code != null)
            {
                SqlSelect += " WHERE (depo_code = @depo_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("depo_code", DbType.String, depo_code));
            }

            SqlSelect += " ORDER BY customer_code, customer_name";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet dsDataSet = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(dsDataSet);
                if (dsDataSet.Tables[0].Rows.Count <= 0)
                {
                    objBLReturnObject.ServerMessage = "There is no sales";
                    objBLReturnObject.ExecutionStatus = 2;
                }
                else
                {
                    objBLReturnObject.dt_ReturnedTables[0] = dsDataSet.Tables[0];
                    objBLReturnObject.ServerMessage = "List of Currently defined sales";
                    objBLReturnObject.ExecutionStatus = 1;
                }
            }
            catch (Exception e)
            {
                objBLReturnObject.ServerMessage = "An error occurred, while retrieving sales.\n" + e.Message;
                objBLReturnObject.ExecutionStatus = 2;
                DBConnection.Close();
            }
            //*****************************************************************************************
            /* CLOSE CONNECTION*/
            DBConnection.Close();
            //*****************************************************************************************
            return objBLReturnObject;
        }

        public DataTable GetAllDivision()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT s_owner_mst.sa_id AS division_code, s_owner_level_mst.description AS division " +
                        "FROM s_owner_mst INNER JOIN " +
                        "s_owner_level_mst ON s_owner_mst.level2 = s_owner_level_mst.level_code " +
                        "WHERE (s_owner_level_mst.level_no = 2) AND (s_owner_level_mst.del_flag = 'N') " +
                        "ORDER BY s_owner_level_mst.description";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetEmployeeDetails(string employee_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT employee_Master.employee_code AS [Employee Code], employee_Master.employee_name AS Name, designation_master.description AS Designation, " +
                      "employee_Master.employee_date_of_joining AS DOJ, s_state_mst.state_name AS State, w_hq_mst_main.hq_name AS City,  " +
                      "employee_Master.date_of_birth AS DOB " +
                    "FROM employee_Master LEFT OUTER JOIN " +
                      "designation_master ON employee_Master.designation_code = designation_master.code LEFT OUTER JOIN " +
                      "w_hq_mst_main ON employee_Master.hq_code = w_hq_mst_main.hq_code LEFT OUTER JOIN " +
                      "s_state_mst ON employee_Master.state_code = s_state_mst.state_code ";

            if (employee_code != null)
                SqlSelect += " WHERE (employee_Master.employee_code = '" + employee_code + "')";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public DataTable GetMainHeadQuarterMaster(String state_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT hq_code, hq_name, state_code FROM w_hq_mst_main " +
                        "WHERE (cancel_flag = 'N') ";

            if (state_code != null)
            {
                SqlSelect += "  AND (state_code = @state_code)";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("state_code", DbType.String, state_code));
            }
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetMainHeadQuarterMaster(string[] state_codes)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT hq_code, hq_name, state_code FROM w_hq_mst_main " +
                        "WHERE (cancel_flag = 'N') ";

            if (state_codes != null)
            {
                string stateList = "";
                for (int curRow = 0; curRow < state_codes.Length; curRow++)
                {
                    stateList += "'" + state_codes[curRow] + "', ";
                }
                stateList = stateList.Substring(0, stateList.Length - 2);

                SqlSelect += "  AND (state_code IN (" + stateList + ")) ";
            }
            SqlSelect += " ORDER BY state_code";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public DataTable GetAllItem(String division_code, String item_code, String sap_code, ItemStatus objItemStatus)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT s_item_mst.* FROM s_item_mst ";
            if (objItemStatus == ItemStatus.ACTIVE)
                SqlSelect += "WHERE (item_status = 'A') ";
            if (objItemStatus == ItemStatus.INACTIVE)
                SqlSelect += "WHERE (item_status = 'D') ";
            if (objItemStatus == ItemStatus.ALL)
                SqlSelect += "WHERE (item_status = 'A' OR item_status = 'D') ";

            if (division_code != null)
            {
                SqlSelect += " AND (sa_id = @sa_id) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("sa_id", DbType.String, division_code));
            }

            if (item_code != null)
            {
                SqlSelect += " AND (item_code = @item_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("item_code", DbType.String, item_code));
            }

            if (sap_code != null)
            {
                SqlSelect += " AND (old_item_code = @sap_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("sap_code", DbType.String, sap_code));
            }

            SqlSelect += " ORDER BY item_desc";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetAllItem(string[] division_code, string item_code, string sap_code, ItemStatus objItemStatus)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT s_item_mst.* FROM s_item_mst ";
            if (objItemStatus == ItemStatus.ACTIVE)
                SqlSelect += "WHERE (item_status = 'A') ";
            if (objItemStatus == ItemStatus.INACTIVE)
                SqlSelect += "WHERE (item_status = 'D') ";
            if (objItemStatus == ItemStatus.ALL)
                SqlSelect += "WHERE (item_status = 'A' OR item_status = 'D') ";

            if (division_code != null)
            {
                string divisionList = "";
                for (int curRow = 0; curRow < division_code.Length; curRow++)
                {
                    divisionList += "'" + division_code[curRow] + "', ";
                }
                divisionList = divisionList.Substring(0, divisionList.Length - 2);

                SqlSelect += "  AND (sa_id IN (" + divisionList + ")) ";
            }

            if (item_code != null)
                SqlSelect += " AND (item_code = '" + item_code + "') ";

            if (sap_code != null)
                SqlSelect += " AND (old_item_code = '" + sap_code + "') ";

            SqlSelect += " ORDER BY item_desc";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetAllItem(string item_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT s_item_mst.* FROM s_item_mst ";

            if (item_code != null)
                SqlSelect += "WHERE item_code IN(" + item_code + ") ";

            SqlSelect += " ORDER BY item_desc";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetAllItem(string item_code, ItemStatus itemStatus)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT s_item_mst.* FROM s_item_mst ";

            if (itemStatus == ItemStatus.ACTIVE)
                SqlSelect += "WHERE (item_status = 'A') ";
            if (itemStatus == ItemStatus.INACTIVE)
                SqlSelect += "WHERE (item_status = 'D') ";
            if (itemStatus == ItemStatus.ALL)
                SqlSelect += "WHERE (item_status = 'A' OR item_status = 'D') ";

            if (item_code != null)
                SqlSelect += " AND item_code = " + item_code + " ";

            SqlSelect += " ORDER BY item_desc";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception)
            {
                return null;
            }
        }

        public DataTable GetAllDepo(string depo_code, DepoType depoType)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT s_depo_mst.* FROM s_depo_mst " +
                        "WHERE (status = 'A') AND (del_flag = 'N') ";

            if (depo_code != null)
            {
                SqlSelect += " AND (depo_code = @depo_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("depo_code", DbType.String, depo_code));
            }
            if (depoType == DepoType.C)
                SqlSelect += " AND (depo_type = 'C') ";
            else if (depoType == DepoType.D)
                SqlSelect += " AND (depo_type = 'D') ";

            SqlSelect += " ORDER BY depo_code";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetALLState()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT * from s_state_mst " +
                        "WHERE (cancel_flag = 'N') ORDER by state_name ";


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetCities(string state_code, string depo_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT * from s_city_mst " +
                        "WHERE (cancel_flag = 'N') ";

            if (state_code != null)
            {
                SqlSelect += " AND (state_code = @state_code)";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("state_code", DbType.String, state_code));
            }

            if (depo_code != null)
            {
                SqlSelect += " AND (depo_code = @depo_code)";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("depo_code", DbType.String, depo_code));
            }


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetAllItem(String item_code, String selected_column, String order_by_column)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT " + selected_column + " FROM s_item_mst WHERE item_code IN(" + item_code + ") ";

            if (order_by_column != null)
            {
                SqlSelect += " ORDER BY " + order_by_column;
            }
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetHeadQaurter(string division_code, string state_code, string hq_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT w_hq_mst.hq_code, w_hq_mst.hq_name, w_hq_mst.state_code, s_state_mst.state_name, w_hq_mst.company AS division_code,  " +
                        "s_owner_mst.description AS division " +
                        "FROM w_hq_mst INNER JOIN " +
                        "s_state_mst ON w_hq_mst.state_code = s_state_mst.state_code LEFT OUTER JOIN " +
                        "s_owner_mst ON w_hq_mst.company = s_owner_mst.sa_id " +
                        "WHERE     (w_hq_mst.cancel_flag = 'N') ";

            if (state_code != null)
            {
                SqlSelect += " AND (w_hq_mst.state_code = @state_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("state_code", DbType.String, state_code));
            }

            if (division_code != null)
            {
                SqlSelect += " AND (w_hq_mst.company = @division_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("division_code", DbType.String, division_code));
            }
            if (hq_code != null)
            {
                SqlSelect += " AND (w_hq_mst.hq_code = @hq_code)  ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("hq_code", DbType.String, hq_code));
            }

            SqlSelect += " ORDER BY division, s_state_mst.state_name, w_hq_mst.hq_name";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no speciality";
                    return null;
                }
                else
                {
                    //Message = "List of speciality.";
                    return ds.Tables[0];
                }
            }
            catch (Exception e)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        //Added by sanket on 27-08-09
        public DataTable GetParameters(String ParameterName)
        {
            DataSet ds = new DataSet();
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT parameter,code,description FROM parameter_mst WHERE(parameter = @parameter) ORDER BY code";// AND( parameter_mst.start_date <= @from_date ) AND( parameter_mst.end_date >= @to_date OR parameter_mst.end_date IS NULL)";

            DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("parameter", DbType.String, ParameterName));

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    return ds.Tables[0];
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }
        }

        public DataTable GetBrands(string[] division_code, ItemStatus objStatus)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT s_brand_mst.brand_code, s_brand_mst.brand_name " +
                    "FROM s_brand_mst LEFT OUTER JOIN " +
                      "s_item_mst ON s_brand_mst.brand_code = s_item_mst.brand_code ";

            if (objStatus == ItemStatus.ACTIVE)
                SqlSelect += " WHERE s_brand_mst.status = 'A'";
            else if (objStatus == ItemStatus.INACTIVE)
                SqlSelect += " WHERE s_brand_mst.status = 'I'";

            if (division_code != null && objStatus != ItemStatus.ALL)
            {
                string divisionList = "";
                for (int curRow = 0; curRow < division_code.Length; curRow++)
                {
                    divisionList += "'" + division_code[curRow] + "', ";
                }
                divisionList = divisionList.Substring(0, divisionList.Length - 2);

                SqlSelect += " AND (s_item_mst.sa_id IN (" + divisionList + ")) ";
            }
            else if (division_code != null)
            {
                string divisionList = "";
                for (int curRow = 0; curRow < division_code.Length; curRow++)
                {
                    divisionList += "'" + division_code[curRow] + "', ";
                }
                divisionList = divisionList.Substring(0, divisionList.Length - 2);

                SqlSelect += " WHERE (s_item_mst.sa_id IN (" + divisionList + ")) ";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public DataTable GetTherapeutic(string[] division_code, ItemStatus objStatus)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT s_item_mst.item_group, s_therapeutic_mst.therapeutic_name " +
                        "FROM s_item_mst LEFT OUTER JOIN " +
                        "s_therapeutic_mst ON s_item_mst.item_group = s_therapeutic_mst.therapeutic_code ";

            if (objStatus == ItemStatus.ACTIVE)
                SqlSelect += " WHERE (s_therapeutic_mst.status = 'A')";
            else if (objStatus == ItemStatus.INACTIVE)
                SqlSelect += " WHERE  (s_therapeutic_mst.status = 'I')";

            if (division_code != null && objStatus != ItemStatus.ALL)
            {
                string divisionList = "";
                for (int curRow = 0; curRow < division_code.Length; curRow++)
                {
                    divisionList += "'" + division_code[curRow] + "', ";
                }
                divisionList = divisionList.Substring(0, divisionList.Length - 2);

                SqlSelect += " AND (s_item_mst.sa_id IN (" + divisionList + ")) ";
            }
            else if (division_code != null)
            {
                string divisionList = "";
                for (int curRow = 0; curRow < division_code.Length; curRow++)
                {
                    divisionList += "'" + division_code[curRow] + "', ";
                }
                divisionList = divisionList.Substring(0, divisionList.Length - 2);

                SqlSelect += " WHERE (s_item_mst.sa_id IN (" + divisionList + ")) ";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public DataTable GetMaxExecuteQueryId()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT MAX(query_id) AS MAX_query_id FROM s_query_to_execute";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public DataTable GetDistinctQueryDesc()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT sa_id FROM s_query_to_execute";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception e)
            {
                return null;
            }
        }

        public DataTable GetExecuteQueryDetails(string query_desc)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT s_query_to_execute.sa_id, s_depo_mst.depo_code, s_depo_mst.depo_name, s_query_to_execute.executed, s_query_to_execute.message, " +
                      "s_query_to_execute.executed_datetime, s_query_to_execute.query " +
                    "FROM s_query_to_execute INNER JOIN " +
                      "s_depo_mst ON s_query_to_execute.depo_code = s_depo_mst.depo_code " +
                    "where sa_id = '" + query_desc + "'";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception e)
            {
                return null;
            }
        }
        #endregion

        #region SUBMIT
        public BLReturnObject SubmitData(DataSet ds_UploadData)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            objBLReturnObject.ExecutionStatus = 2;
            objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

            #region Primary Validation
            if (ds_UploadData == null)
            {
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "There is no data to save";
                return objBLReturnObject;
            }
            if (ds_UploadData.Tables[0].Rows.Count <= 0)
            {
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "There is no data to save";
                return objBLReturnObject;
            }

            #endregion
            ////////////////////////////////
            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            DBConnection.Open();
            DBCommand.Transaction = DBConnection.BeginTransaction();
            /////////////////////////////////////////////////////////////////

            BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

            objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, ds_UploadData.Tables[0], BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
            if (!objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != ds_UploadData.Tables[0].Rows.Count)
            {
                DBCommand.Transaction.Rollback();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage += " Fail to Save Data";
                return objBLReturnObject;
            }
            else
            {
                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                objBLReturnObject.ExecutionStatus = 1;
                objBLReturnObject.ServerMessage = "Data Saved Successfully";
                return objBLReturnObject;
            }
        }

        public BLReturnObject SubmitData(DataSet ds_UploadData, string tableName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            objBLReturnObject.ExecutionStatus = 2;
            objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

            #region Primary Validation
            if (ds_UploadData == null)
            {
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "There is no data to save";
                return objBLReturnObject;
            }
            if (ds_UploadData.Tables[tableName].Rows.Count <= 0)
            {
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "There is no data to save";
                return objBLReturnObject;
            }

            #endregion
            ////////////////////////////////
            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            DBConnection.Open();
            DBCommand.Transaction = DBConnection.BeginTransaction();
            /////////////////////////////////////////////////////////////////

            BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

            objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, ds_UploadData.Tables[tableName], BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
            if (!objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != ds_UploadData.Tables[tableName].Rows.Count)
            {
                DBCommand.Transaction.Rollback();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage += " Fail to Save Data";
                return objBLReturnObject;
            }
            else
            {
                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                objBLReturnObject.ExecutionStatus = 1;
                objBLReturnObject.ServerMessage = "Data Saved Successfully";
                return objBLReturnObject;
            }
        }
        #endregion
    }

    public enum ItemStatus
    {
        ACTIVE, INACTIVE, ALL
    }

    public enum DepoType
    {
        C, D, ALL
    }
}
