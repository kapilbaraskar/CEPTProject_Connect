var oTable;
var asInitVals = new Array();
publish_data_course = [];

function bindsemdata() {
    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

    //for (var i = 0; i < sem_data.length; i++) {
    //  $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));
    //}

    $('#drpsemester').chosen();


}

function bindproglevel() {
    

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_program_level_data",
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

function bindcoursetype() {
    $('#drp_course_type').empty().append($("<option></option>").val("").html("--Please Select course type--"));
    $('#drp_course_type').append($("<option></option>").val("lecture").html("Lecture"));
    $('#drp_course_type').append($("<option></option>").val("seminar").html("Seminar"));
    $('#drp_course_type').append($("<option></option>").val("studio").html("Studio"));
    $('#drp_course_type').append($("<option></option>").val("workshop").html("Workshop"));

    $('#drp_course_type').chosen();
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
function bindprogrammedata() {
    $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

    $('#drpprog').chosen();
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

function bindyeardata_for_allocation() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_year_data",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drpyear_allocation').empty().append($("<option></option>").val("").html("-- Please Select Year Of Allocation --"));

                for (var i = 0; i < year_data.length; i++) {
                    $('#drpyear_allocation').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear_allocation').chosen();
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
		//		"copy",
		//		"print",
		//		{
		//			"sExtends": "collection",
		//			"sButtonText": 'Export',
		//			"aButtons": ["xls"]
		//		}
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Status Of Feedback", "mData": "status_of_feedback", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false }
        ]
    });

    //var oTableTools = new TableTools(oTable, {
    //  "buttons": [
    //	"copy",
    //  "xls",
    //	"pdf", 
    //	{ "type": "print", "buttonText": "Print me!" }
    //]
    //});

    //$('#demo').before(oTableTools.dom.container);
    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function get_feedback_course_wise_receipt_data()
{
    var program_level_code = $('#drpproglevel').val();
    $('#DataList').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var course_code = '';

    //var course_code = $('#drcourses').val();
    //if (course_code == "") {
    //    bootbox.alert('Please select Course')
    //    $('#drcourses').focus();
    //    return false;
    //}
    
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
        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','dept_code':'" + dept_code + "','course_code':'" + course_code + "','program_level_code':'" + program_level_code +"'}",
        dataType: "json",
        success: function (data) {
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
		//		"copy",
		//		"print",
		//		{
		//			"sExtends": "collection",
		//			"sButtonText": 'Export',
		//			"aButtons": ["xls"]
		//		}
        //    ]
        //},
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

    //var oTableTools = new TableTools(oTable, {
    //  "buttons": [
    //	"copy",
    //  "xls",
    //	"pdf", 
    //	{ "type": "print", "buttonText": "Print me!" }
    //]
    //});

    //$('#demo').before(oTableTools.dom.container);

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
    var allocation_year = $('#drpyear_allocation').val();
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        //url: "../../WebService.asmx/get_feedback_data",
        url: "../../WebService.asmx/get_feedback_data_new",
        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','dept_code':'','course_code':'','allocation_year':'" + allocation_year+"'}",
        dataType: "json",
        success: function (data) {
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
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
    //    "oTableTools": {
    //        "aButtons": [
				//"copy",
				//"print",
				//{
				//	"sExtends": "collection",
				//	"sButtonText": 'Export',
				//	"aButtons": ["xls"]
				//}
    //        ]
    //    },
        "aaData": JSON.parse(data),
        "fnFooterCallback": function (nRow, aaData, iStart, iEnd, aiDisplay) {
            var iTotalNuma = 0;
            var iTotalNumb = 0, iTotalNumc = 0, iTotalNumd = 0, iTotalNume = 0;

            if (aaData.length > 0) {
                for (var i = 0; i < aaData.length; i++) {
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
               { "sTitle": "Not completed feedback", "mData": "non_completed", "bSortable": false },
                { "sTitle": "Completed Percentage", "mData": "completed_percentage", "bSortable": false }

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
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
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
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
		//					"copy",
		//					"print",
		//					{
		//					    "sExtends": "collection",
		//					    "sButtonText": 'Export',
		//					    "aButtons": ["xls"]
		//					}
        //    ]
        //},

        "aaData": JSON.parse(data),

        "aoColumns": [
          { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
          { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
           { "sTitle": "Email Id", "mData": "mail", "bSortable": false },
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

function get_course_faculty_wise_feedback_report() {

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


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_course_faculty_wise_feedback_report",

        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','dept_code':'" + dept_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                display_feedback_receipt_report_course_instructor_wise(data.d);
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

function display_feedback_receipt_report_course_instructor_wise(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
		//					"copy",
		//					"print",
		//					{
		//					    "sExtends": "collection",
		//					    "sButtonText": 'Export',
		//					    "aButtons": ["xls"]
		//					}
        //    ]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [
          { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
          { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
           { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
          { "sTitle": "Typology", "mData": "type_name", "bSortable": false },
            { "sTitle": "Instructor Name", "mData": "faculty_name", "bSortable": false },
               { "sTitle": "Instructor Mail", "mData": "faculty_mail", "bSortable": false },
            { "sTitle": "Allocate Course", "mData": "total_course", "bSortable": false },
              { "sTitle": "Feedback Recieved", "mData": "total_feedback", "bSortable": false },
               {
                   "sTitle": " Send mail<center></center>",
                   "mData": null,
                   "bSortable": false,
                   "sDefaultContent": '<center><a href="#" style="text-decoration:none;" class="send_mail" title="Send Remarks"><i class="icon-mail-forward"></i></a></center>'
               },
                {
                    "sTitle": " Send Feedback PDF<center></center>",
                    "mData": null,
                    "bSortable": false,
                    "sDefaultContent": '<center><a href="#" style="text-decoration:none;" class="send_feedback_pdf_mail" title="Send Remarks"><i class="icon-mail-forward"></i></a></center>'
                }
        ]
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
    //$("#example tr:nth-child(2) th").length (Remove because of Download)
    for (var i = 0; i < 8; i++) {
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

var count = 1;
function get_course_faculty_wise_feedback_report_for_send_pdf() {

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
    var program_level_code = $('#drpproglevel').val();
    var prog_code = $('#drpprog').val();

    //    if (dept_code == "") {
    //        bootbox.alert('Please select department')
    //        $('#drpdepartment').focus();
    //        return false;
    //    }


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_course_faculty_wise_feedback_report_for_send_pdf",

        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','dept_code':'" + dept_code + "','program_level_code':'" + program_level_code + "','prog_code':'" + prog_code +"'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {


                display_feedback_receipt_report_course_instructor_wise_for_send_pdf(data.d);
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

function display_feedback_receipt_report_course_instructor_wise_for_send_pdf(data) {
    
    var columns = set_table_columns(JSON.parse(data));
    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
      
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        "iDisplayLength": 60,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        "aaData": JSON.parse(data),

        "aoColumns": columns,
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            if (aData.mailstatus == "Mail Send Successfully") {
                //$('td', nRow).css('background-color', 'orange');
                $('td', nRow).css('background-color', 'orange');
            }

        }
        //"aaData": JSON.parse(data),
        //"aoColumns": [
        //    {
        //        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, fnRender: function (data) {
                  
        //                    return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" />';
                       
        //        }
        //    },

        //    {
        //        "sTitle": "Download <center></center>",
        //        "mData": null,
        //        "bSortable": false,
        //        "sDefaultContent": '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download PDF"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
        //    },
        //  { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
        //  { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
        //   { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
        //  { "sTitle": "Typology", "mData": "type_name", "bSortable": false },
        //    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
        //       { "sTitle": "Instructor Mail", "mData": "mail", "bSortable": false },
        //    { "sTitle": "Allocate Course", "mData": "total_course", "bSortable": false },
        //      { "sTitle": "Feedback Recieved", "mData": "total_feedback", "bSortable": false },
        //        {
        //        "sTitle": " Send Feedback Individually<center></center>",
        //            "mData": null,
        //            "bSortable": false,
        //            "sDefaultContent": '<center><a href="#" style="text-decoration:none;" class="send_feedback_pdf_mail_individual" title="Send Remarks"><i class="icon-mail-forward"></i></a></center>'
        //        }
        //]
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
    //$("#example tr:nth-child(2) th").length (Remove because of email)
    for (var i = 1; i < 9; i++) {
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
   //$('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}


function set_table_columns(row) {
    var columns = [];
    
    columns.push({
        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, fnRender: function (data) {

            return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" />';

        }
    });
    columns.push({
        "sTitle": "Download", "mData": null, "sClass": "cls_action", fnRender: function (data) {
            var pdfstatus = data.aData["pdfstatus"];
            if (pdfstatus == 'Y') {
                return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download PDF"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
            }
            else
            {
                return "";
            }
        }
    });
    
      
    
    //"sTitle": "Description", "mData": null, "mRender": function (data)
    columns.push({ "sTitle": "Course Code", "mData": "course_code", "bSortable": false });
    columns.push({ "sTitle": "Course Name", "mData": "course_name", "bSortable": false });
    columns.push({ "sTitle": "Department", "mData": "dept_name", "bSortable": false });
    columns.push({ "sTitle": "Typology", "mData": "type_name", "bSortable": false });
    columns.push({ "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false });
    columns.push({ "sTitle": "Instructor Mail", "mData": "mail", "bSortable": false });
    columns.push({ "sTitle": "Allocate Course", "mData": "total_course", "bSortable": false });
    columns.push({ "sTitle": "Feedback Recieved", "mData": "total_feedback", "bSortable": false });
    columns.push({
        "sTitle": "Send Feedback Individually", "mData": null, "sClass": "cls_action", "mRender": function () {
            return '<center><a href="#" style="text-decoration:none;" class="send_feedback_pdf_mail_individual" title="Send Remarks"><i class="icon-mail-forward"></i></a></center>';

        }
    });
    columns.push({ "sTitle": "Mail Send Status", "mData": "mailstatus", "bSortable": false });
    return columns;
}





$(document).on("click", ".send_mail", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var course_name = aData["course_name"];
    var total_course = aData["total_course"];
    var total_feedback = aData["total_feedback"];

    var faculty_mail = aData["faculty_mail"];

    var typology_dtl = $.grep(obj_typology_data, function (data) { return data.type_code == aData.course_typology });

    //if (aData.course_typology == "10" || aData.course_typology == "11" || aData.course_typology == "13" || aData.course_typology == "2") {
    if (typology_dtl.length > 0 && typology_dtl[0]['sub_group'] == '') {
        bootbox.alert("You can not send mail for this course. Course is not eligible for feedback.");
        return false;
    }

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

    //    var remark = aData["remark"];

    //    $('#txtRejectRemark').val("");

    //    if (remark != "") {
    //        $('#txtRejectRemark').val(remark);
    //    }

    if (faculty_mail.toString().trim() == "") {

        bootbox.alert("Instructor's mail id not found for selected course : " + course_code);

        return false;
    }

    $('#hdn_course').val(course_code);
    //   $('#hdn_faculty_mail').val(faculty_mail);

    //  $('#myModal').modal('show');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/send_feedback_mail",

        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_code':'" + course_code + "','course_name':'" + course_name + "','total_course':'" + total_course + "','total_feedback':'" + total_feedback + "'}",

        dataType: "json",
        success: function (data) {
            if (data.d != "") {

                if (data.d == "1") {

                    bootbox.alert('Mail sent');
                    get_course_faculty_wise_feedback_report();
                }
                else {
                    bootbox.alert(data.d);

                    return false;
                }


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
});
//kapil
//download_pdf

function select_all_change() {
    if ($('#chk_select_all')[0].checked) {
        $('.cls_chk_course_select').attr('checked', 'checked');
    }
    else {
        $('.cls_chk_course_select').removeAttr('checked');
    }
}

function course_select_change(cur_ele) {
   
    if (cur_ele.checked) {
        if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
            $('#chk_select_all')[0].checked = true;
    }
    else {
        $('#chk_select_all')[0].checked = false;
    }
}
var pdf_print_name = "";

$(document).on("click", ".download_pdf", function (event) {
    
    //instructor_code

   

    var dept_code = $('#drpdepartment').val();
    var department = $('#drpdepartment').val();
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var instructor_code = aData["instructor_code"];

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
    var course_type = "";//$('#drp_course_type').val();
    $('#hdn_course').val(course_code);
    
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        //url: "../../WebService.asmx/print_faculty_report_latest",
        url: "../../WebService.asmx/print_faculty_report_latest_rating_instructor_wise",
        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_type':'" + course_type + "','course_code':'" + course_code + "','dept_code':'" + department + "','selected_instructor':'" + instructor_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d == "Data Not Found") {
                    bootbox.alert("No data found for selected course or course type");
                    $('#print_data').html('');
                    return false;
                }

                if (data.d == "Instructor") {
                    bootbox.alert("No data found for Instructor selected course or course type");
                    $('#print_data').html('');
                    return false;
                }

                if (data.d == "Nofeedback") {
                    bootbox.alert("No Feedback data found for selected course.");
                    $('#print_data').html('');
                    return false;
                }

                //var course_data = JSON.parse(data.d);

                var course_data = JSON.parse(JSON.parse(data.d)["div_data"]);

                if (JSON.parse(data.d)[1] != "") {
                    pdf_print_name = JSON.parse(data.d)["pdf_print_name"];
                }

                $('#print_data').html('');
       
                $('#print_data').append(course_data[0]["table"]);

                //set_svg();

                setTimeout(function () {
                    set_svg();
                    $('#btnprint').click();
                }, 2000);

                return true;
                //display_feedback_receipt_report_course_wise(data.d);
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
});

//end


$(document).on("click", ".send_feedback_pdf_mail", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var course_name = aData["course_name"];
    var total_course = aData["total_course"];
    var total_feedback = aData["total_feedback"];
    var dept_name = aData["dept_name"];

    var faculty_mail = aData["faculty_mail"];

    var typology_dtl = $.grep(obj_typology_data, function (data) { return data.type_code == aData.course_typology });

    //if (aData.course_typology == "10" || aData.course_typology == "11" || aData.course_typology == "13" || aData.course_typology == "2") {
    //if (aData.course_typology == "10" || aData.course_typology == "11"  || aData.course_typology == "2") {
    if (typology_dtl.length > 0 && typology_dtl[0]['sub_group'] == '') {
        bootbox.alert("You can not send mail for this course. Course is not eligible for feedback.");
        return false;
    }

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

    //var remark = aData["remark"];
    //$('#txtRejectRemark').val("");
    //if (remark != "") {
    //    $('#txtRejectRemark').val(remark);
    //}

    if (faculty_mail.toString().trim() == "") {
        bootbox.alert("Instructor's mail id not found for selected course : " + course_code);
        return false;
    }

    $('#hdn_course').val(course_code);
    //$('#hdn_faculty_mail').val(faculty_mail);
    //$('#myModal').modal('show');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/send_feedback_pdf_mail",
        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_code':'" + course_code + "','course_name':'" + course_name + "','total_course':'" + total_course + "','total_feedback':'" + total_feedback + "','dept_name':'" + dept_name + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d == "1") {
                    bootbox.alert('Mail sent');
                    get_course_faculty_wise_feedback_report();
                }
                else {
                    bootbox.alert(data.d);
                    return false;
                }
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
});

$(document).on("click", ".send_feedback_pdf_mail_individual", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var instructor_code = aData["instructor_code"];
    var course_name = aData["course_name"];
    var total_course = aData["total_course"];
    var total_feedback = aData["total_feedback"];
    var dept_name = aData["dept_name"];
    var instructor_name = aData["instructor_name"];
    var faculty_mail = aData["mail"];
    var typology_dtl = $.grep(obj_typology_data, function (data) { return data.type_code == aData.course_typology });

    if (typology_dtl.length > 0 && typology_dtl[0]['sub_group'] == '')
    {
        bootbox.alert("You can not send mail for this course. Course is not eligible for feedback.");
        return false;
    }

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

    

    if (faculty_mail.toString().trim() == "") {
        bootbox.alert("Instructor's mail id not found for selected course : " + course_code);
        return false;
    }

    $('#hdn_course').val(course_code);
    //$('#hdn_faculty_mail').val(faculty_mail);
    //$('#myModal').modal('show');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/send_feedback_pdf_mail_individual",
        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_code':'" + course_code + "','course_name':'" + course_name + "','total_course':'" + total_course + "','total_feedback':'" + total_feedback + "','dept_name':'" + dept_name + "','instructor_name' :'" + instructor_name + "','mail':'" + faculty_mail + "','instructor_code':'" + instructor_code + "','bulkmail':'false'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d == "1") {
                    bootbox.alert('Mail sent');
                    get_course_faculty_wise_feedback_report_for_send_pdf();
                }
                else {
                    bootbox.alert(data.d);
                    return false;
                }
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
});







$(document).on("click", "#btn_remark_submit", function (event) {
    if ($('#txtRejectRemark').val().trim() == "") {
        bootbox.alert("Please Enter Remarks for course : " + $('#hdn_course').val());
        return false;
    }
    else {
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

        var remarks = $('#txtRejectRemark').val().trim();

        if (remarks.search(/\\/) != -1) { remarks = remarks.replace(/\\/g, '\\\\'); }
        if (remarks.search("\"") != -1) { remarks = remarks.replace(/"/g, '\\\"'); }
        if (remarks.search("'") != -1) {
            remarks = remarks.replace(/\'/g, '\\\'');
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/save_feedback_remark",
            data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_code':'" + $('#hdn_course').val() + "','remark': '" + remarks + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "1") {
                        bootbox.alert('Mail sent');
                        get_course_faculty_wise_feedback_report();
                    }
                    else if (data.d == "2") {
                        bootbox.alert(data.d);
                        return false;
                    }
                    else {
                        bootbox.alert(data.d);
                    }
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

    return false;
});


function Get_feedback_raw_data() {
    $('#DataList').css('display', 'none');

    var feedback_type = $('#drp_feedback_type').val();
    if (feedback_type == "") {
        bootbox.alert('Please select feedback type')
        $('#drp_feedback_type').focus();
        return false;
    }

    var course_type = $('#drp_course_type').val();
    if (course_type == "") {
        bootbox.alert('Please select Course Type')
        $('#drp_course_type').focus();
        return false;
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_feedback_raw_data",
        data: "{'feedback_type':'" + feedback_type + "','course_type':'" + course_type + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                display_feedback_raw_data(data.d);
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

function BindData(data) {
    var columns = [];

    if (data != null && data != undefined && data.length > 0) {
        //columns.push({ "sTitle": "", "mData": null, fnRender: function (data) { return '<center><input type="checkbox" /></center>'; } });
        columns.push({ "sTitle": "<center><input type='checkbox' id='chk_select_all'></center>Select", "mData": null, "mRender": function () { return '<center><input type="checkbox" class="chk_select"></center>'; } });

        var row = data[0];
        for (var attr in row) {
            columns.push({ "sTitle": attr, "mData": attr });
        }
    }
    return columns;
}


function display_feedback_raw_data(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody><tfoot style="background-color:#f3f3f3"><tr><th>Total: </th> <th style="text-align: left"> </th>  <th style="text-align: left"></th>  <th style="text-align: left">   </th>  <th style="text-align: left"></th>  <th style="text-align: left">    </th>   <th style="text-align: left"></th> </tr>  </tfoot></table>');



    }

    var columns = [];

    if (data != null && data != undefined && data.length > 0) {

        var row = JSON.parse(data)[0];
        for (var attr in row) {
            columns.push({ "sTitle": attr, "mData": attr });
        }
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

        "aoColumns": columns




    });


    $('#DataList').css('display', 'block');
}



function get_all_typology_group() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_typology_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var res = JSON.parse(data.d);

                if (res['typology_detail'] != null) {
                    obj_typology_data = res['typology_detail'];
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function print_pdf() {
    var doc = new jsPDF();

    //We'll make our own renderer to skip this editor
    var specialElementHandlers = {
        '#chartContainer': function (element, renderer) {
            return true;
        }
    };

    //All units are in the set measurement for the document
    //This can be changed to "pt" (points), "mm" (Default), "cm", "in"

    var htmlString = "<html><body ><label>INPUT TYPE</label></body></html>";
    doc.fromHTML(htmlString, 15, 15, {
        'width': 500,
        'elementHandlers': specialElementHandlers
    });

    //doc.text(20, 20, 'Hello world.');
    doc.save("a.pdf");
    //doc.autoPrint()
    //doc.output('datauri');
    //doc.save("a.pdf");
}


function set_svg() {

    
    $('.instructor .dxc-labels-group rect').attr('x', '955');
    $('.instructor .dxc-labels-group text tspan').attr('x', '970');
    var str = '';
    //course Data 
    var data = $('.course .dxc-h-axis .dxc-elements');
    for (var i = 0; i < data.length; i++)
    {
        //data[i].firstElementChild.style.display = 'none';
        //data[i].lastElementChild.style.display = 'none';
        data[i].lastElementChild.previousSibling.setAttribute('x', '945');
        data[i].lastElementChild.setAttribute('x', '1000');
        data[i].lastElementChild.previousSibling.innerHTML = '<tspan x="945" y="30">COR</tspan><tspan x="945" y="49">AVG</tspan>';
        data[i].lastElementChild.innerHTML = '<tspan x="1000" y="30">FAC</tspan><tspan x="1000" y="49">AVG</tspan>';
        data[i].lastElementChild.previousSibling.previousSibling.innerHTML = '';

        //str = data[i].innerHTML;
        //str = str + "<text x='1040' y='30' text-anchor='middle' transform='rotate(0,1098,49)' style='fill: rgb(0, 0, 0); font-family: 'Segoe UI', 'Helvetica Neue', 'Trebuchet MS', Verdana; font-weight: 400; font-size: 12px; cursor: default;'>FAC</text>";
    }

    data = $('.instructor .dxc-h-axis .dxc-elements');
    for (var i = 0; i < data.length; i++)
    {
        data[i].lastElementChild.previousSibling.setAttribute('x', '945');
        data[i].lastElementChild.setAttribute('x', '1000');
        data[i].lastElementChild.previousSibling.innerHTML = '<tspan x="945" y="30">IND</tspan><tspan x="945" y="49">AVG</tspan>';
        data[i].lastElementChild.innerHTML = '<tspan x="1000" y="30">FAC</tspan><tspan x="1000" y="49">AVG</tspan>';
        data[i].lastElementChild.previousSibling.previousSibling.innerHTML = '';
    }

    data = $('.onlinelerning .dxc-h-axis .dxc-elements');
    for (var i = 0; i < data.length; i++) {

        data[i].lastElementChild.previousSibling.setAttribute('x', '945');
        data[i].lastElementChild.setAttribute('x', '1000');
        data[i].lastElementChild.previousSibling.innerHTML = '<tspan x="945" y="30">COR</tspan><tspan x="945" y="49">AVG</tspan>';
        data[i].lastElementChild.innerHTML = '<tspan x="1000" y="30">FAC</tspan><tspan x="1000" y="49">AVG</tspan>';
        data[i].lastElementChild.previousSibling.previousSibling.innerHTML = '';

        //str = data[i].innerHTML;
        //str = str + "<text x='1040' y='30' text-anchor='middle' transform='rotate(0,1098,49)' style='fill: rgb(0, 0, 0); font-family: 'Segoe UI', 'Helvetica Neue', 'Trebuchet MS', Verdana; font-weight: 400; font-size: 12px; cursor: default;'>FAC</text>";
    }
   

    data = $('.course .dxc-h-axis .dxc-grid');
    for (var i = 0; i < data.length; i++)
    {
        data[i].lastElementChild.style.display = 'none';
        data[i].lastElementChild.previousSibling.style.display = 'none';
        data[i].lastElementChild.previousSibling.previousSibling.style.display = 'none';
    }

    data = $('.instructor .dxc-h-axis .dxc-grid');
    for (var i = 0; i < data.length; i++)
    {
        data[i].lastElementChild.style.display = 'none';
        data[i].lastElementChild.previousSibling.style.display = 'none';
        data[i].lastElementChild.previousSibling.previousSibling.style.display = 'none';
    }

    data = $('.onlinelerning .dxc-h-axis .dxc-grid');
    for (var i = 0; i < data.length; i++) {
        data[i].lastElementChild.style.display = 'none';
        data[i].lastElementChild.previousSibling.style.display = 'none';
        data[i].lastElementChild.previousSibling.previousSibling.style.display = 'none';
    }



    $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').attr('text-anchor', 'inherit');
    data = $('.course .dxc-axes-group .dxc-v-axis .dxc-elements tspan');
    for (var i = 0; i < data.length; i++)
    {
        if (data[i].innerHTML == '10.0') {
            data[i].setAttribute('x', '927');
            data[i].setAttribute('fill', '#266473');
        }
        else if (data[i].innerHTML.length == 3) {
            data[i].setAttribute('x', '935');
            data[i].setAttribute('fill', '#85A9B1');
        }
        else if (data[i].innerHTML.length > 3) {
            data[i].setAttribute('x', '0');
        }
    }

    data = $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text');

    for (var i = 0; i < data.length; i++)
    {
        var total_dy = 0;

        for (var j = 0; j < (data[i].children.length - 1); j++) {
            total_dy += parseInt(data[i].children[j].getAttribute('dy'));
        }

        data[i].children[data[i].children.length - 1].setAttribute('dy', '-' + (total_dy / 2));

        //if (data[i].children.length > 3) {
        //    //data[i].children[data[i].children.length - 1].setAttribute('dy', '-12');
        //}
    }

   

    $('.onlinelerning .dxc-axes-group .dxc-v-axis .dxc-elements text').attr('text-anchor', 'inherit');

    data = $('.onlinelerning .dxc-axes-group .dxc-v-axis .dxc-elements tspan');
    for (var i = 0; i < data.length; i++) {
        if (data[i].innerHTML == '10.0') {
            data[i].setAttribute('x', '927');
            data[i].setAttribute('fill', '#266473');
        }
        else if (data[i].innerHTML.length == 3) {
            data[i].setAttribute('x', '935');
            data[i].setAttribute('fill', '#85A9B1');
        }
        else if (data[i].innerHTML.length > 3) {
            data[i].setAttribute('x', '0');
        }
    }

   
    data = $('.onlinelerning .dxc-axes-group .dxc-v-axis .dxc-elements text');

    for (var i = 0; i < data.length; i++) {
        var total_dy = 0;

        for (var j = 0; j < (data[i].children.length - 1); j++)
        {
            total_dy += parseInt(data[i].children[j].getAttribute('dy'));
        }

        data[i].children[data[i].children.length - 1].setAttribute('dy', '-' + (total_dy / 2));

        //if (data[i].children.length > 3) {
        //    //data[i].children[data[i].children.length - 1].setAttribute('dy', '-12');
        //}
    }




    $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').attr('text-anchor', 'inherit');

    data = $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements tspan');
    for (var i = 0; i < data.length; i++) {
        if (data[i].innerHTML == '10.0') {
            data[i].setAttribute('x', '927');
            data[i].setAttribute('fill', '#266473');
        }
        else if (data[i].innerHTML.length == 3) {
            data[i].setAttribute('x', '935');
            data[i].setAttribute('fill', '#266473');
        }
        else if (data[i].innerHTML.length > 3) {
            data[i].setAttribute('x', '0');
        }
    }

    data = $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text');

    for (var i = 0; i < data.length; i++) {
        var total_dy = 0;

        for (var j = 0; j < (data[i].children.length - 1); j++) {
            total_dy += parseInt(data[i].children[j].getAttribute('dy'));
        }

        data[i].children[data[i].children.length - 1].setAttribute('dy', '-' + (total_dy / 2));

        //if (data[i].children.length > 3) {
        //    //data[i].children[data[i].children.length - 1].setAttribute('dy', '-12');
        //}
    }


    $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");
    $('.onlinelerning .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");    
    $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");

    //$('.onlinelerning .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");

    //$('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').css("font-size", "13px");
    //$('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').css("font-size", "13px");

    $('.course .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");
    $('.onlinelerning .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");
    $('.instructor .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");
    //$('.onlinelerning .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");

    $('.course .dxc-labels-group text tspan').css("font-weight", "bold");
    $('.course .dxc-labels-group text tspan').css("font-size", "15px");

    $('.onlinelerning .dxc-labels-group text tspan').css("font-weight", "bold");
    $('.onlinelerning .dxc-labels-group text tspan').css("font-size", "15px");
   

    $('.instructor .dxc-labels-group text tspan').css("font-weight", "bold");
    $('.instructor .dxc-labels-group text tspan').css("font-size", "15px");

    //$('.onlinelerning .dxc-labels-group text tspan').css("font-weight", "bold");
    //$('.onlinelerning .dxc-labels-group text tspan').css("font-size", "15px");

    $('.course .dxc-labels-group rect').attr('x', '955');
    $('.course .dxc-labels-group text tspan').attr('x', '970');


    $('.onlinelerning .dxc-labels-group rect').attr('x', '955');
    $('.onlinelerning .dxc-labels-group text tspan').attr('x', '970');
   

    data = $('.course .dxc-series-group');
    for (var i = 0; i < data[0].children[0].children[1].children.length; i++)
    {
        data[0].children[0].children[1].children[i].setAttribute('fill', '#85A9B1');
    }

    //$('.course .dxc-series-group .dxc-series .dxc-markers').attr('fill', '#85A9B1');
    $('.course .dxc-trackers .dxc-markers-trackers').attr('display', 'none');


    data = $('.onlinelerning .dxc-series-group');
    if (data.length > 0)
    {
        for (var i = 0; i < data[0].children[0].children[1].children.length; i++) {
            data[0].children[0].children[1].children[i].setAttribute('fill', '#85A9B1');
        }
    }
    
    $('.onlinelerning .dxc-trackers .dxc-markers-trackers').attr('display', 'none');
    

    data = $('.instructor .dxc-labels-group');
    for (var i = 0; i < data.length; i++) {
        data[i].children[0].style.display = 'none';
    }

    //data = $('.onlinelerning .dxc-labels-group');
    //for (var i = 0; i < data.length; i++) {
    //    data[i].children[0].style.display = 'none';
    //}

    //$('.instructor .dxc-labels-group .dxc-series-labels')[0].style.display = 'none';
}

//kapil


$(document).on("click", ".pdf_download", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var instructor_code = aData["instructor_code"];
    var course_name = aData["course_name"];
    var total_course = aData["total_course"];
    var total_feedback = aData["total_feedback"];
    var dept_name = aData["dept_name"];
    var instructor_name = aData["instructor_name"].replace(/'/g, ' ');
    var semester = $('#drpsemester').val();
    var year_code = $('#drpyear').val();
    var dep_name = "";
    //var faculty_mail = aData["mail"];
    //FM_UM4000_Gayatri Doctor_Spring_2020
    //var typology_dtl = $.grep(obj_typology_data, function (data) { return data.type_code == aData.course_typology });
    if (semester == 'S') {
        semester = 'Spring';
    }
    else
    {
        semester = 'Monsoon';
    }
         
    switch (dept_name) {
        case "Architecture":
            dep_name = "FA";
            break;
        case "Design":
            dep_name = "FD";
            break;
        case "Management":
            dep_name = "FM";
            break;
        case "Planning":
            dep_name = "FP";
            break;
        case "Technology":
            dep_name = "FT";
            break;
        case "CEPT Foundation Program":
            dep_name = "CFP";
            break;
        case "Doctoral Programs":
            dep_name = "DP";
            break;
    }
    
    var link = dep_name + "_" + course_code + "_" + instructor_name + "_" + semester + "_" + year_code + '.pdf';

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/FileExits",
        data: "{'dep_name':'" + dep_name + "','course_code':'" + course_code + "','instructor_name':'" + instructor_name + "','semester':'" + semester + "','year_code':'" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "")
            {
                if (data.d == "1")
                {
                    //$("#filename").val(link);
                    window.open('https://connect.cept.ac.in/' + 'FeedbackPdf' + '/' + link, '_blank');
                    //$("#btnDownloadExcelDocuments").click();
                    return false;
                }
                else
                {
                    bootbox.alert('File Not Exits Please Upload Server');
                }
                return true;

            }
            else {
                bootbox.alert('File Not Exits');
            }
        },
        error: function (result) {
            alert(result);
        }
    });

   // window.open('http://localhost:1121/' + 'FeedbackPdf' + '/' + link,'_blank' );
    return false;
});


$(document).on("click", ".send_feedback_pdf_mail_bulk", function (event) {

    var course_code = "";
    var instructor_code = "";
    var course_name = "";
    var total_course = "";
    var total_feedback = "";
    var dept_name = "";
    var instructor_name = "";
    var faculty_mail = "";
    var pdfstatus = "";
    var typology_dtl = "";


    var obj_selected_course = $('.cls_chk_course_select:checked');
    if (obj_selected_course.length > 0) {
        publish_data_course = [];
        debugger;
        for (var i = 0; i < obj_selected_course.length; i++) {
            var aData = oTable.fnGetData(obj_selected_course[i].closest('tr'));
            debugger;
            publish_data_course.push({

                course_code: aData["course_code"],
                instructor_code: aData["instructor_code"],
                             course_name : aData["course_name"],
                             total_course : aData["total_course"],
                             total_feedback : aData["total_feedback"],
                             dept_name : aData["dept_name"],
                             instructor_name : aData["instructor_name"],
                             faculty_mail : aData["mail"],
                             typology_dtl : $.grep(obj_typology_data, function (data) { return data.type_code == aData.course_typology }),
                               pdfstatus: aData['pdfstatus']
            });
           
        }

    }
    else {
        bootbox.alert("Please Select Check box");
        return false;
    }





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



    //if (faculty_mail.toString().trim() == "") {
    //    bootbox.alert("Instructor's mail id not found for selected course : " + course_code);
    //    return false;
    //}

    $('#hdn_course').val(course_code);
    //$('#hdn_faculty_mail').val(faculty_mail);
    //$('#myModal').modal('show');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/send_feedback_pdf_mail_individual",
        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_code':'" + course_code + "','course_name':'" + course_name + "','total_course':'" + total_course + "','total_feedback':'" + total_feedback + "','dept_name':'" + dept_name + "','instructor_name' :'" + instructor_name + "','mail':'" + faculty_mail + "','instructor_code':'" + instructor_code + "','bulkmail':'" + JSON.stringify(publish_data_course) + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d == "1") {
                    bootbox.alert('Mail sent');
                    get_course_faculty_wise_feedback_report_for_send_pdf();
                }
                else {
                    bootbox.alert(data.d);
                    return false;
                }
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
});
