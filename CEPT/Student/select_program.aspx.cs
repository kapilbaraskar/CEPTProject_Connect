using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using System.Data;

public partial class Student_select_program : System.Web.UI.Page
{
    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {

                if (Session["UserId"].ToString() != "")
                {
                    string mail = objmaster.Get_user_mail(Session["UserId"].ToString());

                    if (mail != "")
                    {
                        hdn_mail.Value = mail;
                        DataTable dt_multipel_email = objmaster.Get_multiple_same_email_user(mail);

                      

                        if (dt_multipel_email != null)
                        {
                            string data = "<select id='drp_program_data' name='prog_data'>";

                            string flag = "N";

                            for (int i = 0; i < dt_multipel_email.Rows.Count; i++)
                            {
                                if (dt_multipel_email.Rows[i]["prog_code"].ToString() == "2")
                                {
                                    if (dt_multipel_email.Rows[i]["prog_level_code"].ToString() != "")
                                    {

                                        data += "<option value=" + dt_multipel_email.Rows[i]["prog_level_code"] + ">" + dt_multipel_email.Rows[i]["prog_level_name"] + "</option>";
                                    }
                                    else
                                    {
                                        flag = "Y";
                                    }
                                }
                                else
                                {
                                    switch (dt_multipel_email.Rows[i]["dept_code"].ToString())
                                    {

                                        case "1":

                                            data += "<option value=" + dt_multipel_email.Rows[i]["dept_code"] + ">Bachelor's in Architecture</option>";
                                            break;
                                        case "2":

                                            data += "<option value=" + dt_multipel_email.Rows[i]["dept_code"] + ">Bachelor's in Design</option>";
                                            break;
                                        case "4":

                                            data += "<option value=" + dt_multipel_email.Rows[i]["dept_code"] + ">Bachelor`s in Planning</option>";
                                            break;
                                        case "5":

                                            data += "<option value=" + dt_multipel_email.Rows[i]["dept_code"] + ">Bachelor's in Technology</option>";
                                            break;
                                        case "7":

                                            data += "<option value=" + dt_multipel_email.Rows[i]["dept_code"] + ">Summer Winter</option>";
                                            break;
                                        default:
                                            break;
                                    }

                                }
                            }


                            if (flag == "Y")
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Some Problem found in retrieve your program.')", true);
                             //   drp_program.InnerHtml = "Some Problem found in retrieve your program";
                            }
                            else
                            {
                                data += "</select>";
                                drp_program.InnerHtml = data.ToString();
                            }
                        }
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Some Problem found in retrieve your program.')", true);
                       // drp_program.InnerHtml = "Some Problem found in retrieve your program";
                    }
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Some Problem found in retrieve your program.')", true);
              //  drp_program.InnerHtml = "Some Problem found in retrieve your program";
            }
        }
    }
    protected void btn_save_program_Click(object sender, EventArgs e)
    {
        try
        {

            Boolean status = true;
            string selected_value = Request.Form["prog_data"];

            if (selected_value.Trim() != "")
            {

                if (hdn_mail.Value != "")
                {


                    if (selected_value.Length > 1)
                    {
                        status = objmaster.Update_status_PG_for_user_master(selected_value, hdn_mail.Value);
                    }
                    else
                    {
                        status = objmaster.Update_status_UG_for_user_master(selected_value, hdn_mail.Value);
                    }

                    if (status == true)
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Your Program is saved successfully.')", true);

                        Response.Redirect("~/Login.aspx?logout=2");
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Some Problem found in save your program.')", true);
                
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Some Problem found in save your program.')", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Some Problem found in save your program.')", true);
          //  drp_program.InnerHtml = "Some Problem found in save your program.";
        }
        
    }
}