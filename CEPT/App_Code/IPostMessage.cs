using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for IPostMessage
/// </summary>
public interface IPostMessage
{
    string MessageTitle
    {
        get;
        set;
    }
    string MessageDescription
    {
        get;
        set;
    }
    string BackButtonPage
    {
        get;
        set;
    }
}