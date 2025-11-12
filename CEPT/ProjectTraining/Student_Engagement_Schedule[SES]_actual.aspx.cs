using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using System.Data;

public partial class ProjectTraining_ProjectTraining : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Masters objmaster = new Masters();
        string current_project_sem = "";
        string current_project_year = "";
        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");
        if (dt_ws_current_sem != null)
        {
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }
        string user_id = Session["UserId"].ToString();
        DataTable event_mst_data = objmaster.check_sjr_submited(current_project_sem, current_project_year, user_id);
        if (event_mst_data != null)
        {
            if (event_mst_data.Rows.Count > 0)
            {
                DataRow row = event_mst_data.Rows[0];
                string is_submit = row["is_submit"].ToString();
                if (is_submit != "Y")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "  redirect('Site Joining Report Not Submitted'); ", true);
                }
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "  redirect('Site Joining Report Not Submitted'); ", true);
        }
    }
}