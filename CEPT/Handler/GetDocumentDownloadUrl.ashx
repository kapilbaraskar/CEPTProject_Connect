<%@ WebHandler Language="C#" Class="GetDocumentDownloadUrl" %>

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using Newtonsoft.Json;

public class GetDocumentDownloadUrl : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        try
        {
            string fileName = context.Request["fileName"];
            string folderName = context.Request["folderName"];

            if (string.IsNullOrWhiteSpace(fileName))
            {
                WriteError(context, "File name is required.");
                return;
            }

            if (context.Session == null || context.Session["UserId"] == null)
            {
                WriteError(context, "User session has expired. Please log in again.");
                return;
            }

            string safeFileName = Path.GetFileName(fileName);
            if (string.IsNullOrWhiteSpace(safeFileName))
            {
                WriteError(context, "Invalid file name provided.");
                return;
            }

            string uploadsRoot = context.Server.MapPath("~/UserUploadDocumnet/");
            if (string.IsNullOrWhiteSpace(uploadsRoot) || !Directory.Exists(uploadsRoot))
            {
                WriteError(context, "Upload directory not found on the server.");
                return;
            }

            var safeSegments = new List<string>();
            if (!string.IsNullOrWhiteSpace(folderName))
            {
                var segments = folderName.Split(new[] { '/', '\\' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (var segment in segments)
                {
                    var trimmed = segment.Trim();
                    if (string.IsNullOrEmpty(trimmed) || trimmed.Contains(".."))
                    {
                        continue;
                    }
                    safeSegments.Add(trimmed);
                }
            }

            string targetFolderPath = uploadsRoot;
            foreach (var segment in safeSegments)
            {
                targetFolderPath = Path.Combine(targetFolderPath, segment);
            }

            if (!Directory.Exists(targetFolderPath))
            {
                WriteError(context, "Document folder not found on the server.");
                return;
            }

            string fullFilePath = Path.Combine(targetFolderPath, safeFileName);
            if (!File.Exists(fullFilePath))
            {
                WriteError(context, "The requested document could not be located.");
                return;
            }

            string virtualPath = "~/UserUploadDocumnet/";
            if (safeSegments.Count > 0)
            {
                virtualPath = virtualPath.TrimEnd('/') + "/" + string.Join("/", safeSegments);
            }
            virtualPath = virtualPath.TrimEnd('/') + "/" + safeFileName;

            string downloadUrl = VirtualPathUtility.ToAbsolute(virtualPath);

            WriteSuccess(context, downloadUrl);
        }
        catch (Exception ex)
        {
            WriteError(context, ex.Message);
        }
    }

    public bool IsReusable
    {
        get { return false; }
    }

    private static void WriteError(HttpContext context, string errorMessage)
    {
        var response = new
        {
            success = false,
            error = errorMessage
        };

        context.Response.Write(JsonConvert.SerializeObject(response));
    }

    private static void WriteSuccess(HttpContext context, string downloadUrl)
    {
        var response = new
        {
            success = true,
            downloadUrl = downloadUrl
        };

        context.Response.Write(JsonConvert.SerializeObject(response));
    }
}

