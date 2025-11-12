using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Admin_Master_ws_coursemaster_add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            hdn_utype.Value = Session["user_type"].ToString();
            hdn_course_code.Value = Request.QueryString["c"];
            hdn_sem.Value = Request.QueryString["s"];
            hdn_year.Value = Request.QueryString["y"];
            hdn_sws.Value = Request.QueryString["sws"];
            hdnuserid.Value = Session["UserID"].ToString();

            if (Session["UserID"] != null && (Session["user_type"].ToString() == "I2" || Session["user_type"].ToString() == "PC" || Session["user_type"].ToString() == "D" ))
            {
                if (hdn_course_code.Value != "" && hdn_sem.Value != "" && hdn_year.Value != "")
                {
                }
                else if (Session["UserID"].ToString() != "temp_student")
                {
                    BLL.Master.Masters objmst = new BLL.Master.Masters();

                    DataTable dt_cur_sem = objmst.Get_cept_current_sem_data("ws_course");

                    if (dt_cur_sem != null)
                    {
                        DataTable dt_all_course_int = objmst.Get_ws_courseproposal_inst_data(dt_cur_sem.Rows[0]["sem_code"].ToString(), dt_cur_sem.Rows[0]["year_code"].ToString());
                        DataTable dt_all_course = objmst.Get_ws_courseproposal_data(dt_cur_sem.Rows[0]["sem_code"].ToString(), dt_cur_sem.Rows[0]["year_code"].ToString());
                        DataTable apply_multiple_course = objmst.Get_ws_apply_multiple_course(Session["UserId"].ToString(),dt_cur_sem.Rows[0]["sem_code"].ToString(), dt_cur_sem.Rows[0]["year_code"].ToString());
                        DataTable dt_instructor_check = objmst.Get_disable_user_detail(Session["UserId"].ToString());
                        if (dt_all_course != null)
                        {
                            DataRow[] dr = dt_all_course.Select("created_by='" + Session["UserID"].ToString() + "' and cancel_flag='N'");
                            if (apply_multiple_course != null)
                            {
                               // Response.Redirect("~/Admin/Master/ws_coursemaster_add.aspx");

                            }
                            else if (dr.Length > 0)
                            {
                                if (dr[0]["instructor_approved"].ToString() == "N" && Session["user_type"].ToString() == "I2")
                                {
                                    Response.Redirect("~/Admin/Master/ws_coursemaster_add.aspx?c=" + dr[0]["course_code"].ToString() + "&s=" + dr[0]["semester_type"].ToString() + "&y=" + dr[0]["year_semester"].ToString() + "");

                                }
                                else if (dt_all_course_int != null)
                                {
                                    DataRow[] dr_rows = dt_all_course_int.Select("instructor_code='" + Session["UserID"].ToString() + "' and cancel_flag='N'");
                                    if (dr_rows.Length > 0)
                                    {
                                        
                                        if (Session["user_type"].ToString() == "I2")
                                        {
                                            Application["Message"] = "You have already Inculding This Course ("+ dr_rows[0]["course_code"].ToString()+ ")";
                                            Response.Redirect("~/Admin/Master/personal_detail_sws.aspx?ws=" + Session["UserID"].ToString() + "&message=temp");
                                        }
                                    }
                                    
                                }
                                else 
                                {
                                    //    Response.Redirect("~/Admin/Master/WS_Course_Dashboard.aspx?iel=true");
                                    if (Session["user_type"].ToString() == "I2")
                                    {
                                       
                                        Response.Redirect("~/Admin/Master/personal_detail_sws.aspx?ws=" + Session["UserID"].ToString() + "");
                                    }
                                    
                                }
                               
                                //if (Session["user_type"].ToString() != "PC" && Session["user_type"].ToString() != "D") 
                                //{ 
                                //    Response.Redirect("~/Admin/Master/personal_detail_sws.aspx?ws=" + Session["UserID"].ToString() + "");
                                //}
                                    
                            }
                            else if (dt_all_course_int != null)
                            {
                                DataRow[] dr_rows = dt_all_course_int.Select("instructor_code='" + Session["UserID"].ToString() + "' and cancel_flag='N'");
                                if (dr_rows.Length > 0)
                                {

                                    if (Session["user_type"].ToString() == "I2")
                                    {
                                        Application["Message"] = "You have already Inculding This Course (" + dr_rows[0]["course_code"].ToString() + ")";
                                        Response.Redirect("~/Admin/Master/personal_detail_sws.aspx?ws=" + Session["UserID"].ToString());
                                    }
                                }
                                else 
                                { 
                                    //Response.Redirect("~/Admin/Master/ws_coursemaster_add.aspx");
                                }

                            }
                            else
                            {
                                if (Session["user_type"].ToString() != "PC" && Session["user_type"].ToString() != "D")
                                {
                                    DataTable inst_details = objmst.get_instructor_dtl(Session["UserID"].ToString());
                                    if (inst_details != null)
                                    {
                                        //DataRow[] dr_inst = inst_details.Select("is_submit='Y'");
                                        //if (dr_inst.Length == 0)
                                        //{
                                            if (inst_details.Rows[0]["designation"].ToString() == "VF" || inst_details.Rows[0]["designation"].ToString() == "temp" || inst_details.Rows[0]["designation"].ToString() == "instructor" || inst_details.Rows[0]["designation"].ToString() == "TA" || inst_details.Rows[0]["designation"].ToString() == "AA")
                                            {
                                                if (hdn_sws.Value != "true")
                                                {
                                                    Response.Redirect("~/Admin/Master/personal_detail_sws.aspx?ws=" + Session["UserID"].ToString() + "");
                                                }
                                                
                                            }
                                           // else
                                           // {
                                           //     Response.Redirect("~/Admin/Master/frm_personal_details.aspx");
                                           // }
                                        //}
                                        //else
                                        //{
                                        //    
                                        //}
                                    }
                                }
                               
                            }
                        }
                        else if (dt_instructor_check != null)
                        {
                            //Response.Redirect("~/Admin/Master/ws_coursemaster_add.aspx");
                        }
                    }
                    else
                    {
                        Response.Redirect("~/Admin/Master/WS_Course_Dashboard.aspx");
                    }
                }
            }
        }
    }
}