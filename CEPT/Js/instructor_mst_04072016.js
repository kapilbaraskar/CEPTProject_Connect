
var oTable;

$(document).ready(function () {

    get_all_instructor();

    $('#btn_reset').on('click', function () {

        $('#txt_instructor_name').val('');

        $('#txt_mail').val('');

        $('#hdn_instructor_code').val('');
        $('#drp_user_type').val('I2');

        $('.lable_name').text('Add new Instructor');
        $('#btn_save').text('Save');

        oTable.fnFilter('');
        var oSettings = oTable.fnSettings();
        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable.fnDraw();

        return false;
    });

    $('#txt_instructor_name').on('keyup', function () {


        //  oTable.fnFilter($('#txt_instructor_name').val());
        if ($('#hdn_instructor_code').val().trim() == '') {
            oTable.fnFilter($('#txt_instructor_name').val(), 0);
        }


    });

    $('#btn_save').on('click', function () {


        debugger;
        var instructor_name = $('#txt_instructor_name').val().trim();

        if (instructor_name == "") {

            bootbox.alert("Please add instructor name");
            return false;

        }

        var instructor_code = $('#hdn_instructor_code').val();

        var email = $('#txt_mail').val().trim();

        var user_type = $('#drp_user_type').val().trim();

        if (email != "") {


            var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
            if (testEmail.test(email)) {

            }
            else {
                bootbox.alert("Please Enter Valid Email");
                $('#txtemail').focus();

                return false;
            }
        }


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/change_instructor_mst",
            async: false,
            data: "{instructor_code : '" + instructor_code + "',instructor_name:'" + instructor_name + "',email:'" + email + "',flag:'S',user_type:'" + user_type + "',instructor_first_name:'',instructor_last_name:''}",
            dataType: "json",
            success: function (data) {

                debugger;

                var result = JSON.parse(data.d);

                if (result["status"] != "") {


                    bootbox.alert('Data Saved / Update successfully.');

                    get_all_instructor();
                    $('#txt_instructor_name').val('');
                    $('#hdn_instructor_code').val('');
                    $('#txt_mail').val('');
                    $('#drp_user_type').val('I2');

                    $('.lable_name').text('Add new Instructor');
                    $('#btn_save').text('Save');


                }
                else {

                    bootbox.alert(result["message"]);

                }

            },
            error: function (result) {
                debugger;
                alert(result);
            }
        });

        $('#txt_instructor_name').val('');
        $('#hdn_instructor_code').val('');
        $('#txt_mail').val('');
        $('#drp_user_type').val('I2');
        $('.lable_name').text('Add new Instructor');
        $('#btn_save').text('Save');

        return false;
    });

});

function get_all_instructor() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_instructor_data_with_mail",

        data: "{}",
        dataType: "json",
        success: function (data) {



            debugger;
            if (data.d != "") {


                display_instruction(data.d);
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

function display_instruction(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
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

          { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
            { "sTitle": "Email", "mData": "user_mail", "bSortable": false },
             { "sTitle": "User Type", "mData": "type", "bSortable": false },
        //               { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
{"sTitle": "User Code", "mData": "VF_code", "bSortable": false },
             { "sTitle": "<center>Edit</center>",
                 "mData": null,
                 "bSortable": false,
                 "sDefaultContent": '<center><i class="icon-edit icon-2x text-blue" style="cursor:pointer;"></center>'
             },
            { "sTitle": "<center>Delete</center>",
                "mData": null,
                "bSortable": false,
                "sDefaultContent": '<center><i class="icon-trash icon-2x text-blue" style="cursor:pointer;"></i></center>'
            }

            ]


    });

    $('#DataList').css("display", "block");

}

$('#example tbody tr td i.icon-edit').live('click', function (e) {

    debugger;

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var flag = 'Y';

    var instructor_code = aData.instructor_code;

    $('#txt_instructor_name').val(aData.instructor_name);

    $('#txt_mail').val(aData.user_mail.trim());

    debugger;

    if (aData.user_type != "") {
        if (aData.type == "VF" || aData.type == "AA" || aData.type == "AUVF" ||aData.type=="TA") {
            $('#drp_user_type').val(aData.type.trim());
        }
        else {
            $('#drp_user_type').val(aData.user_type.trim());
        }

    }
    else if (aData.type == "VF" || aData.type == "AA" || aData.type == "AUVF" || aData.type == "TA") {
        $('#drp_user_type').val(aData.type.trim());
    }
    else {
        $('#drp_user_type').val("I2");
    }

    $('#hdn_instructor_code').val(aData.instructor_code);

    $('.lable_name').text('Update Instructor');
    $('#btn_save').text('Update');

});

$('#example tbody tr td i.icon-trash').live('click', function (e) {
    debugger;
    var r = confirm("Are you sure you want to remove this?");
    if (r == true) {

        //            var datalist = [];
        //            var flag = 'Y';
        //            var ob = {};
        //            var thisdata = $(this).closest("tr");

        var row = $(this).closest("tr").get(0);
        var aData = oTable.fnGetData(row);
        var flag = 'Y';
        //    var course = aData.course_code;
        ///    $(this).closest("tr").remove();

        //        $("#example tbody tr ").each(function (index) {
        //            debugger;
        //            $(this).find('.sr_no').text(index + 1);
        //        });
        var instructor_code = aData.instructor_code;

        var email = aData.user_mail;

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/change_instructor_mst",
            async: false,
            data: "{instructor_code : '" + instructor_code + "',instructor_name:'',flag:'D',email:'" + email + "',user_type:'',instructor_first_name:'',instructor_last_name:''}",
            dataType: "json",
            success: function (data) {

                var result = JSON.parse(data.d);

                debugger;
                if (result["status"]) {


                    bootbox.alert('Data Deleted successfully.');

                    get_all_instructor();
                    $('#txt_instructor_name').val('');
                    $('#hdn_instructor_code').val('');
                    $('#drp_user_type').val('I2');
                    $('.lable_name').text('Add new Instructor');
                    $('#btn_save').text('Save');

                }
                else {

                    bootbox.alert(result["message"]);

                }

            },
            error: function (result) {
                alert(result);
            }
        });


        $('#txt_instructor_name').val('');
        $('#hdn_instructor_code').val('');
        $('#drp_user_type').val('I2');
        $('.lable_name').text('Add new Instructor');
        $('#btn_save').text('Save');
    }

});