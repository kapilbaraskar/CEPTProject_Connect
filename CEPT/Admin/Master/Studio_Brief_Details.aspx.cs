using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Studio_Brief_Details : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_utype.Value = Session["user_type"].ToString();
            user_id_dtl.Value = Session["UserId"].ToString();
            hdn_studio_code.Value = Request.QueryString["studio_code"];
            hdn_c.Value = Request.QueryString["c"];
            hdn_s.Value = Request.QueryString["s"];
            hdn_y.Value = Request.QueryString["y"];
            DataTable user_dt = objmaster.Get_disable_user_detail(HttpContext.Current.Session["UserId"].ToString());
            if (Request.QueryString["studio_code"] != "" && Session["user_type"].ToString() == "I2")
            {
                string studio_code = hdn_studio_code.Value;
                DataTable prev_data = objmaster.getInterestedprevsem_dtl(studio_code, Request.QueryString["s"].ToString(), Request.QueryString["y"].ToString());
                if (prev_data != null)
                {
                    prev_course_code.Value = prev_data.Rows[0]["previous_sem_course_code"].ToString();
                    prev_sem_code.Value = prev_data.Rows[0]["previous_sem_code"].ToString();
                    prev_year_code.Value = prev_data.Rows[0]["previous_year_code"].ToString();
                }
            }
            //if (user_dt == null)
            //{
            //    DataTable dt_instructor_dtl = objmaster.get_instructor_data(Session["UserId"].ToString());
            //    if (dt_instructor_dtl.Rows[0]["ifsc_code"].ToString() == "" || dt_instructor_dtl.Rows[0]["bank_account_number"].ToString() == ""
            //        || dt_instructor_dtl.Rows[0]["account_type"].ToString() == "" || dt_instructor_dtl.Rows[0]["name_of_Bank"].ToString() == ""
            //        || dt_instructor_dtl.Rows[0]["branch_name"].ToString() == "" || dt_instructor_dtl.Rows[0]["benificiary_name"].ToString() == ""
            //        || dt_instructor_dtl.Rows[0]["blood_group"].ToString() == "")
            //    {
            //      
            //        Response.Redirect("~/Admin/Master/Add_bank_detl.aspx?c=" + hdn_c.Value + "&s=" + hdn_s.Value + "&y=" + hdn_y.Value);
            //
            //    }
            //    else
            //    {
            //        
            //            Response.Redirect("~/Admin/Master/Add_bank_detl.aspx?c=" + hdn_c.Value + "&s=" + hdn_s.Value + "&y=" + hdn_y.Value);
            //       
            //        
            //    }
            //}




        }
    }
}