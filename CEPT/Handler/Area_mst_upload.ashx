<%@ WebHandler Language="C#" Class="Area_mst_upload" %>

using System;
using System.Web;
using System.Web.UI;

public class Area_mst_upload : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    int mFileSize = 0;
    string msg = string.Empty;
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (context.Request.QueryString["path"] != null && context.Request.QueryString["file"] != null)
            {
                //for deleting existing File by file name
                string Serverpath = context.Request.QueryString["path"].ToString();
                string filename = context.Request.QueryString["file"].ToString();
                Serverpath = Serverpath + "\\" + filename;

                if (System.IO.File.Exists(Serverpath))
                {
                    System.IO.File.Delete(Serverpath);
                }
            }
            else if (context.Request.QueryString["filepath"] != null && context.Request.QueryString["file"] != null)
            {
                //for downloading existing File
                string filepath = context.Request.QueryString["filepath"].ToString();
                string file = context.Request.QueryString["file"].ToString();

                if (System.IO.File.Exists(filepath + "\\" + file))
                {
                    context.Response.Clear();
                    context.Response.ContentType = "application/octet-stream";
                    context.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", file));
                    context.Response.WriteFile(filepath + "\\" + file);
                    context.Response.Flush();
                }

            }
            else
            {
                //for uploading new File
                string Serverpath = System.Configuration.ConfigurationManager.AppSettings["FolderPath"];
                var postedFile = context.Request.Files[0];
                string filesize = System.Configuration.ConfigurationManager.AppSettings["FileSize"];
                mFileSize = postedFile.ContentLength / 1048576;

                if (mFileSize <= Convert.ToInt32(filesize))
                {
                    // Get Server Folder to upload file
                    string Savepath = context.Server.MapPath(Serverpath);
                    string file;

                    //For IE to get file name
                    if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE")
                    {
                        string[] files = postedFile.FileName.Split(new char[] { '\\' });
                        file = files[files.Length - 1];

                    }
                    //For Other Browser to get file name
                    else
                    {
                        string path = DateTime.Today.ToString("yyyy_MM_dd") + DateTime.Now.ToString("_hh_mm_ss_tt_");
                        file = path + "_" + postedFile.FileName;
                    }

                    if (!System.IO.Directory.Exists(Savepath))
                        System.IO.Directory.CreateDirectory(Savepath);

                    string fileDirectory = Savepath + "\\" + file;
                    postedFile.SaveAs(fileDirectory);
                    WebService web = new WebService();

                    string message = web.ExcelFileToDatatable_uplad_area(file, context);

                    ////Set response message
                    //msg = "{";
                    //msg += string.Format("error:'{0}',\n", string.Empty);
                    //msg += string.Format("upfile:'{0}'\n", message);
                    //msg += "}";

                    context.Response.ContentType = "text/html";
                    //context.Response.Write("<script type='text/javascript'>alert('Hello, world');</script>"); 
                    context.Response.Write(message);

                }
            }

        }
        catch (Exception ex)
        {
            //context.Response.Write("Error: " + ex.Message);
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