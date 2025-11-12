var oTable, oTable2;


$(document).ready(function () {

    if ($('#hdnusertype').val() == 'PC') {
        var str = "<div id='div_myTab'><ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Grade Entry and Approval&nbsp;</a></li>" +
                            "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li></ul></div>" +
                    "<div class='tab-content'><div id='pendingcourse' class='tab-pane in active'><div id='DataList_progcoord' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example_progcoord' class='display table table-striped table-bordered table-hover' width='100%'><thead></thead><tbody></tbody></table>" +
                            "</div></div>" +
                        "<div id='mycourses' class='tab-pane'><div id='DataList' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                    "<thead></thead><tbody></tbody></table></div></div></div>";

        $('#div_course_list').removeClass('panel panel-default');
        $('#div_course_list').html(str);
    }
    else if ($('#hdnusertype').val() == 'D') {
        var str = "<div id='div_myTab'><ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Grade Entry and Approval&nbsp;</a></li>" +
                            "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li></ul></div>" +
                    "<div class='tab-content'><div id='pendingcourse' class='tab-pane in active'><div id='DataList_progcoord' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example_progcoord' class='display table table-striped table-bordered table-hover' width='100%'><thead></thead><tbody></tbody></table>" +
                            "</div></div>" +
                        "<div id='mycourses' class='tab-pane'><div id='DataList' style='display: none;'>" +
                                "<table cellpadding='0' cellspacing='0' border='0' id='example' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                    "<thead></thead><tbody></tbody></table></div></div></div>";

        $('#div_course_list').removeClass('panel panel-default');
        $('#div_course_list').html(str);
    }

    bindsemdata();
    bindyeardata_for_cross_reg();
    bindprogramme();
    bindproglevel();

    $('#btnreterive').on('click', function () {
        course_wise_entered_marks();
        return false;
    });

    setCurrentSemester();

});

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

function setCurrentSemester() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_current_grade_semester",
        //async: false,
        data: "{}",
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



function rowClick(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

    window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;

    //window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
}

function rowClick_view(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

    window.location = "View_Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;

    //window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
}


function publish_all() {
    if ($('#hdnusertype').val() == 'A1') {
        bootbox.confirm('Are you sure you want to publish all courses?', function (result) {
            if (result == true) {
                bootbox.confirm('After Publish you can not change grade , Are you sure you want to publish all courses?', function (result2) {
                    if (result2 == true) {
                        if (oTable != undefined) {
                            if (oTable.fnGetData().length > 0) {
                                $.ajax({
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    url: "../../WebService.asmx/publish_all_course_grade",
                                    //async: false,
                                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                                    dataType: "json",
                                    success: function (data) {
                                        if (data.d != "" && data.d != "[]") {
                                            if ($('#hdnusertype').val() == 'A1') {
                                                //course_wise_entered_marks_list_UGPG(data.d);
                                                bootbox.alert(data.d);
                                            }
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
                        } 
                    }
                });
            }
        });
    }
    else {
        bootbox.alert('You are not Authorized to Publish Course');
    }
}

var semester = '';
var year_code = '';
var prog_code = '';
var prog_level_code = '';
var asInitVals = new Array();

function course_wise_entered_marks() {
    $('#DataList').css('display', 'none');
    $('#div_btn').html('');

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
        url: "../../WebService.asmx/course_wise_entered_marks_list",
        //async: false,
        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {
                if ($('#hdnusertype').val() == 'A1') {
                    course_wise_entered_marks_list_UGPG(data.d);
                }
                else if ($('#hdnusertype').val() == 'FA') {
                    course_wise_entered_marks_list_FA(data.d);
                }
                else {
                    course_wise_entered_marks_list(data.d);
                }
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

    if ($('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D') {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/course_wise_entered_marks_list_PC",
            //async: false,
            data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    course_wise_entered_marks_list_PC(data.d);
                    $('#div_course_list').css('display', 'block');
                }
                else {
                    bootbox.alert('No data Found For Selected Semester and Year');
                    //$('#div_course_list').css('display', 'none');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }

    return false;
}


function course_wise_entered_marks_list(data) {

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
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
   //     "oTableTools": {
   //         "aButtons": [
   //         //"copy",
			//	"print",
   //         	{
   //         	    "sExtends": "collection",
   //         	    "sButtonText": 'Export',
   //         	    "aButtons": ["xls"]
   //         	}
			//]
   //     },

        "aaData": JSON.parse(data),

        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Title", "mData": "course_name", "bSortable": false },
            { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
            { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },
        //{ "sTitle": "Total Marks Entered", "mData": null, "bSortable": false },


        //            { "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
        //                //alert(course_code);
        //                return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
        //            }
        //            }


            {"sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D') {
                    if (data.faculty_approval != 'Approved' && data.progcoordinate_approval != 'Approved' && data.ugpg_approval != 'Approved')
                    {
                        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                        //if ($('#hdn_degination').val() == "instructor") {
                        //    return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                        //}
                        //else { return '';}
                        
                    }
                    else {
                        return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                    }
                }
                else {
                    return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                }
                //else {
                //    return '';
                //}
            }
        }


        //            { "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
        //                //alert(course_code);
        //                return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
        //            }
        //            }
        ]
    });

    $('#DataList').css('display', 'block');
    $('#div_btn').html('');
}



function course_wise_entered_marks_list_PC(data) {

    if (oTable2 != null) {
        oTable2.fnDestroy();
        $("#DataList_progcoord").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_progcoord" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable2 = $("#example_progcoord").dataTable({

        "bPaginate": true,
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
   //     "oTableTools": {
   //         "aButtons": [
   //         //"copy",
			//	"print",
   //         	{
   //         	    "sExtends": "collection",
   //         	    "sButtonText": 'Export',
   //         	    "aButtons": ["xls"]
   //         	}
			//]
   //     },

        "aaData": JSON.parse(data),

        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Title", "mData": "course_name", "bSortable": false },
            { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
            { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },

            {"sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
            }
        }
        ]
    });

    $('#DataList_progcoord').css('display', 'block');
    $('#div_btn').html('');
}



function course_wise_entered_marks_list_UGPG(data) {

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
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"oLanguage": {
            //"sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
            //"aButtons": [
            ////"copy",
				//"print",
            	//{
            	    //"sExtends": "collection",
            	    //"sButtonText": 'Export',
            	    //"aButtons": ["xls"]
            	//}
			//]
        //},

        "aaData": JSON.parse(data),

        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Title", "mData": "course_name", "bSortable": false },
            
            //{ "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
            //{ "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },
        
            {
                "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
            }
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
    for (var i = 0; i < 4; i++) {
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
    if ($('#hdnusertype').val() == 'A1') {
        $('#div_btn').html('<button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="publish_all()">Publish All</button>');
    }
}


function course_wise_entered_marks_list_FA(data) {

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
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
   //     "oTableTools": {
   //         "aButtons": [
   //         //"copy",
			//	"print",
   //         	{
   //         	    "sExtends": "collection",
   //         	    "sButtonText": 'Export',
   //         	    "aButtons": ["xls"]
   //         	}
			//]
   //     },

        "aaData": JSON.parse(data),

        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Title", "mData": "course_name", "bSortable": false },

            { "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
            { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

            {"sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approval", "bSortable": false },

            { "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                if ($('#hdnusertype').val() == 'FA') {
                    if (data.faculty_approval != 'Approved' || data.progcoordinate_approval != 'Approved') {
                        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                    }
                    else {
                        return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                    }
                }
                //return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
            }
            }
        ]
    });

    $('#DataList').css('display', 'block');
    $('#div_btn').html('');
}

