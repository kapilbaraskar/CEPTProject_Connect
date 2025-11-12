using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL.Master
{
   public static class RateBand
    {
        public static Dictionary<string, string> AdditionalHours = new Dictionary<string, string>();
        public static string cancel_flag_status { get; set; }

        public static Dictionary<string, string> ta_contact_hrs = new Dictionary<string, string>();
        public static Dictionary<string, string> ta_weeks = new Dictionary<string, string>();
        public static Dictionary<string, string> ta_total_hrs = new Dictionary<string, string>();
        public static Dictionary<string, string> ta_additiona_hrs = new Dictionary<string, string>();
        public static Dictionary<string, string> user_type_ta_aa = new Dictionary<string, string>();


        public static Dictionary<string, string> aa_contact_hrs = new Dictionary<string, string>();
        public static Dictionary<string, string> aa_weeks = new Dictionary<string, string>();
        public static Dictionary<string, string> aa_total_hrs = new Dictionary<string, string>();
        public static Dictionary<string, string> aa_additiona_hrs = new Dictionary<string, string>();


    }

}
