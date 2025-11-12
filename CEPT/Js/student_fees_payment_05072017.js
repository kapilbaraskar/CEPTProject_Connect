
var pg_type = '';

$(document).ready(function () {

    $('#modal_fees').modal(
       {
           backdrop: 'static'
           //  keyboard: false
       });
    $('#modal_fees').modal('hide');

    // coding for online payment
    $('#btnonlinepayment').on('click', function () {

        $('#hdn_fees_type').val("O");

        $('#modal_fees').modal('show');
        //$('#refundpolicy').modal('show');

        pg_type = 'citrus'

        return false;

    });

    // coding for online payment Eazypay
    $('#btnonlineeazypay').on('click', function () {
        $('#hdn_fees_type').val("O");

        $('#modal_fees').modal('show');
        //$('#refundpolicy').modal('show');

        pg_type = 'eazypay';

        return false;
    });

    // coding for online payment HDFC
    $('#btnonlinehdfc').on('click', function () {
        $('#hdn_fees_type').val("O");

        $('#modal_fees').modal('show');
        //$('#refundpolicy').modal('show');

        pg_type = 'hdfc';

        return false;
    });

    $('#btn_refundpolicy').on('click', function () {
        if ($('#isaggre').not(':checked').length) {
            alert('Kindly agree to the Refund Policy');
            return false;
        }
        else {
            $('#refundpolicy').modal('hide');
            $('#modal_fees').modal('show');
            //$('#btn_save_fees_type').click();
        }
    });

    $('input[name=fees_status]:radio').on('change', function () {
        if ($('input[name=fees_status]:checked').val() == 'H') {
            $('#priority_selection').css('display', 'block');

        }
        else {
            $('#priority_selection').css('display', 'none');
        }
    });

    $('#btn_print').on('click', function () {

        $('#hdn_fees_type').val("M");

        $('#modal_fees').modal('show');
        //$('#refundpolicy').modal('show');

        return false;
    });

    $('#btn_save_fees_type').on('click', function () {
        var fees_status = $('input:radio[name=fees_status]:checked').val();

        if (fees_status == "") {
            bootbox.alert("Some problem found in save your fees type.");
            return false;
        }

        var selected_credits = "";

        if (fees_status == "H") {
            selected_credits = $('#drp_priority_select').val();
        }
        else {
            selected_credits
        }

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/save_user_fees_type_before_paid_fees",
            data: "{fees_status:'" + fees_status + "',selected_credits:'" + selected_credits + "',credit_choice:''}",
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    var result = JSON.parse(data.d);

                    if (result["status"]) {
                        $('#modal_fees').modal('hide');

                        if ($('#hdn_fees_type').val() == "O") {
                            bootbox.confirm("Are you sure you want to proceed?", function (result) {
                                if (result == true) {
                                    $.ajax({
                                        type: "POST",
                                        url: "../WebService.asmx/Create_online_payment_new",
                                        data: "{pg_type:'" + pg_type + "'}",
                                        contentType: "application/json; charset=utf-8",
                                        datatype: "json",
                                        success: function (data) {
                                            if (data.d != "") {
                                                //if (data.d == "Fail to Save Details.") {
                                                //    bootbox.alert(data.d);
                                                //    return false;
                                                //}

                                                //if (data.d == "Data Saved Successfully") {
                                                //    bind_sem_course_data();
                                                //    total_creadit = 0;
                                                //}
                                                
                                                var result = JSON.parse(data.d);

                                                if (result["status"]) {
                                                    if (pg_type == 'citrus') {
                                                        generateHMAC(result);
                                                    }
                                                    else if (pg_type == 'eazypay') {
                                                        location.href = result["eazypay_return_url"];
                                                    }
                                                    else if (pg_type == 'hdfc') {
                                                        submitFormHDFC(result);
                                                    }
                                                }
                                                else {
                                                    bootbox.alert(result["message"]);
                                                    return false;
                                                }

                                                //bootbox.alert(data.d);
                                                return false;
                                            }
                                        },
                                        error: function (msg) { alert(msg.d); }
                                    });
                                }
                            });
                        }
                        else {
                            bootbox.confirm("Are you sure you want to proceed?", function (result) {
                                if (result == true) {
                                    $.ajax({
                                        type: "POST",
                                        url: "../WebService.asmx/check_save_course_for_print_pay_in_slip_new",
                                        data: "{}",
                                        contentType: "application/json; charset=utf-8",
                                        datatype: "json",
                                        success: function (data) {
                                            if (data.d != "") {
                                                var result = JSON.parse(data.d);

                                                if (result["status"]) {
                                                    window.open('Print_pay_in_slip_new.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                                                    return false;
                                                }
                                                else {
                                                    bootbox.alert(result["message"]);
                                                    return false;
                                                }
                                                //bootbox.alert(data.d);
                                                return false;
                                            }
                                        },
                                        error: function (msg) { alert(msg.d); }
                                    });
                                }
                            });
                        }
                    }
                    else {
                        bootbox.alert(result["message"]);
                        $('#modal_fees').modal('hide');
                        return false;
                    }

                    return false;
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    });

    //coding for online payment
    $('#btn_new_online').on('click', function () {
        bootbox.confirm("Are you sure you want to proceed?", function (result) {
            if (result == true) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/Create_online_payment_new",
                    data: "{pg_type:'citrus'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var result = JSON.parse(data.d);

                            if (result["status"]) {
                                generateHMAC(result);
                            }
                            else {
                                bootbox.alert(result["message"]);
                                return false;
                            }
                            //bootbox.alert(data.d);
                            return false;
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
        });

        return false;
    });

    // coding for online payment Eazypay
    $('#btn_online_eazypay').on('click', function () {
        bootbox.confirm("Are you sure you want to proceed?", function (result) {
            if (result == true) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/Create_online_payment_new",
                    data: "{pg_type:'eazypay'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var result = JSON.parse(data.d);

                            if (result["status"]) {
                                location.href = result["eazypay_return_url"];
                            }
                            else {
                                bootbox.alert(result["message"]);
                                return false;
                            }
                            //bootbox.alert(data.d);
                            return false;
                        }
                    },
                    error: function (msg) {
                        alert(msg.d);
                    }
                });
            }
        });

        return false;
    });

    // coding for online payment Eazypay
    $('#btn_online_hdfc').on('click', function () {
        bootbox.confirm("Are you sure you want to proceed?", function (result) {
            if (result == true) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/Create_online_payment_new",
                    data: "{pg_type:'hdfc'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var result = JSON.parse(data.d);

                            if (result["status"]) {
                                submitFormHDFC(result);
                            }
                            else {
                                bootbox.alert(result["message"]);
                                return false;
                            }
                            //bootbox.alert(data.d);
                            return false;
                        }
                    },
                    error: function (msg) {
                        alert(msg.d);
                    }
                });
            }
        });

        return false;
    });

    $('#btn_new_manually').on('click', function () {
        //bootbox.alert('Payment is closed');
        //return false;

        //bootbox.confirm("Please make sure you have saved your courses.  Proceed?", function (result) {

        bootbox.confirm("Are you sure you want to proceed?", function (result) {

            if (result == true) {

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/check_save_course_for_print_pay_in_slip_new",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {

                        if (data.d != "") {

                            var result = JSON.parse(data.d);

                            if (result["status"]) {


                                window.open('Print_pay_in_slip_new.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                                return false;
                            }
                            else {

                                bootbox.alert(result["message"]);
                                return false;
                            }


                            //   bootbox.alert(data.d);
                            return false;
                        }


                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
        });


        return false;
    });

    chek_fees_type_status();

});

