var oTable;
var oTable1;
var sem_data = '';

var course_seat_data = '';

var asInitVals = new Array();

var prog_code = $('#drpprog').val();
var prog_level_code = $('#drpproglevel').val();

function bindyeardata() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_year_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d);

                $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                for (var i = 0; i < year_data.length; i++) {
                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindyallcourse() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_course_data",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d);

                $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));

                for (var i = 0; i < year_data.length; i++) {
                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();
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

                $('#drpinstructor').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                for (var i = 0; i < instructor_data.length; i++) {

                    $('#drpinstructor').append($("<option></option>").val(instructor_data[i]["instructor_code"]).html(instructor_data[i]["instructor_name"]));
                }

                $('#drpinstructor').chosen();
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

function bindallstudentdata() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_student_data",
        data: "{year_code:'' ,dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var data = JSON.parse(data.d)

                $('#drpstudent').empty().append($("<option></option>").val("").html("-- Please Select Student --"));

                for (var i = 0; i < data.length; i++) {
                    $('#drpstudent').append($("<option></option>").val(data[i]["user_id"]).html(data[i]["user_id"]));
                }

                $('#drpstudent').chosen();
                $('#drpstudent').trigger("liszt:updated");
            }
            else {
                $('#drpstudent').find('option').remove().end().append('<option value="">No Student found</option>').val('');
                $('#drpstudent').chosen();
                $('#drpstudent').val('').trigger("liszt:updated");
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindallstudentdataforprintpayslip() {
    if ($('#drpdepartment').val() == "") {
        bootbox.alert("Please select department.");
        return false;
    }

    if ($('#drpprog').val() == "") {
        bootbox.alert("Please select program.");
        return false;
    }

    if ($('#drpprog').val() == "") {
        bootbox.alert("Please select program.");
        return false;
    }

    if ($('#drpyear').val() == "") {
        bootbox.alert("Please select year of enrollement.");
        return false;
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_student_data",
        data: "{year_code:'" + $('#drpyear').val() + "' ,dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var data = JSON.parse(data.d)

                $('#drpstudent').empty().append($("<option></option>").val("").html("-- Please Select Student --"));

                for (var i = 0; i < data.length; i++) {
                    $('#drpstudent').append($("<option></option>").val(data[i]["user_id"]).html(data[i]["user_id"]));
                }

                $('#drpstudent').chosen();
                $('#drpstudent').trigger("liszt:updated");
            }
            else {
                $('#drpstudent').find('option').remove().end().append('<option value="">No Student found</option>').val('');
                $('#drpstudent').chosen();
                $('#drpstudent').val('').trigger("liszt:updated");
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

    $('#drpprog').chosen();
}

function bindsemdata() {
    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

    //for (var i = 0; i < sem_data.length; i++) {
    //    $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));
    //}

    $('#drpsemester').chosen();
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
                var sem_data = JSON.parse(data.d)

                $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));

                for (var i = 0; i < sem_data.length; i++) {
                    $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));
                }

                $('#drpsemester').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function binddepartment() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",
        data: "{}",
        dataType: "json",
        async: false,
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

