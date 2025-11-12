using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using BLL.Utilities;
using System.Data;
using System.Text;
using System.Collections;
using Microsoft.VisualBasic.Logging;
namespace BLL.Master
{
    public class AdminUserRights : ServerBase
    {
        #region Get User Multiple Role Detail
        public DataTable GetUserMultiRoleDtl(string UserId)
        {
            try
            {
                DataTable dtMenuRights = new DataTable();
                DataSet dsMenuRights = new DataSet();

                DBDataAdpterObject.SelectCommand.Parameters.Clear();

                StringBuilder SQLSelect = new StringBuilder();

                SQLSelect.Append("select * from user_multi_role_dtl where user_id='" + UserId + "' and cancel_flag='N'");

                DBDataAdpterObject.SelectCommand.CommandText = SQLSelect.ToString();
                DBDataAdpterObject.Fill(dsMenuRights);

                if (dsMenuRights != null && dsMenuRights.Tables[0] != null && dsMenuRights.Tables[0].Rows.Count > 0)
                {
                    dtMenuRights = dsMenuRights.Tables[0].Copy();
                    return dtMenuRights;
                }
                else
                {
                    dtMenuRights = null;
                    return dtMenuRights;
                }
            }
            catch (Exception ex)
            {
                //Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return null;
            }
        }
        #endregion

        #region Get User Multiple Role Detail
        public DataTable GetMultiRoleMenuRights(string UserId, string UserType)
        {
            try
            {
                DataTable dtMenuRights = new DataTable();
                DataSet dsMenuRights = new DataSet();

                DBDataAdpterObject.SelectCommand.Parameters.Clear();

                StringBuilder SQLSelect = new StringBuilder();

                SQLSelect.Append(";with cte(user_id,user_type,menu_id,menu_group) as ( ");
                SQLSelect.Append("select user_id,user_type,CAST(LEFT(menu_group,CHARINDEX(',',menu_group + ',') - 1) as varchar(20)), ");
                SQLSelect.Append("STUFF(menu_group,1,CHARINDEX(',',menu_group + ','),'') ");
                SQLSelect.Append("from user_multi_role_dtl ");
                SQLSelect.Append("where user_id='" + UserId + "' and user_type='" + UserType + "' and cancel_flag='N' ");
                SQLSelect.Append("union all ");
                SQLSelect.Append("select user_id,user_type,CAST(LEFT(menu_group,CHARINDEX(',',menu_group + ',') - 1) as varchar(20)), ");
                SQLSelect.Append("STUFF(menu_group,1,CHARINDEX(',',menu_group + ','),'') ");
                SQLSelect.Append("from cte ");
                SQLSelect.Append("where menu_group > '') ");

                SQLSelect.Append("SELECT MenuMst.menu_id, MenuMst.parent_menu_id, MenuMst.menu_description, MenuMst.window_name, user_group.user_id, user_group.status, MenuMst.page_name ");
                SQLSelect.Append("FROM MenuMst INNER JOIN group_rights ON MenuMst.menu_id = group_rights.menu_id ");
                SQLSelect.Append("INNER JOIN user_group ON group_rights.group_id = user_group.group_id ");
                SQLSelect.Append("WHERE user_group.status = 'A' And group_rights.status = 'A' AND user_group.user_id = '" + UserId + "' ");
                SQLSelect.Append("AND group_rights.group_id in (select menu_id from cte) ");
                SQLSelect.Append("order by group_rights.disp_order,MenuMst.menu_description ");

                DBDataAdpterObject.SelectCommand.CommandText = SQLSelect.ToString();
                DBDataAdpterObject.Fill(dsMenuRights);

                if (dsMenuRights != null && dsMenuRights.Tables[0] != null && dsMenuRights.Tables[0].Rows.Count > 0)
                {
                    //dtMenuRights = dsMenuRights.Tables[0].Copy();
                    dtMenuRights = dsMenuRights.Tables[0].Copy().DefaultView.ToTable(true);
                    return dtMenuRights;
                }
                else
                {
                    dtMenuRights = null;
                    return dtMenuRights;
                }
            }
            catch (Exception ex)
            {
                //Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return null;
            }
        }


