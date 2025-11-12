using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Studio_Proposal_dtl : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
            hdn_user_type.Value = Session["user_type"].ToString();
            hdn_designation_type.Value = Session["designation"].ToString();
        }

    }
    protected void btnDownloadvideo_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/StudioDetails/" + hdn_file_name.Value);
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
}