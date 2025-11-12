<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="Student_Marksheet.aspx.cs" Inherits="Student_student_marksheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Js/student_marksheet.js?t=16032022" type="text/javascript"></script>
    <%--26062019--%><%--15072019--%><%--03092019--%><%--13112019--%><%--06012020--%><%--05022020--%><%--09032020--%><%--13032020--%><%--23072020--%><%--18112020--%><%--30112021--%>

    <style type="text/css">
        #tbl_mid_term th {
            text-align: center;
            vertical-align: middle;
        }

        #tbl_mid_term td {
            text-align: center;
        }

        .monsoon_spring_course_outline {
            color: black;
        }

        #btnreterive {
            line-height: 22px;
        }

        .table-bordered {
            border: 0px solid #ddd;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Grade Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_marksheet_data" style="display: none;">

            <%--<div id="div_download_pdf" style="display: block;">
                <button class="btn btn-primary btn-small" type="button" onclick="btnClick()" style="float: right;">
                    Download</button>
            </div>--%>

            <table style="margin-bottom: 20px;">
                <tr>
                    <td>
                        <span><b>Student Name</b></span>
                    </td>
                    <td>
                        <span style="margin-left: -137px;"><b>&nbsp;:&nbsp; </b></span>
                    </td>
                    <td>
                        <%--<span id='div_stud_name' style="margin-left: -280px;"></span>--%>
                        <span id='div_stud_name'></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span><b>Semester</b></span>
                    </td>
                    <td>
                        <span style="margin-left: -137px;"><b>&nbsp;:&nbsp; </b></span>
                    </td>
                    <td>
                        <%--<span id='div_cur_sem' style="margin-left: -280px;"></span>--%>
                        <span id='div_cur_sem'></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span><b>Year</b></span>
                    </td>
                    <td>
                        <span style="margin-left: -137px;"><b>&nbsp;:&nbsp; </b></span>
                    </td>
                    <td>
                        <%--<span id='div_cur_year' style="margin-left: -280px;"></span>--%>
                        <span id='div_cur_year'></span>
                    </td>
                </tr>
                <tr>
                    <td><a class="btn btn-small btn-primary" style="margin-bottom: 10px; margin-top: 10px;" href="../Content/Student_grievance_form.pdf" download>Student Academic Grievance Form</a></td>
                    <td>
                        <div id="div_download_pdf" style="display: block;">
                            <button class="btn btn-primary btn-small" type="button" onclick="btnClick()" style="float: left;">Download Grade Report</button>
                        </div>
                    </td>
                    <td>
                        <div id="div_download_catlog" style="display: block;">
                            <button class="btn btn-primary btn-small" type="button" onclick="btnClick_coursecatlog()" style="float: left; display: none;">Download Course Catlog</button>
                        </div>
                    </td>
                </tr>
            </table>




            <div class="panel panel-default" id="div_mid_term" style="display: none;">
                <div class="panel-heading">
                    <strong>Mid Term / Internal Marks</strong>
                </div>
                <div>
                    <table id="tbl_mid_term" class="table table-bordered">
                    </table>
                </div>
            </div>

            <div id="div_marksheet_tbl" style="display: none;">
                <%--<div class="panel panel-default" style="display: none;margin-top:10px;">
                    <div class="panel-heading">
                        <strong>Marksheet</strong>
                    </div>
            
                    <div> <%--class="panel-body"--%
                        <div id="DataList" style="display: none;">
                            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                                width="100%">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>--%>

                <div class="panel panel-default" style="margin-top: 10px;">
                    <div class="panel-heading">
                        <strong>Marksheet</strong>
                    </div>
                    <div style="margin-bottom: -7px;">
                        <table id="tbl_course_marks" class="table table-bordered"></table>
                    </div>
                </div>

                <div id="div_ws_course_marks" class="panel panel-default" style="margin-top: 10px; display: none;">
                    <div class="panel-heading">
                        <strong id="title_ws_course_marks"></strong>
                    </div>
                    <div style="margin-bottom: -7px;">
                        <table id="tbl_ws_course_marks" class="table table-bordered">
                        </table>
                    </div>
                </div>
                <div>
                    <span><b>Total Credits Completed : </b></span><span id="spn_credit_calculated"></span>
                    <span><b>(GPA : </b></span><span id="spn_gpa"></span><span><b>, Non GPA : </b></span>
                    <span id="spn_nongpa"></span><span>)</span>
                </div>
                <div style="margin-top: 5px; margin-bottom: 5px;">
                    <span><b>GPA : </b></span><span id="spn_calculated_gpa"></span>
                </div>
                <div>
                    <b>Note&nbsp;:&nbsp; </b>These are provisional grades. The grades might change in
                    case of any review and reassessment process. You can download your grade report
                    from the button given above.
                </div>
                <div style="margin-left: 43px;">
                    Some results of Thesis and Project training courses are not published yet and the
                    same will be added subsequently to your grade report.
                </div>
                <div id="div1" style="display: none;">
                    <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="Download_Student_Grade_Report" />
                    <input type="hidden" id="hdn_filter" runat="server" clientidmode="Static" />
                </div>
            </div>

            <div class="panel panel-default" style="margin-top: 10px; display: none;">
                <%--                <div class="panel-heading">
                    <strong></strong>
                </div>Commented by Mayur--%>
                <div style="margin-bottom: -7px;">
                    <table id="tbl_foundation_marks" class="table table-bordered">
                        <tr>
                            <td><b>Foundation Programme - I</b></td>
                            <td colspan="2"><b><span id="spn_pass_fail"></span></b></td>
                        </tr>
                        <%--<tr>
                            <td><b>Studio & Field Studio -</b> <span id="spn_course1_marks"></span>/100 - 15 Credits</td>
                        </tr>
                        <tr>
                            <td><b>ROWC & Perspectives -</b> <span id="spn_course2_marks"></span>/100 - 5 Credits</td>
                        </tr>
                        <tr>
                            <td colspan="3">Total Marks Out of 100 - 20 Credits (If, 50 or greater than 50, then Pass.)</td>
                        </tr>--%>
                    </table>
                    <table id="tbl_foundation_marks_new" class="table table-bordered">
                        <%--<tr>
                            <td><b>Foundation Programme - I</b></td>
                        </tr>--%>
                        <%--<tr>
                            <td><b>Studio & Field Studio -</b> <span id="spn_course1_marks"></span>/100 - 15 Credits</td>
                        </tr>
                        <tr>
                            <td><b>ROWC & Perspectives -</b> <span id="spn_course2_marks"></span>/100 - 5 Credits</td>
                        </tr>
                        <tr>
                            <td colspan="3">Total Marks Out of 100 - 20 Credits (If, 50 or greater than 50, then Pass.)</td>
                        </tr>--%>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div id="ifrm_outline" style="display: none;"></div>
    <input type="hidden" id="hdn_course_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year_code_foundation" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_course_dtl" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_course_weekly_percent_dtl" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_Course_wise_instructor_dtl" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_Portfoliolink_dtl" runat="server" clientidmode="Static" />
    <div style="display: none;">
        <asp:Button ID="btn_download" runat="server" ClientIDMode="Static" Text="test" OnClick="Download_OutLine" />
    </div>
</asp:Content>
