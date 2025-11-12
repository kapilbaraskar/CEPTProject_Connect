using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL.Master
{
    public class AWPDataSave
    {
        public string parentId { get; set; }
        public string description { get; set; }
        public string tutor { get; set; }
        public string totalHours { get; set; }
        public string sr_no { get; set; }
        public string status_flag { get; set; }
        public List<double> hours { get; set; }
        public List<string> remark { get; set; }
    }

    public class TotalHourse
    {
        public string awp_type_code { get; set; }
        public List<double> hours_Data { get; set; }
    }
}
