using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;

namespace BLL.PersonalDetails
{
    public class PersonalDetails
    {
        private string connectionString;
        Constants constants = new Constants();
         
        public PersonalDetails()
        {
            // Get connection string from web.config
            connectionString = ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ConnectionString;
        }

        /// <summary>
        /// Execute a parameterized SELECT query and return DataTable
        /// </summary>
        /// <param name="query">SQL SELECT query with parameters</param>
        /// <param name="parameters">Array of SqlParameter objects</param>
        /// <returns>DataTable with query results</returns>
        public DataTable ExecuteSelectQuery(string query, SqlParameter[] parameters = null)
        {
            DataTable dataTable = new DataTable();
            
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters if provided
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }

                        connection.Open();
                        using (SqlDataAdapter adapter = new SqlDataAdapter(command))
                        {
                            adapter.Fill(dataTable);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception (you can implement proper logging here)
                throw new Exception("Database query execution failed: " + ex.Message, ex);
            }

            return dataTable;
        }

        /// <summary>
        /// Execute a parameterized SELECT query and return SqlDataReader
        /// Note: The caller is responsible for disposing the SqlDataReader
        /// </summary>
        /// <param name="query">SQL SELECT query with parameters</param>
        /// <param name="parameters">Array of SqlParameter objects</param>
        /// <returns>SqlDataReader</returns>
        public SqlDataReader ExecuteSelectQueryReader(string query, SqlParameter[] parameters = null)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand command = new SqlCommand(query, connection);

