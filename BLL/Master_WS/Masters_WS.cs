using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BLL.Utilities;
using XSD.Masters_WS;
using System.IO;
using System.Web.Script.Serialization;
using System.Web;

namespace BLL.Master_WS
{
    public class Masters_WS : ServerBase
    {
        string jsondata1;

        private string name;
        private string alias;
        Ds_company_master objCompanymst = new Ds_company_master();

        SessionInfo objSessionInfo = new SessionInfo();

        Document objDocument = new Document();
        Ds_Bill_Entry_Save server_bill_entry_save = new Ds_Bill_Entry_Save();
        DSC_fees_status_WS server_fees_status = new DSC_fees_status_WS();
        Ds_Student_Course_detail_WS server_student_course = new Ds_Student_Course_detail_WS();
        DSC_userdataupload_WS server_userupload = new DSC_userdataupload_WS();
        DS_Feedback_Save_WS server_feedback = new DS_Feedback_Save_WS();
        DS_Feedback_calculation_WS server_feedback_calculation = new DS_Feedback_calculation_WS();

        public DataTable userMaster(string user_id)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "Select distinct user_id,user_name,user_type,mail from user_mst where user_status_flag = 'A' and user_id =@user_id";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetVendorname(string vendor_name)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT vendor_details.vendor_name,vendor_details.vendor_code FROM vendor_details " +

                        "WHERE  vendor_details.vendor_code = '" + vendor_name + "' and vendor_details.vendor_flag = 'Y'";



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
            catch (Exception ex)
            {
                return null;
            }
        }

        internal DataTable Getmymethod(string vendor_name, string a)
        {


            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT vendor_details.vendor_name,vendor_details.vendor_code FROM vendor_details " +

                        "WHERE  vendor_details.vendor_code = '" + vendor_name + "' and vendor_details.vendor_flag = 'Y'";



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
            catch (Exception ex)
            {
                return null;
            }
        }

