<%@ Page Title="Verify Grade Student Wise" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Verify_Grade_Student_Wise.aspx.cs" Inherits="Admin_Master_Verify_Grade_Student_Wise_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <%--<script src="../../Js/calculated_commit_grade.js?t=06082020" type="text/javascript"></script>--%>
    <script src="../../Scripts/AjaxFileupload.js" type="text/javascript"></script>
    <style type="text/css">
        .inline_input {
            width: 35px;
            margin: 0;
        }
        .hide {
            display:none;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var sem = '';
        var year = '';
        var student_code = '';
        var table_headers;

        $(document).ready(function () {

            sem = $('#hdn_s').val();
            year = $('#hdn_y').val();
            student_code = $('#hdn_ss').val();

            calculated_grade();

            function calculated_grade() {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/verify_student_grade",
                        //async: false,
                        data: "{student_code:'" + $('#hdn_ss').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (JSON.parse(data.d).status == "false") {
                                bootbox.alert(JSON.parse(data.d).message, function () {
                                    window.close();
                                });
                            } else {

                                var obj_course_detail = JSON.parse(data.d).message['course_grade_detail'];

                                var obj_ws_course_detail = JSON.parse(data.d).message['ws_course_grade_detail'];

                                $('#spn_course_name').html("Student Code : " + student_code + "<br/> Student Name : " + JSON.parse(data.d).message['stud_detail'][0]['user_name']);

                                //setCourseDetail(data.d);

                                //setWSCourseDetail(data.d);

                                data = obj_course_detail;

                                table_headers = [
                                    //{ "sTitle": "Student Code", "mData": student_code, "bSortable": false },
                                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false }
                                ];

                                table_headers.push({ "sTitle": "Calculated Marks (OLD)", "mData": "Total", "bSortable": false });
                                table_headers.push({ "sTitle": "Calculated Grade (OLD)", "mData": "grade", "bSortable": false });
                                table_headers.push({ "sTitle": "Calculated Grade Point (OLD)", "mData": "grade_point", "bSortable": false });

                                table_headers.push({ "sTitle": "Commited Marks (NEW)", "mData": "final_mark", "bSortable": false });
                                table_headers.push({ "sTitle": "Commited Grade (NEW)", "mData": "final_grade", "bSortable": false });
                                table_headers.push({ "sTitle": "Commited Grade Point (NEW)", "mData": "final_grade_point", "bSortable": false });

                                for (var i = 0; i < data.length; i++) {
                                    if (data[i].absent_exam_1 == 'AB' || data[i].absent_exam_1 == 'NA') data[i].exam_1 = data[i].absent_exam_1;
                                    if (data[i].absent_exam_2 == 'AB' || data[i].absent_exam_2 == 'NA') data[i].exam_2 = data[i].absent_exam_2;
                                    if (data[i].absent_exam_3 == 'AB' || data[i].absent_exam_3 == 'NA') data[i].exam_3 = data[i].absent_exam_3;
                                    if (data[i].absent_exam_4 == 'AB' || data[i].absent_exam_4 == 'NA') data[i].exam_4 = data[i].absent_exam_4;
                                    if (data[i].absent_exam_5 == 'AB' || data[i].absent_exam_5 == 'NA') data[i].exam_5 = data[i].absent_exam_5;
                                    if (data[i].absent_exam_6 == 'AB' || data[i].absent_exam_6 == 'NA') data[i].exam_6 = data[i].absent_exam_6;
                                    if (data[i].absent_exam_7 == 'AB' || data[i].absent_exam_7 == 'NA') data[i].exam_7 = data[i].absent_exam_7;
                                    if (data[i].absent_exam_8 == 'AB' || data[i].absent_exam_8 == 'NA') data[i].exam_8 = data[i].absent_exam_8;
                                    if (data[i].absent_exam_9 == 'AB' || data[i].absent_exam_9 == 'NA') data[i].exam_9 = data[i].absent_exam_9;
                                    if (data[i].absent_exam_10 == 'AB' || data[i].absent_exam_10 == 'NA') data[i].exam_10 = data[i].absent_exam_10;
                                }

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
                                    //"aaData": JSON.parse(data),
                                    "aaData": data,
                                    "aoColumns": [
                                        //{ "sTitle": "Student Code", "mData": student_code, "bSortable": false },
                                        //{ "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                                        { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                                        { "sTitle": "Calculated Marks (OLD)", "mData": "Total", "bSortable": false },
                                        { "sTitle": "Calculated Grade (OLD)", "mData": "grade", "bSortable": false },
                                        { "sTitle": "Calculated Grade Point (OLD)", "mData": "grade_point", "bSortable": false },

                                        { "sTitle": "Commited Marks (NEW)", "mData": "final_mark", "bSortable": false },
                                        {
                                            "sTitle": "Commited Grade (NEW)", "mData": "final_grade", "bSortable": false, "fnRender": function (data) {
                                                //if (data.aData.new_course_grade != data.aData.final_grade) {
                                                //    debugger;
                                                //}
                                                return data.aData.final_grade;
                                            }
                                        },
                                        { "sTitle": "Commited Grade Point (NEW)", "mData": "final_grade_point", "bSortable": false },

                                        {
                                            "sTitle": "Grade Changed", "mData": null, "sClass": "hide", "bSortable": false, "fnRender": function (data) {//hide
                                                if (data.aData.grade != data.aData.final_grade && data.aData.final_grade != "") {
                                                    if (data.aData.grade_point != data.aData.final_grade_point && data.aData.final_grade_point != "") {
                                                        return "YES";
                                                    } else {
                                                        return "NO";
                                                    }
                                                } else {
                                                    return "NO";
                                                }
                                            }
                                        }
                                    ]
                                });

                                $('#DataList').css('display', 'block');

                                //if ($('#hdnusertype').val() == "FA") {
                                $("#example tbody tr").each(function (i) {
                                    if ($(this).children().eq(7)[0].innerText == "YES") {
                                        $(this).closest('tr').children('td,th').css('background-color', 'rgb(255, 142, 142)');
                                    }
                                });
                                //}
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }

            function setCourseDetail(data) {

                obj_course_detail = JSON.parse(data)['course_grade_detail'];

                var obj_foundation_detail = JSON.parse(data)['foundation_dtl'];

                if (obj_foundation_detail != null && obj_foundation_detail != undefined && obj_foundation_detail.length != 0) {
                    var str_foundation_html = '';

                    if (obj_course_detail != null && obj_course_detail != undefined) {
                        var pass_fail_flag = 1;
                        var total_marks = 0;
                        var total_credits = 0;

                        var aggregate = 0;
                        var sem1_pass_aggregate = 50;
                        var sem2_pass_aggregate = 60;
                        var semno = 0;

                        if ($("#hdn_year_code_foundation").val() == 'Y2017' || $("#hdn_year_code_foundation").val() == 'Y2018' || $("#hdn_year_code_foundation").val() == 'Y2019') {
                            sem1_pass_aggregate = 50;
                        }
                        else if (parseInt($("#hdn_year_code_foundation").val().slice(1)) >= 2023)
                        {    //changes 1
                            sem1_pass_aggregate = 55;// for Y2023 and onwards passing marks is 55 - 22012024
                        }
                        else {
                            sem1_pass_aggregate = 60;
                        }

                        if ($("#hdn_year_code_foundation").val() == 'Y2019') {// for Y2019 students passing aggregate marks is 65 - 22072020
                            sem2_pass_aggregate = 65;
                        }

                        var year = parseInt($('#drpyear').val());
                        var sem = $('#drpsemester').val();



                        if (year <= 2018) {
                            if (sem == "S" || year < 2018 && sem == "M") {
                                // for Spring 2018 and before
                                for (var i = 0; i < obj_course_detail.length; i++) {
                                    str_foundation_html += '<tr>';
                                    str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['Total'] + '/100</td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                                    str_foundation_html += '</tr>';

                                    if (!(parseInt(obj_course_detail[i]['Total']) >= 50)) {
                                        pass_fail_flag = pass_fail_flag * 0;
                                    }

                                    if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * 25) / 100;
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * 75) / 100;
                                    }

                                    total_credits += parseInt(obj_course_detail[i]['course_credits']);
                                }

                                if (pass_fail_flag) $('#spn_pass_fail').html('PASS');
                                else $('#spn_pass_fail').html('FAIL');

                                str_foundation_html += '<tr><td colspan="3"><b>' + total_marks.toFixed(0) + ' Out of 100 - 20 Credits </b>(If, 50 or greater than 50, then Pass.)</td></tr>';

                                $('#tbl_foundation_marks').append(str_foundation_html);

                                $('#tbl_foundation_marks').parent().parent().css('display', 'block');
                                $('#tbl_foundation_marks_new').css('display', 'none');
                                $('#div_marksheet_tbl').css('display', 'none');

                            } else {
                                // for Monsson 2018 and onwards
                                $('#tbl_foundation_marks_new tbody').html('');
                                str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                                for (var i = 0; i < obj_course_detail.length; i++) {
                                    str_foundation_html += '<tr>';
                                    str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                                    if (i == 0) {
                                        str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                                    }
                                    str_foundation_html += '</tr > ';

                                    if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                                        pass_fail_flag = pass_fail_flag * 0;
                                    }

                                    if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }

                                    total_credits += parseInt(obj_course_detail[i]['course_credits']);
                                }

                                aggregate = total_marks / total_credits;

                                final_aggregate = parseInt(aggregate.toFixed(0));

                                $('#tbl_foundation_marks_new').append(str_foundation_html);

                                if (pass_fail_flag) {
                                    if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                                        $('#spn_pass_fail_new').html('PASS');
                                    }
                                    else {
                                        $('#spn_pass_fail_new').html('FAIL');
                                    }
                                }
                                else {
                                    $('#spn_pass_fail_new').html('FAIL');
                                }

                                $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                                $('#tbl_foundation_marks').css('display', 'none');
                                $('#div_marksheet_tbl').css('display', 'none');
                            }
                        } else {
                            // for Monsson 2018 and onwards
                            $('#tbl_foundation_marks_new tbody').html('');
                            str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                            for (var i = 0; i < obj_course_detail.length; i++) {
                                str_foundation_html += '<tr>';
                                str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                                if (i == 0) {
                                    str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                                }
                                str_foundation_html += '</tr > ';

                                if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                                    pass_fail_flag = pass_fail_flag * 0;
                                }

                                if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                total_credits += parseInt(obj_course_detail[i]['course_credits']);
                            }

                            aggregate = total_marks / total_credits;

                            final_aggregate = parseInt(aggregate.toFixed(0));

                            $('#tbl_foundation_marks_new').append(str_foundation_html);

                            if (pass_fail_flag) {
                                if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                                    $('#spn_pass_fail_new').html('PASS');
                                }
                                else {
                                    $('#spn_pass_fail_new').html('FAIL');
                                }
                            }
                            else {
                                $('#spn_pass_fail_new').html('FAIL');
                            }

                            $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                            $('#tbl_foundation_marks').css('display', 'none');
                            $('#div_marksheet_tbl').css('display', 'none');
                        }

                        foundation_flag = true;
                        $('#div_mid_term').css('display', 'none');
                        //For Foundation Internal and Midterm Marks not to be shown
                    }
                }
                else if (obj_course_detail != null && obj_course_detail != undefined && obj_course_detail.length != 0) {
                    var is_foud = false;
                    for (var i = 0; i < obj_course_detail.length; i++) {
                        if (obj_course_detail[i]['course_code'] == "CFP001" || obj_course_detail[i]['course_code'] == "CFP002" || obj_course_detail[i]['course_code'] == "CFP003" || obj_course_detail[i]['course_code'] == "CFP007"
                            || obj_course_detail[i]['course_code'] == "CFP004" || obj_course_detail[i]['course_code'] == "CFP005" || obj_course_detail[i]['course_code'] == "CFP006" || obj_course_detail[i]['course_code'] == "CFP008"
                            || obj_course_detail[i]['course_code'] == "CFP009" || obj_course_detail[i]['course_code'] == "CFP010") {
                            is_foud = true;
                        }
                    }

                    if (!is_foud) {
                        var strTableCourseDetail = " <tr><th>COURSE CODE</th><th>TITLE OF THE COURSE</th><th>CORE/ ELECTIVE</th><th>CREDIT</th>" +
                            //" <th>MARKS</th>" +
                            " <th>GPA/ NGPA</th>" +
                            " <th>GRADE</th>";

                        //if (obj_stud_detail[0]["year_code"] < 'Y2014') { strTableCourseDetail = strTableCourseDetail + "<th>GRADE POINT</th>"; }

                        strTableCourseDetail = strTableCourseDetail + "<th>REMARKS</th>";
                        strTableCourseDetail = strTableCourseDetail + "<th>Outline</th></tr>";

                        for (var i = 0; i < obj_course_detail.length; i++) {
                            strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_course_detail[i]['course_code'] + "</a></td>" +
                                "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_course_detail[i]['course_name'] + "</a></td>" +
                                "<td>" + obj_course_detail[i]['c_type'] + "</td>" +
                                "<td>" + obj_course_detail[i]['course_credits'] + "</td>";
                            //"<td>" + obj_course_detail[i]['Total'] + "</td>";

                            if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
                            else if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
                            else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
                            else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
                            else { strTableCourseDetail = strTableCourseDetail + "<td></td>"; }

                            strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['grade'] + "</td>";

                            //if (obj_stud_detail[0]["year_code"] < 'Y2014') { strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['grade_point'] + "</td>"; }

                            strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['remarks'] + "</td>";
                            strTableCourseDetail = strTableCourseDetail + "<td><a style='cursor:pointer;color:#0B6CBA;' class='monsoon_spring_course_outline'>Download</a></td></tr>";
                        }

                        $('#tbl_course_marks').html(strTableCourseDetail);

                        $('#div_marksheet_tbl').css('display', '');

                    } else {//Copied and Pasted Above Code

                        var pass_fail_flag = 1;
                        var total_marks = 0;
                        var total_credits = 0;

                        var aggregate = 0;
                        var sem1_pass_aggregate = 50;
                        var sem2_pass_aggregate = 60;
                        var semno = 0;

                        if ($("#hdn_year_code_foundation").val() == 'Y2017' || $("#hdn_year_code_foundation").val() == 'Y2018' || $("#hdn_year_code_foundation").val() == 'Y2019') {
                            sem1_pass_aggregate = 50;
                        }
                        else if (parseInt($("#hdn_year_code_foundation").val().slice(1)) >= 2023) {
                            //changes 1
                            sem1_pass_aggregate = 55; // for Y2023 and onwards passing marks is 55 - 22012024
                        }
                        else {
                            sem1_pass_aggregate = 60;
                        }

                        if ($("#hdn_year_code_foundation").val() == 'Y2019') {// for Y2019 students passing aggregate marks is 65 - 22072020
                            sem2_pass_aggregate = 65;
                        }

                        var year = parseInt($('#drpyear').val());
                        var sem = $('#drpsemester').val();



                        if (year <= 2018) {
                            if (sem == "S" || year < 2018 && sem == "M") {
                                // for Spring 2018 and before
                                for (var i = 0; i < obj_course_detail.length; i++) {
                                    str_foundation_html += '<tr>';
                                    str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['Total'] + '/100</td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                                    str_foundation_html += '</tr>';

                                    if (!(parseInt(obj_course_detail[i]['Total']) >= 50)) {
                                        pass_fail_flag = pass_fail_flag * 0;
                                    }

                                    if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * 25) / 100;
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * 75) / 100;
                                    }

                                    total_credits += parseInt(obj_course_detail[i]['course_credits']);
                                }

                                if (pass_fail_flag) $('#spn_pass_fail').html('PASS');
                                else $('#spn_pass_fail').html('FAIL');

                                str_foundation_html += '<tr><td colspan="3"><b>' + total_marks.toFixed(0) + ' Out of 100 - 20 Credits </b>(If, 50 or greater than 50, then Pass.)</td></tr>';

                                $('#tbl_foundation_marks').append(str_foundation_html);

                                $('#tbl_foundation_marks').parent().parent().css('display', 'block');
                                $('#tbl_foundation_marks_new').css('display', 'none');
                                $('#div_marksheet_tbl').css('display', 'none');
                            } else {
                                // for Monsson 2018 and onwards
                                $('#tbl_foundation_marks_new tbody').html('');
                                str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                                for (var i = 0; i < obj_course_detail.length; i++) {
                                    str_foundation_html += '<tr>';
                                    str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                                    if (i == 0) {
                                        str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                                    }
                                    str_foundation_html += '</tr > ';

                                    if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                                        pass_fail_flag = pass_fail_flag * 0;
                                    }

                                    if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                                        semno = 1;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }
                                    else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                                        semno = 2;
                                        total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                    }

                                    total_credits += parseInt(obj_course_detail[i]['course_credits']);
                                }

                                aggregate = total_marks / total_credits;

                                final_aggregate = parseInt(aggregate.toFixed(0));

                                $('#tbl_foundation_marks_new').append(str_foundation_html);

                                if (pass_fail_flag) {
                                    if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                                        $('#spn_pass_fail_new').html('PASS');
                                    }
                                    else {
                                        $('#spn_pass_fail_new').html('FAIL');
                                    }
                                }
                                else {
                                    $('#spn_pass_fail_new').html('FAIL');
                                }

                                $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                                $('#tbl_foundation_marks').css('display', 'none');
                                $('#div_marksheet_tbl').css('display', 'none');
                            }
                        } else {
                            // for Monsson 2018 and onwards
                            $('#tbl_foundation_marks_new tbody').html('');
                            str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                            for (var i = 0; i < obj_course_detail.length; i++) {
                                str_foundation_html += '<tr>';
                                str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                                if (i == 0) {
                                    str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                                }
                                str_foundation_html += '</tr > ';

                                if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                                    pass_fail_flag = pass_fail_flag * 0;
                                }

                                if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                                    semno = 1;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                                    semno = 2;
                                    total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                                }
                                total_credits += parseInt(obj_course_detail[i]['course_credits']);
                            }

                            aggregate = total_marks / total_credits;

                            final_aggregate = parseInt(aggregate.toFixed(0));

                            $('#tbl_foundation_marks_new').append(str_foundation_html);

                            if (pass_fail_flag) {
                                if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                                    $('#spn_pass_fail_new').html('PASS');
                                }
                                else {
                                    $('#spn_pass_fail_new').html('FAIL');
                                }
                            }
                            else {
                                $('#spn_pass_fail_new').html('FAIL');
                            }

                            $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                            $('#tbl_foundation_marks').css('display', 'none');
                            $('#div_marksheet_tbl').css('display', 'none');
                        }
                        foundation_flag = true;
                        $('#div_mid_term').css('display', 'none');
                    }

                    $('#div_download_pdf').css('display', 'block');
                } else {
                    $('#div_download_pdf').css('display', 'none');
                    $('#div_marksheet_tbl').css('display', 'none');
                }
            }

            function setWSCourseDetail(data) {
                obj_ws_course_detail = JSON.parse(data)['ws_course_grade_detail'];

                if (obj_ws_course_detail != null && obj_ws_course_detail != undefined && obj_ws_course_detail.length != 0) {
                    var strTableCourseDetail = "<tr><th>COURSE CODE</th><th>COURSE NAME</th><th>GPA/ NGPA</th><th>CREDITS</th><th>STATUS</th></tr>";

                    for (var i = 0; i < obj_ws_course_detail.length; i++) {
                        strTableCourseDetail = strTableCourseDetail + "<tr>" +
                            "<td>" + obj_ws_course_detail[i]['course_code'] + "</td>" +
                            "<td>" + obj_ws_course_detail[i]['course_name'] + "</td>";

                        if (obj_ws_course_detail[i]['c_type'] == 'M' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
                        else if (obj_ws_course_detail[i]['c_type'] == 'M' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
                        else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
                        else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
                        else { strTableCourseDetail = strTableCourseDetail + "<td></td>"; }

                        strTableCourseDetail = strTableCourseDetail + "<td>" + obj_ws_course_detail[i]['course_credits'] + "</td>";

                        //if (obj_ws_course_detail[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td>PASS</td></tr>";
                        //else if (obj_ws_course_detail[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td>FAIL</td></tr>";

                        strTableCourseDetail = strTableCourseDetail + "<td>" + obj_ws_course_detail[i]['remarks'] + "</td></tr>";
                    }

                    $('#tbl_ws_course_marks').html(strTableCourseDetail);
                    $('#div_ws_course_marks').css('display', 'block');

                    if (obj_ws_course_detail[0]['semester_type'] == 'S') $('#title_ws_course_marks').html("Summer School");
                    else if (obj_ws_course_detail[0]['semester_type'] == 'W') $('#title_ws_course_marks').html("Winter School");
                }
                else {//Added 17102019 Mayur
                    $('#tbl_ws_course_marks').html('');
                    $('#div_ws_course_marks').css('display', 'none');//Added 17102019 Mayur
                }//Added 17102019 Mayur
            }
        });

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Verify Grade Student Wise
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            
            <div class="panel-heading">
                <strong><span id="spn_course_name" class="panel-headingfont"></span> </strong>
                <span style="float:right;">
                    
                </span>
            </div>
            
            <div>
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

    </div>

    <input type="hidden" id="hdn_ss" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_s" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_y" runat="server" clientidmode="Static" />
    <asp:HiddenField ID="hdnusertype" runat="server" ClientIDMode="Static" />
</asp:Content>

