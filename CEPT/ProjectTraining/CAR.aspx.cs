using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Ionic.Zip;
using BLL.Master;
using System.Data;
using iTextSharp.text.pdf;
using iTextSharp.text;
using System.Text.RegularExpressions;

public partial class ProjectTraining_ProjectTraining : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string json_data_of_sem_year = "";
        string current_project_sem = "";
        string current_project_year = "";
        Masters objmaster = new Masters();

        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");

        if (dt_ws_current_sem != null)
        {
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        json_data_of_sem_year = GetJson1(dt_ws_current_sem);


        hdn_sem_year_data.Value = json_data_of_sem_year;
    }

    protected void print_proposal_old(Object sender, EventArgs e)
    {
        Masters objmaster = new Masters();

        string json_data_of_sem_year = "";
        string current_project_sem = "";
        string current_project_year = "";
        string project_name = "";
        string car_title = "";

        string str_path = HttpContext.Current.Request.Url.Authority;

        for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
        {
            str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
        }

        string file_path = HttpContext.Current.Request.PhysicalApplicationPath;

        JavaScriptSerializer ser = new JavaScriptSerializer();
        
        Dictionary<string,string> data = ser.Deserialize<Dictionary<string,string>>(hdn_data.Value);

        project_name = data["project_name"];
        car_title = data["car_title"];
        string titlecar=car_title.Replace("&", "%26");

        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");

        if (dt_ws_current_sem != null)
        {
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        json_data_of_sem_year = GetJson1(dt_ws_current_sem);


        hdn_sem_year_data.Value = json_data_of_sem_year;

        string a = current_project_sem;
        string b = current_project_year;
        string c = Session["UserId"].ToString();
        string d = Session["UserName"].ToString();
        string date = System.DateTime.Now.GetDateTimeFormats()[7].ToString();

        ReportPrinter obReportPrinter = new ReportPrinter();

        //obReportPrinter.PageFile = "https://" + str_path + "car_report_print.aspx?user_id=" + data["user_id"] + "&page_number=" + data["page_number"] + "&project_name=" + data["project_name"] + "&car_title=" + titlecar + "&user_name=" + d + "&date=" + date;
        obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "car_report_print.aspx?user_id=" + data["user_id"] + "&page_number=" + data["page_number"] + "&project_name=" + data["project_name"] + "&car_title=" + titlecar + "&user_name=" + d + "&date=" + date;
        obReportPrinter.MarginBottom = "0";
        obReportPrinter.GetPdf();

        Random rd = new Random();
        int n = rd.Next();

        if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
        {
            string directory_path = "C:/";
            FileStream fs = new FileStream(directory_path +"test_pdf.pdf", FileMode.Create);
            fs.Write(obReportPrinter.FileContent, 0, obReportPrinter.FileContent.Length);
            fs.Dispose();
         
            string[] lstFiles = new string[3];

            lstFiles[0] = @"c:/test_pdf.pdf";
            //lstFiles[1] = @"d:/cept/CEPT/ProjectTraining/car/" + data["upload_pdf_path"];
            lstFiles[1] = Server.MapPath("~/ProjectTraining/car/") + data["upload_pdf_path"];
            
            //PdfReader reader = null;
            Document sourceDocument = null;
            PdfCopy pdfCopyProvider = null;
            PdfImportedPage importedPage;
            string outputPdfPath = @"C:/new.pdf";
            sourceDocument = new Document();
            pdfCopyProvider = new PdfCopy(sourceDocument, new System.IO.FileStream(outputPdfPath, System.IO.FileMode.Create));

            //Open the output file
            sourceDocument.Open();
            try
            {
                //Loop through the files list
                for (int f = 0; f < lstFiles.Length - 1; f++)
                {
                    int pages = get_pageCcount(lstFiles[f]);
                    PdfReader reader = new PdfReader(lstFiles[f]);
                    //Add pages of current file
                    for (int i = 1; i <= pages; i++)
                    {
                        importedPage = pdfCopyProvider.GetImportedPage(reader, i);
                        pdfCopyProvider.AddPage(importedPage);
                    }

                    reader.Close();
                }
                //At the end save the output file
                sourceDocument.Close();
                sourceDocument.Dispose();
            }
            catch (Exception ex)
            {
                throw ex;
            }

            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "car.pdf"));
            HttpContext.Current.Response.TransmitFile("C:/new.pdf");
            
            Response.Flush();
            Response.End();
        }
    }

    protected void print_proposal(Object sender, EventArgs e)
    {
        Masters objmaster = new Masters();

        string current_project_sem = "";
        string current_project_year = "";
        string project_name = "";
        string car_title = "";

        string str_path = HttpContext.Current.Request.Url.Authority;

        for (int i = 0; i < (HttpContext.Current.Request.Url.Segments.Length - 1); i++)
        {
            str_path = str_path + HttpContext.Current.Request.Url.Segments[i];
        }

        string file_path = HttpContext.Current.Request.PhysicalApplicationPath;

        JavaScriptSerializer ser = new JavaScriptSerializer();

        Dictionary<string, string> data = ser.Deserialize<Dictionary<string, string>>(hdn_data.Value);

        project_name = data["project_name"];
        car_title = data["car_title"];
        string titlecar = car_title.Replace("&", "%26");

        DataTable dt_ws_current_sem = objmaster.Get_cept_current_sem_data("Project Training");

        if (dt_ws_current_sem != null)
        {
            current_project_sem = dt_ws_current_sem.Rows[0]["sem_code"].ToString();
            current_project_year = dt_ws_current_sem.Rows[0]["year_code"].ToString();
        }

        string user_name = "";
        string a = current_project_sem;
        string b = current_project_year;
        string c = Session["UserId"].ToString();

        if (Request.QueryString["user_name"] != "")
        {
            user_name = Request.QueryString["user_name"];
        }
        
        if (Request.QueryString["user_name"] == null) {
            user_name = Session["UserName"].ToString();
        }

        string date = System.DateTime.Now.GetDateTimeFormats()[7].ToString();

        ReportPrinter obReportPrinter = new ReportPrinter();

        //obReportPrinter.PageFile = "https://" + str_path + "car_report_print.aspx?user_id=" + data["user_id"] + "&page_number=" + data["page_number"] + "&project_name=" + data["project_name"] + "&car_title=" + titlecar + "&user_name=" + user_name + "&date=" + date;
        obReportPrinter.PageFile = HttpContext.Current.Request.Url.Scheme + "://" + str_path + "car_report_print.aspx?user_id=" + data["user_id"] + "&page_number=" + data["page_number"] + "&project_name=" + data["project_name"] + "&car_title=" + titlecar + "&user_name=" + user_name + "&date=" + date;
        obReportPrinter.MarginBottom = "0";
        obReportPrinter.GetPdf();

        Random rd = new Random();
        int n = rd.Next();

        if (obReportPrinter.FileContent != null && obReportPrinter.FileContent.Length > 0)
        {
            byte[] mergedPdf = null;
            using (MemoryStream ms = new MemoryStream())
            {
                using (Document document = new Document())
                {
                    using (PdfCopy copy = new PdfCopy(document, ms))
                    {
                        document.Open();

                        //byte[] pdf1 = File.ReadAllBytes("D:\\Spectrum\\Z1.pdf");
                        //byte[] pdf2 = File.ReadAllBytes(@"d:/CEPT_REG/CEPT/ProjectTraining/car/" + data["upload_pdf_path"]);
                        byte[] pdf2 = File.ReadAllBytes(Server.MapPath("~/ProjectTraining/car/") + data["upload_pdf_path"]);

                        PdfReader reader1 = new PdfReader(obReportPrinter.FileContent);
                        int total_page = reader1.NumberOfPages;
                        for (int page = 1; page <= total_page; page++)
                        {
                            copy.AddPage(copy.GetImportedPage(reader1, page));
                        }

                        PdfReader reader2 = new PdfReader(pdf2);
                        total_page = reader2.NumberOfPages;
                        for (int page = 1; page <= total_page; page++)
                        {
                            copy.AddPage(copy.GetImportedPage(reader2, page));
                        }
                    }
                    document.Dispose();
                }
                mergedPdf = ms.ToArray();
            }

            HttpContext.Current.Response.ContentType = "application/octet-stream";
            HttpContext.Current.Response.AddHeader("Content-Disposition", string.Format("attachment; filename=\"{0}\"", "" + data["user_id"] +"_CAR-No:"+ data["page_number"] +".pdf"));
            HttpContext.Current.Response.BinaryWrite(mergedPdf);
            Response.Flush();
            Response.End();
        }
    }

    private int get_pageCcount(string file)
    {
        using (StreamReader sr = new StreamReader(File.OpenRead(file)))
        {
            Regex regex = new Regex(@"/Type\s*/Page[^s]");
            MatchCollection matches = regex.Matches(sr.ReadToEnd());
            return matches.Count;
        }
    }

    public string GetJson1(DataTable dt)
    {
        JavaScriptSerializer ser = new JavaScriptSerializer();
        ser.MaxJsonLength = Int32.MaxValue;
        List<Dictionary<string, string>> dataRows = new List<Dictionary<string, string>>(); // will contain datarows as dictionary objects

        //Convert DataTable to List<Dictionary<string, string>> data structure
        foreach (DataRow VDataRow in dt.Rows)
        {
            var Row = new Dictionary<string, string>(); // DataRow as key-value pairs where key=columnName and value=fieldValue
            foreach (DataColumn Column in dt.Columns)
            {

                Row.Add(Column.ColumnName, VDataRow[Column].ToString());

            }
            dataRows.Add(Row);
        }
        
        return ser.Serialize(dataRows); // convert list to JSON string
    }
}

