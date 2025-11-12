<%@ WebHandler Language="C#" Class="Instructor_Studio_Proposal" %>

using System;
using System.Web;
public class Instructor_Studio_Proposal : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        WebService objWebService = new WebService();
        try
        {
            string UploadType = String.Empty;
            string Extension = String.Empty;
            string studio_code = String.Empty;

            if (context.Request.Form["UploadType"] != null)
            {
                UploadType = context.Request.Form["UploadType"];
            }

            if (context.Request.Form["Extension"] != null)
            {
                Extension = context.Request.Form["Extension"];
            }

            if (context.Request.Form["studio_code"] != null)
            {
                studio_code = context.Request.Form["studio_code"];
            }

            //For Uploading New User Profile Photo
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["InstructorStudioProposalUploadPath"];

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = string.Empty;

                if (UploadType == "studio_proposal")
                {
                    filesize = System.Configuration.ConfigurationManager.AppSettings["InstructorStudioProposalUploadMaxSize"];
                }
                else if (UploadType == "studio_brief")
                {
                    filesize = System.Configuration.ConfigurationManager.AppSettings["InstructorStudioBriefUploadMaxSize"];
                }

                mFileSize = postedFile.ContentLength;
                string user_id = HttpContext.Current.Session["UserId"].ToString();
                string user_name = HttpContext.Current.Session["first_name"].ToString();
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
                    string[] extension = postedFile.ContentType.Split(new char[] { '/' });

                    finalFileName = studio_code + "_" + user_id + "_" + user_name + "_" + UploadType + "." + Extension;
                    //finalFileName = user_id + "_" + user_name + "_" + UploadType + "." + extension[1];

                    finalFileName = finalFileName.Replace("'", "");

                    string fileDirectory = Savepath + "\\" + finalFileName;
                    postedFile.SaveAs(fileDirectory);

                    bool save = objWebService.submit_studio_proposal(finalFileName, UploadType, studio_code);

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