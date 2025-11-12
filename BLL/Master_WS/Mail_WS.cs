using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;
using System.Data;
using BLL.Utilities;
using XSD.Masters_WS;
using System.Threading;
using System.Configuration;
using System.Web;
using System.Net.Mime;

namespace BLL.Master_WS
{
    public class Mail_WS
    {
        string not_send_mail_list = "";

        public static int counter = 0;

        string message_body = "";

        string mail_subject = "";

        DataTable studentemail = null;

        Dictionary<string, string> dic_thread_id = new Dictionary<string, string>();
        String Current_Host = HttpContext.Current.Request.Url.Host;

        int port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"].ToString());

        #region Send Mail to Instructors for Feedback Remarks

        public String SendFeedbackRemarkMail(string feedback_email, string password, DataTable faculty_email, string remark, string subject)
        {
            string ToAddress = "";

            String Message = remark;
            String Subject = subject;
            try
            {
                for (int i = 0; i < faculty_email.Rows.Count; i++)
                {
                    if (faculty_email.Rows[i]["mail"].ToString() != "")
                    {
                        try
                        {
                            ToAddress = faculty_email.Rows[i]["mail"].ToString();

                            SmtpClient smtp = new SmtpClient
                            {
                                Host = "smtp.gmail.com", // smtp server address here...
                                Port = port,
                                EnableSsl = true,
                                DeliveryMethod = SmtpDeliveryMethod.Network,
                                Credentials = new System.Net.NetworkCredential(feedback_email, password),
                                Timeout = 50000,
                            };

                            MailMessage mail = new MailMessage();
                            mail.To.Add(ToAddress);
                            mail.Subject = Subject;
                            mail.From = new MailAddress(feedback_email, "CEPT");
                            mail.IsBodyHtml = true;
                            mail.Body = (Message);
                            if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                            {
                                smtp.Send(mail);
                            }
                        }
                        catch (Exception ex)
                        {
                            not_send_mail_list += ToAddress + ", ";
                        }
                    }
                }

                if (not_send_mail_list != "")
                {
                    return "mail is not send for this emails : " + not_send_mail_list;
                }
            }
            catch (Exception ex)
            {
                return "Some problem in mail send.mail is not send";
            }

            return "success";
        }

        #endregion

        #region Send Mail to Student for Fees status

