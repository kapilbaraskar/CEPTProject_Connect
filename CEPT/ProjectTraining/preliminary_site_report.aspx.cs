using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Ionic.Zip;
using BLL.Master;
using System.Data;
using iTextSharp.text.pdf;
using iTextSharp.text;


public partial class ProjectTraining_ProjectTraining : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

    
    }

    protected void save_comment(Object sender, EventArgs e) {

        Masters objmaster = new Masters();
        string current_project_sem = "";
        string current_project_year = "";

        string comment = txt_area_comments.Value;

        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");
        if (dt_ws_current_sem != null)
        {
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }
        string user_id = Request.QueryString["user_id"];

        String event_mst_data = objmaster.update_psr(user_id, comment);

    
    }
}