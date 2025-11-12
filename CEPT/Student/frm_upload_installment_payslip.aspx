<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="frm_upload_installment_payslip.aspx.cs" Inherits="Student_frm_upload_installment_payslip" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var fees_status = 'N';
        var installment_dtl;
        var late_fees = false;

        $(document).ready(function () {
            //check_manually_submit();
            check_installment_submit();

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
                    },
                    txt_payment_date:
                    {
                        required: false,
                        dateFormat: true
                    },
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

            $('#txt_payment_date').datepicker({
                dateFormat: "dd/mm/yy"
            });
        
            $('#drp_mop').on('change', function () {
                if ($('#drp_mop').val() == "D") {
                    $('#div_dd').css('display', 'block');
                    $('#div_neft').css('display', 'none');
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
                            },
                            txt_payment_date:
                            {
                                required: false,
                                dateFormat: true
                            },
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
                    $('#div_neft').css('display', '');
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
                            },
                            txt_payment_date:
                            {
                                required: true,
                                dateFormat: true
                            },
                        },
                        messages:
                        {
                            txt_amount:
                            {
                                required: "Please enter Amount"
                            },
                            txt_payment_date:
                            {
                                required: "Please enter Date of Payment"
                            }
                        }
                    });

                    var validator = $("#aspnetForm").validate()

                    validator.resetForm();
                }
            });

            $('#btnsave').on('click', function () {
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

            $('#btnsave_installment').on('click', function () {
                var result = $('#aspnetForm').valid();
                if (result) {
                    if ($("#drp_installment_no").val() == '') {
                        bootbox.alert('Please Select Installment No');
                        return false;
                    }
                    else {
                        if (installment_dtl['is_installment' + $("#drp_installment_no").val() + '_paid'] == 'Y') {
                            bootbox.alert('You have already paid the Installment');
                            return false;
                        }
                        else {
                            if ($("#drp_installment_no").val() != '1') {
                                var prev_installment = parseInt($("#drp_installment_no").val()) - 1;
                                if (installment_dtl['is_installment' + prev_installment.toString() + '_paid'] != 'Y') {
                                    bootbox.alert('Your previous Installment is pending, Please pay previous installment first');
                                    return false;
                                }
                            }
                        }
                    }

                    if ($("#hdn_file_upload").val() == '') {
                        bootbox.alert('Please upload payslip.');
                        return false;
                    }
                    
                    var data = {};

                    data["mode_of_payment"] = $("#drp_mop").val();
                    data["branch_name"] = $('#drp_branch_name').val();
                    data["bank_name"] = $('#txt_bank_name').val();
                    data["dd_no"] = $('#txt_dd_no').val();
                    if ($("#drp_mop").val() == "C") {
                        data["date_of_dd"] = $('#txt_payment_date').val();
                    } else {
                        data["date_of_dd"] = $('#txt_dd_date').val();
                    }
                    data["amount"] = $('#txt_amount').val();
                    data["uploadpayslippath"] = $("#hdn_file_upload").val();
                    data["installment_no"] = $("#drp_installment_no").val();;//$("#drp_payslip_installment_no").val()

                    //if (late_fees) {
                    //    if (!$('#not_date').is(":checked")) {
                    //        data["payslip_generated_date"] = $('input[type=radio][name=rdo_generated_date]:checked').val();
                    //    } else {
                    //        data["payslip_generated_date"] = "";
                    //    }
                    //} else {
                    //    data["payslip_generated_date"] = "";
                    //}

                    //if (!$('#not_date').is(":checked")) {
                    //    if (data["payslip_generated_date"] == undefined) {
                    //        bootbox.alert('Please select Payslip Generated Date. If Date is not available in list kindly Tick the above checkbox and go ahead.');
                    //        return false;
                    //    }
                    //}

                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/save_installment_payslip_dtl",
                        data: "{ 'manually_data': '" + JSON.stringify(data) + "' }",
                        contentType: "application/json",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != '' && data.d != '[]') {
                                var fees_detail = JSON.parse(data.d);

                                if (fees_detail["status"] == 'True') {
                                    bootbox.alert(fees_detail['message']);
                                    check_installment_submit();
                                }
                                else if (fees_detail["status"] == 'False') {
                                    bootbox.alert(fees_detail['message']);
                                    check_installment_submit();
                                }
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
                            //fees_status = "Y";
                            //$('#btnsave').css('display', 'none');
                            //check_installment_submit();
                        }

                        if (data.d[1] != null) {
                            var branch_data = JSON.parse(data.d[1]);

                            for (var i = 0; i < branch_data.length; i++) {
                                $('#drp_branch_name').append($("<option></option>").val(branch_data[i]["sol_id"]).html(branch_data[i]["branch"]));
                            }

                            $('#drp_branch_name').chosen();
                            $('#drp_mop').chosen();
                        }
                    }
                }
            });
        }

        function check_installment_submit() {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/check_installment_payslip_submit",
                data: {},
                contentType: "application/json",
                datatype: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d[0] != '' && data.d[0] != '[]') {
                            var fees_detail = JSON.parse(data.d[0]);

                            if (fees_detail["status"] == 'True') {
                                var fees_data = fees_detail['message'][0];
                                installment_dtl = fees_detail['message'][0];

                                if (fees_data["installment_status"] != 'Y' && fees_data["installment_status"] != 'N') {

                                }
                                else {
                                    var cur_installment = '';
                                    var no_of_installment = parseInt(fees_data["no_of_installment"].toString());

                                    for (var i = 1; i <= no_of_installment; i++) {
                                        if (fees_data["is_installment" + i + "_paid"] != "Y") {
                                            cur_installment = i.toString();
                                            break;
                                        }
                                    }

                                    if (cur_installment == '') {
                                        bootbox.alert("You have already paid your fees", function () {
                                            location.href = "Dashboard.aspx";
                                        });
                                    }
                                    else {
                                        check_fees_payment_dtl();
                                    }

                                    $('#btnsave_installment').css('display', 'block');
                                    //$('#div_installment_no').css('display', 'block');
                                }
                            }
                            else if (fees_detail["status"] == 'False') {
                                bootbox.alert(fees_detail["message"], function () {
                                    location.href = "Dashboard.aspx";
                                });
                            }
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

        function check_fees_payment_dtl() {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_fees_payment_dtl",
                data: "{}",
                contentType: "application/json",
                async: false,
                cache: false,
                datatype: "json",
                success: function (data) {
                    var fees_detail_flag = true;

                    if (data.d != '' && data.d != '[]') {
                        var fees_detail = JSON.parse(data.d);

                        if (fees_detail["status"] == 'True') {
                            var user_fees_choice = fees_detail['message']['user_fees_choice'];
                            var user_fees_installment_dtl = fees_detail['message']['user_fees_installment_dtl'];
                            var user_fees_status = fees_detail['message']['user_fees_status'];

                            if (user_fees_choice != null) {
                                if (user_fees_choice[0]['fees_status'] == 'F') {
                                    if (user_fees_installment_dtl != null) {
                                        var fees_data = user_fees_installment_dtl[0];

                                        var cur_installment = '';
                                        var no_of_installment = parseInt(fees_data["no_of_installment"].toString());

                                        for (var i = 1; i <= no_of_installment; i++) {
                                            if (fees_data["is_installment" + i + "_paid"] != "Y") {
                                                cur_installment = i.toString();
                                                break;
                                            }
                                        }

                                        if (cur_installment == '') {
                                            bootbox.alert("You have already paid your fees", function () {
                                                location.href = "Dashboard.aspx";
                                            });
                                        }
                                        else {
                                            if (user_fees_installment_dtl[0]['fees_type'] == 'H') {
                                                bootbox.alert("Please select Fees Pay Type (Full/Installment) to Upload Payslip", function () {
                                                    location.href = "Fees_payment.aspx";
                                                });
                                            }
                                            else {
                                                $('#drp_installment_no').val(cur_installment);
                                                $('#spn_applied_for').css('display', 'inline-block');
                                                $('#spn_applied_for').html('More than 10 Credits');//12
                                                $('#spn_pay_type').css('display', 'inline-block');

                                                //get_generated_payslip_dtl();

                                                if (no_of_installment == 1) {
                                                    $('#spn_pay_type').html('and chose to Pay Full Fees');
                                                }
                                                else if (no_of_installment == 4) {//Open 5th Installment Start //Open 5th Installment End
                                                    $('#spn_pay_type').html('and chose to Pay in Installments');
                                                    $('#spn_cur_installment').css('display', 'block');
                                                    $('#spn_cur_installment').html('Current Installment : ' + cur_installment);
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        fees_detail_flag = false;
                                    }
                                }
                                else if (user_fees_choice[0]['fees_status'] == 'H') {
                                    if (user_fees_status != null) {
                                        bootbox.alert("You have already paid your fees", function () {
                                            location.href = "Dashboard.aspx";
                                        });
                                    }
                                    else {
                                        $('#drp_installment_no').val('1');
                                        $('#spn_applied_for').css('display', 'inline-block');
                                        $('#spn_applied_for').html('Less than 10 Credits');//12
                                        //get_generated_payslip_dtl();
                                    }
                                }
                            }
                            else {
                                fees_detail_flag = false;
                            }
                        }
                        else {
                            fees_detail_flag = false;
                        }
                    }
                    else {
                        fees_detail_flag = false;
                    }

                    if (!fees_detail_flag) {
                        bootbox.alert("Fees Detail not Found. Please try again.", function () {
                            location.href = "Dashboard.aspx";
                        });
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }

        function get_generated_payslip_dtl() {
            var installment_no = parseInt($('#drp_installment_no').val());
            if (installment_no > 0) {

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/get_generated_payslip_dtl",
                    data: "{installment_no:" + installment_no + "}",
                    contentType: "application/json",
                    async: false,
                    cache: false,
                    datatype: "json",
                    success: function (data) {
                        
                        if (data.d != '' && data.d != '[]') {
                            var payslip_dtl = JSON.parse(data.d);
                            if (payslip_dtl.length > 0) {
                                $("#append_slip_date").html('');
                                var str_append = "";

                                for (var i = 0; i < payslip_dtl.length; i++) {
                        
                                    if (payslip_dtl[i]["payslip_generated_date"] != "") {
                                        str_append += '<input type="radio" name="rdo_generated_date" value="' + payslip_dtl[i]["payslip_generated_date"] + '" /> &nbsp; <span>' + payslip_dtl[i]["payslip_generated_date"] + '</span> <br />'
                                        late_fees = true;
                                    } else {
                                        if (!late_fees) {
                                            late_fees = false;
                                        }
                                    }
                                }

                                $("#append_slip_date").append(str_append);
                                
                                
                            }
                        } else {
                            
                            late_fees = false;
                        }
                    },
                    Error: function (data) {
                        alert(data.d);
                    }
                });
                if (late_fees) {
                    $(".div_generated").css("display", "block");
                } else {
                    $(".div_generated").css("display", "none");
                }
            }
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

                                            $("#div_upload_preview").html('<embed id="upload_preview" src="../UploadPayslip/' + FileName + '" width="220" height="264"></embed>');
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
                <i class="icon-desktop"></i>&nbsp;Upload Manully Payslip
            </h1>
        </div>
        <div class="panel panel-default ">
            <%--<div class="panel-heading">
                <strong><span class="panel-headingfont"></span></strong>
            </div>--%>

            <div style="padding-left:16px;padding-top:16px;">
                <b>
                    You have Applied for
                    <span id="spn_applied_for" style="display:none;"></span>
                    <span id="spn_pay_type" style="display:none;"></span>
                    <span id="spn_cur_installment" style="display:none;"></span>
                </b>
            </div>

            <div style="padding: 16px;">
                <div id="div_installment_no" class="row" style="margin-left: 2px;display:none;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Installment No
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_installment_no">
                                <option value="">-- Select Installment --</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </div>
                    </div>
                </div>
                <%--<div class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Payslip Installment No.
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_payslip_installment_no">
                                <option value="">-- Select Installment No --</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </div>
                    </div>
                </div>--%>
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Mode of Payment
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_mop">
                                <option value="C">NEFT-RTGS</option><%--CASH/--%>
                                <option value="D">DD/Cheque</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Branch Name where Deposited
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drp_branch_name">
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Amount
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_amount" id="txt_amount" />
                        </div>
                    </div>
                </div>
                <div id="div_neft" class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Date of Payment (dd/mm/yyyy)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_payment_date" id="txt_payment_date" />
                        </div>
                    </div>
                </div>
                <div id="div_dd" class="row" style="margin-left: 2px; display: none;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Bank Name
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_bank_name" id="txt_bank_name" placeholder="" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            DD No.(start with zero)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_dd_no" id="txt_dd_no" placeholder="" />
                        </div>
                    </div>
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                            Date of DD (dd/mm/yyyy)
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_dd_date" id="txt_dd_date" />
                        </div>
                    </div>
                </div>
                
                <div class="row div_generated" style="margin-left: 2px;display:none;">
                    <div class="col-md-8 col-sm-8" style="padding: 4px 0 4px 0;">
                            <input type="checkbox" id="not_date" /> If Date is not available in below list then do not select any date and kindly Tick the checkbox and go ahead.
                    </div>
                </div>

                <div class="row div_generated" style="margin-left: 2px;display:none;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                            <b>Payment Payslip Date (MM/DD/YYYY - Generated)</b>
                    </div>
                </div>
                <div class="row div_generated" style="margin-left: 2px;display:none;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;" id="append_slip_date">
                    </div>
                </div>

                
                <%--<div class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 0 0 0 0;">
                        <div class="col-md-9 col-sm-4" style="padding: 0 0 0 0;">
                            Amount
                        </div>
                        <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                            <input type="text" name="txt_amount" id="txt_amount" />
                        </div>
                    </div>
                </div>--%>
                <div class="row" style="margin-left: 2px;">
                    <div class="col-md-4 col-sm-8" style="padding: 4px 0 4px 0;">
                        <div class="row" style="margin-left: 2px;">
                            <div class="col-md-9 col-sm-6" style="padding: 2px 0 4px 0;">
                                Upload Payslip in JPEG(Maximum 1 MB)
                            </div>
                            <div class="col-md-11 col-sm-4" style="padding: 0 0 0 0;">
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload Payslip</strong></span>
                                    <input type="file" name="payslipUpload" id="payslipUpload" onchange="javascript:return UploadPayslip();" style="display: none;" />
                                </label>
                                <input type="hidden" id="hdn_file_upload" />
                            </div>
                        </div>
                        <div class="row" style="margin-left: 2px;">
                            <div class="col-md-11 col-sm-11" style="padding: 0 0 0 0;">
                                <span id="spn_upload_name" style="word-wrap: break-word;"></span>
                            </div>
                        </div>
                    </div>
                    <div id="div_upload_preview" class="col-md-8 col-sm-4" style="padding: 0 0 0 0;">
                        
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
                                    <%--<button id="btnsave" style="display: none;" class="btn btn-lg btn-primary" type="button">
                                        <i class="icon-save bigger-160"></i>Save Payslip Detail
                                    </button>--%>
                                    <button id="btnsave_installment" style="display: none;" class="btn btn-lg btn-primary" type="button">
                                        <i class="icon-save bigger-160"></i>Save Payslip Detail
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


<%--<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function () {
            check_installment_submit();

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

            $('#btnsave_installment').on('click', function () {
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
                        url: "../WebService.asmx/save_installment_payslip_dtl",
                        data: "{ 'manually_data': '" + JSON.stringify(data) + "' }",
                        contentType: "application/json",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != '' && data.d != '[]') {
                                var fees_detail = JSON.parse(data.d);

                                if (fees_detail["status"] == 'True') {
                                    bootbox.alert(fees_detail['message']);
                                    check_installment_submit();
                                }
                                else if (fees_detail["status"] == 'False') {
                                    bootbox.alert(fees_detail['message']);
                                }
                            }
                        }
                    });
                }
            });
        });

        function check_installment_submit() {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/check_installment_payslip_submit",
                data: {},
                contentType: "application/json",
                datatype: "json",
                success: function (data) {
                    if (data.d != null) {
                        //if (data.d[0] == "Y") {
                            //$('#btnsave_installment').css('display', 'none');
                        //}
                        if (data.d[0] != '' && data.d[0] != '[]') {
                            var fees_detail = JSON.parse(data.d[0]);

                            if (fees_detail["status"] == 'True') {
                                var fees_data = fees_detail['message'][0];

                                if (fees_data["installment_status"] != 'Y' && fees_data["installment_status"] != 'N') {
                                    
                                }
                                else {
                                    var cur_installment = '';
                                    var no_of_installment = parseInt(fees_data["no_of_installment"].toString());

                                    for (var i = 1; i <= no_of_installment; i++) {
                                        if (fees_data["is_installment" + i + "_paid"] != "Y") {
                                            cur_installment = i.toString();
                                            break;
                                        }
                                    }

                                    if (cur_installment == '') {
                                        bootbox.alert("You have already paid your fees", function () {
                                            location.href = "Dashboard.aspx";
                                        });
                                    }
                                }
                            }
                            else if (fees_detail["status"] == 'False') {
                                bootbox.alert(fees_detail["message"], function () {
                                    location.href = "Dashboard.aspx";
                                });
                            }
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
                                    <button id="btnsave_installment" style="display: block;" class="btn btn-lg btn-primary" type="button">
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
</asp:Content>--%>
