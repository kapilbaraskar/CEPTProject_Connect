using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Thesis : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["user_type"].ToString() != "S")
        {
            Response.Redirect("~/Student/Dashboard.aspx");
        }
        else
        {
            string student_code = HttpContext.Current.Session["UserId"].ToString();
            hdn_stud_code.Value = student_code;
        }
    }
}