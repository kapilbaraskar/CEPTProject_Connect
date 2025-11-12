using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.pdf;

public partial class Split_PDF : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ExtractPages();
    }

    private void ExtractPages()
    {
        PdfReader reader = null;
        Document sourceDocument = null;
        PdfCopy pdfCopyProvider = null;
        PdfImportedPage importedPage = null;

        reader = new PdfReader("D:/Feedback New/Management.pdf");
        sourceDocument = new Document(reader.GetPageSizeWithRotation(1));
       

        sourceDocument.Open();

        for (int j = 1; j <= 25; j++)
        {
            pdfCopyProvider = new PdfCopy(sourceDocument, new System.IO.FileStream("D://Feedback New//output/abc" + j +".pdf", System.IO.FileMode.Create));

            for (int i = j; i <= j; i++)
            {
                importedPage = pdfCopyProvider.GetImportedPage(reader, j);
                pdfCopyProvider.AddPage(importedPage);
               
            }
        }
        sourceDocument.Close();
        reader.Close();
    }
}