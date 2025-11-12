<%@ WebHandler Language="C#" Class="ApprisalFileUpload" %>

using System;
using System.Web;
using System.IO;

public class ApprisalFileUpload : IHttpHandler,System.Web.SessionState.IReadOnlySessionState {

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";

        HttpPostedFile file = context.Request.Files["uploadedFile"];

        if (file != null && file.ContentLength > 0)
        {
            string uploadFolder = context.Server.MapPath("~/ApprisalFileUploads/");
            if (!Directory.Exists(uploadFolder))
            {
                Directory.CreateDirectory(uploadFolder);
            }

            string fileName = Path.GetFileName(file.FileName);
            string filePath = Path.Combine(uploadFolder, fileName);
            file.SaveAs(filePath);

            // Return relative URL for download
            string downloadUrl = "/ApprisalFileUploads/" + fileName;
            context.Response.Write(downloadUrl);
        }
        else
        {
            context.Response.StatusCode = 400;
            context.Response.Write("No file received.");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}