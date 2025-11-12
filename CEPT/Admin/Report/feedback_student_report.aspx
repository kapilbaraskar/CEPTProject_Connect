<%@ Page Title="Feedback Student Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="feedback_student_report.aspx.cs" Inherits="Admin_Report_feedback_student_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/feedback_report.js?t=28082019" type="text/javascript"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    	<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">



        $(document).ready(function () {
            bindsemdata();
            binddepartment();
            bindprogrammedata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {


                get_student_feedback_data();

                return false;
            });

            //        $('#drpsemester').on('change', function () {
            //            if ($('#drpsemester').val() != '') {
            //                bind_sem_course();
            //            }
            //        });



        });
    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Feedback Student Report
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
                                Department 
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                            </select> </td>
                        </tr>
                        <tr>

                            <td>
                                Program 
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="DataList" style="display: none;overflow:auto">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>
