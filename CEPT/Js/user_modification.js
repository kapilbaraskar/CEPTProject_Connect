
var count = 1;
$(document).ready(function () {

    //  binduserdata();
    binddepartment();
    bindprogrammedata();
    bindyeardata();
    bind_prog_level_data();

    $('input,select').css('color','currentcolor');

   

    //    $('#txtmobileno').on('')

    $('#txtdob,#txtDOJ').datepicker({
        dateFormat: "dd/mm/yy"
    });

    $('#drpcountry').on('change', function () {

        if ($('#drpcountry').val() == '1' || $('#drpcountry').val() == '0') {

            $('#other_country').css('display', 'none');
        }
        else {
            $('#other_country').css('display', 'block');
        }

    });

    $('#drp_dept,#drp_prog,#drp_year').on('change', function () {

        binduserdata();
        reset();


    });


    $('#btnreterive').on('click', function () {

        debugger;

        var user_id = $('#drpuser').val();
        if (user_id == "") {
            bootbox.alert('Please select Student')
            $('#drpuser').focus();
            return false;
        }

        reset();

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/retrieve_student_data_for_modification_new",

            data: "{'user_id':'" + user_id + "'}",
            dataType: "json",
            success: function (data)
            {
                if (data.d[0] != null)
                {
                    var student_data = JSON.parse(data.d[0]);

                    $('#divdetails').css('display', 'block');

                    $('#txtemail').val(student_data[0]["mail"]);
                    $('#txt_userid').val(student_data[0]["user_id"]);
                    $('#txt_enrollment_no').val(student_data[0]["enrollment_no"]);

                    if (student_data[0]["first_name"] != '') {
                        $('#txt_firstname').val(student_data[0]["first_name"]);
                    }

                    if (student_data[0]["middle_name"] != '') {
                        $('#txt_middelname').val(student_data[0]["middle_name"]);
                    }

                    if (student_data[0]["last_name"] != '') {
                        $('#txt_Lastname').val(student_data[0]["last_name"]);
                    }

                    if (student_data[0]["nationality"] != '') {
                        $('#txtnationality').val(student_data[0]["nationality"]);
                    }

                    //  $('#txt_middelname').val(student_data[0]["middle_name"]);
                    //   $('#txt_Lastname').val(student_data[0]["last_name"]);

                    $('#txt_full_name').val(student_data[0]["user_name"]);

                    if (student_data[0]["dob1"] != '') {
                        $('#txtdob').val(student_data[0]["dob1"]);
                    }

                    if (student_data[0]["gender"] != '') {
                        $('#drpgender').val(student_data[0]["gender"]);
                    }

                    if (student_data[0]["blood_group"] != '') {
                        $('#txtbloodgrp').val(student_data[0]["blood_group"]);
                    }
                    if (student_data[0]["nationality"] != '') {
                        $('#txtnationality').val(student_data[0]["nationality"]);
                    }

                    if (student_data[0]["nationality"] != '') {
                        $('#txtnationality').val(student_data[0]["nationality"]);
                    }

                    if (student_data[0]["dept_code"] != '') {
                        $('#drpdepartment').val(student_data[0]["dept_code"]);
                        $('#drpdepartment').trigger("liszt:updated");
                    }
                    if (student_data[0]["prog_code"] != '') {
                        $('#drpprog').val(student_data[0]["prog_code"]);
                        $('#drpprog').trigger("liszt:updated");
                    }

                    if (student_data[0]["year_code"] != '') {
                        $('#drpyear').val(student_data[0]["year_code"]);
                        $('#drpyear').trigger("liszt:updated");
                    }
                    if (student_data[0]["prog_level_code"] != '') {
                        $('#drp_prog_level').val(student_data[0]["prog_level_code"]);
                        $('#drp_prog_level').trigger("liszt:updated");

                    }
                    if (student_data[0]["user_status_flag"] != '') {
                        $('#drpavtice').val(student_data[0]["user_status_flag"]);

                    }
                    if (student_data[0]["status"] != '') {
                        $('#drp_status').val(student_data[0]["status"]);

                    }

                    $('#drp_category').val(student_data[0]["category"]);
                    $('#drp_disability').val(student_data[0]["physically_handicapped"]);
                    $('#txt_economically_backward').val(student_data[0]["economically_backward"]);
                    $('#txt_father_name').val(student_data[0]["father_name"]);
                    $('#txt_mother_name').val(student_data[0]["mother_name"]);
                    $('#txt_guardian_contact_name').val(student_data[0]["guardian_contact_name"]);

                    ///////Contact Details///
                    if (student_data[0]["address"] != '') {
                        $('#txtperadd').val(student_data[0]["address"]);
                    }
                    else { $('#txtperadd').val(student_data[0]["per_address"]); }

                    if (student_data[0]["local_address"] != '') {
                        $('#txtadd').val(student_data[0]["local_address"]);
                    }
                    else { $('#txtadd').val(student_data[0]["loc_address"]); }

                    
                    if (student_data[0]["student_contact_no"] != '') {
                        $('#txt_student_contact_no').val(student_data[0]["student_contact_no"]);
                    }
                    else { $('#txt_student_contact_no').val(student_data[0]["applicant_mobile_no"]);}
                    
                    $('#txtaltemail').val(student_data[0]["alternet_mail"]);
                    $('#txt_residence_no').val(student_data[0]["residence_no"]);

                    if (student_data[0]["mobile_no"] != '') {
                        $('#txtmobileno').val(student_data[0]["mobile_no"]);
                    }

                    $('#txt_emergency_contact_2').val(student_data[0]["emergency_contact_2"]);
                    $('#txt_emergency_relationship').val(student_data[0]["relationship_with_emergency_contact"]);
                    $('#txt_father_contact').val(student_data[0]["father_contact_no"]);
                    $('#txt_mother_contact').val(student_data[0]["mother_contact_no"]);
                    if (student_data[0]["phone_no"] != '') {
                        $('#txt_guardian_contact').val(student_data[0]["phone_no"]);
                    }
                    else { $('#txt_guardian_contact').val(student_data[0]["guardian_mobile_no"]);}
                    
                    $('#txt_father_email').val(student_data[0]["father_email"]);
                    $('#txt_mother_email').val(student_data[0]["mother_email"]);

                    if (student_data[0]["guardian_email"] != '') {
                        $('#txt_guardian_email').val(student_data[0]["guardian_email"]);
                    }
                    else
                    {
                        $('#txt_guardian_email').val(student_data[0]["guardian_email_id"]);
                    }
                    

                    if (student_data[0]["doj1"] != '') {
                        $('#txtDOJ').val(student_data[0]["doj1"]);
                    }

                    $('#txt_registered_current_sem').val(student_data[0]["registered_for_current_sem"]);

                    /////////////////




                }

                if (data.d[1] != null) {

                    var medical_data = JSON.parse(data.d[1]);

                    $('#txt_height').val(medical_data[0]["height"]);
                    $('#txt_weight').val(medical_data[0]["weight"]);
                    $('#txt_vision_ability').val(medical_data[0]["vision_ability"]);
                    $('#txt_blindness_color').val(medical_data[0]["blindness_color"]);
                    $('#txt_eye_color').val(medical_data[0]["eye_color"]);
                    $('#txt_identification_1').val(medical_data[0]["identification_1"]);
                    $('#txt_identification_2').val(medical_data[0]["identification_2"]);
                    $('#txt_routine_health_complain').val(medical_data[0]["routine_health_complain"]);
                    $('#txt_allergic_to_drug').val(medical_data[0]["allergic_to_drug"]);
                    $('#txt_disability').val(medical_data[0]["disability"]);
                    $('#txt_major_illness').val(medical_data[0]["major_illness"]);
                    $('#txt_tb_typhoid_asthama').val(medical_data[0]["tb_typhoid_asthama"]);
                    $('#txt_major_injury').val(medical_data[0]["major_injury"]);
                    $('#txt_major_prolonged_illness').val(medical_data[0]["major_prolonged_illness"]);
                    $('#txt_major_dental_surgery').val(medical_data[0]["major_dental_surgery"]);
                    $('#txt_other_habits').val(medical_data[0]["other_habits"]);
                    $('#txt_irregular_sleep_pattern').val(medical_data[0]["irregular_sleep_pattern"]);
                    $('#txt_dietary_habits').val(medical_data[0]["dietary_habits"]);
                    $('#txt_insurance_card_no').val(medical_data[0]["insurance_card_no"]);

                }

                if (data.d[2] != null) {

                    var family_health_data = JSON.parse(data.d[2]);

                    $('#txt_high_bp').val(family_health_data[0]["high_bp"]);
                    $('#txt_diabetes').val(family_health_data[0]["diabetes"]);
                    $('#txt_tuberculosis').val(family_health_data[0]["tuberculosis"]);
                    $('#txt_ischemia_heart_disease').val(family_health_data[0]["ischemia_heart_disease"]);
                    $('#txt_thalassemia').val(family_health_data[0]["thalassemia"]);
                    $('#txt_other').val(family_health_data[0]["other"]);
                }

                if (data.d[3] != null) {
                    
                    eductionbindata(data.d[3])
                }
                return false;
            },
            error: function (result) {
                alert(result);
            }
        });

        return false;

    });


    $('#btnsave').on('click', function () {

        debugger;


        var user_status_flag = $('#drpavtice').val();

        var status = $('#drp_status').val();

        var email = $('#txtemail').val();
        if (email == "") {
            bootbox.alert('Please Insert Email Address')
            $('#txtemail').focus();
            return false;
        }

        var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        if (testEmail.test(email)) {

        }
        else {
            bootbox.alert("Please Enter Valid Email");
            $('#txtemail').focus();

            return false;
        }

        var user_id = $('#txt_userid').val();
        var prog_level_code = $('#drp_prog_level').val();

        var department = $('#drpdepartment').val();
        if (department == "") {
            $('#drpdepartment').focus();
            bootbox.alert('Please Select Department')

            return false;
        }

        var prog_code = $('#drpprog').val();
        if (prog_code == "") {
            $('#drpprog').focus();
            bootbox.alert('Please Select Program')

            return false;
        }

        var year_code = $('#drpyear').val();
        if (year_code == "") {
            $('#drpyear').focus();
            bootbox.alert('Please Select Year')

            return false;
        }

        var full_name = $('#txt_full_name').val().trim();

        var first_name = '';
        var middel_name = '';
        var last_name = '';

        first_name = $('#txt_firstname').val().trim();

        //            if (first_name == "") {
        //                $('#txt_firstname').focus();
        //                bootbox.alert('Please Insert First Name')

        //                return false;
        //            }

        middle_name = $('#txt_middelname').val().trim();
        //            if (middel_name == "") {
        //                $('#txt_middelname').focus();
        //                bootbox.alert('Please Insert Middel Name')

        //                return false;
        //            }

        last_name = $('#txt_Lastname').val().trim();
        //            if (last_name == "") {
        //                $('#txt_Lastname').focus();
        //                bootbox.alert('Please Insert Last Name')

        //                return false;
        //            }

        var nationality = $('#txtnationality').val();

        var birthdate = $('#txtdob').val();

        var gender = $('#drpgender').val();

        //        if (gender == "0") {
        //            $('#drpgender').focus();
        //            bootbox.alert('Please Select Gender');

        //            return false;
        //        }

        var blood_grp = $('#txtbloodgrp').val();

        var per_address = $('#txtperadd').val();

        var local_address = $('#txtadd').val();

        var student_contact_no = $('#txt_student_contact_no').val();

        if (student_contact_no != "") {
            if (student_contact_no.length < 10) {
                bootbox.alert("Please Enter 10 Digit Student Contact Number");
                return false;
            }
        }

        var alternet_email = $('#txtaltemail').val();

        if (alternet_email.trim() != "") {
            if (testEmail.test(alternet_email)) {

            }
            else {
                bootbox.alert("Please Enter Valid Alternet Email");
                $('#txtaltemail').focus();

                return false;
            }
        }
        var residence_no = $('#txt_residence_no').val();

        if (residence_no != "") {
            if (residence_no.length < 10) {
                bootbox.alert("Please Enter 10 Digit Residence Phone no");
                return false;
            }
        }

        var emergency_contact_no = $('#txtmobileno').val();
        if (emergency_contact_no != "") {

            if (emergency_contact_no.length < 10) {
                bootbox.alert("Please Enter 10 Digit Emergency Contact Number");
                return false;
            }
        }

        var emergency_contact_no_2 = $('#txt_emergency_contact_2').val();
        if (emergency_contact_no_2 != "") {

            if (emergency_contact_no_2.length < 10) {
                bootbox.alert("Please Enter 10 Digit Emergency Contact Number 2");
                return false;
            }
        }

        var emergency_contact_relationship = $('#txt_emergency_relationship').val().trim();

        var father_contact = $('#txt_father_contact').val();
        if (father_contact != "") {

            if (father_contact.length < 10) {
                bootbox.alert("Please Enter 10 Digit Father Contact Number");
                return false;
            }
        }

        var mother_contact = $('#txt_mother_contact').val();
        if (mother_contact != "") {

            if (mother_contact.length < 10) {
                bootbox.alert("Please Enter 10 Digit Mother Contact Number");
                return false;
            }
        }

        var guardian_contact = $('#txt_guardian_contact').val();
        if (guardian_contact != "") {

            if (guardian_contact.length < 10) {
                bootbox.alert("Please Enter 10 Digit Guardian Contact Number");
                return false;
            }
        }

        var father_email = $('#txt_father_email').val();

        if (father_email.trim() != "") {
            if (testEmail.test(father_email)) {

            }
            else {
                bootbox.alert("Please enter valid father email");
                $('#txt_father_email').focus();

                return false;
            }
        }

        var mother_email = $('#txt_mother_email').val();

        if (mother_email.trim() != "") {
            if (testEmail.test(mother_email)) {

            }
            else {
                bootbox.alert("Please enter valid mother email");
                $('#txt_mother_email').focus();

                return false;
            }
        }

        var guardian_email = $('#txt_guardian_email').val();

        if (guardian_email.trim() != "") {
            if (testEmail.test(guardian_email)) {

            }
            else {
                bootbox.alert("Please enter valid guardian email");
                $('#txt_guardian_email').focus();

                return false;
            }
        }

        var DOJ = $('#txtDOJ').val();

        var registered_for_current_sem = $('#txt_registered_current_sem').val().trim();

        ///////////////////////////////////////////////////////////////

        var entityMap = { "'": '&#39;', '"': '&#34;', "@": '&#64;', "&": '&#38;', "<": '&#60;', ">": '&#62;' };

        var obj_user_mst = { 'gender': '', 'birthdate': '', 'blood_grp': '', 'email': '', 'first_name': '', 'middle_name': '', 'last_name': '', 'nationality': '', 'user_id': '', 'department': '', 'prog_code': '', 'year_code': '', 'prog_level_code': '', 'user_status_flag': '', 'full_name': '', 'status': '', 'category': '', 'physically_handicapped': '', 'economically_backward': '', 'father_name': '', 'mother_name': '', 'application_no': '', 'per_address': '', 'local_address': '', 'student_contact_no': '', 'alternet_mail': '', 'residence_no': '', 'mobile': '', 'emergency_contact_2': '', 'emergency_contact_relationship': '', 'father_contact_no': '', 'mother_contact_no': '', 'guardian_contact_no': '', 'father_email': '', 'mother_email': '', 'guardian_email': '', 'DOJ': '', 'registered_current_sem': '' };

        obj_user_mst.gender = gender;
        obj_user_mst.birthdate = birthdate;
        obj_user_mst.blood_grp = blood_grp;
        obj_user_mst.email = email;
        obj_user_mst.first_name = first_name;
        obj_user_mst.middle_name = middle_name;
        obj_user_mst.last_name = last_name;
        obj_user_mst.nationality = nationality;
        obj_user_mst.user_id = user_id;
        obj_user_mst.department = department;
        obj_user_mst.prog_code = prog_code;
        obj_user_mst.year_code = year_code;
        obj_user_mst.prog_level_code = prog_level_code;
        obj_user_mst.user_status_flag = user_status_flag;
        obj_user_mst.full_name = full_name;
        obj_user_mst.status = status;
        obj_user_mst.category = $('#drp_category').val();
        obj_user_mst.physically_handicapped = $('#drp_disability').val();
        obj_user_mst.economically_backward = $('#txt_economically_backward').val();
        obj_user_mst.father_name = $('#txt_father_name').val();
        obj_user_mst.mother_name = $('#txt_mother_name').val();
        obj_user_mst.guardian_contact_name = $('#txt_guardian_contact_name').val();
        obj_user_mst.application_no = $('#txt_enrollment_no').val();

        /////////////////////////contact details//////////////////

        obj_user_mst.per_address = per_address.replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; });
        obj_user_mst.local_address = local_address.replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; });
        obj_user_mst.student_contact_no = student_contact_no;
        obj_user_mst.alternet_mail = alternet_email;

        obj_user_mst.residence_no = residence_no;
        obj_user_mst.mobile = emergency_contact_no;
        obj_user_mst.emergency_contact_2 = emergency_contact_no_2;
        obj_user_mst.emergency_contact_relationship = emergency_contact_relationship;
        obj_user_mst.father_contact_no = father_contact;
        obj_user_mst.mother_contact_no = mother_contact;
        obj_user_mst.guardian_contact_no = guardian_contact;
        obj_user_mst.father_email = father_email;
        obj_user_mst.mother_email = mother_email;
        obj_user_mst.guardian_email = guardian_email;
        obj_user_mst.DOJ = DOJ;
        obj_user_mst.registered_current_sem = registered_for_current_sem;

        //////////////////////////////////////////////////////////

        var obj_user_medical_dtl = { 'height': '', 'weight': '', 'vision_ability': '', 'blindness_color': '', 'eye_color': '', 'identification_1': '', 'identification_2': '',
            'routine_health_complain': '', 'allergic_to_drug': '', 'disability': '', 'major_illness': '', 'tb_typhoid_asthama': '', 'major_injury': '', 'major_prolonged_illness': '', 'major_dental_surgery': '', 'other_habits': '',
            'irregular_sleep_pattern': '', 'dietary_habits': '', 'insurance_card_no': ''
        };


        obj_user_medical_dtl.height = $('#txt_height').val();
        obj_user_medical_dtl.weight = $('#txt_weight').val();
        obj_user_medical_dtl.vision_ability = $('#txt_vision_ability').val().trim();
        obj_user_medical_dtl.blindness_color = $('#txt_blindness_color').val().trim();
        obj_user_medical_dtl.eye_color = $('#txt_eye_color').val().trim();
        obj_user_medical_dtl.identification_1 = $('#txt_identification_1').val().trim();
        obj_user_medical_dtl.identification_2 = $('#txt_identification_2').val().trim();
        obj_user_medical_dtl.routine_health_complain = $('#txt_routine_health_complain').val().trim();
        obj_user_medical_dtl.allergic_to_drug = $('#txt_allergic_to_drug').val().trim();
        obj_user_medical_dtl.disability = $('#txt_disability').val().trim();
        obj_user_medical_dtl.major_illness = $('#txt_major_illness').val().trim();
        obj_user_medical_dtl.tb_typhoid_asthama = $('#txt_tb_typhoid_asthama').val().trim();
        obj_user_medical_dtl.major_injury = $('#txt_major_injury').val().trim();
        obj_user_medical_dtl.major_prolonged_illness = $('#txt_major_prolonged_illness').val().trim();
        obj_user_medical_dtl.major_dental_surgery = $('#txt_major_dental_surgery').val().trim();
        obj_user_medical_dtl.other_habits = $('#txt_other_habits').val().trim();
        obj_user_medical_dtl.irregular_sleep_pattern = $('#txt_irregular_sleep_pattern').val().trim();
        obj_user_medical_dtl.dietary_habits = $('#txt_dietary_habits').val().trim();
        obj_user_medical_dtl.insurance_card_no = $('#txt_insurance_card_no').val().trim();


        var obj_family_health_history = { 'high_bp': '', 'diabetes': '', 'tuberculosis': '', 'ischemia_heart_disease': '', 'thalassemia': '', 'other': '' };

        obj_family_health_history.high_bp = $('#txt_high_bp').val().trim();
        obj_family_health_history.diabetes = $('#txt_diabetes').val().trim();
        obj_family_health_history.tuberculosis = $('#txt_tuberculosis').val().trim();
        obj_family_health_history.ischemia_heart_disease = $('#txt_ischemia_heart_disease').val().trim();
        obj_family_health_history.thalassemia = $('#txt_thalassemia').val().trim();
        obj_family_health_history.other = $('#txt_other').val().trim();

        var All_table_student_data = [obj_user_mst, obj_user_medical_dtl, obj_family_health_history];
        var json_All_table_student_data = JSON.stringify(All_table_student_data);

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Modify_student_data",
            data: "{'json_student_detail' : '" + json_All_table_student_data + "'}",
            dataType: "json",
            success: function (data) {
                // bind_grid();
                if (data.d != '') {
                    debugger;

                    if (data.d == "Email") {
                        bootbox.alert("This email id is already used.");
                        return false;
                    }

                    var a = data.d.split(' ');

                    if (a[0] == "Data") {


                        bootbox.alert('Data Modified Successfully');

                        reset();

                        binduserdata();

                        return false;


                    }
                    else {
                        alert(data.d);
                    }

                    return false;

                }



                return false;


            },
            error: function (data) {
                alert(data.d);
                return false;
            }
        });


        return false;

    });

    $('#Clear').on('click', function () {
        window.location.href = "User_Modification.aspx";
    });
    if (window.location.search.indexOf('?studentCode') > -1) {
        $('#drp_dept').val(atob(getParameterByName('DeptCode')));
        $('#drp_dept').trigger("liszt:updated");
        $('#drp_prog').val(atob(getParameterByName('ProgCode')));
        $('#drp_prog').trigger("liszt:updated");
        $('#drp_year').val(atob(getParameterByName('YearCode')));
        $('#drp_year').trigger("liszt:updated");
        binduserdata();
        $('#drpuser').val(atob(getParameterByName('studentCode')));
        $('#drpuser').trigger("liszt:updated"); $('#btnreterive').click();
    }
});

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(window.location.href);
    if (results == null)
        return "";
    else
        return decodeURIComponent(results[1].replace(/\+/g, " "));
}

