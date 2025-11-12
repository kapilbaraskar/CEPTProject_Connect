<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_SGPA.aspx.cs" Inherits="Admin_Report_Student_SGPA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            bindEnrollmentyeardata();
            binddepartment();
            bindprogrammedata();

            $('#btnreterive').on('click', function () {
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

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_students_completed_credits_sgpa_cgpa_report_data",
                    data: "{enrollment_year : '" + enrollment_year + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            display_get_vf_personal_detail(data.d);

                            $('#div_course_list').css('display', 'block');
                        }
                        else {
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

        function round_num(num, precision) {
            return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({
                "sTitle": "Student Code", "mData": "user_id", "mRender": function (data) {
                    return data;
                }
            });
            columns.push({ "sTitle": "Student Name", "mData": "user_name" });
            columns.push({ "sTitle": "Faculty", "mData": "dept_name" });
            columns.push({ "sTitle": "Program Name", "mData": "prog_name" });
            columns.push({ "sTitle": "Program Level", "mData": "prog_level_name" });
            columns.push({
                "sTitle": "Year of Enrollment", "mData": "year_code_actual", "mRender": function (data) {
                    if (data == 'Y1') return 'Y2013';
                    else return data;
                }
            });
            
            columns.push({
                "sTitle": "Total Credits Registered", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.semester_wise_total_credit != '')
                    {
                        return data.semester_wise_total_credit;
                    }
                    else
                    {
                        return '';
                    }
                }
            });
            columns.push({ "sTitle": "Credits Completed", "mData": "credits_completed" });

            columns.push({
                "sTitle": "Earn GPA Credits", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.earn_gpa_credit != '') {
                        return data.earn_gpa_credit;
                    }
                    else {
                        return '';
                    }
                }
            });
            columns.push({
                "sTitle": "Earn NGPA Credits", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.earn_ngpa_credit != '') {
                        return data.earn_ngpa_credit;
                    }
                    else {
                        return '';
                    }
                }
            });


            columns.push({
                "sTitle": "Semester", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.semester_type != '' && data.year_semester != '') return data.semester_type + " " + data.year_semester;
                    else return '';
                }
            });
            columns.push({
                "sTitle": "Semester GPA", "mData": "sem_grade_point_ratio_actual", "mRender": function (data) {// (Actual)
                    if (data != '') return round_num(round_num(data, 2), 1);//parseFloat(data).toFixed(2);
                    else return '';
                }//Total_CGPA
            });
            //columns.push({
            //    "sTitle": "Total CGPA", "mData": null, "mRender": function (data) {// (Actual)
            //        if (data.Total_CGPA != '') {
            //            var calculate_CGPA = parseFloat(data.gpa_multiplication_sem / data.total_gpa_credit_sem).toFixed(1);
            //            return calculate_CGPA;
            //        }
            //        else
            //        {
            //            return '';
            //        }
            //        //nitinbhai changes 03112022
            //         //return round_num(round_num(data.Total_CGPA, 2), 1);//parseFloat(data).toFixed(2);
            //        //else return '';
            //    }//Total_CGPA
            //});

            //columns.push({
            //    "sTitle": "Total CGPA (Decimal 4 Value)", "mData": null, "mRender": function (data) {// (Actual)
            //        if (data.Total_CGPA != '') {
            //            var calculate_CGPA = parseFloat(data.gpa_multiplication_sem / data.total_gpa_credit_sem).toFixed(4);
            //            return calculate_CGPA;
            //        }
            //        else {
            //            return '';
            //        }
            //        //nitinbhai changes 03112022
            //        //return round_num(round_num(data.Total_CGPA, 2), 1);//parseFloat(data).toFixed(2);
            //        //else return '';
            //    }//Total_CGPA
            //});



            //columns.push({
            //    "sTitle": "Semester Aggregate", "mData": "sem_aggregate_percentage_actual", "mRender": function (data) {// (Aggregate)
            //        if (data != '') return parseFloat(data).toFixed(2);
            //        else return '';
            //    }
            //});
            //columns.push({ "sTitle": "Semester GPA (Static)", "mData": "sem_grade_point_ratio", "mRender": function (data) {
            //    if (data != '') return parseFloat(data).toFixed(2);
            //    else return '';
            //}
            //});
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; Students SGPA Details 
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">

            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <%--class="panel-body"--%>
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
                                <td colspan="6">
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
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
                <strong>Student SGPA</strong>
            </div>
            <div><%--class="panel-body"--%>      
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

