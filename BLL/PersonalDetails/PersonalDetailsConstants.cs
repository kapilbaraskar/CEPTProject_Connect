using System;

namespace BLL.PersonalDetails
{
    /// <summary>
    /// Constants class for PersonalDetails operations
    /// Contains database field names, SQL queries, error messages, and UI constants
    /// </summary>
    public static class PersonalDetailsConstants
    {
        #region Database Constants

        /// <summary>
        /// Database table names
        /// </summary>
        public static class Tables
        {
            public const string PERSONAL_DETAILS = "PersonalDetails";
            public const string MENU_MST = "MenuMst";
            public const string GROUP_RIGHTS = "group_rights";
            public const string USER_GROUP = "user_group";
        }

        /// <summary>
        /// PersonalDetails table column names
        /// </summary>
        public static class PersonalDetailsColumns
        {
            public const string PERSONAL_ID = "PersonalId";
            public const string FIRST_NAME = "FirstName";
            public const string LAST_NAME = "LastName";
            public const string EMAIL = "Email";
            public const string PHONE = "Phone";
            public const string ADDRESS = "Address";
            public const string CITY = "City";
            public const string IS_ACTIVE = "IsActive";
            public const string CREATED_DATE = "CreatedDate";
            public const string LAST_MODIFIED = "LastModified";
        }

        /// <summary>
        /// MenuMst table column names
        /// </summary>
        public static class MenuColumns
        {
            public const string MENU_ID = "menu_id";
            public const string MENU_DESCRIPTION = "menu_description";
            public const string WINDOW_NAME = "window_name";
            public const string PAGE_NAME = "page_name";
            public const string PARENT_MENU_ID = "parent_menu_id";
            public const string MENU_ORDER = "menu_order";
        }

        /// <summary>
        /// Group rights table column names
        /// </summary>
        public static class GroupRightsColumns
        {
            public const string GROUP_ID = "group_id";
            public const string MENU_ID = "menu_id";
        }

        /// <summary>
        /// User group table column names
        /// </summary>
        public static class UserGroupColumns
        {
            public const string USER_ID = "user_id";
            public const string USER_TYPE = "user_type";
            public const string GROUP_ID = "group_id";
        }

        /// <summary>
        /// Field sizes for database columns
        /// </summary>
        public static class FieldSizes
        {
            public const int FIRST_NAME_MAX = 50;
            public const int LAST_NAME_MAX = 50;
            public const int EMAIL_MAX = 100;
            public const int PHONE_MAX = 20;
            public const int ADDRESS_MAX = 200;
            public const int CITY_MAX = 50;
            public const int USER_ID_MAX = 50;
            public const int USER_TYPE_MAX = 50;
            public const int GROUP_ID_MAX = 50;
            public const int MENU_ID_MAX = 50;
            public const int PAGE_NAME_MAX = 100;
        }

        #endregion

        #region SQL Query Constants

        /// <summary>
        /// Common SQL queries for PersonalDetails operations
        /// </summary>
        public static class Queries
        {
            // PersonalDetails queries
            public const string SELECT_PERSONAL_DETAILS_BY_ID = 
                "SELECT * FROM PersonalDetails WHERE PersonalId = @PersonalId";

            public const string SELECT_PERSONAL_DETAILS_WITH_TYPES = 
                @"SELECT * FROM PersonalDetails 
                  WHERE PersonalId = @PersonalId 
                  AND IsActive = @IsActive";

            public const string SELECT_PERSONAL_DETAILS_BY_DATE_RANGE = 
                @"SELECT * FROM PersonalDetails 
                  WHERE CreatedDate >= @StartDate 
                  AND CreatedDate <= @EndDate";

            public const string SELECT_PERSONAL_DETAILS_COUNT = 
                "SELECT COUNT(*) FROM PersonalDetails";

            public const string INSERT_PERSONAL_DETAIL = 
                @"INSERT INTO PersonalDetails (FirstName, LastName, Email, Phone, Address, City, IsActive, CreatedDate) 
                  VALUES (@FirstName, @LastName, @Email, @Phone, @Address, @City, @IsActive, GETDATE())";

            public const string INSERT_PERSONAL_DETAIL_WITH_ID = 
                @"INSERT INTO PersonalDetails (FirstName, LastName, Email, Phone, Address, City, IsActive, CreatedDate) 
                  VALUES (@FirstName, @LastName, @Email, @Phone, @Address, @City, @IsActive, GETDATE());
                  SELECT SCOPE_IDENTITY();";