        public DataTable Site_GetMultiRoleMenuRights(string UserId, string UserType)
        {
            try
            {
                DataTable dtMenuRights = new DataTable();
                DataSet dsMenuRights = new DataSet();

                DBDataAdpterObject.SelectCommand.Parameters.Clear();

                StringBuilder SQLSelect = new StringBuilder();

                SQLSelect.Append(";with cte(user_id,user_type,menu_id,menu_group) as ( ");
                SQLSelect.Append("select user_id,user_type,CAST(LEFT(menu_group,CHARINDEX(',',menu_group + ',') - 1) as varchar(20)), ");
                SQLSelect.Append("STUFF(menu_group,1,CHARINDEX(',',menu_group + ','),'') ");
                SQLSelect.Append("from user_multi_role_dtl ");
                SQLSelect.Append("where user_id='" + UserId + "' and user_type='" + UserType + "' and cancel_flag='N' ");
                SQLSelect.Append("union all ");
                SQLSelect.Append("select user_id,user_type,CAST(LEFT(menu_group,CHARINDEX(',',menu_group + ',') - 1) as varchar(20)), ");
                SQLSelect.Append("STUFF(menu_group,1,CHARINDEX(',',menu_group + ','),'') ");
                SQLSelect.Append("from cte ");
                SQLSelect.Append("where menu_group > '') ");

                SQLSelect.Append("SELECT MenuMst.menu_id, MenuMst.parent_menu_id, MenuMst.menu_description, MenuMst.window_name, user_group.user_id, user_group.status, MenuMst.page_name,MenuMst.menu_order,MenuMst.description ");
                SQLSelect.Append("FROM MenuMst INNER JOIN group_rights ON MenuMst.menu_id = group_rights.menu_id ");
                SQLSelect.Append("INNER JOIN user_group ON group_rights.group_id = user_group.group_id ");
                SQLSelect.Append("WHERE user_group.status = 'A' And group_rights.status = 'A' AND user_group.user_id = '" + UserId + "' ");
                SQLSelect.Append("AND group_rights.group_id in (select menu_id from cte) ");
                SQLSelect.Append("order by MenuMst.menu_order asc ");

                DBDataAdpterObject.SelectCommand.CommandText = SQLSelect.ToString();
                DBDataAdpterObject.Fill(dsMenuRights);

                if (dsMenuRights != null && dsMenuRights.Tables[0] != null && dsMenuRights.Tables[0].Rows.Count > 0)
                {
                    //dtMenuRights = dsMenuRights.Tables[0].Copy();
                    dtMenuRights = dsMenuRights.Tables[0].Copy().DefaultView.ToTable(true);
                    return dtMenuRights;
                }
                else
                {
                    dtMenuRights = null;
                    return dtMenuRights;
                }
            }
            catch (Exception ex)
            {
                //Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return null;
            }
        }
        #endregion

        #region Get Admin Menu Rights
        public DataTable GetMenuRights(string UserId)
        {
            try
            {
                DataTable dtMenuRights = new DataTable();
                DataSet dsMenuRights = new DataSet();

                DBDataAdpterObject.SelectCommand.Parameters.Clear();

                StringBuilder SQLSelect = new StringBuilder();
                //SQLSelect.Append("SELECT  MenuMst.menu_id, MenuMst.parent_menu_id, MenuMst.menu_description, MenuMst.window_name, UserMenuRightsMst.user_id, UserMenuRightsMst.status, MenuMst.page_name ");
                //SQLSelect.Append("FROM     MenuMst INNER JOIN UserMenuRightsMst ON MenuMst.menu_id = UserMenuRightsMst.menu_id ");
                //SQLSelect.Append("WHERE   UserMenuRightsMst.status = 'A' AND UserMenuRightsMst.user_id = '" + UserId + "' order by MenuMst.menu_description ");

                SQLSelect.Append("SELECT MenuMst.menu_id, MenuMst.parent_menu_id, MenuMst.menu_description, MenuMst.window_name, user_group.user_id, user_group.status, MenuMst.page_name ");
                SQLSelect.Append("FROM MenuMst INNER JOIN group_rights ON MenuMst.menu_id = group_rights.menu_id ");
                SQLSelect.Append("INNER JOIN user_group ON group_rights.group_id = user_group.group_id ");
                SQLSelect.Append("WHERE user_group.status = 'A' And group_rights.status = 'A' AND user_group.user_id = '" + UserId + "' ");
                SQLSelect.Append("order by group_rights.disp_order,MenuMst.menu_description ");

                //DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@status", DbType.String, "A"));
                //DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@user_id", DbType.String, UserId.ToString()));

                DBDataAdpterObject.SelectCommand.CommandText = SQLSelect.ToString();
                DBDataAdpterObject.Fill(dsMenuRights);

                if (dsMenuRights != null && dsMenuRights.Tables[0] != null && dsMenuRights.Tables[0].Rows.Count > 0)
                {
                    //dtMenuRights = dsMenuRights.Tables[0].Copy();
                    dtMenuRights = dsMenuRights.Tables[0].Copy().DefaultView.ToTable(true);
                    return dtMenuRights;
                }
                else
                {
                    dtMenuRights = null;
                    return dtMenuRights;
                }
            }
            catch (Exception ex)
            {
                // Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return null;
            }
        }

