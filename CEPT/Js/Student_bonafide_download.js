var oTable, oTable2;


$(document).ready(function () {



    bindsemdata();
    bindyeardata_for_cross_reg();
    binddepartment();
    // bindprogramme();
    // bindproglevel();

    $('#btnreterive').on('click', function () {
        bonafide_dtl();
        return false;
    });
    $('#btndownload').on('click', function () {
        BulkDownloadVisa();
        return false;
    });

    // setCurrentSemester();

});

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
    $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
    $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

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

    window.location = "download_visa.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;

    //window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
}




var semester = '';
var year_code = '';
var prog_code = '';
var prog_level_code = '';
var asInitVals = new Array();

function bonafide_dtl() {
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

    var dept_code = $('#drpdepartment').val();
    //prog_code = $('#drpprog').val();
    //prog_level_code = $('#drpproglevel').val();

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_SWS_publish_Course_dtl_with_file_name",
            //async: false,
            data: "{semester_type:'" + semester + "',year_semester:'" + year_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {

                    Student_bonafide_dtl(data.d);

                    $('#div_course_list').css('display', 'block');
                }
                else {
                    bootbox.alert('No data Found For Selected Semester and Year');

                }
            },
            error: function (result) {
                alert(result);
            }
        });

    

    return false;
}










function Student_bonafide_dtl(data) {

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
            {
                "sTitle": "<center><input type='checkbox' id='chk_select_all_student' onchange='select_all_student()' /> Select</center>", "mData": null, "bSortable": false, mRender: function (data) {

                    var row_value = data.course_code;
                    
                        return '<center><input type="checkbox"  name="check_all_student" value="1" class="chk_course" id="' + row_value + '" /></center>';
                    

                }

            },

            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Title", "mData": "course_name", "bSortable": false },

            //{ "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
            //{ "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

            { "sTitle": "Total Student", "mData": "total_student", "bSortable": false },

            //{
            //    "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
            //        return '<center><button type="button" onclick="rowClick_view(this)">Edit</button></center>';
            //    }
            //}
            {
                "sTitle": "Download PDF", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.visa_file_name == "true") {
                        return '<center><button type="button" onclick="rowClick_download_visa(this)">Download</button></center>';
                    }
                    else { return ''; }

                }
            }
        ]
    });

    //var thead = $('<tr class="dt"></tr>');
    //$('#example thead th').each(function (i, r) {
    //    var nm = $('#example thead th').eq($(this).index()).text();
    //    thead.append('<th></th>');
    //});
    //$('#example thead').append(thead);
    ////adding input box in thead second row  
    //for (var i = 0; i < 4; i++) {
    //    var title = $('#example thead th').eq(i).text();
    //    $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    //};
    //$("thead input").keyup(function () {
    //    /* Filter on the column (the index) of this element */
    //    oTable.fnFilter(this.value, $("thead input").index(this));
    //});
    //$("thead input").each(function (i) {
    //    asInitVals[i] = this.value;
    //});
    //$("thead input").focus(function () {
    //    if (this.className == "search_init") {
    //        this.className = "";
    //        this.value = "";
    //    }
    //});
    //$("thead input").blur(function (i) {
    //    if (this.value == "") {
    //        this.className = "search_init";
    //        this.value = asInitVals[$("thead input").index(this)];
    //    }
    //});

    $('#DataList').css('display', 'block');


}
function rowClick_download_visa(row) {

    var rowId = row.parentElement.parentElement.parentElement.childNodes[1].childNodes[0].nodeValue;

    var semester = $('#drpsemester').val();
    var year_code = $('#drpyear').val();



    if (semester == 'S') {
        semester = 'Summer';
    }
    else { semester = 'Winter'; }
    document.getElementById('Link').download = rowId + ' ' + 'Bonafide Letter';
    document.getElementById('Link').href = '';
    document.getElementById('Link').href = window.location.origin + '\\SWS_StudentBonafideLetter\\' + rowId + '_' + semester + '_' + year_code + '.pdf';
    document.getElementById('Link').click();
}

function select_all_student() {
    if ($('#chk_select_all_student')[0].checked) {
        $("input[name='check_all_student']").attr('checked', 'checked');
    }
    else {
        $("input[name='check_all_student']").removeAttr('checked');
    }
}

function BulkDownloadVisa() {
    var sem_code = $('#drpsemester').val();
    if (sem_code == '') {
        bootbox.alert("Please Select Semester");
        return false;
    }
    var year_code = $('#drpyear').val();
    if (year_code == '') {
        bootbox.alert("Please Select Year");
        return false;
    }

    var oSettings = oTable.fnSettings();

    for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
        oSettings.aoPreSearchCols[iCol].sSearch = '';
    }

    oSettings.oPreviousSearch.sSearch = '';
    oTable.fnDraw();

    var flag = "N";

    var datalist = [];
    $("#example tbody tr").each(function (i) {
        var obj = {};
        if ($(this).find(".chk_course").is(':checked')) {
            flag = 'Y';
            obj = {};
            obj["course_code"] = $(this).children().eq(0)[0].children[0].childNodes[0].id;
            datalist.push(obj);
        }
    });

    if (flag == "Y") {
        var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), student_code: '' });

        $.ajax({
            type: "POST",
            url: "../../WebService.asmx/BulkDownloadBonafide",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "Problem in save data") {
                        bootbox.alert("Problem in save data");
                        return false;
                    }
                    bootbox.alert("Student Visa Genrate Successfully");
                    location.reload();
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    }
    else {
        bootbox.alert("Please Checked Checkbox");
        return false;
    }
}



