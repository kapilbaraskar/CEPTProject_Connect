var oTable;
var obj_course_detail;
var obj_ws_course_detail;

$(document).ready(function () {
    bindsemdata();
    bindyeardata_for_cross_reg();

    $('#btnreterive').on('click', function () {
        course_wise_student_marks();
        return false;
    });

    setCurrentSemester();
});

$(document).on("click", ".monsoon_spring_course_outline", function (event) {
    $('#hdn_course_code').val($(this).parent().parent().children()[0].innerText);
    $('#hdn_sem_code').val($('#drpsemester').val());
    $('#hdn_year_code').val($('#drpyear').val());
    $('#btn_download').click();
});

function setCurrentSemester() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/get_current_grade_semester",
        //async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var cur_grade_sem = JSON.parse(data.d);

                if (cur_grade_sem.length > 0) {
                    $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                    $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                    $('#drpsemester').trigger("liszt:updated");
                    $('#drpyear').trigger("liszt:updated");

                    if (cur_grade_sem[0]['sem_code'].toString() == 'S') $('#div_cur_sem').html('Spring');
                    else if (cur_grade_sem[0]['sem_code'].toString() == 'M') $('#div_cur_sem').html('Monsoon');

                    //$('#div_cur_year').html(cur_grade_sem[0]['year_code'].toString());
                    $('#div_cur_year').html(cur_grade_sem[0]['year_code'].toString() + "-" + (parseInt(cur_grade_sem[0]['year_code']) + 1).toString().substr(2, 2));

                    $('#btnreterive').click();
                }
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

    $('#drpsemester').chosen();
}

function bindyeardata_for_cross_reg() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_year_data",
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

var is_eligible = false;

function course_wise_student_marks() {

    foundation_flag = false;
    $('#DataList').css('display', 'none');

    $('#div_marksheet_data').css('display', 'none');
    $('#div_marksheet_tbl').css('display', 'none');
    //$('#div_download_pdf').css('display', 'none');//uncomment when you want to not display
    is_eligible = false;

    semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester');
        $('#drpsemester').focus();
        return false;
    }

    year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year');
        $('#drpyear').focus();
        return false;
    }

    if (semester == 'S') $('#div_cur_sem').html('Spring');
    else if (semester == 'M') $('#div_cur_sem').html('Monsoon');

    //$('#div_cur_year').html(cur_grade_sem[0]['year_code'].toString());
    $('#div_cur_year').html(year_code + "-" + (parseInt(year_code) + 1).toString().substr(2, 2));
    var show_internal_marksheet = true;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/get_student_maksheet",
        async: false,
        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            
            var response = JSON.parse(data.d);
            if (response['status'] == 'falsee') {
                show_internal_marksheet = false;
                bootbox.alert(response['message']);
            }
            else if (response['status'] == 'false') {
                bootbox.alert(response['message']);
            }
            else if (response['status'] == 'true') {
                data.d = JSON.stringify(response['message']);

                if (data.d != "" && data.d != "[]") {
                    //display_course_wise_student_marks(data.d);

                    setCourseDetail(data.d);
                    
                    $('#div_stud_name').html(JSON.parse(data.d)['stud_detail'][0]['user_name']);

                    setCreditsDetail(data.d);

                    setWSCourseDetail(data.d);

                    //setMidTermMarks(data.d);

                    if (!foundation_flag) $('#div_marksheet_tbl').css('display', 'block');

                    if (JSON.parse(data.d)['course_grade_detail'] != null)
                    {
                        if (JSON.parse(data.d)['course_grade_detail'].length == 0 && JSON.parse(data.d)['course_grade_detail'].length != undefined) {
                            $('#div_marksheet_tbl').css('display', 'none');
                        }
                    }
                    else
                    {
                        $("#div_stud_name").css("margin-left", "-120px");
                        $("#div_cur_sem").css("margin-left", "-120px");
                        $("#div_cur_year").css("margin-left", "-120px");
                    }

                    $('#div_marksheet_data').css('display', 'block');

                    is_eligible = true;
                    //$('#div_course_list').css('display', 'block');
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
    
    if (show_internal_marksheet) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/get_student_midterm_marks_midterm",//get_student_midterm_marks
            //async: false,
            data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                var response = JSON.parse(data.d);

                if (response['status'] == 'false') {
                    bootbox.alert(response['message']);
                    $('#div_mid_term').css('display', 'none');
                }
                else if (response['status'] == 'true') {
                    data.d = JSON.stringify(response['message']);
                    if (data.d != "" && data.d != "[]")
                    {
                        $('#div_stud_name').html(JSON.parse(data.d)['stud_detail'][0]['user_name']);
                        $('#hdn_user_id').val(JSON.parse(data.d)['stud_detail'][0]['user_id']);

                        if (!foundation_flag) {
                            setMidTermMarks(data.d);//Put condition if foundation program data comes then not binding this data
                            $('#tbl_foundation_marks_new').parent().parent().css('display', 'none');
                        }

                        $('#div_marksheet_data').css('display', 'block');
                    }
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
}

function display_course_wise_student_marks(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
                //"copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls"]
                }
            ]
        },

        //"aaData": JSON.parse(data),
        "aaData": JSON.parse(data)['course_grade_detail'],

        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Title", "mData": "course_name", "bSortable": false },
            { "sTitle": "GPA/ Non GPA", "mData": "gpa_nongpa", "bSortable": false },
        ]
    });

    $('#DataList').css('display', 'block');
}

