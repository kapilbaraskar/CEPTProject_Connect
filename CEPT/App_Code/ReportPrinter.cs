using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Threading;
using System.IO;
//using WkHtmlToXSharp;
using SelectPdf;

public class ReportPrinter
{
    private static readonly global::Common.Logging.ILog _Log = global::Common.Logging.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
    public string MarginTop { get; set; }
    public bool HeaderLine { get; set; }
    public bool FooterLine { get; set; }
    public string PageFile { get; set; }
    public string HeaderFile { get; set; }
    public string FooterFile { get; set; }
    public static int count = 0;
    public string pdfFile { get; set; }
    private const int ConcurrentTimeout = 50000;
    public string PathToSave { get; set; }
    public string MarginBottom { get; set; }
    public byte[] FileContent { get; set; }
    public PdfPageOrientation Orientation { get; set; }
    public bool ChkPageNumbering { get; set; }
    public PdfPageSize PaperSize { get; set; }
    public int PageWidth { get; set; }
    public int PageHeight { get; set; }
    public string MarginLeft { get; set; }
    public string MarginRight { get; set; }
    public int HeaderHeight { get; set; }
    public int FooterHeight { get; set; }

    string directory_path = "C:/Ceptreg_Log/Course_mst_log/";
    string filename = "error";

    public ReportPrinter()
    {
        HeaderLine = true;
        FooterLine = true;
        MarginTop = "43";
        MarginBottom = "2";
        MarginLeft = "2";
        MarginRight = "2";
        Orientation = PdfPageOrientation.Portrait;
        ChkPageNumbering = false;
        PaperSize = PdfPageSize.A4;
        PageWidth = 1024;
        PageHeight = 0;
        HeaderHeight = 50;
        FooterHeight = 30;
    }

    public void GetPdf()
    {
        CanConvertConcurrently();
    }

    private void _SimpleConversion()
    {
        HtmlToPdf converter = new HtmlToPdf();

        converter.Options.PdfPageSize = PaperSize;
        converter.Options.PdfPageOrientation = Orientation;        
        converter.Options.WebPageWidth = PageWidth;
        converter.Options.WebPageHeight = PageHeight;

        int margin_top = 43;
        Int32.TryParse(MarginTop, out margin_top);
        converter.Options.MarginTop = margin_top;

        int margin_bottom = 2;
        Int32.TryParse(MarginBottom, out margin_bottom);
        converter.Options.MarginBottom = margin_bottom;

        int margin_left = 2;
        Int32.TryParse(MarginLeft, out margin_left);
        converter.Options.MarginLeft = margin_left;

        int margin_right = 2;
        Int32.TryParse(MarginRight, out margin_right);
        converter.Options.MarginRight = margin_right;

        if (HeaderFile != null)
        {
            converter.Options.DisplayHeader = true;
            converter.Header.DisplayOnFirstPage = true;
            converter.Header.DisplayOnOddPages = true;
            converter.Header.DisplayOnEvenPages = true;
            converter.Header.Height = HeaderHeight;
            
            PdfHtmlSection headerHtml = new PdfHtmlSection(HeaderFile);
            headerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Header.Add(headerHtml);
        }

        if (FooterFile != null)
        {
            converter.Options.DisplayFooter = true;
            converter.Footer.DisplayOnFirstPage = true;
            converter.Footer.DisplayOnOddPages = true;
            converter.Footer.DisplayOnEvenPages = true;
            converter.Footer.Height = FooterHeight;

            PdfHtmlSection footerHtml = new PdfHtmlSection(FooterFile);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);
        }

        if (ChkPageNumbering)
        {
            PdfTextSection text = new PdfTextSection(0, 10, "Page: {page_number} of {total_pages}  ", new System.Drawing.Font("Arial", 8));
            text.HorizontalAlign = PdfTextHorizontalAlign.Right;
            converter.Footer.Add(text);
        }

        //System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Before Convert URL() : " + PageFile + Environment.NewLine);

        //PageFile = PageFile.Replace("https://connect.cept.ac.in", "http://localhost/CEPTREG");//CEPTREG_TEMP

        //converter.Options.MaxPageLoadTime = 300;

        //System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "2. Before Convert URL() : " + PageFile + Environment.NewLine);

        PdfDocument doc = converter.ConvertUrl(PageFile);

        //System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "3. After Convert URL()" + Environment.NewLine);

