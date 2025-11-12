<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="Fees_dashboard.aspx.cs" Inherits="Student_Fees_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <%-- <link href="../DesignCss/application.css" rel="stylesheet" type="text/css" />--%>
    <link href="../DesignCss/bootstrap-switch.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/jquery.multi-select.js" type="text/javascript"></script>
    <script src="../DesignJS/application.js" type="text/javascript"></script>
    <script src="../Js/student_fees_payment_05072017.js" type="text/javascript"></script>
    <script src="../Js/general.js" type="text/javascript"></script>
    <script src="../DesignJS/bootstrap-switch.js" type="text/javascript"></script>
    <link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        $(document).ready(function () {
            $('.table td').css('padding', '6px');
            $('.table td').css('line-height', '18px');
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="hdn_fees_type" value="" />
    <div class="modal hide fade" id="modal_fees" style="left: 50%; width: 48%;">
        <div class="modal-header">
            Please select your fees.
        </div>
        <div class="modal-body">
            <table>
                <tr>
                    <td>
                        <div id="div_fees_type">
                            <label class="radio-inline">
                                <input type="radio" name="fees_status" id="rdb_full_fees" value="F" checked="checked" />
                                Full Fees 
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="fees_status" id="rdb_half_fees" value="H" />
                                Partial Fees
                            </label>
                            <label id="priority_selection" style="display:none;">
                                Select your Credits :
                                <select id="drp_priority_select">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                   <%--<option value="15">Thesis Extension</option>--%>
                                </select>
                            </label>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="modal-footer">
            <center>
                <a href="#" id="btn_save_fees_type" class="btn btn-primary">Save</a>
            </center>
        </div>
    </div>

    <div class="modal hide fade" id="refundpolicy" style="left: 50%; width: 48%;">
        <div class="modal-header">
            <b>REFUND POLICY</b>
        </div>

        <div class="modal-body" style="max-height:350px;">
            <table>
                <tr>
                    <td>
                        <p><b>Clause 1.</b></p>
                        <p>In case a student gives up the admission <b>on or before 17 May 2017</b>, paid part fees will be refunded after deduction of administrative charges of INR 5000 /-. Full amount of paid refundable deposit will be refunded.</p>

                        <p><b>Clause 2.</b></p>
                        <p>In case a student gives up the admission <b>any time between 18 May 2017 and 30 May 2017</b>, paid part fees will be refunded after deduction of <b>50 percent</b>. However, full amount of paid refundable deposit will be refunded.</p>

                        <p><b>Clause 3.</b></p>
                        <p>In case a student gives up the admission <b>any time between 31 May 2017 and 27 June 2017</b>, paid fees will be refunded after deduction of <b>75 percent</b>. However full amount of paid refundable deposit will be refunded. </p>

                        <p><b>Clause 4.</b></p>
                        <p>In case a student gives up the admission <b>after 27 June 2017</b>, after payment of full and final fee,<b> 100 per cent of paid full fees</b> will be deducted. Only full amount of paid refundable deposit will be refunded. </p>

                        <p><b>Clause 5.</b></p>
                        <p>In case of <b>transfer from one program to another program</b> within CEPT University, the fee amount paid by the candidate will be transferred suitably. No transfer fee will be charged.</p>

                        <p><b>Clause 6.</b></p>
                        <p>All <b>requests for cancellation </b> of admissions and request for refund of fees shall be made through the <b>“Request for Cancellation”</b> option available in the admission portal. In case an applicant is unable to process it through admissions portal, the applicant must email to admissions office (admissions@cept.ac.in) on <b> or before 5:00 PM </b> on the last date as applicable according to this refund policy. No verbal request will be entertained.</p>

                        <p><b>Clause 7.</b></p>
                        <p>All Refunds of fees as applicable, shall be made after <b> 20th of July 2017.</b></p>
                    </td>
                </tr>
                 <tr>
                    <td></td>
                </tr>
                <tr>
                    <td><input type="checkbox" id="isaggre"/> I have read and agree to the refund policy.</td>
                </tr>
            </table>
        </div>

        <div class="modal-footer">
            <center>
               <input type="button" class="btn btn-primary" id="btn_refundpolicy" value="proceed" /> 
            </center>
        </div>
    </div>
    
    <input type="hidden" id="returnUrl" name="returnUrl" value="" />
    <input type="hidden" id="secSignature" name="secSignature" value="" />
    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
    <input style="display: none;" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
    <input style="display: none;" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
    <input style="display: none;" type="text" id="currency" class="text" name="currency" value="INR" />
    <input type="hidden" id="encRequest" name="encRequest" value="" />
    <input type="hidden" id="access_code" name="access_code" value="" />

    <div class="row-fluid">
        <div class="page-header position-relative">
        </div>
        <div class="span8" style="margin-left: 60px">
            <div id="popup_selection" runat="server" class="row" style="display:none;">
                <div>
                    <div class="widget-box">
                        <div class="widget-header widget-header-flat">
                            <h4 class="smaller">
                            </h4>
                            <%--<div class="widget-toolbar">
                                <label>
                                    <small class="green"><b>Horizontal</b> </small>
                                    <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                    <span class="lbl"></span>
                                </label>
                            </div>--%>
                        </div>
                        <div class="widget-body">
                            <div style="font-size: 17px" class="widget-main">
                                <table id="payment_closed" runat="server" style="display: none;">
                                    <tr>
                                        <td>
                                            Payment is Closed.
                                        </td>
                                    </tr>
                                </table>
                                <table id="payment_open" runat="server" style="display: block;">
                                    <tr>
                                        <td>
                                            1. Online Payment Option (Net Banking/ Credit/Debit card), click on the button below.
                                            <%--<p style="color:Red;">
                                                Due to technical issues at ICICIMS & Citrus payment gateway, 
                                                we are extending the last date from 5th May 2017 to 6th May 2017 (17:30 hours)
                                            </p>
                                            <p style="color:Red;">
                                                Please note that due to above debit card and credit card payments are not getting processed, 
                                                students are requested to use Net banking options for making payment which is working properly.
                                            </p>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%--<button id="btnonlinepayment" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                                <i class="icon-print bigger-160"></i>Online Payment
                                            </button>--%>
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            2. Offline Payment Option (By printing auto-generated pay-in slip, and cash/demand
                                            draft payment at any ICICI bank branch in India), click on the button below.
                                            <br />
                                            <br />
                                            <%--Please Note: No cheque payment will be accepted by bank.--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
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
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="new_popup_selection" runat="server" class="row" style="display:none;">
                <div>
                    <div class="widget-box">
                        <div class="widget-header widget-header-flat">
                            <h4 class="smaller">
                            </h4>
                            <%--   <div class="widget-toolbar">
                                            <label>
                                                <small class="green"><b>Horizontal</b> </small>
                                                <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                                <span class="lbl"></span>
                                            </label>
                                        </div>--%>
                        </div>
                        <div class="widget-body">
                            <div style="font-size: 17px" class="widget-main">
                                <table id="new_payment_closed" runat="server" style="display: none;">
                                    <tr>
                                        <td>
                                            Payment is Closed.
                                        </td>
                                    </tr>
                                </table>
                                <table id="new_payment_open" runat="server" style="display: block;">
                                    <tr>
                                        <td>
                                            1. Online Payment Option (Net Banking/ Credit/Debit card), click on the button below.
                                            <%--<p style="color:Red;">
                                                Due to technical issues at ICICIMS & Citrus payment gateway, 
                                                we are extending the last date from 5th May 2017 to 6th May 2017 (17:30 hours)
                                            </p>
                                            <p style="color:Red;">
                                                Please note that due to above debit card and credit card payments are not getting processed, 
                                                students are requested to use Net banking options for making payment which is working properly.
                                            </p>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <%--<button id="btn_new_online" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                                <i class="icon-print bigger-160"></i>Online Payment
                                            </button>--%>
                                            <div class="panel panel-default" style="width:48%;float:left;margin-bottom:0px;">
                                                <div style="text-align:center;">
                                                    <button id="btn_new_online" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
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

                                            <div class="panel panel-default" style="width:48%;float:left;margin-bottom:0px;margin-left:2%;display:none;">
                                                <div style="text-align:center;">
                                                    <%--<button id="btn_online_eazypay" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
                                                        <i class="icon-print bigger-160"></i>Online Payment (Eazypay)
                                                    </button>--%>
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
                                                    <%--<button id="btn_online_hdfc" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
                                                        <i class="icon-print bigger-160"></i>Online Payment (HDFC)
                                                    </button>--%>
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
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td>
                                            2. Offline Payment Option (By printing auto-generated pay-in slip, and cash/demand
                                            draft payment at any ICICI bank branch in India), click on the button below.
                                            <br />
                                            <br />
                                            Please Note: No cheque payment will be accepted by bank.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td>
                                            <div class="panel panel-default" style="width:48%;float:left;">
                                                <div style="text-align:center;">
                                                    <button id="btn_new_manually" style="display: inline-block; line-height: inherit;margin: 10px;" class="btn btn-lg btn-primary">
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
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