function bindproglevel() {
    //$('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
    //$('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
    //$('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_program_level_data_rights_wise",
        data: "{}",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var prog_level_data = JSON.parse(data.d);

                $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                for (var i = 0; i < prog_level_data.length; i++) {
                    $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                }

                //if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                $('#drpproglevel').chosen();
                //}
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}
/// Returned By Ananth ///
function bind_student_course_allocated_report() {
    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    var prog_code = $('#drpprog').val();
    var prog_level_code = $('#drpproglevel').val();
    var course_code = $("#drcourses").val();


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_allocate_course_data",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',course_code:'" + course_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));

                for (var i = 0; i < year_data.length; i++) {
                    if (i == 0) {
                        $('#drcourses').append($("<option></option>").val(year_data[i]["new_course_code"]).html(year_data[i]["new_course_code"]));
                    }
                    else {
                        if (year_data[i]["new_course_code"] != year_data[i - 1]["new_course_code"])
                            $('#drcourses').append($("<option></option>").val(year_data[i]["new_course_code"]).html(year_data[i]["new_course_code"]));
                    }
                }

                $('#drcourses').chosen();
                $('#drcourses').trigger("liszt:updated");
            }
            else {
                $('#drcourses')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Course found</option>')
                    .val('');
                $('#drcourses').chosen();

                $('#drcourses').val('').trigger("liszt:updated");
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function total_selected_course() {
    $('#DataList').css('display', 'none');
    $('#btn_assign').css('display', 'none');
    $('#btn_assign2').css('display', 'none');
    //$('#btn_remove').css('display', 'none');
    $('#btn_assign3').css('display', 'none');
    $('#btn_delete').css('display', 'none');
    $('#btn_publish').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }
    var CFPCode = '';
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_saved_selected_course_data_for_report",
            data: "{sem_code:'" + semester + "' , year_code :'" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    display_total_selected_course_data(data.d);
                }
                else {
                    bootbox.alert('There is no registered course data found for selected semester');
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function remove_data() {
    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year = $('#drpyear').val();
    if (year == "") {
        bootbox.alert('Please select year')
        $('#drpyear').focus();
        return false;
    }

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/remove_all_allocate_data",
            data: "{sem_code: '" + semester + "',year_code:'" + year + "'}",
            dataType: "json",
            success: function (data) {
                bootbox.alert(data.d);
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function display_total_selected_course_data(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    var page = true;

    oTable = $("#example").dataTable({
        "bPaginate": page,
        "bStateSave": false,
        "bSort": false,
        "iDisplayLength": 60,
        "sDom": 'b',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //    "oTableTools": {
        //        "aButtons": [
        //"copy",
        //"print",
        //{
        //    "sExtends": "collection",
        //    "sButtonText": 'Export',
        //    "aButtons": ["xls", "pdf"]
        //}
        //        ]
        //    },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Course Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Available Seat", "mData": "available_seat", "bSortable": false },
            { "sTitle": "Mandatory", "mData": "mandatory", "bSortable": false },
            { "sTitle": "Elective", "mData": "elective", "bSortable": false }
        ]
    });

    //var oTableTools = new TableTools(oTable, {
    //  "buttons": [
    //      "copy",
    //      "xls",
    //	"pdf", 
    //	{ "type": "print", "buttonText": "Print me!" }
    //]
    //});

    //$('#demo').before(oTableTools.dom.container);
    $('#DataList').css('display', 'block');
    $('#btn_assign').css('display', 'block');
    $('#btn_assign2').css('display', 'block');
    //$('#btn_remove').css('display', 'block');
    //$('#btn_assign3').css('display', 'block');
    $('#btn_delete').css('display', 'block');
    $('#btn_publish').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function save_data() {
    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            //url: "../../WebService.asmx/Save_assign_course_dtl",
            url: "../../WebService.asmx/Save_assign_course_dtl_for_logic2",
            timeout: 2 * 60 * 60 * 1000,
            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var split_data = data.d.split(":");

                    if (data.d == "already") {
                        bootbox.alert('Course Allocation is already completed for this semester and year');
                        return false;
                    }

                    if (split_data[0] == "available_seat") {
                        bootbox.alert('total course selection is grater than available seat for course code : ' + split_data[1]);
                        return false;
                    }

                    bootbox.alert(data.d);

                    $('#DataList').css('display', 'none');
                    $('#btn_assign').css('display', 'none');
                    $('#btn_assign2').css('display', 'none');
                    //$('#btn_remove').css('display', 'none');
                    $('#btn_assign3').css('display', 'none');
                    $('#btn_delete').css('display', 'none');
                    $('#btn_publish').css('display', 'none');
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

// for Logic 2
function save_data_logic2() {
    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Save_assign_course_dtl_for_logic4",
            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var split_data = data.d.split(":");

                    if (data.d == "already") {
                        bootbox.alert('Course Allocation is already completed for this semester and year');
                        return false;
                    }

                    if (split_data[0] == "available_seat") {
                        bootbox.alert('total course selection is grater than available seat for course code : ' + split_data[1]);
                        return false;
                    }

                    bootbox.alert(data.d);

                    $('#DataList').css('display', 'none');
                    $('#btn_assign').css('display', 'none');
                    $('#btn_assign2').css('display', 'none');
                    //$('#btn_remove').css('display', 'none');
                    $('#btn_assign3').css('display', 'none');
                    $('#btn_delete').css('display', 'none');
                    $('#btn_publish').css('display', 'none');
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function save_data_logic3() {
    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Save_assign_course_dtl_for_logic3",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var split_data = data.d.split(":");

                if (data.d == "already") {
                    bootbox.alert('Course Allocation is already completed for this semester and year');
                    return false;
                }

                if (split_data[0] == "available_seat") {
                    bootbox.alert('total course selection is grater than available seat for course code : ' + split_data[1]);
                    return false;
                }

                bootbox.alert(data.d);

                $('#DataList').css('display', 'none');
                $('#btn_assign').css('display', 'none');
                $('#btn_assign2').css('display', 'none');
                //$('#btn_remove').css('display', 'none');
                //$('#btn_assign3').css('display', 'none');
                $('#btn_delete').css('display', 'none');
                $('#btn_publish').css('display', 'none');
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function publish_allocation_data() {
    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/publish_allocation_data",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var split_data = data.d.split(":");

                if (data.d == "already") {
                    bootbox.alert('Course Allocation is already published for this semester and year');
                    return false;
                }

                bootbox.alert(data.d);

                $('#DataList').css('display', 'none');
                $('#btn_assign').css('display', 'none');
                $('#btn_assign2').css('display', 'none');
                //$('#btn_remove').css('display', 'none');
                //$('#btn_assign3').css('display', 'none');
                $('#btn_delete').css('display', 'none');
                $('#btn_publish').css('display', 'none');
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function total_course_allocat() {

    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    //var year_code = $('#drpyear').val();
    //if (year_code == "") {
    //    bootbox.alert('Please select Year')
    //    $('#drpyear').focus();
    //    return false;
    //}

    var dept_code = $('#drpdepartment').val();
    var prog_code = $('#drpprog').val();
    var prog_level_code = $('#drpproglevel').val();
    var course_code = $("#drcourses").val();


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_allocate_course_data",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',course_code:'" + course_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                display_student_Course_allocation(data.d);
            }
            else {
                bootbox.alert('There is No data Found For Selected Semester or Year');
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function display_student_Course_allocation(data) {
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
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //		"print",
        //    	{
        //    	    "sExtends": "collection",
        //    	    "sButtonText": 'Export',
        //    	    "aButtons": ["xls"]
        //    	}
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": false },
            //{ "sTitle": "Course Name", "mData": "course_name","bSortable": false, "bVisible": false },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },
            { "sTitle": "Course Credits", "mData": "course_credits", "bSortable": false },
            { "sTitle": "Priority", "mData": "priority", "bSortable": false },
            { "sTitle": "Selection Type", "mData": "studio_type", "bSortable": false }
        ]

        //"fnDrawCallback": function (oSettings) {
        //    if (oSettings.aiDisplay.length == 0) {
        //        return;
        //    }
        //    var nTrs = $('tbody tr', oSettings.nTable);
        //    var iColspan = nTrs[0].getElementsByTagName('td').length;
        //    var sLastGroup = "";
        //    for (var i = 0; i < nTrs.length; i++) {
        //        var iDisplayIndex = oSettings._iDisplayStart + i;
        //        var sGroup = oSettings.aoData[i]._aData["course_code"];
        //        var sGroup1 = oSettings.aoData[i]._aData["course_name"];
        //        //  alert(sGroup);
        //        //  alert(sGroup["FIM_Code"]);
        //        // alert(JSON.parse(sGroup));
        //        //var sGroup = '100021';
        //        if (sGroup != sLastGroup) {
        //            var nGroup = document.createElement('tr');
        //            var nCell = document.createElement('td');
        //            nCell.colSpan = iColspan;
        //            nCell.className = "group";
        //            nCell.innerHTML = sGroup + ' - ' + sGroup1;
        //            // nCell.innerHTML = sGroup;
        //            nGroup.appendChild(nCell);
        //            nTrs[i].parentNode.insertBefore(nGroup, nTrs[i]);
        //            sLastGroup = sGroup;
        //        }
        //    }
        //}
    }).rowGrouping();

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function total_course_Register() {
    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_registered_course_data_for_report",
        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                display_student_Course_registered_data(data.d);
            }
            else {
                bootbox.alert('There is No data Found For Selected Semester or Year');
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function display_student_Course_registered_data(data) {
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
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        //    "oTableTools": {
        //        "aButtons": [
        //            //"copy",
        //"print",
        //        	{
        //        	    "sExtends": "collection",
        //        	    "sButtonText": 'Export',
        //        	    "aButtons": ["xls"]
        //        	}
        //        ]
        //    },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": false },
            //{ "sTitle": "Course Name", "mData": "course_name","bSortable": false, "bVisible": false },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },
            { "sTitle": "Priority", "mData": "priority", "bSortable": false },
            { "sTitle": "Selection Type", "mData": "studio_type", "bSortable": false }
        ]

        //"fnDrawCallback": function (oSettings) {
        //    if (oSettings.aiDisplay.length == 0) {
        //        return;
        //    }
        //    var nTrs = $('tbody tr', oSettings.nTable);
        //    var iColspan = nTrs[0].getElementsByTagName('td').length;
        //    var sLastGroup = "";
        //    for (var i = 0; i < nTrs.length; i++) {
        //        var iDisplayIndex = oSettings._iDisplayStart + i;
        //        var sGroup = oSettings.aoData[i]._aData["course_code"];
        //        var sGroup1 = oSettings.aoData[i]._aData["course_name"];
        //        //  alert(sGroup);
        //        //  alert(sGroup["FIM_Code"]);
        //        // alert(JSON.parse(sGroup));
        //        //var sGroup = '100021';
        //        if (sGroup != sLastGroup) {
        //            var nGroup = document.createElement('tr');
        //            var nCell = document.createElement('td');
        //            nCell.colSpan = iColspan;
        //            nCell.className = "group";
        //            nCell.innerHTML = sGroup + ' - ' + sGroup1;
        //            // nCell.innerHTML = sGroup;
        //            nGroup.appendChild(nCell);
        //            nTrs[i].parentNode.insertBefore(nGroup, nTrs[i]);
        //            sLastGroup = sGroup;
        //        }
        //    }
        //}
    }).rowGrouping();

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function get_current_sem_data_for_student() {

}

function change_student_current_sem() {
    $('#DataList').css('display', 'none');
    $('#btnsave').css('display', 'none');

    //var semester = $('#drpsemester').val();
    //if (semester == "") {
    //    bootbox.alert('Please select semester')
    //    $('#drpsemester').focus();
    //    return false;
    //}

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select department')
        $('#drpdepartment').focus();
        return false;
    }

    var prog = $('#drpprog').val();
    if (prog == "") {
        bootbox.alert('Please select Programme')
        $('#drpprog').focus();
        return false;
    }

    dept_code = $('#drpdepartment').val();

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_student_data",
        data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_current_sem_data_for_student",
                    async: false,
                    //data: "{sem_code: '" + semester + "',year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
                    data: "{sem_code: '',year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            sem_data = JSON.parse(data.d);
                        }
                        else {
                            sem_data = '';
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                //if (semester == 'M') {
                display_current_sem_data_new(data.d);
                //}

                //if (semester == 'S') {
                //    display_spring_current_sem_data(data.d);
                //}
            }
            else {
                bootbox.alert('There is No data Found For Selected Semester or Year');
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function display_monsoon_current_sem_data(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    var listItems = '<select class="sem_parent">';
    listItems += "<option value='0'>---Select---</option>";
    listItems += "<option value='1'>Semester1</option>";
    listItems += "<option value='3'>Semester3</option>";
    listItems += "<option value='5'>Semester5</option>";
    listItems += "<option value='7'>Semester7</option>";
    listItems += "<option value='9'>Semester9</option>";
    listItems += '</select>';

    oTable = $("#example").dataTable({
        "bPaginate": false,
        "bStateSave": true,
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
                //{
                //    "sExtends": "collection",
                //    "sButtonText": 'Export',
                //    "aButtons": ["xls", "pdf"]
                //}
            ]
        },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "student_no", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            {
                "sTitle": listItems + "Select for all", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    var listItems = '<select class="sem_child">';
                    listItems += "<option value='0'>---Select---</option>";
                    listItems += "<option value='1'>Semester1</option>";
                    listItems += "<option value='3'>Semester3</option>";
                    listItems += "<option value='5'>Semester5</option>";
                    listItems += "<option value='7'>Semester7</option>";
                    listItems += "<option value='9'>Semester9</option>";
                    listItems += '</select>';
                    return listItems;
                }
            }
        ]
    });

    if (sem_data != '') {
        $("#example thead tr").each(function (j) {
            if (sem_data[0]["parent_sem_code"] != "0") {
                $(this).find('.sem_parent').val(sem_data[0]["parent_sem_code"]);
            }
        });

        $("#example tbody tr").each(function (i) {
            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            if (a["user_id"] == "student31") {

            }

            for (var j = 0; j < sem_data.length; j++) {
                if (sem_data[j]["student_id"] == a["user_id"]) {
                    if (sem_data[j]["semester_code"] != "0") {
                        $(this).find('.sem_child').val(sem_data[j]["semester_code"]);
                        break;
                    }
                }
                else {
                    $(this).find('.sem_child').val(0);
                }
            }
        });
    }

    $('#DataList').css('display', 'block');
    $('#btnsave').css('display', 'block');

    return false;
}

function display_current_sem_data_new(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    var listItems = '<select class="sem_parent">';
    listItems += "<option value='0'>---Select---</option>";
    listItems += "<option value='1'>Semester1</option>";
    listItems += "<option value='2'>Semester2</option>";
    listItems += "<option value='3'>Semester3</option>";
    listItems += "<option value='4'>Semester4</option>";
    listItems += "<option value='5'>Semester5</option>";
    listItems += "<option value='6'>Semester6</option>";
    listItems += "<option value='7'>Semester7</option>";
    listItems += "<option value='8'>Semester8</option>";
    listItems += "<option value='9'>Semester9</option>";
    listItems += "<option value='10'>Semester10</option>";
    listItems += '</select>';

    oTable = $("#example").dataTable({
        "bPaginate": false,
        "bStateSave": true,
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
                //{
                //    "sExtends": "collection",
                //    "sButtonText": 'Export',
                //    "aButtons": ["xls", "pdf"]
                //}
            ]
        },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "student_no", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            {
                "sTitle": listItems + "Select for all", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    var listItems = '<select class="sem_child">';

                    listItems += "<option value='0'>---Select---</option>";
                    listItems += "<option value='1'>Semester1</option>";
                    listItems += "<option value='2'>Semester2</option>";
                    listItems += "<option value='3'>Semester3</option>";
                    listItems += "<option value='4'>Semester4</option>";
                    listItems += "<option value='5'>Semester5</option>";
                    listItems += "<option value='6'>Semester6</option>";
                    listItems += "<option value='7'>Semester7</option>";
                    listItems += "<option value='8'>Semester8</option>";
                    listItems += "<option value='9'>Semester9</option>";
                    listItems += "<option value='10'>Semester10</option>";
                    listItems += '</select>';

                    return listItems;
                }
            }
        ]
    });

    if (sem_data != '') {
        $("#example thead tr").each(function (j) {
            if (sem_data[0]["parent_sem_code"] != "0") {
                $(this).find('.sem_parent').val(sem_data[0]["parent_sem_code"]);
            }
        });

        $("#example tbody tr").each(function (i) {
            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            if (a["user_id"] == "student31") {

            }

            for (var j = 0; j < sem_data.length; j++) {
                if (sem_data[j]["student_id"] == a["user_id"]) {
                    if (sem_data[j]["semester_code"] != "0") {
                        $(this).find('.sem_child').val(sem_data[j]["semester_code"]);
                        break;
                    }
                }
                else {
                    $(this).find('.sem_child').val(0);
                }
            }
        });
    }

    $('#DataList').css('display', 'block');
    $('#btnsave').css('display', 'block');

    return false;
}

