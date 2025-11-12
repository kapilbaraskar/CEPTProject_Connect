using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;


public partial class Admin_Report_Student_fees_report_with_credit_choice : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    DataTable dt_ws_current_sem = new DataTable();

    string current_fees_sem, current_fees_year = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["user_type"].ToString() != "A")
            {
                if (Session["user_type"].ToString() != "A1")
                {



                    if (Session["user_type"].ToString() == "S")
                    {
                        Response.Redirect("~/Student/Dashboard.aspx?autho=false");
                    }
                    else if (Session["user_type"].ToString() == "I")
                    {
                        Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                    }
                }

            }

            dt_ws_current_sem = objmaster.Get_cept_current_sem_data("fees");

            if (dt_ws_current_sem != null)
            {
                current_fees_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
                current_fees_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();

                lbl_current_sem.InnerText = dt_ws_current_sem.Rows[0]["sem_desc"].ToString() + "-" + current_fees_year;
            }
        }
    }
}