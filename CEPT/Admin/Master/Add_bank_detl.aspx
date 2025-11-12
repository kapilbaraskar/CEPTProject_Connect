<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Add_bank_detl.aspx.cs" Inherits="Admin_Master_Add_bank_detl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
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

        .file-upload input {
            position: absolute;
            top: 0;
            left: 0;
            margin: 0;
            font-size: 10pt;
            opacity: 0;
        }

        .required {
            color: Red;
        }
    </style>
    <script type="text/javascript">
        var Student_id;
        var status_save = false;
        $(document).ready(function () {
            debugger;
            if ($('#hdn_bank').val() == 'N')
            {
                $('#btn_next').css('display', 'none');
                //
            }
            Student_id = $('#hdn_user_id').val();
            bind_data();
            $('#btn_save').on('click', function () {
                saveData();
            });

            $('#btn_next').on('click', function () {
                saveData();
                if (status_save) {
                    var region = location.origin;
                    if ($('#hdn_studio_code').val() != "") {
                        location.href = region + '/' + 'Admin/Master/' + 'Studio_Brief_Details.aspx?studio_code=' + $('#hdn_studio_code').val() + '&s=' + $('#hdn_s').val() + '&y=' + $('#hdn_y').val();
                        return false;
                    }
                    else if ($('#hdn_c').val() != "") {
                        location.href = region + '/' + 'Admin/Master/' + 'Studio_Brief_Details.aspx?c=' + $('#hdn_c').val() + '&s=' + $('#hdn_s').val() + '&y=' + $('#hdn_y').val();
                        return false;
                    }
                }

            });
        });

        function saveData() {
            if ($("#txt_blood_group").val() == "")
            {
                alert("Please Select Blood Group");
                return false;
            }
            if ($("#txt_bank_account_no").val() == "") {
                alert("Please Enter Bank Account Number");
                return false;
            }
            if ($("#txt_account_type").val() == "") {
                alert("Please Select Account Type");
                return false;

            }
            if ($("#txt_name_of_the_bank").val() == "") {
                alert("Please Enter Name of the Bank ");
                return false;
            }
            if ($("#txt_branch_name").val() == "") {
                alert("Please Enter Branch Name ");
                return false;
            }
            if ($("#txt_ifsc_code").val() == "") {
                alert("Please Enter FSC Code / Swift Code ");
                return false;
            }
            if ($("#txt_benificiary_name").val() == "") {
                alert("Please Enter Beneficiary Name as per Bank Account ");
                return false;
            }

            var blood_group_data = $("#txt_blood_group").val();
            var ifsc_code = $("#txt_ifsc_code").val();
            var bank_account_number = $("#txt_bank_account_no").val();
            var account_type = $("#txt_account_type").val();
            var name_of_Bank = $("#txt_name_of_the_bank").val();
            var branch_name = $("#txt_branch_name").val();
            var benificiary_name = $("#txt_benificiary_name").val();
            var gst_number = $('#txt_gst_no').val();
            var profile_pic = $('#lbl_image_name').text();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/inst_bank_dtl_Update",
                data: "{ blood_group : '" + blood_group_data + "',ifsc_code : '" + ifsc_code + "',bank_account_number : '" + bank_account_number + "', account_type: '" + account_type + "', name_of_Bank: '" + name_of_Bank + "', branch_name: '" + branch_name + "', benificiary_name: '" + benificiary_name + "',gst_number:'" + gst_number + "',profile_pic:'" + profile_pic+"'}",
                async: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        var res = JSON.parse(data.d);
                        if (res["status"] == 'True')
                        {
                            status_save = true;
                            alert(res['message']);
                            //bind_data();
                          
                            //var region = location.origin;
                            //if ($('#hdn_studio_code').val() != "")
                            //{
                            //    location.href = region + '/' + 'Admin/Master/' + 'Studio_Brief_Details.aspx?studio_code=' + $('#hdn_studio_code').val() + '&s=' + $('#hdn_s').val() + '&y=' + $('#hdn_y').val();
                            //    return false;
                            //}
                            //else if ($('#hdn_c').val() != "")
                            //{
                            //    location.href = region + '/' + 'Admin/Master/' + 'Studio_Brief_Details.aspx?c=' + $('#hdn_c').val() + '&s=' + $('#hdn_s').val() + '&y=' + $('#hdn_y').val();
                            //    return false;
                            //}
                            
                            
                        } else {
                            alert(res['message']);
                        }
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }

        function bind_data() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_instructor_data",
                data: "{instructor_code :'" + Student_id + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d[0] != null && data.d[0] != '')
                    {
                        var student_data = JSON.parse(data.d[0])
                        if (student_data[0]["blood_group"] != '') {
                            $('#txt_blood_group').val(student_data[0]["blood_group"]);
                        }
                        if (student_data[0]["bank_account_number"] != '') {
                            $('#txt_bank_account_no').val(student_data[0]["bank_account_number"]);
                        }

                        if (student_data[0]["account_type"] != '') {
                            $('#txt_account_type').val(student_data[0]["account_type"]);
                        }

                        if (student_data[0]["name_of_Bank"] != '') {
                            $('#txt_name_of_the_bank').val(student_data[0]["name_of_Bank"]);
                        }
                        if (student_data[0]["branch_name"] != '') {
                            $('#txt_branch_name').val(student_data[0]["branch_name"]);
                        }

                        if (student_data[0]["ifsc_code"] != '') {
                            $('#txt_ifsc_code').val(student_data[0]["ifsc_code"]);
                        }
                        if (student_data[0]["benificiary_name"] != '') {
                            $('#txt_benificiary_name').val(student_data[0]["benificiary_name"]);
                        }
                        if (student_data[0]["gst_number"] != '') {
                            $('#txt_gst_no').val(student_data[0]["gst_number"]);
                        }
                        debugger;
                        var region = location.origin;
                        //$('#img_photo').attr('src', region + '/' + 'UserProfilePhoto/' + student_data[0]['profile_photo']);
                        $('#img_photo').attr('src', region + '/' + 'UserPersonalPhoto/' + student_data[0]['profile_photo']);
                        
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var FileName2 = '';
        function UploadUserProfilePhoto() {
            try {
                var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                var icode = $('#hdn_icode').val();

                if (CheckUserProfilePhotoExtension(fileToUpload)) {
                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/Instructor_photo_upload.ashx',
                                secureuri: false,
                                fileElementId: 'imageUpload',
                                dataType: 'json',
                                data: { name: name, icode: icode },
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#imageUpload').val("");

                                            bootbox.alert("Photo Uploaded Successfully");
                                            FileName2 = data.upfile;
                                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + FileName2 + "?" + (new Date()).getTime());
                                            $('#lbl_image_name').text(FileName2);
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
        function CheckUserProfilePhotoExtension(file) {
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="div_user_group">
        <h3 style="text-align: center;"><u>Bank Details</u></h3>
    </div>

    <div class="well" style="background-color: White;">
        
        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Step 2A</b>
            </div>
            <div style="padding: 10px; overflow: visible; width: 50%;" class="panel-collapse collapse in">

                <img id="img_photo" src="../../UserProfilePhoto/Default_Avtar.png" alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                    class="img-thumbnail" />

                <label id="lbl_img" class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload Photo</strong><span class="user_img" style="display: inline; color: Red;"> *</span></span>
                    <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadUserProfilePhoto();" />

                </label>
                <br />
                <label id="lbl_image_name" style="display: none;" ng-model="data.image_name"></label>
                <br />
                <%--<p style="color:blue;">Note : Please upload a passport-type front-facing photo taken in light background </p>--%>
                <p style="color:blue;">Note: Upload high-quality headshot in light background </p>
            </div>

        </div>
        <div id="main_div" style="margin-top: 15px; margin-bottom: 40px;" class="panel panel-default">

            <div class="panel-heading">
                <strong>Faculty Bank Detail</strong>
            </div>
            <div style="padding-top: 15px;">
                <table border="0" cellpadding="2" cellspacing="2" style="width: 100%;" align="center">
                    <tr>
                         <td class="pad-top">GST Number
                        </td>
                        <td>
                            <input type="text" id="txt_gst_no" class="marg-btm"/>
                        </td>


                        <td class="pad-top">Blood Group<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <%--<input type="text" id="txt_blood_group" class="marg-btm"/>--%>
                            <select id="txt_blood_group" class="marg-btm">
                                <option value="">--Select Blood Group--</option>
                                <option value='A+'>A+</option>
                                <option value='A-'>A-</option>
                                <option value='B+'>B+</option>
                                <option value='B-'>B-</option>
                                <option value='AB+'>AB+</option>
                                <option value='AB-'>AB-</option>
                                <option value='O+'>O+</option>
                                <option value='O-'>O-</option>
                            </select>
                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">Bank Account Number<span class="cls_mendatory_I2" id="stick_bank" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_bank_account_no" class="marg-btm"/>
                        </td>
                        <td class="pad-top">Account Type<span class="cls_mendatory_I2" id="stick_account" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <select id="txt_account_type" class="marg-btm">
                                <option value="">-- Select Account Type --</option>
                                <option value="Saving">Saving</option>
                                <option value="Current">Current</option>
                            </select>
                        </td>

                    </tr>

                    <tr>

                        
                        <td class="pad-top">Name of the Bank<span class="cls_mendatory_I2" id="stick_ban_name" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_name_of_the_bank" class="marg-btm" />
                        </td>
                         <td class="pad-top">Branch Name<span class="cls_mendatory_I2" id="stick_branch_name" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_branch_name" class="marg-btm" />
                        </td>

                    </tr>

                    <tr>

                       
                        <td class="pad-top">IFSC Code / Swift Code<span class="cls_mendatory_I2" id="stick_ifsc" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_ifsc_code" class="marg-btm" onkeypress='return IsValidIFSC(event);' maxlength="11"/>
                        </td>
                        <td class="pad-top">Beneficiary Name as per Bank Account<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_benificiary_name" class="marg-btm"/>
                        </td>

                    </tr>

                   
                </table>



            </div>
            <br />

        </div>
         <div id="div_button" style="text-align: center; float: none; margin-top: 1%;" class="blood_group_form">
        <input type="button" id="btn_save" value="Save" class="btn btn-primary" />
        <input type="button" id="btn_next" value="Step 3" class="btn btn-primary" />
    </div>

        <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
        <asp:HiddenField ID="hdn_c" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_s" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_y" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_bank" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_studio_code" runat="server" ClientIDMode="Static" />
        
    </div>
</asp:Content>

