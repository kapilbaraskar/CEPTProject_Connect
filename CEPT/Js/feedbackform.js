var oTable;
var instructor_data = '';
var instructor_data_AA = '';
var instructor_data_TA = '';
var saved_data = '';
var feedbcak_instructions_data = '';
var obj_typology_data = [];
var que_at_last = '';
var que_at_last_to_last = '';
var learning_outcome_hide_show = false;

$(document).ready(function () {
    $("input:radio[name=taught_supporte_AA]").click(function () {
        if ($("input[type='radio'][name='taught_supporte_AA']:checked").val() == "Y") {
            $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'block');
        }
        else {
            $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'none');
        }
    });

    $("input:radio[name=taught_supporte_TA]").click(function () {
        if ($("input[type='radio'][name='taught_supporte_TA']:checked").val() == "Y") {
            $('#div_tick_TS_yes,#div_TA_instructor').css('display', 'block');
        }
        else {
            $('#div_tick_TS_yes,#div_TA_instructor').css('display', 'none');
        }
    });

    //$("input:radio").click(function () {
    //    alert('hi');
    //    if ($("input[type='radio'][name='taught_supporte_AA']:checked").val() == "Y") {
    //        $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'block');
    //    }
    //    else {
    //        $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'none');
    //    }
    //});

    $("input:radio[name=taught_supporte_yesssssss]").click(function () {
        $('#div_AA_instructor').html('');

        if ($("input[type='radio'][name='taught_supporte_yes']:checked").val() == "T") {
            for (var i = 0; i < instructor_data.length; i++) {
                var str_instructor = '';

                if (instructor_data[i]["designation"] == 'AA' || instructor_data[i]["designation"] == 'TA') {
                    //if ($('#course_type').val() == '7') {
                    //    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //}
                    //else {

                    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";

                    //}

                    str_instructor = str_instructor + "<table id=" + ('table_taught' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                    str_instructor = str_instructor + "</thead> <tbody>";

                    var comments = '';

                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                        if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";

                            str_instructor += "</tr>";
                        }
                    }

                    str_instructor = str_instructor + "</tbody></table>";
                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data[i]["instructor_name"] + " :</b></p>";
                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + ('table_taught' + parseInt(i + 1) + 'instruction') + "' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
                    $('#div_AA_instructor').append(str_instructor);
                }
            }
            $('#div_AA_instructor').css('display', 'block');
        }
        else {
            for (var i = 0; i < instructor_data.length; i++) {
                var str_instructor = '';

                if (instructor_data[i]["designation"] == 'AA' || instructor_data[i]["designation"] == 'TA') {
                    //if ($('#course_type').val() == '7') {
                    //    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //}
                    //else {
                    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";
                    //}

                    str_instructor = str_instructor + "<table id=" + ('table_supported' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                    str_instructor = str_instructor + "</thead> <tbody>";

                    var comments = '';

                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                        if (feedbcak_instructions_data[j]["feedback_type"] == "AA" || feedbcak_instructions_data[j]["feedback_type"] == "TA") {
                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";

                            str_instructor += "</tr>";
                        }
                    }

                    str_instructor = str_instructor + "</tbody></table>";
                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data[i]["instructor_name"] + " :</b></p>";
                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + ('table_supported' + parseInt(i + 1) + 'instruction') + "' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
                    $('#div_AA_instructor').append(str_instructor);
                }
            }

            $('#div_AA_instructor').css('display', 'block');
        }
    });

    $("input:radio[name=taught_supporte_yesssssss]").click(function () {

        $('#div_TA_instructor').html('');

        if ($("input[type='radio'][name='taught_supporte_yes']:checked").val() == "T") {
            for (var i = 0; i < instructor_data.length; i++) {
                var str_instructor = '';

                if (instructor_data[i]["designation"] == 'TA') {
                    //if ($('#course_type').val() == '7') {
                    //    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //}
                    //else {

                    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";

                    //}

                    str_instructor = str_instructor + "<table id=" + ('table_taught' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                    str_instructor = str_instructor + "</thead> <tbody>";

                    var comments = '';

                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                        if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_taught' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";

                            str_instructor += "</tr>";
                        }
                    }

                    str_instructor = str_instructor + "</tbody></table>";
                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data[i]["instructor_name"] + " :</b></p>";
                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + ('table_taught' + parseInt(i + 1) + 'instruction') + "' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                    $('#div_AA_instructor').append(str_instructor);
                }
            }

            $('#div_TA_instructor').css('display', 'block');
        }
        else {
            for (var i = 0; i < instructor_data.length; i++) {
                var str_instructor = '';

                if (instructor_data[i]["designation"] == 'TA') {
                    //if ($('#course_type').val() == '7') {
                    //    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //}
                    //else {

                    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";

                    //}

                    str_instructor = str_instructor + "<table id=" + ('table_supported' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                    str_instructor = str_instructor + "</thead> <tbody>";

                    var comments = '';

                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                        if (feedbcak_instructions_data[j]["feedback_type"] == "TA") {
                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table_supported' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";

                            str_instructor += "</tr>";
                        }
                    }

                    str_instructor = str_instructor + "</tbody></table>";
                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data[i]["instructor_name"] + " :</b></p>";
                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + ('table_supported' + parseInt(i + 1) + 'instruction') + "' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                    $('#div_AA_instructor').append(str_instructor);
                }
            }

            $('#div_TA_instructor').css('display', 'block');
        }
    });

    //bind_assigned_data();

    check_saved_feedback();

    get_all_typology_group();
    hide_show_learning_outcome();
    display_form();

    $(":checkbox").change(function () {
        //alert('hi');
        $(this).html('kkkkkk');
    });

    $('.btnfeedback').live('click', function (e) {
        
        var row = $(this).closest("tr").get(0);
        var aData = oTable.fnGetData(row);

        var course = aData.course_code;

        $('.lblclass').text(aData.course);
        $('.lblclass').css('display', 'block');

        if (course != "") {
            if (saved_data != '') {
                for (var j = 0; j < saved_data.length; j++) {
                    if (saved_data[j]["course"] == course) {
                        bootbox.alert("You already saved selected Course's Feedback");

                        $('#divlecture').css('display', 'none');
                        $('#divseminar').css('display', 'none');
                        $('#divworkshop').css('display', 'none');
                        $('#divstudio').css('display', 'none');
                        $('.lblclass').css('display', 'none');

                        return false;
                    }
                }
            }

            var coucourse_split = course.split('~');

            $('#course_code').val(coucourse_split[0]);
            $('#course_type').val(coucourse_split[1]);
            $('#course_type_name').text('');

            var course_typology = '';

            //old 
            //if (coucourse_split[1] == "3" || coucourse_split[1] == "4") { // for lecture
            //    course_typology = '3';
            //    $('#course_type_name').text('Lecture Course');
            //}
            //else if (coucourse_split[1] == "5" || coucourse_split[1] == "6" || coucourse_split[1] == "13") { // for seminar
            //    course_typology = '5';
            //    $('#course_type_name').text('Seminar Course');
            //}
            //else if (coucourse_split[1] == "9" || coucourse_split[1] == "1" || coucourse_split[1] == "8") { // for workshop
            //    course_typology = '1';
            //    $('#course_type_name').text('Workshop Course');
            //}
            //else if (coucourse_split[1] == "7") {
            //    course_typology = coucourse_split[1];
            //    $('#course_type_name').text('Studio Course');
            //}

            //if (coucourse_split[1] == "3" || coucourse_split[1] == "4" || coucourse_split[1] == "12")
            if (coucourse_split[1] == "3" || coucourse_split[1] == "4" || coucourse_split[1] == "12" || coucourse_split[1] == "18") { // for lecture
                course_typology = '3';
                $('#course_type_name').text('Lecture Course');
            }
            //else if (coucourse_split[1] == "5" || coucourse_split[1] == "6" || coucourse_split[1] == "13") 
            else if (coucourse_split[1] == "5" || coucourse_split[1] == "6" || coucourse_split[1] == "13" || coucourse_split[1] == "19") { // for seminar
                course_typology = '5';
                $('#course_type_name').text('Seminar Course');
            }
            //else if (coucourse_split[1] == "9" || coucourse_split[1] == "1" || coucourse_split[1] == "8") 
            else if (coucourse_split[1] == "9" || coucourse_split[1] == "1" || coucourse_split[1] == "8" || coucourse_split[1] == "22") { // for workshop
                course_typology = '1';
                $('#course_type_name').text('Workshop Course');
            }
            else if (coucourse_split[1] == "7" || coucourse_split[1] == "14" || coucourse_split[1] == "20") {
                course_typology = "7";
                $('#course_type_name').text('Studio Course');
            }
            //else {
            //    bootbox.alert("This course is not eligible for feedback.");
            //    return false;
            //}

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_instructor_code_for_course_code",
                aSync: false,
                data: "{course_code:'" + coucourse_split[0] + "',course_typology:'" + course_typology + "'}",
                dataType: "json",
                success: function (data) {
                    //var str_instructor = '';

                    if (data.d != null) {
                        instructor_data = JSON.parse(data.d[0]);

                        // For Lecture

                        if (data.d[1] != null) {
                            $('#divseminar').css('display', 'none');
                            $('#divworkshop').css('display', 'none');
                            $('#divstudio').css('display', 'none');

                            $('#div_lecture').html('');
                            $('#div_seminar').html('');
                            $('#div_workshop').html('');
                            $('#div_studio').html('');

                            $('#course_lecture tbody').html('');
                            $('#online_learning tbody').html('');
                            $('#course_workshop tbody').html();
                            $('#course_studio tbody').html('');
                            $('#course_seminar tbody').html('');

                            feedbcak_instructions_data = JSON.parse(data.d[1]);

                            for (var i = 0; i < feedbcak_instructions_data.length; i++) {
                                if (feedbcak_instructions_data[i]["feedback_type"] == "course") {
                                    var str = "<tr><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkagree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkdisagree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkdisagree' /> </center></td> ";

                                    //if (feedbcak_instructions_data[i]["not_applicable"] == "Y") {
                                    //    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chknonapplicable' /> </center></td> ";
                                    //}
                                    //else {
                                    //    str += "<td></td> ";
                                    //}

                                    str += "</tr>";

                                    $('#course_lecture tbody').append(str);
                                }
                                else {

                                }

                                if (feedbcak_instructions_data[i]["feedback_type"] == "online_learning") {
                                    var str = "<tr><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkagree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkdisagree' /> </center></td> ";
                                    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chkdisagree' /> </center></td> ";

                                    //if (feedbcak_instructions_data[i]["not_applicable"] == "Y") {
                                    //    str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chknonapplicable' /> </center></td> ";
                                    //}
                                    //else {
                                    //    str += "<td></td> ";
                                    //}

                                    str += "</tr>";

                                    $('#online_learning tbody').append(str);
                                }
                                else {

                                }
                            }

                            for (var i = 0; i < instructor_data.length; i++) {
                                var str_instructor = " <br /><span style='color:green'><b> Instructor :: " + instructor_data[i]["instructor_name"] + "</b></span> ";
                                str_instructor = str_instructor + "<table id=" + ('table' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                                str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'>   <center><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b></center><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                                str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                                str_instructor = str_instructor + "</thead> <tbody>";

                                for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                                    if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
                                        str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";

                                        str_instructor += "</tr>";
                                    }
                                }

                                str_instructor = str_instructor + "</tbody></table>";
                                str_instructor = str_instructor + " <p><br /><b> Please write your open ended comments about  " + instructor_data[i]["instructor_name"] + " here:</b></p>";
                                str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + ('table' + parseInt(i + 1) + 'instruction') + "' style='width: 99%; height: 110px' rows='3' cols='5' name='address'></textarea></div>";

                                $('#div_lecture').append(str_instructor);
                            }

                            $('#divlecture').css('display', 'block');
                        }
                        else {
                            bootbox.alert("Feedback instructions not found in master table for selected typology.");

                            $('#divlecture').css('display', 'none');
                            $('#divseminar').css('display', 'none');
                            $('#divworkshop').css('display', 'none');
                            $('#divstudio').css('display', 'none');

                            $('#div_lecture').html('');
                            $('#div_seminar').html('');
                            $('#div_workshop').html('');
                            $('#div_studio').html('');

                            $('#course_lecture tbody').html('');
                            $('#online_learning tbody').html('');
                            $('#course_workshop tbody').html();
                            $('#course_studio tbody').html('');
                            $('#course_seminar tbody').html('');

                            return false;
                        }
                    }
                    else {

                        $('#divlecture').css('display', 'none');
                        $('#divseminar').css('display', 'none');
                        $('#divworkshop').css('display', 'none');
                        $('#divstudio').css('display', 'none');
                        $('.lblclass').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        else {
            $('#divlecture').css('display', 'none');
            $('#divseminar').css('display', 'none');
            $('#divworkshop').css('display', 'none');
            $('#divstudio').css('display', 'none');
            $('.lblclass').css('display', 'none');
        }
    });

    // For Lecture Save
    $('#btn_lecture').on('click', function () {
        var flag = 'N';
        var datalist = [];

        $("#course_lecture tbody tr").each(function (i) {
            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            //ob["instructor_code"] = $(this).find('.instructor_name').val();
            ob["instructor_code"] = "";
            //ob["description"] = $(this).children().eq(1).html().trim();
            ob["description"] = "";
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["rating"] = "";
            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                ob["sr_no"] = i + 1;
                ob["comments"] = $('#txt_course_instruction').val().trim();
                ob["releted_feedback"] = "course";

                if ($(this).find('.1:checked').val() || $(this).find('.2:checked').val() || $(this).find('.3:checked').val() || $(this).find('.4:checked').val() || $(this).find('.5:checked').val()
                    || $(this).find('.6:checked').val() || $(this).find('.7:checked').val() || $(this).find('.8:checked').val() || $(this).find('.9:checked').val() || $(this).find('.10:checked').val()) {

                }
                else {
                    bootbox.alert('Please select the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for the Course');
                    flag = 'Y';
                    return false;
                }

                if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
            }
            else if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                if ($(this).find('.cls_txt_course_comment').val() == '') {
                    bootbox.alert('Please Enter the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for the Course');
                    flag = 'Y';
                    return false;
                }

                ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                ob["comments"] = $(this).find('.cls_txt_course_comment').val();
                ob["releted_feedback"] = "course_comments";
            }

            datalist.push(ob);
        });
        
        if (!learning_outcome_hide_show) {
            debugger
            console.log('Hide Show campus' + learning_outcome_hide_show);
        $("#online_learning tbody tr").each(function (i) {
            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            //ob["instructor_code"] = $(this).find('.instructor_name').val();
            ob["instructor_code"] = "";
            //ob["description"] = $(this).children().eq(1).html().trim();
            ob["description"] = "";
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["rating"] = "";
            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            if ($(this).find('.cls_hdn_que_type_online_learning').val() == undefined) {

                //if (i + 1 == 11)
                //    ob["sr_no"] = 8;
                //else
                //    ob["sr_no"] = i + 1;

                if (i + 1 == 11)
                    ob["sr_no"] = 8;
                else if (i + 1 == 12)
                    ob["sr_no"] = 9;
                else
                    ob["sr_no"] = i + 1;

                ob["comments"] = $('#txt_course_instruction_online_learning').val().trim();
                ob["releted_feedback"] = "online_learning";

                if ($(this).find('.1:checked').val() || $(this).find('.2:checked').val() || $(this).find('.3:checked').val() || $(this).find('.4:checked').val() || $(this).find('.5:checked').val()
                    || $(this).find('.6:checked').val() || $(this).find('.7:checked').val() || $(this).find('.8:checked').val() || $(this).find('.9:checked').val() || $(this).find('.10:checked').val()) {

                }
                else {
                    if (i + 1 != 4) {
                        bootbox.alert('Please select the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for the Online Learning');
                        flag = 'Y';
                        return false;
                    }
                }

                if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
            }
            else if ($(this).find('.cls_hdn_que_type_online_learning').val() == 'comment') {
                if ($(this).find('.cls_txt_course_comment_online_learning').val().trim() == '') {
                    if (i + 1 != 8) {
                        bootbox.alert('Please Enter the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for the Online Learning');
                        flag = 'Y';
                        return false;
                    }
                }

                ob["sr_no"] = $(this).find('.cls_hdn_sr_no_online_learning').val();
                ob["comments"] = $(this).find('.cls_txt_course_comment_online_learning').val().trim();
                ob["releted_feedback"] = "online_learning_comments";
            }

            datalist.push(ob);
        });
        }
        if (flag == 'N') {
            if (instructor_data != null) {
                for (var i = 0; i < instructor_data.length; i++) {
                    if (flag == 'N') {
                        $("#table" + (i + 1) + " tbody tr").each(function (j) {
                            if ($(this).find('.1').is(':disabled') == false) {
                                var ob = {};

                                ob["course_code"] = $('#course_code').val();
                                ob["course_type"] = $('#course_type').val();
                                ob["instructor_code"] = instructor_data[i]['instructor_code'];
                                ob["description"] = "";
                                //ob["description"] = $(this).children().eq(1).html();
                                ob["strongly_agree"] = "N";
                                ob["agree"] = "N";
                                ob["neither_agree"] = "N";
                                ob["disagree"] = "N";
                                ob["strongly_disagree"] = "N";
                                ob["not_applicable"] = "N";
                                ob["rating"] = "";
                                ob["taught_supported_selection_AA"] = "";
                                ob["taught_supported_selection_if_yes"] = "";

                                if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                                    ob["sr_no"] = j + 1;
                                    ob["comments"] = $("#table" + (i + 1) + "instruction").val().trim();
                                    ob["releted_feedback"] = "instructor";

                                    if ($(this).find('.1:checked').val() || $(this).find('.2:checked').val() || $(this).find('.3:checked').val() || $(this).find('.4:checked').val() || $(this).find('.5:checked').val()
                                        || $(this).find('.6:checked').val() || $(this).find('.7:checked').val() || $(this).find('.8:checked').val() || $(this).find('.9:checked').val() || $(this).find('.10:checked').val()) {

                                    }
                                    else {
                                        bootbox.alert('Please select the appropriate response for <br /><b>"' + $(this).children().eq(1).html() + '"</b> for Instructor :' + instructor_data[i]['instructor_name']);
                                        flag = 'Y';
                                        return false;
                                    }

                                    if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                                    if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                                    if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                                    if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                                    if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                                    if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                                    if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                                    if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                                    if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                                    if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
                                }
                                else if ($(this).find('.cls_hdn_que_type').val() == 'comment' && $('input.check.' + $(this).closest('table').attr('id') + ':checked').val() == 'Y') {
                                    if ($(this).find('.cls_txt_course_comment').val() == '') {
                                        bootbox.alert('Please Enter the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for Instructor : ' + instructor_data[i]['instructor_name']);
                                        flag = 'Y';
                                        return false;
                                    }

                                    ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                                    ob["comments"] = $(this).find('.cls_txt_course_comment').val();
                                    ob["releted_feedback"] = "instructor_comments";
                                }

                                if ($('input.check.' + $(this).closest('table').attr('id') + ':checked').val() == undefined) {
                                    if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                                        if ($(this).find('.cls_txt_course_comment').val() == '') {
                                            bootbox.alert('Please Enter the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for Instructor : ' + instructor_data[i]['instructor_name']);
                                            flag = 'Y';
                                            return false;
                                        }

                                        ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                                        ob["comments"] = $(this).find('.cls_txt_course_comment').val();
                                        ob["releted_feedback"] = "instructor_comments";
                                        datalist.push(ob);
                                    }
                                    else {
                                        datalist.push(ob);
                                    }
                                }

                                if ($('input.check.' + $(this).closest('table').attr('id') + ':checked').val() == 'Y') {
                                    datalist.push(ob);
                                }
                            }
                        });
                    }
                }
            }

            if (instructor_data_AA != "") {
                for (var i = 0; i < instructor_data_AA.length; i++) {
                    var taught_supporte_AA_value = $("input[type='radio'][name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();

                    if (flag == 'N') {
                        if (taught_supporte_AA_value == "Y") {
                            if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == undefined) {
                                bootbox.alert('Please select Taught or Supported for ' + instructor_data_AA[i]["instructor_name"]);
                                flag = 'Y';
                                return false;
                            }

                            $("#table_taught-" + instructor_data_AA[i]["instructor_code"] + " tbody tr").each(function (j) {
                                if ($(this).find('.1').is(':disabled') == false) {
                                    var ob = {};

                                    ob["course_code"] = $('#course_code').val();
                                    ob["course_type"] = $('#course_type').val();
                                    ob["instructor_code"] = instructor_data_AA[i]['instructor_code'];
                                    //ob["description"] = $(this).children().eq(1).html();
                                    ob["description"] = "";
                                    ob["strongly_agree"] = "N";
                                    ob["agree"] = "N";
                                    ob["neither_agree"] = "N";
                                    ob["disagree"] = "N";
                                    ob["strongly_disagree"] = "N";
                                    ob["not_applicable"] = "N";
                                    ob["rating"] = "";

                                    ob["taught_supported_selection_AA"] = taught_supporte_AA_value;
                                    ob["taught_supported_selection_if_yes"] = $("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();

                                    if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                                        ob["sr_no"] = j + 1;
                                        ob["comments"] = $("#table_taught-" + instructor_data_AA[i]['instructor_code'] + "instruction").val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor";
                                        }
                                        else {
                                            ob["releted_feedback"] = "AA";
                                        }

                                        if ($(this).find('.1:checked').val() || $(this).find('.2:checked').val() || $(this).find('.3:checked').val() || $(this).find('.4:checked').val() || $(this).find('.5:checked').val()
                                            || $(this).find('.6:checked').val() || $(this).find('.7:checked').val() || $(this).find('.8:checked').val() || $(this).find('.9:checked').val() || $(this).find('.10:checked').val()) {

                                        }
                                        else {
                                            bootbox.alert('Please select the appropriate response for <br /><b>"' + $(this).children().eq(1).html() + '"</b> for Instructor :' + instructor_data_AA[i]['instructor_name']);
                                            flag = 'Y';
                                            return false;
                                        }

                                        if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                                        if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                                        if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                                        if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                                        if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                                        if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                                        if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                                        if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                                        if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                                        if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
                                    }
                                    else if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                                        if ($(this).find('.cls_txt_course_comment').val() == '') {
                                            bootbox.alert('Please Enter the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for AA Instructor : ' + instructor_data_AA[i]['instructor_name']);
                                            flag = 'Y';
                                            return false;
                                        }

                                        ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                                        ob["comments"] = $(this).find('.cls_txt_course_comment').val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor_comments";
                                        }
                                        else {
                                            ob["releted_feedback"] = "AA_comments";
                                        }
                                    }

                                    datalist.push(ob);
                                }
                            });
                        }
                    }
                }
            }

            // TA Save DaTa
            if (instructor_data_TA != "") {
                for (var i = 0; i < instructor_data_TA.length; i++) {
                    var taught_supporte_TA_value = $("input[type='radio'][name='taught_supporte_TA~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val();

                    if (flag == 'N') {
                        if (taught_supporte_TA_value == "Y") {
                            if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val() == undefined) {
                                bootbox.alert('Please select Taught or Supported for ' + instructor_data_TA[i]["instructor_name"]);
                                flag = 'Y';
                                return false;
                            }

                            $("#table_taught-" + instructor_data_TA[i]["instructor_code"] + " tbody tr").each(function (j) {
                                if ($(this).find('.1').is(':disabled') == false) {
                                    var ob = {};

                                    ob["course_code"] = $('#course_code').val();
                                    ob["course_type"] = $('#course_type').val();
                                    ob["instructor_code"] = instructor_data_TA[i]['instructor_code'];
                                    //ob["description"] = $(this).children().eq(1).html();
                                    ob["description"] = "";
                                    ob["strongly_agree"] = "N";
                                    ob["agree"] = "N";
                                    ob["neither_agree"] = "N";
                                    ob["disagree"] = "N";
                                    ob["strongly_disagree"] = "N";
                                    ob["not_applicable"] = "N";
                                    ob["rating"] = "";

                                    ob["taught_supported_selection_AA"] = taught_supporte_TA_value;
                                    ob["taught_supported_selection_if_yes"] = $("input[type='radio'][name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val();

                                    if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                                        ob["sr_no"] = j + 1;
                                        ob["comments"] = $("#table_taught-" + instructor_data_TA[i]['instructor_code'] + "instruction").val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor";
                                        }
                                        else {
                                            ob["releted_feedback"] = "TA";
                                        }

                                        if ($(this).find('.1:checked').val() || $(this).find('.2:checked').val() || $(this).find('.3:checked').val() || $(this).find('.4:checked').val() || $(this).find('.5:checked').val()
                                            || $(this).find('.6:checked').val() || $(this).find('.7:checked').val() || $(this).find('.8:checked').val() || $(this).find('.9:checked').val() || $(this).find('.10:checked').val()) {

                                        }
                                        else {
                                            bootbox.alert('Please select the appropriate response for <br /><b>"' + $(this).children().eq(1).html() + '"</b> for Instructor :' + instructor_data_TA[i]['instructor_name']);
                                            flag = 'Y';
                                            return false;
                                        }

                                        if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                                        if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                                        if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                                        if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                                        if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                                        if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                                        if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                                        if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                                        if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                                        if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
                                    }
                                    else if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                                        if ($(this).find('.cls_txt_course_comment').val() == '') {
                                            bootbox.alert('Please Enter the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for TA Instructor : ' + instructor_data_TA[i]['instructor_name']);
                                            flag = 'Y';
                                            return false;
                                        }

                                        ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                                        ob["comments"] = $(this).find('.cls_txt_course_comment').val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor_comments";
                                        }
                                        else {
                                            ob["releted_feedback"] = "TA_comments";
                                        }
                                    }

                                    datalist.push(ob);
                                }
                            });
                        }
                    }
                }
            }
        }

        $("#tbl_student_engagement tr").each(function (i) {
            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            ob["instructor_code"] = "";
            ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
            ob["description"] = "";
            ob["comments"] = "";
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["rating"] = "";
            ob["releted_feedback"] = "student";
            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            for (var j = 0; j < $(this).find('.cls_stud_engage_option input').length; j++) {
                if ($(this).find('.cls_stud_engage_option input')[j].checked) { ob["rating"] = $(this).find('.cls_stud_engage_option input')[j].value; }
            }

            //if (ob["rating"] == "") {
            //    bootbox.alert('Please select the appropriate response for Question ' + (i + 1) + ' in Student Engagement Section');
            //    flag = 'Y';
            //    return false;
            //}

            //datalist.push(ob);
        });

        var course_aspect = '';
        var course_suggestion = '';

        if (flag == 'N') {
            var data = JSON.stringify({ table_data: JSON.stringify(datalist), course_aspect: course_aspect, course_suggestion: course_suggestion, submit_status: 'Y', taught_supported_selection_AA: "", taught_supported_selection_if_yes: "" });

            //alert('hi');

            bootbox.confirm({
                // title: "danger - danger - danger",
                message: "You cannot edit or resubmit your feedback so please recheck before submitting.",
                buttons: {
                    cancel: {
                        label: "Recheck"
                        //className: "btn-default pull-left"
                    },
                    confirm: {
                        label: "Submit"
                        //className: "btn-danger pull-right"
                    }
                },
                callback: function (result) {
                    if (result == true) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../WebService.asmx/save_feedback_data_new",
                            data: data,
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "") {
                                    bootbox.alert(data.d);
                                    window.location.href = "Feedback_dashboard.aspx";
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                    }
                }
            });
        }

        return false;
    });

    // For Save
    $('#btn_save').on('click', function () {
        var flag = 'N';
        var datalist = [];

        $("#course_lecture tbody tr").each(function (i) {
            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            //ob["instructor_code"] = $(this).find('.instructor_name').val();
            ob["instructor_code"] = "";
            //ob["description"] = $(this).children().eq(1).html().trim();
            ob["description"] = "";
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["rating"] = "";
            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                ob["sr_no"] = i + 1;
                ob["comments"] = $('#txt_course_instruction').val().trim();
                ob["releted_feedback"] = "course";

                if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
            }
            else if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                ob["comments"] = $(this).find('.cls_txt_course_comment').val();
                ob["releted_feedback"] = "course_comments";
            }

            datalist.push(ob);
        });
        
        if (!learning_outcome_hide_show) //07112022
        {
        $("#online_learning tbody tr").each(function (i) {
            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            //ob["instructor_code"] = $(this).find('.instructor_name').val();
            ob["instructor_code"] = "";
            //ob["description"] = $(this).children().eq(1).html().trim();
            ob["description"] = "";
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["rating"] = "";
            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            if ($(this).find('.cls_hdn_que_type_online_learning').val() == undefined) {
                if (i + 1 == 11)
                    ob["sr_no"] = 8;
                else if (i + 1 == 12)
                    ob["sr_no"] = 9;
                else
                    ob["sr_no"] = i + 1;

                ob["comments"] = $('#txt_course_instruction_online_learning').val().trim();
                ob["releted_feedback"] = "online_learning";

                if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
            }
            else if ($(this).find('.cls_hdn_que_type_online_learning').val() == 'comment') {
                ob["sr_no"] = $(this).find('.cls_hdn_sr_no_online_learning').val();
                ob["comments"] = $(this).find('.cls_txt_course_comment_online_learning').val().trim();
                ob["releted_feedback"] = "online_learning_comments";
            }

            datalist.push(ob);
        });
        }
        if (flag == 'N') {
            if (instructor_data != null) {
                for (var i = 0; i < instructor_data.length; i++) {
                    if (flag == 'N') {
                        $("#table" + (i + 1) + " tbody tr").each(function (j) {
                            var ob = {};

                            ob["course_code"] = $('#course_code').val();
                            ob["course_type"] = $('#course_type').val();
                            ob["instructor_code"] = instructor_data[i]['instructor_code'];
                            ob["description"] = "";
                            ob["strongly_agree"] = "N";
                            ob["agree"] = "N";
                            ob["neither_agree"] = "N";
                            ob["disagree"] = "N";
                            ob["strongly_disagree"] = "N";
                            ob["not_applicable"] = "N";
                            ob["rating"] = "";
                            ob["taught_supported_selection_AA"] = "";
                            ob["taught_supported_selection_if_yes"] = "";

                            if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                                ob["sr_no"] = j + 1;
                                ob["comments"] = $("#table" + (i + 1) + "instruction").val().trim();
                                ob["releted_feedback"] = "instructor";

                                if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                                if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                                if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                                if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                                if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                                if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                                if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                                if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                                if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                                if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
                            }
                            else if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                                ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                                ob["comments"] = $(this).find('.cls_txt_course_comment').val();
                                ob["releted_feedback"] = "instructor_comments";
                            }

                            datalist.push(ob);
                        });
                    }
                }
            }

            if (instructor_data_AA != "") {
                for (var i = 0; i < instructor_data_AA.length; i++) {
                    var taught_supporte_AA_value = $("input[type='radio'][name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();

                    if (flag == 'N') {
                        if (taught_supporte_AA_value == "Y") {
                            $("#table_taught-" + instructor_data_AA[i]["instructor_code"] + " tbody tr").each(function (j) {

                                if ($(this).find('.1').is(':disabled') == false) {
                                    var ob = {};

                                    ob["course_code"] = $('#course_code').val();
                                    ob["course_type"] = $('#course_type').val();
                                    ob["instructor_code"] = instructor_data_AA[i]['instructor_code'];
                                    //ob["description"] = $(this).children().eq(1).html();
                                    ob["description"] = "";
                                    ob["comments"] = $("#table_taught-" + instructor_data_AA[i]['instructor_code'] + "instruction").val();
                                    ob["strongly_agree"] = "N";
                                    ob["agree"] = "N";
                                    ob["neither_agree"] = "N";
                                    ob["disagree"] = "N";
                                    ob["strongly_disagree"] = "N";
                                    ob["not_applicable"] = "N";
                                    ob["rating"] = "";

                                    ob["taught_supported_selection_AA"] = taught_supporte_AA_value;
                                    ob["taught_supported_selection_if_yes"] = $("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();

                                    if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                                        ob["sr_no"] = j + 1;
                                        ob["comments"] = $("#table_taught-" + instructor_data_AA[i]['instructor_code'] + "instruction").val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor";
                                        }
                                        else {
                                            ob["releted_feedback"] = "AA";
                                        }

                                        if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                                        if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                                        if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                                        if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                                        if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                                        if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                                        if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                                        if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                                        if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                                        if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
                                    }
                                    else if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                                        ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                                        ob["comments"] = $(this).find('.cls_txt_course_comment').val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor_comments";
                                        }
                                        else {
                                            ob["releted_feedback"] = "AA_comments";
                                        }
                                    }

                                    datalist.push(ob);
                                }
                            });
                        }
                    }
                }
            }

            // TA Save
            if (instructor_data_TA != "") {
                for (var i = 0; i < instructor_data_TA.length; i++) {
                    var taught_supporte_TA_value = $("input[type='radio'][name='taught_supporte_TA~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val();

                    if (flag == 'N') {
                        if (taught_supporte_TA_value == "Y") {
                            $("#table_taught-" + instructor_data_TA[i]["instructor_code"] + " tbody tr").each(function (j) {
                                if ($(this).find('.1').is(':disabled') == false) {
                                    var ob = {};

                                    ob["course_code"] = $('#course_code').val();
                                    ob["course_type"] = $('#course_type').val();
                                    ob["instructor_code"] = instructor_data_TA[i]['instructor_code'];
                                    //ob["description"] = $(this).children().eq(1).html();
                                    ob["description"] = "";
                                    ob["strongly_agree"] = "N";
                                    ob["agree"] = "N";
                                    ob["neither_agree"] = "N";
                                    ob["disagree"] = "N";
                                    ob["strongly_disagree"] = "N";
                                    ob["not_applicable"] = "N";
                                    ob["rating"] = "";

                                    ob["taught_supported_selection_AA"] = taught_supporte_TA_value;
                                    ob["taught_supported_selection_if_yes"] = $("input[type='radio'][name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val();

                                    if ($(this).find('.cls_hdn_que_type').val() == undefined) {
                                        ob["sr_no"] = j + 1;
                                        ob["comments"] = $("#table_taught-" + instructor_data_TA[i]['instructor_code'] + "instruction").val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor";
                                        }
                                        else {
                                            ob["releted_feedback"] = "TA";
                                        }

                                        if ($(this).find('.1:checked').val()) { ob["rating"] = "1"; }
                                        if ($(this).find('.2:checked').val()) { ob["rating"] = "2"; }
                                        if ($(this).find('.3:checked').val()) { ob["rating"] = "3"; }
                                        if ($(this).find('.4:checked').val()) { ob["rating"] = "4"; }
                                        if ($(this).find('.5:checked').val()) { ob["rating"] = "5"; }
                                        if ($(this).find('.6:checked').val()) { ob["rating"] = "6"; }
                                        if ($(this).find('.7:checked').val()) { ob["rating"] = "7"; }
                                        if ($(this).find('.8:checked').val()) { ob["rating"] = "8"; }
                                        if ($(this).find('.9:checked').val()) { ob["rating"] = "9"; }
                                        if ($(this).find('.10:checked').val()) { ob["rating"] = "10"; }
                                    }
                                    else if ($(this).find('.cls_hdn_que_type').val() == 'comment') {
                                        ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
                                        ob["comments"] = $(this).find('.cls_txt_course_comment').val();

                                        if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "']:checked").val() == "T") {
                                            ob["releted_feedback"] = "instructor_comments";
                                        }
                                        else {
                                            ob["releted_feedback"] = "TA_comments";
                                        }
                                    }

                                    datalist.push(ob);
                                }
                            });
                        }
                    }
                }
            }
        }

        $("#tbl_student_engagement tr").each(function (i) {
            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            ob["instructor_code"] = "";
            ob["sr_no"] = $(this).find('.cls_hdn_sr_no').val();
            ob["description"] = "";
            ob["comments"] = "";
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["rating"] = "";
            ob["releted_feedback"] = "student";
            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            for (var j = 0; j < $(this).find('.cls_stud_engage_option input').length; j++) {
                if ($(this).find('.cls_stud_engage_option input')[j].checked) { ob["rating"] = $(this).find('.cls_stud_engage_option input')[j].value; }
            }

            //datalist.push(ob);
        });

        var course_aspect = '';
        var course_suggestion = '';

        if (flag == 'N') {
            var data = JSON.stringify({ table_data: JSON.stringify(datalist), course_aspect: course_aspect, course_suggestion: course_suggestion, submit_status: 'N', taught_supported_selection_AA: "", taught_supported_selection_if_yes: "" });

            //bootbox.confirm({
            //    // title: "danger - danger - danger",
            //    message: "You cannot edit or resubmit your feedback so please recheck before submitting.",

            //    buttons: {
            //        cancel: {
            //            label: "Recheck"
            //            //   className: "btn-default pull-left"
            //        },
            //        confirm: {
            //            label: "Submit"
            //            // className: "btn-danger pull-right"
            //        }
            //    },
            //    callback: function (result) {
            //        if (result == true) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/save_feedback_data_new",
                data: data,
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        bootbox.alert(data.d);
                        display_form();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            //        }
            //    }
            //});
        }

        return false;
    });
});

