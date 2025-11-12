<%@ Page Title="Feedback Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Feedback_report.aspx.cs" Inherits="Admin_Report_Feedback_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/feedback_report.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">

        

        $(document).ready(function () {
            bindsemdata();
            binddepartment();
            //   bindprogrammedata();
            bindyeardata_for_cross_reg();
            bindyeardata_for_allocation();

            $('#btnreterive').on('click', function () {


                get_feedback_data();

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
                <i class="icon-desktop"></i>Feedback Report
            </h1>
        </div>
        </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester of Allocation:
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year  :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>

                            
                        </tr>
                        <tr>
                            <td>
                                Year of Allocation :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear_allocation">
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
            <div id="DataList" style="display: none; overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%" style="width:100%;">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot style="background-color:#f3f3f3">
                        <tr>
                            <th>
                                Total:
                            </th>
                            <th style="text-align: left">
                            </th>
                            <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
