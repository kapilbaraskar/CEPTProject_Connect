var action = 'S';
var is_data_found = false;
var pattern = /^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/;
//var pattern = /^([0-9]|[012][0-9]|3[01])\/([0-9]|0[0-9]|1[0-2])\/([0-9]{4})$/



$(document).ready(function () {

    if ($('#hdnusertype').val() == 'FA') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                  "<i class='icon-save bigger-160'></i>Save</button></td> " +
                  "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                  "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }

    if ($('#hdnusertype').val() == 'I2') {
        var str = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display:block;' class='btn btn-primary'>" +
                  "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }

    if ($('#hdnusertype').val() == 'HR') {
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

    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2') {
        $('.cls_mendatory').css('display', 'inline-block');
    }

    $('#txt_first_name').focusout(function () {
        $('#txt_first_name').val($('#txt_first_name').val()[0].toUpperCase() + $('#txt_first_name').val().toLowerCase().substr(1));
    });

    $('#txt_last_name').focusout(function () {
        $('#txt_last_name').val($('#txt_last_name').val()[0].toUpperCase() + $('#txt_last_name').val().toLowerCase().substr(1));
    });

    $('#btnapprove').on('click', function () {

        action = 'S';

        if (!is_data_found) {
            bootbox.alert('No Instructor to update');
            action = 'S';
            return false;
        }

        if ($('#hdn_icode').val() == '') {
            bootbox.alert('No Instructor to update');
            return false;
        }

        if ($('#txt_vf_code').val() == '') {
            bootbox.alert('Please Enter VF Code');
            return false;
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

        //        if ($('#txt_alternate_contact_no').val() == '') {
        //            bootbox.alert('Please Enter Alternate Contact No');
        //            return false;
        //        }

        //        if ($('#txt_blood_group').val() == '') {
        //            bootbox.alert('Please Enter Blood Group');
        //            return false;
        //        }

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
//        else {
//            //var reg_exp = /^([a-zA-Z])([a-zA-Z])([a-zA-Z])([a-zA-Z])([0-9]{7})$/;
//            var reg_exp = /^([a-zA-Z]{4})([0-9]{7})$/;
//            if (!reg_exp.test($('#txt_ifsc_code').val())) {
//                bootbox.alert('IFSC code must have first 4 characters Alpha and rest Numbers');
//                return false;
//            }

//            //            if ($('#txt_ifsc_code').val().length < 4) {
//            //                //A-Z
//            //                if (keyCode >= 65 && keyCode <= 90) {
//            //                    return true;
//            //                }
//            //                //a-z
//            //                else if (keyCode >= 97 && keyCode <= 122) {
//            //                    return true;
//            //                }
//            //                else {
//            //                    return false;
//            //                }
//            //            }
//            //            else {
//            //                //0-9
//            //                if (keyCode >= 48 && keyCode <= 57) {
//            //                    return true;
//            //                }
//            //                else {
//            //                    return false;
//            //                }
//            //            }
//        }

        if ($('#txt_benificiary_name').val() == '') {
            bootbox.alert('Please Enter Benificiary name');
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

        //        if ($('#txt_associated_with_cept_since').val() == '') {
        //            bootbox.alert('Please Enter Associated with cept since detail');
        //            return false;
        //        }

        if ($('#txt_address').val() == '') {
            bootbox.alert('Please Enter Address');
            return false;
        }

        //        if ($('#txt_emergency_contact_name').val() == '') {
        //            bootbox.alert('Please Enter Emergency Contact Name');
        //            return false;
        //        }

        //        if ($('#txt_emergency_contact_no').val() == '') {
        //            bootbox.alert('Please Enter Emergency contact no');
        //            return false;
        //        }

                if (FileName == '') {
                    bootbox.alert('Please Upload CV');
                    return false;
                }

        action = 'A';

        $('#btnsave').click();
    });

    $('#drp_instructor_code').on('change', function () {
        $('#drp_instructor_name').val('');
        $('#drp_instructor_name').trigger("liszt:updated");
    });

    $('#drp_instructor_name').on('change', function () {
        $('#drp_instructor_code').val('');
        $('#drp_instructor_code').trigger("liszt:updated");
    });

    $('#btnsave').on('click', function () {

        if (!is_data_found) {
            bootbox.alert('No Instructor to update');
            action = 'S';
            return false;
        }

        if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2') {
            if ($('#hdn_icode').val() == '') {
                bootbox.alert('No Instructor to update');
                action = 'S';
                return false;
            }
        }

        if ($('#txt_first_name').val() == '') {
            bootbox.alert('Please Enter First Name');
            return false;
        }

        if ($('#txt_last_name').val() == '') {
            bootbox.alert('Please Enter Last Name');
            return false;
        }


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

        var instructor_data = { 'instructor_code': '', 'VF_code': '', 'first_name': '', 'last_name': '', 'title': '', 'mail': '', 'mobile_no': '', 'phone_no': '', 'blood_group': '', 'pan_card_no': '', 'bank_account_number': '', 'account_type': '', 'name_of_Bank': '', 'branch_name': '', 'ifsc_code': '', 'benificiary_name': '', 'dob': '', 'highest_qualification': '', 'total_experiance': '', 'associated_with_cept_since': '', 'address': '', 'emergency_contact_name': '', 'emergency_contact_number': '', 'degree': '', 'specialization': '', 'university': '', 'date_of_issuance_certificate': '', 'work_designation': '', 'work_institute': '', 'work_start_date': '', 'work_end_date': '', 'achievements': '', 'area_of_interest': '', 'cv_file_name': '' };

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
        instructor_data.bank_account_number = $('#txt_bank_account_no').val();
        instructor_data.account_type = $('#txt_account_type').val();
        instructor_data.name_of_Bank = $('#txt_name_of_the_bank').val();
        instructor_data.branch_name = $('#txt_branch_name').val();
        instructor_data.ifsc_code = $('#txt_ifsc_code').val();
        instructor_data.benificiary_name = $('#txt_benificiary_name').val();

        if ($('#txt_dob').val() != '') {
            var str_dob = $('#txt_dob').val().split('/');
            instructor_data.dob = str_dob[1] + '/' + str_dob[0] + '/' + str_dob[2];
        }

        instructor_data.highest_qualification = $('#txt_highest_qualification').val();
        instructor_data.total_experiance = $('#txt_total_experiance').val();
        instructor_data.associated_with_cept_since = $('#txt_associated_with_cept_since').val();
        instructor_data.address = $('#txt_address').val();
        instructor_data.emergency_contact_name = $('#txt_emergency_contact_name').val();
        instructor_data.emergency_contact_number = $('#txt_emergency_contact_no').val();

        //        instructor_data.degree = $('#txt_degree').val();
        //        instructor_data.specialization = $('#txt_specialization').val();
        //        instructor_data.university = $('#txt_university').val();
        //        instructor_data.date_of_issuance_certificate = $('#txt_date_of_issuance_certificate').val();

        //        instructor_data.work_designation = $('#txt_work_designation').val();
        //        instructor_data.work_institute = $('#txt_work_institute').val();
        //        instructor_data.work_start_date = $('#txt_work_start_date').val();
        //        instructor_data.work_end_date = $('#txt_work_end_date').val();

        instructor_data.achievements = $('#txt_achievements').val();

        instructor_data.area_of_interest = $('#txt_area_of_interest').val();

        instructor_data.cv_file_name = FileName;


        var education_dtl = [];
        var wrong_date_of_issuance_certificate = false;
        $('#tbl_academic_qualification tbody tr').each(function (i) {
            if (i > 0) {
                var education_row = { 'sr_no': '', 'degree': '', 'specialization': '', 'university': '', 'date_of_issuance_certificate': '' };

                education_row.sr_no = i;
                education_row.degree = this.children[0].children[0].value;
                education_row.specialization = this.children[1].children[0].value;
                education_row.university = this.children[2].children[0].value;

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
                    education_dtl.push(education_row);
                }
            }
        });

        if (wrong_date_of_issuance_certificate) {
            bootbox.alert('Please Enter Date of issuance certificate in DD/MM/YYYY format');
            action = 'S';
            return false;
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
        $('#tbl_work_experiance tbody tr').each(function (i) {
            if (i > 0) {
                var work_row = { 'sr_no': '', 'work_designation': '', 'work_institute': '', 'work_start_date': '', 'work_end_date': '' };

                work_row.sr_no = i;
                work_row.work_designation = this.children[0].children[0].value;
                work_row.work_institute = this.children[1].children[0].value;

                if (this.children[2].children[0].value != '') {

                    if (!pattern.test(this.children[2].children[0].value)) {
                        wrong_work_start_date = true;
                    }
                    if (this.children[2].children[0].value.split('/')[1] > 12) {
                        wrong_work_start_date = true;
                    }

                    var str_work_start_date = this.children[2].children[0].value.split('/');
                    work_row.work_start_date = str_work_start_date[1] + '/' + str_work_start_date[0] + '/' + str_work_start_date[2];
                }

                if (this.children[3].children[0].value != '') {

                    if (!pattern.test(this.children[3].children[0].value)) {
                        wrong_work_end_date = true;
                    }
                    if (this.children[3].children[0].value.split('/')[1] > 12) {
                        wrong_work_end_date = true;
                    }

                    var str_work_end_date = this.children[3].children[0].value.split('/');
                    work_row.work_end_date = str_work_end_date[1] + '/' + str_work_end_date[0] + '/' + str_work_end_date[2];
                }

                if (work_row.work_designation != '' || work_row.work_institute != '' || work_row.work_start_date != '' || work_row.work_end_date != '') {
                    work_dtl.push(work_row);
                }
            }
        });

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

        //        if (action == 'A') {
        //            if (work_dtl.length <= 0) {
        //                action = 'S';
        //                bootbox.alert('Please Enter atleast one Work Experiance Detail');
        //                return false;
        //            }
        //        }


        var All_instructor_data = [instructor_data, education_dtl, work_dtl, action];
        var json_All_instructor_data = JSON.stringify(All_instructor_data);

        if (json_All_instructor_data.search("'") != -1) {
            json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_instructor_data",
            async: false,
            data: "{ All_table_course_data: '" + json_All_instructor_data + "' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Data Saved Successfully') {
                    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2') {
                        if (action == 'A') {
                            bootbox.alert('Course Submitted Successfully', function () {
                                window.location = "VF_personal_detail.aspx";
                            });
                        }
                        else {
                            bootbox.alert(data.d, function () {
                                location.reload();
                            });
                        }
                    }
                    else if ($('#hdnusertype').val() == 'HR') {
                        retrieveInstructorData();
                    }
                }
                else if (data.d != "")
                {
                    alert(data.d);
                    return false;
                }
            },
            error: function (result) {
                alert(result);
                return false;
            }
        });

    });

    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2') {
        retrieveInstructorData();
    }

    if ($('#hdnusertype').val() == 'HR') {
        bind_instructor_code_data();
        bind_instructor_name_data();
    }

    $('#btnreterive').on('click', function () {
        retrieveInstructorData();
    });
});

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
    if (tbl == 'academic') {
        var str_row = "<tr><td><input type='text' class='marg-btm'/></td><td><input type='text' class='marg-btm'/></td><td><input type='text' class='marg-btm'/></td><td><input type='text' class='cls_date'/></td></tr>";
        $('#tbl_academic_qualification').append(str_row);
        $('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
    }
    else if (tbl == 'work') {
        var str_row = "<tr><td><input type='text' class='marg-btm'/></td><td><input type='text' class='marg-btm'/></td><td><input type='text' class='cls_date'/></td><td><input type='text' class='cls_date'/></td></tr>";
        $('#tbl_work_experiance').append(str_row);
        $('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
    }

    return false;
}

function retrieveInstructorData() {

    var instructor_code = '';

    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2') {
        instructor_code = $('#hdn_icode').val();

        if (instructor_code == '') {
            bootbox.alert('No Instructor found');
        }
    }
    else if ($('#hdnusertype').val() == 'HR') {
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

//                if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2') {
//                    if (instructor_data[0]["admin_approved"] == "Y" || instructor_data[0]["hr_approved"] == "Y") {
//                        bootbox.alert('Course already Submitted , You can not edit Faculty Detail after Submit', function () {
//                            location.replace("VF_personal_detail.aspx");
//                        });
//                        return false;
//                    }
//                }
//                else 
                if ($('#hdnusertype').val() == 'HR') {
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
                $('#txt_account_type').val(instructor_data[0]["account_type"]);
                $('#txt_name_of_the_bank').val(instructor_data[0]["name_of_Bank"]);
                $('#txt_branch_name').val(instructor_data[0]["branch_name"]);
                $('#txt_ifsc_code').val(instructor_data[0]["ifsc_code"]);
                $('#txt_benificiary_name').val(instructor_data[0]["benificiary_name"]);
                //$('#txt_dob').val(instructor_data[0]["dob"]);
                $('#txt_dob').val(convertDate(instructor_data[0]["dob"]));
                $('#txt_highest_qualification').val(instructor_data[0]["highest_qualification"]);
                $('#txt_total_experiance').val(instructor_data[0]["total_experiance"]);
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

                $('#lbl_cv_file_name').html('<b>' + instructor_data[0]["cv_file_name"] + '</b>');
                FileName = instructor_data[0]["cv_file_name"];

            }

            if (data.d[1] != null && data.d[1] != '') {
                var instructor_education_work = JSON.parse(data.d[1]);

                if (instructor_education_work.length > 0) {
                    var total_edu_row = 0;
                    var total_work_row = 0;

                    $('#tbl_academic_qualification tbody tr')[1].remove();
                    $('#tbl_work_experiance tbody tr')[1].remove();

                    for (var i = 0; i < instructor_education_work.length; i++) {
                        if (instructor_education_work[i]['detail_type'] == 'education') {
                            total_edu_row++;
                            var date_of_issuance_certificate = convertDate(instructor_education_work[i]['date_of_issuance_certificate']);

                            var str_row = "<tr><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['degree'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['specialization'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['university'] + "'/></td><td><input type='text' class='cls_date' value='" + date_of_issuance_certificate + "'/></td></tr>";
                            $('#tbl_academic_qualification').append(str_row);
                        }
                        else if (instructor_education_work[i]['detail_type'] == 'work') {
                            total_work_row++;
                            var work_start_date = convertDate(instructor_education_work[i]['work_start_date']);
                            var work_end_date = convertDate(instructor_education_work[i]['work_end_date']);

                            var str_row = "<tr><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['work_designation'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['work_institute'] + "'/></td><td><input type='text' class='cls_date' value='" + work_start_date + "'/></td><td><input type='text' class='cls_date' value='" + work_end_date + "'/></td></tr>";
                            $('#tbl_work_experiance').append(str_row);
                        }
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
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

var FileName = '';
function UploadProfilePhoto() {
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
                        dataType: 'json',
                        success: function (data, status) {
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {
                                    $('#cvUpload').val("");
                                    $('#lbl_cv_file_name').html('<b>' + fileToUpload + '</b>');

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