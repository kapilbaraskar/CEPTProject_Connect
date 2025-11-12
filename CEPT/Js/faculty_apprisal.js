var action = 'S';
var str_year_html = '';
var month_text = '<option value=""> Please Select Month </option><option value="1"> January </option><option value = "2">February </option>';
month_text += '<option value="3"> March </option>';
month_text += '<option value="4"> April </option>';
month_text += '<option value="5"> May </option>';
month_text += '<option value="6"> June </option>';
month_text += '<option value="7"> July </option>';
month_text += '<option value="8"> August </option>';
month_text += '<option value="9"> September </option>'; 
month_text += '<option value="10"> October </option>';
month_text += '<option value="11"> November </option>';
month_text += '<option value="12"> December </option>';
var type_publication = '';
var GetResearchProjectType = '';
var OtherActivityType = '';
var VariousActivities = '';
$(document).ready(function () {

    if ($('#hdnusertype').val() == 'I2') {
        $('#txt_joining_date').attr('disabled', 'disabled');
        $('#txt_total_experiance_months').attr('disabled', 'disabled');
        $('#txt_year_experience').attr('disabled', 'disabled');
        $('#txt_year_teaching').attr('disabled', 'disabled');
        $('#txt_teaching_experience').attr('disabled', 'disabled');
        $('#txt_confirmation_date').attr('disabled', 'disabled');
    }
    if ($('#hdn_year').val() == '') {
        $('#year_self').text($('#show_hdn_year').val());
    }
    else {
        $('#year_self').text($('#hdn_year').val());
    }
    if ($('#hdnusertype').val() == 'D' || $('#hdnusertype').val() == 'HR') {
        $('#comment_section').css('display', 'block');
    }
    if ($('#hdnusertype').val() == 'HR') {
        $('#txt_confirmation_date').attr('disabled', false);
    }
    //
    var page_name = location.pathname.split('/').slice(-1)[0];
    if (page_name != "Apprisal_pdf.aspx") {



        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);

        $('#txt_joining_date').datepicker({
            format: "dd/mm/yyyy",
            autoclose: true,
            endDate: new Date
        });
        $('#txt_year_teaching').datepicker({
            format: "dd-mm-yyyy",
            autoclose: true,
            endDate: new Date
        });

        $('#txt_confirmation_date').datepicker({
            format: "dd-mm-yyyy",
            autoclose: true,
            endDate: new Date
        });
        $('#txt_ongoing_start_date').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date
        });
        $('#txt_ongoing_end_date').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date
        });
        $('#other_activity_date_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date
        });

        $('#prof_Start_Date_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#prof_End_Date_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#publish_StartDate_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });

        $('#publish_EndDate_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#skill_Date_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#comp_StartDate_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#comp_EndDate_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#res_conference_start_date_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#res_conference_enddate_0').datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });


        var str_drp_associate_html = "<option value=''>-- Teaching Year --</option>";
        var cur_date = new Date();
        for (k = cur_date.getFullYear(); k >= 1962; k--) {
            str_drp_associate_html = str_drp_associate_html + "<option value='" + k + "'>" + k + "</option>";
        }

        $('#txt_year_teaching').html(str_drp_associate_html);


        str_year_html = "<option value=''>-- Select Year --</option>";
        var cur_date = new Date();
        for (j = cur_date.getFullYear(); j >= 1962; j--) {
            str_year_html = str_year_html + "<option value='" + j + "'>" + j + "</option>";
        }
        $('#res_year_0').html(str_year_html);

        get_details();
        // $('#txt_name').text('Kapil');

        function replace_special_char(data) {
            if (data != '') {
                data = data.replace(/\\/g, '\\\\');
                //data = data.replace(/\'/g, '\\\'')
                data = data.replace(/"/g, '\\\"');
                //data = data.replace(/'/g, '"');
            }
            return data;
        }

        $('#btnapprove').on('click', function () {
            action = 'A';
            $('#btnsave').click();
        });

        $('#btnsavecomment').on('click', function () {
            var user_id = $('#hdnuserid').val();
            var year = ''
            if ($('#hdn_user_id').val() != '') {
                user_id = $('#hdn_user_id').val();
            }
            if ($('#hdn_year').val() != '') {
                year = $('#hdn_year').val();
            }
            if ($('#deancomments').val() == '' && $('#hdnusertype').val() == 'D') {
               // alert("Please Enter Dean’s comments (For Training Programs )");
               // return false;
            }
            if ($('#deanallcomments').val() == '' && $('#hdnusertype').val() == 'D') {
                //alert("Please Enter Over All Comments by the Faculty Dean )");

                Swal.fire({
                    text: "Please Enter Over All Comments by the Faculty Dean !",
                    icon: "info",
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn btn-primary"
                    }
                });
                return false;
            }
            
            if ($('#reviewcomments').val() == '' && $('#hdnusertype').val() == 'HR') {
                //alert("Please Enter Comments by review committee");
                Swal.fire({
                    text: "Please Enter Comments by review committee !",
                    icon: "info",
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn btn-primary"
                    }
                });
                return false;
            }


            var res_Comments = [];
            var research_comments = { 'comments': '', 'instructor_code': '' };
            research_comments.instructor_code = user_id
            research_comments.comments = replace_special_char($('#reviewcomments').val());
            research_comments.over_all_comment_by_dean = replace_special_char($('#deanallcomments').val());
            research_comments.comment_by_review_committee = replace_special_char($('#deancomments').val());
            res_Comments.push(research_comments);


            var All_instructor_data = [res_Comments];
            var json_All_instructor_data = JSON.stringify(All_instructor_data);

            if (json_All_instructor_data.search("'") != -1) {
                json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_comments",
                async: false,
                data: "{ All_table_course_data: '" + json_All_instructor_data + "',inst_code: '" + user_id + "',year: '" + year + "' }",
                dataType: "json",
                success: function (data) {
                    if (data.d == true) {

                        Swal.fire({
                            text: "Self Evaluation Comments Save Successfully !",
                            icon: "success",
                            buttonsStyling: false,
                            confirmButtonText: "Ok, got it!",
                            customClass: {
                                confirmButton: "btn btn-primary"
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                location.reload();
                            }
                        });

                       // bootbox.alert('Self Evaluation Comments Save Successfully', function ()
                       // {
                       //     location.reload();
                       // });
                    }
                },
                error: function (result) {
                   // alert(result);

                    Swal.fire({
                        text: result,
                        icon: "info",
                        buttonsStyling: false,
                        confirmButtonText: "Ok, got it!",
                        customClass: {
                            confirmButton: "btn btn-primary"
                        }
                    });
                }
            });

        });

        $('#btnsave').on('click', function () {
            //Setp 3
            var user_id = $('#hdnuserid').val();
            var year = ''
            if ($('#hdn_user_id').val() != '') {
                user_id = $('#hdn_user_id').val();
            }
            if ($('#hdn_year').val() != '') {
                year = $('#hdn_year').val();
            }

            if ($("#txt_joining_date").val() == '')
            {
              //  alert("Please Enter Date of Joining CEPT");

                Swal.fire({
                    text: "Please Enter Date of Joining CEPT !",
                    icon: "info",
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn btn-primary"
                    }
                });
                return false;
            }
            if (action == "A") {
                var status = validation();
                if (!status) {
                    action = "S";
                    return false;
                }
            }

            var res_publication = [];
            $('#tbl_rese_publish tbody tr').each(function (i) {
                if (i > 0) {

                    var research_publication = {
                        'instructor_code': '', 'sr_no': '', 'TypeCode': '', 'title_of_research': '', 'Type': '', 'name_of_journal': '', 'conference_type': '', 'impact_factor_of_journal ': '',
                        'co_author ': '', 'publication_month': '', 'publication_year': '', 'submitted_to_university': '', 'total_hours': ''
                    };
                    research_publication.instructor_code = user_id
                    research_publication.sr_no = i;
                    research_publication.TypeCode = replace_special_char(this.children[0].children[0].value);
                    research_publication.title_of_research = replace_special_char(this.children[1].children[0].value);
                    research_publication.Type = replace_special_char(this.children[2].children[0].value);
                    research_publication.name_of_journal = replace_special_char(this.children[3].children[0].value);
                    research_publication.conference_type = replace_special_char(this.children[4].children[0].value);
                    research_publication.impact_factor_of_journal = replace_special_char(this.children[5].children[0].value);
                    research_publication.co_author = replace_special_char(this.children[6].children[0].value);
                    research_publication.publication_month = replace_special_char(this.children[7].children[0].value);
                    research_publication.publication_year = replace_special_char(this.children[8].children[0].value);
                    research_publication.submitted_to_university = replace_special_char(this.children[9].children[0].value);
                    research_publication.total_hours = $('#txt_res_publish_year').val();

                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != "" || this.children[3].children[0].value != ""
                        || this.children[4].children[0].value != "" || this.children[5].children[0].value != "" || this.children[6].children[0].value != "" || this.children[7].children[0].value != "" || this.children[8].children[0].value != "" || this.children[9].children[0].value) {

                        res_publication.push(research_publication);
                    }



                }
            });


            var res_Confrencedtl_data = [];
            $('#tbl_conferences_publish tbody tr').each(function (i) {
                if (i > 0) {
                    var res_Confrencedtl = {
                        'instructor_code': '',        // Instructor code
                        'sr_no': '',                  // Serial number
                        'Title': '',                  // Title of the research
                        'Type': '',                   // Type of research
                        'NameOfConference': '',       // Name of the conference or journal
                        'conferencetype': '',         // Conference type
                        'Authorship': '',             // Authorship (Sole Author or Co-author)
                        'StartDate': '',              // Start date of the research
                        'EndDate': '',                // End date of the research
                        'submittedToUniversity': '',  // Whether submitted to the university
                        'total_hours': ''             // Total hours spent on research
                        
                    };

                    res_Confrencedtl.instructor_code = user_id
                    res_Confrencedtl.sr_no = i;
                    res_Confrencedtl.Title = replace_special_char(this.children[0].children[0].value);
                    res_Confrencedtl.Type = replace_special_char(this.children[1].children[0].value);
                    res_Confrencedtl.NameOfConference = replace_special_char(this.children[2].children[0].value);
                    res_Confrencedtl.conferencetype = replace_special_char(this.children[3].children[0].value);
                    res_Confrencedtl.Authorship = replace_special_char(this.children[4].children[0].value);
                    res_Confrencedtl.StartDate = replace_special_char(this.children[5].children[0].value);
                    res_Confrencedtl.EndDate = replace_special_char(this.children[6].children[0].value);
                    res_Confrencedtl.submittedToUniversity = replace_special_char(this.children[7].children[0].value);
                    res_Confrencedtl.total_hours = $('#txt_res_conferences_year').val();

                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != "" || this.children[3].children[0].value != ""
                        || this.children[4].children[0].value != "" || this.children[5].children[0].value != "" || this.children[6].children[0].value != "" || this.children[7].children[0].value != "" ) {

                        res_Confrencedtl_data.push(res_Confrencedtl);
                    }
                }
            });
            var res_Ongoing = [];
            $('#tbl_comp_ongoing_publish tbody tr').each(function (i) {
                if (i > 0) {

                    var research_ongoing = {
                        'instructor_code': '', 'sr_no': '', 'title': '', 'TypeCode': '', 'Description': '', 'funding_agency': '', 'fund_available': '', 'duration': '', 'status': '', 'total_hours': '', 'StartDate': '','EndDate':''
                    };
                    research_ongoing.instructor_code = user_id
                    research_ongoing.sr_no = i;
                    research_ongoing.title = replace_special_char(this.children[0].children[0].value);
                    research_ongoing.TypeCode = replace_special_char(this.children[1].children[0].value);
                    research_ongoing.Description = replace_special_char(this.children[2].children[0].value);
                    research_ongoing.funding_agency = replace_special_char(this.children[3].children[0].value);
                    research_ongoing.fund_available = replace_special_char(this.children[4].children[0].value);
                    research_ongoing.duration = replace_special_char(this.children[5].children[0].value);
                    research_ongoing.status = replace_special_char(this.children[6].children[0].value);
                    research_ongoing.StartDate = this.children[7].children[0].value;
                    research_ongoing.EndDate = this.children[8].children[0].value;



                    research_ongoing.total_hours = $('#txt_res_com_ongoing').val();
                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != "" || this.children[3].children[0].value != ""
                        || this.children[4].children[0].value != "" || this.children[5].children[0].value != "" || this.children[6].children[0].value != "" || this.children[7].children[0].value != "" || this.children[8].children[0].value != "") {
                        res_Ongoing.push(research_ongoing);
                    }



                }
            });

            var res_other_activity = [];

            $('#tbl_other_activity tbody tr').each(function (i) {
                if (i > 0) {
                    var other_research_activity = {
                        'instructor_code': '', 'sr_no': '', 'other_research_activities': '', 'total_hours': '', 'Date': '', 'Type': '', 'Title': ''
                    };
                    other_research_activity.instructor_code = user_id;
                    other_research_activity.sr_no = i;
                    other_research_activity.Title = replace_special_char(this.children[0].children[0].value);
                    other_research_activity.Type = replace_special_char(this.children[1].children[0].value);
                    other_research_activity.other_research_activities = replace_special_char(this.children[2].children[0].value);
                    other_research_activity.Date = replace_special_char(this.children[3].children[0].value);
                    other_research_activity.total_hours = $('#txt_other_activity').val();
                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != "" || this.children[3].children[0].value != "" || $('#txt_other_activity').val() != '') {
                        res_other_activity.push(other_research_activity);
                    }
                }
            });

            var res_various_activity = [];
            $('#tbl_various_activity_publish tbody tr').each(function (i) {
                if (i > 0) {
                    var various_activities = {
                        'instructor_code': '', 'sr_no': '', 'list_the_various_activities': '', 'role_in_the_activity': '', 'status': '', 'total_hours': ''
                        , 'Type': '', 'Organisation': '', 'StartDate': '', 'EndDate': ''
                    };
                    various_activities.instructor_code = user_id;
                    various_activities.sr_no = i;
                    various_activities.Type = replace_special_char(this.children[0].children[0].value);
                    various_activities.list_the_various_activities = replace_special_char(this.children[1].children[0].value);

                    var cetid = this.children[2].children[0].children[0].id;
                    var otherid = this.children[2].children[0].children[1].id;
                    var othertext = this.children[2].children[0].children[2].id;

                    if ($('#' + cetid).prop("checked"))
                    {
                        various_activities.Organisation = replace_special_char("CEPT");
                    }
                    else if ($('#' + otherid).prop("checked"))
                    {
                        various_activities.Organisation = replace_special_char($('#' + othertext).val());
                    }

                   

                    various_activities.role_in_the_activity = replace_special_char(this.children[3].children[0].value);
                    various_activities.status = replace_special_char(this.children[4].children[0].value);

                    various_activities.StartDate = replace_special_char(this.children[5].children[0].value);
                    various_activities.EndDate = replace_special_char(this.children[6].children[0].value);


                    various_activities.total_hours = $('#txt_various_activity').val();

                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != ""
                        || this.children[3].children[0].value != "" || this.children[4].children[0].value != "" || this.children[5].children[0].value != ""
                        || this.children[6].children[0].value != "") {
                        res_various_activity.push(various_activities);
                    }




                }
            });

            var res_professional_dev_activity = [];
            $('#tbl_professional_activity_publish tbody tr').each(function (i) {
                if (i > 0) {


                    var professional_development_training = {
                        'instructor_code': '', 'sr_no': '', 'list_professional_development_training': '', 'description': '', 'duration': '', 'organizers': '', 'number_of_participants': '', 'total_hours': '', 'Title': '', 'StartDate': '', 'EndDate': ''
                    };
                    professional_development_training.instructor_code = user_id;
                    professional_development_training.sr_no = i;
                    professional_development_training.list_professional_development_training = replace_special_char(this.children[0].children[0].value);
                    professional_development_training.Title = replace_special_char(this.children[1].children[0].value);
                    professional_development_training.description = replace_special_char(this.children[2].children[0].value);
                    professional_development_training.duration = replace_special_char(this.children[3].children[0].value);

                    professional_development_training.StartDate = replace_special_char(this.children[4].children[0].value);
                    professional_development_training.EndDate = replace_special_char(this.children[5].children[0].value);


                    professional_development_training.organizers = replace_special_char(this.children[6].children[0].value);
                    professional_development_training.number_of_participants = replace_special_char(this.children[7].children[0].value);
                    professional_development_training.total_hours = $('#txt_profess_activity').val();

                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != "" || this.children[3].children[0].value != ""
                        || this.children[4].children[0].value != "" || this.children[5].children[0].value != "" || this.children[6].children[0].value != "" || this.children[7].children[0].value != "")  {
                        res_professional_dev_activity.push(professional_development_training);
                    }




                }
            });

            var res_administrative_activity = [];
            $('#tbl_Institutional_activity_publish tbody tr').each(function (i) {
                if (i > 0) {


                    var administrative_work = {
                        'instructor_code': '', 'sr_no': '', 'administrative_work': '', 'status': '', 'total_hours': '', 'Title': '', 'Type': '', 'StartDate': '', 'EndDate': '', 'Duration': ''
                    };
                    administrative_work.instructor_code = user_id
                    administrative_work.sr_no = i;
                    administrative_work.Title = replace_special_char(this.children[0].children[0].value);
                    administrative_work.Type = replace_special_char(this.children[1].children[0].value);


                    administrative_work.administrative_work = replace_special_char(this.children[2].children[0].value);
                    administrative_work.status = replace_special_char(this.children[3].children[0].value);


                    administrative_work.StartDate = replace_special_char(this.children[4].children[0].value);
                    administrative_work.EndDate = replace_special_char(this.children[5].children[0].value);
                    administrative_work.Duration = replace_special_char(this.children[6].children[0].value);

                    administrative_work.total_hours = $('#txt_Institutional_activity').val();

                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != ""
                        || this.children[3].children[0].value != "" || this.children[4].children[0].value != "" || this.children[5].children[0].value != "") {

                        res_administrative_activity.push(administrative_work);
                    }

                }
            });

            var res_trainings_programs_activity = [];
            $('#tbl_skill_activity_publish tbody tr').each(function (i) {
                if (i > 0) {


                    var trainings_programs_attended = {
                        'instructor_code': '', 'sr_no': '', 'trainings_programs_attended': '', 'total_hours': '', 'Title': '', 'Type': '', 'Date': '', 'Organizer': '', 'ModeofTraining': ''
                    };
                    trainings_programs_attended.instructor_code = user_id
                    trainings_programs_attended.sr_no = i;
                    trainings_programs_attended.Title = replace_special_char(this.children[0].children[0].value);
                    trainings_programs_attended.Type = replace_special_char(this.children[1].children[0].value);

                    trainings_programs_attended.trainings_programs_attended = replace_special_char(this.children[2].children[0].value);
                    trainings_programs_attended.Date = replace_special_char(this.children[3].children[0].value);
                    trainings_programs_attended.Organizer = replace_special_char(this.children[4].children[0].value);
                    trainings_programs_attended.ModeofTraining = replace_special_char(this.children[5].children[0].value);


                    trainings_programs_attended.total_hours = $('#txt_trainings_activity').val();
                    if (this.children[0].children[0].value != "" || this.children[1].children[0].value != "" || this.children[2].children[0].value != "" || this.children[3].children[0].value != ""  ) {
                        res_trainings_programs_activity.push(trainings_programs_attended);
                    }


                }
            });

            var res_mention_facilitating_activity = [];
            $('#tbl_facilitating_activity_publish tbody tr').each(function (i) {
                if (i > 0) {


                    var mention_facilitating = {
                        'instructor_code': '', 'sr_no': '', 'mention_facilitating': ''
                    };
                    mention_facilitating.instructor_code = user_id
                    mention_facilitating.sr_no = i;
                    mention_facilitating.mention_facilitating = replace_special_char(this.children[0].children[0].value);
                    if (this.children[0].children[0].value != "") {
                        res_mention_facilitating_activity.push(mention_facilitating);
                    }


                }
            });

            var res_mention_inhibiting_activity = [];
            $('#tbl_Inhibiting_activity_publish tbody tr').each(function (i) {
                if (i > 0) {
                    var mention_inhibiting = {
                        'instructor_code': '', 'sr_no': '', 'mention_inhibiting': ''
                    };
                    mention_inhibiting.instructor_code = user_id
                    mention_inhibiting.sr_no = i;
                    mention_inhibiting.mention_inhibiting = replace_special_char(this.children[0].children[0].value);
                    if (this.children[0].children[0].value != "") {
                        res_mention_inhibiting_activity.push(mention_inhibiting);
                    }


                }
            });


            var res_List_trainings_activity = [];
            $('#tbl_training_activity_publish tbody tr').each(function (i) {
                if (i > 0) {
                    var List_trainings = {
                        'instructor_code': '', 'sr_no': '', 'training_skill': ''
                    };
                    List_trainings.instructor_code = user_id
                    List_trainings.sr_no = i;
                    List_trainings.training_skill = replace_special_char(this.children[0].children[0].value);
                    if (this.children[0].children[0].value != "") {
                        res_List_trainings_activity.push(List_trainings);
                    }


                }
            });
            var question_rating_dtl = [];

            var question_comment_dtl = [];
            $('#tbl_self_evaluation_dtl tbody tr').each(function (i) {
                if (i > 0) {
                    var question_rating = {
                        'instructor_code': '', 'question_id': '', 'rating': ''
                    };
                    var question_comment = {
                        'instructor_code': '', 'question_type': '', 'question_comment': ''
                    };
                    if (this.children.length > 1) {

                        question_rating.instructor_code = user_id
                        question_rating.question_id = this.children[1].children[1].id;
                        question_rating.rating = $('input[name=' + this.children[1].children[1].id + ']:checked').val(); //this.children[1].children[0].value;
                        if ($('input[name=' + this.children[1].children[1].id + ']:checked').val() != undefined) {
                            question_rating_dtl.push(question_rating);
                        }
                        


                    }
                    else if (this.children[0].children[0].className != undefined && this.children[0].children[0].className != 'undefined' && this.children[0].children[0].className != '')
                    {

                        question_comment.instructor_code = user_id
                        question_comment.question_type = this.children[0].children[0].className;
                        question_comment.question_comment = this.children[0].children[0].value;
                        if (this.children[0].children[0].value != "") {
                            question_comment_dtl.push(question_comment);
                        }
                        
                    }



                }
            })




            var drp_activity = [];
            $('#tbl_drp_thesis_dtl tbody tr').each(function (i) {
                if (i > 0) {
                    var $td = $(this).find('td').eq(0); // Get the first <td>
                    var $inputs = $td.find('input');
                    var $textarea = $td.find('textarea');
                    var semesterandyear = '';
                    var coursename = '';
                    if ($inputs.length > 0) {
                         semesterandyear = $(this).find('td').eq(0).find('input').val();
                         coursename = $(this).find('td').eq(1).find('textarea').val();
                    }
                    else
                    {
                        semesterandyear = $(this).find('td').eq(0).text();
                        coursename = $(this).find('td').eq(1).text();
                    }
                    

                    var drp_list = {
                        'instructor_code': '', 'sr_no': '', 'semesterandyear': '', 'coursename': '', 'total_hours': ''
                    };
                    drp_list.instructor_code = user_id
                    drp_list.sr_no = i;
                 
                    drp_list.semesterandyear = replace_special_char(semesterandyear);
                    drp_list.coursename = replace_special_char(coursename);
                   
                    
                    
                    if (semesterandyear != "" || coursename != "") {
                        drp_activity.push(drp_list);
                    }


                }
            });



            var FileUpload_activity = [];
            $('#tbl_self_evaluation_upload_doc_dtl tbody tr').each(function (i) {
               // if (i) {
                    var $td = $(this).find('td').eq(0); // Get the first <td>
                    var $inputs = $td.find('input');
                    var $textarea = $td.find('textarea');
                    var semesterandyear = '';
                    var coursename = '';
                    semesterandyear = $(this).find('td').eq(0).text();
                    coursename = $(this).find('td').eq(1).text();
                    var file_list = {
                        'instructor_code': '', 'sr_no': '', 'filename': '','count':''
                    };
                    file_list.instructor_code = user_id
                    file_list.sr_no = i;

                    file_list.count = semesterandyear;
                    file_list.filename = coursename;
                    if (semesterandyear != "" || coursename != "") {
                        FileUpload_activity.push(file_list);
                    }


                //}
            });




            var faculty_application_dtl = [];
            var application_dtl = {
                'instructor_code': '', 'dean_comment': '', 'over_all_comment_by_dean': '', 'comment_by_review_committee': '', 'status': '', 'dept_name': '', 'designation': '', 'total_year_experience': ''
                , 'teaching_year': '', 'previous_year_experience': '', 'date_of_join_cept': '', 'drp_thesis_hours': '', 'confirmation_date': '', 'total_experiance_months': '', 'total_hrs_teaching': ''
            };

            application_dtl.instructor_code = user_id;
            application_dtl.dean_comment = $('#deancomments').val();
            application_dtl.over_all_comment_by_dean = $('#deanallcomments').val();
            application_dtl.comment_by_review_committee = $('#reviewcomments').val();

            application_dtl.dept_name = $('#txt_faculty').text().trim();
            application_dtl.designation = $('#txt_designation').text().trim();
            application_dtl.total_year_experience = $('#txt_year_experience').val();
            application_dtl.teaching_year = $('#txt_year_teaching').val();
            application_dtl.previous_year_experience = $('#txt_teaching_experience').val();
            application_dtl.drp_thesis_hours = $('#txt_drp_thesis').val();
            application_dtl.total_hrs_teaching = $('#txt_cours_hours').val();

            var str_join_date = $('#txt_joining_date').val().split('/');
            application_dtl.date_of_join_cept = str_join_date[1] + '/' + str_join_date[0] + '/' + str_join_date[2];
            application_dtl.confirmation_date = $('#txt_confirmation_date').val();
            application_dtl.total_experiance_months = $('#txt_total_experiance_months').val();


            application_dtl.status = action;
            faculty_application_dtl.push(application_dtl);
            var All_instructor_data = [res_publication, res_Ongoing, res_other_activity, res_various_activity, res_professional_dev_activity, res_administrative_activity,
                res_trainings_programs_activity, res_mention_facilitating_activity, res_mention_inhibiting_activity, res_List_trainings_activity, question_rating_dtl, question_comment_dtl, faculty_application_dtl, res_Confrencedtl_data, drp_activity, FileUpload_activity];
            var json_All_instructor_data = JSON.stringify(All_instructor_data);

            if (json_All_instructor_data.search("'") != -1) {
                json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/insert_self_evaluation_dtl",
                async: false,
                data: "{ All_table_course_data: '" + json_All_instructor_data + "',inst_code: '" + user_id + "',year: '" + year + "' }",
                dataType: "json",
                success: function (data) {
                    if (data.d == true) {
                        if (action == 'A') {
                            //bootbox.alert('Self Evaluation Details Submitted Successfully', function () {
                            //    location.reload();
                            //});


                            Swal.fire({
                                text: "Self Evaluation Details Submitted Successfully !",
                                icon: "success",
                                buttonsStyling: false,
                                confirmButtonText: "Ok, got it!",
                                customClass: {
                                    confirmButton: "btn btn-primary"
                                }
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    location.reload();
                                }
                            });
                        }
                        else {
                           // bootbox.alert('Self Evaluation Details Saved Successfully', function () {
                           //     location.reload();
                           // });

                            Swal.fire({
                                text: "Self Evaluation Details Saved Successfully !",
                                icon: "success",
                                buttonsStyling: false,
                                confirmButtonText: "Ok, got it!",
                                customClass: {
                                    confirmButton: "btn btn-primary"
                                }
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    location.reload();
                                }
                            });

                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        });

    }
    else { get_details(); }

    $('#tbl_various_activity_publish').on('change', 'input[type=radio][name^=source_]', function () {
        var $row = $(this).closest('tr');
        if (this.value == 'other') {
            $row.find('.other_input').show();
        } else {
            $row.find('.other_input').hide();
        }
    });



   

});
function get_details()
{
    
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
            // Step 4 
            if (data.d[18] != "" && data.d[18] != null) {
                var get_apprisal_type_all_dtl = JSON.parse(data.d[18]);
                var get_apprisal_type_dtl = JSON.parse(data.d[18]);
                get_apprisal_type_dtl = $.grep(get_apprisal_type_dtl, function (element, index)
                {
                    return element.GroupTypeName === 'Publication';
                });
                for (var i = 0; i < get_apprisal_type_dtl.length; i++) {
                    if (i == 0) {
                        type_publication += "<option value=''> Please Select Publication Type </option>";
                    }
                    type_publication += "<option value=" + get_apprisal_type_dtl[i].TypeCode + "> " + get_apprisal_type_dtl[i].TypeName + "</option>";
                }
                $('#res_type_0').append(type_publication);

                var GetResearchProject = $.grep(get_apprisal_type_all_dtl, function (element, index) {
                    return element.GroupTypeName === 'ResearchProject';
                });
                //var GetResearchProjectType = '';
                for (var i = 0; i < GetResearchProject.length; i++) {
                    if (i == 0) {
                        GetResearchProjectType += "<option value=''> Please Select Type </option>";
                    }
                    GetResearchProjectType += "<option value=" + GetResearchProject[i].TypeCode + "> " + GetResearchProject[i].TypeName + "</option>";
                }
                $('#comp_ongoing_type_0').append(GetResearchProjectType);

                var OtherResearchActivities = $.grep(get_apprisal_type_all_dtl, function (element, index) {
                    return element.GroupTypeName === 'OtherResearchActivities';
                });

                for (var i = 0; i < OtherResearchActivities.length; i++) {
                    if (i == 0) {
                        OtherActivityType += "<option value=''> Please Select Type </option>";
                    }
                    OtherActivityType += "<option value=" + OtherResearchActivities[i].TypeCode + "> " + OtherResearchActivities[i].TypeName + "</option>";
                }
                $('#other_activity_type_0').append(OtherActivityType);


                var VariousActivitiesType = $.grep(get_apprisal_type_all_dtl, function (element, index) {
                    return element.GroupTypeName === 'VariousActivities';
                });

                for (var i = 0; i < VariousActivitiesType.length; i++) {
                    if (i == 0) {
                        VariousActivities += "<option value=''> Please Select Type </option>";
                    }
                    VariousActivities += "<option value=" + VariousActivitiesType[i].TypeCode + "> " + VariousActivitiesType[i].TypeName + "</option>";
                }
                $('#comp_various_type_0').append(VariousActivities);


            }
             
            if (data.d[0] != "" && data.d[0] != null)
            {
                var research_publish = JSON.parse(data.d[0]);
                for (var i = 0; i < research_publish.length; i++)
                {
                    if (i == 0) {
                       // $('#res_type_0').append(type_publication);
                        $('#restype').val(research_publish[i]['Type']);
                        $('#res_type_0').val(research_publish[i]['TypeCode']);
                        $('#res_name_0').val(research_publish[i]['title_of_research']);
                        $('#res_journal_0').val(research_publish[i]['name_of_journal']);
                        $('#res_national_0').val(research_publish[i]['conference_type']);
                        $('#res_factor_0').val(research_publish[i]['impact_factor_of_journal']);
                        $('#res_sole_author_0').val(research_publish[i]['co_author']);
                        $('#res_month_0').val(research_publish[i]['publication_month']);
                        $('#res_year_0').val(research_publish[i]['publication_year']);
                        $('#res_submitted_0').val(research_publish[i]['submitted_to_university']);
                        $('#txt_res_publish_year').val(research_publish[i]['total_hours']);
                    }
                    else
                    {
                        month_text = '<option value=""> Please Select Month </option><option value="1"> January </option><option value = "2">February </option>';
                        month_text += '<option value="3"> March </option>';
                        month_text += '<option value="4"> April </option>';
                        month_text += '<option value="5"> May </option>';
                        month_text += '<option value="6"> June </option>';
                        month_text += '<option value="7"> July </option>';
                        month_text += '<option value="8"> August </option>';
                        month_text += '<option value="9"> September </option>';
                        month_text += '<option value="10"> October </option>';
                        month_text += '<option value="11"> November </option>';
                        month_text += '<option value="12"> December </option>';

                        var str_row = "<tr><td><select style='width:100px;' name ='res_type' class='marg-btm restypedtl' id='res_type_" + i + "'>" + type_publication + "</select ></td>"
                            /*+ "<td><input type='text' id='res_name_" + i + 1 + "' class='marg-btm' value='" + research_publish[i]['title_of_research'] + "' style='width: 300px;'/></td>"*/
                            + "<td><textarea id='res_name_" + i + "' class='marg-btm res_name' name='res_name' rows='1' cols='60' style='width:300px;'></textarea></td>"
                            + "<td style = 'display:none;'><select style = 'width:100px; display:none;' name = 'restype' class='marg-btm' id ='restype" + i+ "'><option value=''>Select</option><option value='Journal'>Journal</option><option value = 'Conference'>Conference</option></select></td>"
                        + "<td><input type='text' class='marg-btm' style='width: 90px;' value='" + research_publish[i]['name_of_journal'] + "' /></td>"
                            
                        + "<td> <select style='width: 100%; ' name='res_national' class='marg-btm' id='res_national_" + i + "'><option value = ''> Please Select Type </option ><option value='National'> National </option><option value = 'International'>International</option><option value='Conference'>Conference</option></select></td>"
                        + "<td><input type='text' class='marg-btm' style='width: 50px;' value='" + research_publish[i]['impact_factor_of_journal'] + "' /></td>"
                        /*+ "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + research_publish[i]['co_author'] + "' /></td>"*/
                        + "<td> <select style='width:90%;' name ='res_sole_author' class='marg-btm' id='res_sole_author_" + i + "'><option value = ''> Please Select </option><option value='SoleAuthor'> Sole Author </option><option value='Coauthor'>Co-author</option></select></td>"
                        //+ "<td><input type='text' class='marg-btm' style='width: 50px;'  value='" + research_publish[i]['publication_month'] + "' /></td>"
                        //+ "<td><input type='text' class='marg-btm' style='width: 50px;'  value='" + research_publish[i]['publication_year'] + "' /></td>"
                        + "<td><select style='width:108%;' class='marg-btm' id='res_month_" + i + "'>" + month_text + "</select></td>"
                        + "<td><select style='width:108%;' name ='res_year' class='marg-btm year_dropdown' id='res_year_" + i + "'></select></td>"

                    /*+ "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + research_publish[i]['submitted_to_university'] + "' /></td>"*/
                        + "<td><select style='width:90px;' name=res_submitted class='marg-btm' id='res_submitted_" + i + "'><option value=''> Please Select</option><option value='Yes'> Yes</option><option value='No'>No</option></select></td>"
                        + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                        + "</tr> ";

                        $('#tbl_rese_publish').append(str_row);
                        $('#res_name_' + i).val(research_publish[i]['title_of_research']);
                        $('#res_type_' + i).val(research_publish[i]['TypeCode']);
                        $('#restype' + i).val(research_publish[i]['Type']);
                        $('#res_year_' + i).html(str_year_html);
                        $('#res_year_' + i).val(research_publish[i]['publication_year']);
                        $('#res_month_' + i).val(research_publish[i]['publication_month']);
                        $('#res_national_' + i).val(research_publish[i]['conference_type']);
                        $('#res_sole_author_' + i).val(research_publish[i]['co_author']);
                        $('#res_submitted_' + i).val(research_publish[i]['submitted_to_university']);
                    }
                }
            }
            if (data.d[1] != "" && data.d[1] != null) {
                var add_comp_ongoing = JSON.parse(data.d[1]);
                for (var i = 0; i < add_comp_ongoing.length; i++) {
                    //changes 28052024
                    if (i == 0)
                    {
                        $('#txt_ongoing_start_date').val(add_comp_ongoing[i]['StartDateChange']);
                        $('#txt_ongoing_end_date').val(add_comp_ongoing[i]['EndDateChange']);
                        $('#comp_ongoing_type_0').val(add_comp_ongoing[i]['TypeCode']);
                        $('#comp_ongoing_desc_0').val(add_comp_ongoing[i]['Description']);
                        $('#comp_ongoing_text_0').val(add_comp_ongoing[i]['title']);
                        $('#comp_ongoing_1').val(add_comp_ongoing[i]['funding_agency']);
                        $('#comp_ongoing_2').val(add_comp_ongoing[i]['fund_available']);
                        $('#comp_ongoing_3').val(add_comp_ongoing[i]['duration']);
                        $('.comp_ongoing_status').val(add_comp_ongoing[i]['status']);
                        $('#txt_res_com_ongoing').val(add_comp_ongoing[i]['total_hours']); 
                    }
                    else
                    {/*<td><input type='text' class='marg-btm' style='width: 300px;' value='" + add_comp_ongoing[i]['title'] + "'/></td>*/
                        var str_row = "<tr>"
                            + "<td><textarea id='comp_ongoing_text_" + i + "' class='marg-btm addcomongoingtitle' rows='1' cols='60' style='width: 300px;'></textarea></td>"
                            /*+ "<td><input type='text' class='marg-btm' style='width: 300px;' value='" + add_comp_ongoing[i]['title'] + "'/></td>"*/
                            + "<td><select style='width:100px;' name ='comp_ongoing_type' class='marg-btm' id='comp_ongoing_type_" + i + "'>" + GetResearchProjectType + "</select></td>"
                           /* + "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + add_comp_ongoing[i]['Description'] + "' /></td>"*/
                            + "<td><textarea id='comp_ongoing_desc_" + i + "' class='marg-btm addcomongoingdesc' rows='1' cols='60' style='width: 180px;'></textarea></td>"

                            + "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + add_comp_ongoing[i]['funding_agency'] + "' /></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 90px;' value='" + add_comp_ongoing[i]['fund_available'] + "' /></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 70px;' value='" + add_comp_ongoing[i]['duration'] + "' /></td>"
                            + "<td><select class='comp_ongoing_status' id='com_" + i +"' style='width: 180px;'><option value=''>Please Select Status </option><option value = 'completed'>completed</option><option value='ongoing'>ongoing</option></select></td>"
                            + "<td><input type='text' id='txt_ongoing_start_date_" + i + "' class='marg-btm' style='width: 80px;' placeholder='MM-YYYY' value='" + add_comp_ongoing[i]['StartDateChange'] + "'></td>"
                            + "<td><input type='text' id='txt_ongoing_end_date_" + i + "' class='marg-btm' style='width: 80px;' placeholder='MM-YYYY' value='" + add_comp_ongoing[i]['EndDateChange'] + "'></td>"
                            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                            + "</tr> ";
                        
                        $('#tbl_comp_ongoing_publish').append(str_row);
                        $('#com_' + i).val(add_comp_ongoing[i]['status']);
                        $('#comp_ongoing_type_' + i).val(add_comp_ongoing[i]['TypeCode']);
                        $('#comp_ongoing_text_' + i).text(add_comp_ongoing[i]['title']);
                        $('#comp_ongoing_desc_' + i).text(add_comp_ongoing[i]['Description']);


                        $('#txt_ongoing_end_date_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });

                        $('#txt_ongoing_start_date_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true
                        });
                    }
                }

            }

            if (data.d[2] != "" && data.d[2] != null) {
                var other_research_activities = JSON.parse(data.d[2]);
                for (var i = 0; i < other_research_activities.length; i++)
                {
                    if (i == 0) {
                        $('#other_activity_0').val(other_research_activities[i]['Title']);
                        $('#other_activity_type_0').val(other_research_activities[i]['Type']);
                        $('#other_activity_desc_0').val(other_research_activities[i]['other_research_activities']);
                        $('#other_activity_date_0').val(other_research_activities[i]['StartDate']);
                        $('#txt_other_activity').val(other_research_activities[0]['total_hours']);
                        
                    }
                    else
                    {
                        var str_row = "<tr>"
                           // + "<td><input type='text' class='marg-btm' id='other_activity_" + i + "' value='" + other_research_activities[i]['Title'] + "'/></td>"
                            + "<td><textarea id='other_activity_"+i+"' class='marg-btm addactivitytitle' rows='1' cols='60'></textarea></td>"
                            + "<td><select name='other_activity_type' class='marg-btm' id='other_activity_type_" + i + "'>" + OtherActivityType + "</select></td>"

                           // + "<td><input type='text' class='marg-btm' id='other_activity_desc_" + i + "' value='" + other_research_activities[i]['other_research_activities'] + "' /></td>"
                            + "<td><textarea id='other_activity_desc_"+i+"' class='marg-btm addactivitydesc' rows='1' cols='60'></textarea></td>"


                            + "<td><input type='text' class='marg-btm' id='other_activity_date_" + i + "' value='" + other_research_activities[i]['StartDate'] + "' placeholder='MM-YYYY' /></td>"
                            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
                            + "</tr>";
                        $('#tbl_other_activity').append(str_row);
                        $('#other_activity_type_' + i).val(other_research_activities[i]['Type']);
                        $('#txt_other_activity').val(other_research_activities[0]['total_hours']);

                        $('#other_activity_' + i).val(other_research_activities[i]['Title']);

                        $('#other_activity_desc_' + i).val(other_research_activities[i]['other_research_activities']);


                        $('#other_activity_date_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });
                    }
                }

                //$('#other_activity').val(other_research_activities[0]['other_research_activities']);
                //$('#txt_other_activity').val(other_research_activities[0]['total_hours']);

            }
            if (data.d[3] != "" && data.d[3] != null) {
                var Various_Activities = JSON.parse(data.d[3]);
                for (var i = 0; i < Various_Activities.length; i++) {

                    if (i == 0) {
                        $('#comp_various_0').val(Various_Activities[i]['list_the_various_activities']);
                        $('#comp_various_type_0').val(Various_Activities[i]['role_in_the_activity']);
                        $('#comp_status_0').val(Various_Activities[i]['status']);
                        $('#comp_various_Organisation_0').val(Various_Activities[i]['Organisation']);
                        $('#comp_various_title_0').val(Various_Activities[i]['Type']);
                        $('#comp_StartDate_0').val(Various_Activities[i]['StartDateChange']);
                        $('#comp_EndDate_0').val(Various_Activities[i]['EndDateChange']);
                        $('#txt_various_activity').val(Various_Activities[i]['total_hours']);

                        if (Various_Activities[i]['Organisation'] == 'CEPT') {
                            $('#CEPT_0').attr('checked', true);
                            $('#comp_various_Organisation_0').hide();
                            $('#comp_various_Organisation_0').val('');
                        }
                        else {
                            $('#Other_0').attr('checked', true);
                            $('#comp_various_Organisation_0').val(Various_Activities[i]['Organisation']);
                            $('#comp_various_Organisation_0').show();

                        }

                    }
                    else {
                        
                        //var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 385px;' value='" + Various_Activities[i]['list_the_various_activities'] + "'></td>"
                        //    + "<td><input type='text' class='marg-btm' style='width: 280px;'/ value='" + Various_Activities[i]['role_in_the_activity'] + "' ></td>"
                        //    + "<td><select class='comp_various_status' id='various_" + i + "' style='width: 180px;'><option value=''>Please Select Status </option><option value='completed'>Completed</option>"
                        //    + "<option value='InProcess'>In Process</option><option value='YettoStart'>Yet to Start</option></select ></td>"
                        //    + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                        //    + "</tr> ";

                      //  var str_row = "<tr>"
                      //      + "<td><select id='comp_various_title_" + i + "' style='width: 100px;'>"
                      //      + "<option value=''>Please Select</option>"
                      //      + "<option value='Review'>Review</option>"
                      //      + "<option value='Juries'>Juries</option></select></td>"
                      //      + "<td><input type='text' class='marg-btm' id='comp_various_" + i + "' style='width: 200px;' value='" + Various_Activities[i]['list_the_various_activities'] + "' /></td>"
                      //      + "<td><input type='text' class='marg-btm' id='comp_various_Organisation_" + i + "' style='width: 100px;' value='" + Various_Activities[i]['Organisation'] + "' /></td>"
                      //      + "<td><select class='comp_various_type' id='comp_various_type_" + i + "' style='width: 280px;'>" + VariousActivities + "</select></td>"
                      //      + "<td><select class='comp_various_status' id='comp_status_" + i + "' style='width: 180px;'>"
                      //      + "<option value=''>Please Select Status</option>"
                      //      + "<option value='completed'>Completed</option>"
                      //      + "<option value='InProcess'>In Process</option>"
                      //      + "<option value='YettoStart'>Yet to Start</option></select></td>"
                      //      + "<td><input type='text' class='marg-btm' id='comp_StartDate_" + i + "' style='width: 100px;' placeholder='MM-YYYY' value='" + Various_Activities[i]['StartDateChange'] + "' /></td>"
                      //      + "<td><input type='text' class='marg-btm' id='comp_EndDate_" + i + "' style='width: 100px;' placeholder='MM-YYYY' value='" + Various_Activities[i]['EndDateChange'] + "' /></td>"
                      //      + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
                      //      + "</tr>";




                        var str_row = "<tr>"
                            + "<td><select id='comp_various_title_" + i + "' style='width: 100px;'>"
                            + "<option value=''>Please Select</option>"
                            + "<option value='Review'>Review</option>"
                            + "<option value='Juries'>Juries</option><option value='NotApplicable'>Not Applicable</option></select></td>"
                            //+ "<td><input type='text' class='marg-btm' id='comp_various_" + i + "' style='width: 200px;' value='" + Various_Activities[i]['list_the_various_activities'] + "' /></td>"




                            + "<td><textarea id='comp_various_" + i +"' class='marg-btm' rows='1' cols='60'></textarea></td>"



                            // + "<td><input type='text' class='marg-btm' id='comp_various_Organisation_" + i + "' style='width: 100px;' value='" + Various_Activities[i]['Organisation'] + "' /></td>"
                            + "<td><div class='radio-group'>"
                            + "<input type='radio' id='CEPT_"+i+"' name='source_" + i + "' class='source_radio' value='cept' checked> CEPT"
                            + "<input type='radio' id='Other_" + i +"' name='source_" + i + "' class='source_radio' value='other'> Other"
                            + "<input type='text' class='marg-btm other_input' id='comp_various_Organisation_" + i + "' style='width: 100px; display: none;' placeholder='Other Organisation' />"
                            + "</div></td>"
                            + "<td><select class='comp_various_type' id='comp_various_type_" + i + "' style='width: 100px;'>" + VariousActivities + "</select></td>"
                            + "<td><select class='comp_various_status' id='comp_status_" + i + "' style='width: 180px;'>"
                            + "<option value=''>Please Select Status</option>"
                            + "<option value='completed'>Completed</option>"
                            + "<option value='InProcess'>In Process</option>"
                            + "<option value='YettoStart'>Yet to Start</option></select></td>"
                            + "<td><input type='text' class='marg-btm' id='comp_StartDate_" + i + "' style='width: 100px;' placeholder='MM-YYYY' value='" + Various_Activities[i]['StartDateChange'] + "' /></td>"
                            + "<td><input type='text' class='marg-btm' id='comp_EndDate_" + i + "' style='width: 100px;' placeholder='MM-YYYY' value='" + Various_Activities[i]['EndDateChange'] + "' /></td>"
                            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
                            + "</tr>";







                        $('#tbl_various_activity_publish').append(str_row);


                        $('#comp_status_' + i).val(Various_Activities[i]['status']);
                        $('#comp_various_title_' + i).val(Various_Activities[i]['Type']);
                        $('#comp_various_type_' + i).val(Various_Activities[i]['role_in_the_activity']);
                        $('#comp_various_' + i).val(Various_Activities[i]['list_the_various_activities']);

                        if (Various_Activities[i]['Organisation'] == 'CEPT') {
                            $('#CEPT_' + i).attr('checked', true);
                            $('#comp_various_Organisation_' + i).hide();
                            $('#comp_various_Organisation_' + i).val('');
                        }
                        else
                        {
                            $('#Other_' + i).attr('checked', true);
                            $('#comp_various_Organisation_' + i).val(Various_Activities[i]['Organisation']);
                            $('#comp_various_Organisation_' + i).show();

                        }

                        $('#comp_StartDate_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true
                        });

                        $('#comp_EndDate_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });
                    }
                }

            }

            if (data.d[4] != "" && data.d[4] != null) {
                var comp_profess = JSON.parse(data.d[4]);
                for (var i = 0; i < comp_profess.length; i++) {

                    if (i == 0) {
                        $('#prof_title_0').val(comp_profess[i]['Title']);
                        $('#prof_desc_0').val(comp_profess[i]['description']);
                        $('#prof_1').val(comp_profess[i]['duration']);

                        $('#prof_Start_Date_0').val(comp_profess[i]['StartDateChange']);
                        $('#prof_End_Date_0').val(comp_profess[i]['EndDateChange']);


                        $('#prof_2').val(comp_profess[i]['organizers']);
                        $('#prof_3').val(comp_profess[i]['number_of_participants']);
                        $('.comp_profess_status').val(comp_profess[i]['list_professional_development_training']);
                        $('#txt_profess_activity').val(comp_profess[i]['total_hours']);
                    }
                    else {

                        var str_row = "<tr><td><select class='comp_profess_status' id='profess_" + i + "' style='width: 180px;'><option value=''>Please Select </option>"
                            + "<option value = 'Seminar'> Seminar</option >"
                            + "<option value='Workshop'>Workshop</option><option value='LectureOffered'>Lecture, Offered</option>"
                            + "<option value='Organised'>Organised </option><option value='Facultymeeting'>Faculty Meeting</option><option value='NotApplicable'>Not Applicable</option></select></td>"


                            /*+ "<td><input type='text' class='marg-btm' style='width: 300px;' value='" + comp_profess[i]['Title'] + "' /></td>"*/
                            + "<td><textarea id='prof_title_"+i+"' class='marg-btm' rows='1' cols='60' style='width: 300px;'></textarea></td>"


                            /*+ "<td><input type='text' class='marg-btm' style='width: 300px;' value='" + comp_profess[i]['description'] + "' /></td>"*/
                            + "<td><textarea id='prof_desc_" + i + "' class='marg-btm' rows='1' cols='60' style='width: 300px;'></textarea></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + comp_profess[i]['duration']+"' ></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 120px;' id='prof_Start_Date_" + i +"' value='" + comp_profess[i]['StartDateChange']+"' ></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 120px;' id='prof_End_Date_"+i+"' value='" + comp_profess[i]['EndDateChange']+"' ></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + comp_profess[i]['organizers']+"' ></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 60px;' value='" + comp_profess[i]['number_of_participants'] +"' /></td>"
                            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                            + "</tr> ";

                        $('#tbl_professional_activity_publish').append(str_row);
                        $('#profess_' + i).val(comp_profess[i]['list_professional_development_training']);

                        $('#prof_title_' + i).val(comp_profess[i]['Title']);

                        $('#prof_desc_' + i).val(comp_profess[i]['description']);

                        $('#prof_End_Date_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });

                        $('#prof_Start_Date_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });

                    }
                }

            }
            if (data.d[5] != "" && data.d[5] != null)
            {
                var Administrative_Work = JSON.parse(data.d[5]);
                for (var i = 0; i < Administrative_Work.length; i++)
                {
                   
                    if (i == 0) {
                            $('#publish_title_0').val(Administrative_Work[i]['Title']);
                        $('#publish_type_0').val(Administrative_Work[i]['Type']);
                        $('#admins_0').val(Administrative_Work[i]['administrative_work']);
                        $('.comp_administrative_status').val(Administrative_Work[i]['status']);
                        $('#publish_StartDate_0').val(Administrative_Work[i]['StartDateChange']);
                        $('#publish_EndDate_0').val(Administrative_Work[i]['EndDateChange']);
                        $('#publish_duration_0').val(Administrative_Work[i]['Duration']);

                            $('#txt_Institutional_activity').val(Administrative_Work[i]['total_hours']);
                        }
                        else {

                            

                            //var str_row = '<tr><td><textarea id="admins_' + i + '" class="marg-btm" name="Administrative_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
                            //    + "<td><select class='comp_administrative_status' id='admint_"+i+"' style='width: 120px;'><option value=''>Please Select Status </option><option value='completed'>Completed</option>"
                            //    + "<option value='InProcess'>In Process</option><option value='YettoStart'>Yet to Start</option></select ></td>"
                            //    + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                            //    + "</tr> ";

                        var str_row = "<tr>"
                                + "<td><textarea id='publish_title_" + i + "' class='marg-btm' rows='1' cols='60' style='width: 100px;'></textarea></td>"
                                //+ "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_title_" + i + "' value='" + Administrative_Work[i]['Title'] +"' /></td>"
                                + "<td><select class='publish_type' id='publish_type_" + i +"' style='width: 180px;'>"
                                + "<option value=''>Please Select</option>"
                                + "<option value='Workassigned'>Work assigned</option>"
                            + "<option value='Undertaken'>Undertaken</option><option value='NotApplicable'>Not Applicable</option></select></td>"
                                + "<td><textarea id='admins_" + i +"' class='marg-btm' name='Administrative_text' rows='1' cols='60' style='width:100%;'></textarea></td>"
                                + "<td><select class='comp_administrative_status' id='admint_" + i +"'  style='width: 120px;'>"
                                + "<option value=''>Please Select Status</option>"
                                + "<option value='completed'>Completed</option>"
                                + "<option value='InProcess'>In Process</option>"
                                + "<option value='YettoStart'>Yet to Start</option></select></td>"
                                + "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_StartDate_" + i + "' value='" + Administrative_Work[i]['StartDateChange'] +"' placeholder='MM-YYYY' /></td>"
                                + "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_EndDate_" + i + "' value='" + Administrative_Work[i]['EndDateChange'] +"' placeholder='MM-YYYY' /></td>"
                                + "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_duration_" + i + "' value='" + Administrative_Work[i]['Duration'] +"' /></td>"
                                + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
                                + "</tr>";




                            $('#tbl_Institutional_activity_publish').append(str_row);

                            $('#admins_' + i).val(Administrative_Work[i]['administrative_work']);
                            $('#publish_title_' + i).val(Administrative_Work[i]['Title']);
                            $('#publish_type_' + i).val(Administrative_Work[i]['Type']);
                            $('#admint_' + i).val(Administrative_Work[i]['status']);

                        $('#publish_EndDate_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });

                        $('#publish_StartDate_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });
                        }

                    
                }
            }


            if (data.d[6] != "" && data.d[6] != null) {
                var Trainings_Programs = JSON.parse(data.d[6]);
                var str_row = '';
                for (var i = 0; i < Trainings_Programs.length; i++) {

                    if (i == 0) {
                        $('#skill_org_0').val(Trainings_Programs[i]['Organizer']);
                        $('#skill_org_type_0').val(Trainings_Programs[i]['ModeofTraining']);
                        $('#skills_title_0').val(Trainings_Programs[i]['Title']);
                        $('#skill_type_0').val(Trainings_Programs[i]['Type']);
                        $('#skill_0').val(Trainings_Programs[i]['trainings_programs_attended']);
                        $('#skill_Date_0').val(Trainings_Programs[i]['StartDateChange']);
                        $('#txt_trainings_activity').val(Trainings_Programs[i]['total_hours']);
                    }
                    else
                    {

                         //str_row += "<tr><td><input type='text' class='marg-btm' style='width: 95%;' value='" + Trainings_Programs[i]['trainings_programs_attended']+"' /></td>"
                        //str_row = '<tr><td><textarea id="skill_' + i + '" class="marg-btm" name="skill_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
                        //    + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                        //    + "</tr> ";

                        var str_row = "<tr>"
                            /*+ "<td><input type='text' class='marg-btm' style='width: 100px;' id='skills_title_" + i + "' /></td>"*/
                            + "<td><textarea id='skills_title_" + i + "' class='marg-btm' rows='1' cols='60' style='width: 100px;'></textarea></td>"
                            + "<td><select class='skill_type' id='skill_type_"+i+"' style='width: 180px;'>"
                            + "<option value=''>Please Select</option>"
                            + "<option value='Lecture'>Lecture</option>"
                            + "<option value='Conference'>Conference</option>"
                            + "<option value='Workshop'>Workshop</option>"
                            + "<option value='Seminar'>Seminar</option></select></td>"
                            + "<td><textarea id='skill_" + i +"' class='marg-btm' name='skill_text' rows='1' cols='60' style='width:100%;'></textarea></td>"
                            + "<td><input type='text' class='marg-btm' style='width: 100px;' id='skill_Date_" + i + "' placeholder='MM-YYYY' value='" + Trainings_Programs[i]['StartDateChange'] + "' /></td>"

                            + "<td><textarea id='skill_org_" + i + "' class='marg-btm' name='skill_org_text' rows='1' cols='60' style='width:100%;'></textarea></td>"
                            + "<td><select class='skill_org_type' id='skill_org_type_" + i + "' style='width: 180px;'>"
                            + "<option value=''>Please Select</option>"
                            + "<option value='Online'>Online</option>"
                            + "<option value='OffLine'>Offline</option>"
                            + "</select></td>"
                            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
                            + "</tr>";

                        $('#tbl_skill_activity_publish').append(str_row);
                    }
                   
                    $('#skill_org_' + i).val(Trainings_Programs[i]['Organizer']);
                    $('#skill_org_type_' + i).val(Trainings_Programs[i]['ModeofTraining']);
                    $('#skills_title_' + i).val(Trainings_Programs[i]['Title']);
                    $('#skill_' + i).val(Trainings_Programs[i]['trainings_programs_attended']);
                    $('#skill_type_' + i).val(Trainings_Programs[i]['Type']);

                    $('#skill_Date_' + i).datepicker({
                        format: "mm-yyyy",
                        startView: "months",
                        minViewMode: "months",
                        autoclose: true,
                        endDate: new Date()
                    });
                }
                
            }

            if (data.d[7] != "" && data.d[7] != null) {
                var facilitating_Programs = JSON.parse(data.d[7]);
                var str_row = '';
                for (var i = 0; i < facilitating_Programs.length; i++) {

                    if (i == 0) {
                        $('#facilitating_0').val(facilitating_Programs[i]['mention_facilitating']);
                    }
                    else {

                        //str_row += "<tr><td><input type='text' class='marg-btm' style='width: 95%;' value='" + facilitating_Programs[i]['mention_facilitating'] + "' /></td>"
                        str_row = '<tr><td><textarea id="facilitating_' + i + '" class="marg-btm" name="facilitating_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
                            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                            + "</tr> ";

                        
                    }
                    
                    $('#tbl_facilitating_activity_publish').append(str_row);
                    $('#facilitating_' + i).val(facilitating_Programs[i]['mention_facilitating']);
                }
                
            }


            if (data.d[8] != "" && data.d[8] != null) {
                var mention_Programs = JSON.parse(data.d[8]);
                var str_row = '';
                for (var i = 0; i < mention_Programs.length; i++) {

                    if (i == 0) {
                        $('#Inhibiting_0').val(mention_Programs[i]['mention_inhibiting']);
                    }
                    else {

                         //str_row += "<tr><td><input type='text' class='marg-btm' style='width: 95%;' value='" + mention_Programs[i]['mention_inhibiting'] + "' /></td>"
                        str_row = '<tr><td><textarea id="Inhibiting_' + i + '" class="marg-btm" name="Inhibiting_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
                        + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                            + "</tr> ";

                        
                    }
                    $('#tbl_Inhibiting_activity_publish').append(str_row);
                    $('#Inhibiting_' + i).val(mention_Programs[i]['mention_inhibiting']);

                }
                
            }
            if (data.d[9] != "" && data.d[9] != null) {
                var Trainings = JSON.parse(data.d[9]);
                var str_row = '';
                for (var i = 0; i < Trainings.length; i++) {

                    if (i == 0) {
                        $('#training_skillg_0').val(Trainings[i]['training_skill']);
                    }
                    else {

                         //str_row += "<tr><td><input type='text' class='marg-btm' style='width: 95%;' value='" + Trainings[i]['training_skill'] + "' /></td>"
                        str_row = '<tr><td><textarea id="training_skillg_' + i + '" class="marg-btm" name="traning_skill_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
                             + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                            + "</tr> ";

                        
                    }

                    $('#tbl_training_activity_publish').append(str_row);
                    $('#training_skillg_'+i).val(Trainings[i]['training_skill']);
                }
                
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
                for (var i = 0; i < self_evaluation_dtl.length; i++)
                {
                    if (rating_dtl != '') {
                        var response2 = $.grep(Object(rating_dtl), function (j)
                        {
                            var status = j.question_id.trim() === self_evaluation_dtl[i]["question_id"].trim();
                            if (status == true) {
                                rating_value = j.rating.trim()
                                return false;
                            }

                            
                            

                        });
                    }
                    

                    if (self_evaluation_dtl[i]["question_id"].trim() == "t1")
                    {
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> A1) Teaching : </b></td></tr>";
                    }

                    else if (self_evaluation_dtl[i]["question_id"].trim() == "s1")
                    {
                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="teaching_comment" class="' + self_evaluation_dtl[i - 1]["ques_type"].trim()+'" name="teaching_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> A2) Studios & Courses : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "f1") {
                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="studio_comment" class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() +'" name="studio_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> A3) Student Feedback : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "r1") {

                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="feedback_comment" class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() +'" name="feedback_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> B) Research : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "if1") {

                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="research_comment" class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() +'" name="research_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> C) Institutional Role (Faculty  - needs to be graded separately) : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "iu1") {

                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="Institutional_comment" class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() +'" name="Institutional_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> D) Institutional Role (University - needs to be graded separately) : </b></td></tr>";
                    }
                    else if (self_evaluation_dtl[i]["question_id"].trim() == "sk1") {

                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="Institutional_uni_comment" class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() +'" name="Institutional_uni_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';

                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> E) Skills : </b></td></tr>";
                    }

                    else if (self_evaluation_dtl[i]["question_id"].trim() == "p1") {
                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="skill_comment" class="' + self_evaluation_dtl[i - 1]["ques_type"].trim() +'" name="skill_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';
                        str_row += "<tr class='panel panel-default' style='color:blue; border-color:#673ab7;background-color:#d1dee5;'><td colspan=3><b> F) Personality : </b></td></tr>";
                    }


                    str_row += "<tr><td style='width: 80%;'><b>" + self_evaluation_dtl[i]["doc_no"].trim() + " . " + self_evaluation_dtl[i]["question"].trim() + "</b></td>"
                        //+ "<td><input type='text' class='marg-btm text_rating' onkeyup='this.value = fnc_new(this.value, 0, 10)' onkeypress='return IsNumeric_dtl(event);' maxlength='2' pattern='^[0-9]$'  id=" + self_evaluation_dtl[i]["question_id"].trim() + " style='width: 40%;' value ='" + rating_value+"'/></td>"
                        + "<td> <span style='width: 20px; vertical-align: middle;font-weight: bold;'> 1 </span><input type='radio' style='width: 20px; height: 22px; vertical - align: middle;' id=" + self_evaluation_dtl[i]["question_id"].trim() + " name='" + self_evaluation_dtl[i]["question_id"].trim()+"' value='1'>"
                        + " <span style='width: 20px; vertical-align:middle;font-weight: bold;'> 2 </span><input type='radio' style='width: 20px; height: 22px; vertical - align: middle;' id=" + self_evaluation_dtl[i]["question_id"].trim() + " name='" + self_evaluation_dtl[i]["question_id"].trim() +"' value='2'>"
                        + " <span style='width: 20px; vertical-align:middle;font-weight: bold;' > 3 </span><input type='radio' style='width: 20px; height: 22px; vertical - align: middle;' id=" + self_evaluation_dtl[i]["question_id"].trim() + " name='" + self_evaluation_dtl[i]["question_id"].trim() +"' value='3'>"
                        + " <span style='width: 20px; vertical-align:middle;font-weight: bold;' > 4 </span><input type='radio' style='width: 20px; height: 22px; vertical - align: middle;' id=" + self_evaluation_dtl[i]["question_id"].trim() + " name='" + self_evaluation_dtl[i]["question_id"].trim() +"' value='4'>"
                        + " <span style='width: 20px; vertical-align:middle;font-weight: bold;' > 5 </span><input type='radio' style='width: 20px; height: 22px; vertical - align: middle;' id=" + self_evaluation_dtl[i]["question_id"].trim() + " name='" + self_evaluation_dtl[i]["question_id"].trim() +"' value='5'></td>"
                        + "</tr> ";
                    

                    if (i+1 == self_evaluation_dtl.length ) {
                        str_row += '<tr><td style="color: blue;"><b>Rationale based on evidence & qualitative comments : </b></td></tr>';
                        str_row += '<tr><td colspan = 5><textarea id="personality_comment" class="' + self_evaluation_dtl[i]["ques_type"].trim() +'" name="personality_comment" rows="4" cols="100" style="width:90%;"></textarea></td>';
                    }
                }
                $('#tbl_self_evaluation_dtl').append(str_row);

                for (var i = 0; i < self_evaluation_dtl.length; i++)
                {
                    if (rating_dtl != '')
                    {
                        var response2 = $.grep(Object(rating_dtl), function (j)
                        {
                            var status = j.question_id.trim() === self_evaluation_dtl[i]["question_id"].trim();
                            if (status == true)
                            {
                                $("input[name=" + self_evaluation_dtl[i]["question_id"].trim() + "][value=" + j.rating.trim()+"]").attr('checked', 'checked');
                                rating_value = j.rating.trim()
                               // return false;
                            }




                        });
                    }
                }


                if (data.d[14] != "" && data.d[14] != null)
                {
                    question_dtl = JSON.parse(data.d[14]);
                    for (var i = 0; i < question_dtl.length; i++) {
                        $('.' + question_dtl[i]["question_type"]).val(question_dtl[i]['question_comment'].trim());
                    }
                }
            }

            if (data.d[11] != "" && data.d[11] != null) {
                var get_faculty_course_code = JSON.parse(data.d[11]);
                var str_row = '';
                var total_hours = 0;
                for (var i = 0; i < get_faculty_course_code.length; i++)
                {
                    var response2 = $.grep(Object(get_faculty_course_code), function (j) {
                        
                        return j.course_code === get_faculty_course_code[i]["course_code"];
                    });
                    total_hours = parseInt(parseInt(total_hours) + parseInt(get_faculty_course_code[i]["total_hrs_in_semester"]));
                    str_row += "<tr><td>" + get_faculty_course_code[i]["semester"] + "</td><td>" + get_faculty_course_code[i]["course_code"] + "</td><td>" + get_faculty_course_code[i]["course_name"] + "</td>";
                    str_row += "<td>" + get_faculty_course_code[i]["course_credits"] + "</td><td>" + get_faculty_course_code[i]["total_hrs_in_semester"] + "</td><td>" + get_faculty_course_code[i]["add_total_hrs_in_semester"] + "</td><td>" + get_faculty_course_code[i]["total_no_of_year_count"] + "</td></tr>";

                }
                $('#tbl_teaching_dtl').append(str_row);
                $('#txt_cours_hours').val(total_hours);
            }

            if (data.d[12] != "" && data.d[12] != null) {
                var get_faculty_drp_dtl = JSON.parse(data.d[12]);
                var str_row = '';
                var total_hours = 0;
                for (var i = 0; i < get_faculty_drp_dtl.length; i++)
                {
                    total_hours = parseInt(parseInt(total_hours) + parseInt(get_faculty_drp_dtl[i]["total_hrs_in_semester"]));
                    str_row += "<tr><td>" + get_faculty_drp_dtl[i]["semester"] + "</td>";
                    str_row += "<td>" + get_faculty_drp_dtl[i]["course_code"] + "</td>";
                    str_row += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                }
                $('#tbl_drp_thesis_dtl').append(str_row);
                $('#txt_drp_thesis').val(total_hours);
            }

            if (data.d[15] != "" && data.d[15] != null)
            {
                var get_cpop_personal_details = JSON.parse(data.d[15]);
                var str_row = '';

                $('#txt_name').text(get_cpop_personal_details[0]['supervisor_name']);
                $('#txt_designation').text(get_cpop_personal_details[0]['designation']);
                $('#txt_faculty').text(get_cpop_personal_details[0]['department']);
            }

            if (data.d[16] != "" && data.d[16] != null) {
                var get_instructor_education_details = JSON.parse(data.d[16]);
                var str_row = '';
          
                for (var i = 0; i < get_instructor_education_details.length; i++)
                {
                    str_row += "<tr><td>" + get_instructor_education_details[i]["degree"] + "</td><td>" + get_instructor_education_details[i]["field"] + "</td>";
                    str_row += "<td>" + get_instructor_education_details[i]["institution"] + "</td><td>" + get_instructor_education_details[i]["year_of_completion"] + "</td></tr>";

                }
                $('#tbl_education_dtl').append(str_row);

            }

            if (data.d[17] != "" && data.d[17] != null)
            {
                var get_comments_details = JSON.parse(data.d[17]);
                $('#deancomments').val(get_comments_details[0]["dean_comment"]);
                $('#deanallcomments').val(get_comments_details[0]["over_all_comment_by_dean"]);
                $('#reviewcomments').val(get_comments_details[0]["comment_by_review_committee"]);


                $('#txt_faculty').val(get_comments_details[0]["dept_name"]);
                $('#txt_designation').val(get_comments_details[0]["designation"]);
                //$('#txt_year_experience').val(get_comments_details[0]["total_year_experience"]);
                if (get_comments_details[0]["total_year_experience"] != "") {
                    $('#txt_year_experience').val(get_comments_details[0]["total_year_experience"]);
                }
                else
                {
                    $('#txt_year_experience').val(get_comments_details[0]["total_experiance"]);
                }
                
                $('#txt_year_teaching').val(get_comments_details[0]["imteaching_year"]);
                $('#txt_teaching_experience').val(get_comments_details[0]["total_teaching_experiance"]);
                $('#txt_drp_thesis').val(get_comments_details[0]["drp_thesis_hours"]);
                if (get_comments_details[0]["total_hrs_teaching"] != "")
                {
                    $('#txt_cours_hours').val(get_comments_details[0]["total_hrs_teaching"]);
                }
                

                $('#txt_joining_date').val(get_comments_details[0]["date_of_join"]);
                $('#txt_confirmation_date').val(get_comments_details[0]["confirmationdate"]);
                $('#txt_total_experiance_months').val(get_comments_details[0]["totalexperiancemonths"]);
               
                if (get_comments_details[0]["dean_approve"] == "Y" && $('#hdnusertype').val() == 'D')
                {
                    $('.btn-small').attr("disabled", true);
                    $('input[type=number]').attr("disabled", true);
                    $('#tbl_self_evaluation_dtl textarea').attr("disabled", true);
                    $('input[type=radio]').attr("disabled", true);
                    $('#submitBtnDiv').css('display', 'none');
                }
                else if ($('#hdnusertype').val() == 'D' && get_comments_details[0]["dean_approve"] == "N")
                {
                    $('.btn-small').attr("disabled", true);
                    $('input[type=number]').attr("disabled", true);
                    $('#tbl_self_evaluation_dtl textarea').attr("disabled", true);
                    $('input[type=radio]').attr("disabled", true);
                    $('.marg-btm').attr('disabled', 'disabled');
                    $('.personality').attr('disabled', 'disabled');
                    $('#submitBtnDiv').css('display', 'none');

                    $('#reviewcomments').attr('disabled', 'disabled');
                    $('#deancomments').attr('disabled', 'disabled');
                    var str_row = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsavecomment' type='button' style='display: block' class='btn btn-primary'>" +
                        "<i class='icon-save bigger-160'></i>Comments and Approve </button></td> </tr></table>";
                    $('#submitBtnDivhr').html(str_row);
                    $('#submitBtnDivhr').css('display', 'block');

                }
                else if (get_comments_details[0]["faculty_approve"] == "Y" && $('#hdnusertype').val() == 'I2')
                {
                    $('#submitBtnDiv').css('display', 'none');
                    $('#txt_joining_date').attr('disabled', 'disabled');
                    $('#txt_total_experiance_months').attr('disabled', 'disabled');
                    $('#txt_year_experience').attr('disabled', 'disabled');
                    $('#txt_year_teaching').attr('disabled', 'disabled');
                    $('#txt_teaching_experience').attr('disabled', 'disabled');
                    $('#txt_confirmation_date').attr('disabled', 'disabled');
                }
                //else if ($('#hdnusertype').val() == 'HR' && get_comments_details[0]["uso_approve"] == "Y") {
                else if ($('#hdnusertype').val() == 'HR') {
                    $('.btn-small').attr("disabled", true);
                    $('input[type=number]').attr("disabled", true);
                    $('#tbl_self_evaluation_dtl textarea').attr("disabled", true);
                    $('.marg-btm').attr('disabled', 'disabled');
                    $('.personality').attr('disabled', 'disabled');
                    $('input[type=radio]').attr("disabled", true);
                    $('#deanallcomments').attr('disabled', 'disabled');
                    $('#deancomments').attr('disabled', 'disabled');
                    $('#submitBtnDiv').css('display', 'none');
                    var str_row = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsavecomment' type='button' style='display: block' class='btn btn-primary'>" +
                        "<i class='icon-save bigger-160'></i>Comments and Approve </button></td> </tr></table>";
                    $('#submitBtnDivhr').html(str_row);
                    $('#submitBtnDivhr').css('display', 'block');
                    
                }

                if (get_comments_details[0]["uplodaFile1"] != "")
                {
                    //const fileName = data["uplodaFile1"].split('/').pop();
                    const fileUrl = '/ApprisalFileUploads/' + get_comments_details[0]["uplodaFile1"].replace(/^~\//, '');
                    var newRow =
                        `<tr>
                        <td>1</td>
                        <td>${get_comments_details[0]["uplodaFile1"]}</td>
                        <td><a href="${fileUrl}" target="_blank" download>Download</a></td>
<td><button type="button" class="btn btn-danger btn-sm remove-subrow" style="border-radius: 6px;"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="margin-top: 50%;"></i></button></td>
                    </tr>`;
                    $('#tbl_self_evaluation_upload_doc_dtl tbody').append(newRow);
                }
                if (get_comments_details[0]["uplodaFile2"] != "") {
                    const fileUrl = '/ApprisalFileUploads/' + get_comments_details[0]["uplodaFile2"].replace(/^~\//, '');
                    var newRow =
                        `<tr>
                        <td>2</td>
                        <td>${get_comments_details[0]["uplodaFile2"]}</td>
                        <td><a href="${fileUrl}" target="_blank" download>Download</a></td>
<td><button type="button" class="btn btn-danger btn-sm remove-subrow" style="border-radius: 6px;"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="margin-top: 50%;"></i></button></td>
                    </tr>`;
                    $('#tbl_self_evaluation_upload_doc_dtl tbody').append(newRow); 
                } 
                if (get_comments_details[0]["uplodaFile3"] != "") {
                    const fileUrl = '/ApprisalFileUploads/' + get_comments_details[0]["uplodaFile3"].replace(/^~\//, '');
                    var newRow =
                        `<tr>
                        <td>3</td>
                        <td>${get_comments_details[0]["uplodaFile3"]}</td>
                        <td><a href="${fileUrl}" target="_blank" download>Download</a></td>
<td><button type="button" class="btn btn-danger btn-sm remove-subrow" style="border-radius: 6px;"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="margin-top: 50%;"></i></button></td>
                    </tr>`;
                    $('#tbl_self_evaluation_upload_doc_dtl tbody').append(newRow);
                }

                if (get_comments_details[0]["uplodaFile4"] != "") {
                    const fileUrl = '/ApprisalFileUploads/' + get_comments_details[0]["uplodaFile4"].replace(/^~\//, '');
                    var newRow =
                        `<tr>
                        <td>4</td>
                        <td>${get_comments_details[0]["uplodaFile4"]}</td>
                        <td><a href="${fileUrl}" target="_blank" download>Download</a></td>
<td><button type="button" class="btn btn-danger btn-sm remove-subrow" style="border-radius: 6px;"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="margin-top: 50%;"></i></button></td>
                    </tr>`;
                    $('#tbl_self_evaluation_upload_doc_dtl tbody').append(newRow);
                }
                


            }


            if (data.d[19] != "" && data.d[19] != null) {
                var confrencedtl = JSON.parse(data.d[19]);
                for (var i = 0; i < confrencedtl.length; i++)
                {
                    if (i == 0)
                    {
                        $('#res_conference_title_0').val(confrencedtl[i]['Title']);
                        $('#res_conference_type_0').val(confrencedtl[i]['Type']);
                        $('#res_name_conference_0').val(confrencedtl[i]['NameOfConference']);
                        $('#res_conference_national_0').val(confrencedtl[i]['conferencetype']);
                        $('#res_conference_author_0').val(confrencedtl[i]['Authorship']);
                        $('#res_conference_start_date_0').val(confrencedtl[i]['StartDateChange']);
                        $('#res_conference_enddate_0').val(confrencedtl[i]['EndDateChange']);
                        $('#res_conference_submitted_0').val(confrencedtl[i]['submittedToUniversity']);
                        $('#txt_res_conferences_year').val(confrencedtl[i]['total_hours']);
                    } 
                    else {
                       // var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 300px;' value='" + confrencedtl[i]['title'] + "'/></td>"
                       //     + "<td><select style='width:100px;' name ='comp_ongoing_type' class='marg-btm' id='comp_ongoing_type_" + i + "'>" + GetResearchProjectType + "</select></td></td>"
                       //     + "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + confrencedtl[i]['Description'] + "' /></td>"
                       //     + "<td><input type='text' class='marg-btm' style='width: 120px;' value='" + confrencedtl[i]['funding_agency'] + "' /></td>"
                       //     + "<td><input type='text' class='marg-btm' style='width: 90px;' value='" + confrencedtl[i]['fund_available'] + "' /></td>"
                       //     + "<td><input type='text' class='marg-btm' style='width: 180px;' value='" + confrencedtl[i]['duration'] + "' /></td>"
                       //     + "<td><select class='comp_ongoing_status' id='com_" + i + "' style='width: 180px;'><option value=''>Please Select Status </option><option value = 'completed'>completed</option><option value='ongoing'>ongoing</option></select></td>"
                       //     + "<td><input type='text' id='txt_ongoing_start_date_" + i + "' class='marg-btm' placeholder='MM-YYYY' value='" + confrencedtl[i]['StartDateChange'] + "'></td>"
                       //     + "<td><input type='text' id='txt_ongoing_end_date_" + i + "' class='marg-btm' placeholder='MM-YYYY' value='" + confrencedtl[i]['EndDateChange'] + "'></td>"
                       //     + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
                       //     + "</tr> ";



                        var str_row = "<tr>"
                           // + "<td><input type='text' name='res_name' class='marg-btm res_name' id='res_conference_title_" + i + "' style='width: 180px;' value='" + confrencedtl[i]['Title'] + "' /></td>"


                            + "<td><textarea id='res_conference_title_" + i + "' class='marg - btm res_name' name='res_name' rows='1' cols='60' style='width: 180px;'></textarea></td>"


                            + "<td><select style='width: 120px;' name='resconferencetype' class='marg-btm' id='res_conference_type_" + i + "'>"
                            + "<option value=''>--Select Type--</option>"
                            + "<option value='Journal'>Journal</option>"
                            + "<option value='Conference'>Conference</option><option value='NotApplicable'>Not Applicable</option></select></td>"

                            //+ "<td><input type='text' name='resnameconference' class='marg-btm res_name_conference' id='res_name_conference_" + i + "' style='width: 180px;' value='" + confrencedtl[i]['NameOfConference'] + "' /></td>"
                            + "<td><textarea id='res_name_conference_" + i + "' class='marg - btm res_name_conference' name='resnameconference' rows='1' cols='60' style='width: 180px;'></textarea></td>"

                            + "<td><select style='width: 120px;' name='res_conference_national' class='marg-btm' id='res_conference_national_" + i + "'>"
                            + "<option value=''>Select</option>"
                            + "<option value='National'>National</option>"
                            + "<option value='International'>International</option>"
                            + "<option value='Conference'>Conference</option></select></td>"
                            + "<td><select style='width: 120px;' name='res_conference_author' class='marg-btm' id='res_conference_author_" + i + "'>"
                            + "<option value=''>Select</option>"
                            + "<option value='SoleAuthor'>Sole Author</option>"
                            + "<option value='Coauthor'>Co-author</option></select></td>"
                            + "<td><input type='text' name='res_conference_startdate' class='marg-btm' id='res_conference_start_date_" + i + "' placeholder='MM-YYYY' style='width: 100px;' value='" + confrencedtl[i]['StartDateChange'] + "' /></td>"
                            + "<td><input type='text' name='res_conference_enddate' class='marg-btm' id='res_conference_enddate_" + i + "' placeholder='MM-YYYY' style='width: 100px;' value='" + confrencedtl[i]['EndDateChange'] + "' /></td>"
                            + "<td><select style='width: 90px;' name='res_conference_submitted' class='marg-btm' id='res_conference_submitted_" + i + "'>"
                            + "<option value=''>Select</option>"
                            + "<option value='Yes'>Yes</option>"
                            + "<option value='No'>No</option></select></td>"
                            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
                            + "</tr>";

                        $('#tbl_conferences_publish').append(str_row);
                        $('#res_conference_title_' + i).val(confrencedtl[i]['Title']);
                        $('#res_name_conference_' + i).val(confrencedtl[i]['NameOfConference']);
                        $('#res_conference_type_' + i).val(confrencedtl[i]['Type']);
                        $('#res_conference_national_' + i).val(confrencedtl[i]['conferencetype']);
                        $('#res_conference_author_' + i).val(confrencedtl[i]['Authorship']);
                        $('#res_conference_submitted_' + i).val(confrencedtl[i]['submittedToUniversity']);

                        $('#res_conference_enddate_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true,
                            endDate: new Date()
                        });

                        $('#res_conference_start_date_' + i).datepicker({
                            format: "mm-yyyy",
                            startView: "months",
                            minViewMode: "months",
                            autoclose: true
                        });
                    }
                }

            }




        },
        error: function (result) {
            alert(result);
        }
    });
}
function confirmdialog(message,currentdata) {
    Swal.fire({
        title: message,
        text: "",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, remove it!"
    }).then((result) => {
        if (result.isConfirmed) {
            //var thisdata = $(this).closest("tr");
            currentdata.remove();
            Swal.fire({
                title: "Deleted!",
                text: "Your Data has been deleted.",
                icon: "success"
            });
        }
    });
}
function add_row(tbl) {
    //FirstStep
    month_text = '<option value=""> Please Select Month </option><option value="1"> January </option><option value = "2">February </option>';
    month_text += '<option value="3"> March </option>';
    month_text += '<option value="4"> April </option>';
    month_text += '<option value="5"> May </option>';
    month_text += '<option value="6"> June </option>';
    month_text += '<option value="7"> July </option>';
    month_text += '<option value="8"> August </option>';
    month_text += '<option value="9"> September </option>';
    month_text += '<option value="10"> October </option>';
    month_text += '<option value="11"> November </option>';
    month_text += '<option value="12"> December </option>';
    if (tbl == 'research_publish')
    {
        
        var table_length = $('#tbl_rese_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        var str_row = "<tr><td> <select style='width:100px;' name ='res_type' class='marg-btm restypedtl' id='res_type_" + table_length + "'>" + type_publication + "</select ></td>"
            //+ " <td><input type='text' id='res_name_" + table_length + "' class='marg-btm' style='width: 300px;'/></td> "
            + "<td><textarea id='res_name_" + table_length + "' class='marg-btm res_name' name='res_name' rows='1' cols='60' style='width:300px;'></textarea></td>"
            + "<td style = 'display:none;'><select style = 'width:100px;' name = 'restype' class='marg-btm' id ='restype'><option value=''>Select</option><option value='Journal'>Journal</option><option value = 'Conference'>Conference</option></select></td>"
            + "<td><input type='text' class='marg-btm' style='width: 90px;'/></td>"
            + "<td> <select style='width: 100%; ' name='res_national' class='marg-btm' id='res_national_" + table_length + "'><option value = ''> Please Select Type </option ><option value='National'> National </option><option value = 'International'>International</option><option value='Conference'>Conference</option></select></td>"
          
            + "<td><input type='text' class='marg-btm' style='width: 50px;'/></td>"
            // + "<td><input type='text' class='marg-btm' style='width: 120px;'/></td>"

            + "<td> <select style='width:90%;' name ='res_sole_author' class='marg-btm' id='res_sole_author_" + table_length + "'><option value = ''> Please Select </option><option value='SoleAuthor'> Sole Author </option><option value='Coauthor'>Co-author</option></select></td>"


            //+ "<td><input type='text' class='marg-btm' style='width: 50px;'/></td>"
            + "<td><select style='width:108%;' class='marg-btm' id='res_month_" + table_length + "'>" + month_text + "</select></td>"
            + "<td><select style='width:108%;' name ='res_year' class='marg-btm year_dropdown' id='res_year_" + table_length + "'></select></td>"
            /*+ "<td><input type='text' class='marg-btm' style='width: 120px;'/></td>"*/
            + "<td><select style='width:90px;' name=res_submitted class='marg-btm' id='res_submitted_" + table_length + "'><option value=''> Please Select</option><option value='Yes'> Yes</option><option value='No'>No</option></select></td>"

            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";
        
        $('#tbl_rese_publish').append(str_row);
        $('#' + 'res_year_' + table_length).html(str_year_html);
   
    }

    else if (tbl == 'add_comp_ongoing') {
        var table_length = $('#tbl_comp_ongoing_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
       
        var str_row = "<tr><td><textarea id='comp_ongoing_text_" + table_length + "' class='marg-btm addcomongoingtitle' rows='1' cols='60' style='width: 300px;'></textarea></td>"
            + "<td><select style='width:100px;' name ='comp_ongoing_type' class='marg-btm' id='comp_ongoing_type_" + table_length + "'>" + GetResearchProjectType + "</select></td>"

            /*+ "<td><input type='text' class='marg-btm' style='width: 120px;'/></td>"*/
            + " <td> <textarea id='comp_ongoing_desc_" + table_length + "' class='marg-btm addcomongoingdesc' rows='1' cols='60' style='width: 180px;'></textarea></td>"


            + "<td><input type='text' class='marg-btm' style='width: 120px;'/></td>"
            + "<td><input type='text' class='marg-btm' style='width: 90px;'/></td>"
            + "<td><input type='text' class='marg-btm' style='width: 70px;'/></td>"
            + "<td><select class='comp_ongoing_status' style='width: 180px;' id='com_" + table_length +"><option value=''>Please Select Status </option><option value ='completed'>completed</option><option value='ongoing'>ongoing</option></select></td>"
            + "<td><input type='text' id='txt_ongoing_start_date_" + table_length + "' style='width: 80px;' class='marg-btm' placeholder='MM-YYYY'></td>"
            + "<td><input type='text' id='txt_ongoing_end_date_" + table_length + "' style='width: 80px;' class='marg-btm' placeholder='MM-YYYY'></td>"
            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";

        $('#tbl_comp_ongoing_publish').append(str_row);

        $('#txt_ongoing_end_date_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });

        $('#txt_ongoing_start_date_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true
        });

    }
    else if (tbl == 'various_activity') {
        var table_length = $('#tbl_various_activity_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));

        // var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 385px;'/></td>"
       //     + "<td><input type='text' class='marg-btm' style='width: 280px;'/></td>"
       //     + "<td><select class='comp_various_status' id='various_" + table_length +"' style='width: 180px;'><option value=''>Please Select Status </option><option value='completed'>Completed</option>"
       //     +  "<option value='InProcess'>In Process</option><option value='YettoStart'>Yet to Start</option></select ></td>"
       //     + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
       //     + "</tr> ";


        


        var str_row = "<tr>"
            + "<td><select id='comp_various_title_" + table_length +"' style='width: 100px;'>"
            + "<option value=''>Please Select</option>"
            + "<option value='Review'>Review</option>"
            + "<option value='Juries'>Juries</option><option value='NotApplicable'>Not Applicable</option></select></td>"
            //+ "<td><input type='text' class='marg-btm' id='comp_various_" + table_length +"' style='width: 200px;' /></td>"
            + "<td><textarea id='comp_various_" + table_length + "' class='marg-btm' rows='1' cols='60'></textarea></td>"
            //+ "<td><input type='text' class='marg-btm' id='comp_various_Organisation_" + table_length + "' style='width: 100px;' /></td>"
            + "<td><div class='radio-group'>"
            + "<input type='radio' id='CEPT_" + table_length +"'  name='source_" + table_length + "' class='source_radio' value='cept' checked> CEPT"
            + "<input type='radio' id='Other_" + table_length +"' name='source_" + table_length + "' class='source_radio' value='other'> Other"
            + "<input type='text' class='marg-btm other_input' id='comp_various_Organisation_" + table_length + "' style='width: 100px; display: none;' placeholder='Other Organisation' />"
            + "</div></td>"
            + "<td><select class='comp_various_type' id='comp_various_type_" + table_length + "' style='width: 100px;'>" + VariousActivities +"</select></td>"
            + "<td><select class='comp_various_status' id='comp_status_" + table_length +"' style='width: 180px;'>"
            + "<option value=''>Please Select Status</option>"
            + "<option value='completed'>Completed</option>"
            + "<option value='InProcess'>In Process</option>"
            + "<option value='YettoStart'>Yet to Start</option></select></td>"
            + "<td><input type='text' class='marg-btm' id='comp_StartDate_" + table_length +"' style='width: 100px;' placeholder='MM-YYYY' /></td>"
            + "<td><input type='text' class='marg-btm' id='comp_EndDate_" + table_length +"' style='width: 100px;' placeholder='MM-YYYY' /></td>"
            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
            + "</tr>";

        $('#tbl_various_activity_publish').append(str_row);
        $('#comp_StartDate_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#comp_EndDate_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });


    }

    else if (tbl == 'professional_activity') {
        var table_length = $('#tbl_professional_activity_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        var str_row = "<tr><td><select class='comp_profess_status' id='profess_" + table_length + "' style='width: 180px;'><option value=''>Please Select </option>"
            + "<option value = 'Seminar'> Seminar</option >"
            + "<option value='Workshop'>Workshop</option><option value='LectureOffered'>Lecture, Offered</option>"
            + "<option value='Organised'>Organised </option><option value='Facultymeeting'>Faculty Meeting</option><option value='NotApplicable'>Not Applicable</option></select></td>"
            /*+ "<td><input type='text' class='marg-btm' style='width: 300px;' /></td>"*/
            + "<td><textarea id='prof_title_" + table_length + "' class='marg-btm' rows='1' cols='60' style='width: 300px;'></textarea></td>"
        /*+ "<td><input type='text' class='marg-btm' style='width: 300px;' /></td>"*/
            + "<td><textarea id='prof_desc_" + table_length + "' class='marg-btm' rows='1' cols='60' style='width: 300px;'></textarea></td>"
            + "<td><input type='text' class='marg-btm' style='width: 120px;' /></td>"
            + "<td><input type='text' class='marg-btm' style='width: 120px;'  id='prof_Start_Date_" + table_length+"'  /></td>"
            + "<td><input type='text' class='marg-btm' style='width: 120px;'  id='prof_End_Date_" + table_length+"' /></td>"
            + "<td><input type='text' class='marg-btm' style='width: 120px;' /></td>"
            + "<td><input type='text' class='marg-btm' style='width: 60px;' /></td>"
            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";

        $('#tbl_professional_activity_publish').append(str_row);

        $('#prof_Start_Date_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#prof_End_Date_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });

    }

    else if (tbl == 'Institutional_activity') {
        var table_length = $('#tbl_Institutional_activity_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        //var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 95%;' /></td>"

        //var str_row = '<tr><td><textarea id="admins_' + table_length + '" class="marg-btm" name="Administrative_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
        //    + "<td><select class='comp_ongoing_status' style='width: 120px;'><option value=''>Please Select Status </option><option value='completed'>Completed</option>"
        //    + "<option value='InProcess'>In Process</option><option value='YettoStart'>Yet to Start</option></select ></td>"
        //    + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
        //    + "</tr> ";


        var str_row = "<tr>"
            //+ "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_title_" + table_length + "' /></td>"
            + "<td><textarea id='publish_title_" + table_length + "' class='marg-btm' rows='1' cols='60' style='width: 100px;'></textarea></td>"
            + "<td><select class='publish_type' id='publish_type_" + table_length + "' style='width: 180px;'>"
            + "<option value=''>Please Select</option>"
            + "<option value='Workassigned'>Work assigned</option>"
            + "<option value='Undertaken'>Undertaken</option><option value='NotApplicable'>Not Applicable</option></select></td>"
            + "<td><textarea id='admins_" + table_length + "' class='marg-btm' name='Administrative_text' rows='1' cols='60' style='width:100%;'></textarea></td>"
            + "<td><select class='comp_administrative_status' id='admint_" + table_length + "'  style='width: 120px;'>"
            + "<option value=''>Please Select Status</option>"
            + "<option value='completed'>Completed</option>"
            + "<option value='InProcess'>In Process</option>"
            + "<option value='YettoStart'>Yet to Start</option></select></td>"
            + "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_StartDate_" + table_length + "' placeholder='MM-YYYY' /></td>"
            + "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_EndDate_" + table_length + "' placeholder='MM-YYYY' /></td>"
            + "<td><input type='text' class='marg-btm' style='width: 100px;' id='publish_duration_" + table_length + "' /></td>"
            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
            + "</tr>";

        $('#tbl_Institutional_activity_publish').append(str_row);

        $('#publish_StartDate_' + table_length ).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true
        });

        $('#publish_EndDate_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });

    }

    else if (tbl == 'skill_activity') {
        var table_length = $('#tbl_skill_activity_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
       // var str_row = '<tr><td><textarea id="skill_' + table_length + '" class="marg-btm" name="skill_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
       //     + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
       //     + "</tr> ";


        var str_row = "<tr>"
            /*+ "<td><input type='text' class='marg-btm' style='width: 100px;' id='skills_title_" + table_length + "' /></td>"*/
            + "<td><textarea id='skills_title_" + table_length + "' class='marg-btm' rows='1' cols='60' style='width: 100px;'></textarea></td>"
            + "<td><select class='skill_type' id='skill_type_" + table_length + "' style='width: 180px;'>"
            + "<option value=''>Please Select</option>"
            + "<option value='Lecture'>Lecture</option>"
            + "<option value='Conference'>Conference</option>"
            + "<option value='Workshop'>Workshop</option>"
            + "<option value='Seminar'>Seminar</option></select></td>"
            + "<td><textarea id='skill_" + table_length + "' class='marg-btm' name='skill_text' rows='1' cols='60' style='width:100%;'></textarea></td>"
            + "<td><input type='text' class='marg-btm' style='width: 100px;' id='skill_Date_" + table_length + "' placeholder='MM-YYYY' /></td>"
            + "<td><textarea id='skill_org_" + table_length + "' class='marg-btm' name='skill_org_text' rows='1' cols='60' style='width:100%;'></textarea></td>"
            + "<td><select class='skill_org_type' id='skill_org_type_" + table_length + "' style='width: 180px;'>"
            + "<option value=''>Please Select</option>"
            + "<option value='Online'>Online</option>"
            + "<option value='OffLine'>Offline</option>"
            + "</select></td>"


            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
            + "</tr>";

       

        $('#tbl_skill_activity_publish').append(str_row);
        $('#skill_Date_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
    }


    else if (tbl == 'facilitating_activity') {
        var table_length = $('#tbl_facilitating_activity_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        var str_row = '<tr><td><textarea id="facilitating_' + table_length + '" class="marg-btm" name="facilitating_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
        //var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 95%;' /></td>"
            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";

        $('#tbl_facilitating_activity_publish').append(str_row);

    }

    else if (tbl == 'Inhibiting_activity') {
        var table_length = $('#tbl_Inhibiting_activity_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        //var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 95%;' /></td>"
        var str_row = '<tr><td><textarea id="Inhibiting_' + table_length + '" class="marg-btm" name="Inhibiting_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";

        $('#tbl_Inhibiting_activity_publish').append(str_row);

    }
    else if (tbl == 'training_activity') {
        var table_length = $('#tbl_training_activity_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        //var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 95%;' /></td>"
        var str_row = '<tr><td><textarea id="training_skillg_' + table_length + '" class="marg-btm" name="traning_skill_text" rows="4" cols="100" style="width:100%;"></textarea></td>'
            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";

        $('#tbl_training_activity_publish').append(str_row);

    }

    else if (tbl == 'add_other_activity') {
        var table_length = $('#tbl_other_activity tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));

        var str_row = "<tr><td><textarea id='other_activity_" + table_length +"' class='marg-btm addactivitytitle' rows='1' cols='60'></textarea></td>"
            + "<td><select name ='other_activity_type' class='marg-btm' id='other_activity_type_" + table_length + "'>" + OtherActivityType + "</select></td>"
            + "<td><textarea id='other_activity_desc_" + table_length +"' class='marg-btm addactivitydesc' rows='1' cols='60'></textarea></td>"
            + "<td><input type='text' id='other_activity_date_" + table_length + "' class='marg-btm' placeholder='MM-YYYY'></td>"
            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";

        $('#tbl_other_activity').append(str_row);

        $('#other_activity_date_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });

    }
    else if (tbl == 'research_conferences')
    {
        var table_length = $('#tbl_conferences_publish tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));

        //var str_row = "<tr><td><input type='text' class='marg-btm' id='other_activity_" + table_length + "'/></td>"
        //    + "<td><select name ='other_activity_type' class='marg-btm' id='other_activity_type_" + table_length + "'>" + OtherActivityType + "</select></td>"
        //    + "<td><input type='text' class='marg-btm' id='other_activity_desc_" + table_length + "' /></td>"
        //    + "<td><input type='text' id='other_activity_date_" + table_length + "' class='marg-btm' placeholder='MM-YYYY'></td>"
        //    + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
        //    + "</tr> ";

        var str_row = "<tr>"

            //+ "<td><input type='text' name='res_name' class='marg-btm res_name' id='res_conference_title_" + table_length + "' style='width: 180px;' /></td>"
            + "<td><textarea id='res_conference_title_" + table_length + "' class='marg-btm res_name' name='res_name' rows='1' cols='60' style='width: 180px;'></textarea></td>"

            + "<td><select style='width: 120px;' name='resconferencetype' class='marg-btm' id='res_conference_type_" + table_length + "'>"
            + "<option value=''>--Select Type--</option>"
            + "<option value='Journal'>Journal</option>"
            + "<option value='Conference'>Conference</option><option value='NotApplicable'>Not Applicable</option></select></td>"

            + "<td><textarea id='res_name_conference_" + table_length + "' class='marg-btm resnameconference' name='resnameconference' rows='1' cols='60' style='width: 180px;'></textarea></td>"
            /*+ "<td><input type='text' name='resnameconference' class='marg-btm res_name_conference' id='res_name_conference_" + table_length + "' style='width: 180px;' /></td>"*/



            + "<td><select style='width: 120px;' name='res_conference_national' class='marg-btm' id='res_conference_national_" + table_length + "'>"
            + "<option value=''>Select</option>"
            + "<option value='National'>National</option>"
            + "<option value='International'>International</option>"
            + "<option value='Conference'>Conference</option></select></td>"
            + "<td><select style='width: 120px;' name='res_conference_author' class='marg-btm' id='res_conference_author_" + table_length + "'>"
            + "<option value=''>Select</option>"
            + "<option value='SoleAuthor'>Sole Author</option>"
            + "<option value='Coauthor'>Co-author</option></select></td>"
            + "<td><input type='text' name='res_conference_startdate' class='marg-btm' id='res_conference_start_date_" + table_length + "' placeholder='MM-YYYY' style='width: 100px;' /></td>"
            + "<td><input type='text' name='res_conference_enddate' class='marg-btm' id='res_conference_enddate_" + table_length + "' placeholder='MM-YYYY' style='width: 100px;' /></td>"
            + "<td><select style='width: 90px;' name='res_conference_submitted' class='marg-btm' id='res_conference_submitted_" + table_length + "'>"
            + "<option value=''>Select</option>"
            + "<option value='Yes'>Yes</option>"
            + "<option value='No'>No</option></select></td>"
            + "<td><center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center></td>"
            + "</tr>";

        $('#tbl_conferences_publish').append(str_row);

        $('#res_conference_start_date_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });
        $('#res_conference_enddate_' + table_length).datepicker({
            format: "mm-yyyy",
            startView: "months",
            minViewMode: "months",
            autoclose: true,
            endDate: new Date()
        });

    }

    else if (tbl == 'add_drp') {
        var table_length = $('#tbl_drp_thesis_dtl tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 50px;'/></td>"
            + '<td><textarea id="drp_' + table_length + '" class="marg - btm" name="Inhibiting_text" rows="2" cols="10" style="width: 100 %;"></textarea></td>'
            + "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>"
            + "</tr> ";

        $('#tbl_drp_thesis_dtl').append(str_row);

    }


    return false;
}
//$(document).on('click', '#tbl_rese_publish tbody tr td i.icon-trash', function (e)
//{
//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_other_activity tbody tr td i.icon-trash').live('click', function (e) {
//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_comp_ongoing_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}
//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_various_activity_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}


//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_professional_activity_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}

//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_Institutional_activity_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}

//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_skill_activity_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}

//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_facilitating_activity_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}

//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_Inhibiting_activity_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}

//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_training_activity_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}

//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_conferences_publish tbody tr td i.icon-trash').live('click', function (e) {
//    //var r = confirm("Are u sure you want to remove this?");
//    //if (r == true) {
//    //
//    //    var thisdata = $(this).closest("tr");
//    //    $(this).closest("tr").remove();
//    //}

//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});
//$('#tbl_drp_thesis_dtl tbody tr td i.icon-trash').live('click', function (e) {
//    var thisdata = $(this).closest("tr");
//    confirmdialog('Are u sure you want to remove this?', thisdata);
//});




$(document).on('click',
    '#tbl_other_activity tbody tr td i.icon-trash, \
     #tbl_comp_ongoing_publish tbody tr td i.icon-trash, \
     #tbl_various_activity_publish tbody tr td i.icon-trash, \
     #tbl_professional_activity_publish tbody tr td i.icon-trash, \
     #tbl_Institutional_activity_publish tbody tr td i.icon-trash, \
     #tbl_skill_activity_publish tbody tr td i.icon-trash, \
     #tbl_facilitating_activity_publish tbody tr td i.icon-trash, \
     #tbl_Inhibiting_activity_publish tbody tr td i.icon-trash, \
     #tbl_training_activity_publish tbody tr td i.icon-trash, \
     #tbl_conferences_publish tbody tr td i.icon-trash, \
     #tbl_drp_thesis_dtl tbody tr td i.icon-trash',
    function (e) {
        var thisdata = $(this).closest("tr");
        confirmdialog('Are u sure you want to remove this?', thisdata);
    });







function onlyNumberKey(evt) {

    // Only ASCII character in that range allowed
    var ASCIICode = (evt.which) ? evt.which : evt.keyCode
    if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
        return false;
    return true;
}
function fnc(value, min, max) {
    if (parseInt(value) < 0 || isNaN(value))
        return 0;
    else if (parseInt(value) > 2000)
        return "Number is greater than 2000";
    else return value;
}
function fnc_new(value, min, max) {
    if (parseInt(value) < 0 || isNaN(value))
        return 0;
    else if (parseInt(value) > 10)
        return "0";
    else return value;
}
function validation()
{
    var status_false = false;
    var respublishstatus = false;
    var respublishmessage = "";
    if ($('#txt_joining_date').val() == "")
    {
        Swal.fire({
            text: "Please Enter Date of Joining CEPT !",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });
        return false;
    }
    if ($('#txt_year_experience').val() == "")
    {
       //alert("Enter EnterTotal Years of Experience");

        Swal.fire({
            text: "Enter EnterTotal Years of Experience !",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });
        return false;
    }

    if ($('#txt_year_teaching').val() == "")
    {
    

        //Swal.fire({
        //    text: "select Teaching in the current position since(Years) !",
        //    icon: "info",
        //    buttonsStyling: false,
        //    confirmButtonText: "Ok, got it!",
        //    customClass: {
        //        confirmButton: "btn btn-primary"
        //    }
        //});
        //return false;
    }

    if ($('#txt_teaching_experience').val() == "") {
        //alert(" Enter Teaching Experience in previous position");
        Swal.fire({
            text: "Enter Teaching Experience in previous position!",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });
        return false;
    }
    var focusid = '';
    $('#tbl_rese_publish tbody tr').each(function (i)
    {
        if (i > 0) {
            focusid = '';
            if (this.children[0].children[0].value == "")
            {
                focusid = this.children[0].children[0].id;
                respublishmessage = "Please Select PUBLICATION Type!";
                status_false = true;
                return false;
            }
            else if (this.children[1].children[0].value == "" && this.children[0].children[0].value != "101")
            {
                focusid = this.children[1].children[0].id;
                respublishmessage = "Please Enter Title of Research Article/Paper(s)/Books!";
                status_false = true;
                 return false;
            }
            else if (this.children[3].children[0].value == "" && this.children[0].children[0].value != "101")
            {
                focusid = this.children[3].children[0].id;
                respublishmessage = "Please Enter Publication Name of Journal/ Conference !";
                status_false = true;
                return false;
            }
            else if (this.children[4].children[0].value == "" && this.children[0].children[0].value != "101") {
                //alert(" Enter Whether Sole Author/ Co-author ");
                focusid = this.children[4].children[0].id;
                respublishmessage = "Please Select Publication National/International Conference Type  !";
                status_false = true;
                return false;
            }
            else if (this.children[6].children[0].value == "" && this.children[0].children[0].value != "101") {

                focusid = this.children[6].children[0].id;
                respublishmessage = "Please Enter Publication Whether/Sole Author/ Co-Author !";
                status_false = true;
                return false;
            }
        }
    });

    if (status_false == true)
    {
        //commentext(respublishmessage);
        commentext_focus(respublishmessage, focusid);
        return false;
    }
    $('#tbl_conferences_publish tbody tr').each(function (i) {
        if (i > 0) {

            if (this.children[1].children[0].value == "") {
                focusid = this.children[1].children[0].id;
                respublishmessage = "Please Select Conference Type ";
                status_false = true;
                return false;
            }
            
            else if (this.children[0].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                focusid = this.children[0].children[0].id;
                respublishmessage = "Please Enter Title of Research Article/Paper!";
                status_false = true;
                return false;
            }
            else if (this.children[2].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                focusid = this.children[2].children[0].id;
                respublishmessage = "Enter Name of Conference !";
                status_false = true;
                return false;
            }
            else if (this.children[3].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {
                focusid = this.children[3].children[0].id;
                respublishmessage = "Please Select National/ International Conference Type!";
                status_false = true;
                return false;

            }
            else if (this.children[4].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {
                focusid = this.children[4].children[0].id;
                respublishmessage = "Please Select Authorship !";
                status_false = true;
                return false;

            }
           
            else if (this.children[5].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                focusid = this.children[5].children[0].id;
                respublishmessage = "Please Enter Conference Start Date !";
                status_false = true;
                return false;
            }
            else if (this.children[6].children[0].value == "" && this.children[1].children[0].value != "NotApplicable")
            {
                focusid = this.children[6].children[0].id;
                respublishmessage = "Please Enter Conference End Date !";
                status_false = true;
                return false;
            }
            else if (this.children[7].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                //focusid = this.children[7].children[0].id;
                //respublishmessage = "Please Select Whether submitted to University/ Faculty  !";
                //status_false = true;
                //return false;
            }
        }
    });


    if (status_false == true) {
        //commentext(respublishmessage);
        commentext_focus(respublishmessage, focusid);
        return false;
    }


    $('#tbl_comp_ongoing_publish tbody tr').each(function (i) {
        if (i > 0) {

           if (this.children[1].children[0].value == "") {
                focusid = this.children[1].children[0].id;
                respublishmessage = "Please Select Completed/Ongoing Research Type !";
                status_false = true;
                return false;
            }
           else if (this.children[0].children[0].value == "" && this.children[1].children[0].value != "103") {
                focusid = this.children[0].children[0].id;
                respublishmessage = "Enter Title of Completed/Ongoing Research Projects !";
                status_false = true;
                return false;
            }
           else if (this.children[2].children[0].value == "" && this.children[1].children[0].value != "103")
            {
                focusid = this.children[2].children[0].id;
                respublishmessage = "Please Enter Completed/Ongoing Description !";
                status_false = true;
                return false;
            }
           else if (this.children[3].children[0].value == "" && this.children[1].children[0].value != "103")
            {
                focusid = this.children[3].children[0].id;
                respublishmessage = "Please Enter Funding Agency  !";
                status_false = true;
                return false;
                
            }
           else if (this.children[4].children[0].value == "" && this.children[1].children[0].value != "103") {

                focusid = this.children[4].children[0].id;
                respublishmessage = "Please Enter Completed/Ongoing Fund available !";
                status_false = true;
                return false;
            }
           else if (this.children[5].children[0].value == "" && this.children[1].children[0].value != "103") {
                focusid = this.children[5].children[0].id;
                respublishmessage = "Please Enter Completed/Ongoing Duration  !";
                status_false = true;
                return false;
            }
           else if (this.children[6].children[0].value == "" && this.children[1].children[0].value != "103") {
                focusid = this.children[6].children[0].id;
                respublishmessage = "Please Select Completed/Ongoing Status !";
                status_false = true;
                return false;
            }
           else if (this.children[7].children[0].value == "" && this.children[1].children[0].value != "103") {

                focusid = this.children[7].children[0].id;
                respublishmessage = "Please Enter Completed/Ongoing Start Date !";
                status_false = true;
                return false;
            }
           else if (this.children[8].children[0].value == "" && this.children[1].children[0].value != "103") {
                if (this.children[6].children[0].value != "ongoing") {

                    focusid = this.children[8].children[0].id;
                    respublishmessage = "Please Enter Completed/Ongoing End Date !";
                    status_false = true;
                    return false;
                }
            }


        }
    });

    if (status_false == true) {
        //commentext(respublishmessage);

        commentext_focus(respublishmessage, focusid);
        return false;
    }
    if ($('#txt_res_com_ongoing').val() == "") {
        //alert(" Enter Details of Completed/Ongoing Research Projects Hours");
        Swal.fire({
            text: "Enter Details of Completed/Ongoing Research Projects Hours!",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });

        status_false = true;
        return false;
    }



    $('#tbl_other_activity tbody tr').each(function (i) {
        if (i > 0) {

            if (this.children[1].children[0].value == "") {
                focusid = this.children[1].children[0].id;
                respublishmessage = "Plese Select Type of Any other research activities/recognition/awards !";
                status_false = true;
                return false;
            }
            else if (this.children[0].children[0].value == "" && this.children[1].children[0].value != "104") {

                focusid = this.children[0].children[0].id;
                respublishmessage = " Plese Enter Title of Any other research activities/recognition/awards !"; 
                status_false = true;
                return false;
            }
            else if (this.children[2].children[0].value == "" && this.children[1].children[0].value != "104") {
                focusid = this.children[2].children[0].id;
                respublishmessage = "Plese Enter Description  of Any other research activities/recognition/awards !";
                status_false = true;
                return false;
            }
            else if (this.children[3].children[0].value == "" && this.children[1].children[0].value != "104") {
                focusid = this.children[3].children[0].id;
                respublishmessage = "Plese Enter Date of Any other research activities/recognition/awards !";
                status_false = true;
                return false;

            }

        }
    });

    if (status_false == true) {
        commentext_focus(respublishmessage, focusid);
        //commentext(respublishmessage);
        return false;
    }

    if ($('#txt_other_activity').val() == "") {
        //alert(" Enter Details of Completed/Ongoing Research Projects Hours");
        Swal.fire({
            text: "Please Enter Any other research activities/recognition/awards mention total hours spent on Research !",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });

        status_false = true;
        return false;
    }


    $('#tbl_various_activity_publish tbody tr').each(function (i) {
        if (i > 0) {


            if (this.children[0].children[0].value == "") {

                focusid = this.children[0].children[0].id;
                respublishmessage = "Plese Select Type of Various Activities !";
                status_false = true;
                return false;
            }
            
            else if (this.children[1].children[0].value == "" && this.children[0].children[0].value != "NotApplicable")
            {

                focusid = this.children[1].children[0].id;
                respublishmessage = "Plese Enter List the various activities such as Review / Juries (in CEPT & with others) !";
                status_false = true;
                return false;
            }
            else if (this.children[3].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {

                focusid = this.children[3].children[0].id;
                respublishmessage = "Please Select Your role in the activity (Individual or as a team member) !";
                status_false = true;
                return false;
            }

            else if (this.children[4].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {

                focusid = this.children[4].children[0].id;
                respublishmessage = "Please Select Various Activities Status !";
                status_false = true;
                return false;
            }

            else if (this.children[5].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {
                focusid = this.children[5].children[0].id;
                respublishmessage = "Please Enter Various Activities Start Date !";
                status_false = true;
                return false;
            }

            else if (this.children[6].children[0].value == "" && this.children[0].children[0].value != "NotApplicable")
            {
                if (this.children[4].children[0].value != "InProcess")
                {
                    focusid = this.children[4].children[0].id;
                    respublishmessage = "Please Enter Various Activities End Date !";
                    status_false = true;
                    return false;
                }
            }
        }
    });


    if (status_false == true) {
        commentext_focus(respublishmessage, focusid);
        //commentext(respublishmessage);
        return false;
    }

    if ($('#txt_various_activity').val() == "") {
        // alert(" Enter Various Activities Hours");
        Swal.fire({
            text: "Enter Various Activities Hours !",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });
        status_false = true;
        return false;
    }


    $('#tbl_professional_activity_publish tbody tr').each(function (i) {
        if (i > 0) {


            if (this.children[0].children[0].value == "") {
                //  alert(" Select List the details of various professional development training programmes ");
                focusid = this.children[0].children[0].id;
                respublishmessage = " Please Select Type of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }
            else if (this.children[1].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {

                focusid = this.children[1].children[0].id;
                respublishmessage = "Please Enter Title of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }
            else if (this.children[2].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {

                focusid = this.children[2].children[0].id;
                respublishmessage = "Please Enter Description of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }
            else if (this.children[3].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {
                // alert(" Enter Organizers");
                focusid = this.children[3].children[0].id;
                respublishmessage = "Please Enter Duration of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }
            else if (this.children[4].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {
                //  alert(" Enter Number of participants");
                focusid = this.children[4].children[0].id;
                respublishmessage = "Please Enter Start Date of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }

            else if (this.children[5].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {

                focusid = this.children[5].children[0].id;
                respublishmessage = "Please Enter End Date of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }

            else if (this.children[6].children[0].value == "" && this.children[0].children[0].value != "NotApplicable")
            {
                focusid = this.children[6].children[0].id;
                respublishmessage = "Please Enter Organizers  of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }
            else if (this.children[7].children[0].value == "" && this.children[0].children[0].value != "NotApplicable") {
                focusid = this.children[7].children[0].id;
                respublishmessage = "Please Enter Number of participants of Details of Professional Development Training programs offered !";
                status_false = true;
                return false;
            }



        }
    });

    if (status_false == true) {
        commentext_focus(respublishmessage, focusid);
       // commentext(respublishmessage);
        return false;
    }

    if ($('#txt_profess_activity').val() == "") {
        //  alert(" Enter Professional Development Training Hours");

        Swal.fire({
            text: "Enter Professional Development Training Hours !",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });
        status_false = true;
        return false;
    }


    $('#tbl_Institutional_activity_publish tbody tr').each(function (i) {
        if (i > 0) {

            if (this.children[1].children[0].value == "") {
                // alert(" Select Institutional/Administrative Work During Status ");
                focusid = this.children[1].children[0].id;
                respublishmessage = " Please Select Type of Institutional/Administrative Work Assigned/Undertaken !";
                status_false = true;
                return false;


            }
            else if (this.children[0].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                focusid = this.children[0].children[0].id;
                respublishmessage = " Please Enter Title of Institutional/Administrative Work Assigned/Undertaken !";
                status_false = true;
                return false;
            }
            else if (this.children[2].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                focusid = this.children[2].children[0].id;
                respublishmessage = " Please Enter Administrative Work Assigned/Undertaken !";
                status_false = true;
                return false;
            }
            else if (this.children[3].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                focusid = this.children[3].children[0].id;
                respublishmessage = " Please Select Status of Institutional/Administrative Work Assigned/Undertaken  !";
                status_false = true;
                return false;
            }

            else if (this.children[6].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {

                focusid = this.children[6].children[0].id;
                respublishmessage = "Please Enter Duration of Institutional/Administrative Work Assigned/Undertaken !";
                status_false = true;
                return false;
            }
            else if (this.children[4].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {
                focusid = this.children[4].children[0].id;
                respublishmessage = "Please Enter Start Date of Institutional/Administrative Work Assigned/Undertaken !";
                status_false = true;
                return false;
            }

            else if (this.children[5].children[0].value == "") {

                if (this.children[3].children[0].value != "InProcess" && this.children[1].children[0].value != "NotApplicable") {
                    focusid = this.children[3].children[0].id;
                    respublishmessage = "Please Enter End Date of Institutional/Administrative Work Assigned/Undertaken !";
                    status_false = true;
                    return false;
                }
            }

            
            

        }
    });

    if (status_false == true) {
        commentext_focus(respublishmessage, focusid);
       // commentext(respublishmessage);
        return false;
    }


    $('#tbl_skill_activity_publish tbody tr').each(function (i) {
        if (i > 0) {

            if (this.children[1].children[0].value == "") {
                //alert(" Enter List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill");
                focusid = this.children[1].children[0].id;
                respublishmessage = "Please Select Type of List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill !";
                status_false = true;
                return false;
            }
            else if (this.children[0].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {
                //alert(" Enter List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill");
                focusid = this.children[0].children[0].id;
                respublishmessage = "Please Enter Title of List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill !";
                status_false = true;
                return false;
            }
            else if (this.children[2].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {
                //alert(" Enter List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill");
                focusid = this.children[2].children[0].id;
                respublishmessage = "Please Enter List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill !";
                status_false = true;
                return false;
            }
            else if (this.children[3].children[0].value == "" && this.children[1].children[0].value != "NotApplicable") {
                //alert(" Enter List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill");
                focusid = this.children[3].children[0].id;
                respublishmessage = "Please Enter Date of List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill !";
                status_false = true;
                return false;
            }
            else if (this.children[4].children[0].value == "" && this.children[1].children[0].value != "NotApplicable")
            {
                focusid = this.children[4].children[0].id;
                respublishmessage = "Please Enter Organizer of List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill !";
                status_false = true;
                return false;
            }
            else if (this.children[5].children[0].value == "" && this.children[1].children[0].value != "NotApplicable")
            {
                focusid = this.children[5].children[0].id;
                respublishmessage = "Please Enter Date of List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill !";
                status_false = true;
                return false;
            }


        }
    });

    if (status_false == true) {
        //commentext(respublishmessage);
        commentext_focus(respublishmessage, focusid);
        return false;
    }
    if ($('#txt_trainings_activity').val() == "") {
        
        Swal.fire({
            text: "Enter List any Trainings Programs Attended Hours !",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });

        status_false = true;
        return false;
    }


    $('#tbl_facilitating_activity_publish tbody tr').each(function (i) {
        if (i > 0) {


            if (this.children[0].children[0].value == "") {
                //alert(" Enter Mention facilitating (favourable) factors pertaining to your Role");
                respublishmessage = "Enter Mention facilitating (favourable) factors pertaining to your Role !";
                status_false = true;
                return false;
            }


        }
    });



    if (status_false == true) {
        commentext(respublishmessage);
        return false;
    }


    $('#tbl_Inhibiting_activity_publish tbody tr').each(function (i) {
        if (i > 0) {

            if (this.children[0].children[0].value == "") {
                // alert("Enter Mention inhibiting (unfavorable) factors pertaining to your role");

                respublishmessage = "Enter Mention inhibiting (unfavorable) factors pertaining to your role !";
                status_false = true;
                return false;
                
            }


        }
    });

    var fileupload_1 = true;
    var fileupload_2 = true;
    var fileupload_3 = true;
    var fileupload_4 = true;
    $('#tbl_self_evaluation_upload_doc_dtl tbody tr').each(function (i) {
        const inputVal = $(this).find('td:eq(0)').text();

        if (inputVal === "" && i === 0) {
            respublishmessage = "Please Upload Self-Evaluation !";
            status_false = true;
            fileupload_1 = true;
            return false;
        }

        else if (inputVal === "" && i === 1) {
            respublishmessage = "Please Upload Actual AWP (Annual work plan -2024-2025) !";
            status_false = true;
            fileupload_2 = true;
            return false;
        }

        else if (inputVal === "" && i === 2) {
            respublishmessage = "Please Upload Proposed AWP (Annual work plan - 2025-2026) !";
            status_false = true;
            fileupload_3 = true;
            return false;
        }
        else if (inputVal === "" && i === 3) {
            respublishmessage = "Please Upload Certificate !";
            status_false = true;
            fileupload_4 = true;
            return false;
        }
        else {
            if (i === 0) {
                fileupload_1 = false;
            }
            if (i === 1) {
                fileupload_2 = false;
            }
            if (i === 2) {
                fileupload_3 = false;
            }
            if (i === 3) {
                fileupload_4 = false;
            }

        }
    });

    if (fileupload_1) {
        respublishmessage = "Please Upload Self-Evaluation !";
        status_false = true;

    }
    else if (fileupload_2) {
        respublishmessage = "Please Upload Actual AWP (Annual work plan -2024-2025) !";
        status_false = true;

    }
    else if (fileupload_3) {
        respublishmessage = "Please Upload Proposed AWP (Annual work plan - 2025-2026) !";
        status_false = true;

    }
    else if (fileupload_4) {
        //respublishmessage = "Please Upload Certificate !";
        status_false = false;

    }

    if (status_false == true) {
        commentext(respublishmessage);
        return false;
    }

    $('#tbl_training_activity_publish tbody tr').each(function (i) {
        if (i > 0) {
            if (this.children[0].children[0].value == "") {

                respublishmessage = "Enter List any trainings required to update/enhance your knowledge/ skill set !";
                status_false = true;
                return false;
                
            }


        }
    });

    if (status_false == true) {
        commentext(respublishmessage);
        return false;
    }
    if ($('#txt_Institutional_activity').val() == "") {
       // alert(" Enter Institutional/Administrative Work During Hours");
        Swal.fire({
            text: "Enter Institutional/Administrative Work During Hours !",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });
        status_false = true;
        return false;
    }

    if ($('#txt_res_conferences_year').val() == "") {
        //alert(" Enter Details of Completed/Ongoing Research Projects Hours");
        Swal.fire({
            text: "Please Mention The Total Hours Spent on This Activity!",
            icon: "info",
            buttonsStyling: false,
            confirmButtonText: "Ok, got it!",
            customClass: {
                confirmButton: "btn btn-primary"
            }
        });

        status_false = true;
        return false;
    }
    

    if (status_false)
    {
        return false;
    }

    return true;
}
function IsNumeric_dtl(e) {
    var keyCode = e.which ? e.which : e.keyCode;
    console.log(e.keyCode)
    if ((e.keyCode >= 48 && e.keyCode <= 57) || (e.keyCode >= 96 && e.keyCode <= 105)) {
        //if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

   // if (keyCode >= 48 && keyCode <= 57) {
   //     return true;
   // }
    else {
        return false;
    }

}
function IsNumeric(e)
{
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9)
    {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57)
    {
        return true;
    }
    else {
        return false;
    }
}

function commentext(respublishmessage)
{
    Swal.fire({
        text: respublishmessage,
        width: 400,
        icon: "info",
        buttonsStyling: false,
        confirmButtonText: "Ok, got it!",
        customClass: {
            confirmButton: "btn btn-primary"
        }
    });
    status_false = false;
    return false;
}
function commentext_focus(respublishmessage, target) {
    Swal.fire({
        text: respublishmessage,
        width: 400,
        icon: "info",
        buttonsStyling: false,
        confirmButtonText: "Ok, got it!",
        customClass: {
            confirmButton: "btn btn-primary"
        }
    }).then((result) => {
        if (result.isConfirmed)
        {
            focusAndApplyRedBorder(target);
        }
    });
    status_false = false;
    return false;
}


function focusAndApplyRedBorder(dropdownId) {
    let dropdown = document.getElementById(dropdownId);
    if (dropdown) {
        
        dropdown.focus();
        setTimeout(() => {
            dropdown.blur(); // Remove focus after the specified duration
        }, 5000);
        
    } else {
        console.error('Dropdown with ID', dropdownId, 'not found.');
    }
}
let isBootboxOpen = false;
$(document).on('click', '.remove-subrow', function (e) {
   // e.preventDefault();

    if (isBootboxOpen) return;
    isBootboxOpen = true;

    const $row = $(this).closest('tr');

    bootbox.confirm({
        title: "Confirm Deletion",
        message: "Are you sure you want to delete this row?",
        buttons: {
            confirm: {
                label: 'Yes',
                className: 'btn-danger'
            },
            cancel: {
                label: 'No',
                className: 'btn-secondary'
            }
        },
        callback: function (result) {
            if (result)
            {
                $row.remove();
            }
            isBootboxOpen = false; // Reset the lock after dialog is closed
        }
    });
});