            try
            {
                // Add parameters if provided
                if (parameters != null)
                {
                    command.Parameters.AddRange(parameters);
                }

                connection.Open();
                return command.ExecuteReader(CommandBehavior.CloseConnection);
            }
            catch (Exception ex)
            {
                connection.Close();
                throw new Exception("Database query execution failed: " + ex.Message, ex);
            }
        }

        /// <summary>
        /// Execute a parameterized SELECT query using using statement for automatic disposal
        /// </summary>
        /// <param name="query">SQL SELECT query with parameters</param>
        /// <param name="parameters">Array of SqlParameter objects</param>
        /// <param name="action">Action to perform with the SqlDataReader</param>
        public void ExecuteSelectQueryWithUsing(string query, SqlParameter[] parameters, Action<SqlDataReader> action)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameters if provided
                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        action(reader);
                    }
                }
            }
        }

        /// <summary>
        /// Execute a scalar query (returns single value)
        /// </summary>
        /// <param name="query">SQL query</param>
        /// <param name="parameters">Array of SqlParameter objects</param>
        /// <returns>Object result</returns>
        public object ExecuteScalarQuery(string query, SqlParameter[] parameters = null)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters if provided
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }

                        connection.Open();
                        return command.ExecuteScalar();
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Database scalar query execution failed: " + ex.Message, ex);
            }
        }

        // Helper methods for creating SqlParameter objects with specific data types

        /// <summary>
        /// Create a SqlParameter with specific SqlDbType
        /// </summary>
        /// <param name="parameterName">Parameter name</param>
        /// <param name="value">Parameter value</param>
        /// <param name="dbType">SQL Server data type</param>
        /// <returns>SqlParameter object</returns>
        public SqlParameter CreateParameter(string parameterName, object value, SqlDbType dbType)
        {
            SqlParameter parameter = new SqlParameter(parameterName, dbType);
            parameter.Value = value ?? DBNull.Value;
            return parameter;
        }

        /// <summary>
        /// Create a SqlParameter with specific SqlDbType and size
        /// </summary>
        /// <param name="parameterName">Parameter name</param>
        /// <param name="value">Parameter value</param>
        /// <param name="dbType">SQL Server data type</param>
        /// <param name="size">Parameter size</param>
        /// <returns>SqlParameter object</returns>
        public SqlParameter CreateParameter(string parameterName, object value, SqlDbType dbType, int size)
        {
            SqlParameter parameter = new SqlParameter(parameterName, dbType, size);
            parameter.Value = value ?? DBNull.Value;
            return parameter;
        }

        // Example methods for PersonalDetails specific operations

        /// <summary>
        /// Get personal details by ID
        /// </summary>
        /// <param name="personalId">Personal ID</param>
        /// <returns>DataTable with personal details</returns>
        public DataTable GetPersonalDetailsById(int personalId)
        {
            string query = "SELECT * FROM PersonalDetails WHERE PersonalId = @PersonalId";
            SqlParameter[] parameters = {
                new SqlParameter("@PersonalId", personalId)
            };
            return ExecuteSelectQuery(query, parameters);
        }

        

        /// <summary>
        /// Get personal details with specific data types using helper methods
        /// </summary>
        /// <param name="personalId">Personal ID</param>
        /// <param name="isActive">Active status</param>
        /// <returns>DataTable with personal details</returns>
        public DataTable GetPersonalDetailsWithTypes(int personalId, bool isActive)
        {
            string query = @"SELECT * FROM PersonalDetails 
                           WHERE PersonalId = @PersonalId 
                           AND IsActive = @IsActive";
            SqlParameter[] parameters = {
                CreateParameter("@PersonalId", personalId, SqlDbType.Int),
                CreateParameter("@IsActive", isActive, SqlDbType.Bit)
            };
            return ExecuteSelectQuery(query, parameters);
        }

        /// <summary>
        /// Search personal details with date range
        /// </summary>
        /// <param name="startDate">Start date</param>
        /// <param name="endDate">End date</param>
        /// <returns>DataTable with personal details</returns>
        public DataTable GetPersonalDetailsByDateRange(DateTime startDate, DateTime endDate)
        {
            string query = @"SELECT * FROM PersonalDetails 
                           WHERE CreatedDate >= @StartDate 
                           AND CreatedDate <= @EndDate";
            SqlParameter[] parameters = {
                CreateParameter("@StartDate", startDate, SqlDbType.DateTime),
                CreateParameter("@EndDate", endDate, SqlDbType.DateTime)
            };
            return ExecuteSelectQuery(query, parameters);
        }

        

        /// <summary>
        /// Get personal details count using using statement
        /// </summary>
        /// <param name="whereClause">Optional WHERE clause</param>
        /// <param name="parameters">Parameters for WHERE clause</param>
        /// <returns>Count of records</returns>
        public int GetPersonalDetailsCount(string whereClause = "", SqlParameter[] parameters = null)
        {
            string query = "SELECT COUNT(*) FROM PersonalDetails";
            if (!string.IsNullOrEmpty(whereClause))
            {
                query += " WHERE " + whereClause;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (parameters != null)
                    {
                        command.Parameters.AddRange(parameters);
                    }

                    connection.Open();
                    return Convert.ToInt32(command.ExecuteScalar());
                }
            }
        }

        /// <summary>
        /// Execute multiple queries in a transaction using using statement
        /// </summary>
        /// <param name="queries">Array of SQL queries</param>
        /// <param name="parameters">Array of parameter arrays for each query</param>
        /// <returns>True if all queries executed successfully</returns>
        public bool ExecuteMultipleQueries(string[] queries, SqlParameter[][] parameters)
        {
            if (queries.Length != parameters.Length)
            {
                throw new ArgumentException("Number of queries must match number of parameter arrays");
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlTransaction transaction = connection.BeginTransaction())
                {
                    try
                    {
                        for (int i = 0; i < queries.Length; i++)
                        {
                            using (SqlCommand command = new SqlCommand(queries[i], connection, transaction))
                            {
                                if (parameters[i] != null)
                                {
                                    command.Parameters.AddRange(parameters[i]);
                                }
                                command.ExecuteNonQuery();
                            }
                        }
                        transaction.Commit();
                        return true;
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        throw new Exception("Transaction failed: " + ex.Message, ex);
                    }
                }
            }
        }

        // INSERT Methods

        /// <summary>
        /// Insert a new personal detail record
        /// </summary>
        /// <param name="firstName">First name</param>
        /// <param name="lastName">Last name</param>
        /// <param name="email">Email address</param>
        /// <param name="phone">Phone number</param>
        /// <param name="address">Address</param>
        /// <param name="city">City</param>
        /// <param name="isActive">Active status</param>
        /// <returns>Number of rows affected</returns>
        public int InsertPersonalDetail(string firstName, string lastName, string email, string phone = null, string address = null, string city = null, bool isActive = true)
        {
            string query = @"INSERT INTO PersonalDetails (FirstName, LastName, Email, Phone, Address, City, IsActive, CreatedDate) 
                           VALUES (@FirstName, @LastName, @Email, @Phone, @Address, @City, @IsActive, GETDATE())";
            
            SqlParameter[] parameters = {
                CreateParameter("@FirstName", firstName, SqlDbType.NVarChar, 50),
                CreateParameter("@LastName", lastName, SqlDbType.NVarChar, 50),
                CreateParameter("@Email", email, SqlDbType.NVarChar, 100),
                CreateParameter("@Phone", phone, SqlDbType.NVarChar, 20),
                CreateParameter("@Address", address, SqlDbType.NVarChar, 200),
                CreateParameter("@City", city, SqlDbType.NVarChar, 50),
                CreateParameter("@IsActive", isActive, SqlDbType.Bit)
            };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters);
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
        }

        /// <summary>
        /// Insert personal detail and return the new ID
        /// </summary>
        /// <param name="firstName">First name</param>
        /// <param name="lastName">Last name</param>
        /// <param name="email">Email address</param>
        /// <param name="phone">Phone number</param>
        /// <param name="address">Address</param>
        /// <param name="city">City</param>
        /// <param name="isActive">Active status</param>
        /// <returns>New PersonalId</returns>
        public int InsertPersonalDetailAndReturnId(string firstName, string lastName, string email, string phone = null, string address = null, string city = null, bool isActive = true)
        {
            string query = @"INSERT INTO PersonalDetails (FirstName, LastName, Email, Phone, Address, City, IsActive, CreatedDate) 
                           VALUES (@FirstName, @LastName, @Email, @Phone, @Address, @City, @IsActive, GETDATE());
                           SELECT SCOPE_IDENTITY();";
            
            SqlParameter[] parameters = {
                CreateParameter("@FirstName", firstName, SqlDbType.NVarChar, 50),
                CreateParameter("@LastName", lastName, SqlDbType.NVarChar, 50),
                CreateParameter("@Email", email, SqlDbType.NVarChar, 100),
                CreateParameter("@Phone", phone, SqlDbType.NVarChar, 20),
                CreateParameter("@Address", address, SqlDbType.NVarChar, 200),
                CreateParameter("@City", city, SqlDbType.NVarChar, 50),
                CreateParameter("@IsActive", isActive, SqlDbType.Bit)
            };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    return Convert.ToInt32(result);
                }
            }
        }

        /// <summary>
        /// Generic insert method for any table
        /// </summary>
        /// <param name="tableName">Name of the table</param>
        /// <param name="parameters">Array of SqlParameter objects</param>
        /// <returns>Number of rows affected</returns>
        public int InsertRecord(string tableName, SqlParameter[] parameters)
        {
            if (string.IsNullOrEmpty(tableName) || parameters == null || parameters.Length == 0)
            {
                throw new ArgumentException("Table name and parameters are required");
            }

            string columns = string.Join(", ", parameters.Select(p => p.ParameterName.Replace("@", "")));
            string values = string.Join(", ", parameters.Select(p => p.ParameterName));
            string query = $"INSERT INTO {tableName} ({columns}) VALUES ({values})";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters);
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
        }

        // UPDATE Methods

        /// <summary>
        /// Update personal detail by ID
        /// </summary>
        /// <param name="personalId">Personal ID</param>
        /// <param name="firstName">First name</param>
        /// <param name="lastName">Last name</param>
        /// <param name="email">Email address</param>
        /// <param name="phone">Phone number</param>
        /// <param name="address">Address</param>
        /// <param name="city">City</param>
        /// <param name="isActive">Active status</param>
        /// <returns>Number of rows affected</returns>
        public int UpdatePersonalDetail(int personalId, string firstName, string lastName, string email, string phone = null, string address = null, string city = null, bool? isActive = null)
        {
            string query = @"UPDATE PersonalDetails 
                           SET FirstName = @FirstName, 
                               LastName = @LastName, 
                               Email = @Email, 
                               Phone = @Phone, 
                               Address = @Address, 
                               City = @City, 
                               IsActive = @IsActive,
                               LastModified = GETDATE()
                           WHERE PersonalId = @PersonalId";
            
            SqlParameter[] parameters = {
                CreateParameter("@PersonalId", personalId, SqlDbType.Int),
                CreateParameter("@FirstName", firstName, SqlDbType.NVarChar, 50),
                CreateParameter("@LastName", lastName, SqlDbType.NVarChar, 50),
                CreateParameter("@Email", email, SqlDbType.NVarChar, 100),
                CreateParameter("@Phone", phone, SqlDbType.NVarChar, 20),
                CreateParameter("@Address", address, SqlDbType.NVarChar, 200),
                CreateParameter("@City", city, SqlDbType.NVarChar, 50),
                CreateParameter("@IsActive", isActive, SqlDbType.Bit)
            };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters);
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
        }

        /// <summary>
        /// Update specific fields of personal detail
        /// </summary>
        /// <param name="personalId">Personal ID</param>
        /// <param name="fieldUpdates">Dictionary of field names and values to update</param>
        /// <returns>Number of rows affected</returns>
        public int UpdatePersonalDetailFields(int personalId, Dictionary<string, object> fieldUpdates)
        {
            if (fieldUpdates == null || fieldUpdates.Count == 0)
            {
                throw new ArgumentException("Field updates are required");
            }

            var setClauses = new List<string>();
            var parameters = new List<SqlParameter>
            {
                CreateParameter("@PersonalId", personalId, SqlDbType.Int)
            };

            foreach (var field in fieldUpdates)
            {
                setClauses.Add($"{field.Key} = @{field.Key}");
                parameters.Add(CreateParameter($"@{field.Key}", field.Value, GetSqlDbType(field.Value)));
            }

            setClauses.Add("LastModified = GETDATE()");
            string query = $"UPDATE PersonalDetails SET {string.Join(", ", setClauses)} WHERE PersonalId = @PersonalId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters.ToArray());
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
        }

        /// <summary>
        /// Generic update method for any table
        /// </summary>
        /// <param name="tableName">Name of the table</param>
        /// <param name="updateFields">Fields to update</param>
        /// <param name="whereClause">WHERE clause</param>
        /// <param name="whereParameters">Parameters for WHERE clause</param>
        /// <returns>Number of rows affected</returns>
        public int UpdateRecord(string tableName, SqlParameter[] updateFields, string whereClause, SqlParameter[] whereParameters)
        {
            if (string.IsNullOrEmpty(tableName) || updateFields == null || updateFields.Length == 0)
            {
                throw new ArgumentException("Table name and update fields are required");
            }

            string setClause = string.Join(", ", updateFields.Select(p => $"{p.ParameterName.Replace("@", "")} = {p.ParameterName}"));
            string query = $"UPDATE {tableName} SET {setClause}";

            if (!string.IsNullOrEmpty(whereClause))
            {
                query += " WHERE " + whereClause;
            }

            var allParameters = new List<SqlParameter>(updateFields);
            if (whereParameters != null)
            {
                allParameters.AddRange(whereParameters);
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(allParameters.ToArray());
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
        }

        // Helper method to determine SqlDbType from object value
        private SqlDbType GetSqlDbType(object value)
        {
            if (value == null) return SqlDbType.NVarChar;
            
            Type type = value.GetType();
            if (type == typeof(int)) return SqlDbType.Int;
            if (type == typeof(long)) return SqlDbType.BigInt;
            if (type == typeof(decimal)) return SqlDbType.Decimal;
            if (type == typeof(double) || type == typeof(float)) return SqlDbType.Float;
            if (type == typeof(bool)) return SqlDbType.Bit;
            if (type == typeof(DateTime)) return SqlDbType.DateTime;
            if (type == typeof(Guid)) return SqlDbType.UniqueIdentifier;
            return SqlDbType.NVarChar; // Default to string
        }


         public DataTable GetMenuDetailsForUserTypeWise(string userType, string userid)
        {
            string user_group = "Profile";
            if (userType == "I2")
            {
                user_group = "Profile_VF";
            }
            else if (userType == "TA")
            {
                user_group = "Profile_TA";
            }
            else if (userType == "D")
            {
                user_group = "Profile_D";
            }
            string query = @"Select MenuMst.menu_id,MenuMst.menu_description,MenuMst.window_name,MenuMst.page_name  
                            From group_rights inner join MenuMst on MenuMst.menu_id = group_rights.menu_id
                           where group_id IN(select group_id from user_group where user_id = @userid and user_type =@userType and group_id =@group_id) and parent_menu_id NOT IN ('Root') and menu_description != 'PersonalDetailsView' 
                            ORDER BY menu_order Asc";
            SqlParameter[] parameters = {
                CreateParameter("@userid", userid, SqlDbType.NVarChar),
                CreateParameter("@userType", userType, SqlDbType.NVarChar),
                CreateParameter("@group_id", user_group, SqlDbType.NVarChar)
            };
            return ExecuteSelectQuery(query, parameters);
        }

        public DataTable GetMenuSequence(string userType, string userid, string currentPage)
        {

            string user_group = "Profile";
            if (userType == "I2")
            {
                user_group = "Profile_VF";
            }
            else if (userType == "TA")
            {
                user_group = "Profile_TA";
            }
            else if (userType == "D")
            {
                user_group = "Profile_D";
            }
            string query = @";WITH TargetMenu AS (
                            SELECT TOP 1 m.menu_order
                            FROM group_rights gr
                            INNER JOIN MenuMst m ON m.menu_id = gr.menu_id
                            WHERE gr.group_id IN (
                                    SELECT group_id
                                    FROM user_group
                                    WHERE user_id = @userid
                                      AND user_type = @userType
                                      AND group_id = @group_id
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
                                  AND group_id = @group_id
                              )
                          AND m.parent_menu_id <> 'Root'
                          AND (
                                m.menu_order = t.menu_order       
                                OR m.menu_order = t.menu_order - 1 
                                OR m.menu_order = t.menu_order + 1 
                              )
                        ORDER BY m.menu_order ASC";
             SqlParameter[] parameters = {
                CreateParameter("@userid", userid, SqlDbType.NVarChar),
                CreateParameter("@userType", userType, SqlDbType.NVarChar),
                CreateParameter("@currentPage", currentPage, SqlDbType.NVarChar),
                CreateParameter("@group_id", user_group, SqlDbType.NVarChar)
            };
            return ExecuteSelectQuery(query, parameters);
        }
        public string DataTableToJson(DataTable dataTable)
        {
            var list = new List<Dictionary<string, object>>();
            
            foreach (DataRow row in dataTable.Rows)
            {
                var dict = new Dictionary<string, object>();
                foreach (DataColumn column in dataTable.Columns)
                {
                    dict[column.ColumnName] = row[column];
                }
                list.Add(dict);
            }
            
            return Newtonsoft.Json.JsonConvert.SerializeObject(list);
        }
        public string GetMenuDetailsAsJson(string userType, string userid)
        {
            DataTable menuData = GetMenuDetailsForUserTypeWise(userType, userid);
            return DataTableToJson(menuData);
        }
        public bool SavePersonalDetails(Dictionary<string, object> formData, string userId, string host_name)
        {
            try
            {
                string query = @"
                    
                    UPDATE UserPersonalDetails 
                    SET cancel_flag = 'Y',last_modified_by = @last_modified_by,last_modified_date = @last_modified_date ,last_modified_host = @last_modified_host  
                    WHERE user_code = @user_code AND cancel_flag = 'N';
                    
                    -- Then insert new record
                    INSERT INTO UserPersonalDetails (
                        user_code, Full_name, first_name, middle_name, last_name, dob,
                        place_of_birth, nationality, gender, category_id, mobile_no,
                        alternet_mob_no, emergency_contact_name, emergency_contact_no,
                        user_profile_dtl, edu_work_profile, personal_email_id,
                        alternet_email_id, cancel_flag, created_by, created_date, created_host,filename,filepath
                    ) VALUES (
                        @user_code, @Full_name, @first_name, @middle_name, @last_name, @dob,
                        @place_of_birth, @nationality, @gender, @category_id, @mobile_no,
                        @alternet_mob_no, @emergency_contact_name, @emergency_contact_no,
                        @user_profile_dtl, @edu_work_profile, @personal_email_id,
                        @alternet_email_id, @cancel_flag, @created_by, @created_date, @created_host,@filename,@filepath
                    )";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId),
                    new SqlParameter("@Full_name", GetValueOrNull(formData, "full_name")),
                    new SqlParameter("@first_name", GetValueOrNull(formData, "first_name")),
                    new SqlParameter("@middle_name", GetValueOrNull(formData, "middle_name")),
                    new SqlParameter("@last_name", GetValueOrNull(formData, "last_name")),
                    new SqlParameter("@dob", GetValueOrNull(formData, "dob")),
                    new SqlParameter("@place_of_birth", GetValueOrNull(formData, "place_of_birth")),
                    new SqlParameter("@nationality", GetValueOrNull(formData, "nationality")),
                    new SqlParameter("@gender", GetValueOrNull(formData, "gender")),
                    new SqlParameter("@category_id", GetValueOrNull(formData, "category_id")),
                    new SqlParameter("@mobile_no", GetValueOrNull(formData, "mobile_no")),
                    new SqlParameter("@alternet_mob_no", GetValueOrNull(formData, "alternet_mob_no")),
                    new SqlParameter("@emergency_contact_name", GetValueOrNull(formData, "emergency_contact_name")),
                    new SqlParameter("@emergency_contact_no", GetValueOrNull(formData, "emergency_contact_no")),
                    new SqlParameter("@user_profile_dtl", GetValueOrNull(formData, "user_profile_dtl")),
                    new SqlParameter("@edu_work_profile", GetValueOrNull(formData, "edu_work_profile")),
                    new SqlParameter("@personal_email_id", GetValueOrNull(formData, "personal_email_id")),
                    new SqlParameter("@alternet_email_id", GetValueOrNull(formData, "alternet_email_id")),
                    new SqlParameter("@cancel_flag", "N"),
                    new SqlParameter("@created_by", userId),
                    new SqlParameter("@created_date", DateTime.Now),
                    new SqlParameter("@created_host", host_name),
                    new SqlParameter("@last_modified_by", userId),
                    new SqlParameter("@last_modified_date", DateTime.Now),
                    new SqlParameter("@last_modified_host", host_name),
                    new SqlParameter("@filename", GetValueOrNull(formData, "profile_file_name")),
                    new SqlParameter("@filepath", GetValueOrNull(formData, "profile_file_path"))
                };

                return ExecuteNonQuery(query, parameters);
            }
            catch (Exception ex)
            {
                // Log the exception (you may want to use a proper logging framework)
                System.Diagnostics.Debug.WriteLine($"Error in SavePersonalDetails: {ex.Message}");
                return false;
            }
        }

        public bool SaveContactDetails(Dictionary<string, object> formData, string userId, string host_name)
        {
            try
            {
                string query = @"
                    UPDATE UserContactDetails 
                    SET cancel_flag = 'Y',last_modified_by = @last_modified_by,last_modified_date = @last_modified_date ,last_modified_host = @last_modified_host  
                    WHERE user_code = @user_code AND cancel_flag = 'N';
                    
                    -- Then insert new record
                    INSERT INTO UserContactDetails (
                        user_code, permanent_address, address_line_1, address_line_2, 
                        pcity, pstate, pcountry, residing_address, raddress_line_1, 
                        raddress_line_2, rcity, rstate, rcounty,
                        cancel_flag, created_by, created_date, created_host
                    ) VALUES (
                        @user_code, @permanent_address, @address_line_1, @address_line_2, 
                        @pcity, @pstate, @pcountry, @residing_address, @raddress_line_1, 
                        @raddress_line_2, @rcity, @rstate, @rcounty,
                        @cancel_flag, @created_by, @created_date, @created_host
                    )";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId),
                    new SqlParameter("@permanent_address", GetValueOrNull(formData, "permanent_address")),
                    new SqlParameter("@address_line_1", GetValueOrNull(formData, "address_line_1")),
                    new SqlParameter("@address_line_2", GetValueOrNull(formData, "address_line_2")),
                    new SqlParameter("@pcity", GetValueOrNull(formData, "permanent_city")),
                    new SqlParameter("@pstate", GetValueOrNull(formData, "permanent_state")),
                    new SqlParameter("@pcountry", GetValueOrNull(formData, "permanent_country")),
                    new SqlParameter("@residing_address", GetValueOrNull(formData, "residing_address")),
                    new SqlParameter("@raddress_line_1", GetValueOrNull(formData, "residing_address_line_1")),
                    new SqlParameter("@raddress_line_2", GetValueOrNull(formData, "residing_address_line_2")),
                    new SqlParameter("@rcity", GetValueOrNull(formData, "residing_city")),
                    new SqlParameter("@rstate", GetValueOrNull(formData, "residing_state")),
                    new SqlParameter("@rcounty", GetValueOrNull(formData, "residing_county")),
                    new SqlParameter("@cancel_flag", "N"),
                    new SqlParameter("@created_by", userId),
                    new SqlParameter("@created_date", DateTime.Now),
                    new SqlParameter("@created_host", host_name),
                    new SqlParameter("@last_modified_by", userId),
                    new SqlParameter("@last_modified_date", DateTime.Now),
                    new SqlParameter("@last_modified_host", host_name)
                };

                return ExecuteNonQuery(query, parameters);
            }
            catch (Exception ex)
            {
                // Log the exception (you may want to use a proper logging framework)
                System.Diagnostics.Debug.WriteLine($"Error in SavePersonalDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveEducationDetails(List<Dictionary<string, object>> educationList, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < educationList.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = educationList[i];
                    if (i == 0)
                    {
                query = @"
                UPDATE UserEducationDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }
                    

                query += @"
                INSERT INTO UserEducationDetails (
                    user_code, program, degree, specialization, university_institute,
                    start_date, end_date, percentage_cgpa, per_division, mode_of_learning,
                    marksheet_grade_file, cancel_flag, created_by, created_date, created_host
                ) VALUES (
                    @user_code, @program, @degree, @specialization, @university_institute,
                    @start_date, @end_date, @percentage_cgpa, @per_division, @mode_of_learning,
                    @marksheet_grade_file, @cancel_flag, @created_by, @created_date, @created_host
                )";

                    SqlParameter[] parameters = new SqlParameter[]
                    {
               new SqlParameter("@user_code", userId),
               new SqlParameter("@program", GetValueOrNull(formData, "program")),
               new SqlParameter("@degree", GetValueOrNull(formData, "degree")),
               new SqlParameter("@specialization", GetValueOrNull(formData, "specialization")),
               new SqlParameter("@university_institute", GetValueOrNull(formData, "university")),
               new SqlParameter("@start_date", GetValueOrNull(formData, "start_date")),
               new SqlParameter("@end_date", GetValueOrNull(formData, "end_date")),
               new SqlParameter("@percentage_cgpa", GetValueOrNull(formData, "percentage_cgpa")),
               new SqlParameter("@per_division", GetValueOrNull(formData, "percentage_division")),
               new SqlParameter("@mode_of_learning", GetValueOrNull(formData, "mode")),
               new SqlParameter("@marksheet_grade_file", GetValueOrNull(formData, "marksheet_file")),
               new SqlParameter("@cancel_flag", "N"),
               new SqlParameter("@created_by", userId),
               new SqlParameter("@created_date", DateTime.Now),
               new SqlParameter("@created_host", host_name),
               new SqlParameter("@last_modified_by", userId),
               new SqlParameter("@last_modified_date", DateTime.Now),
               new SqlParameter("@last_modified_host", host_name)
                    };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveEducationDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveExperienceDetails(List<Dictionary<string, object>> ExperienceList, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < ExperienceList.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = ExperienceList[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserWorkDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
    INSERT INTO UserWorkDetails (
        user_code, organization_name, designation, experience_type,
        start_date, end_date, total_year_in_months, mode_of_experience,
        total_hours_in_week, total_year_months_counts, experienced_Document_ref,
        cancel_flag, created_by, created_date, created_host
    ) VALUES (
        @user_code, @organization_name, @designation, @experience_type,
        @start_date, @end_date, @total_year_in_months, @mode_of_experience,
        @total_hours_in_week, @total_year_months_counts, @experienced_Document_ref,
        @cancel_flag, @created_by, @created_date, @created_host
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                           new SqlParameter("@user_code", userId),
                           new SqlParameter("@organization_name", GetValueOrNull(formData, "organization_name")),
                           new SqlParameter("@designation", GetValueOrNull(formData, "designation")),
                           new SqlParameter("@experience_type", GetValueOrNull(formData, "experience_type")),
                           new SqlParameter("@start_date", GetValueOrNull(formData, "start_date")),
                           new SqlParameter("@end_date", GetValueOrNull(formData, "end_date")),
                           new SqlParameter("@total_year_in_months", GetValueOrNull(formData, "total_year_in_months")),
                           new SqlParameter("@mode_of_experience", GetValueOrNull(formData, "mode_of_experience")),
                           new SqlParameter("@total_hours_in_week", GetValueOrNull(formData, "total_hours_in_week")),
                           new SqlParameter("@total_year_months_counts", GetValueOrNull(formData, "total_year_months_counts")),
                           new SqlParameter("@experienced_document_ref", GetValueOrNull(formData, "experienced_document_ref")),
                           new SqlParameter("@cancel_flag", "N"),
                           new SqlParameter("@created_by", userId),
                           new SqlParameter("@created_date", DateTime.Now),
                           new SqlParameter("@created_host", host_name),
                           new SqlParameter("@last_modified_by", userId),
                           new SqlParameter("@last_modified_date", DateTime.Now),
                           new SqlParameter("@last_modified_host", host_name)
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveExperienceDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveExperienceSummary(Dictionary<string, object> formData, string userId, string host_name,string user_type)
        {
            try
            {
                string query = "";
              //  for (int i = 0; i < ExperienceList.Count; i++)
               // {
                    query = "";
                    //Dictionary<string, object> formData = ExperienceList[i];
                    //if (i == 0)
                    //{
                        query = @"
                UPDATE UserDesignationDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    //}


                    query += @"
                    INSERT INTO UserDesignationDetails (
                        user_code, designation_code, user_type, dept_code,
                        total_experience_years, total_experience_months, total_experience_total_months,
                        total_teaching_years, total_teaching_months, total_teaching_total_months,
                        total_industry_years, total_industry_months, total_industry_total_months,
                        total_research_years, total_research_months, total_research_total_months,
                        cancel_flag, created_by, created_date, created_host
                    ) VALUES (
                       @user_code, @designation_code, @user_type, @dept_code,
                        @total_experience_years, @total_experience_months, @total_experience_total_months,
                        @total_teaching_years, @total_teaching_months, @total_teaching_total_months,
                        @total_industry_years, @total_industry_months, @total_industry_total_months,
                        @total_research_years, @total_research_months, @total_research_total_months,
                        @cancel_flag, @created_by, @created_date, @created_host
                    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                           new SqlParameter("@user_code", userId),
                           new SqlParameter("@designation_code", GetValueOrNull(formData, "designation_code")),
                           new SqlParameter("@user_type", user_type),
                           new SqlParameter("@dept_code", GetValueOrNull(formData, "dept_code")),

                           new SqlParameter("@total_experience_years", GetValueOrNull(formData, "total_experience_years")),
                           new SqlParameter("@total_experience_months", GetValueOrNull(formData, "total_experience_months")),
                           new SqlParameter("@total_experience_total_months", GetValueOrNull(formData, "total_experience_total_months")),

                           new SqlParameter("@total_teaching_years", GetValueOrNull(formData, "total_teaching_years")),
                           new SqlParameter("@total_teaching_months", GetValueOrNull(formData, "total_teaching_months")),
                           new SqlParameter("@total_teaching_total_months", GetValueOrNull(formData, "total_teaching_total_months")),

                           new SqlParameter("@total_industry_years", GetValueOrNull(formData, "total_industry_years")),
                           new SqlParameter("@total_industry_months", GetValueOrNull(formData, "total_industry_months")),
                           new SqlParameter("@total_industry_total_months", GetValueOrNull(formData, "total_industry_total_months")),

                           new SqlParameter("@total_research_years", GetValueOrNull(formData, "total_research_years")),
                           new SqlParameter("@total_research_months", GetValueOrNull(formData, "total_research_months")),
                           new SqlParameter("@total_research_total_months", GetValueOrNull(formData, "total_research_total_months")),

                           new SqlParameter("@cancel_flag", "N"),
                           new SqlParameter("@created_by", userId),
                           new SqlParameter("@created_date", DateTime.Now),
                           new SqlParameter("@created_host", host_name),
                           new SqlParameter("@last_modified_by", userId),
                           new SqlParameter("@last_modified_date", DateTime.Now),
                           new SqlParameter("@last_modified_host", host_name)
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                //}

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveExperienceDetails: {ex.Message}");
                return false;
            }
        }
        public bool SaveBankDetails(Dictionary<string, object> formData, string userId, string host_name)
        {
            try
            {
                string query = @"
                    UPDATE UserBankAccountDetails 
                    SET cancel_flag = 'Y',last_modified_by = @last_modified_by,last_modified_date = @last_modified_date ,last_modified_host = @last_modified_host  
                    WHERE user_code = @user_code AND cancel_flag = 'N';
                    
                    -- Then insert new record
                    INSERT INTO UserBankAccountDetails (
        user_code, beneficiary_name, bank_account_no, account_type,
        ifsc_code, bank_name, branch_name,
        cancel_flag, created_by, created_date, created_host
    ) VALUES (
        @user_code, @beneficiary_name, @bank_account_no, @account_type,
        @ifsc_code, @bank_name, @branch_name,
        @cancel_flag, @created_by, @created_date, @created_host
    )";

                SqlParameter[] parameters = new SqlParameter[]
{
    new SqlParameter("@user_code", userId),
    new SqlParameter("@beneficiary_name", GetValueOrNull(formData, "beneficiary_name")),
    new SqlParameter("@bank_account_no", GetValueOrNull(formData, "bank_account_no")),
    new SqlParameter("@account_type", GetValueOrNull(formData, "account_type")),
    new SqlParameter("@ifsc_code", GetValueOrNull(formData, "ifsc_code")),
    new SqlParameter("@bank_name", GetValueOrNull(formData, "bank_name")),
    new SqlParameter("@branch_name", GetValueOrNull(formData, "branch_name")),
    new SqlParameter("@cancel_flag", "N"),
    new SqlParameter("@created_by", userId),
    new SqlParameter("@created_date", DateTime.Now),
    new SqlParameter("@created_host", host_name),
    new SqlParameter("@last_modified_by", userId),
    new SqlParameter("@last_modified_date", DateTime.Now),
    new SqlParameter("@last_modified_host", host_name)
};

                return ExecuteNonQuery(query, parameters);
            }
            catch (Exception ex)
            {
                // Log the exception (you may want to use a proper logging framework)
                System.Diagnostics.Debug.WriteLine($"Error in SavePersonalDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveExpertiseDetails(List<Dictionary<string, object>> ExperienceList, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < ExperienceList.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = ExperienceList[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserAreaofExpertise 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
                        INSERT INTO UserAreaofExpertise (
                            user_code, description, expertise_area, skill_level,
                            years_of_experience, certification, cancel_flag,
                            created_by, created_date, created_host
                        ) VALUES (
                            @user_code, @description, @expertise_area, @skill_level,
                            @years_of_experience, @certification, @cancel_flag,
                            @created_by, @created_date, @created_host
                        )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                          new SqlParameter("@user_code", userId),
                          new SqlParameter("@description", GetValueOrNull(formData, "description")),
                          new SqlParameter("@expertise_area", GetValueOrNull(formData, "expertise_area")),
                          new SqlParameter("@skill_level", GetValueOrNull(formData, "skill_level")),
                          new SqlParameter("@years_of_experience", GetValueOrNull(formData, "years_of_experience")),
                          new SqlParameter("@certification", GetValueOrNull(formData, "certification")),
                          new SqlParameter("@cancel_flag", "N"),
                          new SqlParameter("@created_by", userId),
                          new SqlParameter("@created_date", DateTime.Now),
                          new SqlParameter("@created_host", host_name),
                          new SqlParameter("@last_modified_by", userId),
                          new SqlParameter("@last_modified_date", DateTime.Now),
                          new SqlParameter("@last_modified_host", host_name)
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveExperienceDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveCourseTaughtDetails(List<Dictionary<string, object>> CourseTaughtList, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < CourseTaughtList.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = CourseTaughtList[i];

                    if (formData.ContainsKey("semester_type"))
                    {
                        if (formData["semester_type"].ToString() == "Monsoon")
                        {
                            formData["semester_type"] = "M";
                        }
                        else if (formData["semester_type"].ToString() == "Winter")
                        {
                            formData["semester_type"] = "W";
                        }
                        else { formData["semester_type"] = "S"; }
                        
                    }
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserCoursesTaughtDtl 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
    INSERT INTO UserCoursesTaughtDtl (
        user_code, course_code, title, semester_year,
                semester_type, is_active, cancel_flag,
                created_by, created_date, created_host
    ) VALUES (
        @user_code, @course_code, @title, @semester_year,
                @semester_type, @is_active, @cancel_flag,
                @created_by, @created_date, @created_host
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                           new SqlParameter("@user_code", userId),
                           new SqlParameter("@course_code", GetValueOrNull(formData, "course_code")),
                           new SqlParameter("@title", GetValueOrNull(formData, "title")),
                           new SqlParameter("@semester_year", GetValueOrNull(formData, "semester_year")),
                           new SqlParameter("@semester_type", GetValueOrNull(formData, "semester_type")),
                           new SqlParameter("@is_active", GetValueOrNull(formData, "is_active")),
                           new SqlParameter("@cancel_flag", "N"),
                           new SqlParameter("@created_by", userId),
                           new SqlParameter("@created_date", DateTime.Now),
                           new SqlParameter("@created_host", host_name),
                           new SqlParameter("@last_modified_by", userId),
                           new SqlParameter("@last_modified_date", DateTime.Now),
                           new SqlParameter("@last_modified_host", host_name)
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveExperienceDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveAwardsDetails(List<Dictionary<string, object>> AwardList, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < AwardList.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = AwardList[i];

                    //if (formData.ContainsKey("semester_type"))
                    //{
                    //    if (formData["semester_type"] == "Monsoon")
                    //    {
                    //        formData["semester_type"] = "M";
                    //    }
                    //    else if (formData["semester_type"] == "Winter")
                    //    {
                    //        formData["semester_type"] = "W";
                    //    }
                    //    else { formData["semester_type"] = "S"; }

                    //}
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserAwardsDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
    INSERT INTO UserAwardsDetails (
        user_code, type, title, description, date, year_code,
        cancel_flag, created_by, created_date, created_host
    ) VALUES (
        @user_code, @type, @title, @description, @date, @year_code,
        @cancel_flag, @created_by, @created_date, @created_host
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                           new SqlParameter("@user_code", userId),
                           new SqlParameter("@type", GetValueOrNull(formData, "type")),
                           new SqlParameter("@title", GetValueOrNull(formData, "title")),
                           new SqlParameter("@description", GetValueOrNull(formData, "description")),
                           new SqlParameter("@date", GetValueOrNull(formData, "date")),
                           new SqlParameter("@year_code", GetValueOrNull(formData, "year_code")),
                           new SqlParameter("@cancel_flag", "N"),
                           new SqlParameter("@created_by", userId),
                           new SqlParameter("@created_date", DateTime.Now),
                           new SqlParameter("@created_host", host_name),
                           new SqlParameter("@last_modified_by", userId),
                           new SqlParameter("@last_modified_date", DateTime.Now),
                           new SqlParameter("@last_modified_host", host_name)
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveExperienceDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveTrainingPrograms(List<Dictionary<string, object>> TrainingProgramList, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < TrainingProgramList.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = TrainingProgramList[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserProfessionalTraining 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
    INSERT INTO UserProfessionalTraining (
        user_code, typeCode, title, description, duration,
        start_date, end_date, oraganizer, no_of_participants, certificate,
        cancel_flag, created_by, created_date, created_host
    ) VALUES (
        @user_code, @typeCode, @title, @description, @duration,
        @start_date, @end_date, @oraganizer, @no_of_participants, @certificate,
        @cancel_flag, @created_by, @created_date, @created_host
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                            new SqlParameter("@user_code", userId),
                            new SqlParameter("@typeCode", GetValueOrNull(formData, "typeCode")),
                            new SqlParameter("@title", GetValueOrNull(formData, "title")),
                            new SqlParameter("@description", GetValueOrNull(formData, "description")),
                            new SqlParameter("@duration", GetValueOrNull(formData, "duration")),
                            new SqlParameter("@start_date", GetValueOrNull(formData, "start_date")),
                            new SqlParameter("@end_date", GetValueOrNull(formData, "end_date")),
                            new SqlParameter("@oraganizer", GetValueOrNull(formData, "organizer")),
                            new SqlParameter("@no_of_participants", GetValueOrNull(formData, "no_of_participants")),
                            new SqlParameter("@certificate", GetValueOrNull(formData, "certificate")),
                            new SqlParameter("@cancel_flag", "N"),
                            new SqlParameter("@created_by", userId),
                            new SqlParameter("@created_date", DateTime.Now),
                            new SqlParameter("@created_host", host_name),
                            new SqlParameter("@last_modified_by", userId),
                            new SqlParameter("@last_modified_date", DateTime.Now),
                            new SqlParameter("@last_modified_host", host_name)
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveTrainingDetails: {ex.Message}");
                return false;
            }
        }



        public bool SaveSocialLinks(List<Dictionary<string, object>> SocialLinkList, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < SocialLinkList.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = SocialLinkList[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserSocialLinkDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
    INSERT INTO UserSocialLinkDetails (
         user_code, platform, displayName, url, description, visibility, priority,
        cancel_flag, created_by, created_date, created_host
    ) VALUES (
       @user_code, @platform, @display_name, @url, @description, @visibility, @priority,
        @cancel_flag, @created_by, @created_date, @created_host
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                             new SqlParameter("@user_code", userId),
                             new SqlParameter("@platform", GetValueOrNull(formData, "platform")),
                             new SqlParameter("@display_name", GetValueOrNull(formData, "displayName")),
                             new SqlParameter("@url", GetValueOrNull(formData, "url")),
                             new SqlParameter("@description", GetValueOrNull(formData, "description")),
                             new SqlParameter("@visibility", GetValueOrNull(formData, "visibility")),
                             new SqlParameter("@priority", GetValueOrNull(formData, "priority")),
                             new SqlParameter("@cancel_flag", "N"),
                             new SqlParameter("@created_by", userId),
                             new SqlParameter("@created_date", DateTime.Now),
                             new SqlParameter("@created_host", host_name),
                             new SqlParameter("@last_modified_by", userId),
                             new SqlParameter("@last_modified_date", DateTime.Now),
                             new SqlParameter("@last_modified_host", host_name)
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveTrainingDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveCRDF(List<Dictionary<string, object>> SaveCRDF, string userId, string host_name, string crdfstatus)
        {
            try
            {
                string query = "";
                if (crdfstatus == "Yes")
                {
                    for (int i = 0; i < SaveCRDF.Count; i++)
                    {
                        query = "";
                        Dictionary<string, object> formData = SaveCRDF[i];
                        if (i == 0)
                        {
                            query = @"
                  UPDATE UserOtherEngagementDtl
                  SET cancel_flag = 'Y'
                  WHERE user_code = @user_code AND cancel_flag = 'N';


    INSERT INTO UserOtherEngagementDtl (
        user_code, engagement_code, engagement_name, name_of_center, reporting_to,
        engagement_details, engagement_nature, from_month, from_year,to_month,to_year, engagement_status,
        cancel_flag, created_by, created_date, created_host
    ) VALUES (
        @user_code, @engagement_code, @engagement_name, @name_of_center, @reporting_to,
        @engagement_details, @engagement_nature, @from_month, @from_year,@to_month,@to_year, @engagement_status,
        @cancel_flag, @created_by, @created_date, @created_host
    )";

                            SqlParameter[] parameters = new SqlParameter[]
                                {
                             new SqlParameter("@user_code", userId),
                             new SqlParameter("@engagement_code", GetValueOrNull(formData, "engagement_code")),
                             new SqlParameter("@engagement_name", GetValueOrNull(formData, "engagement_name")),
                             new SqlParameter("@name_of_center", GetValueOrNull(formData, "name_of_center")),
                             new SqlParameter("@reporting_to", GetValueOrNull(formData, "reporting_to")),
                             new SqlParameter("@engagement_details", GetValueOrNull(formData, "engagement_details")),
                             new SqlParameter("@engagement_nature", GetValueOrNull(formData, "engagement_nature")),
                             new SqlParameter("@from_month", GetValueOrNull(formData, "from_month")),
                             new SqlParameter("@from_year", GetValueOrNull(formData, "from_year")),
                             new SqlParameter("@to_month", GetValueOrNull(formData, "to_month")),
                             new SqlParameter("@to_year", GetValueOrNull(formData, "to_year")),
                             new SqlParameter("@engagement_status", GetValueOrNull(formData, "engagement_status")),
                             new SqlParameter("@cancel_flag", "N"),
                             new SqlParameter("@created_by", userId),
                             new SqlParameter("@created_date", DateTime.Now),
                             new SqlParameter("@created_host", host_name),
                             new SqlParameter("@last_modified_by", userId),
                             new SqlParameter("@last_modified_date", DateTime.Now),
                             new SqlParameter("@last_modified_host", host_name)
                                };

                            // execute query for this record
                            ExecuteNonQuery(query, parameters);
                        }

                        return true; // all records processed successfully
                    }
                }
                else 
                {
                    query = "";
                    query = @"
                  UPDATE UserOtherEngagementDtl
                  SET cancel_flag = 'Y',last_modified_by =@last_modified_by,last_modified_date=@last_modified_date,last_modified_host=@last_modified_host
                  WHERE user_code = @user_code AND cancel_flag = 'N'";

                    SqlParameter[] parameters = new SqlParameter[]
                               {
                             new SqlParameter("@user_code", userId),
                             new SqlParameter("@last_modified_by", userId),
                             new SqlParameter("@last_modified_date", DateTime.Now),
                             new SqlParameter("@last_modified_host", host_name)
                               };
                    ExecuteNonQuery(query, parameters);

                }
                
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveTrainingDetails: {ex.Message}");
                return false;
            }
            return true;
        }

        public bool SaveReference(List<Dictionary<string, object>> SaveRefrence, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < SaveRefrence.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = SaveRefrence[i];
                    if (i == 0)
                    {
                        query = @"
                  UPDATE UserReferencesDtl
                  SET cancel_flag = 'Y'
                  WHERE user_code = @user_code AND cancel_flag = 'N';


    INSERT INTO UserReferencesDtl (
        user_code, references_name, references_email, references_mobile,
        cancel_flag, created_by, created_date, created_host
    ) VALUES (
        @user_code, @references_name, @references_email, @references_mobile,
        @cancel_flag, @created_by, @created_date, @created_host
    )";

                        SqlParameter[] parameters = new SqlParameter[]
                            {
                             new SqlParameter("@user_code", userId),
                             new SqlParameter("@references_name", GetValueOrNull(formData, "references_name")),
                             new SqlParameter("@references_email", GetValueOrNull(formData, "references_email")),
                             new SqlParameter("@references_mobile", GetValueOrNull(formData, "references_mobile")),
                             new SqlParameter("@cancel_flag", "N"),
                             new SqlParameter("@created_by", userId),
                             new SqlParameter("@created_date", DateTime.Now),
                             new SqlParameter("@created_host", host_name),
                             new SqlParameter("@last_modified_by", userId),
                             new SqlParameter("@last_modified_date", DateTime.Now),
                             new SqlParameter("@last_modified_host", host_name)
                            };

                        
                        ExecuteNonQuery(query, parameters);
                    }

                    return true; // all records processed successfully
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveTrainingDetails: {ex.Message}");
                return false;
            }
            return true;
        }

        public bool SaveDeclarationData(Dictionary<string, object> formData, string userId, string host_name,string user_type)
        {

            DataTable dt_table = GetTotalExpirenceDetails(userId, user_type);
            DataTable dt_currentSem = GetCurrentSemDetails("PersonalDetails");
            DataTable dt_currentSem_publication = GetCurrentSemDetails("Publication");
            DataTable dt_inst = GetinstpersonalData(userId);
            try
            {
                string status = GetValueOrNull(formData, "status")?.ToString();
                string query = @"
                    UPDATE UserDeclarationDetails 
                    SET cancel_flag = 'Y',last_modified_by = @last_modified_by,last_modified_date = @last_modified_date ,last_modified_host = @last_modified_host  
                    WHERE user_code = @user_code AND cancel_flag = 'N' ;
                    UPDATE UserPersonalDetailsStatus 
                    SET cancel_flag = 'Y',last_modified_by = @last_modified_by,last_modified_date = @last_modified_date ,last_modified_host = @last_modified_host  
                    WHERE user_code = @user_code AND cancel_flag = 'N' 
                    And designation = @designation And user_type = @user_type AND semester_type = @semester_type AND year_semester = @year_semester ;

                    INSERT INTO UserDeclarationDetails (
                    user_code, declarations,signatureName, declarationdate, additionalcomments, status,
                    cancel_flag, created_by, created_date, created_host) 
                    VALUES 
                    (
                    @user_code, @declarations,@signatureName, @declarationdate, @additionalcomments, @status,
                    @cancel_flag, @created_by, @created_date, @created_host
                    );
                    INSERT INTO UserPersonalDetailsStatus (
                    user_code, total_experience, designation, status,user_type,
                    semester_type, year_semester, cancel_flag,created_by, created_date, created_host) 
                    VALUES 
                    (
                    @user_code, @total_experience, @designation, @status,@user_type,
                    @semester_type, @year_semester, @cancel_flag,@created_by, @created_date, @created_host
                    );";


                if (status == "Y")
                {
                    query += @" update ApplicationPersonalDetails set cancel_flag ='Y',last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date ,last_modified_host = @last_modified_host  where cancel_flag ='N' and user_code = @user_code
                    and semester_type = @semester_type and year_semester = @year_semester 

                ;INSERT INTO ApplicationPersonalDetails (
                    user_code, full_name, first_name, middle_name, last_name, dob, 
            place_of_birth, nationality, gender, category_id, mobile_no, 
            alternet_mob_no, emergency_contact_name, emergency_contact_no, 
            user_profile_dtl, edu_work_profile, personal_email_id, 
            alternet_email_id, filename, filepath, semester_type, 
            year_semester, user_type, cancel_flag,created_by, created_date, created_host )
            SELECT 
            user_code, full_name, first_name, middle_name, last_name, dob, 
            place_of_birth, nationality, gender, category_id, mobile_no, 
            alternet_mob_no, emergency_contact_name, emergency_contact_no, 
            user_profile_dtl, edu_work_profile, personal_email_id, 
            alternet_email_id, filename, filepath, 
            @semester_type, @year_semester, @user_type, 'N',@created_by, @created_date, @created_host
            FROM UserPersonalDetails
            WHERE user_code = @user_code  AND cancel_flag = 'N';";


                        query += @" UPDATE upd
            SET 
                upd.profile_photo = src.filename,
                upd.full_name = src.full_name,
                upd.first_name = src.first_name,
                upd.middle_name = src.middle_name,
                upd.last_name = src.last_name,
                upd.dob = src.dob,
                upd.place_of_birth = src.place_of_birth,
                upd.nationality = src.nationality,
                upd.gender = src.gender,
                --upd.special_category = src.special_category,
                upd.mobile_no = src.mobile_no,
                upd.emergency_contact_name = src.emergency_contact_name,
                upd.emergency_contact_2 = src.emergency_contact_no
            FROM user_mst upd
            INNER JOIN UserPersonalDetails src ON upd.User_id = src.user_code
            where user_id = @user_code ";

            query += @" UPDATE faculty_appraisal_research_various_activities_dtl
            SET cancel_flag = 'Y'
            WHERE instructor_code = @user_code
              AND year = @year_code
              AND cancel_flag = 'N';
            INSERT INTO faculty_appraisal_research_various_activities_dtl (
            doc_no,
                instructor_code,
                type,
                sr_no,
                list_the_various_activities,
                role_in_the_activity,
                organisation,
                status,
                StartDate,
                EndDate,
                total_hours,
                year,
                cancel_flag
            )
            SELECT 
            CAST(ROUND((RAND(CHECKSUM(NEWID())) * (999999 - 99)) + 99, 0) AS INT) AS doc_no,
                src.user_code AS instructor_code,
                src.TypeCode AS type,
                src.Sr_no AS sr_no,
                src.various_activity_name AS list_the_various_activities,
                src.Role_in_activity AS role_in_the_activity,
                src.organization AS organisation,
                src.status,
                src.start_date AS StartDate,
                src.end_date AS EndDate,
                src.totalhours AS total_hours,
                src.yearcode AS year,
                src.cancel_flag
            FROM UserVariousActivityDetails src
            WHERE src.user_code = @user_code
              AND src.yearcode = @year_code
              AND src.cancel_flag = 'N'";


            query += @" UPDATE upd
            SET 
                upd.benificiary_name = src.beneficiary_name,
                upd.bank_account_number = src.bank_account_no,
                upd.account_type = src.account_type,
                upd.ifsc_code = src.ifsc_code,
                upd.name_of_bank = src.bank_name,
                upd.Branch_name = src.branch_name
                
            FROM instructor_mst upd
            INNER JOIN UserBankAccountDetails src ON upd.User_id = src.user_code
            where user_id = @user_code";



                    query += @" UPDATE faculty_appraisal_research_conferences_dtl
                                SET cancel_flag = 'Y'
                                WHERE instructor_code = @user_code
                                  AND year = @year_code
                                  AND cancel_flag = 'N';



                        INSERT INTO faculty_appraisal_research_conferences_dtl (
                            doc_no,
                            instructor_code,
                            Type,
                            sr_no,
                            Conferencetype,
                            title,
                            NameOfConference,
                            Authorship,
                            total_hours,
                            submittedToUniversity,
                            year,
                            StartDate,
                            EndDate,
                            cancel_flag
                        )
                        SELECT 
                            CAST(ROUND((RAND(CHECKSUM(NEWID())) * (999999 - 99)) + 99, 0) AS INT) AS doc_no, 
                            usr.user_code AS instructor_code,
                            usr.typeCode AS Type,
                            usr.sr_no AS sr_no,
                            usr.conferenceType AS Conferencetype,
                            usr.title AS title,
                            usr.name_of_conference AS NameOfConference,
                            usr.authorship AS Authorship,
                            usr.total_hours AS total_hours,
                            usr.submitted_university AS submittedToUniversity,
                            usr.yearcode AS year,
                            usr.start_date AS StartDate,
                            usr.end_date AS EndDate,
                            usr.cancel_flag AS cancel_flag
                        FROM UserConferenceDetails usr
                        WHERE usr.user_code = @user_code
                          AND usr.yearcode = @year_code
                          AND usr.cancel_flag = 'N'";



                    query += @" UPDATE faculty_appraisal_research_complete_ongoing_dtl
                                SET cancel_flag = 'Y'
                                WHERE instructor_code = @user_code
                                  AND year = @year_code
                                  AND cancel_flag = 'N';
                                INSERT INTO faculty_appraisal_research_complete_ongoing_dtl (
                                    doc_no,
                                    instructor_code,
                                    sr_no,
                                    title,
                                    funding_agency,
                                    fund_available,
                                    duration,
                                    status,
                                    total_hours,
                                    year,
                                    cancel_flag
                                )
                                SELECT 
                                    CAST(ROUND((RAND(CHECKSUM(NEWID())) * (999999 - 99)) + 99, 0) AS INT) AS doc_no, -- random number between 99–999999
                                    usr.user_code AS instructor_code,
                                    usr.sr_no AS sr_no,
                                    usr.title AS title,
                                    usr.funding_agency AS funding_agency,
                                    usr.funds_available AS fund_available,
                                    usr.duration AS duration,
                                    usr.status AS status,
                                    usr.total_hours AS total_hours,
                                    usr.year_code AS year,
                                    usr.cancel_flag AS cancel_flag
                                FROM UserResearchProjectDetails usr
                                WHERE usr.user_code = @user_code
                                  AND usr.year_code = @year_code
                                  AND usr.cancel_flag = 'N'";

            query += @" update ApplicationUserContact set cancel_flag ='Y',last_modified_by = @last_modified_by,
            last_modified_date = @last_modified_date ,last_modified_host = @last_modified_host  where cancel_flag ='N' and user_code = @user_code
            and semester_type = @semester_type and year_semester = @year_semester 

            ;INSERT INTO ApplicationUserContact (
            user_code,
            permanent_address, address_line_1, address_line_2,
            pcity, pstate, pcountry,
            residing_address, raddress_line_1, raddress_line_2,
            rcity, rstate, rcounty, cancel_flag,semester_type, 
            year_semester, user_type,created_by, created_date, created_host )
            SELECT 
            user_code,
            permanent_address, address_line_1, address_line_2,
            pcity, pstate, pcountry,
            residing_address, raddress_line_1, raddress_line_2,
            rcity, rstate, rcounty,'N', 
            @semester_type, @year_semester, @user_type,@created_by, @created_date, @created_host
            FROM UserContactDetails
            WHERE user_code = @user_code  AND cancel_flag = 'N';";




                                        query += @"
                    UPDATE ApplicationEducationDetails 
                    SET 
                        cancel_flag = 'Y',
                        last_modified_by = @last_modified_by,
                        last_modified_date = @last_modified_date,
                        last_modified_host = @last_modified_host
                    WHERE 
                        cancel_flag = 'N'
                        AND user_code = @user_code;
                    
                    INSERT INTO ApplicationEducationDetails (
                        user_code,
                        program,
                        degree,
                        specialization,
                        university_institute,
                        start_date,
                        end_date,
                        percentage_cgpa,
                        per_division,
                        mode_of_learning,
                        marksheet_grade_file,
                        cancel_flag,
                        created_by,
                        created_date,
                        created_host
                    )
                    SELECT
                        user_code,program,degree,specialization,university_institute,start_date,end_date,percentage_cgpa,per_division,
                        mode_of_learning,marksheet_grade_file,'N',@created_by,@created_date,@created_host
                    FROM 
                        UserEducationDetails
                    WHERE 
                        user_code = @user_code
                        AND cancel_flag = 'N';";

                    query += @"
                     UPDATE ApplicationResearchProjectDetails 
                     SET 
                     cancel_flag = 'Y',
                     last_modified_by = @last_modified_by,
                     last_modified_date = @last_modified_date,
                     last_modified_host = @last_modified_host
                     WHERE 
                     cancel_flag = 'N'
                     AND user_code = @user_code
                     AND user_type = @user_type
                     AND year_code = @year_code;

                     INSERT INTO ApplicationResearchProjectDetails(
                     user_code, typecode, title, description, funding_agency,
                     funds_available, duration, status, start_date, end_date,
                     total_hours, year_code, semester_type, year_semester,
                     user_type, cancel_flag, created_by, created_date, created_host
                     )
                     SELECT
                     user_code, typecode, title, description, funding_agency,
                     funds_available, duration, status, start_date, end_date,
                     total_hours, year_code, @semester_type, @year_semester,
                     @user_type, 'N', @created_by, @created_date, @created_host
                     FROM UserResearchProjectDetails
                     WHERE user_code = @user_code
                     AND year_code = @year_code
                     AND cancel_flag = 'N'; ";


                    query += @"
UPDATE ApplicationOtherDetails 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationOtherDetails (
    user_code,
    title,type_code,
    other_research_activities,
    total_hours,date,year_code,semester_type,year_semester,
    user_type,cancel_flag,created_by,created_date, created_host
)
SELECT
    user_code,title,type_code,other_research_activities,total_hours,date,year_code,
    @semester_type,@year_semester,@user_type,'N',@created_by,@created_date,@created_host
FROM 
    UserOtherDetails
WHERE 
    user_code = @user_code
    
    AND cancel_flag = 'N';";


                    query += @"
UPDATE ApplicationAwardsDetails 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
   
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationAwardsDetails (
    user_code,
    type,
    title,
    description,
    date,
    year_code,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    type,
    title,
    description,
    date,
    year_code,
    @semester_type,
    @year_semester,
    @user_type,'N',@created_by,@created_date,@created_host
FROM 
    UserAwardsDetails
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';";



                    query += @"
UPDATE ApplicationProfessionalTraining 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationProfessionalTraining (
    user_code,
    typeCode,
    title,
    description,
    duration,
    start_date,
    end_date,
    oraganizer,
    no_of_participants,
    certificate,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    typeCode,
    title,
    description,
    duration,
    start_date,
    end_date,
    oraganizer,
    no_of_participants,
    certificate,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserProfessionalTraining
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';";


                    query += @"
UPDATE ApplicationProfessionalAffilition 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationProfessionalAffilition (
    user_code,
    organization_name,
    position_title,
    affiliation_type,
    membership_level,
    start_date,
    end_date,
    membership_number,
    status,
    description,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    organization_name,
    position_title,
    affiliation_type,
    membership_level,
    start_date,
    end_date,
    membership_number,
    status,
    description,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserProfessionalAffilition
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';
";


                    query += @"
UPDATE ApplicationIdentityDetails 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationIdentityDetails (
    user_code,
    Identity_code,
    Identity_number,
    Identity_document,
    Identity_name,
    identity_file_path,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    Identity_code,
    Identity_number,
    Identity_document,
    Identity_name,
    identity_file_path,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserIdentityDetails
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';
";


                    query += @"
UPDATE ApplicationReferenceDocDetails 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationReferenceDocDetails (
    user_code,
    ref_code,
    ref_name,
    ref_file_name,
    ref_file_path,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    ref_code,
    ref_name,
    ref_file_name,
    ref_file_path,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserReferenceDocDetails
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';
";

                    query += @"
UPDATE ApplicationSocialLinkDetails
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationSocialLinkDetails (
    user_code,
    platform,
    displayName,
    url,
    description,
    visibility,
    priority,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    platform,
    displayName,
    url,
    description,
    visibility,
    priority,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserSocialLinkDetails
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';
";


                    query += @"
UPDATE ApplicationDesignationDetails
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationDesignationDetails (
    user_code,
    designation_code,
    user_type,
    dept_code,
    total_experience_years,
    total_experience_months,
    total_experience_total_months,
    total_teaching_years,
    total_teaching_months,
    total_teaching_total_months,
    total_industry_years,
    total_industry_months,
    total_industry_total_months,
    total_research_years,
    total_research_months,
    total_research_total_months,
    semester_type,
    year_semester,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    designation_code,
    @user_type,
    dept_code,
    total_experience_years,
    total_experience_months,
    total_experience_total_months,
    total_teaching_years,
    total_teaching_months,
    total_teaching_total_months,
    total_industry_years,
    total_industry_months,
    total_industry_total_months,
    total_research_years,
    total_research_months,
    total_research_total_months,
    @semester_type,
    @year_semester,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserDesignationDetails
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';";


                    query += @"
UPDATE ApplicationWorkDetails
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationWorkDetails (
    user_code,
    organization_name,
    designation,
    experience_type,
    start_date,
    end_date,
    total_year_in_months,
    mode_of_experience,
    total_hours_in_week,
    total_year_months_counts,
    experienced_document_ref,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    organization_name,
    designation,
    experience_type,
    start_date,
    end_date,
    total_year_in_months,
    mode_of_experience,
    total_hours_in_week,
    total_year_months_counts,
    experienced_document_ref,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserWorkDetails
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';";

                    query += @"
UPDATE ApplicationBankAccountDetails
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationBankAccountDetails (
    user_code,
    beneficiary_name,
    bank_account_no,
    account_type,
    ifsc_code,
    bank_name,
    branch_name,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    beneficiary_name,
    bank_account_no,
    account_type,
    ifsc_code,
    bank_name,
    branch_name,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserBankAccountDetails
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';";

                    query += @"
UPDATE ApplicationAreaofExpertise
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationAreaofExpertise (
    user_code,
    description,
    expertise_area,
    skill_level,
    years_of_experience,
    certification,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    description,
    expertise_area,
    skill_level,
    years_of_experience,
    certification,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserAreaofExpertise
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';";


                    query += @"
UPDATE ApplicationCoursesTaughtDtl
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND seme_type = @seme_type
    AND year_semester = @year_semester;

INSERT INTO ApplicationCoursesTaughtDtl (
    user_code,
    course_code,
    title,
    semester_year,
    semester_type,
    is_active,
    seme_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    course_code,
    title,
    semester_year,
    semester_type,
    is_active,
    @seme_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserCoursesTaughtDtl
WHERE 
    user_code = @user_code
    AND cancel_flag = 'N';
";


                    query += @"
UPDATE ApplicationPublicationDetails 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester
    AND yearcode = @year_code;

INSERT INTO ApplicationPublicationDetails (
    user_code,
    publication_type,
    journal_conference_name,
    title_of_research,
    impact_factor,
    authorship,
    month_of_publication,
    year_of_publication,
    submitted_to_university,
    yearcode,
    total_hours,
    author_details,
    academic_year,
    scope,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    publication_type,
    journal_conference_name,
    title_of_research,
    impact_factor,
    authorship,
    month_of_publication,
    year_of_publication,
    submitted_to_university,
    yearcode,
    total_hours,
    author_details,
    academic_year,
    scope,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserPublicationDetails
WHERE 
    user_code = @user_code
AND yearcode = @year_code
    AND cancel_flag = 'N';";

                    query += @"
UPDATE ApplicationConferenceDetails 
SET 
    cancel_flag = 'Y',
    last_modified_by = @last_modified_by,
    last_modified_date = @last_modified_date,
    last_modified_host = @last_modified_host
WHERE 
    cancel_flag = 'N'
    AND user_code = @user_code
    AND semester_type = @semester_type
    AND year_semester = @year_semester
    AND yearcode = @year_code;

INSERT INTO ApplicationConferenceDetails (
    user_code,
    typeCode,
    conferenceType,
    title,
    name_of_conference,
    authorship,
    total_hours,
    submitted_university,
    yearcode,
    start_date,
    end_date,
    author_details,
    academic_year,
    semester_type,
    year_semester,
    user_type,
    cancel_flag,
    created_by,
    created_date,
    created_host
)
SELECT
    user_code,
    typeCode,
    conferenceType,
    title,
    name_of_conference,
    authorship,
    total_hours,
    submitted_university,
    yearcode,
    start_date,
    end_date,
    author_details,
    academic_year,
    @semester_type,
    @year_semester,
    @user_type,
    'N',
    @created_by,
    @created_date,
    @created_host
FROM 
    UserConferenceDetails
WHERE 
    user_code = @user_code
AND yearcode = @year_code
    AND cancel_flag = 'N';
";

                }

                SqlParameter[] parameters = new SqlParameter[]
                {
                new SqlParameter("@user_code", userId),
                new SqlParameter("@declarations", GetValueOrNull(formData, "declarations")),
                new SqlParameter("@signatureName", GetValueOrNull(formData, "signatureName")),
                new SqlParameter("@declarationdate", GetValueOrNull(formData, "declarationdate")),
                new SqlParameter("@additionalcomments", GetValueOrNull(formData, "additionalcomments")),
                new SqlParameter("@status", GetValueOrNull(formData, "status")),
                new SqlParameter("@user_type", user_type),
                new SqlParameter("@total_experience", dt_table.Rows[0]["TotalMonth"].ToString()),
                new SqlParameter("@designation", dt_inst.Rows[0]["designation"].ToString()),
                new SqlParameter("@semester_type", dt_currentSem.Rows[0]["sem_code"].ToString().Trim()),
                new SqlParameter("@seme_type", dt_currentSem.Rows[0]["sem_code"].ToString().Trim()),
                new SqlParameter("@year_semester", dt_currentSem.Rows[0]["year_code"].ToString()),
                new SqlParameter("@year_code", dt_currentSem_publication.Rows[0]["year_code"].ToString()),
                new SqlParameter("@cancel_flag", "N"),
                new SqlParameter("@created_by", userId),
                new SqlParameter("@created_date", DateTime.Now),
                new SqlParameter("@created_host", host_name),
                new SqlParameter("@last_modified_by", userId),
                new SqlParameter("@last_modified_date", DateTime.Now),
                new SqlParameter("@last_modified_host", host_name)
                };

                return ExecuteNonQuery(query, parameters);
            }
            catch (Exception ex)
            {
                // Log the exception (you may want to use a proper logging framework)
                System.Diagnostics.Debug.WriteLine($"Error in SaveDeclarationDetails: {ex.Message}");
                return false;
            }
        }

        public bool SavePublicationType(List<Dictionary<string, object>> SavePublicationType, string userId, string host_name, string yearcode)
        {
            try
            {
                string query = "";
                for (int i = 0; i < SavePublicationType.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = SavePublicationType[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserPublicationDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N' AND yearcode =@yearcode";
                    }


                    query += @"
    INSERT INTO UserPublicationDetails (
         user_code, publication_type, journal_conference_name, title_of_research, impact_factor,
        authorship, month_of_publication, year_of_publication, submitted_to_university, yearcode,
        total_hours, author_details, academic_year,scope,
        cancel_flag, created_by, created_date, created_host,publication_status
    ) VALUES (
       @user_code, @publication_type, @journal_conference_name, @title_of_research, @impact_factor,
        @authorship, @month_of_publication, @year_of_publication, @submitted_to_university, @yearcode,
        @total_hours, @author_details, @academic_year,@scope,
        @cancel_flag, @created_by, @created_date, @created_host,@publication_status
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                             new SqlParameter("@user_code", userId),
                             new SqlParameter("@publication_type", GetValueOrNull(formData, "publication_type")),
                             new SqlParameter("@journal_conference_name", GetValueOrNull(formData, "journal_conference_name")),
                             new SqlParameter("@title_of_research", GetValueOrNull(formData, "title_of_research")),
                             new SqlParameter("@impact_factor", GetValueOrNull(formData, "impact_factor")),
                             new SqlParameter("@authorship", GetValueOrNull(formData, "authorship")),
                             new SqlParameter("@month_of_publication", GetValueOrNull(formData, "month_of_publication")),
                             new SqlParameter("@year_of_publication", GetValueOrNull(formData, "year_of_publication")),
                             new SqlParameter("@submitted_to_university", GetValueOrNull(formData, "submitted_to_university")),
                             new SqlParameter("@publication_status", GetValueOrNull(formData, "publication_status")),
                             new SqlParameter("@yearcode", yearcode),
                             new SqlParameter("@total_hours", GetValueOrNull(formData, "total_hours")),
                             new SqlParameter("@author_details", GetValueOrNull(formData, "author_details")),
                             new SqlParameter("@academic_year", GetValueOrNull(formData, "academic_year")),
                             new SqlParameter("@scope", GetValueOrNull(formData, "scope")),
                             new SqlParameter("@cancel_flag", "N"),
                             new SqlParameter("@created_by", userId),
                             new SqlParameter("@created_date", DateTime.Now),
                             new SqlParameter("@created_host", host_name),
                             new SqlParameter("@last_modified_by", userId),
                             new SqlParameter("@last_modified_date", DateTime.Now),
                             new SqlParameter("@last_modified_host", host_name)
                             
                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SavePublicationDetails: {ex.Message}");
                return false;
            }
        }



        public bool SaveConferencesDetails(List<Dictionary<string, object>> SaveConferencesDetails, string userId, string host_name, string yearcode)
        {
            try
            {
                string query = "";
                for (int i = 0; i < SaveConferencesDetails.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = SaveConferencesDetails[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserConferenceDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N' AND yearcode ='" + yearcode + @"'";
                    }


                    query += @"
    INSERT INTO UserConferenceDetails (
           user_code, typeCode, conferenceType, title, name_of_conference,
        authorship, total_hours, submitted_university, yearcode, start_date, end_date,
        author_details, academic_year,
        cancel_flag, created_by, created_date
    ) VALUES (
       @user_code, @typeCode, @conferenceType, @title, @name_of_conference,
        @authorship, @total_hours, @submitted_university, @yearcode, @start_date, @end_date,
        @author_details, @academic_year,
        @cancel_flag, @created_by, @created_date
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                             new SqlParameter("@user_code", userId),
    new SqlParameter("@typeCode", GetValueOrNull(formData, "type")),
    new SqlParameter("@conferenceType", GetValueOrNull(formData, "conferenceType")),
    new SqlParameter("@title", GetValueOrNull(formData, "title")),
    new SqlParameter("@name_of_conference", GetValueOrNull(formData, "name_of_conference")),
    new SqlParameter("@authorship", GetValueOrNull(formData, "authorship")),
    new SqlParameter("@total_hours", GetValueOrNull(formData, "total_hours")),
    new SqlParameter("@submitted_university", GetValueOrNull(formData, "submitted_university")),
    new SqlParameter("@yearcode", yearcode),
    new SqlParameter("@start_date", GetValueOrNull(formData, "start_date")),
    new SqlParameter("@end_date", GetValueOrNull(formData, "end_date")),
    new SqlParameter("@author_details", GetValueOrNull(formData, "author_details")),
    new SqlParameter("@academic_year", GetValueOrNull(formData, "academic_year")),
    new SqlParameter("@cancel_flag", "N"),
    new SqlParameter("@created_by", userId),
    new SqlParameter("@created_date", DateTime.Now),
    new SqlParameter("@created_host", host_name),
    new SqlParameter("@last_modified_by", userId),
    new SqlParameter("@last_modified_date", DateTime.Now),
    new SqlParameter("@last_modified_host", host_name)

                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SavePublicationDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveProfessionalAffilitionDetails(List<Dictionary<string, object>> SaveProfessionalAffilition, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < SaveProfessionalAffilition.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = SaveProfessionalAffilition[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserProfessionalAffilition 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
    INSERT INTO UserProfessionalAffilition (
           user_code, organization_name, position_title, affiliation_type,
        membership_level, start_date, end_date, membership_number,
        status, description, cancel_flag,
        created_by, created_date, created_host
    ) VALUES (
       @user_code, @organization_name, @position_title, @affiliation_type,
        @membership_level, @start_date, @end_date, @membership_number,
        @status, @description, @cancel_flag,@created_by, @created_date, @created_host
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                             new SqlParameter("@user_code", userId),
    new SqlParameter("@organization_name", GetValueOrNull(formData, "organization_name")),
    new SqlParameter("@position_title", GetValueOrNull(formData, "position_title")),
    new SqlParameter("@affiliation_type", GetValueOrNull(formData, "affiliation_type")),
    new SqlParameter("@membership_level", GetValueOrNull(formData, "membership_level")),
    new SqlParameter("@start_date", GetValueOrNull(formData, "start_date")),
    new SqlParameter("@end_date", GetValueOrNull(formData, "end_date")),
    new SqlParameter("@membership_number", GetValueOrNull(formData, "membership_number")),
    new SqlParameter("@status", GetValueOrNull(formData, "status")),
    new SqlParameter("@description", GetValueOrNull(formData, "description")),
    new SqlParameter("@cancel_flag", "N"),
    new SqlParameter("@created_by", userId),
    new SqlParameter("@created_date", DateTime.Now),
    new SqlParameter("@created_host", host_name),
    new SqlParameter("@last_modified_by", userId),
    new SqlParameter("@last_modified_date", DateTime.Now),
    new SqlParameter("@last_modified_host", host_name)

                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SavePublicationDetails: {ex.Message}");
                return false;
            }
        }



        public bool SaveOtherDetails(List<Dictionary<string, object>> SaveOtherDetails, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < SaveOtherDetails.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = SaveOtherDetails[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserOtherDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
    INSERT INTO UserOtherDetails (
           user_code, title, type_code, other_research_activities,
        total_hours, date, year_code, cancel_flag,
        created_by, created_date, created_host
    ) VALUES (
       @user_code, @title, @type_code, @other_research_activities,
        @total_hours, @date, @year_code, @cancel_flag,
        @created_by, @created_date, @created_host
    )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                             new SqlParameter("@user_code", userId),
                             new SqlParameter("@title", GetValueOrNull(formData, "title")),
                             new SqlParameter("@type_code", GetValueOrNull(formData, "type_code")),
                             new SqlParameter("@other_research_activities", GetValueOrNull(formData, "other_research_activities")),
                             new SqlParameter("@total_hours", GetValueOrNull(formData, "total_hours")),
                             new SqlParameter("@date", GetValueOrNull(formData, "date")),
                             new SqlParameter("@year_code", GetValueOrNull(formData, "year")),
                             new SqlParameter("@cancel_flag", "N"),
                             new SqlParameter("@created_by", userId),
                             new SqlParameter("@created_date", DateTime.Now),
                             new SqlParameter("@created_host", host_name),
                             new SqlParameter("@last_modified_by", userId),
                             new SqlParameter("@last_modified_date", DateTime.Now),
                             new SqlParameter("@last_modified_host", host_name)

                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SavePublicationDetails: {ex.Message}");
                return false;
            }
        }

        public bool SaveUserResearchProjectDetails(List<Dictionary<string, object>> SaveResearchProjectDetails, string userId, string host_name, string yearcode)
        {
            try
            {
                string query = "";
                for (int i = 0; i < SaveResearchProjectDetails.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = SaveResearchProjectDetails[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserResearchProjectDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N' and year_code =@year_code";
                    }


                    query += @"
                    INSERT INTO UserResearchProjectDetails (
                           user_code, typeCode, title, description,
                        funding_agency, funds_available, duration, status,
                        start_date, end_date, total_hours, year_code,
                        cancel_flag, created_by, created_date, created_host
                   ) VALUES (
                      @user_code, @typeCode, @title, @description,
                       @funding_agency, @funds_available, @duration, @status,
                       @start_date, @end_date, @total_hours, @year_code,
                       @cancel_flag, @created_by, @created_date, @created_host
                   )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                             new SqlParameter("@user_code", userId),
                            new SqlParameter("@typecode", GetValueOrNull(formData, "typecode")),
                            new SqlParameter("@title", GetValueOrNull(formData, "title")),
                            new SqlParameter("@description", GetValueOrNull(formData, "description")),
                            new SqlParameter("@funding_agency", GetValueOrNull(formData, "funding_agency")),
                            new SqlParameter("@funds_available", GetValueOrNull(formData, "funds_available")),
                            new SqlParameter("@duration", GetValueOrNull(formData, "duration")),
                            new SqlParameter("@status", GetValueOrNull(formData, "status")),
                            new SqlParameter("@start_date", GetValueOrNull(formData, "start_date")),
                            new SqlParameter("@end_date", GetValueOrNull(formData, "end_date")),
                            new SqlParameter("@total_hours", GetValueOrNull(formData, "total_hours")),
                            new SqlParameter("@year_code", yearcode),
                            new SqlParameter("@cancel_flag", "N"),
                            new SqlParameter("@created_by", userId),
                            new SqlParameter("@created_date", DateTime.Now),
                            new SqlParameter("@created_host", host_name),
                            new SqlParameter("@last_modified_by", userId),
                            new SqlParameter("@last_modified_date", DateTime.Now),
                            new SqlParameter("@last_modified_host", host_name)

                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                return true; // all records processed successfully
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SavePublicationDetails: {ex.Message}");
                return false;
            }
        }


        public bool SaveDocumentDetails(List<Dictionary<string, object>> documents, List<Dictionary<string, object>> identities, string userId, string host_name)
        {
            try
            {
                string query = "";
                for (int i = 0; i < documents.Count; i++)
                {
                    query = "";
                    Dictionary<string, object> formData = documents[i];
                    if (i == 0)
                    {
                        query = @"
                UPDATE UserReferenceDocDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query += @"
                    INSERT INTO UserReferenceDocDetails (
                           user_code, ref_code, ref_file_name, ref_file_path,ref_name, cancel_flag, created_by, created_date, created_host
                   ) VALUES (
                      @user_code, @ref_code, @ref_file_name, @ref_file_path,@ref_name, @cancel_flag, @created_by, @created_date, @created_host
                   )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                            new SqlParameter("@user_code", userId),
                            new SqlParameter("@ref_code", GetValueOrNull(formData, "documentType")),
                            new SqlParameter("@ref_file_name", GetValueOrNull(formData, "filename")),
                            new SqlParameter("@ref_file_path", GetValueOrNull(formData, "filePath")),
                            new SqlParameter("@ref_name", GetValueOrNull(formData, "documentTypeName")),
                            new SqlParameter("@cancel_flag", "N"),
                            new SqlParameter("@created_by", userId),
                            new SqlParameter("@created_date", DateTime.Now),
                            new SqlParameter("@created_host", host_name),
                            new SqlParameter("@last_modified_by", userId),
                            new SqlParameter("@last_modified_date", DateTime.Now),
                            new SqlParameter("@last_modified_host", host_name)

                        };

                    // execute query for this record
                    ExecuteNonQuery(query, parameters);
                }

                string query_ID = "";
                for (int i = 0; i < identities.Count; i++)
                {
                    query_ID = "";
                    Dictionary<string, object> formData = identities[i];
                    if (i == 0)
                    {
                        query_ID = @"
                UPDATE UserIdentityDetails 
                SET cancel_flag = 'Y',
                    last_modified_by = @last_modified_by,
                    last_modified_date = @last_modified_date,
                    last_modified_host = @last_modified_host
                WHERE user_code = @user_code AND cancel_flag = 'N'";
                    }


                    query_ID += @"
                    INSERT INTO UserIdentityDetails (
                           user_code, Identity_code, Identity_number, Identity_document, Identity_name, 
                           identity_file_path, cancel_flag, created_by, created_date, created_host
                   ) VALUES (
                       @user_code, @Identity_code, @Identity_number, @Identity_document, @Identity_name, 
                       @identity_file_path, @cancel_flag, @created_by, @created_date, @created_host
                   )";

                    SqlParameter[] parameters = new SqlParameter[]
                        {
                             new SqlParameter("@user_code", userId),
                             new SqlParameter("@Identity_code", GetValueOrNull(formData, "identityType")),
                             new SqlParameter("@Identity_number", GetValueOrNull(formData, "identityNumber")),
                             new SqlParameter("@Identity_document", GetValueOrNull(formData, "fileName")),
                             new SqlParameter("@Identity_name", GetValueOrNull(formData, "identityTypeText")),
                             new SqlParameter("@identity_file_path", GetValueOrNull(formData, "filePath")),
                            new SqlParameter("@cancel_flag", "N"),
                            new SqlParameter("@created_by", userId),
                            new SqlParameter("@created_date", DateTime.Now),
                            new SqlParameter("@created_host", host_name),
                            new SqlParameter("@last_modified_by", userId),
                            new SqlParameter("@last_modified_date", DateTime.Now),
                            new SqlParameter("@last_modified_host", host_name)

                        };
                    ExecuteNonQuery(query_ID, parameters);
                }
                return true; 
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in SaveDocumentDetails: {ex.Message}");
                return false;
            }
        }





        /// <summary>
        /// Get personal details for a specific user
        /// </summary>
        /// <param name="userId">User ID</param>
        /// <returns>DataTable with personal details</returns>

        public DataTable GetTotalExpirenceDetails(string userId,string user_type)
        {
            try
            {
                string query = @"
                    SELECT 
                      (CASE WHEN ISNUMERIC(NULLIF(total_teaching_total_months,'')) = 1 THEN CAST(total_teaching_total_months AS INT) ELSE 0 END)
                    + (CASE WHEN ISNUMERIC(NULLIF(total_research_total_months,'')) = 1 THEN CAST(total_research_total_months AS INT) ELSE 0 END)
                    + (CASE WHEN ISNUMERIC(NULLIF(total_industry_total_months,'')) = 1 THEN CAST(total_industry_total_months AS INT) ELSE 0 END)
                    AS TotalMonth, *
                    FROM UserDesignationDetails
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPersonalDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetCurrentSemDetails(string type_desc)
        {
            try
            {
                string query = @"
                    select * from cept_current_semester where cancel_flag ='N' and active_flag = 'Y' and type_desc = @type_desc";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@type_desc", type_desc)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPersonalDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetinstpersonalData(string user_id)
        {
            try
            {
                string query = @"
                    select * from instructor_mst as um 
                        where  um.user_id =@user_id";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_id", user_id)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPersonalDetails: {ex.Message}");
                return null;
            }
        }
        public DataTable GetPersonalDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT 
                        UserPersonalDetails.user_code, Full_name, first_name, middle_name, last_name, dob,
                        place_of_birth, nationality, gender, category_id, mobile_no,
                        alternet_mob_no, emergency_contact_name, emergency_contact_no,
                        user_profile_dtl, edu_work_profile, personal_email_id,
                        alternet_email_id, UserPersonalDetails.cancel_flag, UserPersonalDetails.created_by, 
						UserPersonalDetails.created_date, UserPersonalDetails.created_host,filename,filepath
                    FROM UserPersonalDetails 
                    WHERE UserPersonalDetails.user_code = @user_code AND UserPersonalDetails.cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPersonalDetails: {ex.Message}");
                return null;
            }
        }
        public DataTable GetOfficeLocations(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserOfficelocationDetails 
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPersonalDetails: {ex.Message}");
                return null;
            }
        }
        public DataTable GetContactDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserContactDetails 
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPersonalDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetEducationDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT program,degree,specialization,university_institute as university,start_date,end_date,percentage_cgpa,per_division as percentage_division,mode_of_learning as mode
                    ,marksheet_grade_file as marksheet_file,
                    cancel_flag,created_by,created_date,created_host FROM UserEducationDetails 
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetUserEducationDetails: {ex.Message}");
                return null;
            }
        }



        public DataTable GetExperienceDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserWorkDetails 
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetUserWorkDetails: {ex.Message}");
                return null;
            }
        }


        public DataTable GetBankDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserBankAccountDetails 
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetUserWorkDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetExpertiseDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserAreaofExpertise 
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetUserWorkDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetCourseTaughtDetails(string userId)
        {
            try
            {
                string query = @" SELECT 'Y' as is_active,
                                   cwi.course_code,
                                   cm.course_name AS title,
                                   CASE cwi.semester_type 
                                       WHEN 'S' THEN 'Spring'
                                       WHEN 'M' THEN 'Monsoon'
                                       ELSE 'Winter'
                                   END AS semester_type,
                                   cwi.year_semester AS semester_year
                               FROM course_wise_instructor cwi
                               
                               INNER JOIN course_mst cm 
                                   ON cm.course_code = cwi.course_code
                                  AND cm.semester_type = cwi.semester_type
                                  AND cm.year_semester = cwi.year_semester
                               WHERE cwi.instructor_code = @user_code 
                                 AND cwi.cancel_flag = 'N' 
                                 AND cm.cancel_flag = 'N'
                               AND NOT EXISTS (
        SELECT 1
        FROM UserCoursesTaughtDtl uctd
        WHERE 
            uctd.course_code = cwi.course_code AND uctd.semester_type = cwi.semester_type AND uctd.semester_year = cwi.year_semester
            AND uctd.user_code = cwi.instructor_code AND uctd.is_active = 'N' AND uctd.cancel_flag = 'N' )
                               UNION
                               
                               SELECT  uctd.is_active,
                                   uctd.course_code,
                                   uctd.title,
                                   CASE uctd.semester_type 
                                       WHEN 'S' THEN 'Spring'
                                       WHEN 'M' THEN 'Monsoon'
                                       ELSE 'Winter'
                                   END AS semester_type,
                                   uctd.semester_year
                               FROM UserCoursesTaughtDtl uctd WHERE uctd.user_code = @user_code  AND uctd.cancel_flag = 'N'";


                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetCourseTaughtDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetAwardsDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserAwardsDetails  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetAwardsDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetTrainingProgramsDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserProfessionalTraining  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetTrainingProgramsDetails: {ex.Message}");
                return null;
            }
        }


        public DataTable GetSocialLinks(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserSocialLinkDetails  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetSocialLinks: {ex.Message}");
                return null;
            }
        }

        public DataTable GetDeclarationData(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserDeclarationDetails  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetDeclarationData: {ex.Message}");
                return null;
            }
        }


        public DataTable GetPublicationsDetails(string userId,string yearcode)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserPublicationDetails  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                if (yearcode != "")
                {
                    query += @" AND yearcode = @yearcode ";
                }
                query += @" order by created_date desc ";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId),
                    new SqlParameter("@yearcode", yearcode)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPublicationsDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetPublicationType(string publicationType)
        {
            try
            {
                string query = @"
                    SELECT distinct TypeCode,TypeName FROM faculty_appraisal_Self_Evaluation_type  
                    WHERE GroupTypeName = @publicationType  ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@publicationType", publicationType)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPublicationsDetails: {ex.Message}");
                return null;
            }
        }


        public DataTable GetConferencesDetails(string userId, string yearcode)
        {
            try
            {
                string query = @"
                    SELECT fas.TypeName as type_name,UserConferenceDetails.* FROM UserConferenceDetails 
                    left join faculty_appraisal_Self_Evaluation_type fas on fas.TypeCode = UserConferenceDetails.typeCode
                    and fas.CancelFlag ='N' and fas.Year = UserConferenceDetails.yearcode
                    WHERE user_code = @user_code AND cancel_flag ='N'  ";

                //if (yearcode != "")
                //{
                //    query += @" AND UserConferenceDetails.yearcode = @yearcode ";
                //}
                //SqlParameter[] parameters = new SqlParameter[]
                //{
                //    new SqlParameter("@user_code", userId),
                //    new SqlParameter("@yearcode", yearcode)
                //};

                //return ExecuteSelectQuery(query, parameters);

                List<SqlParameter> parameters = new List<SqlParameter>
                {
                new SqlParameter("@user_code", userId)
                };

                // Add year filter and parameter only if not empty
                if (!string.IsNullOrEmpty(yearcode))
                {
                    query += " AND UserConferenceDetails.yearcode = @yearcode";
                    parameters.Add(new SqlParameter("@yearcode", yearcode));
                }
                query += " order by UserConferenceDetails.sr_no desc";
                return ExecuteSelectQuery(query, parameters.ToArray());
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetConferencesDetails: {ex.Message}");
                return null;
            }
        }


        public DataTable GetAffiliationsDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserProfessionalAffilition  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPublicationsDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetOtherDetails(string userId,string yearcode)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserOtherDetails  
                    WHERE user_code = @user_code AND cancel_flag ='N' And year_code =@year_code ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId),
                    new SqlParameter("@year_code", yearcode)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPublicationsDetails: {ex.Message}");
                return null;
            }
        }


        public DataTable GetResearchProjectDetails(string userId, string yearcode)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserResearchProjectDetails  
                    WHERE user_code = @user_code AND cancel_flag ='N'  ";

                //SqlParameter[] parameters = new SqlParameter[]
                //{
                //    new SqlParameter("@user_code", userId),
                //    new SqlParameter("@year_code", yearcode)
                //};

                //return ExecuteSelectQuery(query, parameters);

                List<SqlParameter> parameters = new List<SqlParameter>
                {
                new SqlParameter("@user_code", userId)
                };

                // Add year filter and parameter only if not empty
                if (!string.IsNullOrEmpty(yearcode))
                {
                    query += " AND year_code = @yearcode";
                    parameters.Add(new SqlParameter("@yearcode", yearcode));
                }
                query += " order by sr_no desc";
                return ExecuteSelectQuery(query, parameters.ToArray());
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetPublicationsDetails: {ex.Message}");
                return null;
            }
        }
        public DataTable GetOtherResearchActivitiesDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserOtherDetails  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetOtherResearchActivitiesDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetDocumentMasterDtl()
        {
            try
            {
                string query = @"
                    SELECT * FROM UserRefDocMaster  
                    WHERE  cancel_flag =@cancel_flag ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@cancel_flag", "N")
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetDocumentMasterDtl: {ex.Message}");
                return null;
            }
        }

        public DataTable GetIdentityMasterDtl()
        {
            try
            {
                string query = @"
                    SELECT * FROM UserIdentityMaster  
                    WHERE  cancel_flag =@cancel_flag ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@cancel_flag", "N")
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetIdentityMasterDtl: {ex.Message}");
                return null;
            }
        }

        public DataTable GetEngagementMasterDtl()
        {
            try
            {
                string query = @"
                    SELECT * FROM UserEngagementMaster  
                    WHERE  cancel_flag =@cancel_flag ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@cancel_flag", "N")
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetEngagementMasterDtl: {ex.Message}");
                return null;
            }
        }
        public DataTable GetDocDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserReferenceDocDetails  
                    WHERE cancel_flag =@cancel_flag AND user_code = @user_code order by sr_no asc";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@cancel_flag", "N"),
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetOtherResearchActivitiesDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetIdentitycDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserIdentityDetails  
                    WHERE cancel_flag =@cancel_flag AND user_code = @user_code order by sr_no asc";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@cancel_flag", "N"),
                     new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetOtherResearchActivitiesDetails: {ex.Message}");
                return null;
            }
        }

        public DataTable GetDesignationMasterDetails()
        {
            try
            {
                string query = @"
                    SELECT * FROM UserDesignationMaster  
                    WHERE cancel_flag =@cancel_flag ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@cancel_flag", "N")
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetDesignationMasterDetails: {ex.Message}");
                return null;
            }
        }


        public DataTable GetDesignationSaveDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserDesignationDetails 
                    WHERE user_code = @user_code AND cancel_flag = 'N'";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in UserDesignationDetails: {ex.Message}");
                return null;
            }
        }


        public DataTable GetCRDFDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserOtherEngagementDtl  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetSocialLinks: {ex.Message}");
                return null;
            }
        }

        public DataTable GetReferenceDetails(string userId)
        {
            try
            {
                string query = @"
                    SELECT * FROM UserReferencesDtl  
                    WHERE user_code = @user_code AND cancel_flag ='N' ";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    new SqlParameter("@user_code", userId)
                };

                return ExecuteSelectQuery(query, parameters);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in GetSocialLinks: {ex.Message}");
                return null;
            }
        }


        public int UpdateCoursesTaughtDetail(string course_code, string semester_year, string semester_type, string is_active,string userId,string host_name)
        {
            string query = @"UPDATE UserCoursesTaughtDtl 
                           SET is_active = @is_active,
                            last_modified_by = @last_modified_by,
                            last_modified_date = @last_modified_date,
                            last_modified_host = @last_modified_host
                           WHERE user_code = @user_code AND cancel_flag = 'N' AND course_code = @course_code AND semester_type = @semester_type 
                           AND semester_year = @semester_year ";

            SqlParameter[] parameters = {
                CreateParameter("@is_active", is_active, SqlDbType.Char,(1)),
                CreateParameter("@course_code", course_code,SqlDbType.NVarChar,50),
                CreateParameter("@semester_type", semester_type,SqlDbType.NVarChar,50),
                CreateParameter("@user_code", userId,SqlDbType.NVarChar,50),
                CreateParameter("@semester_year", semester_year,SqlDbType.NVarChar,50),
                CreateParameter("@last_modified_by", userId,SqlDbType.NVarChar,50),
                CreateParameter("@last_modified_date", DateTime.Now,SqlDbType.DateTime),
                CreateParameter("@last_modified_host", host_name,SqlDbType.NVarChar,50)
                //CreateParameter("@last_modified_by", sr_no, SqlDbType.Int),
                //CreateParameter("@last_modified_date", sr_no, SqlDbType.Int),
                //CreateParameter("@last_modified_host", sr_no, SqlDbType.Int),
            };

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddRange(parameters);
                    connection.Open();
                    return command.ExecuteNonQuery();
                }
            }
        }

        private bool ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters if provided
                        if (parameters != null)
                        {
                            command.Parameters.AddRange(parameters);
                        }

                        connection.Open();
                        int rowsAffected = command.ExecuteNonQuery();
                        return rowsAffected > 0;
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"Error in ExecuteNonQuery: {ex.Message}");
                return false;
            }
        }

        /// <summary>
        /// Gets value from form data or returns NULL if empty/null
        /// </summary>
        /// <param name="formData">Form data dictionary</param>
        /// <param name="key">Key to look for</param>
        /// <returns>Value or DBNull.Value if empty/null</returns>
        private object GetValueOrNull(Dictionary<string, object> formData, string key)
        {
            if (!formData.ContainsKey(key))
                return DBNull.Value;

            object value = formData[key];
            
            if (value == null)
                return DBNull.Value;

            string stringValue = value.ToString().Trim();
            
            if (string.IsNullOrEmpty(stringValue))
                return DBNull.Value;

            return stringValue;
        }

        
    }
}
