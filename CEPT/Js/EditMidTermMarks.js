var oTable, oTable2, oTable3;
var editor1 = { 'doc_no': '', 'student_code': '', 'course_code': '', 'attendance': null, 'exam_1': null, 'exam_2': null, 'exam_3': null, 'exam_4': null, 'exam_5': null, 'exam_6': null, 'exam_7': null, 'exam_8': null, 'exam_9': null, 'exam_10': null, 'absent_exam_1': '', 'absent_exam_2': '', 'absent_exam_3': '', 'absent_exam_4': '', 'absent_exam_5': '', 'absent_exam_6': '', 'absent_exam_7': '', 'absent_exam_8': '', 'absent_exam_9': '', 'absent_exam_10': '', 'sem_code': null, 'year_code': null };
var course_exams = [];
var table_headers, table_headers_xls;
var sem = '';
var year = '';
var tempData = [];
var student_marks;
var course_detail;

$(document).ready(function () {
    sem = $('#hdn_s').val();
    year = $('#hdn_y').val();
    debugger;
    get_course_detail();

    course_wise_exam();

    //student_marks_upload();

    get_exam_weightage_criteria();

    get_course_typology();

    //addModalData();
});

function addModalData() {
    var str = '';

    if (course_exams.length > 0) {
        for (var i = 0; i < course_exams.length; i++) {
            str = str + '<div><div id="div_' + course_exams[i]['exam_code'] + '" style="width: 110px;font-size:14px;display:inline-block;margin-left: 5px;">Assessment ' + (i + 1) + ' </div>' +
                '<input id="txt_title_' + course_exams[i]['exam_code'] + '" type="text" value="' + course_exams[i]['exam_title'] + '" placeholder="Assessment Title" class="" style="width:300px;margin-left: 5px;"/>' +
                '<input id="txt_weightage_' + course_exams[i]['exam_code'] + '" type="text" value="' + course_exams[i]['weightage'] + '" placeholder="Weightage" class="" onkeypress="return IsNumeric(event);" style="width:50px;margin-left: 5px;"/>' +
                '<select id="drp_exam_type_' + course_exams[i]['exam_code'] + '" style="width:95px;margin-left: 5px;">' + drp_exam_criteria + '</select></div>';
        }
    }
    else {
        str = str + '<div><div id="div_exam_1" style="width: 110px;font-size:14px;display:inline-block;margin-left: 5px;">Assessment 1 </div>' +
            '<input id="txt_title_exam_1" type="text" value="" placeholder="Assessment Title" class="" style="width:300px;margin-left: 5px;"/>' +
            '<input id="txt_weightage_exam_1" type="text" value="" placeholder="Weightage" class="" onkeypress="return IsNumeric(event);" style="width:50px;margin-left: 5px;"/>' +
            '<select id="drp_exam_type_exam_1" style="width:95px;margin-left: 5px;">' + drp_exam_criteria + '</select></div>';
    }
    $('.modal-body').html(str);

    if (course_exams.length > 0) {
        for (var i = 0; i < course_exams.length; i++) {
            $('#drp_exam_type_' + course_exams[i]['exam_code']).val(course_exams[i]['exam_type'].toString());
        }
    }

    $('#btn_show_modal').click();
}

function add_exam_row() {
    var modal_data = [];
    var str = '';
    if ($('.modal-body')[0].childNodes.length < 10) {
        //for (var i = 0; i < $('.modal-body')[0].childNodes.length; i++) {
        //    str = str + '<div><div id="div_exam_' + (i + 1) + '" style="width: 110px;font-size:14px;display:inline-block;margin-left: 5px;">Assessment ' + (i + 1) + ' </div>' +
        //            '<input id="txt_title_exam_' + (i + 1) + '" type="text" value="' + $('#txt_title_exam_' + (i + 1)).val() + '" placeholder="Assessment Title" class="" style="width:300px;margin-left: 5px;"/>' +
        //            '<input id="txt_weightage_exam_' + (i + 1) + '" type="text" value="' + $('#txt_weightage_exam_' + (i + 1)).val() + '" placeholder="Weightage" class="" onkeypress="return IsNumeric(event);" style="width:50px;margin-left: 5px;"/></div>';
        //}

        str = str + '<div><div id="div_exam_' + ($('.modal-body')[0].childNodes.length + 1) + '" style="width: 110px;font-size:14px;display:inline-block;margin-left: 5px;">Assessment ' + ($('.modal-body')[0].childNodes.length + 1) + ' </div>' +
            '<input id="txt_title_exam_' + ($('.modal-body')[0].childNodes.length + 1) + '" type="text" value="" placeholder="Assessment Title" class="" style="width:300px;margin-left: 5px;"/>' +
            '<input id="txt_weightage_exam_' + ($('.modal-body')[0].childNodes.length + 1) + '" type="text" value="" placeholder="Weightage" class="" onkeypress="return IsNumeric(event);" style="width:50px;margin-left: 5px;"/>' +
            '<select id="drp_exam_type_exam_' + ($('.modal-body')[0].childNodes.length + 1) + '" style="width:95px;margin-left: 5px;">' + drp_exam_criteria + '</select></div>';

        //$('.modal-body').html(str);
        $('.modal-body').append(str);
    }
    else {
        bootbox.alert('You can Add Maximum 10 Exams per Course');
    }
}

