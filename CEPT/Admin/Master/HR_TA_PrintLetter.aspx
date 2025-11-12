<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HR_TA_PrintLetter.aspx.cs"
    Inherits="Admin_Master_HR_TA_PrintLetter" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <style type="text/css">
        .pg_font {
            font-size: 16px;
            line-height: 25px;
        }

        .mg_top {
            margin-top: 20px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            //$('table').css('font-size', '14px');
            //$('table tr td').css('line-height', '12px');

            if ($('.clsCourseTable').length == 3) {
                $('#p_pgbreak').css('display', 'block');
                //$('.mg_top').css('margin-top', '10px');
                //$('.mg_top').css('line-height', '23px');
                //$('#div_pg_title1').html($('#div_pg_title').html());
                $('.cls_p_pgbreak').eq(0).css('display', 'block');
            }
            else if ($('.clsCourseTable').length == 2) {
                $('#p_pgbreak2').css('display', 'block');
                //$('#div_pg_title2').html($('#div_pg_title').html());
                $('.cls_p_pgbreak').eq(0).css('display', 'block');
                //$('.cls_div_pgbreak').eq(0).html($('#div_pg_title').html());
            }
            else if ($('.clsCourseTable').length == 1) {
                $('#p_pgbreak3').css('display', 'block');
                //$('#div_pg_title3').html($('#div_pg_title').html());
                $('.cls_p_pgbreak').eq(0).css('display', 'block');
                //$('.cls_div_pgbreak').eq(0).html($('#div_pg_title').html());
            }

            $.get($('#img_signature').attr('src')).fail(function () { $('#div_signature').html(''); });
            $.get($('#img_signature_sdmehta').attr('src')).fail(function () { $('#div_signature_sdmehta').html(''); });

            $('#div_course_detail table tr td').css('padding', '4px');
            //$('#div_course_detail table tr td:first-child').css('width', '37%');
            //$('#div_course_detail table tr td:nth-child(2)').css('width', '12%');
        });
    </script>