        public DataTable Site_GetMenuRights(string UserId)
        {
            try
            {
                DataTable dtMenuRights = new DataTable();
                DataSet dsMenuRights = new DataSet();

                DBDataAdpterObject.SelectCommand.Parameters.Clear();

                StringBuilder SQLSelect = new StringBuilder();
                //SQLSelect.Append("SELECT  MenuMst.menu_id, MenuMst.parent_menu_id, MenuMst.menu_description, MenuMst.window_name, UserMenuRightsMst.user_id, UserMenuRightsMst.status, MenuMst.page_name ");
                //SQLSelect.Append("FROM     MenuMst INNER JOIN UserMenuRightsMst ON MenuMst.menu_id = UserMenuRightsMst.menu_id ");
                //SQLSelect.Append("WHERE   UserMenuRightsMst.status = 'A' AND UserMenuRightsMst.user_id = '" + UserId + "' order by MenuMst.menu_description ");

                SQLSelect.Append("SELECT MenuMst.menu_id, MenuMst.parent_menu_id, MenuMst.menu_description, MenuMst.window_name, user_group.user_id, user_group.status, MenuMst.page_name,MenuMst.menu_order,MenuMst.description ");
                SQLSelect.Append("FROM MenuMst INNER JOIN group_rights ON MenuMst.menu_id = group_rights.menu_id ");
                SQLSelect.Append("INNER JOIN user_group ON group_rights.group_id = user_group.group_id ");
                SQLSelect.Append("WHERE user_group.status = 'A' And group_rights.status = 'A' AND user_group.user_id = '" + UserId + "' ");
                SQLSelect.Append("order by MenuMst.menu_order asc ");

                //DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@status", DbType.String, "A"));
                //DBDataAdpterObject.SelectCommand.Parameters.Add(DBObjectFactory.MakeParameter("@user_id", DbType.String, UserId.ToString()));

                DBDataAdpterObject.SelectCommand.CommandText = SQLSelect.ToString();
                DBDataAdpterObject.Fill(dsMenuRights);

                if (dsMenuRights != null && dsMenuRights.Tables[0] != null && dsMenuRights.Tables[0].Rows.Count > 0)
                {
                    //dtMenuRights = dsMenuRights.Tables[0].Copy();
                    dtMenuRights = dsMenuRights.Tables[0].Copy().DefaultView.ToTable(true);
                    return dtMenuRights;
                }
                else
                {
                    dtMenuRights = null;
                    return dtMenuRights;
                }
            }
            catch (Exception ex)
            {
                // Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return null;
            }
        }

        #endregion

        //#region Make the Menu (HTML)
        //public string GetMenu(DataTable UserAccessMenuList)
        //{
        //    string MenuLink = "#", MenuName = "", MenuId = "";

        //    var MenuDiv = "<ul>";

        //    if (UserAccessMenuList != null && UserAccessMenuList.Rows.Count > 0)
        //    {
        //        //Get Parent Menu
        //        DataTable Menu = GetMenuList("Root", UserAccessMenuList);

        //        float count_width = 70 / Menu.Rows.Count;

        //        string style = "width :15%;";
        //        string margin = "";

        //        if (count_width <= 15)
        //        {
        //            style = "width :" + count_width + "%;";

        //            margin = "margin-left:" + (70 - (Menu.Rows.Count * count_width)) + "%;";
        //        }
        //        else
        //        {
        //            margin = "margin-left:" + (70 - (Menu.Rows.Count * 15)) + "%;";
        //        }

        //        for (var i = 0; i < Menu.Rows.Count; i++)   // Loop For First Level Menus
        //        {
        //            MenuName = Menu.Rows[i]["menu_description"].ToString();
        //            MenuLink = Menu.Rows[i]["window_name"].ToString();

        //            if (MenuLink == "") MenuLink = "#\"";

        //            DataTable Menu1 = GetMenuList(Menu.Rows[i]["menu_id"].ToString(), UserAccessMenuList);

        //            if (i == 0)
        //            {
        //                if (Menu1.Rows.Count > 0)
        //                {
        //                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0; " + margin + style + " border-top: 5px solid white;' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
        //                    MenuDiv += "<a href='#'>";
        //                    MenuDiv += "<span>" + MenuName + "</span></a>";
        //                }
        //                else
        //                {
        //                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0;   " + margin + style + " border-top: 5px solid white;' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
        //                    MenuDiv += "<a href='" + MenuLink + "'>";
        //                    MenuDiv += "<span>" + MenuName + "</span></a>";
        //                }
        //            }
        //            else
        //            {
        //                if (Menu1.Rows.Count > 0)
        //                {
        //                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='" + style + " border-top: 5px solid white;' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
        //                    MenuDiv += "<a href='#'>";
        //                    MenuDiv += "<span>" + MenuName + "</span></a>";
        //                }
        //                else
        //                {
        //                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='" + style + " border-top: 5px solid white;'  id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
        //                    MenuDiv += "<a href='" + MenuLink + "'>";
        //                    MenuDiv += "<span>" + MenuName + "</span></a>";
        //                }
        //            }

