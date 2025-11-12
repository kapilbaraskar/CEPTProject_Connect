var oTable;
var oTable1;
var oTable2;
var sem_data = '';

var course_seat_data = '';

var ws_year_data = "";
var current_ws_data = "";

function bindyeardata() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_year_data",

        data: "{}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var year_data = JSON.parse(data.d)



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
        url: "../../WebService_WS.asmx/Get_course_data",

        data: "{}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var year_data = JSON.parse(data.d)



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

function bindyeardata_for_cross_reg() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_year_data",

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
        url: "../../WebService_WS.asmx/Get_student_data",

        data: "{year_code:'' ,dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "'}",
        dataType: "json",
        success: function (data) {

            debugger;


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
                $('#drpstudent')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Student found</option>')
                    .val('');
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

    debugger;

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
        url: "../../WebService_WS.asmx/Get_student_data",

        data: "{year_code:'" + $('#drpyear').val() + "' ,dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "'}",
        dataType: "json",
        success: function (data) {

            debugger;


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
                $('#drpstudent')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Student found</option>')
                    .val('');
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

    $('#drpprog').chosen();
}

function bindsemdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
    //    for (var i = 0; i < sem_data.length; i++) {


    //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

    //    }

    $('#drpsemester').chosen();

}
function bind_ws_semdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
    $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
    //    for (var i = 0; i < sem_data.length; i++) {


    //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

    //    }

    $('#drpsemester').chosen();

}

function bindsemesterdata() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_semester_data",

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
        url: "../../WebService_WS.asmx/Get_department_data",

        data: "{}",
        dataType: "json",
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


function total_selected_course() {


    $('#DataList').css('display', 'none');
    $('#btn_assign').css('display', 'none');
    $('#btn_remove').css('display', 'none');
    $('#btn_assign2').css('display', 'none');
    $('#btn_publish').css('display', 'none');
    debugger;
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
            url: "../../WebService_WS.asmx/Get_ws_saved_selected_course_data_for_report",

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

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/remove_all_allocate_data",
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
        url: "../../WebService_WS.asmx/publish_allocation_data",
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
                $('#btn_remove').css('display', 'none');
                $('#btn_publish').css('display', 'none');
            }
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

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        "bSort": false,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        //     "oTableTools": {
        //         "aButtons": [
        //	"copy",
        //	"print",
        //	{
        //		"sExtends": "collection",
        //		"sButtonText": 'Export',
        //		"aButtons": ["xls", "pdf"]
        //	}
        //]
        //     },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Course Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Available Seat", "mData": "available_seat", "bSortable": false },
            //{ "sTitle": "Mandatory", "mData": "mandatory", "bSortable": false },
            //{ "sTitle": "No. of students registered", "mData": "elective", "bSortable": false }

            {
                "sTitle": "No. of students registered", "mData": null, "sClass": "cls_action", mRender: function (data)
                {
                    if (data.elective != '') {
                        return data.elective;
                    }
                    else
                    {
                        return data.mandatory;

                    }
                }
            },
        ]
    });

    //var oTableTools = new TableTools(oTable, {
    //    "buttons": [
    //	"copy",
    //        "xls",
    //	"pdf", 
    //	{ "type": "print", "buttonText": "Print me!" }
    //]
    //});

    //$('#demo').before(oTableTools.dom.container);

    $('#DataList').css('display', 'block');
    $('#btn_assign').css('display', 'block');
    $('#btn_remove').css('display', 'block');
    $('#btn_assign2').css('display', 'block');
    $('#btn_publish').css('display', 'block');
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
            url: "../../WebService_WS.asmx/Save_assign_course_dtl",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
            dataType: "json",
            success: function (data) {




                if (data.d != "") {

                    var split_data = data.d.split(":");


                    if (data.d == "already") {
                        bootbox.alert('Course Allocation is already completed for this semester');

                        return false;
                    }

                    if (split_data[0] == "available_seat") {

                        bootbox.alert('total course selection is grater than available seat for course code : ' + split_data[1]);

                        return false;
                    }


                    bootbox.alert(data.d);

                    $('#DataList').css('display', 'none');
                    $('#btn_assign').css('display', 'none');
                    $('#btn_remove').css('display', 'none');
                    $('#btn_assign2').css('display', 'none');

                    $('#btn_publish').css('display', 'none');


                }


            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

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
            url: "../../WebService_WS.asmx/Save_assign_course_dtl_for_logic2",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
            dataType: "json",
            success: function (data) {




                if (data.d != "") {

                    var split_data = data.d.split(":");


                    if (data.d == "already") {
                        bootbox.alert('Course Allocation is already completed for this semester');

                        return false;
                    }

                    if (split_data[0] == "available_seat") {

                        bootbox.alert('total course selection is grater than available seat for course code : ' + split_data[1]);

                        return false;
                    }


                    bootbox.alert(data.d);

                    $('#DataList').css('display', 'none');
                    $('#btn_assign').css('display', 'none');
                    $('#btn_remove').css('display', 'none');
                    $('#btn_assign2').css('display', 'none');
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

    debugger;
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

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/get_ws_allocate_course_data",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
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
        //    "bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        //  "oTableTools": {
        //      "aButtons": [
        //      //							"copy",
        //	"print",
        //      							{
        //      							    "sExtends": "collection",
        //      							    "sButtonText": 'Export',
        //      							    "aButtons": ["xls"]

        //      							}
        //]
        //  },

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": false },
            //                              { "sTitle": "Course Name", "mData": "course_name","bSortable": false, "bVisible": false },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false },
            //               { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false }
            //                                                  { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false }


        ]
        //        "fnDrawCallback": function (oSettings) {
        //            if (oSettings.aiDisplay.length == 0) {
        //                return;
        //            }

        //            var nTrs = $('tbody tr', oSettings.nTable);
        //            var iColspan = nTrs[0].getElementsByTagName('td').length;
        //            var sLastGroup = "";
        //            for (var i = 0; i < nTrs.length; i++) {
        //                var iDisplayIndex = oSettings._iDisplayStart + i;
        //                var sGroup = oSettings.aoData[i]._aData["course_code"];
        //                var sGroup1 = oSettings.aoData[i]._aData["course_name"];
        //                //  alert(sGroup);
        //                //  alert(sGroup["FIM_Code"]);
        //                // alert(JSON.parse(sGroup));
        //                //var sGroup = '100021';
        //                if (sGroup != sLastGroup) {
        //                    var nGroup = document.createElement('tr');
        //                    var nCell = document.createElement('td');
        //                    nCell.colSpan = iColspan;
        //                    nCell.className = "group";
        //                    nCell.innerHTML = sGroup + ' - ' + sGroup1;
        //                    // nCell.innerHTML = sGroup;
        //                    nGroup.appendChild(nCell);
        //                    nTrs[i].parentNode.insertBefore(nGroup, nTrs[i]);
        //                    sLastGroup = sGroup;

        //                }
        //            }
        //        }


    }).rowGrouping();

    $('#DataList').css('display', 'block');
    //    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';

}

