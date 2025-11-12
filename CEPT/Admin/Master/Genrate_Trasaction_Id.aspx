<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Genrate_Trasaction_Id.aspx.cs" Inherits="Admin_Master_Genrate_Trasaction_Id" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/GenrateTransactionid.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>WS Generate Transaction Id
            </h1>
        </div>

        <div>
            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Student Code :
                        </td>
                        <td>
                            <input type="text" class="chosen-select" id="txt_student_id" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">Retrieve</button>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="DataList" class="panel panel-default" style="display: none;">
                <div class="panel-heading">
                    <strong>Student Detail</strong>
                </div>
                <div>
                    <div id="" style="display: block;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div id="div_transaction" style="display: none; margin-top: 15px; margin-bottom: 40px;" class="panel panel-default">
                <div class="panel-heading">
                    <strong>Enter Transaction Detail <p style="float:right;">Per Credit Fees Amount : <span id="amountpercredit" style="color:blue;"></span></p></strong>
                </div>
                <div style="padding-top: 15px;">
                    <table border="0" cellpadding="2" cellspacing="2" style="width: 100%;" align="center">
                        <tr>
                            <td style="padding-left: 15px;">
                                <b>Transaction Id :</b>
                            </td>
                            <td>
                                <input type="text" id="txt_PG_transaction_id" />
                            </td>

                            <td>
                                <b>Credit :</b>
                            </td>
                            <td>
                                <input type="text" id="txt_credit_txn_id"/>
                            </td>
                             </tr>
                        <tr>
                            <td style="padding-left: 15px;">
                                <b>Payment Mode :</b>
                            </td>
                            <td>
                                <input type="text" id="txt_PaymentMode_txn_id" />
                            </td>
                            <td>
                                <b>Amount :</b>
                            </td>
                            <td>
                                <input type="text" id="txt_Amount_txn_id"/>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="6" style="padding-top: 2px;"></td>
                        </tr>

                        <tr>
                            <td colspan="6" style="padding: 10px; background-color: #eff3f8; border-top: 1px solid #DDD;">
                                <center>
                                    <button id="btnsave" style="line-height: inherit;" class="btn btn-lg btn-primary"><i class="icon-save bigger-160"></i>Save</button>
                                </center>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

   <input type="hidden" id="hdn_fees_amount" runat="server" clientidmode="Static" />
</asp:Content>

