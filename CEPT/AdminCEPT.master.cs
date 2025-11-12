using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;
using System.IO;

public partial class AdminCEPT : System.Web.UI.MasterPage
{

    #region Variable Declaration
    Masters objmaster = new Masters();
    AdminUserRights objAdminUserRights = new AdminUserRights();

    #endregion

    string str;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        //  Response.Redirect("~/Site_maintenance.htm");
        if (Session["UserId"] != null)
        {
            if (Session["reset_flag"] == "R")
            {
                Response.Redirect("~/reset_password.aspx");
            }
            else
            {
                str = Session["UserId"].ToString();
                hdnuserid.Value = str;
                hdnusertype.Value = Session["user_type"].ToString();
             
                if (Session["user_type"].ToString() != "S" && Session["user_type"].ToString() != "E")
                {
                    InitializeData();
                }
                else
                {
                    Response.Redirect("~/Login.aspx?logout=2");
                }
            }
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }

        DataTable dtus = new DataTable();
        dtus = objmaster.userMaster(str);

        DataTable dt_param_dtl = objmaster.get_parameter_screen_rights_dtl();

        if (dt_param_dtl != null && !Request.Url.AbsolutePath.Contains("Admin/Master/Home.aspx"))
        {
            DataTable dt_appraisal_dtl = objmaster.get_status_for_aaply_appraisal(Session["UserId"].ToString());
            for (int i = 0; i < dt_param_dtl.Rows.Count; i++)
            {
                if (dt_appraisal_dtl == null && Session["user_type"].ToString() == "I2" && Request.Url.AbsolutePath.ToLower() == ("/Admin/Master/Faculty_apprisal_dtl.aspx").ToString().ToLower())
                {
                    //BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                    //string encodedMsg = encode.EncryptData("Not Eligible Please Contact HR Department");
                    //Response.Redirect("~/Admin/Master/Home.aspx?param=true&msg=" + encodedMsg);
                }

               else if (Request.Url.AbsolutePath.ToLower().Contains(dt_param_dtl.Rows[i]["page_path"].ToString().ToLower()) && dt_param_dtl.Rows[i]["user_type"].ToString() == Session["user_type"].ToString() && dt_param_dtl.Rows[i]["TimeStatus"].ToString() == "False")
                {
                    BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                    string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                    Response.Redirect("~/Admin/Master/Home.aspx?param=true&msg=" + encodedMsg);
                }
                else if (Request.Url.AbsolutePath.ToLower().Contains(dt_param_dtl.Rows[i]["page_path"].ToString().ToLower()) && dt_param_dtl.Rows[i]["parameter_value"].ToString() == "D" && dt_param_dtl.Rows[i]["user_type"].ToString() == Session["user_type"].ToString())
                {
                    if (Request.Url.AbsolutePath.ToLower().Contains("admin/master/ws_coursemaster_add.aspx") && dt_param_dtl.Rows[i]["user_type"].ToString() == "I2")
                    {
                        if (Request.Url.Query.ToString() != "")
                        {
                            string sws_status = Request.QueryString["sws"];
                            if (sws_status == null)
                            {
                                string course_code = Request.QueryString["c"];
                                string sem_code = Request.QueryString["s"];
                                string year_code = Request.QueryString["y"];
                                DataTable dt_course_sendforreview = objmaster.get_ws_course_proposal_data_sendforreview(course_code, sem_code, year_code);
                                if (dt_course_sendforreview == null)
                                {
                                    BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                    string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                    Response.Redirect("~/Admin/Master/Home.aspx?param=true&msg=" + encodedMsg);
                                }
                            }
                            else 
                            {
                                BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                                string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                                Response.Redirect("~/Admin/Master/Home.aspx?param=true&msg=" + encodedMsg);
                            }
                            
                            
                        }

                    }
                    else 
                    {
                        BLL.ExtraUtilities1.EncodingDecoding encode = new BLL.ExtraUtilities1.EncodingDecoding();
                        string encodedMsg = encode.EncryptData(dt_param_dtl.Rows[i]["disable_message"].ToString());
                        Response.Redirect("~/Admin/Master/Home.aspx?param=true&msg=" + encodedMsg);
                    }

                    
                }
            }
        }
        DataTable dt_rights_dtl = objmaster.get_rights_dtl(Session["UserId"].ToString());
        DataTable dt_rights_dtl_check = objmaster.get_rights_dtl_check(Session["UserId"].ToString());
        if (Session["designation"].ToString() == "temp" && Request.Url.AbsolutePath.Contains("Admin/Master/Home.aspx"))
        {
            if (dt_rights_dtl != null)
            {
                if (dt_rights_dtl.Rows[0]["group_id"].ToString() == "Sel_Tutor")
                {
                    Response.Redirect("~/Admin/Master/SelectTutor.aspx");
                }
                else if (dt_rights_dtl.Rows[0]["group_id"].ToString() == "TA_Tutor")
                {
                    Response.Redirect("~/Admin/Master/Temp_Dashboard.aspx");
                }
                else 
                {
                   Response.Redirect("~/Admin/Master/Studio_Proposal_Dashboard.aspx");
                }
            }
            else { Response.Redirect("~/Admin/Master/Studio_Proposal_Dashboard.aspx"); }
            
            
        }
        
    }

    protected override void OnInit(EventArgs e)
    {
        if (Session["UserId"] == null)
        {
            if (Request.Cookies["cept_login"] != null)
            {
                Session["UserId"] = Request.Cookies["cept_login"].Values["user_id"];
                Session["UserName"] = Request.Cookies["cept_login"].Values["user_name"];
                Session["user_type"] = Request.Cookies["cept_login"].Values["user_type"];
                Session["dept_code"] = Request.Cookies["cept_login"].Values["dept_code"];
                Session["prog_code"] = Request.Cookies["cept_login"].Values["prog_code"];
                Session["semester_code"] = Request.Cookies["cept_login"].Values["semester_code"];
                Session["year_code"] = Request.Cookies["cept_login"].Values["year_code"];
                Session["prog_level_code"] = Request.Cookies["cept_login"].Values["prog_level_code"];
                Session["gender"] = Request.Cookies["cept_login"].Values["gender"];

                //if (Session["user_type"].ToString() == "A")
                //{
                //    admin_menu.Style.Add("display", "block");
                //}
                //if (Session["user_type"].ToString() == "A1")
                //{
                //    admin1_menu.Style.Add("display", "block");
                //}
                //if (Session["user_type"].ToString() == "A2")
                //{
                //    admin2_menu.Style.Add("display", "block");
                //}
                //else if (Session["user_type"].ToString() == "S")
                //{
                //    student_menu.Style.Add("display", "block");
                //}
                //else if (Session["user_type"].ToString() == "I")
                //{
                //    it_menu.Style.Add("display", "block");
                //}

            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        if (Session["UserId"] != null)
        {
            lblusername.InnerText = Session["UserName"].ToString();
            
            //  Lblusaernameanother.Text = "CEPT UNIVERSITY";
            //  hdnuserid.Value = "123456";
        }
    }

    protected void InitializeData()
    {
        div_current_role.Visible = false;
        //Get User Multiple Role Detail
        DataTable dtUserMultiRoleDtl = objAdminUserRights.GetUserMultiRoleDtl(Session["UserId"].ToString());
        DataTable check_cpop_user = objmaster.get_cpop_user_mst_dtl(Session["UserId"].ToString());

        DataTable dtAdminRights;

        if (dtUserMultiRoleDtl != null)
        {
            //Get Admin Access Rights 
            dtAdminRights = objAdminUserRights.GetMultiRoleMenuRights(Session["UserId"].ToString(), Session["user_type"].ToString());

            DataRow[] dr_MultiRoleDtl = dtUserMultiRoleDtl.Select("user_type not in ('" + Session["user_type"].ToString() + "')");

            if (dr_MultiRoleDtl.Length > 0)
            {
                string str_html = "";

                for (int i = 0; i < dr_MultiRoleDtl.Length; i++)
                {
                    str_html += "<li clientidmode='Static'><a onclick=\"change_user_role('" + dr_MultiRoleDtl[i]["user_type"] + "')\"><span>" + dr_MultiRoleDtl[i]["user_type_desc"] + "</span></a></li>";
                }

                ul_change_role.InnerHtml = str_html;
                li_change_role.Visible = true;
            }

            DataRow[] dr_MultiRoleDtl2 = dtUserMultiRoleDtl.Select("user_type = '" + Session["user_type"].ToString() + "'");

            if (dr_MultiRoleDtl2.Length > 0)
            {
                div_current_role.InnerHtml = "<b>Current Role : " + dr_MultiRoleDtl2[0]["user_type_desc"] + "</b>";
                div_current_role.Visible = true;
            }
        }
        else
        {
            //Get Admin Access Rights 
            dtAdminRights = objAdminUserRights.GetMenuRights(Session["UserId"].ToString());
        }

        //Make the Menu and Bind it to the Menu Bar
        //String strHtmlMenu = "<a href='#'><span>Academic Management</span></a>";
        String strHtmlMenu = objAdminUserRights.GetMenu(dtAdminRights, Page, Session["designation"].ToString());
        if (check_cpop_user == null)
        {
            strHtmlMenu = strHtmlMenu.Replace("<li runat='server' id='Menu311'><a href='Faculty_apprisal_dtl.aspx'><span>Faculty Apprisal Details<span></a></li>", "");
        }
        
        divMenuAdmin.InnerHtml = strHtmlMenu;

        #region Check Access Rights of that page
        String strFileName = String.Empty;
        String strAbsolutePath = Request.Url.AbsolutePath;
        FileInfo fileInfo = new FileInfo(strAbsolutePath);
        bool isPage = false;

        strFileName = fileInfo.Name;
        //main_1.Style.Add("border-bottom", "5px solid white");

        switch (strFileName)
        {
            case "Home.aspx":
                //main_1_span.Style.Add("background", "#5B9BD5");
                //main_1_span.Style.Add("color", "white");
                main_1.Style.Add("border-bottom", "5px solid #5B9BD5");
                //case "UpdateFormUG.aspx":
                //case "UpdateFormPG.aspx":
                //case "UpdateFormPHD.aspx":
                
                isPage = false;
                div_bread_crumbs.InnerHtml = "<a href='Home.aspx'><span>Home<span></a>";
                break;
            default:
                isPage = true;
                break;
        }

        if (isPage)
        {   
            if (dtAdminRights != null && dtAdminRights.Rows.Count > 0)
            {
                DataRow[] dr = dtAdminRights.Select("page_name = '" + strFileName + "'");
                if (dr.Length <= 0)
                {
                    //Rights of Page is Not Available       
                    Response.Redirect("~/Admin/Master/Home.aspx");           
                }
                else
                {
                    String strHtmlMenu1 = objAdminUserRights.GetMenu_after_click(dtAdminRights, dr[0]["parent_menu_id"].ToString(), Page, strFileName, Session["designation"].ToString());
                    if (check_cpop_user == null)
                    {
                        strHtmlMenu1 = strHtmlMenu1.Replace("<li runat='server' id='Menu311'><a href='Faculty_apprisal_dtl.aspx'><span>Faculty Apprisal Details<span></a></li>", "");
                    }
                    divMenuAdmin.InnerHtml = strHtmlMenu1;
                }
            }
            else
            {
                if (Session["user_type"].ToString() != "O")
                {
                    Response.Redirect("../Master/Home.aspx");
                }
                
                //Rights of Page is Not Available
            }
        }

        #endregion

        #region Bread Crumbs

        try
        {
            FileInfo cur_fileInfo = new FileInfo(Request.Url.AbsolutePath);
            FileInfo prev_fileInfo = null;

            if (Request.UrlReferrer != null) prev_fileInfo = new FileInfo(Request.UrlReferrer.AbsolutePath);

            DataRow[] dr_curpage_dtl = dtAdminRights.Select("page_name='" + cur_fileInfo.Name + "'");

            if (dr_curpage_dtl.Length > 0)
            {
                div_bread_crumbs.InnerHtml = "<a href='" + Page.ResolveClientUrl("~/Admin/Master/Home.aspx") + "'><span>Home<span></a>";

                string str_parent = dr_curpage_dtl[0]["parent_menu_id"].ToString();

                if (str_parent != "Menu24")
                {
                    List<string> lst_breadcrumbs = new List<string>();

                    while (str_parent != "Root")
                    {
                        DataRow[] dr_parent_menu = dtAdminRights.Select("menu_id='" + str_parent + "'");

                        if (dr_parent_menu.Length > 0)
                        {
                            //if (dr_parent_menu[0]["window_name"].ToString() != "")
                            //    div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + " / <a href='" + Page.ResolveClientUrl(dr_parent_menu[0]["window_name"].ToString()) + "'><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>";
                            //else
                            //    div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + " / <a><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>";

                            if (dr_parent_menu[0]["window_name"].ToString() != "")
                                lst_breadcrumbs.Add(" / <a href='" + Page.ResolveClientUrl(dr_parent_menu[0]["window_name"].ToString()) + "'><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>");
                            else
                                lst_breadcrumbs.Add(" / <a><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>");

                            str_parent = dr_parent_menu[0]["parent_menu_id"].ToString();
                        }
                        else
                        {
                            break;
                        }
                    }

                    for (int i = lst_breadcrumbs.Count - 1; i >= 0; i--)
                        div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + lst_breadcrumbs[i];

                    div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + " / <a><span>" + dr_curpage_dtl[0]["menu_description"].ToString() + "<span></a>";
                }
                else if (prev_fileInfo != null)
                {
                    DataRow[] dr_prevpage_dtl = dtAdminRights.Select("page_name='" + prev_fileInfo.Name + "'");

                    if (dr_prevpage_dtl.Length > 0)
                    {
                        div_bread_crumbs.InnerHtml = "<a href='" + Page.ResolveClientUrl("~/Admin/Master/Home.aspx") + "'><span>Home<span></a>";

                        str_parent = dr_prevpage_dtl[0]["parent_menu_id"].ToString();

                        List<string> lst_breadcrumbs = new List<string>();

                        while (str_parent != "Root")
                        {
                            DataRow[] dr_parent_menu = dtAdminRights.Select("menu_id='" + str_parent + "'");

                            if (dr_parent_menu.Length > 0)
                            {
                                //if (dr_parent_menu[0]["window_name"].ToString() != "")
                                //    div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + " / <a href='" + Page.ResolveClientUrl(dr_parent_menu[0]["window_name"].ToString()) + "'><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>";
                                //else
                                //    div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + " / <a><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>";

                                if (dr_parent_menu[0]["window_name"].ToString() != "")
                                    lst_breadcrumbs.Add(" / <a href='" + Page.ResolveClientUrl(dr_parent_menu[0]["window_name"].ToString()) + "'><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>");
                                else
                                    lst_breadcrumbs.Add(" / <a><span>" + dr_parent_menu[0]["menu_description"].ToString() + "<span></a>");

                                str_parent = dr_parent_menu[0]["parent_menu_id"].ToString();
                            }
                            else
                            {
                                break;
                            }
                        }

                        for (int i = lst_breadcrumbs.Count - 1; i >= 0; i--)
                            div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + lst_breadcrumbs[i];

                        div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + " / <a href='" + Page.ResolveClientUrl(dr_prevpage_dtl[0]["window_name"].ToString()) + "'><span>" + dr_prevpage_dtl[0]["menu_description"].ToString() + "<span></a>";
                    }

                    div_bread_crumbs.InnerHtml = div_bread_crumbs.InnerHtml + " / <a><span>" + dr_curpage_dtl[0]["menu_description"].ToString() + "<span></a>";
                }
                else if (Session["bread_crumbs"] != null && Session["bread_crumbs"] != "")
                {
                    div_bread_crumbs.InnerHtml = Session["bread_crumbs"].ToString();
                }

                Session["bread_crumbs"] = div_bread_crumbs.InnerHtml;
            }
        }
        catch (Exception ex)
        {

        }

        #endregion
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        DataTable dtUserMultiRoleDtl = objAdminUserRights.GetUserMultiRoleDtl(Session["UserId"].ToString());

        if (dtUserMultiRoleDtl != null)
        {
            DataRow[] dr_MultiRoleDtl = dtUserMultiRoleDtl.Select("user_type = '" + HdnUserRole.Value.ToString() + "'");

            if (dr_MultiRoleDtl.Length > 0)
            {
                bool update_res = objAdminUserRights.ChangeUserRole(Session["UserId"].ToString(), Session["user_type"].ToString(), HdnUserRole.Value.ToString());

                if (update_res)
                {
                    Session["user_type"] = HdnUserRole.Value.ToString();
                    Response.Redirect("~/Admin/Master/Home.aspx");
                }
            }
        }
    }
}