function reset() {

    $('#drpavtice').val('A');
    $('#drp_status').val('A');

    $('#txt_userid').val('');
    $('#txt_enrollment_no').val('');

    $('#txtpassword').val('');
    $('#txt_firstname').val('');
    $('#txt_middelname').val('');
    $('#txt_Lastname').val('');
    $('#txtnationality').val('');
    $('#txt_full_name').val('');

    $('#drpgender').val('0');
    $('#txtdob').val('');
    $('#txtbloodgrp').val('0');

    $('#txtmobileno').val('');
    $('#txtemail').val('');

    $('#drp_prog_level').val('');
    $('#drp_prog_level').trigger("liszt:updated");

    $('#drpdepartment').val("");
    $('#drpdepartment').trigger("liszt:updated");

    $('#drpprog').val("");
    $('#drpprog').trigger("liszt:updated");

    $('#drpyear').val("");
    $('#drpyear').trigger("liszt:updated");

    $('#txt_economically_backward').val('');
    $('#txt_father_name').val('');
    $('#txt_mother_name').val('');
    $('#txt_guardian_contact_name').val('');
    $('#drp_category').val('OP');
    $('#drp_disability').val('N');


    //////contact details rset//////
    $('#txtperadd').val('');
    $('#txtadd').val('');
    $('#txt_student_contact_no').val('');
    $('#txtaltemail').val('');
    $('#txt_residence_no').val('');
    $('#txtmobileno').val('');
    $('#txt_emergency_contact_2').val('');
    $('#txt_emergency_relationship').val('');
    $('#txt_father_contact').val('');
    $('#txt_mother_contact').val('');
    $('#txt_guardian_contact').val('');
    $('#txt_father_email').val('');
    $('#txt_mother_email').val('');
    $('#txt_guardian_email').val('');
    $('#txtDOJ').val('');
    $('#txt_registered_current_sem').val('');

    ///////////////////////////////////////

    /////////Medical Details///////////

    $('#txt_height').val('');
    $('#txt_weight').val('');
    $('#txt_vision_ability').val('');
    $('#txt_blindness_color').val('');
    $('#txt_eye_color').val('');
    $('#txt_identification_1').val('');
    $('#txt_identification_2').val('');
    $('#txt_routine_health_complain').val('');
    $('#txt_allergic_to_drug').val('');
    $('#txt_disability').val('');
    $('#txt_major_illness').val('');
    $('#txt_tb_typhoid_asthama').val('');
    $('#txt_major_injury').val('');
    $('#txt_major_prolonged_illness').val('');
    $('#txt_major_dental_surgery').val('');
    $('#txt_other_habits').val('');
    $('#txt_irregular_sleep_pattern').val('');
    $('#txt_dietary_habits').val('');
    $('#txt_insurance_card_no').val('');

    /////////////////////////

    $('#txt_high_bp').val('');
    $('#txt_diabetes').val('');
    $('#txt_tuberculosis').val('');
    $('#txt_ischemia_heart_disease').val('');
    $('#txt_thalassemia').val('');
    $('#txt_other').val('');

}

