var oTable;
var course_detail;
var rate_band;
var workload_detail;
var action = 'S';


$(document).ready(function () {

    bindsemdata();
    bindyeardata_for_cross_reg();

    get_rate_band();

    $('#btnreterive').on('click', function () {
        get_vf_rate_band_detail();
        return false;
    });

});


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

function get_rate_band() {
    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_rate_band",
        //async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {
                var obj_rate_band = JSON.parse(data.d);
                rate_band = '';
                for (var i = 0; i < obj_rate_band.length; i++) {
                    rate_band = rate_band + "<option>" + obj_rate_band[i]['rate_band'] + "</option>";
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
function get_vf_rate_band_detail() {
    $('#DataList').css('display', 'none');
    $('#div_btn').html('');
    $('#submitBtnDiv').css('display', 'none');

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

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_vf_rate_band_detail_for_HR",
        //async: false,
        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {

                workload_detail = JSON.parse(data.d);

                display_get_vf_personal_detail(data.d);

                $('#div_course_list').css('display', 'block');
                $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
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

function checkedChange() {
    if (document.activeElement.checked) {
        var parent = document.activeElement.parentElement.parentElement;
        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();' checked='checked'/></center>" +
                                    "<center><select class='cls_drp_rate_band' style='width:65px;margin-top:2px;'>" + rate_band + "</select></center>" +
                                    "<center><input type='text' value='' class='inline_input' style='width:70px;margin-top:2px;'/></center>";

        parent.innerHTML = str;
    }
    else {
        var parent = document.activeElement.parentElement.parentElement;
        var str = "<center><input type='checkbox' class='cls_chk_change_band' onchange='return checkedChange();'/></center>";

        parent.innerHTML = str;
    }
}

function set_table_columns(row) {
    var columns = [];
    for (var attr in row) {
        columns.push({ "sTitle": attr, "mData": attr });
    }

    var edit_column = { "sTitle": "Edit", "mData": null, "bSortable": false, fnRender: function (data) {
        if (data.aData.admin_approved != 'Approved') return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
        else return '';
    }
    };

    columns.push(edit_column);

    return columns;
}

function display_get_vf_personal_detail(data) {

    //var columns = set_table_columns(JSON.parse(data)[0]);

    var columns = [{ "sTitle": "Instructor Code", "mData": "instructor_code" },
                    { "sTitle": "VF Code", "mData": "VF_code" },
                    { "sTitle": "Instructor Name", "mData": "instructor_name" },
                    //{ "sTitle": "Designation", "mData": "designation" },
                    {"sTitle": "Designation", "mData": null, "bSortable": false, "mRender": function (data) {
                        if (data.rate_wise_designation != '')
                            return data.rate_wise_designation;
                        else
                            return data.designation;
                    }
                    },
                    { "sTitle": "Total Experiance", "mData": "total_experiance" },
                    { "sTitle": "Highest Qualification", "mData": "highest_qualification" },
                    { "sTitle": "Associate with Faculty", "mData": "vf_dept" },
                    { "sTitle": "Rate Band", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.alternate_band != '') {
                            return data.alternate_band;
                        }
                        else {
                            return data.rate_band;
                        }
                    }
                    },
                    { "sTitle": "Justification", "mData": "justification" },
                    { "sTitle": "Admin Approval", "mData": "admin_approved" }
                    ];

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

    if ($('#hdnusertype').val() == 'HR') {
        var str = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                  "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
        $('#submitBtnDiv').html(str);
    }


    $('#btnapprove').on('click', function () {

        var All_instructor_workload_data = [];
        action = 'A';

        $("#example tbody tr").each(function (i) {
            var instructor_workload_data = { 'instructor_code': ''};

            instructor_workload_data.instructor_code = $(this).children()[0].innerHTML;

            All_instructor_workload_data.push(instructor_workload_data);
        });

        var All_instructor_data = [All_instructor_workload_data, action];
        var json_All_instructor_data = JSON.stringify(All_instructor_data);

        if (json_All_instructor_data.search("'") != -1) {
            json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/hr_approve_rate_band_detail",
            async: false,
            data: "{ All_table_course_data: '" + json_All_instructor_data + "' }",
            dataType: "json",
            success: function (data) {

                if (data.d == 'Data Saved Successfully') {
                    if (action == 'A') {
                        bootbox.alert('Data Submitted Successfully', function () {
                            //window.location = "vf_work_load_mgmt.aspx";
                            $('#btnreterive').click();
                        });
                    }
                    else {
                        bootbox.alert(data.d, function () {
                            //location.reload();
                            $('#btnreterive').click();
                        });
                    }
                }
                else if (data.d != "") {
                    alert(data.d);
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    });

    $('#DataList').css('display', 'block');

    $('#example thead tr')[0].children[0].style.display = 'none';

    $("#example tbody tr").each(function (i) {
        $(this).children().eq(0)[0].style.display = 'none';
    });
}
