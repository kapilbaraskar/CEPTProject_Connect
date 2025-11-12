using System;
using System.Data;
using System.Web;
using System.Net.Mail;

using BLL.Master;
using System.Collections.Generic;
using BLL.Utilities1;

namespace BLL.ExtraUtilities1
{
    public class Mail : ServerBase
    {
        #region Variable Declaration
        static String fromEmail = "donotreply@cept.ac.in";
        static String fromEmailPHDReferee = "phd.admission@cept.ac.in";
        static String mailPassword = "vyujpnmbkllqrujz";  //cept2014

        String msgBody = String.Empty;
        String Host = HttpContext.Current.Request.Url.ToString();
        Log objServerLog = new Log();
        #endregion

        #region Constructor & Destructor.
        public Mail()
        {
        }

        ~Mail()
        {
            if (DBConnection != null)
            {
                if (DBConnection.State == ConnectionState.Open) DBConnection.Close();
            }
        }
        #endregion

        #region Send Mail for Varification Code (Used in Registration Page)
        public String sendVarificationCodeToUser(string EmailId, string UserName, string FirstName, string verificationCode)
        {
            #region Make Varification
            String VarificationLink = Host.Substring(0, Host.LastIndexOf('/'));
            VarificationLink = VarificationLink.Substring(0, VarificationLink.LastIndexOf('/') + 1) + "Pages/EmailVerify.aspx?";
            VarificationLink += "UN=" + (UserName);
            VarificationLink += "&VT=" + (verificationCode);
            #endregion

            String Message = "";
            String Subject = "";

            Subject = "Welcome to CEPT!";

            Message = "Dear " + FirstName + ",<br/><p>Welcome! Your account has been created. By clicking on the following button, please verify your account and complete your admission details.</p>";
            Message += "<div style=\"text-align:center; padding:10px 0 10px 0;\"><a href=" + VarificationLink + " style=\"background:#337BC4; color:#fff; text-decoration:none; font-size:13px; display:inline-block; padding:10px;\">Validate Email</a></div>";
            Message += "<br /><p>Sincerely,<br />-- CEPT</p>";

            SmtpClient smtp = new SmtpClient
            {
                Host = "smtp.gmail.com", // smtp server address here...
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new System.Net.NetworkCredential(fromEmail, mailPassword),
                Timeout = 50000,
            };

            MailMessage mail = new MailMessage();
            mail.To.Add(EmailId);
            mail.Subject = Subject;
            mail.From = new MailAddress(fromEmail, "CEPT");
            mail.IsBodyHtml = true;
            mail.Body = (Message);

            smtp.Send(mail);

            return "success";
        }
        #endregion

        #region Send Mail for its Acknowledgement Receipt
        //public String SendMailAck(string UserId, string filepath, string AdminEmailID, string Password, string MailNote)
        //{

        //    //GetMasterDetails objGetMasterDetails = new GetMasterDetails();
        //    clsRegistration objRegistration = new clsRegistration();

        //    Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
        //    ObjParam.Add("user_id", UserId);

        //    //Get Personal Details
        //    DataTable dtPersonalDtls = objRegistration.GetApplicantDetails(ObjParam);

        //    String Message = "";
        //    String Subject = "";

        //    Subject = "Acknowledgement for CEPT Admission";

        //    Message = "Dear, " + dtPersonalDtls.Rows[0]["first_name"].ToString() + dtPersonalDtls.Rows[0]["last_name"].ToString();
        //    Message += "<br /><p>Thanks for your application in CEPT University.</p>";
        //    Message += "<br /><p>Please find attached Admit Card along with this Email Id</p>";

        //    if (MailNote != string.Empty && MailNote != null)
        //    {
        //        Message += "<b>" + MailNote + "</b>";
        //    }

        //    Message += "<br /><p>Sincerely,<br />-- CEPT University</p>";

        //    SmtpClient smtp = new SmtpClient
        //    {
        //        Host = "smtp.gmail.com", // smtp server address here...
        //        Port = 587,
        //        EnableSsl = true,
        //        DeliveryMethod = SmtpDeliveryMethod.Network,
        //        Credentials = new System.Net.NetworkCredential(AdminEmailID, Password),
        //        Timeout = 50000,
        //    };

