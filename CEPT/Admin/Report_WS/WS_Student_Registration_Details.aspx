<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_Student_Registration_Details.aspx.cs" Inherits="Admin_Report_WS_WS_Student_Registration_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">

        var oTable;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindprogramme();
            bindtypedata();

            $('#btnreterive').on('click', function () {
                get_reg_student_dtl();
                return false;

            });

            $('#drpsemester').on('change', function () {

                if ($('#drpsemester').val() != '') {
                    if ($('#drpyear').val() != '') {
                        $('#drpcoursecode').trigger("liszt:updated");
                        bindallcoursedata();
                    }

                }

            });


            $('#drpyear').on('change', function () {

                if ($('#drpyear').val() != '') {
                    if ($('#drpsemester').val() != '') {
                        $('#drpcoursecode').trigger("liszt:updated");
                        bindallcoursedata();
                    }

                }

            });


            $('#drpdepartment').on('change', function () {

                if ($('#drpdepartment').val() != '') {
                    $('#drpstudent').trigger("liszt:updated");
                    bindallstudentdata();
                }

            });
            $('#drpprog').on('change', function () {

                if ($('#drpprog').val() != '') {
                    $('#drpstudent').trigger("liszt:updated");
                    bindallstudentdata();
                }
            });
            return false;
        });

        function bindprogramme() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
        }

        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
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

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            $('#drpsemester').chosen();
        }

        function bindtypedata() {
            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("R").html("Registered"));
            $('#drptype').append($("<option></option>").val("W").html("Waiting "));
            $('#drptype').append($("<option></option>").val("C").html("Cancelled"));
            $('#drptype').append($("<option></option>").val("CC").html("Course Cancelled"));
            $('#drptype').append($("<option></option>").val("D").html("Drop"));
            $('#drptype').append($("<option></option>").val("A").html("Allocated"));
            $('#drptype').append($("<option></option>").val("E").html("Expire"));
            $('#drptype').chosen();
        }

        function binddepartment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                async: false,
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

        function bindallstudentdata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Ws_student_dtl",
                data: "{sem_code:'" + $('#drpsemester').val() + "',year_code:'" + $('#drpyear').val() + "' ,dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var data = JSON.parse(data.d)

                        $('#drpstudent').empty().append($("<option></option>").val("").html("-- Please Select Student --"));

                        for (var i = 0; i < data.length; i++) {
                            $('#drpstudent').append($("<option></option>").val(data[i]["user_id"]).html(data[i]["user_id"]));
                        }

                        $('#drpstudent').chosen();
                        $('#drpstudent').trigger("liszt:updated");
                    }
                    else {
                        $('#drpstudent').find('option').remove().end().append('<option value="">No Student found</option>').val('');
                        $('#drpstudent').chosen();
                        $('#drpstudent').val('').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_reg_student_dtl() {

            $('#DataList').css('display', 'none');
            var sem_code = $('#drpsemester').val();
            if (sem_code == "") {
                bootbox.alert('Please select Semester')
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
            var prog_code = $('#drpprog').val();
            var student_code = $('#drpstudent').val();
            if (student_code == null) {
                student_code = '';
            }
            var type = $('#drptype').val();
            var course_code = '';
            if ($('#drpcoursecode').val() != '' && $('#drpcoursecode').val() != null) {
                course_code = $('#drpcoursecode').val();
               // dept_code = '';
               // student_code = '';
               // prog_code = '';
               // type = '';
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Ws_Reg_student_dtl",
                data: "{sem_code :'" + sem_code + "',year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',type: '" + type + "',student_code:'" + student_code + "',course_code:'" + course_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d != "") {
                            Display_saved_Data(data.d);
                        }
                        else {
                            if (data.d == "") {
                                bootbox.alert('There is No data Found For Selected student');
                                return false;
                            }

                        }
                    }
                    else {

                        bootbox.alert('There is No data Found For Selected student');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function Display_saved_Data(data) {

            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();


                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Status", "mData": "status_name", "bSortable": false }
                ]

            });

            $('#DataList').css('display', 'block');
        }


        function bindallcoursedata() {

            var sem_code = $('#drpsemester').val();
            if (sem_code == "") {
                bootbox.alert('Please select Semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Ws_Reg_course_dtl",
                data: "{sem_code :'" + sem_code + "',year_code : '" + year_code + "',dept_code: '',prog_code: '',type: '',student_code:''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var data = JSON.parse(data.d)

                        $('#drpcoursecode').empty().append($("<option></option>").val("").html("-- Please Select Course Code --"));

                        for (var i = 0; i < data.length; i++) {
                            $('#drpcoursecode').append($("<option></option>").val(data[i]["course_code"]).html(data[i]["course_code"]));
                        }

                        $('#drpcoursecode').chosen();
                        $('#drpcoursecode').trigger("liszt:updated");
                    }
                    else {
                        $('#drpcoursecode').find('option').remove().end().append('<option value="">No Course Code found</option>').val('');
                        $('#drpcoursecode').chosen();
                        $('#drpcoursecode').val('').trigger("liszt:updated");
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
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;WS Student Registration Details
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td>Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                    </tr>
                    <tr>
                        <td>Programme :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>

                        <td>Type :
                        </td>
                        <td>
                            <select class="chosen-select" id="drptype">
                            </select>
                        </td>

                        <td>Student :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>

                    </tr>

                    <tr>
                        <td colspan="8" style="border-bottom: 2px solid #ddd;"></td>
                    </tr>
                    <tr>
                        <td>Course Code :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpcoursecode" />
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

        <div id="DataList" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Student Registration Details</strong>
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

