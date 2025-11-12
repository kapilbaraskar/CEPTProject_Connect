var oTable;
var course_detail;
var rate_band;
var workload_detail;
var action = 'S';
var ints_code = "";
var user_type = "";
var tea_letter = "";
var program_code = "";
var semester = '';
var year_code = '';
var prog_code = '';
var prog_level_code = '';
var dept_code = '';
var origin = '';


$(document).ready(function () {

    bindsemdata();
    bindyeardata_for_cross_reg();
    bindprogramme();
    bindproglevel();
    // get_rate_band();
    binddepartment();
   // binddepartment_wise_data();

    $('#btndownload').on('click', function () {
        //letter_auto_download();
        pdf_zip_download();
        return false;
    });

    $('#btnreterive').on('click', function () {
        get_vf_rate_band_detail();
        return false;
    });

    $('#btngenerateletter').on('click', function () {
        letter_auto_download();
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
                $('#drpproglevel').chosen();

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
    var name = row.parentElement.parentElement.parentElement.childNodes[4].innerHTML;
    var dept = row.parentElement.parentElement.parentElement.childNodes[7].innerHTML;
    var usrType = row.parentElement.parentElement.parentElement.childNodes[11].innerHTML;
    var tea_letter = row.parentElement.parentElement.parentElement.childNodes[12].innerHTML;
    var prog_code = row.parentElement.parentElement.parentElement.childNodes[13].innerHTML;

    $('#hdn_prog_code').val(prog_code);
    $('#hdn_tea_letter').val(tea_letter);
    $('#hdn_instructor').val(rowId);
    $('#hdn_instructor_name').val(name);
    $('#hdn_dept').val(dept);
    $('#hdn_usrType').val(usrType);
    $('#hdn_print_letter').click();
}
function rowClick_mail(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //var dept = row.parentElement.parentElement.parentElement.childNodes[4].innerHTML;
    var dept = row.parentElement.parentElement.parentElement.childNodes[7].innerHTML;
    var usrType = row.parentElement.parentElement.parentElement.childNodes[11].innerHTML;
    var tea_letter = row.parentElement.parentElement.parentElement.childNodes[12].innerHTML;
    var prog_code = row.parentElement.parentElement.parentElement.childNodes[13].innerHTML;

    $('#hdn_usrType').val(usrType);
    var instructor_list = [{ 'instructor_code': rowId, 'dept_name': dept, 'sem_code': semester, 'year_code': year_code, 'prog_code': prog_code, 'hdn_user_type': usrType, 'hdn_tea_letter': tea_letter }];

    //$('#hdn_instructor').val(JSON.stringify(instructor_list));
    //$('#hdn_send_mail').click();

    send_mail(JSON.stringify(instructor_list));
}
function send_it_to_all() {

    var instructor_list = [];
    // var obj_selected_inst = $('.cls_chk_course_select:checked');
    // if (obj_selected_inst.length > 0)
    var obj_selected_inst = $('.cls_chk_course_select:checked');
    if (obj_selected_inst.length > 0) {
        for (var i = 0; i < obj_selected_inst.length; i++) {
            var row_data = oTable.fnGetData(obj_selected_inst[i].closest('tr'));

            var rowId = row_data["instructor_code"];
            var dept = row_data["dept_name"];
            var admin_approval = row_data["admin_approved"];
            var usrType = row_data["des_type"];
            var prog_code = row_data["dept_code"];
            var tea_letter = row_data["designation_letter"];

            if (admin_approval == 'Approved' && workload_detail[i]['rateband_approved'] == 'Approved' && workload_detail[i]['workload_approved'] == 'Approved') {
                var instructor = { 'instructor_code': rowId, 'dept_name': dept, 'sem_code': semester, 'year_code': year_code, 'prog_code': prog_code, 'hdn_user_type': usrType, 'hdn_tea_letter': tea_letter };

                instructor_list.push(instructor);
            }
        }
        send_mail(JSON.stringify(instructor_list));
    }

    //$('#example tbody tr').each(function (i)
    //{

    //    var rowId = this.children[0].innerHTML;
    //    //var dept = this.children[4].innerHTML;
    //    //var admin_approval = this.children[5].innerHTML;
    //    //var dept = this.children[5].innerHTML;
    //    var dept = this.children[7].innerHTML;
    //    var admin_approval = this.children[8].innerHTML;
    //    var usrType = this.children[11].innerHTML;
    //    var prog_code = this.children[13].innerHTML;

    //    if (admin_approval == 'Approved' && workload_detail[i]['rateband_approved'] == 'Approved' && workload_detail[i]['workload_approved'] == 'Approved') {
    //        var instructor = { 'instructor_code': rowId, 'dept_name': dept, 'sem_code': semester, 'year_code': year_code, 'prog_code': prog_code, 'hdn_user_type': usrType };

    //        instructor_list.push(instructor);
    //    }
    //});

    //$('#hdn_instructor').val(JSON.stringify(instructor_list));
    //$('#hdn_send_mail').click();

    //send_mail(JSON.stringify(instructor_list));
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

    dept_code = $('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select Department');
        $('#drpdepartment').focus();
        return false;
    }

    prog_code = $('#drpprog').val();
    prog_level_code = $('#drpproglevel').val();

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_vf_rate_band_detail",
            data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {

                    $('#hdn_All_instructor').val(data.d);
                    $('#hdn_sem').val(semester);
                    $('#hdn_year').val(year_code);

                    workload_detail = JSON.parse(data.d);

                    display_get_vf_personal_detail(data.d);

                    $('#div_course_list').css('display', 'block');
                    //letter_auto_download();     04082021
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

    var edit_column = {
        "sTitle": "Edit", "mData": null, "bSortable": false, fnRender: function (data) {
            if (data.aData.admin_approved != 'Approved') return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
            else return '';
        }
    };

    columns.push(edit_column);

    return columns;
}

function display_get_vf_personal_detail(data) {
    debugger;
    var columns = [{ "sTitle": "Instructor Code", "mData": "instructor_code" },

    {
        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, mRender: function (data) {
            var pdfstatus = data.pdf_status;
            if (data.BankStatus == 'False')
            {
                return 'Bank Details Not Save';
               
            }
            else if (pdfstatus == 'Y')
            {
                return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
            }
            else if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.des_type == 'VF' && data.uso_hr_approved == 'Approved') {
                return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" checked />';
            }
            else if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.uso_hr_approved == 'Approved') {
                return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" checked />';
            }
            else {

                if (data.admin_approved != 'Approved') {
                    return 'Faculty Admin Not Approved';
                }
                else if (data.rateband_approved != 'Approved')
                {
                    return 'RateBand Not Approved';
                }
                else if (data.workload_approved != 'Approved') {
                    return 'WorkLoad Not Approved';
                }
                else if (data.hr_approved != 'Approved') {
                    return 'HR Not Approved';
                }
                else if (data.uso_hr_approved != 'Approved') {
                    return 'HR Not Approved';
                }
                
                
            }
        }
    },

    {
        "sTitle": "Download", "mData": null, "sClass": "cls_action", mRender: function (data) {
            var pdfstatus = data.pdf_status;
            if (pdfstatus == 'Y') {
                return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download PDF"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
            }
            else {
                return "";

            }
        }
    },


    { "sTitle": "VF Code", "mData": "VF_code" },
    { "sTitle": "Instructor Name", "mData": "instructor_name" },

    //{ "sTitle": "Designation", "mData": "designation" },

    {
        //"sTitle": "Grade", "mData": null, "bSortable": false, "sClass": "cls_hide", "fnRender": function (data) {
        "sTitle": "Grade", "mData": null, "bSortable": false, "mRender": function (data) {
            if (data.rate_wise_designation != '' && data.rate_wise_designation != null && data.rate_wise_designation != undefined) { return data.rate_wise_designation; }

            else if (data.designation != '' && data.designation != null && data.designation != undefined) {
                return data.designation;
            }
            else { return ''; }

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

    { "sTitle": "Admin Approval", "mData": "admin_approved" },

    //{ "sTitle": "Print Letters", "mData": "admin_approved", "bSortable": false, "mRender": function (data, type, full) {
    //    if (data == 'Approved')
    //        return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
    //    else
    //        return '';
    //}
    //},

    {
        "sTitle": "Print Letters", "mData": null, "bSortable": false, "mRender": function (data) {
            if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.des_type == 'VF' && data.uso_hr_approved == 'Approved')
                return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
            else if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.uso_hr_approved == 'Approved')
                return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
            else
                return '';
        }
    },
    {
        "sTitle": "Auto Mail", "mData": null, "bSortable": false, "mRender": function (data) {
            if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.des_type == 'VF' && data.uso_hr_approved == 'Approved')
                return '<center><button type="button" onclick="rowClick_mail(this)">Send</button></center>';
            else if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.uso_hr_approved == 'Approved')
                return '<center><button type="button" onclick="rowClick_mail(this)">Send</button></center>';
            else
                return '<center><button type="button" onclick="rowClick_mail(this)">Send</button></center>';
        }
    },
    { "sTitle": "Designation_Type", "mData": "des_type", "sClass": "cls_hide" },
    { "sTitle": "TEA_designation_letter", "mData": "designation_letter", "sClass": "cls_hide" },
    { "sTitle": "Program Code", "mData": "prog_code", "sClass": "cls_hide" },
    { "sTitle": "Course Code", "mData": "course_code", "sClass": "cls_hide" },
        {
            "sTitle": "Remark", "mData": null, "sClass": "cls_action", mRender: function (data) {
                var BankStatus = data.BankStatus;
                if (BankStatus == 'False')
                {
                    return 'Pending Bank Details and Profile Image';
                }
                else
                {
                    return "";

                }
            }
        },

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
        //        }
        //    ]
        //},

        "aaData": JSON.parse(data),

        "aoColumns": columns

    });

    if ($('#hdnusertype').val() == 'HR') {
        $('#submitBtnDiv').css('display', 'block');
    }

    $('#DataList').css('display', 'block');

    $('#example thead tr')[0].children[0].style.display = 'none';
    $('#example thead tr')[0].children[5].style.display = 'none';
    $('#example thead tr')[0].children[7].style.display = 'none';
    $('#example thead tr')[0].children[8].style.display = 'none';
    $('#example thead tr')[0].children[9].style.display = 'none';

    $("#example tbody tr").each(function (i) {
        $(this).children().eq(0)[0].style.display = 'none';
        $(this).children().eq(5)[0].style.display = 'none';
        $(this).children().eq(7)[0].style.display = 'none';
        $(this).children().eq(8)[0].style.display = 'none';
        $(this).children().eq(9)[0].style.display = 'none';
    });
}

