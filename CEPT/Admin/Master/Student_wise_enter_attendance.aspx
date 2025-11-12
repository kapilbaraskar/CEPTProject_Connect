<%@ Page Title="Course Wise Attendace" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_wise_enter_attendance.aspx.cs" Inherits="Admin_Master_Student_wise_enter_attendance_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js"></script>

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
        var data_value = { 'user_id': '', 'course_code': '', 'no_of_session_attended': '', 'attendance_percentage': null, 'is_submit': 'N', 'semester_type': null, 'year_semester': null };

        $(document).ready(function () {
            get_session_held_dtl();
            $('#btnsave').on('click', function () {
                save_session_held();
                return false;
            });
        });
        

        function save_session_held() {
           course_code = hdn_code.value;
           sem = hdn_semester.value;
           year = hdn_year.value;
            no_of_held = no_held_txt.value;
             var held_value = no_held_txt.value;
            if (held_value == "") {
                bootbox.alert('Please Enter Total Number Of Session Held');
                $('#no_held_txt').focus();
                return false;
            }

            $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_attendance_dtl",
                    data: "{Course_Code: '" + course_code + "',semester: '" + sem + "',year: '" + year + "',no_of_held: '" + no_of_held +"',user_id:''}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "Update Data") {
                                bootbox.alert("Update Data Successfully");
                            }
                            else
                            {
                                bootbox.alert("Save Data Successfully");
                                course_wise_student();
                            }
                        }
                        else {
                            bootbox.alert('Problem in Data');
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }

        function get_session_held_dtl()
        {
             course_code = hdn_code.value;
             sem = hdn_semester.value;
             year = hdn_year.value;
             no_of_held = no_held_txt.value;

            $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_number_of_session_held_dtl",
                    data: "{Course_Code: '" + course_code + "',semester: '" + sem + "',year: '" + year + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "")
                        {
                            var data = JSON.parse(data.d);
                            no_held_txt.value = data[0]["no_of_session_held"];
                            if (data[0]["doc_pdf"] != "")
                            {
                                $('#lbl_port_file_name').html('<b>' + data[0]["doc_pdf"] + '</b>');
                                
                            }
                            
                            course_wise_student();
                        }
                        else {
                            //bootbox.alert('Problem in Data');
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }



        function course_wise_student() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_attendance_allocate_dtl",
                data: "{course_code:'" + $('#hdn_code').val() + "', sem_code:'" + $('#hdn_semester').val() + "', year_code:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "")
                    {
                        student_attendance = JSON.parse(data.d);
                        course_wise_student_dtl(data.d);
                        $('#div_course_list').css('display', 'block');
                        if (student_attendance[0]["is_submit"] == "Y")
                        {
                            $('#upload_div').css('display', 'none');
                            $("#btnsave").prop('disabled', true);
                            $('.inline_input').attr("disabled", "disabled");
                            
                        }
                    }
                    else
                    {
                        user_dtl();
                    }
                    
                  
                },
                    error: function (result) {
                        alert(result);
                    }
                });

            //return false;
        }

        function user_dtl() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_attendance_user_dtl",
                //url: "../../WebService.asmx/get_attendance_allocate_dtl",
                data: "{course_code:'" + $('#hdn_code').val() + "', sem_code:'" + $('#hdn_semester').val() + "', year_code:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        student_attendance = JSON.parse(data.d);
                        course_wise_student_dtl(data.d);

                        $('#div_course_list').css('display', 'block');
                    }
                    else {
                    }


                },
                error: function (result) {
                    alert(result);
                }
            });

            //return false;
        }

        function course_wise_student_dtl(data) {
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

            columns.push({ "sTitle": "Student Code", "mData": "user_id", "bSortable": false });
            columns.push({ "sTitle": "Student Name", "mData": "full_name", "bSortable": false });
            columns.push({
                "sTitle": "Number Of Session Attended", "mData": "no_of_session_attended", "bSortable": false, mRender: function (data) {

                    return "<input type='text' value='" + data + "' class='inline_input' onkeypress='return IsNumeric(event);'/>";
                }
            });



            columns.push({ "sTitle": "Attendance Percentage", "mData": "attendance_percentage", "bSortable": false });
            return columns;
        }


        function IsNumeric(e) {
            //alert(e.which + " : " + e.keyCode);

            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 46) {
                if ($(document.activeElement).val().indexOf('.') != -1) {
                    return false;
                }
                
                if ($(document.activeElement).val() == '100') {
                    return false;
                }
                
            }

            if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {

                if (($(document.activeElement).val().indexOf('.') != -1) && ($(document.activeElement)[0].selectionStart > $(document.activeElement).val().indexOf('.'))) {

                    var no_held = $('#no_held_txt').val();
                   

                    if ($(document.activeElement).val() > no_held) {
                        return false;
                    }

                    if ($(document.activeElement).val().substr($(document.activeElement).val().indexOf('.') + 1).length >= 2) {
                        return false;
                    }
                     
                    else {
                        return true;
                    }
                    
                }
                else {

                    var no_held = $('#no_held_txt').val();
                    

                    if ($(document.activeElement).val() > no_held) {
                        return false;
                    }

                    if (parseInt($(document.activeElement).val()) > 10) {
                        return false;
                    }
                    else if (parseInt($(document.activeElement).val()) == 10) {
                        if (keyCode != 48) {
                            return false;
                        }
                        else {
                            if ($(document.activeElement).val().indexOf('.') != -1) {
                                return false;
                            }
                        }
                    }
                }

                return true;
            }
            else {
                return false;
            }
        }

        function save_student_attendance_Data() {
            
            $("#example tbody tr").each(function (i) {

                data_value.user_id = $(this).children().eq(0).html();
                data_value.no_of_session_attended = $(this).children().eq(2)[0].children[0].value;

                data_value.course_code = $('#hdn_code').val();
                
                data_value.semester_type = $('#hdn_semester').val();
                data_value.year_semester = $('#hdn_year').val();

                tempData.push(data_value);
               
                data_value = { 'user_id': '', 'course_code': '', 'no_of_session_attended': '', 'attendance_percentage': null, 'is_submit': 'N', 'semester_type': null, 'year_semester': null };
            });

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_all_students_attendance_value",
                    //async: false,
                    data: "{student_att_Data:'" + JSON.stringify(tempData) + "',status:'" + submit_flag + "'}",
                    dataType: "json",
                    success: function (data) {
                        tempData = [];
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'Data Saved Successfully')
                            {
                                bootbox.alert("Data Saved Successfully");
                                course_wise_student();
                            }
                            else {
                                bootbox.alert(data.d);
                            }
                        }
                        //course_wise_exam();
                    },
                    error: function (result) {
                        tempData = [];
                        alert(result);
                    }
                });
        }


        function submit_attendance() {

            if ($('#lbl_port_file_name').text() == "") {
                bootbox.alert('Please Upload PDF File');
                return false;
            }


            isExamValidate = true;
            $("#example tbody tr").each(function (i)
            {
                var user_id = $(this).children().eq(0).html();
                var no_of_session_attended = $(this).children().eq(2)[0].children[0].value;

                if (no_of_session_attended == '')
                {
                    bootbox.alert('Please Enter Marks or Select No Of Session Attended Detail for Student Code : ' + $(this).children().eq(0).html());
                    isExamValidate = false;
                        return false;
                    
                }
            });

            if (isExamValidate)
            {
                submit_flag = true;
                save_student_attendance_Data();
                submit_flag = false;
                course_wise_student();
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
                debugger;
                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                var ses_data = $('#hdn_session').val();
                if (CheckMarksDocumentExtension(fileToUpload)) {
                    ses_data = ses_data.replace(/"/g, "'");
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/Student_attendance_upload.ashx',
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
                            else if (data == 'Problem in update DATA.')
                            {
                                bootbox.alert('Problem in update Data.');
                                $("#UploadingProgress").fadeOut(200);
                                $('#reservation_upload_document').val('');
                            }
                            else
                            {
                                data = JSON.parse(data);
                                $("#UploadingProgress").fadeOut(200);
                                bootbox.alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                $('#reservation_upload_document').val('');

                            }
                            if (typeof (data.error) != 'undefined')
                            {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {
                                    alert("Data Saved Successfully ");
                                    return false;

                                }
                            }
                            
                            //$("#UploadingProgress").fadeOut(200);
                            //alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                            //$('#reservation_upload_document').val('');
                        },
                        error: function (data, status, e) {
                            $("#UploadingProgress").fadeOut(200);
                            alert(data.responseText);
                            window.location.reload();
                            //$('#reservation_upload_document').val('');
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
        function display_data_for_excel() {

            var str = '<div id="DataList_xls_format" style="display: none;"><table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%"><thead></thead><tbody></tbody></table></div>';

            $('#mynewModal3 .modal-body').html(str);

            table_headers_xls = [{ "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                { "sTitle": "No Of Session Attended", "mData": "no_of_session_attended", "bSortable": false },
                { "sTitle": "Attendance Percentage", "mData": "attendance_percentage", "bSortable": false }];

            if (oTable3 != null) {
                oTable3.fnDestroy();
                $("#DataList_xls_format").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_xls_format" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable3 = $("#example_xls_format").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
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

                //"aaData": JSON.parse(data),
                "aaData": student_attendance,

                "aoColumns": table_headers_xls
            });

            $('#DataList_xls_format').css('display', 'block');
            $('#btn_show_modal3').click();
        }
        function display_excel_format() {

            var str = '<div id="DataList_xls_format" style="display: none;"><table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%"><thead></thead><tbody></tbody></table></div>';

            $('#mynewModal3 .modal-body').html(str);

            table_headers_xls = [{ "sTitle": "STUDENT_CODE", "mData": "user_id", "bSortable": false },
                { "sTitle": "NO_OF_SESSION_ATTENDED", "mData": null, "bSortable": false }
            ];

            

            if (oTable3 != null) {
                oTable3.fnDestroy();
               
                $("#DataList_xls_format").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_xls_format" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable3 = $("#example_xls_format").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
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
                

                //"aaData": JSON.parse(data),
                "aaData": student_attendance,

                "aoColumns": table_headers_xls
            });

            $('#DataList_xls_format').css('display', 'block');
            $('#btn_show_modal3').click();
        }
        function CheckUserPDFExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
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


        function UploadPdfFile() {
            try {
                debugger;
                var fileToUpload = GetFileNameFromPath($('#att_submit_pdf').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPDFExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {
                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/course_wise_attendance_pdf_upload.ashx',
                                secureuri: false,
                                data: { 'UploadType': 'att_submit_pdf', "course_code": $('#hdn_code').val(), "semester_type": $('#hdn_semester').val(), "year_code": $('#hdn_year').val() },
                                fileElementId: 'att_submit_pdf',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#att_submit_pdf').val("");
                                            $('#lbl_port_file_name').html('<b>' + fileToUpload + '</b>');
                                            FileName = data.upfile;
                                            bootbox.alert('PDF File Uploaded Successfully.');
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
                    $('#att_submit_pdf').val('');
                    alert('Invalid File Type. Please upload .pdf format file.');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function display_excel() {
            $("#btnDownloadExcelDocuments").click();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Wise Attendace
            </h1>
        </div>
    </div>
     <div class="well" style="background-color: White;">
        <h4>Note :</h4>
        <br />
            
        <p>Step 1: Enter Total Number of Sessions Held Value, then click <span style="color:blue;"><b>Save</b></span> Button to save the total number of sessions held.</p>
        <p>Step 2: You can upload Number Of Sessions Attended for each student. Click on <span style="color:blue;"><b>Excel Format</b></span> button to Export and save a .csv File.</p>
        <p>Step 3: Open the .csv file in Excel. Enter Number of Sessions Attended Value for each student, and save the file as a .xls file (Excel 97-2003 format).</p>
        <p>Step 4: Scroll down, <span style="color:blue;"><b>Choose File</b></span> to Upload Excel File you just saved. It saves the student-wise attendance to the Connect database.</p>
        <p>Step 5: You can also manually enter the Number of Sessions Attended Values for each student. Click <span style="color:blue;"><b>Save</b></span> Button at the bottom of the page to save the entered data.</p>
        <p>Step 6: Once you are ready to submit the attendance data, Click <span style="color:blue;"><b>Submit</b></span> Button.</p>
        <p>Step 7: You can export all data into Excel by clicking the <span style="color:blue;"><b>Excel Data</b></span> Button.</p>
        <p style="color:red;">Note: You can not change once you final submit all Session AttendedYou cannot edit the data once you Submit the attendance data.</p>

    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Number Of Session Held</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                   Total Number Of Session Held :
                                </td>
                                <td>
                                    <input type="text" id="no_held_txt" />
                                </td>
                                <td>
                                     <button class="btn btn-primary" id="btnsave">
                                        Save
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Course Wise Entered Attendance Detail</strong>
                <span style="float: right;">
                    
                    <input id="btn_excel_data" type="button" class="btn btn-primary" value="Excel Data" style="height: 40px; margin-top: -10px;" onclick="display_data_for_excel()" />
                    <input id="btn_excel_format" type="button" class="btn btn-primary" value="Csv Format" style="height: 40px; margin-top: -10px; display:none;" onclick="display_excel_format()"  />
                    <input id="btn_excel" type="button" class="btn btn-primary" value="Excel Format" style="height: 40px; margin-top: -10px;" onclick="display_excel()" />
                    <input id="btn_show_modal2" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal2" value="Display" style="height: 40px; margin-top: -10px; display: none;" />
                    <input id="btn_show_modal3" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal3" value="Excel" style="height: 40px; margin-top: -10px; margin-left: 10px; display: none;" />
                </span>
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
            
            <div style="border: 1px solid black;padding:10px;" id="upload_div">
    <div style="margin-top: 1%;">
        <div style="float: left; width: 25%;">1. Upload PDF File :</div>
        <input type="file" name="att_submit_pdf" id="att_submit_pdf" onchange="javascript:return UploadPdfFile();" " />
        <span id="lbl_port_file_name" style="vertical-align: super;"></span>
    </div>
        
		<div style="margin-top: 1%;">
        <div style="float: left; width: 25%;">2. Upload Excel File:</div>
        <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                        onchange="javascript:return UploadAttendance();" />
    </div>
		<div style="margin-top: 1%;">
             <table style="width: 62%; margin-left: 15%;">

            <tr>
                <td align="right">
                    <button id='btnsave_data' type='button' style='display: block;' class='btn btn-lg btn-primary' onclick='save_student_attendance_Data()'>
                        <i class='icon-save bigger-160'></i>Save
                    </button>
                </td>
               
                <td align="center">
                    <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_attendance()">Submit</button>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
            </div>
        </div>
        </div>
        <div id="div_btn" style="text-align: center;">
        </div>
        
    </div>

    <div class="modal fade" id="mynewModal2" style="display: none; top: 5%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H2">Hello</h4>
                </div>

                <div class="modal-body">
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close2" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <%--<button id="btn_modal_save2" type="button" class="btn btn-primary" onclick="updateColumn()">Save changes</button>--%>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="mynewModal3" style="display: none; top: 5%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H3">Excel Download</h4>
                </div>

                <div class="modal-body">
                    <div id="DataList_xls_format" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close3" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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

