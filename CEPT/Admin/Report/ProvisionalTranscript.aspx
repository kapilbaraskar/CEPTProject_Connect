<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProvisionalTranscript.aspx.cs" Inherits="Admin_Report_ProvisionalTranscript" %>

<html xmlns="https://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>

    <style>
        body {
            -webkit-print-color-adjust: exact;
        }

        table {
            border-collapse: collapse;
            margin-bottom: 5px;
            margin-top: 5px;
            width: 98%;
        }

        /*#right_side table tr td .col_dtl: nth-child(1) {
            width: 85%;
            text-align: right !important;
        }*/

        #right_side td.col_dtl:nth-child(2) {
            width: 5%;
            /*padding-left: 15px;*/
            padding-right: 12px;
            text-align: right !important;
        }

        #right_side td.col_dtl:nth-child(3) {
            width: 5%;
            padding-left: 3px;
            text-align: left !important;
        }

        #right_side table tr td.col_dtl:nth-child(4) {
            width: 5%;
            padding-right: 1px;
            text-align: right !important;
        }

        /*#left_side table tr td .col_dtl: nth-child(1) {
            width: 85%;
            text-align: right;
            
        }*/

        #left_side td.col_dtl:nth-child(2) {
            width: 5%;
            /*padding-left: 10px;*/
            /*padding-left: 15px;*/
            padding-right: 12px;
            text-align: right !important;
        }

        #left_side td.col_dtl:nth-child(3) {
            width: 5%;
            /*padding-left: 15px;*/
            padding-left: 3px;
            text-align: left !important;
        }

        #left_side table tr td.col_dtl:nth-child(4) {
            width: 5%;
            padding-right: 1px;
            text-align: right !important;
        }

        td.program_td {
            width: 85%;
            text-align: left;
            line-height: 21px;
        }

       td.program_td:nth-child(2) {
                text-align: right;
            }

        th,td {
            border-bottom: 1px solid #cecfd5;
            /* padding-right:8px; */
            text-align: center;
            padding: 0;
            line-height: 19px;
        }

        th {
            font-weight: bold;
            line-height: 18px;
            padding: 0;
        }



        table thead tr th : first-child {
            width: 85%;
            border: solid 1px Red !important;
        }

        table thead {
            background-color: rgba(217,217,217,1);
            font-family: calibri;
        }

        table tr td : first-child {
            width: 85%;
            text-align: center;
        }

        table tr td : nth-child(2) {
            width: 5%;
        }

        table tbody tr : last-child {
            border-bottom: 1px solid black;
        }

        table tfoot tr td : first-child {
            width: 85%;
        }

        table tfoot {
            font-family: calibri;
            font-weight: bold;
        }

        .col_dtl {
            font-family: Consolas;
            font-size: 10.0pt;
            line-height: 1px;
            padding: 10px 1px;
            text-align: left;
        }

        #prg_summ {
            font-family: calibri;
        }

        #mand_gpa {
            padding-left: 50px;
        }

        #mand_gpa_no {
            font-weight: bold;
        }

        #mand_ngpa {
            padding-left: 50px;
        }

        #elec_gpa {
            padding-left: 50px;
        }

        #elec_gpa_no {
            font-weight: bold;
        }

        #elec_ngpa {
            padding-left: 50px;
        }

        #total_gpa_no {
            font-weight: bold;
        }

        #total_cgpa {
            font-weight: bold;
        }

        table tr .col_dtl {
            border-bottom: 1px solid #C0C0C0 !important;
        }


        table tr .program_td {
            border-bottom: 1px solid #C0C0C0 !important;
            font-size: 15px;
        }

        .div_footer {
            margin-bottom: -5px;
            font-family: Calibri;
            font-size: 15px;
        }

        .program_footer {
            width: 30%;
            display: inline-block;
            float: left;
            text-align: left;
            font-weight: bold;
            font-size: 15px;
        }

        .den_footer {
            width: 30%;
            display: inline-block;
            text-align: center;
            font-weight: bold;
            padding-left: 50px;
            font-size: 15px;
        }

        .reg_footer {
            width: 30%;
            display: inline-block;
            float: right;
            text-align: right;
            font-weight: bold;
            padding-right: 9.5px;
            font-size: 15px;
        }

        .reg_footer_ {
            width: 30%;
            display: inline-block;
            float: right;
            text-align: right;
            padding-right: 9.5px;
            font-size: 15px;
        }

        .program_footer_pg {
            width: 25%;
            display: inline-block;
            float: left;
            text-align: left;
            font-weight: bold;
        }

        .den_footer_pg {
            width: 25%;
            display: inline-block;
            text-align: center;
            font-weight: bold;
        }

        .reg_footer_pg {
            width: 25%;
            display: inline-block;
            text-align: center;
            font-weight: bold;
        }

        .no_pg {
            width: 20%;
            display: inline-block;
            float: right;
            text-align: right;
            font-weight: bold;
        }
        /*title semester & year*/
        td#semesteryear {
            border-bottom: 1px solid black;
            font-weight: bold;
            padding-right: 100px;
            font-size: 15px;
            font-family: Calibri;
        }

        #course_dtl tr:last-child {
            border-bottom: 1px solid black !important;
        }

        tr#course_dtl:last-child td {
            border-bottom: 1px solid black !important;
        }

        #prg_summ tr:last-child td {
            border-bottom: 1px solid black !important;
        }

        #prg_summ tr:first-child {
            border-bottom: 1px solid black !important;
        }

        span#course_code_td {
            font-family: Calibri;
        }

        tr#course_dtl td:first-child {
            width: 85%;
        }


        /*#footer tr td:last-child {
            text-align: right;
            padding-right: 3px;
        }*/
        #footer tr:last-child td {
            border-bottom: 0;
            text-align: right;
            border-top: 1px solid black !important;
            /*line-height: 10px !important;*/
        }

        #footer tr td:nth-child(2) {
            text-align: right;
            padding-right: 12px;
        }

        #footer {
            font-size: 10.0pt;
            font-family: Consolas;
        }
        /*-----------header Style------------------*/

        #tbl_student_detail tr td:nth-child(2) {
            font-weight: bold;
        }
         

        #tbl_student_detail tr td:nth-child(4) {
            font-weight: bold;
            width: initial;
             
            
        }
       
        #tbl_student_detail {
            font-family: Calibri;
            font-size: 15px;
        }

            #tbl_student_detail td {
                line-height: 12px !important;
            }

        .trasncript_div {
            font-family: Calibri;
        }

        .issue_date {
            width: 60%;
            display: inline-block;
            text-align: left;
            font-size: 10px;
            margin-top: -0.5px;
        }
        /*#tbl_student_detail td:nth-child(2),
        {
            padding-right:60px;
        }*/
        /* #tbl_student_detail td:nth-child(3) 
        {
            padding-right:80px;
        }*/
        /*#tbl_student_detail td
         {
             text-align:left;
         }*/

        table#description_tbl tr td {
            text-align: left;
            /*width:30%;*/
            border-bottom: none !important;
        }

        #description_tbl, #desc_right {
            font-family: Calibri;
            line-height: 10px;
            font-weight: 15px;
        }

        table#description_tbl tr td span {
            font-weight: bold;
            padding-right: 20px;
        }

        table#description_tbl tr td:first-child {
            width: 3px !important;
        }


        #course_td {
            width: 30px !important;
        }

        table#desc_right tr td {
            text-align: left;
            border-bottom: none !important;
        }

        table#desc_right tr {
            margin-bottom: 10px;
        }


            table#desc_right tr td {
                padding-left: 60px;
            }

        table#address tr td {
            text-align: right;
            border-bottom: none !important;
        }

        #address {
            font-family: Calibri;
            line-height: 10px;
            font-weight: 15px;
        }

        td#topic span {
            line-height: 22.7px;
        }
        /* div#main_body {
    margin-top: -24px !important;
}*/
    </style>

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
            setStudentDetail();
            $('#title_div_right').css('visibility', 'hidden');

            if (obj_stud_detail[0]['prog_code'] == "1") {
                $('#UG').css('display', 'Block');
                $('#tr_major').css('display', 'none');
                $('#tr_minor').css('display', 'none');
                setCourseDetail();
            }
            else {
                $('#UG').css('display', 'Block');
                setCourseDetail_PG();
            }
            $('tr#first_grade').css('display', 'none');
            display_Grade_Range();
            display_Grade();

            var sum_height;
            var header_height = $('#header_page').height();
            var right_side_panel_height = $('#right_side').height();
            var left_side_panel_height = $('#left_side').height();
            if (right_side_panel_height > left_side_panel_height) {
                right_side_panel_height = $('#right_side').height();
                sum_height = header_height + right_side_panel_height;
            }
            else {
                left_side_panel_height = $('#left_side').height();
                sum_height = header_height + left_side_panel_height;
            }
            var page_outer_height = 1120 - sum_height;
            //$("#footer_div").css('margin-top', page_outer_height + 110 + 'px');
            $("#footer_div").css('margin-top', page_outer_height + 135 + 'px');
            $("td#td_program").css('width', '100px;');
            $("td#name_fo_the_degree").css('width', '100px;');

            var cout_char = $('td#topic').text().length;
            if (cout_char >= 60) {
                $('td#topic').css('line-height', '12.5px');
                $('trtd#topic').css('line-height', '2');
                $('td#topic').css('padding', '10px 1px');
            }
            
            if (obj_transcript_detail != null) {
                if (obj_transcript_detail[0]["degree_code"] != "") {
                    if (obj_stud_detail[0]['prog_code'] == '1') {
                        $('#td_program').html(obj_transcript_detail[0]["degree_name"].toUpperCase());
                    }
                    else {
                        $('#name_fo_the_degree').html(obj_transcript_detail[0]["degree_name"].toUpperCase());
                        $('#td_program').html(obj_transcript_detail[0]["prog_level_name"].toUpperCase());
                    }

                }
                 
                if (obj_transcript_detail[0]["completion_date"] != "") {
                    $('#td_graduation_year').html(obj_transcript_detail[0]["completion_date"]);
                } else {
                    $('#td_graduation_year').html("YET TO COMPLETE");
                }
                $("#label_of_completion").text('DATE OF COMPLETION');
            }
            else {
                $('#td_graduation_year').html("YET TO COMPLETE");
            }

            if ($('#hdn_tab').val() == 'Y') {
                $('title').html('Transcript');
                $('body').css('padding', '0 100px');
                $('div#footer_div').css('margin-top', '0px');
                $('table#address').css('margin-top', '0px');
                var mywindow = window.open('_blank');
                mywindow.document.write(document.getElementsByTagName('html')[0].innerHTML);
            }


        });

        function cout_char(coursecode_name) {

            var leng = coursecode_name.length;
            if (leng >= 56) {
                coursecode_name = coursecode_name.substr(0, 56);
                coursecode_name = coursecode_name + '...';
            }
            return coursecode_name;
        }
        //-------------------Student Dtl-----------------------//
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
                if (obj_stud_detail[0]['prog_code'] == '1') {
                    $('#td_program').html(str_program_new.toUpperCase());//28/08/2019
                }
                else
                {
                    $('#td_program').html(str_program_new.toUpperCase());//28/08/2019

                    $('#name_fo_the_degree').html(obj_stud_detail[0]["degree_name"].toUpperCase());//28/08/2019
                }
                


                //$('#div_program').html("<b>"+str_program.toUpperCase()+"</b>");

                $('#td_name').html((obj_stud_detail[0]["full_name"]).toUpperCase());

                $('#td_rollno').html(obj_stud_detail[0]["user_id"]);

                if (obj_stud_detail[0]['dob'] != '') {
                    //var dob = new Date(obj_transcript_detail[0]["dob"]);
                    var dob = new Date(obj_stud_detail[0]['dob']);
                    //$('#td_dob').html(dob.getDate().toString() + '/' + (dob.getMonth() + 1) + '/' + dob.getFullYear());
                    switch ((dob.getMonth() + 1)) {
                        case 1:
                            mon = "JAN";
                            break;
                        case 2:
                            mon = "FEB";
                            break;
                        case 3:
                            mon = "MAR";
                            break;
                        case 4:
                            mon = "APR";
                            break;
                        case 5:
                            mon = "MAY";
                            break;
                        case 6:
                            mon = "JUN";
                            break;
                        case 7:
                            mon = "JUL";
                            break;
                        case 8:
                            mon = "AUG";
                            break;
                        case 9:
                            mon = "SEP";
                            break;
                        case 10:
                            mon = "OCT";
                            break;
                        case 11:
                            mon = "NOV";
                            break;
                        case 12:
                            mon = "DEC";
                            break;
                        default:
                            mon = "";
                            break;
                    }

                    $('#td_dob').html(dob.getDate().toString() + ' ' + mon + ' ' + dob.getFullYear());
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
                var m_names = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
                var issue_date = new Date();
                $('#spn_issue_date').html(issue_date.getDate() + ' ' + m_names[issue_date.getMonth()] + ' ' + issue_date.getFullYear());

                if (obj_transcript_detail != null) {
                    if (obj_transcript_detail[0]["major"] != null && obj_transcript_detail[0]["major"] != "") {
                        $('#td_major').html((obj_transcript_detail[0]["major"]).toUpperCase());
                    }
                    else {
                        $('#tr_major').css('display', 'none');

                    }


                    if (obj_transcript_detail[0]["minor"] != null && obj_transcript_detail[0]["minor"] != "") {
                        $('#td_minor').html((obj_transcript_detail[0]["minor"]).toUpperCase());
                    }
                    else {
                        $('#tr_minor').css('display', 'none');

                    }
                }//14122020
                else {
                    $('#tr_major').css('display', 'none');
                    $('#tr_minor').css('display', 'none');
                }
            }
            if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                $('#td_previous_degree').html(obj_transcript_detail[0]["previous_degree"]);
                if (obj_transcript_detail[0]["transcript_no"] != '') {
                    $('.spn_transcript_no').html(obj_transcript_detail[0]["transcript_no"]);
                    $('.spn_transcript_no').parent().css('display', '');
                }
            }
            if (obj_stud_detail[0]['prog_code'] == '1')
            {
                $('#name_degree').css('display', 'none');
               
            }
             
            //$('#completed_date').css('display', 'none');
        }
        //-------------------UG Course-----------------------//
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
            var values = 0;
            var values_right = 0;
            var rowcount = 0;
            var strTableCourseDetail_right = "";
            var boolen = false;
            var total_credits_ern = 0;
            var total_credits_count = 0;
            var mandatory_gpa_total = 0;
            var mandatory_nongpa_total = 0;
            var elective_gpa_total = 0;
            var elective_ngpa_total = 0;
            var semester_boolen = true;

            var tcf = 0;
            var elective_ngpa_found = 0;
            var elective_gpa_found = 0;
            var mandatory_nongpa_found = 0;
            var mandatory_gpa_found = 0;

            if (obj_course_detail != null && obj_course_detail != undefined) {

                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                    var obj_course = [];
                    var obj_ws_course = [];

                    if (obj_course_detail[cur_sem]['course_detail'] != "")
                        obj_course = JSON.parse(obj_course_detail[cur_sem]['course_detail']);
                    if (obj_course_detail[cur_sem]['ws_course_detail'] != "")
                        obj_ws_course = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                    if (obj_ws_course.length > 0)
                        obj_ws_course.push({});

                    total_course.push(obj_course.length + obj_ws_course.length);

                    if ((obj_course.length + obj_ws_course.length) > 0)
                        to_semester++;

                    if (cur_sem % 2 == 0) {
                        if (total_course[cur_sem] > table_row_limit['0']) table_row_limit['0'] = total_course[cur_sem];
                    }
                    else {
                        if (total_course[cur_sem] > table_row_limit['1']) table_row_limit['1'] = total_course[cur_sem];
                    }
                }
                 
                if (to_semester > 0)
                    $('#spn_to_semester').html(to_semester);
                if (to_semester < 8)
                    $('#td_graduation_year').html('YET TO COMPLETE');

                var strTableCourseDetail1 = "<table><tr>"

                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {

                    if (obj_course_detail[cur_sem]['course_detail'] != '') {
                        //--------Row Count------------------------//

                        var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);
                        rowcount += cur_sem_courses.length;


                        if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {
                            cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                            rowcount += cur_sem_ws_courses.length + 2;
                        }
                        else {
                            rowcount += 2;
                        }
                        //54
                        if (rowcount < 51) {

                            var fnd_prog = "N";
                            //Check Foundation Course
                            if (cur_sem_courses[0]['course_code'] == "CFP001" || cur_sem_courses[0]['course_code'] == "CFP002" || cur_sem_courses[0]['course_code'] == "CFP003" || cur_sem_courses[0]['course_code'] == "CFP007") {
                                fnd_prog = "Y";
                            }
                            else if (cur_sem_courses[0]['course_code'] == "CFP004" || cur_sem_courses[0]['course_code'] == "CFP005" || cur_sem_courses[0]['course_code'] == "CFP006" || cur_sem_courses[0]['course_code'] == "CFP008" || cur_sem_courses[0]['course_code'] == "CFP009" || cur_sem_courses[0]['course_code'] == "CFP010") {
                                fnd_prog = "Y";
                            }
                            var t_c_found = 0;
                            var elective_ngpa_total_found = 0;
                            var elective_gpa_total_found = 0;
                            var mandatory_nongpa_total_found = 0;
                            var mandatory_gpa_total_found = 0;
                            var f_pass = false;

                            if (fnd_prog == "Y") {
                                var strTableCourseDetail1_found = "";

                                if (values == 0) {
                                    strTableCourseDetail1_found = "<table id='left_table'><tr id='course_dtl'>";
                                    values += 1;
                                }
                                else {
                                    strTableCourseDetail1_found = strTableCourseDetail1_found + "<table id='left_table'><tr>";

                                }
                                if (cur_sem_courses[0]['semester_type'] == 'M') {
                                    strTableCourseDetail1_found = strTableCourseDetail1_found + "<td colspan='4' id='semesteryear'>MONSOON ";
                                    // strTableCourseDetail1_found = strTableCourseDetail1_found + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                    strTableCourseDetail1_found = strTableCourseDetail1_found + cur_sem_courses[0]['year_semester'].toString() + "</td></tr>";

                                }
                                else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                    strTableCourseDetail1_found = strTableCourseDetail1_found + "<td colspan='4' id='semesteryear'>SPRING ";
                                    //strTableCourseDetail1_found = strTableCourseDetail1_found + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                    strTableCourseDetail1_found = strTableCourseDetail1_found + (parseInt(cur_sem_courses[0]['year_semester'].toString())) + "</td></tr>";

                                }

                                var stud_year_code_foundation = obj_stud_detail[0]["year_code"];
                                if (obj_stud_detail[0]["year_code"] == 'Y1') stud_year_code_foundation = 'Y2013';

                                var pass_fail_flag = 1;
                                var total_marks = 0;
                                var total_credits_found = 0;

                                var aggregate = 0;
                                var sem1_pass_aggregate = 50;
                                var sem2_pass_aggregate = 60;
                                var semno = 0;
                                var pass_marks = 50;// for Y2020 and onwards passing marks is 60 - 02112020

                                //$("#CFP_Sem2_Y2017Y2018Y2019_pass_marks").text("60-100");

                                if (stud_year_code_foundation == 'Y2017' || stud_year_code_foundation == 'Y2018' || stud_year_code_foundation == 'Y2019') {
                                    sem1_pass_aggregate = 50;
                                    //$("#CFP_Sem1_Y2017Y2018Y2019_pass_marks").text("50-100");
                                }
                                else if (parseInt(stud_year_code_foundation.slice(1)) >= 2023)
                                {
                                    sem1_pass_aggregate = 55; // for Y2023 and onwards passing marks is 55 - 22012024
                                    pass_marks = 55;
                                }
                                else {
                                    sem1_pass_aggregate = 60;
                                    //$("#CFP_Sem1_Y2017Y2018Y2019_pass_marks").text("60-100");
                                    //$("#CFP_Sem1_Y2017Y2018Y2019_fail_marks").text("0-59");
                                    pass_marks = 60;// for Y2020 and onwards passing marks is 60 - 02112020
                                }

                                if (stud_year_code_foundation == 'Y2019') {
                                    sem2_pass_aggregate = 65;
                                    //$("#CFP_Sem2_Y2017Y2018Y2019_pass_marks").text("60-100");//65 instead of 60 Mahroofbhai Call - 14 08 2020
                                }

                                //11092020 CFP Marks Grade Change like M 2019 and onwards
                                var grade_style = "OLD";
                                if (stud_year_code_foundation >= "Y2019") {
                                    if ($('#hdn_sem').val() != "S" && parseInt($('#hdn_year').val()) != 2019 || $('#hdn_sem').val() == "S" && parseInt($('#hdn_year').val()) > 2019
                                        || $('#hdn_sem').val() == "M" && parseInt($('#hdn_year').val()) >= 2019) {
                                        grade_style = "NEW";
                                    }
                                }
                                //11092020 CFP Marks Grade Change like M 2019 and onwards

                                //var elective_ngpa_total_found = 0;
                                //var elective_gpa_total_found = 0;
                                //var mandatory_nongpa_total_found = 0;
                                //var mandatory_gpa_total_found = 0;

                                if (grade_style == "OLD") {
                                    if (cur_sem_courses != null && cur_sem_courses != undefined) {

                                        for (var i = 0; i < cur_sem_courses.length; i++) {
                                            semester_boolen = false;

                                            //-------------Course Code and Course Name Changes-------------------// 
                                            var coursecode_leg = cur_sem_courses[i]['course_code'].length;
                                            var coursecode_name = cur_sem_courses[i]['course_code'] + " " + cur_sem_courses[i]['course_name'];
                                            var coursename_code = cout_char(coursecode_name)
                                            coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);
                                            //----------------Course Type -------------------------------------//
                                            if (cur_sem_courses[i]['c_type'] == 'E') {
                                                //Design
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                                //-------------------Check GPA & NGPA----------------------//
                                                if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                                    elective_ngpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                                else {
                                                    elective_gpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                            }
                                            else {
                                                //-------------------Check GPA & NGPA----------------------//
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                                if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                                    mandatory_nongpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                                else {
                                                    mandatory_gpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                            }

                                            //------------------Course Credits & grade ------------------------//
                                            strTableCourseDetail1_found = strTableCourseDetail1_found + "<td class= 'col_dtl'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                                "<td class= 'col_dtl'>P</td>";

                                            if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                            }
                                            else {
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_courses[i]['grade_point'], 2), 1) + "</td>";
                                            }

                                            strTableCourseDetail1_found = strTableCourseDetail1_found + "</tr>";
                                            semester_boolen = true;

                                            if (!(parseInt(cur_sem_courses[i]['Total']) >= 45)) {
                                                pass_fail_flag = pass_fail_flag * 0;
                                            }
                                            else {
                                                //window.total_earned_credit += parseInt(cur_sem_courses[i]['course_credits']);
                                                //if (cur_sem_courses[i]['c_type'] == 'M') {
                                                //    window.core_cr += parseInt(cur_sem_courses[i]['course_credits']);
                                                //}
                                                //else {
                                                //    window.ele_cr += parseInt(cur_sem_courses[i]['course_credits']);
                                                //}
                                            }

                                            if (cur_sem_courses[i]['course_code'] == 'CFP001') {
                                                semno = 1;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP002') {
                                                semno = 1;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP003') {
                                                semno = 1;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP007') {
                                                semno = 1;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP004') {
                                                semno = 2;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP005') {
                                                semno = 2;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP006') {
                                                semno = 2;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP008') {
                                                semno = 2;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP009') {
                                                semno = 2;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP010') {
                                                semno = 2;
                                                total_marks += (parseInt(cur_sem_courses[i]['Total']) * parseInt(cur_sem_courses[i]['course_credits']));
                                            }

                                            total_credits_found += parseInt(cur_sem_courses[i]['course_credits']);
                                        }

                                        t_c_found = total_credits_found;

                                        aggregate = total_marks / total_credits_found;

                                        final_aggregate = parseInt(aggregate.toFixed(0));

                                        if (pass_fail_flag) {
                                            if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                                                //$('#spn_pass_fail_new').html('PASS');
                                                strTableCourseDetail1 += strTableCourseDetail1_found;
                                                f_pass = true;
                                                tcf += t_c_found;
                                                elective_ngpa_found += elective_ngpa_total_found;
                                                elective_gpa_found += elective_gpa_total_found;
                                                mandatory_nongpa_found += mandatory_nongpa_total_found;
                                                mandatory_gpa_found += mandatory_gpa_total_found;

                                                //elective_ngpa_total = elective_ngpa_total_found;
                                                //elective_gpa_total = elective_gpa_total_found;
                                                //mandatory_nongpa_total = mandatory_nongpa_total_found;
                                                //mandatory_gpa_total = mandatory_gpa_total_found;
                                            }
                                            else {
                                                //$('#spn_pass_fail_new').html('FAIL');
                                                //window.total_earned_credit = 0;
                                                //window.core_cr = 0;
                                                //window.ele_cr = 0;
                                            }
                                        }
                                        else {
                                            //$('#spn_pass_fail_new').html('FAIL');
                                            //window.total_earned_credit = 0;
                                            //window.core_cr = 0;
                                            //window.ele_cr = 0;
                                        }

                                    }
                                } else if (grade_style == "NEW") {
                                    if (cur_sem_courses != null && cur_sem_courses != undefined) {
                                        
                                        for (var i = 0; i < cur_sem_courses.length; i++) {
                                            semester_boolen = false;

                                            //-------------Course Code and Course Name Changes-------------------// 
                                            var coursecode_leg = cur_sem_courses[i]['course_code'].length;
                                            var coursecode_name = cur_sem_courses[i]['course_code'] + " " + cur_sem_courses[i]['course_name'];
                                            var coursename_code = cout_char(coursecode_name)
                                            coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);
                                            //----------------Course Type -------------------------------------//
                                            if (cur_sem_courses[i]['c_type'] == 'E') {
                                                //Design
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                                //-------------------Check GPA & NGPA----------------------//
                                                if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                                    elective_ngpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                                else {
                                                    elective_gpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                            }
                                            else {
                                                //-------------------Check GPA & NGPA----------------------//
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                                if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                                    mandatory_nongpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                                else {
                                                    mandatory_gpa_total_found += parseInt(cur_sem_courses[i]['course_credits']);
                                                }
                                            }

                                            //------------------Course Credits & grade ------------------------//
                                            strTableCourseDetail1_found = strTableCourseDetail1_found + "<td class= 'col_dtl'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                                "<td class= 'col_dtl'>P</td>";

                                            if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                            }
                                            else {
                                                strTableCourseDetail1_found = strTableCourseDetail1_found + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_courses[i]['grade_point'], 2), 1) + "</td>";
                                            }

                                            strTableCourseDetail1_found = strTableCourseDetail1_found + "</tr>";
                                            semester_boolen = true;

                                            if (cur_sem_courses[i]['course_code'] == 'CFP001') {
                                                semno = 1;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP002') {
                                                semno = 1;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP003') {
                                                semno = 1;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP007') {
                                                semno = 1;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP004') {
                                                semno = 2;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP005') {
                                                semno = 2;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP006') {
                                                semno = 2;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP008') {
                                                semno = 2;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP009') {
                                                semno = 2;
                                            }
                                            else if (cur_sem_courses[i]['course_code'] == 'CFP010') {
                                                semno = 2;
                                            }

                                            if (semno == 1) {
                                                if (!(parseInt(cur_sem_courses[i]['Total']) >= pass_marks)) {// for Y2020 and onwards passing marks is 60 - 02112020
                                                    if (pass_fail_flag != 0) {
                                                        pass_fail_flag = pass_fail_flag * 0;
                                                    }
                                                }
                                                //else {
                                                //    window.total_earned_credit += parseInt(cur_sem_courses[i]['course_credits']);
                                                //    if (cur_sem_courses[i]['c_type'] == 'M') {
                                                //        window.core_cr += parseInt(cur_sem_courses[i]['course_credits']);
                                                //    }
                                                //    else {
                                                //        window.ele_cr += parseInt(cur_sem_courses[i]['course_credits']);
                                                //    }
                                                //}
                                            } else if (semno == 2) {
                                                if (!(parseInt(cur_sem_courses[i]['Total']) >= 60)) {
                                                    if (pass_fail_flag != 0) {
                                                        pass_fail_flag = pass_fail_flag * 0;
                                                    }
                                                }
                                                //else {
                                                //    window.total_earned_credit += parseInt(cur_sem_courses[i]['course_credits']);
                                                //    if (cur_sem_courses[i]['c_type'] == 'M') {
                                                //        window.core_cr += parseInt(cur_sem_courses[i]['course_credits']);
                                                //    }
                                                //    else {
                                                //        window.ele_cr += parseInt(cur_sem_courses[i]['course_credits']);
                                                //    }
                                                //}
                                            }


                                            total_credits_found += parseInt(cur_sem_courses[i]['course_credits']);
                                        }

                                        t_c_found = total_credits_found;

                                        if (pass_fail_flag) {
                                            //$('#spn_pass_fail_new').html('PASS);
                                            strTableCourseDetail1 += strTableCourseDetail1_found;
                                            f_pass = true;
                                            tcf += t_c_found;
                                            elective_ngpa_found += elective_ngpa_total_found;
                                            elective_gpa_found += elective_gpa_total_found;
                                            mandatory_nongpa_found += mandatory_nongpa_total_found;
                                            mandatory_gpa_found += mandatory_gpa_total_found;
                                        }
                                        else {
                                            //$('#spn_pass_fail_new').html('FAIL');
                                            //window.total_earned_credit = 0;
                                            //window.core_cr = 0;
                                            //window.ele_cr = 0;
                                        }
                                    }
                                }

                            }
                            else {

                                if (values == 0) {
                                    strTableCourseDetail1 = "<table id='left_table'><tr id='course_dtl'>";
                                    values += 1;
                                }
                                else {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<table id='left_table'><tr>";

                                }
                                if (cur_sem_courses[0]['semester_type'] == 'M') {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>MONSOON ";
                                    // strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                    strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "</td></tr>";

                                }
                                else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>SPRING ";
                                    //strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                    strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString())) + "</td></tr>";

                                }

                                for (var i = 0; i < cur_sem_courses.length; i++) {
                                    semester_boolen = false;

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

                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                        }
                                    }

                                    //-------------Course Code and Course Name Changes-------------------// 
                                    var coursecode_leg = cur_sem_courses[i]['course_code'].length;
                                    var coursecode_name = cur_sem_courses[i]['course_code'] + " " + cur_sem_courses[i]['course_name'];
                                    var coursename_code = cout_char(coursecode_name)
                                    coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);
                                    //----------------Course Type -------------------------------------//
                                    if (cur_sem_courses[i]['c_type'] == 'E') {

                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        //-------------------Check GPA & NGPA----------------------//
                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        //-------------------Check GPA & NGPA----------------------//
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                        if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                        }
                                    }

                                    //------------------Course Credits & grade ------------------------//
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                        "<td class= 'col_dtl'>" + cur_sem_courses[i]['grade'] + "</td>";

                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }

                                    strTableCourseDetail1 = strTableCourseDetail1 + "</tr>";
                                    semester_boolen = true;
                                }
                            }


                            // }//New

                            //----------------WS Course Details--------------------------//
                            if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {
                                var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);
                                //------------Row count-------------------------------------//
                                //rowcount += cur_sem_ws_courses.length;

                                for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                    //---------------------Course Name and Course Code-----------------//
                                    var coursecode_leg = cur_sem_ws_courses[i]['course_code'].length;
                                    var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });
                                    var coursecode_name = cur_sem_ws_courses[i]['course_code'] + " " + str_course_name;
                                    var coursename_code = cout_char(coursecode_name)
                                    coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);
                                    //New Condition
                                    if (semester_boolen == false) {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<table><tr>";
                                        if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>MONSOON ";
                                            // strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_ws_courses[0]['year_semester'].toString() + "</td></tr>";

                                        }
                                        else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>SPRING ";
                                            //strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_ws_courses[0]['year_semester'].toString())) + "</td></tr>";

                                        }
                                    }

                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        //----------------------Check Course Type----------------------//
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    //---------------Check Credits and grade and grade_Point--------------//

                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail1 = strTableCourseDetail1 + "</tr>";
                                }
                            }

                            if (fnd_prog == "Y") {
                                if (f_pass) {
                                    //----------------------Course Credit Details--------------------------//
                                    if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                        var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);
                                        if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<tfoot id='footer'>" +
                                                "<tr><td></td><td>" + t_c_found + "</td>";
                                        }

                                        var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                        if (sgpa == 'NaN') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td></td></tr></tfoot>";
                                        }
                                        else {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td>" + sgpa + "</td></tr></tfoot>";
                                        }
                                    }
                                }
                            } else {
                                //----------------------Course Credit Details--------------------------//
                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);
                                    if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tfoot id='footer'>" +
                                            "<tr><td></td><td>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";
                                    }

                                    var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                    if (sgpa == 'NaN') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td></td></tr></tfoot>";
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td>" + sgpa + "</td></tr></tfoot>";
                                    }
                                }
                            }
                            strTableCourseDetail1 = strTableCourseDetail1 + "</table>"
                        }

                        else {
                            $('#title_div_right').css('visibility', 'visible');
                            boolen = true;
                            //----------------Row Count ------------------//
                            if (values_right == 0) {
                                strTableCourseDetail_right = "<table id='right_table'><tr>"
                                values_right += 1;
                            }
                            else {
                                strTableCourseDetail_right = strTableCourseDetail_right + "<table id='right_table'><tr>";
                            }

                            //-------------Semester Type -------------------------//
                            if (cur_sem_courses[0]['semester_type'] == 'M') {
                                strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>MONSOON ";
                                strTableCourseDetail_right = strTableCourseDetail_right + cur_sem_courses[0]['year_semester'].toString() + "</td></tr>";

                            }
                            else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>SPRING ";
                                strTableCourseDetail_right = strTableCourseDetail_right + (parseInt(cur_sem_courses[0]['year_semester'].toString())) + "</td></tr>";

                            }

                            //-----------------------GPA NGPA-------------------------//

                            for (var i = 0; i < cur_sem_courses.length; i++) {
                                //semester_boolen = false;
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

                                if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                    }
                                }

                                //--------------------Course Code and Name -------------------------//
                                var coursecode_leg = cur_sem_courses[i]['course_code'].length;
                                var coursecode_name = cur_sem_courses[i]['course_code'] + " " + cur_sem_courses[i]['course_name'];
                                var coursename_code = cout_char(coursecode_name);
                                coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);

                                if (cur_sem_courses[i]['c_type'] == 'E') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        elective_ngpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                    else {
                                        elective_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                }
                                else {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";
                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        mandatory_nongpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                    else {
                                        mandatory_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                }

                                strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                    "<td class= 'col_dtl'>" + cur_sem_courses[i]['grade'] + "</td>";

                                if (cur_sem_courses[i]['grade_point'] == 'NA') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                }
                                else {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_courses[i]['grade_point'], 2), 1) + "</td>";
                                }
                                strTableCourseDetail_right = strTableCourseDetail_right + "</tr>";
                                semester_boolen = true
                            }

                            //------------------ws_course_dtl-----------------------//
                            if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {

                                var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);
                                rowcount += cur_sem_ws_courses.length;
                                for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                    //------------------Course Code and Name--------------------------//    
                                    var coursecode_leg = cur_sem_ws_courses[i]['course_code'].length;
                                    var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });
                                    var coursecode_name = cur_sem_ws_courses[i]['course_code'] + " " + str_course_name;
                                    var coursename_code = cout_char(coursecode_name);
                                    coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);

                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail_right = strTableCourseDetail_right + "</tr>";
                                }
                            }

                            //---------------Course Credit-------------------------//
                            if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<tfoot id='footer'>" +
                                        "<tr><td style='width:85%;'></td><td style='width:5%;'>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";

                                }

                                var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                if (sgpa == 'NaN') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td style='width:5%;'></td><td style='width:5%;'></td></tr></tfoot>";
                                }
                                else {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td style='width:5%;'></td><td style='width:5%;'>" + sgpa + "</td></tr></tfoot>";
                                }
                            }
                            strTableCourseDetail_right = strTableCourseDetail_right + "</table>"

                        }

                    }//course dtl

                    //--------------------------WS Course Dtl----------------------------//
                    else {
                        var ss = 0;
                        if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {
                            //----------------------------------Right Side Data---------------------------------//
                            var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);
                            rowcount += cur_sem_ws_courses.length + 2;
                            for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                //------------------Course Code and Name--------------------------//    
                                var coursecode_leg = cur_sem_ws_courses[i]['course_code'].length;
                                var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });
                                var coursecode_name = cur_sem_ws_courses[i]['course_code'] + " " + str_course_name;
                                var coursename_code = cout_char(coursecode_name);
                                coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);
                                //54
                                if (rowcount < 51) {
                                    if (values == 0) {
                                        strTableCourseDetail1 = "<table><tr id='course_dtl'>";
                                        values += 1;
                                    }
                                    else {
                                        //changes 25112022
                                        if (i == 0) {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<table><tr>"
                                        }
                                        else {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<tr>"
                                        }

                                        //strTableCourseDetail1 = strTableCourseDetail1 + "<table><tr>";
                                    }

                                    if (i == 0) {
                                        if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>MONSOON ";
                                            // strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_ws_courses[0]['year_semester'].toString() + "</td></tr>";

                                        }
                                        else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>SPRING ";
                                            //strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_ws_courses[0]['year_semester'].toString())) + "</td></tr>";

                                        }
                                    }



                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        //----------------------Check Course Type----------------------//
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }

                                    }

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    //---------------Check Credits and grade and grade_Point--------------//

                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail1 = strTableCourseDetail1 + "</tr>";

                                    //----------------------Course Credit Details Left Side --------------------------//
                                    //25112022
                                    if (i == cur_sem_ws_courses.length - 1) {
                                        if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                            var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);
                                            if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                                strTableCourseDetail1 = strTableCourseDetail1 + "<tfoot id='footer'>" +
                                                    "<tr><td></td><td>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";
                                            }

                                            var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                            if (sgpa == 'NaN') {
                                                strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td></td></tr></tfoot>";
                                            }
                                            else {
                                                strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td>" + sgpa + "</td></tr></tfoot>";
                                            }
                                        }

                                        strTableCourseDetail1 = strTableCourseDetail1 + "</table>"
                                    }
                                }
                                else {

                                    if (values_right == 0) {
                                        strTableCourseDetail_right = "<table><tr>"

                                        values_right += 1;
                                    }
                                    else {
                                        if (i == 0) {
                                            strTableCourseDetail_right = strTableCourseDetail_right + "<table><tr>"

                                        }
                                        else {
                                            strTableCourseDetail_right = strTableCourseDetail_right + "<tr>"
                                        }

                                        //strTableCourseDetail_right = strTableCourseDetail_right + "<tr>"
                                    }
                                    if (i == 0) {
                                        if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                            strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>MONSOON ";
                                            // strTableCourseDetail_right = strTableCourseDetail_right + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail_right = strTableCourseDetail_right + cur_sem_ws_courses[0]['year_semester'].toString() + "</td></tr>";

                                        }
                                        else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                            strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>SPRING ";
                                            //strTableCourseDetail_right = strTableCourseDetail_right + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail_right = strTableCourseDetail_right + (parseInt(cur_sem_ws_courses[0]['year_semester'].toString())) + "</td></tr>";

                                        }

                                    }

                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        //------------------------------Left Side Data--------------------------------//
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail_right = strTableCourseDetail_right + "</tr>";


                                    //---------------Course Credit Right Side-------------------------//
                                    if (i == cur_sem_ws_courses.length - 1) {
                                        if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                            var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                            if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                                strTableCourseDetail_right = strTableCourseDetail_right + "<tfoot id='footer'>" +
                                                    "<tr><td></td><td>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";

                                            }

                                            var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                            if (sgpa == 'NaN') {
                                                strTableCourseDetail_right = strTableCourseDetail_right + "<td></td><td></td></tr></tfoot>";
                                            }
                                            else {
                                                strTableCourseDetail_right = strTableCourseDetail_right + "<td></td><td>" + sgpa + "</td></tr></tfoot>";
                                            }
                                        }
                                        strTableCourseDetail_right = strTableCourseDetail_right + "</table>"
                                    }
                                }
                            }
                        }
                    }
                }

                var total_core_credit = 0;
                var total_elective_credit = 0;
                var total_ngpa_credit = 0;
                var total_cgpa = 0;
                var core_ngpa_credit = 0;
                var total_gpa_credit_ern = 0;
                var m_gpa_credit = 0;
                var m_ngpa_credit = 0;
                var total_sws_m_gpa_credit = 0;
                var total_sws_m_ngpa_credit = 0;
                var total_sws_gpa_credit = 0;
                var total_sws_ngpa_credit = 0;
                var found_added = false;

                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                    var obj_course_credit = [];

                    if (obj_course_detail[cur_sem]['credit_detail'] != "") {
                        obj_course_credit = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);
                        //abc
                        
                        if (obj_course_credit[0]['type'] == "F") {

                            if (!found_added) {
                                total_credits_ern += parseInt(tcf);

                                total_core_credit += parseInt(mandatory_gpa_found + mandatory_nongpa_found);
                                m_gpa_credit += parseInt(mandatory_gpa_found);
                                m_ngpa_credit += parseInt(mandatory_nongpa_found);

                                core_ngpa_credit += parseInt(elective_gpa_found + elective_ngpa_found);

                                total_elective_credit += parseInt(elective_gpa_found);
                                total_ngpa_credit += parseInt(elective_ngpa_found);
                            }

                            found_added = true;

                            total_sws_m_gpa_credit += parseInt(obj_course_credit[0]['sws_m_gpa_credit']);
                            total_sws_m_ngpa_credit += parseInt(obj_course_credit[0]['sws_m_ngpa_credit']);
                            total_sws_gpa_credit += parseInt(obj_course_credit[0]['sws_gpa_credit']);
                            total_sws_ngpa_credit += parseInt(obj_course_credit[0]['sws_ngpa_credit']);
                        }
                        else {

                            total_credits_ern += parseInt(obj_course_credit[0]['total_credit']);

                            total_core_credit += parseInt(obj_course_credit[0]['core_credit']);
                            m_gpa_credit += parseInt(obj_course_credit[0]['m_gpa_credit']);
                            m_ngpa_credit += parseInt(obj_course_credit[0]['m_ngpa_credit']);

                            core_ngpa_credit += parseInt(obj_course_credit[0]['elective_credit']);

                            total_elective_credit += parseInt(obj_course_credit[0]['gpa_credit']);
                            total_ngpa_credit += parseInt(obj_course_credit[0]['ngpa_credit']);

                            total_sws_m_gpa_credit += parseInt(obj_course_credit[0]['sws_m_gpa_credit']);
                            total_sws_m_ngpa_credit += parseInt(obj_course_credit[0]['sws_m_ngpa_credit']);
                            total_sws_gpa_credit += parseInt(obj_course_credit[0]['sws_gpa_credit']);
                            total_sws_ngpa_credit += parseInt(obj_course_credit[0]['sws_ngpa_credit']);
                        }
                    }

                }
                
                if (total_GPA_credits != 0 && total_credits != 0) {

                    total_cgpa = parseFloat(total_GPA_credits / total_credits).toFixed(1);

                }

                rowcount += 12;
                //if (boolen == true)//54
                if (rowcount > 51) {

                    $('#left_side').html(strTableCourseDetail1);

                    if (obj_transcript_detail != null) {
                        if (values_right != 0) {
                            strTableCourseDetail_right = strTableCourseDetail_right;
                        }

                        //strTableCourseDetail_right = strTableCourseDetail_right == undefined ? '' : strTableCourseDetail_right;

                        $('#title_div_right').css('visibility', 'visible');
                        //strTableCourseDetail_right = strTableCourseDetail_right + "<table id ='prg_summ' style='padding: 0; line-height: 19px; margin-bottom:15px; margin-top:5px;'><tr>" +
                        //    "<td colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left;font-size:15px;'>THESIS DETAILS</td></tr>" +
                        //    "<tr><td colspan=1 style='text-align: left;font-size:15px;' id='topic'><b>" + obj_transcript_detail[0]['topic_type'] + " TOPIC : </b>" + obj_transcript_detail[0]['dissertation_topic'] + "</td></tr>" +
                        //    "<tr><td colspan=1 style='text-align: left;font-size:15px;' id='super'><b>" + obj_transcript_detail[0]['topic_type'] + " SUPERVISOR : </b>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td></tr></table>";

                        if (obj_transcript_detail[0]['topic_type'] != "" || obj_transcript_detail[0]['dissertation_topic'] != "") {
                            strTableCourseDetail_right = strTableCourseDetail_right + "<table id ='prg_summ' style='padding: 0; line-height: 19px; margin-bottom:15px; margin-top:5px;'><tr>" +
                                "<td colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left;font-size:15px;'>" + obj_transcript_detail[0]['topic_type'] + " DETAILS</td></tr>" +
                                "<tr><td colspan=1 style='text-align: left;font-size:15px;' id='topic'><b>TITLE:   </b>" + obj_transcript_detail[0]['dissertation_topic'] + "</td></tr>" +
                                "</table>";//<tr><td colspan=1 style='text-align: left;font-size:15px;' id='super'><b>SUPERVISOR:  </b>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td></tr>//Mayur 07012021
                        }
                    }
                    $('#title_div_right').css('visibility', 'visible');

                    if (strTableCourseDetail_right != undefined) {
                        strTableCourseDetail_right = strTableCourseDetail_right + "<table id='prg_summ' style='padding: 0; line-height: 19px;'><tr>" +
                            "<td colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left; font-size:15px;'>PROGRAM SUMMARY</td></tr>" +
                            "<tr><td class='program_td' colspan=3>Total Credits Earned</td><td class='program_td'>" + total_credits_ern + "</td></tr>" +
                            "<tr><td class='program_td' id='mand_gpa' colspan=3>Mandatory GPA</td><td class='program_td' id='mand_gpa_no'>" + parseInt(m_gpa_credit + total_sws_m_gpa_credit) + "</td></tr>" +
                            "<tr> <td class='program_td' id='mand_ngpa' colspan='3'>Mandatory NGPA</td><td class='program_td' id='mand_ngpa_no'>" + parseInt(m_ngpa_credit + total_sws_m_ngpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' id='elec_gpa' colspan='3'>Elective GPA</td><td class='program_td' id='elec_gpa_no'>" + parseInt(total_elective_credit + total_sws_gpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' id='elec_ngpa' colspan='3'>Elective NGPA</td><td class='program_td' id='elec_ngpa_no'>" + parseInt(total_ngpa_credit + total_sws_ngpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' id='total_gpa_cre' colspan='3'>Total GPA Credits Earned</td><td class='program_td' id='total_gpa_no'>" + parseInt(m_gpa_credit + total_elective_credit + total_sws_m_gpa_credit + total_sws_gpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' colspan='3'>Cumulative Grade Point Average (CGPA) </td><td class='program_td' id='total_cgpa'>" + total_cgpa + "</td></tr>"
                    }
                    else {

                        strTableCourseDetail_right = "<table id='prg_summ' style='padding: 0; line-height: 19px;'><tr>" +
                            "<td colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left; font-size:15px;'>PROGRAM SUMMARY</td></tr>" +
                            "<tr><td class='program_td' colspan=3>Total Credits Earned</td><td class='program_td'>" + total_credits_ern + "</td></tr>" +
                            "<tr><td class='program_td' id='mand_gpa' colspan=3>Mandatory GPA</td><td class='program_td' id='mand_gpa_no'>" + parseInt(m_gpa_credit + total_sws_m_gpa_credit) + "</td></tr>" +
                            "<tr> <td class='program_td' id='mand_ngpa' colspan='3'>Mandatory NGPA</td><td class='program_td' id='mand_ngpa_no'>" + parseInt(m_ngpa_credit + total_sws_m_ngpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' id='elec_gpa' colspan='3'>Elective GPA</td><td class='program_td' id='elec_gpa_no'>" + parseInt(total_elective_credit + total_sws_gpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' id='elec_ngpa' colspan='3'>Elective NGPA</td><td class='program_td' id='elec_ngpa_no'>" + parseInt(total_ngpa_credit + total_sws_ngpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' id='total_gpa_cre' colspan='3'>Total GPA Credits Earned</td><td class='program_td' id='total_gpa_no'>" + parseInt(m_gpa_credit + total_elective_credit + total_sws_m_gpa_credit + total_sws_gpa_credit) + "</td></tr>" +
                            "<tr><td class='program_td' colspan='3'>Cumulative Grade Point Average (CGPA) </td><td class='program_td' id='total_cgpa'>" + total_cgpa + "</td></tr>"
                    }
                    strTableCourseDetail_right = strTableCourseDetail_right + "</table>";

                    $('#right_side').html(strTableCourseDetail_right);

                }
                else {
                    if (obj_transcript_detail != null) {
                        //strTableCourseDetail1 = strTableCourseDetail1 + "<table id ='prg_summ' style='padding: 0; line-height: 19px; margin-bottom:15px; margin-top:5px;'><tr>" +
                        //    "<td class='program_td' colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left;font-size:15px;'>THESIS DETAILS</td></tr>" +
                        //    "<tr><td class='program_td' colspan=1 style='text-align: left;font-size:15px;' id='topic'><b>" + obj_transcript_detail[0]['topic_type'] + " TOPIC : </b>" + obj_transcript_detail[0]['dissertation_topic'] + "</td></tr>" +
                        //    "<tr><td class='program_td' colspan=1 style='text-align: left;font-size:15px;'><b>" + obj_transcript_detail[0]['topic_type'] + " SUPERVISOR : </b>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td></tr></table>";
                        if (obj_transcript_detail[0]['topic_type'] != "" || obj_transcript_detail[0]['dissertation_topic'] != "") {
                            strTableCourseDetail1 = strTableCourseDetail1 + "<table id ='prg_summ' style='padding: 0; line-height: 19px; margin-bottom:15px; margin-top:5px;'><tr>" +
                                "<td class='program_td' colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left;font-size:15px;'>" + obj_transcript_detail[0]['topic_type'] + " DETAILS</td></tr>" +
                                "<tr><td class='program_td' colspan=1 style='text-align: left;font-size:15px;' id='topic'><b>TITLE:   </b>" + obj_transcript_detail[0]['dissertation_topic'] + "</td></tr>" +
                                "</table>";//<tr><td class='program_td' colspan=1 style='text-align: left;font-size:15px;'><b>SUPERVISOR:  </b>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td></tr>//Mayur 07012021
                        }
                    }
                    strTableCourseDetail1 = strTableCourseDetail1 + "<table id='prg_summ' style='padding: 0; line-height: 19px;'><tr>" +
                        "<td colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left;font-size:15px;'>PROGRAM SUMMARY</td></tr>" +
                        "<tr><td class='program_td' colspan=3>Total Credits Earned</td><td class='program_td'>" + total_credits_ern + "</td></tr>" +
                        "<tr><td class='program_td' id='mand_gpa' colspan=3>Mandatory GPA</td><td class='program_td' id='mand_gpa_no'>" + parseInt(m_gpa_credit + total_sws_m_gpa_credit) + "</td></tr>" +
                        "<tr><td class='program_td' id='mand_ngpa' colspan='3'>Mandatory NGPA</td><td class='program_td' id='mand_ngpa_no'>" + parseInt(m_ngpa_credit + total_sws_m_ngpa_credit) + "</td></tr>" +
                        "<tr><td class='program_td' id='elec_gpa' colspan='3'>Elective GPA</td><td class='program_td' id='elec_gpa_no'>" + parseInt(total_elective_credit + total_sws_gpa_credit) + "</td></tr>" +
                        "<tr><td class='program_td' id='elec_ngpa' colspan='3'>Elective NGPA</td><td class='program_td' id='elec_ngpa_no'>" + parseInt(total_ngpa_credit + total_sws_ngpa_credit) + "</td></tr>" +
                        "<tr><td class='program_td' id='total_gpa_cre' colspan='3'>Total GPA Credits Earned</td><td class='program_td' id='total_gpa_no'>" + parseInt(m_gpa_credit + total_elective_credit + total_sws_m_gpa_credit + total_sws_gpa_credit) + "</td></tr>" +
                        "<tr><td class='program_td' colspan='3'>Cumulative Grade Point Average (CGPA) </td><td class='program_td' id='total_cgpa'>" + total_cgpa + "</td></tr>"

                    strTableCourseDetail1 = strTableCourseDetail1 + "</table>";
                    $('#left_side').html(strTableCourseDetail1);
                }

                if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                    if (obj_stud_detail[0]['dept_name'].toUpperCase() == 'PLANNING' && obj_stud_detail[0]['prog_name'].toUpperCase() == 'PG')
                    {
                        var str_degree = 'MASTER OF PLANNING';

                        if (obj_transcript_detail[0]['specialization'] != '') str_degree += ' (' + obj_transcript_detail[0]['specialization'] + ')';

                        $('#name_fo_the_degree').html(str_degree.toUpperCase());
                    }

                    if (obj_stud_detail[0]['prog_code'] == '1') {
                        if (obj_transcript_detail[0]['name_of_the_degree'] != '')
                            $('#td_program').html(obj_transcript_detail[0]['name_of_the_degree'].toUpperCase());
                    }
                    else
                    {
                        if (obj_transcript_detail[0]['name_of_the_degree'] != '')
                            $('#name_fo_the_degree').html(obj_transcript_detail[0]['name_of_the_degree'].toUpperCase());
                        if (obj_transcript_detail[0]['prog_level_name'] != '')
                            $('#td_program').html(obj_transcript_detail[0]['prog_level_name'].toUpperCase());
                    }
                    
                     
                    if (obj_transcript_detail[0]['graduation_year'] != '') {
                        $('#td_graduation_year').html(obj_transcript_detail[0]['graduation_year'].toUpperCase());
                    } else {
                        $('#td_graduation_year').html("YET TO COMPLETE");
                    }
                }


            }
        }
        //-------------------PG Course-----------------------//
        function setCourseDetail_PG() {

            $('#title_div_right').css('visibility', 'visible');
            var aggregate_marks = 0;
            var total_GPA_marks = 0;
            var total_GPA_credits = 0;
            var total_credits = 0;
            var total_table = 6;
            var sem_cnt = 0;
            var table_row_limit = { '0': 0, '1': 0 };
            var total_course = [];
            var to_semester = 0;
            var values = 0;
            var values_right = 0;
            var rowcount = 0;
            var strTableCourseDetail_right ="";
            var boolen = false;
            var total_credits_ern = 0;
            var total_credits_count = 0;
            var mandatory_gpa_total = 0;
            var mandatory_nongpa_total = 0;
            var elective_gpa_total = 0;
            var elective_ngpa_total = 0;
            var semester_boolen = true;
            var table_margin_left = 0;
            var table_margin_right = 0;
            var arry_len = [];

            if (obj_course_detail != null && obj_course_detail != undefined) {

                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                    var obj_course = [];
                    var obj_ws_course = [];

                    if (obj_course_detail[cur_sem]['course_detail'] != "")
                        obj_course = JSON.parse(obj_course_detail[cur_sem]['course_detail']);
                    if (obj_course_detail[cur_sem]['ws_course_detail'] != "")
                        obj_ws_course = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                    if (obj_ws_course.length > 0)
                        obj_ws_course.push({});

                    total_course.push(obj_course.length + obj_ws_course.length);

                    if ((obj_course.length + obj_ws_course.length) > 0)
                        to_semester++;

                    if (cur_sem % 2 == 0) {
                        if (total_course[cur_sem] > table_row_limit['0']) table_row_limit['0'] = total_course[cur_sem];
                    }
                    else {
                        if (total_course[cur_sem] > table_row_limit['1']) table_row_limit['1'] = total_course[cur_sem];
                    }
                }
                 
                if (to_semester > 0)
                    $('#spn_to_semester').html(to_semester);
                if (to_semester < 8)
                    $('#td_graduation_year').html('YET TO COMPLETE');

                var strTableCourseDetail1 = "<table><tr>"
                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {

                    if (obj_course_detail[cur_sem]['course_detail'] != '') {
                        //--------Row Count------------------------//

                        var cur_sem_courses = JSON.parse(obj_course_detail[cur_sem]['course_detail']);
                        rowcount += cur_sem_courses.length;


                        if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {
                            cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);

                            rowcount += cur_sem_ws_courses.length + 2;
                            arry_len.push(rowcount);
                        }
                        else {
                            rowcount += 2;
                            arry_len.push(rowcount);
                        }

                        if (cur_sem % 2 == 0) {
                            if (values == 0) {
                                strTableCourseDetail1 = "<table id='left_table'><tr id='course_dtl'>";
                                values += 1;
                            }
                            else {
                                //strTableCourseDetail1 = strTableCourseDetail1 + "<table id='left_table'><tr>";
                                var left_side_row_count_course = arry_len[0]; //= JSON.parse(obj_course_detail[cur_sem - 2]['course_detail']).length;
                                var right_side_row_count_course_;

                                if (arry_len[1] > arry_len[0]) {
                                    right_side_row_count_course_ = arry_len[1] - arry_len[0];
                                }
                                else {
                                    right_side_row_count_course_ = arry_len[0] - arry_len[1];
                                }
                                if (left_side_row_count_course == right_side_row_count_course_) {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<table id='left_table'><tr>";
                                }
                                else {
                                    var values_count;
                                    if (left_side_row_count_course < right_side_row_count_course_) {
                                        values_count = right_side_row_count_course_ - left_side_row_count_course;
                                        //values_count = values_count + 2;
                                        //values_count = values_count * 13.5;
                                        values_count = values_count * 21;
                                        values_count = values_count + 7;

                                        strTableCourseDetail1 = strTableCourseDetail1 + "<table id='left_table' style='margin-top:" + values_count + "px;'><tr>";
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<table id='left_table'><tr>";
                                        values_count = 0;
                                    }
                                    table_margin_right = values_count;
                                }


                            }
                            if (cur_sem_courses[0]['semester_type'] == 'M') {
                                strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>MONSOON ";
                                // strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "</td></tr>";

                            }
                            else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>SPRING ";
                                //strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString())) + "</td></tr>";

                            }


                            for (var i = 0; i < cur_sem_courses.length; i++) {
                                semester_boolen = false;


                                if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                    }
                                }

                                //-------------Course Code and Course Name Changes-------------------// 
                                var coursecode_leg = cur_sem_courses[i]['course_code'].length;
                                var coursecode_name = cur_sem_courses[i]['course_code'] + " " + cur_sem_courses[i]['course_name'];
                                var coursename_code = cout_char(coursecode_name)
                                coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);
                                //----------------Course Type -------------------------------------//
                                if (cur_sem_courses[i]['c_type'] == 'E') {

                                    strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                    //-------------------Check GPA & NGPA----------------------//
                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        elective_ngpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                    else {
                                        elective_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                }
                                else {
                                    //-------------------Check GPA & NGPA----------------------//
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        mandatory_nongpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                    else {
                                        mandatory_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                }

                                //------------------Course Credits & grade ------------------------//
                                strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                    "<td class= 'col_dtl'>" + cur_sem_courses[i]['grade'] + "</td>";

                                if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                }
                                else {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_courses[i]['grade_point'], 2), 1) + "</td>";
                                }

                                strTableCourseDetail1 = strTableCourseDetail1 + "</tr>";
                                semester_boolen = true;
                            }


                            // }//New

                            //----------------WS Course Details--------------------------//
                            if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {

                                var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);
                                //------------Row count-------------------------------------//
                                //rowcount += cur_sem_ws_courses.length;

                                for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                    //---------------------Course Name and Course Code-----------------//
                                    var coursecode_leg = cur_sem_ws_courses[i]['course_code'].length;
                                    var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });
                                    var coursecode_name = cur_sem_ws_courses[i]['course_code'] + " " + str_course_name;
                                    var coursename_code = cout_char(coursecode_name)
                                    coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);

                                    if (semester_boolen == false) {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<table><tr>";
                                        if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>MONSOON ";
                                            // strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_ws_courses[0]['year_semester'].toString() + "</td></tr>";

                                        }
                                        else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>SPRING ";
                                            //strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                            strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_ws_courses[0]['year_semester'].toString())) + "</td></tr>";

                                        }
                                    }

                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        //----------------------Check Course Type----------------------//
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }

                                    }

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    //---------------Check Credits and grade and grade_Point--------------//

                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail1 = strTableCourseDetail1 + "</tr>";

                                }

                            }

                            //----------------------Course Credit Details--------------------------//
                            if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);
                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<tfoot id='footer'>" +
                                        "<tr><td></td><td>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";
                                }

                                var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                if (sgpa == 'NaN') {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td></td></tr></tfoot>";
                                }
                                else {
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td>" + sgpa + "</td></tr></tfoot>";
                                }
                            }

                            strTableCourseDetail1 = strTableCourseDetail1 + "</table>"
                        }

                        else {
                            $('#title_div_right').css('visibility', 'visible');
                            boolen = true;
                            //----------------Row Count ------------------//
                            if (values_right == 0) {
                                strTableCourseDetail_right = "<table id='right_table'><tr>"
                                values_right += 1;
                            }
                            else {
                                //strTableCourseDetail_right = strTableCourseDetail_right + "<table id='right_table'><tr>";


                                var left_side_row_count_course = arry_len[0]; //= JSON.parse(obj_course_detail[cur_sem - 3]['course_detail']).length;
                                var right_side_row_count_course_;//= arry_len[1] - arry_len[0];

                                if (arry_len[1] > arry_len[0]) {
                                    right_side_row_count_course_ = arry_len[1] - arry_len[0];

                                }
                                else {
                                    right_side_row_count_course_ = arry_len[0] - arry_len[1];
                                }
                                var values_count;
                                if (left_side_row_count_course > right_side_row_count_course_) {
                                    values_count = left_side_row_count_course - right_side_row_count_course_;//left_side_row_count_ws_course_ - left_side_row_count_ws_course;
                                    //values_count = values_count + 2;//+ table_margin_right;
                                    //values_count = values_count * 13.5;
                                    values_count = values_count * 21;
                                    values_count = values_count + 7;
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<table id='right_table' style='margin-top:" + values_count + "px;'><tr>";

                                }
                                else {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<table id='right_table'><tr>";
                                }
                            }

                            //-------------Semester Type -------------------------//
                            if (cur_sem_courses[0]['semester_type'] == 'M') {
                                strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>MONSOON ";
                                strTableCourseDetail_right = strTableCourseDetail_right + cur_sem_courses[0]['year_semester'].toString() + "</td></tr>";

                            }
                            else if (cur_sem_courses[0]['semester_type'] == 'S') {
                                strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>SPRING ";
                                strTableCourseDetail_right = strTableCourseDetail_right + (parseInt(cur_sem_courses[0]['year_semester'].toString())) + "</td></tr>";

                            }

                            //-----------------------GPA NGPA-------------------------//

                            for (var i = 0; i < cur_sem_courses.length; i++) {
                                //semester_boolen = false;
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

                                if (cur_sem_courses[i]['gpa_nongpa'] == 'G') {
                                    if (cur_sem_courses[i]['remarks'] == 'PASS') {
                                        total_GPA_marks += parseFloat(cur_sem_courses[i]['Total']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        total_GPA_credits += parseFloat(cur_sem_courses[i]['grade_point']) * parseFloat(cur_sem_courses[i]['course_credits']);
                                        total_credits += parseFloat(cur_sem_courses[i]['course_credits']);
                                    }
                                }

                                //--------------------Course Code and Name -------------------------//
                                var coursecode_leg = cur_sem_courses[i]['course_code'].length;
                                var coursecode_name = cur_sem_courses[i]['course_code'] + " " + cur_sem_courses[i]['course_name'];
                                var coursename_code = cout_char(coursecode_name);
                                coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);

                                if (cur_sem_courses[i]['c_type'] == 'E') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        elective_ngpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                    else {
                                        elective_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                }
                                else {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";
                                    if (cur_sem_courses[i]['gpa_nongpa'] == 'N') {
                                        mandatory_nongpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                    else {
                                        mandatory_gpa_total += parseInt(cur_sem_courses[i]['course_credits']);
                                    }
                                }

                                strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_courses[i]['course_credits'] + "</td>" +
                                    "<td class= 'col_dtl'>" + cur_sem_courses[i]['grade'] + "</td>";

                                if (cur_sem_courses[i]['grade_point'] == 'NA') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                }
                                else {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_courses[i]['grade_point'], 2), 1) + "</td>";
                                }
                                strTableCourseDetail_right = strTableCourseDetail_right + "</tr>";
                                semester_boolen = true
                            }

                            //------------------ws_course_dtl-----------------------//
                            if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {


                                var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);
                                rowcount += cur_sem_ws_courses.length;
                                for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                    //------------------Course Code and Name--------------------------//    
                                    var coursecode_leg = cur_sem_ws_courses[i]['course_code'].length;
                                    var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });
                                    var coursecode_name = cur_sem_ws_courses[i]['course_code'] + " " + str_course_name;
                                    var coursename_code = cout_char(coursecode_name);
                                    coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);

                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail_right = strTableCourseDetail_right + "</tr>";
                                }
                            }

                            //---------------Course Credit-------------------------//
                            if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<tfoot id='footer'>" +
                                        "<tr><td style='width:85%;'></td><td style='width:5%;'>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";

                                }

                                var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                if (sgpa == 'NaN') {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td style='width:5%;'></td><td style='width:5%;'></td></tr></tfoot>";
                                }
                                else {
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td style='width:5%;'></td><td style='width:5%;'>" + sgpa + "</td></tr></tfoot>";
                                }
                            }
                            strTableCourseDetail_right = strTableCourseDetail_right + "</table>"

                        }

                    }//course dtl

                    //--------------------------WS Course Dtl----------------------------//
                    else {

                        if (obj_course_detail[cur_sem]['ws_course_detail'] != '') {
                            //----------------------------------Right Side Data---------------------------------//
                            var cur_sem_ws_courses = JSON.parse(obj_course_detail[cur_sem]['ws_course_detail']);
                            rowcount += cur_sem_ws_courses.length + 2;
                            for (var i = 0; i < cur_sem_ws_courses.length; i++) {
                                //------------------Course Code and Name--------------------------//    
                                var coursecode_leg = cur_sem_ws_courses[i]['course_code'].length;
                                var str_course_name = cur_sem_ws_courses[i]['course_name'].toString();//.toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });
                                var coursecode_name = cur_sem_ws_courses[i]['course_code'] + " " + str_course_name;
                                var coursename_code = cout_char(coursecode_name);
                                coursename_code = coursename_code.substr(coursecode_leg, coursename_code.length);

                                if (cur_sem % 2 == 0) {
                                    if (values == 0) {
                                        strTableCourseDetail1 = "<table><tr id='course_dtl'>";
                                        values += 1;
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<table><tr>";
                                    }


                                    if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>MONSOON ";
                                        // strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                        strTableCourseDetail1 = strTableCourseDetail1 + cur_sem_ws_courses[0]['year_semester'].toString() + "</td></tr>";

                                    }
                                    else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td colspan='4' id='semesteryear'>SPRING ";
                                        //strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                        strTableCourseDetail1 = strTableCourseDetail1 + (parseInt(cur_sem_ws_courses[0]['year_semester'].toString())) + "</td></tr>";

                                    }



                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        //----------------------Check Course Type----------------------//
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }

                                    }

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    //---------------Check Credits and grade and grade_Point--------------//

                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail1 = strTableCourseDetail1 + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail1 = strTableCourseDetail1 + "</tr>";

                                    //----------------------Course Credit Details Left Side --------------------------//
                                    if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                        var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);
                                        if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<tfoot id='footer'>" +
                                                "<tr><td></td><td>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";
                                        }

                                        var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                        if (sgpa == 'NaN') {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td></td></tr></tfoot>";
                                        }
                                        else {
                                            strTableCourseDetail1 = strTableCourseDetail1 + "<td></td><td>" + sgpa + "</td></tr></tfoot>";
                                        }
                                    }

                                    strTableCourseDetail1 = strTableCourseDetail1 + "</table>"
                                }
                                else {

                                    if (values_right == 0) {
                                        strTableCourseDetail_right = "<table><tr>"

                                        values_right += 1;
                                    }
                                    else {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<table><tr>"
                                    }


                                    //

                                    if (cur_sem_ws_courses[0]['semester_type'] == 'W') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>MONSOON ";
                                        // strTableCourseDetail_right = strTableCourseDetail_right + cur_sem_courses[0]['year_semester'].toString() + "-" + (parseInt(cur_sem_courses[0]['year_semester'].toString()) + 1).toString().substr(2, 2) + "</td></tr>";
                                        strTableCourseDetail_right = strTableCourseDetail_right + cur_sem_ws_courses[0]['year_semester'].toString() + "</td></tr>";

                                    }
                                    else if (cur_sem_ws_courses[0]['semester_type'] == 'S') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td colspan='4' id='semesteryear'>SPRING ";
                                        //strTableCourseDetail_right = strTableCourseDetail_right + (parseInt(cur_sem_courses[0]['year_semester'].toString()) - 1) + "-" + (cur_sem_courses[0]['year_semester'].toString()).toString().substr(2, 2) + "</td></tr>";
                                        strTableCourseDetail_right = strTableCourseDetail_right + (parseInt(cur_sem_ws_courses[0]['year_semester'].toString())) + "</td></tr>";

                                    }

                                    if (cur_sem_ws_courses[i]['c_type'] == 'E') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + " " + "(E)" + "</span></td>";
                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            elective_ngpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            elective_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }
                                    else {
                                        //------------------------------Left Side Data--------------------------------//
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<tr id='course_dtl'><td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_code'] + "<span id='course_code_td'>&nbsp;" + coursename_code + "</span></td>";

                                        if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'N') {
                                            mandatory_nongpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                        else {
                                            mandatory_gpa_total += parseInt(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    if (cur_sem_ws_courses[i]['gpa_nongpa'] == 'G') {
                                        if (cur_sem_ws_courses[i]['remarks'] == 'PASS') {
                                            total_GPA_marks += parseFloat(cur_sem_ws_courses[i]['Total']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_GPA_credits += parseFloat(cur_sem_ws_courses[i]['grade_point']) * parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                            total_credits += parseFloat(cur_sem_ws_courses[i]['course_credits']);
                                        }
                                    }

                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['course_credits'] + "</td>";
                                    strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + cur_sem_ws_courses[i]['grade'] + "</td>";
                                    if (cur_sem_ws_courses[i]['grade_point'] == 'NA') {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>&nbsp;&nbsp;&nbsp;</td>";
                                    }
                                    else {
                                        strTableCourseDetail_right = strTableCourseDetail_right + "<td class= 'col_dtl'>" + round_num(round_num(cur_sem_ws_courses[i]['grade_point'], 2), 1) + "</td>";
                                    }
                                    strTableCourseDetail_right = strTableCourseDetail_right + "</tr>";


                                    //---------------Course Credit Right Side-------------------------//
                                    if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                        var cur_sem_credit_dtl = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                                        if (obj_course_detail[cur_sem]['credit_detail'] != '') {
                                            strTableCourseDetail_right = strTableCourseDetail_right + "<tfoot id='footer'>" +
                                                "<tr><td></td><td>" + cur_sem_credit_dtl[0]['total_credit'] + "</td>";

                                        }

                                        var sgpa = round_num(round_num(cur_sem_credit_dtl[0]['grade_point_avg'], 2), 1);

                                        if (sgpa == 'NaN') {
                                            strTableCourseDetail_right = strTableCourseDetail_right + "<td></td><td></td></tr></tfoot>";
                                        }
                                        else {
                                            strTableCourseDetail_right = strTableCourseDetail_right + "<td></td><td>" + sgpa + "</td></tr></tfoot>";
                                        }
                                    }
                                    strTableCourseDetail_right = strTableCourseDetail_right + "</table>"
                                }
                            }
                        }
                    }
                }

                var total_core_credit = 0;
                var total_elective_credit = 0;
                var total_ngpa_credit = 0;
                var total_cgpa = 0;
                var core_ngpa_credit = 0;
                var total_gpa_credit_ern = 0;
                var m_gpa_credit = 0;
                var m_ngpa_credit = 0;
                var total_sws_m_gpa_credit = 0;
                var total_sws_m_ngpa_credit = 0;
                var total_sws_gpa_credit = 0;
                var total_sws_ngpa_credit = 0;

                for (var cur_sem = 0; cur_sem < obj_course_detail.length; cur_sem++) {
                    var obj_course_credit = [];

                    if (obj_course_detail[cur_sem]['credit_detail'] != "") {
                        obj_course_credit = JSON.parse(obj_course_detail[cur_sem]['credit_detail']);

                        total_credits_ern += parseInt(obj_course_credit[0]['total_credit']);

                        total_core_credit += parseInt(obj_course_credit[0]['core_credit']);
                        m_gpa_credit += parseInt(obj_course_credit[0]['m_gpa_credit']);
                        m_ngpa_credit += parseInt(obj_course_credit[0]['m_ngpa_credit']);

                        core_ngpa_credit += parseInt(obj_course_credit[0]['elective_credit']);

                        total_elective_credit += parseInt(obj_course_credit[0]['gpa_credit']);
                        total_ngpa_credit += parseInt(obj_course_credit[0]['ngpa_credit']);

                        total_sws_m_gpa_credit += parseInt(obj_course_credit[0]['sws_m_gpa_credit']);
                        total_sws_m_ngpa_credit += parseInt(obj_course_credit[0]['sws_m_ngpa_credit']);
                        total_sws_gpa_credit += parseInt(obj_course_credit[0]['sws_gpa_credit']);
                        total_sws_ngpa_credit += parseInt(obj_course_credit[0]['sws_ngpa_credit']);

                    }

                }
                
                if (total_GPA_credits != 0 && total_credits != 0) {

                    total_cgpa = parseFloat(total_GPA_credits / total_credits).toFixed(1);

                }
                $('#left_side').html(strTableCourseDetail1);

                if (obj_transcript_detail != null) {
                    if (values_right != 0) {
                        strTableCourseDetail_right = strTableCourseDetail_right;
                    }

                    //strTableCourseDetail_right = strTableCourseDetail_right == undefined ? '' : strTableCourseDetail_right;

                    $('#title_div_right').css('visibility', 'visible');

                    if (obj_transcript_detail[0]['topic_type'] != "" || obj_transcript_detail[0]['dissertation_topic'] != "") {
                        strTableCourseDetail_right = strTableCourseDetail_right + "<table id ='prg_summ' style='padding: 0; line-height: 19px; margin-bottom:15px; margin-top:5px;'><tr>" +
                            "<td colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left;font-size:15px;'>" + obj_transcript_detail[0]['topic_type'] + " DETAILS</td></tr>" +
                            "<tr><td colspan=1 style='text-align: left;font-size:15px;' id='topic'><b>TITLE:   </b>" + obj_transcript_detail[0]['dissertation_topic'] + "</td></tr>" +
                            "</table>";//<tr><td colspan=1 style='text-align: left;font-size:15px;'><b>SUPERVISOR:  </b>" + obj_transcript_detail[0]['dissertation_supervisor'] + "</td></tr>//Mayur 07012021
                    }
                }

                if (strTableCourseDetail_right != undefined) {
                    strTableCourseDetail_right = strTableCourseDetail_right;
                }
                else { strTableCourseDetail_right = ''; }
                $('#title_div_right').css('visibility', 'visible');
                strTableCourseDetail_right = strTableCourseDetail_right + "<table id='prg_summ' style='padding: 0; line-height: 19px;'><tr>" +
                    "<td colspan = 4 style='border-bottom: 1px solid black; font-weight: bold; text-align: left; font-size:15px;'>PROGRAM SUMMARY</td></tr>" +
                    "<tr><td class='program_td' colspan=3>Total Credits Earned</td><td class='program_td'>" + total_credits_ern + "</td></tr>" +
                    "<tr><td class='program_td' id='mand_gpa' colspan=3>Mandatory GPA</td><td class='program_td' id='mand_gpa_no'>" + parseInt(m_gpa_credit + total_sws_m_gpa_credit) + "</td></tr>" +
                    "<tr> <td class='program_td' id='mand_ngpa' colspan='3'>Mandatory NGPA</td><td class='program_td' id='mand_ngpa_no'>" + parseInt(m_ngpa_credit + total_sws_m_ngpa_credit) + "</td></tr>" +
                    "<tr><td class='program_td' id='elec_gpa' colspan='3'>Elective GPA</td><td class='program_td' id='elec_gpa_no'>" + parseInt(total_elective_credit + total_sws_gpa_credit) + "</td></tr>" +
                    "<tr><td class='program_td' id='elec_ngpa' colspan='3'>Elective NGPA</td><td class='program_td' id='elec_ngpa_no'>" + parseInt(total_ngpa_credit + total_sws_ngpa_credit) + "</td></tr>" +
                    "<tr><td class='program_td' id='total_gpa_cre' colspan='3'>Total GPA Credits Earned</td><td class='program_td' id='total_gpa_no'>" + parseInt(m_gpa_credit + total_elective_credit + total_sws_m_gpa_credit + total_sws_gpa_credit) + "</td></tr>" +
                    "<tr><td class='program_td' colspan='3'>Cumulative Grade Point Average (CGPA) </td><td class='program_td' id='total_cgpa'>" + total_cgpa + "</td></tr>"

                strTableCourseDetail_right = strTableCourseDetail_right + "</table>";

                $('#right_side').html(strTableCourseDetail_right);

                if (obj_transcript_detail != null && obj_transcript_detail != undefined) {
                    if (obj_stud_detail[0]['dept_name'].toUpperCase() == 'PLANNING' && obj_stud_detail[0]['prog_name'].toUpperCase() == 'PG') {
                        var str_degree = 'MASTER OF PLANNING';

                        if (obj_transcript_detail[0]['specialization'] != '') str_degree += ' (' + obj_transcript_detail[0]['specialization'] + ')';

                        $('#name_fo_the_degree').html(str_degree.toUpperCase());
                    }

                    if (obj_transcript_detail[0]['name_of_the_degree'] != '')
                        $('#name_fo_the_degree').html(obj_transcript_detail[0]['name_of_the_degree'].toUpperCase());
                    if (obj_transcript_detail[0]['prog_level_name'] != '')
                        $('#td_program').html(obj_transcript_detail[0]['prog_level_name'].toUpperCase());
                     
                    if (obj_transcript_detail[0]['graduation_year'] != '') {
                        $('#td_graduation_year').html(obj_transcript_detail[0]['graduation_year'].toUpperCase());
                    } else {
                        $('#td_graduation_year').html("YET TO COMPLETE");
                    }
                }
            }
        }

        function display_Grade() {
            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                if (obj_stud_detail[0]["year_code"] >= 'Y2014' && obj_stud_detail[0]["year_code"] <= 'Y2017') {
                    $('tr#first_grade').css('display', 'block');
                }
            }
        }
        function display_Grade_Range() {

            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                    $('#div_grade_range').css('display', 'block');
                    $('#div_grade_range table').css('font-size', '10px');
                    $('div#div_grade_range').css('padding-right', '9.5px');
                    $('#div_grade_range table').css('font-family', 'Calibri');
                    $('#div_grade_range table tr th').css('line-height', '10px');
                    $('#div_grade_range table tr td').css('line-height', '10px');
                    $('#div_grade_range_2014_onward table tr td').css('text-align', 'center');


                }

                else if (obj_stud_detail[0]["year_code"] >= 'Y2018') {

                    $('#div_grade_range').css('display', 'none');

                    $('#div_grade_range_Y2018_onward').css('display', 'block');
                    $('#div_grade_range_Y2018_onward table').css('font-size', '10px');
                    $('div#div_grade_range_Y2018_onward').css('padding-right', '9.5px');
                    $('#div_grade_range_Y2018_onward table').css('font-family', 'Calibri');
                    $('#div_grade_range_Y2018_onward table tr th').css('line-height', '10px');
                    $('#div_grade_range_Y2018_onward table tr td').css('line-height', '10px');

                    //$('.cls_marks').css('display', 'none');
                    //$('#tr_semester_marks_avg').css('display', 'none');
                    //$('#div_white_space').css('height', '84px');

                    //$('#div_grade_range_Y2018_onward table tbody tr th').css('width', '10%');
                    ////$('#div_grade_range_Y2018_onward table tbody tr th').css('text-align', 'center');
                    //$('#div_grade_range_Y2018_onward table tbody tr td').css('width', '5%');
                    $('#div_grade_range_Y2018_onward table tbody tr td').css('text-align', 'center');
                    $("#div_note").css('display', 'none');
                }
                else {
                    $('#div_grade_range_2014_onward').css('display', 'block');
                    $('#div_grade_range_2014_onward table').css('font-size', '10px');
                    $('div#div_grade_range_2014_onward').css('padding-right', '9.5px');
                    $('#div_grade_range table').css('font-family', 'Calibri');
                    $('#div_grade_range_2014_onward table tr th').css('line-height', '10px');
                    $('#div_grade_range_2014_onward table tr td').css('line-height', '10px');
                    $('#div_grade_range_2014_onward table tr td').css('text-align', 'center');
                }
            }
        }
        function round_num(num, precision) {
            return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
        }
    </script>