        public String SendFeesStatusMail(string admin_mail, string password, string student_email, string remark, string subject)
        {
            string ToAddress = "";

            String Message = remark;
            String Subject = subject;
            try
            {
                try
                {
                    ToAddress = student_email.ToString();

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(admin_mail, password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    mail.To.Add(ToAddress);
                    mail.Subject = Subject;
                    mail.From = new MailAddress(admin_mail, "CEPT");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    //not_send_mail_list += ToAddress + ", ";
                    return ex.ToString();
                }
            }
            catch (Exception ex)
            {
                return "Some problem in mail send.mail is not send";
            }

            return "success";
        }

        #endregion

        #region Send Mail to Student for publish allocation

        public String sendmailforpublish(DataTable student_email, string remark, string subject)
        {
            try
            {
                counter = 0;

                message_body = remark;
                mail_subject = subject;

                studentemail = student_email;

                Thread th1 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th2 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th3 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th4 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th5 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th6 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th7 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th8 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th9 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));
                Thread th10 = new Thread(new ThreadStart(SendMailtostudentforPublish_new));

                dic_thread_id[th1.ManagedThreadId.ToString() + "_dept_code"] = "1";
                dic_thread_id[th1.ManagedThreadId.ToString() + "_prog_code"] = "1";
                dic_thread_id[th2.ManagedThreadId.ToString() + "_dept_code"] = "1";
                dic_thread_id[th2.ManagedThreadId.ToString() + "_prog_code"] = "2";

                dic_thread_id[th3.ManagedThreadId.ToString() + "_dept_code"] = "2";
                dic_thread_id[th3.ManagedThreadId.ToString() + "_prog_code"] = "1";
                dic_thread_id[th4.ManagedThreadId.ToString() + "_dept_code"] = "2";
                dic_thread_id[th4.ManagedThreadId.ToString() + "_prog_code"] = "2";

                dic_thread_id[th5.ManagedThreadId.ToString() + "_dept_code"] = "3";
                dic_thread_id[th5.ManagedThreadId.ToString() + "_prog_code"] = "2";

                dic_thread_id[th6.ManagedThreadId.ToString() + "_dept_code"] = "4";
                dic_thread_id[th6.ManagedThreadId.ToString() + "_prog_code"] = "1";
                dic_thread_id[th7.ManagedThreadId.ToString() + "_dept_code"] = "4";
                dic_thread_id[th7.ManagedThreadId.ToString() + "_prog_code"] = "2";

                dic_thread_id[th8.ManagedThreadId.ToString() + "_dept_code"] = "5";
                dic_thread_id[th8.ManagedThreadId.ToString() + "_prog_code"] = "1";
                dic_thread_id[th9.ManagedThreadId.ToString() + "_dept_code"] = "5";
                dic_thread_id[th9.ManagedThreadId.ToString() + "_prog_code"] = "2";

                dic_thread_id[th10.ManagedThreadId.ToString() + "_dept_code"] = "7";
                dic_thread_id[th10.ManagedThreadId.ToString() + "_prog_code"] = "1";

                th1.Start();
                th2.Start();
                th3.Start();
                th4.Start();
                th5.Start();
                th6.Start();
                th7.Start();
                th8.Start();
                th9.Start();
                th10.Start();

                while (true)
                {
                    if (counter >= studentemail.Rows.Count)
                    {
                        th1.Abort();
                        th2.Abort();
                        th3.Abort();
                        th4.Abort();
                        th5.Abort();
                        th6.Abort();
                        th7.Abort();
                        th8.Abort();
                        th9.Abort();
                        th10.Abort();
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                ServerLog.ExceptionLog(ex.ToString());
            }

            return "success";
        }

        public String sendmailforpublishnew(DataTable student_email, string remark, string subject)
        {
            try
            {
                message_body = remark;
                mail_subject = subject;

                studentemail = student_email;

                SendMailtostudentforPublish_new2();
            }
            catch (Exception ex)
            {
                ServerLog.ExceptionLog(ex.ToString());
            }

            return "success";
        }

        public void SendMailtostudentforPublish_new()
        {
            string ToAddress = "", prog_code = "", dept_code = "";

            String Message = message_body;
            String Subject = mail_subject;

            var thread_id = Thread.CurrentThread.ManagedThreadId.ToString();

            string directory_path = "C:/Ceptreg_Log/CEPT_WS_mail_log/";

            System.IO.File.WriteAllText(@"" + directory_path + thread_id + ".txt", "Managed Thread ID : " + thread_id + Environment.NewLine);
            System.IO.File.WriteAllText(@"" + directory_path + thread_id + "_Exception.txt", "Managed Thread ID : " + thread_id + Environment.NewLine);

            string from_mail = "", from_password = "";
            try
            {
                DataRow[] dr_student_data = studentemail.Select("dept_code = '" + dic_thread_id[thread_id + "_dept_code"].ToString() + "' and prog_code = '" + dic_thread_id[thread_id + "_prog_code"].ToString() + "'");
                System.IO.File.AppendAllText(@"" + directory_path + thread_id + ".txt", "Total Students : " + dr_student_data.Length + Environment.NewLine);

                //while (true)
                //{
                for (int i = 0; i < dr_student_data.Length; i++)
                {
                    if (counter < studentemail.Rows.Count)
                    {
                        //Thread.Sleep(1000 * 5);

                        //DataRow dr = studentemail.Rows[counter++];
                        DataRow dr = dr_student_data[i];

                        counter++;

                        if (dr["mail"].ToString() != "")
                        {
                            try
                            {
                                ToAddress = dr["mail"].ToString();

                                dept_code = dr["dept_code"].ToString();
                                prog_code = dr["prog_code"].ToString();

                                //from_mail = "donotreply@cept.ac.in";
                                //from_password = "cept2014";

                                from_mail = "swsnotreply@cept.ac.in";
                                //from_password = "CEPT@2016";
                                from_password = "pwujalrdcbsegjfo";

                                //switch (dept_code)
                                //{
                                //    case "1":
                                //        if (prog_code == "1")
                                //        {
                                //            from_mail = "donotreply.ug.fa@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "2")
                                //        {
                                //            from_mail = "donotreply.pg.fa@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "3")
                                //        {

                                //        }
                                //        break;
                                //    case "2":
                                //        if (prog_code == "1")
                                //        {
                                //            from_mail = "donotreply.ug.fd@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "2")
                                //        {
                                //            from_mail = "donotreply.pg.fd@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "3")
                                //        {

                                //        }
                                //        break;
                                //    case "3":
                                //        if (prog_code == "1")
                                //        {
                                //            from_mail = "donotreply.ug.fm@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "2")
                                //        {
                                //            from_mail = "donotreply.pg.fm@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "3")
                                //        {

                                //        }
                                //        break;
                                //    case "4":
                                //        if (prog_code == "1")
                                //        {
                                //            from_mail = "donotreply.ug.fp@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "2")
                                //        {
                                //            from_mail = "donotreply.pg.fp@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "3")
                                //        {

                                //        }
                                //        break;
                                //    case "5":
                                //        if (prog_code == "1")
                                //        {
                                //            from_mail = "donotreply.ug.ft@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "2")
                                //        {
                                //            from_mail = "donotreply.pg.ft@cept.ac.in";
                                //            from_password = "CEPT@2015";
                                //        }
                                //        else if (prog_code == "3")
                                //        {

                                //        }
                                //        break;

                                //    case "7":
                                //        from_mail = "donotreply@cept.ac.in";
                                //        from_password = "cept2014";
                                //        break;
                                //    default:
                                //        break;
                                //}

                                SmtpClient smtp = new SmtpClient
                                {
                                    Host = "smtp.gmail.com", // smtp server address here...
                                    Port = port,
                                    EnableSsl = true,
                                    DeliveryMethod = SmtpDeliveryMethod.Network,
                                    Credentials = new System.Net.NetworkCredential(from_mail, from_password),
                                    Timeout = 50000,
                                };

                                MailMessage mail = new MailMessage();
                                mail.To.Add(ToAddress);
                                mail.Subject = Subject;
                                mail.From = new MailAddress(from_mail, "CEPT");

                                mail.IsBodyHtml = true;
                                mail.Body = (Message);

                                //if (from_mail == "donotreply.pg.fa@cept.ac.in")
                                //{
                                //    //smtp.Send(mail);
                                //}
                                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                                {
                                    smtp.Send(mail);
                                }
                                //ServerLog.ExceptionLog(ToAddress.ToString());
                                System.IO.File.AppendAllText(@"" + directory_path + thread_id + ".txt", "ToAddress :: " + ToAddress.ToString() + " :: Counter :: " + counter + " :: i-Counter :: " + (i + 1) + Environment.NewLine);

                            }
                            catch (Exception ex)
                            {
                                //ServerLog.ExceptionLog("In loop - " + ex.ToString());
                                System.IO.File.AppendAllText(@"" + directory_path + thread_id + "_Exception.txt", "Mail send error :: " + ToAddress.ToString() + " :: Counter :: " + counter + Environment.NewLine);
                                System.IO.File.AppendAllText(@"" + directory_path + thread_id + "_Exception.txt", "Exception :: " + ex.ToString() + Environment.NewLine);
                            }
                        }
                        //}
                    }
                    else
                    {
                        //ServerLog.ExceptionLog("kamlesh - " + counter);
                        System.IO.File.AppendAllText(@"" + directory_path + thread_id + ".txt", "Else counter :: " + counter + Environment.NewLine);
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                //return "Some problem in mail send.mail is not send";
                System.IO.File.AppendAllText(@"" + directory_path + thread_id + "_Exception.txt", "Exception :: " + ex.ToString() + Environment.NewLine);
            }
            //return "success";
        }

        public void SendMailtostudentforPublish_new2()
        {
            string ToAddress = "";

            String Message = message_body;
            String Subject = mail_subject;

            string directory_path = "C:/Ceptreg_Log/CEPT_WS_mail_log/";

            string from_mail = "", from_password = "";
            try
            {
                System.IO.File.AppendAllText(@"" + directory_path + "Success.txt", "Total Students : " + studentemail.Rows.Count + Environment.NewLine);

                for (int i = 0; i < studentemail.Rows.Count; i++)
                {
                    ToAddress = studentemail.Rows[i]["mail"].ToString();

                    if (ToAddress != "")
                    {
                        try
                        {
                            from_mail = "swsnotreply@cept.ac.in";
                            //from_password = "CEPT@2016";
                            from_password = "pwujalrdcbsegjfo";

                            SmtpClient smtp = new SmtpClient
                            {
                                Host = "smtp.gmail.com", // smtp server address here...
                                Port = port,
                                EnableSsl = true,
                                DeliveryMethod = SmtpDeliveryMethod.Network,
                                Credentials = new System.Net.NetworkCredential(from_mail, from_password),
                                Timeout = 50000,
                            };
                            
                            MailMessage mail = new MailMessage();
                            mail.To.Add(ToAddress);
                            mail.Subject = Subject;
                            mail.From = new MailAddress(from_mail, "CEPT");

                            mail.IsBodyHtml = true;
                            mail.Body = (Message);

                            if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                            {
                                smtp.Send(mail);
                            }
                            System.IO.File.AppendAllText(@"" + directory_path + "Success.txt", "ToAddress :: " + ToAddress.ToString() + " :: Success " + DateTime.Now.ToString() + Environment.NewLine);
                        }
                        catch (Exception ex)
                        {
                            System.IO.File.AppendAllText(@"" + directory_path + "Unsuccess_Exception.txt", "Mail send error :: " + ToAddress.ToString() + "Time " + DateTime.Now.ToString() + Environment.NewLine);
                            System.IO.File.AppendAllText(@"" + directory_path + "Unsuccess_Exception.txt", "Exception :: " + ex.ToString() + "Time " + DateTime.Now.ToString() + Environment.NewLine);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.IO.File.AppendAllText(@"" + directory_path + "Unsuccess_Exception.txt", "Exception :: " + ex.ToString() + Environment.NewLine);
            }
        }

        #endregion

        #region Send Accept Reject Email for Manually Payslip

        public String Send_accept_reject_mail(string admin_mail, string password, string student_email, string remark, string subject)
        {
            string ToAddress = "";

            String Subject = subject;
            try
            {
                try
                {
                    ToAddress = student_email.ToString();

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(admin_mail, password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    mail.To.Add(ToAddress);
                    mail.Subject = Subject;
                    mail.From = new MailAddress(admin_mail, "CEPT");
                    mail.IsBodyHtml = true;
                    mail.Body = (remark);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    //not_send_mail_list += ToAddress + ", ";
                    return ex.ToString();
                }
            }
            catch (Exception ex)
            {
                return "Some problem in mail send.mail is not send";
            }

            return "success";
        }

        #endregion

        public String send_test_mail(string remark, string subject)
        {
            try
            {
                string from_mail = "donotreply.pg.fm@cept.ac.in";
                string from_password = "CEPT@2015";


                SmtpClient smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com", // smtp server address here...
                    Port = port,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Credentials = new System.Net.NetworkCredential(from_mail, from_password),
                    Timeout = 50000,
                };

                //     string path = HttpContext.Current.Server.MapPath(@"image/popup_allocation.png"); // my logo is placed in images folder

                //  LinkedResource logo = new LinkedResource("https://sws.cept.ac.in//image/popup_allocation.png");
                //    logo.ContentId = "Screenshot";

                //now do the HTML formatting
                //AlternateView av1 = AlternateView.CreateAlternateViewFromString(
                //      "<html><body>" + remark + "<img src=" + path + "/>" +
                //      "<br></body></html>",
                //      null, MediaTypeNames.Text.Html);

                ////now add the AlternateView
                //av1.LinkedResources.Add(logo);

                //now append it to the body of the mail


                MailMessage mail = new MailMessage();
                //   mail.AlternateViews.Add(av1);
                mail.To.Add("call2kamlesh2007@gmail.com");
                mail.Subject = subject;
                mail.From = new MailAddress(from_mail, "TEST");

                mail.IsBodyHtml = true;
                mail.Body = (remark);

                //if (from_mail == "donotreply.pg.fa@cept.ac.in")
                //{
                //    //smtp.Send(mail);
                //}
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
            }
            catch (Exception ex)
            {

                throw;
            }

            return "success";
        }
    }
}
