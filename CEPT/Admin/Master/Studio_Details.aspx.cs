using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Studio_Details : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
        if (Session["user_type"].ToString() != "I2" && Session["user_type"].ToString() != "PC")
        {
            Response.Redirect("~/Admin/Master/Home.aspx");
        }
        if (Session["superviser_code"].ToString() == "")
        {
            //if (Session["is_submit"].ToString() == "N")
            //{
            //    Response.Redirect("~/Admin/Master/Home.aspx");
            //}
        }
    }

    //protected void hid_but_Click(object sender, EventArgs e)
    //{
    //ProcessStartInfo startinfo = new ProcessStartInfo();
    //startinfo.FileName = @"C:\\Users\\admin\\source\\repos\\Google Drive Upload Video\\bin\\Debug\\netcoreapp3.1\\Google Drive Upload Video.exe";
    ////startinfo.Arguments = hdn_file_path.Value;
    ////startinfo.Arguments = hdn_file_path.Value;
    ////startinfo.CreateNoWindow = true;
    //startinfo.UseShellExecute = true;
    //Process myProcess = Process.Start(startinfo);
    //myProcess.Start();
    ////myProcess.Kill();
    // }

    //protected void Button1_Click(object sender, EventArgs e)
    //{        //C:\CT3005- 2021 Monsoon with Audio Low.mp4
        //string inputfilename = "";//FileUpload1.FileName;
        ////string inputfile = "C://" + inputfilename;
        //string inputfile = "C://CT3005- 2021 Monsoon with Audio Low.mp4";

        ////string outputfile = "C://inetpub//wwwroot//CEPTREG//StudioDetails//CT3005_2021_Monsoon";
        //string outputfile = "BonafideCertificate//CT3005- 2021 Monsoon with Audio Low.mp4";
        //string fileargs = "-i" + inputfile + "-ar 22050" + outputfile;
        //Process proc;
        //proc = new Process();
        //proc.StartInfo.FileName = Server.MapPath(outputfile) + "\\ffmpeg\\bin\\ffmpeg.exe";
        //proc.StartInfo.Arguments = fileargs;
        //proc.StartInfo.UseShellExecute = false;
        //proc.StartInfo.CreateNoWindow = false;
        //proc.StartInfo.RedirectStandardInput = false;

        //try
        //{
            //proc.Start();
        //}
        //catch (Exception ex)
        //{
            //Response.Write(ex.Message);
        //}

    //}
}