function check_saved_feedback() {
    var course = getParameterByName('course_code');
    var course_name = getParameterByName('course_name');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_student_saved_feedback_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data1) {
            if (data1.d != '') {
                var feedback_saved_data = JSON.parse(data1.d);

                for (var j = 0; j < feedback_saved_data.length; j++) {
                    if (feedback_saved_data[j]["course"] == course) {
                        //bootbox.alert("The Feedback of this course is already submitted by you.");

                        bootbox.confirm({
                            //title: "danger - danger - danger",
                            message: "The Feedback of this course is already submitted by you.",
                            closeButton: true,
                            buttons: {
                                cancel: {
                                    label: "Cancel"
                                    //className: "btn-default pull-left",
                                },
                                confirm: {
                                    label: "OK"
                                    //className: "btn-danger pull-right"
                                }
                            },
                            callback: function (result) {
                                window.location.href = "Feedback_dashboard.aspx";
                            }
                        });

                        return false;
                        //break;
                    }
                }
            }
        }
    });
}

function hide_show_learning_outcome()
{
    var course = getParameterByName('course_code');
    var coucourse_split = course.split('~');
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_course_data_for_mode",
        async: false,
        data: "{course_code:'" + coucourse_split[0] + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "")
            {
                
                console.log('First Check On campus ' + learning_outcome_hide_show);
                learning_outcome_hide_show = true;
                $('#online_learning_section_e_d').css('display', 'none');
                //var res = JSON.parse(data.d);

                //if (res['typology_detail'] != null)
                //{
                // //   obj_typology_data = res['typology_detail'];
                //}
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function get_all_typology_group() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_typology_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var res = JSON.parse(data.d);

                if (res['typology_detail'] != null) {
                    obj_typology_data = res['typology_detail'];
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function display_form() {
    //var row = $(this).closest("tr").get(0);
    //var aData = oTable.fnGetData(row);

    var course = getParameterByName('course_code');
    var course_name = getParameterByName('course_name');

    $('.lblclass').text(course_name);
    $('.lblclass').css('display', 'block');

    $('#tbl_student_engagement').html('');

    if (course != "") {
        if (saved_data != '') {
            for (var j = 0; j < saved_data.length; j++) {
                if (saved_data[j]["course"] == course) {
                    bootbox.alert("You already saved selected Course's Feedback");

                    $('#divlecture').css('display', 'none');
                    $('#divseminar').css('display', 'none');
                    $('#divworkshop').css('display', 'none');
                    $('#divstudio').css('display', 'none');

                    $('.lblclass').css('display', 'none');
                    return false;
                }
            }
        }

        var coucourse_split = course.split('~');

        $('#course_code').val(coucourse_split[0]);
        $('#course_type').val(coucourse_split[1]);
        $('#course_type_name').text('');

        var course_typology = '';

        var typology_dtl = $.grep(obj_typology_data, function (data) { return data.type_code == coucourse_split[1] });

        if (typology_dtl.length > 0) {
            //if (coucourse_split[1] == "3" || coucourse_split[1] == "4" || coucourse_split[1] == "12")
            //if (coucourse_split[1] == "3" || coucourse_split[1] == "4" || coucourse_split[1] == "12" || coucourse_split[1] == "18") { // for Lecture
            if (typology_dtl[0]['sub_group'] == 'SG001') {
                course_typology = '3';
                $('#course_type_name').text('Lecture Course');
            }
            //else if (coucourse_split[1] == "5" || coucourse_split[1] == "6" || coucourse_split[1] == "13") 
            //else if (coucourse_split[1] == "5" || coucourse_split[1] == "6" || coucourse_split[1] == "13" || coucourse_split[1] == "19") { // for Seminar
            else if (typology_dtl[0]['sub_group'] == 'SG002') {
                course_typology = '5';
                $('#course_type_name').text('Seminar Course');
            }
            //else if (coucourse_split[1] == "9" || coucourse_split[1] == "1" || coucourse_split[1] == "8") 
            //else if (coucourse_split[1] == "9" || coucourse_split[1] == "1" || coucourse_split[1] == "8" || coucourse_split[1] == "22") { // for Workshop
            else if (typology_dtl[0]['sub_group'] == 'SG004') {
                course_typology = '1';
                $('#course_type_name').text('Workshop Course');
            }
            //else if (coucourse_split[1] == "7" || coucourse_split[1] == "14" || coucourse_split[1] == "20") { // for Studio
            else if (typology_dtl[0]['sub_group'] == 'SG003') {
                // course_typology = coucourse_split[1];
                course_typology = "7";
                $('#course_type_name').text('Studio Course');
            }
            else {
                bootbox.alert("This course is not eligible for feedback.");
                return false;
            }
        }
        else {
            bootbox.alert("This course is not eligible for feedback.");
            return false;
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/Get_instructor_code_for_course_code_for_feedback",
            async: false,
            data: "{course_code:'" + coucourse_split[0] + "',course_typology:'" + course_typology + "'}",
            dataType: "json",
            success: function (data) {
                setInstructions(data, course, course_name, coucourse_split, course_typology);
            },
            error: function (result) {
                alert(result);
            }
        });
    }
    else {
        $('#divlecture').css('display', 'none');
        $('#divseminar').css('display', 'none');
        $('#divworkshop').css('display', 'none');
        $('#divstudio').css('display', 'none');
        $('.lblclass').css('display', 'none');
    }
}

function setInstructions(data, course, course_name, coucourse_split, course_typology) {
    //var str_instructor = '';

    var ta_que_avail = false;
    var aa_que_avail = false;

    if (data.d != null) {
        var feedback_saved_data = '';
        var taught_saved_data = '';
        var taught_supported_selection = '';
        var taught_supported_selection_if_yes = '';

        instructor_data = JSON.parse(data.d[0]);

        if (data.d[2] != null) { feedback_saved_data = JSON.parse(data.d[2]); }

        // For Lecture

        if (data.d[3] != null) { taught_saved_data = JSON.parse(data.d[3]); }

        if (data.d[4] != null) { instructor_data_AA = JSON.parse(data.d[4]); }

        if (data.d[5] != null) { instructor_data_TA = JSON.parse(data.d[5]); }

        if (data.d[1] != null) {
            $('#divseminar').css('display', 'none');
            $('#divworkshop').css('display', 'none');
            $('#divstudio').css('display', 'none');
            $('.instructor_feedback_lable').css('display', 'none');

            $('#div_lecture').html('');
            $('#div_seminar').html('');
            $('#div_workshop').html('');
            $('#div_studio').html('');
            $('#course_lecture tbody').html('');
            $('#online_learning tbody').html('');
            $('#course_workshop tbody').html();
            $('#course_studio tbody').html('');
            $('#course_seminar tbody').html('');

            feedbcak_instructions_data = JSON.parse(data.d[1]);

            // Course Feedback

            for (var i = 0; i < feedbcak_instructions_data.length; i++) {
                if (feedbcak_instructions_data[i]["feedback_type"] == "course") {
                    if (feedback_saved_data != '') {
                        for (var k = 0; k < feedback_saved_data.length; k++) {
                            if (feedback_saved_data[k]["releted_feedback"] == 'course' && feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[i]["sr_no"]) {
                                $('#txt_course_instruction').val(feedback_saved_data[k]["comments"]);

                                var str = "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";

                                if (feedback_saved_data[k]["rating"] == '1') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='1' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='1' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '2') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='2' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='2' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '3') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='3' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='3' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '4') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='4' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='4' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '5') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='5' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='5' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '6') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='6' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='6' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '7') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='7' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='7' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '8') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='8' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='8' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '9') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='9' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='9' /> </center></td> ";
                                }

                                if (feedback_saved_data[k]["rating"] == '10') {
                                    str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='10' /> </center></td> ";
                                }
                                else {
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='10' /> </center></td> ";
                                }

                                str += "</tr>";

                                $('#course_lecture tbody').append(str);
                            }
                        }
                    }
                    else {
                        var str = "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";

                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='1' /> </center></td> ";
                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='2' /> </center></td> ";
                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='3' /> </center></td> ";
                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='4' /> </center></td> ";
                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='5' /> </center></td> ";
                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='6' /> </center></td> ";
                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='7' /> </center></td> ";
                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='8' /> </center></td> ";
                        str += "<td style='width:57px'><center> <input type='radio' name='1." + (i + 1) + "' class='9' /> </center></td> ";
                        str += "<td style='width:57px'><center> <input type='radio' name='1." + (i + 1) + "' class='10' /> </center></td> ";
                        str += "</tr>";

                        $('#course_lecture tbody').append(str);
                    }
                }
                else {
                }

                if (feedbcak_instructions_data[i]["feedback_type"] == "online_learning") {
                    debugger;
                    console.log('feedback_saved_data ' + feedback_saved_data);
                    if (feedback_saved_data != '') {
                        for (var k = 0; k < feedback_saved_data.length; k++) {
                            if (feedback_saved_data[k]["releted_feedback"] == 'online_learning' && feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[i]["sr_no"])
                            {
                                $('#online_learning_section_e_d').css('display', 'block'); // Changes 07112022 by nitinbhai 
                                console.log('Second Check On campus' + learning_outcome_hide_show);
                                learning_outcome_hide_show = false;
                                $('#txt_course_instruction_online_learning').val(feedback_saved_data[k]["comments"]);

                                var str = "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";

                                var str = "";
                                 
                                if (feedbcak_instructions_data[i]["sr_no"] == 5) {
                                    //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " a.</td>";
                                    str += "<tr><td>a.</td>";
                                } else if (feedbcak_instructions_data[i]["sr_no"] == 6) {
                                    //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " b.</td>";
                                    str += "<tr><td>b.</td>";
                                } else if (feedbcak_instructions_data[i]["sr_no"] == 7) {
                                    //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " 5</td>";
                                    str += "<tr><td>5</td>";
                                } else if (feedbcak_instructions_data[i]["sr_no"] == 8) {
                                    //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " 6</td>";
                                    str += "<tr><td>7</td>";
                                }
                                else if (feedbcak_instructions_data[i]["sr_no"] == 9) {
                                    //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " 6</td>";
                                    str += "<tr><td>8</td>";
                                } else {
                                    str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td>";
                                }

                                str += "<td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td>";

                                //var str = "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";
                                if (feedbcak_instructions_data[i]["sr_no"] != 4) {
                                    if (feedback_saved_data[k]["rating"] == '1') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='1' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='1' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '2') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='2' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='2' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '3') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='3' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='3' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '4') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='4' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='4' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '5') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='5' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='5' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '6') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='6' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='6' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '7') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='7' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='7' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '8') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='8' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='8' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '9') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='9' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='9' /> </center></td> ";
                                    }

                                    if (feedback_saved_data[k]["rating"] == '10') {
                                        str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='10' /> </center></td> ";
                                    }
                                    else {
                                        str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='10' /> </center></td> ";
                                    }
                                } else {
                                    str += "<td colspan='10'></td>";
                                }
                                str += "</tr>";

                                //if (feedbcak_instructions_data[i]["sr_no"] == 8) {
                                //    que_at_last = str;
                                //} else {
                                //    $('#online_learning tbody').append(str);
                                //}

                                if (feedbcak_instructions_data[i]["sr_no"] == 8) {
                                    que_at_last = str;
                                } else {
                                    if (feedbcak_instructions_data[i]["sr_no"] == 9) {
                                        que_at_last_to_last = str;
                                    } else {
                                        $('#online_learning tbody').append(str);
                                    }
                                }
                            }
                        }
                    }
                    else {
                        var str = "";
                         
                        if (feedbcak_instructions_data[i]["sr_no"] == 5) {
                            //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " a.</td>";
                            str += "<tr><td>a.</td>";
                        } else if (feedbcak_instructions_data[i]["sr_no"] == 6) {
                            //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " b.</td>";
                            str += "<tr><td>b.</td>";
                        } else if (feedbcak_instructions_data[i]["sr_no"] == 7) {
                            //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " 5</td>";
                            str += "<tr><td>5</td>";
                        } else if (feedbcak_instructions_data[i]["sr_no"] == 8) {
                            //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " 6</td>";
                            str += "<tr><td>7</td>";
                        }
                        else if (feedbcak_instructions_data[i]["sr_no"] == 9) {
                            //str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + " 6</td>";
                            str += "<tr><td>8</td>";
                        } else {
                            str += "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td>";
                        }

                        str += "<td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td>";

                        //var str = "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";
                        if (feedbcak_instructions_data[i]["sr_no"] != 4) {
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='1' /> </center></td> ";
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='2' /> </center></td> ";
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='3' /> </center></td> ";
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='4' /> </center></td> ";
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='5' /> </center></td> ";
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='6' /> </center></td> ";
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='7' /> </center></td> ";
                            str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='8' /> </center></td> ";
                            str += "<td style='width:57px'><center> <input type='radio' name='1." + (i + 1) + "' class='9' /> </center></td> ";
                            str += "<td style='width:57px'><center> <input type='radio' name='1." + (i + 1) + "' class='10' /> </center></td> ";
                        } else {
                            str += "<td colspan='10'></td>";
                        }
                        str += "</tr>";

                        //if (feedbcak_instructions_data[i]["sr_no"] == 8) {
                        //    que_at_last = str;
                        //} else {
                        //    $('#online_learning tbody').append(str);
                        //}

                        if (feedbcak_instructions_data[i]["sr_no"] == 8) {
                            que_at_last = str;
                        } else {
                            if (feedbcak_instructions_data[i]["sr_no"] == 9) {
                                que_at_last_to_last = str;
                            } else {
                                $('#online_learning tbody').append(str);
                            }
                        }
                    }
                }
                else {
                }
            }

            if (coucourse_split[0] != '3022') {

                // Instructor Feedback

                if (instructor_data != null) {
                    $('.instructor_feedback_lable').css('display', 'block');

                    for (var i = 0; i < instructor_data.length; i++) {
                        var str_instructor = '';

                        if (instructor_data[i]["designation"] != 'AA' && instructor_data[i]["designation"] != 'TA') {
                            if (course_typology == '7') {
                                //str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                                str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><div style='display:none'> I have interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was assigned to us for studio ";
                                str_instructor += "  ( Yes  <input checked='checked' type='radio' value='Y' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='check " + ('table' + parseInt(i + 1)) + "' /> No  <input  type='radio' value='N' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='check " + ('table' + parseInt(i + 1)) + "'/> )</div><br /> ";
                            }
                            else {
                                str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";
                            }

                            str_instructor = str_instructor + "<table id=" + ('table' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                            str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px; width: 650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td> ";
                            str_instructor = str_instructor + "<td colspan='3' style='text-align: center;'><p><b>Unsatisfactory</b></p></td><td colspan='3' style='text-align: center;'><p><b>Average</b></p></td><td colspan='2' style='text-align: center;'><p><b>Good</b></p></td><td style='text-align: center;'><p><b>Very Good</b></p></td><td style='text-align: center;'><p><b>Excellent</b></p></td></tr> ";
                            str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
                            str_instructor = str_instructor + "</thead> <tbody>";

                            var comments = '';

                            for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                                if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
                                    var temp_instructor_dtl = $.grep(feedback_saved_data, function (data) { return data.instructor_code == instructor_data[i]["instructor_code"] });

                                    //if (feedback_saved_data != '') {
                                    if (feedback_saved_data != '' && temp_instructor_dtl.length > 0) {
                                        for (var k = 0; k < feedback_saved_data.length; k++) {
                                            if (feedback_saved_data[k]["releted_feedback"] == 'instructor') {
                                                if (feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[j]["sr_no"] && feedback_saved_data[k]["instructor_code"] == instructor_data[i]["instructor_code"]) {

                                                    str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";

                                                    comments = feedback_saved_data[k]["comments"];

                                                    if (feedback_saved_data[k]["rating"] == '1') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '2') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '3') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '4') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '5') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '6') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '7') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '8') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '9') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                                                    }

                                                    if (feedback_saved_data[k]["rating"] == '10') {
                                                        str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                                                    }
                                                    else {
                                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                                                    }

                                                    str_instructor += "</tr>";
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='10' /> </center></td> ";

                                        str_instructor += "</tr>";
                                    }
                                }
                            }

                            str_instructor = str_instructor + "</tbody></table>";
                            str_instructor = str_instructor + " <p id='" + ('table' + parseInt(i + 1) + 'commenttitle') + "'><br /><b>Please write your comments about " + instructor_data[i]["instructor_name"] + " :</b></p>";
                            str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + ('table' + parseInt(i + 1) + 'instruction') + "' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                            $('#div_lecture').append(str_instructor);
                        }
                    }
                }

                // Academic Associate Feedback

                $('#div_AA_instructor_selection').html('<p class="instructor_feedback_lable">  <br /><b>3. Feedback : Academic Associate </b> </p>');

                for (var i = 0; i < instructor_data_AA.length; i++) {
                    var str_instructor = '';
                    var str_instructor_selection = '';
                    var instructor_code = instructor_data_AA[i]["instructor_code"];

                    var str_instructor_temp = '';

                    //if ($('#course_type').val() == '7') {
                    //    str_instructor_temp = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //}
                    //else {

                    str_instructor_temp = " <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span>";

                    //}

                    str_instructor_temp = str_instructor_temp + "<table id='table_taught-" + instructor_data_AA[i]["instructor_code"] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                    str_instructor_temp = str_instructor_temp + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px; align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;  width:650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the academic associate.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_AA[i]["instructor_code"] + " /></td> ";
                    str_instructor_temp = str_instructor_temp + "<td colspan='3'><p><b>Unsatisfactory</b></p></td><td colspan='3'><p><b>Average</b></p></td><td colspan='2'><p><b>Good</b></p></td><td ><p><b>Very Good</b></p></td><td><p><b>Excellent</b></p></td></tr> ";
                    str_instructor_temp = str_instructor_temp + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
                    str_instructor_temp = str_instructor_temp + "</thead> <tbody>";

                    var comments = '';

                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                        if (feedbcak_instructions_data[j]["feedback_type"] == "AA") {
                            aa_que_avail = true;
                            str_instructor_temp += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_AA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                            str_instructor_temp += "</tr>";
                        }
                    }

                    str_instructor_temp = str_instructor_temp + "</tbody></table>";
                    str_instructor_temp = str_instructor_temp + " <p><br /><b>Please write your comments about " + instructor_data_AA[i]["instructor_name"] + " :</b></p>";
                    str_instructor_temp = str_instructor_temp + " <div class='control-group'>  <textarea id='table_taught-" + instructor_data_AA[i]["instructor_code"] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                    //"3.<span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span> : &nbsp; " +
                    str_instructor_selection = "<div style='display:none;'><input type='radio' name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "' value='Y' checked>Yes " +
                        "<input type='radio' name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "' value='N'>No</div>" +
                        "<br /> <br /> <div id='div_taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "' style='display:block;'>" +
                        "<div style='display:block;opacity: 0;'>&nbsp; &nbsp; &nbsp; Please Tick the relevant : <input type='radio' name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "'  value='T'>Taught " +
                        "<input type='radio' name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "' value='S' checked>Supported </div>" +
                        "<div id='div_taught_supporte_AA_relevent~" + instructor_data_AA[i]["instructor_code"] + "'>" + str_instructor_temp + "</div></div> <br /> ";

                    $('#div_AA_instructor_selection').css('display', 'block');

                    $('#div_AA_instructor').css('display', 'block');

                    $('#div_AA_instructor_selection').append(str_instructor_selection);

                    var table_name = "table_taught-" + instructor_data_AA[i]["instructor_code"];

                    var feedbackType = "";
                    //if (course_typology == '7') {

                    if (taught_saved_data != "") {
                        for (var m = 0; m < taught_saved_data.length; m++) {
                            var feedbackType = "";

                            if (instructor_data_AA[i]["instructor_code"] == taught_saved_data[m]["instructor_code"]) {
                                if (taught_saved_data[m]["taught_supported_selection_AA"] == "Y") {
                                    if (taught_saved_data[m]["taught_supported_selection_if_yes"] == "T") {
                                        feedbackType = "instructor";
                                    }
                                    else {
                                        feedbackType = "AA";
                                    }

                                    str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span>";
                                    //}
                                    //else {
                                    //   str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";
                                    //}

                                    str_instructor = str_instructor + "<table id=" + table_name + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px; width:650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the academic associate.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_AA[i]["instructor_code"] + " /></td> ";
                                    str_instructor = str_instructor + "<td colspan='3' style='text-align: center;'><p><b>Unsatisfactory</b></p></td><td colspan='3' style='text-align: center;'><p><b>Average</b></p></td><td colspan='2' style='text-align: center;'><p><b>Good</b></p></td><td style='text-align: center; '><p><b>Very Good</b></p></td><td style='text-align: center;'><p><b>Excellent</b></p></td></tr> ";
                                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
                                    str_instructor = str_instructor + "</thead> <tbody>";

                                    var comments = '';

                                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                                        if (feedbcak_instructions_data[j]["feedback_type"] == feedbackType) {
                                            if (feedback_saved_data != '') {
                                                for (var k = 0; k < feedback_saved_data.length; k++) {
                                                    if (feedback_saved_data[k]["releted_feedback"] == feedbackType) {
                                                        if (feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[j]["sr_no"] && feedback_saved_data[k]["instructor_code"] == instructor_data_AA[i]["instructor_code"]) {

                                                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";

                                                            comments = feedback_saved_data[k]["comments"];

                                                            if (feedback_saved_data[k]["rating"] == '1') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '2') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '3') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '4') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '5') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '6') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '7') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '8') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '9') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '10') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                                                            }

                                                            str_instructor += "</tr>";
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    str_instructor = str_instructor + "</tbody></table>";
                                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_AA[i]["instructor_name"] + " :</b></p>";
                                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + table_name + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                                    document.getElementById('div_taught_supporte_AA_relevent~' + instructor_code).innerHTML = str_instructor;
                                    document.getElementById('div_taught_supporte_AA~' + instructor_code).style.display = 'block';
                                    document.getElementsByName('taught_supporte_AA~' + instructor_code)[0].checked = true;

                                    if (taught_saved_data[m]["taught_supported_selection_if_yes"] == "T") {
                                        document.getElementsByName('taught_supporte_yes~' + instructor_code)[0].checked = true;
                                    }
                                    else {
                                        document.getElementsByName('taught_supporte_yes~' + instructor_code)[1].checked = true;
                                    }
                                }
                            }
                        }
                    }

                    //$('#div_AA_instructor').append(str_instructor);// add today
                    //$("input[name=taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "][value=Y]")[0].checked = true;
                    //$("input[name=taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "][value=Y]").focus();
                    //$("input[name=taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "][value=Y]").click();
                }

                // Teaching Associate Feedback
                // New TT Instructor

                $('#div_TA_instructor_selection').html('<p class="instructor_feedback_lable">  <br /><b>4. Feedback : Teaching Associate</b> </p>');

                for (var i = 0; i < instructor_data_TA.length; i++) {
                    var str_instructor = '';
                    var str_instructor_selection = '';
                    var instructor_code = instructor_data_TA[i]["instructor_code"];
                    var str_instructor_temp = '';

                    //if ($('#course_type').val() == '7') {
                    //    str_instructor_temp = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //}
                    //else {

                    str_instructor_temp = " <span style='color:#2283c5 !important'><b> " + instructor_data_TA[i]["instructor_name"] + "</b></span>";

                    //}

                    str_instructor_temp = str_instructor_temp + "<table id='table_taught-" + instructor_data_TA[i]["instructor_code"] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                    str_instructor_temp = str_instructor_temp + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px; align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;  width:650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the teaching associate.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_TA[i]["instructor_code"] + " /></td> ";
                    str_instructor_temp = str_instructor_temp + "<td colspan='3'><p><b>Unsatisfactory</b></p></td><td colspan='3'><p><b>Average</b></p></td><td colspan='2'><p><b>Good</b></p></td><td ><p><b>Very Good</b></p></td><td><p><b>Excellent</b></p></td></tr> ";
                    str_instructor_temp = str_instructor_temp + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";

                    str_instructor_temp = str_instructor_temp + "</thead> <tbody>";

                    var comments = '';

                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                        if (feedbcak_instructions_data[j]["feedback_type"] == "TA") {
                            ta_que_avail = true;
                            str_instructor_temp += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                            str_instructor_temp += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_data_TA[i]["instructor_code"] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                            str_instructor_temp += "</tr>";
                        }
                    }

                    str_instructor_temp = str_instructor_temp + "</tbody></table>";
                    str_instructor_temp = str_instructor_temp + " <p><br /><b>Please write your comments about " + instructor_data_TA[i]["instructor_name"] + " :</b></p>";
                    str_instructor_temp = str_instructor_temp + " <div class='control-group'>  <textarea id='table_taught-" + instructor_data_TA[i]["instructor_code"] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                    //"<span style='color:#2283c5 !important'><b> " + instructor_data_TA[i]["instructor_name"] + "</b></span> : &nbsp; " +

                    str_instructor_selection = "<div style='display:none;'><input type='radio' name='taught_supporte_TA~" + instructor_data_TA[i]["instructor_code"] + "' value='Y' checked>Yes " +
                        "<input type='radio' name='taught_supporte_TA~" + instructor_data_TA[i]["instructor_code"] + "'  value='N'>No </div>" +
                        "<br /> <br /> <div id='div_taught_supporte_TA~" + instructor_data_TA[i]["instructor_code"] + "' style='display:block;'>" +
                        "<div style='display:block;opacity: 0;'>&nbsp; &nbsp; &nbsp; Please Tick the relevant : <input type='radio' name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "'  value='T'>Taught " +
                        "<input type='radio' name='taught_supporte_yes~" + instructor_data_TA[i]["instructor_code"] + "'  value='S' checked>Supported </div>" +
                        "<div id='div_taught_supporte_TA_relevent~" + instructor_data_TA[i]["instructor_code"] + "'>" + str_instructor_temp + "</div></div> <br /> ";

                    $('#div_TA_instructor_selection').css('display', 'block');
                    $('#div_TA_instructor').css('display', 'block');
                    $('#div_TA_instructor_selection').append(str_instructor_selection);

                    var table_name = "table_taught-" + instructor_data_TA[i]["instructor_code"];
                    var feedbackType = "";

                    //if (course_typology == '7') {

                    if (taught_saved_data != "") {
                        for (var m = 0; m < taught_saved_data.length; m++) {
                            var feedbackType = "";

                            if (instructor_data_TA[i]["instructor_code"] == taught_saved_data[m]["instructor_code"]) {
                                if (taught_saved_data[m]["taught_supported_selection_AA"] == "Y") {
                                    if (taught_saved_data[m]["taught_supported_selection_if_yes"] == "T") {
                                        feedbackType = "instructor";
                                    }
                                    else {
                                        feedbackType = "TA";
                                    }

                                    str_instructor = str_instructor + " <span style='color:#2283c5 !important'><b> " + instructor_data_TA[i]["instructor_name"] + "</b></span>";

                                    //}
                                    //else {
                                    //   str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";
                                    //}

                                    str_instructor = str_instructor + "<table id=" + table_name + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px; width:650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the teaching associate.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_TA[i]["instructor_code"] + " /></td> ";
                                    str_instructor = str_instructor + "<td colspan='3' style='text-align: center;'><p><b>Unsatisfactory</b></p></td><td colspan='3' style='text-align: center;'><p><b>Average</b></p></td><td colspan='2' style='text-align: center;'><p><b>Good</b></p></td><td style='text-align: center; '><p><b>Very Good</b></p></td><td style='text-align: center;'><p><b>Excellent</b></p></td></tr> ";
                                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
                                    str_instructor = str_instructor + "</thead> <tbody>";

                                    var comments = '';

                                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                                        if (feedbcak_instructions_data[j]["feedback_type"] == feedbackType) {
                                            if (feedback_saved_data != '') {
                                                for (var k = 0; k < feedback_saved_data.length; k++) {
                                                    if (feedback_saved_data[k]["releted_feedback"] == feedbackType) {
                                                        if (feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[j]["sr_no"] && feedback_saved_data[k]["instructor_code"] == instructor_data_TA[i]["instructor_code"]) {
                                                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";

                                                            comments = feedback_saved_data[k]["comments"];

                                                            if (feedback_saved_data[k]["rating"] == '1') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '2') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '3') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '4') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '5') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '6') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '7') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '8') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '9') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
                                                            }

                                                            if (feedback_saved_data[k]["rating"] == '10') {
                                                                str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                                                            }
                                                            else {
                                                                str_instructor += "<td style='width:57px'> <center> <input  type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
                                                            }

                                                            str_instructor += "</tr>";
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    str_instructor = str_instructor + "</tbody></table>";
                                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_TA[i]["instructor_name"] + " :</b></p>";
                                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='" + table_name + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                                    document.getElementById('div_taught_supporte_TA_relevent~' + instructor_code).innerHTML = str_instructor;
                                    document.getElementById('div_taught_supporte_TA~' + instructor_code).style.display = 'block';
                                    document.getElementsByName('taught_supporte_TA~' + instructor_code)[0].checked = true;

                                    if (taught_saved_data[m]["taught_supported_selection_if_yes"] == "T") {
                                        document.getElementsByName('taught_supporte_yes~' + instructor_code)[0].checked = true;
                                    }
                                    else {
                                        document.getElementsByName('taught_supporte_yes~' + instructor_code)[1].checked = true;
                                    }
                                }
                            }
                        }
                    }

                    //$('#div_AA_instructor').append(str_instructor);
                }
            }
            //}

            // Student Engagement Form

            var student_engagement_instructions = $.grep(feedbcak_instructions_data, function (data) { return data.feedback_type == 'student' });

            if (student_engagement_instructions.length > 0) {
                for (var i = 1; i <= student_engagement_instructions.length; i++) {
                    var obj_instruction = JSON.parse(student_engagement_instructions[i - 1]['feedback_instruction']);

                    if (obj_instruction['question'] != undefined && obj_instruction['option'] != undefined) {
                        var stud_engage_saved_data = [];

                        if (feedback_saved_data != '') {
                            stud_engage_saved_data = $.grep(feedback_saved_data, function (data) {
                                return data.releted_feedback == 'student' && data.sr_no == student_engagement_instructions[i - 1]['sr_no']
                            });
                        }

                        var str_html = '';

                        str_html += '<tr><td>' + i + '<input type="hidden" class="cls_hdn_sr_no" value="' + student_engagement_instructions[i - 1]['sr_no'] + '" /></td>';
                        str_html += '<td><div style="margin-bottom: 15px;"><div><b>' + obj_instruction['question'] + '</b></div>';
                        str_html += '<div class="cls_stud_engage_option">';

                        for (var j = 1; j <= obj_instruction['option'].length; j++) {
                            if (j != 1) str_html += '<br />';

                            if (stud_engage_saved_data.length > 0 && stud_engage_saved_data[0]['rating'].toString() == j.toString()) {
                                str_html += '<input type="radio" name="rdo_stud_engage_que' + i + '" value="' + j + '" checked /> ' + obj_instruction['option'][j];
                            }
                            else {
                                str_html += '<input type="radio" name="rdo_stud_engage_que' + i + '" value="' + j + '" /> ' + obj_instruction['option'][j];
                            }
                        }

                        str_html += '</div></div></td></tr>';

                        $('#tbl_student_engagement').append(str_html);
                    }
                }
            }

            // Add Course Comments

            var obj_course_comments = $.grep(feedbcak_instructions_data, function (data) { return data.feedback_type == 'course_comments' });

            if (obj_course_comments.length > 0) {
                var course_tr_length = $('#course_lecture tbody tr').length;

                for (var i = 1; i <= obj_course_comments.length; i++) {
                    var course_comment_saved_data = [];

                    if (feedback_saved_data != '') {
                        course_comment_saved_data = $.grep(feedback_saved_data, function (data) {
                            return data.releted_feedback == 'course_comments' && data.sr_no == obj_course_comments[i - 1]['sr_no']
                        });
                    }

                    var str_html = '';

                    str_html += '<tr><td>' + (i + course_tr_length);
                    str_html += '<input type="hidden" class="cls_hdn_que_type" value="comment" />';
                    str_html += '<input type="hidden" class="cls_hdn_sr_no" value="' + obj_course_comments[i - 1]['sr_no'] + '" /></td>';
                    str_html += '<td>' + obj_course_comments[i - 1]['feedback_instruction'] + '</td>';

                    if (course_comment_saved_data.length > 0 && course_comment_saved_data[0]['comments'] != undefined) {
                        //str_html += '<td colspan=10><input type="text" class="cls_txt_course_comment" value="' + course_comment_saved_data[0]['comments'] + '" /></td>';
                        str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false">' + course_comment_saved_data[0]['comments'] + '</textarea></td>';
                    }
                    else {
                        //str_html += '<td colspan=10><input type="text" class="cls_txt_course_comment" /></td>';
                        str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false"></textarea></td>';
                    }

                    str_html += '</tr>';

                    $('#course_lecture tbody').append(str_html);
                }
            }

            // Add Online Course Comments

            var obj_course_comments_online_learning = $.grep(feedbcak_instructions_data, function (data) { return data.feedback_type == 'online_learning_comments' });

            if (obj_course_comments_online_learning.length > 0) {
                var course_tr_length = $('#online_learning tbody tr').length;

                for (var i = 1; i <= obj_course_comments_online_learning.length; i++) {
                    var course_comment_saved_data = [];

                    if (feedback_saved_data != '') {
                        course_comment_saved_data = $.grep(feedback_saved_data, function (data) {
                            return data.releted_feedback == 'online_learning_comments' && data.sr_no == obj_course_comments_online_learning[i - 1]['sr_no']
                        });
                    }

                    var str_html = '';

                    if ((i + course_tr_length) == 8) {
                        //str_html += '<tr><td>' + (i + course_tr_length) + '7';
                        str_html += '<tr><td>6';
                    }
                    if ((i + course_tr_length) == 9) {
                        //str_html += '<tr><td>' + (i + course_tr_length) + 'a.';
                        str_html += '<tr><td>a.';
                    }
                    if ((i + course_tr_length) == 10) {
                        //str_html += '<tr><td>' + (i + course_tr_length) + 'b.';
                        str_html += '<tr><td>b.';
                    }
                    str_html += '<input type="hidden" class="cls_hdn_que_type_online_learning" value="comment" />';
                    str_html += '<input type="hidden" class="cls_hdn_sr_no_online_learning" value="' + obj_course_comments_online_learning[i - 1]['sr_no'] + '" /></td>';
                    str_html += '<td>' + obj_course_comments_online_learning[i - 1]['feedback_instruction'] + '</td>';

                    if ((i + course_tr_length) != 8) {
                        if (course_comment_saved_data.length > 0 && course_comment_saved_data[0]['comments'] != undefined) {
                            str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment_online_learning">' + course_comment_saved_data[0]['comments'] + '</textarea></td>';
                        }
                        else {
                            str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment_online_learning" /></td>';
                        }
                    } else {
                        str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment_online_learning" style="display:none;"/></td>';
                    }
                    str_html += '</tr>';

                    $('#online_learning tbody').append(str_html);
                }

                $('#online_learning tbody').append(que_at_last);
                $('#online_learning tbody').append(que_at_last_to_last);
                que_at_last = '';
                que_at_last_to_last = '';
            }

            // Add Instructor Comments

            if (instructor_data != null) {
                for (var k = 0; k < instructor_data.length; k++) {
                    if (instructor_data[k]["designation"] != 'AA' && instructor_data[k]["designation"] != 'TA') {
                        var obj_instructor_comments = $.grep(feedbcak_instructions_data, function (data) { return data.feedback_type == 'instructor_comments' });

                        if (obj_instructor_comments.length > 0 && $('#table' + (k + 1) + ' tbody tr').length > 0) {
                            var instructor_tr_length = $('#table' + (k + 1) + ' tbody tr').length;

                            for (var i = 1; i <= obj_instructor_comments.length; i++) {
                                var instructor_comment_saved_data = [];

                                if (feedback_saved_data != '') {
                                    instructor_comment_saved_data = $.grep(feedback_saved_data, function (data) {
                                        return data.releted_feedback == 'instructor_comments' && data.sr_no == obj_instructor_comments[i - 1]['sr_no'] && data.instructor_code == instructor_data[k]["instructor_code"]
                                    });
                                }

                                var str_html = '';

                                str_html += '<tr><td>' + (i + instructor_tr_length);
                                str_html += '<input type="hidden" class="cls_hdn_que_type" value="comment" />';
                                str_html += '<input type="hidden" class="cls_hdn_sr_no" value="' + obj_instructor_comments[i - 1]['sr_no'] + '" /></td>';
                                str_html += '<td>' + obj_instructor_comments[i - 1]['feedback_instruction'] + '</td>';
                                
                                if (instructor_comment_saved_data.length > 0 && instructor_comment_saved_data[0]['comments'] != undefined) {
                                    //str_html += '<td colspan=10><input type="text" class="cls_txt_course_comment" value="' + instructor_comment_saved_data[0]['comments'] + '" /></td>';
                                    str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false">' + instructor_comment_saved_data[0]['comments'] + '</textarea></td>';
                                }
                                else {
                                    str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false"></textarea></td>';
                                }

                                str_html += '</tr>';

                                $('#table' + (k + 1) + ' tbody').append(str_html);
                            }
                        }
                    }
                }
            }

            // Add AA Instructor Comments

            if (instructor_data_AA != null) {
                for (var k = 0; k < instructor_data_AA.length; k++) {
                    if (instructor_data_AA[k]["designation"] == "AA") {
                        var obj_instructor_comments = $.grep(feedbcak_instructions_data, function (data) { return data.feedback_type == 'AA_comments' });

                        if (obj_instructor_comments.length > 0 && $('#table_taught-' + instructor_data_AA[k]["instructor_code"] + ' tbody tr').length > 0) {
                            var instructor_tr_length = $('#table_taught-' + instructor_data_AA[k]["instructor_code"] + ' tbody tr').length;

                            for (var i = 1; i <= obj_instructor_comments.length; i++) {
                                var instructor_comment_saved_data = [];

                                if (feedback_saved_data != '') {
                                    instructor_comment_saved_data = $.grep(feedback_saved_data, function (data) {
                                        return data.releted_feedback == 'AA_comments' && data.sr_no == obj_instructor_comments[i - 1]['sr_no'] && data.instructor_code == instructor_data_AA[k]["instructor_code"]
                                    });
                                }

                                var str_html = '';

                                str_html += '<tr><td>' + (i + instructor_tr_length);
                                str_html += '<input type="hidden" class="cls_hdn_que_type" value="comment" />';
                                str_html += '<input type="hidden" class="cls_hdn_sr_no" value="' + obj_instructor_comments[i - 1]['sr_no'] + '" /></td>';
                                str_html += '<td>' + obj_instructor_comments[i - 1]['feedback_instruction'] + '</td>';

                                if (instructor_comment_saved_data.length > 0 && instructor_comment_saved_data[0]['comments'] != undefined) {
                                    //str_html += '<td colspan=10><input type="text" class="cls_txt_course_comment" value="' + instructor_comment_saved_data[0]['comments'] + '" /></td>';
                                    str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false">' + instructor_comment_saved_data[0]['comments'] + '</textarea></td>';
                                }
                                else {
                                    //str_html += '<td colspan=10><input type="text" class="cls_txt_course_comment" /></td>';
                                    str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false"></textarea></td>';
                                }

                                str_html += '</tr>';

                                $('#table_taught-' + instructor_data_AA[k]["instructor_code"] + ' tbody').append(str_html);
                            }
                        }
                    }
                }
            }

            // Add TA Instructor Comments

            if (instructor_data_TA != null) {
                for (var k = 0; k < instructor_data_TA.length; k++) {
                    if (instructor_data_TA[k]["designation"] == "TA") {
                        var obj_instructor_comments = $.grep(feedbcak_instructions_data, function (data) { return data.feedback_type == 'TA_comments' });

                        if (obj_instructor_comments.length > 0 && $('#table_taught-' + instructor_data_TA[k]["instructor_code"] + ' tbody tr').length > 0) {
                            var instructor_tr_length = $('#table_taught-' + instructor_data_TA[k]["instructor_code"] + ' tbody tr').length;

                            for (var i = 1; i <= obj_instructor_comments.length; i++) {
                                var instructor_comment_saved_data = [];

                                if (feedback_saved_data != '') {
                                    instructor_comment_saved_data = $.grep(feedback_saved_data, function (data) {
                                        return data.releted_feedback == 'TA_comments' && data.sr_no == obj_instructor_comments[i - 1]['sr_no'] && data.instructor_code == instructor_data_TA[k]["instructor_code"]
                                    });
                                }

                                var str_html = '';

                                str_html += '<tr><td>' + (i + instructor_tr_length);
                                str_html += '<input type="hidden" class="cls_hdn_que_type" value="comment" />';
                                str_html += '<input type="hidden" class="cls_hdn_sr_no" value="' + obj_instructor_comments[i - 1]['sr_no'] + '" /></td>';
                                str_html += '<td>' + obj_instructor_comments[i - 1]['feedback_instruction'] + '</td>';

                                if (instructor_comment_saved_data.length > 0 && instructor_comment_saved_data[0]['comments'] != undefined) {
                                    //str_html += '<td colspan=10><input type="text" class="cls_txt_course_comment" value="' + instructor_comment_saved_data[0]['comments'] + '" /></td>';
                                    str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false">' + instructor_comment_saved_data[0]['comments'] + '</textarea></td>';
                                }
                                else {
                                    //str_html += '<td colspan=10><input type="text" class="cls_txt_course_comment" /></td>';
                                    str_html += '<td colspan=10><textarea rows="3" class="cls_txt_course_comment" spellcheck="false"></textarea></td>';
                                }

                                str_html += '</tr>';

                                $('#table_taught-' + instructor_data_TA[k]["instructor_code"] + ' tbody').append(str_html);
                            }
                        }
                    }
                }
            }

            $('#divlecture').css('display', 'block');
        }
        else {
            bootbox.alert("Feedback instructions not found in master table for selected typology.");

            $('#divlecture').css('display', 'none');
            $('#divseminar').css('display', 'none');
            $('#divworkshop').css('display', 'none');
            $('#divstudio').css('display', 'none');

            $('#div_lecture').html('');
            $('#div_seminar').html('');
            $('#div_workshop').html('');
            $('#div_studio').html('');

            $('#course_lecture tbody').html('');
            $('#online_learning tbody').html('');
            $('#course_workshop tbody').html();
            $('#course_studio tbody').html('');
            $('#course_seminar tbody').html('');

            return false;
        }

        if (ta_que_avail) {
            $("#div_TA_instructor_selection").css("display", "");
            $("#div_TA_instructor").css("display", "");
        } else {
            $("#div_TA_instructor_selection").css("display", "none");
            $("#div_TA_instructor").css("display", "none");
        }

        if (aa_que_avail) {
            $("#div_AA_instructor_selection").css("display", "");
            $("#div_AA_instructor").css("display", "");
        } else {
            $("#div_AA_instructor_selection").css("display", "none");
            $("#div_AA_instructor").css("display", "none");
        }
    }
    else {
        $('#divlecture').css('display', 'none');
        $('#divseminar').css('display', 'none');
        $('#divworkshop').css('display', 'none');
        $('#divstudio').css('display', 'none');
        $('.lblclass').css('display', 'none');
    }

    //$("input:radio").on('click', function () {
    //    var str_instructor_selection = document.activeElement.name.split('~');
    //    var radio_value = document.activeElement.value;

    //    if (str_instructor_selection[0] == "taught_supporte_AA") {
    //        if (radio_value == "Y") {
    //            document.getElementById('div_taught_supporte_AA~' + str_instructor_selection[1]).style.display = 'block';

    //            if (!document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].checked) {
    //                document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].focus();
    //                document.activeElement.click();
    //            }
    //        }
    //        else {
    //            document.getElementById('div_taught_supporte_AA~' + str_instructor_selection[1]).style.display = 'none';
    //        }
    //    }
    //    else if (str_instructor_selection[0] == "taught_supporte_yes") {
    //        document.getElementById('div_taught_supporte_AA_relevent~' + str_instructor_selection[1]).innerHTML = '';
    //        if (radio_value == "T") {
    //            for (var i = 0; i < instructor_data_AA.length; i++) {
    //                var str_instructor = '';
    //                if (instructor_data_AA[i]["instructor_code"] == str_instructor_selection[1]) {
    //                    //                    if ($('#course_type').val() == '7') {
    //                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
    //                    //                    }
    //                    //                    else {
    //                    str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span>";
    //                    //                    }
    //                    str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
    //                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;width: 650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_AA[i]["instructor_code"] + " /></td>";
    //                    str_instructor = str_instructor + "<td colspan='3' style='text-align: center;'><p><b>Unsatisfactory</b></p></td><td colspan='3' style='text-align: center;'><p><b>Average</b></p></td><td colspan='2' style='text-align: center;'><p><b>Good</b></p></td><td style='text-align: center; '><p><b>Very Good</b></p></td><td style='text-align: center;'><p><b>Excellent</b></p></td></tr> ";
    //                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
    //                    str_instructor = str_instructor + "</thead> <tbody>";
    //                    var comments = '';
    //                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
    //                        if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
    //                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
    //                            str_instructor += "</tr>";
    //                        }
    //                    }
    //                    str_instructor = str_instructor + "</tbody></table>";
    //                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_AA[i]["instructor_name"] + " :</b></p>";
    //                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
    //                    document.getElementById('div_taught_supporte_AA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
    //                }
    //            }
    //        }
    //        else {
    //            for (var i = 0; i < instructor_data_AA.length; i++) {                
    //                var str_instructor = '';
    //                if (instructor_data_AA[i]["instructor_code"] == str_instructor_selection[1]) {
    //                    //                    if ($('#course_type').val() == '7') {
    //                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
    //                    //                    }
    //                    //                    else {
    //                    str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span>";
    //                    //                    }
    //                    str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
    //                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px; align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;  width:650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_AA[i]["instructor_code"] + " /></td> ";
    //                    str_instructor = str_instructor + "<td colspan='3'><p><b>Unsatisfactory</b></p></td><td colspan='3'><p><b>Average</b></p></td><td colspan='2'><p><b>Good</b></p></td><td ><p><b>Very Good</b></p></td><td><p><b>Excellent</b></p></td></tr> ";
    //                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
    //                    str_instructor = str_instructor + "</thead> <tbody>";
    //                    var comments = '';
    //                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
    //                        if (feedbcak_instructions_data[j]["feedback_type"] == "AA") {
    //                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
    //                            str_instructor += "</tr>";
    //                        }
    //                    }
    //                    str_instructor = str_instructor + "</tbody></table>";
    //                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_AA[i]["instructor_name"] + " :</b></p>";
    //                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
    //                    document.getElementById('div_taught_supporte_AA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
    //                }
    //            }
    //        }
    //    }
    //    ////TA 
    //    //if (str_instructor_selection[0] == "taught_supporte_TA") {
    //    //    if (radio_value == "Y") {
    //    //        document.getElementById('div_taught_supporte_TA~' + str_instructor_selection[1]).style.display = 'block';
    //    //        if (!document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].checked) {
    //    //            document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].focus();
    //    //            document.activeElement.click();
    //    //        }
    //    //    }
    //    //    else {
    //    //        document.getElementById('div_taught_supporte_TA~' + str_instructor_selection[1]).style.display = 'none';
    //    //    }
    //    //}
    //    //else if (str_instructor_selection[0] == "taught_supporte_yes") {
    //    //    document.getElementById('div_taught_supporte_TA_relevent~' + str_instructor_selection[1]).innerHTML = '';
    //    //    if (radio_value == "T") {
    //    //        for (var i = 0; i < instructor_data_TA.length; i++) {
    //    //            
    //    //            var str_instructor = '';
    //    //            if (instructor_data_TA[i]["instructor_code"] == str_instructor_selection[1]) {
    //    //                //                    if ($('#course_type').val() == '7') {
    //    //                //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
    //    //                //                    }
    //    //                //                    else {
    //    //                str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_TA[i]["instructor_name"] + "</b></span>";
    //    //                //                    }
    //    //                str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
    //    //                str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px; width: 650px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_TA[i]["instructor_code"] + " /></td>";
    //    //                str_instructor = str_instructor + "<td colspan='3' style='text-align: center;'><p><b>Unsatisfactory</b></p></td><td colspan='3' style='text-align: center;'><p><b>Average</b></p></td><td colspan='2' style='text-align: center;'><p><b>Good</b></p></td><td style='text-align: center; '><p><b>Very Good</b></p></td><td style='text-align: center;'><p><b>Excellent</b></p></td></tr> ";
    //    //                str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
    //    //                str_instructor = str_instructor + "</thead> <tbody>";
    //    //                var comments = '';
    //    //                for (var j = 0; j < feedbcak_instructions_data.length; j++) {
    //    //                    if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
    //    //                        str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
    //    //                        str_instructor += "</tr>";
    //    //                    }
    //    //                }
    //    //                str_instructor = str_instructor + "</tbody></table>";
    //    //                str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_TA[i]["instructor_name"] + " :</b></p>";
    //    //                str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
    //    //                document.getElementById('div_taught_supporte_TA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
    //    //            }
    //    //        }
    //    //    }
    //    //    else {
    //    //        for (var i = 0; i < instructor_data_TA.length; i++) {
    //    //            var str_instructor = '';
    //    //            if (instructor_data_TA[i]["instructor_code"] == str_instructor_selection[1]) {
    //    //                //                    if ($('#course_type').val() == '7') {
    //    //                //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
    //    //                //                    }
    //    //                //                    else {
    //    //                str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_TA[i]["instructor_name"] + "</b></span>";
    //    //                //                    }
    //    //                str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
    //    //                str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px; align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;  width:650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_TA[i]["instructor_code"] + " /></td> ";
    //    //                str_instructor = str_instructor + "<td colspan='3'><p><b>Unsatisfactory</b></p></td><td colspan='3'><p><b>Average</b></p></td><td colspan='2'><p><b>Good</b></p></td><td ><p><b>Very Good</b></p></td><td><p><b>Excellent</b></p></td></tr> ";
    //    //                str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
    //    //                str_instructor = str_instructor + "</thead> <tbody>";
    //    //                var comments = '';
    //    //                for (var j = 0; j < feedbcak_instructions_data.length; j++) {
    //    //                    if (feedbcak_instructions_data[j]["feedback_type"] == "TA") {
    //    //                        str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
    //    //                        str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
    //    //                        str_instructor += "</tr>";
    //    //                    }
    //    //                }
    //    //                str_instructor = str_instructor + "</tbody></table>";
    //    //                str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_TA[i]["instructor_name"] + " :</b></p>";
    //    //                str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
    //    //                document.getElementById('div_taught_supporte_TA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
    //    //            }
    //    //        }
    //    //    }
    //    //}
    //});
    //$("input:radio").on('click', function () {
    //    var str_instructor_selection = document.activeElement.name.split('~');
    //    var radio_value = document.activeElement.value;
    //    //TA 
    //    if (str_instructor_selection[0] == "taught_supporte_TA") {
    //        if (radio_value == "Y") {
    //            document.getElementById('div_taught_supporte_TA~' + str_instructor_selection[1]).style.display = 'block';
    //            if (!document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].checked) {
    //                document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].focus();
    //                document.activeElement.click();
    //            }
    //        }
    //        else {
    //            document.getElementById('div_taught_supporte_TA~' + str_instructor_selection[1]).style.display = 'none';
    //        }
    //    }
    //    else if (str_instructor_selection[0] == "taught_supporte_yes") {
    //        document.getElementById('div_taught_supporte_TA_relevent~' + str_instructor_selection[1]).innerHTML = '';
    //        if (radio_value == "T") {
    //            for (var i = 0; i < instructor_data_TA.length; i++) {
    //                var str_instructor = '';
    //                if (instructor_data_TA[i]["instructor_code"] == str_instructor_selection[1]) {
    //                    //                    if ($('#course_type').val() == '7') {
    //                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
    //                    //                    }
    //                    //                    else {
    //                    str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_TA[i]["instructor_name"] + "</b></span>";
    //                    //                    }
    //                    str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
    //                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px; width: 650px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_TA[i]["instructor_code"] + " /></td>";
    //                    str_instructor = str_instructor + "<td colspan='3' style='text-align: center;'><p><b>Unsatisfactory</b></p></td><td colspan='3' style='text-align: center;'><p><b>Average</b></p></td><td colspan='2' style='text-align: center;'><p><b>Good</b></p></td><td style='text-align: center; '><p><b>Very Good</b></p></td><td style='text-align: center;'><p><b>Excellent</b></p></td></tr> ";
    //                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
    //                    str_instructor = str_instructor + "</thead> <tbody>";
    //                    var comments = '';
    //                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
    //                        if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
    //                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
    //                            str_instructor += "</tr>";
    //                        }
    //                    }
    //                    str_instructor = str_instructor + "</tbody></table>";
    //                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_TA[i]["instructor_name"] + " :</b></p>";
    //                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
    //                    document.getElementById('div_taught_supporte_TA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
    //                }
    //            }
    //        }
    //        else {
    //            for (var i = 0; i < instructor_data_TA.length; i++) {
    //                
    //                var str_instructor = '';
    //                if (instructor_data_TA[i]["instructor_code"] == str_instructor_selection[1]) {
    //                    //                    if ($('#course_type').val() == '7') {
    //                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
    //                    //                    }
    //                    //                    else {
    //                    str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_TA[i]["instructor_name"] + "</b></span>";
    //                    //                    }
    //                    str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
    //                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px; align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;  width:650px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_TA[i]["instructor_code"] + " /></td> ";
    //                    str_instructor = str_instructor + "<td colspan='3'><p><b>Unsatisfactory</b></p></td><td colspan='3'><p><b>Average</b></p></td><td colspan='2'><p><b>Good</b></p></td><td ><p><b>Very Good</b></p></td><td><p><b>Excellent</b></p></td></tr> ";
    //                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>1</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>5</td><td style=' text-align: center;'>6</td><td style=' text-align: center;'>7</td><td style=' text-align: center;'>8</td><td style=' text-align: center;'>9</td><td style=' text-align: center;'>10</td></tr>";
    //                    str_instructor = str_instructor + "</thead> <tbody>";
    //                    var comments = '';
    //                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
    //                        if (feedbcak_instructions_data[j]["feedback_type"] == "TA") {
    //                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='1' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='2' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='3' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='4' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='5' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='6' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='7' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='8' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='9' /> </center></td> ";
    //                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='10' /> </center></td> ";
    //                            str_instructor += "</tr>";
    //                        }
    //                    }
    //                    str_instructor = str_instructor + "</tbody></table>";
    //                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_TA[i]["instructor_name"] + " :</b></p>";
    //                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";
    //                    document.getElementById('div_taught_supporte_TA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
    //                }
    //            }
    //        }
    //    }
    //});
}

