using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_studio_proposal_authorize_tb : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    { 

    }

    protected void btnDownloadcv_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/InstructorCVUpload/" + hdn_file_name.Value);
            if (File.Exists(path))
            {
                string ext = Path.GetExtension(path).Replace(".", "");
                Response.ContentType = "application/" + ext + "";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + hdn_file_name.Value);
                Response.TransmitFile(path);
                Response.Flush();
                Response.End();
            }

        }
        catch (Exception ex)
        {
            //    throw;
        }

    }

    protected void btnDownloadportfolio_Click(object sender, EventArgs e)
    {
        try
        {

            string path = Server.MapPath("~/InstructorPortfolioUpload/" + hdn_file_name.Value);
            if (File.Exists(path))
            {
                string ext = Path.GetExtension(path).Replace(".", "");
                Response.ContentType = "application/" + ext + "";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + hdn_file_name.Value);
                Response.TransmitFile(path);
                Response.Flush();
                Response.End();
            }

        }
        catch (Exception ex)
        {
            //    throw;
        }
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