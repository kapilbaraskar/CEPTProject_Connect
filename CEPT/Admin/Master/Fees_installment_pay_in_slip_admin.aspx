<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fees_installment_pay_in_slip_admin.aspx.cs" Inherits="Admin_Master_Fees_installment_pay_in_slip_admin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Print In Payslip</title>
    <script src="../../DesignJS/jquery.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        var installment_data = [];
        var trans_data = [];
        var installment_no = '';
        var today_date = '';

        $(document).ready(function () {
            var student = getParameterByName('student');
            var sem_code = getParameterByName('semester');
            var year_code = getParameterByName('year_code');
            installment_no = getParameterByName('installment_no');

            $('.cls_bank_img').attr('src', '../../image/icicibanglogo.png');

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_fees_installment_dtl_all",
                data: "{sem_code:'" + sem_code + "', year_code:'" + year_code + "'}",
                contentType: "application/json",
                async: false,
                cache: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        installment_data = JSON.parse(data.d);
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_online_payment_transaction_id",
                data: "{'student':'" + student + "','sem_code':'" + sem_code + "','year_code':'" + year_code + "'}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        trans_data = JSON.parse(data.d);
                    }
                    else {
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            var currentDate = new Date();
            var day = currentDate.getDate();
            var month = currentDate.getMonth() + 1;
            var year = currentDate.getFullYear();
            var today_date = day.toString().length == 1 ? '0' + day : day.toString() + ('00' + month).substring(1) + year.toString().substring(2);

            var add_yaer = currentDate.getFullYear() + 1;
            var res = add_yaer.toString().substring(2);

            createPaySlip();
        });

        function createPaySlip() {
            installment_data = $.grep(installment_data, function (data) { return data['is_installment' + installment_no + '_paid'] != 'Y' && data.cancel_flag == 'N' });

            for (var i = 0; i < installment_data.length; i++) {
                $('#div_temp_payslip').html($('#div_blank_payslip').html());

                var fees_data = installment_data[i];
                var user_id = fees_data["user_id"];

                var user_data = $.grep(trans_data, function (data) { return data.user_id == user_id });
                if (user_data.length > 0) {
                    $('#div_temp_payslip .cls_StudentName td:nth-child(3)').text(user_data[0]["user_name"].toLowerCase());

                    setCellData('cls_PAN_No', 'AAAJC0452C');
                    setCellData('cls_AccountToBeCredited', '0036SLFEECOL');
                    setCellData('cls_InstitutionName', user_data[0]["bank_code"]); //change for foreign student
                    setCellData('cls_Sem', user_data[0]["semester_code"]);
                    setCellData('cls_TransactionID', user_data[0]["payslip_number"]);
                    setCellData('cls_DateOfDeposit', today_date);

                    $('#div_temp_payslip .cls_account_name').text(user_data[0]["account_name"]);
                }

                if (fees_data["installment_status"] != 'Y' && fees_data["installment_status"] != 'N') {
                }
                else {
                    //$('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                    //$('.cls_no_of_installment').html(fees_data["no_of_installment"]);
                    //$('.cls_cur_installment').html(installment_no);
                    //$('.cls_cur_installment_amount').html(fees_data["installment" + installment_no]);

                    setCellData('cls_StudentCode', user_id);
                    $('#div_temp_payslip .cls_Amount td:nth-child(3)').text(fees_data["installment" + installment_no]);

                    var rupees = 'Rupees ' + convert_number(fees_data["installment" + installment_no]) + ' Only';

                    $('#div_temp_payslip .cls_AmountInWords td:nth-child(3)').html('');
                    for (var j = 0; j < rupees.length; j++) {
                        if (j != 0 && j % 43 == 0)
                            $('#div_temp_payslip .cls_AmountInWords td:nth-child(3)').append('<br/>');

                        $('#div_temp_payslip .cls_AmountInWords td:nth-child(3)').append(rupees[j]);
                    }
                }

                $('#div_payslip_all').append($('#div_temp_payslip').html());
                $('#div_temp_payslip').html('');
            }
        }

        function setCellData(trClass, cellValue) {
            for (var i = 0; i < cellValue.length; i++) {
                $('#div_temp_payslip .' + trClass + ' td:nth-child(' + (i + 3) + ')').html(cellValue[i]);
            }
        }

        function convert_number(number) {
            if ((number < 0) || (number > 999999999)) {
                return "Number is out of range";
            }

            var Gn = Math.floor(number / 10000000);  /* Crore */
            number -= Gn * 10000000;
            var kn = Math.floor(number / 100000);     /* lakhs */
            number -= kn * 100000;
            var Hn = Math.floor(number / 1000);      /* thousand */
            number -= Hn * 1000;
            var Dn = Math.floor(number / 100);       /* Tens (deca) */
            number = number % 100;               /* Ones */
            var tn = Math.floor(number / 10);
            var one = Math.floor(number % 10);
            var res = "";

            if (Gn > 0) {
                res += (convert_number(Gn) + " Crore");
            }
            if (kn > 0) {
                res += (((res == "") ? "" : " ") + convert_number(kn) + " Lakhs");
            }
            if (Hn > 0) {
                res += (((res == "") ? "" : " ") + convert_number(Hn) + " Thousand");
            }

            if (Dn) {
                res += (((res == "") ? "" : " ") + convert_number(Dn) + " hundred");
            }

            var ones = Array("", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eightteen", "Nineteen");
            var tens = Array("", "", "Twenty", "Thirty", "Fourty", "Fifty", "Sixty", "Seventy", "Eigthy", "Ninety");

            if (tn > 0 || one > 0) {
                if (!(res == "")) {
                    res += " and ";
                }
                if (tn < 2) {
                    res += ones[tn * 10 + one];
                }
                else {
                    res += tens[tn];
                    if (one > 0) {
                        res += ("-" + ones[one]);
                    }
                }
            }

            if (res == "") {
                res = "zero";
            }

            return res;
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
    </script>

    <style type="text/css">
        body
        {
            width: 20.05cm;
            margin: 0 auto;
            font-size: 14px;
            padding-top:20px;
            padding-left:17px;
        }
        
        .div_container
        {
            border: 1px solid black;
            height: 9.02cm;
        }
        
        .div_left
        {
            float: left;
            width: 58%;
        }
        
        .div_right
        {
            float: left;
            width: 41%;
            border-left: 1px solid black;
        }
        
        table tr td
        {
            border-left: 1px solid black;
            border-bottom: 1px solid black;
            min-width: 15px;
        }
        table tr td:first-child
        {
            border-left: 0px;
        }
        table tr td:last-child
        {
            border-right: 1px solid black;
        }
        
        .table_left tr td:nth-child(2)
        {
            border-bottom: 0px !important;
        }
        
        .table_left tr:last-child td:nth-child(2)
        {
            border-bottom: 1px solid black !important;
        }
        
        .table_left tr td
        {
            text-align: center;
        }
        
        .table_left tr td:first-child, .cls_StudentName td:nth-child(3), .cls_AmountInWords td:nth-child(3), .cls_Amount td:nth-child(3)
        {
            text-align: left;
        }
        
        .table_right tr td
        {
            font-size: 12px;
        }
        
        .table_right tr:first-child td,.table_right tr:nth-child(2) td
        {
            line-height:14px;
        }
        
        .bottom_zero
        {
            border-bottom: 0px !important;
        }
        
        .right_zero
        {
            border-right: 0px !important;
        }
        
        .font12
        {
            font-size: 12px !important;
        }
        
        .set_padding td
        {
            padding: 0 1px;
        }
        
        .marg_top
        {
            margin-top: 20px;
        }
        
        .cls_StudentName td:nth-child(3)
        {
            text-transform: capitalize;
            max-width: 280px;
        }
        
        <%--.cls_NameOfBranch td:nth-child(3),.cls_StudentName td:nth-child(3)
        {
            height:22px;
        }
        .cls_Amount td:nth-child(3)
        {
            height:19px;
        }--%>
    </style>
</head>

<body>
    <div id="div_payslip_all">

    </div>

    <div id="div_temp_payslip">

    </div>

    <div id="div_blank_payslip" style="display:none;">
        <div class="div_container">
            <div class="div_left">
                <%--<div style="text-align: center;border-bottom:1px solid black;">
                    Student / Applicant Copy
                </div>--%>

                <div style="border-bottom:1px solid black;">
                    <div style="float: left;">
                        <img style="margin-top: 5px;margin-left: 5px; width: 66%;" src="../../image/Capture.PNG" />
                    </div>

                    <div style="float: left;text-align:center;">
                        <div>
                            Student / Applicant Copy
                        </div>

                        <div>
                            CEPT University
                        </div>

                        <div>
                            Ahmedabad
                        </div>
                    </div>

                    <div style="float: right;">
                        <img style="margin-top: 5px; margin-right: 3px;" class="cls_bank_img" src="../../image/icicibanglogo.png" />
                    </div>
            
                    <div style="clear:both;"></div>
                </div>

                <div style="clear: both;">
                    <table class="table_left" cellspacing="0">
                        <tr class="cls_BranchSolId">
                            <td>Branch Sol Id</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="7"></td>
                        </tr>
                        <tr class="cls_NameOfBranch">
                            <td>Name of Branch</td>
                            <td></td>
                            <td colspan="12"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_DateOfDeposit">
                            <td>Date of Deposit</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="4"></td>
                        </tr>
                        <%--<tr>
                            <td class="right_zero" colspan="12" style="text-align:center;">DD/MM/YYYY</td>
                        </tr>--%>
                        <tr class="cls_PAN_No">
                            <td>PAN No. of Institution</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="2"></td>
                        </tr>
                        <tr class="cls_AccountToBeCredited">
                            <td>Account to be credited</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="border:0;border-left:1px solid black;"></td>
                            <td style="border:0;"></td>
                            <td style="border:0;"></td>
                            <td style="border:0;"></td>
                        </tr>
                        <tr class="cls_InstitutionName">
                            <td>1. Institution Name</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="10"></td>
                        </tr>
                        <tr class="cls_StudentName">
                            <td>2. Student Name</td>
                            <td></td>
                            <td colspan="16"></td>
                        </tr>
                        <tr class="cls_StudentCode">
                            <td>3. Roll No./Student Id</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_Sem">
                            <td>4. Class/Sem/Year</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_Course">
                            <td>5. Course /Section</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero"></td>
                        </tr>
                        <tr class="cls_Amount">
                            <td>6. Amount</td>
                            <td></td>
                            <td colspan="7"></td>
                            <td class="right_zero" colspan="9"></td>
                        </tr>
                        <tr class="cls_AmountInWords">
                            <td>7. Amount in words</td>
                            <td></td>
                            <td colspan="16" style="height:32px;"></td>
                        </tr>
                        <%--<tr>
                            <td></td>
                            <td></td>
                            <td colspan="16">_________________________________ Only</td>
                        </tr>--%>
                    </table>
                </div>
            </div>

            <div class="div_right">
                <div>
                    <table class="table_right" cellspacing="0">
                        <tr class="set_padding">
                            <td>8. Cash Details</td>
                            <td class="right_zero" colspan="8"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>Denomination</td>
                            <td colspan="8">Amount</td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>2000 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>500 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>200 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>100 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>50 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>20 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>10 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>5 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>Total</td>
                            <td colspan="8"></td>
                            <td colspan="2" class="right_zero"></td>
                        </tr>
                        <tr>
                            <td class="font12">Depositor Contact No.</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="1" class="font12">Cheque/Payorder/DD No</td>
                            <td colspan="4"></td>
                            <td colspan="6"></td>
                        </tr>
                        <tr>
                            <td class="font12">Payable At Branch</td>
                            <td colspan="10"></td>
                        </tr>
                        <tr class="set_padding">
                            <td colspan="2" class="font12">Transaction ID (Mandatorily filled by Bank Officials)</td>
                            <td colspan="9" class="cls_TransactionID"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height:34px;">&nbsp;</td>
                            <td colspan="9">&nbsp;</td>
                        </tr>
                        <tr class="set_padding">
                            <td colspan="2" style="text-align:center;">Signture / Stamp</td>
                            <td colspan="9" style="text-align:center;">Signature of Depositor</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div style="clear: both;font-size:11px;text-align:right;">
                * must be drawn payable at centre of deposit of the instrument (outstation instruments not acceptable)
            </div>
        </div>

        <div style="clear:both;"></div>
    
        <div class="div_container marg_top">
            <div class="div_left">
                <%--<div style="text-align: center;border-bottom:1px solid black;">
                    Student / Applicant Copy
                </div>--%>

                <div style="border-bottom:1px solid black;">
                    <div style="float: left;">
                        <img style="margin-top: 5px;margin-left: 5px; width: 66%;" src="../../image/Capture.PNG" />
                    </div>

                    <div style="float: left;text-align:center;">
                        <div>
                            Institution Copy
                        </div>

                        <div>
                            CEPT University
                        </div>

                        <div>
                            Ahmedabad
                        </div>
                    </div>

                    <div style="float: right;">
                        <img style="margin-top: 5px; margin-right: 3px;" class="cls_bank_img" src="../../image/icicibanglogo.png" />
                    </div>
            
                    <div style="clear:both;"></div>
                </div>

                <div style="clear: both;">
                    <table class="table_left" cellspacing="0">
                        <tr class="cls_BranchSolId">
                            <td>Branch Sol Id</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="7"></td>
                        </tr>
                        <tr class="cls_NameOfBranch">
                            <td>Name of Branch</td>
                            <td></td>
                            <td colspan="12"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_DateOfDeposit">
                            <td>Date of Deposit</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="4"></td>
                        </tr>
                        <%--<tr>
                            <td class="right_zero" colspan="12" style="text-align:center;">DD/MM/YYYY</td>
                        </tr>--%>
                        <tr class="cls_PAN_No">
                            <td>PAN No. of Institution</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="2"></td>
                        </tr>
                        <tr class="cls_AccountToBeCredited">
                            <td>Account to be credited</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="border:0;border-left:1px solid black;"></td>
                            <td style="border:0;"></td>
                            <td style="border:0;"></td>
                            <td style="border:0;"></td>
                        </tr>
                        <tr class="cls_InstitutionName">
                            <td>1. Institution Name</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="10"></td>
                        </tr>
                        <tr class="cls_StudentName">
                            <td>2. Student Name</td>
                            <td></td>
                            <td colspan="16"></td>
                        </tr>
                        <tr class="cls_StudentCode">
                            <td>3. Roll No./Student Id</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_Sem">
                            <td>4. Class/Sem/Year</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_Course">
                            <td>5. Course /Section</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero"></td>
                        </tr>
                        <tr class="cls_Amount">
                            <td>6. Amount</td>
                            <td></td>
                            <td colspan="7"></td>
                            <td class="right_zero" colspan="9"></td>
                        </tr>
                        <tr class="cls_AmountInWords">
                            <td>7. Amount in words</td>
                            <td></td>
                            <td colspan="16" style="height:32px;"></td>
                        </tr>
                        <%--<tr>
                            <td></td>
                            <td></td>
                            <td colspan="16">_________________________________ Only</td>
                        </tr>--%>
                    </table>
                </div>
            </div>

            <div class="div_right">
                <div>
                    <table class="table_right" cellspacing="0">
                        <tr class="set_padding">
                            <td>8. Cash Details</td>
                            <td class="right_zero" colspan="8"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>Denomination</td>
                            <td colspan="8">Amount</td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>2000 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>500 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>200 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>100 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>50 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>20 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>10 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>5 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>Total</td>
                            <td colspan="8"></td>
                            <td colspan="2" class="right_zero"></td>
                        </tr>
                        <tr>
                            <td class="font12">Depositor Contact No.</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="1" class="font12">Cheque/Payorder/DD No</td>
                            <td colspan="4"></td>
                            <td colspan="6"></td>
                        </tr>
                        <tr>
                            <td class="font12">Payable At Branch</td>
                            <td colspan="10"></td>
                        </tr>
                        <tr class="set_padding">
                            <td colspan="2" class="font12">Transaction ID (Mandatorily filled by Bank Officials)</td>
                            <td colspan="9" class="cls_TransactionID"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height:34px;">&nbsp;</td>
                            <td colspan="9">&nbsp;</td>
                        </tr>
                        <tr class="set_padding">
                            <td colspan="2" style="text-align:center;">Signture / Stamp</td>
                            <td colspan="9" style="text-align:center;">Signature of Depositor</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div style="clear: both;font-size:11px;text-align:right;">
                * must be drawn payable at centre of deposit of the instrument (outstation instruments not acceptable)
            </div>
        </div>
    
        <div style="clear:both;"></div>
    
        <div class="div_container marg_top">
            <div class="div_left">
                <%--<div style="text-align: center;border-bottom:1px solid black;">
                    Student / Applicant Copy
                </div>--%>

                <div style="border-bottom:1px solid black;">
                    <div style="float: left;">
                        <img style="margin-top: 5px;margin-left: 5px; width: 66%;" src="../../image/Capture.PNG" />
                    </div>

                    <div style="float: left;text-align:center;">
                        <div>
                            Bank Copy
                        </div>

                        <div>
                            CEPT University
                        </div>

                        <div>
                            Ahmedabad
                        </div>
                    </div>

                    <div style="float: right;">
                        <img style="margin-top: 5px; margin-right: 3px;" class="cls_bank_img" src="../../image/icicibanglogo.png" />
                    </div>
            
                    <div style="clear:both;"></div>
                </div>

                <div style="clear: both;">
                    <table class="table_left" cellspacing="0">
                        <tr class="cls_BranchSolId">
                            <td>Branch Sol Id</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="7"></td>
                        </tr>
                        <tr class="cls_NameOfBranch">
                            <td>Name of Branch</td>
                            <td></td>
                            <td colspan="12"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_DateOfDeposit">
                            <td>Date of Deposit</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="4"></td>
                        </tr>
                        <%--<tr>
                            <td class="right_zero" colspan="12" style="text-align:center;">DD/MM/YYYY</td>
                        </tr>--%>
                        <tr class="cls_PAN_No">
                            <td>PAN No. of Institution</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="2"></td>
                        </tr>
                        <tr class="cls_AccountToBeCredited">
                            <td>Account to be credited</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td style="border:0;border-left:1px solid black;"></td>
                            <td style="border:0;"></td>
                            <td style="border:0;"></td>
                            <td style="border:0;"></td>
                        </tr>
                        <tr class="cls_InstitutionName">
                            <td>1. Institution Name</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero" colspan="10"></td>
                        </tr>
                        <tr class="cls_StudentName">
                            <td>2. Student Name</td>
                            <td></td>
                            <td colspan="16"></td>
                        </tr>
                        <tr class="cls_StudentCode">
                            <td>3. Roll No./Student Id</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_Sem">
                            <td>4. Class/Sem/Year</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="cls_Course">
                            <td>5. Course /Section</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="right_zero"></td>
                        </tr>
                        <tr class="cls_Amount">
                            <td>6. Amount</td>
                            <td></td>
                            <td colspan="7"></td>
                            <td class="right_zero" colspan="9"></td>
                        </tr>
                        <tr class="cls_AmountInWords">
                            <td>7. Amount in words</td>
                            <td></td>
                            <td colspan="16" style="height:32px;"></td>
                        </tr>
                        <%--<tr>
                            <td></td>
                            <td></td>
                            <td colspan="16">_________________________________ Only</td>
                        </tr>--%>
                    </table>
                </div>
            </div>

            <div class="div_right">
                <div>
                    <table class="table_right" cellspacing="0">
                        <tr class="set_padding">
                            <td>8. Cash Details</td>
                            <td class="right_zero" colspan="8"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>Denomination</td>
                            <td colspan="8">Amount</td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>2000 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>500 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>200 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>100 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>50 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>20 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>10 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>5 X </td>
                            <td colspan="8"></td>
                            <td class="bottom_zero right_zero"></td>
                        </tr>
                        <tr class="set_padding">
                            <td>Total</td>
                            <td colspan="8"></td>
                            <td colspan="2" class="right_zero"></td>
                        </tr>
                        <tr>
                            <td class="font12">Depositor Contact No.</td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="1" class="font12">Cheque/Payorder/DD No</td>
                            <td colspan="4"></td>
                            <td colspan="6"></td>
                        </tr>
                        <tr>
                            <td class="font12">Payable At Branch</td>
                            <td colspan="10"></td>
                        </tr>
                        <tr class="set_padding">
                            <td colspan="2" class="font12">Transaction ID (Mandatorily filled by Bank Officials)</td>
                            <td colspan="9" class="cls_TransactionID"></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height:34px;">&nbsp;</td>
                            <td colspan="9">&nbsp;</td>
                        </tr>
                        <tr class="set_padding">
                            <td colspan="2" style="text-align:center;">Signture / Stamp</td>
                            <td colspan="9" style="text-align:center;">Signature of Depositor</td>
                        </tr>
                    </table>
                </div>
            </div>

            <div style="clear: both;font-size:11px;text-align:right;">
                * must be drawn payable at centre of deposit of the instrument (outstation instruments not acceptable)
            </div>
        </div>

        <div style='page-break-after: always;'></div>
    </div>
</body>
</html>
