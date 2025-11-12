var oTable;
var course_detail;
var rate_band;
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

function rowClick_print(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //var name = row.parentElement.parentElement.parentElement.childNodes[1].innerHTML;
    //var dept = row.parentElement.parentElement.parentElement.childNodes[4].innerHTML;
    var name = row.parentElement.parentElement.parentElement.childNodes[2].innerHTML;
    var dept = row.parentElement.parentElement.parentElement.childNodes[5].innerHTML;

    $('#hdn_instructor').val(rowId);
    $('#hdn_instructor_name').val(name);
    $('#hdn_dept').val(dept);
    $('#hdn_print_letter').click();
}

function rowClick_mail(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //var dept = row.parentElement.parentElement.parentElement.childNodes[4].innerHTML;
    var dept = row.parentElement.parentElement.parentElement.childNodes[5].innerHTML;

    var instructor_list = [{ 'instructor_code': rowId, 'dept_name': dept, 'sem_code': semester, 'year_code': year_code}];

    //$('#hdn_instructor').val(JSON.stringify(instructor_list));
    //$('#hdn_send_mail').click();

    send_mail(JSON.stringify(instructor_list));
}

function send_it_to_all() {

    var instructor_list = [];

    $('#example tbody tr').each(function (i) {
        var rowId = this.children[0].innerHTML;
        //var dept = this.children[4].innerHTML;
        //var admin_approval = this.children[5].innerHTML;
        var dept = this.children[5].innerHTML;
        var admin_approval = this.children[6].innerHTML;

        if (admin_approval == 'Approved' && workload_detail[i]['rateband_approved'] == 'Approved' && workload_detail[i]['workload_approved'] == 'Approved') {
            var instructor = { 'instructor_code': rowId, 'dept_name': dept, 'sem_code': semester, 'year_code': year_code };

            instructor_list.push(instructor);
        }
    });
    
    //$('#hdn_instructor').val(JSON.stringify(instructor_list));
    //$('#hdn_send_mail').click();

    send_mail(JSON.stringify(instructor_list));
}

function send_mail(instructor_list) {

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/send_Appointment_mail_to_visiting_faculty",
        //async: false,
        data: "{instructor_list:'" + instructor_list + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d == null || data.d == '') {
                bootbox.alert('Problem in Sending Mails.');
            }
            else if (data.d != "" && data.d != "[]") {
                bootbox.alert(data.d);
            }
            else {
                bootbox.alert(data.d);
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

var semester = '';
var year_code = '';
var prog_code = '';
var prog_level_code = '';

function get_vf_rate_band_detail() {
    $('#DataList').css('display', 'none');
    $('#div_btn').html('');
    $('#submitBtnDiv').css('display', 'none');

    debugger;
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
        url: "../../WebService.asmx/get_vf_rate_band_detail",
        //async: false,
        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {

                $('#hdn_All_instructor').val(data.d);
                $('#hdn_sem').val(semester);
                $('#hdn_year').val(year_code);

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
    if (document.activeElement.checked) {
        var parent = document.activeElement.parentElement.parentElement;
        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();' checked='checked'/></center>" +
                                    "<center><select class='cls_drp_rate_band' style='width:65px;margin-top:2px;'>" + rate_band + "</select></center>" +
                                    "<center><input type='text' value='' class='inline_input' style='width:70px;margin-top:2px;'/></center>";

        parent.innerHTML = str;
    }
    else {
        var parent = document.activeElement.parentElement.parentElement;
        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";

        parent.innerHTML = str;
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
                    
                    {"sTitle": "Grade", "mData": null, "bSortable": false, "sClass": "cls_hide", "fnRender": function (data) {
                        if (data.aData.rate_wise_designation != '')
                            return data.aData.rate_wise_designation;
                        else
                            return data.aData.designation;
                    }
                    },
                    { "sTitle": "Email", "mData": "mail" },
                    { "sTitle": "Department", "mData": "dept_name" },
                    
                    //{ "sTitle": "Highest Qualification", "mData": "highest_qualification" },
                    //{ "sTitle": "Rate Band", "mData": null, "bSortable": false, fnRender: function (data) {
                    //    if (data.aData.alternate_band != '') {
                    //        return data.aData.alternate_band;
                    //    }
                    //    else {
                    //        return data.aData.rate_band;
                    //    }
                    //}
                    //},
                    //{ "sTitle": "Justification", "mData": "justification" },
                    
                    {"sTitle": "Admin Approval", "mData": "admin_approved" },
                    
                    //{ "sTitle": "Print Letters", "mData": "admin_approved", "bSortable": false, "mRender": function (data, type, full) {
                    //    if (data == 'Approved')
                    //        return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
                    //    else
                    //        return '';
                    //}
                    //},
                    
                    {"sTitle": "Print Letters", "mData": null, "bSortable": false, "fnRender": function (data) {
                        if (data.aData.admin_approved == 'Approved' && data.aData.rateband_approved == 'Approved' && data.aData.workload_approved == 'Approved' && data.aData.hr_approved == 'Approved')
                            return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Auto Mail", "mData": null, "bSortable": false, "fnRender": function (data) {
                        if (data.aData.admin_approved == 'Approved' && data.aData.rateband_approved == 'Approved' && data.aData.workload_approved == 'Approved' && data.aData.hr_approved == 'Approved')
                            return '<center><button type="button" onclick="rowClick_mail(this)">Send</button></center>';
                        else
                            return '';
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

    if ($('#hdnusertype').val() == 'HR') {
        $('#submitBtnDiv').css('display','block');
    }

    $('#DataList').css('display', 'block');

    $('#example thead tr')[0].children[0].style.display = 'none';
    $('#example thead tr')[0].children[5].style.display = 'none';
    $('#example thead tr')[0].children[6].style.display = 'none';

    $("#example tbody tr").each(function (i) {
        $(this).children().eq(0)[0].style.display = 'none';
        $(this).children().eq(5)[0].style.display = 'none';
        $(this).children().eq(6)[0].style.display = 'none';
    });
}