function IsNumeric(e) {


    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {


        return true;
    }
    else {
        return false;
    }
}

function binduserdata() {
    
    if ($('#drp_dept').val() != '' && $('#drp_prog').val() != '' && $('#drp_year').val() != '') {


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_all_student_data_for_modification",
            async: false,
            data: "{'dept_code':'" + $('#drp_dept').val() + "','prog_code':'" + $('#drp_prog').val() + "','year_code':'" + $('#drp_year').val() + "'}",
            dataType: "json",
            success: function (data) {
                debugger;
                if (data.d != "") {


                    var year_data = JSON.parse(data.d)



                    $('#drpuser').empty().append($("<option></option>").val("").html("-- Please Select Student --"));
                    for (var i = 0; i < year_data.length; i++) {


                        $('#drpuser').append($("<option></option>").val(year_data[i]["user_id"]).html(year_data[i]["user_id"] + '-' + year_data[i]["user_name"]));
                    }

                    $('#drpuser').chosen();
                    $('#drpuser').trigger("liszt:updated");
                }
                else {

                    $('#drpuser')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No Student found</option>')
                .val('');
                    $('#drpuser').chosen();

                    $('#drpuser').val('').trigger("liszt:updated");
                }


            },
            error: function (result) {
                alert(result);
            }
        });
    }
}

