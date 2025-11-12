<%@ Page Title="Print - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="feedback_faculty_member_report.aspx.cs" Inherits="Admin_Report_feedback_faculty_member_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
    <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>
    <script src="../../Js_WS/feedback_faculty_report.js" type="text/javascript"></script>
   
    <style>
        td
        {
            padding-left: 5px;
      
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
     
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Feedback Faculty Member Report
            </h1>
        </div>
         </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            
                            <td>
                                Semester
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester" name="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear" name="drpyear">
                                </select>
                            </td>
                            <td>
                                Course
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses" name="drcourses">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <%-- <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>--%>
                            <td>
                                Instructor
                            </td>
                            <td align="center">
                                <select class="chosen-select" id="drp_instructor" name="drp_instructor">
                                </select>
                            </td>
                            <%-- <td>
                                Course Type
                            </td>
                            <td align="center">
                                <select class="chosen-select" id="drp_course_type" name="drp_course_type">
                                </select>
                            </td>--%>
                            <td>
                                Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" name="drpdepartment">
                                </select>
                            </td>
                            <td>
                                <%--<a id="btnreterive1" class="btn btn-primary" target="_blank">Print</a>--%>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                            <td>
                                <%--<a id="btnreterive1" class="btn btn-primary" target="_blank">Print</a>--%>
                                <button class="btn btn-primary" type="button" id="btnprint">
                                    Print
                                </button>
                            </td>
                            <td style="display: none">
                                <%--<input type="button" value="Download" runat="server" clientidmode="Static"/>--%>
                                <asp:Button ID="Button1" runat="server" Text="Download" OnClick="Button1_Click" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="chartContainer" class="containers" style="height: 440px; width: 100%;">
            </div>
            <div id="print_data" class="panel panel-default" style="display: block">
                 <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
                <div>
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_lecture" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                    </div>
            </div>
            <%--  <div id="div_seminar" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_seminar" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div id="div_workshop" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_workshop" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div id="div_studio" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_studio" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>--%>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
   
</asp:Content>