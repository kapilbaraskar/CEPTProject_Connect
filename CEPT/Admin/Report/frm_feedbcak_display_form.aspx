<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="frm_feedbcak_display_form.aspx.cs" Inherits="Admin_Report_frm_feedbcak_display_form" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="width: 25%; float: left">
        <div style="margin-left: 25px" class="col-xs-12">
            <p>
                <input type="hidden" id="course_code" value="5002">
                <input type="hidden" id="course_type" value="7">
            </p>
            <h5>
                Select Your Course</h5>
            <p>
            </p>
        </div>
        <div id="datalist_saved" style="display: block;">
            <div id="datatable_saved_wrapper" class="dataTables_wrapper form-inline" role="grid">
                <table cellpadding="0" cellspacing="0" border="0" id="datatable_saved" class="display table table-striped table-bordered table-hover dataTable"
                    width="100%" style="width: 100%;">
                    <thead>
                        <tr role="row">
                            <th class="sorting_disabled" tabindex="0" rowspan="1" colspan="1" aria-label="Course">
                                Course
                            </th>
                            <th class="sorting_disabled" tabindex="0" rowspan="1" colspan="1" aria-label="Submit Feedbak">
                                <center>
                                    Submit Feedbak</center>
                            </th>
                        </tr>
                    </thead>
                    <tbody role="alert" aria-live="polite" aria-relevant="all">
                        <tr class="odd" style="color: rgb(214, 213, 195);">
                            <td class=" sorting_1">
                                1543 - Foundation Studio
                            </td>
                            <td class="">
                                <center>
                                    <button type="button" class="btn btn-lg btn-primary btnfeedback" disabled="">
                                        Submit</button></center>
                            </td>
                        </tr>
                        <tr class="even" style="color: rgb(214, 213, 195);">
                            <td class=" sorting_1">
                                1547 - Recomposing Urban Fragments
                            </td>
                            <td class="">
                                <center>
                                    <button disabled type="button" class="btn btn-lg btn-primary btnfeedback">
                                        Submit</button></center>
                            </td>
                        </tr>
                        <tr class="odd" style="color: rgb(214, 213, 195);">
                            <td class=" sorting_1">
                                2521 - History &amp; Theory - I
                            </td>
                            <td class="">
                                <center>
                                    <button disabled type="button" class="btn btn-lg btn-primary btnfeedback">
                                        Submit</button></center>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div id="divlecture" class="row-fluid" style="font-family: Calibri; font-size: 18px;
        display: block;">
        <div class="tab-content" style="width: 70%; float: right">
            <div class="page-header position-relative">
                <h1 align="center">
                    CEPT Student Feedback Form - <u>LECTURE Course</u></h1>
                <h1 align="center">
                    <span style="display: block; font-size: 22px;" class="lblclass">5002 - Engineering Drawing</span>
                </h1>
            </div>
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
                course instructors after the final grades for this course have been submitted &amp;the
                identity of individual student/s will be kept confidential.
            </p>
            <p>
                <i class="icon-arrow-right"></i>Your feedback will be considered more carefully
                if it is provided in a professional and constructive manner</p>
            <br>
            <p>
                <b>Please select the appropriate box</b></p>
            <br>
            <p>
                <b>1 Feedback : Course</b></p>
            <div id="divcourse">
                <table id="course_lecture" border="1" cellspacing="0" cellpadding="0" class="display table table-striped table-bordered table-hover ">
                    <thead>
                        <tr class="table_header">
                            <td rowspan="2" style="padding-top: 20px;" align="center" valign="middle">
                                • Your answers to questions 1-8 will be useful for assessing the value of this course.
                                <br>
                                <b>• The following questions focus only on the course. Instructor evaluation is given
                                    separately.</b>
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
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                1. The course achieved its stated objectives.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.1" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                2. Course outline (including schedule of classes, reading and other resources, assignments
                                and, evaluation scheme and criteria) was provided at the beginning and explained
                                clearly
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.2" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.2" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.2" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.2" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.2" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                3. The course materials (e.g. text, lecture notes, reading, etc.) were helpful in
                                learning and understanding the content taught.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.3" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.3" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.3" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.3" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.3" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                4. The assignments / field visits / practicalsorganized as a part of the course
                                helped to improve my understanding of the subject.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.4" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.4" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.4" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.4" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.4" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                5.The course was well structured.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.5" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                6. The evaluation weightage of different components / assignments of the course
                                was consistent with their workload.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.6" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.6" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.6" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.6" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.6" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                7.The assignments were promptly evaluated and comments were given.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.7" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.7" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.7" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.7" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.7" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                8. The course met my expectations.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.8" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.8" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.8" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.8" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="1.8" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <p>
                <br>
                <b>Please write your open ended comments about the course here:</b></p>
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
                                                    <textarea id="txt_course_instruction" style="width: 230%; height: 110px" rows="3"
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
            <p>
                <br />
                <b>2 Feedback : Instructor </b>
            </p>
            <div id="div_lecture">
                <br />
                <span style="color: green"><b>Instructor :: Yogesh Gandevikar</b></span>
                <table id="table1" border="1" cellspacing="0" cellpadding="0" class="data-table table table-bordered table-striped">
                    <thead>
                        <tr class="table_header">
                            <td rowspan="2" style="padding-top: 20px;" align="center">
                                <center>
                                    <b>Your answers to questions 1-9 will be useful for evaluating the effectiveness of
                                        the instructor. </b>
                                </center>
                                <p>
                                </p>
                                <input type="hidden" class="instructor_name" value="191">
                            </td>
                            <td>
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Neither Agree nor Disagree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
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
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                1.The class started on time and the instructor was available during full class time.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.9" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.9" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.9" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.9" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.9" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                2.The sessions held by instructor were according to the course out line.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.10" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.10" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.10" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.10" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.10" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                3.The instructor had sufficient knowledge about the main theme or topic.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.11" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.11" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.11" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.11" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.11" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                4.The instructor was organized and well prepared for the class.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.12" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.12" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.12" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.12" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.12" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                5. The instructor was effective in communicating the concepts and stimulated interest
                                in the subject matter in class.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.13" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.13" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.13" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.13" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.13" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                6.Conceptual and critical thinking was encouraged.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.14" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.14" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.14" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.14" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.14" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                7.Question raised in class were effectively addressed.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.15" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.15" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.15" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.15" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.15" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                8. The instructor provided the timely feedback on the various components of the
                                course (quizzes, exams, assignments, projects, and class participation).
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.16" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.16" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.16" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.16" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.16" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                9. The instructor did an excellent job in teaching this course.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.17" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.17" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.17" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.17" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table12.17" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p>
                    <br>
                    <b>Please write your open ended comments about the Yogesh Gandevikar here:</b></p>
                <div class="control-group">
                    <textarea id="table1instruction" style="width: 99%; height: 110px" rows="3" cols="5"
                        name="address"></textarea></div>
                <br>
                <span style="color: green"><b>Instructor :: Bhushan Sachdeva</b></span>
                <table id="table2" border="1" cellspacing="0" cellpadding="0" class="data-table table table-bordered table-striped">
                    <thead>
                        <tr class="table_header">
                            <td rowspan="2" style="padding-top: 20px;" align="center">
                                <center>
                                    <b>Your answers to questions 1-9 will be useful for evaluating the effectiveness of
                                        the instructor. </b>
                                </center>
                                <p>
                                </p>
                                <input type="hidden" class="instructor_name" value="235">
                            </td>
                            <td>
                                <p>
                                    <b>Strongly Agree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Agree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Neither Agree nor Disagree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Disagree</b></p>
                            </td>
                            <td>
                                <p>
                                    <b>Strongly Disagree</b></p>
                            </td>
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
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                1.The class started on time and the instructor was available during full class time.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.9" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.9" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.9" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.9" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.9" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                2.The sessions held by instructor were according to the course out line.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.10" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.10" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.10" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.10" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.10" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                3.The instructor had sufficient knowledge about the main theme or topic.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.11" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.11" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.11" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.11" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.11" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                4.The instructor was organized and well prepared for the class.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.12" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.12" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.12" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.12" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.12" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                5. The instructor was effective in communicating the concepts and stimulated interest
                                in the subject matter in class.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.13" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.13" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.13" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.13" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.13" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                6.Conceptual and critical thinking was encouraged.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.14" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.14" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.14" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.14" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.14" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                7.Question raised in class were effectively addressed.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.15" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.15" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.15" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.15" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.15" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                8. The instructor provided the timely feedback on the various components of the
                                course (quizzes, exams, assignments, projects, and class participation).
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.16" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.16" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.16" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.16" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.16" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                9. The instructor did an excellent job in teaching this course.
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.17" class="chkstronglyagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.17" class="chkagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.17" class="chkneitherAgree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.17" class="chkdisagree">
                                </center>
                            </td>
                            <td>
                                <center>
                                    <input type="radio" name="table22.17" class="chkdisagree">
                                </center>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p>
                    <br>
                    <b>Please write your open ended comments about the Bhushan Sachdeva here:</b></p>
                <div class="control-group">
                    <textarea id="table2instruction" style="width: 99%; height: 110px" rows="3" cols="5"
                        name="address"></textarea></div>
            </div>
        </div>
    </div>
</asp:Content>
