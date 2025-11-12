using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class MasterPageAlumini : System.Web.UI.MasterPage
{
    Masters objmaster = new Masters();
    string str;

    protected void Page_Load(object sender, EventArgs e)
    {
         if(Session["UserId"] != null)
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
             
                DataTable dtuservendor = objmaster.GetVendorname(str);
                if (dtuservendor != null)
                {
                    lblusername.Text = dtuservendor.Rows[0]["user_name"].ToString();
                   // Lblusaernameanother.Text = "CEPT UNIVERSITY";
                }
            }
            else
            {
                if (dtus.Rows[0]["user_type"].ToString() == "S")
                {
                    student_menu.Style.Add("display", "block");
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

              if (Session["user_type"].ToString() == "S")
                {
                    student_menu.Style.Add("display", "block");
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
