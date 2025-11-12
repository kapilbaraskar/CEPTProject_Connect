using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Faculty_apprisal_dtl : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    DataTable check_cpop_user = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {

            
            DataTable dt = objmaster.get_apprisal_start_year();
            show_hdn_year.Value = dt.Rows[0]["from_year"].ToString().Trim() + "-" + dt.Rows[0]["to_year"].ToString().Trim();
            if (Request.QueryString["c"] != null && Request.QueryString["c"] != "")
            {
                hdn_user_id.Value = Request.QueryString["c"].ToString();
                hdn_year.Value = Request.QueryString["y"].ToString();
            }
            if (Session["UserId"].ToString() == "I1920001697")
            {
                Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            }
            if (hdn_user_id.Value != "")
            {
                check_cpop_user = objmaster.get_cpop_user_mst_dtl(Request.QueryString["c"].ToString());
            }
            else { check_cpop_user = objmaster.get_cpop_user_mst_dtl(Session["UserId"].ToString()); }
            

            if (check_cpop_user == null)
            {
                Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            }
        }
        
        
    }
}