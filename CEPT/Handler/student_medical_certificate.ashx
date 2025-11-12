<%@ WebHandler Language="C#" Class="student_medical_certificate" %>

using System;
using System.Web;

public class student_medical_certificate : IHttpHandler , System.Web.SessionState.IRequiresSessionState
{
    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;
    string Serverpath_medical;
    string Serverpath;
    string type;

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            //For Uploading New User Profile Photo


            if (context.Request.Files.Count > 0)
            {
                if (context.Request.Form["LNAME"] == "medical")
                { Serverpath_medical = System.Configuration.ConfigurationManager.AppSettings["MedicalCertificatePath"]; }
                else { Serverpath = System.Configuration.ConfigurationManager.AppSettings["AntiraggingPath"]; }


                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["MedicalAntiraggingMaxSize"];
                mFileSize = postedFile.ContentLength;
                string user_id = "";
                string user_name = "";

                if (context.Request.Form["ICODE"] != null)
                {
                    user_id = context.Request.Form["ICODE"].ToString();
                }

                if (context.Request.Form["FNAME"] != null && context.Request.Form["LNAME"] != null)
                {
                    string str = Guid.NewGuid().ToString("N").Substring(0, 2);
                    user_name = context.Request.Form["FNAME"].ToString() + str;
                    user_name = user_name.Replace(" ", "_").ToString();
                }

                if (mFileSize <= Convert.ToInt32(filesize))
                {
                    //Get Server Folder to upload file 
                    string Savepath;
                    if (context.Request.Form["LNAME"] == "medical")
                    {
                        Savepath = context.Server.MapPath(Serverpath_medical);//
                    }
                    else { Savepath = context.Server.MapPath(Serverpath); }

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
                    // finalFileName = user_id + "_" + file;
                    if (context.Request.Form["LNAME"] == "medical")
                    {
                        finalFileName = user_id + "_" + user_name + "." + extension[1];
                        type = "M";
                    }
                    else { finalFileName = user_id + "_" + user_name + "." + extension[1]; type = "A"; }

                    finalFileName = finalFileName.Replace("'", "");
                    if (!System.IO.Directory.Exists(Savepath))
                        System.IO.Directory.CreateDirectory(Savepath);

                    string fileDirectory = Savepath + "\\" + finalFileName;
                    postedFile.SaveAs(fileDirectory);

                    fileNames += finalFileName + ",";
                    //WebService web = new WebService();

                    //string message = web.MedicalCertificate_upload_dtl(finalFileName, user_id,type);
                    //context.Response.ContentType = "text/html"; 
                    //context.Response.Write(message);
                }
                else
                {
                    msg = "{";
                    msg += string.Format("error:'{0}',\n", "File Size Exeeds Limit.");
                    msg += "}";
                    //context.Response.Write(msg);
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