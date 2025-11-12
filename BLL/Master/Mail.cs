using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net.Mail;
using System.Data;
using BLL.Utilities;
using XSD.Masters;
using System.Threading;
using System.Configuration;
using BLL.Utilities1;
using System.Web;
using System.Net;
using System.IO;

namespace BLL.Master
{
    public class Mail
    {
        string not_send_mail_list = "";
        public static int counter = 0;
        string message_body = "";
        string mail_subject = "";
        int installment_no = 0;
        string due_date = "";
        string Message_body_gen = "";
        string Subject_gen = "";
        string filePath_gen = "";
        string ToMail_gen = "";
        string FromMail_gen = "";
        string FromPassword_gen = "";
        string CCMail_gen = "";
        DataTable studentemail = null;
        String Host = HttpContext.Current.Request.Url.ToString();
        String Current_Host = HttpContext.Current.Request.Url.Host;
        Dictionary<string, string> dic_thread_id = new Dictionary<string, string>();
        int port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"].ToString());
        #region send opt mobile number verification
        public bool SendSMS(string number, string otp)
        {
            SendReceiveJSon objResponse = new SendReceiveJSon();
            //string url = "http://mysms.dynasoft.in/sendsms.aspx?";
            string url = "http://sms.dynasoft.in/sendsms.aspx?";
            //string mobile = "9574777510";
            //string pass = "admin123";
            string mobile = "9824432279";
            string pass = "anjali@86";

            //string senderid = "SMSBUZ";
            //string senderid = "CEPTAO";
            string senderid = "CEPTUN";

            string to = number;
            string msg = "Your Verification Code is " + " " + otp;

            try
            {
                WebRequest request = HttpWebRequest.Create(url + "mobile=" + mobile + "&pass=" + pass + "&senderid=" + senderid + "&to=" + to + "&msg=" + msg);
                WebResponse response = request.GetResponse();
                StreamReader reader = new StreamReader(response.GetResponseStream());
                string urlText = reader.ReadToEnd(); // it takes the response from your url. now you can use as your need 
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }
        #endregion
        #region Send Mail for Varification Code (Used in Registration Page)
        public String sendVarificationCodeToUser(string EmailId, string FirstName, string verificationCode)//, string UserName
        {
            #region Make Varification
            String VarificationLink = Host.Substring(0, Host.LastIndexOf('/'));
            VarificationLink = VarificationLink.Substring(0, VarificationLink.LastIndexOf('/') + 1) + "EmailVerify.aspx?";
            VarificationLink += "UN=" + (EmailId);
            VarificationLink += "&VT=" + (verificationCode);
            #endregion

            String Message = "";
            String Subject = "";

            Subject = "Welcome to CEPT University!";

            Message = "Dear " + FirstName + ",<br/><p>Welcome! Your account has been created. By clicking on the following button, please verify your account and complete your details.</p>";
            Message += "<div style=\"text-align:center; padding:10px 0 10px 0;\"><a href=" + VarificationLink + " style=\"background:#337BC4; color:#fff; text-decoration:none; font-size:13px; display:inline-block; padding:10px;\">Validate Email</a></div>";
            Message += "<br /><p>Sincerely,<br />-- CEPT</p>";

            //Change email id and password to send verification email

            string from_mail = "donotreply@cept.ac.in";
            string from_password = "vyujpnmbkllqrujz";  //cept2014

            SmtpClient smtp = new SmtpClient
            {
                Host = "smtp.gmail.com", // smtp server address here...
                //Port = 587,
                Port = port,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new System.Net.NetworkCredential(from_mail, from_password),
                Timeout = 50000,
            };

            EmailId = EmailId.Trim();

            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(EmailId);
                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                    Log.ExceptionLog("Email Sent Successfully. " + EmailId + Environment.NewLine);
                }

            }
            catch (Exception ex)
            {
                Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return "unsuccess";
            }
            return "success";
        }
        #endregion

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

        public String SendFeedbackPDFRemarkMail(string feedback_email, string password, DataTable faculty_email, string remark, string subject, string attachement_name, string semesteryear)
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

                            string attach_name = attachement_name + "_" + faculty_email.Rows[i]["instructor_name"].ToString() + "_" + semesteryear;

                            string remarks = "Dear Prof. " + faculty_email.Rows[i]["instructor_name"].ToString() + "," + Message;

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
                            //mail.CC.Add("student.feedback@cept.ac.in");
                            mail.Subject = Subject;
                            mail.From = new MailAddress(feedback_email, "CEPT");
                            mail.IsBodyHtml = true;
                            mail.Body = (remarks);

