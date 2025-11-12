var oTable;
var sem = '';
var year = '';
var dept_code = '';
var prog_code = '';
var prog_level_code = '';
var obj_typology_group = [];
var obj_typology = {};

$(document).ready(function () {
    bindsemdata();
    bindyeardata_for_cross_reg();
    binddepartment();
    bindprogrammedata();
    bindproglevel();
    get_all_typology_group();

    $('#btnreterive').on('click', function () {
        course_wise_avg_marks();
        return false;
    });

    setCurrentSemester();

    $('#drptypology').html('<option value="">-- Please Select Typology --</option>');

    $('#drp_typology_group').on('change', function () {

        $('#drptypology').html('<option value="">-- Please Select Typology --</option>');

        if ($('#drp_typology_group').val() != '') {
            for (var i = 0; i < obj_typology[$('#drp_typology_group').val()].length; i++) {
                $('#drptypology').append('<option value="' + obj_typology[$('#drp_typology_group').val()][i]['type_code'].toString() + '">' + obj_typology[$('#drp_typology_group').val()][i]['type_name'].toString() + '</option>');
            }
        }
        $('#drpsubtypology').find('option').remove().end().append('<option value="">No Data found</option>').val('');
        $('#typ_sub_group').css("display", "none");
        $('#drpsubtypology').css("display", "none");
    });

    //$('#drptypology').on('change', function () {
    //    if ($("#drptypology").val() != '') {
    //        bindsubgrouptypology();
    //    }
    //});
});

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

                //$('#typ_sub_group').css("display", "block");
                //$('#drpsubtypology').css("display", "block");
            }
            else {
                $('#drpsubtypology').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                $('#typ_sub_group').css("display", "none");
                $('#drpsubtypology').css("display", "none");
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function setCurrentSemester() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_current_grade_semester",
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


//function rowClick(row) {
//    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
//    window.location = "Student_wise_marks.aspx?c=" + rowId;
//    //window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
//}


function Submit_grade_range() {
    var obj_grade_dtl = [];
    var selected_course = "";

    if ($("#example_filter :input").val() != '') {
        bootbox.alert("Please Remove Course Code in Search Box then Submit");
        return false;
    }

    var ALL_Course = false;

    if ($(".chk_selection_all_course_code").is(':checked')) {
        ALL_Course = true;
    }

    var ind_select = false;

    $('#example tbody tr').each(function (d) {

        if ($(this).find(".chk_selection_course_code").is(':checked')) {

            ind_select = true;

            //obj_grade_dtl.push({ 'course_code': $(this).find('.course_code').html(), 'grade_type': $(this).find('.cls_grade_type').val() }); 

            if (d == 0) {
                selected_course = $(this).find('.course_code').html();
            } else {
                if (selected_course == "") {
                    selected_course = $(this).find('.course_code').html();
                } else {
                    selected_course += '#' + $(this).find('.course_code').html();
                }
            }
        }

        obj_grade_dtl.push({ 'course_code': $(this).find('.course_code').html(), 'grade_type': $(this).find('.cls_grade_type').val() });

        //console.log(d);

        //for (var i = 0; i < window.course_wise_grade_range.length; i++) {
        //    var course_code = window.course_wise_grade_range[i]["course_code"];
        //    var type_code = window.course_wise_grade_range[i]["grade_type"];

        //    if (course_code == $(this).find('td:first-child').html()) {
        //        window.course_wise_grade_range[i]["course_code"] = $(this).find('td:first-child').html();
        //        window.course_wise_grade_range[i]["grade_type"] = $(this).find('.cls_grade_type').val();
        //    }
        //}
    });

    if (ind_select || ALL_Course) {

    } else {
        bootbox.alert("Please select any Course Grade Range");
        return false;
    } 

    //obj_grade_dtl = window.course_wise_grade_range;

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/submit_course_wise_grade_range",
            //async: false,
            data: "{sem_code:'" + sem + "',year_code:'" + year + "',course_grade_type:'" + JSON.stringify(obj_grade_dtl) + "',selected_course:'" + selected_course + "', ALL_Course:" + ALL_Course + " }",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    bootbox.alert("Grade Range for selected Courses Submitted Successfully.");//data.d
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}

function course_wise_avg_marks() {
    $('#DataList').css('display', 'none');

    sem = $('#drpsemester').val();
    if (sem == "") {
        bootbox.alert('Please select semester');
        $('#drpsemester').focus();
        return false;
    }

    year = $('#drpyear').val();
    if (year == "") {
        bootbox.alert('Please select Year');
        $('#drpyear').focus();
        return false;
    }

    dept_code = $('#drpdepartment').val();

    prog_code = $('#drpprog').val();

    prog_level_code = $('#drpproglevel').val();

    if ($('#drp_typology_group').val() != "") {
        if ($('#drptypology').val() == "") {
            bootbox.alert('Please select Course Typology');
            $('#drpyear').focus();
            return false;
        }
    }

    course_typology = $('#drptypology').val();

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_course_wise_avg_sd_range",
            //async: false,
            data: "{sem_code:'" + sem + "',year_code:'" + year + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',course_typology:'" + course_typology +"'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    //course_wise_avg_marks_list(data.d);
                    //$('#div_course_list').css('display', 'block');
                    
                    var result = JSON.parse(data.d);

                    if (result['status'] == 'True' && result['message']['course_grade_detail'] != null) {
                        course_wise_avg_marks_list(result['message']);
                        $('#div_course_list').css('display', 'block');
                    }
                    else if (result['status'] == 'False') {
                        bootbox.alert(result['message']);
                        $('#div_course_list').css('display', 'none');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester and Year');
                        $('#div_course_list').css('display', 'none');
                    }

                    if (dept_code != "" || prog_code != "" || prog_level_code != "" || course_typology != "") {
                        $('th')[0].innerHTML = '';
                    }
                }
                else {
                    bootbox.alert('No data Found For Selected Semester and Year');
                    $('#div_course_list').css('display', 'none');
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
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

                        for (var i = 0; i < obj_typology_group.length; i++) {
                            obj_typology[obj_typology_group[i]['group_id']] = jQuery.grep(typology_data, function (data) { return data.group_id === obj_typology_group[i]['group_id'] });
                        }
                    }
                }               
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

