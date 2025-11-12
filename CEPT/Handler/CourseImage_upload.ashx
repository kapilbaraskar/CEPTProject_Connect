<%@ WebHandler Language="C#" Class="CourseImage_upload" %>

using System;
using System.Web;

public class CourseImage_upload : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            //For Uploading Course Image
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["CourseImageUploadPath"];

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["CourseImageUploadMaxSize"];
                mFileSize = postedFile.ContentLength;
                string user_id = HttpContext.Current.Session["UserId"].ToString();
                string action = context.Request.Form["action"].ToString();
                string image_name = context.Request.Form["image_name"].ToString();

                if (postedFile != null && postedFile.ContentLength > 0)
                {
                    System.IO.Stream fileStream = postedFile.InputStream;
                    fileStream.Position = 0;

                    byte[] fileContents = new byte[postedFile.ContentLength];
                    fileStream.Read(fileContents, 0, postedFile.ContentLength);

                    System.Drawing.Image image = System.Drawing.Image.FromStream(new System.IO.MemoryStream(fileContents));
                    //image.Height.ToString();

                    //if (image.Width == 720 && image.Height == 540)
                    if (image.Height == 600)
                    {
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

                            //finalFileName = user_id + "_" + file;
                            finalFileName = image_name;

                            finalFileName = finalFileName.Replace("'", "");

                            string fileDirectory = Savepath + "\\" + finalFileName;
                            if (action == "save") 
                                postedFile.SaveAs(fileDirectory);

                            fileNames += finalFileName + ",";
                        }
                        else
                        {
                            msg = "{";
                            msg += string.Format("error:'{0}',\n", "File Size Exeeds Limit");
                            msg += "}";
                        }
                    }
                    else
                    {
                        msg = "{";
                        msg += string.Format("error:'{0}',\n", "The image height must be 600px Please resize and upload");
                        msg += "}";
                    }
                }
                else
                {
                    msg = "{";
                    msg += string.Format("error:'{0}',\n", "File not found");
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