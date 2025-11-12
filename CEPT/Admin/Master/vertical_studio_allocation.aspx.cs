using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using BLL.Master;

public partial class Admin_Master_vertical_studio_allocation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Masters objMaster = new Masters();

        DataTable dtCurrentSem = objMaster.Get_cept_current_sem_data("all");

        string i_code = HttpContext.Current.Session["UserId"].ToString();

        if (dtCurrentSem != null)
        {
            if (Session["UserId"] != null)
            {
                DataTable dtInstData = objMaster.GetInstructorData(i_code, dtCurrentSem.Rows[0]["sem_code"].ToString(), dtCurrentSem.Rows[0]["year_code"].ToString());

                if (dtInstData == null)
                {
                    Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
                }
                //hdn_user_type.Value = Session["designation"].ToString();
                //if (Session["designation"].ToString() == "TA")
                //{
                //    Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
                //}
            }
        }
    }
}