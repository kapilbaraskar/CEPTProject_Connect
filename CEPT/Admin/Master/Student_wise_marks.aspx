<%@ Page Title="Student Wise Marks" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_wise_marks.aspx.cs" Inherits="Admin_Master_Student_wise_marks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/student_wise_marks_06092017.js?t=21042022" type="text/javascript"></script><%--19092020--%><%--21062021--%><%--17012022--%>
    <script src="../../Scripts/AjaxFileupload.js"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>
        .inline_input {

            width: 35px;
            margin: 0;
        }
    </style>

    <script type="text/javascript">

        <%--function student_marks_upload() {

            $("#" + '<%=student_marks_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/Student_Marks_Upload.ashx',
                'buttonText': 'Excel Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 120,
                'height': 34,
                'formData': { 'course_code': $('#hdn_c').val(), 'semester_type': sem, 'year_code': year, 'session_data': $('#hdn_session').val() },
                'onUploadSuccess': function (file, data, response) {

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
                        $('#H2').html('' + course_detail[0]['course_code'] + ' - ' + course_detail[0]['course_name']);
                        var str_modal2 = "<div id='DataList2' style='display: none;'>" +
                                " <table cellpadding='0' cellspacing='0' border='0' id='example2' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                " <thead></thead><tbody></tbody></table></div>";
                        $('.modal-body')[1].innerHTML = str_modal2;
                        display_student_marks_upload_error_data(JSON.parse(data));
                    }
                }
            });

            $('#ctl00_ContentPlaceHolder1_student_marks_upload').addClass("btn btn-lg btn-primary");
            $('#ctl00_ContentPlaceHolder1_student_marks_upload').css('padding', '0');
            $('#ctl00_ContentPlaceHolder1_student_marks_upload').css('margin-bottom', '0');
            $('#SWFUpload_0').css('margin-left', '-50%');
            $('#ctl00_ContentPlaceHolder1_student_marks_upload-button').removeClass("uploadify-button");
            $('#ctl00_ContentPlaceHolder1_student_marks_upload-queue').remove();

            return false;
        }--%>

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
                    case 'xls':
                    //case 'xlxs':
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

        function UploadMarks() {
            try {
                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                
                var ses_data = $('#hdn_session').val();
                //var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckMarksDocumentExtension(fileToUpload)) {
                    //if (filename != "" && filename != null) {
                    ses_data = ses_data.replace(/"/g, "'");
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/Student_Marks_Upload.ashx',
                        secureuri: false,
                        data: { "session_data": ses_data, "course_code": $('#hdn_c').val(), "semester_type": sem, "year_code": year },
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
                    $('#reservation_upload_document').val('');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Wise Marks
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <h4>Note :</h4>
        <br />

        <p>Step 1: Add Assessment, Click on <span style="color:blue;"><b>Assessment</b></span> button.</p>
        <p>Step 2: Upload Assessment Marks, Click on <span style="color:blue;"><b>Excel Format</b></span> button Export to Excel File.</p>
        <p>Step 3: Insert Marks into Excel File</p>
        <p>Step 4: Scroll down, <span style="color:blue;"><b>Choose File</b></span> to Upload Excel File. It saves marks for the Assessment.</p>
        <p>Step 5: If you want to manually insert marks then first insert marks and Click <span style="color:blue;"><b>Save</b></span> Button besides Upload Marks.</p>
        <p>Step 6: If you want to Submit Exam Wise Marks then Click <span style="color:blue;"><b>Submit</b></span> Button below Exam Titel.</p>
        <p>Step 7: If you want to Commit Grade into Database, Click <span style="color:blue;"><b>Calculate Grade</b></span> Button besides Save button.</p>
        <p>Step 8: Export all data into Excel, Click <span style="color:blue;"><b>Excel Data</b></span> Button besides Assessment button.</p>
        <p>Step 9: Once all exam marks is entered, To Submit all Exam Marks, Click <span style="color:blue;"><b>Submit</b></span> Button besides Calculate Grade button.</p>
        <p style="color:red;">Note: You can not change once you final submit all exam marks.</p>
        <p style="color:red;">Note: Marks for each assessment have to be entered out of 100. The final marks will be appropriately calculated using the weight given to each assessment.</p>

    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span id="spn_course_name" class="panel-headingfont"></span></strong>
                <span style="float: right;">
                    <input id="btn_add_exam" type="button" class="btn btn-primary" value="Assessment" style="height: 40px; margin-top: -10px;" onclick="addModalData()" />
                    <input id="btn_excel_data" type="button" class="btn btn-primary" value="Excel Data" style="height: 40px; margin-top: -10px;" onclick="display_data_for_excel()" />
                    <input id="btn_excel_format" type="button" class="btn btn-primary" value="Excel Format" style="height: 40px; margin-top: -10px;" onclick="display_excel_format()" />
                    <input id="btn_show_modal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal" value="Add Exam" style="height: 40px; margin-top: -10px; display: none;" />
                    <input id="btn_show_modal2" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal2" value="Display" style="height: 40px; margin-top: -10px; display: none;" />
                    <input id="btn_show_modal3" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal3" value="Excel" style="height: 40px; margin-top: -10px; margin-left: 10px; display: none;" />
                </span>
            </div>

            <div>
                <%--class="panel-body"--%>
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

        <table style="width: 62%; margin-left: 15%;">
            <tr>
                <td align="right">
                    <%--<div id="div_student_marks_upload">
                        <asp:FileUpload ID="student_marks_upload"  runat="server"/>
                    </div>--%>
                    <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                        onchange="javascript:return UploadMarks();" />
                </td>
                <td align="right">
                    <button id='btnsave' type='button' style='display: block;' class='btn btn-lg btn-primary' onclick='save_student_marks_Data()'>
                        <i class='icon-save bigger-160'></i>Save
                    </button>
                </td>
                <td align="center">
                    <button id="btn_calc_grade" type="button" class="btn btn-lg btn-primary" onclick="calculate_grade()">Calculate Grade</button>
                </td>
                <td align="left">
                    <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_grade()">Submit</button>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
    </div>

    <div class="modal fade" id="mynewModal" style="display: none; top: 5%; width: 670px; left: 46%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H1"></h4>
                    <input id="btn_add_exam_row" type="button" class="btn btn-primary" value="Add New Assessment" style="height: 40px; margin-top: 5px;" onclick="add_exam_row()" />
                    <input id="btn_remove_all" type="button" class="btn btn-primary" value="Remove All" style="height: 40px; margin-top: 5px;" onclick="remove_all_exam()" />
                </div>

                <div class="modal-body">
                    <%--<iframe src="#DataList" width="500" height="580" frameborder="0" allowtransparency="true">
                    </iframe>--%>

                    <div>
                        <div style="width: 75px; font-size: 14px; display: inline-block; margin-left: 5px;">Exam Title </div>
                        <input id="txt_modal_examtitle" type='text' value='' placeholder="Exam Title" class='' style="width: 300px; margin-left: 5px;" />
                        <input id="txt_modal_examweightage" type='text' value='' placeholder="Weightage" onkeypress='return IsNumeric(event);' style="width: 80px; margin-left: 5px;" />
                    </div>

                    <%--<div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 1 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 2 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 3 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 4 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 5 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 6 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 7 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 8 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 9 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>
                    <div>
                        <div style="width: 65px;font-size:14px;display:inline-block;margin-left: 5px;">Exam 10 </div>
                        <input type='text' value='' placeholder="Exam Title" class='' style="width:300px;margin-left: 5px;"/>
                        <input type='text' value='' placeholder="Weightage" class='' style="width:80px;margin-left: 5px;"/>
                    </div>--%>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <%--<button id="btn_modal_save" type="button" class="btn btn-primary" onclick="addColumn()">Save changes</button>--%>
                    <button id="btn_modal_save" type="button" class="btn btn-primary" onclick="updateColumn()">Save changes</button>
                </div>
            </div>
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

    <input type="hidden" id="hdn_c" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_s" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_y" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_session" runat="server" clientidmode="Static" />
</asp:Content>

