using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;

/// <summary>
/// Summary description for ClientInformation
/// </summary>
namespace Utilities
{
    public enum LoginType
    {
        SalesMan,
        Party
    }

    public class ClientInformation
    {
        public ClientInformation()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        private static DateTime ServerDateTime;
        //Get today's date
        public static DateTime Today
        {
            get
            {
                return ServerDateTime;
            }
            set
            {
                ServerDateTime = value;
            }
        }
        //Get your user IP
        public static string GetHostIP()
        {
            //get the ip address of this machine
            IPHostEntry hostInfo = Dns.GetHostEntry(Dns.GetHostName());
            // Get the IP address list that resolves to the host names  					
            IPAddress[] address = hostInfo.AddressList;
            return address[0].ToString();
        }

        public static string GetHostName()
        {
            return Dns.GetHostName();
        }
    }
}