        MemoryStream stream = new MemoryStream();
        doc.Save(stream);
        FileContent = stream.ToArray();
        doc.Close();
    }

    class ThreadData
    {
        public Thread Thread;
        public Exception Exception;
        public ManualResetEvent WaitHandle;
    }

    void ThreadStart(object arg)
    {
        _Log.DebugFormat("New thread {0}", arg);

        var tmp = arg as ThreadData;
        try
        {
            _SimpleConversion();
        }
        catch (Exception ex)
        {
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "4. ThreadStart : " + ex.ToString() + Environment.NewLine);

            tmp.Exception = ex;
        }
        finally
        {
            tmp.WaitHandle.Set();
        }
    }

    public void CanConvertConcurrently()
    {
        var error = false;
        var threads = new List<ThreadData>();

        //for (int i = 0; i < 5; i++)
        //{
        var tmp = new ThreadData()
        {
            Thread = new Thread(ThreadStart),
            WaitHandle = new ManualResetEvent(false)
        };
        threads.Add(tmp);
        tmp.Thread.Start(tmp);
        //}

        var handles = threads.Select(x => x.WaitHandle).ToArray();
        WaitHandle.WaitAll(handles, ConcurrentTimeout);
        //WaitAll(handles);

        threads.ForEach(x => x.Thread.Abort());

        var exceptions = threads.Select(x => x.Exception).Where(x => x != null);

        foreach (var tmp1 in threads)
        {
            if (tmp1.Exception != null)
            {
                error = true;
                var tid = tmp1.Thread.ManagedThreadId;
                _Log.Error("Thread-" + tid + " failed!", tmp1.Exception);
            }
        }

        //Assert.IsFalse(error, "At least one thread failed!");
    }

    public static void SetSession(string qStringSession)
    {
        JavaScriptSerializer ser = new JavaScriptSerializer();

        Dictionary<string, object> sessionDic = new Dictionary<string, object>();

        if (qStringSession != null)
        {
            sessionDic = ser.Deserialize<Dictionary<string, object>>(qStringSession);
        }

        HttpContext.Current.Session.Clear();

        if (sessionDic.Keys.Count > 0)
        {
            foreach (string key in sessionDic.Keys)
            {
                HttpContext.Current.Session[key] = sessionDic[key];
            }
        }
    }
}

public class ReportPrinterFromHTML
{
    private static readonly global::Common.Logging.ILog _Log = global::Common.Logging.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
    public string MarginTop { get; set; }
    public bool HeaderLine { get; set; }
    public bool FooterLine { get; set; }
    public string PageHTML { get; set; }
    public string HeaderFile { get; set; }
    public string FooterFile { get; set; }
    public static int count = 0;
    public string pdfFile { get; set; }
    private const int ConcurrentTimeout = 50000;
    public string PathToSave { get; set; }
    public string MarginBottom { get; set; }
    public byte[] FileContent { get; set; }
    public PdfPageOrientation Orientation { get; set; }
    public bool ChkPageNumbering { get; set; }
    public PdfPageSize PaperSize { get; set; }
    public int PageWidth { get; set; }
    public int PageHeight { get; set; }
    public string MarginLeft { get; set; }
    public string MarginRight { get; set; }
    public int HeaderHeight { get; set; }
    public int FooterHeight { get; set; }

    public ReportPrinterFromHTML()
    {
        HeaderLine = true;
        FooterLine = true;
        MarginTop = "43";
        MarginBottom = "2";
        MarginLeft = "2";
        MarginRight = "2";
        Orientation = PdfPageOrientation.Portrait;
        ChkPageNumbering = false;
        PaperSize = PdfPageSize.A4;
        PageWidth = 1024;
        PageHeight = 0;
        HeaderHeight = 50;
        FooterHeight = 30;
    }

    public void GetPdf()
    {
        CanConvertConcurrently();
    }

    private void _SimpleConversion()
    {
        HtmlToPdf converter = new HtmlToPdf();

        converter.Options.PdfPageSize = PaperSize;
        converter.Options.PdfPageOrientation = Orientation;
        converter.Options.WebPageWidth = PageWidth;
        converter.Options.WebPageHeight = PageHeight;

        int margin_top = 43;
        Int32.TryParse(MarginTop, out margin_top);
        converter.Options.MarginTop = margin_top;

        int margin_bottom = 2;
        Int32.TryParse(MarginBottom, out margin_bottom);
        converter.Options.MarginBottom = margin_bottom;

        int margin_left = 2;
        Int32.TryParse(MarginLeft, out margin_left);
        converter.Options.MarginLeft = margin_left;

        int margin_right = 2;
        Int32.TryParse(MarginRight, out margin_right);
        converter.Options.MarginRight = margin_right;

        if (HeaderFile != null)
        {
            converter.Options.DisplayHeader = true;
            converter.Header.DisplayOnFirstPage = true;
            converter.Header.DisplayOnOddPages = true;
            converter.Header.DisplayOnEvenPages = true;
            converter.Header.Height = HeaderHeight;

            PdfHtmlSection headerHtml = new PdfHtmlSection(HeaderFile);
            headerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Header.Add(headerHtml);
        }

        if (FooterFile != null)
        {
            converter.Options.DisplayFooter = true;
            converter.Footer.DisplayOnFirstPage = true;
            converter.Footer.DisplayOnOddPages = true;
            converter.Footer.DisplayOnEvenPages = true;
            converter.Footer.Height = FooterHeight;

            PdfHtmlSection footerHtml = new PdfHtmlSection(FooterFile);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);
        }

