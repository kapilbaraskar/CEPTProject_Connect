var action = 'S';
var is_data_found = false;
var pattern = /^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/;
//var pattern = /^([0-9]|[012][0-9]|3[01])\/([0-9]|0[0-9]|1[0-2])\/([0-9]{4})$/
var user_temp = false;
var block = false;


$(document).ready(function () {
    var message_type = $('#hdn_message').val();
    if (message_type != '') {
        bootbox.alert(message_type , function () {
            location.reload();

        //    window.location = "ws_coursemaster_add.aspx?sws=true";
            //location.reload();
        });
        //bootbox.alert(message_type);
        
        
    }

    var type = getParameterByName('type');
    //var types = getParameterByName('ic');
    var types = getParameterByName('ws');
    var types_ = getParameterByName('ie');

    if (type == "tutor") {
        $("#for_I2").css("display", "");
    }
    else {
        $("#for_other").css("display", "");
    }
  

    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

   // if ($('#hdnusertype').val() == 'FA') {
   //     var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
   //         "<i class='icon-save bigger-160'></i>Save</button></td> " +
   //         "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
   //         "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
   //     $('#submitBtnDiv').html(str);
   // }

  
    disable_user();
    if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC') {

        var str = "";

        //if ($('#hdn_icode_ex').val() != "") {
        //    str = "<table style='width: 100%'><tr><td align='center' style='width: 40%;'> "
        //        + "<button id = 'btnsave' type = 'button' style='display:block; margin-right: -75%;' class='btn btn-primary'>"
        //        + "<i class='icon-save bigger-160' ></i> Save</button ></td > <td align='' style='width: 20%;'> <button id = 'btnapprove' type = 'button' style='display:block; float: center;' class='btn btn-primary'>"
        //        + "<i class='icon-save bigger-160'></i>Submit</button></td><td align='center' style='width: 40%;'><button id = 'btnnext_ext' type = 'button' style='margin-left:-136%;' class='btn btn-primary'>"
        //        + " Step 2 >></button ></td ></tr ></table > ";
        //
        //}
        //else {

        str = "<table style='width: 100%'><tr><td align='center' style='width: 15%;'> "
            + "<button id = 'btnsave' type = 'button' style='display:block; margin-right: -75%;' class='btn btn-primary'>"
            + "<i class='icon-save bigger-160' ></i> Save</button ></td > <td align='' style='width: 20%;'> <button id = 'btnapprove' type = 'button' style='display:block; float: center;' class='btn btn-primary'>"
            + "<i class='icon-save bigger-160'></i>Step 2 >></button></td></tr ></table >";
               // + "<td align='center' style='width: 40%; display:none;'><button id = 'next_step' type = 'button' style='margin-left:-136%;' class='btn btn-primary'>"
               // + " Step 2 >></button ></td ></tr ></table > ";

       // }

        $('#submitBtnDiv').html(str);
    }

    if ($('#hdnusertype').val() == 'HR' || $('#hdnusertype').val() == 'A') {
        var str = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
        $('#div_filter_criteria').css('display', 'block');
    }

    var str_drp_associate_html = "<option value=''>-- Associated Since --</option>";
    var cur_date = new Date();
    for (i = cur_date.getFullYear(); i >= 1962; i--) {
        str_drp_associate_html = str_drp_associate_html + "<option value='" + i + "'>" + i + "</option>";
    }
    $('#txt_associated_with_cept_since').html(str_drp_associate_html);

    $('#txt_dob').datepicker({ dateFormat: 'dd/mm/yy' });
    $('#txt_date_of_issuance_certificate').datepicker({ dateFormat: 'dd/mm/yy' });
    $('#txt_work_start_date').datepicker({ dateFormat: 'dd/mm/yy' });
    $('#txt_work_end_date').datepicker({ dateFormat: 'dd/mm/yy' });
    $('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });

    $('#drp_title').chosen();
    $('#txt_highest_qualification').chosen();
    $('#txt_blood_group').chosen();
    $('#txt_associated_with_cept_since').chosen();

    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC') {
        $('.cls_mendatory').css('display', 'inline-block');
    }

    $('#txt_first_name').focusout(function () {
        $('#txt_first_name').val($('#txt_first_name').val()[0].toUpperCase() + $('#txt_first_name').val().toLowerCase().substr(1));
    });

    $('#txt_last_name').focusout(function () {
        $('#txt_last_name').val($('#txt_last_name').val()[0].toUpperCase() + $('#txt_last_name').val().toLowerCase().substr(1));
    });

    
    function call_for_studio_status_track() {
        $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/call_for_studio_status_track",
                //async: false,
                data: "{studio_code:''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        var track_call_for_studio = JSON.parse(data.d);
                        //if (track_call_for_studio[0]["value"] == "Y") {
                        //    $("#btnnext").css('display', '');
                        //    $("#pd").css('background-color', 'white');
                        //} else {
                        //    block = true;
                        //    $("#pd").css('background-color', 'white');
                        //    $("#ip").addClass("inactive");
                        //    $("#ip").removeClass("active");
                        //    $("#sd").addClass("inactive");
                        //    $("#sd").removeClass("active");
                        //}
                        //if (track_call_for_studio[1]["value"] == "Y") {
                        //    $("#btnnext").css('display', '');
                        //    $("#ip").css('background-color', 'white');
                        //} else {
                        //    $("#ip").css('background-color', 'grey');
                        //}
                        if (track_call_for_studio[2]["value"] == "Y") {
                            $("#sd").css('background-color', 'white');
                        } else {
                            $("#sd").css('background-color', 'grey');
                        }
                        if (track_call_for_studio[3]["value"] == "Y") {
                            $("#bank_tutor").css('background-color', 'white');
                        } else {
                            $("#bank_tutor").css('background-color', 'grey');
                        }
                        if (track_call_for_studio[4]["value"] == "Y") {
                            block = false;
                            $("#btnnext").css('display', '');
                        }
                    }
                    else {
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        return false;
    }

    $('#btnapprove').on('click', function () {
        debugger;
        if ($('#hdn_skip_personaldtl').val() == 'true')
        {
            var url = "ws_coursemaster_add.aspx?sws=true";
            window.open(url, "_self");
            
        }

        if (!is_data_found) {
            bootbox.alert('No Instructor to update');
            action = 'S';
            return false;
        }
        if ($('#hdn_status').val() == "false") {

        
        if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC') {
            if ($('#hdn_icode').val() == '') {
                bootbox.alert('No Instructor to update');
                action = 'S';
                return false;
            }
        }

        if ($('#drp_title').val() == '') {
            bootbox.alert('Please Enter Title');
            return false;
        }

        if ($('#txt_first_name').val() == '') {
            bootbox.alert('Please Enter First Name');
            return false;
        }

        if ($('#txt_last_name').val() == '') {
            bootbox.alert('Please Enter Last Name');
            return false;
        }

        if ($('#txt_email').val() == '') {
            bootbox.alert('Please Enter Email');
            return false;
        }

        if ($('#txt_mobile_no').val() == '') {
            bootbox.alert('Please Enter Mobile No');
            return false;
        }

        if ($('#txt_dob').val() == '') {
            bootbox.alert('Please Enter Date of Birth');
            return false;
        }

        if ($('#txt_highest_qualification').val() == '') {
            bootbox.alert('Please Enter Highest qualification');
            return false;
        }

        if ($('#txt_total_experiance').val() == '') {
            bootbox.alert('Please Enter Total Experiance');
            return false;
        }
        //changes 17052022
        if ($('#txt_total_experiance_months').val() == '') {
            bootbox.alert('Please Select Months In Total Experiance');
            return false;
        }

        if ($('#txt_address').val() == '') {
            bootbox.alert('Please Enter Address');
            return false;
        }
        // Add City State Country 18022021 NitinBhai
        if ($('#txt_city').val() == '') {
            bootbox.alert('Please Enter City');
            return false;
        }

        if ($('#txt_state').val() == '') {
            bootbox.alert('Please Enter State');
            return false;
        }

        if ($('#txt_country').val() == '') {
            bootbox.alert('Please Enter Country');
            return false;
        }

        if ($('#drp_gender').val() == '') {
            bootbox.alert('Please Select Gender');
            return false;
        }

        //if ($('#txt_last_name').val() == '') {
        //    bootbox.alert('Please Enter Last Name');
        //    return false;
        //}


        //        if ($('#txt_dob').val() != '') {
        //            if ($('#txt_dob').val().length != 10) {
        //                bootbox.alert('Please Enter Date of Birth in DD/MM/YYYY format');
        //                action = 'S';
        //                return false;
        //            }

        //            if ($('#txt_dob').val().split('/').length != 3) {
        //                bootbox.alert('Please Enter Date of Birth in DD/MM/YYYY format');
        //                action = 'S';
        //                return false;
        //            }

        //            if ($('#txt_dob').val().split('/')[1] > 12) {
        //                bootbox.alert('Please Enter Date of Birth in DD/MM/YYYY format');
        //                action = 'S';
        //                return false;
        //            }
        //        }

        if ($('#txt_dob').val() != '') {
            if (!pattern.test($('#txt_dob').val())) {
                bootbox.alert('Please Enter Date of Birth in DD/MM/YYYY format');
                action = 'S';
                return false;
            }
            if ($('#txt_dob').val().split('/')[1] > 12) {
                bootbox.alert('Please Enter Date of Birth in DD/MM/YYYY format');
                action = 'S';
                return false;
            }
        }

            if ($('#hdn_designation').val().trim().toLowerCase() == "instructor") {
                user_temp = true;
            }

        if (!user_temp) {

            //if ($('#txt_passport_no').val() == '') {
            //    bootbox.alert('Please Enter Passport no');
            //    return false;
            //}

            //if ($('#txt_aadhaar_no').val() == '') {
            //    bootbox.alert('Please Enter Aadhaar no');
            //    return false;
            //}
           //kapil 02092021
           if ($('#txt_pan_card_no').val() == '') {
               bootbox.alert('Please Enter PAN card no');
               return false;
           }

            if ($('#txt_bank_account_no').val() == '') {
                bootbox.alert('Please Enter Bank account no');
                return false;
            }

            if ($('#txt_account_type').val() == '') {
                bootbox.alert('Please Enter Account type');
                return false;
            }

            if ($('#txt_name_of_the_bank').val() == '') {
                bootbox.alert('Please Enter name of the Bank');
                return false;
            }

            if ($('#txt_branch_name').val() == '') {
                bootbox.alert('Please Enter Branch name');
                return false;
            }

            if ($('#txt_ifsc_code').val() == '') {
                bootbox.alert('Please Enter IFSC code');
                return false;
            }
            else if ($('#txt_ifsc_code').val().length < 11) {
                bootbox.alert('IFSC code must have 11 characters');
                return false;
            }

            if ($('#txt_benificiary_name').val() == '') {
                bootbox.alert('Please Enter Benificiary name');
                return false;
            }

            if ($('#txt_benificiary_name').val() == '') {
                bootbox.alert('Please Enter Benificiary name');
                return false;
            }
        }

        if (FileName == '') {
            bootbox.alert('Please Upload CV');
            return false;
        }
        //if ($('#hdnusertype').val() == 'I2') {
        //    if (FileName == '') {
        //        bootbox.alert('Please Upload CV');
        //        return false;
        //    }
        //
        //    if (FileNameforPort == '') {
        //        bootbox.alert('Please Upload Portfolio');
        //        return false;
        //    }
        //}

        //if ($("#ICN").is(":checked") == $("#ICY").is(":checked"))
        //{
        //   // bootbox.alert('Please Select - Are you a Citizen of India?');
        //   // return false;
        //}
        }
        action = 'A';//A 09 09 2020

        $('#btnsave').click();
    });

    $('.cls_date').on('change', function () {

        var clasname = $(this)[0].className;
        if (clasname.includes("start_date")) {
            if ($(this).parent().parent().find('.end_date').val() != "") {
                var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
            }
        } else if (clasname.includes("end_date")) {
            if ($(this).parent().parent().find('.start_date').val() != "") {
                var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
            }
        }
    });

    $('#drp_instructor_code').on('change', function () {
        $('#drp_instructor_name').val('');
        $('#drp_instructor_name').trigger("liszt:updated");
    });

    $('#drp_instructor_name').on('change', function () {
        $('#drp_instructor_code').val('');
        $('#drp_instructor_code').trigger("liszt:updated");
    });

    $('#btnnext').on('click', function () {
        $('#btnapprove').click();
        var url = "Interested_Program.aspx";
        window.open(url, "_self");
    });
    $('#next_step').on('click', function () {
        $('#btnapprove').click();
        var url = "ws_coursemaster_add.aspx?sws=true";
        window.open(url, "_self");
    });

    $('#btnsave').on('click', function () {

        //if ($("input[name='indian_citizen']:checked").val() == undefined) {
        //    bootbox.alert('Please Select - Are you a Citizen of India?');
        //    action = 'S';
        //    return false;
        //}
      
            if ($("input[name='ind_bank_account']:checked").val() == undefined) {
                bootbox.alert('Please Select - Do you have a Bank Account as an Indian Citizen (Not as NRI or OIC)');
                action = 'S';
                return false;
            }
       



       // var instructor_data = { 'instructor_code': '', 'VF_code': '', 'first_name': '', 'last_name': '', 'title': '', 'mail': '', 'mobile_no': '', 'phone_no': '', 'blood_group': '', 'pan_card_no': '', 'bank_account_number': '', 'account_type': '', 'name_of_Bank': '', 'branch_name': '', 'ifsc_code': '', 'benificiary_name': '', 'dob': '', 'highest_qualification': '', 'total_experiance': '', 'associated_with_cept_since': '', 'address': '', 'emergency_contact_name': '', 'emergency_contact_number': '', 'degree': '', 'specialization': '', 'university': '', 'date_of_issuance_certificate': '', 'work_designation': '', 'work_institute': '', 'work_start_date': '', 'work_end_date': '', 'achievements': '', 'area_of_interest': '', 'cv_file_name': '', 'image_path': '', 'gst_number': '', 'coa_registration_no': '', 'gender': '', 'edu_work_description': '', 'city': '', 'state': '', 'country': '' };
        var instructor_data = {
            'instructor_code': '', 'VF_code': '', 'first_name': '', 'last_name': '', 'title': '', 'mail': '', 'mobile_no': '', 'phone_no': '', 'blood_group': '', 'pan_card_no': '', 'bank_account_number': '', 'account_type': '',
            'name_of_Bank': '', 'branch_name': '', 'ifsc_code': '', 'benificiary_name': '', 'dob': '', 'highest_qualification': '', 'total_experiance': '', 'total_experiance_months': '', 'associated_with_cept_since': '', 'address': '', 'emergency_contact_name': '',
            'emergency_contact_number': '', 'degree': '', 'specialization': '', 'university': '', 'date_of_issuance_certificate': '', 'work_designation': '', 'work_institute': '', 'work_start_date': '', 'work_end_date': '', 'achievements': '',
            'area_of_interest': '', 'cv_file_name': '', 'image_path': '', 'gst_number': '', 'coa_registration_no': '', 'gender': '', 'edu_work_description': '', 'city': '', 'state': '', 'country': '', 'passport_doc': '', 'oci_card_status': '', 'oci_card_doc': '',
            'permanent_address': '', 'aadhaar_doc': '', 'coa_doc': '',
            'crdf_status': '', 'crdf_code': '', 'crdf_engagment_status': '', 'crdf_nature_engagment': '', 'crdf_from_date': '', 'crdf_to_date': '', 'crdf_hours': '', 'crdf_name_of_center': '', 'crdf_reporting_to': '', 'question_status': '', 'oci_country_status': ''
        };
        instructor_data.instructor_code = $('#hdn_icode').val();


        instructor_data.VF_code = $('#txt_vf_code').val();
        instructor_data.first_name = $('#txt_first_name').val();
        instructor_data.last_name = $('#txt_last_name').val();
        instructor_data.title = $('#drp_title').val();
        instructor_data.mail = $('#txt_email').val();
        instructor_data.mobile_no = $('#txt_mobile_no').val();
        instructor_data.phone_no = $('#txt_alternate_contact_no').val();
        instructor_data.blood_group = $('#txt_blood_group').val();
        instructor_data.pan_card_no = $('#txt_pan_card_no').val();
        instructor_data.passport_no = $('#txt_passport_no').val();
        instructor_data.aadhaar_no = $('#txt_aadhaar_no').val();
        instructor_data.bank_account_number = $('#txt_bank_account_no').val();
        instructor_data.account_type = $('#txt_account_type').val();
        instructor_data.name_of_Bank = $('#txt_name_of_the_bank').val();
        instructor_data.branch_name = $('#txt_branch_name').val();
        instructor_data.ifsc_code = $('#txt_ifsc_code').val();
        instructor_data.benificiary_name = $('#txt_benificiary_name').val();
        //kapil08062020

        instructor_data.gst_number = $('#txt_gst_no').val();
        if (action == "A")
            instructor_data.is_submit = "Y";
        else
            instructor_data.is_submit = "N";
        instructor_data.coa_registration_no = $('#txt_coa_reg_no').val();
        instructor_data.gender = $('#drp_gender').val();
        instructor_data.edu_work_description = $('#txt_eduction_dtl').val();
        if (instructor_data.edu_work_description.search(/\\/) != -1) { instructor_data.edu_work_description = instructor_data.edu_work_description.replace(/\\/g, '\\\\'); }
        if (instructor_data.edu_work_description.search("\"") != -1) { instructor_data.edu_work_description = instructor_data.edu_work_description.replace(/"/g, '\\\"'); }
        //End

        if ($('#txt_dob').val() != '') {
            var str_dob = $('#txt_dob').val().split('/');
            instructor_data.dob = str_dob[1] + '/' + str_dob[0] + '/' + str_dob[2];
        }

        instructor_data.highest_qualification = $('#txt_highest_qualification').val();
        instructor_data.total_experiance = $('#txt_total_experiance').val();
        instructor_data.total_experiance_months = $('#txt_total_experiance_months').val();
        instructor_data.total_teaching_experiance = $('#txt_total_teaching_experiance').val();
        instructor_data.total_research_experiance = '';//$('#txt_total_research_experiance').val();
        instructor_data.total_industry_experiance = '';//$('#txt_total_industry_experiance').val();
        instructor_data.associated_with_cept_since = $('#txt_associated_with_cept_since').val();
        //instructor_data.indian_citizen = $("input[name='indian_citizen']:checked").val();
        instructor_data.indian_citizen = $('#txt_country_dtl').val();
        country_value = '';
        instructor_data.ind_bank_account = $("input[name='ind_bank_account']:checked").val();
        instructor_data.address = replace_special_char($('#txt_address').val());
        instructor_data.emergency_contact_name = $('#txt_emergency_contact_name').val();
        instructor_data.emergency_contact_number = $('#txt_emergency_contact_no').val();

        //Add City state country 18022021
        instructor_data.city = $('#txt_city').val();
        instructor_data.state = $('#txt_state').val();
        instructor_data.country = $('#txt_country').val();

        //        instructor_data.degree = $('#txt_degree').val();
        //        instructor_data.specialization = $('#txt_specialization').val();
        //        instructor_data.university = $('#txt_university').val();
        //        instructor_data.date_of_issuance_certificate = $('#txt_date_of_issuance_certificate').val();

        //        instructor_data.work_designation = $('#txt_work_designation').val();
        //        instructor_data.work_institute = $('#txt_work_institute').val();
        //        instructor_data.work_start_date = $('#txt_work_start_date').val();
        //        instructor_data.work_end_date = $('#txt_work_end_date').val();

        instructor_data.achievements = replace_special_char($('#txt_achievements').val());

        instructor_data.area_of_interest = replace_special_char($('#txt_area_of_interest').val());

        instructor_data.cv_file_name = FileName;

        instructor_data.portfolio_file_name = FileNameforPort;

        if ($('#lbl_image_name').text().trim() != "") {
            instructor_data.image_path = $('#lbl_image_name').text();
        }

        var reference_dtl = [];
        var check_reference_data = true;

        $('#tbl_reference tbody tr').each(function (i) {
            if (i > 0) {

                var reference_row = { 'sr_no': '', 'name': '', 'mobile_no': '', 'email_id': '' };

                reference_row.sr_no = i;
                reference_row.name = replace_special_char(this.children[0].children[0].value);
                reference_row.mobile_no = replace_special_char(this.children[1].children[0].value);
                reference_row.email_id = replace_special_char(this.children[2].children[0].value);
                if (reference_row.name != '' || reference_row.mobile_no != '' || reference_row.email_id != '') {
                    check_reference_data = false;
                    reference_dtl.push(reference_row);
                }
            }
        });
        //kapil 02092021
        //if (check_reference_data && action == "A" && $('#hdnusertype').val() == 'I2') {
        //    bootbox.alert('Please Enter Reference Details');
        //    action = 'S';
        //    return false;
        //}
        //
        //if (reference_dtl.length < 3 && action == "A" && $('#hdnusertype').val() == 'I2') {
        //    bootbox.alert('Please Enter Minimum 3 Reference Details');
        //    action = 'S';
        //    return false;
        //}

        var education_dtl = [];
        var wrong_date_of_issuance_certificate = false;
        var check_academic_data = true;

        $('#tbl_academic_qualification tbody tr').each(function (i) {
            if (i > 0) {

                var education_row = { 'sr_no': '', 'degree': '', 'specialization': '', 'university': '', 'date_of_issuance_certificate': '', 'edu_start_date': '', 'edu_end_date': '', 'edu_percentage': '', 'edu_mode': '' };
                //var education_row = { 'sr_no': '', 'degree': '', 'specialization': '', 'university': '', 'edu_start_date': '', 'edu_end_date': '', 'edu_percentage': '', 'edu_mode': '' };
                education_row.sr_no = i;
                education_row.degree = replace_special_char(this.children[0].children[0].value);
                education_row.specialization = replace_special_char(this.children[1].children[0].value);
                education_row.university = replace_special_char(this.children[2].children[0].value);

                if (this.children[3].children[0].value != '') {

                    if (!pattern.test(this.children[3].children[0].value)) {
                        wrong_date_of_issuance_certificate = true;
                    }
                    if (this.children[3].children[0].value.split('/')[1] > 12) {
                        wrong_date_of_issuance_certificate = true;
                    }

                    var str_date_of_issuance_certificate = this.children[3].children[0].value.split('/');
                    education_row.date_of_issuance_certificate = str_date_of_issuance_certificate[1] + '/' + str_date_of_issuance_certificate[0] + '/' + str_date_of_issuance_certificate[2];
                }

                if (education_row.degree != '' || education_row.specialization != '' || education_row.university != '' || education_row.date_of_issuance_certificate != '') {
                    check_academic_data = false;
                    education_dtl.push(education_row);
                }
            }
        });
        if ($('#hdn_status').val() == "false") { 
        if (check_academic_data && action == "A" && $('#hdnusertype').val() == 'I2') {
            bootbox.alert('Please Enter Academic Qualification Details');
            action = 'S';
            return false;
        }

        if (wrong_date_of_issuance_certificate && $('#hdnusertype').val() == 'I2') {
            bootbox.alert('Please Enter Date of issuance certificate in DD/MM/YYYY format');
            action = 'S';
            return false;
        }
        }
        //        if (action == 'A') {
        //            if (education_dtl.length <= 0) {
        //                action = 'S';
        //                bootbox.alert('Please Enter atleast one Education Detail');
        //                return false;
        //            }
        //        }

        var work_dtl = [];
        var wrong_work_start_date = false;
        var wrong_work_end_date = false;
        var check_work_exp_data = true;

        $('#tbl_work_experiance tbody tr').each(function (i) {
            if (i > 0) {


               var work_row = { 'sr_no': '', 'work_designation': '', 'work_institute': '', 'work_experience_type': '', 'work_start_date': '', 'work_end_date': '' };
                //var work_row = { 'sr_no': '', 'work_designation': '', 'work_institute': '', 'work_experience_type': '', 'work_start_date': '', 'work_end_date': '', 'work_experience_year': '', 'work_expe_total_month': '' };
                work_row.sr_no = i;
                work_row.work_designation = replace_special_char(this.children[1].children[0].value);
                work_row.work_institute = replace_special_char(this.children[0].children[0].value);
                work_row.work_experience_type = replace_special_char(this.children[2].children[0].value);
                work_row.work_experience_months = replace_special_char(this.children[5].children[0].value);

                if (this.children[3].children[0].value != '') {

                    if (!pattern.test(this.children[3].children[0].value)) {
                        wrong_work_start_date = true;
                    }
                    if (this.children[3].children[0].value.split('/')[1] > 12) {
                        wrong_work_start_date = true;
                    }

                    var str_work_start_date = this.children[3].children[0].value.split('/');
                    work_row.work_start_date = str_work_start_date[1] + '/' + str_work_start_date[0] + '/' + str_work_start_date[2];
                }

                if (this.children[4].children[0].value != '') {

                    if (!pattern.test(this.children[4].children[0].value)) {
                        wrong_work_end_date = true;
                    }
                    if (this.children[4].children[0].value.split('/')[1] > 12) {
                        wrong_work_end_date = true;
                    }

                    var str_work_end_date = this.children[4].children[0].value.split('/');
                    work_row.work_end_date = str_work_end_date[1] + '/' + str_work_end_date[0] + '/' + str_work_end_date[2];
                }

                if (work_row.work_designation != '' || work_row.work_institute != '' || work_row.work_experience_type != '' || work_row.work_start_date != '' || work_row.work_end_date != '') {
                    check_work_exp_data = false;
                    work_dtl.push(work_row);
                }
            }
        });
        if ($('#hdn_status').val() == "false") {
        if (check_work_exp_data && action == "A" && $('#hdnusertype').val() == 'I2') {
            bootbox.alert('Please Enter Work Experience Details');
            action = 'S';
            return false;
        }

        if (wrong_work_start_date) {
            bootbox.alert('Please Enter Work Start Date in DD/MM/YYYY format');
            action = 'S';
            return false;
        }

        if (wrong_work_end_date) {
            bootbox.alert('Please Enter Work End Date in DD/MM/YYYY format');
            action = 'S';
            return false;
        }
        }
        //        if (action == 'A') {
        //            if (work_dtl.length <= 0) {
        //                action = 'S';
        //                bootbox.alert('Please Enter atleast one Work Experiance Detail');
        //                return false;
        //            }
        //        }


        var All_instructor_data = [instructor_data, reference_dtl, education_dtl, work_dtl, action];
        var json_All_instructor_data = JSON.stringify(All_instructor_data);

        if (json_All_instructor_data.search("'") != -1) {
            json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
        }
       // json_All_instructor_data = '[{"instructor_code":"I1","VF_code":"I1","first_name":"Magjikondi","last_name":"Durgasha","title":"Mr.","mail":"AFS@GMAIL.COM","mobile_no":"9662062505","phone_no":"","blood_group":"O-","pan_card_no":"aaadafada","bank_account_number":"145254364644567","account_type":"Saving","name_of_Bank":"sdfsdfsdf","branch_name":"sdfsdf","ifsc_code":"sdf00112365","benificiary_name":"Nitin","dob":"03/20/1987","highest_qualification":"PG","total_experiance":"8","associated_with_cept_since":"","address":"D-37 JOGESHWARI BAUG SOCEITY JAYSHREE TENT PART 2 NR ARBUDANAGAR ROAD RAJENDRA PARKPARK ODHAV AHMEDA","emergency_contact_name":"","emergency_contact_number":"","degree":"","specialization":"","university":"","date_of_issuance_certificate":"","work_designation":"","work_institute":"","work_start_date":"","work_end_date":"","achievements":"I have got certificate for the appreciation regarding the providing the IT Support in Code for Gujarat. I have also participate into the Smart India Hackathon 2018 and 2019.","area_of_interest":"Project Management, IT Services.","cv_file_name":"I1_Cv&amp;portfolio.pdf","image_path":"","gst_number":"","coa_registration_no":"","gender":"M","edu_work_description":"Master of Computer Application, I have worked more than 8 years in IT.","city":"Ahmedabad","state":"Gujarat","country":"india","passport_doc":"","oci_card_status":"","oci_card_doc":"","permanent_address":"","aadhaar_doc":"","coa_doc":"","crdf_status":"","crdf_code":"","crdf_engagment_status":"","crdf_nature_engagment":"","crdf_from_date":"","crdf_to_date":"","crdf_hours":"","crdf_name_of_center":"","crdf_reporting_to":"","question_status":"","oci_country_status":"","passport_no":"asfsdfsdf","aadhaar_no":"","is_submit":"Y","total_teaching_experiance":"","total_research_experiance":"","total_industry_experiance":"","indian_citizen":"Y","ind_bank_account":"Y","portfolio_file_name":"I1_Cv&amp;portfolio.pdf"},[{"sr_no":1,"name":"Mr. Mahroof","mobile_no":"9887844154","email_id":"mahroof@cept.ac.in"},{"sr_no":2,"name":"Mr.Sharma","mobile_no":"8787124584","email_id":"sharma@gmail.com"},{"sr_no":3,"name":"Mr.Patel","mobile_no":"7874548971","email_id":"patel@gmail.com"}],[{"sr_no":1,"degree":"MCA","specialization":"Information Technology","university":"Gujarat University","date_of_issuance_certificate":"","edu_start_date":"","edu_end_date":"","edu_percentage":"","edu_mode":""}],[{"sr_no":1,"work_designation":"25000","work_institute":"GTU","work_experience_type":"","work_start_date":"12/16/2014","work_end_date":"11/21/2019","work_experience_year":"","work_expe_total_month":"","work_experience_months":"64"}],"A"]'
       // json_All_instructor_data = '[{"instructor_code":"I1","VF_code":"I1","first_name":"Magjikondi","last_name":"Durgasha","title":"Mr.","mail":"AFS@GMAIL.COM","mobile_no":"9662062505","phone_no":"","blood_group":"O-","pan_card_no":"aaadafada","bank_account_number":"145254364644567","account_type":"Saving","name_of_Bank":"sdfsdfsdf","branch_name":"sdfsdf","ifsc_code":"sdf00112365","benificiary_name":"Nitin","dob":"03/20/1987","highest_qualification":"PG","total_experiance":"8","associated_with_cept_since":"","address":"D-37 JOGESHWARI BAUG SOCEITY JAYSHREE TENT PART 2 NR ARBUDANAGAR ROAD RAJENDRA PARKPARK ODHAV AHMEDA","emergency_contact_name":"","emergency_contact_number":"","degree":"","specialization":"","university":"","date_of_issuance_certificate":"","work_designation":"","work_institute":"","work_start_date":"","work_end_date":"","achievements":"I have got certificate for the appreciation regarding the providing the IT Support in Code for Gujarat. I have also participate into the Smart India Hackathon 2018 and 2019.","area_of_interest":"Project Management, IT Services.","cv_file_name":"I1_Cv&amp;portfolio.pdf","image_path":"","gst_number":"","coa_registration_no":"","gender":"M","edu_work_description":"Master of Computer Application, I have worked more than 8 years in IT.","city":"Ahmedabad","state":"Gujarat","country":"india","passport_doc":"","oci_card_status":"","oci_card_doc":"","permanent_address":"","aadhaar_doc":"","coa_doc":"","crdf_status":"","crdf_code":"","crdf_engagment_status":"","crdf_nature_engagment":"","crdf_from_date":"","crdf_to_date":"","crdf_hours":"","crdf_name_of_center":"","crdf_reporting_to":"","question_status":"","oci_country_status":"","passport_no":"asfsdfsdf","aadhaar_no":"","is_submit":"Y","total_teaching_experiance":"","total_research_experiance":"","total_industry_experiance":"","indian_citizen":"Y","ind_bank_account":"Y","portfolio_file_name":"I1_Cv&amp;portfolio.pdf"},[{"sr_no":1,"name":"Mr. Mahroof","mobile_no":"9887844154","email_id":"mahroof@cept.ac.in"},{"sr_no":2,"name":"Mr.Sharma","mobile_no":"8787124584","email_id":"sharma@gmail.com"},{"sr_no":3,"name":"Mr.Patel","mobile_no":"7874548971","email_id":"patel@gmail.com"}],[{"sr_no":1,"degree":"MCA","specialization":"Information Technology","university":"Gujarat University","date_of_issuance_certificate":"","edu_start_date":"","edu_end_date":"","edu_percentage":"","edu_mode":""}],[{"sr_no":1,"work_designation":"25000","work_institute":"GTU","work_experience_type":"","work_start_date":"12/16/2014","work_end_date":"11/21/2019","work_experience_year":"","work_expe_total_month":"","work_experience_months":"64"}],"A"]'

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
           /* url: "../../WebService.asmx/save_instructor_data",*/
            url: "../../WebService.asmx/sws_save_instructor_data",
            async: false,
            data: "{ All_table_course_data: '" + json_All_instructor_data + "' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Data Saved Successfully') {
                    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC') {
                        if (action == 'A') {
                            bootbox.alert('Personal Details Submitted Successfully.', function ()
                            {
                                window.location = "ws_coursemaster_add.aspx?sws=true";
                                //location.reload();
                            });
                        }
                        else {
                            bootbox.alert(data.d, function () {
                                location.reload();
                            });
                        }
                    }
                    else if ($('#hdnusertype').val() == 'HR' || $('#hdnusertype').val() == 'A') {
                        retrieveInstructorData();
                    }
                }
                else if (data.d != "") {
                    alert(data.d);
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    });
    //|| $('#hdnusertype').val() == 'A1'
    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'A1' || $('#hdnusertype').val() == 'PC') {
        retrieveInstructorData();
        if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC') {
            call_for_studio_status_track();
        }
    }

    if ($('#hdnusertype').val() == 'HR' || $('#hdnusertype').val() == 'A') {
        bind_instructor_code_data();
        bind_instructor_name_data();
    }

    $('#btnreterive').on('click', function () {
        retrieveInstructorData();
    });

    if ($('#hdn_icode_ex').val() != "") {
        $('#existing_user').css('display', 'block');
        $('#temp_user').css('display', 'none');
    }
    if ($("#hdn_tutor_type").val() == "VF") {
        $("#stick_bank").css("display", "inline-block");
        $("#stick_account").css("display", "inline-block");
        $("#stick_ban_name").css("display", "inline-block");
        $("#stick_branch_name").css("display", "inline-block");
        $("#stick_ifsc").css("display", "inline-block");
    }

    $("#pd").css('background-color', 'grey');
    $("#ip").css('background-color', 'white');
    $("#pd").removeClass("active");
    $("#ip").addClass("active");
    //bindcountry();

   
    


});



