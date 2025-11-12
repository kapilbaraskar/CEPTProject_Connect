$(document).ready(function () {

    var userid = getParameterByName("userid");
    Get_refund_data(userid);

});

function Get_refund_data(data) {
    var obj_data = {};
    obj_data.userid = data;
    $.ajax({
        type: "POST",
        url: "../../WebService.asmx/Get_Refund_Student_application_report_form",
        data: "{userid:'" + JSON.stringify(obj_data) + "'}",
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
                    $('#txt_reason').html(data["message"][0]["reason_for_dropwithdrawal"]);
                    $('#txt_acc_holder_name').html(data["message"][0]["name_of_account_holder"]);
                    $('#txt_bank_address').html(data["message"][0]["name_of_bank_address"]);
                    $('#txt_account_type').html(data["message"][0]["account_type"]);
                    $('#txt_IFScode').html(data["message"][0]["IFSC_code"]);
                    $('#txt_acount_number').html(data["message"][0]["account_number"]);

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


function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}