        //            if (Menu1.Rows.Count > 0)
        //            {
        //                if (Menu1.Rows.Count > 0)
        //                {
        //                    MenuDiv += "<ul>";

        //                    for (var J = 0; J < Menu1.Rows.Count; J++) // Loop For First Level Menus
        //                    {
        //                        MenuName = Menu1.Rows[J]["menu_description"].ToString();
        //                        MenuLink = Menu1.Rows[J]["window_name"].ToString();
        //                        MenuId = Menu1.Rows[J]["menu_id"].ToString();

        //                        if (MenuLink == "")
        //                            MenuLink = "#\"";

        //                        DataTable Menu2 = GetMenuList(Menu1.Rows[J]["menu_id"].ToString(), UserAccessMenuList);
        //                        if (Menu2.Rows.Count > 0)
        //                        {
        //                            MenuDiv += "<li runat='server' id='" + MenuId + "'>";
        //                            MenuDiv += "<a href='" + MenuLink + "'><span>" + MenuName + "</span></a></li>";
        //                        }
        //                        else
        //                        {
        //                            MenuDiv += "<li runat='server' id='" + MenuId + "'>";
        //                            MenuDiv += "<a href='" + MenuLink + "'><span>" + MenuName + "<span></a></li>";
        //                        }
        //                    }
        //                    MenuDiv += "</ul>";
        //                }
        //            }
        //            MenuDiv += "</li>";
        //        }
        //    }

        //    //MenuDiv += "<li><a href=\"javascript:LogOutAndClearSession()\">Log Out</a></li>";
        //    MenuDiv += "<li runat='server' style='width: 14%; border-top: 5px solid white;'  class='has-sub'><a href='#'><span>My calander</span></a></li><li runat='server' style='width: 15%; border-top: 5px solid white;'  class='has-sub'><a href='#'><span>Personal details</span></a></li>";
        //    MenuDiv += "</ul>";

        //    return MenuDiv;
        //}
        //#endregion

