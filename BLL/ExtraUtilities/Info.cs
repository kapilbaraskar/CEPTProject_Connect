using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BLL.Utilities;

namespace BLL.ExtraUtility
{
    public class Info : ServerBase
    {
        String[] ObjectProfile;
        String[] GeneralArgs;
        String[] OpArgs;

        #region Constructor & Destructor.
        public Info()
        {
            ObjectProfile = new String[3];
            ObjectProfile[0] = "T";//transaction
            ObjectProfile[1] = "G";//Employee General Detail

            GeneralArgs = new String[2];
            GeneralArgs[0] = null;
            GeneralArgs[1] = "501";

            OpArgs = new string[3];
        }
        ~Info()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }
        #endregion

        public BLReturnObject GetUserMstInfo(String SessionId, String user_id)
        {
            BLReturnObject objBLReturnObject = null;
            
            //IServer objIServer = (IServer)RemotingHelper.CreateProxy(typeof(IServer));
            //objBLReturnObject = objIServer.Retrieve(ObjectProfile, OpArgs, GeneralArgs, null);
            return objBLReturnObject;
        }

        public BLReturnObject GetEmployeeCSLevel(String SessionId, String employee_code)
        {
            BLReturnObject objBLReturnObject = null;
            ObjectProfile[0] = "T";//transaction
            ObjectProfile[1] = "G";//Employee General Detail
            ObjectProfile[2] = "W100N";

            GeneralArgs[0] = SessionId;

            OpArgs[0] = "L"; //Levels
            OpArgs[1] = employee_code;

            //IServer objIServer = (IServer)RemotingHelper.CreateProxy(typeof(IServer));
            //objBLReturnObject = objIServer.Retrieve(ObjectProfile, OpArgs, GeneralArgs, null);
            return objBLReturnObject;
        }
    }
}