            public const string UPDATE_PERSONAL_DETAIL = 
                @"UPDATE PersonalDetails 
                  SET FirstName = @FirstName, 
                      LastName = @LastName, 
                      Email = @Email, 
                      Phone = @Phone, 
                      Address = @Address, 
                      City = @City, 
                      IsActive = @IsActive,
                      LastModified = GETDATE()
                  WHERE PersonalId = @PersonalId";

            // Menu queries
            public const string SELECT_MENU_DETAILS_FOR_USER = 
                @"Select MenuMst.menu_id,MenuMst.menu_description,MenuMst.window_name,MenuMst.page_name  
                  From group_rights inner join MenuMst on MenuMst.menu_id = group_rights.menu_id
                  where group_id IN(select group_id from user_group where user_id = @userid and user_type =@userType and group_id ='Profile')  
                  and parent_menu_id NOT IN ('Root') 
                  ORDER BY menu_order Asc";

            public const string SELECT_MENU_SEQUENCE = 
                @";WITH TargetMenu AS (
                    SELECT TOP 1 m.menu_order
                    FROM group_rights gr
                    INNER JOIN MenuMst m ON m.menu_id = gr.menu_id
                    WHERE gr.group_id IN (
                            SELECT group_id
                            FROM user_group
                            WHERE user_id = @userid
                              AND user_type = @userType
                              AND group_id = 'Profile'
                          )
                      AND m.parent_menu_id <> 'Root'
                      AND m.page_name = @currentPage
                    ORDER BY m.menu_order
                )
                SELECT m.menu_id,
                       m.menu_description,
                       m.window_name,
                       m.page_name,
                       m.menu_order,
                       CASE 
                         WHEN m.menu_order = t.menu_order - 1 THEN 'Previous'
                         WHEN m.menu_order = t.menu_order     THEN 'Current'
                         WHEN m.menu_order = t.menu_order + 1 THEN 'Next'
                       END AS PositionStatus
                FROM group_rights gr
                INNER JOIN MenuMst m ON m.menu_id = gr.menu_id
                CROSS JOIN TargetMenu t
                WHERE gr.group_id IN (
                        SELECT group_id
                        FROM user_group
                        WHERE user_id = @userid
                          AND user_type = @userType
                          AND group_id = 'Profile'
                      )
                  AND m.parent_menu_id <> 'Root'
                  AND (
                        m.menu_order = t.menu_order       
                        OR m.menu_order = t.menu_order - 1 
                        OR m.menu_order = t.menu_order + 1 
                      )
                ORDER BY m.menu_order ASC";
        }

        #endregion

        #region Parameter Names

        /// <summary>
        /// SQL parameter names
        /// </summary>
        public static class Parameters
        {
            public const string PERSONAL_ID = "@PersonalId";
            public const string FIRST_NAME = "@FirstName";
            public const string LAST_NAME = "@LastName";
            public const string EMAIL = "@Email";
            public const string PHONE = "@Phone";
            public const string ADDRESS = "@Address";
            public const string CITY = "@City";
            public const string IS_ACTIVE = "@IsActive";
            public const string START_DATE = "@StartDate";
            public const string END_DATE = "@EndDate";
            public const string USER_ID = "@userid";
            public const string USER_TYPE = "@userType";
            public const string CURRENT_PAGE = "@currentPage";
        }

        #endregion

        #region Error Messages

        /// <summary>
        /// Error messages for PersonalDetails operations
        /// </summary>
        public static class ErrorMessages
        {
            public const string DATABASE_QUERY_FAILED = "Database query execution failed: {0}";
            public const string DATABASE_SCALAR_QUERY_FAILED = "Database scalar query execution failed: {0}";
            public const string TRANSACTION_FAILED = "Transaction failed: {0}";
            public const string TABLE_NAME_REQUIRED = "Table name and parameters are required";
            public const string UPDATE_FIELDS_REQUIRED = "Field updates are required";
            public const string QUERIES_PARAMETERS_MISMATCH = "Number of queries must match number of parameter arrays";
            public const string FIELD_UPDATES_REQUIRED = "Field updates are required";
            public const string TABLE_NAME_UPDATE_FIELDS_REQUIRED = "Table name and update fields are required";
            public const string FAILED_TO_LOAD_PAGE_DATA = "Failed to load page data";
            public const string NO_DATA_RECEIVED = "No data received from server";
            public const string ERROR_PROCESSING_RESPONSE = "Error processing page load response: {0}";
        }

