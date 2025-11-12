<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GradeTranscriptPDF_UG_10sem.aspx.cs" Inherits="Admin_Report_GradeTranscriptPDF_UG_10sem" %>

<html xmlns="https://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <script type="text/javascript">
        var obj_stud_detail;
        var obj_course_detail;
        var obj_transcript_detail;
        //var obj_credit_detail;
        var ws_course_credits = 0;

        $(document).ready(function () {
            if ($("#hdn_stud_detail").val() != '') {
                obj_stud_detail = JSON.parse($("#hdn_stud_detail").val());
            }
            if ($("#hdn_course_detail").val() != '') {
                obj_course_detail = JSON.parse($("#hdn_course_detail").val());
            }
            if ($("#hdn_transcript_detail").val() != '') {
                obj_transcript_detail = JSON.parse($("#hdn_transcript_detail").val());
            }
            //if ($("#hdn_credit_detail").val() != '') {
            //    obj_credit_detail = JSON.parse($("#hdn_credit_detail").val());
            //}

            setStudentDetail();
            setCourseDetail();
            //set_WS_CourseDetail();
            //setCreditDetail();
            display_Grade_Range();

            $('table').css('border-color', 'black');
            $('table th').css('border-color', 'black');
            $('table td').css('border-color', 'black');

            $('#tbl_aggregate_avg td').css('border', '1px solid black');
            $('#tbl_aggregate_avg td').css('font-size', '11px');
            $('#tbl_aggregate_avg tr td:nth-child(3)').css('border-top', '0px');
            $('#tbl_aggregate_avg tr td:nth-child(3)').css('border-bottom', '0px')
            $('#tbl_aggregate_avg tr:first-child td:nth-child(3)').css('border-top', '1px solid black');
            $('#tbl_aggregate_avg tr:last-child td:nth-child(3)').css('border-bottom', '1px solid black');
            $('#tbl_aggregate_avg tr td:nth-child(2)').css('text-align', 'center');
            $('#tbl_aggregate_avg tr td:last-child').css('text-align', 'center');
            $('#tbl_aggregate_avg tr td:nth-child(1)').css('width', '32%');
            $('#tbl_aggregate_avg tr td:nth-child(2)').css('width', '8%');

            if ($('#hdn_tab').val() == 'Y') {
                $('title').html('Transcript');
                $('body').css('padding', '0 100px');
                var mywindow = window.open('_blank');
                mywindow.document.write(document.getElementsByTagName('html')[0].innerHTML);
            }
        });

        function setStudentDetail() {

            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                var str_program = '';

                var str_program_new = obj_stud_detail[0]['prog_level_name'];//28/08/2019

                var stud_year_code = obj_stud_detail[0]["year_code"];
                if (obj_stud_detail[0]["year_code"] == 'Y1') stud_year_code = 'Y2013';

                //Start : No Longer Used from 28/08/2019
                if (obj_stud_detail[0]["prog_desc"] == 'Landscape Architecture') {
                    str_program = 'MASTERS IN LANDSCAPE ARCHITECTURE';
                }
                else if (obj_stud_detail[0]["prog_desc"] == 'Landscape Design') {
                    str_program = 'MASTERS IN LANSCAPE DESIGN';
                }
                else if (obj_stud_detail[0]['prog_code'] == '1') { // FD UG //obj_stud_detail[0]['dept_code'] == '2' && //30072019
                    str_program = obj_stud_detail[0]['prog_level_name'];//'BACHELOR OF INTERIOR DESIGN'//30072019
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '1' && stud_year_code >= 'Y2016') { // FP UG
                    str_program = 'BACHELOR OF URBAN DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '2' && stud_year_code == 'Y2014') { // FP PG
                    str_program = 'MASTER OF PLANNING';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '2' && stud_year_code >= 'Y2015') { // FP PG
                    str_program = 'MASTER OF URBAN DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '1' && stud_year_code <= 'Y2012') { // FT UG
                    str_program = 'BACHELOR OF TECHNOLOGY(HONS. CIVIL-CONSTRUCTION)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '1' && stud_year_code >= 'Y2013') { // FT UG
                    str_program = 'BACHELOR OF CONSTRUCTION TECHNOLOGY';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT1') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (CONSTRUCTION ENGINEERING & MANAGEMENT)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT2') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (GEOMATICS)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT3') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (INFRASTRUCTURE ENGINEERING DESIGN)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT4') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (STRUCTURAL ENGINEERING DESIGN)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT5') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (BUILDING ENERGY PERFORMANCE)';
                }
                else if (obj_stud_detail[0]["prog_level_name"] == '') {
                    switch (obj_stud_detail[0]["prog_code"]) {
                        case "1": str_program = "BACHELOR OF " + obj_stud_detail[0]["dept_name"]; break;
                        case "2": str_program = "MASTER OF " + obj_stud_detail[0]["dept_name"]; break;
                    }
                }
                else {
                    str_program = obj_stud_detail[0]["prog_level_name"];
                }
                //End : No Longer Used from 28/08/2019

                //$('#td_program').html(str_program.toUpperCase());

                $('#td_program').html(str_program_new.toUpperCase());//28/08/2019

                //$('#div_program').html("<b>"+str_program.toUpperCase()+"</b>");

                $('#td_name').html((obj_stud_detail[0]["full_name"]).toUpperCase());

                $('#td_rollno').html(obj_stud_detail[0]["user_id"]);

                if (obj_stud_detail[0]['dob'] != '') {
                    //var dob = new Date(obj_transcript_detail[0]["dob"]);
                    var dob = new Date(obj_stud_detail[0]['dob']);
                    $('#td_dob').html(dob.getDate().toString() + '/' + (dob.getMonth() + 1) + '/' + dob.getFullYear());
                }

                if ($("#hdn_sem").val() == 'S') {
                    $('#td_sem').html("SPRING");
                    $('#td_year').html((parseInt($("#hdn_year").val()) - 1).toString() + "-" + $("#hdn_year").val().toString().substr(2, 2));
                }
                else if ($("#hdn_sem").val() == 'M') {
                    $('#td_sem').html("MONSOON");
                    $('#td_year').html($("#hdn_year").val().toString() + "-" + (parseInt($("#hdn_year").val()) + 1).toString().substr(2, 2));
                }

                //$('#td_year').html($("#hdn_year").val());
                //$('#td_year').html($("#hdn_year").val().toString() + "-" + (parseInt($("#hdn_year").val()) + 1).toString().substr(2, 2));

                if (obj_stud_detail[0]["year_code"] < 'Y2014')
                    $('#div_note').css('display', 'none')

                //$('#td_issuedate').html(obj_stud_detail[0]["full_name"]);
                var issue_date = new Date();
                $('#spn_issue_date').html(issue_date.getDate() + '/' + (issue_date.getMonth() + 1) + '/' + issue_date.getFullYear());
            }

            if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                $('#td_previous_degree').html(obj_transcript_detail[0]["previous_degree"]);
                if (obj_transcript_detail[0]["transcript_no"] != '') {
                    $('.spn_transcript_no').html(obj_transcript_detail[0]["transcript_no"]);
                    $('.spn_transcript_no').parent().css('display', '');
                }
            }
        }

        function setCourseDetail() {
            var aggregate_marks = 0;
            var total_GPA_marks = 0;
            var total_GPA_credits = 0;
            var total_credits = 0;
            var total_table = 6;
            var sem_cnt = 0;
            var table_row_limit = { '0': 0, '1': 0 };
            var total_course = [];
            var to_semester = 0;

            if (obj_course_detail != null && obj_course_detail != undefined) {

                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                    var obj_course = [];
                    var obj_ws_course = [];

                    if (obj_course_detail[cur_sem]['course_detail'] != "") obj_course = JSON.parse(obj_course_detail[cur_sem]['course_detail']);
                    if (obj_course_detail[cur_sem]['ws_course_detail'] != "") obj_ws_course = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                    if (obj_ws_course.length > 0) obj_ws_course.push({});

                    total_course.push(obj_course.length + obj_ws_course.length);

                    if ((obj_course.length + obj_ws_course.length) > 0) to_semester++;

                    if (cur_sem % 2 == 0) {
                        if (total_course[cur_sem] > table_row_limit['0']) table_row_limit['0'] = total_course[cur_sem];
                    }
                    else {
                        if (total_course[cur_sem] > table_row_limit['1']) table_row_limit['1'] = total_course[cur_sem];
                    }
                }

                if (to_semester > 0) $('#spn_to_semester').html(to_semester);
                if (to_semester < 8) $('#td_graduation_year').html('Yet to Complete');

                for (var cur_table = 1; cur_table < total_table; cur_table++) {
                    if (sem_cnt < obj_course_detail.length) {
                        if (cur_table == 1) {
                            //var strTableCourseDetail = "<tr><th style='width:10px;'>COURSE CODE</th><th style='width:10.768%;'>COURSE TITLE</th>" +
                            //                "<th style='width:10px;text-align: center;'>CRS</th><th style='width: 10px;text-align: center;'>MARKS (%)</th>" +
                            //               "<th style='width:10px;text-align: center;'>GRD</th>";

                            var strTableCourseDetail = "<tr><th style='width:3.264%;'>COURSE CODE</th><th style='width:11.768%;'>COURSE TITLE</th>" +
                                "<th style='width:1.576%;text-align: center;'>CRS</th>" +//<th style='width: 2.6%;text-align: center;'>MRK</th>// 18 11 2019
                                "<th style='width:1.696%;text-align: center;border-top-right-radius: 4px;'>GRD</th>" +// 18 11 2019
                                "<th style='width:1.696%;text-align: center;'>GP</th>";//width: 2.6%;// 18 11 2019
                            strTableCourseDetail = strTableCourseDetail + "</tr>";

                            //for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                            for (var cur_sem = sem_cnt; cur_sem < (sem_cnt + 2); cur_sem++) {
                                var mandatory_ngpa = false;

                                if (obj_course_detail[cur_sem]['course_detail'] != '') {
                                    var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);

                                    if (cur_sem_courses[0]['semester_type'] == 'M') {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                    }
                                    else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                        strTableCourseDetail = strTableCourseDetail + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</b></td></tr>";
                                    }

                                    for (var i = 0; i < cur_sem_courses.length; i++) {
                                        strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                            "<td style='text-align: center;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";

                                        //Write Logic of GPA Calculation 08 01 2020 - Done

                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                            if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                                total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                                total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                                total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                            }
                                        }
                                        //Commented 08012020 Start
                                        //if (cur_sem_courses[i]['c_type'] == 'M') {
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        //            cur_sem_courses[i]['Total'] = '-';
                                        //            cur_sem_courses[i]['grade'] = 'P';
                                        //            mandatory_ngpa = true;
                                        //        }
                                        //        else {
                                        //            total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //            total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //            total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        }
                                        //    }
                                        //}
                                        //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //Commented 08012020 Start

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['course_credits'] + "</td>";
                                        //"<td style='text-align: center;'>" + cur_sem_courses[i]['Total'] + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade'] + "</td>";

                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                        } else if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";
                                        }

                                        strTableCourseDetail = strTableCourseDetail + "</tr>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {
                                    if (obj_course_detail[cur_sem]['course_detail'] == '') {
                                        var sem_type = '';
                                        var year_type = $('#hdn_year').val();
                                        if (cur_sem % 2 == 1) {
                                            if ($('#hdn_sem').val() == 'M') {
                                                sem_type = 'S';
                                                year_type = parseInt(year_type) + (cur_table - 1);
                                            }
                                            else if ($('#hdn_sem').val() == 'S') {
                                                sem_type = 'M';
                                                year_type = parseInt(year_type) + (cur_table - 1);
                                            }
                                        }
                                        else {
                                            sem_type = $('#hdn_sem').val();
                                            year_type = parseInt(year_type) + (cur_table - 1);
                                        }

                                        if (sem_type == 'M') {
                                            strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                            strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                        }
                                        else if (sem_type == 'S') {
                                            strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                            strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                        }
                                    }

                                    var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                                    if (cur_sem_ws_courses[0]['semester_type'] == 'W')
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=2><b>Winter School</b></td><td></td><td></td><td></td></tr>";
                                    else if (cur_sem_ws_courses[0]['semester_type'] == 'S')
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=2><b>Summer School</b></td><td></td><td></td><td></td></tr>";

                                    for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                        var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                                        strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                            "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                            if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                                total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            }
                                        }

                                        //write whatever it comes instead of below 08 01 2020 - Done

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";

                                        //Commented 08012020 Start
                                        //if (cur_sem_ws_courses[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>P</td>";
                                        //else if (cur_sem_ws_courses[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NP</td>";
                                        //Commented 08012020 End

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                        } else if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade_point'] + "</td>";
                                        }

                                        strTableCourseDetail = strTableCourseDetail + "</tr>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['course_detail'] == '' && obj_course_detail[cur_sem]['ws_course_detail'] == '') {
                                    var sem_type = '';
                                    var year_type = $('#hdn_year').val();
                                    if (cur_sem % 2 == 1) {
                                        if ($('#hdn_sem').val() == 'M') {
                                            sem_type = 'S';
                                            year_type = parseInt(year_type) + (cur_table - 1);
                                        }
                                        else if ($('#hdn_sem').val() == 'S') {
                                            sem_type = 'M';
                                            year_type = parseInt(year_type) + (cur_table - 1);
                                        }
                                    }
                                    else {
                                        sem_type = $('#hdn_sem').val();
                                        year_type = parseInt(year_type) + (cur_table - 1);
                                    }

                                    if (sem_type == 'M') {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                    }
                                    else if (sem_type == 'S') {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                        strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                    }

                                    //strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 rowspan=" + table_row_limit[cur_sem % 2] + ">&nbsp;</td></tr>";
                                    strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 rowspan=" + table_row_limit[cur_sem % 2] + " style='text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td></tr>";

                                    for (var i = total_course[cur_sem]; i < (table_row_limit[cur_sem % 2] - 1); i++) {
                                        strTableCourseDetail = strTableCourseDetail + "<tr></tr>";
                                    }

                                    if (obj_course_detail[cur_sem]['credit_detail'] == '') {
                                        for (var i = 0; i < 1; i++) {
                                            strTableCourseDetail = strTableCourseDetail + "<tr><td>&nbsp;</td><td></td><td></td><td></td><td></td></tr>";
                                        }
                                    }
                                }
                                else {
                                    for (var i = total_course[cur_sem]; i < table_row_limit[cur_sem % 2]; i++) {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td>&nbsp;</td><td></td><td></td><td></td><td></td></tr>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                    //check whether it is correct or not? 08 01 2020 - 1 - Done
                                    strTableCourseDetail = strTableCourseDetail + "<tr class='cls_semester_aggregate'>" +
                                        "<td style='' colspan=2><b>SEM AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['elective_credit'] + " E)</b></td>"; //<td></td>";

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['total_credit'] + "</b></td>";

                                    //Commented 08012020 Start
                                    //if (mandatory_ngpa) {
                                    //    cur_sem_credit_dtl[0]['semester_marks_avg'] = '-';
                                    //}
                                    //Commented 08012020 End

                                    //18 11 2019 Not needed Mahroof bhai said 
                                    //if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                    //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['semester_marks_avg'] + "</b></td><td></td>"; //<td></td>";
                                    //}
                                    //else {
                                    //    aggregate_marks += parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']);

                                    //    if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                                    //        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                    //        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>"; //<td></td>";
                                    //    }
                                    //    else {
                                    //        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                    //        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>";  //<td></td>";
                                    //    } 
                                    //}

                                    //Commented 08012020 Start
                                    //if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                    //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + "-" + "</b></td><td></td>";
                                    //} else {
                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + "-" + "</b></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>"; //<td></td>";
                                    //}
                                    //Commented 08012020 End

                                    //18 11 2019 Not needed Mahroof bhai said 

                                    strTableCourseDetail = strTableCourseDetail + "</tr>";

                                    ws_course_credits += parseInt(cur_sem_credit_dtl[0]['sws_credit']);
                                }
                            }

                            //check whether it is correct or not? 08 01 2020 - 2 - Done
                            
                            if (total_GPA_marks != 0 && total_credits != 0) {
                                $('#td_aggre_per_marks').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                                //$('#td_aggregate_avg').html(parseFloat(total_GPA_marks / total_credits).toFixed(1)); remove 22112019
                            }
                            if (total_GPA_credits != 0 && total_credits != 0) {
                                $('#td_grade_point_avg').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                                $('#td_aggregate_gpa').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                            }

                            if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                                //strTableCourseDetail = strTableCourseDetail + "<tr><td style='text-align: center;' colspan=2><b>" + obj_transcript_detail[0]['topic_type'] + " TOPIC</b></td><td colspan=3 style='line-height: 18px;border-right: 1px solid black;'>" + obj_transcript_detail[0]['dissertation_topic'] + "</td></tr>";
                                //strTableCourseDetail = strTableCourseDetail + "<tr><td style='text-align: center;' colspan=2><b>" + obj_transcript_detail[0]['topic_type'] + " SUPERVISOR</b></td><td colspan=3 style='border-right: 1px solid black;'>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td></tr>";
                            }

                            $('#tbl_course_marks1').html(strTableCourseDetail);
                        }
                        else {
                            var row_cnt = 0;
                            strTableCourseDetail = '';

                            //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<th style='width:10px;border-left: 2px solid black;'>COURSE CODE</th><th style='width:10.768%;'>COURSE TITLE</th>" +
                            //                "<th style='width:10px;text-align: center;'>CRS</th><th style='width: 10px;text-align: center;'>MARKS (%)</th>" +
                            //               "<th style='width:10px;text-align: center;'>GRD</th>";

                            $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<th style='width:3.264%;border-left: 2px solid black;border-top-left-radius: 4px;'>COURSE CODE</th><th style='width:11.768%;'>COURSE TITLE</th>" +
                                "<th style='width:1.576%;text-align: center;'>CRS</th>" +//<th style='width: 2.6%;text-align: center;'>MRK</th> // 18 11 2019
                                "<th style='width:1.696%;text-align: center;border-top-right-radius: 4px;'>GRD</th>" + // 18 11 2019
                                "<th style='width:1.696%;text-align: center;'>GP</th>";//width: 2.6%// 18 11 2019
                            //for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                            for (var cur_sem = sem_cnt; cur_sem < (sem_cnt + 2); cur_sem++) {
                                //var mandatory_ngpa = false;

                                if (obj_course_detail[cur_sem]['course_detail'] != '') {
                                    var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);

                                    if (cur_sem_courses[0]['semester_type'] == 'M') {
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=5 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td>";
                                    }
                                    else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=5 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                        strTableCourseDetail = strTableCourseDetail + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</b></td>";
                                    }

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                    strTableCourseDetail = '';

                                    for (var i = 0; i < cur_sem_courses.length; i++) {
                                        strTableCourseDetail = strTableCourseDetail +
                                            "<td style='text-align: center;border-left: 2px solid black;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";

                                        //Write Logic of GPA Calculation 08 01 2020 - Done

                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                            if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                                total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                                total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                                total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                            }
                                        }

                                        //Commented 08012020 Start
                                        //if (cur_sem_courses[i]['c_type'] == 'M') {
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        //            cur_sem_courses[i]['Total'] = '-';
                                        //            cur_sem_courses[i]['grade'] = 'P';
                                        //            mandatory_ngpa = true;
                                        //        }
                                        //        else {
                                        //            total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //            total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //            total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        }
                                        //    }
                                        //}
                                        //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //Commented 08012020 End

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['course_credits'] + "</td>";
                                        //"<td style='text-align: center;'>" + cur_sem_courses[i]['Total'] + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade'] + "</td>";

                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                        } else if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";
                                        }

                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                        strTableCourseDetail = '';
                                    }
                                }

                                if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {
                                    if (obj_course_detail[cur_sem]['course_detail'] == '') {
                                        var sem_type = '';
                                        var year_type = $('#hdn_year').val();
                                        if (cur_sem % 2 == 1) {
                                            if ($('#hdn_sem').val() == 'M') {
                                                sem_type = 'S';
                                                year_type = parseInt(year_type) + (cur_table - 1);
                                            }
                                            else if ($('#hdn_sem').val() == 'S') {
                                                sem_type = 'M';
                                                year_type = parseInt(year_type) + (cur_table - 1);
                                            }
                                        }
                                        else {
                                            sem_type = $('#hdn_sem').val();
                                            year_type = parseInt(year_type) + (cur_table - 1);
                                        }

                                        if (sem_type == 'M') {
                                            strTableCourseDetail = strTableCourseDetail + "<td colspan=5 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                            strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                        }
                                        else if (sem_type == 'S') {
                                            strTableCourseDetail = strTableCourseDetail + "<td colspan=5 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                            strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                        }


                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                        strTableCourseDetail = '';
                                    }

                                    var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                                    if (cur_sem_ws_courses[0]['semester_type'] == 'W')
                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;' colspan=2><b>Winter School</b></td><td></td><td></td><td></td>";
                                    else if (cur_sem_ws_courses[0]['semester_type'] == 'S')
                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;' colspan=2><b>Summer School</b></td><td></td><td></td><td></td>";

                                    for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                        var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                                        strTableCourseDetail = strTableCourseDetail +
                                            "<td style='text-align: center;border-left: 2px solid black;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                            if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                                total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            }
                                        }

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                        } else if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade_point'] + "</td>";
                                        }

                                        //Commented 08012020 Start
                                        //if (cur_sem_ws_courses[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>P</td>";
                                        //else if (cur_sem_ws_courses[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NP</td>";
                                        //Commented 08012020 End

                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                        strTableCourseDetail = '';
                                    }
                                }

                                if (obj_course_detail[cur_sem]['course_detail'] == '' && obj_course_detail[cur_sem]['ws_course_detail'] == '') {
                                    var sem_type = '';
                                    var year_type = $('#hdn_year').val();
                                    if (cur_sem % 2 == 1) {
                                        if ($('#hdn_sem').val() == 'M') {
                                            sem_type = 'S';
                                            year_type = parseInt(year_type) + (cur_table - 1);
                                        }
                                        else if ($('#hdn_sem').val() == 'S') {
                                            sem_type = 'M';
                                            year_type = parseInt(year_type) + (cur_table - 1);
                                        }
                                    }
                                    else {
                                        sem_type = $('#hdn_sem').val();
                                        year_type = parseInt(year_type) + (cur_table - 1);
                                    }

                                    if (sem_type == 'M') {
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=5 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                    }
                                    else if (sem_type == 'S') {
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=5 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                        strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                    }

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                    strTableCourseDetail = '';

                                    //$('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=5 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 2px solid black;'>&nbsp;</td>";
                                    $('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=5 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 2px solid black;text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td>";
                                    if (table_row_limit[cur_sem % 2] == 0) row_cnt++;
                                    else row_cnt += table_row_limit[cur_sem % 2];

                                    if (obj_course_detail[cur_sem]['credit_detail'] == '') {
                                        for (var i = 0; i < 1; i++) {
                                            $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td>";
                                        }
                                    }
                                }
                                else {
                                    for (var i = total_course[cur_sem]; i < table_row_limit[cur_sem % 2]; i++) {
                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                    strTableCourseDetail = strTableCourseDetail +
                                        "<td style='border-left: 2px solid black;' colspan=2><b>SEM AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['elective_credit'] + " E)</b></td>"; //<td></td>";

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['total_credit'] + "</b></td>";

                                    if (mandatory_ngpa) {
                                        cur_sem_credit_dtl[0]['semester_marks_avg'] = '-';
                                    }

                                    //18 11 2019 Not needed Mahroof bhai said
                                    //if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                    //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['semester_marks_avg'] + "</b></td><td></td>"; //<td></td>";
                                    //}
                                    //else {
                                    //    aggregate_marks += parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']);

                                    //    if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                                    //        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                    //        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>"; //<td></td>";
                                    //    }
                                    //    else {
                                    //        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                    //        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>";  //<td></td>";
                                    //    } 
                                    //}
                                    if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + "-" + "</b></td><td></td>";
                                    } else {
                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + "-" + "</b></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>"; //<td></td>";
                                    }
                                    //18 11 2019 Not needed Mahroof bhai said

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                    strTableCourseDetail = '';

                                    ws_course_credits += parseInt(cur_sem_credit_dtl[0]['sws_credit']);
                                }
                            }

                            if (total_GPA_marks != 0 && total_credits != 0) {
                                $('#td_aggre_per_marks').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                                //$('#td_aggregate_avg').html(parseFloat(total_GPA_marks / total_credits).toFixed(1)); remove 22112019
                            }
                            if (total_GPA_credits != 0 && total_credits != 0) {
                                $('#td_grade_point_avg').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                                $('#td_aggregate_gpa').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                            }

                            if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                                //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='text-align: center;' colspan=2><b>" + obj_transcript_detail[0]['topic_type'] + " TOPIC</b></td><td colspan=3 style='line-height: 18px;border-right: 1px solid black;'>" + obj_transcript_detail[0]['dissertation_topic'] + "</td>";
                                //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='text-align: center;' colspan=2><b>" + obj_transcript_detail[0]['topic_type'] + " SUPERVISOR</b></td><td colspan=3 style='border-right: 1px solid black;'>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td>";
                            }
                        }

                        sem_cnt += 2;
                    }
                }

                $('#tbl_course_marks1 tr th').css('font-size', '14px');
                $('#tbl_course_marks1 tr td').css('font-size', '14px');
                $('#tbl_course_marks1 tr th').css('padding-top', '1px');
                $('#tbl_course_marks1 tr th').css('padding-bottom', '1px');
                $('#tbl_course_marks1 tr td').css('padding-top', '0px');
                $('#tbl_course_marks1 tr td').css('padding-bottom', '2px');
                $('#tbl_course_marks1 th,#tbl_course_marks1 td').css('font-size', '11px');
                $('#tbl_course_marks1 th,#tbl_course_marks1 td').css('padding', '1px 1px 1px 1px');
                $('#tbl_course_marks1 th,#tbl_course_marks1 td').css('line-height', '16px');
                $('#tbl_course_marks1 tr th').css('border-top', '2px solid black');
                $('#tbl_course_marks1 .cls_semester_aggregate td').css('border-bottom', '1px solid black');

                $('#tbl_student_detail tr td').css('line-height', '11px');
                $('#tbl_student_detail').css('margin-bottom', '2px');
                $('#tbl_student_detail').css('font-size', '15px');

                if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                    //strTableCourseDetail = "<tr><td colspan=2 style='font-size: 12px;line-height: 10px;'>MINIMUM PASSING REQUIREMENT: 50% IN EACH SUBJECT</td><td colspan=2 style='font-size: 12px;line-height: 10px;'>C=CORE, E= ELECTIVE</td><td colspan=4 style='font-size: 10px;line-height: 10px;padding-left: 4px;padding-right: 2px;border-right: 1px solid black;'>'ALL SUBJECTS CARRY MAXIMUM 100 MARKS EACH'</td></tr>";
                    //$('#tbl_course_marks1').append(strTableCourseDetail);

                    if (obj_stud_detail[0]['dept_name'].toUpperCase() == 'PLANNING' && obj_stud_detail[0]['prog_name'].toUpperCase() == 'PG') {
                        var str_degree = 'MASTER OF PLANNING';

                        if (obj_transcript_detail[0]['specialization'] != '') str_degree += ' (' + obj_transcript_detail[0]['specialization'] + ')';

                        $('#td_program').html(str_degree);
                    }

                    if (obj_transcript_detail[0]['name_of_the_degree'] != '') $('#td_program').html(obj_transcript_detail[0]['name_of_the_degree'].toUpperCase());

                    if (obj_transcript_detail[0]['graduation_year'] != '') $('#td_graduation_year').html(obj_transcript_detail[0]['graduation_year'].toUpperCase());
                }

                //check whether it is correct or not? 08 01 2020 - Ongoing
                var total_core_credit = 0;
                var total_elective_credit = 0;
                var total_ngpa_credit = 0;

                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                    var obj_course_credit = [];

                    if (obj_course_detail[cur_sem]['credit_detail'] != "") {
                        obj_course_credit = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                        total_core_credit += parseInt(obj_course_credit[0]['core_credit']);//M (G+N)
                        //total_elective_credit += parseInt(obj_course_credit[0]['elective_credit']);
                        total_elective_credit += parseInt(obj_course_credit[0]['gpa_credit']);//E(G)
                        total_ngpa_credit += parseInt(obj_course_credit[0]['ngpa_credit']);//E(N)
                    }
                }
                $('#td_core').html(total_core_credit);
                $('#td_elective').html(total_elective_credit);
                $('#td_non_gpa').html(total_ngpa_credit);
                $('#td_ws_credit').html(ws_course_credits);//ok
                $('#td_total').html(total_core_credit + total_elective_credit + total_ngpa_credit + ws_course_credits);
            }
        }

        function display_Grade_Range() {
            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                    $('#div_grade_range').css('display', 'block');
                    $('#div_grade_range table').css('font-size', '11px');
                    $('#div_grade_range table tr th').css('line-height', '5px');
                    $('#div_grade_range table tr td').css('line-height', '5px');
                }
                else {
                    $('#div_grade_range_2014_onward').css('display', 'block');
                    $('#div_grade_range_2014_onward table').css('font-size', '11px');
                    $('#div_grade_range_2014_onward table tr th').css('line-height', '5px');
                    $('#div_grade_range_2014_onward table tr td').css('line-height', '5px');
                }
            }
        }

        function round_num(num, precision) {
            return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
        }
    </script>
