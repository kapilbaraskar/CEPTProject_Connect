var oTable;
var course_detail;
var rate_band;
var obj_rate_band;
var workload_detail;
var action = 'S';


$(document).ready(function () {

    bindsemdata();
    bindyeardata_for_cross_reg();
    bindprogramme();
    bindproglevel();

    get_rate_band();

    $('#btnreterive').on('click', function () {
        get_vf_rate_band_detail();
        return false;
    });

    setCurrentSemester();
});


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

function setCurrentSemester() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_cept_current_sem_data",
        //async: false,
        data: "{type:'course'}",
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

function bindprogramme() {

    if ($('#hdnusertype').val() == 'FA') {

        $('.cls_dept_prog').css('display', 'none');

        $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);

                            $('#drpprog').empty();

                            for (var i = 0; i < user_data.length; i++) {

                                if (user_data[i]['prog_code'] == "1") {
                                    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "2") {
                                    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "3") {
                                    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                }
                            }

                        }
                        else {
                            $('#drpprog').val('1');
                            $("#drpprog").attr('disabled', 'disabled');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
    }
    else {

        $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

        if ($("#hdnusertype").val() != 'PC' && $("#hdnusertype").val() != 'FA') {
            $('#drpprog').chosen();
        }
    }
}

function bindproglevel() {

    //    $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
    //    $('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
    //    $('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_program_level_data_rights_wise",
        data: "{}",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var prog_level_data = JSON.parse(data.d)

                $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                for (var i = 0; i < prog_level_data.length; i++) {
                    $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                }

                // if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                $('#drpproglevel').chosen();
                //  }

            }
        },
        error: function (result) {
            alert(result);
        }
    });

}


