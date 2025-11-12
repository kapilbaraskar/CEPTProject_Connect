
var oTable;
var instructor_data = '';
var instructor_data_AA = '';
var saved_data = '';
var feedbcak_instructions_data = '';

$(document).ready(function () {

    debugger;

    $("input:radio[name=taught_supporte_AA]").click(function () {


        if ($("input[type='radio'][name='taught_supporte_AA']:checked").val() == "Y") {
            $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'block');
        }
        else {
            $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'none');
        }

    });

    //    $("input:radio").click(function () {


    //        alert('hi');

    //        if ($("input[type='radio'][name='taught_supporte_AA']:checked").val() == "Y") {
    //            $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'block');
    //        }
    //        else {
    //            $('#div_tick_TS_yes,#div_AA_instructor').css('display', 'none');
    //        }

    //    });

    $("input:radio[name=taught_supporte_yesssssss]").click(function () {

        $('#div_AA_instructor').html('');
        debugger;
        if ($("input[type='radio'][name='taught_supporte_yes']:checked").val() == "T") {
            for (var i = 0; i < instructor_data.length; i++) {
                debugger;
                var str_instructor = '';

                if (instructor_data[i]["designation"] == 'AA') {



                    //                    if ($('#course_type').val() == '7') {
                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //                    }
                    //                    else {
                    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";

                    //                    }

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
                debugger;
                var str_instructor = '';

                if (instructor_data[i]["designation"] == 'AA') {



                    //                    if ($('#course_type').val() == '7') {
                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                    //                    }
                    //                    else {
                    str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";

                    //                    }

                    str_instructor = str_instructor + "<table id=" + ('table_supported' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                    str_instructor = str_instructor + "</thead> <tbody>";

                    var comments = '';

                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {

                        if (feedbcak_instructions_data[j]["feedback_type"] == "AA") {


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


    //  bind_assigned_data();


    check_saved_feedback();

    display_form();

    //    $('.btnfeedback').live('click', function (e) {

    //        debugger;
    //      

    //    });
    $(":checkbox").change(function () {

        alert('hi');

        $(this).html('kkkkkk');

    });


    $('.btnfeedback').live('click', function (e) {


        debugger;

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

            if (coucourse_split[1] == "3" || coucourse_split[1] == "4") { // for lecture

                course_typology = '3';
                $('#course_type_name').text('Lecture Course');

            }
            else if (coucourse_split[1] == "5" || coucourse_split[1] == "6" || coucourse_split[1] == "13") { // for seminar
                course_typology = '5';
                $('#course_type_name').text('Seminar Course');
            }
            else if (coucourse_split[1] == "9" || coucourse_split[1] == "1" || coucourse_split[1] == "8") { // for workshop
                course_typology = '1';
                $('#course_type_name').text('Workshop Course');
            }
            else if (coucourse_split[1] == "7") {

                course_typology = coucourse_split[1];
                $('#course_type_name').text('Studio Course');
            }


            debugger;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_instructor_code_for_course_code",
                aSync: false,
                data: "{course_code:'" + coucourse_split[0] + "',course_typology:'" + course_typology + "'}",
                dataType: "json",
                success: function (data) {


                    debugger;
                    //   var str_instructor = '';
                    if (data.d != null) {




                        instructor_data = JSON.parse(data.d[0]);


                        debugger;
                        //for Lecture



                        if (data.d[1] != null) {

                            $('#divseminar').css('display', 'none');
                            $('#divworkshop').css('display', 'none');
                            $('#divstudio').css('display', 'none');

                            $('#div_lecture').html('');
                            $('#div_seminar').html('');
                            $('#div_workshop').html('');
                            $('#div_studio').html('');

                            $('#course_lecture tbody').html('');
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
                                    //                                    if (feedbcak_instructions_data[i]["not_applicable"] == "Y") {
                                    //                                        str += "<td> <center> <input type='radio' name='1." + (i + 1) + "' class='chknonapplicable' /> </center></td> ";
                                    //                                    }
                                    //                                    else {
                                    //                                        str += "<td></td> ";
                                    //                                    }
                                    str += "</tr>";


                                    $('#course_lecture tbody').append(str);
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


                                //                                str = str + "<tbody><tr><td>The classes started on time</td><td><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.6' + " class='chkstronglyagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.6' + " class='chkagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.6' + " class='chkneitherAgree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.6' + " class='chkdisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.6' + " class='chkstronglydisagree' /></center></td><td valign='top'></td></tr>";
                                //                                str = str + "<tr><td>The sessions were held according to course outline</td><td><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.1' + " class='chkstronglyagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.1' + " class='chkagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.1' + " class='chkneitherAgree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.1' + " class='chkdisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.1' + " class='chkstronglydisagree' /></center></td><td valign='top'></td></tr>";
                                //                                str = str + "<tr><td>The course was taught well and key concepts were clearly communicated</td><td><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.2' + " class='chkstronglyagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.2' + " class='chkagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.2' + " class='chkneitherAgree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.2' + " class='chkdisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.2' + " class='chkstronglydisagree' /></center></td><td valign='top'></td></tr>";
                                //                                str = str + "<tr><td>Conceptual and critical thinking was encouraged</td><td><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.3' + " class='chkstronglyagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.3' + " class='chkagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.3' + " class='chkneitherAgree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.3' + " class='chkdisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.3' + " class='chkstronglydisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.3' + " class='chknonapplicable' /></center></td></tr>";
                                //                                str = str + "<tr><td>The instructor made the subject interesting</td><td><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.4' + " class='chkstronglyagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.4' + " class='chkagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.4' + " class='chkneitherAgree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.4' + " class='chkdisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.4' + " class='chkstronglydisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.4' + " class='chknonapplicable' /></center></td></tr>";
                                //                                str = str + "<tr><td>Questions raised in class were effectively addressed</td><td><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.5' + " class='chkstronglyagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.5' + " class='chkagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.5' + " class='chkneitherAgree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.5' + " class='chkdisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.5' + " class='chkstronglydisagree' /></center></td><td valign='top'><center> <input type='radio' name=" + ('table' + parseInt(i + 1)) + '2.5' + " class='chknonapplicable' /></center></td></tr></tbody>";


                                for (var j = 0; j < feedbcak_instructions_data.length; j++) {

                                    if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {

                                        str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                        str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                        //                                        if (feedbcak_instructions_data[j]["not_applicable"] == "Y") {
                                        //                                            str_instructor += "<td> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chknonapplicable' /> </center></td> ";
                                        //                                        }
                                        //                                        else {
                                        //                                            str_instructor += "<td></td> ";
                                        //                                        }
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




    //For Lecture Save
    $('#btn_lecture').on('click', function () {

        var flag = 'N';
        var datalist = [];
        $("#course_lecture tbody tr").each(function (i) {

            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            //ob["instructor_code"] = $(this).find('.instructor_name').val();
            ob["instructor_code"] = "";
            ob["sr_no"] = i + 1;
            //   ob["description"] = $(this).children().eq(1).html().trim();
            ob["description"] = "";
            ob["comments"] = $('#txt_course_instruction').val().trim();
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["releted_feedback"] = "course";

            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            if ($(this).find('.chkstronglyagree:checked').val() || $(this).find('.chkagree:checked').val() || $(this).find('.chkneitherAgree:checked').val() ||
            $(this).find('.chkdisagree:checked').val() || $(this).find('.chkstronglydisagree:checked').val() || $(this).find('.chknonapplicable:checked').val()) {


            }
            else {


                bootbox.alert('Please select the appropriate response for  <br /><b>"' + $(this).children().eq(1).html().trim() + '" </b> for the Course');
                flag = 'Y';
                return false;
            }


            if ($(this).find('.chkstronglyagree:checked').val()) {

                ob["strongly_agree"] = "Y";
            }

            if ($(this).find('.chkagree:checked').val()) {

                ob["agree"] = "Y";
            }
            if ($(this).find('.chkneitherAgree:checked').val()) {

                ob["neither_agree"] = "Y";
            }
            if ($(this).find('.chkdisagree:checked').val()) {

                ob["disagree"] = "Y";
            }
            if ($(this).find('.chkstronglydisagree:checked').val()) {

                ob["strongly_disagree"] = "Y";
            }
            if ($(this).find('.chknonapplicable:checked').val()) {

                ob["not_applicable"] = "Y";
            }

            datalist.push(ob);

        });

        if (flag == 'N') {

            if (instructor_data != null) {


                for (var i = 0; i < instructor_data.length; i++) {

                    if (flag == 'N') {

                        $("#table" + (i + 1) + " tbody tr").each(function (j) {

                            if ($(this).find('.chkstronglyagree').is(':disabled') == false) {
                                var ob = {};

                                ob["course_code"] = $('#course_code').val();
                                ob["course_type"] = $('#course_type').val();
                                ob["instructor_code"] = instructor_data[i]['instructor_code'];

                                ob["sr_no"] = j + 1;
                                ob["description"] = "";
                                //    ob["description"] = $(this).children().eq(1).html();
                                ob["comments"] = $("#table" + (i + 1) + "instruction").val().trim();
                                ob["strongly_agree"] = "N";
                                ob["agree"] = "N";
                                ob["neither_agree"] = "N";
                                ob["disagree"] = "N";
                                ob["strongly_disagree"] = "N";
                                ob["not_applicable"] = "N";
                                ob["releted_feedback"] = "instructor";

                                ob["taught_supported_selection_AA"] = "";
                                ob["taught_supported_selection_if_yes"] = "";

                                if ($(this).find('.chkstronglyagree:checked').val() || $(this).find('.chkagree:checked').val() || $(this).find('.chkneitherAgree:checked').val() ||
                            $(this).find('.chkdisagree:checked').val() || $(this).find('.chkstronglydisagree:checked').val() || $(this).find('.chknonapplicable:checked').val()) {

                                }
                                else {

                                    bootbox.alert('Please select the appropriate response for <br /><b>"' + $(this).children().eq(1).html() + '"</b> for Instructor :' + instructor_data[i]['instructor_name']);
                                    flag = 'Y';
                                    return false;
                                }

                                if ($(this).find('.chkstronglyagree:checked').val()) {

                                    ob["strongly_agree"] = "Y";
                                }

                                if ($(this).find('.chkagree:checked').val()) {

                                    ob["agree"] = "Y";
                                }
                                if ($(this).find('.chkneitherAgree:checked').val()) {

                                    ob["neither_agree"] = "Y";
                                }
                                if ($(this).find('.chkdisagree:checked').val()) {

                                    ob["disagree"] = "Y";
                                }
                                if ($(this).find('.chkstronglydisagree:checked').val()) {

                                    ob["strongly_disagree"] = "Y";
                                }
                                if ($(this).find('.chknonapplicable:checked').val()) {

                                    ob["not_applicable"] = "Y";
                                }

                                datalist.push(ob);
                            }
                        });
                    }
                }

            }

            //            var check_taught_selection = "";
            //            var check_taught_selection_after_yes = "";
            //            var table_name = "";
            //            var related_feedback_name = "";

            //            if ($("input[type='radio'][name='taught_supporte_AA']:checked").val() == "Y") {
            //                check_taught_selection = "Y";
            //            }
            //            else {
            //                check_taught_selection = "N";
            //            }

            //            if (check_taught_selection == "Y") {

            //                if ($("input[type='radio'][name='taught_supporte_yes']:checked").val() == undefined) {
            //                    // $("input[name=taught_supporte_AA][value= 'N']").prop("checked", true);
            //                    bootbox.alert('Please select Taught or Supported for Academic Associate.');
            //                    flag = 'Y';
            //                    return false;
            //                }
            //            }

            //            if ($("input[type='radio'][name='taught_supporte_yes']:checked").val() == "T") {
            //                table_name = "table_taught";
            //                related_feedback_name = "instructor";
            //                check_taught_selection_after_yes = "T";
            //            }
            //            else {
            //                table_name = "table_supported";
            //                related_feedback_name = "AA";
            //                check_taught_selection_after_yes = "S";
            //            }
            debugger;
            if (instructor_data_AA != "") {

                for (var i = 0; i < instructor_data_AA.length; i++) {

                    var taught_supporte_AA_value = $("input[type='radio'][name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();

                    debugger;
                    if (flag == 'N') {

                        if (taught_supporte_AA_value == "Y") {

                            if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == undefined) {

                                bootbox.alert('Please select Taught or Supported for ' + instructor_data_AA[i]["instructor_name"]);
                                flag = 'Y';
                                return false;
                            }

                            $("#table_taught-" + instructor_data_AA[i]["instructor_code"] + " tbody tr").each(function (j) {



                                if ($(this).find('.chkstronglyagree').is(':disabled') == false) {
                                    var ob = {};

                                    ob["course_code"] = $('#course_code').val();
                                    ob["course_type"] = $('#course_type').val();
                                    ob["instructor_code"] = instructor_data_AA[i]['instructor_code'];

                                    ob["sr_no"] = j + 1;
                                    //    ob["description"] = $(this).children().eq(1).html();
                                    ob["description"] = "";

                                    ob["comments"] = $("#table_taught-" + instructor_data_AA[i]['instructor_code'] + "instruction").val();
                                    ob["strongly_agree"] = "N";
                                    ob["agree"] = "N";
                                    ob["neither_agree"] = "N";
                                    ob["disagree"] = "N";
                                    ob["strongly_disagree"] = "N";
                                    ob["not_applicable"] = "N";
                                    if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == "T") {
                                        ob["releted_feedback"] = "instructor";
                                    }
                                    else {
                                        ob["releted_feedback"] = "AA";
                                    }


                                    if ($(this).find('.chkstronglyagree:checked').val() || $(this).find('.chkagree:checked').val() || $(this).find('.chkneitherAgree:checked').val() ||
                                        $(this).find('.chkdisagree:checked').val() || $(this).find('.chkstronglydisagree:checked').val() || $(this).find('.chknonapplicable:checked').val()) {


                                    }
                                    else {


                                        bootbox.alert('Please select the appropriate response for <br /><b>"' + $(this).children().eq(1).html() + '"</b> for Instructor :' + instructor_data_AA[i]['instructor_name']);
                                        flag = 'Y';
                                        return false;
                                    }


                                    ob["taught_supported_selection_AA"] = taught_supporte_AA_value;
                                    ob["taught_supported_selection_if_yes"] = $("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();


                                    if ($(this).find('.chkstronglyagree:checked').val()) {

                                        ob["strongly_agree"] = "Y";
                                    }

                                    if ($(this).find('.chkagree:checked').val()) {

                                        ob["agree"] = "Y";
                                    }
                                    if ($(this).find('.chkneitherAgree:checked').val()) {

                                        ob["neither_agree"] = "Y";
                                    }
                                    if ($(this).find('.chkdisagree:checked').val()) {

                                        ob["disagree"] = "Y";
                                    }
                                    if ($(this).find('.chkstronglydisagree:checked').val()) {

                                        ob["strongly_disagree"] = "Y";
                                    }
                                    if ($(this).find('.chknonapplicable:checked').val()) {

                                        ob["not_applicable"] = "Y";
                                    }

                                    datalist.push(ob);
                                }
                            });
                        }
                    }

                }
            }

        }
        debugger;
        //        var course_aspect = $('#txt_lecture_aspect').val();
        //        var course_suggestion = $('#txt_lecture_suggestion').val();

        var course_aspect = '';
        var course_suggestion = '';

        if (flag == 'N') {


            var data = JSON.stringify({ table_data: JSON.stringify(datalist), course_aspect: course_aspect, course_suggestion: course_suggestion, submit_status: 'Y', taught_supported_selection_AA: "", taught_supported_selection_if_yes: "" });

            //   alert('hi');

            bootbox.confirm({
                // title: "danger - danger - danger",
                message: "You cannot edit or resubmit your feedback so please recheck before submitting.",

                buttons: {
                    cancel: {
                        label: "Recheck"
                        //   className: "btn-default pull-left"
                    },
                    confirm: {
                        label: "Submit"
                        // className: "btn-danger pull-right"
                    }
                },
                callback: function (result) {

                    if (result == true) {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../WebService.asmx/save_feedback_data",

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


    //For Save
    $('#btn_save').on('click', function () {

        var flag = 'N';
        var datalist = [];
        $("#course_lecture tbody tr").each(function (i) {

            var ob = {};

            ob["course_code"] = $('#course_code').val();
            ob["course_type"] = $('#course_type').val();
            //ob["instructor_code"] = $(this).find('.instructor_name').val();
            ob["instructor_code"] = "";
            ob["sr_no"] = i + 1;
            //  ob["description"] = $(this).children().eq(1).html().trim();
            ob["description"] = "";
            ob["comments"] = $('#txt_course_instruction').val().trim();
            ob["strongly_agree"] = "N";
            ob["agree"] = "N";
            ob["neither_agree"] = "N";
            ob["disagree"] = "N";
            ob["strongly_disagree"] = "N";
            ob["not_applicable"] = "N";
            ob["releted_feedback"] = "course";
            ob["taught_supported_selection_AA"] = "";
            ob["taught_supported_selection_if_yes"] = "";

            //            if ($(this).find('.chkstronglyagree:checked').val() || $(this).find('.chkagree:checked').val() || $(this).find('.chkneitherAgree:checked').val() ||
            //            $(this).find('.chkdisagree:checked').val() || $(this).find('.chkstronglydisagree:checked').val() || $(this).find('.chknonapplicable:checked').val()) {


            //            }
            //            else {


            //                bootbox.alert('Please select the appropriate box of ' + $(this).children().eq(0).html().trim() + ' for course');
            //                flag = 'Y';
            //                return false;
            //            }


            if ($(this).find('.chkstronglyagree:checked').val()) {

                ob["strongly_agree"] = "Y";
            }

            if ($(this).find('.chkagree:checked').val()) {

                ob["agree"] = "Y";
            }
            if ($(this).find('.chkneitherAgree:checked').val()) {

                ob["neither_agree"] = "Y";
            }
            if ($(this).find('.chkdisagree:checked').val()) {

                ob["disagree"] = "Y";
            }
            if ($(this).find('.chkstronglydisagree:checked').val()) {

                ob["strongly_disagree"] = "Y";
            }
            if ($(this).find('.chknonapplicable:checked').val()) {

                ob["not_applicable"] = "Y";
            }

            datalist.push(ob);

        });

        if (flag == 'N') {

            if (instructor_data != null) {


                for (var i = 0; i < instructor_data.length; i++) {


                    if (flag == 'N') {


                        $("#table" + (i + 1) + " tbody tr").each(function (j) {


                            var ob = {};

                            ob["course_code"] = $('#course_code').val();
                            ob["course_type"] = $('#course_type').val();
                            ob["instructor_code"] = instructor_data[i]['instructor_code'];

                            ob["sr_no"] = j + 1;
                            // ob["description"] = $(this).children().eq(1).html();
                            ob["description"] = "";
                            ob["comments"] = $("#table" + (i + 1) + "instruction").val().trim();
                            ob["strongly_agree"] = "N";
                            ob["agree"] = "N";
                            ob["neither_agree"] = "N";
                            ob["disagree"] = "N";
                            ob["strongly_disagree"] = "N";
                            ob["not_applicable"] = "N";
                            ob["releted_feedback"] = "instructor";
                            ob["taught_supported_selection_AA"] = "";
                            ob["taught_supported_selection_if_yes"] = "";

                            //                        if ($(this).find('.chkstronglyagree:checked').val() || $(this).find('.chkagree:checked').val() || $(this).find('.chkneitherAgree:checked').val() ||
                            //               $(this).find('.chkdisagree:checked').val() || $(this).find('.chkstronglydisagree:checked').val() || $(this).find('.chknonapplicable:checked').val()) {


                            //                        }
                            //                        else {


                            //                            bootbox.alert('Please select the appropriate box of ' + $(this).children().eq(0).html() + ' for Instructor :' + instructor_data[i]['instructor_name']);
                            //                            flag = 'Y';
                            //                            return false;
                            //                        }

                            if ($(this).find('.chkstronglyagree:checked').val()) {

                                ob["strongly_agree"] = "Y";
                            }

                            if ($(this).find('.chkagree:checked').val()) {

                                ob["agree"] = "Y";
                            }
                            if ($(this).find('.chkneitherAgree:checked').val()) {

                                ob["neither_agree"] = "Y";
                            }
                            if ($(this).find('.chkdisagree:checked').val()) {

                                ob["disagree"] = "Y";
                            }
                            if ($(this).find('.chkstronglydisagree:checked').val()) {

                                ob["strongly_disagree"] = "Y";
                            }
                            if ($(this).find('.chknonapplicable:checked').val()) {

                                ob["not_applicable"] = "Y";
                            }

                            datalist.push(ob);

                        });
                    }
                }
            }


            //            var check_taught_selection = "";
            //            var check_taught_selection_after_yes = "";
            //            var table_name = "";
            //            var related_feedback_name = "";

            //            if ($("input[type='radio'][name='taught_supporte_AA']:checked").val() == "Y") {
            //                check_taught_selection = "Y";
            //            }
            //            else {
            //                check_taught_selection = "N";
            //            }

            //            if (check_taught_selection == "Y") {

            //                if ($("input[type='radio'][name='taught_supporte_yes']:checked").val() == undefined) {
            //                    check_taught_selection = "N";
            //                    // $("input[name=taught_supporte_AA][value= 'N']").prop("checked", true);
            //                }
            //            }

            //            if ($("input[type='radio'][name='taught_supporte_yes']:checked").val() == "T") {
            //                table_name = "table_taught";
            //                related_feedback_name = "instructor";
            //                check_taught_selection_after_yes = "T";
            //            }
            //            else {
            //                table_name = "table_supported";
            //                related_feedback_name = "AA";
            //                check_taught_selection_after_yes = "S";
            //            }



            //  if (check_taught_selection == "Y") {

            debugger;

            if (instructor_data_AA != "") {


                for (var i = 0; i < instructor_data_AA.length; i++) {

                    var taught_supporte_AA_value = $("input[type='radio'][name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();

                    debugger;
                    if (flag == 'N') {

                        if (taught_supporte_AA_value == "Y") {



                            $("#table_taught-" + instructor_data_AA[i]["instructor_code"] + " tbody tr").each(function (j) {



                                if ($(this).find('.chkstronglyagree').is(':disabled') == false) {
                                    var ob = {};

                                    ob["course_code"] = $('#course_code').val();
                                    ob["course_type"] = $('#course_type').val();
                                    ob["instructor_code"] = instructor_data_AA[i]['instructor_code'];

                                    ob["sr_no"] = j + 1;
                                    //    ob["description"] = $(this).children().eq(1).html();
                                    ob["description"] = "";

                                    ob["comments"] = $("#table_taught-" + instructor_data_AA[i]['instructor_code'] + "instruction").val();
                                    ob["strongly_agree"] = "N";
                                    ob["agree"] = "N";
                                    ob["neither_agree"] = "N";
                                    ob["disagree"] = "N";
                                    ob["strongly_disagree"] = "N";
                                    ob["not_applicable"] = "N";
                                    if ($("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val() == "T") {
                                        ob["releted_feedback"] = "instructor";
                                    }
                                    else {
                                        ob["releted_feedback"] = "AA";
                                    }

                                    ob["taught_supported_selection_AA"] = taught_supporte_AA_value;
                                    ob["taught_supported_selection_if_yes"] = $("input[type='radio'][name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "']:checked").val();


                                    if ($(this).find('.chkstronglyagree:checked').val()) {

                                        ob["strongly_agree"] = "Y";
                                    }

                                    if ($(this).find('.chkagree:checked').val()) {

                                        ob["agree"] = "Y";
                                    }
                                    if ($(this).find('.chkneitherAgree:checked').val()) {

                                        ob["neither_agree"] = "Y";
                                    }
                                    if ($(this).find('.chkdisagree:checked').val()) {

                                        ob["disagree"] = "Y";
                                    }
                                    if ($(this).find('.chkstronglydisagree:checked').val()) {

                                        ob["strongly_disagree"] = "Y";
                                    }
                                    if ($(this).find('.chknonapplicable:checked').val()) {

                                        ob["not_applicable"] = "Y";
                                    }

                                    datalist.push(ob);
                                }
                            });
                        }
                    }

                }
            }
        }
        debugger;
        //        var course_aspect = $('#txt_lecture_aspect').val();
        //        var course_suggestion = $('#txt_lecture_suggestion').val();

        var course_aspect = '';
        var course_suggestion = '';

        if (flag == 'N') {


            var data = JSON.stringify({ table_data: JSON.stringify(datalist), course_aspect: course_aspect, course_suggestion: course_suggestion, submit_status: 'N', taught_supported_selection_AA: "", taught_supported_selection_if_yes: "" });


            //            bootbox.confirm({
            //                // title: "danger - danger - danger",
            //                message: "You cannot edit or resubmit your feedback so please recheck before submitting.",

            //                buttons: {
            //                    cancel: {
            //                        label: "Recheck"
            //                        //   className: "btn-default pull-left"
            //                    },
            //                    confirm: {
            //                        label: "Submit"
            //                        // className: "btn-danger pull-right"
            //                    }
            //                },
            //                callback: function (result) {

            //                    if (result == true) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/save_feedback_data",

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
            //                    }
            //                }
            //            });
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


                debugger;
                var feedback_saved_data = JSON.parse(data1.d);


                for (var j = 0; j < feedback_saved_data.length; j++) {
                    debugger;
                    if (feedback_saved_data[j]["course"] == course) {

                        //  bootbox.alert("The Feedback of this course is already submitted by you.");

                        bootbox.confirm({
                            // title: "danger - danger - danger",
                            message: "The Feedback of this course is already submitted by you.",
                            closeButton: true,
                            buttons: {
                                cancel: {
                                    label: "Cancel"
                                    //                                    className: "btn-default pull-left",

                                },
                                confirm: {
                                    label: "OK"
                                    // className: "btn-danger pull-right"
                                }
                            },
                            callback: function (result) {
                                window.location.href = "Feedback_dashboard.aspx";
                            }
                        });

                        return false;
                        //  break;

                    }

                }



            }
        }

    });
}

function display_form() {

    debugger;

    //    var row = $(this).closest("tr").get(0);
    //    var aData = oTable.fnGetData(row);

    var course = getParameterByName('course_code');

    var course_name = getParameterByName('course_name');


    $('.lblclass').text(course_name);

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

        if (coucourse_split[1] == "3" || coucourse_split[1] == "4" || coucourse_split[1] == "12") { // for lecture
            course_typology = '3';
            $('#course_type_name').text('Lecture Course');
        }
        else if (coucourse_split[1] == "5" || coucourse_split[1] == "6" || coucourse_split[1] == "13") { // for seminar
            course_typology = '5';
            $('#course_type_name').text('Seminar Course');
        }
        else if (coucourse_split[1] == "9" || coucourse_split[1] == "1" || coucourse_split[1] == "8") { // for workshop
            course_typology = '1';
            $('#course_type_name').text('Workshop Course');
        }
        else if (coucourse_split[1] == "7" || coucourse_split[1] == "14") {

            //            course_typology = coucourse_split[1];
            course_typology = "7";
            $('#course_type_name').text('Studio Course');
        }
        else {

            bootbox.alert("This course is not eligible for feedback.");
            return false;
        }

        debugger;
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/Get_instructor_code_for_course_code_for_feedback",
            aSync: false,
            data: "{course_code:'" + coucourse_split[0] + "',course_typology:'" + course_typology + "'}",
            dataType: "json",
            success: function (data) {
                debugger;
                //   var str_instructor = '';
                if (data.d != null) {


                    var feedback_saved_data = '';
                    var taught_saved_data = '';

                    var taught_supported_selection = '';
                    var taught_supported_selection_if_yes = '';

                    instructor_data = JSON.parse(data.d[0]);

                    if (data.d[2] != null) {

                        feedback_saved_data = JSON.parse(data.d[2]);
                    }
                    debugger;
                    //for Lecture

                    if (data.d[3] != null) {

                        taught_saved_data = JSON.parse(data.d[3]);

                        //                        taught_supported_selection = taught_saved_data[0]["taught_supported_selection_AA"];
                        //                        taught_supported_selection_if_yes = taught_saved_data[0]["taught_supported_selection_if_yes"];
                    }

                    if (data.d[4] != null) {

                        instructor_data_AA = JSON.parse(data.d[4]);

                    }

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
                        $('#course_workshop tbody').html();
                        $('#course_studio tbody').html('');
                        $('#course_seminar tbody').html('');

                        feedbcak_instructions_data = JSON.parse(data.d[1]);

                        for (var i = 0; i < feedbcak_instructions_data.length; i++) {

                            if (feedbcak_instructions_data[i]["feedback_type"] == "course") {

                                if (feedback_saved_data != '') {

                                    for (var k = 0; k < feedback_saved_data.length; k++) {


                                        if (feedback_saved_data[k]["releted_feedback"] == 'course' && feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[i]["sr_no"]) {

                                            $('#txt_course_instruction').val(feedback_saved_data[k]["comments"]);
                                            var str = "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";

                                            if (feedback_saved_data[k]["strongly_agree"] == 'Y') {
                                                str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                            }
                                            else {
                                                str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                            }

                                            if (feedback_saved_data[k]["agree"] == 'Y') {
                                                str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='chkagree' /> </center></td> ";
                                            }
                                            else {
                                                str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkagree' /> </center></td> ";
                                            }

                                            if (feedback_saved_data[k]["neither_agree"] == 'Y') {
                                                str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                            }
                                            else {
                                                str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                            }

                                            if (feedback_saved_data[k]["disagree"] == 'Y') {
                                                str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='chkdisagree' /> </center></td> ";
                                            }
                                            else {
                                                str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkdisagree' /> </center></td> ";
                                            }

                                            if (feedback_saved_data[k]["strongly_disagree"] == 'Y') {
                                                str += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='1." + (i + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                            }
                                            else {
                                                str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                            }
                                            str += "</tr>";

                                            $('#course_lecture tbody').append(str);
                                        }
                                    }

                                }
                                else {
                                    var str = "<tr><td>" + feedbcak_instructions_data[i]["sr_no"] + "</td><td>" + feedbcak_instructions_data[i]["feedback_instruction"] + " </td> ";
                                    str += "<td style='width:57px'><center> <input type='radio' name='1." + (i + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkagree' /> </center></td> ";
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkdisagree' /> </center></td> ";
                                    str += "<td style='width:57px'> <center> <input type='radio' name='1." + (i + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                    str += "</tr>";

                                    $('#course_lecture tbody').append(str);
                                }
                            }
                            else {

                            }

                        }

                        if (coucourse_split[0] != '3022') {

                            if (instructor_data != null) {

                                $('.instructor_feedback_lable').css('display', 'block');

                                for (var i = 0; i < instructor_data.length; i++) {
                                    debugger;
                                    var str_instructor = '';

                                    if (instructor_data[i]["designation"] != 'AA') {

                                        if (course_typology == '7') {
                                            //                                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                                            str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /> I have interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was assigned to us for studio ";
                                            str_instructor += "  ( Yes  <input checked='checked' type='radio' value='Y' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='check " + ('table' + parseInt(i + 1)) + "' /> No  <input  type='radio' value='N' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='check " + ('table' + parseInt(i + 1)) + "'/> )<br /> ";
                                        }
                                        else {
                                            str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";

                                        }

                                        str_instructor = str_instructor + "<table id=" + ('table' + parseInt(i + 1)) + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                                        str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                                        str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                                        str_instructor = str_instructor + "</thead> <tbody>";

                                        var comments = '';

                                        for (var j = 0; j < feedbcak_instructions_data.length; j++) {

                                            if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {

                                                if (feedback_saved_data != '') {

                                                    for (var k = 0; k < feedback_saved_data.length; k++) {


                                                        if (feedback_saved_data[k]["releted_feedback"] == 'instructor') {

                                                            if (feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[j]["sr_no"] && feedback_saved_data[k]["instructor_code"] == instructor_data[i]["instructor_code"]) {

                                                                str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";

                                                                comments = feedback_saved_data[k]["comments"];

                                                                if (feedback_saved_data[k]["strongly_agree"] == 'Y') {
                                                                    str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                                                }
                                                                else {
                                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                                                }

                                                                if (feedback_saved_data[k]["agree"] == 'Y') {
                                                                    str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                                                }
                                                                else {
                                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                                                }

                                                                if (feedback_saved_data[k]["neither_agree"] == 'Y') {
                                                                    str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                                                }
                                                                else {
                                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                                                }

                                                                if (feedback_saved_data[k]["disagree"] == 'Y') {
                                                                    str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                                                }
                                                                else {
                                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                                                }

                                                                if (feedback_saved_data[k]["strongly_disagree"] == 'Y') {
                                                                    str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                                                }
                                                                else {
                                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                                                }
                                                                str_instructor += "</tr>";

                                                            }
                                                        }
                                                    }


                                                }
                                                else {

                                                    str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                                    str_instructor += "<td style='width:57px'> <center> <input type='radio' name='" + ('table' + parseInt(i + 1)) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";

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

                            //    if (taught_supported_selection == "Y") {



                            //                                $('#div_AA_instructor,#div_tick_TS_yes').css('display', 'block');

                            //                                 $('#div_AA_instructor').html('');

                            //                                var table_name = "";
                            //                                var feedbackType = "";



                            //                                if (taught_supported_selection_if_yes == "T") {
                            //                                    table_name = "table_taught";
                            //                                    feedbackType = "instructor";
                            //                                }
                            //                                else {
                            //                                    table_name = "table_supported";
                            //                                    feedbackType = "AA";
                            //                                }

                            //                                $("input[name=taught_supporte_yes][value= '" + taught_supported_selection_if_yes + "']").prop("checked", true);
                            //                                $("input[name=taught_supporte_AA][value= '" + taught_supported_selection + "']").prop("checked", true);

                            $('#div_AA_instructor_selection').html('<p class="instructor_feedback_lable">  <br /><b>3. Feedback : Academic Associate </b> </p>');



                            for (var i = 0; i < instructor_data_AA.length; i++) {
                                debugger;
                                var str_instructor = '';

                                var str_instructor_selection = '';

                                var instructor_code = instructor_data_AA[i]["instructor_code"];

                                str_instructor_selection = "3." + (i + 1) + " Have you been Supported by <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span> : &nbsp; " +
                                                            "<input type='radio' name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "' value='Y'>Yes " +
                                                            "<input type='radio' name='taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "' checked value='N'>No " +
                                                            "<br /> <br /> <div id='div_taught_supporte_AA~" + instructor_data_AA[i]["instructor_code"] + "' style='display:none;'>" +
                                                            "<div style='display:block;opacity: 0;'>&nbsp; &nbsp; &nbsp; Please Tick the relevant : <input type='radio' name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "'  value='T'>Taught " +
                                                            "<input type='radio' name='taught_supporte_yes~" + instructor_data_AA[i]["instructor_code"] + "'  value='S'>Supported </div>" +
                                                            "<div id='div_taught_supporte_AA_relevent~" + instructor_data_AA[i]["instructor_code"] + "'></div></div> <br /> ";

                                $('#div_AA_instructor_selection').css('display', 'block');

                                $('#div_AA_instructor').css('display', 'block');

                                $('#div_AA_instructor_selection').append(str_instructor_selection);

                                var table_name = "table_taught-" + instructor_data_AA[i]["instructor_code"];

                                var feedbackType = "";
                                //     if (course_typology == '7') {

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



                                                str_instructor = str_instructor + " <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span>";
                                                //   }
                                                //    else {
                                                //       str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span>";

                                                //   }

                                                str_instructor = str_instructor + "<table id=" + table_name + " border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                                                str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_AA[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                                                str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                                                str_instructor = str_instructor + "</thead> <tbody>";

                                                var comments = '';

                                                for (var j = 0; j < feedbcak_instructions_data.length; j++) {

                                                    if (feedbcak_instructions_data[j]["feedback_type"] == feedbackType) {

                                                        if (feedback_saved_data != '') {

                                                            for (var k = 0; k < feedback_saved_data.length; k++) {

                                                                debugger;
                                                                if (feedback_saved_data[k]["releted_feedback"] == feedbackType) {

                                                                    if (feedback_saved_data[k]["sr_no"] == feedbcak_instructions_data[j]["sr_no"] && feedback_saved_data[k]["instructor_code"] == instructor_data_AA[i]["instructor_code"]) {

                                                                        str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";

                                                                        comments = feedback_saved_data[k]["comments"];

                                                                        if (feedback_saved_data[k]["strongly_agree"] == 'Y') {
                                                                            str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                                                        }
                                                                        else {
                                                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                                                        }

                                                                        if (feedback_saved_data[k]["agree"] == 'Y') {
                                                                            str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                                                        }
                                                                        else {
                                                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                                                        }

                                                                        if (feedback_saved_data[k]["neither_agree"] == 'Y') {
                                                                            str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                                                        }
                                                                        else {
                                                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                                                        }

                                                                        if (feedback_saved_data[k]["disagree"] == 'Y') {
                                                                            str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                                                        }
                                                                        else {
                                                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                                                        }

                                                                        if (feedback_saved_data[k]["strongly_disagree"] == 'Y') {
                                                                            str_instructor += "<td style='width:57px'> <center> <input checked='checked' type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                                                        }
                                                                        else {
                                                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + instructor_code + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";
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


                                // $('#div_AA_instructor').append(str_instructor);
                            }




                        }
                        // }

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

                $("input:radio").on('click', function () {
                    var str_instructor_selection = document.activeElement.name.split('~');
                    var radio_value = document.activeElement.value;

                    if (str_instructor_selection[0] == "taught_supporte_AA") {
                        if (radio_value == "Y") {
                            document.getElementById('div_taught_supporte_AA~' + str_instructor_selection[1]).style.display = 'block';

                            if (!document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].checked) {
                                document.getElementsByName('taught_supporte_yes~' + str_instructor_selection[1])[1].focus();
                                document.activeElement.click();
                            }
                        }
                        else {
                            document.getElementById('div_taught_supporte_AA~' + str_instructor_selection[1]).style.display = 'none';
                        }
                    }
                    else if (str_instructor_selection[0] == "taught_supporte_yes") {

                        document.getElementById('div_taught_supporte_AA_relevent~' + str_instructor_selection[1]).innerHTML = '';

                        if (radio_value == "T") {
                            for (var i = 0; i < instructor_data_AA.length; i++) {
                                debugger;
                                var str_instructor = '';

                                if (instructor_data_AA[i]["instructor_code"] == str_instructor_selection[1]) {

                                    //                    if ($('#course_type').val() == '7') {
                                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                                    //                    }
                                    //                    else {
                                    str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span>";

                                    //                    }

                                    str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_AA[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                                    str_instructor = str_instructor + "</thead> <tbody>";

                                    var comments = '';

                                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                                        if (feedbcak_instructions_data[j]["feedback_type"] == "instructor") {
                                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                            str_instructor += "</tr>";
                                        }
                                    }

                                    str_instructor = str_instructor + "</tbody></table>";
                                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_AA[i]["instructor_name"] + " :</b></p>";
                                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                                    document.getElementById('div_taught_supporte_AA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
                                }
                            }
                        }
                        else {



                            for (var i = 0; i < instructor_data_AA.length; i++) {
                                debugger;
                                var str_instructor = '';

                                if (instructor_data_AA[i]["instructor_code"] == str_instructor_selection[1]) {

                                    //                    if ($('#course_type').val() == '7') {
                                    //                        str_instructor = " <span style='color:#2283c5 !important'><b>Prof. " + instructor_data[i]["instructor_name"] + "</b></span><br /><input type='checkbox'  class='check " + ('table' + parseInt(i + 1)) + "' /> I have not interacted with Prof. " + instructor_data[i]["instructor_name"] + ", he/she was not assigned to us for studio<br />";
                                    //                    }
                                    //                    else {
                                    str_instructor = " <span style='color:#2283c5 !important'><b> " + instructor_data_AA[i]["instructor_name"] + "</b></span>";

                                    //                    }

                                    str_instructor = str_instructor + "<table id='table_taught-" + str_instructor_selection[1] + "'  border='1' cellspacing='0' cellpadding='0' class='data-table table table-bordered table-striped'>";
                                    str_instructor = str_instructor + "<thead><tr class='table_header'><td rowspan='2' style='padding-top: 20px;' align='center'><b>Sr No.</b></td><td rowspan='2' style='padding-top: 20px;' align='center'><b>Your answers to questions below will be useful for evaluating the effectiveness of the instructor.  </b><p></p><input type='hidden' class='instructor_name' value =" + instructor_data_AA[i]["instructor_code"] + " /></td><td><p><b>Strongly Agree</b></p></td><td><p><b>Agree</b></p></td><td ><p><b>Neutral</b></p></td><td><p><b>Disagree</b></p></td><td><p><b>Strongly Disagree</b></p></td></tr> ";
                                    str_instructor = str_instructor + "<tr class='table_header'><td style=' text-align: center;'>5</td><td style=' text-align: center;'>4</td><td style=' text-align: center;'>3</td><td style=' text-align: center;'>2</td><td style=' text-align: center;'>1</td></tr>";
                                    str_instructor = str_instructor + "</thead> <tbody>";

                                    var comments = '';

                                    for (var j = 0; j < feedbcak_instructions_data.length; j++) {
                                        if (feedbcak_instructions_data[j]["feedback_type"] == "AA") {
                                            str_instructor += "<tr><td>" + feedbcak_instructions_data[j]["sr_no"] + "</td><td>" + feedbcak_instructions_data[j]["feedback_instruction"] + " </td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglyagree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkagree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkneitherAgree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkdisagree' /> </center></td> ";
                                            str_instructor += "<td style='width:57px'> <center> <input type='radio' name='table_taught-" + str_instructor_selection[1] + "_" + parseInt(i + 1) + "2." + (j + 1) + "' class='chkstronglydisagree' /> </center></td> ";
                                            str_instructor += "</tr>";
                                        }
                                    }

                                    str_instructor = str_instructor + "</tbody></table>";
                                    str_instructor = str_instructor + " <p><br /><b>Please write your comments about " + instructor_data_AA[i]["instructor_name"] + " :</b></p>";
                                    str_instructor = str_instructor + " <div class='control-group'>  <textarea id='table_taught-" + str_instructor_selection[1] + "instruction' style='width: 99%; height: 110px' rows='3' cols='5' name='address'>" + comments + "</textarea></div>";

                                    document.getElementById('div_taught_supporte_AA_relevent~' + str_instructor_selection[1]).innerHTML = str_instructor;
                                }
                            }

                        }

                    }
                });

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

$('.check').live('click', function () {

    var check_id;
    var table_id;
    debugger;

    if (this.checked) {

        if (this.value == 'N') {

            check_id = $(this).attr('class').split(' ');


            $('#' + check_id[1]).css('display', 'none');
            $('#' + check_id[1] + 'instruction').css('display', 'none');
            $('#' + check_id[1] + 'commenttitle').css('display', 'none');
            
            debugger;

            //        $('#' + check_id[1]).attr('disabled', 'disabled');

            //        $('#' + check_id[1]).readonly = true;
            //        $('#' + check_id[1]).disabled = 'disabled';

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



    //    bootbox.confirm("You cannot edit or resubmit your feedback so please recheck before submitting.", function (result1) {

    //       
    //    
    //    });

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
                         "sTitle": "<center>Submit Feedbak</center>",
                         "mData": null,
                         "bSortable": false,
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


                debugger;
                saved_data = JSON.parse(data1.d);

                $("#datalist_saved tbody tr").each(function (i) {
                    debugger;
                    var aPos = oTable.fnGetPosition(this);
                    var aData = oTable.fnGetData(aPos[i]);
                    var a = aData[i];


                    for (var j = 0; j < saved_data.length; j++) {
                        debugger;
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