using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_frm_upload_installment_payslip : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
     //   Response.Redirect("~/Student/Dashboard.aspx");

        if (Session["UserId"] != null)
        {
            if (Session["prog_code"].ToString() == "1" && Session["year_code"].ToString() == "Y2016")
            {
               // Response.Redirect("~/Student/Dashboard.aspx");
            }
            else
            {
                //Response.Redirect("~/Student/Dashboard.aspx");
            }
        }
    }
}