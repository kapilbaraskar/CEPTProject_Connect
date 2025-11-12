using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using BLL.Master;

public partial class Student_Fees_payment_YesBank_offline : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string user_id = Request.QueryString["user_id"].ToString();
            string acountno = Request.QueryString["accountno"].ToString();
            Masters objmaster = new Masters();

            acc_no.InnerHtml ="<b>"+ acountno +"</b>";
            int digitbefor = acountno.Length - 8;
            digit.InnerHtml = digitbefor.ToString();

            //bool fine_added = false;
            bool insert_fine = false;
            bool late_fees = false;

            decimal fine_amount = 0; 
            decimal fine_amount_1 = 0;
            decimal fine_amount_2 = 0;
            decimal fine_amount_3 = 0;

            int cur_inst = 0;
            string last_date_of_fees = "";

            lbl_generated_date.Text = DateTime.Now.ToLongDateString();

            DataTable dt_user_fees_installment_dtl = objmaster.get_user_fees_installment_dtl(user_id, "fees");

            int no_of_installment = Convert.ToInt32(dt_user_fees_installment_dtl.Rows[0]["no_of_installment"].ToString());

            int cur_installment = 0;

            for (int i = 1; i <= no_of_installment; i++)
            {
                if (dt_user_fees_installment_dtl.Rows[0]["is_installment" + i + "_paid"].ToString() != "Y")
                {
                    cur_installment = i;
                    break;
                }
            }

            DataTable dt_fine_dtl = objmaster.get_fine_dtl_for_fees(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString());

            if (cur_installment == 1)
            {
                last_date_of_fees = dt_fine_dtl.Rows[0]["end_date"].ToString();
            }
            else if (cur_installment == 2)
            {
                last_date_of_fees = dt_fine_dtl.Rows[0]["end_date2"].ToString();
            }
            else if (cur_installment == 3)
            {
                last_date_of_fees = dt_fine_dtl.Rows[0]["end_date3"].ToString();
            }

            if (DateTime.Now > Convert.ToDateTime(last_date_of_fees))//If Todays Date is greater than last date of fees, calculate fine and add.
            {
                insert_fine = true;
                late_fees = true;

                String days = (DateTime.Now - Convert.ToDateTime(last_date_of_fees)).TotalDays.ToString();

                int total_days = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(days)));

                if (total_days <= WebService.firstDay)
                {
                    if (dt_fine_dtl.Rows[0]["fine"].ToString() != "")
                    {
                        fine_amount = Convert.ToDecimal(total_days) * Convert.ToDecimal(dt_fine_dtl.Rows[0]["fine"].ToString());
                    }
                }
                else if (total_days <= WebService.secondDay)
                {
                    if (dt_fine_dtl.Rows[0]["fine2"].ToString() != "")
                    {
                        //fine_amount = Convert.ToDecimal(total_days) * Convert.ToDecimal(dt_fine_dtl.Rows[0]["fine2"].ToString());
                        fine_amount = Convert.ToDecimal(total_days - WebService.firstDay) * Convert.ToDecimal(dt_fine_dtl.Rows[0]["fine2"].ToString());
                        fine_amount = fine_amount + (Convert.ToDecimal(WebService.firstDay) * Convert.ToDecimal(dt_fine_dtl.Rows[0]["fine"].ToString()));//WebService.SevenDaysFine
                    }
                }
                else
                {
                    //What to do?
                }
            }

            fine_amount_1 = fine_amount;
            fine_amount_2 = fine_amount;
            fine_amount_3 = fine_amount;

            //DataTable dt_fine_dtl = objmaster.get_fine_dtl_for_fees(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString());

            //if (DateTime.Now > Convert.ToDateTime(dt_fine_dtl.Rows[0]["end_date"].ToString()))//If Todays Date is greater than last date of fees, calculate fine and add.
            //{
            //    String days = (DateTime.Now - Convert.ToDateTime(dt_fine_dtl.Rows[0]["end_date"].ToString())).TotalDays.ToString();

            //    int total_days = Convert.ToInt32(Math.Ceiling(Convert.ToDecimal(days)));

            //    //if (total_days <= 7)
            //    //{
            //    //    if (dt_fine_dtl.Rows[0]["fine"].ToString() != "")
            //    //    {
            //    //        fine_amount = Convert.ToDecimal(total_days) * Convert.ToDecimal(dt_fine_dtl.Rows[0]["fine"].ToString());
            //    //        amount = Convert.ToDecimal(amount + fine_amount);//Add Fine
            //    //                                                         //fine_added = true;
            //    //    }
            //    //}
            //    //else if (total_days <= 84)
            //    //{
            //    //    if (dt_fine_dtl.Rows[0]["fine2"].ToString() != "")
            //    //    {
            //    //        fine_amount = Convert.ToDecimal(total_days) * Convert.ToDecimal(dt_fine_dtl.Rows[0]["fine2"].ToString());
            //    //        amount = Convert.ToDecimal(amount + fine_amount);//Add Fine
            //    //                                                         //fine_added = true;
            //    //    }
            //    //}
            //    //else 
            //    //{ 

            //    //}

            //    if (dt_fine_dtl.Rows[0]["fine"].ToString() != "")
            //    {
            //        fine_amount = Convert.ToDecimal(total_days) * Convert.ToDecimal(dt_fine_dtl.Rows[0]["fine"].ToString());//Calculate Fine
            //        //fine_added = true;
            //    }
            //}

            if (dt_user_fees_installment_dtl != null)
            {
                if (dt_user_fees_installment_dtl.Rows[0]["fees_type"].ToString() == "H")
                {
                    if (insert_fine)
                    {
                        DataTable dt_saved_fine_dtl_1 = objmaster.get_fine_dtl_for_fees_installement_wise(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), 1);

                        if (dt_saved_fine_dtl_1 != null)
                        {
                            //2. is_admin = Y then not to insert if not then insert(Makes all cancel_flag Y them=n insert) 2 Master
                            if (dt_saved_fine_dtl_1.Rows[0]["is_admin"].ToString() == "Y")
                            {
                                insert_fine = false;
                                fine_amount_1 = Convert.ToDecimal(dt_saved_fine_dtl_1.Rows[0]["installment_fine"].ToString());
                            }

                            if (insert_fine)
                            {
                                //Insert and Update Fine Second Fine for all user
                                //3. created_date = current_date then not to insert (If not then insert (Go ahead)) 2 Master
                                DateTime _dateJoin = Convert.ToDateTime(dt_saved_fine_dtl_1.Rows[0]["created_date"].ToString());
                                DateTime _CurDate = DateTime.Now;

                                if (_CurDate.Date == _dateJoin.Date)//check proper
                                {
                                    insert_fine = false;
                                    fine_amount_1 = Convert.ToDecimal(dt_saved_fine_dtl_1.Rows[0]["installment_fine"].ToString());
                                }
                            }
                        }
                        else
                        {
                            //Insert Fine First Time for all user
                            insert_fine = true;
                        }
                    }

                    if (fine_amount_1 == 0)
                    {
                        payable_amount.InnerHtml = "Payable Amount : " + dt_user_fees_installment_dtl.Rows[0]["installment1"].ToString();//Add Fine
                    }
                    else
                    {
                        payable_amount.InnerHtml = "Payable Amount : " + (fine_amount_1 + Convert.ToDecimal(dt_user_fees_installment_dtl.Rows[0]["installment1"].ToString()));//Add Fine
                    }
                    cur_inst = 1;
                }
                else if (dt_user_fees_installment_dtl.Rows[0]["fees_type"].ToString() == "F" && dt_user_fees_installment_dtl.Rows[0]["no_of_installment"].ToString() == "1")
                {
                    if (insert_fine)
                    {
                        DataTable dt_saved_fine_dtl_1 = objmaster.get_fine_dtl_for_fees_installement_wise(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), 1);

                        if (dt_saved_fine_dtl_1 != null)
                        {
                            //2. is_admin = Y then not to insert if not then insert(Makes all cancel_flag Y them=n insert) 2 Master
                            if (dt_saved_fine_dtl_1.Rows[0]["is_admin"].ToString() == "Y")
                            {
                                insert_fine = false;
                                fine_amount_1 = Convert.ToDecimal(dt_saved_fine_dtl_1.Rows[0]["installment_fine"].ToString());
                            }

                            if (insert_fine)
                            {
                                //Insert and Update Fine Second Fine for all user
                                //3. created_date = current_date then not to insert (If not then insert (Go ahead)) 2 Master
                                DateTime _dateJoin = Convert.ToDateTime(dt_saved_fine_dtl_1.Rows[0]["created_date"].ToString());
                                DateTime _CurDate = DateTime.Now;

                                if (_CurDate.Date == _dateJoin.Date)//check proper
                                {
                                    insert_fine = false;
                                    fine_amount_1 = Convert.ToDecimal(dt_saved_fine_dtl_1.Rows[0]["installment_fine"].ToString());
                                }
                            }
                        }
                        else
                        {
                            //Insert Fine First Time for all user
                            insert_fine = true;
                        }
                    }

                    if (fine_amount_1 == 0)
                    {
                        payable_amount.InnerHtml = "Payable Amount (Full) : " + dt_user_fees_installment_dtl.Rows[0]["installment1"].ToString();//Add Fine
                    }
                    else
                    {
                        payable_amount.InnerHtml = "Payable Amount (Full) : " + (fine_amount_1 + Convert.ToDecimal(dt_user_fees_installment_dtl.Rows[0]["installment1"].ToString()));//Add Fine
                    }
                    cur_inst = 1;
                }
                else
                {
                    if (dt_user_fees_installment_dtl.Rows[0]["is_installment1_paid"].ToString() != "Y")
                    {
                        if (insert_fine)
                        {
                            DataTable dt_saved_fine_dtl_1 = objmaster.get_fine_dtl_for_fees_installement_wise(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), 1);

                            if (dt_saved_fine_dtl_1 != null)
                            {
                                //2. is_admin = Y then not to insert if not then insert(Makes all cancel_flag Y them=n insert) 2 Master
                                if (dt_saved_fine_dtl_1.Rows[0]["is_admin"].ToString() == "Y")
                                {
                                    insert_fine = false;
                                    fine_amount_1 = Convert.ToDecimal(dt_saved_fine_dtl_1.Rows[0]["installment_fine"].ToString());
                                }

                                if (insert_fine)
                                {
                                    //Insert and Update Fine Second Fine for all user
                                    //3. created_date = current_date then not to insert (If not then insert (Go ahead)) 2 Master
                                    DateTime _dateJoin = Convert.ToDateTime(dt_saved_fine_dtl_1.Rows[0]["created_date"].ToString());
                                    DateTime _CurDate = DateTime.Now;

                                    if (_CurDate.Date == _dateJoin.Date)//check proper
                                    {
                                        insert_fine = false;
                                        fine_amount_1 = Convert.ToDecimal(dt_saved_fine_dtl_1.Rows[0]["installment_fine"].ToString());
                                    }
                                }
                            }
                            else
                            {
                                //Insert Fine First Time for all user
                                insert_fine = true;
                            }
                        }

                        if (fine_amount_1 == 0)
                        {
                            payable_amount.InnerHtml = "Payable Amount (Installment 1) : " + dt_user_fees_installment_dtl.Rows[0]["installment1"].ToString();//Add Fine
                        }
                        else
                        {
                            payable_amount.InnerHtml = "Payable Amount (Installment 1) : " + (fine_amount_1 + Convert.ToDecimal(dt_user_fees_installment_dtl.Rows[0]["installment1"].ToString()));//Add Fine
                        }
                        cur_inst = 1;
                    }
                    else if (dt_user_fees_installment_dtl.Rows[0]["is_installment2_paid"].ToString() != "Y")
                    {
                        if (insert_fine)
                        {
                            DataTable dt_saved_fine_dtl_2 = objmaster.get_fine_dtl_for_fees_installement_wise(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), 2);

                            if (dt_saved_fine_dtl_2 != null)
                            {
                                //2. is_admin = Y then not to insert if not then insert(Makes all cancel_flag Y them=n insert) 2 Master
                                if (dt_saved_fine_dtl_2.Rows[0]["is_admin"].ToString() == "Y")
                                {
                                    insert_fine = false;
                                    fine_amount_2 = Convert.ToDecimal(dt_saved_fine_dtl_2.Rows[0]["installment_fine"].ToString());
                                }

                                if (insert_fine)
                                {
                                    //Insert and Update Fine Second Fine for all user
                                    //3. created_date = current_date then not to insert (If not then insert (Go ahead)) 2 Master
                                    DateTime _dateJoin = Convert.ToDateTime(dt_saved_fine_dtl_2.Rows[0]["created_date"].ToString());
                                    DateTime _CurDate = DateTime.Now;

                                    if (_CurDate.Date == _dateJoin.Date)//check proper
                                    {
                                        insert_fine = false;
                                        fine_amount_2 = Convert.ToDecimal(dt_saved_fine_dtl_2.Rows[0]["installment_fine"].ToString());
                                    }
                                }
                            }
                            else
                            {
                                //Insert Fine First Time for all user
                                insert_fine = true;
                            }
                        }

                        if (fine_amount_2 == 0)
                        {
                            payable_amount.InnerHtml = "Payable Amount (Installment 2) : " + dt_user_fees_installment_dtl.Rows[0]["installment2"].ToString();//Add Fine
                        }
                        else
                        {
                            payable_amount.InnerHtml = "Payable Amount (Installment 2) : " + (fine_amount_2 + Convert.ToDecimal(dt_user_fees_installment_dtl.Rows[0]["installment2"].ToString()));//Add Fine
                        }
                        cur_inst = 2;
                    }
                    else if (dt_user_fees_installment_dtl.Rows[0]["is_installment3_paid"].ToString() != "Y")
                    {
                        if (insert_fine)
                        {
                            DataTable dt_saved_fine_dtl_3 = objmaster.get_fine_dtl_for_fees_installement_wise(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), 3);

                            if (dt_saved_fine_dtl_3 != null)
                            {
                                //2. is_admin = Y then not to insert if not then insert(Makes all cancel_flag Y them=n insert) 2 Master
                                if (dt_saved_fine_dtl_3.Rows[0]["is_admin"].ToString() == "Y")
                                {
                                    insert_fine = false;
                                    fine_amount_3 = Convert.ToDecimal(dt_saved_fine_dtl_3.Rows[0]["installment_fine"].ToString());
                                }

                                if (insert_fine)
                                {
                                    //Insert and Update Fine Second Fine for all user
                                    //3. created_date = current_date then not to insert (If not then insert (Go ahead)) 2 Master
                                    DateTime _dateJoin = Convert.ToDateTime(dt_saved_fine_dtl_3.Rows[0]["created_date"].ToString());
                                    DateTime _CurDate = DateTime.Now;

                                    if (_CurDate.Date == _dateJoin.Date)//check proper
                                    {
                                        insert_fine = false;
                                        fine_amount_3 = Convert.ToDecimal(dt_saved_fine_dtl_3.Rows[0]["installment_fine"].ToString());
                                    }
                                }
                            }
                            else
                            {
                                //Insert Fine First Time for all user
                                insert_fine = true;
                            }
                        }

                        if (fine_amount_3 == 0)
                        {
                            payable_amount.InnerHtml = "Payable Amount (Installment 3) : " + dt_user_fees_installment_dtl.Rows[0]["installment3"].ToString();//Add Fine
                        }
                        else
                        {
                            payable_amount.InnerHtml = "Payable Amount (Installment 3) : " + (fine_amount_3 + Convert.ToDecimal(dt_user_fees_installment_dtl.Rows[0]["installment3"].ToString()));//Add Fine
                        }
                        cur_inst = 3;
                    }
                    else
                    {
                        payable_amount.InnerHtml = "Payable Amount : 0";//Add Fine
                    }
                }
                
                //If Student Uploaded Payslip Then No entry again.
                DataTable dt_uploaded_payslip_dtl = objmaster.get_uploaded_payslip_dtl(cur_inst.ToString(), user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString());
                
                bool payslip_uploaded = false;
                
                if (dt_uploaded_payslip_dtl != null)
                {
                    payslip_uploaded = true;
                    insert_fine = false;
                }

                if (cur_inst == 1) { fine_amount = fine_amount_1; }
                if (cur_inst == 2) { fine_amount = fine_amount_2; }
                if (cur_inst == 3) { fine_amount = fine_amount_3; }

                if (late_fees)
                {
                    if (insert_fine)
                    {
                        //update cancel_flag Y
                        bool result = objmaster.update_user_wise_fees_dtl(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), cur_inst, fine_amount);

                        //insert
                        if (result)
                        {
                            result = objmaster.save_user_wise_fees_dtl(user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), cur_inst, fine_amount, "Offline");
                        }
                    }
                    else
                    {
                        if (!payslip_uploaded)
                        {
                            bool fine_updated = objmaster.update_fine_user_fees_fine_dtl(fine_amount, cur_inst.ToString(), user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString(), "Offline");
                        }
                    }
                }
                //if (fine_added)
                //{
                //fine_amount update user_fees_installment_dtl
                //      bool fine_updated = objmaster.update_fine_user_fees_installment_dtl(fine_amount, cur_inst, user_id, dt_user_fees_installment_dtl.Rows[0]["semester_type"].ToString(), dt_user_fees_installment_dtl.Rows[0]["year_semester"].ToString());
                //}
            }
        }
        catch (Exception ex) {
        }
    }
}