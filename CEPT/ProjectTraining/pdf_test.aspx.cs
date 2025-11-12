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
    }
    protected void print_proposal(Object sender, EventArgs e)
    {
        string[] lstFiles = new string[3];
        lstFiles[0] = @"e:/1.pdf";
        lstFiles[1] = @"e:/2.pdf";
        PdfReader reader = null;
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
                reader = new PdfReader(lstFiles[f]);
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
        }
        catch (Exception ex)
        {
            throw ex;
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
}
              
        