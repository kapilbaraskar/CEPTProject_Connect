<%@ Page Title="Course Wise Assessment Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Course_Wise_Assessment_Details.aspx.cs" Inherits="Admin_Master_Course_Wise_Assessment_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Wise Assessment Details
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
                                        <option value="ALL">ALL</option>
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

            <div id="assessmentcourses" class="tab-pane">
                <div id="DataList_assessmentcourses" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example_assessmentcourses" class="display table table-striped table-bordered table-hover"
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
    <script type="text/javascript">
        var oTable;

        $(document).ready(function () {

            var long_dept_name = "";

            if (getParameterByName("autho") == 'false') {
                bootbox.alert('You are not authorized to view this page.', function (result) {
                    window.location.replace('Course_wise_entered_marks.aspx');
                });
            }

            bindsemdata();
            bindyeardata_for_cross_reg();

            setCurrentSemester();

            if ($("#hdn_user_type").val() == "FA") {
                binddepartmentnew()
            }
            else {
                binddepartment();
                bindprogrammedata();
            }

            $('#drpsemester').on('change', function () {
                if ($('#drpsemester').val() != '') {

                    if ($('#drpyear').val() != '')
                    {
                        if ($("#hdn_user_type").val() == "FA")
                        {
                            bindprogramme($("#drpsemester").val(), $("#drpyear").val());
                        }
                        
                    }

                }
            });

            $('#drpyear').on('change', function () {
                if ($('#drpyear').val() != '') {

                    if ($('#drpsemester').val() != '')
                    {
                        if ($("#hdn_user_type").val() == "FA") {
                            bindprogramme($("#drpsemester").val(), $("#drpyear").val());
                        }
                        
                    }

                }
            });

            $('#btnretrieve').on('click', function () {
                get_assessment_details();
                return false;
            });

            function binddepartmentnew() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_department_data",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            long_dept_name = JSON.parse(data.d)
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function bindprogramme(semester, year_code) {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_semyearwise_department_user_dtl",
                        async: false,
                        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                $('#drpprog').empty();

                                var first = false;
                                var second = false;
                                var third = false;

                                for (var i = 0; i < user_data.length; i++) {
                                    if (user_data[i]['prog_code'] == "1") {
                                        if (!first) {
                                            first = true;
                                            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                        }
                                    }
                                    else if (user_data[i]['prog_code'] == "2") {
                                        if (!second) {
                                            second = true;
                                            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                        }
                                    }
                                    else if (user_data[i]['prog_code'] == "3") {
                                        if (!third) {
                                            third = true;
                                            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                        }
                                    }
                                }


                                $('#drpdepartment').html('');
                                $('#drpdepartment').trigger("liszt:updated");
                                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));

                                for (var i = 0; i < user_data.length; i++) {
                                    var not_present = false;
                                    for (var k = 0; k < long_dept_name.length; k++) {
                                        if (user_data[i]['dept_code'] == long_dept_name[k]["dept_code"]) {
                                            for (var y = 0; y < i; y++) {
                                                if (user_data[i]['dept_code'] == user_data[y]['dept_code'] && i != 0) {
                                                    not_present = true;
                                                }
                                            }
                                            if (!not_present) {
                                                $('#drpdepartment').append($("<option></option>").val(long_dept_name[k]["dept_code"]).html(long_dept_name[k]["dept_name"]));
                                            }
                                        }
                                    }
                                }
                                $('#drpdepartment').val(user_data[0]['dept_code']);
                                $('#drpdepartment').trigger("liszt:updated");
                            }
                            else {
                                $('#drpprog').empty();
                                $('#drpprog').append($("<option></option>").val('').html("No Data Found"));
                                $('#drpprog').trigger("liszt:updated");
                                $('#drpdepartment').empty();
                                $('#drpdepartment').append($("<option></option>").val('').html("No Data Found"));
                                $('#drpdepartment').trigger("liszt:updated");
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

                                if ($("#hdn_user_type").val() == "FA")
                                {
                                    bindprogramme($("#drpsemester").val(), $("#drpyear").val());
                                }
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function get_assessment_details() {

                $('#DataList_assessmentcourses').css('display', 'none');

                var semester = $("#drpsemester").val();
                var year_code = $("#drpyear").val();

                if (semester == "") {
                    bootbox.alert('Please Select Semester');
                }

                if (year_code == "") {
                    bootbox.alert('Please Select Year');
                }

                var dept_code = $("#drpdepartment").val();
                var prog_code = $("#drpprog").val();
                var type = $("#drp_exam_type").val();

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_assessment_details",
                        async: true,
                        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',type:'" + type + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                if ($('#hdnusertype').val() == 'AD' || $('#hdnusertype').val() == 'A1' || $('#hdnusertype').val() == 'FA') {
                                    get_assessment_details_data(data.d);
                                }
                                $('#DataList_assessmentcourses').css('display', 'block');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#DataList_assessmentcourses').css('display', 'none');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;
            }

            function get_assessment_details_data(data) {
                if (oTable != null) {
                    oTable.fnDestroy();
                    $("#DataList_assessmentcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_assessmentcourses" width="100%"><thead></thead><tbody> </tbody></table>');
                }

                oTable = $("#example_assessmentcourses").dataTable({
                    //"bPaginate": true,
                    //"bSortable": false,
                    //"bSort": false,
                    //"iDisplayLength": 60,
                    //"sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    //"oLanguage": {
                    //    "sSearch": "Search all columns with Space:"
                    //},
                    "bPaginate": true,
                    "bStateSave": false,
                    "bSort": false,
                    "iDisplayLength": 60,
                    "sDom": 'b',
                    dom: 'Bfrtip',
                    buttons: [
                        {
                            extend: 'csv',
                            footer: false,
                            exportOptions: {
                                columns: [1, 2, 3, 4, 5, 6, 7]
                            }
                        },
                        {
                            extend: 'print',
                            footer: false,
                            exportOptions: {
                                columns: [0, 3, 4, 5, 6, 7]
                            }
                        }
                    ],
                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    "aaData": JSON.parse(data),
                    "aoColumns": [
                        { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": false },
                        { "sTitle": "Course Code", "mData": "cc", "bSortable": false, "bVisible": false },
                        { "sTitle": "Course Name", "mData": "course_name", "bSortable": false, "bVisible": false },
                        { "sTitle": "Assessment Name", "mData": "exam_title", "bSortable": false },
                        //{ "sTitle": "Assessment Type", "mData": "exam_type", "bSortable": false },
                        {
                            "sTitle": "Assessment Type", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.exam_type == "IN") {
                                    return "Internal";
                                } else if (data.exam_type == "MT") {
                                    return "MidTerm";
                                } else if (data.exam_type == "EX") {
                                    return "External";
                                }
                            }
                        },
                        { "sTitle": "Weightage", "mData": "weightage", "bSortable": false },
                        //{ "sTitle": "Assessment Status", "mData": "is_submit", "bSortable": false },
                        {
                            "sTitle": "Assessment Status", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.is_submit == "Y") {
                                    return "Submitted";
                                } else {
                                    return "Pending";
                                }
                            }
                        },
                        { "sTitle": "Date (MM/DD/YYYY)", "mData": "last_modified_date", "bSortable": false }
                    ]
                }).rowGrouping();

                $('#DataList_assessmentcourses').css('display', 'block');
                $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
                $(".dt-buttons").css('float', 'right');
            }
        });
    </script>
    <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
</asp:Content>