        #endregion

        #region UI Constants

        /// <summary>
        /// UI-related constants for PersonalDetails page
        /// </summary>
        public static class UI
        {
            /// <summary>
            /// Form field placeholders
            /// </summary>
            public static class Placeholders
            {
                public const string FULL_NAME = "Enter full name";
                public const string EMAIL = "Enter email";
                public const string MOBILE_NUMBER = "Enter mobile number";
                public const string ADDRESS = "Enter address";
            }

            /// <summary>
            /// Form field labels
            /// </summary>
            public static class Labels
            {
                public const string FULL_NAME = "Full Name";
                public const string DATE_OF_BIRTH = "Date of Birth";
                public const string GENDER = "Gender";
                public const string EMAIL = "Email";
                public const string MOBILE_NUMBER = "Mobile Number";
                public const string ADDRESS = "Address";
            }

            /// <summary>
            /// Gender options
            /// </summary>
            public static class GenderOptions
            {
                public const string CHOOSE = "Choose...";
                public const string MALE = "Male";
                public const string FEMALE = "Female";
                public const string OTHER = "Other";
            }

            /// <summary>
            /// Button text
            /// </summary>
            public static class ButtonText
            {
                public const string PREVIOUS = "Previous";
                public const string NEXT = "Next";
                public const string SAVE = "Save";
            }

            /// <summary>
            /// CSS classes
            /// </summary>
            public static class CssClasses
            {
                public const string FORM_CONTROL = "form-control";
                public const string FORM_SELECT = "form-select";
                public const string FORM_LABEL = "form-label";
                public const string BTN_PRIMARY = "btn btn-primary";
                public const string BTN_SECONDARY = "btn btn-secondary";
                public const string BTN_SUCCESS = "btn btn-success";
                public const string CARD_HEADER = "card-header";
                public const string CARD_BODY = "card-body";
                public const string TAB_PANE = "tab-pane";
                public const string TAB_PANE_ACTIVE = "tab-pane fade show active";
            }

            /// <summary>
            /// Loading messages
            /// </summary>
            public static class LoadingMessages
            {
                public const string LOADING_PAGE_DATA = "Loading page data...";
                public const string LOADING = "Loading...";
            }

            /// <summary>
            /// Success messages
            /// </summary>
            public static class SuccessMessages
            {
                public const string PAGE_DATA_LOADED = "Page data loaded successfully";
            }

            /// <summary>
            /// Console messages
            /// </summary>
            public static class ConsoleMessages
            {
                public const string PAGE_LOADED = "Page loaded - calling AJAX method...";
                public const string NO_DATA_RECEIVED = "No data received from server";
            }
        }

        #endregion

        #region Validation Constants

        /// <summary>
        /// Validation rules and limits
        /// </summary>
        public static class Validation
        {
            public const int MIN_NAME_LENGTH = 1;
            public const int MAX_NAME_LENGTH = 50;
            public const int MIN_EMAIL_LENGTH = 5;
            public const int MAX_EMAIL_LENGTH = 100;
            public const int MIN_PHONE_LENGTH = 10;
            public const int MAX_PHONE_LENGTH = 20;
            public const int MAX_ADDRESS_LENGTH = 200;
            public const int MAX_CITY_LENGTH = 50;

            public const string EMAIL_REGEX_PATTERN = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            public const string PHONE_REGEX_PATTERN = @"^[\+]?[1-9][\d]{0,15}$";
        }

        #endregion

        #region Configuration Constants

        /// <summary>
        /// Configuration-related constants
        /// </summary>
        public static class Configuration
        {
            public const string CONNECTION_STRING_NAME = "SBSSNDConnectionString";
            public const string DEFAULT_USER_TYPE = "Profile";
            public const string ROOT_MENU_ID = "Root";
            public const string DEFAULT_GROUP_ID = "Profile";
        }

        #endregion

        #region JSON Constants

        /// <summary>
        /// JSON-related constants
        /// </summary>
        public static class Json
        {
            public const string CONTENT_TYPE = "application/json; charset=utf-8";
            public const string DATA_PROPERTY = "d";
        }

        #endregion

        #region Menu Position Constants

        /// <summary>
        /// Menu position status constants
        /// </summary>
        public static class MenuPosition
        {
            public const string PREVIOUS = "Previous";
            public const string CURRENT = "Current";
            public const string NEXT = "Next";
        }

        #endregion
    }
}
