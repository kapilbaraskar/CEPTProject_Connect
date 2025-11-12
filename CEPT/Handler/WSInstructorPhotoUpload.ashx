<%@ WebHandler Language="C#" Class="WSInstructorPhotoUpload" %>

using System;
using System.Web;
using System.Drawing;

public class WSInstructorPhotoUpload : IHttpHandler,System.Web.SessionState.IRequiresSessionState {

    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            //For Uploading New User Profile Photo
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["WSInstructorPhotoPath"];

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["WSInstructorPhotoMaxSize"];
                mFileSize = postedFile.ContentLength;
                string user_id = HttpContext.Current.Session["UserId"].ToString();

                /////////////////
                
                //Image img = Image.FromStream(new System.IO.MemoryStream(postedFile.InputStream));
                
                //HttpPostedFile pfile = null;
                //pfile = context.Request.Files[0];

                if (postedFile != null && postedFile.ContentLength > 0)
                {
                    System.IO.Stream fileStream = postedFile.InputStream;
                    fileStream.Position = 0;

                    byte[] fileContents = new byte[postedFile.ContentLength];
                    fileStream.Read(fileContents, 0, postedFile.ContentLength);

                    System.Drawing.Image image = System.Drawing.Image.FromStream(new System.IO.MemoryStream(fileContents));
                    //image.Height.ToString();



                    if (image.Width == 200 && image.Height == 240)
                    {
                        ///////////////

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

                            finalFileName = "WS_" + context.Request.QueryString["filename"].ToString();

                            finalFileName = finalFileName.Replace("'", "");

                            string fileDirectory = Savepath + "\\" + finalFileName;
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
                        msg += string.Format("error:'{0}',\n", "The image dimension is not 200px X 240px Please resize and upload");
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