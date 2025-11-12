var oTable;
var oTable1;
var oTable2;

var feedback_saved_data = '';
var FileName = '';

$(document).ready(function () {

    $('#txt_dob').datepicker({ dateFormat: 'dd/mm/yy' });

    $('#myModal').modal(
        {
            backdrop: 'static',
            keyboard: false
        });

    $('#myModal').modal('hide');

    $('#modal_credit_bifurcation').modal(
        {
            backdrop: 'static',
            keyboard: false
        });

    $('#modal_credit_bifurcation').modal('hide');

    $('#my_instruction').modal(
        {
            backdrop: 'static',
            keyboard: false
        });

    $('#my_instruction').modal('hide');

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/check_Gender",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d == false) {
                //$('#myModal').modal('show');
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/check_instruction",
                    data: "{}",
                    contentType: "application/json",
                    async: false,
                    cache: false,
                    datatype: "json",
                    success: function (data) {
                        if (data.d == false) {
                            //$('#my_instruction').modal('show');
                        }
                        else {
                        }
                    },
                    Error: function (data) {
                        alert(data.d);
                    }
                });
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/check_session",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d == false) {
                bootbox.alert('Session expired, Please login to continue.', function () {
                    window.location.href = "../Login.aspx";
                });
            }
            else {
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_sws_parked_credits",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                $("#sws_parked_credits").text(data.d);
            } else {
                $("#sws_parked_credits").text("0");
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    if (getParameterByName("autho") == 'false') {
        bootbox.alert('You are not authorized to view this page.');
    }

    //binddata();

    bind_saved_data();
    bind_validation_data();

    bind_assigned_data();

    getcredit_choice_data();

    get_fees_status();

    get_earned_credits_dtl();

    Mandatory_course_data_for_student_view();

    View_hostel_fees_payment();

    $('#btnsavegender').on('click', function () {

        //var pattern = /^\d{10}$/;
        //if (pattern.test($('#txt_contact_number').val())) {

        //}
        //else {
        //    bootbox.alert("Please Enter Only Number In Contact Number");

        //    return false;
        //}

        //if (FileName == '') {
        //    bootbox.alert("Please Upload Photo");
        //    return false;
        //}

        if ($('#txt_first_name').val() == '') {
            bootbox.alert("Please Enter Name");
            return false;
        }

        //if ($('#txt_last_name').val() == '') {
        //    bootbox.alert("Please Enter Last Name");
        //    return false;
        //}

        var blood_group = $('#drpbloodgroup').val();
        if (blood_group == "0") {
            bootbox.alert("Please Select Blood Group");
            return false;
        }

        if ($('#txt_dob').val() == '') {
            bootbox.alert("Please Enter Date of Birth");
            return false;
        }

        //if ($('#txt_emergency_name').val() == '') {
        //    bootbox.alert("Please Enter Emergency Contact Name");
        //    return false;
        //}

        //if (isNaN($('#txt_emergency_contact_number').val())) {
        //    bootbox.alert("Please Enter Only Number In Emergency Contact Number");
        //    return false;
        //}
        //var emergency_contact_no = $('#txt_emergency_contact_number').val();
        //if (emergency_contact_no == "") {
        //    bootbox.alert("Please Enter Emergency Contact Number");
        //    return false;
        //}
        //else if (emergency_contact_no.length < 10) {
        //    bootbox.alert("Please Enter 10 Digit Emergency Contact Number");
        //    return false;
        //}

        //if ($('#txt_father_name').val() == '') {
        //    bootbox.alert("Please Enter Father's Name");
        //    return false;
        //}

        //if ($('#txt_father_email').val() == '') {
        //    //bootbox.alert("Please Enter Father's Email Id");
        //    // return false;
        //}
        //else {
        //    var reg_email = /\S+@\S+\.\S+/;
        //    if (!reg_email.test($('#txt_father_email').val())) {
        //        bootbox.alert("Invalid Father's Email Id");
        //        return false;
        //    }
        //}

        //if (isNaN($('#txt_father_contact_no').val())) {
        //    bootbox.alert("Please Enter Only Number In Father's Contact Number");
        //    return false;
        //}
        //var father_contact_no = $('#txt_father_contact_no').val();
        //if (father_contact_no == "") {
        //    bootbox.alert("Please Enter Father's Contact Number");
        //    return false;
        //}
        //else if (father_contact_no.length < 10) {
        //    bootbox.alert("Please Enter 10 Digit Father's Contact Number");
        //    return false;
        //}

        //        if ($('#txt_guardian_name').val() == '') {
        //            bootbox.alert("Please Enter Guardian Name");
        //            return false;
        //        }

        //        if (isNaN($('#txt_guardian_contact_number').val())) {
        //            bootbox.alert("Please Enter Only Number In Guardian Contact Number");
        //            return false;
        //        }
        //        var guardian_contact_no = $('#txt_guardian_contact_number').val();
        //        if (guardian_contact_no == "") {
        //            bootbox.alert("Please Enter Guardian Contact Number");
        //            return false;
        //        }
        //        else if (guardian_contact_no.length < 10) {
        //            bootbox.alert("Please Enter 10 Digit Guardian Contact Number");
        //            return false;
        //        }

        //        if ($('#txt_religion').val() == "") {
        //            bootbox.alert("Please Enter Religion");
        //            return false;
        //        }
        //        if ($('#txt_relationship_with_emergency_contact').val() == "") {
        //            bootbox.alert("Please Enter Relation with Emergency Contact");
        //            return false;
        //        }

        //        if ($('#txt_guardian_email').val() == '') {
        //            //bootbox.alert("Please Enter Father's Email Id");
        //            // return false;
        //        }
        //        else {
        //            var reg_email = /\S+@\S+\.\S+/;
        //            if (!reg_email.test($('#txt_guardian_email').val())) {
        //                bootbox.alert("Invalid Emergency Contact's Email Id");
        //                return false;
        //            }
        //        }


        //        if (isNaN($('#txt_contact_number').val())) {

        //            bootbox.alert("Please Enter Only Number In Contact Number");

        //            return false;
        //        }
        //        var contact_no = $('#txt_contact_number').val();
        //        if (contact_no == "") {

        //            bootbox.alert("Please Enter Contact Number");

        //            return false;

        //        }
        //        else if (contact_no.length < 10) {
        //            bootbox.alert("Please Enter 10 Digit Contact Number");

        //            return false;

        //        }

        //        var email = $('#txt_alternet_email').val();
        //        if (email == "") {
        //            bootbox.alert('Please Insert Email Address')
        //            $('#txtemail').focus();
        //            return false;
        //        }

        //        var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        //        if (testEmail.test(email)) {

        //        }
        //        else {
        //            bootbox.alert("Please Enter Valid Email");
        //            $('#txtemail').focus();

        //            return false;
        //        }

        if ($('#chkregistration').is(':checked')) {
        }
        else {
            bootbox.alert("Please tick Checkbox.");
            return false;
        }

        var obj_personal_detail = { 'profile_photo': '', 'first_name': '', 'last_name': '', 'blood_group': '', 'gender': '', 'dob': '', 'father_name': '', 'father_email': '', 'father_contact_no': '', 'mother_name': '', 'mother_email': '', 'mother_contact_no': '', 'emergency_contact_name': '', 'emergency_contact_number': '', 'guardian_contact_name': '', 'guardian_contact_number': '', 'religion': '', 'relationship_with_emergency_contact': '', 'guardian_email': '' };

        var dob_dd_mm = $("#txt_dob").datepicker("getDate");

        obj_personal_detail.profile_photo = FileName;
        obj_personal_detail.first_name = $('#txt_first_name').val();
        //obj_personal_detail.last_name = $('#txt_last_name').val();
        obj_personal_detail.blood_group = $('#drpbloodgroup').val();
        obj_personal_detail.gender = $('#drpgender').val();
        //obj_personal_detail.dob = $('#txt_dob').val();
        obj_personal_detail.dob = '' + (dob_dd_mm.getMonth() + 1) + '/' + dob_dd_mm.getDate() + '/' + dob_dd_mm.getFullYear();
        obj_personal_detail.emergency_contact_name = $('#txt_emergency_name').val();
        obj_personal_detail.emergency_contact_number = $('#txt_emergency_contact_number').val();

        obj_personal_detail.father_name = $('#txt_father_name').val();
        obj_personal_detail.father_email = $('#txt_father_email').val();
        obj_personal_detail.father_contact_no = $('#txt_father_contact_no').val();
        //obj_personal_detail.mother_name = $('#txt_mother_name').val();
        //obj_personal_detail.mother_email = $('#txt_mother_email').val();
        //obj_personal_detail.mother_contact_no = $('#txt_mother_contact_no').val();

        //obj_personal_detail.guardian_contact_name = $('#txt_guardian_name').val();
        //obj_personal_detail.guardian_contact_number = $('#txt_guardian_contact_number').val();
        //obj_personal_detail.religion = $('#txt_religion').val();
        obj_personal_detail.relationship_with_emergency_contact = $('#txt_relationship_with_emergency_contact').val();
        obj_personal_detail.guardian_email = $('#txt_guardian_email').val();

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/Save_Gender_data",
            //data: "{'gender' : '" + $('#drpgender').val() + "' , 'contact_no' :'" + contact_no + "', 'email' : '" + email + "', 'blood_grp':'" + blood_group + "'}",
            data: "{'json_personal_detail' : '" + JSON.stringify(obj_personal_detail) + "'}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {
                if (data.d == true) {
                    bootbox.alert("Your Registration data are updated successfully.");
                    $('#myModal').modal('hide');

                    //$('#my_instruction').modal('show');
                }
                else {
                    bootbox.alert("Your Registration data are not updated");
                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });
    });

    $('#btn_save_instruction').on('click', function () {
        if ($('#chk_agree_afidavite').is(':checked')) {
        }
        else {
            bootbox.alert("Please tick first chekbox");
            return false;
        }

        if ($('#chk_agree_reg_process').is(':checked')) {
        }
        else {
            bootbox.alert("Please tick Second chekbox");
            return false;
        }

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/Save_registration_instruction_data",
            data: "{}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {
                if (data.d == true) {
                    //bootbox.alert("Your Gender is updated successfully.");
                    //$('#myModal').modal('hide');

                    $('#my_instruction').modal('hide');
                }
                else {
                    //bootbox.alert("Your Gender is not updated");
                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });
    });

    $('#btn_save').on('click', function () {

        var credit = $('#txtcreditchoice').val();

        if (credit == "") {
            bootbox.alert("Please Enter Credit Choice");
            return false;
        }

        if (credit > 24) {
            bootbox.alert("You Can Select Max. 24 credit");
            return false;
        }

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/save_choice_credit_for_student",
            data: "{creadit_choice: '" + credit + "'}",
            contentType: "application/json",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "There is no current semester detail found.") {
                        bootbox.alert("Your current semester detail is not found in system.");
                        return false;
                    }

                    if (data.d == "allocate") {
                        bootbox.alert("You can not change credit choice for current semester.Course allocation is Completed for current semester");
                        return false;
                    }

                    bootbox.alert('Data Saved Succesfully');
                }
                else {

                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });
        return false;
    });

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Check_studio_brief_display",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d == true) {
                $("#view_vertical_studio").css('display', '');
            }
            else {
                $("#view_vertical_studio").css('display', '');
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    CampusEntry('ready');
});

