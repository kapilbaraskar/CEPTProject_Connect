<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="sws_stu_course_reg_dtl.aspx.cs" Inherits="Admin_Report_sws_stu_course_reg_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <script src="../../Js/admin_report.js?t=15062021" type="text/javascript"></script>
        <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            //bindyeardata_for_cross_reg();
            //bindsemdata();
            //binddepartment();
            //bindproglevel();
            bindprogrammedata();
            //type();
            bind_ws_semdata();
            binddepartment();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                total_assigned_report_data();
                return false;
            });

            return false;
        });

        function bind_ws_semdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

            $('#drpsemester').chosen();

        }
        function binddepartment() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/Get_department_data",

                data: "{}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {

                        var sem_data = JSON.parse(data.d)

                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }
                        $('#drpdepartment').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bindyeardata_for_cross_reg() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/Get_year_data",

                data: "{}",
                dataType: "json",
                success: function (data) {




                    if (data.d != "") {


                        var year_data = JSON.parse(data.d)



                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {


                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }
       
        function total_assigned_report_data() {
            $('#DataList').css('display', 'none');

            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

           var dept_code = $('#drpdepartment').val();
            var course_code = '';
            var prog_code = $('#drpprog').val();
            var prog_level_code = '';
            var type = '';
            //var type = $('#drptype').val();
            //if (type == "") {
            //    bootbox.alert('Please select Type')
            //    $('#drptype').focus();
            //    return false;
            //}

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_student_wise_reg_dtl",
                data: "{sem_code: '" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',course_code:'" + course_code + "',prog_code:'" + prog_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Display_faculty_report(data.d);
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function Display_faculty_report(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "full Name", "mData": "um_full_name", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false  },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false  },
                    { "sTitle": "Student mail id", "mData": "mail", "bSortable": false  },
                    { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Credit Combination", "mData": "credit_combination", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.status == 'A') {
                                return '<span style=color:Green;><b>Allocated</b></span>';
                            }
                            else if (data.status == 'R') {
                                return '<span style=color:darkblue;><b>Submitted</b></span>';
                            }
                            else if (data.status == 'P') {
                                return '<span style=color:blue;><b>Allocated</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    },
                    {
                        "sTitle": "Drop Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.course_drop_status == 'Y') {
                                return '<span style=color:red;><b>DROP</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    }


                ]
            }).rowGrouping();
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
       <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; SW Student Course Registration Details
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
                            Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td>
                            Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
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
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>

                    </tr>
                </table>
            </div>
        </div>
        
        <div id="DataList" class="panel panel-default" style="display:none;margin-bottom:40px;">
            <div class="panel-heading">
                <strong id="panel_head">SW Student Course Registration Details</strong>
            </div>

            <div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</asp:Content>

