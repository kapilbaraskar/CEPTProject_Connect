var oTable;
var oTable1;
var sem_data = '';

var course_seat_data = '';

var ws_year_data = "";
var current_ws_data = "";


function bindyeardata() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_year_data",

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
        url: "../../WebService.asmx/Get_year_data",

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

function bindsemdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
    $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
    //    for (var i = 0; i < sem_data.length; i++) {


    //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

    //    }

    $('#drpsemester').chosen();
}

function binddepartment() {

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
        url: "../../WebService.asmx/get_financial_report_data_SW",

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

                    { "sTitle": "Student Code", "mData": "code", "bSortable": false },
        //  { "sTitle": "Form ID", "mData": "application_id", "bSortable": false },
                    {"sTitle": "Student Name", "mData": "name", "bSortable": false },
                     { "sTitle": "Year of Enrollment", "mData": "year_desc", "bSortable": false },
                     { "sTitle": "Faculty", "mData": "department_name", "bSortable": false },
                     { "sTitle": "UG/PG", "mData": "program", "bSortable": false },
                        { "sTitle": "Gender", "mData": "gender", "bSortable": false },

                    { "sTitle": "Credit Choice", "mData": "credit_choice", "bSortable": false },

                    { "sTitle": "Waiver Credits", "mData": "waiver_credits", "bSortable": false },
        //   { "sTitle": "Total Credits", "mData": "total_credits", "bSortable": false },
                     {"sTitle": "Semester", "mData": "semester_type", "bSortable": false },
                     { "sTitle": "Year", "mData": "year_semester", "bSortable": false },
                      { "sTitle": "Fees Paid", "mData": "fees_status", "bSortable": false },
                      { "sTitle": "Date of Payment", "mData": "fees_date", "bSortable": false },
                       { "sTitle": "Mode of Payment", "mData": "payment_mode", "bSortable": false },
                         { "sTitle": "Payment Reference", "mData": "payment_reference", "bSortable": false }
           ]


    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function financial_report_course_wise_data() {
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
    //    if (dept_code == "") {
    //        bootbox.alert('Please select department')
    //        $('#drpdepartment').focus();
    //        return false;
    //    }


    $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_financial_report_with_coursedata_SW",

        data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
        dataType: "json",
        success: function (data) {


            if (data.d != "") {


                Display_financial_report_course_wise_data(data.d);
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

function Display_financial_report_course_wise_data(data) {

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
       // "sDom": 't',
        //  "sScrollY": '400px',
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

                    { "sTitle": "Student Code", "mData": "code", "bSortable": false },
        //  { "sTitle": "Form ID", "mData": "application_id", "bSortable": false },
                    {"sTitle": "Student Name", "mData": "name", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Credit", "mData": "course_credits", "bSortable": false },
                       { "sTitle": "Fees Payable", "mData": "fees_payable", "bSortable": false },
        //                     { "sTitle": "Year of Enrollment", "mData": "year_desc", "bSortable": false },
        //                     { "sTitle": "Faculty", "mData": "department_name", "bSortable": false },
        //                     { "sTitle": "UG/PG", "mData": "program", "bSortable": false },
        //                        { "sTitle": "Gender", "mData": "gender", "bSortable": false },

        //                    { "sTitle": "Credit Choice", "mData": "credit_choice", "bSortable": false },

        //                    { "sTitle": "Waiver Credits", "mData": "waiver_credits", "bSortable": false },
        //        //   { "sTitle": "Total Credits", "mData": "total_credits", "bSortable": false },
        //                     {"sTitle": "Semester", "mData": "semester_type", "bSortable": false },
        //                     { "sTitle": "Year", "mData": "year_semester", "bSortable": false },
                             { "sTitle": "Fees Paid", "mData": "fees_status", "bSortable": false },
        //                      { "sTitle": "Date of Payment", "mData": "fees_date", "bSortable": false },
                       {"sTitle": "Mode of Payment", "mData": "payment_mode", "bSortable": false },
        //                         { "sTitle": "Payment Reference", "mData": "payment_reference", "bSortable": false }
           ]


    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';

}