$('.check').live('click', function () {
    var check_id;
    var table_id;

    if (this.checked) {
        if (this.value == 'N') {
            check_id = $(this).attr('class').split(' ');

            $('#' + check_id[1]).css('display', 'none');
            $('#' + check_id[1] + 'instruction').css('display', 'none');
            $('#' + check_id[1] + 'commenttitle').css('display', 'none');

            //$('#' + check_id[1]).attr('disabled', 'disabled');
            //$('#' + check_id[1]).readonly = true;
            //$('#' + check_id[1]).disabled = 'disabled';

            $('#' + check_id[1]).find("input,button,textarea").attr("disabled", "disabled");
            $('#' + check_id[1] + 'instruction').find("textarea").attr("disabled", "disabled");
        }
        else {
            check_id = $(this).attr('class').split(' ');

            $('#' + check_id[1]).css('display', 'block');
            $('#' + check_id[1] + 'instruction').css('display', 'block');
            $('#' + check_id[1] + 'commenttitle').css('display', 'block');
            $('#' + check_id[1]).find("input,button,textarea").prop("disabled", false);
            $('#' + check_id[1] + 'instruction').find("textarea").attr("disabled", false);
        }
    }
    else {
        check_id = $(this).attr('class').split(' ');

        $('#' + check_id[1]).find("input,button,textarea").prop("disabled", false);
        $('#' + check_id[1] + 'instruction').find("textarea").attr("disabled", false);
    }
});