function display_spring_current_sem_data(data) {
    // alert(data);

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }


    var listItems = '<select class="sem_parent">';
    listItems += "<option value='0'>---Select---</option>";
    listItems += "<option value='2'>Semester2</option>";
    listItems += "<option value='4'>Semester4</option>";
    listItems += "<option value='6'>Semester6</option>";
    listItems += "<option value='8'>Semester8</option>";
    listItems += "<option value='10'>Semester10</option>";
    listItems += '</select>';

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
                //							    "copy",
                //							    "print",
                //							    {
                //							        "sExtends": "collection",
                //							        "sButtonText": 'Export',
                //							        "aButtons": ["xls", "pdf"]
                //							    }
            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "student_no", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },

            {
                "sTitle": listItems + "Select for all",
                "bSortable": false,
                "mData": null,

                fnRender: function (oObj) {

                    var listItems = '<select class="sem_child">';
                    listItems += "<option value='0'>---Select---</option>";
                    listItems += "<option value='2'>Semester2</option>";
                    listItems += "<option value='4'>Semester4</option>";
                    listItems += "<option value='6'>Semester6</option>";
                    listItems += "<option value='8'>Semester8</option>";
                    listItems += "<option value='10'>Semester10</option>";
                    listItems += '</select>';
                    return listItems;



                }
            }


        ]


    });

    if (sem_data != '') {

        $("#example thead tr").each(function (j) {

            if (sem_data[0]["parent_sem_code"] != "0") {
                $(this).find('.sem_parent').val(sem_data[0]["parent_sem_code"]);
            }
        });


        $("#example tbody tr").each(function (i) {



            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];



            for (var j = 0; j < sem_data.length; j++) {

                if (sem_data[j]["student_id"] == a["user_id"]) {



                    if (sem_data[j]["semester_code"] != "0") {

                        $(this).find('.sem_child').val(sem_data[j]["semester_code"]);
                    }
                }
            }



        });

    }





    $('#DataList').css('display', 'block');
    $('#btnsave').css('display', 'block');

    return false;

}

