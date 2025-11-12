using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Outlinepdfdownload : System.Web.UI.Page
{
    string[] data;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["course_id"] != null)
        {
            hdn_outline.Value = Request.QueryString["course_id"].ToString();

            if (Request.QueryString["new_tab"] != null)
            {
                hdn_new_tab.Value = Request.QueryString["new_tab"].ToString();
            }
            string course_code = Request.QueryString["course_id"].ToString();
            string[] code = course_code.Split(',');
            string status = "N";

            WebService objser = new WebService();
            data = objser.Get_OutlinePDF_For_VerticalStudio_new(Request.QueryString["course_id"].ToString(), Request.QueryString["sem_code"].ToString(), Request.QueryString["year_code"].ToString(), status);
            hdnres.Value = data[0];
            hdnres1.Value = data[1];
            hdn_tutor_profile.Value = data[2];
            portfoliolink.Value = data[3];
        }
        else
        {

        }
    }
}