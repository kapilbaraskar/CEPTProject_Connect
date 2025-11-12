var oTable;


$(document).ready(function () {

    bindsemdata();
    bindyeardata_for_cross_reg();
    bindprogramme();
    bindproglevel();

    $('#btnreterive').on('click', function () {
        get_vf_personal_detail();
        return false;
    });
    $('#btndownload').on('click', function () {
        download_image();
        return false;
    });

    setCurrentSemester();
});


$('#btndownload').on('click', function () {
    download_image();
    return false;
});


function download_image() {
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

    //var data = oTable.fnGetData();
    //if (data.length > 0) {//}

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Download_User_Profile_Image",
            //async: false,
            data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "2") {
                        bootbox.alert("No Data Found");
                        return false;
                    }
                    else
                    {
                        var origin = window.location.origin;
                        window.open(origin + '/' + 'UserPersonalPhoto' + '/' + 'UserPersonalPhoto.zip');
                        return false;
                    }

                    return false;

                }
                else {
                    bootbox.alert('No data found for selected criteria');
                    return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}



function bindsemdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

    $('#drpsemester').chosen();

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

function rowClick(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //alert("ID : " + rowId);
    window.location = "vf_edit_personal_detail.aspx?ic=" + rowId;
}

var semester = '';
var year_code = '';
var prog_code = '';
var prog_level_code = '';

function get_vf_personal_detail() {
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
        url: "../../WebService.asmx/get_vf_personal_detail",
        //async: false,
        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {

                display_get_vf_personal_detail(data.d);
                
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

    return false;
}

function set_table_columns(row) {
    var columns = [];
    //for (var attr in row) {
    //  columns.push({ "sTitle": attr, "mData": attr });
    //} 

    columns.push({ "sTitle": "Instructor Code", "mData": "instructor_code" });
    columns.push({ "sTitle": "VF Code", "mData": "VF_code" });
    columns.push({ "sTitle": "Instructor Name", "mData": "instructor_name" });
    columns.push({ "sTitle": "Grade", "mData": "designation", "sClass": "cls_hide" });
    //columns.push({ "sTitle": "Admin Approved", "mData": "admin_approved" });
    columns.push({ "sTitle": "Associated with other Faculty", "mData": "other_dept" });

    var edit_column = { "sTitle": "Edit", "mData": null, "bSortable": false, mRender: function (data) {
        //if (data.aData.admin_approved != 'Approved') return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
        //else return '';
        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>'
    }};

    columns.push(edit_column);


   
    
    return columns;
}

function display_get_vf_personal_detail(data) {

    var columns = set_table_columns(JSON.parse(data)[0]);

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
       // "sDom": 't',
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

        "aoColumns": columns

    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';

    $('#example thead tr')[0].children[0].style.display = 'none';

    $("#example tbody tr").each(function (i) {
        $(this).children().eq(0)[0].style.display = 'none';
    });
}
