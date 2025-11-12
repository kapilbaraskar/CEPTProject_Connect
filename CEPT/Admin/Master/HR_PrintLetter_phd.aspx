<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HR_PrintLetter_phd.aspx.cs" Inherits="Admin_Master_HR_PrintLetter_phd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <style type="text/css">
        .pg_font
        {
            font-size: 16px;
            line-height: 25px;
        }
        .mg_top
        {
            margin-top: 20px;
        }
        #div_annexure p
        {
            margin-bottom:4px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            if ($('.clsCourseTable').length == 3) {
                $('#p_pgbreak').css('display', 'block');
                $('.cls_p_pgbreak').eq(0).css('display', 'block');
            }
            else if ($('.clsCourseTable').length == 2) {
                $('#p_pgbreak2').css('display', 'block');
                $('.cls_p_pgbreak').eq(0).css('display', 'block');
            }
            else if ($('.clsCourseTable').length == 1) {
                $('#p_pgbreak3').css('display', 'block');
                $('.cls_p_pgbreak').eq(0).css('display', 'block');
            }

            $.get($('#img_signature').attr('src')).fail(function () { $('#div_signature').html(''); });

            $('#div_course_detail table tr td').css('padding', '4px');
            $(".colspan").css('padding', '0px');
            $(".one").css('width', '50%');
            $(".one1").css('width', '50%');
            $(".two").css('width', '25%');
            $(".two2").css('width', '25%');
            $(".three").css('width', '25%');
            $(".three3").css('width', '8.33%');
        });
    </script>
