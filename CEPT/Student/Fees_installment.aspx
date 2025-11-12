<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Fees_installment.aspx.cs" Inherits="Student_Fees_installment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script type="text/javascript">

    var pg_type = '';
    var semester = '';
    var year = '';

    $(document).ready(function () {

        $('#myModal').modal(
        {
            backdrop: 'static',
            keyboard: false
        });

        $('#myModal').modal('hide');

        $('#btnonlinepayment').on('click', function () {
            pg_type = 'citrus';
            installment_create_online_payment();
        });

        $('#btnonlineeazypay').on('click', function () {
            pg_type = 'eazypay';
            installment_create_online_payment();
        });

        $('#btnonlinehdfc').on('click', function () {
            pg_type = 'hdfc';
            installment_create_online_payment();
        });

        $('#btn_print').on('click', function () {
            window.open('Fees_installment_pay_in_slip.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
            return false;
        });

        get_fees_detail();
    });

    function get_fees_detail() {
        $.ajax({
            type: "POST",
            //url: "../WebService.asmx/get_fees_installment_dtl",
            url: "../WebService.asmx/get_fees_installment_dtl_old",
            data: "{sem_code:'', year_code:''}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {
                if (data.d != '' && data.d != '[]') {
                    var fees_detail = JSON.parse(data.d);

                    if (fees_detail["status"] == 'True') {
                        var fees_data = fees_detail['message'][0];

                        semester = fees_data["semester_type"].toString();
                        year = fees_data["year_semester"].toString();

                        var sem = '';
                        if (semester == 'M') sem = 'Monsoon';
                        else if (semester == 'S') sem = 'Spring';

                        $('#spn_sem').html(sem + ' - ' + year);

                        if (fees_data["installment_status"] != 'Y' && fees_data["installment_status"] != 'N') {
                            $('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                            $('#spn_semester').html(' (' + sem + ' - ' + year + ')');
                            $('#myModal').modal('show');
                        }
                        else {
                            $('#myModal').modal('hide');
                            var cur_installment = '';
                            var no_of_installment = parseInt(fees_data["no_of_installment"].toString());
                            var total_amount = '';
                            var fees_paid = 0;

                            for (var i = 1; i <= no_of_installment; i++) {
                                if (fees_data["is_installment" + i + "_paid"] != "Y") {
                                    cur_installment = i.toString();
                                    break;
                                }
                                else if (fees_data["is_installment" + i + "_paid"] == "Y") {
                                    fees_paid += parseInt(fees_data["installment" + i].toString());
                                }
                            }
                            
                            if (cur_installment == '') {
                                bootbox.alert("You have already paid your fees", function () {
                                    location.href = "Dashboard.aspx";
                                });
                            }

                            $('#spn_fees_paid').html(fees_paid);
                            $('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                            total_amount = parseInt(fees_data["fees_amount"]);
                            $('.cls_no_of_installment').html(fees_data["no_of_installment"]);
                            $('.cls_cur_installment').html(cur_installment);
                            $('.cls_cur_installment_amount').html(fees_data["installment" + cur_installment]);

                            $('#tbl_fees_detail').css('display', 'block');

                            $('.tbl_balance_payable tr').css('display', 'none');

                            //$('.td_installment1').html('' + total_amount / no_of_installment);
                            $('.td_installment1').html(fees_data["installment1"]);
                            $('.tr_balance_payable1').css('display', '');

                            if (no_of_installment > 1) {
                                //$('.td_installment2').html('' + total_amount / no_of_installment);
                                $('.td_installment2').html(fees_data["installment2"]);
                                $('.tr_balance_payable2').css('display', '');
                            }
                            if (no_of_installment > 2) {
                                //$('.td_installment3').html('' + total_amount / no_of_installment);
                                $('.td_installment3').html(fees_data["installment3"]);
                                $('.tr_balance_payable3').css('display', '');
                            }

                            $('.tr_balance_payable').css('display', '');
                        }
                    }
                    else if (fees_detail["status"] == 'False') {
                        bootbox.alert(fees_detail["message"], function () {
                            location.href = "Dashboard.aspx";
                        });
                    }
                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });
    }

    function installment_status_change() {
        $('#drp_no_of_installment').val('1');
        if ($('#drp_installment').val() == 'Y') {
            $('#tr_no_of_installment').css('display', '');
            $('.tr_balance_payable').css('display', '');
        }
        else if ($('#drp_installment').val() == 'N') {
            $('#tr_no_of_installment').css('display', 'none');
            $('.tr_balance_payable').css('display', 'none');
        }
        installment_change();
    }

    function installment_change() {
        $('.tbl_balance_payable tr').css('display', 'none');

        var total_installment = parseInt($('#drp_no_of_installment').val());
        var total_amount = '';

        if ($('.spn_fees_to_pay').length > 0 && $('.spn_fees_to_pay')[0].innerHTML != '') total_amount = parseInt($('.spn_fees_to_pay')[0].innerHTML);

        $('.td_installment1').html('' + total_amount / total_installment);
        $('.tr_balance_payable1').css('display', '');

        if (total_installment > 1) {
            $('.td_installment2').html('' + total_amount / total_installment);
            $('.tr_balance_payable2').css('display', '');
        }
        if (total_installment > 2) {
            $('.td_installment3').html('' + total_amount / total_installment);
            $('.tr_balance_payable3').css('display', '');
        }
    }

    function save_installment_dtl() {

        var installment_dtl = { 'installment_status': '', 'no_of_installment': '' };

        installment_dtl.installment_status = $('#drp_installment').val();
        installment_dtl.no_of_installment = $('#drp_no_of_installment').val();

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/save_installment_dtl",
            data: "{installment_dtl:'" + JSON.stringify(installment_dtl) + "', sem_code:'', year_code:''}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {
                if (data.d != '' && data.d != '[]') {
                    var fees_detail = JSON.parse(data.d);

                    if (fees_detail["status"] == 'True') {
                        var fees_data = fees_detail['message'][0];

                        if (fees_data["installment_status"] != 'Y' && fees_data["installment_status"] != 'N') {
                            $('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                            $('#myModal').modal('show');
                        }
                        else {
                            $('#myModal').modal('hide');
                            var cur_installment = '';
                            var no_of_installment = parseInt(fees_data["no_of_installment"].toString());
                            var fees_paid = 0;

                            for (var i = 1; i <= no_of_installment; i++) {
                                if (fees_data["is_installment" + i + "_paid"] != "Y") {
                                    cur_installment = i.toString();
                                    break;
                                }
                                else if (fees_data["is_installment" + i + "_paid"] == "Y") {
                                    fees_paid += parseInt(fees_data["installment" + i].toString());
                                }
                            }

                            if (cur_installment == '') {
                                bootbox.alert("You have already paid your fees", function () {
                                    location.href = "Dashboard.aspx";
                                });
                            }

                            $('#spn_fees_paid').html(fees_paid);
                            $('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                            $('.cls_no_of_installment').html(fees_data["no_of_installment"]);
                            //$('.cls_cur_installment').html(fees_data["round"]);
                            $('.cls_cur_installment').html(cur_installment);
                            $('.cls_cur_installment_amount').html(fees_data["installment" + cur_installment]);

                            $('#tbl_fees_detail').css('display', 'block');
                        }
                    }
                    else if (fees_detail["status"] == 'False') {
                        bootbox.alert(fees_detail["message"], function () {
                            location.href = "Dashboard.aspx";
                        });
                    }
                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });
    }

    function installment_create_online_payment() {
        var data = JSON.stringify({ 'pg_type': pg_type });

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/installment_create_online_payment",
            async: false,
            data: data,
            dataType: "json",
            success: function (data) {
                debugger;
                if (data.d != "" && data.d != "[]") {
                    var result = JSON.parse(data.d);

                    if (result["status"] == 'True') {
                        if (pg_type == 'citrus') {
                            generateHMAC(result["message"]);
                        }
                        else if (pg_type == 'eazypay') {
                            var eazypay_url = result["message"]["eazypay_return_url"].toString();
                            //location.href = eazypay_url;
                            document.forms[0].action = eazypay_url;
                            document.forms[0].method = 'POST';
                            document.forms[0].submit();
                        }
                        else if (pg_type == 'hdfc') {
                            submitFormHDFC(result["message"]);
                        }
                    }
                    else {
                        bootbox.alert(result["message"]);
                    }
                }
            },
            error: function (result) {
                debugger;
                alert(result);
            }
        });
    }

    var merchantURLPart = "";
    var vanityURLPart = "";
    var reqObj = null;

    function generateHMAC(param1) {
        document.getElementById("orderAmount").value = param1["amount"];
        document.getElementById("merchantTxnId").value = param1["transaction_id"];
        document.getElementById("currency").value = param1["currency"];
        document.getElementById("returnUrl").value = param1["return_url"];

        if (window.XMLHttpRequest) {
            reqObj = new XMLHttpRequest();
        }
        else {
            reqObj = new ActiveXObject("Microsoft.XMLHTTP");
        }

        merchantURLPart = param1["merchant_id"];

        if (merchantURLPart.lastIndexOf("/") != -1) {
            vanityURLPart = merchantURLPart.substring(merchantURLPart.lastIndexOf("/") + 1)
        }
        
        var orderAmount = document.getElementById("orderAmount").value;
        var merchantTxnId = document.getElementById("merchantTxnId").value;
        var currency = document.getElementById("currency").value;

        var param = "merchantId=" + vanityURLPart + "&orderAmount=" + orderAmount
				+ "&merchantTxnId=" + merchantTxnId + "&currency=" + currency;
        
        reqObj.onreadystatechange = process;

        reqObj.open("POST", param1["hmac_url"] + "?" + param, false);
        reqObj.send(null);
    }

    function process() {
        if (reqObj.readyState == 4) {
            document.getElementById("secSignature").value = reqObj.responseText;
            submitForm();
        }
    }

    function submitForm() {
        document.aspnetForm.action = merchantURLPart;
        document.aspnetForm.method = 'POST';
        document.aspnetForm.submit();
    }

    function submitFormHDFC(param1) {
        $('#encRequest').val(param1["encRequest"]);
        $('#access_code').val(param1["access_code"]);
        document.aspnetForm.action = param1["hdfc_request_url"];
        document.aspnetForm.method = 'POST';
        document.aspnetForm.submit();
    }

</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="modal hide fade" id="myModal" style="left: 50%; width: 40%;top:13%;">
        <div class="modal-header" style="font-size: 14px;text-align:center;">
            <h3 style="width:100%;">Fees Installment Detail<span id="spn_semester"></span></h3>
        </div>
        <div class="modal-body" style="height: 265px;" align="center">
            <table id="tbl_popup" cellpadding="5px">
                <tr>
                    <td align="right">
                        Total Fees Payable
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="spn_fees_to_pay"></span>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Installment
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <select id="drp_installment" style="margin: 5px 0 0 0;" onchange="installment_status_change()">
                            <option value="N">No</option>
                            <option value="Y">Yes</option>
                        </select>
                    </td>
                </tr>
                <tr id="tr_no_of_installment" style="display:none;">
                    <td align="right">
                        No of Installment
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <select id="drp_no_of_installment" style="margin: 5px 0 0 0;" onchange="installment_change()">
                            <option value='1'>1</option>
                            <option value='2'>2</option>
                            <option value='3'>3</option>
                        </select>
                    </td>
                </tr>
                <tr class="tr_balance_payable" style="display:none;">
                    <td align="right" style="vertical-align: super;">
                        Balance Payable
                    </td>
                    <td style="vertical-align: super;">&nbsp;:&nbsp;</td>
                    <td>
                        <table class="tbl_balance_payable">
                            <tr class="tr_balance_payable1">
                                <td>1)&nbsp;</td>
                                <td>Amount</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="td_installment1"></td>
                            </tr>
                            <tr class="tr_balance_payable1">
                                <td></td>
                                <td>Date</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td>17-07-2017</td>
                            </tr>
                            <tr class="tr_balance_payable2">
                                <td>2)&nbsp;</td>
                                <td>Amount</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="td_installment2"></td>
                            </tr>
                            <tr class="tr_balance_payable2">
                                <td></td>
                                <td>Date</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td>17-08-2017</td>
                            </tr>
                            <tr class="tr_balance_payable3">
                                <td>3)&nbsp;</td>
                                <td>Amount</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="td_installment3"></td>
                            </tr>
                            <tr class="tr_balance_payable3">
                                <td></td>
                                <td>Date</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td>17-09-2017</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div class="modal-footer">
            <center>
                <input type="button" id="btnsave_installment_dtl" class="btn btn-primary" value="Submit" onclick="save_installment_dtl()" />
            </center>
        </div>
    </div>

    <div class="row-fluid" style="margin-top:10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Fees Payment Detail
            </h1>
        </div>
    </div>
    
    <div class="panel panel-default" style="width:90%;float:left;margin-bottom:0px;padding:20px;">

        <div style="margin-bottom:20px;">
            <table id="tbl_fees_detail" style="display:none;" cellpadding="5px">
                <tr>
                    <td align="left">
                        Semester
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span id="spn_sem"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        Fees Paid
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span id="spn_fees_paid"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        Total Fees Payable
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="spn_fees_to_pay"></span>
                    </td>
                </tr>
                <tr id="tr1">
                    <td align="left">
                        No of Installment
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_no_of_installment"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        Current Installment
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_cur_installment"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        Installment Amount
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_cur_installment_amount"></span>
                    </td>
                </tr>
                <tr class="tr_balance_payable" style="display:none;">
                    <td style="vertical-align: super;">
                        Balance Payable
                    </td>
                    <td style="vertical-align: super;">&nbsp;:&nbsp;</td>
                    <td>
                        <table class="tbl_balance_payable">
                            <tr class="tr_balance_payable1">
                                <td>1)&nbsp;</td>
                                <td>Amount</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="td_installment1"></td>
                            </tr>
                            <tr class="tr_balance_payable1">
                                <td></td>
                                <td>Date</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td>17-07-2017</td>
                            </tr>
                            <tr class="tr_balance_payable2">
                                <td>2)&nbsp;</td>
                                <td>Amount</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="td_installment2"></td>
                            </tr>
                            <tr class="tr_balance_payable2">
                                <td></td>
                                <td>Date</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td>17-08-2017</td>
                            </tr>
                            <tr class="tr_balance_payable3">
                                <td>3)&nbsp;</td>
                                <td>Amount</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="td_installment3"></td>
                            </tr>
                            <tr class="tr_balance_payable3">
                                <td></td>
                                <td>Date</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td>17-09-2017</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>

        <div>
            <h5 style="margin-top:-10px;">1. Online Payment Option (Net Banking/ Credit/Debit card), click on the button below.</h5>
        </div>

        <div style="padding-top:5px;">
            <div class="panel panel-default" style="width:48%;float:left;margin-bottom:0px;">
                <div style="text-align:center;">
                    <button id="btnonlinepayment" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
                        <i class="icon-print bigger-160"></i>Online Payment (Citrus)
                    </button>
                </div>
                                                
                <div>
                    <table class="table table-bordered" style="font-size:14px;margin-bottom:0px !important;">
                        <thead>
                            <tr>
                                <th>Type of Transaction</th>
                                <th>Convenience Fee</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Net Banking</td>
                                <td>Zero</td>
                            </tr>
                            <tr>
                                <td>Debit Card</td>
                                <td>1.15 % - per transaction</td>
                            </tr>
                            <tr>
                                <td>Credit Card</td>
                                <td>1.15 % - per transaction</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="panel panel-default" style="width:48%;float:left;margin-bottom:0px;margin-left:2%;">
                <div style="text-align:center;">
                    <button id="btnonlineeazypay" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
                        <i class="icon-print bigger-160"></i>Online Payment (Eazypay)
                    </button>
                </div>
                                                
                <div>
                    <table class="table table-bordered" style="font-size:14px;margin-bottom:0px !important;">
                        <thead>
                            <tr>
                                <th>Type of Transaction</th>
                                <th>Convenience Fee</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Cash</td>
                                <td>Rs. 50/- per transaction</td>
                            </tr>
                            <tr>
                                <td>Demand Draft</td>
                                <td>Zero</td>
                            </tr>
                            <%--<tr>
                                <td>RTGS / NEFT</td>
                                <td>Rs. 5/- per transaction</td>
                            </tr>--%>
                            <tr>
                                <td>Net Banking</td>
                                <td>Rs. 10/- per transaction</td>
                            </tr>
                            <tr>
                                <td>Debit Card</td>
                                <td>0.75 % per transaction</td>
                            </tr>
                            <tr>
                                <td>Credit Card</td>
                                <td>1.10 % per transaction</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="panel panel-default" style="width:48%;float:left;margin-bottom:0px;margin-left:2%;display:none;">
                <div style="text-align:center;">
                    <button id="btnonlinehdfc" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
                        <i class="icon-print bigger-160"></i>Online Payment (HDFC)
                    </button>
                </div>
                                                
                <div style="display:none;">
                    <table class="table table-bordered" style="font-size:14px;margin-bottom:0px !important;">
                        <thead>
                            <tr>
                                <th>Type of Transaction</th>
                                <th>Convenience Fee</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Cash</td>
                                <td>Rs. 50/- per transaction</td>
                            </tr>
                            <tr>
                                <td>Demand Draft</td>
                                <td>Zero</td>
                            </tr>
                            <%--<tr>
                                <td>RTGS / NEFT</td>
                                <td>Rs. 5/- per transaction</td>
                            </tr>--%>
                            <tr>
                                <td>Net Banking</td>
                                <td>Rs. 10/- per transaction</td>
                            </tr>
                            <tr>
                                <td>Debit Card</td>
                                <td>0.75 % per transaction</td>
                            </tr>
                            <tr>
                                <td>Credit Card</td>
                                <td>1.10 % per transaction</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div style="clear:both;padding-top:15px;">
            <div>
                <h5>2. Offline Payment Option (By printing auto-generated pay-in slip, and cash/demand draft payment at any ICICI bank branch in India), click on the button below.</h5>
                <h5>Please Note: No cheque payment will be accepted by bank.</h5>
            </div>

            <div class="panel panel-default" style="width:48%;float:left;">
                <div style="text-align:center;">
                    <button id="btn_print" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
                        <i class="icon-print bigger-160"></i>Print Pay-In Slip
                    </button>
                </div>

                <div>
                    <table class="table table-bordered" style="font-size:14px;margin-bottom:0px !important;">
                        <thead>
                            <tr>
                                <th>Type of Transaction</th>
                                <th>Convenience Fee</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Cash</td>
                                <td>Zero</td>
                            </tr>
                            <tr>
                                <td>Demand Draft</td>
                                <td>Zero</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <input type="hidden" id="returnUrl" name="returnUrl" value="" />
        <input type="hidden" id="secSignature" name="secSignature" value="" />
        <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
        <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
        <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
        <input style="display: none" type="text" id="currency" class="text" name="currency" value="INR" />
        <input type="hidden" id="encRequest" name="encRequest" value="" />
        <input type="hidden" id="access_code" name="access_code" value="" />
    </div>
</asp:Content>

