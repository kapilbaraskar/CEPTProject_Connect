<%@ Page Title="Report - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_student_wise_course_report.aspx.cs" Inherits="Admin_Report_frm_student_wise_course_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">


        $(document).ready(function () {
            debugger;
            bindyeardata_for_cross_reg();
            bindsemdata();
            //  bindyeardata();
            //  bindprogrammedata();
            binddepartment();
            bindprogramme();

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

                        $('#drpstudent').trigger("liszt:updated");
                       
                        bindallstudentdata();
                    }
                }
            });

            return false;
        });

        function bindprogramme() {

            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);

                            $('#drpprog').empty();

                            for (var i = 0; i < user_data.length; i++) {

                                if (user_data[i]['prog_code'] == "1") {
                                    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "2") {
                                    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "3") {
                                    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                }
                            }

                        }
                        else {
                            $('#drpprog').val('1');
                            $("#drpprog").attr('disabled', 'disabled');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            else {

                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

                if ($("#hdnusertype").val() != 'PC' && $("#hdnusertype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Selection Report Student Wise
            </h1>
        </div>
        </div>
        <div class="space">
        </div>
        <div>
            <div class="panel panel-default">
                 <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                             Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>
                           Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                       
                    </tr>
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
                Registered Courses
            </h4>
        </div>
        <div style="margin-top: 5px; display: none;  width: 100%" class="row-fluid panel panel-default" id="datalist_saved" >
            <div class="panel-heading">
                <strong id="panel_head">Registered Courses</strong>
            </div>
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
        <div style="display: none; width: 100%" class="row-fluid panel panel-default" id="datalist_register">
            <div class="panel-heading">
                <strong id="panel_head">Assigned Course</strong>
            </div>
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="datatable_register" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
    
</asp:Content>