var updated_exams = [];
var total_weightage = 0;
//var exam_row = { cancel_flag: "", course_code: "", created_by: "", created_date: "", created_host: "", doc_no: "", exam_code: "", exam_desc: "", exam_title: "", exam_type: "", last_modified_by: "", last_modified_date: "", last_modified_host: "", required_marks: "", semester_type: "", total_out_of_marks: "", weightage: "", year_semester: "" };
function updateColumn() {
    updated_exams = [];
    var modal_data = $('.modal-body')[0].childNodes;
    total_weightage = 0;
    obj_criteria_weightage = {};

    for (var i = 0; i < obj_exam_criteria.length; i++) {
        obj_criteria_weightage[obj_exam_criteria[i]['exam_type']] = 0;
    }

    if (modal_data.length <= 10) {
        for (var i = 0; i < modal_data.length; i++) {
            var exam_row = { cancel_flag: "", course_code: "", created_by: "", created_date: "", created_host: "", doc_no: "", exam_code: "", exam_desc: "", exam_title: "", exam_type: "", last_modified_by: "", last_modified_date: "", last_modified_host: "", required_marks: "", semester_type: "", total_out_of_marks: "", weightage: "", year_semester: "", is_submit: "" };
            //if ($('#txt_title_' + course_exams[i]['exam_code']).val() == '') {
            if ($('#txt_title_exam_' + (i + 1)).val() == '') {
                bootbox.alert('Please Enter Exam Title');
                return false;
            }

            //if ($('#txt_weightage_' + course_exams[i]['exam_code']).val() == '') {
            if ($('#txt_weightage_exam_' + (i + 1)).val() == '') {
                bootbox.alert('Please Enter Exam Weightage');
                return false;
            }

            //exam_row['exam_title'] = $('#txt_title_' + course_exams[i]['exam_code']).val();
            //exam_row['weightage'] = $('#txt_weightage_' + course_exams[i]['exam_code']).val();

            if (i < course_exams.length) {
                exam_row['doc_no'] = course_exams[i]['doc_no'];
                exam_row['created_by'] = course_exams[i]['created_by'];
                exam_row['created_date'] = course_exams[i]['created_date'];
                exam_row['created_host'] = course_exams[i]['created_host'];
                exam_row['is_submit'] = course_exams[i]['is_submit'];
            }
            exam_row['course_code'] = $('#hdn_c').val();
            exam_row['exam_code'] = 'exam_' + (i + 1);
            exam_row['exam_title'] = $('#txt_title_exam_' + (i + 1)).val();
            exam_row['weightage'] = $('#txt_weightage_exam_' + (i + 1)).val();
            exam_row['exam_type'] = $('#drp_exam_type_exam_' + (i + 1)).val();
            exam_row['sem_code'] = sem;
            exam_row['year_code'] = year;

            total_weightage = total_weightage + parseInt($('#txt_weightage_exam_' + (i + 1)).val());
            obj_criteria_weightage[exam_row['exam_type']] += parseInt($('#txt_weightage_exam_' + (i + 1)).val());

            updated_exams.push(exam_row);
        }
    }
    else {
        bootbox.alert('You can Add Maximum 10 Exams per Course');
    }

    if (total_weightage != 100) {
        bootbox.alert('Total Weightage Must be 100');
        return false;
    }

    if (course_typology == 'SG003') {
        for (var i = 0; i < obj_exam_criteria.length; i++) {
            var temp_weightage;
            if (obj_exam_criteria[i]['exam_type'] == 'MT') {
                temp_weightage = obj_criteria_weightage[obj_exam_criteria[i]['exam_type']];
                if (temp_weightage < obj_exam_criteria[i]['min_weightage'] || temp_weightage > obj_exam_criteria[i]['max_weightage']) {
                    bootbox.alert('Total Mid Term Exam Weightage Must be between ' + obj_exam_criteria[i]['min_weightage'] + ' and ' + obj_exam_criteria[i]['max_weightage']);
                    return false;
                }
            }
            else if (obj_exam_criteria[i]['exam_type'] == 'IN') {
                temp_weightage = obj_criteria_weightage['MT'] + obj_criteria_weightage[obj_exam_criteria[i]['exam_type']];
                if (temp_weightage < obj_exam_criteria[i]['min_weightage'] || temp_weightage > obj_exam_criteria[i]['max_weightage']) {
                    bootbox.alert('Total Internal Exam Weightage Must be between ' + obj_exam_criteria[i]['min_weightage'] + ' and ' + obj_exam_criteria[i]['max_weightage']);
                    return false;
                }
            }
            else if (obj_exam_criteria[i]['exam_type'] == 'EX') {
                temp_weightage = obj_criteria_weightage[obj_exam_criteria[i]['exam_type']];
                if (temp_weightage < obj_exam_criteria[i]['min_weightage'] || temp_weightage > obj_exam_criteria[i]['max_weightage']) {
                    bootbox.alert('Total External Exam Weightage Must be between ' + obj_exam_criteria[i]['min_weightage'] + ' and ' + obj_exam_criteria[i]['max_weightage']);
                    return false;
                }
            }
        }
    }

    if (modal_data.length <= 10) {
        $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/course_wise_all_exam_add",
                //async: false,
                data: "{newColumn_Data:'" + JSON.stringify(updated_exams) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        //course_wise_exam();
                    }
                    calc_flag = false;
                    course_wise_exam();
                },
                error: function (result) {
                    alert(result);
                }
            });
    }
    else {
        bootbox.alert('You can Add Maximum 10 Exams per Course');
    }

    //    $('#txt_modal_examtitle').val('');
    //    $('#txt_modal_examweightage').val('');

    $('#btn_modal_close').click();
}

function remove_all_exam() {
    if (course_exams.length > 0) {
        if (confirm("Are you sure you want to Remove all Exams and Exam Data")) {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/remove_all_exam_dtl",
                    //async: false,
                    data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data != "" && data != "[]") {
                            bootbox.alert(data.d, function () {
                                window.location.reload();
                            });
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }
    }
    else {
        bootbox.alert("No Exams Found");
        return false;
    }
}