function IsNumeric(e) {
    //alert(e.which + " : " + e.keyCode);
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {

        //if (parseInt($(document.activeElement).val()) > 10) {
        //    return false;
        //}
        //else if (parseInt($(document.activeElement).val()) == 10) {
        //    if (keyCode != 48) {
        //        return false;
        //    }
        //}

        return true;
    }
    else {
        return false;
    }
}

function getcredit_choice_data() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_saved_credit_choice_data",
        data: "{}",
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                var data = JSON.parse(data.d);
                $('#txtcreditchoice').val(data[0]["credit_choice"]);
            }
            else {

            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
    return false;
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

function View_hostel_fees_payment() {

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/check_Gender_view_hostel_fees_payment",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d == false) {
                $('#hostel_menu').remove();
            }
            else {
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

}

function binddata() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_student_current_sem_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                DisplayData(data.d);
            }
            else {
                bootbox.alert("There is no Selected Course available.Please Select Course For Current Semester");
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
    return false;
}
/*Start - Mayur 17/09/2018*/
$(document).on("click", ".course_outlin_oTable2_download", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);

    $('#hdn_course_code').val(aData["course_code"]);
    $('#hdn_sem_code').val(aData["semester_type"]);
    $('#hdn_year_code').val(aData["year_semester"]);
    $('#btn_download').click();
});
/*End - Mayur 17/09/2018*/
function bind_saved_data() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_student_saved_current_sem_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                Display_saved_Data(data.d);
            }
            else {

            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
    return false;
}