        if (ChkPageNumbering)
        {
            PdfTextSection text = new PdfTextSection(0, 10, "Page: {page_number} of {total_pages}  ", new System.Drawing.Font("Arial", 8));
            text.HorizontalAlign = PdfTextHorizontalAlign.Right;
            converter.Footer.Add(text);
        }

        PdfDocument doc = converter.ConvertHtmlString(PageHTML);
        MemoryStream stream = new MemoryStream();
        doc.Save(stream);
        FileContent = stream.ToArray();
        doc.Close();
    }

    class ThreadData
    {
        public Thread Thread;
        public Exception Exception;
        public ManualResetEvent WaitHandle;
    }

    void ThreadStart(object arg)
    {
        _Log.DebugFormat("New thread {0}", arg);

        var tmp = arg as ThreadData;
        try
        {
            _SimpleConversion();
        }
        catch (Exception ex)
        {
            tmp.Exception = ex;
        }
        finally
        {
            tmp.WaitHandle.Set();
        }
    }

    public void CanConvertConcurrently()
    {
        var error = false;
        var threads = new List<ThreadData>();

        //for (int i = 0; i < 5; i++)
        //{
        var tmp = new ThreadData()
        {
            Thread = new Thread(ThreadStart),
            WaitHandle = new ManualResetEvent(false)
        };
        threads.Add(tmp);
        tmp.Thread.Start(tmp);
        //}

        var handles = threads.Select(x => x.WaitHandle).ToArray();
        WaitHandle.WaitAll(handles, ConcurrentTimeout);
        //WaitAll(handles);

        threads.ForEach(x => x.Thread.Abort());

        var exceptions = threads.Select(x => x.Exception).Where(x => x != null);

        foreach (var tmp1 in threads)
        {
            if (tmp1.Exception != null)
            {
                error = true;
                var tid = tmp1.Thread.ManagedThreadId;
                _Log.Error("Thread-" + tid + " failed!", tmp1.Exception);
            }
        }

        //Assert.IsFalse(error, "At least one thread failed!");
    }

    public static void SetSession(string qStringSession)
    {
        JavaScriptSerializer ser = new JavaScriptSerializer();

        Dictionary<string, object> sessionDic = new Dictionary<string, object>();

        if (qStringSession != null)
        {
            sessionDic = ser.Deserialize<Dictionary<string, object>>(qStringSession);
        }

        HttpContext.Current.Session.Clear();

        if (sessionDic.Keys.Count > 0)
        {
            foreach (string key in sessionDic.Keys)
            {
                HttpContext.Current.Session[key] = sessionDic[key];
            }
        }
    }
}


//public class ReportPrinter_WkhtmlToXsharp
//{
//    private static readonly global::Common.Logging.ILog _Log = global::Common.Logging.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
//    public string MarginTop { get; set; }
//    public bool HeaderLine { get; set; }
//    public bool FooterLine { get; set; }
//    public string PageFile { get; set; }
//    public string HeaderFile { get; set; }
//    public string FooterFile { get; set; }
//    public static int count = 0;
//    public string pdfFile { get; set; }
//    private const int ConcurrentTimeout = 50000;
//    public string PathToSave { get; set; }
//    public string MarginBottom { get; set; }
//    public byte[] FileContent { get; set; }
//    public PdfOrientation Orientation { get; set; }

//    public ReportPrinter_WkhtmlToXsharp()
//    {
//        HeaderLine = true;
//        FooterLine = true;
//        MarginTop = "1.5cm";
//        MarginBottom = "1cm";
//        Orientation = PdfOrientation.Portrait;
//    }

//    public void GetPdf()
//    {
//        CanConvertConcurrently();

//        //return pdfFile;
//    }

//    private MultiplexingConverter _GetConverter()
//    {
//        var obj = new MultiplexingConverter();
//        obj.Begin += (s, e) => _Log.DebugFormat("Conversion begin, phase count: {0}", e.Value);
//        obj.Error += (s, e) => _Log.Error(e.Value);
//        obj.Warning += (s, e) => _Log.Warn(e.Value);
//        obj.PhaseChanged += (s, e) => _Log.InfoFormat("PhaseChanged: {0} - {1}", e.Value, e.Value2);
//        obj.ProgressChanged += (s, e) => _Log.InfoFormat("ProgressChanged: {0} - {1}", e.Value, e.Value2);
//        obj.Finished += (s, e) => _Log.InfoFormat("Finished: {0}", e.Value ? "success" : "failed!");
//        return obj;
//    }

