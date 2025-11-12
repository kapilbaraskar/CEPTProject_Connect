<%@ Page Title="Course Wise Result Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
     CodeFile="Course_wise_result_report.aspx.cs" Inherits="Admin_Report_Course_wise_result_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        var asInitVals = new Array();

        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            bindproglevel();
            $('#btnreterive').on('click', function () {
                get_course_wise_result();
                return false;
            });

        });

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            $('#drpsemester').chosen();
        }

        function bindproglevel() {
         
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d);

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }

                        $('#drpproglevel').chosen();
                     
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

        var semester = '';
        var year_code = '';
        function get_course_wise_result() {
            $('#DataList').css('display', 'none');
            
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
            var prog_level_code = $('#drpproglevel').val();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_wise_result",
                //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_level_code:'" + prog_level_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {

                        display_get_vf_personal_detail(data.d);

                        $('#div_course_list').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester and Year');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Course Code", "mData": "course_code" });
            columns.push({ "sTitle": "Course Name", "mData": "course_name" });
            columns.push({ "sTitle": "Course Type", "mData": "course_type" });
            columns.push({ "sTitle": "Credits", "mData": "course_credits" });
            columns.push({ "sTitle": "Typology", "mData": "type_name" });
            columns.push({ "sTitle": "Program", "mData": "prog_name" });
            columns.push({ "sTitle": "Program Level", "mData": "prog_level_desc" });
            columns.push({ "sTitle": "Instructors", "mData": "instructor_name" });
            columns.push({ "sTitle": "Students Enrolled", "mData": "students_enrolled" });
            columns.push({ "sTitle": "Students Passed", "mData": "students_passed" });
            columns.push({ "sTitle": "Students Failed", "mData": "students_failed" });
            columns.push({ "sTitle": "Elective Students", "mData": "elective_students" });
            columns.push({ "sTitle": "GPA Students", "mData": "gpa_students" });
            columns.push({ "sTitle": "GPA Students Passed", "mData": "gpa_students_passed" });
            columns.push({ "sTitle": "NonGPA Students", "mData": "nongpa_students" });
            columns.push({ "sTitle": "NonGPA Students Passed", "mData": "nongpa_students_passed" });

//            columns.push({ "sTitle": "Student Code", "mData": "user_id" });
//            columns.push({ "sTitle": "Student Name", "mData": "student_name" });
//            columns.push({ "sTitle": "Course Code", "mData": "course_code" });
//            columns.push({ "sTitle": "Course Credits", "mData": "credits" });
//            columns.push({ "sTitle": "GP in particular course", "mData": "grade_point" });
//            //columns.push({ "sTitle": "Semester Grade Point Ratio", "mData": "sem_grade_point_ratio" });
//            columns.push({ "sTitle": "Semester Grade Point Ratio", "mData": null, "bSortable": false, fnRender: function (data) { return parseFloat(data.aData.sem_grade_point_ratio).toFixed(2); } });
//            columns.push({ "sTitle": "Credits Completed", "mData": "credits_completed" });
//            columns.push({ "sTitle": "Mandatory Credits Completed", "mData": "mandatory_credits_completed" });
//            columns.push({ "sTitle": "Elective Credits Completed", "mData": "elective_credits_completed" });

            return columns;
        }

        function display_get_vf_personal_detail(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

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

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
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
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Course Wise Result Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
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
                                </tr>
                            <tr>
                                <td>
                               Program Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
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
                <strong>Course Result Detail</strong>
            </div>
            <div><%--class="panel-body"--%>      
                <div id="DataList" style="display: none;overflow:auto">
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

