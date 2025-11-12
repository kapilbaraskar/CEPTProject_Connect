<%@ WebHandler Language="C#" Class="UploadPayslip" %>
using System;
using System.Web;
using System.Data;
using BLL.Master;

public class UploadPayslip : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{

    int mFileSize = 0;
    string msg = "";
    String fileNames = string.Empty;

    public void ProcessRequest (HttpContext context) 
    {
        try
        {
           // HttpContext.Current.Session["abc"] = "Kamlesh Nada";
            //For Uploading New User Profile Photo
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["UserPayslipPath"];

            if (context.Request.Files.Count > 0)
            {
                var postedFile = context.Request.Files[0];
                string filesize = "1048576";
                mFileSize = postedFile.ContentLength;
                string user_id = HttpContext.Current.Session["UserId"].ToString();

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


                    Masters objmaster = new Masters();
                   
                    DataTable dt_fees_year = objmaster.Get_cept_current_sem_data("fees");
                    string current_fees_sem = "", current_fees_year = "";
                    
                    if (dt_fees_year != null)
                    {
                        //if (dt_fees_year.Rows[0]["sem_desc"] == System.DBNull.Value)
                        //{

                        //}
                        
                        current_fees_sem = dt_fees_year.Rows[0]["sem_desc"].ToString();
                        current_fees_year = dt_fees_year.Rows[0]["year_code"].ToString();
                    }

                    finalFileName = current_fees_sem + "_" + current_fees_year + "_" + user_id + "_" + file;

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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}