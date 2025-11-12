<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GradeReportPDF2.aspx.cs"
    Inherits="Admin_Report_GradeReportPDF2" %>

<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <script type="text/javascript">
        var obj_stud_detail;
        var obj_course_detail;
        var obj_ws_course_detail;
        var obj_credit_detail;

        $(document).ready(function () {
            var fnd_prog = "N";
            var year = parseInt($('#hdn_year').val());
            var sem = $('#hdn_sem').val();
            window.found_flag = "N";

            if ($("#hdn_stud_detail").val() != '') {
                obj_stud_detail = JSON.parse($("#hdn_stud_detail").val());
            }
            if ($("#hdn_course_detail").val() != '') {
                obj_course_detail = JSON.parse($("#hdn_course_detail").val());
            }
            if ($("#hdn_ws_course_detail").val() != '') {
                obj_ws_course_detail = JSON.parse($("#hdn_ws_course_detail").val());
            }
            if ($("#hdn_credit_detail").val() != '') {
                obj_credit_detail = JSON.parse($("#hdn_credit_detail").val());
            }
            if ($("#hdn_course_detail").val() != '') {
                for (var k = 0; k < obj_course_detail.length; k++) {
                    if (obj_course_detail[k]["course_code"] == "CFP001" || obj_course_detail[k]["course_code"] == "CFP002" || obj_course_detail[k]["course_code"] == "CFP003" || obj_course_detail[k]["course_code"] == "CFP004" || obj_course_detail[k]["course_code"] == "CFP005" || obj_course_detail[k]["course_code"] == "CFP006" || obj_course_detail[k]["course_code"] == "CFP007"
                        || obj_course_detail[k]["course_code"] == "CFP008" || obj_course_detail[k]["course_code"] == "CFP009" || obj_course_detail[k]["course_code"] == "CFP010") {

                        if (year >= 2024) {// This Changes By Nitinbhai 23012025
                            fnd_prog = "N";
                        }
                        else {
                            fnd_prog = "Y";
                        }

                        
                    }
                }
            }
            // for Spring 2018 and before
            if (fnd_prog == "Y")//if foundation program then only execute this
            {
                if (year <= 2018)//2018 and below then it goes if statement
                {
                    if (sem == "S" || year < 2018 && sem == "M")//for spring 18 and before it old logic should works
                    {
                        setStudentDetail();
                        setCourseDetail();
                        window.found_flag = "N";
                    }
                    else//new logic
                    {
                        setStudentFoundationDetail();
                        setCourseFoundationDetail();
                        window.found_flag = "Y";
                    }
                }
                else//new logic
                {
                    setStudentFoundationDetail();
                    setCourseFoundationDetail();
                    window.found_flag = "Y";
                }
            }
            else//old logic
            {
                setStudentDetail();
                setCourseDetail();
                window.found_flag = "N";
            }

            //setStudentDetail();
            //setCourseDetail();
            set_WS_CourseDetail();
            setCreditDetail();
            display_Grade_Range();

            if (window.found_flag == "Y") {
                $('.cls_found_hide').css('display', 'none');
                $('.cls_found_show').css('display', '');
            } else {
                $('.cls_found_show').css('display', 'none');
                $('.cls_found_hide').css('display', '');
            }

        });

        function setStudentFoundationDetail() {

            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var output = (day < 10 ? '0' : '') + day + '/' +
                (month < 10 ? '0' : '') + month + '/' +
                d.getFullYear();

            $('#td_found_doi').html(output);

            if (obj_stud_detail != null && obj_stud_detail != undefined) 
            {
                var str_program = '';

                var str_program_new = obj_stud_detail[0]['prog_level_name'];//27/08/2019

                var stud_year_code = obj_stud_detail[0]["year_code"];
                if (obj_stud_detail[0]["year_code"] == 'Y1') stud_year_code = 'Y2013';

                //Start : No Longer Used from 27/08/2019
                if (obj_stud_detail[0]["prog_desc"] == 'Landscape Architecture') {
                    str_program = 'MASTERS PROGRAM IN LANDSCAPE ARCHITECTURE';
                }
                else if (obj_stud_detail[0]["prog_desc"] == 'Landscape Design') {
                    str_program = 'MASTERS PROGRAM IN LANSCAPE DESIGN';
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
                    str_program = 'MASTER OF URBAN AND REGIONAL PLANNING';
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

                if (obj_stud_detail[0]["name_of_the_degree"] != '') {
                    str_program = obj_stud_detail[0]["name_of_the_degree"];
                }
                //End : No Longer Used from 27/08/2019

                if (obj_stud_detail[0]["dob"] == "") {

                } else {
                    var dd = new Date(obj_stud_detail[0]["dob"]);
                    var monthh = dd.getMonth() + 1;
                    var dayy = dd.getDate();
                    var dob = (dayy < 10 ? '0' : '') + dayy + '/' +
                        (monthh < 10 ? '0' : '') + monthh + '/' +
                        dd.getFullYear();

                    $('#td_found_dob').html(dob.toUpperCase());
                }

                //$('#td_found_degree').html(str_program.toUpperCase());

                //$('#td_found_degree').html(str_program_new.toUpperCase());//27/08/2019
                
                $('#td_found_program').html(str_program_new.toUpperCase());//27/08/2019

                $('#td_found_stud_name').html((obj_stud_detail[0]["full_name"]).toUpperCase());

                $('#td_found_stud_code').html(obj_stud_detail[0]["user_id"]);

                if ($("#hdn_sem").val() == 'S') {
                    $('#td_found_sem').html("SPRING");
                    $('#td_found_year').html((parseInt($("#hdn_year").val()) - 1).toString() + "-" + $("#hdn_year").val().toString().substr(2, 2));
                }
                else if ($("#hdn_sem").val() == 'M') {
                    $('#td_found_sem').html("MONSOON");
                    $('#td_found_year').html($("#hdn_year").val().toString() + "-" + (parseInt($("#hdn_year").val()) + 1).toString().substr(2, 2));
                }

                //$('#spn_dept').html(obj_stud_detail[0]["dept_name"].toUpperCase());

                switch (obj_stud_detail[0]['dept_code']) {
                    case "1":
                        $('#td_found_faculty').html('FACULTY OF ARCHITECTURE');
                        break;
                    case "2":
                        $('#td_found_faculty').html('FACULTY OF DESIGN');
                        break;
                    case "3":
                        $('#td_found_faculty').html('FACULTY OF MANAGEMENT');
                        break;
                    case "4":
                        $('#td_found_faculty').html('FACULTY OF PLANNING');
                        break;
                    case "5":
                        $('#td_found_faculty').html('FACULTY OF TECHNOLOGY');
                        break;
                }
                $('#div_pdf_logo').html('<img alt="" style="object-fit: cover;" src="../../image/ceptlogo_pdf.jpg" />');
                //$('#td_year').html($("#hdn_year").val());

                //$('#td_issuedate').html(obj_stud_detail[0]["full_name"]);
            }
        }

        function setStudentDetail() {

            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                var str_program = '';

                var str_program_new = obj_stud_detail[0]['prog_level_name'];//27/08/2019

                var stud_year_code = obj_stud_detail[0]["year_code"];

                if (obj_stud_detail[0]["year_code"] == 'Y1') stud_year_code = 'Y2013';

                //Start : No Longer Used from 27/08/2019
                if (obj_stud_detail[0]["prog_desc"] == 'Landscape Architecture') {
                    str_program = 'MASTERS PROGRAM IN LANDSCAPE ARCHITECTURE';
                }
                else if (obj_stud_detail[0]["prog_desc"] == 'Landscape Design') {
                    str_program = 'MASTERS PROGRAM IN LANSCAPE DESIGN';
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
                    str_program = 'MASTER OF URBAN AND REGIONAL PLANNING';
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

                if (obj_stud_detail[0]["name_of_the_degree"] != '') {
                    str_program = obj_stud_detail[0]["name_of_the_degree"];
                    $('#td_degree').html(str_program.toUpperCase());
                } else {
                    $('#td_degree').html("");
                }
                
                if (obj_stud_detail[0]['prog_code'] == '1') {
                    $('.PG').css("display","none");
                }
                //End : No Longer Used from 27/08/2019

                //$('#td_program').html(str_program.toUpperCase());

                $('#td_program').html(str_program_new.toUpperCase());//27/08/2019

                $('#td_name').html((obj_stud_detail[0]["full_name"]).toUpperCase());

                $('#td_rollno').html(obj_stud_detail[0]["user_id"]);

                if ($("#hdn_sem").val() == 'S') {
                    $('#td_sem').html("SPRING");
                    $('#td_year').html((parseInt($("#hdn_year").val()) - 1).toString() + "-" + $("#hdn_year").val().toString().substr(2, 2));
                }
                else if ($("#hdn_sem").val() == 'M') {
                    $('#td_sem').html("MONSOON");
                    $('#td_year').html($("#hdn_year").val().toString() + "-" + (parseInt($("#hdn_year").val()) + 1).toString().substr(2, 2));
                }

                //$('#spn_dept').html(obj_stud_detail[0]["dept_name"].toUpperCase());

                switch (obj_stud_detail[0]['dept_code']) {
                    case "1":
                        $('#div_pdf_logo').html('<img alt="" style="width: 284px; height: 152px; object-fit: cover;" src="../../image/ceptlogo_pdf_FA.jpg" />');
                        break;
                    case "2":
                        $('#div_pdf_logo').html('<img alt="" style="width: 284px; height: 152px; object-fit: cover;" src="../../image/ceptlogo_pdf_FD.jpg" />');
                        break;
                    case "3":
                        $('#div_pdf_logo').html('<img alt="" style="width: 284px; height: 152px; object-fit: cover;" src="../../image/ceptlogo_pdf_FM.jpg" />');
                        break;
                    case "4":
                        $('#div_pdf_logo').html('<img alt="" style="width: 284px; height: 152px; object-fit: cover;" src="../../image/ceptlogo_pdf_FP.jpg" />');
                        break;
                    case "5":
                        $('#div_pdf_logo').html('<img alt="" style="width: 284px; height: 152px; object-fit: cover;" src="../../image/ceptlogo_pdf_FT.jpg" />');
                        break;
                }

                //$('#td_year').html($("#hdn_year").val());

                //$('#td_issuedate').html(obj_stud_detail[0]["full_name"]);
            }
        }

        function setCourseFoundationDetail() {
            var pass_fail_flag = 1;
            var total_marks = 0;
            var total_credits = 0;

            var aggregate = 0;
            var sem1_pass_aggregate = 50;
            var sem2_pass_aggregate = 60;
            var semno = 0;
            var pass_marks = 50;// for Y2020 and onwards passing marks is 60 - 02112020

            $("#CFP_Sem2_Y2017Y2018Y2019_pass_marks").text("60-100");

            if (obj_stud_detail[0]["year_code"] == 'Y2017' || obj_stud_detail[0]["year_code"] == 'Y2018' || obj_stud_detail[0]["year_code"] == 'Y2019') {
                sem1_pass_aggregate = 50;
                $("#CFP_Sem1_Y2017Y2018Y2019_pass_marks").text("50-100");
            }
            else if (parseInt(obj_stud_detail[0]["year_code"].slice(1)) >= 2023)
            {
                //changes 1
                sem1_pass_aggregate = 55;
                $("#CFP_Sem1_Y2017Y2018Y2019_pass_marks").text("55-100");
                $("#CFP_Sem1_Y2017Y2018Y2019_fail_marks").text("0-54");
                pass_marks = 55;// for Y2023 and onwards passing marks is 55 - 22012024
            }
            else {
                sem1_pass_aggregate = 60;
                $("#CFP_Sem1_Y2017Y2018Y2019_pass_marks").text("60-100");
                $("#CFP_Sem1_Y2017Y2018Y2019_fail_marks").text("0-59");
                pass_marks = 60;// for Y2020 and onwards passing marks is 60 - 02112020
            }

            if (obj_stud_detail[0]["year_code"] == 'Y2019') {
                sem2_pass_aggregate = 65;
                $("#CFP_Sem2_Y2017Y2018Y2019_pass_marks").text("60-100");//65 instead of 60 Mahroofbhai Call - 14 08 2020
            }

            //11092020 CFP Marks Grade Change like M 2019 and onwards
            var grade_style = "OLD";
            if (obj_stud_detail[0]["year_code"] >= "Y2019") {
                if ($('#hdn_sem').val() != "S" && parseInt($('#hdn_year').val()) != 2019 || $('#hdn_sem').val() == "S" && parseInt($('#hdn_year').val()) > 2019
                    || $('#hdn_sem').val() == "M" && parseInt($('#hdn_year').val()) >= 2019) {
                    grade_style = "NEW";
                }
            }
            //11092020 CFP Marks Grade Change like M 2019 and onwards

            window.total_earned_credit = 0;
            window.core_cr = 0;
            window.ele_cr = 0;
            if (grade_style == "OLD") {
                if (obj_course_detail != null && obj_course_detail != undefined) {
                    var strTableCourseDetail = "<tr><th style='width: 125px;'>COURSE CODE</th><th>COURSE TITLE</th><th style='width:56px;text-align: center;'>CORE/ ELECTIVE</th><th style='text-align: center;width:79px;'>CREDIT</th><th class='cls_marks' style='text-align: center;width:79px;'>MARKS</th>" +
                        "<th style='width:10px;text-align: center;width:79px;'>GPA/ NGPA</th>";

                    strTableCourseDetail = strTableCourseDetail + "<th style='text-align: center;width:79px;'>REMARKS</th></tr>";

                    for (var i = 0; i < obj_course_detail.length; i++) {
                        strTableCourseDetail = strTableCourseDetail + "<tr>" +
                            "<td>" + obj_course_detail[i]['course_code'] + "</td>" +
                            "<td>" + obj_course_detail[i]['course_name'] + "</td>";
                        //"<td>" + obj_course_detail[i]['course_code'] + " - " + obj_course_detail[i]['course_name'] + "</td>";

                        if (obj_course_detail[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                        else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['c_type'] + "</td>";

                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['course_credits'] + "</td>" +
                            "<td class='cls_marks' style='text-align: center;'>" + obj_course_detail[i]['Total'] + "</td>";

                        if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'G') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                        }
                        else if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'N') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                        }
                        else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'G') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                        }
                        else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'N') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                        }
                        else {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                        }

                        if (i == 0) {
                            strTableCourseDetail += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><span id="spn_pass_fail_new"></span></td></tr>';
                        }
                        else if (i > 3) {
                            strTableCourseDetail += '<td style="vertical-align : middle;text-align:center;">' + obj_course_detail[i]['remarks'] + '</td></tr>';
                        }

                        if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {
                            pass_fail_flag = pass_fail_flag * 0;
                        }
                        else {
                            window.total_earned_credit += parseInt(obj_course_detail[i]['course_credits']);
                            if (obj_course_detail[i]['c_type'] == 'M') {
                                window.core_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                            else {
                                window.ele_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
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

                    $('#tbl_course_marks').html(strTableCourseDetail);

                    if (pass_fail_flag) {
                        if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                            $('#spn_pass_fail_new').html('PASS');
                        }
                        else {
                            $('#spn_pass_fail_new').html('FAIL');
                            window.total_earned_credit = 0;
                            window.core_cr = 0;
                            window.ele_cr = 0;
                        }
                    }
                    else {
                        $('#spn_pass_fail_new').html('FAIL');
                        window.total_earned_credit = 0;
                        window.core_cr = 0;
                        window.ele_cr = 0;
                    }

                    if (obj_course_detail[0]['semester_type'] == 'S') $('#h5_ws').html("SUMMER SCHOOL");
                    else if (obj_course_detail[0]['semester_type'] == 'M') $('#h5_ws').html("WINTER SCHOOL");
                }
            }
            else if (grade_style == "NEW") {
                if (obj_course_detail != null && obj_course_detail != undefined) {
                    var strTableCourseDetail = "<tr><th style='width: 125px;'>COURSE CODE</th><th>COURSE TITLE</th><th style='width:56px;text-align: center;'>CORE/ ELECTIVE</th><th style='text-align: center;width:79px;'>CREDIT</th><th class='cls_marks' style='text-align: center;width:79px;'>MARKS</th>" +
                        "<th style='width:10px;text-align: center;width:79px;'>GPA/ NGPA</th>";

                    strTableCourseDetail = strTableCourseDetail + "<th style='text-align: center;width:79px;'>REMARKS</th></tr>";

                    for (var i = 0; i < obj_course_detail.length; i++) {
                        strTableCourseDetail = strTableCourseDetail + "<tr>" +
                            "<td>" + obj_course_detail[i]['course_code'] + "</td>" +
                            "<td>" + obj_course_detail[i]['course_name'] + "</td>";
                        //"<td>" + obj_course_detail[i]['course_code'] + " - " + obj_course_detail[i]['course_name'] + "</td>";

                        if (obj_course_detail[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                        else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['c_type'] + "</td>";

                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['course_credits'] + "</td>" +
                            "<td class='cls_marks' style='text-align: center;'>" + obj_course_detail[i]['Total'] + "</td>";

                        if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'G') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                        }
                        else if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'N') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                        }
                        else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'G') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                        }
                        else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'N') {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                        }
                        else {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                        }

                        if (i == 0) {
                            strTableCourseDetail += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><span id="spn_pass_fail_new"></span></td></tr>';
                        }
                        else if (i > 3) {
                            strTableCourseDetail += '<td style="vertical-align : middle;text-align:center;">' + obj_course_detail[i]['remarks'] + '</td></tr>';
                        }

                        if (obj_course_detail[i]['course_code'] == 'CFP001') {
                            semno = 1;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                            semno = 1;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                            semno = 1;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                            semno = 1;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                            semno = 2;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                            semno = 2;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                            semno = 2;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                            semno = 2;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                            semno = 2;
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                            semno = 2;
                        }

                        if (semno == 1) {
                            if (!(parseInt(obj_course_detail[i]['Total']) >= pass_marks)) {// for Y2020 and onwards passing marks is 60 - 02112020
                                if (pass_fail_flag != 0) {
                                    pass_fail_flag = pass_fail_flag * 0;
                                }
                            }
                            else {
                                window.total_earned_credit += parseInt(obj_course_detail[i]['course_credits']);
                                if (obj_course_detail[i]['c_type'] == 'M') {
                                    window.core_cr += parseInt(obj_course_detail[i]['course_credits']);
                                }
                                else {
                                    window.ele_cr += parseInt(obj_course_detail[i]['course_credits']);
                                }
                            }
                        }
                        else if (semno == 2) {
                            if (!(parseInt(obj_course_detail[i]['Total']) >= 60))
                            {
                                if (pass_fail_flag != 0) {
                                    pass_fail_flag = pass_fail_flag * 0;
                                }
                            }
                            else {
                                window.total_earned_credit += parseInt(obj_course_detail[i]['course_credits']);
                                if (obj_course_detail[i]['c_type'] == 'M') {
                                    window.core_cr += parseInt(obj_course_detail[i]['course_credits']);
                                }
                                else {
                                    window.ele_cr += parseInt(obj_course_detail[i]['course_credits']);
                                }
                            }
                        }
                        

                        total_credits += parseInt(obj_course_detail[i]['course_credits']);
                    }
                    

                    $('#tbl_course_marks').html(strTableCourseDetail);

                    if (pass_fail_flag) {
                            $('#spn_pass_fail_new').html('PASS');
                        }
                        else {
                            $('#spn_pass_fail_new').html('FAIL');
                            window.total_earned_credit = 0;
                            window.core_cr = 0;
                            window.ele_cr = 0;
                        }

                    if (obj_course_detail[0]['semester_type'] == 'S') $('#h5_ws').html("SUMMER SCHOOL");
                    else if (obj_course_detail[0]['semester_type'] == 'M') $('#h5_ws').html("WINTER SCHOOL");
                }
            }

        }

        function setCourseDetail() {
            if (obj_course_detail != null && obj_course_detail != undefined) {
                var strTableCourseDetail = "<tr><th>COURSE CODE</th><th>COURSE TITLE</th><th style='width:10px;text-align: center;'>CORE/ ELECTIVE</th><th style='text-align: center;'>CREDIT</th><th class='cls_marks' style='text-align: center;'>MARKS</th>" +
                    //var strTableCourseDetail = "<tr><th>COURSE CODE & TITLE</th><th style='width:10px;text-align: center;'>CORE/ ELECTIVE</th><th style='text-align: center;'>CREDIT</th><th class='cls_marks' style='text-align: center;'>MARKS</th>" +
                    //var strTableCourseDetail = "<tr><th>COURSE CODE</th><th>TITLE OF THE COURSE</th><th>CORE/ ELECTIVE</th><th>CREDIT</th><th>GPA/ NGPA</th>" +
                    "<th style='width:10px;text-align: center;'>GPA/ NGPA</th><th style='text-align: center;'>GRADE</th>";

                //if (obj_stud_detail[0]["year_code"] < 'Y2014') { strTableCourseDetail = strTableCourseDetail + "<th>GRADE POINT</th>"; }
                strTableCourseDetail = strTableCourseDetail + "<th style='width:10px;text-align: center;'>GRADE POINT</th>";

                strTableCourseDetail = strTableCourseDetail + "<th style='text-align: center;'>REMARKS</th></tr>";

                for (var i = 0; i < obj_course_detail.length; i++) {
                    strTableCourseDetail = strTableCourseDetail + "<tr>" +
                        "<td>" + obj_course_detail[i]['course_code'] + "</td>" +
                        "<td>" + obj_course_detail[i]['course_name'] + "</td>";
                    //"<td>" + obj_course_detail[i]['course_code'] + " - " + obj_course_detail[i]['course_name'] + "</td>";

                    if (obj_course_detail[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                    else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['c_type'] + "</td>";

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['course_credits'] + "</td>" +
                        "<td class='cls_marks' style='text-align: center;'>" + obj_course_detail[i]['Total'] + "</td>";

                    //07012020 M N the GPA/NGPA Correct shown and Grade P if Pass 
                    if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'G') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                    }
                    else if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'N') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                    }
                    else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'G') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                    }
                    else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'N') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                    }
                    else {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                    }
                    //07012020 M N the GPA/NGPA Correct shown and Grade P if Pass

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;' class='cls_found_hide'>" + obj_course_detail[i]['grade'] + "</td>";

                    //if (obj_stud_detail[0]["year_code"] < 'Y2014') { strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['grade_point'] + "</td>"; }
                    if (obj_stud_detail[0]["year_code"] == 'Y2017')
                    {
                        if (obj_course_detail[i]['grade_point'] == 'NA')
                        {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;' class='cls_found_hide'>" + obj_course_detail[i]['grade_point'] + "</td>";
                        }
                        else
                        {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;' class='cls_found_hide'>" + round_num(round_num(obj_course_detail[i]['grade_point'], 2), 1) + "</td>";
                        }
                        
                    }
                    else { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;' class='cls_found_hide'>" + obj_course_detail[i]['grade_point'] + "</td>";}
                    
                    //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;' class='cls_found_hide'>" + round_num(round_num(obj_course_detail[i]['grade_point'], 2), 1) + "</td>";//29/01/2021 - Nitinbhai Called and Email - Please check the grade report as well as the transcript should be 1 decimal in both. it should use the same as it is used in the transcript. I have explained it to you over the phone for example : Student  UC0915

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['remarks'] + "</td></tr>";
                }

                $('#tbl_course_marks').html(strTableCourseDetail);

                if (obj_course_detail[0]['semester_type'] == 'S') $('#h5_ws').html("SUMMER SCHOOL");
                else if (obj_course_detail[0]['semester_type'] == 'M') $('#h5_ws').html("WINTER SCHOOL");
            }
        }

        function set_WS_CourseDetail() {
            //if (obj_ws_course_detail != null && obj_ws_course_detail != undefined) {
            //    var strTableCourseDetail = "<tr><th style='text-align: center;'>COURSE CODE</th><th style='text-align: center;'>COURSE NAME</th><th style='text-align: center;'>GPA/ NGPA</th><th style='text-align: center;'>CREDITS</th><th style='text-align: center;'>STATUS</th></tr>";

            //    for (var i = 0; i < obj_ws_course_detail.length; i++) {
            //        var str_course_name = obj_ws_course_detail[i]['course_name'].toString().toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

            //        strTableCourseDetail = strTableCourseDetail + "<tr>" +
            //                                "<td style='text-align: center;'>" + obj_ws_course_detail[i]['course_code'] + "</td>" +
            //        //"<td>" + obj_ws_course_detail[i]['course_name'] + "</td>";
            //                                "<td>" + str_course_name + "</td>";

            //        if (obj_ws_course_detail[i]['c_type'] == 'M') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>"; }
            //        else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>"; }
            //        else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>"; }
            //        else { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>"; }

            //        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['course_credits'] + "</td>";

            //        if (obj_ws_course_detail[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>PASS</td></tr>";
            //        else if (obj_ws_course_detail[i]['Total'] == 0) {
            //            if (obj_ws_course_detail[i]['absent_exam_1'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_2'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_3'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_4'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_5'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_6'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_7'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_8'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_9'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else if (obj_ws_course_detail[i]['absent_exam_10'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
            //            else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>FAIL</td></tr>";
            //        }
            //        else if (obj_ws_course_detail[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>FAIL</td></tr>";
            //    }

            //    $('#tbl_ws_course_marks').html(strTableCourseDetail);
            //}
            //else {
            //    $('#div_ws_course_marks').css('display', 'none');
            //}

            $('#div_ws_course_marks').css('display', 'none');

            if (obj_ws_course_detail != null && obj_ws_course_detail != undefined) {
                var strTableCourseDetail = "";

                for (var i = 0; i < obj_ws_course_detail.length; i++) {
                    var str_course_name = obj_ws_course_detail[i]['course_name'].toString().toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                    strTableCourseDetail = strTableCourseDetail + "<tr>" +
                        "<td>" + obj_ws_course_detail[i]['course_code'] + "</td>" +
                        "<td>" + str_course_name + "</td>";

                    if (obj_ws_course_detail[i]['c_type'] == "M") strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>C</td>";
                    else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['c_type'] + "</td>";

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['course_credits'] + "</td>";

                    if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') {
                        strTableCourseDetail += "<td class='cls_marks' style='text-align: center;'>NA</td>";
                    }
                    else {
                        strTableCourseDetail += "<td class='cls_marks' style='text-align: center;'>" + obj_ws_course_detail[i]['Total'] + "</td>";
                    }

                    //02012020 M N the GPA/NGPA Correct shown and Grade P if Pass 
                    if (obj_ws_course_detail[i]['c_type'] == 'M' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                    }
                    else if (obj_ws_course_detail[i]['c_type'] == 'M' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                    }
                    else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>";
                    }
                    else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>";
                    }
                    else {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>";
                    }
                    //02012020 M N the GPA/NGPA Correct shown and Grade P if Pass

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['grade'] + "</td>";
                     // Changes By Nitinbhai called Task 2825 Date 14122022
                    if (obj_stud_detail[0]["year_code"] == 'Y2017')
                    {
                        if (obj_ws_course_detail[i]['grade_point'] == 'NA')
                        {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['grade_point'] + "</td>";
                        }
                        else
                        {
                            strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + round_num(round_num(obj_ws_course_detail[i]['grade_point'], 2), 1) + "</td>";
                        }
                        
                    }
                    else { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['grade_point'] + "</td>";}
                    
                    //strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + round_num(round_num(obj_ws_course_detail[i]['grade_point'], 2), 1) + "</td>";//29/01/2021 - Nitinbhai Called and Email - Please check the grade report as well as the transcript should be 1 decimal in both. it should use the same as it is used in the transcript. I have explained it to you over the phone for example : Student  UC0915

                    if (obj_ws_course_detail[i]['Total'] == 0) {
                        if (obj_ws_course_detail[i]['absent_exam_1'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_2'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_3'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_4'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_5'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_6'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_7'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_8'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_9'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else if (obj_ws_course_detail[i]['absent_exam_10'] == 'IC') strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>IC</td></tr>";
                        else strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>FAIL</td></tr>";
                    }
                    else {
                        strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['remarks'] + "</td></tr>";
                    }
                }

                $('#tbl_course_marks tbody').append(strTableCourseDetail);
            }
        }

        function setCreditDetail() {
            if (obj_credit_detail != null && obj_credit_detail != undefined) {
                if (window.found_flag == "N") {
                    $('#td_total_credit').html(obj_credit_detail[0]['total_credit']);
                    $('#td_core_credit').html(parseInt(obj_credit_detail[0]['core_credit']) + parseInt(obj_credit_detail[0]['sws_m_gpa_credit']) + parseInt(obj_credit_detail[0]['sws_m_ngpa_credit']));
                    //$('#td_core_credit').html(obj_credit_detail[0]['core_credit']);
                    $('#td_elective_credit').html(parseInt(obj_credit_detail[0]['elective_credit']) + parseInt(obj_credit_detail[0]['sws_gpa_credit']) + parseInt(obj_credit_detail[0]['sws_ngpa_credit']));
                    //$('#td_elective_credit').html(obj_credit_detail[0]['elective_credit']);

                    //$('#td_gpa_credit').html(obj_credit_detail[0]['gpa_credit']);
                    $('#td_gpa_credit').html(parseInt(obj_credit_detail[0]['gpa_credit']) + parseInt(obj_credit_detail[0]['sws_gpa_credit']));
                    //$('#td_ngpa_credit').html(obj_credit_detail[0]['ngpa_credit']);
                    $('#td_ngpa_credit').html(parseInt(obj_credit_detail[0]['ngpa_credit']) + parseInt(obj_credit_detail[0]['sws_ngpa_credit']));

                    //$('#td_m_gpa_credit').html(obj_credit_detail[0]['m_gpa_credit']);
                    //$('#td_m_ngpa_credit').html(obj_credit_detail[0]['m_ngpa_credit']);
                    $('#td_m_gpa_credit').html(parseInt(obj_credit_detail[0]['m_gpa_credit']) + parseInt(obj_credit_detail[0]['sws_m_gpa_credit']));
                    $('#td_m_ngpa_credit').html(parseInt(obj_credit_detail[0]['m_ngpa_credit']) + parseInt(obj_credit_detail[0]['sws_m_ngpa_credit']));


                    $('#td_sws_credit').html(obj_credit_detail[0]['sws_credit']);
                } else {
                    $('#td_found_total_credit').html(window.total_earned_credit);
                    $('#td_found_core_credit').html(window.core_cr);
                    $('#td_found_elective_credit').html(window.ele_cr);

                    //$('#td_found_total_credit').html(obj_credit_detail[0]['total_credit']);
                    //$('#td_found_core_credit').html(obj_credit_detail[0]['core_credit']);
                    //$('#td_found_elective_credit').html(obj_credit_detail[0]['elective_credit']);
                }

                //$('#td_grade_point_avg').html(obj_credit_detail[0]['grade_point_avg']);
                if (obj_credit_detail[0]['grade_point_avg'].toString() == '-') {
                    $('#td_grade_point_avg').html(obj_credit_detail[0]['grade_point_avg']);
                }
                else {
                    if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                        //$('#td_grade_point_avg').html(parseFloat(obj_credit_detail[0]['grade_point_avg']).toFixed(2));
                        $('#td_grade_point_avg').html(round_num(obj_credit_detail[0]['grade_point_avg'], 2));
                    } else if (obj_stud_detail[0]["year_code"] == 'Y2018') {
                        //$('#td_grade_point_avg').html("<b>" + parseFloat(obj_credit_detail[0]['grade_point_avg']).toFixed(1) + "&nbsp;*</b>");
                        $('#td_grade_point_avg').html(round_num(round_num(obj_credit_detail[0]['grade_point_avg'], 2), 1) + "&nbsp; ");
                    } else {
                        //$('#td_grade_point_avg').html(parseFloat(obj_credit_detail[0]['grade_point_avg']).toFixed(1) + "&nbsp;*");
                        $('#td_grade_point_avg').html(round_num(round_num(obj_credit_detail[0]['grade_point_avg'], 2), 1) + "&nbsp; ");
                    }
                }

                //if (obj_credit_detail[0]['total_credit'] != '0') {
                //    $('#td_total_credit').html(obj_credit_detail[0]['total_credit']);
                //}
                //if (obj_credit_detail[0]['core_credit'] != '0') {
                //    $('#td_core_credit').html(obj_credit_detail[0]['core_credit']);
                //}
                //if (obj_credit_detail[0]['elective_credit'] != '0') {
                //    $('#td_elective_credit').html(obj_credit_detail[0]['elective_credit']);
                //}
                //if (obj_credit_detail[0]['gpa_credit'] != '0') {
                //    $('#td_gpa_credit').html(obj_credit_detail[0]['gpa_credit']);
                //}
                //if (obj_credit_detail[0]['ngpa_credit'] != '0') {
                //    $('#td_ngpa_credit').html(obj_credit_detail[0]['ngpa_credit']);
                //}
                //if (obj_credit_detail[0]['grade_point_avg'] != '0') {
                //    $('#td_grade_point_avg').html(obj_credit_detail[0]['grade_point_avg']);
                //}
            }
        }

        function display_Grade_Range() {
            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                    $('#div_grade_range').css('display', 'block');
                    $('#div_grade_range table').css('font-size', '11px');
                    $('#div_grade_range table tr th').css('line-height', '10px');
                    $('#div_grade_range table tr td').css('line-height', '10px');
                }
                else if (obj_stud_detail[0]["year_code"] >= 'Y2018') {
                    $('#div_grade_range_Y2018_onward').css('display', 'block');//uncomment 06082019
                    $('#div_grade_range_Y2018_onward table').css('font-size', '11px');
                    $('#div_grade_range_Y2018_onward table tr th').css('line-height', '10px');
                    $('#div_grade_range_Y2018_onward table tr td').css('line-height', '10px');

                    $('.cls_marks').css('display', 'none');
                    $('#tr_semester_marks_avg').css('display', 'none');
                    $('#div_white_space').css('height', '84px');

                    $('#div_grade_range_Y2018_onward table tbody tr th').css('width', '10%');
                    //$('#div_grade_range_Y2018_onward table tbody tr th').css('text-align', 'center');
                    $('#div_grade_range_Y2018_onward table tbody tr td').css('width', '5%');
                    $('#div_grade_range_Y2018_onward table tbody tr td').css('text-align', 'center');
                    $("#div_note").css('display', 'none');
                }
                else {
                    $('#div_grade_range_2014_onward').css('display', 'block');
                    $('#div_grade_range_2014_onward table').css('font-size', '11px');
                    $('#div_grade_range_2014_onward table tr th').css('line-height', '10px');
                    $('#div_grade_range_2014_onward table tr td').css('line-height', '10px');
                    $('.cls_marks').css('display', 'none');
                }

                if (window.found_flag == "Y") {
                    $('#div_grade_range_2014_onward').css('display', 'none');
                    $('#div_grade_range_Y2018_onward').css('display', 'none');//Added 06082019
                    $('#div_grade_range').css('display', 'none');
                    $("#div_note").css('display', 'none');
                }
            }
        }
        
        function round_num(num, precision) {
            return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
        }

    </script>
