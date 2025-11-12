<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Scholarship_amount_dtl.aspx.cs" Inherits="Admin_Master_Scholarship_amount_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script type="text/javascript">
        var fees_value = [];
        var paid_inst_val = [];
        var percentage = '';
        var scho_type = '';
        var status = true;
        var carry_forward_amount = '';
        $(document).ready(function () {


            if ($('#hdn_sem').val() == '' || $('#hdn_year').val() == '' || $('#hdn_user_id').val() == '') { }
            else {
                retrieveschalData();

            }
            $('#btn_save').on('click', function () {

                save_schol_detail();
                return false;
            });
            bindPercentage();
            bindScholarshipType();//new 12072021
            $('input[id$=txt_approve_date]').datepicker({
                dateFormat: 'dd-mm-yy'
            });
            //$("#drpper").change(function ()

            if (percentage != '') {
                myfunction(percentage);
            }
            if (scho_type != '') {
                sch_type_change(scho_type);
            }


        });
        $("#drpper").live('change', function () {
            // $("#drpper").change(function () {
            var selectedValue = $(this).val();
            if (selectedValue != '') {
                //var percentage = $('#txt_fees_amount').val() * parseInt(selectedValue) / 100;
                var percentage = $('#txt_fees_amount').val() * parseFloat(selectedValue).toFixed(2) / 100;
                $('#txt_approve_amount').val(percentage);
                get_schol_carry_amount();
            }
            else {
                $('#txt_approve_amount').val('');
            }
            //}

        });

        function retrieveschalData() {


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_scholship_dtl",
                async: false,
                data: "{user_id:'" + $('#hdn_user_id').val() + "',sem_code:'" + $('#hdn_sem').val() + "',year_code:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != '') {
                        var retrieved_Schol_data = JSON.parse(data.d);

                        $('#txt_stu_code').val(retrieved_Schol_data[0]['user_id']);
                        $('#txt_stu_name').val(retrieved_Schol_data[0]['full_name']);
                        $('#txt_fees_amount').val(retrieved_Schol_data[0]['fees_amount']);

                        percentage = retrieved_Schol_data[0]['scholarship_percentage'];

                        $('#txt_approve_amount').val(retrieved_Schol_data[0]['apprve_scholarship_amount']);
                        var approvedate = retrieved_Schol_data[0]['approve_date'];
                        if (approvedate != "" && typeof approvedate != 'undefined') {
                            approvedate = approvedate.substring(0, approvedate.length - 11);
                            var approvedate_ = changeformate(approvedate);
                            $('#txt_approve_date').val(approvedate_);
                        }


                        $('#txt_ref_no').val(retrieved_Schol_data[0]['ref_no']);
                        $('#txt_remark').val(retrieved_Schol_data[0]['remark']);

                        scho_type = retrieved_Schol_data[0]['scholarship_type'];
                        // sch_type_change(retrieved_Schol_data[0]['scholarship_type'])
                        //$('#scholar_type').val(retrieved_Schol_data[0]["scholarship_type"]);
                        //$('#scholar_type').change();
                        //$('#scholar_type').trigger("liszt:updated");

                        $('#txt_inst_1_amount').val(retrieved_Schol_data[0]['installment1']);
                        $('#txt_inst_2_amount').val(retrieved_Schol_data[0]['installment2']);
                        $('#txt_inst_3_amount').val(retrieved_Schol_data[0]['installment3']);
                        $('#txt_inst_4_amount').val(retrieved_Schol_data[0]['installment4']);
                        if (retrieved_Schol_data[0]['carry_forward_amount'] = 'null') {
                            $('#txt_carryforward_amount').val('');
                        }
                        else { $('#txt_carryforward_amount').val(retrieved_Schol_data[0]['carry_forward_amount']); }

                        if (retrieved_Schol_data[0]['is_installment1_paid'] == 'Y') {
                            $("#txt_inst_1_amount").attr("disabled", "disabled");
                            $('#ints_1_N').attr('disabled', 'disabled');
                            $('#ints_1_Y').attr('checked', 'checked');
                            paid_inst_val.push('1');

                        }
                        else {
                            fees_value.push(retrieved_Schol_data[0]['installment1']);

                        }
                        if (retrieved_Schol_data[0]['is_installment2_paid'] == 'Y') {
                            $("#txt_inst_2_amount").attr("disabled", "disabled");
                            $('#ints_2_N').attr('disabled', 'disabled');
                            $('#ints_2_Y').attr('checked', 'checked');
                            paid_inst_val.push('2');

                        }
                        else {
                            fees_value.push(retrieved_Schol_data[0]['installment2']);
                            //if (paid_inst_val.length == 0 && retrieved_Schol_data[0]['no_of_installment'] >= '2') {
                            //    paid_inst_val.push('2');
                            //}

                        }
                        if (retrieved_Schol_data[0]['is_installment3_paid'] == 'Y') {
                            $("#txt_inst_3_amount").attr("disabled", "disabled");
                            $('#ints_3_N').attr('disabled', 'disabled');
                            $('#ints_3_Y').attr('checked', 'checked');
                            paid_inst_val.push('3');


                        }
                        else {
                            fees_value.push(retrieved_Schol_data[0]['installment3']);
                            //if (paid_inst_val.length == 0 && retrieved_Schol_data[0]['no_of_installment'] >= '3') {
                            //    paid_inst_val.push('3');
                            //}
                        }
                        if (retrieved_Schol_data[0]['is_installment4_paid'] == 'Y') {
                            $("#txt_inst_4_amount").attr("disabled", "disabled");
                            $('#ints_4_N').attr('disabled', 'disabled');
                            $('#ints_4_Y').attr('checked', 'checked');
                            paid_inst_val.push('4');


                        } else {
                            fees_value.push(retrieved_Schol_data[0]['installment4']);
                            //if (paid_inst_val.length == 0 && retrieved_Schol_data[0]['no_of_installment'] >= '4') {
                            //    paid_inst_val.push('4');
                            //}
                        }

                        if (retrieved_Schol_data[0]['no_of_installment'] == '1') {
                            $("#txt_inst_2_amount").attr("disabled", "disabled");
                            $('#ints_2_N').attr('disabled', 'disabled');
                            $('#ints_2_Y').attr('disabled', 'disabled');



                            $("#txt_inst_3_amount").attr("disabled", "disabled");
                            $('#ints_3_N').attr('disabled', 'disabled');
                            $('#ints_3_Y').attr('disabled', 'disabled');
                            $("#txt_inst_4_amount").attr("disabled", "disabled");
                            $('#ints_4_N').attr('disabled', 'disabled');
                            $('#ints_4_Y').attr('disabled', 'disabled');
                        }
                        else if (retrieved_Schol_data[0]['no_of_installment'] == '2') {
                            $("#txt_inst_3_amount").attr("disabled", "disabled");
                            $('#ints_3_N').attr('disabled', 'disabled');
                            $('#ints_3_Y').attr('disabled', 'disabled');
                            $("#txt_inst_4_amount").attr("disabled", "disabled");
                            $('#ints_4_N').attr('disabled', 'disabled');
                            $('#ints_4_Y').attr('disabled', 'disabled');
                        }
                        else if (retrieved_Schol_data[0]['no_of_installment'] == '3') {
                            $("#txt_inst_4_amount").attr("disabled", "disabled");
                            $('#ints_4_N').attr('disabled', 'disabled');
                            $('#ints_4_Y').attr('disabled', 'disabled');
                        }

                        //

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function save_schol_detail() {
            if ($('#drpper').val() == '') {
                bootbox.alert("Please Select Scholarship Percentage");
                return false;
            }
            if ($('#txt_approve_date').val() == '') {
                bootbox.alert("Please Insert Approve Date");
                return false;
            }
            if ($('#txt_ref_no').val() == '') {
                bootbox.alert("Please Insert Ref No / Voucher No");
                return false;
            }
            var inst_1 = '';
            var inst_2 = '';
            var inst_3 = '';
            var inst_4 = '';
            var scholarship_type = '';

            if ($("#ints_1_Y").is(":checked")) {
                inst_1 = "Y";
            }
            else {
                inst_1 = '';
            }
            if ($("#ints_2_Y").is(":checked")) {
                inst_2 = "Y";
            }
            else { inst_2 = ''; }
            if ($("#ints_3_Y").is(":checked")) {
                inst_3 = "Y";
            }
            else { inst_3 = ''; }
            if ($("#ints_4_Y").is(":checked")) {
                inst_4 = "Y";
            }
            else { inst_4 = ''; }

            if ($('#scholar_type').val() != '') {
                scholarship_type = $('#scholar_type').val();
            }
            else {
                scholarship_type = '';
            }

            var obj_schol_data = {

                'user_id': $('#txt_stu_code').val(),
                'total_fees_amount': $('#txt_fees_amount').val(),
                'scholarship_percentage': $('#drpper').val(),
                'apprve_scholarship_amount': $('#txt_approve_amount').val(),
                'approve_date': $('#txt_approve_date').val(),
                'ref_no': $('#txt_ref_no').val(),
                'remark': $('#txt_remark').val(),

                'installment1': $('#txt_inst_1_amount').val(),
                'installment2': $('#txt_inst_2_amount').val(),
                'installment3': $('#txt_inst_3_amount').val(),
                'installment4': $('#txt_inst_4_amount').val(),
                'is_installment1_paid': inst_1,
                'is_installment2_paid': inst_2,
                'is_installment3_paid': inst_3,
                'is_installment4_paid': inst_4,
                'carry_forward_amount': carry_forward_amount,
                'semester_type': $('#hdn_sem').val(),
                'year_semester': $('#hdn_year').val(),
                'scholarship_type': scholarship_type

            };


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_scholarship_detail",
                async: false,
                data: "{scholarship_data:'" + JSON.stringify(obj_schol_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == "True") {
                        alert("Data Save Successfully");
                        location.reload();
                    }
                    else { bootbox.alert("Problem In Data"); }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function changeformate(values) {
            var parts = values.split('/');
            var year = parts[2].split(' ');
            var dmyDate = parts[1] + '-' + parts[0] + '-' + year[0];
            return dmyDate;
        }

        function get_schol_carry_amount() {
            if (paid_inst_val.length > 0) {
                var paid_installment_amount = '';
                var approved_amount = $('#txt_approve_amount').val();
                var total_fess_amount = $('#txt_fees_amount').val();
                for (var i = 0; i < paid_inst_val.length; i++) {
                    inst_no = parseInt(i) + parseInt('1');
                    if (i == 0) {

                        paid_installment_amount = $('#txt_inst_' + inst_no + '_amount').val();
                    }
                    else {
                        paid_installment_amount = parseInt(paid_installment_amount) + parseInt($('#txt_inst_' + inst_no + '_amount').val());
                    }
                    //var installment_amount = $('#txt_inst_' + paid_inst_val[0] + '_amount').val();
                }
                var carry = parseInt(paid_installment_amount) + parseInt(approved_amount) - parseInt(total_fess_amount);

                if (parseInt(paid_installment_amount) + parseInt(approved_amount) > parseInt(total_fess_amount)) {
                    carry_forward_amount = parseInt(carry);
                    $('#txt_carryforward_amount').val(carry_forward_amount);
                }
                else {
                    carry_forward_amount = '';
                    $('#txt_carryforward_amount').val('');
                }

            }

        }


        function bindPercentage() {
            $('#drpper').empty().append($("<option></option>").val("").html("-- Please Select Percentage --"));
            $('#drpper').append($("<option></option>").val("10").html("10%"));
            $('#drpper').append($("<option></option>").val("20").html("20%"));
            $('#drpper').append($("<option></option>").val("12.85").html("12.85%"));
            $('#drpper').append($("<option></option>").val("30").html("30%"));
            $('#drpper').append($("<option></option>").val("40").html("40%"));
            $('#drpper').append($("<option></option>").val("50").html("50%"));
            $('#drpper').append($("<option></option>").val("60").html("60%"));
            $('#drpper').append($("<option></option>").val("70").html("70%"));
            $('#drpper').append($("<option></option>").val("80").html("80%"));
            $('#drpper').append($("<option></option>").val("90").html("90%"));
            $('#drpper').append($("<option></option>").val("100").html("100%"));

            $('#drpper').chosen();
        }
        function myfunction(per) {

            $('#drpper').val(per);
            $('#drpper').change();
            $('#drpper').trigger("liszt:updated");

        }
        function sch_type_change(scho) {

            $('#scholar_type').val(scho);
            $('#scholar_type').change();
            $('#scholar_type').trigger("liszt:updated");

        }

        //function bindScholarshipType() {
        //    $('#scholar_type').empty().append($("<option></option>").val("").html("-- Please Select Scholarship Type --"));
        //    $('#scholar_type').append($("<option></option>").val("10").html("10%"));
        //    $('#scholar_type').append($("<option></option>").val("20").html("20%"));
        //    $('#scholar_type').append($("<option></option>").val("30").html("30%"));
        //    $('#scholar_type').append($("<option></option>").val("40").html("40%"));
        //    $('#scholar_type').append($("<option></option>").val("50").html("50%"));
        //    $('#scholar_type').append($("<option></option>").val("60").html("60%"));
        //    $('#scholar_type').append($("<option></option>").val("70").html("70%"));
        //    $('#scholar_type').append($("<option></option>").val("80").html("80%"));
        //    $('#scholar_type').append($("<option></option>").val("90").html("90%"));
        //    $('#scholar_type').append($("<option></option>").val("100").html("100%"));
        //        
        //    $('#scholar_type').chosen();
        //}


        function bindScholarshipType() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_scholarship_mst_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d);

                        $('#scholar_type').empty().append($("<option></option>").val("").html("-- Please Select Scholarship --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#scholar_type').append($("<option></option>").val(year_data[i]["scholarship_type_code"]).html(year_data[i]["scholarship_name"]));
                        }

                        $('#scholar_type').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    </script>
    <style>
        label {
            float: left;
            clear: none;
            display: block;
            padding: 0px 1em 0px 8px;
        }

        input[type=radio],
        input.radio {
            float: left;
            clear: none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">

        <div id="div_fees_bank_dtl" style="margin-top: 15px; margin-bottom: 40px;" class="panel panel-default">


            <div class="panel-heading">
                <strong>Scholarship Detail</strong>
            </div>
            <div style="padding-top: 15px;">
                <table border="0" cellpadding="2" cellspacing="2" style="width: 100%;" align="center">

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
                            <b>Scholarship Percentage</b>
                        </td>
                        <td>
                            <select class="chosen-select" id="drpper"></select>
                        </td>
                    </tr>

                    <tr>

                        <td style="padding-left: 15px;">
                            <b>Approve Scholarship Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_approve_amount" readonly />
                        </td>
                        <td>
                            <b>Approve Date</b>
                        </td>
                        <td>
                            <input type="text" id="txt_approve_date" />
                        </td>


                    </tr>
                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Ref No / Voucher No.</b>
                        </td>
                        <td>
                            <input type="text" id="txt_ref_no" />
                        </td>
                        <td>
                            <b>Remark </b>
                        </td>
                        <td>
                            <%-- <input type="text" id="txt_remark" />--%>
                            <textarea id="txt_remark" rows="4" cols="50"></textarea>
                        </td>


                    </tr>
                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Installment 1 Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_inst_1_amount" />
                        </td>
                        <td>
                            <b>Installment 2 Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_inst_2_amount" />
                        </td>



                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-bottom: 26px; padding-top: 26px;">
                            <b>Payment installment 1 Paid</b>
                        </td>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="ints_1_Yes" id="ints_1_Y">Yes</label>
                            <label class="radio-inline">
                                <input type="radio" name="ints_1_Yes" id="ints_1_N" checked>No</label>
                        </td>
                        <td>
                            <b>Payment installment 2 Paid</b>
                        </td>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="ints_2_Yes" id="ints_2_Y">Yes</label>
                            <label class="radio-inline">
                                <input type="radio" name="ints_2_Yes" id="ints_2_N" checked>No</label>
                        </td>



                    </tr>
                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Installment 3 Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_inst_3_amount" />
                        </td>
                        <td>
                            <b>Installment 4 Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_inst_4_amount" />
                        </td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px; padding-bottom: 26px; padding-top: 26px;">
                            <b>Payment installment 3 Paid</b>
                        </td>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="ints_3_Yes" id="ints_3_Y">Yes</label>
                            <label class="radio-inline">
                                <input type="radio" name="ints_3_Yes" id="ints_3_N" checked>No</label>
                        </td>
                        <td>
                            <b>Payment installment 4 Paid</b>
                        </td>
                        <td>
                            <label class="radio-inline">
                                <input type="radio" name="ints_4_Yes" id="ints_4_Y">Yes</label>
                            <label class="radio-inline">
                                <input type="radio" name="ints_4_Yes" id="ints_4_N" checked>No</label>
                        </td>



                    </tr>

                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Carry Forward Amount</b>
                        </td>
                        <td>
                            <input type="text" id="txt_carryforward_amount" readonly />
                        </td>
                        <td>
                            <b>Scholarship Type</b>
                        </td>
                        <td>
                            <select class="chosen-select" id="scholar_type"></select>
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
                                <input type="button" id="btn_save" style="line-height: inherit; display: block;" class="btn btn-lg btn-primary" value="Save" />
                            </center>
                        </td>
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
</asp:Content>