        //    MailMessage mail = new MailMessage();
        //    mail.To.Add(dtPersonalDtls.Rows[0]["email_id"].ToString());
        //    mail.Subject = Subject;
        //    mail.From = new MailAddress(AdminEmailID, "CEPT");
        //    mail.IsBodyHtml = true;
        //    mail.Body = (Message);

        //    if (filepath != string.Empty)
        //    {
        //        var attachment = new Attachment(filepath);
        //        mail.Attachments.Add(attachment);
        //    }

        //    smtp.Send(mail);

        //    return "success";
        //}
        #endregion

        #region Send Mail for Reject Application Remark
        //public String SendMailRejectRemark(string UserId, string remark, string mailmsg, string AdminEmailID, string Password)
        //{
        //    clsRegistration objRegistration = new clsRegistration();

        //    Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
        //    ObjParam.Add("user_id", UserId);

        //    //Get Personal Details
        //    DataTable dtPersonalDtls = objRegistration.GetApplicantDetails(ObjParam);

        //    String Message = "";
        //    String Subject = "";

        //    Subject = "Remarks for CEPT Admission";

        //    Message = "Dear, " + dtPersonalDtls.Rows[0]["first_name"].ToString() + dtPersonalDtls.Rows[0]["last_name"].ToString();
        //    Message += "<br /> " + mailmsg;
        //    Message += "<br /> " + remark;
        //    Message += "<br /><p>Sincerely,<br />-- CEPT University</p>";

        //    SmtpClient smtp = new SmtpClient
        //    {
        //        Host = "smtp.gmail.com", // smtp server address here...
        //        Port = 587,
        //        EnableSsl = true,
        //        DeliveryMethod = SmtpDeliveryMethod.Network,
        //        Credentials = new System.Net.NetworkCredential(AdminEmailID, Password),
        //        Timeout = 50000,
        //    };

        //    MailMessage mail = new MailMessage();
        //    mail.To.Add(dtPersonalDtls.Rows[0]["email_id"].ToString());
        //    mail.Subject = Subject;
        //    mail.From = new MailAddress(AdminEmailID, "CEPT");
        //    mail.IsBodyHtml = true;
        //    mail.Body = (Message);

        //    smtp.Send(mail);

        //    return "success";
        //}
        #endregion

        #region Send Mail for Reset Password (Used in Forgot Password Page)
        public String SendEmailForResetPassword(string EmailId, string UserId, string FirstName)
        {
            #region Make Varification
            String VarificationLink = Host.Substring(0, Host.LastIndexOf('/'));
            VarificationLink = VarificationLink.Substring(0, VarificationLink.LastIndexOf('/') + 1) + "Pages/ResetPassword.aspx?";
            VarificationLink += "UN=" + (UserId);
            #endregion

            String Message = "";
            String Subject = "";

            Subject = "Reset Password";

            Message = "Dear " + FirstName + ",<br/><p>By clicking on the following button, you can reset your password.</p>";
            Message += "<div style=\"text-align:center; padding:10px 0 10px 0;\"><a href=" + VarificationLink + " style=\"background:#337BC4; color:#fff; text-decoration:none; font-size:13px; display:inline-block; padding:10px;\">Reset Password</a></div>";
            Message += "<br /><p>Sincerely,<br />-- CEPT</p>";

            SmtpClient smtp = new SmtpClient
            {
                Host = "smtp.gmail.com", // smtp server address here...
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new System.Net.NetworkCredential(fromEmail, mailPassword),
                Timeout = 50000,
            };

            MailMessage mail = new MailMessage();
            mail.To.Add(EmailId);
            mail.Subject = Subject;
            mail.From = new MailAddress(fromEmail, "CEPT");
            mail.IsBodyHtml = true;
            mail.Body = (Message);

            smtp.Send(mail);

            return "success";
        }
        #endregion

        #region Send Mail to Recommender for PHD Recommedation Form
        //public String SendMailToRecommender(string UserId, string RecommenderEmailId, string RecommenderDisplayName, string CourseId, string ReferenceNo)
        //{
        //    #region Make Varification String
        //    String RecommendationLink = Host.Substring(0, Host.LastIndexOf('/'));
        //    RecommendationLink = RecommendationLink.Substring(0, RecommendationLink.LastIndexOf('/') + 1) + "Pages/RecommendationLetter.aspx?";
        //    RecommendationLink += "UserId=" + UserId;
        //    RecommendationLink += "&CourseId=" + CourseId;
        //    RecommendationLink += "&ReferenceNo=" + ReferenceNo;
        //    #endregion

