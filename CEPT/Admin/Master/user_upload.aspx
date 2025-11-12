<%@ Page Title="Upload Master - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="user_upload.aspx.cs" Inherits="Admin_Master_user_upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js?t=28062019"></script>
    <script language="javascript" type="text/javascript">
        var oTable;
        var semester = '';
        var year_code = '';
        var drp_selected_id = '';
        var drpselect_selection = '';

        //M 27062019
        jQuery.extend({
        handleError: function (s, xhr, status, e) {
                // If a local callback was specified, fire it
                if (s.error)
                    s.error(xhr, status, e);
                // If we have some XML response text (e.g. from an AJAX call) then log it in the console
                else if (xhr.responseText)
                    console.log(xhr.responseText);
            }
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
                    //case 'xls':
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

        function UploadStudent() {
        
            try {
                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                var ses_data = $('#hdn_session').val();
                //var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));
               
                if (CheckMarksDocumentExtension(fileToUpload)) {
                    //if (filename != "" && filename != null) {
                        ses_data = ses_data.replace(/"/g, "'");
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/UploadFile.ashx',
                            secureuri: false,
                            //data: { "session_data": ses_data, "course_code": $('#hdn_c').val(), "semester_type": sem, "year_code": year },
                            data: { 'UploadType': 'Student' },
                            fileElementId: 'reservation_upload_document',
                            dataType: 'json',
                            success: function (data, status) {
                                
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        
                                    }
                                }
                                $("#UploadingProgress").fadeOut(200);
                                alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                $('#reservation_upload_document').val('');
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
                    alert('Invalid File Type. Please upload .xlsx file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }
        //M 27062019

        //M 22112019
        function UploadCourse() {
            
            try {
                var fileToUpload = GetFileNameFromPath($('#course_master_uploadd').val());
                var ses_data = $("#hdn_session").val();
                //var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckMarksDocumentExtension(fileToUpload)) {
                    //if (filename != "" && filename != null) {
                    ses_data = ses_data.replace(/"/g, "'");
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/UploadFile.ashx',
                        secureuri: false,
                        //data: { "session_data": ses_data, "course_code": $('#hdn_c').val(), "semester_type": sem, "year_code": year },
                        data: { 'UploadType': 'Course', 'session_data': ses_data, 'course_code': $('#hdn_c').val(), 'semester_type': semester, 'year_code': year_code },
                        fileElementId: 'course_master_uploadd',
                        dataType: 'json',
                        success: function (data, status) {
                           
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {

                                }
                            }
                            $("#UploadingProgress").fadeOut(200);
                            alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                            $('#course_master_uploadd').val('');
                        },
                        error: function (data, status, e) {
                           
                            $("#UploadingProgress").fadeOut(200);
                            alert(data.responseText);
                            window.location.reload();
                            //$('#course_master_uploadd').val('');
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
        //M 22112019

        function course_master_upload() {

            $('#div_course_master_upload').css("display", "block");

            $("#" + '<%=course_master_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/Course_Master_Upload.ashx',
                'buttonText': 'Choose File',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'formData': { 'semester_type': semester, 'year_code': year_code, 'session_data': $("#hdn_session").val() },
                'onUploadSuccess': function (file, data, response) {
                
                    //alert(data);

                    FileName = file.name;

                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data, function () {
                            window.location.reload();
                        });
                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                    }
                    else {
                        display_course_master_upload_error_data(data);
                    }
                }
            });

            return false;

        }

        function semchange() {
            
            semester = $('#drpsemester').val();
            //alert(semester);

            if (semester == '') {
                $('#' + drp_selected_id).css("display", "none");
            }
            else if (year_code != '') {
                if (drpselect_selection == "student_wise_course_upload") {
                    student_course_upload();
                }
                else if (drpselect_selection == "course_master") {
                    course_master_upload();
                }
            }
        }

        function yearchange() {
           
            year_code = $('#drpyear').val();
            //alert(semester);

            if (year_code == '') {
                $('#' + drp_selected_id).css("display", "none");
            }
            else if (semester != '') {
                if (drpselect_selection == "student_wise_course_upload") {
                    student_course_upload();
                }
                else if (drpselect_selection == "course_master") {
                    course_master_upload();
                }
            }
        }

        function student_course_upload() {

            $('#div_student_wise_course_upload').css("display", "block");

            $("#" + '<%=student_wise_course_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/Student_Wise_Course_Upload.ashx',
                'buttonText': 'Choose File',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'formData': { 'semester_type': semester, 'year_code': year_code },
                'onUploadSuccess': function (file, data, response) {
                    
                    //alert(data);

                    FileName = file.name;

                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data, function () {
                            window.location.reload();
                        });
                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                    }
                    else {
                        display_student_wise_course_upload_error_data(data);
                    }
                }
            });

            return false;

        }

        

        $(document).ready(function () {
            $("#" + '<%=area_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/Area_mst_upload.ashx',
                'buttonText': 'Area Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
               
                    FileName = file.name;
                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data);

                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                    }
                    else {

                        display_area_upload_error_data(data);

                    }

                    //   alert(FileName);
                }
            });

            <%--$("#" + '<%=user_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/UploadFile.ashx',
                'buttonText': 'User Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                //  'successTimeout': 15,
                //  'width': 90,
                'onUploadSuccess': function (file, data, response) {

                    FileName = file.name;
                   
                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                        return false;
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data);
                        $('#dt_user_upload tbody').html('');
                        $('#DataList_user').css('display', 'none');
                        return false;
                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                        return false;
                    }
                    else {

                        display_user_upload_error_data(data);

                    }


                    //   alert(FileName);
                }
            });--%>
            

            $("#" + '<%=department_master.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/department.ashx',
                'buttonText': 'Department Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
                    
                    FileName = file.name;
                    alert(data);
                    //   alert(FileName);
                }
            });
            $("#" + '<%=instructer_master.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/instructer.ashx',
                'buttonText': 'Instructer Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
                    
                    FileName = file.name;
                    alert(data);
                    //   alert(FileName);
                }
            });

