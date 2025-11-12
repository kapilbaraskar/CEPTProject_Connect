using BLL.Master;
using BLL.Utilities1;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_EazypayResponseHandler : System.Web.UI.Page
{
    #region <-- Variable Declaration -->
    Log objLog = new Log();
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] != null)
        {
            hdn_user_id.Value = Session["UserId"].ToString();
        }

        Masters objmaster = new Masters();
        DataTable dt_cur_sem = new DataTable();

        DataTable dt_foundation_fees_sem_dtl_user = objmaster.Get_fees_sem_dtl_of_foundation_student(Session["UserId"].ToString());

        if (dt_foundation_fees_sem_dtl_user != null)
        {
            if (dt_foundation_fees_sem_dtl_user.Rows[0]["cur_foundation_sem"].ToString() == "1")
            {
                dt_cur_sem = objmaster.Get_cept_current_sem_data("CFP 1st Sem Fees");
                hdn_fond.Value = "Y";
            }
            else if (dt_foundation_fees_sem_dtl_user.Rows[0]["cur_foundation_sem"].ToString() == "2")
            {
                dt_cur_sem = objmaster.Get_cept_current_sem_data("CFP 2nd Sem Fees");
                hdn_fond.Value = "Y";
            }
        }
        else
        {
            dt_cur_sem = objmaster.Get_cept_current_sem_data("fees_installment");
            hdn_fond.Value = "N";
        }

        fees_sem.Value = dt_cur_sem.Rows[0]["sem_code"].ToString();
        fees_year.Value = dt_cur_sem.Rows[0]["year_code"].ToString();

        hdn_year_code.Value = Session["year_code"].ToString();
        hdn_prog_code.Value = Session["prog_code"].ToString();
        hdn_dept_code.Value = Session["dept_code"].ToString();
        hdn_created_by.Value = Session["created_by"].ToString();

        if (Session["UserId"] != null && Session["dept_code"] != null)
        {
            switch (Session["dept_code"].ToString())
            {
                case "1":
                    hdn_yes_virtual_acc.Value = "CEPTFACM" + Session["UserId"].ToString();
                    break;
                case "2":
                    hdn_yes_virtual_acc.Value = "CEPTFDCM" + Session["UserId"].ToString();
                    break;
                case "3":
                    hdn_yes_virtual_acc.Value = "CEPTFMCM" + Session["UserId"].ToString();
                    break;
                case "4":
                    hdn_yes_virtual_acc.Value = "CEPTFPCM" + Session["UserId"].ToString();
                    break;
                case "5":
                    hdn_yes_virtual_acc.Value = "CEPTFTCM" + Session["UserId"].ToString();
                    break;
            }
        }
    }
}