function total_course_Register() {
    $('#DataList').css('display', 'none');

    debugger;
    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    //    var year_code = $('#drpyear').val();
    //    if (year_code == "") {
    //        bootbox.alert('Please select Year')
    //        $('#drpyear').focus();
    //        return false;
    //    }

    var dept_code = $('#drpdepartment').val();
    var year_Code = $("#drpyear").val();

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/get_registered_course_data_for_report",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_Code + "',dept_code: '" + dept_code + "'}",
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
        //    "bStateSave": true,
        "iDisplayLength": 60,
        "sDom": 'b',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //        "sDom": 'T<"clear">lfrtip',
        //  "oTableTools": {
        //      "aButtons": [
        //      //							"copy",
        //	"print",
        //      							{
        //      							    "sExtends": "collection",
        //      							    "sButtonText": 'Export',
        //      							    "aButtons": ["xls"]

        //      							}
        //]
        //  },

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": false },
            //                              { "sTitle": "Course Name", "mData": "course_name","bSortable": false, "bVisible": false },
            { "sTitle": "Student Code", "mData": "student_no", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Priority", "mData": "priority", "bSortable": false },
            { "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false }


        ]
        //        "fnDrawCallback": function (oSettings) {
        //            if (oSettings.aiDisplay.length == 0) {
        //                return;
        //            }

        //            var nTrs = $('tbody tr', oSettings.nTable);
        //            var iColspan = nTrs[0].getElementsByTagName('td').length;
        //            var sLastGroup = "";
        //            for (var i = 0; i < nTrs.length; i++) {
        //                var iDisplayIndex = oSettings._iDisplayStart + i;
        //                var sGroup = oSettings.aoData[i]._aData["course_code"];
        //                var sGroup1 = oSettings.aoData[i]._aData["course_name"];
        //                //  alert(sGroup);
        //                //  alert(sGroup["FIM_Code"]);
        //                // alert(JSON.parse(sGroup));
        //                //var sGroup = '100021';
        //                if (sGroup != sLastGroup) {
        //                    var nGroup = document.createElement('tr');
        //                    var nCell = document.createElement('td');
        //                    nCell.colSpan = iColspan;
        //                    nCell.className = "group";
        //                    nCell.innerHTML = sGroup + ' - ' + sGroup1;
        //                    // nCell.innerHTML = sGroup;
        //                    nGroup.appendChild(nCell);
        //                    nTrs[i].parentNode.insertBefore(nGroup, nTrs[i]);
        //                    sLastGroup = sGroup;

        //                }
        //            }
        //        }


    }).rowGrouping();

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';


}



function get_current_sem_data_for_student() {



}