function bindcountry() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_country_data",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var country_data = JSON.parse(data.d);


                $('#txt_country_dtl').empty().append($("<option></option>").val("").html("-- Please Select Country --"));

                for (var i = 0; i < country_data.length; i++) {
                    $('#txt_country_dtl').append($("<option></option>").val(country_data[i]["id"]).html(country_data[i]["name"]));
                }

                $('#txt_country_dtl').chosen();


                // $('#txt_country_dtl').html(str_drp_country_html);

            }
        },
        error: function (result) {
            alert(result);
        }
    });
}
function edit_bindcountry(value) {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_country_data",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var country_data = JSON.parse(data.d);


                $('#txt_country_dtl').empty().append($("<option></option>").val("").html("-- Please Select Country --"));

                for (var i = 0; i < country_data.length; i++) {
                    $('#txt_country_dtl').append($("<option></option>").val(country_data[i]["id"]).html(country_data[i]["name"]));
                }

                $('#txt_country_dtl').chosen();
                
                if (value != '' && value != undefined)
                {
                    $('#txt_country_dtl').val(value.trim());
                    $('#txt_country_dtl').change();
                    $('#txt_country_dtl').trigger("liszt:updated");

                   // $('#txt_country_dtl').val(value);
                }

            }
        },
        error: function (result) {
            alert(result);
        }
    });
}
function IsNumeric(e) {
    //alert(e.which + " : " + e.keyCode);

    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {

        //        if (parseInt($(document.activeElement).val()) > 10) {
        //            return false;
        //        }
        //        else if (parseInt($(document.activeElement).val()) == 10) {
        //            if (keyCode != 48) {
        //                return false;
        //            }
        //        }

        return true;
    }
    else {
        return false;
    }
}

