<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GradeTranscriptPDF_PG.aspx.cs" Inherits="Admin_Report_GradeTranscriptPDF_PG" %>

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

            //$('#tbl_course_marks1,#tbl_course_marks1 th,#tbl_course_marks1 td,#tbl_dissertation,#tbl_dissertation td').css('border-color', 'red');
            $('table,table th,table td').css('border-color', 'grey');
            $('table,table th,table td').css('border-radius', '0px');
            $('#tbl_student_detail').css('font-size', '15px');

            //$('#tbl_student_detail tbody td').css('border-left', '1px solid');
            //$('#tbl_student_detail tbody td').css('border-top', '1px solid');
            //$('#tbl_student_detail').css('border-right', '1px solid');
            //$('#tbl_student_detail').css('border-bottom', '1px solid');
            //$('#tbl_student_detail tbody tr:first-child td').css('border', '0');

            $('.cls_td_student_detail').css('padding', '3px 8px 2px 0');
            $('.spn_student_detail_title').css('font-size', '11px');
            $('.spn_student_detail_title').css('margin-top', '1px');
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

                var str_program_new = obj_stud_detail[0]['prog_level_name'];//27/08/2019

                var stud_year_code = obj_stud_detail[0]["year_code"];

                if (obj_stud_detail[0]["year_code"] == 'Y1') stud_year_code = 'Y2013';

                //Start : No Longer Used from 27/08/2019
                if (obj_stud_detail[0]["prog_desc"] == 'Landscape Architecture') {
                    str_program = 'MASTERS IN LANDSCAPE ARCHITECTURE';
                }
                else if (obj_stud_detail[0]["prog_desc"] == 'Landscape Design') {
                    str_program = 'MASTERS IN LANSCAPE DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '2' && obj_stud_detail[0]['prog_code'] == '1') { // FD UG
                    str_program = 'BACHELOR OF INTERIOR DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '1' && stud_year_code >= 'Y2016') { // FP UG
                    str_program = 'BACHELOR OF URBAN DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '2' && stud_year_code == 'Y2014') { // FP PG
                    str_program = 'MASTER OF PLANNING';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '2' && stud_year_code >= 'Y2015') { // FP PG
                    str_program = 'Master of Urban and Regional Planning';
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
                //End : No Longer Used from 27/08/2019

                //$('.td_program').html(str_program.toUpperCase());

                $('.td_program').html(str_program_new.toUpperCase());//27/08/2019

                //$('#div_program').html("<b>"+str_program.toUpperCase()+"</b>");

                $('.td_name').html((obj_stud_detail[0]["full_name"]).toUpperCase());

                $('.td_rollno').html((obj_stud_detail[0]["user_id"]).toUpperCase());

                if (obj_stud_detail[0]['dob'] != '') {
                    //var dob = new Date(obj_transcript_detail[0]["dob"]);
                    var dob = new Date(obj_stud_detail[0]['dob']);
                    $('.td_dob').html(dob.getDate().toString() + '/' + (dob.getMonth() + 1) + '/' + dob.getFullYear());
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

                if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                    $('#div_note').css('display', 'none');
                }
                else {
                    $('#div_blank').css('height', '92px');
                }

                //$('#td_issuedate').html(obj_stud_detail[0]["full_name"]);
                var issue_date = new Date();
                $('.spn_issue_date').html(issue_date.getDate() + '/' + (issue_date.getMonth() + 1) + '/' + issue_date.getFullYear());
            }

            if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                $('#td_previous_degree').html(obj_transcript_detail[0]["previous_degree"]);

                var str_dissertation_html = '';
                str_dissertation_html += "<tr><td style='text-align: center;width:15%;' colspan=2><b>" + obj_transcript_detail[0]['topic_type'] + " TOPIC</b></td><td colspan=3 style='line-height: 18px;width:35%;'>" + obj_transcript_detail[0]['dissertation_topic'] + "</td>";
                str_dissertation_html += "<td style='text-align: center;width:15%;' colspan=2><b>" + obj_transcript_detail[0]['topic_type'] + " SUPERVISOR</b></td><td colspan=3 style='width:35%;'>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td></tr>";

                $('#tbl_dissertation tbody')[0].innerHTML += str_dissertation_html;
                $('#tbl_dissertation').css('display', '');
                $('.spn_transcript_no').html(obj_transcript_detail[0]["transcript_no"]);
                $('.td_major').html((obj_transcript_detail[0]["major"]).toUpperCase());
                $('.td_minor').html((obj_transcript_detail[0]["minor"]).toUpperCase());

                if (obj_transcript_detail[0]["major"].toString() == '' && obj_transcript_detail[0]["minor"].toString() == '') {
                    $('.cls_no_major_minor').css('display', '');
                    $('.cls_major_minor').css('display', 'none');
                    $('.cls_major').css('display', 'none');
                    $('.cls_minor').css('display', 'none');
                }
                else if (obj_transcript_detail[0]["major"].toString() != '' && obj_transcript_detail[0]["minor"].toString() != '') {
                    $('.cls_no_major_minor').css('display', 'none');
                    $('.cls_major_minor').css('display', '');
                    $('.cls_major').css('display', 'none');
                    $('.cls_minor').css('display', 'none');
                }
                else if (obj_transcript_detail[0]["major"].toString() != '' && obj_transcript_detail[0]["minor"].toString() == '') {
                    $('.cls_no_major_minor').css('display', 'none');
                    $('.cls_major_minor').css('display', 'none');
                    $('.cls_major').css('display', '');
                    $('.cls_minor').css('display', 'none');
                }
                else if (obj_transcript_detail[0]["major"].toString() == '' && obj_transcript_detail[0]["minor"].toString() != '') {
                    $('.cls_no_major_minor').css('display', 'none');
                    $('.cls_major_minor').css('display', 'none');
                    $('.cls_major').css('display', 'none');
                    $('.cls_minor').css('display', '');
                }
            }
            else {
                $('.cls_no_major_minor').css('display', '');
                $('.cls_major_minor').css('display', 'none');
                $('.cls_major').css('display', 'none');
                $('.cls_minor').css('display', 'none');
            }
        }

        function setCourseDetail() {
            var aggregate_marks = 0;
            var total_GPA_marks = 0;
            var total_GPA_credits = 0;
            var total_credits = 0;
            var total_table = 5;
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
                if (to_semester < 4) $('.td_graduation_year').html('YET TO COMPLETE');

                for (var cur_table = 1; cur_table < total_table; cur_table++) {
                    //if (sem_cnt < obj_course_detail.length) {
                    if (sem_cnt < 4) {
                        if (cur_table == 1) {
                            //                            var strTableCourseDetail = "<tr><th style='width:10px;'>COURSE CODE</th><th style='width:13.46%;'>COURSE TITLE</th>" +
                            //                                            "<th style='width:10px;text-align: center;'>CRS</th><th style='width: 10px;text-align: center;'>MARKS (%)</th>" +
                            //                                           "<th style='width:10px;text-align: center;'>GRD</th>";

                            //var strTableCourseDetail = "<tr><th style='width:4.08%;'>COURSE CODE</th><th style='width:13.46%;'>COURSE TITLE</th>" +
                            //                "<th style='width:1.97%;text-align: center;'>CRS</th><th style='width: 3.25%;text-align: center;'>MARKS (%)</th>" +
                            //                "<th style='width:2.12%;text-align: center;border-top-right-radius: 4px;'>GRD</th>";

                            var strTableCourseDetail = "<tr><th style='width:3.58%;'>COURSE CODE</th><th style='width:13.46%;'>COURSE TITLE</th>" +
                                "<th style='width:1.97%;text-align: center;'>CRS</th>" + //<th style='width: 3.25%;text-align: center;'>MARKS (%)</th>" +
                                "<th style='width:1.97%;text-align: center;'>C / E</th><th style='width:2.07%;text-align: center;'>GRD POINT</th>" +
                                "<th style='width:2.12%;text-align: center;border-top-right-radius: 4px;'>GRD</th>";

                            strTableCourseDetail = strTableCourseDetail + "</tr>";

                            //for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                            for (var cur_sem = sem_cnt; cur_sem < (sem_cnt + 2); cur_sem++) {

                                if (obj_course_detail[cur_sem]['course_detail'] != '') {
                                    var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);

                                    if (cur_sem_courses[0]['semester_type'] == 'M') {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                    }
                                    else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                        //strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                        strTableCourseDetail = strTableCourseDetail + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + cur_sem_courses[0]['year_semester'].toString().substr(2, 2) + "</b></td></tr>";
                                    }

                                    for (var i = 0; i < cur_sem_courses.length; i++) {
                                        strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                            "<td style='text-align: center;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                            ""; //"<td style='text-align: center;'>" + cur_sem_courses[i]['Total'] + "</td>";

                                        if (cur_sem_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                        else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['c_type'] + "</td>";

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
                                        //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                        //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                        //}
                                        //else {
                                        //    strTableCourseDetail = strTableCourseDetail + "<td></td>";
                                        //}
                                        //Commented 08012020 End

                                        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";

                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                        } else if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";
                                        }

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade'] + "</td>";

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
                                                year_type = parseInt(year_type) + cur_table;
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
                                            strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                            strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                        }
                                        else if (sem_type == 'S') {
                                            strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                            //strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                            strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td></tr>";
                                        }
                                    }

                                    var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                                    if (cur_sem_ws_courses[0]['semester_type'] == 'W')
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=2><b>Winter School</b></td><td></td><td></td><td></td><td></td></tr>";
                                    else if (cur_sem_ws_courses[0]['semester_type'] == 'S')
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=2><b>Summer School</b></td><td></td><td></td><td></td><td></td></tr>";

                                    for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                        var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                                        strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                            "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>"; //<td style='text-align: center;'>-</td>

                                        //Commented 08012020 Start
                                        //if (cur_sem_ws_courses[i]['c_type'] == 'M') {
                                        //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //else if (cur_sem_ws_courses[i]['c_type'] == 'E' && cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //Commented 08012020 End

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                            if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                                total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            }
                                        }

                                        if (cur_sem_ws_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                        else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['c_type'] + "</td>";

                                        //strTableCourseDetail = strTableCourseDetail + "<td></td>";//<td></td> Mayur Commented 11062019 for NGPA P / NP

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == "N") {
                                            strTableCourseDetail = strTableCourseDetail + "<td></td>";
                                        } else {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade_point'] + "</td>";//02072019 Add Grade Point
                                        }

                                        //Commented 08012020 Start
                                        //if (cur_sem_ws_courses[i]['Total'] > 49 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>P</td>";// Newly Added
                                        //else if (cur_sem_ws_courses[i]['Total'] < 50 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NP</td>";// Newly Added
                                        //else if (cur_sem_ws_courses[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//P
                                        //else if (cur_sem_ws_courses[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//NP
                                        //Commented 08012020 End

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "</tr>";
                                    }

                                    if (obj_course_detail[cur_sem]['course_detail'] == '') {
                                        //strTableCourseDetail = strTableCourseDetail + "<tr><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['course_detail'] == '' && obj_course_detail[cur_sem]['ws_course_detail'] == '') {
                                    var sem_type = '';
                                    var year_type = $('#hdn_year').val();
                                    if (cur_sem % 2 == 1) {
                                        if ($('#hdn_sem').val() == 'M') {
                                            sem_type = 'S';
                                            year_type = parseInt(year_type) + cur_table;
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
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                    }
                                    else if (sem_type == 'S') {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                        //strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                        strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td></tr>";
                                    }

                                    //strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=5 rowspan=" + table_row_limit[cur_sem % 2] + ">&nbsp;</td></tr>";
                                    strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 rowspan=" + table_row_limit[cur_sem % 2] + " style='text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td></tr>";

                                    for (var i = total_course[cur_sem]; i < (table_row_limit[cur_sem % 2] - 1); i++) {
                                        strTableCourseDetail = strTableCourseDetail + "<tr></tr>";
                                    }

                                    for (var i = 0; i < 1; i++) {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>";
                                    }
                                }
                                else {
                                    for (var i = total_course[cur_sem]; i < table_row_limit[cur_sem % 2]; i++) {
                                        strTableCourseDetail = strTableCourseDetail + "<tr><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                    var ngpa_credits = parseInt(cur_sem_credit_dtl[0]['ngpa_credit'].toString()) + parseInt(cur_sem_credit_dtl[0]['sws_credit'].toString());

                                    strTableCourseDetail = strTableCourseDetail + "<tr class='cls_semester_aggregate'>" +
                                        //"<td style='' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['elective_credit'] + " E)</b></td>"; //<td></td>";
                                        "<td style='' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['gpa_credit'] + " EGPA + " + ngpa_credits + " NGPA)</b></td>"; //<td></td>";

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['total_credit'] + "</b></td>";

                                    if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['semester_marks_avg'] + "</b></td><td></td><td></td>";
                                        strTableCourseDetail = strTableCourseDetail + "<td></td><td></td>";
                                    }
                                    else {
                                        aggregate_marks += parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']);

                                        if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                                            //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                            //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                            strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>"; //<td></td>";
                                        }
                                        else {
                                            //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                            //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                            strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>";  //<td></td>";
                                        }
                                    }

                                    strTableCourseDetail = strTableCourseDetail + "<td></td></tr>";

                                    ws_course_credits += parseInt(cur_sem_credit_dtl[0]['sws_credit']);
                                }

                                if (cur_sem % 2 == 0) {
                                    strTableCourseDetail = strTableCourseDetail + "<tr><td class='cls_tr_blank' style='height: 6px;' colspan='6'></td></tr>";
                                }
                            }

                            if (total_GPA_marks != 0 && total_credits != 0) {
                                $('#td_aggre_per_marks').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                                $('#td_aggregate_avg').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
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

                            //                            $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<th style='width:10px;border-left: 2px solid black;'>COURSE CODE</th><th style='width:13.46%;'>COURSE TITLE</th>" +
                            //                                            "<th style='width:10px;text-align: center;'>CRS</th><th style='width: 10px;text-align: center;'>MARKS (%)</th>" +
                            //                                           "<th style='width:10px;text-align: center;'>GRD</th>";

                            //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<th style='width:4.08%;border-left: 2px solid black;border-top-left-radius: 4px;'>COURSE CODE</th><th style='width:13.46%;'>COURSE TITLE</th>" +
                            $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<th style='width:3.58%;border-left: 1px solid black;border-top-left-radius: 4px;'>COURSE CODE</th><th style='width:13.46%;'>COURSE TITLE</th>" +
                                "<th style='width:1.97%;text-align: center;'>CRS</th>" + //<th style='width: 3.25%;text-align: center;'>MARKS (%)</th>" +
                                "<th style='width:1.97%;text-align: center;'>C / E</th><th style='width:2.07%;text-align: center;'>GRD POINT</th>" +
                                "<th style='width:2.12%;text-align: center;border-top-right-radius: 4px;'>GRD</th>";

                            //for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                            for (var cur_sem = sem_cnt; cur_sem < (sem_cnt + 2); cur_sem++) {

                                if (obj_course_detail[cur_sem]['course_detail'] != '') {
                                    var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);

                                    if (cur_sem_courses[0]['semester_type'] == 'M') {
                                        //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td>";
                                    }
                                    else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                        //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Spring ";
                                        //strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td>";
                                        strTableCourseDetail = strTableCourseDetail + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + cur_sem_courses[0]['year_semester'].toString().substr(2, 2) + "</b></td>";
                                    }

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                    strTableCourseDetail = '';

                                    for (var i = 0; i < cur_sem_courses.length; i++) {
                                        strTableCourseDetail = strTableCourseDetail +
                                            //"<td style='text-align: center;border-left: 2px solid black;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";
                                            "<td style='text-align: center;border-left: 1px solid black;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                            ""; //"<td style='text-align: center;'>" + cur_sem_courses[i]['Total'] + "</td>";

                                        if (cur_sem_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                        else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['c_type'] + "</td>";

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
                                        //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                        //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                        //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                        //}
                                        //else {
                                        //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                        //}
                                        //Commented 08012020 End

                                        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";

                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                        } else if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";
                                        }

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade'] + "</td>";

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
                                                year_type = parseInt(year_type) + cur_table;
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
                                            //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                            strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Monsoon ";
                                            strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                        }
                                        else if (sem_type == 'S') {
                                            //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                            strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Spring ";
                                            //strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                            strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td>";
                                        }

                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                        strTableCourseDetail = '';
                                    }

                                    var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                                    if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                        //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;' colspan=2><b>Winter School</b></td><td></td><td></td><td></td><td></td><td></td>";
                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;' colspan=2><b>Winter School</b></td><td></td><td></td><td></td><td></td>";
                                    }
                                    else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                        //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;' colspan=2><b>Summer School</b></td><td></td><td></td><td></td><td></td><td></td>";
                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;' colspan=2><b>Summer School</b></td><td></td><td></td><td></td><td></td>";
                                    }

                                    for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                        var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                                        strTableCourseDetail = strTableCourseDetail +
                                            //"<td style='text-align: center;border-left: 2px solid black;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";
                                            "<td style='text-align: center;border-left: 1px solid black;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>"; //<td style='text-align: center;'>-</td>";

                                        //strTableCourseDetail = strTableCourseDetail + "<td></td><td></td>";

                                        //Commented 08012020 Start
                                        //if (cur_sem_ws_courses[i]['c_type'] == 'M') {
                                        //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //else if (cur_sem_ws_courses[i]['c_type'] == 'E' && cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                        //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        //    }
                                        //}
                                        //Commented 08012020 End

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                            if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                                total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                                total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            }
                                        }

                                        if (cur_sem_ws_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                        else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['c_type'] + "</td>";

                                        //strTableCourseDetail = strTableCourseDetail + "<td></td>";//<td></td> Mayur Commented 11062019 for NGPA P / NP

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == "N") {
                                            strTableCourseDetail = strTableCourseDetail + "<td></td>";
                                        } else {
                                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade_point'] + "</td>";//02072019 Add Grade Point
                                        }

                                        //Commented 08012020 Start
                                        //if (cur_sem_ws_courses[i]['Total'] > 49 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>P</td>";// Newly Added
                                        //else if (cur_sem_ws_courses[i]['Total'] < 50 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NP</td>";// Newly Added
                                        //else if (cur_sem_ws_courses[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//P
                                        //else if (cur_sem_ws_courses[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//NP
                                        //Commented 08012020 End

                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";

                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                        strTableCourseDetail = '';
                                    }

                                    if (obj_course_detail[cur_sem]['course_detail'] == '') {
                                        ////$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td>";
                                        //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['course_detail'] == '' && obj_course_detail[cur_sem]['ws_course_detail'] == '') {
                                    var sem_type = '';
                                    var year_type = $('#hdn_year').val();
                                    if (cur_sem % 2 == 1) {
                                        if ($('#hdn_sem').val() == 'M') {
                                            sem_type = 'S';
                                            year_type = parseInt(year_type) + cur_table;
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
                                        //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                    }
                                    else if (sem_type == 'S') {
                                        //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Spring ";
                                        //strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                        strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td>";
                                    }

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                    strTableCourseDetail = '';

                                    //$('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=5 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 2px solid black;'>&nbsp;</td>";
                                    //$('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=7 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 2px solid black;text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td>";
                                    $('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=6 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 1px solid black;text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td>";
                                    if (table_row_limit[cur_sem % 2] == 0) row_cnt++;
                                    else row_cnt += table_row_limit[cur_sem % 2];

                                    for (var i = 0; i < 1; i++) {
                                        //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td>";
                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td>";
                                    }
                                }
                                else {
                                    for (var i = total_course[cur_sem]; i < table_row_limit[cur_sem % 2]; i++) {
                                        //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td>";
                                        $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td>";
                                    }
                                }

                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                    var ngpa_credits = parseInt(cur_sem_credit_dtl[0]['ngpa_credit'].toString()) + parseInt(cur_sem_credit_dtl[0]['sws_credit'].toString());

                                    strTableCourseDetail = strTableCourseDetail +
                                        //"<td style='border-left: 2px solid black;' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['elective_credit'] + " E)</b></td>"; //<td></td>";
                                        //"<td style='border-left: 1px solid black;' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['elective_credit'] + " E)</b></td>"; //<td></td>";
                                        "<td style='border-left: 1px solid black;' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['gpa_credit'] + " EGPA + " + ngpa_credits + " NGPA)</b></td>"; //<td></td>";

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['total_credit'] + "</b></td>";

                                    if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['semester_marks_avg'] + "</b></td><td></td><td></td>";
                                        strTableCourseDetail = strTableCourseDetail + "<td></td><td></td>";
                                    }
                                    else {
                                        aggregate_marks += parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']);

                                        if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                                            //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                            //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                            strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>"; //<td></td>";
                                        }
                                        else {
                                            //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                            //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                            strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>";  //<td></td>";
                                        }
                                    }

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail + "<td></td>";
                                    strTableCourseDetail = '';

                                    ws_course_credits += parseInt(cur_sem_credit_dtl[0]['sws_credit']);
                                }

                                if (cur_sem % 2 == 0) {
                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail + "<td class='cls_tr_blank' style='height: 6px;' colspan='6'></td>";
                                }
                            }

                            if (total_GPA_marks != 0 && total_credits != 0) {
                                $('#td_aggre_per_marks').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                                $('#td_aggregate_avg').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
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

                        //var temp_cnt = 0;
                        for (var temp_cnt = 0; temp_cnt < $('#tbl_course_marks1 tr').length; temp_cnt++) {
                            $('#tbl_course_marks1 tr')[temp_cnt].innerHTML += "<td class='cls_td_blank' style='width:0.2%;border-top:0;'></td>";
                        }
                    }
                }

                $('#tbl_course_marks1 tr td:last-child').remove();

                ////////////////////////////////
                //  For 5th and 6th Semester  //
                ////////////////////////////////

                cur_table = 5;

                if (obj_course_detail[cur_sem]['course_detail'] == '' && obj_course_detail[cur_sem]['ws_course_detail'] == '') {
                    cur_sem++;
                    sem_cnt++;
                }

                if (cur_table == 5 && (obj_course_detail[cur_sem]['course_detail'] != '' || obj_course_detail[cur_sem]['ws_course_detail'] != '')) {

                    var table_length = $('#tbl_course_marks1 tr').length;
                    var strTableCourseDetail = '<tr><td class="cls_tr_blank" style="height: 6px; font-size: 11px; padding: 1px 1px 1px 3px; line-height: 16px; border-left: 0px grey; border-right: 0px grey; border-top-color: grey; border-bottom-color: grey; border-radius: 0px;" colspan="6"></td><td class="cls_td_blank" style="width: 0.2%; border-top: 0px grey; font-size: 11px; padding: 1px 1px 1px 3px; line-height: 16px; border-left: 0px grey; border-bottom: 0px grey; border-right-color: grey; border-radius: 0px;"></td><td class="cls_tr_blank" style="height: 6px; font-size: 11px; padding: 1px 1px 1px 3px; line-height: 16px; border-right: 0px grey; border-left: 0px grey; border-top-color: grey; border-bottom-color: grey; border-radius: 0px;" colspan="6"></td></tr>';

                    for (var cur_sem = sem_cnt; cur_sem < (sem_cnt + 1); cur_sem++) {

                        if (obj_course_detail[cur_sem]['course_detail'] != '') {
                            var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);

                            if (cur_sem_courses[0]['semester_type'] == 'M') {
                                strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td></tr>";
                            }
                            else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                strTableCourseDetail = strTableCourseDetail + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + cur_sem_courses[0]['year_semester'].toString().substr(2, 2) + "</b></td></tr>";
                            }

                            for (var i = 0; i < cur_sem_courses.length; i++) {
                                strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                    "<td style='text-align: center;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";

                                strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['course_credits'] + "</td>";

                                if (cur_sem_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['c_type'] + "</td>";

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
                                //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                //    }
                                //}
                                //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                //    }
                                //}
                                //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                //}
                                //else {
                                //    strTableCourseDetail = strTableCourseDetail + "<td></td>";
                                //}
                                //Commented 08012020 End

                                //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";

                                if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                } else if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";
                                }

                                strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade'] + "</td>";

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
                                        year_type = parseInt(year_type) + cur_table;
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
                                    strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                    strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                                }
                                else if (sem_type == 'S') {
                                    strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                    strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td></tr>";
                                }
                            }

                            var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                            if (cur_sem_ws_courses[0]['semester_type'] == 'W')
                                strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=2><b>Winter School</b></td><td></td><td></td><td></td><td></td></tr>";
                            else if (cur_sem_ws_courses[0]['semester_type'] == 'S')
                                strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=2><b>Summer School</b></td><td></td><td></td><td></td><td></td></tr>";

                            for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                                strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                    "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";

                                strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";

                                //strTableCourseDetail = strTableCourseDetail + "<td></td><td></td>";

                                //Commented 08012020 Start
                                //if (cur_sem_ws_courses[i]['c_type'] == 'M') {
                                //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                //    }
                                //}
                                //else if (cur_sem_ws_courses[i]['c_type'] == 'E' && cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                //    }
                                //}
                                //Commented 08012020 Start

                                if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                    }
                                }

                                if (cur_sem_ws_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['c_type'] + "</td>";

                                //strTableCourseDetail = strTableCourseDetail + "<td></td>";//<td></td> Mayur Commented 11062019 for NGPA P / NP

                                if (cur_sem_ws_courses[i]['gpa_nongpa'] == "N") {
                                    strTableCourseDetail = strTableCourseDetail + "<td></td>";
                                } else {
                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade_point'] + "</td>";//02072019 Add Grade Point
                                }

                                //Commented 08012020 Start
                                //if (cur_sem_ws_courses[i]['Total'] > 49 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>P</td>";// Newly Added
                                //else if (cur_sem_ws_courses[i]['Total'] < 50 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NP</td>";// Newly Added
                                //else if (cur_sem_ws_courses[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//P
                                //else if (cur_sem_ws_courses[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//NP
                                //Commented 08012020 End

                                strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";

                                strTableCourseDetail = strTableCourseDetail + "</tr>";
                            }
                        }

                        if (obj_course_detail[cur_sem]['course_detail'] == '' && obj_course_detail[cur_sem]['ws_course_detail'] == '') {
                            var sem_type = '';
                            var year_type = $('#hdn_year').val();
                            if (cur_sem % 2 == 1) {
                                if ($('#hdn_sem').val() == 'M') {
                                    sem_type = 'S';
                                    year_type = parseInt(year_type) + cur_table;
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
                                strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Monsoon ";
                                strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td></tr>";
                            }
                            else if (sem_type == 'S') {
                                strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 style='border-left:1px solid black;text-align: center;'><b>Spring ";
                                strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td></tr>";
                            }

                            strTableCourseDetail = strTableCourseDetail + "<tr><td colspan=6 rowspan=" + table_row_limit[cur_sem % 2] + " style='text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td></tr>";
                        }

                        if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                            var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                            var ngpa_credits = parseInt(cur_sem_credit_dtl[0]['ngpa_credit'].toString()) + parseInt(cur_sem_credit_dtl[0]['sws_credit'].toString());

                            strTableCourseDetail = strTableCourseDetail + "<tr class='cls_semester_aggregate'>" +
                                "<td style='' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['gpa_credit'] + " EGPA + " + ngpa_credits + " NGPA)</b></td>";

                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['total_credit'] + "</b></td>";

                            if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                strTableCourseDetail = strTableCourseDetail + "<td></td><td></td>";
                            }
                            else {
                                aggregate_marks += parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']);

                                if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                                    //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";
                                    strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>";
                                }
                                else {
                                    //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";
                                    strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>";
                                }
                            }

                            strTableCourseDetail = strTableCourseDetail + "<td></td></tr>";

                            ws_course_credits += parseInt(cur_sem_credit_dtl[0]['sws_credit']);
                        }
                    }

                    if (total_GPA_marks != 0 && total_credits != 0) {
                        $('#td_aggre_per_marks').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                        $('#td_aggregate_avg').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                    }

                    if (total_GPA_credits != 0 && total_credits != 0) {
                        $('#td_grade_point_avg').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                        $('#td_aggregate_gpa').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                    }

                    $('#tbl_course_marks1 tbody').html($('#tbl_course_marks1 tbody').html() + strTableCourseDetail);

                    //////////////////////////////////////////////////////////////////////////////////////////////////
                    //Remaining
                    if (cur_sem < 6 && (obj_course_detail[cur_sem]['course_detail'] != '' || obj_course_detail[cur_sem]['ws_course_detail'] != '')) {
                        //cur_sem++;
                        sem_cnt++;
                        row_cnt++;
                        strTableCourseDetail = '';

                        for (var temp_cnt = table_length + 1; temp_cnt < $('#tbl_course_marks1 tr').length; temp_cnt++) {
                            $('#tbl_course_marks1 tr')[temp_cnt].innerHTML += "<td class='cls_td_blank' style='width:0.2%;border-top:0;'></td>";
                        }

                        //for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                        for (var cur_sem = sem_cnt; cur_sem < (sem_cnt + 1); cur_sem++) {

                            if (obj_course_detail[cur_sem]['course_detail'] != '') {
                                var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);

                                if (cur_sem_courses[0]['semester_type'] == 'M') {
                                    //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                    strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Monsoon ";
                                    strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td>";
                                }
                                else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                    //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                    strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Spring ";
                                    //strTableCourseDetail = strTableCourseDetail + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</b></td>";
                                    strTableCourseDetail = strTableCourseDetail + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + cur_sem_courses[0]['year_semester'].toString().substr(2, 2) + "</b></td>";
                                }

                                $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                strTableCourseDetail = '';

                                for (var i = 0; i < cur_sem_courses.length; i++) {
                                    strTableCourseDetail = strTableCourseDetail +
                                        //"<td style='text-align: center;border-left: 2px solid black;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";
                                        "<td style='text-align: center;border-left: 1px solid black;'>" + cur_sem_courses[i]['course_code'] + "</td><td>" + cur_sem_courses[i]['course_name'] + "</td>";

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                        ""; //"<td style='text-align: center;'>" + cur_sem_courses[i]['Total'] + "</td>";

                                    if (cur_sem_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                    else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['c_type'] + "</td>";

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
                                    //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                    //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                    //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                    //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                    //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                    //    }
                                    //}
                                    //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                    //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                    //    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                    //        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                    //        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                    //        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                    //    }
                                    //}
                                    //else if (cur_sem_courses[i]['c_type'] == 'E' && cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                    //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>E</td>";
                                    //}
                                    //else {
                                    //    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                    //}
                                    //Commented 08012020 End

                                    //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";

                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                                    } else if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade_point'] + "</td>";
                                    }

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_courses[i]['grade'] + "</td>";

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
                                            year_type = parseInt(year_type) + cur_table;
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
                                        //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Monsoon ";
                                        strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                    }
                                    else if (sem_type == 'S') {
                                        //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                        strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Spring ";
                                        //strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                        strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td>";
                                    }

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                    strTableCourseDetail = '';
                                }

                                var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                                if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                    //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;' colspan=2><b>Winter School</b></td><td></td><td></td><td></td><td></td><td></td>";
                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;' colspan=2><b>Winter School</b></td><td></td><td></td><td></td><td></td>";
                                }
                                else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                    //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;' colspan=2><b>Summer School</b></td><td></td><td></td><td></td><td></td><td></td>";
                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;' colspan=2><b>Summer School</b></td><td></td><td></td><td></td><td></td>";
                                }

                                for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                    var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                                    strTableCourseDetail = strTableCourseDetail +
                                        //"<td style='text-align: center;border-left: 2px solid black;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";
                                        "<td style='text-align: center;border-left: 1px solid black;'>" + cur_sem_ws_courses[i]['course_code'] + "</td><td>" + str_course_name + "</td>";

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>"; //<td style='text-align: center;'>-</td>";

                                    //strTableCourseDetail = strTableCourseDetail + "<td></td><td></td>";

                                    //Commented 08012020 Start
                                    //if (cur_sem_ws_courses[i]['c_type'] == 'M') {
                                    //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                    //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                    //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                    //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                    //    }
                                    //}
                                    //else if (cur_sem_ws_courses[i]['c_type'] == 'E' && cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                    //    if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                    //        total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                    //        total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                    //        total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                    //    }
                                    //}
                                    //Commented 08012020 End

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    if (cur_sem_ws_courses[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                                    else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['c_type'] + "</td>";

                                    //strTableCourseDetail = strTableCourseDetail + "<td></td>";//<td></td> Mayur Commented 11062019 for NGPA P / NP

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == "N") {
                                        strTableCourseDetail = strTableCourseDetail + "<td></td>";
                                    } else {
                                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade_point'] + "</td>";//02072019 Add Grade Point
                                    }

                                    //Commented 08012020 Start
                                    //if (cur_sem_ws_courses[i]['Total'] > 49 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>P</td>";// Newly Added
                                    //else if (cur_sem_ws_courses[i]['Total'] < 50 && cur_sem_ws_courses[i]['gpa_nongpa'] == "N") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NP</td>";// Newly Added
                                    //else if (cur_sem_ws_courses[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//P
                                    //else if (cur_sem_ws_courses[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";//NP
                                    //Commented 08012020 End

                                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + cur_sem_ws_courses[i]['grade'] + "</td>";

                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                    strTableCourseDetail = '';
                                }

                                if (obj_course_detail[cur_sem]['course_detail'] == '') {
                                    //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td>";
                                    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td>";
                                }
                            }

                            if (obj_course_detail[cur_sem]['course_detail'] == '' && obj_course_detail[cur_sem]['ws_course_detail'] == '') {
                                var sem_type = '';
                                var year_type = $('#hdn_year').val();
                                if (cur_sem % 2 == 1) {
                                    if ($('#hdn_sem').val() == 'M') {
                                        sem_type = 'S';
                                        year_type = parseInt(year_type) + cur_table;
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
                                    //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Monsoon ";
                                    strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Monsoon ";
                                    strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                }
                                else if (sem_type == 'S') {
                                    //strTableCourseDetail = strTableCourseDetail + "<td colspan=7 style='border-left:1px solid black;border-left: 2px solid black;text-align: center;'><b>Spring ";
                                    strTableCourseDetail = strTableCourseDetail + "<td colspan=6 style='border-left:1px solid black;border-left: 1px solid black;text-align: center;'><b>Spring ";
                                    //strTableCourseDetail = strTableCourseDetail + year_type + "-" + (parseInt(year_type) + 1).toString().substr(2, 2) + "</b></td>";
                                    strTableCourseDetail = strTableCourseDetail + (parseInt(year_type) - 1) + "-" + year_type.toString().substr(2, 2) + "</b></td>";
                                }

                                $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail;
                                strTableCourseDetail = '';

                                //$('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=5 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 2px solid black;'>&nbsp;</td>";
                                //$('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=7 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 2px solid black;text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td>";
                                $('#tbl_course_marks1 tr')[row_cnt].innerHTML += "<td colspan=6 rowspan=" + table_row_limit[cur_sem % 2] + " style='border-left: 1px solid black;text-align: center;'><img style='object-fit: cover;margin-top: 15px;' src='../../image/yet-to-complete.png'></td>";
                                if (table_row_limit[cur_sem % 2] == 0) row_cnt++;
                                else row_cnt += table_row_limit[cur_sem % 2];

                                //for (var i = 0; i < 1; i++) {
                                //    //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td>";
                                //    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td>";
                                //}
                            }
                            else {
                                //for (var i = total_course[cur_sem]; i < table_row_limit[cur_sem % 2]; i++) {
                                //    //$('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 2px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td><td></td>";
                                //    $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += "<td style='border-left: 1px solid black;'>&nbsp;</td><td></td><td></td><td></td><td></td><td></td>";
                                //}
                            }

                            if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                var ngpa_credits = parseInt(cur_sem_credit_dtl[0]['ngpa_credit'].toString()) + parseInt(cur_sem_credit_dtl[0]['sws_credit'].toString());

                                strTableCourseDetail = strTableCourseDetail +
                                    //"<td style='border-left: 2px solid black;' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['elective_credit'] + " E)</b></td>"; //<td></td>";
                                    //"<td style='border-left: 1px solid black;' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['elective_credit'] + " E)</b></td>"; //<td></td>";
                                    "<td style='border-left: 1px solid black;' colspan=2><b>SEMESTER AGGREGATE (" + cur_sem_credit_dtl[0]['core_credit'] + " C + " + cur_sem_credit_dtl[0]['gpa_credit'] + " EGPA + " + ngpa_credits + " NGPA)</b></td>"; //<td></td>";

                                strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['total_credit'] + "</b></td>";

                                if (cur_sem_credit_dtl[0]['semester_marks_avg'].toString() == '-') {
                                    //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + cur_sem_credit_dtl[0]['semester_marks_avg'] + "</b></td><td></td><td></td>";
                                    strTableCourseDetail = strTableCourseDetail + "<td></td><td></td>";
                                }
                                else {
                                    aggregate_marks += parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']);

                                    if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                                        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                        //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>"; //<td></td>";
                                        strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>"; //<td></td>";
                                    }
                                    else {
                                        //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['semester_marks_avg']).toFixed(1) + "</b></td><td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                        //strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + parseFloat(cur_sem_credit_dtl[0]['grade_point_avg']).toFixed(1) + "</b></td>";  //<td></td>";
                                        strTableCourseDetail = strTableCourseDetail + "<td></td><td style='text-align: center;'><b>" + round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1) + "</b></td>";  //<td></td>";
                                    }
                                }

                                $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail + "<td></td>";
                                strTableCourseDetail = '';

                                ws_course_credits += parseInt(cur_sem_credit_dtl[0]['sws_credit']);
                            }

                            if (cur_sem % 2 == 0) {
                                $('#tbl_course_marks1 tr')[row_cnt++].innerHTML += strTableCourseDetail + "<td class='cls_tr_blank' style='height: 6px;' colspan='6'></td>";
                            }
                        }

                        if (total_GPA_marks != 0 && total_credits != 0) {
                            $('#td_aggre_per_marks').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                            $('#td_aggregate_avg').html(parseFloat(total_GPA_marks / total_credits).toFixed(1));
                        }

                        if (total_GPA_credits != 0 && total_credits != 0) {
                            $('#td_grade_point_avg').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                            $('#td_aggregate_gpa').html(parseFloat(total_GPA_credits / total_credits).toFixed(1));
                        }
                    }
                }

                $('#tbl_course_marks1 tr th').css('font-size', '14px');
                $('#tbl_course_marks1 tr td').css('font-size', '14px');
                $('#tbl_course_marks1 tr th').css('padding-top', '1px');
                $('#tbl_course_marks1 tr th').css('padding-bottom', '1px');
                $('#tbl_course_marks1 tr td').css('padding-top', '0px');
                $('#tbl_course_marks1 tr td').css('padding-bottom', '2px');
                $('#tbl_course_marks1 th,#tbl_course_marks1 td,#tbl_dissertation td').css('font-size', '11px');
                $('#tbl_course_marks1 th,#tbl_course_marks1 td,#tbl_dissertation td').css('padding', '1px 1px 1px 3px');
                $('#tbl_course_marks1 th,#tbl_course_marks1 td,#tbl_dissertation td').css('line-height', '16px');
                //$('#tbl_course_marks1 tr th').css('border-top', '2px solid black');
                $('#tbl_course_marks1 tr th').css('border-top', '1px solid black');
                //$('#tbl_course_marks1 .cls_semester_aggregate td').css('border-bottom', '1px solid black');
                $('#tbl_dissertation').css('border-left', '0px solid black');

                $('#tbl_student_detail tr td').css('line-height', '13px');
                $('#tbl_student_detail').css('margin-bottom', '10px');

                if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                    //strTableCourseDetail = "<tr><td colspan=2 style='font-size: 12px;line-height: 10px;'>MINIMUM PASSING REQUIREMENT: 50% IN EACH SUBJECT</td><td colspan=2 style='font-size: 12px;line-height: 10px;'>C=CORE, E= ELECTIVE</td><td colspan=4 style='font-size: 10px;line-height: 10px;padding-left: 4px;padding-right: 2px;border-right: 1px solid black;'>'ALL SUBJECTS CARRY MAXIMUM 100 MARKS EACH'</td></tr>";
                    //$('#tbl_course_marks1').append(strTableCourseDetail);

                    if (obj_stud_detail[0]['dept_name'].toUpperCase() == 'PLANNING' && obj_stud_detail[0]['prog_name'].toUpperCase() == 'PG') {
                        var str_degree = 'MASTER OF PLANNING';

                        if (obj_transcript_detail[0]['name_of_the_degree'] != '') str_degree = obj_transcript_detail[0]['name_of_the_degree'].toUpperCase();

                        if (obj_transcript_detail[0]['specialization'] != '') str_degree += ' (' + obj_transcript_detail[0]['specialization'] + ')';

                        $('.td_program').html(str_degree.toUpperCase());
                    }
                    else if (obj_transcript_detail[0]['name_of_the_degree'] != '') $('.td_program').html(obj_transcript_detail[0]['name_of_the_degree'].toUpperCase());

                    if (obj_transcript_detail[0]['graduation_year'] != '') $('.td_graduation_year').html(obj_transcript_detail[0]['graduation_year'].toUpperCase());
                }

                //check whether it is correct or not? 08 01 2020 - 2
                var total_core_credit = 0;
                var total_elective_credit = 0;
                var total_ngpa_credit = 0;
                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                    var obj_course_credit = [];

                    if (obj_course_detail[cur_sem]['credit_detail'] != "") {
                        obj_course_credit = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                        total_core_credit += parseInt(obj_course_credit[0]['core_credit']);
                        //total_elective_credit += parseInt(obj_course_credit[0]['elective_credit']);
                        total_elective_credit += parseInt(obj_course_credit[0]['gpa_credit']);
                        total_ngpa_credit += parseInt(obj_course_credit[0]['ngpa_credit']);
                    }
                }

                $('#td_core').html(total_core_credit);
                $('#td_elective').html(total_elective_credit);
                $('#td_non_gpa').html(total_ngpa_credit);
                $('#td_ws_credit').html(ws_course_credits);
                $('#td_total').html(total_core_credit + total_elective_credit + total_ngpa_credit + ws_course_credits);

                //$('#tbl_course_marks1 tr td:last-child').remove();
                $('#tbl_course_marks1 tr:last-child td').css('border-bottom', '1px solid grey');
                $('#tbl_course_marks1 tr th:last-child').css('border-right', '1px solid grey');
                $('#tbl_course_marks1 tr td:last-child').css('border-right', '1px solid grey');
                $('.cls_tr_blank').css('border-left', '0');
                $('.cls_tr_blank').css('border-right', '0');
                $('.cls_tr_blank').next().css('border-left', '0');
                $('.cls_td_blank').css('border-bottom', '0');
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
                else if (obj_stud_detail[0]["year_code"] >= 'Y2018') {// Start Mayur 18 11 2019
                    $('#div_grade_range_Y2018_onward').css('display', 'block');//uncomment 06082019
                    $('#div_grade_range_Y2018_onward').css('font-size', '11px');
                    $('#div_grade_range_Y2018_onward tr th').css('line-height', '5px');
                    $('#div_grade_range_Y2018_onward tr th').css('font-size', '10px');
                    $('#div_grade_range_Y2018_onward tr td').css('line-height', '5px');
                    $('#div_grade_range_Y2018_onward tr td').css('font-size', '10px');
                    $('#div_grade_range_Y2018_onward tr td').css('text-align', 'center');
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

    <%--<div style="top: 20px; width: 99%;height: 96px; left: 1px;position:absolute;" title="" id="i22byht1" align="right">
        <a style="width: 297px; height: 96px; cursor: pointer;float:right;" href="../Master/Home.aspx" id="i22byht1link">
            <div id="i22byht1img" style="width: 297px; height: 96px; position: relative;">
                <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage"></div>
        </a>
    </div>--%>

    <div>
        <%--<div style="margin-top: 20px;margin-bottom: 10px;margin-left: 5px;font-size: large;"><b>OFFICIAL TRANSCRIPT</b></div>--%>
        <div style="margin-top: 20px; margin-bottom: 10px; margin-left: 5px; font-size: large;"><b>&nbsp;</b></div>

        <table id="tbl_student_detail" class="table table-condensed" style="width: 1100px;">
            <tr>
                <%--<td style="border:none;padding:0;width:260px;"></td>
                <td style="border:none;padding:0;width:10px;"></td>
                <td style="border:none;padding:0;width:300px;"></td>
                <td style="border:none;padding:0;width:195px;"></td>
                <td style="border:none;padding:0;width:10px;"></td>
                <td style="border:none;padding:0;width:620px;"></td>--%>

                <td style="border: none; padding: 0; width: 48%;"></td>
                <td style="border: none; padding: 0; width: 50%;"></td>
            </tr>

            <tr class="">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_name"></div>
                    <div class="spn_student_detail_title">Name of the Student</div>
                </td>
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_program"></div>
                    <div class="spn_student_detail_title">Name of the Degree</div>
                </td>
            </tr>
            <tr class="">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_rollno"></div>
                    <div class="spn_student_detail_title">Student Code</div>
                </td>
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_medium_of_instruction">ENGLISH</div>
                    <div class="spn_student_detail_title">Medium of Instruction</div>
                </td>
            </tr>

            <%--=======================================================================================================================--%>

            <tr class="cls_major_minor">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_dob"></div>
                    <div class="spn_student_detail_title">Date of Birth</div>
                </td>
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_major"></div>
                    <div class="spn_student_detail_title">Major</div>
                </td>
            </tr>
            <tr class="cls_major_minor">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_graduation_year"></div>
                    <div class="spn_student_detail_title">Date of Graduation</div>
                </td>
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_minor"></div>
                    <div class="spn_student_detail_title">Minor</div>
                </td>
            </tr>

            <%--=======================================================================================================================--%>

            <tr class="cls_no_major_minor">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_dob"></div>
                    <div class="spn_student_detail_title">Date of Birth</div>
                </td>
            </tr>
            <tr class="cls_no_major_minor">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_graduation_year"></div>
                    <div class="spn_student_detail_title">Date of Graduation</div>
                </td>
            </tr>

            <%--=======================================================================================================================--%>

            <tr class="cls_major">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_dob"></div>
                    <div class="spn_student_detail_title">Date of Birth</div>
                </td>
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_major"></div>
                    <div class="spn_student_detail_title">Major</div>
                </td>
            </tr>
            <tr class="cls_major">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_graduation_year"></div>
                    <div class="spn_student_detail_title">Date of Graduation</div>
                </td>
            </tr>

            <%--=======================================================================================================================--%>

            <tr class="cls_minor">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_dob"></div>
                    <div class="spn_student_detail_title">Date of Birth</div>
                </td>
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_minor"></div>
                    <div class="spn_student_detail_title">Minor</div>
                </td>
            </tr>
            <tr class="cls_minor">
                <td class="cls_td_student_detail" style="border: none;">
                    <div class="td_graduation_year"></div>
                    <div class="spn_student_detail_title">Date of Graduation</div>
                </td>
            </tr>

            <%--=======================================================================================================================--%>

            <%--<tr class="cls_no_major_minor">
                <td style="border:none;"><b>NAME OF THE STUDENT</b></td>
                <td style="border:none;"> : </td>
                <td class="td_name" style="border:none;"></td>

                <td style="border:none;"><b>NAME OF THE DEGREE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_program" style="border:none;"></td>
            </tr>
            <tr class="cls_no_major_minor">
                <td style="border:none;"><b>STUDENT CODE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_rollno" style="border:none;"></td>
                
                <td style="border:none;"><b>MEDIUM OF INSTRUCTION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_medium_of_instruction" style="border:none;">ENGLISH</td>
            </tr>
            <tr class="cls_no_major_minor">
                <td style="border:none;"><b>DATE OF BIRTH</b></td>
                <td style="border:none;"> : </td>
                <td class="td_dob" style="border:none;"></td>
            </tr>
            <tr class="cls_no_major_minor">
                <td style="border:none;"><b>MONTH AND YEAR OF GRADUATION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_graduation_year" style="border:none;">MAY 2015</td>
            </tr>--%>

            <%--=======================================================================================================================--%>

            <%--<tr class="cls_major_minor">
                <td style="border:none;"><b>NAME OF THE STUDENT</b></td>
                <td style="border:none;"> : </td>
                <td class="td_name" style="border:none;"></td>

                <td style="border:none;"><b>NAME OF THE DEGREE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_program" style="border:none;"></td>
            </tr>
            <tr class="cls_major_minor">
                <td style="border:none;"><b>STUDENT CODE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_rollno" style="border:none;"></td>
                
                <td style="border:none;"><b>MAJOR</b></td>
                <td style="border:none;"> : </td>
                <td class="td_major" style="border:none;"></td>
            </tr>
            <tr class="cls_major_minor">
                <td style="border:none;"><b>DATE OF BIRTH</b></td>
                <td style="border:none;"> : </td>
                <td class="td_dob" style="border:none;"></td>
                
                <td style="border:none;"><b>MINOR</b></td>
                <td style="border:none;"> : </td>
                <td class="td_minor" style="border:none;"></td>
            </tr>
            <tr class="cls_major_minor">
                <td style="border:none;"><b>MONTH AND YEAR OF GRADUATION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_graduation_year" style="border:none;">MAY 2015</td>
                
                <td style="border:none;"><b>MEDIUM OF INSTRUCTION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_medium_of_instruction" style="border:none;">ENGLISH</td>
            </tr>--%>

            <%--=======================================================================================================================--%>

            <%--<tr class="cls_major">
                <td style="border:none;"><b>NAME OF THE STUDENT</b></td>
                <td style="border:none;"> : </td>
                <td class="td_name" style="border:none;"></td>

                <td style="border:none;"><b>NAME OF THE DEGREE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_program" style="border:none;"></td>
            </tr>
            <tr class="cls_major">
                <td style="border:none;"><b>STUDENT CODE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_rollno" style="border:none;"></td>
                
                <td style="border:none;"><b>MAJOR</b></td>
                <td style="border:none;"> : </td>
                <td class="td_major" style="border:none;"></td>
            </tr>
            <tr class="cls_major">
                <td style="border:none;"><b>DATE OF BIRTH</b></td>
                <td style="border:none;"> : </td>
                <td class="td_dob" style="border:none;"></td>
                
                <td style="border:none;"><b>MEDIUM OF INSTRUCTION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_medium_of_instruction" style="border:none;">ENGLISH</td>
            </tr>
            <tr class="cls_major">
                <td style="border:none;"><b>MONTH AND YEAR OF GRADUATION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_graduation_year" style="border:none;">MAY 2015</td>
            </tr>--%>

            <%--=======================================================================================================================--%>

            <%--<tr class="cls_minor">
                <td style="border:none;"><b>NAME OF THE STUDENT</b></td>
                <td style="border:none;"> : </td>
                <td class="td_name" style="border:none;"></td>

                <td style="border:none;"><b>NAME OF THE DEGREE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_program" style="border:none;"></td>
            </tr>
            <tr class="cls_minor">
                <td style="border:none;"><b>STUDENT CODE</b></td>
                <td style="border:none;"> : </td>
                <td class="td_rollno" style="border:none;"></td>
                
                <td style="border:none;"><b>MINOR</b></td>
                <td style="border:none;"> : </td>
                <td class="td_minor" style="border:none;"></td>
            </tr>
            <tr class="cls_minor">
                <td style="border:none;"><b>DATE OF BIRTH</b></td>
                <td style="border:none;"> : </td>
                <td class="td_dob" style="border:none;"></td>
                
                <td style="border:none;"><b>MEDIUM OF INSTRUCTION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_medium_of_instruction" style="border:none;">ENGLISH</td>
            </tr>
            <tr class="cls_minor">
                <td style="border:none;"><b>MONTH AND YEAR OF GRADUATION</b></td>
                <td style="border:none;"> : </td>
                <td class="td_graduation_year" style="border:none;">MAY 2015</td>
            </tr>--%>
        </table>
    </div>

    <%--<div style="min-height: 676px;">--%>
    <div style="min-height: 635px;">

        <table id="tbl_course_marks1" class="table table-bordered" style="margin-bottom: 0px; border-top: 0px solid black; border-bottom: 0; border-right: 0; width: 100%; float: left;">
        </table>

        <table id="tbl_course_marks2" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

        <table id="tbl_course_marks3" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

        <table id="tbl_course_marks4" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

        <table id="tbl_course_marks5" class="table table-bordered" style="margin-bottom: 0px; border-right: 1px solid black; width: 20%; float: left; margin-left: 0px; display: none;">
        </table>

        <table id="tbl_dissertation" class="table table-bordered" style="margin-bottom: 0px; border-top: 0px solid black; border-left: 1px solid black; border-right: 1px solid black; border-bottom: 1px solid black; width: 100%; float: left; margin-top: 10px; border-top: 1px solid black; display: none;">
            <tbody></tbody>
        </table>
    </div>

    <div style="float: left; width: 60%;">
        <div id="div_ug_note" style="margin-top: -11px; font-size: 8px; line-height: 10px;">
            <b>Note : </b>1. Related Study Program (RSP) not taken into account for AGG.AVG. 
            2. Summer / Winter Training (ST / WT) not taken into account for AGG.AVG. 
            3. Interative Studio (IS) not taken into account for AGG.AVG.
            <br />
            4. Office Training (OT) not taken into account for AGG.AVG. 
            5. NGPA : NON GPA
        </div>

        <div id="div_grade_range" style="display: none; padding-top: 1px;">
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

        <div id="div_grade_range_2014_onward" style="display: none; padding-top: 1px;">
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

        <div id="div_grade_range_Y2018_onward" style="display: none; padding-top: 1px;">
            <table class="table table-bordered table-condensed" style="width: 40% !important">
                <tr>
                    <th>Grade
                    </th>
                    <td>O
                    </td>
                    <td>A
                    </td>
                    <td>B
                    </td>
                    <td>C
                    </td>
                    <td>F
                    </td>
                </tr>
                <tr>
                    <th>Grade Point
                    </th>
                    <td>5
                    </td>
                    <td>4
                    </td>
                    <td>3
                    </td>
                    <td>2
                    </td>
                    <td>0
                    </td>
                </tr>
                <tr>
                    <th>Mark Range
                    </th>
                    <td>90-100
                    </td>
                    <td>80-89
                    </td>
                    <td>65-79
                    </td>
                    <td>55-64
                    </td>
                    <td>0-54
                    </td>
                </tr>
            </table>
        </div>

        <div id="div_note" style="margin-top: -15px; clear: both;">
            <b>* All grades are as per relative grading policy. <%--Please refer &nbsp;<a href="https://goo.gl/m29t1k">goo.gl/m29t1k</a>&nbsp; for details.--%></b>
        </div>

        <div style="display: none;">
            <div id="div_blank" style="height: 80px;"></div>
            <div style="float: left; margin-bottom: 5px; width: 330px;"><b>ISSUE DATE : </b><span class="spn_issue_date"></span></div>
            <div style="float: left; font-weight: bold; margin-bottom: 5px;">PROGRAM CHAIR</div>
            <div style="float: right; font-weight: bold; margin-bottom: 5px; width: 100px;">DEAN</div>
        </div>
    </div>

    <div style="float: right; width: 38%; margin-top: -15px; font-size: 12px;">
        <b>AGGREGATE AVERAGE (SEMESTER 1 TO <span id="spn_to_semester"></span>)</b>
        <table id="tbl_aggregate_avg" style="margin-top: 5px; width: 100%;">
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
                <%--<td style="text-align: right;"><b>CUMULATIVE AGGREGATE AVG</b></td>
                <td style="width:10%;"><b id="td_aggregate_avg"></b></td>--%>
            </tr>
            <tr>
                <td>Summer Winter School</td>
                <%--<td id="td1">15</td>--%>
                <td id="td_ws_credit"></td>
                <td>&nbsp;</td>
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

        <div style="display: none; font-size: 14px;">
            <div style="height: 69px;"></div>
            <div>
                <div style="width: 47%; float: left; text-align: right;"><b>NO : </b></div>
                <div style="margin-bottom: 5px; width: 53%; float: left; text-align: right;"><span class="spn_transcript_no"></span></div>
            </div>
        </div>
    </div>

    <div style="clear: both; margin-top: 155px; margin-bottom: 7px;">
        <table style="font-size: 14px; width: 100%;">
            <tr>
                <td style="width: 19%;"><b>ISSUE DATE : </b><span class="spn_issue_date"></span></td>
                <td style="width: 35%; text-align: center;"><b>PROGRAM CHAIR</b></td>
                <td style="width: 25%; text-align: center;"><b>DEAN</b></td>
                <td style="width: 20%; text-align: right;"><b>NO : </b><span class="spn_transcript_no"></span></td>
            </tr>
        </table>
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
