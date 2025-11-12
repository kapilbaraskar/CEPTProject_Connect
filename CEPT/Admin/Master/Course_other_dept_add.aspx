<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Course_other_dept_add.aspx.cs" Inherits="Admin_Master_Course_other_dept_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        var sem_code = '';
        var year_code = '';
        var course_code = '';

        $(document).ready(function () {
            bindsemdata();
            bindyeardata();
            setCurrentSemester();

            binddepartment();
            bindprogrammedata();
            bindsemesterdata();
            bindproglevel();

            $('#drpsemester,#drpyear').on('change', function () {
                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));
                $('#drcourses').trigger("liszt:updated");

                if ($('#drpsemester').val() != '' && $('#drpyear').val() != '') {
                    bind_drp_course();
                }
            });

            $('#btnRetrieve').click(function () {
                GetSelectedCourseData();
            });

            $('#btn_add_other_dept').click(function () {
                Add_other_dept();
            });

            $('#btn_save_other_dept').click(function () {
                Save_other_dept();
            });
        });

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
        }

        function bindyeardata() {
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

        function bind_drp_course() {
            sem_code = $('#drpsemester').val();
            if (sem_code == '') {
                //bootbox.alert('Please select semester');
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == '') {
                //bootbox.alert('Please select year');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_all_course_data_For_Modification",
                async: false,
                data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drcourses').append($("<option></option>").val(year_data[i]["course_code"]).html(year_data[i]["course_code"]));
                        }

                        $('#drcourses').chosen();
                        $('#drcourses').trigger("liszt:updated");
                    }
                    else {
                        $('#drcourses').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                        $('#drcourses').chosen();
                        $('#drcourses').val('').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type : 'course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            $('#drpsemester').trigger("change");
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var str_dept_option = '';
        function binddepartment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var dept_data = JSON.parse(data.d);

                        str_dept_option += '<option value="">-- Please Select Department --</option>';
                        for (var i = 0; i < dept_data.length; i++) {
                            str_dept_option += '<option value="' + dept_data[i]["dept_code"] + '">' + dept_data[i]["dept_name"] + '</option>';
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var str_prog_option = '';
        function bindprogrammedata() {
            str_prog_option += '<option value="">-- Please Select Program Level --</option>';
            str_prog_option += '<option value="1">Undergraduate</option>';
            str_prog_option += '<option value="2">Postgraduate</option>';
            str_prog_option += '<option value="3">Doctoral</option>';
        }

        var str_semester_option = '';
        function bindsemesterdata() {
            str_semester_option += '<option value="">-- Please Select Student Semester --</option>';
            str_semester_option += '<option value="1">1</option>';
            str_semester_option += '<option value="2">2</option>';
            str_semester_option += '<option value="3">3</option>';
            str_semester_option += '<option value="4">4</option>';
            str_semester_option += '<option value="5">5</option>';
            str_semester_option += '<option value="6">6</option>';
            str_semester_option += '<option value="7">7</option>';
            str_semester_option += '<option value="8">8</option>';
            str_semester_option += '<option value="9">9</option>';
            str_semester_option += '<option value="10">10</option>';
        }

        var str_prog_level_option = '';
        function bindproglevel() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d)

                        str_prog_level_option += '<option value="">-- Please Select Program Type --</option>';
                        for (var i = 0; i < prog_level_data.length; i++) {
                            str_prog_level_option += '<option value="' + prog_level_data[i]["prog_level_code"] + '">' + prog_level_data[i]["prog_level_desc"] + '</option>';
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function GetSelectedCourseData() {
            $('#div_add_other_dept').css('display', 'none');
            $('#tbl_add_other_dept').css('display', 'none');
            $('#btn_save_other_dept').css('display', 'none');
            $('#tbl_add_other_dept tbody').html('');

            sem_code = $('#drpsemester').val();
            if (sem_code == '') {
                bootbox.alert('Please Select Semester');
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == '') {
                bootbox.alert('Please Select Year');
                return false;
            }

            course_code = $('#drcourses').val();
            if (course_code == '') {
                bootbox.alert('Please Select Course');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_data_for_other_dept",
                async: false,
                data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code:'" + course_code + "'}",
                dataType: "json",
                success: function (data) {
                    debugger;
                    if (data.d[0] != null) {
                        var course_data = JSON.parse(data.d[0]);

                        if (course_data[0]['ugpgoffice_approved'] == 'Y' && course_data[0]['cancel_flag'] == 'N') {
                            if (data.d[1] != null) {
                                var course_dept = JSON.parse(data.d[1]);

                                //course_dept
                            }

                            if (data.d[2] != null) {
                                var course_other_dept = JSON.parse(data.d[2]);

                                if (course_other_dept.length > 0) {
                                    for (var i = 0; i < course_other_dept.length; i++) {
                                        $('#btn_add_other_dept').click();

                                        $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_dept').val(course_other_dept[i]['dept_code']);
                                        $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_prog').val(course_other_dept[i]['prog_code']);
                                        $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_prog_level_code').val(course_other_dept[i]['prog_level_code']);
                                        $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_semester').val(course_other_dept[i]['semester_code']);
                                    }
                                }
                            }

                            $('#div_add_other_dept').css('display', '');
                        }
                        else {
                            bootbox.alert("Course not published yet. Please publish the course to add other department detail.");
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function Add_other_dept() {
            var str_html = '';

            str_html += '<tr><td><select class="cls_dept">' + str_dept_option + '</select></td><td><select class="cls_prog">' + str_prog_option + '</select></td>' +
                        '<td><select class="cls_prog_level_code">' + str_prog_level_option + '</select></td><td><select class="cls_semester">' + str_semester_option + '</select></td>' +
                        '<td><center><i class="icon-trash icon-2x text-blue" style="cursor:pointer;"></i></center></td></tr>';

            $('#tbl_add_other_dept tbody').append(str_html);

            if ($('#tbl_add_other_dept tbody tr').length > 0) {
                $('#tbl_add_other_dept').css('display', '');
                $('#btn_save_other_dept').css('display', '');
            }
        }

        function Save_other_dept() {
            if ($('#tbl_add_other_dept tbody tr').length > 0) {
                var arr_course_other_dept = [];

                for (var i = 0; i < $('#tbl_add_other_dept tbody tr').length; i++) {
                    var temp_dept = $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_dept').val();
                    var temp_prog = $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_prog').val();
                    var temp_prog_level = $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_prog_level_code').val();
                    var temp_sem = $('#tbl_add_other_dept tbody tr').eq(i).find('.cls_semester').val();

                    if (temp_dept != '' && temp_prog != '' && temp_prog_level != '' && temp_sem != '') {
                        arr_course_other_dept.push({ 'dept_code': temp_dept, 'prog_code': temp_prog, 'prog_level_code': temp_prog_level, 'semester': temp_sem });
                    }
                    else {
                        bootbox.alert('All fields are mandatory. Please Enter all detail to Save Other Course Detail');
                        break;
                    }
                }

                if (arr_course_other_dept.length > 0) {
                    var obj_course_other_dept = { 'sem_code': sem_code, 'year_code': year_code, 'course_code': course_code, 'course_other_dept': JSON.stringify(arr_course_other_dept) };

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/save_course_data_for_other_dept",
                        async: false,
                        data: JSON.stringify(obj_course_other_dept),
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                bootbox.alert(data.d, function () {
                                    location.reload();
                                });
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }
                else {
                    bootbox.alert('No Data Found to Save Other Course Detail');
                }
            }
            else {
                bootbox.alert('No Data Found to Save Other Course Detail');
            }
        }

        $('#tbl_add_other_dept tbody tr td i.icon-trash').live('click', function (e) {
            var r = confirm("Are you sure you want to remove this?");

            if (r == true) {
                var datalist = [];
                var flag = 'Y';
                var ob = {};
                var thisdata = $(this).closest("tr");

                $(this).closest("tr").remove();
                var totalsum = 0;
            }

            if ($('#tbl_add_other_dept tbody tr').length == 0) {
                $('#tbl_add_other_dept').css('display', 'none');
                $('#btn_save_other_dept').css('display', 'none');
            }
        });

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Add Course Other Department
            </h1>
        </div>
    </div>

    <div id="course_select" class="panel panel-default">
        <div class="panel-heading">
            <strong><span class="panel-headingfont">Course Selection</span></strong></div>
        <div style="padding: 15px;" id="div3">
            <div class="row">
                <div id="div_drpsem" class="form-group col-md-4">
                    <div class="col-md-3" style="padding: 0 0 0 0;">Semester :</div>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drpsemester">
                        </select>
                    </div>
                </div>
                <div id="div_drpyear" class="form-group col-md-3">
                    <div class="col-md-3" style="padding: 0 0 0 0;">Year :</div>
                    <div class="col-md-8" style="padding: 0 0 0 0;">
                        <select class="chosen-select col-md-12" id="drpyear">
                        </select>
                    </div>
                </div>
                <div id="div_drpcourse" class="form-group col-md-3">
                    <div class="col-md-3" style="padding: 0 0 0 0;">Course :</div>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drcourses">
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div style="margin-left: 41%;" class="form-group col-md-12">
                    <button class="btn  btn-primary" type="button" id="btnRetrieve"><i class="icon-plus"></i>&nbsp; Retrieve</button>
                </div>
            </div>
        </div>
    </div>
    
    <div id="div_add_other_dept" class="panel panel-default" style="display:none;">
        <div class="panel-heading">
            <strong><span class="panel-headingfont">Add Course Other Department Detail</span></strong></div>
        <div style="padding: 15px;">
            <button class="btn btn-primary btn-small" type="button" id="btn_add_other_dept"><i class="icon-plus"></i>&nbsp; Add</button>

            <table id="tbl_add_other_dept" class="table table-bordered table-striped" style="display:none;">
                <thead>
                    <tr>
                        <th>Faculty</th>
                        <th>Program Level</th>
                        <th>Program Type</th>
                        <th>Student Semester</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>

            <div align="center">
                <button class="btn btn-primary btn-small" type="button" id="btn_save_other_dept" style="display:none;"><i class="icon-save"></i>&nbsp; Save</button>
            </div>
        </div>
    </div>
</asp:Content>