function bind_assigned_data() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_student_assigned_current_sem_data",
        data: {},
        contentType: "application/json",
        async: false,
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                Display_registered_Data(data.d);
            }
            else {

            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
    return false;
}

function bind_validation_data() {

    var status = false;
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_mandatory_certificate_dtl",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                certificate_dtl = JSON.parse(data.d);
                //if (parseInt(certificate_dtl[0]['year_code']) >= parseInt('2021')) {
                var str_html = '<table class="tbl_credits_dtl"><tr><th>Name</th><th>Status</th></tr>';
                for (var i = 0; i < certificate_dtl.length; i++)
                {

                    if (certificate_dtl[i]['apaaridStatus'] == "Y")
                    {
                        if (certificate_dtl[i]['apaaridsaveornot'] == 'N') {
                            str_html += '<tr class="sem_tr1"><td>Apaar ID</td>' +
                                '<td>Pending</td>' +
                                '</tr>';
                        }
                        else {
                            str_html += '<tr class="sem_tr1"><td>Apaar ID</td>' +
                            '<td>Submitted</td>' +
                            '</tr>';}

                        
                    }
                    else {

                        str_html += '<tr class="sem_tr1"><td>Apaar ID</td>' +
                            '<td>Pending</td>' +
                            '</tr>';

                    }
                    // close by nitinbhai 09072025
                    //if (certificate_dtl[i]['consent_status'] == "A")
                    //{
                    //    str_html += '<tr class="sem_tr1"><td>Parental Consent Form</td>' +
                    //        '<td>Submitted</td>' +
                    //        '</tr>';
                    //}
                    //else
                    //{
                    //
                    //    str_html += '<tr class="sem_tr1"><td>Parental Consent Form</td>' +
                    //        '<td>Pending</td>' +
                    //        '</tr>';
                    //
                    //}

                    if (certificate_dtl[i]['medical_certificate'] != "") {
                        str_html += '<tr class="sem_tr1"><td>Medical Fitness Certificate</td>' +
                            '<td>Submitted</td>' +
                            /*        '<td></td></tr>';*/
                            '</tr>';
                    }
                    else {

                        str_html += '<tr class="sem_tr1"><td>Medical Fitness Certificate</td>' +
                            '<td>Pending</td>' +
                            /*'<td><a href="' + location.origin + '\\Student\\student_medical_fintness_certificate.aspx">Click Here</a></td></tr>';*/
                            '</tr>';

                    }

                    if (certificate_dtl[i]['antiragging_certificate'] != "") {
                        str_html += '<tr class="sem_tr1"><td>Anti-Ragging Certificate</td>' +
                            '<td>Submitted</td>' +
                            /*'<td></td></tr>';*/
                            '</tr>';
                    }
                    else {

                        str_html += '<tr class="sem_tr1"><td>Anti-Ragging Certificate</td>' +
                            '<td>Pending</td>' +
                            /*'<td><a href="' + location.origin + '\\Student\\student_antiragging_certificate.aspx">Click Here</a></td></tr>';*/
                            '</tr>';

                    }

                    if (certificate_dtl[i]['birth_certificate'] != "") {
                        str_html += '<tr class="sem_tr1"><td>Proof Of DOB</td>' +
                            '<td>Submitted</td>' +
                            '</tr>';
                    }
                    else if (certificate_dtl[i]['school_leaving_certificate'] != "") {
                        str_html += '<tr class="sem_tr1"><td>Proof Of DOB</td>' +
                            '<td>Submitted</td>' +
                            '</tr>';

                    }
                    else {

                        str_html += '<tr class="sem_tr1"><td>Proof Of DOB</td>' +
                            '<td>Pending</td>' +
                            '</tr>';

                    }
                    // close by nitinbhai 09072025
                    //if (certificate_dtl[i]['vaccination_status'] != "") {
                    //    str_html += '<tr class="sem_tr1"><td>Covid Vaccine Certificate</td>' +
                    //        '<td>Submitted</td>' +
                    //        '</tr>';
                    //}
                    //else {

                    //    str_html += '<tr class="sem_tr1"><td>Covid Vaccine Certificate</td>' +
                    //        '<td>Pending</td>' +
                    //        '</tr>';

                    //} 

                    //if (certificate_dtl[i]['dob'] != "") {
                    //    str_html += '<tr><td>Date of Birth</td>' +
                    //        '<td>Submitted</td>' +
                    //        //'<td></td></tr>';
                    //        '</tr>';
                    //}
                    //else {
                    //    str_html += '<tr><td>Date of Birth</td>' +
                    //        '<td>Pending</td>' +
                    //        /*'<td><a href="' + location.origin + '\\Student\\student_birth_leaving_certificate.aspx">Click Here</a></td></tr>';*/
                    //        '</tr>';
                    //}

                    if (certificate_dtl[i]['blood_group'] != "") {
                        str_html += '<tr class="sem_tr1"><td>Blood Group</td>' +
                            '<td>Submitted</td>' +
                            /* '<td></td></tr>';*/
                            '</tr>';
                    }
                    else {

                        str_html += '<tr class="sem_tr1"><td>Blood Group</td>' +
                            '<td>Pending</td>' +
                            /* '<td><a href="' + location.origin + '\\Student\\Blood_Group.aspx">Click Here</a></td></tr>';*/
                            '</tr>';
                    }

                }
                str_html += '</table>';
                $("#validation_list").html(str_html);
                $('#validation_status').css('display', 'block');
                $('#validation_list').css('display', 'block');
                $('#validation_body').css('display', 'block');
                return false;
                //}
                //else {
                //    $('#validation_status').css('display', 'none');
                //    $('#validation_list').css('display', 'none');
                //    $('#validation_body').css('display', 'none');
                //    return false;
                //}

            }
            else {


            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });



}

