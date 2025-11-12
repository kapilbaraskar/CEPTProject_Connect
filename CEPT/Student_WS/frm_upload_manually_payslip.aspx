<%@ Page Title="Upload Payslip" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="frm_upload_manually_payslip.aspx.cs" Inherits="Student_frm_upload_manually_payslip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script src="../Js/google_analytics_code.js" type="text/javascript"></script>
 
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
        <style type="text/css">
        .style1
        {
            width: 386px;
        }
        #sidebar:before   
        {
            width : 124px;    
        }
        #sidebar 
        {
             width : 124px;    
        }
    </style>
    <script type="text/javascript">


        $(document).ready(function () {

            check_manually_submit();

            $.validator.addMethod("dateFormat", function (value, element) {
                return value.match(/^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/);
            }, "Please enter a date in the format dd/mm/yyyy.");

            $("#aspnetForm").validate({
                rules:
                {
                    txt_amount:
                    {
                        required: true,
                        digits: true
                    },
                    txt_bank_name:
                    {
                        required: false
                    },
                    txt_dd_no:
                    {
                        required: false,
                        digits: true
                    },
                    txt_dd_date:
                    {
                        required: false,
                        dateFormat: true
                    }
                },
                messages:
                {
                    txt_amount:
                    {
                        required: "Please enter Amount"
                    }
                }
            });

            $('#txt_dd_date').datepicker({
                dateFormat: "dd/mm/yy"
            });

            $('#drp_mop').on('change', function () {

                debugger;

                if ($('#drp_mop').val() == "D") {

                    $('#div_dd').css('display', 'block');



                    $('#aspnetForm').removeData('validator');

                    $("#aspnetForm").validate({
                        rules:
                        {
                            txt_amount:
                            {
                                required: true,
                                digits: true
                            },
                            txt_bank_name:
                            {
                                required: true
                            },
                            txt_dd_no:
                            {
                                required: true,
                                digits: true
                            },
                            txt_dd_date:
                            {
                                required: true,
                                dateFormat: true
                            }
                        },
                        messages:
                        {
                            txt_amount:
                            {
                                required: "Please enter Amount"
                            },
                            txt_bank_name:
                            {
                                required: "Please enter Bank name"
                            },
                            txt_dd_no:
                            {
                                required: "Please enter DD No"
                            },
                            txt_dd_date:
                            {
                                required: "Please enter Date of DD"
                            }

                        }

                    });

                    var validator = $("#aspnetForm").validate()

                    validator.resetForm();
                }
                else {

                    $('#div_dd').css('display', 'none');


                    $('#aspnetForm').removeData('validator');



                    $("#aspnetForm").validate({
                        rules:
                        {
                            txt_amount:
                            {
                                required: true,
                                digits: true
                            },
                            txt_bank_name:
                            {
                                required: false
                            },
                            txt_dd_no:
                            {
                                required: false,
                                digits: true
                            },
                            txt_dd_date:
                            {
                                required: false,
                                dateFormat: true
                            }
                        },
                        messages:
                        {
                            txt_amount:
                            {
                                required: "Please enter Amount"
                            }
                        }
                    });

                    var validator = $("#aspnetForm").validate()

                    validator.resetForm();

                }
            });

            $('#btnsave').on('click', function () {

                debugger;

                var result = $('#aspnetForm').valid();

                if (result) {

                    if ($("#hdn_file_upload").val() == '') {

                        bootbox.alert('Please upload payslip.');

                        return false;
                    }

                    var data = {};

                    data["mode_of_payment"] = $("#drp_mop").val();
                    data["branch_name"] = $('#drp_branch_name').val();
                    data["bank_name"] = $('#txt_bank_name').val();
                    data["dd_no"] = $('#txt_dd_no').val();
                    data["date_of_dd"] = $('#txt_dd_date').val();
                    data["amount"] = $('#txt_amount').val();
                    data["uploadpayslippath"] = $("#hdn_file_upload").val();

                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/save_upload_manually_payslip_dtl",
                        data: "{ 'manually_data': '" + JSON.stringify(data) + "' }",
                        contentType: "application/json",
                        datatype: "json",
                        success: function (data) {

                            if (data.d != "") {

                                bootbox.alert(data.d);
                                check_manually_submit();

                            }
                        }
                    });
                }

            });

        });


        function check_manually_submit() {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/check_manually_payslip_submit",
                data: {},
                contentType: "application/json",
                datatype: "json",
                success: function (data) {

                    if (data.d != null) {

                        if (data.d[0] == "Y") {

                            $('#btnsave').css('display', 'none');
                        }

                        if (data.d[1] != null) {

                            var branch_data = JSON.parse(data.d[1]);


                            for (var i = 0; i < branch_data.length; i++) {
                                $('#drp_branch_name').append($("<option></option>").val(branch_data[i]["sol_id"]).html(branch_data[i]["branch"]));
                            }

                            $('#drp_branch_name').chosen();
                        }

                    }
                }
            });

        }

        function UploadPayslip() {
            $("#hdn_file_upload").val('');
            $('#spn_upload_name').text('');
            try {
                var fileToUpload = GetFileNameFromPath($('#payslipUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPayslipExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../Handler/UploadPayslip.ashx',
                                secureuri: false,
                                fileElementId: 'payslipUpload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#payslipUpload').val("");

                                            FileName = data.upfile;

                                            $('#spn_upload_name').text(fileToUpload);

                                            $("#hdn_file_upload").val(FileName);

                                            debugger;

                                            //alert('<%= Session["abc"] %>');

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
                    alert('Invalid File Type. Please upload .jpeg,.jpg file');
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

        function CheckUserPayslipExtension(file) {
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
                    case 'Pdf':
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Upload Manully Payslip
            </h1>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont"></span></strong>
            </div>
            <div style="padding: 16px;">
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Mode of Payment
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_mop">
                                <option value="C">Cash</option>
                                <option value="D">DD</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Branch Name where Deposited
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_branch_name">
                            </select>
                        </div>
                    </div>
                </div>
                <div id="div_dd" class="row" style="margin-left: 2px; display: none;">
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Bank Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_bank_name" id="txt_bank_name" placeholder="" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            DD No.(start with zero)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_dd_no" id="txt_dd_no" placeholder="" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Date of DD (dd/mm/yyyy)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_dd_date" id="txt_dd_date" />
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Amount
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_amount" id="txt_amount" />
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Upload Payslip in JPEG(Maximum 1 MB)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Payslip</strong></span>
                                <input type="file" name="payslipUpload" id="payslipUpload" onchange="javascript:return UploadPayslip();"
                                    style="display: none;">
                            </label>
                            <input type="hidden" id="hdn_file_upload" />
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-1 col-sm-4" style="padding: 0 0 0 0;">
                        <span id="spn_upload_name"></span>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <div class="tabbable">
                <div class="row-fluid">
                    <div class="span11" style="margin-top: 10px">
                        <table style="width: 100%" align="center" border="0" cellpadding="3" cellspacing="5">
                            <tr>
                                <td align="center">
                                    <button id="btnsave" style="display: block;" class="btn btn-lg btn-primary" type="button">
                                        <i class="icon-save bigger-160"></i>Save
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
