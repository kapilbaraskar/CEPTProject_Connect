using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Commit_Grade : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnusertype.Value = Session["user_type"].ToString();
    }
}