$(document).on("change", ".sem_parent", function (event) {
    var val = $(this).val();

    $("#example tbody tr").each(function (j) {
        $(this).find(".sem_child").val(val);
    });
});

function save_current_sem() {

    var current_sem_data = [];
    var parent_sem = '';

    $("#example thead tr").each(function (j) {
        parent_sem = $(this).find(".sem_parent").val();
    });

    $("#example tbody tr").each(function (i) {

        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];


        var obj = {};

        obj["student_code"] = $(this).children().eq(0).html();
        obj["user_id"] = a['user_id'];
        obj["sem_code"] = $(this).find(".sem_child").val();
        obj["parent_sem_code"] = parent_sem;
        obj["year_code"] = $('#drpyear').val();
        obj["dept_code"] = $('#drpdepartment').val();
        obj["prog_code"] = $('#drpprog').val();
        current_sem_data.push(obj);

    });

    var data = JSON.stringify({ current_sem_data: JSON.stringify(current_sem_data) });

    $.ajax({
        type: "POST",
        url: "../../WebService.asmx/save_student_current_sem",
        data: data,
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            bootbox.alert("Data Saved Succesfully");
            // DisplayData(data.d);
            $('#btnsave').css("display", "none");
            $('#DataList').css("display", "none");


        },
        error: function (msg) { alert(msg.d); }
    });



}


function get_seat_dtl_for_course() {
    $('#DataList').css('display', 'none');

    $('#btnsave').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select department')
        $('#drpdepartment').focus();
        return false;
    }

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_seats_dtl_of_course",

            data: "{sem_code:'" + semester + "' , dept_code :'" + dept_code + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {




                if (data.d != "") {


                    course_seat_data = JSON.parse(data.d);

                    display_course_seat_data(data.d);

                }
                else {

                    course_seat_data = '';
                    bootbox.alert('There is no course data found for Selected Semester');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function display_course_seat_data(data) {


    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        // "iDisplayLength": 60,
        "sDom": 't',
        //      "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },

        "oTableTools": {
            "aButtons": [

            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },

            {
                "sTitle": "Available Seats",
                "mData": null,
                "bSortable": false,
                "sWidth": "5px",
                "sDefaultContent": '<input type="text" class="total_seat" width="5px" id="available_seats">'
            }

        ]


    });

    if (course_seat_data != '') {


        $("#example tbody tr").each(function (i) {

            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            for (var j = 0; j < course_seat_data.length; j++) {

                if (course_seat_data[j]["course_code"] == $(this).children().eq(0).html()) {
                    $(this).find(".total_seat").val(course_seat_data[j]["available_seat"]);
                }
            }
        });

    }


    $('#DataList').css('display', 'block');
    $('#btnsave').css('display', 'block');

    return false;

}

function save_course_seats() {

    var course_seat_data = [];
    var parent_sem = '';



    $("#example tbody tr").each(function (i) {

        var aPos = oTable.fnGetPosition(this);
        //        var aData = oTable.fnGetData(aPos[i]);
        //        var a = aData[i];

        var a = oTable.fnGetData(aPos);


        var obj = {};

        obj["doc_no"] = a["doc_no"];
        obj["dept_code"] = a["dept_code"];
        obj["course_code"] = $(this).children().eq(0).html();
        obj["semester_code"] = a['semester_code'];
        obj["available_seat"] = $(this).find(".total_seat").val();
        obj["course_type"] = a["course_type"];
        obj["prog_code"] = a["prog_code"];
        obj["year_code"] = a["year_code"];
        obj["course_typology"] = a["course_typology"]
        obj["prog_level_code"] = a["prog_level_code"]
        obj["prog_course_id"] = a["prog_course_id"]
        obj["sub_category_id"] = a["sub_category_id"]
        obj["focus_studio"] = a["focus_studio"]
        obj["secondary_focus_studio"] = a["secondary_focus_studio"]
        obj["created_by"] = a["created_by"];
        obj["created_date"] = a["created_date"];
        obj["created_host"] = a["created_host"];

        course_seat_data.push(obj);

    });

    var data = JSON.stringify({ course_seat_data: JSON.stringify(course_seat_data) });

    $.ajax({
        type: "POST",
        url: "../../WebService.asmx/save_course_seat_data",
        data: data,
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            bootbox.alert(data.d);
            // DisplayData(data.d);
            $('#btnsave').css("display", "none");
            $('#DataList').css("display", "none");


        },
        error: function (msg) { alert(msg.d); }
    });

}

function change_student_password() {
    $('#DataList').css('display', 'none');
    $('#btnsave').css('display', 'none');

    //    var semester = $('#drpsemester').val();
    //    if (semester == "") {
    //        bootbox.alert('Please select semester')
    //        $('#drpsemester').focus();
    //        return false;
    //    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select department')
        $('#drpdepartment').focus();
        return false;
    }


    var dept_code = $('#drpdepartment').val();

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_student_data",

            data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:''}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {



                    display_student_password_data(data.d);


                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester or Year');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function display_student_password_data(data) {
    // alert(data);

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
                //							    "copy",
                //							    "print",
                //							    {
                //							        "sExtends": "collection",
                //							        "sButtonText": 'Export',
                //							        "aButtons": ["xls", "pdf"]
                //							    }
            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
            {
                "sTitle": "<center><input type='checkbox' name='checkheader'  class='chk_half_parent'></input></center>",
                "mData": null,
                "bSortable": false,
                "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_half_child" ></center>'
            },
            { "sTitle": "User Id", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Code", "mData": "student_no", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Email Id", "mData": "mail", "bSortable": false }

        ]
    });

    $('#DataList').css('display', 'block');
    $('#btnsave').css('display', 'block');

    return false;
}

function save_reset_password() {

    var datalist = [];


    $('#example tbody tr').each(function (i) {

        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

        var obj = {};

        //obj["company_code"] = $(this).children().eq(0).html();
        //obj["user_id"] = $(this).find(".cad_user").val();


        if ($(this).find(".chk_half_child").is(':checked')) {

            obj["user_id"] = a["user_id"];
            obj["student_no"] = $('#drpsemester').val();
            obj["dept_code"] = $('#drpdepartment').val();
            obj["year_code"] = $('#drpyear').val();

            datalist.push(obj);
        }


    });

    var data = JSON.stringify({ reset_password: JSON.stringify(datalist) });

    $.ajax({
        type: "POST",
        url: "../../WebService.asmx/save_reset_password",
        data: data,
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            bootbox.alert(data.d);
            // DisplayData(data.d);
            $('#btnsave').css("display", "none");

            $('#DataList').css("display", "none");
        },
        error: function (msg) { alert(msg.d); }
    });

    return false;
}

