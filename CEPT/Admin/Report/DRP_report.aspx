<%@ Page Title="DRP Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="DRP_report.aspx.cs" Inherits="Admin_Report_DRP_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var oTable;
        var oTable1;
        var semester = '';
        var year_code = '';
        var report_type = '';
        var asInitVals = new Array();
        var asInitVals_stu = new Array();
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            bindreportdata();
            binddepartment();
            bindprogrammedata();
            $('#btnreterive').on('click', function () {
                get_drp_data();

                return false;
            });

            $('#btndeallocated').on('click', function () {
                save_deallocated_data();
                return false;
            });
            $('#report').change(function () {
                $('#div_course_list').css('display', 'none');
                $('#div_student_list').css('display', 'none');
            });
        });

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

        function bindreportdata() {

            $('#report').empty().append($("<option></option>").val("").html("-- Please Select Report --"));
            $('#report').append($("<option></option>").val("C").html("Course Wise Report"));
            $('#report').append($("<option></option>").val("S").html("Student Wise Report"));

            $('#report').chosen();

        }


        function get_drp_data() {
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
            report_type = $('#report').val();
            if (report_type == "") {
                bootbox.alert('Please select Report Type');
                $('#report').focus();
                return false;
            }
            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();
            if (report_type == "C") {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_total_funded_unfunded_set",
                        //async: false,
                        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:'',drp_code:'',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                drp_data_list(data.d);
                                $('#div_student_list').css('display', 'none');
                                $('#div_course_list').css('display', 'block');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_course_list').css('display', 'none');
                                $('#div_student_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if (report_type == "S") {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_student_wise_drp_rept",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',drp_code:'',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                student_data_list(data.d);
                                $('#div_course_list').css('display', 'none');
                                $('#div_student_list').css('display', 'block');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_course_list').css('display', 'none');
                                $('#div_student_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }


            return false;
        }

        function drp_data_list(data) {

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
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Course Code ", "mData": "course_code", "bSortable": false },
                    { "sTitle": "DRP Topic Name ", "mData": "topic", "bSortable": false },
                    { "sTitle": "Instructor Name ", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Mail ", "mData": "mail", "bSortable": false },
                    { "sTitle": "Total Vacant Seats ", "mData": "vacant_seats", "bSortable": false },
                    { "sTitle": "Total Funded Seats ", "mData": "funded_seats", "bSortable": false },
                    { "sTitle": "Total UN-Funded Seats ", "mData": "unfunded_seats", "bSortable": false },
                    { "sTitle": "Allocated Funded Seats ", "mData": "funded", "bSortable": false },
                    { "sTitle": "Allocated UN-Funded Seats ", "mData": "unfunded", "bSortable": false },
                    { "sTitle": "Remaining Funded Seats ", "mData": "fund_rem_set", "bSortable": false },
                    { "sTitle": "Remaining UN-Funded Seats ", "mData": "unfund_rem_set", "bSortable": false },
                    {
                        "sTitle": "Document ", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data["doc_path"] != "") {
                                var path_value = "../../DRPTopicBriefDocs/" + data["doc_path"];
                                return "<a href='" + path_value + "' download>Downlod PDF</a>";
                            }
                            else {
                                return "PDF Not Available";
                            }
                        }
                    }
                ]
            });
            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 

            for (var i = 0; i < $("#example tr:nth-child(2) th").length - 1; i++) {
                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {
                asInitVals[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });

            $('#DataList').css('display', 'block');
        }

        function save_deallocated_data() {
            
            var oSettings = oTable1.fnSettings();

            for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                oSettings.aoPreSearchCols[iCol].sSearch = '';
            }

            oSettings.oPreviousSearch.sSearch = '';
            oTable1.fnDraw();
            var datalist = [];
            var status_data = 'N';
            $("#stu_example tbody tr").each(function (i) {
                var obj = {};
                if ($(this).find(".chk_user_id").is(':checked'))
                {
                    obj = {};
                    obj["user_id"] = $(this).children().eq(2).html();
                    datalist.push(obj);
                    status_data = 'Y';
                    
                }
            });
            if (status_data == 'N')
            {
                bootbox.alert('Please Select CheckBox');
                return false;
            }
            var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), drp_code: '', flag_status:'Y' });

                $.ajax({
                    type: "POST",
                    url: "../../WebService.asmx/Deallocate_drp_request",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "Problem in save data") {
                                bootbox.alert("Problem in save data");
                                return false;
                            }
                            get_drp_data();
                           
                            bootbox.alert("Data Saved Successfully");
                            //return false;
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
           
        }



        function student_data_list(data) {

            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#StudentDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="stu_example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#stu_example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "aaData": JSON.parse(data),

                "aoColumns": [
                    {
                        "sTitle": "<center>Select</center>", "mData": null, "bSortable": false, mRender: function (data) {
                            return '<center><input type="checkbox"  name="check_all_student" class="chk_user_id" onchange="user_select_change(this)" id="' + data["student_id"] + '" /></center>';
                        }

                    },

                    { "sTitle": "Course Code ", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Student Code ", "mData": "student_id", "bSortable": false },
                    { "sTitle": "Student Name ", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Instructor Name", "mData": "faculty_name", "bSortable": false },
                    { "sTitle": "Instructor Mail id", "mData": "mail", "bSortable": false },
                    { "sTitle": "DRP Topic Name ", "mData": "topic", "bSortable": false },
                    { "sTitle": "Seats ", "mData": "seat", "bSortable": false },
                    {
                        "sTitle": "Document ", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data["doc_path"] != "") {
                                var path_value = "../../DRPTopicBriefDocs/" + data["doc_path"];
                                return "<a href='" + path_value + "' download>Downlod PDF</a>";
                            }
                            else {
                                return "PDF Not Available";
                            }
                        }
                    }
                ]
            });


            var thead = $('<tr class="dt"></tr>');
            $('#stu_example thead th').each(function (i, r) {
                var nm = $('#stu_example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#stu_example thead').append(thead);

            //adding input box in thead second row 

            for (var i = 0; i < $("#stu_example tr:nth-child(2) th").length - 1; i++) {
                var title = $('#stu_example thead th').eq(i).text();
                $('#stu_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init_1' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable1.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {
                asInitVals_stu[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init_1") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init_1";
                    this.value = asInitVals_stu[$("thead input").index(this)];
                }
            });

            $('#StudentDataList').css('display', 'block');

        }

        function binddepartment() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                aSync: false,
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

        function bindprogrammedata() {

            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>DRP Report
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
                                <td>Department
                                </td>
                                <td>
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
                                <td>Report Type:
                                </td>
                                <td>
                                    <select class="chosen-select" id="report">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>

                                <td>
                                    <button class="btn btn-primary" id="btndeallocated">
                                        Deallocate DRP
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
                <strong>Course Wise DRP Report</strong>
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


        <div id="div_student_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Student Wise DRP Report </strong>
            </div>
            <div>
                <div id="StudentDataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="stu_example" class="display table table-striped table-bordered table-hover"
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

