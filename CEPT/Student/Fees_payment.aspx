<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Fees_payment.aspx.cs" Inherits="Student_Fees_payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/bootstrap-switch.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/jquery.multi-select.js" type="text/javascript"></script>
    <script src="../DesignJS/application.js" type="text/javascript"></script>
    <script src="../Js/fees_payment.js?t=03072022" type="text/javascript"></script>
    <%--17122018,17122019--%><%--06032020--%><%--19032020--%><%--07072020--%><%--17072020--%><%--23102020--%><%--18032021--%><%--14072021--%>
    <script src="../Js/general.js" type="text/javascript"></script>
    <script src="../DesignJS/bootstrap-switch.js" type="text/javascript"></script>
    <link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        #tbl_balance_payable1 th, #tbl_balance_payable1 td {
            text-align: center; 
        }

        .cls_align_center th, .cls_align_center td {
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" style="margin-top: 10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Fees Payment
            </h1>
        </div>
    </div>

    <div id="pnl_choose_credits" class="panel panel-default" style="display: none;">
        <div class="panel-heading">
            <strong>Choose Credits</strong>
        </div>

        <div id="div_fees_type" class="panel-body">
            <label class="radio-inline">
                <input type="radio" name="fees_status" id="rdb_quarter_fees" value="Q" />
                I am applying for up to 5 credits
            </label>

            <label class="radio-inline">
                <input type="radio" name="fees_status" id="rdb_half_fees" value="H" />
                I am applying for up to 10 credits
            </label>

            <label class="radio-inline">
                <input type="radio" name="fees_status" id="rdb_full_fees" value="F" />
                I am applying for more than 10 credits
            </label>

            <div style="display: none;">
                <label id="priority_selection" style="display: none;">
                    Select your Credits :
                    <select id="drp_priority_select">
                        <option value="10">10</option>
                        <option value="5">5</option>
                        <%--<option value="1">1</option>
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
                        <option value="12">12</option>--%>
                    </select>
                </label>
            </div>

            <div style="margin-top: 15px;">
                <a id="btn_save_fees_type" class="btn btn-primary btn-small">Next</a>
            </div>
        </div>
    </div>

    <div id="pnl_pay_type" class="panel panel-default" style="display: none;">
        <div class="panel-heading">
            <strong>Pay Type</strong>
        </div>

        <div id="div_pay_type" class="panel-body">
            <div id="div_credits" style="margin-bottom: 10px;"></div>

            <label class="radio-inline">
                <input type="radio" name="rdo_pay_type" id="rdo_pay_full" value="F" />
                Pay Full Fees
            </label>

            <label class="radio-inline">
                <input type="radio" name="rdo_pay_type" id="rdo_pay_installment" value="I" />
                Pay In Installments
            </label>

            <div style="margin-top: 15px;">
                <a id="btn_pay_type_next" class="btn btn-primary btn-small">Next</a>
            </div>
        </div>
    </div>

    <div id="pnl_full_fees_detail" class="panel panel-default" style="display: none;">
        <div class="panel-heading">
            <strong>Fees Detail</strong>
        </div>

        <div id="div_full_fees_dtl" class="panel-body">
            <table id="tbl_full_fees_dtl" style="display: block;" cellpadding="5px">
                <tr>
                    <td align="left">Semester
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="spn_sem"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">Total Fees Payable
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="spn_fees_to_pay"></span>
                    </td>
                </tr>
                <tr class="cls_tr_fine" style="display: none; color: red;">
                    <td align="left">Late Fees Fine
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_fine_amount"></span>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div id="pnl_installment_detail" class="panel panel-default" style="display: none;">
        <div class="panel-heading">
            <strong>Installment Detail</strong>
        </div>
        <div class="panel-body Y2020" style="display: none;">
            <input type="radio" name="y2020_fees_pay_type" id="4installment" value="4" onclick="change_no_of_installment(3)" />
            Pay In Installment &nbsp;&nbsp;&nbsp;&nbsp;
             <input type="radio" name="y2020_fees_pay_type" id="2installment" value="2" onclick="change_no_of_installment(2)" />
            Pay Full Fees
        </div>
        <div id="div_installment_dtl" class="panel-body">
            <table id="tbl_fees_detail" style="display: block;" cellpadding="5px">
                <tr>
                    <td align="left">Semester
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="spn_sem"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">Fees Paid
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span id="spn_fees_paid"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">Total Fees Payable
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="spn_fees_to_pay"></span>
                    </td>
                </tr>
                <tr id="tr1">
                    <td align="left">No of Installment
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_no_of_installment"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">Current Installment
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_cur_installment"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left">Installment Amount
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_cur_installment_amount"></span>
                    </td>
                </tr>
                <tr class="cls_tr_fine" style="display: none; color: red;">
                    <td align="left">Late Fees Fine
                    </td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>
                        <span class="cls_fine_amount"></span>
                    </td>
                </tr>
                <tr class="tr_balance_payable" style="display: none;">
                    <td style="vertical-align: super;">Balance Payable
                    </td>
                    <td style="vertical-align: super;">&nbsp;:&nbsp;</td>
                    <td>
                        <table id="tbl_balance_payable1" class="table table-bordered tbl_balance_payable" style="display: none;">
                            <tr class="tr_balance_payable1">
                                <th>Installment No</th>
                                <th>Amount</th>
                                <th>Due Date</th>
                            </tr>
                            <tr class="tr_balance_payable1">
                                <td>1</td>
                                <td class="td_installment1"></td>
                                <td>18th Dec 2020 (FRI)</td>
                            </tr>
                            <tr class="tr_balance_payable2">
                                <td>2</td>
                                <td class="td_installment2"></td>
                                <td class="ins2">29th Jan 2021 (FRI)</td>
                            </tr>
                            <tr class="tr_balance_payable3">
                                <td>3</td>
                                <td class="td_installment3"></td>
                                <td>26th Feb 2021 (FRI)</td>
                            </tr>
                            <tr class="tr_balance_payable4">
                                <%--//Open 5th Installment Start--%>
                                <td>4</td>
                                <td class="td_installment4"></td>
                                <td>26th Mar 2021 (FRI)</td>
                            </tr>
                        </table>

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
                                <td class="ins1">26th Jul 2021 (MON)</td>
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
                                <td class="ins2">09th Sep 2021 (THU)</td>
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
                                <td class="ins3">09th Oct 2021 (SAT)</td>
                            </tr>
                            <%--//Open 5th Installment Start--%>
                            <%--//Open 5th Installment Start--%>
                            <%--<tr class="tr_balance_payable4">
                                
                                <td>4)&nbsp;</td>
                                <td>Amount</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="td_installment4"></td>
                            </tr>
                            <tr class="tr_balance_payable4">
                                
                                <td></td>
                                <td>Date</td>
                                <td>&nbsp;:&nbsp;</td>
                                <td class="ins4">09th Nov 2021 (TUE)</td>
                            </tr>--%>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="panel panel-default divCheckOrderStatus" style="display: none;">
        <div class="panel-heading">
            <strong>Fees Status</strong>
        </div>
        <div style="margin: 10px 0px 10px 10px;">
            <table class="table table-bordered cls_align_center fees_status" style="width: 70%;text-align:center;">
                <thead>
                    <tr>
                        <td><b>Sr. No.</b></td>
                        <td><b>Installment No</b></td>
                        <td><b>Transaction ID</b></td>
                        <td><b>Amount</b></td>
                        <td><b>Payment Date</b></td>
                        <td><b>Fees Status</b></td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>

    <div id="pnl_pay_fees" class="panel panel-default" style="display: none;">
        <div class="panel-heading">
            <strong>Pay Fees</strong>
        </div>

        <div id="div_pay_fees" class="panel-body" style="min-height: 20px;">
            <%--<label class="radio-inline" style="float:left;">
                <input type="radio" name="rdo_pay_fees" id="rdo_pay_online" value="ON" />
                Online
            </label>
            
            <label class="radio-inline" style="float:left;margin-left:20px;margin-bottom:15px;">
                <input type="radio" name="rdo_pay_fees" id="rdo_pay_offline" value="OFF" />
                Offline
            </label>--%>

            <div>
                <%--<label class="radio-inline"><input type="radio" name="rdo_online_pay_option" id="rdo_online_pay_citrus" value="citrus" onclick="pg_change('online_citrus')" />&nbsp;Citrus</label>
                            <label class="radio-inline"><input type="radio" name="rdo_online_pay_option" id="rdo_online_pay_eazypay" value="eazypay" onclick="pg_change('online_eazypay')" />&nbsp;Eazypay</label>
                            <label class="radio-inline"><input type="radio" name="rdo_online_pay_option" id="rdo_online_pay_kotak" value="kotak" onclick="pg_change('online_kotak')" />&nbsp;Kotak</label>--%>

                <table class="table table-bordered cls_align_center">
                    <thead>
                        <tr>
                            <th><%--Payment Gateway--%></th>
                            <th colspan="2">Netbanking</th>
                            <th colspan="2">Debit Card</th>
                            <th colspan="2">Credit Card</th>
                            <th colspan="2">NEFT/RTGS</th>
                        </tr>
                        <tr>
                            <th></th>
                            <th>Available</th>
                            <th>Charges</th>
                            <th>Available</th>
                            <th>Charges</th>
                            <th>Available</th>
                            <th>Charges</th>
                            <th>Available</th>
                            <th>Charges</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                                        <tr id="enableeazpay" style="display:none;">
                                        <td><label class="radio-inline"><input type="radio" name="rdo_online_pay_option" id="rdo_online_pay_eazypay" value="eazypay" onclick="pg_change('online_eazypay')" />&nbsp;<span style="color:red;"> ICICI Eazypay </span></label></td>
                                        <%--<td>No</td>
                                        <td>-</td>
                                        <td>No</td>
                                        <td>-</td>
                                        <td>No</td>
                                        <td>-</td>--%>
                                          <td colspan="6"> <span style="color:blue;">ICICI Eazypay Allows Only NEFT/RTGS</span> </td>
                                        <td>Yes</td>
                                        <td>Zero</td>
                                    </tr>
                        <tr>
                            <td>
                                <label class="radio-inline">
                                    <input type="radio" name="rdo_online_pay_option" id="rdo_online_pay_kotak" value="kotak" onclick="pg_change('online_kotak')" />&nbsp;<span style="color:red;"> Kotak </span></label></td>
                            <td>Yes</td>
                            <td>Zero</td>
                            <td>Yes</td>
                            <td>1% plus applicable GST</td>
                            <td>Yes</td>
                            <td>1% plus applicable GST</td>
                            <td>Yes</td>
                            <td>Zero</td>
                        </tr>
                        <%--<tr>
                                        <td><label class="radio-inline"><input type="radio" name="rdo_online_pay_option" id="rdo_online_pay_hdfc" value="hdfc" onclick="pg_change('online_hdfc')" />&nbsp;HDFC</label></td>
                                        <td>Yes</td>
                                        <td>Zero</td>
                                        <td>Yes</td>
                                        <td>1% plus applicable GST</td>
                                        <td>Yes</td>
                                        <td>1% plus applicable GST</td>
                                    </tr>--%>
                    </tbody>
                </table>


            </div>

            <div style="margin-top: 15px; text-align: center; display: none;" id="online_pay">
                <a id="btn_pay_now_online" class="btn btn-primary btn-small">Pay Now</a>
            </div>

            <br />

            <table class="table table-bordered cls_align_center BCT_BID_HIDE" style="width: 51%;">
                <thead>
                    <tr>
                        <th><%--Payment Gateway--%></th>
                        <%--<th colspan="2">Cash</th>--%>
                        <th colspan="2">Demand Draft</th>
                        <%--<th colspan="2">NEFT/RTGS</th>--%>
                        <th>To be deposited at</th>
                    </tr>
                    <tr>
                        <th></th>
                        <%-- <th>Available</th>
                                    <th>Charges</th>--%>
                        <th>Available</th>
                        <th>Charges</th>
                        <%--<th>Available</th>
                                    <th>Charges</th>--%>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_icici" value="icici" onclick="pg_change('offline_icici')" />&nbsp;ICICI</label></td>
                        <%--<td>Yes</td>
                                    <td>Zero</td>--%>
                        <td>Yes</td>
                        <td>Zero</td>
                        <%-- <td colspan="2">No</td>--%>
                        <td>Any branch of ICICI Bank</td>
                    </tr>
                    <%--<tr>
                                    <td><label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_eazypay" value="eazypay" onclick="pg_change('offline_eazypay')" />&nbsp;Eazypay</label></td>
                                    <td>Yes</td>
                                    <td>Rs. 50/- per transaction</td>
                                    <td>Yes</td>
                                    <td>Zero</td>
                                    <td colspan="2">No</td>
                                    <td>Any branch of ICICI Bank</td>
                                </tr>--%>
                    <%--<tr>
                                    <td><label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_yes" value="yes" onclick="pg_change('offline_yes')" />&nbsp;Yes Bank (NEFT)</label></td>
                                    <%--<td colspan="2">No</td>
                                    <td colspan="2">No</td>
                                    <td>Yes</td>
                                    <td>Zero</td>
                                    <td>Your Bank</td>
                                </tr>06 03 2020 Email Mahroofbhai Stops--%>

                    <%--Added by Mayur 14 06 2019 Start--%>
                    <%--<tr>
                                    <td><label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_kotak_neft_rtgs" value="kotak_neft_rtgs" onclick="pg_change('offline_kotak_neft_rtgs')" />&nbsp;Kotak Bank (NEFT/RTGS)</label></td>
                                    <td colspan="2">No</td>
                                    <td colspan="2">No</td>
                                    <td>Yes</td>
                                    <td>Zero</td>
                                    <td>Your Bank</td>
                                </tr>--%>
                    <%--Added by Mayur 14 06 2019 End--%>

                    <%--<tr>
                                    <td><label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_kotak" value="kotak" onclick="pg_change('offline_kotak')" />&nbsp;Kotak Bank</label></td>
                                    <td>Yes</td>
                                    <td>Rs. 20/- per transaction</td>
                                    <td>Yes</td>
                                    <td>Rs. 20/- per transaction</td>
                                    <td colspan="2">No</td>
                                    <td>Any branch of Kotak Bank</td>
                                </tr>Open Kotak Offline--%>
                </tbody>
            </table>

            <div style="margin-top: 15px; text-align: center; display: none;" id="offline_pay">
                <a id="btn_pay_now_offline" class="btn btn-primary btn-small">Generate Payment Challan</a><%--Print Pay-In Slip--%>
                <%--Added by Mayur 14 06 2019 Start--%>
                <a id="btn_pay_now_kotak_neft_rtgs" class="btn btn-primary btn-small">Pay Now</a>
                <%--Added by Mayur 14 06 2019 End--%>
            </div>

            <div style="clear: both;"></div>

            <%--<div style="width:45%;float:left;">--%>
            <div style="">
                <div id="div_online_pay_option" class="panel panel-default" style="display: none;">
                    <div class="panel-heading">
                        <strong>Online Payment Option<span id="spn_online_pay_option" style="color: Red; display: none;">&nbsp;(Please select appropriate option)</span></strong>
                    </div>

                    <div class="panel-body">
                    </div>
                </div>

                <div id="div_offline_pay_option" class="panel panel-default" style="display: none;">
                    <div class="panel-heading">
                        <strong>Offline Payment Option<span id="spn_offline_pay_option" style="color: Red; display: none;">&nbsp;(Please select appropriate option)</span></strong>
                    </div>

                    <div class="panel-body">
                        <%--<label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_icici" value="icici" onclick="pg_change('offline_icici')" />&nbsp;ICICI</label>
                        <label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_eazypay" value="eazypay" onclick="pg_change('offline_eazypay')" />&nbsp;Eazypay</label>
                        <label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_yes" value="yes" onclick="pg_change('offline_yes')" />&nbsp;Yes Bank (NEFT)</label>
                        <label class="radio-inline"><input type="radio" name="rdo_offline_pay_option" id="rdo_offline_pay_kotak" value="kotak" onclick="pg_change('offline_kotak')" />&nbsp;Kotak Bank</label>--%>
                    </div>
                </div>
            </div>

            <%--<div style="width:50%;float:right;">--%>
            <div style="display: none;">
                <div id="online_citrus" class="panel panel-default cls_pg_charges" style="display: none;">
                    <div class="panel-heading">
                        <strong>Citrus Charges</strong>
                    </div>
                    <table class="table table-bordered" style="font-size: 14px; margin-bottom: 0px !important;">
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
                                <td>1% plus applicable GST</td>
                            </tr>
                            <tr>
                                <td>Credit Card</td>
                                <td>1% plus applicable GST</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="online_eazypay" class="panel panel-default cls_pg_charges" style="display: none;">
                    <div class="panel-heading">
                        <strong>Eazypay Charges</strong>
                    </div>
                    <table class="table table-bordered" style="font-size: 14px; margin-bottom: 0px !important;">
                        <thead>
                            <tr>
                                <th>Type of Transaction</th>
                                <th>Convenience Fee</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Net Banking</td>
                                <td>Rs. 10/- per Transaction</td>
                            </tr>
                            <tr>
                                <td>Debit Card</td>
                                <td>1% plus applicable GST</td>
                            </tr>
                            <tr>
                                <td>Credit Card</td>
                                <td>1.10% plus applicable GST</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="online_kotak" class="panel panel-default cls_pg_charges" style="display: none;">
                    <div class="panel-heading">
                        <strong>Kotak Charges</strong>
                    </div>
                    <table class="table table-bordered" style="font-size: 14px; margin-bottom: 0px !important;">
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
                                <td>1% plus applicable GST</td>
                            </tr>
                            <tr>
                                <td>Credit Card</td>
                                <td>1% plus applicable GST</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="offline_icici" class="panel panel-default cls_pg_charges" style="display: none;">
                    <div class="panel-heading">
                        <strong>ICICI Charges</strong>
                    </div>
                    <table class="table table-bordered" style="font-size: 14px; margin-bottom: 0px !important;">
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
                            <tr>
                                <td>To be deposited at</td>
                                <td>Any branch of ICICI Bank</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="offline_eazypay" class="panel panel-default cls_pg_charges" style="display: none;">
                    <div class="panel-heading">
                        <strong>ICICI Eazypay Charges</strong>
                    </div>
                    <table class="table table-bordered" style="font-size: 14px; margin-bottom: 0px !important;">
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
                            <tr>
                                <td>To be deposited at</td>
                                <td>Any branch of ICICI Bank</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="offline_yes" class="panel panel-default cls_pg_charges" style="display: none;">
                    <div class="panel-heading">
                        <strong>Yes Bank Charges</strong>
                    </div>
                    <table class="table table-bordered" style="font-size: 14px; margin-bottom: 0px !important;">
                        <thead>
                            <tr>
                                <th>Type of Transaction</th>
                                <th>Convenience Fee</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>NEFT / RTGS</td>
                                <td>Zero</td>
                            </tr>
                            <tr>
                                <td>To be deposited at</td>
                                <td>Your Bank</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div id="offline_kotak" class="panel panel-default cls_pg_charges" style="display: none;">
                    <div class="panel-heading">
                        <strong>Kotak Bank Charges</strong>
                    </div>
                    <table class="table table-bordered" style="font-size: 14px; margin-bottom: 0px !important;">
                        <thead>
                            <tr>
                                <th>Type of Transaction</th>
                                <th>Convenience Fee</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Cash</td>
                                <td>Rs. 20/- per transaction</td>
                            </tr>
                            <tr>
                                <td>Demand Draft</td>
                                <td>Rs. 20/- per transaction</td>
                            </tr>
                            <tr>
                                <td>To be deposited at</td>
                                <td>Any branch of Kotak Bank</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div style="clear: both;"></div>
        </div>
    </div>

    <div style="display: none;">
        <asp:Button ID="hdn_download_icici" runat="server" ClientIDMode="Static" OnClick="Download_ICICI_Payslip" />
        <asp:Button ID="hdn_send_response" runat="server" ClientIDMode="Static" OnClick="Send_Response" />
        <%--<asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="Download_Bank_Instruction" />06 03 2020 Email Mahroofbhai Stops--%>
    </div>

    <input type="hidden" id="returnUrl" name="returnUrl" value="" />
    <input type="hidden" id="secSignature" name="secSignature" value="" />
    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
    <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
    <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
    <input style="display: none" type="text" id="currency" class="text" name="currency" value="INR" />
    <input type="hidden" id="encRequest" name="encRequest" value="" />
    <input type="hidden" id="access_code" name="access_code" value="" />
    <input type="hidden" id="fees_sem" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="fees_year" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="hdn_fond" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="hdn_prog_code" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="hdn_dept_code" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="hdn_created_by" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="hdn_yes_virtual_acc" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="KotakAPIEncReponse" runat="server" clientidmode="Static" value="" />
</asp:Content>

