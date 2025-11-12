<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print_pay_in_slip_new1.aspx.cs"
    Inherits="Student_Print_pay_in_slip_new1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .firstcolumn
        {
            width: 12.5%;
        }
        .secondcolumn
        {
            width: 10%;
        }
        .thirdcolumn
        {
            width: 10%;
        }
        .border
        {
        	border-left:1px dotted black;
        }
        body
        {
            font-size: 11px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table class="style1">
            <tr>
                <td colspan="3">
                    Student/Applicant copy
                </td>
                <td colspan="3">
                    Student/Applicant copy
                </td>
                <td colspan="3">
                    Student/Applicant copy
                </td>
            </tr>
            <tr>
                <td class="firstcolumn">
                    <img height="30px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />
                </td>
                <td class="secondcolumn" style="font-size: 8px;">
                    CEPT UNIVERSITY</br>Ahmedabad
                </td>
                <td class="thirdcolumn">
                    <img width="75px" height="30px" src="<%= Page.ResolveClientUrl("~/image/icicibanglogo.png") %>" />
                </td>
                <td class="firstcolumn">
                    <img height="30px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />
                </td>
                <td class="secondcolumn" style="font-size: 8px;">
                    CEPT UNIVERSITY</br>Ahmedabad
                </td>
                <td class="thirdcolumn">
                    <img width="75px" height="30px" src="<%= Page.ResolveClientUrl("~/image/icicibanglogo.png") %>" />
                </td>
                <td class="firstcolumn">
                    <img height="30px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />
                </td>
                <td class="secondcolumn" style="font-size: 8px;">
                    CEPT UNIVERSITY</br>Ahmedabad
                </td>
                <td class="thirdcolumn">
                    <img width="75px" height="30px" src="<%= Page.ResolveClientUrl("~/image/icicibanglogo.png") %>" />
                </td>
            </tr>
            <tr>
                <td class="firstcolumn border">
                    Branch Sol Id
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td class="firstcolumn border">
                    Branch Sol Id
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td class="firstcolumn border">
                    Branch Sol Id
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="firstcolumn">
                    Name of Branch
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Name of Branch
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Name of Branch
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Date of Deposit
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Date of Deposit
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Date of Deposit
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    PAN No. of Institution
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    PAN No. of Institution
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    PAN No. of Institution
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Account to be credited
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Account to be credited
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Account to be credited
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    1. Institution Name
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    1. Institution Name
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    1. Institution Name
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    2.Student Name<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    2.Student Name<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    2.Student Name<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    3. Roll No./Student Id
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    3. Roll No./Student Id
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    3. Roll No./Student Id
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    4. Class/Sem/Year
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    4. Class/Sem/Year
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    4. Class/Sem/Year
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    5. Course /Section
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    5. Course /Section
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    5. Course /Section
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    6. Amount
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    6. Amount
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    6. Amount
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    7. Amount in words
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    7. Amount in words
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    7. Amount in words
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    8. Cash Details:
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    8. Cash Details:
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    8. Cash Details:
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Denomination
                </td>
                <td>
                    Amount
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    Denomination
                </td>
                <td>
                    Amount
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    Denomination
                </td>
                <td>
                    Amount
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    1000 X<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    1000 X<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    1000 X<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    500<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;<span
                            class="Apple-converted-space">&nbsp;<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman';
                                font-size: 14.44444465637207px; font-style: normal; font-variant: normal; font-weight: bold;
                                letter-spacing: normal; line-height: normal; orphans: auto; text-align: start;
                                text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px;
                                -webkit-text-stroke-width: 0px; display: inline !important; float: none;">X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    500 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    500<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;<span
                            class="Apple-converted-space">&nbsp;<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman';
                                font-size: 14.44444465637207px; font-style: normal; font-variant: normal; font-weight: bold;
                                letter-spacing: normal; line-height: normal; orphans: auto; text-align: start;
                                text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px;
                                -webkit-text-stroke-width: 0px; display: inline !important; float: none;">X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    100 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    100 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    100 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    50<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;<span
                            class="Apple-converted-space">&nbsp;<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman';
                                font-size: 14.44444465637207px; font-style: normal; font-variant: normal; font-weight: bold;
                                letter-spacing: normal; line-height: normal; orphans: auto; text-align: start;
                                text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px;
                                -webkit-text-stroke-width: 0px; display: inline !important; float: none;">X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    50<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;<span
                            class="Apple-converted-space">&nbsp;<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman';
                                font-size: 14.44444465637207px; font-style: normal; font-variant: normal; font-weight: bold;
                                letter-spacing: normal; line-height: normal; orphans: auto; text-align: start;
                                text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px;
                                -webkit-text-stroke-width: 0px; display: inline !important; float: none;">X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    50<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman'; font-size: 14.44444465637207px;
                        font-style: normal; font-variant: normal; font-weight: bold; letter-spacing: normal;
                        line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;
                        white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;">&nbsp;<span
                            class="Apple-converted-space">&nbsp;<span style="color: rgb(0, 0, 0); font-family: 'Times New Roman';
                                font-size: 14.44444465637207px; font-style: normal; font-variant: normal; font-weight: bold;
                                letter-spacing: normal; line-height: normal; orphans: auto; text-align: start;
                                text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px;
                                -webkit-text-stroke-width: 0px; display: inline !important; float: none;">X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    20 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    20 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    20 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    10 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    10 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    10 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    5 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    5 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    5 X
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Total
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    Total
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    Total
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    9.Depositor Contact No.
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    9.Depositor Contact No.
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    9.Depositor Contact No.
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Cheque / Payorder / DD No.
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Cheque / Payorder / DD No.
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Cheque / Payorder / DD No.
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Payable At Branch:
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Payable At Branch:
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Payable At Branch:
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Transaction ID (Mandatorily filled by Bank Officials)
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Transaction ID (Mandatorily filled by Bank Officials)
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Transaction ID (Mandatorily filled by Bank Officials)
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    Signature/ Stamp
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Signature/ Stamp
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    Signature/ Stamp
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    ICICI Bank Ltd
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    ICICI Bank Ltd
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
                <td>
                    ICICI Bank Ltd
                </td>
                <td colspan="2">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    * must be drawn payable at the centre of deposit of the instrument i.e. outstation
                    instruments not acceptable
                </td>
                <td colspan="3">
                    * must be drawn payable at the centre of deposit of the instrument i.e. outstation
                    instruments not acceptable
                </td>
                <td colspan="3">
                    * must be drawn payable at the centre of deposit of the instrument i.e. outstation
                    instruments not acceptable
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