function get_fees_status() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        async: false,
        datatype: "json",
        success: function (data) {
            //alert('kamlesh');
            if (data.d != "") {
                fees_status = JSON.parse(data.d);
                if (fees_status[0]["fees_status"] == "F") {
                    //$('#lbl_fees_status').text("Paid full fees (for 24 credits)");
                    $('#lbl_fees_status').text("Full Fees");
                    if (fees_status[0]["installment_status"] == "Y") {
                        $('#lbl_fees_status').text("Full Fees (Installment)");
                    }
                }
                if (fees_status[0]["fees_status"] == "H") {
                    $('#lbl_fees_status').text("Half Fees");
                    //$('#lbl_fees_status').text("Paid half fees (for 12 credits)");
                }
                if (fees_status[0]["no_of_installment"] > 0) {
                    var str = "<table style='margin-left:25%;padding:4px;text-align:center;border: 1px solid black;'><tbody><tr><th style='padding:4px;text-align:center;border: 1px solid black;'>Installment No</th><th style='padding:4px;text-align:center;border: 1px solid black;'>Status</th></tr>";//<th style='padding:4px;text-align:center;border: 1px solid black;'>Fine</th>
                    for (var i = 1; i <= fees_status[0]["no_of_installment"]; i++) {
                        str += "<tr><td style='padding:4px;text-align:center;border: 1px solid black;'>" + i + "</td>";
                        if (fees_status[0]["is_installment" + i + "_paid"] == "Y") {
                            str += "<td style='padding:4px;text-align:center;border: 1px solid black;'>Paid</td>";
                        } else {
                            str += "<td style='padding:4px;text-align:center;border: 1px solid black;'>Pending</td>";
                        }
                        //str += "<td style='padding:4px;text-align:center;border: 1px solid black;'>" + "0" + "</td></tr>";
                    }
                    $("#fees_installment_status").html(str);
                }
            }
            else {
                $('#lbl_fees_status').text('Fees not paid');
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    return false;
}

function DisplayData(data) {

    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //"sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        "oTableTools": {
            "aButtons": [
                "copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls", "pdf"]
                }
            ]
        },
        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Priority", "mData": "priority", "bSortable": false },
            { "sTitle": "Semester", "mData": "semester_code", "bSortable": false },
            { "sTitle": "Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Credits", "mData": "credits", "bSortable": false },

            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "GPA/Non GPA", "mData": "gpa_nongpa", "bSortable": false }

        ]
    });
}