</head>
<body class="container">

    <%--<div style="top: 20px; height: 120px; left: 1px;" title="" id="i22byht1">
        <a style="width: 297px; height: 96px; cursor: pointer;float:right;" href="../Master/Home.aspx">
            <div style="width: 297px; height: 96px; position: relative;">
                <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage" />
            </div>
        </a>

        <div style="clear:both;padding-top: 10px;">
            <div style="float:right;color: #5575B2;font-size:22px;font-weight:bold;padding-left:10px;padding-right:10px;">FACULTY <br /> OF <span id="spn_dept"></span></div>
            <div style="float:right;background-color: #5575B2;height: 41px;">&nbsp;</div>
        </div>
    </div>--%>

    <div style="top: 20px; height: 120px; left: 1px;" title="" id="i22byht1">
        <a style="width: 288px; height: 96px; float: right; margin-top: 1px;">
            <div id="div_pdf_logo" style="width: 288px; height: 152px; position: relative;">
                <%--<img alt="" style="width: 284px; height: 152px; object-fit: cover;" src="../../image/ceptlogo_pdf_FA.jpg" id="img_pdf_logo" class="s4imgimage" />--%>
            </div>
        </a>
    </div>

    <h4 class="cls_found_hide">GRADE REPORT (Provisional)</h4>
    <%--<h4>GRADE REPORT</h4>--%>

    <div>
        <table class="table table-condensed cls_found_hide">
            <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE PROGRAM</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_program" style="border: none;"></td>
            </tr>
            <tr class="PG">
                <td style="border: none; width: 240px;"><b>NAME OF THE DEGREE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_degree" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE STUDENT</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_name" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>STUDENT CODE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_rollno" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>SEMESTER</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_sem" style="border: none;"></td>
            </tr>
            <tr>
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

        <table class="table table-condensed cls_found_show">
            <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE STUDENT</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_stud_name" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>STUDENT CODE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_stud_code" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>DATE OF BIRTH</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_dob" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE PROGRAM</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_program" style="border: none;"></td>
            </tr>
           <%-- <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE DEGREE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_degree" style="border: none;"></td>
            </tr>--%>
            <tr>
                <td style="border: none; width: 240px;"><b>NAME OF THE FACULTY</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_faculty" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>SEMESTER</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_sem" style="border: none;"></td>
            </tr>
            <tr>
                <td style="border: none; width: 240px;"><b>ACADEMIC YEAR</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_year" style="border: none;"></td>

                <td style="border: none; width: 255px;"><b style="float: right;">DATE OF ISSUE</b></td>
                <td style="border: none; width: 10px;">: </td>
                <td id="td_found_doi" style="border: none; float: right;"></td>
            </tr>
        </table>
    </div>

    <div style="height: 600px;">
        <table id="tbl_course_marks" class="table table-bordered">
            <tr>
                <th>COURSE CODE</th>
                <th>TITLE OF THE COURSE</th>
                <th>CORE/ ELECTIVE</th>
                <th>CREDIT</th>
                <th class="cls_marks">MARKS</th>
                <th>GPA/ NGPA</th>
                <th>GRADE</th>
                <th>GRADE POINT</th>
                <th>REMARKS</th>
            </tr>

            <%--<tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>--%>
        </table>
    </div>

    <div id="div_ws_course_marks">
        <h5 id="h5_ws"></h5>

        <table id="tbl_ws_course_marks" class="table table-bordered">
            <tr>
                <th>COURSE CODE</th>
                <th>COURSE NAME</th>
                <th>GPA/ NGPA</th>
                <th>CREDITS</th>
                <th>STATUS</th>
            </tr>

            <tr>
                <%--<td>W13FA004</td>
                <td>DIGITAL CRAFT</td>
                <td>NGPA</td>
                <td>5</td>
                <td>PASS</td>--%>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
        </table>
    </div>

    <div>

        <table class="table table-bordered table-condensed cls_found_hide">
            <tr>
                <td>
                    <table class="table table-condensed" style="margin-bottom: 15px; margin-top:15px;">
                        <tr>
                            <td style="border: none;">TOTAL CREDITS EARNED</td>
                            <td style="border: none;">- </td>
                            <td id="td_total_credit" style="border: none;"></td>
                        </tr>
                        <tr>
                            <td style="border: none;">CORE</td>
                            <td style="border: none;">- </td>
                            <td id="td_core_credit" style="border: none;"></td>
                        </tr>
                        <tr>
                            <td style="border: none; padding-left: 35px;">GPA</td>
                            <td style="border: none;">- </td>
                            <td id="td_m_gpa_credit" style="border: none;"></td>
                        </tr>
                        <tr>
                            <td style="border: none; padding-left: 35px;">NGPA</td>
                            <td style="border: none;">- </td>
                            <td id="td_m_ngpa_credit" style="border: none;"></td>
                        </tr>
                        <tr>
                            <td style="border: none;">ELECTIVE</td>
                            <td style="border: none;">- </td>
                            <td id="td_elective_credit" style="border: none;"></td>
                        </tr>
                        <tr>
                            <td style="border: none; padding-left: 35px;">GPA</td>
                            <td style="border: none;">- </td>
                            <td id="td_gpa_credit" style="border: none;"></td>
                        </tr>
                        <tr>
                            <td style="border: none; padding-left: 35px;">NGPA</td>
                            <td style="border: none;">- </td>
                            <td id="td_ngpa_credit" style="border: none;"></td>
                        </tr>
                        <tr style="display:none;">
                            <td style="border: none;">SUMMER/WINTER SCHOOL</td>
                            <td style="border: none;">- </td>
                            <td id="td_sws_credit" style="border: none;"></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td style="border: none;">SEMESTER GRADE POINT AVERAGE</td>
                            <td style="border: none;">: </td>
                            <td id="td_grade_point_avg" style="border: none;"></td>
                        </tr>
                        <tr style="display: none;">
                            <td style="border: none;">SEMESTER GRADE POINT RATIO</td>
                            <td style="border: none;">: </td>
                            <td id="td_grade_point_ratio" style="border: none;"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table class="table table-bordered table-condensed cls_found_show" style="margin-top: 0; width: 100%;">
            <tbody>
                <tr>
                    <td style="font-weight: bold; width: 30%; padding: 5px 10px;">TOTAL CREDITS EARNED</td>
                    <td style="border: none; font-weight: bold; padding: 5px 10px; text-align: center; width: 5%;">- </td>
                    <td id="td_found_total_credit" style="border-left: none; padding: 5px 10px; font-weight: bold; width: 15%; border-right: inset; border-width: thin; text-align: left;"></td>
                    <td style="border: none; width: 50%; padding: 5px 10px;">&nbsp;</td>
                </tr>
                <tr>
                    <td style="border-top: none; width: 30%; padding: 5px 10px;">CORE</td>
                    <td style="border: none; text-align: center; width: 5%; padding: 5px 10px;">- </td>
                    <td id="td_found_core_credit" style="border-left: none; padding: 5px 10px; border-top: none; width: 15%; border-right: inset; border-width: thin; text-align: left;"></td>
                    <td style="border: none; width: 50%; padding: 5px 10px;">&nbsp;</td>
                </tr>
                <tr>
                    <td style="border-top: none; width: 30%; padding: 5px 10px;">ELECTIVE</td>
                    <td style="border: none; text-align: center; padding: 5px 10px; width: 5%;">- </td>
                    <td id="td_found_elective_credit" style="border-left: none; padding: 5px 10px; border-top: none; width: 15%; border-right: inset; border-width: thin; text-align: left;"></td>
                    <td style="border: none; width: 50%; padding: 5px 10px;">&nbsp;</td>
                </tr>
            </tbody>
        </table>
        <div style="font-weight: bold;">C – Core, E – Elective, NGPA - Non GPA, P - Pass, F - Fail, NA - Not Applicable</div>
    </div>

    <div style="display: none;">
        <div style="height: 50px;"></div>
        <div style="float: left; font-weight: bold; margin-bottom: 10px;">PROGRAM COORDINATOR</div>
        <div style="float: right; font-weight: bold; margin-bottom: 10px;">DEAN</div>
    </div>

    <div id="div_grade_range" style="display: none;">
        <table class="table table-bordered table-condensed">
            <tr>
                <th>Grade</th>
                <td>A+</td>
                <td>A</td>
                <td>A-</td>
                <td>B+</td>
                <td>B</td>
                <td>B-</td>
                <td>C+</td>
                <td>C</td>
                <td>C-</td>
                <td>D+</td>
                <td>D</td>
                <td>D-</td>
                <td>F</td>
                <td>P</td>
                <td>NP</td>
                <td>IC</td>
            </tr>

            <tr>
                <th>Grade Point</th>
                <td>4.00</td>
                <td>4.00</td>
                <td>3.67</td>
                <td>3.33</td>
                <td>3.00</td>
                <td>2.67</td>
                <td>2.33</td>
                <td>2.00</td>
                <td>1.67</td>
                <td>1.33</td>
                <td>1.00</td>
                <td>0.67</td>
                <td>0</td>
                <td>NA</td>
                <td>NA</td>
                <td>NA</td>
            </tr>

            <tr>
                <th>Numerical</th>
                <td>>86</td>
                <td>83-86</td>
                <td>80-82</td>
                <td>77-79</td>
                <td>73-76</td>
                <td>70-72</td>
                <td>67-69</td>
                <td>63-66</td>
                <td>60-62</td>
                <td>57-59</td>
                <td>53-56</td>
                <td>50-52</td>
                <td><50</td>
                <td>PASS</td>
                <td>NO PASS</td>
                <td>In-Complete</td>
            </tr>
        </table>
    </div>

    <div id="div_grade_range_2014_onward" style="display: none;">
        <table class="table table-bordered table-condensed">
            <tr>
                <th>Grade</th>
                <td>A+</td>
                <td>A</td>
                <td>A-</td>
                <td>B+</td>
                <td>B</td>
                <td>B-</td>
                <td>C+</td>
                <td>C</td>
                <td>C-</td>
                <td>D+</td>
                <td>D</td>
                <td>D-</td>
                <td>F</td>
                <td>P</td>
                <td>NP</td>
                <td>IC</td>
            </tr>
            <tr>
                <th>Grade Point</th>
                <td>4.3</td>
                <td>4.0</td>
                <td>3.7</td>
                <td>3.3</td>
                <td>3.0</td>
                <td>2.7</td>
                <td>2.3</td>
                <td>2.00</td>
                <td>1.7</td>
                <td>1.3</td>
                <td>1.0</td>
                <td>0.7</td>
                <td>0</td>
                <td>NA</td>
                <td>NA</td>
                <td>NA</td>
            </tr>
        </table>
    </div>

    <div class="cls_found_show">
        <div id="div_grade_range_M_Y2018_onward_sem1" style="margin-top: 20px; float: left;">
            <table class="table table-bordered table-condensed" style="width: 100% !important;">
                <tr>
                    <td style="width: 100%; padding: 0 10px; font-size: 14px;" colspan="4">Year 1 – CEPT Foundation Program</td>
                </tr>
                <tr>
                    <td style="text-align: center; width: 50%; font-size: 14px; padding: 0 10px;" colspan="2">Sem 1
                    </td>
                    <td style="text-align: center; width: 50%; font-size: 14px; padding: 0 10px;" colspan="2">Sem 2
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;">PASS
                    </td>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;">FAIL
                    </td>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;">PASS
                    </td>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;">FAIL
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;" id="CFP_Sem1_Y2017Y2018Y2019_pass_marks"></td>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;" id="CFP_Sem1_Y2017Y2018Y2019_fail_marks">0-49
                    </td>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;" id="CFP_Sem2_Y2017Y2018Y2019_pass_marks"></td>
                    <td style="text-align: center; width: 25%; font-size: 14px; padding: 0 10px;">0-59
                    </td>
                </tr>
            </table>
        </div>

        <div id="div_grade_range_M_Y2018_onward_sem2" style="margin-top: 20px; float: left; margin-left: 10%;">
            <table class="table table-bordered table-condensed" style="width: 100% !important;">
                <tr>
                    <td style="padding: 0 10px; font-size: 14px;">Year 2 - 5</td>
                </tr>
                <tr>
                    <td style="text-align: left; padding: 0 10px; font-size: 14px; width: 25%;">Grade
                    </td>
                    <td style="text-align: center; width: 15%; font-size: 14px; padding: 0 10px;">O
                    </td>
                    <td style="text-align: center; width: 15%; font-size: 14px; padding: 0 10px;">A
                    </td>
                    <td style="text-align: center; width: 15%; font-size: 14px; padding: 0 10px;">B
                    </td>
                    <td style="text-align: center; width: 15%; font-size: 14px; padding: 0 10px;">C
                    </td>
                    <td style="text-align: center; width: 15%; font-size: 14px; padding: 0 10px;">F
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; font-size: 14px; padding: 0 10px;">Grade Point
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">5
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">4
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">3
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">2
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">0
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left; font-size: 14px; padding: 0 10px;">Mark Range
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">90-100
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">80-89
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">65-79
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">55-64
                    </td>
                    <td style="text-align: center; font-size: 14px; padding: 0 10px;">0-54
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div id="div_grade_range_Y2018_onward" style="display: none;">
        <table class="table table-bordered table-condensed" style="width: 39.81% !important">
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

    <div class="cls_found_show" style="font-weight: bold; float: left; margin-top: 4%;">PROGRAM CHAIR  <span style="margin-left: 260px;">DIRECTOR, CFP</span></div>

    <input type="hidden" id="hdn_uid" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_stud_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_course_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_ws_course_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_credit_detail" runat="server" clientidmode="Static" />

</body>
</html>