</head>
<%--<body class="container" style="color:Black;width:1170px;">--%>
<body style="color: Black; padding-left: 1%; padding-right: 1%;">

    <div style="top: 2px; width: 99%; height: 96px; left: 1px; position: absolute;" title="" id="i22byht1" align="right">

        <%--<div style="float: left;margin-top: 66px;margin-left: 5px;font-size: large;"><b>OFFICIAL TRANSCRIPT</b></div>--%>

        <%--<a style="width: 297px; height: 96px; cursor: default;float:right;" href="" id="i22byht1link">--%>
        <div id="i22byht1img" style="width: 297px; height: 96px; position: relative;">
            <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage" />
        </div>
        <%--</a>--%>
    </div>

    <div>
        <div style="margin-top: 2px; margin-bottom: 2px; margin-left: 5px; font-size: large;"><b>OFFICIAL TRANSCRIPT</b></div>

        <table id="tbl_student_detail" class="table table-condensed">
            <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE DEGREE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_program" style="border: none;" colspan="4"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE STUDENT</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_name" style="border: none;" colspan="4"></td>
            </tr>
            <%--<tr style="display:none;">
                <td style="border:none;width:240px;"><b>STUDENT ROLL NO.</b></td>
                <td style="border:none;width:10px;"> : </td>
                <td id="td_rollno" style="border:none;"></td>
            </tr>--%>
            <tr>
                <td style="border: none; width: 300px;"><b>MONTH AND YEAR OF GRADUATION</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_graduation_year" style="border: none; width: 230px;">May 2015</td>

                <td style="border: none; width: 160px;"><b>STUDENT CODE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_rollno" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 230px;"><b>MEDIUM OF INSTRUCTION</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_medium_of_instruction" style="border: none;">English</td>

                <td style="border: none; width: 160px;"><b>DATE OF BIRTH</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_dob" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px; display: none;"><b>GRADE POINT AVERAGE</b></td>
                <td style="border: none; width: 10px; display: none;">: </td>
                <td id="td_grade_point_avg" style="border: none; display: none;"></td>

                <td style="border: none; width: 240px; display: none;"><b>AGGREGATE PERCENTAGE MARKS</b></td>
                <td style="border: none; width: 10px; display: none;">: </td>
                <td id="td_aggre_per_marks" style="border: none; display: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 160px; display: none;"><b>PREVIOUS DEGREE</b></td>
                <td style="border: none; width: 10px; display: none;">: </td>
                <td id="td_previous_degree" style="border: none; display: none;" colspan="4"></td>
            </tr>
            <tr style="display: none;">
                <td style="border: none; width: 240px;"><b>SEMESTER</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_sem" style="border: none;"></td>
            </tr>
            <tr style="display: none;">
                <td style="border: none; width: 240px;"><b>YEAR</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_year" style="border: none;"></td>
            </tr>
            <tr style="display: none;">
                <td style="border: none; width: 240px;"><b>DATE OF ISSUE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_issuedate" style="border: none;"></td>
            </tr>
        </table>
    </div>

    <div style="min-height: 676px;">

        <table id="tbl_course_marks1" class="table table-bordered" style="margin-bottom: 0px; border-top: 0px solid black; border-left: 1px solid black; border-right: 2px solid black; border-bottom: 1px solid black; width: 100%; float: left;">
        </table>

        <table id="tbl_course_marks2" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

        <table id="tbl_course_marks3" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

        <table id="tbl_course_marks4" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

        <table id="tbl_course_marks5" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

    </div>

    <div style="float: left; width: 60%;">
        <div id="div_ug_note" style="margin-top: 5px; font-size: 8px; line-height: 10px;">
            <b>Note = 1. Related Study Program (RSP) not taken into account for AGG.AVG. 
            2. Summer / Winter Training (ST / WT) not taken into account for AGG.AVG. 
            3. Interative Studio (IS) not taken into account for AGG.AVG. 
            4. Office Training (OT) not taken into account for AGG.AVG. 
            5. NGPA : NON GPA</b>
        </div>

        <div id="div_grade_range" style="display: none;">
            <table class="table table-bordered table-condensed">
                <tr>
                    <th>Grade
                    </th>
                    <td>A+
                    </td>
                    <td>A
                    </td>
                    <td>A-
                    </td>
                    <td>B+
                    </td>
                    <td>B
                    </td>
                    <td>B-
                    </td>
                    <td>C+
                    </td>
                    <td>C
                    </td>
                    <td>C-
                    </td>
                    <td>D+
                    </td>
                    <td>D
                    </td>
                    <td>D-
                    </td>
                    <td>F
                    </td>
                    <td>P
                    </td>
                    <td>NP
                    </td>
                    <td>IC
                    </td>
                </tr>
                <tr>
                    <th>Grade Point
                    </th>
                    <td>4.00
                    </td>
                    <td>4.00
                    </td>
                    <td>3.67
                    </td>
                    <td>3.33
                    </td>
                    <td>3.00
                    </td>
                    <td>2.67
                    </td>
                    <td>2.33
                    </td>
                    <td>2.00
                    </td>
                    <td>1.67
                    </td>
                    <td>1.33
                    </td>
                    <td>1.00
                    </td>
                    <td>0.67
                    </td>
                    <td>0
                    </td>
                    <td>NA
                    </td>
                    <td>NA
                    </td>
                    <td>NA
                    </td>
                </tr>
                <tr>
                    <th>Numerical
                    </th>
                    <td>>86
                    </td>
                    <td>83-86
                    </td>
                    <td>80-82
                    </td>
                    <td>77-79
                    </td>
                    <td>73-76
                    </td>
                    <td>70-72
                    </td>
                    <td>67-69
                    </td>
                    <td>63-66
                    </td>
                    <td>60-62
                    </td>
                    <td>57-59
                    </td>
                    <td>53-56
                    </td>
                    <td>50-52
                    </td>
                    <td><50
                    </td>
                    <td>PASS
                    </td>
                    <td>NO PASS
                    </td>
                    <td>In-Complete
                    </td>
                </tr>
            </table>
        </div>

        <div id="div_grade_range_2014_onward" style="display: none;">
            <table class="table table-bordered table-condensed">
                <tr>
                    <th>Grade
                    </th>
                    <td>A+
                    </td>
                    <td>A
                    </td>
                    <td>A-
                    </td>
                    <td>B+
                    </td>
                    <td>B
                    </td>
                    <td>B-
                    </td>
                    <td>C+
                    </td>
                    <td>C
                    </td>
                    <td>C-
                    </td>
                    <td>D+
                    </td>
                    <td>D
                    </td>
                    <td>D-
                    </td>
                    <td>F
                    </td>
                    <td>P
                    </td>
                    <td>NP
                    </td>
                    <td>IC
                    </td>
                </tr>
                <tr>
                    <th>Grade Point
                    </th>
                    <td>4.3
                    </td>
                    <td>4.0
                    </td>
                    <td>3.7
                    </td>
                    <td>3.3
                    </td>
                    <td>3.0
                    </td>
                    <td>2.7
                    </td>
                    <td>2.3
                    </td>
                    <td>2.00
                    </td>
                    <td>1.7
                    </td>
                    <td>1.3
                    </td>
                    <td>1.0
                    </td>
                    <td>0.7
                    </td>
                    <td>0
                    </td>
                    <td>NA
                    </td>
                    <td>NA
                    </td>
                    <td>NA
                    </td>
                </tr>
            </table>
        </div>

        <div style="display: block;">
            <div style="height: 40px;"></div>
            <div style="float: left; margin-bottom: 5px; width: 330px;"><b>Issue Date : </b><span id="spn_issue_date"></span></div>
            <div style="float: left; font-weight: bold; margin-bottom: 5px;">PROGRAM CHAIR</div>
            <div style="float: right; font-weight: bold; margin-bottom: 5px; width: 100px;">DEAN</div>
        </div>
    </div>

    <div style="float: right; width: 38%; margin-top: 1px;">
        <b>AGGREGATE AVERAGE (SEMESTER 1 TO <span id="spn_to_semester"></span>)</b>
        <table id="tbl_aggregate_avg" style="margin-top: 5px; width: 90%;">
            <tr>
                <td><b>CREDITS EARNED</b></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td rowspan="5" colspan="2"></td>
            </tr>
            <tr>
                <td>Core</td>
                <%--<td id="td1">147</td>--%>
                <td id="td_core"></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Elective</td>
                <%--<td id="td1">15</td>--%>
                <td id="td_elective"></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Non GPA Elective</td>
                <%--<td id="td1">7</td>--%>
                <td id="td_non_gpa"></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Summer Winter School</td>
                <td id="td_ws_credit"></td>
                <td>&nbsp;</td>
                <%--<td style="text-align: right;"><b>CUMULATIVE AGGREGATE AVG</b></td>--%><%--22112019--%>
                <%--<td style="width:10%;"><b id="B1">65.78</b></td>--%>
                <%--<td style="width: 10%;"><b id="td_aggregate_avg"></b></td>--%><%--22112019--%>
            </tr>
            <tr>
                <td><b>TOTAL</b></td>
                <%--<td id="td1"><b>169</b></td>--%>
                <td><b id="td_total"></b></td>
                <td>&nbsp;</td>
                <td style="text-align: right;"><b>CUMULATIVE GRADE POINT AVG</b></td>
                <%--<td style="width:10%;"><b id="B1">2.22</b></td>--%>
                <td style="width: 10%;"><b id="td_aggregate_gpa"></b></td>
            </tr>
        </table>

        <div style="float: right; margin-bottom: 5px; margin-top: 11px; display: none;">
            <b>NO : </b><span class="spn_transcript_no"></span>
        </div>
    </div>

    <div id="div_note" style="margin-top: -15px; clear: both;">
        <%--<b>* All grades are as per relative grading policy. Please refer &nbsp;<a href="https://goo.gl/m29t1k">goo.gl/m29t1k</a>&nbsp; for details.</b>--%><%--22112019--%>
    </div>

    <div style="margin-top: -15px; clear: both;">
        &nbsp;
    </div>

    <input type="hidden" id="hdn_uid" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_stud_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_course_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_ws_course_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_credit_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_transcript_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_tab" runat="server" clientidmode="Static" />
</body>
</html>
