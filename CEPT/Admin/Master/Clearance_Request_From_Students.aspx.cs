using Ionic.Zip;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Clearance_Request_From_Students : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    #region Download All User Document as Zip Folder
    protected void btnDownloadDocuments_Click(object sender, EventArgs e)
    {
        try
        {
            JavaScriptSerializer ser = new JavaScriptSerializer();
            Dictionary<string, object> dicParam = ser.Deserialize<Dictionary<string, object>>(hfDocuments.Value);
            string user_id = dicParam["uid"].ToString();
            string sem = dicParam["s"].ToString();
            string year = dicParam["y"].ToString();

            string foldername = user_id + '_' + sem + '_' + year;

            string[] filenames;

            string path = Server.MapPath("~/ClearanceDocs/" + foldername);

            if (Directory.Exists(path))
            {
                filenames = Directory.GetFiles(path);
            }
            else
            {
                filenames = null;
            }

            if (filenames != null)
            {
                using (ZipFile zip = new ZipFile())
                {
                    for (int i = 0; i < filenames.Length; i++)
                    {
                        bool flag = false;
                        string[] str_filename = filenames[i].Split('\\');

                        for (int j = 0; j < i; j++)
                        {
                            if (filenames[j].ToUpper().Contains(str_filename[str_filename.Length - 1].ToUpper()))
                            {
                                flag = true;
                            }
                        }

                        if (!flag)
                        {
                            zip.AddFile(filenames[i], "Files");
                        }
                    }

                    //zip.AddFiles(filenames, "files");
                    zip.Save(Server.MapPath("~/ClearanceDocs/" + foldername + ".zip"));
                    path = Server.MapPath("~/ClearanceDocs/" + foldername + ".zip");

                    Response.ContentType = "application/zip";
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + foldername + ".zip");
                    Response.TransmitFile(path);
                }

                FileInfo file = new FileInfo(path);
                if (file.Exists)
                {
                    Response.Flush();
                    file.Delete();
                    Response.End();
                }
            }
        }
        catch (Exception Ex)
        {
            throw;
        }
    }
    #endregion
}