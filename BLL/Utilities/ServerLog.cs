using System;
using System.IO;
using System.Configuration;
using System.Text;

namespace BLL.Utilities
{
    public class ServerLog
    {
        private static String ServerLogFile = ConfigurationManager.AppSettings.Get("ServerLogFile");
        private static String InvalidLoginLogFile = ConfigurationManager.AppSettings.Get("InvalidLoginLogFile");
        private static String ExceptionLogFile = ConfigurationManager.AppSettings.Get("ExceptionLogFile");
        private static String ThemeLogFile = ConfigurationManager.AppSettings.Get("ThemeLogFile");
        private static String User_fees_Log = ConfigurationManager.AppSettings.Get("User_fees_Log");
        private static String User_fees_error = ConfigurationManager.AppSettings.Get("User_fees_error");
        private static String CommitGradeLogFile = ConfigurationManager.AppSettings.Get("CommitGradeLogFile");
        private static String DateTimeLogFormat = "dd-MMM-yyyy hh:mm:ss:fffffff tt";

        public static void Log(String message)
        {
            //FileInfo fi = new FileInfo(ServerLogFile);
            //if (!fi.Exists)
            //    ServerLogFile = "c:\\inetpub\\wwwroot\\SBSPortal\\UIL\\UploadDownload\\log.txt";

            FileStream fs = new FileStream(ServerLogFile, FileMode.Append, FileAccess.Write, FileShare.Write);
            fs.Close();
            StreamWriter sw = new StreamWriter(ServerLogFile, true, Encoding.ASCII);
            sw.WriteLine(message);
            sw.Close();
        }
        public static void InvalidLoginLog(String message)
        {
            FileStream fs = new FileStream(InvalidLoginLogFile, FileMode.Append, FileAccess.Write, FileShare.Write);
            fs.Close();
            StreamWriter sw = new StreamWriter(InvalidLoginLogFile, true, Encoding.ASCII);
            sw.WriteLine(message);
            sw.Close();

        }
        private static void WriteLog(String LogFileName, String message)
        {
            String AutoFlushServerLogFile = "Y";
            long MaxSizeToAutoFlushServerLogFile = 5000000; //in bytes.

            try
            {
                AutoFlushServerLogFile = ConfigurationManager.AppSettings.Get("AutoFlushServerLogFile");
                if (AutoFlushServerLogFile == null)
                    AutoFlushServerLogFile = "Y";

                String LogFileSize = ConfigurationManager.AppSettings.Get("MaxSizeToAutoFlushServerLogFile");
                if (LogFileSize == null)
                    LogFileSize = "5000000";
                MaxSizeToAutoFlushServerLogFile = Convert.ToInt64(LogFileSize);
            }
            catch
            {
                AutoFlushServerLogFile = "Y";
                MaxSizeToAutoFlushServerLogFile = 5000000;
            }

            try
            {
                //String DirectoryPath = System.Reflection.Assembly.LoadFrom(System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetEntryAssembly().Location)) + @"\Log";
                String DirectoryPath = System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath + "LogDetails";
                if (!Directory.Exists(DirectoryPath))
                    Directory.CreateDirectory(DirectoryPath);
                String LogFilePath = DirectoryPath + @"\" + LogFileName;


                StreamWriter sw = null;
                if (AutoFlushServerLogFile == "Y")
                {
                    if (File.Exists(LogFilePath))
                    {
                        FileInfo objFileInfo = new FileInfo(LogFilePath);
                        if (objFileInfo.Length >= MaxSizeToAutoFlushServerLogFile)
                        {
                            //Commented 04 03 2020 - B'coz Payment History Cleared
                            //File.Delete(LogFilePath);
                            //sw = File.CreateText(LogFilePath);
                            //sw.WriteLine("Auto Clear Log file on " + DateTime.Now.ToString(DateTimeLogFormat));
                            //sw.WriteLine(DateTime.Now.ToString() + "  " + message);
                            //sw.Close();
                            //return;
                            //Commented 04 03 2020 - B'coz Payment History Cleared
                        }
                    }
                }

                if (!File.Exists(LogFilePath))
                    sw = File.CreateText(LogFilePath);
                else
                    sw = File.AppendText(LogFilePath);
                sw.WriteLine(DateTime.Now.ToString(DateTimeLogFormat) + "  " + message);
                sw.Close();
            }
            catch { }
        }
        public static void CommitGradeLog(String message)
        {
            WriteLog(CommitGradeLogFile, message);
        }
        public static void ExceptionLog(String message)
        {
            FileStream fs = new FileStream(ExceptionLogFile, FileMode.Append, FileAccess.Write, FileShare.Write);
            fs.Close();
            StreamWriter sw = new StreamWriter(ExceptionLogFile, true, Encoding.ASCII);
            sw.WriteLine(message);
            sw.Close();

        }
        public static void ThemeLog(String message)
        {
            FileStream fs = new FileStream(ThemeLogFile, FileMode.Append, FileAccess.Write, FileShare.Write);
            fs.Close();
            StreamWriter sw = new StreamWriter(ThemeLogFile, true, Encoding.ASCII);
            sw.WriteLine(message);
            sw.Close();

        }

        public static void FeesLog(String message)
        {
            //FileInfo fi = new FileInfo(ServerLogFile);
            //if (!fi.Exists)
            //    ServerLogFile = "c:\\inetpub\\wwwroot\\SBSPortal\\UIL\\UploadDownload\\log.txt";

            FileStream fs = new FileStream(User_fees_Log, FileMode.Append, FileAccess.Write, FileShare.Write);
            fs.Close();
            StreamWriter sw = new StreamWriter(User_fees_Log, true, Encoding.ASCII);
            sw.WriteLine(message);
            sw.Close();
        }

        public static void FeesLogError(String message)
        {
            //FileInfo fi = new FileInfo(ServerLogFile);
            //if (!fi.Exists)
            //    ServerLogFile = "c:\\inetpub\\wwwroot\\SBSPortal\\UIL\\UploadDownload\\log.txt";

            FileStream fs = new FileStream(User_fees_error, FileMode.Append, FileAccess.Write, FileShare.Write);
            fs.Close();
            StreamWriter sw = new StreamWriter(User_fees_error, true, Encoding.ASCII);
            sw.WriteLine(message);
            sw.Close();
        }
        public static void Flush()
        {
            File.Delete(ServerLogFile);
        }
    }
}