function IsNumeric_TotalExperience(e) {
    //alert(e.which + " : " + e.keyCode);
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {

        //        if (parseInt($(document.activeElement).val()) > 10) {
        //            return false;
        //        }
        //        else if (parseInt($(document.activeElement).val()) == 10) {
        //            if (keyCode != 48) {
        //                return false;
        //            }
        //        }

        return true;
    }
    else {
        return false;
    }
}

function IsValidIFSC(e) {

    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    //A-Z
    if (keyCode >= 65 && keyCode <= 90) {
        return true;
    }
    //a-z
    else if (keyCode >= 97 && keyCode <= 122) {
        return true;
    }
    //0-9
    else if (keyCode >= 48 && keyCode <= 57) {
        return true;
    }
    else {
        return false;
    }
}

function bind_instructor_name_data() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_drp_VF_name_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var instructor_name_data = JSON.parse(data.d);

                $('#drp_instructor_name').empty().append($("<option></option>").val("").html("-- Please Select Instructor --"));

                for (var i = 0; i < instructor_name_data.length; i++) {
                    $('#drp_instructor_name').append($("<option></option>").val(instructor_name_data[i]["instructor_code"]).html(instructor_name_data[i]["instructor_name"]));
                }

                $('#drp_instructor_name').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bind_instructor_code_data() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_drp_VF_code_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var instructor_code_data = JSON.parse(data.d);

                $('#drp_instructor_code').empty().append($("<option></option>").val("").html("-- Please Select Instructor --"));

                for (var i = 0; i < instructor_code_data.length; i++) {
                    $('#drp_instructor_code').append($("<option></option>").val(instructor_code_data[i]["instructor_code"]).html(instructor_code_data[i]["VF_code"]));
                }

                $('#drp_instructor_code').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function add_row(tbl) {
    if (tbl == 'reference') {
        var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 297px;'/></td><td><input type='text' class='marg-btm' style='width: 297px;'/></td><td><input type='text' class='marg-btm' style='width: 297px;'/></td></tr>";
        $('#tbl_reference').append(str_row);
        //$('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
    }
    else if (tbl == 'academic') {
        var str_row = "<tr><td><input type='text' class='marg-btm'/></td><td><input type='text' class='marg-btm'/></td><td><input type='text' class='marg-btm'/></td><td><input type='text' class='cls_date' placeholder='DD/MM/YYYY'/></td></tr>";
        $('#tbl_academic_qualification').append(str_row);
        $('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
    }
    else if (tbl == 'work') {
        var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 180px;'/></td><td><input type='text' class='marg-btm' style='width: 120px;'/></td><td>"
            + "<select class='experience_type' style='width: 140px;'>"
            + "<option value=''>Please Select Experience Type</option>"
            + "<option value='Teaching'>Teaching</option>"
            + "<option value='Research'>Research</option>"
            + "<option value='Industry'>Industry</option>"
            + "</select>"
            + "</td><td><input type='text' class='cls_date start_date' placeholder='DD/MM/YYYY' style='width: 120px;'/></td><td><input type='text' class='cls_date end_date' placeholder='DD/MM/YYYY' style='width: 120px;'/></td><td>"
            + "<input type = 'text' class='cls_duration' style='width: 125px;' disabled/></td></tr>";
        $('#tbl_work_experiance').append(str_row);
        $('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
    }

    return false;
}
var country_value = '';
function retrieveInstructorData() {

    var instructor_code = '';
    //|| $('#hdnusertype').val() == 'A1'
    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'A1' || $('#hdnusertype').val() == 'PC') {
        instructor_code = $('#hdn_icode').val();

        if (instructor_code == '') {
            bootbox.alert('No Instructor found');
        }
    }
    else if ($('#hdnusertype').val() == 'HR' || $('#hdnusertype').val() == 'A') {
        if ($('#drp_instructor_name').val() != '') {
            instructor_code = $('#drp_instructor_name').val();
        }
        else if ($('#drp_instructor_code').val() != '') {
            instructor_code = $('#drp_instructor_code').val();
        }

        if (instructor_code == '') {
            bootbox.alert('Please select Instructor to retrieve data');
        }
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_instructor_data",
        async: false,
        data: "{instructor_code : '" + instructor_code + "'}",
        dataType: "json",
        success: function (data) {

            if (data.d[0] != null && data.d[0] != '') {

                var instructor_data = JSON.parse(data.d[0]);
                is_data_found = true;

                //if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2') {
                //    if (instructor_data[0]["admin_approved"] == "Y" || instructor_data[0]["hr_approved"] == "Y") {
                //        bootbox.alert('Course already Submitted , You can not edit Faculty Detail after Submit', function () {
                //            location.replace("VF_personal_detail.aspx");
                //        });
                //        return false;
                //    }
                //}
                //else 

                if ($('#hdnusertype').val() == 'HR' || $('#hdnusertype').val() == 'A') {
                    $('#hdn_icode').val(instructor_data[0]["instructor_code"]);
                }

                $('#txt_vf_code').val(instructor_data[0]["VF_code"]);
                $('#txt_first_name').val(instructor_data[0]["first_name"]);
                $('#txt_last_name').val(instructor_data[0]["last_name"]);
                $('#drp_title').val(instructor_data[0]["title"]);
                $('#txt_email').val(instructor_data[0]["mail"]);
                $('#txt_mobile_no').val(instructor_data[0]["mobile_no"]);
                $('#txt_alternate_contact_no').val(instructor_data[0]["phone_no"]);
                $('#txt_blood_group').val(instructor_data[0]["blood_group"]);
                $('#txt_pan_card_no').val(instructor_data[0]["pan_card_no"]);
                $('#txt_bank_account_no').val(instructor_data[0]["bank_account_number"]);
               // $('#IC' + instructor_data[0]["indian_citizen"]).attr('checked', 'checked');
               // $('#IC' + instructor_data[0]["indian_citizen"]).attr('checked', 'checked');
               // bindcountry();
                if (instructor_data[0]["indian_citizen"] != 'N' && instructor_data[0]["indian_citizen"] != 'Y') {
                    country_value = instructor_data[0]["indian_citizen"];
                    edit_bindcountry(country_value);
                    //$('#txt_country_dtl').val(instructor_data[0]["indian_citizen"]);
                }
                
                $('#IBA' + instructor_data[0]["ind_bank_account"]).attr('checked', 'checked');
                $('#txt_passport_no').val(instructor_data[0]["passport_no"]);
                $('#txt_aadhaar_no').val(instructor_data[0]["aadhaar_no"]);
                $('#txt_account_type').val(instructor_data[0]["account_type"]);
                $('#txt_name_of_the_bank').val(instructor_data[0]["name_of_Bank"]);
                $('#txt_branch_name').val(instructor_data[0]["branch_name"]);
                $('#txt_ifsc_code').val(instructor_data[0]["ifsc_code"]);
                $('#txt_benificiary_name').val(instructor_data[0]["benificiary_name"]);
                //$('#txt_dob').val(instructor_data[0]["dob"]);
                $('#txt_dob').val(convertDate(instructor_data[0]["dob"]));
                $('#txt_highest_qualification').val(instructor_data[0]["highest_qualification"]);
                $('#txt_total_experiance').val(instructor_data[0]["total_experiance"]);
                $('#txt_total_experiance_months').val(instructor_data[0]["total_experiance_months"]);
                $('#txt_total_teaching_experiance').val(instructor_data[0]["total_teaching_experiance"]);
                //$('#txt_total_research_experiance').val(instructor_data[0]["total_research_experiance"]);
                //$('#txt_total_industry_experiance').val(instructor_data[0]["total_industry_experiance"]);
                $('#txt_associated_with_cept_since').val(instructor_data[0]["associated_with_cept_since"]);
                $('#txt_address').val(instructor_data[0]["address"]);
                $('#txt_emergency_contact_name').val(instructor_data[0]["emergency_contact_name"]);
                $('#txt_emergency_contact_no').val(instructor_data[0]["emergency_contact_number"]);

                $('#txt_degree').val(instructor_data[0]["degree"]);
                $('#txt_specialization').val(instructor_data[0]["specialization"]);
                $('#txt_university').val(instructor_data[0]["university"]);
                $('#txt_date_of_issuance_certificate').val(instructor_data[0]["date_of_issuance_certificate"]);

                $('#txt_work_designation').val(instructor_data[0]["work_designation"]);
                $('#txt_work_institute').val(instructor_data[0]["work_institute"]);
                $('#txt_work_start_date').val(instructor_data[0]["work_start_date"]);
                $('#txt_work_end_date').val(instructor_data[0]["work_end_date"]);

                $('#txt_achievements').val(instructor_data[0]["achievements"]);

                $('#txt_area_of_interest').val(instructor_data[0]["area_of_interest"]);

                //$('#lbl_cv_file_name').html('<b>' + instructor_data[0]["cv_file_name"] + '</b>');
                $('#lbl_cv_file_name').html('<b><a href="../../InstructorCVUpload/' + instructor_data[0]["cv_file_name"] + '" target="_blank">' + instructor_data[0]["cv_file_name"] + '</b>');
                FileName = instructor_data[0]["cv_file_name"];

                //$('#lbl_port_file_name').html('<b>' + instructor_data[0]["portfolio_file_name"] + '</b>');
                $('#lbl_port_file_name').html('<b><a href="../../InstructorPortfolioUpload/' + instructor_data[0]["portfolio_file_name"] + '" target="_blank">' + instructor_data[0]["portfolio_file_name"] + '</b>');
                FileNameforPort = instructor_data[0]["portfolio_file_name"];

                if (instructor_data[0]["profile_photo"] != "") {
                    $("#img_photo").attr("src", "../../UserPersonalPhoto/" + instructor_data[0]["profile_photo"] + "?" + (new Date()).getTime());
                    $('#lbl_image_name').text(instructor_data[0]["profile_photo"]);
                }

                //kapil08062020
                $('#drp_gender').val(instructor_data[0]["gender"]);
                $('#txt_gst_no').val(instructor_data[0]["gst_number"]);
                $('#txt_coa_reg_no').val(instructor_data[0]["coa_registration_no"]);
                $('#txt_eduction_dtl').val(instructor_data[0]["edu_work_description"]);

                // City state country
                $('#txt_city').val(instructor_data[0]["city"]);
                $('#txt_state').val(instructor_data[0]["state"]);
                $('#txt_country').val(instructor_data[0]["country"]);


                //End
                if (instructor_data[0]["designation"].trim().toLowerCase() == "instructor") {
                    user_temp = true;
                }

                if (instructor_data[0]["designation"] == "temp") {
                    user_temp = true;
                    //$("#txt_pan_card_no").prop("disabled", true);
                    $("#txt_bank_account_no").prop("disabled", true);
                    $("#txt_account_type").prop("disabled", true);
                    $("#txt_name_of_the_bank").prop("disabled", true);
                    $("#txt_branch_name").prop("disabled", true);
                    $("#txt_ifsc_code").prop("disabled", true);
                    $("#txt_benificiary_name").prop("disabled", true);
                } else {
                }

                if (instructor_data[0]["is_submit"] == "Y") {
                    $("#btnnext").css('display', '');
                    $("#pd").css('background-color', 'white');
                } else {
                    block = true; //uncomment this line to work logic of stop going next button - Mahroofbhai - 14 10 2020
                    //$("#btnnext").css('display', '');//
                    $("#btnnext").css('display', 'none');
                    $("#ip").css('background-color', 'grey');
                    $("#pd").css('background-color', 'white');
                    $("#ip").addClass("inactive");
                    $("#ip").removeClass("active");
                    $("#sd").addClass("inactive");
                    $("#sd").removeClass("active");
                }

                if ($("#hdn_tutor_type").val() == "temp") {
                    $("#bank_tutor").addClass("inactive");
                    $("#bank_tutor").removeClass("active");
                    $("#tutor_disabled").prop("disabled", true);
                }

            }

            if (data.d[1] != null && data.d[1] != '') {
                var instructor_education_work = JSON.parse(data.d[1]);

                if (instructor_education_work.length > 0) {
                    var total_ref_row = 0;
                    var total_edu_row = 0;
                    var total_work_row = 0;

                    $('#tbl_reference tbody tr')[1].remove();
                    $('#tbl_academic_qualification tbody tr')[1].remove();
                    $('#tbl_work_experiance tbody tr')[1].remove();

                    for (var i = 0; i < instructor_education_work.length; i++) {
                        if (instructor_education_work[i]['detail_type'] == 'reference') {
                            total_ref_row++;
                            var str_row = "<tr><td><input type='text' class='marg-btm' value='' style='width: 297px;'/></td><td><input type='text' class='marg-btm' value='' style='width: 297px;'/></td><td><input type='text' class='marg-btm' value='' style='width: 297px;'/></td></tr>";
                            $('#tbl_reference').append(str_row);

                            $('#tbl_reference tbody tr:last-child td')[0].children[0].value = instructor_education_work[i]['referee_name'];
                            $('#tbl_reference tbody tr:last-child td')[1].children[0].value = instructor_education_work[i]['referee_mobile_no'];
                            $('#tbl_reference tbody tr:last-child td')[2].children[0].value = instructor_education_work[i]['referee_email_id'];
                        }
                        else if (instructor_education_work[i]['detail_type'] == 'education') {
                            total_edu_row++;
                            var date_of_issuance_certificate = convertDate(instructor_education_work[i]['date_of_issuance_certificate']);

                            //var str_row = "<tr><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['degree'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['specialization'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['university'] + "'/></td><td><input type='text' class='cls_date' value='" + date_of_issuance_certificate + "'/></td></tr>";
                            var str_row = "<tr><td><input type='text' class='marg-btm' value=''/></td><td><input type='text' class='marg-btm' value=''/></td><td><input type='text' class='marg-btm' value='' /></td> <td><input type='text' class='cls_date' value='" + date_of_issuance_certificate + "' /></td></tr > ";
                            $('#tbl_academic_qualification').append(str_row);

                            $('#tbl_academic_qualification tbody tr:last-child td')[0].children[0].value = instructor_education_work[i]['degree'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[1].children[0].value = instructor_education_work[i]['specialization'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[2].children[0].value = instructor_education_work[i]['university'];
                        }
                        else if (instructor_education_work[i]['detail_type'] == 'work') {
                            total_work_row++;
                            var work_start_date = convertDate(instructor_education_work[i]['work_start_date']);
                            var work_end_date = convertDate(instructor_education_work[i]['work_end_date']);

                            var dt1 = new Date(instructor_education_work[i]['work_start_date']);
                            var dt2 = new Date(instructor_education_work[i]['work_end_date']);

                            //var str_row = "<tr><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['work_designation'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['work_institute'] + "'/></td><td><input type='text' class='cls_date' value='" + work_start_date + "'/></td><td><input type='text' class='cls_date' value='" + work_end_date + "'/></td></tr>";
                            var str_row = "<tr><td><input type='text' class='marg-btm' value='' style='width: 180px;'/></td><td><input type='text' class='marg-btm' value='' style='width: 120px;'/></td><td><select class='experience_type' style='width: 140px;'>"
                                + "<option value=''>Please Select Experience Type</option>"
                                + "<option value='Teaching'>Teaching</option>"
                                + "<option value='Research'>Research</option>"
                                + "<option value='Industry'>Industry</option>"
                                + "</select>"
                                + "</td ><td><input type='text' class='cls_date start_date' value='" + work_start_date + "' style='width: 120px;'/></td><td><input type='text' class='cls_date end_date' value='" + work_end_date + "' style='width: 120px;'/></td>"
                                + " <td><input type = 'text' class='cls_duration' style='width: 125px;' value='" + diff_months(dt1, dt2) + "' disabled/></td></tr> ";

                            $('#tbl_work_experiance').append(str_row);

                            $('#tbl_work_experiance tbody tr:last-child td')[1].children[0].value = instructor_education_work[i]['work_designation']
                            $('#tbl_work_experiance tbody tr:last-child td')[0].children[0].value = instructor_education_work[i]['work_institute']
                            $('#tbl_work_experiance tbody tr:last-child td')[2].children[0].value = instructor_education_work[i]['work_experience_type']

                            $('.cls_date').on('change', function () {

                                var clasname = $(this)[0].className;
                                if (clasname.includes("start_date")) {
                                    if ($(this).parent().parent().find('.end_date').val() != "") {
                                        var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                                        var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                                        $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
                                    }
                                } else if (clasname.includes("end_date")) {
                                    if ($(this).parent().parent().find('.start_date').val() != "") {
                                        var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                                        var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                                        $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
                                    }
                                }
                            });
                        }
                    }

                    if (total_ref_row == 0) {
                        add_row('reference');
                    }
                    if (total_edu_row == 0) {
                        add_row('academic');
                    }
                    if (total_work_row == 0) {
                        add_row('work');
                    }

                    $('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
                }
            }

            $('#drp_title').trigger("liszt:updated");
            $('#txt_highest_qualification').trigger("liszt:updated");
            $('#txt_blood_group').trigger("liszt:updated");
            $('#txt_associated_with_cept_since').trigger("liszt:updated");
            $('#txt_country_dtl').trigger("liszt:updated");
        },
        error: function (result) {
            alert(result);
        }
    });
    return false;
}

function diff_months(dt2, dt1) {

    var months = (dt1.getFullYear() - dt2.getFullYear()) * 12;
    months -= dt2.getMonth();
    months += dt1.getMonth();
    return months <= 0 ? 0 : months;

    //var diff = (dt2.getTime() - dt1.getTime()) / 1000;
    //diff /= (60 * 60 * 24 * 7 * 4);
    //return Math.abs(Math.round(diff));
}

var FileName = '';
var FileNameforPort = '';
function UploadProfilePhoto() {
    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading CV.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading CV.");
        return false;
    } else {
        try {
            var fileToUpload = GetFileNameFromPath($('#cvUpload').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserPhotoExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {

                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Instructor_CV_upload.ashx',
                            secureuri: false,
                            fileElementId: 'cvUpload',
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#cvUpload').val("");
                                        $('#lbl_cv_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload

                                        FileName = data.upfile;
                                    }
                                }
                                $("#UploadingProgress").fadeOut(200);
                            },
                            error: function (data, status, e) {
                                $("#UploadingProgress").fadeOut(200);
                                alert(e);
                            }
                        });
                    }
                }
            }
            else {
                alert('Invalid File Type. Please upload jpeg / png / pdf / doc file');
            }
            return false;
        }
        catch (e) {
            alert("Exception : " + e.message);
        }
    }
}