function Display_saved_Data(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#datalist_saved").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_saved"><thead></thead><tbody> </tbody></table>');
    }
    oTable = $("#datatable_saved").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        // "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        //        "oTableTools": {
        //            "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls", "pdf"]
        //							}
        //						]
        //        },

        "aaData": JSON.parse(data),
        "aoColumns": [
            //{ "sTitle": "Course", "mData": "course", "bSortable": false },
            /*Start - Mayur 17/09/2018*/
            {
                "sTitle": "Course", "bSortable": false, "mData": "course", "mRender": function (course) {
                    return '<a style="cursor:pointer" class="course_outlin_oTable2_download" >' + course + '</a>';
                }
            },
            /*End - Mayur 17/09/2018*/
            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false }
        ]
    });

    $('#datalist_saved').css('display', 'block');
}





function Display_registered_Data(data) {
    if (oTable1 != null) {
        oTable1.fnDestroy();
        $("#datalist_register").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_register"><thead></thead><tbody style="cursor: pointer;"> </tbody></table>');
    }

    oTable1 = $("#datatable_register").dataTable({
        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course", "mData": "course", "bSortable": false },
            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "GPA/NonGPA", "mData": "gpa_nongpa", "bSortable": false },
            { "sTitle": "Credits", "mData": "course_credits", "bSortable": false }
        ]
    });
    $('#datalist_register').css('display', 'block');
}

