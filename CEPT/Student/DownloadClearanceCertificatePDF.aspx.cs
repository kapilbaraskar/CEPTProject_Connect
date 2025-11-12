using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_DownloadClearanceCertificatePDF : System.Web.UI.Page
{
    WebService wbse = new WebService();
    Masters objmaster = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        string user_id = Request.QueryString.Get("user_id");
        string sem_code = Request.QueryString.Get("sem_code");
        string year_code = Request.QueryString.Get("year_code");

       
        DataTable dt = objmaster.Get_student_personal_data(user_id);

        if (dt != null)
        {
            stu_name.Text = dt.Rows[0]["first_name"].ToString() + " " + dt.Rows[0]["middle_name"].ToString() + " " + dt.Rows[0]["last_name"].ToString();
            code_num.Text = dt.Rows[0]["user_id"].ToString();
            cont_no.Text = dt.Rows[0]["applicant_mobile_no"].ToString();
            cetp_email.Text = dt.Rows[0]["mail"].ToString();
            name_prog.Text = dt.Rows[0]["prog_level_name"].ToString();
            faculty.Text = dt.Rows[0]["dept_name"].ToString();
            per_address.Text = dt.Rows[0]["applicant_address_house_no"].ToString();
            cor_address.Text = dt.Rows[0]["preferred_mailing_address_house_no"].ToString();
            per_email.Text = dt.Rows[0]["alternet_mail"].ToString();
        }

        DataTable dt_clearance_data = objmaster.get_data_for_clearance_certificate(user_id, sem_code, year_code);

        if (dt_clearance_data != null)
        {
            hdn_clearance_data.Value = wbse.GetJson1(dt_clearance_data);
        }
    }
}