<%@ WebHandler Language="C#" Class="Drp_Topic_Brief_Doc" %>

using System;
using System.Web;

public class Drp_Topic_Brief_Doc : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string UploadType = String.Empty;
            string Course_Code = String.Empty;

            if (context.Request.Form["UploadType"] != null)
            {
                UploadType = context.Request.Form["UploadType"];
            }

            if (context.Request.Form["Course_Code"] != null)
            {
                Course_Code = context.Request.Form["Course_Code"];
            }

            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["DRPTopicPDF"];

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = string.Empty;

                if (UploadType == "drp_brief")
                {
                    filesize = System.Configuration.ConfigurationManager.AppSettings["DRPTopicBriefDocs"];
                }

                mFileSize = postedFile.ContentLength;

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
                    string new_Course_Code = Course_Code.Substring(0, 3);
                    if(new_Course_Code == "DRP")
                    {
                          finalFileName = Course_Code + '_' + file;
                    }
                    else 
                        {
                            finalFileName = file;//Course_Code + "_DRP_Topic_" +
                        }
                    

                    //finalFileName = user_id + "_" + user_name + "_" + UploadType + "." + extension[1];

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