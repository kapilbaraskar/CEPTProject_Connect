using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PersonalDetails : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null) 
        {
            hdnuserid.Value = Session["UserId"].ToString(); ;
            hdnusertype.Value = Session["user_type"].ToString();
            hdnuserprog.Value = Session["prog_code"].ToString();
            hdnusername.Value = Session["UserName"].ToString();
        }    
        
    }
}
