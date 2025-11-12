<%@ Page Title="Feedback Disable" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" 
    CodeFile="Feedback_disable.aspx.cs" Inherits="Admin_Master_Feedback_disable" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js"></script>
      <script src="../../Scripts/jquery.table2excel.min.js"></script>
    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>
        .cls_course_code {
        width:103px;
        }
        .cls_course_name {
        width:303px;
        }
        .cls_dept_name {
        width:200px;
        }
        .cls_prog_name {
        width:182px;
        }
        .cls_cancel_flag {
        width:87px;
        }
    </style>

    <script type="text/javascript">
        var oTable;
        var oTable1;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            bind_feedback_disable_type();

            $('#btnreterive').on('click', function () {
                feedback_disable_course_data();
                return false;
            });
            //return false;

            $("#feedback_disable_type").on('change', function () {
                if ($("#feedback_disable_type").val() == "") {
                    $("#div_upload_file").css("display", "none");
                    $("#btnExcelDownlaod").css("display", "none");
                    $("#disable_filter").css("display", "none");
                }
                else {
                    $("#div_upload_file").css("display", "block");
                    $("#btnExcelDownlaod").css("display", "block");
                    $("#disable_filter").css("display", "block");
                }
              
                if ($("#feedback_disable_type").val() == "FCD") {
                    $("#feedback_disable_course").css('display', 'block');
                    $("#feedback_disable_instuctor").css('display', 'none');
                }
                else {
                    $("#feedback_disable_course").css('display', 'none');
                    $("#feedback_disable_instuctor").css('display', 'block');
                }

            });

            

        });

        $(function () {
            $("#btnExcelDownlaod").click(function () {

                if ($("#feedback_disable_type").val() == "FCD") {
                    $("#tblfeedback_course_disable").table2excel({
                        exclude: ".xls",
                        filename: "Table.xls"
                    });
                }
                else {
                    $("#tblfeedback_instructor_disable").table2excel({
                        exclude: ".xls",
                        name: "Results",
                        filename: "Table.xls"
                    });
                }
            });
        });

        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }
                        $('#drpyear').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();
        }

        function bind_feedback_disable_type() {
            $('#feedback_disable_type').empty().append($("<option></option>").val("").html("-- Please Select Feedback Disable Type --"));
            $('#feedback_disable_type').append($("<option></option>").val("FCD").html("Feedback Course Disable"));
            $('#feedback_disable_type').append($("<option></option>").val("FID").html("Feedback Instructor Disable "));

            $('#feedback_disable_type').chosen();
        }

        function feedback_disable_course_data() {
            $('#DataList').css('display', 'none');

            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            var feedback_disable_type = $("#feedback_disable_type").val();
            if (feedback_disable_type == "") {
                bootbox.alert('Please select Feedback Disable Type');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_data_Feedback_disable_course",
                async: false,
                data: "{sem_code : '" + semester + "',year_code : '" + year_code + "',feedback_disable_type : '" + feedback_disable_type + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var dataa = JSON.parse(data["d"]);
                        if (dataa != "" && feedback_disable_type == "FCD") {
                            Display_Assigned_report(data.d);
                        }
                        else
                        {
                            Display_Assigned_report_for_instructor(data.d);
                        }
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function Display_Assigned_report(data) {
            $('#DataList').css('display', 'block');
            $('#DataList1').css('display', 'none');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                //"sDom": 't',
                //"sScrollY": '400px',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"oTableTools":
                //{
                //    "aButtons": [
                //        "copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "sClass": "cls_course_code" },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false, "sClass": "cls_course_name" },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false, "sClass": "cls_dept_name" },
                    { "sTitle": "Program Name", "mData": "prog_name", "bSortable": false, "sClass": "cls_prog_name" },
                    { "sTitle": "Cancel Flag", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_cancel_flag" },
                ]
            });
            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function Display_Assigned_report_for_instructor(data) {
            $('#DataList1').css('display', 'block');
            $('#DataList').css('display', 'none');

            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example1" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example1").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
               // "sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]

                //        }
                //    ]
                //},

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "sClass": "cls_course_code" },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false, "sClass": "cls_course_name" },
                    { "sTitle": "User Id", "mData": "user_id", "bSortable": false, "sClass": "cls_dept_name" },
                    { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false, "sClass": "cls_prog_name" },
                    { "sTitle": "Cancel Flag", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_cancel_flag" },
                ]
            });

            $('#DataList1').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';

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

        function Upload_feedback_disable(e) {
            try {
                var feedback_disable_type = $("#feedback_disable_type").val();
                if (feedback_disable_type == "") {
                    bootbox.alert('Please select Feedback Disable Type');
                    $('#reservation_upload_document').val('');
                    return false;
                }
                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                var ses_data = $('#hdn_session').val();
                //var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));
                
                if (CheckMarksDocumentExtension(fileToUpload)) {
                    //if (filename != "" && filename != null) {
                   //ses_data = ses_data.replace(/"/g, "'");
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/feedback_disable.ashx',
                        secureuri: false,
                        data: { "feedback_disable_type": feedback_disable_type },
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
                            //window.location.reload();
                            $('#reservation_upload_document').val('');
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
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="well" style="background-color:white">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Feedback Disable
            </h1>
        </div>
    </div>

    <div class="panel panel-default">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Filter Criteria</span></strong>
            </div>

            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div id="div_drpsem" class="form-group col-md-5">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Semester :
                        </div>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </div>
                    </div>
                    <div id="div_drpyear" class="form-group col-md-3" style="margin-left:-8%">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Year :
                        </div>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select col-md-12" id="drpyear">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top:10px">
                    <div id="div_questions" class="form-group col-md-5">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                             Feedback Disable Type :
                        </div>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="feedback_disable_type">
                            </select>
                        </div>
                    </div>
                    <div style="margin-left: 41%;" class="form-group col-md-12">
                        <button class="btn  btn-primary" type="button" id="btnreterive">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>
            </div>

            <div>
            <table id="tblfeedback_course_disable" cellspacing="0" cellpadding="0">
            <tr style="display:none">
                <th><b>Course_code</b></th>
                <th><b>Semester_Type</b></th>
                <th><b>Year_Semester</b></th>
                <th><b>Cancel_flag</b></th>
            </tr>
            </table>
        </div>

            <div>
            <table id="tblfeedback_instructor_disable" cellspacing="0" cellpadding="0">
            <tr style="display:none">
                <th><b>Course_code</b></th>
                <th><b>User_id</b></th>
                <th><b>Instructor_code</b></th>
                <th><b>Semester_Type</b></th>
                <th><b>Year_Semester</b></th>
                <th><b>Cancel_flag</b></th>
            </tr>
        </table>
        </div>
     </div>

    <div class="panel panel-default" id="disable_filter" style="display:none">
        <div class="row" style="margin-left:8px;margin-top:2px">
            <span>
                Step 1: Download Excel Format
            </span><br/>
            <span>
                Step 2: As Per Format Insert Date into Excel
            </span>
                <br/>
            <span>
                Step 3: Upload Excel To Save Data
            </span>
        </div>

        <div class="row" style="padding:7px">
                    <div id="div1" class="form-group col-md-5">
                        <a href="../../ExcelFormatFiles/FeedbackDisableCourse.xlsx" id="feedback_disable_course" style="display:none" download>Download Excel Format</a>
                        <a href="../../ExcelFormatFiles/FeedbackDisableInstructor.xlsx" id="feedback_disable_instuctor" style="display:none" download>Download Excel Format</a>
                        <input type="button"  value="Download Excel Format" style="display:none;margin-bottom:6px;" />
                    </div>
                    <div id="div_upload_file" class="form-group col-md-3" style="margin-left:-8%;display:none">
                        <div class="col-md-4" style="padding: 0 0 0 0;">
                            <span>Upload Excel : </span>
                        </div>
                        <div class="col-md-6" style="padding: 0 0 0 0;">
                             <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                                onchange="javascript:return Upload_feedback_disable(this);"  style="margin-left:2%;"/>
                        </div>
                    </div>
         </div>
    </div>    

    <div id="DataList" class="panel panel-default" style="display:none;margin-bottom:40px;">
            <div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
     </div>

    <div id="DataList1" class="panel panel-default" style="display:none;margin-bottom:40px;">
            <div>
                <table cellpadding="0" cellspacing="0" border="0" id="example1" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
     </div>

    </div>

     <input type="hidden" id="hdn_session" runat="server" clientidmode="Static" />
</asp:Content>