                            Attachment attach = new Attachment("C:/inetpub/wwwroot/CEPTREG/FeedbackPdf/" + attach_name.Replace('/', '_') + ".pdf");
                            attach.Name = attach_name.Replace('/', '_') + ".pdf";
                            mail.Attachments.Add(attach);
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
                    return "There is an error in course feedback. Mail is not sent for the given emails : " + not_send_mail_list;
                }
            }
            catch (Exception ex)
            {
                return "There is an error in course feedback. Mail is not sent for the given emails.";
            }

            return "success";
        }

        public String SendFeedbackPDFRemarkMailIndividual(string feedback_email, string password, string remark, string subject, string attachement_name, string instructor_mail)
        {
            string ToAddress = "";

            String Message = remark;
            String Subject = subject;
            try
            {
                try
                {
                    ToAddress = instructor_mail;

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
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "To Address : " + ToAddress + Environment.NewLine);
                    //mail.CC.Add("student.feedback@cept.ac.in");
                    mail.Subject = Subject;
                    mail.From = new MailAddress(feedback_email, "CEPT");
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "From Mail : " + feedback_email + Environment.NewLine);
                    mail.IsBodyHtml = true;
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Body : " + remark + Environment.NewLine);
                    mail.Body = (remark);

                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Instructor mail : " + instructor_mail + Environment.NewLine);
                    string attah_1 = "c:/ inetpub / wwwroot / ceptreg / feedbackpdf / " + System.Text.RegularExpressions.Regex.Replace(attachement_name.Replace('/', '_').Replace(':', '_'), @"\s + ", " ") + ".pdf";
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Attachment File Path And Name : " + attah_1 + Environment.NewLine);

                    Attachment attach = new Attachment("c:/inetpub/wwwroot/ceptreg/feedbackpdf/" + System.Text.RegularExpressions.Regex.Replace(attachement_name.Replace('/', '_').Replace(':', '_'), @"\s+", " ") + ".pdf");
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Attachment After : " + Environment.NewLine);

                    attach.Name = System.Text.RegularExpressions.Regex.Replace(attachement_name.Replace('/', '_').Replace(':', '_'), @"\s+", " ") + ".pdf";
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Attachment File Name : " + attachement_name + Environment.NewLine);

                    mail.Attachments.Add(attach);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    not_send_mail_list += ToAddress + ", ";

                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Send Feedback PDF : " + ex.ToString() + Environment.NewLine);
                }

                if (not_send_mail_list != "")
                {
                    return "There is an error in course feedback. Mail is not sent for the given emails : " + not_send_mail_list;
                }
            }
            catch (Exception ex)
            {
                return "There is an error in course feedback. Mail is not sent for the given emails.";
            }

            return "success";
        }


        public String SWSSendFeedbackPDFRemarkMailIndividual(string feedback_email, string password, string remark, string subject, string attachement_name, string instructor_mail)
        {
            string ToAddress = "";

            String Message = remark;
            String Subject = subject;
            try
            {
                try
                {
                    ToAddress = instructor_mail;

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
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "To Address : " + ToAddress + Environment.NewLine);
                    //mail.CC.Add("student.feedback@cept.ac.in");
                    mail.Subject = Subject;
                    mail.From = new MailAddress(feedback_email, "CEPT");
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "From Mail : " + feedback_email + Environment.NewLine);
                    mail.IsBodyHtml = true;
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Body : " + remark + Environment.NewLine);
                    mail.Body = (remark);

                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Instructor mail : " + instructor_mail + Environment.NewLine);
                    string attah_1 = "c:/ inetpub / wwwroot / ceptreg / feedbackpdf / " + System.Text.RegularExpressions.Regex.Replace(attachement_name.Replace('/', '_').Replace(':', '_'), @"\s + ", " ") + ".pdf";
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Attachment File Path And Name : " + attah_1 + Environment.NewLine);
                    string path = "c:/inetpub/wwwroot/ceptreg/SWSFeedbackPdf/";
                    if (Current_Host == "localhost")
                    {
                        path = "C:/CEPTPROJECT/CEPT_REG/CEPT/SWSFeedbackPdf/";
                    }

                    Attachment attach = new Attachment(path + System.Text.RegularExpressions.Regex.Replace(attachement_name.Replace('/', '_').Replace(':', '_'), @"\s+", " ") + ".pdf");
                    
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Attachment After : " + Environment.NewLine);

                    attach.Name = System.Text.RegularExpressions.Regex.Replace(attachement_name.Replace('/', '_').Replace(':', '_'), @"\s+", " ") + ".pdf";
                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Attachment File Name : " + attachement_name + Environment.NewLine);

                    mail.Attachments.Add(attach);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    not_send_mail_list += ToAddress + ", ";

                    System.IO.File.AppendAllText(@"" + "C:/Ceptreg_Log/Course_mst_log/error.txt", "Send Feedback PDF : " + ex.ToString() + Environment.NewLine);
                }

                if (not_send_mail_list != "")
                {
                    return "There is an error in course feedback. Mail is not sent for the given emails : " + not_send_mail_list;
                }
            }
            catch (Exception ex)
            {
                return "There is an error in course feedback. Mail is not sent for the given emails.";
            }

            return "success";
        }


        #region Send Mail to Studdent for Fees status

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

        #region Send Mail to Student on Fees payment successfull

        public String SendEmailOnfeesPaymentSuccess(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    if (!data.ContainsKey("pg_type")) data["pg_type"] = "Citrus";

                    Message = "Hello " + data["user_name"].ToString() + ",";
                    Message += "<br /><br />Your payment with Cept <b>" + data["program_name"].ToString() + "</b> using " + data["pg_type"] + " was <b>successful!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />" + data["pg_type"] + " Reference Number :  " + data["pg_transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Payment Received :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    //Message += "<br /><br /><br />For payment related queries please contact admissions.finance@cept.ac.in";



                    if (data["year_code"].ToString().ToUpper() == "Y2020" && data["prog_code"].ToString() == "1" && data["dept_code"].ToString() == "2")
                    {
                        Message += "<br /><br /><br />If you face any difficulty or payment related queries please contact admissions@cept.ac.in and copying to connect.help@cept.ac.in.";
                    }
                    else if (data["year_code"].ToString().ToUpper() == "Y2020" && data["prog_code"].ToString() == "1" && data["dept_code"].ToString() == "5")
                    {
                        Message += "<br /><br /><br />If you face any difficulty or payment related queries please contact admissions@cept.ac.in and copying to connect.help@cept.ac.in.";
                    }
                    else
                    {
                        Message += "<br /><br /><br />For payment related queries please contact ug.office@cept.ac.in for UG programs and pg.office@cept.ac.in for PG Programs.";
                    }

                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    //ToAddress = "mpanchal2707@gmail.com";
                    mail.To.Add(ToAddress);
                    //mail.To.Add("connect.help@cept.ac.in");
                    mail.Subject = "Payment Confirmation";
                    mail.From = new MailAddress(sending_email, "CEPT");
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

        #region Send Mail to Student on Fees payment successfull

        public String SendEmailOnfeesPaymentFail(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your online payment with CEPT <b>" + data["program_name"].ToString() + " has failed!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Transaction Amount :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    Message += "<br /><br /><br />In case the amount has been deducted from your account, contact your bank with details of the transaction. You are also requested to email the proof of transaction/debit in your account to admissions.finance@cept.ac.in for further action.";
                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    //ToAddress = "mpanchal2707@gmail.com";
                    mail.To.Add(ToAddress);
                    //mail.To.Add("connect.help@cept.ac.in");
                    mail.Subject = "Payment Fail";
                    mail.From = new MailAddress(sending_email, "CEPT");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    return ex.ToString();
                }
            }
            catch (Exception ex)
            {
                return "Some problem in mail sent. Mail is not sent";
            }
            return "success";
        }

        #endregion

        #region Send Mail to Student on Fees payment unsuccessfull
        public String SendEmailOnfeesPaymentUnSuccess(Dictionary<string, string> data)
        {
            string ToAddress = "";

            String Message = "";

            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();

            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();


            try
            {

                try
                {
                    ToAddress = data["student_email"].ToString();

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your payment with Cept <b>" + data["program_name"].ToString() + "</b> using Citrus was <b>unsuccessful!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    //  Message += "<br /><br />Citrus Reference Number :  " + data["pg_transaction_id"].ToString() + "";
                    //    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    //  Message += "<br /><br />Payment Received :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    Message += "<br /><br /><br />If you would like to try again, please do so after some time.";
                    Message += "<br /><br /><br />In case your account was debited in error, you should receive refund within next 72 hours from your bank. In case of any difficulty, request you to contact your bank for further details.";

                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    mail.To.Add(ToAddress);
                    mail.Subject = "Registration Details - CEPT";
                    mail.From = new MailAddress(sending_email, "CEPT");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }

                }
                catch (Exception ex)
                {

                    // not_send_mail_list += ToAddress + ", ";

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

                    // not_send_mail_list += ToAddress + ", ";

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

        public String SendMailtostudentforPublish(DataTable student_email, string remark, string subject)
        {
            string ToAddress = "", prog_code = "", dept_code = "";

            String Message = remark;
            String Subject = subject;
            string mail_status = "N";

            string from_mail = "", from_password = "";
            try
            {
                for (int i = 0; i < student_email.Rows.Count; i++)
                {
                    mail_status = "N";

                    if (student_email.Rows[i]["mail"].ToString() != "")
                    {
                        try
                        {
                            ToAddress = student_email.Rows[i]["mail"].ToString();

                            dept_code = student_email.Rows[i]["dept_code"].ToString();
                            prog_code = student_email.Rows[i]["prog_code"].ToString();

                            switch (dept_code)
                            {
                                case "1":
                                    if (prog_code == "1")
                                    {

                                    }
                                    else if (prog_code == "2")
                                    {

                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "2":
                                    if (prog_code == "1")
                                    {

                                    }
                                    else if (prog_code == "2")
                                    {

                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "3":
                                    if (prog_code == "1")
                                    {

                                    }
                                    else if (prog_code == "2")
                                    {

                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "4":
                                    if (prog_code == "1")
                                    {

                                    }
                                    else if (prog_code == "2")
                                    {

                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "5":
                                    if (prog_code == "1")
                                    {

                                    }
                                    else if (prog_code == "2")
                                    {

                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                default:
                                    break;
                            }


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

                            mail_status = "Y";

                        }
                        catch (Exception ex)
                        {
                            mail_status = "N";

                        }
                    }
                }



            }
            catch (Exception ex)
            {
                return "Some problem in mail send.mail is not send";

            }

            return "success";
        }

        public String sendmailforpublish(DataTable student_email, string remark, string subject)
        {
            try
            {
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

                th1.Start();
                th2.Start();
                th3.Start();
                th4.Start();
                th5.Start();
                th6.Start();
                th7.Start();
                th8.Start();
                th9.Start();

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

                        counter = 0;
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

        public void SendMailtostudentforPublish_new()
        {
            string ToAddress = "", prog_code = "", dept_code = "";

            String Message = message_body;
            String Subject = mail_subject;

            var thread_id = Thread.CurrentThread.ManagedThreadId.ToString();

            string directory_path = "C:/Ceptreg_Log/CEPT_mail_log/";

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

                                switch (dept_code)
                                {
                                    case "1":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fa@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fa@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "2":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fd@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fd@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "3":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fm@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fm@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "4":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fp@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fp@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "5":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.ft@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.ft@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    default:
                                        break;
                                }

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
                        //ServerLog.ExceptionLog(" - " + counter);
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


        public dynamic sws_SendMailtostudentforPublish(DataTable student_email_id, string remark, string subject)
        {
            string ToAddress = "", prog_code = "", dept_code = "";

            String Message = message_body;
            String Subject = mail_subject;
            string user_id = "";
            var thread_id = Thread.CurrentThread.ManagedThreadId.ToString();

            string directory_path = "C:/Ceptreg_Log/CEPT_mail_log/";

            //System.IO.File.WriteAllText(@"" + directory_path + thread_id + ".txt", "Managed Thread ID : " + thread_id + Environment.NewLine);
            //System.IO.File.WriteAllText(@"" + directory_path + thread_id + "_Exception.txt", "Managed Thread ID : " + thread_id + Environment.NewLine);

            string from_mail = "", from_password = "";
            try
            {
                //DataRow[] dr_student_data = studentemail.Select("dept_code = '" + dic_thread_id[thread_id + "_dept_code"].ToString() + "' and prog_code = '" + dic_thread_id[thread_id + "_prog_code"].ToString() + "'");
                //System.IO.File.AppendAllText(@"" + directory_path + thread_id + ".txt", "Total Students : " + dr_student_data.Length + Environment.NewLine);

                //while (true)
                //{
                for (int i = 0; i < student_email_id.Rows.Count; i++)
                {

                    user_id = student_email_id.Rows[i]["user_id"].ToString();
                    if (student_email_id.Rows[i]["mail"].ToString() != "")
                    {
                        try
                        {
                            ToAddress = student_email_id.Rows[i]["mail"].ToString();

                            dept_code = student_email_id.Rows[i]["dept_code"].ToString();
                            prog_code = student_email_id.Rows[i]["prog_code"].ToString();

                            //from_mail = "donotreply@cept.ac.in";
                            //from_password = "cept2014";

                            switch (dept_code)
                            {
                                case "1":
                                    if (prog_code == "1")
                                    {
                                        from_mail = "donotreply.ug.fa@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "2")
                                    {
                                        from_mail = "donotreply.pg.fa@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "2":
                                    if (prog_code == "1")
                                    {
                                        from_mail = "donotreply.ug.fd@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "2")
                                    {
                                        from_mail = "donotreply.pg.fd@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "3":
                                    if (prog_code == "1")
                                    {
                                        from_mail = "donotreply.ug.fm@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "2")
                                    {
                                        from_mail = "donotreply.pg.fm@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "4":
                                    if (prog_code == "1")
                                    {
                                        from_mail = "donotreply.ug.fp@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "2")
                                    {
                                        from_mail = "donotreply.pg.fp@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                case "5":
                                    if (prog_code == "1")
                                    {
                                        from_mail = "donotreply.ug.ft@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "2")
                                    {
                                        from_mail = "donotreply.pg.ft@cept.ac.in";
                                        from_password = "CEPT@2015";
                                    }
                                    else if (prog_code == "3")
                                    {

                                    }
                                    break;
                                default:
                                    break;
                            }

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
                            System.IO.File.AppendAllText(@"" + directory_path + student_email_id.Rows[i]["user_id"].ToString() + ".txt", "ToAddress :: " + ToAddress.ToString() + Environment.NewLine);

                        }
                        catch (Exception ex)
                        {
                            //ServerLog.ExceptionLog("In loop - " + ex.ToString());
                            System.IO.File.AppendAllText(@"" + directory_path + student_email_id.Rows[i]["user_id"].ToString() + "_Exception.txt", "Mail send error :: " + ToAddress.ToString() + Environment.NewLine);
                            System.IO.File.AppendAllText(@"" + directory_path + student_email_id.Rows[i]["user_id"].ToString() + "_Exception.txt", "Exception :: " + ex.ToString() + Environment.NewLine);
                        }
                    }


                }
                return "success";
            }
            catch (Exception ex)
            {
                //return "Some problem in mail send.mail is not send";
                System.IO.File.AppendAllText(@"" + directory_path + user_id + "_Exception.txt", "Exception :: " + ex.ToString() + Environment.NewLine);
                return "false";
            }

            //return "success";
        }

        #endregion

        #region Send Mail to Visiting Faculty for Appointment Letter

        public String Send_Appointment_Mail_to_visiting_faculty(Dictionary<string, object>[] dic_instructor_list, DataTable AckDetails)
        {
            //string source_email = "donotreply.ug.fm@cept.ac.in";
            string source_email = "";
            string password = "CEPT2016";
            string ToAddress = "";
            String Message = "";
            String Subject = "";
            String Body = "";
            string directory_path = "C:/Ceptreg_Log/Send_Appointment_Letter/Log/";
            string filename = "Visiting_Faculty_Mail_Log";
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Date : " + DateTime.Now + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);

            try
            {
                for (int i = 0; i < dic_instructor_list.Length; i++)
                {
                    if (dic_instructor_list[i]["status"].ToString() == "True")
                    {
                        string sem = "";
                        if (dic_instructor_list[i]["sem_code"].ToString() == "S") sem = "Spring";
                        else if (dic_instructor_list[i]["sem_code"].ToString() == "M") sem = "Monsoon";
                        string year = dic_instructor_list[i]["year_code"].ToString();
                        Subject = AckDetails.Rows[0]["subject"].ToString();
                        Subject = Subject.Replace("@@sem", sem);
                        Subject = Subject.Replace("@@year", year);
                        Message = AckDetails.Rows[0]["body"].ToString();
                        Message = Message.Replace("@@title", dic_instructor_list[i]["title"].ToString());
                        Message = Message.Replace("@@instructor_name", dic_instructor_list[i]["instructor_name"].ToString());

                        if (dic_instructor_list[i]["hdn_tea_letter"].ToString() == "TEA")
                        {
                            Message = Message.Replace("@@user_type", "Teaching Associate");
                        }
                        else if (dic_instructor_list[i]["hdn_user_type"].ToString() == "VF")
                        {
                            Message = Message.Replace("@@user_type", "Visiting Faculty");
                        }
                        else if (dic_instructor_list[i]["userType"].ToString() == "TA")
                        {
                            Message = Message.Replace("@@user_type", "Teaching Assistant");
                        }
                        else if (dic_instructor_list[i]["userType"].ToString() == "AA")//Teaching Associate/
                        {
                            Message = Message.Replace("@@user_type", "Academic Associate");
                        }
                        Message = Message.Replace("@@dept_name", dic_instructor_list[i]["dept_name"].ToString());
                        Message = Message.Replace("@@sem", sem);
                        Message = Message.Replace("@@year", year);
                        Message = Message.Replace("@@faculty_admin_name", dic_instructor_list[i]["FA_name"].ToString());

                        if (dic_instructor_list[i]["prog_code"].ToString() == "3")
                        {
                            source_email = "head.doctoraloffice@cept.ac.in";
                            password = "glaonrbjvqygkbhi";
                        }
                        else
                        {
                            switch (dic_instructor_list[i]["dept_name"].ToString())
                            {
                                case "Architecture":
                                    source_email = "fa.admin@cept.ac.in";
                                    password = "myeultgbvzwviork";
                                    break;
                                case "Design":
                                    source_email = "fd.admin@cept.ac.in";
                                    password = "srpisdqoqudebkwl";
                                    break;
                                case "Management":
                                    source_email = "fm.admin@cept.ac.in";
                                    password = "ntfepqitxqnbntbc";
                                    break;
                                case "Planning":
                                    source_email = "fp.admin@cept.ac.in";
                                    password = "srbkefkbafczuasq";
                                    break;
                                case "Technology":
                                    source_email = "ft.admin@cept.ac.in";
                                    password = "rccgxcipwqxozklg";
                                    break;
                                case "Doctoral Programs":
                                    source_email = "head.doctoraloffice@cept.ac.in";
                                    password = "glaonrbjvqygkbhi";
                                    break;
                                case "CEPT Foundation Program":
                                    source_email = "cfpadmin@cept.ac.in";
                                    password = "eucoqyfkrcszzlxq";
                                    break;
                                default:
                                    source_email = "donotreply@cept.ac.in";
                                    password = "vyujpnmbkllqrujz";  //cept2014
                                    break;
                                    
                            }
                        }
                        if (dic_instructor_list[i]["destination_mail"].ToString() != "")
                        {
                            try
                            {
                                ToAddress = dic_instructor_list[i]["destination_mail"].ToString();
                                SmtpClient smtp = new SmtpClient
                                {
                                    Host = "smtp.gmail.com", // smtp server address here...
                                    Port = port,
                                    EnableSsl = true,
                                    DeliveryMethod = SmtpDeliveryMethod.Network,
                                    Credentials = new System.Net.NetworkCredential(source_email, password),
                                    Timeout = 50000,
                                };

                                MailMessage mail = new MailMessage();
                                mail.To.Add(ToAddress);
                                mail.Subject = Subject;
                                mail.From = new MailAddress(source_email, "CEPT");
                                mail.IsBodyHtml = true;
                                mail.Body = (Message);

                                Attachment attach = new Attachment(dic_instructor_list[i]["attachment_path"].ToString().Replace(" ", "_"));
                                attach.Name = dic_instructor_list[i]["attachment_name"].ToString();
                                mail.Attachments.Add(attach);
                                
                                Message_body_gen = Message;
                                Subject_gen = Subject;
                                filePath_gen = dic_instructor_list[i]["attachment_path"].ToString().Replace(" ", "_");
                                ToMail_gen = ToAddress;
                                FromMail_gen = source_email;
                                FromPassword_gen = password;
                                CCMail_gen = "";

                                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                                {
                                    smtp.Send(mail);
                                }

                                mail.Dispose();

                                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : " + dic_instructor_list[i]["status"] + "  :: ");
                                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Code : " + dic_instructor_list[i]["instructor_code"] + Environment.NewLine);
                            }
                            catch (Exception ex)
                            {
                                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Mail Delivery Fail Exception to => " + ex.Message + Environment.NewLine);
                                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Exception Message : " + ex.Message + " :: ");
                                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : " + dic_instructor_list[i]["status"] + " :: ");
                                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Code : " + dic_instructor_list[i]["instructor_code"] + " :: ");
                                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Message : " + dic_instructor_list[i]["message"] + Environment.NewLine);

                                not_send_mail_list = not_send_mail_list + " :: " + ToAddress;
                            }
                        }
                    }
                    else
                    {
                        System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : " + dic_instructor_list[i]["status"] + " :: ");
                        System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Code : " + dic_instructor_list[i]["instructor_code"] + " :: ");
                        System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Message : " + dic_instructor_list[i]["message"] + Environment.NewLine);

                        not_send_mail_list = not_send_mail_list + " :: " + dic_instructor_list[i]["instructor_code"];
                    }

                    source_email = "";
                    Body = "";
                }

                if (not_send_mail_list != "")
                {
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "---------------------------------------------------------------------------------------" + Environment.NewLine);
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Mail Delivery Fail to => " + not_send_mail_list + Environment.NewLine);
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "---------------------------------------------------------------------------------------" + Environment.NewLine);

                    return "Mail is not delivered to this IDs : " + not_send_mail_list;
                }

            }
            catch (Exception ex)
            {
                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Mail Delivery Fail Exception to => " + ex.Message + Environment.NewLine);
                return "A Problem occured during sending Mail. Mail is not delivered to anyone.";
            }

            return "Mail Delivered Successfully";
        }

        #endregion

        #region Send Mail to Faculty for Course Proposal Send_for_Review and Reject
        public String[] Send_WS_course_proposal_sendforreview_reject(Dictionary<string, object> dic_instructor_list)
        {
            Masters objmaster = new Masters();
            DataTable dt = objmaster.Get_VF_TA_AA_Letter_Email_Body("SWSRejectedCourse", "email");
            string mail_body = "";
            //if (dic_instructor_list.Count > 8)
            //{
                mail_body = dt.Rows[0]["body"].ToString();
                mail_body = mail_body.Replace("@@course_code", dic_instructor_list["course_code"].ToString());
                mail_body = mail_body.Replace("@@course_name", dic_instructor_list["course_name"].ToString());
            //}
            
            string source_email = "donotreply@cept.ac.in";
            string password = "vyujpnmbkllqrujz";  //cept2014
            string ToAddress = "";
            string sender_name = "";
            string dept_code = "";

            String Body = mail_body + " " + dic_instructor_list["mail_body"].ToString() + "<br /><br />";

            String Subject = dic_instructor_list["mail_subject"].ToString();

            string directory_path = "C:/Ceptreg_Log/Send_Appointment_Letter/Log/";
            string filename = "Visiting_Faculty_Mail_Log";
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Date : " + DateTime.Now + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);

            try
            {
                if (dic_instructor_list["destination_mail"].ToString() != "")
                {
                    ToAddress = dic_instructor_list["destination_mail"].ToString();
                    sender_name = dic_instructor_list["user_name"].ToString();


                    if (sender_name == "") sender_name = "CEPT";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(source_email, password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    mail.To.Add(ToAddress);

                    if (dic_instructor_list["inhabitation"].ToString().Trim() == "1")
                    {
                        //mail.CC.Add(new MailAddress("anjali.yagnik@cept.ac.in"));
                        mail.CC.Add(new MailAddress("sameep.padora@cept.ac.in"));
                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "2")
                    {
                        mail.CC.Add(new MailAddress("saleem.bhatri@cept.ac.in"));

                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "3")
                    {
                        mail.CC.Add(new MailAddress("pranavant@cept.ac.in"));
                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "4")
                    {
                        mail.CC.Add(new MailAddress("shalini.sinha@cept.ac.in"));
                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "5")
                    {
                        mail.CC.Add(new MailAddress("aanal.shah@cept.ac.in"));
                    }

                    mail.Subject = Subject;
                    mail.From = new MailAddress(source_email, sender_name);
                    mail.IsBodyHtml = true;
                    mail.Body = (Body);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                    mail.Dispose();
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : True :: ");
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Mail : " + dic_instructor_list["destination_mail"] + "  :: ");
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "WS Course Code : " + dic_instructor_list["course_code"] + Environment.NewLine);
                }
                else
                {
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : False :: ");
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Message : Destination Mail not Found." + Environment.NewLine);

                    return new String[] { "False", "Destination Mail not Found." };
                }
            }
            catch (Exception ex)
            {
                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : False :: ");
                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Message : " + ex.ToString() + Environment.NewLine);

                return new String[] { "False", "A Problem occured during sending Mail. Mail Delivery Failed." };
            }

            return new String[] { "True", "Mail Delivered Successfully" };
        }

        public String[] Send_WS_course_proposal_sendforreview(Dictionary<string, object> dic_instructor_list)
        {
            Masters objmaster = new Masters();
            DataTable dt = objmaster.Get_VF_TA_AA_Letter_Email_Body("SendForReview", "email");
            string mail_body = "";
            
                mail_body = dt.Rows[0]["body"].ToString();
                mail_body = mail_body.Replace("@@course_code", dic_instructor_list["course_code"].ToString());
                mail_body = mail_body.Replace("@@course_name", dic_instructor_list["course_name"].ToString());
            

            string source_email = "donotreply@cept.ac.in";
            string password = "vyujpnmbkllqrujz";  //cept2014
            string ToAddress = "";
            string sender_name = "";
            string dept_code = "";

            String Body = mail_body + " " + dic_instructor_list["mail_body"].ToString() + "<br /><br />";

            String Subject = dic_instructor_list["mail_subject"].ToString();

            string directory_path = "C:/Ceptreg_Log/Send_Appointment_Letter/Log/";
            string filename = "Visiting_Faculty_Mail_Log";
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Date : " + DateTime.Now + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);

            try
            {
                if (dic_instructor_list["destination_mail"].ToString() != "")
                {
                    ToAddress = dic_instructor_list["destination_mail"].ToString();
                    sender_name = dic_instructor_list["user_name"].ToString();


                    if (sender_name == "") sender_name = "CEPT";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(source_email, password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    mail.To.Add(ToAddress);

                    if (dic_instructor_list["inhabitation"].ToString().Trim() == "1")
                    {
                        mail.CC.Add(new MailAddress("sameep.padora@cept.ac.in"));
                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "2")
                    {
                        mail.CC.Add(new MailAddress("saleem.bhatri@cept.ac.in"));

                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "3")
                    {
                        mail.CC.Add(new MailAddress("pranavant@cept.ac.in"));
                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "4")
                    {
                        mail.CC.Add(new MailAddress("shalini.sinha@cept.ac.in"));
                    }
                    else if (dic_instructor_list["inhabitation"].ToString().Trim() == "5")
                    {
                        mail.CC.Add(new MailAddress("aanal.shah@cept.ac.in"));
                    }

                    mail.Subject = Subject;
                    mail.From = new MailAddress(source_email, sender_name);
                    mail.IsBodyHtml = true;
                    mail.Body = (Body);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }

                    mail.Dispose();

                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : True :: ");
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Mail : " + dic_instructor_list["destination_mail"] + "  :: ");
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "WS Course Code : " + dic_instructor_list["course_code"] + Environment.NewLine);

                }
                else
                {
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : False :: ");
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Message : Destination Mail not Found." + Environment.NewLine);

                    return new String[] { "False", "Destination Mail not Found." };
                }
            }
            catch (Exception ex)
            {
                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Status : False :: ");
                System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Message : " + ex.ToString() + Environment.NewLine);

                return new String[] { "False", "A Problem occured during sending Mail. Mail Delivery Failed." };
            }

            return new String[] { "True", "Mail Delivered Successfully" };
        }

        #endregion

        #region Send Mail to BTG Team on Fees payment successfull

        public String SendEmailToBTG(DataTable dt_btg_payment)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["BTG_email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["BTG_password"].ToString();

            try
            {
                try
                {
                    ToAddress = dt_btg_payment.Rows[0]["email_id"].ToString();

                    Message = "Team Leader,";
                    Message += "<br /><br />We are in receipt of registration fee of 450 and we confirm that your team has been successfully registered for the event “BRIDGE THE GAP 4.0” to be held on 31st March, 2018.</b></p>";
                    Message += "<br /><br />Your Team number is :  " + dt_btg_payment.Rows[0]["team_id"].ToString() + "";
                    Message += "<br /><br />Your team members are: <br />";

                    for (int i = 0; i < dt_btg_payment.Rows.Count; i++)
                    {
                        Message += dt_btg_payment.Rows[i]["sr_no"].ToString() + ") " + dt_btg_payment.Rows[i]["name"].ToString() + "<br />";
                    }

                    //Message += "<br />Please keep yourself updated on important dates and clarifications on our Facebook page and the website: www.facebook.com/bridgethegap4.0";
                    Message += "<br />Please keep yourself updated on important dates and clarifications on our <a href='https://www.facebook.com/Bridgethegap4.0' style='color:rgb(17,85,204)' target='_blank'>Facebook page</a> and the <a href='http://cept.ac.in/btg/?template=btg' style='color:rgb(17,85,204)' target='_blank'>Website</a>.";

                    Message += "<br /><p>Thank You,<br />BTG Team.</p>";
                    Message += "<p>For any help, please contact:,<br />Nipun Patel +91-9825076121<br />Harnish Patel +91-9586688300<br />(calls will only be entertained between 6:30 pm to 10:30 pm)<br /><br />Or e-mail us at bridgethegap@cept.ac.in </p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    mail.To.Add(ToAddress);
                    mail.Subject = "BTG Confirmation";
                    mail.From = new MailAddress(sending_email, "CEPT");
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

        #region Send Mail to Visiting Faculty for Payment Success
        public String Send_Payment_Success_Mail_to_visiting_faculty(List<Dictionary<string, object>> dic_instructor_list)
        {
            //string source_email = "donotreply.ug.fm@cept.ac.in";
            string source_email = "";
            string password = "F!n@nce@123";
            string ToAddress = "";

            String Body = "";

            string directory_path = "C:/Ceptreg_Log/Send_Appointment_Letter/Log/";
            string filename = "Visiting_Faculty_Mail_Log";
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Date : " + DateTime.Now + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);

            try
            {
                for (int i = 0; i < dic_instructor_list.Count; i++)
                {
                    string sem = "";
                    string faculty_accountant = "";
                    string dept_name = "";
                    string cur_installment = "";
                    if (dic_instructor_list[i]["sem_code"].ToString() == "S") sem = "Spring";
                    else if (dic_instructor_list[i]["sem_code"].ToString() == "M") sem = "Monsoon";

                    string year = dic_instructor_list[i]["year_code"].ToString();

                    switch (dic_instructor_list[i]["dept_code"].ToString())
                    {
                        case "1":
                            source_email = "fafinance@cept.ac.in";
                            faculty_accountant = "Devang Bhavsar";
                            dept_name = "Architecture";
                            break;
                        case "2":
                            source_email = "fdfinance@cept.ac.in";
                            faculty_accountant = "Uma Raval";
                            dept_name = "Design";
                            break;
                        case "3":
                            source_email = "fmfinance@cept.ac.in";
                            faculty_accountant = "Uma Raval";
                            dept_name = "Management";
                            break;
                        case "4":
                            source_email = "fpfinance@cept.ac.in";
                            faculty_accountant = "Hansa Gohel";
                            dept_name = "Planning";
                            break;
                        case "5":
                            source_email = "ftfinance@cept.ac.in";
                            faculty_accountant = "Amit Shah";
                            dept_name = "Technology";
                            break;
                            //default:
                            //return "Source Email not found.";
                    }

                    switch (dic_instructor_list[i]["cur_installment"].ToString())
                    {
                        case "1":
                            cur_installment = "First";
                            break;
                        case "2":
                            cur_installment = "Second";
                            break;
                        case "3":
                            cur_installment = "Third";
                            break;
                        case "4":
                            cur_installment = "Fourth";
                            break;
                    }

                    Body = "<p>Dear " + dic_instructor_list[i]["title"].ToString() + " " + dic_instructor_list[i]["instructor_name"].ToString() + "</p>" +
                                "<p>We would like to inform you that your " + cur_installment + " part payment (out of total " + dic_instructor_list[i]["total_installments"] + " part), of Rs. " + dic_instructor_list[i]["payable_amount"].ToString() + " (after deduction of TDS as applicable) as " +
                                "visiting faculty remuneration for " + sem + " " + year + " Semester in Faculty of " + dept_name + " is sent to your bankaccount " + dic_instructor_list[i]["bank_account_no"].ToString() + " on " + dic_instructor_list[i]["payment_ref_date"].ToString() + " and you " +
                                "will receive credit of the same in couple of days.</p>" +
                                "<p> </p>" +
                                "<p>You are requested to write back, if you do not receive the credit in your account.</p>" +
                                "<p> </p>" +
                                "<p>From<br/>" +
                                "" + faculty_accountant + "<br/>" +
                                "Accountant<br/>" +
                                "Faculty of " + dept_name + "</p>";

                    String Subject = "CEPT VFM Payment Intimation " + sem + " " + year + " – " + cur_installment + " Part Payment";

                    if (dic_instructor_list[i]["destination_mail"].ToString() != "")
                    {
                        try
                        {
                            ToAddress = dic_instructor_list[i]["destination_mail"].ToString();

                            SmtpClient smtp = new SmtpClient
                            {
                                Host = "smtp.gmail.com", // smtp server address here...
                                Port = port,
                                EnableSsl = true,
                                DeliveryMethod = SmtpDeliveryMethod.Network,
                                Credentials = new System.Net.NetworkCredential(source_email, password),
                                Timeout = 50000,
                            };

                            MailMessage mail = new MailMessage();
                            mail.To.Add(ToAddress);
                            mail.Subject = Subject;
                            mail.From = new MailAddress(source_email, "CEPT");
                            mail.IsBodyHtml = true;
                            mail.Body = (Body);
                            if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                            {
                                smtp.Send(mail);
                            }

                            mail.Dispose();

                            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Code : " + dic_instructor_list[i]["instructor_code"] + Environment.NewLine);
                        }
                        catch (Exception ex)
                        {
                            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Code : " + dic_instructor_list[i]["instructor_code"] + " :: ");

                            if (not_send_mail_list != "") not_send_mail_list += " , ";
                            not_send_mail_list += ToAddress;
                        }
                    }

                    source_email = "";
                    Body = "";
                }

                if (not_send_mail_list != "")
                {
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "---------------------------------------------------------------------------------------" + Environment.NewLine);
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Mail Delivery Fail to => " + not_send_mail_list + Environment.NewLine);
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "---------------------------------------------------------------------------------------" + Environment.NewLine);

                    return " But Mail is not delivered to this IDs : " + not_send_mail_list;
                }

            }
            catch (Exception ex)
            {
                return " But A Problem occured during sending Mail. Mail is not delivered to anyone.";
            }

            return " And Mail Delivered Successfully";
        }
        #endregion

        #region Alumni
        public String[] Send_Alumni_Invite_friend_Mail(Dictionary<string, string> dic_req_data)
        {
            string source_email = "donotreply@cept.ac.in";
            string password = "vyujpnmbkllqrujz";  //cept2014
            string ToAddress = "";
            string sender_name = "";

            String Body = "Hi,<br /><br />I would like to invite you to join the CEPT Alumni network. Kindly go to https://connect.cept.ac.in/Alumni/Alumni_registration.aspx and join the network.<br /><br />";

            String Subject = "Invitation";

            try
            {
                if (dic_req_data["invite_friend"].ToString() != "")
                {
                    ToAddress = dic_req_data["invite_friend"].ToString();

                    if (ToAddress != "")
                    {
                        if (ToAddress[ToAddress.Length - 1] == '~') ToAddress = ToAddress.Remove(ToAddress.Length - 1, 1);
                        ToAddress = ToAddress.Replace('~', ',');
                    }

                    sender_name = dic_req_data["sender_email"].ToString();

                    if (sender_name == "") sender_name = "CEPT";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(source_email, password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();
                    mail.To.Add(ToAddress);
                    mail.Subject = Subject;
                    mail.From = new MailAddress(source_email, sender_name);
                    mail.IsBodyHtml = true;
                    mail.Body = (Body);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }

                    mail.Dispose();
                }
                else
                {
                    return new String[] { "False", "Destination Mail not Found." };
                }
            }
            catch (Exception ex)
            {
                return new String[] { "False", "A Problem occured during sending Mail. Mail Delivery Failed." };
            }

            return new String[] { "True", "Mail Delivered Successfully" };
        }

        public bool Send_Alumni_Verification_Mail_to_admin(Dictionary<string, object> dic_req_data)
        {
            string source_email = "alumniregistry@cept.ac.in";
            string password = "C#PT@2017";
            string ToAddress = "";

            //string source_email = "donotreply@cept.ac.in";
            //string password = "cept2014";
            // string sender_name = "";

            StringBuilder Body = new StringBuilder();

            Masters objmaster = new Masters();
            DataTable dt = objmaster.Get_alumini_prog_data();
            DataTable dt_year = objmaster.Get_alumini_year_data();

            Body.Append("Dear Sir,<br /><br/>Mr./Ms. " + dic_req_data["name"].ToString() + " has submitted a request for registration on the CEPT Alumni Registry:<br /><br />");

            Body.Append("<table>");

            if (dt_year != null)
            {
                DataRow[] dr = dt_year.Select("year_code = '" + dic_req_data["year_code"].ToString() + "'");

                if (dr.Length > 0)
                {
                    Body.Append("<tr><td>1. </td><td><b>Year of Enrollment :</b></td><td><span>" + dr[0]["year_desc"].ToString() + "</span></td></tr>");
                }
            }
            else
            {
                Body.Append("<tr><td>1. </td><td><b>Year of Enrollment :</b></td><td><span>" + dic_req_data["year_code"].ToString() + "</span></td></tr>");
            }

            if (dic_req_data["prog_level_code"].ToString() != "O")
            {
                if (dt != null)
                {

                    string dept_code = "";
                    string prog_code = "";
                    string prog_level_code = "";
                    // string send_mail = "";

                    DataRow[] dr = dt.Select("prog_level_code = '" + dic_req_data["prog_level_code"].ToString() + "'");

                    if (dr.Length > 0)
                    {
                        Body.Append("<tr><td>2. </td> <td><b>Program Name  :</b></td><td><span>" + dr[0]["prog_level_name"].ToString() + "</span></td></tr>");

                        dept_code = dr[0]["dept_code"].ToString();
                        prog_code = dr[0]["prog_code"].ToString();

                        prog_level_code = dic_req_data["prog_level_code"].ToString();

                        switch (dept_code)
                        {
                            case "1":
                                if (prog_level_code == "UA")
                                {
                                    ToAddress = "seema@cept.ac.in";
                                }
                                else if (prog_level_code == "PG4" || prog_level_code == "PG6")
                                {
                                    ToAddress = "minal.marathe@cept.ac.in";
                                }
                                else if (prog_level_code == "PG1" || prog_level_code == "PG2" || prog_level_code == "PG13")
                                {
                                    ToAddress = "shivani.joshi@cept.ac.in";
                                }
                                else
                                {
                                    ToAddress = "cas@cept.ac.in";
                                }
                                break;
                            case "2":
                                if (prog_level_code == "UD1")
                                {
                                    ToAddress = "kdaprsid@cept.ac.in";
                                }
                                else if (prog_level_code == "PG20")
                                {
                                    ToAddress = "kdaprsid@cept.ac.in";
                                }
                                else
                                {
                                    ToAddress = "cas@cept.ac.in";
                                }
                                break;
                            case "3":
                                if (prog_level_code == "PG18" || prog_level_code == "PG19" || prog_level_code == "O29")
                                {
                                    ToAddress = "jyoti.tomar@cept.ac.in";
                                }
                                else
                                {
                                    ToAddress = "cas@cept.ac.in";
                                }
                                break;
                            case "4":
                                if (prog_level_code == "PG3")
                                {
                                    ToAddress = "jinu@cept.ac.in";
                                }
                                else if (prog_level_code == "UP1")
                                {
                                    ToAddress = "divya.bhatt@cept.ac.in";
                                }
                                else if (prog_level_code == "PG5"
                                 || prog_level_code == "PG7"
                                 || prog_level_code == "PG8"
                                 || prog_level_code == "PG9"
                                 || prog_level_code == "PG10"
                                 || prog_level_code == "PG17")
                                {
                                    ToAddress = "sp@cept.ac.in";
                                }
                                else
                                {
                                    ToAddress = "cas@cept.ac.in";
                                }
                                break;
                            case "5":
                                if (prog_level_code == "UT1")
                                {
                                    ToAddress = "pooja.patel@cept.ac.in";
                                }
                                else if (prog_level_code == "PG11" || prog_level_code == "PG12" || prog_level_code == "PG15")
                                {
                                    ToAddress = "pooja.patel@cept.ac.in";
                                }
                                else
                                {
                                    ToAddress = "cas@cept.ac.in";
                                }
                                break;
                            case "":
                                ToAddress = "cas@cept.ac.in";
                                break;

                            default:
                                break;
                        }
                    }
                }
            }
            else
            {
                ToAddress = "cas@cept.ac.in";
                Body.Append("<tr><td>2. </td><td><b>Program Name  :</b></td><td><span>" + dic_req_data["other_prog"].ToString() + "</span></td></tr>");
            }
            Body.Append("<tr><td>3. </td> <td><b>Student Name :</b></td><td><span>" + dic_req_data["name"].ToString() + "</span></td></tr>");
            Body.Append("<tr><td>4. </td> <td><b>Student Code :</b></td><td><span>" + dic_req_data["user_id"].ToString() + "</span></td></tr>");
            Body.Append("<tr><td>5. </td> <td><b>Email :</b></td><td><span>" + dic_req_data["email"].ToString() + "</span></td></tr>");
            Body.Append("<tr><td>6. </td> <td><b>Date of birth :</b></td><td><span>" + dic_req_data["dob"].ToString() + "</span></td></tr>");
            Body.Append("</table>");
            Body.Append("<br/>Please log into <a href='connect.cept.ac.in'>connect.cept.ac.in</a> to verify the above details and furnish the required data at your earliest.");
            Body.Append("<br/><br/><br/>With warm regards,<br/><br/>");
            Body.Append("Ashok Shah<br/>Director, Career and Alumni Services<br/>CEPT University<br/>Email: ashok.shah@cept.ac.in<br/>Phone: 079-26302470 Extn.320, 9909960240");
            // Body.Append("<br/>" + dic_req_data["name"].ToString());

            String Subject = "Verification of Alumnus";

            try
            {
                SmtpClient smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com", // smtp server address here...
                    Port = port,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Credentials = new System.Net.NetworkCredential(source_email, password),
                    Timeout = 50000,
                };

                MailMessage mail = new MailMessage();

                mail.To.Add(ToAddress);
                mail.Subject = Subject;
                mail.From = new MailAddress(source_email, "CEPT");

                mail.IsBodyHtml = true;
                mail.Body = (Body.ToString());
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }

                mail.Dispose();

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;

        }

        public bool Send_verify_mail_to_alumni(string email_link, string student_email)
        {
            string source_email = "alumniregistry@cept.ac.in";
            string password = "C#PT@2017";

            //string source_email = "donotreply@cept.ac.in";
            //string password = "cept2014";

            StringBuilder Body = new StringBuilder();

            Masters objmaster = new Masters();
            DataTable dt = objmaster.Get_alumini_prog_data();
            DataTable dt_year = objmaster.Get_alumini_year_data();

            Body.Append("Dear Alumnus,<br/><br/>Welcome to CEPT Alumni Registry!<br/><br/>Your credentials have been successfully verified. Please click on the link below to access your profile on the Alumni Registry:<br/><br/>" + email_link);

            Body.Append("<br/><br/>We thank you for reconnecting with your alma mater and hope to remain in touch.<br/><br/>With warm regards,<br/><br/>");
            Body.Append("Ashok Shah<br/>Director, Career and Alumni Services<br/>CEPT University<br/>Email: ashok.shah@cept.ac.in<br/>Phone: 079-26302470 Extn.320, 9909960240");

            String Subject = "Welcome to CEPT Alumni Registry!";
            try
            {

                SmtpClient smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com", // smtp server address here...
                    Port = port,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Credentials = new System.Net.NetworkCredential(source_email, password),
                    Timeout = 50000,
                };

                MailMessage mail = new MailMessage();
                mail.To.Add(student_email);
                mail.Subject = Subject;
                mail.From = new MailAddress(source_email, "CEPT");
                mail.IsBodyHtml = true;
                mail.Body = (Body.ToString());
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }

                mail.Dispose();

                return true;
            }
            catch (Exception ex)
            {
                return false;
            }

            return true;

        }
        #endregion

        #region Send Fees Installment Reminder Mail

        public String fees_installment_reminder_mail(DataTable student_email, string sem_code, string year_code, string installment, string str_due_date, string subject)
        {
            try
            {
                //message_body = remark;
                mail_subject = subject;
                installment_no = Int32.Parse(installment);
                due_date = str_due_date;

                studentemail = student_email;

                Thread th1 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th2 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th3 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th4 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th5 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th6 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th7 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th8 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));
                Thread th9 = new Thread(new ThreadStart(Send_fees_installment_reminder_mail));

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

                th1.Start();
                th2.Start();
                th3.Start();
                th4.Start();
                th5.Start();
                th6.Start();
                th7.Start();
                th8.Start();
                th9.Start();

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

                        counter = 0;
                        break;
                    }
                }
            }
            catch (Exception ex)
            {
                ServerLog.ExceptionLog(ex.ToString());
                return ex.ToString();
            }

            return "Mail Sent Successfully";
        }

        public void Send_fees_installment_reminder_mail()
        {
            string ToAddress = "", prog_code = "", dept_code = "";

            String Message = message_body;
            String Subject = mail_subject;

            var thread_id = Thread.CurrentThread.ManagedThreadId.ToString();

            string directory_path = "C:/Ceptreg_Log/CEPT_mail_log/";

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
                    Message = "";

                    if (counter < studentemail.Rows.Count)
                    {
                        //Thread.Sleep(1000 * 5);

                        //DataRow dr = studentemail.Rows[counter++];
                        DataRow dr = dr_student_data[i];

                        //counter++;

                        if (dr["mail"].ToString() != "")
                        {
                            try
                            {
                                ToAddress = dr["mail"].ToString();

                                dept_code = dr["dept_code"].ToString();
                                prog_code = dr["prog_code"].ToString();

                                //from_mail = "donotreply@cept.ac.in";
                                //from_password = "cept2014";

                                switch (dept_code)
                                {
                                    case "1":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fa@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fa@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "2":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fd@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fd@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "3":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fm@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fm@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "4":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.fp@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.fp@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    case "5":
                                        if (prog_code == "1")
                                        {
                                            from_mail = "donotreply.ug.ft@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "2")
                                        {
                                            from_mail = "donotreply.pg.ft@cept.ac.in";
                                            from_password = "CEPT@2015";
                                        }
                                        else if (prog_code == "3")
                                        {

                                        }
                                        break;
                                    default:
                                        break;
                                }

                                string sem = "";
                                if (dr["semester_type"].ToString() == "M") sem = "Monsoon";
                                else if (dr["semester_type"].ToString() == "S") sem = "Spring";

                                Message = "<p>Dear " + dr["user_name"].ToString() + ",</p>";

                                Message += "<p>You had opted to pay your " + sem + " " + dr["year_semester"].ToString() + " fees in two installments, and accordingly your payment details till date is as below:";

                                if (installment_no > 1)
                                {
                                    if (dr["online1"].ToString() != "")
                                        Message += "<br />Installment 1 – " + dr["online1"].ToString() + " – " + dr["installment1"].ToString();
                                    else if (dr["offline1"].ToString() != "")
                                        Message += "<br />Installment 1 – " + dr["offline1"].ToString() + " – " + dr["installment1"].ToString();
                                }

                                if (installment_no > 2)
                                {
                                    if (dr["online2"].ToString() != "")
                                        Message += "<br />Installment 2 – " + dr["online2"].ToString() + " – " + dr["installment2"].ToString();
                                    else if (dr["offline2"].ToString() != "")
                                        Message += "<br />Installment 2 – " + dr["offline2"].ToString() + " – " + dr["installment2"].ToString();
                                }

                                Message += "</p>";

                                string str_installment = "";
                                if (installment_no == 1) str_installment = "first";
                                if (installment_no == 2) str_installment = "second";
                                if (installment_no == 3) str_installment = "third";

                                Message += "<p>This is to remind you that the " + str_installment + " installment is to be paid before " + due_date + "; you are requested to make your payment before the last date.</p>";

                                Message += "<p>In case payment is made and it is not reflecting on your Dashboard, kindly connect to your concern faculty admin with the transaction details.</p>";

                                Message += "<p>Ignore this email, if you have already paid your " + str_installment + " installment.</p>";

                                Message += "<p>Regards<br />Finance Team<br />CEPT University</p>";

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
                                    smtp.Send(mail);//Mayur 13092019
                                }

                                //ServerLog.ExceptionLog(ToAddress.ToString());
                                System.IO.File.AppendAllText(@"" + directory_path + thread_id + ".txt", "ToAddress :: " + ToAddress.ToString() + " :: Counter :: " + (counter + 1) + " :: i-Counter :: " + (i + 1) + Environment.NewLine);

                            }
                            catch (Exception ex)
                            {
                                //ServerLog.ExceptionLog("In loop - " + ex.ToString());
                                System.IO.File.AppendAllText(@"" + directory_path + thread_id + "_Exception.txt", "Mail send error :: " + ToAddress.ToString() + " :: Counter :: " + (counter + 1) + Environment.NewLine);
                                System.IO.File.AppendAllText(@"" + directory_path + thread_id + "_Exception.txt", "Exception :: " + ex.ToString() + Environment.NewLine);
                            }
                        }
                        //}

                        counter++;
                    }
                    else
                    {
                        //ServerLog.ExceptionLog(" - " + counter);
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

        #endregion

        #region Send Mail to Student on Hostel Fees payment successfull

        public String SendEmailOnHostelfeesPaymentSuccess(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    if (!data.ContainsKey("pg_type")) data["pg_type"] = "Citrus";

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your hostel fees payment with Cept using " + data["pg_type"] + " was <b>successful!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />" + data["pg_type"] + " Reference Number :  " + data["pg_transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Payment Received :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    //Message += "<br /><br /><br />For payment related queries please contact admissions.finance@cept.ac.in";
                    Message += "<br /><br /><br />For payment related queries please contact For Boys Hostel Mr. Ramesh Raval,at cepthostel@cept.ac.in.";
                    Message += "<br /><br /><br />For Girls Hostel Ms. Hansa Gohel,at hansa.gohel@cept.ac.in.";
                    Message += "<br /><p>Sincerely,<br />Rector<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();

                    mail.To.Add(ToAddress);
                    mail.Subject = "CEPT hostel Fees: Payment Confirmation";
                    mail.From = new MailAddress(sending_email, "CEPT");
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

        public String SendEmailOnHostelfeesPaymentFail(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your online hostel fees payment with CEPT has failed!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Transaction Amount :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    Message += "<br /><br /><br />In case the amount has been deducted from your account, contact your bank with details of the transaction. You are also requested to email the proof of transaction/debit in your account to cepthostel@cept.ac.in for further action.";
                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();

                    mail.To.Add(ToAddress);
                    mail.Subject = "CEPT Boys hostel Fees: Payment Fail";
                    mail.From = new MailAddress(sending_email, "CEPT");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    return ex.ToString();
                }
            }
            catch (Exception ex)
            {
                return "Some problem in mail sent. Mail is not sent";
            }
            return "success";
        }

        #endregion

        #region Send Mail to Student and Concern Faculty of Thesis and DRP

        public bool SendThesisDrpMail(Dictionary<string, object> thesis_drp_data, DataTable AckDetails, DataTable MailDetails, DataTable MailDetailsInst)
        {
            try
            {
                string ToAddress = "", prog_code = "", dept_code = "", from_mail = "", from_password = "", CcAddress = "";

                String Message = "";
                String Subject = "";

                from_password = "CEPT2016";

                prog_code = MailDetails.Rows[0]["prog_code"].ToString();
                dept_code = MailDetails.Rows[0]["dept_code"].ToString();

                ToAddress = MailDetails.Rows[0]["mail"].ToString();

                CcAddress = MailDetailsInst.Rows[0]["mail"].ToString();

                Subject = AckDetails.Rows[0]["subject"].ToString();

                Subject = Subject.Replace("@@student_code", MailDetails.Rows[0]["user_id"].ToString());
                Subject = Subject.Replace("@@student_name", MailDetails.Rows[0]["user_name"].ToString());
                Subject = Subject.Replace("@@program_name", MailDetails.Rows[0]["prog_name"].ToString());
                Subject = Subject.Replace("@@program_level", MailDetails.Rows[0]["prog_level_desc"].ToString());

                Subject = Subject.Replace("@@instructor_name", MailDetailsInst.Rows[0]["instructor_name"].ToString());

                Subject = Subject.Replace("@@thesis_title", thesis_drp_data["topic"].ToString());
                Subject = Subject.Replace("@@abstract", thesis_drp_data["abstract"].ToString());
                Subject = Subject.Replace("@@references", thesis_drp_data["references"].ToString());

                Message = AckDetails.Rows[0]["body"].ToString();

                Message = Message.Replace("@@student_code", MailDetails.Rows[0]["user_id"].ToString());
                Message = Message.Replace("@@student_name", MailDetails.Rows[0]["user_name"].ToString());
                Message = Message.Replace("@@program_name", MailDetails.Rows[0]["prog_name"].ToString());
                Message = Message.Replace("@@program_level", MailDetails.Rows[0]["prog_level_desc"].ToString());
                Message = Message.Replace("@@instructor_name", MailDetailsInst.Rows[0]["instructor_name"].ToString());
                Message = Message.Replace("@@thesis_title", thesis_drp_data["topic"].ToString());
                Message = Message.Replace("@@abstract", thesis_drp_data["abstract"].ToString());
                Message = Message.Replace("@@references", thesis_drp_data["references"].ToString());

                switch (dept_code)
                {
                    case "1":
                        from_mail = "fa.admin@cept.ac.in";
                        from_password = "myeultgbvzwviork";
                        break;
                    case "2":
                        from_mail = "fd.admin@cept.ac.in";
                        from_password = "rlccvavgbhbwcwqd";
                        break;
                    case "3":
                        from_mail = "fm.admin@cept.ac.in";
                        from_password = "ntfepqitxqnbntbc";
                        break;
                    case "4":
                        from_mail = "fp.admin@cept.ac.in";
                        from_password = "srbkefkbafczuasq";
                        break;
                    case "5":
                        from_mail = "ft.admin@cept.ac.in";
                        from_password = "rccgxcipwqxozklg";
                        break;
                    default:
                        break;
                }

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
                mail.To.Add(CcAddress);
                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);

                //Attachment attach = new Attachment(AckDetails.Rows[0]["att_path"].ToString());
                //attach.Name = AckDetails.Rows[0]["attachment_name"].ToString();
                //mail.Attachments.Add(attach);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);//28112019
                }

                mail.Dispose();//28112019
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }
        #endregion
        #region Send Mail to Student and Concern Faculty of Thesis and DRP
        public bool SendCourseRegistration(DataTable AckDetails, DataSet ds_course_reg_dtl)
        {
            try
            {
                string ToAddress = "", from_mail = "", from_password = "", guides = "", dept_code = "", semester = "", year = "", mandatory_course = "", elective_course = "", fees_type = "", installment_status = ""; // fees_amount = "", no_of_installment = "";

                String Message = "";
                String Subject = "";

                int credits = 0; //installment_no = 0;
                //decimal installment1 = 0, installment2 = 0, installment3 = 0;

                from_password = "CEPT2016";

                ToAddress = ds_course_reg_dtl.Tables[0].Rows[0]["mail"].ToString();
                dept_code = ds_course_reg_dtl.Tables[0].Rows[0]["dept_code"].ToString();
                semester = ds_course_reg_dtl.Tables[0].Rows[0]["semester_type"].ToString();
                year = ds_course_reg_dtl.Tables[0].Rows[0]["year_semester"].ToString();
                fees_type = ds_course_reg_dtl.Tables[0].Rows[0]["fees_type"].ToString();

                //fees_amount = ds_course_reg_dtl.Tables[0].Rows[0]["fees_amount"].ToString();
                installment_status = ds_course_reg_dtl.Tables[0].Rows[0]["installment_status"].ToString();
                guides = ds_course_reg_dtl.Tables[0].Rows[0]["dissertation_supervisor"].ToString();

                //no_of_installment = ds_course_reg_dtl.Tables[0].Rows[0]["no_of_installment"].ToString();

                //installment1 = Convert.ToDecimal(ds_course_reg_dtl.Tables[0].Rows[0]["installment1"]) + Convert.ToDecimal(ds_course_reg_dtl.Tables[0].Rows[0]["installment1_fine"]);
                //installment2 = Convert.ToDecimal(ds_course_reg_dtl.Tables[0].Rows[0]["installment2"]) + Convert.ToDecimal(ds_course_reg_dtl.Tables[0].Rows[0]["installment1_fine"]);
                //installment3 = Convert.ToDecimal(ds_course_reg_dtl.Tables[0].Rows[0]["installment3"]) + Convert.ToDecimal(ds_course_reg_dtl.Tables[0].Rows[0]["installment1_fine"]);

                if (semester == "S") { semester = "Spring"; } else if (semester == "M") { semester = "Monsoon"; }

                if (fees_type == "H") { fees_type = "Half"; } else if (fees_type == "F") { fees_type = "Full"; }

                //if (ds_course_reg_dtl.Tables[0].Rows[0]["is_installment1_paid"].ToString() == "Y") { fees_amount = installment1.ToString(); installment_no = 1; }

                if (installment_status == "Y") { installment_status = "Yes"; } else if (installment_status == "N") { installment_status = "No"; }

                if (guides == "") { guides = "No Guide."; }

                mandatory_course = "<table style='text-align:center;' border='1'><caption><strong>Mandatory Courses</strong></caption><thead><th>Course Code</th><th>Course Name</th><th>Credits</th><th>GPA/NGPA</th><th>Semester</th></thead><tbody>";
                elective_course = "<table style='text-align:center;' border='1'><caption><strong>Elective Courses</strong></caption><thead><th>Priority</th><th>Course Code</th><th>Course Name</th><th>Credits</th><th>GPA/NGPA</th><th>Faculty</th><th>Semester</th></thead><tbody>";

                for (int h = 0; h < ds_course_reg_dtl.Tables[1].Rows.Count; h++)
                {
                    if (ds_course_reg_dtl.Tables[1].Rows[h]["course_type"].ToString() == "M")
                    {
                        mandatory_course += "<tr>";
                        mandatory_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["course_code"].ToString() + "</td>";
                        mandatory_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["course_name"].ToString() + "</td>";
                        mandatory_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["course_credits"].ToString() + "</td>";
                        mandatory_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["gpa_ngpa"].ToString() + "</td>";
                        mandatory_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["semester_code"].ToString() + "</td>";
                        mandatory_course += "</tr>";
                        credits = credits + Convert.ToInt32(ds_course_reg_dtl.Tables[1].Rows[h]["course_credits"].ToString());
                    }
                }
                mandatory_course += "</tbody></table>";

                for (int h = 0; h < ds_course_reg_dtl.Tables[1].Rows.Count; h++)
                {
                    if (ds_course_reg_dtl.Tables[1].Rows[h]["course_type"].ToString() == "E")
                    {
                        elective_course += "<tr>";
                        elective_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["priority"].ToString() + "</td>";
                        elective_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["course_code"].ToString() + "</td>";
                        elective_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["course_name"].ToString() + "</td>";
                        elective_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["course_credits"].ToString() + "</td>";
                        elective_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["gpa_ngpa"].ToString() + "</td>";
                        elective_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["dept_name"].ToString() + "</td>";
                        elective_course += "<td>" + ds_course_reg_dtl.Tables[1].Rows[h]["semester_code"].ToString() + "</td>";
                        elective_course += "</tr>";
                        credits = credits + Convert.ToInt32(ds_course_reg_dtl.Tables[1].Rows[h]["course_credits"].ToString());
                    }
                }
                elective_course += "</tbody></table>";

                //CcAddress = MailDetailsInst.Rows[0]["mail"].ToString();

                Subject = AckDetails.Rows[0]["subject"].ToString();

                Subject = Subject.Replace("@@studentcode", ds_course_reg_dtl.Tables[0].Rows[0]["user_id"].ToString());
                Subject = Subject.Replace("@@studentname", ds_course_reg_dtl.Tables[0].Rows[0]["user_name"].ToString());
                Subject = Subject.Replace("@@semester", semester);
                Subject = Subject.Replace("@@year", year);

                Message = AckDetails.Rows[0]["body"].ToString();

                Message = Message.Replace("@@total_credits", credits.ToString());
                Message = Message.Replace("@@mandatory_credits", ds_course_reg_dtl.Tables[0].Rows[0]["mandatory_credits"].ToString());
                Message = Message.Replace("@@elective_credits", ds_course_reg_dtl.Tables[0].Rows[0]["elective_credits"].ToString());
                Message = Message.Replace("@@sws_credits", ds_course_reg_dtl.Tables[0].Rows[0]["sws_credits"].ToString());
                Message = Message.Replace("@@guides", guides);
                Message = Message.Replace("@@studentcode", ds_course_reg_dtl.Tables[0].Rows[0]["user_id"].ToString());
                Message = Message.Replace("@@studentname", ds_course_reg_dtl.Tables[0].Rows[0]["user_name"].ToString());
                Message = Message.Replace("@@semester", semester);
                Message = Message.Replace("@@year", year);

                Message = Message.Replace("@@mandatory_courses", mandatory_course);
                Message = Message.Replace("@@elective_courses", elective_course);
                Message = Message.Replace("@@programlevel", ds_course_reg_dtl.Tables[0].Rows[0]["prog_level_name"].ToString());

                Message = Message.Replace("@@feestype", fees_type);
                Message = Message.Replace("@@installment_status", installment_status);

                switch (dept_code)
                {
                    case "1":
                        from_mail = "fa.admin@cept.ac.in";
                        from_password = "myeultgbvzwviork";
                        break;
                    case "2":
                        from_mail = "fd.admin@cept.ac.in";
                        from_password = "rlccvavgbhbwcwqd";
                        break;
                    case "3":
                        from_mail = "fm.admin@cept.ac.in";
                        from_password = "ntfepqitxqnbntbc";
                        break;
                    case "4":
                        from_mail = "fp.admin@cept.ac.in";
                        from_password = "srbkefkbafczuasq";
                        break;
                    case "5":
                        from_mail = "ft.admin@cept.ac.in";
                        from_password = "rccgxcipwqxozklg";
                        break;
                    default:
                        break;
                }

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
                //mail.To.Add(CcAddress);
                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);

                //Attachment attach = new Attachment(AckDetails.Rows[0]["att_path"].ToString());
                //attach.Name = AckDetails.Rows[0]["attachment_name"].ToString();
                //mail.Attachments.Add(attach);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);//30112019     
                }

                mail.Dispose();//30112019
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }
        #endregion

        #region Send Email Instructor
        public bool SendEmailNewInstructor(DataTable AckDetails, String instructor_name, String email, String instructor_code, String password, DataTable dept_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "", to_password = "", dept_code = "";

                String Message = "";
                String Subject = "";

                to_password = password;
                from_password = "CEPT2016";
                if (dept_dtl != null)
                {
                    dept_code = dept_dtl.Rows[0]["dept_code"].ToString();

                    switch (dept_code)
                    {
                        case "1":
                            from_mail = "fa.admin@cept.ac.in";
                            from_password = "myeultgbvzwviork";
                            break;
                        case "2":
                            from_mail = "fd.admin@cept.ac.in";
                            from_password = "rlccvavgbhbwcwqd";
                            break;
                        case "3":
                            from_mail = "fm.admin@cept.ac.in";
                            from_password = "ntfepqitxqnbntbc";
                            break;
                        case "4":
                            from_mail = "fp.admin@cept.ac.in";
                            from_password = "srbkefkbafczuasq";
                            break;
                        case "5":
                            from_mail = "ft.admin@cept.ac.in";
                            from_password = "rccgxcipwqxozklg";
                            break;
                        default:
                            break;
                    }
                }
                else
                {
                    from_mail = "connect.help@cept.ac.in";
                    from_password = "bsnl.c0nnEct";
                }

                ToAddress = email;
                Subject = AckDetails.Rows[0]["subject"].ToString();
                Subject.Replace("@@instructor_code", instructor_code);
                Subject.Replace("@@instructor_name", instructor_name);
                Subject.Replace("@@instructor_email", email);
                Subject.Replace("@@instructor_password", password);

                Message = AckDetails.Rows[0]["body"].ToString();
                Message = Message.Replace("@@instructor_code", instructor_code);
                Message = Message.Replace("@@instructor_name", instructor_name);
                Message = Message.Replace("@@instructor_email", email);
                Message = Message.Replace("@@instructor_password", password);

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        #endregion
        #region Send Email - Clearance Form
        public bool SendEmailWhileStudentSubmitClearanceForm(DataTable AckDetails, DataTable StudentDetails, DataTable DepartmentDetails)
        {
            try
            {

                string from_mail = "", from_password = "", dept_code = "", admin_email = "", account_email = "";

                String Message = "";
                String Subject = "";

                from_mail = "donotreply@cept.ac.in";
                from_password = "vyujpnmbkllqrujz"; //cept2014

                if (StudentDetails != null)
                {
                    dept_code = StudentDetails.Rows[0]["dept_code"].ToString();

                    switch (dept_code)
                    {
                        case "1":
                            admin_email = "fa.admin@cept.ac.in";
                            from_password = "vyujpnmbkllqrujz";
                            account_email = "devang.bhavsar@cept.ac.in";
                            break;
                        case "2":
                            admin_email = "fd.admin@cept.ac.in";
                            account_email = "uma@cept.ac.in";
                            break;
                        case "3":
                            admin_email = "fm.admin@cept.ac.in";
                            account_email = "uma@cept.ac.in";
                            break;
                        case "4":
                            admin_email = "fp.admin@cept.ac.in";
                            account_email = "hansa.gohel@cept.ac.in";
                            break;
                        case "5":
                            admin_email = "ft.admin@cept.ac.in";
                            account_email = "amit.shah@cept.ac.in";
                            break;
                        default:
                            break;
                    }
                }

                Subject = AckDetails.Rows[0]["subject"].ToString();

                Subject = Subject.Replace("@@user_id", StudentDetails.Rows[0]["user_id"].ToString());
                Subject = Subject.Replace("@@student_name", StudentDetails.Rows[0]["user_name"].ToString());

                Message = AckDetails.Rows[0]["body"].ToString();

                Message = Message.Replace("@@user_id", StudentDetails.Rows[0]["user_id"].ToString());
                Message = Message.Replace("@@student_name", StudentDetails.Rows[0]["user_name"].ToString());

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

                for (int i = 0; i < DepartmentDetails.Rows.Count; i++)
                {
                    if (DepartmentDetails.Rows[i]["mail"].ToString() != "")
                    {
                        mail.To.Add(DepartmentDetails.Rows[i]["mail"].ToString());
                    }
                }

                mail.To.Add(admin_email);
                mail.To.Add(account_email);
                //mail.To.Add("kbaraskar735@gmail.com");
                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();
            }
            catch (Exception ex)
            {
                Log.ExceptionLog("Email Sent ClearanceForm 2. " + ex.Message + Environment.NewLine);
                return false;
            }
            return true;
        }
        public bool SendEmailWhileSaveActionClearanceForm(DataTable AckDetails, DataTable StudentDetails, string department_name)
        {
            string student_email_new = "";
            try
            {

                string from_mail = "", from_password = "", student_email = "";

                String Message = "";
                String Subject = "";

                from_mail = "donotreply@cept.ac.in";
                from_password = "vyujpnmbkllqrujz";  //cept2014

                if (StudentDetails != null)
                {
                    student_email = StudentDetails.Rows[0]["mail"].ToString();
                    student_email_new = StudentDetails.Rows[0]["mail"].ToString();
                }

                Subject = AckDetails.Rows[0]["subject"].ToString();

                Subject = Subject.Replace("@@user_id", StudentDetails.Rows[0]["user_id"].ToString());
                Subject = Subject.Replace("@@student_name", StudentDetails.Rows[0]["user_name"].ToString());
                Subject = Subject.Replace("@@department_name", department_name);

                Message = AckDetails.Rows[0]["body"].ToString();

                Message = Message.Replace("@@user_id", StudentDetails.Rows[0]["user_id"].ToString());
                Message = Message.Replace("@@student_name", StudentDetails.Rows[0]["user_name"].ToString());
                Message = Message.Replace("@@department_name", department_name);

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
                mail.To.Add(student_email);
                //mail.To.Add("mpanchal2707@gmail.com");
                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                    Log.ExceptionLog("ClearanceForm Email Sent Successfully. " + student_email + Environment.NewLine);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {
                Log.ExceptionLog("Email Sent ClearanceForm. " + student_email_new + ex.Message + Environment.NewLine);
                return false;
            }
            return true;
        }
        #endregion
        #region Send Email - Call For Studio
        public bool sendmailforstudiouser(DataTable AckDetails, String user_id, String user_type, DataTable user_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "", to_password = "", dept_code = "";

                String Message = "";
                String Subject = "";
                from_mail = "donotreply@cept.ac.in";
                from_password = "vyujpnmbkllqrujz";  //cept2014

                ToAddress = user_dtl.Rows[0]["mail"].ToString();
                Subject = AckDetails.Rows[0]["subject"].ToString();

                Message = AckDetails.Rows[0]["body"].ToString();
                string full_name = string.Empty;
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                Message = Message.Replace("@@full_name", full_name);

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        #endregion
        #region Send Email - Bonafied Certificate
        public bool sendmailforbonafiedcert(DataTable AckDetails)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "", to_password = "", dept_code = "";

                String Message = "";
                String Subject = "";
                from_mail = "donotreply@cept.ac.in";
                from_password = "vyujpnmbkllqrujz";  //cept2014

                ToAddress = "studentservices@cept.ac.in";
                Subject = AckDetails.Rows[0]["subject"].ToString();

                Message = AckDetails.Rows[0]["body"].ToString();
                string full_name = string.Empty;
                Message = Message.Replace("@@full_name", full_name);

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        #endregion
        #region Email Body For Medical and Anti Ragging Certificate
        public String SendCertificateMail(string EmailId, string status, string type)//, string UserName
        {
            #region Make Varification
            //EmailId = "nitin.magjikondi@cept.ac.in";                         
            String Cept_Link = "http://connect.cept.ac.in/";
            #endregion

            String Message = "";
            String Subject = "";
            Message = "Dear Student.<br/>";
            if (status == "A")
            {
                if (type == "M")
                {
                    Subject = "Medical Fitness Certificate";
                    Message += "<p>Your Medical Certificate has been Successfully Approved by SSO.</p>";
                }
                else
                {
                    Subject = "Anti Ragging Certificate";
                    Message += "<p>Your Anti-ragging Certificate has been Successfully Approved by SSO.</p>";
                }
                Message += "Wish you very good luck.<br/>Best Wishes,<br/>Student Services Office";
            }
            else if (status == "R")
            {
                if (type == "M")
                {
                    Subject = "Medical Fitness Certificate";
                    Message += "<p>Your Medical certificate has been rejected by SSO and has given remarks to upload a new file.<br/></p>";
                    Message += "<p>To view remarks and update file : Please login :<a href=" + Cept_Link + ">http://connect.cept.ac.in/</a></p>";
                }
                else
                {
                    Subject = "Anti Ragging Certificate";
                    Message += "<p>Your Anti-ragging certificate has been rejected by SSO and has given remarks to upload a new file.<br/></p>";
                    Message += "<p>To view remarks and update file : Please login :<a href=" + Cept_Link + ">http://connect.cept.ac.in/</a></p>";
                }
                Message += "Regards,<br/>Student Services Office";
            }


            //Change email id and password to send verification email

            string from_mail = "donotreply@cept.ac.in";
            string from_password = "vyujpnmbkllqrujz";  //cept2014

            SmtpClient smtp = new SmtpClient
            {
                Host = "smtp.gmail.com", // smtp server address here...
                //Port = 587,
                Port = port,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new System.Net.NetworkCredential(from_mail, from_password),
                Timeout = 50000,
            };

            EmailId = EmailId.Trim();

            try
            {
                MailMessage mail = new MailMessage();
                mail.To.Add(EmailId);
                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);

                //if (status == "A")
                //{
                // Attachment attach = new Attachment("C:/inetpub/wwwroot/CEPTREG/FeedbackPdf/" + attach_name.Replace('/', '_') + ".pdf");
                // attach.Name = attach_name.Replace('/', '_') + ".pdf";
                // mail.Attachments.Add(attach);
                //}

                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                    Log.ExceptionLog("Email Sent Successfully. " + EmailId + Environment.NewLine);
                }

            }
            catch (Exception ex)
            {
                Log.ExceptionLog(ex.Message + Environment.NewLine + ex.StackTrace);
                return "unsuccess";
            }
            return "success";
        }
        #endregion
        #region studio Details Submit
        public bool sendmailforstudioDetails(string user_id, string user_type, DataTable user_dtl, DataTable from_mail_password, DataTable AckDetails)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = from_mail_password.Rows[0]["from_mail_id"].ToString();
                from_password = from_mail_password.Rows[0]["from_password"].ToString();

                ToAddress = user_dtl.Rows[0]["mail"].ToString();
                Subject = AckDetails.Rows[0]["subject"].ToString();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                Message = Message.Replace("@@full_name", full_name);

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool sendmailforTAApplicatioSubmit(DataTable user_dtl, DataTable from_mail_password, DataTable AckDetails, string semester_type, string year_type)
        {
            try
            {
                if (semester_type.ToLower() == "s")
                {
                    semester_type = "Spring";
                }
                else
                {
                    semester_type = "Monsoon";
                }

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = from_mail_password.Rows[0]["from_mail_id"].ToString();
                from_password = from_mail_password.Rows[0]["from_password"].ToString();

                ToAddress = user_dtl.Rows[0]["mail"].ToString();
                Subject = AckDetails.Rows[0]["subject"].ToString();
                Subject = Subject.Replace("@@semester_type", semester_type);
                Subject = Subject.Replace("@@year_type", year_type);
                Message = AckDetails.Rows[0]["body"].ToString();
                Message = Message.Replace("@@semester_type", semester_type);
                Message = Message.Replace("@@year_type", year_type);

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool sendmailforBriefsubmit(string user_id, string user_type, DataTable user_dtl, DataTable from_mail_password, DataTable AckDetails)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = from_mail_password.Rows[0]["from_mail_id"].ToString();
                from_password = from_mail_password.Rows[0]["from_password"].ToString();

                ToAddress = user_dtl.Rows[0]["mail"].ToString();
                Subject = AckDetails.Rows[0]["subject"].ToString();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                //if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                //{
                //    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                //}
                //if (full_name == "")
                //{
                //    full_name = user_dtl.Rows[0]["user_name"].ToString();
                //}
                //else if (full_name == "")
                //{
                //    full_name = user_dtl.Rows[0]["full_name"].ToString();
                //}
                full_name = "Tutor";
                Message = Message.Replace("@@full_name", full_name);

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool StudioproposalAuthorized(string inst_code, DataTable pc_dtl, DataTable dean_dtl, DataTable faculty_admin, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl, string remark)
        {
            try
            {
                ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                //if (user_dtl.Columns.Count > 1)
                //{

                
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                //}
                //else { full_name = "Tutor"; }
                Message = Message.Replace("@@full_name", full_name);

                if (remark != "")
                {
                    Message = Message.Replace("@@remark", remark);
                }

                if (AckDetails.Rows[0]["email_type"].ToString().Trim() == "TAAuthorization")
                {
                    Message = Message.Replace("@@studio_name", remark);
                }

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
                if (pc_dtl != null)
                {
                    string[] ToMuliId = pc_dtl.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }

                }
                if (dean_dtl != null)
                {
                    string[] ToMuliId = dean_dtl.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }
                        }

                    }

                }

                if (faculty_admin != null)
                {
                    string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }

                }

                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);

                Message_body_gen = Message;
                Subject_gen = Subject;
                filePath_gen = "";
                ToMail_gen = ToAddress;
                FromMail_gen = from_mail;
                FromPassword_gen = from_password;
                CCMail_gen = "";

               // HandleSmtpException("", ToMail_gen, FromMail_gen, FromPassword_gen, Subject_gen, Message_body_gen, CCMail_gen, filePath_gen);

                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    Log.ExceptionLog("Email Reject EmailID. " + from_mail + " Email Body. " + Message + Environment.NewLine);
                    smtp.Send(mail);
                    Log.ExceptionLog("Email Reject EmailID. " + from_mail + " Email Body. " + Message + Environment.NewLine);
                }
                mail.Dispose();
            }
            catch (SmtpException smtpEx)
            {
                HandleSmtpException(smtpEx, ToMail_gen, FromMail_gen, FromPassword_gen, Subject_gen, Message_body_gen, CCMail_gen, filePath_gen);
               
                return false;
            }
            catch (Exception ex)
            {
                Log.ExceptionLog("Reject Mail Exception " + ex.Message);
                return false;
            }
            return true;
        }
        public bool StudioproposalAuthorized_new(string inst_code, DataTable pc_dtl, DataTable dean_dtl, DataTable faculty_admin, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl, string remark,DataTable dt_studio_code_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                //if (user_dtl.Columns.Count > 1)
                //{


                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                //}
                //else { full_name = "Tutor"; }
                Message = Message.Replace("@@full_name", full_name);

                if (remark != "")
                {
                    Message = Message.Replace("@@remark", remark);
                }

                if (dt_studio_code_dtl != null && dt_studio_code_dtl.Rows[0]["studio_title"].ToString().Trim() != "")
                {
                    Message = Message.Replace("@@studio_name", dt_studio_code_dtl.Rows[0]["studio_title"].ToString().Trim());
                }

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
                if (pc_dtl != null)
                {
                    string[] ToMuliId = pc_dtl.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }

                }
                if (dean_dtl != null)
                {
                    string[] ToMuliId = dean_dtl.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }
                        }

                    }

                }
                if (faculty_admin != null)
                {
                    string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }

                }

                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool SendMailForTutorRemarkByHR(string inst_code, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl, string remark)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                //if (user_dtl.Columns.Count > 1)
                //{


                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                Message = Message.Replace("@@full_name", full_name);

                if (remark != "")
                {
                    Message = Message.Replace("@@remark", remark);
                }

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool SendMailForTutorRemarkByHR_New(string inst_code, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl, string remark)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                ToAddress = "uso@cept.ac.in";
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                //if (user_dtl.Columns.Count > 1)
                //{


                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                Message = Message.Replace("@@full_name", full_name);

                if (remark != "")
                {
                    Message = Message.Replace("@@remark", remark);
                }

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
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool SendCACMail(DataTable dataTable, DataTable pc_dtl, DataTable dean_dtl, DataTable mail_from_id_password, DataTable AckDetails, DataTable dept_dt,DataTable faculty_admin, DataTable AckDetails_Core)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";

                DataRow[] dr_VF = dataTable.Select("designation <> 'instructor'");
                DataRow[] dr_inst = dataTable.Select("designation = 'instructor'");
                if (dr_VF.Length > 0)
                {
                    from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                    from_password = mail_from_id_password.Rows[0]["from_password"].ToString();

                    Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                    Message = AckDetails.Rows[0]["body"].ToString();

                    Message = Message.Replace("@@full_name", "Tutor");
                    Message = Message.Replace("@@department", dept_dt.Rows[0]["DepartmentName"].ToString());

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
                    // mail.To.Add(ToAddress);
                    if (dataTable != null)
                    {
                        //for (int p = 0; p < dataTable.Rows.Count; p++)
                        //{
                        //    if (dataTable.Rows[p]["mail"].ToString() != "")
                        //    {
                        //        mail.To.Add(new MailAddress(dataTable.Rows[p]["mail"].ToString().Trim()));
                        //    }
                        //}
                        for (int p = 0;  p < dr_VF.Length;  p++)
                        {
                            if (dr_VF[p]["mail"].ToString() != "")
                            {
                                mail.To.Add(new MailAddress(dr_VF[p]["mail"].ToString().Trim()));
                            }
                        }

                    }

                    if (pc_dtl != null)
                    {
                        string[] ToMuliId = pc_dtl.Rows[0]["mail_id"].ToString().Split(',');
                        foreach (string ToEMailId in ToMuliId)
                        {
                            if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }
                    if (dean_dtl != null)
                    {
                        string[] ToMuliId = dean_dtl.Rows[0]["mail_id"].ToString().Split(',');
                        foreach (string ToEMailId in ToMuliId)
                        {
                            if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }

                    if (faculty_admin != null)
                    {
                        string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                        foreach (string ToEMailId in ToMuliId)
                        {
                            if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }


                    //mail.CC.Add(new MailAddress("uso@cept.ac.in"));

                    mail.Subject = Subject;
                    mail.From = new MailAddress(from_mail, "CEPT University");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                    mail.Dispose();
                }

                if (dr_inst.Length > 0)
                {
                    from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                    from_password = mail_from_id_password.Rows[0]["from_password"].ToString();

                    Subject = AckDetails_Core.Rows[0]["subject"].ToString().Trim();

                    Message = AckDetails_Core.Rows[0]["body"].ToString();

                    Message = Message.Replace("@@full_name", "Tutor");
                    Message = Message.Replace("@@department", dept_dt.Rows[0]["DepartmentName"].ToString());

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
                    // mail.To.Add(ToAddress);
                    if (dataTable != null)
                    {
                        //for (int p = 0; p < dataTable.Rows.Count; p++)
                        //{
                        //    if (dataTable.Rows[p]["mail"].ToString() != "")
                        //    {
                        //        mail.To.Add(new MailAddress(dataTable.Rows[p]["mail"].ToString().Trim()));
                        //    }
                        //}
                        for (int p = 0; p < dr_inst.Length; p++)
                        {
                            if (dr_inst[p]["mail"].ToString() != "")
                            {
                                mail.To.Add(new MailAddress(dr_inst[p]["mail"].ToString().Trim()));
                            }
                        }

                    }

                    if (pc_dtl != null)
                    {
                        string[] ToMuliId = pc_dtl.Rows[0]["mail_id"].ToString().Split(',');
                        foreach (string ToEMailId in ToMuliId)
                        {
                            if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }
                    if (dean_dtl != null)
                    {
                        string[] ToMuliId = dean_dtl.Rows[0]["mail_id"].ToString().Split(',');
                        foreach (string ToEMailId in ToMuliId)
                        {
                            if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }

                    if (faculty_admin != null)
                    {
                        string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                        foreach (string ToEMailId in ToMuliId)
                        {
                            if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }


                    //mail.CC.Add(new MailAddress("uso@cept.ac.in"));

                    mail.Subject = Subject;
                    mail.From = new MailAddress(from_mail, "CEPT University");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                    mail.Dispose();
                }


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool SendMailforSendforreviewfaculty(DataTable dataTable, DataTable pc_dtl, DataTable dean_dtl, DataTable mail_from_id_password, DataTable AckDetails)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();
                Message = Message.Replace("@@course_code", dataTable.Rows[0]["course_code"].ToString());
                Message = Message.Replace("@@course_name", dataTable.Rows[0]["course_name"].ToString());

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
                // mail.To.Add(ToAddress);
                if (dataTable != null)
                {
                    for (int p = 0; p < dataTable.Rows.Count; p++)
                    {
                        if (dataTable.Rows[p]["mail"].ToString() != "")
                        {
                            mail.To.Add(new MailAddress(dataTable.Rows[p]["mail"].ToString().Trim()));
                        }
                    }

                }

                if (pc_dtl != null)
                {
                    string[] ToMuliId = pc_dtl.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                        }

                    }

                }
                //if (dean_dtl != null)
                //{
                //    string[] ToMuliId = dean_dtl.Rows[0]["mail_id"].ToString().Split(',');
                //    foreach (string ToEMailId in ToMuliId)
                //    {
                //        if (ToEMailId.Trim() != "prashant" && ToEMailId.Trim() != "")
                //        {
                //            mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                //        }
                //
                //    }
                //
                //}
                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        #endregion

        #region Send Mail to Student on SmartCard Fees payment successfull
        public String SendEmailOnSmartCardfeesPaymentSuccess(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    if (!data.ContainsKey("pg_type")) data["pg_type"] = "Citrus";

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your Smart Card fees payment with Cept using " + data["pg_type"] + " was <b>successful!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />" + data["pg_type"] + " Reference Number :  " + data["pg_transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Payment Received :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    //Message += "<br /><br /><br />For payment related queries please contact admissions.finance@cept.ac.in";
                    Message += "<br /><br /><br />For payment related queries please contact Mr. Ramesh Raval, at studentservices@cept.ac.in.";
                    Message += "<br /><p>Sincerely,<br />Rector<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();

                    mail.To.Add(ToAddress);
                    mail.Subject = "CEPT Smart Card Fees: Payment Confirmation";
                    mail.From = new MailAddress(sending_email, "CEPT");
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
        public String SendEmailOnSmartCardfeesPaymentFail(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your online Smart Card fees payment with CEPT has failed!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Transaction Amount :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    Message += "<br /><br /><br />In case the amount has been deducted from your account, contact your bank with details of the transaction. You are also requested to email the proof of transaction/debit in your account to studentservices@cept.ac.in for further action.";
                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();

                    mail.To.Add(ToAddress);
                    mail.Subject = "CEPT Smart Card Fees: Payment Fail";
                    mail.From = new MailAddress(sending_email, "CEPT");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    return ex.ToString();
                }
            }
            catch (Exception ex)
            {
                return "Some problem in mail sent. Mail is not sent";
            }
            return "success";
        }
        #endregion
        public bool SentTAApplicatioAccept(DataTable get_studio_details, DataTable dt_inst_email, DataTable accept_ta, DataTable mail_from_id_password, DataTable AckDetails, string type)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                //  ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                //string full_name = string.Empty;
                //if (dataTable.Rows[0]["first_name"].ToString() != "" && dataTable.Rows[0]["last_name"].ToString() != "")
                //{
                //    full_name = dataTable.Rows[0]["first_name"].ToString() + " " + dataTable.Rows[0]["last_name"].ToString();
                //}
                //if (full_name == "")
                //{
                //    full_name = dataTable.Rows[0]["instructor_name"].ToString();
                //}

                Message = Message.Replace("@@dept_name", get_studio_details.Rows[0]["dept_name"].ToString().Trim());
                if (type == "23")
                {
                    Message = Message.Replace("@@studio_name", get_studio_details.Rows[0]["studio_code"].ToString().Trim() + " " + get_studio_details.Rows[0]["studio_title"].ToString().Trim());
                    Message = Message.Replace("@@level ", get_studio_details.Rows[0]["studio_level"].ToString().Trim());
                }
                else if (type == "24")
                {
                    Message = Message.Replace("@@studio_name", get_studio_details.Rows[0]["course_code"].ToString().Trim() + " " + get_studio_details.Rows[0]["course_name"].ToString().Trim());
                    Message = Message.Replace("@@level ", "");
                }



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
                // mail.To.Add("kbaraskar735@gmail.com");
                // mail.To.Add("connect.help@cept.ac.in");
                mail.To.Add(new MailAddress(dt_inst_email.Rows[0]["mail"].ToString().Trim()));
                mail.To.Add(new MailAddress(accept_ta.Rows[0]["mail"].ToString().Trim()));

                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool SWSCourseApprovedMail(string inst_code, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                //if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                //{
                //    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                //}
                //if (full_name == "")
                //{
                //    full_name = user_dtl.Rows[0]["full_name"].ToString();
                //}
                //else if (full_name == "")
                //{
                //    full_name = user_dtl.Rows[0]["user_name"].ToString();
                //}
                Message = Message.Replace("@@course_code", user_dtl.Rows[0]["course_code"].ToString());
                Message = Message.Replace("@@course_name", user_dtl.Rows[0]["course_name"].ToString());



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
                //mail.To.Add(ToAddress);

                for (int i = 0; i < user_dtl.Rows.Count; i++)
                {
                    mail.To.Add(new MailAddress(user_dtl.Rows[i]["mail"].ToString().Trim()));
                }
                if (user_dtl.Rows[0]["inhabitation"].ToString().Trim() == "1")
                {
                    mail.CC.Add(new MailAddress("sameep.padora@cept.ac.in"));
                }
                else if (user_dtl.Rows[0]["inhabitation"].ToString().Trim() == "2")
                {
                    mail.CC.Add(new MailAddress("saleem.bhatri@cept.ac.in"));

                }
                else if (user_dtl.Rows[0]["inhabitation"].ToString().Trim() == "3")
                {
                    mail.CC.Add(new MailAddress("pranavant@cept.ac.in"));
                }
                else if (user_dtl.Rows[0]["inhabitation"].ToString().Trim() == "4")
                {
                    mail.CC.Add(new MailAddress("shalini.sinha@cept.ac.in"));
                }
                else if (user_dtl.Rows[0]["inhabitation"].ToString().Trim() == "5")
                {
                    mail.CC.Add(new MailAddress("aanal.shah@cept.ac.in"));
                }




                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public String SWS_Send_Appointment_Mail_to_visiting_faculty(Dictionary<string, object>[] dic_instructor_list, DataTable AckDetails, DataTable course_data, string directory_path_new)
        {
            //string source_email = "donotreply.ug.fm@cept.ac.in";
            string source_email = "swsnotreply@cept.ac.in";
            //string password = "CEPT@2016";
            string password = "pwujalrdcbsegjfo";
            string ToAddress = "";

            String Message = "";
            String Subject = "";
            String Body = "";



            string directory_path = "C:/Ceptreg_Log/Send_Appointment_Letter/Log/";
            string filename = "Visiting_Faculty_Mail_Log";
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Date : " + DateTime.Now + Environment.NewLine);
            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "=======================================================================================" + Environment.NewLine);

            try
            {
                for (int i = 0; i < dic_instructor_list.Length; i++)
                {

                    string sem = "";
                    if (dic_instructor_list[i]["sem_code"].ToString() == "S") sem = "Summer";
                    else if (dic_instructor_list[i]["sem_code"].ToString() == "W") sem = "Winter";

                    string year = dic_instructor_list[i]["year_code"].ToString();
                    String File_Name = dic_instructor_list[i]["instructor_code"].ToString() + "_" + dic_instructor_list[i]["instructor_name"].ToString().Replace(" ", "_") + "_" + sem + "_" + year + ".pdf";
                    Subject = AckDetails.Rows[0]["subject"].ToString();

                    Subject = Subject.Replace("@@sem", sem);
                    Subject = Subject.Replace("@@year", year);

                    Message = AckDetails.Rows[0]["body"].ToString();
                    Message = Message.Replace("@@title", dic_instructor_list[i]["title"].ToString());
                    Message = Message.Replace("@@instructor_name", dic_instructor_list[i]["instructor_name"].ToString());



                    //if (dic_instructor_list[i]["hdn_tea_letter"].ToString() == "TEA")
                    //{
                    //    Message = Message.Replace("@@user_type", "Teaching Associate");
                    //}
                    //else if (dic_instructor_list[i]["hdn_user_type"].ToString() == "VF")
                    //{
                    //    Message = Message.Replace("@@user_type", "Visiting Faculty");
                    //}
                    //else if (dic_instructor_list[i]["userType"].ToString() == "TA")
                    //{
                    //    Message = Message.Replace("@@user_type", "Teaching Assistant");
                    //}
                    //else if (dic_instructor_list[i]["userType"].ToString() == "AA")//Teaching Associate/
                    //{
                    //    Message = Message.Replace("@@user_type", "Academic Associate");
                    //}


                    switch (course_data.Rows[0]["inhabitation"].ToString().Trim())
                    {
                        case "1":
                            Message = Message.Replace("@@dept_name", "Architecture");
                            break;
                        case "2":
                            Message = Message.Replace("@@dept_name", "Design");
                            break;
                        case "3":
                            Message = Message.Replace("@@dept_name", "Management");
                            break;
                        case "4":
                            Message = Message.Replace("@@dept_name", "Planning");

                            break;
                        case "5":
                            Message = Message.Replace("@@dept_name", "Technology");
                            break;
                        default:
                            return "Department not found.";
                    }

                    Message = Message.Replace("@@sem", sem);
                    Message = Message.Replace("@@year", year);


                    //if (dic_instructor_list[i]["prog_code"].ToString() == "3")
                    //{
                    //    source_email = "head.doctoraloffice@cept.ac.in";
                    //    password = "phd@2018";
                    //}
                    //else
                    //{
                    //    switch (dic_instructor_list[i]["dept_name"].ToString())
                    //    {
                    //        case "Architecture":
                    //            source_email = "fa.admin@cept.ac.in";
                    //            password = "2019_C#PT";
                    //            break;
                    //        case "Design":
                    //            source_email = "fd.admin@cept.ac.in";
                    //            break;
                    //        case "Management":
                    //            source_email = "fm.admin@cept.ac.in";
                    //            break;
                    //        case "Planning":
                    //            source_email = "fp.admin@cept.ac.in";
                    //            password = "fpadmin@2021";
                    //            break;
                    //        case "Technology":
                    //            source_email = "ft.admin@cept.ac.in";
                    //            break;
                    //        case "Doctoral Programs":
                    //            source_email = "head.doctoraloffice@cept.ac.in";
                    //            password = "phd@2018";
                    //            break;
                    //        default:
                    //            return "Source Email not found.";
                    //    }
                    //}


                    if (dic_instructor_list[i]["mail"].ToString() != "")
                    {
                        try
                        {
                            ToAddress = dic_instructor_list[i]["mail"].ToString();
                            //ToAddress = "kbaraskar735@gmail.com";
                            SmtpClient smtp = new SmtpClient
                            {
                                Host = "smtp.gmail.com", // smtp server address here...
                                Port = port,
                                EnableSsl = true,
                                DeliveryMethod = SmtpDeliveryMethod.Network,
                                Credentials = new System.Net.NetworkCredential(source_email, password),
                                Timeout = 50000,
                            };

                            MailMessage mail = new MailMessage();
                            mail.To.Add(ToAddress);
                            //Dean 
                            mail.CC.Add(new MailAddress("finance@cept.ac.in"));
                            mail.CC.Add(new MailAddress("hr@cept.ac.in"));
                            mail.CC.Add(new MailAddress("summerwinterschool@cept.ac.in"));
                            if (course_data.Rows[0]["inhabitation"].ToString().Trim() == "1")
                            {
                                //mail.CC.Add(new MailAddress("anjali.yagnik@cept.ac.in"));
                                mail.CC.Add(new MailAddress("fa.pg@cept.ac.in"));
                                mail.CC.Add(new MailAddress("manisha.asrani@cept.ac.in"));
                                Message = Message.Replace("@@faculty_admin_name", "Manisha Asrani");
                            }
                            else if (course_data.Rows[0]["inhabitation"].ToString().Trim() == "2")
                            {
                                // mail.CC.Add(new MailAddress("saleem.bhatri@cept.ac.in"));
                                mail.CC.Add(new MailAddress("kdaprsid@cept.ac.in"));
                                Message = Message.Replace("@@faculty_admin_name", "I V Krishna Das");

                            }
                            else if (course_data.Rows[0]["inhabitation"].ToString().Trim() == "3")
                            {
                                // mail.CC.Add(new MailAddress("chirayu.bhatt@cept.ac.in"));
                                mail.CC.Add(new MailAddress("jyoti.tomar@cept.ac.in"));
                                Message = Message.Replace("@@faculty_admin_name", "Jyoti Tomar");
                            }
                            else if (course_data.Rows[0]["inhabitation"].ToString().Trim() == "4")
                            {
                                // mail.CC.Add(new MailAddress("shalini.sinha@cept.ac.in"));
                                mail.CC.Add(new MailAddress("jinu@cept.ac.in"));
                                Message = Message.Replace("@@faculty_admin_name", "Jinu Joseph");
                            }
                            else if (course_data.Rows[0]["inhabitation"].ToString().Trim() == "5")
                            {
                                //mail.CC.Add(new MailAddress("aanal.shah@cept.ac.in"));
                                mail.CC.Add(new MailAddress("minal.trivedi@cept.ac.in"));
                                Message = Message.Replace("@@faculty_admin_name", "Minal Chirag Trivedi");
                            }



                            mail.Subject = Subject;
                            mail.From = new MailAddress(source_email, "CEPT");
                            mail.IsBodyHtml = true;
                            mail.Body = (Message);
                            string path = directory_path_new + "\\" + File_Name;
                            Attachment attach = new Attachment(path.ToString().Replace(" ", "_"));
                            attach.Name = "Appointment Letter" + ".pdf";
                            mail.Attachments.Add(attach);
                            if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                            {
                                smtp.Send(mail);
                            }

                            mail.Dispose();


                            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Code : " + dic_instructor_list[i]["instructor_code"] + Environment.NewLine);
                        }
                        catch (Exception ex)
                        {

                            System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Instructor Code : " + dic_instructor_list[i]["instructor_code"] + " :: ");


                            not_send_mail_list = not_send_mail_list + " :: " + ToAddress;
                        }
                    }


                    source_email = "";
                    Body = "";
                }

                if (not_send_mail_list != "")
                {
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "---------------------------------------------------------------------------------------" + Environment.NewLine);
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "Mail Delivery Fail to => " + not_send_mail_list + Environment.NewLine);
                    System.IO.File.AppendAllText(@"" + directory_path + filename + ".txt", "---------------------------------------------------------------------------------------" + Environment.NewLine);

                    return "Mail is not delivered to this IDs : " + not_send_mail_list;
                }

            }
            catch (Exception ex)
            {
                return "A Problem occured during sending Mail. Mail is not delivered to anyone.";
            }

            return "Mail Delivered Successfully";
        }
        #region Send Mail to Student on SmartCard Fees payment successfull
        public String SendEmailOnSWSCoursefeesPaymentSuccess(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    if (!data.ContainsKey("pg_type")) data["pg_type"] = "Citrus";

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your SW Course fees payment with Cept using " + data["pg_type"] + " was <b>successful!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />" + data["pg_type"] + " Reference Number :  " + data["pg_transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Payment Received :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    //Message += "<br /><br /><br />For payment related queries please contact admissions.finance@cept.ac.in";
                    Message += "<br /><br /><br />For payment related queries please contact SWS office.";
                    Message += "<br /><p>Sincerely,<br />Rector<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();

                    mail.To.Add(ToAddress);
                    mail.Subject = "CEPT SW Course Fees: Payment Confirmation";
                    mail.From = new MailAddress(sending_email, "CEPT");
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
        public String SendEmailOnSWSCoursefeesPaymentFail(Dictionary<string, string> data)
        {
            string ToAddress = "";
            String Message = "";
            string sending_email = ConfigurationSettings.AppSettings["email"].ToString();
            string sending_password = ConfigurationSettings.AppSettings["password"].ToString();

            try
            {
                try
                {
                    ToAddress = data["student_email"].ToString();

                    Message = "Hello, " + data["user_name"].ToString() + "";
                    Message += "<br /><br /><br />Your online SW Course fees payment with CEPT has failed!</b></p>";
                    Message += "<br /><br />Merchant Order Number :  " + data["transaction_id"].ToString() + "";
                    Message += "<br /><br />Application Number :  " + data["user_id"].ToString() + "";
                    Message += "<br /><br />Transaction Amount :  " + data["amount"].ToString() + "";
                    Message += "<br /><br />Transaction Date & Time :  " + data["transaction_date"].ToString() + "";
                    Message += "<br /><br /><br />In case the amount has been deducted from your account, contact your bank with details of the transaction. You are also requested to email the proof of transaction/debit in your account to studentservices@cept.ac.in for further action.";
                    Message += "<br /><p>Sincerely,<br />CEPT University</p>";

                    SmtpClient smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com", // smtp server address here...
                        Port = port,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        Credentials = new System.Net.NetworkCredential(sending_email, sending_password),
                        Timeout = 50000,
                    };

                    MailMessage mail = new MailMessage();

                    mail.To.Add(ToAddress);
                    mail.Subject = "CEPT SW Course Fees: Payment Fail";
                    mail.From = new MailAddress(sending_email, "CEPT");
                    mail.IsBodyHtml = true;
                    mail.Body = (Message);
                    if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                    {
                        smtp.Send(mail);
                    }
                }
                catch (Exception ex)
                {
                    return ex.ToString();
                }
            }
            catch (Exception ex)
            {
                return "Some problem in mail sent. Mail is not sent";
            }
            return "success";
        }
        #endregion

        //#region Mail Send For 
        #region
        public bool AppraisalMaildetails(string inst_code, DataTable dean_dtl, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                Message = Message.Replace("@@instructor_name", full_name);
                Message = Message.Replace("@@title", user_dtl.Rows[0]["title"].ToString());


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
                mail.CC.Add(new MailAddress("appraisals25@cept.ac.in"));

                //if (dean_dtl != null)
                //{
                //    string[] ToMuliId = dean_dtl.Rows[0]["mail_id"].ToString().Split(',');
                //    foreach (string ToEMailId in ToMuliId)
                //    {
                //        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                //        {
                //            if (ToEMailId.Contains('@') == true)
                //            {
                //                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                //            }
                //        }

                //    }

                //}



                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool AppraisalMaildetailsdean(string inst_code, DataTable dean_dtl, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();

                for (int i = 0; i < dean_dtl.Rows.Count; i++)
                {



                    ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                    Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                    Message = AckDetails.Rows[0]["body"].ToString();

                    string full_name = string.Empty;
                    if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                    {
                        full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                    }
                    if (full_name == "")
                    {
                        full_name = user_dtl.Rows[0]["full_name"].ToString();
                    }
                    else if (full_name == "")
                    {
                        full_name = user_dtl.Rows[0]["user_name"].ToString();
                    }


                    string deanfull_name = string.Empty;
                    if (dean_dtl.Rows[i]["first_name"].ToString() != "" && dean_dtl.Rows[i]["last_name"].ToString() != "")
                    {
                        deanfull_name = dean_dtl.Rows[i]["first_name"].ToString() + " " + dean_dtl.Rows[i]["last_name"].ToString();
                    }
                    if (deanfull_name == "")
                    {
                        deanfull_name = dean_dtl.Rows[i]["full_name"].ToString();
                    }
                    else if (deanfull_name == "")
                    {
                        deanfull_name = dean_dtl.Rows[i]["user_name"].ToString();
                    }
                    Message = Message.Replace("@@instructor_name", full_name);
                    Message = Message.Replace("@@dean_name", deanfull_name);
                    Message = Message.Replace("@@title", user_dtl.Rows[0]["title"].ToString());
                    Message = Message.Replace("@@deantitle", dean_dtl.Rows[i]["title"].ToString());


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
                    if (dean_dtl.Rows[i]["mail"].ToString().Trim() != "dean" && dean_dtl.Rows[i]["mail"].ToString().Trim() != "")
                    {


                        mail.To.Add(dean_dtl.Rows[i]["mail"].ToString());
                        //if (dean_dtl != null)
                        //{
                        //    string[] ToMuliId = dean_dtl.Rows[0]["mail_id"].ToString().Split(',');
                        //    foreach (string ToEMailId in ToMuliId)
                        //    {
                        //        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        //        {
                        //            if (ToEMailId.Contains('@') == true)
                        //            {
                        //                mail.To.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                        //            }
                        //        }
                        //
                        //    }
                        //
                        //}
                        mail.CC.Add(new MailAddress("appraisals25@cept.ac.in"));


                        mail.Subject = Subject;
                        mail.From = new MailAddress(from_mail, "CEPT University");
                        mail.IsBodyHtml = true;
                        mail.Body = (Message);
                        if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                        {
                            smtp.Send(mail);
                        }
                        mail.Dispose();
                    }
                }

            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        #endregion
        #region TA Remark Mail
        public bool SendTAApplicationRemark(DataTable faculty_admin, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                Message = Message.Replace("@@full_name", full_name);

                //if (remark != "")
                //{
                //    Message = Message.Replace("@@remark", remark);
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
              
                

                if (faculty_admin != null)
                {
                    string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }

                        }

                    }

                }

                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        #endregion

        #region Provisal Certificate Mail
        public bool SendProvisnalCertificate(DataTable faculty_admin, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                Message = Message.Replace("@@student_name", full_name);

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

                //if (faculty_admin != null)
                //{
                //    string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                //    foreach (string ToEMailId in ToMuliId)
                //    {
                //        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                //        {
                //            if (ToEMailId.Contains('@') == true)
                //            {
                //                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                //            }
                //        }
                //    }
                //}

                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool SendProvisnalCertificateFaculty(DataTable faculty_admin, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";

                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();



                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }
                Message = Message.Replace("@@student_name", full_name);
                Message = Message.Replace("@@user_id", user_dtl.Rows[0]["user_id"].ToString());

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

                if (faculty_admin != null)
                {
                    string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                    foreach (string ToEMailId in ToMuliId)
                    {
                        if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                        {
                            if (ToEMailId.Contains('@') == true)
                            {
                                mail.CC.Add(new MailAddress(ToEMailId.Trim())); //adding multiple TO Email Id  
                            }
                        }
                    }
                }
                mail.CC.Add(new MailAddress("pg.office@cept.ac.in"));
                mail.CC.Add(new MailAddress("ug.office@cept.ac.in"));
                mail.CC.Add(new MailAddress("Hansa.gohel@cept.ac.in"));
                mail.CC.Add(new MailAddress("examination@cept.ac.in"));

                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        public bool SendProvisnalCertificateFacultyComman(DataTable faculty_admin, DataTable mail_from_id_password, DataTable AckDetails, DataTable user_dtl, DataTable Get_Remark, string user_type, DataTable Loginuserid)
        {
            try
            {

                string ToAddress = "", from_mail = "", from_password = "";
                String Message = "";
                String Subject = "";
                from_mail = mail_from_id_password.Rows[0]["from_mail_id"].ToString();
                from_password = mail_from_id_password.Rows[0]["from_password"].ToString();

                ToAddress = user_dtl.Rows[0]["mail"].ToString().Trim();
                Subject = AckDetails.Rows[0]["subject"].ToString().Trim();

                Message = AckDetails.Rows[0]["body"].ToString();

                string full_name = string.Empty;
                if (user_dtl.Rows[0]["first_name"].ToString() != "" && user_dtl.Rows[0]["last_name"].ToString() != "")
                {
                    full_name = user_dtl.Rows[0]["first_name"].ToString() + " " + user_dtl.Rows[0]["last_name"].ToString();
                }
                 if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["full_name"].ToString();
                }
                else if (full_name == "")
                {
                    full_name = user_dtl.Rows[0]["user_name"].ToString();
                }


                string Login_full_name = string.Empty;
                if (Loginuserid.Rows[0]["first_name"].ToString() != "" && Loginuserid.Rows[0]["last_name"].ToString() != "")
                {
                    Login_full_name = Loginuserid.Rows[0]["first_name"].ToString() + " " + Loginuserid.Rows[0]["last_name"].ToString();
                }
                if (Login_full_name == "")
                {
                    Login_full_name = Loginuserid.Rows[0]["full_name"].ToString();
                }
                else if (Login_full_name == "")
                {
                    Login_full_name = Loginuserid.Rows[0]["user_name"].ToString();
                }


                Message = Message.Replace("@@student_name", full_name);
                Message = Message.Replace("@@user_id", user_dtl.Rows[0]["user_id"].ToString());
                Message = Message.Replace("@@student_code", user_dtl.Rows[0]["user_id"].ToString());
                if (user_type == "FA")
                {
                    Message = Message.Replace("@@faculty_admin_remark", Get_Remark.Rows[0]["Student_FA_Remark"].ToString());
                    Message = Message.Replace("@@faculty_admin", Login_full_name.ToString());
                }

                if (user_type == "AC")
                {
                    Message = Message.Replace("@@Account_remark", Get_Remark.Rows[0]["Student_AC_Remark"].ToString());
                    Message = Message.Replace("@@Account", Login_full_name.ToString());
                }

                if (user_type == "exam")
                {
                    Message = Message.Replace("@@exam_remark", Get_Remark.Rows[0]["Student_Exam_Remark"].ToString());
                    Message = Message.Replace("@@exam", Login_full_name.ToString());
                }

                if (user_type == "A1")
                {
                    Message = Message.Replace("@@UGPG_Remark", Get_Remark.Rows[0]["Student_UGPG_Remark"].ToString());
                    Message = Message.Replace("@@UGPG", Login_full_name.ToString());
                }

                SmtpClient smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = port,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    Credentials = new System.Net.NetworkCredential(from_mail, from_password),
                    Timeout = 50000,
                };

                MailMessage mail = new MailMessage();
                mail.To.Add(ToAddress);

                if (user_type == "exam")
                {
                    mail.CC.Add(new MailAddress("examination@cept.ac.in"));
                }
                if (user_type == "AC")
                {
                    mail.CC.Add(new MailAddress("hansa.gohel@cept.ac.in"));
                }

                if (user_type == "A1")
                {
                    mail.CC.Add(new MailAddress("ug.office@cept.ac.in"));
                    mail.CC.Add(new MailAddress("pg.office@cept.ac.in"));
                }
                if (user_type == "FA")
                {
                    if (faculty_admin != null)
                    {
                        string[] ToMuliId = faculty_admin.Rows[0]["mail_id"].ToString().Split(',');
                        foreach (string ToEMailId in ToMuliId)
                        {
                            if (ToEMailId.Trim() != "dean" && ToEMailId.Trim() != "")
                            {
                                if (ToEMailId.Contains('@') == true)
                                {
                                    mail.CC.Add(new MailAddress(ToEMailId.Trim()));
                                }
                            }
                        }
                    }
                }

                mail.Subject = Subject;
                mail.From = new MailAddress(from_mail, "CEPT University");
                mail.IsBodyHtml = true;
                mail.Body = (Message);
                if (Current_Host != "localhost" && Current_Host != "104.211.138.53")
                {
                    smtp.Send(mail);
                }
                mail.Dispose();


            }
            catch (Exception ex)
            {

                return false;
            }
            return true;
        }
        #endregion
        public void HandleSmtpException(SmtpException smtpEx, string ToMail_gen, string FromMail_gen, string FromPassword_gen, string Subject_gen, string Message_body_gen, string CCMail_gen, string filePath_gen)
        {
            Masters objmaster = new Masters();
            bool status_data = objmaster.GetUpdateEmailtemplateContantData(ToMail_gen, FromMail_gen, FromPassword_gen, Subject_gen, Message_body_gen, CCMail_gen, filePath_gen);
            if (status_data)
            {
                Log.ExceptionLog("Data Save In Table SendMailDetails : " + status_data);
            }
            else
            {
                Log.ExceptionLog("Data Not Save In Table SendMailDetails : " + ToMail_gen + " " + FromMail_gen + " " + FromPassword_gen + " " + Subject_gen + " " + Message_body_gen + " " + CCMail_gen + " " + filePath_gen);
            }



            Log.ExceptionLog("SMTP Exception: " + smtpEx.Message);
            Log.ExceptionLog("SMTP StackTrace: " + smtpEx.StackTrace);
            Log.ExceptionLog("SMTP StatusCode: " + smtpEx.StatusCode.ToString());

            if (smtpEx.InnerException != null)
            {
                Log.ExceptionLog("SMTP InnerException: " + smtpEx.InnerException.Message);
                Log.ExceptionLog("SMTP Inner StackTrace: " + smtpEx.InnerException.StackTrace);
            }
        }
    }
}
