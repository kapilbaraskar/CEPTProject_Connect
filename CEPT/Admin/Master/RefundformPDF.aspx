<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RefundformPDF.aspx.cs" Inherits="Admin_Master_RefundformPDF" %>

<html xmlns="https://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <script src="../../Js/RefundformPDF.js"></script>
</head>
<body class="container" style="color: Black; width: 985px;">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <img src="../../image/Capture.PNG" style="position: absolute;" />
            <h1 style="margin-left: 310px;">
                Cancellation Application
            </h1>
        </div>
    </div>
    <div class="" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>PERSONAL DETAILS</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="1" cellpadding="10" cellspacing="10" style="width: 100%">
                            <tr>
                                <td>
                                    Name of the Applicant:
                                </td>
                                <td colspan="3">
                                    <label id="lbl_app_name">
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Application ID:
                                </td>
                                <td>
                                    <label id="lbl_app_id">
                                    </label>
                                </td>
                                <td>
                                    Mobile No:
                                </td>
                                <td>
                                    <label id="lbl_mobile_no">
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    E Mail Id:
                                </td>
                                <td>
                                    <label id="lbl_email_id">
                                    </label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Program Admitted</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="1" cellpadding="10" cellspacing="10" style="width: 100%;">
                            <tr>
                                <td>
                                    Amount Paid
                                </td>
                                <td>
                                    <label id="lbl_amount">
                                    </label>
                                </td>
                                <td>
                                    Date of Payment
                                </td>
                                <td>
                                    <label id="lbl_date_pay">
                                    </label>
                                </td>
                                <td>
                                    Mode of Payment
                                </td>
                                <td>
                                    <label id="lbl_mode_pay">
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Refund Amount
                                </td>
                                <td colspan="5">
                                    <label id="lbl_ref_amount">
                                    </label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Reason for Drop-Withdrawal
                                </td>
                                <td colspan="5">
                                    <label id="txt_reason">
                                    </label>
                                    <%--<textarea col="5" rows="3" style="width: 98%" id="txt_reason"></textarea>--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>BANK DETAILS</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="1" cellpadding="10" cellspacing="5" style="width: 100%;">
                            <tr>
                                <td>
                                    Name of Account Holder:
                                </td>
                                <td>
                                    <label id="txt_acc_holder_name">
                                    </label>
                                    <%--<input type="text" id="txt_acc_holder_name" class="txtbox" />--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Name of Bank & Branch Address:
                                </td>
                                <td>
                                    <label id="txt_bank_address">
                                    </label>
                                    <%--<input type="text" id="txt_bank_address" class="txtbox" />--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Account Type
                                </td>
                                <td>
                                    <label id="txt_account_type">
                                    </label>
                                    <%--<input type="text" id="txt_account_type" class="txtbox" />--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    IFSC Code of Branch
                                </td>
                                <td>
                                    <label id="txt_IFScode">
                                    </label>
                                    <%--<input type="text" id="txt_IFScode" class="txtbox" maxlength="11"/>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Account Number
                                </td>
                                <td>
                                    <label id="txt_acount_number">
                                    </label>
                                    <%--<input type="number" id="txt_acount_number" class="txtbox" />--%>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <%--   <div>
            <p style="font-size:larger;"><b> *Student who have paid fees through offline mode are required to send original payslip to Admission office at CEPT University, K L Campus, Navrangpura, Ahmedabad, Gujarat – 380009</b></p>
        </div>--%>
        <%--  <div style="    margin-left: 45%;">
          <button class="btn btn-primary" type="button" id="btn_save">
                            Save
                        </button>
         <button class="btn btn-primary" type="button" id="btn_submit">
                            Submit
                        </button>
        </div>--%>
        <input type="hidden" id="hdn_trn_id" />
        <input type="hidden" id="hdn_amount" />
    </div>
    <style>
        .txtwidth
        {
            width: 10PX;
        }
        
        .tdwidth
        {
            width: 1PX;
        }
        
        .txtbox
        {
            width: 98%;
        }
    </style>
</body>
</html>
