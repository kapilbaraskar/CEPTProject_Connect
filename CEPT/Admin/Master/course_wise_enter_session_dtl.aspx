<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="course_wise_enter_session_dtl.aspx.cs" Inherits="Admin_Master_course_wise_enter_session_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>


    <script type="text/javascript">
        var oTable, oTable3;
        var table_headers, table_headers_xls;
        var no_of_held = '';
        var year = '';
        var sem = '';
        var course_code = '';
        var tempData = [];
        var isExamValidate = true;
        var submit_flag = false;
        var student_attendance;
        var course_code_v2 = '';

        $(document).ready(function () {
            course_code_v2 = $('#hdn_code').val();
            $('#course_code_v2').text(course_code_v2);

            course_wise_student();
            $('#session_date').datepicker({ dateFormat: 'dd/mm/yy' });
            $('#btnsave_data').on('click', function () {
                save_manully_session();

                //course_wise_student();
                return false;
            });
            return false;

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
        function CheckMarksDocumentExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'xls':
                    case 'xlxs':
                    case 'xlsx':
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

        function UploadAttendance() {
            try {
                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                var ses_data = $('#hdn_session').val();
                if (CheckMarksDocumentExtension(fileToUpload)) {
                    ses_data = ses_data.replace(/"/g, "'");
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        type: "POST",
                        url: '../../Handler/Course_wise_session_upload.ashx',
                        secureuri: false,
                        data: { "session_data": ses_data, "course_code": $('#hdn_code').val(), "semester_type": $('#hdn_semester').val(), "year_code": $('#hdn_year').val() },
                        fileElementId: 'reservation_upload_document',
                        //dataType: 'json',
                        dataType: 'text',
                        success: function (data, status) {

                            if (data == 'Data Saved Successfully') {
                                bootbox.alert(data);
                                $('#reservation_upload_document').val('');
                                course_wise_student();
                                return false;

                            }
                            else if (data == 'Session Date Format must be DD/MM/YYYY') {
                                bootbox.alert('Session Date Format must be DD/MM/YYYY');
                                $("#UploadingProgress").fadeOut(200);
                                $('#reservation_upload_document').val('');
                            }
                            else if (data == 'Problem in update DATA.') {
                                bootbox.alert('Problem in update Data.');
                                $("#UploadingProgress").fadeOut(200);
                                $('#reservation_upload_document').val('');
                            }
                            else if (data == 'Problem in save data') {
                                bootbox.alert('Problem in save data');
                                $("#UploadingProgress").fadeOut(200);
                                $('#reservation_upload_document').val('');
                            }
                            else {
                                data = JSON.parse(data);
                                $("#UploadingProgress").fadeOut(200);
                                bootbox.alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                $('#reservation_upload_document').val('');

                            }
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {
                                    alert("Data Saved Successfully ");
                                    return false;

                                }
                            }
                        },
                        error: function (data, status, e) {
                            $("#UploadingProgress").fadeOut(200);
                            alert(data.responseText);
                            window.location.reload();
                        }
                    });
                    //}
                }
                else {
                    alert('Invalid File Type. Please upload .xls file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function course_wise_student() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_wise_session_dtl",
                data: "{Course_Code:'" + $('#hdn_code').val() + "', semester:'" + $('#hdn_semester').val() + "', year:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        course_wise_session_dtl(data.d);
                        $('#div_course_list').css('display', 'block');

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            //return false;
        }


        function save_manully_session() {

            if ($("#session_name").val() == "") {
                bootbox.alert("Please Insert Session Name");
                return false;
            }
            if ($("#session_date").val() == "") {
                bootbox.alert("Please Insert Session Date");
                return false;

            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/manully_save_session",
                data: "{Course_Code:'" + $('#hdn_code').val() + "', Session_Name:'" + $("#session_name").val() + "',Session_Date:'" + $("#session_date").val() + "',semester:'" + $('#hdn_semester').val() + "', year:'" + $('#hdn_year').val() + "',user_id:''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "true") {

                            course_wise_student();
                            bootbox.alert("Data Saved Successfully");
                            $('#session_name').val('');
                            $('#session_date').val('');
                            //location.reload();
                            //
                        }
                        else {
                            bootbox.alert("Problem in Data");
                            return false;
                        }

                        // course_wise_session_dtl(data.d);
                        //$('#div_course_list').css('display', 'block');

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            //return false;
        }

        function course_wise_session_dtl(data) {
            var columns = set_table_columns(JSON.parse(data)[0]);
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),

                "aoColumns": columns


            });

            $('#DataList').css('display', 'block');

        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Session Name", "mData": "session_name", "bSortable": false });
            columns.push({
                "sTitle": "Session Date", "mData": "session_date", "bSortable": false, fnRender: function (data) {
                    if (data.aData.session_date != '' && data.aData.session_date != null) {
                        // var date_formate = data.aData.session_date.split('/');
                        // var new_date = date_formate[1] + "/" + date_formate[0] + "/" + date_formate[2].substring(0, 4);

                        // return new_date;
                        return data.aData.session_date;
                    }
                    else {
                        return '';
                    }
                }
            });
            columns.push({
                "sTitle": "Action", "mData": "session_id", "bSortable": false, fnRender: function (data) {
                    if (data.aData.is_submit == "Y") {
                        $('#reservation_upload_document').prop('disabled', true);
                        $('#btnsave_data').prop('disabled', true);
                        return '<center><button type="button" id=' + data.aData.session_id + ' onclick="rowClick_cancel(this)" disabled>Cancel</button></center>';
                    }
                    else {
                        return '<center><button type="button" id=' + data.aData.session_id + ' onclick="rowClick_cancel(this)">Cancel</button></center>';
                    }

                }
            });
            return columns;
        }


        function rowClick_cancel(row) {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/cancel_session",
                    data: "{session_id:'" + row.id + "',Course_Code:'" + $('#hdn_code').val() + "', semester:'" + $('#hdn_semester').val() + "', year:'" + $('#hdn_year').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                course_wise_student();
                                bootbox.alert("Cancel successfully");
                                location.reload();
                                // get_studio_detail();

                            }
                            else {
                                bootbox.alert('Problem in Data');
                            }
                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

        function step_next_page() {
            window.location = "student_wise_session_attendence.aspx?c=" + $('#hdn_code').val() + "&s=" + $('#hdn_semester').val() + "&y=" + $('#hdn_year').val();

        }
        function display_excel() {
           
            var href = $('.downloadLink').attr('href');
            window.location.href = href;
            //$("#btnDownloadExcelDocuments").click();
        }

        $("#btn_download_prev1").click(function () {
            
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Wise Session Attendance Entry
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <h4>Note :</h4>
        <br />

        <p><b>Step 1 - Add Session</b></p>
        <p>1: You can upload date wise session details. Click on <span style="color: blue;"><b>Excel Format</b></span> button to Export and save a .xlsx file.</p>
        <p>2: Open the .xlsx file in Excel. Enter Session Name and Session Date Value , and save the file as a .xlsx file.</p>
        <p>3: <span style="color: blue;"><b>Choose File</b></span> to Upload Excel File you just saved. It saves the date wise session details to the Connect database.</p>
        <p>4: You can also manually enter the Session Name and Session Date Values. Click <span style="color: blue;"><b>Save</b></span> Button to save the entered data.</p>
        </br>
        <p><b>Step 2 - Attendance Entry</b></p>
        <p>1: Once you are ready to Save the date wise session details, Then Click <span style="color: blue;"><b>Step 2</b></span> Button.</p>
        <%-- <p>Step 6: You can export all data into Excel by clicking the <span style="color: blue;"><b>Excel Data</b></span> Button.</p>
        <p style="color: red;">Note: You can not change once you final submit all Session Attended You cannot edit the data once you Submit the attendance data.</p>--%>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Step 1 - Add Session (Course Code : <span id="course_code_v2" style="color: blue;"></span>)</strong>
                <span style="float: right;">
                    <input id="btn_excel_data" type="button" class="btn btn-primary" value="Excel Data" style="height: 40px; margin-top: -10px; display: none;" onclick="display_data_for_excel()" />
                    <input id="btn_excel_format" type="button" class="btn btn-primary" value="Csv Format" style="height: 40px; margin-top: -10px; display: none;" onclick="display_excel_format()" />
                    <%--<input id="btn_excel" type="button" class="btn btn-primary" value="Excel Format" style="height: 40px; margin-top: -10px;" onclick="display_excel()" />--%>
                     <a href="../../ExcelFormatFiles/Date_Wise_Session.xlsx" download="Date_Wise_Session" download>Download Excel Format</a>
                </span>
            </div>

            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Upload Excel File:</td>
                                <td>
                                    <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                                        onchange="javascript:return UploadAttendance();" /></td>

                            </tr>
                            <tr>
                                <td>Session Name :
                                </td>
                                <td>
                                    <input type="text" id="session_name" placeholder="Session Name" />
                                    <%--<select class="chosen-select" id="drptype">
                                    </select>--%>
                                </td>
                                <td>Session Date :
                                </td>
                                <td>
                                    <input type="text" id="session_date" class="marg-btm" placeholder="DD/MM/YYYY" />
                                    <%--<select class="chosen-select" id="drptype">
                                    </select>--%>
                                </td>

                                <td>
                                    <button class="btn btn-primary" id="btnsave_data">
                                        Save
                                    </button>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_course_list" class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Course Wise Session Attendance Entry </strong>
                <%--<span style="float: right;">
                    <input id="btn_excel_data" type="button" class="btn btn-primary" value="Excel Data" style="height: 40px; margin-top: -10px; display: none;" onclick="display_data_for_excel()" />
                    <input id="btn_excel_format" type="button" class="btn btn-primary" value="Csv Format" style="height: 40px; margin-top: -10px; display: none;" onclick="display_excel_format()" />
                    <input id="btn_excel" type="button" class="btn btn-primary" value="Excel Format" style="height: 40px; margin-top: -10px;" onclick="display_excel()" />
                </span>--%>
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
        <div id="div_btn" style="text-align: center;">
        </div>

        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Step 2 - Attendance Entry</strong>
            </div>
            <div style="padding: 10px;" id="upload_div">
                <div style="margin-top: 1%; display: block;">
                    <table style="width: 37%; margin-left: 15%;">

                        <tr>
                            <td align="right">
                                <button id='btnstep_data' type='button' style='display: block;' class='btn btn-lg btn-primary' onclick='step_next_page()'>
                                    <i class='icon-save bigger-160'></i>Step 2
                                </button>
                            </td>

                            <td align="center" style="display: none;">
                                <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_attendance()">Submit</button>
                            </td>
                        </tr>
                        <tr>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </div>




    <input type="hidden" id="hdn_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_semester" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_session" runat="server" clientidmode="Static" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadExcelDocuments_Click" ClientIDMode="Static" />
</asp:Content>

