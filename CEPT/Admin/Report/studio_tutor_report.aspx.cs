using BLL.Master;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Excel;
using DataTable = System.Data.DataTable;
using System.Data.OleDb;
using ClosedXML.Excel;
//using BLL.Utilities;
//using ClosedXML.Excel;


public partial class Admin_Report_studio_tutor_report : System.Web.UI.Page
{
    Masters objmaster = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnDownloadExcelDocuments_Click(object sender, EventArgs e)
    {
        try 
        {
             JavaScriptSerializer ser = new JavaScriptSerializer();
             Dictionary<string, object> tempParam = ser.Deserialize<Dictionary<string, object>>(exDocuments.Value);
             string user_id = tempParam["id"].ToString();
             string user_name = tempParam["name"].ToString();
             string sem = tempParam["s"].ToString();
             string year = tempParam["y"].ToString();
            
             //Microsoft.Office.Interop.Excel.Application excel;
             //Microsoft.Office.Interop.Excel.Workbook worKbooK;
             //Microsoft.Office.Interop.Excel.Worksheet worKsheeT;
             //Microsoft.Office.Interop.Excel.Range celLrangE;
             //Microsoft.Office.Interop.Excel.CellFormat formatColor;
             DataTable dt = objmaster.Export_Excel_File(user_id, sem, year);
             DataTable work_dtl = objmaster.get_instructor_education_work_dtl(user_id);
            //ServerLog.ExceptionLog("Get Data For Dt");
            //ServerLog.ExceptionLog("Get Data For work_dtl");
            #region Version Problem 02082021
            // if (dt != null)
            // {
            //     excel = new Microsoft.Office.Interop.Excel.Application();
            //     excel.Visible = false;
            //     excel.DisplayAlerts = false;
            //     worKbooK = excel.Workbooks.Add(Type.Missing);
            //
            //
            //     worKsheeT = (Microsoft.Office.Interop.Excel.Worksheet)worKbooK.ActiveSheet;
            //     worKsheeT.Name = "Personal Details";
            //     worKsheeT.Range[worKsheeT.Cells[1, 1], worKsheeT.Cells[1, 8]].Merge();
            //     worKsheeT.Cells[1, 1] = "Personal Details";
            //     worKsheeT.Cells.Font.Size = 15;
            //
            //     int rowcount = 2;
            //
            //     foreach (DataRow datarow in dt.Rows)
            //     {
            //         rowcount += 1;
            //         for (int i = 1; i <= dt.Columns.Count; i++)
            //         {
            //             worKsheeT.Cells[2, i] = dt.Columns[i - 1].ColumnName;
            //             worKsheeT.Cells.Font.Color = System.Drawing.Color.Black;
            //             worKsheeT.Cells[rowcount, i] = datarow[i - 1].ToString();
            //             worKsheeT.Range[worKsheeT.Cells[2, i], worKsheeT.Cells[2, i]].Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red);
            //         }
            //
            //     }
            //     rowcount += 2;
            //
            //     worKsheeT.Range[worKsheeT.Cells[rowcount, 1], worKsheeT.Cells[rowcount, 8]].Merge();
            //     worKsheeT.Cells[rowcount, 1] = "Academic Qualification";
            //     worKsheeT.Cells.Font.Size = 15;
            //     rowcount += 1;
            //
            //     worKsheeT.Cells[rowcount, 1] = "Degree";
            //     worKsheeT.Cells[rowcount, 2] = "Specialization";
            //     worKsheeT.Cells[rowcount, 3] = "University";
            //     worKsheeT.Cells[rowcount, 4] = "Date of Issuance of Certificate";
            //     worKsheeT.Cells.Font.Color = System.Drawing.Color.Black;
            //     worKsheeT.Range[worKsheeT.Cells[rowcount, 1], worKsheeT.Cells[rowcount, 4]].Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red);
            //     System.Data.DataTable dt_education = work_dtl.Select("detail_type ='education'").CopyToDataTable();
            //     if (dt_education != null)
            //     {
            //
            //
            //         for (int j = 0; j < dt_education.Rows.Count; j++)
            //         {
            //             rowcount += 1;
            //             worKsheeT.Cells[rowcount, 1] = dt_education.Rows[j]["degree"].ToString();
            //             worKsheeT.Cells[rowcount, 2] = dt_education.Rows[j]["specialization"].ToString();
            //             worKsheeT.Cells[rowcount, 3] = dt_education.Rows[j]["university"].ToString();
            //             worKsheeT.Cells[rowcount, 4] = dt_education.Rows[j]["date_of_issuance_certificate"].ToString();
            //         }
            //     }
            //     rowcount += 2;
            //     worKsheeT.Range[worKsheeT.Cells[rowcount, 1], worKsheeT.Cells[rowcount, 8]].Merge();
            //     worKsheeT.Cells[rowcount, 1] = "References";
            //     worKsheeT.Cells.Font.Size = 15;
            //     rowcount += 1;
            //
            //     worKsheeT.Cells[rowcount, 1] = "Name";
            //     worKsheeT.Cells[rowcount, 2] = "Mobile No";
            //     worKsheeT.Cells[rowcount, 3] = "Email Id";
            //     worKsheeT.Cells.Font.Color = System.Drawing.Color.Black;
            //     worKsheeT.Range[worKsheeT.Cells[rowcount, 1], worKsheeT.Cells[rowcount, 3]].Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red);
            //     System.Data.DataTable dt_refrence = work_dtl.Select("detail_type ='reference'").CopyToDataTable();
            //     if (dt_refrence != null)
            //     {
            //         for (int k = 0; k < dt_refrence.Rows.Count; k++)
            //         {
            //             rowcount += 1;
            //             worKsheeT.Cells[rowcount, 1] = dt_refrence.Rows[k]["referee_name"].ToString();
            //             worKsheeT.Cells[rowcount, 2] = dt_refrence.Rows[k]["referee_mobile_no"].ToString();
            //             worKsheeT.Cells[rowcount, 3] = dt_refrence.Rows[k]["referee_email_id"].ToString();
            //         }
            //     }
            //     rowcount += 2;
            //     worKsheeT.Range[worKsheeT.Cells[rowcount, 1], worKsheeT.Cells[rowcount, 8]].Merge();
            //     worKsheeT.Cells[rowcount, 1] = "Work Experience";
            //     worKsheeT.Cells.Font.Size = 15;
            //     rowcount += 1;
            //
            //     worKsheeT.Cells[rowcount, 1] = "Work Designation";
            //     worKsheeT.Cells[rowcount, 2] = "Work Institute";
            //     worKsheeT.Cells[rowcount, 3] = "Work Start Date";
            //     worKsheeT.Cells[rowcount, 4] = "Work End Date";
            //     worKsheeT.Cells[rowcount, 5] = "Work Experience Type";
            //     worKsheeT.Cells[rowcount, 6] = "Work Experience Months";
            //     worKsheeT.Range[worKsheeT.Cells[rowcount, 1], worKsheeT.Cells[rowcount, 6]].Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.Red);
            //
            //     System.Data.DataTable dt_work = work_dtl.Select("detail_type ='work'").CopyToDataTable();
            //     if (dt_work != null)
            //     {
            //         for (int q = 0; q < dt_work.Rows.Count; q++)
            //         {
            //             rowcount += 1;
            //             worKsheeT.Cells[rowcount, 1] = dt_work.Rows[q]["work_designation"].ToString();
            //             worKsheeT.Cells[rowcount, 2] = dt_work.Rows[q]["work_institute"].ToString();
            //             worKsheeT.Cells[rowcount, 3] = dt_work.Rows[q]["work_start_date"].ToString();
            //             worKsheeT.Cells[rowcount, 4] = dt_work.Rows[q]["work_end_date"].ToString();
            //             worKsheeT.Cells[rowcount, 5] = dt_work.Rows[q]["work_experience_type"].ToString();
            //             worKsheeT.Cells[rowcount, 6] = dt_work.Rows[q]["work_experience_months"].ToString();
            //         }
            //     }
            //
            //
            //     celLrangE = worKsheeT.Range[worKsheeT.Cells[1, 1], worKsheeT.Cells[rowcount, dt.Columns.Count]];
            //     celLrangE.EntireColumn.AutoFit();
            //     Microsoft.Office.Interop.Excel.Borders border = celLrangE.Borders;
            //     border.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
            //     border.Weight = 2d;
            //
            //
            //     //celLrangE = worKsheeT.Range[worKsheeT.Cells[1, 1], worKsheeT.Cells[2, dt.Columns.Count]];
            //     worKbooK.SaveAs(Server.MapPath("~/ExcelFormatFiles/" + user_id + "_" + user_name + "_" + "Excel.xlsx"));
            //     worKbooK.Close();
            //     excel.Quit();
            //     worKsheeT = null;
            //     celLrangE = null;
            //     worKbooK = null;
            //     // return "1";
            // }
            #endregion
            if (dt != null) {

                var wbook = new XLWorkbook();
                //ServerLog.ExceptionLog("wbook Create Object");
                var ws = wbook.AddWorksheet("Personal Details");
                ws.Range(ws.Cell(1, 1), ws.Cell(1, 8)).Merge();
                ws.Cell(1, 1).Value = "Personal Details";
                ws.Cell(1, 1).Style.Font.FontSize = 15;
                int rowcount = 2;

                foreach (DataRow datarow in dt.Rows)
                {
                    rowcount += 1;
                    for (int i = 1; i <= dt.Columns.Count; i++)
                    {

                        ws.Cell(2, i).Value = dt.Columns[i - 1].ColumnName;
                        ws.Cell(2, i).Style.Font.FontSize = 15;
                        ws.Cell(2, i).Style.Fill.BackgroundColor = XLColor.Red;
                        ws.Cell(rowcount, i).Value = datarow[i - 1].ToString();
                        ws.Cell(rowcount, i).Style.Font.FontSize = 15;
                        ws.Cell(rowcount, i).Style.Border.TopBorder = XLBorderStyleValues.Thin;
                        
                        ws.Cell(rowcount, i).Style.Border.InsideBorder = XLBorderStyleValues.Thin;
                        ws.Cell(rowcount, i).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                        ws.Cell(rowcount, i).Style.Border.LeftBorder = XLBorderStyleValues.Thin;
                        ws.Cell(rowcount, i).Style.Border.RightBorder = XLBorderStyleValues.Thin;

                    }
                }

                rowcount += 2;


                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 8)).Merge();
                ws.Cell(rowcount, 1).Value = "Academic Qualification";
                ws.Cell(rowcount, 1).Style.Font.FontSize = 15;
                rowcount += 1;

                ws.Cell(rowcount, 1).Value = "Degree";
                ws.Cell(rowcount, 2).Value = "Specialization";
                ws.Cell(rowcount, 3).Value = "University";
                ws.Cell(rowcount, 4).Value = "Date of Issuance of Certificate";

                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Font.FontColor = XLColor.Black;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Fill.BackgroundColor = XLColor.Red;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Font.FontSize = 15;
                
                System.Data.DataTable dt_education = work_dtl.Select("detail_type ='education'").CopyToDataTable();
                
                if (dt_education != null)
                {
                    for (int j = 0; j < dt_education.Rows.Count; j++)
                    {
                        rowcount += 1;
                        ws.Cell(rowcount, 1).Value = dt_education.Rows[j]["degree"].ToString();
                        ws.Cell(rowcount, 2).Value = dt_education.Rows[j]["specialization"].ToString();
                        ws.Cell(rowcount, 3).Value = dt_education.Rows[j]["university"].ToString();
                        ws.Cell(rowcount, 4).Value = dt_education.Rows[j]["date_of_issuance_certificate"].ToString();
                        ws.Cell(rowcount, 1).Style.Font.FontSize = 15;
                        ws.Cell(rowcount, 2).Style.Font.FontSize = 15;
                        ws.Cell(rowcount, 3).Style.Font.FontSize = 15;
                        ws.Cell(rowcount, 4).Style.Font.FontSize = 15;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Border.TopBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Border.InsideBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Border.LeftBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Border.RightBorder = XLBorderStyleValues.Thin;

                    }
                }

                //ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 4)).Style.Font.FontSize = 15;
                rowcount += 2;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 8)).Merge();
                ws.Cell(rowcount, 1).Value = "References";
               // ws.Cell.Font.Size = 15;
                ws.Cell(rowcount, 1).Style.Font.FontSize = 15;
                rowcount += 1;

                ws.Cell(rowcount, 1).Value = "Name";
                ws.Cell(rowcount, 2).Value = "Mobile No";
                ws.Cell(rowcount, 3).Value = "Email Id";
               // ws.Cell(rowcount, 1).Style.Font.FontColor = XLColor.Black;
               // ws.Cell(rowcount, 2).Style.Font.FontColor = XLColor.Black;
               // ws.Cell(rowcount, 3).Style.Font.FontColor = XLColor.Black;
               // ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Font.FontColor = XLColor.Red;

                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Font.FontColor = XLColor.Black;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Fill.BackgroundColor = XLColor.Red;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Font.FontSize = 15;
                System.Data.DataTable dt_refrence = work_dtl.Select("detail_type ='reference'").CopyToDataTable();

                if (dt_refrence != null)
                {
                    for (int k = 0; k < dt_refrence.Rows.Count; k++)
                    {
                        rowcount += 1;
                        ws.Cell(rowcount, 1).Value = dt_refrence.Rows[k]["referee_name"].ToString();
                        ws.Cell(rowcount, 2).Value = dt_refrence.Rows[k]["referee_mobile_no"].ToString();
                        ws.Cell(rowcount, 3).Value = dt_refrence.Rows[k]["referee_email_id"].ToString();

                        ws.Cell(rowcount, 1).Style.Font.FontSize = 15;
                        ws.Cell(rowcount, 2).Style.Font.FontSize = 15;
                        ws.Cell(rowcount, 3).Style.Font.FontSize = 15;

                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Border.TopBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Border.InsideBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Border.OutsideBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Border.LeftBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 3)).Style.Border.RightBorder = XLBorderStyleValues.Thin;

                    }
                }

                rowcount += 2;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 8)).Merge();
                ws.Cell(rowcount, 1).Value = "Work Experience";
                ws.Cell(rowcount, 1).Style.Font.FontSize = 15;
                rowcount += 1;

                ws.Cell(rowcount, 1).Value = "Work Designation";
                ws.Cell(rowcount, 2).Value = "Work Institute";
                ws.Cell(rowcount, 3).Value = "Work Start Date";
                ws.Cell(rowcount, 4).Value = "Work End Date";
                ws.Cell(rowcount, 5).Value = "Work Experience Type";
                ws.Cell(rowcount, 6).Value = "Work Experience Months";
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Font.FontColor = XLColor.Black;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Fill.BackgroundColor = XLColor.Red;
                ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Font.FontSize = 15;
             



                System.Data.DataTable dt_work = work_dtl.Select("detail_type ='work'").CopyToDataTable();
                if (dt_work != null)
                {
                    for (int q = 0; q < dt_work.Rows.Count; q++)
                    {
                        rowcount += 1;
                        ws.Cell(rowcount, 1).Value = dt_work.Rows[q]["work_designation"].ToString();
                        ws.Cell(rowcount, 2).Value = dt_work.Rows[q]["work_institute"].ToString();
                        ws.Cell(rowcount, 3).Value = dt_work.Rows[q]["work_start_date"].ToString();
                        ws.Cell(rowcount, 4).Value = dt_work.Rows[q]["work_end_date"].ToString();
                        ws.Cell(rowcount, 5).Value = dt_work.Rows[q]["work_experience_type"].ToString();
                        ws.Cell(rowcount, 6).Value = dt_work.Rows[q]["work_experience_months"].ToString();
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Font.FontSize = 15;

                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Border.TopBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Border.InsideBorder = XLBorderStyleValues.Thin; 
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Border.OutsideBorder = XLBorderStyleValues.Thin; 
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Border.LeftBorder = XLBorderStyleValues.Thin;
                        ws.Range(ws.Cell(rowcount, 1), ws.Cell(rowcount, 6)).Style.Border.RightBorder = XLBorderStyleValues.Thin;

                    }
                }


                //ws.Range(ws.Cell(1, 1), ws.Cell(rowcount, dt.Columns.Count))
                ws.Columns().AdjustToContents();  // Adjust column width
                ws.Rows().AdjustToContents();

                BLL.Utilities.ServerLog.ExceptionLog(" Add Rows And Column ");
                wbook.SaveAs(Server.MapPath("~/ExcelFormatFiles/" + user_id + "_" + user_name + "_" + "Excel.xls"));
                BLL.Utilities.ServerLog.ExceptionLog(" SaveAs Excel File");

            }
            string path = Server.MapPath("~/ExcelFormatFiles/" + user_id + "_" + user_name + "_" + "Excel.xls");
             //Response.ContentType = "application/xls";
             Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
             Response.AppendHeader("Content-Disposition", "attachment; filename=" + user_id + "_" + user_name + "_" + "Excel.xls");
             Response.TransmitFile(path);
             Response.Flush();
             Response.End();
            
        }
        catch(Exception ex)
        {
            BLL.Utilities.ServerLog.ExceptionLog(ex.Message);
            //return false;

        }
    }

    protected void btnDownloadPDFDocuments_Click(object sender, EventArgs e)
    {
        try
        {
            string path = Server.MapPath("~/InstructorCVUpload/Document.zip");
            Response.ContentType = "application/xls";
            Response.AppendHeader("Content-Disposition", "attachment; filename=Document.zip");
            Response.TransmitFile(path);
            Response.Flush();
            Response.End();
        }
        catch (Exception ex)
        { throw; }
    }


    
}
