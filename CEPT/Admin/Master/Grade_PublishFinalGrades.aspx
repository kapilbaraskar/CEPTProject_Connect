<%@ Page Title="Publish Result" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Grade_PublishFinalGrades.aspx.cs" Inherits="Admin_Master_Grade_PublishFinalGrades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Wise Entered Marks
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">

        <div class="panel panel-default" style="">

            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year of allocation
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td class="cls_dept_prog">Department
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                            </tr>
                            <tr>
                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>Assessment Type
                                </td>
                                <td>
                                    <select class="chosen-select" id="drp_exam_type">
                                        <option value="EX">External</option>
                                        <option value="MT">Midterm</option>
                                        <option value="IN">Internal</option>
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnretrieve">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>

        <div id="div_course_list" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong>Course Wise Entered Marks Detail</strong>
            </div>


            <div id="DataList" style="display: none; overflow: auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        </div>

        <div id="div_course_pending" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Course Wise Entered Marks Detail</strong>
            </div>
            <div id="div_tab" class="tabbable" style="display: block; width: 100%; margin-bottom: 20px;">
                <div id="div_myTab">
                </div>
                <div class="tab-content">
                    <div id="pendingcourse" class="tab-pane">
                        <div id="DataList_tab" style="display: block; overflow: auto;">
                            <table cellpadding="0" cellspacing="0" border="0" id="example_tab" class="display table table-striped table-bordered table-hover" width="100%">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="approvedcourses" class="tab-pane">
                        <div id="DataList_approvedcourses" style="display: none;">
                            <table cellpadding="0" cellspacing="0" border="0" id="example_approvedcourses" class="display table table-striped table-bordered table-hover"
                                width="100%">
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



        <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
            <div class="container">
                <div class="row-fluid">
                    <div id="submitBtnDiv" class="controls" style="text-align: right; width: 50%;">
                    </div>
                </div>
                <!--/row-fluid-->
            </div>
            <!--/container-->
        </div>

    </div>

    <script type="text/javascript">
        var oTable, oTable2, oTable1, oTable3;

        $(document).ready(function () {
            if (getParameterByName("autho") == 'false') {
                bootbox.alert('You are not authorized to view this page.', function (result) {
                    window.location.replace('Course_wise_entered_marks.aspx');
                });
            }
            else if (getParameterByName("autho") == 'app') {
                if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D' || $('#hdnusertype').val() == 'FA') {
                    bootbox.alert('You can not edit student marks after submit.', function (result) {
                        window.location.replace('Course_wise_entered_marks.aspx')
                    });
                }
            }

            //if ($('#hdnusertype').val() == 'PC') {
            //    var str = "<div id='div_myTab'><ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Grade Entry and Approval&nbsp;</a></li>" +
            //                    "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li></ul></div>" +
            //            "<div class='tab-content'><div id='pendingcourse' class='tab-pane in active'><div id='DataList_progcoord' style='display: none;'>" +
            //                        "<table cellpadding='0' cellspacing='0' border='0' id='example_progcoord' class='display table table-striped table-bordered table-hover' width='100%'><thead></thead><tbody></tbody></table>" +
            //                    "</div></div>" +
            //                "<div id='mycourses' class='tab-pane'><div id='DataList' style='display: none;'>" +
            //                        "<table cellpadding='0' cellspacing='0' border='0' id='example' class='display table table-striped table-bordered table-hover' width='100%'>" +
            //                            "<thead></thead><tbody></tbody></table></div></div></div>";

            //    $('#div_course_list').removeClass('panel panel-default');
            //    $('#div_course_list').html(str);
            //}
            //else if ($('#hdnusertype').val() == 'D') {
            //    var str = "<div id='div_myTab'><ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Grade Entry and Approval&nbsp;</a></li>" +
            //                    "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li></ul></div>" +
            //            "<div class='tab-content'><div id='pendingcourse' class='tab-pane in active'><div id='DataList_progcoord' style='display: none;'>" +
            //                        "<table cellpadding='0' cellspacing='0' border='0' id='example_progcoord' class='display table table-striped table-bordered table-hover' width='100%'><thead></thead><tbody></tbody></table>" +
            //                    "</div></div>" +
            //                "<div id='mycourses' class='tab-pane'><div id='DataList' style='display: none;'>" +
            //                        "<table cellpadding='0' cellspacing='0' border='0' id='example' class='display table table-striped table-bordered table-hover' width='100%'>" +
            //                            "<thead></thead><tbody></tbody></table></div></div></div>";

            //    $('#div_course_list').removeClass('panel panel-default');
            //    $('#div_course_list').html(str);
            //}

            bindsemdata();
            bindyeardata_for_cross_reg();
            binddepartment();
            bindprogrammedata();

            $('#btnretrieve').on('click', function () {
                course_wise_entered_marks();
                approved_course_list();
                if ($('#drp_exam_type').val() != 'EX') { $('.copyright').css('display', 'none'); } else { $('.copyright').css('display', 'block'); }
                return false;
            });

            setCurrentSemester();
            if ($('#drp_exam_type').val() == 'EX') {
                $("#div_tab").css('display', 'block');
                var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Pending Publish Course&nbsp;</a></li>" +
                    "<li><a data-toggle='tab' href='#approvedcourses'>Publish Course &nbsp; </a></li></ul>";
                $("#div_myTab").html(strHtml);
                $("#pendingcourse").addClass("in active");
                //course_wise_entered_marks();
                //approved_course_list();
            }
            else {

                $("#div_course_pending").css('display', 'none');

                //$("#div_tab").css('display', 'none');
                //$("#div_myTab").css('display', 'none');
                //$("#DataList").css('display', 'block');
            }
        });

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_current_grade_semester",
                //async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            $('#btnretrieve').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();

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

        function rowClick(row) {
            var row_data = oTable.fnGetData(row.closest('tr'));
            var rowId = row_data['course_code'];

            window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }

        function rowClick_1(row) {
            var row_data = oTable1.fnGetData(row.closest('tr'));
            var rowId = row_data['course_code'];

            window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }

        function rowClick_2(row) {
            var row_data = oTable3.fnGetData(row.closest('tr'));
            var rowId = row_data['course_code'];

            window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }

        function rowClick_view(row) {
            var row_data = oTable.fnGetData(row.closest('tr'));

            var rowId = row_data['course_code'];

            window.location = "View_Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }

        function rowClick_view_1(row) {
            var row_data = oTable1.fnGetData(row.closest('tr'));

            var rowId = row_data['course_code'];

            window.location = "View_Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }

        function rowClick_view_2(row) {
            var row_data = oTable3.fnGetData(row.closest('tr'));

            var rowId = row_data['course_code'];

            window.location = "View_Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }



        function send_for_review(row) {
            var row_data = oTable.fnGetData(row.closest('tr'));

            var course_code = row_data['course_code'];

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/send_for_review",
                    //async: false,
                    data: "{course_code:'" + course_code + "', sem_code:'" + semester + "', year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            bootbox.alert(data.d);
                        }
                    },
                    error: function (result) {
                        tempData = [];
                        alert(result);
                    }
                });
        }

        function send_for_review_1(row) {
            var row_data = oTable1.fnGetData(row.closest('tr'));

            var course_code = row_data['course_code'];

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/send_for_review",
                    //async: false,
                    data: "{course_code:'" + course_code + "', sem_code:'" + semester + "', year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            bootbox.alert(data.d);
                        }
                    },
                    error: function (result) {
                        tempData = [];
                        alert(result);
                    }
                });
        }

        function send_for_review_2(row) {
            var row_data = oTable3.fnGetData(row.closest('tr'));

            var course_code = row_data['course_code'];

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/send_for_review",
                    //async: false,
                    data: "{course_code:'" + course_code + "', sem_code:'" + semester + "', year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            bootbox.alert(data.d);
                        }
                    },
                    error: function (result) {
                        tempData = [];
                        alert(result);
                    }
                });
        }


        function publish_all() {
            if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                bootbox.confirm('Are you sure you want to publish Selected courses?', function (result) {
                    if (result == true) {
                        bootbox.confirm('After Publish you can not change grade , Are you sure you want to publish Selected courses?', function (result2) {
                            if (result2 == true) {
                                if (oTable1 != undefined) {
                                    if (oTable1.fnGetData().length > 0) {

                                        var obj_selected_course = $('.cls_chk_course_select:checked');
                                        if (obj_selected_course.length > 0) {
                                            var publish_data = [];
                                            for (var i = 0; i < obj_selected_course.length; i++) {
                                                var row_data = oTable1.fnGetData(obj_selected_course[i].closest('tr'));
                                                if (row_data['ugpg_approval'] != 'Approved') {
                                                    publish_data.push(row_data['course_code']);
                                                }
                                            }

                                            if (publish_data.length > 0) {

                                                var str_publish_data = JSON.stringify(publish_data);

                                                $.ajax({
                                                    type: "POST",
                                                    contentType: "application/json; charset=utf-8",
                                                    url: "../../WebService.asmx/publish_selected_course_grade",
                                                    //async: false,
                                                    data: "{publish_data:'" + str_publish_data + "',sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                                                    dataType: "json",
                                                    success: function (data) {
                                                        if (data.d != "" && data.d != "[]") {
                                                            if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                                                                var res = JSON.parse(data.d);
                                                                if (res["status"].toString() == 'True') bootbox.alert("Course Published Successfully", function () { $('#btnretrieve').click() });
                                                                else bootbox.alert(res["message"].toString());
                                                            }
                                                        }
                                                        else {
                                                            bootbox.alert(data.d);
                                                        }
                                                    },
                                                    error: function (result) {
                                                        alert(result);
                                                    }
                                                });
                                            }
                                            else {
                                                bootbox.alert('No Courses Selected to Publish Course');
                                            }
                                        }
                                        else {
                                            bootbox.alert('No Courses Selected to Publish Course');
                                        }
                                    }
                                }
                            }
                        });
                    }
                });
            }
            else {
                bootbox.alert('You are not Authorized to Publish Course');
            }
        }

        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var exam_type = '';
        function course_wise_entered_marks() {
            $('#DataList').css('display', 'none');
            $('#submitBtnDiv').html('');

            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            dept_code = $('#drpdepartment').val();

            prog_code = $('#drpprog').val();

            exam_type = $('#drp_exam_type').val();

            if (exam_type == 'EX') {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/course_wise_entered_marks_list_Pending_Approve", //course_wise_entered_marks_list_AD_new
                        //async: false,
                        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',status:'P'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                                    //course_wise_entered_marks_list(data.d);
                                    course_wise_entered_marks_list_new_tab(data.d);
                                }
                                $('#div_course_list').css('display', 'none');
                                $('#div_course_pending').css('display', 'block');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                if ($('#hdnusertype').val() != 'PC') {
                                    $('#div_course_list').css('display', 'none');
                                }
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/course_wise_midterm_exam_dtl",
                        //async: false,
                        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',exam_type:'" + exam_type + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                //17092021
                                if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                                    course_wise_entered_marks_list_midterm(data.d);
                                }
                                $('#div_course_list').css('display', 'block');
                                //new
                                $("#div_course_pending").css('display', 'none');


                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                if ($('#hdnusertype').val() != 'PC') {
                                    $('#div_course_list').css('display', 'none');
                                }
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }

            return false;
        }

        function course_wise_entered_marks_list_new_tab(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList_tab").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_tab" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example_tab").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    {
                        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, fnRender: function (data) {
                            //changes 17092021
                            if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                                if (data.aData.ugpg_approval != 'Approved' && data.aData.faculty_approval == 'Approved' && data.aData.progcoordinate_approval == 'Approved' && data.aData.grade_range_submit != '') {
                                    //if (data.aData.ugpg_approval != 'Approved') {
                                    return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" />';
                                }
                                else return '';
                            }
                            else return '';
                        }
                    },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                    { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },
                    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
                    { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },
                    {
                        "sTitle": "", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                if (data.aData.ugpg_approval != 'Approved') {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_1(this)">Edit</button></center>';
                                }
                                else {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view_1(this)">View</button></center>';
                                }
                            }
                            else {
                                return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view_1(this)">View</button></center>';
                            }
                        }
                    },
                    {
                        "sTitle": "Send for Review", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                if (data.aData.faculty_approval == 'Approved' && data.aData.ugpg_approval != 'Approved') {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="send_for_review_1(this)">Send</button></center>';
                                }
                                else {
                                    return '';
                                }
                            }
                            else {
                                return '';
                            }
                        }
                    }
                ]
            });

            $('#DataList_tab').css('display', 'block');
            //17092021
            if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                $('#submitBtnDiv').html('<button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="publish_all()">Publish All</button>');
            }
        }

        function course_wise_entered_marks_list_new_tab_approve(data) {
            if (oTable3 != null) {
                oTable3.fnDestroy();
                $("#DataList_approvedcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approvedcourses" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable3 = $("#example_approvedcourses").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    {
                        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                if (data.aData.ugpg_approval != 'Approved' && data.aData.faculty_approval == 'Approved' && data.aData.progcoordinate_approval == 'Approved') {
                                    //if (data.aData.ugpg_approval != 'Approved') {
                                    return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" />';
                                }
                                else return '';
                            }
                            else return '';
                        }
                    },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                    { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },
                    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
                    { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },
                    {
                        "sTitle": "", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                if (data.aData.ugpg_approval != 'Approved') {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_2(this)">Edit</button></center>';
                                }
                                else {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view_2(this)">View</button></center>';
                                }
                            }
                            else {
                                return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view_2(this)">View</button></center>';
                            }
                        }
                    },
                    {
                        "sTitle": "Send for Review", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                if (data.aData.faculty_approval == 'Approved' && data.aData.ugpg_approval != 'Approved') {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="send_for_review_2(this)">Send</button></center>';
                                }
                                else {
                                    return '';
                                }
                            }
                            else {
                                return '';
                            }
                        }
                    },
                    { "sTitle": "Date (MM/DD/YYYY)", "mData": "last_modified_date", "bSortable": false }
                ]
            });

            $('#DataList_tab').css('display', 'block');
            if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                $('#submitBtnDiv').html('<button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="publish_all()">Publish All</button>');
            }
        }

        function approved_course_list() {
            $('#DataList_approvedcourses').css('display', 'none');

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/course_wise_entered_marks_list_Pending_Approve", //course_wise_entered_marks_list_AD_new
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',status:'A'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            //17092021
                            if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                                //course_wise_entered_marks_list(data.d);
                                course_wise_entered_marks_list_new_tab_approve(data.d);
                            }
                            //$('#div_course_list').css('display', 'block');
                            $('#DataList_approvedcourses').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            if ($('#hdnusertype').val() != 'PC') {
                                $('#div_course_list').css('display', 'none');
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }





        function course_wise_entered_marks_list(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    {
                        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                //if (data.aData.ugpg_approval != 'Approved' && data.aData.faculty_approved == 'Approved' && data.aData.progcoordinate_approved == 'Approved') {
                                if (data.aData.ugpg_approval != 'Approved') {
                                    return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" />';
                                }
                                else return '';
                            }
                            else return '';
                        }
                    },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                    { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },
                    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
                    { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },
                    {
                        "sTitle": "", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                if (data.aData.ugpg_approval != 'Approved') {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick(this)">Edit</button></center>';
                                }
                                else {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view(this)">View</button></center>';
                                }
                            }
                            else {
                                return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view(this)">View</button></center>';
                            }
                        }
                    },
                    {
                        "sTitle": "Send for Review", "mData": null, "bSortable": false, fnRender: function (data) {
                            if ($('#hdnusertype').val() == 'AD') {
                                if (data.aData.faculty_approval == 'Approved' && data.aData.ugpg_approval != 'Approved') {
                                    return '<center><button type="button" class="btn btn-small btn-primary" onclick="send_for_review(this)">Send</button></center>';
                                }
                                else {
                                    return '';
                                }
                            }
                            else {
                                return '';
                            }
                        }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            //if ($('#hdnusertype').val() == 'AD') {
            //    $('#submitBtnDiv').html('<button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="publish_all()">Publish All</button>');
            //}
        }

        var max_exams = 0;
        function course_wise_entered_marks_list_midterm(data) {

            var row_data = JSON.parse(data)[0];
            max_exams = parseInt(row_data['max_exams']);
            var obj_col = [{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false }];

            //{ "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, fnRender: function (data) {
            //    if ($('#hdnusertype').val() == 'AD') {
            //        if (data.aData.ugpg_approval != 'Approved') {
            //            return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" />';
            //        }
            //        else return '';
            //    }
            //    else return '';
            //}
            //},

            for (var i = 0; i < max_exams; i++) {
                //obj_col.push({ "sTitle": "Exam" + (i + 1), "mData": "title" + (i + 1), "bSortable": false });

                obj_col.push({
                    "sTitle": "Exam" + (i + 1) + "<br><button id='btn_exam_" + (i + 1) + "' type='button' class='btn btn-small btn-primary' style='margin-top:5px;' onclick='submit_exam(\"exam" + (i + 1) + "\")'>Submit</button>",
                    "mData": null, "bSortable": false, "sClass": "cls_exam_head", fnRender: function (data) {
                        if (i == max_exams) i = 0;

                        if (data.aData['exam' + (i + 1)] != '') {
                            if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                                if (data.aData[data.aData['exam' + (i + 1)] + '_eligible'] == 'Y') {
                                    return '<div><input type="checkbox" class="cls_chk_exam' + (i + 1) + '" style="float:left;" value="' + data.aData['exam' + (i + 1)] + '" />' +
                                        '</div><div style="margin-left:20px;">' + data.aData['title' + (i++ + 1)] + '</div>';
                                }
                                else {
                                    return '<div style="margin-left:20px;">' + data.aData['title' + (i++ + 1)] + '</div>';
                                }
                            }
                            else {
                                return '<div style="margin-left:20px;">' + data.aData['title' + (i++ + 1)] + '</div>';
                            }
                        }
                        else {
                            i++;
                            return '';
                        }
                    }
                });
            }

            obj_col.push({ "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false });
            obj_col.push({ "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false });
            obj_col.push({ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false });
            obj_col.push({ "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false });

            obj_col.push({
                "sTitle": "", "mData": null, "bSortable": false, fnRender: function (data) {
                    if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
                        if (data.aData.ugpg_approval != 'Approved') {
                            return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick(this)">Edit</button></center>';
                        }
                        else {
                            return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view(this)">View</button></center>';
                        }
                    }
                    else {
                        return '<center><button type="button" class="btn btn-small btn-primary" onclick="rowClick_view(this)">View</button></center>';
                    }
                }
            });

            //obj_col.push({ "sTitle": "Send for Review", "mData": null, "bSortable": false, fnRender: function (data) {
            //    if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1') {
            //        if (data.aData.faculty_approval == 'Approved' && data.aData.ugpg_approval != 'Approved') {
            //            return '<center><button type="button" class="btn btn-small btn-primary" onclick="send_for_review(this)">Send</button></center>';
            //        }
            //        else {
            //            return '';
            //        }
            //    }
            //    else {
            //        return '';
            //    }
            //}
            //});

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": obj_col
            });

            $('#DataList').css('display', 'block');
            //if ($('#hdnusertype').val() == 'AD') {
            //    $('#submitBtnDiv').html('<button id="btn_submit_exam_all" type="button" class="btn btn-lg btn-primary" onclick="submit_exam_all()">Submit All Exam</button>');
            //}
            // $('.copyright').css('display', 'none');
            $('.cls_exam_head').css('width', '100px');
        }

        function submit_exam(submit_exam_code) {
            var selected_exams = $('.cls_chk_' + submit_exam_code + ':checked');

            if (selected_exams.length > 0) {
                var obj_exam_dtl = [];

                for (var i = 0; i < selected_exams.length; i++) {
                    if (selected_exams[i].checked) {
                        var cur_tr_data = oTable.fnGetData($(selected_exams[i]).closest('tr')[0]);

                        obj_exam_dtl.push({ 'course_code': cur_tr_data['course_code'], 'exam_code': selected_exams[i].value });
                    }
                }

                if (obj_exam_dtl.length > 0) {
                    var obj_req = { exam_dtl: obj_exam_dtl, sem_code: semester, year_code: year_code };

                    $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService.asmx/submit_exam_marks_all",
                            //async: false,
                            data: "{req_obj:'" + JSON.stringify(obj_req) + "'}",
                            dataType: "json",
                            success: function (data) {
                                bootbox.alert(data.d);
                                course_wise_entered_marks();
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                }
            }
            else {
                bootbox.alert('No exams are selected to submit');
            }
        }

        function select_all_change() {
            if ($('#chk_select_all')[0].checked) {
                $('.cls_chk_course_select').attr('checked', 'checked');
            }
            else {
                $('.cls_chk_course_select').removeAttr('checked');
            }
        }

        function course_select_change(cur_ele) {
            if (cur_ele.checked) {
                if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
                    $('#chk_select_all')[0].checked = true;
            }
            else {
                $('#chk_select_all')[0].checked = false;
            }
        }
    </script>

</asp:Content>
