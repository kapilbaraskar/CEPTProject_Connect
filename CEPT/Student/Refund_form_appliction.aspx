<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Refund_form_appliction.aspx.cs" Inherits="Student_Refund_form_appliaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Js/Refund_application.js"></script>
    <style>
        table {
            min-width: 100% !important;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Refund Application
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>PERSONAL DETAILS</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="1" cellpadding="10" cellspacing="10">
                            <tr>
                                <td>Name of the Applicant: 
                                </td>
                                <td colspan="3">
                                    <label id="lbl_app_name"> </label>
                                </td>
                            </tr>
                            <tr>
                                <td>Application ID:
                                </td>
                                <td>
                                    <label id="lbl_app_id"></label>
                                </td>
                                <td>Mobile No:
                                </td>
                                <td>
                                    <label id="lbl_mobile_no"> </label>
                                </td>
                            </tr>

                            <tr>
                                <td>E Mail Id: 
                                </td>
                                <td>
                                    <label id="lbl_email_id"></label>
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
                        <table border="1" cellpadding="10" cellspacing="10">
                            <tr>
                                <td>Amount Paid
                                </td>
                                <td>
                                    <label id="lbl_amount"> </label>
                                </td>
                                <td>Date of Payment
                                </td>
                                <td>
                                    <label id="lbl_date_pay"></label>
                                </td>
                                <td>Mode of Payment
                                </td>
                                <td>
                                    <label id="lbl_mode_pay"></label>
                                </td>
                            </tr>


                            <tr>
                                <td>Refund Amount
                                </td>
                                <td colspan="5">
                                    <label id="lbl_ref_amount"></label>
                                </td>

                            </tr>
                            <tr>
                                <td>Reason for Drop-Withdrawal
                                </td>
                                <td colspan="5">
                                    <textarea col="5" rows="3" style="width: 98%" id="txt_reason"></textarea>
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
                        <table border="1" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Name of Account Holder:
                                </td>
                                <td >
                                    <input type="text" id="txt_acc_holder_name" class="txtbox" />
                                </td>

                            </tr>


                            <tr>
                                <td>Name of Bank & Branch Address:
                                </td>
                                <td >
                                    <input type="text" id="txt_bank_address" class="txtbox" />
                                </td>

                            </tr>
                            <tr>
                                <td>Account Type
                                </td>
                                <td >
                                    <input type="text" id="txt_account_type" class="txtbox" />
                                </td>
                            </tr>
                            <tr>
                                <td>IFSC Code of Branch
                                </td>
                                <td>
                                    <input type="text" id="txt_IFScode" class="txtbox" maxlength="11"/>
                                </td>
                               
                            </tr>
                            <tr>
                                <td>Account Number
                                </td>
                                <td >
                                    <input type="number" id="txt_acount_number" class="txtbox" />
                                </td>

                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div>
            <p style="font-size:larger;"><b> *Student who have paid fees through offline mode are required to send original payslip to Admission office at CEPT University, K L Campus, Navrangpura, Ahmedabad, Gujarat – 380009</b></p>
        </div>
        <div style="    margin-left: 45%;">
          <button class="btn btn-primary" type="button" id="btn_save">
                            Save
                        </button>
         <button class="btn btn-primary" type="button" id="btn_submit">
                            Submit
                        </button>
        </div>
        <input type="hidden" id="hdn_trn_id" />
        <input type="hidden" id="hdn_amount" />
    </div>
    <style>
        .txtwidth {
            WIDTH: 10PX;
        }

        .tdwidth {
            WIDTH: 1PX;
        }

        .txtbox {
            width: 98%;
        }
    </style>
</asp:Content>

