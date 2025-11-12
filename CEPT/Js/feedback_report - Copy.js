var oTable;

function bindsemdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
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


function bind_sem_course() {


    var sem_code = $('#drpsemester').val();

    if (sem_code == '') {
        bootbox.alert('Please select semester');
    }

    var year_code = $('#drpyear').val();

    if (year_code == '') {
        bootbox.alert('Please select year');
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_course_data_new",

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


function get_feedback_receipt_data() {

    $('#DataList').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var course_code = $('#drcourses').val();
    if (course_code == "") {
        bootbox.alert('Please select Course')
        $('#drcourses').focus();
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


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_feedback_receipt_report",

        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','dept_code':'" + dept_code + "','course_code':'" + course_code + "'}",
        dataType: "json",
        success: function (data) {



            debugger;
            if (data.d != "") {


                display_feedback_receipt_report(data.d);
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



function display_feedback_receipt_report(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
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
           { "sTitle": "Status Of Feedback", "mData": "status_of_feedback", "bSortable": false },
          { "sTitle": "Email", "mData": "mail", "bSortable": false }


            ]


    });

    //    var oTableTools = new TableTools(oTable, {
    //        "buttons": [
    //			"copy",
    //            "xls",
    //			"pdf", 
    //			{ "type": "print", "buttonText": "Print me!" }
    //		]
    //    });

    //    $('#demo').before(oTableTools.dom.container);
    $('#DataList').css('display', 'block');


}


function get_feedback_course_wise_receipt_data() {

    $('#DataList').css('display', 'none');


    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var course_code = '';

    //    var course_code = $('#drcourses').val();
    //    if (course_code == "") {
    //        bootbox.alert('Please select Course')
    //        $('#drcourses').focus();
    //        return false;
    //    }

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


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_course_wise_feedback_receipt_report",

        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','dept_code':'" + dept_code + "','course_code':'" + course_code + "'}",
        dataType: "json",
        success: function (data) {



            debugger;
            if (data.d != "") {


                display_feedback_receipt_report_course_wise(data.d);
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

function display_feedback_receipt_report_course_wise(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
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
          { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
          { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
           { "sTitle": "Mandatory", "mData": "mandatory", "bSortable": false },
          { "sTitle": "Elective", "mData": "elective", "bSortable": false },
            { "sTitle": "Mandatory Feedbcak", "mData": "mandatory_fb", "bSortable": false },
              { "sTitle": "Elective Feedback", "mData": "elective_fb", "bSortable": false }

            ]


    });

    //    var oTableTools = new TableTools(oTable, {
    //        "buttons": [
    //			"copy",
    //            "xls",
    //			"pdf", 
    //			{ "type": "print", "buttonText": "Print me!" }
    //		]
    //    });

    //    $('#demo').before(oTableTools.dom.container);
    $('#DataList').css('display', 'block');


}


function get_feedback_data() {

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



    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_feedback_data",

        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','dept_code':'','course_code':''}",
        dataType: "json",
        success: function (data) {



            debugger;
            if (data.d != "") {


                display_feedback_data(data.d);
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

function display_feedback_data(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody><tfoot style="background-color:#f3f3f3"><tr><th>Total: </th> <th style="text-align: left"> </th>  <th style="text-align: left"></th>  <th style="text-align: left">   </th>  <th style="text-align: left"></th>  <th style="text-align: left">    </th>   <th style="text-align: left"></th> </tr>  </tfoot></table>');



    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        "bSort": false,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
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
        "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
       aiDisplay) {

            debugger;
            var iTotalNuma = 0;
            var iTotalNumb = 0, iTotalNumc = 0, iTotalNumd = 0, iTotalNume = 0;
            if (aaData.length > 0) {
                for (var i = 0; i < aaData.length; i++) {

                    debugger;
                    if (aaData[i].total_allocate != "") {
                        iTotalNuma += parseInt(aaData[i].total_allocate);
                    }

                    if (aaData[i].not_filled_feedback != "") {
                        iTotalNumb += parseInt(aaData[i].not_filled_feedback);
                    }

                    if (aaData[i].total_feedback_received != "") {
                        iTotalNumc += parseInt(aaData[i].total_feedback_received);
                    }
                    if (aaData[i].completed != "") {
                        iTotalNumd += parseInt(aaData[i].completed);
                    }

                    if (aaData[i].non_completed != "") {
                        iTotalNume += parseInt(aaData[i].non_completed);
                    }



                }
            }
            /*
            * render the total row in table footer
            */
            var nCells = $('#example tfoot tr th');

            //            var nCells = nRow.getElementsByTagName("th");
            nCells[2].innerHTML = iTotalNuma;
            nCells[3].innerHTML = iTotalNumb;
            nCells[4].innerHTML = iTotalNumc;
            nCells[5].innerHTML = iTotalNumd;
            nCells[6].innerHTML = iTotalNume;

        },
        "aoColumns": [
          { "sTitle": "Department", "mData": "dept", "bSortable": false },
          { "sTitle": "Program", "mData": "prog", "bSortable": false },
           { "sTitle": "Total Allocated", "mData": "total_allocate", "bSortable": false },
          { "sTitle": "Not Filled Feedback", "mData": "not_filled_feedback", "bSortable": false },
            { "sTitle": "Total feedback Received", "mData": "total_feedback_received", "bSortable": false },
              { "sTitle": "Completed feedback", "mData": "completed", "bSortable": false },
               { "sTitle": "Not completed feedback", "mData": "non_completed", "bSortable": false }

            ]


    });

    //    var oTableTools = new TableTools(oTable, {
    //        "buttons": [
    //			"copy",
    //            "xls",
    //			"pdf", 
    //			{ "type": "print", "buttonText": "Print me!" }
    //		]
    //    });

    //    $('#demo').before(oTableTools.dom.container);
    $('#DataList').css('display', 'block');
}




function get_student_feedback_data() {

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

    var prog_code = $('#drpprog').val();



    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_student_feedback_data",

        data: "{'sem_code':'" + semester + "','year_code':'" + year_code + "','dept_code':'" + dept_code + "','prog_code':'" + prog_code + "'}",
        dataType: "json",
        success: function (data) {



            debugger;
            if (data.d != "") {


                display_student_feedback_data(data.d);
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

function display_student_feedback_data(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody><tfoot style="background-color:#f3f3f3"><tr><th>Total: </th> <th style="text-align: left"> </th>  <th style="text-align: left"></th>  <th style="text-align: left">   </th>  <th style="text-align: left"></th>  <th style="text-align: left">    </th>   <th style="text-align: left"></th> </tr>  </tfoot></table>');



    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        "bSort": false,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
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
          { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
          { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
          { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
          { "sTitle": "Program", "mData": "prog_desc", "bSortable": false },
          { "sTitle": "Total Allocated", "mData": "total_course", "bSortable": false },
          { "sTitle": "Lecture", "mData": "lecture", "bSortable": false },
          { "sTitle": "Seminar", "mData": "seminar", "bSortable": false },
          { "sTitle": "Studio", "mData": "studio", "bSortable": false },
                       { "sTitle": "Workshop", "mData": "workshop", "bSortable": false },
                          { "sTitle": "Others", "mData": "others", "bSortable": false },

            { "sTitle": "Total feedback Received", "mData": "total_feedback", "bSortable": false },
              { "sTitle": "Status", "mData": "status", "bSortable": false }

            ]


    });

    //    var oTableTools = new TableTools(oTable, {
    //        "buttons": [
    //			"copy",
    //            "xls",
    //			"pdf", 
    //			{ "type": "print", "buttonText": "Print me!" }
    //		]
    //    });

    //    $('#demo').before(oTableTools.dom.container);
    $('#DataList').css('display', 'block');
}