</head>
<body style="margin: 12px 70px 0px 70px;" class="pg_font">
    <span id="div_pg_title">CEPT/USO/D<asp:Label ID="lbl_short_dept" runat="server" ClientIDMode="Static"></asp:Label>-DO/VFI/<asp:Label
        ID="lbl_month_year" runat="server" ClientIDMode="Static"></asp:Label>/<asp:Label
            ID="lbl_sr_no" runat="server" ClientIDMode="Static"></asp:Label><br />
        Date : 
        <%--21/07/2016--%><asp:Label ID="lbl_date" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>
    </span>
    <br />
    <p class="pg_font mg_top">
        To</p>
    <h5 class="pg_font" style="margin-bottom: 0px;">
        <asp:Label ID="lbl_to_title" runat="server" ClientIDMode="Static"></asp:Label>&nbsp;
        <asp:Label ID="lbl_to_instructor_name" runat="server" ClientIDMode="Static"></asp:Label>
    </h5>
    <p class="pg_font" style="margin-top: 0px;">
        <asp:Label ID="lbl_address" runat="server" ClientIDMode="Static"></asp:Label>
    </p>
    <h5 class="pg_font mg_top">
        Sub : Engagement as Visiting Faculty at Doctoral Program
        <span style="display:none;">Faculty <asp:Label ID="lbl_sub_vfdesignation" runat="server" ClientIDMode="Static" Visible="false"></asp:Label>at Faculty of
        <asp:Label ID="lbl_sub_dept" runat="server" ClientIDMode="Static"></asp:Label></span>
    </h5>
    <h5 class="pg_font mg_top">
        Dear
        <asp:Label ID="lbl_title" runat="server" ClientIDMode="Static"></asp:Label>&nbsp;
        <asp:Label ID="lbl_instructor_name" runat="server" ClientIDMode="Static"></asp:Label>,
    </h5>
    <p class="mg_top" style="text-align: justify;display:none;">
        I am pleased to confirm your appointment as a visiting faculty / studio tutor
        <asp:Label ID="lbl_vfdesignation" runat="server" ClientIDMode="Static" Visible="false"></asp:Label>
        at Faculty of
        <asp:Label ID="lbl_dept" runat="server" ClientIDMode="Static"></asp:Label>,
        CEPT University, Ahmedabad for <b>Monsoon Semester 2020</b>. The Monsoon Semester
        2020 begins on <b>27th July 2020</b> and ends with the close of exhibition on <b>5th December 2020</b>.
        Please see the calendar posted on CEPT website for details of juries & examinations.
    </p>
    <p>
        We are pleased to invite you as Visiting Faculty at Doctoral Program and welcome you to be a part of CEPT University for the Monsoon Semester 2020.
        The Monsoon Semester 2020 begins on <b>27th July 2020</b> and ends on <b>5th December 2020</b>. 
        We will share with you the academic calendar (PG courses) for details of juries & examinations at the University.
    </p>
    <p>
        Please see below course and payment details. (Also enclosed is an annexure as provided by the University Staff Office).
    </p>

    <h5 class="pg_font mg_top">Course and Payment Details</h5>
    <div id="div_course_detail" runat="server"></div>

    <p class="mg_top" style="text-align: justify;">
        You are kindly requested to send us a signed copy of this letter as a token of your acceptance of the engagement with the Doctoral Program.
    </p>
    <p>Looking forward to a fruitful association.</p>
    <p class="mg_top" style="margin-bottom: 0px;">Sincerely,</p>

    <div id="div_signature" style="height: 55px;">
        <img alt="" src="" style="height: 55px;" id="img_signature" runat="server" />
    </div>

    <p style="margin-bottom: 0px;"><asp:Label ID="lbl_sincerely_professor" runat="server" ClientIDMode="Static"></asp:Label></p>
    Head, Doctoral office
    <p style="margin-bottom: 0px; margin-top: 0px;display:none;"><asp:Label ID="lbl_sincerely_dean_dept" runat="server" ClientIDMode="Static"></asp:Label></p>

    <h5 class="pg_font mg_top">Contact Details:</h5>
    <div id="div_prog_coordinator" runat="server"></div>

    <p id="p_pgbreak3" style="page-break-before: always;">&nbsp;</p>

    <div id="div_annexure">
        <p style="text-decoration:underline;font-weight:bold;">ANNEXURE: RULES AND RESPONSIBILITIES</p>

        <p style="font-weight:bold;">PART A: ACADEMIC RESPONSIBILITIES</p>

        <p>As a Visiting Faculty, you will lead the teaching of the Studio/Course unit including setting up of the various exercises and design problems, tutoring students in improving their abilities, and evaluating student work and output. You are requested to work with the Program Chair to finalize course details, schedule sessions and other logistics of delivery. As best as possible, kindly adhere to published schedules and unit meeting times. In case you need to revise the published schedules, please inform the Program Chair and students in advance.</p>

        <p>In case you find students not progressing through the exercises as per expectation, please identify possibilities of extra tutoring or working with the TA to ensure that they are brought at par. If students consistently fail to meet expected quantitative and qualitative standards of work, please notify them in writing at the earliest.  Tutors are requested to apprise the students regarding the quality and quantity of work expected from them.</p>

        <p>In case you need assistance with respect to specific questions like use of certain pedagogic tools or evaluation methods, please feel free to contact theProgram Chair.</p>

        <p>You will be provided CEPT library membership for the engagement period.</p>

        <p>Being a Visiting Faculty at CEPT is a significant commitment. To foster a deeper involvement with the university, you are expected to place CEPT University's interests above all else while engaging in academic activities. You are requested to abide by all rules and regulations of the University.</p>

        <p style="font-weight:bold;">PART B: GENERAL TERMS</p>

        <p style="font-weight:bold;"><%--Remuneration--%>Professional Fees</p>

        <p>Your total <%--remuneration (--%>Professional Fees<%--)--%> for the duration of semester shall be as mentioned above. Please contact your faculty admin staff member for schedule of payment. Please note that the last installment will be subject to completion of all contractual obligations and approval of Dean/Director.Please also note that your payment will be subject to your signing of your engagement letter (this letter) and submitting the same to the faculty admin.The payment will be directly credited to your bank account after deduction of TDS as applicable from time to time.</p>
    
        <p>Please note that your above <%--remuneration (--%>Professional Fees<%--)--%> does not include GST. In case you are registered under GST regulation and need to be paid GST, you will need to submit invoice as per GST regulations in hard copy to faculty admin by 20th of the month, and the University will make payment by 12th of the subsequent month (E.g. please submit invoice on 20 Aug 2020 for payment to be made on 12­ Sep 2020).</p>

        <p style="font-weight:bold;">Reporting</p>

        <p>You are requested to report to the Faculty Dean/ Director of Program (as applicable) for all matters.</p>

        <p style="font-weight:bold;">Standard of Ethics</p>

        <p>Visiting faculty members are expected to ensure veracity of all the details and documents submitted by them at the time of engagement. If it is found at any stage that the details / documents submitted by you are incorrect, you will be asked for clarification. If your clarification is found unsatisfactory, your engagement will be cancelled.</p>

        <p style="font-weight:bold;">Jurisdiction</p>

        <p>In the event of any dispute, Ahmedabad jurisdiction would prevail.</p>

        <p style="font-weight:bold;">IT Policy</p>

        <p>As a visiting faculty, you agree to conduct yourself within the ambits of prevailing CEPT IT policy. You agree that only software with appropriate licenses will be installed and/or used and/or stored on your computer systems allotted to you and/or in your control, or on your personal devices which use any University resources. Any liability arising out of any unauthorized usage will solely be of the visiting faculty, and not of the University. The University may take appropriate actions against visiting faculty found violating CEPT IT Policy.</p>
    </div>
</body>
</html>