        public BLReturnObject GetMenus()
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
            String SqlSelect = "";
            SqlSelect = "SELECT * FROM menu_mst WHERE (client_type = 'B')";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet dsDataSet = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(dsDataSet);
                if (dsDataSet.Tables[0].Rows.Count <= 0)
                {
                    objBLReturnObject.ServerMessage = "There is no Groups";
                    objBLReturnObject.ExecutionStatus = 2;
                }
                else
                {
                    objBLReturnObject.dt_ReturnedTables[0] = dsDataSet.Tables[0];
                    objBLReturnObject.ServerMessage = "List of Currently defined Groups";
                    objBLReturnObject.ExecutionStatus = 1;
                }
            }
            catch (Exception e)
            {
                objBLReturnObject.ServerMessage = "An error occurred, while retrieving Groups.\n" + e.Message;
                objBLReturnObject.ExecutionStatus = 2;
                DBConnection.Close();
            }
            //*****************************************************************************************
            /* CLOSE CONNECTION*/
            DBConnection.Close();
            //*****************************************************************************************
            return objBLReturnObject;
        }

        public BLReturnObject GetMenus(String GroupID)
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
            String SqlSelect = "";
            SqlSelect = "SELECT menu_mst.menu_id, menu_mst.pmenu_id, menu_mst.menu_desc, " +
                "menu_mst.window_name, menu_mst.window_desc, group_rights.group_id " +
                "FROM group_rights INNER JOIN menu_mst ON group_rights.menu_id = menu_mst.menu_id " +
                "WHERE (menu_mst.client_type = 'B') AND (group_rights.group_id = '" + GroupID + "')";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet dsDataSet = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(dsDataSet);
                if (dsDataSet.Tables[0].Rows.Count <= 0)
                {
                    objBLReturnObject.ServerMessage = "There is no Groups";
                    objBLReturnObject.ExecutionStatus = 2;
                }
                else
                {
                    objBLReturnObject.dt_ReturnedTables[0] = dsDataSet.Tables[0];
                    objBLReturnObject.ServerMessage = "List of Currently defined Groups";
                    objBLReturnObject.ExecutionStatus = 1;
                }
            }
            catch (Exception e)
            {
                objBLReturnObject.ServerMessage = "An error occurred, while retrieving Groups.\n" + e.Message;
                objBLReturnObject.ExecutionStatus = 2;
                DBConnection.Close();
            }
            //*****************************************************************************************
            /* CLOSE CONNECTION*/
            DBConnection.Close();
            //*****************************************************************************************
            return objBLReturnObject;
        }

        public Boolean DeleteGroupsRights(String groupID)
        {
            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();
            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "DELETE FROM group_rights WHERE group_id IN (" + groupID + ")";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            try
            {
                DBCommand.ExecuteNonQuery();
                DBConnection.Close();
                return true;
            }
            catch (Exception e)
            {
                DBConnection.Close();
                return false;
            }
        }

        public Boolean DeleteOldRights(String GroupID)
        {
            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();
            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "DELETE FROM group_rights WHERE group_id = '" + GroupID + "'";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            try
            {
                DBCommand.ExecuteNonQuery();
                DBConnection.Close();
                return true;
            }
            catch (Exception)
            {
                DBConnection.Close();
                return false;
            }
        }

        public DataTable GetCategoryMaster()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "Select category_code,category_name from category_mst where category_flag = 'Y'";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable getforgetpwd(string user)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT password,user_id, email FROM user_mst WHERE user_id= '" + user + "'  and (status = 'A')";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        #region Retrieve Get Method

        public DataTable get_user_data_for_pay_slip(String user_id, String sem_code)
        {
            try
            {
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                //"SELECT user_mst.*, w_employee_master.full_name,  w_employee_master.first_name, w_employee_master.middle_name, w_employee_master.last_name, " +
                //"w_employee_master.user_short_name FROM user_mst LEFT OUTER JOIN w_employee_master ON user_mst.user_id = w_employee_master.user_id " +
                //"WHERE (user_mst.user_id = @userid)";

                SqlSelect = "select * from user_mst " +
                         " INNER JOIN department_mst on  user_mst.dept_code =  department_mst.dept_code  " +

                        " WHERE user_mst.user_status_flag = 'A' and  user_mst.user_id =@user_id   ";



                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@user_id";
                para1.DbType = DbType.String;
                para1.Value = user_id;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);



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
                catch (Exception ex)
                {
                    return null;
                }
            }
            catch (Exception ex)
            {

                return null;
            }
        }

        public DataTable Get_time_table_data_for_student(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select ws_student_course_allocate_dtl.course_code,ws_course_mst.course_name,ws_course_wise_time.from_time,ws_course_wise_time.to_time,ws_course_wise_time.day_code,Convert(varchar(10),ws_course_wise_time.from_date,101) as from_date,Convert(varchar(10),ws_course_wise_time.to_date,101) as to_date from ws_student_course_allocate_dtl " +
                       "  INNER JOIN ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code " +
                       " INNER JOIN ws_course_wise_time on ws_student_course_allocate_dtl.course_code = ws_course_wise_time.course_code " +
                       " INNER JOIN day_mst on ws_course_wise_time.day_code = day_mst.day_code   where ws_student_course_allocate_dtl.cancel_flag ='N' and ws_student_course_allocate_dtl.user_id = @user_id and ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester ='" + year_code + "' and ws_course_wise_time.semester_type ='" + sem_code + "' and ws_course_wise_time.year_semester ='" + year_code + "' ";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);



            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_time_table_data_for_student_befor_allocation(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select ws_student_wise_course_dtl.course_code,ws_course_mst.course_name,ws_course_wise_time.from_time,ws_course_wise_time.to_time,ws_course_wise_time.day_code,Convert(varchar(10),ws_course_wise_time.from_date,101) as from_date,Convert(varchar(10),ws_course_wise_time.to_date,101) as to_date,ws_course_mst.color " +
                        "from ws_student_wise_course_dtl   INNER JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
                        "INNER JOIN ws_course_wise_time on ws_student_wise_course_dtl.course_code = ws_course_wise_time.course_code INNER JOIN day_mst on ws_course_wise_time.day_code = day_mst.day_code " +
                        "where ws_student_wise_course_dtl.cancel_flag ='N' and (ws_student_wise_course_dtl.status ='S' or ws_student_wise_course_dtl.status ='R') and ws_student_wise_course_dtl.user_id = @user_id  ";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);


            if (sem_code != "")
            {
                SqlSelect = SqlSelect + " and ws_student_wise_course_dtl.semester_type = @sem_code and ws_course_mst.semester_type = @sem_code and ws_course_wise_time.semester_type  = @sem_code   ";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@sem_code";
                para2.DbType = DbType.String;
                para2.Value = sem_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and ws_student_wise_course_dtl.year_semester = @year_code and ws_course_mst.year_semester = @year_code and ws_course_wise_time.year_semester  = @year_code ";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@year_code";
                para3.DbType = DbType.String;
                para3.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_course_data_for_student_selection()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select course_mst.course_code,course_mst.course_name,course_mst.course_credits,course_type,course_wise_semester.semester_code from course_mst INNER JOIN " +
                        "course_wise_semester on course_mst.course_code = course_wise_semester.course_code where course_mst.cancel_flag = 'N'	";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_saved_selected_course_data_for_report(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select student_wise_course_dtl.course_code,course_mst.course_name,student_wise_course_dtl.course_type,COUNT(student_wise_course_dtl.course_code) as total_course,department_wise_course_dtl.available_seat,department_mst.dept_name " +
                        "from student_wise_course_dtl INNER JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code INNER JOIN   course_mst on student_wise_course_dtl.course_code = course_mst.course_code " +
                        " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code where student_wise_course_dtl.cancel_flag = 'N'   and student_wise_course_dtl.status ='R' ";


            if (sem_code == "M")
            {
                SqlSelect = SqlSelect + " and student_wise_course_dtl.semester_code in ('1','3','5','7','9') and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";

            }
            else if (sem_code == "S")
            {
                SqlSelect = SqlSelect + " and student_wise_course_dtl.semester_code in ('2','4','6','8','10') and department_wise_course_dtl.semester_code in ('2','4','6','8','10') ";

            }

            SqlSelect = SqlSelect + "GROUP BY student_wise_course_dtl.course_code,student_wise_course_dtl.course_type,course_mst.course_name,department_mst.dept_name ";

            //IDataParameter para2 = DBObjectFactory.GetParameterObject();
            //para2.ParameterName = "@year_code";
            //para2.DbType = DbType.String;
            //para2.Value = year_code;
            //DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_WS_saved_selected_course_data_for_report(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select ws_student_wise_course_dtl.course_code,ws_course_mst.course_name,ws_student_wise_course_dtl.course_type,COUNT(ws_student_wise_course_dtl.course_code) as total_course,department_mst.dept_name,ws_course_mst.available_seat " +
                        "from ws_student_wise_course_dtl  INNER JOIN   ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
                        " INNER JOIN department_mst on ws_student_wise_course_dtl.dept_code = department_mst.dept_code where ws_student_wise_course_dtl.cancel_flag = 'N'   and (ws_student_wise_course_dtl.status ='R' or ws_student_wise_course_dtl.status ='A') ";


            if (sem_code != "" && year_code != "")
            {
                SqlSelect = SqlSelect + " and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";

            }


            SqlSelect = SqlSelect + "GROUP BY ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type,ws_course_mst.course_name,department_mst.dept_name,ws_course_mst.available_seat ";

            //IDataParameter para2 = DBObjectFactory.GetParameterObject();
            //para2.ParameterName = "@year_code";
            //para2.DbType = DbType.String;
            //para2.Value = year_code;
            //DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_term_condition_data(String user_id, String sem_code, string year_code)
        {
            try
            {
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                SqlSelect = " select * from ws_term_condition where cancel_flag = 'N' and user_id = '" + user_id + "' and semester_type ='" + sem_code + "' and year_semester = '" + year_code + "' ";



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
                catch (Exception ex)
                {
                    return null;
                }
            }
            catch (Exception ex)
            {

                return null;
            }
        }

        public DataTable Get_total_allocate_course_for_second_round(String user_id, String sem_code, string year_code)
        {
            try
            {
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";

                SqlSelect = "SELECT ws_student_course_allocate_dtl.course_code , COUNT(ws_student_course_allocate_dtl.course_code) as total_course FROM ws_student_course_allocate_dtl " +

                            " where cancel_flag = 'N' and semester_type ='" + sem_code + "' and year_semester = '" + year_code + "' GROUP BY course_code ";



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
                catch (Exception ex)
                {
                    return null;
                }
            }
            catch (Exception ex)
            {

                return null;
            }
        }

        public DataTable Get_student_assigned_current_sem_data_for_feedback(string user_id, string sem_code, string year_code, string disable_course)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "SELECT ws_student_course_allocate_dtl.doc_no,ws_student_course_allocate_dtl.course_code  as course_code ,ws_course_mst.course_code +'-'+ ws_course_mst.course_name as course,department_mst.dept_name FROM ws_student_course_allocate_dtl " +
                        " INNER JOIN ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code " +
                        "INNER JOIN department_mst on ws_course_mst.dept_code = department_mst.dept_code " +
                        "where ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "' and ws_student_course_allocate_dtl.user_id = '" + user_id + "' " +
                        " and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' and ws_student_course_allocate_dtl.cancel_flag ='N' and ws_course_mst.cancel_flag ='N' and ws_student_course_allocate_dtl.course_code not in (" + disable_course + ") ";

            SqlSelect = SqlSelect + " order by course_code";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_allocation_publish_dtl(string sem_code, string year_code)
        {
            String SqlSelect = "";
            string year = DateTime.Now.Year.ToString();

            SqlSelect = "select * from ws_publish_allocation_dtl where semester_type='" + sem_code + "' and year_semester='" + year_code + "' and publish_flag='Y'";

            return Get_data(SqlSelect);
        }

        public DataTable get_feedback_disable_course_data(string current_sem, string current_year, string course_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = @" select * from ws_feedback_disable_course where cancel_flag ='N' 
                         and semester_type = '" + current_sem + "' and year_semester = '" + current_year + "'  ";

            if (course_code != "")
            {
                SqlSelect = SqlSelect + " and course_code = '" + course_code + "' ";
            }

            return Get_data(SqlSelect);
        }

        public DataTable Get_student_saved_feedback_data_for_Feedback_dashboard(string course_code, string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            //SqlSelect = " SELECT DISTINCT user_id,current_sem_code,course_code +'~' +course_type as course FROM student_feedback_dtl where cancel_flag = 'N' and submit_status = 'Y' and user_id ='" + user_id + "' and current_sem_code ='" + sem_code + "'  order by course";

            SqlSelect = " SELECT convert(varchar(11),created_date,106) as created_date,convert(varchar(11),last_modified_date,106) as last_modified_date ,* FROM ws_student_feedback_dtl where cancel_flag = 'N' and  user_id ='" + user_id + "' and semester_type =  '" + sem_code + "' and year_semester = '" + year_code + "'  ";

            if (course_code != "")
            {
                SqlSelect = SqlSelect + " and course_code = '" + course_code + "' ";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_instructor_code_for_course_code(string course_code, string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT ws_course_wise_instructor.course_code,ws_course_wise_instructor.instructor_code,instructor_mst.instructor_name FROM ws_course_wise_instructor INNER JOIN " +
                        " instructor_mst on ws_course_wise_instructor.instructor_code = instructor_mst.instructor_code " +
                        " where course_code = '" + course_code + "' and instructor_mst.cancel_flag = 'N' and ws_course_wise_instructor.semester_type = '" + sem_code + "' and ws_course_wise_instructor.year_semester ='" + year_code + "' ";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_saved_feedback_data(string user_id, string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT DISTINCT user_id,current_sem_code,course_code as course FROM ws_student_feedback_dtl where cancel_flag = 'N' and user_id ='" + user_id + "' and semester_type ='" + sem_code + "' and year_semester = '" + year_code + "' and submit_status = 'Y'  order by course";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_saved_course_feedback_data(string user_id, string sem_code, string year_code, string courde_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = " SELECT * FROM ws_student_feedback_dtl where cancel_flag = 'N' and user_id ='" + user_id + "' and semester_type ='" + sem_code + "' and year_semester = '" + year_code + "' and course_code ='" + courde_code + "' and submit_status = 'Y'  order by course_code";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_feedback_instruction_mst_data(string course_typology, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "select * from ws_feedback_instructions_mst " +
                        " where cancel_flag = 'N'  and ws_feedback_instructions_mst.semester_type = '" + sem_code + "' and ws_feedback_instructions_mst.year_semester = '" + year_code + "' ";


            if (course_typology != "")
            {
                SqlSelect = SqlSelect + "and ws_feedback_instructions_mst.course_typology = '" + course_typology + "'";
            }
            SqlSelect = SqlSelect + " order by feedback_type,sr_no ";




            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_saved_feedback_data_for_submit(string course_code, string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            //SqlSelect = " SELECT DISTINCT user_id,current_sem_code,course_code +'~' +course_type as course FROM student_feedback_dtl where cancel_flag = 'N' and submit_status = 'Y' and user_id ='" + user_id + "' and current_sem_code ='" + sem_code + "'  order by course";

            SqlSelect = " SELECT * FROM ws_student_feedback_dtl where cancel_flag = 'N' and submit_status = 'N' and user_id ='" + user_id + "' and semester_type =  '" + sem_code + "' and year_semester = '" + year_code + "'   ";

            if (course_code != "")
            {
                SqlSelect = SqlSelect + " and course_code = '" + course_code + "' ";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_feedback_status_report(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            //SqlSelect = " SELECT DISTINCT user_id,current_sem_code,course_code +'~' +course_type as course FROM student_feedback_dtl where cancel_flag = 'N' and submit_status = 'Y' and user_id ='" + user_id + "' and current_sem_code ='" + sem_code + "'  order by course";

            SqlSelect = " WITH feedback_status (user_name,mail,user_id, total_course, total_feedback,status) " +
                        " AS " +
                        " ( " +
                        " select user_mst.user_name,user_mst.mail,ws_student_course_allocate_dtl.user_id,count(ws_student_course_allocate_dtl.course_code) as total_course " +
                        " ,isnull(feedback.total_feedback ,0)as total_feedback,case when count(ws_student_course_allocate_dtl.course_code) = total_feedback then 'Completed' else 'Not Completed' end as status " +
                        " from ws_student_course_allocate_dtl " +
                        " left join ( " +
                        " select user_id,count(distinct course_code) as total_feedback from ws_student_feedback_dtl " +
                        " where  ws_student_feedback_dtl.semester_type = '" + sem_code + "' and ws_student_feedback_dtl.year_semester ='" + year_code + "' and  " +
                        " ws_student_feedback_dtl.submit_status ='Y' and ws_student_feedback_dtl.cancel_flag = 'N' group by user_id " +

                        " ) as feedback on ws_student_course_allocate_dtl.user_id = feedback.user_id inner join user_mst on ws_student_course_allocate_dtl.user_id = user_mst.user_id " +
                        " where ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester ='" + year_code + "'  " +
                        " and ws_student_course_allocate_dtl.cancel_flag ='N' and user_mst.user_status_flag ='A' and user_mst.cancel_flag ='N'  " +
                        " group by user_mst.user_name,user_mst.mail,ws_student_course_allocate_dtl.user_id,feedback.total_feedback  " +
                        " ) " +
                        " select * from feedback_status ";





            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_country_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " selecT * from CountryMst order by name";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_Non_cept_registered_student(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = " select user_id,user_name,mail,gender,mobile_no" +
            //            " from user_mst" +
            //            " where dept_code='7'";

            SqlSelect = " SELECT distinct user_mst.user_id,user_name,mail,case gender when 'M' then 'Male' when 'F' then 'Female' end as gender,address,city,state,(case country when '1' then 'India' when '2' then other_county end) as country" +
                        " ,convert(varchar(10),dob,103) as dob,phone_no,mobile_no,blood_group,place_of_birth,nationality,local_address,academic_prog,year_of_Enrollment,year_of_passing" +
                        " ,name_of_university,full_name_of_degree,prof_exp,address_of_university,marks,about_here,agree_affidavit,agree_reg_process,convert(varchar(10),user_mst.created_date,103) as joining_date,prof_details " +
                        " ,ws_student_certificate_dtl.bonafide_certi_name,ws_student_certificate_dtl.degree_certificate_name,ws_student_certificate_dtl.letter_organization " +
                        " FROM user_mst  left join ws_student_certificate_dtl on user_mst.user_id = ws_student_certificate_dtl.user_id " +
                        " where user_mst.cancel_flag='N' and ws_semester_type = '" + sem_code + "'   and   ws_year_semester= '" + year_code + "' and dept_code ='7' ";

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and  user_mst.dept_code ='" + dept_code + "'";
            }




            //,[dept_code]
            //,[alternet_mail]
            //,[start_date]
            //,[end_date]
            //,[pass_expiry_date]
            //,[user_status_flag]
            //,[last_login_date]
            //,[cancel_flag]
            //,[created_by]
            //,[created_date]
            //,[created_host]
            //,[last_modified_by]
            //,[last_midified_date]
            //,[last_modified_host]
            //,[user_dept]
            //,[ws_semester_type]
            //,[ws_year_semester]  


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_student_passport_detail(string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select um.user_name,dm.dept_name,* from student_transcript_dtl as st inner join user_mst as um on st.user_id = um.user_id inner join department_mst dm on um.dept_code = dm.dept_code   where passport_scan_copy != '' and um.user_status_flag ='A' ";

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and  um.dept_code ='" + dept_code + "'";
            }

            return Get_data(SqlSelect);
        }

        public DataTable get_successfully_paid_fees_details(string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = " select user_id,user_name,mail,gender,mobile_no" +
            //            " from user_mst" +
            //            " where dept_code='7'";

            SqlSelect = " SELECT transaction_id, ws_applicationpaymenttransaction.user_id ,user_mst.user_name,department_mst.dept_name," +
                        " payment_transaction_reference_id, payment_authorization_code,Citrus_PaymentMode, Citrus_TxRefNo, amount," +
                        " convert(varchar(10),ws_applicationpaymenttransaction.created_date,103) as created_date,payment_root_transaction_reference_no" +
                        " FROM ws_applicationpaymenttransaction " +
                        " inner join user_mst on ws_applicationpaymenttransaction.user_id = user_mst.user_id" +
                        " inner join department_mst on ws_applicationpaymenttransaction.dept_id = department_mst.dept_code" +
                        " WHERE (payment_response_code = '0') AND (payment_response_msg='Transaction Successfull' OR payment_response_msg='Transaction Successful') AND (semester_type = '" + sem_code + "') and (year_semester='" + year_code + "')" +
                        " ORDER BY created_date DESC";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_allocate_user_for_send_mail(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";

            SqlSelect = @" select ws_student_course_allocate_dtl.user_id,SUM(cast(credits as int)) ,user_mst.dept_code , case  when user_mst.dept_code = '7' then  '1' else user_mst.prog_code end as prog_code ,user_mst.mail
                        from ws_student_course_allocate_dtl
                        inner join user_mst on ws_student_course_allocate_dtl.user_id = user_mst.user_id
                        where semester_type =@sem_code and year_semester =@year_code and ws_student_course_allocate_dtl.cancel_flag ='N'
                        and user_mst.user_status_flag ='A' and user_mst.cancel_flag ='N'
                        group by ws_student_course_allocate_dtl.user_id,user_mst.dept_code,user_mst.prog_code,user_mst.mail
                        order by user_mst.dept_code,user_mst.prog_code";

            IDataParameter para2 = DBObjectFactory.GetParameterObject();

            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@year_code";
            para2.DbType = DbType.String;
            para2.Value = year_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            return Get_data(SqlSelect);


        }

        public DataTable get_Student_not_allocate_Course_for_send_mail(string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";

            SqlSelect = @" select distinct swc.user_id,um.dept_code , case  when um.dept_code = '7' then  '1' else um.prog_code end as prog_code ,um.mail 
                            from  ws_student_wise_course_dtl  as swc
                            inner join user_mst as um on swc.user_id=um.user_id
                            where  swc.status='A' and swc.cancel_flag='N' and  swc.semester_type=@sem_code and swc.year_semester=@year_code
                            and swc.user_id not in( select distinct sca.user_id from   ws_student_course_allocate_dtl  as sca
                            where  sca.cancel_flag='N' and  sca.semester_type=@sem_code and sca.year_semester=@year_code  ) ";

            IDataParameter para2 = DBObjectFactory.GetParameterObject();

            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@year_code";
            para2.DbType = DbType.String;
            para2.Value = year_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            return Get_data(SqlSelect);
        }

        #region Student Course Selection

        #region  For Mandatory Course

        public DataTable Get_mandatory_course_data_for_student(string dept_code, string prog_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code,course_mst.course_desc,course_mst.prerequisite from course_mst INNER JOIN " +
                        " department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code where course_mst.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='M' ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_mandatory_instructor_data_for_student(string dept_code, string prog_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                        " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                        " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='M' ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_mandatory_time_days_data_for_student(string dept_code, string prog_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                        " course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                        " INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='M' ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_mandatory_Area_data_for_student(string dept_code, string prog_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name " +
                        " from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
                        " INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='M' ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_mandatory_course_data_for_student_new(string dept_code, string prog_code, string sem_code, string prog_level_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code,course_mst.course_desc,course_mst.prerequisite from course_mst INNER JOIN " +
                        " department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code where course_mst.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='M' ";

            if (prog_level_code != "")
            {
                SqlSelect = SqlSelect + "and department_wise_course_dtl.prog_level_code =@prog_level_code ";
                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_level_code";
                para3.DbType = DbType.String;
                para3.Value = prog_level_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();

            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        #endregion

        public DataTable Get_saved_student_course_data(string user_id, string current_ws_sem, string current_ws_year)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_student_wise_course_dtl where ws_student_wise_course_dtl.status != 'C' and cancel_flag ='N' and user_id =@user_id  and semester_type= '" + current_ws_sem + "' and year_semester = '" + current_ws_year + "'  ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            //if (sem_code != "")
            //{
            //    SqlSelect = SqlSelect + " and current_sem_code=@sem_code";
            //    IDataParameter para2 = DBObjectFactory.GetParameterObject();
            //    para2.ParameterName = "@sem_code";
            //    para2.DbType = DbType.String;
            //    para2.Value = sem_code;
            //    DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            //}

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetEmailTemplate(string email_type, string type_content)
        {
            String SqlSelect = "";

            SqlSelect = "select * from email_content_details" +
                        " where email_type = @email_type and type_content = @type_content ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@email_type";
            para1.DbType = DbType.String;
            para1.Value = email_type;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@type_content";
            para2.DbType = DbType.String;
            para2.Value = type_content;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_current_sem_data(string user_id, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select student_wise_course_dtl.doc_no,student_wise_course_dtl.course_code,course_mst.course_name,student_wise_course_dtl.semester_code, " +
                        "case student_wise_course_dtl.course_type WHEN 'M' THEN 'Mandatory' when 'E' THEN 'Elective' END as course_type, " +
                        "student_wise_course_dtl.credits , case student_wise_course_dtl.gpa_nongpa WHEN 'G' THEN 'GPA' when 'N' THEN 'Non GPA' END as gpa_nongpa, " +
                        "student_wise_course_dtl.dept_code,department_mst.dept_name,student_wise_course_dtl.priority from student_wise_course_dtl inner JOIN course_mst on student_wise_course_dtl.course_code = course_mst.course_code " +
                        "LEFT JOIN  department_mst on student_wise_course_dtl.dept_code = department_mst.dept_code " +
                        "where  student_wise_course_dtl.cancel_flag ='N' and course_mst.cancel_flag ='N' and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_saved_current_sem_data(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";





            SqlSelect = "select ws_student_wise_course_dtl.doc_no,ws_student_wise_course_dtl.course_code + ' - ' + ws_course_mst.course_name as course,department_mst.dept_name from ws_student_wise_course_dtl " +

                      " INNER JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
                      " INNER JOIN department_mst on ws_course_mst.dept_code = department_mst.dept_code  " +
                      " where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status != 'C' and ws_course_mst.cancel_flag ='N' and ws_student_wise_course_dtl.user_id =@user_id and ws_student_wise_course_dtl.semester_type= '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "'  ";





            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);





            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_assigned_current_sem_data(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "select ws_student_course_allocate_dtl.doc_no,ws_student_course_allocate_dtl.course_code + ' - ' + ws_course_mst.course_name as course,department_mst.dept_name,ws_student_course_allocate_dtl.course_code from ws_student_course_allocate_dtl " +
                        " inner JOIN ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code " +

                        " INNER JOIN department_mst on ws_course_mst.dept_code = department_mst.dept_code  " +
                        " where  ws_student_course_allocate_dtl.cancel_flag ='N' and ws_course_mst.cancel_flag ='N' and ws_student_course_allocate_dtl.user_id =@user_id and ws_student_course_allocate_dtl.semester_type= '" + sem_code + "'  and ws_student_course_allocate_dtl.year_semester= '" + year_code + "'";



            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);




            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Get_student_assigned_agree_data(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "select * from ws_student_course_allocate_agree_dtl where user_id =@user_id and semester_type= '" + sem_code + "'  and year_semester= '" + year_code + "'";



            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_saved_current_sem_data_report(string user_id, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";





            SqlSelect = "select student_wise_course_dtl.doc_no,student_wise_course_dtl.course_code + ' - ' + course_mst.course_name as course,department_mst.dept_name,student_wise_course_dtl.course_type, " +
                        " case student_wise_course_dtl.gpa_nongpa when 'G' THEN 'GPA' when 'N' THEN 'Non GPA' else student_wise_course_dtl.gpa_nongpa END as gpa_nongpa from student_wise_course_dtl " +
                      " inner JOIN course_mst on student_wise_course_dtl.course_code = course_mst.course_code " +
                      " INNER JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code " +
                      " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  " +
                      " where  student_wise_course_dtl.cancel_flag ='N'  and course_mst.cancel_flag ='N' and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";



            if (Convert.ToInt32(sem_code) % 2 == 1)
            {


                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_assigned_current_sem_data_report(string user_id, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "select student_course_allocate_dtl.doc_no,student_course_allocate_dtl.course_code + ' - ' + course_mst.course_name as course,department_mst.dept_name,student_course_allocate_dtl.course_type, " +
                         " case student_course_allocate_dtl.gpa_nongpa when 'G' THEN 'GPA' when 'N' THEN 'Non GPA' else student_course_allocate_dtl.gpa_nongpa END as gpa_nongpa,student_course_allocate_dtl.course_code from student_course_allocate_dtl " +
                        " inner JOIN course_mst on student_course_allocate_dtl.course_code = course_mst.course_code " +
                        " INNER JOIN department_wise_course_dtl on student_course_allocate_dtl.course_code = department_wise_course_dtl.course_code " +
                        " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  " +
                        " where  student_course_allocate_dtl.cancel_flag ='N' and course_mst.cancel_flag ='N' and student_course_allocate_dtl.user_id =@user_id and student_course_allocate_dtl.current_sem_code=@sem_code ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {


                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }


            SqlSelect = SqlSelect + " order by  student_course_allocate_dtl.course_type , student_course_allocate_dtl.course_code";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_assigned_current_sem_data_report_for_drop_course(string user_id, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select student_course_allocate_dtl.doc_no,student_course_allocate_dtl.course_code + ' - ' + course_mst.course_name as course,department_mst.dept_name,student_course_allocate_dtl.course_type, " +
                         " case student_course_allocate_dtl.gpa_nongpa when 'G' THEN 'GPA' when 'N' THEN 'Non GPA' else student_course_allocate_dtl.gpa_nongpa END as gpa_nongpa,student_course_allocate_dtl.course_code from student_course_allocate_dtl " +
                        " inner JOIN course_mst on student_course_allocate_dtl.course_code = course_mst.course_code " +
                        " INNER JOIN department_wise_course_dtl on student_course_allocate_dtl.course_code = department_wise_course_dtl.course_code " +
                        " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  " +
                        " where  student_course_allocate_dtl.cancel_flag ='N' and student_course_allocate_dtl.course_type = 'E'  and course_mst.cancel_flag ='N' and student_course_allocate_dtl.user_id =@user_id and student_course_allocate_dtl.current_sem_code=@sem_code ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_registered_current_sem_data(string user_id, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            //SqlSelect = "select student_wise_course_dtl.doc_no,CONCAT(student_wise_course_dtl.course_code, ' - ', course_mst.course_name) as course,department_mst.dept_name from student_wise_course_dtl " +
            //            " inner JOIN course_mst on student_wise_course_dtl.course_code = course_mst.course_code " +
            //            " INNER JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code " +
            //            " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  " +
            //            " where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='S' and course_mst.cancel_flag ='N' and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";

            SqlSelect = "select * from student_wise_course_dtl  where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='R'  and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable check_student_allocate_current_sem_data(string user_id, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            //SqlSelect = "select student_wise_course_dtl.doc_no,CONCAT(student_wise_course_dtl.course_code, ' - ', course_mst.course_name) as course,department_mst.dept_name from student_wise_course_dtl " +
            //            " inner JOIN course_mst on student_wise_course_dtl.course_code = course_mst.course_code " +
            //            " INNER JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code " +
            //            " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  " +
            //            " where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='S' and course_mst.cancel_flag ='N' and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";

            SqlSelect = "select * from student_wise_course_dtl  where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='A'  and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_student_course_dtl_data(string user_id, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            //SqlSelect = "select student_wise_course_dtl.doc_no,CONCAT(student_wise_course_dtl.course_code, ' - ', course_mst.course_name) as course,department_mst.dept_name from student_wise_course_dtl " +
            //            " inner JOIN course_mst on student_wise_course_dtl.course_code = course_mst.course_code " +
            //            " INNER JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code " +
            //            " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  " +
            //            " where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='S' and course_mst.cancel_flag ='N' and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";

            SqlSelect = "select * from student_wise_course_dtl  where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='A'  and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_student_course_dtl_data(string sem_code, string year_code, string course_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";




            SqlSelect = "select * from ws_student_wise_course_dtl  where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status ='R'  and ws_student_wise_course_dtl.course_code ='" + course_code + "' and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' ";


            //IDataParameter para1 = DBObjectFactory.GetParameterObject();
            //para1.ParameterName = "@user_id";
            //para1.DbType = DbType.String;
            //para1.Value = user_id;
            //DBDataAdpterObject.SelectCommand.Parameters.Add(para1);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_student_allcate_course_dtl_data(string sem_code, string year_code, string course_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_student_course_allocate_dtl  where  ws_student_course_allocate_dtl.cancel_flag ='N'   and ws_student_course_allocate_dtl.course_code ='" + course_code + "' and ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "' ";


            //IDataParameter para1 = DBObjectFactory.GetParameterObject();
            //para1.ParameterName = "@user_id";
            //para1.DbType = DbType.String;
            //para1.Value = user_id;
            //DBDataAdpterObject.SelectCommand.Parameters.Add(para1);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Ws_Studnt_change_course_type(string sem_code, string year_code, string course_code, string dept_code, string prog_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = @" Select wsca.user_id, um.full_name,wsca.course_type from ws_student_course_allocate_dtl wsca
                           inner join ws_student_wise_course_dtl wswc on wswc.course_code = wsca.course_code
                           and wswc.user_id = wsca.user_id
                           and wswc.cancel_flag = wsca.cancel_flag
                           and wswc.semester_type = wsca.semester_type
                           and wswc.year_semester = wsca.year_semester
                           and wswc.course_type = wsca.course_type
                           inner join user_mst um on um.user_id = wsca.user_id
                           where wsca.semester_type='"+ sem_code + @"' and wsca.year_semester='"+ year_code + @"'
                           and wsca.cancel_flag='N'and wswc.status ='A' ";
            if (course_code != "")
            {
                SqlSelect += @" and wsca.course_code ='"+ course_code + "'";
            }
            if (dept_code != "")
            {
                SqlSelect += @" and wsca.dept_code ='" + dept_code + "'";
            }
            if (prog_code != "")
            {
                SqlSelect += @" and um.prog_code ='" + prog_code + "'";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_student_course_allocate_data(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";




            SqlSelect = "select * from ws_student_course_allocate_dtl  where  ws_student_course_allocate_dtl.cancel_flag ='N'  and ws_student_course_allocate_dtl.user_id =@user_id and ws_student_course_allocate_dtl.semester_type= '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester ='" + year_code + "' ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@sem_code";
            para2.DbType = DbType.String;
            para2.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);



            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable retrieve_student_data_for_modification(string user_id)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "Select *,convert(varchar(10),dob,103) as dob1 from user_mst where (user_type = 'S' or user_type = 'E' or user_type = 'HS') and user_status_flag = 'A' and user_id ='" + user_id + "' order by user_id ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        #region For Elective Course

        public DataTable Get_elective_current_sem_course_data_for_student(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code from course_mst INNER JOIN " +
            //            "department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code where course_mst.cancel_flag = 'N' " +
            //            " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='E' ";

            SqlSelect = "select department_wise_course_dtl.dept_code,department_mst.dept_name,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code,course_mst.course_desc,course_mst.prerequisite from course_mst INNER JOIN " +
                         "department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code where course_mst.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.dept_code=@dept_code and department_wise_course_dtl.course_type='E' " +
                        " UNION " +
                        "select department_wise_course_dtl.dept_code,department_mst.dept_name,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code,course_mst.course_desc,course_mst.prerequisite from course_mst INNER JOIN " +
                        " department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code where course_mst.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.prog_code =@prog_code and department_wise_course_dtl.dept_code<>@dept_code ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_course_data_for_student(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code from course_mst INNER JOIN " +
                        "department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code where course_mst.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code !=@dept_code and department_wise_course_dtl.prog_code =@prog_code ";




            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_Area_data_for_student(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                        " department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code  " +
                        " INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='E' " +
                         " UNION " +
                         "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                        "department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
                            "INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                         " where department_wise_course_dtl.cancel_flag = 'N' and department_wise_course_dtl.prog_code =@prog_code and department_wise_course_dtl.dept_code<>@dept_code ";



            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_instructor_data_for_student(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                        " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                       " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='E' ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }

            SqlSelect = SqlSelect + " Union " +
                   "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                   " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                  " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                   " and department_wise_course_dtl.dept_code <>@dept_code and department_wise_course_dtl.prog_code =@prog_code ";


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }




            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_time_days_data_for_student(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                        "course_wise_time.from_time + '-', course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                        "INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='E' ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }
            SqlSelect = SqlSelect + " UNION " +

         "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
            " course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
           "  INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
            "  where department_wise_course_dtl.cancel_flag = 'N' " +
            " and department_wise_course_dtl.dept_code <>@dept_code and department_wise_course_dtl.prog_code =@prog_code  ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);




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
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Get_elective_current_sem_course_data_for_student_new(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = " select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code from course_mst INNER JOIN " +
            //            "department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code where course_mst.cancel_flag = 'N' " +
            //            " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code =@prog_code and  department_wise_course_dtl.course_type ='E' ";

            SqlSelect = "select department_wise_course_dtl.dept_code,department_mst.dept_name,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code,course_mst.course_desc,course_mst.prerequisite from course_mst INNER JOIN " +
                         "department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code where course_mst.cancel_flag = 'N' " +
                        "  and  department_wise_course_dtl.dept_code=@dept_code and department_wise_course_dtl.course_type='E' " +
                        " UNION " +

                       " select department_wise_course_dtl.dept_code,department_mst.dept_name,department_wise_course_dtl.prog_code,course_mst.course_code, " +
                       " course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code, " +
                       " course_mst.course_desc,course_mst.prerequisite from course_mst INNER JOIN department_wise_course_dtl " +
                       " on course_mst.course_code = department_wise_course_dtl.course_code INNER JOIN department_mst " +
                       " on department_wise_course_dtl.dept_code = department_mst.dept_code where course_mst.cancel_flag = 'N' " +
                       " and  department_wise_course_dtl.dept_code=@dept_code and department_wise_course_dtl.course_type='M'and department_wise_course_dtl.prog_code <> @prog_code " +




                       " UNION " +
                        "select department_wise_course_dtl.dept_code,department_mst.dept_name,department_wise_course_dtl.prog_code,course_mst.course_code,course_mst.course_name,course_mst.course_credits,department_wise_course_dtl.course_type,department_wise_course_dtl.semester_code,course_mst.course_desc,course_mst.prerequisite from course_mst INNER JOIN " +
                        " department_wise_course_dtl on course_mst.course_code = department_wise_course_dtl.course_code INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code where course_mst.cancel_flag = 'N' " +
                        "  and department_wise_course_dtl.dept_code<>@dept_code ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_instructor_data_for_student_new(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                        " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                       " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code  and  department_wise_course_dtl.course_type ='E' ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }

            SqlSelect = SqlSelect + " Union " +
                "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                       " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                      " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                       " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code <>@prog_code and  department_wise_course_dtl.course_type ='M' ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }


            SqlSelect = SqlSelect + " Union " +
                   "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                   " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                  " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                   " and department_wise_course_dtl.dept_code <>@dept_code ";


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }




            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_time_days_data_for_student_new(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                        " course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                        "INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and  department_wise_course_dtl.course_type ='E' ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }


            SqlSelect = SqlSelect + " UNION " +

                "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                      "course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                      "INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                      " where department_wise_course_dtl.cancel_flag = 'N' " +
                      " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code <>@prog_code and  department_wise_course_dtl.course_type ='M' ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }

            SqlSelect = SqlSelect + " UNION " +

         "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
            " course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
           "  INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
            "  where department_wise_course_dtl.cancel_flag = 'N' " +
            " and department_wise_course_dtl.dept_code <>@dept_code ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);




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
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Get_elective_Area_data_for_student_new(string dept_code, string prog_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                        " department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code  " +
                        " INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code  and  department_wise_course_dtl.course_type ='E' " +

                          " UNION " +
                         "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                        "department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
                            "INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                         " where department_wise_course_dtl.cancel_flag = 'N' and department_wise_course_dtl.prog_code <>@prog_code and department_wise_course_dtl.dept_code=@dept_code and department_wise_course_dtl.course_type ='M' " +
                         " UNION " +
                         "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                        "department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
                            "INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                         " where department_wise_course_dtl.cancel_flag = 'N'  and department_wise_course_dtl.dept_code<>@dept_code ";



            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
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
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Get_elective_current_sem_course_data_for_student_new1(string dept_code, string prog_code, string sem_code, string prog_level_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = " select * from ws_course_mst where cancel_flag = 'N' ";


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_instructor_data_for_student_new1(string dept_code, string prog_code, string sem_code, string prog_level_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                        " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                       " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code  and  department_wise_course_dtl.course_type ='E' ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }

            SqlSelect = SqlSelect + " Union " +
                "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                       " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                      " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                       " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code <>@prog_code and  department_wise_course_dtl.course_type ='M' ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }



            if (prog_level_code != "")
            {
                SqlSelect = SqlSelect + " Union " +
            "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                   " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                  " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                   " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code = @prog_code and  department_wise_course_dtl.course_type ='M' and  department_wise_course_dtl.prog_level_code <> @prog_level_code ";

                if (Convert.ToInt32(sem_code) % 2 == 1)
                {
                    //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                    //para3.ParameterName = "@sem_code";
                    //para3.DbType = DbType.String;
                    //para3.Value = "'1','3','5','7','9'";
                    //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                    //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                    SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
                }
                else
                {
                    //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                    //para3.ParameterName = "@sem_code";
                    //para3.DbType = DbType.String;
                    //para3.Value = "'2','4','6','8','10'";
                    //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                    SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
                }


                if (prog_level_code == "5" || prog_level_code == "7")
                {
                    SqlSelect = SqlSelect + " Union " +
                  "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                 " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                 " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code = @prog_code and  department_wise_course_dtl.course_type ='M' and  department_wise_course_dtl.prog_level_code = @prog_level_code ";

                    if (Convert.ToInt32(sem_code) % 2 == 1)
                    {
                        //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                        //para3.ParameterName = "@sem_code";
                        //para3.DbType = DbType.String;
                        //para3.Value = "'1','3','5','7','9'";
                        //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                        //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                        SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
                    }
                    else
                    {
                        //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                        //para3.ParameterName = "@sem_code";
                        //para3.DbType = DbType.String;
                        //para3.Value = "'2','4','6','8','10'";
                        //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                        SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
                    }


                }

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_level_code";
                para3.DbType = DbType.String;
                para3.Value = prog_level_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

            }


            SqlSelect = SqlSelect + " Union " +
                   "(select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, " +
                   " course_wise_instructor.instructor_code,instructor_mst.instructor_name from department_wise_course_dtl INNER JOIN course_wise_instructor on department_wise_course_dtl.course_code = course_wise_instructor.course_code " +
                  " INNER JOIN instructor_mst on course_wise_instructor.instructor_code = instructor_mst.instructor_code where department_wise_course_dtl.cancel_flag = 'N' " +
                   " and department_wise_course_dtl.dept_code <>@dept_code ";


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }




            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);




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
            catch (Exception ex)
            {
                return null;
            }
        }



        public DataTable Get_elective_time_days_data_for_student_new1(string dept_code, string prog_code, string sem_code, string prog_level_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                        "course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                        "INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code and  department_wise_course_dtl.course_type ='E' ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }


            SqlSelect = SqlSelect + " UNION " +

                "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                      "course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                      "INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                      " where department_wise_course_dtl.cancel_flag = 'N' " +
                      " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code <>@prog_code and  department_wise_course_dtl.course_type ='M' ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }


            if (prog_level_code != "")
            {
                SqlSelect = SqlSelect + " UNION " +

             "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                   "course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                   "INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                   " where department_wise_course_dtl.cancel_flag = 'N' " +
                   " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code = @prog_code and  department_wise_course_dtl.course_type ='M' and  department_wise_course_dtl.prog_level_code <> @prog_level_code ";
                if (Convert.ToInt32(sem_code) % 2 == 1)
                {
                    //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                    //para3.ParameterName = "@sem_code";
                    //para3.DbType = DbType.String;
                    //para3.Value = "'1','3','5','7','9'";
                    //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                    //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                    SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
                }
                else
                {
                    //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                    //para3.ParameterName = "@sem_code";
                    //para3.DbType = DbType.String;
                    //para3.Value = "'2','4','6','8','10'";
                    //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                    SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
                }


                if (prog_level_code == "5" || prog_level_code == "7")
                {
                    SqlSelect = SqlSelect + " UNION " +

             "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
                   "course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
                   "INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
                   " where department_wise_course_dtl.cancel_flag = 'N' " +
                   " and department_wise_course_dtl.dept_code =@dept_code and department_wise_course_dtl.prog_code = @prog_code and  department_wise_course_dtl.course_type ='M' and  department_wise_course_dtl.prog_level_code = @prog_level_code ";
                    if (Convert.ToInt32(sem_code) % 2 == 1)
                    {
                        //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                        //para3.ParameterName = "@sem_code";
                        //para3.DbType = DbType.String;
                        //para3.Value = "'1','3','5','7','9'";
                        //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                        //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                        SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
                    }
                    else
                    {
                        //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                        //para3.ParameterName = "@sem_code";
                        //para3.DbType = DbType.String;
                        //para3.Value = "'2','4','6','8','10'";
                        //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                        SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
                    }
                }

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_level_code";
                para3.DbType = DbType.String;
                para3.Value = prog_level_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }




            SqlSelect = SqlSelect + " UNION " +

         "(select course_wise_time.doc_no,department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code, course_wise_time.from_time, + course_wise_time.To_time ,day_mst.day_name, " +
            "course_wise_time.from_time + '-' + course_wise_time.To_time as time,day_mst.day_code from department_wise_course_dtl " +
           "  INNER JOIN course_wise_time on department_wise_course_dtl.course_code = course_wise_time.course_code INNER JOIN day_mst on course_wise_time.day_code = day_mst.day_code " +
            "  where department_wise_course_dtl.cancel_flag = 'N' " +
            " and department_wise_course_dtl.dept_code <>@dept_code ";
            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9') order by course_wise_instructor.doc_no )";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') order by course_wise_instructor.doc_no )";
            }

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_elective_Area_data_for_student_new1(string dept_code, string prog_code, string sem_code, string prog_level_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                        " department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code  " +
                        " INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' " +
                        " and department_wise_course_dtl.dept_code =@dept_code  and  department_wise_course_dtl.course_type ='E' ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {


                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {


                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }


            SqlSelect = SqlSelect + " UNION " +
            "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
           "department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
               "INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
            " where department_wise_course_dtl.cancel_flag = 'N' and department_wise_course_dtl.prog_code <>@prog_code and department_wise_course_dtl.dept_code=@dept_code and department_wise_course_dtl.course_type ='M' ";

            if (Convert.ToInt32(sem_code) % 2 == 1)
            {


                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {


                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }


            if (prog_level_code != "")
            {
                SqlSelect = SqlSelect + " UNION " +
                               "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                              "department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
                                  "INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                               " where department_wise_course_dtl.cancel_flag = 'N' and department_wise_course_dtl.prog_code = @prog_code and department_wise_course_dtl.dept_code=@dept_code and department_wise_course_dtl.course_type ='M' and department_wise_course_dtl.prog_level_code <> @prog_level_code ";

                if (Convert.ToInt32(sem_code) % 2 == 1)
                {


                    SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
                }
                else
                {


                    SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
                }

                if (prog_level_code == "5" || prog_level_code == "7")
                {
                    SqlSelect = SqlSelect + " UNION " +
                               "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                              "department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
                                  "INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                               " where department_wise_course_dtl.cancel_flag = 'N' and department_wise_course_dtl.prog_code = @prog_code and department_wise_course_dtl.dept_code=@dept_code and department_wise_course_dtl.course_type ='M' and department_wise_course_dtl.prog_level_code = @prog_level_code ";

                    if (Convert.ToInt32(sem_code) % 2 == 1)
                    {


                        SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
                    }
                    else
                    {


                        SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
                    }
                }

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_level_code";
                para3.DbType = DbType.String;
                para3.Value = prog_level_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            SqlSelect = SqlSelect + " UNION " +
                    "select department_wise_course_dtl.dept_code,department_wise_course_dtl.prog_code,department_wise_course_dtl.course_code,department_wise_course_dtl.semester_code,course_wise_area.area_code,area_mst.area_name, " +
                   "department_wise_course_dtl.course_type from department_wise_course_dtl INNER JOIN course_wise_area on department_wise_course_dtl.course_code = course_wise_area.course_code " +
                       "INNER JOIN area_mst on course_wise_area.area_code = area_mst.area_code " +
                    " where department_wise_course_dtl.cancel_flag = 'N'  and department_wise_course_dtl.dept_code<>@dept_code ";



            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@prog_code";
            para2.DbType = DbType.String;
            para2.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);


            if (Convert.ToInt32(sem_code) % 2 == 1)
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'1','3','5','7','9'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                //SqlSelect = SqlSelect.Replace("@sem_code", "'1','3','5','7','9'");

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')";
            }
            else
            {
                //IDataParameter para3 = DBObjectFactory.GetParameterObject();
                //para3.ParameterName = "@sem_code";
                //para3.DbType = DbType.String;
                //para3.Value = "'2','4','6','8','10'";
                //DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_ws_course_mst_data(string sem_code, string year_code, string prof_course, string current_round)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = " select * from ws_course_mst inner join department_mst on ws_course_mst.dept_code =  department_mst.dept_code where ws_course_mst.cancel_flag = 'N' " +
                  " and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "'";

            if (prof_course == "P")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.prof_course = 'P' ";
            }

            if (current_round != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.round = '" + current_round + "' ";
            }


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        //public DataTable Get_ws_course_wise_instructor_data(string sem_code ,string year_code)
        //{

        //    DBDataAdpterObject.SelectCommand.Parameters.Clear();
        //    String SqlSelect = "";



        //    SqlSelect = " select ws_course_wise_instructor.course_code,ws_course_wise_instructor.instructor_code,ws_instructor_mst.instructor_name from ws_course_wise_instructor inner join ws_instructor_mst on ws_course_wise_instructor.instructor_code =  ws_instructor_mst.instructor_code ";


        //    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        DBDataAdpterObject.Fill(ds);
        //        if (ds.Tables[0].Rows.Count <= 0)
        //            return null;
        //        else
        //        {
        //            return ds.Tables[0];
        //        }

        //    }
        //    catch (Exception ex)
        //    {
        //        return null;
        //    }
        //}

        public DataTable Get_ws_course_wise_instructor_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = " select ws_course_wise_instructor.course_code,ws_course_wise_instructor.instructor_code,instructor_mst.instructor_name from ws_course_wise_instructor inner join instructor_mst on ws_course_wise_instructor.instructor_code =  instructor_mst.instructor_code " +
                " where ws_course_wise_instructor.semester_type = '" + sem_code + "' and ws_course_wise_instructor.year_semester = '" + year_code + "' and ws_course_wise_instructor.cancel_flag ='N' and instructor_mst.cancel_flag ='N'";


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        //public DataTable Get_ws_course_wise_time_data()
        //{

        //    DBDataAdpterObject.SelectCommand.Parameters.Clear();
        //    String SqlSelect = "";

        //    SqlSelect = " SELECT ws_course_wise_time.course_code, CONCAT(DATE_FORMAT(ws_course_wise_time.from_date, '%d/%m/%Y') , '-', DATE_FORMAT(ws_course_wise_time.to_date, '%d/%m/%Y') ) as date ,CONCAT(ws_course_wise_time.from_time, '-', ws_course_wise_time.To_time) as time " +
        //                ",day_mst.day_name,ws_course_wise_time.city_name FROM ws_course_wise_time inner JOIN day_mst on ws_course_wise_time.day_code = day_mst.day_code  where ws_course_wise_time.cancel_flag = 'N';  ";





        //    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        DBDataAdpterObject.Fill(ds);
        //        if (ds.Tables[0].Rows.Count <= 0)
        //            return null;
        //        else
        //            return ds.Tables[0];

        //    }
        //    catch (Exception ex)
        //    {
        //        return null;
        //    }
        //}



        public DataTable Get_ws_course_wise_time_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT ws_course_wise_time.course_code, CONVERT(VARCHAR(10),ws_course_wise_time.from_date,103) + '-' +  CONVERT(VARCHAR(10),ws_course_wise_time.to_date,103) as date " +
                        " ,ws_course_wise_time.from_time + '-' + ws_course_wise_time.To_time as time ," +
                        " day_mst.day_name,ws_course_wise_time.city_name FROM ws_course_wise_time inner JOIN day_mst  on ws_course_wise_time.day_code = day_mst.day_code  " +
                        " where ws_course_wise_time.cancel_flag = 'N' and ws_course_wise_time.semester_type = '" + sem_code + "' and ws_course_wise_time.year_semester ='" + year_code + "' order by ws_course_wise_time.course_code,date ";




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
            catch (Exception ex)
            {
                return null;
            }
        }
        public DataTable Get_ws_course_wise_time_data_for_check()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT ws_course_wise_time.course_code, ws_course_wise_time.day_code, ws_course_wise_time.from_date,ws_course_wise_time.to_date,ws_course_wise_time.from_time,ws_course_wise_time.to_time ,   CONVERT(VARCHAR(10),ws_course_wise_time.from_date,103) + '-' +  CONVERT(VARCHAR(10),ws_course_wise_time.to_date,103) as date , ws_course_wise_time.from_time + '-' +  ws_course_wise_time.To_time as time " +
                        ",day_mst.day_name FROM ws_course_wise_time inner JOIN day_mst on ws_course_wise_time.day_code = day_mst.day_code  where ws_course_wise_time.cancel_flag = 'N'   ";





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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable check_ws_student_allocate_saved_data(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            //SqlSelect = "select student_wise_course_dtl.doc_no,CONCAT(student_wise_course_dtl.course_code, ' - ', course_mst.course_name) as course,department_mst.dept_name from student_wise_course_dtl " +
            //            " inner JOIN course_mst on student_wise_course_dtl.course_code = course_mst.course_code " +
            //            " INNER JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code " +
            //            " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  " +
            //            " where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='S' and course_mst.cancel_flag ='N' and student_wise_course_dtl.user_id =@user_id and student_wise_course_dtl.current_sem_code=@sem_code ";

            SqlSelect = "select * from ws_student_wise_course_dtl  where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status ='A'  and ws_student_wise_course_dtl.user_id =@user_id and ws_student_wise_course_dtl.semester_type = '" + sem_code + "'   and ws_student_wise_course_dtl.year_semester = '" + year_code + "'  ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);


            //if (sem_code != "")
            //{
            //    SqlSelect = SqlSelect + "   and student_wise_course_dtl.current_sem_code=@sem_code ";

            //    IDataParameter para2 = DBObjectFactory.GetParameterObject();
            //    para2.ParameterName = "@sem_code";
            //    para2.DbType = DbType.String;
            //    para2.Value = sem_code;
            //    DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            //}




            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_ws_student_registered(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";





            SqlSelect = "select * from ws_student_wise_course_dtl  where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status ='R'  and ws_student_wise_course_dtl.user_id =@user_id and ws_student_wise_course_dtl.semester_type = '" + sem_code + "'  and  ws_student_wise_course_dtl.year_semester = '" + year_code + "'  ";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);


            //if (sem_code != "")
            //{
            //    SqlSelect = SqlSelect + "   and ws_student_wise_course_dtl.current_sem_code=@sem_code ";

            //    IDataParameter para2 = DBObjectFactory.GetParameterObject();
            //    para2.ParameterName = "@sem_code";
            //    para2.DbType = DbType.String;
            //    para2.Value = sem_code;
            //    DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            //}





            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }
        #endregion

        #endregion

        #region assign course methods

        public DataTable get_course_seat_dtl(string year_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = " select DISTINCT student_wise_course_dtl.course_code,department_wise_course_dtl.available_seat,department_wise_course_dtl.year_code from student_wise_course_dtl inner JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code " +
            //            " where department_wise_course_dtl.year_code = @year_code and student_wise_course_dtl.cancel_flag ='N'  order by student_wise_course_dtl.course_code ";

            SqlSelect = " select DISTINCT student_wise_course_dtl.course_code,department_wise_course_dtl.available_seat,department_wise_course_dtl.year_code from student_wise_course_dtl inner JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code " +
                  " where  student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status ='R'  ";



            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and department_wise_course_dtl.year_code = @year_code";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            if (sem_code == "M")
            {
                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('1','3','5','7','9')  and student_wise_course_dtl.semester_type = '" + sem_code + "' ";

            }
            else if (sem_code == "S")
            {
                SqlSelect = SqlSelect + " and department_wise_course_dtl.semester_code in ('2','4','6','8','10') and student_wise_course_dtl.semester_type = '" + sem_code + "' ";

            }


            SqlSelect = SqlSelect + " order by student_wise_course_dtl.course_code  ";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_course_seat_dtl(string year_code, string sem_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = " select  distinct ws_student_wise_course_dtl.course_code ,ws_course_mst.available_seat " +
                  " FROM ws_student_wise_course_dtl inner JOIN ws_course_mst on  ws_student_wise_course_dtl.course_code = ws_course_mst.course_code where ws_student_wise_course_dtl.cancel_flag = 'N'  ";



            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";


            }

            if (sem_code != "")
            {
                SqlSelect = SqlSelect + " and  ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_course_mst.semester_type = '" + sem_code + "' ";

            }



            SqlSelect = SqlSelect + " order by ws_student_wise_course_dtl.course_code  ";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_all_course_dtl(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from student_wise_course_dtl " +
                        " where  student_wise_course_dtl.cancel_flag ='N'  and student_wise_course_dtl.status = 'R' ";


            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and student_wise_course_dtl.year_code = @year_code";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }



            if (sem_code == "M")
            {
                SqlSelect = SqlSelect + " and student_wise_course_dtl.current_sem_code in ('1','3','5','7','9') ";
            }
            else if (sem_code == "S")
            {
                SqlSelect = SqlSelect + " and student_wise_course_dtl.current_sem_code in ('2','4','6','8','10') ";
            }
            {


            }


            SqlSelect = SqlSelect + " order by student_wise_course_dtl.course_code ";


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_all_course_dtl(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_student_wise_course_dtl " +
                        " where  ws_student_wise_course_dtl.cancel_flag ='N'  and ws_student_wise_course_dtl.status = 'R' and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'  order by ws_student_wise_course_dtl.course_code  ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_elective_all_course_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select  student_wise_course_dtl.course_code,priority,COUNT(priority) as total_priority,department_wise_course_dtl.available_seat from student_wise_course_dtl " +
                        "inner JOIN department_wise_course_dtl on student_wise_course_dtl.course_code = department_wise_course_dtl.course_code  " +
                        "where student_wise_course_dtl.course_type ='E' and student_wise_course_dtl.cancel_flag ='N' and student_wise_course_dtl.status = 'R'  ";



            if (sem_code == "M")
            {
                SqlSelect = SqlSelect + " and student_wise_course_dtl.current_sem_code in ('1','3','5','7','9') and department_wise_course_dtl.semester_code in  ('1','3','5','7','9') ";
            }
            else
            {
                SqlSelect = SqlSelect + " and student_wise_course_dtl.current_sem_code in ('2','4','6','8','10') and department_wise_course_dtl.semester_code in  ('2','4','6','8','10') ";
            }

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and  student_wise_course_dtl.year_code = @year_code and department_wise_course_dtl.year_code =@year_code";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }




            SqlSelect = SqlSelect + " GROUP BY course_code,priority order by priority,total_priority desc,student_wise_course_dtl.course_code";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_elective_all_course_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select  ws_student_wise_course_dtl.course_code,priority,COUNT(priority) as total_priority,ws_course_mst.available_seat from ws_student_wise_course_dtl " +
                        "inner JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code  " +
                        "where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status = 'R' and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "'   ";

            SqlSelect = SqlSelect + " GROUP BY ws_student_wise_course_dtl.course_code,priority,ws_course_mst.available_seat order by priority,total_priority desc,ws_student_wise_course_dtl.course_code";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_course_time_day_data(string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from course_wise_time where cancel_flag = 'N' ";


            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and year_code = @year_code";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_course_time_day_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_course_wise_time where cancel_flag = 'N' and semester_type ='" + sem_code + "' and year_semester = '" + year_code + "' ";


            //if (year_code != "")
            //{
            //    SqlSelect = SqlSelect + " and year_code = @year_code";

            //    IDataParameter para1 = DBObjectFactory.GetParameterObject();
            //    para1.ParameterName = "@year_code";
            //    para1.DbType = DbType.String;
            //    para1.Value = year_code;
            //    DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            //}







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
            catch (Exception ex)
            {
                return null;
            }
        }

        #endregion

        #region Reports method

        public DataTable get_allocate_course_data(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_student_course_allocate_dtl  where  ws_student_course_allocate_dtl.cancel_flag ='N'  " +
                        " and ws_student_course_allocate_dtl.semester_type ='" + sem_code + "' and ws_student_course_allocate_dtl.year_semester ='" + year_code + "'   ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_publish_allocation_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_publish_allocation_dtl " +
                        " where ws_publish_allocation_dtl.semester_type ='" + sem_code + "' and ws_publish_allocation_dtl.year_semester ='" + year_code + "' and cancel_flag ='N' ";


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_allocate_course_data(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            String SqlSelect = "";

            SqlSelect = " select * from ws_student_course_allocate_dtl where cancel_flag = 'N' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "' ";

            return Get_data(SqlSelect);

        }

        public DataTable get_allocate_course_data_new(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select student_course_allocate_dtl.doc_no,student_course_allocate_dtl.user_id ,user_mst.full_name,user_mst.mail,student_course_allocate_dtl.course_code + ' - ' + course_mst.course_name) as course_code ,course_mst.course_name , " +
                        " case student_course_allocate_dtl.course_type when 'M' THEN 'Mandatory' when 'E' THEN 'Elective' end as course_type,user_mst.student_no ,department_mst.dept_name,case student_course_allocate_dtl.gpa_nongpa when 'G' then 'GPA' when 'N' then 'Non GPA' else student_course_allocate_dtl.gpa_nongpa end as gpa_nongpa " +
                        "from student_course_allocate_dtl inner join course_mst on student_course_allocate_dtl.course_code = course_mst.course_code INNER JOIN user_mst on student_course_allocate_dtl.user_id = user_mst.user_id inner JOIN department_mst on user_mst.dept_code = department_mst.dept_code " +
                        "INNER JOIN department_wise_course_dtl on student_course_allocate_dtl.course_code = department_wise_course_dtl.course_code where  student_course_allocate_dtl.cancel_flag ='N'  ";


            if (sem_code == "M")
            {


                SqlSelect = SqlSelect + " and student_course_allocate_dtl.current_sem_code in ('1','3','5','7','9') and department_wise_course_dtl.semester_code in ('1','3','5','7','9') ";
            }
            else
            {
                SqlSelect = SqlSelect + " and student_course_allocate_dtl.current_sem_code in ('2','4','6','8','10') and department_wise_course_dtl.semester_code in ('2','4','6','8','10')";
            }

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and department_wise_course_dtl.dept_code = @dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and student_course_allocate_dtl.year_code =@year_code ";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@year_code";
                para2.DbType = DbType.String;
                para2.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }


            SqlSelect = SqlSelect + "order by student_course_allocate_dtl.course_code,student_course_allocate_dtl.course_type desc,user_mst.student_no ASC ";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_allocate_course_data_new(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select ws_student_course_allocate_dtl.doc_no,ws_student_course_allocate_dtl.user_id ,user_mst.user_name as full_name,user_mst.mail,ws_student_course_allocate_dtl.course_code + ' - ' + ws_course_mst.course_name as course_code ,ws_course_mst.course_name,department_mst.dept_name " +

                        "from ws_student_course_allocate_dtl inner join ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code INNER JOIN user_mst on ws_student_course_allocate_dtl.user_id = user_mst.user_id inner JOIN department_mst on user_mst.dept_code = department_mst.dept_code " +
                        " where  ws_student_course_allocate_dtl.cancel_flag ='N'  and ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";



            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.dept_code = @dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }




            SqlSelect = SqlSelect + "order by ws_student_course_allocate_dtl.course_code,ws_student_course_allocate_dtl.course_type desc,user_mst.student_no ASC ";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_ws_allocate_course_data_drop_by_student_from_popup(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select ws_student_course_allocate_dtl.doc_no,ws_student_course_allocate_dtl.user_id ,user_mst.full_name,user_mst.mail,ws_student_course_allocate_dtl.course_code + ' - ' + ws_course_mst.course_name as course_code ,ws_course_mst.course_name,department_mst.dept_name, CONVERT(VARCHAR(5),ws_student_course_allocate_dtl.last_modified_date,108) as time, CONVERT(VARCHAR(24),ws_student_course_allocate_dtl.last_modified_date,105) as date " +
                        " , case course_drop when 'Y' then 'Drop' else 'Decline' end  drop_cancel,refund_tbl.amount_paid,refund_tbl.refund_amount,refund_tbl.account_holder_name,refund_tbl.bank_name, " +
                        " refund_tbl.branch_name,refund_tbl.branch_city,refund_tbl.branch_state,refund_tbl.account_type,refund_tbl.ifsc_code,refund_tbl.account_number " +
                        "from ws_student_course_allocate_dtl inner join ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code INNER JOIN user_mst on ws_student_course_allocate_dtl.user_id = user_mst.user_id inner JOIN department_mst on user_mst.dept_code = department_mst.dept_code " +
                        " left join " +
                         " ( " +
                         " select * from " +
                         " (select ROW_NUMBER() over(partition by user_id order by created_date desc) as number,*  " +
                         " from ws_refund_application_dtl where semester_type ='" + sem_code + "' and year_semester = '" + year_code + "') as tmp " +
                         " where number = 1 " +
                         " ) as refund_tbl on ws_student_course_allocate_dtl.user_id = refund_tbl.user_id " +
                        " where  ws_student_course_allocate_dtl.cancel_flag ='Y'  and ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "'  ";
            //  " and ws_student_course_allocate_dtl.last_modified_by like '%popup%' ";



            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.dept_code = @dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }


            SqlSelect = SqlSelect + "order by ws_student_course_allocate_dtl.course_code,ws_student_course_allocate_dtl.course_type desc,user_mst.student_no ASC ";


            return Get_data(SqlSelect);


        }

        public DataTable get_ws_allocate_course_data_new_for_report(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select ws_student_course_allocate_dtl.doc_no,ws_student_course_allocate_dtl.user_id ,user_mst.full_name,user_mst.mail,ws_student_course_allocate_dtl.course_code ,ws_course_mst.course_name, ws_student_course_allocate_dtl.credits,department_mst.dept_name " +

                        "from ws_student_course_allocate_dtl inner join ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code INNER JOIN user_mst on ws_student_course_allocate_dtl.user_id = user_mst.user_id inner JOIN department_mst on user_mst.dept_code = department_mst.dept_code " +
                        " where  ws_student_course_allocate_dtl.cancel_flag ='N'  and ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "'  and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";



            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.dept_code = @dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }




            SqlSelect = SqlSelect + "order by ws_student_course_allocate_dtl.course_code,ws_student_course_allocate_dtl.course_type desc,user_mst.student_no ASC ";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_refund_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from  ws_refund_application_dtl where semester_type ='" + sem_code + "' and year_semester ='" + year_code + "' and  cancel_flag ='N' order by ORDER BY user_id, created_date DESC";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_registered_course_data_for_report(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select ws_student_wise_course_dtl.doc_no,ws_student_wise_course_dtl.user_id ,user_mst.user_name as full_name, " +
                       " ws_student_wise_course_dtl.course_code + ' - ' + ws_course_mst.course_name as course_code ,ws_course_mst.course_name ,   " +
                       " ws_student_wise_course_dtl.priority,user_mst.student_no ,  " +
                       " department_mst.dept_name,case ws_student_wise_course_dtl.gpa_nongpa when 'G' then 'GPA' when 'N' then 'Non GPA' else  " +
                       " ws_student_wise_course_dtl.gpa_nongpa end as gpa_nongpa   " +
                       " from ws_student_wise_course_dtl  " +
                       " Inner join ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code   " +
                       " INNER JOIN user_mst on ws_student_wise_course_dtl.user_id = user_mst.user_id  " +
                       " Inner JOIN department_mst on user_mst.dept_code = department_mst.dept_code   " +
                       " AND ws_student_wise_course_dtl.course_code = ws_course_mst.course_code  " +
                       " Where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status = 'R'   and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";



            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.dept_code = @dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            //if (year_code != "")
            //{
            //    SqlSelect = SqlSelect + " and student_wise_course_dtl.year_code =@year_code ";

            //    IDataParameter para2 = DBObjectFactory.GetParameterObject();
            //    para2.ParameterName = "@year_code";
            //    para2.DbType = DbType.String;
            //    para2.Value = year_code;
            //    DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            //}


            SqlSelect = SqlSelect + " order by ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type desc,user_mst.student_no ASC  ";


            return Get_data(SqlSelect);

        }

        public DataTable get_registered_course_data_for_report_after_allocation(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select ws_student_wise_course_dtl.doc_no,ws_student_wise_course_dtl.user_id ,user_mst.user_name as full_name, " +
                       " ws_student_wise_course_dtl.course_code + ' - ' + ws_course_mst.course_name as course_code ,ws_course_mst.course_name ,   " +
                       " ws_student_wise_course_dtl.priority,user_mst.student_no ,  " +
                       " department_mst.dept_name,case ws_student_wise_course_dtl.gpa_nongpa when 'G' then 'GPA' when 'N' then 'Non GPA' else  " +
                       " ws_student_wise_course_dtl.gpa_nongpa end as gpa_nongpa   " +
                       " from ws_student_wise_course_dtl  " +
                       " Inner join ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code   " +
                       " INNER JOIN user_mst on ws_student_wise_course_dtl.user_id = user_mst.user_id  " +
                       " Inner JOIN department_mst on user_mst.dept_code = department_mst.dept_code   " +
                       " AND ws_student_wise_course_dtl.course_code = ws_course_mst.course_code  " +
                       " Where  ws_student_wise_course_dtl.cancel_flag ='N' and (ws_student_wise_course_dtl.status = 'R' or ws_student_wise_course_dtl.status = 'A'  )    and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";



            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.dept_code = @dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            //if (year_code != "")
            //{
            //    SqlSelect = SqlSelect + " and student_wise_course_dtl.year_code =@year_code ";

            //    IDataParameter para2 = DBObjectFactory.GetParameterObject();
            //    para2.ParameterName = "@year_code";
            //    para2.DbType = DbType.String;
            //    para2.Value = year_code;
            //    DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            //}

            SqlSelect = SqlSelect + " order by ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type desc,user_mst.student_no ASC  ";



            return Get_data(SqlSelect);
        }

        public DataTable check_allocation_completed_for_student(string sem_code, string year_code, string user_id)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select *  from student_course_allocate_dtl where cancel_flag ='N' and current_sem_code = @sem_code and year_code =@year_code and user_id =@user_id  ";









            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@sem_code";
            para1.DbType = DbType.String;
            para1.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            IDataParameter para2 = DBObjectFactory.GetParameterObject();
            para2.ParameterName = "@year_code";
            para2.DbType = DbType.String;
            para2.Value = year_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            IDataParameter para3 = DBObjectFactory.GetParameterObject();
            para3.ParameterName = "@user_id";
            para3.DbType = DbType.String;
            para3.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para3);


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable check_ws_allocation_completed_for_student(string sem_code, string year_code, string user_id)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select *  from ws_student_course_allocate_dtl where cancel_flag ='N' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "' and user_id =@user_id  ";


            IDataParameter para3 = DBObjectFactory.GetParameterObject();
            para3.ParameterName = "@user_id";
            para3.DbType = DbType.String;
            para3.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para3);


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
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable check_credit_choice_by_student(string sem_code, string year_code, string user_id, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from student_current_sem_dtl where cancel_flag = 'N' and active_flag ='Y'   ";


            if (sem_code == "M")
            {
                SqlSelect = SqlSelect + "and semester_code in ('1','3','5','7','9')";
            }
            else if (sem_code == "S")
            {
                SqlSelect = SqlSelect + "and semester_code in ('2','4','6','8','10')";
            }

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and year_code =@year_code";
                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }




            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and student_id = @user_id";


                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@user_id";
                para2.DbType = DbType.String;
                para2.Value = user_id;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

            }

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and dept_code = @dept_code";


                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@dept_code";
                para3.DbType = DbType.String;
                para3.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable check_ws_credit_choice_by_student(string sem_code, string year_code, string user_id)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_credit_choice where cancel_flag = 'N'  and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'   ";

            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and user_id = @user_id";


                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@user_id";
                para2.DbType = DbType.String;
                para2.Value = user_id;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_total_offered_course_report()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select   COUNT(  course_mst.course_code) as course_code,  sum( course_mst.course_credits) as total_credits,course_mst.course_type from course_mst where cancel_flag  = 'N'  GROUP BY course_mst.course_type ORDER BY course_type DESC ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_faculty_wise_total_course_report()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select dept_code,dept_name,  COUNT(course_code) as course_code , sum(course_credits) as credits FROM (SELECT DISTINCT department_wise_course_dtl.dept_code, " +
                        " case department_mst.dept_name WHEN 'Architecture' THEN 'FA' WHEN 'Design' THEN 'FD' WHEN 'Management' THEN 'FM' WHEN 'Planning' THEN 'FP' WHEN 'Technology' THEN 'FT' end as dept_name, " +
                        " department_wise_course_dtl.course_code,course_mst.course_credits FROM `department_wise_course_dtl`  INNER JOIN course_mst on department_wise_course_dtl.course_code = course_mst.course_code " +
                        " INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code where course_mst.cancel_flag = 'N' and department_wise_course_dtl.cancel_flag = 'N' " +
                        " GROUP BY department_wise_course_dtl.dept_code,department_wise_course_dtl.course_code,dept_name) as a  GROUP BY dept_code,dept_name ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_faculty_type_wise_total_course_report()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select COUNT(course_code) as course_code,sum(course_credits) as credits,dept_code,dept_name,course_type from ( " +
                        " select DISTINCT department_wise_course_dtl.course_code ,course_mst.course_credits ,department_wise_course_dtl.dept_code , case department_mst.dept_name WHEN 'Architecture' THEN 'FA' WHEN 'Design' THEN 'FD' WHEN 'Management' THEN 'FM' WHEN 'Planning' THEN 'FP' WHEN 'Technology' " +
                        " THEN 'FT'  end as dept_name,department_wise_course_dtl.course_type from department_wise_course_dtl inner JOIN course_mst on " +
                        " department_wise_course_dtl.course_code = course_mst.course_code  INNER JOIN department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code " +
                        " where department_wise_course_dtl.cancel_flag = 'N' and course_mst.cancel_flag = 'N'  GROUP BY department_wise_course_dtl.dept_code,department_wise_course_dtl.course_type ,department_wise_course_dtl.course_code ) " +
                        " as a GROUP BY dept_code,dept_name,course_type ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_course_type_offered_report()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "  select course_type,count(course_code) as course_code,SUM(course_credits) as course_credits from(  select DISTINCT CASE course_type_mst.type_name " +
                        " WHEN 'Lecture' THEN 'Lecture/ Theory Courses' WHEN 'Lecture (Large)' THEN 'Lecture/ Theory Courses' WHEN 'Theory' THEN 'Lecture/ Theory Courses'  WHEN 'Seminar' THEN 'Seminar Courses' " +
                        " WHEN 'Research Seminar' THEN 'Seminar Courses' ELSE course_type_mst.type_name end as course_type,  " +
                        " department_wise_course_dtl.course_code ,course_mst.course_credits from department_wise_course_dtl  inner join course_mst on department_wise_course_dtl.course_code = course_mst.course_code  " +
                        " inner join course_type_mst on department_wise_course_dtl.course_typology = course_type_mst.type_code  where department_wise_course_dtl.cancel_flag ='N' " +
                        " and course_mst.cancel_flag ='N' GROUP BY course_typology,department_wise_course_dtl.course_code ) as a GROUP BY course_type ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_course_type_and_credits_offered_report()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "  select dept_name,course_type,Count(course_code) as course_code,SUM(course_credits) as course_credits " +
                        " from(  select DISTINCT CASE department_mst.dept_name WHEN 'Architecture' THEN 'FA' WHEN 'Design' THEN 'FD' WHEN 'Management' THEN 'FM' WHEN 'Planning' THEN 'FP' WHEN 'Technology' THEN 'FT' ELSE  department_mst.dept_name end as dept_name,   CASE course_type_mst.type_name WHEN 'Lecture' THEN 'lecture' WHEN 'Lecture (Large)' THEN 'lecture' WHEN 'Theory' THEN 'lecture' when 'Design Workshop' then 'design_workshop'  WHEN 'Seminar' THEN 'seminar' WHEN 'Research Seminar' THEN 'seminar' when 'Guided Research' " +
                        " THEN 'ghuided_research' when 'Workshop' then 'workshop' when 'Studio' then 'studio'  ELSE course_type_mst.type_name end as course_type,  " +
                        " department_wise_course_dtl.course_code, course_mst.course_credits from department_wise_course_dtl  inner join course_mst " +
                        " on department_wise_course_dtl.course_code = course_mst.course_code  inner join course_type_mst on department_wise_course_dtl.course_typology = course_type_mst.type_code  inner join department_mst on department_wise_course_dtl.dept_code = department_mst.dept_code  where department_wise_course_dtl.cancel_flag ='N' and course_mst.cancel_flag ='N'  " +
                        " GROUP BY course_typology,department_mst.dept_name,course_code ) as a GROUP BY course_type,dept_name  ORDER BY dept_name ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_registration_report_data(string dept_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT student_wise_course_dtl.user_id,user_mst.user_name, course_type,COUNT(course_code) as course_code,sum(credits) as credits FROM `student_wise_course_dtl` " +
                        " INNER JOIN user_mst on student_wise_course_dtl.user_id = user_mst.user_id  where student_wise_course_dtl.cancel_flag = 'N' and student_wise_course_dtl.status = 'R' " +
                        " and student_wise_course_dtl.semester_type = '" + sem_code + "' ";


            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and user_mst.dept_code =@dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            }

            SqlSelect = SqlSelect + " GROUP BY student_wise_course_dtl.user_id,course_type ORDER BY user_mst.dept_code,student_wise_course_dtl.user_id ";


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_assigned_report_data(string dept_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT student_course_allocate_dtl.user_id,user_mst.user_name, course_type,COUNT(course_code) as course_code,sum(credits) as credits FROM `student_course_allocate_dtl` " +
                        " INNER JOIN user_mst on student_course_allocate_dtl.user_id = user_mst.user_id  where student_course_allocate_dtl.cancel_flag = 'N'  " +
                        " and student_course_allocate_dtl.semester_type = '" + sem_code + "' ";


            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and user_mst.dept_code =@dept_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            }

            SqlSelect = SqlSelect + " GROUP BY student_course_allocate_dtl.user_id,course_type ORDER BY user_mst.dept_code,student_course_allocate_dtl.user_id ";


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_assigned_cross_registration_faculty_report(string year_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select user_dept,dept_code , COUNT(course_code) as course_code , SUM(credits) as credits from " +
                        " (SELECT user_mst.dept_code as user_dept,student_course_allocate_dtl.dept_code,student_course_allocate_dtl.course_code,student_course_allocate_dtl.credits " +
                        " FROM `student_course_allocate_dtl` inner JOIN user_mst on student_course_allocate_dtl.user_id = user_mst.user_id where student_course_allocate_dtl.semester_type = '" + sem_code + "' and student_course_allocate_dtl.year_semester = '" + year_code + "' " +
                        "and   student_course_allocate_dtl.dept_code != '' HAVING user_dept != student_course_allocate_dtl.dept_code ORDER BY user_mst.dept_code )  as a group by	user_dept,dept_code ";





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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_assigned_cross_registration_PG_UG_report(string year_code, string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select  user_dept,sum(course_code) as course_code, SUM(credits) as credits , prog_code from (select user_dept , user_prog_code , dept_code  , count(course_code) as course_code , SUM(credits) as credits , prog_code from " +
                        " (SELECT user_mst.dept_code as user_dept,user_mst.prog_code as user_prog_code , student_course_allocate_dtl.dept_code,student_course_allocate_dtl.course_code,student_course_allocate_dtl.credits ,department_wise_course_dtl.prog_code " +
                        " FROM `student_course_allocate_dtl` inner JOIN user_mst on student_course_allocate_dtl.user_id = user_mst.user_id INNER JOIN department_wise_course_dtl on student_course_allocate_dtl.course_code = department_wise_course_dtl.course_code " +
                        " where student_course_allocate_dtl.semester_type = '" + sem_code + "' and student_course_allocate_dtl.year_semester = '" + year_code + "' and   student_course_allocate_dtl.dept_code != '' and department_wise_course_dtl.semester_code in ('2','4','6','8','10') " +
                        " HAVING user_dept != student_course_allocate_dtl.dept_code and user_prog_code != department_wise_course_dtl.prog_code " +
                        " ORDER BY user_mst.dept_code ,user_mst.prog_code ) as a GROUP BY user_dept , user_prog_code , dept_code ,prog_code ) as b GROUP BY user_dept ,  prog_code ";





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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_selected_transaction_data(string trans_id)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select ws_applicationpaymenttransaction.transaction_id,ws_applicationpaymenttransaction.user_id,user_mst.user_name ,ws_applicationpaymenttransaction.amount,ws_applicationpaymenttransaction.created_date,payment_transaction_reference_id  from ws_applicationpaymenttransaction INNER JOIN user_mst on ws_applicationpaymenttransaction.user_id = user_mst.user_id " +
            " where transaction_id = '" + trans_id + "' ";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        //public DataTable Get_selected_transaction_data(string user_id, string trans_id, string sem_code, string year_code, string enrollment_year, string dept_code, string prog_code)
        //{
        //    DBDataAdpterObject.SelectCommand.Parameters.Clear();
        //    String SqlSelect = "";
        //    SqlSelect = "select (CAST(DATEPART(day,ws_applicationpaymenttransaction.created_date) AS VARCHAR)+'/'+CAST(DATEPART(month,ws_applicationpaymenttransaction.created_date) AS VARCHAR)+'/'+CAST(DATEPART(year,ws_applicationpaymenttransaction.created_date) AS VARCHAR)) as created_date,ws_applicationpaymenttransaction.transaction_id,ws_applicationpaymenttransaction.user_id,user_mst.user_name ,ws_applicationpaymenttransaction.amount,payment_transaction_reference_id  from ws_applicationpaymenttransaction INNER JOIN user_mst on ws_applicationpaymenttransaction.user_id = user_mst.user_id " +
        //    " where user_mst.user_status_flag ='A' and  ws_applicationpaymenttransaction.semester_type ='" + sem_code + "' and ws_applicationpaymenttransaction.year_semester ='" + year_code + "'  and payment_response_code ='0' ";
        //    if (enrollment_year != "")
        //    {
        //        SqlSelect = SqlSelect + " and user_mst.year_code ='" + enrollment_year + "' ";
        //    }
        //    if (dept_code != "")
        //    {
        //        SqlSelect = SqlSelect + " and user_mst.dept_code ='" + dept_code + "' ";
        //    }
        //    if (prog_code != "")
        //    {
        //        SqlSelect = SqlSelect + " and user_mst.prog_code ='" + prog_code + "' ";
        //    }
        //    if (trans_id != "")
        //    {
        //        SqlSelect = SqlSelect + " and ws_applicationpaymenttransaction.transaction_id = '" + trans_id + "' ";
        //    }
        //    if (user_id != "")
        //    {
        //        SqlSelect = SqlSelect + " and ws_applicationpaymenttransaction.user_id = '" + user_id + "' ";
        //    }
        //    return Get_data(SqlSelect);
        //}

        public DataTable Get_selected_transaction_data(string user_id, string trans_id, string sem_code, string year_code, string enrollment_year, string dept_code, string prog_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = "select (CAST(DATEPART(day,ws_applicationpaymenttransaction.created_date) AS VARCHAR)+'/'+CAST(DATEPART(month,ws_applicationpaymenttransaction.created_date) AS VARCHAR)+'/'+CAST(DATEPART(year,ws_applicationpaymenttransaction.created_date) AS VARCHAR)) as created_date,ws_applicationpaymenttransaction.transaction_id,ws_applicationpaymenttransaction.user_id,user_mst.user_name ,ws_applicationpaymenttransaction.amount,payment_transaction_reference_id  from ws_applicationpaymenttransaction INNER JOIN user_mst on ws_applicationpaymenttransaction.user_id = user_mst.user_id " +
            SqlSelect = @"select ws_applicationpaymenttransaction.created_date,
					ws_applicationpaymenttransaction.transaction_id,ws_applicationpaymenttransaction.user_id,
					user_mst.user_name ,ws_applicationpaymenttransaction.amount,payment_transaction_reference_id,
					user_mst.prog_desc, user_mst.middle_name, user_mst.first_name, user_mst.dept_code,
					user_mst.prog_code,user_mst.year_code,user_mst.prog_level_code,plm.prog_level_name
					from ws_applicationpaymenttransaction 
					INNER JOIN user_mst on ws_applicationpaymenttransaction.user_id = user_mst.user_id  
					LEFT JOIN programme_level_mst as plm on plm.prog_level_code = user_mst.prog_level_code
					where user_mst.user_status_flag ='A' and  ws_applicationpaymenttransaction.semester_type ='" + sem_code + "' and ws_applicationpaymenttransaction.year_semester ='" + year_code + "'  and payment_response_code ='0' ";

            if (enrollment_year != "")
            {
                SqlSelect = SqlSelect + " and user_mst.year_code ='" + enrollment_year + "' ";
            }

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and user_mst.dept_code ='" + dept_code + "' ";
            }

            if (prog_code != "")
            {
                SqlSelect = SqlSelect + " and user_mst.prog_code ='" + prog_code + "' ";
            }

            if (trans_id != "")
            {
                SqlSelect = SqlSelect + " and ws_applicationpaymenttransaction.transaction_id = '" + trans_id + "' ";
            }

            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and ws_applicationpaymenttransaction.user_id = '" + user_id + "' ";
            }

            return Get_data(SqlSelect);
        }

        public DataTable GetTransactionDetails_studentwise(string user_id, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select (CAST(DATEPART(day,created_date) AS VARCHAR)+'/'+CAST(DATEPART(month,created_date) AS VARCHAR)+'/'+CAST(DATEPART(year,created_date) AS VARCHAR)) as created_date,*  from ws_applicationpaymenttransaction  " +
            " where user_id = '" + user_id + "' and semester_type = '" + sem_code + "' and year_semester ='" + year_code + "' and payment_response_code = '0' ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetTransactionDetails(string transaction_id)
        {
            try
            {
                DataTable dt = new DataTable();
                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                String SqlSelect = "";


                BLL.Utilities1.Log.PaymentTransactionLog(transaction_id);
                SqlSelect = "SELECT * from  ws_applicationpaymenttransaction  where  transaction_id ='" + transaction_id + "'";
                BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);






                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                BLL.Utilities1.Log.PaymentTransactionLog(SqlSelect);
                DataSet ds = new DataSet();
                try
                {
                    DBDataAdpterObject.Fill(ds);
                    if (ds.Tables[0].Rows.Count <= 0)
                    {
                        BLL.Utilities1.Log.PaymentTransactionLog("row not found");
                        return null;
                    }
                    else
                    {

                        BLL.Utilities1.Log.PaymentTransactionLog("successful" + ds.Tables[0].Rows[0]["transaction_id"].ToString());
                        dt = ds.Tables[0];
                        BLL.Utilities1.Log.PaymentTransactionLog("successful1" + dt.Rows[0]["transaction_id"].ToString());
                        return dt;

                    }

                }
                catch (Exception ex)
                {
                    BLL.Utilities1.Log.PaymentTransactionLog("Error" + ex.ToString());
                    return null;
                }
            }
            catch (Exception ex)
            {
                BLL.Utilities1.Log.PaymentTransactionLog("Error1" + ex.ToString());
                return null;
            }
        }

        //public DataTable get_registered_course_detail(string dept_code, string sem_code, string year_code)
        //{
        //    DBDataAdpterObject.SelectCommand.Parameters.Clear();
        //    String SqlSelect = "";


        //    //if (dept_code != "")
        //    //{
        //    //    SqlSelect = SqlSelect + " and user_mst.dept_code =@dept_code ";

        //    //    IDataParameter para1 = DBObjectFactory.GetParameterObject();
        //    //    para1.ParameterName = "@dept_code";
        //    //    para1.DbType = DbType.String;
        //    //    para1.Value = dept_code;
        //    //    DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
        //    //    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
        //    //}

        //    //SqlSelect = SqlSelect + " GROUP BY student_course_allocate_dtl.user_id,course_type,user_mst.user_name ORDER BY student_course_allocate_dtl.user_id ";

        //    SqlSelect = " SELECT sc.course_code,cm.course_name,sc.course_type,sc.priority,COUNT(sc.course_type) as TotalStudent,cm.available_seat " +
        //                " FROM ws_student_wise_course_dtl as sc" +
        //                " inner join ws_course_mst as cm on sc.course_code=cm.course_code" +
        //                " where sc.cancel_flag='N' and ( sc.status = 'A' or  sc.status = 'R') and sc.semester_type = '" + sem_code + "' " + "and sc.year_semester = '" + year_code + "' and cm.semester_type = '" + sem_code + "' " + "and cm.year_semester = '" + year_code + "' ";

        //    if (dept_code != "")
        //    {
        //        SqlSelect = SqlSelect + " and sc.dept_code = '" + dept_code + "' ";
        //    }

        //    SqlSelect = SqlSelect + " group by sc.course_code,cm.course_name,sc.course_type,sc.priority,cm.available_seat order by sc.course_code,sc.course_type,sc.priority";


        //    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;


        //    DataSet ds = new DataSet();
        //    try
        //    {
        //        DBDataAdpterObject.Fill(ds);
        //        if (ds.Tables[0].Rows.Count <= 0)
        //        {
        //            ds = new DataSet();
        //            SqlSelect = " SELECT sc.course_code,cm.course_name,sc.course_type,sc.priority,COUNT(sc.course_type) as TotalStudent,cm.available_seat " +
        //                " FROM ws_student_wise_course_dtl as sc" +
        //                " inner join ws_course_mst as cm on sc.course_code=cm.course_code" +
        //                " where sc.cancel_flag='N' and ( sc.status = 'A' or  sc.status = 'R') and sc.semester_type = '" + sem_code + "' " + "and sc.year_semester = '" + year_code + "' and cm.semester_type = '" + sem_code + "' " + "and cm.year_semester = '" + year_code + "' ";

        //            if (dept_code != "")
        //            {
        //                SqlSelect = SqlSelect + " and sc.dept_code = '" + dept_code + "' ";
        //            }

        //            SqlSelect = SqlSelect + " group by sc.course_code,cm.course_name,sc.course_type,sc.priority,cm.available_seat order by sc.course_code,sc.course_type,sc.priority";


        //            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

        //            DBDataAdpterObject.Fill(ds);

        //            if (ds.Tables[0].Rows.Count <= 0)
        //            {
        //                return null;
        //            }
        //            else
        //            {
        //                return ds.Tables[0];
        //            }
        //        }

        //        else
        //            return ds.Tables[0];

        //    }
        //    catch (Exception ex)
        //    {
        //        return null;
        //    }
        //}


        public DataTable get_registered_course_detail(string dept_code, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select course_code,course_name,available_seat,[1] as priority1,[2] as priority2,[3] as priority3,[4] as priority4, [5] as priority5, " +
                        " (isnull([1],0) +  isnull([2],0) + isnull([3],0) + isnull([4],0) + isnull([5],0)) as elective_course " +
                        " from (select cm.course_code,cm.course_name,cm.available_seat,a.TotalStudent,a.priority from ws_course_mst as cm  " +
                        " left join ( " +
                        " select course_code,sc.course_type,sc.priority,COUNT(sc.course_type) as TotalStudent from ws_student_wise_course_dtl as sc where  sc.cancel_flag='N' and ( sc.status = 'A' or  sc.status = 'R') and sc.semester_type = '" + sem_code + "' and sc.year_semester = '" + year_code + "'  " +
                        " group by sc.course_code,sc.course_type,sc.priority " +
                        " ) as a on cm.course_code   = a.course_code " +
                        " where  cm.semester_type = '" + sem_code + "' and cm.year_semester = '" + year_code + "' and cm.cancel_flag ='N'  ";
            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and  cm.dept_code ='" + dept_code + "' ";
            }

            SqlSelect = SqlSelect + " ) as tbl " +
                      " pivot " +
                      " ( " +
                      " min(TotalStudent) for priority in ([1], [2], [3], [4],[5]) ) as pivottbl ";


            return Get_data(SqlSelect);
        }


        public DataTable get_total_allocate_seats_and_total_course_seats_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select a.course_code,ws_course_mst.course_name,a.total_allocate_course,ws_course_mst.available_seat from ws_course_mst INNER JOIN " +
                    " (select ws_student_course_allocate_dtl.course_code,count(ws_student_course_allocate_dtl.course_code) as total_allocate_course from ws_student_course_allocate_dtl " +
                    " where ws_student_course_allocate_dtl.cancel_flag ='N' and ws_student_course_allocate_dtl.semester_type ='" + sem_code + "' and ws_student_course_allocate_dtl.year_semester ='" + year_code + "' " +

                    " group by ws_student_course_allocate_dtl.course_code) as a on a.course_code = ws_course_mst.course_code where  ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester ='" + year_code + "' order by a.course_code ";





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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_student_for_next_round_registration(string sem_code, string year_code, string user_id, string round)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_student_list_for_register_next_round where semester_type ='" + sem_code + "' and year_semester ='" + year_code + "' and cancel_flag ='N' and round ='" + round + "' ";

            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and user_id ='" + user_id + "' ";
            }

            return Get_data(SqlSelect);
        }

        #endregion

        #region Generel Methods

        public DataTable Get_WS_Course_dtl(string sem_code, string year_code, string course_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_course_mst where semester_type='" + sem_code + "' and year_semester='" + year_code + "' and course_code='" + course_code + "' ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_faculty_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from instructor_mst where cancel_flag ='N' ";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_semester_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from semester_mst where cancel_flag ='N' order by cast(semester_code as SIGNED)";







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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_department_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " selecT *from department_mst where cancel_flag='N'";



            return Get_data(SqlSelect);

        }

        public DataTable Get_year_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " selecT *from year_mst where cancel_flag='N' ORDER BY year_desc desc";



            return Get_data(SqlSelect);

        }

        public DataTable Get_student_data(string year_code, string dept_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from user_mst where user_type='S' and user_status_flag ='A' and year_code=@year_code ";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@year_code";
            para1.DbType = DbType.String;
            para1.Value = year_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and dept_code=@dept_code";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@dept_code";
                para2.DbType = DbType.String;
                para2.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }

            return Get_data(SqlSelect);
        }

        public DataTable Get_student_data_new(string year_code, string dept_code, string prog_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from user_mst where user_type='S' and user_status_flag ='A' ";

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and year_code =@year_code ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and dept_code =@dept_code ";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@dept_code";
                para2.DbType = DbType.String;
                para2.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }

            if (prog_code != "")
            {
                SqlSelect = SqlSelect + " and prog_code =@prog_code ";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_code";
                para3.DbType = DbType.String;
                para3.Value = prog_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            return Get_data(SqlSelect);
        }

        public DataTable Get_student_data_for_manually_allocation(string year_code, string dept_code, string prog_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from user_mst where ( user_type= 'S' or user_type= 'E') and user_status_flag ='A' ";

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and year_code =@year_code  ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and dept_code =@dept_code";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@dept_code";
                para2.DbType = DbType.String;
                para2.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }

            if (prog_code != "")
            {
                SqlSelect = SqlSelect + " and prog_code =@prog_code";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_code";
                para3.DbType = DbType.String;
                para3.Value = prog_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_data_for_manually_allocation_new(string year_code, string dept_code, string prog_code, string user_type)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            if (user_type == "HS")
                SqlSelect = " select user_id,user_name from user_mst where ( user_type= 'HS') and user_status_flag ='A' ";
            else
                SqlSelect = " select user_id,user_name from user_mst where ( user_type= 'S' or user_type= 'E') and user_status_flag ='A' ";

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and year_code =@year_code  ";

                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and dept_code =@dept_code";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@dept_code";
                para2.DbType = DbType.String;
                para2.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }

            if (prog_code != "")
            {
                SqlSelect = SqlSelect + " and prog_code =@prog_code";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_code";
                para3.DbType = DbType.String;
                para3.Value = prog_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_course_data_for_add_manually_before_allocation(string year_code, string sem_code, string course_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.doc_no, ws_student_wise_course_dtl.user_id,user_mst.user_name ,ws_student_wise_course_dtl.semester_type,ws_student_wise_course_dtl.year_semester , department_mst.dept_name FROM ws_student_wise_course_dtl INNER JOIN user_mst on  ws_student_wise_course_dtl.user_id =  user_mst.user_id INNER JOIN department_mst on user_mst.dept_code = department_mst.dept_code  " +
                        " where ws_student_wise_course_dtl.status = 'R' and ws_student_wise_course_dtl.cancel_flag = 'N' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "' and course_code = '" + course_code + "' order by ws_student_wise_course_dtl.user_id  ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_all_user_mst_data()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "Select * from user_mst where user_status_flag = 'A' ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable get_all_student_data()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "Select * from user_mst where user_status_flag = 'A' and user_type = 'S' order by user_id";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_programme_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " selecT *from programme_mst where cancel_flag='N'";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_area_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from area_mst where cancel_flag ='N' ";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_all_course_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT  * FROM   ws_course_mst  where ws_course_mst.cancel_flag = 'N' and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";

            SqlSelect = SqlSelect + " ORDER BY ws_course_mst.course_code";

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
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetAllDataForSWSFeedBack(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = @" SELECT CASE When FeedBackMailSendStatus.cancel_flag ='N' Then 'Mail Send Successfully' Else 'Not Send' End as mailstatus, * FROM  ws_course_mst 
                           INNER JOIN ws_course_wise_instructor on ws_course_wise_instructor.course_code = ws_course_mst.course_code
                           and ws_course_wise_instructor.cancel_flag ='N'
                           and ws_course_wise_instructor.semester_type = ws_course_mst.semester_type 
                           and ws_course_wise_instructor.year_semester = ws_course_mst.year_semester
                           INNER JOIN instructor_mst on instructor_mst.instructor_code=ws_course_wise_instructor.instructor_code 
                           LEFT JOIN department_mst on department_mst.dept_code = ws_course_mst.inhabitation
                           LEFT JOIN FeedBackMailSendStatus on FeedBackMailSendStatus.UserID = instructor_mst.instructor_code
						   and FeedBackMailSendStatus.CourseCode =ws_course_mst.course_code 
						   and FeedBackMailSendStatus.Semester = ws_course_mst.semester_type 
                           and FeedBackMailSendStatus.SemesterYear = ws_course_mst.year_semester and FeedBackMailSendStatus.cancel_flag ='N'
                           LEFT JOIN 
                           ( select distinct course_code,count(distinct user_id ) as FeedbackRecieved from  ws_student_feedback_dtl as student_feedback_dtl  where student_feedback_dtl.cancel_flag = 'N'
                           and student_feedback_dtl.submit_status = 'Y' and    student_feedback_dtl.semester_type = '" + sem_code + @"'  
				           and  student_feedback_dtl.year_semester = '" + year_code + @"' 
                           group by course_code ) as total_feedback 
                           on ws_course_mst.course_code = total_feedback.course_code
				           LEFT JOIN (select course_code as course_code_new ,COUNT(course_code) AllocateCourse from ws_student_course_allocate_dtl where semester_type= '" + sem_code + @"' and year_semester= '" + year_code + @"'  and cancel_flag='N' 
				           Group by course_code) as AllocateCourse
				           on ws_course_mst.course_code = AllocateCourse.course_code_new
                           where ws_course_mst.cancel_flag = 'N' 
                           and ws_course_mst.semester_type = '" + sem_code + @"' and ws_course_mst.year_semester = '"+ year_code + @"'";

            if (dept_code != "")
            {
                SqlSelect += " AND ws_course_mst.inhabitation ='"+ dept_code + "'";
            }
            SqlSelect += " ORDER BY ws_course_mst.course_code ";
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
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Get_ws_all_course_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_course_mst where cancel_flag = 'N' order by course_code ";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        #endregion

        #region transaction report

        public DataTable get_seats_dtl_of_course(string sem_code, string dept_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_course_mst  where ws_course_mst.cancel_flag = 'N'  ";


            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.dept_code =@dept_code ";
                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@dept_code";
                para1.DbType = DbType.String;
                para1.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            if (sem_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.semester_type =@sem_code ";
                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@sem_code";
                para1.DbType = DbType.String;
                para1.Value = sem_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.year_semester =@year_code ";
                IDataParameter para1 = DBObjectFactory.GetParameterObject();
                para1.ParameterName = "@year_code";
                para1.DbType = DbType.String;
                para1.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            }

            SqlSelect = SqlSelect + " order by course_code ";








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
            catch (Exception ex)
            {
                return null;
            }
        }


        #endregion

        #region Student Fees Status
        public DataTable Get_user_userfees(string dept_code, string sem_code, string year_code, string prog_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = "selecT * from user_mst u  INNER JOIN  student_current_sem_dtl on u.user_id=student_current_sem_dtl.student_id " +
            //          " where u.user_type='S' and student_current_sem_dtl.semester_code=@sem_code  ";

            SqlSelect = "selecT * from user_mst u INNER JOIN student_current_sem_dtl on u.user_id=student_current_sem_dtl.student_id " +
                      " where u.user_type='S' and u.user_status_flag = 'A' and student_current_sem_dtl.cancel_flag = 'N' and student_current_sem_dtl.active_flag ='Y' and   student_current_sem_dtl.semester_code=@sem_code  ";

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + "  and u.dept_code=@dept_code";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@dept_code";
                para2.DbType = DbType.String;
                para2.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }
            if (year_code != "")
            {
                SqlSelect = SqlSelect + "  and u.year_code=@year_code";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@year_code";
                para3.DbType = DbType.String;
                para3.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            if (prog_code != "")
            {
                SqlSelect = SqlSelect + "  and u.prog_code=@prog_code";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_code";
                para3.DbType = DbType.String;
                para3.Value = prog_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            SqlSelect = SqlSelect + " order by u.user_id";

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@sem_code";
            para1.DbType = DbType.String;
            para1.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_student_fees_saved_data(string dept_code, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from user_fees_status where cancel_flag ='N' and semester_code = @sem_code ";

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + "  and dept_code=@dept_code";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@dept_code";
                para2.DbType = DbType.String;
                para2.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }
            if (year_code != "")
            {
                SqlSelect = SqlSelect + "  and year_code=@year_code";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@year_code";
                para3.DbType = DbType.String;
                para3.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }
            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@sem_code";
            para1.DbType = DbType.String;
            para1.Value = sem_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);


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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_WS_current_sem_data()
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_current_semester where cancel_flag ='N' and active_flag = 'Y' ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_fees_status_for_student(string user_id, string current_ws_sem, string current_ws_year)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_user_fees_status where ws_user_fees_status.user_id =@user_id and semester_type = '" + current_ws_sem + "' and year_type = '" + current_ws_year + "'";


            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_fees_amount_for_student(string year_code, string current_ws_sem, string current_ws_year, string prof_details)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_fees_amount_per_credit where ws_fees_amount_per_credit.year_code = '" + year_code + "' and semester_type = '" + current_ws_sem + "' and year_semester = '" + current_ws_year + "' and ws_fees_amount_per_credit.cancel_flag ='N'";

            if (prof_details == "P")
            {
                SqlSelect = SqlSelect + " and user_type = 'P'";
            }
            else
            {
                SqlSelect = SqlSelect + " and user_type = 'S'";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_fees_amount_pre_credit_WS(string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from ws_fees_amount_per_credit where cancel_flag = 'N' and semester_type = '" + sem_code + "' and year_semester ='" + year_code + "' ";

            return Get_data(SqlSelect);
        }

        public DataTable Get_fees_status_for_student_for_assign(string sem_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from student_current_sem_dtl INNER JOIN user_fees_status on student_current_sem_dtl.student_id = user_fees_status.user_id and student_current_sem_dtl.semester_code = user_fees_status.semester_code " +
                        " where student_current_sem_dtl.active_flag = 'Y' and student_current_sem_dtl.cancel_flag = 'N' and user_fees_status.cancel_flag = 'N' ";

            if (sem_code == "M")
            {
                SqlSelect = SqlSelect + " and student_current_sem_dtl.semester_code in ('1','3','5','7','9')";

            }
            else if (sem_code == "S")
            {
                SqlSelect = SqlSelect + " and student_current_sem_dtl.semester_code in ('2','4','6','8','10')";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_WS_fees_status_for_student_for_assign(string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from  ws_user_fees_status  where  ws_user_fees_status.cancel_flag = 'N'  and semester_type = '" + sem_code + "' and year_type = '" + year_code + "'";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_WS_credit_choice_for_student_for_assign(string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from  ws_credit_choice  where  ws_credit_choice.cancel_flag = 'N'  and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'";


            return Get_data(SqlSelect);


        }

        public DataTable get_data_before_allocation(string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from  ws_student_course_allocate_dtl  where  ws_student_course_allocate_dtl.cancel_flag = 'N'  and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'";




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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_total_credits_for_pay_slip(string user_id, string current_ws_sem, string current_ws_year)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select SUM(credits) as credits from ws_student_wise_course_dtl where status = 'S' and cancel_flag = 'N' and user_id =@user_id and semester_type='" + current_ws_sem + "' and year_semester = '" + current_ws_year + "' ";




            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@user_id";
            para1.DbType = DbType.String;
            para1.Value = user_id;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_ws_user_userfees(string dept_code, string sem_code, string year_code, string prog_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = "selecT * from user_mst u  INNER JOIN  student_current_sem_dtl on u.user_id=student_current_sem_dtl.student_id " +
            //          " where u.user_type='S' and student_current_sem_dtl.semester_code=@sem_code  ";

            SqlSelect = "selecT * from user_mst " +
                      " where user_status_flag = 'A'";

            if (dept_code != "")
            {
                if (dept_code == "7")
                {
                    SqlSelect = SqlSelect + " and user_type in ('E','HS') and dept_code=@dept_code ";

                    IDataParameter para2 = DBObjectFactory.GetParameterObject();
                    para2.ParameterName = "@dept_code";
                    para2.DbType = DbType.String;
                    para2.Value = dept_code;
                    DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
                }
                else
                {
                    SqlSelect = SqlSelect + " and user_type='S' and dept_code=@dept_code ";

                    IDataParameter para2 = DBObjectFactory.GetParameterObject();
                    para2.ParameterName = "@dept_code";
                    para2.DbType = DbType.String;
                    para2.Value = dept_code;
                    DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
                }
            }

            if (year_code != "")
            {
                SqlSelect = SqlSelect + " and year_code=@year_code ";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@year_code";
                para3.DbType = DbType.String;
                para3.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            if (prog_code != "")
            {
                SqlSelect = SqlSelect + " and prog_code=@prog_code ";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@prog_code";
                para3.DbType = DbType.String;
                para3.Value = prog_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            SqlSelect = SqlSelect + " order by user_id ";

            //IDataParameter para1 = DBObjectFactory.GetParameterObject();
            //para1.ParameterName = "@sem_code";
            //para1.DbType = DbType.String;
            //para1.Value = sem_code;
            //DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_ws_student_fees_saved_data(string dept_code, string year_code, string current_ws_sem, string current_ws_year)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_user_fees_status where cancel_flag ='N' ";

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + "  and dept_code=@dept_code";

                IDataParameter para2 = DBObjectFactory.GetParameterObject();
                para2.ParameterName = "@dept_code";
                para2.DbType = DbType.String;
                para2.Value = dept_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para2);
            }
            if (year_code != "")
            {
                SqlSelect = SqlSelect + "  and year_code=@year_code";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@year_code";
                para3.DbType = DbType.String;
                para3.Value = year_code;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }
            if (current_ws_sem != "")
            {
                SqlSelect = SqlSelect + "  and semester_type=@semester_type";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@semester_type";
                para3.DbType = DbType.String;
                para3.Value = current_ws_sem;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }

            if (current_ws_year != "")
            {
                SqlSelect = SqlSelect + "  and year_type=@year_type";

                IDataParameter para3 = DBObjectFactory.GetParameterObject();
                para3.ParameterName = "@year_type";
                para3.DbType = DbType.String;
                para3.Value = current_ws_year;
                DBDataAdpterObject.SelectCommand.Parameters.Add(para3);
            }
            //IDataParameter para1 = DBObjectFactory.GetParameterObject();
            //para1.ParameterName = "@sem_code";
            //para1.DbType = DbType.String;
            //para1.Value = sem_code;
            //DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            SqlSelect = SqlSelect + " order by user_id ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_prority_wise_registered_data_with_pivot(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select user_id,user_name,[1],[2],[3],[4],[5] from (select ws_student_wise_course_dtl.user_id,user_mst.user_name,ws_student_wise_course_dtl.course_code +'-'+ course_name as course,priority from ws_student_wise_course_dtl  " +
                        "inner join user_mst on ws_student_wise_course_dtl.user_id = user_mst.user_id " +
                        " where ws_student_wise_course_dtl.semester_type ='" + sem_code + "' and ws_student_wise_course_dtl.year_semester ='" + year_code + "' and status ='R' and user_status_flag ='A' and " +
                        " ws_student_wise_course_dtl.cancel_flag ='N' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester ='" + year_code + "' " +
                        " ) as a " +
                        " pivot " +
                        " (MIN (course) " +
                        " for priority in ([1], [2], [3], [4],[5]) " +
                        " ) AS PVTTable order by user_id";

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
            catch (Exception ex)
            {
                return null;
            }
        }



        public DataTable get_financial_report_data_WS(string dept_code, string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = " select UF.user_id,UF.fees_waiver_credits,UF.waiver_credits,UF.installmant_status,fees_status,user_mst.user_name,user_mst.prof_details,year_mst.year_desc,user_mst.gender,department_mst.dept_name,convert(varchar(10),UF.created_date,103) as date, " +
            //            " case prog_code when '1' then 'UG' when '2' then 'PG' when '3' then 'Doctoral' end as prog_name " +
            //            " from ws_user_fees_status as UF inner join user_mst on UF.user_id = user_mst.user_id inner join department_mst on user_mst.dept_code = department_mst.dept_code inner join year_mst on user_mst.year_code = year_mst.year_code " +
            //            " where UF.cancel_flag ='N' and fees_status ='Y' and semester_type ='" + sem_code + "' and year_type ='" + year_code + "' and user_status_flag ='A' " +
            //            " order by department_mst.dept_name,prog_name desc ";


            SqlSelect = " select ws_user_fees_status.user_id,user_mst.user_name,ws_user_fees_status.fees_type,user_mst.prof_details,year_mst.year_desc,user_mst.gender,department_mst.dept_name,case prog_code when '1' then 'UG' when '2' then 'PG' when '3' then 'Doctoral' end as prog_name,convert(varchar(10),ws_user_fees_status.created_date,103) as date, " +
             " ws_credit_choice.credit_choice,ws_user_fees_status.fees_waiver_credits,ws_user_fees_status.waiver_credits,ws_user_fees_status.installmant_status " +
             " from ws_user_fees_status left join " +
             " (select distinct user_id from ws_applicationpaymenttransaction WHERE   semester_type ='" + sem_code + "' and (year_semester = '" + year_code + "') AND (payment_response_code = 0)) as a " +
             " on ws_user_fees_status.user_id = a.user_id " +
             " left join ws_credit_choice on ws_user_fees_status.user_id = ws_credit_choice.user_id " +
             " inner join user_mst on ws_user_fees_status.user_id = user_mst.user_id " +
             " inner join department_mst on user_mst.dept_code = department_mst.dept_code " +
             " inner join year_mst on user_mst.year_code = year_mst.year_code " +
             " where ws_user_fees_status.semester_type ='" + sem_code + "' and year_type ='" + year_code + "' and ws_user_fees_status.fees_status = 'Y'  " +
             " and a.user_id is null and user_mst.user_status_flag = 'A' " +
             " and  ws_credit_choice.semester_type = '" + sem_code + "' and  ws_credit_choice.year_semester = '" + year_code + "'  " +
             " order by department_mst.dept_name,prog_name desc ";

            return Get_data(SqlSelect);

        }

        public DataTable get_financial_report_data_for_manual_online_fees(string dept_code, string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            //and user_status_flag ='A' Comment By Nitinbhai 16062023
            SqlSelect = " select UF.user_id,UF.fees_type,UF.fees_waiver_credits,UF.waiver_credits,UF.installmant_status,fees_status,ws_credit_choice.credit_choice,user_mst.user_name,user_mst.prof_details,year_mst.year_desc,user_mst.mail,user_mst.mobile_no,user_mst.gender,department_mst.dept_name,convert(varchar(10),UF.created_date,103) as date, " +
                        " case prog_code when '1' then 'UG' when '2' then 'PG' when '3' then 'Doctoral' end as prog_name " +
                        " from ws_user_fees_status as UF inner join user_mst on UF.user_id = user_mst.user_id inner join department_mst on user_mst.dept_code = department_mst.dept_code inner join year_mst on user_mst.year_code = year_mst.year_code " +
                        " left join ws_credit_choice on uf.user_id = ws_credit_choice.user_id and ws_credit_choice.cancel_flag ='N' " +
                        "           and ws_credit_choice.semester_type ='" + sem_code + "' and ws_credit_choice.year_semester ='" + year_code + "' " +
                        " where UF.cancel_flag ='N' and fees_status ='Y' and UF.semester_type ='" + sem_code + "' and UF.year_type ='" + year_code + "'  " +
                        " order by department_mst.dept_name,prog_name desc ";

            return Get_data(SqlSelect);

        }
        #endregion

        public DataTable Get_student_passport_detail(string user_id)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from student_transcript_dtl where user_id='" + user_id + "'";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public void save_student_passport_detail(string user_id, Dictionary<string, string> dic_student_passport_dtl, string action)
        {
            //DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            if (action == "I")
            {
                SqlSelect = "insert into student_transcript_dtl(doc_no,user_id,name_as_per_passport,passport_number,passport_scan_copy,cancel_flag,created_by,created_date) " +
                                "values('" + user_id + "','" + user_id + "','" + dic_student_passport_dtl["name_as_per_passport"].ToString() + "','" + dic_student_passport_dtl["passport_number"].ToString() + "','" + dic_student_passport_dtl["passport_scan_copy"].ToString() + "','N','" + user_id + "','" + DateTime.Now + "')";

                //DBDataAdpterObject.InsertCommand.CommandText = SqlSelect;
                DBCommand.CommandText = SqlSelect;
            }
            else if (action == "U")
            {
                SqlSelect = "update student_transcript_dtl set name_as_per_passport='" + dic_student_passport_dtl["name_as_per_passport"].ToString() + "',passport_number='" + dic_student_passport_dtl["passport_number"].ToString() + "',passport_scan_copy='" + dic_student_passport_dtl["passport_scan_copy"].ToString() + "',cancel_flag='N',last_modified_by='" + user_id + "',last_modified_date='" + DateTime.Now + "' " +
                                " where user_id='" + user_id + "'";

                //DBDataAdpterObject.UpdateCommand.CommandText = SqlSelect;
                DBCommand.CommandText = SqlSelect;
            }

            DataSet ds = new DataSet();
            try
            {
                //DBDataAdpterObject.Fill(ds);
                //if (ds.Tables[0].Rows.Count <= 0)
                //    return null;
                //else
                //    return ds.Tables[0];

                DBConnection.Open();

                //int res = DBDataAdpterObject.Update(ds);
                int res = DBCommand.ExecuteNonQuery();

                DBConnection.Close();
            }
            catch (Exception ex)
            {
                DBConnection.Close();
                //return null;
            }
        }

        #endregion

        #region Save methods

        public BLReturnObject Save_registration_data(DataSet ds_UploadData, string compnyid, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_userupload = (DSC_userdataupload_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                //Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                DSC_userdataupload_WS objuserupload = new DSC_userdataupload_WS();


                objuserupload.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                //for (int mprCnt = 0; mprCnt < obj_PO_Upload.PO_UploadDetails.Rows.Count; mprCnt++)
                for (int mprCnt = 0; mprCnt < server_userupload.user_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();

                    string document = server_userupload.user_mst[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    objuserupload.user_mst.ImportRow(server_userupload.user_mst.Rows[mprCnt]);

                    if (strSplitArr == "W")
                    {

                    }
                    else
                    {

                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "WS", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        objuserupload.user_mst[mprCnt].doc_no = DocNo;
                        objuserupload.user_mst[mprCnt].user_id = DocNo;
                        objuserupload.user_mst[mprCnt].student_no = DocNo;
                        objuserupload.user_mst[mprCnt].created_by = DocNo;
                    }

                }

                for (int mprCnt = 0; mprCnt < server_userupload.ws_student_certificate_dtl.Rows.Count; mprCnt++)
                {

                    objuserupload.ws_student_certificate_dtl.ImportRow(server_userupload.ws_student_certificate_dtl.Rows[mprCnt]);

                    objuserupload.ws_student_certificate_dtl[mprCnt].user_id = DocNo;

                    objuserupload.ws_student_certificate_dtl[mprCnt].created_by = DocNo;

                }

                //  objuserupload.user_mst.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.user_mst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.user_mst.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.ws_student_certificate_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.ws_student_certificate_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }
                else
                {
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 1;
                    objBLReturnObject.ServerMessage = "Data Registerd Successfully.Your Student code is :" + DocNo;
                    return objBLReturnObject;
                }

            }

            catch (Exception ex)
            {
                objBLReturnObject.ServerMessage = ex.ToString();
            }
            return objBLReturnObject;
        }

        public string get_doc_no_student_certificate()
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            string DocNo = "", message = "";
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                objDocument = new Document();

                DBConnection.Open();


                if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "CF", "", "", ref DocNo, ref message))
                {

                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    return "Error";
                }
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();

            }

            catch (Exception ex)
            {
                objBLReturnObject.ServerMessage = ex.ToString();
            }
            return DocNo;
        }

        //For Save Student fees Status Half / full semester wise
        public BLReturnObject save_user_fees(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_fees_status = (DSC_fees_status_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DSC_fees_status_WS obj_fees_status = new DSC_fees_status_WS();

                obj_fees_status.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_fees_status.user_fees_status.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_fees_status.user_fees_status[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_fees_status.user_fees_status.ImportRow(server_fees_status.user_fees_status.Rows[mprCnt]);
                    if (strSplitArr == "U")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "UF", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_fees_status.user_fees_status[mprCnt].doc_no = DocNo;
                    }






                    //objorder.PO_UploadDetails[mprCnt].created_by = UserID;
                    //objorder.PO_UploadDetails[mprCnt].created_host = HostName;
                    //objorder.PO_UploadDetails[mprCnt].created_date = DateTime.Now;

                }


                obj_fees_status.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_fees_status.user_fees_status, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_fees_status.user_fees_status.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject save_ws_user_fees(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_fees_status = (DSC_fees_status_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DSC_fees_status_WS obj_fees_status = new DSC_fees_status_WS();

                obj_fees_status.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);

                for (int mprCnt = 0; mprCnt < server_fees_status.ws_user_fees_status.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_fees_status.ws_user_fees_status[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_fees_status.ws_user_fees_status.ImportRow(server_fees_status.ws_user_fees_status.Rows[mprCnt]);
                    if (strSplitArr == "U")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "UFW", UserID, HostName, ref DocNo, ref message))
                        {
                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_fees_status.ws_user_fees_status[mprCnt].doc_no = DocNo;
                    }

                    //objorder.PO_UploadDetails[mprCnt].created_by = UserID;
                    //objorder.PO_UploadDetails[mprCnt].created_host = HostName;
                    //objorder.PO_UploadDetails[mprCnt].created_date = DateTime.Now;
                }

                obj_fees_status.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_fees_status.ws_user_fees_status, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_fees_status.ws_user_fees_status.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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
            catch (Exception ex)
            {
            }

            return objBLReturnObject;
        }

        public BLReturnObject save_ws_user_fees_for_online_payment(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {
                ServerLog.InvalidLoginLog("Start save_ws_user_fees_for_online_payment method in master");
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_fees_status = (DSC_fees_status_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DSC_fees_status_WS obj_fees_status = new DSC_fees_status_WS();

                obj_fees_status.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_fees_status.ws_user_fees_status.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_fees_status.ws_user_fees_status[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_fees_status.ws_user_fees_status.ImportRow(server_fees_status.ws_user_fees_status.Rows[mprCnt]);
                    if (strSplitArr == "U")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "UFW", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_fees_status.ws_user_fees_status[mprCnt].doc_no = DocNo;
                    }






                    //objorder.PO_UploadDetails[mprCnt].created_by = UserID;
                    //objorder.PO_UploadDetails[mprCnt].created_host = HostName;
                    //objorder.PO_UploadDetails[mprCnt].created_date = DateTime.Now;

                }


                obj_fees_status.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_fees_status.ws_user_fees_status, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_fees_status.ws_user_fees_status.Rows.Count)
                {
                    ServerLog.InvalidLoginLog("Fail to Save Details.");
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                else
                {
                    ServerLog.InvalidLoginLog("Data save successfully ");
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 1;
                    objBLReturnObject.ServerMessage = "Data Saved Successfully";
                    return objBLReturnObject;
                }

            }

            catch (Exception ex)
            {
                ServerLog.InvalidLoginLog("Error in save in master catch : " + ex.Message);
            }
            return objBLReturnObject;
        }

        public BLReturnObject save_student_current_sem(DataSet ds_UploadData, String UserID, String HostName, String prog_code)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                String dept_code = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student = new Ds_Student_Course_detail_WS();

                obj_student.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_student_course.student_current_sem_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_student_course.student_current_sem_dtl[mprCnt].doc_no;
                    dept_code = server_student_course.student_current_sem_dtl[mprCnt].dept_code; ;
                    string strSplitArr = document.Substring(0, 1);
                    obj_student.student_current_sem_dtl.ImportRow(server_student_course.student_current_sem_dtl.Rows[mprCnt]);
                    if (strSplitArr == "C")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "CS", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_student.student_current_sem_dtl[mprCnt].doc_no = DocNo;
                    }

                }

                obj_student.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                Boolean status = Update_current_sem_flag(dept_code, UserID, HostName, prog_code);



                if (status == true)
                {

                }
                else
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }


                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student.student_current_sem_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student.student_current_sem_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject save_ws_student_current_sem(DataSet ds_UploadData, String UserID, String HostName, String prog_code)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                String dept_code = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student = new Ds_Student_Course_detail_WS();

                obj_student.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_student_course.ws_current_semester.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_student_course.ws_current_semester[mprCnt].doc_no;

                    obj_student.ws_current_semester.ImportRow(server_student_course.ws_current_semester.Rows[mprCnt]);

                }


                obj_student.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                Boolean status = Update_current_sem_flag(dept_code, UserID, HostName, prog_code);

                if (status == true)
                {

                }
                else
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }


                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student.ws_current_semester, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student.ws_current_semester.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject save_increase_course_seats_data(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                String dept_code = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student = new Ds_Student_Course_detail_WS();

                obj_student.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_student_course.ws_course_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    // string document = server_student_course.department_wise_course_dtl[mprCnt].doc_no;
                    //   dept_code = server_student_course.ws_course_mst[mprCnt].dept_code; ;
                    //  string strSplitArr = document.Substring(0, 1);
                    obj_student.ws_course_mst.ImportRow(server_student_course.ws_course_mst.Rows[mprCnt]);
                    //if (strSplitArr == "C")
                    //{
                    //}
                    //else
                    //{
                    //    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "CS", UserID, HostName, ref DocNo, ref message))
                    //    {

                    //        DBCommand.Transaction.Rollback();
                    //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    //        objBLReturnObject.ExecutionStatus = 2;
                    //        return objBLReturnObject;
                    //    }

                    //    obj_student.student_current_sem_dtl[mprCnt].doc_no = DocNo;
                    //}








                }


                obj_student.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;




                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student.ws_course_mst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student.ws_course_mst.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject Save_ws_student_course_dtl(DataSet ds_UploadData, String UserID, String current_sem_code, String HostName, string sem_code, string year_code)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student_course = new Ds_Student_Course_detail_WS();

                obj_student_course.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_student_course.ws_student_wise_course_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_student_course.ws_student_wise_course_dtl[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_student_course.ws_student_wise_course_dtl.ImportRow(server_student_course.ws_student_wise_course_dtl.Rows[mprCnt]);
                    if (strSplitArr == "S")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "SCW", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_student_course.ws_student_wise_course_dtl[mprCnt].doc_no = DocNo;
                    }
                }

                Boolean flag;
                obj_student_course.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                flag = Update_Student_course_flag(UserID, current_sem_code, "Y", sem_code, year_code);

                if (flag == false)
                {
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student_course.ws_student_wise_course_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student_course.ws_student_wise_course_dtl.Rows.Count)
                {
                    flag = Update_Student_course_flag(UserID, current_sem_code, "N", sem_code, year_code);
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject Save_assign_course_dtl(DataSet ds_UploadData, String UserID, String current_sem_code, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student_course = new Ds_Student_Course_detail_WS();

                obj_student_course.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                // server_student_course.student_course_allocate_dtl.DefaultView.Sort = "course_code asc";


                for (int mprCnt = 0; mprCnt < server_student_course.ws_student_course_allocate_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_student_course.ws_student_course_allocate_dtl[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_student_course.ws_student_course_allocate_dtl.ImportRow(server_student_course.ws_student_course_allocate_dtl.Rows[mprCnt]);
                    if (strSplitArr == "S")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "SA", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_student_course.ws_student_course_allocate_dtl[mprCnt].doc_no = DocNo;
                    }
                }


                obj_student_course.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;





                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student_course.ws_student_course_allocate_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student_course.ws_student_course_allocate_dtl.Rows.Count)
                {
                    //  flag = Update_Student_course_flag(UserID, current_sem_code, "N");
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                else
                {
                    if (current_sem_code != "manually")
                    {



                        Boolean update_status = Update_status_flag("", "");

                        if (update_status == true)
                        {

                        }
                        else
                        {
                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            objBLReturnObject.ServerMessage = "Fail to Save Details.";
                            return objBLReturnObject;
                        }
                    }

                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 1;
                    objBLReturnObject.ServerMessage = "Data Saved Successfully";
                    return objBLReturnObject;
                }

            }

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject Save_ws_assign_course_dtl(DataSet ds_UploadData, String UserID, String current_sem_code, String HostName, string sem_code, string year_code)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student_course = new Ds_Student_Course_detail_WS();

                obj_student_course.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                // server_student_course.student_course_allocate_dtl.DefaultView.Sort = "course_code asc";


                for (int mprCnt = 0; mprCnt < server_student_course.ws_student_course_allocate_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_student_course.ws_student_course_allocate_dtl[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_student_course.ws_student_course_allocate_dtl.ImportRow(server_student_course.ws_student_course_allocate_dtl.Rows[mprCnt]);
                    if (strSplitArr == "S")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "SAW", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_student_course.ws_student_course_allocate_dtl[mprCnt].doc_no = DocNo;
                    }
                }


                obj_student_course.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;





                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student_course.ws_student_course_allocate_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student_course.ws_student_course_allocate_dtl.Rows.Count)
                {
                    //  flag = Update_Student_course_flag(UserID, current_sem_code, "N");
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                else
                {
                    if (current_sem_code != "manually")
                    {



                        Boolean update_status = Update_status_flag(sem_code, year_code);

                        if (update_status == true)
                        {

                        }
                        else
                        {
                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            objBLReturnObject.ServerMessage = "Fail to Save Details.";
                            return objBLReturnObject;
                        }
                    }

                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 1;
                    objBLReturnObject.ServerMessage = "Data Saved Successfully";
                    return objBLReturnObject;
                }

            }

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }
        public BLReturnObject save_choice_credit_for_student(DataSet ds_UploadData, String UserID, String current_sem_code, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student_course = new Ds_Student_Course_detail_WS();

                obj_student_course.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                // server_student_course.student_course_allocate_dtl.DefaultView.Sort = "course_code asc";


                for (int mprCnt = 0; mprCnt < server_student_course.student_current_sem_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_student_course.student_current_sem_dtl[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_student_course.student_current_sem_dtl.ImportRow(server_student_course.student_current_sem_dtl.Rows[mprCnt]);
                    //if (document == "new")
                    //{

                    //}
                    //else
                    //{
                    //    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "CC", UserID, HostName, ref DocNo, ref message))
                    //    {

                    //        DBCommand.Transaction.Rollback();
                    //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    //        objBLReturnObject.ExecutionStatus = 2;
                    //        return objBLReturnObject;
                    //    }

                    //    obj_student_course.student_course_allocate_dtl[mprCnt].doc_no = DocNo;
                    //}
                }


                obj_student_course.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;





                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student_course.student_current_sem_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student_course.student_current_sem_dtl.Rows.Count)
                {
                    //  flag = Update_Student_course_flag(UserID, current_sem_code, "N");
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }
        public BLReturnObject save_ws_choice_credit_for_student(DataSet ds_UploadData, String UserID, String current_sem_code, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student_course = new Ds_Student_Course_detail_WS();

                obj_student_course.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                // server_student_course.student_course_allocate_dtl.DefaultView.Sort = "course_code asc";


                for (int mprCnt = 0; mprCnt < server_student_course.ws_credit_choice.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_student_course.ws_credit_choice[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_student_course.ws_credit_choice.ImportRow(server_student_course.ws_credit_choice.Rows[mprCnt]);
                    if (strSplitArr == "C")
                    {

                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "CCW", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_student_course.ws_credit_choice[mprCnt].doc_no = DocNo;
                    }
                }


                obj_student_course.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;





                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student_course.ws_credit_choice, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student_course.ws_credit_choice.Rows.Count)
                {
                    //  flag = Update_Student_course_flag(UserID, current_sem_code, "N");
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject save_rest_password(DataSet ds_UploadData, string company, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_userupload = (DSC_userdataupload_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DSC_userdataupload_WS objuserupload = new DSC_userdataupload_WS();

                objuserupload.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                // server_student_course.student_course_allocate_dtl.DefaultView.Sort = "course_code asc";


                for (int mprCnt = 0; mprCnt < server_userupload.user_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();

                    string document = server_userupload.user_mst[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    objuserupload.user_mst.ImportRow(server_userupload.user_mst.Rows[mprCnt]);


                    if (strSplitArr == "U")
                    {

                    }
                    else
                    {

                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, company, "UD", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        objuserupload.user_mst[mprCnt].doc_no = DocNo;
                    }
                }

                //objuserupload.user_mst.AcceptChanges();
                objuserupload.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;



                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.user_mst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                //    objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.user_mst, BLGeneralUtil.UpdateWhereMode.KeyAndModifiedColumns);
                // objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.user_mst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.user_mst.Rows.Count)
                {
                    //  flag = Update_Student_course_flag(UserID, current_sem_code, "N");
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject save_change_data_after_allocation(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                String dept_code = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student = new Ds_Student_Course_detail_WS();

                obj_student.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_student_course.student_wise_course_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    // string document = server_student_course.department_wise_course_dtl[mprCnt].doc_no;
                    dept_code = server_student_course.student_wise_course_dtl[mprCnt].dept_code; ;
                    //  string strSplitArr = document.Substring(0, 1);
                    obj_student.student_wise_course_dtl.ImportRow(server_student_course.student_wise_course_dtl.Rows[mprCnt]);
                }




                for (int mprCnt = 0; mprCnt < server_student_course.ws_student_course_allocate_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    // string document = server_student_course.department_wise_course_dtl[mprCnt].doc_no;
                    dept_code = server_student_course.ws_student_course_allocate_dtl[mprCnt].dept_code; ;
                    //  string strSplitArr = document.Substring(0, 1);
                    obj_student.ws_student_course_allocate_dtl.ImportRow(server_student_course.ws_student_course_allocate_dtl.Rows[mprCnt]);
                }

                obj_student.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;




                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student.ws_student_wise_course_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student.ws_student_wise_course_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }
                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student.ws_student_course_allocate_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student.ws_student_course_allocate_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject save_ws_change_data_before_allocation(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_student_course = (Ds_Student_Course_detail_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                String dept_code = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                Ds_Student_Course_detail_WS obj_student = new Ds_Student_Course_detail_WS();

                obj_student.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_student_course.ws_student_wise_course_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    // string document = server_student_course.department_wise_course_dtl[mprCnt].doc_no;
                    dept_code = server_student_course.ws_student_wise_course_dtl[mprCnt].dept_code; ;
                    //  string strSplitArr = document.Substring(0, 1);
                    obj_student.ws_student_wise_course_dtl.ImportRow(server_student_course.ws_student_wise_course_dtl.Rows[mprCnt]);
                }




                for (int mprCnt = 0; mprCnt < server_student_course.ws_student_course_allocate_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();

                    string document = server_student_course.ws_student_course_allocate_dtl[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_student.ws_student_course_allocate_dtl.ImportRow(server_student_course.ws_student_course_allocate_dtl.Rows[mprCnt]);


                    if (strSplitArr == "S")
                    {

                    }
                    else
                    {

                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "SAW", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_student.ws_student_course_allocate_dtl[mprCnt].doc_no = DocNo;
                    }
                }

                obj_student.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;




                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student.ws_student_wise_course_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student.ws_student_wise_course_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }
                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_student.ws_student_course_allocate_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_student.ws_student_course_allocate_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {
                //return ex.ToString();
            }
            return objBLReturnObject;
        }

        public BLReturnObject save_student_term_and_condition(DataSet ds_UploadData, String UserID, String compnyid, string HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {



                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_userupload = (DSC_userdataupload_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                //Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                DSC_userdataupload_WS objuserupload = new DSC_userdataupload_WS();


                objuserupload.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);

                //  ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows.Count.ToString());

                //for (int mprCnt = 0; mprCnt < obj_PO_Upload.PO_UploadDetails.Rows.Count; mprCnt++)
                for (int mprCnt = 0; mprCnt < server_userupload.ws_term_condition.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();

                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["doc_no"].ToString());

                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["user_id"].ToString());
                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["term_condition"].ToString());
                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["semester_type"].ToString());
                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["year_semester"].ToString());

                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["created_date"].ToString());
                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["created_by"].ToString());
                    //ServerLog.InvalidLoginLog(server_userupload.ws_term_condition.Rows[mprCnt]["created_host"].ToString());

                    string document = server_userupload.ws_term_condition[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    objuserupload.ws_term_condition.ImportRow(server_userupload.ws_term_condition.Rows[mprCnt]);

                    if (strSplitArr == "T")
                    {

                    }
                    else
                    {

                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "TC", UserID, HostName, ref DocNo, ref message))
                        {
                            //    ServerLog.InvalidLoginLog("Doc_no = " + message + "-" + DocNo);
                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        objuserupload.ws_term_condition[mprCnt].doc_no = DocNo;

                        //    ServerLog.InvalidLoginLog(DocNo.ToString());

                    }

                }



                //  objuserupload.user_mst.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;
                //  ServerLog.InvalidLoginLog("Before Update");
                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.ws_term_condition, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.ws_term_condition.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }
                else
                {
                    DBCommand.Transaction.Commit();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 1;
                    objBLReturnObject.ServerMessage = "ok";
                    return objBLReturnObject;
                }

            }

            catch (Exception ex)
            {
                objBLReturnObject.ServerMessage = "Problem in save data";
            }
            return objBLReturnObject;
        }

        public BLReturnObject save_feedback_data(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_feedback = (DS_Feedback_Save_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DS_Feedback_Save_WS obj_feedback = new DS_Feedback_Save_WS();

                obj_feedback.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);

                Dictionary<string, object> WhereCriteriaDegree = new Dictionary<string, object>();
                string Message = "";
                WhereCriteriaDegree["user_id"] = UserID;
                //         WhereCriteriaDegree["course_type"] = server_feedback.student_feedback_dtl[0].course_type;
                WhereCriteriaDegree["course_code"] = server_feedback.ws_student_feedback_dtl[0].course_code;
                WhereCriteriaDegree["semester_type"] = server_feedback.ws_student_feedback_dtl[0].semester_type;
                WhereCriteriaDegree["year_semester"] = server_feedback.ws_student_feedback_dtl[0].year_semester;
                bool resultDegree = DeleteData(ref DBCommand, "ws_student_feedback_dtl", WhereCriteriaDegree, ref Message);


                for (int mprCnt = 0; mprCnt < server_feedback.ws_student_feedback_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_feedback.ws_student_feedback_dtl[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_feedback.ws_student_feedback_dtl.ImportRow(server_feedback.ws_student_feedback_dtl.Rows[mprCnt]);
                    if (strSplitArr == "F")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "FBW", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_feedback.ws_student_feedback_dtl[mprCnt].doc_no = DocNo;
                    }






                    //objorder.PO_UploadDetails[mprCnt].created_by = UserID;
                    //objorder.PO_UploadDetails[mprCnt].created_host = HostName;
                    //objorder.PO_UploadDetails[mprCnt].created_date = DateTime.Now;

                }


                obj_feedback.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_feedback.ws_student_feedback_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_feedback.ws_student_feedback_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public BLReturnObject Save_manually_Online_transaction_data(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();

            try
            {
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                DS_Payment_WS server_payment = new DS_Payment_WS();

                server_payment = (DS_Payment_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DS_Payment_WS obj_payment = new DS_Payment_WS();

                obj_payment.EnforceConstraints = false;

                for (int mprCnt = 0; mprCnt < server_payment.ws_applicationpaymenttransaction.Rows.Count; mprCnt++)
                {
                    obj_payment.ws_applicationpaymenttransaction.ImportRow(server_payment.ws_applicationpaymenttransaction.Rows[mprCnt]);
                }

                for (int mprCnt = 0; mprCnt < server_payment.user_activity_log.Rows.Count; mprCnt++)
                {
                    objDocument.W_GetNextDocumentNo(ref DBCommand, "", "UA", UserID, HostName, ref DocNo, ref message);

                    obj_payment.user_activity_log.ImportRow(server_payment.user_activity_log.Rows[mprCnt]);
                    obj_payment.user_activity_log[mprCnt].doc_no = DocNo;
                }

                obj_payment.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_payment.ws_applicationpaymenttransaction, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_payment.ws_applicationpaymenttransaction.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_payment.user_activity_log, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_payment.user_activity_log.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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
            catch (Exception ex)
            {
            }

            return objBLReturnObject;
        }

        public Boolean insert_allocation_agree_or_not_data(string flag, string user_id, string host_name, string sem_code, string year_code)
        {
            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();

            DBCommand.Transaction = DBConnection.BeginTransaction();

            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            try
            {

                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                SqlSelect = "";

                SqlSelect = "insert into ws_student_course_allocate_agree_dtl(user_id,flag,semester_type,year_semester,created_by,created_date,created_host) VALUES('" + user_id + "' , '" + flag + "', '" + sem_code + "','" + year_code + "' ,'" + user_id + "', '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' , '" + host_name + "' )";

                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

                DBCommand.ExecuteNonQuery();

                //if (flag == "N")
                //{
                //    SqlSelect = "update ws_student_course_allocate_dtl set cancel_flag ='Y' ,last_modified_by = '" + user_id + "' , last_modified_host = '" + host_name + "' , last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' where user_id ='" + user_id + "' and  semester_type = '" + sem_code + "' and year_semester = '" + year_code + "' and cancel_flag ='N' ";

                //    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

                //    DBCommand.ExecuteNonQuery();
                //}

                DBCommand.Transaction.Commit();

                DBConnection.Close();
                return true;
            }
            catch (Exception ex)
            {
                DBCommand.Transaction.Rollback();
                DBConnection.Close();
                return false;
            }
        }

        #endregion

        #region SWS

        public DataTable Get_course_wise_allocation_dtl(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select t1.course_code,t1.course_name,t1.course_type,t1.total_course,t1.dept_name,t1.available_seat, " +
                " COUNT(wsc.course_code) as final_allocation_status,STUFF((select ', '+ws_student_course_allocate_dtl.user_id from ws_student_course_allocate_dtl " +
                " where ws_student_course_allocate_dtl.course_code = t1.course_code and ws_student_course_allocate_dtl.cancel_flag='N' and ws_student_course_allocate_dtl.semester_type='" + sem_code + "'  " +
                " and ws_student_course_allocate_dtl.year_semester='" + year_code + "' FOR XML PATH(''),TYPE ).value('.','NVARCHAR(MAX)'),1,2,'')allocated_user_id, " +
                " (select COUNT(wswc.course_code) from ws_student_wise_course_dtl as wswc where wswc.semester_type='" + sem_code + "' and wswc.year_semester='" + year_code + "' " +
                " and wswc.course_code=t1.course_code and wswc.cancel_flag ='N' and wswc.status='R') registered_students" +
                " from ( select ws_student_wise_course_dtl.course_code,ws_course_mst.course_name,ws_student_wise_course_dtl.course_type, " +
                " COUNT(ws_student_wise_course_dtl.course_code) as total_course,department_mst.dept_name,ws_course_mst.available_seat from ws_student_wise_course_dtl " +
                " INNER JOIN   ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
                " INNER JOIN department_mst on ws_student_wise_course_dtl.dept_code = department_mst.dept_code " +
                " where ws_student_wise_course_dtl.cancel_flag = 'N' and (ws_student_wise_course_dtl.status ='R' or ws_student_wise_course_dtl.status ='A')  and ws_student_wise_course_dtl.semester_type = '" + sem_code + "'" +
                " and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' " +
                " GROUP BY ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type,ws_course_mst.course_name,department_mst.dept_name,ws_course_mst.available_seat) t1 " +
                " left join ws_student_course_allocate_dtl wsc on wsc.course_code = t1.course_code and wsc.cancel_flag='N' " +
                " and wsc.semester_type= '" + sem_code + "' and wsc.year_semester = '" + year_code + "' " +
                " GROUP BY t1.course_code,t1.course_name,t1.course_type,t1.total_course,t1.dept_name,t1.available_seat,wsc.course_code order by course_code ";

            //SqlSelect = " select ws_student_wise_course_dtl.course_code,ws_course_mst.course_name,ws_student_wise_course_dtl.course_type,COUNT(ws_student_wise_course_dtl.course_code) as total_course,department_mst.dept_name,ws_course_mst.available_seat " +
            //            " from ws_student_wise_course_dtl  INNER JOIN   ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
            //            " INNER JOIN department_mst on ws_student_wise_course_dtl.dept_code = department_mst.dept_code where ws_student_wise_course_dtl.cancel_flag = 'N'   and (ws_student_wise_course_dtl.status ='R' or ws_student_wise_course_dtl.status ='A') ";
            //if (sem_code != "" && year_code != "")
            //{
            //    SqlSelect = SqlSelect + " and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";

            //}
            //SqlSelect = SqlSelect + "GROUP BY ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type,ws_course_mst.course_name,department_mst.dept_name,ws_course_mst.available_seat ";

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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_course_cancel_dtl(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select ws_student_wise_course_dtl.course_code,ws_course_mst.course_name,ws_student_wise_course_dtl.course_type, " +
                        " COUNT(ws_student_wise_course_dtl.course_code) as registered_seat,department_mst.dept_name,ws_course_mst.available_seat,ws_course_mst.minimum_seat " +
                        " from ws_student_wise_course_dtl " +
                        " INNER JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
                        " INNER JOIN department_mst on ws_student_wise_course_dtl.dept_code = department_mst.dept_code " +
                        " where ws_student_wise_course_dtl.cancel_flag = 'N' and(ws_student_wise_course_dtl.status = 'R' or ws_student_wise_course_dtl.status = 'A') " +
                        " and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type = '" + sem_code + "' " +
                        " and ws_course_mst.year_semester = '" + year_code + "' " +
                        " GROUP BY ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type,ws_course_mst.course_name,department_mst.dept_name,ws_course_mst.available_seat,ws_course_mst.minimum_seat ";

            if (sem_code.ToUpper() == "W" && year_code == "2023")
            {
                SqlSelect = "";
                SqlSelect = @" select ws_student_wise_course_dtl.course_code,ws_course_mst.course_name,ws_student_wise_course_dtl.course_type,  
                               COUNT(ws_student_wise_course_dtl.course_code) as registered_seat,department_mst.dept_name,

                               ws_course_mst.available_seat,ws_course_mst.minimum_seat
                               from ws_connect_student_reg_dtl as ws_student_wise_course_dtl
                               INNER JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code
                               INNER JOIN department_mst on ws_course_mst.dept_code = department_mst.dept_code
                               where ws_student_wise_course_dtl.cancel_flag = 'N' and(ws_student_wise_course_dtl.status = 'P'
                               or ws_student_wise_course_dtl.status = 'A') and ws_student_wise_course_dtl.course_drop_status IS NULL
                               and ws_student_wise_course_dtl.semester_type = 'W'
                               and ws_student_wise_course_dtl.year_semester = '2023' and ws_course_mst.semester_type = 'W'
                               and ws_course_mst.year_semester = '2023'
                               GROUP BY ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type,ws_course_mst.course_name,department_mst.dept_name,
                               ws_course_mst.available_seat,ws_course_mst.minimum_seat ";

            }
            else if (Convert.ToInt32(year_code) > Convert.ToInt32("2023"))
            {
                SqlSelect = "";
                SqlSelect = @" select ws_student_wise_course_dtl.course_code,ws_course_mst.course_name,ws_student_wise_course_dtl.course_type,  
                               COUNT(ws_student_wise_course_dtl.course_code) as registered_seat,department_mst.dept_name,

                               ws_course_mst.available_seat,ws_course_mst.minimum_seat
                               from ws_connect_student_reg_dtl as ws_student_wise_course_dtl
                               INNER JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code
                               INNER JOIN department_mst on ws_course_mst.dept_code = department_mst.dept_code
                               where ws_student_wise_course_dtl.cancel_flag = 'N' and(ws_student_wise_course_dtl.status = 'P'
                               or ws_student_wise_course_dtl.status = 'A') and ws_student_wise_course_dtl.course_drop_status IS NULL
                               and ws_student_wise_course_dtl.semester_type = '" + sem_code + @"'
                               and ws_student_wise_course_dtl.year_semester = '" + year_code + @"' and ws_course_mst.semester_type = '" + sem_code + @"'
                               and ws_course_mst.year_semester = '" + year_code + @"'
                               GROUP BY ws_student_wise_course_dtl.course_code,ws_student_wise_course_dtl.course_type,ws_course_mst.course_name,department_mst.dept_name,
                               ws_course_mst.available_seat,ws_course_mst.minimum_seat ";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        #endregion




        #region upload manually payslip

        public DataTable get_user_upload_payslip_data(string user_id, string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "  select uu.*,um.user_name,pm.prog_name +' in '+dm.dept_name as prog_name from  ws_user_uploaded_payslip_dtl as uu   inner join user_mst as um on uu.user_id = um.user_id  inner join department_mst as dm on um.dept_code = dm.dept_code left join programme_mst as pm on um.prog_code = pm.prog_code " +
                      " where  uu.cancel_flag = 'N' and uu.semester_type = '" + sem_code + "' and uu.year_semester ='" + year_code + "' and um.user_status_flag = 'A' and uu.is_admin_approved != 'R' ";

            //SqlSelect = "  select uu.*,um.user_name,pm.prog_name +' in '+dm.dept_name as prog_name from  user_uploaded_payslip_dtl as uu   inner join user_mst as um on uu.user_id = um.user_id  inner join department_mst as dm on um.dept_code = dm.dept_code inner join programme_mst as pm on um.prog_code = pm.prog_code " +
            //        " where  uu.cancel_flag = 'N' and uu.semester_type = '" + sem_code + "' and uu.year_semester ='" + year_code + "' and um.user_status_flag = 'A' ";

            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and  uu.user_id ='" + user_id + "'  ";
            }

            return Get_data(SqlSelect);
        }

        public DataTable get_user_upload_payslip_data_report(string user_id, string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "  select uu.*,um.user_name,pm.prog_name +' in '+dm.dept_name as prog_name,bank_branch_mst.branch from  ws_user_uploaded_payslip_dtl as uu   inner join user_mst as um on uu.user_id = um.user_id  inner join department_mst as dm on um.dept_code = dm.dept_code inner join programme_mst as pm on um.prog_code = pm.prog_code  inner join bank_branch_mst on uu.branch_name = bank_branch_mst.sol_id " +
                      " where  uu.cancel_flag = 'N' and uu.semester_type = '" + sem_code + "' and uu.year_semester ='" + year_code + "' and um.user_status_flag = 'A' and uu.is_admin_approved = 'A' ";

            //SqlSelect = "  select uu.*,um.user_name,pm.prog_name +' in '+dm.dept_name as prog_name from  user_uploaded_payslip_dtl as uu   inner join user_mst as um on uu.user_id = um.user_id  inner join department_mst as dm on um.dept_code = dm.dept_code inner join programme_mst as pm on um.prog_code = pm.prog_code " +
            //        " where  uu.cancel_flag = 'N' and uu.semester_type = '" + sem_code + "' and uu.year_semester ='" + year_code + "' and um.user_status_flag = 'A' ";

            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and  uu.user_id ='" + user_id + "'  ";
            }

            return Get_data(SqlSelect);
        }

        public DataTable Get_fees_status_for_student_for_fees_payment(string user_id, string sem_code, string year_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from  ws_user_fees_status " +
                      " where  ws_user_fees_status.cancel_flag = 'N' and ws_user_fees_status.semester_type = '" + sem_code + "' and ws_user_fees_status.year_type ='" + year_code + "' ";

            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and  ws_user_fees_status.user_id ='" + user_id + "' and ws_user_fees_status.fees_status in ('Y') ";
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
            catch (Exception ex)
            {
                return null;
            }

        }

        public BLReturnObject save_upload_manually_payslip_dtl(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_fees_status = (DSC_fees_status_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number

                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DSC_fees_status_WS obj_fees_status = new DSC_fees_status_WS();

                obj_fees_status.EnforceConstraints = false;

                for (int mprCnt = 0; mprCnt < server_fees_status.ws_user_uploaded_payslip_dtl.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_fees_status.ws_user_uploaded_payslip_dtl[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_fees_status.ws_user_uploaded_payslip_dtl.ImportRow(server_fees_status.ws_user_uploaded_payslip_dtl.Rows[mprCnt]);

                    if (strSplitArr == "W")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "WSMP", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_fees_status.ws_user_uploaded_payslip_dtl[mprCnt].doc_no = DocNo;
                    }
                }

                for (int mprCnt = 0; mprCnt < server_fees_status.ws_user_fees_status.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    string document = server_fees_status.ws_user_fees_status[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    obj_fees_status.ws_user_fees_status.ImportRow(server_fees_status.ws_user_fees_status.Rows[mprCnt]);
                    if (strSplitArr == "U")
                    {
                    }
                    else
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "UFW", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        obj_fees_status.ws_user_fees_status[mprCnt].doc_no = DocNo;
                    }

                }

                obj_fees_status.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;





                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_fees_status.ws_user_uploaded_payslip_dtl, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);

                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_fees_status.ws_user_uploaded_payslip_dtl.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_fees_status.ws_user_fees_status, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);

                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_fees_status.ws_user_fees_status.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }


                if (server_fees_status.ws_user_uploaded_payslip_dtl.Rows.Count > 0)
                {
                    if (server_fees_status.ws_user_uploaded_payslip_dtl[0].is_admin_approved == "R")
                    {
                        string user_id = obj_fees_status.ws_user_uploaded_payslip_dtl[0].user_id;
                        string sem_code = obj_fees_status.ws_user_uploaded_payslip_dtl[0].semester_type;
                        string year_code = obj_fees_status.ws_user_uploaded_payslip_dtl[0].year_semester;

                        DBDataAdpterObject.SelectCommand.Parameters.Clear();
                        String SqlSelect = "";

                        SqlSelect = "update ws_student_wise_course_dtl set status ='S' where cancel_flag = 'N' and status = 'R' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "' and user_id = '" + user_id + "'";

                        DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                        try
                        {
                            DBCommand.ExecuteNonQuery();

                            DBCommand.Transaction.Commit();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 1;
                            objBLReturnObject.ServerMessage = "Data Saved Successfully";
                        }
                        catch (Exception ex)
                        {
                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            objBLReturnObject.ServerMessage = "Fail to Save Details.";
                            return objBLReturnObject;


                        }
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
                else
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

            }

            catch (Exception ex)
            {

            }
            return objBLReturnObject;
        }

        public DataTable get_upload_manually_payslip_dtl(string dept_code, string prog_code, string year_of_allocation, string current_fees_sem, string current_fees_year)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();

            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_code";
            para1.DbType = DbType.String;
            para1.Value = dept_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@year_of_allocation";
            para1.DbType = DbType.String;
            para1.Value = year_of_allocation;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@prog_code";
            para1.DbType = DbType.String;
            para1.Value = prog_code;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@sem_code";
            para1.DbType = DbType.String;
            para1.Value = current_fees_sem;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@year_code";
            para1.DbType = DbType.String;
            para1.Value = current_fees_year;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);

            return Get_data_from_SP("ws_get_upload_manually_payslip_dtl");
        }

        public DataTable Get_student_fees_saved_data_for_manually_accept(string user_id, string current_sem_code, string current_year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_user_fees_status where cancel_flag ='N'  and semester_type ='" + current_sem_code + "' and year_type ='" + current_year_code + "' ";

            if (user_id != "")
            {
                SqlSelect = SqlSelect + " and user_id ='" + user_id + "' ";
            }

            return Get_data(SqlSelect);
        }
        #endregion

        #region

        #region Update Method

        public Boolean Update_status_flag(string sem_code, string year_code)
        {
            /*************************/
            /* ESTABLISH CONNECTION */

            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "update ws_student_wise_course_dtl set status ='A' where cancel_flag = 'N' and status = 'R' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            try
            {
                DBCommand.ExecuteNonQuery();

                return true;
            }
            catch (Exception)
            {

                return false;
            }
        }

        public Boolean Update_Student_course_flag(string user_id, string current_sem_code, string flag, string sem_code, string year_code)
        {
            /*************************/
            /* ESTABLISH CONNECTION */

            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "update ws_student_wise_course_dtl set cancel_flag ='" + flag + "' where user_id = '" + user_id + "' ";

            if (current_sem_code != "")
            {
                SqlSelect = SqlSelect + "and semester_type ='" + sem_code + "' and year_semester = '" + year_code + "' ";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            try
            {
                DBCommand.ExecuteNonQuery();
                // DBConnection.Close();
                return true;
            }
            catch (Exception)
            {
                // DBConnection.Close();
                return false;
            }
        }

        //public Boolean remove_all_allocate_data()
        //{
        //    /*************************/
        //    /* ESTABLISH CONNECTION */
        //    DBConnection.Open();

        //    /*************************/
        //    DBDataAdpterObject.SelectCommand.Parameters.Clear();
        //    String SqlSelect = "";

        //    SqlSelect = "update student_course_allocate_dtl set cancel_flag ='Y' ";

        //    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
        //    try
        //    {
        //        DBCommand.ExecuteNonQuery();
        //        DBConnection.Close();
        //        return true;
        //    }
        //    catch (Exception)
        //    {
        //        DBConnection.Close();
        //        return false;
        //    }
        //}

        public Boolean remove_all_allocate_data(string sem_code, string year_code)
        {
            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();

            DBCommand.Transaction = DBConnection.BeginTransaction();

            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "delete from ws_student_course_allocate_dtl where  semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            try
            {

                DBCommand.ExecuteNonQuery();

                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                SqlSelect = "";

                SqlSelect = "update ws_student_wise_course_dtl set status ='R' where cancel_flag ='N' and status ='A' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'";

                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

                DBCommand.ExecuteNonQuery();

                DBCommand.Transaction.Commit();

                DBConnection.Close();
                return true;
            }
            catch (Exception)
            {
                DBCommand.Transaction.Rollback();
                DBConnection.Close();
                return false;
            }
        }

        public Boolean update_published_allocation(string sem_code, string year_code, string user_id, string host_name)
        {
            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();

            // DBCommand.Transaction = DBConnection.BeginTransaction();

            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";


            try
            {

                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                SqlSelect = "";

                SqlSelect = "update ws_publish_allocation_dtl set publish_flag ='Y',last_modified_by = '" + user_id + "' , last_modified_host = '" + host_name + "' , last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' where  semester_type = '" + sem_code + "' and year_semester = '" + year_code + "'";

                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

                DBCommand.ExecuteNonQuery();

                //  DBCommand.Transaction.Commit();

                DBConnection.Close();
                return true;
            }
            catch (Exception)
            {
                //  DBCommand.Transaction.Rollback();
                DBConnection.Close();
                return false;
            }
        }

        public Boolean insert_published_allocation(string sem_code, string year_code, string user_id, string host_name)
        {
            /*************************/
            /* ESTABLISH CONNECTION */
            DBConnection.Open();

            // DBCommand.Transaction = DBConnection.BeginTransaction();

            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";


            try
            {



                DBDataAdpterObject.SelectCommand.Parameters.Clear();
                SqlSelect = "";

                SqlSelect = "Insert into ws_publish_allocation_dtl(semester_type,year_semester,publish_flag,cancel_flag,created_by,created_host,created_date) values('" + sem_code + "','" + year_code + "','Y','N','" + user_id + "','" + host_name + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "')  ";

                DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

                DBCommand.ExecuteNonQuery();

                //  DBCommand.Transaction.Commit();

                DBConnection.Close();
                return true;
            }
            catch (Exception)
            {
                //  DBCommand.Transaction.Rollback();
                DBConnection.Close();
                return false;
            }
        }

        public Boolean Update_current_sem_flag(string dept_code, string user_id, string host_name, string prog_code)
        {
            /*************************/
            /* ESTABLISH CONNECTION */

            /*************************/
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "update student_current_sem_dtl set active_flag ='N' , last_modified_by = '" + user_id + "' , last_modified_host = '" + host_name + "' , last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "' where dept_code = '" + dept_code + "' and prog_code = '" + prog_code + "'";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            try
            {
                DBCommand.ExecuteNonQuery();

                return true;
            }
            catch (Exception)
            {

                return false;
            }
        }

        #endregion

        #region upload_data
        public DataTable year_code_select(string year_desc)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            SqlSelect = "selecT year_code from year_mst where year_desc=@year_desc";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@year_desc";
            para1.DbType = DbType.String;
            para1.Value = year_desc;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);



            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public DataTable department_code_upload(string dept_name)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            SqlSelect = "select dept_code from department_mst where dept_name=@dept_name";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@dept_name";
            para1.DbType = DbType.String;
            para1.Value = @dept_name;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);
            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public DataTable program_code_upload(string prog_name)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            SqlSelect = "select prog_code from programme_mst where prog_name=@prog_name";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
            IDataParameter para1 = DBObjectFactory.GetParameterObject();
            para1.ParameterName = "@prog_name";
            para1.DbType = DbType.String;
            para1.Value = prog_name;
            DBDataAdpterObject.SelectCommand.Parameters.Add(para1);



            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public BLReturnObject excel_data_uplad(DataSet ds_UploadData, string compnyid, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_userupload = (DSC_userdataupload_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                //Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                DSC_userdataupload_WS objuserupload = new DSC_userdataupload_WS();


                objuserupload.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                //for (int mprCnt = 0; mprCnt < obj_PO_Upload.PO_UploadDetails.Rows.Count; mprCnt++)
                for (int mprCnt = 0; mprCnt < server_userupload.user_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();

                    string document = server_userupload.user_mst[mprCnt].doc_no;
                    string strSplitArr = document.Substring(0, 1);
                    objuserupload.user_mst.ImportRow(server_userupload.user_mst.Rows[mprCnt]);

                    if (strSplitArr == "U")
                    {

                    }
                    else
                    {

                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "UD", UserID, HostName, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                            objBLReturnObject.ExecutionStatus = 2;
                            return objBLReturnObject;
                        }

                        objuserupload.user_mst[mprCnt].doc_no = DocNo;
                    }

                }
                for (int mprCnt = 0; mprCnt < server_userupload.area_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "AM", UserID, HostName, ref DocNo, ref message))
                    {

                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        objBLReturnObject.ExecutionStatus = 2;
                        return objBLReturnObject;
                    }
                    objuserupload.area_mst.ImportRow(server_userupload.area_mst.Rows[mprCnt]);
                    // objuserupload.area_mst[mprCnt].doc_no = DocNo;

                }
                for (int mprCnt = 0; mprCnt < server_userupload.course_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "CU", UserID, HostName, ref DocNo, ref message))
                    {

                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        objBLReturnObject.ExecutionStatus = 2;
                        return objBLReturnObject;
                    }
                    objuserupload.course_mst.ImportRow(server_userupload.course_mst.Rows[mprCnt]);
                    objuserupload.course_mst[mprCnt].doc_no = DocNo;

                }
                for (int mprCnt = 0; mprCnt < server_userupload.department_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "DU", UserID, HostName, ref DocNo, ref message))
                    {

                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        objBLReturnObject.ExecutionStatus = 2;
                        return objBLReturnObject;
                    }
                    objuserupload.department_mst.ImportRow(server_userupload.department_mst.Rows[mprCnt]);
                    //   objuserupload.department_mst[mprCnt].doc_no = DocNo;

                }
                for (int mprCnt = 0; mprCnt < server_userupload.instructor_mst.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "IU", UserID, HostName, ref DocNo, ref message))
                    {

                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        objBLReturnObject.ExecutionStatus = 2;
                        return objBLReturnObject;
                    }
                    objuserupload.instructor_mst.ImportRow(server_userupload.instructor_mst.Rows[mprCnt]);
                    objuserupload.instructor_mst[mprCnt].doc_no = DocNo;

                }
                objuserupload.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.user_mst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.user_mst.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }
                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.area_mst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.area_mst.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }

                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, objuserupload.course_mst, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.course_mst.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.department_mst.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != objuserupload.instructor_mst.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {
                objBLReturnObject.ServerMessage = "Problem in save data";
            }
            return objBLReturnObject;
        }


        #endregion

        #region feedback
        public DataTable Get_course_wise_instructor_data_for_feedback(string sem_code, string year_code, string course_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select * from ws_course_wise_instructor inner join instructor_mst on instructor_mst.instructor_code=ws_course_wise_instructor.instructor_code " +
             " where  semester_type='" + sem_code + "' and year_semester = '" + year_code + "'  and instructor_mst.cancel_flag ='N' and ws_course_wise_instructor.cancel_flag ='N' ";


            if (course_code != "")
            {
                SqlSelect = SqlSelect + " and course_code = '" + course_code + "' ";
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_course_data_type_wise(string sem_code, string year_code, string course_type, string course_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "SELECT COUNT(ws_student_course_allocate_dtl.user_id) as total_allocate_user,ws_student_course_allocate_dtl.course_code " +
                        " ,ws_course_mst.course_name,ws_course_mst.dept_code FROM ws_student_course_allocate_dtl " +
                        "  INNER JOIN ws_course_mst  on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code " +
                        "where ws_student_course_allocate_dtl.cancel_flag = 'N' and  ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "'  " +

                        " and  ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' and ws_course_mst.cancel_flag = 'N'  ";

            if (course_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.course_code = '" + course_code + "' ";
            }

            if (course_type != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.course_elegibility in " + course_type + " ";
            }


            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and ws_course_mst.dept_code = '" + dept_code + "'";
            }

            SqlSelect = SqlSelect + " GROUP BY ws_student_course_allocate_dtl.course_code,ws_course_mst.course_name,ws_course_mst.dept_code order by ws_student_course_allocate_dtl.course_code  ";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_total_student_fill_feedback_course_wise(string course_code, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "select COUNT(user_id) as total_user,course_code from " +
                        " (SELECT ws_student_feedback_dtl.user_id,course_code FROM ws_student_feedback_dtl where instructor_code != '' and cancel_flag = 'N' and submit_status = 'Y' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "' GROUP BY ws_student_feedback_dtl.user_id,course_code ) as a ";


            if (course_code != "")
            {
                SqlSelect = SqlSelect + " where course_code = '" + course_code + "' ";
            }

            SqlSelect = SqlSelect + " GROUP BY course_code";




            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_total_student_fill_feedback_instructor_course_wise(string course_code, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "select COUNT(user_id) as total,course_code,instructor_code from " +
                        " (SELECT user_id,course_code,instructor_code FROM ws_student_feedback_dtl where instructor_code != '' and cancel_flag = 'N' and submit_status = 'Y' and semester_type = '" + sem_code + "' and year_semester = '" + year_code + "' " +
                        " group by user_id,course_code,instructor_code) as a ";


            if (course_code != "")
            {
                SqlSelect = SqlSelect + " where course_code = '" + course_code + "' ";
            }

            SqlSelect = SqlSelect + " GROUP BY course_code,instructor_code";




            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_all_feedback_data(string sem_code, string year_code, string course_type, string course_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = " SELECT * FROM ws_student_feedback_dtl where semester_type = '" + sem_code + "' and year_semester ='" + year_code + "' and cancel_flag = 'N' and submit_status = 'Y' ";

            if (course_code != "")
            {
                SqlSelect = SqlSelect + " and course_code = '" + course_code + "' ";
            }

            if (course_type != "")
            {
                SqlSelect = SqlSelect + " and course_type in " + course_type + " ";
            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_Chart_data_for_registration(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT ws_student_course_allocate_dtl.user_id,user_mst.dept_code,ws_course_mst.dept_code as course_dept,ws_student_course_allocate_dtl.course_code FROM ws_student_course_allocate_dtl " +
                     " INNER JOIN user_mst on ws_student_course_allocate_dtl.user_id = user_mst.user_id inner join ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code " +
                     " where ws_student_course_allocate_dtl.cancel_flag = 'N'  and ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "'  and user_mst.dept_code = ws_course_mst.dept_code " +
                       " and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "'  ";


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_Chart_data_for_cross_registration(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " SELECT ws_student_course_allocate_dtl.user_id,user_mst.dept_code,ws_course_mst.dept_code as course_dept,ws_student_course_allocate_dtl.course_code FROM ws_student_course_allocate_dtl " +
                        " INNER JOIN user_mst on ws_student_course_allocate_dtl.user_id = user_mst.user_id inner join ws_course_mst on ws_student_course_allocate_dtl.course_code = ws_course_mst.course_code " +
                        " where ws_student_course_allocate_dtl.cancel_flag = 'N' and ws_student_course_allocate_dtl.semester_type = '" + sem_code + "' and ws_student_course_allocate_dtl.year_semester = '" + year_code + "'  and user_mst.dept_code != ws_course_mst.dept_code " +
                        " and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "'  ";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_feedback_median_data(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT ws_student_feedback_dtl.course_code,sr_no, case when strongly_agree = 'Y' then 5 when agree = 'Y' then 4 when neither_agree ='Y' then 3 WHEN disagree = 'Y' then 2 when strongly_disagree = 'Y' then 1 " +
                        "when not_applicable = 'Y' then 3 end  as number,instructor_code ,ws_student_feedback_dtl.course_type,ws_course_mst.dept_code,  releted_feedback    FROM ws_student_feedback_dtl INNER JOIN ws_course_mst on ws_student_feedback_dtl.course_code = ws_course_mst.course_code " +
             "where ws_student_feedback_dtl.cancel_flag = 'N' and  ws_student_feedback_dtl.submit_status = 'Y' and ws_student_feedback_dtl.semester_type = '" + sem_code + "' and ws_student_feedback_dtl.year_semester = '" + year_code + "' and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "'  order by sr_no,number ";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_all_text_from_feedback(string sem_code, string year_code, string course_type, string course_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "SELECT user_id,course_type,course_aspect,course_suggestion,comments,ws_student_feedback_dtl.course_code,releted_feedback,instructor_code FROM  " +
                        "ws_student_feedback_dtl   where semester_type = '" + sem_code + "' and year_semester ='" + year_code + "' and cancel_flag = 'N' and submit_status = 'Y' ";

            if (course_code != "")
            {
                SqlSelect = SqlSelect + " and course_code = '" + course_code + "' ";
            }

            if (course_type != "")
            {
                SqlSelect = SqlSelect + " and course_type in " + course_type + " ";
            }


            SqlSelect = SqlSelect + "GROUP BY user_id,course_aspect,course_suggestion,comments,ws_student_feedback_dtl.course_code,course_type,ws_student_feedback_dtl.releted_feedback,ws_student_feedback_dtl.instructor_code ";







            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Get_feedback_instruction_mst_data_report(string course_typology, string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";



            SqlSelect = "select * from ws_feedback_instructions_mst_for_chart " +
                        " where cancel_flag = 'N'  and ws_feedback_instructions_mst_for_chart.semester_type = '" + sem_code + "' and ws_feedback_instructions_mst_for_chart.year_semester = '" + year_code + "' ";


            if (course_typology != "")
            {
                SqlSelect = SqlSelect + "and ws_feedback_instructions_mst_for_chart.course_typology in " + course_typology + "";
            }
            SqlSelect = SqlSelect + " order by feedback_type,sr_no ";




            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                {
                    return ds.Tables[0];
                }

            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public BLReturnObject save_feedback_calculation_data(DataSet ds_UploadData, String UserID, String HostName)
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            try
            {

                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = "Insufficient Arguments, Operation Canceled.";

                if (ds_UploadData == null)
                {
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "There is no data to save";
                    return objBLReturnObject;
                }

                server_feedback_calculation = (DS_Feedback_calculation_WS)ds_UploadData;

                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                //To generate next doc number
                Document Doc = new Document();
                String message = "";
                String DocNo = "";
                String DocNo1 = "";
                //Ds_Workflow obj_workflow = new Ds_Workflow();
                DS_Feedback_calculation_WS obj_feedback = new DS_Feedback_calculation_WS();

                obj_feedback.EnforceConstraints = false;
                //objDocument.W_GetNextDocumentNo(ref DBCommand, compnyid, "VD", sessionInfo.GetUserID(), sessionInfo.GetHostID(), ref DocNo, ref message);


                for (int mprCnt = 0; mprCnt < server_feedback_calculation.ws_feedback_calculation.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    //string document = server_feedback.student_feedback_dtl[mprCnt].doc_no;
                    //string strSplitArr = document.Substring(0, 1);
                    obj_feedback.ws_feedback_calculation.ImportRow(server_feedback_calculation.ws_feedback_calculation.Rows[mprCnt]);
                    //if (strSplitArr == "F")
                    //{
                    //}
                    //else
                    //{
                    //    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "FB", UserID, HostName, ref DocNo, ref message))
                    //    {

                    //        DBCommand.Transaction.Rollback();
                    //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    //        objBLReturnObject.ExecutionStatus = 2;
                    //        return objBLReturnObject;
                    //    }

                    //    obj_feedback.student_feedback_dtl[mprCnt].doc_no = DocNo;
                    //}






                    //objorder.PO_UploadDetails[mprCnt].created_by = UserID;
                    //objorder.PO_UploadDetails[mprCnt].created_host = HostName;
                    //objorder.PO_UploadDetails[mprCnt].created_date = DateTime.Now;

                }

                for (int mprCnt = 0; mprCnt < server_feedback_calculation.ws_feedback_calculation_average2.Rows.Count; mprCnt++)
                {
                    objDocument = new Document();
                    //string document = server_feedback.student_feedback_dtl[mprCnt].doc_no;
                    //string strSplitArr = document.Substring(0, 1);
                    obj_feedback.ws_feedback_calculation_average2.ImportRow(server_feedback_calculation.ws_feedback_calculation_average2.Rows[mprCnt]);
                    //if (strSplitArr == "F")
                    //{
                    //}
                    //else
                    //{
                    //    if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "FB", UserID, HostName, ref DocNo, ref message))
                    //    {

                    //        DBCommand.Transaction.Rollback();
                    //        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    //        objBLReturnObject.ExecutionStatus = 2;
                    //        return objBLReturnObject;
                    //    }

                    //    obj_feedback.student_feedback_dtl[mprCnt].doc_no = DocNo;
                    //}






                    //objorder.PO_UploadDetails[mprCnt].created_by = UserID;
                    //objorder.PO_UploadDetails[mprCnt].created_host = HostName;
                    //objorder.PO_UploadDetails[mprCnt].created_date = DateTime.Now;

                }



                obj_feedback.EnforceConstraints = true;
                BLGeneralUtil.UpdateTableInfo objUpdateTableInfo;



                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_feedback.ws_feedback_calculation, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_feedback.ws_feedback_calculation.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
                    return objBLReturnObject;
                }


                objUpdateTableInfo = BLGeneralUtil.UpdateTable(ref DBCommand, obj_feedback.ws_feedback_calculation_average2, BLGeneralUtil.UpdateWhereMode.KeyColumnsOnly, BLGeneralUtil.UpdateMethod.DeleteAndInsert);
                if (objUpdateTableInfo.Status == true && objUpdateTableInfo.TotalRowsAffected != obj_feedback.ws_feedback_calculation_average2.Rows.Count)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    objBLReturnObject.ExecutionStatus = 2;
                    objBLReturnObject.ServerMessage = "Fail to Save Details.";
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

            catch (Exception ex)
            {
                if (DBCommand.Transaction != null)
                    DBCommand.Transaction.Rollback();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                objBLReturnObject.ExecutionStatus = 2;
                objBLReturnObject.ServerMessage = ex.Message;

            }

            return objBLReturnObject;
        }
        #endregion

        #region priority report

        public DataTable get_priority_registration_report_course_wise(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //SqlSelect = "select course,course_row_no,[1] as P1,[2] as P2,[3] as P3,[4] as P4, [5] as P5,[p1_name], [p2_name], [p3_name], [p4_name],[p5_name] from (select ROW_NUMBER() OVER(ORDER BY priority ) as course_row_no, ws_student_wise_course_dtl.user_id , user_mst.user_name ,ws_student_wise_course_dtl.course_code +'-'+ course_name as course,priority,[P_name] = case priority when  '1' then 'p1_name' when '2' then 'p2_name' when '3' then 'p3_name'  when '4' then 'p4_name'  when '5' then 'p5_name' end  from ws_student_wise_course_dtl " +
            //            " inner join user_mst on ws_student_wise_course_dtl.user_id = user_mst.user_id  inner join ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
            //            " where ws_student_wise_course_dtl.semester_type ='" + sem_code + "' and ws_student_wise_course_dtl.year_semester ='" + year_code + "' and ws_student_wise_course_dtl.status  in ('R','A') and user_status_flag ='A' and " +
            //            " ws_student_wise_course_dtl.cancel_flag ='N' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester ='" + year_code + "'  " +
            //            " ) as a " +
            //            " pivot " +
            //            " ( min( user_id) " +
            //            " for priority in ([1], [2], [3], [4],[5]) " +
            //            ") AS PVTTable " +
            //            " pivot  ( min( user_name)  for [P_name] in ([p1_name], [p2_name], [p3_name], [p4_name],[p5_name])  " +
            //            " ) AS PVTTable1 " +
            //            " order by course ";

            SqlSelect = "select ws_student_wise_course_dtl.user_id , user_mst.user_name,ws_student_wise_course_dtl.course_code,priority from ws_student_wise_course_dtl " +
                        " inner join user_mst on ws_student_wise_course_dtl.user_id = user_mst.user_id " +
                        " inner join ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
                        " where ws_student_wise_course_dtl.semester_type ='" + sem_code + "' and ws_student_wise_course_dtl.year_semester ='" + year_code + "' and ws_student_wise_course_dtl.status in ('R','A') and user_status_flag ='A' and " +
                        " ws_student_wise_course_dtl.cancel_flag ='N' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester ='" + year_code + "' " +

                        " order by ws_student_wise_course_dtl.course_code,priority ";


            return Get_data(SqlSelect);

        }

        public DataTable get_total_first_priority_registration_report_course_wise(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select a.course_code,a.course,MAX(a.total_priority) as total from " +
                        " (select  ws_student_wise_course_dtl.course_code,priority,COUNT(priority) as total_priority,ws_student_wise_course_dtl.course_code +'-' + ws_course_mst.course_name as course from ws_student_wise_course_dtl " +
                        " inner JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code  " +
                        " where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status in  ('R','A') " +
                        " and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "'  " +
                        " and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "'  " +
            " GROUP BY ws_student_wise_course_dtl.course_code,priority,ws_student_wise_course_dtl.course_code +'-' + ws_course_mst.course_name " +
            " ) as a " +
            " group by a.course_code,a.course " +
            " order by a.course_code ";


            return Get_data(SqlSelect);

        }

        public DataTable get_registered_priority_course_wise(string sem_code, string year_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select distinct ws_student_wise_course_dtl.course_code,priority from ws_student_wise_course_dtl " +
                        " inner JOIN ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code   " +
                        " where  ws_student_wise_course_dtl.cancel_flag ='N' and ws_student_wise_course_dtl.status in ('R','A') " +
                        " and ws_student_wise_course_dtl.semester_type = '" + sem_code + "' and ws_student_wise_course_dtl.year_semester = '" + year_code + "' " +
                        " and ws_course_mst.semester_type = '" + sem_code + "' and ws_course_mst.year_semester = '" + year_code + "' ";


            return Get_data(SqlSelect);

        }

        public DataTable get_priority_registration_report_student_wise(string sem_code, string year_code, string dept_code)
        {

            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "select user_id,user_name,[1] as P1,[2] as P2,[3] as P3,[4] as P4, [5] as P5 from (select ws_student_wise_course_dtl.user_id,user_mst.user_name,ws_student_wise_course_dtl.course_code +'-'+ course_name as course,priority from ws_student_wise_course_dtl " +
                        " inner join user_mst on ws_student_wise_course_dtl.user_id = user_mst.user_id  inner join ws_course_mst on ws_student_wise_course_dtl.course_code = ws_course_mst.course_code " +
                        " where ws_student_wise_course_dtl.semester_type ='" + sem_code + "' and ws_student_wise_course_dtl.year_semester ='" + year_code + "' and ws_student_wise_course_dtl.status  in ('R','A') and user_status_flag ='A' and " +
                        " ws_student_wise_course_dtl.cancel_flag ='N' and ws_course_mst.semester_type ='" + sem_code + "' and ws_course_mst.year_semester ='" + year_code + "'  ";

            if (dept_code != "")
            {
                SqlSelect = SqlSelect + " and user_mst.dept_code ='" + dept_code + "' ";
            }
            SqlSelect = SqlSelect + " ) as a " +
                   " pivot " +
                   " ( min(course) " +
                   " for priority in ([1], [2], [3], [4],[5]) " +
                   ") AS PVTTable order by user_id ";



            return Get_data(SqlSelect);

        }

        #endregion

        #region Common method

        public DataTable get_bank_branch_dtl()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = " select * from bank_branch_mst where cancel_flag ='N' order by state";

            return Get_data(SqlSelect);
        }

        public DataTable Get_data(String SqlSelect)
        {
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
            catch (Exception ex)
            {
                return null;
            }
        }

        public string GetJson1(DataTable dt)
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            List<Dictionary<string, string>> dataRows = new List<Dictionary<string, string>>(); // will contain datarows as dictionary objects

            //Convert DataTable to List<Dictionary<string, string>> data structure
            foreach (DataRow VDataRow in dt.Rows)
            {
                var Row = new Dictionary<string, string>(); // DataRow as key-value pairs where key=columnName and value=fieldValue 
                foreach (DataColumn Column in dt.Columns)
                {





                    Row.Add(Column.ColumnName, VDataRow[Column].ToString());

                }
                dataRows.Add(Row);
            }
            return ser.Serialize(dataRows); // convert list to JSON string 

        }

        public DataTable Get_data_from_SP(String sp_name)
        {
            DBDataAdpterObject.SelectCommand.CommandText = sp_name;
            DBDataAdpterObject.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        #endregion

        public bool DeleteData(ref IDbCommand command, string TableName, Dictionary<string, object> WhereCriteria, ref string message)
        {
            StringBuilder sql = new StringBuilder();

            if (!(WhereCriteria.Keys.Count > 0)) { message = "please provide where criteria."; return false; }

            sql.Append("DELETE FROM " + TableName + " WHERE ");

            int i = 0;
            foreach (string key in WhereCriteria.Keys)
            {
                sql.Append("" + key + "='" + WhereCriteria[key].ToString() + "'");
                if (i < WhereCriteria.Keys.Count - 1)
                {
                    sql.Append(" AND ");
                }
                i++;
            }

            command.CommandText = sql.ToString();

            if (command.ExecuteNonQuery() >= 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        #endregion

        #region SWS Entry
        public bool sws_course_manually_allocation_dtl(DataSet ds_UploadData, String UserID, String current_sem_code, String HostName)
        {

            string host_name = HostName;
            Document Doc = new Document();
            String message = "";
            String DocNo = "";
            DataTable dt_course_dtl = ds_UploadData.Tables["ws_student_course_allocate_dtl"];
            try
            {
                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                String SqlSelect = "";

                try
                {
                    DBDataAdpterObject.SelectCommand.Parameters.Clear();
                    SqlSelect = "";

                    for (int i = 0; i < dt_course_dtl.Rows.Count; i++)
                    {
                        if (!objDocument.W_GetNextDocumentNo(ref DBCommand, "", "SAW", UserID, host_name, ref DocNo, ref message))
                        {

                            DBCommand.Transaction.Rollback();
                            if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        }

                        SqlSelect += @" Insert into ws_student_wise_course_dtl ( doc_no, user_id, year_code, course_code, course_type, credits, gpa_nongpa, priority, dept_code, status, semester_type, year_semester,cancel_flag,
                                            created_by, created_date, created_host)";

                        SqlSelect += " VALUES('" + DocNo + "','" + dt_course_dtl.Rows[i]["user_id"].ToString() + "','" + dt_course_dtl.Rows[i]["year_code"].ToString() + "','" + dt_course_dtl.Rows[i]["course_code"].ToString() + "','" + dt_course_dtl.Rows[i]["course_type"].ToString() + "'," +
                            " '" + dt_course_dtl.Rows[i]["credits"].ToString() + "','" + dt_course_dtl.Rows[i]["gpa_nongpa"].ToString() + "','" + dt_course_dtl.Rows[i]["priority"].ToString() + "','" + dt_course_dtl.Rows[i]["dept_code"].ToString() + "'," +
                            " 'R','" + dt_course_dtl.Rows[i]["semester_type"].ToString() + "','" + dt_course_dtl.Rows[i]["year_semester"].ToString() + "','N'," +
                            " '" + UserID + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "','" + host_name + "')";


                        SqlSelect += " insert into ws_connect_student_reg_dtl (doc_no,user_id,course_code,course_type,credits," +
                               " priority,status,semester_type,year_semester,cancel_flag,created_by,created_date,created_host,manually_course_status) " +
                               " VALUES('" + DocNo + "','" + dt_course_dtl.Rows[i]["user_id"].ToString() + "','" + dt_course_dtl.Rows[i]["course_code"].ToString() + "','" + dt_course_dtl.Rows[i]["course_type"].ToString() + "'," +
                               " '" + dt_course_dtl.Rows[i]["credits"].ToString() + "','" + dt_course_dtl.Rows[i]["priority"].ToString() + "','M','" + dt_course_dtl.Rows[i]["semester_type"].ToString() + "','" + dt_course_dtl.Rows[i]["year_semester"].ToString() + "','N'," +
                               " '" + UserID + "','" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss.ffffff") + "','" + host_name + "','M')";


                    }
                    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                    ServerLog.ExceptionLog("Sws Table ws_student_course_allocate_dtl ExecuteNonQuery Result  : " + SqlSelect);
                    int res_insert_combination = DBCommand.ExecuteNonQuery();

                    if (res_insert_combination <= 0)
                    {
                        DBCommand.Transaction.Rollback();
                        if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                        return false;
                    }

                }
                catch (Exception ex)
                {
                    ServerLog.ExceptionLog("Sws Query Wise EX  : " + ex.Message);
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return false;
                }



                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return true;
            }
            catch (Exception ex)
            {
                DBCommand.Transaction.Rollback();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return false;
            }
            return true;
        }


        public bool sws_deallocate_course(string course_code, string student_code, string sem_code, string year_code,string user_id, string user_type, string host_name)
        {

            
            try
            {
                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                String SqlSelect = "";

                try
                {
                    SqlSelect = " update ws_connect_student_reg_dtl set cancel_flag='Y',last_modified_by='" + user_id + "',last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "'," +
                        " last_modified_host = '" + host_name + "' where user_id='" + student_code + "' and semester_type='" + sem_code + "' " +
                        " and year_semester='" + year_code + "' and cancel_flag='N' and status in ('M','A') and (course_drop_status is NULL or course_drop_status ='N')" +
                        " and course_code='" + course_code + "'";


                    SqlSelect += " update ws_student_course_allocate_dtl set cancel_flag='Y',last_modified_by='" + user_id + "',last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "'," +
                        " last_modified_host = '" + host_name + "' where user_id='" + student_code + "' and semester_type='" + sem_code + "' " +
                        " and year_semester='" + year_code + "' and cancel_flag='N'" +
                        " and course_code='" + course_code + "'";

                    SqlSelect += " update ws_student_wise_course_dtl set cancel_flag='Y',last_modified_by='" + user_id + "',last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "'," +
                        " last_modified_host = '" + host_name + "' where user_id='" + student_code + "' and semester_type='" + sem_code + "' " +
                        " and year_semester='" + year_code + "' and cancel_flag='N'" +
                        " and course_code='" + course_code + "'";

                    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                    int res_insert = DBCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return false;
                }

                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return true;
            }
            catch (Exception ex)
            {
                DBCommand.Transaction.Rollback();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return false;
            }
            return true;
        }

        public bool sws_update_student_course_type(string course_code, string student_code, string sem_code, string year_code, string user_id, string user_type, string host_name, string course_type)
        {


            try
            {
                DBConnection.Open();
                DBCommand.Transaction = DBConnection.BeginTransaction();

                String SqlSelect = "";

                try
                {
                    SqlSelect += " update ws_student_course_allocate_dtl set course_type='"+ course_type + "',last_modified_by='" + user_id + "',last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "'," +
                        " last_modified_host = '" + host_name + "' where user_id='" + student_code + "' and semester_type='" + sem_code + "' " +
                        " and year_semester='" + year_code + "' and cancel_flag='N'" +
                        " and course_code='" + course_code + "'";

                    SqlSelect += " update ws_student_wise_course_dtl set course_type='"+ course_type + "',last_modified_by='" + user_id + "',last_modified_date = '" + DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss") + "'," +
                        " last_modified_host = '" + host_name + "' where user_id='" + student_code + "' and semester_type='" + sem_code + "' " +
                        " and year_semester='" + year_code + "' and cancel_flag='N'" +
                        " and course_code='" + course_code + "'";

                    DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;
                    int res_insert = DBCommand.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    DBCommand.Transaction.Rollback();
                    if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                    return false;
                }

                DBCommand.Transaction.Commit();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return true;
            }
            catch (Exception ex)
            {
                DBCommand.Transaction.Rollback();
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
                return false;
            }
            return true;
        }
        #endregion



    }
}
