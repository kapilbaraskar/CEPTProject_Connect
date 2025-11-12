<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutLinePDF.aspx.cs" Inherits="Student_OutLinePDF" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            //  append_tutor_image();
            GetData();
            GetData_week_per_crt();
            append_tutor_image_details();

            Getportfoliolink();
            getinst_time_slot();
            get_course_wise_time_slot();

            if ($('#hdn_new_tab').val() == 'Y') {
                $('title').html($('#hdn_outline').val());

                $('body').css('padding', '0 100px');

                var mywindow = window.open('_blank');
                mywindow.document.write(document.getElementsByTagName('html')[0].innerHTML);
            }
        });

        function dis_image1() {
            $("#img1").css('display', '');
            $("#img2").css('display', 'none');
            $("#img3").css('display', 'none');
            $("#img4").css('display', 'none');
            $("#img5").css('display', 'none');
            $("#img6").css('display', 'none');
            $("#img7").css('display', 'none');
        }

        function dis_image2() {
            $("#img1").css('display', 'none');
            $("#img2").css('display', '');
            $("#img3").css('display', 'none');
            $("#img4").css('display', 'none');
            $("#img5").css('display', 'none');
            $("#img6").css('display', 'none');
            $("#img7").css('display', 'none');
        }

        function dis_image3() {
            $("#img1").css('display', 'none');
            $("#img2").css('display', 'none');
            $("#img3").css('display', '');
            $("#img4").css('display', 'none');
            $("#img5").css('display', 'none');
            $("#img6").css('display', 'none');
            $("#img7").css('display', 'none');
        }

        function dis_image4() {
            $("#img1").css('display', 'none');
            $("#img2").css('display', 'none');
            $("#img3").css('display', 'none');
            $("#img4").css('display', '');
            $("#img5").css('display', 'none');
            $("#img6").css('display', 'none');
            $("#img7").css('display', 'none');
        }

        function dis_image5() {
            $("#img1").css('display', 'none');
            $("#img2").css('display', 'none');
            $("#img3").css('display', 'none');
            $("#img4").css('display', 'none');
            $("#img5").css('display', '');
            $("#img6").css('display', 'none');
            $("#img7").css('display', 'none');
        }

        function dis_image6() {
            $("#img1").css('display', 'none');
            $("#img2").css('display', 'none');
            $("#img3").css('display', 'none');
            $("#img4").css('display', 'none');
            $("#img5").css('display', 'none');
            $("#img6").css('display', '');
            $("#img7").css('display', 'none');
        }

        function dis_image7() {
            $("#img1").css('display', 'none');
            $("#img2").css('display', 'none');
            $("#img3").css('display', 'none');
            $("#img4").css('display', 'none');
            $("#img5").css('display', 'none');
            $("#img6").css('display', 'none');
            $("#img7").css('display', '');
        }

        var current_row_id;

        function GetData() {
            binddata(JSON.parse($('#hdnres').val()));
        }

        function GetData_week_per_crt() {
            if ($('#hdnres1').val() != "") {

                binddata_week_per_crt(JSON.parse($('#hdnres1').val()));
            }
        }

        function Getportfoliolink() {
            if ($('#portfoliolink').val() != "") {
                binddata_portfoliolink(JSON.parse($('#portfoliolink').val()));
            }
        }

        function binddata_portfoliolink(data) {
            $("#txt_link").html('');
            for (var j = 0; j < data.length; j++) {
                var semestername;
                var semesterlink = data[j]["semester_wise_link"];
                var semestertype = data[j]["semester_type"];
                var semester = data[j]["year_semester"];
                if (semestertype == "M") {
                    semestername = "Monsoon" + " " + semester;
                }
                else {
                    semestername = "Spring" + " " + semester;
                }

                var dd = data[j]["semester_wise_link"];
                if (j < 3) {
                    // $("div div #txt_link").append('<div id=link style="width:20%"> ' + semestername + ' - <div style="width:20%"><a href=' + semesterlink + '>' + semesterlink + '</a></div></div></br>');

                    //$("div div #txt_link").append('<div id=link style="width:20%"> ' + semestername + ' - </div>');
                    //$("div div #txt_link").append(' <div style="width:80%"><a href=' + semesterlink + '>' + semesterlink + '</a></div></br>');

                    $("div div #txt_link").append('<b id=link> ' + semestername + ' </b>- <a href=' + semesterlink + '>' + semesterlink + '</a></br>');
                }

            }

        }

        function binddata(data) {

            $('#txtcourse_outline').html('');
            $('#txtbrief_introduction').html('');
            $('#subtitle_course_name').html('');
            //$('#txtcourse_description').html('');
            $('#txt_week1').html('');
            $('#txt_week2').html('');
            $('#txt_week3').html('');
            $('#txt_week4').html('');
            $('#txt_week5').html('');
            $('#txt_week6').html('');
            $('#txt_week7').html('');
            $('#txt_week8').html('');
            $('#txt_week9').html('');
            $('#txt_week10').html('');
            $('#txt_week11').html('');
            $('#txt_week12').html('');
            $('#txt_week13').html('');
            $('#txt_week14').html('');
            $('#txt_week15').html('');
            $('#txt_week16').html('');

            $('#txtcourse_structure').html('');
            $('#txt_course_code').html('');

            $('#txt_reference').html('');
            $('#txt_eval_method').html('');
            $('#div_course_expense').html('');
            $('#div_course_assessment').html('');
            $('#div_course_assessment_new').html('');
            $('#head_data').html('');

            $('#course_prerequisite').html('');  //Returned By Ananath
            $('#course_title').html('');

            $('#lear_outcome').html("");
            $('#lear_outcome1').html("");
            $('#lear_outcome2').html("");
            $('#lear_outcome3').html("");
            $('#lear_outcome4').html("");
            $('#lear_outcome5').html("");
            $('#problem_statement').html("");

            var aData = data;

            var flag = 'N';

            var course_code = aData[0]["course_code"];

            console.log(aData[0]["course_desc"]);
            if (aData[0]["course_typology"] == '23') {
                $("#subtitlevalue").css('display', '');
                $('#subtitle_course_name').html(aData[0]["StudioSubTitle"]);
            }
            else
            {
                $("#subtitlevalue").css('display', 'none');
            }
            
            var courseDesc = aData[0]["course_desc"];
            courseDesc = $('<div/>').text(courseDesc).html();
            $("#txtbrief_introduction").html(courseDesc);
            //$('#txtcourse_outline').html(aData[0]["course_outline"]);

            var courseout = aData[0]["course_outline"];
            courseout = $('<div/>').text(courseout).html();
            $("#txtcourse_outline").html(courseout);


            //$('#txtcourse_description').html(aData[0]["course_desc"]);
            $('#course_title').html(aData[0]["course_name"]);

            var prerequisite = JSON.parse(aData[0]["prerequisite"]);

            $('#course_prerequisite').html(prerequisite["other"]);  //Returned By Ananath

            if (aData[0]["sub_group"] == "SG003") {//Returned By Mayur
                $('#problem_statement').html(aData[0]["problem_statement"]);//Returned By Ananath
            } else {
                $(".problem_statement").css('display', 'none');
            }
            //mode
            if (aData[0]["studio_mode"] != "")
            {
                $('#mode').html(aData[0]["studio_mode"]);
                $("#mode_text").css('display', 'block');
            }

            $('#course_code').html(aData[0]["course_code"] + ':');

            $('#txt_week1').html(aData[0]["week1"]);
            $('#txt_week2').html(aData[0]["week2"]);
            $('#txt_week3').html(aData[0]["week3"]);
            $('#txt_week4').html(aData[0]["week4"]);
            $('#txt_week5').html(aData[0]["week5"]);
            $('#txt_week6').html(aData[0]["week6"]);
            $('#txt_week7').html(aData[0]["week7"]);
            $('#txt_week8').html(aData[0]["week8"]);
            $('#txt_week9').html(aData[0]["week9"]);
            $('#txt_week10').html(aData[0]["week10"]);
            $('#txt_week11').html(aData[0]["week11"]);
            $('#txt_week12').html(aData[0]["week12"]);
            $('#txt_week13').html(aData[0]["week13"]);
            $('#txt_week14').html(aData[0]["week14"]);
            $('#txt_week15').html(aData[0]["week15"]);
            $('#txt_week16').html(aData[0]["week16"]);

            //$('#txtcourse_structure').html(aData[0]["course_structure"]);

            //if (aData[0]["sub_group"] == "SG003") {//Returned By Mayur
            //    $("#div_course_structure").css('display', 'none');
            //}

            $('#txt_course_code').html(course_code);

            var a = ['', 'One ', 'Two ', 'Three ', 'Four ', 'Five ', 'Six ', 'Seven ', 'Eight ', 'Nine ', 'Ten ', 'Eleven ', 'Twelve ', 'Thirteen ', 'Fourteen ', 'Fifteen ', 'Sixteen ', 'Seventeen ', 'Eighteen ', 'Nineteen '];
            var b = ['', '', 'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'];

            function inWords(num) {
                if ((num = num.toString()).length > 9) return 'overflow';
                n = ('000000000' + num).substr(-9).match(/^(\d{2})(\d{2})(\d{2})(\d{1})(\d{2})$/);
                if (!n) return; var str = '';
                str += (n[1] != 0) ? (a[Number(n[1])] || b[n[1][0]] + ' ' + a[n[1][1]]) + 'Crore ' : '';
                str += (n[2] != 0) ? (a[Number(n[2])] || b[n[2][0]] + ' ' + a[n[2][1]]) + 'Lakh ' : '';
                str += (n[3] != 0) ? (a[Number(n[3])] || b[n[3][0]] + ' ' + a[n[3][1]]) + 'Thousand ' : '';
                str += (n[4] != 0) ? (a[Number(n[4])] || b[n[4][0]] + ' ' + a[n[4][1]]) + 'Hundred ' : '';
                str += (n[5] != 0) ? ((str != '') ? 'and ' : '') + (a[Number(n[5])] || b[n[5][0]] + ' ' + a[n[5][1]]) + 'only ' : '';
                return str;
            }

            $('#txt_reference').html(aData[0]["remark"]);
            $('#txt_eval_method').html(aData[0]["eval_method1"]);
            $('#div_course_expense').html('INR ' + aData[0]["course_expense"] + '/- (' + inWords(parseInt(aData[0]["course_expense"])) + 'Rupees)');

            //if (aData[0]["course_assessment"] != '') {
            //    debugger;
            //    var assessment = JSON.parse(aData[0]["course_assessment"]);
            //    var str_html = '<table>';
            //    //if (assessment.length == "0")
            //    //{
            //    //    $('#co_ass').css('display', 'none');
            //    //}
            //    for (var i = 0; i < assessment.length; i++) {
            //        str_html += '<tr><td><b>Exercise : </b>' + assessment[i]['exercise'] + '</td>';
            //        str_html += '<td style="padding-left:20px;"><b>Percentage : </b>' + assessment[i]['percentage'] + '</td>';
            //        str_html += '<td style="padding-left:20px;"><b>Criteria : </b>' + assessment[i]['criteria'] + '</td></tr>';

            //    }

            //    str_html += '</table>';



            //    $('#div_course_assessment').html(str_html);
            //    $('#co_ass').css('display', 'block');

            //}
            //if (aData[0]["sub_category_id"] == "L2" || aData[0]["sub_category_id"] == "L3" || aData[0]["sub_category_id"] == "L4")
            //{
            //    debugger;
            if (aData[0]["course_assessment"] != '') {
                var assessment = JSON.parse(aData[0]["course_assessment"]);
                if (assessment.length == "0" || aData[0]["sub_group"] == "SG003") {
                    $('#co_ass').css('display', 'none');
                }
                else {
                    var str_html = '<table>';
                    for (var i = 0; i < assessment.length; i++) {
                        str_html += '<tr><td><b>Exercise : </b>' + assessment[i]['exercise'] + '</td>';
                        str_html += '<td style="padding-left:20px;"><b>Percentage : </b>' + assessment[i]['percentage'] + '</td>';
                        str_html += '<td style="padding-left:20px;"><b>Criteria : </b>' + assessment[i]['criteria'] + '</td></tr>';
                    }
                    str_html += '</table>';
                    $('#co_ass').css('display', 'block');//none
                    $('#div_course_assessment_new').html(str_html);
                    $('#txtcourse_structure').html(aData[0]["course_structure"]);
                    $("#div_course_structure").css('display', '');
                }
            }

            //}


            //else
            //{
            //    $('#co_ass').css('display', 'block');
            //}

            $('#img1').css("display", "none");
            $('#img2').css("display", "none");
            $('#img3').css("display", "none");
            $('#img4').css("display", "none");
            $('#img5').css("display", "none");
            $('#img6').css("display", "none");
            $('#img7').css("display", "none");
            $('#mainimg').css("display", "none");
            $('#img567').css("display", "none");

            $('#lear_outcome').html("After completing the " + aData[0]["Course_type_name"] + ",the student will be able to :");

            if (aData[0]["eval_method5"] != "" && aData[0]["eval_method5"] != null) {
                var learing_outcome = JSON.parse(aData[0].eval_method5);

                if (learing_outcome["course_outcome1"] != "" && learing_outcome["course_outcome1"] != null)
                    $('#lear_outcome1').html("- " + learing_outcome["course_outcome1"]);
                if (learing_outcome["course_outcome2"] != "" && learing_outcome["course_outcome2"] != null)
                    $('#lear_outcome2').html("- " + learing_outcome["course_outcome2"]);
                if (learing_outcome["course_outcome3"] != "" && learing_outcome["course_outcome3"] != null)
                    $('#lear_outcome3').html("- " + learing_outcome["course_outcome3"]);
                if (learing_outcome["course_outcome4"] != "" && learing_outcome["course_outcome4"] != null)
                    $('#lear_outcome4').html("- " + learing_outcome["course_outcome4"]);
                if (learing_outcome["course_outcome5"] != "" && learing_outcome["course_outcome5"] != null)
                    $('#lear_outcome5').html("- " + learing_outcome["course_outcome5"]);
            }

            if (aData[0]["eval_method4"] != "" && aData[0]["eval_method4"] != null) {
                var CourseImg = JSON.parse(aData[0]["eval_method4"]);
                if (CourseImg.length > 2)
                    $('#img567').removeAttr('style');

                if (CourseImg.length > 0) {
                    $('#mainimg').removeAttr('style');
                    for (var i = 1; i <= CourseImg.length; i++) {

                        $('#img' + i).attr("src", "https://connect.cept.ac.in/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);

                        var myImg = document.querySelector('#img' + i);
                        var realWidth = myImg.naturalWidth;

                        if (realWidth > 500) {

                            $('#img' + i).width("600px");
                        }
                        //$('#img' + i).attr("src", "http://localhost:35273/CEPT/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);

                        $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);

                        //$('#div_caption2').html(CourseImg[1]["img_caption"]);
                        $('#img1').css("display", "");
                        $('#square' + i).css("display", "");
                        $('#clk_other_img').css("display", "block");
                        //$('#img' + i).removeAttr('style');

                    }
                }
            }
            //set Header

            if (aData[0]["semester_type"] == "M") {
                $('#head_data').append("Monsoon Semester");
            }
            else if (aData[0]["semester_type"] == "S") {
                $('#head_data').append("Spring Semester");
            }

            if (aData[0]["year_semester"] != "") {
                $('#head_data').append(", " + aData[0]["year_semester"]);
            }

            $('#head_data').append(", Faculty of " + aData[0]["department"] + ",  CEPT University");
            $('#course_name').html(aData[0]["course_name"]);
            $('#tutors').html(aData[0]["instructor"]);



            if (aData[0].course_structure != '') {
                $('#div_weekly_plan').css('display', 'none');
                $('#div_course_structure').css('display', 'block');
            }
            else if (aData[0].week1 != '' || aData[0].week2 != '' || aData[0].week3 != '' || aData[0].week4 != '' || aData[0].week5 != '' || aData[0].week6 != '' || aData[0].week7 != '' || aData[0].week8 != '' || aData[0].week9 != '' || aData[0].week10 != '' || aData[0].week11 != '' || aData[0].week12 != '' || aData[0].week13 != '' || aData[0].week14 != '' || aData[0].week15 != '' || aData[0].week16 != '') {
                $('#div_weekly_plan').css('display', 'block');
                $('#div_course_structure').css('display', 'none');
            }
            else {
                $('#div_weekly_plan').css('display', 'none');
                $('#div_course_structure').css('display', 'none');
            }

            //if ($('#hdn_new_tab').val() == 'Y') {
            //    $('title').html($('#hdn_outline').val());

            //    $('body').css('padding', '0 100px');

            //    var mywindow = window.open('_blank');
            //    mywindow.document.write(document.getElementsByTagName('html')[0].innerHTML);
            //}

            for (var i = parseInt(aData[0]["week"]); i <= 16; i++) {
                $('.week_none_' + (i + 1)).css('display', 'none');
            }
        }

        function binddata_week_per_crt(data) {

            $('#txt_week_per1').html('');
            $('#txt_week_per2').html('');
            $('#txt_week_per3').html('');
            $('#txt_week_per4').html('');
            $('#txt_week_per5').html('');
            $('#txt_week_per6').html('');
            $('#txt_week_per7').html('');
            $('#txt_week_per8').html('');
            $('#txt_week_per9').html('');
            $('#txt_week_per10').html('');
            $('#txt_week_per11').html('');
            $('#txt_week_per12').html('');
            $('#txt_week_per13').html('');
            $('#txt_week_per14').html('');
            $('#txt_week_per15').html('');
            $('#txt_week_per16').html('');


            $('#txt_week_crt1').html('');
            $('#txt_week_crt2').html('');
            $('#txt_week_crt3').html('');
            $('#txt_week_crt4').html('');
            $('#txt_week_crt5').html('');
            $('#txt_week_crt6').html('');
            $('#txt_week_crt7').html('');
            $('#txt_week_crt8').html('');
            $('#txt_week_crt9').html('');
            $('#txt_week_crt10').html('');
            $('#txt_week_crt11').html('');
            $('#txt_week_crt12').html('');
            $('#txt_week_crt13').html('');
            $('#txt_week_crt14').html('');
            $('#txt_week_crt15').html('');
            $('#txt_week_crt16').html('');


            var aData = data;


            $('#txt_week_per1').html(aData[0]["week_assignment_per1"]);
            $('#txt_week_per2').html(aData[0]["week_assignment_per2"]);
            $('#txt_week_per3').html(aData[0]["week_assignment_per3"]);
            $('#txt_week_per4').html(aData[0]["week_assignment_per4"]);
            $('#txt_week_per5').html(aData[0]["week_assignment_per5"]);
            $('#txt_week_per6').html(aData[0]["week_assignment_per6"]);
            $('#txt_week_per7').html(aData[0]["week_assignment_per7"]);
            $('#txt_week_per8').html(aData[0]["week_assignment_per8"]);
            $('#txt_week_per9').html(aData[0]["week_assignment_per9"]);
            $('#txt_week_per10').html(aData[0]["week_assignment_per10"]);
            $('#txt_week_per11').html(aData[0]["week_assignment_per11"]);
            $('#txt_week_per12').html(aData[0]["week_assignment_per12"]);
            $('#txt_week_per13').html(aData[0]["week_assignment_per13"]);
            $('#txt_week_per14').html(aData[0]["week_assignment_per14"]);
            $('#txt_week_per15').html(aData[0]["week_assignment_per15"]);
            $('#txt_week_per16').html(aData[0]["week_assignment_per16"]);


            $('#txt_week_crt1').html(aData[0]["week_assignment_crt1"]);
            $('#txt_week_crt2').html(aData[0]["week_assignment_crt2"]);
            $('#txt_week_crt3').html(aData[0]["week_assignment_crt3"]);
            $('#txt_week_crt4').html(aData[0]["week_assignment_crt4"]);
            $('#txt_week_crt5').html(aData[0]["week_assignment_crt5"]);
            $('#txt_week_crt6').html(aData[0]["week_assignment_crt6"]);
            $('#txt_week_crt7').html(aData[0]["week_assignment_crt7"]);
            $('#txt_week_crt8').html(aData[0]["week_assignment_crt8"]);
            $('#txt_week_crt9').html(aData[0]["week_assignment_crt9"]);
            $('#txt_week_crt10').html(aData[0]["week_assignment_crt10"]);
            $('#txt_week_crt11').html(aData[0]["week_assignment_crt11"]);
            $('#txt_week_crt12').html(aData[0]["week_assignment_crt12"]);
            $('#txt_week_crt13').html(aData[0]["week_assignment_crt13"]);
            $('#txt_week_crt14').html(aData[0]["week_assignment_crt14"]);
            $('#txt_week_crt15').html(aData[0]["week_assignment_crt15"]);
            $('#txt_week_crt16').html(aData[0]["week_assignment_crt16"]);

        }

        function append_tutor_image_details() {

            if ($('#hdn_tutor_profile').val() != "") {
                append_tutor_image(JSON.parse($('#hdn_tutor_profile').val()));
            }
        }

        function append_tutor_image(data) {

            var profile_data = data;
            $("#tutorimg").html('');
            for (var i = 0; i < profile_data.length; i++) {

                if (document.querySelectorAll("[data-bind_row_no='" + (i + 1) + "']").length > 0) {
                    var imgurl;
                    if (profile_data[i]['profile_photo'] != '' && profile_data[i]['profile_photo'] != null && profile_data[i]['profile_photo'] != undefined) {
                        if (document.querySelectorAll("img[data-bind_row_no='" + (i + 1) + "']").length > 0) {
                            if (profile_data[i]['profile_photo'].indexOf("/") >= 0) {

                                imgurl = "https://connect.cept.ac.in/" + profile_data[i]['profile_photo'] + "";

                                if (profile_data[i]['tutor_type'] == "CT") {
                                    $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Co-Tutor Profile: </div>');
                                    $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                                    $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                                    $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');
                                }
                                else {
                                    $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Tutor Profile: </div>');
                                    $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                                    $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                                    $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');

                                }

                                // $("#tutor_img" + (i + 1)).attr("src", "https://connect.cept.ac.in/" + profile_data[i]['profile_photo']);
                                // $("#tutor_img" + (i + 1)).css("display", "block");
                            }
                            else {
                                imgurl = "https://connect.cept.ac.in/UserPersonalPhoto/" + profile_data[i]['profile_photo'] + "";

                                if (profile_data[i]['tutor_type'] == "CT") {
                                    $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Co-Tutor Profile: </div>');
                                    $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                                    $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                                    $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');

                                }
                                else {
                                    $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Tutor Profile: </div>');
                                    $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                                    $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                                    $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');
                                }

                                // $("#tutor_img" + (i + 1)).attr("src", "https://connect.cept.ac.in/UserPersonalPhoto/" + profile_data[i]['profile_photo']);
                                //$("#tutor_img" + (i + 1)).css("display", "block");
                            }

                        }

                        if (document.querySelectorAll("label[data-bind_row_no='" + (i + 1) + "']").length > 0) {
                            document.querySelectorAll("label[data-bind_row_no='" + (i + 1) + "']")[i].innerHTML = profile_data[i]["user_name"]
                        }
                        if (document.querySelectorAll("span[data-bind_row_no='" + current_row_id + "']").length > 0) {
                            document.querySelectorAll("span[data-bind_row_no='" + current_row_id + "']")[i].innerHTML = 'Profile For ' + profile_data[i]["user_name"];
                        }
                    }
                    else {

                    }
                }
                else {
                    if (profile_data[i]['profile_photo'] != '' && profile_data[i]['profile_photo'] != null && profile_data[i]['profile_photo'] != undefined) {

                        var imgurl;
                        if (profile_data[i]['profile_photo'].indexOf("/") >= 0) {
                            imgurl = "https://connect.cept.ac.in/" + profile_data[i]['profile_photo'] + "";

                            // $("#tutor_img" + (i + 1)).attr("src", "https://connect.cept.ac.in/" + profile_data[i]['profile_photo']);
                            // $("#tutor_img" + (i + 1)).appendTo($("#tutor_img"));
                            // $("#tutor_img" + (i + 1)).css("display", "block");
                        }
                        else {
                            imgurl = "https://connect.cept.ac.in/UserPersonalPhoto/" + profile_data[i]['profile_photo'] + "";

                            // $("#tutor_img" + (i + 1)).attr("src", "https://connect.cept.ac.in/UserPersonalPhoto/" + profile_data[i]['profile_photo']);
                            // $("#tutor_img" + (i + 1)).css("display", "block");
                        }

                        if (profile_data[i]['tutor_type'] == "CT") {

                            $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Co-Tutor Profile: </div>');
                            $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                            $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                            $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');
                        }
                        else {
                            $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Tutor Profile: </div>');
                            $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                            $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                            $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');
                        }

                        img.setAttribute('data-bind_row_no', (i + 1));
                    }
                    else {
                        if (profile_data[i]['tutor_type'] == "CT") {
                            $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Co-Tutor Profile: </div>');
                            $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                            $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                            var imgurl = "https://connect.cept.ac.in/UserProfilePhoto/Default_Avtar.png";
                            $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');

                            //$("#tutorimg").append('<div><div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-top:13px; height:80px;" id=title' + i + '> Co-Tutor Profile: </div>');
                            //$("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px; margin-top:10px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                            //$("#tutorimg").append('<div style="width:9%;float:left;" id = img' + i + '></div></div></br>');
                            //var imgurl = "https://connect.cept.ac.in/UserProfilePhoto/Default_Avtar.png";
                            //$('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');
                        }
                        else {
                            $("#tutorimg").append('<div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-left:13px; height:80px;" id=title' + i + '> Tutor Profile: </div>');
                            $("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                            $("#tutorimg").append('<div style="width:9%;float:left; margin-left:17px;height:100px;" id = img' + i + '></div>');
                            var imgurl = "https://connect.cept.ac.in/UserProfilePhoto/Default_Avtar.png";
                            $('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');

                            //$("#tutorimg").append('<div><div style="width:18.2%;float:left;color:#b4b4b4;font-weight:bold; margin-top:13px; height:80px;" id=title' + i + '> Tutor Profile: </div>');
                            //$("#tutorimg").append('<div style="width:62.6%;float:left;border: 1px solid #e9e9e9; padding:8px; margin-top:10px;" id = description' + i + '>' + profile_data[i]["tutor_description"] + '</div>');
                            //$("#tutorimg").append('<div style="width:9%;float:left;" id = img' + i + '></div></div></br>');
                            //var imgurl = "https://connect.cept.ac.in/UserProfilePhoto/Default_Avtar.png";
                            //$('div #img' + i + '').append('<img id="theImg' + i + '" src="' + imgurl + '"style="width:105px;height:90px;"/>');
                        }
                        img.setAttribute('data-bind_row_no', (i + 1));
                    }
                }
            }
        }
        function getinst_time_slot()
        {
            if ($('#insttimeslot').val() != "") {

                gettimeslot_data(JSON.parse($('#insttimeslot').val()));
            }
        }
        function gettimeslot_data(data)
        {
            var str = '';
            var inst_code = '';
            for (var j = 0; j < data.length; j++)
            {
                if (data[j]['instructor_code'] == inst_code)
                {
                    str += "<tr><td>" + data[j]['from_time'] + "</td><td>" + data[j]['to_time'] + "</td><td>" + data[j]['day_name'] + "</td><td>" + data[j]['room_id'] + "</td></tr>";
                    inst_code = data[j]['instructor_code'];
                }
                else
                {
                    str += "<tr><td colspan='4'>" + data[j]['instructor_name'] + "</td></tr>";
                    str += "<tr><td>" + data[j]['from_time'] + "</td><td>" + data[j]['to_time'] + "</td><td>" + data[j]['day_name'] + "</td><td>" + data[j]['room_id'] + "</td></tr>";
                    inst_code = data[j]['instructor_code'];
                    
                }
            }
            if (str != '') {
                $('#time_slot_tbody').html('');
                $('#time_slot_tbody').append(str);
                $('#inst_time_slot').css('display', 'block');

            }
            else { $('#inst_time_slot').css('display', 'none');}
        }


        function get_course_wise_time_slot() {
            if ($('#coursewisetimeslot').val() != "") {

                get_course_wise_timeslot_data(JSON.parse($('#coursewisetimeslot').val()));
            }
        }

        function get_course_wise_timeslot_data(data) {
            var str = '';
            for (var j = 0; j < data.length; j++)
            {      
             str += "<tr><td>" + data[j]['from_time'] + "</td><td>" + data[j]['To_time'] + "</td><td>" + data[j]['day_name'] + "</td><td>" + data[j]['room_id'] + "</td></tr>";
                
            }
            if (str != '') {
                $('#coursewisetime_slot_tbody').html('');
                $('#coursewisetime_slot_tbody').append(str);
                $('#course_wise_time_slot').css('display', 'block');

            }
            else { $('#course_wise_time_slot').css('display', 'none'); }
        }

    </script>

    <style type="text/css">
        .square {
            height: 10px;
            width: 10px;
            background-color: #555;
            float: right;
            margin-top: 5px;
        }

        table, th, td {
            border: 1px solid #e9e9e9;
            border-collapse: collapse;
            padding: 8px;
        }

        .col-md-9 {
            padding-left: 0;
        }

        .col-md-2 {
            width: 18% !important;
            padding-right: 0;
        }

        .courseimg {
            height: 100px;
            /*width: 150px;*/
        }

        #img1, #img2, #img3, #img4, #img5, #img6, #img7 {
            height: 300px;
            margin-left: 10px;
        }

        /* Comment By Ananth*/
        /*#mainimg
        {
            margin-bottom: 16px;
        }*/

        #maining {
            margin-bottom: 4px;
        }

        .pddltrt {
            padding-left: 0px;
            padding-right: 0px;
        }

        .weekrow {
            margin-left: 103px;
            margin-bottom: 3px;
        }

        .cls_div_img {
            z-index: 1000;
            float: left;
            margin-right: 5px;
        }

            .cls_div_img:hover {
                z-index: 1001;
            }

        /*.cls_img_up:hover
        {
            -ms-transform: scale(2.2); /* IE 9 */
        /*-webkit-transform: scale(2.2); /* Safari 3-8 */
        /*transform: scale(2.2);*/
        /*}*/

        /*.cls_img_up:hover ~ div
            {
                -ms-transform: scale(3.0); /* IE 9 */
        /*-webkit-transform: scale(3.0); /* Safari 3-8 */
        /*transform: scale(3.0);
                position: absolute;
                margin-top: 140px;
                background: #cac3c4;
                font-size: 7px;
                padding: 0 10px;*/
        /*}*/

        .below-caption {
            display: none;
        }

        /*.cls_img_below:hover
        {
            -ms-transform: scale(3.0); /* IE 9 */
        /*-webkit-transform: scale(3.0); /* Safari 3-8 */
        /*transform: scale(3.0);*/
        /*}*/

        /*.cls_img_below:hover ~ div
            {
                -ms-transform: scale(2.0); /* IE 9 */
        /*-webkit-transform: scale(2.0); /* Safari 3-8 */
        /*transform: scale(2.0);
                position: absolute;
                margin-top: 110px;
                background: #cac3c4;
                font-size: 7px;
                padding: 0 10px;
                display: block;
            }*/

        .align_text {
            text-align: justify;
        }
    </style>

    <title></title>