function change_student_current_sem() {
    $('#DataList').css('display', 'none');
    $('#btnsave').css('display', 'none');
    debugger;
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



    var dept_code = $('#drpdepartment').val();

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/Get_student_data",

            data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {

                    $.ajax(

                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService_WS.asmx/get_current_sem_data_for_student",
                            async: false,
                            data: "{sem_code: '" + semester + "',year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
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


                    if (semester == 'M') {
                        display_monsoon_current_sem_data(data.d);
                    }

                    if (semester == 'S') {
                        display_spring_current_sem_data(data.d);
                    }


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
    // alert(data);

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


            debugger;
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
            debugger;
            if (sem_data[0]["parent_sem_code"] != "0") {
                $(this).find('.sem_parent').val(sem_data[0]["parent_sem_code"]);
            }
        });


        $("#example tbody tr").each(function (i) {



            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            debugger;

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
    debugger;

    $("#example tbody tr").each(function (j) {

        debugger;
        $(this).find(".sem_child").val(val);
    });





});


function save_current_sem() {

    debugger;
    var current_sem_data = [];
    var parent_sem = '';

    $("#example thead tr").each(function (j) {

        debugger;
        parent_sem = $(this).find(".sem_parent").val();
    });

    $("#example tbody tr").each(function (i) {


        debugger;
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
        url: "../../WebService_WS.asmx/save_student_current_sem",
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

    debugger;
    //    var semester = $('#drpsemester').val();
    //    if (semester == "") {
    //        bootbox.alert('Please select semester')
    //        $('#drpsemester').focus();
    //        return false;
    //    }

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
            url: "../../WebService_WS.asmx/get_seats_dtl_of_course",

            data: "{sem_code:'' , dept_code :'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {




                if (data.d != "") {


                    course_seat_data = JSON.parse(data.d);

                    display_course_seat_data(data.d);

                }
                else {

                    course_seat_data = '';
                    bootbox.alert('There is no registered course data found for selected course');
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

            debugger;

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

        debugger;
        var aPos = oTable.fnGetPosition(this);
        //        var aData = oTable.fnGetData(aPos[i]);
        //        var a = aData[i];
        var a = oTable.fnGetData(aPos);

        var obj = {};

        obj["doc_no"] = a["doc_no"];
        obj["course_code"] = $(this).children().eq(0).html();

        obj["available_seat"] = $(this).find(".total_seat").val();


        course_seat_data.push(obj);

    });

    var data = JSON.stringify({ course_seat_data: JSON.stringify(course_seat_data) });

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/save_course_seat_data",
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
            url: "../../WebService_WS.asmx/Get_student_data",

            data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
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
    // debugger;

    $('#example tbody tr').each(function (i) {

        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

        var obj = {};

        //obj["company_code"] = $(this).children().eq(0).html();
        //obj["user_id"] = $(this).find(".cad_user").val();
        debugger;

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
        url: "../../WebService_WS.asmx/save_reset_password",
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
            url: "../../WebService_WS.asmx/Get_student_data",

            data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
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




    // debugger;

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
        url: "../../WebService_WS.asmx/send_multiple_email",
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

    //    var semester = $('#drpsemester').val();
    //    if (semester == "") {
    //        bootbox.alert('Please select semester')
    //        $('#drpsemester').focus();
    //        return false;
    //    }

    var year_code = "";

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
    if (student == "") {
        bootbox.alert('Please select student');
        $('#drpstudent').focus();
        return false;
    }



    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/get_saved_registerd_course",

            data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog: '" + prog + "',student: '" + student + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != null) {


                    if (data.d[0] != "") {


                        Display_saved_Data(data.d[0]);
                        //   display_student_password_data(data.d);


                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Student');
                        return false;
                    }


                    if (data.d[1] != "") {

                        Display_assigned_Data(data.d[1]);

                        //   display_student_password_data(data.d);


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

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools": {
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

            { "sTitle": "Course", "mData": "course", "sWidth": "500px", "bSortable": false },
            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },



        ]

    });

    $('#datalist_saved').css('display', 'block');
}

function Display_assigned_Data(data1) {


    if (oTable1 != null) {
        oTable1.fnDestroy();


        $("#datalist_register").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_register" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#datatable_register").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools": {
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

        "aaData": JSON.parse(data1),
        "aoColumns": [

            { "sTitle": "Course", "mData": "course", "sWidth": "500px", "bSortable": false },
            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },


        ]

    });

    $('#datalist_register').css('display', 'block');
}

