using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Verify_Grade_Student_Wise_ : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_ss.Value = Request.QueryString["StudentID"];
        hdn_s.Value = Request.QueryString["Sem"];
        hdn_y.Value = Request.QueryString["Year"];
        hdnusertype.Value = Session["user_type"].ToString();
    }
}