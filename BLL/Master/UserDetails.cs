using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL.Master
{
   public static class UserDetails
    {
        public static string user_name  { get; set; }
        public static string user_id { get; set; }
        public static string user_mail { get; set; }
        public static string semester { get; set; }
        public static string yearcode { get; set; }
        public static string studiocode { get; set; }

    }
    public class CourseRegist
    {
        public string course_code;
        public string priority;
        public string course_credits;
        public string course_type;
        public string status;
        public string credit_combination;
    }
}