function total_registration_report_data() {
    $('#DataList').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
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
            url: "../../WebService_WS.asmx/get_registration_report_data",

            data: "{dept_code: '" + dept_code + "',semester: '" + semester + "'}",
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

            { "sTitle": "Student Code", "mData": "code", "bSortable": false },
            { "sTitle": "Student Name", "mData": "name", "bSortable": false },
            { "sTitle": "Mandatory Course", "mData": "mandatory_course", "bSortable": false },
            { "sTitle": "Mandatory Credits", "mData": "mandatory_credits", "bSortable": false },
            { "sTitle": "Elective Course", "mData": "elective_course", "bSortable": false },
            { "sTitle": "Elective Credits", "mData": "elective_credits", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
}

function total_assigned_report_data() {
    $('#DataList').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
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
            url: "../../WebService_WS.asmx/get_assigned_report_data",

            data: "{dept_code: '" + dept_code + "',semester: '" + semester + "'}",
            dataType: "json",
            success: function (data) {


                if (data.d != "") {


                    Display_Assigned_report(data.d);
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

function Display_Assigned_report(data) {

    $('#DataList').css('display', 'block');


    debugger;


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

            { "sTitle": "Student Code", "mData": "code", "bSortable": false },
            { "sTitle": "Student Name", "mData": "name", "bSortable": false },
            { "sTitle": "Mandatory Course", "mData": "mandatory_course", "bSortable": false },
            { "sTitle": "Mandatory Credits", "mData": "mandatory_credits", "bSortable": false },
            { "sTitle": "Elective Course", "mData": "elective_course", "bSortable": false },
            { "sTitle": "Elective Credits", "mData": "elective_credits", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
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
            url: "../../WebService_WS.asmx/get_cross_registration__Faculty_report_data",

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


    debugger;


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


    debugger;


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
            url: "../../WebService_WS.asmx/get_cross_registration_PG_UG_report_data",

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


    debugger;


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


    debugger;


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

function change_WS_sem_year() {


    $('#DataList').css('display', 'none');
    $('#btnsave').css('display', 'none');
    debugger;


    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/Get_current_WS_sem_year_data",
            async: false,
            data: "{}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    current_ws_data = JSON.parse(data.d)


                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService_WS.asmx/Get_year_data",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {



                            debugger;
                            if (data.d != "") {


                                ws_year_data = JSON.parse(data.d)
                            }

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });



                    display_current_ws_data(data.d);


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


function display_current_ws_data(data) {



    $('#DataList').css('display', 'block');
    $('#btnsave').css('display', 'block');

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



            {
                "sTitle": "Current Summer / Winter",
                "bSortable": false,
                "mData": null,

                fnRender: function (oObj) {

                    var listItems = '<select class="current_sem">';
                    listItems += "<option value='0'>---Select---</option>";
                    listItems += "<option value='S'>Summer</option>";
                    listItems += "<option value='W'>Winter</option>";

                    listItems += '</select>';
                    return listItems;



                }
            },

            {
                "sTitle": "Current year",
                "bSortable": false,
                "mData": null,

                fnRender: function (oObj) {



                    debugger;
                    //   var data = JSON.parse(ws_year_data)




                    var listItems = '<select class="current_year" >';
                    listItems += "<option value='0'>-- - Select-- -</option>";
                    for (var i = 0; i < ws_year_data.length; i++) {


                        listItems += "<option  value='" + ws_year_data[i]["year_desc"] + "'>" + ws_year_data[i]["year_desc"] + "</option>";
                    }


                    listItems += '</select>';
                    // alert(listItems);
                    return listItems;

                }
            }


        ]


    });


    $('#example tbody tr').each(function (i) {

        debugger;

        $(this).find(".current_year").val(current_ws_data[0]["year_code"]);

        $(this).find(".current_sem").val(current_ws_data[0]["sem_code"]);


    });


}

function save_ws_current_sem() {

    debugger;
    var current_sem_data = [];
    var parent_sem = '';

    //    $("#example thead tr").each(function (j) {

    //        debugger;
    //        parent_sem = $(this).find(".sem_parent").val();
    //    });

    $("#example tbody tr").each(function (i) {





        var obj = {};


        obj["sem_code"] = $(this).find(".current_sem").val();
        obj["year_code"] = $(this).find(".current_year").val();

        current_sem_data.push(obj);

    });

    var data = JSON.stringify({ current_sem_data: JSON.stringify(current_sem_data) });

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/save_ws_student_current_sem",
        data: data,
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            bootbox.alert("Data Saved Succesfully");
            // DisplayData(data.d);
            //            $('#btnsave').css("display", "none");
            //            $('#DataList').css("display", "none");


        },
        error: function (msg) { alert(msg.d); }
    });



}