function binddepartment()
{
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",
        data: "{}",
        dataType: "json",
        aSync: false,
        success: function (data) {
            if (data.d != "") {
                var sem_data = JSON.parse(data.d)

                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));

                for (var i = 0; i < sem_data.length; i++) {
                    $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                }

                $('#drpdepartment').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}


function binddepartment_wise_data()
{
    var url_path = '';
    if ($('#hdnusertype').val() == 'FA') {
        url_path = "../../WebService.asmx/get_faculty_name_department_wise";
    }
    else if ($('#hdnusertype').val() == 'PC')
    {
        url_path = "../../WebService.asmx/get_pc_name_department_wise";
    }
    else { return false; }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: url_path,
        data: "{}",
        dataType: "json",
        aSync: false,
        success: function (data) {
            if (data.d != "")
            {
                var sem_data = JSON.parse(data.d)

                $('#drpdepartment').val(sem_data[0]["dept_code"]);
                $('#drpdepartment').change();
                $('#drpdepartment').trigger("liszt:updated");


               // $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
               //
               // for (var i = 0; i < sem_data.length; i++) {
               //     $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
               // }

               // $('#drpdepartment').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}



function select_all_change() {
    if ($('#chk_select_all')[0].checked) {
        $('.cls_chk_course_select').attr('checked', 'checked');
    }
    else {
        $('.cls_chk_course_select').removeAttr('checked');
    }
}


function course_select_change(cur_ele) {

    if (cur_ele.checked)
    {
        if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
            $('#chk_select_all')[0].checked = true;
    }
    else {
        $('#chk_select_all')[0].checked = false;
    }
}

function letter_auto_download() {

    var sem_code = $('#drpsemester').val();
    if (sem_code == "") {
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

    dept_code = $('#drpdepartment option:selected').text();//$('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select Department');
        $('#drpdepartment').focus();
        return false;
    }

    prog_code = $('#drpprog').val();
    prog_level_code = $('#drpproglevel').val();

    var obj_selected_inst = $('.cls_chk_course_select:checked');
    if (obj_selected_inst.length > 0)
    {
        ints_code = "";
        for (var i = 0; i < obj_selected_inst.length; i++)
        {
            var row_data = oTable.fnGetData(obj_selected_inst[i].closest('tr'));

            if (ints_code == "")
            {
                ints_code = row_data['instructor_code'];
                user_type = row_data['des_type'];
                tea_letter = row_data['designation_letter'];
                program_code = row_data['prog_code'];

            }
            else {
                //ints_code = '126';
                ints_code = ints_code + ',' + row_data['instructor_code'];
                user_type = user_type + ',' + row_data['des_type'];
                tea_letter = tea_letter + ',' + row_data['designation_letter'];
                program_code = program_code + ',' + row_data['prog_code'];


            }
        }
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_publish_letter_print",
            data: "{sem_code:'" + sem_code + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "',ints_code:'" + ints_code + "',user_type:'" + user_type + "',tea_letter:'" + tea_letter + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "Data Not Found") {
                        bootbox.alert("No data found for selected course or course type");
                        return false;
                    }
                    else if (data.d == "true")
                    {
                       // get_vf_rate_band_detail(); session out issue 
                        //origin = window.location.origin + '/' + 'login.aspx?logout=2';
                        //window.open(origin, "_self");
                    }

                    return true;

                }
                else {
                    bootbox.alert('No data found for selected criteria');
                }
            },
            error: function (result) {
                alert(result);
            }
        });



    }
    else {
        alert("Please Select CheckBox");
        return false;
    }
}
$(document).on("click", ".pdf_download", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    //var course_code = aData["course_code"];
    var instructor_code = aData["instructor_code"];
    //var course_name = aData["course_name"];
    //var total_course = aData["total_course"];
    //var total_feedback = aData["total_feedback"];
    var dept_name = aData["dept_name"];
    if (aData["dept_code"] == '9') {
        dept_name = aData["dept_name"].replace(" ", "_");

    }
    //var dept_name = aData["dept_name"];
    var instructor_name = aData["instructor_name"];
    var semester = $('#drpsemester').val();
    var year_code = $('#drpyear').val();
    if (semester == 'S') {
        semester = 'Spring';
    }
    else {
        semester = 'Monsoon';
    }
    var link = instructor_code + '_' + instructor_name.replace(' ', '_') + '_' + dept_name + '_' + semester + '_' + year_code + '.pdf';
    link = link.replace(' ', '_');
    origin = window.location.origin + '/';
    window.open(origin + 'LetterPDF' + '/' + link, '_blank');
    return false;
});
var pdf_file_path = "";
//$(document).on("click", "#btndownload", function (event) {
function pdf_zip_download() {

    var semester = $('#drpsemester').val();
    var sem = "";
    var year_code = $('#drpyear').val();
    if (semester == 'S') {
        sem = 'Spring';
    }
    else {
        sem = 'Monsoon';
    }
    var obj_selected_inst = $('.cls_chk_course_select:checked');
    if (obj_selected_inst.length > 0) {
        for (var i = 0; i < obj_selected_inst.length; i++) {
            var row_data = oTable.fnGetData(obj_selected_inst[i].closest('tr'));

            if (pdf_file_path == "") {
                pdf_file_path = row_data['instructor_code'].replace(' ', '_') + '_' + row_data['instructor_name'].replace(' ', '_') + '_' + row_data['dept_name'] + '_' + sem + '_' + year_code + '.pdf';
                pdf_file_path = pdf_file_path.replace(' ', '_');
            }
            else {

                pdf_file_path = pdf_file_path + ',' + row_data['instructor_code'].replace(' ', '_') + '_' + row_data['instructor_name'].replace(' ', '_') + '_' + row_data['dept_name'] + '_' + sem + '_' + year_code + '.pdf';
                pdf_file_path = pdf_file_path.replace(' ', '_');
            }
        }
    }
    else {
        bootbox.alert("please select checkbox");
        return false;
    }


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/CombinePDF_TE_Letter",

        data: "{'FileName':'" + pdf_file_path + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d == "2") {
                    bootbox.alert("No Data Found");
                    return false;
                }
                else {
                    origin = window.location.origin + '/';
                    window.open(origin + 'LetterPDF' + '/' + 'Letter Pdf.zip', '_blank');
                    bootbox.alert("Letter PDF Download Sucessfully");
                }

                return false;

            }
            else {
                bootbox.alert('No data found for selected criteria');
            }
        },
        error: function (result) {
            alert(result);
        }
    });



    return false;
}//);


