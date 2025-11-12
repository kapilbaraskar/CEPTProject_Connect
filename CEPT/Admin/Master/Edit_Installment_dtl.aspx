<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Edit_Installment_dtl.aspx.cs" Inherits="Admin_Master_Edit_Installment_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {


            if ($('#hdn_sem').val() == '' || $('#hdn_year').val() == '' || $('#hdn_user_id').val() == '' || $('#hdn_inst_no').val() == '') { }
            else {  retrieveFeesData(); }
            $('#btn_update').on('click', function () {

                update_installment_detail();
                return false;
            });
            $('input[type=radio][name=Yes]').change(function () {

                if (this.id == 'int_Y') {

                    bootbox.confirm({
                        message: "Do you want to Add Transaction Id For This Payment ?",
                        buttons: {
                            confirm: {
                                label: 'Yes',
                                className: 'btn-success'
                            },
                            cancel: {
                                label: 'No',
                                className: 'btn-danger'
                            }
                        },
                        callback: function (result)
                        {
                            if (result == true) {
                                //$('#btn_update').css('display', 'none');
                                $('#trs_2').css('display', '');
                                $('#trs_1').css('display', '');
                                $('#hdn_status_tran').val('true');
                            }
                            else {
                                $('#tras_type').val('');
                                $('#txt_tras_no').val('');
                                $('#txt_citrus_txn_id').val('');
                                $('#txt_payment_autho_code').val('');
                                $('#hdn_status_tran').val('');
                                $('#trs_2').css('display', 'none');
                                $('#trs_1').css('display', 'none');
                            }
                        }
                    });

                    //bootbox.confirm('Do you want to Add Transaction Id For This Payment ?',
                    //function (result)
                    //{

                    //    if (result == true)
                    //    {
                    //        //$('#btn_update').css('display', 'none');
                    //        $('#trs_2').css('display', '');
                    //        $('#trs_1').css('display', '');
                    //        $('#hdn_status_tran').val('true');
                    //    }
                    //    else
                    //    {
                    //        $('#tras_type').val('');
                    //        $('#txt_tras_no').val('');
                    //        $('#txt_citrus_txn_id').val('');
                    //        $('#txt_payment_autho_code').val('');
                    //        $('#hdn_status_tran').val('');
                    //        $('#trs_2').css('display', 'none');
                    //        $('#trs_1').css('display', 'none');
                    //    }
                    //});

                }
                else if (this.id == 'int_N') {
                    $('#hdn_status_tran').val('');
                    $('#trs_2').css('display', 'none');
                    $('#trs_1').css('display', 'none');

                    $('#tras_type').val('');
                    $('#txt_tras_no').val('');
                    $('#txt_citrus_txn_id').val('');
                    $('#txt_payment_autho_code').val('');
                    $('#hdn_status_tran').val('');

                } 


            });

            $("#tras_type").change(function () {
                var selec_value = this.value;
                if (selec_value == 'BL') {
                    $('#txt_tras_no').val('BankLoan_' + $('#hdn_user_id').val() + '_' + $('#hdn_sem').val() + $('#hdn_year').val() + '_' + $('#hdn_inst_no').val());
                }
                else if (selec_value == 'BT') {
                    $('#txt_tras_no').val('BankTrans_' + $('#hdn_user_id').val() + '_' + $('#hdn_sem').val() + $('#hdn_year').val() + '_' + $('#hdn_inst_no').val());
                }
                var firstDropVal = $('#pick').val();
            });
        });

        function retrieveFeesData()
        {
           

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Fees_installment_details",
                async: false,
                data: "{user_id:'" + $('#hdn_user_id').val() + "',installment_no:'" + $('#hdn_inst_no').val() + "',sem_code:'" + $('#hdn_sem').val() + "',year_code:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != '') {
                        var retrieved_fees_data = JSON.parse(data.d);

                        $('#txt_stu_code').val(retrieved_fees_data[0]['user_id']);
                        $('#txt_stu_name').val(retrieved_fees_data[0]['full_name']);
                        $('#txt_fees_amount').val(retrieved_fees_data[0]['fees_amount']);
                        $('#txt_total_inst_no').val(retrieved_fees_data[0]['no_of_installment']);
                        var inst_no = retrieved_fees_data[0]['installment_no'].substring(retrieved_fees_data[0]['installment_no'].length, retrieved_fees_data[0]['installment_no'].length - 1)
                        $('#txt_current_inst_no').val(inst_no);
                        $('#txt_schol_inst_no').val(inst_no);
                        $('#txt_inst_fees_amount').val(retrieved_fees_data[0]['installmentfess']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function update_installment_detail() {
            var fees_amount = $('#txt_inst_fees_amount').val();
            var trans_no = '';
            var citrus_id = '';
            var auth_id = '';
            var paid_inst = '';
            if ($("#int_Y").is(":checked")) {
                paid_inst = 'Y';
            }
            else
            {
                paid_inst = 'N';
            }
            if ($('#hdn_status_tran').val() == 'true')
            {
                if ($('#tras_type').val() == '')
                {
                    bootbox.alert("Please Select Transaction Type");
                    return false;
                }
                if ($('#txt_tras_no').val() == '') {
                    return false;
                }
                else
                {
                    trans_no = $('#txt_tras_no').val();
                }
                if ($('#txt_citrus_txn_id').val() == '')
                {
                    bootbox.alert("Please Enter Citrus Txn Id");
                    return false;
                }
                
                else
                {
                    citrus_id = $('#txt_payment_autho_code').val();
                }
                if ($('#txt_payment_autho_code').val() == '')
                {
                    bootbox.alert("Please Enter Auth Id Code");
                    return false;
                }
                else
                {
                    auth_id = $('#txt_payment_autho_code').val();
                }
                
                
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_installment_data",
                async: false,
                data: "{student_code:'" + $('#hdn_user_id').val() + "',installment_no:'" + $('#hdn_inst_no').val() + "',installment_amount:'" + $('#txt_inst_fees_amount').val() + "',sem_code:'" + $('#hdn_sem').val() + "',year_code:'" + $('#hdn_year').val() + "',paid_inst:'" + paid_inst + "',trans_no:'" + trans_no + "',citrus_id:'" + citrus_id + "',auth_id:'" + auth_id + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == "True") {
                        alert("Data Update Successfully");
                        var origin = window.location.origin;
                        window.location.replace(origin + "/Admin/Master/" + "Fees_Installment_dtl.aspx");
                        //window.open(origin +"/Admin/Master/"+ "Fees_Installment_dtl.aspx");
                    }
                    else { bootbox.alert("Problem In Data"); }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function rowClick(row) {
            //var but_id = data.aData["user_id"] + '_' + installment_number;
            //var data_value = row.id.split('_');
            var origin = window.location.origin;
            //window.open(origin + '\\' + 'MedicalCertificate' + '\\' + $('#lbl_medical_Cert_file_name').text(),);
            // window.location = "Edit_Installment_dtl.aspx?c=" + data_value[0] + "&i=" + data_value[1] + "&s=" + sem_code + "&y=" + year_code,"_blank";
            window.open("Scholarship_amount_dtl.aspx?c=" + $('#hdn_user_id').val() + "&i=" + $('#hdn_inst_no').val() + "&s=" + $('#hdn_sem').val() + "&y=" + $('#hdn_year').val(), "_blank");
        }

      
       
    </script>
    <style>label {
      float: left;
      clear: none;
      display: block;
      padding: 0px 1em 0px 8px;
    }
    
    input[type=radio],
    input.radio {
      float: left;
      clear: none;
     
    }</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">

        <div id="div_fees_bank_dtl" style="margin-top: 15px; margin-bottom: 40px;" class="panel panel-default">


            <div class="panel-heading">
                <strong>Edit Installment Detail</strong>
            </div>
            <div style="padding-top: 15px;">
                <table border="0" cellpadding="2" cellspacing="2" style="width: 100%;" align="center">
                    <tr >
                        <td style="padding-left: 15px;">
                            <b>Payment installment Paid</b>
                        </td>
                        <td colspan="2">
                            <label class="radio-inline"><input type="radio" name="Yes" id="int_Y" >Yes</label>
                            <label class="radio-inline"><input type="radio" name="Yes" id="int_N" checked>No</label>
                          
                        </td>

                    </tr>
                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Student Code</b>
                        </td>
                        <td>
                            <input type="text" id="txt_stu_code" readonly />
                        </td>

                        <td>
                            <b>Student Name</b>
                        </td>
                        <td>
                            <input type="text" id="txt_stu_name" readonly />
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4" style="padding-top: 6px;"></td>
                    </tr>

                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Total Fees Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_fees_amount" readonly />
                        </td>

                        <td>
                            <b>Total Installment</b>
                        </td>
                        <td>
                            <input type="text" id="txt_total_inst_no" readonly />
                        </td>
                    </tr>

                    <tr>

                        <td style="padding-left: 15px;">
                            <b>Current Installment No.</b>
                        </td>
                        <td>
                            <input type="text" id="txt_current_inst_no" readonly />
                        </td>
                        <td>
                            <b>Installment Fees Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_inst_fees_amount" />
                        </td>


                    </tr>

                    <tr style="display:none;">

                    </tr>
                    <tr id="trs_1" style="display:none;padding-left: 15px;">
                         <td style="padding-left: 15px;">
                                <b>Transaction Type :</b>
                            </td>
                            <td>
                                <select id="tras_type" class="marg-btm">
                                <option value="">--Select Transaction Type --</option>
                                <option value='BL'>Bank Loan</option>
                                <option value='BT'>Bank Transaction</option>
                                
                                
                            </select>
                            </td>

                            <td>
                                <b>Transaction No :</b>
                            </td>
                            <td>
                                <input type="text" id="txt_tras_no" readonly  />
                            </td>
                    </tr>

                    <tr id="trs_2" style="display:none;padding-left: 15px;">
                         <td style="padding-left: 15px;">
                                <b>Citrus Txn Id :</b>
                            </td>
                            <td>
                                <input type="text" id="txt_citrus_txn_id" />
                            </td>

                            <td>
                                <b>Auth Id Code :</b>
                            </td>
                            <td>
                                <input type="text" id="txt_payment_autho_code" />
                            </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="padding-top: 6px;"></td>
                    </tr>

                    <tr>
                        <td colspan="4" style="padding-top: 2px;"></td>
                    </tr>

                    <tr>
                        <td colspan="4" style="padding: 10px; background-color: #eff3f8; border-top: 1px solid #DDD;">
                            <center>
                                <input type="button" id="btn_update" style="line-height: inherit; display: block;" class="btn btn-lg btn-primary" value="Update" />
                            </center>
                        </td>
                        <%--<td><center>
                                <input type="button" id="btn_scholarship" style="line-height: inherit; display: block;" class="btn btn-lg btn-primary" value="Scholarship" onclick="rowClick(this)" />
                            </center></td>--%>
                    </tr>
                </table>



            </div>
            <br />

        </div>


    </div>
    <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_inst_no" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_status_tran" runat="server" clientidmode="Static" />
</asp:Content>

