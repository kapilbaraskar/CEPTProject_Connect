<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="split_feedback_pdf.aspx.cs" Inherits="Admin_Master_split_feedback_pdf" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();

            $('#btnsplit').on('click', function () {
                split_pdf();
            });

            return false;
        });

        var FileName = '';
        function UploadfeedbackPDF() {
            try {
                FileName = '';
                $('#lbl_courseimage_file_name').html('');

                var fileToUpload = GetFileNameFromPath($('#feedbackPDFUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/DepartmentFeedbackPDF_upload.ashx',
                                secureuri: false,
                                fileElementId: 'feedbackPDFUpload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#feedbackPDFUpload').val("");
                                            $('#lbl_courseimage_file_name').html('<b>' + fileToUpload + '</b>');

                                            FileName = data.upfile;
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

        function split_pdf() {
            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert("Please Select Semester");
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert("Please Select Year");
                return false;
            }

            var dept_code = $('#drpdepartment').val();
            if (dept_code == "") {
                bootbox.alert("Please Select Department");
                return false;
            }

            if (FileName == "") {
                bootbox.alert("Please Upload PDF File");
                return false;
            }

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/split_department_PDF_instructor_wise",
                data: "{sem_code: '" + semester + "',year_code:'" + year_code + "',dept_code:'" + $('#drpdepartment').val() + "',file_name:'" + FileName + "'}",
                dataType: "json",
                success: function (data) {
                    if (JSON.parse(data.d)['status'] == 'True') {
                        Display_PDF_status(JSON.parse(data.d)['message']);
                    }
                    else if (JSON.parse(data.d)['status'] == 'False') {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function Display_PDF_status(data) {

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
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        "copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },

                "aaData": data,
                "aoColumns": [{ "sTitle": "PDF Name", "mData": "pdf_name", "bSortable": false },
                            { "sTitle": "PDF Detail", "mData": "pdf_detail", "bSortable": false },
                            { "sTitle": "Status", "mData": "status", "bSortable": false }]
            });

            $('#DataList').css('display', 'block');
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Split PDF
            </h1>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>
                            Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>
                            Year of allocation
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td class="cls_dept_prog">
                            Department
                        </td>
                        <td class="cls_dept_prog">
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top;">
                            Upload Department PDF<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </td>
                        <td colspan="4">
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="feedbackPDFUpload" id="feedbackPDFUpload" onchange="javascript:return UploadfeedbackPDF();" style="display: none;" />
                            </label>
                            <span id="lbl_courseimage_file_name" style="vertical-align: super;"></span>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td>
                            <button class="btn btn-primary" type="button" id="btnsplit">
                                Split
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <div id="DataList" class="panel panel-default" style="display:none;overflow:auto;">
            <div class="panel-heading">
                <strong>Incorrect PDF's</strong>
            </div>

            <div>
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
</asp:Content>

