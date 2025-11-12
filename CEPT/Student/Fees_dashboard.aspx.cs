using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class Student_Fees_dashboard : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Redirect("~/Student/Dashboard.aspx");

        string closed = "";
        if (!IsPostBack)
        {
            try
            {
                if (Session["UserId"].ToString() != "")
                {
                    //payment_open.Style.Clear();
                    //payment_open.Style.Add("display", "block");

                    //if (Session["dept_code"].ToString() != "5")
                    //{
                    //    payment_open.Style.Clear();
                    //    payment_open.Style.Add("display","block");
                    //}
                    //else
                    //{
                    //    payment_closed.Style.Clear();
                    //    payment_closed.Style.Add("display", "block");
                    //}

                    if (Session["user_type"].ToString() == "E")
                    {
                        Response.Redirect("~/Student_WS/Dashboard.aspx");
                    }

                    string current_ws_sem = "";
                    string current_ws_year = "";

                    DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("all");

                    if (dt_ws_current_sem != null)
                    {
                        current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                        current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
                    }

                    //dt_ws_current_sem = objmaster.Get_cept_current_sem_data("feedback");

                    //if (dt_ws_current_sem != null)
                    //{
                    //    current_feedback_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                    //    current_feedback_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
                    //}

                    //dt_ws_current_sem = objmaster.Get_cept_current_sem_data("fees");

                    //if (dt_ws_current_sem != null)
                    //{
                    //    current_fees_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                    //    current_fees_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
                    //}

                    try
                    {
                        if (HttpContext.Current.Session["user_dept"] != null)
                        {
                            if (HttpContext.Current.Session["user_dept"].ToString() == "F")
                            {
                                dt_ws_current_sem = objmaster.Get_cept_current_sem_data("forenstudent");

                                if (dt_ws_current_sem != null)
                                {
                                    current_ws_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                                    current_ws_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
                                }
                            }
                        }
                    }
                    catch
                    {
                    }

                    DataTable dt_fees_open_flag = objmaster.Get_cept_current_sem_data("open_fees_for_all");

                    if (dt_fees_open_flag == null)
                    {
                        DataTable dt_fees_open_or_close = objmaster.get_fees_open_or_close_for_student(Session["UserId"].ToString(), current_ws_sem, current_ws_year);

                        if (dt_fees_open_or_close != null)
                        {
                            closed = "Open";
                        }
                        else
                        {
                            closed = "";
                        }
                    }
                    else
                    {
                        closed = "Open";
                    }

                    if (closed == "")
                    {
                        Response.Redirect("~/Student/Dashboard.aspx", false);
                    }

                    if (Session["year_code"].ToString() == "Y2016")
                    {
                        //if (Session["prog_code"].ToString() == "2")
                        //{
                        //    Response.Redirect("~/Student/Dashboard.aspx", false);
                        //}
                    }
                    else
                    {
                        if (Session["user_dept"].ToString() != "F")
                        {
                          //  Response.Redirect("~/Student/Dashboard.aspx", false);
                        }
                    }

                    if (Session["prog_code"].ToString() == "3")
                    {
                        //if (Session["UserId"].ToString() == "DP 1512")
                        //{
                        //}
                        //else
                        //{
                            //Response.Redirect("~/Student/Dashboard.aspx", false);
                        //}
                    }
                    else
                    {
                        ////if (Session["UserId"].ToString() != "PA101515")
                        ////{

                        //Response.Redirect("~/Student/Dashboard.aspx", false);
                        
                        ////}
                    }

                    string mail = objmaster.Get_user_mail(Session["UserId"].ToString());

                    if (mail != "")
                    {
                        DataTable dt_multipel_email = objmaster.Get_multiple_same_email_user(mail);

                        if (dt_multipel_email != null)
                        {
                            if (dt_multipel_email.Rows.Count > 1)
                            {
                                string url = "~/student/select_program.aspx";
                                Response.Redirect(url, false);
                            }
                        }
                    }
                }

                if (Session["year_code"].ToString() != "")
                {
                    string flag = objmaster.get_user_fees_selection_rights(Session["year_code"].ToString());

                    if (flag != "")
                    {
                        if (flag == "Y")
                        {
                            popup_selection.Style.Clear();
                            popup_selection.Style.Add("display", "block");

                            new_popup_selection.Style.Clear();
                            new_popup_selection.Style.Add("display", "none");
                        }
                        else
                        {
                            popup_selection.Style.Clear();
                            popup_selection.Style.Add("display", "none");

                            new_popup_selection.Style.Clear();
                            new_popup_selection.Style.Add("display", "block");
                        }
                    }
                    else
                    {
                        popup_selection.Style.Clear();
                        popup_selection.Style.Add("display", "block");

                        new_popup_selection.Style.Clear();
                        new_popup_selection.Style.Add("display", "none");
                    }
                }
                else
                {
                    popup_selection.Style.Clear();
                    popup_selection.Style.Add("display", "block");

                    new_popup_selection.Style.Clear();
                    new_popup_selection.Style.Add("display", "none");
                }

                if (Session["user_dept"].ToString() != "F")
                {
                    if (Session["gender"].ToString() == "" || Session["agree_afidavite"].ToString() == "")
                    {
                        //Response.Redirect("~/student/Dashboard.aspx");
                        Response.Redirect("~/Student/Dashboard.aspx", false);
                    }
                }

                if (Session["user_type"].ToString() != "S")
                {
                    if (Session["user_type"].ToString() == "I")
                    {
                        Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                    }
                    else if (Session["user_type"].ToString() == "A")
                    {
                        Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                    }
                    else if (Session["user_type"].ToString() == "A1")
                    {
                        Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Login.aspx?logout=2");
            }
        }
    }
}