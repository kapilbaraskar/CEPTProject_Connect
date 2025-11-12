using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLL.Utilities
{
   public static class SWSCalculateCredit
    {
        public static int AllocatedCredit { get; set; }
        public static int PaymentCredit { get; set; }
        public static int RequiredToPay { get; set; }
        public static int DropCredit { get; set; }
        public static int TotalApplyCredit { get; set; }
        public static int ProvisionallyAllocatedCredits { get; set; }
        public static int TotalRemainingCredits { get; set; }
        public static int WaiverCredit { get; set; }
        public static string DropCourseCredit { get; set; }
        public static string AllocatedStatus { get; set; }
        public static string UserId { get; set; }
        public static string SemesterType { get; set; }
        public static string YearCode { get; set; }
        public static int Srno { get; set; }
        public static int PaidFeesCredit { get; set; }
        public static int RemaningWaiverCredit { get; set; }
        public static int RegisteredCredits { get; set; }

        public static int calculateCredit { get; set; }
        public static int PaidFeesWithWaiverCredit { get; set; }
    }
}
