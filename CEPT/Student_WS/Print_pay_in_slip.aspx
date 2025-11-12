<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print_pay_in_slip.aspx.cs"
    Inherits="Student_Print_pay_in_slip" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <script src="../DesignJS/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var user_data;
        var waiver_installmant_data = '';
        $(document).ready(function () {
            //var today = new Date();
            //var dd = today.getDate();
            //var mm = today.getMonth() + 1; //January is 0!

            //var yyyy = today.getFullYear();
            //if (dd < 10) { dd = '0' + dd } if (mm < 10) { mm = '0' + mm } today = mm + '/' + dd + '/' + yyyy;

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_user_data_for_pay_slip",
                data: "{}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        user_data = JSON.parse(data.d);

                        $('#lblstudentname1').text(user_data[0]["full_name"]);
                        $('#lblstudentname2').text(user_data[0]["full_name"]);
                        $('#lblstudentname3').text(user_data[0]["full_name"]);

                        $('#lblstudent1').text(user_data[0]["student_no"]);
                        $('#lblstudent2').text(user_data[0]["student_no"]);
                        $('#lblstudent3').text(user_data[0]["student_no"]);

                        $('#lbldescription1').text('CEPT University');
                        $('#lbldescription2').text('CEPT University');
                        $('#lbldescription3').text('CEPT University');

                        $('#lbl_drawn1').text('CEPT University');
                        $('#lbl_drawn2').text('CEPT University');
                        $('#lbl_drawn3').text('CEPT University');

                        $('#lblcode1').text('FCCUVY');
                        $('#lblcode2').text('FCCUVY');
                        $('#lblcode3').text('FCCUVY');

                        $('#lblbranch1').text(user_data[0]["dept_name"]);
                        $('#lblbranch2').text(user_data[0]["dept_name"]);
                        $('#lblbranch3').text(user_data[0]["dept_name"]);
                    }
                    else {

                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_fees_status",
                data: "{}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        waiver_installmant_data = JSON.parse(data.d);
                    }
                    else {

                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_ws_credit_choice",
                data: {},
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        fees_status = JSON.parse(data.d);

                        if (fees_status[0]["credit_choice"] != '') {
                            if (fees_status[0]["credit_choice"] > 12) {

                            }
                            else {
                                if (waiver_installmant_data != '') {
                                    if (waiver_installmant_data[0]["fees_type"] == "F") {
                                        if (waiver_installmant_data[0]["installmant_status"] == "Y") {
                                            $('#lblamount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);
                                            $('#lblamount2').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);
                                            $('#lblamount3').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);

                                            $('#lbltot_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);
                                            $('#lbltot_amount2').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);
                                            $('#lbltot_amount3').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);

                                            var rupees = convert_number(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000) / 2);

                                            $('#lbltotalrs1').text(rupees + ' ' + 'Only');
                                            $('#lbltotalrs2').text(rupees + ' ' + 'Only');
                                            $('#lbltotalrs3').text(rupees + ' ' + 'Only');
                                        }
                                        else {
                                            if (waiver_installmant_data[0]["waiver_credits"] != '') {
                                                $('#lblamount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));
                                                $('#lblamount2').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));
                                                $('#lblamount3').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));

                                                $('#lbltot_amount1').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));
                                                $('#lbltot_amount2').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));
                                                $('#lbltot_amount3').text(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));

                                                var rupees = convert_number(((parseInt(fees_status[0]["credit_choice"]) - parseInt(waiver_installmant_data[0]["waiver_credits"])) * 4000));

                                                $('#lbltotalrs1').text(rupees + ' ' + 'Only');
                                                $('#lbltotalrs2').text(rupees + ' ' + 'Only');
                                                $('#lbltotalrs3').text(rupees + ' ' + 'Only');
                                            }
                                            else {
                                                $('#lblamount1').text(fees_status[0]["credit_choice"] * 4000);
                                                $('#lblamount2').text(fees_status[0]["credit_choice"] * 4000);
                                                $('#lblamount3').text(fees_status[0]["credit_choice"] * 4000);

                                                $('#lbltot_amount1').text(fees_status[0]["credit_choice"] * 4000);
                                                $('#lbltot_amount2').text(fees_status[0]["credit_choice"] * 4000);
                                                $('#lbltot_amount3').text(fees_status[0]["credit_choice"] * 4000);

                                                var rupees = convert_number(fees_status[0]["credit_choice"] * 4000);

                                                $('#lbltotalrs1').text(rupees + ' ' + 'Only');
                                                $('#lbltotalrs2').text(rupees + ' ' + 'Only');
                                                $('#lbltotalrs3').text(rupees + ' ' + 'Only');
                                            }
                                        }
                                    }
                                    else {
                                        if (waiver_installmant_data[0]["fees_type"] == "I") {
                                            $('#lblamount1').text((fees_status[0]["credit_choice"] * 4000) / 4);
                                            $('#lblamount2').text((fees_status[0]["credit_choice"] * 4000) / 4);
                                            $('#lblamount3').text((fees_status[0]["credit_choice"] * 4000) / 4);

                                            $('#lbltot_amount1').text((fees_status[0]["credit_choice"] * 4000) / 4);
                                            $('#lbltot_amount2').text((fees_status[0]["credit_choice"] * 4000) / 4);
                                            $('#lbltot_amount3').text((fees_status[0]["credit_choice"] * 4000) / 4);

                                            var rupees = convert_number((fees_status[0]["credit_choice"] * 4000) / 4);

                                            $('#lbltotalrs1').text(rupees + ' ' + 'Only');
                                            $('#lbltotalrs2').text(rupees + ' ' + 'Only');
                                            $('#lbltotalrs3').text(rupees + ' ' + 'Only');
                                        }
                                        else {
                                            $('#lblamount1').text(fees_status[0]["credit_choice"] * 4000);
                                            $('#lblamount2').text(fees_status[0]["credit_choice"] * 4000);
                                            $('#lblamount3').text(fees_status[0]["credit_choice"] * 4000);

                                            $('#lbltot_amount1').text(fees_status[0]["credit_choice"] * 4000);
                                            $('#lbltot_amount2').text(fees_status[0]["credit_choice"] * 4000);
                                            $('#lbltot_amount3').text(fees_status[0]["credit_choice"] * 4000);

                                            var rupees = convert_number(fees_status[0]["credit_choice"] * 4000);

                                            $('#lbltotalrs1').text(rupees + ' ' + 'Only');
                                            $('#lbltotalrs2').text(rupees + ' ' + 'Only');
                                            $('#lbltotalrs3').text(rupees + ' ' + 'Only');
                                        }
                                    }
                                }
                                else {
                                    $('#lblamount1').text(fees_status[0]["credit_choice"] * 4000);
                                    $('#lblamount2').text(fees_status[0]["credit_choice"] * 4000);
                                    $('#lblamount3').text(fees_status[0]["credit_choice"] * 4000);

                                    $('#lbltot_amount1').text(fees_status[0]["credit_choice"] * 4000);
                                    $('#lbltot_amount2').text(fees_status[0]["credit_choice"] * 4000);
                                    $('#lbltot_amount3').text(fees_status[0]["credit_choice"] * 4000);

                                    var rupees = convert_number(fees_status[0]["credit_choice"] * 4000);

                                    $('#lbltotalrs1').text(rupees + ' ' + 'Only');
                                    $('#lbltotalrs2').text(rupees + ' ' + 'Only');
                                    $('#lbltotalrs3').text(rupees + ' ' + 'Only');
                                }
                            }
                        }
                    }
                    else {

                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            var currentDate = new Date()
            var day = currentDate.getDate()
            var month = currentDate.getMonth() + 1
            var year = currentDate.getFullYear()

            var today_date = day + "/" + month + "/" + year;

            $('#lbldate1').text(today_date);
            $('#lbldate2').text(today_date);
            $('#lbldate3').text(today_date);

            var add_yaer = currentDate.getFullYear() + 1;

            var res = add_yaer.toString().substring(2)

            $('#lblyear1').text(year + ' - ' + res);
            $('#lblyear2').text(year + ' - ' + res);
            $('#lblyear3').text(year + ' - ' + res);

            //var characters = add_yaer[add_yaer.length - 1];

            window.print();
        });

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
                res += (((res == "") ? "" : " ") +
            convert_number(kn) + " Lakhs");
            }
            if (Hn > 0) {
                res += (((res == "") ? "" : " ") +
            convert_number(Hn) + " Thousand");
            }

            if (Dn) {
                res += (((res == "") ? "" : " ") +
            convert_number(Dn) + " hundred");
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

    </script>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            padding: 1px 4px;
            width: 1035px;
            height: 646px;
            border-right-style: solid;
            border-right-width: 0px;
        }
        .style11
        {
        }
        .style20
        {
            width: 295px;
        }
        .style21
        {
            width: 214px;
        }
        .style38
        {
        }
        .style41
        {
            font-size: medium;
            font-weight: bold;
        }
        .style46
        {
            font-size: medium;
        }
        .style56
        {
            padding: 1px 4px;
            width: 370px;
            border-right-style: solid;
            border-right-width: 1px;
        }
        .style58
        {
            width: 264px;
        }
        .style59
        {
            font-size: medium;
            font-weight: bold;
            width: 167px;
        }
        .style60
        {
            height: 16px;
        }
    </style>
