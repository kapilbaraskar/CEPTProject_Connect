using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.SessionState;
using BLL.Master;
using System.Data;

public partial class Student_frm_upload_manually_payslip : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {

        Response.Redirect("~/Student/Dashboard.aspx");

        if (!IsPostBack)
        {
            try
            {
                if (Session["UserId"].ToString() != "")
                {
                    //if (Session["prog_code"].ToString() == "3")
                    //{

                    //}
                    //else
                    //{
                    //    Response.Redirect("~/Student/Dashboard.aspx", false);
                    //}
                }
            }
            catch (Exception ex)
            {
            
            }
        }
    }
}