function btnClick() {
    if (is_eligible) {
        var filter_criteria = { sem_code: semester, year: year_code };
        $('#hdn_filter').val(JSON.stringify(filter_criteria));

        $('#hdn_download').click();
    }
}

function btnClick_coursecatlog()
{
    var semester = $('#drpsemester').val();
    var year_code = $('#drpyear').val();
    var user_id = $('#hdn_user_id').val();

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_OutlinePDF_For_VerticalStudio_new",
        //async: false,
        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',status:'Y'}",
        dataType: "json",
        success: function (data)
        {
            if (data.d != null && data.d != "")
            {
               // hdn_course_dtl.val(JSON.parse(data["d"][0]));
               // hdn_course_weekly_percent_dtl.val(JSON.parse(data["d"][1]));
               // hdn_Course_wise_instructor_dtl.val(JSON.parse(data["d"][2]));
               // hdn_Portfoliolink_dtl.val(JSON.parse(data["d"][3]));
            }
        },
        error: function (result) {
            alert(result);
        }
    });
    


}

var foundation_flag = false;

function setCourseDetail(data) {
    debugger;
    obj_course_detail = JSON.parse(data)['course_grade_detail'];

    var obj_foundation_detail = JSON.parse(data)['foundation_dtl'];

    if (obj_foundation_detail != null && obj_foundation_detail != undefined && obj_foundation_detail.length != 0) {
        var str_foundation_html = '';

        if (obj_course_detail != null && obj_course_detail != undefined) {
            var pass_fail_flag = 1;
            var total_marks = 0;
            var total_credits = 0;

            var aggregate = 0;
            var sem1_pass_aggregate = 50;
            var sem2_pass_aggregate = 60;
            var semno = 0;
            var pass_marks = 50;// for Y2020 and onwards passing marks is 60 - 02112020

            if ($("#hdn_year_code_foundation").val() == 'Y2017' || $("#hdn_year_code_foundation").val() == 'Y2018' || $("#hdn_year_code_foundation").val() == 'Y2019') {
                sem1_pass_aggregate = 50;
            }
            else if (parseInt($("#hdn_year_code_foundation").val().slice(1)) >= 2023)
            {
                //changes 1
                sem1_pass_aggregate = 55;
                pass_marks = 55;// for Y2023 and onwards passing marks is 60 - 22012024
            }
            else
            {
                sem1_pass_aggregate = 60;
                pass_marks = 60;// for Y2020 and onwards passing marks is 60 - 02112020
            }

            if ($("#hdn_year_code_foundation").val() == 'Y2019') {// for Y2019 students passing aggregate marks is 65 - 22072020
                sem2_pass_aggregate = 65;
            }

            var year = parseInt($('#drpyear').val());
            var sem = $('#drpsemester').val();

            //11092020 CFP Marks Grade Change like M 2019 and onwards
            var grade_style = "OLD";

            if ($("#hdn_year_code_foundation").val() >= "Y2019") {
                if ($('#drpsemester').val() != "S" && parseInt($('#drpyear').val()) != 2019 || $('#drpsemester').val() == "S" && parseInt($('#drpyear').val()) > 2019
                    || $('#drpsemester').val() == "M" && parseInt($('#drpyear').val()) >= 2019) {
                    grade_style = "NEW";
                }
            }
            //11092020 CFP Marks Grade Change like M 2019 and onwards

            if (grade_style == "OLD") {
                if (year <= 2018) {
                    if (sem == "S" || year < 2018 && sem == "M") {
                        // for Spring 2018 and before
                        for (var i = 0; i < obj_course_detail.length; i++) {
                            str_foundation_html += '<tr>';
                            str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['Total'] + '/100</td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                            str_foundation_html += '</tr>';

                            if (!(parseInt(obj_course_detail[i]['Total']) >= 50)) {
                                pass_fail_flag = pass_fail_flag * 0;
                            }

                            if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * 25) / 100;
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * 75) / 100;
                            }

                            total_credits += parseInt(obj_course_detail[i]['course_credits']);
                        }

                        if (pass_fail_flag) $('#spn_pass_fail').html('PASS');
                        else $('#spn_pass_fail').html('FAIL');

                        str_foundation_html += '<tr><td colspan="3"><b>' + total_marks.toFixed(0) + ' Out of 100 - 20 Credits </b>(If, 50 or greater than 50, then Pass.)</td></tr>';

                        $('#tbl_foundation_marks').append(str_foundation_html);

                        $('#tbl_foundation_marks').parent().parent().css('display', 'block');
                        $('#tbl_foundation_marks_new').css('display', 'none');
                        $('#div_marksheet_tbl').css('display', 'none');

                    } else {
                        // for Monsson 2018 and onwards
                        $('#tbl_foundation_marks_new tbody').html('');
                        str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                        for (var i = 0; i < obj_course_detail.length; i++) {
                            str_foundation_html += '<tr>';
                            str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                            if (i == 0) {
                                str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                            }
                            str_foundation_html += '</tr > ';

                            if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                                pass_fail_flag = pass_fail_flag * 0;
                            }

                            if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }

                            total_credits += parseInt(obj_course_detail[i]['course_credits']);
                        }

                        aggregate = total_marks / total_credits;

                        final_aggregate = parseInt(aggregate.toFixed(0));

                        $('#tbl_foundation_marks_new').append(str_foundation_html);

                        if (pass_fail_flag) {
                            if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                                $('#spn_pass_fail_new').html('PASS');
                            }
                            else {
                                $('#spn_pass_fail_new').html('FAIL');
                            }
                        }
                        else {
                            $('#spn_pass_fail_new').html('FAIL');
                        }

                        $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                        $('#tbl_foundation_marks').css('display', 'none');
                        $('#div_marksheet_tbl').css('display', 'none');
                    }
                } else {
                    // for Monsson 2018 and onwards
                    $('#tbl_foundation_marks_new tbody').html('');
                    str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                    for (var i = 0; i < obj_course_detail.length; i++) {
                        str_foundation_html += '<tr>';
                        str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                        if (i == 0) {
                            str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                        }
                        str_foundation_html += '</tr > ';

                        if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                            pass_fail_flag = pass_fail_flag * 0;
                        }

                        if (obj_course_detail[i]['course_code'] == 'CFP001') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }

                        total_credits += parseInt(obj_course_detail[i]['course_credits']);
                    }

                    aggregate = total_marks / total_credits;

                    final_aggregate = parseInt(aggregate.toFixed(0));

                    $('#tbl_foundation_marks_new').append(str_foundation_html);

                    if (pass_fail_flag) {
                        if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                            $('#spn_pass_fail_new').html('PASS');
                        }
                        else {
                            $('#spn_pass_fail_new').html('FAIL');
                        }
                    }
                    else {
                        $('#spn_pass_fail_new').html('FAIL');
                    }

                    $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                    $('#tbl_foundation_marks').css('display', 'none');
                    $('#div_marksheet_tbl').css('display', 'none');
                }
            }
            else if (grade_style == "NEW") {
                $('#tbl_foundation_marks_new tbody').html('');
                str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                for (var i = 0; i < obj_course_detail.length; i++) {
                    str_foundation_html += '<tr>';
                    str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                    if (i == 0) {
                        str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                    }
                    str_foundation_html += '</tr > ';

                    //if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                    //    pass_fail_flag = pass_fail_flag * 0;
                    //}

                    if (obj_course_detail[i]['course_code'] == 'CFP001') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                        semno = 2;
                    }

                    if (semno == 1) {
                        if (!(parseInt(obj_course_detail[i]['Total']) >= pass_marks)) {// for Y2020 and onwards passing marks is 60 - 02112020
                            if (pass_fail_flag != 0) {
                                pass_fail_flag = pass_fail_flag * 0;
                            }
                        }
                        else {
                            window.total_earned_credit += parseInt(obj_course_detail[i]['course_credits']);
                            if (obj_course_detail[i]['c_type'] == 'M') {
                                window.core_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                            else {
                                window.ele_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                        }
                    } else if (semno == 2) {
                        if (!(parseInt(obj_course_detail[i]['Total']) >= 60)) {
                            if (pass_fail_flag != 0) {
                                pass_fail_flag = pass_fail_flag * 0;
                            }
                        }
                        else {
                            window.total_earned_credit += parseInt(obj_course_detail[i]['course_credits']);
                            if (obj_course_detail[i]['c_type'] == 'M') {
                                window.core_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                            else {
                                window.ele_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                        }
                    }

                    total_credits += parseInt(obj_course_detail[i]['course_credits']);
                }

                $('#tbl_foundation_marks_new').append(str_foundation_html);

                if (pass_fail_flag) {
                    $('#spn_pass_fail_new').html('PASS');
                }
                else {
                    $('#spn_pass_fail_new').html('FAIL');
                }

                $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                $('#tbl_foundation_marks').css('display', 'none');
                $('#div_marksheet_tbl').css('display', 'none');
            }

            foundation_flag = true;
            $('#div_mid_term').css('display', 'none');
            //For Foundation Internal and Midterm Marks not to be shown
        }
    }
    
    else if (obj_course_detail != null && obj_course_detail != undefined && obj_course_detail.length != 0)
    {
        debugger;
        var is_foud = false;
        for (var i = 0; i < obj_course_detail.length; i++) {
            if (obj_course_detail[i]['course_code'] == "CFP001" || obj_course_detail[i]['course_code'] == "CFP002" || obj_course_detail[i]['course_code'] == "CFP003" || obj_course_detail[i]['course_code'] == "CFP007"
                || obj_course_detail[i]['course_code'] == "CFP004" || obj_course_detail[i]['course_code'] == "CFP005" || obj_course_detail[i]['course_code'] == "CFP006" || obj_course_detail[i]['course_code'] == "CFP008"
                || obj_course_detail[i]['course_code'] == "CFP009" || obj_course_detail[i]['course_code'] == "CFP010") {
                is_foud = true;
            }
        }

        if (!is_foud) {
            var strTableCourseDetail = " <tr><th>COURSE CODE</th><th>TITLE OF THE COURSE</th><th>CORE/ ELECTIVE</th><th>CREDIT</th>" +
                //" <th>MARKS</th>" +
                " <th>GPA/ NGPA</th>" +
                " <th>GRADE</th>";

            //if (obj_stud_detail[0]["year_code"] < 'Y2014') { strTableCourseDetail = strTableCourseDetail + "<th>GRADE POINT</th>"; }

            strTableCourseDetail = strTableCourseDetail + "<th>REMARKS</th>";
            strTableCourseDetail = strTableCourseDetail + "<th>Outline</th></tr>";

            for (var i = 0; i < obj_course_detail.length; i++) {
                strTableCourseDetail = strTableCourseDetail + "<tr>" +
                    "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_course_detail[i]['course_code'] + "</a></td>" +
                    "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_course_detail[i]['course_name'] + "</a></td>" +
                    "<td>" + obj_course_detail[i]['c_type'] + "</td>" +
                    "<td>" + obj_course_detail[i]['course_credits'] + "</td>";
                //"<td>" + obj_course_detail[i]['Total'] + "</td>";
                
                if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
                else if (obj_course_detail[i]['c_type'] == 'M' && obj_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
                else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
                else if (obj_course_detail[i]['c_type'] == 'E' && obj_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
                else { strTableCourseDetail = strTableCourseDetail + "<td></td>"; }

                strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['grade'] + "</td>";

                //if (obj_stud_detail[0]["year_code"] < 'Y2014') { strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['grade_point'] + "</td>"; }

                strTableCourseDetail = strTableCourseDetail + "<td>" + obj_course_detail[i]['remarks'] + "</td>";
                strTableCourseDetail = strTableCourseDetail + "<td><a style='cursor:pointer;color:#0B6CBA;' class='monsoon_spring_course_outline'>Download</a></td></tr>";
            }

            $('#tbl_course_marks').html(strTableCourseDetail);

            $('#div_marksheet_tbl').css('display', '');

        } else {//Copied and Pasted Above Code

            var pass_fail_flag = 1;
            var total_marks = 0;
            var total_credits = 0;

            var aggregate = 0;
            var sem1_pass_aggregate = 50;
            var sem2_pass_aggregate = 60;
            var semno = 0;
            var pass_marks = 50;// for Y2020 and onwards passing marks is 60 - 02112020

            if ($("#hdn_year_code_foundation").val() == 'Y2017' || $("#hdn_year_code_foundation").val() == 'Y2018' || $("#hdn_year_code_foundation").val() == 'Y2019') {
                sem1_pass_aggregate = 50;
            }
            else if (parseInt($("#hdn_year_code_foundation").val().slice(1)) >= 2023) {
                //changes 1
                sem1_pass_aggregate = 55;
                pass_marks = 55;// for Y2023 and onwards passing marks is 55 - 22012024
            }
            else {
                sem1_pass_aggregate = 60;
                pass_marks = 60;// for Y2020 and onwards passing marks is 60 - 02112020
            }

            if ($("#hdn_year_code_foundation").val() == 'Y2019') {// for Y2019 students passing aggregate marks is 65 - 22072020
                sem2_pass_aggregate = 65;
            }

            var year = parseInt($('#drpyear').val());
            var sem = $('#drpsemester').val();

            //11092020 CFP Marks Grade Change like M 2019 and onwards
            var grade_style = "OLD";
            if ($("#hdn_year_code_foundation").val() >= "Y2019") {
                if ($('#drpsemester').val() != "S" && parseInt($('#drpyear').val()) != 2019 || $('#drpsemester').val() == "S" && parseInt($('#drpyear').val()) > 2019
                    || $('#drpsemester').val() == "M" && parseInt($('#drpyear').val()) >= 2019) {
                    grade_style = "NEW";
                }
            }
            //11092020 CFP Marks Grade Change like M 2019 and onwards

            if (grade_style == "OLD") {
                if (year <= 2018) {
                    if (sem == "S" || year < 2018 && sem == "M") {
                        // for Spring 2018 and before
                        for (var i = 0; i < obj_course_detail.length; i++) {
                            str_foundation_html += '<tr>';
                            str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['Total'] + '/100</td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                            str_foundation_html += '</tr>';

                            if (!(parseInt(obj_course_detail[i]['Total']) >= 50)) {
                                pass_fail_flag = pass_fail_flag * 0;
                            }

                            if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * 25) / 100;
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * 75) / 100;
                            }

                            total_credits += parseInt(obj_course_detail[i]['course_credits']);
                        }

                        if (pass_fail_flag) $('#spn_pass_fail').html('PASS');
                        else $('#spn_pass_fail').html('FAIL');

                        str_foundation_html += '<tr><td colspan="3"><b>' + total_marks.toFixed(0) + ' Out of 100 - 20 Credits </b>(If, 50 or greater than 50, then Pass.)</td></tr>';

                        $('#tbl_foundation_marks').append(str_foundation_html);

                        $('#tbl_foundation_marks').parent().parent().css('display', 'block');
                        $('#tbl_foundation_marks_new').css('display', 'none');
                        $('#div_marksheet_tbl').css('display', 'none');
                    } else {
                        // for Monsson 2018 and onwards
                        $('#tbl_foundation_marks_new tbody').html('');
                        str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                        for (var i = 0; i < obj_course_detail.length; i++) {
                            str_foundation_html += '<tr>';
                            str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                            if (i == 0) {
                                str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                            }
                            str_foundation_html += '</tr > ';

                            if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                                pass_fail_flag = pass_fail_flag * 0;
                            }

                            if (obj_course_detail[i]['course_code'] == 'CFP001') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                                semno = 1;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }
                            else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                                semno = 2;
                                total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                            }

                            total_credits += parseInt(obj_course_detail[i]['course_credits']);
                        }

                        aggregate = total_marks / total_credits;

                        final_aggregate = parseInt(aggregate.toFixed(0));

                        $('#tbl_foundation_marks_new').append(str_foundation_html);

                        if (pass_fail_flag) {
                            if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                                $('#spn_pass_fail_new').html('PASS');
                            }
                            else {
                                $('#spn_pass_fail_new').html('FAIL');
                            }
                        }
                        else {
                            $('#spn_pass_fail_new').html('FAIL');
                        }

                        $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                        $('#tbl_foundation_marks').css('display', 'none');
                        $('#div_marksheet_tbl').css('display', 'none');
                    }
                }
                else {
                    // for Monsson 2018 and onwards
                    $('#tbl_foundation_marks_new tbody').html('');
                    str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                    for (var i = 0; i < obj_course_detail.length; i++) {
                        str_foundation_html += '<tr>';
                        str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                        if (i == 0) {
                            str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                        }
                        str_foundation_html += '</tr > ';

                        if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                            pass_fail_flag = pass_fail_flag * 0;
                        }

                        if (obj_course_detail[i]['course_code'] == 'CFP001') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                            semno = 1;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }
                        else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                            semno = 2;
                            total_marks += (parseInt(obj_course_detail[i]['Total']) * parseInt(obj_course_detail[i]['course_credits']));
                        }

                        total_credits += parseInt(obj_course_detail[i]['course_credits']);
                    }

                    aggregate = total_marks / total_credits;

                    final_aggregate = parseInt(aggregate.toFixed(0));

                    $('#tbl_foundation_marks_new').append(str_foundation_html);

                    if (pass_fail_flag) {
                        if (semno == 1 && final_aggregate >= sem1_pass_aggregate || semno == 2 && final_aggregate >= sem2_pass_aggregate) {
                            $('#spn_pass_fail_new').html('PASS');
                        }
                        else {
                            $('#spn_pass_fail_new').html('FAIL');
                        }
                    }
                    else {
                        $('#spn_pass_fail_new').html('FAIL');
                    }

                    $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                    $('#tbl_foundation_marks').css('display', 'none');
                    $('#div_marksheet_tbl').css('display', 'none');
                }
            }
            else if (grade_style == "NEW") {
                $('#tbl_foundation_marks_new tbody').html('');
                str_foundation_html += '<tr><td><b>Foundation Programme - I</b></td></tr>';
                for (var i = 0; i < obj_course_detail.length; i++) {
                    str_foundation_html += '<tr>';
                    str_foundation_html += '<td><b>' + obj_course_detail[i]['course_name'] + '</b></td><td>' + obj_course_detail[i]['course_credits'] + ' Credits</td>';
                    if (i == 0) {
                        str_foundation_html += '<td rowspan="' + obj_course_detail.length + '" style="vertical-align : middle;text-align:center;"><b><span id="spn_pass_fail_new"></span></b></td>';
                    }
                    str_foundation_html += '</tr > ';

                    //if (!(parseInt(obj_course_detail[i]['Total']) >= 45)) {//45 comes from database
                    //    pass_fail_flag = pass_fail_flag * 0;
                    //}

                    if (obj_course_detail[i]['course_code'] == 'CFP001') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP002') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP003') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP007') {
                        semno = 1;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP004') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP005') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP006') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP008') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP009') {
                        semno = 2;
                    }
                    else if (obj_course_detail[i]['course_code'] == 'CFP010') {
                        semno = 2;
                    }

                    if (semno == 1) {
                        if (!(parseInt(obj_course_detail[i]['Total']) >= pass_marks)) {// for Y2020 and onwards passing marks is 60 - 02112020
                            if (pass_fail_flag != 0) {
                                pass_fail_flag = pass_fail_flag * 0;
                            }
                        }
                        else {
                            window.total_earned_credit += parseInt(obj_course_detail[i]['course_credits']);
                            if (obj_course_detail[i]['c_type'] == 'M') {
                                window.core_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                            else {
                                window.ele_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                        }
                    } else if (semno == 2) {
                        if (!(parseInt(obj_course_detail[i]['Total']) >= 60)) {
                            if (pass_fail_flag != 0) {
                                pass_fail_flag = pass_fail_flag * 0;
                            }
                        }
                        else {
                            window.total_earned_credit += parseInt(obj_course_detail[i]['course_credits']);
                            if (obj_course_detail[i]['c_type'] == 'M') {
                                window.core_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                            else {
                                window.ele_cr += parseInt(obj_course_detail[i]['course_credits']);
                            }
                        }
                    }

                    total_credits += parseInt(obj_course_detail[i]['course_credits']);
                }

                $('#tbl_foundation_marks_new').append(str_foundation_html);

                if (pass_fail_flag) {
                    $('#spn_pass_fail_new').html('PASS');
                }
                else {
                    $('#spn_pass_fail_new').html('FAIL');
                }

                $('#tbl_foundation_marks_new').parent().parent().css('display', 'block');
                $('#tbl_foundation_marks').css('display', 'none');
                $('#div_marksheet_tbl').css('display', 'none');
            }

            foundation_flag = true;
            $('#div_mid_term').css('display', 'none');
        }

        $('#div_download_pdf').css('display', 'block');
    } else {
        $('#div_download_pdf').css('display', 'none');
        $('#div_marksheet_tbl').css('display', 'none');
    }
}

