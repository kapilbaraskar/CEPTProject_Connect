var instructor = '';
var instructor_tutorial = '';
var TA_instructor = '';
var area = '';
var semester = '';
var day = '';
var day_tutorial = '';
var action = 'S';
var prog_name_flag = false;
var temp_typology = '';
var typology_detail = [];
//var old_typology = [];
//var new_typology = [];
var to_be_later_inst = '';//04032022
var course_wise_ta = '';//04032022
var obj_typology_group = [];
var obj_typology = {};
var image_save_date;
var obj_FileName = [];
var short_dept = { '1': 'FA', '2': 'FD', '3': 'FM', '4': 'FP', '5': 'FT', '9': 'CFP' }

//14 11 2019 
var current_row_id_room;
var from_time1;
var to_time1;
var day_code1;
var current_sem;
var current_year;
var typology_hrs_dtl = [];
var ontrigger_update = false;
var btn_ret_new_flag = false;
//14 11 2019 

var temp_sub_group_typology = ''; // Returned By Ananth


var add_instructor_cnt = 1;
var add_aa_cnt = 1;
var add_ta_cnt = 1;
var course_publish_status = 'N';
var studio_course_or_not = false;

function IsNumeric(e) {
    //alert(e.which + " : " + e.keyCode);
    var keyCode = e.which ? e.which : e.keyCode;

    //if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
    if (keyCode == 8 || keyCode == 46 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {

        if (parseInt($(document.activeElement).val()) > 10) {
            return false;
        }
        else if (parseInt($(document.activeElement).val()) == 10) {
            if (keyCode != 48) {
                return false;
            }
        }

        return true;
    }
    else {
        return false;
    }
}

function edValueKeyPress_add_aa(e) {
    var pre_value = '';
    var week_value = '';
    var per_loda_id = e + '_' + 'aa_per_load';
    var weeks_id = e + '_' + 'aa_week';
    var total_hours_new = e + '_' + 'aa_add_hrs';
    pre_value = $('#' + per_loda_id).val();
    week_value = $('#' + weeks_id).val();
    total_hrs_value = $('#' + total_hours_new).val();
    if (pre_value != '' && week_value != '') {
        var calculate_hrs = (parseFloat(parseFloat(pre_value) * parseFloat(week_value))).toFixed(0);
        if (total_hrs_value != '') {
            total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
            $('#' + e + '_' + 'aa_hrs_new').val(total_hours_new);
        } else { $('#' + e + '_' + 'aa_hrs_new').val(total_hrs_value); }

    }

}
function edValueKeyPress_add_ta(e) {
    var pre_value = '';
    var week_value = '';
    var per_loda_id = e + '_' + 'ta_per_load';
    var weeks_id = e + '_' + 'ta_week';
    var total_hours_new = e + '_' + 'ta_add_hrs';
    pre_value = $('#' + per_loda_id).val();
    week_value = $('#' + weeks_id).val();
    total_hrs_value = $('#' + total_hours_new).val();
    if (pre_value != '' && week_value != '') {
        var calculate_hrs = (parseFloat(parseFloat(pre_value) * parseFloat(week_value))).toFixed(0);
        if (total_hrs_value != '') {
            total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
            $('#' + e + '_' + 'ta_hrs_new').val(total_hours_new);
        }
        else {

            $('#' + e + '_' + 'ta_hrs_new').val(total_hrs_value);
        }

    }

}


function edValueKeyPress_new(e) {
    var pre_value = '';
    var week_value = '';
    var per_loda_id = e + '_' + 'per_load';
    var weeks_id = e + '_' + 'week';
    var total_hours_new = e + '_' + 'add_hrs';
    pre_value = $('#' + per_loda_id).val();
    week_value = $('#' + weeks_id).val();
    total_hrs_value = $('#' + total_hours_new).val();
    if (pre_value != '' && week_value != '') {
        var calculate_hrs = (parseFloat(parseFloat(pre_value) * parseFloat(week_value))).toFixed(0);
        total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
        $('#' + e + '_' + 'add_hrs_new').val(total_hours_new);
    }
    else if (pre_value != '' && week_value == '') {

    }
    else if (pre_value == '' && week_value != '') {

    }
    else if (pre_value == '' && week_value == '') {

    }

}

function edValueKeyPress(e)
{
    var pre_value = '';
    var week_value = '';
    var total_hrs_value = '';
    var per_loda_id = e + '_' + 'per_load';
    var weeks_id = e + '_' + 'week';
    var total_hours_new = e + '_' + 'add_hrs';
    pre_value = $('#' + per_loda_id).val();
    week_value = $('#' + weeks_id).val();
    total_hrs_value = $('#' + total_hours_new).val();
    if (pre_value != '' && week_value != '')
    {
        var calculate_hrs = (parseFloat(parseFloat(pre_value) * parseFloat(week_value))).toFixed(0);
        $('#' + e + '_' + 'total_hrs').val(calculate_hrs);
        total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
        $('#' + e + '_' + 'add_hrs_new').val(total_hours_new);
    }
    else if (pre_value != '' && week_value == '')
    {
        var calculate_hrs = '';
        $('#' + e + '_' + 'total_hrs').val(calculate_hrs);
        //total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
        //$('#' + e + '_' + 'add_hrs_new').val(total_hours_new);
    }
    else if (pre_value == '' && week_value != '')
    {
        var calculate_hrs = '';
        $('#' + e + '_' + 'total_hrs').val(calculate_hrs);
        //total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
        //$('#' + e + '_' + 'add_hrs_new').val(total_hours_new);
    }
    else if (pre_value == '' && week_value == '')
    {
        var calculate_hrs = '';
        $('#' + e + '_' + 'total_hrs').val(calculate_hrs);
        //total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
        //$('#' + e + '_' + 'add_hrs_new').val(total_hours_new);
    }

}

function edValueKeyPress_ta(e) {
    var pre_value = '';
    var week_value = '';
    var total_hrs_value = '';
    var per_loda_id = e + '_' + 'ta_per_load';
    var weeks_id = e + '_' + 'ta_week';
    var total_hours_new = e + '_' + 'ta_add_hrs';
    pre_value = $('#' + per_loda_id).val();
    week_value = $('#' + weeks_id).val();
    total_hrs_value = $('#' + total_hours_new).val();
    if (pre_value != '' && week_value != '') {
        var calculate_hrs = (parseFloat(parseFloat(pre_value) * parseFloat(week_value))).toFixed(0);
        $('#' + e + '_' + 'ta_total_hrs').val(calculate_hrs);
        if (total_hrs_value != '') {
            total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
            $('#' + e + '_' + 'ta_hrs_new').val(total_hours_new);
        } else { $('#' + e + '_' + 'ta_hrs_new').val(total_hrs_value); }
    }
    else if (pre_value != '' && week_value == '') {
        var calculate_hrs = '';
        $('#' + e + '_' + 'ta_total_hrs').val(calculate_hrs);
    }
    else if (pre_value == '' && week_value != '') {
        var calculate_hrs = '';
        $('#' + e + '_' + 'ta_total_hrs').val(calculate_hrs);
    }
    else if (pre_value == '' && week_value == '') {
        var calculate_hrs = '';
        $('#' + e + '_' + 'ta_total_hrs').val(calculate_hrs);
    }

}

function edValueKeyPress_aa(e) {
    var pre_value = '';
    var week_value = '';
    var total_hrs_value = '';
    var per_loda_id = e + '_' + 'aa_per_load';
    var weeks_id = e + '_' + 'aa_week';
    var total_hours_new = e + '_' + 'aa_add_hrs';
    pre_value = $('#' + per_loda_id).val();
    week_value = $('#' + weeks_id).val();
    total_hrs_value = $('#' + total_hours_new).val();
    if (pre_value != '' && week_value != '') {
        var calculate_hrs = (parseFloat(parseFloat(pre_value) * parseFloat(week_value))).toFixed(0);
        $('#' + e + '_' + 'aa_total_hrs').val(calculate_hrs);
        if (total_hrs_value != '') {
            total_hours_new = (parseFloat(parseFloat(total_hrs_value) + parseFloat(calculate_hrs))).toFixed(0);
            $('#' + e + '_' + 'aa_hrs_new').val(total_hours_new);
        }
        else { $('#' + e + '_' + 'aa_hrs_new').val(total_hrs_value); }
    }
    else if (pre_value != '' && week_value == '') {
        var calculate_hrs = '';
        $('#' + e + '_' + 'aa_total_hrs').val(calculate_hrs);
    }
    else if (pre_value == '' && week_value != '') {
        var calculate_hrs = '';
        $('#' + e + '_' + 'aa_total_hrs').val(calculate_hrs);
    }
    else if (pre_value == '' && week_value == '') {
        var calculate_hrs = '';
        $('#' + e + '_' + 'aa_total_hrs').val(calculate_hrs);
    }

}

function IsNumeric_istructor(e) {
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {
        if ($('#drp_contact_hrs').val() == "PR") {
            if (parseInt($(document.activeElement).val()) > 10) {
                return false;
            }
            else if (parseInt($(document.activeElement).val()) == 10) {
                if (keyCode != 48) {
                    return false;
                }
            }
        }
        else {
            if (parseInt($(document.activeElement).val()) > 40) {
                return false;
            }
            else if (parseInt($(document.activeElement).val()) == 40) {
                if (keyCode != 48) {
                    return false;
                }
            }
        }
        var dInput = this.value;
        console.log(dInput);
        return true;
    }
    else {
        return false;
    }
}

function IsNumeric_istructor_in(e) {
    var keyCode = e.which ? e.which : e.keyCode;
    var activeElement = $(document.activeElement);
    var currentValue = activeElement.val();
    var decimalIndex = currentValue.indexOf('.');

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {

        var newValue = currentValue + String.fromCharCode(keyCode);

        if (parseInt(newValue) > 399.99) {
            bootbox.alert('Maximum input value is 399.99')
            return false;
        }
        // Allow only two decimal places
        if (decimalIndex !== -1 && newValue.length - decimalIndex > 3) {
            return false;
        }

        if ($('#drp_contact_hrs').val() == "PR") {
            if (parseInt($(document.activeElement).val()) > 10) {
                return false;
            }
            else if (parseInt($(document.activeElement).val()) == 10) {
                if (keyCode != 48) {
                    return false;
                }
            }
        }
        else {
            if (parseInt($(document.activeElement).val()) > 399.999) {
                return false;
            }
            else if (parseInt($(document.activeElement).val()) == 40) {
                if (keyCode != 48) {
                    return false;
                }
            }
        }

        if (keyCode == 190 || keyCode == 110) { // Decimal point (.) key codes
            if (decimalIndex === -1) {
                return true;
            } else {
                return false; // Prevent multiple decimal points
            }
        }

        // Limit to two decimal places
        if (decimalIndex !== -1 && currentValue.length - decimalIndex > 3) {
            return false;
        }

        return true;
    }
    else {
        return false;
    }
}

//function keydown_removechar(e) {
//    /////Character
//    if (e.keyCode == 8) {
//        if ($('#txtcourse_description').val() != '') {
//            $('#spn_desc').html('' + 'Total Char : ' + ($('#txtcourse_description').val().length - 1));
//        }
//    }
//}

//function charcount(e) {
//    /////Character
//    $('#spn_desc').html('' + 'Total Char : ' + $('#txtcourse_description').val().length);

//    if (e.keyCode != 8) {
//        if ($('#txtcourse_description').val().length >= 1380) {
//            bootbox.alert('You Exceeds the Character Limit');
//            return false;
//        }
//    }

/////Word
//var keyCode = e.which ? e.which : e.keyCode;
//var desc = $('#txtcourse_description').val();
//desc = desc.replace(/\s+/g, ' ');

//if (keyCode == 32) {
//    $('#spn_desc').html('' + 'Total Word : ' + ((desc.match(/ /g) || []).length + 1));
//}
//else {
//    $('#spn_desc').html('' + 'Total Word : ' + (desc.match(/ /g) || []).length);
//}

//if ((desc.match(/ /g) || []).length >= 100) {
//    bootbox.alert('You Exceeds the Word Limit');
//    return false;
//}
//}

function timerIncrement() {
    idleTime = idleTime + 1;

    if (idleTime == 10) { // 10 minutes
        //window.location.reload();
    }
}

//function tutor_charcount(e) {
//    $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].innerHTML = 'Total Char :' + (e.currentTarget.value.length + 1);
//}

//function keydown_tutor_removechar(e) {
//    if (e.keyCode == 8) {
//        $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].innerHTML = 'Total Char :' + (e.currentTarget.value.length - 1);
//    }
//}

//function tutor_charcount(e) {

//    if (e.currentTarget.value.length != 400) {
//        $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].innerHTML = 'Total Char : ' + (400 - (e.currentTarget.value.length + 1));

//        if ((400 - (e.currentTarget.value.length + 1)) == 0) {

//            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "red";
//        } else {
//            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "black";
//        }
//    } else {
//        bootbox.alert('You Exceeds the Character Limit');
//    }
//}

//function keydown_tutor_removechar(e) {
//    if (e.keyCode == 8) {
//        $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].innerHTML = 'Total Char : ' + (400 - (e.currentTarget.value.length - 1));
//        if ((400 - (e.currentTarget.value.length - 1)) == 0) {

//            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "red";
//        } else {
//            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "black";
//        }
//    }
//}

function tutor_charcount(e) {
    if (e.currentTarget.value.length != 400) {
        //var char_len = 400 - (e.currentTarget.value.length + 1);
        var char_len = (e.currentTarget.value.length + 1);
        var char_red = false;

        //if (char_len < 0) {
        //    char_len = -(char_len);
        //    char_red = true;
        //}

        if (char_len > 400) {
            char_len = -(char_len);
            char_red = true;
        }

        $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].innerHTML = 'Total Char : ' + (char_len);
        //if ((400 - (e.currentTarget.value.length + 1)) == 0) {
        if ((e.currentTarget.value.length + 1) > 400) {
            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "red";
        } else {
            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "black";
        }
        if (char_red) $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "red";
    } else {
        bootbox.alert('You Exceeds the Character Limit');
    }
}

function keydown_tutor_removechar(e) {

    //var char_len = 400 - (e.currentTarget.value.length - 1);
    var char_len = (e.currentTarget.value.length - 1);
    var char_red = false;

   // if (char_len < 0) {
    if (char_len > 400) {
        char_len = -(char_len);
        char_red = true;
    }

    if (e.keyCode == 8) {
        $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].innerHTML = 'Total Char : ' + (char_len);
        //if ((400 - (e.currentTarget.value.length - 1)) == 0) {
        if ((e.currentTarget.value.length + 1) > 400) {
            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "red";
        } else {
            $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "black";
        }
        if (char_red) $("#profile_desc").find("span[data-bind_row_no='" + e.currentTarget.dataset["bind_row_no"] + "']")[1].style.color = "red";
    }
}

//06112020-Kapil
function append_tutor_value(e) {
    var k = 0;
    var tutor = e.value;
    if ($('#tblinstructor tr').length > 3) {
        for (var j = 2; j < $('#tblinstructor tr').length; j++) {
            var value = $('#tblinstructor tr').eq(j).closest('tr').find('.cls_drp_tutor').val();
            if ('T' == value) {
                k = k + 1;
                if (k == 2) {
                    bootbox.alert('Already Lead Tutor Define. First make Lead Tutor to Co-Tutor, Then define Lead Tutor.');
                    //$('#tblinstructor #' + e.id + '.cls_drp_tutor').val("CT");
                    $(e)[0].value = "CT";
                    return false;
                }
            }
        }
    }
}

$(document).ready(function () {

    window.temp_week_typology = 16;
    window.calling_funcation = true;
    $(window).on('load', function () {
        window.calling_funcation = false;
    });
    $('#drcourses').empty().append($("<option></option>").val("").html("-- No Data Found --"));
    CKEDITOR.replace('txtcourse_structure', { width: '770px' });
    CKEDITOR.replace('txt_reference', { width: '770px' });
    if ($("#hdn_utype").val() == 'A1' || $("#hdn_utype").val() == 'FA') {
        $("#course_select").css('display', 'block');
    }
    //04032022
    function bind_tobelater_inst() {
        var studio_code = '';
        if ($('#hdn_c').val() != '') {
            studio_code = $('#hdn_c').val();
        }
       
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_TobeDecided_int",
            async: false,
            data: "{studio_code :'" + studio_code + "',sem_code :'" + $('#hdn_s').val() + "',year_code :'" + $('#hdn_y').val() + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    to_be_later_inst = JSON.parse(data.d);

                }
                else {
                    to_be_later_inst = "";

                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }

    function course_wise_ta() {
        var studio_code = '';
        var sem_code = '';
        var year_code = '';
        if ($('#hdn_c').val() != '')
        {
            studio_code = $('#hdn_c').val();
            sem_code = $('#hdn_s').val();
            year_code = $('#hdn_y').val();
        }
        else if ($('#drcourses').val() != '')
        {
            studio_code = $('#drcourses').val();
            sem_code = $('#drpsemester').val();
            year_code = $('#drpyear').val();
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_Studio_wise_ta",
            async: false,
            data: "{studio_code :'" + studio_code + "',sem_code :'" + sem_code + "',year_code :'" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    course_wise_ta = JSON.parse(data.d);


                    if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW')
                    {
                        
                        TA_instructor = "<select onchange='append_ta_tutor_hrs(this)' style='width:100%' class='drpinstructor_tutorial' disabled><option value=''>&lt; Select Instructor &gt;</option>";
                    }
                    else
                    {
                        TA_instructor = "<select onchange='append_ta_tutor_hrs(this)' style='width:100%' class='drpinstructor_tutorial'>";
                    }

                    for (var i = 0; i < course_wise_ta.length; i++)
                    {
                        TA_instructor = TA_instructor + "<option value =" + course_wise_ta[i]["user_id"] + ">" + course_wise_ta[i]["instructor_name"] + " </option>";
                    }
                    TA_instructor = TA_instructor + "</select>";




                }
                else {
                    course_wise_ta = "";

                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }


    bind_tobelater_inst();//04032022
    course_wise_ta();
    bindinstructor();
    bindsemesterdata();
    bindarea();
    binddepartment();
    bindtype();
    //bintypology();
    bindgpanongpa();
    bindprogrammedata();
    bindsemdata();
    bindyeardata_for_cross_reg();
    bindday(0);
    bindproglevel();
    bindcolor();
    getallcourse();
    getstudio_text_description_dtl();//03032022
    getstudio_dtl_with_no_of_tutor();//04032022

    var text_max = 0;//1380
    var text_word = 0;
    var text_max_ps = 0;//400 Mayur 12092019

    $('#spn_desc').html('' + 'Total Char : ' + text_max);
    $('#word_desc').html('' + 'Total Word : ' + text_word);
    $('#spn_long_word').html('' + 'Total Word : ' + text_word);
    $('#spn_ps').html('' + 'Total Char : ' + text_max_ps);
    
    $("#studio_mode").change(function () {
        if ($("#studio_mode").val() == "Partial On-Campus") {
            $(".POC").css('display', '');
        } else {
            $(".POC").css('display', 'none');
        }
    });

    $('#txtcourse_description').keyup(function () {
        var text_length = $('#txtcourse_description').val().length;
        var text_remaining = text_max + text_length;
        var words = $('#txtcourse_description').val().split(' ');
        var words_remaining = text_word + words.length;
        if (text_remaining > 2000) {
            $('#spn_desc').html('' + 'Total Char : ' + text_remaining);
            $('#spn_desc').css('color', 'red');
            //bootbox.alert('You Exceeds the Character Limit');
        } else {
            $('#spn_desc').html('' + 'Total Char : ' + text_remaining);
            $('#spn_desc').css('color', 'black');
        }

        //06042022 word_desc
        //changes 28112023
        if (words_remaining > 200) {
            $('#word_desc').html('' + 'Total Word : ' + words_remaining);
            $('#word_desc').css('color', 'red');
        }
        else {
            $('#word_desc').html('' + 'Total Word : ' + words_remaining);
            $('#word_desc').css('color', 'black');
        }

    });

    $('#txtcourse_studiosubtitle').keyup(function () {

        var text_length = $('#txtcourse_studiosubtitle').val().length;
        var text_remaining = text_max + text_length;
        var words = $('#txtcourse_studiosubtitle').val().split(' ');
        var words_remaining = text_word + words.length;
        if (text_remaining > 700) {
            $('#spn_desc1').html('' + 'Total Char : ' + text_remaining);
            $('#spn_desc1').css('color', 'red');
        } else {
            $('#spn_desc1').html('' + 'Total Char : ' + text_remaining);
            $('#spn_desc1').css('color', 'black');
        }

        if (words_remaining > 100) {
            $('#word_desc1').html('' + 'Total Word : ' + words_remaining);
            $('#word_desc1').css('color', 'red');
        }
        else {
            $('#word_desc1').html('' + 'Total Word : ' + words_remaining);
            $('#word_desc1').css('color', 'black');
        }


    });


    $('#txtcourse_outline').keyup(function () {
        var text_length = $('#txtcourse_outline').val().length;
        var text_remaining = text_max + text_length;
        var words = $('#txtcourse_outline').val().split(' ');
        var words_remaining = text_word + words.length;
        if (text_remaining > 3000) {
            $('#spn_long_desc').html('' + 'Total Char : ' + text_remaining);
            $('#spn_long_desc').css('color', 'red');
            //bootbox.alert('You Exceeds the Character Limit');
        } else {
            $('#spn_long_desc').html('' + 'Total Char : ' + text_remaining);
            $('#spn_long_desc').css('color', 'black');
        }

        //06042022 word_desc

        if (words_remaining > 600) {
            $('#spn_long_word').html('' + 'Total Word : ' + words_remaining);
            $('#spn_long_word').css('color', 'red');
        }
        else {
            $('#spn_long_word').html('' + 'Total Word : ' + words_remaining);
            $('#spn_long_word').css('color', 'black');
        }

    });

    $('#problem_statement').keyup(function () {
        var text_length = $('#problem_statement').val().length;
        var text_remaining = text_max_ps + text_length;
        if (text_remaining > 400) {
            $('#spn_ps').html('' + 'Total Char : ' + text_remaining);
            $('#spn_ps').css('color', 'red');
            //bootbox.alert('You Exceeds the Character Limit');
        } else {
            $('#spn_ps').html('' + 'Total Char : ' + text_remaining);
            $('#spn_ps').css('color', 'black');
        }

    });

    $('#drptypology').empty().append($("<option></option>").val("").html("-- Please Select Typology --"));
    
    //if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'PC') {
    if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
        //$("#div_txtcoursecode").css('display', 'none');
        $("#txtcoursecode").attr('disabled', 'disabled');
        $("#txtcoursename").attr('disabled', 'disabled');
        $("#txtavailable_seats").attr('disabled', 'disabled');
        $("#txtcredits").attr('disabled', 'disabled');
        $("#drpdepartment").attr('disabled', 'disabled');
        $("#drptype").attr('disabled', 'disabled');
        $("#drpproglevel").attr('disabled', 'disabled');
        $("#drp_semester").attr('disabled', 'disabled');
        $("#drpprog").attr('disabled', 'disabled');
        $("#drptypology").attr('disabled', 'disabled');
        $("#drpsubtypology").attr('disabled', 'disabled');
        $('#drp_typology_group').attr('disabled', 'disabled');
        $('#btn_instructor').attr('disabled', 'disabled');
        $('#btn_instructor_tutorial').attr('disabled', 'disabled');
        $('#btn_instructor_aa').attr('disabled', 'disabled');
        $('#btn_instructor_ta').attr('disabled', 'disabled');
        $('#btn_area').attr('disabled', 'disabled');
        // $('#btn_time').attr('disabled', 'disabled');
        $('#btn_time_tutorial').attr('disabled', 'disabled');
        $("#drp_color").attr('disabled', 'disabled');
        $("#drpproject").attr('disabled', 'disabled');
        $("#txt_project_name").attr('disabled', 'disabled');
        $("#txtroomid").attr('disabled', 'disabled');
        $("#drp_gpa_ngpa").attr('disabled', 'disabled');
        $('input[type=radio][name=rdo_backlog]').attr('disabled', 'disabled');
        $('input[type=radio][name=rdo_select_studio_type]').attr('disabled', 'disabled');
        $('input[type=radio][name=rdo_select_type_ta]').attr('disabled', 'disabled');
        $('input[type=radio][name=rdo_select_type]').attr('disabled', 'disabled');

        //$('#txtcourse_description').attr('disabled', 'disabled');
        //$('#txtcourse_prerequisite').attr('disabled', 'disabled');
        //$('#txt_evalmethod').attr('disabled', 'disabled');
        $('#txt_prep_self_hrs').attr('disabled', 'disabled');

        $("#div_facultynote").css('display', 'block');
        $('.color-blue').css('color', '#6FB9E1');

        $('.cls_mendatory_instructor').css('display', 'inline-block');

        if ($("#hdn_utype").val() == 'CW') {
            $("#txtavailable_seats").attr('disabled', 'disabled');
            $('#txtcourse_prerequisite').attr('disabled', 'disabled');

            $('#txtavailable_seats,#txtcourse_prerequisite').parent().prev().css('color', 'black');
            $('#txtavailable_seats,#txtcourse_prerequisite').parent().prev().children().css('display', 'none');

            $('#course_select').css('display', 'block');
            $('#div_drpsem').css('display', 'none');
            $('#div_drpyear').css('display', 'none');

            $('input[name=rdo_outline]')[0].disabled = true;
            $('input[name=rdo_outline]')[1].disabled = true;
            $('#chk_week_ref').attr('disabled', 'disabled');

            setCurrentSemester();
        }
    }
    else if ($("#hdn_utype").val() == 'A1') {
        //$("#div_txtcoursecode").css('display', 'block');
        $('.cls_mendatory').css('display', 'inline-block');
    }
    else if ($("#hdn_utype").val() == 'PC') {
        //$("#div_txtcoursecode").css('display', 'none');
        //$("#txtcoursecode").attr('disabled', 'disabled');
        if (studio_course_or_not == true) {

            $("#txtavailable_seats").attr('disabled', 'disabled');
            $("#txtcredits").attr('disabled', 'disabled');
            $("#drpdepartment").attr('disabled', 'disabled');
            $("#drpproglevel").attr('disabled', 'disabled');
            $("#drpprog").attr('disabled', 'disabled');
            $("#drptypology").attr('disabled', 'disabled');
            $("#drpsubtypology").attr('disabled', 'disabled');
            $('#drp_typology_group').attr('disabled', 'disabled');
            $("#tbltimeday tr td input").attr('disabled', 'disabled');
            $("#tblinstructor_time_slot tr td input").attr('disabled', 'disabled');
            // This Add Day and Time Section Day dropdown and delete Button Disabled By NitinBhai 15062023       
            //$('.drpday').attr('disabled', 'disabled')
            //$("#tbltimeday tr td center i").css('display', 'none')
            $("#tblinstructor_ta tr td center i").css('display', 'none')



        }
        $('.cls_mendatory').css('display', 'inline-block');
    }
    else if ($("#hdn_utype").val() == 'FA') {
        //$("#div_txtcoursecode").css('display', 'none');
        //$("#txtcoursecode").attr('disabled', 'disabled');
        if (studio_course_or_not == true) {

            $("#txtavailable_seats").attr('disabled', 'disabled');
            $("#txtcredits").attr('disabled', 'disabled');
            $("#drpdepartment").attr('disabled', 'disabled');

            $("#drpproglevel").attr('disabled', 'disabled');
            $("#drpprog").attr('disabled', 'disabled');
            $("#drptypology").attr('disabled', 'disabled');
            $("#drpsubtypology").attr('disabled', 'disabled');
            $('#drp_typology_group').attr('disabled', 'disabled');
            $("#tbltimeday tr td input").attr('disabled', 'disabled');
            $("#tblinstructor_time_slot tr td input").attr('disabled', 'disabled');
            //$('.drpday').attr('disabled', 'disabled')
            //$("#tbltimeday tr td center i").css('display', 'none')
            $("#tblinstructor_ta tr td center i").css('display', 'none')



        }

        $('.cls_mendatory').css('display', 'inline-block');
    }
   
    if ($("#hdn_utype").val() == 'CW') {
        $('#div_chk_prerequisite input[type=checkbox]').attr('disabled', 'disabled');
    }

    $('#drpprog').on('change', function () {
        if (btn_ret_new_flag == false) {
             bind_program_level_code();
        }
       
        bindweek(); //Mayur 30042019
        BindCourseTimetable(); //21052022
        //if ($("#drpprog").val() == '2' || $("#drpprog").val() == '3') {
        //    $("#spn_proglvl").css('display', 'block');
        //    $("#drpproglevel_chzn").css('display', 'block');
        //}
        //else {
        //    $("#spn_proglvl").css('display', 'none');
        //    $("#drpproglevel_chzn").css('display', 'none');
        //    $("#drpproglevel").val('');
        //    $("#drpproglevel").trigger("liszt:updated");
        //}
    });

    $('#drpprog,#drpproglevel,#drp_semester,#drptypology').on('change', function (e) {
        var id_get_drodown = e.target.id;
        count = count + 1;
        console.log(count);
        if (!prog_name_flag) {
            var value = '';

            if ($('#drpprog').val() == "1") {
                value = 'UG';
            }
            else if ($('#drpprog').val() == "2") {
                value = 'PG';
            }

            if ($('#drpproglevel').val() != '') {
                value += ' - ' + $('#drpproglevel option:selected').text();
            }
            if ($('#drptypology').val() != '') {
                value += ' - ' + $('#drptypology option:selected').text();
            }

            if ($('#drp_semester').val() != '') {
                value += ' - ' + $('#drp_semester').val();
            }

            $('#txt_project_name').val(value);

            if ($("#drptypology").val() != '') {
                if (id_get_drodown != 'drp_semester')
                { bindsubgrouptypology(); }
                
            }
        }

        prog_name_flag = false;

        if (this.id == "drp_semester" || this.id == "drpprog" || this.id == "drpproglevel") {
            //bind_group_wise_typology();

            if (this.id == "drp_semester") {
                if ($('#drp_semester').val() == '1') {
                    //$('#drp_typology_group').val('new');
                    $('#drp_typology_group').val('G003');
                    $('#drp_typology_group').attr('disabled', 'disabled');
                    $('#drp_typology_group').change();
                }
                else {
                   if (id_get_drodown != 'drp_semester') {
                     $('#drp_typology_group').val(''); //17082022
                   }
                    
                    $('#drp_typology_group').attr('disabled', false);
                    if ($("#hdn_utype").val() == 'I2') {
                        $('#drp_typology_group').attr('disabled', 'disabled');
                    }
                    if (id_get_drodown != 'drp_semester')
                    {
                      $('#drp_typology_group').change(); //17082022
                    }
                   
                }
                //}

                if (temp_typology != '') {
                    //var temp_old = jQuery.grep(old_typology, function (data) { return data.type_code === temp_typology });
                    //if (temp_old.length > 0) {
                    //    //$('#drp_typology_group').val('old');
                    //    $('#drp_typology_group').val('G001');
                    //    $('#drp_typology_group').change();
                    //}
                    //else {
                    //    var temp_new = jQuery.grep(new_typology, function (data) { return data.type_code === temp_typology });
                    //    if (temp_new.length > 0) {
                    //        //$('#drp_typology_group').val('new');
                    //        $('#drp_typology_group').val('G002');
                    //        $('#drp_typology_group').change();
                    //    }
                    //}

                    for (var i = 0; i < obj_typology_group.length; i++) {
                        var temp_typo = jQuery.grep(obj_typology[obj_typology_group[i]['group_id']], function (data) { return data.type_code === temp_typology });

                        if (temp_typo.length > 0) {

                            $('#drp_typology_group').val(obj_typology_group[i]['group_id']);
                            $('#drp_typology_group').change();
                            break;
                        }
                    }
                }
            }
        }
        if (id_get_drodown != 'drp_semester') {
          BindCourseTimetable();
          append_tutor_image_2();
        }
        
        
    });

    $('#drpdepartment').on('change', function () {
        if (btn_ret_new_flag == false) {
            bind_program_level_code();
        }
        bindweek(); //Mayur 30042019
        //bind_group_wise_typology();
    });

    $('#drptype').on('change', function () {
        if ($("#drptype").val() == 'M') {
            $("#spn_project,#drpproject").css('display', 'inline-block');
            // $('#drpproject').val('0');
            //$(".gpa_nongpa").css("display", "none");
            //$("#drp_gpa_ngpa").val('G');
        }
        else {
            $("#spn_project,#drpproject").css('display', 'none');
            $("#spn_project_name,#txt_project_name").css('display', 'none');
            $('#drpproject').val('N');
            //$(".gpa_nongpa").css("display", "");
        }
    });

    $('#drpproject').on('change', function () {
        if ($("#drpproject").val() == 'Y') {
            $("#spn_project_name,#txt_project_name").css('display', 'inline-block');

            var value = '';

            if ($('#drpprog').val() == "1") {
                value = 'UG';
            }
            else if ($('#drpprog').val() == "2") {
                value = 'PG';
            }

            if ($('#drpproglevel').val() != '') {
                value += ' - ' + $('#drpproglevel option:selected').text();
            }
            if ($('#drptypology').val() != '') {
                value += ' - ' + $('#drptypology option:selected').text();
            }

            if ($('#drp_semester').val() != '') {
                value += ' - ' + $('#drp_semester').val();
            }

            $('#txt_project_name').val(value);

        }
        else {
            $("#spn_project_name,#txt_project_name").css('display', 'none');
        }
    });

    $('#drpsemester').on('change', function () {
        if ($('#drpsemester').val() != '') {
            if ($('#drpyear').val() != '') {
                bind_sem_course();
            }
        }
    });

    $('#chk_pre10').on('click', function () {
        if (this.checked) {
            $('#txtcourse_prerequisite').css('display', 'block');
        }
        else {
            $('#txtcourse_prerequisite').css('display', 'none');
        }
    });

    $('#chk_pre11').on('click', function () {
        if (this.checked) {
            $('#divPreCourseCode').css('display', 'inline-block');
        }
        else {
            $('#divPreCourseCode').css('display', 'none');
        }
    });

    $('.cls_week_ref').css('margin-left', '15px');
    $('.cls_week_assign').css('margin-left', '15px');

    $('#div_weekly_plan').css('display', 'none');
    $('#div_course_structure').css('display', 'block');

    $('input[name=rdo_outline]')[0].checked = true;
    $('#spn_chkbox').css('display', 'none');

    $('#div_assign_title').css('display', 'none');
    $('.cls_week_assign').css('display', 'none');

    $('input[name=rdo_outline]:radio').on('change', function () {
        if ($('input[name=rdo_outline]:checked').val() == 'weekly') {
            $('#div_weekly_plan').css('display', 'block');
            $('#div_course_structure').css('display', 'none');
            $('#spn_chkbox').css('display', 'inline-block');
            $('.l2l3_star_show_conso_outline').css('display', 'none');
        }
        else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
            $('#div_weekly_plan').css('display', 'none');
            $('#div_course_structure').css('display', 'block');
            $('#spn_chkbox').css('display', 'none');
            $('.l2l3_star_show_conso_outline').css('display', '');
        }
    });

    $('#chk_week_ref').on('change', function () {
        $('#div_week_title').css('display', 'block');
        $('#div_ref_title').css('display', 'block');
        $('#div_assign_title').css('display', 'block');

        if ($('#chk_week_ref')[0].checked) {
            $('.cls_week_ref').css('display', 'inline-block');

            if ($('#chk_week_ref')[0].checked && $('#chk_week_assign')[0].checked) {
                $('#div_weekly_plan .txtwidth').css('width', '27%');
            }
            else if (!$('#chk_week_assign')[0].checked) {
                $('#div_assign_title').css('display', 'none');

                //$('.divweek').removeClass('col-md-6');
                //$('.divweek').addClass('col-md-12');
                //$('#div_weekly_plan .txtwidth').css('width', '40%');
            }
        }
        else if (!$('#chk_week_ref')[0].checked) {
            $('.cls_week_ref').css('display', 'none');
            $('#div_ref_title').css('display', 'none');

            if (!$('#chk_week_ref')[0].checked && !$('#chk_week_assign')[0].checked) {
                $('#div_week_title').css('display', 'none');

                //$('.divweek').removeClass('col-md-12');
                //$('.divweek').addClass('col-md-6');
                //$('#div_weekly_plan .txtwidth').css('width', '80%');
            }
            else if ($('#chk_week_assign')[0].checked) {
                $('#div_weekly_plan .txtwidth').css('width', '40%');
            }
        }
    });
    //$('#chk_week_assign').on('change', function () {
    //    $('#div_week_title').css('display', 'block');
    //    $('#div_ref_title').css('display', 'block');
    //    $('#div_assign_title').css('display', 'block');

    //    if ($('#chk_week_assign')[0].checked) {
    //        $('.cls_week_assign').css('display', 'inline-block');

    //        if ($('#chk_week_ref')[0].checked && $('#chk_week_assign')[0].checked) {
    //            $('#div_weekly_plan .txtwidth').css('width', '27%');
    //        }
    //        else if (!$('#chk_week_ref')[0].checked) {
    //            $('#div_ref_title').css('display', 'none');

    //            $('.divweek').removeClass('col-md-6');
    //            $('.divweek').addClass('col-md-12');
    //            $('#div_weekly_plan .txtwidth').css('width', '40%');
    //        }
    //    }
    //    else if (!$('#chk_week_assign')[0].checked) {
    //        $('.cls_week_assign').css('display', 'none');
    //        $('#div_assign_title').css('display', 'none');

    //        if (!$('#chk_week_ref')[0].checked && !$('#chk_week_assign')[0].checked) {
    //            $('#div_week_title').css('display', 'none');

    //            $('.divweek').removeClass('col-md-12');
    //            $('.divweek').addClass('col-md-6');
    //            $('#div_weekly_plan .txtwidth').css('width', '80%');
    //        }
    //        else if ($('#chk_week_ref')[0].checked) {
    //            $('#div_weekly_plan .txtwidth').css('width', '40%');
    //        }
    //    }
    //});

    //$('#drptypology').on('change', function () {
    //     
    //    if ($("#drptypology").val() != '') {
    //        bindsubgrouptypology();
    //    }
    //});


    function bindsubgrouptypology() {

        var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });
        var sub_group_id = temp_selected_typology[0]['sub_group'];

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_sub_group_typology_data",
            data: "{sub_group_id : '" + sub_group_id + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var sub_typology_data = JSON.parse(data.d);

                    $('#drpsubtypology').empty().append($("<option></option>").val("").html("-- Please Select --"));

                    for (var i = 0; i < sub_typology_data.length; i++) {
                        $('#drpsubtypology').append($("<option></option>").val(sub_typology_data[i]["sub_category_id"]).html(sub_typology_data[i]["sub_category_desc"]));
                    }

                    $('#drpsubtypology').val(temp_sub_group_typology);
                    $('#typ_sub_group').css("display", "block");
                    $('#drpsubtypology').css("display", "block");
                    $('.studioprobstmnt').css("display", "none");
                    //$('.cls_studio_mode').css("display", "");

                    if (temp_sub_group_typology == "L2") {
                        $('#drpsubtypology').change();
                        $('#drpsubtypology').trigger("liszt:updated");
                    }
                    if (temp_sub_group_typology == "L3" && $("#drpproglevel").val() == "UD2") {
                        $('#drpsubtypology').change();
                        $('#drpsubtypology').trigger("liszt:updated");
                    }

                    if (temp_sub_group_typology == 1) {
                        $('.l2l3').css('display', 'none');
                        $('.l2l3_star_show').css('display', 'none');
                       // $('.l2l3_hide').css('display', '');
                        $('.l2l3_hide').show();
                    } else {
                        $('.l2l3').css('display', '');
                        $('.l2l3_star_show').css('display', '');
                        //$('.l2l3_hide').css('display', 'none');
                        $('.l2l3_hide').show();
                    }

                    //07102021
                    if ($('#drptypology').val() == '23') {
                        $('#weekly_excerises').css("display", "block");

                    }
                    //07102021
                    if ($('#drptypology').val() == '28') {
                        $('#weekly_excerises').css("display", "block");

                    }
                }
                else {
                    $('#drpsubtypology').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                    temp_sub_group_typology = "";
                    $('#typ_sub_group').css("display", "none");
                    $('#drpsubtypology').css("display", "none");
                    $('.studioprobstmnt').css("display", "none");

                    $('#weekly_excerises').css("display", "none");//07102021
                    $('#lbl_excercises_file_name').text('');//07102021
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }


    $('#drp_typology_group').on('change', function () {

        $('#drptypology').html('<option value="">-- Please Select Typology --</option>');

        ////if ($('#drp_typology_group').val() == 'old') {
        //if ($('#drp_typology_group').val() == 'G001') {
        //    typology_detail = old_typology;
        //    for (var i = 0; i < old_typology.length; i++) {
        //        $('#drptypology').append('<option value="' + old_typology[i]['type_code'].toString() + '">' + old_typology[i]['type_name'].toString() + '</option>');
        //    }
        //}
        ////else if ($('#drp_typology_group').val() == 'new') {
        //else if ($('#drp_typology_group').val() == 'G002') {
        //    typology_detail = new_typology;
        //    for (var i = 0; i < new_typology.length; i++) {
        //        $('#drptypology').append('<option value="' + new_typology[i]['type_code'].toString() + '">' + new_typology[i]['type_name'].toString() + '</option>');
        //    }
        //}

        typology_detail = obj_typology[$('#drp_typology_group').val()];
        if ($('#drp_typology_group').val() != '') {
            for (var i = 0; i < obj_typology[$('#drp_typology_group').val()].length; i++) {
                $('#drptypology').append('<option value="' + obj_typology[$('#drp_typology_group').val()][i]['type_code'].toString() + '">' + obj_typology[$('#drp_typology_group').val()][i]['type_name'].toString() + '</option>');
            }
        }

        if (temp_typology != '' && $('#drptypology').children().length > 1) {

            $('#drptypology').val(temp_typology);
            $('#drptypology').change();
            $('#drptypology').trigger("liszt:updated");

            $('#drpsubtypology').val(temp_sub_group_typology);
            $('#drpsubtypology').change();
            $('#drpsubtypology').trigger("liszt:updated");

            temp_typology = '';
        }

        if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
            $('#drptypology').chosen();
            $('#drptypology').trigger("liszt:updated");
        }

        if ($('#drp_typology_group').val() != "" && $('#drptypology').val() != "") {

            var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

            if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] != 'SG003') {
                //$("#studio_mode").val("");
                $(".POC").css("display", "none");
                //$(".cls_studio_mode").css("display", "none");
            }

        }

        bindweek(); //Mayur 30042019
        set_tutorial_dtl();
    });

    $('#drpproglevel').on('change', function () {
        bindweek(); //Mayur 30042019
    });

    $('#drptypology').on('change', function () {
        $('.l2l3').css('display', '');// If change 
        if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4') {
            $('#div_weekly_plan').css('display', 'block');
            $('#div_course_structure').css('display', 'none');

            $('input[name=rdo_outline]')[1].checked = true;
            $('input[name=rdo_outline]')[0].disabled = true;
            $('#spn_chkbox').css('display', 'inline-block');
        }
        else {
            $('input[name=rdo_outline]')[0].disabled = false;
        }

        if ($('#drp_typology_group').val() != '' && $('#drptypology').val() != '') {
            var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

            if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003') {
                $('.l2l3_studio_hide').css('display', 'none');
                $('input[name=rdo_outline]')[1].checked = true;
                $('input[name=rdo_outline]').trigger('change');
                //$('.l2l3_star_show_conso_outline').css('display', 'none');
            } else {
                $('.l2l3_studio_hide').css('display', '');
                //07112020-Kapil
                $('.cls_focus_studio').css('display', 'none');
                $('.cls_focus_studio_options').css('display', 'none');
                //$('.l2l3_star_show_conso_outline').css('display', '');
            }
        }
        var year = parseInt($('#drpyear').val());
        var sem = $('#drpsemester').val()
        // for Spring 2019 and before
        if (year <= 2019) {

            if (sem == "S" || year <= 2019 && sem == "S" || year < 2019 && sem == "M") {
                if ($('#drptypology').val() == '24') {
                    //$('#txt_week13').closest('.row').css('display', 'none');
                    window.temp_week_typology = 12;
                }
                else {
                    //$('#txt_week13').closest('.row').css('display', 'block');
                    window.temp_week_typology = 16;
                }

                weeks = parseInt(window.temp_week_typology) + 1; //Mayur 03052019 Put Variable instead of 12

                for (var i = 1; i < weeks; i++) {
                    $('.week' + i).css('display', 'block');
                }

                for (var i = weeks; i <= 16; i++) {
                    $('.week' + i).css('display', 'none');
                }
            }
        }

        if ($('#drp_typology_group').val() != "" && $('#drptypology').val() != "") {

            var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

            if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] != 'SG003') {
                //$("#studio_mode").val("");
                $(".POC").css("display", "none");
                //$(".cls_studio_mode").css("display", "none");
            }

        }

        bindweek(); //Mayur 30042019
        set_tutorial_dtl();
        create_str_room();
        //19052022
        if ($('#drptypology').val() == '23')
        {
            $('#single_show').css('display', 'none');
            $('#dual_show').css('display', 'none');
            $('#course_panel_show').css('display', 'none');
            $('#studio_panel_showing').css('display', 'block');
            $('#course_text').css('display', 'none');
            $('#studio_text').css('display', 'block');


            $('#rdo_ta').prop('checked', true);
            $('#rdo_t').prop('checked', false);
            $('#rdo_ta_y').prop('checked', false);
            $('#rdo_ta_n').prop('checked', true);
            $("#studio_type_select").show();
            $("#tutor_type_select").hide();
            $("#tutor_type_select_ta").hide();
             appendtimeslotdtl();
            $('.txt_change_course').text('(70% Internal, 30% Portfolio for all programs)');

        }
        else if ($('#drptypology').val() == '24')
        {
            $('#single_show').css('display', 'none');
            $('#dual_show').css('display', 'none');
            $('#course_panel_show').css('display', 'block');
            $('#studio_panel_showing').css('display', 'none');
            $('#course_text').css('display', 'block');
            $('#studio_text').css('display', 'none');


            $('#rdo_s').prop('checked', false);
            $('#rdo_d').prop('checked', false);
            //nitinbhai 20112024
            if (parseInt($('#drpyear').val()) >= 2025) {
                $("#tutor_type_select").hide();
            }
            else { $("#tutor_type_select").show();}
            
            $("#tutor_type_select_ta").show();
            $("#studio_type_select").hide();
             appendtimeslotdtl();
            $('.txt_change_course').text('(100% for all programs (Mid Term + End Term)');

        }
        else {

            $('#single_show').css('display', 'none');
            $('#dual_show').css('display', 'none');
            $('#course_panel_show').css('display', 'none');
            $('#studio_panel_showing').css('display', 'none');
            $('#course_text').css('display', 'none');
            $('#studio_text').css('display', 'none');

            $('#rdo_s').prop('checked', false);
            $('#rdo_d').prop('checked', false);
            $('#rdo_ta').prop('checked', true);
            $('#rdo_t').prop('checked', false);
            $('#rdo_ta_y').prop('checked', false);
            $('#rdo_ta_n').prop('checked', true);
            $("#tutor_type_select_ta").hide();
            $("#tutor_type_select").hide();
            $("#studio_type_select").hide();
             appendtimeslotdtl();
            $('.txt_change_course').text('(70% Internal, 30% Portfolio for all programs)');

        }
        BindCourseTimetable();
        append_tutor_image_2();
    });

    function bindweek() {//Mayur 30042019
        //console.log('bindweek Loop');
        var status_week = false;
        var year = parseInt($('#drpyear').val());
        var sem = $('#drpsemester').val();
        // for Monsson 2019 and after
        if (year >= 2019) {
            if (sem == "M" || year >= 2019 && sem == "S") {//!=
                if (year != 2019 || sem == "M") {
                    var dept_code = $('#drpdepartment').val();
                    var prog_code = $('#drpprog').val();
                    var prog_level_code = $('#drpproglevel').val();
                    var group_id = $('#drp_typology_group').val();
                    var course_typology = $('#drptypology').val();

                    if (dept_code != "" && prog_code != "" && prog_level_code != "" && group_id != "" && course_typology != "") {
                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService.asmx/get_course_weeks_typology_wise",
                            data: "{dept_code : '" + dept_code + "', prog_code : '" + prog_code + "', prog_level_code : '" + prog_level_code + "', group_id : '" + group_id + "', course_typology : '" + course_typology + "'}",
                            dataType: "json",
                            success: function (data) {

                                if (data.d != "") {
                                    var weeks_data = JSON.parse(data.d)

                                    window.temp_week_typology = weeks_data[0]["weeks"];

                                    weeks = parseInt(window.temp_week_typology) + 1; //Mayur 03052019 Put Variable instead of 12

                                    for (var i = 1; i < weeks; i++) {
                                        $('.week' + i).css('display', 'block');
                                        status_week = true;
                                    }

                                    for (var i = weeks; i <= 16; i++) {
                                        $('.week' + i).css('display', 'none');
                                        status_week = false;
                                    }

                                    //07102021
                                    if ($('#drptypology').val() == '23' && status_week == true) {
                                        $('#weekly_excerises').css("display", "block");

                                    }
                                    else {
                                        $('#weekly_excerises').css("display", "none");
                                        $('#lbl_excercises_file_name').text('');
                                    }

                                }
                                else
                                {

                                    window.temp_week_typology = 0;
                                    for (var i = 1; i <= 16; i++)
                                    {
                                        $('.week' + i).css('display', 'none');
                                    }
                                    //07102021
                                    $('#weekly_excerises').css("display", "none");
                                    $('#lbl_excercises_file_name').text('');
                                }
                            }

                        });
                    }
                }
            }
        }
    }

    function bindfocusofstudio() {//Mayur 12092019

        var focus_studio_level = $('#drpsubtypology').val();
        var deptcode = $('#drpdepartment').val();
        var progcode = $('#drpproglevel').val();
        if (progcode == '') {
            alert("Please Select Program Type");
            return false;
        }
        if (focus_studio_level != "") {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_focus_of_studio",
                data: "{focus_studio_level : '" + focus_studio_level + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {
                        var str_data = "";
                        $('.cls_focus_studio_options').html("");
                        var focus_of_studio = JSON.parse(data.d);

                        if (progcode == 'UA' || progcode == 'UP2' || progcode == 'UD') {
                            var result = alasql('SELECT * FROM ? WHERE focus_area_code IN (?, ?, ?)', [focus_of_studio, 'VC', 'CS', 'PO']);
                            focus_of_studio = '';
                            focus_of_studio = result;
                        }

                        else if (progcode == 'UT') {
                            var result = alasql('SELECT * FROM ? WHERE focus_area_code IN (?, ?, ?)', [focus_of_studio, 'AD', 'CS', 'PO']);
                            focus_of_studio = '';
                            focus_of_studio = result;
                        }
                       else if (progcode == 'UD2') {
                            var result = alasql('SELECT * FROM ? WHERE focus_area_code IN (?, ?, ?, ?)', [focus_of_studio, 'MM', 'PP', 'SS', 'RP']);
                            focus_of_studio = '';
                            focus_of_studio = result;
                        }

                        str_data += '<div style="width: 921%;margin-left: 10px !important;">';
                        str_data += '<div style="width:60%;float:left;">Focus</div><div style="width:5%;float:left;text-align:center;">Primary</div><div style="width:5%;float:left;text-align:center; display:none;">Secondary</div>';
                        for (var i = 0; i < focus_of_studio.length; i++) {
                            //str_data += '<div style="width:610%;"><input type="radio" name="rdo_focus_studio" value="' + focus_of_studio[i]["focus_area_code"] + '" />&nbsp;' + focus_of_studio[i]["focus_area_name"] + '&nbsp;&nbsp;<span style="color:#00a1ff;">(' + focus_of_studio[i]["focus_area_desc"] + ')</span></div><br/>';
                            if (deptcode == '5' && (focus_of_studio[i]["focus_area_code"] == 'AD'))
                            {
                                str_data += '<div style="width:60%;float:left;text-align:justify;">' + focus_of_studio[i]["focus_area_name"] + ' &nbsp;&nbsp; <span style="color:#00a1ff;">(' + focus_of_studio[i]["focus_area_desc"] + ')</span></div><div style="width:5%;float:left;text-align:center;"><input type="radio" name="rdo_focus_studio" value="' + focus_of_studio[i]["focus_area_code"] + '" /></div><div style="width:5%;float:left;text-align:center;"><input type="radio" style="display:none" name="rdo_focus_studio_secondary" value="' + focus_of_studio[i]["focus_area_code"] + '" /></div>';
                            }
                            else if (focus_of_studio[i]["focus_area_code"] == 'AD')
                            {

                            }
                            else
                            {
                                if (deptcode == '5' && (focus_of_studio[i]["focus_area_code"] == 'VC')) {

                                }
                                else if (focus_of_studio[i]["focus_area_code"] == 'VC') {

                                    str_data += '<div style="width:60%;float:left;text-align:justify;">' + focus_of_studio[i]["focus_area_name"] + ' &nbsp;&nbsp; <span style="color:#00a1ff;">(' + focus_of_studio[i]["focus_area_desc"] + ')</span></div><div style="width:5%;float:left;text-align:center;"><input type="radio" name="rdo_focus_studio" value="' + focus_of_studio[i]["focus_area_code"] + '" /></div><div style="width:5%;float:left;text-align:center;"><input type="radio" name="rdo_focus_studio_secondary" style="display:none" value="' + focus_of_studio[i]["focus_area_code"] + '" /></div>';

                                }
                                else
                                {
                                    str_data += '<div style="width:60%;float:left;text-align:justify;">' + focus_of_studio[i]["focus_area_name"] + ' &nbsp;&nbsp; <span style="color:#00a1ff;">(' + focus_of_studio[i]["focus_area_desc"] + ')</span></div><div style="width:5%;float:left;text-align:center;"><input type="radio" name="rdo_focus_studio" value="' + focus_of_studio[i]["focus_area_code"] + '" /></div><div style="width:5%;float:left;text-align:center;"><input type="radio" name="rdo_focus_studio_secondary" style="display:none" value="' + focus_of_studio[i]["focus_area_code"] + '" /></div>';
                                }
                                
                            }


                            
                        }
                        str_data += '</div>';
                        $('.cls_focus_studio_options').append(str_data);
                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            $('input[type=radio][name=rdo_focus_studio]').attr('disabled', 'disabled');
                            $('input[type=radio][name=rdo_focus_studio_secondary]').attr('disabled', 'disabled');
                        }
                    } else {

                    }

                    if (temp_sub_group_typology == "L2") {
                        if (temp_focus_of_studio != null && temp_focus_of_studio != "")
                        {
                            if ($('input[type=radio][name=rdo_focus_studio][value=' + temp_focus_of_studio + ']')[0] != undefined)
                            {
                                $('input[type=radio][name=rdo_focus_studio][value=' + temp_focus_of_studio + ']')[0].checked = true;
                            }
                            
                        }
                        if (temp_focus_of_studio_secondary != null && temp_focus_of_studio_secondary != "") {
                            if ($('input[type=radio][name=rdo_focus_studio_secondary][value=' + temp_focus_of_studio_secondary + ']')[0] != undefined)
                            {
                                $('input[type=radio][name=rdo_focus_studio_secondary][value=' + temp_focus_of_studio_secondary + ']')[0].checked = true;
                            }
                            
                        }
                    }

                    if (temp_sub_group_typology == "L3" && $("#drpproglevel").val() == "UD2") {
                        if (temp_focus_of_studio != null && temp_focus_of_studio != "") {
                            if ($('input[type=radio][name=rdo_focus_studio][value=' + temp_focus_of_studio + ']')[0] != undefined) {
                                $('input[type=radio][name=rdo_focus_studio][value=' + temp_focus_of_studio + ']')[0].checked = true;
                            }

                        }
                        if (temp_focus_of_studio_secondary != null && temp_focus_of_studio_secondary != "") {
                            if ($('input[type=radio][name=rdo_focus_studio_secondary][value=' + temp_focus_of_studio_secondary + ']')[0] != undefined) {
                                $('input[type=radio][name=rdo_focus_studio_secondary][value=' + temp_focus_of_studio_secondary + ']')[0].checked = true;
                            }

                        }
                    }
                }

            });
        }
    }

    $('#drpyear').on('change', function () {
        if ($('#drpyear').val() != '') {

            if ($('#drpsemester').val() != '') {
                bind_sem_course();
            }

        }
    });

    $('#btn_instructor').on('click', function () {
        //04032022
        if ($('#no_of_tutor_bind').text() == "Dual")
        {
            //if ($('#tblinstructor tbody tr').length == 2)
            //{
            //    bootbox.alert("Maximum Two Instructor Add ");
            //    return false;
            //}
            //else if ($('#tblinstructor tbody tr').length > 2)
            //{
            //    bootbox.alert("Maximum Two Instructor Add ");
            //    return false;
            //}
        }
        if ($('#no_of_tutor_bind').text() == "Single") {
            if ($('#tblinstructor tbody tr').length == 1) {
                bootbox.alert("Maximum One Instructor Add ");
                return false;
            }
        }
        //changes 19052022

        if ($('#drptypology').val() == '23')
        {
            if ($('#rdo_s').prop("checked") == false && $('#rdo_d').prop("checked") == false) {
                bootbox.alert('Please Select Studio Type');
                return false;
            }
        }

        if ($('#tbltimeday tbody tr').length == 0) {
            bootbox.alert('Please Add Time and Day');
            return false;
        }


        //06112020
        //var str = "<tr data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td><td><select data-row_no='" + add_instructor_cnt + "' class='cls_drp_contact_hrs' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><input type='radio' class='cls_radio_tutor' name='rdo_tutor' value='" + add_instructor_cnt + "' /></td><td><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        //var str = "<tr data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td><td><select data-row_no='" + add_instructor_cnt + "' class='cls_drp_contact_hrs' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><input type='radio' class='cls_radio_tutor' name='rdo_tutor' value='" + add_instructor_cnt + "' /></td><td><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td><input type='button' value='View'  class ='but_click' /></td></tr>";// id='" + add_instructor_cnt + "' 11 05 2020
        var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td>";
        str += "<td><select  data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_contact_hrs' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td>";

        str += "<td><input id ='" + add_instructor_cnt + '_' + 'per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + add_instructor_cnt + ")' /></td>";
        str += "<td><input id ='" + add_instructor_cnt + '_' + 'week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + add_instructor_cnt + ")' /></td>";

        //str += "<td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td>";
        //str += "<td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td>";

        //new 28042022
        str += "<td><input id ='" + add_instructor_cnt + '_' + 'total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
        str += "<td><input id ='" + add_instructor_cnt + '_' + 'add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='6' onkeypress='return IsNumeric_istructor_in(event);' onInput='edValueKeyPress_new(" + add_instructor_cnt + ")' /></td>";
        str += "<td><input id ='" + add_instructor_cnt + '_' + 'add_hrs_new' + "' style='width: 30px;' type='text' class='add_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor_new(event);' disabled /></td>";
        //end


        str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td><td class='hig_" + add_instructor_cnt + "'></td><td class='toex_" + add_instructor_cnt + "'></td><td class='rate_" + add_instructor_cnt +"'></td>";
        str += "<td><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td><input type='button' value='View'  class ='but_click' /></td>";//id='" + add_instructor_cnt + "' 11 05 2020
        str += "<td></td></tr>";

        $('#tblinstructor tbody').append(str);
        add_instructor_cnt = add_instructor_cnt + 1;


        //semester wise changes 28042022
        if ($('#hdn_y').val() == '2022' && $('#hdn_sem').val() == 'M')
        {
            $(this).parent().parent().find('.cls_drp_contact_hrs').attr('disabled', 'disabled');
        }
        else if ($('#hdn_y').val() > parseInt('2022')) {
            $(this).parent().parent().find('.cls_drp_contact_hrs').attr('disabled', 'disabled');
        }



        $('.cls_drp_contact_hrs').on('change', function () {
            if ($(this).val() == "HW") {
                $(this).parent().parent().find('.week').prop('disabled', false);
            } else {
                $(this).parent().parent().find('.week').attr('disabled', 'disabled');
                $(this).parent().parent().find('.week').val('');
            }
        });

        //changes 17052022
        typology_wise_get_hrs();

        //$('.drpinstructor').chosen();
        //$('.chzn-drop').css({ "width": "140px" });
        return false;
    });

    $('#btn_instructor_tutorial').on('click', function () {
        var str = "<tr><td>" + instructor_tutorial + "</td><td><select class='cls_drp_contact_hrs_tutorial' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load_tutorial' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tblinstructor_tutorial tbody').append(str);
        return false;
    });

    $('#btn_instructor_aa').on('click', function () {
        var str = "<tr><td>" + instructor_tutorial + "</td>";

        str += "<td><input id ='" + add_aa_cnt + '_' + 'aa_per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_aa(" + add_aa_cnt + ")' /></td>";
        str += "<td><input id ='" + add_aa_cnt + '_' + 'aa_week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_aa(" + add_aa_cnt + ")' /></td>";
        //new 28042022
        str += "<td><input id ='" + add_aa_cnt + '_' + 'aa_total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
        str += "<td><input id ='" + add_aa_cnt + '_' + 'aa_add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='5' onkeypress='return IsNumeric_istructor(event);'  /></td>";
        str += "<td><input id ='" + add_aa_cnt + '_' + 'aa_hrs_new' + "' style='width: 30px;' type='text' class='aa_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled /></td>";
        str += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td></td></tr>";
        $('#tblinstructor_aa tbody').append(str);
        add_aa_cnt = add_aa_cnt + 1;
        return false;
    });

    $('#btn_instructor_ta').on('click', function () {
        //changes 17052022

        if (studio_course_or_not == true) {
            bootbox.alert("For Studio : Please Select TA From TA Application Page <a href='department_wise_ta_approved.aspx'>click</a>");
            return false;
        }
        if ($('#txtcredits').val() == '') {
            bootbox.alert('Please Enter Course Credits');
            return false;
        }

        if ($('#txtavailable_seats').val() == '') {
            bootbox.alert('Please Enter Intake Capacity');
            return false;
        }
        if ($('#drp_typology_group').val() == '') {
            bootbox.alert('Please Select Typology Group');
            return false;
        }
        if ($('#drptypology').val() == '') {
            bootbox.alert('Please Select Course Typology');
            return false;
        }
        if ($('#drptypology').val() == '23') {
            if ($('#rdo_s').prop("checked") == false && $('#rdo_d').prop("checked") == false) {
                bootbox.alert('Please Select Studio Type');
                return false;
            }
        }

        var str = "";
        if (course_wise_ta == "") {
            str = "<tr data-row_no ='" + add_ta_cnt + "'><td>" + instructor_tutorial + "</td>";
        }
        else
        {
            str = "<tr data-row_no ='" + add_ta_cnt + "'><td>" + TA_instructor + "</td>";
        }
        

        str += "<td><input id ='" + add_ta_cnt + '_' + 'ta_per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + add_ta_cnt + ")' /></td>";
        str += "<td><input id ='" + add_ta_cnt + '_' + 'ta_week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + add_ta_cnt + ")' /></td>";
        //new 28042022
        str += "<td><input id ='" + add_ta_cnt + '_' + 'ta_total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
        str += "<td><input id ='" + add_ta_cnt + '_' + 'ta_add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + add_ta_cnt + ")'/></td>";
        str += "<td><input id ='" + add_ta_cnt + '_' + 'ta_hrs_new' + "' style='width: 30px;' type='text' class='ta_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled /></td>";
        str += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td></td></tr>";
        $('#tblinstructor_ta tbody').append(str);
        add_ta_cnt = add_ta_cnt + 1;
        typology_wise_get_hrs();//changes 18052022


        return false;
    });

    $('#btn_area').on('click', function () {
        var str = "<tr><td>" + area + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tblarea tbody').append(str);

        //$('.drparea').chosen();
        return false;
    });

    $('#btn_semester').on('click', function () {
        var str = "<tr><td>" + semester + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tblsemester tbody').append(str);

        $('.drpsemester').chosen();
        return false;
    });

    $('#btn_time').on('click', function () {
        var row_length = $('#tbltimeday tbody tr').length;
        bindday(row_length);
       
        //var str = "<tr><td><input style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour()'/></td><td><input style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour()'/></td><td>" + day + "</td><td><input type='text' class='marg-btm cls_roomid' style='width: 50px;' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

        //commented 14 11 2019 space allocation changes
        //var str = "<tr><td><input style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour()'/></td><td><input style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour()'/></td><td>" + day + "</td><td><select class='marg-btm cls_roomid' style='width: 87px;'>" + str_room + "</select><a class='cls_view_room'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

        var str = "<tr id ='time_" + row_length + "'><td><input style='width: 56px;' id='" + row_length + "' type='text' class='from_time' onchange='calcTotalHour(this)'/></td><td><input id='" + row_length + "' style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour(this)'/></td><td style='width: 90px;'>" + day + "</td><td><select class='marg-btm cls_roomid' id ='drp_" + row_length + "' onchange='room_onchange_event(this)' style='width: 218px;'>" + str_room + "</select><a class='cls_view_room'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

        $('#tbltimeday tbody').append(str);
        add_new_rows();

        setTimepicker();

        //$('.drpsemester').chosen();
        return false;
    });

    $('#btn_time_tutorial').on('click', function () {
        //var str = "<tr><td><input style='width: 56px;' type='text' class='from_time_tutorial' onchange='calcTotalHour()'/></td><td><input style='width: 56px;' type='text' class='to_time_tutorial' onchange='calcTotalHour()'/></td><td>" + day_tutorial + "</td><td><input type='text' class='marg-btm cls_roomid_tutorial' style='width: 50px;' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        var str = "<tr><td><input style='width: 56px;' type='text' class='from_time_tutorial' onchange='calcTotalHour(this)'/></td><td><input style='width: 56px;' type='text' class='to_time_tutorial' onchange='calcTotalHour(this)'/></td><td>" + day_tutorial + "</td><td><select class='marg-btm cls_roomid_tutorial' style='width: 87px;'>" + str_room + "</select><a class='cls_view_room_tutorial'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tbltimeday_tutorial tbody').append(str);

        setTimepicker();

        return false;
    });

    if ($('#hdn_utype').val() == 'A1') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }
    else if ($('#hdn_utype').val() == 'PC') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }
    else if ($('#hdn_utype').val() == 'FA') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }
    //else {
    //if ($('#hdn_utype').val() != '' && $('#hdn_utype').val() != null && $('#hdn_utype').val() != undefined) {
    else if ($('#hdn_utype').val() == 'I2') {
        //var str = "<table style='width: 100%'><tr><td align='center'><button id='btnsave' type='button' style='display: block' class='btn btn-primary btn-primary'>" +
        //"<i class='icon-save bigger-160'></i>Save</button></td></tr></table>";

        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
        //}
    }
    else if ($('#hdn_utype').val() == 'D') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }
    else if ($('#hdn_utype').val() == 'CW') {
        var str = "<table style='width: 90%'><tr><td style='padding-left:20px;'><button id='btnsave' type='button' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "</tr></table>";
        $('#submitBtnDiv').html(str);
    }

    $('#drp_contact_hrs').on('change', function () {
        $('#tblinstructor input').val('');
    });
    var slot_status = false;
    $('#btnapprove').on('click', function () {

        if ($('#hdn_ccode').val() == '') {
            action = 'S';
            bootbox.alert('No Course to update');
            return false;
        }

        if ($('#txtcoursecode').val() == '') {
            action = 'S';
            bootbox.alert('Please Enter Course Code');
            return false;
        }

        var course_type_flag = false;
        if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA') {
            if ($('#txtcoursename').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Name');
                return false;
            }
            if ($('#txtavailable_seats').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Intake Capacity');
                return false;
            }
            if ($('#txtcredits').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Credits');
                return false;
            }
            if ($('#drpdepartment').val() == '') {
                action = 'S';
                bootbox.alert('Please Select Department');
                return false;
            }
            if ($('#drptype').val() == '') {
                //action = 'S';
                //bootbox.alert('Please Select Course Type');
                //return false;
                if (!(confirm('Are you sure you want to submit course without Course Type?'))) {
                    course_type_flag = true;
                }
            }
            else {
                if ($('#drptype').val() == 'M') {
                    if ($('#drpproject').val() == '') {
                        action = 'S';
                        bootbox.alert('Please Select Project');
                        return false;
                    }
                    else {

                        if ($('#drpproject').val() == 'Y') {

                            if ($('#txt_project_name').val().trim() == '') {
                                action = 'S';
                                bootbox.alert('Please Enter Project Name');
                                return false;
                            }
                        }

                    }

                }
            }

            if ($("#drp_gpa_ngpa").val() == '') {
                action = 'S';
                bootbox.alert('Please Select GPA/NonGPA');
                return false;
            }

            if (course_type_flag) {
                action = 'S';
                return false;
            }

            if ($('#drptypology').val() == '') {
                action = 'S';
                bootbox.alert('Please Select Course Typology');
                return false;
            }
            if ($('#txt_course_expense').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Expense');
                return false;
            }
            if ($('#drp_semester').val() == '') {
                action = 'S';
                bootbox.alert('Please Select Course Semester');
                return false;
            }
            if ($('#drpprog').val() == '') {
                action = 'S';
                bootbox.alert('Please Select Program');
                return false;
            }
            if ($('#drpprog').val() != '1') {
                //if ($('#drp_color').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Select Specialization');
                //    return false;
                //}
            }
            if ($('#drpproglevel').val() == '') {
                action = 'S';
                bootbox.alert('Please Select Program Level');
                return false;
            }
            if ($('#txtcourse_description').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Brief Introducation');
                return false;
            }
            // changes 28112023
            if ($('#txtcourse_description').val().split(' ').length > 200) {//1380
                action = 'S';
                bootbox.alert('Brief Introducation Exceeds the Word Limit');
                return false;
            }
            if ($('#txtcourse_outline').val().length > 3000) {//1380
                action = 'S';
                bootbox.alert('Long Description Exceeds the Character Limit');
                return false;
            }
            if ($('#problem_statement').val().length > 400) {//1380
                //14032022
                //action = 'S';
                //bootbox.alert('Problem Statement Exceeds the Character Limit');
                //return false;
            }

            if ($('#div_chk_prerequisite').find('input[type=checkbox]:checked').length > 0) {

                if ($('#chk_pre10').prop('checked')) {

                    if ($('#txtcourse_prerequisite').val() == '') {
                        action = 'S';
                        bootbox.alert('Please Enter Other Course Prerequisite');
                        return false;
                    }
                }
            }
            else {
                action = 'S';
                bootbox.alert('Please select Course Prerequisite');
                return false;
            }

            if ($('#txtcourse_outcome1').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Outcome 1');
                return false;
            }
            if ($("#hdn_utype").val() != 'A1') {//$("#drpsubtypology").val() != "" && //Mahroofbhai told on call 22062021
                if ($("#txtcourse_description").val() != '') {

                    var textbox = document.getElementById("txtcourse_description");
                    //if (textbox.value.length <= 1300 && textbox.value.length >= 1100) {//1380 - 1155
                    // changes 28112023
                    if (textbox.value.split(' ').length <= 200 && textbox.value.split(' ').length >= 15) {//1380 - 1155
                        //bootbox.alert("The characters it will be min 1155 to max 1380 characters");
                        // return true;
                    }
                    else {
                        action = 'S';
                       // bootbox.alert("Make sure the Brief Description input is between min 1100 to max 1300 characters");
                        bootbox.alert("Make sure the Brief Introduction input is between Min 15 to Max 200 Word");
                        return false;
                    }
                }
            }

            //if ($('#txt_evalmethod').val() == '') {
            //    action = 'S';
            //    bootbox.alert('Please Enter Assessment in Evaluation Method');
            //    return false;
            //}
            if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
                if ($('#tbl_course_assessment tbody tr').length > 0 && $('.tr_assessment').length > 0) {
                    if ($('.tr_assessment').eq(0).find('.cls_exercises').val() == undefined || $('.tr_assessment').eq(0).find('.cls_exercises').val() == ''
                        || $('.tr_assessment').eq(0).find('.cls_percentage').val() == undefined || $('.tr_assessment').eq(0).find('.cls_percentage').val() == ''
                        || $('.tr_assessment').eq(0).find('.cls_criteria').val() == undefined || $('.tr_assessment').eq(0).find('.cls_criteria').val() == '') {
                        action = 'S';
                        bootbox.alert('Please Enter Course Assessment');
                        return false;
                    }
                }
                else {
                    if ($("#drpsubtypology").val() != 1) {
                        action = 'S';
                        bootbox.alert('Please Enter Course Assessment');
                        return false;
                    }
                }
            }

            if ($("#drpsubtypology").val() == "L2")
            {
                if ($('input[type=radio][name=rdo_focus_studio]:checked').val() == "") {
                    action = 'S';
                    bootbox.alert('Please Select Focus of Studio');
                    return false;
                }
            }
            if ($("#drpsubtypology").val() == "L3" && $("#drpproglevel").val() == "UD2") {
                if ($('input[type=radio][name=rdo_focus_studio]:checked').val() == "") {
                    action = 'S';
                    bootbox.alert('Please Select Focus of Studio');
                    return false;
                }
            }

            //if ($('#txt_evalmethod_weightage1').val() == '') {
            //    action = 'S';
            //    bootbox.alert('Please Enter Assessment 1 Weightage');
            //    return false;
            //} 

            //var total_eval_weightage = 0;
            //for (var i = 1; i <= 5; i++) {
            //    if ($('#txt_evalmethod_weightage' + i).val() != '') {
            //        total_eval_weightage = total_eval_weightage + parseInt($('#txt_evalmethod_weightage' + i).val());
            //    }
            //}
            //if (total_eval_weightage != 100) {
            //    action = 'S';
            //    total_eval_weightage = 0;
            //    bootbox.alert('Total Evaluation Method Weightage must be 100');
            //    return false;
            //}

            if ($('#txt_prep_self_hrs').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Student Prep/Self Study Hours');
                return false;
            }

            //if ($("#drpsubtypology").val() != "1") {
            //drpsubtypology
            if ($('#drp_typology_group').val() != '' && $('#drptypology').val() != '') {
                var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

                if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003' || $('#drptypology').val() == '24') {
                    if ($('#txtcourse_outline').val() == '')
                    {
                        
                            action = 'S';
                            bootbox.alert('Please Enter Long Description');
                            return false;
                        
                    }
                }
            }

            var textbox_long_desc = document.getElementById("txtcourse_outline");
            //Check
            if ($("#hdn_utype").val() != 'A1') {
                if (textbox_long_desc.value.length <= 3000 && textbox_long_desc.value.length >= 1100) {//1380 - 1155

                }
                else {
                    action = 'S';
                    bootbox.alert("Make sure the Long Description input is between Min 1100 to Max 3000 characters");
                    return false;
                }
            }

            if ($('input[name=rdo_outline]:checked').val() == 'weekly') {
                if (window.temp_week_typology == 0 || window.temp_week_typology == undefined) {
                    action = 'S';
                    bootbox.alert('Define Weeks for weekly plan.');
                    return false;
                }

                var flag = true;
                var weeks = window.temp_week_typology; //Mayur 30042019 Put Variable instead of 12
                for (var i = 1; i <= weeks; i++) {
                    if (flag) {
                        if ($('#txt_week' + i).val() == '') {
                            action = 'S';
                            bootbox.alert('Please Enter Weekly Plan for Week ' + i);
                            flag = false;
                        }
                        if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'A1') {
                            if ($('#txt_week_per' + i).val() == '') {
                                action = 'S';
                                bootbox.alert('Please Enter 0 if no Assessment Percentage for Week ' + i);
                                flag = false;
                            }
                            if ($('#txt_week_crt' + i).val() == '') {
                                action = 'S';
                                bootbox.alert('Please Enter Assessment Criteria for Week ' + i);
                                flag = false;
                            }
                        }


                        //14032022
                        if ($('#lbl_week_img_' + i).text() == '') {
                            //action = 'S';
                            //bootbox.alert('Please Upload Weekly PDF/Image ' + i);
                            //flag = false;
                        }

                    }
                }

                if (!flag) {
                    return false;
                }

                //if ($('#txt_week1').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 1');
                //    return false;
                //}
                //if ($('#txt_week2').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 2');
                //    return false;
                //}
                //if ($('#txt_week3').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 3');
                //    return false;
                //}
                //if ($('#txt_week4').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 4');
                //    return false;
                //}
                //if ($('#txt_week5').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 5');
                //    return false;
                //}
                //if ($('#txt_week6').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 6');
                //    return false;
                //}
                //if ($('#txt_week7').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 7');
                //    return false;
                //}
                //if ($('#txt_week8').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 8');
                //    return false;
                //}
                //if ($('#txt_week9').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 9');
                //    return false;
                //}
                //if ($('#txt_week10').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 10');
                //    return false;
                //}
                //if ($('#txt_week11').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 11');
                //    return false;
                //}
                //if ($('#txt_week12').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 12');
                //    return false;
                //}

                //if ($('#drptypology').val() != '24') {
                //    if ($('#txt_week13').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 13');
                //        return false;
                //    }
                //    if ($('#txt_week14').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 14');
                //        return false;
                //    }
                //    if ($('#txt_week15').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 15');
                //        return false;
                //    }
                //    if ($('#txt_week16').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 16');
                //        return false;
                //    }
                //}
            }
            else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
                //if ($('#txtcourse_structure').val() == '') {
                if (CKEDITOR.instances.txtcourse_structure.getData() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Course Structure');
                    return false;
                }
            }
            //}
            //if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
        }
        else if ($('#hdn_utype').val() == 'I2' || $("#hdn_utype").val() == 'D') {
            //if ($('#txtavailable_seats').val() == '') {
            //    action = 'S';
            //    bootbox.alert('Please Enter Intake Capacity');
            //    return false;
            //}

            if ($('#drp_typology_group').val() != '' && $('#drptypology').val() != '') {
                var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

                if (temp_selected_typology.length > 0) {// && temp_selected_typology[0]['sub_group'] == 'SG003'

                    if (temp_selected_typology[0]['sub_group'] == 'SG003') {
                        if ($("#studio_mode").val() == "") {
                            action = 'S';
                            bootbox.alert('Please Select Teaching Mode');
                            return false;
                        }
                    }
                    else if (parseInt($('#drpyear').val()) == 2021 && $('#drpsemester').val() == "S") {
                    }
                    else if (parseInt($('#drpyear').val()) >= 2021 && $('#drpsemester').val() == "M") {
                        if ($("#studio_mode").val() == "") {
                            action = 'S';
                            bootbox.alert('Please Select Teaching Mode');
                            return false;
                        }
                    }
                    else if (parseInt($('#drpyear').val()) >= 2021) {
                        if ($("#studio_mode").val() == "") {
                            action = 'S';
                            bootbox.alert('Please Select Teaching Mode');
                            return false;
                        }
                    }
                    //if ($("#studio_mode").val() == "") {
                    //    action = 'S';
                    //    bootbox.alert('Please Select Studio Mode');
                    //    return false;
                    //}
                }
            }

            if ($('#txtcourse_description').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Brief Description');
                return false;
            }
            //if ($('#txtcourse_description').val().length > 1300) {//1380
            //    action = 'S';
            //    bootbox.alert('Course Introduction Exceeds the Character Limit');
            //    return false;
            //}

            //var textbox = document.getElementById("txtcourse_description");
            //var textbox1 = document.getElementById("problem_statement");

            //if ($("#drpsubtypology").val() != "") {// && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA'
            //    if (textbox.value.length <= 1300 && textbox.value.length >= 1100) {//1380 - 1155

            //    }
            //    else {
            //        bootbox.alert("Make sure the Course Introduction input is between Min 1100 to Max 1300 characters");
            //        action = 'S';
            //        return false;
            //    }
            //}

            //if ($("#drpsubtypology").val() != "") {// && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA'
            //    if (textbox1.value.length <= 400 && textbox1.value.length >= 200) {//1380 - 1155

            //    }
            //    else {
            //        bootbox.alert("Make sure the Problem Statement input is between Min 200 to Max 400 characters");
            //        action = 'S';
            //        return false;
            //    }
            //}

            if ($('#div_chk_prerequisite').find('input[type=checkbox]:checked').length > 0) {
                if ($('#chk_pre10').prop('checked')) {

                    if ($('#txtcourse_prerequisite').val() == '') {
                        action = 'S';
                        bootbox.alert('Please Enter Other Course Prerequisite');
                        return false;
                    }
                }
            }
            else {
                action = 'S';
                bootbox.alert('Please select Course Prerequisite');
                return false;
            }

            if ($('#txtcourse_outcome1').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Outcome 1');
                return false;
            }

            //if ($('#txt_evalmethod').val() == '') {
            //    action = 'S';
            //    bootbox.alert('Please Enter Assessment in Evaluation Method');
            //    return false;
            //}
            if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
                if ($('#tbl_course_assessment tbody tr').length > 0 && $('.tr_assessment').length > 0) {
                    if ($('.tr_assessment').eq(0).find('.cls_exercises').val() == undefined || $('.tr_assessment').eq(0).find('.cls_exercises').val() == ''
                        || $('.tr_assessment').eq(0).find('.cls_percentage').val() == undefined || $('.tr_assessment').eq(0).find('.cls_percentage').val() == ''
                        || $('.tr_assessment').eq(0).find('.cls_criteria').val() == undefined || $('.tr_assessment').eq(0).find('.cls_criteria').val() == '') {
                        action = 'S';
                        bootbox.alert('Please Enter Course Assessment');
                        return false;
                    }
                }
                else {
                    if ($("#drpsubtypology").val() != 1) {
                        action = 'S';
                        bootbox.alert('Please Enter Course Assessment');
                        return false;
                    }
                }
            }

            //if ($('#txt_evalmethod_weightage1').val() == '') {
            //    action = 'S';
            //    bootbox.alert('Please Enter Assessment 1 Weightage');
            //    return false;
            //} 

            //var total_eval_weightage = 0;
            //for (var i = 1; i <= 5; i++) {
            //    if ($('#txt_evalmethod_weightage' + i).val() != '') {
            //        total_eval_weightage = total_eval_weightage + parseInt($('#txt_evalmethod_weightage' + i).val());
            //    }
            //}
            //if (total_eval_weightage != 100) {
            //    action = 'S';
            //    total_eval_weightage = 0;
            //    bootbox.alert('Total Evaluation Method Weightage must be 100');
            //    return false;
            //}
            //if ($("#drpsubtypology").val() != 1) {

            if ($('#drp_typology_group').val() != '' && $('#drptypology').val() != '') {
                var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

                if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003' || $('#drptypology').val() == '24') {
                    if ($('#txtcourse_outline').val() == '')
                    {
                        //if ($("#drpsubtypology").val() != '1')
                        //{
                            action = 'S';
                            bootbox.alert('Please Enter Long Description');
                            return false;
                        //}
                    }
                }
            }

            //}

            if ($('#drp_typology_group').val() != '' && $('#drptypology').val() != '') {
                var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

                if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003') {
                    if ($("#problem_statement").val() == '' && $("#hdn_utype").val() != 'A1')
                    {    //14032022
                       // action = 'S';
                       // bootbox.alert("Please Enter Problem Statement");
                       // return false;
                    }
                }
            }

            if ($('#drp_typology_group').val() != '' && $('#drptypology').val() != '') {
                var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

                if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003') {
                    var textbox1 = document.getElementById("problem_statement");
                    if ($("#hdn_utype").val() != 'A1') {// && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA'//$("#drpsubtypology").val() != "" && //Mahroofbhai told on call 22062021
                        if (textbox1.value.length <= 400 && textbox1.value.length >= 200) {//1380 - 1155

                        }
                        else {
                            //14032022
                            //bootbox.alert("Make sure the Problem Statement input is between Min 200 to Max 400 characters.");
                            //action = 'S';
                            //return false;
                        }
                    }
                }
            }

            //if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {

            if ($('input[name=rdo_outline]:checked').val() == 'weekly') {
                if (window.temp_week_typology == 0 || window.temp_week_typology == undefined) {
                    action = 'S';
                    bootbox.alert('Define Weeks for weekly plan.');
                    return false;
                }

                var flag = true;
                var weeks = window.temp_week_typology; //Mayur 30042019 Put Variable instead of 12
                for (var i = 1; i <= weeks; i++) {
                    if (flag) {
                        if ($('#txt_week' + i).val() == '') {
                            action = 'S';
                            bootbox.alert('Please Enter Weekly Plan for Week ' + i);
                            flag = false;
                        }
                        if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'A1') {
                            if ($('#txt_week_per' + i).val() == '') {
                                action = 'S';
                                bootbox.alert('Please Enter 0 if no Assessment Percentage for Week ' + i);
                                flag = false;
                            }
                            if ($('#txt_week_crt' + i).val() == '') {
                                action = 'S';
                                bootbox.alert('Please Enter Assessment Criteria for Week ' + i);
                                flag = false;
                            }
                        }


                        //14032022
                        if ($('#lbl_week_img_' + i).text() == '') {
                            //action = 'S';
                            //bootbox.alert('Please Upload Weekly PDF/Image ' + i);
                            //flag = false;
                        }
                    }
                }

                if (!flag) {
                    return false;
                }

                //if ($('#txt_week1').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 1');
                //    return false;
                //}
                //if ($('#txt_week2').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 2');
                //    return false;
                //}
                //if ($('#txt_week3').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 3');
                //    return false;
                //}
                //if ($('#txt_week4').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 4');
                //    return false;
                //}
                //if ($('#txt_week5').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 5');
                //    return false;
                //}
                //if ($('#txt_week6').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 6');
                //    return false;
                //}
                //if ($('#txt_week7').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 7');
                //    return false;
                //}
                //if ($('#txt_week8').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 8');
                //    return false;
                //}
                //if ($('#txt_week9').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 9');
                //    return false;
                //}
                //if ($('#txt_week10').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 10');
                //    return false;
                //}
                //if ($('#txt_week11').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 11');
                //    return false;
                //}
                //if ($('#txt_week12').val() == '') {
                //    action = 'S';
                //    bootbox.alert('Please Enter Weekly Plan for Week 12');
                //    return false;
                //}

                //if ($('#drptypology').val() != '24') {
                //    if ($('#txt_week13').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 13');
                //        return false;
                //    }
                //    if ($('#txt_week14').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 14');
                //        return false;
                //    }
                //    if ($('#txt_week15').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 15');
                //        return false;
                //    }
                //    if ($('#txt_week16').val() == '') {
                //        action = 'S';
                //        bootbox.alert('Please Enter Weekly Plan for Week 16');
                //        return false;
                //    }
                //}
            }
            else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
                //if ($('#txtcourse_structure').val() == '') {
                if (CKEDITOR.instances.txtcourse_structure.getData() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Course Structure');
                    return false;
                }
            }
        }

        //if ($("#drpsubtypology").val() != "" && $("#problem_statement").val() == '' && $("#hdn_utype").val() != 'A1') {
        //    action = 'S';
        //    bootbox.alert("Please Enter Problem Statement");
        //    return false;
        //}

        var textbox = document.getElementById("txtcourse_description");
        //Done
        if ($("#hdn_utype").val() != 'A1') {// && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA'//$("#drpsubtypology").val() != "" && //Mahroofbhai told on call 22062021
            //if (textbox.value.length <= 1300 && textbox.value.length >= 1100) {//1380 - 1155
            //changes 28112023
            if (textbox.value.split(' ').length <= 200 && textbox.value.split(' ').length >= 15) {//1380 - 1155

            }
            else {
                //bootbox.alert("Make sure the Brief Description input is between Min 1100 to Max 1300 characters");
                bootbox.alert("Make sure the Brief Introduction input is between Min 15 to Max 200 Word");
                action = 'S';
                return false;
            }
        }

        if (CKEDITOR.instances.txt_reference.getData() == "") {
            action = 'S';
            bootbox.alert('Please Enter References');
            return false;
        }

        var flag_inst_new = true;
        var text_desc_status = false;
        $("#tblinstructor tbody tr").each(function (j) {
            //04032022
            var instructor_data = { 'tutor_description': '' };
            var tbd_inst = $(this).find(".drpinstructor").val();
            if (tbd_inst.substring(0, 4) != "TBD_")
            {
            instructor_data.tutor_description = document.querySelectorAll("textarea[data-bind_row_no='" + $(this).find("[data-row_no]")[0].dataset["row_no"] + "']")[0].value;
            if (instructor_data.tutor_description.search("\"") != -1) { instructor_data.tutor_description = instructor_data.tutor_description.replace(/"/g, '\\\"'); }

                //changes 03062022
                var text_desc = instructor_data.tutor_description;
                if (text_desc == undefined || text_desc.trim() == "") {
                    text_desc_status = true;
                    
                }

            if (flag_inst_new) {
                if (instructor_data.tutor_description.length < 350) {//370
                    flag_inst_new = false;
                }
                if (instructor_data.tutor_description.length > 400) {
                    flag_inst_new = false;
                }
                }
            }
        });
        //this changes By Nitinbhai 06062022 all user mandatory for Tutor Profile... 
        if (text_desc_status)
        {
            action = 'S';
            bootbox.alert('Please Enter Tutor Profile Details');
            return false;
        }
        if (!flag_inst_new)
        {
            action = 'S';
            bootbox.alert('Please write in between  Min 350 and Max 400 characters for Tutor Profile ');
            return false;
        }

        if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'A1')
        {
            if ($('#drptypology').val() != "") {
                var temp_select_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });
                if (temp_select_typology.length > 0 && temp_select_typology[0]['sub_group'] == 'SG003')
                {
                    if (!flag_inst_new) {
                        action = 'S';
                        bootbox.alert('Please write in between  Min 350 and Max 400 characters for Tutor Profile ');
                        return false;
                    }
                }
            }
        }

        //if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'A1') {
        //    if (temp_FileName.length == 0) {
        //        action = 'S';
        //        bootbox.alert('Please Add Course Image');
        //        return false;
        //    }
        //}

        //07102021
        //if ($('#drptypology').val() == '23' || $('#drptypology').val() == '28') {
        if ($('#drptypology').val() == '23')
        {
            var file_name_value = $('#lbl_excercises_file_name').text();
            if (file_name_value == '') {
                action = 'S';
                bootbox.alert('Please Upload weekly excercises (PDF file only with Max 50 MB)');
                return false;
            }

            var subtitletextbox = document.getElementById("txtcourse_studiosubtitle");

            if (subtitletextbox.value.split(' ').length <= 100 && subtitletextbox.value.split(' ').length >= 15) {

            }
            else
            {

                //bootbox.alert("Make sure the Studio SubTitle input is between Min 15 to Max 100 Word");
                 //action = 'S';
                //return false;
            }

        }

        
        //if ($('#hdn_utype').val() == 'I2') 
       // {
            if ($("#tblinstructor_time_slot tbody tr").length > 0)
            {
                $("#tblinstructor_time_slot tbody tr").each(function (j)
                {
                    var time_slot_value = $(this).find(".inst_name").val();
                    if (time_slot_value != '')
                    {
                        if ($(this).find(".from_time").val() == '')
                        {
                            slot_status = true;
                            return false;
                        }
                        else
                        {
                            slot_status = false;
                        }
                        if ($(this).find(".to_time").val() == '') {
                            slot_status = true;
                            return false;
                        }
                        else { slot_status = false; }
                    }
                });
            }
            else
            {
                slot_status = true;
            }
            if (slot_status) {
                action = 'S';
                bootbox.alert('Please Select Instructor Hours Time Slot');
                return false;

            }
        //}
        //else
        //{
        //    slot_status = false;
        //}
        

        action = 'A';
        $('#btnsave').click();
    });

    $('#btnsave').on('click', function ()
    {
        var group_id = "";
        if ($('#hdn_ccode').val() == '') {
            action = 'S';
            bootbox.alert('No Course to update');
            return false;
        }
        if ($('#txtcoursecode').val() == '') {
            action = 'S';
            bootbox.alert('Please Enter Course Code');
            return false;
        }
        if ($('#drptypology').val() == '24')
        {
            if ($('#rdo_t').prop("checked") == true && $('#rdo_ta_y').prop("checked") == true)
            {
                group_id = 'WT003';
            }
            else if ($('#rdo_ta_y').prop("checked") == true) {
                group_id = 'WT002';
            }
            else if ($('#rdo_t').prop("checked") == true) {
                group_id = 'WT001';
            }
            else {
                group_id = 'WT001';
            }

        }
        else if ($('#drptypology').val() == '23')
        {
            

            if ($('#rdo_s').prop("checked") == true) {
                group_id = 'WT004';
            }
            else if ($('#rdo_d').prop("checked") == true) {
                group_id = 'WT005';
            }
            else {
                action = 'S';
                bootbox.alert('Select Studio Type');
                return false;
            }


            var subtitletextbox = document.getElementById("txtcourse_studiosubtitle");

            if (subtitletextbox.value.split(' ').length <= 100 && subtitletextbox.value.split(' ').length >= 15) {

            }
            else {

                //bootbox.alert("Make sure the Studio SubTitle input is between Min 15 to Max 100 Word");
               // action = 'S';
                //return false;
            }

        }
        var course_data = { 'doc_no': '', 'course_code': '', 'course_name': '', 'credits': '', 'course_description': '', 'course_prerequisite': '', 'course_outline': '', 'remark': '', 'type': '', 'semester_type': '', 'year_semester': '', 'week1': '', 'week2': '', 'week3': '', 'week4': '', 'week5': '', 'week6': '', 'week7': '', 'week8': '', 'week9': '', 'week10': '', 'week11': '', 'week12': '', 'week13': '', 'week14': '', 'week15': '', 'week16': '', 'week_reference1': '', 'week_reference2': '', 'week_reference3': '', 'week_reference4': '', 'week_reference5': '', 'week_reference6': '', 'week_reference7': '', 'week_reference8': '', 'week_reference9': '', 'week_reference10': '', 'week_reference11': '', 'week_reference12': '', 'week_reference13': '', 'week_reference14': '', 'week_reference15': '', 'week_reference16': '', 'week_assignment1': '', 'week_assignment2': '', 'week_assignment3': '', 'week_assignment4': '', 'week_assignment5': '', 'week_assignment6': '', 'week_assignment7': '', 'week_assignment8': '', 'week_assignment9': '', 'week_assignment10': '', 'week_assignment11': '', 'week_assignment12': '', 'week_assignment13': '', 'week_assignment14': '', 'week_assignment15': '', 'week_assignment16': '', 'course_structure': '', 'eval_method': '', 'eval_method2': '', 'eval_method3': '', 'eval_method4': '', 'eval_method5': '', 'eval_method_weightage1': '', 'eval_method_weightage2': '', 'eval_method_weightage3': '', 'eval_method_weightage4': '', 'eval_method_weightage5': '', 'prep_self_study_hrs': '', 'instructor_contact_hrs': '', 'project': '', 'project_name': '', 'room_id': '', 'tutorial_offered': '', 'course_expense': '', 'gpa_ngpa': '', 'course_assessment': '', 'problem_statement': '', 'studio_mode': '', 'weekly_excercises_path': '', 'hrs_group_id': '', 'CouseSubTitle': '' };//07102021

        var course_weekly_percent_criteria = {
            'week_assignment_per1': '', 'week_assignment_per2': '', 'week_assignment_per3': '', 'week_assignment_per4': '', 'week_assignment_per5': '', 'week_assignment_per6': '', 'week_assignment_per7': '', 'week_assignment_per8': '', 'week_assignment_per9': '', 'week_assignment_per10': '', 'week_assignment_per11': '', 'week_assignment_per12': '', 'week_assignment_per13': '', 'week_assignment_per14': '', 'week_assignment_per15': '', 'week_assignment_per16': '', 'week_assignment_crt1': '', 'week_assignment_crt2': '', 'week_assignment_crt3': '', 'week_assignment_crt4': '', 'week_assignment_crt5': '', 'week_assignment_crt6': '', 'week_assignment_crt7': '', 'week_assignment_crt8': '', 'week_assignment_crt9': '', 'week_assignment_crt10': '', 'week_assignment_crt11': '', 'week_assignment_crt12': '', 'week_assignment_crt13': '', 'week_assignment_crt14': '', 'week_assignment_crt15': '', 'week_assignment_crt16': ''
            , 'week_exercises1': '', 'week_exercises2': '', 'week_exercises3': '', 'week_exercises4': '', 'week_exercises5': '', 'week_exercises6': '', 'week_exercises7': ''
            , 'week_exercises8': '', 'week_exercises9': '', 'week_exercises10': '', 'week_exercises11': '', 'week_exercises12': '', 'week_exercises13': '', 'week_exercises14': ''
            , 'week_exercises15': '', 'week_exercises16': ''
        };

        course_data.doc_no = $('#hdn_dno').val();
        course_data.course_code = $('#hdn_ccode').val();
        course_data.course_name = $('#txtcoursename').val();
        course_data.credits = $('#txtcredits').val();
        course_data.course_description = $('#txtcourse_description').val();
        course_data.CouseSubTitle = $('#txtcourse_studiosubtitle').val();
        //new 19052022
        course_data.hrs_group_id = group_id;
        //var textbox = document.getElementById("txtcourse_description");
        //var textbox1 = document.getElementById("problem_statement");

        //if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
        //    if (textbox.value.length <= 1300 && textbox.value.length >= 1100) {//1380 - 1155

        //    }
        //    else {
        //        bootbox.alert("Make sure the Course Introduction input is between Min 1100 to Max 1300 characters")
        //        return false;
        //    }
        //}

        //if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
        //    if (textbox1.value.length <= 400 && textbox1.value.length >= 200) {//1380 - 1155

        //    }
        //    else {
        //        bootbox.alert("Make sure the Problem Statement input is between Min 200 to Max 400 characters");
        //        return false;
        //    }
        //}
        //course_data.course_prerequisite = $('#txtcourse_prerequisite').val();

        var chk_prerequisite = "";

        //for (var i = 0; i < $('#div_chk_prerequisite').find('input[type=checkbox]').length; i++) {
        //    if (document.getElementById($('#div_chk_prerequisite').find('input[type=checkbox]')[i].id).checked) {
        //        chk_prerequisite = chk_prerequisite + $('#div_chk_prerequisite').find('input[type=checkbox]')[i].id + '~';
        //    }
        //}

        for (var i = 0; i < $('#div_chk_prerequisite').find('input[type=checkbox]:checked').length; i++) {
            chk_prerequisite = chk_prerequisite + $('#div_chk_prerequisite').find('input[type=checkbox]:checked')[i].id + '~';
        }

        if (chk_prerequisite != "") {
            chk_prerequisite = chk_prerequisite.substr(0, chk_prerequisite.length - 1)
        }

        if (!$("#chk_pre10").prop('checked')) {
            $('#txtcourse_prerequisite').val('');
        }

        var pre_course_code = '';
        if (!$("#chk_pre11").prop('checked')) {
            pre_course_code = '';
        }
        else {
            pre_course_code = $('#drpallprecourse').val();
        }

        course_data.course_prerequisite = JSON.stringify({ "chkbox": chk_prerequisite, "other": $('#txtcourse_prerequisite').val(), "pre_course_code": pre_course_code });
        course_data.course_outline = $('#txtcourse_outline').val();

        var textbox_long_desc = document.getElementById("txtcourse_outline");
        //Done
        //Remove Validation and Keep on Submit Button
        if (action == 'A') {
            //if ($("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {//$("#drpsubtypology").val() != "1" && //Mahroofbhai told on call 22062021
            if (textbox_long_desc.value.length <= 3000 && textbox_long_desc.value.length >= 1100) {//1380 - 1155

            }
            else {
                action = 'S';
                bootbox.alert("Make sure the Long Description input is between Min 1100 to Max 3000 characters");
                return false;
            }
            //}
        }
        //Remove Validation and Keep on Submit Button

        course_data.remark = $('#txtremarks').val();
        course_data.type = $('#drptype').val();

        if ($('#drptype').val() == 'M') {
            course_data.project = $('#drpproject').val();

            if ($('#drpproject').val() == 'Y') {
                course_data.project_name = $('#txt_project_name').val();
            }
            else {
                course_data.project_name = '';
            }
            //course_data.gpa_ngpa = "G";
            course_data.gpa_ngpa = $('#drp_gpa_ngpa').val();
        }
        else {
            course_data.project = '';
            course_data.project_name = '';
            if ($('#drptype').val() == 'E') {
                if ($('#drp_gpa_ngpa').val() == "") {
                    bootbox.alert('Please Select GPA/NGPA');
                    return false;
                }
                else {
                    course_data.gpa_ngpa = $('#drp_gpa_ngpa').val();
                }
            }
        }

        //if ($("#drpsubtypology").val() != "" && $("#problem_statement").val() == '' && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
        //    bootbox.alert("Please Enter Problem Statement");
        //    return false;
        //}

        //course_data.problem_statement = $('#problem_statement').val(); //Returned By ananth
        course_data.problem_statement = ''; 
        //course_data.room_id = $('#txtroomid').val();
        course_data.room_id = '';
        course_data.semester_type = $('#hdn_sem').val();
        course_data.year_semester = $('#hdn_year').val();
        //course_data.instructor_contact_hrs = $('#drp_contact_hrs').val();
        course_data.tutorial_offered = $('input[type=radio][name=rdo_tutorial_offered]:checked').val();
        course_data.backlog = $('input[type=radio][name=rdo_backlog]:checked').val(); //Mayur 30042019
        course_data.course_expense = $('#txt_course_expense').val();
        course_data.studio_mode = $("#studio_mode").val(); //Mayur 06112020
        //if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
        var crt_flag = true;
        if ($('input[name=rdo_outline]:checked').val() == 'weekly') {
            course_data.course_structure = "";
            var weeks = parseInt(window.temp_week_typology);

            for (var i = 1; i <= weeks; i++) {
                course_data['week' + i] = $('#txt_week' + i).val();
                course_data['week_assignment' + i] = $('#txt_week_assignment' + i).val();
                course_weekly_percent_criteria['week_assignment_per' + i] = $('#txt_week_per' + i).val();
                course_weekly_percent_criteria['week_assignment_crt' + i] = $('#txt_week_crt' + i).val();
                // 14032022 
                //course_weekly_percent_criteria['week_exercises' + i] = $('#lbl_week_img_' + i).text();
                course_weekly_percent_criteria['week_exercises' + i] = '';
            }
            if (weeks != 16) {
                for (var j = weeks + 1; j <= 16; j++) {
                    course_data['week' + j] = "";
                    course_data['week_assignment' + j] = "";
                    course_weekly_percent_criteria['week_assignment_per' + j] = "";
                    course_weekly_percent_criteria['week_assignment_crt' + j] = "";
                    //14032022
                    course_weekly_percent_criteria['week_exercises' + j] = "";
                }
            }

            //course_data.week1 = $('#txt_week1').val();
            //course_data.week2 = $('#txt_week2').val();
            //course_data.week3 = $('#txt_week3').val();
            //course_data.week4 = $('#txt_week4').val();
            //course_data.week5 = $('#txt_week5').val();
            //course_data.week6 = $('#txt_week6').val();
            //course_data.week7 = $('#txt_week7').val();
            //course_data.week8 = $('#txt_week8').val();
            //course_data.week9 = $('#txt_week9').val();
            //course_data.week10 = $('#txt_week10').val();
            //course_data.week11 = $('#txt_week11').val();
            //course_data.week12 = $('#txt_week12').val();
            //course_data.week13 = $('#txt_week13').val();
            //course_data.week14 = $('#txt_week14').val();
            //course_data.week15 = $('#txt_week15').val();
            //course_data.week16 = $('#txt_week16').val();

            //course_data.week_reference1 = $('#txt_week_reference1').val();This should be blank
            //course_data.week_reference2 = $('#txt_week_reference2').val();
            //course_data.week_reference3 = $('#txt_week_reference3').val();
            //course_data.week_reference4 = $('#txt_week_reference4').val();
            //course_data.week_reference5 = $('#txt_week_reference5').val();
            //course_data.week_reference6 = $('#txt_week_reference6').val();
            //course_data.week_reference7 = $('#txt_week_reference7').val();
            //course_data.week_reference8 = $('#txt_week_reference8').val();
            //course_data.week_reference9 = $('#txt_week_reference9').val();
            //course_data.week_reference10 = $('#txt_week_reference10').val();
            //course_data.week_reference11 = $('#txt_week_reference11').val();
            //course_data.week_reference12 = $('#txt_week_reference12').val();
            //course_data.week_reference13 = $('#txt_week_reference13').val();
            //course_data.week_reference14 = $('#txt_week_reference14').val();
            //course_data.week_reference15 = $('#txt_week_reference15').val();
            //course_data.week_reference16 = $('#txt_week_reference16').val();

            //course_data.week_assignment1 = $('#txt_week_assignment1').val();
            //course_data.week_assignment2 = $('#txt_week_assignment2').val();
            //course_data.week_assignment3 = $('#txt_week_assignment3').val();
            //course_data.week_assignment4 = $('#txt_week_assignment4').val();
            //course_data.week_assignment5 = $('#txt_week_assignment5').val();
            //course_data.week_assignment6 = $('#txt_week_assignment6').val();
            //course_data.week_assignment7 = $('#txt_week_assignment7').val();
            //course_data.week_assignment8 = $('#txt_week_assignment8').val();
            //course_data.week_assignment9 = $('#txt_week_assignment9').val();
            //course_data.week_assignment10 = $('#txt_week_assignment10').val();
            //course_data.week_assignment11 = $('#txt_week_assignment11').val();
            //course_data.week_assignment12 = $('#txt_week_assignment12').val();
            //course_data.week_assignment13 = $('#txt_week_assignment13').val();
            //course_data.week_assignment14 = $('#txt_week_assignment14').val();
            //course_data.week_assignment15 = $('#txt_week_assignment15').val();
            //course_data.week_assignment16 = $('#txt_week_assignment16').val();

            //course_weekly_percent_criteria.week_assignment_per1 = $('#txt_week_per1').val();
            //course_weekly_percent_criteria.week_assignment_per2 = $('#txt_week_per2').val();
            //course_weekly_percent_criteria.week_assignment_per3 = $('#txt_week_per3').val();
            //course_weekly_percent_criteria.week_assignment_per4 = $('#txt_week_per4').val();
            //course_weekly_percent_criteria.week_assignment_per5 = $('#txt_week_per5').val();
            //course_weekly_percent_criteria.week_assignment_per6 = $('#txt_week_per6').val();
            //course_weekly_percent_criteria.week_assignment_per7 = $('#txt_week_per7').val();
            //course_weekly_percent_criteria.week_assignment_per8 = $('#txt_week_per8').val();
            //course_weekly_percent_criteria.week_assignment_per9 = $('#txt_week_per9').val();
            //course_weekly_percent_criteria.week_assignment_per10 = $('#txt_week_per10').val();
            //course_weekly_percent_criteria.week_assignment_per11 = $('#txt_week_per11').val();
            //course_weekly_percent_criteria.week_assignment_per12 = $('#txt_week_per12').val();
            //course_weekly_percent_criteria.week_assignment_per13 = $('#txt_week_per13').val();
            //course_weekly_percent_criteria.week_assignment_per14 = $('#txt_week_per14').val();
            //course_weekly_percent_criteria.week_assignment_per15 = $('#txt_week_per15').val();
            //course_weekly_percent_criteria.week_assignment_per16 = $('#txt_week_per16').val();

            //course_weekly_percent_criteria.week_assignment_crt1 = $('#txt_week_crt1').val();
            //course_weekly_percent_criteria.week_assignment_crt2 = $('#txt_week_crt2').val();
            //course_weekly_percent_criteria.week_assignment_crt3 = $('#txt_week_crt3').val();
            //course_weekly_percent_criteria.week_assignment_crt4 = $('#txt_week_crt4').val();
            //course_weekly_percent_criteria.week_assignment_crt5 = $('#txt_week_crt5').val();
            //course_weekly_percent_criteria.week_assignment_crt6 = $('#txt_week_crt6').val();
            //course_weekly_percent_criteria.week_assignment_crt7 = $('#txt_week_crt7').val();
            //course_weekly_percent_criteria.week_assignment_crt8 = $('#txt_week_crt8').val();
            //course_weekly_percent_criteria.week_assignment_crt9 = $('#txt_week_crt9').val();
            //course_weekly_percent_criteria.week_assignment_crt10 = $('#txt_week_crt10').val();
            //course_weekly_percent_criteria.week_assignment_crt11 = $('#txt_week_crt11').val();
            //course_weekly_percent_criteria.week_assignment_crt12 = $('#txt_week_crt12').val();
            //course_weekly_percent_criteria.week_assignment_crt13 = $('#txt_week_crt13').val();
            //course_weekly_percent_criteria.week_assignment_crt14 = $('#txt_week_crt14').val();
            //course_weekly_percent_criteria.week_assignment_crt15 = $('#txt_week_crt15').val();
            //course_weekly_percent_criteria.week_assignment_crt16 = $('#txt_week_crt16').val();
            for (var i = 1; i < weeks; i++) {
                if (course_weekly_percent_criteria['week_assignment_crt' + i].length > 300) {
                    crt_flag = false;
                }
            }
        }
        else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
            //course_data.course_structure = $('#txtcourse_structure').val();

            if (CKEDITOR.instances.txtcourse_structure.getData() == "") {
                course_data.course_structure = "";
            }
            else {
                course_data.course_structure = CKEDITOR.instances.txtcourse_structure.getData();
            }
        }

        // New 07102021
        course_data.weekly_excercises_path = $('#lbl_excercises_file_name').text().trim();



        //Remove Validation and Keep on Submit Button
        if (action == 'A') {
            if ($("#drpsubtypology").val() != "") {
                if (!crt_flag) {
                    bootbox.alert('You Exceeds the Character Limit in Assessment Criteria');
                    return false;
                }
            }
        }
        //Remove Validation and Keep on Submit Button

        var course_outcome = { "course_outcome1": $('#txtcourse_outcome1').val(), "course_outcome2": $('#txtcourse_outcome2').val(), "course_outcome3": $('#txtcourse_outcome3').val(), "course_outcome4": $('#txtcourse_outcome4').val(), "course_outcome5": $('#txtcourse_outcome5').val() };

        for (var i = 1; i <= 5; i++) {
            if (course_outcome["course_outcome" + i].search(/\\/) != -1) { course_outcome["course_outcome" + i] = course_outcome["course_outcome" + i].replace(/\\/g, '\\\\'); }
            if (course_outcome["course_outcome" + i].search("\"") != -1) { course_outcome["course_outcome" + i] = course_outcome["course_outcome" + i].replace(/"/g, '\\\"'); }
        }

        course_data.eval_method5 = JSON.stringify(course_outcome);
        if (course_data.eval_method5.search(/\\/) != -1) { course_data.eval_method5 = course_data.eval_method5.replace(/\\/g, '\\\\'); }
        if (course_data.eval_method5.search("\"") != -1) { course_data.eval_method5 = course_data.eval_method5.replace(/"/g, '\\\"'); }

        var lst_course_assessment = [];
        var total_percent = 0;

        if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
            for (var i = 0; i < $('#tbl_course_assessment tbody tr').length; i++) {
                var row = $('#tbl_course_assessment tbody tr').eq(i);
                var obj_assessment = { 'exercise': row.find('.cls_exercises').val(), 'percentage': row.find('.cls_percentage').val(), 'criteria': row.find('.cls_criteria').val() };

                if (obj_assessment.exercise.search(/\\/) != -1) { obj_assessment.exercise = obj_assessment.exercise.replace(/\\/g, '\\\\'); }
                if (obj_assessment.exercise.search("\"") != -1) { obj_assessment.exercise = obj_assessment.exercise.replace(/"/g, '\\\"'); }

                if (obj_assessment.criteria.search(/\\/) != -1) { obj_assessment.criteria = obj_assessment.criteria.replace(/\\/g, '\\\\'); }
                if (obj_assessment.criteria.search("\"") != -1) { obj_assessment.criteria = obj_assessment.criteria.replace(/"/g, '\\\"'); }

                if (row.find('.cls_percentage').val() != '')
                    total_percent += parseFloat(row.find('.cls_percentage').val());

                lst_course_assessment.push(obj_assessment);
            }


            if ($('#tbl_course_assessment tbody tr').length > 0 && total_percent != 100) {
                action = 'S';
                bootbox.alert('Total of Assessment Percentage should be 100');
                return false;
            }

            course_data.course_assessment = JSON.stringify(lst_course_assessment);
            if (course_data.course_assessment.search(/\\/) != -1) { course_data.course_assessment = course_data.course_assessment.replace(/\\/g, '\\\\'); }
            if (course_data.course_assessment.search("\"") != -1) { course_data.course_assessment = course_data.course_assessment.replace(/"/g, '\\\"'); }
        } else {
            course_data.course_assessment = "";
        }
        //course_data.remark = $('#txt_reference').val();

        if (CKEDITOR.instances.txt_reference.getData() == "") {
            course_data.remark = "";
        }
        else {
            course_data.remark = CKEDITOR.instances.txt_reference.getData();
        }

        course_data.eval_method = $('#txt_evalmethod').val();
        //course_data.eval_method2 = $('#txt_evalmethod2').val();
        //course_data.eval_method3 = $('#txt_evalmethod3').val();
        //course_data.eval_method4 = $('#txt_evalmethod4').val();
        //course_data.eval_method5 = $('#txt_evalmethod5').val();

        //course_data.eval_method_weightage1 = $('#txt_evalmethod_weightage1').val();
        //course_data.eval_method_weightage2 = $('#txt_evalmethod_weightage2').val();
        //course_data.eval_method_weightage3 = $('#txt_evalmethod_weightage3').val();
        //course_data.eval_method_weightage4 = $('#txt_evalmethod_weightage4').val();
        //course_data.eval_method_weightage5 = $('#txt_evalmethod_weightage5').val();

        course_data.prep_self_study_hrs = $('#txt_prep_self_hrs').val();

        if (course_data.course_description.search(/\\/) != -1) { course_data.course_description = course_data.course_description.replace(/\\/g, '\\\\'); }
        if (course_data.course_description.search("\"") != -1) { course_data.course_description = course_data.course_description.replace(/"/g, '\\\"'); }

        if (course_data.course_prerequisite.search(/\\/) != -1) { course_data.course_prerequisite = course_data.course_prerequisite.replace(/\\/g, '\\\\'); }
        if (course_data.course_prerequisite.search("\"") != -1) { course_data.course_prerequisite = course_data.course_prerequisite.replace(/"/g, '\\\"'); }

        if (course_data.course_outline.search(/\\/) != -1) { course_data.course_outline = course_data.course_outline.replace(/\\/g, '\\\\'); }
        if (course_data.course_outline.search("\"") != -1) { course_data.course_outline = course_data.course_outline.replace(/"/g, '\\\"'); }

        if (course_data.course_structure.search(/\\/) != -1) { course_data.course_structure = course_data.course_structure.replace(/\\/g, '\\\\'); }
        if (course_data.course_structure.search("\"") != -1) { course_data.course_structure = course_data.course_structure.replace(/"/g, '\\\"'); }

        if (course_data.remark.search(/\\/) != -1) { course_data.remark = course_data.remark.replace(/\\/g, '\\\\'); }
        if (course_data.remark.search("\"") != -1) { course_data.remark = course_data.remark.replace(/"/g, '\\\"'); }

        if (course_data.eval_method.search(/\\/) != -1) { course_data.eval_method = course_data.eval_method.replace(/\\/g, '\\\\'); }
        if (course_data.eval_method.search("\"") != -1) { course_data.eval_method = course_data.eval_method.replace(/"/g, '\\\"'); }

        //for (var i = 2; i <= 5; i++) {
        //    if (course_data["eval_method" + i].search(/\\/) != -1) { course_data["eval_method" + i] = course_data["eval_method" + i].replace(/\\/g, '\\\\'); }
        //    if (course_data["eval_method" + i].search("\"") != -1) { course_data["eval_method" + i] = course_data["eval_method" + i].replace(/"/g, '\\\"'); }
        //}

        for (var i = 1; i <= 16; i++) {
            if (course_data["week" + i].search(/\\/) != -1) { course_data["week" + i] = course_data["week" + i].replace(/\\/g, '\\\\'); }
            if (course_data["week" + i].search("\"") != -1) { course_data["week" + i] = course_data["week" + i].replace(/"/g, '\\\"'); }
        }

        //comment BY Ananth
        //for (var i = 1; i <= 16; i++) {
        //    if (course_data["week_reference" + i].search(/\\/) != -1) { course_data["week_reference" + i] = course_data["week_reference" + i].replace(/\\/g, '\\\\'); }
        //    if (course_data["week_reference" + i].search("\"") != -1) { course_data["week_reference" + i] = course_data["week_reference" + i].replace(/"/g, '\\\"'); }
        //}

        for (var i = 1; i <= 16; i++) {
            if (course_data["week_assignment" + i].search(/\\/) != -1) { course_data["week_assignment" + i] = course_data["week_assignment" + i].replace(/\\/g, '\\\\'); }
            if (course_data["week_assignment" + i].search("\"") != -1) { course_data["week_assignment" + i] = course_data["week_assignment" + i].replace(/"/g, '\\\"'); }
        }

        var course_dept_data = { 'semester': '', 'department': '', 'programme': '', 'typology': '', 'available_seats': '', 'program_level_code': '', 'color': '', 'sub_category_id': '', 'focus_studio': '' };

        course_dept_data.semester = $('#drp_semester').val();
        course_dept_data.department = $('#drpdepartment').val();
        course_dept_data.programme = $('#drpprog').val();
        course_dept_data.typology = $('#drptypology').val();
        course_dept_data.available_seats = $('#txtavailable_seats').val();
        course_dept_data.program_level_code = $('#drpproglevel').val();
        course_dept_data.color = $('#drp_color').val();

        course_dept_data.sub_category_id = $("#drpsubtypology").val(); //Returned By Ananth

        if ($('input[type=radio][name=rdo_focus_studio]:checked').length > 0) {
            if ($("#drpsubtypology").val() == "L2")
            {
                course_dept_data.focus_studio = $('input[type=radio][name=rdo_focus_studio]:checked').val(); //Mayur 11092019
                if ($('input[type=radio][name=rdo_focus_studio_secondary]:checked').length > 0) {
                    course_dept_data.secondary_focus_studio = $('input[type=radio][name=rdo_focus_studio_secondary]:checked').val(); //Mayur 11102019
                } else {
                    course_dept_data.secondary_focus_studio = null; //Mayur 11102019
                }
            }
            else if ($("#drpsubtypology").val() == "L3" && $("#drpproglevel").val() == "UD2") {
                course_dept_data.focus_studio = $('input[type=radio][name=rdo_focus_studio]:checked').val(); //Mayur 11092019
                if ($('input[type=radio][name=rdo_focus_studio_secondary]:checked').length > 0) {
                    course_dept_data.secondary_focus_studio = $('input[type=radio][name=rdo_focus_studio_secondary]:checked').val(); //Mayur 11102019
                } else {
                    course_dept_data.secondary_focus_studio = null; //Mayur 11102019
                }
            }
            else
            {
                course_dept_data.focus_studio = null; //Mayur 12092019
                course_dept_data.secondary_focus_studio = null; //Mayur 11102019
            }
        } else {
            course_dept_data.focus_studio = null; //Mayur 11092019
            course_dept_data.secondary_focus_studio = null; //Mayur 11102019
        }

        var instructor_data_list = [];
        var total_per_load = 0;

        var flag_inst = true;
        var flag_no_inst = true;
        //04032022
        $("#tblinstructor tbody tr").each(function (j) {

            var instructor_data = { 'instructor_code': '', 'instructor_name': '', 'percent_load': '', 'instructor_contact_hrs': '', 'tbd_status': '', 'total_hrs': '', 'additional_hours': '' };//28042022
            var tbd_inst = $(this).find(".drpinstructor").val();
            if (tbd_inst.substring(0, 4) != "TBD_")
            {
                instructor_data.instructor_code = document.querySelectorAll("textarea[data-bind_row_no='" + $(this).find("[data-row_no]")[0].dataset["row_no"] + "']")[0].id; // change by kapil 07072021
                //instructor_data.instructor_code = $(this).find(".drpinstructor").val();
                if (instructor_data.instructor_code == "") {
                    flag_no_inst = false;
                    return false;
                }
                instructor_data.percent_load = $(this).find(".per_load").val();
                instructor_data.week = $(this).find(".week").val();
                instructor_data.instructor_contact_hrs = $(this).find(".cls_drp_contact_hrs").val();

                //changes 04032022
                var tbd = $(this).find("#TBD").text();
                if (tbd.length > 0) {
                    if (tbd.substring(0, 4) == "TBD_")
                    {
                        instructor_data.tbd_status = tbd;
                    }
                }
                else {
                    instructor_data.tbd_status = "";
                }
                //instructor_data.tutor_description = document.querySelectorAll("textarea[data-bind_row_no='" + $(this).find("[data-row_no]")[0].dataset["row_no"] + "']")[0].value;
                instructor_data.tutor_description = document.querySelectorAll("textarea[data-bind_row_no='" + $(this).find("[data-row_no]")[0].dataset["row_no"] + "']")[0].value;
                if (instructor_data.tutor_description.search("\"") != -1) {
                    instructor_data.tutor_description = instructor_data.tutor_description.replace(/"/g, '\\\"');
                }

                // if (instructor_data.tutor_description != undefined)
                // {
                //      instructor_data.tutor_description = $('textarea#' + $(this).find(".drpinstructor").val() + '').val();
                // }


                if (flag_inst) {
                    if (instructor_data.tutor_description.length < 350) {//370
                        flag_inst = false;
                    }
                    if (instructor_data.tutor_description.length > 400) {
                        flag_inst = false;
                    }
                }
                total_per_load = total_per_load + parseInt($(this).find(".per_load").val());

                //if ((j + 1) == $('input[type=radio][name=rdo_tutor]:checked').val()) {
                //    instructor_data.tutor_type = "T";
                //} else {
                //    instructor_data.tutor_type = "CT";
                //}

                //06112020
                //if ((j + 1) == $('input[type=radio][name=rdo_tutor]:checked').val()) {
                //    instructor_data.tutor_type = "T";
                //} else {
                //    instructor_data.tutor_type = "CT";
                //}

                var values_tutor = $(this).find(".cls_drp_tutor").val();
                if (values_tutor == "T") {
                    instructor_data.tutor_type = "T";
                }
                else if (values_tutor == "CT") {
                    instructor_data.tutor_type = "CT";
                }
                else {
                    instructor_data.tutor_type = '';
                }
                //28042022
                instructor_data.total_hrs = $(this).find(".total_hrs").val();
                instructor_data.additional_hours = $(this).find(".add_hrs").val();
            //end
                instructor_data_list.push(instructor_data);
            }
        });

        if (!flag_no_inst) {
            bootbox.alert('Please Select Instructor');
            return false;
        }

        //if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
        //    if ($('#drptypology').val() != "") {
        //        var temp_select_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });
        //        if (temp_select_typology.length > 0 && temp_select_typology[0]['sub_group'] == 'SG003') {
        //            if (!flag_inst) {
        //                bootbox.alert('Please write in between  Min 350 and Max 400 charactres for Tutor Profile ');
        //                return false;
        //            }
        //        }
        //    }
        //}

        if (instructor_data_list.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA')) {
            if (action == 'A') {
                action = 'S';
                bootbox.alert('Please Add atleast one Instructor');
                return false;
            }
        }
        else if (instructor_data_list.length > 0)
        {
            for (var i = 0; i < instructor_data_list.length; i++) {
                if (instructor_data_list[i]['percent_load'] == '')
                {
                    if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA') {
                        //if ($('#hdn_utype').val() == 'A1') {
                        if (action == 'A') {
                            action = 'S';
                            bootbox.alert('Please Enter Percent Load');
                            return false;
                        }
                    }
                }
            }
        }

        //if (total_per_load > 100) {
        //    if (action == 'A') {
        //        action = 'S';
        //        bootbox.alert('Total Percent Load should not be greater than 100');
        //        return false;
        //    }
        //}

        var instructor_data_list_tutorial = [];
        var total_per_load_tutorial = 0;
        if ($('input[type=radio][name=rdo_tutorial_offered]:checked').val() == 'Y') {
            $("#tblinstructor_tutorial tbody tr").each(function (j) {
                var instructor_data = { 'instructor_code': '', 'instructor_name': '', 'percent_load': '', 'instructor_contact_hrs': '' };

                instructor_data.instructor_code = $(this).find(".drpinstructor_tutorial").val();
                instructor_data.percent_load = $(this).find(".per_load_tutorial").val();
                instructor_data.instructor_contact_hrs = $(this).find(".cls_drp_contact_hrs_tutorial").val();

                if ($(this).find(".per_load_tutorial").val() != '') {
                    total_per_load_tutorial = total_per_load_tutorial + parseFloat($(this).find(".per_load_tutorial").val());
                }

                instructor_data_list_tutorial.push(instructor_data);
            });

            if (instructor_data_list_tutorial.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA')) {
                if (action == 'A') {
                    action = 'S';
                    bootbox.alert('Please Add atleast one Instructor');
                    return false;
                }
            }
            else if (instructor_data_list_tutorial.length > 0) {
                for (var i = 0; i < instructor_data_list_tutorial.length; i++) {
                    if (instructor_data_list_tutorial[i]['percent_load'] == '') {
                        if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA') {
                            //if ($('#hdn_utype').val() == 'A1') {
                            if (action == 'A') {
                                action = 'S';
                                bootbox.alert('Please Enter Percent Load');
                                return false;
                            }
                        }
                    }
                }
            }

            if ($('#txtcredits').val() != '' && $('#drptypology').val() != '' && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA')) {
                var temp_contact_hr = 0;

                ////if ($('#drp_typology_group').val() == 'old') {
                //if ($('#drp_typology_group').val() == 'G001') {
                //    var temp_old_typology = jQuery.grep(old_typology, function (data) { return data.type_code === $('#drptypology').val() });
                //    if (temp_old_typology.length > 0 && temp_old_typology[0]['contact_hr_credit'] != '')
                //        temp_contact_hr = parseFloat(temp_old_typology[0]['contact_hr_credit']);
                //}
                ////else if ($('#drp_typology_group').val() == 'new') {
                //else if ($('#drp_typology_group').val() == 'G002') {
                //    var temp_new_typology = jQuery.grep(new_typology, function (data) { return data.type_code === $('#drptypology').val() });
                //    if (temp_new_typology.length > 0 && temp_new_typology[0]['contact_hr_credit'] != '')
                //        temp_contact_hr = parseFloat(temp_new_typology[0]['contact_hr_credit']);
                //}

                if ($('#drp_typology_group').val() != '') {
                    var temp_typo = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });
                    if (temp_typo.length > 0 && temp_typo[0]['contact_hr_credit'] != '')
                        temp_contact_hr = parseFloat(temp_typo[0]['contact_hr_credit']);
                }

                if (total_per_load_tutorial > (temp_contact_hr * parseInt($('#txtcredits').val()) * 25 / 100)) {
                    if (action == 'A') {
                        action = 'S';
                    }
                    bootbox.alert('Tutorial hours should be <=25% of Total hours');
                    return false;
                }
            }
        }

        var area_data_list = [];

        //$("#tblarea tbody tr").each(function (j) {
        //    var area_data = { 'area_code': '', 'area_name': '' };

        //    area_data.area_code = $(this).find(".drparea").val();
        //    area_data_list.push(area_data);
        //});
        //if (area_data_list.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC')) {
        //    if (action == 'A') {
        //        action = 'S';
        //        bootbox.alert('Please Add atleast one Area');
        //        return false;
        //    }
        //}

        var day_time_data_list = [];
        var tempthis;
        $("#tbltimeday tbody tr").each(function (j) {
            var day_time_data = { 'from_time': '', 'to_time': '', 'day': '', 'room_id': '' };

            //day_time_data.from_time = $(this).find(".from_time").val();
            //day_time_data.to_time = $(this).find(".to_time").val();

            day_time_data.from_time = convertTime($(this).find(".from_time").val());
            day_time_data.to_time = convertTime($(this).find(".to_time").val());

            day_time_data.room_id = $(this).find(".cls_roomid").val();

            day_time_data.day = $(this).find(".drpday").val();

            day_time_data_list.push(day_time_data);
        });
        if (day_time_data_list.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA')) {
            if (action == 'A') {
                action = 'S';
                bootbox.alert('Please Add atleast one Time and Day');
                return false;
            }
        }
        else if (day_time_data_list.length > 0) {
            for (var i = 0; i < day_time_data_list.length; i++) {
                if (day_time_data_list[i]['from_time'] == '' || day_time_data_list[i]['to_time'] == '' || day_time_data_list[i]['from_time'] == '0.' || day_time_data_list[i]['to_time'] == '0.') {
                    if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA') {
                        //if ($('#hdn_utype').val() == 'A1') {
                        if (action == 'A') {
                            action = 'S';
                            bootbox.alert('Please Enter Time');
                            return false;
                        }
                    }
                }

                if ($('#drpprog').val() != '3' && $('#drptype').val() == 'E' && day_time_data_list[i]['day'] != '2') {
                    action = 'S';
                    bootbox.alert('Elective courses can be offered on Tuesday only.');
                    return false;
                }
            }
        }

        var day_time_data_list_tutorial = [];
        var tempthis_tutorial;
        if ($('input[type=radio][name=rdo_tutorial_offered]:checked').val() == 'Y') {
            $("#tbltimeday_tutorial tbody tr").each(function (j) {
                var day_time_data = { 'from_time': '', 'to_time': '', 'day': '', 'room_id': '' };

                day_time_data.from_time = convertTime($(this).find(".from_time_tutorial").val());
                day_time_data.to_time = convertTime($(this).find(".to_time_tutorial").val());

                day_time_data.room_id = $(this).find(".cls_roomid_tutorial").val();

                day_time_data.day = $(this).find(".drpday_tutorial").val();

                day_time_data_list_tutorial.push(day_time_data);
            });
            if (day_time_data_list_tutorial.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA')) {
                if (action == 'A') {
                    action = 'S';
                    bootbox.alert('Please Add atleast one Time and Day');
                    return false;
                }
            }
            else if (day_time_data_list_tutorial.length > 0) {
                for (var i = 0; i < day_time_data_list_tutorial.length; i++) {
                    if (day_time_data_list_tutorial[i]['from_time_tutorial'] == '' || day_time_data_list_tutorial[i]['to_time_tutorial'] == '' || day_time_data_list_tutorial[i]['from_time_tutorial'] == '0.' || day_time_data_list_tutorial[i]['to_time_tutorial'] == '0.') {
                        if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC' || $('#hdn_utype').val() == 'FA') {
                            //if ($('#hdn_utype').val() == 'A1') {
                            if (action == 'A') {
                                action = 'S';
                                bootbox.alert('Please Enter Time');
                                return false;
                            }
                        }
                    }
                }
            }
        }

        var instructor_data_AA = [];
        $("#tblinstructor_aa tbody tr").each(function (j) {
            var instructor_data = { 'instructor_code': '', 'percent_load': '', 'week': '', 'total_hrs': '', 'additional_hours': '' };

            instructor_data.instructor_code = $(this).find(".drpinstructor_tutorial").val();
            //02052022
            instructor_data.percent_load = $(this).find(".per_load").val();
            instructor_data.week = $(this).find(".week").val();
            instructor_data.total_hrs = $(this).find(".total_hrs").val();
            instructor_data.additional_hours = $(this).find(".add_hrs").val();

            instructor_data_AA.push(instructor_data);
        });

        var instructor_data_TA = [];
        $("#tblinstructor_ta tbody tr").each(function (j) {
            var instructor_data = { 'instructor_code': '', 'percent_load': '', 'week': '', 'total_hrs': '', 'additional_hours': '' };

            instructor_data.instructor_code = $(this).find(".drpinstructor_tutorial").val();
            //02052022
            instructor_data.percent_load = $(this).find(".per_load").val();
            instructor_data.week = $(this).find(".week").val();
            instructor_data.total_hrs = $(this).find(".total_hrs").val();
            instructor_data.additional_hours = $(this).find(".add_hrs").val();

            instructor_data_TA.push(instructor_data);
        });

        //04052022
        var inst_day_time_data_list = [];
        var inst_id = '';
        //$("#tblinstructor_time_slot tbody tr").each(function (j) {
        //    var day_time_data = { 'instructor_code': '', 'from_time': '', 'to_time': '', 'day_code': '', 'room_id': '' };
        //    var time_slot_value = $(this).find(".timesolt_drp").val().split('@@');
        //    //var inst_value = $(this).find(".inst_name")[0].id;
        //    var inst_value = '';
        //    inst_value = $(this).find(".inst_name")[0].parentElement.classList[1];
        //    if (inst_value == undefined) {
        //        inst_value = $(this).find(".inst_name")[0].id;
        //    }
        //    day_time_data.room_id = '';
        //    if (time_slot_value[0] != '')
        //    {

        //        if (time_slot_value[0] != '' && time_slot_value[0] != undefined) {
        //            day_time_data.from_time = time_slot_value[0];
        //        }
        //        else {
        //            day_time_data.from_time = '';
        //        }
        //        if (time_slot_value[1] != '' && time_slot_value[1] != undefined) {
        //            day_time_data.to_time = time_slot_value[1];
        //        }
        //        else {
        //            day_time_data.to_time = '';
        //        }
        //        if (time_slot_value[2] != '' && time_slot_value[2] != undefined) {
        //            day_time_data.day_code = time_slot_value[2];
        //        }
        //        else {
        //            day_time_data.day_code = '';
        //        }
        //        if (time_slot_value[3] != '' && time_slot_value[3] != undefined) {
        //            day_time_data.room_id = time_slot_value[3];
        //        }
        //        else { day_time_data.room_id = ''; }
        //        if (inst_value != '') {
        //            inst_id = inst_value;
        //            day_time_data.instructor_code = inst_id;
        //        }
        //        else { day_time_data.instructor_code = inst_id; }

        //        inst_day_time_data_list.push(day_time_data);
        //    }


        //});


        $("#tblinstructor_time_slot tbody tr").each(function (j)
        {
            var day_time_data = { 'instructor_code': '', 'from_time': '', 'to_time': '', 'day_code': '', 'room_id': '', 'time_sq_no': '' };
            if (slot_status == false) {
            var inst_value = '';
            inst_value = $(this).find(".inst_name").prevObject[0].classList[1];
            var time_slot_seq = $(this).find(".inst_name").prevObject[0].classList[0];
            var split_inst = inst_value.split('_');
            if (split_inst.length == 1) {
                inst_id = '';
                inst_id = inst_value;

            }
            else {

                day_time_data.instructor_code = inst_id;
                if ($(this).find(".from_time").val() != '') {
                    day_time_data.from_time = convertTime($(this).find(".from_time").val());
                }
                else { day_time_data.from_time = $(this).find(".from_time").val(); }
                if ($(this).find(".to_time").val() != '') {
                    day_time_data.to_time = convertTime($(this).find(".to_time").val());
                }
                else { day_time_data.to_time = $(this).find(".to_time").val();}
                var day_value_week = '';
                switch ($(this).find(".day_value").text().trim()) {

                    case "Monday":
                        day_value_week = "1";
                        break;
                    case "Tuesday":
                        day_value_week = "2";
                        break;
                    case "Wednesday":
                        day_value_week = "3";
                        break;
                    case "Thursday":
                        day_value_week = "4";
                        break;
                    case "Friday":
                        day_value_week = "5";
                        break;
                    case "Saturday":
                        day_value_week = "6";
                        break;
                    default:
                        day_value_week = "";
                }

                day_time_data.day_code = day_value_week;
                day_time_data.room_id = $(this).find(".class_room_id").text();
                day_time_data.time_sq_no = parseInt(parseInt(split_inst[1]) + parseInt('1'));
                inst_day_time_data_list.push(day_time_data);

                }
            }
        });
        //end

        image_save_date = (new Date()).getTime();
        var temp_FileName = [];
        var temp_arr_img = [];
        if ($('#drp_typology_group').val() != '' && $('#drptypology').val() != '') {
            var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

            if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003') {
                $("#tbl_course_image tbody tr").each(function (j) {
                    if ($(this).find('.cls_course_image').val() != '') {
                        var image_dtl = { 'image_id': (j + 1), 'image_name': image_save_date.toString() + (j + 1).toString() + '.jpg' };

                        var temp_image = $.grep(obj_FileName, function (data) { return data.image_id == (j + 1) });
                        if (temp_image.length > 0) image_dtl.image_name = temp_image[0]['image_name'];

                        temp_FileName.push(image_dtl);
                        //temp_arr_img.push(image_dtl.image_name);
                        temp_arr_img.push({ 'img_name': image_dtl.image_name, 'img_caption': $(this).find('.cls_image_caption').val() });
                    }
                    else {
                        var temp_image = $.grep(obj_FileName, function (data) { return data.image_id == (j + 1) });
                        if (temp_image.length > 0) {
                            var image_dtl = { 'image_id': (j + 1), 'image_name': temp_image[0]['image_name'] };

                            temp_FileName.push(image_dtl);
                            //temp_arr_img.push(image_dtl.image_name);
                            temp_arr_img.push({ 'img_name': image_dtl.image_name, 'img_caption': $(this).find('.cls_image_caption').val() });
                        }
                    }
                });
            }
        }

        if (action == 'A') {
            if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'A1') {
                if (temp_FileName.length == 0) {
                    action = 'S';
                    bootbox.alert('Please Add Course Image');
                    return false;
                }
            }
        }

        


        //if ($("#drpsubtypology").val() != "" && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
        //    if (temp_FileName.length == 0) {
        //        bootbox.alert('Please Add Course Image');
        //        return false;
        //    }
        //}
        obj_FileName = temp_FileName;
        course_data.eval_method4 = JSON.stringify(temp_arr_img);
        if (course_data.eval_method4.search(/\\/) != -1) { course_data.eval_method4 = course_data.eval_method4.replace(/\\/g, '\\\\'); }
        if (course_data.eval_method4.search("\"") != -1) { course_data.eval_method4 = course_data.eval_method4.replace(/"/g, '\\\"'); }

        var new_code = $('#txtcoursecode').val();

        //var All_table_course_data = { 'course_data': course_data, 'course_dept_data': course_dept_data, 'instructor_data_list': instructor_data_list, 'area_data_list': area_data_list, 'day_time_data_list': day_time_data_list };
        //var All_table_course_data = { 'course_data': JSON.stringify(course_data), 'course_dept_data': JSON.stringify(course_dept_data), 'instructor_data_list': JSON.stringify(instructor_data_list), 'area_data_list': JSON.stringify(area_data_list), 'day_time_data_list': JSON.stringify(day_time_data_list) };
        //alert(JSON.stringify(All_table_course_data));

        var All_table_course_data = [course_data, course_dept_data, instructor_data_list, area_data_list, day_time_data_list, action, new_code, instructor_data_list_tutorial, day_time_data_list_tutorial, instructor_data_AA, instructor_data_TA, course_weekly_percent_criteria, inst_day_time_data_list];
        var json_All_table_course_data = JSON.stringify(All_table_course_data);

        if (json_All_table_course_data.search("'") != -1) {
            json_All_table_course_data = json_All_table_course_data.replace(/\'/g, '\\\'');
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/update_course_tables_data",
            async: false,
            data: "{ All_table_course_data: '" + json_All_table_course_data + "' }",
            //data: JSON.stringify({ 'All_table_course_data': All_table_course_data }),
            //data: "{All_table_course_data : 'Hello' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Course Code is already Available , You can not enter same Course Code again') {
                    bootbox.alert(data.d);
                }
                else if (data.d == 'Data Saved Successfully') {
                    for (var i = 0; i < obj_FileName.length; i++) {
                        UploadCourseImage(obj_FileName[i]['image_id'], 'save', obj_FileName[i]['image_name']);
                    }
                    
                    if (action == 'A') {
                        bootbox.alert('Course Submitted Successfully', function () {
                            window.location = "Admin_dashboard.aspx";
                        });
                    }
                    else {
                        bootbox.alert(data.d, function () {
                            if ($('#hdn_c').val() == $('#txtcoursecode').val()) {
                                location.reload();
                            }
                            else if ($('#hdn_c').val() != $('#txtcoursecode').val()) {
                                location.replace("frmcoursemaster.aspx?c=" + $('#txtcoursecode').val() + "&s=" + $('#hdn_sem').val() + "&y=" + $('#hdn_year').val() + "");
                            }
                        });
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

        //return false;
    });

    var current_row_id;
    function GetLsitOfInstructorImages(list_of_instructors) {

        //var instructor_code = "'" + e.value + "'";
        //  current_row_id = e.closest('tr').dataset["row_no"];
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_tutor_image_data",
            //  data: "{instructor_code :'" + instructor_code + "'}",
            data: JSON.stringify({ "instructor_code": list_of_instructors }),
            dataType: "json",
            success: function (data) {
                
                if (data.d != "") {
                    var profile_data = JSON.parse(data.d);
                    for (var i = 0; i < profile_data.length; i++) {
                        if (document.querySelectorAll("[data-bind_row_no='" + (i + 1) + "']").length > 0) {
                            if (profile_data[i]['profile_photo'] != '' && profile_data[i]['profile_photo'] != null && profile_data[i]['profile_photo'] != undefined) {
                                if (document.querySelectorAll("img[data-bind_row_no='" + (i + 1) + "']").length > 0) {
                                    if (profile_data[i]['profile_photo'].indexOf("/") >= 0) {
                                        document.querySelectorAll("img[data-bind_row_no='" + (i + 1) + "']")[i].src = profile_data[i]['profile_photo'];
                                    }
                                    else {
                                        document.querySelectorAll("img[data-bind_row_no='" + (i + 1) + "']")[i].src = "../../UserPersonalPhoto/" + profile_data[i]['profile_photo'];
                                    }

                                }

                                if (document.querySelectorAll("label[data-bind_row_no='" + (i + 1) + "']").length > 0) {
                                    document.querySelectorAll("label[data-bind_row_no='" + (i + 1) + "']")[0].innerHTML = profile_data[i]["user_name"]
                                }
                                if (document.querySelectorAll("span[data-bind_row_no='" + (i + 1) + "']").length > 0) {
                                    document.querySelectorAll("span[data-bind_row_no='" + (i + 1) + "']")[0].innerHTML = 'Profile For ' + profile_data[i]["user_name"];
                                }
                                if (document.querySelectorAll("textarea[data-bind_row_no='" + current_row_id + "']").length > 0) {
                                    document.querySelectorAll("textarea[data-bind_row_no='" + current_row_id + "']")[0].value = profile_data[0]["education_description"];
                                }
                            }
                            else {

                            }
                        }
                        else {
                          
                            if (profile_data[i]['profile_photo'] != '' && profile_data[i]['profile_photo'] != null && profile_data[i]['profile_photo'] != undefined) {

                                var user_name = document.createElement('label');

                                var textArea = $('<span data-bind_row_no="' + (i + 1) + '">Profile For ' + profile_data[i]["user_name"] + '</span><textarea id="' + profile_data[i]["instructor_code"] + '" style="width: 100%"   rows="4" cols="50" onkeypress="tutor_charcount(event)" onkeydown="return keydown_tutor_removechar(event)" name="address" data-bind_row_no="' + (i + 1) + '">' + profile_data[0]["education_description"] + '</textarea><span style="float: right; margin-bottom: 10px;" data-bind_row_no="' + (i + 1) + '">Total Char : 400</span>');

                                $("#profile_desc").append(textArea);

                                user_name.className = 'col-md-2';
                                user_name.style.fontWeight = "bold";
                                //user_name.id = profile_data[i]["instructor_code"];
                                user_name.innerHTML = profile_data[i]["user_name"];

                                var img = document.createElement('img');
                                img.style.width = '140px';
                                img.style.height = '150px';
                                img.style.margin = '0px -7px 0px 0px ';
                                img.className = 'col-md-2';

                                if (profile_data[i]['profile_photo'].indexOf("/") >= 0) {
                                    img.src = profile_data[i]['profile_photo'];
                                }
                                else {
                                    img.src = "../../UserPersonalPhoto/" + profile_data[i]['profile_photo'];
                                }

                                $("#img")[0].appendChild(img);
                                $("#profile_name")[0].appendChild(user_name);
                                user_name.setAttribute('data-bind_row_no', (i + 1));
                                img.setAttribute('data-bind_row_no', (i + 1));
                            }
                            else {
                                var img = document.createElement('img');
                                var user_name = document.createElement('label');
                                user_name.className = 'col-md-2';

                                var textArea = $('<span data-bind_row_no="' + (i + 1) + '">Profile For ' + profile_data[i]["user_name"] + '</span> <textarea id="' + profile_data[i]["instructor_code"] + '" style="width: 100%"   rows="4" cols="50" onkeypress="tutor_charcount(event)" onkeydown="return keydown_tutor_removechar(event)" data-bind_row_no="' + (i + 1) + '" name="address">' + profile_data[0]["education_description"] + '</textarea><span style="float: right; margin-bottom: 10px;" data-bind_row_no="' + (i + 1) + '">Total Char : 400</span>');
                                $("#profile_desc").append(textArea)
                                user_name.style.fontWeight = "bold";
                                //user_name.id = profile_data[0]["instructor_code"];
                                user_name.innerHTML = profile_data[i]["user_name"];

                                img.style.width = '140px';
                                img.style.height = '150px';
                                img.style.margin = '0px -7px 0px 0px ';
                                img.className = 'col-md-2';
                                //img.id = profile_data[i]["instructor_code"];
                                $("#img")[0].appendChild(img);

                                $("#profile_name")[0].appendChild(user_name);
                                user_name.setAttribute('data-bind_row_no', (i + 1));
                                img.setAttribute('data-bind_row_no', (i + 1));
                            }
                        }
                    }
                    bindinstdata();
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    }

    var selected_instructor = '';
    $('#tblinstructor tbody tr td input.but_click').live('click', function (e) {

        cur_tr = $(this).closest('tr');
        selected_instructor = cur_tr.find('.drpinstructor').val();
        InstructorImages(selected_instructor);
    });

    $('#tblinstructor tbody tr td input.but_save').live('click', function (e) {
        //alert(e.currentTarget.id);
        
        cur_tr = $(this).closest('tr');
        var per_load = cur_tr.find('.per_load').val();
        var total_weeks = cur_tr.find('.week').val();
        var total_contact_hrs = cur_tr.find('.per_load').val();
        var total_hrs_in_semester = cur_tr.find('.total_hrs').val();
        var add_hrs = cur_tr.find('.add_hrs').val();
        var instructor_code = cur_tr.find('.drpinstructor').val();
        var inst_type = e.currentTarget.id;
        var course_code = $('#txtcoursecode').val();
        var course_cancel_flag = course_publish_status;
        var inst_code = cur_tr.find(".drpinstructor").val();

        
        if (inst_code == '')
        {
            bootbox.alert('Please Select Instructor')
            return false;
        }
        if (per_load == '') {
            bootbox.alert('Please Enter Average Contact hours');
            return false;
        }

        if (total_weeks == '') {
            bootbox.alert('Please Enter Total Weeks');
            return false;
        }
        var sem_code = '';
        var year_code = '';
        if ($('#hdn_s').val() != '') {
            sem_code = $('#hdn_s').val();
        }
        else if ($('#drpsemester').val() != '') {
            sem_code = $('#drpsemester').val();
        }
        if ($('#hdn_y').val() != '') {
            year_code = $('#hdn_y').val();
        }
        else if ($('#drpyear').val() != '') {
            year_code = $('#drpyear').val();
        }
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/instructor_wise_Rateband_update",
            async: false,
            data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code : '" + course_code + "',total_weeks : '" + total_weeks + "',total_contact_hrs : '" + total_contact_hrs + "',total_hrs : '" + total_contact_hrs + "',total_hrs_in_semester : '" + total_hrs_in_semester + "',instructor_code : '" + instructor_code + "',inst_type:'" + inst_type + "',course_cancel_flag:'" + course_cancel_flag + "',add_hrs:'" + add_hrs +"'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "")
                {
                    if (data.d == true) {
                        bootbox.alert("Data Save Successfully");
                    }
                    return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });

        
    });


    $('#tblinstructor_ta tbody tr td input.but_save_ta').live('click', function (e) {
        cur_tr = $(this).closest('tr');
        var per_load = cur_tr.find('.per_load').val();
        var total_weeks = cur_tr.find('.week').val();
        var total_contact_hrs = cur_tr.find('.per_load').val();
        var total_hrs_in_semester = cur_tr.find('.total_hrs').val();
        var add_hrs = cur_tr.find('.add_hrs').val();
        var instructor_code = cur_tr.find('.drpinstructor_tutorial').val();
        var inst_type = e.currentTarget.id;
        var course_code = $('#txtcoursecode').val();
        var course_cancel_flag = course_publish_status;
        var inst_code = cur_tr.find(".drpinstructor").val();
        var inst_code_multiple = '';
        var sem_code = '';
        var year_code = '';
        if ($('#hdn_s').val() != '') {
            sem_code = $('#hdn_s').val();
        }
        else if ($('#drpsemester').val() != '') {
            sem_code = $('#drpsemester').val();
        }
        if ($('#hdn_y').val() != '') {
            year_code = $('#hdn_y').val();
        }
        else if ($('#drpyear').val() != '') {
            year_code = $('#drpyear').val();
        }

        if (inst_code == '') {
            bootbox.alert('Please Select Instructor')
            return false;
        }
        if (per_load == '') {
            bootbox.alert('Please Enter Average Contact hours');
            return false;
        }

        if (total_weeks == '') {
            bootbox.alert('Please Enter Total Weeks');
            return false;
        }
       // var instructor_data_inst_code = [];
       // $("#tblinstructor_ta tbody tr").each(function (j) {
       //     var instructor_code = { 'instructor_code': '' };
       //     instructor_code.instructor_code = $(this).find(".drpinstructor_tutorial").val();
       //     instructor_data_inst_code.push(instructor_code);
       // });
        //var instructor_data_TA = [];
        //$("#tblinstructor_ta tbody tr").each(function (j) {
        //    var instructor_data = { 'instructor_code': '', 'percent_load': '', 'week': '', 'total_hrs': '', 'additional_hours': '' };
        //
        //    instructor_data.instructor_code = $(this).find(".drpinstructor_tutorial").val();
        //    //02052022
        //    instructor_data.percent_load = $(this).find(".per_load").val();
        //    instructor_data.week = $(this).find(".week").val();
        //    instructor_data.total_hrs = $(this).find(".total_hrs").val();
        //    instructor_data.additional_hours = $(this).find(".add_hrs").val();
        //
        //    instructor_data_TA.push(instructor_data);
        //});
        //var All_table_course_data = [instructor_data_TA, instructor_data_inst_code];
        //var json_All_table_course_data = JSON.stringify(All_table_course_data);
        //
        //if (json_All_table_course_data.search("'") != -1) {
        //    json_All_table_course_data = json_All_table_course_data.replace(/\'/g, '\\\'');
        //}

        
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/instructor_wise_Rateband_update",
           // url: "../../WebService.asmx/update_ta_workload_data",
            async: false,
            data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code : '" + course_code + "',total_weeks : '" + total_weeks + "',total_contact_hrs : '" + total_contact_hrs + "',total_hrs : '" + total_contact_hrs + "',total_hrs_in_semester : '" + total_hrs_in_semester + "',instructor_code : '" + instructor_code + "',inst_type:'" + inst_type + "',course_cancel_flag:'" + course_cancel_flag + "',add_hrs:'" + add_hrs +"'}",
            //data: "{ All_table_course_data: '" + json_All_table_course_data + "', sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code : '" + course_code + "',instructor_code : '" + instructor_code + "',total_weeks : '" + total_weeks + "',total_contact_hrs : '" + total_contact_hrs + "',total_hrs : '" + total_contact_hrs + "',total_hrs_in_semester : '" + total_hrs_in_semester + "',inst_type:'" + inst_type + "',course_cancel_flag:'" + course_cancel_flag + "',add_hrs:'" + add_hrs + "',current_inst_code :'" + instructor_code+"'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == true) {
                        bootbox.alert("Data Save Successfully");
                    }
                    return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });


    });

    $('#tblinstructor_aa tbody tr td input.but_save_aa').live('click', function (e) {
        //alert(e.currentTarget.id);
        cur_tr = $(this).closest('tr');
        var per_load = cur_tr.find('.per_load').val();
        var total_weeks = cur_tr.find('.week').val();
        var total_contact_hrs = cur_tr.find('.per_load').val();
        var total_hrs_in_semester = cur_tr.find('.total_hrs').val();
        var add_hrs = cur_tr.find('.add_hrs').val();
        var instructor_code = cur_tr.find('.drpinstructor_tutorial').val();
        var inst_type = e.currentTarget.id;
        var course_code = $('#txtcoursecode').val();
        var course_cancel_flag = course_publish_status;
        var inst_code = cur_tr.find(".drpinstructor").val();
        if (inst_code == '') {
            bootbox.alert('Please Select Instructor')
            return false;
        }

        if (per_load == '') {
            bootbox.alert('Please Enter Average Contact hours');
            return false;
        }

        if (total_weeks == '') {
            bootbox.alert('Please Enter Total Weeks');
            return false;
        }
        var sem_code = '';
        var year_code = '';
        if ($('#hdn_s').val() != '') {
            sem_code = $('#hdn_s').val();
        }
        else if ($('#drpsemester').val() != '') {
            sem_code = $('#drpsemester').val();
        }
        if ($('#hdn_y').val() != '') {
            year_code = $('#hdn_y').val();
        }
        else if ($('#drpyear').val() != '') {
            year_code = $('#drpyear').val();
        }

        //var instructor_data_inst_code = [];
        //$("#tblinstructor_aa tbody tr").each(function (j) {
        //    var instructor_code = { 'instructor_code': '' };
        //    instructor_code.instructor_code = $(this).find(".drpinstructor_tutorial").val();
        //    instructor_data_inst_code.push(instructor_code);
        //});
        //var instructor_data_AA = [];
        //$("#tblinstructor_aa tbody tr").each(function (j) {
        //    var instructor_data = { 'instructor_code': '', 'percent_load': '', 'week': '', 'total_hrs': '', 'additional_hours': '' };
        //
        //    instructor_data.instructor_code = $(this).find(".drpinstructor_tutorial").val();
        //    //02052022
        //    instructor_data.percent_load = $(this).find(".per_load").val();
        //    instructor_data.week = $(this).find(".week").val();
        //    instructor_data.total_hrs = $(this).find(".total_hrs").val();
        //    instructor_data.additional_hours = $(this).find(".add_hrs").val();
        //
        //    instructor_data_AA.push(instructor_data);
        //});
        //var All_table_course_data = [instructor_data_AA, instructor_data_inst_code];
        //var json_All_table_course_data = JSON.stringify(All_table_course_data);
        //
        //if (json_All_table_course_data.search("'") != -1) {
        //    json_All_table_course_data = json_All_table_course_data.replace(/\'/g, '\\\'');
        //}


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/instructor_wise_Rateband_update",
            //url: "../../WebService.asmx/update_aa_workload_data",
            async: false,
            //data: "{ All_table_course_data: '" + json_All_table_course_data + "', sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code : '" + course_code + "',instructor_code : '" + instructor_code + "',total_weeks : '" + total_weeks + "',total_contact_hrs : '" + total_contact_hrs + "',total_hrs : '" + total_contact_hrs + "',total_hrs_in_semester : '" + total_hrs_in_semester + "',inst_type:'" + inst_type + "',course_cancel_flag:'" + course_cancel_flag + "',add_hrs:'" + add_hrs + "',current_inst_code :'" + instructor_code +"'}",
            data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code : '" + course_code + "',total_weeks : '" + total_weeks + "',total_contact_hrs : '" + total_contact_hrs + "',total_hrs : '" + total_contact_hrs + "',total_hrs_in_semester : '" + total_hrs_in_semester + "',instructor_code : '" + instructor_code + "',inst_type:'" + inst_type + "',course_cancel_flag:'" + course_cancel_flag + "',add_hrs:'" + add_hrs +"'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == true) {
                        bootbox.alert("Data Save Successfully");
                    }
                    return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });


    });


    function InstructorImages(selected_instructor) {

        var selected_instructor = "\'" + selected_instructor + "\'";
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_tutor_image_data",
            //data: "{instructor_code : '"+ selected_instructor + "'}",
            data: JSON.stringify({ "instructor_code": selected_instructor }),
            dataType: "json",
            success: function (data) {
                var imgurl;
                if (data.d != "") {
                    var profile_data = JSON.parse(data.d);
                    var dialogDiv = $(document.createElement('div'));
                    var photo = profile_data[0]['profile_photo'];
                    if (photo != null && photo != "") {
                        if (profile_data[0]['profile_photo'].indexOf("/") >= 0) {
                            imgurl = profile_data[i]['profile_photo'];
                        }
                        else {
                            imgurl = "../../UserPersonalPhoto/" + profile_data[0]['profile_photo'] + "";
                        }
                    }
                    else {
                        imgurl = "https://connect.cept.ac.in/UserProfilePhoto/Default_Avtar.png";
                    }
                    dialogDiv.append('<div style="width:70%; float:left;"><b>Name: ' + profile_data[0]['user_name'] + '</b></br><b>Email: ' + profile_data[0]['mail'] + '</b></div><div style="float:right;"><img id="theImg" src="' + imgurl + '"style="width:105px;height:110px;"/></div>');
                    dialogDiv.dialog();
                    $('.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front.ui-draggable.ui-resizable').css("width", "500px");
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }

    $('#btnRetrieve').click(function () {
        btn_ret_new_flag = true;
        var new_course_time_data_get = '';
        var new_course_inst_data = '';
        var new_course_TA_data = '';
        var new_course_AA_data = '';
        var sem_code = $('#drpsemester').val();
        
        $('#tblinstructor_time_slot tbody').html('');

        if (sem_code == '') {
            bootbox.alert('Please select semester');
            return false;
        }

        var year_code = $('#drpyear').val();

        if (year_code == '') {
            bootbox.alert('Please select year');
            return false;
        }

        var course_code = $('#drcourses').val();

        if (course_code == '') {
            //bootbox.alert('Please select course');
            bootbox.alert('Approval is pending at TLC Level. Please contact TLC.');
            return false;
        }
       //course_wise_ta();

        for (var i = 1; i <= $('#div_chk_prerequisite').find('input[type=checkbox]').length; i++) {
            $('#chk_pre' + i).prop('checked', false);
        }

        $('#txtcourse_prerequisite').css('display', 'none');
        $('#divPreCourseCode').css('display', 'none');
        $('#tbl_course_assessment tbody').html('');
        $('#tbl_course_image tbody').html('');
        obj_FileName = [];
        var progra_level_code_new = '';
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_all_tables_course_data",
            async: false,
            data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code:'" + course_code + "'}",
            dataType: "json",
            success: function (data) {
                
                temp_typology = '';
                temp_sub_group_typology = '';
                temp_focus_of_studio = '';
                temp_focus_of_studio_secondary = '';

                if (data.d[0] != null) {

                    var course_data = JSON.parse(data.d[0]);

                    var course_weekly_percent_criteria = JSON.parse(data.d[9])
                    //This Condtion Remove By Nitinbhai 09062023 
                    // old condtion if ($("#hdn_utype").val() == 'FA' && (course_data[0]["progcoordinate_approved"] == "Y" || course_data[0]["ugpgoffice_approved"] == "Y"))
                    if ($("#hdn_utype").val() == 'FA' && course_data[0]["ugpgoffice_approved"] == "Y")
                    {
                        $("#submitBtnDiv").remove();
                       
                    }

                    $('#hdn_faculty_flag').val(course_data[0]["faculty_approved"]);
                    $('#hdn_pc_flag').val(course_data[0]["progcoordinate_approved"]);
                    $('#hdn_ugpg_flag').val(course_data[0]["ugpgoffice_approved"]);

                    $('#hdn_dno').val(course_data[0]["doc_no"]);
                    $('#hdn_ccode').val(course_data[0]["course_code"]);
                    $('#hdn_sem').val(course_data[0]["semester_type"]);
                    $('#hdn_year').val(course_data[0]["year_semester"]);
                    $('#drp_gpa_ngpa').val(course_data[0]["gpa_ngpa"]);
                    //$('#drp_gpa_ngpa').trigger("liszt:updated");
                    $('#txtcoursecode').val(course_data[0]["course_code"]);
                    $('#txtcoursename').val(course_data[0]["course_name"]);
                    $('#txtcredits').val(course_data[0]["course_credits"]);
                    $('#txtcourse_description').val(course_data[0]["course_desc"]);
                    $('#txtcourse_studiosubtitle').val(course_data[0]["CouseSubTitle"]);



                    $('#spn_desc1').html('' + 'Total Char : ' + (course_data[0]["CouseSubTitle"].length));//1380 Mayur 12092019
                    if (course_data[0]["CouseSubTitle"].length > 700) {//1380
                        $('#spn_desc1').css('color', 'red');
                    } else {
                        $('#spn_desc1').css('color', 'black');
                    }
                    if (course_data[0]["CouseSubTitle"] == '') {
                        $('#word_desc1').html('' + 'Total Word : ' + (0));
                    }
                    else { $('#word_desc1').html('' + 'Total Word : ' + (course_data[0]["CouseSubTitle"].split(' ').length)); }

                    if (course_data[0]["CouseSubTitle"].split(' ').length > 100) {
                        $('#word_desc1').css('color', 'red');
                    } else {
                        $('#word_desc1').css('color', 'black');
                    }





                    //$('#spn_desc').html('' + 'Total Char : ' + (1300 - course_data[0]["course_desc"].length));
                    //if ((1300 - course_data[0]["course_desc"].length) == 0) {
                    //    $('#spn_desc').css('color', 'red');
                    //} else {
                    //    $('#spn_desc').css('color', 'black');
                    //}

                    $('#spn_desc').html('' + 'Total Char : ' + (course_data[0]["course_desc"].length));//1380 Mayur 12092019
                    if (course_data[0]["course_desc"].length > 1300) {//1380
                        $('#spn_desc').css('color', 'red');
                    } else {
                        $('#spn_desc').css('color', 'black');
                    }

                    //06042022

                    if (course_data[0]["course_desc"] == '') {
                        $('#word_desc').html('' + 'Total Word : ' + (0));
                    }
                    else { $('#word_desc').html('' + 'Total Word : ' + (course_data[0]["course_desc"].split(' ').length)); }

                    if (course_data[0]["course_desc"].split(' ').length > 150) {
                        $('#word_desc').css('color', 'red');
                    } else {
                        $('#word_desc').css('color', 'black');
                    }


                    if (course_data[0]["prerequisite"] != "") {
                        //var obj_prerequisite = JSON.parse(course_data[0]["prerequisite"]);
                        var obj_prerequisite = JSON.parse(course_data[0]["prerequisite"].replace(/[\n]/g, ' '));

                        if (obj_prerequisite["chkbox"] != "") {
                            var split_chk_data = obj_prerequisite["chkbox"].split('~');

                            for (var i = 0; i < split_chk_data.length; i++) {
                                $('#' + split_chk_data[i]).prop('checked', true);
                            }

                            if (document.getElementById('chk_pre10').checked) {
                                $('#txtcourse_prerequisite').css('display', 'block');
                            }
                        }

                        if (obj_prerequisite["other"] != "") {
                            $('#chk_pre10').prop('checked', true);

                            $('#txtcourse_prerequisite').val(obj_prerequisite["other"]);
                            $('#txtcourse_prerequisite').css('display', 'block');
                        }

                        if (obj_prerequisite["pre_course_code"] != undefined && obj_prerequisite["pre_course_code"] != "") {
                            $('#chk_pre11').prop('checked', true);

                            $('#drpallprecourse').val(obj_prerequisite["pre_course_code"]);

                            if ($("#hdn_utype").val() != 'CW') {
                                $('#drpallprecourse').trigger("liszt:updated");
                            }

                            $('#divPreCourseCode').css('display', 'block');
                        }
                        else {
                            $('#chk_pre11').prop('checked', false);
                            $('#divPreCourseCode').css('display', 'none');
                        }
                    }

                    $('#txtcourse_outline').val(course_data[0]["course_outline"]);
                    $('#spn_long_desc').html('' + 'Total Char : ' + (course_data[0]["course_outline"].length));//3000 Mayur 12092019
                    if (course_data[0]["course_outline"].length > 3000) {//1380
                        $('#spn_long_desc').css('color', 'red');
                    } else {
                        $('#spn_long_desc').css('color', 'black');
                    }


                    //06042022

                    if (course_data[0]["course_outline"] == '') {
                        $('#spn_long_word').html('' + 'Total Word : ' + (0));
                    }
                    else { $('#spn_long_word').html('' + 'Total Word : ' + (course_data[0]["course_outline"].split(' ').length)); }

                    if (course_data[0]["course_outline"].split(' ').length > 600) {
                        $('#spn_long_word').css('color', 'red');
                    } else {
                        $('#spn_long_word').css('color', 'black');
                    }

                    $('#txtremarks').val(course_data[0]["remark"]);

                    if (course_data[0]["instructor_contact_hrs"] != "") {
                        $('#drp_contact_hrs').val(course_data[0]["instructor_contact_hrs"]);
                    }
                    else {
                        //$('#drp_contact_hrs').val('PR');
                        $('#drp_contact_hrs').val('');
                    }

                    $('#drptype').val(course_data[0]["course_type"]);

                    if ($("#drptype").val() == 'M') {
                        // alert(course_data[0]["project"]);
                        $("#spn_project,#drpproject").css('display', 'inline-block');
                        // $('#drpproject').val('0');
                        $('#drpproject').val(course_data[0]["project"]);

                        if (course_data[0]["project"] == 'Y') {
                            $("#spn_project_name,#txt_project_name").css('display', 'inline-block');
                            $("#txt_project_name").val(course_data[0]["project_name"]);
                        }
                        else {
                            $('#drpproject').val('N');
                            $("#spn_project_name,#txt_project_name").css('display', 'none');
                        }
                    }
                    else {
                        $("#spn_project,#drpproject").css('display', 'none');
                        $("#spn_project_name,#txt_project_name").css('display', 'none');
                        $('#drpproject').val('0');
                    }

                    //$("#txtroomid").val(course_data[0]["room_id"]);
                    if (course_data[0]["tutorial_offered"] == 'Y') $('input[type=radio][name=rdo_tutorial_offered][value=Y]')[0].checked = true;
                    else $('input[type=radio][name=rdo_tutorial_offered][value=N]')[0].checked = true;

                    if (course_data[0]["backlog"] == 'Y') $('input[type=radio][name=rdo_backlog][value=Y]')[0].checked = true;
                    else $('input[type=radio][name=rdo_backlog][value=N]')[0].checked = true; //Mayur 30042019

                    //$('#txt_tutor_description').val(course_data[0]["tutor_description"]) // Returned By Ananth

                    $('#txt_week1').val(course_data[0]["week1"]);
                    $('#txt_week2').val(course_data[0]["week2"]);
                    $('#txt_week3').val(course_data[0]["week3"]);
                    $('#txt_week4').val(course_data[0]["week4"]);
                    $('#txt_week5').val(course_data[0]["week5"]);
                    $('#txt_week6').val(course_data[0]["week6"]);
                    $('#txt_week7').val(course_data[0]["week7"]);
                    $('#txt_week8').val(course_data[0]["week8"]);
                    $('#txt_week9').val(course_data[0]["week9"]);
                    $('#txt_week10').val(course_data[0]["week10"]);
                    $('#txt_week11').val(course_data[0]["week11"]);
                    $('#txt_week12').val(course_data[0]["week12"]);
                    $('#txt_week13').val(course_data[0]["week13"]);
                    $('#txt_week14').val(course_data[0]["week14"]);
                    $('#txt_week15').val(course_data[0]["week15"]);
                    $('#txt_week16').val(course_data[0]["week16"]);

                    $('#txt_week_reference1').val(course_data[0]["week_reference1"]);
                    $('#txt_week_reference2').val(course_data[0]["week_reference2"]);
                    $('#txt_week_reference3').val(course_data[0]["week_reference3"]);
                    $('#txt_week_reference4').val(course_data[0]["week_reference4"]);
                    $('#txt_week_reference5').val(course_data[0]["week_reference5"]);
                    $('#txt_week_reference6').val(course_data[0]["week_reference6"]);
                    $('#txt_week_reference7').val(course_data[0]["week_reference7"]);
                    $('#txt_week_reference8').val(course_data[0]["week_reference8"]);
                    $('#txt_week_reference9').val(course_data[0]["week_reference9"]);
                    $('#txt_week_reference10').val(course_data[0]["week_reference10"]);
                    $('#txt_week_reference11').val(course_data[0]["week_reference11"]);
                    $('#txt_week_reference12').val(course_data[0]["week_reference12"]);
                    $('#txt_week_reference13').val(course_data[0]["week_reference13"]);
                    $('#txt_week_reference14').val(course_data[0]["week_reference14"]);
                    $('#txt_week_reference15').val(course_data[0]["week_reference15"]);
                    $('#txt_week_reference16').val(course_data[0]["week_reference16"]);

                    $('#txt_week_assignment1').val(course_data[0]["week_assignment1"]);
                    $('#txt_week_assignment2').val(course_data[0]["week_assignment2"]);
                    $('#txt_week_assignment3').val(course_data[0]["week_assignment3"]);
                    $('#txt_week_assignment4').val(course_data[0]["week_assignment4"]);
                    $('#txt_week_assignment5').val(course_data[0]["week_assignment5"]);
                    $('#txt_week_assignment6').val(course_data[0]["week_assignment6"]);
                    $('#txt_week_assignment7').val(course_data[0]["week_assignment7"]);
                    $('#txt_week_assignment8').val(course_data[0]["week_assignment8"]);
                    $('#txt_week_assignment9').val(course_data[0]["week_assignment9"]);
                    $('#txt_week_assignment10').val(course_data[0]["week_assignment10"]);
                    $('#txt_week_assignment11').val(course_data[0]["week_assignment11"]);
                    $('#txt_week_assignment12').val(course_data[0]["week_assignment12"]);
                    $('#txt_week_assignment13').val(course_data[0]["week_assignment13"]);
                    $('#txt_week_assignment14').val(course_data[0]["week_assignment14"]);
                    $('#txt_week_assignment15').val(course_data[0]["week_assignment15"]);
                    $('#txt_week_assignment16').val(course_data[0]["week_assignment16"]);

                    //Returned By Ananth
                    //$('#problem_statement').val(course_data[0]["problem_statement"]); // 10-06-2019
                    $('#problem_statement').val(''); // 10-06-2019

                    //$('#spn_ps').html('' + 'Total Char : ' + (400 - course_data[0]["problem_statement"].length));//Mayur 12092019
                    //if ((400 - course_data[0]["problem_statement"].length) == 0) {
                    //    $('#spn_ps').css('color', 'red');
                    //} else {
                    //    $('#spn_ps').css('color', 'black');
                    //}

                    $('#spn_ps').html('' + 'Total Char : ' + (course_data[0]["problem_statement"].length));//Mayur 12092019
                    if ((course_data[0]["problem_statement"].length) > 400) {
                        $('#spn_ps').css('color', 'red');
                    } else {
                        $('#spn_ps').css('color', 'black');
                    }

                    if (data.d[9] != null) {
                        $('#txt_week_per1').val(course_weekly_percent_criteria[0]["week_assignment_per1"]);
                        $('#txt_week_per2').val(course_weekly_percent_criteria[0]["week_assignment_per2"]);
                        $('#txt_week_per3').val(course_weekly_percent_criteria[0]["week_assignment_per3"]);
                        $('#txt_week_per4').val(course_weekly_percent_criteria[0]["week_assignment_per4"]);
                        $('#txt_week_per5').val(course_weekly_percent_criteria[0]["week_assignment_per5"]);
                        $('#txt_week_per6').val(course_weekly_percent_criteria[0]["week_assignment_per6"]);
                        $('#txt_week_per7').val(course_weekly_percent_criteria[0]["week_assignment_per7"]);
                        $('#txt_week_per8').val(course_weekly_percent_criteria[0]["week_assignment_per8"]);
                        $('#txt_week_per9').val(course_weekly_percent_criteria[0]["week_assignment_per9"]);
                        $('#txt_week_per10').val(course_weekly_percent_criteria[0]["week_assignment_per10"]);
                        $('#txt_week_per11').val(course_weekly_percent_criteria[0]["week_assignment_per11"]);
                        $('#txt_week_per12').val(course_weekly_percent_criteria[0]["week_assignment_per12"]);
                        $('#txt_week_per13').val(course_weekly_percent_criteria[0]["week_assignment_per13"]);
                        $('#txt_week_per14').val(course_weekly_percent_criteria[0]["week_assignment_per14"]);
                        $('#txt_week_per15').val(course_weekly_percent_criteria[0]["week_assignment_per15"]);
                        $('#txt_week_per16').val(course_weekly_percent_criteria[0]["week_assignment_per16"]);

                        $('#txt_week_crt1').val(course_weekly_percent_criteria[0]["week_assignment_crt1"]);
                        $('#txt_week_crt2').val(course_weekly_percent_criteria[0]["week_assignment_crt2"]);
                        $('#txt_week_crt3').val(course_weekly_percent_criteria[0]["week_assignment_crt3"]);
                        $('#txt_week_crt4').val(course_weekly_percent_criteria[0]["week_assignment_crt4"]);
                        $('#txt_week_crt5').val(course_weekly_percent_criteria[0]["week_assignment_crt5"]);
                        $('#txt_week_crt6').val(course_weekly_percent_criteria[0]["week_assignment_crt6"]);
                        $('#txt_week_crt7').val(course_weekly_percent_criteria[0]["week_assignment_crt7"]);
                        $('#txt_week_crt8').val(course_weekly_percent_criteria[0]["week_assignment_crt8"]);
                        $('#txt_week_crt9').val(course_weekly_percent_criteria[0]["week_assignment_crt9"]);
                        $('#txt_week_crt10').val(course_weekly_percent_criteria[0]["week_assignment_crt10"]);
                        $('#txt_week_crt11').val(course_weekly_percent_criteria[0]["week_assignment_crt11"]);
                        $('#txt_week_crt12').val(course_weekly_percent_criteria[0]["week_assignment_crt12"]);
                        $('#txt_week_crt13').val(course_weekly_percent_criteria[0]["week_assignment_crt13"]);
                        $('#txt_week_crt14').val(course_weekly_percent_criteria[0]["week_assignment_crt14"]);
                        $('#txt_week_crt15').val(course_weekly_percent_criteria[0]["week_assignment_crt15"]);
                        $('#txt_week_crt16').val(course_weekly_percent_criteria[0]["week_assignment_crt16"]);


                        //$('#lbl_week_img_1').text(course_weekly_percent_criteria[0]["week_exercises1"]);
                        //$('#lbl_week_img_2').text(course_weekly_percent_criteria[0]["week_exercises2"]);
                        //$('#lbl_week_img_3').text(course_weekly_percent_criteria[0]["week_exercises3"]);
                        //$('#lbl_week_img_4').text(course_weekly_percent_criteria[0]["week_exercises4"]);
                        //$('#lbl_week_img_5').text(course_weekly_percent_criteria[0]["week_exercises5"]);
                        //$('#lbl_week_img_6').text(course_weekly_percent_criteria[0]["week_exercises6"]);
                        //$('#lbl_week_img_7').text(course_weekly_percent_criteria[0]["week_exercises7"]);
                        //$('#lbl_week_img_8').text(course_weekly_percent_criteria[0]["week_exercises8"]);
                        //$('#lbl_week_img_9').text(course_weekly_percent_criteria[0]["week_exercises9"]);
                        //$('#lbl_week_img_10').text(course_weekly_percent_criteria[0]["week_exercises10"]);
                        //$('#lbl_week_img_11').text(course_weekly_percent_criteria[0]["week_exercises11"]);
                        //$('#lbl_week_img_12').text(course_weekly_percent_criteria[0]["week_exercises12"]);
                        //$('#lbl_week_img_13').text(course_weekly_percent_criteria[0]["week_exercises13"]);
                        //$('#lbl_week_img_14').text(course_weekly_percent_criteria[0]["week_exercises14"]);
                        //$('#lbl_week_img_15').text(course_weekly_percent_criteria[0]["week_exercises15"]);
                        //$('#lbl_week_img_16').text(course_weekly_percent_criteria[0]["week_exercises16"]);
                        $('#lbl_week_img_1').text('');
                        $('#lbl_week_img_2').text('');
                        $('#lbl_week_img_3').text('');
                        $('#lbl_week_img_4').text('');
                        $('#lbl_week_img_5').text('');
                        $('#lbl_week_img_6').text('');
                        $('#lbl_week_img_7').text('');
                        $('#lbl_week_img_8').text('');
                        $('#lbl_week_img_9').text('');
                        $('#lbl_week_img_10').text('');
                        $('#lbl_week_img_11').text('');
                        $('#lbl_week_img_12').text('');
                        $('#lbl_week_img_13').text('');
                        $('#lbl_week_img_14').text('');
                        $('#lbl_week_img_15').text('');
                        $('#lbl_week_img_16').text('');


                    } else {
                        $('#txt_week_per1').val('');
                        $('#txt_week_per2').val('');
                        $('#txt_week_per3').val('');
                        $('#txt_week_per4').val('');
                        $('#txt_week_per5').val('');
                        $('#txt_week_per6').val('');
                        $('#txt_week_per7').val('');
                        $('#txt_week_per8').val('');
                        $('#txt_week_per9').val('');
                        $('#txt_week_per10').val('');
                        $('#txt_week_per11').val('');
                        $('#txt_week_per12').val('');
                        $('#txt_week_per13').val('');
                        $('#txt_week_per14').val('');
                        $('#txt_week_per15').val('');
                        $('#txt_week_per16').val('');

                        $('#txt_week_crt1').val('');
                        $('#txt_week_crt2').val('');
                        $('#txt_week_crt3').val('');
                        $('#txt_week_crt4').val('');
                        $('#txt_week_crt5').val('');
                        $('#txt_week_crt6').val('');
                        $('#txt_week_crt7').val('');
                        $('#txt_week_crt8').val('');
                        $('#txt_week_crt9').val('');
                        $('#txt_week_crt10').val('');
                        $('#txt_week_crt11').val('');
                        $('#txt_week_crt12').val('');
                        $('#txt_week_crt13').val('');
                        $('#txt_week_crt14').val('');
                        $('#txt_week_crt15').val('');
                        $('#txt_week_crt16').val('');


                        $('#lbl_week_img_1').text('');
                        $('#lbl_week_img_2').text('');
                        $('#lbl_week_img_3').text('');
                        $('#lbl_week_img_4').text('');
                        $('#lbl_week_img_5').text('');
                        $('#lbl_week_img_6').text('');
                        $('#lbl_week_img_7').text('');
                        $('#lbl_week_img_8').text('');
                        $('#lbl_week_img_9').text('');
                        $('#lbl_week_img_10').text('');
                        $('#lbl_week_img_11').text('');
                        $('#lbl_week_img_12').text('');
                        $('#lbl_week_img_13').text('');
                        $('#lbl_week_img_14').text('');
                        $('#lbl_week_img_15').text('');
                        $('#lbl_week_img_16').text('');
                    }
                    //14032022
                    for (var o = 1; o <= 16; o++) {
                        if (course_weekly_percent_criteria != null)
                        {
                            if (course_weekly_percent_criteria[0]["week_exercises" + o] != "") {
                                //$('#lbl_week_img_name_' + o).text('week' + o);
                                $('#lbl_week_img_' + o).text('');
                            }
                            else {
                                $('#lbl_week_img_name_' + o).text('');
                                $('#lbl_week_img_' + o).text('');
                            }
                        }
                        
                    }

                    //$('#txtcourse_structure').val(course_data[0]["course_structure"]);
                    CKEDITOR.instances.txtcourse_structure.setData(course_data[0]["course_structure"]);

                    //$('#txt_reference').val(course_data[0]["remark"]);
                    CKEDITOR.instances.txt_reference.setData(course_data[0]["remark"]);

                    $('#txt_evalmethod').val(course_data[0]["eval_method1"]);
                    //$('#txt_evalmethod2').val(course_data[0]["eval_method2"]);
                    //$('#txt_evalmethod3').val(course_data[0]["eval_method3"]);
                    //$('#txt_evalmethod4').val(course_data[0]["eval_method4"]);
                    //$('#txt_evalmethod5').val(course_data[0]["eval_method5"]);

                    //$('#txt_evalmethod_weightage1').val(course_data[0]["eval_method_weightage1"]);
                    //$('#txt_evalmethod_weightage2').val(course_data[0]["eval_method_weightage2"]);
                    //$('#txt_evalmethod_weightage3').val(course_data[0]["eval_method_weightage3"]);
                    //$('#txt_evalmethod_weightage4').val(course_data[0]["eval_method_weightage4"]);
                    //$('#txt_evalmethod_weightage5').val(course_data[0]["eval_method_weightage5"]);

                    if (course_data[0]["eval_method5"] != '') {
                        var course_outcome = JSON.parse(course_data[0]["eval_method5"]);

                        $('#txtcourse_outcome1').val(course_outcome['course_outcome1']);
                        $('#txtcourse_outcome2').val(course_outcome['course_outcome2']);
                        $('#txtcourse_outcome3').val(course_outcome['course_outcome3']);
                        $('#txtcourse_outcome4').val(course_outcome['course_outcome4']);
                        $('#txtcourse_outcome5').val(course_outcome['course_outcome5']);
                    }

                    $('#txt_course_expense').val(course_data[0]['course_expense']);

                    //if (course_data[0]["course_assessment"] != '' && course_data[0]["course_assessment"] != '[]') {
                    //    var obj_course_assessment = JSON.parse(course_data[0]["course_assessment"]);

                    //    for (var i = 0; i < obj_course_assessment.length; i++) {
                    //        $('#btn_add_course_assessment').click();

                    //        var row = $('#tbl_course_assessment tbody tr').eq(i);

                    //        row.find('.cls_exercises').val(obj_course_assessment[i]['exercise']);
                    //        row.find('.cls_percentage').val(obj_course_assessment[i]['percentage']);
                    //        row.find('.cls_criteria').val(obj_course_assessment[i]['criteria']);
                    //    }
                    //}

                    if (course_data[0]["eval_method4"] != '' && course_data[0]["eval_method4"] != '[]') {
                        var obj_course_img = JSON.parse(course_data[0]["eval_method4"]);

                        for (var i = 0; i < obj_course_img.length; i++) {
                            $('#btn_add_course_image').click();
                            $('#lbl_courseimage_file_name' + (i + 1)).html(obj_course_img[i]['img_name']);
                            $('#txt_image_caption' + (i + 1)).val(obj_course_img[i]['img_caption']);
                            var image_dtl = { 'image_id': (i + 1), 'image_name': obj_course_img[i]['img_name'] };
                            obj_FileName.push(image_dtl);
                        }
                    }

                    $('#txt_prep_self_hrs').val(course_data[0]["prep_self_study_hrs"]);
                    $('#studio_mode').val(course_data[0]["studio_mode"]);

                    //$('#spn_desc').html('' + 'Total Char : ' + $('#txtcourse_description').val().length);
                    $('#drptype').trigger("liszt:updated");
                    
                }

                if (data.d[1] != null) {
                    var course_dept_data = JSON.parse(data.d[1]);
                    $('#drp_semester').val(course_dept_data[0]["semester_code"]);
                    $('#drpdepartment').val(course_dept_data[0]["dept_code"]);
                    $('#drpprog').val(course_dept_data[0]["prog_code"]);
                    $('#drpproglevel').val(course_dept_data[0]["prog_level_code"]);
                    progra_level_code_new = course_dept_data[0]["prog_level_code"];
                    $('#drptypology').val(course_dept_data[0]["course_typology"]);
                    temp_typology = course_dept_data[0]["course_typology"];
                    $('#drp_color').val(course_dept_data[0]["prog_course_id"]);

                    temp_sub_group_typology = course_dept_data[0]["sub_category_id"];
                    temp_focus_of_studio = course_dept_data[0]["focus_studio"];
                    temp_focus_of_studio_secondary = course_dept_data[0]["secondary_focus_studio"];

                    //$('#drpsubtypology').val(course_dept_data[0]["sub_category_id"]); // Returned By Ananth

                    $('#txtavailable_seats').val(course_dept_data[0]["available_seat"]);

                    if ($('#drpproglevel').val() != '' || $('#drpprog').val() == '2' || $('#drpprog').val() == '3') {
                        $("#spn_proglvl").css('display', 'block');

                        if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
                            $("#drpproglevel_chzn").css('display', 'block');
                        }
                        else {
                            $("#drpproglevel").css('display', 'block');
                        }
                    }

                    if ($('#txt_project_name').val() != '') {
                        prog_name_flag = true;
                    }
                    bind_program_level_code();
                    $('#drpproglevel').val(course_dept_data[0]["prog_level_code"]);
                    count = 1;
                    $('#drp_semester,#drpdepartment,#drpprog,#drptypology,#drpproglevel,#drp_color').trigger("liszt:updated");
                    $('#drpprog').trigger('change');
                   
                    //changes 19052022
                    if (temp_typology == '24') {
                        $('#single_show').css('display', 'none');
                        $('#dual_show').css('display', 'none');
                        $('#course_panel_show').css('display', 'block');
                        $('#studio_panel_showing').css('display', 'none');
                        $('#course_text').css('display', 'block');
                        $('#studio_text').css('display', 'none');

                        $('#textsubtitle').css('display', 'none');

                        $('#rdo_d').prop('checked', false);
                        $('#rdo_s').prop('checked', false);
                        // This changes by nitinbhai 20-11-2024
                        if (parseInt($('#drpyear').val()) >= 2025)
                        {
                            $("#tutor_type_select").hide();
                        }
                        else
                        {
                            $("#tutor_type_select").show();
                        }
                        
                        
                        $("#tutor_type_select_ta").show();
                        $("#studio_type_select").hide();

                        if (course_data[0]["hrs_group_id"] != '') {
                            if (course_data[0]["hrs_group_id"] == 'WT002')
                            {
                                //$('#rdo_t').prop('checked', false);
                                $('#rdo_ta_y').prop('checked', true);
                            }
                            if (course_data[0]["hrs_group_id"] == 'WT003')
                            {
                                $('#rdo_t').prop('checked', true);
                                $('#rdo_ta_y').prop('checked', true);
                            }
                            if (course_data[0]["hrs_group_id"] == 'WT001')
                            {
                                $('#rdo_t').prop('checked', true);
                                //$('#rdo_ta').prop('checked', true);
                            }
                        }

                    }

                    else if (temp_typology == '23') {

                        $('#course_panel_show').css('display', 'none');
                        $('#studio_panel_showing').css('display', 'block');
                        $('#course_text').css('display', 'none');
                        $('#studio_text').css('display', 'block');
                        $('#rdo_t').prop('checked', false);
                        $('#rdo_ta').prop('checked', true);
                        $('#rdo_ta_y').prop('checked', false);
                        $('#rdo_ta_n').prop('checked', true);

                        $("#tutor_type_select").hide();
                        $("#tutor_type_select_ta").hide();
                        $("#studio_type_select").show();

                        if (course_data[0]["hrs_group_id"] != '') {
                            if (course_data[0]["hrs_group_id"] == 'WT004') {
                                $('#single_show').css('display', 'block');
                                $('#dual_show').css('display', 'none');
                                $('#rdo_d').prop('checked', false);
                                $('#rdo_s').prop('checked', true);

                            }
                            else if (course_data[0]["hrs_group_id"] == 'WT005') {
                                $('#single_show').css('display', 'none');
                                $('#dual_show').css('display', 'block');
                                $('#rdo_d').prop('checked', true);
                                $('#rdo_s').prop('checked', false);

                            }
                        }

                    }
                    else {
                        $('#single_show').css('display', 'none');
                        $('#dual_show').css('display', 'none');
                        $('#course_panel_show').css('display', 'none');
                        $('#studio_panel_showing').css('display', 'none');

                        $('#course_text').css('display', 'none');
                        $('#studio_text').css('display', 'none');
                        $('#textsubtitle').css('display', 'none');
                        $('#rdo_d').prop('checked', false);
                        $('#rdo_s').prop('checked', false);
                        $('#rdo_t').prop('checked', false);
                        $('#rdo_ta').prop('checked', true);
                        $('#rdo_ta_y').prop('checked', false);
                        $('#rdo_ta_n').prop('checked', true);
                        $("#tutor_type_select").hide();
                        $("#studio_type_select").hide();
                    }
                }

                $("#tblinstructor tbody").html('');

                if (data.d[2] != null) {
                    $("#tblinstructor tbody").html('');
                    $("[data-bind_row_no]").remove();
                    $("#tblinstructor tbody").html('');
                    var course_instructor_data = JSON.parse(data.d[2])
                    new_course_inst_data = JSON.parse(data.d[2]);
                    var currentTime = new Date().getTime();
                    console.log(currentTime);
                    var str = '';
                    for (var i = 0; i < course_instructor_data.length; i++)
                    {
                        console.log(i);
                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW')
                        {
                            $('#drp_contact_hrs').prop('disabled', 'disabled');
                            //06112020
                            //var str = "<tr data-row_no='" + (i + 1) + "'><td>" + instructor + "</td><td><select class='cls_drp_contact_hrs' style='width: 100%;' disabled><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled/></td><td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled/></td><td><input type='radio' class='cls_radio_tutor' name='rdo_tutor' value='" + (i + 1) + "' disabled/></td><td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            //var str = "<tr data-row_no='" + (i + 1) + "'><td>" + instructor + "</td><td><select class='cls_drp_contact_hrs' style='width: 100%;' disabled><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled/></td><td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled/></td><td><input type='radio' class='cls_radio_tutor' name='rdo_tutor' value='" + (i + 1) + "' disabled/></td><td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td><input type='button' value='View' class ='but_click' /></td></tr>";//id='" + (i + 1) + "' 11 05 2020
                            str = '';
                            str = "<tr data-row_no='" + (i + 1) + "'><td>" + instructor + "</td>";
                            str += "<td><select class='cls_drp_contact_hrs' style='width: 100%;' disabled><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td>";


                            str += "<td><input id ='" + (i + 1) + '_' + 'per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + (i + 1) + ")' disabled/></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + (i + 1) + ")' disabled/></td>";

                            //str += "<td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled/></td>";
                            //str += "<td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled/></td>";


                            //28042022
                            str += "<td><input id ='" + (i + 1) + '_' + 'total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='6' onkeypress='return IsNumeric_istructor_in(event);' onInput='edValueKeyPress_new(" + (i + 1) + ")' disabled /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'add_hrs_new' + "' style='width: 30px;' type='text' class='add_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor_new(event);' disabled /></td>";


                            str += "<td><select onchange='append_tutor_value(this)' class='cls_drp_tutor' style='width: 100%;' disabled><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td><td class='hig_" + (i + 1) + "'>" + course_instructor_data[i]["highest_qualification"] + "</td><td class='toex_" + (i + 1) + "'>" + course_instructor_data[i]["total_experiance"] + "</td><td class='rate_" + (i + 1) + "'>" + course_instructor_data[i]["rate_band"] + "</td>";

                            if (course_instructor_data[i]["uso_hr_approved"] == "Y")
                            {
                                if ($("#hdnuserid").val() == 'ugpgoffice' || $("#hdnuserid").val() == 'ug' || $("#hdnuserid").val() == 'pg') {
                                    str += "<td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;display:block;'></i></center></td>";
                                }
                                else
                                {
                                    str += "<td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;display:none;'></i></center></td>";
                                }
                                
                            }
                            else
                            {
                            str += "<td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";// id='" + (i + 1) + "' 11 05 2020
                            }

                            str += "<td><input type='button' value='View' class ='but_click' /></td>";// id='" + (i + 1) + "' 11 05 2020
                            if ($('#hdn_ugpg_flag').val() == 'Y')
                            {
                                if ($("#hdnuserid").val() == 'ugpgoffice' || $("#hdnuserid").val() == 'ug' || $("#hdnuserid").val() == 'pg' )
                                {
                                    str += "<td><input type='button' value='Save'  id='inst' class ='but_save' /></td></tr>";
                                }
                                else
                                { str += "<td></td></tr>"; }
                                
                            }
                            else
                            {
                                str += "<td><input type='button' value='Save'  id='inst' class ='but_save' disabled /></td></tr>";
                            }
                            
                        }
                        else {
                            //var str = "<tr data-row_no='" + (i + 1) + "'><td>" + instructor + "</td><td><select class='cls_drp_contact_hrs' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);'/></td><td><input type='radio' class='cls_radio_tutor' name='rdo_tutor' value='" + (i + 1) + "' /></td><td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            //var str = "<tr data-row_no='" + (i + 1) + "'><td>" + instructor + "</td><td><select class='cls_drp_contact_hrs' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);'/></td><td><input type='radio' class='cls_radio_tutor' name='rdo_tutor' value='" + (i + 1) + "' /></td><td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td><input type='button' value='View' class ='but_click' /></td></tr>";//id='" + (i + 1) + "' 11 05 2020
                            str = '';
                            str = "<tr data-row_no='" + (i + 1) + "'><td>" + instructor + "</td>";
                            str += "<td><select class='cls_drp_contact_hrs' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td>";


                            str += "<td><input id ='" + (i + 1) + '_' + 'per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + (i + 1) + ")' /></td>";

                            //28042022
                            str += "<td><input id ='" + (i + 1) + '_' + 'total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='6' onkeypress='return IsNumeric_istructor_in(event);' onInput='edValueKeyPress_new(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'add_hrs_new' + "' style='width: 30px;' type='text' class='add_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor_new(event);' disabled /></td>";


                            //str += "<td><input style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td>";
                            //str += "<td><input style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);'/></td>";

                            str += "<td><select onchange='append_tutor_value(this)' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td><td class='hig_" + (i + 1) + "'>" + course_instructor_data[i]["highest_qualification"] + "</td><td class='toex_" + (i + 1) + "'>" + course_instructor_data[i]["total_experiance"] + "</td><td class='rate_" + (i + 1) + "'>" + course_instructor_data[i]["rate_band"] + "</td>";

                            if (course_instructor_data[i]["uso_hr_approved"] == "Y")
                            {
                                //changes by nitinbhai 11122023
                                if ($("#hdnuserid").val() == 'ugpgoffice' || $("#hdnuserid").val() == 'ug' || $("#hdnuserid").val() == 'pg')
                                {
                                    str += "<td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;display:block;'></i></center></td>";
                                }
                                else {
                                    str += "<td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;display:none;'></i></center></td>";
                            }


                                //str += "<td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;display:none;'></i></center></td>";
                            }
                            else {
                                str += "<td><center><i data-row_no='" + (i + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";// id='" + (i + 1) + "' 11 05 2020
                            }
                            str += "<td><input type='button' value='View' class ='but_click' /></td>";// id='" + (i + 1) + "' 11 05 2020

                            if ($('#hdn_ugpg_flag').val() == 'Y')
                            {
                                if ($("#hdnuserid").val() == 'ugpgoffice' || $("#hdnuserid").val() == 'ug' || $("#hdnuserid").val() == 'pg') {
                                    str += "<td><input type='button' value='Save'  id='inst' class ='but_save' /></td></tr>";
                                }
                                else { str += "<td></td></tr>";}
                                
                            }
                            else {
                                str += "<td><input type='button' value='Save'  id='inst' class ='but_save' /></td></tr>";
                            }

                            
                        }

                        $('#tblinstructor tbody').append(str);
                    }
                    var currentTime1 = new Date().getTime();
                    console.log(currentTime1);
                    $('.drpinstructor').attr('disabled', true);
                    add_instructor_cnt = (i + 1);


                    //04032022

                    if (to_be_later_inst != "") {
                        for (var k = 0; k < to_be_later_inst.length; k++) {
                            var str = "<tr data-row_no='" + (course_instructor_data.length + k + 1) + "'><td>" + instructor + "</td>";
                            str += "<td><select class='cls_drp_contact_hrs' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td>";

                            str += "<td><input id ='" + (course_instructor_data.length + k + 1) + '_' + 'per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + (course_instructor_data.length + k + 1) + ")' /></td>";
                            str += "<td><input id ='" + (course_instructor_data.length + k + 1) + '_' + 'week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress(" + (course_instructor_data.length + k + 1) + ")'/></td>";

                            str += "<td><input id ='" + (course_instructor_data.length + k + 1) + '_' + 'total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
                            str += "<td><input id ='" + (course_instructor_data.length + k + 1) + '_' + 'add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='6' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_new(" + (course_instructor_data.length + k + 1) + ")' /></td>";
                            str += "<td><input id ='" + (course_instructor_data.length + k + 1) + '_' + 'add_hrs_new' + "' style='width: 30px;' type='text' class='add_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor_new(event);' disabled /></td>";

                            str += "<td><select onchange='append_tutor_value(this)' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td><td class='hig_" + (course_instructor_data.length + k + 1) + "'></td><td class='toex_" + (course_instructor_data.length + k + 1) + "'></td><td class='rate_" + (course_instructor_data.length + k + 1) + "'></td>";
                            str += "<td><span id ='TBD' style='display:none;'><center><i data-row_no='" + (course_instructor_data.length + k + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;' disabled></i></center>" + to_be_later_inst[k]["instructor_code"] + "</span></td><td><input type='button' value='View' class ='but_click' /></td>";// id='" + (i + 1) + "' 11 05 2020
                            str += "<td><input type='button' value='Save'  id='inst' class ='but_save' disabled /></td></tr>";
                            $('#tblinstructor tbody').append(str);
                            //<center><i data-row_no='" + (course_instructor_data.length + k + 1) + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;' disabled></i></center>
                        }
                    }


                    $("#tblinstructor tbody tr").each(function (j) {

                        for (var i = 0; i < course_instructor_data.length; i++) {

                            if (j == i) {
                                $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);

                                $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);
                                $(this).find(".per_load").val(course_instructor_data[i]["percent_load"]);
                                $(this).find(".cls_drp_contact_hrs").val(course_instructor_data[i]["instructor_contact_hrs"]);
                                if (course_instructor_data[i]["instructor_contact_hrs"] == "HS")
                                {
                                    $(this).find(".week").attr('disabled', 'disabled');
                                    $(this).find(".week").val(course_instructor_data[i]["week"]);
                                } else {
                                    $(this).find(".week").val(course_instructor_data[i]["week"]);
                                }

                                //06112020
                                if (course_instructor_data[i]["tutor_type"] == "T")//06112020
                                {
                                    $(this).find(".cls_drp_tutor").val(course_instructor_data[i]["tutor_type"]);
                                    // $(this).find(".cls_radio_tutor")[0].checked = true;
                                }
                                else if (course_instructor_data[i]["tutor_type"] == "CT") {
                                    $(this).find(".cls_drp_tutor").val(course_instructor_data[i]["tutor_type"]);
                                }
                                else {
                                }
                                //28042022

                                if (course_instructor_data[i]["percent_load"] != "" && course_instructor_data[i]["week"] != "") {
                                    $(this).find(".total_hrs").val((parseFloat(parseFloat(course_instructor_data[i]["percent_load"]) * parseFloat(course_instructor_data[i]["week"]))).toFixed(0));
                                }
                                else {

                                }
                                if (course_instructor_data[i]["additional_hours"] != "")
                                {
                                    $(this).find(".add_hrs").val(course_instructor_data[i]["additional_hours"]);
                                    var calculate_total_hrs = (parseFloat(parseFloat(course_instructor_data[i]["week"]) * parseFloat(course_instructor_data[i]["percent_load"]))).toFixed(0);
                                    calculate_total_hrs = (parseFloat(parseFloat(course_instructor_data[i]["additional_hours"]) + parseFloat(calculate_total_hrs))).toFixed(0);
                                    $(this).find(".add_hrs_new").val(calculate_total_hrs);
                                }

                                //28042022
                                if ($('#hdn_y').val() == '2022' && $('#hdn_s').val() == 'M') {
                                    $(this).parent().parent().find('.cls_drp_contact_hrs').attr('disabled', 'disabled');
                                }
                                else if ($('#hdn_y').val() > parseInt('2022')) {
                                    $(this).parent().parent().find('.cls_drp_contact_hrs').attr('disabled', 'disabled');
                                }


                                //if (course_instructor_data[i]["tutor_type"] == "T") {
                                //    $(this).find(".cls_radio_tutor")[0].checked = true;
                                //} else {
                                //}

                                //$(this).find(".drpinstructor").chosen();
                                //$(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }


                        $('.cls_drp_contact_hrs').on('change', function () {
                            if ($(this).val() == "HW") {
                                $(this).parent().parent().find('.week').prop('disabled', false);
                            } else {
                                $(this).parent().parent().find('.week').attr('disabled', 'disabled');
                                $(this).parent().parent().find('.week').val('');
                            }
                        });
                    });

                    // Bind inst to be later //04032022
                    $("#tblinstructor tbody tr").each(function (u) {
                        if (to_be_later_inst != "") {
                            if (course_instructor_data.length <= u) {
                                $(this).find(".drpinstructor").val(to_be_later_inst[u - course_instructor_data.length]["instructor_code"]);
                            }
                        }

                    });

                    var list_of_instructors = "";
                    
                    for (var i = 0; i < course_instructor_data.length; i++) {

                        if (list_of_instructors != "") {
                            list_of_instructors += ",";
                        }
                        list_of_instructors += "'" + course_instructor_data[i]["instructor_code"] + "'";
                    }
                    window.instructordata = course_instructor_data;

                    GetLsitOfInstructorImages(list_of_instructors);

                }
                else
                {
                    $("#tblinstructor tbody").html('');
                    $("[data-bind_row_no]").remove()
                }
                $("#tblarea tbody").html('');
                if (data.d[3] != null) {

                    $("#tblarea tbody").html('');
                    var course_area_data = JSON.parse(data.d[3]);

                    for (var i = 0; i < course_area_data.length; i++) {
                        var str = "<tr><td>" + area + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        $('#tblarea tbody').append(str);
                    }

                    $("#tblarea tbody tr").each(function (j) {
                        for (var i = 0; i < course_area_data.length; i++) {
                            if (j == i) {
                                $(this).find(".drparea").val(course_area_data[i]["area_code"]);
                                //$(this).find(".drpinstructor").chosen();
                                //$(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }
                    });
                }

                $("#tbltimeday tbody").html('');
                if (data.d[4] != null) {

                    $("#tbltimeday tbody").html('');
                    var course_time_data = JSON.parse(data.d[4]);
                    new_course_time_data_get = JSON.parse(data.d[4]);
                    for (var i = 0; i < course_time_data.length; i++) {
                        bindday(i);
                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW')
                        {
                            //var str = "<tr><td><input style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour()' disabled/></td><td><input style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour()' disabled/></td><td>" + day + "</td><td><input type='text' class='marg-btm cls_roomid' style='width: 50px;' disabled /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                            if (temp_typology == '23') {
                                var str = "<tr id ='time_" + i + "'><td><input id='" + i + "' style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour(this)' disabled/></td><td><input id='" + i + "' style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour(this)' disabled/></td><td>" + day + "</td><td><select class='marg-btm cls_roomid' id ='drp_" + i + "' onchange='room_onchange_event(this)' style='width: 218px;' disabled>" + str_room + "</select><a class='cls_view_room'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;display:none;'></i></center></td></tr>";
                            }
                            else
                            {
                                var str = "<tr id ='time_" + i + "'><td><input id='" + i + "' style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour(this)' disabled/></td><td><input id='" + i + "' style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour(this)' disabled/></td><td>" + day + "</td><td><select class='marg-btm cls_roomid' id ='drp_" + i + "' onchange='room_onchange_event(this)' style='width: 218px;' disabled>" + str_room + "</select><a class='cls_view_room'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            }
                            
                        }
                        else {
                            //var str = "<tr><td><input style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour()'/></td><td><input style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour()'/></td><td>" + day + "</td><td><input type='text' class='marg-btm cls_roomid' style='width: 50px;' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            if ($("#hdn_utype").val() == 'A1')
                            {
                                var str = "<tr id ='time_" + i + "'><td><input id='" + i + "' style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour(this)'/></td><td><input id='" + i + "' style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour(this)'/></td><td>" + day + "</td><td><select class='marg-btm cls_roomid' id ='drp_" + i + "' onchange='room_onchange_event(this)'  style='width: 218px;'>" + str_room + "</select><a class='cls_view_room'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                            }
                            else
                            {
                                if (temp_typology == '23' || temp_typology == '') {
                                    var str = "<tr id ='time_" + i + "'><td><input id='" + i + "' style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour(this)'/></td><td><input id='" + i + "' style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour(this)'/></td><td>" + day + "</td><td><select class='marg-btm cls_roomid' id ='drp_" + i + "' onchange='room_onchange_event(this)'  style='width: 218px;'>" + str_room + "</select><a class='cls_view_room'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;display:none;'></i></center></td></tr>";
                                }
                                else
                                {
                                    var str = "<tr id ='time_" + i + "'><td><input id='" + i + "' style='width: 56px;' type='text' class='from_time' onchange='calcTotalHour(this)'/></td><td><input id='" + i + "' style='width: 56px;' type='text' class='to_time' onchange='calcTotalHour(this)'/></td><td>" + day + "</td><td><select class='marg-btm cls_roomid' id ='drp_" + i + "' onchange='room_onchange_event(this)'  style='width: 218px;'>" + str_room + "</select><a class='cls_view_room'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                                }
                                
                            }
                            
                        }

                        $('#tbltimeday tbody').append(str);
                    }

                    $("#tbltimeday tbody tr").each(function (j) {
                        for (var i = 0; i < course_time_data.length; i++) {
                            if (j == i) {
                                $(this).find(".drpday").val(course_time_data[i]["day_code"]);
                                $(this).find(".from_time").val(course_time_data[i]["from_time"]);
                                $(this).find(".to_time").val(course_time_data[i]["To_time"]);

                                $(this).find(".cls_roomid").html('<option value="' + course_time_data[i]["room_id"] + '">' + course_time_data[i]["room_id"] + '</option>');
                                $(this).find(".cls_roomid").val(course_time_data[i]["room_id"]);

                                //$(this).find(".drpinstructor").chosen();
                                //$(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }
                    });

                    setTimepicker();
                    calcTotalHour('');

                    //if ($('#drptypology').val() == '') {
                    //    $('#div_weekly_plan').css('display', 'none');
                    //    $('#div_course_structure').css('display', 'none');
                    //}
                    //else if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
                    //    $('#div_weekly_plan').css('display', 'block');
                    //    $('#div_course_structure').css('display', 'none');
                    //}
                    //else {
                    //    $('#div_weekly_plan').css('display', 'none');
                    //    $('#div_course_structure').css('display', 'block');
                    //}
                }
                else { $('#spn_totalhour').html("Total Hours : 0 hr/week"); }

                $("#tblinstructor_tutorial tbody").html('');
                if (data.d[5] != null) {

                    $("#tblinstructor_tutorial tbody").html('');
                    var course_instructor_data = JSON.parse(data.d[5])

                    for (var i = 0; i < course_instructor_data.length; i++) {
                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            $('#drp_contact_hrs').prop('disabled', 'disabled');
                            var str = "<tr><td>" + instructor_tutorial + "</td><td><select class='cls_drp_contact_hrs_tutorial' style='width: 100%;' disabled><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load_tutorial' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled/></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }
                        else {
                            var str = "<tr><td>" + instructor_tutorial + "</td><td><select class='cls_drp_contact_hrs_tutorial' style='width: 100%;'><option value='HW'>Hrs/Week</option><option value='HS'>Hrs/Semester</option></select></td><td><input style='width: 30px;' type='text' class='per_load_tutorial' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }

                        $('#tblinstructor_tutorial tbody').append(str);
                    }

                    $("#tblinstructor_tutorial tbody tr").each(function (j) {
                        for (var i = 0; i < course_instructor_data.length; i++) {
                            if (j == i) {
                                $(this).find(".drpinstructor_tutorial").val(course_instructor_data[i]["instructor_code"]);
                                $(this).find(".per_load_tutorial").val(course_instructor_data[i]["percent_load"]);
                                $(this).find(".cls_drp_contact_hrs_tutorial").val(course_instructor_data[i]["instructor_contact_hrs"]);
                                //$(this).find(".drpinstructor").chosen();
                                //$(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }
                    });
                }

                $("#tbltimeday_tutorial tbody").html('');
                if (data.d[6] != null) {

                    $("#tbltimeday_tutorial tbody").html('');
                    var course_time_data = JSON.parse(data.d[6])

                    for (var i = 0; i < course_time_data.length; i++) {
                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            //var str = "<tr><td><input style='width: 56px;' type='text' class='from_time_tutorial' onchange='calcTotalHour()' disabled/></td><td><input style='width: 56px;' type='text' class='to_time_tutorial' onchange='calcTotalHour()' disabled/></td><td>" + day_tutorial + "</td><td><input type='text' class='marg-btm cls_roomid_tutorial' style='width: 50px;' disabled /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            var str = "<tr><td><input style='width: 56px;' type='text' class='from_time_tutorial' onchange='calcTotalHour(this)' disabled/></td><td><input style='width: 56px;' type='text' id=" + i + " class='to_time_tutorial' onchange='calcTotalHour(this)' disabled/></td><td>" + day_tutorial + "</td><td><select class='marg-btm cls_roomid_tutorial' style='width: 87px;' disabled>" + str_room + "</select><a class='cls_view_room_tutorial'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }
                        else {
                            //var str = "<tr><td><input style='width: 56px;' type='text' class='from_time_tutorial' onchange='calcTotalHour()'/></td><td><input style='width: 56px;' type='text' class='to_time_tutorial' onchange='calcTotalHour()'/></td><td>" + day_tutorial + "</td><td><input type='text' class='marg-btm cls_roomid_tutorial' style='width: 50px;' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            var str = "<tr><td><input style='width: 56px;' type='text' class='from_time_tutorial' onchange='calcTotalHour(this)'/></td><td><input style='width: 56px;' type='text' id=" + i + " class='to_time_tutorial' onchange='calcTotalHour(this)'/></td><td>" + day_tutorial + "</td><td><select class='marg-btm cls_roomid_tutorial' style='width: 87px;'>" + str_room + "</select><a class='cls_view_room_tutorial'>View</a></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }

                        $('#tbltimeday_tutorial tbody').append(str);
                    }

                    $("#tbltimeday_tutorial tbody tr").each(function (j) {
                        for (var i = 0; i < course_time_data.length; i++) {
                            if (j == i) {
                                $(this).find(".drpday_tutorial").val(course_time_data[i]["day_code"]);
                                $(this).find(".from_time_tutorial").val(course_time_data[i]["from_time"]);
                                $(this).find(".to_time_tutorial").val(course_time_data[i]["To_time"]);

                                $(this).find(".cls_roomid_tutorial").html('<option value="' + course_time_data[i]["room_id"] + '">' + course_time_data[i]["room_id"] + '</option>');
                                $(this).find(".cls_roomid_tutorial").val(course_time_data[i]["room_id"]);
                            }
                        }
                    });

                    setTimepicker();
                    calcTotalHour('');
                }
                else { $('#spn_totalhour_tutorial').html("Total Hours : 0 hr/week"); }

                $("#tblinstructor_aa tbody").html('');
                if (data.d[7] != null) {

                    $("#tblinstructor_aa tbody").html('');
                    var course_instructor_data = JSON.parse(data.d[7]);
                    new_course_AA_data = JSON.parse(data.d[7]);

                    for (var i = 0; i < course_instructor_data.length; i++) {
                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            $('#drp_contact_hrs').prop('disabled', 'disabled');
                            var str = "<tr><td>" + instructor_tutorial + "</td>";

                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_aa(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_aa(" + (i + 1) + ")' /></td>";

                            //28042022
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_hrs_new' + "' style='width: 30px;' type='text' class='aa_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled /></td>";


                            str += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";
                            str += "<td><input type='button' value='Save'  id='aa' class ='but_save_aa' disabled /></td></tr>";
                        }
                        else {
                            var str = "<tr><td>" + instructor_tutorial + "</td>";

                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_aa(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_aa(" + (i + 1) + ")' /></td>";

                            //28042022
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='5' onkeypress='return IsNumeric_istructor(event);' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'aa_hrs_new' + "' style='width: 30px;' type='text' class='aa_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled /></td>";
                            str += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";
                            if ($('#hdn_ugpg_flag').val() == 'Y')
                            {
                                if ($("#hdnuserid").val() == 'ugpgoffice' || $("#hdnuserid").val() == 'ug' || $("#hdnuserid").val() == 'pg') {
                                    str += "<td><input type='button' value='Save'  id='aa' class ='but_save_aa' /></td></tr>";
                                }
                                else
                                {
                                    str += "<td></td></tr>";
                                }
                                
                            }
                            else { str += "<td><input type='button' value='Save'  id='aa' class ='but_save_aa' /></td></tr>";}

                            
                        }

                        $('#tblinstructor_aa tbody').append(str);
                    }

                    $("#tblinstructor_aa tbody tr").each(function (j) {
                        for (var i = 0; i < course_instructor_data.length; i++) {
                            if (j == i) {
                                $(this).find(".drpinstructor_tutorial").val(course_instructor_data[i]["instructor_code"]);

                                $(this).find(".per_load").val(course_instructor_data[i]["total_contact_hrs"]);
                                $(this).find(".week").val(course_instructor_data[i]["total_weeks"]);
                                $(this).find(".total_hrs").val(course_instructor_data[i]["total_hrs_in_semester"]);
                                $(this).find(".add_hrs").val(course_instructor_data[i]["additional_hours"]);

                                if (course_instructor_data[i]["additional_hours"] != "")
                                {
                                    var calculate_total_hrs = (parseFloat(parseFloat(course_instructor_data[i]["total_weeks"]) * parseFloat(course_instructor_data[i]["total_contact_hrs"]))).toFixed(0);
                                    calculate_total_hrs = (parseFloat(parseFloat(course_instructor_data[i]["additional_hours"]) + parseFloat(calculate_total_hrs))).toFixed(0);
                                    $(this).find(".aa_hrs_new").val(calculate_total_hrs);
                                }

                                //$(this).find(".drpinstructor").chosen();
                                //$(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }
                    });
                    $('.drpinstructor_tutorial').attr('disabled', true);
                }

                $("#tblinstructor_ta tbody").html('');
                if (data.d[8] != null) {

                    $("#tblinstructor_ta tbody").html('');
                    var course_instructor_data = JSON.parse(data.d[8])
                    new_course_TA_data = JSON.parse(data.d[8])

                    for (var i = 0; i < course_instructor_data.length; i++) {
                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            $('#drp_contact_hrs').prop('disabled', 'disabled');

                            var str = "";
                            if (course_wise_ta == "")
                            {
                                str = "<tr data-row_no ='" + (i + 1) + "'><td>" + instructor_tutorial + "</td>";
                            }
                            else {
                                str = "<tr data-row_no ='" + (i + 1) + "'><td>" + TA_instructor + "</td>";
                            }

                           

                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + (i + 1) + ")' /></td>";

                            //28042022
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_hrs_new' + "' style='width: 30px;' type='text' class='ta_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled /></td>";
                           // str += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";
                            str += "<td></td>";
                            if (course_instructor_data[i]["inm_designation"].trim() == 'temp')
                            {
                                str += "<td></td></tr>";
                            }
                           else
                            {
                                if ($('#hdn_ugpg_flag').val() == 'Y')
                                {
                                    if ($("#hdnuserid").val() == 'ugpgoffice') {
                                        str += "<td><input type='button' value='Save'  id='ta' class ='but_save_ta' disabled /></td></tr>";
                                    }
                                    else
                                    { str += "<td></td></tr>"; }
                                    
                                }
                                else { str += "<td><input type='button' value='Save'  id='ta' class ='but_save_ta' disabled /></td></tr>";}
                                
                           }
                            


                        }
                        else {
                            var str = "";
                            if (course_wise_ta == "") {
                                str = "<tr data-row_no ='" + (i + 1) + "'><td>" + instructor_tutorial + "</td>";
                            }
                            else {
                                str = "<tr data-row_no ='" + (i + 1) + "'><td>" + TA_instructor + "</td>";
                            }

                            //var str = "<tr data-row_no ='" + (i + 1) + "'><td>" + TA_instructor + "</td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_per_load' + "' style='width: 30px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_week' + "' style='width: 30px;' type='text' class='week' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + (i + 1) + ")' /></td>";

                            //28042022
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_total_hrs' + "' style='width: 30px;' type='text' class='total_hrs' maxlength='5' disabled /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_add_hrs' + "' style='width: 30px;' type='text' class='add_hrs' maxlength='5' onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress_ta(" + (i + 1) + ")' /></td>";
                            str += "<td><input id ='" + (i + 1) + '_' + 'ta_hrs_new' + "' style='width: 30px;' type='text' class='ta_hrs_new' maxlength='5' onkeypress='return IsNumeric_istructor(event);' disabled  /></td>";
                           // str += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";
                            str += "<td></td>";
                           
                            if (course_instructor_data[i]["inm_designation"].trim() == 'temp')
                            {
                              str += "<td></td></tr>";
                            }
                            else
                            {
                                if ($('#hdn_ugpg_flag').val() == 'Y')
                                {
                                    if ($("#hdnuserid").val() == 'ugpgoffice' || $("#hdnuserid").val() == 'ug' || $("#hdnuserid").val() == 'pg') {
                                        str += "<td><input type='button' value='Save'  id='ta' class ='but_save_ta' /></td></tr>";
                                    }
                                    else { str += "<td></td></tr>";}
                                    
                                }
                                else
                                {
                                    str += "<td><input type='button' value='Save'  id='ta' class ='but_save_ta' /></td></tr>";
                                }
                                
                            }
                            //str += "<td><input type='button' value='Save'  id='ta' class ='but_save_ta' /></td></tr>";
                        }

                        $('#tblinstructor_ta tbody').append(str);
                    }
                    add_ta_cnt = (i + 1);
                    $("#tblinstructor_ta tbody tr").each(function (j) {
                        for (var i = 0; i < course_instructor_data.length; i++) {
                            if (j == i) {
                                $(this).find(".drpinstructor_tutorial").val(course_instructor_data[i]["instructor_code"]);
                                //02052022
                                $(this).find(".per_load").val(course_instructor_data[i]["total_contact_hrs"]);
                                $(this).find(".week").val(course_instructor_data[i]["total_weeks"]);
                                $(this).find(".total_hrs").val(course_instructor_data[i]["total_hrs_in_semester"]);
                                $(this).find(".add_hrs").val(course_instructor_data[i]["additional_hours"]);

                                if (course_instructor_data[i]["additional_hours"] != "") {
                                    var calculate_total_hrs = (parseFloat(parseFloat(course_instructor_data[i]["total_weeks"]) * parseFloat(course_instructor_data[i]["total_contact_hrs"]))).toFixed(0);
                                    calculate_total_hrs = (parseFloat(parseFloat(course_instructor_data[i]["additional_hours"]) + parseFloat(calculate_total_hrs))).toFixed(0);
                                    $(this).find(".ta_hrs_new").val(calculate_total_hrs);
                                }

                                //$(this).find(".drpinstructor").chosen();
                                //$(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }
                    });
                    $('.drpinstructor_tutorial').attr('disabled', true);
                }

                //if ($('#drptypology').val() == '') {
                //    $('#div_weekly_plan').css('display', 'none');
                //    $('#div_course_structure').css('display', 'none');
                //}
                //else if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
                //    $('#div_weekly_plan').css('display', 'block');
                //    $('#div_course_structure').css('display', 'none');
                //}
                //else {
                //    $('#div_weekly_plan').css('display', 'none');
                //    $('#div_course_structure').css('display', 'block');
                //}

                if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4') {
                    $('#div_weekly_plan').css('display', 'block');
                    $('#div_course_structure').css('display', 'none');

                    $('input[name=rdo_outline]')[1].checked = true;
                    $('input[name=rdo_outline]')[0].disabled = true;
                    $('#spn_chkbox').css('display', 'inline-block');
                }
                //else if ($('#txtcourse_structure').val() != '') {
                else if (CKEDITOR.instances.txtcourse_structure.getData() != '') {
                    $('#div_weekly_plan').css('display', 'none');
                    $('#div_course_structure').css('display', 'block');

                    $('input[name=rdo_outline]')[0].checked = true;
                    $('#spn_chkbox').css('display', 'none');
                }
                else if ($('#txt_week1').val() != '' || $('#txt_week2').val() != '' || $('#txt_week3').val() != '' || $('#txt_week4').val() != '' || $('#txt_week5').val() != '' || $('#txt_week6').val() != '' || $('#txt_week7').val() != '' || $('#txt_week8').val() != '' || $('#txt_week9').val() != '' || $('#txt_week10').val() != '' || $('#txt_week11').val() != '' || $('#txt_week12').val() != '' || $('#txt_week13').val() != '' || $('#txt_week14').val() != '' || $('#txt_week15').val() != '' || $('#txt_week16').val() != '') {
                    $('#div_weekly_plan').css('display', 'block');
                    $('#div_course_structure').css('display', 'none');

                    $('input[name=rdo_outline]')[1].checked = true;
                    $('#spn_chkbox').css('display', 'inline-block');
                }
                else if ($('#txt_week_reference1').val() != '' || $('#txt_week_reference2').val() != '' || $('#txt_week_reference3').val() != '' || $('#txt_week_reference4').val() != '' || $('#txt_week_reference5').val() != '' || $('#txt_week_reference6').val() != '' || $('#txt_week_reference7').val() != '' || $('#txt_week_reference8').val() != '' || $('#txt_week_reference9').val() != '' || $('#txt_week_reference10').val() != '' || $('#txt_week_reference11').val() != '' || $('#txt_week_reference12').val() != '' || $('#txt_week_reference13').val() != '' || $('#txt_week_reference14').val() != '' || $('#txt_week_reference15').val() != '' || $('#txt_week_reference16').val() != '') {
                    $('#div_weekly_plan').css('display', 'block');
                    $('#div_course_structure').css('display', 'none');

                    $('input[name=rdo_outline]')[1].checked = true;
                    $('#spn_chkbox').css('display', 'inline-block');
                }
                else if ($('#txt_week_assignment1').val() != '' || $('#txt_week_assignment2').val() != '' || $('#txt_week_assignment3').val() != '' || $('#txt_week_assignment4').val() != '' || $('#txt_week_assignment5').val() != '' || $('#txt_week_assignment6').val() != '' || $('#txt_week_assignment7').val() != '' || $('#txt_week_assignment8').val() != '' || $('#txt_week_assignment9').val() != '' || $('#txt_week_assignment10').val() != '' || $('#txt_week_assignment11').val() != '' || $('#txt_week_assignment12').val() != '' || $('#txt_week_assignment13').val() != '' || $('#txt_week_assignment14').val() != '' || $('#txt_week_assignment15').val() != '' || $('#txt_week_assignment16').val() != '') {
                    $('#div_weekly_plan').css('display', 'block');
                    $('#div_course_structure').css('display', 'none');

                    $('input[name=rdo_outline]')[1].checked = true;
                    $('#spn_chkbox').css('display', 'inline-block');
                }
                else {
                    $('#div_weekly_plan').css('display', 'none');
                    $('#div_course_structure').css('display', 'block');

                    $('input[name=rdo_outline]')[0].checked = true;
                    $('#spn_chkbox').css('display', 'none');
                }

                $('input[name=rdo_outline]').trigger('change');

                if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
                    if (course_data[0]["course_assessment"] != '' && course_data[0]["course_assessment"] != '[]') {
                        var obj_course_assessment = JSON.parse(course_data[0]["course_assessment"]);

                        for (var i = 0; i < obj_course_assessment.length; i++) {
                            $('#btn_add_course_assessment').click();
                            var row = $('#tbl_course_assessment tbody tr').eq(i);
                            row.find('.cls_exercises').val(obj_course_assessment[i]['exercise']);
                            row.find('.cls_percentage').val(obj_course_assessment[i]['percentage']);
                            row.find('.cls_criteria').val(obj_course_assessment[i]['criteria']);
                        }
                    }
                }
                ontrigger_update = true;
                $('#drp_semester').trigger('change');
                ontrigger_update = false;
                create_str_room();

                //07102021
                //if ($('#drptypology').val() == '23' || $('#drptypology').val() == '28') {
                if ($('#drptypology').val() == '23') {
                    if (course_data[0]["weekly_excercises_path"] != '' && course_data[0]["weekly_excercises_path"] != undefined) {
                        $('#lbl_excercises_file_name').text(course_data[0]["weekly_excercises_path"]);
                    }
                }

                if (data.d[10] != null) {
                    var studio_type = $('#drptypology').val();
                    if (studio_type == '23')
                    {
                        //changes by nitin bhai 13052024 AnyDesk
                        if ($("#hdn_utype").val() == 'A1')
                        {
                            //$('#btn_time').attr('disabled', '');
                        }
                        else
                        {
                            $('#btn_time').attr('disabled', 'disabled');
                        }
                        

                    }
                    $("#tblinstructor_time_slot tbody").html('');
                    var dropdown_list = "";
                    var inst_time_data = JSON.parse(data.d[10])
                    if (data.d[4] != null) {
                        var course_time_data = JSON.parse(data.d[4]);
                    }
                    var string_html = '';
                    var inst_code_duplicate = '';
                    var row_number = 1;
                    var child_row_count = 1;
                    var create_id = '';
                    var autoincrement = 1;
                    for (var k = 0; k < inst_time_data.length; k++) {
                        var bind_dropdown = '';
                        if (inst_code_duplicate == '') {
                            row_number = 1;
                            string_html = '';
                            var new_class = (k + 1) + " " + inst_time_data[k]["instructor_code"];
                            string_html += '<tr class ="' + new_class + '"  data-row_no =' + row_number + '><td colspan = 7  id=' + row_number + ' class = inst_name>' + inst_time_data[k]["instructor_name"] + '</td></tr>';

                            if (inst_time_data[k]["time_sq_no"] != '') {
                                //row_number = parseInt(parseInt(inst_time_data[k]["time_sq_no"]) - parseInt('1'));
                                row_number = k;
                            }
                            else { row_number = k; }

                            //create_id = inst_time_data[k]["instructor_code"] + '_' + row_number
                            // var new_class = 'c_' + " " + inst_time_data[k]["instructor_code"];

                            var row_count_val = 'rowselect_' + row_number;
                            var current_tr_id = 'c_' + inst_time_data[k]["instructor_code"];
                            var inst_code_new = inst_time_data[k]["instructor_code"] + '_' + row_number;
                            var inst_code_new_from = 'from' + '_' + inst_code_new;
                            var inst_code_new_to = 'to' + '_' + inst_code_new
                            var new_temp_day = Week(inst_time_data[k]["day_code"]);
                            new_temp_day = day_value;

                            string_html += "<tr class ='" + current_tr_id + ' ' + row_count_val + "'><td></td><td><input style='width: 56px;' id='" + inst_code_new_from + "' type='text' class='from_time_" + row_number + ' ' + inst_code_new_from + ' ' + 'from_time' + "' /></td><td><input id='" + inst_code_new_to + "' style='width: 56px;' type='text' class='to_time_" + row_number + ' ' + inst_code_new_to + ' ' + 'to_time' + "' /></td><td class='day_value_" + row_number + ' ' + 'day_value' + "'>" + new_temp_day + "</td><td class='room_value_" + row_number + ' ' + 'class_room_id ' + "'>" + inst_time_data[k]["room_id"] + "</td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td></tr>";

                            inst_code_duplicate = inst_time_data[k]["instructor_code"];
                        }
                        else if (inst_code_duplicate == inst_time_data[k]["instructor_code"]) {

                            string_html = '';
                            if (inst_time_data[k]["time_sq_no"] != '') {
                                //row_number = parseInt(parseInt(inst_time_data[k]["time_sq_no"]) - parseInt('1'));
                                row_number = child_row_count;
                            }
                            else { row_number = child_row_count; }
                            // create_id = inst_time_data[k]["instructor_code"] + '_' + row_number
                            //var new_class = 'c_' + " " + inst_time_data[k]["instructor_code"];

                            var row_count_val = 'rowselect_' + row_number;
                            var current_tr_id = 'c_' + inst_time_data[k]["instructor_code"];
                            var inst_code_new = inst_time_data[k]["instructor_code"] + '_' + row_number;
                            var inst_code_new_from = 'from' + '_' + inst_code_new;
                            var inst_code_new_to = 'to' + '_' + inst_code_new
                            //var inst_id = inst_code_ + '_' + j;
                            var new_temp_day = Week(inst_time_data[k]["day_code"]);
                            new_temp_day = day_value;
                            string_html += "<tr class ='" + current_tr_id + ' ' + row_count_val + "'><td></td><td><input style='width: 56px;' id='" + inst_code_new_from + "' type='text' class='from_time_" + row_number + ' ' + inst_code_new_from + ' ' + 'from_time' + "' /></td><td><input id='" + inst_code_new_to + "' style='width: 56px;' type='text' class='to_time_" + row_number + ' ' + inst_code_new_to + ' ' + 'to_time' + "' /></td><td class='day_value_" + row_number + ' ' + 'day_value' + "'>" + new_temp_day + "</td><td class='room_value_" + row_number + ' ' + 'class_room_id ' + "'>" + inst_time_data[k]["room_id"] + "</td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td></tr>";
                            inst_code_duplicate = inst_time_data[k]["instructor_code"];
                            child_row_count = child_row_count + 1;
                        }
                        else {
                            string_html = '';
                            row_number = 1;
                            autoincrement = parseInt(parseInt(autoincrement) + parseInt('1'));
                            var new_class = autoincrement + " " + inst_time_data[k]["instructor_code"];
                            string_html += '<tr class ="' + new_class + '"  data-row_no =' + autoincrement + '><td colspan = 7  id=' + autoincrement + ' class = inst_name>' + inst_time_data[k]["instructor_name"] + '</td></tr>';

                            //row_number = parseInt(parseInt(inst_time_data[k]["time_sq_no"]) - parseInt('1'));
                            if (inst_time_data[k]["time_sq_no"] != '') {
                                //row_number = parseInt(parseInt(inst_time_data[k]["time_sq_no"]) - parseInt('1'));
                                row_number = 0;
                            }
                            else { row_number = 0; }

                            // create_id = inst_time_data[k]["instructor_code"] + '_' + row_number
                            var new_class = 'c_' + " " + inst_time_data[k]["instructor_code"];

                            var row_count_val = 'rowselect_' + row_number;

                            var current_tr_id = 'c_' + inst_time_data[k]["instructor_code"];
                            var inst_code_new = inst_time_data[k]["instructor_code"] + '_' + row_number;
                            var inst_code_new_from = 'from' + '_' + inst_code_new;
                            var inst_code_new_to = 'to' + '_' + inst_code_new
                            //var inst_id = inst_code_ + '_' + j;
                            var new_temp_day = Week(inst_time_data[k]["day_code"]);
                            new_temp_day = day_value;

                            string_html += "<tr class ='" + current_tr_id + ' ' + row_count_val + "'><td></td><td><input style='width: 56px;' id='" + inst_code_new_from + "' type='text' class='from_time_" + row_number + ' ' + inst_code_new_from + ' ' + 'from_time' + "' /></td><td><input id='" + inst_code_new_to + "' style='width: 56px;' type='text' class='to_time_" + row_number + ' ' + inst_code_new_to + ' ' + 'to_time' + "' /></td><td class='day_value_" + row_number + ' ' + 'day_value' + "'>" + new_temp_day + "</td><td class='room_value_" + row_number + ' ' + 'class_room_id ' + "'>" + inst_time_data[k]["room_id"] + "</td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td></tr>";

                            inst_code_duplicate = inst_time_data[k]["instructor_code"];
                            child_row_count = 1;

                        }
                        $('#tblinstructor_time_slot tbody').append(string_html);

                    }
                    var duplicate_inst_id = '';
                    var time_sq_no = '';
                    for (var k = 0; k < inst_time_data.length; k++) {
                        // for (var i = 0; i < course_time_data.length; i++)
                        //{

                        $(".from_time_" + k).timepicker({ 'minTime': '8:00am' });
                        $(".to_time_" + k).timepicker({ 'minTime': '8:00am' });
                        var hours_from = inst_time_data[k]["from_time"];
                        var hours_to = inst_time_data[k]["to_time"];
                        var hours_from_ = inst_time_data[k]["from_time"];
                        var hours_from_split = inst_time_data[k]["from_time"].split('.');
                        var ampm = hours_from_split[0] >= 12 ? 'pm' : 'am';
                        hours_from_ = hours_from_split[0] % 12;
                        if (hours_from_ == '0') {
                            hours_from_ = '12';
                        }
                        hours_from_ = hours_from_ + ':' + hours_from_split[1] + ampm;
                        hours_from_ = hours_from_.replace('.', ':');
                        var hours_to_ = inst_time_data[k]["to_time"];
                        var hours_to_split = inst_time_data[k]["to_time"].split('.');
                        var ampm_to_ = hours_to_ >= 12 ? 'pm' : 'am';
                        hours_to_ = hours_to_split[0] % 12;
                        if (hours_to_ == '0') {
                            hours_to_ = '12';
                        }
                        hours_to_ = hours_to_ + ':' + hours_to_split[1] + ampm_to_;
                        hours_to_ = hours_to_.replace('.', ':');
                        if (duplicate_inst_id == '') {
                            duplicate_inst_id = inst_time_data[k]["instructor_code"];
                            time_sq_no = 0;
                        }
                        else if (inst_time_data[k]["instructor_code"] == duplicate_inst_id) {
                            time_sq_no = time_sq_no + 1;
                            duplicate_inst_id = inst_time_data[k]["instructor_code"];

                        } else {
                            time_sq_no = 0;
                            duplicate_inst_id = inst_time_data[k]["instructor_code"];
                        }

                        var from_id_value = 'from' + '_' + inst_time_data[k]["instructor_code"] + '_' + time_sq_no;
                        var to_id_value = 'to' + '_' + inst_time_data[k]["instructor_code"] + '_' + time_sq_no;
                        if (inst_time_data[k]["from_time"] != '') {
                            $('#' + from_id_value).val(hours_from_);
                        }
                        if (inst_time_data[k]["to_time"] != '') {
                            $('#' + to_id_value).val(hours_to_);
                        }



                        var timeslot_from_time = inst_time_data[k]["timeslot_from_time"];
                        var timeslot_to_time = inst_time_data[k]["timeslot_to_time"];

                        $('.from_time_' + time_sq_no).timepicker('option', { 'minTime': timeslot_from_time, 'maxTime': timeslot_to_time });
                        $('.to_time_' + time_sq_no).timepicker('option', { 'minTime': timeslot_from_time, 'maxTime': timeslot_to_time });

                        // }
                    }

                }

                else {
                    var studio_type = $('#drptypology').val();
                    if (studio_type == '23')
                    {
                        //changes by nitin bhai 13052024 AnyDesk
                        if ($("#hdn_utype").val() == 'A1') {
                            //$('#btn_time').attr('disabled', '');
                        }
                        else {
                            $('#btn_time').attr('disabled', 'disabled');
                        }
                        //$('#btn_time').attr('disabled', 'disabled');

                    }
                    if (data.d[4] != null) {
                        var dropdown_list = '';
                        var course_time_data = JSON.parse(data.d[4]);

                        if (data.d[2] != null) {
                            var inst_time_data = JSON.parse(data.d[2]);
                            var string_html = '';
                            var create_id = '';
                            var status_inst = true;
                            for (var k = 0; k < inst_time_data.length; k++) {
                                if (status_inst) {
                                    status_inst = false;
                                    var time_slot_inst_code = '';
                                    var new_class = (k + 1) + ' ' + inst_time_data[k]["instructor_code"];
                                    var current_row_id = (k + 1);
                                    string_html += '<tr class ="' + new_class + '"  data-row_no =' + current_row_id + '><td colspan = 7  id=' + current_row_id + ' class = inst_name>' + inst_time_data[k]["instructor_name"] + '</td></tr>';

                                }
                                for (var i = 0; i < course_time_data.length; i++) {
                                    status_inst = false;
                                    var row_number = i;
                                    var row_count_val = 'rowselect_' + row_number;
                                    var current_tr_id = 'c_' + inst_time_data[k]["instructor_code"];
                                    var inst_code_new = inst_time_data[k]["instructor_code"] + '_' + row_number;
                                    var inst_code_new_from = 'from' + '_' + inst_time_data[k]["instructor_code"] + '_' + row_number;
                                    var inst_code_new_to = 'to' + '_' + inst_time_data[k]["instructor_code"] + '_' + row_number;
                                    string_html += "<tr class ='" + current_tr_id + ' ' + row_count_val + "'><td></td><td><input style='width: 56px;' id='" + inst_code_new_from + "' type='text' class='from_time_" + row_number + ' ' + inst_code_new_from + ' ' + 'from_time' + "' /></td><td><input id='" + inst_code_new_to + "' style='width: 56px;' type='text' class='to_time_" + row_number + ' ' + inst_code_new_to + ' ' + 'to_time' + "' /></td><td class='day_value_" + row_number + ' ' + 'day_value' + "'>" + course_time_data[i]["day_name"] + "</td><td class='room_value_" + row_number + ' ' + 'class_room_id ' + "'>" + course_time_data[i]["room_id"] + "</td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td></tr>";

                                    if (i == (course_time_data.length - 1)) {
                                        status_inst = true;

                                    }
                                }

                            }
                            $('#tblinstructor_time_slot tbody').append(string_html);
                            for (var k = 0; k < inst_time_data.length; k++) {
                                for (var i = 0; i < course_time_data.length; i++) {
                                    $(".from_time_" + i).timepicker({ 'minTime': '8:00am' });
                                    $(".to_time_" + i).timepicker({ 'minTime': '8:00am' });
                                    var hours_from = course_time_data[i]["from_time"];
                                    var hours_to = course_time_data[i]["To_time"];

                                    $('.from_time_' + i).timepicker('option', { 'minTime': hours_from, 'maxTime': hours_to });
                                    $('.to_time_' + i).timepicker('option', { 'minTime': hours_from, 'maxTime': hours_to });

                                }
                            }
                        }
                    }
                }

                if (course_data[0]["hrs_group_id"] == 'WT004') {
                    $('#single_show').css('display', 'block');
                    $('#dual_show').css('display', 'none');
                }
                else if (course_data[0]["hrs_group_id"] == 'WT005') {
                    $('#single_show').css('display', 'none');
                    $('#dual_show').css('display', 'block');
                }

                if (course_data[0]["progcoordinate_approved"] == "Y" || course_data[0]["ugpgoffice_approved"] == "Y")
                {
                    course_publish_status = 'Y';
                    $(".but_save").attr('value', 'Update');
                    $(".but_save_ta").attr('value', 'Update');
                    $(".but_save_aa").attr('value', 'Update');
                }
               // $('#drpproglevel').val(progra_level_code_new);
               // $('#drpproglevel').trigger('change');
                if ($('#drptypology').val() == '23' && $("#hdn_utype").val() != 'A1')
                {
                    $("#tbltimeday tr td input").attr('disabled', 'disabled');
                    $("#tbltimeday tr").find("td:nth-child(3) select").attr('disabled', 'disabled');
                }
                

            },
            error: function (result) {
                alert(result);
            }
        });

        $('#drptype').trigger('change');

        get_all_course_time_data(sem_code, year_code);
        $('#studio_mode').trigger("change");
        var course_time_data = new_course_time_data_get;
        $("#tbltimeday tbody tr").each(function (j)
        {
            for (var i = 0; i < course_time_data.length; i++) {
                if (j == i)
                {
                    $(this).find(".cls_roomid").html('<option value="' + course_time_data[i]["room_id"] + '">' + course_time_data[i]["room_id"] + '</option>');
                    $(this).find(".cls_roomid").val(course_time_data[i]["room_id"]);
                }
            }
        });
        var course_Ta_data = new_course_TA_data;
        $("#tblinstructor_ta tbody tr").each(function (j) {
            for (var i = 0; i < course_Ta_data.length; i++)
            {
                if (j == i)
                {
                    $(this).find(".drpinstructor_tutorial").val(course_Ta_data[i]["instructor_code"]);
                    $(this).find(".per_load").val(course_Ta_data[i]["total_contact_hrs"]);
                    $(this).find(".week").val(course_Ta_data[i]["total_weeks"]);
                    $(this).find(".total_hrs").val(course_Ta_data[i]["total_hrs_in_semester"]);
                    $(this).find(".add_hrs").val(course_Ta_data[i]["additional_hours"]);

                    if (course_Ta_data[i]["additional_hours"] != "") {
                        var calculate_total_hrs = (parseFloat(parseFloat(course_Ta_data[i]["total_weeks"]) * parseFloat(course_Ta_data[i]["total_contact_hrs"]))).toFixed(0);
                        calculate_total_hrs = (parseFloat(parseFloat(course_Ta_data[i]["additional_hours"]) + parseFloat(calculate_total_hrs))).toFixed(0);
                        $(this).find(".ta_hrs_new").val(calculate_total_hrs);
                    }
                }
            }
        });

        var course_Aa_data = new_course_AA_data;

        $("#tblinstructor_aa tbody tr").each(function (j) {
            for (var i = 0; i < course_Aa_data.length; i++) {
                if (j == i) {
                    $(this).find(".drpinstructor_tutorial").val(course_Aa_data[i]["instructor_code"]);

                    $(this).find(".per_load").val(course_Aa_data[i]["total_contact_hrs"]);
                    $(this).find(".week").val(course_Aa_data[i]["total_weeks"]);
                    $(this).find(".total_hrs").val(course_Aa_data[i]["total_hrs_in_semester"]);
                    $(this).find(".add_hrs").val(course_Aa_data[i]["additional_hours"]);

                    if (course_Aa_data[i]["additional_hours"] != "") {
                        var calculate_total_hrs = (parseFloat(parseFloat(course_Aa_data[i]["total_weeks"]) * parseFloat(course_Aa_data[i]["total_contact_hrs"]))).toFixed(0);
                        calculate_total_hrs = (parseFloat(parseFloat(course_Aa_data[i]["additional_hours"]) + parseFloat(calculate_total_hrs))).toFixed(0);
                        $(this).find(".aa_hrs_new").val(calculate_total_hrs);
                    }

                    //$(this).find(".drpinstructor").chosen();
                    //$(this).find(".drpinstructor").trigger("liszt:updated");
                }
            }
        });
        var course_inst_data = new_course_inst_data;

        $("#tblinstructor tbody tr").each(function (j) {

            for (var i = 0; i < course_inst_data.length; i++) {

                if (j == i) {
                    $(this).find(".drpinstructor").val(course_inst_data[i]["instructor_code"]);

                    $(this).find(".drpinstructor").val(course_inst_data[i]["instructor_code"]);
                    $(this).find(".per_load").val(course_inst_data[i]["percent_load"]);
                    $(this).find(".cls_drp_contact_hrs").val(course_inst_data[i]["instructor_contact_hrs"]);
                    if (course_inst_data[i]["instructor_contact_hrs"] == "HS") {
                        $(this).find(".week").attr('disabled', 'disabled');
                        $(this).find(".week").val(course_inst_data[i]["week"]);
                    } else {
                        $(this).find(".week").val(course_inst_data[i]["week"]);
                    }

                    //06112020
                    if (course_inst_data[i]["tutor_type"] == "T")//06112020
                    {
                        $(this).find(".cls_drp_tutor").val(course_inst_data[i]["tutor_type"]);
                    }
                    else if (course_inst_data[i]["tutor_type"] == "CT") {
                        $(this).find(".cls_drp_tutor").val(course_inst_data[i]["tutor_type"]);
                    }
                    else {
                    }
                    //28042022

                    if (course_inst_data[i]["percent_load"] != "" && course_inst_data[i]["week"] != "") {
                        $(this).find(".total_hrs").val((parseFloat(parseFloat(course_inst_data[i]["percent_load"]) * parseFloat(course_inst_data[i]["week"]))).toFixed(0));
                    }
                    else {

                    }
                    if (course_inst_data[i]["additional_hours"] != "") {
                        $(this).find(".add_hrs").val(course_inst_data[i]["additional_hours"]);
                        var calculate_total_hrs = (parseFloat(parseFloat(course_inst_data[i]["week"]) * parseFloat(course_inst_data[i]["percent_load"]))).toFixed(0);
                        calculate_total_hrs = (parseFloat(parseFloat(course_inst_data[i]["additional_hours"]) + parseFloat(calculate_total_hrs))).toFixed(0);
                        $(this).find(".add_hrs_new").val(calculate_total_hrs);
                    }

                    //28042022
                    if ($('#hdn_y').val() == '2022' && $('#hdn_s').val() == 'M') {
                        $(this).parent().parent().find('.cls_drp_contact_hrs').attr('disabled', 'disabled');
                    }
                    else if ($('#hdn_y').val() > parseInt('2022')) {
                        $(this).parent().parent().find('.cls_drp_contact_hrs').attr('disabled', 'disabled');
                    }
                }
            }

            $('.cls_drp_contact_hrs').on('change', function () {
                if ($(this).val() == "HW") {
                    $(this).parent().parent().find('.week').prop('disabled', false);
                } else {
                    $(this).parent().parent().find('.week').attr('disabled', 'disabled');
                    $(this).parent().parent().find('.week').val('');
                }
            });
        });

        btn_ret_new_flag = false;
        return false;
    });

    $('#txtavailable_seats,#drpdepartment').on('change', function () {
        create_str_room();
        BindCourseTimetable(); //21052022
    });
    $('#drpsubtypology').on('change', function () {
        if ($('#drpsubtypology').val() != "") {//!="" 08052020
            $('.l2l3').css('display', 'none');
            $('.l2l3_star_show').css('display', 'none');
            $('.l2l3_hide').show();
            //$('.l2l3_hide').css('display', '');
            $('input[name=rdo_outline]')[1].checked = true;
            $('input[name=rdo_outline]').trigger('change');
            if ($('#drpsubtypology').val() != "1") {
                $('.l2l3l4').css('display', '');
            }
        } else {
            $('.l2l3').css('display', '');
            $('.l2l3_star_show').css('display', '');
            //$('.l2l3_hide').css('display', 'none');
            $('.l2l3_hide').show();
            //$('input[name=rdo_outline]')[0].checked = true;
            $('input[name=rdo_outline]').trigger('change');
        }

        //Mayur 12092019
        if ($('#drpsubtypology').val() == "L2")
        {
            bindfocusofstudio();
            $('.cls_focus_studio').css('display', '');
            $('.cls_focus_studio_options').css('display', '');
        }
        else if ($('#drpsubtypology').val() == "L3" && $("#drpproglevel").val() == "UD2") {
            bindfocusofstudio();
            $('.cls_focus_studio').css('display', '');
            $('.cls_focus_studio_options').css('display', '');
        }
        else {
            $('.cls_focus_studio').css('display', 'none');
            $('.cls_focus_studio_options').css('display', 'none');
        }

        if ($('#drpsubtypology').val() == "L2" || $('#drpsubtypology').val() == "L3")
        {
            BindCourseTimetable();
        }
    });

    $(document).on('change', '.from_time,.to_time,.drpday', function () {
        current_row_id_room = $(this).closest('tr').attr('id');
        create_str_room();
    });
    $(document).on('change', '.from_time_tutorial,.to_time_tutorial,.drpday_tutorial', function () { create_str_room(); });

    //$('#cke_txt_week_reference1 .cke_reset_all').css('display', 'none');


    get_all_typology_group();
    //get_room_detail();
    getparamrequest();
    rdo_tutorial_click();
    bindweek();

    $('#rdo_t').change(function () {
         appendtimeslotdtl();
    });
    $('#rdo_ta').change(function () {
         appendtimeslotdtl();
    });
    $('#rdo_ta_y').change(function () {
        appendtimeslotdtl();
    });
    $('#rdo_ta_n').change(function () {
        appendtimeslotdtl();
    })
    $('#rdo_s').change(function () {
        $('#single_show').css('display', 'block');
        $('#dual_show').css('display', 'none');
         appendtimeslotdtl();
    });
    $('#rdo_d').change(function () {
        $('#single_show').css('display', 'none');
        $('#dual_show').css('display', 'block');
         appendtimeslotdtl();
    });
    $("#txtavailable_seats").on("keyup change", function (e)
    {
        if ($('#drptypology').val() == '23') {
            if ($('#rdo_s').prop('checked') == true || $('#rdo_d').prop('checked') == true) {
                appendtimeslotdtl();
                append_tutor_image_2();
            }

            
        }
        else if ($('#drptypology').val() == '24') {
            appendtimeslotdtl();
            append_tutor_image_2();
        }

    })

    $("#txtcredits").on("keyup change", function (e)
    {
        if ($('#drptypology').val() == '23') {
            if ($('#rdo_s').prop('checked') == true || $('#rdo_d').prop('checked') == true) {
                appendtimeslotdtl();
            }
        }
        else if ($('#drptypology').val() == '24') {
            appendtimeslotdtl();
        }


    });

    if (studio_course_or_not == true)
    {
        $("#tblinstructor_ta tr td center i").css('display', 'none')
        if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'A1') {
            $("#txtavailable_seats").attr('disabled', 'disabled');
            $("#txtcredits").attr('disabled', 'disabled');
            $("#drpdepartment").attr('disabled', 'disabled');
            $("#drptype").attr('disabled', 'disabled');
            $("#drpproglevel").attr('disabled', 'disabled');
            $("#drpprog").attr('disabled', 'disabled');
            $("#drptypology").attr('disabled', 'disabled');
            $("#drpsubtypology").attr('disabled', 'disabled');
            $('#drp_typology_group').attr('disabled', 'disabled');
            $("#tbltimeday tr td input").attr('disabled', 'disabled');
            $("#tblinstructor_time_slot tr td input").attr('disabled', 'disabled');
            //$('.drpday').attr('disabled', 'disabled')
            //$("#tbltimeday tr td center i").css('display', 'none')
            

        }
        
    }

  
    
   // window.calling_funcation = false;
});
//function bindinstdata() {

//    for (var i = 0; i < window.instructordata.length; i++) {
//        $('#' + window.instructordata[i]["instructor_code"] + '').val(window.instructordata[i]["tutor_description"]);
//        $("#profile_desc").find("span[data-bind_row_no='" + (i + 1) + "']")[1].innerHTML = 'Total Char :' + (window.instructordata[i]["tutor_description"].length);
//    }
//}

function bindinstdata() {
    for (var i = 0; i < window.instructordata.length; i++) {
        $('#' + window.instructordata[i]["instructor_code"] + '').val(window.instructordata[i]["tutor_description"]);
        if ($("#profile_desc").find("span[data-bind_row_no='" + (i + 1) + "']")[1] != undefined) // By me Kapil 25062021
        {
           // $("#profile_desc").find("span[data-bind_row_no='" + (i + 1) + "']")[1].innerHTML = 'Total Char : ' + (400 - window.instructordata[i]["tutor_description"].length);
            $("#profile_desc").find("span[data-bind_row_no='" + (i + 1) + "']")[1].innerHTML = 'Total Char : ' + (window.instructordata[i]["tutor_description"].length);
           // if ((400 - window.instructordata[i]["tutor_description"].length) == 0) {
            if ((window.instructordata[i]["tutor_description"].length) > 400) {
                $("#profile_desc").find("span[data-bind_row_no='" + (i + 1) + "']")[1].style.color = "red";
            } else {
                $("#profile_desc").find("span[data-bind_row_no='" + (i + 1) + "']")[1].style.color = "black";
            }
        }

    }
}

function setCurrentSemester() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_cept_current_sem_data",
        //async: false,
        data: "{type : 'course'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var cur_grade_sem = JSON.parse(data.d);

                if (cur_grade_sem.length > 0) {
                    $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                    $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                    $('#drpsemester').trigger("liszt:updated");
                    $('#drpyear').trigger("liszt:updated");

                    $('#drpsemester').trigger("change");
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function getparamrequest() {
    if ($("#hdn_c").val() != '') {
        $("#drpsemester").val($("#hdn_s").val());
        $("#drpyear").val($("#hdn_y").val());
        $('#drpyear').trigger("liszt:updated");
        bind_sem_course();
        $("#drcourses").val($("#hdn_c").val());
        $('#drcourses').trigger("liszt:updated");
        $('#btnRetrieve').click();
        $('#btnRetrieve').css('display', 'none');//nitinbhai 24022025
    }
}

function setTimepicker() {
    $(".from_time").timepicker({ 'minTime': '8:00am' });
    $(".to_time").timepicker({ 'minTime': '8:00am' });
    $(".from_time_tutorial").timepicker({ 'minTime': '8:00am' });
    $(".to_time_tutorial").timepicker({ 'minTime': '8:00am' });
}

function room_onchange_event(e)
{
    var new_temp_day = '';
    var new_temp_from = '';
    var new_temp_to = '';
    var new_temp_room_id = '';
    var new_temp_room_text = '';
    var current_no = e.id.split('_');

    var total_hour = 0;
    var total_min = 0;
    for (var i = 0; i < $('#datalist_timeday .ui-timepicker-input').length; i = i + 2) {
        var temp_day = $('#datalist_timeday .ui-timepicker-input').eq(i).closest('tr').find('.drpday').val();
        var temp_from = convertTime($('#datalist_timeday .ui-timepicker-input')[i].value);
        var temp_to = convertTime($('#datalist_timeday .ui-timepicker-input')[i + 1].value);
        new_temp_room_id = $('#datalist_timeday .ui-timepicker-input').eq(i).closest('tr').find('.cls_roomid').val();
        new_temp_room_text = $('#datalist_timeday .ui-timepicker-input').eq(i).closest('tr').find('.cls_roomid').val();

        if (current_no[1] == i) {
            new_temp_day = temp_day;
            new_temp_from = temp_from;
            new_temp_to = temp_to;
        }
        var timediff_h = parseInt(temp_to.substring(0, 2)) - parseInt(temp_from.substring(0, 2));

        var timediff_m;
        if ((parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5))) < 0) {
            timediff_h = timediff_h - 1;
            timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5)) + 60;
        }
        else {
            timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5));
        }

        if (timediff_h < 0 || (timediff_h == 0 && timediff_m < 0)) {
            if (temp_to != '0.') {
                bootbox.alert('From_Time is greater than To_Time');
            }
        }

        var add_flag = true;
        for (var j = 0; j < $('#datalist_timeday .ui-timepicker-input').length; j = j + 2) {
            var temp_j_day = $('#datalist_timeday .ui-timepicker-input').eq(j).closest('tr').find('.drpday').val();
            var temp_j_from = convertTime($('#datalist_timeday .ui-timepicker-input')[j].value);
            var temp_j_to = convertTime($('#datalist_timeday .ui-timepicker-input')[j + 1].value);
            var new_temp_j_room_id = $('#datalist_timeday .ui-timepicker-input').eq(j).closest('tr').find('.cls_roomid').val();
            var new_temp_j_room_text = $('#datalist_timeday .ui-timepicker-input').eq(j).closest('tr').find('.cls_roomid').val();

            //05052022
            var curren_id = current_no[1];
            if (j != 0) {
                curren_id = parseInt(parseInt(curren_id) * parseInt('2'));
            }
            if (curren_id == j) {
                new_temp_day = temp_j_day;
                new_temp_from = temp_j_from;
                new_temp_to = temp_j_to;
                new_temp_room_id = new_temp_j_room_id;
                new_temp_room_text = new_temp_j_room_text;
            }


            if (j != i) {
                if (temp_from == temp_j_from && temp_to == temp_j_to && temp_day == temp_j_day) {
                    if (j < i)
                        add_flag = false;
                }
                else if (temp_from >= temp_j_from && temp_from <= temp_j_to && temp_to >= temp_j_from && temp_to <= temp_j_to && temp_day == temp_j_day) {
                    add_flag = false;
                }

                //else if(((temp_from > temp_j_from && temp_from < temp_j_to) || (temp_to > temp_j_from && temp_to < temp_j_to)) && temp_day == temp_j_day)
            }
        }

        if (add_flag) {
            total_hour = total_hour + timediff_h;
            total_min = total_min + timediff_m;
        }
    }

    if (total_min >= 60) {
        total_hour = total_hour + 1;
        total_min = total_min - 60;
    }

    $('#spn_totalhour').html("Total Hours : " + total_hour + "." + total_min + " hr/week");
    //alert("Time : " + total_hour + total_min);
    //parseInt(temp2.substr(0,2)) - parseInt(temp2.substr(0,2))

    calcTotalHour_tutorial();
    //05052022
    //if (new_temp_to != '' && new_temp_to != '0.' && new_temp_from != '' && new_temp_from != '0.' && new_temp_day != '') {
    //    var daySelect = document.getElementsByClassName('timesolt_drp');
    //    var day_code = new_temp_day;
    //    new_temp_day = Week(new_temp_day);
    //    new_temp_day = day_value;
    //    var text = new_temp_from + '-' + new_temp_to + '-' + new_temp_day + '-' + new_temp_room_id;
    //    var val_text = new_temp_from + '@@' + new_temp_to + '@@' + day_code + '@@' + new_temp_room_text;
    //    var lent = $("#tblinstructor_time_slot tbody tr").length;

    //    if (lent > 0) {
    //        var option_index = $('.timesolt_drp option.cls_' + current_no[1]).text()
    //        if (option_index != '') {
    //            $('.timesolt_drp option.cls_' + current_no[1]).text(text);
    //            $('.timesolt_drp option.cls_' + current_no[1]).val(val_text);
    //        }
    //        else {
    //            var dd_length = daySelect[0].options.length - 1;
    //            $('.timesolt_drp').append($('<option>').val(val_text).text(text).addClass('cls_' + dd_length));
    //        }

    //    }


    //}
    var current_id_add = e.id;
    $('.room_value_' + current_no[1]).text(new_temp_room_id);

}

function calcTotalHour(e) {

    var new_temp_day = '';
    var new_temp_from = '';
    var new_temp_to = '';
    var new_temp_room_id = '';
    var new_temp_room_text = '';

    var total_hour = 0;
    var total_min = 0;
    for (var i = 0; i < $('#datalist_timeday .ui-timepicker-input').length; i = i + 2) {
        var temp_day = $('#datalist_timeday .ui-timepicker-input').eq(i).closest('tr').find('.drpday').val();
        var temp_from = convertTime($('#datalist_timeday .ui-timepicker-input')[i].value);
        var temp_to = convertTime($('#datalist_timeday .ui-timepicker-input')[i + 1].value);
        new_temp_room_id = $('#datalist_timeday .ui-timepicker-input').eq(i).closest('tr').find('.cls_roomid').val();
        new_temp_room_text = $('#datalist_timeday .ui-timepicker-input').eq(i).closest('tr').find('.cls_roomid').val();

        if (e.id == i) {
            new_temp_day = temp_day;
            new_temp_from = temp_from;
            new_temp_to = temp_to;
        }


        //var temp_from = $('.ui-timepicker-input')[i].value;
        //var temp_to = $('.ui-timepicker-input')[i + 1].value;

        //if (temp_from.length < 7) {
        //    temp_from = '0' + temp_from;
        //}
        //if (temp_to.length < 7) {
        //    temp_to = '0' + temp_to;
        //}

        //if (temp_from.search('pm') != -1) {
        //    if (temp_from.substring(0, 2) != '12') {
        //        temp_from = (parseInt(temp_from.substring(0, 2)) + 12) + '.' + temp_from.substring(3, 5);
        //    }
        //    else {
        //        temp_from = temp_from.substring(0, 2) + '.' + temp_from.substring(3, 5);
        //    } 
        //}
        //else {
        //    if (temp_from.substring(0, 2) != '12') {
        //        temp_from = temp_from.substring(0, 2) + '.' + temp_from.substring(3, 5);
        //    }
        //    else {
        //        temp_from = '00.' + temp_from.substring(3, 5);
        //    }
        //}

        //if (temp_to.search('pm') != -1) {
        //    if (temp_to.substring(0, 2) != '12') {
        //        temp_to = (parseInt(temp_to.substring(0, 2)) + 12) + '.' + temp_to.substring(3, 5);
        //    }
        //    else {
        //        temp_to = temp_to.substring(0, 2) + '.' + temp_to.substring(3, 5);
        //    }
        //}
        //else {
        //    if (temp_to.substring(0, 2) != '12') {
        //        temp_to = temp_to.substring(0, 2) + '.' + temp_to.substring(3, 5);
        //    }
        //    else {
        //        temp_to = '00.' + temp_to.substring(3, 5);
        //    }
        //}

        var timediff_h = parseInt(temp_to.substring(0, 2)) - parseInt(temp_from.substring(0, 2));

        var timediff_m;
        if ((parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5))) < 0) {
            timediff_h = timediff_h - 1;
            timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5)) + 60;
        }
        else {
            timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5));
        }

        if (timediff_h < 0 || (timediff_h == 0 && timediff_m < 0)) {
            if (temp_to != '0.') {
                bootbox.alert('From_Time is greater than To_Time');
            }
        }

        var add_flag = true;
        var time_from_am = '';
        var time_to_pm = '';
        for (var j = 0; j < $('#datalist_timeday .ui-timepicker-input').length; j = j + 2) {
            var temp_j_day = $('#datalist_timeday .ui-timepicker-input').eq(j).closest('tr').find('.drpday').val();
            var temp_j_from = convertTime($('#datalist_timeday .ui-timepicker-input')[j].value);
            var temp_j_to = convertTime($('#datalist_timeday .ui-timepicker-input')[j + 1].value);
            time_from_am = $('#datalist_timeday .ui-timepicker-input')[j].value
            time_to_pm = $('#datalist_timeday .ui-timepicker-input')[j + 1].value;
            var new_temp_j_room_id = $('#datalist_timeday .ui-timepicker-input').eq(j).closest('tr').find('.cls_roomid').val();
            var new_temp_j_room_text = $('#datalist_timeday .ui-timepicker-input').eq(j).closest('tr').find('.cls_roomid').val();

            //05052022
            var curren_id = e.id;
            if (j != 0) {
                curren_id = parseInt(parseInt(curren_id) * parseInt('2'));
            }
            if (curren_id == j) {
                new_temp_day = temp_j_day;
                new_temp_from = temp_j_from;
                new_temp_to = temp_j_to;
                new_temp_room_id = new_temp_j_room_id;
                new_temp_room_text = new_temp_j_room_text;
            }


            if (j != i) {
                if (temp_from == temp_j_from && temp_to == temp_j_to && temp_day == temp_j_day) {
                    if (j < i)
                        add_flag = false;
                }
                else if (temp_from >= temp_j_from && temp_from <= temp_j_to && temp_to >= temp_j_from && temp_to <= temp_j_to && temp_day == temp_j_day) {
                    add_flag = false;
                }

                //else if(((temp_from > temp_j_from && temp_from < temp_j_to) || (temp_to > temp_j_from && temp_to < temp_j_to)) && temp_day == temp_j_day)
            }
        }

        if (add_flag) {
            total_hour = total_hour + timediff_h;
            total_min = total_min + timediff_m;
        }
    }

    if (total_min >= 60) {
        total_hour = total_hour + 1;
        total_min = total_min - 60;
    }

    $('#spn_totalhour').html("Total Hours : " + total_hour + "." + total_min + " hr/week");
    //alert("Time : " + total_hour + total_min);
    //parseInt(temp2.substr(0,2)) - parseInt(temp2.substr(0,2))

    calcTotalHour_tutorial();
    //05052022
    if (new_temp_to != '' && new_temp_to != '0.' && new_temp_from != '' && new_temp_from != '0.' && new_temp_day != '') {
        var daySelect = document.getElementsByClassName('timesolt_drp');
        var day_code = new_temp_day;
        new_temp_day = Week(new_temp_day);
        new_temp_day = day_value;
        var text = new_temp_from + '-' + new_temp_to + '-' + new_temp_day + '-' + new_temp_room_id;
        var val_text = new_temp_from + '@@' + new_temp_to + '@@' + day_code + '@@' + new_temp_room_text;
        var lent = $("#tblinstructor_time_slot tbody tr").length;

        if (lent > 0) {
            var current_id_add = e.id;
            // changes by 01072022
            //$('.from_time_' + current_id_add).val('');
            //$('.to_time_' + current_id_add).val('');
            $('.day_value_' + current_id_add).text(new_temp_day);
            $('.room_value_' + current_id_add).text(new_temp_room_id);

            $('.from_time_' + current_id_add).timepicker('option', { 'minTime': new_temp_from, 'maxTime': new_temp_to });
            $('.to_time_' + current_id_add).timepicker('option', { 'minTime': new_temp_from, 'maxTime': new_temp_to });

            //var option_index = $('.timesolt_drp option.cls_' + e.id).text()
            //if (option_index != '') {
            //    $('.timesolt_drp option.cls_' + e.id).text(text);
            //    $('.timesolt_drp option.cls_' + e.id).val(val_text);
            //}
            //else {
            //    var dd_length = daySelect[0].options.length - 1;
            //    //$('.timesolt_drp').append($('<option>').val(val_text).text(text).addClass('cls_' + dd_length));
            //}

        }


    }

}

//function get_from_time(f_time) {
//    var from_time_zone = f_time.substring(f_time.length - 2);
//    if (from_time_zone == "am") {
//        var hours = f_time.substring(0, f_time.length - 5);
//        if (hours.length == "1") {
//            hours = '0' + hours;
//            var mint = f_time.substring(f_time.length - 4);
//            mint = mint.substring(0, mint.length - 2);
//            from_time1 = hours + '.' + mint;
//            return from_time1;
//        }
//        else {
//            from_time1 = f_time.substring(0, f_time.length - 2);
//            from_time1 = from_time1.replace(":", ".");
//            return from_time1;
//        }
//    }
//    else {
//        var hours = f_time.substring(0, f_time.length - 5);
//        from_time1 = f_time.substring(0, f_time.length - 2);
//        if (hours != "12") {
//            var total_hours = parseInt(hours) + parseInt(12);
//            var mint = from_time1.substring(from_time1.length - 4);
//            mint = mint.substring(0, mint.length - 2);
//            from_time1 = total_hours + '.' + mint;
//            return from_time1;
//        }
//        else {
//            from_time1 = from_time1.replace(":", ".");
//            return from_time1;
//        }
//    }
//}

//function get_to_time(t_time) {
//    var to_time_zone = t_time.substring(t_time.length - 2);
//    if (to_time_zone == "am") {

//        var hours = t_time.substring(0, t_time.length - 5);
//        if (hours.length == "1") {
//            hours = '0' + hours;
//            var mint = t_time.substring(t_time.length - 4);
//            mint = mint.substring(0, mint.length - 2);
//            to_time1 = hours + '.' + mint;
//            return to_time1;
//        }
//        else {
//            to_time1 = t_time.substring(0, t_time.length - 2);
//            to_time1 = to_time1.replace(":", ".");
//            return to_time1;
//        }

//    }
//    else {
//        var hours = t_time.substring(0, t_time.length - 5);
//        to_time1 = t_time.substring(0, t_time.length - 2);
//        if (hours != "12") {
//            var total_hours = parseInt(hours) + parseInt(12);
//            var mint = to_time1.substring(to_time1.length - 2);
//            to_time1 = total_hours + '.' + mint;
//            return to_time1;
//        }
//        else {
//            to_time1 = to_time1.replace(":", ".");
//            return to_time1;
//        }

//    }
//}

function calcTotalHour_tutorial() {

    var total_hour = 0;
    var total_min = 0;
    for (var i = 0; i < $('#datalist_timeday_tutorial .ui-timepicker-input').length; i = i + 2) {

        var temp_from = convertTime($('#datalist_timeday_tutorial .ui-timepicker-input')[i].value);
        var temp_to = convertTime($('#datalist_timeday_tutorial .ui-timepicker-input')[i + 1].value);

        var timediff_h = parseInt(temp_to.substring(0, 2)) - parseInt(temp_from.substring(0, 2));

        var timediff_m;
        if ((parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5))) < 0) {
            timediff_h = timediff_h - 1;
            timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5)) + 60;
        }
        else {
            timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5));
        }

        if (timediff_h < 0 || (timediff_h == 0 && timediff_m < 0)) {
            if (temp_to != '0.') {
                bootbox.alert('From_Time is greater than To_Time');
            }
        }

        total_hour = total_hour + timediff_h;
        total_min = total_min + timediff_m;
    }

    if (total_min >= 60) {
        total_hour = total_hour + 1;
        total_min = total_min - 60;
    }

    $('#spn_totalhour_tutorial').html("Total Hours : " + total_hour + "." + total_min + " hr/week");
    //alert("Time : " + total_hour + total_min);
    //parseInt(temp2.substr(0,2)) - parseInt(temp2.substr(0,2))
}

function set_tutorial_dtl() {
    $('.cls_tutorial_offered').css('display', 'none');

    if ($('#drptypology').val() != '') {
        var temp_obj = jQuery.grep(typology_detail, function (data) { return data.type_code === $('#drptypology').val() });
        if (temp_obj.length > 0 && temp_obj[0]['is_tutorial'] == 'Y') {
            $('.cls_tutorial_offered').css('display', '');
        }
        else {
            $('input[type=radio][name=rdo_tutorial_offered][value=N]')[0].checked = true;
        }
    }
    else {
        $('input[type=radio][name=rdo_tutorial_offered][value=N]')[0].checked = true;
    }

    rdo_tutorial_click();
}

function convertTime(tempTime) {

    if (tempTime.length < 7) {
        tempTime = '0' + tempTime;
    }

    if (tempTime.search('pm') != -1) {
        if (tempTime.substring(0, 2) != '12') {
            tempTime = (parseInt(tempTime.substring(0, 2)) + 12) + '.' + tempTime.substring(3, 5);
        }
        else {
            tempTime = tempTime.substring(0, 2) + '.' + tempTime.substring(3, 5);
        }
    }
    else {
        if (tempTime.substring(0, 2) != '12') {
            tempTime = tempTime.substring(0, 2) + '.' + tempTime.substring(3, 5);
        }
        else {
            tempTime = '00.' + tempTime.substring(3, 5);
        }
    }

    return tempTime;
}

function getallcourse() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/GetAllSemestercourse",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var course_data = JSON.parse(data.d)

                //$('#drpallprecourse').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                for (var i = 0; i < course_data.length; i++) {
                    $('#drpallprecourse').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"]));
                }

                if ($("#hdn_utype").val() == 'CW') {
                    $('#drpallprecourse').attr('disabled', 'disabled');
                }
                else {
                    $('#drpallprecourse').chosen();
                    $('#drpallprecourse').trigger("liszt:updated");
                }

                $('#divPreCourseCode').css('display', 'none');
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}
//04032022 Bind Brief
function getstudio_text_description_dtl() {
    if ($('#hdn_studio_code').val() != '') {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Studio_introducation_Get",
            async: false,
            data: "{studio_code :'" + $('#hdn_studio_code').val() + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var course_data = JSON.parse(data.d)
                    $('#txtcourse_description').val(course_data[0]['studio_description']);
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }


}
function getstudio_dtl_with_no_of_tutor() {

    var studio_code = '';
    if ($('#hdn_c').val() != '') {
        studio_code = $('#hdn_c').val();
    }
    

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Studio_teaching_interest_dtl",
        async: false,
        data: "{studio_code :'" + studio_code + "',sem_code :'" + $('#hdn_s').val() + "',year_code :'" + $('#hdn_y').val() + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var course_data = JSON.parse(data.d)
                studio_course_or_not = true;
                $('#no_of_tutor_bind').text(course_data[0]['no_of_tutor']);
                $('#no_of_tutor').css('display', 'block');
                //Changed by nitinbhai 30122022

                // $('#btn_instructor_ta').attr('disabled', 'disabled');

                //$('#txtcourse_description').val(course_data[0]['no_of_tutor']);
            }
        },
        error: function (result) {
            alert(result);
        }
    });



}
//var dataday = "";
function bindday(e) {
    var number = e;
    //if (dataday == "") {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_day_data",
            async: false,
            data: "{}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var day_data = JSON.parse(data.d)
                    //dataday = true;
                    if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                        day = "<select id=" + number + " style='width:90px' class='drpday' onchange='calcTotalHour(this)' disabled>";
                        day_tutorial = "<select id=" + number + " style='width:65px' class='drpday_tutorial' disabled>";
                    }
                    else {
                        day = "<select id=" + number + " style='width:90px' class='drpday' onchange='calcTotalHour(this)'>";
                        day_tutorial = "<select id=" + number + " style='width:65px' class='drpday_tutorial'>";
                    }

                    for (var i = 0; i < day_data.length; i++) {
                        day = day + "<option value =" + day_data[i]["day_code"] + ">" + day_data[i]["day_name"] + " </option>";
                        day_tutorial = day_tutorial + "<option value =" + day_data[i]["day_code"] + ">" + day_data[i]["day_name"] + " </option>";
                    }

                    day = day + "</select>";
                    day_tutorial = day_tutorial + "</select>";
                }
            },
            error: function (result) {
                alert(result);
            }
        });
   // }
   
 
}

function bind_sem_course() {
    var sem_code = $('#drpsemester').val();
    if (sem_code == '') {
        bootbox.alert('Please select semester');
    }

    var year_code = $('#drpyear').val();
    if (year_code == '') {
        bootbox.alert('Please select year');
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        //url: "../../WebService.asmx/Get_all_course_data_For_Modification",
        url: "../../WebService.asmx/Get_all_course_data_For_Modification_new",
        async: false,
        data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',user_type : '" + $("#hdn_utype").val() + "',userid : '" + $('#hdnuserid').val() + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));
                //for (var i = 0; i < year_data.length; i++) {
                //    $('#drcourses').append($("<option></option>").val(year_data[i]["course_code"]).html(year_data[i]["course_code"]));
                //}
                $('#drcourses').html(year_data[0]["CourseCode"]);
                $('#drcourses').chosen();
                $('#drcourses').trigger("liszt:updated");
            }
            else {
                $('#drcourses').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                $('#drcourses').chosen();
                $('#drcourses').val('').trigger("liszt:updated");
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindyeardata_for_cross_reg() {
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
                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindsemdata() {
    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

    //for (var i = 0; i < sem_data.length; i++) {
    //    $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));
    //}

    if ($("#hdn_utype").val() != 'I2') {
        //$('#drpsemester').chosen();
    }
}

function bindtype() {

    $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
    $('#drptype').append($("<option></option>").val("E").html("Elective"));
    $('#drptype').append($("<option></option>").val("M").html("Mandatory"));

    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        $('#drptype').chosen();
    }
}

function bindproglevel() {

    //$('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
    //$('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
    //$('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));
 
    
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_program_level_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var prog_level_data = JSON.parse(data.d)

                $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                for (var i = 0; i < prog_level_data.length; i++) {
                    $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                }

                if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
                    $('#drpproglevel').chosen();
                }

                //$("#spn_proglvl").css('display', 'none');
                //$("#drpproglevel").css('display', 'none');
                //$("#drpproglevel_chzn").css('display', 'none');
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindsemesterdata() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_semester_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var semester_data = JSON.parse(data.d);

                $('#drp_semester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                for (var i = 0; i < semester_data.length; i++) {
                    $('#drp_semester').append($("<option></option>").val(semester_data[i]["semester_code"]).html(semester_data[i]["semester_name"]));
                }

                if ($("#hdn_utype").val() != 'I2') {
                    //$('#drp_semester').chosen();
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindinstructor() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
       // url: "../../WebService.asmx/Get_faculty_data",
        url: "../../WebService.asmx/Get_faculty_data_new",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var instructor_data = JSON.parse(data.d[0])
                var inst_ta_with_tem = JSON.parse(data.d[1])
            
                    if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW')
                    {
                        instructor = "<select style='width:100%' class='drpinstructor' disabled>";
                        instructor_tutorial = "<select onchange='append_ta_tutor_hrs(this)' style='width:100%' class='drpinstructor_tutorial' disabled><option value=''>&lt; Select Instructor &gt;</option>";
                    }
                    else {
                        instructor = "<select onchange='append_tutor_image(this)' style='width:100%' class='drpinstructor'><option value=''> Select Instructor</option>";
                        instructor_tutorial = "<select onchange='append_ta_tutor_hrs(this)' style='width:100%' class='drpinstructor_tutorial'>";
                    }

                for (var i = 0; i < instructor_data.length; i++)
                {
                    //instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                    instructor = instructor + instructor_data[i]["options"];
                }
                for (var p = 0; p < inst_ta_with_tem.length; p++)
                {
                    //instructor_tutorial = instructor_tutorial + "<option value =" + inst_ta_with_tem[p]["instructor_code"] + ">" + inst_ta_with_tem[p]["instructor_name"] + " </option>";
                    instructor_tutorial = instructor_tutorial + inst_ta_with_tem[p]["options"];
                }
                if (to_be_later_inst != "")
                {
                    for (var j = 0; j < to_be_later_inst.length; j++)
                    {
                        instructor = instructor + "<option value =" + to_be_later_inst[j]["instructor_code"] + ">" + to_be_later_inst[j]["instructor_code"] + " </option>";
                    }
                }

                    instructor = instructor + "</select>";
                    instructor_tutorial = instructor_tutorial + "</select>";
                
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindarea() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_Area_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var area_data = JSON.parse(data.d)

                if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                    area = "<select style='width:100%' class='drparea' disabled>";
                }
                else {
                    area = "<select style='width:100%' class='drparea'>";
                }

                for (var i = 0; i < area_data.length; i++) {
                    area = area + "<option value =" + area_data[i]["area_code"] + ">" + area_data[i]["area_name"] + " </option>";
                }

                area = area + "</select>";
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}
function bindgpanongpa() {
    $('#drp_gpa_ngpa').empty().append($("<option></option>").val("").html("-- Please Select --"));
    $('#drp_gpa_ngpa').append($("<option></option>").val('G').html('GPA'));
    $('#drp_gpa_ngpa').append($("<option></option>").val('N').html('Non-GPA'));
    //$('#drp_gpa_ngpa').chosen();
}
function bintypology() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_typology_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var typology_data = JSON.parse(data.d);

                $('#drptypology').empty().append($("<option></option>").val("").html("-- Please Select Typology --"));
                for (var i = 0; i < typology_data.length; i++) {
                    $('#drptypology').append($("<option></option>").val(typology_data[i]["type_code"]).html(typology_data[i]["type_name"]));
                }

                if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
                    $('#drptypology').chosen();
                }
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
        url: "../../WebService.asmx/Get_typology_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var res = JSON.parse(data.d);


                if (res['typology_group_detail'] != null) {
                    obj_typology_group = res['typology_group_detail'];

                    for (var i = 0; i < obj_typology_group.length; i++) {
                        $('#drp_typology_group').append('<option value="' + obj_typology_group[i]['group_id'].toString() + '">' + obj_typology_group[i]['group_desc'].toString() + '</option>');
                    }

                    if (res['typology_detail'] != null) {
                        var typology_data = res['typology_detail'];

                        //old_typology = jQuery.grep(typology_data, function (data) { return data.group_id === 'G001' });
                        //new_typology = jQuery.grep(typology_data, function (data) { return data.group_id === 'G002' });

                        for (var i = 0; i < obj_typology_group.length; i++) {
                            obj_typology[obj_typology_group[i]['group_id']] = jQuery.grep(typology_data, function (data) { return data.group_id === obj_typology_group[i]['group_id'] });
                        }
                    }
                }

                if (res['room_detail'] != null) {
                    obj_room_dtl = res['room_detail'];
                    create_str_room();
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

var obj_room_dtl = [];
//function get_room_detail() {
//    $.ajax({
//        type: "POST",
//        contentType: "application/json; charset=utf-8",
//        url: "../../WebService.asmx/get_room_detail",
//        async: false,
//        data: "{}",
//        dataType: "json",
//        success: function (data) {
//            if (data.d != "") {
//                obj_room_dtl = JSON.parse(data.d);
//                create_str_room();
//            }
//        },
//        error: function (result) {
//            alert(result);
//        }
//    });
//}

var str_room = '<option value="">--</option>';
//function create_str_room_old(capacity) {
//    str_room = '<option value="">--</option>';
//    
//    if (capacity == undefined) {
//        for (var i = 0; i < obj_room_dtl.length; i++) {
//            //str_room += '<option value="' + obj_room_dtl[i]['room_id'] + '">' + obj_room_dtl[i]['room_id'] + ' - ' + obj_room_dtl[i]['name'] + '</option>';
//        }
//    }
//    else {
//        var temp_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return data.capacity >= capacity });

//        if (temp_room_dtl.length > 0) {
//            for (var i = 0; i < temp_room_dtl.length; i++) {
//                str_room += '<option value="' + temp_room_dtl[i]['room_id'] + '">' + temp_room_dtl[i]['room_id'] + ' - ' + temp_room_dtl[i]['name'] + '</option>';
//            }
//        }
//    }
//}


function append_tutor_image(e) {

    //var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

    //var sub_group_id = temp_selected_typology[0]['sub_group'];
    var instructor_code = "'" + e.value + "'";
    current_row_id = e.closest('tr').dataset["row_no"];
    //07052022
    var inst_new_ver = e.value;
    var inst_name = '';

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_tutor_image_data",
        //  data: "{instructor_code :'" + instructor_code + "'}",
        data: JSON.stringify({ "instructor_code": instructor_code }),
        dataType: "json",
        success: function (data) {
            if (data.d != "") {

                var profile_data = JSON.parse(data.d);
                inst_name = profile_data[0]['user_name'];
                //new add 10052022
                $('.hig_' + current_row_id).text('');
                $('.toex_' + current_row_id).text('');
                if (profile_data[0]['highest_qualification'] != '') {
                    $('.hig_' + current_row_id).text(profile_data[0]['highest_qualification']);
                }
                
                if (profile_data[0]['total_experiance'] != '') {
                    $('.toex_' + current_row_id).text(profile_data[0]['total_experiance']);

                }
                if (document.querySelectorAll("[data-bind_row_no='" + current_row_id + "']").length > 0)
                {
                    if (profile_data[0]['profile_photo'] != '' && profile_data[0]['profile_photo'] != null && profile_data[0]['profile_photo'] != undefined) {
                        if (document.querySelectorAll("img[data-bind_row_no='" + current_row_id + "']").length > 0) {
                            if (profile_data[0]['profile_photo'].indexOf("/") >= 0) {
                                document.querySelectorAll("img[data-bind_row_no='" + current_row_id + "']")[0].src = profile_data[0]['profile_photo'];
                            }
                            else {
                                document.querySelectorAll("img[data-bind_row_no='" + current_row_id + "']")[0].src = "../../UserPersonalPhoto/" + profile_data[0]['profile_photo'];
                            }

                        }


                    }
                    else {

                    }

                    //$("[data-bind_row_no='" + current_row_id + "']").remove();
                    if (document.querySelectorAll("label[data-bind_row_no='" + current_row_id + "']").length > 0) {
                        document.querySelectorAll("label[data-bind_row_no='" + current_row_id + "']")[0].innerHTML = profile_data[0]["user_name"]
                    }
                    if (document.querySelectorAll("span[data-bind_row_no='" + current_row_id + "']").length > 0) {
                        document.querySelectorAll("span[data-bind_row_no='" + current_row_id + "']")[0].innerHTML = 'Profile For ' + profile_data[0]["user_name"];
                    }
                    if (document.querySelectorAll("textarea[data-bind_row_no='" + current_row_id + "']").length > 0) {
                        document.querySelectorAll("textarea[data-bind_row_no='" + current_row_id + "']")[0].value = profile_data[0]["education_description"];
                    }
                    document.querySelectorAll("textarea[data-bind_row_no='" + current_row_id + "']")[0].id = e.value;
                    //var textArea = $('<span data-bind_row_no="' + current_row_id + '">Profile For ' + profile_data[0]["user_name"] + '</span><textarea id="' + profile_data[0]["instructor_code"] + '" style="width: 100%"   rows="4" cols="50" onkeypress="tutor_charcount(event)" onkeydown="return keydown_tutor_removechar(event)" name="address" data-bind_row_no="' + current_row_id + '">' + profile_data[0]["education_description"] + '</textarea><span style="float: right; margin-bottom: 10px;" data-bind_row_no="' + current_row_id + '">Total Char : 400</span>');
                    //$("#profile_desc").append(textArea);
                }
                else
                {
                    if (profile_data[0]['profile_photo'] != '' && profile_data[0]['profile_photo'] != null && profile_data[0]['profile_photo'] != undefined) {

                        var user_name = document.createElement('label');

                        var textArea = $('<span data-bind_row_no="' + current_row_id + '">Profile For ' + profile_data[0]["user_name"] + '</span><textarea id="' + profile_data[0]["instructor_code"] + '" style="width: 100%"   rows="4" cols="50" onkeypress="tutor_charcount(event)" onkeydown="return keydown_tutor_removechar(event)" name="address" data-bind_row_no="' + current_row_id + '">' + profile_data[0]["education_description"] + '</textarea><span style="float: right; margin-bottom: 10px;" data-bind_row_no="' + current_row_id + '">Total Char : 400</span>');
                        $("#profile_desc").append(textArea);
                        //$('#' + profile_data[0]["instructor_code"]).val('');

                        user_name.className = 'col-md-2';
                        user_name.style.fontWeight = "bold";
                        //user_name.id = profile_data[0]["instructor_code"];
                        user_name.innerHTML = profile_data[0]["user_name"];


                        var img = document.createElement('img');
                        img.style.width = '140px';
                        img.style.height = '150px';
                        img.style.margin = '0px -7px 0px 0px ';
                        img.className = 'col-md-2';
                        //img.id = profile_data[0]["instructor_code"];
                        if (profile_data[0]['profile_photo'].indexOf("/") >= 0) {
                            img.src = profile_data[0]['profile_photo'];
                        }
                        else {
                            img.src = "../../UserPersonalPhoto/" + profile_data[0]['profile_photo'];
                        }

                        $("#profile_name")[0].appendChild(user_name);
                        $("#img")[0].appendChild(img);
                        user_name.setAttribute('data-bind_row_no', current_row_id)
                        img.setAttribute('data-bind_row_no', current_row_id)


                    }
                    else {
                        var img = document.createElement('img');
                        var user_name = document.createElement('label');
                        user_name.className = 'col-md-2';

                        var textArea = $('<span data-bind_row_no="' + current_row_id + '">Profile For ' + profile_data[0]["user_name"] + '</span><textarea id="' + profile_data[0]["instructor_code"] + '" style="width: 100%"   rows="4" cols="50" onkeypress="tutor_charcount(event)" onkeydown="return keydown_tutor_removechar(event)" data-bind_row_no="' + current_row_id + '" name="address">' + profile_data[0]["education_description"] + '</textarea><span style="float: right; margin-bottom: 10px;" data-bind_row_no="' + current_row_id + '">Total Char : 400</span>');
                        $("#profile_desc").append(textArea)
                        user_name.style.fontWeight = "bold";
                        //user_name.id = profile_data[0]["instructor_code"];
                        user_name.innerHTML = profile_data[0]["user_name"];

                        img.style.width = '140px';
                        img.style.height = '150px';
                        img.style.margin = '0px -7px 0px 0px ';
                        img.className = 'col-md-2';
                        //img.id = profile_data[0]["instructor_code"];
                        $("#img")[0].appendChild(img);
                        $("#profile_name")[0].appendChild(user_name);
                        user_name.setAttribute('data-bind_row_no', current_row_id);
                        img.setAttribute('data-bind_row_no', current_row_id);

                    }
                }




                //07052022
                var dropdown_list = '';
                var from_time = '';
                var to_time = '';
                var row_count_val = '';
                $("#tbltimeday tbody tr").each(function (j) {
                    from_time = convertTime($(this).find(".from_time").val());
                    to_time = convertTime($(this).find(".to_time").val());
                    var class_room = $(this).find(".cls_roomid").val();
                    var drpday1 = $(this).find(".drpday").val();
                    var drpday_code = $(this).find(".drpday").val();
                    drpday1 = Week(drpday1);
                    drpday1 = day_value;
                    if (j == 0) {
                        var inst_code_new = inst_new_ver;
                        inst_code_new = inst_code_new + '_' + 1;

                        dropdown_list += "<select class='timesolt_drp' id=" + inst_code_new + "><option value=''>Please Select Time Slot</option>"; //class='js-select2-multi' multiple='multiple'
                        dropdown_list += "<option class='cls_" + j + "'  value='" + from_time + '@@' + to_time + '@@' + drpday_code + '@@' + class_room + "'>" + from_time + '-' + to_time + '-' + drpday1 + '-' + class_room + "</option>";
                    }
                    else { dropdown_list += "<option class='cls_" + j + "' value='" + from_time + '@@' + to_time + '@@' + drpday_code + '@@' + class_room + "'>" + from_time + '-' + to_time + '-' + drpday1 + '-' + class_room + "</option>"; }

                });
                dropdown_list += "</select>";

                inst_id_with = instructor_code;
                //changes  id=' + instructor_code + '
                var new_class = current_row_id + " " + inst_new_ver;
                var string_html = '<tr class ="' + new_class + '"  data-row_no =' + current_row_id + '><td id=' + current_row_id + ' class = inst_name>';
                string_html += inst_name + '</td>';
                string_html += "<td>" + dropdown_list + "</td>";
                var new_class_btn = 'addRows' + " " + inst_new_ver;
                string_html += "<td><input type='button' id =" + instructor_code + " value='Add' class= '" + new_class_btn +"' /></td>";
                string_html += "<td></td>";
                string_html += '</tr>';
                if ($('#tblinstructor_time_slot tbody tr').length > 0) {

                    if ($('#tblinstructor_time_slot tbody .' + current_row_id).length > 0)
                    {
                        var td_id = $('#tblinstructor_time_slot tbody .' + current_row_id)[0].classList[1];
                        $('#tblinstructor_time_slot tbody .' + current_row_id).remove();
                        $('#tblinstructor_time_slot tbody tr.c_' + td_id).remove();
                       // $('#tbody_tblinstructor_time_slot').append(string_html);
                        //if ($('#tblinstructor_time_slot tbody .' + current_row_id)[0].children[0].innerHTML != '' && $('#tblinstructor_time_slot tbody .' + current_row_id)[0].children[0].innerHTML != undefined) {
                        //    $('#tblinstructor_time_slot tbody .' + current_row_id)[0].children[0].innerHTML = inst_name;
                        //    var id_value = $('#tblinstructor_time_slot tbody .' + current_row_id)[0].classList[0];
                        //    $('#tblinstructor_time_slot tbody .' + current_row_id)[0].classList.value = id_value + ' ' + inst_new_ver;
                        //}
                        //else { $('#tbody_tblinstructor_time_slot').append(string_html); }
                    }
                    else {
                       // $('#tbody_tblinstructor_time_slot').append(string_html);
                    }

                }
                else {
                    //$('#tbody_tblinstructor_time_slot').append(string_html);
                }


                var new_string = "";
                new_string += '<tr class ="' + new_class + '"  data-row_no =' + current_row_id + '><td colspan = 7  id=' + current_row_id + ' class = inst_name ' + row_count_val + '>' + inst_name + '</td></tr>';
                $("#tbltimeday tbody tr").each(function (j) {
                    row_count_val = 'rowselect_' + j;
                    from_time = convertTime($(this).find(".from_time").val());
                    to_time = convertTime($(this).find(".to_time").val());
                    var class_room = $(this).find(".cls_roomid").val();
                    var drpday1 = $(this).find(".drpday").val();
                    var drpday_code = $(this).find(".drpday").val();
                    drpday1 = Week(drpday1);
                    drpday1 = day_value;
                    var inst_code_new = inst_new_ver;
                    var current_tr_id = 'c_' + inst_code_new;
                    inst_code_new = inst_code_new + '_' + j;
                    var inst_code_new_from = 'from' + '_' + inst_code_new;
                    var inst_code_new_to = 'to' + '_' + inst_code_new
                    //var inst_id = inst_code_ + '_' + j;

                    new_string += "<tr class ='" + current_tr_id + ' ' + row_count_val + "'><td></td><td><input style='width: 56px;' id='" + inst_code_new_from + "' type='text' class='from_time_" + j + ' ' + inst_code_new_from + ' ' + 'from_time' + "' /></td><td><input id='" + inst_code_new_to + "' style='width: 56px;' type='text' class='to_time_" + j + ' ' + inst_code_new_to + ' ' + 'to_time' + "' /></td><td class='day_value_" + j + ' ' + 'day_value' + "'>" + drpday1 + "</td><td class='room_value_" + j + ' ' + 'class_room_id ' + "'>" + class_room + "</td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td></tr>";

                });

                $('#tbody_tblinstructor_time_slot').append(new_string);

                $("#tbltimeday tbody tr").each(function (j) {
                    from_time = $(this).find(".from_time").val();
                    to_time = $(this).find(".to_time").val();
                    var inst_code_new = inst_new_ver;
                    inst_code_new = inst_code_new + '_' + j;
                    var inst_code_new_from = 'from' + '_' + inst_code_new;
                    var inst_code_new_to = 'to' + '_' + inst_code_new;
                    $('.' + inst_code_new_from).timepicker({
                        minTime: from_time,
                        maxTime: to_time,
                        dynamic: false
                    });

                    $("." + inst_code_new_to).timepicker({
                        minTime: from_time,
                        maxTime: to_time,
                        dynamic: false
                    });
                });
                appendtimeslotdtl();
               
            }
        },
        error: function (result) {
            alert(result);
        }
    });

}

//changes 13052022
function add_new_rows() {
    if ($('#tblinstructor_time_slot tbody tr').length > 0) {
        var instructor_data_list = [];

        $("#tblinstructor tbody tr").each(function (j) {
            var instructor_data = { 'instructor_code': '' };
            instructor_data.instructor_code = $(this).find(".drpinstructor").val();
            instructor_data_list.push(instructor_data);

        });

        for (var i = 0; i < instructor_data_list.length; i++) {
            var new_string = '';
            var inst_code = instructor_data_list[i]['instructor_code'];
            //$(this).find(".drpinstructor").val();
            if (inst_code != '') {
                var new_inst = inst_code;
                inst_code = 'c_' + inst_code;
                var current_tr_id = 'c_' + new_inst;
                var row_leng_index = $('#tbltimeday tbody tr').length - 1;
                var inst_code_new = new_inst + '_' + row_leng_index;
                var inst_code_new_from = 'from' + '_' + inst_code_new;
                var inst_code_new_to = 'to' + '_' + inst_code_new;
                row_count_val = 'rowselect_' + row_leng_index;

                new_string += "<tr class ='" + current_tr_id + ' ' + row_count_val + "'><td></td><td><input style='width: 56px;' id='" + inst_code_new_from + "' type='text' class='from_time_" + row_leng_index + ' ' + inst_code_new_from + ' ' + 'from_time' + "' /></td><td><input id='" + inst_code_new_to + "' style='width: 56px;' type='text' class='to_time_" + row_leng_index + ' ' + inst_code_new_to + ' ' + 'to_time' + "' /></td><td class='day_value_" + row_leng_index + ' ' + 'day_value' + "'></td><td class='room_value_" + row_leng_index + ' ' + 'class_room_id ' + "'></td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td></tr>";

                var new_row = $('.' + inst_code).length - 1;
                if ($('.' + inst_code).length == 0) {
                    $(new_string).insertAfter($('.' + new_inst)[0]);
                    // $('#tblinstructor_time_slot tbody').closest('tr').after(new_string);
                }
                else {
                    $(new_string).insertAfter($('.' + inst_code)[new_row]);
                }
                $(".from_time_" + row_leng_index).timepicker({ 'minTime': '8:00am' });
                $(".to_time_" + row_leng_index).timepicker({ 'minTime': '8:00am' });

            }

        }
    }
}

//07052022
$('#tblinstructor_time_slot tbody tr td .addRows').live('click', function (e) {
    var dropdown_list = '';
    var inst_code_ = '';
    
    if (e.target.classList[1] != undefined) {
        inst_code_ = e.target.classList[1];
    }
    else if (e.currentTarget.attributes[1].ownerElement.classList[1] != undefined) { inst_code_ = e.currentTarget.attributes[1].ownerElement.classList[1]; }
    else if (e.currentTarget.attributes[1].nodeValue != undefined)
    { inst_code_ = e.currentTarget.attributes[1].nodeValue; }

    var col = $(this).parent().children().index($(this));
    var row = $(this).parent().parent().children().index($(this).parent());
    var after_row_add = '';
    var current_tr_id = '';
    var row_count = '';
    $("#tbltimeday tbody tr").each(function (j) {
        var inst_code = $(this).find(".inst_name").val();
        from_time = convertTime($(this).find(".from_time").val());
        var to_time = convertTime($(this).find(".to_time").val());
        var class_room = $(this).find(".cls_roomid").val();
        var drpday1 = $(this).find(".drpday").val();
        var drpday_code = $(this).find(".drpday").val();
        drpday1 = Week(drpday1);
        drpday1 = day_value;
        current_tr_id = 'c_' + inst_code_;
        row_count = $('#tbody_tblinstructor_time_slot tr#' + current_tr_id).length;
        after_row_add = row_count;
        row_count = parseInt(parseInt(row_count) + parseInt(2));
        if (j == 0) {
            var inst_id = inst_code_ + '_' + row_count;
            dropdown_list += "<select class='timesolt_drp' id =" + inst_id + "><option value=''>Please Select Time Slot</option>"; //class='js-select2-multi' multiple='multiple'
            dropdown_list += "<option class='cls_" + j + "'  value='" + from_time + '@@' + to_time + '@@' + drpday_code + '@@' + class_room + "'>" + from_time + '-' + to_time + '-' + drpday1 + '-' + class_room + "</option>";
        }
        else {
            dropdown_list += "<option class='cls_" + j + "' value='" + from_time + '@@' + to_time + '@@' + drpday_code + '@@' + class_room + "'>" + from_time + '-' + to_time + '-' + drpday1 + '-' + class_room + "</option>";
        }

    });
    dropdown_list += "</select>";
    var row_data = "";
    var row_id = 'c_' + inst_code_;
    var row_cls = 'c_' + inst_code_ + '_select';
    row_data = "<tr id =" + row_id + " class='" + row_cls+"'><td style='display:block;' class=inst_name></td><td>" + dropdown_list + "</td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td>";
    row_data += "</tr>";
    var new_row = $('.c_' + inst_code_ + '_select').length - 1;
    if ($('.c_' + inst_code_ + '_select').length == 0) {
        $(this).closest('tr').after(row_data);
    } else {
        $(row_data).insertAfter($('.c_' + inst_code_ + '_select')[new_row]);
    }
    

    //$(this).closest('tr').after(row_data);
    

});
var day_value = '';
function Week(val) {

    switch (parseInt(val)) {

        case 1:
            day_value = "Monday";
            break;
        case 2:
            day_value = "Tuesday";
            break;
        case 3:
            day_value = "Wednesday";
            break;
        case 4:
            day_value = "Thursday";
            break;
        case 5:
            day_value = "Friday";
            break;
        case 6:
            day_value = "Saturday";
    }

}

function create_str_room() {

    //call ajax start

    if (current_row_id_room != null && current_row_id_room != 'undefined') {

        current_year = $('#drpyear').val();
        current_sem = $('#drpsemester').val();

        var f_time_ = parseFloat(convertTime($('#' + current_row_id_room + '').find('.from_time').val()));
        var t_time_ = parseFloat(convertTime($('#' + current_row_id_room + '').find('.to_time').val()));
        var selected_day_ = $('#' + current_row_id_room + '').find('.drpday').val();

        if (f_time_ != 0 && t_time_ != 0 && selected_day_ != "" && current_sem != "" && current_year != "") {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_day_wise_room_detail",
                async: false,
                data: "{from_time : '" + f_time_ + "',to_time : '" + t_time_ + "',day_code : '" + selected_day_ + "',sem_code : '" + current_sem + "',year_code : '" + current_year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var room_id = JSON.parse(data.d);
                        obj_room_dtl = room_id;
                    }
                    else {
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }

    }

    //call ajax end

    //$('.cls_roomid').html('<option value="">--</option>');
    $('.cls_roomid_tutorial').html('<option value="">--</option>');
    var studio_flag = false;

    if ($('#drptypology').val() != '') {
        var temp_selected_typology = [];

        ////if ($('#drp_typology_group').val() == 'old') {
        //if ($('#drp_typology_group').val() == 'G001') {
        //    temp_selected_typology = jQuery.grep(old_typology, function (data) { return data.type_code === $('#drptypology').val() });
        //}
        ////else if ($('#drp_typology_group').val() == 'new') {
        //else if ($('#drp_typology_group').val() == 'G002') {
        //    temp_selected_typology = jQuery.grep(new_typology, function (data) { return data.type_code === $('#drptypology').val() });
        //}

        temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

        if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003') {
            //var temp_str_room = '<option value="studio">Studio</option><option value="auditorium">Auditorium</option>';
            //$('.cls_roomid').html(temp_str_room);
            //$('.cls_roomid_tutorial').html(temp_str_room);
            studio_flag = true;
            $('#div_course_image').css('display', 'block');
        }
        else
            $('#div_course_image').css('display', 'none');
    }
    else {
        $('#div_course_image').css('display', 'none');
    }

    //if (!studio_flag) {
    if ($('#txtavailable_seats').val() == '' || $('#txtavailable_seats').val() == '0') {
        var temp_str_room = '<option value="">--</option>';
        $('.cls_roomid').html(temp_str_room);
        $('.cls_roomid_tutorial').html(temp_str_room);
    }
    else {
        
        var temp_room_dtl = [];
        var without_dept_dtl = [];
        var university_room_dtl = [];

        //university_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return data.possession == "University" });
        university_room_dtl = jQuery.grep(obj_room_dtl, function (data)
        {
            if (parseFloat($('#txtavailable_seats').val()) < 60) {
                return data.possession == "University" && (parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) || data.capacity == "") && data.room_id != 'FP-103' && data.room_id != 'U16-101' && data.room_id != 'U05-201';
            }
            else {
                return data.possession == "University" && (parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) || data.capacity == "")
            }
        });

        //if (parseFloat($('#txtavailable_seats').val()) < 60)
        //    temp_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) && parseFloat(data.capacity) <= 60 });
        //else
        //    temp_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) });

        temp_room_dtl = jQuery.grep(obj_room_dtl, function (data)
        {
            if (parseFloat($('#txtavailable_seats').val()) < 60)
            {
                return data.possession != "University" && parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) && data.room_id != 'FP-103' && data.room_id != 'U16-101' && data.room_id != 'U05-201';
            }
            else {
                return data.possession != "University" && parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val())
            }

            //return parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val())
        });


        if (studio_flag) {
            temp_room_dtl = jQuery.grep(temp_room_dtl, function (data) { return data.possession == short_dept[$('#drpdepartment').val()] && data.room_type == 'Studio' });
        }
        else {
            without_dept_dtl = jQuery.grep(temp_room_dtl, function (data) { return data.possession != short_dept[$('#drpdepartment').val()] });
            temp_room_dtl = jQuery.grep(temp_room_dtl, function (data) { return data.possession == short_dept[$('#drpdepartment').val()] });

            // Changes By Nitin 26062023 studio type and course type changes 
            //if (without_dept_dtl.length > 0)
            //{
            //    for (var p = 0; p < without_dept_dtl.length; p++)
            //    {
            //        temp_room_dtl.push(without_dept_dtl[p]);
            //    }
            //}
            


            //temp_room_dtl = jQuery.grep(temp_room_dtl, function (data) { return data.room_type != 'Studio' });
        }

        for (var g = 0; g < university_room_dtl.length; g++) {
            if (university_room_dtl[g]['possession'] == "University" && university_room_dtl[g]['room_type'] == "Lecture Space" && studio_flag == true)
            {
            }
            else
            {
                temp_room_dtl.push(university_room_dtl[g]);
            }
            
        }

        if (temp_room_dtl.length > 0) {
            $('#tbltimeday tbody tr').each(function (e) {
                var temp_str_room = '<option value="">--</option>';

                if ($(this).find('.from_time').val() != '' && $(this).find('.to_time').val() != '' && $(this).find('.drpday').val() != '') {
                    var f_time = parseFloat(convertTime($(this).find('.from_time').val()));
                    var t_time = parseFloat(convertTime($(this).find('.to_time').val()));
                    var selected_day = $(this).find('.drpday').val();

                    var allocated_room = jQuery.grep(all_course_time_data, function (data) {
                        return data.day_code === selected_day && data.course_code != $('#hdn_ccode').val() &&
                            ((data.FromTime <= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime <= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time));
                    });

                    for (var i = 0; i < temp_room_dtl.length; i++) {

                        var f_boolen = false;

                        if (parseFloat('16.3') <= parseFloat(f_time_) && parseFloat(f_time_) <= parseFloat('19.3') && temp_room_dtl[i]['room_id'] == "FP103") {
                            f_boolen = true;
                        }
                        if (parseFloat('16.3') <= parseFloat(t_time_) && parseFloat(t_time_) <= parseFloat('19.3') && temp_room_dtl[i]['room_id'] == "FP103") {
                            f_boolen = true;
                        }
                        if (parseFloat('10.3') <= parseFloat(f_time_) && parseFloat(f_time_) <= parseFloat('12.3') && selected_day_ == '2' && temp_room_dtl[i]['room_id'] == "FP103") {
                            f_boolen = true
                        }
                        if (parseFloat('10.3') <= parseFloat(t_time_) && parseFloat(t_time_) <= parseFloat('12.3') && selected_day_ == '2' && temp_room_dtl[i]['room_id'] == "FP103") {
                            f_boolen = true;
                        }

                        if (jQuery.grep(allocated_room, function (data) { return data.room_id === temp_room_dtl[i]['room_id'] }).length == 0) {
                            //if (parseFloat(temp_room_dtl[i]['available_start_time']) <= f_time && parseFloat(temp_room_dtl[i]['available_end_time']) >= t_time) {
                            if (!f_boolen)
                            {
                                temp_str_room += '<option value="' + temp_room_dtl[i]['room_id'] + '">' + temp_room_dtl[i]['room_id'] + ' - ' + temp_room_dtl[i]['name'] + ' (' + temp_room_dtl[i]['capacity'] + ')'+ '</option>';
                            }
                            //}
                        }
                    }
                }

                var cur_selection = $(this).find('.cls_roomid').val();
                $(this).find('.cls_roomid').html(temp_str_room);
                $(this).find('.cls_roomid').val(cur_selection);
            });

            $('#tbltimeday_tutorial tbody tr').each(function (e) {
                var temp_str_room = '<option value="">--</option>';

                if ($(this).find('.from_time_tutorial').val() != '' && $(this).find('.to_time_tutorial').val() != '' && $(this).find('.drpday_tutorial').val() != '') {
                    var f_time = parseFloat(convertTime($(this).find('.from_time_tutorial').val()));
                    var t_time = parseFloat(convertTime($(this).find('.to_time_tutorial').val()));
                    var selected_day = $(this).find('.drpday_tutorial').val();

                    var allocated_room = jQuery.grep(all_course_time_data, function (data) {
                        return data.day_code === selected_day && data.course_code != $('#hdn_ccode').val() &&
                            ((data.FromTime <= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime <= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time));
                    });

                    for (var i = 0; i < temp_room_dtl.length; i++) {
                        if (jQuery.grep(allocated_room, function (data) { return data.room_id === temp_room_dtl[i]['room_id'] }).length == 0) {
                            if (parseFloat(temp_room_dtl[i]['available_start_time']) <= f_time && parseFloat(temp_room_dtl[i]['available_end_time']) >= t_time) {
                                temp_str_room += '<option value="' + temp_room_dtl[i]['room_id'] + '">' + temp_room_dtl[i]['room_id'] + ' - ' + temp_room_dtl[i]['name'] + '</option>';
                            }
                        }
                    }
                }

                var cur_selection = $(this).find('.cls_roomid_tutorial').val();
                $(this).find('.cls_roomid_tutorial').html(temp_str_room);
                $(this).find('.cls_roomid_tutorial').val(cur_selection);
            });
        }
        else {
            $('.cls_roomid').html(temp_str_room);
            $('.cls_roomid_tutorial').html(temp_str_room);
        }
    }
    //}
}

var obj_days = { '1': 'Monday', '2': 'Tuesday', '3': 'Wednesday', '4': 'Thursday', '5': 'Friday', '6': 'Saturday' };
var cur_tr;
function view_allocated_room_dtl(cur_ele) {
    $('#tbl_allocated_rooms tbody').html('');
    $('#tbl_available_rooms tbody').html('');
    cur_tr = $(cur_ele).closest('tr');

    if (cur_tr.find('.cls_roomid').val() != 'studio' && cur_tr.find('.cls_roomid').val() != 'auditorium') {
        if (cur_tr.find('.from_time').val() != '' && cur_tr.find('.to_time') != '' && cur_tr.find('.drpday') != '' && $('#txtavailable_seats').val() != '' && $('#txtavailable_seats').val() != '0') {
            var f_time = parseFloat(convertTime(cur_tr.find('.from_time').val()));
            var t_time = parseFloat(convertTime(cur_tr.find('.to_time').val()));
            var time_diff = t_time - f_time;
            if (time_diff.toFixed(2).search('.70') > -1) time_diff = time_diff - 0.4;
            var selected_day = cur_tr.find('.drpday').val();

            var allocated_room = jQuery.grep(all_course_time_data, function (data) {
                return data.day_code === selected_day && data.course_code != $('#hdn_ccode').val() &&
                    ((data.FromTime <= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                        (data.FromTime <= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                        (data.FromTime >= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                        (data.FromTime >= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time));
            });

            var str_html = '';
            for (var i = 0; i < allocated_room.length; i++) {
                str_html = str_html + '<tr><td>' + allocated_room[i]['from_time'] + '</td><td>' + allocated_room[i]['To_time'] + '</td>' +
                    '<td>' + obj_days[allocated_room[i]['day_code']] + '</td><td>' + allocated_room[i]['room_id'] + '</td><td>' + allocated_room[i]['course_code'] + '</td></tr>';
            }
            $('#tbl_allocated_rooms tbody').html(str_html);

            var temp_room_dtl = [];

            //if (parseFloat($('#txtavailable_seats').val()) < 60)
            //    temp_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) && parseFloat(data.capacity) <= 60 });
            //else
            //    temp_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) });
            temp_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) });
            var temp_selected_typology = jQuery.grep(obj_typology[$('#drp_typology_group').val()], function (data) { return data.type_code === $('#drptypology').val() });

            if (temp_selected_typology.length > 0 && temp_selected_typology[0]['sub_group'] == 'SG003')
                temp_room_dtl = jQuery.grep(temp_room_dtl, function (data) { return data.possession == short_dept[$('#drpdepartment').val()] && data.room_type == 'Studio' });
            else
                temp_room_dtl = jQuery.grep(temp_room_dtl, function (data) { return data.room_type != 'Studio' });

            if (temp_room_dtl.length > 0) {

                var obj_time = [];
                for (var i = 8; i <= 19; i++) {
                    obj_time.push({ 'from_time': i, 'to_time': i + time_diff });
                    if (time_diff.toFixed(2).search('.30') > -1)
                        obj_time.push({ 'from_time': i + 0.3, 'to_time': i + 0.7 + time_diff });
                    else
                        obj_time.push({ 'from_time': i + 0.3, 'to_time': i + 0.3 + time_diff });
                }

                for (var j = 0; j < obj_time.length; j++) {
                    f_time = obj_time[j]['from_time'];
                    t_time = obj_time[j]['to_time'];

                    allocated_room = jQuery.grep(all_course_time_data, function (data) {
                        return data.day_code === selected_day &&
                            ((data.FromTime <= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime <= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time));
                    });

                    for (var i = 0; i < temp_room_dtl.length; i++) {
                        if (jQuery.grep(allocated_room, function (data) { return data.room_id === temp_room_dtl[i]['room_id'] }).length == 0) {
                            if (parseFloat(temp_room_dtl[i]['available_start_time']) <= f_time && parseFloat(temp_room_dtl[i]['available_end_time']) >= t_time) {
                                $('#tbl_available_rooms tbody').append('<tr><td class="avlbl_f_time">' + f_time.toFixed(2) + '</td><td class="avlbl_t_time">' + t_time.toFixed(2) + '</td>' +
                                    '<td class="avlbl_day" style="display:none;">' + selected_day + '</td><td>' + obj_days[selected_day] + '</td><td class="avlbl_room_id">' + temp_room_dtl[i]['room_id'] + '</td>' +
                                    '<td>' + temp_room_dtl[i]['name'] + '</td><td><a class="cls_select_time_room">Select</a></td></tr>');
                            }
                        }
                    }
                }
            }

            $('#btn_show_modal').click();
        }
        else {
            bootbox.alert("Please enter From Time, To Time, Day and Available Seats to view Allocated Rooms");
        }
    }
}

function view_allocated_room_dtl_tutorial(cur_ele) {
    $('#tbl_allocated_rooms tbody').html('');
    $('#tbl_available_rooms tbody').html('');
    cur_tr = $(cur_ele).closest('tr');

    if (cur_tr.find('.cls_roomid_tutorial').val() != 'studio' && cur_tr.find('.cls_roomid_tutorial').val() != 'auditorium') {
        if (cur_tr.find('.from_time_tutorial').val() != '' && cur_tr.find('.to_time_tutorial') != '' && cur_tr.find('.drpday_tutorial') != '' && $('#txtavailable_seats').val() != '' && $('#txtavailable_seats').val() != '0') {
            var f_time = parseFloat(convertTime(cur_tr.find('.from_time_tutorial').val()));
            var t_time = parseFloat(convertTime(cur_tr.find('.to_time_tutorial').val()));
            var time_diff = t_time - f_time;
            if (time_diff.toFixed(2).search('.70') > -1) time_diff = time_diff - 0.4;
            var selected_day = cur_tr.find('.drpday_tutorial').val();

            var allocated_room = jQuery.grep(all_course_time_data, function (data) {
                return data.day_code === selected_day && data.course_code != $('#hdn_ccode').val() &&
                    ((data.FromTime <= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                        (data.FromTime <= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                        (data.FromTime >= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                        (data.FromTime >= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time));
            });

            var str_html = '';
            for (var i = 0; i < allocated_room.length; i++) {
                str_html = str_html + '<tr><td>' + allocated_room[i]['from_time'] + '</td><td>' + allocated_room[i]['To_time'] + '</td>' +
                    '<td>' + obj_days[allocated_room[i]['day_code']] + '</td><td>' + allocated_room[i]['room_id'] + '</td><td>' + allocated_room[i]['course_code'] + '</td></tr>';
            }
            $('#tbl_allocated_rooms tbody').html(str_html);

            var temp_room_dtl = jQuery.grep(obj_room_dtl, function (data) { return parseFloat(data.capacity) >= parseFloat($('#txtavailable_seats').val()) });

            if (temp_room_dtl.length > 0) {

                var obj_time = [];
                for (var i = 8; i <= 19; i++) {
                    obj_time.push({ 'from_time': i, 'to_time': i + time_diff });
                    if (time_diff.toFixed(2).search('.30') > -1)
                        obj_time.push({ 'from_time': i + 0.3, 'to_time': i + 0.7 + time_diff });
                    else
                        obj_time.push({ 'from_time': i + 0.3, 'to_time': i + 0.3 + time_diff });
                }

                for (var j = 0; j < obj_time.length; j++) {
                    f_time = obj_time[j]['from_time'];
                    t_time = obj_time[j]['to_time'];

                    allocated_room = jQuery.grep(all_course_time_data, function (data) {
                        return data.day_code === selected_day &&
                            ((data.FromTime <= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime <= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime <= t_time && data.ToTime > f_time && data.FromTime < t_time) ||
                                (data.FromTime >= f_time && data.ToTime >= t_time && data.ToTime > f_time && data.FromTime < t_time));
                    });

                    for (var i = 0; i < temp_room_dtl.length; i++) {
                        if (jQuery.grep(allocated_room, function (data) { return data.room_id === temp_room_dtl[i]['room_id'] }).length == 0) {
                            if (parseFloat(temp_room_dtl[i]['available_start_time']) <= f_time && parseFloat(temp_room_dtl[i]['available_end_time']) >= t_time) {
                                $('#tbl_available_rooms tbody').append('<tr><td class="avlbl_f_time">' + f_time.toFixed(2) + '</td><td class="avlbl_t_time">' + t_time.toFixed(2) + '</td>' +
                                    '<td class="avlbl_day" style="display:none;">' + selected_day + '</td><td>' + obj_days[selected_day] + '</td><td class="avlbl_room_id">' + temp_room_dtl[i]['room_id'] + '</td>' +
                                    '<td>' + temp_room_dtl[i]['name'] + '</td><td><a class="cls_select_time_room_tutorial">Select</a></td></tr>');
                            }
                        }
                    }
                }
            }

            $('#btn_show_modal').click();
        }
        else {
            bootbox.alert("Please enter From Time, To Time, Day and Available Seats to view Allocated Rooms");
        }
    }
}

$('#tbltimeday tbody tr td .cls_view_room').live('click', function (e) {
    view_allocated_room_dtl(this);
});

$('#tbltimeday_tutorial tbody tr td .cls_view_room_tutorial').live('click', function (e) {
    view_allocated_room_dtl_tutorial(this);
});

$('.cls_select_time_room').live('click', function (e) {
    var row = $(this).closest('tr');

    cur_tr.find('.from_time').val(row.find('.avlbl_f_time').html());
    cur_tr.find('.to_time').val(row.find('.avlbl_t_time').html());
    cur_tr.find('.drpday').val(row.find('.avlbl_day').html());
    cur_tr.find('.cls_roomid').val(row.find('.avlbl_room_id').html());

    setTimepicker();
    calcTotalHour('');

    $('#btn_modal_close').click();
});

$('.cls_select_time_room_tutorial').live('click', function (e) {
    var row = $(this).closest('tr');

    cur_tr.find('.from_time_tutorial').val(row.find('.avlbl_f_time').html());
    cur_tr.find('.to_time_tutorial').val(row.find('.avlbl_t_time').html());
    cur_tr.find('.drpday_tutorial').val(row.find('.avlbl_day').html());
    cur_tr.find('.cls_roomid_tutorial').val(row.find('.avlbl_room_id').html());

    setTimepicker();
    calcTotalHour('');

    $('#btn_modal_close').click();
});

var all_course_time_data = [];
function get_all_course_time_data(cur_sem, cur_year) {
    var call_flag = false;

    if (all_course_time_data.length > 0) {
        if (all_course_time_data[0]['semester_type'] != cur_sem || all_course_time_data[0]['year_semester'] != cur_year) {
            call_flag = true;
        }
    }
    else {
        call_flag = true;
    }

    if (call_flag) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_all_course_time_data",
            data: "{sem_code : '" + cur_sem + "',year_code : '" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    all_course_time_data = JSON.parse(data.d);

                    create_str_room();
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
}

//function intake_capacity_change() {
//    if ($('#txtavailable_seats').val() == '' || $('#txtavailable_seats').val() == '0') {
//        create_str_room();
//    }
//    else {
//        create_str_room($('#txtavailable_seats').val());
//    }

//    for (var i = 0; i < $('.cls_roomid').length; i++) {
//        var cur_selection = $('.cls_roomid')[i].value;
//        $('.cls_roomid')[i].innerHTML = str_room;
//        $('.cls_roomid')[i].value = cur_selection;
//    }

//    for (var i = 0; i < $('.cls_roomid_tutorial').length; i++) {
//        var cur_selection = $('.cls_roomid_tutorial')[i].value;
//        $('.cls_roomid_tutorial')[i].innerHTML = str_room;
//        $('.cls_roomid_tutorial')[i].value = cur_selection;
//    }
//}

function bind_group_wise_typology() {

    typology_detail = [];
    $('#drptypology').empty().append($("<option></option>").val("").html("-- Please Select Typology --"));
    $('#drptypology').trigger("liszt:updated");

    if ($('#drp_semester').val() != "" && $('#drpdepartment').val() != "" && $('#drpprog').val() != "") {

        var obj_req = {
            semester_code: $('#drp_semester').val(), dept_code: $('#drpdepartment').val(), prog_code: $('#drpprog').val(), prog_level_code: $('#drpproglevel').val(), semester: '', year_code: ''
        };

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_group_wise_typology_data",
            data: "{ str_req: '" + JSON.stringify(obj_req) + "' }",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var typology_data = JSON.parse(data.d);
                    typology_detail = typology_data;

                    $('#drptypology').empty().append($("<option></option>").val("").html("-- Please Select Typology --"));

                    for (var i = 0; i < typology_data.length; i++) {
                        $('#drptypology').append($("<option></option>").val(typology_data[i]["type_code"]).html(typology_data[i]["type_name"]));
                    }

                    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
                        $('#drptypology').chosen();
                    }
                }
                else {
                    //bootbox.alert("Course Typology not Found.");
                }

                if (temp_typology != '') {
                    $('#drptypology').val(temp_typology);
                    temp_typology = '';
                }

                $('#drptypology').trigger("liszt:updated");
                set_tutorial_dtl();
            },
            error: function (result) {
                alert(result);
            }
        });
    }
}

function bindprogrammedata() {

    $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        $('#drpprog').chosen();
    }
}

function binddepartment() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var sem_data = JSON.parse(data.d);

                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                for (var i = 0; i < sem_data.length; i++) {
                    $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                }

                if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
                    $('#drpdepartment').chosen();
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindcolor() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_color_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {

                var color_data = JSON.parse(data.d)

                $('#drp_color').empty().append($("<option></option>").val("").html("-Please Select Specialization-"));
                for (var i = 0; i < color_data.length; i++) {
                    $('#drp_color').append($("<option></option>").val(color_data[i]["prog_course_id"]).html(color_data[i]["prog_course_name"]));
                }

                if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
                    $('#drp_color').chosen();
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function rdo_tutorial_click() {
    var rdo_selected = $('input[type=radio][name=rdo_tutorial_offered]:checked').val();

    if (rdo_selected == 'Y') {
        $('#btn_instructor_tutorial').attr('disabled', false);
        $('#btn_time_tutorial').attr('disabled', false);

        $('#tblinstructor_tutorial .drpinstructor_tutorial').attr('disabled', false);
        $('#tblinstructor_tutorial .cls_drp_contact_hrs_tutorial').attr('disabled', false);
        $('#tblinstructor_tutorial .per_load_tutorial').attr('disabled', false);

        $('#tbltimeday_tutorial .from_time_tutorial').attr('disabled', false);
        $('#tbltimeday_tutorial .to_time_tutorial').attr('disabled', false);
        $('#tbltimeday_tutorial .drpday_tutorial').attr('disabled', false);
        $('#tbltimeday_tutorial .cls_roomid_tutorial').attr('disabled', false);

        //$('#dataList_instructor_tutorial').css('display', 'block');
        //$('#datalist_timeday_tutorial').css('display', 'block');
    }
    else {
        $('#btn_instructor_tutorial').attr('disabled', 'disabled');
        $('#btn_time_tutorial').attr('disabled', 'disabled');

        $('#tblinstructor_tutorial .drpinstructor_tutorial').attr('disabled', 'disabled');
        $('#tblinstructor_tutorial .cls_drp_contact_hrs_tutorial').attr('disabled', 'disabled');
        $('#tblinstructor_tutorial .per_load_tutorial').attr('disabled', 'disabled');

        $('#tbltimeday_tutorial .from_time_tutorial').attr('disabled', 'disabled');
        $('#tbltimeday_tutorial .to_time_tutorial').attr('disabled', 'disabled');
        $('#tbltimeday_tutorial .drpday_tutorial').attr('disabled', 'disabled');
        $('#tbltimeday_tutorial .cls_roomid_tutorial').attr('disabled', 'disabled');

        $('#tblinstructor_tutorial tbody').html('');
        $('#tbltimeday_tutorial tbody').html('');

        //$('#dataList_instructor_tutorial').css('display', 'none');
        //$('#datalist_timeday_tutorial').css('display', 'none');
    }
}

$('#tblinstructor tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        var r = confirm("Are you sure you want to remove this?");

        if (r == true) {
            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");
            var inst_code = '';
            inst_code = thisdata.find('.drpinstructor').val();
            if (inst_code != '') {
                $('#tblinstructor_time_slot tbody tr.' + inst_code).remove();
                $('#tblinstructor_time_slot tbody tr.c_' + inst_code).remove();
            }

            $(this).closest("tr").remove();
            $("[data-bind_row_no='" + e.currentTarget.dataset["row_no"] + "']").remove();
            var totalsum = 0;
        }
    }
});

$('#tblinstructor_tutorial tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW' && $('input[type=radio][name=rdo_tutorial_offered]:checked').val() == 'Y') {
        var r = confirm("Are you sure you want to remove this?");

        if (r == true) {
            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");

            $(this).closest("tr").remove();
            var totalsum = 0;
        }
    }
});

$('#tblinstructor_aa tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        var r = confirm("Are you sure you want to remove this?");

        if (r == true) {
            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");

            $(this).closest("tr").remove();
            var totalsum = 0;
        }
    }
});

$('#tblinstructor_ta tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        var r = confirm("Are you sure you want to remove this?");

        if (r == true) {
            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");

            $(this).closest("tr").remove();
            var totalsum = 0;
        }
    }
});

//06052022
$('#tblinstructor_time_slot tbody tr td .deleteRows').live('click', function (e) {

    var r = confirm("Are you sure you want to remove this?");

    if (r == true) {
        var datalist = [];
        var flag = 'Y';
        var ob = {};
        var thisdata = $(this).closest("tr");

        $(this).closest("tr").remove();
        var totalsum = 0;
    }

});

$('#tblarea tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        var r = confirm("Are you sure you want to remove this?");

        if (r == true) {
            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");

            $(this).closest("tr").remove();
            var totalsum = 0;
        }
    }
});

$('#tbltimeday tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        var r = confirm("Are you sure you want to remove this?");

        if (r == true) {
            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");

            var id_value = thisdata[0].attributes[0].value.split('_');
            //var class_id = 'cls_' + id_value[1];
            //$("option[class='" + class_id + "']").remove();
            var class_id = id_value[1];
            $('.rowselect_' + class_id).remove();

            $(this).closest("tr").remove();
            var totalsum = 0;

            calcTotalHour('');
        }
    }
});

$('#tbltimeday_tutorial tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW' && $('input[type=radio][name=rdo_tutorial_offered]:checked').val() == 'Y') {
        var r = confirm("Are you sure you want to remove this?");

        if (r == true) {
            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");

            $(this).closest("tr").remove();
            var totalsum = 0;

            calcTotalHour('');
        }
    }
});

$('#tblsemester tbody tr td i.icon-trash').live('click', function (e) {
    var r = confirm("Are you sure you want to remove this?");

    if (r == true) {
        var datalist = [];
        var flag = 'Y';
        var ob = {};
        var thisdata = $(this).closest("tr");

        $(this).closest("tr").remove();
        var totalsum = 0;
    }
    else {
        alert("You pressed Cancel!");
    }
});

$('#tbl_course_assessment tbody tr td i.icon-trash').live('click', function (e) {
    var r = confirm("Are you sure you want to remove this?");

    if (r == true) {
        var datalist = [];
        var flag = 'Y';
        var ob = {};
        var thisdata = $(this).closest("tr");

        $(this).closest("tr").remove();
        var totalsum = 0;

        $('#tbl_course_assessment tbody tr').each(function (i) {
            $(this).children().eq(0).html('Assessment ' + (i + 1));
        });
    }
});


// upload PDF File //07102021
function UploadExercisespdf() {//
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
            var fileToUpload = GetFileNameFromPath($('#excercisesUpload').val());

            var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

            if (CheckExtension(fileToUpload)) {

                var flag = true;

                if (filename != "" && filename != null) {
                    if (flag == true) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Exercises_Upload.ashx',
                            secureuri: false,
                            fileElementId: 'excercisesUpload',
                            data: { 'CourseCode': $('#txtcoursecode').val() },
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        $('#excercisesUpload').val("");
                                        $('#lbl_excercises_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload

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
                alert('Invalid File Type. Please upload Pdf file');
            }
            return false;
        }
        catch (e) {
            alert("Exception : " + e.message);
        }
    }
}
//07102021
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
//07102021
function CheckExtension(file) {
    try {
        var flag = true;
        var extension = file.substr((file.lastIndexOf('.') + 1));

        switch (extension) {
            //case 'jpg':
            //case 'jpeg':
            //case 'JPG':
            //case 'JPEG':
            //case 'png':
            //case 'PNG':
            case 'pdf':
            case 'PDF':
                //case 'doc':
                //case 'DOC':
                //case 'docx':
                //case 'DOCX':
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


function typology_wise_get_hrs() {
    var group_id = '';
    var designation = '';
    var course_credits = '';
    var intake_capacity = '';
    //if ($('#drptypology').val() == '24')
    //{
    //    if ($('#rdo_t').prop("checked") == true && $('#rdo_ta').prop("checked") == true) {
    //        group_id = 'WT003';
    //        designation = 'TA' + ',' + 'T';
    //    }
    //    else if ($('#rdo_ta').prop("checked") == true) {
    //        group_id = 'WT002';
    //        designation = 'TA';
    //    }
    //    else {
    //        group_id = 'WT001';
    //        designation = '';
    //    }
    //    course_credits = $('#txtcredits').val();
    //}
    //else if ($('#drptypology').val() == '23')
    //{
    //    if ($('#rdo_s').prop("checked") == true) {
    //        group_id = 'WT004';
    //        designation = '';
    //    }
    //    else if ($('#rdo_d').prop("checked") == true) {
    //        group_id = 'WT005';
    //        designation = '';
    //    }
    //    course_credits = $('#txtcredits').val();
    //    intake_capacity = $('#txtavailable_seats').val();
    //    if (parseInt(intake_capacity) >= parseInt(12) && parseInt(intake_capacity) <= parseInt(13)) {
    //        intake_capacity = '12';
    //    }
    //    else if (parseInt(intake_capacity) >= parseInt(14)) {
    //        intake_capacity = '14';
    //    }
    //}


    if ($('#drptypology').val() == '24') {
        if ($('#rdo_t').prop("checked") == true && $('#rdo_ta_y').prop("checked") == true) {
            group_id = 'WT003';
            designation = 'TA' + ',' + 'T';
        }
        else if ($('#rdo_ta_y').prop("checked") == true) {
            group_id = 'WT002';
            designation = 'TA' + ',' + 'T';
        }
        else if ($('#rdo_t').prop("checked") == true) {
            group_id = 'WT001';
            designation = 'T';
        }
        else {
            group_id = 'WT001';
            designation = '';
        }
        course_credits = $('#txtcredits').val();

        intake_capacity = $('#txtavailable_seats').val();
    }
    else if ($('#drptypology').val() == '23') {
        if ($('#rdo_s').prop("checked") == true) {
            group_id = 'WT004';
            designation = '';
        }
        else if ($('#rdo_d').prop("checked") == true) {
            group_id = 'WT005';
            designation = '';
        }
        course_credits = $('#txtcredits').val();
        intake_capacity = $('#txtavailable_seats').val();
        if (parseInt(intake_capacity) >= parseInt(12) && parseInt(intake_capacity) <= parseInt(13)) {
            intake_capacity = '12';
        }
        else if (parseInt(intake_capacity) >= parseInt(14)) {
            intake_capacity = '14';
        }
    }
    var sem_code = '';
    var year_code = '';
    if ($('#hdn_s').val() == '')
    {
        sem_code = $('#drpsemester').val();
    }
    else
    {
        sem_code = $('#hdn_s').val();
    }
    if ($('#hdn_y').val() == '')
    {
        year_code = $('#drpyear').val();
    }
    else { year_code = $('#hdn_y').val(); }
    //var course_credits = $('#txtcredits').val();

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/typology_wise_get_contact_hrs",
        async: false,
        data: "{ group_id: '" + group_id + "',semester_type: '" + sem_code + "',year_semester: '" + year_code + "',intake_capacity: '" + intake_capacity + "',course_credits: '" + course_credits + "',designation: '" + designation + "',course_typology: '" + $('#drptypology').val() + "' }",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var typ_hrs_dtl = JSON.parse(data.d);
                typology_hrs_dtl = typ_hrs_dtl;
                var text_value = "Note : You can add " + " " + typ_hrs_dtl[0]["no_of_tutor"] + " Tutor and " + " " + typ_hrs_dtl[0]["no_of_ta"] + " TA in this course/studio";
                $('#dynamic_text').text(text_value);
            }
            else if (data.d != "") {
                alert(data.d);
            }
        },
        error: function (result) {
            alert(result);
        }
    });

}

function typology_onchange() {
    $('#drp_typology_group').val('G003');
    $('#drp_typology_group').trigger("liszt:updated");
    //changes 17052022
    typology_detail = obj_typology[$('#drp_typology_group').val()];
    if ($('#drp_typology_group').val() != '') {
        for (var i = 0; i < obj_typology[$('#drp_typology_group').val()].length; i++) {
            $('#drptypology').append('<option value="' + obj_typology[$('#drp_typology_group').val()][i]['type_code'].toString() + '">' + obj_typology[$('#drp_typology_group').val()][i]['type_name'].toString() + '</option>');
        }
    }

}

function appendtimeslotdtl() {
    if (window.calling_funcation == false)
    {
        if ($('#drptypology').val() == '24' || $('#drptypology').val() == '23') {
            typology_wise_get_hrs();
            $("#tblinstructor tbody tr").each(function (j)
            {
                hrs_tutor_dtl = jQuery.grep(typology_hrs_dtl, function (data) { return data.designation == "T" });
                if (hrs_tutor_dtl.length > 0) {
                    $(this).find('.per_load').val(parseFloat(hrs_tutor_dtl[0]['avg_contact_hrs_per_week']).toFixed(0));
                    $(this).find('.week').val(hrs_tutor_dtl[0]['weeks']);
                    $(this).find('.add_hrs').val(hrs_tutor_dtl[0]['additinal_contact_hrs']);
                    $(this).find('.total_hrs').val(hrs_tutor_dtl[0]['contact_hrs']);
                    var total_hours_add = parseInt(parseInt(hrs_tutor_dtl[0]['additinal_contact_hrs']) + parseInt(hrs_tutor_dtl[0]['contact_hrs']));
                    $(this).find('.add_hrs_new').val(total_hours_add);

                }

            });

            $("#tblinstructor_ta tbody tr").each(function (j) {
                hrs_tutor_dtl = jQuery.grep(typology_hrs_dtl, function (data) { return data.designation == "TA" });
                if (hrs_tutor_dtl.length > 0) {
                    $(this).find('.per_load').val(parseFloat(hrs_tutor_dtl[0]['avg_contact_hrs_per_week']).toFixed(0));

                    $(this).find('.week').val(hrs_tutor_dtl[0]['weeks']);
                    $(this).find('.add_hrs').val(hrs_tutor_dtl[0]['additinal_contact_hrs']);
                    $(this).find('.total_hrs').val(hrs_tutor_dtl[0]['contact_hrs']);
                    var total_hours_add = parseInt(parseInt(hrs_tutor_dtl[0]['additinal_contact_hrs']) + parseInt(hrs_tutor_dtl[0]['contact_hrs']));
                    $(this).find('.ta_hrs_new').val(total_hours_add);

                }


                // $("[data-bind_row_no='" + $(this)[0].dataset.row_no + "']").remove();
            });

            $("#tblinstructor tbody tr").each(function (k) {
                var inst_new_ver = $(this).find('.drpinstructor').val();
                $("#tbltimeday tbody tr").each(function (j) {
                    from_time = $(this).find(".from_time").val();
                    to_time = $(this).find(".to_time").val();
                    var inst_code_new = inst_new_ver;
                    inst_code_new = inst_code_new + '_' + j;
                    var inst_code_new_from = 'from' + '_' + inst_code_new;
                    var inst_code_new_to = 'to' + '_' + inst_code_new;
                    $('.' + inst_code_new_from).timepicker({
                        minTime: from_time,
                        maxTime: to_time,
                        dynamic: false
                    });

                    $("." + inst_code_new_to).timepicker({
                        minTime: from_time,
                        maxTime: to_time,
                        dynamic: false
                    });
                });
            });

        }
    }
    
}
function validation_hrs()
{
     appendtimeslotdtl();
}
function append_ta_tutor_hrs(e) {

    var instructor_code = "'" + e.value + "'";
    var inst_new_ver = e.value;
    current_row_id = e.closest('tr').dataset["row_no"];
    var inst_name = '';
    var hrs_tutor_dtl = [];
    if ($('#drptypology').val() == '24') {
        if ($('#rdo_ta_y').prop("checked") == true) {
            hrs_tutor_dtl = jQuery.grep(typology_hrs_dtl, function (data) { return data.designation == "TA" });
            if (hrs_tutor_dtl.length > 0) {
                $('#' + current_row_id + '_ta_per_load').val(parseFloat(hrs_tutor_dtl[0]['avg_contact_hrs_per_week']).toFixed(0));
                $('#' + current_row_id + '_ta_week').val(hrs_tutor_dtl[0]['weeks']);
                $('#' + current_row_id + '_ta_add_hrs').val(hrs_tutor_dtl[0]['additinal_contact_hrs']);
                $('#' + current_row_id + '_ta_total_hrs').val(hrs_tutor_dtl[0]['contact_hrs']);
                var total_hours_add = parseInt(parseInt(hrs_tutor_dtl[0]['additinal_contact_hrs']) + parseInt(hrs_tutor_dtl[0]['contact_hrs']));
                $('#' + current_row_id + '_ta_hrs_new').val(total_hours_add);
            }
        }
    }
    else if ($('#drptypology').val() == '23') {
        hrs_tutor_dtl = jQuery.grep(typology_hrs_dtl, function (data) { return data.designation == "TA" });
        if (hrs_tutor_dtl.length > 0) {
            $('#' + current_row_id + '_ta_per_load').val(parseFloat(hrs_tutor_dtl[0]['avg_contact_hrs_per_week']).toFixed(0));
            $('#' + current_row_id + '_ta_week').val(hrs_tutor_dtl[0]['weeks']);
            $('#' + current_row_id + '_ta_add_hrs').val(hrs_tutor_dtl[0]['additinal_contact_hrs']);
            $('#' + current_row_id + '_ta_total_hrs').val(hrs_tutor_dtl[0]['contact_hrs']);
            var total_hours_add = parseInt(parseInt(hrs_tutor_dtl[0]['additinal_contact_hrs']) + parseInt(hrs_tutor_dtl[0]['contact_hrs']));
            $('#' + current_row_id + '_ta_hrs_new').val(total_hours_add);
        }

    }

    else if ($('#rdo_ta').prop("checked") == false && $('#rdo_ta_n').prop("checked") == false) {
        // hrs_tutor_dtl = jQuery.grep(typology_hrs_dtl, function (data) { return data.designation == "TA" });
        // if (hrs_tutor_dtl.length > 0) {
        //     $('#' + current_row_id + '_ta_per_load').val(parseFloat(hrs_tutor_dtl[0]['avg_contact_hrs_per_week']).toFixed(0));
        //     $('#' + current_row_id + '_ta_week').val(hrs_tutor_dtl[0]['weeks']);
        //     $('#' + current_row_id + '_ta_add_hrs').val(hrs_tutor_dtl[0]['additinal_contact_hrs']);
        //     $('#' + current_row_id + '_ta_total_hrs').val(hrs_tutor_dtl[0]['contact_hrs']);
        // }
    }


}
var count = 1;
function BindCourseTimetable() {

    console.log(count);
    count = count + 1;
    if (count >= 8 &&  count <= 10)
    {
        return false;
    }
    //if (btn_ret_new_flag == true) {
    //    return false;
    //
    //}

    var prog_level_code = "";
    var sub_category_id = "";
    var course_typology = "";
    if ($('#drptypology').val() == '23')
    {
        if ($('#drpdepartment').val() == '') {
            return false;
        }
        if ($('#drpprog').val() == '') {
            return false;

        }
        if ($('#drpprog').val() == '1') {
            if ($('#drpproglevel').val() == '') {
                return false;

            }
            else {
                prog_level_code = $('#drpproglevel').val();
            }
            if ($('#drpsubtypology').val() == '') {
                return false;
            }
            else {
                sub_category_id = $('#drpsubtypology').val();
            }
        }
        else {
            prog_level_code = "";
        }

        course_typology = $('#drptypology').val();
        var sem_code = '';
        var year_code = '';
        if ($('#hdn_s').val() != '') {
            sem_code = $('#hdn_s').val();
        }
        else if ($('#drpsemester').val() != '') {
            sem_code = $('#drpsemester').val();
        }
        if ($('#hdn_y').val() != '') {
            year_code = $('#hdn_y').val();
        }
        else if ($('#drpyear').val() != '') {
            year_code = $('#drpyear').val();
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/dept_wise_get_time_table_dtl",
            async: false,
            data: "{ prog_code: '" + $('#drpprog').val() + "',dept_code: '" + $('#drpdepartment').val() + "',prog_level_code: '" + prog_level_code + "',sub_category_id: '" + sub_category_id + "',course_typology: '" + course_typology + "',semester_type: '" + sem_code + "',year_semester: '" + year_code + "' }",
            dataType: "json",
            success: function (data) {
                console.log(window.calling_funcation);
                if (window.calling_funcation == false) {
                    if (data.d != "") {
                        var typ_hrs_dtl = JSON.parse(data.d);
                        dept_timetable_dtl = typ_hrs_dtl;
                        $('#spn_totalhour').html('');


                        if ($('#tbltimeday tbody tr').length > 0) {
                            $('#tbltimeday tbody').html('');
                        }
                        if ($('#tblinstructor_time_slot tbody tr').length > 0)
                        {
                            $('#tblinstructor_time_slot tbody').html('');
                        }
                        for (var i = 0; i < typ_hrs_dtl.length; i++) {
                            $('#btn_time').click();
                        }

                        $("#tbltimeday tbody tr").each(function (j) {
                            for (var k = 0; k < typ_hrs_dtl.length; k++) {
                                if (j == k) {
                                    $(this).find(".drpday").val(typ_hrs_dtl[k]["day_code"]);
                                    $(this).find(".from_time").val(typ_hrs_dtl[k]["from_time"]);
                                    $(this).find(".to_time").val(typ_hrs_dtl[k]["to_time"]);

                                    $(this).find(".cls_roomid").html('<option value="' + typ_hrs_dtl[k]["room_id"] + '">' + typ_hrs_dtl[k]["room_id"] + '</option>');
                                    $(this).find(".cls_roomid").val(typ_hrs_dtl[k]["room_id"]);
                                }
                            }
                        });
                        append_tutor_image_2();

                        calcTotalHour('');
                        for (var q = 0; q < typ_hrs_dtl.length; q++) {
                            current_row_id_room = 'time_' + q;
                            create_str_room()
                        }

                    }
                    else if (data.d == "")
                    {
                        //changes 27052022
                        $('#spn_totalhour').html('');
                        //$('#tbltimeday tbody').html('');
                        //$('#tblinstructor_time_slot tbody').html('');
                    }
                    else if (data.d != "") {
                        alert(data.d);
                    }
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    }
    else
    {
        $('#spn_totalhour').html('');
       // $('#tblinstructor_time_slot tbody').html('');
    }

}
function append_tutor_image_2() {

    var instructor_code = "";
    
    //07052022
    var inst_new_ver = '';
    var inst_name = '';
   
    var from_time = '';
    var to_time = '';
    var row_count_val = '';
    var new_string = "";

    if (window.calling_funcation == false)
    {
        if ($('#drptypology').val() == '23')
        {
            $("#tblinstructor tbody tr").each(function (p) {
                if (p == 0) {
                    $('#tblinstructor_time_slot tbody').html('');
                }
                current_row_id = parseInt(parseInt(p) + parseInt(1));
                inst_id_with = $(this).find('.drpinstructor').val();
                inst_new_ver = $(this).find('.drpinstructor').val();
                var new_class = current_row_id + " " + inst_new_ver;
                inst_name = $('.drpinstructor option:selected').eq(p).text();

                new_string += '<tr class ="' + new_class + '"  data-row_no =' + current_row_id + '><td colspan = 7  id=' + current_row_id + ' class = inst_name ' + row_count_val + '>' + inst_name + '</td></tr>';
                $("#tbltimeday tbody tr").each(function (j) {
                    row_count_val = 'rowselect_' + j;
                    from_time = convertTime($(this).find(".from_time").val());
                    to_time = convertTime($(this).find(".to_time").val());
                    var class_room = $(this).find(".cls_roomid").val();
                    var drpday1 = $(this).find(".drpday").val();
                    var drpday_code = $(this).find(".drpday").val();
                    drpday1 = Week(drpday1);
                    drpday1 = day_value;
                    var inst_code_new = inst_new_ver;
                    var current_tr_id = 'c_' + inst_code_new;
                    inst_code_new = inst_code_new + '_' + j;
                    var inst_code_new_from = 'from' + '_' + inst_code_new;
                    var inst_code_new_to = 'to' + '_' + inst_code_new
                    //var inst_id = inst_code_ + '_' + j;

                    new_string += "<tr class ='" + current_tr_id + ' ' + row_count_val + "'><td></td><td><input style='width: 56px;' id='" + inst_code_new_from + "' type='text' class='from_time_" + j + ' ' + inst_code_new_from + ' ' + 'from_time' + "' /></td><td><input id='" + inst_code_new_to + "' style='width: 56px;' type='text' class='to_time_" + j + ' ' + inst_code_new_to + ' ' + 'to_time' + "' /></td><td class='day_value_" + j + ' ' + 'day_value' + "'>" + drpday1 + "</td><td class='room_value_" + j + ' ' + 'class_room_id ' + "'>" + class_room + "</td><td></td><td><input type='button' value='Delete' class='deleteRows' /></td></tr>";

                });

            });
            $('#tbody_tblinstructor_time_slot').append(new_string);
            setTimepicker();
            $("#tblinstructor tbody tr").each(function (k) {
                var inst_new_ver = $(this).find('.drpinstructor').val();
                $("#tbltimeday tbody tr").each(function (j) {
                    from_time = $(this).find(".from_time").val();
                    to_time = $(this).find(".to_time").val();
                    var inst_code_new = inst_new_ver;
                    inst_code_new = inst_code_new + '_' + j;
                    var inst_code_new_from = 'from' + '_' + inst_code_new;
                    var inst_code_new_to = 'to' + '_' + inst_code_new;
                    $('.' + inst_code_new_from).timepicker({
                        minTime: from_time,
                        maxTime: to_time,
                        dynamic: false
                    });

                    $("." + inst_code_new_to).timepicker({
                        minTime: from_time,
                        maxTime: to_time,
                        dynamic: false
                    });
                });
            });
        }
    }
    

    

           
       
        

}
function showLoader() {
    Swal.fire({
        title: 'Generating PDF...',
        text: 'Please wait while the PDF is being generated.',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading(); // Show loading spinner
        }
    });
}

// Call this function when the PDF generation is done
function hideLoader() {
    Swal.close(); // Manually close the loader
}
function bind_program_level_code() {
    var dept_code = $('#drpdepartment').val();
    var prog_code = $('#drpprog').val();

    if (dept_code == '' && prog_code == '') {
        //bootbox.alert('Please select From year');
        return false;
    }
    //if (prog_code == '') {
    //   // bootbox.alert('Please select To year');
    //    return false;
    //}

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_programme_level_dept_wise",
        data: "{dept_code : '" + dept_code + "',prog_code:'" + prog_code + "'}",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Program level Code course --"));

                for (var i = 0; i < year_data.length; i++) {
                    $('#drpproglevel').append($("<option></option>").val(year_data[i]["prog_level_code"]).html(year_data[i]["prog_level_desc"]));
                }

                $('#drpproglevel').chosen();
                $('#drpproglevel').trigger("liszt:updated");
            }
            else {
                $('#drpproglevel')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Program level found</option>')
                    .val('');
                $('#drpproglevel').chosen();

                $('#drpproglevel').val('').trigger("liszt:updated");
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}