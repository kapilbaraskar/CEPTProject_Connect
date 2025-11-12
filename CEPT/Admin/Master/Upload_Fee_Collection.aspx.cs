using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

public partial class Admin_Master_Upload_Fee_Collection : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        JavaScriptSerializer ser = new JavaScriptSerializer();
        Dictionary<string, object> sessionData = new Dictionary<string, object>();
        foreach (string key in Session.Keys)
        {
            sessionData[key] = Session[key];
        }

        hdn_session.Value = ser.Serialize(sessionData);
    }
}