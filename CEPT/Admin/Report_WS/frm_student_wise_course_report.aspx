<%@ Page Title="Report - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="frm_student_wise_course_report.aspx.cs" Inherits="Admin_Report_frm_student_wise_course_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script type="text/javascript">


        $(document).ready(function () {


            //  bindyeardata();
            bindprogrammedata();
            binddepartment();


            $('#btnreterive').on('click', function () {

                get_saved_allocate_data();

                return false;

            });

            $('#drpdepartment').on('change', function () {

                if ($('#drpdepartment').val() != '') {
                    if ($('#drpprog').val() != '') {

                        //                        alert('Change');
                        $('#drpstudent').trigger("liszt:updated");
                        //                        $('#drpstudent').chosen();
                        //                        $('#drpstudent').html("");
                        bindallstudentdata();

                    }
                }

            });

            $('#drpprog').on('change', function () {

                if ($('#drpprog').val() != '') {
                    if ($('#drpdepartment').val() != '') {

                        //                        alert('Change');
                        $('#drpstudent').trigger("liszt:updated");
                        //                        $('#drpstudent').chosen();
                        //                        $('#drpstudent').html("");
                        bindallstudentdata();

                    }
                }

            });


            return false;

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Selection Report Student Wise
            </h1>
        </div>
        <div class="space">
        </div>
        <div>
            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                            Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            Programme :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                          <td>
                            Student :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                    <tr>
                      
                    </tr>
                </table>
            </div>
        </div>
        <div class="page-header position-relative">
            <h4>
                Saved / Registered Courses
            </h4>
        </div>
        <div style="margin-top: 5px; display: none; width: 100%" class="row-fluid" id="datalist_saved">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="datatable_saved" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
        <div class="page-header position-relative">
            <h4>
                Assigned Course
            </h4>
        </div>
        <div style="display: none; width: 100%" class="row-fluid" id="datalist_register">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="datatable_register" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
