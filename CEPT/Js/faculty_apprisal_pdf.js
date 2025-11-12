$(document).ready(function () {
    var page_name = location.pathname.split('/').slice(-1)[0];
    get_details();
    if ($('#hdn_user_type').val() == "D")
    {
        $('#tbl_comments_activity_publish .comment_committee').css('display', 'none');
    }
    if ($('#hdn_comment_type').val() == "w")
    {
        $('.comment_div').css('display', 'none');
    }

});


function get_details() {

    var user_id = $('#hdnuserid').val();
    var year = ''
    if ($('#hdn_user_id').val() != '') {
        user_id = $('#hdn_user_id').val();
    }
    if ($('#hdn_year').val() != '') {
        year = $('#hdn_year').val();
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_self_evaluation_dtl",
        async: false,
        data: "{ inst_code: '" + user_id + "',year: '" + year + "' }",
        dataType: "json",
        success: function (data) {

            if (data.d[0] != "" && data.d[0] != null) {
                var research_publish = JSON.parse(data.d[0]);
                var str_row = '';
                for (var i = 0; i < research_publish.length; i++) {
                    str_row += "<tr><td>" + research_publish[i]['TypeName'] + "</td>";
                    str_row += "<td>" + research_publish[i]['title_of_research'] + "</td>";
                    str_row += "<td>" + research_publish[i]['Type'] + "</td>";
                    str_row += "<td>" + research_publish[i]['name_of_journal'] + "</td>";
                    str_row += "<td>" + research_publish[i]['conference_type'] + "</td>";
                    str_row += "<td>" + research_publish[i]['impact_factor_of_journal'] + "</td>";
                    str_row += "<td>" + research_publish[i]['co_author'] + "</td>";
                    str_row += "<td>" + research_publish[i]['publication_month'] + "</td>";
                    str_row += "<td>" + research_publish[i]['publication_year'] + "</td>";
                    str_row += "<td>" + research_publish[i]['submitted_to_university'] + "</td>";
                    str_row += "</tr>";
                    $('#txt_res_publish_year').text(research_publish[i]['total_hours']);
                }

                $('#tbl_rese_publish').append(str_row);

            }
            if (data.d[1] != "" && data.d[1] != null) {
                var add_comp_ongoing = JSON.parse(data.d[1]);
                var str_row = '';
                for (var i = 0; i < add_comp_ongoing.length; i++) {

                    str_row += "<tr><td>" + add_comp_ongoing[i]['title'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['TypeName'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['Description'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['funding_agency'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['fund_available'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['duration'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['status'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['StartDateChange'] + "</td>";
                    str_row += "<td>" + add_comp_ongoing[i]['EndDateChange'] + "</td>";
                    str_row += "</tr>";
                    $('#txt_res_com_ongoing').text(add_comp_ongoing[i]['total_hours']);
                }
                $('#tbl_comp_ongoing_publish').append(str_row);
            }


            if (data.d[2] != "" && data.d[2] != null) {
                var other_research_activities = JSON.parse(data.d[2]);
                //$('#other_activity').text(other_research_activities[0]['other_research_activities']);


                var str_row = '';
                for (var i = 0; i < other_research_activities.length; i++) {

                    str_row += "<tr><td>" + other_research_activities[i]['Title'] + "</td>";
                    str_row += "<td>" + other_research_activities[i]['TypeName'] + "</td>";
                    str_row += "<td>" + other_research_activities[i]['other_research_activities'] + "</td>";
                    str_row += "<td>" + other_research_activities[i]['StartDate'] + "</td>";

                    str_row += "</tr>";
                    
                }
                $('#tbl_other_activity').append(str_row);
               
                $('#txt_other_activity').text(other_research_activities[0]['total_hours']);
            }
            if (data.d[3] != "" && data.d[3] != null) {
                var Various_Activities = JSON.parse(data.d[3]);
                var str_row = '';
                for (var i = 0; i < Various_Activities.length; i++) {
                    str_row += "<tr><td>" + Various_Activities[i]['Type'] + "</td>";
                    str_row += "<td>" + Various_Activities[i]['list_the_various_activities'] + "</td>";
                    str_row += "<td>" + Various_Activities[i]['Organisation'] + "</td>";
                    str_row += "<td>" + Various_Activities[i]['TypeName'] + "</td>";
                    str_row += "<td>" + Various_Activities[i]['status'] + "</td>";
                    str_row += "<td>" + Various_Activities[i]['StartDateChange'] + "</td>";
                    str_row += "<td>" + Various_Activities[i]['EndDateChange'] + "</td>";
                    str_row += "</tr>";
                    $('#txt_various_activity').text(Various_Activities[i]['total_hours']);


                }
                $('#tbl_various_activity_publish').append(str_row);
            }

            if (data.d[4] != "" && data.d[4] != null) {
                var comp_profess = JSON.parse(data.d[4]);
                var str_row = '';
                for (var i = 0; i < comp_profess.length; i++) {

                    str_row += "<tr><td>" + comp_profess[i]['list_professional_development_training'] + "</td>";
                    str_row += "<td>" + comp_profess[i]['Title'] + "</td>";
                    str_row += "<td>" + comp_profess[i]['description'] + "</td>";
                    str_row += "<td>" + comp_profess[i]['duration'] + "</td>";
                    str_row += "<td>" + comp_profess[i]['StartDateChange'] + "</td>";
                    str_row += "<td>" + comp_profess[i]['EndDateChange'] + "</td>";
                    /*str_row += "<td>" + comp_profess[i]['list_professional_development_training'] + "</td>";*/
                    str_row += "<td>" + comp_profess[i]['organizers'] + "</td>";
                    str_row += "<td>" + comp_profess[i]['number_of_participants'] + "</td>";
                    $('#txt_profess_activity').text(comp_profess[i]['total_hours']);
                    str_row += "</tr>";

                }
                $('#tbl_professional_activity_publish').append(str_row);
            }
            if (data.d[5] != "" && data.d[5] != null) {
                var Administrative_Work = JSON.parse(data.d[5]);
                var str_row = '';
                for (var i = 0; i < Administrative_Work.length; i++) {

                    str_row += "<tr><td>" + Administrative_Work[i]['Title'] + "</td>";
                    str_row += "<td>" + Administrative_Work[i]['Type'] + "</td>";
                    str_row += "<td>" + Administrative_Work[i]['administrative_work'] + "</td>";
                    str_row += "<td>" + Administrative_Work[i]['status'] + "</td>";
                    str_row += "<td>" + Administrative_Work[i]['StartDateChange'] + "</td>";
                    str_row += "<td>" + Administrative_Work[i]['StartDateChange'] + "</td>";
                    str_row += "<td>" + Administrative_Work[i]['Duration'] + "</td>";
                    $('#txt_Institutional_activity').text(Administrative_Work[i]['total_hours']);
                    str_row += "</tr>";
                }
                $('#tbl_Institutional_activity_publish').append(str_row);
            }


            if (data.d[6] != "" && data.d[6] != null) {
                var Trainings_Programs = JSON.parse(data.d[6]);
                var str_row = '';
                for (var i = 0; i < Trainings_Programs.length; i++) {
                    str_row += "<tr><td>" + Trainings_Programs[i]['Title'] + "</td>";
                    str_row += "<td>" + Trainings_Programs[i]['Type'] + "</td>";
                    str_row += "<td>" + Trainings_Programs[i]['trainings_programs_attended'] + "</td>";
                    str_row += "<td>" + Trainings_Programs[i]['StartDateChange'] + "</td>";
                    str_row += "<td>" + Trainings_Programs[i]['Organizer'] + "</td>";
                    str_row += "<td>" + Trainings_Programs[i]['ModeofTraining'] + "</td>";
                    $('#txt_trainings_activity').text(Trainings_Programs[i]['total_hours']);
                    str_row += "</tr>";


                }
                $('#tbl_skill_activity_publish').append(str_row);
            }
            if (data.d[7] != "" && data.d[7] != null) {
                var facilitating_Programs = JSON.parse(data.d[7]);
                var str_row = '';
                for (var i = 0; i < facilitating_Programs.length; i++)
                {
                    str_row += "<tr><td>" + facilitating_Programs[i]['mention_facilitating'] + "</td>"
                        + "</tr> ";
                }
                $('#tbl_facilitating_activity_publish').append(str_row);
            }


            if (data.d[8] != "" && data.d[8] != null) {
                var mention_Programs = JSON.parse(data.d[8]);
                var str_row = '';
                for (var i = 0; i < mention_Programs.length; i++) {

                    str_row += "<tr><td>" + mention_Programs[i]['mention_inhibiting'] + "</td>"
                            + "</tr> ";
                }
                $('#tbl_Inhibiting_activity_publish').append(str_row);
            }
            if (data.d[9] != "" && data.d[9] != null) {
                var Trainings = JSON.parse(data.d[9]);
                var str_row = '';
                for (var i = 0; i < Trainings.length; i++) {

                        str_row += "<tr><td>" + Trainings[i]['training_skill'] + "</td>"
                            + "</tr> ";  
                    
                }
                $('#tbl_training_activity_publish').append(str_row);
            }
            if (data.d[10] != "" && data.d[10] != null) {
                var self_evaluation_dtl = JSON.parse(data.d[10]);
                var rating_dtl = '';
                var question_dtl = '';
                if (data.d[13] != "" && data.d[13] != null) {
                    rating_dtl = JSON.parse(data.d[13]);
                }
                var str_row = '';
                var rating_value = '';
                for (var i = 0; i < self_evaluation_dtl.length; i++) {
                    if (rating_dtl != '') {
                        var response2 = $.grep(Object(rating_dtl), function (j) {
                            var status = j.question_id.trim() === self_evaluation_dtl[i]["question_id"].trim();
                            if (status == true) {
                                rating_value = j.rating.trim()
                                return false;
                            }
                        });
                    }


                    if (self_evaluation_dtl[i]["question_id"].trim() == "t1") {
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> A1) Teaching : </b></td></tr>";
                    }

                    else if (self_evaluation_dtl[i]["question_id"].trim() == "s1") {
                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> A2) Studios & Courses : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "f1") {
                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> A3) Student Feedback : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "r1") {

                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; margin-top:5%; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> B) Research : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "if1") {

                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> C) Institutional Role (Faculty  - needs to be graded separately) : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "iu1") {

                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> D) Institutional Role (University - needs to be graded separately) : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "sk1") {

                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';

                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> E) Skills : </b></td></tr>";
                    }

                    else if (self_evaluation_dtl[i]["question_id"].trim() == "p1") {
                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> F) Personality : </b></td></tr>";
                    }


                    str_row += "<tr><td style='width: 80%;'><b>" + self_evaluation_dtl[i]["doc_no"].trim() + " . " + self_evaluation_dtl[i]["question"].trim() + "</b></td>"
                        + "<td>" + rating_value + "</td>"
                        + "</tr> ";

                    if (i + 1 == self_evaluation_dtl.length) {
                        str_row += '<tr><td colspan=3 style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5 class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() + '"></td>';
                    }
                }
                $('#tbl_self_evaluation_dtl').append(str_row);
                if (data.d[14] != "" && data.d[14] != null) {
                    question_dtl = JSON.parse(data.d[14]);
                    for (var i = 0; i < question_dtl.length; i++) {
                        $('.' + question_dtl[i]["question_type"]).text(question_dtl[i]['question_comment'].trim());
                    }
                }
            }

            if (data.d[11] != "" && data.d[11] != null) {
                var get_faculty_course_code = JSON.parse(data.d[11]);
                var str_row = '';
                var total_hours = 0;
                for (var i = 0; i < get_faculty_course_code.length; i++) {
                    var response2 = $.grep(Object(get_faculty_course_code), function (j) {

                        return j.course_code === get_faculty_course_code[i]["course_code"];
                    });
                    total_hours = parseInt(parseInt(total_hours) + parseInt(get_faculty_course_code[i]["total_hrs_in_semester"]));
                    str_row += "<tr><td>" + get_faculty_course_code[i]["semester"] + "</td><td>" + get_faculty_course_code[i]["course_code"] + "</td><td>" + get_faculty_course_code[i]["course_name"] + "</td>";
                    str_row += "<td>" + get_faculty_course_code[i]["course_credits"] + "</td><td>" + get_faculty_course_code[i]["total_hrs_in_semester"] + "</td><td>" + get_faculty_course_code[i]["add_total_hrs_in_semester"] + "</td><td>" + get_faculty_course_code[i]["total_no_of_year_count"] + "</td></tr>";


                }
                $('#tbl_teaching_dtl').append(str_row);
                $('#txt_cours_hours').text(total_hours);
            }

            if (data.d[12] != "" && data.d[12] != null) {
                var get_faculty_drp_dtl = JSON.parse(data.d[12]);
                var str_row = '';
                var total_hours = 0;
                for (var i = 0; i < get_faculty_drp_dtl.length; i++) {
                    total_hours = parseInt(parseInt(total_hours) + parseInt(get_faculty_drp_dtl[i]["total_hrs_in_semester"]));
                    str_row += "<tr><td>" + get_faculty_drp_dtl[i]["semester"] + "</td>";
                    str_row += "<td>" + get_faculty_drp_dtl[i]["course_code"] + "- " + get_faculty_drp_dtl[i]["course_name"] + "</td></tr>";

                }
                $('#tbl_drp_thesis_dtl').append(str_row);
                $('#txt_drp_thesis').text(total_hours);
            }

            if (data.d[15] != "" && data.d[15] != null) {
                var get_cpop_personal_details = JSON.parse(data.d[15]);
                var str_row = '';

                $('#txt_name').text(get_cpop_personal_details[0]['supervisor_name']);
                $('#txt_designation').text(get_cpop_personal_details[0]['designation']);
                $('#txt_faculty').text(get_cpop_personal_details[0]['department']);
            }

            if (data.d[16] != "" && data.d[16] != null) {
                var get_instructor_education_details = JSON.parse(data.d[16]);
                var str_row = '';

                for (var i = 0; i < get_instructor_education_details.length; i++) {
                    str_row += "<tr><td>" + get_instructor_education_details[i]["degree"] + "</td><td>" + get_instructor_education_details[i]["field"] + "</td>";
                    str_row += "<td>" + get_instructor_education_details[i]["institution"] + "</td><td>" + get_instructor_education_details[i]["year_of_completion"] + "</td></tr>";

                }
                $('#tbl_education_dtl').append(str_row);

            }

            if (data.d[17] != "" && data.d[17] != null) {
                var get_comments_details = JSON.parse(data.d[17]);
                $('#deancomments').text(get_comments_details[0]["dean_comment"]);
                $('#deanallcomments').text(get_comments_details[0]["over_all_comment_by_dean"]);
                $('#reviewcomments').text(get_comments_details[0]["comment_by_review_committee"]);


                $('#txt_faculty').text(get_comments_details[0]["dept_name"]);
                //$('#txt_designation').text(get_comments_details[0]["designation"]);
                $('#txt_year_experience').text(get_comments_details[0]["total_year_experience"]);
                $('#txt_year_teaching').text(get_comments_details[0]["teaching_year"]);
                $('#txt_teaching_experience').text(get_comments_details[0]["total_teaching_experiance"]);
                $('#txt_year_teaching').val(get_comments_details[0]["imteaching_year"]);
                $('#txt_joining_date').text(get_comments_details[0]["date_of_join"]);
                $('#txt_confirmation_date').text(get_comments_details[0]["confirmationdate"]);
                $('#txt_drp_thesis').text(get_comments_details[0]["drp_thesis_hours"]);
                if (get_comments_details[0]["total_hrs_teaching"] != "")
                {
                    $('#txt_cours_hours').text(get_comments_details[0]["total_hrs_teaching"]);
                }
                if (get_comments_details[0]["dean_approve"] == "Y" && $('#hdnusertype').val() == 'D') {
                    $('#submitBtnDiv').css('display', 'none');
                }
                else if (get_comments_details[0]["faculty_approve"] == "Y" && $('#hdnusertype').val() == 'I2') {
                    $('#submitBtnDiv').css('display', 'none');
                }
                else if ($('#hdnusertype').val() == 'HR' && get_comments_details[0]["uso_approve"] == "Y") {
                    $('#deanallcomments').attr('disabled', 'disabled');
                    $('#deancomments').attr('disabled', 'disabled');
                    $('#submitBtnDiv').css('display', 'none');
                    var str_row = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsavecomment' type='button' style='display: block' class='btn btn-primary'>" +
                        "<i class='icon-save bigger-160'></i>Save Comments </button></td> </tr></table>";
                    $('#submitBtnDivhr').html(str_row);
                    $('#submitBtnDivhr').css('display', 'block');

                }

            }


            if (data.d[19] != "" && data.d[19] != null) {
                var Conferences_publish = JSON.parse(data.d[19]);
                var str_row = '';
                for (var i = 0; i < Conferences_publish.length; i++) {
                    str_row += "<tr><td>" + Conferences_publish[i]['Title'] + "</td>";
                    str_row += "<td>" + Conferences_publish[i]['Type'] + "</td>";
                    str_row += "<td>" + Conferences_publish[i]['NameOFConference'] + "</td>";
                    str_row += "<td>" + Conferences_publish[i]['conferencetype'] + "</td>";
                    str_row += "<td>" + Conferences_publish[i]['Authorship'] + "</td>";
                    str_row += "<td>" + Conferences_publish[i]['StartDateChange'] + "</td>";
                    str_row += "<td>" + Conferences_publish[i]['EndDateChange'] + "</td>";
                    str_row += "<td>" + Conferences_publish[i]['submittedToUniversity'] + "</td>";
                    str_row += "</tr>";
                    $('#txt_res_conferences_year').text(Conferences_publish[i]['total_hours']);
                }

                $('#tbl_conferences_publish').append(str_row);

            }

        },
        error: function (result) {
            alert(result);
        }
    });
}