</head>
<body style="height: 649px; width: 1095px; font-size: large;">
    <table class="style2">
        <tr>
            <td class="style56">
                <div style="width: 353px; height: 624px; background-color: #FFFFFF;">
                    <table class="style1">
                        <tr>
                            <td colspan="6">
                                ICICI BANK PAYSLIP FOR FEES
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" class="style20">
                                <img style="margin-top: 7px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />
                            </td>
                            <td style="text-align: center" class="style41">
                                <strong>CEPT UNIVERSITY<br />
                                    &nbsp;AHMEDABAD </strong>
                            </td>
                            <td style="text-align: center" class="style21">
                                <img style="margin-top: 7px" src="<%= Page.ResolveClientUrl("~/image/icici.jpg") %>" />
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="3">
                                <strong>Date</strong>:
                                <label id="lbldate1">
                                </label>
                            </td>
                            <td colspan="3">
                                <strong>Branch</strong> :
                                <label id="lblbranch1">
                                    Arch</label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                S<strong>tudent Code:</strong>
                                <label id="lblstudent1">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <strong>Student name :</strong> <b>
                                    <label id="lblstudentname1" style="white-space: normal">
                                    </label>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <strong>Year : </strong>
                                <label id="lblyear1">
                                </label>
                            </td>
                        </tr>
                        <%--   <tr>
                            <td colspan="6">
                                <strong>Semester :</strong><label id="lblSemester1"></label>
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="6" style="text-align: left" class="style41">
                                <strong>FEES / CHARGES : </strong>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr style="border-style: solid; border-width: 1px;">
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>Description: </strong>
                            </td>
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>CodeNo</strong>
                            </td>
                            <%--   <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>A/C.No</strong>
                            </td>--%>
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>Amount</strong>
                            </td>
                        </tr>
                        <tr>
                            <td height="50" style="border: thin solid #000000;">
                                <b>
                                    <label id="lbldescription1" style="word-spacing: inherit; font-size: smaller">
                                    </label>
                                </b>
                            </td>
                            <td height="50" style="border: thin solid #000000;">
                                <b>
                                    <label id="lblcode1" style="font-size: medium">
                                    </label>
                                </b>
                            </td>
                            <%-- <td height="50" style="border: thin solid #000000;">
                                <label id="lblacountNo1" style="font-size: smaller">
                                </label>
                                <label id="Label9" style="font-size: smaller">
                                </label>
                            </td>--%>
                            <td align="right" style="border: thin solid #000000;" height="50">
                                <label id="lblamount1">
                                </label>
                                <label id="Label10">
                                </label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="1" align="right" class="style58">
                                <strong>Total Amount :</strong>
                            </td>
                            <td align="right" colspan="5">
                                <label id="lbltot_amount1">
                                </label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="6" class="style41">
                                <b>Total Rs :</b>
                                <label id="lbltotalrs1">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="style41">
                                <strong>By Cash/Draft :</strong><label id="lbldraft1"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="style60">
                                <strong><span class="style46">Drawn in favour of :</span></strong>
                            </td>
                            <td class="style60">
                                <label style="word-spacing: inherit; font-size: smaller" id="lbl_drawn1">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="style60">
                                <strong><span class="style46"></span></strong>
                            </td>
                            <td class="style60">
                                (Payable Localy)
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="style41" height="30">
                                <strong>Sign of Depositer :</strong>
                            </td>
                        </tr>
                        <tr>
                            <td class="style59" style="text-align: left" id="lbl" colspan="1" align="justify">
                                Bank Seal and Sign
                                <br />
                            </td>
                            <td style="border-style: solid; border-width: 1px; padding: 1px 4px; text-align: left"
                                id="Td3" class="style41" colspan="4" align="justify">
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" rowspan="2" class="style41" height="30">
                                This Pay Slip Valid Upto<label id="Label1"></label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td style="text-align: center" id="Td9" class="style11">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" id="Td10" class="style11">
                                <strong>Banker Copy </strong>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td class="style56">
                <div style="width: 353px; height: 623px; background-color: #FFFFFF;">
                    <table class="style1">
                        <tr>
                            <td colspan="6">
                                ICICI BANK PAYSLIP FOR FEES
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" class="style20">
                                <img style="margin-top: 7px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />
                            </td>
                            <td style="text-align: center" class="style41">
                                <strong>CEPT UNIVERSITY<br />
                                    &nbsp;AHMEDABAD </strong>
                            </td>
                            <td style="text-align: center" class="style21">
                                <img style="margin-top: 7px" src="<%= Page.ResolveClientUrl("~/image/icici.jpg") %>" />
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="3">
                                <strong>Date</strong>:
                                <label id="lbldate2">
                                </label>
                            </td>
                            <td colspan="3">
                                <strong>Branch</strong>:
                                <label id="lblbranch2">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                S<strong>tudent Code :</strong>
                                <label id="lblstudent2">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <strong>Student name:</strong> <b>
                                    <label id="lblstudentname2">
                                    </label>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <strong>Year : </strong>
                                <label id="lblyear2">
                                </label>
                            </td>
                        </tr>
                        <%--  <tr>
                            <td colspan="6">
                                <strong>Semester :</strong>
                                <label id="lblSemester2">
                                </label>
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="6" class="style41">
                                <strong>FEES / CHARGES : </strong>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr style="border-style: solid; border-width: 1px;">
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>Description: </strong>
                            </td>
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>CodeNo</strong>
                            </td>
                            <%-- <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>A/C.No</strong>
                            </td>--%>
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>Amount</strong>
                            </td>
                        </tr>
                        <tr>
                            <td height="50" style="border: thin solid #000000;">
                                <b>
                                    <label id="lbldescription2" style="word-spacing: inherit; font-size: smaller">
                                    </label>
                                </b>
                                <label id="Label4" style="word-spacing: inherit; font-size: smaller">
                                </label>
                            </td>
                            <td height="50" style="border: thin solid #000000;">
                                <b>
                                    <label id="lblcode2" style="font-size: smaller">
                                    </label>
                                </b>
                                <label id="Label11" style="font-size: smaller">
                                </label>
                            </td>
                            <%-- <td height="50" style="border: thin solid #000000;">
                                <label id="Label12" style="font-size: smaller">
                                </label>
                                <label id="Label13" style="font-size: smaller">
                                </label>
                            </td>--%>
                            <td align="right" style="border: thin solid #000000;" height="50">
                                <label id="lblamount2">
                                </label>
                                <label id="Label16">
                                </label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="1" align="right" class="style58">
                                <strong>Total Amount :</strong>
                            </td>
                            <td align="right" colspan="5">
                                <label id="lbltot_amount2">
                                </label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="6" class="style41">
                                <b>Total Rs :</b>
                                <label id="lbltotalrs2">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="style41">
                                <strong>By Cash/Draft :</strong><label id="Label19"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <strong><span class="style46">Drawn in favour of :</span></strong>
                            </td>
                            <td class="style60">
                                <label style="word-spacing: inherit; font-size: smaller" id="lbl_drawn2">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="style60">
                                <strong><span class="style46"></span></strong>
                            </td>
                            <td class="style60">
                                (Payable Localy)
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="style41" height="30">
                                <strong>Sign of Depositer :</strong>
                            </td>
                        </tr>
                        <tr>
                            <td class="style59" style="text-align: left" id="Td1" colspan="1" align="justify">
                                Bank Seal and Sign
                                <br />
                            </td>
                            <td style="border-style: solid; border-width: 1px; padding: 1px 4px; text-align: left"
                                colspan="4" id="Td4" class="style41" align="justify">
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                           <td colspan="6" rowspan="2" class="style41" height="30">
                                This Pay Slip Valid Upto<label id="Label2"></label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td style="text-align: center" id="Td7" class="style11">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" id="Td8" class="style11">
                                <strong>Institution Copy </strong>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td class="style56">
                <div style="width: 353px; height: 626px; background-color: #FFFFFF;">
                    <table class="style1">
                        <tr>
                            <td colspan="6">
                                ICICI BANK PAYSLIP FOR FEES
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" class="style20">
                                <img style="margin-top: 7px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />
                            </td>
                            <td style="text-align: center" class="style41">
                                <strong>CEPT UNIVERSITY<br />
                                    &nbsp;AHMEDABAD </strong>
                            </td>
                            <td style="text-align: center" class="style21">
                                <img style="margin-top: 7px" src="<%= Page.ResolveClientUrl("~/image/icici.jpg") %>" />
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="3">
                                <strong>Date</strong>:
                                <label id="lbldate3">
                                </label>
                            </td>
                            <td>
                                <strong>Branch</strong>:
                                <label id="lblbranch3">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                S<strong>tudent Code :</strong>
                                <label id="lblstudent3">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <strong>Student name :</strong> <b>
                                    <label id="lblstudentname3">
                                    </label>
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                <strong>Year : </strong>
                                <label id="lblyear3">
                                </label>
                            </td>
                        </tr>
                        <%--  <tr>
                            <td colspan="6">
                                <strong>Semester :</strong>
                                <label id="lblSemester3">
                                </label>
                            </td>
                        </tr>--%>
                        <tr>
                            <td colspan="6" style="text-align: left" class="style38">
                                <strong>FEES / CHARGES :</strong>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr style="border-style: solid; border-width: 1px;">
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>Description: </strong>
                            </td>
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>CodeNo</strong>
                            </td>
                            <%--  <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>A/C.No</strong>
                            </td>--%>
                            <td colspan="1.5" class="style41" style="border: thin solid #000000;">
                                <strong>Amount</strong>
                            </td>
                        </tr>
                        <tr>
                            <td height="50" style="border: thin solid #000000;">
                                <b>
                                    <label id="lbldescription3" style="word-spacing: inherit; font-size: smaller">
                                    </label>
                                </b>
                                <label id="Label5" style="word-spacing: inherit; font-size: smaller">
                                </label>
                            </td>
                            <td height="50" style="border: thin solid #000000;">
                                <b>
                                    <label id="lblcode3" style="font-size: smaller">
                                    </label>
                                </b>
                                <label id="Label21" style="font-size: smaller">
                                </label>
                            </td>
                            <%--  <td height="50" style="border: thin solid #000000;">
                                <label id="Label22" style="font-size: smaller">
                                </label>
                                <label id="Label23" style="font-size: smaller">
                                </label>
                            </td>--%>
                            <td align="right" style="border: thin solid #000000;" height="50">
                                <label id="lblamount3">
                                </label>
                                <label id="Label25">
                                </label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="1" align="right" class="style58">
                                <strong>Total Amount :</strong>
                            </td>
                            <td align="right" colspan="5">
                                <label id="lbltot_amount3">
                                </label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td colspan="6" class="style41">
                                <b>Total Rs :</b>
                                <label id="lbltotalrs3">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="style41">
                                <strong>By Cash/Draft :</strong><label id="Label28"></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <strong><span class="style46">Drawn in favour of :</span></strong>
                            </td>
                            <td>
                                <label style="word-spacing: inherit; font-size: smaller" id="lbl_drawn3">
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="style60">
                                <strong><span class="style46"></span></strong>
                            </td>
                            <td class="style60">
                                (Payable Localy)
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="style41" height="30">
                                <strong>Sign of Depositer :</strong>
                            </td>
                        </tr>
                        <tr>
                            <td class="style59" style="text-align: left" id="Td2" colspan="1" align="justify">
                                Bank Seal and Sign
                                <br />
                            </td>
                            <td style="border-style: solid; border-width: 1px; padding: 1px 4px; text-align: left"
                                id="Td5" class="style41" colspan="4" align="justify">
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" rowspan="2" class="style41" height="30">
                                This Pay Slip Valid Upto<label id="Label29"></label>
                            </td>
                        </tr>
                    </table>
                    <table class="style1">
                        <tr>
                            <td style="text-align: center" id="Td17" class="style11">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center" id="Td18" class="style11">
                                <strong>Student Copy </strong>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>
