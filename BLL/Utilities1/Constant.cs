
namespace BLL.Utilities1
{
    public class Constant
    {
        #region <-- Active/Deactive -->
        public const string STATUS_ACTIVE = "A";
        public const string STATUS_DEACTIVE = "D";
        #endregion

        #region <-- Yes/No -->
        public const string YES = "Y";
        public const string NO = "N";
        #endregion

        #region <-- Document Number Type -->
        public const string CANDIDATE_MST = "CM";
        public const string PROGRAM_COURSE_MST = "PCM";
        public const string PROGRAM_FACULTY_TYPE_MST = "PFTM";
        public const string PROGRAM_TYPE_MST = "PTM";
        public const string TRANSACTION_DOC_TYPE = "PT";
        public const string TRANSACTION_DOC_TYPE_CASH = "CPTRAN";
        public const string ADMIN_ACTIVITY_LOG = "ALOG";
        #endregion

        #region <-- User Type -->
        public const string USER_TYPE_CANDIDATE = "C";
        public const string USER_TYPE_ADMIN = "A";
        public const string USER_TYPE_SUPERADMIN = "S";
        #endregion

        public const string PAYMENT_MODE_CASH = "C";
        public const string PAYMENT_MODE_ONLINE = "O";
    }
}