        #region Make the Menu (HTML)
        public string GetMenu(DataTable UserAccessMenuList, System.Web.UI.Page ui_page, string temp_tutor)
        {
            string MenuLink = "#", MenuName = "", MenuId = "";

            var MenuDiv = "<ul>";

            if (UserAccessMenuList != null && UserAccessMenuList.Rows.Count > 0)
            {
                //Get Parent Menu
                DataTable Menu = GetMenuList("Root", UserAccessMenuList);
                if (Menu.Rows.Count != 0)
                {

                    float count_width = 70 / Menu.Rows.Count;

                    string style = "width :15%;";
                    string margin = "";

                    if (count_width <= 15)
                    {
                        if (Menu.Rows.Count == 6)
                        {
                            style = "width :" + (count_width + 1) + "%;";
                        }
                        else { style = "width :" + count_width + "%;"; }
                        

                        margin = "margin-left:" + (71 - (Menu.Rows.Count * count_width)) + "%;";
                    }
                    else
                    {
                        margin = "margin-left:" + (71 - (Menu.Rows.Count * 15)) + "%;";
                    }

                    for (var i = 0; i < Menu.Rows.Count; i++)   // Loop For First Level Menus
                    {
                        MenuName = Menu.Rows[i]["menu_description"].ToString();
                        //MenuLink = Menu.Rows[i]["window_name"].ToString();
                        MenuLink = ui_page.ResolveClientUrl(Menu.Rows[i]["window_name"].ToString());

                        if (MenuLink == "") MenuLink = "#\"";

                        DataTable Menu1 = GetMenuList(Menu.Rows[i]["menu_id"].ToString(), UserAccessMenuList);

                        if (i == 0)
                        {
                            if (Menu1.Rows.Count > 0)
                            {
                                if (temp_tutor == "temp" && MenuName == "Reports")
                                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0; float:right; width:14%; " + margin + " ' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                else
                                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0; width:14%; " + margin + " ' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";

                                MenuDiv += "<a href='#'>";
                                MenuDiv += "<span>" + MenuName + "</span></a>";
                            }
                            else
                            {
                                MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0;   width:14%;" + margin + "' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                MenuDiv += "<a href='" + MenuLink + "'>";
                                MenuDiv += "<span>" + MenuName + "</span></a>";
                            }
                        }
                        else
                        {
                            if (Menu1.Rows.Count > 0)
                            {
                                if (temp_tutor == "temp" && MenuName == "Reports")
                                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='float:right;" + style + " ' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                else
                                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='" + style + " ' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                MenuDiv += "<a href='#'>";
                                MenuDiv += "<span>" + MenuName + "</span></a>";
                            }
                            else
                            {
                                MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='" + style + " '  id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                MenuDiv += "<a href='" + MenuLink + "'>";
                                MenuDiv += "<span>" + MenuName + "</span></a>";
                            }
                        }

                        if (Menu1.Rows.Count > 0)
                        {
                            if (Menu1.Rows.Count > 0)
                            {
                                MenuDiv += "<ul>";

                                for (var J = 0; J < Menu1.Rows.Count; J++) // Loop For First Level Menus
                                {
                                    MenuName = Menu1.Rows[J]["menu_description"].ToString();
                                    //MenuLink = Menu1.Rows[J]["window_name"].ToString();
                                    MenuLink = ui_page.ResolveClientUrl(Menu1.Rows[J]["window_name"].ToString());
                                    MenuId = Menu1.Rows[J]["menu_id"].ToString();

                                    if (MenuLink == "")
                                        MenuLink = "#\"";

                                    DataTable Menu2 = GetMenuList(Menu1.Rows[J]["menu_id"].ToString(), UserAccessMenuList);
                                    if (Menu2.Rows.Count > 0)
                                    {
                                        MenuDiv += "<li runat='server' id='" + MenuId + "'>";
                                        MenuDiv += "<a href='" + MenuLink + "'><span>" + MenuName + "</span></a></li>";
                                    }
                                    else
                                    {
                                        MenuDiv += "<li runat='server' id='" + MenuId + "'>";
                                        MenuDiv += "<a href='" + MenuLink + "'><span>" + MenuName + "<span></a></li>";
                                    }
                                }
                                MenuDiv += "</ul>";
                            }
                        }
                        MenuDiv += "</li>";
                    }
                }
                else
                {
                    MenuDiv += "<li runat='server' style='width: 71%; '  class='has-sub'></li>";//width:17%
                }
            }

            if (UserAccessMenuList != null && UserAccessMenuList.Rows.Count > 0 && temp_tutor != "temp")
            {
                DataRow[] dr = UserAccessMenuList.Select("menu_id ='Menu61'");//Changes 25112022 NitinBhai
                if (dr.Length > 0)
                {
                    MenuDiv += "<li runat='server' style='width: 13%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/MyCalendar.aspx") + "'><span>My calendar</span></a></li><li runat='server' style='width: 16%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/frm_personal_details.aspx") + "'><span style='float:right;'>Personal details</span></a></li>";//width:17%
                }
                else
                {
                    MenuDiv += "<li runat='server' style='width: 16%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/frm_personal_details.aspx") + "'><span style='float:right;'>Personal details</span></a></li>";//width:17% }
                }
                //  MenuDiv += "</ul>";
            }
            else if (temp_tutor != "temp")
            {
                MenuDiv += "<li runat='server' style='width: 13%; margin-left:70%;'  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/MyCalendar.aspx") + "'><span>My calendar</span></a></li><li runat='server' style='width: 16%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/frm_personal_details.aspx") + "'><span style='float:right;'>Personal details</span></a></li>";//width:17%
                // MenuDiv += "</ul>";

            }
            //MenuDiv += "<li><a href=\"javascript:LogOutAndClearSession()\">Log Out</a></li>";

            MenuDiv += "</ul>";
            return MenuDiv;
        }
        #endregion

        #region Make the Menu (HTML)
        public string GetMenu_after_click(DataTable UserAccessMenuList, string parent_menu, System.Web.UI.Page ui_page, string page_name, string temp_tutor)
        {
            string MenuLink = "#", MenuName = "", MenuId = "";

            var MenuDiv = "<ul>";

            if (UserAccessMenuList != null && UserAccessMenuList.Rows.Count > 0)
            {
                //Get Parent Menu
                DataTable Menu = GetMenuList("Root", UserAccessMenuList);
                if (Menu.Rows.Count != 0)
                {

                    float count_width = 70 / Menu.Rows.Count;

                    string style = "width :15%;";
                    string margin = "";

                    if (count_width <= 15)
                    {
                        style = "width :" + count_width + "%;";

                        margin = "margin-left:" + (71 - (Menu.Rows.Count * count_width)) + "%;";
                    }
                    else
                    {
                        margin = "margin-left:" + (71 - (Menu.Rows.Count * 15)) + "%;";
                    }

                    for (var i = 0; i < Menu.Rows.Count; i++)   // Loop For First Level Menus
                    {
                        MenuName = Menu.Rows[i]["menu_description"].ToString();
                        // MenuLink = Menu.Rows[i]["window_name"].ToString();

                        MenuLink = ui_page.ResolveClientUrl(Menu.Rows[i]["window_name"].ToString());

                        if (MenuLink == "") MenuLink = "#\"";

                        DataTable Menu1 = GetMenuList(Menu.Rows[i]["menu_id"].ToString(), UserAccessMenuList);

                        if (i == 0)
                        {
                            if (Menu1.Rows.Count > 0)
                            {

                                if (parent_menu == Menu.Rows[i]["menu_id"].ToString())
                                {
                                    if (temp_tutor == "temp" && MenuName == "Reports")
                                        MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0; float:right; width:14%; " + margin + " border-top: 5px solid #5B9BD5;' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                    else
                                        MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0; width:14%; " + margin + " border-top: 5px solid #5B9BD5;' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                    MenuDiv += "<a href='#'>";
                                    MenuDiv += "<span style='  font-weight: bold; color: black;'>" + MenuName + "</span></a>";
                                }
                                else
                                {
                                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0; width:14%; " + margin + "' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                    MenuDiv += "<a href='#'>";
                                    MenuDiv += "<span>" + MenuName + "</span></a>";
                                }

                            }
                            else
                            {
                                MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='border-left: 0; width:14%; " + margin + " ' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                MenuDiv += "<a href='" + MenuLink + "'>";
                                MenuDiv += "<span>" + MenuName + "</span></a>";
                            }
                        }
                        else
                        {
                            if (Menu1.Rows.Count > 0)
                            {
                                if (parent_menu == Menu.Rows[i]["menu_id"].ToString())
                                {
                                    if (temp_tutor == "temp" && MenuName == "Reports")
                                        MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='float:right;" + style + " border-top: 5px solid #5B9BD5;' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                    else
                                        MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='" + style + " border-top: 5px solid #5B9BD5;' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";

                                    MenuDiv += "<a href='#'>";
                                    MenuDiv += "<span style='  font-weight: bold; color: black;'>" + MenuName + "</span></a>";
                                }
                                else
                                {
                                    MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='" + style + "' id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                    MenuDiv += "<a href='#'>";
                                    MenuDiv += "<span>" + MenuName + "</span></a>";
                                }

                            }
                            else
                            {
                                MenuDiv += "<li runat='server' id=" + Menu.Rows[i]["menu_id"].ToString() + " style='" + style + " '  id=\"" + Menu.Rows[i]["menu_id"] + "\" class='has-sub'>";
                                MenuDiv += "<a href='" + MenuLink + "'>";
                                MenuDiv += "<span>" + MenuName + "</span></a>";
                            }
                        }

                        if (Menu1.Rows.Count > 0)
                        {
                            if (Menu1.Rows.Count > 0)
                            {
                                MenuDiv += "<ul>";

                                for (var J = 0; J < Menu1.Rows.Count; J++) // Loop For First Level Menus
                                {
                                    MenuName = Menu1.Rows[J]["menu_description"].ToString();
                                    // MenuLink = Menu1.Rows[J]["window_name"].ToString();

                                    MenuLink = ui_page.ResolveClientUrl(Menu1.Rows[J]["window_name"].ToString());
                                    MenuId = Menu1.Rows[J]["menu_id"].ToString();

                                    if (MenuLink == "")
                                        MenuLink = "#\"";

                                    DataTable Menu2 = GetMenuList(Menu1.Rows[J]["menu_id"].ToString(), UserAccessMenuList);
                                    if (Menu2.Rows.Count > 0)
                                    {
                                        MenuDiv += "<li runat='server' id='" + MenuId + "'>";
                                        MenuDiv += "<a href='" + MenuLink + "'><span>" + MenuName + "</span></a></li>";
                                    }
                                    else
                                    {
                                        MenuDiv += "<li runat='server' id='" + MenuId + "'>";
                                        MenuDiv += "<a href='" + MenuLink + "'><span>" + MenuName + "<span></a></li>";
                                    }
                                }
                                MenuDiv += "</ul>";
                            }
                        }
                        MenuDiv += "</li>";
                    }
                }
                else
                {
                    MenuDiv += "<li runat='server' style='width: 71%; '  class='has-sub'></li>";//width:17%
                }
            }

            if (UserAccessMenuList != null && UserAccessMenuList.Rows.Count > 0)
            {
                DataRow[] dr = UserAccessMenuList.Select("menu_id ='Menu61'");//Changes 25112022 NitinBhai
                if (page_name == "MyCalendar.aspx")
                {
                    if (dr.Length > 0)
                    {
                        MenuDiv += "<li runat='server' style='width: 13%; border-top: 5px solid #5B9BD5;'  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/MyCalendar.aspx") + "'><span>My calendar</span></a></li> ";
                    }
                    
                    MenuDiv += " <li runat='server' style='width: 16%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/frm_personal_details.aspx") + "'><span style='float:right;'>Personal details</span></a></li>";//width: 17%
                }
                else if (page_name == "frm_personal_details.aspx")
                {
                    if (dr.Length > 0)
                    {
                        MenuDiv += "<li runat='server' style='width: 13%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/MyCalendar.aspx") + "'><span>My calendar</span></a></li> ";
                    }
                    
                    MenuDiv += " <li runat='server' style='width: 16%; border-top: 5px solid #5B9BD5;'  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/frm_personal_details.aspx") + "'><span style='float:right;'>Personal details</span></a></li>";//width: 17%
                }
                else if (temp_tutor != "temp")
                {
                    if (dr.Length > 0)
                    {
                        MenuDiv += "<li runat='server' style='width: 13%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/MyCalendar.aspx") + "'><span>My calendar</span></a></li> ";
                    }
                    
                    MenuDiv += " <li runat='server' style='width: 16%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/frm_personal_details.aspx") + "'><span style='float:right;'>Personal details</span></a></li>";//width: 17%
                }
                //    MenuDiv += "</ul>";
            }
            else
            {
                
                MenuDiv += "<li runat='server' style='width: 13%; margin-left:70%;'  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/MyCalendar.aspx") + "'><span>My calendar</span></a></li> ";
                MenuDiv += "<li runat='server' style='width: 16%; '  class='has-sub'><a href='" + ui_page.ResolveClientUrl("~/Admin/Master/frm_personal_details.aspx") + "'><span style='float:right;'>Personal details</span></a></li>";//width: 17%
                //   MenuDiv += "</ul>";

            }
            MenuDiv += "</ul>";
            return MenuDiv;
        }
        #endregion

        #region Get and Make the Sub Menu List
        public DataTable GetMenuList(string MenuId, DataTable UserAccessMenuList)
        {
            DataTable UserAccessSubMenuList = new DataTable();
            UserAccessSubMenuList = UserAccessMenuList.Clone();

            for (var i = 0; i < UserAccessMenuList.Rows.Count; i++)
            {
                if (UserAccessMenuList.Rows[i]["parent_menu_id"].ToString().Trim() == MenuId)
                {
                    UserAccessSubMenuList.ImportRow(UserAccessMenuList.Rows[i]);
                }
            }

            return UserAccessSubMenuList;
        }
        #endregion

        #region Get User Multiple Role Detail
        public bool ChangeUserRole(string UserId, string CurUserType, string NewUserType)
        {
            try
            {
                StringBuilder SQLSelect = new StringBuilder();

                SQLSelect.Append("update user_mst set user_type='" + NewUserType + "' where user_id='" + UserId + "' and user_type='" + CurUserType + "'");

                DBCommand.CommandText = SQLSelect.ToString();
                DBCommand.CommandType = CommandType.Text;

                DBCommand.Connection.Open();

                int res = DBCommand.ExecuteNonQuery();

                DBCommand.Connection.Close();

                if (res > 0)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                DBCommand.Connection.Close();
                //Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return false;
            }
        }
        #endregion


        #region Site Map Menu Details
        public string SiteMenuDetails(DataTable UserAccessMenuList, System.Web.UI.Page ui_page, string temp_tutor)
        {
            string MenuLink = "#", MenuName = "", MenuId = "", MenuNVALink = "#";

             var MenuDiv = "";
            string Menubar = "";

            if (UserAccessMenuList != null && UserAccessMenuList.Rows.Count > 0)
            {
                //Get Parent Menu
                DataTable Menu = GetMenuList("Root", UserAccessMenuList);
                if (Menu.Rows.Count != 0)
                {


                    for (var i = 0; i < Menu.Rows.Count; i++)   // Loop For First Level Menus
                    {
                        MenuNVALink = "#";
                        MenuName =  Menu.Rows[i]["menu_description"].ToString();
                        MenuLink = ui_page.ResolveClientUrl(Menu.Rows[i]["window_name"].ToString());

                        if (MenuLink == "") MenuLink = "#\"";

                        DataTable Menu1 = GetMenuList(Menu.Rows[i]["menu_id"].ToString(), UserAccessMenuList);

                        MenuDiv += "<section id=" + Menu.Rows[i]["menu_id"].ToString() + ">";
                        MenuDiv += "<h3> " + MenuName + "</h3>";
                        MenuDiv += "<div class='row'>";
                       // MenuDiv += "<div class='col-md-4'>";
                        if (i == 0)
                        {
                            Menubar += "<ul class='nav nav-pills'>";
                            MenuNVALink +=  Menu.Rows[i]["menu_id"].ToString();
                            Menubar += " <li role='presentation'><a href="+ MenuNVALink + ">"+ MenuName + "</a></li>";
                        }
                        else if( i == Menu.Rows.Count-1)
                        {
                            MenuNVALink += Menu.Rows[i]["menu_id"].ToString();
                            Menubar += " <li role='presentation'><a href=" + MenuNVALink + ">" + MenuName + "</a></li>";
                            Menubar += "</ul>";
                        }
                        else 
                        {
                            MenuNVALink += Menu.Rows[i]["menu_id"].ToString();
                            Menubar += " <li role='presentation'><a href=" + MenuNVALink + ">" + MenuName + "</a></li>";
                        }
                       
                        if (Menu1.Rows.Count > 0)
                        {
                            for (int J = 0; J < Menu1.Rows.Count; J++)
                            {
                                int k = J;
                                // if (k == 0)
                                // {
                                //     MenuDiv += "<ul>";
                                // }
                                // else if (k == 6)
                                // {
                                //     MenuDiv += "</ul>";
                                //     MenuDiv += "</div>";
                                //     MenuDiv += "<div class='col-md-4'>";
                                //     MenuDiv += "<ul>";
                                // }
                                // else if (k == 12)
                                // {
                                //     MenuDiv += "</ul>";
                                //     MenuDiv += "</div>";
                                //     MenuDiv += "<div class='col-md-4'>";
                                //     MenuDiv += "<ul>";
                                // }
                                // else if (k == 18)
                                // {
                                //     MenuDiv += "</ul>";
                                //     MenuDiv += "</div>";
                                //     MenuDiv += "</div>";
                                //     MenuDiv += "<hr style='border-bottom: 1px solid #ccc;'>";
                                //     MenuDiv += "<div class='row'>";
                                //     MenuDiv += "<div class='col-md-4'>";
                                //     MenuDiv += "<ul>";
                                // }
                                // else if (k == 24)
                                // {
                                //     MenuDiv += "</ul>";
                                //     MenuDiv += "</div>";
                                //     MenuDiv += "<div class='col-md-4'>";
                                //     MenuDiv += "<ul>";
                                // }
                                // else if (k == 30)
                                // {
                                //     MenuDiv += "</ul>";
                                //     MenuDiv += "</div>";
                                //     MenuDiv += "<div class='col-md-4'>";
                                //     MenuDiv += "<ul>";
                                // }
                                // else if (k == 36)
                                // {
                                //     MenuDiv += "</ul>";
                                //     MenuDiv += "</div>";
                                //     MenuDiv += "<div class='col-md-4'>";
                                //     MenuDiv += "<ul>";
                                // }
                                // else
                                // {
                                //
                                // }
                                MenuDiv += "<div class='col-md-4'>";
                                MenuDiv += "<ul>";

                                MenuName =  Menu1.Rows[J]["menu_description"].ToString();
                                MenuLink = ui_page.ResolveClientUrl(Menu1.Rows[J]["window_name"].ToString());
                                MenuLink = MenuLink.Replace("../", "Admin/");
                                MenuId = Menu1.Rows[J]["menu_id"].ToString();
                                if (MenuLink == "")
                                { MenuLink = "#\""; }
                                DataTable Menu2 = GetMenuList(Menu1.Rows[J]["menu_id"].ToString(), UserAccessMenuList);
                                if (Menu2.Rows.Count > 0)
                                {
                                    MenuDiv += "<li runat='server' id='" + MenuId + "'>";
                                    MenuDiv += "<a href='" + MenuLink + "' target='_blank'><span id='count_value'>" +(k + 1) + " "+ "</span>" + MenuName + "</a>";
                                    if (Menu1.Rows[J]["description"].ToString() != "")
                                    {
                                        MenuDiv += "<ol class='sub_des'><li><p id='test_1'><span>" + Menu1.Rows[J]["description"].ToString() + "</span></p></li></ol></li>";
                                    }
                                    else 
                                    { MenuDiv += "<ol class='sub_des'><li><p id='test_1'><span>" + MenuName + "</span></p></li></ol></li>"; }
                                    
                                }
                                else
                                {
                                    MenuDiv += "<li runat='server' id='" + MenuId + "'>";
                                    MenuDiv += "<a href='" + MenuLink + "' target='_blank'><span id='count_value'>" + (k + 1) + " " + "</span>" + MenuName + "</a></li>";
                                    if (Menu1.Rows[J]["description"].ToString() != "")
                                    {
                                        MenuDiv += "<ol class='sub_des'><li><p id='test_1'><span>" + Menu1.Rows[J]["description"].ToString() + "</span></p></li></ol></li>";
                                    }
                                    else
                                    { MenuDiv += "<ol class='sub_des'><li><p id='test_1'><span>" + MenuName + "</span></p></li></ol></li>"; }
                                }
                                MenuDiv += "</ul>";
                                MenuDiv += "</div>";
                            }




                           // MenuDiv += "</ul>";
                            MenuDiv += "</section>";
                        }
                    }
                }
                else
                {
                    MenuDiv += "<li runat='server' style='width: 71%; '  class='has-sub'></li>";//width:17%
                }
            }

            //return Menubar + MenuDiv;
            return  MenuDiv;
        }

        #endregion
    }
}
