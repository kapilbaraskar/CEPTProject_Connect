<%@ Page Title="Course Wise Student Grade Status" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Course_wise_student_Grade_status.aspx.cs" Inherits="Admin_Report_Course_wise_student_Grade_status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script>

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
            binddepartment();
            bindprogrammedata();
            bindyeardata_allocation();

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

        function bindyeardata_allocation() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d);

                        $('#drpyear_allocation').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear_allocation').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear_allocation').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var year_allocation = '';
        function get_course_wise_result() {
            $('#DataList').css('display', 'none');

            semester = $('#drpsemester').val();
            //if (semester == "") {
            //    bootbox.alert('Please select semester');
            //    $('#drpsemester').focus();
            //    return false;
            //}

            year_code = $('#drpyear').val();
            //if (year_code == "") {
            //    bootbox.alert('Please select Year');
            //    $('#drpyear').focus();
            //    return false;
            //}

            dept_code = $('#drpdepartment').val();
            year_allocation = $('#drpyear_allocation').val();
          // if (dept_code == "") {
          //     bootbox.alert('Please select Department');
          //     $('#drpdepartment').focus();
          //     return false;
          // }

            prog_code = $('#drpprog').val();

            //if (year_code == "" && year_allocation == "") {
            //    bootbox.alert('Please select Year OR Enrollment Year');
            //    return false;
            //}
            //if (prog_code == "") {
            //    bootbox.alert('Please select Programme');
            //    $('#drpprog').focus();
            //    return false;
            //}

            if (year_allocation == "") {
                if (semester == "" || year_code == "") {
                    bootbox.alert('Please select Enrollment Year or select both Year & Semester');
                    return false;
                }
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_course_wise_student_Grade_status_report",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',year_allocation:'" + year_allocation+"'}",
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
            columns.push({ "sTitle": "Student Name", "mData": "user_name" });
            columns.push({ "sTitle": "Course Code", "mData": "course_code" });
            columns.push({ "sTitle": "Course Name", "mData": "course_name" });
           
            columns.push({ "sTitle": "Course Typology", "mData": "type_name" });
            columns.push({ "sTitle": "Course Type", "mData": "course_type" });
            columns.push({ "sTitle": "Course Credits", "mData": "credits" });
            
            columns.push({ "sTitle": "Student Code", "mData": "user_id" });
            columns.push({ "sTitle": "Student Faculty", "mData": "dept_name" });
            columns.push({ "sTitle": "Student Program ", "mData": "prog_name" });
            columns.push({ "sTitle": "Student Program Level", "mData": "prog_level_code" });
            columns.push({ "sTitle": "Marks", "mData": "Total" });

           // columns.push({ "sTitle": "Grade", "mData": "grade" });
            // This Changes By Nitinbhai 24072023
            columns.push({
                "sTitle": "Grade", "mData": null, "bSortable": false, mRender: function (row)
                {
                    if (row.course_type == 'M' && row.swscourse == 'SWS' && row.gpa_nongpa == 'N')
                    {
                        if (row.remarks.trim() == "PASS") {
                            return "P";
                        }
                        else if (row.remarks.trim() == "FAIL") {
                            return "NP";
                        }
                        else { return "";}
                        
                    }
                    else
                    {
                        return row.grade;
                         
                    }

                } });


            //columns.push({ "sTitle": "Grade Point", "mData": "grade_point" });
            // This Changes By Nitinbhai 24072023
            columns.push({
                "sTitle": "Grade Point", "mData": null, "bSortable": false, mRender: function (row) {
                    if (row.course_type == 'M' && row.swscourse == 'SWS' && row.gpa_nongpa == 'N') {
                        return "NA"; 

                    }
                    else
                    {
                        return row.grade_point;

                    }

                }
            });
            //columns.push({ "sTitle": "Year Code", "mData": "year_code" });
            columns.push({ "sTitle": "Status", "mData": "status" });
            columns.push({ "sTitle": "GPA/NGPA", "mData": "gpa_nongpa" });
            columns.push({ "sTitle": "Semester", "mData": "semester_type" });
            columns.push({ "sTitle": "Semester Year", "mData": "year_semester" });
            columns.push({ "sTitle": "Batch Year", "mData": "BatchYear" });
            columns.push({ "sTitle": "Admission Year", "mData": "AdmissionYear" });
            return columns;
        }

        function display_get_vf_personal_detail(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").DataTable({
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
                //        //"copy",
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

            //Mayur

            //added the second row in thead  
            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row  
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 50px;'>");
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

            //Mayur

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            oTable = $("#example").dataTable();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Course Wise Student Grade Status
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

                                <td> Enrollment Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear_allocation">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="cls_dept_prog">Department :
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <td>Programme :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
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
                <strong>Student Grade Detail</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none; overflow: auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
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

