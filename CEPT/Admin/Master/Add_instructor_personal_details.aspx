<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Add_instructor_personal_details.aspx.cs" Inherits="Admin_Master_Add_instructor_personal_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style>
        .img-thumbnail
        {
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
        .file-upload input
        {
            position: absolute;
            top: 0;
            left: 0;
            margin: 0;
            font-size: 10pt;
            opacity: 0;
        }
        .wysiwyg_viewer_skins_button_BasicButtonb1-link
        {
            border-radius: 0px;
            position: absolute;
            top: 0px;
            bottom: 0px;
            left: 0px;
            right: 0px;
            background-color: rgb(102, 102, 102);
            transition: border-color 0.4s ease 0s, background-color 0.4s ease 0s;
            -webkit-transition: border-color 0.4s ease 0s, background-color 0.4s ease 0s;
            box-shadow: rgba(0, 0, 0, 0.6) 0px 1px 4px 0px;
        }
        .wysiwyg_viewer_skins_button_BasicButtonb1-label
        {
            font: normal normal normal 13px/1.3em arial, 'ｍｓ ｐゴシック' , 'ms pgothic' , 돋움, dotum, helvetica, sans-serif;
            transition: color 0.4s ease 0s;
            -webkit-transition: color 0.4s ease 0s;
            color: rgb(255, 255, 255);
            white-space: nowrap;
            margin: 0px;
            display: inline-block;
            position: relative;
        }
        .required
        {
            color: Red;
        }
    </style>
    <script type="text/javascript">



        $(document).ready(function () {
            bindinstructor();
            $('#btnreterive').on('click', function () {
                retrieve_Data();
                return false;
            });

            $('#drpinstructor').on('change', function () {

                $('#div_pdetails,.copyright').css('display', 'none');

                $('#txt_qualification').val('');
                $('#txt_public_service').val('');
                $('#drp_type').val('');
                $('#txt_contact').val('');
                $('#txt_office_location').val('');

                $("#img_photo").attr("src", "");
                $('#lbl_image_name').text('');

            });

            $('#btnsave').on('click', function () {

                var data = { user_id: '', supervisor_name: '', email: '', image_path: '', public_service: '', designation: '', department: '', contact: '', office_location: '', capstone_project: '' };


                if ($('#lbl_image_name').text().trim() != "") {
                    data.image_path = $('#lbl_image_name').text();
                }

                // data.qualification = $('#txt_qualification').val();

                data.public_service = $('#txt_public_service').val();

                if ($('#drp_type').val() != '') {
                    data.designation = $('#drp_type').val();
                }

                data.department = $('#drp_department').val();
                data.contact = $('#txt_contact').val().trim();
                data.office_location = $('#txt_office_location').val().trim();
                // data.capstone_project = $('#txt_capstone_project').val().trim();
                data.supervisor_name = $('#txt_name').val();
                data.email = $('#txt_mail').val();
                data.user_id = $('#drpinstructor').val();

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_profile_data_by_HR",
                    data: "{'profile_detail' : '" + JSON.stringify(data) + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != '') {
                            bootbox.alert(data.d);
                        }

                        return false;
                    },
                    error: function (data) {
                        alert(data.d);
                        return false;
                    }
                });
            });
        });

        function bindinstructor() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_instructor_available_personal_details",
                async: false,
              //  headers:{"Authorization": "Basic YWRtaW46YWRtaW5AMTIz"},
                data: "{}",
                datatype: "json",
                success: function (data,status,abc) {
                    if (data.d != "") {
                        var instructor_data = JSON.parse(data.d);

                        $('#drpinstructor').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < instructor_data.length; i++) {
                            $('#drpinstructor').append($("<option></option>").val(instructor_data[i]["user_id"]).html(instructor_data[i]["instructor_name"]));
                        }
                        $('#drpinstructor').chosen();
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function retrieve_Data() {
            $('#div_pdetails,.copyright').css('display', 'none');

            $('#txt_qualification').val('');
            $('#txt_public_service').val('');
            $('#drp_type').val('');
            $('#txt_contact').val('');
            $('#txt_office_location').val('');

            $("#img_photo").attr("src", "");
            $('#lbl_image_name').text('');


            var instructor_code = $('#drpinstructor').val();

            if (instructor_code == "") {

                bootbox.alert('Please select instructor');
                $('#drpinstructor').focus();
                return false;
            }

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_instructor_personal_details",
                data: "{instructor_code:'" + instructor_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {

                        if (data.d[0] != null) {
                            debugger;
                            var p_details = JSON.parse(data.d[0]);

                            $('#txt_qualification').val(p_details[0]["qualification"]);
                            $('#txt_public_service').val(p_details[0]["public_service"]);
                            $('#drp_type').val(p_details[0]["designation"]);
                            // $('#drp_department').val(p_details[0]["department"]);
                            $('#txt_contact').val(p_details[0]["contact"]);
                            $('#txt_office_location').val(p_details[0]["office_location"]);
                            // $('#txt_capstone_project').val(p_details[0]["capstone_project"])

                            if (p_details["image_path"] != "") {

                                $("#img_photo").attr("src", "../../UserPersonalPhoto/" + p_details[0]["image_path"]);
                                $('#lbl_image_name').text(p_details[0]["image_path"]);
                            }
                            if (p_details[0]["supervisor_name"] != '') {
                                $('#txt_name').val(p_details[0]["supervisor_name"]);
                            }
                            else {
                                $('#txt_name').val($('#drpinstructor option:selected').text());
                            }

                            $('#txt_mail').val(p_details[0]["mail"]);

                            $('#div_pdetails,.copyright').css('display', 'block');
                        }
                        else {
                            $('#txt_name').val($('#drpinstructor option:selected').text());
                            $('#txt_mail').val(data.d[1]);
                            $('#div_pdetails,.copyright').css('display', 'block');

                        }
                    }
                    else {
                        bootbox.alert('No data found');
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        }

        function UploadProfilePhoto() {
            debugger;
            try {

                var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/Instructor_photo_upload.ashx',
                                secureuri: false,
                                fileElementId: 'imageUpload',
                                dataType: 'json',
                                data: { name: name },
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#imageUpload').val("");
                                            FileName = data.upfile;
                                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + FileName);
                                            $('#lbl_image_name').text(FileName);
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
      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; Course Catalog Summary
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Instructor :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpinstructor">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="display: none;" id="div_pdetails" class="row-fluid">
        <div class="panel panel-default " id="my_print_outline">
            <div class="tabbable">
                <div class="row" style="padding-bottom: 5px; padding-left: 75px;">
                    <div class="col-md-3">
                        <img id="img_photo" ng-model="data.image" src="UserProfilePhoto/Default_Avtar.png"
                            alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                            class="img-thumbnail">
                        <label id="lbl_img" class="btn btn-primary file-upload " style="vertical-align: bottom;">
                            <span><strong>Upload Photo</strong></span>
                            <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadProfilePhoto();" /></label><br />
                        <label id="lbl_image_name" style="display: none" ng-model="data.image_name">
                        </label>
                        <input type="hidden" id="hdn_doc" ng-model="data.doc_no" />
                    </div>
                </div>
                <div id="Div2" class="tab-pane active" style="padding-left: 75px;">
                    <table width="100%" cellpadding="10" cellspacing="50">
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Name<%--<span class="required"> *</span>--%>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_name" ng-model="data.supervisor_name" placeholder="Name" />
                                        <span style="color: red" ng-show="name.$dirty && name.$invalid">
                                    </div>
                                </div>
                            </td>
                            <td style="display: none;">
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Qualification<%--<span class="required"> *</span>--%>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_qualification" ng-model="data.qualification" placeholder="Qualification" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Designation<%--<span class="required"> *</span>--%>
                                    </label>
                                    <div class="controls">
                                        <select id="drp_type" ng-model="data.designation">
                                            <option value="Adjunct Professor">Adjunct Professor</option>
                                            <option value="Adjunct Assistant Professor">Adjunct Assistant Professor</option>
                                            <option value="Adjunct Associate Professor">Adjunct Associate Professor</option>
                                            <option value="Assistant Professor">Assistant Professor</option>
                                            <option value="Associate Professor">Associate Professor</option>
                                            <%--<option value="Dean">Dean</option>--%>
                                             <option value="Coordinator">Coordinator</option>
                                            <option value="Director">Director</option>
                                            <option value="President">President</option>
                                            <option value="Professor">Professor</option>
                                            <option value="Visiting Faculty">Visiting Faculty</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <%--<td>
                                <div class="control-group">
                                    <label class="control-label" for="drpcountry">
                                        Link to personal web page
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_capstone_project" ng-model="data.capstone_project" placeholder="Link to personal web page" />
                                    </div>
                                </div>
                            </td>--%>
                        </tr>
                        <tr>
                            <%--<td>
                                <div class="control-group">
                                    <label class="control-label" for="txtdob">
                                        Faculty/Organisation<span class="required"> *</span>
                                    </label>
                                    <div class="controls">
                                        <select id="drp_department">
                                            <option value=''>-- Please Select Depatment --</option>
                                            <option value="Architecture">Architecture</option>
                                            <option value="Design">Design</option>
                                            <option value="Management">Management</option>
                                            <option value="Planning">Planning</option>
                                            <option value="Technology">Technology</option>
                                            <option value="University">University</option>
                                            <option value="Others">Others</option>
                                        </select>
                                    </div>
                                </div>
                            </td>--%>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Phone number
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_contact" ng-model="data.contact" placeholder="Phone number" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Email<%--<span class="required"> *</span>--%>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_mail" ng-model="data.email" placeholder="email" disabled />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="drpcountry">
                                        Office Location
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_office_location" ng-model="data.office_location" placeholder="" />
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">
                                        Institutional Roles
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_public_service" placeholder="" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1057px; height: 40px;
        display: none;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                    <table style="width: 1057px;">
                        <tr>
                            <td align="center">
                                <button id="btnsave" type="button" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>
</asp:Content>