function retrieve_data_for_send_mail() {


    $('#DataList').css('display', 'none');
    $('#btnsave').css('display', 'none');
    $('#ceditor').css('display', 'none');

    //    var semester = $('#drpsemester').val();
    //    if (semester == "") {
    //        bootbox.alert('Please select semester')
    //        $('#drpsemester').focus();
    //        return false;
    //    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    //    if (dept_code == "") {
    //        bootbox.alert('Please select department')
    //        $('#drpdepartment').focus();
    //        return false;
    //    }


    var dept_code = $('#drpdepartment').val();

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_student_data",

            data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:''}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    display_student_password_data(data.d);
                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester or Year');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function send_multiple_email() {

    var datalist = [];

    var flag = 'N';

    var body_data = CKEDITOR.instances.editor4.getData();


    if (body_data == '') {
        bootbox.alert('Please Enter data in body');
        return false;
    }

    var subject = $('#txt_subject').val();

    if (subject == '') {
        bootbox.alert('Please Enter data in subject');
        return false;
    }

    $('#example tbody tr').each(function (i) {

        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

        var obj = {};

        if ($(this).find(".chk_half_child").is(':checked')) {
            flag = 'Y';

            obj["user_id"] = a["user_id"];
            obj["email_id"] = a["mail"];


            datalist.push(obj);
        }

    });


    if (flag != 'Y') {

        bootbox.alert('You not select anyone student.please select student data');
        return false;
    }

    var data = JSON.stringify({ email: JSON.stringify(datalist), subject: subject, body: body_data });

    $.ajax({
        type: "POST",
        url: "../../WebService.asmx/send_multiple_email",
        data: data,
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {

            bootbox.alert(data.d);
            // DisplayData(data.d);
            $('#btnsave').css("display", "none");

            $('#ceditor').css('display', 'none');
            $('#DataList').css("display", "none");
        },
        error: function (msg) { alert(msg.d); }
    });

    return false;
}

function get_saved_allocate_data() {

    $('#datalist_saved').css('display', 'none');
    $('#datalist_register').css('display', 'none');


    var semester_type = $('#drpsemester').val();
    if (semester_type == "") {
        bootbox.alert('Please select Semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_semester = $('#drpyear').val();
    if (year_semester == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select department')
        $('#drpdepartment').focus();
        return false;
    }

    var prog = $('#drpprog').val();
    if (prog == "") {
        bootbox.alert('Please select programme')
        $('#drpprog').focus();
        return false;
    }

    var student = $('#drpstudent').val();
    //    if (student == "") {
    //        bootbox.alert('Please select student');
    //        $('#drpstudent').focus();
    //        return false;
    //    }

    var year_code = "";

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_saved_registerd_course_new",

            data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog: '" + prog + "',student: '" + student + "',semester_type:'" + semester_type + "',year_semester:'" + year_semester + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != null) {
                    if (data.d[0] != "") {
                        Display_saved_Data(data.d[0]);
                    }

                    if (data.d[1] != "") {
                        Display_assigned_Data(data.d[1]);
                    }
                    else {
                        if (data.d[0] == "") {
                            bootbox.alert('There is No data Found For Selected student');
                            return false;
                        }

                    }
                }
                else {

                    bootbox.alert('There is No data Found For Selected student');
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function Display_saved_Data(data) {

    $('#datalist_saved').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();


        $("#datalist_saved").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_saved" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#datatable_saved").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 25,
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },




        //"oTableTools": {
        //    "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls", "pdf"]
        //							}
        //    ]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Course", "mData": "course", "sWidth": "500px", "bSortable": false },
            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },
            { "sTitle": "Credits", "mData": "course_credits", "bSortable": false }


        ]

    });

    $('#datalist_saved').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function Display_assigned_Data(data1) {


    if (oTable1 != null) {
        oTable1.fnDestroy();


        $("#datalist_register").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_register" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#datatable_register").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 25,
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"oTableTools": {
        //    "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls", "pdf"]
        //							}
        //    ]
        //},

        "aaData": JSON.parse(data1),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Course", "mData": "course", "sWidth": "500px", "bSortable": false },
            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },
            { "sTitle": "Credits", "mData": "course_credits", "bSortable": false }

        ]

    });

    $('#datalist_register').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[1].innerText = 'Excel';
}

function total_registration_report_data() {
    $('#DataList').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    //    if (dept_code == "") {
    //        bootbox.alert('Please select department')
    //        $('#drpdepartment').focus();
    //        return false;
    //    }


    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_registration_report_data",

            data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {


                if (data.d != "") {


                    Display_Registration_report(data.d);
                    //   display_student_password_data(data.d);


                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester');
                    return false;
                }





            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function Display_Registration_report(data) {

    $('#DataList').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "bSort": false,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Student Code", "mData": "code", "bSortable": false },
            { "sTitle": "Student Name", "mData": "name", "bSortable": false },
            { "sTitle": "Mandatory Course", "mData": "mandatory_course", "bSortable": false },
            { "sTitle": "Mandatory Credits", "mData": "mandatory_credits", "bSortable": false },
            { "sTitle": "Elective Course", "mData": "elective_course", "bSortable": false },
            { "sTitle": "Elective Credits", "mData": "elective_credits", "bSortable": false },
            { "sTitle": "SWS Credits", "mData": "sws_credits", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function total_assigned_report_data() {
    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    var prog_level_code = $('#drpproglevel').val();
    //    if (dept_code == "") {
    //        bootbox.alert('Please select department')
    //        $('#drpdepartment').focus();
    //        return false;
    //    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_assigned_report_data",
        data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "',prog_level_code:'" + prog_level_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                Display_Assigned_report(data.d);
                //display_student_password_data(data.d);
            }
            else {
                bootbox.alert('There is No data Found For Selected Semester');
                return false;
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function Display_Assigned_report(data) {
    $('#DataList').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        //"sDom": 't',
        //"sScrollY": '400px',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"oTableTools":
        //{
        //    "aButtons": [
        //		"copy",
        //		"print",
        //		{
        //		    "sExtends": "collection",
        //		    "sButtonText": 'Export',
        //		    "aButtons": ["xls"]
        //		}
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "code", "bSortable": false },
            { "sTitle": "Student Name", "mData": "name", "bSortable": false },
            { "sTitle": "Student Level", "mData": "student_level", "bSortable": false },
            //{ "sTitle": "Program Level", "mData": "prog_level_name", "bSortable": false },
            { "sTitle": "Program Description", "mData": "prog_level_desc", "bSortable": false },
            { "sTitle": "Student Faculty", "mData": "student_faculty", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },
            { "sTitle": "Mandatory Course", "mData": "mandatory_course", "bSortable": false },
            { "sTitle": "Mandatory Credits", "mData": "mandatory_credits", "bSortable": false },
            { "sTitle": "Elective Course", "mData": "elective_course", "bSortable": false },
            { "sTitle": "Elective Credits", "mData": "elective_credits", "bSortable": false }
        ]
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 

    for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
        var title = $('#example thead th').eq(i).text();
        $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    };

    $("thead input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("thead input").index(this));
    });

    $("thead input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("thead input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("thead input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("thead input").index(this)];
        }
    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function allocated_course_detail() {
    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    //if (dept_code == "") {
    //    bootbox.alert('Please select department')
    //    $('#drpdepartment').focus();
    //    return false;
    //}

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_allocated_course_detail",
        data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                Display_allocated_course_detail(data.d);
                //display_student_password_data(data.d);
            }
            else {
                bootbox.alert('There is No data Found For Selected Semester');
                return false;
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function Display_allocated_course_detail(data) {

    $('#DataList').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        //"sDom": 't',
        //  "sScrollY": '400px',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        //"oTableTools":
        //{
        //    "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls"]
        //							}
        //    ]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Mandatory Course", "mData": "mandatory_course", "bSortable": false },
            { "sTitle": "Elective Course", "mData": "elective_course", "bSortable": false },
            { "sTitle": "Priority 1", "mData": "priority1", "bSortable": false },
            { "sTitle": "Priority 2", "mData": "priority2", "bSortable": false },
            { "sTitle": "Priority 3", "mData": "priority3", "bSortable": false },
            { "sTitle": "Priority 4", "mData": "priority4", "bSortable": false },
            { "sTitle": "Priority 5", "mData": "priority5", "bSortable": false },
            { "sTitle": "Priority 6", "mData": "priority6", "bSortable": false },
            { "sTitle": "Priority 7", "mData": "priority7", "bSortable": false },
            { "sTitle": "Priority 8", "mData": "priority8", "bSortable": false },
            { "sTitle": "Priority 9", "mData": "priority9", "bSortable": false },
            { "sTitle": "Priority 10", "mData": "priority10", "bSortable": false }
        ]

    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 

    for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
        var title = $('#example thead th').eq(i).text();
        $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    };

    $("thead input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("thead input").index(this));
    });

    $("thead input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("thead input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("thead input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("thead input").index(this)];
        }
    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}






function get_cross_reg_Faculty_wise() {
    $('#DataList').css('display', 'none');
    $('#DataList1').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select year')
        $('#drpyear').focus();
        return false;
    }



    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_cross_registration__Faculty_report_data",

            data: "{year_code: '" + year_code + "', semester: '" + semester + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != null) {


                    if (data.d[0] != "") {


                        Display_Cross_reg_course_faculty_report(data.d[0]);
                        //   display_student_password_data(data.d);


                    }
                    else {
                        bootbox.alert('There is No data Found for selected semester and year');
                        return false;
                    }


                    if (data.d[1] != "") {

                        Display_Cross_reg_credits_faculty_report(data.d[1]);

                        //   display_student_password_data(data.d);


                    }
                }
                else {

                    bootbox.alert('There is No data Found for selected semester and year');
                    return false;
                }



            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function Display_Cross_reg_course_faculty_report(data) {

    $('#DataList').css('display', 'block');
    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools":
        {
            "aButtons": [
                "copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls"]
                }
            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "", "mData": "Faculty", "bSortable": false },
            { "sTitle": "FA", "mData": "FA", "bSortable": false },
            { "sTitle": "FD", "mData": "FD", "bSortable": false },
            { "sTitle": "FM", "mData": "FM", "bSortable": false },
            { "sTitle": "FP", "mData": "FP", "bSortable": false },
            { "sTitle": "FT", "mData": "FT", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
}

function Display_Cross_reg_credits_faculty_report(data) {

    $('#DataList1').css('display', 'block');

    if (oTable1 != null) {
        oTable1.fnDestroy();


        $("#DataList1").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example1"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#example1").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools":
        {
            "aButtons": [
                "copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls"]
                }
            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "", "mData": "Faculty", "bSortable": false },
            { "sTitle": "FA", "mData": "FA", "bSortable": false },
            { "sTitle": "FD", "mData": "FD", "bSortable": false },
            { "sTitle": "FM", "mData": "FM", "bSortable": false },
            { "sTitle": "FP", "mData": "FP", "bSortable": false },
            { "sTitle": "FT", "mData": "FT", "bSortable": false }
        ]

    });

    $('#DataList1').css('display', 'block');
}



