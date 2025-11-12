<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_course_budget_summery_dtl.aspx.cs" Inherits="Admin_Master_ws_course_budget_summery_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" /> 
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        var oTable;
        var oTable1;
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            //bindreportdata();
            //binddepartment();
            //bindprogrammedata();
            $('#btnreterive').on('click', function () {
                get_budget_data();
                return false;
            });

            function bindsemdata() {

                $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
                $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
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

            function get_budget_data() {
                var semester = $('#drpsemester').val();
                if (semester == "") {
                    bootbox.alert('Please select semester');
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    bootbox.alert('Please select Year');
                    $('#drpyear').focus();
                    return false;
                }
                    $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService.asmx/Get_course_budget_details",
                            //async: false,
                            data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:''}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "" && data.d != "[]") {
                                    budget_data_list(data.d);
                                    $('#div_course_list').css('display', 'block');
                                }
                               
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                


                return false;
            }

            function budget_data_list(data) {

                if (oTable != null) {
                    oTable.fnDestroy();
                    $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
                }

                oTable = $("#example").dataTable({

                    "bPaginate": false,
                    "bSortable": false,
                    "bSort": false,
                    "iDisplayLength": 60,
                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                    "aaData": JSON.parse(data),

                    "aoColumns": [
                        { "sTitle": "WS Course Code ", "mData": "ws_course_code", "bSortable": false, "className": "ws-course-col" },
                        { "sTitle": "Course Code ", "mData": "course_code", "bSortable": false },
                        
                        //{ "sTitle": "Course Description ", "mData": "course_desc", "bSortable": false },
                        { "sTitle": "Course Name ", "mData": "course_name", "bSortable": false },
                        { "sTitle": "Course Type ", "mData": "course_type", "bSortable": false },
                        { "sTitle": "Type of Course ", "mData": "type_of_course", "bSortable": false },
                        { "sTitle": "Minimum Student Decided ", "mData": "min_student_decided", "bSortable": false },
                        { "sTitle": "Minimum Student Suggest ", "mData": "min_student_suggest", "bSortable": false },
                        { "sTitle": "Fees Per Credit ", "mData": "fees_per_credit", "bSortable": false },
                        { "sTitle": "Total Expected Fees ", "mData": "total_expected_fees", "bSortable": false },
                        { "sTitle": "University Component ", "mData": "uni_component", "bSortable": false },
                        { "sTitle": "Faculty Component ", "mData": "fac_componet", "bSortable": false },
                        { "sTitle": "Total Expenses ", "mData": "total_expenses", "bSortable": false },
                        { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                        { "sTitle": "Faculty Name ", "mData": "instructor_name", "bSortable": false },


                        { "sTitle": "Budget RateBand ", "mData": "rate_band", "bSortable": false },
                        { "sTitle": "Workload RateBand ", "mData": "workloadrateband", "bSortable": false },
                        { "sTitle": "Budget Status ", "mData": "budget_status", "bSortable": false },
                        { "sTitle": "Budget Approve Status ", "mData": "budget_approve_status", "bSortable": false },
                        { "sTitle": "Faculty Approve Status ", "mData": "Faculty_status", "bSortable": false },
                        { "sTitle": "Dean Approve Status ", "mData": "Dean_status1", "bSortable": false },
                        { "sTitle": "Admin Approve Status ", "mData": "Ugpg_status1", "bSortable": false },
                        
                        
                        {
                            "sTitle": "Action", 
                            "mData": null,
                            "bSortable": false,
                            "mRender": function (data, type, row) {
                                return '<button class="btn btn-sm btn-primary edit-btn" data-sem="' + row.semester_type + '" data-year="' + row.year_semester + '" data-coursecode="' + row.course_code + '">Edit</button>';
                            }
                        }
                    ]
                }).rowGrouping();
                $('#DataList').css('display', 'block');
            }
        });


        $(document).on("click", ".edit-btn", function (e) {
            e.preventDefault();
            var sem_code = $(this).data("sem");
            var year_code = $(this).data("year");
            var course_code = $(this).data("coursecode");

            window.open("ws_course_budget_dtl.aspx?c=" + course_code + "&s=" + sem_code + "&y=" + year_code, "_blank");
        });
    </script>
    <style>
        .ws-course-col {
    color: blue;  
    background-color: #f0f0f0; 
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>SW Course Budget summary Details
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
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
                <strong>Course Budget Details</strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow: overlay;">
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


    </div>
</asp:Content>