function addColumn() {

    if ($('#txt_modal_examtitle').val() == '') {
        bootbox.alert('Please Enter Exam Title');
        return false;
    }

    if ($('#txt_modal_examweightage').val() == '') {
        bootbox.alert('Please Enter Exam Weightage');
        return false;
    }

    if ($('#txt_modal_examtitle').val() != '') {
        if (table_headers.length < 12) {
            //table_headers.pop();

            //var header_def = { "sTitle": $('#txt_modal_examtitle').val(), "mData": "exam_4", "bSortable": false };
            //table_headers.push(header_def);

            //table_headers.push({ "sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) { return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>'; } });

            if (table_headers.length == 2) {
                var newcolumn_data = { 'course_code': $('#hdn_c').val(), 'exam_title': $('#txt_modal_examtitle').val(), 'weightage': $('#txt_modal_examweightage').val(), 'exam_code': 'exam_1', 'sem_code': sem, 'year_code': year };
            }
            else {
                var newcolumn_data = { 'course_code': $('#hdn_c').val(), 'exam_title': $('#txt_modal_examtitle').val(), 'weightage': $('#txt_modal_examweightage').val(), 'exam_code': 'exam_' + (course_exams.length + 1), 'sem_code': sem, 'year_code': year };
            }



            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/course_wise_exam_add",
                    //async: false,
                    data: "{newColumn_Data:'" + JSON.stringify(newcolumn_data) + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            //course_wise_exam();
                        }
                        course_wise_exam();
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }
        else {
            bootbox.alert('You can Add Maximum 10 Exams per Course');
        }
    }

    $('#txt_modal_examtitle').val('');
    $('#txt_modal_examweightage').val('');

    $('#btn_modal_close').click();
}


document.onkeydown = function (event) {
    //if (!event)
    //event = window.event;
    var code = event.keyCode;
    //if (event.charCode && code == 0)

    if (event.keyCode == 38) {
        var index;
        var b = event.target.parentElement;

        if (b.parentElement != null) {
            if (b.parentElement.previousSibling != null) {
                var c = event.target.parentElement.parentElement.childNodes;
                for (var i = 0; i < c.length; i++) {
                    if (c[i] == b) {
                        index = i;
                    }
                }
                //if (b.parentElement.previousSibling.childNodes[index].textContent == "" && b.parentElement.previousSibling.childNodes[index].hasChildNodes() == true) {
                if (b.parentElement.previousSibling.childNodes[index].hasChildNodes() == true) {
                    b1 = b.parentElement.previousSibling.childNodes[index].childNodes[0];

                    //b1.focus();
                    setTimeout(function () {
                        b1.focus();
                    }, 1);
                }
            }
        }
        //console.log(code + ' : ' + index);
    }

    if (event.keyCode == 40) {
        var index;
        var b = event.target.parentElement;

        if (b.parentElement != null) {
            if (b.parentElement.nextSibling != null) {
                var c = event.target.parentElement.parentElement.childNodes;
                for (var i = 0; i < c.length; i++) {
                    if (c[i] == b) {
                        index = i;
                    }
                }
                //if (b.parentElement.nextSibling.childNodes[index].textContent == "" && b.parentElement.nextSibling.childNodes[index].hasChildNodes() == true) {
                if (b.parentElement.nextSibling.childNodes[index].hasChildNodes() == true) {
                    b1 = b.parentElement.nextSibling.childNodes[index].childNodes[0];

                    //b1.focus();
                    setTimeout(function () {
                        b1.focus();
                    }, 1);
                }
            }
        }
        //console.log(code + ' : ' + index);
    }
    //event.preventDefault();
};


function IsNumeric(e) {
    //alert(e.which + " : " + e.keyCode);

    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 46) {
        if ($(document.activeElement).val().indexOf('.') != -1) {
            return false;
        }
        if ($(document.activeElement).val() == '100') {
            return false;
        }
    }

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {

        if (($(document.activeElement).val().indexOf('.') != -1) && ($(document.activeElement)[0].selectionStart > $(document.activeElement).val().indexOf('.'))) {
            if ($(document.activeElement).val().substr($(document.activeElement).val().indexOf('.') + 1).length >= 2) {
                return false;
            }
            else {
                return true;
            }
        }
        else {
            if (parseInt($(document.activeElement).val()) > 10) {
                return false;
            }
            else if (parseInt($(document.activeElement).val()) == 10) {
                if (keyCode != 48) {
                    return false;
                }
                else {
                    if ($(document.activeElement).val().indexOf('.') != -1) {
                        return false;
                    }
                }
            }
        }

        return true;
    }
    else {
        return false;
    }
}


function rowClick(row) {

    var parenttr = row.parentElement.parentElement.parentElement;

    //editor1.student_code = parenttr.childNodes[0].childNodes[0].nodeValue;
    //editor1.student_code = parenttr.childNodes[0].innerText;
    //editor1.exam_1 = parenttr.childNodes[2].innerText;
    //parenttr.childNodes[2].innerHTML = "<input type='text' value='" + editor1.exam_1 + "' class='inline_input'/>";
    //parenttr.childNodes[12].innerHTML = "<center><button type='button' onclick='rowSave(this)'>Save</button></center>";

    for (var i = 0; i < course_exams.length; i++) {
        parenttr.childNodes[i + 2].innerHTML = "<input type='text' value='" + parenttr.childNodes[i + 2].innerText + "' class='inline_input' onkeypress='return IsNumeric(event);'/>";
    }

    parenttr.childNodes[course_exams.length + 2].innerHTML = "<center><button type='button' onclick='rowSave(this)'>Save</button></center>";
}

var calc_flag = false;

function calculate_grade() {
    calc_flag = true;
    save_student_marks_Data();
}

//function calculate_grade() {
//    var url = "Calculated_Commit_Grade.aspx?c=" + $('#hdn_c').val() + "&s=" + $('#hdn_s').val() + "&y=" + $('#hdn_y').val();
//    window.open(url, '_blank');
//}