function get_rate_band() {
    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_rate_band",
        //async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {
                obj_rate_band = JSON.parse(data.d);
                rate_band = '';
                for (var i = 0; i < obj_rate_band.length; i++) {
                    rate_band = rate_band + "<option>" + obj_rate_band[i]['rate_band'] + "</option>";
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function rowClick(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //alert("ID : " + rowId);
    window.location = "vf_edit_personal_detail.aspx?ic=" + rowId;
}

var semester = '';
var year_code = '';
var prog_code = '';
var prog_level_code = '';

function get_vf_rate_band_detail() {
    $('#DataList').css('display', 'none');
    $('#div_btn').html('');
    $('#submitBtnDiv').css('display', 'none');

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

    prog_code = $('#drpprog').val();
    prog_level_code = $('#drpproglevel').val();

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        //url: "../../WebService.asmx/get_vf_rate_band_detail",
        url: "../../WebService.asmx/get_vf_rate_band_for_edit_rate",
        //async: false,
        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {

                workload_detail = JSON.parse(data.d);
            
                display_get_vf_personal_detail(data.d);

                $('#div_course_list').css('display', 'block');
            }
            else {
                bootbox.alert('No data Found For Selected Semester and Year');
                if ($('#hdnusertype').val() != 'PC') {
                    $('#div_course_list').css('display', 'none');
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function checkedChange() {
//    if (document.activeElement.checked) {
//        var parent = document.activeElement.parentElement.parentElement;
//        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();' checked='checked'/></center>" +
//                                    "<center><select class='cls_drp_rate_band' style='width:65px;margin-top:2px;'>" + rate_band + "</select></center>" +
//                                    "<center><input type='text' value='' class='inline_input' style='width:70px;margin-top:2px;'/></center>";

//        parent.innerHTML = str;
//    }

    if (document.activeElement.checked) {
        var parent = document.activeElement.parentElement.parentElement;
        var row_rate_band = document.activeElement.parentElement.parentElement.previousSibling.innerHTML;
        var index = -1;
        var str_rate_band = '';

//        if (row_rate_band != '') {
//            for (var i = 0; i < obj_rate_band.length; i++) {
//                if (row_rate_band == obj_rate_band[i]['rate_band']) index = i;
//                if (index != -1 && i <= (index + 4)) str_rate_band = str_rate_band + '<option>' + obj_rate_band[i]['rate_band'] + '</option>';
//            }
//        }
//        else str_rate_band = rate_band;

//        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();' checked='checked'/></center>" +
//                                    "<center><select class='cls_drp_rate_band' style='width:65px;margin-top:2px;'>" + str_rate_band + "</select></center>" +
        //                                    "<center><input type='text' value='' class='inline_input' style='width:70px;margin-top:2px;'/></center>";

        str_rate_band = rate_band;

        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();' checked='checked'/></center>";
        parent.innerHTML = str;

        str = "<center><select class='cls_drp_rate_band' style='width:65px;margin-top:2px;'>" + str_rate_band + "</select></center>";
        parent.nextSibling.innerHTML = str;

        str = "<center><input type='text' value='' class='inline_input' style='width:200px;margin-top:2px;'/></center>";
        parent.nextSibling.nextSibling.innerHTML = str;
    }
    else {
        var parent = document.activeElement.parentElement.parentElement;
        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";

        parent.innerHTML = str;
        parent.nextSibling.innerHTML = "";
        parent.nextSibling.nextSibling.innerHTML = "";
    }
}

function set_table_columns(row) {
    var columns = [];
    for (var attr in row) {
        columns.push({ "sTitle": attr, "mData": attr });
    }

    var edit_column = { "sTitle": "Edit", "mData": null, "bSortable": false, fnRender: function (data) {
        if (data.aData.admin_approved != 'Approved') return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
        else return '';
    } 
    };

    columns.push(edit_column);

    return columns;
}

function display_get_vf_personal_detail(data) {

    //var columns = set_table_columns(JSON.parse(data)[0]);

    var columns = [{ "sTitle": "Instructor Code", "mData": "instructor_code" },
                    { "sTitle": "VF Code", "mData": "VF_code" },
                    { "sTitle": "Instructor Name", "mData": "instructor_name" },
    //{ "sTitle": "Designation", "mData": "designation" },
                    {"sTitle": "Grade", "mData": null, "bSortable": false, "fnRender": function (data) {
                        if (data.aData.rate_wise_designation != '')
                            return data.aData.rate_wise_designation;
                        else
                            return data.aData.designation;
                    }
                },
                    { "sTitle": "Total Experience", "mData": "total_experiance" },
                    { "sTitle": "Highest Qualification", "mData": "highest_qualification" },
                    { "sTitle": "Calculated Rate Band", "mData": "rate_band" },
                    { "sTitle": "Change Band", "mData": null, "bSortable": false, fnRender: function (data) {
                        //                        var index = -1;
                        //                        var str_rate_band = '';
                        //                        if (data.aData.rate_band != '' && data.aData.alternate_band != '') {
                        //                            for (var i = 0; i < obj_rate_band.length; i++) {
                        //                                if (data.aData.rate_band == obj_rate_band[i]['rate_band']) index = i;
                        //                                if (index != -1 && i <= (index + 2)) str_rate_band = str_rate_band + '<option>' + obj_rate_band[i]['rate_band'] + '</option>';
                        //                            }
                        //                        }
                        //                        else str_rate_band = rate_band;

                        if (data.aData.alternate_band != '') {
                            return "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();' checked='checked'/></center>";
                            //"<center><select class='cls_drp_rate_band' style='width:65px;margin-top:2px;'>" + str_rate_band + "</select></center>" +
                            //"<center><input type='text' value='' class='inline_input' style='width:70px;margin-top:2px;'/></center>";
                        }
                        else return "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";
                    }
                    },
                    { "sTitle": "Alternate Band", "mData": null, "bSortable": false, fnRender: function (data) {
                        var index = -1;
                        var str_rate_band = '';
//                        if (data.aData.rate_band != '' && data.aData.alternate_band != '') {
//                            for (var i = 0; i < obj_rate_band.length; i++) {
//                                if (data.aData.rate_band == obj_rate_band[i]['rate_band']) index = i;
//                                if (index != -1 && i <= (index + 4)) str_rate_band = str_rate_band + '<option>' + obj_rate_band[i]['rate_band'] + '</option>';
//                            }
//                        }
                        //                        else str_rate_band = rate_band;

                        str_rate_band = rate_band;

                        if (data.aData.alternate_band != '') {
                            return "<center><select class='cls_drp_rate_band' style='width:65px;margin-top:2px;'>" + str_rate_band + "</select></center>";
                        }
                        else return "";
                    }
                    },
                    { "sTitle": "Justification", "mData": null, "bSortable": false, fnRender: function (data) {
                        if (data.aData.alternate_band != '') {
                            return "<center><input type='text' value='' class='inline_input' style='width:200px;margin-top:2px;'/></center>";
                        }
                        else return "";
                    }
                    }
                    ];

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

        "aaData": JSON.parse(data),

        "aoColumns": columns

    });

    if ($('#hdnusertype').val() == 'FA') {
        //var str = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                    //"<i class='icon-save bigger-160'></i>Save</button></td></tr></table>";

        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                  "<i class='icon-save bigger-160'></i>Save</button></td> " +
                  "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                  "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";

        $('#submitBtnDiv').html(str);
    }


    $('#btnapprove').on('click', function () {

        action = 'A';

        $('#btnsave').click();
    });

    $('#btnsave').on('click', function () {

        var All_instructor_workload_data = [];
        var is_rateband_blank = false;
        var is_justification_blank = false;

        $("#example tbody tr").each(function (i) {
            var instructor_workload_data = { 'instructor_code': '', 'alternate_band': '', 'justification': '' };

            instructor_workload_data.instructor_code = $(this).children()[0].innerHTML;

//            if ($(this).children().eq(6)[0].children[0].children[0].checked) {
//                
//                instructor_workload_data.alternate_band = $(this).children().eq(7)[0].children[0].children[0].value;
//                instructor_workload_data.justification = $(this).children().eq(8)[0].children[0].children[0].value;

//                if ($(this).children().eq(7)[0].children[0].children[0].value == '') is_rateband_blank = true;
//                if ($(this).children().eq(8)[0].children[0].children[0].value == '') is_justification_blank = true;
//            }
//            else {
//                if ($(this).children()[5].innerHTML == '') is_rateband_blank = true;
            //            }

            if ($(this).children().eq(7)[0].children[0].children[0].checked) {

                instructor_workload_data.alternate_band = $(this).children().eq(8)[0].children[0].children[0].value;
                instructor_workload_data.justification = $(this).children().eq(9)[0].children[0].children[0].value;

                if ($(this).children().eq(8)[0].children[0].children[0].value == '') is_rateband_blank = true;
                if ($(this).children().eq(9)[0].children[0].children[0].value == '') is_justification_blank = true;
            }
            else {
                if ($(this).children()[6].innerHTML == '') is_rateband_blank = true;
            }

            All_instructor_workload_data.push(instructor_workload_data);
        });

        if (is_rateband_blank && action == 'A') {
            bootbox.alert('Please Enter Rateband');
            action = 'S';
            return false;
        }

        if (is_justification_blank && action == 'A') {
            bootbox.alert('Please Enter Justification');
            action = 'S';
            return false;
        }

        var All_instructor_data = [All_instructor_workload_data, action];
        var json_All_instructor_data = JSON.stringify(All_instructor_data);

        if (json_All_instructor_data.search("'") != -1) {
            json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_vf_rate_band_detail",
            async: false,
            data: "{ All_table_course_data: '" + json_All_instructor_data + "' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Data Saved Successfully') {
                    if (action == 'A') {
                        bootbox.alert('Data Submitted Successfully', function () {
                            window.location = "VF_personal_detail.aspx";
                        });
                    }
                    else {
                        bootbox.alert(data.d, function () {
                            //location.reload();
                            $('#btnreterive').click();
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

    });
    
    var cnt = 0;
    if (workload_detail.length > 0) {
        $("#example tbody tr").each(function (i) {
//            if (workload_detail[i].alternate_band != '') {
//                
//                $(this).children().eq(7)[0].children[0].children[0].value = workload_detail[i].alternate_band;
//                $(this).children().eq(8)[0].children[0].children[0].value = workload_detail[i].justification;

//                if (workload_detail[i].rateband_approved == 'Approved') {
//                    $(this).children().eq(6)[0].children[0].children[0].disabled = true;
//                    
//                    $(this).children().eq(7)[0].children[0].children[0].disabled = true;
//                    $(this).children().eq(8)[0].children[0].children[0].disabled = true;
//                    cnt++;
//                }
//            }
//            else {
//                if (workload_detail[i].rateband_approved == 'Approved') {
//                    $(this).children().eq(6)[0].children[0].children[0].disabled = true;
//                    cnt++;
//                }
            //            }
            if (workload_detail[i].alternate_band != '') {

                $(this).children().eq(8)[0].children[0].children[0].value = workload_detail[i].alternate_band;
                $(this).children().eq(9)[0].children[0].children[0].value = workload_detail[i].justification;

                if (workload_detail[i].rateband_approved == 'Approved') {
                    $(this).children().eq(7)[0].children[0].children[0].disabled = true;

                    $(this).children().eq(8)[0].children[0].children[0].disabled = true;
                    $(this).children().eq(9)[0].children[0].children[0].disabled = true;
                    cnt++;
                }
            }
            else {
                if (workload_detail[i].rateband_approved == 'Approved') {
                    $(this).children().eq(7)[0].children[0].children[0].disabled = true;
                    cnt++;
                }
            }
        });
    }

    $('#DataList').css('display', 'block');
    if (cnt < workload_detail.length) $('#submitBtnDiv').css('display', 'block');
    else $('#submitBtnDiv').css('display', 'none');

    $('#example thead tr')[0].children[0].style.display = 'none';

    $("#example tbody tr").each(function (i) {
        $(this).children().eq(0)[0].style.display = 'none';
    });
}
