<%@ Page Title="Course Allocation Report - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="student_course_allocated_report.aspx.cs" ViewStateEncryptionMode="Always"  Inherits="Admin_Report_student_course_allocated_report"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script><%--01012021--%>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
          //  bindyeardata();
            bindsemdata();
            binddepartment()

            ///// Returned By Ananth ////
            bindprogrammedata();
            bindproglevel();

            $('#btnreterive').on('click', function () {

                total_course_allocat();

                return false;

            });

            //Returned By Ananth ///

            $('#drpproglevel').on('change', function () {
                if ($('#drpyear').val() != '' && $('#drpsemester').val() != '' && $('#drpdepartment').val() != '' && $('#drpprog').val() != '' && $('#drpproglevel').val() != '') {
                    bind_student_course_allocated_report();  
                }
            });

            $('#btn_assign').on('click', function () {
                return false;
            });
            return false;
        });

      

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">

            <h1>
                <i class="icon-desktop"></i> Course Allocation Report
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
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                              <td>
                                Year of allocation :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <%--<td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>--%>
                            <td>
                               Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                        <tr>
                            <td>
                               Program :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog" />
                            </td>
                            <td>
                               Program Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
                            </td>
                            <td>
                               Course Code :
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div >

         
            <div id="DataList" style="display: none; overflow:auto;" class="panel panel-default">
                 <div class="panel-heading">
                <strong id="panel_head">Course Allocation Report</strong>
            </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <table width="100%" border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td align="center">
                        <button class="btn btn-primary" style="display: none" type="submit" id="btn_assign">
                            Assign Course
                        </button>
                    </td>
                </tr>
            </table>
                   </div>
        </div>
    
    
</asp:Content>
