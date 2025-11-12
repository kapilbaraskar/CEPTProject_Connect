    [WebMethod(EnableSession = true)]
    public string SavePersonalDetails(string formDataJson)
    {
        try
        {
            var user_id = HttpContext.Current.Session["UserId"].ToString();
            var user_type = HttpContext.Current.Session["user_type"].ToString();
            string host_name = HttpContext.Current.Request.UserHostName;

            // Parse JSON string to dictionary
            Dictionary<string, object> formData = new Dictionary<string, object>();
            
            if (!string.IsNullOrEmpty(formDataJson))
            {
                // Parse JSON to dictionary
                var jsonObject = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, object>>(formDataJson);
                if (jsonObject != null)
                {
                    formData = jsonObject;
                }
            }

            // Call the BLL method to save personal details
            bool result = personalDetails.SavePersonalDetails(formData, user_id);

            if (result)
            {
                return GetJson1(new { 
                    success = true, 
                    message = "Personal details saved successfully",
                    error = (string)null
                });
            }
            else
            {
                return GetJson1(new { 
                    success = false, 
                    message = "Failed to save personal details",
                    error = "Database operation failed"
                });
            }
        }
        catch (Exception ex)
        {
            // Log the exception
            System.Diagnostics.Debug.WriteLine($"Error in SavePersonalDetails: {ex.Message}");
            
            return GetJson1(new { 
                success = false, 
                message = "An error occurred while saving personal details",
                error = ex.Message 
            });
        }
    }

    // Helper method to convert object to JSON string
    private string GetJson1(object obj)
    {
        return Newtonsoft.Json.JsonConvert.SerializeObject(obj);
    }

    [WebMethod(EnableSession = true)]
    public string GetPersonalDetails()
    {
        try
        {
            var user_id = HttpContext.Current.Session["UserId"].ToString();
            var user_type = HttpContext.Current.Session["user_type"].ToString();
            string host_name = HttpContext.Current.Request.UserHostName;

            DataTable personalDetailsData = personalDetails.GetPersonalDetails(user_id);
            
            if (personalDetailsData != null && personalDetailsData.Rows.Count > 0)
            {
                return GetJson1(new { 
                    success = true, 
                    message = "Personal details retrieved successfully",
                    data = personalDetailsData,
                    error = (string)null
                });
            }
            else
            {
                return GetJson1(new { 
                    success = false, 
                    message = "No personal details found",
                    error = "No data available for this user"
                });
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"Error in GetPersonalDetails: {ex.Message}");
            return GetJson1(new { 
                success = false, 
                message = "An error occurred while retrieving personal details",
                error = ex.Message 
            });
        }
    }