function binddepartment() {
    debugger;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {
                debugger;
                var sem_data = JSON.parse(data.d)

                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                for (var i = 0; i < sem_data.length; i++) {
                    $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                }

                $('#drp_dept').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                for (var i = 0; i < sem_data.length; i++) {
                    $('#drp_dept').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                }

                $('#drp_dept').chosen();
                $('#drpdepartment').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bind_prog_level_data() {
    debugger;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_program_level_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {
                debugger;
                var sem_data = JSON.parse(data.d)

                $('#drp_prog_level').empty().append($("<option></option>").val("").html("-- Please Select Program Level --"));
                for (var i = 0; i < sem_data.length; i++) {
                    $('#drp_prog_level').append($("<option></option>").val(sem_data[i]["prog_level_code"]).html(sem_data[i]["prog_level_desc"]));
                }
                $('#drp_prog_level').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}




function bindprogrammedata() {

    $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

    $('#drpprog').chosen();

    $('#drp_prog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
    $('#drp_prog').append($("<option></option>").val("1").html("Undergraduate"));
    $('#drp_prog').append($("<option></option>").val("2").html("Postgraduate"));
    $('#drp_prog').append($("<option></option>").val("3").html("Doctoral"));

    $('#drp_prog').chosen();
}

function bindyeardata() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_year_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var year_data = JSON.parse(data.d)



                $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                for (var i = 0; i < year_data.length; i++) {


                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();

                $('#drp_year').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                for (var i = 0; i < year_data.length; i++) {


                    $('#drp_year').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                }

                $('#drp_year').chosen();

                $('#drpyear').chosen();
            }

        },
        error: function (result) {
            alert(result);
        }
    });
}