</head>
<%--<body class="container">--%>
<%--<body style="margin:100px 70px 0px 70px;">--%>
<body style="margin: 12px 70px 0px 70px;" class="pg_font">
    <%--<div style="top: 20px; height: 120px; left: 1px;" title="" id="i22byht1">
        <a style="width: 372px; height: 120px; cursor: pointer;float:right;" href=""
            id="i22byht1link">
            <div id="i22byht1img" style="width: 372px; height: 120px; position: relative;">
                <img alt="" style="width: 372px; height: 120px; object-fit: cover;" src="../../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage"></div>
        </a>
    </div>--%>

    <span id="div_pg_title">CEPT/USO/F<asp:Label ID="lbl_short_dept" runat="server" ClientIDMode="Static"></asp:Label>/VFI/<asp:Label ID="lbl_month_year" runat="server" ClientIDMode="Static"></asp:Label>/<asp:Label ID="lbl_sr_no" runat="server" ClientIDMode="Static"></asp:Label><br />
        Date :
        <%--21/07/2016--%><asp:Label ID="lbl_date" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>
    </span>
    <br />
    <p class="pg_font mg_top">To</p>

    <h5 class="pg_font" style="margin-bottom: 0px;">
        <asp:Label ID="lbl_to_title" runat="server" ClientIDMode="Static"></asp:Label>&nbsp;
        <asp:Label ID="lbl_to_instructor_name" runat="server" ClientIDMode="Static"></asp:Label>
    </h5>

    <p class="pg_font" style="margin-top: 0px;">
        <asp:Label ID="lbl_address" runat="server" ClientIDMode="Static"></asp:Label></p>

    <h5 class="pg_font mg_top">Sub : Engagement as Teaching Assistant
        <asp:Label ID="lbl_sub_vfdesignation" runat="server" ClientIDMode="Static" Visible="false"></asp:Label>
        at Faculty of
        <asp:Label ID="lbl_sub_dept" runat="server" ClientIDMode="Static"></asp:Label>
    </h5>

    <h5 class="pg_font mg_top">Dear
        <asp:Label ID="lbl_title" runat="server" ClientIDMode="Static"></asp:Label>&nbsp;
        <asp:Label ID="lbl_instructor_name" runat="server" ClientIDMode="Static"></asp:Label>,
    </h5>

    <p class="mg_top" style="text-align: justify;">
        I am pleased to confirm your engagement as a Teaching Assistant
        <asp:Label ID="lbl_vfdesignation" runat="server" ClientIDMode="Static" Visible="false"></asp:Label>
        at Faculty of
        <asp:Label ID="lbl_dept" runat="server" ClientIDMode="Static"></asp:Label>,

        CEPT University, Ahmedabad for <b>Spring Semester 2021</b>. The Spring Semester 2021 begins on <b>4th January 2021</b> and ends with the close of exhibition on <b>8th May 2021</b>.
        Please see the calendar posted on CEPT website for details of juries & examinations.
    </p>

    <p style="text-align: justify;">
        This engagement will be subject to following terms and conditions effective from
        the date of joining on or before 4th January 2021.
    </p>

    <p style="text-align: justify;">
        The term of your engagement as a Teaching Assistant for&nbsp;<asp:Label ID="weeks" runat="server" ClientIDMode="Static"></asp:Label>&nbsp;weeks of the duration
        of the semester is as follows.
    </p>

    <h5 class="pg_font mg_top">Academic Responsibilities</h5>

    <p style="text-align: justify;">
        As a Teaching Assistant you will assist the course/studio faculty in teaching
        the studio/course unit for academic research, administration and logistical support as best as possible,
        you will adhere to published schedules and unit meeting
        times. In case you need to revise the published schedules, you will inform program
        chairs and students in advance of such changes.
        <br />
    </p>

    <p style="text-align: justify;">
        In case you find students not progressing through the exercises as per expectation, please identify possibilities of
        extra tutoring with the tutor and ensure that they are up to par and also inform the same to the concerned studio
        faculty. If students consistently fail to meet expected quantitative and qualitative standards of work, please notify the
        tutor at the earliest. You are expected to communicate clearly regarding the quality and quantity of work expected
        from students.
        <br />
    </p>

    <p style="text-align: justify;">
        You’ll be provided CEPT library membership for the engagement period.
        <br />
    </p>

    <p style="text-align: justify;">
        As a Teaching Assistant,, you are expected to avoid conflict of commitment.
        Conflict of commitment will arise when the Teaching Assistant, engages outside CEPT University
        that interferes in the primary commitment to CEPT University.
    </p>

    <h5 class="pg_font mg_top">Course and Payment Details</h5>

    <div id="div_course_detail" runat="server">
        <table class="table table-bordered">
            <tr>
                <td><b>Course Code</b></td>
                <td></td>
                <td><b>Course Name</b></td>
                <td colspan="3"></td>
            </tr>
            <tr>
                <td><b>Course Type</b></td>
                <td></td>
                <td><b>Course Credits</b></td>
                <td></td>
                <td><b>Contact Hours per week</b></td>
                <td></td>
            </tr>
            <tr>
                <td><b>Preparatory Hours per week</b></td>
                <td></td>
                <td><b>Total no. of Hours per week</b></td>
                <td></td>
                <td><b>Total no. of weeks(semester)</b></td>
                <td></td>
            </tr>
            <tr>
                <td><b>Hours for remuneration</b></td>
                <td></td>
                <td><b>Hourly Rate</b></td>
                <td></td>
                <td><b>Total</b></td>
                <td></td>
            </tr>
        </table>
    </div>

    <h5 class="pg_font mg_top">Professional Fees</h5>

    <p style="text-align: justify;">
        Your total Professional Fees for the duration of semester shall
        be as mentioned above. It will be paid in equal installments as per the payment framework
        decided by the Faculty Dean/Director. The last installment will be subject to completion
        of all contractual obligations and approval of Dean/Director.
    </p>
    <p style="text-align: justify;">
        The payment will be directly credited to your bank account after deduction of TDS
        as applicable from time to time.
    </p>
    <p style="text-align: justify;">
        Please note that your above Professional Fees does not include GST.
        In case you have registered for GST and need to be paid GST, you will need to submit
        invoice as per GST regulations in hard copy to faculty admin by 20th of the month,
        and the University will make payment by 12th of the subsequent month (E.g. please submit invoice on 20 Feb 2021 for payment to be made on 12 Mar 2021).
    </p>


    <h5 class="pg_font mg_top">Work Schedule</h5>

    <p style="text-align: justify;">
        You will be expected to adhere your work schedules and rules and regulations of CEPT University.
        You are further required to mark your attendance through bio metrics system.
        Please note that once you have accepted this letter, you are required to complete the engagement and cannot leave any time during the semester. 
        If you leave the engagement/ assignment before completion, you will not be considered for any further engagement in any of the roles / jobs  at CEPT University.
    </p>

    <h5 class="pg_font mg_top">Reporting</h5>



    <p style="text-align: justify;">You will report to the Faculty Dean/Director for all matters.</p>



    <h5 class="pg_font mg_top">Standard of Ethics</h5>

    <p style="text-align: justify;">
        You are expected to ensure the veracity of all the details and documents submitted
        by you at the time of engagement. If it is found at any stage that the details /
        documents submitted by you are incorrect, you will be asked for clarification and
        if found unsatisfactory, your engagement will be cancelled without notice.
    </p>

    <h5 class="pg_font mg_top">Intellectual Property</h5>

    <p style="text-align: justify;">
        You agree that all work produced by you, and by your students as part of the studio/course
        taught by you falls within the ambit of prevailing CEPT University Intellectual
        Property Policy.
    </p>
    <p id="p_pgbreak" style="page-break-before: always; display: none;">&nbsp;</p>
    <div id="div_pg_title1"></div>

    <h5 class="pg_font mg_top">General</h5>

    <p style="text-align: justify;">
        In the event of any dispute, Ahmedabad jurisdiction would prevail.
    </p>
    <br />
    <p style="text-align: justify;">
        You will be covered by the service rules and regulations including good conduct,
        discipline and administrative orders and any such other rules or orders of the CEPT
        University that may come in force from time to time.
    </p>

    <h5 class="pg_font mg_top">IT Policy</h5>

    <p style="text-align: justify;">
        Staff members agree to conduct themselves within the ambits of CEPT IT policy in
        force. Staff members agree that only software with appropriate licenses will be
        installed and/or used and/or stored on their computer systems/tablets/mobile phones
        allotted to them and in their control, or on their personal devices which use any
        University resources. Any liability arising out of any unauthorized usage will solely
        be of the staff member, and not of the university. The university may take appropriate
        actions against staff member found violating CEPT IT Policy.
    </p>
    <p id="p_pgbreak2" style="page-break-before: always; display: none;">&nbsp;</p>
    <div id="div_pg_title2"></div>
    <p style="text-align: justify;">
        You are requested to reply with the signed copy of the letter as an acceptance of
        your engagement within one week from the date of issue of this engagement letter.
        In case we do not receive same from your end, after one week, we will move ahead
        with the understanding that terms of your engagement are acceptable to you and you
        have accepted your engagement at CEPT University. However, your payment will be
        subject to your signing of your engagement letter and submitting the same.
    </p>


    <p class="mg_top" style="text-align: justify;">
        Thanks again. We look forward to your association with CEPT University.
    </p>
    <p class="mg_top" style="margin-bottom: 0px;">Sincerely,</p>
    <%--<br /><br />--%>
    
    <div style="width: 60.2%; float: left;">
        <div id="div_signature" style="height: 55px;">
            <%--<img alt="" src="../../image/signature_FT.jpg" style="height:55px;"/>--%>
            <%--<img alt="" src="../../image/signature_FM.png" style="height:55px;"/>--%>
            <img alt="" src="" style="height: 55px;" id="img_signature" runat="server" />
        </div>

        <p style="margin-bottom: 0px;">
            <asp:Label ID="lbl_sincerely_professor" runat="server" ClientIDMode="Static"></asp:Label></p>
        <p style="margin-bottom: 0px; margin-top: 0px;">
            <asp:Label ID="lbl_sincerely_dean_director" runat="server" ClientIDMode="Static"></asp:Label></p>
        <p style="margin-bottom: 0px; margin-top: 0px;">
            <asp:Label ID="lbl_sincerely_dean_dept" runat="server" ClientIDMode="Static"></asp:Label></p>
    </div>

    <div style="width: 80%;">
        <div id="div_signature_sdmehta" style="height: 55px;">
            <img alt="" src="../../image/SDMehtaSign.jpg?t=1" style="height: 55px;" id="img_signature_sdmehta" runat="server" />
        </div>
        <p style="margin-bottom: 0px;">
            <asp:Label ID="lbl_sincerely_sdmehta" runat="server" ClientIDMode="Static">S D Mehta</asp:Label>
        </p>
        <p style="margin-bottom: 0px; margin-top: 0px;">
            <asp:Label ID="lbl_sincerely__sdmehta" runat="server" ClientIDMode="Static">Chief HR Officer</asp:Label>
        </p>
        <p style="margin-bottom: 0px; margin-top: 0px;">
            <asp:Label ID="lbl_place" runat="server" ClientIDMode="Static">CEPT University</asp:Label>
        </p>
    </div>

    <br />
    <br />

    <h5 class="pg_font mg_top">Contact Details:</h5>

    <div id="div_prog_coordinator" runat="server"></div>
</body>
</html>
