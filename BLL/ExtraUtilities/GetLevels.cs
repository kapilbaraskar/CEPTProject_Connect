using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Configuration;
using BLL.Utilities;

namespace BLL.ExtraUtility
{
    /// <summary>
    /// Get Levels of particular employee or all levells defined.
    /// </summary>
    public class GetLevels : ServerBase
    {
        #region VARIABLE DECLARATION
        String sa_id = null;
        String[] ObjectProfile;
        String[] GeneralArgs;
        String[] OpArgs;
        #endregion

        #region Constructor & Destructor.
        public GetLevels()
        {
            ObjectProfile = new String[3];
            ObjectProfile[0] = "T";//transaction
            ObjectProfile[1] = "G";//Employee Level Details

            GeneralArgs = new String[2];
            GeneralArgs[0] = null;
            GeneralArgs[1] = "501";

            OpArgs = new string[1];
        }
        ~GetLevels()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }
        #endregion

        /// <summary>
        /// Used to get Levels and cs_id of praticular Employee
        /// </summary>
        /// <param name="SessionId"></param>
        /// <param name="EmployeeCode"></param>
        /// <returns>String Array of Employee Levels and cs_id</returns>
        public String[] GetEmployeeLevels(String SessionId, String EmployeeCode)
        {
            String[] Levels = new string[6];
            BLReturnObject objBLReturnObject = null;
            GeneralArgs[0] = SessionId;
            ObjectProfile[2] = "W100N";

            OpArgs = new String[2];
            OpArgs[0] = "L"; //LEVELS.
            OpArgs[1] = EmployeeCode;

            //IServer objIServer = (IServer)RemotingHelper.CreateProxy(typeof(IServer));
            //objBLReturnObject = objIServer.Retrieve(ObjectProfile, OpArgs, GeneralArgs, null);
            //if (objBLReturnObject.ExecutionStatus == 1)
            //{
            //    Levels[0] = objBLReturnObject.dt_ReturnedTables[0].Rows[0]["cs_id"].ToString();
            //    Levels[1] = objBLReturnObject.dt_ReturnedTables[0].Rows[0]["cs_level1"].ToString();
            //    Levels[2] = objBLReturnObject.dt_ReturnedTables[0].Rows[0]["cs_level2"].ToString();
            //    Levels[3] = objBLReturnObject.dt_ReturnedTables[0].Rows[0]["cs_level3"].ToString();
            //    Levels[4] = objBLReturnObject.dt_ReturnedTables[0].Rows[0]["cs_level4"].ToString();
            //    Levels[5] = objBLReturnObject.dt_ReturnedTables[0].Rows[0]["cs_level5"].ToString();
            //}
            return Levels;
        }

        #region RetrieveMethod
        public BLReturnObject Retrieve()
        {
            BLReturnObject objBLReturnObject = new BLReturnObject();
            objBLReturnObject.ServerMessage = "";
            sa_id = GeneralArgs[1];

            /*************************/
            DBConnection.Open();
            /*************************/
            switch (ObjectProfile[2])
            {
                //case Constant.TEMP: //T
                //    return objBLReturnObject;
                default:
                    return objBLReturnObject;
               
            }
        }
        #endregion
    }
}
