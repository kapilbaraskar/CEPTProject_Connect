<%@ WebHandler Language="C#" Class="ws_course_wise_attendance_pdf_upload" %>

using System;
using System.Web;

public class ws_course_wise_attendance_pdf_upload : IHttpHandler,System.Web.SessionState.IRequiresSessionState {
    
        int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;
    public void ProcessRequest (HttpContext context) {
       WebService objWebService = new WebService();
        try
        {
            string UploadType = String.Empty;

            if (context.Request.Form["UploadType"] != null)
            {
                UploadType = context.Request.Form["UploadType"];
            }

            //For Uploading New User Profile Photo
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["AttendancePdf"];

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = string.Empty;
                filesize = System.Configuration.ConfigurationManager.AppSettings["AttendancePdfUploadMaxSize"];

                mFileSize = postedFile.ContentLength;
                string user_id = HttpContext.Current.Session["UserId"].ToString();
                string user_name = HttpContext.Current.Session["UserName"].ToString();
                string course_code = context.Request.Form["course_code"].ToString();
                string sem_code = context.Request.Form["semester_type"].ToString();
                string year_code = context.Request.Form["year_code"].ToString();

                if(sem_code =="S")
                {
                    sem_code = "Summer";
                }
                else 
                    {
                        sem_code = "Winter";
                    }
                user_name = user_name.Replace(" ", "_");
                if (mFileSize <= Convert.ToInt32(filesize))
                {
                    //Get Server Folder to upload file        
                    string Savepath = context.Server.MapPath(Serverpath);
                    string file;
                    string finalFileName;

                    //For IE to get file name
                    if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                    {
                        string[] files = postedFile.FileName.Split(new char[] { '\\' });
                        file = files[files.Length - 1];
                    }
                    //For Other Browser to get file name
                    else
                    {
                        file = postedFile.FileName;
                    }
                    string [] extension = postedFile.ContentType.Split(new char[] {'/' });

                    finalFileName = course_code + "_" + sem_code + "_" + year_code + "." + extension[1];

                    finalFileName = finalFileName.Replace("'", "");

                    string fileDirectory = Savepath + "\\" + finalFileName;
                    postedFile.SaveAs(fileDirectory);

                    bool save = objWebService.ws_course_wise_save_attendance_doc(finalFileName, UploadType,context);

                    fileNames += finalFileName + ",";
                }
                else
                {
                    msg = "{";
                    msg += string.Format("error:'{0}',\n", "File Size Exeeds Limit.");
                    msg += "}";
                }
            }

            if (fileNames != string.Empty)
            {
                //Set response message
                msg = "{";
                msg += string.Format("error:'{0}',\n", string.Empty);
                msg += string.Format("upfile:'{0}'\n", fileNames.Substring(0, fileNames.Length - 1));
                msg += "}";
            }

            context.Response.Write(msg);
        }
        catch (Exception ex)
        {
            context.Response.Write("error: " + ex.Message);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}