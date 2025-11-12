using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_medical_fitness_certificate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        hdn_stud_code.Value = Request.QueryString["id"].ToString();

    }
}