function UploadPortfolioPhoto() {
    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading Portfolio.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading Portfolio.");
        return false;
    } else {
        try {
            var fileToUpload = GetFileNameFromPath($('#portUpload').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserPhotoExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {
                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Instructor_Portfolio_upload.ashx',
                            secureuri: false,
                            fileElementId: 'portUpload',
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#portUpload').val("");
                                        $('#lbl_port_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload

                                        FileNameforPort = data.upfile;
                                    }
                                }
                                $("#UploadingProgress").fadeOut(200);
                            },
                            error: function (data, status, e) {
                                $("#UploadingProgress").fadeOut(200);
                                alert(e);
                            }
                        });
                    }
                }
            }
            else {
                alert('Invalid File Type. Please upload jpeg / png / pdf / doc file');
            }
            return false;
        }
        catch (e) {
            alert("Exception : " + e.message);
        }
    }
}

function GetFileNameFromPath(strFilepath) {

    var objRE = new RegExp(/([^\/\\]+)$/);
    var strName = objRE.exec(strFilepath);

    if (strName == null) {
        return null;
    }
    else {
        return strName[0];
    }
}

function CheckUserPhotoExtension(file) {
    try {
        var flag = true;
        var extension = file.substr((file.lastIndexOf('.') + 1));

        switch (extension) {
            case 'jpg':
            case 'jpeg':
            case 'JPG':
            case 'JPEG':
            case 'png':
            case 'PNG':
            case 'pdf':
            case 'PDF':
            case 'doc':
            case 'DOC':
            case 'docx':
            case 'DOCX':
                flag = true;
                break;
            default:
                flag = false;
        }

        return flag;
    }
    catch (e) {
        alert("Exception : " + e.message);
    }
}