var absolute_range;
function course_wise_avg_marks_list(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    window.course_wise_grade_range = [];
    for (var i = 0; i < data["course_grade_detail"].length; i++) {
        window.course_wise_grade_range.push({ 'course_code': data["course_grade_detail"][i]["course_code"], 'grade_type': data["course_grade_detail"][i]["grade_type"] })
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
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }//,"select"
        //    ]
        //},
        "aaData": data['course_grade_detail'],
        "aoColumns": [
            {
                "sTitle": "Select <center><input type='checkbox' name='cc' class='chk_selection_all_course_code' ></center>", "mData": null, "bSortable": false, mRender: function (data) {
                    return '<center><input type="checkbox" name="substudio_user" class="chk_selection_course_code" ></center>';
                }
            },
            {
                "sTitle": "Course Code", "mData": null, "bSortable": false, mRender: function (data) {
                    return '<span class="course_code" >' + data.course_code + '</span>';
                }
            },
            //{ "sTitle": "Course Total Marks", "mData": "Course_Total_Marks", "bSortable": false },
            //{"sTitle": "Total Students", "mData": "Total_Students", "bSortable": false },
            //{ "sTitle": "Average Marks", "mData": "Average", "bSortable": false },
            //{ "sTitle": "Standard Deviation", "mData": "SD", "bSortable": false },

            {
                "sTitle": "Grade Type", "mData": null, "bSortable": false, mRender: function (data) {
                    return '<select class="cls_grade_type" style="width:90px;"><option value="R">Relative</option><option value="A">Absolute</option></select>' +
                        '<input type="hidden" class="cls_hdn_grade_type" value="' + data.grade_type + '" />';
                }
            },

            { "sTitle": "Average Marks", "mData": null, "bSortable": false, mRender: function (data) { return "<center>" + parseFloat(data.Average).toFixed(2); + "</center>" } },

            { "sTitle": "Standard Deviation", "mData": null, "bSortable": false, mRender: function (data) { return "<center>" + parseFloat(data.SD).toFixed(2); + "</center>" } },

            //{ "sTitle": "A+", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.A_plus_from + ' - ' + data.aData.A_plus_to; } },
            //{ "sTitle": "A", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.A_from + ' - ' + data.aData.A_to; } },
            //{ "sTitle": "A-", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.A_minus_from + ' - ' + data.aData.A_minus_to; } },
            //{ "sTitle": "B+", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.B_plus_from + ' - ' + data.aData.B_plus_to; } },
            //{ "sTitle": "B", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.B_from + ' - ' + data.aData.B_to; } },
            //{ "sTitle": "B-", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.B_minus_from + ' - ' + data.aData.B_minus_to; } },
            //{ "sTitle": "C+", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.C_plus_from + ' - ' + data.aData.C_plus_to; } },
            //{ "sTitle": "C", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.C_from + ' - ' + data.aData.C_to; } },
            //{ "sTitle": "C-", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.C_minus_from + ' - ' + data.aData.C_minus_to; } },
            //{ "sTitle": "D+", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.D_plus_from + ' - ' + data.aData.D_plus_to; } },
            //{ "sTitle": "D", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.D_from + ' - ' + data.aData.D_to; } },
            //{ "sTitle": "D-", "mData": null, "bSortable": false, fnRender: function (data) { return data.aData.D_minus_from + ' - ' + data.aData.D_minus_to; } }

            { "sTitle": "A+", "mData": null, "bSortable": false, "sClass": "cls_A_plus", mRender: function (data) { return data.A_plus_from + ' - ' + data.A_plus_to; } },

            { "sTitle": "A", "mData": null, "bSortable": false, "sClass": "cls_A", mRender: function (data) { return data.A_from + ' - ' + data.A_to; } },

            { "sTitle": "A-", "mData": null, "bSortable": false, "sClass": "cls_A_minus", mRender: function (data) { return data.A_minus_from + ' - ' + data.A_minus_to; } },

            { "sTitle": "B+", "mData": null, "bSortable": false, "sClass": "cls_B_plus", mRender: function (data) { return data.B_plus_from + ' - ' + data.B_plus_to; } },

            { "sTitle": "B", "mData": null, "bSortable": false, "sClass": "cls_B", mRender: function (data) { return data.B_from + ' - ' + data.B_to; } },

            { "sTitle": "B-", "mData": null, "bSortable": false, "sClass": "cls_B_minus", mRender: function (data) { return data.B_minus_from + ' - ' + data.B_minus_to; } },

            { "sTitle": "C+", "mData": null, "bSortable": false, "sClass": "cls_C_plus", mRender: function (data) { return data.C_plus_from + ' - ' + data.C_plus_to; } },

            { "sTitle": "C", "mData": null, "bSortable": false, "sClass": "cls_C", mRender: function (data) { return data.C_from + ' - ' + data.C_to; } },

            { "sTitle": "C-", "mData": null, "bSortable": false, "sClass": "cls_C_minus", mRender: function (data) { return data.C_minus_from + ' - ' + data.C_minus_to; } },

            { "sTitle": "D+", "mData": null, "bSortable": false, "sClass": "cls_D_plus", mRender: function (data) { return data.D_plus_from + ' - ' + data.D_plus_to; } },

            { "sTitle": "D", "mData": null, "bSortable": false, "sClass": "cls_D", mRender: function (data) { return data.D_from + ' - ' + data.D_to; } },

            { "sTitle": "D-", "mData": null, "bSortable": false, "sClass": "cls_D_minus", mRender: function (data) { return data.D_minus_from + ' - ' + data.D_minus_to; } },

            {
                "sTitle": "Submitted", "mData": null, "bSortable": false, "sClass": "", mRender: function (data) {
                    if (data.grade_submitted == "Y") {
                        return "<center>Yes</center>";
                    } else {
                        return "<center>No</center>";
                    }
                }
            },

            { "sTitle": "Submission Date-Time", "mData": null, "bSortable": false, "sClass": "sub_date", mRender: function (data) { return "<center>" + data.grade_submitted_date_time + "</center>"; } }

            //{ "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //    //alert(course_code);
            //    return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
            //}
            //}

            //{ "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //    //alert(course_code);
            //    return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
            //}
            //}
        ]
    });

    $(".cls_hover").hover(
        function () {
            $(this).next()[0].style.display = "block";
        }, function () {
            $(this).next()[0].style.display = "none";
        }
    );

    $('.chk_selection_all_course_code').change(function () {
        if (this.checked) {
            $("input:checkbox.chk_selection_course_code").prop('checked', this.checked);
        } else {
            $("input:checkbox.chk_selection_course_code").prop('checked', false);
        }
    });

    $('.chk_selection_course_code').change(function () {
        if (this.checked) {
            //
        } else {
            $("input:checkbox.chk_selection_all_course_code").prop('checked', false);
        }
    });

    absolute_range = data['absolute_grade_range'][0];
    for (var i = 0; i < $('#example tbody tr').length; i++) {
        var temp_tr = $('#example tbody tr:nth-child(' + (i + 1) + ')');

        temp_tr.find('.cls_grade_type').val(temp_tr.find('.cls_hdn_grade_type').val());

        if (temp_tr.find('.cls_hdn_grade_type').val() == 'A') {
            temp_tr.find('.cls_A_plus').html(absolute_range.A_plus_from + ' - ' + absolute_range.A_plus_to);
            temp_tr.find('.cls_A').html(absolute_range.A_from + ' - ' + absolute_range.A_to);
            temp_tr.find('.cls_A_minus').html(absolute_range.A_minus_from + ' - ' + absolute_range.A_minus_to);
            temp_tr.find('.cls_B_plus').html(absolute_range.B_plus_from + ' - ' + absolute_range.B_plus_to);
            temp_tr.find('.cls_B').html(absolute_range.B_from + ' - ' + absolute_range.B_to);
            temp_tr.find('.cls_B_minus').html(absolute_range.B_minus_from + ' - ' + absolute_range.B_minus_to);
            temp_tr.find('.cls_C_plus').html(absolute_range.C_plus_from + ' - ' + absolute_range.C_plus_to);
            temp_tr.find('.cls_C').html(absolute_range.C_from + ' - ' + absolute_range.C_to);
            temp_tr.find('.cls_C_minus').html(absolute_range.C_minus_from + ' - ' + absolute_range.C_minus_to);
            temp_tr.find('.cls_D_plus').html(absolute_range.D_plus_from + ' - ' + absolute_range.D_plus_to);
            temp_tr.find('.cls_D').html(absolute_range.D_from + ' - ' + absolute_range.D_to);
            temp_tr.find('.cls_D_minus').html(absolute_range.D_minus_from + ' - ' + absolute_range.D_minus_to);
        }
    }

    $('#DataList').css('display', 'block');
}