function get_earned_credits_dtl() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_earned_credits_dtl",
        data: {},
        contentType: "application/json",
        async: false,
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                debugger;
                var credits_data_all_sem = JSON.parse(data.d);
                var credit_dtl = credits_data_all_sem.message["other_sem_credits_detail"];

                var total_credits = 0;
                if (credit_dtl[0]['earned_credits'] != "") {
                    total_credits = total_credits + parseInt(credit_dtl[0]['earned_credits']);
                    //total_credits = total_credits + parseInt(credit_dtl[0]['alloted_credits']);
                }
                 
                total_credits = total_credits + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][0]["total_earned_foundation"]) + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][1]["total_earned_foundation"]);

                var mandatory_credits = 0;
                if (credit_dtl[0]['earned_mandatory_credits'] != "") {
                    mandatory_credits = mandatory_credits + parseInt(credit_dtl[0]['earned_mandatory_credits']);
                }

                mandatory_credits = mandatory_credits + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][0]["total_earned_foundation"]) + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][1]["total_earned_foundation"]);

                //Mayur 16-10-2019 Start - Logic of not showing credits untill grades publish and not submit feedback
                var current_alloted_credits = credits_data_all_sem.message["allocated_credits_cur_sem_details"];

                //var alloted_credits = parseInt(credit_dtl[0]['alloted_credits']) + parseInt(current_alloted_credits[0]['alloted_credits']) ;//09112022 Nitinbhai
                var alloted_credits = parseInt(credit_dtl[0]['alloted_credits']) + parseInt(current_alloted_credits[0]['alloted_credits']) + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][0]["total_earned_foundation"]) + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][1]["total_earned_foundation"]);
                //var alloted_mandatory_credits = parseInt(credit_dtl[0]['alloted_mandatory_credits']) + parseInt(current_alloted_credits[0]['alloted_mandatory_credits']);
                var alloted_mandatory_credits = parseInt(credit_dtl[0]['alloted_mandatory_credits']) + parseInt(current_alloted_credits[0]['alloted_mandatory_credits']) + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][0]["total_earned_foundation"]) + parseInt(credits_data_all_sem.message["sem1_sem2_credits_details"][1]["total_earned_foundation"]);
                var alloted_elective_credits = parseInt(credit_dtl[0]['alloted_elective_credits']) + parseInt(current_alloted_credits[0]['alloted_elective_credits']);
                var alloted_sws_credits = parseInt(credit_dtl[0]['alloted_sws_credits']) + parseInt(current_alloted_credits[0]['alloted_sws_credits']);
                var sws_alloted_mandatory_credits = parseInt(credit_dtl[0]['sws_alloted_mandatory_credits']) + parseInt(current_alloted_credits[0]['sws_alloted_mandatory_credits']);
                var sws_alloted_elective_credits = parseInt(credit_dtl[0]['sws_alloted_elective_credits']) + parseInt(current_alloted_credits[0]['sws_alloted_elective_credits']);

                var current_earned_credits = credits_data_all_sem.message["earned_credits_cur_sem_details"];

                total_credits = total_credits + parseInt(current_earned_credits[0]['earned_credits']);
                mandatory_credits = mandatory_credits + parseInt(current_earned_credits[0]['earned_mandatory_credits']);

                var earned_elective_credits = parseInt(credit_dtl[0]['earned_elective_credits']) + parseInt(current_earned_credits[0]['earned_elective_credits']);
                var earned_sws_credits = parseInt(credit_dtl[0]['earned_sws_credits']) + parseInt(current_earned_credits[0]['earned_sws_credits']);

                
                var sws_earned_mandatory_credits = parseInt(credit_dtl[0]['sws_earned_mandatory_credits']) + parseInt(current_earned_credits[0]['sws_earned_mandatory_credits']);
                
                var sws_earned_elactive_credits =  parseInt(credit_dtl[0]['sws_earned_elactive_credits']) + parseInt(current_earned_credits[0]['sws_earned_elactive_credits']);
                //Mayur 16-10-2019 End

              
                $('#td_total').html(credit_dtl[0]['total_credits']);
                $('#td_mandatory').html(credit_dtl[0]['mandatory_credits']);
                $('#td_elective').html(credit_dtl[0]['elective_credits']);
                $('#td_sws').html(credit_dtl[0]['sws_credits']);

                //Mayur 16-10-2019 Start - Logic of not showing credits untill grades publish and not submit feedback

                $('#td_total_alloted').html(alloted_credits);//credit_dtl[0]['alloted_credits']
                $('#td_mandatory_alloted').html(alloted_mandatory_credits);//credit_dtl[0]['alloted_mandatory_credits']
                $('#td_elective_alloted').html(alloted_elective_credits);//credit_dtl[0]['alloted_elective_credits']
                $('#td_sws_alloted').html(alloted_sws_credits);//credit_dtl[0]['alloted_sws_credits']

                //Mayur 16-10-2019 End

                $('#td_total_earned').html(total_credits);//Check Here credit_dtl[0]['earned_credits']
                $('#td_mandatory_earned').html(mandatory_credits);//Check Here credit_dtl[0]['earned_mandatory_credits']
                $('#td_elective_earned').html(earned_elective_credits);//credit_dtl[0]['earned_elective_credits']
                $('#td_sws_earned').html(earned_sws_credits);//credit_dtl[0]['earned_sws_credits']

                $('#td_sws_alloted_mandatory_credits').html(sws_alloted_mandatory_credits);
                $('#td_sws_alloted_elective_credits').html(sws_alloted_elective_credits);
                $('#td_sws_earned_mandatory_credits').html(sws_earned_mandatory_credits);
                $('#td_sws_earned_elactive_credits').html(sws_earned_elactive_credits);




                if (credit_dtl[0]['sws_credits'] == '0') {
                    $('#td_elective').attr('colspan', '2');
                    $('#td_sws').css('display', 'none');
                }
                $('#hdntotalearncredit').val(parseInt($('#td_total_earned').text()) + parseInt($('#td_sws_earned').text()))
                $('#hdntotalallocatecredit').val(parseInt($('#td_total_alloted').text()) + parseInt($('#td_sws_alloted').text()))
                $('#hdntotalcurrentsemcredit').val(parseInt(current_alloted_credits[0]['alloted_credits']) + parseInt(current_alloted_credits[0]['alloted_sws_credits']))
                $('#hdntotalcredit').val(parseInt($('#td_total_earned').text()) + parseInt($('#td_sws_earned').text()) + parseInt(current_alloted_credits[0]['alloted_credits']) + parseInt(current_alloted_credits[0]['alloted_sws_credits']))
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    return false;
}

