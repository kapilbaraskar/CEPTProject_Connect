using System;
using System.Configuration;
using System.IO;

namespace BLL.Utilities1
{
    public class Log
    {
        private static String ClientRequestLogFile = ConfigurationManager.AppSettings.Get("ClientRequestLogFile");
        private static String ExceptionLogFile = "ExceptionLog.txt";
        private static String InvalidLoginLogFile = "InvalidLog.txt";
        private static String PaymentTransactionLogFile = ConfigurationManager.AppSettings.Get("PaymentTransactionLogFile");
        private static String DateTimeLogFormat = "dd-MMM-yyyy hh:mm:ss:fffffff tt";

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

        public static void ClientRequestLog(String message)
        {
            WriteLog(ClientRequestLogFile, message);
        }

        public static void ExceptionLog(String message)
        {
            WriteLog(ExceptionLogFile, message);
        }
        public static void InvalidLoginLog(String message)
        {
            WriteLog(InvalidLoginLogFile, message);
        }
        public static void PaymentTransactionLog(String message)
        {
            WriteLog(PaymentTransactionLogFile, message);
        }
        private static void Flush(String LogFile)
        {
            try
            {
                File.Delete(LogFile);
                StreamWriter sw = File.CreateText(LogFile);
                sw.WriteLine("Clear Log file on " + DateTime.Now.ToString(DateTimeLogFormat));
                sw.Close();
            }
            catch { }
        }

        public static void FlushClientRequestLog()
        {
            Flush(ClientRequestLogFile);
        }

        public static void FlushExceptionLog()
        {
            Flush(ExceptionLogFile);
        }
        public static void FlushPaymentTransactionLog()
        {
            Flush(PaymentTransactionLogFile);
        }
        public static void FlushALL()
        {
            Flush(ClientRequestLogFile);
            Flush(InvalidLoginLogFile);
            Flush(PaymentTransactionLogFile);
            Flush(ExceptionLogFile);
        }

        public void ExceptionLogEntry(String message)
        {
            StreamWriter sw = null;
            if (File.Exists(ExceptionLogFile))
                sw = File.AppendText(ExceptionLogFile);
            else
                sw = File.CreateText(ExceptionLogFile);

            sw.WriteLine(DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss:ffffff tt") + "    " + message);
            sw.WriteLine("-----------------------------------------------------------------------------------------------------");
            sw.Close();
        }
    }
}