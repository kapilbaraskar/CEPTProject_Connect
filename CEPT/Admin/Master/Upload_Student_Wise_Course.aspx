<%@ Page Title="Fees Status - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Upload_Student_Wise_Course.aspx.cs" Inherits="Admin_Master_Upload_Student_Wise_Course" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var oTable;
        var semester = '';
        var year_code = '';

        function semchange(){
            debugger;
            semester = $('#drpsemester').val();
            //alert(semester);

            if (semester == '') {
                $('#div_student_wise_course_upload').css("display", "none");                
            }
            else if (year_code != '') {
                student_course_upload();
            }
        }

        function yearchange() {
            debugger;
            year_code = $('#drpyear').val();
            //alert(semester);

            if (year_code == '') {
                $('#div_student_wise_course_upload').css("display", "none");
            }
            else if (semester != '') {
                student_course_upload();
            }
        }

        function student_course_upload(){

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
                    debugger;
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

            debugger;
        
//            $("#" + '<%=student_wise_course_upload.ClientID%>').uploadify({
//                'swf': '../../Scripts/uploadify.swf',
//                'uploader': '../../Handler/Student_Wise_Course_Upload.ashx',
//                'buttonText': 'Student Wise Course Upload',
//                'fileDesc': 'Image Files',
//                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
//                'multi': false,
//                'auto': true,
//                'successTimeout': 15,
//                'width': 90,
//                'formData': { 'semester_type': semester },
//                'onUploadSuccess': function (file, data, response) {
//                    debugger;
//                    //alert(data);

//                    FileName = file.name;

//                    if (data == "Problem in save data") {
//                        bootbox.alert(data);
//                    }
//                    else if (data == "Data Saved Successfully") {
//                        bootbox.alert(data);
//                    }
//                    else if (data == "null") {

//                        bootbox.alert("No data found in excel");
//                    }
//                    else {
//                        display_student_wise_course_upload_error_data(data);
//                    }
//                }
//            });

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
                    debugger;
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

            $('#drpselect').on('change', function () {
                var str = $('#drpselect').val();

                if (str == "student_wise_course_upload") {
                    $('#student_wise_course').css("display", "block");
                    $('#area').css("display", "none");
                    $('#user').css("display", "none");
                    $('#course').css("display", "none");
                    $('#dept').css("display", "none");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");

                    bindsemdata();
                    bindyeardata_for_cross_reg();

                }

                if (str == "area_upload") {
                    $('#area').css("display", "block");
                    $('#user').css("display", "none");
                    $('#course').css("display", "none");
                    $('#dept').css("display", "none");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");
                }
                if (str == "") {
                    $('#ins').css("display", "none");
                    $('#area').css("display", "none");
                    $('#user').css("display", "none");
                    $('#course').css("display", "none");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");
                }
            });
        });

        function display_area_upload_error_data(data) {


            bootbox.alert("There are some problem in excel data please check and correct data");

            debugger;

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

            debugger;

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
       
       
                
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Upload Student Wise Course
            </h1>
        </div>
        <div class="row-fluid">
            <div class="span4">
                <div class="control-group">
                    <label class="control-label" for="drpupload">
                    </label>
                    <div class="controls">
                        <select id="drpselect">
                            <option value="">Select Upload</option>
                            <option value="student_wise_course_upload">Student Wise Course Upload</option>
                            <%--<option value="area_upload">Area upload</option>--%>
                            <%--<option value="user_upload">User upload</option>--%>
                            <%-- <option value="course_master">course master</option>--%>
                            <%--  <option value="department_master">Department master</option>--%>
                            <%-- <option value="instructer_master">instructer master</option>--%>
                        </select>
                    </div>
                    <div class="widget-box" id="student_wise_course" style="display: none;">
                        <p style="color:Red;padding-left:5px;"> * select both Drop Down List to proceed</p>
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
                        
                        <%--<button id="btn_student_wise_course" onclick="return student_course_upload()">Student Wise Course Upload</button>--%>

                        <div class="widget-box" id="div_student_wise_course_upload" style="display: none;">
                            <asp:FileUpload ID="student_wise_course_upload" runat="server"/>
                        </div>
                    </div>
                    <div class="widget-box" id="area" style="display: none">
                        <asp:FileUpload ID="area_upload" runat="server" />
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
</asp:Content>
