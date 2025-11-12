<%@ Page Title="CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="fees_waiver_installment_entry.aspx.cs" Inherits="Admin_Master_fees_waiver_installment_entry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/StudentFees.js?t=02082019" type="text/javascript"></script>
    <script src="../../DesignJS/FixedHeader.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js?t=28062019"></script>
    <script type="text/javascript">
        //M 02082019
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

        function UploadStudent() {
            debugger;
            try {
                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                //var ses_data = $('#hdn_session').val();
                //var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckMarksDocumentExtension(fileToUpload)) {
                    //if (filename != "" && filename != null) {
                    //ses_data = ses_data.replace(/"/g, "'");
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/FeesDataUpload.ashx',
                        secureuri: false,
                        //data: { "session_data": ses_data, "course_code": $('#hdn_c').val(), "semester_type": sem, "year_code": year },
                        fileElementId: 'reservation_upload_document',
                        dataType: 'json',
                        success: function (data, status) {
                            if (data.message.length > 0) {
                                for (var i = 0; i < data.message.length; i++) {
                                    for (var j = 0; j < $("#example tbody tr").length; j++) {
                                        if (data.message[i]["user_id"] == $("#example tbody tr")[j].children[0]["innerHTML"]) {
                                            if (data.message[i]["fees_type"] == "Y") {
                                                //$(this).find(".chk_fees_type_child").prop('checked', true);
                                                $("#example tbody tr")[j].children[2].children[0].children[0].checked = true;
                                            }
                                            if (data.message[i]["fees_waiver_credits"] != "" && data.message[i]["fees_waiver_credits"] != null) {
                                                //$(this).find(".fees_waiver_credits").val(data.message[i]["fees_waiver_credits"]);
                                                //$(this).find(".fees_waiver_credits").prop('disabled', false);
                                                $("#example tbody tr")[j].children[3].children[0].value = data.message[i]["fees_waiver_credits"];
                                                $("#example tbody tr")[j].children[3].children[0].disabled = false;
                                            }
                                            //if (data.message[i]["installment_status"] == "Y") {
                                            //    //$(this).find(".chk_fees_type_child").prop('checked', true);
                                            //    $("#example tbody tr")[j].children[4].children[0].children[0].checked = true;
                                            //}
                                            //if (data.message[i]["waiver_credits"] != "" && data.message[i]["waiver_credits"] != null) {
                                            //    //$(this).find(".fees_waiver_credits").val(data.message[i]["fees_waiver_credits"]);
                                            //    //$(this).find(".fees_waiver_credits").prop('disabled', false);
                                            //    $("#example tbody tr")[j].children[5].children[0].value = data.message[i]["waiver_credits"];
                                            //    $("#example tbody tr")[j].children[5].children[0].disabled = false;
                                            //}
                                        }
                                    }
                                }
                                $('#reservation_upload_document').val('');
                            }

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
                            //debugger;
                            //var abc = JSON.parse(data.responseText);
                            //if (abc.status == "True") {
                            //    if (abc.length > 0) {
                            //        for (var i = 0; i < abc.length; i++) {
                            //            for (var j = 0; j < $("#example tbody tr").length; j++) {
                            //                if (abc[i]["user_id"] == $("#example tbody tr")[j].children[0]["innerHTML"]) {
                            //                    if (abc[i]["fees_type"] == "Y") {
                            //                        //$(this).find(".chk_fees_type_child").prop('checked', true);
                            //                        $("#example tbody tr")[j].children[2].children[0].children[0].checked = true;
                            //                    }
                            //                    if (abc[i]["fees_waiver_credits"] != "" && abc[i]["fees_waiver_credits"] != null) {
                            //                        //$(this).find(".fees_waiver_credits").val(abc[i]["fees_waiver_credits"]);
                            //                        //$(this).find(".fees_waiver_credits").prop('disabled', false);
                            //                        $("#example tbody tr")[j].children[3].children[0].value = abc[i]["fees_waiver_credits"];
                            //                        $("#example tbody tr")[j].children[3].children[0].disabled = false;
                            //                    }
                            //                    //if (abc[i]["installment_status"] == "Y") {
                            //                    //    //$(this).find(".chk_fees_type_child").prop('checked', true);
                            //                    //    $("#example tbody tr")[j].children[4].children[0].children[0].checked = true;
                            //                    //}
                            //                    //if (abc[i]["waiver_credits"] != "" && abc[i]["waiver_credits"] != null) {
                            //                    //    //$(this).find(".fees_waiver_credits").val(abc[i]["fees_waiver_credits"]);
                            //                    //    //$(this).find(".fees_waiver_credits").prop('disabled', false);
                            //                    //    $("#example tbody tr")[j].children[5].children[0].value = abc[i]["waiver_credits"];
                            //                    //    $("#example tbody tr")[j].children[5].children[0].disabled = false;
                            //                    //}
                            //                }
                            //            }
                            //        }
                            //    }
                            //} else {
                                
                            //}
                            $("#UploadingProgress").fadeOut(200);
                            //alert(data.responseText);
                            //window.location.reload();
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
        //M 02082019
        $(document).ready(function () {

            $('#drpyear,#drpdepartment,#drpprog').on('change', function () {

                $('#btnsave_feestype').css("display", "none");
                $('#DataList').css('display', 'none');

            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-rupee"></i>Student Fees Type
            </h1>
        </div>
        <div class="space">
        </div>
        <div>
            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <%--<td>
                            Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>--%>
                        <td>Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>Programme :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>

                    </tr>
                    <tr>
                        <td>Year of enrollment :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td></td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive_feestype">
                                Retrieve
                            </button>
                        </td>


                    </tr>

                </table>
            </div>
        </div>
        <div style="margin-left: 5px;">
            <a href="../../ExcelFormatFiles/FeesData.xlsx" download>Download Excel Format</a>
        </div>
        <div style="margin-left: 5px;">
            <span>Upload Excel : </span>
            <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                onchange="javascript:return UploadStudent();" style="margin-left: 4%;" /><span style="color: red; margin-left: 5px;">(Note : Retrieve Data > Download Excel Format > Insert Data > Upload Excel > Verify > Click Save)</span>
        </div>
        <div style="margin-top: 25px; display: none; width: 100%" class="row-fluid" id="DataList">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="example" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
        <div style="width: 100%; float: left; margin-top: 15px;">
            <table width="100%">
                <tr>
                    <td align="center">
                        <button id="btnsave_feestype" style="display: none" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Save
                        </button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>

