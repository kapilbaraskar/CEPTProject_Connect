<%@ Page Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="week_report_menu.aspx.cs" Inherits="ProjectTraining_week_report_pdf" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">


        <div class="panel panel-default ">
            <div class="panel-heading">
                <div>
                    <b>Weekly Timesheet Download    
                    </b>
                </div>

            </div>
            <input type="button" name="save" value="save" id="save" style="display: none" />
            <table id="tbl" class="display table table-striped table-bordered table-hover">
                <thead>
                    <th>Sr.NO</th>
                    <th>From date</th>
                    <th>To date</th>
                    <th>Download</th>
                    <th>Upload</th>
                    <th>Download TimeSheet</th>
                </thead>
                <tbody></tbody>
            </table>

        </div>

        <%--   <span style="color: red ;display:none">Please Select The Week Number.You will be able to Download the tiimesheet.</span><br />--%>
        <%--  <div class="col-sm-12" style="display:none">
            <br />
            <span>Select No</span>
            <select id="number"></select>
            <input id="print" type="button" value="Download" />

        </div>
        --%>
    </div>
    <div>
    </div>
    <div style="display: none">
        <asp:Button ID="hdn_print" runat="server" ClientIDMode="Static" Text="Download" OnClick="print_timesheet" />
    </div>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_data" />

    <script type="text/javascript">
        var save_timesheet_data = new Object();
        var obj_Get_student_actual = new Object();
        var obj_get_weekly_timesheet_data = new Object();
        var str1 = '';
        var sr_no = 1;
        var week_no = 1;

        var from_date = '';
        var to_date = '';
        var week_num = '';
        var length = 0;
        $(document).ready(function () {
            var user = '';
            user = getQueryStringValue('user_id');

            function getQueryStringValue(key) {
                return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }

            if (user == '') {
                user = ('<%= Session["UserId"] %>');

            }


            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_weekly_timesheet_upload",
                data: '{user_id: "' + user + '"}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    debugger;
                    if (result.d != "") {
                        obj_get_weekly_timesheet_data = JSON.parse(result.d);
                    }



                },
                error: function (error) {
                    console.log(error);
                }
            });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_time_sheet_date",
                data: '{user_id : "' + user + '"}',
                dataType: 'json',
                async: false,
                contentType: "application/json",
                success: function (result) {
                    if (result.d != "") {
                        debugger;
                        obj_Get_student_actual = JSON.parse(result.d);
                        var str = "";
                        for (var i = 0; i < obj_Get_student_actual.length; i++) {
                            debugger;
                            //if (obj_Get_student_actual.length > i) {

                            //}
                            //else {

                            str += "<tr>";
                            str += "<td>" + sr_no++ + " </td>";
                            str += "<td>" + obj_Get_student_actual[i]["date"] + "</td>";
                            if ((i + 5) <= obj_Get_student_actual.length) {

                                str += "<td>" + obj_Get_student_actual[i + 5]["date"].substr(0, 10) + "</td>";
                                str += "<td>  <input type='button' class='print_timesheet' value='Time Sheet' /></td>";
                                str += "<td> <label class='btn btn-primary file-upload btn_hide  ' style='vertical-align: bottom; width: 100px'>";
                                str += "<span><strong>Upload Files</strong></span><div class='col-xs-2'>";
                                str += "<input type='file' name='file_upload' id='file_upload" + week_no++ + "' onchange='javascript:return Upload_timesheet(this);' style='display: none;'/>";
                                str += "</div></label></td>";
                                debugger;

                                var flag = 0;
                                for (var j = 0; j < obj_get_weekly_timesheet_data.length; j++) {
                                    if (sr_no - 1 == obj_get_weekly_timesheet_data[j]["week_no"]) {
                                        //str += "<td>" + obj_get_weekly_timesheet_data[j]["file_path"] + "</td>";

                                        str += "<td><a id='download_link' class='fancybox'rel='group' href='../ProjectTraining/project_weekly_timesheet/" + obj_get_weekly_timesheet_data[j]["file_path"] + "' style='display: block;'>Download</a></td>";

                                        flag++;
                                    }


                                }
                                if (flag == 0) {
                                    str += "<td></td>";
                                }

                                i = i + 5;
                            }
                            else {
                                str += "<td>" + obj_Get_student_actual[(obj_Get_student_actual.length - 1)]["date"].substr(0, 10) + "</td>";
                                str += "<td>  <input type='button' /></td>";

                                i = obj_Get_student_actual.length - 1;
                            }
                            str += "</tr>";
                            //}
                        }
                        $('#tbl tbody').append(str);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });


            hide_upload_btn = getQueryStringValue('user_id');
            if (hide_upload_btn != '' | hide_upload_btn == undefined) {
                $('.file-upload').hide();
                $(".print_timesheet").css('display', 'none');
            }
        });

        debugger;
        for (var i = 1; i < 19; i++) {
            str1 += '<option value=>' + i + '</option>';
        }
        $('#number').append(str1);

        $('#print').on('click', function () {
            page_number = $('#number :selected').text();
            document.getElementById('hdn_data').value = page_number;
        });

        $(document).on('click', ".print_timesheet", function () {
            page_number = this.parentElement.parentElement.childNodes[0].innerText;
            document.getElementById('hdn_data').value = page_number;
            $('#hdn_print').click();
        });

        $(document).on('click', '#save', function () {
            debugger;
            save_timesheet_data.week_no = week_num;
            save_timesheet_data.from_date = from_date;
            save_timesheet_data.to_date = to_date;
            save_timesheet_data.upload_file_name = upload_file_name;
            var data = JSON.stringify({ "data": save_timesheet_data });
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/project_upload_timesheet",
                data: data,
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    bootbox.alert(result.d, function () {
                        window.location.reload();
                    });
                },
                error: function (error) {

                }
            });
        });



        function Upload_timesheet(event) {
            debugger;
            upload_file_name = '';

            current_event = event.id;
            try {
                debugger;
                var fileToUpload = GetFileNameFromPath(event.value);

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));
                var temp_event = $(event).closest('tr')[0];

                from_date = temp_event.childNodes[1].innerText;
                to_date = temp_event.childNodes[2].innerText;
                week_num = temp_event.childNodes[0].innerText;


                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../Handler/project_week_timesheet_upload.ashx?week_num=' + week_num,
                                secureuri: false,
                                fileElementId: event.id,
                                dataType: 'json',
                                success: function (data, status) {
                                    debugger;
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                            current_event = '';
                                        }
                                        else {
                                            $('#' + current_event).closest('tr').find('.upload_result').text(data.upfile);
                                            upload_file_name = data.upfile;

                                            $('#save').click();
                                            current_event = '';
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);

                                    $('#upload_result').text('file upload successfully.');


                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    current_event = '';
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    alert('Invalid File Type. Please upload  only .jpeg and .png file');
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
    </script>

</asp:Content>
