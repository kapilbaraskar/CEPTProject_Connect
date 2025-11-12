using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class MasterPageProject : System.Web.UI.MasterPage
{
    Masters objmaster = new Masters();
    string str;
    protected void Page_Load(object sender, EventArgs e)
    {
        //   Response.Redirect("~/Site_maintenance.htm");

        if (Session["UserId"] != null)
        {
            WebService objService = new WebService();

         
            bool flag = false;
            if (Session["user_type"].ToString() == "S")
            {
                string str_stud_list = objService.get_student_detail();

                JavaScriptSerializer ser = new JavaScriptSerializer();

                List<Dictionary<string, string>> dt_stud_list = ser.Deserialize<List<Dictionary<string, string>>>(str_stud_list);

               
                for (int i = 0; i < dt_stud_list.Count; i++)
                {
                    if (dt_stud_list[i]["user_id"].ToString() == Session["UserId"].ToString())
                    {
                        flag = true;
                    }
                }
            }
            else if (Session["user_type"].ToString() == "I2" || Session["user_type"].ToString() == "PC" || Session["user_type"].ToString() == "FA")
            {
                flag = true;
            }
            
            if(!flag)
            {
                Response.Redirect("~/Student/Dashboard.aspx");
            }

            if (Session["reset_flag"] == "R")
            {
                Response.Redirect("~/reset_password.aspx");
            }
            else
            {
                str = Session["UserId"].ToString();
                hdnuserid.Value = str;
                hdnusertype.Value = Session["user_type"].ToString();
            }
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
        DataTable dtus = new DataTable();
        dtus = objmaster.userMaster(str);
        if (dtus != null)
        {
            //  lblusername.Attributes.Add("style", "text-decoration:blink");
            if (dtus.Rows[0]["user_type"].ToString() == "V")
            {
                div_admin.Style.Add("display", "none");
                DataTable dtuservendor = objmaster.GetVendorname(str);
                if (dtuservendor != null)
                {
                    lblusername.Text = dtuservendor.Rows[0]["user_name"].ToString();
                    // Lblusaernameanother.Text = "CEPT UNIVERSITY";
                }
            }
            else
            {
                div_admin1.Style.Add("display", "none");

                if (dtus.Rows[0]["user_type"].ToString() == "A")
                {
                    admin_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "S")
                {
                    student_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "I")
                {
                    it_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "A1")
                {
                    admin1_menu.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "A2")
                {
                    admin2_menu.Style.Add("display", "block");
                }


                else if (dtus.Rows[0]["user_type"].ToString() == "PC")
                {
                    Prog_Coord.Style.Add("display", "block");
                }
                else if (dtus.Rows[0]["user_type"].ToString() == "I2")
                {
                    faculty.Style.Add("display", "block");
                }


                else if (dtus.Rows[0]["user_type"].ToString() == "F")
                {
                    Finance.Style.Add("display", "block");
                }
                lblusername.Text = dtus.Rows[0]["user_name"].ToString();
                //  Lblusaernameanother.Text = "CEPT UNIVERSITY";
            }

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



                if (Session["user_type"].ToString() == "A")
                {
                    admin_menu.Style.Add("display", "block");
                }
                if (Session["user_type"].ToString() == "A1")
                {
                    admin1_menu.Style.Add("display", "block");
                }
                if (Session["user_type"].ToString() == "A2")
                {
                    admin2_menu.Style.Add("display", "block");
                }
                else if (Session["user_type"].ToString() == "S")
                {
                    student_menu.Style.Add("display", "block");
                }
                else if (Session["user_type"].ToString() == "I")
                {
                    it_menu.Style.Add("display", "block");
                }

            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        if (Session["UserId"] != null)
        {
            lblusername.Text = Session["UserName"].ToString();
            //  Lblusaernameanother.Text = "CEPT UNIVERSITY";

        }
    }
}
