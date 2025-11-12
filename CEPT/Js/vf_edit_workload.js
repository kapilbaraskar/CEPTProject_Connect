var oTable;
var course_detail;
var rate_band;
var workload_detail;
var action = 'S';

function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 46) {
        if (e.currentTarget.value == '') {
            e.currentTarget.value = '0';
        }
        else if (e.currentTarget.value.indexOf('.') != -1) {
            return false;
        }
    }

    if (keyCode == 8 || keyCode == 46 || keyCode == 9) {
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

function IsNumeric2(e) {
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 46) {
        return false;
    }

    if (keyCode == 8 || keyCode == 46 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {
        return true;
    }
    else {
        return false;
    }
}

$(document).ready(function () {

    get_rate_band();

    //changes RateBand 02102021
    get_vf_additional_rates();

    get_vf_course_wise_workload_detail();

    if ($('#hdnusertype').val() == 'FA') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }
    else if ($('#hdnusertype').val() == 'A1') {
        var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: none' class='btn btn-primary'>" +
            "<i class='icon-save bigger-160'></i>Save</button></td> " +
            "<td align='left' style='padding-left:400px;'><button id='btnupdate' type='button' style='display: block' class='btn btn-primary'> " +
            "<i class='icon-save bigger-160'></i>Update</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }


    $('#btnapprove').on('click', function () {

        action = 'A';

        $('#btnsave').click();
    });
    $('#btnupdate').on('click', function () {

        action = 'A';

        $('#btnsave').click();
    });


    $('#btnsave').on('click', function () {

        if ($('#hdn_ccode').val() == '') {
            bootbox.alert('No Course to update');
            action = 'S';
            return false;
        }

        var All_instructor_workload_data = [];
        var inst_code = "";
        var avg_contact_hrs = 0;
        var flag = true;
        if ($('.cls_chk_change_band_data:checked').length === 0)
        {
            bootbox.alert('Are you sure you want to save data? Please check the checkbox.');
            return false;
        } 

        $("#example tbody tr").each(function (i)
        {
            

            var checkbox = $(this).find('.cls_chk_change_band_data');
            if (checkbox.prop('checked')) {

                inst_code = $(this).children()[0].innerHTML;
                var weeks = $(this).children().eq(4)[0].children[0].children[0].value;
                var hours = $(this).children().eq(5)[0].children[0].children[0].value;
                if (weeks == "") {
                    alert("Please Enter Weeks");
                    flag = false;
                }
                if (hours == "") {
                    alert("Please Enter Hours");
                    flag = false;
                }
                if (All_instructor_workload_data.length > 0 && All_instructor_workload_data[All_instructor_workload_data.length - 1]['instructor_code'] == inst_code) {
                    var temp_total_weeks = All_instructor_workload_data[All_instructor_workload_data.length - 1]['total_weeks'];

                    All_instructor_workload_data[All_instructor_workload_data.length - 1]['total_weeks'] = parseFloat(temp_total_weeks) + parseInt(weeks);

                    All_instructor_workload_data[All_instructor_workload_data.length - 1]['total_hrs_in_semester'] = parseFloat(All_instructor_workload_data[All_instructor_workload_data.length - 1]['total_hrs_in_semester']) + (parseFloat(weeks) * parseFloat(hours));

                    All_instructor_workload_data[All_instructor_workload_data.length - 1]['hours_bifurcation'].push({ 'weeks': weeks, 'contact_hrs': hours });

                }
                else {
                    var instructor_workload_data = { 'instructor_code': '', 'course_code': '', 'total_weeks': '', 'total_contact_hrs': '', 'total_preparation_hrs': '', 'total_hrs': '', 'total_hrs_in_semester': '', 'total_exp': '', 'rate_band': '', 'alternate_band': '', 'justification': '', 'semester_type': '', 'year_semester': '', 'is_tutorial': '', 'hours_bifurcation': [] };
                    avg_contact_hrs = 0;

                    instructor_workload_data.instructor_code = $(this).children()[0].innerHTML;
                    instructor_workload_data.course_code = course;

                    //changes this set 

                    instructor_workload_data.total_weeks = $(this).children().eq(4)[0].children[0].children[0].value;
                    instructor_workload_data.total_contact_hrs = $(this).children().eq(5)[0].children[0].children[0].value;
                    instructor_workload_data.total_preparation_hrs = $(this).children()[6].innerHTML;
                    instructor_workload_data.total_hrs = $(this).children()[7].innerHTML;
                    instructor_workload_data.total_hrs_in_semester = $(this).children()[8].innerHTML;
                    instructor_workload_data.total_exp = $(this).children()[9].innerHTML;
                    instructor_workload_data.rate_band = $(this).children()[11].innerHTML;
                    instructor_workload_data.alternate_band = $(this).find('.cls_alternate_band')[0].value;
                    instructor_workload_data.justification = $(this).find('.cls_justification')[0].value;
                    instructor_workload_data.is_tutorial = $(this).find('.cls_tutorial')[0].innerHTML;

                    instructor_workload_data.additional_hours = $(this).children().eq(15)[0].children[0].children[0].value;

                    //if ($(this).children().eq(11)[0].children[0].children[0].checked) {
                    //    instructor_workload_data.alternate_band = $(this).children().eq(11)[0].children[1].children[0].value;
                    //    instructor_workload_data.justification = $(this).children().eq(11)[0].children[2].children[0].value;
                    //}

                    instructor_workload_data.semester_type = semester;
                    instructor_workload_data.year_semester = year_code;

                    instructor_workload_data.hours_bifurcation.push({ 'weeks': instructor_workload_data.total_weeks, 'contact_hrs': instructor_workload_data.total_contact_hrs });

                    //instructor_workload_data.total_hrs_in_semester = parseFloat(instructor_workload_data.total_weeks) * parseFloat(instructor_workload_data.total_contact_hrs);
                    instructor_workload_data.total_hrs_in_semester = (parseFloat(instructor_workload_data.total_weeks) * parseFloat(instructor_workload_data.total_contact_hrs)).toFixed(0);

                    All_instructor_workload_data.push(instructor_workload_data);
                }

            }
        });

        if (flag != true) {
            return false;
        }

        for (var i = 0; i < All_instructor_workload_data.length; i++) {
            All_instructor_workload_data[i].total_contact_hrs = (All_instructor_workload_data[i].total_hrs_in_semester / parseFloat(All_instructor_workload_data[i].total_weeks)).toFixed(2);
            All_instructor_workload_data[i].total_hrs_in_semester = All_instructor_workload_data[i].total_hrs_in_semester.toString();
            All_instructor_workload_data[i].hours_bifurcation = JSON.stringify(All_instructor_workload_data[i].hours_bifurcation);
            if (All_instructor_workload_data[i].total_preparation_hrs != "") {
                All_instructor_workload_data[i].total_hrs = (parseFloat(All_instructor_workload_data[i].total_preparation_hrs) + parseFloat(All_instructor_workload_data[i].total_contact_hrs)).toFixed(2);
            } else {
                All_instructor_workload_data[i].total_hrs = parseFloat(All_instructor_workload_data[i].total_contact_hrs).toFixed(2);
            }
        }

        //return false;

        var All_instructor_data = [All_instructor_workload_data, action];
        var json_All_instructor_data = JSON.stringify(All_instructor_data);

        if (json_All_instructor_data.search("'") != -1) {
            json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
        }
        if (json_All_instructor_data.search(/\\/) != -1) { json_All_instructor_data = json_All_instructor_data.replace(/\\/g, '\\\\'); }
        if (json_All_instructor_data.search("\"") != -1) { json_All_instructor_data = json_All_instructor_data.replace(/"/g, '\\\"'); }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_vf_course_wise_workload_detail_v2",
            async: false,
            data: "{ All_table_course_data: '" + json_All_instructor_data + "' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Data Saved Successfully') {
                    if (action == 'A') {
                        bootbox.alert('WorkLoad Updated Successfully', function () {
                            window.location = "vf_work_load_mgmt.aspx";
                        });
                    }
                    else {
                        bootbox.alert(data.d, function () {
                            location.reload();
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

    

});

function updatedata(data)
{
    var currentRow = $(data).closest('tr');  
    var row_data = oTable.fnGetData(currentRow[0]);  

    if ($('#total_week_' + row_data.instructor_code).val() == '')
    {
        bootbox.alert("Please Enter Total Week");
        return false;
    }
    if ($('#total_contact_hrs_' + row_data.instructor_code).val() == '')
    {
        bootbox.alert("Please Enter Total Contact Hrs");
        return false;
    }
   

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/SaveRateBandOnlyTAUser",
        async: false,
        data: "{ total_weeks: '" + $('#total_week_' + row_data.instructor_code).val() + "',total_contact_hrs: '" + $('#total_contact_hrs_' + row_data.instructor_code).val() + "',justification: '" + $('#justification_' + row_data.instructor_code).val() + "',additional_hours: '" + $('#additional_hours_' + row_data.instructor_code).val() + "',course_code: '" + $('#hdn_ccode').val() + "',sem_code: '" + semester + "', year_code: '" + year_code + "', inst_code: '" + row_data.instructor_code + "' }",
        dataType: "json",
        success: function (data) {

            if (data.d == 'You Cannot Exceed 40 Contact Hours Of Tutor. If you need to go above this limit, please contact the UG/PG office.') {
                bootbox.alert('You Cannot Exceed 40 Contact Hours Of Tutor. If you need to go above this limit, please contact the UG/PG office.');
                return false;

            }
            else if (data.d == "true") {
                bootbox.alert('Data Saved Successfully');
                return false;
            }
            else
            {
                bootbox.alert('Data Not Correct please contact the UG/PG office.');
                return false;
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
                    var obj_rate_band = JSON.parse(data.d);
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

var obj_additional_rates = [];
function get_vf_additional_rates() {

    semester = $('#hdn_scode').val();
    if (semester == "") {
        bootbox.alert('Please select semester');
        $('#drpsemester').focus();
        return false;
    }

    year_code = $('#hdn_ycode').val();
    if (year_code == "") {
        bootbox.alert('Please select Year');
        $('#drpyear').focus();
        return false;
    }
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_vf_additional_rates",
            async: false,
            data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    obj_additional_rates = JSON.parse(data.d);
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}

var course = '';
var semester = '';
var year_code = '';
function get_vf_course_wise_workload_detail() {
    $('#DataList').css('display', 'none');
    $('#div_btn').html('');
    var url_sem_wise = '';
    var data_sem_wise = '';
    course = $('#hdn_ccode').val();
    if (course == "") {
        bootbox.alert('No Course Found to Edit Workload');
        return false;
    }

    semester = $('#hdn_scode').val();
    if (semester == "") {
        bootbox.alert('Please select semester');
        $('#drpsemester').focus();
        return false;
    }

    year_code = $('#hdn_ycode').val();
    if (year_code == "") {
        bootbox.alert('Please select Year');
        $('#drpyear').focus();
        return false;
    }
    
    if ($('#hdn_scode').val() == 'M' && $('#hdn_ycode').val() == '2022') {
        //url_sem_wise = "../../WebService.asmx/get_vf_course_wise_workload_detail_v2";
        url_sem_wise = "../../WebService.asmx/get_rateband_dtl_course_wise";
        data_sem_wise = "{course_code:'" + course + "',sem_code:'" + semester + "',year_code:'" + year_code + "',cancel_flag:'N'}";
    }
    else if (parseInt($('#hdn_ycode').val()) > 2022) {
        //url_sem_wise = "../../WebService.asmx/get_vf_course_wise_workload_detail_v2";
        url_sem_wise = "../../WebService.asmx/get_rateband_dtl_course_wise";
        data_sem_wise = "{course_code:'" + course + "',sem_code:'" + semester + "',year_code:'" + year_code + "',cancel_flag:'N'}";
    }
    else
    {
        url_sem_wise = "../../WebService.asmx/get_vf_course_wise_workload_detail";
        data_sem_wise = "{course_code:'" + course + "',sem_code:'" + semester + "',year_code:'" + year_code + "'}";
    }

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: url_sem_wise,
            //async: false,
            data: data_sem_wise,
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {

                    course_detail = JSON.parse(data.d)[0];
                    workload_detail = JSON.parse(data.d);

                    display_get_vf_course_wise_workload_detail(data.d);

                    $('#div_course_list').css('display', 'block');

                    setDataTableHeaderFooter('example');
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

function set_table_columns(row) {
    var columns = [];

    for (var attr in row) {
        columns.push({ "sTitle": attr, "mData": attr });
    }

    columns[4] = {
        "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false, mRender: function (ddata) {
            return "<center><input type='text' value='" + ddata + "' class='inline_input' style='width:40px;' onkeypress='return IsNumeric(event);'/></center>";
        }
    };

    columns[5] = {
        "sTitle": "Total Contact Hrs", "mData": "total_contact_hrs", "bSortable": false, mRender: function (ddata) {
            return "<center><input type='text' value='" + parseFloat(ddata).toFixed(2) + "' class='inline_input' style='width:40px;' onkeypress='return IsNumeric(event);'/></center>";
        }
    };

    return columns;
}

function inputChange(value) {
    
    $('#example tbody tr').each(function () {
        var total_weeks = this.children[4].children[0].children[0].value;
        var total_contact_hrs = this.children[5].children[0].children[0].value;
        if (total_contact_hrs != '' && course_detail['prep_hr_per_week'] != "")
            this.children[6].innerHTML = parseFloat(course_detail['prep_hr_per_week']) * parseFloat(total_contact_hrs);
        else
            this.children[6].innerHTML = '';

        if (total_contact_hrs != '' && this.children[6].innerHTML != '')
            this.children[7].innerHTML = parseFloat(total_contact_hrs) + parseFloat(this.children[6].innerHTML);
        else if (total_contact_hrs != '')
            this.children[7].innerHTML = total_contact_hrs;
        else if (this.children[6].innerHTML != '')
            this.children[7].innerHTML = this.children[6].innerHTML;
        else
            this.children[7].innerHTML = '';

        if (total_weeks != '' && this.children[7].innerHTML != '')
            //this.children[8].innerHTML = parseFloat(total_weeks) * parseFloat(this.children[7].innerHTML);
            //this.children[8].innerHTML = parseFloat(total_weeks) * parseFloat(total_contact_hrs);
            this.children[8].innerHTML = (parseFloat(total_weeks) * parseFloat(total_contact_hrs)).toFixed(0);
        else
            this.children[8].innerHTML = '';
    });
}

function checkedChange() {
    var active_element = document.activeElement;
    var parent_tr = document.activeElement.parentElement.parentElement.parentElement;
    if (document.activeElement.checked) {
        bootbox.confirm("Are you sure you want to change Workload Detail?", function (result) {
            if (result) {
                //parent_tr.children[3].children[0].children[0].disabled = false;
                //parent_tr.children[4].children[0].children[0].disabled = false;

                parent_tr.children[4].children[0].children[0].disabled = false;
                parent_tr.children[5].children[0].children[0].disabled = false;
                parent_tr.getElementsByClassName('cls_alternate_band')[0].disabled = false;
                parent_tr.getElementsByClassName('cls_justification')[0].disabled = false;
            }
            else active_element.checked = false;
        });
    }
    else {
        //parent_tr.children[3].children[0].children[0].disabled = true;
        //parent_tr.children[4].children[0].children[0].disabled = true;

        parent_tr.children[4].children[0].children[0].disabled = true;
        parent_tr.children[5].children[0].children[0].disabled = true;
        parent_tr.getElementsByClassName('cls_alternate_band')[0].disabled = true;
        parent_tr.getElementsByClassName('cls_justification')[0].disabled = true;
    }
}




function display_get_vf_course_wise_workload_detail(data) {

    var columns = [

        

    { "sTitle": "Instructor Code", "mData": "instructor_code" },
    { "sTitle": "Code", "mData": "VF_code" },
    //{ "sTitle": "Instructor Name", "mData": "instructor_name" },
    {
        "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false, fnRender: function (ddata) {
            if (ddata.aData.is_tutorial == 'Y') return ddata.aData.instructor_name + ' (T)';
            else return ddata.aData.instructor_name;
        }
    },
    //{ "sTitle": "Designation", "mData": "designation" },
    { "sTitle": "Grade", "mData": "designation" },
    {
        "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false, fnRender: function (ddata) {
            return "<center><input type='text' id='total_week_" + ddata.aData.instructor_code + "' value='" + ddata.aData.total_weeks + "' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'/></center>";
        }
    },
    {
        "sTitle": "Total Contact Hrs / Week", "mData": "total_contact_hrs", "bSortable": false, fnRender: function (ddata) {
            if (ddata != '')
                return "<center><input type='text' id='total_contact_hrs_" + ddata.aData.instructor_code + "' value='" + parseFloat(ddata.aData.total_contact_hrs).toFixed(2) + "' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'/></center>";
            else
                return "<center><input type='text' value='' id='total_contact_hrs_" + ddata.aData.instructor_code + "' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'/></center>";
        }
    },
    {
        "sTitle": "Total Preparation Hrs / Week", "mData": "total_preparation_hrs", "bSortable": false, "sClass": "cls_hide", mRender: function (ddata) {
            //(67.4897586206897).toFixed(2)
            if (ddata != '')
                return parseFloat(ddata).toFixed(2);
            else
                return '';
        }
    },
    {
        "sTitle": "Total Hrs / Week", "mData": "total_hrs", "bSortable": false, "sClass": "cls_hide", mRender: function (ddata) {
            //(67.4897586206897).toFixed(2)
            if (ddata != '')
                return parseFloat(ddata).toFixed(2);
            else
                return '';
        }
    },
    { "sTitle": "Total Hrs in Semester", "mData": "total_hrs_in_semester" },
    { "sTitle": "Total Experience", "mData": "total_experiance" },
        { "sTitle": "Highest Qualification", "mData": "highest_qualification" },
    { "sTitle": "Rate Band", "mData": "rate_band" },

    //{ "sTitle": "Rate Band", "mData": "calculated_rate_band" }

    //{"sTitle": "Alternate Band", "mData": "alternate_band", "bSortable": false, mRender: function (ddata) {
    //    if (ddata != '')
    //        return "<center><input type='text' value='" + parseFloat(ddata) + "' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);'/></center>";
    //    else
    //        return "<center><input type='text' value='' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);'/></center>";
    //}
    //},
    {
        "sTitle": "Alternate Band", "mData": "upper_rate_band", "sClass": "cls_hide", "bSortable": false, fnRender: function (ddata) {
            
            //if (ddata != '')
            //    return "<center><select class='inline_input cls_alternate_band' style='width:70px;'><option value=''>--</option>" +
            //                "<option value='" + parseFloat(ddata) + "'>" + parseFloat(ddata) + "</option></select></center>";
            //else
            //    return "<center><select class='inline_input cls_alternate_band' style='width:70px;'><option value=''>--</option></select></center>";


            var str_option = "<center><select class='inline_input cls_alternate_band' style='width:70px;'><option value=''>--</option>";

            if (ddata.aData.upper_rate_band != '')
                str_option += "<option value='" + parseFloat(ddata.aData.upper_rate_band) + "'>" + parseFloat(ddata.aData.upper_rate_band) + "</option>";

            var other_rates = $.grep(obj_additional_rates, function (d) {
                return d.degree == ddata.aData.highest_qualification && d.from_experiance <= parseInt(ddata.aData.total_experiance) && parseInt(ddata.aData.total_experiance) <= d.to_experiance && d.typology_sub_group == ddata.aData.sub_group && d.designation == ddata.aData.designation + '2';
            });

            for (var i = 0; i < other_rates.length; i++) {
                str_option += "<option value='" + parseFloat(other_rates[i]['rate_band']) + "'>" + parseFloat(other_rates[i]['rate_band']) + "</option>";
            }

            str_option += "</select></center>";

            return str_option;
        }
    },
    {
        "sTitle": "Justification", "mData": "justification", "bSortable": false, fnRender: function (ddata) {
            if (ddata.aData.justification != '')
                return "<center><input type='text' id='justification_" + ddata.aData.instructor_code + "' value='" + ddata.aData.justification + "' class='inline_input cls_justification' style='width:100px;' /></center>";
            else
                return "<center><input type='text' id='justification_" + ddata.aData.instructor_code + "' value='' class='inline_input cls_justification' style='width:100px;' /></center>";
        }
    },
    {
        //"sTitle": "Change Workload", "mData": "admin_approved", "bSortable": false, mRender: function (ddata) {
        "sTitle": "Change Workload", "mData": "admin_approved", "bSortable": false, fnRender: function (ddata) {

            if (ddata.aData.acceptance == 'N') {
                if ($('#hdnusertype').val() == 'FA' && ddata.aData.designation == 'TA') {
                    return "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";
                }
                else if (ddata.aData.admin_approved != 'Approved' && $('#hdnusertype').val() != 'A1') {
                    return "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";
                }
                else if ($('#hdnusertype').val() == 'A1') {
                    return "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";
                }
                else {
                    return "";
                }
            }
            else
            {
                return "After your acceptance, the rate band cannot be modified.";
            }
            
        }
    },
    {
        "sTitle": "Additional Hours", "mData": "additional_hours", "bSortable": false, fnRender: function (ddata) {//extra_hours
            return "<center><input type='text' id='additional_hours_" + ddata.aData.instructor_code + "' value='" + ddata.aData.additional_hours + "' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'/></center>";
        }
    },
    //{
    //    "sTitle": "Add Workload", "mData": "admin_approved", "bSortable": false, mRender: function (ddata) {
    //        if (ddata != 'Approved') {
    //            //return "<button type='button' onclick='addRow(this)'>Add</button>";
    //            return "<input type='button' value='Add' class='addRows' />";
    //        }
    //        else return "";
    //    }
    //},
        {
            "sTitle": "Select CheckBox", "mData": "admin_approved", "bSortable": false, mRender: function (ddata)
            {
                if (ddata != 'Approved' && $('#hdnusertype').val() != 'A1')
                {
                    return "<center><input type='checkbox' class='cls_chk_change_band_data' onchange='return checkedselect();'/></center>";
                }
                else if ($('#hdnusertype').val() == 'A1')
                {
                    return "<center><input type='checkbox' class='cls_chk_change_band_data' onchange='return checkedselect();'/></center>";
                }
                else
                {
                    return "";
                }
            }
        },
        {
            "sTitle": "Action", "mData": null, "bSortable": false, fnRender: function (ddata) {
                if (ddata.aData.designation == 'TA' && ddata.aData.admin_approved != 'Approved' && $('#hdnusertype').val() == 'FA')
                {
                    return "<button id='" + ddata.aData.instructor_code +"' type='button' onclick=updatedata(this) class='btn btn-primary'>Save</button>";
                }
                else
                {
                    return "";
                }
            }
        },

    { "sTitle": "Is Tutorial", "mData": "is_tutorial", "sClass": "cls_tutorial cls_hide" }
    ];

    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 100,
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

    $('#td_course_code').html(course_detail['course_code']);
    $('#td_course_name').html(course_detail['course_name']);
    $('#td_course_type').html(course_detail['type_name']);
    $('#td_course_credits').html(course_detail['course_credits']);

    approve_cnt = 0;
    var str_tbl_load_dtl_html = '';
    for (var i = 0; i < workload_detail.length; i++) {
        if (workload_detail[i]['admin_approved'] == 'Approved')
        {
            approve_cnt++;
        }
        $('#example tbody tr')[i].children[4].children[0].children[0].disabled = true;
        $('#example tbody tr')[i].children[5].children[0].children[0].disabled = true;
        $('#example tbody tr')[i].getElementsByClassName('cls_alternate_band')[0].disabled = true;
        $('#example tbody tr')[i].getElementsByClassName('cls_justification')[0].disabled = true;
        
        if (workload_detail[i]['alternate_band'].toString() != '') {
            $('#example tbody tr')[i].getElementsByClassName('cls_alternate_band')[0].value = workload_detail[i]['alternate_band'];
        }
        
        if (workload_detail[i]['is_tutorial'] == 'Y') workload_detail[i]['instructor_name'] += ' (T)';
        
        str_tbl_load_dtl_html = str_tbl_load_dtl_html + '<tr><td>' + workload_detail[i]['instructor_name'] + '</td><td>&nbsp;:&nbsp;</td><td>' + workload_detail[i]['percent_load'] + '</td></tr>';
    }

    if (str_tbl_load_dtl_html != '') $('#tbl_load_dtl tbody').html(str_tbl_load_dtl_html);
    else $('#tbl_load_dtl').css('display', 'none');

    if (approve_cnt == workload_detail.length)
    {
        if ($('#hdnusertype').val() != 'A1')
        {
            $('#submitBtnDiv').html('');
        }
        
    }
        

    $('#DataList').css('display', 'block');
    $('#div_course_detail').css('display', 'block');

    $('#example thead tr')[0].children[0].style.display = 'none';

    $("#example tbody tr").each(function (i) {
        $(this).children().eq(0)[0].style.display = 'none';
    });

    $('.cls_alternate_band').on('change', function () {
        if (this.value == '') {
            $(this).closest('tr').find('.cls_justification').val('');
        }
    });

    $(function () {
        $(".addRows").click(function () {
            var row_data = "";
            row_data = "<tr><td style='display:none;'>" + $(this).closest('tr')[0]["childNodes"][0]["innerHTML"] + "</td><td></td><td></td><td></td>";
            row_data += "<td><center><input type='text' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'></center></td>";
            row_data += "<td><center><input type='text' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'></center></td>";
            row_data += "<td class='cls_hide'></td><td class='cls_hide'></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a class='del_row'>Delete</a></td><td class='cls_hide'></td></tr>";
            $(this).closest('tr').after(row_data);
        });
    });

    $("#example tbody tr").each(function (i) {
        if (workload_detail[i]["hours_bifurcation"] != "") {
            h_data = JSON.parse(workload_detail[i]["hours_bifurcation"]);
            for (var j = h_data.length - 1; j >= 0; j--) {
                if (j != 0) {
                    var row_data = "";
                    row_data = "<tr><td style='display:none;'>" + $(this).closest('tr')[0]["childNodes"][0]["innerHTML"] + "</td><td></td><td></td><td></td>";
                    row_data += "<td><center><input type='text' class='inline_input' style='width:30px;' value='" + h_data[j]["weeks"] + "' onchange='return inputChange();' onkeypress='return IsNumeric(event);'></center></td>";
                    row_data += "<td><center><input type='text' class='inline_input' style='width:30px;' value='" + h_data[j]["contact_hrs"] + "' onchange='return inputChange();' onkeypress='return IsNumeric(event);'></center></td>";
                    row_data += "<td class='cls_hide'></td><td class='cls_hide'></td><td>" + h_data[j]["weeks"] * h_data[j]["contact_hrs"] + "</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a class='del_row'>Delete</a></td><td class='cls_hide'></td></tr>";
                    $(this).closest('tr').after(row_data);
                }
                else
                {
                    $(this).closest('tr')[0]["childNodes"][4]["childNodes"][0]["childNodes"][0].value = h_data[j]["weeks"];
                    $(this).closest('tr')[0]["childNodes"][5]["childNodes"][0]["childNodes"][0].value = h_data[j]["contact_hrs"];
                    //$(this).closest('tr')[0]["childNodes"][8].innerHTML = h_data[j]["weeks"] * h_data[j]["contact_hrs"];
                    $(this).closest('tr')[0]["childNodes"][8].innerHTML = (h_data[j]["weeks"] * h_data[j]["contact_hrs"]).toFixed(0);
                }
            }
        }
    });
}


$(".del_row").live('click', function (e) {
    if (confirm('Are you sure you want to delete this workload ?')) {
        $(this).closest('tr').remove();
    } else {
        // Do nothing!
    }
});
