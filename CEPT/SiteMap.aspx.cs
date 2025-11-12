using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMap : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    AdminUserRights objAdminUserRights = new AdminUserRights();


    string str;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserId"] != null)
            {
            DataTable dtUserMultiRoleDtl = objAdminUserRights.GetUserMultiRoleDtl(Session["UserId"].ToString());

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

                    //ul_change_role.InnerHtml = str_html;
                    //li_change_role.Visible = true;
                }

                DataRow[] dr_MultiRoleDtl2 = dtUserMultiRoleDtl.Select("user_type = '" + Session["user_type"].ToString() + "'");

                if (dr_MultiRoleDtl2.Length > 0)
                {
                    //div_current_role.InnerHtml = "<b>Current Role : " + dr_MultiRoleDtl2[0]["user_type_desc"] + "</b>";
                   // div_current_role.Visible = true;
                }
            }
            else
            {
                //Get Admin Access Rights 
                dtAdminRights = objAdminUserRights.GetMenuRights(Session["UserId"].ToString());
            }

            //Make the Menu and Bind it to the Menu Bar
            //String strHtmlMenu = objAdminUserRights.SiteMenuDetails(dtAdminRights, Page, Session["designation"].ToString());
            //    divSiteMap.InnerHtml = strHtmlMenu;
            }
        }

    }
}