<%@ WebHandler Language="C#" Class="UserUploadFile" %>

using System;
using System.Web;
using System.IO;

public class UserUploadFile : IHttpHandler, System.Web.SessionState.IRequiresSessionState  {
    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;
    String fileNamesPath = string.Empty;
    public void ProcessRequest (HttpContext context) {
        try
        {
           
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["UserUploadDocumnet"];
                string baseVirtualPath = "~/UserUploadDocumnet/";
                string serverBasePath = context.Server.MapPath(baseVirtualPath);
                string user_id = HttpContext.Current.Session["UserId"].ToString();
            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["UserUploadDocumnetMaxSize"];
                mFileSize = postedFile.ContentLength;
                string uploadGradeDoc = "";

                if (context.Request.Form["documentType"] != null)
                {
                    uploadGradeDoc = context.Request.Form["documentType"].ToString();
                    //string folderPath = context.Server.MapPath("~/UserUploadDocumnet/" + uploadGradeDoc);
                    string folderPath = Path.Combine(serverBasePath, uploadGradeDoc);
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                        Serverpath = "";
                        Serverpath = folderPath;
                    }
                    else
                    {
                        Serverpath = "";
                        Serverpath = folderPath;
                    }
                }



                if (mFileSize <= Convert.ToInt32(filesize))
                {
                    //Get Server Folder to upload file        
                    //string Savepath = context.Server.MapPath(Serverpath);
                    string Savepath = Serverpath;
                    string file;
                    string finalFileName;
                    string timestamp = DateTime.Now.ToString("yyyyMMdd_HHmmssfff");


                    //For IE to get file name
                    if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                    {
                        string[] files = postedFile.FileName.Split(new char[] { '\\' });
                        file = files[files.Length - 1];
                    }
                    else
                    {
                        file = postedFile.FileName;
                    }
                    string[] extension = postedFile.ContentType.Split(new char[] { '/' });
                    finalFileName = user_id + "_" + timestamp + "." + extension[1];
                    finalFileName = finalFileName.Replace("'", "");

                    string fileDirectory = Savepath + "\\" + finalFileName;
                    postedFile.SaveAs(fileDirectory);

                    fileNames += finalFileName + ",";
                    fileNamesPath += fileDirectory.Replace(@"\", @"\\") ;
                        
                }
                else
                {
                    msg = "{";
                    msg += string.Format("\"error\":\"{0}\",", "File Size Exeeds Limit.");
                    msg += string.Format("\"upfile\":\"{0}\",", fileNames.Substring(0, fileNames.Length - 1));
                    msg += string.Format("\"upfilePath\":\"{0}\"", fileNamesPath.Substring(0, fileNamesPath.Length - 1));
                    msg += "}";
                }
            }

            if (fileNames != string.Empty)
            {
                msg = "{";
                msg += string.Format("\"error\":\"{0}\",", string.Empty);
                msg += string.Format("\"upfile\":\"{0}\",", fileNames.Substring(0, fileNames.Length - 1));
               msg += string.Format("\"upfilePath\":\"{0}\"", fileNamesPath);
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