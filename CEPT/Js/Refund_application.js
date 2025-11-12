
$(document).ready(function () {

    Get_refund_data();


    $('#btn_save').on('click', function () {
        Save_refund_application();
    });
    $('#btn_submit').on('click', function () {
      
        if ($('#txt_reason').val() == "") {
            bootbox.alert(" reason is not empty");
            return false;
        }

        if ($('#txt_acc_holder_name').val() == "") {
            bootbox.alert(" Account holder Name is not empty");
            return false;
        }

        if ($('#txt_bank_address').val() == "") {
            bootbox.alert(" Bank Address is not empty");
            return false;
        }
        
        if ($('#txt_account_type').val() == "") {
            bootbox.alert(" Bank Account Type  not empty");
            return false;
        }

        if ($('#txt_IFScode').val() == "") {
            bootbox.alert(" IFSC code is not empty");
            return false;
        }
        if ($('#txt_acount_number').val() == "") {
            bootbox.alert("Account is not empty");
            return false;
        }

        submit_refund_application();
    });

});

function Get_refund_data() {

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_Refund_Student_application",
        data: "{}",
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                var data = JSON.parse(data.d);
                if (data["status"] == "true") {

                    $('#lbl_app_name').html(data["message"][0]["full_name"]);
                    $('#lbl_app_id').html(data["message"][0]["student_no"]);
                    $('#lbl_mobile_no').html(data["message"][0]["mobile_no"]);
                    $('#lbl_email_id').html(data["message"][0]["mail"]);
                    $('#lbl_date_pay').html(data["message"][0]["datepayment"]);
                    $('#lbl_mode_pay').html(data["message"][0]["paymentmode"]);
                    $('#lbl_amount').html(data["message"][0]["amountpaid"])
                    $('#lbl_ref_amount').html(data["message"][0]["refund_amount"]);
                    $('#hdn_amount').val(data["message"][0]["refund_amount"]);
                    $('#hdn_trn_id').val(data["message"][0]["transaction_id"]);
                    $('#txt_reason').val(data["message"][0]["reason_for_dropwithdrawal"]);
                    $('#txt_acc_holder_name').val(data["message"][0]["name_of_account_holder"]);
                    $('#txt_bank_address').val(data["message"][0]["name_of_bank_address"]);
                    $('#txt_account_type').val(data["message"][0]["account_type"]);
                    $('#txt_IFScode').val(data["message"][0]["IFSC_code"]);
                    $('#txt_acount_number').val(data["message"][0]["account_number"]);

                    if (data["message"][0]["is_submit"] == "Y") {
                        $('#btn_save').css("display", "none");
                        $('#btn_submit').css("display", "none");

                    }
                }
                else if (data["status"] == 'False') {
                    //bootbox.alert(data["message"]);
                    location.href = "Dashboard.aspx";
                }

            }
        },
        Error: function (data) {

            alert(data.d);
        }

    });
    return false;

}

function Save_refund_application() {
    debugger;
    var obj_data = {};

    obj_data.transaction_id = $('#hdn_trn_id').val();
    obj_data.refund_amount = $('#hdn_amount').val();
    obj_data.reson = $('#txt_reason').val();
    obj_data.accoun_holder_name = $('#txt_acc_holder_name').val();
    obj_data.bank_address = $('#txt_bank_address').val();
    obj_data.account_type = $('#txt_account_type').val();
    obj_data.ifsc_code = $('#txt_IFScode').val();
    obj_data.account_number = $('#txt_acount_number').val();


    obj_data.is_submit = "N";

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/save_fees_refund",
        async: false,
        data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var response = JSON.parse(data.d);

                if (response['status'] == 'True') {
                    bootbox.alert(response['message'], function () {
                        location.reload();
                    });
                }
                else if (response['status'] == 'False') {
                    bootbox.alert(response['message']);
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });

}


function submit_refund_application() {
    debugger;
    var obj_data = {};

    obj_data.transaction_id = $('#hdn_trn_id').val();
    obj_data.refund_amount = $('#hdn_amount').val();
    obj_data.reson = $('#txt_reason').val();
    obj_data.accoun_holder_name = $('#txt_acc_holder_name').val();
    obj_data.bank_address = $('#txt_bank_address').val();
    obj_data.account_type = $('#txt_account_type').val();
    obj_data.ifsc_code = $('#txt_IFScode').val();
    obj_data.account_number = $('#txt_acount_number').val();


    obj_data.is_submit = "Y";

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/save_fees_refund",
        async: false,
        data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var response = JSON.parse(data.d);

                if (response['status'] == 'True') {
                    bootbox.alert(response['message'], function () {
                        location.reload();
                    });
                }
                else if (response['status'] == 'False') {
                    bootbox.alert(response['message']);
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });

}

var inputQuantity = [];
$(function () {
    $("#").each(function (i) {
        inputQuantity[i] = this.defaultValue;
        $(this).data("idx", i); // save this field's index to access later
    });
    $("#").on("keyup", function (e) {
        var $field = $(this),
            val = this.value,
            $thisIndex = parseInt($field.data("idx"), 10); // retrieve the index
        //        window.console && console.log($field.is(":invalid"));
        //  $field.is(":invalid") is for Safari, it must be the last to not error in IE8
        if (this.validity && this.validity.badInput || isNaN(val) || $field.is(":invalid")) {
            this.value = inputQuantity[$thisIndex];
            return;
        }
        if (val.length > Number($field.attr("maxlength"))) {
            val = val.slice(0,11);
            $field.val(val);
        }
        inputQuantity[$thisIndex] = val;
    });
});