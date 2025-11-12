<%@ Page Title="Course Instructor Feedback Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="course_instructor_wise_feedback.aspx.cs" Inherits="Admin_Report_course_instructor_wise_feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/feedback_report.js?t=24052018" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    
    <script type="text/javascript">
        var obj_typology_data = [];

        $(document).ready(function () {
            bindsemdata();
            binddepartment();
            //bindprogrammedata();
            bindyeardata_for_cross_reg();
            get_all_typology_group();

            $('#btnreterive').on('click', function () {
                get_course_faculty_wise_feedback_report();
                return false;
            });

            $("#drpsemester,#drpyear,#drpdepartment ").on('change', function () {
                $('#DataList').css('display', 'none');
                return true;
            });
        });

        function get_all_typology_group() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_typology_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var res = JSON.parse(data.d);

                        if (res['typology_detail'] != null) {
                            obj_typology_data = res['typology_detail'];
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal hide fade" id="myModal" style="left: 50%; width: 40%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;</button>
                    <h4 class="modal-title">
                        <b>Enter Remark</b></h4>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" rows="10" cols="500" id="txtRejectRemark" maxlength="10000"
                        style="width: 97%;"></textarea>
                    <asp:HiddenField ID="hdn_course" runat="server" ClientIDMode="Static" />
                     <asp:HiddenField ID="hdn_faculty_mail" runat="server" ClientIDMode="Static" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close</button>
                    <button id="btn_remark_submit" type="button" class="btn btn-primary" data-toggle="confirmation">
                        Submit</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
    </div>
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Instructor Feedback Report
            </h1>
        </div>
        <div>
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
                                Year of Allocation :
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
                                <select class="chosen-select" id="drpdepartment">
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
            <div id="DataList" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