function update_letter() {
    ints_code = "";
    user_type = "";
    tea_letter = "";
    program_code = "";
    var sem_code = $('#drpsemester').val();
    if (sem_code == "") {
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

    dept_code = $('#drpdepartment option:selected').text();//$('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select Department');
        $('#drpdepartment').focus();
        return false;
    }

    prog_code = $('#drpprog').val();
    prog_level_code = $('#drpproglevel').val();

    var obj_selected_inst = $('.cls_chk_course_select:checked');
    if (obj_selected_inst.length > 0) {
        for (var i = 0; i < obj_selected_inst.length; i++) {
            var row_data = oTable.fnGetData(obj_selected_inst[i].closest('tr'));

            if (ints_code == "") {
                ints_code = row_data['instructor_code'];
                user_type = row_data['des_type'];
                tea_letter = row_data['designation_letter'];
                program_code = row_data['prog_code'];

            }
            else {
                //ints_code = '126';
                ints_code = ints_code + ',' + row_data['instructor_code'];
                user_type = user_type + ',' + row_data['des_type'];
                tea_letter = tea_letter + ',' + row_data['designation_letter'];
                program_code = program_code + ',' + row_data['prog_code'];


            }
        }
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_publish_letter_print",
            data: "{sem_code:'" + sem_code + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "',ints_code:'" + ints_code + "',user_type:'" + user_type + "',tea_letter:'" + tea_letter + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "Data Not Found") {
                        bootbox.alert("No data found for selected course or course type");
                        return false;
                    }
                    else if (data.d == "true") {
                        // origin = window.location.origin + '/' + 'login.aspx?logout=2';
                        // window.open(origin, "_self");

                    }

                    return true;

                }
                else {
                    bootbox.alert('No data found for selected criteria');
                }
            },
            error: function (result) {
                alert(result);
            }
        });



    }
    else {
        alert("Please Select CheckBox");
        return false;
    }
}
