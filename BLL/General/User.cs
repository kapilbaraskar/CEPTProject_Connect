using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BLL.Utilities;
using BLL.Master;
//using Assembly;




namespace BLL.General
{
    public class User : ServerBase
    {

        
        #region Varible Declaration

        #endregion

        #region Constructor & Destructor.
        public User()
        {
        }
        ~User()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }
        #endregion

        //Modified on 18/09/2008
        public BLReturnObject GetUser(String user_id)
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
            String SqlSelect = "SELECT * FROM user_mst WHERE status='A'";

            if (user_id != null)
            {
                SqlSelect += " AND (user_id = @user_id)";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("user_id", DbType.String, user_id));
            }

            SqlSelect += " ORDER BY user_id";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet dsDataSet = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(dsDataSet);
                if (dsDataSet.Tables[0].Rows.Count <= 0)
                {
                    objBLReturnObject.ServerMessage = "There is no User";
                    objBLReturnObject.ExecutionStatus = 2;
                }
                else
                {
                    objBLReturnObject.dt_ReturnedTables[0] = dsDataSet.Tables[0];
                    objBLReturnObject.ServerMessage = "List of Currently defined User";
                    objBLReturnObject.ExecutionStatus = 1;
                }
            }
            catch (Exception e)
            {
                objBLReturnObject.ServerMessage = "An error occurred, while retrieving User.\n" + e.Message;
                objBLReturnObject.ExecutionStatus = 2;
                DBConnection.Close();
            }
            //*****************************************************************************************
            /* CLOSE CONNECTION*/
            DBConnection.Close();
            //*****************************************************************************************
            return objBLReturnObject;
        }

        //Added by sanket on 07/05/2008 fro retrieve all active and deactive User
        public BLReturnObject GetActiveDeactiveUser(String user_id)
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
            String SqlSelect = "SELECT user_id,status FROM w_user_master";

            if (user_id != null)
            {
                SqlSelect += " WHERE (user_id = @user_id)";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("user_id", DbType.String, user_id));
            }

            SqlSelect += " ORDER BY user_id";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet dsDataSet = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(dsDataSet);
                if (dsDataSet.Tables[0].Rows.Count <= 0)
                {
                    objBLReturnObject.ServerMessage = "There is no User";
                    objBLReturnObject.ExecutionStatus = 2;
                }
                else
                {
                    objBLReturnObject.dt_ReturnedTables[0] = dsDataSet.Tables[0];
                    objBLReturnObject.ServerMessage = "List of Currently defined User";
                    objBLReturnObject.ExecutionStatus = 1;
                }
            }
            catch (Exception e)
            {
                objBLReturnObject.ServerMessage = "An error occurred, while retrieving User.\n" + e.Message;
                objBLReturnObject.ExecutionStatus = 2;
                DBConnection.Close();
            }
            //*****************************************************************************************
            /* CLOSE CONNECTION*/
            DBConnection.Close();
            //*****************************************************************************************
            return objBLReturnObject;
        }

        public DataTable GetEmployeeDetails(String user_id)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            ////Modified on 11/09/2008 by sanket
            //SqlSelect = "SELECT w_employee_master.document_number, w_employee_master.sa_id, w_employee_master.user_id, w_employee_master.company_code, " +
            //          "w_employee_master.is_field_employee, w_employee_master.first_name, w_employee_master.middle_name, w_employee_master.last_name, " +
            //          "w_employee_master.user_short_name, w_employee_master.address1, w_employee_master.address2, w_employee_master.address3, " +
            //          "w_employee_master.area, w_employee_master.city_code, w_employee_master.state_code, w_employee_master.pin_code, " +
            //          "w_employee_master.phone_no, w_employee_master.mobile_no, w_employee_master.birth_date, w_employee_master.smsmail, " +
            //          "w_employee_master.email, w_employee_master.push, w_employee_master.pull, w_designation_master.description AS designation, " +
            //          "w_employee_master.status, w_employee_master.date_of_joining, w_employee_master.date_of_resign, w_employee_master.cancel_flag, " +
            //          "w_employee_master.designation_code, w_employee_master.anniversary_date, w_employee_master.blood_group, w_employee_master.full_name, " +
            //          "s_state_mst.state_name, s_city_mst.city_name, w_employee_master.city_name AS city1_name, w_employee_master.state_name AS state1_name, " +
            //          "w_employee_master.hq_code, w_hq_mst.hq_name, w_hq_mst.state_code AS hq_state_code " +
            //          "FROM         w_employee_master INNER JOIN " +
            //          "w_designation_master ON w_employee_master.designation_code = w_designation_master.code LEFT OUTER JOIN " +
            //          "w_hq_mst ON w_employee_master.hq_code = w_hq_mst.hq_code LEFT OUTER JOIN " +
            //          "s_state_mst ON w_hq_mst.state_code = s_state_mst.state_code AND w_employee_master.state_code = s_state_mst.state_code LEFT OUTER JOIN " +
            //          "s_city_mst ON w_employee_master.city_code = s_city_mst.city_code " +
            //          "WHERE     (w_employee_master.cancel_flag = N'N') AND (w_employee_master.user_id = @user_id) AND (w_employee_master.status = N'A')";

            //Modified on 04/03/2009
            SqlSelect = "SELECT employee_Master.*, designation_master.description, w_hq_mst.hq_name, s_state_mst.state_name, " +
                        "s_city_mst.city_name,designation_master.short_desc FROM employee_Master LEFT OUTER JOIN " +
                        "s_city_mst ON employee_Master.city_code = s_city_mst.city_code LEFT OUTER JOIN " +
                        "s_state_mst ON employee_Master.state_code = s_state_mst.state_code LEFT OUTER JOIN " +
                        "w_hq_mst ON employee_Master.hq_code = w_hq_mst.hq_code LEFT OUTER JOIN " +
                        "designation_master ON employee_Master.designation_code = designation_master.code " +
                        "WHERE     (employee_Master.employee_code = @user_id)";
            DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("user_id", DbType.String, user_id));

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
            catch (Exception)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        //Modified by sanket 01/10/2008
        public DataTable GetEmployeeAllDetails(String user_id)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            //SqlSelect = "SELECT w_employee_master.* FROM w_employee_master " +
            //            "WHERE (user_id = @user_id) AND (cancel_flag = N'N') AND (status = N'A')";

            SqlSelect = "SELECT employee_Master.* FROM employee_Master " +
                        "WHERE (employee_present_status = N'01')";
            if (user_id != null)
            {
                SqlSelect += " AND (employee_code = @employee_code)";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("employee_code", DbType.String, user_id));
            }
            else
            {
                SqlSelect += " ORDER BY employee_code";
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
            catch (Exception)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        //Added by sanket on 12/09/2008
        //Modified on 01/10/2008
        public DataTable GetAllUser(String user_id)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT employee_Master.employee_code AS [User Id], employee_Master.employee_name AS [User Name], " +
                "w_user_master.status AS [User Status], w_hq_mst.hq_name AS [Head Quarter] FROM employee_Master LEFT OUTER JOIN " +
                "w_hq_mst ON employee_Master.hq_code = w_hq_mst.hq_code LEFT OUTER JOIN w_user_master ON employee_Master.employee_code = " +
                "w_user_master.user_id ORDER BY [User Id]";

            //Commented on 04-11-08
            //SqlSelect = "SELECT w_user_master.user_id AS [User Id], employee_Master.employee_name AS [User Name], " +
            //            "w_user_master.status AS [User Status], w_hq_mst.hq_name AS [Head Quarter] " +
            //            "FROM w_hq_mst INNER JOIN " +
            //            "employee_Master ON w_hq_mst.hq_code = employee_Master.hq_code RIGHT OUTER JOIN " +
            //            "w_user_master ON employee_Master.employee_code = w_user_master.user_id " +
            //            "WHERE (w_user_master.cancel_flag = N'N') ORDER BY [User Id]";
            //DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("user_id", DbType.String, user_id));

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
            catch (Exception)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetUserForMail()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";

            SqlSelect = "SELECT w_user_master.user_id, employee_Master.employee_name " +
                        "FROM w_user_master LEFT OUTER JOIN " +
                        "employee_Master ON w_user_master.user_id = employee_Master.employee_code " +
                        "WHERE (w_user_master.status = N'A') ORDER BY w_user_master.user_id";

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
            catch (Exception)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetUserInfo(String employee_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "SELECT employee_Master.employee_name, employee_Master.employee_date_of_joining, " +
                               "designation_master.description AS designation, employee_Master.cs_id, " +
                               "employee_Master.cs_level1, employee_Master.employee_coff_overtime_eligibility, " +
                               "employee_Master.employee_service_type, employee_Master.employee_code " +
                               "FROM employee_Master LEFT OUTER JOIN " +
                               "designation_master ON employee_Master.hr_id = designation_master.hr_id AND " +
                               "employee_Master.designation_code = designation_master.code " +
                               "WHERE (employee_Master.employee_code = @employee_code)";

            DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("employee_code", DbType.String, employee_code));
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                {
                    //Message = "There is no Data";
                    return null;
                }
                else
                {
                    //Message = "User Info";
                    return ds.Tables[0];
                }
            }
            catch (Exception)
            {
                //Message = "An error occurred, while retrieving UserInfo.\n" + e.Message;
                return null;
            }
        }

        public DataTable GetUser(String state_code, UserStatus objUserStatus, String user_id)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";
            SqlSelect = "SELECT w_user_master.user_id AS [User Id], employee_Master.employee_name AS [User Name], w_user_master.status AS [User Status], " +
                        "designation_master.description AS designation, s_state_mst.state_name, w_hq_mst.hq_name, employee_Master.state_code, w_hq_mst.hq_code, " +
                        "employee_Master.employee_date_of_joining, employee_Master.date_of_birth, w_user_master.start_date, w_user_master.end_date, " +
                        "employee_Master.designation_code, designation_master.short_desc " +
                        "FROM         employee_Master INNER JOIN " +
                        "w_user_master ON employee_Master.employee_code = w_user_master.user_id INNER JOIN " +
                        "s_state_mst ON employee_Master.state_code = s_state_mst.state_code LEFT OUTER JOIN " +
                        "designation_master ON employee_Master.designation_code = designation_master.code LEFT OUTER JOIN " +
                        "w_hq_mst ON employee_Master.hq_code = w_hq_mst.hq_code " +
                        "WHERE     (w_user_master.cancel_flag = N'N')";

            if (state_code != null)
            {
                SqlSelect += " AND (employee_Master.state_code = @state_code) ";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("state_code", DbType.String, state_code));
            }

            if (user_id != null)
            {
                SqlSelect += " AND (w_user_master.user_id = @user_id)";
                DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("user_id", DbType.String, user_id));
            }
            //if (division_code != null)
            //{
            //    SqlSelect += " AND (employee_Master.division_code = @division_code)";
            //    DBDataAdpterObject.SelectCommand.Parameters.Add(BLGeneralUtil.MakeParameter("division_code", DbType.String, division_code));
            //}
            if (objUserStatus == UserStatus.ACTIVE)
            {
                SqlSelect += " AND (w_user_master.status = 'A') ";
            }
            if (objUserStatus == UserStatus.DEACTIVE)
            {
                SqlSelect += " AND (w_user_master.status = 'D') ";
            }

            SqlSelect += " ORDER BY [User Id]";

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
            catch (Exception)
            {
                //Message = "An error occurred, while retrieving sa speciality.\n" + e.Message;
                return null;
            }
        }

    }
    public enum UserStatus
    {
        ACTIVE,
        DEACTIVE,
        ALL
    }

}
