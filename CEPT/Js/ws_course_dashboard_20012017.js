var semester = '';
var year_code = '';
var dept_code = '';
var prog_code = '';
var str_mynewModal_view = '';
var oTable2, oTable3;

$(document).ready(function () {
    bindyeardata_for_cross_reg();
    bindwssemdata();
    binddepartment();
    //bindprogrammedata();

    setCurrentSemester();

    bindinstructor();

    $('#btnreterive').on('click', function () {
        retrieve_WS_offered_course_Data();
        retrieve_WS_approved_course_Data();

        if ($('#hdnusertype').val() == 'D') {
            retrieve_WS_sendedforreview_course_Data();
            retrieve_WS_rejected_course_Data();
        }

        return false;
    });

    $('#mynewModal_sendforreview').on('hidden', function () {
        $('#td_send_course_name').html('');
        $('#txt_send_mail_subject').val('');
        $('#txt_send_mail_body').val('');
        cur_course_data = {};
    });

    $('#mynewModal_reject').on('hidden', function () {
        $('#td_reject_course_name').html('');
        $('#txt_reject_mail_subject').val('');
        $('#txt_reject_mail_body').val('');
        cur_course_data = {};
    });

    str_mynewModal_view = $('#mynewModal_view').html();
    $('#mynewModal_view').on('hidden', function () {
        $('#mynewModal_view').html(str_mynewModal_view);
    });

    if ($('#hdnusertype').val() == 'D') {
        $('.cls_tabs').css('display', 'block');
    }
});

function setCurrentSemester() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_cept_current_sem_data",
        //async: false,
        data: "{type:'ws_course'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                cur_grade_sem = JSON.parse(data.d);

                if (cur_grade_sem.length > 0) {
                    $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                    $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                    $('#drpsemester').trigger("liszt:updated");
                    $('#drpyear').trigger("liszt:updated");

                    get_acuser_detail();
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindwssemdata() {
    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
    $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            
    $('#drpsemester').chosen();
}

var dept_options = [];
function get_acuser_detail() {
    if ($('#hdnusertype').val() == 'AC' || $('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'D') {

        dept_options = $('#drpdepartment').children();

        semester = $('#drpsemester').val();

        year_code = $('#drpyear').val();

        if (semester == "" || year_code == "") {
            return false;
        }

        $('#drpdepartment').html('');
        $('#drpdepartment').append(dept_options[0]);
        $('#drpdepartment').trigger("liszt:updated");

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_semyearwise_dean_user_dtl",
            async: false,
            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var user_data = JSON.parse(data.d);

                    for (var i = 0; i < user_data.length; i++) {
                        $('#drpdepartment').append(dept_options[user_data[i]['dept_code']]);
                    }

                    $('#drpdepartment').val(user_data[0]['dept_code']);

                    $('#drpdepartment').trigger("liszt:updated");
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
    $('#btnreterive').click();
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

                instructor = "<option value=''></option>";

                for (var i = 0; i < instructor_data.length; i++) {
                    instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                }

                $('#drp_instructor_list').html(instructor);
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function retrieve_WS_offered_course_Data() {
    $('#DataList_offeredcourses').css('display', 'none');

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

//            dept_code = $('#drpdepartment').val();
//            if ($('#hdnusertype').val() == 'D') {
//                if (dept_code == "") {
//                    bootbox.alert('Please select Department');
//                    $('#drpdepartment').focus();
//                    return false;
//                }
//            }

    //prog_code = $('#drpprog').val();
            
    var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code };
    $('#hdn_filter').val(JSON.stringify(filter_criteria));

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_ws_offered_course_list",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {
                display_offered_course_Data(data.d);
                //setDataTableHeaderFooter('example_offeredcourses');
            }
            else {
                bootbox.alert('No Offered Courses Found For Selected Semester or Year');
            }
        },
        error: function (result) {
            alert(result);
        }
    });
    return false;
}

