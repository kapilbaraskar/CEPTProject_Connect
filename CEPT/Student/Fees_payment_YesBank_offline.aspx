<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Fees_payment_YesBank_offline.aspx.cs"
    Inherits="Student_Fees_payment_YesBank_offline" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>

        <style type="text/css">
            table th,table td
            {
                border-bottom:1px solid #ddd;
                border-right:1px solid #ddd;
                border-left:1px solid #ddd;
            }

           .new_font
           {
            font-family: Inconsolata;
           }
           
           @font-face {
            font-family: 'Inconsolata';
            src: url('../font/Inconsolata-Regular.ttf');
           }
        </style>
    </head>

    <body class="container">
        <div>
            <p>Student opting to make payment through NEFT / RTGS can use YES BANK option and use below YES BANK tutorial:</p>
            <b>Date : <asp:Label ID="lbl_generated_date" runat="server" ClientIDMode="Static"></asp:Label></b>
            <p style="font-size:18px;padding-top:6px;padding-bottom:6px;"><b runat="server" clientidmode="Static" id="payable_amount"></b></p>

            <table class="table table-condensed" border="1">
                <tr>
                    <th>
                        Bank Name
                    </th>
                    <td>
                        YES BANK
                    </td>
                </tr>
                <tr>
                    <th>
                        Beneficiary Name
                    </th>
                    <td>
                        CEPT UNIVERSITY
                    </td>
                </tr>
                <tr>
                    <th>
                        Beneficiary Account Number
                    </th>
                    <td>
                        <label id="acc_no" runat="server" style="display:inline-block;font-size: 17px !important;"  class="new_font"></label>
                        <%--<span>(last <label id="digit" runat="server" style="display:inline-block;"></label> digits are your student code)</span>--%>
                    </td>
                </tr>
                <tr>
                    <th style="border-right:none;"></th>
                    <td style="border-left:none;">(last <label id="digit" runat="server" style="display: inline;"></label> digits are your student code)</td>
                </tr>
                <tr>
                    <th>
                        Branch Name
                    </th>
                    <td>
                        CMS NOC MMR
                    </td>
                </tr>
                <tr>
                    <th>
                        Branch Code
                    </th>
                    <td>
                        Last six characters of IFSC Code represent Branch code
                    </td>
                </tr>
                <tr>
                    <th>
                        Branch Address
                    </th>
                    <td>
                        YES BANK TOWER IFC-2 8TH FLOOR SB MARG ELPHINSTONE MUMBAI 400013
                    </td>
                </tr>
                <tr>
                    <th>
                        Account Type
                    </th>
                    <td>
                        SAVING
                    </td>
                </tr>
                <tr>
                    <th>
                        IFSC Code
                    </th>
                    <th class="new_font" style="font-size: 17px !important;">
                        YESB0CMSNOC
                    </th>
                </tr>
                <tr>
                    <th style="border-right:none;"></th>
                    <td style="border-left:none;"><b>Read the 5th digit as numeric “Zero” and 10th digit as alpha “O”</b></td>
                </tr>
            </table>
            <ul>
                <li><b>Go to your bankbranch and Ask for NEFT form</b></li>
                <li><b>Fill in the beneficiary and IFSC Code above details, along with other details
                    as required by your bank.</b></li>
                <li><b>Depending upon your bank’s policy, you will be required to give cheque from your
                    account.Your bank may collect additional charges that will be additional.</b></li>
                <li><b>Once your payment is successfully credited in CEPT’s bank account, you will receive
                    an email confirming your admission from donotreply@cept.ac.in.</b></li>
                <li><b>If you use wrong details (beneficiary account number & IFSC Code), the amount
                    may initially get debited from your account but within two working days it will
                    get re credited in your account and hence you will have to make payment to CEPT
                    again</b></li>
            </ul>
        </div>
    </body>
</html>
