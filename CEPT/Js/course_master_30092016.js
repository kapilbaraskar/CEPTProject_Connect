
var instructor = '';
var area = '';
var semester = '';
var day = '';
var action = 'S';
var prog_name_flag = false;

function IsNumeric(e) {
    //alert(e.which + " : " + e.keyCode);
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
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

function IsNumeric_istructor(e) {

    debugger;
    //alert(e.which + " : " + e.keyCode);
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
            if (parseInt($(document.activeElement).val()) > 20) {
                return false;
            }
            else if (parseInt($(document.activeElement).val()) == 20) {
                if (keyCode != 48) {
                    return false;
                }
            }
        }

        return true;
    }
    else {
        return false;
    }
}

function keydown_removechar(e) {
    /////Character
    if (e.keyCode == 8) {
        if ($('#txtcourse_description').val() != '') {
            $('#spn_desc').html('' + 'Total Char : ' + ($('#txtcourse_description').val().length - 1));
        }
    }
}

function charcount(e) {
    /////Character
    $('#spn_desc').html('' + 'Total Char : ' + $('#txtcourse_description').val().length);

    if (e.keyCode != 8) {
        if ($('#txtcourse_description').val().length >= 400) {
            bootbox.alert('You Exceeds the Character Limit');
            return false;
        }
    }

    /////Word
    //    var keyCode = e.which ? e.which : e.keyCode;
    //    var desc = $('#txtcourse_description').val();
    //    desc = desc.replace(/\s+/g, ' ');

    //    if (keyCode == 32) {
    //        $('#spn_desc').html('' + 'Total Word : ' + ((desc.match(/ /g) || []).length + 1));
    //    }
    //    else {
    //        $('#spn_desc').html('' + 'Total Word : ' + (desc.match(/ /g) || []).length);
    //    }

    //    if ((desc.match(/ /g) || []).length >= 100) {
    //        bootbox.alert('You Exceeds the Word Limit');
    //        return false;
    //    }
}

function timerIncrement() {

    idleTime = idleTime + 1;
    if (idleTime == 10) { // 10 minutes
        //  window.location.reload();
    }

}