</head>
<%--<body class="container" style="color:Black;width:1170px;">--%>
<body id="body_id" style="color: Black; padding-left: 1.27px; padding-right: 1px; margin-left: 49.13px; margin-right: 38px; margin-bottom: 38px; padding-top: 1px; padding-bottom: 1px;">
    <div id="header_page">
        <div style="width: 60%; display: inline-block;">
            <table id="tbl_student_detail" class="table table-condensed">
                <tr>
                    <td colspan="3" style="border: none;">
                        <span><b>PROVISIONAL TRANSCRIPT</b></span>
                    </td>

                </tr>
                <tr>
                    <td style="border: none;">
                        <span>NAME OF STUDENT</span>
                    </td>
                    <%--<td style="border: none;">: </td>--%>
                    <td id="td_name" colspan="3" style="border: none;"></td>
                </tr>
                <tr>
                    <td style="border: none;">
                        <span>STUDENT CODE</span></td>

                    <td id="td_rollno" style="border: none;"></td>
                    <td id='date_text' style="border: none; padding-left: 10px;  text-align: left;">
                        <span>DATE OF BIRTH</span>
                    </td>
                    
                    <td id="td_dob" style="border: none;"></td>
                </tr>

                <tr>
                    <td style="border: none;">
                        <span>NAME OF PROGRAM</span>
                    </td>
                    <%--<td style="border: none;">: </td>--%>
                    <td id="td_program" colspan="3" style="border: none;"></td>
                </tr>
                <tr id="name_degree">
                    <td style="border:none;">
                        <span>NAME OF DEGREE</span>
                    </td>
                    <td id="name_fo_the_degree" colspan="3" style="border: none;"></td>
                </tr>
                <tr id="tr_major">
                    <td style="border: none;">
                        <span>MAJOR</span>
                    </td>

                    <td id="td_major" colspan="3" style="border: none;"></td>
                </tr>
                <tr id="tr_minor">
                    <td style="border: none;">
                        <span>MINOR</span>
                    </td>

                    <td id="td_minor" colspan="3" style="border: none;"></td>
                </tr>

                <tr>
                    <td style="border: none;">
                        <span>MEDIUM OF INSTRUCTION</span>
                    </td>
                    <td id="td_medium_of_instruction" style="border: none;">ENGLISH</td>
                    <%--<td style="border: none; padding-left: 130px; text-align: right; padding-right: 12px;">
                        <span>DOB</span>
                    </td>

                    <td id="td_dob" style="border: none; padding-right: 0px;"></td>--%>
                </tr>

                <tr id="completed_date">
                    <td style="border: none;">
                        <span id="label_of_completion">DATE OF COMPLETION</span></td>

                    <td id="td_graduation_year" style="border: none;"></td>
                    <%--<td style="border: none; padding-left: 10px; text-align: left;">
                        <span>DATE OF GRADUATION</span>
                    </td>
                    
                    <td id="d" style="border: none;">MAY 2019</td>--%>
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
        <div style="float: right;">
            <img alt="" style="width: 257px; height: 95px; object-fit: cover;" src="../../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage" />
        </div>

    </div>

    <%--<div style="min-height: 676px;" id="main_body">--%>
    <div id="main_body">
        <div id='title_div_left' style='width: 50%; float: left;'>
            <table id="left_side_title" style="width: 98%;">
                <thead>
                    <tr>
                        <%--//<th scope="col" colspan="1" style="border: none;">Course</th>--%>
                        <th scope="col" style="width: 82%; text-align: center; font-family: Calibri; border: none;">Course</th>
                        <th scope="col" style="width: 7%; padding-right: 1px; text-align: center; font-family: Calibri; border: none;">CRS</th>
                        <th scope="col" style="width: 6%; padding-left: 0.9px; text-align: center; font-family: Calibri; border: none;">GRD</th>
                        <th scope="col" style="width: 5%; text-align: center; font-family: Calibri; border: none;">GP</th>
                    </tr>
                </thead>
            </table>
        </div>
        <div id='title_div_right' style='width: 50%; float: right;'>
            <table id="right_side_title" style="width: 98%;">
                <thead>
                    <tr>
                        <th scope="col" style="width: 82%; border: none; font-family: Calibri;">Course</th>
                        <th scope="col" style="width: 7%; padding-right: 1px; text-align: center; font-family: Calibri; border: none;">CRS</th>
                        <th scope="col" style="width: 6%; padding-left: 0.9px; text-align: center; font-family: Calibri; border: none;">GRD</th>
                        <th scope="col" style="width: 5%; text-align: center; font-family: Calibri; border: none;">GP</th>
                    </tr>
                </thead>
            </table>
        </div>
        <div style='width: 100%;'>
            <div id="left_side" style="width: 50%; float: left;">
            </div>
            <div id="right_side" style="width: 50%; float: right;">
            </div>

        </div>

    </div>



    <div style="margin-top: -15px; clear: both;">
        &nbsp;
    </div>

    <div id="footer_div" style='border: none;'>
        <%--<footer class="div_footer" id="UG">
            <div class="program_footer">PROGRAM CHAIR</div>
            <div class="den_footer">DEAN</div>
            <div class="reg_footer">REGISTRAR</div>
        </footer>--%>
    </div>
    <div class="trasncript_div">

        <div class="issue_date">ISSUE DATE: <span id="spn_issue_date"></span>&nbsp;&nbsp;&nbsp;NO: <span class="spn_transcript_no"></span></div>

    </div>

    <div id="desc_div" style="padding-top: 30px;">

        <table id="description_tbl" style="width: 50%; float: left; padding-top: 20px; text-align: left; display: inline-block;">
            <tr>
                <td><b>Abbreviations:</b></td>
            </tr>
            <tr>
                <td><b>CRS</b></td>
                <td>Credits</td>
            </tr>
            <tr>
                <td><b>GRD</b></td>
                <td>Grade</td>
            </tr>
            <tr>
                <td><b>GP</b></td>
                <td>Grade Point</td>

            </tr>
            <tr>
                <td><b>GPA</b></td>
                <td>Grade Point Average</td>
            </tr>
            <tr>
                <td><b>NGPA</b></td>
                <td>Non- Grade Point Average</td>
            </tr>
            <tr>
                <td><b>CGPA</b></td>
                <td>Cumulative Grade Point Average</td>
            </tr>
            <tr>
                <td><b>(E)</b></td>
                <td>Elective Course</td>
            </tr>
            <tr>
                <td><b>P</b></td>
                <td>Pass</td>
            </tr>
            <tr>
                <td colspan="2">
                    <p>
                        Courses are offered in four terms: 
                Monsoon,<br />
                        Spring, and Winter, Summer. 
                Courses offered<br />
                        during Winter and Summer 
                are modular and<br />
                        offered in one full session. 
                Grades from these terms<br />
                        are accounted in the 
                previous Monsoon and Spring<br />
                        semesters respectively.
                    </p>
                </td>
            </tr>
        </table>
        <table id="desc_right" style="float: right; width: 50%; text-align: left;">
            <tr>
                <td>GPA is calculated based on the GPA courses<br />
                    completed by the student.<br />
                    NGPA courses are only awarded a <b>Pass</b> grade.<br />
                    <br />
                </td>

            </tr>

            <tr>
                <td>Office Training/Project Training/other courses<br />
                    taken as <b>NGPA</b> are excluded in the <b>GPA/CGPA</b>
                    <br />
                    calculations.<br />
                    <br />
                </td>
            </tr>
            <tr id="first_grade">
                <td><b>Grading System</b></td>
            </tr>
            <tr id="first_grade">
                <td>Batches joining between 2014 to 2017 (inclusive)<br />
                    were graded on a Relative Grading System, in which<br />
                    the relative performance of the students is<br />
                    assessed with respect to their class. In classes with<br />
                    less than 20 students, absolute grading was<br />
                    adopted.
                </td>
            </tr>
        </table>

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
                <th>Point
                </th>
                <td>4.0
                </td>
                <td>4.0
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
                <td>2.0
                </td>
                <td>1.67
                </td>
                <td>1.33
                </td>
                <td>1.0
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
                <th>Point
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
                <td>2.0
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


    <%--2018--%>
    <div id="div_grade_range_Y2018_onward" style="display: none; width: 50%;">
        <table class="table table-bordered table-condensed">
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
                <th>Point
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
                <th>Numerical
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
    <%--//830//740--%>
    <div style="">
        <table id="address" style="font-size: 11px; float: right; margin-right: 25px; margin-top: 810px; margin-bottom: 10px; width: 100%;">
            <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td>KASTURBHAI LALBHAI</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>CAMPUS, UNIVERSITY RD</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>NAVRANGPURA</td>
                </tr>
                <tr>
                    <td></td>
                    <td><b>T:+917926302470</b></td>
                    <td>AHMEDABAD 380009</td>
                </tr>
                <tr>
                    <td style="text-align: right; padding-left: 550px">WWW.CEPT.AC.IN</td>
                    <td style="text-align: right;"><b>F:+917926302075</b></td>
                    <td>GUJARAT, INDIA</td>
                </tr>
            </tbody>
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
    <input type="hidden" id="hdn_transcript_no" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_tab" runat="server" clientidmode="Static" />

</body>

</html>