        //    GetMasterDetails objGetMasterDetails = new GetMasterDetails();
        //    string ProgramCoursedesc = "";
        //    string Username = "";
        //    string Gender = "";
        //    string Gender1 = "";

        //    //Get Program course description
        //    DataTable dt = objGetMasterDetails.GetProgramCourseDetails(CourseId);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        ProgramCoursedesc = dt.Rows[0]["program_course_desc"].ToString().ToUpper();
        //    }

        //    Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
        //    ObjParam.Add("user_id", HttpContext.Current.Session["UserId"].ToString());

        //    //Get Personal Details
        //    DataTable dtPersonalDtls = objGetMasterDetails.GetCandidatePersonalDetails(ObjParam);

        //    if (dtPersonalDtls != null && dtPersonalDtls.Rows.Count > 0)
        //    {
        //        Username = dtPersonalDtls.Rows[0]["first_name"].ToString().ToUpper();
        //        if (dtPersonalDtls.Rows[0]["gender"].ToString() == "M")
        //        {
        //            Gender = "He";
        //            Gender1 = "his";
        //        }
        //        else if (dtPersonalDtls.Rows[0]["gender"].ToString() == "F")
        //        {
        //            Gender = "She";
        //            Gender1 = "her";
        //        }
        //        else
        //        {
        //            Gender = "He/She";
        //            Gender1 = "his/her";
        //        }
        //    }

        //    String Message = "";
        //    String Subject = "";

        //    Subject = "Recommendation Letter for Ph.D";

        //    Message = "Dear " + RecommenderDisplayName + ",<br/><p>" + Username + " has applied for " + ProgramCoursedesc + " at CEPT University.</p><br/>";
        //    Message += "<p> " + Gender + " has requested you to give " + Gender1 + " reference.</p>";
        //    Message += "Please give your feedback on " + Username + " by clicking the button 'Fill Recommendation'";
        //    Message += "<div style=\"text-align:center; padding:10px 0 10px 0;\"><a href=" + RecommendationLink + " style=\"background:#337BC4; color:#fff; text-decoration:none; font-size:13px; display:inline-block; padding:10px;\">Fill Recommendation</a></div>";
        //    Message += "<br /><p>Sincerely,<br />-- CEPT University</p>";

        //    SmtpClient smtp = new SmtpClient
        //    {
        //        Host = "smtp.gmail.com", // smtp server address here...
        //        Port = 587,
        //        EnableSsl = true,
        //        DeliveryMethod = SmtpDeliveryMethod.Network,
        //        Credentials = new System.Net.NetworkCredential(fromEmailPHDReferee, mailPassword),
        //        Timeout = 50000,
        //    };

        //    MailMessage mail = new MailMessage();
        //    mail.To.Add(RecommenderEmailId);
        //    mail.Subject = Subject;
        //    mail.From = new MailAddress(fromEmailPHDReferee, "CEPT");
        //    mail.IsBodyHtml = true;
        //    mail.Body = (Message);

        //    smtp.Send(mail);

        //    return "success";
        //}
        #endregion

        #region Send Mail to Recommender for PHD Recommedation Form (By Admin Screen)
        //public String SendMailToRecommenderByAdmin(string ApplicantUserId, string EncryptedUserId, string RecommenderEmailId, string RecommenderDisplayName, string CourseId, string ReferenceNo)
        //{
        //    #region Make Varification String
        //    String RecommendationLink = Host.Substring(0, Host.LastIndexOf('/'));
        //    RecommendationLink = RecommendationLink.Substring(0, RecommendationLink.LastIndexOf('/') + 1) + "Pages/RecommendationLetter.aspx?";
        //    RecommendationLink += "UserId=" + EncryptedUserId;
        //    RecommendationLink += "&CourseId=" + CourseId;
        //    RecommendationLink += "&ReferenceNo=" + ReferenceNo;
        //    #endregion

        //    GetMasterDetails objGetMasterDetails = new GetMasterDetails();
        //    string ProgramCoursedesc = "";
        //    string Username = "";
        //    string Gender = "";
        //    string Gender1 = "";

