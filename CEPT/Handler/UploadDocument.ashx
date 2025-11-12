<%@ WebHandler Language="C#" Class="UploadDocument" %>

using System;
using System.Web;
using BLL.Master;
using System.Data;
using System.IO;

public class UploadDocument : IHttpHandler
{

    int mFileSize = 0;
    string msg = string.Empty;
    String fileNames = string.Empty;

    Masters objMaster = new Masters();

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string Serverpath = System.Configuration.ConfigurationManager.AppSettings["ClearanceDocPath"];
            string UploadType = String.Empty;

            if (context.Request.Form["UploadType"] != null)
            {
                UploadType = context.Request.Form["UploadType"];
            }

            var postedFile = context.Request.Files[0];

            DataTable clearance_form_current_sem_detail = objMaster.get_current_clearance_form_semester();

            string user_id = context.Request.Form["UserId"];
            string sem = clearance_form_current_sem_detail.Rows[0]["sem_code"].ToString();
            string year = clearance_form_current_sem_detail.Rows[0]["year_code"].ToString();

            //Get Server Folder to upload file        
            string Savepath = context.Server.MapPath(Serverpath);
            string file;
            string finalFileName;
            string diff_finalFileName = "";

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

            finalFileName = user_id + "_" + sem + "_" + year + "_" + UploadType + ".pdf";

            Savepath = Savepath + "\\" + user_id + "_" + sem + "_" + year;

            if (!Directory.Exists(Savepath))
            {
                Directory.CreateDirectory(Savepath);
            }

            string fileDirectory = Savepath + "\\" + finalFileName;
            postedFile.SaveAs(fileDirectory);

            if (UploadType == "INDEMNITYBOND")
            {
                diff_finalFileName = user_id + "_" + sem + "_" + year + "_ReceiptOfDeposit.pdf";
            }
            else if (UploadType == "ReceiptOfDeposit")
            {
                diff_finalFileName = user_id + "_" + sem + "_" + year + "_INDEMNITYBOND.pdf";
            }

            if (File.Exists(Path.Combine(Savepath, diff_finalFileName)))
            {
                // If file found, delete it    
                File.Delete(Path.Combine(Savepath, diff_finalFileName));
                Console.WriteLine("File deleted.");
            }
            else Console.WriteLine("File not found");

            fileNames += finalFileName + ",";

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