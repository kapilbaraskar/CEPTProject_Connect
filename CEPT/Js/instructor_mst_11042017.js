var oTable;
var asInitVals = new Array();
var teastatus = '';

$(document).ready(function () {
    if ($('#hdnusertype').val() != 'OR') {
        $('#div_add_new').css('display', 'block');
    }

    $('#tea_status').attr('disabled', true);
    $("#tea_id").hide();

    //$("#drp_user_type").change(function () {
    //    var selectedText = $(this).find("option:selected").text();
    //    var selectedValue = $(this).val();
    //    if (selectedValue == "TA") {
    //        $("#tea_id").show();
    //        $("#tea_status").attr("disabled", false);
    //    }
    //    else {
    //        if ($("#tea_status").prop("checked") == true) {
    //
    //            $("#tea_status").prop("checked", false);
    //
    //        }
    //        else ($("#tea_status").prop("checked") == false)
    //        {
    //
    //        }
    //        $("#tea_id").hide();
    //        $("#tea_status").attr("disabled", true);
    //    }
    //});

    get_all_instructor();

    $('#btn_reset').on('click', function () {
        $('#txt_instructor_name').val('');

        $('#txt_mail').val('');

        $('#hdn_instructor_code').val('');
        $('#drp_user_type').val('I2');

        $('.lable_name').text('Add new Instructor');
       // $("#tea_status").prop("checked", false);
        $('#btn_save').text('Save');

        oTable.fnFilter('');
        var oSettings = oTable.fnSettings();
        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable.fnDraw();
       // $('#tea_status').attr('disabled', true);
        //$('#tea_id').hide();
        return false;
    });

    $('#txt_instructor_name').on('keyup', function () {
        //oTable.fnFilter($('#txt_instructor_name').val());
        if ($('#hdn_instructor_code').val().trim() == '') {
            oTable.fnFilter($('#txt_instructor_name').val(), 0);
        }
    });

    $('#btn_save').on('click', function () {
        var instructor_name = $('#txt_instructor_name').val().trim();

        if (instructor_name == "") {
            bootbox.alert("Please add instructor name");
            return false;
        }

        var instructor_code = $('#hdn_instructor_code').val();

        var email = $('#txt_mail').val().trim();

        var user_type = $('#drp_user_type').val().trim();

        if (email != "")
        {
            var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
            if (testEmail.test(email))
            {

            }
            else
            {
                bootbox.alert("Please Enter Valid Email");
                $('#txtemail').focus();

                return false;
            }
        }

        //if ($('#tea_status').is(":checked"))
        if (user_type == "TEA")
        {
            teastatus = "TEA";
            user_type = "TA";
        }
        else
        {
            teastatus = "";
        }


        //$('#tea_status').is(":checked")

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/change_instructor_mst",
            async: false,
            data: "{instructor_code : '" + instructor_code + "',instructor_name:'" + instructor_name + "',email:'" + email + "',flag:'S',user_type:'" + user_type + "',des_letter:'" + teastatus +"',instructor_first_name:'',instructor_last_name:''}",
            dataType: "json",
            success: function (data) {
                var result = JSON.parse(data.d);

                if (result["status"] != "")
                {
                    bootbox.alert('Data Saved / Update successfully.');

                    get_all_instructor();
                    $('#txt_instructor_name').val('');
                    $('#hdn_instructor_code').val('');
                    $('#txt_mail').val('');
                    $('#drp_user_type').val('I2');

                    $('.lable_name').text('Add new Instructor');
                    $('#btn_save').text('Save');
                    //$("#tea_status").prop("checked", false);
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
    var tbl_columns = [
        { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
        { "sTitle": "Email", "mData": "user_mail", "bSortable": false },
        { "sTitle": "User Type", "mData": "type", "bSortable": false },
        //{ "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
        {"sTitle": "User Code", "mData": "VF_code", "bSortable": false },
        { "sTitle": "<center>Upload Photo</center>", "mData": null, "bSortable": false, "mRender": function (data) {
            var str_html = '<a class="cls_image_view" style="margin-left: 10px;" target="_blank">View</a>';

            if (data.profile_photo != '') str_html = '<a class="cls_image_view" href="../../UserPersonalPhoto/' + data.profile_photo + '" style="margin-left: 10px;" target="_blank">View</a>';

            return '<center><label class="cls_lbl_img btn btn-primary file-upload" style="vertical-align: bottom;">' +
                        '<span><strong>Upload</strong></span>' +
                        '<input type="file" name="imageUpload_' + data.instructor_code + '" id="imageUpload_' + data.instructor_code + '" style="width:100%;" onchange="javascript:return UploadProfilePhoto(this);" />' +
                    '</label>' + str_html +
                    '<input type="hidden" id="hdn_image_' + data.instructor_code + '" value=""></center>';
        }
        }
    ];

    if ($('#hdnusertype').val() != 'OR') {
        tbl_columns.push({ "sTitle": "<center>Edit</center>", "mData": null, "bSortable": false, "sDefaultContent": '<center><i class="icon-edit icon-2x text-blue" style="cursor:pointer;"></center>' });
        tbl_columns.push({ "sTitle": "<center>Delete</center>", "mData": null, "bSortable": false, "sDefaultContent": '<center><i class="icon-trash icon-2x text-blue" style="cursor:pointer;"></i></center>' });
    }

    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 30,
        "bSort": false,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
			//	    "sExtends": "collection",
			//	    "sButtonText": 'Export',
			//	    "aButtons": ["xls"]
			//	}
			//]
   //     },
        "aaData": JSON.parse(data),
        "aoColumns": tbl_columns
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
    //$("#example tr:nth-child(2) th").length (Remove because of Download)
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

    $('#DataList').css("display", "block");
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

$('#example tbody tr td i.icon-edit').live('click', function (e) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    window.localStorage.setItem("RowData", JSON.stringify(aData));
    window.location.href = "UpdateInstructorDetail.aspx";

    //var flag = 'Y';
    //
    //var instructor_code = aData.instructor_code;
    //
    //$('#txt_instructor_name').val(aData.instructor_name);
    //
    //$('#txt_mail').val(aData.user_mail.trim());
    //
    //if (aData.user_type != "") {
    //    if (aData.type == "VF" || aData.type == "AA" || aData.type == "AUVF" || aData.type == "TA") {
    //        if (aData.type == "TA") {
    //            $("#tea_id").show();
    //            $("#tea_status").attr("disabled", false);
    //        }
    //        else {
    //            $("#tea_id").hide();
    //            $("#tea_status").attr("disabled", true);
    //        }
    //        $('#drp_user_type').val(aData.type.trim());
    //    }
    //    else {
    //        $('#drp_user_type').val(aData.user_type.trim());
    //    }
    //    if (aData.designation == "temp") {
    //        $('#drp_user_type').val("temp");
    //    }
    //}
    //else if (aData.type == "VF" || aData.type == "AA" || aData.type == "AUVF" || aData.type == "TA") {
    //    if (aData.type == "TA") {
    //        $("#tea_id").show();
    //        $("#tea_status").attr("disabled", false);
    //    }
    //    else {
    //        $("#tea_id").hide();
    //        $("#tea_status").attr("disabled", true);
    //    }
    //    $('#drp_user_type').val(aData.type.trim());
    //}
    //else if (aData.designation == "temp") {
    //    $('#drp_user_type').val("temp");
    //}
    //else {
    //    $('#drp_user_type').val("I2");
    //}
    //
    //$("#tea_status").prop("checked", false);
    //if (aData.designation_letter != "" && aData.designation_letter != "NULL" )
    //{
    //    $("#tea_status").prop("checked", true);
    //}
    //$('#hdn_instructor_code').val(aData.instructor_code);
    //
    //$('.lable_name').text('Update Instructor');
    //$('#btn_save').text('Update');
});

$('#example tbody tr td i.icon-trash').live('click', function (e) {
    var r = confirm("Are you sure you want to remove this?");
    if (r == true) {

        //var datalist = [];
        //var flag = 'Y';
        //var ob = {};
        //var thisdata = $(this).closest("tr");

        var row = $(this).closest("tr").get(0);
        var aData = oTable.fnGetData(row);
        var flag = 'Y';
        //var course = aData.course_code;
        ///$(this).closest("tr").remove();

        //$("#example tbody tr ").each(function (index) {
        //    $(this).find('.sr_no').text(index + 1);
        //});
        var instructor_code = aData.instructor_code;

        var email = aData.user_mail;

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/change_instructor_mst",
            async: false,
            data: "{instructor_code : '" + instructor_code + "',instructor_name:'',flag:'D',email:'" + email + "',user_type:'', des_letter:'',instructor_first_name:'',instructor_last_name:''}",
            dataType: "json",
            success: function (data) {
                var result = JSON.parse(data.d);

                if (result["status"]) {
                    bootbox.alert('Data Deleted successfully.');

                    get_all_instructor();
                    $('#txt_instructor_name').val('');
                    $('#hdn_instructor_code').val('');
                    $('#drp_user_type').val('I2');
                    $('.lable_name').text('Add new Instructor');
                    $('#btn_save').text('Save');
                   // $('#tea_status').attr('disabled', true);
                   // $('#tea_id').hide();
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

function UploadProfilePhoto(temp_cur_ele) {
    try {
        var fileToUpload = GetFileNameFromPath($('#' + temp_cur_ele.id).val());

        var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

        if (CheckUserPhotoExtension(fileToUpload)) {
            var flag = true;
            var temp_icode = oTable.fnGetData($(temp_cur_ele).closest('tr')[0]).user_id;
            var temp_des = oTable.fnGetData($(temp_cur_ele).closest('tr')[0]).designation;

            if (filename != "" && filename != null) {
                if (flag == true) {
                    $("#UploadingProgress").fadeIn(200);

                    $.ajaxFileUpload({
                        url: '../../Handler/Instructor_photo_upload.ashx',
                        secureuri: false,
                        fileElementId: temp_cur_ele.id,
                        dataType: 'json',
                        data: { name: name, icode: temp_icode, designation: temp_des },
                        success: function (data, status) {
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {
                                    var temp_user_id = oTable.fnGetData($('#' + temp_cur_ele.name).closest('tr')[0]).user_id;
                                    $('#' + temp_cur_ele.name).val("");
                                    $('#hdn_image_' + temp_user_id).val(data.upfile);
                                    $('#' + temp_cur_ele.name).closest('tr').find('.cls_image_view')[0].href = '../../UserPersonalPhoto/' + data.upfile;

                                    if (temp_user_id != undefined) {
                                        $.ajax({
                                            type: "POST",
                                            contentType: "application/json; charset=utf-8",
                                            url: "../../WebService.asmx/save_instructor_profile_photo",
                                            data: "{'user_id' : '" + temp_user_id + "','file_name':'" + data.upfile + "'}",
                                            dataType: "json",
                                            success: function (data) {
                                                if (data.d != '') {
                                                    bootbox.alert(data.d);
                                                }
                                            },
                                            error: function (data) {
                                                alert(data.d);
                                            }
                                        });
                                    }
                                }
                            }

                            $("#UploadingProgress").fadeOut(200);
                        },
                        error: function (data, status, e) {
                            $("#UploadingProgress").fadeOut(200);
                            alert(e);
                        }
                    });
                }
            }
        }
        else {
            alert('Invalid File Type. Please upload .jpeg file');
        }
        return false;
    }
    catch (e) {
        alert("Exception : " + e.message);
    }
}

//Check User Photo Extension
function CheckUserPhotoExtension(file) {
    try {
        var flag = true;
        var extension = file.substr((file.lastIndexOf('.') + 1));

        switch (extension) {
            case 'jpg':
            case 'jpeg':
            case 'JPG':
            case 'JPEG':
                flag = true;
                break;
            default:
                flag = false;
        }

        return flag;
    }
    catch (e) {
        alert("Exception : " + e.message);
    }
}

//Get File Name From Path
function GetFileNameFromPath(strFilepath) {
    var objRE = new RegExp(/([^\/\\]+)$/);
    var strName = objRE.exec(strFilepath);

    if (strName == null) {
        return null;
    }
    else {
        return strName[0];
    }
}