function chek_fees_type_status() {

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_student_fees_type_saved_data_for_before_paid_fees",
        data: {},
        contentType: "application/json",
        datatype: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {

                fees_type_status = JSON.parse(data.d);

                if (fees_type_status[0]["fees_status"] != "") {

                    if (fees_type_status[0]["fees_status"] == "H") {

                        //  $('input:radio[name=fees_status][value="H"]').prop('checked', true);

                        $('#rdb_half_fees').prop('checked', true);

                        $('#priority_selection').css('display', 'block');

                        $('#drp_priority_select').val(fees_type_status[0]["credit_selected"]);

                    }
                    else if (fees_type_status[0]["fees_status"] == "F") {
                        //  $('input:radio[name=fees_status][value="F"]').prop('checked', true);

                        $('#priority_selection').css('display', 'none');
                        $('#rdb_full_fees').prop('checked', true);

                    }
                    else {
                        $('#rdb_full_fees').prop('checked', true);

                        $('#priority_selection').css('display', 'none');
                    }

                }
            }


        },

        Error: function (data) {

            alert(data.d);
        }

    });

}

var merchantURLPart = "";
var vanityURLPart = "";
var reqObj = null;

function generateHMAC(param1) {
    document.getElementById("orderAmount").value = param1["amount"];
    document.getElementById("merchantTxnId").value = param1["transaction_id"];
    document.getElementById("currency").value = param1["currency"];
    document.getElementById("returnUrl").value = param1["return_url"];

    if (window.XMLHttpRequest) {
        reqObj = new XMLHttpRequest();
    }
    else {
        reqObj = new ActiveXObject("Microsoft.XMLHTTP");
    }

    merchantURLPart = param1["merchant_id"];

    if (merchantURLPart.lastIndexOf("/") != -1) {
        vanityURLPart = merchantURLPart.substring(merchantURLPart.lastIndexOf("/") + 1)
    }

    var orderAmount = document.getElementById("orderAmount").value;
    var merchantTxnId = document.getElementById("merchantTxnId").value;
    var currency = document.getElementById("currency").value;

    var param = "merchantId=" + vanityURLPart + "&orderAmount=" + orderAmount + "&merchantTxnId=" + merchantTxnId + "&currency=" + currency;

    reqObj.onreadystatechange = process;
    reqObj.open("POST", param1["hmac_url"] + "?" + param, false);
    reqObj.send(null);
}

function process() {
    if (reqObj.readyState == 4) {
        document.getElementById("secSignature").value = reqObj.responseText;
        submitForm();
    }
}

function submitForm() {
    document.aspnetForm.action = merchantURLPart;
    document.aspnetForm.method = 'POST';
    document.aspnetForm.submit();
}

function submitFormHDFC(param1) {
    $('#encRequest').val(param1["encRequest"]);
    $('#access_code').val(param1["access_code"]);
    document.aspnetForm.action = param1["hdfc_request_url"];
    document.aspnetForm.method = 'POST';
    document.aspnetForm.submit();
}
