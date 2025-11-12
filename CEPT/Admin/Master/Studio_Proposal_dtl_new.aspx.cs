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

public partial class Admin_Master_Studio_Proposal_dtl_new : System.Web.UI.Page
{
    Masters masters = new Masters();
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void btn_approved_Click(object sender, EventArgs e)
    {
        download_excel();
    }
     
    public void download_excel()
    {
        try
        {
            DataTable dts = masters.Get_studio_proposal_excel_formate(hdn_sem_code.Value, hdn_year_code.Value, hdn_dept.Value, hdn_prog.Value, hdn_type.Value);
            if (dts != null)
            {
               

                using (XLWorkbook wb = new XLWorkbook())
                {
                    var ws = wb.Worksheets.Add(dts, "Studio Proposal Details");

                    ws.Tables.FirstOrDefault().ShowAutoFilter = false;
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Studio Proposal Details.xlsx");
                    using (MemoryStream MyMemoryStream = new MemoryStream())
                    {
                        wb.SaveAs(MyMemoryStream);
                        MyMemoryStream.WriteTo(Response.OutputStream);

                        Response.Flush();
                        Response.End();
                        Response.Close();
                    }
                }
            }

        }
        catch (Exception ex)
        { }

    }
}