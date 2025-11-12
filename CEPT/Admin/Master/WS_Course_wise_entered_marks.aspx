<%@ Page Title="Course Wise Entered Marks" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_Course_wise_entered_marks.aspx.cs" Inherits="Admin_Master_WS_Course_wise_entered_marks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">

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

        });

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>
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

        <div class="panel panel-default">
            
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div> <%--class="panel-body"--%>
                <div>
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
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
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
            
            <div> <%--class="panel-body"--%>
                <div id="DataList" style="display: none;">
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

        <div id="div_btn" style="text-align: center;">
            
        </div>

        <%--<div id="div_tab" class="tabbable" style="width: 100%; margin-bottom: 20px;">
            <div id="div_myTab">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a data-toggle="tab" href="#pendingcourse">Course Wise Entered Marks Detail&nbsp;</a></li>
                    <li><a data-toggle="tab" href="#mycourses">My Courses &nbsp; </a></li>
                </ul>
            </div>
            <div class="tab-content">
                <div id="pendingcourse" class="tab-pane in active">
                    <div id="Div1" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="Table1" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="mycourses" class="tab-pane">
                    <div id="DataList_mycourse" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_mycourse" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                
            </div>
        </div>--%>
    </div>

    <script type="text/javascript">
        var oTable, oTable2;


        $(document).ready(function () {

            if ($('#hdnusertype').val() == 'PC') {
                var str = "<div id='div_myTab'><ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Grade Entry and Approval&nbsp;</a></li>" +
                            "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li></ul></div>" +
                    "<div class='tab-content'><div id='pendingcourse' class='tab-pane in active'><div id='DataList_progcoord' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example_progcoord' class='display table table-striped table-bordered table-hover' width='100%'><thead></thead><tbody></tbody></table>" +
                            "</div></div>" +
                        "<div id='mycourses' class='tab-pane'><div id='DataList' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                    "<thead></thead><tbody></tbody></table></div></div></div>";

                $('#div_course_list').removeClass('panel panel-default');
                $('#div_course_list').html(str);
            }
            else if ($('#hdnusertype').val() == 'D') {
                var str = "<div id='div_myTab'><ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Grade Entry and Approval&nbsp;</a></li>" +
                            "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li></ul></div>" +
                    "<div class='tab-content'><div id='pendingcourse' class='tab-pane in active'><div id='DataList_progcoord' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example_progcoord' class='display table table-striped table-bordered table-hover' width='100%'><thead></thead><tbody></tbody></table>" +
                            "</div></div>" +
                        "<div id='mycourses' class='tab-pane'><div id='DataList' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                    "<thead></thead><tbody></tbody></table></div></div></div>";

                $('#div_course_list').removeClass('panel panel-default');
                $('#div_course_list').html(str);
            }

            bindsemdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                course_wise_entered_marks();
                return false;
            });

            setCurrentSemester();

        });

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_current_grade_semester",
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

                            $('#btnreterive').click();
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
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));

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
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

            window.location = "WS_Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }

        function rowClick_view(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

            window.location = "WS_View_Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }


        function publish_all() {
            if ($('#hdnusertype').val() == 'A1') {
                bootbox.confirm('Are you sure you want to publish all courses?', function (result) {
                    if (result == true) {
                        bootbox.confirm('After Publish you can not change grade , Are you sure you want to publish all courses?', function (result2) {
                            if (result2 == true) {
                                if (oTable != undefined) {
                                    if (oTable.fnGetData().length > 0) {
                                        $.ajax({
                                            type: "POST",
                                            contentType: "application/json; charset=utf-8",
                                            url: "../../WebService.asmx/ws_publish_all_course_grade",
                                            //async: false,
                                            data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                                            dataType: "json",
                                            success: function (data) {
                                                if (data.d != "" && data.d != "[]") {
                                                    if ($('#hdnusertype').val() == 'A1') {
                                                        //course_wise_entered_marks_list_UGPG(data.d);
                                                        bootbox.alert(data.d);
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
        function course_wise_entered_marks() {
            $('#DataList').css('display', 'none');
            $('#div_btn').html('');

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

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_course_wise_entered_marks_list",
                //async: false,
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]")
                    {
                        if ($('#hdnusertype').val() == 'A1') {
                            course_wise_entered_marks_list_UGPG(data.d);
                        }
                        else if ($('#hdnusertype').val() == 'FA') {
                            course_wise_entered_marks_list_FA(data.d);
                        }
                        else
                        {
                            course_wise_entered_marks_list(data.d);
                        }
                        $('#div_course_list').css('display', 'block');
                    }
                    else
                    {
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

            if ($('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D')
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ws_course_wise_entered_marks_list_PC",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            course_wise_entered_marks_list_PC(data.d);
                            $('#div_course_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            //$('#div_course_list').css('display', 'none');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            return false;
        }




        function course_wise_entered_marks_list(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
               // "sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                // "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
           //     "oTableTools": {
           //         "aButtons": [
           //         //"copy",
				       // "print",
           // 	        {
           // 	            "sExtends": "collection",
           // 	            "sButtonText": 'Export',
           // 	            "aButtons": ["xls"]
           // 	        }
			        //]
           //     },

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                    { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },
                    
                    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
                    { "sTitle": "Admin Approval", "mData": "progcoordinate_approval", "bSortable": false },

                    { "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                        if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D')
                        {
                            if (data.faculty_approval != 'Approved' && data.progcoordinate_approval != 'Approved') {
                                return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                            }
                            else {
                                return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                            }
                        }
                        else if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A')
                        {
                            if (data.ugpg_approval != 'Approved') {
                                return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                            }
                            else {
                                return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                            }
                        }
                        else {
                            return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                        }
                    }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            $('#div_btn').html('');
        }



        function course_wise_entered_marks_list_PC(data) {

            if (oTable2 != null) {


                oTable2.fnDestroy();
                $("#DataList_progcoord").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_progcoord" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable2 = $("#example_progcoord").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
           //     "oTableTools": {
           //         "aButtons": [
           //             //"copy",
				       // "print",
           // 	        {
           // 	            "sExtends": "collection",
           // 	            "sButtonText": 'Export',
           // 	            "aButtons": ["xls"]
           // 	        }
			        //]
           //     },

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                    { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

                    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
                    { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },

                    { "sTitle": "", "mData": null, "bSortable": false, fnRender: function (data) {
                        return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                    }
                    }
                ]
            });

            $('#DataList_progcoord').css('display', 'block');
            $('#div_btn').html('');
        }



        function course_wise_entered_marks_list_UGPG(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
           //     "oTableTools": {
           //         "aButtons": [
           //             //"copy",
				       // "print",
           // 	        {
           // 	            "sExtends": "collection",
           // 	            "sButtonText": 'Export',
           // 	            "aButtons": ["xls"]
           // 	        }
			        //]
           //     },

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },

                        //{ "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                        //{ "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

                    {"sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
                    { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },

                    { "sTitle": "", "mData": null, "bSortable": false, fnRender: function (data) {
                        return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                    }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            if ($('#hdnusertype').val() == 'A1') {
                $('#div_btn').html('<button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="publish_all()">Publish All</button>');
            }
        }


        function course_wise_entered_marks_list_FA(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
           //     "oTableTools": {
           //         "aButtons": [
           //             //"copy",
				       // "print",
           // 	        {
           // 	            "sExtends": "collection",
           // 	            "sButtonText": 'Export',
           // 	            "aButtons": ["xls"]
           // 	        }
			        //]
           //     },

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },

                    { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                    { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

                    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
                    { "sTitle": "Admin Approval", "mData": "progcoordinate_approval", "bSortable": false },

                    { "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                        if ($('#hdnusertype').val() == 'FA') {
                            if (data.faculty_approval != 'Approved' || data.progcoordinate_approval != 'Approved') {
                                return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                            }
                            else {
                                return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                            }
                        }
                        //return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                    }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            $('#div_btn').html('');
        }

    </script>

</asp:Content>

