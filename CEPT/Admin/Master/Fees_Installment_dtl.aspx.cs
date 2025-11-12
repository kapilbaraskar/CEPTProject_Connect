using BLL.Master;
using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_Fees_Installment_dtl : System.Web.UI.Page
{
    Masters masters = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    {
        try
        {
            string student_ids = hdn_student_ids.Value;
            string user_id = "";
            
            if (student_ids.Split(',').Length > 0)
            {
                for (int j = 0; j < student_ids.Split(',').Length; j++)
                {
                    if (j == 0)
                        user_id += "'" + student_ids.Split(',')[j] + "'";
                    else
                        user_id += ",'" + student_ids.Split(',')[j] + "'";
                }

                DataTable dts = masters.Get_scholship_dtl_Excel_Data(user_id, hdn_sem.Value, hdn_year.Value);

                if (dts != null)
                {
                    DataTable dt = new DataTable();
                    DataRow workRow;
                    dt.Columns.Add("STUDENT_CODE");
                    dt.Columns.Add("STUDENT_NAME");
                    dt.Columns.Add("TOTAL_FEES_AMOUNT");
                    dt.Columns.Add("SCHOLARSHIP_PERCENTAGE");
                    dt.Columns.Add("APPROVE_SCHOLARSHIP_AMOUNT");
                    dt.Columns.Add("APPROVE_DATE");
                    dt.Columns.Add("REF_NO_VOUCHER_NO");
                    dt.Columns.Add("REMARK");
                    dt.Columns.Add("INSTALLMENT_1_AMOUNT");
                    dt.Columns.Add("PAYMENT_INSTALLMENT_1_PAID");
                    dt.Columns.Add("INSTALLMENT_2_AMOUNT");
                    dt.Columns.Add("PAYMENT_INSTALLMENT_2_PAID");
                    dt.Columns.Add("INSTALLMENT_3_AMOUNT");
                    dt.Columns.Add("PAYMENT_INSTALLMENT_3_PAID");
                    dt.Columns.Add("INSTALLMENT_4_AMOUNT");
                    dt.Columns.Add("PAYMENT_INSTALLMENT_4_PAID");
                    dt.Columns.Add("CARRY_FORWARD_AMOUNT");
                    dt.Columns.Add("SCHOLARSHIP_TYPE");
                    dt.Columns.Add("SEMESTER");
                    dt.Columns.Add("YEAR");

                    foreach (DataRow dr in dts.Rows)
                    {
                        for (int i = 0; i < 1; i++)
                        {
                            workRow = dt.NewRow();
                            workRow[0] = dr[0].ToString();//STUDENT_CODE
                            workRow[1] = dr[1].ToString();//STUDENT_NAME
                            workRow[2] = dr[2].ToString();//TOTAL_FEES_AMOUNT
                            workRow[3] = dr[3].ToString();//SCHOLARSHIP_PERCENTAGE
                            workRow[4] = dr[4].ToString();//APPROVE_SCHOLARSHIP_AMOUNT
                            workRow[5] = dr[5].ToString();//APPROVE_DATE
                            workRow[6] = dr[6].ToString();//REF_NO_VOUCHER_NO
                            workRow[7] = dr[7].ToString();//REMARK
                            workRow[8] = dr[9].ToString();//INSTALLMENT_1_AMOUNT
                            workRow[9] = dr[14].ToString();//PAYMENT_INSTALLMENT_1_PAID
                            workRow[10] = dr[10].ToString();//INSTALLMENT_2_AMOUNT
                            workRow[11] = dr[15].ToString();//PAYMENT_INSTALLMENT_2_PAID
                            workRow[12] = dr[11].ToString();//INSTALLMENT_3_AMOUNT
                            workRow[13] = dr[16].ToString();//PAYMENT_INSTALLMENT_3_PAID
                            workRow[14] = dr[12].ToString();//INSTALLMENT_4_AMOUNT
                            workRow[15] = dr[17].ToString();//PAYMENT_INSTALLMENT_4_PAID
                            workRow[16] = dr[20].ToString();//CARRY_FORWARD_AMOUNT
                            workRow[17] = dr[8].ToString();//SCHOLARSHIP_TYPE
                            workRow[18] = dr[21].ToString();//SEMESTER
                            workRow[19] = dr[22].ToString();//YEAR
                            dt.Rows.Add(workRow);
                        }
                    }

                    using (XLWorkbook wb = new XLWorkbook())
                    {
                        wb.Worksheets.Add(dt, "Scholarship Students Data");
                        Response.Clear();
                        Response.Buffer = true;
                        Response.Charset = "";
                        Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                        Response.AddHeader("content-disposition", "attachment;filename=Scholarship Students Data.xlsx");
                        using (MemoryStream MyMemoryStream = new MemoryStream())
                        {
                            wb.SaveAs(MyMemoryStream);
                            MyMemoryStream.WriteTo(Response.OutputStream);
                            Response.Flush();
                            Response.End();
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        { 
            //
        }
    }
}