function get_cross_reg_PG_UG_wise() {
    $('#DataList').css('display', 'none');
    $('#DataList1').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select year')
        $('#drpyear').focus();
        return false;
    }



    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_cross_registration_PG_UG_report_data",

            data: "{year_code: '" + year_code + "', semester: '" + semester + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != null) {


                    if (data.d[0] != "") {


                        Display_Cross_reg_course_pg_ug_report(data.d[0]);
                        //   display_student_password_data(data.d);


                    }
                    else {
                        bootbox.alert('There is No data Found for selected semester and year');
                        return false;
                    }


                    if (data.d[1] != "") {

                        Display_Cross_reg_credits_pg_ug_report(data.d[1]);

                        //   display_student_password_data(data.d);


                    }
                }
                else {

                    bootbox.alert('There is No data Found for selected semester and year');
                    return false;
                }



            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function Display_Cross_reg_course_pg_ug_report(data) {

    $('#DataList').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools":
        {
            "aButtons": [
                "copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls"]
                }
            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "", "mData": "Faculty", "bSortable": false },
            { "sTitle": "FA", "mData": "FA", "bSortable": false },
            { "sTitle": "FD", "mData": "FD", "bSortable": false },
            { "sTitle": "FM", "mData": "FM", "bSortable": false },
            { "sTitle": "FP", "mData": "FP", "bSortable": false },
            { "sTitle": "FT", "mData": "FT", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
}

function Display_Cross_reg_credits_pg_ug_report(data) {

    $('#DataList1').css('display', 'block');

    if (oTable1 != null) {
        oTable1.fnDestroy();

        $("#DataList1").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example1"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#example1").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools":
        {
            "aButtons": [
                "copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls"]
                }
            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "", "mData": "Faculty", "bSortable": false },
            { "sTitle": "FA", "mData": "FA", "bSortable": false },
            { "sTitle": "FD", "mData": "FD", "bSortable": false },
            { "sTitle": "FM", "mData": "FM", "bSortable": false },
            { "sTitle": "FP", "mData": "FP", "bSortable": false },
            { "sTitle": "FT", "mData": "FT", "bSortable": false }
        ]

    });

    $('#DataList1').css('display', 'block');
}