function get_consolidates_data() {



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
    var prog_code = $('#drpprog').val();

    if (dept_code != "7") {



        if (prog_code == "") {
            bootbox.alert('Please select Program')
            $('#drpprog').focus();
            return false;
        }
    }
    else {
        prog_code = "";
    }


    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/get_consolidates_data",

            data: "{year_code: '" + year_code + "', semester: '" + semester + "' , dept_code:'" + dept_code + "',prog_code : '" + prog_code + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != null) {



                    if (data.d != '') {
                        Display_consolidates_data(data.d);
                    }
                    else {

                        bootbox.alert('There is No data Found for selected semester , year , department');
                        return false;
                    }

                    //   display_student_password_data(data.d);




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
function Display_consolidates_data(data) {


    $('#DataList').css('display', 'block');


    debugger;


    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "bSort": false,
        "iDisplayLength": 60,
        "sDom": 'b',
        "sScrollX": '400px',
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
        //						]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
            { "sTitle": "Student Name", "mData": "student_name", "bSortable": false },
            { "sTitle": "Course Code-1", "mData": "course_code1", "bSortable": false },
            { "sTitle": "Course Name-1", "mData": "course_name1", "bSortable": false },
            { "sTitle": "Credits -1", "mData": "credits1", "bSortable": false },
            { "sTitle": "Course Code-2", "mData": "course_code2", "bSortable": false },
            { "sTitle": "Course Name-2", "mData": "course_name2", "bSortable": false },
            { "sTitle": "Credits -2", "mData": "credits2", "bSortable": false },
            { "sTitle": "Course Code-3", "mData": "course_code3", "bSortable": false },
            { "sTitle": "Course Name-3", "mData": "course_name3", "bSortable": false },
            { "sTitle": "Credits -3", "mData": "credits3", "bSortable": false },
            { "sTitle": "Fee Paid/ Unpaid", "mData": "fees_status", "bSortable": false },
            { "sTitle": "Paying/ Non Paying (Credits)", "mData": "waiver_credits", "bSortable": false },
            { "sTitle": "Installment", "mData": "installment", "bSortable": false },
            { "sTitle": "Registeration Status", "mData": "registration_status", "bSortable": false },
            { "sTitle": "Mobile No.", "mData": "mobile_no", "bSortable": false },
            { "sTitle": "e-mail", "mData": "email", "bSortable": false }
            //    { "sTitle": "Credit Choice", "mData": "credit_choice", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function Non_cept_registered_student() {
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
    //  var year_Code = $("#drpyear").val();

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/get_Non_cept_registered_student",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: ''}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {



                    display_Non_cept_registered_student(data.d);
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





function display_Non_cept_registered_student(data) {


    $('#DataList').css('display', 'block');


    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        "bSort": false,
        // "sDom": 't',
        "sScrollX": '400px',
        "sScrollY": '700px',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
        //						]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "User ID", "mData": "user_id", "bSortable": false },
            { "sTitle": "User Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Registration Date", "mData": "joining_date", "bSortable": false },
            { "sTitle": "Mail", "mData": "mail", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },
            { "sTitle": "Address", "mData": "address", "bSortable": false },
            { "sTitle": "City", "mData": "city", "bSortable": false },
            { "sTitle": "State", "mData": "state", "bSortable": false },
            { "sTitle": "Country", "mData": "country", "bSortable": false },
            { "sTitle": "Date Of Birth", "mData": "dob", "bSortable": false },
            { "sTitle": "Phone Number", "mData": "phone_no", "bSortable": false },
            { "sTitle": "Mobile Number", "mData": "mobile_no", "bSortable": false },
            { "sTitle": "Blood Group", "mData": "blood_group", "bSortable": false },
            { "sTitle": "Place of Birth", "mData": "place_of_birth", "bSortable": false },
            { "sTitle": "Nationality", "mData": "nationality", "bSortable": false },
            { "sTitle": "Local Address", "mData": "local_address", "bSortable": false },
            { "sTitle": "Academic Program", "mData": "academic_prog", "bSortable": false },
            { "sTitle": "Year of EnrollMent", "mData": "year_of_Enrollment", "bSortable": false },
            { "sTitle": "Year of Passing", "mData": "year_of_passing", "bSortable": false },
            { "sTitle": "Name Of University", "mData": "name_of_university", "bSortable": false },
            { "sTitle": "Full Name of Degree", "mData": "full_name_of_degree", "bSortable": false },
            { "sTitle": "Proffessional/Student", "mData": "prof_details", "bSortable": false },
            { "sTitle": "Proffessional Experiance", "mData": "prof_exp", "bSortable": false },
            { "sTitle": "Address of University", "mData": "address_of_university", "bSortable": false },
            { "sTitle": "Marks", "mData": "marks", "bSortable": false },
            { "sTitle": "About Here", "mData": "about_here", "bSortable": false },
            { "sTitle": "Agree Affidavit", "mData": "agree_affidavit", "bSortable": false },
            { "sTitle": "Agree Registration Process", "mData": "agree_reg_process", "bSortable": false },
            {
                "sTitle": "Bonafied Certificate",
                "mData": null,
                "bSortable": false,
                mRender: function (oObj) {

                    if (oObj.bonafide_certi_name != '') {
                        return '<a class="fancybox" target="_blank" rel="group" download href="https://sws.cept.ac.in/assets/UserCertificate/' + oObj.bonafide_certi_name + '">Download</a>';
                    }
                    else {
                        return "";
                    }
                }
            },
            {
                "sTitle": "Degree Certificate",
                "mData": null,
                "bSortable": false,
                mRender: function (oObj) {

                    if (oObj.degree_certificate_name != '') {
                        return '<a class="fancybox" target="_blank" rel="group" download href="https://sws.cept.ac.in/assets/UserCertificate/' + oObj.degree_certificate_name + '">Download</a>';
                    }
                    else {
                        return "";
                    }
                }
            },
            {
                "sTitle": "Letter Organization",
                "mData": null,
                "bSortable": false,
                mRender: function (oObj) {

                    if (oObj.letter_organization != '') {
                        return '<a class="fancybox" target="_blank" rel="group" download href="https://sws.cept.ac.in/assets/UserCertificate/' + oObj.letter_organization + '">Download</a>';
                    }
                    else {
                        return "";
                    }
                }
            }

        ]

    });

    $('#DataList').css('display', 'block');
}

