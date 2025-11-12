<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Studio_Brief_Details.aspx.cs" Inherits="Admin_Master_Studio_Brief_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../DesignCss/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/studio_brief_details.js?t=13032025" type="text/javascript"></script>
    <%--14062019--%><%--11122019--%><%--06052020--%><%--15062020--%><%--09072020--%>
    <script src="../../DesignJS/ckeditor2/ckeditor.js" type="text/javascript"></script>
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
           
            if ($("#hdn_utype").val() == 'CW')
            {
                $('#btnRetrieve').css('display', 'none');
               // $('#btnRetrieve1').css('display', 'block');//nitinbhai 
                $('#btnRetrieve1').css('display', 'none');
            }

            $('#btnRetrieve1').click(function () {
                if ($('#drpsemester').val() == '') {
                    bootbox.alert('Please select semester');
                    return false;
                }

                if ($('#drpyear').val() == '') {
                    bootbox.alert('Please select year');
                    return false;
                }

                if ($('#drcourses').val() == '') {
                    bootbox.alert('Please select course');
                    return false;
                }

                location.replace("frmcoursemaster.aspx?c=" + $('#drcourses').val() + "&s=" + $('#drpsemester').val() + "&y=" + $('#drpyear').val() + "");
            });
            //validation for course_code
            $('#txtcoursecode').keypress(function (e) {
                var regex = new RegExp("^[a-zA-Z0-9_-]+$");
                var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
                if (regex.test(str)) {
                    return true;
                }
                e.preventDefault();
                return false;
            });
            //DrawMe();
            if ($("#hdn_utype").val() == 'I2')
            {
                if ($('#hdn_studio_code').val() != '' && $('#prev_course_code').val() != '')
                {
                    $("#drpsemester").val($('#prev_sem_code').val());
                    $("#drpsemester").trigger("liszt:updated");
                    $("#drpyear").val($('#prev_year_code').val());
                    $("#drpyear").trigger("liszt:updated");
                    if ($('#drpyear').val() != '') {

                        if ($('#drpsemester').val() != '') {
                            bind_sem_course();
                        }

                    }
                    $("#drcourses").val($('#prev_course_code').val());
                    $("#drcourses").trigger("liszt:updated");
                    if ($("#drpsemester").val() != '' || $("#drpyear").val() != '' || $("#drcourses").val() != '') {
                        $('#btnRetrieve_new').click();
                    }
                }
            }
            

        });

        function addCourseAssessment() {
            var total_assessment = $('#tbl_course_assessment tbody tr').length;
            if (total_assessment < 20) {
                var str_html = '<tr class="tr_assessment">' +
                    '<td class="align-pad">Assessment ' + (total_assessment + 1) + '</td>' +
                    '<td><input type="text" class="cls_exercises" value="" /></td>' +
                    '<td><input type="text" class="cls_percentage" value="" onkeypress="return IsNumeric(event);" /></td>' +
                    '<td><input type="text" class="cls_criteria" value="" /></td><td><center><i class="icon-trash icon-2x text-blue" style="cursor:pointer;"></i></center></td></tr>';

                $('#tbl_course_assessment tbody').append(str_html);
            }
        }

        function addCourseImage() {
            var total_image = $('#tbl_course_image tbody tr').length;
            if (total_image < 7) {
                var str_html = '<tr><td class="align-pad">Course Image ' + (total_image + 1) + ' &nbsp;&nbsp;:&nbsp;&nbsp;</td>' +
                    '<td style="padding-top: 6px;padding-bottom: 0px;"><label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;"><span><strong>Upload Image</strong></span>' +
                    '<input type="file" name="courseImageUpload' + (total_image + 1) + '" id="courseImageUpload' + (total_image + 1) + '" class="cls_course_image" onchange="javascript:return UploadCourseImage(' + (total_image + 1) + ',\'validate\',\'\');" style="display: none;" />' +
                    '</label></td><td class="align-pad" style="width:260px;"><span id="lbl_courseimage_file_name' + (total_image + 1) + '" style="vertical-align: super;"></span></td><td class="align-pad">Course Label ' + (total_image + 1) + '</td>' +
                    '<td><input type="text" id="txt_image_caption' + (total_image + 1) + '" class="cls_image_caption" value="" /></td></tr>';

                $('#tbl_course_image tbody').append(str_html);
            }
        }

        var FileName = '';
        var obj_FileName = {};
        var inst = '';
        function UploadCourseImage(id, action, image_name) {
            try {
                if ($('#courseImageUpload' + id).val() != '') {
                    var fileToUpload = GetFileNameFromPath($('#courseImageUpload' + id).val());
                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));
                    //var course_code = $('#txtcoursecode').val() + '_';
                    var course_code = '';

                    if (CheckUserPhotoExtension(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../../Handler/CourseImage_upload.ashx',
                                    secureuri: false,
                                    fileElementId: 'courseImageUpload' + id,
                                    dataType: 'json',
                                    data: { action: action, image_name: image_name },
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                                $('#courseImageUpload' + id).val("");
                                            }
                                            else {
                                                //$('#courseImageUpload' + id).val("");
                                                $('#lbl_courseimage_file_name' + id).html('<b>' + fileToUpload + '</b>');

                                                //FileName = data.upfile;
                                                //obj_FileName['lbl_portfolioimage_file_name' + id] = data.upfile;

                                                //$('#img_course_image' + id).attr('src', '../../WSCourseImageUpload/' + FileName + '?' + (new Date()).getTime());
                                            }
                                        }
                                        $("#UploadingProgress").fadeOut(200);
                                    },
                                    error: function (data, status, e) {
                                        $("#UploadingProgress").fadeOut(200);
                                        $('#courseImageUpload' + id).val("");
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
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function GetFileNameFromPath(strFilepath) {
            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) { return null; }
            else { return strName[0]; }
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
        function CheckUserPhotoExtension_(file) {
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

        function Uploadweekimagpdf(id) {
            debugger;
            try {
                if ($('#week_img_pdf_' + id).val() != '') {
                    var fileToUpload = GetFileNameFromPath($('#week_img_pdf_' + id).val());
                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));
                    var course_code = $('#txtcoursecode').val() + '_' + $('#hdn_s').val().trim() + $('#hdn_y').val().trim() + '_' +'week'+ id;
                    //var course_code = '';

                    if (CheckUserPhotoExtension_(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../../Handler/Exercises_Upload.ashx',
                                    secureuri: false,
                                    fileElementId: 'week_img_pdf_' + id,
                                    dataType: 'json',
                                    data: { 'CourseCode': course_code},
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                                $('#week_img_pdf_' + id).val("");
                                                $('#lbl_week_img_name_' + id).val("");
                                            }
                                            else {
                                                //$('#courseImageUpload' + id).val("");
                                                $('#lbl_week_img_name_' + id).html('<b>Week' + id + '</b>');
                                                $('#lbl_week_img_' + id).html('<b>' + data.upfile + '</b>');
                                            }
                                        }
                                        $("#UploadingProgress").fadeOut(200);
                                    },
                                    error: function (data, status, e) {
                                        $("#UploadingProgress").fadeOut(200);
                                        $('#week_img_pdf_' + id).val("");
                                        alert(e);
                                    }
                                });
                            }
                        }
                    }
                    else {
                        alert('Invalid File Type. Please upload jpeg / png/ pdf file');
                    }
                    return false;
                }
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }


        //function DrawMe() {
        //    var c = document.getElementById("mycanvas");
        //    var ctx = c.getContext("2d");
        //    ctx.moveTo(10, 10);
        //    ctx.lineTo(200, 100);
        //    ctx.stroke();
        //}

       
    </script>
    <style type="text/css">
        .txtvalue {
            width: 27.5%;
            height: 39px !important;
        }

        #cke_txt_reference {
            width: width: 773px;
        }

        .marg-btm {
            margin-bottom: 0px;
        }

        .pad-top {
            padding-top: 0px;
        }

        .txtwidth {
           width: 30%;
            /*width: 23%;*/
        }

        .divweek {
            padding-right: 0px;
            margin-right: -20px;
        }

        .color-blue {
            color: Black;
        }

        .outline_css {
            padding-right: 0px;
        }

        #tblinstructor th, #tblinstructor td, #tblinstructor_tutorial th, #tblinstructor_tutorial td {
            padding-left: 5px;
            padding-right: 5px;
        }

        #tbltimeday th, #tbltimeday td, #tbltimeday_tutorial th, #tbltimeday_tutorial td {
            padding-left: 5px;
            padding-right: 5px;
        }

        .cls_view_room, .cls_view_room_tutorial {
            padding-left: 3px;
        }

        .align-pad {
            vertical-align: middle !important;
            padding: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Studio Brief Details
            </h1>
        </div>
    </div>
    <div class="" style="background-color: White;">
        <div id="course_select" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Selection</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div id="div_drpsem" class="form-group col-md-4">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Semester :
                        </div>
                        <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </div>
                    </div>
                    <div id="div_drpyear" class="form-group col-md-3">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Year :
                        </div>
                        <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-8" style="padding: 0 0 0 0;">
                            <select class="chosen-select col-md-12" id="drpyear">
                            </select>
                        </div>
                    </div>
                    <div id="div_drpcourse" class="form-group col-md-3">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Course :
                        </div>
                        <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drcourses">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div style="margin-left: 41%;" class="form-group col-md-12">
                        <%--<button class="btn  btn-primary" type="button" id="btnRetrieve_new">--%>
                        <button class="btn  btn-primary" type="button" id="btnRetrieve_new" style="display: none;">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                        <button class="btn  btn-primary" type="button" id="btnRetrieve1" style="display: none;">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                        <button class="btn  btn-primary" type="button" id="btnRetrieve" style="display: none;">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="div_facultynote" style="margin-top: -12px; margin-bottom: 12px; font-size: 14px; display: none;">
            <%--<span class="label-yellow" style="padding: 5px;">Please note, that you are required to fill only fields with <b style="color: #6FB9E1;">Blue</b> titles</span>--%>
            <span class="label-yellow" style="padding: 5px;">Please note, Kindly Fill all the Editable Fields</span>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Data &nbsp;( Program Coordinator Panel )</span></strong>
            </div>
            <div style="padding: 10px; overflow: visible;" id="div_progcoord_panel" class="panel-collapse collapse in">
                <div>
                    <table style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr id="div_txtcoursecode">
                        </tr>
                        <tr>
                            <td class="pad-top" style="vertical-align: middle;">Course Code<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <input type="text" id="txtcoursecode" class="marg-btm" />
                            </td>
                            <td class="pad-top" style="vertical-align: middle;">Course Name<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <input type="text" id="txtcoursename" class="marg-btm" />
                            </td>
                            <%--<td class="pad-top">
                                Intake Capacity
                            </td>
                            <td>
                                <input type="text" id="txtavailable_seats" class="marg-btm"/>
                            </td>--%>
                            <td class="pad-top" style="vertical-align: middle;">Credits<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <input type="text" id="txtcredits" class="marg-btm" />
                            </td>
                        </tr>
                        <%--<tr>
                            <%--  <td>
                        <input type="text" id="txtcoursecode" />
                     
                    </td>--
                            <td>
                                <input type="text" id="txtcoursename" />
                            </td>
                            <td>
                                <input type="text" id="txtavailable_seats" />
                            </td>
                            <td>
                                <input type="text" id="txtcredits" />
                            </td>
                            
                        </tr>--%>
                        <tr>
                            <td>Faculty<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                            <td style="vertical-align: top;">Elective/ Mandatory<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <select class="chosen-select" id="drptype">
                                </select>
                            </td>
                            <td style="vertical-align: top;">Intake Capacity<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <input type="text" id="txtavailable_seats" class="marg-btm" />
                            </td>
                        </tr>
                        <%--<tr>
                            <td style="padding-top: 0">
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                            <td style="padding-top: 0">
                                <select class="chosen-select" id="drptype">
                                </select>
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel">
                                </select>
                            </td>
                        </tr>--%>
                        <tr>
                            <td style="vertical-align: top;">Course Semester<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <select class="chosen-select" id="drp_semester">
                                </select>
                            </td>
                            <td style="vertical-align: top;">Program Level<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                            <td style="vertical-align: top;">
                                <span id="spn_proglvl">Program Type<span class="cls_mendatory" style="display: none; color: Red;">*</span></span>
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel">
                                </select>
                            </td>
                        </tr>
                        <%--<tr>
                            <td style="padding-top: 0">
                                <select class="chosen-select" id="drp_semester">
                                </select>
                            </td>
                            <td style="padding-top: 0">
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                            <td style="padding-top: 0">
                                <select class="chosen-select" id="drptypology">
                                </select>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>Specialization<%--<span class="cls_mendatory" style="display: none; color: Red;">*</span>--%>
                            </td>
                            <td>
                                <select class="chosen-select" id="drp_color">
                                </select>
                            </td>
                            <td id="spn_project" style="display: none;">
                                <span>Project</span><span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td style="padding-top: 0;">
                                <select class="chosen-select" id="drpproject" style="display: none;">
                                    <option value="">--- Please Select Project ---</option>
                                    <option value="N">No</option>
                                    <option value="Y">Yes</option>
                                </select>
                            </td>
                            <td id="spn_project_name" style="vertical-align: middle; padding-top: 0; display: none;">
                                <span>Project Name</span><span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td style="padding-top: 0;">
                                <input type="text" id="txt_project_name" class="marg-btm" style="display: none;" />
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td>Room Id<%--<span class="cls_mendatory" style="display: none; color: Red;">*</span>--%>
                            </td>
                            <td>
                                <input type="text" id="txtroomid" class="marg-btm" />
                            </td>
                        </tr>
                        <tr id="div_tutorial_offered">
                            <td style="vertical-align: top; padding-right: 0px;">Typology Group
                            </td>
                            <td>
                                <select class="chosen-select" id="drp_typology_group">
                                    <option value="">-- Select Typology Group --</option>
                                    <%--<option value="old">Old Typology</option>
                                    <option value="new">New Typology</option>--%>

                                    <%--<option value="G001">Old Typology</option>
                                    <option value="G002">New Typology</option>
                                    <option value="G003">UG Typology</option>--%>
                                </select>
                            </td>

                            <td style="vertical-align: top; padding-right: 0px;">Course Typology<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td>
                                <select class="chosen-select" id="drptypology">
                                </select>
                            </td>
                            <td style="vertical-align: top; padding-right: 0px; display: none" id="typ_sub_group">Course Sub Category 
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsubtypology" style="display: none;">
                                    <option value="">-- Please Select --</option>
                                </select>
                            </td>
                        </tr>
                        <%--<tr class="cls_focus_studio" style="display: none;">
                            <td style="font-size: 16px;">Focus of Studio<span class="cls_focus_studio" style="display: none; color: Red;">*</span>
                            </td>
                        </tr>
                        <tr class="cls_focus_studio_options" style="display: none;">
                        </tr>--%>
                        <tr>
                            <td class="cls_tutorial_offered" style="display: none;">Tutorial Offered
                            </td>
                            <td class="cls_tutorial_offered" style="display: none;">
                                <input type="radio" name="rdo_tutorial_offered" value="Y" onclick="rdo_tutorial_click()" />&nbsp;Yes&nbsp;&nbsp;
                                <input type="radio" name="rdo_tutorial_offered" value="N" onclick="rdo_tutorial_click()" checked="checked" />&nbsp;No
                            </td>

                            <td class="" style="vertical-align: top; padding-right: 0px;">Add Student Preparatory/Self Study hr/week : <span class="cls_mendatory" style="color: Red;">*</span>
                            </td>
                            <td class="" style="">
                                <input type="text" id="txt_prep_self_hrs" class="marg-btm txtwidth" onkeypress='return IsNumeric(event);' />
                            </td>

                            <td class="gpa_nongpa" style="vertical-align: top; padding-right: 0px;">GPA/Non-GPA<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            </td>
                            <td class="gpa_nongpa" style="display: block;">
                                <select class="chosen-select" id="drp_gpa_ngpa">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            

                            <td class="cls_backlog">Backlog
                            </td>
                            <td class="cls_backlog"><%--Mayur 25042019--%>
                                <input type="radio" name="rdo_backlog" value="Y" />&nbsp;Yes&nbsp;&nbsp;
                                <input type="radio" name="rdo_backlog" value="N" checked="checked" />&nbsp;No
                            </td>
                            
                        </tr>
                    </table>

                    
                    <div class="row">
                       
                    </div>
                    
                </div>

               <%-- <div style="display: block; width: 100%;">
                    <div class="row-fluid" id="dataList_instructor" style="margin-top: 50px; float: left; width: 30%; display: block;">
                        <div class="box-content box-no-padding">
                            <button class="btn  btn-primary" type="button" id="btn_instructor">
                                <i class="icon-plus"></i>&nbsp;Add Instructor
                            </button>
                        </div>
                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor" style="width: 168% !important">
                            <thead>
                                <tr>
                                    <th>Instructor
                                    </th>
                                    <th style="width: 13%;">Unit
                                        <select style="width: 100%; display: none;" id="drp_contact_hrs">
                                           
                                            <option value="">--</option>
                                            <option value="HW">Hrs/Week</option>
                                            <option value="HS">Hrs/Semester</option>
                                        </select>
                                    </th>
                                    <th>Contact Hrs (including Tutorial hrs)</th>
                                    <th>Weeks</th>
                                    <th style="width: 18%;">Tutor
                                    <select style="width: 100%; display: none;" id="cls_drp_tutor">
                                        <option value="">--</option>
                                        <option value="T">Lead Tutor</option>
                                        <option value="CT">Co Tutor</option>
                                    </select>
                                    </th>
                                    <th>Delete</th>
                                    <th>Details</th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div class="row-fluid" id="datalist_timeday" style="margin-top: 50px; margin-left: 23%; float: left; margin-bottom: 12px; width: 37%; display: block;">
                        <div class="box-content box-no-padding">
                            <button class="btn  btn-primary" type="button" id="btn_time">
                                <i class="icon-plus"></i>&nbsp;Add Time and Day
                            </button>
                            <span id="spn_totalhour">Total Hours : 0 hr/week</span>
                        </div>
                        <table class="data-table table table-bordered table-striped" border="0" id="tbltimeday" style="width: 113%;">
                            <thead>
                                <tr>
                                    <th>From Time</th>
                                    <th>To Time</th>
                                    <th>Day</th>
                                    <th>RoomId</th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div class="row-fluid" id="datalist_area" style="margin-top: 50px; margin-left: 6%; float: left; width: 26%;">
                        <div style="display: none;">
                            <div class="box-content box-no-padding">
                                <button class="btn  btn-primary" type="button" id="btn_area">
                                    <i class="icon-plus"></i>&nbsp;Add Area
                                </button>
                            </div>
                            <table class="data-table table table-bordered table-striped" border="0" id="tblarea">
                                <thead>
                                    <tr>
                                        <th>Area
                                        </th>
                                    </tr>
                                    <tr>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                       
                    </div>

                    <div style="margin-left: 64%; margin-bottom: 12px;">
                        <div class="row">
                           
                        </div>
                    </div>

                    <div class="panel panel-default ">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Tutorial</span></strong>
                        </div>

                        <div style="padding: 15px;">
                            <div class="row-fluid" id="dataList_instructor_tutorial" style="float: left; width: 31%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" id="btn_instructor_tutorial">
                                        <i class="icon-plus"></i>&nbsp;Add Instructor
                                    </button>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_tutorial">
                                    <thead>
                                        <tr>
                                            <th>Instructor
                                            </th>
                                            <th>Contact Hrs
                                                <select style="width: 100%; display: none;" id="drp_contact_hrs_tutorial">
                                                   
                                                    <option value="">--</option>
                                                    <option value="HW">Hrs/Week</option>
                                                    <option value="HS">Hrs/Semester</option>
                                                </select>
                                            </th>
                                            <th></th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row-fluid" id="datalist_timeday_tutorial" style="margin-left: 1%; float: left; margin-bottom: 12px; width: 36%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" id="btn_time_tutorial">
                                        <i class="icon-plus"></i>&nbsp;Add Time and Day
                                    </button>
                                    <span id="spn_totalhour_tutorial">Total Hours : 0 hr/week</span>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tbltimeday_tutorial" style="width: 118%;">
                                    <thead>
                                        <tr>
                                            <th>From Time</th>
                                            <th>To Time</th>
                                            <th>Day</th>
                                            <th>RoomId</th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div style="margin-left: 64%; margin-bottom: 12px;">
                            <div class="row"></div>
                        </div>
                    </div>

                    <div class="panel panel-default ">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Add AA / TA</span></strong>
                        </div>

                        <div style="padding: 15px;">
                            <div class="row-fluid" id="dataList_instructor_aa" style="float: left; width: 31%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" id="btn_instructor_aa">
                                        <i class="icon-plus"></i>&nbsp;Add AA
                                    </button>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_aa">
                                    <thead>
                                        <tr>
                                            <th>Instructor
                                            </th>
                                            <th></th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>

                            <div class="row-fluid" id="dataList_instructor_ta" style="margin-left: 1%; float: left; margin-bottom: 12px; width: 36%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" id="btn_instructor_ta">
                                        <i class="icon-plus"></i>&nbsp;Add TA
                                    </button>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_ta">
                                    <thead>
                                        <tr>
                                            <th>Instructor
                                            </th>
                                            <th></th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div style="margin-left: 64%; margin-bottom: 12px;">
                            <div class="row"></div>
                        </div>
                    </div>

                    <div style="margin-top: -10px;">* Your choice of room(s) has been saved. However, note that the room(s) will be allocated only after you submit the course details.</div>
                </div>--%>
            </div>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Data &nbsp;( Instructor Panel )</span></strong>
            </div>
             <div style="padding: 10px;" id="div_instructor_details_add" class="panel-collapse collapse in">
                 
                  <div class="panel panel-default ">
                       <div class="panel-body">
                           <table class="cls_focus_studio" style="display: none;">
                               <tbody>
                                   <tr >
                            <td style="font-size: 16px;">Focus of Studio<span class="cls_focus_studio" style="display: none; color: Red;">*</span>
                            </td>
                        </tr>
                        <tr class="cls_focus_studio_options" style="display: none;">
                        </tr>
                               </tbody>
                           </table>

                          </br>
                           <span style="display:block;"><b>No Of Tutor :  </b> 
                               <select id="no_of_tutor" disabled="true">
                                    <option value="">-- Please Select Tutor --</option>
                                    <option value="Single">Single</option>
                                    <option value="Dual">Dual</option>
                                    <option value="Multiple">Multiple</option>
                                </select>
                              <%-- <br><span id="no_of_tutor_bind" style="color:red;"></span>--%>
                               <span>TBD : To Be Decided </span>
                           </span>
                       <p id="single_show" style="color:blue; display:block !important;"><span style="color:red">Note 1 :</span> Contact Hours for Single tutor Studio: Contact hours- 288 (15hr/week for 12 week & 18hr/week for 6 weeks) and 94 preparatory hours.Total hours are 382.</p>
                        <p id="dual_show" style="color:blue; display:block !important;"><span style="color:red">Note 1 :</span> Contact Hours for Dual tutor Studio: . Contact hours-180 (9 hr/week for 12 week & 12 hr./week for 6 weeks) and 47 preparatory hours. Total hours are 227.</p>
                  </br>
                   <%--<div class="row-fluid" id="datalist_timeday" style="margin-top: 50px; margin-left: 23%; float: left; margin-bottom: 12px; width: 37%; display: block;">--%>
                   <div class="row-fluid" id="datalist_timeday" style="margin-bottom: 12px; width: 62%; display: block;">
                        <div class="box-content box-no-padding">
                            <button class="btn  btn-primary" type="button" id="btn_time" disabled="disabled">
                                <i class="icon-plus"></i>&nbsp;Add Time and Day
                            </button>
                            <span id="spn_totalhour">Total Hours : 0 hr/week</span>
                        </div>
                      <%--  <table class="data-table table table-bordered table-striped" border="0" id="tbltimeday" style="width: 113%;">--%>
                         <table class="data-table table table-bordered table-striped" border="0" id="tbltimeday">
                            <thead>
                                <tr>
                                    <th>From Time</th>
                                    <th>To Time</th>
                                    <th>Day</th>
                                    <th>RoomId</th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                       <p style="color:red;display:block;" id="studio_text"><b>Note: Please ensure that your modify the instructor time slot.(Approximately)</b></p>
                    </div>
                   
                    <div class="row-fluid" id="dataList_instructor" style="margin-top: 50px; float: left; width: 30%; display: block;">
                        <div class="box-content box-no-padding">
                            <button class="btn  btn-primary" type="button" id="btn_instructor">
                                <i class="icon-plus"></i>&nbsp;Add Instructor
                            </button>
                        </div>
                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor" style="width: 331% !important">
                            <thead>
                                <tr>
                                    <th>Instructor
                                    </th>
                                    <th style="width: 13%;">Unit
                                        <select style="width: 100%; display: none;" id="drp_contact_hrs">
                                           
                                            <option value="">--</option>
                                            <option value="HW">Hrs/Week</option>
                                            <option value="HS">Hrs/Semester</option>
                                        </select>
                                    </th>
                                    <th>Average Contact hours</th>
                                    <th>Total Weeks
                                    </th>
                                    <th>Total Contact Hrs</th>
                                    <th>Additional Hours</th>
                                    <th>Total Hrs</th>
                                    <th style="width: 18%;">Tutor
                                    <select style="width: 100%; display: none;" id="cls_drp_tutor">
                                        <option value="">--</option>
                                        <option value="T">Lead Tutor</option>
                                        <option value="CT">Co Tutor</option>
                                    </select>
                                    </th>
                                     <th>Highest Qualification</th>
                                    <th>Total EXP.</th>
                                    <th>RateBand</th>
                                    <th>Delete</th>
                                    <th>Details</th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                         <div class="row" style="margin-left: 2%; color:red;width: 114%;">
                         <b><span id="dynamic_text"></span></b>
                        </div>

                    </div>        
                           
                        <div class="row-fluid" id="datalist_area" style="margin-top: 50px; margin-left: 6%; float: left; width: 26%;">
                        <div style="display: none;">
                            <div class="box-content box-no-padding">
                                <button class="btn  btn-primary" type="button" id="btn_area">
                                    <i class="icon-plus"></i>&nbsp;Add Area
                                </button>
                            </div>
                            <table class="data-table table table-bordered table-striped" border="0" id="tblarea">
                                <thead>
                                    <tr>
                                        <th>Area
                                        </th>
                                    </tr>
                                    <tr>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                       
                    </div>

                    <div style="margin-left: 64%; margin-bottom: 12px;">
                        <div class="row">
                           
                        </div>
                    </div>

                    <div class="panel panel-default ">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Tutorial</span></strong>
                        </div>

                        <div style="padding: 15px;">
                            <div class="row-fluid" id="dataList_instructor_tutorial" style="float: left; width: 31%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" id="btn_instructor_tutorial" style="display:none">
                                        <i class="icon-plus"></i>&nbsp;Add Instructor
                                    </button>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_tutorial">
                                    <thead>
                                        <tr>
                                            <th>Instructor
                                            </th>
                                            <th>Contact Hrs
                                                <select style="width: 100%; display: none;" id="drp_contact_hrs_tutorial">
                                                   
                                                    <option value="">--</option>
                                                    <option value="HW">Hrs/Week</option>
                                                    <option value="HS">Hrs/Semester</option>
                                                </select>
                                            </th>
                                            <th></th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <div class="row-fluid" id="datalist_timeday_tutorial" style="margin-left: 1%; float: left; margin-bottom: 12px; width: 36%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" id="btn_time_tutorial" style="display:none">
                                        <i class="icon-plus"></i>&nbsp;Add Time and Day
                                    </button>
                                    <span id="spn_totalhour_tutorial">Total Hours : 0 hr/week</span>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tbltimeday_tutorial" style="width: 118%;">
                                    <thead>
                                        <tr>
                                            <th>From Time</th>
                                            <th>To Time</th>
                                            <th>Day</th>
                                            <th>RoomId</th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div style="margin-left: 64%; margin-bottom: 12px;">
                            <div class="row"></div>
                        </div>
                    </div>

                    <div class="panel panel-default ">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Add AA / TA</span></strong>
                        </div>

                        <div style="padding: 15px;">
                            <div class="row-fluid" id="dataList_instructor_aa" style="float: left;margin-bottom: 20px; width: 100%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" style="display:none" id="btn_instructor_aa" disabled>
                                        <i class="icon-plus"></i>&nbsp;Add AA
                                    </button>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_aa">
                                    <thead>
                                        <tr>
                                          <th>Instructor
                                            </th>
                                            <th>Average Contact hours</th>
                                            <th>Total Weeks</th>
                                            <th>Total Contact Hrs</th>
                                            <th>Additional Hours</th>
                                            <th>Total Hrs</th>
                                            <th>Highest Qualification</th>
                                            <th>Total EXP.</th>
                                            <th>RateBand</th>
                                            <th></th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>

                            <div class="row-fluid" id="dataList_instructor_ta" style="margin-bottom: 20px; width: 100%;">
                                <div class="box-content box-no-padding">
                                    <button class="btn btn-primary" type="button" id="btn_instructor_ta" disabled="disabled" style="display:none">
                                        <i class="icon-plus"></i>&nbsp;Add TA
                                    </button>
                                </div>
                                <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_ta">
                                    <thead>
                                        <tr>
                                            <th>Instructor
                                            </th>
                                            <th>Average Contact hours</th>
                                            <th>Total Weeks</th>
                                            <th>Total Contact Hrs</th>
                                            <th>Additional Hours</th>
                                            <th>Total Hrs</th>
                                             <th>Highest Qualification</th>
                                            <th>Total EXP.</th>
                                            <th>RateBand</th>
                                            <th></th>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div style="margin-left: 64%; margin-bottom: 12px;">
                            <div class="row"></div>
                        </div>
                    </div>

                    <div style="margin-top: -10px;">* Your choice of room(s) has been saved. However, note that the room(s) will be allocated only after you submit the course details.</div>
                </div>
                 </div>
            </div>



            <div style="padding: 10px;" id="div_instructor_panel" class="panel-collapse collapse in">
                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <b>Course Detail</b>
                    </div>
                    <div class="panel-body">
                        <%--<div class="row" style="margin-top: 15px;">
                            <div class="form-group col-md-2 color-blue">
                                Intake Capacity<span class="cls_mendatory cls_mendatory_instructor" style="display: none;color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <input type="text" id="txtavailable_seats" class="marg-btm" />
                            </div>
                        </div>--%>
                        <%--//new changes 03082022--%>

                          <div class="panel panel-default ">
                    <div class="panel-heading">
                        
                        <b>Instructor Hours</b>
                    </div>
                    <div class="panel-body">
                        <div id="studio_panel_showing" style="display:block;">
                         <b><sapn style="color:red;">Note 3 :</sapn> Please enter your specific contact hours per week in the studio windows below (As identified in the timetable) </b>
                        <p style="color:blue;">1. Contact Hours for Single tutor Studio: Contact hours- 288 (15hr/week for 12 week & 18hr/week for 6 weeks) and 94 preparatory hours.Total hours are 382.</p>
                        <p style="color:blue;">2. Contact Hours for Dual tutor Studio: . Contact hours-180 (9 hr/week for 12 week & 12 hr./week for 6 weeks) and 47 preparatory hours. Total hours are 227.</p>
                        <br />
                        </div>
                         <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_time_slot" >
                            <thead>
                                <tr>
                                    <th>Instructor</th>
                                    <th>From Time</th>
                                    <th>To Time</th>
                                    <th>Day</th>
                                    <th>Room</th>
                                    <th>Add</th>
                                    <th>Delete</th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody id="tbody_tblinstructor_time_slot">
                            </tbody>
                        </table>
                    </div>
                    </div>

                        <div class="row" style="margin-top: 15px;">
                            <%--<div><span id="spn_desc">total char : 0</span></div>--%>

                            <div class="form-group col-md-2 color-blue cls_studio_mode" style="display: none; vertical-align: top; padding-right: 0px;">
                                <span>Mode of Studio</span><span class="cls_mendatory" style="color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9 cls_studio_mode" style="display: none;">
                                <select class="chosen-select" id="studio_mode" style="margin-left: 2%;">
                                    <option value="">- Please Select Studio Mode -</option>
                                    <option value="Online">Online</option>
                                    <option value="Partial On-Campus">Partial On-Campus</option>
                                    <option value="Full On-Campus">Full On-Campus</option>
                                    <option value="Blended">Blended</option>
                                    <option value="Hybrid">Hybrid</option>
                                </select>
                            </div>


                            <div class="form-group col-md-2 color-blue">
                                Studio SubTitle: <br />
                                (Max 100 words with space)<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>

                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_studiosubtitle" style="width: 100%; margin-bottom: 0px;" rows="3"
                                    cols="50" name="address" maxlength="900"></textarea>
                                <span style="float: right;"><span id="word_desc1" style=" margin-bottom: 10px;">Total Word : 0</span> &nbsp;&nbsp;  <span id="spn_desc1" style="margin-bottom: 10px;">total char : 0</span></span>
                            </div>
                            <br />
                            <br /><br />



                            <div class="form-group col-md-2 color-blue">
                                Brief Introduction:  <%--Course Introduction--%>
                                <br /><%--(Min 1100- Max 1300 characters with space)--%>
                                (Max 200 words with space)<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                                <span style="color: red;">(Goes into the Course Catalog)</span>
                            </div>

                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_description" style="width: 100%; margin-bottom: 0px;" rows="6"
                                    cols="50" name="address" maxlength="1380"></textarea><%--onkeypress="return charcount(event)"onkeydown="return keydown_removechar(event)"--%>
                                <span style="float: right;"><span id="word_desc" style=" margin-bottom: 10px;">Total Word : 0</span> &nbsp;&nbsp;  <span id="spn_desc" style="margin-bottom: 10px;">total char : 0</span></span>
                            </div>

                            <div class="form-group col-md-2 color-blue l2l3 l2l3l4">
                                Long Description
                                <br />
                                (Min 1100- Max 3000 characters with space) or (Approximately Min 220 - Max 600 Words with space)<%--Course Description--%><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                                <%--<p style="color: Red;">(Please insert NA for L2-L3 studios) NA-Not Applicable</p>--%>
                                <span style="color: red;">(Description as seen by students)</span>
                            </div>
                            <div class="form-group col-md-9 l2l3 l2l3l4">
                                <textarea id="txtcourse_outline" style="width: 100%" rows="6" cols="50" name="address"></textarea>
                               <span style="float: right;"> <span id="spn_long_word" style="margin-bottom: 10px;">Total Word : 0</span> &nbsp;&nbsp; <span id="spn_long_desc" style="margin-bottom: 10px;">Total Char : 0</span></span>
                            </div>

                            <div class="form-group col-md-2 color-blue">
                                Course Expense:
                                <br />
                                (extra expenditure a student would incur during the semester)<%--(Max. 170 to 200 words)--%><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <input type="text" id="txt_course_expense" class="marg-btm" />
                            </div>
                            <br />

                        </div>
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Course Prerequisite<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div id="div_chk_prerequisite" class="form-group col-md-9">
                                <div class="row">
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre1" />&nbsp;None
                                    </div>
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre2" />&nbsp;Completed 3rd year FA
                                    </div>
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre3" />&nbsp;Completed 3rd year FD
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre4" />&nbsp;Completed 3rd year FP
                                    </div>
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre5" />&nbsp;Completed 3rd year FT
                                    </div>
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre6" />&nbsp;Completed UG Architecture
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre7" />&nbsp;Completed UG Planning
                                    </div>
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre8" />&nbsp;Completed UG Design
                                    </div>
                                    <div class="form-group col-md-5 outline_css">
                                        <input type="checkbox" id="chk_pre9" />&nbsp;Completed UG Technology/ Engineering
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-3 outline_css">
                                        <input type="checkbox" id="chk_pre10" />&nbsp;Any Other
                                    </div>
                                </div>
                                <br />
                                <textarea id="txtcourse_prerequisite" style="width: 100%; display: none;" rows="6"
                                    cols="50" name="address"></textarea>
                                <div class="row">
                                    <div class="form-group col-md-5 outline_css">
                                        <input type="checkbox" id="chk_pre11" />&nbsp;Successful completion of course required
                                    </div>
                                    <div id="divPreCourseCode" class="form-group col-md-3 outline_css">
                                        <select class="chosen-select" id="drpallprecourse">
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style="display:none;">
                        <div class="row studioprobstmnt" style="margin-top: 15px;">
                            <%--<div><span id="spn_desc">total char : 0</span></div>--%>
                            <div class="form-group col-md-2 color-blue">
                                Problem Statement:
                                <br />
                                (Min 200 to Max 400 characters with space) <span class="l2l3_hide" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="problem_statement" style="width: 100%; margin-bottom: 0px;" rows="6"
                                    cols="50" name="address"></textarea>
                                <span id="spn_ps" style="float: right; margin-bottom: 10px;">Total Char : 0</span>
                            </div>
                        </div></div>
                    </div>
                </div>

                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <b>Learning Outcomes</b>
                    </div>
                    <div class="panel-body">
                        <b> After completing this studio, the students will be able to:</b>
                        <%--<a href="../../StudioDetails/Mode-of-Teaching-v3.pdf" download="#" style="color:blue;font-size:12px;">(Refer docs)</a>--%>
                        <br />
                        <br />
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Course Outcome 1<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_outcome1" style="width: 100%" rows="2" cols="50" name="txtcourse_outcome1"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Course Outcome 2
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_outcome2" style="width: 100%" rows="2" cols="50" name="txtcourse_outcome1"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Course Outcome 3
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_outcome3" style="width: 100%" rows="2" cols="50" name="txtcourse_outcome1"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Course Outcome 4
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_outcome4" style="width: 100%" rows="2" cols="50" name="txtcourse_outcome1"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Course Outcome 5
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_outcome5" style="width: 100%" rows="2" cols="50" name="txtcourse_outcome1"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <b>Detailed Course Outline</b>
                    </div>
                    <div class="panel-body">
                        <%--<div class="row">
                            <div class="form-group col-md-2 color-blue l2l3">
                                Course Description<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                                <%--<p style="color: Red;">(Please insert NA for L2-L3 studios) NA-Not Applicable</p>
                            </div>
                            <div class="form-group col-md-9 l2l3">
                                <textarea id="txtcourse_outline" style="width: 100%" rows="6" cols="50" name="address"></textarea>
                            </div>
                        </div>--%>
                        <div class="row" style="margin-bottom: 15px; margin-top: 15px;">
                            <div class="form-group col-md-10">
                                <input type="radio" name="rdo_outline" value="consolidated" class="l2l3_studio_hide" />
                                <span style="vertical-align: bottom;" class="l2l3_studio_hide">Consolidated Outline <%--<span style="color:red;font-size:11px;">(Not Applicable for L2-L3 studios)</span>--%></span> &nbsp;
                                <input type="radio" name="rdo_outline" value="weekly" />
                                <span style="vertical-align: bottom;">Weekly Plan</span> &nbsp; <span id="spn_chkbox">
                                    <input type="checkbox" id="chk_week_ref" value="chk_week_ref" checked disabled />
                                    <span style="vertical-align: bottom;">Session Wise Reference</span> &nbsp;
                                    <input type="checkbox" id="chk_week_assign" value="chk_week_assign" style="display: none;" />
                                    <span style="vertical-align: bottom; display: none;">Session Wise Assignment</span>
                                    &nbsp; </span>
                            </div>
                        </div>
                        <div id="div_weekly_plan" style="display: none;">
                            <div class="row" style="margin-bottom: 10px; margin-top: 10px;">
                                <div class="form-group col-md-10">
                                    <b>Weekly Plan (Please fill in the details with title of Session(s) and it's description)
                                        <span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span> :</b>
                                </div>
                            </div>
                            <%--<div class="row">
                                <div class="form-group col-md-12 divweek color-blue">
                                    Temp &nbsp; 2 :
                                    <textarea id="Textarea4" class="txtwidth" rows="2" cols="50" name="address" style="margin-left: 5px;"></textarea>
                                    <textarea id="Textarea5" class="txtwidth" rows="2" cols="50" name="address" style="margin-left: 15px;"></textarea>
                                    <textarea id="Textarea6" class="txtwidth" rows="2" cols="50" name="address" style="margin-left: 15px;"></textarea>
                                </div>
                            </div>--%>
                            <div id="div_week_title" class="row" style="margin-bottom: 10px; margin-top: 10px;">
                                <div class="form-group col-md-12">
                                    <div class="form-group txtwidth" style="float: left; margin-left: 75px; text-align: center;">
                                        <b>Exercise Description</b><%--Outline--%>
                                        <br class="POC" style="display: none" />
                                        <span class="POC" style="display: none">(OCp: On-campus, ONI-Online)</span>
                                    </div>
                                    <%-- <div id="div_ref_title" class="form-group txtwidth" style="float: left; text-align: center;">
                                        Reference
                                    </div>--%>
                                    <div id="div_assign_title" class="form-group txtwidth" style="float: left; text-align: center;">
                                        <b>Assignment</b>
                                    </div>
                                    <div id="div_assign_percentage" class="form-group txtwidth" style="float: left; text-align: center;">
                                        <b>Assessment Percentage (%)</b>
                                        <br />
                                        (70% Internal, 30% Portfolio for all programs)
                                        <br />
                                        <%--(BCT - 80% Internal, 20% Portfolio)Assignment Percentage--%>
                                        <%--<br />--%>
                                        <p style="color: red;">(Enter 0 if no assessment)</p>
                                    </div>
                                    <%----padding-left: 80px----%>
                                    <div id="div_assign_criteria" class="form-group txtwidth" style="float: left; text-align: center;">
                                        <b>Assessment Criteria</b>
                                        <br />
                                        (Max 300 characters with space)
                                        <%--Assignment Criteria--%>
                                    </div>
                                    <div id="div_weekly_image" class="form-group txtwidth" style="float: left; text-align: right; width:147px; display:none;">
                                        <b>Weekly Image (images/pdf (image 600px height))</b>    
                                    </div>

                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12 divweek color-blue week1">
                                    Week &nbsp; 1 :
                                    <%--<input type="text" id="txt_week1" class="marg-btm txtwidth"/>--%>
                                    <textarea id="txt_week1" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--<textarea id="txt_week_reference1" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment1" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt1" class="marg-btm txtvalue"   />
                                    <%--<input type="text" id="txt_week_pdf1" class="marg-btm txtvalue" style="width:80px;" />--%>
                                   
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_1" id="week_img_pdf_1" onchange="javascript:return Uploadweekimagpdf('1');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_1" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_1" style="vertical-align: super;display:none;"></span>
                           

                                </div>
                                <div class="form-group col-md-12 divweek color-blue week2">
                                    Week &nbsp; 2 :
                                    <%--<input type="text" id="txt_week2" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week2" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--<textarea id="txt_week_reference2" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment2" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per2" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt2" class="marg-btm txtvalue"   />

                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_2" id="week_img_pdf_2" onchange="javascript:return Uploadweekimagpdf('2');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_2" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_2" style="vertical-align: super;display:none;"></span>

                                </div>
                                <div class="form-group col-md-12 divweek color-blue week3">
                                    Week &nbsp; 3 :
                                    <%--<input type="text" id="txt_week3" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week3" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--<textarea id="txt_week_reference3" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment3" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt3" class="marg-btm txtvalue"   />

                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_3" id="week_img_pdf_3" onchange="javascript:return Uploadweekimagpdf('3');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_3" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_3" style="vertical-align: super;display:none;"></span>


                                </div>
                                <div class="form-group col-md-12 divweek color-blue week4">
                                    Week &nbsp; 4 :
                                    <%--<input type="text" id="txt_week4" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week4" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference4" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment4" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt4" class="marg-btm txtvalue"   />

                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_4" id="week_img_pdf_4" onchange="javascript:return Uploadweekimagpdf('4');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_4" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_4" style="vertical-align: super;display:none;"></span>

                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12 divweek color-blue week5">
                                    Week &nbsp; 5 :
                                    <%--<input type="text" id="txt_week5" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week5" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--<textarea id="txt_week_reference5" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment5" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per5" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt5" class="marg-btm txtvalue"   />

                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_5" id="week_img_pdf_5" onchange="javascript:return Uploadweekimagpdf('5');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_5" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_5" style="vertical-align: super;display:none;"></span>


                                </div>
                                <div class="form-group col-md-12 divweek color-blue week6">
                                    Week &nbsp; 6 :
                                    <%--<input type="text" id="txt_week6" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week6" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference6" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment6" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per6" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt6" class="marg-btm txtvalue"   />

                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_6" id="week_img_pdf_6" onchange="javascript:return Uploadweekimagpdf('6');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_6" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_6" style="vertical-align: super;display:none;"></span>



                                </div>
                                <div class="form-group col-md-12 divweek color-blue week7">
                                    Week &nbsp; 7 :
                                    <%--<input type="text" id="txt_week7" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week7" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--<textarea id="txt_week_reference7" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment7" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per7" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt7" class="marg-btm txtvalue"   />


                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_7" id="week_img_pdf_7" onchange="javascript:return Uploadweekimagpdf('7');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_7" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_7" style="vertical-align: super;display:none;"></span>


                                </div>
                                <div class="form-group col-md-12 divweek color-blue week8">
                                    Week &nbsp; 8 :
                                    <%--<input type="text" id="txt_week8" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week8" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--<textarea id="txt_week_reference8" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment8" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per8" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt8" class="marg-btm txtvalue"  />

                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_8" id="week_img_pdf_8" onchange="javascript:return Uploadweekimagpdf('8');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_8" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_8" style="vertical-align: super;display:none;"></span>

                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12 divweek color-blue week9">
                                    Week &nbsp; 9 :
                                    <%--<input type="text" id="txt_week9" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week9" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--  <textarea id="txt_week_reference9" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment9" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per9" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt9" class="marg-btm txtvalue"   />

                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_9" id="week_img_pdf_9" onchange="javascript:return Uploadweekimagpdf('9');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_9" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_9" style="vertical-align: super;display:none;"></span>


                                </div>
                                <div class="form-group col-md-12 divweek color-blue week10">
                                    Week 10 :
                                    <%--<input type="text" id="txt_week10" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week10" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference10" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment10" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per10" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt10" class="marg-btm txtvalue"   />

                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_10" id="week_img_pdf_10" onchange="javascript:return Uploadweekimagpdf('10');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_10" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_10" style="vertical-align: super;display:none;"></span>

                                </div>
                                <div class="form-group col-md-12 divweek color-blue week11">
                                    Week 11 :
                                    <%--<input type="text" id="txt_week11" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week11" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference11" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment11" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per11" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt11" class="marg-btm txtvalue"   />

                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_11" id="week_img_pdf_11" onchange="javascript:return Uploadweekimagpdf('11');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_11" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_11" style="vertical-align: super;display:none;"></span>


                                </div>
                                <div class="form-group col-md-12 divweek color-blue week12">
                                    Week 12 :
                                    <%--<input type="text" id="txt_week12" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week12" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference12" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment12" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per12" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt12" class="marg-btm txtvalue"   />

                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_12" id="week_img_pdf_12" onchange="javascript:return Uploadweekimagpdf('12');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_12" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_12" style="vertical-align: super;display:none;"></span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-12 divweek color-blue week13">
                                    Week 13 :
                                    <%--<input type="text" id="txt_week13" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week13" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference13" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment13" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per13" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt13" class="marg-btm txtvalue"   />

                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_13" id="week_img_pdf_13" onchange="javascript:return Uploadweekimagpdf('13');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_13" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_13" style="vertical-align: super;display:none;"></span>

                                </div>
                                <div class="form-group col-md-12 divweek color-blue week14">
                                    Week 14 :
                                    <%--<input type="text" id="txt_week14" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week14" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference14" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment14" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per14" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt14" class="marg-btm txtvalue"   />


                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_14" id="week_img_pdf_14" onchange="javascript:return Uploadweekimagpdf('14');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_14" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_14" style="vertical-align: super;display:none;"></span>


                                </div>
                                <div class="form-group col-md-12 divweek color-blue week15">
                                    Week 15 :
                                    <%--<input type="text" id="txt_week15" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week15" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%-- <textarea id="txt_week_reference15" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment15" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per15" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt15" class="marg-btm txtvalue"  />


                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_15" id="week_img_pdf_15" onchange="javascript:return Uploadweekimagpdf('15');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_15" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_15" style="vertical-align: super;display:none;"></span>

                                </div>
                                <div class="form-group col-md-12 divweek color-blue week16">
                                    Week 16 :
                                    <%--<input type="text" id="txt_week16" class="marg-btm txtwidth" />--%>
                                    <textarea id="txt_week16" class="txtwidth" rows="2" cols="50" name="address"></textarea>
                                    <%--<textarea id="txt_week_reference16" class="txtwidth cls_week_ref" rows="2" cols="50"
                                        name="address"></textarea>--%>
                                    <textarea id="txt_week_assignment16" class="txtwidth cls_week_assign" rows="2" cols="50"
                                        name="address"></textarea>
                                    <input type="text" id="txt_week_per16" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" class="marg-btm txtvalue" />
                                    <input type="text" id="txt_week_crt16" class="marg-btm txtvalue"   />


                                     <label class="btn btn-primary file-upload " style="vertical-align: bottom;margin-bottom: 16px;display:none;">
                                    <span style="display:none;"><strong>Upload</strong></span>
                                    <input type="file" name="week_img_pdf_16" id="week_img_pdf_16" onchange="javascript:return Uploadweekimagpdf('16');" style="display: none;" />
                                </label>
                                <span id="lbl_week_img_name_16" style="vertical-align: super;display:none;"></span>
                                <span id="lbl_week_img_16" style="vertical-align: super;display:none;"></span>
                                </div>
                            </div>
                        </div>
                        <div id="div_course_structure" class="row" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">
                                Course Structure<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txtcourse_structure" style="width: 100%" rows="6" cols="50" name="address"></textarea>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; margin-bottom: 10px; display:none;" id="weekly_excerises" >
                            <div class="form-group col-md-2 color-blue">
                                Upload weekly excercises (PDF file only with Max 50 MB) :<span class="" style="color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">                        
                                <div class="form-group col-md-4">
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload PDF</strong></span>
                                    <input type="file" name="excercisesUpload" id="excercisesUpload" onchange="javascript:return UploadExercisespdf();" style="display: none;">
                                </label>
                                <span id="lbl_excercises_file_name" style="vertical-align: super; font-weight:bold;"><b></b></span></div>
                                <div class="form-group col-md-5">
                                 <span style="float:right; color:red;">Sample Studio weekly Exercises template :<a href="../../StudioDetails/weeklyExercises.pdf">Download</a></span>
                             </div>
                           
                            </div>
                             
                        </div>


                        <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
                            <div class="form-group col-md-2 color-blue">
                                References/Reading (if any)<span class="" style="color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_reference" style="width: 100%" rows="6" cols="50" name="address"></textarea>--%>
                                <textarea id="txt_reference" style="width: 100%" rows="6" cols="50" name="address"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default" style="display: none;">
                    <div class="panel-heading">
                        <b>Evaluation</b>
                    </div>
                    <div class="panel-body">
                        <div class="row" style="margin-top: 10px;">
                            <div class="form-group col-md-2 color-blue">
                                Assessment Criteria, Break Up & Details of Assignments
                                <span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txt_evalmethod" class="cls_evalmethod" style="width: 100%;" rows="6"
                                    cols="50" name="address"></textarea>
                                <span style="margin-left: 15px; display: none;">Weightage(%)</span>
                                <input id="txt_evalmethod_weightage1" style="width: 60px; margin-left: 3%; display: none;"
                                    type="text" class="per_load" maxlength="3" onkeypress="return IsNumeric(event);" />
                            </div>
                        </div>
                        <%--<div class="row" style="margin-top: 10px;">
                                <div class="form-group col-md-2 color-blue">
                                    Assessment 1 :
                                </div>
                                <div class="form-group col-md-9">
                                    <textarea id="txt_evalmethod" class="cls_evalmethod" style="width: 65%;" rows="2" cols="50" name="address"></textarea>
                                    <span style="margin-left: 15px;">Weightage(%)</span>
                                    <input id="txt_evalmethod_weightage1" style="width: 60px; margin-left: 3%;" type="text" class="per_load" maxlength="3" onkeypress="return IsNumeric(event);" />
                                </div>
                            </div>--%>
                        <div class="row" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">
                                Assessment 2 :
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txt_evalmethod2" class="cls_evalmethod" style="width: 65%;" rows="2"
                                    cols="50" name="address"></textarea>
                                <span style="margin-left: 15px;">Weightage(%)</span>
                                <input id="txt_evalmethod_weightage2" style="width: 60px; margin-left: 3%;" type="text"
                                    class="per_load" maxlength="3" onkeypress="return IsNumeric(event);" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">
                                Assessment 3 :
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txt_evalmethod3" class="cls_evalmethod" style="width: 65%;" rows="2"
                                    cols="50" name="address"></textarea>
                                <span style="margin-left: 15px;">Weightage(%)</span>
                                <input id="txt_evalmethod_weightage3" style="width: 60px; margin-left: 3%;" type="text"
                                    class="per_load" maxlength="3" onkeypress="return IsNumeric(event);" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">
                                Assessment 4 :
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txt_evalmethod4" class="cls_evalmethod" style="width: 65%;" rows="2"
                                    cols="50" name="address"></textarea>
                                <span style="margin-left: 15px;">Weightage(%)</span>
                                <input id="txt_evalmethod_weightage4" style="width: 60px; margin-left: 3%;" type="text"
                                    class="per_load" maxlength="3" onkeypress="return IsNumeric(event);" />
                            </div>
                        </div>
                        <div class="row" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">
                                Assessment 5 :
                            </div>
                            <div class="form-group col-md-9">
                                <textarea id="txt_evalmethod5" class="cls_evalmethod" style="width: 65%;" rows="2"
                                    cols="50" name="address"></textarea>
                                <span style="margin-left: 15px;">Weightage(%)</span>
                                <input id="txt_evalmethod_weightage5" style="width: 60px; margin-left: 3%;" type="text"
                                    class="per_load" maxlength="3" onkeypress="return IsNumeric(event);" />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default l2l3_star_show_conso_outline">
                    <div class="panel-heading">
                        <b>Course Assessments</b>&nbsp;<span class="cls_mendatory cls_mendatory_instructor l2l3_star_show_conso_outline"
                            style="display: none; color: Red;">*</span><%--<p style="color:red;">(Not Applicable for L2-L3 studios)</p>--%>
                    </div>
                    <div class="panel-body">
                        <input type="button" id="btn_add_course_assessment" class="btn btn-primary" value="Add Assessment" onclick="addCourseAssessment()" />

                        <table id="tbl_course_assessment" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Exercises</th>
                                    <th>Assessment Percentage</th>
                                    <th>Assessment Criteria</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <b>Tutor Profile</b>&nbsp;<span class="l2l3_hide" style="color: Red;">*</span>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Tutor Profile<br />
                                <p>(Min 350 to Max 400 characters with space)<%--<p style="color:red;">*Only applicable for L2-L3 studios</p>--%></p>
                                <span class="cls_mendatory cls_mendatory_instructor" style="display: none;"></span>
                            </div>
                            <div class="form-group col-md-9" id="profile_desc">
                                <%--<textarea id="txt_tutor_description" style="width: 100%" rows="4" cols="50" name="address"></textarea>--%>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                Tutor Picture<span class="cls_mendatory cls_mendatory_instructor" style="display: none;"></span>
                            </div>
                            <div class="form-group col-md-9">
                                <div id="profile_name" class="row"></div>
                                <div id="img" class="row">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="div_course_image" class="panel panel-default" style="display: none;">
                    <div class="panel-heading">
                        <b>Course Image</b><span class="l2l3_hide" style="color: red;"><%--(Only applicable for L2-L3 studios)--%>*</span>
                        <span style="color: red; margin-left: 3px;">(The image height must be 600px)</span>
                    </div>
                    <div class="panel-body">
                        <input type="button" id="btn_add_course_image" class="btn btn-primary" value="Add Image" onclick="addCourseImage()" />

                        <table id="tbl_course_image">
                            <thead></thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                    <%--<table style="width: 100%">
                <tr>
                    <td align="right" style="padding-left:75px;">
                        <button id="btnsave" type="button" style="display: block" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Save
                        </button>
                    </td>
                    <td align="left" style="padding-left:40px;">
                        <button id="Button1" type="button" style="display: block" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Save & Approve
                        </button>
                    </td>
                </tr>
            </table>--%>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>
    <%--<div class="row">
        <div class="col-sm-3" style="padding-right: 0" id="dataList_instructor">
            <div class="box-content box-no-padding">
                <button class="btn  btn-primary" type="button" id="btn_instructor">
                    <i class="icon-plus"></i>&nbsp;Add Instructor
                </button>
            </div>
            <div class="row">
            <div class="col-sm-10">
            <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor">
                <thead>
                    <tr>
                        <th>
                            Instructor
                        </th>
                    </tr>
                    <tr>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            </div></div>
        </div>
        <div class="col-sm-3" style="padding:0 0 0 0" id="datalist_area">
            <div class="box-content box-no-padding">
                <button class="btn  btn-primary" type="button" id="btn_area">
                    <i class="icon-plus"></i>&nbsp;Add Area
                </button>
            </div>
            <div class="row">
            <div class="col-sm-10">
            <table class="data-table table table-bordered table-striped" border="0" id="tblarea">
                <thead>
                    <tr>
                        <th>
                            Area
                        </th>
                    </tr>
                    <tr>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            </div></div>
        </div>
        <div class="col-sm-3" style="padding: 0 0 0 0" id="datalist_semester">
            <div class="box-content box-no-padding">
                <button class="btn  btn-primary" type="button" id="btn_semester">
                    <i class="icon-plus"></i>&nbsp;Add Semester
                </button>
            </div>
            <div class="row">
            <div class="col-sm-10">
            <table class="data-table table table-bordered table-striped" border="0" id="tblsemester">
                <thead>
                    <tr>
                        <th>
                            Semester
                        </th>
                    </tr>
                    <tr>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            </div></div>
        </div>
        <div class="col-sm-2" style="padding-right: 0 0 0 0" id="Div1">
            <div class="box-content box-no-padding">
                <button class="btn  btn-primary" type="button" id="Button1">
                    <i class="icon-plus"></i>&nbsp;Add Semester
                </button>
            </div>
            <div class="row">
            <div class="col-sm-10">
            <table class="data-table table table-bordered table-striped" border="0" id="Table1">
                <thead>
                    <tr>
                        <th>
                            Semester
                        </th>
                    </tr>
                    <tr>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            </div></div>
        </div>
    </div>--%>

    <div>
        <input id="btn_show_modal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal" value="Add Exam" style="height: 40px; margin-top: -10px; display: none;" />

        <div class="modal fade" id="mynewModal" style="display: none; top: 5%; width: 650px; left: 48%;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <strong><span class="panel-headingfont">Allocated Rooms for Same Timeslot</span></strong>
                            </div>
                            <div style="padding: 15px;" id="div1">
                                <table id="tbl_allocated_rooms" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>From Time</th>
                                            <th>To Time</th>
                                            <th>Day</th>
                                            <th>Room Id</th>
                                            <th>Course Code</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <strong><span class="panel-headingfont">Available Rooms for Different Timeslot</span></strong>
                            </div>
                            <div style="padding: 15px;" id="div2">
                                <table id="tbl_available_rooms" class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>From Time</th>
                                            <th>To Time</th>
                                            <th style="display: none;"></th>
                                            <th>Day</th>
                                            <th>Room Id</th>
                                            <th>Room Name</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button id="btn_modal_close" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <%--<button id="btn_modal_save" type="button" class="btn btn-primary" onclick="updateColumn()">Save changes</button>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_dno" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_ccode" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_studio_code" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_sem" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_c" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_s" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_y" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="img_inst_id" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="bank_detl_status" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="user_id_dtl" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="prev_course_code" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="prev_sem_code" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="prev_year_code" runat="server" ClientIDMode="Static" />
    <div id="ifrm_outline" style="display:none;"></div>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>--%>

