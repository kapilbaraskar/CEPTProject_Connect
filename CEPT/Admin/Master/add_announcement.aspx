<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="add_announcement.aspx.cs" Inherits="Admin_Master_add_announcement" %>

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

        #cke_txt_news_description
        {
            width: 725px !important;
        }

        .user_type
        {
            margin: 0 !important;
        }
    </style>
    <script type="text/javascript">
        //Test Commit Myr
        $(document).ready(function () {
            function getQueryStringValue(key) {
                return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }
            var a_id = getQueryStringValue("announcement_id");
            if (a_id != "") {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_news_announcement_dtl_for_edit",
                    //async: false,
                    data: "{a_id:'" + a_id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            $("#btn_modal_save").css("display", "none");
                            $("#btn_modal_update").css("display", "block");
                            $(".edit_mode").css("display", "block");
                            var array = JSON.parse(data.d)[0]["user_type"].split(",");
                            var str = "";
                            for (i = 0; i < array.length; i++) {
                                if (array[i] == 'S') $("#S").prop("checked", true);
                                if (array[i] == 'I2') $("#I2").prop("checked", true);
                                if (array[i] == 'D') $("#D").prop("checked", true);
                                if (array[i] == 'PC') $("#PC").prop("checked", true);
                                if (array[i] == 'FA') $("#FA").prop("checked", true);
                            }

                            $('#txt_news_title').val(JSON.parse(data.d)[0]["title"]);

                            CKEDITOR.instances['txt_news_description'].setData(JSON.parse(data.d)[0]["description"]);
                            $('#txt_news_date').datepicker('setDate', JSON.parse(data.d)[0]["date"]);
                            
                            $('#txt_news_expiry_date').datepicker('setDate', JSON.parse(data.d)[0]["expiry_date"]);
                            if (JSON.parse(data.d)[0]["news_image"] != "") {
                                $("#download_uploaded").attr('href', '../../WSNewsImageUpload/' + JSON.parse(data.d)[0]["news_image"]);
                            } else {
                                $(".edit_mode").css("display", "none");
                            }
                        }
                        else {
                            $("#btn_modal_save").css("display", "block");
                            $("#btn_modal_update").css("display", "none");
                            bootbox.alert('Announcement Details Not Found');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            } else {
                $("#btn_modal_save").css("display", "block");
                $("#btn_modal_update").css("display", "none");
                $(".edit_mode").css("display", "none");

                $("#S").prop("checked", false);
                $("#I2").prop("checked", false);
                $("#D").prop("checked", false);
                $("#PC").prop("checked", false);
                $("#FA").prop("checked", false);
                $('#txt_news_title').val("");
                function CKupdate() {
                    for (instance in CKEDITOR.instances) {
                        CKEDITOR.instances[instance].updateElement();
                        CKEDITOR.instances[instance].setData('');
                    }
                }
            }
            $('#txt_news_date').datepicker({ dateFormat: 'dd/mm/yy' });
            $('#txt_news_expiry_date').datepicker({ dateFormat: 'dd/mm/yy' });
        });

        function getQueryStringValue(key) {
            return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }

        function saveAnnouncement() {
            obj_data = { type: 'A', title: '', category: '', date: '', news_image: '', description: '', expiry_date: '', user_type: '' };

            var user_type = [];
            $(':checkbox:checked').each(function (i) {
                user_type[i] = $(this).val();
            });

            if (user_type.toString() == "") {
                bootbox.alert("Please Select View Announcement");
                return false;
            }

            if ($('#txt_news_title').val() == "") {
                bootbox.alert("Please Enter Announcement Title");
                return false;
            }

            if (CKEDITOR.instances['txt_news_description'].getData() == "") {
                bootbox.alert("Please Enter Announcement Description");
                return false;
            }

            if ($('#txt_news_date').val() == "") {
                bootbox.alert("Please Enter Announcement Date");
                return false;
            }

            if ($('#txt_news_date').val() != '') {
                obj_data.date = convertDateFormat($('#txt_news_date').val());
                if (obj_data.date == '') {
                    bootbox.alert('Please Enter valid Announcement Date');
                    return false;
                }
            }

            if ($('#txt_news_expiry_date').val() == "") {
                bootbox.alert("Please Enter Announcement Expiry Date");
                return false;
            }

            if ($('#txt_news_expiry_date').val() != '') {
                obj_data.expiry_date = convertDateFormat($('#txt_news_expiry_date').val());
                if (obj_data.expiry_date == '') {
                    bootbox.alert('Please Enter valid Announcement Expiry Date');
                    return false;
                }
            }

            obj_data.user_type = user_type.toString();

            obj_data.title = $('#txt_news_title').val();

            obj_data.news_image = FileName_News;

            obj_data.description = CKEDITOR.instances['txt_news_description'].getData();
            if (obj_data.description.search(/\\/) != -1) { obj_data.description = obj_data.description.replace(/\\/g, '\\\\'); }
            if (obj_data.description.search("\"") != -1) { obj_data.description = obj_data.description.replace(/"/g, '\\\"'); }

            saveData(obj_data);
        }

        function updateAnnouncement() {
            obj_data = { doc_no: '', type: 'A', title: '', category: '', date: '', news_image: '', description: '', expiry_date: '', user_type: '' };

            var user_type = [];
            $(':checkbox:checked').each(function (i) {
                user_type[i] = $(this).val();
            });

            if (user_type.toString() == "") {
                bootbox.alert("Please Select View Announcement");
                return false;
            }

            if ($('#txt_news_title').val() == "") {
                bootbox.alert("Please Enter Announcement Title");
                return false;
            }

            if (CKEDITOR.instances['txt_news_description'].getData() == "") {
                bootbox.alert("Please Enter Announcement Description");
                return false;
            }

            if ($('#txt_news_date').val() == "") {
                bootbox.alert("Please Enter Announcement Date");
                return false;
            }

            if ($('#txt_news_date').val() != '') {
                obj_data.date = convertDateFormat($('#txt_news_date').val());
                if (obj_data.date == '') {
                    bootbox.alert('Please Enter valid Announcement Date');
                    return false;
                }
            }

            if ($('#txt_news_expiry_date').val() == "") {
                bootbox.alert("Please Enter Announcement Expiry Date");
                return false;
            }

            if ($('#txt_news_expiry_date').val() != '') {
                obj_data.expiry_date = convertDateFormat($('#txt_news_expiry_date').val());
                if (obj_data.expiry_date == '') {
                    bootbox.alert('Please Enter valid Announcement Expiry Date');
                    return false;
                }
            }

            obj_data.doc_no = getQueryStringValue("announcement_id");

            obj_data.user_type = user_type.toString();

            obj_data.title = $('#txt_news_title').val();

            obj_data.news_image = FileName_News;

            obj_data.description = CKEDITOR.instances['txt_news_description'].getData();
            if (obj_data.description.search(/\\/) != -1) { obj_data.description = obj_data.description.replace(/\\/g, '\\\\'); }
            if (obj_data.description.search("\"") != -1) { obj_data.description = obj_data.description.replace(/"/g, '\\\"'); }

            updateData(obj_data);
        }

        function saveData(data) {
            $.ajax({
                async: false,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_news_announcement",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('Data Saved Successfully', function () {
                            window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/view_announcement.aspx") %>";
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
                url: "../../WebService.asmx/update_news_announcement",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('Data Updated Successfully', function () {
                            window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/view_announcement.aspx") %>";
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
                                url: '../../Handler/WSNewsImage_upload.ashx?t=' + (new Date()).getTime() + '.' + extension,
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

                                            $('#img_news_image').attr('src', '../../WSNewsImageUpload/' + FileName_News + '?' + (new Date()).getTime());
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
                    case 'jpg':
                    case 'jpeg':
                    case 'JPG':
                    case 'JPEG':
                    case 'png':
                    case 'PNG':
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
                <strong><span class="panel-headingfont">Add New Announcement</span></strong>
            </div>
            <div class="row" style="padding: 30px;">
                <div class="form-group col-md-4 color-blue">View Announcement<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5">
                    <input type="checkbox" name="selector[]" class="user_type" id="S" value="S" />&nbsp;Student&emsp;
                    <input type="checkbox" name="selector[]" class="user_type" id="I2" value="I2" />&nbsp;Instructor&emsp;
                    <input type="checkbox" name="selector[]" class="user_type" id="D" value="D" />&nbsp;Dean&emsp;
                    <input type="checkbox" name="selector[]" class="user_type" id="PC" value="PC" />&nbsp;Coordinator&emsp;
                    <input type="checkbox" name="selector[]" class="user_type" id="FA" value="FA" />&nbsp;Faculty Admin
                </div>
                <div class="form-group col-md-4 color-blue" style="margin-top:10px!important;">Announcement Title<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5" style="margin-top:10px!important;"><input type="text" id="txt_news_title" class="marg-btm" style="width: 140%;" /></div>
            
                <div class="form-group col-md-4 color-blue">Announcement Description<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5">
                      <textarea rows="200" cols="200" id="txt_news_description" class="ckeditor"></textarea>
                </div>
            
                <div class="form-group col-md-4 color-blue" style="margin-top:10px!important;">Announcement Date<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5" style="margin-top:10px!important;"><input type="text" id="txt_news_date" class="marg-btm" style="" /></div>
            
                <div class="form-group col-md-4 color-blue">Announcement Expiry Date<span style="color:red;"> *</span></div>
                <div class="form-group col-md-5"><input type="text" id="txt_news_expiry_date" class="marg-btm" style="" /></div>

                <div class="form-group col-md-4 color-blue edit_mode" >Download Uploaded File<span style="color:red;"> </span></div>
                <div class="form-group col-md-5 edit_mode" style="margin-bottom:10px;"><%--<button id="Button1" type="button" style="text-align: center;border: 0px solid;width: 94px;" class="btn btn-primary" onclick="Download()">Download</button>--%>
                <a href="" id="download_uploaded" download="">Click Here To Download</a><%--&emsp;<img src="../../image/delete.png" id="dlt_img" style="width: 16px;"/>--%></div>

                <div class="form-group col-md-4 color-blue">Upload File</div>
                <div class="form-group col-md-5">
                    <div>
                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                            <span><strong>Choose File</strong></span>
                            <input type="file" name="newsImageUpload" id="newsImageUpload" onchange="javascript:return UploadNewsImage();" style="display: none;" />
                        </label>&nbsp;&nbsp;<p style="color:red;">(PDF, JPEG, JPG, PNG)</p>
                        <span id="lbl_newsimage_file_name" style="vertical-align: super;"></span>
                    </div>
                    <div>
                    <input type="image" id="img_news_image" src="" style="max-width:100%;display:none;border:1px solid;" />
                    <br /><br />
                    <button id="btn_modal_save" type="button" style="text-align: center;border: 0px solid;margin-left: 25%;" class="btn btn-primary" onclick="saveAnnouncement()">Save Announcement</button>
                    <button id="btn_modal_update" type="button" style="text-align: center;border: 0px solid;margin-left: 25%;" class="btn btn-primary" onclick="updateAnnouncement()">Update Announcement</button>
                    </div>
                </div>
             </div>        
    </div>
</asp:Content>

