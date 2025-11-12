using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_personal_detail_sws : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Application["Message"] != null )
            {

                string message = Application["Message"].ToString();
                hdn_message.Value = message;
            }
            Application["Message"] = "";
            hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
            hdn_icode.Value = Request.QueryString["ws"];
            hdn_user_id.Value = Session["UserId"].ToString();
           // hdn_icode_ex.Value = Request.QueryString["ie"];

            if (Session["UserId"] != null && Session["user_type"].ToString() == "I2" || Session["user_type"].ToString() == "A1" || Session["user_type"].ToString() == "PC")
            {
                DataTable dt_instructor_dtl = objmaster.get_instructor_data(Session["UserId"].ToString());
                DataTable dt_instructor_check = objmaster.Get_disable_user_detail(Session["UserId"].ToString());
                if (dt_instructor_check != null)
                {
                    hdn_skip_personaldtl.Value = "true";
                }
                if (dt_instructor_dtl != null)//instructor
                {
                    hdn_designation.Value = dt_instructor_dtl.Rows[0]["designation"].ToString();
                    if (dt_instructor_dtl.Rows[0]["designation"].ToString() == "VF" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "temp" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "instructor" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "TA" || dt_instructor_dtl.Rows[0]["designation"].ToString() == "AA")
                    {
                        if (hdn_icode.Value != Session["UserId"].ToString())
                        {

                            Response.Redirect("~/Admin/Master/Home.aspx?autho=false");
                        }
                        
                        //else
                        //{
                        //    if (hdn_icode_ex.Value != "")
                        //    { hdn_icode.Value = Request.QueryString["ie"]; }
                        //}

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
        }
    }
}