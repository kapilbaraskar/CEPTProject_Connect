<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GradeReportPDF2.aspx.cs" Inherits="Admin_Report_GradeReportPDF2" %>

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
            //alert($("#hdn_stud_detail").val());
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

            setStudentDetail();
            setCourseDetail();
            set_WS_CourseDetail();
            setCreditDetail();
            display_Grade_Range();
        });

        function setStudentDetail() {
            
            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                var str_program = '';
                var stud_year_code = obj_stud_detail[0]["year_code"];
                if (obj_stud_detail[0]["year_code"] == 'Y1') stud_year_code = 'Y2013';

                if (obj_stud_detail[0]["prog_desc"] == 'Landscape Architecture') {
                    str_program = 'MASTERS PROGRAM IN LANDSCAPE ARCHITECTURE';
                }
                else if (obj_stud_detail[0]["prog_desc"] == 'Landscape Design') {
                    str_program = 'MASTERS PROGRAM IN LANSCAPE DESIGN';
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

                $('#td_program').html(str_program.toUpperCase());

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

                $('#spn_dept').html(obj_stud_detail[0]["dept_name"].toUpperCase());

                //$('#td_year').html($("#hdn_year").val());
            
                
                //$('#td_issuedate').html(obj_stud_detail[0]["full_name"]);
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

                    if (obj_course_detail[i]['c_type'] == 'M') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>"; }
                    else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>"; }
                    else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>"; }
                    else { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>"; }

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['grade'] + "</td>";

                    //if (obj_stud_detail[0]["year_code"] < 'Y2014') { strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['grade_point'] + "</td>"; }
                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['grade_point'] + "</td>";

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_course_detail[i]['remarks'] + "</td></tr>";
                }

                $('#tbl_course_marks').html(strTableCourseDetail);

                if (obj_course_detail[0]['semester_type'] == 'S') $('#h5_ws').html("SUMMER SCHOOL");
                else if (obj_course_detail[0]['semester_type'] == 'M') $('#h5_ws').html("WINTER SCHOOL"); 
            }
        }

        function set_WS_CourseDetail() {
            if (obj_ws_course_detail != null && obj_ws_course_detail != undefined) {
                var strTableCourseDetail = "<tr><th style='text-align: center;'>COURSE CODE</th><th style='text-align: center;'>COURSE NAME</th><th style='text-align: center;'>GPA/ NGPA</th><th style='text-align: center;'>CREDITS</th><th style='text-align: center;'>STATUS</th></tr>";

                for (var i = 0; i < obj_ws_course_detail.length; i++) {
                    var str_course_name = obj_ws_course_detail[i]['course_name'].toString().toLowerCase().replace(/([^a-z]|^)([a-z])(?=[a-z]{0})/g, function (_, g1, g2) { return g1 + g2.toUpperCase(); });

                    strTableCourseDetail = strTableCourseDetail + "<tr>" +
                                            "<td style='text-align: center;'>" + obj_ws_course_detail[i]['course_code'] + "</td>" +
                    //"<td>" + obj_ws_course_detail[i]['course_name'] + "</td>";
                                            "<td>" + str_course_name + "</td>";

                    if (obj_ws_course_detail[i]['c_type'] == 'M') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>"; }
                    else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>GPA</td>"; }
                    else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>NGPA</td>"; }
                    else { strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'></td>"; }

                    strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>" + obj_ws_course_detail[i]['course_credits'] + "</td>";

                    if (obj_ws_course_detail[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>PASS</td></tr>";
                    else if (obj_ws_course_detail[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td style='text-align: center;'>FAIL</td></tr>";
                }

                $('#tbl_ws_course_marks').html(strTableCourseDetail);
            }
            else {
                $('#div_ws_course_marks').css('display','none');
            }
        }

        function setCreditDetail() {

            if (obj_credit_detail != null && obj_credit_detail != undefined) {
                $('#td_total_credit').html(obj_credit_detail[0]['total_credit']);
                $('#td_core_credit').html(obj_credit_detail[0]['core_credit']);
                $('#td_elective_credit').html(obj_credit_detail[0]['elective_credit']);
                $('#td_gpa_credit').html(obj_credit_detail[0]['gpa_credit']);
                $('#td_ngpa_credit').html(obj_credit_detail[0]['ngpa_credit']);
                $('#td_sws_credit').html(obj_credit_detail[0]['sws_credit']);

                //$('#td_grade_point_avg').html(obj_credit_detail[0]['grade_point_avg']);
                if (obj_credit_detail[0]['grade_point_avg'].toString() == '-')
                {
                    $('#td_grade_point_avg').html(obj_credit_detail[0]['grade_point_avg']);
                }
                else {
                    if (obj_stud_detail[0]["year_code"] < 'Y2014')
                        $('#td_grade_point_avg').html(parseFloat(obj_credit_detail[0]['grade_point_avg']).toFixed(2));
                    else
                        $('#td_grade_point_avg').html(parseFloat(obj_credit_detail[0]['grade_point_avg']).toFixed(1) + "&nbsp;*");
                }
                
//                if (obj_credit_detail[0]['total_credit'] != '0') {
//                    $('#td_total_credit').html(obj_credit_detail[0]['total_credit']);
//                }
//                if (obj_credit_detail[0]['core_credit'] != '0') {
//                    $('#td_core_credit').html(obj_credit_detail[0]['core_credit']);
//                }
//                if (obj_credit_detail[0]['elective_credit'] != '0') {
//                    $('#td_elective_credit').html(obj_credit_detail[0]['elective_credit']);
//                }
//                if (obj_credit_detail[0]['gpa_credit'] != '0') {
//                    $('#td_gpa_credit').html(obj_credit_detail[0]['gpa_credit']);
//                }
//                if (obj_credit_detail[0]['ngpa_credit'] != '0') {
//                    $('#td_ngpa_credit').html(obj_credit_detail[0]['ngpa_credit']);
//                }
//                if (obj_credit_detail[0]['grade_point_avg'] != '0') {
//                    $('#td_grade_point_avg').html(obj_credit_detail[0]['grade_point_avg']);
//                }
            } 
        }

        function display_Grade_Range() {
            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                if (obj_stud_detail[0]["year_code"] < 'Y2014') {
                    //$('#div_grade_range').css('display', 'block');
                    $('#div_grade_range table').css('font-size', '11px');
                    $('#div_grade_range table tr th').css('line-height', '10px');
                    $('#div_grade_range table tr td').css('line-height', '10px');
                }
                else {
                    //$('#div_grade_range_2014_onward').css('display', 'block');
                    $('#div_grade_range_2014_onward table').css('font-size', '11px');
                    $('#div_grade_range_2014_onward table tr th').css('line-height', '10px');
                    $('#div_grade_range_2014_onward table tr td').css('line-height', '10px');
                    $('.cls_marks').css('display', 'none');
                }
            }
        }
    </script>
</head>
<body class="container">

    <div style="top: 20px; height: 120px; left: 1px;" title="" id="i22byht1">
        <a style="width: 297px; height: 96px; cursor: pointer;float:right;" href="../Master/Home.aspx">
            <div style="width: 297px; height: 96px; position: relative;">
                <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage" />
            </div>
        </a>

        <div style="clear:both;padding-top: 10px;">
            <div style="float:right;color: #5575B2;font-size:22px;font-weight:bold;padding-left:10px;padding-right:10px;">FACULTY <br /> OF <span id="spn_dept"></span></div>
            <div style="float:right;background-color: #5575B2;height: 41px;">&nbsp;</div>
        </div>
    </div>

    <h4>GRADE REPORT (Provisional)</h4>
    <%--<h4>GRADE REPORT</h4>--%>

    <div>
        <table class="table table-condensed">
            <tr>
                <td style="border:none;width:240px;"><b>NAME OF THE PROGRAM</b></td>
                <td style="border:none;width:10px;"> : </td>
                <td id="td_program" style="border:none;"></td>
            </tr>
            <tr>
                <td style="border:none;width:240px;"><b>NAME OF THE STUDENT</b></td>
                <td style="border:none;width:10px;"> : </td>
                <td id="td_name" style="border:none;"></td>
            </tr>
            <tr>
                <td style="border:none;width:240px;"><b>STUDENT ROLL NO.</b></td>
                <td style="border:none;width:10px;"> : </td>
                <td id="td_rollno" style="border:none;"></td>
            </tr>
            <tr>
                <td style="border:none;width:240px;"><b>SEMESTER</b></td>
                <td style="border:none;width:10px;"> : </td>
                <td id="td_sem" style="border:none;"></td>
            </tr>
            <tr>
                <td style="border:none;width:240px;"><b>YEAR</b></td>
                <td style="border:none;width:10px;"> : </td>
                <td id="td_year" style="border:none;"></td>
            </tr>
            <tr style="display:none;">
                <td style="border:none;width:240px;"><b>DATE OF ISSUE</b></td>
                <td style="border:none;width:10px;"> : </td>
                <td id="td_issuedate" style="border:none;"></td>
            </tr>
        </table>
    </div>

    <div>
        <table id="tbl_course_marks" class="table table-bordered">
            <tr>
                <th>COURSE CODE</th>
                <th>TITLE OF THE COURSE</th>
                <th>CORE/ ELECTIVE</th>
                <th>CREDIT</th>
                <th>MARKS</th>
                <th>GPA/ NGPA</th>
                <th>GRADE</th>
                <th>GRADE POINT</th>
                <th>REMARKS</th>
            </tr>
            
            <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
            </tr>

            <%--<tr>
                <td>1061</td>
                <td>Flexible Cities</td>
                <td>E</td>
                <td>2</td>
                <td>58</td>
                <td>NGPA</td>
                <td>NA</td>
                <td>P</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>1062</td>
                <td>Architecture of flight</td>
                <td>E</td>
                <td>2</td>
                <td>70</td>
                <td>NGPA</td>
                <td>NA</td>
                <td>P</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4015</td>
                <td>Introduction to Civil & Structural Engineering</td>
                <td>C</td>
                <td>2</td>
                <td>60</td>
                <td>GPA</td>
                <td>C-</td>
                <td>1.67</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4016</td>
                <td>Culture and Climate in Built Environment</td>
                <td>C</td>
                <td>2</td>
                <td>66</td>
                <td>GPA</td>
                <td>C</td>
                <td>2.00</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4017</td>
                <td>Introduction to Settlement Planning</td>
                <td>C</td>
                <td>2</td>
                <td>50</td>
                <td>GPA</td>
                <td>D-</td>
                <td>0.67</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4018</td>
                <td>GIS - 2</td>
                <td>C</td>
                <td>3</td>
                <td>53</td>
                <td>GPA</td>
                <td>D</td>
                <td>1.00</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4019</td>
                <td>Rural Lab : Rural Development and Livelihoods</td>
                <td>C</td>
                <td>6</td>
                <td>71</td>
                <td>GPA</td>
                <td>B-</td>
                <td>2.67</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4017</td>
                <td>Introduction to Settlement Planning</td>
                <td>C</td>
                <td>2</td>
                <td>50</td>
                <td>GPA</td>
                <td>D-</td>
                <td>0.67</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4018</td>
                <td>GIS - 2</td>
                <td>C</td>
                <td>3</td>
                <td>53</td>
                <td>GPA</td>
                <td>D</td>
                <td>1.00</td>
                <td>PASS</td>
            </tr>
            <tr>
                <td>4019</td>
                <td>Rural Lab : Rural Development and Livelihoods</td>
                <td>C</td>
                <td>6</td>
                <td>71</td>
                <td>GPA</td>
                <td>B-</td>
                <td>2.67</td>
                <td>PASS</td>
            </tr>
--%>
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
        <table class="table table-bordered table-condensed">
            <tr>
                <td>
                    <table class="table table-condensed">
                        <tr>
                            <td style="border:none;">TOTAL CREDITS EARNED</td>
                            <td style="border:none;"> - </td>
                            <td id="td_total_credit" style="border:none;"></td>
                        </tr>
                        <tr>
                            <td style="border:none;">CORE</td>
                            <td style="border:none;"> - </td>
                            <td id="td_core_credit" style="border:none;"></td>
                        </tr>
                        <tr>
                            <td style="border:none;">ELECTIVE</td>
                            <td style="border:none;"> - </td>
                            <td id="td_elective_credit" style="border:none;"></td>
                        </tr>
                        <tr>
                            <td style="border:none;padding-left: 35px;">GPA</td>
                            <td style="border:none;"> - </td>
                            <td id="td_gpa_credit" style="border:none;"></td>
                        </tr>
                        <tr>
                            <td style="border:none;padding-left: 35px;">NGPA</td>
                            <td style="border:none;"> - </td>
                            <td id="td_ngpa_credit" style="border:none;"></td>
                        </tr>
                        <tr>
                            <td style="border:none;">SUMMER/WINTER SCHOOL</td>
                            <td style="border:none;"> - </td>
                            <td id="td_sws_credit" style="border:none;"></td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>
                            <td style="border:none;">SEMESTER GRADE POINT AVERAGE</td>
                            <td style="border:none;"> : </td>
                            <td id="td_grade_point_avg" style="border:none;"></td>
                        </tr>
                        <tr style="display:none;">
                            <td style="border:none;">SEMESTER GRADE POINT RATIO</td>
                            <td style="border:none;"> : </td>
                            <td id="td_grade_point_ratio" style="border:none;"></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div style="display:none;">
        <div style="height:50px;"></div>
        <div style="float:left;font-weight:bold;margin-bottom: 10px;">PROGRAM COORDINATOR</div>
        <div style="float:right;font-weight:bold;margin-bottom: 10px;">DEAN</div>
    </div>

    <div id="div_grade_range" style="display:none;">
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
    
    <div id="div_grade_range_2014_onward" style="display:none;">
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

    <input type="hidden" id="hdn_uid" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_stud_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_course_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_ws_course_detail" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_credit_detail" runat="server" clientidmode="Static" />
</body>
</html>
