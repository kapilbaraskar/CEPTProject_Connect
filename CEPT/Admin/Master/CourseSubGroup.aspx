<%@ Page Title="Course Sub Group" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="CourseSubGroup.aspx.cs" Inherits="Admin_Master_CourseSubGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var cur_sem;
        var cur_year;
        var course_code;
        var oTable_instructor;
        var oTable_student;
        var str_drp_options = '<option value="">-- Select Course Sub Group --</option>';

        $(document).ready(function () {
            $('.container').width($('#main-content').width());

            bindyeardata_for_cross_reg();
            binddepartment();
            get_fauser_detail();

            $('#btnRetrieve').on('click', function () {
                get_sub_group_data();
            });

            $('#btn_save').on('click', function () {
                save_sub_group_data();
            });

            $('#drpsem,#drpyear,#drpdepartment').on('change', function () {
                bindDrpCourse();
            });
        });

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

        function get_fauser_detail() {
            if ($('#hdnusertype').val() == 'FA') {
                
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_department_wise_user_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);
                            $('#drpdepartment').val(user_data[0]['dept_code']);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }

        function bindDrpCourse() {
            if ($('#drpsem').val() != '' && $('#drpyear').val() != '' && $('#drpdepartment').val() != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_course_list_for_subgroup",
                    data: "{sem_code :'" + $('#drpsem').val() + "' , year_code :'" + $('#drpyear').val() + "',dept_code: '" + $('#drpdepartment').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        $('#drpcourse').empty().append($("<option></option>").val("").html("-- Please Select Course --"));

                        if (data.d != "") {
                            var course_data = JSON.parse(data.d)

                            for (var i = 0; i < course_data.length; i++) {
                                $('#drpcourse').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"] + ' - ' + course_data[i]["course_name"]));
                            }
                        }

                        $('#drpcourse').chosen();
                        $("#drpcourse").trigger("liszt:updated");
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }

        function get_sub_group_data() {
            $('#div_course_sub_group_dtl').css('display', 'none');
            $('.copyright').css('display', 'none');
            $('#DataList_instructor').css('display', 'none');
            $('#DataList_student').css('display', 'none');
            $('#example_instructor').html('<thead></thead><tbody></tbody>');
            $('#example_student').html('<thead></thead><tbody></tbody>');
            $('#drp_total_sub_group').val('');
            $('#drp_total_sub_group').change();

            cur_sem = $('#drpsem').val();
            if (cur_sem == "") {
                bootbox.alert('Please select semester');
                $('#drpsem').focus();
                return false;
            }

            cur_year = $('#drpyear').val();
            if (cur_year == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            course_code = $('#drpcourse').val();
            if (course_code == "" || course_code == null) {
                bootbox.alert('Please select course');
                $('#drpcourse').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_course_subgroup_dtl",
                async: false,
                data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',course_code: '" + course_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d[2] != null && data.d[2] != '') {
                        $('#drp_total_sub_group').val(JSON.parse(data.d[2]).length);
                        $('#drp_total_sub_group').change();
                    }
                    else {
                        $('#drp_total_sub_group').val('');
                        $('#drp_total_sub_group').change();
                    }

                    if (data.d[0] != null && data.d[0] != '') {
                        display_instructor_data(JSON.parse(data.d[0]));
                    }

                    if (data.d[1] != null && data.d[1] != '') {
                        display_student_data(JSON.parse(data.d[1]));
                    }

                    $('#spn_pnl_title').val('');
                    $('#div_course_sub_group_dtl').css('display', 'block');
                    $('.copyright').css('display', 'block');
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function display_instructor_data(data) {
            if (oTable_instructor != null) {
                oTable_instructor.fnDestroy();
                $("#DataList_instructor").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_instructor" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable_instructor = $("#example_instructor").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},
                "aaData": data,
                "aoColumns": [
                    { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
                    { "sTitle": "Instructor Type", "mData": "instructor_type", "bSortable": false },
                    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "Course Sub Group", "mData": null, "bSortable": false, "mRender": function (course_code) {
                        return '<center><select class="cls_drp_sub_group">' + str_drp_options + '</select></center>';
                    }
                    }
                ]
            });

            $('#example_instructor tbody tr').each(function (i) {
                var row_data = oTable_instructor.fnGetData(this);

                $(this).find('.cls_drp_sub_group').val(row_data['sub_group_id']);
            });

            $('#DataList_instructor').css('display', 'block');
        }

        function display_student_data(data) {
            if (oTable_student != null) {
                oTable_student.fnDestroy();
                $("#DataList_student").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_student" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable_student = $("#example_student").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},
                "aaData": data,
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Course Sub Group", "mData": null, "bSortable": false, "mRender": function (course_code) {
                        return '<center><select class="cls_drp_sub_group">' + str_drp_options + '</select></center>';
                    }
                    }
                ]
            });

            $('#example_student tbody tr').each(function (i) {
                var row_data = oTable_student.fnGetData(this);

                $(this).find('.cls_drp_sub_group').val(row_data['sub_group_id']);
            });

            $('#DataList_student').css('display', 'block');
        }

        function save_sub_group_data() {
            var obj_instructor_subgroup = [];
            var obj_student_subgroup = [];

            if ($('#drp_total_sub_group').val() == '') {
                bootbox.alert('Please select Total Sub Groups');
                return false;
            }

            var check_subgroup = true;
            $('#example_instructor tbody tr').each(function (i) {
                var row_data = oTable_instructor.fnGetData(this);

                if ($(this).find('.cls_drp_sub_group').val() == '')
                    check_subgroup = false;
                else
                    obj_instructor_subgroup.push({ 'instructor_code': row_data['instructor_code'], 'instructor_type': row_data['instructor_type'], 'sub_group': $(this).find('.cls_drp_sub_group').val() });
            });
            if (!check_subgroup) {
                bootbox.alert('Please select Sub Group for all Instructors');
                return false;
            }

            check_subgroup = true;
            $('#example_student tbody tr').each(function (i) {
                var row_data = oTable_student.fnGetData(this);

                if ($(this).find('.cls_drp_sub_group').val() == '')
                    check_subgroup = false;
                else
                    obj_student_subgroup.push({ 'user_id': row_data['user_id'], 'sub_group': $(this).find('.cls_drp_sub_group').val() });
            });
            if (!check_subgroup) {
                bootbox.alert('Please select Sub Group for all Students');
                return false;
            }

            var req_data = { course_code: course_code, sem_code: cur_sem, year_code: cur_year, total_subgroup: $('#drp_total_sub_group').val(), instructor_subgroup: obj_instructor_subgroup, student_subgroup: obj_student_subgroup };

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_course_subgroup_dtl",
                async: false,
                data: "{req_data:'" + JSON.stringify(req_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != '' && data.d != []) {
                        var res = JSON.parse(data.d);

                        bootbox.alert(res['message']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function drp_total_sub_group_change() {
            str_drp_options = '<option value="">-- Select Course Sub Group --</option>';

            for (var i = 1; i <= parseInt($('#drp_total_sub_group').val()); i++) {
                var str_value = course_code + '_SG' + (('000' + i).substr(('000' + i).length - 2));
                str_drp_options += '<option value="' + str_value + '">' + str_value + '</option>';
            }

            $('#example_instructor tbody tr').each(function (i) {
                var temp_value = $(this).find('.cls_drp_sub_group').val();
                $(this).find('.cls_drp_sub_group').html(str_drp_options);
                $(this).find('.cls_drp_sub_group').val(temp_value);
            });

            $('#example_student tbody tr').each(function (i) {
                var temp_value = $(this).find('.cls_drp_sub_group').val();
                $(this).find('.cls_drp_sub_group').html(str_drp_options);
                $(this).find('.cls_drp_sub_group').val(temp_value);
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panel-default">
        <div class="panel-heading">
            <strong><span class="panel-headingfont">Retrieve Course Data</span></strong>
        </div>
        <div style="padding: 15px;">
            <div class="row">
                <div class="form-group col-md-1" style="padding-top: 8px;">Semester :</div>
                <div class="form-group col-md-3" style="padding-top: 6px;">
                    <select class="chosen-select" id="drpsem">
                        <option value="M">Monsoon</option>
                        <option value="S">Spring</option>
                    </select>
                </div>
                <div class="form-group col-md-1" style="padding-top: 8px;">Year :</div>
                <div id="div_cur_sem_course" class="form-group col-md-3" style="padding-top: 6px;">
                    <select class="chosen-select" id="drpyear"></select>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-1" style="padding-top: 8px;">Department</div>
                <div class="form-group col-md-3" style="padding-top: 6px;">
                    <select class="chosen-select" id="drpdepartment"></select>
                </div>
                <div class="form-group col-md-1" style="padding-top: 8px;">Course :</div>
                <div class="form-group col-md-3" style="padding-top: 6px;">
                    <select class="chosen-select" id="drpcourse"></select>
                </div>
                <div class="form-group col-md-2">
                    <button class="btn btn-primary" type="button" id="btnRetrieve"><i class="icon-plus"></i>&nbsp; Retrieve</button>
                </div>
            </div>
        </div>
    </div>

    <div id="div_course_sub_group_dtl" class="panel panel-default" style="margin-bottom:80px;display:none;">
        <div class="panel-heading">
            <strong><span id="spn_pnl_title" class="panel-headingfont">Course Sub Group Detail</span></strong>
        </div>
        <div style="padding: 15px;">
            <div style="margin-bottom:10px;">
                <span>Select Total Sub Group : </span>
                <select id="drp_total_sub_group" onchange="drp_total_sub_group_change()">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                </select>
            </div>

            <div id="div_tab" class="tabbable" style="display: block; width: 100%; margin-bottom: 20px;">
                <div id="div_myTab">
                    <ul class="nav nav-tabs" id="myTab">
                        <li class="active"><a data-toggle="tab" href="#instructor_tab">Instructor&nbsp;</a></li>
                        <li><a data-toggle="tab" href="#student_tab">Student &nbsp; </a></li>
                    </ul>
                </div>

                <div class="tab-content">
                    <div id="instructor_tab" class="tab-pane active">
                        <div id="DataList_instructor" style="display: none;">
                            <table cellpadding="0" cellspacing="0" border="0" id="example_instructor" class="display table table-striped table-bordered table-hover" width="100%">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="student_tab" class="tab-pane">
                        <div id="DataList_student" style="display: none;">
                            <table cellpadding="0" cellspacing="0" border="0" id="example_student" class="display table table-striped table-bordered table-hover" width="100%">
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
    </div>

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; display: none;">
        <div id="div_buttons" class="container" runat="server">
            <div class="row-fluid">
                <div class="span11" style="margin: 10px;" align="center">
                    <button type="button" id="btn_save" style="line-height: inherit;" class="btn btn-lg btn-primary">
                        <i class="icon-save bigger-160"></i>Save
                    </button>
                    <%--<input type="button" id="btn_save" class="btn btn-lg btn-primary" style="line-height: inherit;" value="Save" />--%>
                    <%--<button id="btnsave" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                        <i class="icon-save bigger-160"></i>Register
                    </button>--%>
                </div>
            </div>
        </div>
    </div>
</asp:Content>