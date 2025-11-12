using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DDay.iCal;
using System.Net;

public partial class Admin_Master_MyCalander : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //string a = Session.SessionID.ToString();

        //Session.RemoveAll();

        //string b = Session.SessionID.ToString();
        try
        {

            //WebClient client = new WebClient();

            //// Download string. 
            //string value = client.DownloadString("https://connect.cept.ac.in/");
            //byte[] arr = client.DownloadData("https://connect.cept.ac.in/");


            //string Serverpath = System.Configuration.ConfigurationManager.AppSettings["FolderPath"];
            //string Savepath = Server.MapPath(Serverpath);


            //if (!System.IO.Directory.Exists(Savepath))
            //    System.IO.Directory.CreateDirectory(Savepath);

            ////if (System.IO.File.Exists(Savepath + "\\" + Session["UserId"].ToString() + ".ics"))
            ////{
                
            ////}

            //WebClient webClient = new WebClient();                                                          // Creates a webclient
            //webClient.DownloadFile("https://www.google.com/calendar/ical/call2kamlesh2007%40gmail.com/public/basic.ics", @"" + Savepath + "\\" + Session["UserId"].ToString() + ".ics");
           
        }
        catch (Exception ex)
        {

            throw;
        }

        if (Session["UserId"] != null)
        {
            if (Session["UserId"].ToString() != "178" && Session["UserId"].ToString() != "2" && Session["UserId"].ToString() != "308")
            {
                Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            }
        }
    }
}