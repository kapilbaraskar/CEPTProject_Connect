using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_RateBandDtl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/InstructorCVUpload/Document.zip");
            Response.ContentType = "application/xls";
            Response.AppendHeader("Content-Disposition", "attachment; filename=Document.zip");
            Response.TransmitFile(path);
            Response.Flush();
            Response.End();
        }
        catch (Exception ex)
        { throw; }
    }
}