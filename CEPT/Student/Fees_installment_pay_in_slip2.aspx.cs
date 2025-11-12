using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Fees_installment_pay_in_slip2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["UserId"] = Request.QueryString["user_id"].ToString();
        Session["user_type"] = Request.QueryString["user_type"].ToString();
        Session["gender"] = Request.QueryString["gender"].ToString();
        Session["semester_code"] = Request.QueryString["semester_code"].ToString();
    }
}