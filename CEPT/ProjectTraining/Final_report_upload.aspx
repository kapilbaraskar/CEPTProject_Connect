<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPageProject.master"  CodeFile="Final_report_upload.aspx.cs" Inherits="ProjectTraining_Final_report_upload" %>

 <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
   <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <br />
    <div class="well" style="background-color: White;">
           <%--<label>Student Name :  Nirav Patel</label> --%>

                   
        <div class="panel panel-default ">
          
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Final Report Upload</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">

              <%--   <div class="row">
                    <div style="" class="form-group col-md-12">
                     
                           <div class="col-sm-2">
                                     <label class="btn btn-primary file-upload btn_hide radio_hide " style="vertical-align: bottom; width: 100px">
                                            <span><strong>Upload Files</strong></span>
                                            <div class="col-xs-2">
                                                <input type="file" name="file_upload" id="file_upload" onchange="javascript:return UploadProfilePhoto();" style="display: none;"/>
                                            </div>
                                        </label>
                        </div>
                           <div class="col-sm-1">
                                         <span id="upload_span"><strong id="upload_result"></strong></span> 
                                        <a id='download_link' class="fancybox radio_hide" download="" rel="group" href="">Download</a>
                        </div>
                           <div class="col-sm-1">
                            <input class="btn btn-primary pull-right btn-small" type="button" id="save" value="save" style="display:none" />
                        </div>
                    </div>
                </div>--%>

                   <div class="row">
                    <div style="" class="form-group col-md-12">

                        <table id="psr_tbl" class="display table table-striped table-bordered table-hover" style="width: 97%;">
                            <thead>
                                <tr>
                                    <td>Upload</td>
                                    <td>Download</td>
                                    <td>Comments</td>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center;">
                                        <label class="btn btn-primary file-upload btn_hide radio_hide " style="vertical-align: bottom;">
                                            <span><strong>Upload Files</strong></span>
                                            <input type="file"  name="file_upload" id="file_upload" onchange="javascript:return UploadProfilePhoto();" style="display: none;" />
                                        </label>
                                    </td>
                                    <td>
                                        <span id="upload_span"><strong id="upload_result"></strong></span>
                                        <a id='download_link' class="fancybox radio_hide" download="" rel="group" href="">Download Final Report</a>
                                    </td>
                                    <td>
                                        <textarea id="txt_area_comments" ClientIDMode="Static"  style="width: 96%" runat="server"></textarea>
                                        <label id="lbl_comment"></label>
                                    </td>
                                 
                                </tr>
                            </tbody>
                        </table>

                         <input class="btn btn-primary  btn-small" type="button" id="save" value="save" style="display:none" />
                    </div>
                </div>

            
            </div>
        </div>
        
    </div>
     <input type="button" runat="server" id="save_commnets" onserverclick="save_comment" value="Save Comment"/>
    <style>
      #psr_tbl tr td {
            text-align: center;
        }
    </style>
    <script type="text/javascript">

        var user;
        $(function () {
            $('#download_link').tooltip();
        });

        function getQueryStringValue(key) {
            return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }

        var myObject = new Object();

        var upload_file_name;
        $(document).ready(function () {
            //$.ajax({
            //    type: "POST",
            //    url: "../WebService.asmx/get_date_for_planned",
            //    data: '{}',
            //    dataType: 'json',
            //    contentType: "application/json",
            //    async: false,
            //    success: function (result) {
            //        if (result.d != "") {

            //            week_flag = result.d;
            //        }
            //        else {
            //            $('#loading').hide();
            //            bootbox.alert('Please Fill Site Join Report', function () {
            //                window.location.href = "site_joining_report(SJR).aspx";
            //            });
            //        }
            //    },
            //    error: function (error) {

            //    }
            //});
            var User_type = ('<%= Session["User_type"] %>');
            if (User_type == "FA")
            {
                $("#ctl00_ContentPlaceHolder1_save_commnets").css('display', 'none');
                  $("#txt_area_comments").attr('readonly','readonly')
            }

            if (User_type == "S") {
                $("#txt_area_comments").css('display', 'none');
                $("#lbl_comment").css('display', 'block');
                $("#ctl00_ContentPlaceHolder1_save_commnets").css('display', 'none');
            }
            else {
                $(".file-upload").css('display', 'none');
                $("#txt_area_comments").css('display', 'block');
                $("#lbl_comment").css('display', 'none');
            }


            user = getQueryStringValue('user_id');
            if (user == '') {
                user = ('<%= Session["UserId"] %>');
            }

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_project_final_report_upload",
                data: '{user_id :"' + user + '"}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != "") {
                        
                        Obj_project_psr = JSON.parse(result.d);
                        if (Obj_project_psr[0]['file_path'] != "") {
                            $("#txt_area_comments").val(Obj_project_psr[0]['comment']);


                            $("#lbl_comment").text(Obj_project_psr[0]['comment']);

                            $('#download_link').prop('href', ("../ProjectTraining/final_upload/" + Obj_project_psr[0]['file_path']));
                        }
                        else {
                            $('#download_link').css('display', 'none');
                        }
                    }
                    else {
                        $('#download_link').css('display', 'none');
                    }

                },
                error: function (error) {
                    console.log(error);
                }
            });



        });

        $('#save').on('click', function () {
            var result = $('#aspnetForm').valid();
            if (result == true) {

                if (upload_file_name != undefined) {
                    myObject.file_path = upload_file_name;
                }
                else {
                    myObject.file_path = "";
                }

                data = JSON.stringify({ "data": myObject });
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/project_Final_report_upload",
                    data: data,
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (result) {
                        bootbox.alert(result.d, function () {
                            window.location.reload();
                        });
                    },
                    error: function (error) {
                        console.log(error);
                    }

                });
            }
        });

        function UploadProfilePhoto() {
            upload_file_name = '';
            try {
               
                var fileToUpload = GetFileNameFromPath($('#file_upload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../Handler/project_final_report_upload.ashx',
                                secureuri: false,
                                fileElementId: 'file_upload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#file_upload').val("");

                                            FileName = data.upfile;
                                            upload_file_name = FileName;

                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                    $('#save').click();
                                    $('#upload_result').text('file upload successfully.');

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
                    alert('Invalid File Type. Please upload PDF file');
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
                    case 'pdf':
                    case 'PDF':

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