function get_instructor_details() {
    $('#div_faculty_list').css('display', 'none');
    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select year')
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
    if (prog_code == "") {
        bootbox.alert('Please select Programme');
        $('#drpprog').focus();
        return false;
    }

    prog_level_code = $("#drpproglevel").val();  ///Returned By Ananth 26/04/2019

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_instructor_details_course_wise",
        data: "{sem_code: '" + semester + "',year_code: '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code: '" + prog_level_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != null) {
                if (data.d != "") {
                    Display_Faculty_data(data.d);
                    //display_student_password_data(data.d);
                    setDataTableHeaderFooter('example');
                }
                else {
                    bootbox.alert('There is No data Found for selected semester and year');
                    return false;
                }
            }
            else {
                bootbox.alert('There is No data Found for selected semester and year');
                return false;
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function Display_Faculty_data(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        "bSort": false,
        //"sDom": 't',
        //"sScrollX": '300px',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"oTableTools":
        //{
        //    "aButtons": [
        //		"copy",
        //		"print",
        //		{
        //		    "sExtends": "collection",
        //		    "sButtonText": 'Export',
        //		    "aButtons": ["xls"]
        //		}
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Sr No", "mData": "sr_no", "bSortable": false },
            { "sTitle": "name", "mData": "name", "bSortable": false },
            //{ "sTitle": "User type", "mData": "designation", "bSortable": false },
            { "sTitle": "Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Type", "mData": "typology", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Program", "mData": "prog_name", "bSortable": false },
            { "sTitle": "Credits", "mData": "course_credits", "bSortable": false },
            { "sTitle": "Contact Hrs", "mData": "instructor_contact_hrs", "bSortable": false },
            { "sTitle": "Percent Load", "mData": "percent_load", "bSortable": false },
            { "sTitle": "Contact Hours", "mData": "total_contact_hrs", "bSortable": false },
            { "sTitle": "Preparatory Hours", "mData": "total_preparation_hrs", "bSortable": false },
            { "sTitle": "Rate Band", "mData": "rate_band", "bSortable": false },
            { "sTitle": "Total Payment", "mData": "total_amount_paid", "bSortable": false },
            { "sTitle": "FA_UG", "mData": "FA_UG", "bSortable": false },
            { "sTitle": "FA_PG", "mData": "FA_PG", "bSortable": false },
            { "sTitle": "FA_Doctoral", "mData": "FA_PHD", "bSortable": false },
            { "sTitle": "FD_UG", "mData": "FD_UG", "bSortable": false },
            { "sTitle": "FD_PG", "mData": "FD_PG", "bSortable": false },
            { "sTitle": "FM_UG", "mData": "FM_UG", "bSortable": false },
            { "sTitle": "FM_PG", "mData": "FM_PG", "bSortable": false },
            { "sTitle": "FP_UG", "mData": "FP_UG", "bSortable": false },
            { "sTitle": "FP_PG", "mData": "FP_PG", "bSortable": false },
            { "sTitle": "FP_Doctoral", "mData": "FP_PHD", "bSortable": false },
            { "sTitle": "FT_UG", "mData": "FT_UG", "bSortable": false },
            { "sTitle": "FT_PG", "mData": "FT_PG", "bSortable": false },
            { "sTitle": "Total", "mData": "total_course", "bSortable": false }
        ]
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
    for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
        var title = $('#example thead th').eq(i).text();
        $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    };

    $("thead input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("thead input").index(this));
    });

    $("thead input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("thead input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("thead input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("thead input").index(this)];
        }
    });

    $('#div_faculty_list').css('display', 'block');
    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function financial_report_data() {
    $('#DataList').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    //    if (dept_code == "") {
    //        bootbox.alert('Please select department')
    //        $('#drpdepartment').focus();
    //        return false;
    //    }


    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_financial_report_data",

            data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {


                if (data.d != "") {


                    Display_financial_report_data(data.d);
                    //   display_student_password_data(data.d);


                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester');
                    return false;
                }





            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function Display_financial_report_data(data) {

    $('#DataList').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "bSort": false,
        //"sDom": 't',
        //  "sScrollY": '400px',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

        //"oTableTools":
        //{
        //    "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls"]
        //							}
        //    ]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Student Code", "mData": "code", "bSortable": false },
            { "sTitle": "Form ID", "mData": "application_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "name", "bSortable": false },
            { "sTitle": "Year of Enrollment", "mData": "year_desc", "bSortable": false },
            { "sTitle": "Faculty", "mData": "department_name", "bSortable": false },
            { "sTitle": "UG/PG", "mData": "program", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },

            { "sTitle": "Mandatory Credits", "mData": "mandatory_credits", "bSortable": false },

            { "sTitle": "Elective Credits", "mData": "elective_credits", "bSortable": false },
            { "sTitle": "Total Credits", "mData": "total_credits", "bSortable": false },
            { "sTitle": "Semester", "mData": "semester_type", "bSortable": false },
            { "sTitle": "Year", "mData": "year_semester", "bSortable": false },
            { "sTitle": "Fees Paid", "mData": "fees_status", "bSortable": false },
            { "sTitle": "Date of Payment", "mData": "fees_date", "bSortable": false },
            { "sTitle": "Mode of Payment", "mData": "payment_mode", "bSortable": false },
            { "sTitle": "Payment Reference", "mData": "payment_reference", "bSortable": false }
        ]


    });


    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
    for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
        var title = $('#example thead th').eq(i).text();
        $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    };

    $("thead input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("thead input").index(this));
    });

    $("thead input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("thead input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("thead input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("thead input").index(this)];
        }
    });


    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function Sale_of_admission_form() {

    //  alert('hi');
    $('#DataList').css('display', 'none');

    var programme = $('#drpprogramme').val();
    //    if (semester == "") {
    //        bootbox.alert('Please select semester')
    //        $('#drpsemester').focus();
    //        return false;
    //    }

    var start_date = $('#start_date').val(); // '2014-03-05';
    if (start_date == "") {
        bootbox.alert('Please select Start Date')
        $('#start_date').focus();
        return false;
    }

    var end_date = $('#end_date').val(); //'2014-10-01';
    if (end_date == "") {
        bootbox.alert('Please select End Date')
        $('#end_date').focus();
        return false;
    }

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Sale_of_admission_form",

            data: "{programme: '" + programme + "',start_date: '" + start_date + "',end_date:'" + end_date + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != "") {

                    Display_Sale_of_admission_form(data.d);

                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester');
                    return false;
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function Display_Sale_of_admission_form(data) {

    $('#DataList').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "bSort": false,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sDom": 't',
        //  "sScrollY": '400px',
        // "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        //"oTableTools":
        //{
        //    "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls"]
        //							}
        //    ]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Student Code", "mData": "application_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "candidate_display_name", "bSortable": false },
            { "sTitle": "Faculty", "mData": "Faculty", "bSortable": false },
            { "sTitle": "Program Type", "mData": "Program Type", "bSortable": false },
            { "sTitle": "Year", "mData": "year_code", "bSortable": false },
            { "sTitle": "Category", "mData": "Category", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },
            { "sTitle": "Fees Paid", "mData": "amount", "bSortable": false },
            { "sTitle": "Date of Payment", "mData": "Date of Payment", "bSortable": false },
            { "sTitle": "Payment Mode", "mData": "Payment Mode", "bSortable": false },
            { "sTitle": "Payment Reference", "mData": "transaction_id", "bSortable": false }
        ]

    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
    for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
        var title = $('#example thead th').eq(i).text();
        $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    };

    $("thead input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("thead input").index(this));
    });

    $("thead input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("thead input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("thead input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("thead input").index(this)];
        }
    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function get_course_catalog_data() {
    $('#DataList_mycourse').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();

    var prog_code = $('#drpprog').val();
    var prog_level_code = $('#drpproglevel').val();

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_course_catalog_data",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code: '" + prog_level_code + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != "") {



                    display_course_catalog(data.d);
                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester or Year');

                }

            },
            error: function (result) {

                alert(result);
            }
        });

    return false;
}



