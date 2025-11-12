var oTable;
var course_detail;
var rate_band;
var workload_detail;
var action = 'S';

function IsNumeric(e) {
    //alert(e.which + " : " + e.keyCode);

    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 46) {
        return false;
    }

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

    get_vf_course_wise_workload_detail();

    if ($('#hdnusertype').val() == 'FA') {
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

        if ($('#hdn_ccode').val() == '') {
            bootbox.alert('No Course to update');
            action = 'S';
            return false;
        }

        var All_instructor_workload_data = [];

        $("#example tbody tr").each(function (i) {
            var instructor_workload_data = { 'instructor_code': '', 'course_code': '', 'total_weeks': '', 'total_contact_hrs': '', 'total_preparation_hrs': '', 'total_hrs': '', 'total_hrs_in_semester': '', 'total_exp': '', 'rate_band': '', 'alternate_band': '', 'justification': '', 'semester_type': '', 'year_semester': '', 'is_tutorial': '' };

            instructor_workload_data.instructor_code = $(this).children()[0].innerHTML;
            instructor_workload_data.course_code = course;

            //instructor_workload_data.total_weeks = $(this).children().eq(3)[0].children[0].children[0].value;
            //instructor_workload_data.total_contact_hrs = $(this).children().eq(4)[0].children[0].children[0].value;
            //instructor_workload_data.total_preparation_hrs = $(this).children()[5].innerHTML;
            //instructor_workload_data.total_hrs = $(this).children()[6].innerHTML;
            //instructor_workload_data.total_hrs_in_semester = $(this).children()[7].innerHTML;
            //instructor_workload_data.total_exp = $(this).children()[8].innerHTML;
            //instructor_workload_data.rate_band = $(this).children()[10].innerHTML;

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

            //if ($(this).children().eq(11)[0].children[0].children[0].checked) {
            //    instructor_workload_data.alternate_band = $(this).children().eq(11)[0].children[1].children[0].value;
            //    instructor_workload_data.justification = $(this).children().eq(11)[0].children[2].children[0].value;
            //}

            instructor_workload_data.semester_type = semester;
            instructor_workload_data.year_semester = year_code;

            All_instructor_workload_data.push(instructor_workload_data);
        });

        var All_instructor_data = [All_instructor_workload_data, action];
        var json_All_instructor_data = JSON.stringify(All_instructor_data);

        if (json_All_instructor_data.search("'") != -1) {
            json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_vf_course_wise_workload_detail",
            async: false,
            data: "{ All_table_course_data: '" + json_All_instructor_data + "' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Data Saved Successfully') {
                    if (action == 'A') {
                        bootbox.alert('Course Submitted Successfully', function () {
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

var course = '';
var semester = '';
var year_code = '';
function get_vf_course_wise_workload_detail() {
    $('#DataList').css('display', 'none');
    $('#div_btn').html('');

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

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_vf_course_wise_workload_detail",
        //async: false,
        data: "{course_code:'" + course + "',sem_code:'" + semester + "',year_code:'" + year_code + "'}",
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

    columns[4] = { "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false, mRender: function (ddata) {
        return "<center><input type='text' value='" + ddata + "' class='inline_input' style='width:40px;' onkeypress='return IsNumeric(event);'/></center>";
    } 
    };

    columns[5] = { "sTitle": "Total Contact Hrs", "mData": "total_contact_hrs", "bSortable": false, mRender: function (ddata) {
        return "<center><input type='text' value='" + parseFloat(ddata).toFixed(2) + "' class='inline_input' style='width:40px;' onkeypress='return IsNumeric(event);'/></center>";
    } 
    };

    return columns;
}

function inputChange(value) {
    //$('#example tbody tr').each(function () {
    //    var total_weeks = this.children[3].children[0].children[0].value;
    //    var total_contact_hrs = this.children[4].children[0].children[0].value;

    //    if (total_contact_hrs != '')
    //        this.children[5].innerHTML = parseFloat(course_detail['prep_hr_per_week']) * parseFloat(total_contact_hrs);
    //    else
    //        this.children[5].innerHTML = '';

    //    if (total_contact_hrs != '' && this.children[5].innerHTML != '')
    //        this.children[6].innerHTML = parseFloat(total_contact_hrs) + parseFloat(this.children[5].innerHTML);
    //    else if (total_contact_hrs != '')
    //        this.children[6].innerHTML = total_contact_hrs;
    //    else if (this.children[5].innerHTML != '')
    //        this.children[6].innerHTML = this.children[5].innerHTML;
    //    else
    //        this.children[6].innerHTML = '';

    //    if (total_weeks != '' && this.children[6].innerHTML != '')
    //        this.children[7].innerHTML = parseFloat(total_weeks) * parseFloat(this.children[6].innerHTML);
    //    else
    //        this.children[7].innerHTML = '';
    //});

    $('#example tbody tr').each(function () {
        var total_weeks = this.children[4].children[0].children[0].value;
        var total_contact_hrs = this.children[5].children[0].children[0].value;

        if (total_contact_hrs != '')
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
            this.children[8].innerHTML = parseFloat(total_weeks) * parseFloat(total_contact_hrs);
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

    //var columns = set_table_columns(JSON.parse(data)[0]);

    var columns = [{ "sTitle": "Instructor Code", "mData": "instructor_code" },
                    { "sTitle": "Code", "mData": "VF_code" },
                    //{ "sTitle": "Instructor Name", "mData": "instructor_name" },
                    {"sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false, fnRender: function (ddata) {
                        if (ddata.aData.is_tutorial == 'Y') return ddata.aData.instructor_name + ' (T)';
                        else return ddata.aData.instructor_name;
                    }
                    },
                    //{ "sTitle": "Designation", "mData": "designation" },
                    {"sTitle": "Grade", "mData": "designation" },
                    { "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false, mRender: function (ddata) {
                        return "<center><input type='text' value='" + ddata + "' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'/></center>";
                    }
                    },
                    { "sTitle": "Total Contact Hrs / Week", "mData": "total_contact_hrs", "bSortable": false, mRender: function (ddata) {
                        if (ddata != '')
                            return "<center><input type='text' value='" + parseFloat(ddata).toFixed(2) + "' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'/></center>";
                        else
                            return "<center><input type='text' value='' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'/></center>";
                    }
                    },
                    { "sTitle": "Total Preparation Hrs / Week", "mData": "total_preparation_hrs", "bSortable": false, "sClass": "cls_hide", mRender: function (ddata) {
                        //(67.4897586206897).toFixed(2)
                        if (ddata != '')
                        //return parseFloat(ddata).toFixed(2);
                            return '';
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Total Hrs / Week", "mData": "total_hrs", "bSortable": false, "sClass": "cls_hide", mRender: function (ddata) {
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
                    {"sTitle": "Alternate Band", "mData": "upper_rate_band", "bSortable": false, mRender: function (ddata) {
                        if (ddata != '')
                            return "<center><select class='inline_input cls_alternate_band' style='width:70px;'><option value=''>--</option>" +
                                        "<option value='" + parseFloat(ddata) + "'>" + parseFloat(ddata) + "</option></select></center>";
                        else
                            return "<center><select class='inline_input cls_alternate_band' style='width:70px;'><option value=''>--</option></select></center>";
                    }
                },
                    { "sTitle": "Justification", "mData": "justification", "bSortable": false, mRender: function (ddata) {
                        if (ddata != '')
                            return "<center><input type='text' value='" + ddata + "' class='inline_input cls_justification' style='width:200px;' /></center>";
                        else
                            return "<center><input type='text' value='' class='inline_input cls_justification' style='width:200px;' /></center>";
                    }
                    },
                    { "sTitle": "Change Workload", "mData": "admin_approved", "bSortable": false, mRender: function (ddata) {
                        if (ddata != 'Approved') {
                            return "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";
                        }
                        else return "";
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

//    if (workload_detail.length > 0) {
//        $("#example tbody tr").each(function (i) {
//            if (workload_detail[i].alternate_band != '') {
//                $(this).children().eq(11)[0].children[1].children[0].value = workload_detail[i].alternate_band;
//                $(this).children().eq(11)[0].children[2].children[0].value = workload_detail[i].justification;
//            }
//        });
//    }

    //$('#panel_head').html(course_detail['course_code'] + ' - ' + course_detail['course_name']);
    $('#td_course_code').html(course_detail['course_code']);
    $('#td_course_name').html(course_detail['course_name']);
    $('#td_course_type').html(course_detail['type_name']);
    $('#td_course_credits').html(course_detail['course_credits']);

    approve_cnt = 0;
    var str_tbl_load_dtl_html = '';
    for (var i = 0; i < workload_detail.length; i++) {
        if (workload_detail[i]['admin_approved'] == 'Approved') {
            approve_cnt++;
        }
        //$('#example tbody tr')[i].children[3].children[0].children[0].disabled = true;
        //$('#example tbody tr')[i].children[4].children[0].children[0].disabled = true;

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
    else $('#tbl_load_dtl').css('display','none');

    if (approve_cnt == workload_detail.length) $('#submitBtnDiv').html('');

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
}
