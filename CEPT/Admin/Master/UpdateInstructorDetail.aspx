<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="UpdateInstructorDetail.aspx.cs" Inherits="Admin_Master_UpdateInstructorDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script type="text/javascript">
        var aData;
        $(document).ready(function () {
            $("#tea_id").hide();
            $("#tea_status").attr("disabled", true);
            aData = JSON.parse(window.localStorage.getItem('RowData'));
            var flag = 'Y';

            var instructor_code = aData.instructor_code;

            $('#txt_instructor_name').val(aData.first_name);
            $('#txt_instructor_last_name').val(aData.last_name);

            $('#txt_mail').val(aData.Personal_mail_id.trim());//aData.instructor_mail.trim()
            $('#txt_per_mail').val(aData.user_mail.trim());
            $('#txt_highest_qualification').val(aData.highest_qualification.trim());
            $('#txt_total_experiance').val(aData.total_experiance.trim());
            $('#txt_total_experiance_months').val(aData.total_experiance_months.trim());

            if (aData.user_type != "") {
                if (aData.type == "VF" || aData.type == "AA" || aData.type == "AUVF" || aData.type == "TA") {
                    // if (aData.type == "TA") {
                    //     $("#tea_id").show();
                    //     $("#tea_status").attr("disabled", false);
                    // }
                    // else {
                    //     $("#tea_id").hide();
                    //     $("#tea_status").attr("disabled", true);
                    // }
                    $('#drp_user_type').val(aData.type.trim());
                }
                else {
                    $('#drp_user_type').val(aData.user_type.trim());
                }
                if (aData.designation == "temp") {
                    $('#drp_user_type').val("temp");
                }
            }
            else if (aData.type == "VF" || aData.type == "AA" || aData.type == "AUVF" || aData.type == "TA") {
                // if (aData.type == "TA") {
                //     $("#tea_id").show();
                //     $("#tea_status").attr("disabled", false);
                // }
                // else {
                //     $("#tea_id").hide();
                //     $("#tea_status").attr("disabled", true);
                // }
                $('#drp_user_type').val(aData.type.trim());
            }
            else if (aData.designation == "temp") {
                $('#drp_user_type').val("temp");
            }
            else {
                $('#drp_user_type').val("I2");
            }

            //$("#tea_status").prop("checked", false);
            if (aData.designation_letter != "" && aData.designation_letter != "NULL") {
                //$("#tea_status").prop("checked", true);
                $('#drp_user_type').val("TEA");
            }
            $('#hdn_instructor_code').val(aData.instructor_code);
            $('#img_photo').attr('src', "../../UserPersonalPhoto/" + aData.profile_photo);

            //$("#drp_user_type").change(function () {
            //    var selectedText = $(this).find("option:selected").text();
            //    var selectedValue = $(this).val();
            //    if (selectedValue == "TA") {
            //        $("#tea_id").show();
            //        $("#tea_status").attr("disabled", false);
            //    }
            //    else {
            //        if ($("#tea_status").prop("checked") == true) {

            //            $("#tea_status").prop("checked", false);

            //        }
            //        else ($("#tea_status").prop("checked") == false)
            //        {

            //        }
            //        $("#tea_id").hide();
            //        $("#tea_status").attr("disabled", true);
            //    }
            //});

            $('#btn_save').on('click', function () {
                var instructor_name = $('#txt_instructor_name').val().trim() + ' ' + $('#txt_instructor_last_name').val().trim();
                var instructor_first_name = $('#txt_instructor_name').val().trim();
                var instructor_last_name = $('#txt_instructor_last_name').val().trim();
                if (instructor_first_name == "") {
                    bootbox.alert("Please add instructor first name");
                    return false;
                }
                if (instructor_last_name == "") {
                    bootbox.alert("Please add instructor last name");
                    return false;
                }
                var instructor_code = $('#hdn_instructor_code').val();
                var email = $('#txt_per_mail').val().trim()//$('#txt_mail').val().trim();
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
                //if ($('#tea_status').is(":checked"))
                if (user_type == "TEA") {
                    teastatus = "TEA";
                    user_type = "TA";
                }
                else {
                    teastatus = "";
                }


                var instructor_code = $('#hdn_instructor_code').val();
                var highest_qualification = $('#txt_highest_qualification').val();
                var total_experiance = $('#txt_total_experiance').val();
                var total_experiance_months = $('#txt_total_experiance_months').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_user_mst_inst_mst_credential",
                    async: false,
                    data: "{instructor_code : '" + instructor_code + "',user_mst_mail:'" + $('#txt_per_mail').val() + "',personal_mail:'" + $('#txt_mail').val() + "',highest_qualification:'" + highest_qualification + "',total_experiance:'" + total_experiance + "',total_experiance_months:'" + total_experiance_months + "'}",
                    dataType: "json",
                    success: function (data) {
                        //var result = JSON.parse(data.d);

                        if (data.d = true) {
                            //alert("Data Saved Successfully");
                            //window.location.href = "frm_instructor_mst.aspx";
                            //return false;
                            $.ajax({
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                url: "../../WebService.asmx/change_instructor_mst",
                                async: false,
                                data: "{instructor_code : '" + instructor_code + "',instructor_name:'" + instructor_name + "',email:'" + email + "',flag:'S',user_type:'" + user_type + "',des_letter:'" + teastatus + "',instructor_first_name:'" + instructor_first_name + "',instructor_last_name:'" + instructor_last_name + "'}",
                                dataType: "json",
                                success: function (data) {
                                    var result = JSON.parse(data.d);

                                    if (result["status"] != "") {
                                        //update_user_mst();
                                        alert("Data Saved Successfully");
                                        window.location.href = "frm_instructor_mst.aspx";
                                        return false;
                                    }
                                    else {
                                        bootbox.alert(result["message"]);
                                    }
                                },
                                error: function (result) {
                                    alert(result);
                                }
                            });


                        }
                        else {
                            bootbox.alert("Problem in Data");
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });



                
            });
        });
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
        function UploadProfilePhoto(temp_cur_ele) {
            try {
                var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {
                    var flag = true;
                    var temp_icode = aData.user_id;
                    var temp_des = aData.designation;

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
                                            var temp_user_id = aData.user_id;
                                            $('#' + temp_cur_ele.name).val("");
                                            /*$('#hdn_image_' + temp_user_id).val(data.upfile);*/
                                            /*$('#' + temp_cur_ele.name).closest('tr').find('.cls_image_view')[0].href = '../../UserPersonalPhoto/' + data.upfile;*/
                                            $("#img_photo").attr('src', "../../UserPersonalPhoto/" + data.upfile + "?" + (new Date()).getTime()); // $('#imageUpload').val());
                                            var Photo = data.upfile;
                                            if (temp_user_id != undefined) {
                                                $.ajax({
                                                    type: "POST",
                                                    contentType: "application/json; charset=utf-8",
                                                    url: "../../WebService.asmx/save_instructor_profile_photo",
                                                    data: "{'user_id' : '" + temp_user_id + "','file_name':'" + data.upfile + "'}",
                                                    dataType: "json",
                                                    success: function (data) {
                                                        if (data.d != '') {
                                                            aData.profile_photo = Photo;
                                                            window.localStorage.setItem("RowData", JSON.stringify(aData));
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
        function IsNumeric_TotalExperience(e) {
            //alert(e.which + " : " + e.keyCode);
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {

                //        if (parseInt($(document.activeElement).val()) > 10) {
                //            return false;
                //        }
                //        else if (parseInt($(document.activeElement).val()) == 10) {
                //            if (keyCode != 48) {
                //                return false;
                //            }
                //        }

                return true;
            }
            else {
                return false;
            }
        }

        function update_user_mst() {
            //txt_per_mail
            var instructor_code = $('#hdn_instructor_code').val();
            var highest_qualification = $('#txt_highest_qualification').val();
            var total_experiance = $('#txt_total_experiance').val();
            var total_experiance_months = $('#txt_total_experiance_months').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_user_mst_inst_mst_credential",
                async: false,
                data: "{instructor_code : '" + instructor_code + "',user_mst_mail:'" + $('#txt_mail').val() + "',highest_qualification:'" + highest_qualification + "',total_experiance:'" + total_experiance + "',total_experiance_months:'" + total_experiance_months + "'}",
                dataType: "json",
                success: function (data) {
                    //var result = JSON.parse(data.d);

                    if (data.d = true) {
                        alert("Data Saved Successfully");
                        window.location.href = "frm_instructor_mst.aspx";
                        return false;
                    }
                    else {
                        bootbox.alert("Problem in Data");
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
    </script>
    <style type="text/css">
        .img-thumbnail {
            display: inline-block;
            max-width: 100%;
            height: auto;
            padding: 4px;
            line-height: 1.42857143;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            -webkit-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <div class="page-header position-relative">
        <h1>
            <i class="icon-desktop"></i>&nbsp;Instructor Master
        </h1>
    </div>
    <div class="well" style="background-color: White; margin-top: 1%;">
        <div class="panel panel-default" id="profile_pic">
            <div class="panel-heading">
                <b>Profile Photo</b>
            </div>

            <div style="padding: 10px; overflow: visible;" class="panel-collapse collapse in">
                <img id="img_photo" src="../../UserProfilePhoto/Default_Avtar.png" alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                    class="img-thumbnail" />

                <label id="lbl_img" class="btn btn-primary file-upload " style="width: 95px; vertical-align: 17px">
                    <span><strong>Upload Photo</strong></span>
                    <%--<input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadProfilePhoto();" />--%>
                    <input type="file" name="imageUpload" id="imageUpload" style="width: 0%;" onchange="javascript:return UploadProfilePhoto(this);" />
                </label>
                <br />

                <label id="lbl_image_name" style="display: none;" ng-model="data.image_name"></label>
            </div>
        </div>
        <div id="div_add_new" class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Update Instructor Details</strong>
            </div>

            <div>
                <table cellpadding="10">
                    <tr>
                        <td class="add_update_label">
                            <span class="lable_name">First Name</span>
                        </td>
                        <td class="add_update_input">
                            <input type="text" id="txt_instructor_name" />
                            <input type="hidden" id="hdn_instructor_code" />
                        </td>
                        <td class="add_update_label">
                            <span class="lable_name">Last Name</span>
                        </td>
                        <td class="add_update_input">
                            <input type="text" id="txt_instructor_last_name" />
                        </td>
                    </tr>
                    <tr>
                        <td class="add_update_label">
                            <span>Personal Login Email Id</span>
                        </td>
                        <td class="add_update_input">
                            <input type="text" id="txt_mail" />
                        </td>
                        <td class="add_update_label">
                            <span>User-Type</span>
                        </td>
                        <td class="add_update_input">
                            <select id="drp_user_type">
                                <option value="I2">Instructor</option>
                                <option value="PC">Program Coordinator</option>
                                <option value="D">Dean</option>
                                <option value="VF">VF</option>
                                <option value="AA">AA</option>
                                <option value="AUVF">AUVF</option>
                                <option value="TA">TA</option>
                                <option value="TEA">TEA</option>
                                <option value="temp">Temp</option>
                            </select>
                        </td>
                        
                        <%--<td>
                        <button class="btn btn-primary" type="submit" id="btn_reset">Reset</button>
                    </td>--%>
                    </tr>
                    <tr>
                        <td class="add_update_label">
                            <span>Connect Login Email Id</span>
                        </td>
                        <td class="add_update_input">
                            <input type="text" id="txt_per_mail" />
                        </td>
                         <td class="pad-top">Total Years of Experience<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                           <%-- <input type="text" id="txt_total_experiance" class="marg-btm" onkeypress='return IsNumeric_TotalExperience(event);' maxlength="2" />--%>
                            <input type="text" id="txt_total_experiance" class="marg-btm" onkeypress='return IsNumeric_TotalExperience(event);' maxlength="2" style="width:25%" placeholder="Enter years"/>
                            <select id="txt_total_experiance_months" class="marg-btm" style="width:35%">
                                <option value="">--Select Months--</option>
                                <option value="0">0</option>
                                <option value='1'>1</option>
                                <option value='2'>2</option>
                                <option value='3'>3</option>
                                <option value='4'>4</option>
                                <option value='5'>5</option>
                                <option value='6'>6</option>
                                <option value='7'>7</option>
                                <option value='8'>8</option>
                                <option value='9'>9</option>
                                <option value='10'>10</option>
                                <option value='11'>11</option>
                                <option value='12'>12</option>
                            </select>
                        </td>
                        
                    </tr>
                    <tr>
                        <td class="pad-top">Highest Qualification<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            
                            <select id="txt_highest_qualification" class="marg-btm">
                                <option value="">--Select Qualification--</option>
                                <option value='PHD'>PhD/MPhil</option>
                                <option value='PG'>Masters</option>
                                <option value='UG'>Bachelors</option>
                                <option value='HSC'>HSC</option>
                            </select>
                        </td>
                        <td>
                            <input class="btn btn-primary" type="button" id="btn_save" value="Save" />
                        </td>
                    </tr>
                    <tr id="tea_id">
                        <td colspan="7">
                            <%--<input type="checkbox" id="tea_value" value="tea_data" />--%>
                            <input type="checkbox" id="tea_status" style="margin-bottom: 5px; margin-left: 6px;" /><span> Teaching Associate</span>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