        //    //Get Program course description
        //    DataTable dt = objGetMasterDetails.GetProgramCourseDetails(CourseId);
        //    if (dt != null && dt.Rows.Count > 0)
        //    {
        //        ProgramCoursedesc = dt.Rows[0]["program_course_desc"].ToString().ToUpper();
        //    }

        //    Dictionary<String, Object> ObjParam = new Dictionary<String, Object>();
        //    ObjParam.Add("user_id", ApplicantUserId);

        //    //Get Personal Details
        //    DataTable dtPersonalDtls = objGetMasterDetails.GetCandidatePersonalDetails(ObjParam);

        //    if (dtPersonalDtls != null && dtPersonalDtls.Rows.Count > 0)
        //    {
        //        Username = dtPersonalDtls.Rows[0]["first_name"].ToString().ToUpper();
        //        if (dtPersonalDtls.Rows[0]["gender"].ToString() == "M")
        //        {
        //            Gender = "He";
        //            Gender1 = "his";
        //        }
        //        else if (dtPersonalDtls.Rows[0]["gender"].ToString() == "F")
        //        {
        //            Gender = "She";
        //            Gender1 = "her";
        //        }
        //        else
        //        {
        //            Gender = "He/She";
        //            Gender1 = "his/her";
        //        }
        //    }

        //    String Message = "";
        //    String Subject = "";

        //    Subject = "Recommendation Letter for Ph.D";

        //    Message = "Dear " + RecommenderDisplayName + ",<br/><p>" + Username + " has applied for " + ProgramCoursedesc + " at CEPT University.</p><br/>";
        //    Message += "<p> " + Gender + " has requested you to give " + Gender1 + " reference.</p>";
        //    Message += "Please give your feedback on " + Username + " by clicking the button 'Fill Recommendation'";
        //    Message += "<div style=\"text-align:center; padding:10px 0 10px 0;\"><a href=" + RecommendationLink + " style=\"background:#337BC4; color:#fff; text-decoration:none; font-size:13px; display:inline-block; padding:10px;\">Fill Recommendation</a></div>";
        //    Message += "<br /><p>Sincerely,<br />-- CEPT University</p>";

        //    SmtpClient smtp = new SmtpClient
        //    {
        //        Host = "smtp.gmail.com", // smtp server address here...
        //        Port = 587,
        //        EnableSsl = true,
        //        DeliveryMethod = SmtpDeliveryMethod.Network,
        //        Credentials = new System.Net.NetworkCredential(fromEmailPHDReferee, mailPassword),
        //        Timeout = 50000,
        //    };

        //    MailMessage mail = new MailMessage();
        //    mail.To.Add(RecommenderEmailId);
        //    mail.Subject = Subject;
        //    mail.From = new MailAddress(fromEmailPHDReferee, "CEPT");
        //    mail.IsBodyHtml = true;
        //    mail.Body = (Message);

        //    smtp.Send(mail);

        //    return "success";
        //}
        #endregion

        #region Send Mail to Referee, Applicant and Admin for Submitting Details of Referee (By Referee - Submitting Recommendation Details)
        public String SendMailForReferenceAcknowledgement(string ApplicantEmailId, string RefereeEmailId, string ApplicantFullName, string RefereeFullName, string AdminEmailId)
        {
            string ToAddress = ApplicantEmailId + "," + RefereeEmailId + "," + AdminEmailId;

            String Message = "";
            String Subject = "";

            Subject = "Acknowledgement of Reference Letter";

            Message = "This is to acknowledge the reference letter uploaded by " + RefereeFullName + " for the applicant " + ApplicantFullName + " for Doctoral Program at CEPT University.";

            SmtpClient smtp = new SmtpClient
            {
                Host = "smtp.gmail.com", // smtp server address here...
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                Credentials = new System.Net.NetworkCredential(fromEmailPHDReferee, mailPassword),
                Timeout = 50000,
            };

            MailMessage mail = new MailMessage();
            mail.To.Add(ToAddress);
            mail.Subject = Subject;
            mail.From = new MailAddress(fromEmailPHDReferee, "CEPT");
            mail.IsBodyHtml = true;
            mail.Body = (Message);

            smtp.Send(mail);

            return "success";
        }
        #endregion
    }
}