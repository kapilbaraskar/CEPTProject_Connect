<%@ WebHandler Language="C#" Class="Instructor_photo_upload" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class Instructor_photo_upload : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {

    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string user_id = HttpContext.Current.Session["UserId"].ToString();

            if (HttpContext.Current.Request.UrlReferrer.ToString().Contains("vf_edit_personal_detail.aspx") || HttpContext.Current.Request.UrlReferrer.ToString().Contains("frm_instructor_mst.aspx")
                    || HttpContext.Current.Request.UrlReferrer.ToString().Contains("UpdateInstructorDetail.aspx") )
            {
                user_id = context.Request.Form["icode"].ToString();
            }
            
            //For Uploading New User Profile Photo
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["UserPersonalPhotoPath"];

            string instructor_name = context.Request.Form["name"].ToString();

            string CPOP_Serverpath = System.Configuration.ConfigurationManager.AppSettings["UserCPOPProfilePhotoPath"];
            //WebService obj = new WebService();

            //obj.HelloWorld();

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["UserCPOPProfilePhotoMaxSize"];
                mFileSize = postedFile.ContentLength;
                //string user_id = HttpContext.Current.Session["UserId"].ToString();

                if (mFileSize <= Convert.ToInt32(filesize))
                {
                    System.Drawing.Image img = System.Drawing.Image.FromStream(postedFile.InputStream);

                    if (img.Width == 175 && img.Height == 172)
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
                        finalFileName = "profile_" + user_id + ".jpg";

                        finalFileName = finalFileName.Replace("'", "");

                        string fileDirectory = Savepath + "\\" + finalFileName;
                        postedFile.SaveAs(fileDirectory);

                        if (HttpContext.Current.Request.UrlReferrer.ToString().Contains("frm_edit_personal_details.aspx"))
                        {
                            string CPOP_fileDirectory = CPOP_Serverpath + "\\" + finalFileName;
                            postedFile.SaveAs(CPOP_fileDirectory);
                        }

                        if (context.Request.Form["designation"] != null)
                        {
                            if (context.Request.Form["designation"].ToString() == "instructor")
                            {
                                string CPOP_fileDirectory = CPOP_Serverpath + "\\" + finalFileName;
                                postedFile.SaveAs(CPOP_fileDirectory);
                            }
                        }

                        fileNames += finalFileName + ",";
                    }
                    else
                    {
                        msg = "{";
                        msg += string.Format("error:'{0}',\n", "Image Size should be 175px*172px.");
                        msg += "}";
                    }
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
        get { throw new NotImplementedException(); }
    }
}