using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Fees_Status : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Masters objmaster = new Masters();
        DataTable dt_cur_sem = new DataTable();

        DataTable dt_foundation_fees_sem_dtl_user = objmaster.Get_fees_sem_dtl_of_foundation_student(Session["UserId"].ToString());

        if (dt_foundation_fees_sem_dtl_user != null)
        {
            if (dt_foundation_fees_sem_dtl_user.Rows[0]["cur_foundation_sem"].ToString() == "1")
            {
                dt_cur_sem = objmaster.Get_cept_current_sem_data("CFP 1st Sem Fees");
            }
            else if (dt_foundation_fees_sem_dtl_user.Rows[0]["cur_foundation_sem"].ToString() == "2")
            {
                dt_cur_sem = objmaster.Get_cept_current_sem_data("CFP 2nd Sem Fees");
            }
        }
        else
        {
            dt_cur_sem = objmaster.Get_cept_current_sem_data("fees_installment");
        }

        fees_sem.Value = dt_cur_sem.Rows[0]["sem_code"].ToString();
        fees_year.Value = dt_cur_sem.Rows[0]["year_code"].ToString();
    }

    protected void Send_Response(object sender, EventArgs e)
    {
        Application["EncResponse"] = KotakAPIEncReponse.Value;
        Response.Redirect("~/Student/KotakAPIResponse.aspx");
    }

}