$(document).ready(function () {


    //    var editor = CKEDITOR.replace('txt_reference');
    //    var div = document.getElementById('editor');
    //    editor.resize($(div).width(), '700');

    CKEDITOR.replace('txt_reference', {
        width: '770px'

    });

    //    CKEDITOR.replace('txt_week_reference1', {
    //        width: '40%', height: '52px',float:'right'
    //    });


    //    var idleInterval = setInterval(timerIncrement, 60000); // 1 minute

    //    //Zero the idle timer on mouse movement.
    //    $(this).mousemove(function (e) {
    //        idleTime = 0;
    //    });
    //    $(this).keypress(function (e) {
    //        idleTime = 0;
    //    });


    if ($("#hdn_utype").val() == 'A1') {
        $("#course_select").css('display', 'block');
    }

    bindinstructor();
    bindsemesterdata();
    bindarea();
    binddepartment();
    bindtype();
    bintypology();
    bindprogrammedata();
    bindsemdata();
    bindyeardata_for_cross_reg();
    bindday();
    bindproglevel();
    bindcolor();
    getallcourse();


    var myElement = document.getElementById('txtcourse_description');
    myElement.onpaste = function (e) {
        var pastedText = undefined;
        if (window.clipboardData && window.clipboardData.getData) { // IE
            pastedText = window.clipboardData.getData('Text');
        } else if (e.clipboardData && e.clipboardData.getData) {
            pastedText = e.clipboardData.getData('text/plain');
        }

        var cnt = $('#txtcourse_description').val().length;
        //$('#spn_desc').html('' + 'Total Char : ' + $('#txtcourse_description').val().length);
        if (cnt < 400) {
            if ((cnt + pastedText.length) >= 400) {
                $('#spn_desc').html('' + 'Total Char : ' + 400);
                bootbox.alert('You Exceeds the Character Limit');
            }
            else {
                $('#spn_desc').html('' + 'Total Char : ' + (cnt + pastedText.length));
            }
        }
        else {
            $('#spn_desc').html('' + 'Total Char : ' + cnt);
        }

        //alert(pastedText); // Process and handle text...
        return true; // Prevent the default handler from running.
    };

    //if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'PC') {
    if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
        //$("#div_txtcoursecode").css('display', 'none');
        $("#txtcoursecode").attr('disabled', 'disabled');
        $("#txtcoursename").attr('disabled', 'disabled');
        //$("#txtavailable_seats").attr('disabled', 'disabled');
        $("#txtcredits").attr('disabled', 'disabled');
        $("#drpdepartment").attr('disabled', 'disabled');
        $("#drptype").attr('disabled', 'disabled');
        $("#drpproglevel").attr('disabled', 'disabled');
        $("#drp_semester").attr('disabled', 'disabled');
        $("#drpprog").attr('disabled', 'disabled');
        $("#drptypology").attr('disabled', 'disabled');
        $('#btn_instructor').attr('disabled', 'disabled');
        $('#btn_area').attr('disabled', 'disabled');
        $('#btn_time').attr('disabled', 'disabled');
        $("#drp_color").attr('disabled', 'disabled');
        $("#drpproject").attr('disabled', 'disabled');
        $("#txt_project_name").attr('disabled', 'disabled');

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
        $('.cls_mendatory').css('display', 'inline-block');
    }

    if ($("#hdn_utype").val() == 'CW') {
        $('#div_chk_prerequisite input[type=checkbox]').attr('disabled', 'disabled');
    }

    $('#drpprog').on('change', function () {

        if ($("#drpprog").val() == '2' || $("#drpprog").val() == '3') {
            $("#spn_proglvl").css('display', 'block');
            $("#drpproglevel_chzn").css('display', 'block');
        }
        else {
            $("#spn_proglvl").css('display', 'none');
            $("#drpproglevel_chzn").css('display', 'none');
            $("#drpproglevel").val('');
            $("#drpproglevel").trigger("liszt:updated");
        }
    });

    $('#drpprog,#drpproglevel,#drp_semester,#drptypology').on('change', function () {

        debugger;
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
        }
        prog_name_flag = false;
    });

    $('#drptype').on('change', function () {

        if ($("#drptype").val() == 'M') {
            $("#spn_project,#drpproject").css('display', 'inline-block');
            // $('#drpproject').val('0');
        }
        else {
            $("#spn_project,#drpproject").css('display', 'none');
            $("#spn_project_name,#txt_project_name").css('display', 'none');
            $('#drpproject').val('0');
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
        }
        else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
            $('#div_weekly_plan').css('display', 'none');
            $('#div_course_structure').css('display', 'block');
            $('#spn_chkbox').css('display', 'none');
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

                $('.divweek').removeClass('col-md-6');
                $('.divweek').addClass('col-md-12');
                $('#div_weekly_plan .txtwidth').css('width', '40%');
            }
        }
        else if (!$('#chk_week_ref')[0].checked) {
            $('.cls_week_ref').css('display', 'none');
            $('#div_ref_title').css('display', 'none');

            if (!$('#chk_week_ref')[0].checked && !$('#chk_week_assign')[0].checked) {
                $('#div_week_title').css('display', 'none');

                $('.divweek').removeClass('col-md-12');
                $('.divweek').addClass('col-md-6');
                $('#div_weekly_plan .txtwidth').css('width', '80%');
            }
            else if ($('#chk_week_assign')[0].checked) {
                $('#div_weekly_plan .txtwidth').css('width', '40%');
            }
        }
    });
    //    $('#chk_week_assign').on('change', function () {
    //        $('#div_week_title').css('display', 'block');
    //        $('#div_ref_title').css('display', 'block');
    //        $('#div_assign_title').css('display', 'block');

    //        if ($('#chk_week_assign')[0].checked) {
    //            $('.cls_week_assign').css('display', 'inline-block');

    //            if ($('#chk_week_ref')[0].checked && $('#chk_week_assign')[0].checked) {
    //                $('#div_weekly_plan .txtwidth').css('width', '27%');
    //            }
    //            else if (!$('#chk_week_ref')[0].checked) {
    //                $('#div_ref_title').css('display', 'none');

    //                $('.divweek').removeClass('col-md-6');
    //                $('.divweek').addClass('col-md-12');
    //                $('#div_weekly_plan .txtwidth').css('width', '40%');
    //            }
    //        }
    //        else if (!$('#chk_week_assign')[0].checked) {
    //            $('.cls_week_assign').css('display', 'none');
    //            $('#div_assign_title').css('display', 'none');

    //            if (!$('#chk_week_ref')[0].checked && !$('#chk_week_assign')[0].checked) {
    //                $('#div_week_title').css('display', 'none');

    //                $('.divweek').removeClass('col-md-12');
    //                $('.divweek').addClass('col-md-6');
    //                $('#div_weekly_plan .txtwidth').css('width', '80%');
    //            }
    //            else if ($('#chk_week_ref')[0].checked) {
    //                $('#div_weekly_plan .txtwidth').css('width', '40%');
    //            }
    //        }
    //    });


    $('#drptypology').on('change', function () {
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
    });


    //    $('#drptypology').on('change', function () {

    //        $('#txt_week1').val('');
    //        $('#txt_week2').val('');
    //        $('#txt_week3').val('');
    //        $('#txt_week4').val('');
    //        $('#txt_week5').val('');
    //        $('#txt_week6').val('');
    //        $('#txt_week7').val('');
    //        $('#txt_week8').val('');
    //        $('#txt_week9').val('');
    //        $('#txt_week10').val('');
    //        $('#txt_week11').val('');
    //        $('#txt_week12').val('');
    //        $('#txt_week13').val('');
    //        $('#txt_week14').val('');
    //        $('#txt_week15').val('');
    //        $('#txt_week16').val('');

    //        $('#txtcourse_structure').val('');

    //        if ($('#drptypology').val() == '') {
    //            $('#div_weekly_plan').css('display', 'none');
    //            $('#div_course_structure').css('display', 'none');
    //        }
    //        else if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
    //            $('#div_weekly_plan').css('display', 'block');
    //            $('#div_course_structure').css('display', 'none');
    //        }
    //        else {
    //            $('#div_weekly_plan').css('display', 'none');
    //            $('#div_course_structure').css('display', 'block');
    //        }

    //    });


    $('#drpyear').on('change', function () {
        if ($('#drpyear').val() != '') {

            if ($('#drpsemester').val() != '') {
                bind_sem_course();
            }

        }
    });

    $('#btn_instructor').on('click', function () {
        debugger;
        var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric_istructor(event);' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tblinstructor tbody').append(str);

        // $('.drpinstructor').chosen();
        // $('.chzn-drop').css({ "width": "140px" });
        return false;
    });

    $('#btn_area').on('click', function () {
        debugger;
        var str = "<tr><td>" + area + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tblarea tbody').append(str);

        //   $('.drparea').chosen();
        return false;
    });

    $('#btn_semester').on('click', function () {
        debugger;
        var str = "<tr><td>" + semester + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tblsemester tbody').append(str);

        $('.drpsemester').chosen();
        return false;
    });

    $('#btn_time').on('click', function () {

        // alert('hi');
        debugger;
        var str = "<tr><td><input style='width: 60px;' type='text' class='from_time' onchange='calcTotalHour()'/></td><td><input style='width: 60px;' type='text' class='to_time' onchange='calcTotalHour()'/></td><td>" + day + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
        $('#tbltimeday tbody').append(str);

        setTimepicker();

        //$('.drpsemester').chosen();
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

    $('#btnapprove').on('click', function () {

        if ($('#hdn_ccode').val() == '') {
            bootbox.alert('No Course to update');
            return false;
        }

        if ($('#txtcoursecode').val() == '') {
            action = 'S';
            bootbox.alert('Please Enter Course Code');
            return false;
        }

        if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC') {
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
                action = 'S';
                bootbox.alert('Please Select Course Type');
                return false;
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



            if ($('#drptypology').val() == '') {
                action = 'S';
                bootbox.alert('Please Select Course Typology');
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
                //                if ($('#drp_color').val() == '') {
                //                    action = 'S';
                //                    bootbox.alert('Please Select Specialization');
                //                    return false;
                //                }
            }
            if ($('#txtcourse_description').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Description');
                return false;
            }
            if ($('#txtcourse_description').val().length > 400) {
                action = 'S';
                bootbox.alert('Course Description Exceeds the Character Limit');
                return false;
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

            if ($('#txt_evalmethod').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Assessment in Evaluation Method');
                return false;
            }
            if ($('#txt_evalmethod').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Assessment in Evaluation Method');
                return false;
            }
            //            if ($('#txt_evalmethod_weightage1').val() == '') {
            //                action = 'S';
            //                bootbox.alert('Please Enter Assessment 1 Weightage');
            //                return false;
            //            } 

            //            var total_eval_weightage = 0;
            //            for (var i = 1; i <= 5; i++) {
            //                if ($('#txt_evalmethod_weightage' + i).val() != '') {
            //                    total_eval_weightage = total_eval_weightage + parseInt($('#txt_evalmethod_weightage' + i).val());
            //                }
            //            }
            //            if (total_eval_weightage != 100) {
            //                action = 'S';
            //                total_eval_weightage = 0;
            //                bootbox.alert('Total Evaluation Method Weightage must be 100');
            //                return false;
            //            }

            if ($('#txt_prep_self_hrs').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Student Prep/Self Study Hours');
                return false;
            }



            if ($('#txtcourse_outline').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Introduction');
                return false;
            }

            //if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
            if ($('input[name=rdo_outline]:checked').val() == 'weekly') {
                if ($('#txt_week1').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 1');
                    return false;
                }
                if ($('#txt_week2').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 2');
                    return false;
                }
                if ($('#txt_week3').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 3');
                    return false;
                }
                if ($('#txt_week4').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 4');
                    return false;
                }
                if ($('#txt_week5').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 5');
                    return false;
                }
                if ($('#txt_week6').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 6');
                    return false;
                }
                if ($('#txt_week7').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 7');
                    return false;
                }
                if ($('#txt_week8').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 8');
                    return false;
                }
                if ($('#txt_week9').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 9');
                    return false;
                }
                if ($('#txt_week10').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 10');
                    return false;
                }
                if ($('#txt_week11').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 11');
                    return false;
                }
                if ($('#txt_week12').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 12');
                    return false;
                }
                if ($('#txt_week13').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 13');
                    return false;
                }
                if ($('#txt_week14').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 14');
                    return false;
                }
                if ($('#txt_week15').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 15');
                    return false;
                }
                if ($('#txt_week16').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 16');
                    return false;
                }
            }
            else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
                if ($('#txtcourse_structure').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Course Structure');
                    return false;
                }
            }
        }
        else if ($('#hdn_utype').val() == 'I2' || $("#hdn_utype").val() == 'D') {
            if ($('#txtavailable_seats').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Intake Capacity');
                return false;
            }
            if ($('#txtcourse_description').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Description');
                return false;
            }
            if ($('#txtcourse_description').val().length > 400) {
                action = 'S';
                bootbox.alert('Course Description Exceeds the Character Limit');
                return false;
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

            if ($('#txt_evalmethod').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Assessment in Evaluation Method');
                return false;
            }
            if ($('#txt_evalmethod').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Assessment in Evaluation Method');
                return false;
            }

            //            if ($('#txt_evalmethod_weightage1').val() == '') {
            //                action = 'S';
            //                bootbox.alert('Please Enter Assessment 1 Weightage');
            //                return false;
            //            } 

            //            var total_eval_weightage = 0;
            //            for (var i = 1; i <= 5; i++) {
            //                if ($('#txt_evalmethod_weightage' + i).val() != '') {
            //                    total_eval_weightage = total_eval_weightage + parseInt($('#txt_evalmethod_weightage' + i).val());
            //                }
            //            }
            //            if (total_eval_weightage != 100) {
            //                action = 'S';
            //                total_eval_weightage = 0;
            //                bootbox.alert('Total Evaluation Method Weightage must be 100');
            //                return false;
            //            }

            if ($('#txtcourse_outline').val() == '') {
                action = 'S';
                bootbox.alert('Please Enter Course Introduction');
                return false;
            }

            //if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
            if ($('input[name=rdo_outline]:checked').val() == 'weekly') {
                if ($('#txt_week1').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 1');
                    return false;
                }
                if ($('#txt_week2').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 2');
                    return false;
                }
                if ($('#txt_week3').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 3');
                    return false;
                }
                if ($('#txt_week4').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 4');
                    return false;
                }
                if ($('#txt_week5').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 5');
                    return false;
                }

                if ($('#txt_week6').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 6');
                    return false;
                }
                if ($('#txt_week7').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 7');
                    return false;
                }
                if ($('#txt_week8').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 8');
                    return false;
                }
                if ($('#txt_week9').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 9');
                    return false;
                }
                if ($('#txt_week10').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 10');
                    return false;
                }
                if ($('#txt_week11').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 11');
                    return false;
                }
                if ($('#txt_week12').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 12');
                    return false;
                }
                if ($('#txt_week13').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 13');
                    return false;
                }
                if ($('#txt_week14').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 14');
                    return false;
                }
                if ($('#txt_week15').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 15');
                    return false;
                }
                if ($('#txt_week16').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Weekly Plan for Week 16');
                    return false;
                }
            }
            else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
                if ($('#txtcourse_structure').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Enter Course Structure');
                    return false;
                }
            }
        }

        action = 'A';
        $('#btnsave').click();
    });
    $('#btnsave').on('click', function () {

        //alert("Save Click");
        if ($('#hdn_ccode').val() == '') {
            bootbox.alert('No Course to update');
            return false;
        }
        if ($('#txtcoursecode').val() == '') {
            action = 'S';
            bootbox.alert('Please Enter Course Code');
            return false;
        }

        var course_data = { 'doc_no': '', 'course_code': '', 'course_name': '', 'credits': '', 'course_description': '', 'course_prerequisite': '', 'course_outline': '', 'remark': '', 'type': '', 'semester_type': '', 'year_semester': '', 'week1': '', 'week2': '', 'week3': '', 'week4': '', 'week5': '', 'week6': '', 'week7': '', 'week8': '', 'week9': '', 'week10': '', 'week11': '', 'week12': '', 'week13': '', 'week14': '', 'week15': '', 'week16': '', 'week_reference1': '', 'week_reference2': '', 'week_reference3': '', 'week_reference4': '', 'week_reference5': '', 'week_reference6': '', 'week_reference7': '', 'week_reference8': '', 'week_reference9': '', 'week_reference10': '', 'week_reference11': '', 'week_reference12': '', 'week_reference13': '', 'week_reference14': '', 'week_reference15': '', 'week_reference16': '', 'week_assignment1': '', 'week_assignment2': '', 'week_assignment3': '', 'week_assignment4': '', 'week_assignment5': '', 'week_assignment6': '', 'week_assignment7': '', 'week_assignment8': '', 'week_assignment9': '', 'week_assignment10': '', 'week_assignment11': '', 'week_assignment12': '', 'week_assignment13': '', 'week_assignment14': '', 'week_assignment15': '', 'week_assignment16': '', 'course_structure': '', 'eval_method': '', 'eval_method2': '', 'eval_method3': '', 'eval_method4': '', 'eval_method5': '', 'eval_method_weightage1': '', 'eval_method_weightage2': '', 'eval_method_weightage3': '', 'eval_method_weightage4': '', 'eval_method_weightage5': '', 'prep_self_study_hrs': '', 'instructor_contact_hrs': '', 'project': '', 'project_name': '' };
        debugger;
        course_data.doc_no = $('#hdn_dno').val();
        course_data.course_code = $('#hdn_ccode').val();
        course_data.course_name = $('#txtcoursename').val();
        course_data.credits = $('#txtcredits').val();
        course_data.course_description = $('#txtcourse_description').val();
        //course_data.course_prerequisite = $('#txtcourse_prerequisite').val();

        var chk_prerequisite = "";

        //        for (var i = 0; i < $('#div_chk_prerequisite').find('input[type=checkbox]').length; i++) {

        //            if (document.getElementById($('#div_chk_prerequisite').find('input[type=checkbox]')[i].id).checked) {
        //                chk_prerequisite = chk_prerequisite + $('#div_chk_prerequisite').find('input[type=checkbox]')[i].id + '~';
        //            }

        //        }

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
        debugger;
        course_data.course_prerequisite = JSON.stringify({ "chkbox": chk_prerequisite, "other": $('#txtcourse_prerequisite').val(), "pre_course_code": pre_course_code });
        course_data.course_outline = $('#txtcourse_outline').val();
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

        }
        else {
            course_data.project = '';
            course_data.project_name = '';
        }

        course_data.semester_type = $('#hdn_sem').val();
        course_data.year_semester = $('#hdn_year').val();
        course_data.instructor_contact_hrs = $('#drp_contact_hrs').val();

        //if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
        if ($('input[name=rdo_outline]:checked').val() == 'weekly') {
            course_data.week1 = $('#txt_week1').val();
            course_data.week2 = $('#txt_week2').val();
            course_data.week3 = $('#txt_week3').val();
            course_data.week4 = $('#txt_week4').val();
            course_data.week5 = $('#txt_week5').val();
            course_data.week6 = $('#txt_week6').val();
            course_data.week7 = $('#txt_week7').val();
            course_data.week8 = $('#txt_week8').val();
            course_data.week9 = $('#txt_week9').val();
            course_data.week10 = $('#txt_week10').val();
            course_data.week11 = $('#txt_week11').val();
            course_data.week12 = $('#txt_week12').val();
            course_data.week13 = $('#txt_week13').val();
            course_data.week14 = $('#txt_week14').val();
            course_data.week15 = $('#txt_week15').val();
            course_data.week16 = $('#txt_week16').val();

            course_data.week_reference1 = $('#txt_week_reference1').val();
            course_data.week_reference2 = $('#txt_week_reference2').val();
            course_data.week_reference3 = $('#txt_week_reference3').val();
            course_data.week_reference4 = $('#txt_week_reference4').val();
            course_data.week_reference5 = $('#txt_week_reference5').val();
            course_data.week_reference6 = $('#txt_week_reference6').val();
            course_data.week_reference7 = $('#txt_week_reference7').val();
            course_data.week_reference8 = $('#txt_week_reference8').val();
            course_data.week_reference9 = $('#txt_week_reference9').val();
            course_data.week_reference10 = $('#txt_week_reference10').val();
            course_data.week_reference11 = $('#txt_week_reference11').val();
            course_data.week_reference12 = $('#txt_week_reference12').val();
            course_data.week_reference13 = $('#txt_week_reference13').val();
            course_data.week_reference14 = $('#txt_week_reference14').val();
            course_data.week_reference15 = $('#txt_week_reference15').val();
            course_data.week_reference16 = $('#txt_week_reference16').val();

            course_data.week_assignment1 = $('#txt_week_assignment1').val();
            course_data.week_assignment2 = $('#txt_week_assignment2').val();
            course_data.week_assignment3 = $('#txt_week_assignment3').val();
            course_data.week_assignment4 = $('#txt_week_assignment4').val();
            course_data.week_assignment5 = $('#txt_week_assignment5').val();
            course_data.week_assignment6 = $('#txt_week_assignment6').val();
            course_data.week_assignment7 = $('#txt_week_assignment7').val();
            course_data.week_assignment8 = $('#txt_week_assignment8').val();
            course_data.week_assignment9 = $('#txt_week_assignment9').val();
            course_data.week_assignment10 = $('#txt_week_assignment10').val();
            course_data.week_assignment11 = $('#txt_week_assignment11').val();
            course_data.week_assignment12 = $('#txt_week_assignment12').val();
            course_data.week_assignment13 = $('#txt_week_assignment13').val();
            course_data.week_assignment14 = $('#txt_week_assignment14').val();
            course_data.week_assignment15 = $('#txt_week_assignment15').val();
            course_data.week_assignment16 = $('#txt_week_assignment16').val();
        }
        else if ($('input[name=rdo_outline]:checked').val() == 'consolidated') {
            course_data.course_structure = $('#txtcourse_structure').val();
        }

        //old add by ajay
        //course_data.remark = $('#txt_reference').val();
        //change by kamlesh for ck editor mail by tushar bose

        if (CKEDITOR.instances.txt_reference.getData() == "") {
            course_data.remark = "";
        }
        else {
            course_data.remark = CKEDITOR.instances.txt_reference.getData();
        }

        course_data.eval_method = $('#txt_evalmethod').val();
        //        course_data.eval_method2 = $('#txt_evalmethod2').val();
        //        course_data.eval_method3 = $('#txt_evalmethod3').val();
        //        course_data.eval_method4 = $('#txt_evalmethod4').val();
        //        course_data.eval_method5 = $('#txt_evalmethod5').val();

        //        course_data.eval_method_weightage1 = $('#txt_evalmethod_weightage1').val();
        //        course_data.eval_method_weightage2 = $('#txt_evalmethod_weightage2').val();
        //        course_data.eval_method_weightage3 = $('#txt_evalmethod_weightage3').val();
        //        course_data.eval_method_weightage4 = $('#txt_evalmethod_weightage4').val();
        //        course_data.eval_method_weightage5 = $('#txt_evalmethod_weightage5').val();

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

        //        for (var i = 2; i <= 5; i++) {
        //            if (course_data["eval_method" + i].search(/\\/) != -1) { course_data["eval_method" + i] = course_data["eval_method" + i].replace(/\\/g, '\\\\'); }
        //            if (course_data["eval_method" + i].search("\"") != -1) { course_data["eval_method" + i] = course_data["eval_method" + i].replace(/"/g, '\\\"'); }
        //        }

        for (var i = 1; i <= 16; i++) {
            if (course_data["week" + i].search(/\\/) != -1) { course_data["week" + i] = course_data["week" + i].replace(/\\/g, '\\\\'); }
            if (course_data["week" + i].search("\"") != -1) { course_data["week" + i] = course_data["week" + i].replace(/"/g, '\\\"'); }
        }

        for (var i = 1; i <= 16; i++) {
            if (course_data["week_reference" + i].search(/\\/) != -1) { course_data["week_reference" + i] = course_data["week_reference" + i].replace(/\\/g, '\\\\'); }
            if (course_data["week_reference" + i].search("\"") != -1) { course_data["week_reference" + i] = course_data["week_reference" + i].replace(/"/g, '\\\"'); }
        }

        for (var i = 1; i <= 16; i++) {
            if (course_data["week_assignment" + i].search(/\\/) != -1) { course_data["week_assignment" + i] = course_data["week_assignment" + i].replace(/\\/g, '\\\\'); }
            if (course_data["week_assignment" + i].search("\"") != -1) { course_data["week_assignment" + i] = course_data["week_assignment" + i].replace(/"/g, '\\\"'); }
        }




        var course_dept_data = { 'semester': '', 'department': '', 'programme': '', 'typology': '', 'available_seats': '', 'program_level_code': '', 'color': '' };

        course_dept_data.semester = $('#drp_semester').val();
        course_dept_data.department = $('#drpdepartment').val();
        course_dept_data.programme = $('#drpprog').val();
        course_dept_data.typology = $('#drptypology').val();
        course_dept_data.available_seats = $('#txtavailable_seats').val();
        course_dept_data.program_level_code = $('#drpproglevel').val();
        course_dept_data.color = $('#drp_color').val();

        var instructor_data_list = [];
        var total_per_load = 0;
        $("#tblinstructor tbody tr").each(function (j) {
            var instructor_data = { 'instructor_code': '', 'instructor_name': '', 'percent_load': '' };

            instructor_data.instructor_code = $(this).find(".drpinstructor").val();
            instructor_data.percent_load = $(this).find(".per_load").val();

            total_per_load = total_per_load + parseInt($(this).find(".per_load").val());

            instructor_data_list.push(instructor_data);
        });

        if (instructor_data_list.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC')) {
            if (action == 'A') {
                action = 'S';
                bootbox.alert('Please Add atleast one Instructor');
                return false;
            }
        }
        else if (instructor_data_list.length > 0) {
            for (var i = 0; i < instructor_data_list.length; i++) {
                if (instructor_data_list[i]['percent_load'] == '') {
                    if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC') {
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
        //        if (total_per_load > 100) {
        //            if (action == 'A') {
        //                action = 'S';
        //                bootbox.alert('Total Percent Load should not be greater than 100');
        //                return false;
        //            }
        //        }

        var area_data_list = [];

        $("#tblarea tbody tr").each(function (j) {
            var area_data = { 'area_code': '', 'area_name': '' };

            area_data.area_code = $(this).find(".drparea").val();
            area_data_list.push(area_data);
        });
        if (area_data_list.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC')) {
            if (action == 'A') {
                action = 'S';
                bootbox.alert('Please Add atleast one Area');
                return false;
            }
        }

        var day_time_data_list = [];
        var tempthis;
        $("#tbltimeday tbody tr").each(function (j) {
            var day_time_data = { 'from_time': '', 'to_time': '', 'day': '' };

            //day_time_data.from_time = $(this).find(".from_time").val();
            //day_time_data.to_time = $(this).find(".to_time").val();

            day_time_data.from_time = convertTime($(this).find(".from_time").val());
            day_time_data.to_time = convertTime($(this).find(".to_time").val());

            day_time_data.day = $(this).find(".drpday").val();

            day_time_data_list.push(day_time_data);
        });
        if (day_time_data_list.length == 0 && ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC')) {
            if (action == 'A') {
                action = 'S';
                bootbox.alert('Please Add atleast one Time and Day');
                return false;
            }
        }
        else if (day_time_data_list.length > 0) {
            for (var i = 0; i < day_time_data_list.length; i++) {
                if (day_time_data_list[i]['from_time'] == '' || day_time_data_list[i]['to_time'] == '' || day_time_data_list[i]['from_time'] == '0.' || day_time_data_list[i]['to_time'] == '0.') {
                    if ($('#hdn_utype').val() == 'A1' || $('#hdn_utype').val() == 'PC') {
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

        var new_code = $('#txtcoursecode').val();

        //var All_table_course_data = { 'course_data': course_data, 'course_dept_data': course_dept_data, 'instructor_data_list': instructor_data_list, 'area_data_list': area_data_list, 'day_time_data_list': day_time_data_list };
        //var All_table_course_data = { 'course_data': JSON.stringify(course_data), 'course_dept_data': JSON.stringify(course_dept_data), 'instructor_data_list': JSON.stringify(instructor_data_list), 'area_data_list': JSON.stringify(area_data_list), 'day_time_data_list': JSON.stringify(day_time_data_list) };
        //alert(JSON.stringify(All_table_course_data));

        var All_table_course_data = [course_data, course_dept_data, instructor_data_list, area_data_list, day_time_data_list, action, new_code];
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

    $('#btnRetrieve').click(function () {

        var sem_code = $('#drpsemester').val();

        if (sem_code == '') {
            bootbox.alert('Please select semester');
        }

        var year_code = $('#drpyear').val();

        if (year_code == '') {
            bootbox.alert('Please select year');
        }

        var course_code = $('#drcourses').val();

        if (course_code == '') {
            bootbox.alert('Please select course');
        }

        for (var i = 1; i <= $('#div_chk_prerequisite').find('input[type=checkbox]').length; i++) {

            $('#chk_pre' + i).prop('checked', false);
        }


        $('#txtcourse_prerequisite').css('display', 'none');
        $('#divPreCourseCode').css('display', 'none');

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_all_tables_course_data",
            async: false,
            data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code:'" + course_code + "'}",
            dataType: "json",
            success: function (data) {


                debugger;

                if (data.d[0] != null) {




                    var course_data = JSON.parse(data.d[0]);

                    $('#hdn_dno').val(course_data[0]["doc_no"]);
                    $('#hdn_ccode').val(course_data[0]["course_code"]);
                    $('#hdn_sem').val(course_data[0]["semester_type"]);
                    $('#hdn_year').val(course_data[0]["year_semester"]);

                    $('#txtcoursecode').val(course_data[0]["course_code"]);
                    $('#txtcoursename').val(course_data[0]["course_name"]);
                    $('#txtcredits').val(course_data[0]["course_credits"]);
                    $('#txtcourse_description').val(course_data[0]["course_desc"]);

                    if (course_data[0]["prerequisite"] != "") {
                        debugger;
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
                    $('#txtremarks').val(course_data[0]["remark"]);

                    if (course_data[0]["instructor_contact_hrs"] != "") {
                        $('#drp_contact_hrs').val(course_data[0]["instructor_contact_hrs"]);
                    }
                    else {
                        $('#drp_contact_hrs').val('PR');
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
                            $("#spn_project_name,#txt_project_name").css('display', 'none');
                        }
                    }
                    else {
                        $("#spn_project,#drpproject").css('display', 'none');
                        $("#spn_project_name,#txt_project_name").css('display', 'none');
                        $('#drpproject').val('0');
                    }


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

                    $('#txtcourse_structure').val(course_data[0]["course_structure"]);
                    //   $('#txt_reference').val(course_data[0]["remark"]);

                    CKEDITOR.instances.txt_reference.setData(course_data[0]["remark"])

                    $('#txt_evalmethod').val(course_data[0]["eval_method1"]);
                    //                    $('#txt_evalmethod2').val(course_data[0]["eval_method2"]);
                    //                    $('#txt_evalmethod3').val(course_data[0]["eval_method3"]);
                    //                    $('#txt_evalmethod4').val(course_data[0]["eval_method4"]);
                    //                    $('#txt_evalmethod5').val(course_data[0]["eval_method5"]);

                    //                    $('#txt_evalmethod_weightage1').val(course_data[0]["eval_method_weightage1"]);
                    //                    $('#txt_evalmethod_weightage2').val(course_data[0]["eval_method_weightage2"]);
                    //                    $('#txt_evalmethod_weightage3').val(course_data[0]["eval_method_weightage3"]);
                    //                    $('#txt_evalmethod_weightage4').val(course_data[0]["eval_method_weightage4"]);
                    //                    $('#txt_evalmethod_weightage5').val(course_data[0]["eval_method_weightage5"]);

                    $('#txt_prep_self_hrs').val(course_data[0]["prep_self_study_hrs"]);

                    $('#spn_desc').html('' + 'Total Char : ' + $('#txtcourse_description').val().length);
                    $('#drptype').trigger("liszt:updated");
                }

                if (data.d[1] != null) {


                    var course_dept_data = JSON.parse(data.d[1])

                    $('#drp_semester').val(course_dept_data[0]["semester_code"]);
                    $('#drpdepartment').val(course_dept_data[0]["dept_code"]);
                    $('#drpprog').val(course_dept_data[0]["prog_code"]);
                    $('#drpproglevel').val(course_dept_data[0]["prog_level_code"]);
                    $('#drptypology').val(course_dept_data[0]["course_typology"]);
                    $('#drp_color').val(course_dept_data[0]["prog_course_id"]);

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

                    $('#drp_semester,#drpdepartment,#drpprog,#drptypology,#drpproglevel,#drp_color').trigger("liszt:updated");
                    $('#drpprog').trigger('change');


                }

                $("#tblinstructor tbody").html('');
                if (data.d[2] != null) {

                    $("#tblinstructor tbody").html('');
                    var course_instructor_data = JSON.parse(data.d[2])

                    for (var i = 0; i < course_instructor_data.length; i++) {

                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            $('#drp_contact_hrs').prop('disabled', 'disabled');
                            var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric_istructor(event);' disabled/></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }
                        else {
                            var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric_istructor(event);' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }

                        $('#tblinstructor tbody').append(str);

                    }


                    $("#tblinstructor tbody tr").each(function (j) {

                        debugger;
                        for (var i = 0; i < course_instructor_data.length; i++) {

                            if (j == i) {
                                $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);
                                $(this).find(".per_load").val(course_instructor_data[i]["percent_load"]);
                                //    $(this).find(".drpinstructor").chosen();
                                // $(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }



                    });



                }

                $("#tblarea tbody").html('');
                if (data.d[3] != null) {

                    $("#tblarea tbody").html('');
                    var course_area_data = JSON.parse(data.d[3])

                    for (var i = 0; i < course_area_data.length; i++) {

                        var str = "<tr><td>" + area + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        $('#tblarea tbody').append(str);

                    }

                    $("#tblarea tbody tr").each(function (j) {

                        debugger;
                        for (var i = 0; i < course_area_data.length; i++) {

                            if (j == i) {
                                $(this).find(".drparea").val(course_area_data[i]["area_code"]);
                                //    $(this).find(".drpinstructor").chosen();
                                // $(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }



                    });
                }

                $("#tbltimeday tbody").html('');
                if (data.d[4] != null) {

                    $("#tbltimeday tbody").html('');
                    var course_time_data = JSON.parse(data.d[4])

                    for (var i = 0; i < course_time_data.length; i++) {

                        if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            var str = "<tr><td><input style='width: 60px;' type='text' class='from_time' onchange='calcTotalHour()' disabled/></td><td><input style='width: 60px;' type='text' class='to_time' onchange='calcTotalHour()' disabled/></td><td>" + day + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }
                        else {
                            var str = "<tr><td><input style='width: 60px;' type='text' class='from_time' onchange='calcTotalHour()'/></td><td><input style='width: 60px;' type='text' class='to_time' onchange='calcTotalHour()'/></td><td>" + day + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                        }

                        $('#tbltimeday tbody').append(str);

                    }

                    $("#tbltimeday tbody tr").each(function (j) {

                        debugger;
                        for (var i = 0; i < course_time_data.length; i++) {

                            if (j == i) {
                                $(this).find(".drpday").val(course_time_data[i]["day_code"]);
                                $(this).find(".from_time").val(course_time_data[i]["from_time"]);
                                $(this).find(".to_time").val(course_time_data[i]["To_time"]);
                                //    $(this).find(".drpinstructor").chosen();
                                // $(this).find(".drpinstructor").trigger("liszt:updated");
                            }
                        }



                    });

                    setTimepicker();
                    calcTotalHour();

                    //                    if ($('#drptypology').val() == '') {
                    //                        $('#div_weekly_plan').css('display', 'none');
                    //                        $('#div_course_structure').css('display', 'none');
                    //                    }
                    //                    else if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
                    //                        $('#div_weekly_plan').css('display', 'block');
                    //                        $('#div_course_structure').css('display', 'none');
                    //                    }
                    //                    else {
                    //                        $('#div_weekly_plan').css('display', 'none');
                    //                        $('#div_course_structure').css('display', 'block');
                    //                    }
                }
                else { $('#spn_totalhour').html("Total Hours : 0 hr/week"); }


                //                if ($('#drptypology').val() == '') {
                //                    $('#div_weekly_plan').css('display', 'none');
                //                    $('#div_course_structure').css('display', 'none');
                //                }
                //                else if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4' || $('#drptypology').val() == '6' || $('#drptypology').val() == '8') {
                //                    $('#div_weekly_plan').css('display', 'block');
                //                    $('#div_course_structure').css('display', 'none');
                //                }
                //                else {
                //                    $('#div_weekly_plan').css('display', 'none');
                //                    $('#div_course_structure').css('display', 'block');
                //                }

                if ($('#drptypology').val() == '3' || $('#drptypology').val() == '4') {
                    $('#div_weekly_plan').css('display', 'block');
                    $('#div_course_structure').css('display', 'none');

                    $('input[name=rdo_outline]')[1].checked = true;
                    $('input[name=rdo_outline]')[0].disabled = true;
                    $('#spn_chkbox').css('display', 'inline-block');
                }
                else if ($('#txtcourse_structure').val() != '') {
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

            },
            error: function (result) {
                alert(result);
            }
        });

        return false;
    });

    //   $('#cke_txt_week_reference1 .cke_reset_all').css('display', 'none');

    getparamrequest();
});

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
    }
}

function setTimepicker() {
    $(".from_time").timepicker({ 'minTime': '8:00am' });
    $(".to_time").timepicker({ 'minTime': '8:00am' });
}

function calcTotalHour() {
    debugger;
    var total_hour = 0;
    var total_min = 0;
    for (var i = 0; i < $('.ui-timepicker-input').length; i = i + 2) {

        var temp_from = convertTime($('.ui-timepicker-input')[i].value);
        var temp_to = convertTime($('.ui-timepicker-input')[i + 1].value);


        //        var temp_from = $('.ui-timepicker-input')[i].value;
        //        var temp_to = $('.ui-timepicker-input')[i + 1].value;

        //        if (temp_from.length < 7) {
        //            temp_from = '0' + temp_from;
        //        }
        //        if (temp_to.length < 7) {
        //            temp_to = '0' + temp_to;
        //        }

        //        if (temp_from.search('pm') != -1) {
        //            if (temp_from.substring(0, 2) != '12') {
        //                temp_from = (parseInt(temp_from.substring(0, 2)) + 12) + '.' + temp_from.substring(3, 5);
        //            }
        //            else {
        //                temp_from = temp_from.substring(0, 2) + '.' + temp_from.substring(3, 5);
        //            } 
        //        }
        //        else {
        //            if (temp_from.substring(0, 2) != '12') {
        //                temp_from = temp_from.substring(0, 2) + '.' + temp_from.substring(3, 5);
        //            }
        //            else {
        //                temp_from = '00.' + temp_from.substring(3, 5);
        //            }
        //        }

        //        if (temp_to.search('pm') != -1) {
        //            if (temp_to.substring(0, 2) != '12') {
        //                temp_to = (parseInt(temp_to.substring(0, 2)) + 12) + '.' + temp_to.substring(3, 5);
        //            }
        //            else {
        //                temp_to = temp_to.substring(0, 2) + '.' + temp_to.substring(3, 5);
        //            }
        //        }
        //        else {
        //            if (temp_to.substring(0, 2) != '12') {
        //                temp_to = temp_to.substring(0, 2) + '.' + temp_to.substring(3, 5);
        //            }
        //            else {
        //                temp_to = '00.' + temp_to.substring(3, 5);
        //            }
        //        }

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

    $('#spn_totalhour').html("Total Hours : " + total_hour + "." + total_min + " hr/week");
    //alert("Time : " + total_hour + total_min);
    //parseInt(temp2.substr(0,2)) - parseInt(temp2.substr(0,2))
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

                // $('#drpallprecourse').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

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

function bindday() {

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


                if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                    day = "<select style='width:120px' class='drpday' disabled>";
                }
                else {
                    day = "<select style='width:120px' class='drpday'>";
                }

                for (var i = 0; i < day_data.length; i++) {

                    day = day + "<option value =" + day_data[i]["day_code"] + ">" + day_data[i]["day_name"] + " </option>";

                }

                day = day + "</select>";
            }

        },
        error: function (result) {
            alert(result);
        }
    });

}

function bind_sem_course() {
    debugger;

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
        url: "../../WebService.asmx/Get_all_course_data_For_Modification",
        async: false,
        data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {


            debugger;

            if (data.d != "") {


                var year_data = JSON.parse(data.d)



                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));
                for (var i = 0; i < year_data.length; i++) {


                    $('#drcourses').append($("<option></option>").val(year_data[i]["course_code"]).html(year_data[i]["course_code"]));
                }

                $('#drcourses').chosen();


                $('#drcourses').trigger("liszt:updated");
            }
            else {
                $('#drcourses')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No Data found</option>')
                .val('');
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
    //    for (var i = 0; i < sem_data.length; i++) {


    //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

    //    }

    if ($("#hdn_utype").val() != 'I2') {
        ///  $('#drpsemester').chosen();
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

    //    $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
    //    $('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
    //    $('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

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

                $("#spn_proglvl").css('display', 'none');
                $("#drpproglevel").css('display', 'none');
                $("#drpproglevel_chzn").css('display', 'none');
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


                var semester_data = JSON.parse(data.d)






                $('#drp_semester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                for (var i = 0; i < semester_data.length; i++) {
                    $('#drp_semester').append($("<option></option>").val(semester_data[i]["semester_code"]).html(semester_data[i]["semester_name"]));
                }

                if ($("#hdn_utype").val() != 'I2') {
                    //  $('#drp_semester').chosen();
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
        url: "../../WebService.asmx/Get_faculty_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var instructor_data = JSON.parse(data.d)

                if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                    instructor = "<select style='width:85%' class='drpinstructor' disabled>";
                }
                else {
                    instructor = "<select style='width:85%' class='drpinstructor'>";
                }

                for (var i = 0; i < instructor_data.length; i++) {

                    instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";

                }

                instructor = instructor + "</select>";


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
                    area = "<select style='width:85%' class='drparea' disabled>";
                }
                else {
                    area = "<select style='width:85%' class='drparea'>";
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


                var typology_data = JSON.parse(data.d)




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
                debugger;
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

$('#tblinstructor tbody tr td i.icon-trash').live('click', function (e) {
    if ($("#hdn_utype").val() != 'I2' && $("#hdn_utype").val() != 'D' && $("#hdn_utype").val() != 'CW') {
        var r = confirm("Are you sure you want to remove this?");
        if (r == true) {

            var datalist = [];
            var flag = 'Y';
            var ob = {};
            var thisdata = $(this).closest("tr");


            $(this).closest("tr").remove();
            var totalsum = 0;
            //        $("#example tbody tr ").each(function (index) {
            //            debugger;
            //            $(this).find('.sr_no').text(index + 1);
            //        });






        }
        //    else {
        //        alert("You pressed Cancel!");
        //    }
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
            //        $("#example tbody tr ").each(function (index) {
            //            debugger;
            //            $(this).find('.sr_no').text(index + 1);
            //        });






        }
        //    else {
        //        alert("You pressed Cancel!");
        //    }
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


            $(this).closest("tr").remove();
            var totalsum = 0;
            //        $("#example tbody tr ").each(function (index) {
            //            debugger;
            //            $(this).find('.sr_no').text(index + 1);
            //        });



            calcTotalHour();


        }
        //    else {
        //        alert("You pressed Cancel!");
        //    }
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
        //        $("#example tbody tr ").each(function (index) {
        //            debugger;
        //            $(this).find('.sr_no').text(index + 1);
        //        });






    }
    else {
        alert("You pressed Cancel!");
    }
});


