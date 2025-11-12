<%@ WebHandler Language="C#" Class="student_upload_id_proof" %>

using System;
using System.Web;

public class student_upload_id_proof : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;
    string Serverpath_fees;
    string Serverpath;
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            //For Uploading New User Profile Photo


            if (context.Request.Files.Count > 0)
            {
                if (context.Request.Form["LNAME"] == "feesslip")
                { Serverpath_fees = System.Configuration.ConfigurationManager.AppSettings["FeesSlip"]; }
                else { Serverpath = System.Configuration.ConfigurationManager.AppSettings["BonafideIdProofPath"]; }


                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["BonafideIdProofMaxSize"];
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
                    //user_name = context.Request.Form["FNAME"].ToString() + "_" + context.Request.Form["LNAME"].ToString();
                    user_name = context.Request.Form["FNAME"].ToString() + str;
                    user_name = user_name.Replace(" ", "_").ToString();
                }

                if (mFileSize <= Convert.ToInt32(filesize))
                {
                    //Get Server Folder to upload file 
                    string Savepath;
                    if (context.Request.Form["LNAME"] == "feesslip")
                    {
                        Savepath = context.Server.MapPath(Serverpath_fees);//
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
                    if (context.Request.Form["LNAME"] == "feesslip")
                    {
                        finalFileName = user_id + "_" + user_name + "_FEESSLIP" + "." + extension[1];
                    }
                    else { finalFileName = user_id + "_" + user_name + "_IDPROOF" + "." + extension[1]; }

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