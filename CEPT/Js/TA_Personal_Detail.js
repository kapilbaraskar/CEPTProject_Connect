var action = 'S';
var is_data_found = false;
var pattern = /^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/;
//var pattern = /^([0-9]|[012][0-9]|3[01])\/([0-9]|0[0-9]|1[0-2])\/([0-9]{4})$/
var user_temp = false;
var bank_dtl_status = false;
var block = false;
var country_type = '';
var user_status = false;
var tutor_types = "";
var type = '';

$(document).ready(function () {

    $('.check_dept').attr('checked', true);
    type = getParameterByName('type');
    tutor_types = getParameterByName('type');
    var types = getParameterByName('ic');
    $('#hdn_icode').val(types);
    var types_ = getParameterByName('ie');
    $("#sd").css('display', 'none');

    if (type == "tutor") {
        if ($('#hdnusertype').val() == 'HR' && type == "tutor") {
            $("#under_mark").css("display", "block");
            $("#main_div_crdf").css("display", "block");

        }
        else {
            $("#for_I2").css("display", "");
            $("#main_div_crdf").css("display", "block");
            $("#under_mark").css("display", "block");
            $("#bank_1").css('display', 'none');
            $("#bank_2").css('display', 'none');
            $("#bank_3").css('display', 'none');
            $("#bank_4").css('display', 'none');
            $("#bank_5").css('display', 'none');
            $("#bank_6").css('display', 'none');
            $("#bank_7").css('display', 'none');
            $('#profile_pic').css('display', 'none');
            $('#references_tab').css('display', 'none');
        }
    }
    else {
        $("#for_other").css("display", "");
    }
    if (type == "tutor") {
        get_disable_user_data(types);
    }
    studio_dtl();


    $("input[name='CEPTSTU_DTL']").click(function () {
        var selectedValue = $("input[name='CEPTSTU_DTL']:checked").val();
        if (selectedValue == "Y") {
            $('.labelstudentid').css('display', '');
            $('.textstudentid').css('display', '');
        }
        else {
            $('.labelstudentid').css('display', 'none');
            $('.textstudentid').css('display', 'none');
            $('.textstudentid').val('');
        }
        //console.log("Selected value: " + selectedValue);
        
    });

    function getParameterByName(name) {
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
        return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    }

    if ($('#hdnusertype').val() == 'FA') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }

    if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC') {

        var str = "";

        if ($('#hdn_icode_ex').val() != "") {
            str = "<table style='width: 100%'><tr><td align='center' style='width: 40%;'> "
                + "<button id = 'btnsave' type = 'button' style='display:block; margin-right: -75%;' class='btn btn-primary'>"
                + "<i class='icon-save bigger-160' ></i> Save</button ></td > <td align='' style='width: 20%;'> <button id = 'btnapprove' type = 'button' style='display:block; float: center;' class='btn btn-primary'>"
                + "<i class='icon-save bigger-160'></i>Submit</button></td><td align='center' style='width: 40%;'><button id = 'btnnext_ext' type = 'button' style='margin-left:-136%;' class='btn btn-primary'>"
                + " Submit</button ></td ></tr ></table > ";

        }
        else {

            if (type == "") {
                str = "<table style='width: 100%'><tr><td align='center' style='width: 40%;'> "
                    + "<button id = 'btnsave' type = 'button' style='display:block; margin-right: -75%;' class='btn btn-primary'>"
                    + "<i class='icon-save bigger-160' ></i> Save</button ></td > <td align='' style='width: 20%;'> <button id = 'btnapprove' type = 'button' style='display:block; float: center;' class='btn btn-primary'>"
                    + "<i class='icon-save bigger-160'></i>Submit</button></td><td align='center' style='width: 40%;visibility: collapse;'><button id = 'btnnext' type = 'button' style='margin-left:-136%;' class='btn btn-primary'>"
                    + " Submit</button ></td ></tr ></table > ";
            }
            else {
                str = "<table style='width: 100%'><tr><td align='center' style='width: 40%;'> "
                    + "<button id = 'btnsave' type = 'button' style='display:block; margin-right: -75%;' class='btn btn-primary'>"
                    + "<i class='icon-save bigger-160' ></i> Save</button ></td > <td align='' style='width: 20%;'> <button id = 'btnapprove' type = 'button' style='display:block; float: center;' class='btn btn-primary'>"
                    + "Submit</button></td><td align='center' style='width: 40%;visibility: collapse;'><button id = 'btnnext' type = 'button' style='margin-left:-136%;' class='btn btn-primary'>"
                    + " Submit</button ></td ></tr ></table > ";
            }



        }

        $('#submitBtnDiv').html(str);
    }

    if ($('#hdnusertype').val() == 'HR' || $('#hdnusertype').val() == 'A') {
        if ($('#hdnusertype').val() == 'HR' && type == "tutor") {
            str = "<table style='width: 100%'><tr><td align='center' style='width: 40%;'> "
                + "<button id = 'btnsave' type = 'button' style='display:block; margin-right: -75%;' class='btn btn-primary'>"
                + "<i class='icon-save bigger-160' ></i> Save</button ></td > <td align='' style='width: 20%;'> <button id = 'btnapprove' type = 'button' style='display:block; float: center;' class='btn btn-primary'>"
                + "<i class='icon-save bigger-160'></i>Submit</button></td><td align='center' style='width: 40%;visibility: collapse;'><button id = 'btnnext' type = 'button' style='margin-left:-136%;' class='btn btn-primary'>"
                + " Submit</button ></td ></tr ></table > ";
            $('#submitBtnDiv').html(str);
        }
        else {
            var str = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                "<i class='icon-save bigger-160'></i>Save</button></td></tr></table>";
            $('#submitBtnDiv').html(str);
            $('#div_filter_criteria').css('display', 'block');
        }

    }

    var str_drp_associate_html = "<option value=''>-- Associated Since --</option>";
    var cur_date = new Date();
    for (i = cur_date.getFullYear(); i >= 1962; i--) {
        str_drp_associate_html = str_drp_associate_html + "<option value='" + i + "'>" + i + "</option>";
    }
    $('#txt_associated_with_cept_since').html(str_drp_associate_html);

    //$('#txt_dob').datepicker({ dateFormat: 'dd/mm/yy' });
    //$('#txt_date_of_issuance_certificate').datepicker({ dateFormat: 'dd/mm/yy' });
    //$('#txt_work_start_date').datepicker({ dateFormat: 'dd/mm/yy' });
    //$('#txt_work_end_date').datepicker({ dateFormat: 'dd/mm/yy' });
    //$('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });


    $('#txt_dob').datepicker({
        format: "dd/mm/yyyy",
        autoclose: true,
        endDate: new Date
    });
    $('#txt_date_of_issuance_certificate').datepicker({
        format: "dd/mm/yyyy",
        autoclose: true,
        endDate: new Date
    });
    $('#txt_work_start_date').datepicker({
        format: "dd/mm/yyyy",
        autoclose: true,
        endDate: new Date
    });
    $('#txt_work_end_date').datepicker({
        format: "dd/mm/yyyy",
        autoclose: true,
        endDate: new Date
    });

    $("#startDate_1").datepicker({
        format: "mm/yyyy",
        autoclose: true,
        startView: 2,
        minViewMode: 1,
        endDate: new Date(),
    }).on('changeDate', function (ev) {

        $("#endDate_1").datepicker('setStartDate', ev.date);
    });
    $("#endDate_1").datepicker({
        format: "mm/yyyy",
        autoclose: true,
        startView: 2,
        minViewMode: 1,
        //endDate: new Date //changes 02112022 by nitinbhai Remove year validation 
    }).on('changeDate', function (ev) {

        $("#startDate_1").datepicker('setEndDate', ev.date);
    });
    $("#start_0").datepicker({
        format: 'dd/mm/yyyy',
        autoclose: true,
        endDate: new Date(),
    }).on('changeDate', function (ev) {

        $("#end_0").datepicker('setStartDate', ev.date);
    });
    $("#end_0").datepicker({
        format: 'dd/mm/yyyy',
        autoclose: true,
        endDate: new Date()
    }).on('changeDate', function (ev) {

        $("#start_0").datepicker('setEndDate', ev.date);
    });
    $("#txt_contract_from_date").datepicker({
        format: 'mm/dd/yyyy',
        autoclose: true,
        endDate: new Date(),
    }).on('changeDate', function (ev) {

        $("#txt_contract_to_date").datepicker('setStartDate', ev.date);
    });
    $("#txt_contract_to_date").datepicker({
        format: 'mm/dd/yyyy',
        autoclose: true,
        endDate: new Date()
    }).on('changeDate', function (ev) {

        $("#txt_contract_from_date").datepicker('setEndDate', ev.date);
    });

    $('.date-picker, .cls_date, #txt_dob, #txt_date_of_issuance_certificate, #txt_work_start_date, #txt_work_end_date').on('focus', function () {
        $('.datepicker-switch').on('click', function () {
            if (this.parentElement.parentElement.parentElement.parentElement.className == "datepicker-days") {
                setTimeout(function () {
                    $('.datepicker-months')[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].click();
                }, 1);
            }
        });
    });

    $('.cls_date').on('change', function () {
        var clasname = $(this)[0].className;
        if (clasname.includes("start_date")) {
            if ($(this).parent().parent().find('.end_date').val() != "") {
                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                //var dt1 = new Date(match[3], match[2], match[1]);



                var dt1 = calculate_month(match);
                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                //var dt2 = new Date(match[3], match[2], match[1]);

                var dt2 = calculate_month(match);

                //var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                //var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));

                var cal_month = calculate_moth_year();
                const divid = parseFloat(cal_month) / parseFloat(12);
                var split_year = String(divid).split(".");
                //for (var i = 0; i < split_year.length; i++) {
                //    if (i == 0) {
                //        $('#txt_experiance_year').val(split_year[0]);
                //    }
                //    else {
                //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                //        $('#txt_experiance_month').val(remaning_month);
                //    }
                //}
            }
        }
        else if (clasname.includes("end_date")) {
            if ($(this).parent().parent().find('.start_date').val() != "") {
                // var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                // var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                //var dt1 = new Date(match[3], match[2], match[1]);


                var dt1 = calculate_month(match);

                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                //var dt2 = new Date(match[3], match[2], match[1]);

                var dt2 = calculate_month(match);


                $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
                var cal_month = calculate_moth_year();
                const divid = parseFloat(cal_month) / parseFloat(12);
                var split_year = String(divid).split(".");
                //for (var i = 0; i < split_year.length; i++) {
                //    if (i == 0) {
                //        $('#txt_experiance_year').val(split_year[0]);
                //    }
                //    else {
                //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                //        $('#txt_experiance_month').val(remaning_month);
                //    }
                //}
            }
        }
    });


    $('#drp_title').chosen();
    $('#txt_highest_qualification').chosen();
    $('#txt_blood_group').chosen();
    $('#txt_associated_with_cept_since').chosen();

    //$('#txt_country_dtl').chosen();

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

        if (!user_status) {
            if (type == 'tutor') {
                if (!$(".check_dept").is(':checked')) {
                    alert("Please Select Department");
                    return false;
                }
            }


            if (!is_data_found) {
                bootbox.alert('No Instructor to update');
                action = 'S';
                return false;
            }

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

            var selectedValue = $("input[name='CEPTSTU_DTL']:checked").val();
            if (selectedValue == 'Y') {
                if ($('.textstudentid').val() == '') {
                    bootbox.alert("Please Enter CEPT Student ID");
                    return false;
                }
            }

            if ($('#txt_highest_qualification').val() == '') {
                bootbox.alert('Please Enter Highest qualification');
                return false;
            }

            if ($('#txt_total_experiance').val() == '') {
                bootbox.alert('Please Enter Total Experiance');
                return false;
            }

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


            if ($("input[name='oci_card']:checked").val() == 'Y') {
                if (OCI_Card_FileName == '') {

                    bootbox.alert('Please Upload OCI Card');
                    return false;
                }

            }
            if ($('#txt_country_dtl').val() == '') {
                if (country_value == 'IN') {
                    $('#txt_country_dtl').val(country_value);
                }
                else {
                    if (country_value != '') {
                        $('#txt_country_dtl').val(country_value);
                    }
                    else {

                        bootbox.alert('Please Select - Nationality');
                        return false;
                    }
                }
            }

            if ($('#txt_country_dtl').val() != '' && $('#txt_country_dtl').val() != 'IN') {
                if ($("#oci_Y").is(':checked') == false && $("#oci_N").is(':checked') == false) {

                    bootbox.alert('Please Checked - Holder of OCI Card');
                    return false;
                }
            }

            if ($("#oci_Y").is(':checked') != false) {
                if ($('#lbl_ocicard_file_name').text() == '') {

                    bootbox.alert('Please Upload OCI Card');
                    return false;
                }
            }
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

            if ($("#txt_passport_no").val() != "") {
                if (Passport_FileName == '') {
                    bootbox.alert('Please Upload Passport');
                    return false;
                }
            }


            //changes 11012022
            if ($('#txt_country_dtl').val() != 'IN') {
                if ($('#txt_passport_no').val() == '') {
                    bootbox.alert('Please Enter Passport no');
                    return false;
                }

                if ($('#txt_passport_no').val() != '') {
                    if (Passport_FileName == '') {
                        bootbox.alert('Please Upload Passport');
                        return false;
                    }
                }
            }

            if ($('#txt_country_dtl').val() == 'IN') {
                if ($('#txt_aadhaar_no').val() == '' && $('#txt_passport_no').val() == '') {
                    bootbox.alert('Please Enter Passport no or Aadhaar no');
                    return false;

                }

                if ($('#txt_passport_no').val() == '') {
                    if ($('#txt_aadhaar_no').val() == '') {
                        bootbox.alert('Please Enter Aadhaar no');
                        return false;
                    }
                    if (Aadhaar_Card_FileName == '') {

                        bootbox.alert('Please Upload Aadhaar Card');
                        return false;
                    }
                }

                if ($('#txt_aadhaar_no').val() != '') {
                    if (Aadhaar_Card_FileName == '') {

                        bootbox.alert('Please Upload Aadhaar Card');
                        return false;
                    }
                }
                if ($('#txt_passport_no').val() != '') {
                    if (Passport_FileName == '') {
                        bootbox.alert('Please Upload Passport');
                        return false;
                    }
                }


                if ($('#txt_coa_reg_no').val() == '') {
                    //bootbox.alert('Please Enter Coa Registration Number');
                    //return false;

                }
                if (COA_Card_FileName == '') {
                    //bootbox.alert('Please Upload COA Card');
                    //return false;
                }

            }

            if ($('#txt_permanent_address').val() == '') {
                bootbox.alert('Please Enter Permanent Address');
                return false;
            }
            if ($('#txt_country_dtl').val() != 'IN') {
                if ($("#oci_Y").is(':checked') == true) {
                    if ($("#oci_country_Y").is(':checked') == false && $("#oci_country_N").is(':checked') == false) {
                        bootbox.alert('Please Checked - Social Security From Your Country ?');
                        return false;
                    }
                }
                if ($("#oci_country_Y").is(':checked') == true) {
                    if ($('#txt_ssn_no').val() == '') {
                        bootbox.alert('Please Enter Social Security Number');
                        return false;
                    }
                }
                if ($("#online_working_Y").is(':checked') == false && $("#online_working_N").is(':checked') == false) {

                    bootbox.alert('Please Checked - Agree to work completely online ?');
                    return false;
                }
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

                //if ($('#txt_pan_card_no').val() == '') {
                //    bootbox.alert('Please Enter PAN card no');
                //    return false;
                //}

                if (bank_dtl_status == true) {
                    //if ($('#txt_bank_account_no').val() == '')
                    //{
                    //    bootbox.alert('Please Enter Bank account no');
                    //    return false;
                    //}
                    //if ($('#txt_account_type').val() == '') {
                    //    bootbox.alert('Please Enter Account type');
                    //    return false;
                    //}
                    //
                    //if ($('#txt_name_of_the_bank').val() == '') {
                    //    bootbox.alert('Please Enter name of the Bank');
                    //    return false;
                    //}
                    //
                    //if ($('#txt_branch_name').val() == '') {
                    //    bootbox.alert('Please Enter Branch name');
                    //    return false;
                    //}
                    //
                    //if ($('#txt_ifsc_code').val() == '') {
                    //    bootbox.alert('Please Enter IFSC code');
                    //    return false;
                    //}
                    //else if ($('#txt_ifsc_code').val().length < 11) {
                    //    bootbox.alert('IFSC code must have 11 characters');
                    //    return false;
                    //}
                    //
                    //if ($('#txt_benificiary_name').val() == '') {
                    //    bootbox.alert('Please Enter Benificiary name');
                    //    return false;
                    //}
                    //
                    //if ($('#txt_benificiary_name').val() == '') {
                    //    bootbox.alert('Please Enter Benificiary name');
                    //    return false;
                    //}
                }

            }

            if ($('#hdnusertype').val() == 'I2') {
                if (FileName == '') {
                    bootbox.alert('Please Upload CV');
                    return false;
                }

                if (FileNameforPort == '') {
                    bootbox.alert('Please Upload Portfolio');
                    return false;
                }
            }

            if (type == 'tutor') {
                if ($("input[name='crdf_ques']:checked").val() == undefined) {
                    bootbox.alert('Please Fill Details For CRDF (CEPT Research and Development Foundation)');
                    return false;
                }
                if ($("input[name='crdf_ques']:checked").val() == 'Y') {
                    //txt_crdf_code
                    if ($('#txt_crdf_code').val() == '') {
                        bootbox.alert('Please Enter CRDF Code');
                        return false;
                    }
                    if ($('#drp_engagement_status').val() == '') {
                        bootbox.alert('Please Select Engagement Status');
                        return false;
                    }
                    if ($('#drp_nature_engagement_status').val() == '') {
                        bootbox.alert('Please Select Nature of Engagement');
                        return false;
                    }
                    //txt_contract_from_date
                    if ($('#txt_contract_from_date').val() == '') {
                        bootbox.alert('Please Enter Contract Period From Date');
                        return false;
                    }
                    if ($('#txt_contract_to_date').val() == '') {
                        bootbox.alert('Please Enter Contract Period To Date');
                        return false;
                    }
                    if ($('#drp_nature_engagement_status').val() == 'Part Time') {
                        if ($('#txt_eng_hourse').val() == '') {
                            bootbox.alert('Please Enter Engagement Hours per week as per contract');
                            return false;
                        }
                        if ($('#txt_center_name').val() == '') {
                            bootbox.alert('Please Enter Name of Centre');
                            return false;
                        }
                        if ($('#txt_reporting_to').val() == '') {
                            bootbox.alert('Please Enter Reporting to');
                            return false;
                        }
                    }
                }
                if ($("#q1").is(':checked')) {

                }
                else {
                    bootbox.alert('Please Checked UNDERTAKING ');
                    return false;
                }
                if ($("#q2").is(':checked')) {
                    // q2 = 'Y';
                }
                else {
                    bootbox.alert('Please Checked UNDERTAKING ');
                    return false;
                }
                if ($("#q7").is(':checked')) {
                    // q7 = 'Y';
                }
                else {
                    bootbox.alert('Please Checked UNDERTAKING ');
                    return false;
                }


                if ($('#txt_country_dtl').val() != '' && $('#txt_country_dtl').val() != 'IN') {
                    var value_oci_new = $("input[name='oci_card']:checked").val();
                    if (value_oci_new == 'N') {
                        if ($("#q4").is(':checked')) {

                        }
                        else { bootbox.alert('Please Checked UNDERTAKING '); return false; }

                        if ($("#q5").is(':checked')) {
                            //q5 = 'Y';
                        }
                        else { bootbox.alert('Please Checked UNDERTAKING '); return false; }
                    }

                }

                if ($("#oci_Y").is(':checked') == true) {
                    if ($("#q3").is(':checked')) {
                        //q3 = 'Y';
                    }
                    else { bootbox.alert('Please Checked UNDERTAKING '); return false; }
                }
                if ($("#crdf_Y").is(':checked') == true) {
                    if ($("#q6").is(':checked')) {
                        // q6 = 'Y';
                    }
                    else { bootbox.alert('Please Checked UNDERTAKING '); return false; }
                }

            }


            //28022022
            //var text_achievements_length = $('#txt_achievements').val().split(' ').length;
            //if (text_achievements_length <= '150') {
            //    bootbox.alert('Honors / Awards / Achievements Min Words Limit is 150 ');
            //    return false;
            //}
            //
            //var text_length = $('#txt_eduction_dtl').val().split(' ').length;
            //if (text_length <= '150') {
            //    bootbox.alert('Brief Description (Education & Work Profile) Min Words Limit is 150 ');
            //    return false;
            //}




            //nitinbhai 01032022
            //var check_reference_data_new = true;
            //var reference_dtl_new = [];
            //$('#tbl_reference tbody tr').each(function (i) {
            //    if (i > 0) {
            //
            //        var reference_row_new = { 'sr_no': '', 'name': '', 'mobile_no': '', 'email_id': '' };
            //
            //        reference_row_new.sr_no = i;
            //        reference_row_new.name = replace_special_char(this.children[0].children[0].value);
            //        reference_row_new.mobile_no = replace_special_char(this.children[1].children[0].value);
            //        reference_row_new.email_id = replace_special_char(this.children[2].children[0].value);
            //        if (reference_row_new.name == '') {
            //
            //            if ($('#hdnusertype').val() == 'I2') {
            //                bootbox.alert("Reference Details : Please Enter Name");
            //                check_reference_data_new = false;
            //                return false;
            //            }
            //        }
            //        if (reference_row_new.mobile_no == '') {
            //            if ($('#hdnusertype').val() == 'I2') {
            //                check_reference_data_new = false;
            //                bootbox.alert("Reference Details : Please Enter Mobile Number");
            //                return false;
            //            }
            //        }
            //        if (reference_row_new.email_id == '') {
            //            if ($('#hdnusertype').val() == 'I2') {
            //                check_reference_data_new = false;
            //                bootbox.alert("Reference Details : Please Enter Email Id Number");
            //                return false;
            //            }
            //        }
            //        if (reference_row_new.name != '' || reference_row_new.mobile_no != '' || reference_row_new.email_id != '') {
            //            check_reference_data = false;
            //            reference_dtl_new.push(reference_row_new);
            //        }
            //    }
            //});
            //
            //if (check_reference_data_new == false) {
            //    if (reference_dtl_new.length < 3 && $('#hdnusertype').val() == 'I2') {
            //        bootbox.alert('Please Enter Minimum 3 Reference Details');
            //        return false;
            //    }
            //}

            var education_dtl = [];
            var wrong_date_of_issuance_certificate = false;
            var check_academic_data = true;

            var Degree = false;
            var Specialization = false;
            var University = false;
            var StartDate = false;
            var EndDate = false;
            var EducationDateValid = false;
            var Percentage = false;
            var Mode = false;
            var PercentageCGPA = false;
            $('#tbl_academic_qualification tbody tr').each(function (i) {
                if (i > 0) {


                    var education_row = { 'sr_no': '', 'program_code': '', 'degree': '', 'specialization': '', 'university': '', 'edu_start_date': '', 'edu_end_date': '', 'edu_percentage': '', 'edu_mode': '', 'edu_type': '' };

                    education_row.sr_no = i;
                    education_row.program_code = replace_special_char(this.children[0].children[0].value);
                    education_row.degree = replace_special_char(this.children[1].children[0].value);
                    education_row.specialization = replace_special_char(this.children[2].children[0].value);
                    education_row.university = replace_special_char(this.children[3].children[0].value);
                    education_row.edu_percentage = replace_special_char(this.children[7].children[0].value);

                    if (replace_special_char(this.children[1].children[0].value) == "") {
                        Degree = true;
                        return false;
                    }
                    if (replace_special_char(this.children[2].children[0].value) == "") {
                        Specialization = true;
                        return false;
                    }
                    if (replace_special_char(this.children[3].children[0].value) == "") {
                        University = true;
                        return false;
                    }
                    if (this.children[6].children[0].value != undefined && this.children[6].children[0].value != "") {
                        education_row.edu_type = replace_special_char(this.children[6].children[0].value);
                    }
                    else {
                        PercentageCGPA = true;
                        return false;
                    }

                    if (replace_special_char(this.children[7].children[0].value) == "") {
                        Percentage = true;
                        return false;
                    }

                    if (this.children[8].children[0].value != undefined && this.children[8].children[0].value != "") {
                        education_row.edu_mode = replace_special_char(this.children[8].children[0].value);
                    }
                    else {
                        Mode = true;
                        return false;
                    }
                    var start_date_edu = this.children[4].children[0].value.trim();
                    var end_date_edu = this.children[5].children[0].value.trim();
                    var edu_start_date = this.children[4].children[0].value.split('/');
                    var edu_end_date = this.children[5].children[0].value.split('/');

                    if (start_date_edu != '' && start_date_edu != '/ undefined') {
                        education_row.edu_start_date = edu_start_date[0] + '/' + edu_start_date[1];
                    }
                    else {
                        StartDate = true;
                        return false;
                    }
                    if (end_date_edu != '' && end_date_edu != '/ undefined') {
                        education_row.edu_end_date = edu_end_date[0] + '/' + edu_end_date[1];
                    }
                    else {
                        EndDate = true;
                        return false;
                    }

                    var DateStartEducation = this.children[4].children[0].value.split('/')[1] + this.children[4].children[0].value.split('/')[0];
                    var DateEndEducation = this.children[5].children[0].value.split('/')[1] + this.children[5].children[0].value.split('/')[0];
                    if (parseInt(DateStartEducation) > parseInt(DateEndEducation)) {
                        EducationDateValid = true;
                    }
                    if (education_row.degree != '' || education_row.specialization != '' || education_row.university != '' || education_row.edu_percentage != '' || education_row.edu_mode != '') {
                        check_academic_data = false;
                        education_dtl.push(education_row);
                    }
                }
            });

            if (Degree) {
                bootbox.alert('Academic Qualification : Please Enter Degree');
                return false;
            }
            if (Specialization) {
                bootbox.alert('Academic Qualification : Please Enter Specialization/Field (if applicable)');
                return false;
            }
            if (University) {
                bootbox.alert('Academic Qualification : Please Enter University/Institute');
                return false;
            }

            if (StartDate) {
                bootbox.alert('Academic Qualification : Please Enter Start Date in MM/YYYY format');

                return false;
            }
            if (EndDate) {
                bootbox.alert('Academic Qualification : Please Enter End Date in MM/YYYY format');
                return false;
            }
            if (EducationDateValid) {
                bootbox.alert('Academic Qualification : Please Enter valid Academic dates start date should not be greater than end');
                return false;
            }

            if (PercentageCGPA) {
                bootbox.alert('Academic Qualification : Please Select Percentage/CGPA');
                return false;
            }
            if (Percentage) {
                bootbox.alert('Academic Qualification : Please Enter Percentage/ Division');
                return false;
            }

            if (Mode) {
                bootbox.alert('Academic Qualification : Please Select Mode');
                return false;
            }

            //if (check_academic_data && $('#hdnusertype').val() == 'I2')
            //{
            //    bootbox.alert('Please Enter Academic Qualification Details');

            //    return false;
            //}


            //if (wrong_date_of_issuance_certificate && $('#hdnusertype').val() == 'I2') {
            //    bootbox.alert('Please Enter Date of issuance certificate in DD/MM/YYYY format');
            //    return false;
            //}
            var work_dtl = [];
            var wrong_work_start_date = false;
            var wrong_work_end_date = false;
            var wrong_work_Date = false;
            var designation = false;
            var institute = false;
            var experience_type = false;
            var experience_mode = false;
            var experience_hourse = false;
            var check_work_exp_data = true;
            $('#tbl_work_experiance tbody tr').each(function (i) {
                if (i > 0) {

                    var work_row = { 'sr_no': '', 'work_designation': '', 'work_institute': '', 'work_experience_type': '', 'work_start_date': '', 'work_end_date': '', 'work_mode': '', 'work_week_per_hours': '', 'work_year_month': '', 'work_ex_cert': '' };

                    work_row.sr_no = i;
                    work_row.work_designation = replace_special_char(this.children[1].children[0].value);
                    work_row.work_institute = replace_special_char(this.children[0].children[0].value);
                    work_row.work_experience_type = replace_special_char(this.children[2].children[0].value);
                    work_row.work_experience_months = replace_special_char(this.children[5].children[0].value);

                    if (replace_special_char(this.children[0].children[0].value) == "") {
                        institute = true;
                        return false;
                    }

                    if (replace_special_char(this.children[1].children[0].value) == "") {
                        designation = true;
                        return false;
                    }

                    if (replace_special_char(this.children[2].children[0].value) == "") {
                        experience_type = true;
                        return false;
                    }

                    if (replace_special_char(this.children[6].children[0].value) == "") {
                        experience_mode = true;
                        return false;
                    }
                    if (replace_special_char(this.children[7].children[0].value) == "") {
                        experience_hourse = true;
                        return false;
                    }


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
                    else {
                        wrong_work_start_date = true;
                        return false;
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
                    else {
                        wrong_work_end_date = true;
                        return false;
                    }
                    var str_work_start_date = this.children[3].children[0].value.split('/');
                    var WorkStartDate = str_work_start_date[2] + str_work_start_date[1] + str_work_start_date[0];
                    var str_work_end_date = this.children[4].children[0].value.split('/');
                    var WorkEndDate = str_work_end_date[2] + str_work_end_date[1] + str_work_end_date[0];

                    if (parseInt(WorkStartDate) > parseInt(WorkEndDate)) {
                        wrong_work_Date = true;
                    }

                    var work_year_month = this.children[8].children[0].id;
                    if (work_year_month != undefined && work_year_month != '') {
                        work_row.work_year_month = $('#' + work_year_month).text();
                    }
                    else { work_row.work_year_month = ''; }
                    var file_name_class = this.children[9].children[1].className;
                    if (file_name_class != undefined) {
                        work_row.work_ex_cert = $('.' + file_name_class).text();
                    }
                    else { work_row.work_ex_cert = ''; }

                    if (work_row.work_designation != '' || work_row.work_institute != '' || work_row.work_experience_type != '' || work_row.work_start_date != '' || work_row.work_end_date != '') {
                        check_work_exp_data = false;
                        work_dtl.push(work_row);
                    }
                    else {
                        check_work_exp_data = true;;
                    }
                }
            });
            if (institute) {
                bootbox.alert('Work Experience : Please Enter Name of Institute / Organization Details');
                return false;
            }
            if (designation) {
                bootbox.alert('Work Experience : Please Enter Designation Details');

                return false;
            }
            if (experience_type) {
                bootbox.alert('Work Experience : Please Select Experience Type');
                return false;
            }
            if (wrong_work_start_date) {
                bootbox.alert('Work Experience : Please Enter Work Start Date in DD/MM/YYYY format');

                return false;
            }

            if (wrong_work_end_date) {
                bootbox.alert('Please Enter Work End Date in DD/MM/YYYY format');

                return false;
            }
            if (wrong_work_Date) {
                bootbox.alert('Please Enter valid Work dates, work start date should not be greater than work end date');

                return false;
            }

            if (check_work_exp_data) {
                bootbox.alert('Please Enter Work Experience Details');
                return false;
            }
            if (experience_mode) {
                bootbox.alert('Please Select Work Mode');
                return false;
            }
            if (experience_hourse) {
                bootbox.alert('Please Enter Total no of hours per week');
                return false;
            }
        }

        
        action = 'A';

        $('#btnsave').click();
        if ($('#hdnusertype').val() == 'HR' && type == "tutor") {
            bootbox.alert('Personal Details Submitted Successfully.');
            return false;
        }
        else if (type == "tutor") {
            if (!user_status) {
                alert('Personal Details Submitted Successfully.');
            }

            var url = "Temp_Dashboard.aspx";
            window.open(url, "_self");
        }

    });

    //$('.cls_date').on('change', function () {
    //    debugger;
    //    var clasname = $(this)[0].className;
    //    if (clasname.includes("start_date")) {
    //        if ($(this).parent().parent().find('.end_date').val() != "") {
    //            var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
    //            var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
    //            $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
    //        }
    //    } else if (clasname.includes("end_date")) {
    //        if ($(this).parent().parent().find('.start_date').val() != "") {
    //            var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
    //            var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
    //            $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
    //        }
    //    }
    //});

    $('#drp_instructor_code').on('change', function () {
        $('#drp_instructor_name').val('');
        $('#drp_instructor_name').trigger("liszt:updated");
    });

    $('#drp_instructor_name').on('change', function () {
        $('#drp_instructor_code').val('');
        $('#drp_instructor_code').trigger("liszt:updated");
    });

    $('#btnnext').on('click', function () {

        if ($("input[name='oci_card']:checked").val() == 'Y') {
            if (OCI_Card_FileName == '') {

                bootbox.alert('Please Upload OCI Card');
                return false;
            }

        }
        if ($('#txt_country_dtl').val() == '') {
            if (country_value == 'IN') {
                $('#txt_country_dtl').val(country_value);
            }
            else {
                if (country_value != '') {
                    $('#txt_country_dtl').val(country_value);
                }
                else {

                    bootbox.alert('Please Select - Nationality');
                    return false;
                }
            }
        }

        if ($('#txt_country_dtl').val() != '' && $('#txt_country_dtl').val() != 'IN') {
            if ($("#oci_Y").is(':checked') == false && $("#oci_N").is(':checked') == false) {
                bootbox.alert('Please Checked - Holder of OCI Card');
                return false;
            }

            if ($("#oci_Y").is(':checked') == true) {
                if ($("#oci_country_Y").is(':checked') == false && $("#oci_country_N").is(':checked') == false) {
                    bootbox.alert('Please Checked - Social Security From Your Country ?');
                    return false;
                }



            }

        }

        if ($("#oci_Y").is(':checked') != false) {
            if ($('#lbl_ocicard_file_name').text() == '') {

                bootbox.alert('Please Upload OCI Card');
                return false;
            }
        }


        if ($("#txt_passport_no").val() != "") {
            if (Passport_FileName == '') {
                bootbox.alert('Please Upload Passport');
                return false;
            }
        }

        if ($('#txt_country_dtl').val() != 'IN') {
            if ($("#txt_passport_no").val() == "") {
                alert("Please Enter Passport No.");
                return false;
            }
            if (Passport_FileName == '') {
                bootbox.alert('Please Upload Passport');
                return false;
            }

        }

        $('#btnapprove').click();
        //var url = "Interested_Program.aspx";
        //window.open(url, "_self");


    });
    $('#btnnext_ext').on('click', function () {
        $('#btnapprove').click();
        //var url = "Existing_Interested_Program.aspx";
        //window.open(url, "_self");
    });

    $('#btnsave').on('click', function () {

        //if ($("input[name='indian_citizen']:checked").val() == undefined) {
        //    bootbox.alert('Please Select - Are you a Citizen of India?');
        //    action = 'S';
        //    return false;
        //}
        if (!user_status) {
            if (type == 'tutor') {
                if (!$(".check_dept").is(':checked')) {
                    alert("Please Select Department");
                    return false;
                }
            }


            if ($('#txt_country_dtl').val() == '') {
                if (country_value == 'IN') {
                    $('#txt_country_dtl').val(country_value);
                }
                else {
                    if (country_value != '') {
                        $('#txt_country_dtl').val(country_value);
                    }
                    else {
                        bootbox.alert('Please Select - Nationality');
                        action = 'S';
                        return false;
                    }
                }
            }
            if ($('#txt_country_dtl').val() != '' && $('#txt_country_dtl').val() != 'IN') {
                if ($("#oci_Y").is(':checked') == false && $("#oci_N").is(':checked') == false) {
                    bootbox.alert('Please Checked - Holder of OCI Card');
                    return false;
                }
            }

            var selectedValue = $("input[name='CEPTSTU_DTL']:checked").val();
            if (selectedValue == 'Y') {
                if ($('.textstudentid').val() == '') {
                    bootbox.alert("Please Enter CEPT Student ID");
                    return false;
                }
            }

            if ($("#oci_Y").is(':checked') != false) {
                if ($('#lbl_ocicard_file_name').text() == '') {
                    bootbox.alert('Please Upload OCI Card');
                    return false;
                }
            }

            if ($("input[name='ind_bank_account']:checked").val() == undefined) {
                bootbox.alert('Please Select - Do you have a Bank Account as an Indian Citizen (Not as NRI or OIC)');
                action = 'S';
                return false;
            }

        }



        var instructor_data = {
            'instructor_code': '', 'VF_code': '', 'first_name': '', 'last_name': '', 'title': '', 'mail': '', 'mobile_no': '', 'phone_no': '', 'blood_group': '', 'pan_card_no': '', 'bank_account_number': '', 'account_type': '',
            'name_of_Bank': '', 'branch_name': '', 'ifsc_code': '', 'benificiary_name': '', 'dob': '', 'highest_qualification': '', 'total_experiance': '', 'total_experiance_months': '', 'associated_with_cept_since': '', 'address': '', 'emergency_contact_name': '',
            'emergency_contact_number': '', 'degree': '', 'specialization': '', 'university': '', 'date_of_issuance_certificate': '', 'work_designation': '', 'work_institute': '', 'work_start_date': '', 'work_end_date': '', 'achievements': '',
            'area_of_interest': '', 'cv_file_name': '', 'image_path': '', 'gst_number': '', 'coa_registration_no': '', 'gender': '', 'edu_work_description': '', 'city': '', 'state': '', 'country': '', 'passport_doc': '', 'oci_card_status': '', 'oci_card_doc': '',
            'permanent_address': '', 'aadhaar_doc': '', 'coa_doc': '',
            'crdf_status': '', 'crdf_code': '', 'crdf_engagment_status': '', 'crdf_nature_engagment': '', 'crdf_from_date': '', 'crdf_to_date': '', 'crdf_hours': '', 'crdf_name_of_center': '', 'crdf_reporting_to': '', 'question_status': '', 'oci_country_status': '',
            'total_work_experience_year': '', 'total_work_experience_month': '', 'social_security_no': '', 'online_working_status': '', 'cept_student_id': ''
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
        if ($('#txt_benificiary_name').val() == undefined) {
            instructor_data.benificiary_name = "";
        }
        else { instructor_data.benificiary_name = $('#txt_benificiary_name').val(); }

        //kapil08062020
        instructor_data.cept_student_id = $('.textstudentid').val();
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
        //change 13092021

        instructor_data.indian_citizen = $('#txt_country_dtl').val();
        country_value = '';
        //$("input[name='indian_citizen']:checked").val();
        instructor_data.ind_bank_account = $("input[name='ind_bank_account']:checked").val();

        var per_add = '';
        if ($("#txt_address").val() != '') {
            per_add = $("#txt_address").val();
            instructor_data.address = per_add;
        }
        if ($("#txt_address_1").val() != '') {
            per_add += '@#' + $("#txt_address_1").val();
            instructor_data.address = per_add;
        }

        if ($("#txt_country_res").val() != '') {
            per_add += '@#' + $("#txt_country_res").val() + '@c#';
            instructor_data.address = per_add;
        }
        if ($("#txt_state_res").val() != '') {
            per_add += '@#' + $("#txt_state_res").val() + '@s#';
            instructor_data.address = per_add;

        }
        if ($("#txt_city_res").val() != '') {
            per_add += '@#' + $("#txt_city_res").val() + '@ci#';
            instructor_data.address = per_add;
        }

        //instructor_data.address = replace_special_char($('#txt_address').val());
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

        //new 13092021
        instructor_data.passport_doc = Passport_FileName;
        if ($("#oci_Y").is(':checked') == false && $("#oci_N").is(':checked') == false) {
            instructor_data.oci_card_doc = '';
            instructor_data.oci_card_status = '';
        }
        else if ($("input[name='oci_card']:checked").val() == "N") {
            instructor_data.oci_card_doc = '';
            instructor_data.oci_card_status = $("input[name='oci_card']:checked").val();
        }
        else {
            instructor_data.oci_card_doc = OCI_Card_FileName;
            instructor_data.oci_card_status = $("input[name='oci_card']:checked").val();
        }


        if ($("#oci_country_Y").is(':checked') == false && $("#oci_country_N").is(':checked') == false) {
            instructor_data.oci_country_status = '';

        }
        else if ($("input[name='oci_country_card']:checked").val() == "N") {

            instructor_data.oci_country_status = $("input[name='oci_country_card']:checked").val();
        }
        else {

            instructor_data.oci_country_status = $("input[name='oci_country_card']:checked").val();
        }
        var per_add_res = '';
        if ($("#txt_permanent_address").val() != '') {
            per_add_res = $("#txt_permanent_address").val();
            instructor_data.permanent_address = per_add_res;
        }
        if ($("#txt_permanent_address_1").val() != '') {
            per_add_res += '@#' + $("#txt_permanent_address_1").val();
            instructor_data.permanent_address = per_add_res;
        }

        //if ($("#txt_permanent_address_2").val() != '') {
        //    per_add += '@#' + $("#txt_permanent_address_2").val();
        //    instructor_data.permanent_address = per_add;
        //}
        //else { instructor_data.permanent_address = $("#txt_permanent_address").val();}


        if ($('#txt_country_dtl').val() == 'IN') {
            if (Aadhaar_Card_FileName == undefined) {
                instructor_data.aadhaar_doc = '';
            }
            else { instructor_data.aadhaar_doc = Aadhaar_Card_FileName; }

            if (COA_Card_FileName == undefined) {
                instructor_data.coa_doc = '';
            }
            else { instructor_data.coa_doc = COA_Card_FileName; }

        }
        else {
            instructor_data.aadhaar_doc = '';
            instructor_data.coa_doc = '';
        }
        //changes 24092021
        if ($("#oci_country_Y").is(':checked') == true) {
            instructor_data.social_security_no = $('#txt_ssn_no').val();

        }
        else {
            instructor_data.social_security_no = '';
        }

        if ($("#online_working_Y").is(':checked') == false && $("#online_working_N").is(':checked') == false) {
            instructor_data.online_working_status = '';

        }

        else if ($("input[name='online_working']:checked").val() == "N") {

            instructor_data.online_working_status = $("input[name='online_working']:checked").val();
        }
        else {

            instructor_data.online_working_status = $("input[name='online_working']:checked").val();
        }


        if ($("input[name='crdf_ques']:checked").val() != undefined) {
            if ($("#crdf_Y").is(':checked') == true) {
                instructor_data.crdf_status = $("input[name='crdf_ques']:checked").val();
                instructor_data.crdf_code = $('#txt_crdf_code').val();
                instructor_data.crdf_engagment_status = $('#drp_engagement_status').val();
                instructor_data.crdf_nature_engagment = $('#drp_nature_engagement_status').val();
                instructor_data.crdf_from_date = $('#txt_contract_from_date').val();
                instructor_data.crdf_to_date = $('#txt_contract_to_date').val();
                instructor_data.crdf_hours = $('#txt_eng_hourse').val();
                instructor_data.crdf_name_of_center = $('#txt_center_name').val();
                instructor_data.crdf_reporting_to = $('#txt_reporting_to').val();
            }
            else {
                instructor_data.crdf_status = $("input[name='crdf_ques']:checked").val();
            }
        }
        var q1 = 'N';
        var q2 = 'N';
        var q3 = 'N';
        var q4 = 'N';
        var q5 = 'N';
        var q6 = 'N';
        var q7 = 'N';

        // if ($('#txt_country_dtl').val() == 'IN') {
        if ($("#q1").is(':checked')) {
            q1 = 'Y';
        }
        else {
            q1 = 'N';
        }
        if ($("#q2").is(':checked')) {
            q2 = 'Y';
        }
        else {
            q2 = 'N';
        }
        if ($("#q7").is(':checked')) {
            q7 = 'Y';
        }
        else { q7 = 'N'; }
        //   }

        if ($('#txt_country_dtl').val() != '' && $('#txt_country_dtl').val() != 'IN') {
            if ($("#q4").is(':checked')) {
                q4 = 'Y';
            }
            else { q4 = 'N'; }

            if ($("#q5").is(':checked')) {
                q5 = 'Y';
            }
            else { q5 = 'N'; }
        }

        if ($("#oci_Y").is(':checked') == true) {
            if ($("#q3").is(':checked')) {
                q3 = 'Y';
            }
            else { q3 = 'N'; }
        }
        if ($("#crdf_Y").is(':checked') == true) {
            if ($("#q6").is(':checked')) {
                q6 = 'Y';
            }
            else { q6 = 'N'; }
        }
        var obj_question = { 'q1': q1, 'q2': q2, 'q3': q3, 'q4': q4, 'q5': q5, 'q6': q6, 'q7': q7 };


        if (obj_question.q1.search(/\\/) != -1) { obj_question.q1 = obj_question.q1.replace(/\\/g, '\\\\'); }
        if (obj_question.q1.search("\"") != -1) { obj_question.q1 = obj_question.q1.replace(/"/g, '\\\"'); }

        if (obj_question.q2.search(/\\/) != -1) {
            obj_question.q2 = obj_question.q2.replace(/\\/g, '\\\\');
        }
        if (obj_question.q2.search("\"") != -1) {
            obj_question.q2 = obj_question.q2.replace(/"/g, '\\\"');
        }

        if (obj_question.q3.search(/\\/) != -1) { obj_question.q3 = obj_question.q3.replace(/\\/g, '\\\\'); }
        if (obj_question.q3.search("\"") != -1) { obj_question.q3 = obj_question.q3.replace(/"/g, '\\\"'); }

        if (obj_question.q4.search(/\\/) != -1) { obj_question.q4 = obj_question.q4.replace(/\\/g, '\\\\'); }
        if (obj_question.q4.search("\"") != -1) { obj_question.q4 = obj_question.q4.replace(/"/g, '\\\"'); }

        if (obj_question.q5.search(/\\/) != -1) { obj_question.q5 = obj_question.q5.replace(/\\/g, '\\\\'); }
        if (obj_question.q5.search("\"") != -1) { obj_question.q5 = obj_question.q5.replace(/"/g, '\\\"'); }

        if (obj_question.q6.search(/\\/) != -1) { obj_question.q6 = obj_question.q6.replace(/\\/g, '\\\\'); }
        if (obj_question.q6.search("\"") != -1) { obj_question.q6 = obj_question.q6.replace(/"/g, '\\\"'); }

        if (obj_question.q7.search(/\\/) != -1) { obj_question.q7 = obj_question.q7.replace(/\\/g, '\\\\'); }
        if (obj_question.q7.search("\"") != -1) { obj_question.q7 = obj_question.q7.replace(/"/g, '\\\"'); }

        instructor_data.question_status = JSON.stringify(obj_question);

        if (instructor_data.question_status.search(/\\/) != -1) { instructor_data.question_status = instructor_data.question_status.replace(/\\/g, '\\\\'); }
        if (instructor_data.question_status.search("\"") != -1) { instructor_data.question_status = instructor_data.question_status.replace(/"/g, '\\\"'); }
        else {
            instructor_data.question_status = "";
        }

        instructor_data.total_work_experience_year = $('#txt_experiance_year').val();
        instructor_data.total_work_experience_month = $('#txt_experiance_month').val();

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

        if (!user_status) {
            //01032022
            //if (check_reference_data && action == "A" && $('#hdnusertype').val() == 'I2')
            //{
            //    alert('Please Enter Reference Details');
            //    action = 'S';
            //    return false;
            //}
            //
            //if (reference_dtl.length < 3 && action == "A" && $('#hdnusertype').val() == 'I2') {
            //    alert('Please Enter Minimum 3 Reference Details');
            //    action = 'S';
            //    return false;
            //}
        }


        var education_dtl = [];
        var wrong_date_of_issuance_certificate = false;
        var check_academic_data = true;
        //kapil 09092021 changes 
        $('#tbl_academic_qualification tbody tr').each(function (i) {
            if (i > 0) {

                //var education_row = { 'sr_no': '', 'degree': '', 'specialization': '', 'university': '', 'date_of_issuance_certificate': '', 'edu_start_date': '', 'edu_end_date' :'', 'edu_percentage' :'', 'edu_mode' :'' };
                var education_row = { 'sr_no': '', 'program_code': '', 'degree': '', 'specialization': '', 'university': '', 'edu_start_date': '', 'edu_end_date': '', 'edu_percentage': '', 'edu_mode': '', 'edu_type': '' };

                education_row.sr_no = i;
                education_row.program_code = replace_special_char(this.children[0].children[0].value);
                education_row.degree = replace_special_char(this.children[1].children[0].value);
                education_row.specialization = replace_special_char(this.children[2].children[0].value);
                education_row.university = replace_special_char(this.children[3].children[0].value);
                //kapil 09092021

                education_row.edu_percentage = replace_special_char(this.children[7].children[0].value);
                if (this.children[8].children[0].value != undefined) {
                    education_row.edu_mode = replace_special_char(this.children[8].children[0].value);
                }
                //28022022
                if (this.children[6].children[0].value != undefined) {
                    education_row.edu_type = replace_special_char(this.children[6].children[0].value);
                }
                //end
                //education_row.edu_mode = replace_special_char(this.children[7].children[0].value);
                var start_date_edu = this.children[4].children[0].value.trim();
                var end_date_edu = this.children[5].children[0].value.trim();
                var edu_start_date = this.children[4].children[0].value.split('/');
                var edu_end_date = this.children[5].children[0].value.split('/');
                if (start_date_edu != '' && start_date_edu != '/ undefined') {
                    education_row.edu_start_date = edu_start_date[0] + '/' + edu_start_date[1];
                }
                if (end_date_edu != '' && end_date_edu != '/ undefined') {
                    education_row.edu_end_date = edu_end_date[0] + '/' + edu_end_date[1];
                }



                //education_row.edu_start_date = replace_special_char(this.children[4].children[0].value);
                //education_row.edu_end_date = replace_special_char(this.children[5].children[0].value);

                //if (this.children[3].children[0].value != '') {
                //
                //    if (!pattern.test(this.children[3].children[0].value)) {
                //        wrong_date_of_issuance_certificate = true;
                //    }
                //    if (this.children[3].children[0].value.split('/')[1] > 12) {
                //        wrong_date_of_issuance_certificate = true;
                //    }
                //
                //    var str_date_of_issuance_certificate = this.children[3].children[0].value.split('/');
                //    education_row.date_of_issuance_certificate = str_date_of_issuance_certificate[1] + '/' + str_date_of_issuance_certificate[0] + '/' + str_date_of_issuance_certificate[2];
                //}

                //if (education_row.degree != '' || education_row.specialization != '' || education_row.university != '' || education_row.date_of_issuance_certificate != '' || education_row.edu_percentage != '' || education_row.edu_mode != '')
                if (education_row.degree != '' || education_row.specialization != '' || education_row.university != '' || education_row.edu_percentage != '' || education_row.edu_mode != '') {
                    check_academic_data = false;
                    education_dtl.push(education_row);
                }
            }
        });
        if (!user_status) {
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

                var work_row = { 'sr_no': '', 'work_designation': '', 'work_institute': '', 'work_experience_type': '', 'work_start_date': '', 'work_end_date': '', 'work_mode': '', 'work_week_per_hours': '', 'work_year_month': '', 'work_ex_cert': '' };

                work_row.sr_no = i;
                work_row.work_designation = replace_special_char(this.children[1].children[0].value);
                work_row.work_institute = replace_special_char(this.children[0].children[0].value);
                work_row.work_experience_type = replace_special_char(this.children[2].children[0].value);
                work_row.work_experience_months = replace_special_char(this.children[5].children[0].value);
                //28022022

                if (this.children[6].children[0].value != undefined) {
                    work_row.work_mode = this.children[6].children[0].value;
                }

                work_row.work_week_per_hours = this.children[7].children[0].value;
                //end
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

                //work_row.work_experience_year = replace_special_char(this.children[6].children[0].value);
                //work_row.work_expe_total_month = replace_special_char(this.children[7].children[0].value);

                var file_name_class = this.children[9].children[1].className;
                if (file_name_class != undefined) {
                    work_row.work_ex_cert = $('.' + file_name_class).text();
                }
                else { work_row.work_ex_cert = ''; }

                var work_year_month = this.children[8].children[0].id;
                if (work_year_month != undefined && work_year_month != '') {
                    work_row.work_year_month = $('#' + work_year_month).text();
                }
                else { work_row.work_year_month = ''; }

                if (work_row.work_designation != '' || work_row.work_institute != '' || work_row.work_experience_type != '' || work_row.work_start_date != '' || work_row.work_end_date != '') {
                    check_work_exp_data = false;
                    work_dtl.push(work_row);
                }
            }
        });

        if (!user_status) {
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

        var ta_apply_dtl = [];

        for (var ta = 1; ta <= 7; ta++) {
            var ta_apply_dtl_data = { 'dept_code': '', 'prev_text': '', 'refrence_path': '', 'action': '', 'total_experiance_months': '', 'apply_type': '' };
            if (ta == 6) {
                ta = 10;
            }
            if (ta == 7) {
                ta = 9;
            }
            if ($("#dept_" + ta).is(':checked')) {
                ta_apply_dtl_data.dept_code = ta;
                ta_apply_dtl_data.apply_type = '23';
                if ($('#txt_prev_ta_dtl').val() != '') {
                    ta_apply_dtl_data.prev_text = $('#txt_prev_ta_dtl').val();
                }
                else {
                    ta_apply_dtl_data.prev_text = '';
                }
                if ($('#lbl_reference_letter_name').text() != '') {
                    ta_apply_dtl_data.refrence_path = $('#lbl_reference_letter_name').text();
                }
                else {
                    ta_apply_dtl_data.refrence_path = '';
                }

                if (action == 'A') {
                    ta_apply_dtl_data.action = 'Y';
                }
                else { ta_apply_dtl_data.action = 'N'; }
                var total_month = '';
                if ($('#txt_total_experiance').val() != '') {
                    total_month = parseInt(parseInt($('#txt_total_experiance').val()) * 12);
                }
                if ($('#txt_total_experiance_months').val() != '') {
                    total_month = parseInt(parseInt(total_month) + parseInt($('#txt_total_experiance_months').val()));
                }

                ta_apply_dtl_data.total_experiance_months = total_month;



                ta_apply_dtl.push(ta_apply_dtl_data);

            }

            if ($("#course_" + ta).is(':checked')) {
                ta_apply_dtl_data = { 'dept_code': '', 'prev_text': '', 'refrence_path': '', 'action': '', 'total_experiance_months': '', 'apply_type': '' };
                ta_apply_dtl_data.dept_code = ta;
                ta_apply_dtl_data.apply_type = '24';
                if ($('#txt_prev_ta_dtl').val() != '') {
                    ta_apply_dtl_data.prev_text = $('#txt_prev_ta_dtl').val();
                }
                else {
                    ta_apply_dtl_data.prev_text = '';
                }
                if ($('#lbl_reference_letter_name').text() != '') {
                    ta_apply_dtl_data.refrence_path = $('#lbl_reference_letter_name').text();
                }
                else {
                    ta_apply_dtl_data.refrence_path = '';
                }

                if (action == 'A') {
                    ta_apply_dtl_data.action = 'Y';
                }
                else { ta_apply_dtl_data.action = 'N'; }
                var total_month = '';
                if ($('#txt_total_experiance').val() != '') {
                    total_month = parseInt(parseInt($('#txt_total_experiance').val()) * 12);
                }
                if ($('#txt_total_experiance_months').val() != '') {
                    total_month = parseInt(parseInt(total_month) + parseInt($('#txt_total_experiance_months').val()));
                }

                ta_apply_dtl_data.total_experiance_months = total_month;



                ta_apply_dtl.push(ta_apply_dtl_data);

            }

            if (ta == 10) {
                ta = 6;
            }
            else if (ta == 9) {
                ta = 7;
            }

            //else {
            //    ta_apply_dtl_data.dept_code = '';
            //}



        }

        var All_instructor_data = [instructor_data, reference_dtl, education_dtl, work_dtl, action, ta_apply_dtl];
        var json_All_instructor_data = JSON.stringify(All_instructor_data);

        if (json_All_instructor_data.search("'") != -1) {
            json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
        }
        //json_All_instructor_data = JSON.stringify(json_All_instructor_data);
        //json_All_instructor_data = '[{"instructor_code":"151","VF_code":"","first_name":"Sandip","last_name":"Patil","title":"Mr.","mail":"sandip.patil@cept.ac.in","mobile_no":"9537938015","phone_no":"9099041404","blood_group":"A + ","pan_card_no":"ALLPP1449A","bank_account_number":"203810110002781","account_type":"Saving","name_of_Bank":"Bank of India","branch_name":"Vastrapur","ifsc_code":"BKID0002038","benificiary_name":"Sandip Patil","dob":"03 / 5 / 1983","highest_qualification":"PG","total_experiance":"14","associated_with_cept_since":"2009","address":"83, Chanakya Tower, Nr Sandesh Press, Vastrapur, Ahmedabad 380054","emergency_contact_name":"Shilpa Gavane","emergency_contact_number":"9099041404","degree":"","specialization":"","university":"","date_of_issuance_certificate":"","work_designation":"","work_institute":"","work_start_date":"","work_end_date":"","achievements":"","area_of_interest":"landscape architecture, landscape planning, water management","cv_file_name":"151_Sandip CV 2020.pdf","image_path":"profile_151.jpg","gst_number":"","coa_registration_no":"","gender":"M","edu_work_description":"","city":"Ahmedabad","state":"Gujarat","country":"india","passport_doc":"151_Sandip_Patil_Passport.pdf","oci_card_status":"","oci_card_doc":"","passport_no":"J0711911","aadhaar_no":"","is_submit":"N","total_teaching_experiance":"","total_research_experiance":"","total_industry_experiance":"","indian_citizen":"IN","ind_bank_account":"Y","portfolio_file_name":"151_Sandip_Patil_Portfolio.pdf"},[{"sr_no":1,"name":"Deepa Maheshwari","mobile_no":"0","email_id":"deepa.maheshwari@cept.ac.in"},{"sr_no":2,"name":"Alka Yagnik","mobile_no":"0","email_id":"alka.yagnik@cept.ac.in"},{"sr_no":3,"name":"Divya Shah","mobile_no":"0","email_id":"divya.shah@cept.ac.in"}],[{"sr_no":1,"degree":"Master of Landscape Architecture","specialization":"","university":"CEPT University","edu_start_date":" / undefined","edu_end_date":" / undefined","edu_percentage":"","edu_mode":""},{"sr_no":2,"degree":"Bachelor of Architecture","specialization":"","university":"The MS University of Baroda","edu_start_date":" / undefined","edu_end_date":" / undefined","edu_percentage":"","edu_mode":""}],[{"sr_no":1,"work_designation":"Director","work_institute":"Earthscapes Consultancy Pvt Ltd","work_experience_type":"Industry","work_start_date":"01 / 01 / 2020","work_end_date":"09 / 06 / 2021","work_experience_months":"22"},{"sr_no":2,"work_designation":"Assistant Professor","work_institute":"CEPT University","work_experience_type":"Teaching","work_start_date":"12 / 1 / 2009","work_end_date":"12 / 1 / 2015","work_experience_months":"78"}],"S"]'
        // json_All_instructor_data = '[{"instructor_code":"I201","VF_code":"I201","first_name":"Devna","last_name":"Vyas","title":"Ms.","mail":"devna.vyas@gmail.com","mobile_no":"9879172613","phone_no":"","blood_group":"","pan_card_no":"","bank_account_number":"","account_type":"","name_of_Bank":"","branch_name":"","ifsc_code":"","benificiary_name":"","dob":"","highest_qualification":"PG","total_experiance":"5","associated_with_cept_since":"","address":"","emergency_contact_name":"","emergency_contact_number":"","degree":"","specialization":"","university":"","date_of_issuance_certificate":"","work_designation":"","work_institute":"","work_start_date":"","work_end_date":"","achievements":"","area_of_interest":"","cv_file_name":"","image_path":"","gst_number":"","coa_registration_no":"","gender":"F","edu_work_description":"","city":"","state":"","country":"","passport_doc":"","oci_card_status":"","oci_card_doc":"","passport_no":"123456","aadhaar_no":"","is_submit":"N","total_teaching_experiance":"","total_research_experiance":"","total_industry_experiance":"","indian_citizen":"IN","ind_bank_account":"Y","portfolio_file_name":""},[],[],[],"S"]';
        // json_All_instructor_data = '[{"instructor_code":"I1617000467","VF_code":"AA18062","first_name":"Priyanka","last_name":"Kanhare","title":"Ms.","mail":"priyanka.kanhare@cept.ac.in","mobile_no":"7202072222","phone_no":"9825071314","blood_group":"B+","pan_card_no":"CFQPK5481L","bank_account_number":"20078341191","account_type":"Saving","name_of_Bank":"State Bank of India","branch_name":"ST. Xavier’s High School Road","ifsc_code":"SBIN0003092","benificiary_name":"Priyanka Kanhare","dob":"12/11/1988","highest_qualification":"PG","total_experiance":"8","associated_with_cept_since":"2007","address":"1/A, Paliadnagar society, near Devkinandan Jain Derasar, Naranpura, Ahmedabad- 380013","emergency_contact_name":"","emergency_contact_number":"","degree":"","specialization":"","university":"","date_of_issuance_certificate":"","work_designation":"","work_institute":"","work_start_date":"","work_end_date":"","achievements":"• Presented and gave a talk at Rotary Club Bird watchers group, Jamshedpur on the topic: The Green\nMosaic, Enhancing Urban Biodiversity, August, 2021\n• Presented and gave a talk at Rotary club Youth wing (RYLA, 2021), Jamshedpur on the topic:\nDocumenting and Representing Urban Biodiversity, June, 2021\n• Presented and gave a talk at TATA Steel, Jamshedpur on the topic: Importance of Green Mosaic in\nSafeguarding Urban Biodiversity, case of Ahmedabad, June, 2021\n• Presented and gave a talk at Indian Green Building Council (IGBC, Ahmedabad) on the topic:\nBiodiversity In Cities, case of Ahmedabad, July 2018\n(link to video: https://www.youtube.com/watch?V=lhihkphwwly)\n• Conducted workshop with FABLAB, CEPT University, (Making prototype fro large scale installation as\nfauna habitat in Parks of Ahmedabad, 29th September, 2017) (in collaboration with Ahmedabad\nMunicipal Corporation, Ahmedabad)\n• Worked as a part of core team for Jury and Exhibition for Archiprix Workshop, 2017\n• Presented in the 4D RF session, FA, CEPT University\n• Paintings selected as Exhibit Entry for Gujarat Lalit Kala Academy State Art Exhibition, Ahmedabad in\n2016, 2017, 2018\n• Presented my Thesis research - design work at 10th AGM of ISOLA, at CEPT University, Ahmedabad on\n22/08/2015 (Topic: Landscape Exploration in the Public Realm)\n• Redesigned (conceptual design) for existing Sayaji zoo, at Vadodara (proposal for redesigning zoo)\n• Designed Flower arrangement- layout for Annual Flower Show, 2015 for Ahmedabad Municipal\nCorporation (got compliment and appreciation from Hon. Chief Minister of Gujarat, Mayor and\nMunicipal Commissioner of Ahmedabad)\n• One of my paintings got selected as Exhibit Entry from West zone for All India Camel Art Foundation\nNational Exhibition at Mumbai in 2015\n• Documented Biodiversity of Birds in city of Ahmedabad. Part of this work got published in Times of\nIndia, Sunday edition (main paper), 2014\n• Received Travel grant Award for highest marks in Drawing and Painting in First Year in CEPT\nUniversity.","area_of_interest":"In my teaching and practice, I emphasise more on developing environments, which are specific to place and\ntime. I try seeing it through the lens of people, who inhabit these varied geographies. Each city or geographic\nlocation has its own unique environmental setting/context and history. Historic urban landscapes are a result\nof dynamic interrelationship between physical, ecological and cultural factors. Through the exercises that I\nframe for my studio programs, I try to make myself and students imagine, look, preserve, renew and\nreconsider how these landscapes are part of our present and can continue to become part of the future. As I am qualified as Landscape Architect, over past 6 years I have been exploring various methods of documenting and recording Urban biodiversity. Recently I have started working with younger school students and college across India, on making them aware about their surrounding nature and guide them in mapping the biodiversity around their institutional campuses. ","cv_file_name":"I1617000467_Priyanka_Kanhare_CV.pdf","image_path":"profile_I1617000467.jpg","gst_number":"","coa_registration_no":"CA/2014/62928","gender":"F","edu_work_description":"I am an Academician and a practicing Architect and Landscape Architect. Currently I am working as Visiting Faculty at CEPT University, Faculty of Architecture Program (Master in Architecture History and Theory), Ahmedabad and Navrachana University (School of Environment, Design And Architecture), Vadodara. Beside this, I also conduct workshops informing ways to Represent and Document Intangible Cultural Heritage of People and Places. I completed my Bachelor in Architecture in 2013, followed by Masters in Landscape Architecture in 2015 from CEPT University, Ahmedabad. Currently I am pursuing PhD in Landscape Architecture at School of Planning and Architecture (SPA), New Delhi. My research interest lies in reading and documenting ecological and cultural manifestations along natural systems (rivers). I have worked on various academic and professional projects dealing with mapping and understanding the associations between Biodiversity and Urban Spaces. Some of these works include: developing prototype for large scale installation as fauna habitat in Parks of Ahmedabad; designing and executing Annual Flower Show for Ahmedabad Municipal Corporation; studying and mapping biodiversity of birds in city of Ahmedabad; mapping natural world (biodiversity) in institutional campuses like CEPT University and Navrachana University (ongoing) and educational institutes (schools across India); and also giving talks and presentation on topics related to biodiversity in cities and landscape proposal for Zoological parks, Public initiative projects like “ VAD of Vadodara” (mapping Banyan trees) with Pragya Shankar, under Centre for Heritage Research, Navrachana University, Vadodara, etc. ","city":"ahmedabad","state":"Gujarat","country":"India","passport_doc":"I1617000467_Priyanka_Kanhare_Passport.jpeg","oci_card_status":"","oci_card_doc":"","permanent_address":"1/A, Paliadnagar society, near Devkinandan Jain Derasar, Naranpura, Ahmedabad- 380013","crdf_status":"","crdf_code":"","crdf_engagment_status":"","crdf_nature_engagment":"","crdf_from_date":"","crdf_to_date":"","crdf_hours":"","crdf_name_of_center":"","crdf_reporting_to":"","question_status":"{\\\"q1\\\":\\\"N\\\",\\\"q2\\\":\\\"N\\\",\\\"q3\\\":\\\"N\\\",\\\"q4\\\":\\\"N\\\",\\\"q5\\\":\\\"N\\\",\\\"q6\\\":\\\"N\\\",\\\"q7\\\":\\\"N\\\"}","oci_country_status":"","passport_no":"U2291381","aadhaar_no":"","is_submit":"N","total_teaching_experiance":"","total_research_experiance":"","total_industry_experiance":"","indian_citizen":"IN","ind_bank_account":"Y","portfolio_file_name":"I1617000467_Portfolio_Priyanka Kanhare copy.pdf"},[{"sr_no":1,"name":"Gauri Bharat","mobile_no":"99999999","email_id":"gauri.bharat@cept.ac.in "},{"sr_no":2,"name":"Pratyush Shankar","mobile_no":"99999999","email_id":"pratyushshankar@gmail.com "},{"sr_no":3,"name":"Anjali Jain","mobile_no":"99999999","email_id":"anjali.gap@gmail.com "}],[{"sr_no":1,"degree":"Master in Landscape Architecture","specialization":"Landscape Architecture","university":"CEPT University, Ahmedabad","edu_start_date":"07/2013","edu_end_date":"05/2015","edu_percentage":"72.8","edu_mode":"Regular"},{"sr_no":2,"degree":"Bachelor in Architecture","specialization":"Architecture","university":"CEPT University, Ahmedabad","edu_start_date":"07/2007","edu_end_date":"09/2013","edu_percentage":"67.01","edu_mode":"Regular"}],[{"sr_no":1,"work_designation":"Visiting Faculty","work_institute":"CEPT University, Ahmedabad","work_experience_type":"Teaching","work_start_date":"06/1/2019","work_end_date":"12/31/2021","work_experience_year":"","work_expe_total_month":"","work_experience_months":"34"},{"sr_no":2,"work_designation":"Visiting Faculty","work_institute":"Navrachana University, Vadodara","work_experience_type":"Teaching","work_start_date":"06/1/2019","work_end_date":"12/31/2021","work_experience_year":"","work_expe_total_month":"","work_experience_months":"34"},{"sr_no":3,"work_designation":"Visiting Faculty (Thesis)","work_institute":"Sal School of Architecture","work_experience_type":"Teaching","work_start_date":"01/1/2019","work_end_date":"12/31/2019","work_experience_year":"","work_expe_total_month":"","work_experience_months":"13"},{"sr_no":4,"work_designation":"Assistant Professor","work_institute":"Sal School of Architecture","work_experience_type":"Teaching","work_start_date":"01/1/2018","work_end_date":"06/30/2018","work_experience_year":"","work_expe_total_month":"","work_experience_months":"6"},{"sr_no":5,"work_designation":"Academic Associate","work_institute":"CEPT UNIVERSITY, Ahmedabad","work_experience_type":"Teaching","work_start_date":"01/1/2016","work_end_date":"11/30/2017","work_experience_year":"","work_expe_total_month":"","work_experience_months":"25"},{"sr_no":6,"work_designation":"Assistant Professor","work_institute":"INDUS UNIVERSITY, Ahmedabad","work_experience_type":"Teaching","work_start_date":"06/1/2015","work_end_date":"03/31/2017","work_experience_year":"","work_expe_total_month":"","work_experience_months":"24"},{"sr_no":7,"work_designation":"Teaching Assistant","work_institute":"CEPT UNIVERSITY, Ahmedabad","work_experience_type":"Teaching","work_start_date":"07/1/2014","work_end_date":"04/30/2015","work_experience_year":"","work_expe_total_month":"","work_experience_months":"11"}],"S"]';
        //json_All_instructor_data = '[{"instructor_code":"I1","VF_code":"I1","first_name":"Magjikondi","last_name":"Durgasha","title":"Mr.","mail":"AFS@GMAIL.COM","mobile_no":"9662062505","phone_no":"","blood_group":"O-","pan_card_no":"aaadafada","bank_account_number":"145254364644567","account_type":"Saving","name_of_Bank":"sdfsdfsdf","branch_name":"sdfsdf","ifsc_code":"sdf00112365","benificiary_name":"Nitin","dob":"03/20/1987","highest_qualification":"PG","total_experiance":"8","associated_with_cept_since":"","address":"D-37 JOGESHWARI BAUG SOCEITY JAYSHREE TENT PART 2 NR ARBUDANAGAR ROAD RAJENDRA PARKPARK ODHAV AHMEDA","emergency_contact_name":"","emergency_contact_number":"","degree":"","specialization":"","university":"","date_of_issuance_certificate":"","work_designation":"","work_institute":"","work_start_date":"","work_end_date":"","achievements":"I have got certificate for the appreciation regarding the providing the IT Support in Code for Gujarat. I have also participate into the Smart India Hackathon 2018 and 2019.","area_of_interest":"Project Management, IT Services.","cv_file_name":"I1_Cv&amp;portfolio.pdf","image_path":"","gst_number":"","coa_registration_no":"","gender":"M","edu_work_description":"Master of Computer Application, I have worked more than 8 years in IT.","city":"Ahmedabad","state":"Gujarat","country":"india","passport_doc":"I1_Magjikondi_Durgasha_Passport.pdf","oci_card_status":"","oci_card_doc":"","permanent_address":"","crdf_status":"","crdf_code":"","crdf_engagment_status":"","crdf_nature_engagment":"","crdf_from_date":"","crdf_to_date":"","crdf_hours":"","crdf_name_of_center":"","crdf_reporting_to":"","question_status":"{\\\"q1\\\":\\\"N\\\",\\\"q2\\\":\\\"N\\\",\\\"q3\\\":\\\"N\\\",\\\"q4\\\":\\\"N\\\",\\\"q5\\\":\\\"N\\\",\\\"q6\\\":\\\"N\\\",\\\"q7\\\":\\\"N\\\"}","oci_country_status":"","passport_no":"asfsdfsdf","aadhaar_no":"","is_submit":"N","total_teaching_experiance":"","total_research_experiance":"","total_industry_experiance":"","indian_citizen":"IN","ind_bank_account":"Y","portfolio_file_name":"I1_Cv&amp;portfolio.pdf"},[{"sr_no":1,"name":"Mr. Mahroof","mobile_no":"9887844154","email_id":"mahroof@cept.ac.in"},{"sr_no":2,"name":"Mr.Sharma","mobile_no":"8787124584","email_id":"sharma@gmail.com"},{"sr_no":3,"name":"Mr.Patel","mobile_no":"7874548971","email_id":"patel@gmail.com"}],[{"sr_no":1,"degree":"MCA","specialization":"Information Technology","university":"Gujarat University","edu_start_date":"","edu_end_date":"","edu_percentage":"","edu_mode":""}],[{"sr_no":1,"work_designation":"25000","work_institute":"GTU","work_experience_type":"","work_start_date":"12/16/2014","work_end_date":"11/21/2019","work_experience_year":"","work_expe_total_month":"","work_experience_months":"64"}],"S"]';
        // json_All_instructor_data = '[{"instructor_code":"I1","VF_code":"I1","first_name":"Magjikondi","last_name":"Durgasha","title":"Mr.","mail":"AFS@GMAIL.COM","mobile_no":"9662062505","phone_no":"","blood_group":"O-","pan_card_no":"aaadafada","bank_account_number":"145254364644567","account_type":"Saving","name_of_Bank":"sdfsdfsdf","branch_name":"sdfsdf","ifsc_code":"sdf00112365","benificiary_name":"Nitin","dob":"03/20/1987","highest_qualification":"PG","total_experiance":"8","associated_with_cept_since":"","address":"D-37 JOGESHWARI BAUG SOCEITY JAYSHREE TENT PART 2 NR ARBUDANAGAR ROAD RAJENDRA PARKPARK ODHAV AHMEDA","emergency_contact_name":"","emergency_contact_number":"","degree":"","specialization":"","university":"","date_of_issuance_certificate":"","work_designation":"","work_institute":"","work_start_date":"","work_end_date":"","achievements":"I have got certificate for the appreciation regarding the providing the IT Support in Code for Gujarat. I have also participate into the Smart India Hackathon 2018 and 2019.","area_of_interest":"Project Management, IT Services.","cv_file_name":"I1_Cv&amp;portfolio.pdf","image_path":"","gst_number":"","coa_registration_no":"","gender":"M","edu_work_description":"Master of Computer Application, I have worked more than 8 years in IT.","city":"Ahmedabad","state":"Gujarat","country":"india","passport_doc":"I1_Magjikondi_Durgasha_Passport.pdf","oci_card_status":"","oci_card_doc":"","permanent_address":"","crdf_status":"","crdf_code":"","crdf_engagment_status":"","crdf_nature_engagment":"","crdf_from_date":"","crdf_to_date":"","crdf_hours":"","crdf_name_of_center":"","crdf_reporting_to":"","question_status":"{\\\"q1\\\":\\\"N\\\",\\\"q2\\\":\\\"N\\\",\\\"q3\\\":\\\"N\\\",\\\"q4\\\":\\\"N\\\",\\\"q5\\\":\\\"N\\\",\\\"q6\\\":\\\"N\\\",\\\"q7\\\":\\\"N\\\"}","oci_country_status":"","passport_no":"asfsdfsdf","aadhaar_no":"","is_submit":"N","total_teaching_experiance":"","total_research_experiance":"","total_industry_experiance":"","indian_citizen":"IN","ind_bank_account":"Y","portfolio_file_name":"I1_Cv&amp;portfolio.pdf"},[{"sr_no":1,"name":"Mr. Mahroof","mobile_no":"9887844154","email_id":"mahroof@cept.ac.in"},{"sr_no":2,"name":"Mr.Sharma","mobile_no":"8787124584","email_id":"sharma@gmail.com"},{"sr_no":3,"name":"Mr.Patel","mobile_no":"7874548971","email_id":"patel@gmail.com"}],[{"sr_no":1,"degree":"MCA","specialization":"Information Technology","university":"Gujarat University","edu_start_date":"","edu_end_date":"","edu_percentage":"","edu_mode":""}],[{"sr_no":1,"work_designation":"25000","work_institute":"GTU","work_experience_type":"","work_start_date":"12/16/2014","work_end_date":"11/21/2019","work_experience_year":"","work_expe_total_month":"","work_experience_months":"64"}],"S"]';

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_apply_ta_data",
            async: false,
            data: "{ All_table_course_data: '" + json_All_instructor_data + "' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Data Saved Successfully') {
                    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC') {
                        if (action == 'A') {
                            bootbox.alert('Personal Details Submitted Successfully.', function () {
                                //window.location = "VF_personal_detail.aspx";
                                location.reload();
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
                    //else if ($('#hdnusertype').val() == 'HR' || type == "tutor") {
                    //    retrieveInstructorData();
                    //}
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
    if ($('#hdnusertype').val() == 'HR' && type == "tutor") {
        retrieveInstructorData();
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
    //new


    $(function () {
        //$('.date-picker').datepicker({
        //    format: "mm/yyyy",
        //    autoclose: true,
        //    startView: 2,
        //    minViewMode: 1
        //});
        // $('.date-picker').datepicker(
        //{
        //    dateFormat: "mm/yy",
        //    changeMonth: true,
        //    changeYear: true,
        //    showButtonPanel: true,
        //    onClose: function (dateText, inst) {
        //
        //
        //        function isDonePressed() {
        //            return ($('#ui-datepicker-div').html().indexOf('ui-datepicker-close ui-state-default ui-priority-primary ui-corner-all ui-state-hover') > -1);
        //        }
        //
        //        if (isDonePressed()) {
        //            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
        //            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
        //            $(this).datepicker('setDate', new Date(year, month, 1)).trigger('change');
        //
        //            $('.date-picker').focusout()//Added to remove focus from datepicker input box on selecting date
        //        }
        //    },
        //    beforeShow: function (input, inst) {
        //
        //        inst.dpDiv.addClass('month_year_datepicker')
        //
        //        if ((datestr = $(this).val()).length > 0) {
        //            year = datestr.substring(datestr.length - 4, datestr.length);
        //            month = datestr.substring(0, 2);
        //            $(this).datepicker('option', 'defaultDate', new Date(year, month - 1, 1));
        //            $(this).datepicker('setDate', new Date(year, month - 1, 1));
        //            $(".ui-datepicker-calendar").hide();
        //        }
        //    }
        //})
    });
    //Bind Country

    bindcountry();


    $('input[type=radio][name=oci_card]').change(function () {
        if (this.value == 'Y') {

            $('#div_upload_OCICARD').css('display', 'block');
            $('#div_upload_OCICARD1').css('display', 'block');
            $('#div_upload_OCICARD2').css('display', 'block');
            $('#oci_card_country_title').css('display', 'block');
            $('#oci_card_country_title1').css('display', 'block');

            if ($("input[name='oci_country_card']:checked").val() == 'Y') {
                $('#ssn_number_title').css('display', 'block');
                $('#txt_ssn_no').css('display', 'block');
            }
            else if ($("input[name='oci_country_card']:checked").val() == 'N') {
                $('#ssn_number_title').css('display', 'none');
                $('#txt_ssn_no').css('display', 'none');
            }
            else {
                $('#ssn_number_title').css('display', 'none');
                $('#txt_ssn_no').css('display', 'none');
            }



            $('#only_oci_user').css('display', 'block');
            $('#only_other_country').css('display', 'none');

        }
        else if (this.value == 'N') {
            $('#div_upload_OCICARD').css('display', 'none');
            $('#div_upload_OCICARD1').css('display', 'none');
            $('#div_upload_OCICARD2').css('display', 'none');
            $('#oci_card_country_title').css('display', 'none');
            $('#oci_card_country_title1').css('display', 'none');

            $('#ssn_number_title').css('display', 'none');
            $('#txt_ssn_no').css('display', 'none');

            $('#only_oci_user').css('display', 'none');
            $('#only_other_country').css('display', 'block');

        }
    });



    $('input[type=radio][name=oci_country_card]').change(function () {
        if (this.value == 'Y') {

            $('#ssn_number_title').css('display', 'block');
            $('#txt_ssn_no').css('display', 'block');


        }
        else if (this.value == 'N') {
            $('#ssn_number_title').css('display', 'none');
            $('#txt_ssn_no').css('display', 'none');


        }
    });





    $('input[type=radio][name=crdf_ques]').change(function () {
        if (this.value == 'Y') {
            $('#crdf_dtl').css('display', 'block');
            $('#drp_nature_engagement_status').val('');
            $('#drp_engagement_status').val('');
            $('#txt_crdf_code').val('');
            $('#txt_contract_from_date').val('');
            $('#txt_contract_to_date').val('');
            $('#only_crdf_user').css('display', 'block');

        }
        else if (this.value == 'N') {
            $('#crdf_dtl').css('display', 'none');
            $('#drp_nature_engagement_status').val('');
            $('#drp_engagement_status').val('');
            $('#txt_crdf_code').val('');
            $('#txt_contract_from_date').val('');
            $('#txt_contract_to_date').val('');
            $('#only_crdf_user').css('display', 'none');
            //$('#div_upload_OCICARD1').css('display', 'none');
            //$('#div_upload_OCICARD2').css('display', 'none');
        }
        $('tr[class^=part_time_div]').hide().children('td');
    });


    $('.date-picker, .cls_date, #txt_dob, #txt_date_of_issuance_certificate, #txt_work_start_date, #txt_work_end_date').on('focus', function () {
        $('.datepicker-switch').on('click', function () {
            if (this.parentElement.parentElement.parentElement.parentElement.className == "datepicker-days") {
                setTimeout(function () {
                    $('.datepicker-months')[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].click();
                }, 1);
            }
        });
    });

    $('.cls_date').on('change', function () {
        var clasname = $(this)[0].className;
        if (clasname.includes("start_date")) {
            if ($(this).parent().parent().find('.end_date').val() != "") {
                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                //var dt1 = new Date(match[3], match[2], match[1]);

                var dt1 = calculate_month(match);


                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                //var dt2 = new Date(match[3], match[2], match[1]);

                var dt2 = calculate_month(match);

                //var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                //var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));

                var cal_month = calculate_moth_year();
                const divid = parseFloat(cal_month) / parseFloat(12);
                var split_year = String(divid).split(".");
                //for (var i = 0; i < split_year.length; i++) {
                //    if (i == 0) {
                //        $('#txt_experiance_year').val(split_year[0]);
                //    }
                //    else {
                //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                //        $('#txt_experiance_month').val(remaning_month);
                //    }
                //}
            }
        }
        else if (clasname.includes("end_date")) {
            if ($(this).parent().parent().find('.start_date').val() != "") {
                // var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                // var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                //var dt1 = new Date(match[3], match[2], match[1]);


                var dt1 = calculate_month(match);

                var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                //var dt2 = new Date(match[3], match[2], match[1]);

                //var dt2 = calculate_month(match);


                //$(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));



                var dt2 = calculate_month(match);
                $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));


                var thisdata = $(this).closest("tr");
                var type = thisdata.find("td:eq(6)")[0].childNodes[0].id;
                var col1 = thisdata.find("td:eq(5)")[0].childNodes[0].id;
                var col7 = thisdata.find("td:eq(7)")[0].childNodes[0].id;
                var col8 = thisdata.find("td:eq(8)")[0].childNodes[0].id;
                var text_value = $('#' + col1).val();
                var text_value1 = $('#' + col7).val();

                if ($('#' + type).val() == 'Fulltime') {

                    if (parseInt(text_value1) < parseInt('40')) {
                        text_value1 = '40';
                        $('#' + col7).val('40');
                    }

                    if (text_value1 >= 40) {
                        var calculate_month_year = Math.floor(text_value / 12);
                        var month = text_value % 12;
                        $('#' + col8).text(calculate_month_year + '.' + month);
                    }
                    else {
                        bootbox.alert("Please Enter Total no of hours per week Minimum 40");
                    }
                }
                else if ($('#' + type).val() == 'Parttime') {

                    var calculate_month_year = '';
                    if (text_value1 == '') {
                        text_value1 = '20';
                        $('#' + col7).val('20');
                    }
                    if (text_value1 >= 40) {
                        calculate_month_year = Math.floor(text_value / 12);
                        var month = text_value % 12;
                        $('#' + col8).text(calculate_month_year + '.' + month);
                    }
                    else {
                        calculate_month_year = (text_value * text_value1 / 40);
                        calculate_month_year = (calculate_month_year / 12).toFixed(1);
                        //var month = text_value % 12;
                        $('#' + col8).text(calculate_month_year);
                    }

                }
                else if ($('#' + type).val() == 'Remote') {
                    var calculate_month_year = '';
                    if (text_value1 == '') {
                        text_value1 = '20';
                        $('#' + col7).val('20');
                    }
                    if (text_value1 >= 40) {
                        calculate_month_year = Math.floor(text_value / 12);
                        var month = text_value % 12;
                        $('#' + col8).text(calculate_month_year + '.' + month);
                    }
                    else {
                        calculate_month_year = (text_value * text_value1 / 40);
                        calculate_month_year = (calculate_month_year / 12).toFixed(1);
                        //var month = text_value % 12;
                        $('#' + col8).text(calculate_month_year);
                    }
                }



                var cal_month = calculate_moth_year();
                const divid = parseFloat(cal_month) / parseFloat(12);
                var split_year = String(divid).split(".");
                //for (var i = 0; i < split_year.length; i++) {
                //    if (i == 0) {
                //        $('#txt_experiance_year').val(split_year[0]);
                //    }
                //    else {
                //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                //        $('#txt_experiance_month').val(remaning_month);
                //    }
                //}
            }
        }
    });
});
//$(".cls_date").live("change", function ()
//{
//    });


function calculate_moth_year() {

    var row_count = $('#tbl_work_experiance tbody tr').length;
    var month_count = 0;
    for (var i = 0; i < row_count; i++) {
        if (i != 0) {
            var count = parseInt(i) - parseInt(1);
            var moth = $('#dur_' + count).val();
            month_count = parseInt(month_count) + parseInt(moth);
        }

    }
    return month_count;
}

function studio_dtl() {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_studio_proposal_dtl_dashboard",
            async: true,
            data: "{}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {

                    var user_details = JSON.parse(data.d)
                    if (user_details.length > 0) {
                        for (var i = 0; i < user_details.length; i++) {
                            if (user_details[i]["approved"] == 'Y') {
                                $("#sd").css('display', 'block');
                                return false;
                            }
                        }
                    }


                }
                else {
                }

            },
            error: function (result) {
                //alert(result);
            }
        });
    return false;
}

function get_disable_user_data(user_id_new) {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_disable_user_detail",
        async: false,
        data: "{user_id : '" + user_id_new + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d[0] != null && data.d[0] != "") {
                user_status = true;
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

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
                // $('#txt_country_dtl').html(str_drp_country_html);
                if (value != '' && value != undefined) {
                    $('#txt_country_dtl').val(value);
                    $('#txt_country_dtl').change();
                    $('#txt_country_dtl').trigger("liszt:updated");

                    $('#txt_country_dtl').val(value);
                }

            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function country_type_change(country_type) {
    bindcountry();
    $('#txt_country_dtl').val(country_type);
    $('#txt_country_dtl').change();
    $('#txt_country_dtl').trigger("liszt:updated");


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
    else if (tbl == 'academic') {//kapil 09092021
        var AcadamicRowCount = $('#tbl_academic_qualification tbody tr').length + 1;
        var str_row = "<tr><td><select class='program_type1' style ='width: 110px;'>"
            + "<option value=''>Please Select Program Type</option>"
            + "<option value='1'>UG</option>"
            + "<option value='2'>PG</option>"
            + "<option value='3'>Doctoral</option>"
            + "</select></td><td><input type='text' class='marg-btm'/></td><td><input type='text' class='marg-btm'/></td>"
            + "<td> <input type='text' class='marg-btm'/></td>"
            //+"<td style='display:none;'><input type='text' class='cls_date' placeholder='DD/MM/YYYY' style='width: 100px;' /></td>"
            // + "<td><input type='text' class='date-picker' placeholder='MM/YYYY' style='width: 80px;' /></td><td><input type='text' class='date-picker' placeholder='MM/YYYY' style='width: 80px;'/></td>"
            + "<td><input type='text' id='startDate_" + AcadamicRowCount + "' class='date-picker' placeholder='MM/YYYY' style='width: 80px;' /></td>"
            + "<td><input type='text' id='endDate_" + AcadamicRowCount + "' class='date-picker' placeholder='MM/YYYY' style='width: 80px;'/></td>"
            + "<td><select class='per_cgpa_type' style='width: 110px;'>"
            + "<option value=''>Please Select Type</option>"
            + "<option value='Percentage'>Percentage</option>"
            + "<option value='CGPA'>CGPA</option>"
            + "</select></td>"


            + "<td> <input type='text' class='marg-btm' style='width: 80px;'/></td>"
            + " <td><select class='mode_type' style='width: 110px;'>"
            + "<option value=''>Please Select Mode Type</option>"
            + "<option value='Regular'>Regular (Full-time)</option>"
            + "<option value='Part-time'>Part-time</option>"
            + "<option value='Distance Learning'>Distance Learning</option>"
            + "</select></td><td><i class='icon-trash icon-2x text-blue' style='cursor: pointer;'></i></td></tr>";
        $('#tbl_academic_qualification').append(str_row);
        //$('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
        //$('.date-picker').datepicker({ dateFormat: 'mm/yy' });

        //$('.date-picker').datepicker({
        //    format: "mm/yyyy",
        //    autoclose: true,
        //    startView: 2,
        //    minViewMode: 1
        //});

        $("#startDate_" + AcadamicRowCount + "").datepicker({
            format: "mm/yyyy",
            autoclose: true,
            startView: 2,
            minViewMode: 1,
            endDate: new Date(),
        }).on('changeDate', function (ev) {

            $("#endDate_" + ev.currentTarget.id.split('_')[1]).datepicker('setStartDate', ev.date);
        });
        $("#endDate_" + AcadamicRowCount + "").datepicker({
            format: "mm/yyyy",
            autoclose: true,
            startView: 2,
            minViewMode: 1,
            // endDate: new Date //changes 02112022
        }).on('changeDate', function (ev) {

            $("#startDate_" + ev.currentTarget.id.split('_')[1]).datepicker('setEndDate', ev.date);
        });
        $('.date-picker, .cls_date, #txt_dob, #txt_date_of_issuance_certificate, #txt_work_start_date, #txt_work_end_date').on('focus', function () {
            $('.datepicker-switch').on('click', function () {
                if (this.parentElement.parentElement.parentElement.parentElement.className == "datepicker-days") {
                    setTimeout(function () {
                        $('.datepicker-months')[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].click();
                    }, 1);
                }
            });
        });

        $('.cls_date').on('change', function () {
            var clasname = $(this)[0].className;
            if (clasname.includes("start_date")) {
                if ($(this).parent().parent().find('.end_date').val() != "") {
                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                    //var dt1 = new Date(match[3], match[2], match[1]);


                    var dt1 = calculate_month(match);

                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                    //var dt2 = new Date(match[3], match[2], match[1]);

                    var dt2 = calculate_month(match);

                    //var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                    //var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                    $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));

                    var cal_month = calculate_moth_year();
                    const divid = parseFloat(cal_month) / parseFloat(12);
                    var split_year = String(divid).split(".");
                    //for (var i = 0; i < split_year.length; i++) {
                    //    if (i == 0) {
                    //        $('#txt_experiance_year').val(split_year[0]);
                    //    }
                    //    else {
                    //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                    //        $('#txt_experiance_month').val(remaning_month);
                    //    }
                    //}
                }
            }
            else if (clasname.includes("end_date")) {
                if ($(this).parent().parent().find('.start_date').val() != "") {
                    // var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                    // var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                    //var dt1 = new Date(match[3], match[2], match[1]);


                    var dt1 = calculate_month(match);

                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                    //var dt2 = new Date(match[3], match[2], match[1]);


                    var dt2 = calculate_month(match);

                    $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
                    var cal_month = calculate_moth_year();
                    const divid = parseFloat(cal_month) / parseFloat(12);
                    var split_year = String(divid).split(".");
                    //for (var i = 0; i < split_year.length; i++) {
                    //    if (i == 0) {
                    //        $('#txt_experiance_year').val(split_year[0]);
                    //    }
                    //    else {
                    //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                    //        $('#txt_experiance_month').val(remaning_month);
                    //    }
                    //}
                }
            }
        });


        //id="startDate" class="date-picker"
        //$('.cls_date_new').datepicker({ dateFormat: 'mm/yy' });
    }
    else if (tbl == 'work') {
        var table_length = $('#tbl_work_experiance tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        var str_row = "<tr><td><input type='text' class='marg-btm' style='width: 180px;'/></td><td><input type='text' class='marg-btm' style='width: 120px;'/></td><td>"
            + "<select class='experience_type' style='width: 140px;'>"
            + "<option value=''>Please Select Experience Type</option>"
            + "<option value='Teaching'>Teaching</option>"
            + "<option value='Research'>Research</option>"
            + "<option value='Industry'>Industry/Professional</option>"
            + "</select>"
            + "</td>"
            + "<td> <input type='text' class='cls_date start_date' id='start_" + table_length + "' placeholder='DD/MM/YYYY' style='width: 120px;' /></td><td><input type='text' id='end_" + table_length + "' class='cls_date end_date' placeholder='DD/MM/YYYY' style='width: 120px;'/></td><td><input type = 'text' id='dur_" + table_length + "' class='cls_duration' style='width: 125px;' disabled/></td>"
            + " <td><select class='work_mode_type' id ='mode_type_" + table_length + "' style='width: 110px;'>"
            + "<option value=''>Please Select Mode Type</option>"
            + "<option value='Fulltime'>Full-time</option>"
            + "<option value='Parttime'>Part-time</option>"
            + "<option value='Remote'>Remote</option>"
            + "</select></td>"
            + "<td><input type='text' class='marg-btm onchangetext' id='total_hrs_" + table_length + "' style='width: 120px;'/></td>"
            + "<td><span  id='year_month_" + table_length + "'></span></td>"
            + "<td><label class='btn btn-primary file-upload' style='vertical-align: bottom;vertical-align: bottom;width: 100px;padding: 0px;margin-left: 25px'><span><strong>Upload</strong></span>"
            + "<input type = 'file' name = 'experienceupload' class='experienceupload' id = 'experienceupload_" + table_length + "' onchange = 'javascript: return UploadWorkExperienceCertificate(this);' /></label> "
            + "<span class='lbl_experience_file_name_" + table_length + "'></span></td>"
            + "<td><i class='icon-trash icon-2x text-blue' style='cursor: pointer;'></i></td></tr> ";
        //+ "<input type = 'text' class='cls_duration' style='width: 125px;' disabled/></td><td><input type='number' name='quantity' min='0' max='100' id='txt_experiance_year' style='width: 60px; display: inline; 'placeholder='Year' onkeypress='return onlyNumberKey(event)' onkeyup='this.value = fnc(this.value, 0, 100)'/></td>"
        //+ "<td><input type='number' name='quantity' min='0' max='12' id='txt_experiance_month' style='width: 60px; display: inline; ' onkeypress='return onlyNumberKey(event)' placeholder='Month' onkeyup='this.value = fnc_2(this.value, 0, 12)'/></td></tr>";
        $('#tbl_work_experiance').append(str_row);
        //$('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });

        $("#start_" + table_length).datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true,
            endDate: new Date(),
        }).on('changeDate', function (ev) {

            $("#end_" + ev.currentTarget.id.split('_')[1]).datepicker('setStartDate', ev.date);
        });
        $("#end_" + table_length).datepicker({
            format: 'dd/mm/yyyy',
            autoclose: true,
            endDate: new Date()
        }).on('changeDate', function (ev) {

            $("#start_" + ev.currentTarget.id.split('_')[1]).datepicker('setEndDate', ev.date);
        });
        $('.date-picker, .cls_date, #txt_dob, #txt_date_of_issuance_certificate, #txt_work_start_date, #txt_work_end_date').on('focus', function () {
            $('.datepicker-switch').on('click', function () {
                if (this.parentElement.parentElement.parentElement.parentElement.className == "datepicker-days") {
                    setTimeout(function () {
                        $('.datepicker-months')[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].click();
                    }, 1);
                }
            });
        });

        $('.cls_date').on('change', function () {
            debugger;
            var clasname = $(this)[0].className;
            if (clasname.includes("start_date")) {
                if ($(this).parent().parent().find('.end_date').val() != "") {
                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                    //var dt1 = new Date(match[3], match[2], match[1]);



                    var dt1 = calculate_month(match);

                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                    //var dt2 = new Date(match[3], match[2], match[1]);

                    var dt2 = calculate_month(match);

                    //var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                    //var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                    $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));



                    var thisdata = $(this).closest("tr");
                    var type = thisdata.find("td:eq(6)")[0].childNodes[0].id;
                    var col1 = thisdata.find("td:eq(5)")[0].childNodes[0].id;
                    var col7 = thisdata.find("td:eq(7)")[0].childNodes[0].id;
                    var col8 = thisdata.find("td:eq(8)")[0].childNodes[0].id;
                    var text_value = $('#' + col1).val();
                    var text_value1 = $('#' + col7).val();

                    if ($('#' + type).val() == 'Fulltime') {

                        if (parseInt(text_value1) < parseInt('40')) {
                            text_value1 = '40';
                            $('#' + col7).val('40');
                        }
                        if (text_value1 >= 40) {
                            var calculate_month_year = Math.floor(text_value / 12);
                            var month = text_value % 12;
                            $('#' + col8).text(calculate_month_year + '.' + month);
                        }
                        else {
                            bootbox.alert("Please Enter Total no of hours per week Minimum 40");
                        }
                    }
                    else if ($('#' + type).val() == 'Parttime') {

                        var calculate_month_year = '';
                        if (text_value1 == '') {
                            text_value1 = '20';
                            $('#' + col7).val('20');
                        }
                        if (text_value1 >= 40) {
                            calculate_month_year = Math.floor(text_value / 12);
                            var month = text_value % 12;
                            $('#' + col8).text(calculate_month_year + '.' + month);
                        }
                        else {
                            calculate_month_year = (text_value * text_value1 / 40);
                            calculate_month_year = (calculate_month_year / 12).toFixed(1);
                            //var month = text_value % 12;
                            $('#' + col8).text(calculate_month_year);
                        }

                    }
                    else if ($('#' + type).val() == 'Remote') {
                        var calculate_month_year = '';
                        if (text_value1 == '') {
                            text_value1 = '20';
                            $('#' + col7).val('20');
                        }
                        if (text_value1 >= 40) {
                            calculate_month_year = Math.floor(text_value / 12);
                            var month = text_value % 12;
                            $('#' + col8).text(calculate_month_year + '.' + month);
                        }
                        else {
                            calculate_month_year = (text_value * text_value1 / 40);
                            calculate_month_year = (calculate_month_year / 12).toFixed(1);
                            //var month = text_value % 12;
                            $('#' + col8).text(calculate_month_year);
                        }
                    }





                    var cal_month = calculate_moth_year();
                    const divid = parseFloat(cal_month) / parseFloat(12);
                    var split_year = String(divid).split(".");
                    //for (var i = 0; i < split_year.length; i++) {
                    //    if (i == 0) {
                    //        $('#txt_experiance_year').val(split_year[0]);
                    //    }
                    //    else {
                    //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                    //        $('#txt_experiance_month').val(remaning_month);
                    //    }
                    //}
                }
            }
            else if (clasname.includes("end_date")) {
                if ($(this).parent().parent().find('.start_date').val() != "") {
                    // var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                    // var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                    //var dt1 = new Date(match[3], match[2], match[1]);


                    var dt1 = calculate_month(match);

                    var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())

                    //var dt2 = new Date(match[3], match[2], match[1]);

                    var dt2 = calculate_month(match);

                    $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
                    var cal_month = calculate_moth_year();
                    const divid = parseFloat(cal_month) / parseFloat(12);
                    var split_year = String(divid).split(".");
                    //for (var i = 0; i < split_year.length; i++) {
                    //    if (i == 0) {
                    //        $('#txt_experiance_year').val(split_year[0]);
                    //    }
                    //    else {
                    //        var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                    //        $('#txt_experiance_month').val(remaning_month);
                    //    }
                    //}
                }
            }
        });


        //$('.cls_date').datepicker({
        //    format: "dd/mm/yyyy",
        //    autoclose: true
        //});
    }

    return false;
}
var Exits_country_status = "";
var country_value = '';
function retrieveInstructorData() {

    var instructor_code = '';
    //|| $('#hdnusertype').val() == 'A1'
    //|| $('#hdnusertype').val() == 'I2'
    if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'A1' || $('#hdnusertype').val() == 'PC') {
        instructor_code = $('#hdn_icode').val();

        if (instructor_code == '') {
            bootbox.alert('No Instructor found');
        }
    }
    else if ($('#hdnusertype').val() == 'HR' || $('#hdnusertype').val() == 'A') {
        if ($('#hdnusertype').val() == 'HR' && tutor_types == "tutor") {
            instructor_code = $('#hdn_icode').val();

            if (instructor_code == '') {
                bootbox.alert('No Instructor found');
            }

        }
        else {
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


    }
    else {
        instructor_code = $('#hdn_icode').val();
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
                //if ($('#hdnusertype').val() == 'HR' && tutor_types == "tutor")
                //{
                //    $('#hdn_icode').val(instructor_data[0]["instructor_code"]);
                //}

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

                Exits_country_status = instructor_data[0]["indian_citizen"];
                //$('#IC' + instructor_data[0]["indian_citizen"]).attr('checked', 'checked');

                if (instructor_data[0]["indian_citizen"].trim() == "N") {
                    country_value = 'IN';
                    //country_type_change(value);
                    edit_bindcountry(country_value);
                }
                else {
                    country_value = instructor_data[0]["indian_citizen"].trim();
                    edit_bindcountry(country_value);


                    if (country_value != "IN" && country_value != "") {
                        $('#oci_card_title').css('display', 'block');
                        $('#oci_card_title1').css('display', 'block');
                        $('#only_other_country').css('display', 'block');
                        $('#indian_country').css('display', 'block');
                        $('#online_working_title').css('display', 'block');
                        $('#online_working_title1').css('display', 'block');

                    }
                    else {
                        $('#oci_card_title').css('display', 'none');
                        $('#oci_card_title1').css('display', 'none');
                        $('#online_working_title').css('display', 'none');
                        $('#online_working_title1').css('display', 'none');

                        $('#ssn_number_title').css('display', 'none');
                        $('#txt_ssn_no').css('display', 'none');


                        $('#div_upload_OCICARD').css('display', 'none');
                        $('#div_upload_OCICARD1').css('display', 'none');
                        $('#div_upload_OCICARD2').css('display', 'none');

                        $('#oci_card_country_title').css('display', 'none');
                        $('#oci_card_country_title1').css('display', 'none');

                        $('#only_other_country').css('display', 'none');
                        $('#indian_country').css('display', 'block');
                    }


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


                if (instructor_data[0]["Cept_student_id"] != "")
                {
                    $("input[name='CEPTSTU_DTL'][value='Y']").prop('checked', true);
                    $('.labelstudentid').css('display', '');
                    $('.textstudentid').css('display', '');
                    $('.textstudentid').val(instructor_data[0]["Cept_student_id"]);
                }
                else
                {
                    $("input[name='CEPTSTU_DTL'][value='N']").prop('checked', true);
                    $('.labelstudentid').css('display', 'none');
                    $('.textstudentid').css('display', 'none');
                    $('.textstudentid').val('');
                }



                var address_add = instructor_data[0]["address"].split('@#');
                if (address_add[0] != '') {

                    for (var i = 0; i < address_add.length; i++) {
                        if (i == 0) {
                            $('#txt_address').val(address_add[0]);
                        }
                        else {
                            var city_address = address_add[i].split('@ci#');
                            var state_address = address_add[i].split('@s#');
                            var country_address = address_add[i].split('@c#');
                            if (city_address.length == 2) {
                                $('#txt_city_res').val(city_address[0]);
                            }
                            if (state_address.length == 2) {
                                $('#txt_state_res').val(state_address[0]);
                            }
                            if (country_address.length == 2) {
                                $('#txt_country_res').val(country_address[0]);
                            }



                            // if (address_add[i].split('@ci#').length == 2) {
                            //     var city_value = address_add[i].split('@ci#');
                            //     $('#txt_city_res').val(city_value[0]);
                            // }
                            // if (address_add[i].split('@s#').length == 2) {
                            //     var state_value = address_add[i].split('@s#');
                            //     $('#txt_state_res').val(state_value[0]);
                            // }
                            // if (address_add[i].split('@c#').length == 2) {
                            //     var country_value = address_add[i].split('@c#');
                            //     $('#txt_country_res').val(country_value[0]);
                            // }

                            //var second_line_address = address_add[i].split('@c#');
                            //if (second_line_address[0] != '' && second_line_address[0] != undefined)
                            //{
                            //    $('#txt_address_' + i).val(second_line_address[0]);
                            //}

                            $('#txt_address_' + i).val(address_add[i]);
                        }

                    }


                }
                else {
                    $('#txt_address').val(instructor_data[0]["address"]);
                }


                //$('#txt_address').val(instructor_data[0]["address"]);
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

                /*$('#lbl_cv_file_name').html('<b>' + instructor_data[0]["cv_file_name"] + '</b>');*/
                $('#lbl_cv_file_name').html('<b><a href="../../InstructorCVUpload/' + instructor_data[0]["cv_file_name"] + '" target="_blank">' + instructor_data[0]["cv_file_name"] + '</b>');
                FileName = instructor_data[0]["cv_file_name"];

                //$('#lbl_port_file_name').html('<b>' + instructor_data[0]["portfolio_file_name"] + '</b>');
                $('#lbl_port_file_name').html('<b><a href="../../InstructorPortfolioUpload/' + instructor_data[0]["portfolio_file_name"] + '" target="_blank">' + instructor_data[0]["portfolio_file_name"] + '</b>');
                FileNameforPort = instructor_data[0]["portfolio_file_name"];

                //13092021
                $('#lbl_passport_file_name').html('<b><a href="../../Passport/' + instructor_data[0]["passport_doc"] + '" target="_blank">' + instructor_data[0]["passport_doc"] + '</a></b>');


                Passport_FileName = instructor_data[0]["passport_doc"];

                $('#lbl_ocicard_file_name').html('<b>' + instructor_data[0]["oci_card_doc"] + '</b>');
                OCI_Card_FileName = instructor_data[0]["oci_card_doc"];
                $('#oci_' + instructor_data[0]["oci_card_status"]).attr('checked', 'checked');
                if (instructor_data[0]["oci_card_status"].trim() == 'Y') {
                    $('#div_upload_OCICARD').css('display', 'block');
                    $('#only_oci_user').css('display', 'block');
                    $('#only_other_country').css('display', 'none');

                }
                else if (instructor_data[0]["oci_card_status"].trim() == 'N') {
                    $('#div_upload_OCICARD').css('display', 'none');
                    $('#only_oci_user').css('display', 'none');
                    $('#only_other_country').css('display', 'block');
                }
                //changes 01032022
                var permanent_add = instructor_data[0]["permanent_address"].split('@#');
                if (permanent_add[0] != '') {

                    for (var i = 0; i < permanent_add.length; i++) {
                        if (i == 0) {
                            $('#txt_permanent_address').val(permanent_add[0]);
                        }
                        else {
                            $('#txt_permanent_address_' + i).val(permanent_add[i]);
                        }

                    }
                } else { $('#txt_permanent_address').val(instructor_data[0]["permanent_address"]); }

                Aadhaar_Card_FileName = instructor_data[0]["aadhaar_doc"];
                COA_Card_FileName = instructor_data[0]["coa_doc"];
                $('#lbl_coacard_file_name').html('<b><a href="../../COACard/' + instructor_data[0]["coa_doc"] + '" target="_blank">' + instructor_data[0]["coa_doc"] + '</a></b>');
                //$('#lbl_coacard_file_name').html('<b>' + instructor_data[0]["coa_doc"] + '</b>');
                //$('#lbl_aadhaar_file_name').html('<b>' + instructor_data[0]["aadhaar_doc"] + '</b>');
                $('#lbl_aadhaar_file_name').html('<b><a href="../../AadhaarCard/' + instructor_data[0]["aadhaar_doc"] + '" target="_blank">' + instructor_data[0]["aadhaar_doc"] + '</a></b>');


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

                if (instructor_data[0]["crdf_status"] != "") {
                    $('#crdf_' + instructor_data[0]["crdf_status"]).attr('checked', 'checked');
                    $('#only_crdf_user').css('display', 'block');

                }
                if (instructor_data[0]["crdf_status"] == 'Y') {
                    $('#crdf_dtl').css('display', 'block');
                }
                else {
                    $('#crdf_dtl').css('display', 'none');
                    $('#only_crdf_user').css('display', 'none');
                }
                if (instructor_data[0]["crdf_nature_engagment"] != 'Full Time') {
                    $('tr[class^=part_time_div]').show().children('td');
                }
                else {
                    $('tr[class^=part_time_div]').hide().children('td');
                }

                $('#txt_crdf_code').val(instructor_data[0]["crdf_code"]);
                $('#drp_engagement_status').val(instructor_data[0]["crdf_engagment_status"]);
                $('#drp_nature_engagement_status').val(instructor_data[0]["crdf_nature_engagment"]);
                $('#txt_eng_hourse').val(instructor_data[0]["crdf_hours"]);
                $('#txt_center_name').val(instructor_data[0]["crdf_name_of_center"]);
                $('#txt_reporting_to').val(instructor_data[0]["crdf_reporting_to"]);
                $('#txt_contract_from_date').val(instructor_data[0]["crdf_from_date"]);
                $('#txt_contract_to_date').val(instructor_data[0]["crdf_to_date"]);

                // $('#oci_' + instructor_data[0]["oci_card_status"]).attr('checked', 'checked');
                if (instructor_data[0]["question_status"] != '') {
                    var obj_question_status = JSON.parse(instructor_data[0]["question_status"]);
                    //for (var i = 1; i <= obj_question_status.length; i++)
                    //{
                    if (obj_question_status["q1"] == 'Y') {
                        $('#q1').attr('checked', 'checked');
                    }
                    if (obj_question_status["q2"] == 'Y') {
                        $('#q2').attr('checked', 'checked');
                    }

                    if (obj_question_status["q3"] == 'Y') {
                        $('#q3').attr('checked', 'checked');
                    }
                    if (obj_question_status["q4"] == 'Y') {
                        $('#q4').attr('checked', 'checked');
                    }
                    if (obj_question_status["q5"] == 'Y') {
                        $('#q5').attr('checked', 'checked');
                    }

                    if (obj_question_status["q6"] == 'Y') {
                        $('#q6').attr('checked', 'checked');
                    }
                    if (obj_question_status["q7"] == 'Y') {
                        $('#q7').attr('checked', 'checked');
                    }
                }

                //$('#oci_' + instructor_data[0]["oci_card_status"]).attr('checked', 'checked');
                //}


                //End
                if (instructor_data[0]["oci_country_status"].trim() != '') {
                    $('#oci_country_' + instructor_data[0]["oci_country_status"]).attr('checked', 'checked');

                    $('#oci_card_country_title').css('display', 'block');
                    $('#oci_card_country_title1').css('display', 'block');
                }


                $('#txt_experiance_year').val(instructor_data[0]["total_work_experience_year"]);
                $('#txt_experiance_month').val(instructor_data[0]["total_work_experience_month"])

                if (instructor_data[0]["online_working_status"] != "") {
                    $('#online_working_' + instructor_data[0]["online_working_status"]).attr('checked', 'checked');
                    if (instructor_data[0]["online_working_status"] == "Y") {
                        $('#ssn_number_title').css('display', 'block');
                        $('#txt_ssn_no').css('display', 'block');
                    }
                    if (instructor_data[0]["online_working_status"] == "N") {
                        $('#ssn_number_title').css('display', 'none');
                        $('#txt_ssn_no').css('display', 'none');
                    }


                }

                $('#txt_ssn_no').val(instructor_data[0]["social_security_no"]);

                if (instructor_data[0]["designation"] == "temp") {
                    user_temp = true;
                    //$("#txt_pan_card_no").prop("disabled", true);
                    $("#bank_1").css('display', 'none');
                    $("#bank_2").css('display', 'none');
                    $("#bank_3").css('display', 'none');
                    $("#bank_4").css('display', 'none');
                    $("#bank_5").css('display', 'none');
                    $("#bank_6").css('display', 'none');
                    $("#bank_7").css('display', 'none');

                    $("#txt_bank_account_no").prop("disabled", true);
                    $("#txt_account_type").prop("disabled", true);
                    $("#txt_name_of_the_bank").prop("disabled", true);
                    $("#txt_branch_name").prop("disabled", true);
                    $("#txt_ifsc_code").prop("disabled", true);
                    $("#txt_benificiary_name").prop("disabled", true);
                }
                else if (instructor_data[0]["designation"] == "TA") {
                    user_temp = false;
                    bank_dtl_status = true;
                    if (type != "tutor") {

                        //$("#bank_1").css('display', 'block');
                        //$("#bank_2").css('display', 'block');
                        //$("#bank_3").css('display', 'block');
                        //$("#bank_4").css('display', 'block');
                        //$("#bank_5").css('display', 'block');
                        //$("#bank_6").css('display', 'block');
                        //$("#bank_7").css('display', 'block');
                    }


                    $("#txt_bank_account_no").prop("disabled", false);
                    $("#txt_account_type").prop("disabled", false);
                    $("#txt_name_of_the_bank").prop("disabled", false);
                    $("#txt_branch_name").prop("disabled", false);
                    $("#txt_ifsc_code").prop("disabled", false);
                    $("#txt_benificiary_name").prop("disabled", false);

                }
                //31012022 Only VF User Type 
                else if (instructor_data[0]["designation"] == "VF" && $('#inst_work_load_dtl').val() == "Y") {
                    user_temp = false;
                    bank_dtl_status = true;

                    if (type != "tutor") {

                        //$("#bank_1").css('display', 'block');
                        //$("#bank_2").css('display', 'block');
                        //$("#bank_3").css('display', 'block');
                        //$("#bank_4").css('display', 'block');
                        //$("#bank_5").css('display', 'block');
                        //$("#bank_6").css('display', 'block');
                        //$("#bank_7").css('display', 'block');
                    }




                    $("#txt_bank_account_no").prop("disabled", false);
                    $("#txt_account_type").prop("disabled", false);
                    $("#txt_name_of_the_bank").prop("disabled", false);
                    $("#txt_branch_name").prop("disabled", false);
                    $("#txt_ifsc_code").prop("disabled", false);
                    $("#txt_benificiary_name").prop("disabled", false);
                }

                else if ($('#studio_submit_dtl').val() == 'Y') {
                    user_temp = false;
                    bank_dtl_status = true;

                    if (type != "tutor") {

                        //$("#bank_1").css('display', 'block');
                        //$("#bank_2").css('display', 'block');
                        //$("#bank_3").css('display', 'block');
                        //$("#bank_4").css('display', 'block');
                        //$("#bank_5").css('display', 'block');
                        //$("#bank_6").css('display', 'block');
                        //$("#bank_7").css('display', 'block');
                    }

                    $("#txt_bank_account_no").prop("disabled", false);
                    $("#txt_account_type").prop("disabled", false);
                    $("#txt_name_of_the_bank").prop("disabled", false);
                    $("#txt_branch_name").prop("disabled", false);
                    $("#txt_ifsc_code").prop("disabled", false);
                    $("#txt_benificiary_name").prop("disabled", false);
                }

                else {
                    //user_temp = false;
                    //$("#txt_bank_account_no").prop("disabled", false);
                    //$("#txt_account_type").prop("disabled", false);
                    //$("#txt_name_of_the_bank").prop("disabled", false);
                    //$("#txt_branch_name").prop("disabled", false);
                    //$("#txt_ifsc_code").prop("disabled", false);
                    //$("#txt_benificiary_name").prop("disabled", false);
                }


                if (instructor_data[0]["is_submit"] == "Y") {
                    //kapil 15092021
                    $("#btnnext").css('display', 'none');
                    $("#pd").css('background-color', 'white');
                }
                else {
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
                    //kapil 09092021
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
                            var edu_start_date = instructor_education_work[i]['edu_start_date'];
                            var edu_end_date = instructor_education_work[i]['edu_end_date'];
                            //var str_row = "<tr><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['degree'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['specialization'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['university'] + "'/></td><td><input type='text' class='cls_date' value='" + date_of_issuance_certificate + "'/></td></tr>";
                            // var str_row = "<tr><td><input type='text' class='marg-btm' value=''/></td><td><input type='text' class='marg-btm' value=''/></td><td><input type='text' class='marg-btm' value='' /></td> <td><input type='text' class='cls_date' value='" + date_of_issuance_certificate + "' /></td></tr > ";

                            var str_row = "<tr><td><select class='program_type1' style = 'width: 110px;'>"
                                + "<option value=''>Please Select Program Type</option>"
                                + "<option value='1'>UG</option>"
                                + "<option value='2'>PG</option>"
                                + "<option value='3'>Doctoral</option>"
                                + "</select></td><td><input type='text' class='marg-btm' value=''/></td>"
                                + "<td><input type='text' class='marg-btm' value=''/></td>"
                                + "<td><input type='text' class='marg-btm' value='' /></td>"
                                /*  + "<td style='display:none;'><input type='text' class='cls_date' value='" + date_of_issuance_certificate + "' style='width: 100px;display:none;'/></td>"*/
                                + "<td><input type='text' id ='startDate_" + total_edu_row + "' class='date-picker' placeholder='MM/YYYY' value='" + edu_start_date + "' style='width: 80px;'/></td>"
                                + "<td><input type='text' id='endDate_" + total_edu_row + "' class='date-picker' placeholder='MM/YYYY' value='" + edu_end_date + "' style='width: 80px;'/></td>"

                                + "<td><select class='per_cgpa_type' style='width: 110px;'>"
                                + "<option value=''>Please Select Type</option>"
                                + "<option value='Percentage'>Percentage</option>"
                                + "<option value='CGPA'>CGPA</option>"
                                + "</select></td>"

                                + "<td><input type='text' class='marg-btm' value='' style='width: 80px;'/></td>"
                                + "<td><select class='mode_type' style='width: 110px;'>"
                                + "<option value=''>Please Select Mode Type</option>"
                                + "<option value='Regular'>Regular (Full-time)</option>"
                                + "<option value='Part-time'>Part-time</option>"
                                + "<option value='Distance Learning'>Distance Learning</option>"
                                + "</select></td><td><i class='icon-trash icon-2x text-blue' style='cursor: pointer;'></i></td></tr>";
                            $('#tbl_academic_qualification').append(str_row);

                            $("#startDate_" + total_edu_row + "").datepicker({
                                format: "mm/yyyy",
                                autoclose: true,
                                startView: 2,
                                minViewMode: 1,
                                endDate: edu_end_date,
                            }).on('changeDate', function (ev) {

                                $("#endDate_" + ev.currentTarget.id.split('_')[1]).datepicker('setStartDate', ev.date);
                            });
                            $("#endDate_" + total_edu_row + "").datepicker({
                                format: "mm/yyyy",
                                autoclose: true,
                                startView: 2,
                                minViewMode: 1,
                                startDate: edu_start_date,
                                //endDate: new Date //changes 02112022
                            }).on('changeDate', function (ev) {

                                $("#startDate_" + ev.currentTarget.id.split('_')[1]).datepicker('setEndDate', ev.date);
                            });

                            $('#tbl_academic_qualification tbody tr:last-child td')[0].children[0].value = instructor_education_work[i]['program_code'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[1].children[0].value = instructor_education_work[i]['degree'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[2].children[0].value = instructor_education_work[i]['specialization'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[3].children[0].value = instructor_education_work[i]['university'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[7].children[0].value = instructor_education_work[i]['edu_percentage'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[8].children[0].value = instructor_education_work[i]['edu_mode'];
                            $('#tbl_academic_qualification tbody tr:last-child td')[6].children[0].value = instructor_education_work[i]['edu_type'];
                        }
                        else if (instructor_education_work[i]['detail_type'] == 'work') {
                            total_work_row++;
                            var work_start_date = convertDate(instructor_education_work[i]['work_start_date']);
                            var work_end_date = convertDate(instructor_education_work[i]['work_end_date']);

                            var dt1 = new Date(instructor_education_work[i]['work_start_date']);
                            var dt2 = new Date(instructor_education_work[i]['work_end_date']);

                            var table_length = (total_work_row - 1);
                            //var str_row = "<tr><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['work_designation'] + "'/></td><td><input type='text' class='marg-btm' value='" + instructor_education_work[i]['work_institute'] + "'/></td><td><input type='text' class='cls_date' value='" + work_start_date + "'/></td><td><input type='text' class='cls_date' value='" + work_end_date + "'/></td></tr>";
                            var str_row = "<tr><td><input type='text' class='marg-btm' value='' style='width: 180px;'/></td><td><input type='text' class='marg-btm' value='' style='width: 120px;'/></td><td><select class='experience_type' style='width: 140px;'>"
                                + "<option value=''>Please Select Experience Type</option>"
                                + "<option value='Teaching'>Teaching</option>"
                                + "<option value='Research'>Research</option>"
                                + "<option value='Industry'>Industry/Professional</option>"
                                + "</select>"
                                + "</td ><td><input type='text' class='cls_date start_date' id='start_" + table_length + "' value='" + work_start_date + "' style='width: 120px;'/></td><td><input type='text' id='end_" + table_length + "' class='cls_date end_date' value='" + work_end_date + "' style='width: 120px;'/></td>"
                                + "<td><input type = 'text' id='dur_" + table_length + "' class='cls_duration' style='width: 125px;' value='" + diff_months(dt1, dt2) + "' disabled/></td>"
                                + " <td><select class='work_mode_type' id ='mode_type_" + table_length + "' style='width: 110px;'>"
                                + "<option value=''>Please Select Mode Type</option>"
                                + "<option value='Fulltime'>Full-time</option>"
                                + "<option value='Parttime'>Part-time</option>"
                                + "<option value='Remote'>Remote</option>"
                                + "</select></td>"
                                + "<td><input type='text' class='marg-btm onchangetext' id='total_hrs_" + table_length + "' style='width: 120px;'/></td>"
                                + "<td><span  id='year_month_" + table_length + "'></span></td>"
                                + "<td><label class='btn btn-primary file-upload' style='vertical-align: bottom;vertical-align: bottom;width: 100px;padding: 0px;margin-left: 25px'><span><strong>Upload</strong></span>"
                                + "<input type = 'file' name = 'experienceupload' class='experienceupload' id = 'experienceupload_" + table_length + "' onchange = 'javascript: return UploadWorkExperienceCertificate(this);' /></label> "
                                + "<span class='lbl_experience_file_name_" + table_length + "'></span></td>"
                                + "<td><i class='icon-trash icon-2x text-blue' style='cursor: pointer;'></i></td> </tr> ";
                            //+ "<td><input type='number' name='quantity' min='0' max='100' id='txt_experiance_year' style='width: 60px; display: inline; 'placeholder='Year' onkeypress='return onlyNumberKey(event)' onkeyup='this.value = fnc(this.value, 0, 100)'/></td>"
                            //+ "<td><input type='number' name='quantity' min='0' max='12' id='txt_experiance_month' style='width: 60px; display: inline; ' onkeypress='return onlyNumberKey(event)' placeholder='Month' onkeyup='this.value = fnc_2(this.value, 0, 12)'/></td></tr>";
                            $('#tbl_work_experiance').append(str_row);

                            $("#start_" + table_length).datepicker({
                                format: 'dd/mm/yyyy',
                                autoclose: true,
                                endDate: work_end_date
                            }).on('changeDate', function (ev) {

                                $("#end_" + ev.currentTarget.id.split('_')[1]).datepicker('setStartDate', ev.date);
                            });
                            $("#end_" + table_length).datepicker({
                                format: 'dd/mm/yyyy',
                                autoclose: true,
                                startDate: work_start_date,
                                endDate: new Date()
                            }).on('changeDate', function (ev) {

                                $("#start_" + ev.currentTarget.id.split('_')[1]).datepicker('setEndDate', ev.date);
                            });


                            $('#tbl_work_experiance tbody tr:last-child td')[1].children[0].value = instructor_education_work[i]['work_designation']
                            $('#tbl_work_experiance tbody tr:last-child td')[0].children[0].value = instructor_education_work[i]['work_institute']
                            $('#tbl_work_experiance tbody tr:last-child td')[2].children[0].value = instructor_education_work[i]['work_experience_type']
                            //28022022
                            $('#tbl_work_experiance tbody tr:last-child td')[6].children[0].value = instructor_education_work[i]['work_mode']
                            $('#tbl_work_experiance tbody tr:last-child td')[7].children[0].value = instructor_education_work[i]['work_week_per_hours']


                            var row_no = instructor_education_work[i]['sr_no'];
                            $('.lbl_experience_file_name_' + (row_no - 1)).html('<a href="../../InstructorWorkExperiencecertificate/' + instructor_education_work[i]['work_experience_cert'] + '" target="_blank">' + instructor_education_work[i]['work_experience_cert'] + '</a>');
                            debugger;
                            if (instructor_education_work[i]['work_year_month'] != '') {
                                $('#year_month_' + (row_no - 1)).html(instructor_education_work[i]['work_year_month']);
                            }
                            else {
                                if (instructor_education_work[i]['detail_type'] == 'work') {


                                    var work_mode = instructor_education_work[i]['work_mode']
                                    var work_week_per_hours = instructor_education_work[i]['work_week_per_hours']
                                    var duration = diff_months(dt1, dt2);
                                    if (work_mode != "" && work_week_per_hours != "" && duration != "") {
                                        var year_month = calu_year_month(work_mode, work_week_per_hours, duration)
                                        debugger;
                                        $('#year_month_' + (row_no - 1)).html(year_month);
                                    }
                                    else {
                                        $('#year_month_' + (row_no - 1)).html(instructor_education_work[i]['work_year_month']);
                                    }
                                }

                            }


                            calculatemonthyear();
                            //end
                            //$('#tbl_work_experiance tbody tr:last-child td')[6].children[0].value = instructor_education_work[i]['work_experience_year']
                            //$('#tbl_work_experiance tbody tr:last-child td')[7].children[0].value = instructor_education_work[i]['work_expe_total_month']

                            //$('.cls_date').on('change', function () {
                            //
                            //    var clasname = $(this)[0].className;
                            //    if (clasname.includes("start_date")) {
                            //        if ($(this).parent().parent().find('.end_date').val() != "") {
                            //           // var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                            //            //var dt1 = new Date($(this).parent().parent().find('.start_date').val());
                            //           // var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                            //           
                            //            var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                            //            var dt1 = new Date(match[3], match[2], match[1]);
                            //           
                            //            var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                            //            var dt2 = new Date(match[3], match[2], match[1]);
                            //            
                            //            $(this).parent().parent().find('.cls_duration').val(diff_months(dt1, dt2));
                            //
                            //            var cal_month = calculate_moth_year();
                            //            const divid = parseFloat(cal_month) / parseFloat(12);
                            //            var split_year = String(divid).split(".");
                            //            for (var i = 0; i < split_year.length; i++) {
                            //                if (i == 0) {
                            //                    $('#txt_experiance_year').val(split_year[0]);
                            //                }
                            //                else {
                            //                    var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                            //                    $('#txt_experiance_month').val(remaning_month);
                            //                }
                            //            }
                            //        }
                            //    } else if (clasname.includes("end_date"))
                            //    {
                            //        if ($(this).parent().parent().find('.start_date').val() != "")
                            //        {
                            //            //var start = $(this).parent().parent().find('.start_date').val().split('/');
                            //            //var end = $(this).parent().parent().find('.end_date').val().split('/')
                            //            //var start_date = new Date(start[0] + "-" + start[1] + "-" + start[2]);
                            //            //var end_date = new Date(end[0] + "-" + end[1] + "-" + end[2]);
                            //            //
                            //            //var diffDate = (end_date - start_date) / (1000 * 60 * 60 * 24);
                            //            //alert(Math.round(diffDate));
                            //            //var days = Math.round(diffDate);
                            //
                            //           // var dt1 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.start_date').val()));
                            //            //var dt2 = new Date(convertDateCalculateMonth($(this).parent().parent().find('.end_date').val()));
                            //
                            //            var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.start_date').val())
                            //            var dt1 = new Date(match[3], match[2], match[1]);
                            //
                            //            var match = /(\d+)\/(\d+)\/(\d+)/.exec($(this).parent().parent().find('.end_date').val())
                            //            var dt2 = new Date(match[3], match[2], match[1]);
                            //            $(this).parent().parent().find('.cls_duration').val(diff_months(dt2, dt1));
                            //            var cal_month = calculate_moth_year();
                            //            const divid = parseFloat(cal_month) / parseFloat(12);
                            //            var split_year = String(divid).split(".");
                            //            for (var i = 0; i < split_year.length; i++) {
                            //                if (i == 0) {
                            //                    $('#txt_experiance_year').val(split_year[0]);
                            //                }
                            //                else {
                            //                    var remaning_month = parseInt(cal_month) - parseInt(split_year[0] * 12)
                            //                    $('#txt_experiance_month').val(remaning_month);
                            //                }
                            //            }
                            //
                            //        }
                            //    }
                            //});
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

                    //$('.cls_date').datepicker({ dateFormat: 'dd/mm/yy' });
                    //$('.cls_date').datepicker({
                    //    format: "dd/mm/yyyy",
                    //    autoclose: true
                    //});
                }
            }

            if (data.d[2] != null && data.d[2] != '') {
                var ta_details = JSON.parse(data.d[2]);
                for (var p = 0; p < ta_details.length; p++) {
                    $('#txt_prev_ta_dtl').text(ta_details[0]['past_studio_ta_txt']);

                    $('#lbl_reference_letter_name').html('<b><a href="../../TAReferenceLetter/' + ta_details[0]['refrence_letter_path'] + '" target="_blank">' + ta_details[0]['refrence_letter_path'] + '</b>');
                    //$('#lbl_reference_letter_name').text(ta_details[0]['refrence_letter_path']);

                    if (ta_details[p]['apply_type'] == '23') {
                        $('#dept_' + ta_details[p]['dept_code']).attr('checked', true);
                    }
                    else if (ta_details[p]['apply_type'] == '24') {
                        $('#course_' + ta_details[p]['dept_code']).attr('checked', true);
                    }

                    if (ta_details[0]['is_submit'] == 'Y') {
                        $('#btnapprove').css('display', 'none');
                    }
                    else { $('div#submitBtnDiv').css('display', 'block'); }
                }
            }

            $('#drp_title').trigger("liszt:updated");
            $('#txt_highest_qualification').trigger("liszt:updated");
            $('#txt_blood_group').trigger("liszt:updated");
            $('#txt_associated_with_cept_since').trigger("liszt:updated");
            //$('#txt_country_dtl').change();
            //$('#txt_country_dtl').trigger("liszt:updated");
            //$('#txt_country_dtl').val('IN');
            // $('#txt_country_dtl').change();
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
var FileNameforPort_TA = '';
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

var Passport_FileName = '';
var OCI_Card_FileName = '';
var COA_Card_FileName = '';
var Aadhaar_Card_FileName = '';
function UploadPassportpdf() {//
    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading Passport.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading Passport.");
        return false;
    }
    else if ($("#txt_passport_no").val() == "") {
        alert("Please Enter Passport No before uploading Passport.");
        return false;
    }

    else {
        try {
            var fileToUpload = GetFileNameFromPath($('#passportUpload').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserPassporOCICardExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {
                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Instructor_Passport_Upload.ashx',
                            secureuri: false,
                            fileElementId: 'passportUpload',
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#passportUpload').val("");
                                        $('#lbl_passport_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload

                                        Passport_FileName = data.upfile;
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
                alert('Invalid File Type. Please upload jpeg / png / pdf file');
            }
            return false;
        }
        catch (e) {
            alert("Exception : " + e.message);
        }
    }
}

function UploadOCICARDpdf() {//
    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading Passport.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading Passport.");
        return false;
    }

    else {
        try {
            var fileToUpload = GetFileNameFromPath($('#OCICARDUpload').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserPassporOCICardExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {
                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Instructor_OCICard_Upload.ashx',
                            secureuri: false,
                            fileElementId: 'OCICARDUpload',
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#OCICARDUpload').val("");
                                        $('#lbl_ocicard_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload

                                        OCI_Card_FileName = data.upfile;
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
                alert('Invalid File Type. Please upload jpeg / png / pdf file');
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

function Uploadreferenceletter() {
    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading Reference Letter.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading Reference Letter.");
        return false;
    } else {
        try {
            var fileToUpload = GetFileNameFromPath($('#reference_letter').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserPhotoExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {
                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/TA_reference_letter.ashx',
                            secureuri: false,
                            fileElementId: 'reference_letter',
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#reference_letter').val("");
                                        $('#lbl_reference_letter_name').html('<b>' + data.upfile + '</b>');//fileToUpload

                                        FileNameforPort_TA = data.upfile;
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

function CheckUserPassporOCICardExtension(file) {
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
        if (dd < 10) dd = '0' + dd;

        var convertedDate = '' + dd + '/' + mm + '/' + year;
        return convertedDate;
    }
    return '';
}

function convertDateCalculateMonth(str_date) {
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


//changes 14092021

$(function () {
    $("#same_address_id").click(function () {
        if ($(this).is(":checked")) {
            var permanent_address = $('#txt_permanent_address').val();
            if (permanent_address != '') {
                $('#txt_address').val(permanent_address);
            }
            var permanent_address_1 = $('#txt_permanent_address_1').val();
            if (permanent_address_1 != '') {
                $('#txt_address_1').val(permanent_address_1);
            }

            var permanent_address_city = $('#txt_city').val();
            if (permanent_address_city != '') {
                $('#txt_city_res').val(permanent_address_city);
            }
            var permanent_address_state = $('#txt_state').val();
            if (permanent_address_state != '') {
                $('#txt_state_res').val(permanent_address_state);
            }
            var permanent_address_country = $('#txt_country').val();
            if (permanent_address_country != '') {
                $('#txt_country_res').val(permanent_address_country);
            }

            //var permanent_address_2 = $('#txt_permanent_address_2').val();
            //if (permanent_address_2 != '') {
            //    $('#txt_address_2').val(permanent_address_2);
            //}
        }
    });
});


function changecountry() {
    var country_val = $('#txt_country_dtl').val();
    if (country_val == '') {
        country_value = '';
    }
    if (Exits_country_status.trim() != country_val) {
        if (country_val == 'IN') {
            $('#oci_card_title').css('display', 'none');
            $('#oci_card_title1').css('display', 'none');
            $('#online_working_title').css('display', 'none');
            $('#online_working_title1').css('display', 'none');
            $('#ssn_number_title').css('display', 'none');
            $('#txt_ssn_no').css('display', 'none');

            $('#indian_country').css('display', 'block');
            $('#only_other_country').css('display', 'none');
            $('#only_oci_user').css('display', 'none');

        }
        else if (country_val == "") {
            $('#oci_card_title').css('display', 'none');
            $('#oci_card_title1').css('display', 'none');
            $('#online_working_title').css('display', 'none');
            $('#online_working_title1').css('display', 'none');

            $('#ssn_number_title').css('display', 'none');
            $('#txt_ssn_no').css('display', 'none');

        }
        else {
            $('#oci_card_title').css('display', 'block');
            $('#oci_card_title1').css('display', 'block');
            $('#online_working_title').css('display', 'block');
            $('#online_working_title1').css('display', 'block');

            if (true) {

            }
            $('#ssn_number_title').css('display', 'none');
            $('#txt_ssn_no').css('display', 'none');

            $('#only_other_country').css('display', 'block');
            $('#indian_country').css('display', 'block');


        }

        $('#div_upload_OCICARD').css('display', 'none');
        $('#div_upload_OCICARD1').css('display', 'none');
        $('#div_upload_OCICARD2').css('display', 'none');
        $('#oci_card_country_title').css('display', 'none');
        $('#oci_card_country_title1').css('display', 'none');




        $("#oci_Y").prop('checked', false);
        $("#oci_N").prop('checked', false);
        $("#oci_country_N").prop('checked', false);
        $("#oci_country_Y").prop('checked', false);
        $("#online_working_Y").prop('checked', false);
        $("#online_working_N").prop('checked', false);
    }
    else if (country_val != 'IN' && country_val != '') {
        $('#oci_card_title').css('display', 'block');
        $('#oci_card_title1').css('display', 'block');

        $('#online_working_title').css('display', 'block');
        $('#online_working_title1').css('display', 'block');



        if ($("#oci_country_Y").is(':checked') == true) {
            $('#ssn_number_title').css('display', 'block');
            $('#txt_ssn_no').css('display', 'block');
        }
        else if ($("#oci_country_Y").is(':checked') == false) {
            $('#ssn_number_title').css('display', 'none');
            $('#txt_ssn_no').css('display', 'none');
        }



        var value_oci = $("input[name='oci_card']:checked").val();
        if (value_oci == 'N' || value_oci == undefined) {
            $('#div_upload_OCICARD').css('display', 'none');
            $('#div_upload_OCICARD1').css('display', 'none');
            $('#div_upload_OCICARD2').css('display', 'none');
            $('#oci_card_country_title').css('display', 'none');
            $('#oci_card_country_title1').css('display', 'none');

            $('#ssn_number_title').css('display', 'none');
            $('#txt_ssn_no').css('display', 'none');

            $('#txt_ssn_no').val('');

            $("#oci_Y").prop('checked', false);
            $("#oci_country_Y").prop('checked', false);

        }
        else {
            $('#div_upload_OCICARD').css('display', 'block');
            $('#div_upload_OCICARD1').css('display', 'block');
            $('#div_upload_OCICARD2').css('display', 'block');

            $('#oci_card_country_title').css('display', 'block');
            $('#oci_card_country_title1').css('display', 'block');
        }
        if (value_oci == 'Y' || value_oci == undefined) {
            $('#only_other_country').css('display', 'none');
            $("#q5").prop('checked', false);
            $("#q4").prop('checked', false);
        }
        else { $('#only_other_country').css('display', 'block'); }


        //$("input[name=oci_card][value='N']").attr('checked', 'checked');

    }

    else {
        $('#oci_card_title').css('display', 'none');
        $('#oci_card_title1').css('display', 'none');

        $('#online_working_title').css('display', 'none');
        $('#online_working_title1').css('display', 'none');

        $('#ssn_number_title').css('display', 'none');
        $('#txt_ssn_no').css('display', 'none');

        $('#div_upload_OCICARD').css('display', 'none');
        $('#div_upload_OCICARD1').css('display', 'none');
        $('#div_upload_OCICARD2').css('display', 'none');
    }
}


function UploadCOACARDpdf() {//
    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading Passport.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading Passport.");
        return false;
    }

    else {
        try {
            var fileToUpload = GetFileNameFromPath($('#COACARDUpload').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserPassporOCICardExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {
                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Instructor_COACard_Upload.ashx',
                            secureuri: false,
                            fileElementId: 'COACARDUpload',
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#COACARDUpload').val("");
                                        $('#lbl_coacard_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload

                                        COA_Card_FileName = data.upfile;
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
                alert('Invalid File Type. Please upload jpeg / png / pdf file');
            }
            return false;
        }
        catch (e) {
            alert("Exception : " + e.message);
        }
    }
}



function UploadAadhaarpdf() {//
    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading Passport.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading Passport.");
        return false;
    }

    else {
        try {
            var fileToUpload = GetFileNameFromPath($('#aadhaarUpload').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserPassporOCICardExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {
                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Instructor_aadhaarCard_Upload.ashx',
                            secureuri: false,
                            fileElementId: 'aadhaarUpload',
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#aadhaarUpload').val("");
                                        $('#lbl_aadhaar_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload

                                        Aadhaar_Card_FileName = data.upfile;
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
                alert('Invalid File Type. Please upload jpeg / png / pdf file');
            }
            return false;
        }
        catch (e) {
            alert("Exception : " + e.message);
        }
    }
}

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
    else if (parseInt(value) > 100)
        return "Number is greater than 100";
    else return value;
}
function fnc_2(value, min, max) {
    if (parseInt(value) < 0 || isNaN(value))
        return 0;
    else if (parseInt(value) > 12)
        return "Number is greater than 12";
    else return value;
}

function changenature_time() {
    var nature_enga = $('#drp_nature_engagement_status').val();
    if (nature_enga == 'Part Time') {
        $('tr[class^=part_time_div]').show().children('td');
    }
    else {
        $('tr[class^=part_time_div]').hide().children('td');

    }
    $('#txt_eng_hourse').val('');
    $('#txt_center_name').val('');
    $('#txt_reporting_to').val('');

}

function CheckUserWorkExperience(file) {
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
var Workexperience_FileName = '';
function UploadWorkExperienceCertificate(data_id) {

    var file_index = data_id.id;
    var get_last_index = '';
    if (file_index != '') {
        var index_value = file_index.split('_');
        get_last_index = index_value[1];
    }

    if ($("#txt_first_name").val() == "") {
        alert("Please Enter First Name before uploading work certificate.");
        return false;
    }
    else if ($("#txt_last_name").val() == "") {
        alert("Please Enter Last Name before uploading work certificate..");
        return false;
    } else {
        try {
            var fileToUpload = GetFileNameFromPath($('#' + data_id.id).val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckUserWorkExperience(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {

                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Instructor_Work_Experience_certificate_upload.ashx',
                            secureuri: false,
                            fileElementId: data_id.id,
                            data: { 'ICODE': $('#hdn_icode').val(), 'FNAME': $("#txt_first_name").val(), 'LNAME': $("#txt_last_name").val() },

                            dataType: 'json',
                            success: function (data, status) {

                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#' + file_index).val("");
                                        $('.lbl_experience_file_name_' + get_last_index).html('<b>' + data.upfile + '</b>');//fileToUpload

                                        Workexperience_FileName = data.upfile;
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

$(".work_mode_type").live("change", function () {
    debugger;
    var type = this.value;
    var thisdata = $(this).closest("tr");

    /* var col1 = thisdata.find("td:eq(5)")[0].childNodes[0].id;*/
    var tdElement = thisdata.find("td:eq(5)")[0];
    var col1 = $(tdElement).find('input')[0].id;


    /* var col7 = thisdata.find("td:eq(7)")[0].childNodes[0].id;*/

    var tdElement1 = thisdata.find("td:eq(7)")[0];
    var col7 = $(tdElement1).find('input')[0].id;


    var col8 = thisdata.find("td:eq(8)")[0].childNodes[0].id;

    //var tdElement2 = thisdata.find("td:eq(8)")[0];
    //var col8 = $(tdElement2).find('input')[0].id;


    var text_value = $('#' + col1).val();
    var text_value1 = $('#' + col7).val();

    if (type == 'Fulltime') {
        if (parseInt(text_value1) < parseInt('40')) {
            text_value1 = '40';
            $('#' + col7).val('40');
        }

        if (text_value1 >= 40) {
            var calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            $('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            bootbox.alert("Please Enter Total no of hours per week Minimum 40");
        }
    }
    else if (type == 'Parttime') {

        var calculate_month_year = '';
        //if (text_value1 == '') {
        text_value1 = '20';
        $('#' + col7).val('20');
        //}
        if (text_value1 >= 40) {
            calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            $('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            calculate_month_year = (text_value * text_value1 / 40);
            calculate_month_year = (calculate_month_year / 12).toFixed(1);
            //var month = text_value % 12;
            $('#' + col8).text(calculate_month_year);
        }

    }
    else if (type == 'Remote') {
        var calculate_month_year = '';
        //if (text_value1 == '') {
        text_value1 = '20';
        $('#' + col7).val('20');
        //}
        if (text_value1 >= 40) {
            calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            $('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            calculate_month_year = (text_value * text_value1 / 40);
            calculate_month_year = (calculate_month_year / 12).toFixed(1);
            //var month = text_value % 12;
            $('#' + col8).text(calculate_month_year);
        }
    }

    calculatemonthyear();


});
$(".onchangetext").live("keyup", function () {
    debugger;
    var type = this.value;
    var thisdata = $(this).closest("tr");
    var col6 = thisdata.find("td:eq(6)")[0].childNodes[0].id;
    var col1 = thisdata.find("td:eq(5)")[0].childNodes[0].id;
    var col7 = thisdata.find("td:eq(7)")[0].childNodes[0].id;
    var col8 = thisdata.find("td:eq(8)")[0].childNodes[0].id;
    var text_value = $('#' + col1).val();
    var text_value1 = $('#' + col7).val();

    var type = $('#' + col6).val();

    if (type == 'Fulltime') {

        if (text_value1 >= 40) {
            var calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            $('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            bootbox.alert("Please Enter Total no of hours per week Minimum 40");
        }
    }
    else if (type == 'Parttime') {

        var calculate_month_year = '';
        if (text_value1 >= 40) {
            calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            $('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            calculate_month_year = (text_value * text_value1 / 40);
            calculate_month_year = (calculate_month_year / 12).toFixed(1);
            //var month = text_value % 12;
            $('#' + col8).text(calculate_month_year);
        }

    }
    else if (type == 'Remote') {
        var calculate_month_year = '';
        if (text_value1 >= 40) {
            calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            $('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            calculate_month_year = (text_value * text_value1 / 40);
            calculate_month_year = (calculate_month_year / 12).toFixed(1);
            //var month = text_value % 12;
            $('#' + col8).text(calculate_month_year);
        }
    }
    calculatemonthyear();

});



function calu_year_month(type, text_value1, text_value) {



    var calculate_month_year = '';
    if (type == 'Fulltime') {

        if (text_value1 >= 40) {
            calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            calculate_month_year = calculate_month_year + '.' + month;

            //$('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            // bootbox.alert("Please Enter Total no of hours per week Minimum 40");
        }
        return calculate_month_year;
    }
    else if (type == 'Parttime') {

        var calculate_month_year = '';
        if (text_value1 >= 40) {
            calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            calculate_month_year = calculate_month_year + '.' + month;
            //$('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            calculate_month_year = (text_value * text_value1 / 40);
            calculate_month_year = (calculate_month_year / 12).toFixed(1);
            //calculate_month_year = calculate_month_year + '.' + month;

            //var month = text_value % 12;
            //$('#' + col8).text(calculate_month_year);
        }
        return calculate_month_year;

    }
    else if (type == 'Remote') {
        var calculate_month_year = '';
        if (text_value1 >= 40) {
            calculate_month_year = Math.floor(text_value / 12);
            var month = text_value % 12;
            calculate_month_year = calculate_month_year + '.' + month;
            // $('#' + col8).text(calculate_month_year + '.' + month);
        }
        else {
            calculate_month_year = (text_value * text_value1 / 40);
            calculate_month_year = (calculate_month_year / 12).toFixed(1);
            //var month = text_value % 12;
            // $('#' + col8).text(calculate_month_year);
        }
        return calculate_month_year;
    }


}

//function calculatemonthyear() {
//    var arrData = [];
//    var total_month = 0;
//    var total_year = 0;
//    $("#tbl_work_experiance tr").each(function () {
//        var currentRow = $(this);
//        var col1_value = currentRow.find("td:eq(8)").text();


//        var obj = {};
//        obj.col1 = col1_value;
//        if (col1_value != '') {


//            var split_year_month = col1_value.split(".");
//            total_year = parseInt(total_year) + parseInt(split_year_month[0]);
//            total_month = parseFloat(total_month) + parseFloat(split_year_month[1]);




//        }
//        arrData.push(obj);
//    });

//    if (total_month != 0 && total_year != 0) {

//        var total_convert_year = total_year;
//        total_convert_year = parseInt(total_convert_year) + parseInt(Math.floor(total_month / 12));
//        var total_convert_month = total_month % 12;



//        $('#txt_experiance_year').val(total_convert_year);
//        $('#txt_experiance_month').val(total_convert_month);
//    }
//}


function calculatemonthyear() {
    var total_month = 0;
    var total_year = 0;

    $("#tbl_work_experiance tr").each(function () {
        var currentRow = $(this);
        var col1_value = currentRow.find("td:eq(8)").text().trim();
        if (col1_value !== '' && col1_value.includes(".")) {
            var split_year_month = col1_value.split(".");
            var year = parseInt(split_year_month[0], 10);
            var month = parseInt(split_year_month[1], 10);
            if (!isNaN(year)) {
                total_year += year;
            }
            if (!isNaN(month)) {
                total_month += month;
            }
        }
    });
    if (total_month > 0) {
        total_year += Math.floor(total_month / 12);
        var remaining_month = total_month % 12;
        $('#txt_experiance_year').val(total_year);
        $('#txt_experiance_month').val(remaining_month);
    }
    else {
        $('#txt_experiance_year').val(total_year);
        $('#txt_experiance_month').val(0);
    }
}


function calculate_month(match) {
    var dt = '';
    if (match[2] == '12') {
        dt = new Date(match[3] + ' Dec ' + match[1]);
    }
    else if (match[2] == '11') {
        dt = new Date(match[3] + ' Nov ' + match[1]);
    }
    else if (match[2] == '10') {
        dt = new Date(match[3] + ' Oct ' + match[1]);
    }
    else if (match[2] == '9' || match[2] == '09') {
        dt = new Date(match[3] + ' Sep ' + match[1]);
    }
    else if (match[2] == '8' || match[2] == '08') {
        dt = new Date(match[3] + ' Aug ' + match[1]);
    }
    else if (match[2] == '7' || match[2] == '07') {
        dt = new Date(match[3] + ' Jul ' + match[1]);
    }
    else if (match[2] == '6' || match[2] == '06') {
        dt = new Date(match[3] + ' Jun ' + match[1]);
    }
    else if (match[2] == '5' || match[2] == '05') {
        dt = new Date(match[3] + ' May ' + match[1]);
    }
    else if (match[2] == '4' || match[2] == '04') {
        dt = new Date(match[3] + ' Apr ' + match[1]);
    }
    else if (match[2] == '3' || match[2] == '03') {
        dt = new Date(match[3] + ' Mar ' + match[1]);
    }
    else if (match[2] == '2' || match[2] == '02') {
        dt = new Date(match[3] + ' Feb ' + match[1]);
    }
    else if (match[2] == '1' || match[2] == '01') {
        dt = new Date(match[3] + ' Jan ' + match[1]);
    }
    else { dt = new Date(match[3], match[2], match[1]); }
    return dt;

}