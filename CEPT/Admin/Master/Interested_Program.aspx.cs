using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Interested_Program : System.Web.UI.Page
{
    Masters masters = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_user_id.Value = Session["userid"].ToString();
        hdn_tutor_type.Value = HttpContext.Current.Session["designation"].ToString();
        if (Session["user_type"].ToString() != "I2" && Session["user_type"].ToString() != "PC")
        {
            Response.Redirect("~/Admin/Master/Home.aspx");
        }
        if (Session["superviser_code"].ToString() == "")
        {
            //if (Session["is_submit"].ToString() == "N")
            //{
            //    //Response.Redirect("~/Admin/Master/Home.aspx");
            //    Response.Redirect("~/Admin/Master/vf_edit_personal_detail.aspx?ic=" + HttpContext.Current.Session["UserId"].ToString() + "&type=tutor");
            //}
        }
        //DataTable user_dt = masters.Get_disable_user_detail(HttpContext.Current.Session["UserId"].ToString());
        //DataTable dt = masters.get_instructor_dtl(HttpContext.Current.Session["UserId"].ToString());
        //if (dt!= null)
        //{
            //Boolean allow_user = true;
            //if (user_dt != null)
            //{
            //    allow_user = false;
            //}
            //if (allow_user)
            //{
            //    string[] selectedColumns = new[] { "title", "first_name", "last_name", "gender", "mail", "indian_citizen", "dob", "highest_qualification", "total_experiance", "address", "city", "state", "country" };
            //
            //    DataTable dt_ = new DataView(dt).ToTable(false, selectedColumns);
            //    foreach (DataRow dtRow in dt_.Rows)
            //    {
            //        // On all tables' columns
            //        foreach (DataColumn dc in dt_.Columns)
            //        {
            //            var field1 = dtRow[dc].ToString();
            //            if (field1 == "")
            //            {
            //                Response.Redirect("~/Admin/Master/vf_edit_personal_detail.aspx?ic=" + HttpContext.Current.Session["UserId"].ToString() + "&type=tutor");
            //            }
            //        }
            //    }
            //}
           
       // }
        //if (Session["is_submit"].ToString() == "N")
        //{
        //    //Response.Redirect("~/Admin/Master/Home.aspx");
        //    Response.Redirect("~/Admin/Master/vf_edit_personal_detail.aspx?ic=" + HttpContext.Current.Session["UserId"].ToString() + "&type=tutor");
        //}
    }
}