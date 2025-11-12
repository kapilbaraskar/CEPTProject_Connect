<%@ Page Title="Course Report - Feedback" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="feedback_course_report.aspx.cs" Inherits="Admin_Report_feedback_course_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
 <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
   <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>
    <script src="../../Js/feedback_course_report.js" type="text/javascript"></script>
    <style>
    .dxc-pane-tracker
    {
    	display : none;
    }
    
    
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Feedback Course Report
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester of Allocation
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year of Allocation 
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                                Course 
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>

                             <td>
                                <button class="btn btn-primary" type="submit" id="btnprint">
                                    Print
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div id="print_data">
            
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>