function display_offered_course_Data(data) {

    var columns = [];

    columns = [{ "sTitle": "Course Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Instructors", "mData": "instructors", "bSortable": false },
                    { "sTitle": "Inhabitation", "mData": "inhabitation", "bSortable": false, "mRender": function (data) {
                        if (data == "1") return "Architecture";
                        else if (data == "2") return "Design";
                        else if (data == "3") return "Management";
                        else if (data == "4") return "Planning";
                        else if (data == "5") return "Technology";
                        else return "";
                    }
                    },
                    { "sTitle": "Intake Capacity", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Credits", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Category Location Wise", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Location", "mData": "location", "bSortable": false },

                    { "sTitle": "Start Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", "fnRender": function (data) {
                        if (data.aData.start_date != '') {
                            var temp_date = new Date(data.aData.start_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "End Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.end_date != '') {
                            var temp_date = new Date(data.aData.end_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    }
    ];

    if ($("#hdnusertype").val() == 'D') {
        columns.push({ "sTitle": "Approve", "mData": null, "bSortable": false, fnRender: function (data) {
            if (data.aData.instructor_approved == 'Y') {
                return "<center><button type='button' onclick='approve(this)' class='btn btn-primary btn-small'>Approve</button></center>";
            }
            else return "";
        }
        });
        columns.push({ "sTitle": "Send for Review", "mData": null, "bSortable": false, fnRender: function (data) {
            if (data.aData.instructor_approved == 'Y') {
                return "<center><button type='button' onclick='sendForReview(this)' class='btn btn-primary btn-small'>Send</button></center>";
            }
            else return "";
        }
        });
        columns.push({ "sTitle": "Reject", "mData": null, "bSortable": false, fnRender: function (data) {
            if (data.aData.instructor_approved == 'Y') {
                return "<center><button type='button' onclick='reject(this)' class='btn btn-primary btn-small'>Reject</button></center>";
            }
            else return "";
        }
        });
        columns.push({ "sTitle": "Edit", "mData": null, "bSortable": false, fnRender: function (data) {
            if (data.aData.instructor_approved == 'N' && data.aData.created_by == $('#hdnuserid').val()) {
                return "<center><button type='button' onclick='edit(this)' class='btn btn-primary btn-small'>Edit</button></center>";
            }
            else return "";
        }
        });
    }
    else if ($("#hdnusertype").val() == 'WSA') {
        columns.push({ "sTitle": "Edit", "mData": null, "bSortable": false, fnRender: function (data) {
            return "<center><button type='button' onclick='edit(this)' class='btn btn-primary btn-small'>Edit</button></center>";
        }
        });
    }
    else if ($("#hdnusertype").val() == 'I2') {
        columns.push({ "sTitle": "Edit", "mData": null, "bSortable": false, fnRender: function (data) {
            if (data.aData.instructor_approved == 'N') {
                return "<center><button type='button' onclick='edit(this)' class='btn btn-primary btn-small'>Edit</button></center>";
            }
            else return "";
        }
        });
    }
    else if ($("#hdnusertype").val() == 'PC') {
        columns.push({ "sTitle": "Edit", "mData": null, "bSortable": false, fnRender: function (data) {
            if (data.aData.instructor_approved == 'N' && data.aData.created_by == $('#hdnuserid').val()) {
                return "<center><button type='button' onclick='edit(this)' class='btn btn-primary btn-small'>Edit</button></center>";
            }
            else return "";
        }
        });
    }

    columns.push({ "sTitle": "View Detail", "mData": null, "bSortable": false, fnRender: function (data) {
        return "<center><a onclick='view_course_detail(this)'>View</button></a>";
    }
    });

    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList_offeredcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_offeredcourses" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example_offeredcourses").dataTable({
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
                //"print",
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

    $('#DataList_offeredcourses').css('display', 'block');
}

function retrieve_WS_approved_course_Data() {
    $('#DataList_approvedcourses').css('display', 'none');
    $('#div_save_course_code').html('');

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

    //            dept_code = $('#drpdepartment').val();
    //            if ($('#hdnusertype').val() == 'D') {
    //                if (dept_code == "") {
    //                    bootbox.alert('Please select Department');
    //                    $('#drpdepartment').focus();
    //                    return false;
    //                }
    //            }

    //prog_code = $('#drpprog').val();

    var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code };
    $('#hdn_filter').val(JSON.stringify(filter_criteria));

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_ws_approved_course_list",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {
                display_approved_course_Data(data.d);
                //setDataTableHeaderFooter('example_approvedcourses');
            }
            else {
                //bootbox.alert('No data Found For Selected Semester or Year');
            }
        },
        error: function (result) {
            alert(result);
        }
    });
    return false;
}

function display_approved_course_Data(data) {

    var columns = [];

//            if ($("#hdnusertype").val() == 'WSA') {
//                columns.push({ "sTitle": "Course Code", "mData": "ws_course_code", "bSortable": false, "mRender": function (data) {
//                    return '<input type="text" value="' + data + '" class="cls_ws_course_code" style="width:100px;" />';
//                }
//                });
//            }
            
    if ($("#hdnusertype").val() == 'WSA') {
        columns.push({ "sTitle": "Course Code", "mData": null, "bSortable": false, "fnRender": function (data) {
            if (data.aData.is_publish != 'Y')
                return '<input type="text" value="' + data.aData.ws_course_code + '" class="cls_ws_course_code" style="width:100px;" />';
            else return '' + data.aData.ws_course_code;
        }
        });
    }

    columns.push({ "sTitle": "Course Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Instructors", "mData": "instructors", "bSortable": false },
                    { "sTitle": "Inhabitation", "mData": "inhabitation", "bSortable": false, "mRender": function (data) {
                        if (data == "1") return "Architecture";
                        else if (data == "2") return "Design";
                        else if (data == "3") return "Management";
                        else if (data == "4") return "Planning";
                        else if (data == "5") return "Technology";
                        else return "";
                    }
                    },
                    { "sTitle": "Intake Capacity", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Credits", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Category Location Wise", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Location", "mData": "location", "bSortable": false },

                    { "sTitle": "Start Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.start_date != '') {
                            var temp_date = new Date(data.aData.start_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "End Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.end_date != '') {
                            var temp_date = new Date(data.aData.end_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "View Detail", "mData": null, "bSortable": false, fnRender: function (data) {
                        return "<center><a onclick='view_approve_course_detail(this)'>View</button></a>";
                    }
                    }
                );

    if (oTable1 != null) {
        oTable1.fnDestroy();
        $("#DataList_approvedcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approvedcourses" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#example_approvedcourses").dataTable({
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
            //"print",
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

    $('#DataList_approvedcourses').css('display', 'block');

    if ($('#hdnusertype').val() == 'WSA') {
        $('#div_save_course_code').html('<input id="btn_save_course_code" type="button" class="btn btn-primary" value="Save" style="margin-top: 15px;" />');

        $('#btn_save_course_code').on('click', function () {
            var lst_changed_code_list = [];
            $('#example_approvedcourses tbody tr').each(function (i) {
                var row_data = oTable1.fnGetData(this);

                if ($(this).find('.cls_ws_course_code').val() != '' && $(this).find('.cls_ws_course_code').val() != undefined && $(this).find('.cls_ws_course_code').val() != row_data['ws_course_code'].toString()) {
                    var obj_changed_code_detail = { 'course_code': '', 'ws_course_code': '', 'sem_code': '', 'year_code': '' };

                    obj_changed_code_detail.course_code = row_data['course_code'];
                    obj_changed_code_detail.ws_course_code = $(this).find('.cls_ws_course_code').val();
                    obj_changed_code_detail.sem_code = semester;
                    obj_changed_code_detail.year_code = year_code;

                    lst_changed_code_list.push(obj_changed_code_detail);
                }
            });

            if (lst_changed_code_list.length > 0) {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_ws_course_code",
                    //async: false,
                    data: "{changed_course_detail:'" + JSON.stringify(lst_changed_code_list) + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var res = JSON.parse(data.d);
                            if (res["status"].toString() == 'True') bootbox.alert("Course Codes Saved Successfully", function () { $('#btnreterive').click() });
                            else bootbox.alert(res["message"].toString());
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            else {
                bootbox.alert("No Changes Found");
            }
        });
    }
}

function retrieve_WS_sendedforreview_course_Data() {
    $('#DataList_sendedforreview').css('display', 'none');

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

    //            dept_code = $('#drpdepartment').val();
    //            if ($('#hdnusertype').val() == 'D') {
    //                if (dept_code == "") {
    //                    bootbox.alert('Please select Department');
    //                    $('#drpdepartment').focus();
    //                    return false;
    //                }
    //            }

    //prog_code = $('#drpprog').val();

    var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code };
    $('#hdn_filter').val(JSON.stringify(filter_criteria));

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_ws_sendedforreview_course_list",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {
                display_sendedforreview_course_Data(data.d);
                //setDataTableHeaderFooter('example_sendedforreview');
            }
            else {
                //bootbox.alert('No data Found For Selected Semester or Year');
            }
        },
        error: function (result) {
            alert(result);
        }
    });
    return false;
}

function display_sendedforreview_course_Data(data) {

    var columns = [];

    columns = [{ "sTitle": "Course Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Instructors", "mData": "instructors", "bSortable": false },
                    { "sTitle": "Inhabitation", "mData": "inhabitation", "bSortable": false, "mRender": function (data) {
                        if (data == "1") return "Architecture";
                        else if (data == "2") return "Design";
                        else if (data == "3") return "Management";
                        else if (data == "4") return "Planning";
                        else if (data == "5") return "Technology";
                        else return "";
                    }
                    },
                    { "sTitle": "Intake Capacity", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Credits", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Category Location Wise", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Location", "mData": "location", "bSortable": false },

                    { "sTitle": "Start Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.start_date != '') {
                            var temp_date = new Date(data.aData.start_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "End Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.end_date != '') {
                            var temp_date = new Date(data.aData.end_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    }//,
                    //{ "sTitle": "View Detail", "mData": null, "bSortable": false, fnRender: function (data) {
                    //    return "<center><a onclick='view_sendedforreview_course_detail(this)'>View</button></a>";
                    //}
                    //}
                ];

    if (oTable2 != null) {
        oTable2.fnDestroy();
        $("#DataList_sendedforreview").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_sendedforreview" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable2 = $("#example_sendedforreview").dataTable({
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
            //"print",
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

    $('#DataList_sendedforreview').css('display', 'block');
}

function retrieve_WS_rejected_course_Data() {
    $('#DataList_rejectedcourses').css('display', 'none');

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

    //            dept_code = $('#drpdepartment').val();
    //            if ($('#hdnusertype').val() == 'D') {
    //                if (dept_code == "") {
    //                    bootbox.alert('Please select Department');
    //                    $('#drpdepartment').focus();
    //                    return false;
    //                }
    //            }

    //prog_code = $('#drpprog').val();

    var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code };
    $('#hdn_filter').val(JSON.stringify(filter_criteria));

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_ws_rejected_course_list",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {
                display_rejected_course_Data(data.d);
                //setDataTableHeaderFooter('example_rejectedcourses');
            }
            else {
                //bootbox.alert('No data Found For Selected Semester or Year');
            }
        },
        error: function (result) {
            alert(result);
        }
    });
    return false;
}

function display_rejected_course_Data(data) {

    var columns = [];

    columns = [{ "sTitle": "Course Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Instructors", "mData": "instructors", "bSortable": false },
                    { "sTitle": "Inhabitation", "mData": "inhabitation", "bSortable": false, "mRender": function (data) {
                        if (data == "1") return "Architecture";
                        else if (data == "2") return "Design";
                        else if (data == "3") return "Management";
                        else if (data == "4") return "Planning";
                        else if (data == "5") return "Technology";
                        else return "";
                    }
                    },
                    { "sTitle": "Intake Capacity", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Credits", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Category Location Wise", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Location", "mData": "location", "bSortable": false },

                    { "sTitle": "Start Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.start_date != '') {
                            var temp_date = new Date(data.aData.start_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "End Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.end_date != '') {
                            var temp_date = new Date(data.aData.end_date);
                            return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                        }
                        else
                            return '';
                    }
                    }//,
    //                            { "sTitle": "View Detail", "mData": null, "bSortable": false, fnRender: function (data) {
    //                                return "<center><a onclick='view_rejected_course_detail(this)'>View</button></a>";
    //                            }
    //                            }
                ];

    if (oTable3 != null) {
        oTable3.fnDestroy();
        $("#DataList_rejectedcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_rejectedcourses" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable3 = $("#example_rejectedcourses").dataTable({
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
            //"print",
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

    $('#DataList_rejectedcourses').css('display', 'block');
}

function approve(element) {
    if ($("#hdnusertype").val() == 'D') {
        var row = element.closest('tr');
        var row_data = oTable.fnGetData(row);

        var course_data = { 'course_code': row_data['course_code'].toString(), 'sem_code': semester, 'year_code': year_code };

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/WS_course_proposal_approve",
            //async: false,
            data: "{course_data:'" + JSON.stringify(course_data) + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    var res = JSON.parse(data.d);
                    if (res["status"].toString() == 'True') bootbox.alert("Course Approved Successfully", function () { $('#btnreterive').click() });
                    else bootbox.alert(res["message"].toString());
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
}

var cur_course_data;
function sendForReview(element) {
    cur_course_data = {};

    if ($("#hdnusertype").val() == 'D') {
        var row = element.closest('tr');
        var row_data = oTable.fnGetData(row);

        cur_course_data = { 'course_code': row_data['course_code'].toString(), 'sem_code': semester, 'year_code': year_code, 'mail_subject': '', 'mail_body': '' };

        $('#td_send_course_name').html(row_data['course_name'].toString());

        $('#btn_show_modal_sendforreview').click();
    }
}

function sendMail_sendforreview() {

    cur_course_data['mail_subject'] = $('#txt_send_mail_subject').val();
    cur_course_data['mail_body'] = $('#txt_send_mail_body').val();

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/WS_course_proposal_send_for_review",
        //async: false,
        data: "{course_data:'" + JSON.stringify(cur_course_data) + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {
                var res = JSON.parse(data.d);
                if (res["status"]) {
                    bootbox.alert("Course Sended for Review Successfully", function () {
                        $('#btn_modal_close_sendforreview').click();
                        $('#btnreterive').click();
                    });
                }
                else bootbox.alert(data.d);
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function reject(element) {
    cur_course_data = {};

    if ($("#hdnusertype").val() == 'D') {
        var row = element.closest('tr');
        var row_data = oTable.fnGetData(row);

        cur_course_data = { 'course_code': row_data['course_code'].toString(), 'sem_code': semester, 'year_code': year_code, 'mail_subject': '', 'mail_body': '' };

        $('#td_reject_course_name').html(row_data['course_name'].toString());

        $('#btn_show_modal_reject').click();
    }
}

function sendMail_reject() {

    cur_course_data['mail_subject'] = $('#txt_reject_mail_subject').val();
    cur_course_data['mail_body'] = $('#txt_reject_mail_body').val();

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/WS_course_proposal_reject",
        //async: false,
        data: "{course_data:'" + JSON.stringify(cur_course_data) + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {
                var res = JSON.parse(data.d);
                if (res["status"]) {
                    bootbox.alert("Course Rejected Successfully", function () {
                        $('#btn_modal_close_reject').click();
                        $('#btnreterive').click();
                    });
                }
                else bootbox.alert(data.d);
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function edit(element) {
    if ($("#hdnusertype").val() == 'I2' || $("#hdnusertype").val() == 'PC' || $("#hdnusertype").val() == 'D' || $("#hdnusertype").val() == 'WSA') {
        var row = element.closest('tr');
        var row_data = oTable.fnGetData(row);
        window.location = "ws_coursemaster_add.aspx?c=" + row_data['course_code'] + "&s=" + semester + "&y=" + year_code;
    }
}

function view_course_detail(element) {
    var row = element.closest('tr');
    var row_data = oTable.fnGetData(row);

    set_course_detail(row, row_data);
    //set_poster_detail(row, row_data);
}

function view_approve_course_detail(element) {
    var row = element.closest('tr');
    var row_data = oTable1.fnGetData(row);

    set_course_detail(row, row_data);
}

//        function view_sendedforreview_course_detail(element) {
//            var row = element.closest('tr');
//            var row_data = oTable2.fnGetData(row);

//            set_course_detail(row, row_data);
//        }

//        function view_rejected_course_detail(element) {
//            var row = element.closest('tr');
//            var row_data = oTable3.fnGetData(row);

//            set_course_detail(row, row_data);
//        }


function set_course_detail(row, row_data) {
//            $('#td_view_course_name').html(row_data['course_name'].toString());
//            $('#td_view_methodology').html(row_data['methodology'].toString());
//            $('#td_view_inhabitation').html(row_data['inhabitation'].toString());

//            switch (row_data['inhabitation'].toString()) {
//                case "1": $('#td_view_inhabitation').html("Architecture"); break;
//                case "2": $('#td_view_inhabitation').html("Design"); break;
//                case "3": $('#td_view_inhabitation').html("Management"); break;
//                case "4": $('#td_view_inhabitation').html("Planning"); break;
//                case "5": $('#td_view_inhabitation').html("Technology"); break;
//            }

    if (row_data != null) {

        $('#spn_course_title').html('<b class="cls_colon">:</b>' + row_data["course_name"]);

        set_course_instructor_workplan_detail(row_data["course_code"]);

        $('#spn_category_location_wise').html('<b class="cls_colon">:</b>' + row_data["category_location_wise"]);
        $('#spn_location').html('<b class="cls_colon">:</b>' + row_data["location"]);

        if (row_data["available_seat"] != '') {
            $('#spn_available_seats').html('<b class="cls_colon">:</b>' + row_data["available_seat"]);
        }

        $('#spn_credits').html('<b class="cls_colon">:</b>' + row_data["course_credits"]);
        $('#spn_course_description').html(row_data["course_desc"]);
        $('#spn_course_prerequisite').html('<b class="cls_colon">:</b>' + row_data["prerequisite"]);

        if (row_data["is_open_for_professional"] == 'Y') {
            $('#spn_is_for_professional').html('<b class="cls_colon">:</b>Yes');
            $('#spn_professional_prerequisite').html('<b class="cls_colon">:</b>' + row_data["prerequisite_for_prof"]);
            $('#div_professional_prerequisite').css('display', 'block');
        }
        else $('#spn_is_for_professional').html('<b class="cls_colon">:</b>No');

        //$('#txt_start_date').val(row_data["start_date"]);
        if (row_data["start_date"] != '') {
            var temp_date = new Date(row_data["start_date"]);
            $('#spn_start_date').html('<b class="cls_colon">:</b>' + '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
        }

        //$('#txt_end_date').val(row_data["end_date"]);
        if (row_data["end_date"] != '') {
            var temp_date = new Date(row_data["end_date"]);
            $('#spn_end_date').html('<b class="cls_colon">:</b>' + '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
        }

        if (row_data["image_name"].toString() != '')
            $('#spn_courseimage_file_name').html('<b class="cls_colon">:</b><a href="../../WSCourseImageUpload/' + row_data["image_name"] + '" target="_blank" style="text-decoration: underline;">Click To View Image</a>');

        $('#spn_image_source').html('<b class="cls_colon">:</b>' + row_data["image_source"]);

        //$('#spn_inhabitation').html('<b class="cls_colon">:</b>');
        switch (row_data['inhabitation'].toString()) {
            case "1": $('#spn_inhabitation').html('<b class="cls_colon">:</b>Architecture'); break;
            case "2": $('#spn_inhabitation').html('<b class="cls_colon">:</b>Design'); break;
            case "3": $('#spn_inhabitation').html('<b class="cls_colon">:</b>Management'); break;
            case "4": $('#spn_inhabitation').html('<b class="cls_colon">:</b>Planning'); break;
            case "5": $('#spn_inhabitation').html('<b class="cls_colon">:</b>Technology'); break;
        }

        $('#spn_methodology').html('<b class="cls_colon">:</b>' + row_data["methodology"]);

//                $('#ul_course_output').html('');
//                if (row_data["course_output1"].toString() != '') $('#ul_course_output').append('<li>' + row_data["course_output1"] + '</li>');
//                if (row_data["course_output2"].toString() != '') $('#ul_course_output').append('<li>' + row_data["course_output2"] + '</li>');
//                if (row_data["course_output3"].toString() != '') $('#ul_course_output').append('<li>' + row_data["course_output3"] + '</li>');

        if (row_data["course_output1"] != '') {
            var obj_course_output = row_data["course_output1"].split('~');
            for (var i = 0; i < obj_course_output.length; i++) {
                if (obj_course_output[i] == 'Others') {
                    $('#tr_other_course_output').html('Other : '+row_data["course_output2"]);
                    $('#tr_other_course_output').css('display', '');
                }
                else {
                    $('#' + obj_course_output[i]).attr('checked', 'checked');
                } 
            }
        }

        $('#spn_material_for_workshop').html('<b class="cls_colon">:</b>' + row_data["material_for_workshop"]);
        $('#spn_outside_service_rent').html('<b class="cls_colon">:</b>' + row_data["outside_service_rent"]);
        $('#spn_printing_stationary').html('<b class="cls_colon">:</b>' + row_data["printing_stationary"]);

        //$('#spn_travel_arrangement_needed').val(row_data["travel_arrangement_needed"]);
        if (row_data["travel_arrangement_needed"] == 'Y') {
            $('#spn_travel_arrangement_needed').html('<b class="cls_colon">:</b>Yes');
            $('#spn_travel_arrangement_needed_from').html('<b class="cls_colon">:</b>' + row_data["travel_arrangement_needed_from"]);
            $('#spn_travel_arrangement_needed_to').html('<b class="cls_colon">:</b>' + row_data["travel_arrangement_needed_to"]);
            $('#div_travel_arrangement_needed').css('display', 'block');
        }
        else $('#spn_travel_arrangement_needed').html('<b class="cls_colon">:</b>No');

        //$('#spn_is_travel_based_course').val(row_data["is_travel_based_course"]);
        if (row_data["is_travel_based_course"] == 'Y') {
            $('#spn_is_travel_based_course').html('<b class="cls_colon">:</b>Yes');
            $('#spn_is_travel_based_course_from').html('<b class="cls_colon">:</b>' + row_data["is_travel_based_course_from"]);
            $('#spn_is_travel_based_course_to').html('<b class="cls_colon">:</b>' + row_data["is_travel_based_course_to"]);
            $('#div_is_travel_based_course').css('display', 'block');
        }
        else $('#spn_is_travel_based_course').html('<b class="cls_colon">:</b>No');

        if (row_data["accommodation_needed"] == 'Y') $('#spn_accommodation_needed').html('<b class="cls_colon">:</b>Yes');
        else $('#spn_accommodation_needed').html('<b class="cls_colon">:</b>No');

        if (row_data["hotel_accommodation"] == 'Y') $('#spn_hotel_accommodation').html('<b class="cls_colon">:</b>Yes');
        else $('#spn_hotel_accommodation').html('<b class="cls_colon">:</b>No');

        //$('#drp_contract_to_be_done').val(row_data["is_contract_to_be_done"]);
        if (row_data["is_contract_to_be_done"] == 'Y') {
            $('#drp_contract_to_be_done').html('<b class="cls_colon">:</b>Yes');
            $('#spn_contract_to_be_done').html('<b class="cls_colon">:</b>' + row_data["rs_contract_to_be_done"]);
            $('#div_contract_to_be_done').css('display', 'block');
        }
        else $('#drp_contract_to_be_done').html('<b class="cls_colon">:</b>No');

        $('#spn_other_major_expense').html('<b class="cls_colon">:</b>' + row_data["other_major_expense"]);

        $('#spn_material_cost').html('<b class="cls_colon">:</b>' + row_data["material_cost"]);
        $('#spn_food_stay').html('<b class="cls_colon">:</b>' + row_data["food_stay"]);
        $('#spn_local_travel').html('<b class="cls_colon">:</b>' + row_data["local_travel"]);
        $('#spn_total_approx_expense').html('<b class="cls_colon">:</b>' + row_data["approx_expense"]);
        $('#spn_travel_expense').html('<b class="cls_colon">:</b>' + row_data["travel_expense"]);
        $('#spn_total_expense').html('<b class="cls_colon">:</b>' + row_data["total_expense"]);
    }

    $($('.cls_colon').closest('div')).css('padding-left', '0px');
    $('.cls_colon').css('margin-right', '15px');
    $('#btn_show_modal_view').click();

    if (row_data != null) {
        get_course_data(row_data["course_code"], row_data["semester_type"], row_data["year_semester"]);
    }
}

function set_poster_detail(row, row_data) {
    if (row_data != null) {

        $('#td_course_code').html(row_data["course_code"]);
        $('#td_course_credits').html(row_data["course_credits"]);
        $('#td_course_fees').html("-");

        var course_dates = '';
        if (row_data["start_date"] != '') {
            var temp_date = new Date(row_data["start_date"]);
            course_dates += '' + temp_date.format('dd MMM');
        }
        course_dates += ' to ';
        if (row_data["end_date"] != '') {
            var temp_date = new Date(row_data["end_date"]);
            course_dates += '' + temp_date.format('dd MMM');
        }
        $('#td_course_dates').html(course_dates);

        //$('#td_course_duration').html("-");

        if (row_data["available_seat"] != '') $('#td_course_no_of_students').html(row_data["available_seat"]);
        else $('#td_course_no_of_students').html("-");

        //$('#td_course_open_for_professional').html("-");
        //$('#td_course_prerequisite_professional').html("-");
        if (row_data["is_open_for_professional"] == 'Y') {
            $('#td_course_open_for_professional').html('Yes');
            $('#td_course_prerequisite_professional').html(row_data["prerequisite_for_prof"]);
            //$('#div_professional_prerequisite').css('display', 'block');
        }
        else $('#td_course_open_for_professional').html('No');

        $('#td_course_professional_fees').html("-");
        $('#td_course_prerequisite_student').html(row_data["prerequisite"]);
        $('#td_course_location').html(row_data["location"]);
        $('#td_course_expense').html(row_data["approx_expense"] + '/-');
        $('#td_course_students_deliverables').html("-");

        //$('#td_course_faculty').html("-");
        switch (row_data['inhabitation'].toString()) {
            case "1": $('#td_course_faculty').html('FACULTY OF ARCHITECTURE'); break;
            case "2": $('#td_course_faculty').html('FACULTY OF DESIGN'); break;
            case "3": $('#td_course_faculty').html('FACULTY OF MANAGEMENT'); break;
            case "4": $('#td_course_faculty').html('FACULTY OF PLANNING'); break;
            case "5": $('#td_course_faculty').html('FACULTY OF TECHNOLOGY'); break;
        }


        $('#div_course_title').html('<b>' + row_data["course_name"] + '</b>');

        if (row_data["image_name"].toString() != '')
            $('#img_course_image').attr('src', '../../WSCourseImageUpload/' + row_data["image_name"]);
        //$('#spn_courseimage_file_name').html('<b class="cls_colon">:</b><a href="../../WSCourseImageUpload/' + row_data["image_name"] + '" target="_blank" style="text-decoration: underline;">Click To View Image</a>');

        $('#div_course_desc').html(row_data["course_desc"]);

        /////////////////////////////////////


        set_course_instructor_workplan_detail(row_data["course_code"]);

        $('#spn_category_location_wise').html('<b class="cls_colon">:</b>' + row_data["category_location_wise"]);
                
        $('#spn_course_description').html(row_data["course_desc"]);
                
        $('#spn_image_source').html('<b class="cls_colon">:</b>' + row_data["image_source"]);

        $('#spn_methodology').html('<b class="cls_colon">:</b>' + row_data["methodology"]);

        $('#ul_course_output').html('');
        if (row_data["course_output1"].toString() != '') $('#ul_course_output').append('<li>' + row_data["course_output1"] + '</li>');
        if (row_data["course_output2"].toString() != '') $('#ul_course_output').append('<li>' + row_data["course_output2"] + '</li>');
        if (row_data["course_output3"].toString() != '') $('#ul_course_output').append('<li>' + row_data["course_output3"] + '</li>');


        $('#spn_material_for_workshop').html('<b class="cls_colon">:</b>' + row_data["material_for_workshop"]);
        $('#spn_outside_service_rent').html('<b class="cls_colon">:</b>' + row_data["outside_service_rent"]);

        //$('#spn_travel_arrangement_needed').val(row_data["travel_arrangement_needed"]);
        if (row_data["travel_arrangement_needed"] == 'Y') {
            $('#spn_travel_arrangement_needed').html('<b class="cls_colon">:</b>Yes');
            $('#spn_travel_arrangement_needed_from').html('<b class="cls_colon">:</b>' + row_data["travel_arrangement_needed_from"]);
            $('#spn_travel_arrangement_needed_to').html('<b class="cls_colon">:</b>' + row_data["travel_arrangement_needed_to"]);
            $('#div_travel_arrangement_needed').css('display', 'block');
        }
        else $('#spn_travel_arrangement_needed').html('<b class="cls_colon">:</b>No');

        //$('#spn_is_travel_based_course').val(row_data["is_travel_based_course"]);
        if (row_data["is_travel_based_course"] == 'Y') {
            $('#spn_is_travel_based_course').html('<b class="cls_colon">:</b>Yes');
            $('#spn_is_travel_based_course_from').html('<b class="cls_colon">:</b>' + row_data["is_travel_based_course_from"]);
            $('#spn_is_travel_based_course_to').html('<b class="cls_colon">:</b>' + row_data["is_travel_based_course_to"]);
            $('#div_is_travel_based_course').css('display', 'block');
        }
        else $('#spn_is_travel_based_course').html('<b class="cls_colon">:</b>No');

        if (row_data["accommodation_needed"] == 'Y') $('#spn_accommodation_needed').html('<b class="cls_colon">:</b>Yes');
        else $('#spn_accommodation_needed').html('<b class="cls_colon">:</b>No');

        if (row_data["hotel_accommodation"] == 'Y') $('#spn_hotel_accommodation').html('<b class="cls_colon">:</b>Yes');
        else $('#spn_hotel_accommodation').html('<b class="cls_colon">:</b>No');

        //$('#drp_contract_to_be_done').val(row_data["is_contract_to_be_done"]);
        if (row_data["is_contract_to_be_done"] == 'Y') {
            $('#drp_contract_to_be_done').html('<b class="cls_colon">:</b>Yes');
            $('#spn_contract_to_be_done').html('<b class="cls_colon">:</b>' + row_data["rs_contract_to_be_done"]);
            $('#div_contract_to_be_done').css('display', 'block');
        }
        else $('#drp_contract_to_be_done').html('<b class="cls_colon">:</b>No');

        $('#spn_other_major_expense').html('<b class="cls_colon">:</b>' + row_data["other_major_expense"]);

        $('#spn_material_cost').html('<b class="cls_colon">:</b>' + row_data["material_cost"]);
        $('#spn_food_stay').html('<b class="cls_colon">:</b>' + row_data["food_stay"]);
        $('#spn_local_travel').html('<b class="cls_colon">:</b>' + row_data["local_travel"]);
        //$('#spn_total_approx_expense').html('<b class="cls_colon">:</b>' + row_data["approx_expense"]);
        $('#spn_travel_expense').html('<b class="cls_colon">:</b>' + row_data["travel_expense"]);
        $('#spn_total_expense').html('<b class="cls_colon">:</b>' + row_data["total_expense"]);
    }

    $('#tbl_poster_dtl tbody tr td').css('color', 'white');
    $('#tbl_poster_dtl tbody tr td').css('text-align', 'right');
    $('#tbl_poster_dtl tbody tr td').css('line-height', '12px');

    $('#tbl_poster_dtl tbody tr td.cls_td_title').css('font-size', '9px');
    $('#tbl_poster_dtl tbody tr td.cls_td_title').css('font-weight', 'bold');
    $('#tbl_poster_dtl tbody tr td.cls_td_title').css('padding', '10px 1px 0px 1px');

    $('#tbl_poster_dtl tbody tr td.cls_td_course_dtl').css('font-size', '9px');
    $('#tbl_poster_dtl tbody tr td.cls_td_course_dtl').css('padding', '0px 1px');

    $('#btn_show_modal_view_poster').click();
}

function set_course_instructor_workplan_detail(course_code) {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_all_ws_course_proposal_data",
        //async: false,
        data: "{course_code:'" + course_code + "',sem_code : '" + semester + "',year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {

            $("#tblinstructor tbody").html('');
            if (data.d[1] != null) {

                $("#tblinstructor tbody").html('');
                var course_instructor_data = JSON.parse(data.d[1]);

                for (var i = 0; i < course_instructor_data.length; i++) {
                    $('#drp_instructor_list').val(course_instructor_data[i]["instructor_code"]);

                    var str = "<tr><td>" + $('#drp_instructor_list')[0].selectedOptions[0].innerHTML.trim() + "</td><td>" + course_instructor_data[i]["contact_hrs"] + "</td></tr>";

                    $('#tblinstructor tbody').append(str);
                }

                $('#drp_instructor_list').val('');

                $('#tblinstructor thead th').css('line-height', '12px');
                $('#tblinstructor tbody td').css('line-height', '12px');
            }

            $("#tbl_workplan tbody").html('');
            if (data.d[2] != null) {

                $("#tbl_workplan tbody").html('');
                var course_workplan_data = JSON.parse(data.d[2]);

                for (var i = 0; i < course_workplan_data.length; i++) {
                    var temp_workplan_date = '';
                    var temp_date;
                    if (course_workplan_data[i]["workplan_date"] != '') {
                        temp_date = new Date(course_workplan_data[i]["workplan_date"]);
                        temp_workplan_date = '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                    }

                    $('#drp_instructor_list').val(course_workplan_data[i]["faculty_involve"]);

                    var str_tbody = '<tr id="' + temp_date + '"><td>Day' + (i + 1) + '</td>' +
                            '<td class="cls_workplan_date">' + temp_workplan_date + '</td>' +
                            '<td><span class="ui-timepicker-input">' + course_workplan_data[i]["from_time"] + '</span> - <span class="ui-timepicker-input">' + course_workplan_data[i]["To_time"] + '</span></td>' +
                            '<td>' + course_workplan_data[i]["topic_covered"] + '</td>' +
                            '<td>' + course_workplan_data[i]["methodology"] + '</td>' +
                            '<td><span class="cls_total_hrs">' + course_workplan_data[i]["no_of_hrs"] + '</span></td>' +
                            '<td><span class="cls_faculty_involve">' + $('#drp_instructor_list')[0].selectedOptions[0].innerHTML.trim() + '</span></td></tr>';

                    $('#tbl_workplan tbody').append(str_tbody);
                }

                $('#drp_instructor_list').val('');

                calcTotalHour();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function calcTotalHour() {
    var total_hour = 0;
    var total_min = 0;

    for (var i = 0; i < $('.ui-timepicker-input').length; i = i + 2) {

        if ($('.ui-timepicker-input')[i].innerHTML != '' && $('.ui-timepicker-input')[i + 1].innerHTML != '') {
            var temp_from = convertTime($('.ui-timepicker-input')[i].innerHTML);
            var temp_to = convertTime($('.ui-timepicker-input')[i + 1].innerHTML);
            var cur_tr = $('.ui-timepicker-input')[i].closest('tr');

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

            if (timediff_m >= 60) {
                timediff_h = timediff_h + 1;
                timediff_m = timediff_m - 60;
            }

            //cur_tr.getElementsByClassName('cls_total_hrs')[0].innerHTML = "" + timediff_h + "." + timediff_m + "";
        }
    }

    if (total_min >= 60) {
        total_hour = total_hour + 1;
        total_min = total_min - 60;
    }

    $('#td_total_contact_hrs').html("" + total_hour + "." + total_min);
    $('#td_duration_in_days').html("" + $('#tbl_workplan tbody tr').length);
    $('#td_course_duration').html("" + $('#tbl_workplan tbody tr').length + " Days");
    calc_faculty_workplan_total();
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

function calc_faculty_workplan_total() {
    $('#tbl_workplan_faculty_total thead').html('');
    if ($('#tbl_workplan tbody tr').length > 0) {
        var options_total_workload = {};

        for (var i = 0; i < $('#tblinstructor tbody tr').length; i++) {
            if ($('#tblinstructor tbody tr')[i].children[0].innerHTML != '') {
                options_total_workload[$('#tblinstructor tbody tr')[i].children[0].innerHTML] = 0;
            }
        }

        $('#tbl_workplan tbody tr').each(function (i) {
            if ($(this).find('.cls_faculty_involve').html() != '' && parseFloat($(this).find('.cls_total_hrs').html()).toString() != 'NaN') {
                options_total_workload[$(this).find('.cls_faculty_involve').html()] += parseFloat($(this).find('.cls_total_hrs').html());
            }
        });

        for (var i = 0; i < $('#tblinstructor tbody tr').length; i++) {
            if ($('#tblinstructor tbody tr')[i].children[0].innerHTML != '') {
                $('#tbl_workplan_faculty_total thead').append('<tr><td>Workload of ' + $('#tblinstructor tbody tr')[i].children[0].innerHTML + '</td><td>&nbsp;:&nbsp;</td><td>' + options_total_workload[$('#tblinstructor tbody tr')[i].children[0].innerHTML] + '</td></tr>');
            }
        }
    }
}


function get_course_data(course_code, sem_code, year_code) {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_all_ws_course_proposal_data",
        async: false,
        data: "{course_code:'" + course_code + "',sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d[1] != null) {

                var course_instructor_data = JSON.parse(data.d[1]);

                for (var i = 0; i < course_instructor_data.length; i++) {
                    $('#div_desc_faculty' + (i + 1)).css('display', 'block');

                    //$('#txt_desc_faculty' + (i + 1)).val(course_instructor_data[i]["instructor_desc"]);
                    $('#txt_desc_faculty' + (i + 1)).parent().html(course_instructor_data[i]["instructor_desc"]);

                    //$('#drp_based_in_ahmedabad' + (i + 1)).val(course_instructor_data[i]["based_in_ahmedabad"]);
                    if (course_instructor_data[i]["based_in_ahmedabad"] == 'Y') $('#drp_based_in_ahmedabad' + (i + 1)).parent().html('Yes');
                    else if (course_instructor_data[i]["based_in_ahmedabad"] == 'N') $('#drp_based_in_ahmedabad' + (i + 1)).parent().html('No');
                    else $('#drp_based_in_ahmedabad' + (i + 1)).parent().parent().css('display','none');

                    if (course_instructor_data[i]["based_in_ahmedabad"] == 'N') {
                        $('.cls_travel_accomodation' + (i + 1)).css('display', 'block');
                    }

                    //$('#drp_is_travel_based_course' + (i + 1)).val(course_instructor_data[i]["is_travel_based_course"]);
                    if (course_instructor_data[i]["is_travel_based_course"] == 'Y') $('#drp_is_travel_based_course' + (i + 1)).parent().html('Yes');
                    else if (course_instructor_data[i]["is_travel_based_course"] == 'N') $('#drp_is_travel_based_course' + (i + 1)).parent().html('No');
                    else $('#drp_is_travel_based_course' + (i + 1)).parent().parent().css('display', 'none');

                    if (course_instructor_data[i]["is_travel_based_course"] == 'Y') {
                        $('#txt_is_travel_based_course_from' + (i + 1)).html(course_instructor_data[i]["is_travel_based_course_from"]);
                        $('#txt_is_travel_based_course_to' + (i + 1)).html(course_instructor_data[i]["is_travel_based_course_to"]);

                        $('#div_is_travel_based_course' + (i + 1)).css('display', 'block');
                    }

                    //$('#drp_accommodation_needed' + (i + 1)).val(course_instructor_data[i]["accommodation_needed"]);
                    if (course_instructor_data[i]["accommodation_needed"] == 'Y') $('#drp_accommodation_needed' + (i + 1)).parent().html('Yes');
                    else if (course_instructor_data[i]["accommodation_needed"] == 'N') $('#drp_accommodation_needed' + (i + 1)).parent().html('No');
                    else $('#drp_accommodation_needed' + (i + 1)).parent().parent().css('display', 'none');

                    if (course_instructor_data[i]["accommodation_needed"] == 'Y') {
                        if (course_instructor_data[i]["accommodation_needed_from_date"] != '') {
                            var temp_date = new Date(course_instructor_data[i]["accommodation_needed_from_date"]);
                            $('#txt_accomodation_from_date' + (i + 1)).html('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        if (course_instructor_data[i]["accommodation_needed_to_date"] != '') {
                            var temp_date = new Date(course_instructor_data[i]["accommodation_needed_to_date"]);
                            $('#txt_accomodation_to_date' + (i + 1)).html('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        $('#txt_accomodation_total_days' + (i + 1)).html(course_instructor_data[i]["accommodation_needed_total_days"]);
                        
                        $('#div_is_accomodation_needed' + (i + 1)).css('display', 'block');
                    }
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}