//            $('#drpselect').on('change', function () {
//                var str = $('#drpselect').val();

//                if (str == "student_wise_course_upload") {
//                    $('#student_wise_course').css("display", "block");
//                    $('#area').css("display", "none");
//                    $('#user').css("display", "none");
//                    $('#course').css("display", "none");
//                    $('#dept').css("display", "none");
//                    $('#ins').css("display", "none");
//                    $('#DataList_user').css("display", "none");

//                    bindsemdata();
//                    bindyeardata_for_cross_reg();

//                }

//                if (str == "area_upload") {
//                    $('#area').css("display", "block");
//                    $('#user').css("display", "none");
//                    $('#course').css("display", "none");
//                    $('#dept').css("display", "none");
//                    $('#ins').css("display", "none");
//                    $('#DataList_user').css("display", "none");
//                    $('#student_wise_course').css("display", "none");
//                }
//                if (str == "user_upload") {
//                    $('#area').css("display", "none");
//                    $('#user').css("display", "block");
//                    $('#course').css("display", "none");
//                    $('#dept').css("display", "none");
//                    $('#ins').css("display", "none");
//                    $('#DataList_user').css("display", "none");
//                    $('#student_wise_course').css("display", "none");
//                }
//                if (str == "course_master") {
//                    $('#course').css("display", "block");
//                    $('#area').css("display", "none");
//                    $('#user').css("display", "none");
//                    $('#dept').css("display", "none");
//                    $('#ins').css("display", "none");
//                    $('#DataList_user').css("display", "none");
//                    $('#student_wise_course').css("display", "none");
//                }
//                if (str == "department_master") {
//                    $('#course').css("display", "none");
//                    $('#area').css("display", "none");
//                    $('#user').css("display", "none");
//                    $('#dept').css("display", "block");
//                    $('#ins').css("display", "none");
//                    $('#DataList_user').css("display", "none");
//                    $('#student_wise_course').css("display", "none");
//                }
//                if (str == "instructer_master") {
//                    $('#dept').css("display", "none");
//                    $('#area').css("display", "none");
//                    $('#user').css("display", "none");
//                    $('#course').css("display", "none");
//                    $('#ins').css("display", "block");
//                    $('#DataList_user').css("display", "none");
//                    $('#student_wise_course').css("display", "none");
//                }
//                if (str == "") {
//                    $('#ins').css("display", "none");
//                    $('#area').css("display", "none");
//                    $('#user').css("display", "none");
//                    $('#course').css("display", "none");
//                    $('#ins').css("display", "none");
//                    $('#DataList_user').css("display", "none");
//                    $('#student_wise_course').css("display", "none");
//                }
            //            });



            $('#drpselect').on('change', function () {
                drpselect_selection = $('#drpselect').val();
                semester = '';
                year_code = '';

                $('#student_wise_course').css("display", "none");
                $('#area').css("display", "none");
                $('#user').css("display", "none");
                $('#course').css("display", "none");
                $('#dept').css("display", "none");
                $('#ins').css("display", "none");

                $('#DataList_user').css("display", "none");

                $('#div_drp').css("display", "none");
                $('#div_student_wise_course_upload').css("display", "none");
                $('#div_course_master_upload').css("display", "none");

                $('#div_drp').html("<p style='color:Red;padding-left:5px;'> Note : Select Semester and Year of allocation to proceed.</p><table border='0' cellpadding='10' cellspacing='5'>" +
                                    "<tr><td>Semester :</td><td><select class='chosen-select' id='drpsemester' onchange='semchange()'></select></td>" +
                                    "<td>Year Of Allocation :</td><td><select class='chosen-select' id='drpyear' onchange='yearchange()'></select></td></tr></table>");


                if (drpselect_selection == "student_wise_course_upload") {
                    $('#student_wise_course').css("display", "block");

                    $('#div_drp').css("display", "block");

                    drp_selected_id = "div_student_wise_course_upload";

                    bindsemdata();
                    bindyeardata_for_cross_reg();

                }

                if (drpselect_selection == "area_upload") {
                    $('#area').css("display", "block");

                    drp_selected_id = 'area';
                }

                if (drpselect_selection == "user_upload") {
                    $('#user').css("display", "block");

                    drp_selected_id = 'user';
                }

                if (drpselect_selection == "course_master") {
                    $('#course').css("display", "block");

                    $('#div_drp').css("display", "block");

                    drp_selected_id = "div_course_master_upload";

                    bindsemdata();
                    bindyeardata_for_cross_reg();
                }

                if (drpselect_selection == "department_master") {
                    $('#dept').css("display", "block");

                    drp_selected_id = 'dept';
                }

                if (drpselect_selection == "instructer_master") {
                    $('#ins').css("display", "block");

                    drp_selected_id = 'ins';
                }

                if (drpselect_selection == "") {
                    drp_selected_id = '';
                }
            });

        });

        function display_user_upload_error_data(data) {


            bootbox.alert("There are some problem in excel data please check and correct data");

           

            $('#dt_user_upload tbody').html('');

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="dt_user_upload"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#dt_user_upload").dataTable({

                "bPaginate": true,
                "bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //  "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
          { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
          { "sTitle": "User Id", "mData": "User_Id", "bSortable": false },
           { "sTitle": "Remark", "mData": "Remark", "bSortable": false }



            ]


            });

            $('#DataList_user').css('display', 'block');


        }

        function display_area_upload_error_data(data) {


            bootbox.alert("There are some problem in excel data please check and correct data");

          

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="dt_user_upload"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#dt_user_upload").dataTable({

                "bPaginate": true,
                "bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //  "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
          { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
          { "sTitle": "Area Code", "mData": "area_code", "bSortable": false },
           { "sTitle": "Remark", "mData": "Remark", "bSortable": false }



            ]


            });

            $('#DataList_user').css('display', 'block');


        }

        function display_student_wise_course_upload_error_data(data) {

            bootbox.alert("There are some problem in excel data please check and correct data");

            

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="dt_user_upload"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#dt_user_upload").dataTable({

                "bPaginate": true,
                "bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //  "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
          { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
          { "sTitle": "User Id", "mData": "User_Id", "bSortable": false },
           { "sTitle": "Remark", "mData": "Remark", "bSortable": false }



            ]


            });

            $('#DataList_user').css('display', 'block');


        }

        function display_course_master_upload_error_data(data) {

            bootbox.alert("There are some problem in excel data please check and correct data");

          

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered table-hover" id="dt_user_upload" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#dt_user_upload").dataTable({

                "bPaginate": true,
                "bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //  "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
          { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
          { "sTitle": "Course ID", "mData": "User_Id", "bSortable": false },
           { "sTitle": "Remark", "mData": "Remark", "bSortable": false }



            ]


            });

            $('#DataList_user').css('display', 'block');


        }
                
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Upload Master
            </h1>
        </div>
        <div class="row-fluid">
            <div class="span9">
                <div class="control-group">
                    <label class="control-label" for="drpupload">
                    </label>
                    <div class="controls">
                        <select id="drpselect">
                            <option value="">Select Upload</option>
                            <%--<option value="student_wise_course_upload">Student Wise Course Upload</option>--%>
                            <%-- <option value="area_upload">Area upload</option>--%>
                            <option value="user_upload">Student upload</option>
                            <option value="course_master">course catalog</option>
                            <%--  <option value="department_master">Department master</option>--%>
                            <%-- <option value="instructer_master">instructer master</option>--%>
                        </select>
                    </div>
                    
                    <div id="div_drp" style="display:none;">
                        <p style="color:Red;padding-left:5px;">Note : Select Semester and Year of allocation to proceed</p>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester" onchange="semchange()">
                                    </select>
                                </td>
                                <td>
                                    Year Of Allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear" onchange="yearchange()">
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <div class="widget-box" id="student_wise_course" style="display: none;">
                        <div class="widget-box" id="div_student_wise_course_upload" style="display: none;">
                            <asp:FileUpload ID="student_wise_course_upload" runat="server"/>
                        </div>
                    </div>

                    <div class="widget-box" id="area" style="display: none">
                        <asp:FileUpload ID="area_upload" runat="server" />
                    </div>
                    <div class="widget-box" id="user" style="display: none">
                    <%--<asp:FileUpload ID="user_upload" runat="server" />--%>
                        <p>Note : Download Excel Format File and Upload File below.</p><br />
                        <a href="../../ExcelFormatFiles/student_upload-exchange.xlsx" download>Download Excel Format</a><br /><br />
                        <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                                                onchange="javascript:return UploadStudent();" />
                    </div>
                    <div class="widget-box" id="course" style="display: none">
                        <div class="widget-box" id="div_course_master_upload" style="display: none;">
                            <div style="display:none;"><asp:FileUpload ID="course_master_upload" runat="server"/></div>
                            <p>Note : Download Excel Format File and Upload File below.</p><br />
                        <a href="../../ExcelFormatFiles/CatalogUpload.xlsx" download>Download Excel Format</a><br /><br />
                            <input id="course_master_uploadd" type="file" name="course_master_uploadd"
                                                onchange="javascript:return UploadCourse();" />
                        </div>
                    </div>
                    <div class="widget-box" id="dept" style="display: none">
                        <asp:FileUpload ID="department_master" runat="server" />
                    </div>
                    <div class="widget-box" id="ins" style="display: none">
                        <asp:FileUpload ID="instructer_master" runat="server" />
                    </div>
                </div>
            </div>
            <div id="DataList_user" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="dt_user_upload" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <input type="hidden" id="hdn_session" runat="server" clientidmode="Static"/>
</asp:Content>
