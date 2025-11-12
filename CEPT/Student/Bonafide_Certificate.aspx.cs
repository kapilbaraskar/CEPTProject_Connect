using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Bonafide_Certificate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_type"].ToString() != "S")
        {
            Response.Redirect("~/Student/Dashboard.aspx");
        }
        else
        {
            string student_code = HttpContext.Current.Session["UserId"].ToString();
            hdn_stud_code.Value = student_code;
            hdn_sr_no.Value = Request.QueryString["c"];
        }
    }
    protected void btnDownloadvideo_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/BonafideCertificate/" + hdn_file_name.Value + ".pdf");
            if (File.Exists(path))
            {
                string ext = Path.GetExtension(path).Replace(".", "");
                Response.ContentType = "application/" + ext + "";
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + hdn_file_name.Value + ".pdf");
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