$(document).on('change', '.cls_grade_type', function () {
    var temp_tr = $(this).closest('tr');

    if ($(this).val() == 'R') {
        var row_data = oTable.fnGetData(temp_tr[0]);

        temp_tr.find('.cls_A_plus').html(row_data.A_plus_to);
        temp_tr.find('.cls_A').html(row_data.A_to);
        temp_tr.find('.cls_A_minus').html(row_data.A_minus_to);
        temp_tr.find('.cls_B_plus').html(row_data.B_plus_to);
        temp_tr.find('.cls_B').html(row_data.B_to);
        temp_tr.find('.cls_B_minus').html(row_data.B_minus_to);
        temp_tr.find('.cls_C_plus').html(row_data.C_plus_to);
        temp_tr.find('.cls_C').html(row_data.C_to);
        temp_tr.find('.cls_C_minus').html(row_data.C_minus_to);
        temp_tr.find('.cls_D_plus').html(row_data.D_plus_to);
        temp_tr.find('.cls_D').html(row_data.D_to);
        temp_tr.find('.cls_D_minus').html(row_data.D_minus_to);
    }
    else {
        temp_tr.find('.cls_A_plus').html(absolute_range.A_plus_from + ' - ' + absolute_range.A_plus_to);
        temp_tr.find('.cls_A').html(absolute_range.A_from + ' - ' + absolute_range.A_to);
        temp_tr.find('.cls_A_minus').html(absolute_range.A_minus_from + ' - ' + absolute_range.A_minus_to);
        temp_tr.find('.cls_B_plus').html(absolute_range.B_plus_from + ' - ' + absolute_range.B_plus_to);
        temp_tr.find('.cls_B').html(absolute_range.B_from + ' - ' + absolute_range.B_to);
        temp_tr.find('.cls_B_minus').html(absolute_range.B_minus_from + ' - ' + absolute_range.B_minus_to);
        temp_tr.find('.cls_C_plus').html(absolute_range.C_plus_from + ' - ' + absolute_range.C_plus_to);
        temp_tr.find('.cls_C').html(absolute_range.C_from + ' - ' + absolute_range.C_to);
        temp_tr.find('.cls_C_minus').html(absolute_range.C_minus_from + ' - ' + absolute_range.C_minus_to);
        temp_tr.find('.cls_D_plus').html(absolute_range.D_plus_from + ' - ' + absolute_range.D_plus_to);
        temp_tr.find('.cls_D').html(absolute_range.D_from + ' - ' + absolute_range.D_to);
        temp_tr.find('.cls_D_minus').html(absolute_range.D_minus_from + ' - ' + absolute_range.D_minus_to);
    }
});