function convertDate(str_date) {
    if (str_date != '') {
        dateToConvert = new Date(str_date)
        var dd = dateToConvert.getDate();
        var mm = (dateToConvert.getMonth() + 1);
        if (mm < 10) mm = '0' + mm;
        var year = dateToConvert.getFullYear();

        var convertedDate = '' + dd + '/' + mm + '/' + year;
        return convertedDate;
    }
    return '';
}

function convertDateCalculateMonth(str_date) {
    if (str_date != '')
    {
        dateToConvert = new Date(str_date)
        var dd = dateToConvert.getDate();
        var mm = (dateToConvert.getMonth() + 1);
        if (mm < 10) mm = '0' + mm;
        var year = dateToConvert.getFullYear();

        var convertedDate = '' + dd + '/' + mm + '/' + year;
        return convertedDate;
    }
    return '';
}

function replace_special_char(data) {
    if (data != '') {
        data = data.replace(/\\/g, '\\\\');
        //data = data.replace(/\'/g, '\\\'')
        data = data.replace(/"/g, '\\\"');
    }
    return data;
}

var FileName2 = '';
function UploadUserProfilePhoto() {
    try {
        var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

        var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

        var icode = $('#hdn_icode').val();

        if (CheckUserProfilePhotoExtension(fileToUpload)) {
            var flag = true;

            if (filename != "" && filename != null) {

                if (flag == true) {
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/Instructor_photo_upload.ashx',
                        secureuri: false,
                        fileElementId: 'imageUpload',
                        dataType: 'json',
                        data: { name: name, icode: icode },
                        success: function (data, status) {
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {
                                    $('#imageUpload').val("");

                                    bootbox.alert("Photo Uploaded Successfully");
                                    FileName2 = data.upfile;
                                    $("#img_photo").attr("src", "../../UserPersonalPhoto/" + FileName2 + "?" + (new Date()).getTime());
                                    $('#lbl_image_name').text(FileName2);
                                }
                            }
                            $("#UploadingProgress").fadeOut(200);
                        },
                        error: function (data, status, e) {
                            $("#UploadingProgress").fadeOut(200);
                            alert(e);
                        }
                    });
                }
            }
        }
        else {
            alert('Invalid File Type. Please upload .jpeg file');
        }
        return false;
    }
    catch (e) {
        alert("Exception : " + e.message);
    }
}

//Check User Photo Extension
function CheckUserProfilePhotoExtension(file) {
    try {
        var flag = true;
        var extension = file.substr((file.lastIndexOf('.') + 1));

        switch (extension) {
            case 'jpg':
            case 'jpeg':
            case 'JPG':
            case 'JPEG':
                flag = true;
                break;
            default:
                flag = false;
        }

        return flag;
    }
    catch (e) {
        alert("Exception : " + e.message);
    }
}


