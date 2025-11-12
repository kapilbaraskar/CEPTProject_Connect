using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Student_Clearance_Status_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["c"] != null)
        {
            hdn_user_id.Value = Request.QueryString["c"].ToString();
            hdnsem.Value = Request.QueryString["s"].ToString();
            hdnyear.Value = Request.QueryString["y"].ToString();

            WebService objser = new WebService();
            var data = objser.get_student_clearance_form_table_dtl_new(Request.QueryString["s"].ToString(), Request.QueryString["y"].ToString(), Request.QueryString["c"].ToString());
            hdndata.Value = data;
        }
        else
        {

        }
    }
}