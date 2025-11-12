<%@ Page Title="Feedback Form - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="Student_Feedback_form.aspx.cs" Inherits="Student_Student_Feedback_form" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Js_WS/feedbackform.js" type="text/javascript"></script>
    <script src="../Js_WS/google_analytics_code.js" type="text/javascript"></script>
    
    <style>
        .row_selected tr
        {
            background-color: Red;
        }
        .table_header
        {
            background-image: none !important;
            background-color: #2283c5 !important;
            color: #FFF !important;
            text-shadow: 0 -1px 0 rgba(0,0,0,0.25) !important;
            font-size: 16px;
        }
        . table_td_width
        {
            width: 57px;
        }
    </style>
        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 25%; float: left; display: none">
        <div style="margin-left: 25px" class="col-xs-12">
            <p>
                <input type="hidden" id="course_code" />
                <input type="hidden" id="course_type" />
                <h5>
                    Select Your Course</h5>
            </p>
        </div>
        <div id="datalist_saved" style="display: none;">
            <table cellpadding="0" cellspacing="0" border="0" id="datatable_saved" class="display table table-striped table-bordered table-hover"
                width="100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    <div id="divlecture" class="row-fluid" style="font-family: Calibri; font-size: 16px;
        display: none">
        <div class="tab-content" style="width: 98%; float: right">
            <div class="page-header position-relative">
                <h1 align="center">
                    Student Feedback Form</h1>
                <h1 align="center">
                    <span style="display: none; font-size: 22px" class="lblclass"></span>
                </h1>
                <h1 align="center">
                    <span style="font-size: 22px" id="course_type_name"></span>
                </h1>
            </div>
            <%--<div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i> CEPT Student Feedback Form - LECTURE Course
                                </h4>
                            </div>--%>
          <p>
                Thank you for taking the time to complete
                the student feedback form. At CEPT University, student feedback is a very important
                resource for assessing and improving the quality of teaching and learning.
            </p>
            <p>
                Please provide reasoned opinions to the
                following questions.
            </p>
            <p>
                The summary of responses will be shared
                with the course instructors after the final grades are published.
            </p>
            <p>
                Your identity will be kept confidential.</p>
            <p>
                Your feedback is very valuable.
            </p>
            <br />
          <%--  <p>
                <b>Please select the appropriate box</b></p>
            <br />--%>
            
            <p><b>1. Feedback : Course</b></p>
            <div id="divcourse">
                <table id="course_lecture" border="1" cellspacing="0" cellpadding="0" class="display table table-striped table-bordered table-hover ">
                    <thead>
                        <tr class="table_header">
                            <%--    <td style="padding-top: 20px;" align="center" valign="middle">
                                <center>
                                    <b>Course related Feedback</b></center>
                            </td>--%>
                            <td style='padding-top: 20px;' align='center' rowspan="2">
                               <b> Sr No. </b>
                            </td>
                            <td rowspan="2" style="padding-top: 20px;" align="center" valign="middle">
                           
                             <b>    Your answers to questions 1-6 will be useful for assessing the value of this course.</b>
                                <br />
                               <b>  Instructor evaluation is given separately.</b>
                                
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Neutral</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
                            <%--   <td valign="top">
                                <p>
                                    <b>Not Applicable</b></p>
                            </td>--%>
                        </tr>
                        <tr class="table_header">
                            <td style="text-align: center;">
                                5
                            </td>
                            <td style="text-align: center;">
                                4
                            </td>
                            <td style="text-align: center;">
                                3
                            </td>
                            <td style="text-align: center;">
                                2
                            </td>
                            <td style="text-align: center;">
                                1
                            </td>
                            <%-- <td>
                            </td>--%>
                        </tr>
                    </thead>
                    <tbody>
                        
                    </tbody>
                </table>
            </div>
            
            <p>
                <br />
                <b>Please write your comments about the course :</b></p>
            <table cellpadding="0" cellspacing="0" style="width: 100%">
                <tbody>
                    <tr>
                        <td>
                            <div class="control-group">
                                <div>
                                    <textarea id="txt_course_instruction" style="width: 99%; height: 110px" rows="3"
                                        cols="50" name="address"></textarea>
                                </div>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <p class="instructor_feedback_lable">
                <br />
                <b>2. Feedback : Instructor </b>
            </p>
            <div id="div_lecture">
                
            </div>
            
           
            <p><b>3. Feedback : Overall Summer Winter School</b></p>
            <div id="div_overall">
                <table id="tbl_overall" border="1" cellspacing="0" cellpadding="0" class="display table table-striped table-bordered table-hover ">
                    <thead>
                        <tr class="table_header">
                            <%--    <td style="padding-top: 20px;" align="center" valign="middle">
                                <center>
                                    <b>Course related Feedback</b></center>
                            </td>--%>
                            <td style='padding-top: 20px;' align='center' rowspan="2">
                               <b> Sr No. </b>
                            </td>
                            <td rowspan="2" style="padding-top: 20px;" align="center" valign="middle">
                           
                             <b>    Your answers to questions 1-6 will be useful for assessing the value of this course.</b>
                                <br />
                               <b>  Instructor evaluation is given separately.</b>
                                
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Neutral</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
                            <%--   <td valign="top">
                                <p>
                                    <b>Not Applicable</b></p>
                            </td>--%>
                        </tr>
                        <tr class="table_header">
                            <td style="text-align: center;">
                                5
                            </td>
                            <td style="text-align: center;">
                                4
                            </td>
                            <td style="text-align: center;">
                                3
                            </td>
                            <td style="text-align: center;">
                                2
                            </td>
                            <td style="text-align: center;">
                                1
                            </td>
                            <%-- <td>
                            </td>--%>
                        </tr>
                    </thead>
                    <tbody>
                        
                    </tbody>
                </table>
            </div>

            <div class="row-fluid">
                <div style="margin-top: 5px">
                    <table align="center" border="0" cellpadding="10" cellspacing="0">
                        <tr>
                            <td>
                                <button type="button" id="btn_save" style="display: block; line-height: inherit;
                                    width: 110px; height: 36px;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>
                            </td>
                            <td>
                                <button id="btn_lecture" style="display: block; line-height: inherit; width: 110px;
                                    height: 36px;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>SUBMIT
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="divseminar" class="row-fluid" style="font-family: Calibri; font-size: 18px;
        display: none">
        <div class="tab-content" style="width: 70%; float: right">
            <div class="page-header position-relative">
                <h1 align="center">
                    CEPT Student Feedback Form – <u>SEMINAR Course</u></h1>
                <h1 align="center">
                    <span style="display: none; font-size: 22px" class="lblclass"></span>
                </h1>
            </div>
            <%--<div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i> CEPT Student Feedback Form - LECTURE Course
                                </h4>
                            </div>--%>
            <p>
                <i class="icon-arrow-right"></i>Thank you for taking the time to complete the student
                feedback form. At CEPT University, student feedback is a very important resource
                for assessing and improving the quality of teaching and learning.
            </p>
            <p>
                <i class="icon-arrow-right"></i>Please think carefully and provide reasoned opinions
                to the following questions.
            </p>
            <p>
                <i class="icon-arrow-right"></i>The summary of responses will be shared with the
                course instructors after the final grades for this course have been submitted &the
                identity of individual student/s will be kept confidential.
            </p>
            <p>
                <i class="icon-arrow-right"></i>Your feedback will be considered more carefully
                if it is provided in a professional and constructive manner</p>
            <br />
            <p>
                <b>Please select the appropriate box</b></p>
            <br />
            <p>
                <b>1 Feedback : Course</b></p>
            <div id="div2">
                <table id="course_seminar" border="1" cellspacing="0" cellpadding="0" class="display table table-striped table-bordered table-hover">
                    <thead>
                        <tr class="table_header">
                            <td style="padding-top: 20px;" align="center" valign="middle">
                                <center>
                                    <b>Course related Feedback</b></center>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Neither Agree nor Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Not Applicable</b></p>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- <tr>
                            <td>
                                The objectives for this course were clearly outlined and communicated
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkstronglyagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkneitherAgree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkdisagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkstronglydisagree" /></center>
                            </td>
                            <td>
                                <%--<center> <input type="radio" name="1.1" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                The course met my expectations (based on the course objective)
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkstronglyagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkneitherAgree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkdisagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkstronglydisagree" /></center>
                            </td>
                            <td>
                                <%--<center> <input type="radio" name="1.1" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                The course was well structured
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.2" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                                <%--<center> <input type="radio" name="1.2" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                The course enabled me to learn and think about new concepts and ideas
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.3" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                                <%-- <center> <input type="radio" name="1.3" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                The material and/or assignments helped to improve my understanding of the subject
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.4" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.4" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.4" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.4" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.4" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                                <%-- <center> <input type="radio" name="1.4" class="chknonapplicable" /></center>
                            </td>
                        </tr>--%>
                    </tbody>
                </table>
            </div>
            <p>
                <br />
                <b>2 Feedback : Instructor </b>
            </p>
            <div id="div_seminar">
            </div>
            <p>
                <br />
                <b>3 What aspects of this course or the delivery/teaching method did you like best?</b></p>
            <table cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="control-group">
                                                <div>
                                                    <textarea id="txt_seminar_aspect" style="width: 230%; height: 110px" rows="3" cols="50"
                                                        name="address"></textarea>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <p>
                <b>4 Please provide suggestions (if any) on how the course and/or delivery method can
                    be improved, with regard to the above points where you have disagreed.</b></p>
            <table cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="control-group">
                                                <div>
                                                    <textarea id="txt_seminar_suggestion" style="width: 230%; height: 150px" rows="3"
                                                        cols="50" name="address"></textarea>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="row-fluid">
                <div style="margin-top: 5px">
                    <table align="center" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <button id="btn_seminar" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>SUBMIT
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="divworkshop" class="row-fluid" style="font-family: Calibri; font-size: 18px;
        display: none">
        <div class="tab-content" style="width: 70%; float: right">
            <div class="page-header position-relative">
                <h1 align="center">
                    CEPT Student Feedback Form - <u>WORKSHOP Course</u></h1>
                <h1 align="center">
                    <span style="display: none; font-size: 22px" class="lblclass"></span>
                </h1>
            </div>
            <%--<div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i> CEPT Student Feedback Form - LECTURE Course
                                </h4>
                            </div>--%>
            <p>
                <i class="icon-arrow-right"></i>Thank you for taking the time to complete the student
                feedback form. At CEPT University, student feedback is a very important resource
                for assessing and improving the quality of teaching and learning.
            </p>
            <p>
                <i class="icon-arrow-right"></i>Please think carefully and provide reasoned opinions
                to the following questions.
            </p>
            <p>
                <i class="icon-arrow-right"></i>The summary of responses will be shared with the
                course instructors after the final grades for this course have been submitted &the
                identity of individual student/s will be kept confidential.
            </p>
            <p>
                <i class="icon-arrow-right"></i>Your feedback will be considered more carefully
                if it is provided in a professional and constructive manner</p>
            <br />
            <p>
                <b>Please select the appropriate box</b></p>
            <br />
            <p>
                <b>1 Feedback : Course</b></p>
            <div id="div4">
                <table id="course_workshop" border="1" cellspacing="0" cellpadding="0" class="display table table-striped table-bordered table-hover">
                    <thead>
                        <tr class="table_header">
                            <td style="padding-top: 20px;" align="center" valign="middle">
                                <center>
                                    <b>Course related Feedback</b></center>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Neither Agree nor Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Not Applicable</b></p>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                        <%--<tr>
                            <td>
                                The course was well structured
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkstronglyagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkneitherAgree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkdisagree" /></center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                                <%--  <center> <input type="radio" name="1.1" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                There was sufficient opportunity to gain hands-on experience
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.2" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.2" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                                <%--<center> <input type="radio" name="1.2" class="chknonapplicable" /></center>
                        </tr>
                        <tr>
                            <td>
                                I acquired new skills during by attending this course
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.3" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                                <center>
                                    <input type="radio" name="1.3" class="chknonapplicable" /></center>
                            </td>
                        </tr>--%>
                    </tbody>
                </table>
            </div>
            <p>
                <br />
                <b>2 Feedback : Instructor </b>
            </p>
            <div id="div_workshop">
                <%--<table border="1" cellspacing="0" cellpadding="0" class="data-table table table-bordered table-striped">
                    <tbody>
                        <tr>
                            <td valign="top">
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Neither Agree nor Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Not Applicable</b></p>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <p>
                                    2.1 The instructors had sufficient knowledge about the main theme or topic of the workshop</p>
                            </td>
                           <td>
                           <center> <input type="radio" name="2.1" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                              <center> <input type="radio" name="2.1" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.1" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.1" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.1" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                             <center> <input type="radio" name="2.1" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <p>
                                    2.2 My learning difficulties were addressed</p>
                            </td>
                             <td>
                           <center> <input type="radio" name="2.3" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                              <center> <input type="radio" name="2.3" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.3" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.3" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.3" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                             <center> <input type="radio" name="2.3" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <p>
                                    2.3 The workshop encouraged creative exploration.</p>
                            </td>
                            <td>
                           <center> <input type="radio" name="2.4" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                              <center> <input type="radio" name="2.4" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.4" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.4" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.4" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                             <center> <input type="radio" name="2.4" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <p>
                                    2.4 The instructor was available regularly during workshop hours</p>
                            </td>
                            <td>
                           <center> <input type="radio" name="2.5" class="chkstronglyagree" /></center>
                            </td>
                            <td valign="top">
                              <center> <input type="radio" name="2.5" class="chkagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.5" class="chkneitherAgree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.5" class="chkdisagree" /></center>
                            </td>
                            <td valign="top">
                            <center> <input type="radio" name="2.5" class="chkstronglydisagree" /></center>
                            </td>
                            <td valign="top">
                             <center> <input type="radio" name="2.5" class="chknonapplicable" /></center>
                            </td>
                        </tr>
                        
                    </tbody>
                </table>--%>
            </div>
            <p>
                <br />
                <b>3 What aspects of this course or the delivery/teaching method did you like best?</b></p>
            <table cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="control-group">
                                                <div>
                                                    <textarea id="txt_workshop_aspect" style="width: 230%; height: 110px" rows="3" cols="50"
                                                        name="address"></textarea>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <p>
                <b>4 Please provide suggestions (if any) on how the course and/or delivery method can
                    be improved, with regard to the above points where you have disagreed.</b></p>
            <table cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="control-group">
                                                <div>
                                                    <textarea id="txt_workshop_suggestion" style="width: 230%; height: 150px" rows="3"
                                                        cols="50" name="address"></textarea>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="row-fluid">
                <div style="margin-top: 5px">
                    <table align="center" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <button id="btn_workshop" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>SUBMIT
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="divstudio" class="row-fluid" style="font-family: Calibri; font-size: 18px;
        display: none">
        <div class="tab-content" style="width: 70%; float: right">
            <div class="page-header position-relative">
                <h1 align="center">
                    CEPT Student Feedback Form - <u>STUDIO Course</u></h1>
                <h1 align="center">
                    <span style="display: none; font-size: 22px" class="lblclass"></span>
                </h1>
            </div>
            <%--<div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i> CEPT Student Feedback Form - LECTURE Course
                                </h4>
                            </div>--%>
            <p>
                <i class="icon-arrow-right"></i>Thank you for taking the time to complete the student
                feedback form. At CEPT University, student feedback is a very important resource
                for assessing and improving the quality of teaching and learning.
            </p>
            <p>
                <i class="icon-arrow-right"></i>Please think carefully and provide reasoned opinions
                to the following questions.
            </p>
            <p>
                <i class="icon-arrow-right"></i>The summary of responses will be shared with the
                course instructors after the final grades for this course have been submitted &the
                identity of individual student/s will be kept confidential.
            </p>
            <p>
                <i class="icon-arrow-right"></i>Your feedback will be considered more carefully
                if it is provided in a professional and constructive manner</p>
            <br />
            <p>
                <b>Please select the appropriate box</b></p>
            <br />
            <p>
                <b>1 Feedback : Course</b></p>
            <div id="div6">
                <table id="course_studio" border="1" cellspacing="0" cellpadding="0" class="display table table-striped table-bordered table-hover table_course">
                    <thead>
                        <tr class="table_header">
                            <td style="padding-top: 20px;" align="center" valign="middle">
                                <center>
                                    <b>Course related Feedback</b></center>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Neither Agree nor Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
                            <td valign="top">
                                <p>
                                    <b>Not Applicable</b></p>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <p>
                <br />
                <b>2 Feedback : Instructor </b>
            </p>
            <br />
            <p>
                <b>If specific / multiple instructors were assigned for your group, please fill up the
                    form for the instructor/s with whom you had the maximum interaction</b></p>
            <div id="div_studio">
            </div>
            <p>
                <br />
                <b>3 What aspects of this course or the delivery/teaching method did you like best?</b></p>
            <table cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="control-group">
                                                <div>
                                                    <textarea id="txt_studio_aspect" style="width: 230%; height: 110px" rows="3" cols="50"
                                                        name="address"></textarea>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <p>
                <b>4 Please provide suggestions (if any) on how the course and/or delivery method can
                    be improved, with regard to the above points where you have disagreed.</b></p>
            <table cellpadding="0" cellspacing="0">
                <tbody>
                    <tr>
                        <td>
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tbody>
                                    <tr>
                                        <td>
                                            <div class="control-group">
                                                <div>
                                                    <textarea id="txt_studio_suggestion" style="width: 230%; height: 150px" rows="3"
                                                        cols="50" name="address"></textarea>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="row-fluid">
                <div style="margin-top: 5px">
                    <table align="center" border="0" cellpadding="10" cellspacing="0">
                        <tr>
                            <td>
                                <button type="button" id="btn_studio" style="display: block; line-height: inherit;"
                                    class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>SUBMIT
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
