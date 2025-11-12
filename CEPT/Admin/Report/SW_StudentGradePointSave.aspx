<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SW_StudentGradePointSave.aspx.cs" Inherits="Admin_Report_SW_StudentGradePointSave" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>

    <script type="text/javascript">
        var savedataget = '';
        $(document).ready(function () {
            bindEnrollmentyeardata();
            binddepartment();
            bindprogrammedata();

            $('#btnreterive').on('click', function () {
                //GetSaveData();
                retrieve_Data();

                return false;
            });
        });

        function bindEnrollmentyeardata() {

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

                        $('#drpenrollmentyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpenrollmentyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpenrollmentyear').chosen();
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

        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function retrieve_Data() {

            $('#DataList').css('display', 'none');

            var enrollment_year = $('#drpenrollmentyear').val();

            if (enrollment_year == "") {
                bootbox.alert('Please Select Enrollment Year');
                return false;
            }

            dept_code = $('#drpdepartment').val();

            if (dept_code == "") {
                bootbox.alert('Please Select Department');
                return false;
            }

            prog_code = $('#drpprog').val();

            if (prog_code == "") {
                bootbox.alert('Please Select Programme');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Save_SWS_GraderPoint",
                data: JSON.stringify({
                    
                    year_code: enrollment_year,
                    dept_code: dept_code,
                    prog_code: prog_code
                }),
                dataType: "json",
                async: true,
                success: function (data) {
                    if (data.d !== "") {
                        let parsedData = JSON.parse(data.d);
                        display_get_vf_personal_detail(parsedData.message.stud_detail);
                        $('#div_course_list').css('display', 'block');
                    } else {
                        bootbox.alert('No data Found For Selected Enrollment Year');
                        $('#div_data_list').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });


            return false;
        }


        function GetSaveData() {

          

            var enrollment_year = $('#drpenrollmentyear').val();

            if (enrollment_year == "") {
                bootbox.alert('Please Select Enrollment Year');
                return false;
            }

            dept_code = $('#drpdepartment').val();

            if (dept_code == "") {
                bootbox.alert('Please Select Department');
                return false;
            }

            prog_code = $('#drpprog').val();

            if (prog_code == "") {
                bootbox.alert('Please Select Programme');
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetDataSemesterWiseSGPACGPAData",
                    data: "{dept_code : '" + dept_code + "',prog_code:'" + prog_code + "',EnrollmentYear:'" + enrollment_year + "'}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "")
                        {
                            savedataget = data.d;
                        }
                    }
                });

            return false;
        }


        function round_num(num, precision) {
            return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({
                "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, mRender: function (data)
                {
                    if (data.statussave != 'Y') {
                        return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                    }
                    else { return ''; }
                    
                }
            });


            columns.push({
                "sTitle": "Student Code", "mData": "user_id", "mRender": function (data) {
                    return data;
                }
            });
            columns.push({ "sTitle": "Student Name", "mData": "full_name" });
            columns.push({ "sTitle": "Course Code", "mData": "course_code" });
            columns.push({ "sTitle": "Faculty", "mData": "dept_name" });
            columns.push({ "sTitle": "Program Name", "mData": "prog_name" });
            columns.push({ "sTitle": "Semester Year", "mData": "semyear" });
            /*columns.push({ "sTitle": "Program Level", "mData": "prog_level_name" });*/
            columns.push({
                "sTitle": "Year of Enrollment", "mData": "year_code", "mRender": function (data) {
                    if (data == 'Y1') return 'Y2013';
                    else return data;
                }
            });
            
            columns.push({
                "sTitle": "GPA/NGPA", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.gpa_nongpa != '')
                    {
                        if (data.gpa_nongpa == 'N') {
                            return 'NGPA';
                        }
                        else
                        {
                            return 'GPA';
                        }
                        
                    }
                    else {
                        if (data.gpa_nongpa == 'N') {
                            return 'NGPA';
                        }
                        else {
                            return 'GPA';
                        }
                    }
                }
            });

            columns.push({
                "sTitle": "Grade", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.grade != '') {
                        return data.grade;
                    }
                    else {
                        return data.grade;
                    }
                }
            });

            columns.push({
                "sTitle": "Grade Point", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.grade_point != '') {
                        return data.grade_point;
                    }
                    else {
                        return data.grade_point;
                    }
                }
            });

            columns.push({
                "sTitle": "Status", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.remarks != '') {
                        return data.remarks;
                    }
                    else {
                        return data.remarks;
                    }
                }
            });


            return columns;
        }

        function display_get_vf_personal_detail(data) {

            //var columns = set_table_columns(JSON.parse(data)[0]);
            var columns = set_table_columns(data);

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
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": data,
               // "aaData": JSON.parse(data),

                "aoColumns": columns,
                "initComplete": function () {
                    var table = this.api();
                    
                    table.columns('.hidecolumn').visible(false);
                }

            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            for (var i = 1; i < $("#example tr:nth-child(2) th").length; i++) {
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

        function select_all_change() {
            $('#chk_select_all')[0].checked
                //? $('.cls_chk_course_select').prop('checked', true)
                //: $('.cls_chk_course_select').prop('checked', false);
                ? $('.cls_chk_course_select:visible').prop('checked', true)
                : $('.cls_chk_course_select:visible').prop('checked', false);
        }

        function course_select_change(cur_ele)
        {
            $('#chk_select_all')[0].checked =
                $('.cls_chk_course_select').length === $('.cls_chk_course_select:checked').length;
        }

        $(document).on("click", "#btnsave", function (event) {
           
            var table = $('#example').DataTable();
            var selectedRowsData = [];
            $('.cls_chk_course_select:checked').each(function () {
                var $row = $(this).closest('tr');
                var rowData = table.row($row).data();
                var rowColumns = {
                    user_id: rowData.user_id,
                    EnrollmentYear: rowData.year_code,
                    Course_Code: rowData.course_code,
                    Grade: rowData.grade,
                    GradePoint: rowData.grade_point,
                    FaillPassStatus: rowData.remarks,
                    semester_type: rowData.semester_type,
                    year_semester: rowData.year_semester
                };
                selectedRowsData.push(rowColumns);
            });

            if (selectedRowsData.length > 0) {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/WS_StudentWiseSaveGradePoint",
                        data: "{Student_list : '" + JSON.stringify(selectedRowsData) + "'}",
                        dataType: "json",
                        success: function (data) {
                            
                            if (data.d == "true")
                            {
                                $('.cls_chk_course_select:checked').css('display', 'none');
                                $('.cls_chk_course_select:checked').prop('checked', false);
                                bootbox.alert("Data Saved Successfully ");
                                return false;
                            }
                            else {
                                bootbox.alert("Data Not Saved Successfully ")
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else
            {
                bootbox.alert("Please Checked CheckBox");
                return false;
            }
            return false;
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; Students Wise Save GradePoint
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">

            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                             <tr>
                                <td class="cls_dept_prog">
                                    Department :
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <td>
                                    Programme :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Enrollment Year
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpenrollmentyear">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>

                               <td>
                                    <button class="btn btn-primary" type="submit" id="btnsave">
                                        Save
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
                <strong>Student Wise Save SGPA CGPA</strong>
            </div>
            <div>  
                <div id="DataList" style="display: none;overflow:auto;">
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

