<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_news_announcement.aspx.cs" Inherits="Admin_Master_WS_news_announcement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>
      <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <style type="text/css">
        .cls_is_enable{width:65px;}
        .cls_disable{width:40px;}
        .cls_enable{width:40px;}
    </style>

    <script type="text/javascript">
        var oTable;
        var filter;

        $(document).ready(function () {
            $('#txt_news_date').datepicker({ dateFormat: 'dd/mm/yy' });
            $('#txt_announcement_date').datepicker({ dateFormat: 'dd/mm/yy' });

            get_news_announcement_dtl();
        });

        function get_news_announcement_dtl() {
            $('#DataList').css('display', 'none');

            filter = "";

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_news_announcement_dtl",
                //async: false,
                data: "{filter:'" + filter + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        display_news_announcement_dtl(data.d);
                        $('#div_news_announcement_list').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No News and Announcement Found');
                        $('#div_news_announcement_list').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function display_news_announcement_dtl(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
               // "sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
               // "oLanguage": { "sSearch": "Search all columns with Space:" },
               // "oTableTools": { "aButtons": ["print", { "sExtends": "collection", "sButtonText": 'Export', "aButtons": ["xls"]}] },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Type", "mData": "type", "bSortable": false, "mRender": function (ddata) {
                        if (ddata == 'N') return "News";
                        else if (ddata == 'A') return "Announcement";
                    }
                    },
                    { "sTitle": "Title", "mData": "title", "bSortable": false },
                    { "sTitle": "Date", "mData": "date", "bSortable": false, "mRender": function (ddata) {
                        if (ddata != '' && ddata != undefined && ddata != null) {
                            var temp_date = new Date(ddata);
                            var str_day = '0' + temp_date.getDate().toString();
                            var str_month = '0' + (temp_date.getMonth() + 1).toString();
                            var str_date = '';
                            str_date += str_day.substring(str_day.length, (str_day.length - 2)) + '/';
                            str_date += str_month.substring(str_month.length, (str_month.length - 2)) + '/' + temp_date.getFullYear().toString();
                            return str_date;
                        }
                        else return '';
                    }
                    },
                    { "sTitle": "Description", "mData": "description", "bSortable": false },
                    { "sTitle": "Is Enable", "mData": "cancel_flag", "bSortable": false, "sClass":"cls_is_enable", "mRender": function (ddata) {
                        if (ddata == 'N') return "<span style='text-align: center;'>Enabled</span>";
                        else if (ddata == 'Y') return "<span style='text-align: center;'>Disabled</span>";
                    }
                    },
                    { "sTitle": "Disable", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_disable", "mRender": function (ddata) {
                        if (ddata == 'N') return "<h3 onclick='disable_row(this)' style='text-align: center;'><i class='icon-remove'></i></h3>";
                        else if (ddata == 'Y') return "";
                    }
                    },
                    { "sTitle": "Enable", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_enable", "mRender": function (ddata) {
                        if (ddata == 'N') return "";
                        else if (ddata == 'Y') return "<h3 onclick='enable_row(this)' style='text-align: center;'><i class='icon-ok'></i></h3>";
                    }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function add_news() {
            $('#btn_show_news_modal').click();
        }

        function add_announcement() {
            $('#btn_show_announcement_modal').click();
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

        function saveNews() {
            var obj_data = { 'type': 'N', 'title': '', 'category': '', 'date': '', 'news_image': '', 'description': '' };

            if ($('#txt_news_title').val() == "") {
                bootbox.alert("Please Enter News Title");
                return false;
            }

            if ($('#txt_news_date').val() == "") {
                bootbox.alert("Please Enter News Date");
                return false;
            }
            
//            if (FileName_News == "") {
//                bootbox.alert("Please Enter News Image");
//                return false;
//            }

            obj_data.title = $('#txt_news_title').val();

            //obj_data.date = $('#txt_news_date').val();
            if ($('#txt_news_date').val() != '') {
                obj_data.date = convertDateFormat($('#txt_news_date').val());
                if (obj_data.date == '') {
                    bootbox.alert('Please Enter valid News Date');
                    return false;
                }
            }

            obj_data.news_image = FileName_News;
            obj_data.description = $('#txt_news_description').val();

            saveData(obj_data);
        }

        function saveAnnouncement() {
            var obj_data = { 'type': 'A', 'title': '', 'category': '', 'date': '', 'news_image': '', 'description': '' };

            if ($('#txt_announcement_title').val() == "") {
                bootbox.alert("Please Enter Announcement Title");
                return false;
            }

            if ($('#txt_announcement_date').val() == "") {
                bootbox.alert("Please Enter Announcement Date");
                return false;
            }

            obj_data.title = $('#txt_announcement_title').val();

            //obj_data.date = $('#txt_news_date').val();
            if ($('#txt_announcement_date').val() != '') {
                obj_data.date = convertDateFormat($('#txt_announcement_date').val());
                if (obj_data.date == '') {
                    bootbox.alert('Please Enter valid Announcement Date');
                    return false;
                }
            }

            saveData(obj_data);
        }

        function saveData(data) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_WS_news_announcement",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('Data Saved Successfully');
                        $('#btn_modal_close').click();
                        $('#btn_modal_close2').click();
                        get_news_announcement_dtl();
                    }
                    else if (res_data == "False") {
                        alert(res_data);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function enable_row(cur_ele) {
            var row = $(cur_ele).closest('tr');

            var row_data = oTable.fnGetData(row[0]);

            var data = { 'doc_no': row_data["doc_no"], 'cancel_flag': 'N', 'action': 'Enable' };

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/WS_enable_disable_news_announcement",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('News / Announcement Enabled Successfully');
                        $('#btn_modal_close').click();
                        $('#btn_modal_close2').click();
                        get_news_announcement_dtl();
                    }
                    else if (res_data == "False") {
                        alert(res_data);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function disable_row(cur_ele) {
            var row = $(cur_ele).closest('tr');

            var row_data = oTable.fnGetData(row[0]);

            var data = { 'doc_no': row_data["doc_no"], 'cancel_flag': 'Y', 'action': 'Disable' };

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/WS_enable_disable_news_announcement",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('News / Announcement Disabled Successfully');
                        $('#btn_modal_close').click();
                        $('#btn_modal_close2').click();
                        get_news_announcement_dtl();
                    }
                    else if (res_data == "False") {
                        alert(res_data);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

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

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;SWS News and Announcement
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <span style="float:right;">
            <input type="button" class="btn btn-primary" value="Add News" onclick="add_news()" style="height: 41px;margin-right: 10px;"/>
            <input type="button" class="btn btn-primary" value="Add Announcement" onclick="add_announcement()" style="height: 41px;"/>

            <input id="btn_show_news_modal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#NewsModal" value="Add Exam" style="height: 40px;margin-top: -10px;display:none;"/>
            <input id="btn_show_announcement_modal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#AnnouncementModal" value="Display" style="height: 40px;margin-top: -10px;display:none;"/>
        </span>

        <div id="div_news_announcement_list" class="panel panel-default" style="display:none;">
            <div class="panel-heading">
                <strong>News and Announcement Detail</strong>
                
            </div>

            <div>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="NewsModal" style="display:none;top:10%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H1">News</h4>
                </div>
                
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-4 color-blue">News Title</div>
                        <div class="form-group col-md-5"><input type="text" id="txt_news_title" class="marg-btm" style="" /></div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4 color-blue">News Description</div>
                        <div class="form-group col-md-5"><input type="text" id="txt_news_description" class="marg-btm" style="" /></div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4 color-blue">News Date</div>
                        <div class="form-group col-md-5"><input type="text" id="txt_news_date" class="marg-btm" style="" /></div>
                    </div>
                    <div class="row" style="margin-top:10px;">
                        <div class="form-group col-md-4 color-blue">News Image</div>
                        <div class="form-group col-md-5">
                            <div>
                                <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload Image</strong></span>
                                    <input type="file" name="newsImageUpload" id="newsImageUpload" onchange="javascript:return UploadNewsImage();" style="display: none;" />
                                </label>
                                <span id="lbl_newsimage_file_name" style="vertical-align: super;"></span>
                            </div>
                            <div>
                                <input type="image" id="img_news_image" src="" style="max-width:100%;display:inline-block;border:1px solid;" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button id="btn_modal_save" type="button" class="btn btn-primary" onclick="saveNews()">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="AnnouncementModal" style="display:none;top:10%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H2">Announcement</h4>
                </div>
                
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group col-md-4 color-blue">Announcement Title</div>
                        <div class="form-group col-md-5"><input type="text" id="txt_announcement_title" class="marg-btm" style="" /></div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-4 color-blue">Announcement Date</div>
                        <div class="form-group col-md-5"><input type="text" id="txt_announcement_date" class="marg-btm" style="" /></div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close2" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button id="btn_modal_save2" type="button" class="btn btn-primary" onclick="saveAnnouncement()">Save changes</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

