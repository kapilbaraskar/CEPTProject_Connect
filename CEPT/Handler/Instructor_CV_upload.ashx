<%@ WebHandler Language="C#" Class="Instructor_CV_upload" %>

using System;
using System.Web;

public class Instructor_CV_upload : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            //For Uploading New User Profile Photo
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["InstructorCVUploadPath"];

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["InstructorCVUploadMaxSize"];
                mFileSize = postedFile.ContentLength;
                string user_id = "";
                string user_name = "";
                
                if (context.Request.Form["ICODE"] != null)
                {
                    user_id = context.Request.Form["ICODE"].ToString();
                }

                if (context.Request.Form["FNAME"] != null && context.Request.Form["LNAME"] != null)
                {        
                    user_name = context.Request.Form["FNAME"].ToString() + "_" + context.Request.Form["LNAME"].ToString();
                }

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
                    // finalFileName = user_id + "_" + file;
                    finalFileName = user_id + "_" + user_name + "_CV" + "." + extension[1];
                    finalFileName = finalFileName.Replace("'", "");

                    string fileDirectory = Savepath + "\\" + finalFileName;
                    postedFile.SaveAs(fileDirectory);

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

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}