function display_course_catalog(data) {

    if (oTable1 != null) {
        oTable1.fnDestroy();
        $("#DataList_mycourse").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_mycourse" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#example_mycourse").dataTable({

        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",


        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //    //"copy",
        //		"print",
        //    	{
        //    	    "sExtends": "collection",
        //    	    "sButtonText": 'Export',
        //    	    "aButtons": ["xls"]
        //    	}
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Type", "mData": "type", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            { "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "Description", "mData": "course_desc", "bSortable": false },

            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },

            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },

            {
                "sTitle": "Total Hours(hr/week)", "mDataProp": "time", "bSortable": false, "mRender": function (data, type, full) {
                    if (data != '') {
                        return calcTotalHour(data);
                    }
                    else {
                        return '';
                    }
                }
            },

            //{ "sTitle": "Area", "mData": "area", "bSortable": false },  //// Comment By Ananth
            { "sTitle": "GPA / Non GPA", "mData": "gpa_ngpa_new", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },
            { "sTitle": "Preparatory/Self ", "mData": "prep_self_study_hrs", "bSortable": false }




        ]
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example_mycourse  thead th').each(function (i, r) {
        var nm = $('#example_mycourse  thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example_mycourse  thead').append(thead);

    //adding input box in thead second row 

    for (var i = 0; i < $("#example_mycourse  tr:nth-child(2) th").length; i++) {
        var title = $('#example_mycourse  thead th').eq(i).text();
        $('#example_mycourse  thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    };

    $("thead input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable1.fnFilter(this.value, $("thead input").index(this));
    });

    $("thead input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("thead input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("thead input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("thead input").index(this)];
        }
    });


    $('#DataList_mycourse').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function get_prerequisite(data) {
    var str_return = '';
    var obj_prerequisite;
    if (data != "") {
        try {
            obj_prerequisite = JSON.parse(data);
        } catch (e) {
            return data;
        }

        if (obj_prerequisite["chkbox"] != "") {
            var split_chk_data = obj_prerequisite["chkbox"].split('~');

            for (var i = 0; i < split_chk_data.length; i++) {
                if (split_chk_data[i] != 'chk_pre10') {
                    if (str_return != '') str_return = str_return + ', ';

                    switch (split_chk_data[i]) {
                        case 'chk_pre1':
                            str_return = str_return + 'None'; break;
                        case 'chk_pre2':
                            str_return = str_return + 'Completed 3rd year FA'; break;
                        case 'chk_pre3':
                            str_return = str_return + 'Completed 3rd year FD'; break;
                        case 'chk_pre4':
                            str_return = str_return + 'Completed 3rd year FP'; break;
                        case 'chk_pre5':
                            str_return = str_return + 'Completed 3rd year FT'; break;
                        case 'chk_pre6':
                            str_return = str_return + 'Completed UG Architecture'; break;
                        case 'chk_pre7':
                            str_return = str_return + 'Completed UG Planning'; break;
                        case 'chk_pre8':
                            str_return = str_return + 'Completed UG Design'; break;
                        case 'chk_pre9':
                            str_return = str_return + 'Completed UG Technology/ Engineering'; break;
                    }
                }
            }
        }

        if (obj_prerequisite["other"] != "") {
            if (str_return != '') str_return = str_return + ', ';
            str_return = str_return + obj_prerequisite["other"];
        }
    }
    return str_return;
}


function calcTotalHour(str_time) {

    var total_hour = 0;
    var total_min = 0;
    var arr_time = str_time.split(',');

    for (var i = 0; i < arr_time.length; i++) {


        var temp_from = arr_time[i].split('-')[0].trim();
        var temp_to = arr_time[i].split('-')[1].trim();

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
                //bootbox.alert('From_Time is greater than To_Time');
            }
        }

        total_hour = total_hour + timediff_h;
        total_min = total_min + timediff_m;
    }

    if (total_min >= 60) {
        total_hour = total_hour + 1;
        total_min = total_min - 60;
    }

    return total_hour.toString() + "." + total_min.toString();
}



function print_payslip() {

    if ($('#drpdepartment').val() == "") {

        bootbox.alert("Please select department.");

        return false;
    }

    if ($('#drpprog').val() == "") {

        bootbox.alert("Please select program.");

        return false;
    }

    if ($('#drpprog').val() == "") {

        bootbox.alert("Please select program.");

        return false;
    }


    if ($('#drpyear').val() == "") {

        bootbox.alert("Please select year of enrollement.");

        return false;
    }

    if ($('#drpstudent').val() == "") {

        bootbox.alert("Please select student.");

        return false;
    }
}

function fees_payment_report_data() {


    $('#DataList').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    //  var dept_code = $('#drpdepartment').val();
    var ob = {};

    ob["member_code"] = "41";
    ob["Email"] = "kuakpati@logistixinfosys.com";
    ob["password"] = "1212";

    //        var data2 = JSON.stringify({ 
    //                        "member_mst": ob,
    //                        "city_mst": { "university_name": "abc", "country_name": "india", "is_active": "y" }
    //                   });

    //    var data2 = JSON.stringify({
    //        "member_mst": JSON.stringify(ob),
    //        "city_mst": JSON.stringify({ "university_name": "abc", "country_name": "india", "is_active": "y" })
    //    });

    //        $.ajax(

    //        {
    //            type: "POST",
    //            contentType: "application/json; charset=utf-8",
    //            url: "../../WebService.asmx/get_fees_payment_report_data_new",

    //            //  data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
    //            data: data2,
    //            dataType: "json",
    //            success: function (data) {

    //                if (data.d != "") {
    //                    Display_fees_payment_report_data(data.d);
    //                }
    //                else {
    //                    bootbox.alert('There is No data Found For Selected Semester');
    //                    return false;
    //                }
    //            },
    //            error: function (result) {
    //                alert(result);
    //            }
    //        });


    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_fees_payment_report_data",

            //  data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
            data: "{semester: '" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != "") {
                    Display_fees_payment_report_data(data.d);
                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester');
                    return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function Display_fees_payment_report_data(data) {
    $('#DataList').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        "bSort": false,
        //"sDom": 't',
        //"sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"oTableTools":
        //{
        //    "aButtons": [
        //		"copy",
        //		"print",
        //		{
        //		    "sExtends": "collection",
        //		    "sButtonText": 'Export',
        //		    "aButtons": ["xls"]
        //		}
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Year of Enrollment", "mData": "year_desc", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false },
            { "sTitle": "Fees Status", "mData": "fees_status", "bSortable": false },
            { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Program", "mData": "prog_level_desc", "bSortable": false },
            { "sTitle": "Fees Payable", "mData": "fees_payable", "bSortable": false },
            { "sTitle": "Credits", "mData": "allocated_credits", "bSortable": false },
            { "sTitle": "Type of Payment", "mData": "type_of_payment", "bSortable": false },
            { "sTitle": "amount", "mData": "amount", "bSortable": false },
            { "sTitle": "Installment", "mData": "Installment", "bSortable": false },
            { "sTitle": "Transaction Id", "mData": "transaction_id", "bSortable": false },
            { "sTitle": "Running serial number", "mData": "running_serial_number", "bSortable": false },
            { "sTitle": "Transaction Date", "mData": "fees_date", "bSortable": false },
            { "sTitle": "DD no", "mData": "dd_no", "bSortable": false },
            { "sTitle": "Branch Name", "mData": "branch_name", "bSortable": false },
            { "sTitle": "Branch Code", "mData": "branch_code", "bSortable": false }
        ]
    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function online_payment_report_data() {
    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year')
        $('#drpyear').focus();
        return false;
    }

    var dept_code = $('#drpdepartment').val();
    //    if (dept_code == "") {
    //        bootbox.alert('Please select department')
    //        $('#drpdepartment').focus();
    //        return false;
    //    }

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_online_payment_data",
            data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    Display_online_payment_report_data(data.d);
                    //display_student_password_data(data.d);
                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester');
                    return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function Display_online_payment_report_data(data) {

    $('#DataList').css('display', 'block');
    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools":
        {
            "aButtons": [
                "copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls"]
                }
            ]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },

            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },

            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Program", "mData": "prog_name", "bSortable": false },

            { "sTitle": "Transaction No", "mData": "transaction_id", "bSortable": false },
            { "sTitle": "Amount Paid", "mData": "amount", "bSortable": false },
            { "sTitle": "Date of Payment", "mData": "created_date", "bSortable": false },
            { "sTitle": "Mode of Payment", "mData": "Citrus_PaymentMode", "bSortable": false }

        ]
    });

    $('#DataList').css('display', 'block');
}