var submit_flag = false;
function submit_grade() {
    if (course_exams.length == 0) {
        return false;
    }

    submit_flag = true;
    isValidate = true;

    $("#example tbody tr").each(function (i) {

        //if ($(this).children().eq(2)[0].children[0].value == '') {
        //    bootbox.alert('Please Enter Attendance for Student Code : ' + $(this).children().eq(0).html());
        //    isValidate = false;
        //    return false;
        //}

        if (course_exams.length > 0) {
            if ($(this).children().eq(3)[0].children[0].value == '') {
                if ($(this).children().eq(3)[0].children[1].value == '') {
                    bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                    isValidate = false;
                    return false;
                }
            }
            if (course_exams.length > 1) {
                if ($(this).children().eq(4)[0].children[0].value == '') {
                    if ($(this).children().eq(4)[0].children[1].value == '') {
                        bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                        isValidate = false;
                        return false;
                    }
                }
                if (course_exams.length > 2) {
                    if ($(this).children().eq(5)[0].children[0].value == '') {
                        if ($(this).children().eq(5)[0].children[1].value == '') {
                            bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                            isValidate = false;
                            return false;
                        }
                    }
                    if (course_exams.length > 3) {
                        if ($(this).children().eq(6)[0].children[0].value == '') {
                            if ($(this).children().eq(6)[0].children[1].value == '') {
                                bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                                isValidate = false;
                                return false;
                            }
                        }
                        if (course_exams.length > 4) {
                            if ($(this).children().eq(7)[0].children[0].value == '') {
                                if ($(this).children().eq(7)[0].children[1].value == '') {
                                    bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                                    isValidate = false;
                                    return false;
                                }
                            }
                            if (course_exams.length > 5) {
                                if ($(this).children().eq(8)[0].children[0].value == '') {
                                    if ($(this).children().eq(8)[0].children[1].value == '') {
                                        bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                                        isValidate = false;
                                        return false;
                                    }
                                }
                                if (course_exams.length > 6) {
                                    if ($(this).children().eq(9)[0].children[0].value == '') {
                                        if ($(this).children().eq(9)[0].children[1].value == '') {
                                            bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                                            isValidate = false;
                                            return false;
                                        }
                                    }
                                    if (course_exams.length > 7) {
                                        if ($(this).children().eq(10)[0].children[0].value == '') {
                                            if ($(this).children().eq(10)[0].children[1].value == '') {
                                                bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                                                isValidate = false;
                                                return false;
                                            }
                                        }
                                        if (course_exams.length > 8) {
                                            if ($(this).children().eq(11)[0].children[0].value == '') {
                                                if ($(this).children().eq(11)[0].children[1].value == '') {
                                                    bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                                                    isValidate = false;
                                                    return false;
                                                }
                                            }
                                            if (course_exams.length > 9) {
                                                if ($(this).children().eq(12)[0].children[0].value == '') {
                                                    if ($(this).children().eq(12)[0].children[1].value == '') {
                                                        bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                                                        isValidate = false;
                                                        return false;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    });

    if (isValidate) {
        save_student_marks_Data();
    }
    else {
        submit_flag = false;
    }
}

var submit_exam_flag = false;
var exam_to_submit = '';
function submit_exam(str_exam_code) {
    debugger;
    if (course_exams.length == 0) {
        return false;
    }

    exam_to_submit = str_exam_code;
    str_exam_code = parseInt(str_exam_code.substr(5)) + 2;
    submit_exam_flag = true;
    var isExamValidate = true;

    $("#example tbody tr").each(function (i) {
        if ($(this).children().eq(str_exam_code)[0].children[0].value == '') {
            if ($(this).children().eq(str_exam_code)[0].children[1].value == '') {
                bootbox.alert('Please Enter Marks or Select Absent Detail for Student Code : ' + $(this).children().eq(0).html());
                isExamValidate = false;
                return false;
            }
        }
    });

    if (isExamValidate) {
        save_student_marks_Data();
    }
    else {
        submit_exam_flag = false;
    }
}

function submit_course_grade() {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/submit_course_grade",
            //async: false,
            data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "', page:'EDIT'}",
            dataType: "json",
            success: function (data) {
                tempData = [];
                if (data.d != "" && data.d != "[]") {
                    if (data.d == 'Data Saved Successfully') {
                        bootbox.alert('Course submitted successfully', function (result) {
                            window.location = "Course_wise_entered_marks.aspx";
                        });
                    }
                    else {
                        submit_flag = false;
                        bootbox.alert(data.d);
                    }
                }
                //course_wise_exam();
            },
            error: function (result) {
                tempData = [];
                alert(result);
            }
        });
}

function submit_exam_marks() {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/submit_exam_marks",
            //async: false,
            data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "', exam_code:'" + exam_to_submit + "'}",
            dataType: "json",
            success: function (data) {
                bootbox.alert(data.d, function () {
                    window.location.reload();
                });
            },
            error: function (result) {
                alert(result);
            }
        });
    submit_exam_flag = false;
}

function save_student_marks_Data() {

    if (course_exams.length == 0) {
        return false;
    }

    $("#example tbody tr").each(function (i) {

        editor1.student_code = $(this).children().eq(0).html();
        editor1.attendance = $(this).children().eq(2)[0].children[0].value;

        editor1.course_code = $('#hdn_c').val();
        if (course_exams.length > 0) {
            editor1.exam_1 = $(this).children().eq(3)[0].children[0].value;
            editor1.absent_exam_1 = $(this).children().eq(3)[0].children[1].value;
            if (course_exams.length > 1) {
                editor1.exam_2 = $(this).children().eq(4)[0].children[0].value;
                editor1.absent_exam_2 = $(this).children().eq(4)[0].children[1].value;
                if (course_exams.length > 2) {
                    editor1.exam_3 = $(this).children().eq(5)[0].children[0].value;
                    editor1.absent_exam_3 = $(this).children().eq(5)[0].children[1].value;
                    if (course_exams.length > 3) {
                        editor1.exam_4 = $(this).children().eq(6)[0].children[0].value;
                        editor1.absent_exam_4 = $(this).children().eq(6)[0].children[1].value;
                        if (course_exams.length > 4) {
                            editor1.exam_5 = $(this).children().eq(7)[0].children[0].value;
                            editor1.absent_exam_5 = $(this).children().eq(7)[0].children[1].value;
                            if (course_exams.length > 5) {
                                editor1.exam_6 = $(this).children().eq(8)[0].children[0].value;
                                editor1.absent_exam_6 = $(this).children().eq(8)[0].children[1].value;
                                if (course_exams.length > 6) {
                                    editor1.exam_7 = $(this).children().eq(9)[0].children[0].value;
                                    editor1.absent_exam_7 = $(this).children().eq(9)[0].children[1].value;
                                    if (course_exams.length > 7) {
                                        editor1.exam_8 = $(this).children().eq(10)[0].children[0].value;
                                        editor1.absent_exam_8 = $(this).children().eq(10)[0].children[1].value;
                                        if (course_exams.length > 8) {
                                            editor1.exam_9 = $(this).children().eq(11)[0].children[0].value;
                                            editor1.absent_exam_9 = $(this).children().eq(11)[0].children[1].value;
                                            if (course_exams.length > 9) {
                                                editor1.exam_10 = $(this).children().eq(12)[0].children[0].value;
                                                editor1.absent_exam_10 = $(this).children().eq(12)[0].children[1].value;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        editor1.sem_code = sem;
        editor1.year_code = year;

        for (var j = 0; j < student_marks.length; j++) {
            if (student_marks[j]['student_code'] == editor1.student_code) {
                editor1.doc_no = student_marks[j]['doc_no'];
            }
        }

        tempData.push(editor1);

        editor1 = { 'doc_no': '', 'student_code': '', 'course_code': '', 'attendance': null, 'exam_1': null, 'exam_2': null, 'exam_3': null, 'exam_4': null, 'exam_5': null, 'exam_6': null, 'exam_7': null, 'exam_8': null, 'exam_9': null, 'exam_10': null, 'absent_exam_1': '', 'absent_exam_2': '', 'absent_exam_3': '', 'absent_exam_4': '', 'absent_exam_5': '', 'absent_exam_6': '', 'absent_exam_7': '', 'absent_exam_8': '', 'absent_exam_9': '', 'absent_exam_10': '', 'sem_code': null, 'year_code': null };
    });

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_all_students_marks",
            //async: false,
            data: "{student_marks_Data:'" + JSON.stringify(tempData) + "'}",
            dataType: "json",
            success: function (data) {
                tempData = [];
                if (data.d != "" && data.d != "[]") {
                    if (data.d == 'Data Saved Successfully') {
                        if (submit_flag) {
                            submit_course_grade();
                            return;
                        }
                        if (!calc_flag) {
                            if (submit_exam_flag) {
                                submit_exam_marks();
                            }
                            else {
                                bootbox.alert(data.d, function () {
                                    //location.reload();
                                });
                            }
                        }
                        course_wise_exam();
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                //course_wise_exam();
            },
            error: function (result) {
                tempData = [];
                alert(result);
            }
        });
}

function rowSave(row) {

    var parenttr = row.parentElement.parentElement.parentElement;
    var doc;

    for (var i = 0; i < student_marks.length; i++) {
        if (student_marks[i]['student_code'] == parenttr.childNodes[0].innerText) {
            //alert(student_marks[i]['student_code'] + ' : ' + student_marks[i]['doc_no']);
            doc = student_marks[i]['doc_no'];
        }
    }

    editor1.doc_no = doc;
    editor1.student_code = parenttr.childNodes[0].innerText;
    editor1.course_code = $('#hdn_c').val();
    editor1.attendance = parenttr.childNodes[2].childNodes[0].value.trim();
    if (course_exams.length > 0) {
        editor1.exam_1 = parenttr.childNodes[3].childNodes[0].value.trim();
        editor1.absent_exam_1 = parenttr.childNodes[3].childNodes[1].value.trim();
        if (course_exams.length > 1) {
            editor1.exam_2 = parenttr.childNodes[4].childNodes[0].value.trim();
            editor1.absent_exam_2 = parenttr.childNodes[4].childNodes[1].value.trim();
            if (course_exams.length > 2) {
                editor1.exam_3 = parenttr.childNodes[5].childNodes[0].value.trim();
                editor1.absent_exam_3 = parenttr.childNodes[5].childNodes[1].value.trim();
                if (course_exams.length > 3) {
                    editor1.exam_4 = parenttr.childNodes[6].childNodes[0].value.trim();
                    editor1.absent_exam_4 = parenttr.childNodes[6].childNodes[1].value.trim();
                    if (course_exams.length > 4) {
                        editor1.exam_5 = parenttr.childNodes[7].childNodes[0].value.trim();
                        editor1.absent_exam_5 = parenttr.childNodes[7].childNodes[1].value.trim();
                        if (course_exams.length > 5) {
                            editor1.exam_6 = parenttr.childNodes[8].childNodes[0].value.trim();
                            editor1.absent_exam_6 = parenttr.childNodes[8].childNodes[1].value.trim();
                            if (course_exams.length > 6) {
                                editor1.exam_7 = parenttr.childNodes[9].childNodes[0].value.trim();
                                editor1.absent_exam_7 = parenttr.childNodes[9].childNodes[1].value.trim();
                                if (course_exams.length > 7) {
                                    editor1.exam_8 = parenttr.childNodes[10].childNodes[0].value.trim();
                                    editor1.absent_exam_8 = parenttr.childNodes[10].childNodes[1].value.trim();
                                    if (course_exams.length > 8) {
                                        editor1.exam_9 = parenttr.childNodes[11].childNodes[0].value.trim();
                                        editor1.absent_exam_9 = parenttr.childNodes[11].childNodes[1].value.trim();
                                        if (course_exams.length > 9) {
                                            editor1.exam_10 = parenttr.childNodes[12].childNodes[0].value.trim();
                                            editor1.absent_exam_10 = parenttr.childNodes[12].childNodes[1].value.trim();
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    editor1.sem_code = sem;
    editor1.year_code = year;

    //save_student_marks(editor1);
    //editor1.student_code = parenttr.childNodes[0].childNodes[0].nodeValue;
    //editor1.exam_1 = parenttr.childNodes[2].childNodes[0].value.trim();
    //parenttr.childNodes[2].innerHTML = editor1.exam_1;
    //parenttr.childNodes[12].innerHTML = "<center><button type='button' onclick='rowClick(this)'>Edit</button></center>";

    var student_entry = editor1;

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_student_marks",
            //async: false,
            data: "{student_marks_Data:'" + JSON.stringify(student_entry) + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    if (data.d == 'Data Saved Successfully') {

                        for (var i = 0; i < course_exams.length; i++) {
                            parenttr.childNodes[i + 2].innerHTML = parenttr.childNodes[i + 2].childNodes[0].value.trim();
                        }
                        parenttr.childNodes[course_exams.length + 2].innerHTML = "<center><button type='button' onclick='rowClick(this)'>Edit</button></center>";

                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                //course_wise_exam();
            },
            error: function (result) {
                alert(result);
            }
        });


    //for (var i = 0; i < course_exams.length; i++) {
    //parenttr.childNodes[i + 2].innerHTML = parenttr.childNodes[i + 2].childNodes[0].value.trim();
    //}

    //parenttr.childNodes[course_exams.length + 2].innerHTML = "<center><button type='button' onclick='rowClick(this)'>Edit</button></center>";

    editor1 = { 'doc_no': '', 'student_code': '', 'course_code': '', 'attendance': null, 'exam_1': null, 'exam_2': null, 'exam_3': null, 'exam_4': null, 'exam_5': null, 'exam_6': null, 'exam_7': null, 'exam_8': null, 'exam_9': null, 'exam_10': null, 'absent_exam_1': '', 'absent_exam_2': '', 'absent_exam_3': '', 'absent_exam_4': '', 'absent_exam_5': '', 'absent_exam_6': '', 'absent_exam_7': '', 'absent_exam_8': '', 'absent_exam_9': '', 'absent_exam_10': '', 'sem_code': null, 'year_code': null };
}

function get_course_detail() {
    debugger;
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_course_detail",
            //async: false,
            data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    course_detail = JSON.parse(data.d);
                    $('#spn_course_name').html('' + course_detail[0]['course_code'] + ' - ' + course_detail[0]['course_name']);
                    $('#H1').html('' + course_detail[0]['course_code'] + ' - ' + course_detail[0]['course_name']);
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}

var obj_exam_criteria;
var drp_exam_criteria = '';
function get_exam_weightage_criteria() {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_exam_weightage_criteria",
            //async: false,
            data: "{}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    obj_exam_criteria = JSON.parse(data.d);
                    drp_exam_criteria = '';

                    for (var i = 0; i < obj_exam_criteria.length; i++) {
                        drp_exam_criteria += '<option value="' + obj_exam_criteria[i]['exam_type'] + '">' + obj_exam_criteria[i]['exam_type_desc'] + '</option>';
                    }
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}

function course_wise_exam() {
    //$('#DataList').css('display', 'none');
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/course_wise_exam_list",
            //async: false,
            data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
            dataType: "json",
            success: function (data) {

                table_headers = [
                    //{ "sTitle": "Doc No", "mData": "doc_no", "bSortable": false, "bVisible": false },       
                    { "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false }
                ];
                if (data.d != "" && data.d != "[]") {

                    table_headers.push({
                        "sTitle": "Attendance", "mData": "attendance", "bSortable": false, mRender: function (ddata) {
                            return "<input type='text' value='" + ddata + "' class='inline_input' onkeypress='return IsNumeric(event);'/>";
                        }
                    });

                    //course_wise_exam_weightage_list(data.d);
                    course_exams = JSON.parse(data.d);

                    for (var i = 0; i < course_exams.length; i++) {
                        if (course_exams[i].exam_type != "MT") {
                            course_exams.splice(i, 1);
                            i = i - 1;
                        }
                    }

                    for (var i = 0; i < course_exams.length; i++) {
                            //var header_def = { "sTitle": course_exams[i].exam_title + ' (' + course_exams[i].weightage + '%)', "mData": course_exams[i].exam_code, "bSortable": false };

                            var header_def = {
                                "sTitle": course_exams[i].exam_title + ' (' + course_exams[i].weightage + '%)<br/><button id="btn_' + course_exams[i].exam_code + '" type="button" class="btn btn-small btn-primary" style="margin-top:5px;" onclick="submit_exam(\'' + course_exams[i].exam_code + '\')">Submit</button>', "mData": course_exams[i].exam_code, "bSortable": false, mRender: function (ddata) {
                                    return "<input type='text' value='" + ddata + "' class='inline_input' onkeypress='return IsNumeric(event);'/>" +
                                        "<select class='cls_absent' style='width: 46px;margin-top: 5px;padding:0px;'>" +
                                        "<option value=''>--</option>" +
                                        "<option value='AB'>AB</option>" +
                                        "<option value='NA'>NA</option>" +
                                        "</select>";
                                }
                            };

                            table_headers.push(header_def);
                    }

                    if (calc_flag) {
                        table_headers.push({ "sTitle": "Total Marks", "mData": "subject_marks", "bSortable": false });
                        table_headers.push({ "sTitle": "Student Grade", "mData": "course_grade", "bSortable": false });
                    }

                }

                //table_headers.push({ "sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) { return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>'; } });

                course_wise_student_marks();

            },
            error: function (result) {
                alert(result);
            }
        });

    //return false;
}

var course_typology = '';
function get_course_typology() {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_course_typology",
            //async: false,
            data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    course_typology = JSON.parse(data.d)[0]['sub_group'].toString();
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    //return false;
}


function course_wise_student_marks() {
    //$('#DataList').css('display', 'none');
    var ajax_url;
    if (calc_flag) {
        //ajax_url = "../../WebService.asmx/calc_course_wise_student_marks_list";
        ajax_url = "../../WebService.asmx/get_student_wise_grade";
        calc_flag = false;
    }
    else {
        ajax_url = "../../WebService.asmx/course_wise_student_marks_list";
    }

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            //url: "../../WebService.asmx/course_wise_student_marks_list",
            url: ajax_url,
            //async: false,
            data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    //course_wise_exam_weightage_list(data.d);
                    //course_exams = JSON.parse(data.d);
                    student_marks = JSON.parse(data.d);

                    student_wise_marks_list(student_marks);
                }
                else if (data.d == "") {
                    student_wise_marks_list(data.d);
                }
                else if (data.d == "[]") {
                    if (ajax_url == "../../WebService.asmx/get_student_wise_grade") {
                        bootbox.alert('Grade Range not Found for given marks');
                    }
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    //return false;
}


function student_wise_marks_list(data) {
    debugger;
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //"sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //"aButtons": [
        ////"copy",
        //"print",
        //{
        //"sExtends": "collection",
        //"sButtonText": 'Export',
        //"aButtons": ["xls"]
        //}
        //]
        //},
        //"aaData": JSON.parse(data),
        "aaData": data,
        "aoColumns": table_headers
    });

    $('#DataList').css('display', 'block');

    if (student_marks != undefined) {
        if (student_marks.length > 0) {
            $("#example tbody tr").each(function (i) {
                if (course_exams.length > 0) {
                    $(this).children().eq(3)[0].children[1].value = student_marks[i].absent_exam_1;
                    if (student_marks[i].absent_exam_1 != '') { $(this).children().eq(3)[0].children[0].disabled = true; }
                    /*if (course_exams[0]["is_submit"] == "Y") { $(this).children().eq(3)[0].children[0].disabled = true; $(this).children().eq(3)[0].children[1].disabled = true; }*/
                    if (course_exams.length > 1) {
                        $(this).children().eq(4)[0].children[1].value = student_marks[i].absent_exam_2;
                        if (student_marks[i].absent_exam_2 != '') { $(this).children().eq(4)[0].children[0].disabled = true; }
                        //if (course_exams[1]["is_submit"] == "Y") { $(this).children().eq(4)[0].children[0].disabled = true; $(this).children().eq(4)[0].children[1].disabled = true; }
                        if (course_exams.length > 2) {
                            $(this).children().eq(5)[0].children[1].value = student_marks[i].absent_exam_3;
                            if (student_marks[i].absent_exam_3 != '') { $(this).children().eq(5)[0].children[0].disabled = true; }
                            //if (course_exams[2]["is_submit"] == "Y") { $(this).children().eq(5)[0].children[0].disabled = true; $(this).children().eq(5)[0].children[1].disabled = true; }
                            if (course_exams.length > 3) {
                                $(this).children().eq(6)[0].children[1].value = student_marks[i].absent_exam_4;
                                if (student_marks[i].absent_exam_4 != '') { $(this).children().eq(6)[0].children[0].disabled = true; }
                                //if (course_exams[3]["is_submit"] == "Y") { $(this).children().eq(6)[0].children[0].disabled = true; $(this).children().eq(6)[0].children[1].disabled = true; }
                                if (course_exams.length > 4) {
                                    $(this).children().eq(7)[0].children[1].value = student_marks[i].absent_exam_5;
                                    if (student_marks[i].absent_exam_5 != '') { $(this).children().eq(7)[0].children[0].disabled = true; }
                                    //if (course_exams[4]["is_submit"] == "Y") { $(this).children().eq(7)[0].children[0].disabled = true; $(this).children().eq(7)[0].children[1].disabled = true; }
                                    if (course_exams.length > 5) {
                                        $(this).children().eq(8)[0].children[1].value = student_marks[i].absent_exam_6;
                                        if (student_marks[i].absent_exam_6 != '') { $(this).children().eq(8)[0].children[0].disabled = true; }
                                        //if (course_exams[5]["is_submit"] == "Y") { $(this).children().eq(8)[0].children[0].disabled = true; $(this).children().eq(8)[0].children[1].disabled = true; }
                                        if (course_exams.length > 6) {
                                            $(this).children().eq(9)[0].children[1].value = student_marks[i].absent_exam_7;
                                            if (student_marks[i].absent_exam_7 != '') { $(this).children().eq(9)[0].children[0].disabled = true; }
                                            //if (course_exams[6]["is_submit"] == "Y") { $(this).children().eq(9)[0].children[0].disabled = true; $(this).children().eq(9)[0].children[1].disabled = true; }
                                            if (course_exams.length > 7) {
                                                $(this).children().eq(10)[0].children[1].value = student_marks[i].absent_exam_8;
                                                if (student_marks[i].absent_exam_8 != '') { $(this).children().eq(10)[0].children[0].disabled = true; }
                                                //if (course_exams[7]["is_submit"] == "Y") { $(this).children().eq(10)[0].children[0].disabled = true; $(this).children().eq(10)[0].children[1].disabled = true; }
                                                if (course_exams.length > 8) {
                                                    $(this).children().eq(11)[0].children[1].value = student_marks[i].absent_exam_9;
                                                    if (student_marks[i].absent_exam_9 != '') { $(this).children().eq(11)[0].children[0].disabled = true; }
                                                    //if (course_exams[8]["is_submit"] == "Y") { $(this).children().eq(11)[0].children[0].disabled = true; $(this).children().eq(11)[0].children[1].disabled = true; }
                                                    if (course_exams.length > 9) {
                                                        $(this).children().eq(12)[0].children[1].value = student_marks[i].absent_exam_10;
                                                        if (student_marks[i].absent_exam_10 != '') { $(this).children().eq(12)[0].children[0].disabled = true; }
                                                        //if (course_exams[9]["is_submit"] == "Y") { $(this).children().eq(12)[0].children[0].disabled = true; $(this).children().eq(12)[0].children[1].disabled = true; }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            });
        }
    }

    $('.cls_absent').on('change', function () {
        //alert('change' + this.value);
        if (this.value != '') {
            this.previousSibling.value = '';
            this.previousSibling.disabled = true;
        }
        else {
            this.previousSibling.disabled = false;
        }
    });
    var all_delete = true;
    //for (var i = 0; i < course_exams.length; i++) {
    //    if (course_exams[i]["is_submit"] == "Y") {
    //        $("#btn_" + course_exams[i].exam_code).remove();
    //    } else {
    //        all_delete = false;
    //    }
    //}
    if (course_exams.length > 0) {
        if (all_delete) {
            $("#btn_excel_format").remove();
            $("#reservation_upload_document").remove();
            $("#btnsave").remove();
            $("#btn_add_exam").remove();
        }
    }
}


function display_student_marks_upload_error_data(data) {

    if (oTable2 != null) {
        oTable2.fnDestroy();
        $("#DataList2").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example2" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable2 = $("#example2").dataTable({

        "bPaginate": false,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //     "oTableTools": {
        //         "aButtons": [
        //         //"copy",
        //	"print",
        //         	{
        //         	    "sExtends": "collection",
        //         	    "sButtonText": 'Export',
        //         	    "aButtons": ["xls"]
        //         	}
        //]
        //     },

        //"aaData": JSON.parse(data),
        "aaData": data,

        "aoColumns": [{ "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
        { "sTitle": "User Id", "mData": "User_Id", "bSortable": false },
        { "sTitle": "Remark", "mData": "Remark", "bSortable": false }]
    });

    $('#DataList2').css('display', 'block');
    $('#btn_show_modal2').click();
}



function display_data_for_excel() {

    var str = '<div id="DataList_xls_format" style="display: none;"><table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%"><thead></thead><tbody></tbody></table></div>';

    $('#mynewModal3 .modal-body').html(str);

    table_headers_xls = [{ "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false }];

    if (course_exams.length > 0) {
        table_headers_xls.push({ "sTitle": "Attendance", "mData": "attendance", "bSortable": false });
        for (var i = 0; i < course_exams.length; i++) {
            table_headers_xls.push({ "sTitle": course_exams[i].exam_title + ' (' + course_exams[i].weightage + '%)', "mData": course_exams[i].exam_code, "bSortable": false });
        }
    }

    if (table_headers.length > table_headers_xls.length) {

        for (var i = table_headers_xls.length; i < table_headers.length; i++) {
            table_headers_xls.push(table_headers[i]);
        }
    }

    if (oTable3 != null) {
        oTable3.fnDestroy();
        $("#DataList_xls_format").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_xls_format" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable3 = $("#example_xls_format").dataTable({

        "bPaginate": false,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //     "oTableTools": {
        //         "aButtons": [
        //         //"copy",
        //	"print",
        //         	{
        //         	    "sExtends": "collection",
        //         	    "sButtonText": 'Export',
        //         	    "aButtons": ["xls"]
        //         	}
        //]
        //     },

        //"aaData": JSON.parse(data),
        "aaData": student_marks,

        "aoColumns": table_headers_xls
    });

    $('#DataList_xls_format').css('display', 'block');
    $('#btn_show_modal3').click();
}



function display_excel_format() {

    var str = '<div id="DataList_xls_format" style="display: none;"><table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%"><thead></thead><tbody></tbody></table></div>';

    $('#mynewModal3 .modal-body').html(str);
    // "sTitle": "Approval Status", "mData": null, "bSortable": false, mRender: function (data) {
    table_headers_xls = [{ "sTitle": "Student_Code", "mData": "student_code", "bSortable": false }];

    if (course_exams.length > 0) {
        table_headers_xls.push({
            "sTitle": "Attendance", "mData": null, "bSortable": false, mRender: function (data) {
                return '';
            }
        });

        for (var i = 0; i < course_exams.length; i++) {
            if (course_exams[i]["is_submit"] != "Y") {
                table_headers_xls.push({
                    "sTitle": course_exams[i].exam_title, "mData": null, "bSortable": false, mRender: function (data) {
                        return '';
                    }
                });
            }

        }
    }

    if (oTable3 != null) {
        oTable3.fnDestroy();
        $("#DataList_xls_format").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_xls_format" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable3 = $("#example_xls_format").dataTable({

        "bPaginate": false,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //     "oTableTools": {
        //         "aButtons": [
        //         //"copy",
        //	"print",
        //         	{
        //         	    "sExtends": "collection",
        //         	    "sButtonText": 'Export',
        //         	    "aButtons": ["xls"]
        //         	}
        //]
        //     },

        //"aaData": JSON.parse(data),
        "aaData": student_marks,

        "aoColumns": table_headers_xls
    });

    $('#DataList_xls_format').css('display', 'block');
    $('#btn_show_modal3').click();
}


//var temp = [
//            { "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
//            { "sTitle": "Student Name", "mData": "student_name", "bSortable": false },
//            { "sTitle": "Exam 1", "mData": "exam_1", "bSortable": false },
//            { "sTitle": "Exam 2", "mData": "exam_2", "bSortable": false },
//            { "sTitle": "Exam 3", "mData": "exam_3", "bSortable": false },
//            { "sTitle": "Exam 4", "mData": "exam_4", "bSortable": false },
//            { "sTitle": "Exam 5", "mData": "exam_5", "bSortable": false },
//            { "sTitle": "Exam 6", "mData": "exam_6", "bSortable": false },
//            { "sTitle": "Exam 7", "mData": "exam_7", "bSortable": false },
//            { "sTitle": "Exam 8", "mData": "exam_8", "bSortable": false },
//            { "sTitle": "Exam 9", "mData": "exam_9", "bSortable": false },
//            { "sTitle": "Exam 10", "mData": "exam_10", "bSortable": false },


//            { "sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) {
//                //alert(course_code);
//                return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
//            }
//            }];
