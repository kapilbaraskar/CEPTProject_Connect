using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using System.Data;


public partial class Admin_frm_personal_details : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_OnInit(object sender, EventArgs e)
    {

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {
            hdn_page_per.Value = Request.QueryString["ie"];
            //DataTable dt_check_rights = objmaster.get_personal_details_rights(Session["UserId"].ToString());

            //if (dt_check_rights == null)
            //{
            //    //Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            //}

            //if (Session["UserId"].ToString() != "178" && Session["UserId"].ToString() != "23" && Session["UserId"].ToString() != "47" && Session["UserId"].ToString() != "140" && Session["UserId"].ToString() != "33" && Session["UserId"].ToString() != "243")
            //{
            //    //Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
            //}
            DataTable dt_instructor_dtl = objmaster.get_instructor_data(Session["UserId"].ToString());
            if (dt_instructor_dtl != null)
            {
                hdn_user_type.Value = dt_instructor_dtl.Rows[0]["designation"].ToString();
            }

            if (Session["user_type"].ToString() == "I2")
            {
                hdn_user_id.Value = Session["UserId"].ToString();
                  

                if (dt_instructor_dtl != null)
                {
                    if (dt_instructor_dtl.Rows[0]["designation"].ToString() == "VF" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "temp")
                    {
                        if (hdn_page_per.Value != "")
                        {
                            Response.Redirect("~/Admin/Master/vf_edit_personal_detail.aspx?ie=" + Session["UserId"].ToString());

                        }
                        else
                        {
                            Response.Redirect("~/Admin/Master/vf_edit_personal_detail.aspx?ic=" + Session["UserId"].ToString());
                        }

                    }
                }
            }

            bool personal_dtl_flag = false;

            switch (Session["user_type"].ToString())
            {
                case "FA": personal_dtl_flag = true; break;
            }

            if (personal_dtl_flag)
            {
                Response.Redirect("~/Admin/Master/FA_frm_personal_deatil.aspx");
            }
        }
    }

}