//    private void _SimpleConversion()
//    {
//        using (var wk = _GetConverter())
//        {
//            _Log.DebugFormat("Performing conversion..");

//            wk.GlobalSettings.Margin.Top = MarginTop;
//            wk.GlobalSettings.Margin.Bottom = MarginBottom;
//            wk.GlobalSettings.Margin.Left = "0cm";
//            wk.GlobalSettings.Margin.Right = "0cm";

//            //wk.GlobalSettings.Out = @"c:\temp\tmp.pdf";

//            wk.ObjectSettings.footer.fontSize = 13;
//            wk.ObjectSettings.footer.htmlUrl = FooterFile;
//            wk.ObjectSettings.footer.line = HeaderLine;
//            wk.ObjectSettings.footer.fontName = "times";

//            //wk.ObjectSettings.header.center = "header";
//            //wk.ObjectSettings.header.line = HeaderLine;
//            wk.ObjectSettings.header.fontSize = 13;
//            wk.ObjectSettings.header.fontName = "times";
//            wk.ObjectSettings.header.htmlUrl = HeaderFile;

//            wk.ObjectSettings.Web.EnablePlugins = false;
//            wk.ObjectSettings.Web.EnableJavascript = true;
//            wk.ObjectSettings.Load.LoadErrorHandling = LoadErrorHandlingType.ignore;
//            //wk.ObjectSettings.Page = SimplePageFile;
//            wk.ObjectSettings.Page = PageFile;
//            wk.GlobalSettings.Orientation = Orientation;

//            //wk.ObjectSettings.Page = "https://www.google.com";
//            wk.ObjectSettings.Load.Proxy = "none";

//            FileContent = wk.Convert();

//            //var number = 0;
//            //lock (this) number = count++;
//            //string FileName = PageFile.Substring(PageFile.LastIndexOf('/') + 1, PageFile.IndexOf(".aspx") - (PageFile.LastIndexOf('/') + 1));
//            //pdfFile = PathToSave + FileName + DateTime.Now.ToString("MM.dd.yyyy HH.mm.ss") + ".pdf";  //@"c:\temp\tmp" + (number) + @".pdf";

//            //File.WriteAllBytes(pdfFile, FileContent);
//            //Process.Start(@"c:\temp\tmp" + (number) + ".pdf");
//        }
//    }

//    class ThreadData
//    {
//        public Thread Thread;
//        public Exception Exception;
//        public ManualResetEvent WaitHandle;
//    }

//    void ThreadStart(object arg)
//    {
//        _Log.DebugFormat("New thread {0}", arg);

//        var tmp = arg as ThreadData;
//        try
//        {
//            _SimpleConversion();
//        }
//        catch (Exception ex)
//        {
//            tmp.Exception = ex;
//        }
//        finally
//        {
//            tmp.WaitHandle.Set();
//        }
//    }

//    public void CanConvertConcurrently()
//    {
//        var error = false;
//        var threads = new List<ThreadData>();

//        //for (int i = 0; i < 5; i++)
//        //{
//        var tmp = new ThreadData()
//        {
//            Thread = new Thread(ThreadStart),
//            WaitHandle = new ManualResetEvent(false)
//        };
//        threads.Add(tmp);
//        tmp.Thread.Start(tmp);
//        //}

//        var handles = threads.Select(x => x.WaitHandle).ToArray();
//        WaitHandle.WaitAll(handles, ConcurrentTimeout);
//        //WaitAll(handles);

//        threads.ForEach(x => x.Thread.Abort());

//        var exceptions = threads.Select(x => x.Exception).Where(x => x != null);

//        foreach (var tmp1 in threads)
//        {
//            if (tmp1.Exception != null)
//            {
//                error = true;
//                var tid = tmp1.Thread.ManagedThreadId;
//                _Log.Error("Thread-" + tid + " failed!", tmp1.Exception);
//            }
//        }

//        //Assert.IsFalse(error, "At least one thread failed!");
//    }

//    public static void SetSession(string qStringSession)
//    {
//        JavaScriptSerializer ser = new JavaScriptSerializer();

//        Dictionary<string, object> sessionDic = new Dictionary<string, object>();

//        if (qStringSession != null)
//        {
//            sessionDic = ser.Deserialize<Dictionary<string, object>>(qStringSession);
//        }

//        HttpContext.Current.Session.Clear();

//        if (sessionDic.Keys.Count > 0)
//        {
//            foreach (string key in sessionDic.Keys)
//            {
//                HttpContext.Current.Session[key] = sessionDic[key];
//            }
//        }
//    }
//}