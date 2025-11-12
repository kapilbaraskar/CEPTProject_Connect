<%@ Page Title="Course Wise instructor Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Course_wise_instructor_personal_dtl.aspx.cs" Inherits="Admin_Report_WS_Course_wise_instructor_personal_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
     <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    
    <script type="text/javascript">
        $(document).ready(function () {
            bind_ws_semdata();
            binddepartment();
            bindyeardata_for_cross_reg();
            bindprogrammedata();
            $('#btnreterive').on('click', function () {
                $('#DataList1').css('display', 'block');
                get_course_wise_inst_dtl_praposal();
                get_course_wise_inst_dtl();
               

                return false;

            });
            $('#drpsemester').on('change', function () {
                if ($('#drpsemester').val() != '') {

                    if ($('#drpyear').val() != '') {
                        bind_sem_course();
                    }

                }
            });


            $('#drpyear').on('change', function () {
                if ($('#drpyear').val() != '') {

                    if ($('#drpsemester').val() != '') {
                        bind_sem_course();
                    }

                }
            });


            return false;

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Course Wise instructor Details
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
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
                        </tr>
                    <tr>
                        <td>
                           Publish Course Code :
                        </td>
                        <td>
                                <select class="chosen-select" id="drcourses" name="drcourses">
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
        
        <div id="DataList1" class="panel panel-default" style="display:none;margin-bottom:40px;">
           <div id="div_myTab">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a data-toggle="tab" href="#approvedcourses">Course Proposal instructor&nbsp;</a></li>
                    <li><a data-toggle="tab" href="#offeredcourse">Course Publish instructor &nbsp;</a></li>
                    
                   
                </ul>
            </div>
            <div class="panel-heading">
                <strong id="panel_head">Course Wise instructor Details</strong>
            </div>
            <div class="tab-content">
                <div id="offeredcourse" class="tab-pane">
            <div id="DataList">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
                    </div>
                 <div id="approvedcourses" class="tab-pane in active">
            <div id="swsDataList">
                <table cellpadding="0" cellspacing="0" border="0" id="example_course" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
                </div>
                </div>
        </div>
    </div>
    <asp:Button ID="btnDownload_cv" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownload_cv_Click" ClientIDMode="Static" />
    
    <asp:Button ID="btnDownload_Portfolio" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownload_Portfolio_Click" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_file_name" runat="server" ClientIDMode="Static" />
</asp:Content>