function bind_assigned_data() {
    //bootbox.confirm("You cannot edit or resubmit your feedback so please recheck before submitting.", function (result1) {});

    $('#divlecture').css('display', 'none');
    $('#divseminar').css('display', 'none');
    $('#divworkshop').css('display', 'none');
    $('#divstudio').css('display', 'none');
    $('.lblclass').css('display', 'none');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_student_assigned_current_sem_data_for_feedback",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                displaydata(data.d);
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function displaydata(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#datalist_saved").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_saved"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#datatable_saved").dataTable({
        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course", "mData": "course", "bSortable": false },
            {
                "sTitle": "<center>Submit Feedbak</center>", "mData": null, "bSortable": false,
                "sDefaultContent": '<center><button type="button" class="btn btn-lg btn-primary btnfeedback">Submit</button></center>'
            },
            { "sTitle": "Course", "mData": "course_code", "bVisible": false }
        ]
    });

    $('#datalist_saved').css('display', 'block');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_student_saved_feedback_data",
        aSync: false,
        data: "{}",
        dataType: "json",
        success: function (data1) {
            if (data1.d != '') {
                saved_data = JSON.parse(data1.d);

                $("#datalist_saved tbody tr").each(function (i) {
                    var aPos = oTable.fnGetPosition(this);
                    var aData = oTable.fnGetData(aPos[i]);
                    var a = aData[i];

                    for (var j = 0; j < saved_data.length; j++) {
                        if (saved_data[j]["course"] == aData[i].course_code) {
                            //$(this.nTr).addClass('row_selected');
                            $(this.nTr).removeClass('row_selected');
                            $(this).css('color', "#D6D5C3");
                            $(this).find('.btnfeedback').prop('disabled', 'disabled');
                        }
                    }
                });
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}