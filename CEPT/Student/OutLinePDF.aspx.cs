using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_OutLinePDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
            if (Request.QueryString["course_id"] != null)
            {
                hdn_outline.Value = Request.QueryString["course_id"].ToString();

                if (Request.QueryString["new_tab"] != null)
                {
                    hdn_new_tab.Value = Request.QueryString["new_tab"].ToString();
                }

                WebService objser = new WebService();
                var data = objser.Get_OutlinePDF_For_VerticalStudio(Request.QueryString["course_id"].ToString(), Request.QueryString["sem_code"].ToString(), Request.QueryString["year_code"].ToString());
                hdnres.Value = data[0];
                hdnres1.Value = data[1];
                hdn_tutor_profile.Value = data[2];
                portfoliolink.Value = data[3];
                insttimeslot.Value = data[4];
                coursewisetimeslot.Value = data[5];
            }
            else
            {

            }
        

        
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}