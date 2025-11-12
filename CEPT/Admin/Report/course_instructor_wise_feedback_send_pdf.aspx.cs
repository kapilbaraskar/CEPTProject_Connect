using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report_course_instructor_wise_feedback_send_pdf : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    //protected void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string myFileName = filename.Value;
    //        string finalerPfad = Server.MapPath("~/FeedbackPdf/") + myFileName;
    //        string fileLength;
    //        FileInfo myFileInfo = new FileInfo(Server.MapPath("~/FeedbackPdf/") + filename.Value);
    //        fileLength = myFileInfo.Length.ToString();



    //        //Response.Clear();
    //        //Response.ClearHeaders();
    //        //Response.ClearContent();
    //        //Response.AddHeader("Content-Disposition", "inline; filename=" + myFileName + "target =_blank");
    //        //Response.AddHeader("Content-Length", myFileInfo.Length.ToString());
    //        //Response.ContentType = "application/pdf";
    //        //Response.Flush();
    //        //Response.TransmitFile(finalerPfad);
    //        //Response.End();




    //        //string path = @"/FeedbackPdf/";

    //        //Response.Clear();
    //        //Response.AddHeader("Accept-Ranges", "ascii");
    //        //Response.AddHeader("Content-Length", fileLength);
    //        //Response.AddHeader("Cache-Control", "post-check=0, pre-check=0");
    //        //Response.ContentType = "application/pdf";
    //        //Response.AddHeader("Content-Disposition", "inline; filename=\"" + myFileName + "\"");
    //        //Response.AddHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    //        //Response.AddHeader("Pragma", "no-cache");

    //        //Response.Flush();
    //        //Response.WriteFile(finalerPfad);
    //        //Response.End();
    //    }
    //    catch(Exception ex)
    //    {

    //    }

    //}
}