function get_credit_bifurcation() {
    var credit_dtl_cur_sem;
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_cur_sem_earned_credit_bifurcation",
        data: {},
        contentType: "application/json",
        datatype: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                credit_dtl_cur_sem = JSON.parse(data.d);
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_credit_bifurcation",
        data: {},
        contentType: "application/json",
        datatype: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var credit_dtl = JSON.parse(data.d);

                var str_html = '<table class="tbl_credits_dtl"><tr><th class="brdr_lft" rowspan="2" style="width: 14%;"></th><th rowspan="2" style="width: 14%;"></th><th rowspan="2" style="width: 14%;">Total</th><th colspan="2" style="width: 14%;">Mandatory Courses</th><th colspan="2" style="width: 14%;">Elective Courses</th></tr><tr><th style="width: 14%!important;">GPA</th><th style="width: 14%!important;">NGPA</th><th style="width: 14%!important;">GPA</th><th style="width: 14%!important;">NGPA</th></tr>';
                //WORKING 30052022
                for (var i = 0; i < credit_dtl.length; i++) {
                    if (credit_dtl_cur_sem[0]["semester_type"] == credit_dtl[i]['semester_type'] && credit_dtl_cur_sem[0]["year_semester"] == credit_dtl[i]['year_semester']) {
                        str_html += '<tr class="sem_tr1"><td class="col_header brdr_lft" rowspan="2">' + credit_dtl[i]['semester_type'] + ' - ' + credit_dtl[i]['year_semester'] + '</td>' +
                            '<td class="col_header">Credits Alloted</td>' +
                            '<td>' + credit_dtl[i]['alloted_credits'] + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_gpa_mandatory_credits']) + parseInt(credit_dtl[i]['alloted_gpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_nongpa_mandatory_credits']) + parseInt(credit_dtl[i]['alloted_nongpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_gpa_elective_credits']) + parseInt(credit_dtl[i]['alloted_gpa_elective_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_nongpa_elective_credits']) + parseInt(credit_dtl[i]['alloted_nongpa_elective_sws_credits'])) + '</td>' +
                            '</tr><tr>' +
                            '<td class="col_header">Credits Earned</td>' +
                            '<td>' + credit_dtl_cur_sem[0]['earned_credits'] + '</td>' +
                            '<td>' + (parseInt(credit_dtl_cur_sem[0]['earned_gpa_mandatory_credits']) + parseInt(credit_dtl_cur_sem[0]['earned_gpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl_cur_sem[0]['earned_nongpa_mandatory_credits']) + parseInt(credit_dtl_cur_sem[0]['earned_nongpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl_cur_sem[0]['earned_gpa_elective_credits']) + parseInt(credit_dtl_cur_sem[0]['earned_gpa_elective_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl_cur_sem[0]['earned_nongpa_elective_credits']) + parseInt(credit_dtl_cur_sem[0]['earned_nongpa_elective_sws_credits'])) + '</td>';
                    }
                    else {
                        str_html += '<tr class="sem_tr1"><td class="col_header brdr_lft" rowspan="2">' + credit_dtl[i]['semester_type'] + ' - ' + credit_dtl[i]['year_semester'] + '</td>' +
                            '<td class="col_header">Credits Alloted</td>' +
                            '<td>' + credit_dtl[i]['alloted_credits'] + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_gpa_mandatory_credits']) + parseInt(credit_dtl[i]['alloted_gpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_nongpa_mandatory_credits']) + parseInt(credit_dtl[i]['alloted_nongpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_gpa_elective_credits']) + parseInt(credit_dtl[i]['alloted_gpa_elective_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['alloted_nongpa_elective_credits']) + parseInt(credit_dtl[i]['alloted_nongpa_elective_sws_credits'])) + '</td>' +
                            '</tr><tr>' +
                            '<td class="col_header">Credits Earned</td>' +
                            '<td>' + credit_dtl[i]['earned_credits'] + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['earned_gpa_mandatory_credits']) + parseInt(credit_dtl[i]['earned_gpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['earned_nongpa_mandatory_credits']) + parseInt(credit_dtl[i]['earned_nongpa_mandatory_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['earned_gpa_elective_credits']) + parseInt(credit_dtl[i]['earned_gpa_elective_sws_credits'])) + '</td>' +
                            '<td>' + (parseInt(credit_dtl[i]['earned_nongpa_elective_credits']) + parseInt(credit_dtl[i]['earned_nongpa_elective_sws_credits'])) + '</td>';
                    }
                }

                //var str_html = '<table class="tbl_credits_dtl"><tr><th class="brdr_lft" ></th><th></th><th>Total</th><th>Mandatory Courses</th><th>Elective Courses</th><th>SWS Courses</th></tr>';            

                //for (var i = 0; i < credit_dtl.length; i++) {
                //    if (credit_dtl_cur_sem[0]["semester_type"] == credit_dtl[i]['semester_type'] && credit_dtl_cur_sem[0]["year_semester"] == credit_dtl[i]['year_semester']) {
                //        str_html += '<tr class="sem_tr1"><td class="col_header brdr_lft" rowspan="2">' + credit_dtl[i]['semester_type'] + ' - ' + credit_dtl[i]['year_semester'] + '</td>' +
                //            '<td class="col_header">Credits Alloted</td>' +
                //            '<td>' + credit_dtl[i]['alloted_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['alloted_mandatory_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['alloted_elective_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['alloted_sws_credits'] + '</td>' +
                //            '</tr><tr>' +
                //            '<td class="col_header">Credits Earned</td>' +
                //            '<td>' + credit_dtl_cur_sem[0]['earned_credits'] + '</td>' +
                //            '<td>' + credit_dtl_cur_sem[0]['earned_mandatory_credits'] + '</td>' +
                //            '<td>' + credit_dtl_cur_sem[0]['earned_elective_credits'] + '</td>' +
                //            '<td>' + credit_dtl_cur_sem[0]['earned_sws_credits'] + '</td>';
                //    }
                //    else {
                //        str_html += '<tr class="sem_tr1"><td class="col_header brdr_lft" rowspan="2">' + credit_dtl[i]['semester_type'] + ' - ' + credit_dtl[i]['year_semester'] + '</td>' +
                //            '<td class="col_header">Credits Alloted</td>' +
                //            '<td>' + credit_dtl[i]['alloted_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['alloted_mandatory_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['alloted_elective_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['alloted_sws_credits'] + '</td>' +
                //            '</tr><tr>' +
                //            '<td class="col_header">Credits Earned</td>' +
                //            '<td>' + credit_dtl[i]['earned_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['earned_mandatory_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['earned_elective_credits'] + '</td>' +
                //            '<td>' + credit_dtl[i]['earned_sws_credits'] + '</td>';
                //    }
                //}

                str_html += '</table>';

                $('#modal_credit_bifurcation .modal-body').html(str_html);
                //$(".tbl_credits_dtl th").css("width", "14% !important");
                $('#modal_credit_bifurcation .tbl_credits_dtl').css('border', '1px solid rgb(151, 151, 151)');
                $('#modal_credit_bifurcation .tbl_credits_dtl th').css('border-top', '1px solid rgb(151, 151, 151)');
                $('.sem_tr1').children().css('border-top', '1px solid rgb(151, 151, 151)');
                $('.brdr_lft').css('border-left', '1px solid rgb(151, 151, 151)');

                $('#modal_credit_bifurcation').modal('show');
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    return false;
}

function UploadProfilePhoto() {
    try {
        var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

        var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

        if (CheckUserPhotoExtension(fileToUpload)) {

            var flag = true;

            if (filename != "" && filename != null) {

                if (flag == true) {
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../Handler/UserProfilePhoto.ashx',
                        secureuri: false,
                        fileElementId: 'imageUpload',
                        dataType: 'json',
                        success: function (data, status) {
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {
                                    $('#imageUpload').val("");

                                    FileName = data.upfile;

                                    $("#img_photo").attr("src", "../UserProfilePhoto/" + FileName);
                                    $("#img_photo").attr("alt", FileName);
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

$(document).on("click", ".course_outlin_link", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable2.fnGetData(row);

    var arr = aData;
    var data = arr["course"].split(' - ');
    var course_code = data[0];
    var year_semester = event.currentTarget.dataset["year"];
    var semester_type = event.currentTarget.dataset["semester"];

    window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester_type + '&year_code=' + year_semester + '&new_tab=N', "_newtab");
    //  var course_code = $('#hdn_course_code').val(aData["course_code"]);
});

function Mandatory_course_data_for_student_view() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_mandatory_course_data_for_student_view",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d[1] == '1') {
                    Display_mandatory_course_data_for_student_view(data.d);
                }
                //mandatory_course_data_for_student_view = JSON.parse(data.d);
                //for (var i = 0; i < mandatory_course_data_for_student_view.length; i++) {
                //    if (mandatory_course_data_for_student_view[i]["sub_category_id"] == '1') {
                //        alert("checking");
                //    }
                //}



            }
            else {
                //$('#lbl_fees_status').text('Fees not paid');
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });

    return false;
}

var semester_type;
var year_semester;

function Display_mandatory_course_data_for_student_view(data) {

    semester_type = data[2];
    year_semester = data[3];

    $("#view_line").css('display', 'block');

    if (oTable2 != null) {
        // oTable.fnDestroy();
        $("#view_list_course_data_for_student").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="view_course_data_for_student"><thead></thead><tbody> </tbody></table>');
    }
    oTable2 = $("#view_course_data_for_student").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        "aaData": JSON.parse(data[0]),
        "aoColumns": [
            //{
            //    "sTitle": "Course Code", "bSortable": false, "mData": "course_code", "mRender": function (course) {
            //        return '<a style="cursor:pointer" class="course_outlin_oTable2_download" >' + course + '</a>';
            //    }
            //},
            {
                "sTitle": "Course", "mData": "course", "bSortable": false, "mRender": function (data) {
                    return sub_category_id(data);
                }
            },
            //  { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            // { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
            //{ "sTitle": "Faculty", "mData": "dept_name", "bSortable": false }
        ]
    });

    $('#view_list_course_data_for_student').css('display', 'block');
}

function sub_category_id(data) {
    if (data == "") {
        return '<a style="cursor:pointer" class="course_outlin_link" data-semester="' + semester_type + '" data-year="' + year_semester + '" >' + data + '</a>';
    } else {
        return '<a style="cursor:pointer" class="course_outlin_link" data-semester="' + semester_type + '" data-year="' + year_semester + '" >' + data + '</a>';
    }
}