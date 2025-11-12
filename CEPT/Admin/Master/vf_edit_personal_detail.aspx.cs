using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using System.Data;

public partial class Admin_Master_vf_edit_personal_detail : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
            hdn_icode.Value = Request.QueryString["ic"];
            hdn_icode_ex.Value = Request.QueryString["ie"];
            
            

            if (Session["UserId"] != null && Session["user_type"].ToString() == "I2" || Session["user_type"].ToString() == "A1" || Session["user_type"].ToString() == "PC")
            {
                DataTable dt_instructor_dtl = objmaster.get_instructor_data(Session["UserId"].ToString());


                if (dt_instructor_dtl != null)//instructor
                {
                    if (dt_instructor_dtl.Rows[0]["designation"].ToString() == "VF" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "temp" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "instructor" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "TA" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "AA")
                    {
                        DataTable dt_studio_dtl = objmaster.GetInstructorStudioProposalApprovedDetails(Session["UserId"].ToString());
                        if (dt_studio_dtl != null)
                        {
                            studio_submit_dtl.Value = dt_studio_dtl.Rows[0]["approved"].ToString();
                        }

                        DataTable dt_workload_dtl = objmaster.GetInstructorWorkDetailsDetails(Session["UserId"].ToString());
                        if (dt_workload_dtl != null)
                        {
                            inst_work_load_dtl.Value = dt_workload_dtl.Rows[0]["uso_hr_approved"].ToString();
                        }

                        if (hdn_icode.Value != Session["UserId"].ToString() && hdn_icode_ex.Value != Session["UserId"].ToString())
                        {

                            Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
                        }
                        else
                        {
                            if (hdn_icode_ex.Value != "")
                            {
                                hdn_icode.Value = Request.QueryString["ie"];
                            }
                        }

                    }
                    else
                    {
                        Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
                    }
                }
                else
                {
                    if (Session["user_type"].ToString() == "A1" || Session["user_type"].ToString() == "PC")
                    {
                    }
                    else
                    {
                        Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
                    }
                }
            }
            else if (Session["user_type"].ToString() == "FA")
            {
                DataTable dt_workload_dtl = objmaster.GetInstructorWorkDetailsDetails(hdn_icode.Value);
                if (dt_workload_dtl != null)
                {
                    inst_work_load_dtl.Value = dt_workload_dtl.Rows[0]["uso_hr_approved"].ToString();
                }
            }
        }
    }
}