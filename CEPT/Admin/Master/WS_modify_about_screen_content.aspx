<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_modify_about_screen_content.aspx.cs" Inherits="Admin_Master_WS_modify_about_screen_content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../../DesignJs/ckeditor2/ckeditor.js" type="text/javascript"></script>
    <style>
        .col-md-4
        {
            width: 25.33%;
        }

        .col-md-5
        {
            width: 50%;
        }

        #cke_txt_description
        {
            width: 725px !important;
        }
        .pdf, .text
        {
            display:none;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            bindtype();
            function getQueryStringValue(key) {
                return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }
            var id = getQueryStringValue("id");
            if (id != "") {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_about_screen_content",//Cont..
                    //async: false,
                    data: "{id:'" + id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            about_data = JSON.parse(data.d);
                            $("#btn_modal_save").css("display", "none");
                            $("#btn_modal_update").css("display", "block");
                            $('#drp_type').val(about_data[0]["type"]);
                            $(".edit_mode").css("display", "block");
                            $('#txt_title').val(about_data[0]["title"]);

                            CKEDITOR.instances['txt_description'].setData(about_data[0]["description"]);

                            if (about_data[0]["pdf_path"] != "") {
                                $("#download_uploaded").attr('href', '../../WSAboutPDF/' + about_data[0]["pdf_path"]);
                            } else {
                                $(".edit_mode").css("display", "none");
                            }
                            $('#txt_position').val(parseInt(about_data[0]["position"]));
                        }
                        else {
                            $("#btn_modal_save").css("display", "block");
                            $("#btn_modal_update").css("display", "none");
                            bootbox.alert('Details Not Found');
                        }
                        $("#drp_type").trigger("liszt:updated");
                        $("#drp_type").trigger("change");
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            } else {
                $("#btn_modal_save").css("display", "block");
                $("#btn_modal_update").css("display", "none");
                $(".edit_mode").css("display", "none");
                $('#txt_title').val("");
                function CKupdate() {
                    for (instance in CKEDITOR.instances) {
                        CKEDITOR.instances[instance].updateElement();
                        CKEDITOR.instances[instance].setData('');
                    }
                }
            }
            $("#drp_type").change(function () {
                if ($("#drp_type").val() == 'pdf') {
                    $(".pdf").css("display", "block");
                    $(".text").css("display", "none");
                } else if ($("#drp_type").val() == 'text') {
                    $(".text").css("display", "block");
                    $(".pdf").css("display", "none");
                    $(".edit_mode").css("display", "none");
                } else {
                    $(".text").css("display", "none");
                    $(".pdf").css("display", "none");
                    $(".edit_mode").css("display", "none");
                }
            })
        });

        function bindtype() {
            $('#drp_type').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drp_type').append("<option value='pdf'>PDF</option>");
            $('#drp_type').append("<option value='text'>Textual</option>");
            $('#drp_type').chosen();
        }

        function getQueryStringValue(key) {
            return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }

        function saveAbout() {

            obj_data = { type: '', title: '', description: '', pdf_path: '', position: '' };

            //----------------Link Type----------------//
             if ($("#drp_type").val() == '') {
                bootbox.alert("Please Select Link Type");
                return false;
            }

            //----------------Title----------------//
            if ($('#txt_title').val() == "") {
                bootbox.alert("Please Enter Title");
                return false;
            }

            //----------------Content / PDF----------------//
            if ($("#drp_type").val() == 'pdf') {
                if (FileName_News == "") {
                    bootbox.alert("Please Upload PDF File");
                    return false;
                } else {
                    obj_data.pdf_path = FileName_News;

                    obj_data.description = "";
                }
            } else if ($("#drp_type").val() == 'text') {
                if (CKEDITOR.instances['txt_description'].getData() == "") {
                    bootbox.alert("Please Enter Content");
                    return false;
                } else {
                    obj_data.pdf_path = "";

                    obj_data.description = CKEDITOR.instances['txt_description'].getData();
                    if (obj_data.description.search(/\\/) != -1) { obj_data.description = obj_data.description.replace(/\\/g, '\\\\'); }
                    if (obj_data.description.search("\"") != -1) { obj_data.description = obj_data.description.replace(/"/g, '\\\"'); }
                }
            }

            //----------------Title----------------//
            if ($('#txt_position').val() == "") {
                bootbox.alert("Please Enter Position");
                return false;
            }

            obj_data.type = $("#drp_type").val();
            obj_data.title = $('#txt_title').val();

            //obj_data.pdf_path = FileName_News;

            //obj_data.description = CKEDITOR.instances['txt_description'].getData();
            //if (obj_data.description.search(/\\/) != -1) { obj_data.description = obj_data.description.replace(/\\/g, '\\\\'); }
            //if (obj_data.description.search("\"") != -1) { obj_data.description = obj_data.description.replace(/"/g, '\\\"'); }

            obj_data.position = $('#txt_position').val();

            saveData(obj_data);
        }

        function updateAbout() {
            obj_data = { id: '', type: '', title: '', description: '', pdf_path: '', position: '' };
            
            //----------------Link Type----------------//
            if ($("#drp_type").val() == '') {
                bootbox.alert("Please Select Link Type");
                return false;
            }

            //----------------Title----------------//
            if ($('#txt_title').val() == "") {
                bootbox.alert("Please Enter Title");
                return false;
            }

            //----------------Content / PDF----------------//
            if ($("#drp_type").val() == 'pdf') {
                if (FileName_News == "") {
                    if ($("#download_uploaded").attr('href') == "") {
                        bootbox.alert("Please Upload PDF File");
                        return false;
                    } else {
                        obj_data.pdf_path = $("#download_uploaded").attr('href').substring(17);
                    }
                } else {
                    obj_data.pdf_path = FileName_News;

                    obj_data.description = "";
                }
            } else if ($("#drp_type").val() == 'text') {
                if (CKEDITOR.instances['txt_description'].getData() == "") {
                    bootbox.alert("Please Enter Content");
                    return false;
                } else {
                    obj_data.pdf_path = "";

                    obj_data.description = CKEDITOR.instances['txt_description'].getData();
                    if (obj_data.description.search(/\\/) != -1) { obj_data.description = obj_data.description.replace(/\\/g, '\\\\'); }
                    if (obj_data.description.search("\"") != -1) { obj_data.description = obj_data.description.replace(/"/g, '\\\"'); }
                }
            }

            //----------------Title----------------//
            if ($('#txt_position').val() == "") {
                bootbox.alert("Please Enter Position");
                return false;
            }
            obj_data.id = getQueryStringValue("id");
            obj_data.type = $("#drp_type").val();
            obj_data.title = $('#txt_title').val();

            //obj_data.pdf_path = FileName_News;

            //obj_data.description = CKEDITOR.instances['txt_description'].getData();
            //if (obj_data.description.search(/\\/) != -1) { obj_data.description = obj_data.description.replace(/\\/g, '\\\\'); }
            //if (obj_data.description.search("\"") != -1) { obj_data.description = obj_data.description.replace(/"/g, '\\\"'); }

            obj_data.position = $('#txt_position').val();

            updateData(obj_data);
        }

        function saveData(data) {
            $.ajax({
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_about_screen_content",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('Data Saved Successfully', function () {
                            window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/WS_view_about_screen_content.aspx") %>";
                        });
                    }
                    else if (res_data['status'] == "False") {
                        alert(res_data['message']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function updateData(data) {
            $.ajax({
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/edit_about_screen_content",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('Data Updated Successfully', function () {
                            window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/WS_view_about_screen_content.aspx") %>";
                        });
                    }
                    else if (res_data['status'] == "False") {
                        alert(res_data['message']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        //$("#dlt_img").click(function () {

        //});
    
        function convertDateFormat(str_date) {
            if (str_date != '') {
                if (str_date.split('/').length == 3) {
                    var date_split = str_date.split('/');
                    var temp_date = new Date(date_split[1] + '/' + date_split[0] + '/' + date_split[2]);
                    if (temp_date.toString() == 'Invalid Date') {
                        bootbox.alert('Please Enter Date in valid format');
                        return '';
                    }
                    else {
                        return '' + (temp_date.getMonth() + 1) + '/' + temp_date.getDate() + '/' + temp_date.getFullYear();
                    }
                }
                else {
                    bootbox.alert('Please Enter Date in valid format');
                    return '';
                }
            }
            else
                return str_date;
        }

        var FileName_News = '';
        function UploadNewsImage() {
            try {
                var fileToUpload = GetFileNameFromPath($('#newsImageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                var extension = fileToUpload.substr((fileToUpload.lastIndexOf('.') + 1));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/WSAboutContent.ashx?t=' + (new Date()).getTime() + '.' + extension,
                                secureuri: false,
                                fileElementId: 'newsImageUpload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#newsImageUpload').val("");
                                            $('#lbl_newsimage_file_name').html('<b>' + fileToUpload + '</b>');

                                            FileName_News = data.upfile;
                                            $('#img_news_image').attr('src', '../../WSAboutPDF/' + FileName_News + '?' + (new Date()).getTime());
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
                    alert('Invalid File Type. Please upload jpeg / png file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }
        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'PDF':
                    case 'pdf':
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="panel panel-default " style="padding: 5px;">
        
            <div class="panel-heading" style="padding: 10px;">
                <strong><span class="panel-headingfont">Add About Content</span></strong>
            </div>
            <div class="row" style="padding: 30px;">

                <div class="form-group col-md-4 color-blue" style="margin-top:10px!important;">Link Type<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5" style="margin-top:10px!important;">
                     <select class="chosen-select" id="drp_type">
                     </select>
                </div>

                <div class="form-group col-md-4 color-blue" style="margin-top:10px!important;">Title<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5" style="margin-top:10px!important;"><input type="text" id="txt_title" class="marg-btm" style="width: 100%;" /></div>
            
                <div class="form-group col-md-4 color-blue text">Content<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5 text">
                      <textarea rows="200" cols="200" id="txt_description" class="ckeditor"></textarea>
                </div>

                <div class="form-group col-md-4 color-blue edit_mode" >Download Uploaded File<span style="color:red;"> </span></div>
                <div class="form-group col-md-5 edit_mode" style="margin-bottom:10px;"><%--<button id="Button1" type="button" style="text-align: center;border: 0px solid;width: 94px;" class="btn btn-primary" onclick="Download()">Download</button>--%>
                <a href="" id="download_uploaded" download="">Click Here To Download</a><%--&emsp;<img src="../../image/delete.png" id="dlt_img" style="width: 16px;"/>--%></div>
              
                <div class="form-group col-md-4 color-blue pdf">Upload File<span style="color:red;">*</span></div>
                <div class="form-group col-md-5 pdf">
                    <div>
                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                            <span><strong>Choose File</strong></span>
                            <input type="file" name="newsImageUpload" id="newsImageUpload" onchange="javascript:return UploadNewsImage();" style="display: none;" />
                        </label>&nbsp;&nbsp;<p style="color:red;">(PDF Only)</p>
                        <span id="lbl_newsimage_file_name" style="vertical-align: super;"></span>
                    </div>
                    <div>
                    <input type="image" id="img_news_image" src="" style="max-width:100%;display:none;border:1px solid;" />
                    <br /><br />
                    </div>
                </div>
                <div class="form-group col-md-4 color-blue" style="margin-top:10px!important;">Position<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5" style="margin-top:10px!important;"><input type="number" id="txt_position" class="marg-btm" style="width: 20%;" min="0"/></div>
                <div class="form-group col-md-4"></div>
                <div class="form-group col-md-5">
                    <button id="btn_modal_save" type="button" style="text-align: center;border: 0px solid;margin-left: 33%;" class="btn btn-primary" onclick="saveAbout()">Save</button>
                    <button id="btn_modal_update" type="button" style="text-align: center;border: 0px solid;margin-left: 33%;" class="btn btn-primary" onclick="updateAbout()">Update</button>
                </div>
             </div>        
    </div>
</asp:Content>