function successfully_paid_fees_details() {
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

    var year_Code = $("#drpyear").val();

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/get_successfully_paid_fees_details",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_Code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {



                    display_successfully_paid_fees_details(data.d);
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



function display_successfully_paid_fees_details(data) {


    $('#DataList').css('display', 'block');


    debugger;


    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "bSort": false,
        "iDisplayLength": 60,
        "sDom": 'b',
        "sScrollX": '400px',
        "sScrollY": '400px',
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
        //						]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Transaction ID", "mData": "transaction_id", "bSortable": false },
            { "sTitle": "User ID", "mData": "user_id", "bSortable": false },
            { "sTitle": "User Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Payment Transaction Reference ID", "mData": "payment_transaction_reference_id", "bSortable": false },
            { "sTitle": "Payment Authorization Code", "mData": "payment_authorization_code", "bSortable": false },
            { "sTitle": "Citrus Payment Mode", "mData": "Citrus_PaymentMode", "bSortable": false },
            { "sTitle": "Citrus TxReference No", "mData": "Citrus_TxRefNo", "bSortable": false },
            { "sTitle": "Amount", "mData": "amount", "bSortable": false },
            { "sTitle": "Created Date", "mData": "created_date", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function total_available_seats_after_allocation() {


    $('#DataList').css('display', 'none');

    debugger;
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
            url: "../../WebService_WS.asmx/get_total_allocate_seats_and_total_course_seats_data",

            data: "{sem_code:'" + semester + "' , year_code :'" + year_code + "'}",
            dataType: "json",
            success: function (data) {




                if (data.d != "") {


                    display_total_available_seats_after_allocation(data.d);





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

function display_total_available_seats_after_allocation(data) {


    $('#DataList').css('display', 'block');


    debugger;


    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" width="100%" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        "bSort": false,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
        //						]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Course Seats", "mData": "available_seat", "bSortable": false },
            { "sTitle": "Total Allocated Seats", "mData": "total_allocate_course", "bSortable": false }
        ]

    });

    $('#DataList').css('display', 'block');
}


function registered_course_detail() {
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
            url: "../../WebService_WS.asmx/get_registered_course_detail",

            data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {


                if (data.d != "") {


                    Display_registered_course_detail(data.d);
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

function Display_registered_course_detail(data) {

    $('#DataList').css('display', 'block');


    debugger;


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
        //						]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },

            { "sTitle": "Total available seats", "mData": "available_seat", "bSortable": false },
            { "sTitle": "Total students registered", "mData": "elective_course", "bSortable": false },
            { "sTitle": "Priority 1", "mData": "priority1", "bSortable": false },
            { "sTitle": "Priority 2", "mData": "priority2", "bSortable": false },
            { "sTitle": "Priority 3", "mData": "priority3", "bSortable": false },
            { "sTitle": "Priority 4", "mData": "priority4", "bSortable": false },
            { "sTitle": "Priority 5", "mData": "priority5", "bSortable": false }

        ]

    });

    $('#DataList').css('display', 'block');
}

function get_feedback_status_data() {
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



    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/Get_feedback_status_report",

            data: "{sem_code: '" + semester + "',year_code:'" + year_code + "'}",
            dataType: "json",
            success: function (data) {


                if (data.d != "") {


                    Display_feedback_status_detail(data.d);
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

function Display_feedback_status_detail(data) {

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
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
        //						]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false },
            { "sTitle": "Total allocate course", "mData": "total_course", "bSortable": false },
            { "sTitle": "Total feedback received", "mData": "total_feedback", "bSortable": false },
            { "sTitle": "Status", "mData": "status", "bSortable": false },

        ]

    });

    $('#DataList').css('display', 'block');
}


function Drop_course_by_popup_after_allocation() {
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

    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/get_ws_allocate_course_data_drop_by_student_from_popup",

            data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {

                    display_Drop_course_by_popup_after_allocation(data.d);
                }
                else {
                    bootbox.alert('There is no data found for selected semester or year');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}






function display_Drop_course_by_popup_after_allocation(data) {


    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bSortable": false,
        "bSort": false,

        //    "bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        //     "sScrollX": '400px',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        //  "oTableTools": {
        //      "aButtons": [
        //      //							"copy",
        //	"print",
        //      							{
        //      							    "sExtends": "collection",
        //      							    "sButtonText": 'Export',
        //      							    "aButtons": ["xls"]

        //      							}
        //]
        //  },

        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": false },
            //                              { "sTitle": "Course Name", "mData": "course_name","bSortable": false, "bVisible": false },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false },
            //               { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Date", "mData": "date", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            { "sTitle": "Drop or Decline", "mData": "drop_cancel", "bSortable": false },
            { "sTitle": "Amount Paid", "mData": "amount_paid", "bSortable": false },
            { "sTitle": "Refund amount", "mData": "refund_amount", "bSortable": false },
            { "sTitle": "Account Holder Name", "mData": "account_holder_name", "bSortable": false },
            { "sTitle": "Bank Name", "mData": "bank_name", "bSortable": false },
            { "sTitle": "Branch Name", "mData": "branch_name", "bSortable": false },
            { "sTitle": "Branch City", "mData": "branch_city", "bSortable": false },
            { "sTitle": "Branch State", "mData": "branch_state", "bSortable": false },
            { "sTitle": "Account Type", "mData": "account_type", "bSortable": false },
            { "sTitle": "IFSC Code", "mData": "ifsc_code", "bSortable": false },
            { "sTitle": "Account Number", "mData": "account_number", "bSortable": false }

            //                                                  { "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false }


        ]


    }).rowGrouping();

    $('#DataList').css('display', 'block');


}



function get_course_wise_inst_dtl() {



    var sem_code = $('#drpsemester').val();
    if (sem_code == "") {
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
    var course_code = $('#drcourses').val();
    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_ws_course_wise_instructor_personal_dtl",
            data: "{sem_code: '" + sem_code + "',year_code: '" + year_code + "',course_code:'" + course_code+"'}",
            dataType: "json",
            success: function (data) {

                if (data.d != null) {
                    if (data.d != '') {
                        Display_course_wise_personal_data(data.d);
                    }
                    else {
                        //$('#DataList1').css('display', 'none');
                        bootbox.alert('There is No data Found for selected semester , year');
                        return false;
                    }

                }
                else {
                    //$('#DataList1').css('display', 'none');
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

function get_course_wise_inst_dtl_praposal()
{
    var sem_code = $('#drpsemester').val();
    if (sem_code == "") {
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
    //var course_code = $('#drcourses').val();
    var course_code = '';
    $.ajax(

        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_ws_course_praposal_wise_instructor_personal_dtl",
            data: "{sem_code: '" + sem_code + "',year_code: '" + year_code + "',course_code:'" + course_code + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != null) {
                    if (data.d != '') {
                        Display_course_wise_personal_data_praposal(data.d);
                    }
                    else {
                       // $('#DataList1').css('display', 'none');
                        bootbox.alert('There is No data Found for selected semester , year');
                        return false;
                    }

                }
                else {
                   // $('#DataList1').css('display', 'none');
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


function Display_course_wise_personal_data(data) {
    $('#DataList').css('display', 'block');
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }
    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "bSort": false,
        "iDisplayLength": 60,
        "sDom": 'b',
        "sScrollX": '400px',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
            { "sTitle": "VF Code", "mData": "VF_code", "bSortable": false },
            { "sTitle": "First Name", "mData": "first_name", "bSortable": false },
            { "sTitle": "Last Name", "mData": "last_name", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },
            { "sTitle": "Email id", "mData": "mail", "bSortable": false },
            { "sTitle": "Mobile Number", "mData": "mobile_no", "bSortable": false },
            { "sTitle": "Blood Group", "mData": "blood_group", "bSortable": false },
            { "sTitle": "Alternate Contact Number", "mData": "emergency_contact_number", "bSortable": false },
            { "sTitle": "PAN No", "mData": "pan_card_no", "bSortable": false },
            { "sTitle": "Passport No", "mData": "passport_no", "bSortable": false },
            { "sTitle": "Aadhaar No", "mData": "aadhaar_no", "bSortable": false },
            { "sTitle": "GST Number", "mData": "gst_number", "bSortable": false },
            { "sTitle": "Bank Account Number", "mData": "bank_account_number", "bSortable": false },
            { "sTitle": "Account Type", "mData": "account_type", "bSortable": false },
            { "sTitle": "Branch Name", "mData": "branch_name", "bSortable": false },
            { "sTitle": "IFSC Code", "mData": "ifsc_code", "bSortable": false },
            { "sTitle": "Beneficiary Name as per Bank Account", "mData": "benificiary_name", "bSortable": false },
            { "sTitle": "Date of Birth", "mData": "dob", "bSortable": false },
            { "sTitle": "Highest Qualification", "mData": "highest_qualification", "bSortable": false },
            { "sTitle": "Total Years of Experience", "mData": "total_experiance", "bSortable": false },
            { "sTitle": "Total Teaching Experience", "mData": "total_teaching_experiance", "bSortable": false },
            { "sTitle": "Associated with CEPT Since(optional)", "mData": "associated_with_cept_since", "bSortable": false },
            { "sTitle": "Emergency Contact Person Name", "mData": "emergency_contact_name", "bSortable": false },
            { "sTitle": "Coa Registration Number", "mData": "coa_registration_no", "bSortable": false },
            { "sTitle": "City", "mData": "city", "bSortable": false },
            { "sTitle": "State", "mData": "state", "bSortable": false },
            { "sTitle": "Country", "mData": "country", "bSortable": false },
           /* { "sTitle": "Address", "mData": "address", "bSortable": false },*/
            {
                "sTitle": "Address", "mData": null, "bSortable": false, mRender: function (data) {


                    var row_value = data.address;

                    if (row_value != '') {
                        var split_data = row_value.split('@#');
                        if (split_data != undefined) {
                            row_value = split_data[0].replace('@#', ' ');
                            row_value = row_value.replace('@c#', ' ');
                            row_value = row_value.replace('#', ' ');

                        } else {
                            row_value = row_value.replace('@#', ' ');
                            row_value = row_value.replace('@c#', ' ');
                            row_value = row_value.replace('#', ' ');
                        }

                        return row_value.replace('@', ' ');
                    }
                    else {
                        return "";
                    }


                }
            },
            {
                "sTitle": "CV", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data['cv_file_name'] != '') {
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + data['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            },
            {

                "sTitle": "Portfolio", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data['portfolio_file_name'] != '') {
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download(this)" id=' + data['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            }
        ]

        // }).rowGrouping();
    });

    $('#DataList').css('display', 'block');
    // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}


function Display_course_wise_personal_data_praposal(data) {
    $('#swsDataList').css('display', 'block');
    if (oTable2 != null) {
        oTable2.fnDestroy();
        $("#swsDataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_course"><thead></thead><tbody> </tbody></table>');
    }
    oTable2 = $("#example_course").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "bSort": false,
        "iDisplayLength": 60,
        "sDom": 'b',
        "sScrollX": '400px',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

        "aaData": JSON.parse(data),
        "aoColumns": [

            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
            { "sTitle": "VF Code", "mData": "VF_code", "bSortable": false },
            { "sTitle": "First Name", "mData": "first_name", "bSortable": false },
            { "sTitle": "Last Name", "mData": "last_name", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },
            { "sTitle": "Email id", "mData": "mail", "bSortable": false },
            { "sTitle": "Mobile Number", "mData": "mobile_no", "bSortable": false },
            { "sTitle": "Blood Group", "mData": "blood_group", "bSortable": false },
            { "sTitle": "Alternate Contact Number", "mData": "emergency_contact_number", "bSortable": false },
            { "sTitle": "PAN No", "mData": "pan_card_no", "bSortable": false },
            { "sTitle": "Passport No", "mData": "passport_no", "bSortable": false },
            { "sTitle": "Aadhaar No", "mData": "aadhaar_no", "bSortable": false },
            { "sTitle": "GST Number", "mData": "gst_number", "bSortable": false },
            { "sTitle": "Bank Account Number", "mData": "bank_account_number", "bSortable": false },
            { "sTitle": "Account Type", "mData": "account_type", "bSortable": false },
            { "sTitle": "Branch Name", "mData": "branch_name", "bSortable": false },
            { "sTitle": "IFSC Code", "mData": "ifsc_code", "bSortable": false },
            { "sTitle": "Beneficiary Name as per Bank Account", "mData": "benificiary_name", "bSortable": false },
            { "sTitle": "Date of Birth", "mData": "dob", "bSortable": false },
            { "sTitle": "Highest Qualification", "mData": "highest_qualification", "bSortable": false },
            { "sTitle": "Total Years of Experience", "mData": "total_experiance", "bSortable": false },
            { "sTitle": "Total Teaching Experience", "mData": "total_teaching_experiance", "bSortable": false },
            { "sTitle": "Associated with CEPT Since(optional)", "mData": "associated_with_cept_since", "bSortable": false },
            { "sTitle": "Emergency Contact Person Name", "mData": "emergency_contact_name", "bSortable": false },
            { "sTitle": "Coa Registration Number", "mData": "coa_registration_no", "bSortable": false },
            { "sTitle": "City", "mData": "city", "bSortable": false },
            { "sTitle": "State", "mData": "state", "bSortable": false },
            { "sTitle": "Country", "mData": "country", "bSortable": false },
            /*{ "sTitle": "Address", "mData": "address", "bSortable": false },*/
            {
                "sTitle": "Address", "mData": null, "bSortable": false, mRender: function (data) {


                    var row_value = data.address;

                    if (row_value != '') {
                        var split_data = row_value.split('@#');
                        if (split_data != undefined) {
                            row_value = split_data[0].replace('@#', ' ');
                            row_value = row_value.replace('@c#', ' ');
                            row_value = row_value.replace('#', ' ');

                        } else {
                            row_value = row_value.replace('@#', ' ');
                            row_value = row_value.replace('@c#', ' ');
                            row_value = row_value.replace('#', ' ');
                        }

                        return row_value.replace('@', ' ');
                    }
                    else {
                        return "";
                    }


                }
            },
            {
                "sTitle": "CV", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data['cv_file_name'] != '') {
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download_pro" id=' + data['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            },
            {

                "sTitle": "Portfolio", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data['portfolio_file_name'] != '') {
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download(this)" id=' + data['portfolio_file_name'] + ' class="portfolio_download_pro" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            }
        ]

        // }).rowGrouping();
    });

    $('#swsDataList').css('display', 'block');
    // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}



$(document).on("click", ".cv_download", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var cv_file_name = aData["cv_file_name"];
    $('#hdn_file_name').val(cv_file_name);
    $("#btnDownload_cv").click();
    return false;
});
$(document).on("click", ".portfolio_download", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var portfolio_file_name = aData["portfolio_file_name"];
    //var ppt_video = aData["ppt_video"];
    $('#hdn_file_name').val(portfolio_file_name);
    $("#btnDownload_Portfolio").click();
    return false;
});


$(document).on("click", ".cv_download_pro", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable2.fnGetData(row);
    var cv_file_name = aData["cv_file_name"];
    $('#hdn_file_name').val(cv_file_name);
    $("#btnDownload_cv").click();
    return false;
});
$(document).on("click", ".portfolio_download_pro", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable2.fnGetData(row);
    var portfolio_file_name = aData["portfolio_file_name"];
    //var ppt_video = aData["ppt_video"];
    $('#hdn_file_name').val(portfolio_file_name);
    $("#btnDownload_Portfolio").click();
    return false;
});



function bind_sem_course() {


    var sem_code = $('#drpsemester').val();

    if (sem_code == '') {
        bootbox.alert('Please select semester');
        return false;
    }

    var year_code = $('#drpyear').val();

    if (year_code == '') {
        bootbox.alert('Please select year');

        return false;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_course_data",
        data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {


                var course_data = JSON.parse(data.d)



                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));
                for (var i = 0; i < course_data.length; i++) {


                    $('#drcourses').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"]));
                }

                $('#drcourses').chosen();


                $('#drcourses').trigger("liszt:updated");
            }
            else {
                $('#drcourses')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Data found</option>')
                    .val('');
                $('#drcourses').chosen();

                $('#drcourses').val('').trigger("liszt:updated");
            }

        },
        error: function (result) {
            alert(result);
        }
    });

}