function setWSCourseDetail(data) {
    obj_ws_course_detail = JSON.parse(data)['ws_course_grade_detail'];

    if (obj_ws_course_detail != null && obj_ws_course_detail != undefined && obj_ws_course_detail.length != 0) {
        var strTableCourseDetail = "<tr><th>COURSE CODE</th><th>COURSE NAME</th><th>GPA/ NGPA</th><th>CREDITS</th><th>STATUS</th></tr>";

        for (var i = 0; i < obj_ws_course_detail.length; i++) {
            strTableCourseDetail = strTableCourseDetail + "<tr>" +
                "<td>" + obj_ws_course_detail[i]['course_code'] + "</td>" +
                "<td>" + obj_ws_course_detail[i]['course_name'] + "</td>";

            if (obj_ws_course_detail[i]['c_type'] == 'M' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
            else if (obj_ws_course_detail[i]['c_type'] == 'M' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
            else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'G') { strTableCourseDetail = strTableCourseDetail + "<td>GPA</td>"; }
            else if (obj_ws_course_detail[i]['c_type'] == 'E' && obj_ws_course_detail[i]['gpa_nongpa'] == 'N') { strTableCourseDetail = strTableCourseDetail + "<td>NGPA</td>"; }
            else { strTableCourseDetail = strTableCourseDetail + "<td></td>"; }

            strTableCourseDetail = strTableCourseDetail + "<td>" + obj_ws_course_detail[i]['course_credits'] + "</td>";

            //if (obj_ws_course_detail[i]['Total'] > 49) strTableCourseDetail = strTableCourseDetail + "<td>PASS</td></tr>";
            //else if (obj_ws_course_detail[i]['Total'] < 50) strTableCourseDetail = strTableCourseDetail + "<td>FAIL</td></tr>";

            strTableCourseDetail = strTableCourseDetail + "<td>" + obj_ws_course_detail[i]['remarks'] + "</td></tr>";
        }

        $('#tbl_ws_course_marks').html(strTableCourseDetail);
        $('#div_ws_course_marks').css('display', 'block');

        if (obj_ws_course_detail[0]['semester_type'] == 'S') $('#title_ws_course_marks').html("Summer School");
        else if (obj_ws_course_detail[0]['semester_type'] == 'W') $('#title_ws_course_marks').html("Winter School");
    }
    else {//Added 17102019 Mayur
        $('#tbl_ws_course_marks').html('');
        $('#div_ws_course_marks').css('display', 'none');//Added 17102019 Mayur
    }//Added 17102019 Mayur
}

function setCreditsDetail(data) {
    obj_credit_detail = JSON.parse(data)['credit_detail'];

    if (obj_credit_detail != null && obj_credit_detail != undefined) {
        $('#spn_credit_calculated').html(obj_credit_detail[0]['total_credit']);
        $('#spn_gpa').html(obj_credit_detail[0]['gpa_credit']);
        $('#spn_nongpa').html(obj_credit_detail[0]['ngpa_credit']);
        //$('#spn_calculated_gpa').html(obj_credit_detail[0]['grade_point_avg']);
        if (obj_credit_detail[0]['grade_point_avg'].toString() == '-') {
            $('#spn_calculated_gpa').html(obj_credit_detail[0]['grade_point_avg']);
        }
        else {
            $('#spn_calculated_gpa').html(round_num(round_num(obj_credit_detail[0]['grade_point_avg'], 2), 1));
        }
    }
}

function round_num(num, precision) {
    return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
}

function setMidTermMarks(data) {
    
    obj_marks_detail = JSON.parse(data)['mid_term_marks'];

    if (obj_marks_detail != null && obj_marks_detail != undefined) {
        var strTableCourseDetail = "<tr><th style='width:100px;' rowspan='2'>COURSE CODE</th><th rowspan='2'>COURSE NAME</th><th style='width:205px;'>Mid Term</th><th style='width:205px;' colspan='2'>Internal</th></tr>" +//colspan='2'
            //var strTableCourseDetail = "<tr><th style='width:100px;' rowspan='2'>COURSE CODE</th><th rowspan='2'>COURSE NAME</th><th style='width:205px;' colspan='2'>Mid Term</th></tr>" +
            "<tr><th>Grade</th><th>Obtained Marks</th><th>Total Marks</th><th>Outline</th></tr>";//<th>Total Marks</th>
        //"<tr><th>Obtained Marks</th><th>Total Marks</th></tr>";
        
        for (var i = 0; i < obj_marks_detail.length; i++) {
            var obtained_marks;
            var in_obtained_marks;

            if (obj_marks_detail[i]['mt_obtained_marks'].toString() != '' && obj_marks_detail[i]['mt_obtained_marks'].toString() != '0')
                obtained_marks = parseFloat(parseFloat(obj_marks_detail[i]['mt_obtained_marks'].toString()).toFixed(1));
            else if (obj_marks_detail[i]['mt_obtained_marks'].toString() != '')
                obtained_marks = obj_marks_detail[i]['mt_absent_dtl'].toString();
            else
                obtained_marks = obj_marks_detail[i]['mt_obtained_marks'];

            if (obj_marks_detail[i]['in_obtained_marks'].toString() != '' && obj_marks_detail[i]['in_obtained_marks'].toString() != '0')
                in_obtained_marks = parseFloat(parseFloat(obj_marks_detail[i]['in_obtained_marks'].toString()).toFixed(1));
            else if (obj_marks_detail[i]['in_obtained_marks'].toString() != '')
                in_obtained_marks = obj_marks_detail[i]['in_absent_dtl'].toString();
            else
                in_obtained_marks = obj_marks_detail[i]['in_obtained_marks'];

            //if (obj_marks_detail[i]['sub_group'] == "SG003" || obj_marks_detail[i]['sub_group'] == "SG001" || obj_marks_detail[i]['sub_group'] == "SG006") {

            if (true) {//Email 16032022 Mahroofbhai
                //Blockmarks as of now 24092021 - Call Nitinbhai Mahroofbhai Start
                //strTableCourseDetail = strTableCourseDetail + "<tr>" +
                //    "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_code'] + "</a></td>" +
                //    "<td style='text-align:left;'><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_name'] + "</a></td>" +
                //    "<td>" + obtained_marks + "</td>" +
                //    "<td>" + obj_marks_detail[i]['mt_total_marks'] + "</td>" +
                //    "<td> - </td>" +
                //    "<td> - </td>" +
                //    "<td><a style='cursor:pointer;color:#0B6CBA;' class='monsoon_spring_course_outline'>Download</a></td>" +
                //    "</tr>";
                //Blockmarks as of now 24092021 - Call Nitinbhai Mahroofbhai End
                strTableCourseDetail = strTableCourseDetail + "<tr>" +
                    "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_code'] + "</a></td>" +
                    "<td style='text-align:left;'><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_name'] + "</a></td>" +
                    "<td>" + obj_marks_detail[i]['grade'] + "</td>" +
                    //"<td>-</td>" +
                    "<td> - </td>" +
                    "<td> - </td>" +
                    "<td><a style='cursor:pointer;color:#0B6CBA;' class='monsoon_spring_course_outline'>Download</a></td>" +
                    "</tr>";
            } else {
                //Blockmarks as of now 24092021 - Call Nitinbhai Mahroofbhai Start
                //strTableCourseDetail = strTableCourseDetail + "<tr>" +
                //    "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_code'] + "</a></td>" +
                //    "<td style='text-align:left;'><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_name'] + "</a></td>" +
                //    "<td>" + obtained_marks + "</td>" +
                //    "<td>" + obj_marks_detail[i]['mt_total_marks'] + "</td>" +
                //    "<td>" + in_obtained_marks + "</td>" +
                //    "<td>" + obj_marks_detail[i]['in_total_marks'] + "</td>" +
                //    "<td><a style='cursor:pointer;color:#0B6CBA;' class='monsoon_spring_course_outline'>Download</a></td>" +
                //    "</tr>";
                //Blockmarks as of now 24092021 - Call Nitinbhai Mahroofbhai End
                strTableCourseDetail = strTableCourseDetail + "<tr>" +
                    "<td><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_code'] + "</a></td>" +
                    "<td style='text-align:left;'><a style='cursor:pointer' class='monsoon_spring_course_outline'>" + obj_marks_detail[i]['course_name'] + "</a></td>" +
                    "<td>" + obj_marks_detail[i]['grade'] + "</td>" +
                    //"<td>-</td>" +
                    "<td>" + in_obtained_marks + "</td>" +
                    "<td>" + obj_marks_detail[i]['in_total_marks'] + "</td>" +
                    "<td><a style='cursor:pointer;color:#0B6CBA;' class='monsoon_spring_course_outline'>Download</a></td>" +
                    "</tr>";
            }
        }

        $('#tbl_mid_term').html(strTableCourseDetail);
        $('#div_mid_term').css('display', 'block');
    }
}
