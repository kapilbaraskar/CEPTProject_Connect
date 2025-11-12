var oTable;
var sem = '';
var year = '';
var asInitVals = new Array();

$(document).ready(function () {
    bindsemdata();
    bindyeardata_for_cross_reg();

    $('#drpsemester').on('change', function () {
        if ($('#drpsemester').val() != '' && $('#drpyear').val() != '') {
            bind_sem_course();
        }
        if ($('#drpsemester').val() == '')
        {
            $('#drcourses')
            .find('option')
            .remove()
            .end()
            .append('<option value="">No Data found</option>')
            .val('');

            $('#drcourses').chosen();
            $('#drcourses').val('').trigger("liszt:updated");
        }
    });

    $('#drpyear').on('change', function () {
        if ($('#drpsemester').val() != '' && $('#drpyear').val() != '') {
            bind_sem_course();
        }
        if ($('#drpyear').val() == '') {
            $('#drcourses')
            .find('option')
            .remove()
            .end()
            .append('<option value="">No Data found</option>')
            .val('');

            $('#drcourses').chosen();
            $('#drcourses').val('').trigger("liszt:updated");
        }
    });

    setCurrentSemester();

});

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

                    $('#drpyear').trigger('change');
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function retrieveClick() {
    if ($('#drcourses').val() != '' && $('#drcourses').val() != null) {
        student_wise_grade();
    }
    else if ($('#drcourses').val() == '') {
        bootbox.alert('Please select Course');
    }
    else if ($('#drcourses').val() == null) {
        bootbox.alert('Please select Semester and Year to get Course List');
    }
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

function bind_sem_course() {
    sem = $('#drpsemester').val();
    if (sem == "") {
        $('#drpsemester').focus();
        return false;
    }

    year = $('#drpyear').val();
    if (year == "") {
        $('#drpyear').focus();
        return false;
    }   

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        //url: "../../WebService.asmx/Get_course_data_new",
        url: "../../WebService.asmx/Get_course_for_student_wise_grade",
        async: false,
        data: "{sem_code : '" + sem + "',year_code : '" + year + "'}",
        dataType: "json",
        success: function (data) {
            
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));
                for (var i = 0; i < year_data.length; i++) {
                    $('#drcourses').append($("<option></option>").val(year_data[i]["course_code"]).html(year_data[i]["course_code"]));
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

function student_wise_grade() {
    $('#DataList').css('display', 'none');

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_student_wise_grade",
        //async: false,
        data: "{course_code:'" + $('#drcourses').val() + "',sem_code:'" + sem + "',year_code:'" + year + "'}",
        dataType: "json",
        success: function (data) {
            
            if (data.d != "" && data.d != "[]") {
                
                student_wise_grade_list(data.d);
                $('#div_stud_list').css('display', 'block');
            }
            else {
                bootbox.alert('No data Found For Selected Course , Semester and Year');
                $('#div_stud_list').css('display', 'none');
            }
        },
        error: function (result) {
            
            alert(result);
        }
    });

    return false;
}


function student_wise_grade_list(data) {

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
        //    //"copy",
		//		"print",
        //    	{
        //    	    "sExtends": "collection",
        //    	    "sButtonText": 'Export',
        //    	    "aButtons": ["xls"]
        //    	}
		//	]
        //},

        "aaData": JSON.parse(data),

        "aoColumns": [
            { "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Subject Marks", "mData": "subject_marks", "bSortable": false },
            { "sTitle": "Subject Grade", "mData": "course_grade", "bSortable": false },
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