</head>
<body>
    <div class="" id="my_outline" style="padding-left: 50px;">
        <%-- <button style="float: right" class="btn btn-lg btn-primary" id="btn_print_outline">Print outline</button>--%>
        <div class="" id="my_print_outline" style="margin-bottom: 150px; padding-left: 21px;">

            <div class="row" style="">
                <div class="panel-heading col-md-12" style="margin-top: 10px;">
                    <div id="head_data" style="margin-left: 3%; text-align: center; font-weight: bold; font-style: initial;">
                    </div>
                </div>
                <div id="img" class="row col-md-6" style="float: right; margin-right: -11%; margin-top: 5px;">
                    <%-- <img  class="col-md-3" style="height:142px; width:134px; display:none;" id="tutor_img1" target="_blank"/>--%>
                    <%--<img  class="col-md-3"style="height:142px; width:134px; display:none;" id="tutor_img2" target="_blank"/>--%>
                </div>
                <div id="profile_name" class="row"></div>

            </div>
            <div class="panel-body">
                <%--<div class="row" style="float:right">
                    <div id="img" class="row"></div>
                        <div id="profile_name" class="row"></div>
                </div>--%>
                <%--<div class="row">
                    <div class="form-group col-md-2 color-blue">
                        <div id="course_code" class="align_text" style="font-weight:bold">
                        </div>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="tutors" class="align_text" style="font-weight:bold">
                        </div>
                    </div>
                </div>--%>

                <%--<div class="row" style="margin-bottom: 10px">
                    <div class="form-group col-md-2 color-blue"style="display:none">
                        <b>Detailed Course Outline :</b>
                    </div>
                    <div class="form-group col-md-9" style="padding-left: 0;">
                        <div class="form-group col-md-5" style="padding-left: 0;display:none">
                            <div id="course_name">
                            </div>
                        </div>
                        <div class="form-group col-md-2" style="padding-left: 0;display:none">
                            <b>Name of Tutor :</b>
                        </div>
                        <div class="form-group col-md-4" style="padding-left: 0; padding-right: 0;">
                            <%--<div id="tutors">
                            </div>
                        </div>
                    </div>
                </div>--%>
                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Title:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <span id="course_code" class="align_text" style="font-weight: bold"></span>
                        <span id="course_name" class="align_text" style="font-weight: bold"></span>

                    </div>
                </div>
                  

                <div class="row" id="subtitlevalue" style="display:none;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Sub Title:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <span id="subtitle_course_name" class="align_text" style="font-weight: bold"></span>

                    </div>
                </div>


                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Tutor/s:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="tutors" class="align_text" style="font-weight: bold">
                        </div>
                    </div>
                </div>

                <div class="row" id="mode_text" style="display:none;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Mode:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="mode" class="align_text" style="font-weight: bold">
                        </div>
                    </div>
                </div>
                <%-- Course Title Command --%>
                <%-- <div class="row" style="margin-top:10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Title :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="course_title" class="align_text" style="font-weight:bold">
                        </div>
                    </div>
                </div>--%>
                <div class="row" id="mainimg" style="display: none; margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Excellent Sample Output Images:</b>
                    </div>
                </div>
                <%--<div class="row">
                     <div class="form-group col-md-11 cls_div_img">
                        <div class="form-group cls_div_img pddltrt"> <%--style="margin-right: 20px;"--%>
                <%--<img id="img1" class="cls_img_up" style="display: none;" />
                            <div style="float:left; margin-left:3%;">(Other images click here)
                            <div class="square" id="dis_image1" onclick="dis_image1()">
                            </div>
                                <div class="square" style="margin-right:8px;margin-left:8px;" id="dis_image2" onclick="dis_image2()">
                            </div>
                            </div>
                            <div id="div_caption1" style="display:none"></div>
                        </div>
                        <div class="form-group cls_div_img">
                            <img id="img2" class="cls_img_up" style="display: none;" />
                            <div id="div_caption2" style="display:none"></div>
                        </div>
                    </div>
                </div>--%>
                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                    </div>
                    <div class="form-group col-md-9 cls_div_img" style="margin-left: -10px;">
                        <img id="img1" class="" style="display: none;" />
                        <img id="img2" class="" style="display: none;" />
                        <img id="img3" class="" style="display: none;" />
                        <img id="img4" class="" style="display: none;" />
                        <img id="img5" class="" style="display: none;" />
                        <img id="img6" class="" style="display: none;" />
                        <img id="img7" class="" style="display: none;" />
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-11">
                        <b style="float: left; display: none;" id="clk_other_img">(Other images click here)</b>
                        <div class="square" id="square1" onclick="dis_image1()" style="float: left; display: none; margin-left: 26px"></div>
                        <div class="square" id="square2" onclick="dis_image2()" style="float: left; margin-left: 10px; display: none;"></div>
                        <div class="square" id="square3" onclick="dis_image3()" style="float: left; margin-left: 10px; display: none;"></div>
                        <div class="square" id="square4" onclick="dis_image4()" style="float: left; margin-left: 10px; display: none;"></div>
                        <div class="square" id="square5" onclick="dis_image5()" style="float: left; margin-left: 10px; display: none;"></div>
                        <div class="square" id="square6" onclick="dis_image6()" style="float: left; margin-left: 10px; display: none;"></div>
                        <div class="square" id="square7" onclick="dis_image7()" style="float: left; margin-left: 10px; display: none;"></div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Link to CEPT Portfolio :</b><br />
                        <p style="color: #b4b4b4; font-size: x-small; line-height: 1.2">
                            (studio work from past<br />
                            semesters)
                        </p>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txt_link" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;">
                            <%--<b>Monsoon 2019  - <a href="" id="links0">Link1</a></b><br />
                            <b>Spring 2018   - <a href="" id="links1">Link2</a></b><br />
                            <b>Monsoon 2018  - <a href="" id="links2">Link3</a></b><br />--%>
                        </div>
                    </div>

                </div>
                <%--<div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Brief Description : </b>
                        <br/> 
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txtcourse_description" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;">
                        </div>
                    </div>
                </div>--%>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Brief Introduction : </b>
                        <br/> (Ensure that the first two / three / four sentences of the studio brief clearly state what the studio will result in - using simple jargon-free language.)
                    </div>
                    <div class="form-group col-md-9">
                        <pre id="txtbrief_introduction" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif;background:white;">
                           
                        </pre>
                    </div>
                </div>


                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Long Description : </b>
                        <br/> <%--(170-200 words)--%>
                    </div>
                    <div class="form-group col-md-9">
                        <pre id="txtcourse_outline" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;font-family:Helvetica Neue,Helvetica,Arial,sans-serif;background:white;">
                        </pre>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Expense :</b><br />
                        <p style="color: #b4b4b4; font-size: x-small; line-height: 1.2">
                            (INR -extra expenditure a<br />
                            student would
                         incur during<br />
                            the semester)
                        </p>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="div_course_expense" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;"></div>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Prerequisite: </b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="course_prerequisite" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;">
                        </div>
                    </div>
                </div>
                <div class="row problem_statement" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Problem Statement: </b>
                        </br> <%--(Max 30 words)--%>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="problem_statement" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Learning Outcomes :</b>
                        </br> <%--(Max 90 words)--%>
                    </div>
                    <div class="form-group col-md-9" style="border: 1px solid #e9e9e9; padding: 8px; width: 73.4%">
                        <div id="lear_outcome" class="align_text">
                        </div>
                        <div id="lear_outcome1" class="align_text">
                        </div>
                        <div id="lear_outcome2" class="align_text">
                        </div>
                        <div id="lear_outcome3" class="align_text">
                        </div>
                        <div id="lear_outcome4" class="align_text">
                        </div>
                        <div id="lear_outcome5" class="align_text">
                        </div>
                    </div>
                </div>

                <div class="row" id="course_wise_time_slot" style="display: none; margin-top: 10px; width: 100%">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Time</b>
                        </br><b style="color: #b4b4b4;"> Slot:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <table>
                            <tr>
                                <td><b>From Time</b></td>
                                <td><b>To Time</b></td>
                                <td><b>Day</b></td>
                                <td><b>Room Id</b></td>
                            </tr>
                            <tbody id="coursewisetime_slot_tbody">

                        </tbody>
                        </table>
                        
                    </div>
                </div>

                <div class="row" id="div_weekly_plan" style="display: none; margin-top: 10px; page-break-before: always">
                    <%-- <hr />--%>
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Weekly Plan &</b>
                        </br><b style="color: #b4b4b4;">Assessment:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <table>
                            <%--<tr>
                            <th style="width:13%">Weeks</th>
                            <th style="width:55%">Exercise Description</th> 
                            <th>Assessment Percentage</th>
                            <th>Assessment Criteria</th>
                        </tr>--%>
                            <tr>
                                <th rowspan="2" style="width: 4%">Weeks</th>
                                <th rowspan="2" style="width: 24%">Exercise Description</th>
                                <th colspan="2" style="width: 27%">Assessment</th>
                                <%-- <th style="width:37%">Assessment Criteria</th>--%>
                                <%--<th colspan="2" style="width:13%">Assessment Percentage</th>
                            <th style="width:37%">Assessment Criteria</th>--%>
                            </tr>
                            <tr>
                                <th style="width: 3%">%</th>
                                <th>Criteria</th>
                            </tr>
                            <tr class="week_none_1">
                                <td>
                                    <b>Week &nbsp; 1</b>
                                </td>
                                <td>
                                    <div id="txt_week1"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per1"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt1"></div>
                                </td>
                            </tr>
                            <tr class="week_none_2">
                                <td>
                                    <b>Week &nbsp; 2</b>
                                </td>
                                <td>
                                    <div id="txt_week2"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per2"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt2"></div>
                                </td>
                            </tr>
                            <tr class="week_none_3">
                                <td>
                                    <b>Week &nbsp; 3</b>
                                </td>
                                <td>
                                    <div id="txt_week3"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per3"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt3"></div>
                                </td>
                            </tr>
                            <tr class="week_none_4">
                                <td>
                                    <b>Week &nbsp; 4</b>
                                </td>
                                <td>
                                    <div id="txt_week4"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per4"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt4"></div>
                                </td>
                            </tr>
                            <tr class="week_none_5">
                                <td>
                                    <b>Week &nbsp; 5</b>
                                </td>
                                <td>
                                    <div id="txt_week5"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per5"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt5"></div>
                                </td>
                            </tr>
                            <tr class="week_none_6">
                                <td>
                                    <b>Week &nbsp; 6</b>
                                </td>
                                <td>
                                    <div id="txt_week6"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per6"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt6"></div>
                                </td>
                            </tr>
                            <tr class="week_none_7">
                                <td>
                                    <b>Week &nbsp; 7</b>
                                </td>
                                <td>
                                    <div id="txt_week7"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per7"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt7"></div>
                                </td>
                            </tr>
                            <tr class="week_none_8">
                                <td>
                                    <b>Week &nbsp; 8</b>
                                </td>
                                <td>
                                    <div id="txt_week8"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per8"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt8"></div>
                                </td>
                            </tr>
                            <tr class="week_none_9">
                                <td>
                                    <b>Week &nbsp; 9</b>
                                </td>
                                <td>
                                    <div id="txt_week9"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per9"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt9"></div>
                                </td>
                            </tr>
                            <tr class="week_none_10">
                                <td>
                                    <b>Week &nbsp; 10</b>
                                </td>
                                <td>
                                    <div id="txt_week10"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per10"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt10"></div>
                                </td>
                            </tr>
                            <tr class="week_none_11">
                                <td>
                                    <b>Week &nbsp; 11</b>
                                </td>
                                <td>
                                    <div id="txt_week11"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per11"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt11"></div>
                                </td>
                            </tr>
                            <tr class="week_none_12">
                                <td>
                                    <b>Week &nbsp; 12</b>
                                </td>
                                <td>
                                    <div id="txt_week12"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per12"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt12"></div>
                                </td>
                            </tr>
                            <tr class="week_none_13">
                                <td>
                                    <b>Week &nbsp; 13</b>
                                </td>
                                <td>
                                    <div id="txt_week13"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per13"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt13"></div>
                                </td>
                            </tr>
                            <tr class="week_none_14">
                                <td>
                                    <b>Week &nbsp; 14</b>
                                </td>
                                <td>
                                    <div id="txt_week14"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per14"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt14"></div>
                                </td>
                            </tr>
                            <tr class="week_none_15">
                                <td>
                                    <b>Week &nbsp; 15</b>
                                </td>
                                <td>
                                    <div id="txt_week15"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per15"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt15"></div>
                                </td>
                            </tr>
                            <tr class="week_none_16">
                                <td>
                                    <b>Week &nbsp; 16</b>
                                </td>
                                <td>
                                    <div id="txt_week16"></div>
                                </td>
                                <td>
                                    <div id="txt_week_per16"></div>
                                </td>
                                <td>
                                    <div id="txt_week_crt16"></div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%--   <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt ">
                            
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            
                        </div>
                      </div>
                      <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt ">
                            <b>Week &nbsp; 2 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week2" class="align_text"></div>
                        </div>
                      </div>
                       <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 3 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week3"></div>
                        </div>
                       </div>
                       <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue  pddltrt ">
                            <b>Week &nbsp; 4 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt ">
                            <div id="txt_week4" class="align_text"></div>
                        </div>
                       </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 5 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week5"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 6 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt ">
                            <div id="txt_week6" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 7 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week7"></div>
                        </div>
                     </div>
                     <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 8 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week8" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 9 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week9"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 10 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week10" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 11 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week11"></div>
                        </div>
                        </div>
                        <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 12 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week12" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 13 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week13"></div>
                        </div>
                    </div>
                        <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 14 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week14" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 15 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week15"></div>
                        </div>
                        </div>
                        <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 16 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week16" class="align_text"></div>
                        </div>
                    </div>--%>
                </div>


                

                <div class="row" id="inst_time_slot" style="display: none; margin-top: 10px; width: 100%">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Instructor Time</b>
                        </br><b style="color: #b4b4b4;"> Slot:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <table>
                            <tr>
                                <td><b>From Time</b></td>
                                <td><b>To Time</b></td>
                                <td><b>Day</b></td>
                                <td><b>Room Id</b></td>
                            </tr>
                            <tbody id="time_slot_tbody">

                        </tbody>
                        </table>
                        
                    </div>
                </div>

                <div id="div_course_structure" class="row" style="margin-top: 10px; display: none; page-break-before: always">
                    <%-- <hr />--%>
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Structure :</b>
                    </div>
                    <div class="form-group col-md-9" style="border: 1px solid #e9e9e9; padding: 8px; width: 73.4%">
                        <div id="txtcourse_structure">
                        </div>
                    </div>
                </div>

                <div class="row" id="co_ass" style="margin-top: 10px;display:none;">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Course Assessment :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="div_course_assessment_new"></div>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px; page-break-before: always">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">References :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txt_reference" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px; display: none">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Evaluation Method :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txt_eval_method" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;">
                        </div>
                    </div>
                </div>

                <div class="row" style="display: none; margin-top: 10px;" id="tut1">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Tutor Profile:</b>
                        </br> <%--(50-60 words)--%>
                    </div>
                    <div class="form-group col-md-9">
                        <div class="col-md-9" id="tutor_description1" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;">
                        </div>
                        <div class="col-md-2">
                            <img style="height: 130px; width: 134px; display: none; float: right; margin-right: 15px;" id="tutor_img1" target="_blank" />
                        </div>
                    </div>
                    <%--<div class="form-group col-md-1">--%>
                    <%-- <img style="height:120px; width:145px; display:none; float:right;" id="tutor_img1" target="_blank"/>--%>
                    <%--</div>--%>
                    <%--<div class="form-group col-md-3>
                        <img  class="col-md-3" style="height:142px; width:134px; display:none; float:right; margin-right:15px;" id="tutor_img1" target="_blank"/>
                        <img  class="col-md-3" style="height:142px; width:134px; display:none; float:right; margin-right:15px;" id="tutor_img1" target="_blank"/>
                    </div>--%>
                </div>
                <div class="row" style="display: none; margin-top: 10px;" id="tut2">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Co-Tutor Profile:</b>
                        </br> <%--(50-60 words)--%>
                    </div>
                    <div class="form-group col-md-9">
                        <div class="col-md-9" id="tutor_description2" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;"></div>
                        <div class="col-md-2">
                            <img class="col-md-3" style="height: 130px; width: 134px; display: none; float: right;" id="tutor_img2" target="_blank" />
                        </div>
                    </div>

                    <%-- <div class="form-group col-md-6" style="margin-left:-14px">
                        <div id="tutor_description2" class="align_text" style="border:1px solid #e9e9e9; padding:8px;"></div>
                    </div>
                    <div class="form-group col-md-3">
                        <img  class="col-md-3" style="height:142px; width:134px; display:none; float:right; margin-right:15px;" id="tutor_img2" target="_blank"/>

                    </div>--%>
                </div>
                <div class="row" style="margin-top: 10px; display: none">
                    <div class="form-group col-md-2 color-blue">
                        <b style="color: #b4b4b4;">Co-Tutor Profile:</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="div_course_assessment" class="align_text" style="border: 1px solid #e9e9e9; padding: 8px;"></div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;" id="tutorimg">
                </div>


                <%-- <div class="row" style="margin-top: 10px;display:none">
                    <div class="form-group col-md-2 color-blue" id="img567" style="display: none;">
                        <b style="color: #b4b4b4;">Image of Final Output:</b>
                    </div>
                    <div class="form-group">
                        <div class="cls_div_img">
                            <img id="img3" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption3" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img4" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption4" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img5" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption5" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img6" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption6" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img7" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption7" class="below-caption"></div>
                        </div>
                    </div>
                </div>--%> <I>Note :  This course outline is subject to change.</I>
            </div>
        </div>
    </div>

    <input type="hidden" id="hdn_outline" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdnres" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdnres1" runat="server" />
    <input type="hidden" id="hdn_tutor_profile" runat="server" />
    <input type="hidden" id="portfoliolink" runat="server" />
    <input type="hidden" id="insttimeslot" runat="server" />
    <input type="hidden" id="coursewisetimeslot" runat="server" />
    <input type="hidden" id="hdn_new_tab" runat="server" clientidmode="Static" />
</body>
</html>
