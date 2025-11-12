using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Newtonsoft.Json;

namespace BLL.PersonalDetails
{
    public class Constants
    {
        /// <summary>
        /// SQL parameter names used in queries
        /// </summary>
        public static class Parameters
        {
            public const string CANCEL_FLAG = "N";
            public const string DATE_PARAMETER = "@Date";
            public const string DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
            public const string PersonalDtlSem = "@PersonalDtlSem";
            public const string PersonalDtlyear = "@PersonalDtlyear";
            
        }

        /// <summary>
        /// DateTime constants for database queries
        /// </summary>
        public static class DateTimeConstants
        {
            public const string DATETIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
            public const string DATETIME_FORMAT_WITH_MILLISECONDS = "yyyy-MM-dd HH:mm:ss.fff";
            public const string CURRENT_DATETIME = "GETDATE()";
            public const string CURRENT_UTC_DATETIME = "GETUTCDATE()";
            public const string DATETIME_PARAMETER = "@DateTime";
            public const string START_DATETIME_PARAMETER = "@StartDateTime";
            public const string END_DATETIME_PARAMETER = "@EndDateTime";
        }

       
        public static class JsonResponse
        {
            public static string CreateResponse(bool success, string message, string error = null, object data = null)
            {
                var response = new
                {
                    success = success,
                    message = message,
                    error = error,
                    data = data
                };

                return JsonConvert.SerializeObject(response);
            }
            public static string CreateSuccessResponse(string message, object data = null)
            {
                return CreateResponse(true, message, null, data);
            }
            public static string CreateErrorResponse(string message, string error = null)
            {
                return CreateResponse(false, message, error, null);
            }
        }
    }
}