function eductionbindata(data) {
    var E_details = JSON.parse(data);
    $("#tbleducation tbody").html('');

    for (var i = 0; i < E_details.length; i++) {
        var str_edu = "<tr><td><span style='width: 202px;' type='text' class='degree'></span></td> ";
        str_edu += "<td><span style='width: 202px;' type='text' class='Institution'></span></td> ";
        str_edu += "<td><span style='width: 202px;' type='text' class='university'></span></td> ";
        str_edu += "<td><span style='width: 202px;' type='text' class='education_major_subject'></span></td> ";
        str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='year_of_completion' onkeypress='return isNumber(event);'></span></td> ";
        str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='education_score' onkeypress='return isNumber(event);'></span></td> ";
        str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='nata_id' onkeypress='return isNumber(event);'></span></td> ";
        str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='nata_score' onkeypress='return isNumber(event);'></span></td> ";
        str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='nata_second_score' onkeypress='return isNumber(event);'></span></td> ";

        $('#tbleducation tbody').append(str_edu);
        count++;
    }

    $("#tbleducation tbody tr").each(function (j) {
        for (var i = 0; i < E_details.length; i++) {
            if (j == i) {
                $(this).find(".degree").html(E_details[i].degree_type);
                $(this).find(".Institution").html(E_details[i].education_institution);
                $(this).find(".university").html(E_details[i].education_university_type);
                $(this).find(".year_of_completion").html(E_details[i].education_passing_year);
                $(this).find(".nata_id").html(E_details[i].nata_id);
                $(this).find(".nata_score").html(E_details[i].nata_score);
                $(this).find(".nata_second_score").html(E_details[i].nata_second_score);
                $(this).find(".education_major_subject").html(E_details[i].education_major_subject);
                $(this).find(".education_score").html(E_details[i].education_score);
            }
        }
    });
}



