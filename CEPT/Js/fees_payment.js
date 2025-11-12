var pg_type = '';
var semester = '';
var year = '';
var currenr_install_no = 0;
var installment_date = [];
$(document).ready(function () {

    if ($('#hdnuserid').val() == 'ucadmin' || $('#hdnuserid').val() == 'test_student' || $('#hdnuserid').val() == 'test_student1' || $('#hdnuserid').val() == 'test_student2' || $('#hdnuserid').val() == 'test_student3' || $('#hdnuserid').val() == 'test_student4' || $('#hdnuserid').val() == 'test_student5')
    { $('#enableeazpay').css('display', '') } else { $('#enableeazpay').css('display', '') }
    if ($("#hdn_year_code").val() == "Y2020" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2020")
    {
        $(".Y2020").css('display', '');
    }
    if ($("#hdn_year_code").val() == "Y2021" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2021" && $("#hdn_created_by").val() != "ACPC") {
        $(".Y2020").css('display', '');
    }
    get_dynamic_fees_date();//24062022
    if ($("#hdn_user_id").val() == "ucadmin") {
        //$(".divCheckOrderStatus").css('display', '');
    }

    $('.cls_align_center tbody tr td:first-child').css('text-align', 'left');

    $('input[name=fees_status]:radio').on('change', function () {
        if ($('input[name=fees_status]:checked').val() == 'H') {
            //$('#priority_selection').css('display', 'block');
        }
        else {
            $('#priority_selection').css('display', 'none');
        }
    });

    $('input:radio[name=fees_status],#drp_priority_select').on('change', function () {
        $('#pnl_pay_type').css('display', 'none');
        $('#pnl_full_fees_detail').css('display', 'none');
        $('#pnl_installment_detail').css('display', 'none');
        $('#pnl_pay_fees').css('display', 'none');
        $('input:radio[name=rdo_pay_type]').removeAttr('checked');
        $('#chk_credits').removeAttr('checked');
        $('input:radio[name=rdo_pay_fees]').removeAttr('checked');
        $('#div_online_pay_option').css('display', 'none');
        $('#div_offline_pay_option').css('display', 'none');
        $('.cls_pg_charges').css('display', 'none');
        $('input:radio[name=rdo_online_pay_option]').removeAttr('checked');
        $('input:radio[name=rdo_offline_pay_option]').removeAttr('checked');

        if ($('input:radio[name=fees_status]:checked').val() == 'F') {
            $('#rdo_offline_pay_yes').closest('label').css('display', 'block');
        }
        else {
            //$('#rdo_offline_pay_yes').closest('label').css('display', 'none');
            $('#rdo_offline_pay_yes').closest('label').css('display', 'block');
        }
    });

    $('input:radio[name=rdo_pay_type]').on('change', function () {
        $('#pnl_full_fees_detail').css('display', 'none');
        $('#pnl_installment_detail').css('display', 'none');
        $('#pnl_pay_fees').css('display', 'none');
        $('input:radio[name=rdo_pay_fees]').removeAttr('checked');
        $('#div_online_pay_option').css('display', 'none');
        $('#div_offline_pay_option').css('display', 'none');
        $('.cls_pg_charges').css('display', 'none');
        $('input:radio[name=rdo_online_pay_option]').removeAttr('checked');
        $('input:radio[name=rdo_offline_pay_option]').removeAttr('checked');
    });

    //Added by mayur
    $('input:radio[name=rdo_offline_pay_option]').on('change', function () {
        $('input:radio[name=rdo_online_pay_option]').removeAttr('checked');

        var pg_type = $('input:radio[name=rdo_offline_pay_option]:checked').val();
        if (pg_type == "icici") {
            $('#online_pay').css('display', 'none');
            $('#offline_pay').css('display', '');
        }
    });

    $('input:radio[name=rdo_online_pay_option]').on('change', function () {
        $('input:radio[name=rdo_offline_pay_option]').removeAttr('checked');

        var pg_type = $('input:radio[name=rdo_online_pay_option]:checked').val();
        if (pg_type == "kotak") {
            $('#online_pay').css('display', '');
            $('#offline_pay').css('display', 'none');
        }
    });

    $('input:radio[name=rdo_offline_pay_option]').removeAttr('checked');
    //Added by mayur

    $('input:radio[name=rdo_pay_fees]').on('change', function () {
        $('#div_online_pay_option').css('display', 'none');
        $('#div_offline_pay_option').css('display', 'none');
        $('.cls_pg_charges').css('display', 'none');
        $('input:radio[name=rdo_online_pay_option]').removeAttr('checked');
        $('input:radio[name=rdo_offline_pay_option]').removeAttr('checked');
        $('#spn_online_pay_option').css('display', 'none');
        $('#spn_offline_pay_option').css('display', 'none');

        if ($('input:radio[name=rdo_pay_fees]:checked').val() == 'ON') {
            $('#div_online_pay_option').css('display', 'block');
            $('#spn_online_pay_option').css('display', 'inline-block');
        }
        else if ($('input:radio[name=rdo_pay_fees]:checked').val() == 'OFF') {
            $('#div_offline_pay_option').css('display', 'block');
            $('#spn_offline_pay_option').css('display', 'inline-block');
        }
    });

    $('#btn_save_fees_type').on('click', function () {
        $('#pnl_pay_type').css('display', 'none');
        $('#pnl_full_fees_detail').css('display', 'none');
        $('#pnl_installment_detail').css('display', 'none');
        $('#pnl_pay_fees').css('display', 'none');
        $('input:radio[name=rdo_pay_type]').removeAttr('checked');
        $('#chk_credits').removeAttr('checked');
        $('input:radio[name=rdo_pay_fees]').removeAttr('checked');

        var fees_status = $('input:radio[name=fees_status]:checked').val();

        if (fees_status == "") {
            bootbox.alert("Please try again.");
            return false;
        }

        var selected_credits = "";

        if (fees_status == "Q") {
            fees_status = 'H';
            selected_credits = '5';
        }
        else if (fees_status == "H") {
            //selected_credits = $('#drp_priority_select').val();
            selected_credits = '10';
        }
        else {
            //selected_credits
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

                    if (result["status"])
                    {
                        if ($('input:radio[name=fees_status]:checked').val() == 'F') {
                            $('#pnl_pay_type').css('display', 'block');
                        }
                        else if ($('input:radio[name=fees_status]:checked').val() == 'H' || $('input:radio[name=fees_status]:checked').val() == 'Q') {
                            get_fees_installment_detail(1);
                            $('#pnl_full_fees_detail').css('display', 'block');
                            $('#pnl_pay_fees').css('display', 'block');
                        }
                        //Changes BY Nitinbhai 04012024
                        if ($('input:radio[name=fees_status]:checked').val() == 'H') {
                            get_fine_dtl();
                        }
                        
                    }
                    else {
                        bootbox.alert(result["message"]);
                        return false;
                    }

                    return false;
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    });

    $('#btn_pay_type_next').on('click', function () {
        $('#pnl_full_fees_detail').css('display', 'none');
        $('#pnl_installment_detail').css('display', 'none');
        $('#pnl_pay_fees').css('display', 'none');
        $('input:radio[name=rdo_pay_fees]').removeAttr('checked');

        var rdo_pay_type = $('input:radio[name=rdo_pay_type]:checked').val();

        if (rdo_pay_type == "F") {
            get_fees_installment_detail(1);
            $('#pnl_full_fees_detail').css('display', 'block');
            $('#pnl_pay_fees').css('display', 'block');
        }
        else if (rdo_pay_type == "I") {
            get_fees_installment_detail(4);//Open 5th Installment Start
            $('#pnl_installment_detail').css('display', 'block');
            $('#pnl_pay_fees').css('display', 'block');
        }

        currenr_install_no = parseInt(currenr_install_no);
        get_fine_dtl();
        //dynamic Bind Fees Date
        get_dynamic_fees_date();
    });

    $('#btn_pay_now_online').on('click', function () {

        if ($('input[name=fees_status]:checked').val() == 'H' || $('input[name=fees_status]:checked').val() == 'Q') {
            //create_online_payment();
            installment_create_online_payment();
        }
        else if ($('input[name=fees_status]:checked').val() == 'F') {
            installment_create_online_payment();
        }
    });

    $('#btn_pay_now_kotak_neft_rtgs').on('click', function () {

        if ($('input[name=fees_status]:checked').val() == 'H' || $('input[name=fees_status]:checked').val() == 'Q') {
            //create_online_payment();
            installment_create_online_payment_kotak_neft_rtgs();
        }
        else if ($('input[name=fees_status]:checked').val() == 'F') {
            installment_create_online_payment_kotak_neft_rtgs();
        }
    });

    $('#btn_pay_now_offline').on('click', function () {
        if ($('input[name=fees_status]:checked').val() == 'H' || $('input[name=fees_status]:checked').val() == 'Q') {
            //create_pay_in_slip();
            installment_create_pay_in_slip();
        }
        else if ($('input[name=fees_status]:checked').val() == 'F') {
            installment_create_pay_in_slip();
        }
    });

    Check_Fees_Payment_Block();

    get_fees_payment_dtl('ready');

    get_fine_dtl();

    $('#btn_pay_now_kotak_neft_rtgs').css('display', 'none');
    /*Have added for selection remove after done start*/ //Added by mayur
    //$("#rdb_full_fees")[0].checked = true;
    //$('#btn_save_fees_type').trigger('click');
    //$("#rdo_pay_full")[0].checked = true;
    //$('#btn_pay_type_next').trigger('click');
    //$("#rdo_pay_offline")[0].checked = true;
    //$("#div_offline_pay_option").css('display','');
    /*Have added for selection remove after done start*/ //Added by mayur

    Get_fees_payment_pending_transaction(currenr_install_no);

    $('.btnCheckOrderStatus').on('click', function () {
        var request_data = "";
        var enc_response = "";

        var t_id = $(this).parent().parent().find('.t_id').text();
        var call_api = true;

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/Create_request_for_check_order_status",
            data: "{transaction_id:'" + t_id + "'}",
            //data: "{transaction_id:'FCCFOPPUD202111P2122089328'}",//FCCFARUA56171P2021084257
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {
                if (data.d != '' && data.d != '[]') {
                    var request_object = JSON.parse(data.d);
                    if (request_object["status"] == 'True') {
                        request_data = request_object["message"];
                    } else {
                        call_api = false;
                        bootbox.alert(request_object["message"]);
                    }
                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });

        if (call_api) {
            $.ajax({
                type: "POST",
                //url: "https://logintest.ccavenue.com/apis/servlet/DoWebTrans",
                url: "https://login.ccavenue.com/apis/servlet/DoWebTrans",
                data: request_data,
                success: function (data) {
                    if (data != "") {
                        var res = data.split("&");
                        var order_status_success = true;
                        for (var i = 0; i < res.length; i++) {
                            if (res[i] == "status=1") {
                                order_status_success = false;
                                res[1] = res[1].replace("enc_response=", "");
                                bootbox.alert("Error while Getting Fees Status : <b>" + res[1] + "</b>");
                                //DecryptResponseandMakePaymentSuccess(enc_response);
                            }
                        }

                        if (order_status_success) {
                            //Decrypt Response
                            enc_response = res[1].replace("enc_response=", "");
                            console.log(enc_response);
                            $("#KotakAPIEncReponse").val(enc_response);
                            $('#hdn_send_response').click();
                            //DecryptResponseandMakePaymentSuccess(enc_response);
                        }
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }

    });
    
});

function DecryptResponseandMakePaymentSuccess(enc_response) {
    var response_data = "";

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/DecryptResponseandMakePaymentSuccess",
        data: "{enc_response:'" + enc_response + "'}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != '' && data.d != '[]') {
                var response_object = JSON.parse(data.d);
                console.log(response_object);

                if (response_object["status"] == 'True') {
                    response_data = response_object["message"];
                    console.log(response_object);
                } else {
                    console.log(response_object);
                    //alert(response_object["message"]);
                }
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
}

function Get_fees_payment_pending_transaction(current_install_no) {

    var cur_inst = parseInt(current_install_no);

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_fees_payment_pending_transaction",
        data: "{installment_no:" + cur_inst + ", fees_sem:'" + $("#fees_sem").val() + "', fees_year:'" + $("#fees_year").val() + "'}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != '' && data.d != '[]') {
                var pending_transaction = JSON.parse(data.d);
                if (pending_transaction["status"] == 'True') {
                    var str = "";
                    //str = '<tr><td>0</td><td>1</td><td class="t_id">FCCPFTucadmin4P2021083821</td><td>31250</td><td>2020-12-18</td><td><a class="btn btn-primary btn-small btnCheckOrderStatus">Check</a></td></tr>';
                    for (var k = 0; k < pending_transaction["message"].length; k++) {
                        str += "<tr><td>" + (k + 1) + "</td>";
                        str += "<td>" + cur_inst + "</td>";
                        str += "<td class='t_id'>" + pending_transaction["message"][k]["transaction_id"] + "</td>";
                        str += "<td>" + pending_transaction["message"][k]["amount"] + "</td>";
                        str += "<td>" + pending_transaction["message"][k]["created_date"] + "</td>";
                        str += "<td><a class='btn btn-primary btn-small btnCheckOrderStatus'>Check</a></td></tr>";
                    }

                    $(".fees_status tbody").append(str);
                    //$(".divCheckOrderStatus").css('display', '');
                } else {
                    //bootbox.alert(pending_transaction["message"]);
                    //str = '<tr><td>0</td><td>1</td><td class="t_id">FCCPFTucadmin4P2021083819</td><td>36000</td><td>2020-12-14 00:07:09.8270000</td><td><a class="btn btn-primary btn-small btnCheckOrderStatus">Check</a></td></tr>';

                    $(".fees_status tbody").append(str);
                    //$(".divCheckOrderStatus").css('display','none');
                }
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
}

$(document).on('click', '#chk_credits', function () {
    $('#rdo_pay_full').change();
});

function change_no_of_installment(no_of_installment) {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/change_no_of_installment",
        data: "{ no_of_installment: " + no_of_installment + "}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != '' && data.d != '[]') {
                var response = JSON.parse(data.d);
                if (response["status"] == 'True') {
                    get_fees_payment_dtl('');
                    get_fine_dtl();
                }
                else {
                    alert(response["message"]);
                }
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
}

function get_fees_payment_dtl(ready) {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_fees_payment_dtl",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            $('#pnl_choose_credits').css('display', 'block');
            if (data.d != '' && data.d != '[]') {
                var fees_detail = JSON.parse(data.d);

                if (fees_detail["status"] == 'True') {
                    var user_fees_choice = fees_detail['message']['user_fees_choice'];
                    var user_fees_installment_dtl = fees_detail['message']['user_fees_installment_dtl'];
                    var user_fees_status = fees_detail['message']['user_fees_status'];
                    var user_credits_dtl = fees_detail['message']['user_credits_dtl'];

                    if (user_fees_choice != null) {
                        if (user_fees_choice[0]['fees_status'] == 'F') {
                            $('#rdb_full_fees').attr('checked', 'checked');
                            $('#pnl_pay_type').css('display', 'block');

                            if (user_fees_installment_dtl != null) {
                                var fees_data = user_fees_installment_dtl[0];

                                semester = fees_data["semester_type"].toString();
                                year = fees_data["year_semester"].toString();

                                var sem = '';
                                if (semester == 'M') sem = 'Monsoon';
                                else if (semester == 'S') sem = 'Spring';

                                $('.spn_sem').html(sem + ' - ' + year);

                                var cur_installment = '';
                                var no_of_installment = parseInt(fees_data["no_of_installment"].toString());
                                var total_amount = '';
                                var fees_paid = 0;

                                for (var i = 1; i <= no_of_installment; i++) {
                                    if (fees_data["is_installment" + i + "_paid"] != "Y") {
                                        cur_installment = i.toString();
                                        break;
                                    }
                                    else if (fees_data["is_installment" + i + "_paid"] == "Y") {
                                        fees_paid += parseInt(fees_data["installment" + i].toString());
                                    }
                                }

                                if (cur_installment == 3) {
                                    $(".Y2020").css('display', 'none');
                                }

                                if (cur_installment == '') {
                                    bootbox.alert("You have already paid your fees", function () {
                                        location.href = "Dashboard.aspx";
                                    });
                                }

                                currenr_install_no = cur_installment;

                                if (currenr_install_no == 1)
                                {
                                    if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2020")
                                    {//BID
                                        $("#pnl_choose_credits").css('display', 'none');
                                        $("#pnl_pay_type").css('display', 'none');
                                        $(".BCT_BID_HIDE").css('display', 'none');
                                    }

                                    if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2020")
                                    {//BID// && $("#hdn_dept_code").val() == "2"
                                        $(".Y2020").css('display', 'none');
                                    }
                                }

                                $('#spn_fees_paid').html(fees_paid);
                                $('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                                total_amount = parseInt(fees_data["fees_amount"]);
                                $('.cls_no_of_installment').html(fees_data["no_of_installment"]);
                                $('.cls_cur_installment').html(cur_installment);
                                $('.cls_cur_installment_amount').html(fees_data["installment" + cur_installment]);

                                $('#tbl_fees_detail').css('display', 'block');

                                $('.tbl_balance_payable tr').css('display', 'none');

                                //$('.td_installment1').html('' + total_amount / no_of_installment);
                                $('.td_installment1').html(fees_data["installment1"]);
                                $('.tr_balance_payable1').css('display', '');

                                if (no_of_installment > 1) {
                                    //$('.td_installment2').html('' + total_amount / no_of_installment);
                                    $('.td_installment2').html(fees_data["installment2"]);
                                    $('.tr_balance_payable2').css('display', '');
                                }
                                if (no_of_installment > 2) {
                                    //$('.td_installment3').html('' + total_amount / no_of_installment);
                                    $('.td_installment3').html(fees_data["installment3"]);
                                    $('.tr_balance_payable3').css('display', '');
                                }
                                //Open 5th Installment Start
                                if (no_of_installment > 3) {
                                    //$('.td_installment4').html('' + total_amount / no_of_installment);
                                    $('.td_installment4').html(fees_data["installment4"]);
                                    $('.tr_balance_payable4').css('display', '');
                                }
                                //Open 5th Installment End
                                $('.tr_balance_payable').css('display', '');

                                if (user_fees_installment_dtl[0]['no_of_installment'] == '1' && user_fees_installment_dtl[0]['fees_type'] != 'H') {
                                    $('#rdo_pay_full').attr('checked', 'checked');
                                    $('#pnl_full_fees_detail').css('display', 'block');
                                    $('#pnl_pay_fees').css('display', 'block');
                                }
                                //else if (user_fees_installment_dtl[0]['no_of_installment'] == '3') {
                                else if (parseInt(user_fees_installment_dtl[0]['no_of_installment']) > 1) {
                                    $('#rdo_pay_installment').attr('checked', 'checked');
                                    $('#pnl_installment_detail').css('display', 'block');
                                    $('#pnl_pay_fees').css('display', 'block');
                                }

                                if (ready == "ready") {
                                    if (cur_installment != '') {
                                        if (parseInt(cur_installment) > 1) {
                                            $('#rdb_half_fees').parent()[0].outerHTML = '';
                                            $('#priority_selection')[0].outerHTML = '';
                                            $('#btn_save_fees_type').parent()[0].outerHTML = '';
                                            $('#rdo_pay_full').parent()[0].outerHTML = '';
                                            $('#btn_pay_type_next').parent()[0].outerHTML = '';

                                            $('#pnl_choose_credits').css('display', 'none');
                                            $('#pnl_pay_type').css('display', 'none');
                                        }
                                    }
                                } else {
                                    $('#pnl_choose_credits').css('display', 'none');
                                    $('#pnl_pay_type').css('display', 'none');
                                }
                                if (no_of_installment == 3)
                                {
                                    $('input[name=y2020_fees_pay_type]')[0].checked = true;
                                    
                                  $(".ins1").html(installment_date[0]['installment_1_date']);
                                  $(".ins2").html(installment_date[0]['installment_2_date']);
                                  $(".ins3").html(installment_date[0]['installment_3_date']);
                                  $(".ins4").html(installment_date[0]['installment_4_date']);
                                   
                                    

                                    //if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2020") {//BID
                                    //    $(".ins1").html('20th October 2020');
                                    //    $(".ins2").html('4th December 2020');
                                    //    $(".ins3").html('4th January 2020');
                                    //    $(".ins4").html('4th February 2021');
                                    //}
                                    //else if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "S" && $("#fees_year").val() == "2021") {//BID
                                    //    $(".ins1").html('21st March 2021');
                                    //    $(".ins2").html('16th April 2021');
                                    //    $(".ins3").html('14th May 2021');
                                    //    $(".ins4").html('11th June 2021');
                                    //}
                                    //else if ($("#hdn_year_code").val() == "Y2021" && $("#hdn_prog_code").val() == "1" && $("#hdn_fond").val() == "Y" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2021") {
                                    //    $(".ins1").html('20th November 2021 (MON)');
                                    //    $(".ins2").html('1st December 2021 (THU)');
                                    //    $(".ins3").html('1st January 2022 (SAT)');
                                    //    $(".ins4").html('1st February 2022 (TUE)');
                                    //}
                                    //else if ($("#hdn_year_code").val() == "Y2021") {
                                    //    $(".ins1").html('26st July 2022 (MON)');
                                    //    $(".ins2").html('9th September 2022 (THU)');
                                    //    $(".ins3").html('9th October 2022 (SAT)');
                                    //    $(".ins4").html('9th November 2022 (TUE)');
                                    //}
                                    //else {
                                    //    //$(".ins2").html('21st August 2020');
                                    //}

                                }
                                if (no_of_installment == 2) {
                                    $('input[name=y2020_fees_pay_type]')[1].checked = true;
                                    // change 02072022
                                    //if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2020")
                                    //{//BID
                                    //    $(".ins1").html('20th October 2020');
                                    //    $(".ins2").html('20th November 2020');
                                    //}
                                    //else if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "S" && $("#fees_year").val() == "2021")
                                    //{//BID
                                    //    $(".ins1").html('21st March 2021');
                                    //    $(".ins2").html('16th April 2021');
                                    //    $(".ins3").html('14th May 2021');
                                    //    $(".ins4").html('11th June 2021');
                                    //}
                                    //else if ($("#hdn_year_code").val() == "Y2021" && $("#hdn_prog_code").val() == "1" && $("#hdn_fond").val() == "Y" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2021")
                                    //{
                                    //    $(".ins1").html('20th November 2021 (MON)');
                                    //    $(".ins2").html('1st December 2021 (THU)');
                                    //    $(".ins3").html('1st January 2022 (SAT)');
                                    //    $(".ins4").html('1st February 2022 (TUE)');
                                    //}
                                    //else if ($("#hdn_year_code").val() == "Y2021" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2021")
                                    //{
                                    //    $(".ins2").html('09th September 2021 (THU) ');
                                    //}
                                    //else {
                                    //    $(".ins2").html('09th September 2021 (THU)');
                                    //}


                                    $(".ins1").html(installment_date[0]['installment_1_date']);
                                    $(".ins2").html(installment_date[0]['installment_2_date']);
                                    $(".ins3").html(installment_date[0]['installment_3_date']);
                                    $(".ins4").html(installment_date[0]['installment_4_date']);
                                }
                            }
                        }
                        else if (user_fees_choice[0]['fees_status'] == 'H') {
                            if (user_fees_installment_dtl != null) {
                                var fees_data = user_fees_installment_dtl[0];

                                var no_of_installment_half = parseInt(fees_data["no_of_installment"].toString());
                                for (var h = 1; h <= no_of_installment_half; h++) {
                                    if (fees_data["is_installment" + h + "_paid"] != "Y") {
                                        currenr_install_no = h.toString();
                                        break;
                                    }
                                }
                            }

                            if (user_fees_choice[0]['credit_selected'].toString() == '5') {
                                $('#rdb_quarter_fees').attr('checked', 'checked');
                            }
                            else {
                                $('#rdb_half_fees').attr('checked', 'checked');
                            }

                            //$('#priority_selection').css('display', 'block');
                            $('#drp_priority_select').val(user_fees_choice[0]['credit_selected']);
                            $('#pnl_full_fees_detail').css('display', 'block');
                            $('#pnl_pay_fees').css('display', 'block');

                            if (user_fees_installment_dtl != null) {
                                var fees_data = user_fees_installment_dtl[0];

                                semester = fees_data["semester_type"].toString();
                                year = fees_data["year_semester"].toString();

                                var sem = '';
                                if (semester == 'M') sem = 'Monsoon';
                                else if (semester == 'S') sem = 'Spring';

                                $('.spn_sem').html(sem + ' - ' + year);
                                $('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                            }

                            if (user_fees_status != null) {
                                bootbox.alert("You have already paid your fees", function () {
                                    location.href = "Dashboard.aspx";
                                });
                            }
                        }

                        if ($('input:radio[name=fees_status]:checked').val() == 'F') {
                            $('#rdo_offline_pay_yes').closest('label').css('display', 'block');
                        }
                        else {
                            //$('#rdo_offline_pay_yes').closest('label').css('display', 'none');
                            $('#rdo_offline_pay_yes').closest('label').css('display', 'block');
                        }
                    }

                    if (user_credits_dtl != null && user_credits_dtl[0]['carry_forwarded_credit'] != '0') {
                        var str_html = '';
                        if (user_credits_dtl[0]['used_in'] == 'connect')
                            str_html = '<input type="checkbox" id="chk_credits" checked />';
                        else
                            str_html = '<input type="checkbox" id="chk_credits" />';

                        //str_html += '&nbsp;Use ' + (parseInt(user_credits_dtl[0]['carry_forwarded_credit']) - parseInt(user_credits_dtl[0]['used_forwarded_credit'])) + ' carry forwarded credits in current fees payment';
                        //str_html += '&nbsp;Use ' + user_credits_dtl[0]['carry_forwarded_credit'] + ' carry forwarded credits in current fees payment';

                        //str_html += '&nbsp;Carry forward unused credits from previous semesters ( <b>' + user_credits_dtl[0]['carry_forwarded_credit'] + ' available</b> )';
                        $('#div_credits').html('');//str_html // Removed 17 12 2019 By Mahroofbhai un comment above line
                    }
                }
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
}

function get_fine_dtl() {
if (parseInt(currenr_install_no) > 0) {
        var installment_no = parseInt(currenr_install_no);

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/get_fine_dtl",
            data: "{installment_no:" + installment_no + ", type : 'O'}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {

                if (data.d != '' && data.d != '[]') {
                    var fees_detail = JSON.parse(data.d);
                    if (fees_detail["status"] != 'False') {
                        if (parseInt(fees_detail["message"]) > 0) {// || installment_no == 2 && fees_detail["status"] != "0"
                            $(".cls_tr_fine").css("display", "");
                            $(".cls_fine_amount").html(parseInt(fees_detail["message"]));// + ' (' + fees_detail["status"] + ' day)'
                        } else {
                            $(".cls_tr_fine").css("display", "none");
                            $(".cls_fine_amount").html();
                        }
                    }
                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });
    }
}

function Check_Fees_Payment_Block() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Check_Fees_Payment_Block",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != '' && data.d != '[]') {
                var fees_detail = JSON.parse(data.d);
                if (!fees_detail["status"]) {
                    bootbox.alert(fees_detail["message"], function () {
                        location.href = "Dashboard.aspx";
                    });
                }
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
}

function get_fees_installment_detail(installment_no) {
    var chk_credits = 'N';

    if ($('#chk_credits:checked').length > 0) chk_credits = 'Y';

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_fees_installment_dtl",
        data: "{sem_code:'', year_code:'', no_of_installment:" + installment_no + ", chk_credits:'" + chk_credits + "'}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != '' && data.d != '[]') {
                var fees_detail = JSON.parse(data.d);

                if (fees_detail["status"] == 'True') {
                    var fees_data = fees_detail['message'][0];

                    semester = fees_data["semester_type"].toString();
                    year = fees_data["year_semester"].toString();

                    var sem = '';
                    if (semester == 'M') sem = 'Monsoon';
                    else if (semester == 'S') sem = 'Spring';

                    $('.spn_sem').html(sem + ' - ' + year);

                    var cur_installment = '';
                    var no_of_installment = parseInt(fees_data["no_of_installment"].toString());
                    var total_amount = '';
                    var fees_paid = 0;

                    for (var i = 1; i <= no_of_installment; i++) {
                        if (fees_data["is_installment" + i + "_paid"] != "Y") {
                            cur_installment = i.toString();
                            break;
                        }
                        else if (fees_data["is_installment" + i + "_paid"] == "Y") {
                            fees_paid += parseInt(fees_data["installment" + i].toString());
                        }
                    }

                    if (cur_installment == 3) {
                        $(".Y2020").css('display', 'none');
                    }

                    if (cur_installment == '') {
                        bootbox.alert("You have already paid your fees", function () {
                            location.href = "Dashboard.aspx";
                        });
                    }

                    currenr_install_no = cur_installment;

                    $('#spn_fees_paid').html(fees_paid);
                    $('.spn_fees_to_pay').html(fees_data["fees_amount"]);
                    total_amount = parseInt(fees_data["fees_amount"]);
                    $('.cls_no_of_installment').html(fees_data["no_of_installment"]);
                    $('.cls_cur_installment').html(cur_installment);
                    $('.cls_cur_installment_amount').html(fees_data["installment" + cur_installment]);

                    $('#tbl_fees_detail').css('display', 'block');

                    $('.tbl_balance_payable tr').css('display', 'none');

                    //$('.td_installment1').html('' + total_amount / no_of_installment);
                    $('.td_installment1').html(fees_data["installment1"]);
                    $('.tr_balance_payable1').css('display', '');

                    if (no_of_installment > 1) {
                        //$('.td_installment2').html('' + total_amount / no_of_installment);
                        $('.td_installment2').html(fees_data["installment2"]);
                        $('.tr_balance_payable2').css('display', '');
                    }
                    if (no_of_installment > 2) {
                        //$('.td_installment3').html('' + total_amount / no_of_installment);
                        $('.td_installment3').html(fees_data["installment3"]);
                        $('.tr_balance_payable3').css('display', '');
                    }
                    //Open 5th Installment Start
                    if (no_of_installment > 3) {
                        //$('.td_installment4').html('' + total_amount / no_of_installment);
                        $('.td_installment4').html(fees_data["installment4"]);
                        $('.tr_balance_payable4').css('display', '');
                    }
                    //Open 5th Installment End
                    $('.tr_balance_payable').css('display', '');

                    if (no_of_installment == 4)
                    {
                        $('input[name=y2020_fees_pay_type]')[0].checked = true;
                        //if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2020")
                        //{//BID// && $("#hdn_dept_code").val() == "2" 
                        //    $(".ins2").html('21st August 2020');
                        //}

                        $(".ins1").html(installment_date[0]['installment_1_date']);
                        $(".ins2").html(installment_date[0]['installment_2_date']);
                        $(".ins3").html(installment_date[0]['installment_3_date']);
                        $(".ins4").html(installment_date[0]['installment_4_date']);
                    }
                    if (no_of_installment == 2)
                    {
                        $('input[name=y2020_fees_pay_type]')[1].checked = true;
                        //if ($("#hdn_year_code").val() == "Y2020" && $("#hdn_prog_code").val() == "1" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2020")
                        //{//BID// && $("#hdn_dept_code").val() == "2"
                        //    $(".ins2").html('20th July 2020');
                        //}
                        //else if ($("#hdn_year_code").val() == "Y2021" && $("#fees_sem").val() == "M" && $("#fees_year").val() == "2021") {
                        //    $(".ins2").html('09th September 2021 (MON)');
                        //}

                        $(".ins1").html(installment_date[0]['installment_1_date']);
                        $(".ins2").html(installment_date[0]['installment_2_date']);
                        $(".ins3").html(installment_date[0]['installment_3_date']);
                        $(".ins4").html(installment_date[0]['installment_4_date']);
                    }
                    if (no_of_installment == 3)
                    {
                        $('input[name=y2020_fees_pay_type]')[1].checked = true;
                        $(".ins1").html(installment_date[0]['installment_1_date']);
                        $(".ins2").html(installment_date[0]['installment_2_date']);
                        $(".ins3").html(installment_date[0]['installment_3_date']);
                    }
                }
                else if (fees_detail["status"] == 'False') {
                    bootbox.alert(fees_detail["message"], function () {
                        location.href = "Dashboard.aspx";
                    });
                }
            }
        },
        error: function (data) {
            alert(data.d);
        }
    });
}

function create_online_payment() {
    pg_type = '';

    if ($('input:radio[name=rdo_online_pay_option]:checked').length > 0) {
        pg_type = $('input:radio[name=rdo_online_pay_option]:checked').val();

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/Create_online_payment_new",
            data: "{pg_type:'" + pg_type + "'}",
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    var result = JSON.parse(data.d);

                    if (result["status"]) {
                        if (pg_type == 'citrus') {
                            generateHMAC(result);
                        }
                        else if (pg_type == 'eazypay')
                        {
                            //location.href = result["eazypay_return_url"];
                            //document.forms[0].action = result["eazypay_return_url"];
                            //document.forms[0].method = 'POST';
                            //document.forms[0].submit();
                        }
                        else if (pg_type == 'hdfc') {
                            submitFormHDFC(result);
                        }
                        else if (pg_type == 'kotak') {
                            submitFormKotak(result);
                        }
                    }
                    else {
                        bootbox.alert(result["message"]);
                        return false;
                    }

                    return false;
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    }
}

function installment_create_online_payment() {

    pg_type = '';

    if ($('input:radio[name=rdo_online_pay_option]:checked').length > 0) {
        pg_type = $('input:radio[name=rdo_online_pay_option]:checked').val();

        var data = JSON.stringify({ 'pg_type': pg_type });

        $.ajax({
            type: "POST", 
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/installment_create_online_payment",
            async: false,
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    var result = JSON.parse(data.d);

                    if (result["status"] == 'True') {
                        if (pg_type == 'citrus') {
                            generateHMAC(result["message"]);
                        }
                        else if (pg_type == 'eazypay')
                        {
                            //Before it is commented start
                            //var eazypay_url = result["message"]["eazypay_return_url"].toString();
                            //location.href = result["eazypay_return_url"];
                            //document.forms[0].action = eazypay_url;
                            //document.forms[0].method = 'POST';
                            //document.forms[0].submit();
                            //Before it is commented end
                            location.href = 'EazypayRequestHandler.aspx';
                        }
                        else if (pg_type == 'hdfc') {
                            submitFormHDFC(result["message"]);
                        }
                        else if (pg_type == 'kotak') {
                            submitFormKotak(result["message"]);
                        }
                    }
                    else {
                        bootbox.alert(result["message"]);
                    }
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
}

//Added by mayur
function installment_create_online_payment_kotak_neft_rtgs() {

    pg_type = '';

    if ($('input:radio[name=rdo_offline_pay_option]:checked').length > 0) {
        pg_type = $('input:radio[name=rdo_offline_pay_option]:checked').val();

        var data = JSON.stringify({ 'pg_type': pg_type });

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../WebService.asmx/installment_create_online_payment",
            async: false,
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    var result = JSON.parse(data.d);

                    if (result["status"] == 'True') {
                        //if (pg_type == 'kotak_neft_rtgs') {
                        //    submitFormKotakNeftRtgs(result["message"]);
                        //}
                    }
                    else {
                        bootbox.alert(result["message"]);
                    }
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
}
//Added by mayur

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
    //$('#encRequest').val(param1["encRequest"]);
    //$('#access_code').val(param1["access_code"]);
    //document.aspnetForm.action = param1["hdfc_request_url"];
    //document.aspnetForm.method = 'POST';
    //document.aspnetForm.submit();

    location.href = 'HDFCRequestHandler.aspx';
}

function submitFormKotak(param1) {
    //$('#encRequest').val(param1["encRequest"]);
    //$('#access_code').val(param1["access_code"]);
    ////document.aspnetForm.action = param1["kotak_request_url"];
    //document.aspnetForm.action = 'KotakRequestHandler.aspx';
    ////document.aspnetForm.method = 'POST';
    //document.aspnetForm.submit();

    location.href = 'KotakRequestHandler.aspx';
}

//Added by mayur
function submitFormKotakNeftRtgs(param1) {
    //$('#encRequest').val(param1["encRequest"]);
    //$('#access_code').val(param1["access_code"]);
    ////document.aspnetForm.action = param1["kotak_request_url"];
    //document.aspnetForm.action = 'KotakRequestHandler.aspx';
    ////document.aspnetForm.method = 'POST';
    //document.aspnetForm.submit();

    //location.href = 'KotakRequestHandlerNR.aspx'; uncomment this code
}
//Added by mayur

var off_pg_type = '';
function create_pay_in_slip() {
    off_pg_type = '';

    if ($('input:radio[name=rdo_offline_pay_option]:checked').length > 0) {
        off_pg_type = $('input:radio[name=rdo_offline_pay_option]:checked').val();

        if (off_pg_type == 'eazypay') {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Create_online_payment_new",
                data: "{pg_type:'" + off_pg_type + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                    if (data.d != "") {
                        var result = JSON.parse(data.d);

                        if (result["status"]) {
                            if (off_pg_type == 'eazypay') {
                                ////location.href = result["eazypay_return_url"];
                                //document.forms[0].action = result["eazypay_return_url"];
                                //document.forms[0].method = 'POST';
                                //document.forms[0].submit();
                            }
                        }
                        else {
                            bootbox.alert(result["message"]);
                            return false;
                        }

                        return false;
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }
        else if (off_pg_type == 'icici') {//icici
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
                        return false;
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }
        else if (off_pg_type == 'yes') {
            bootbox.alert('Please Transfer your fees to \"' + $('#hdn_yes_virtual_acc').val() + '\" using NEFT');
        }
    }
}

function installment_create_pay_in_slip() {
    off_pg_type = '';

    if ($('input:radio[name=rdo_offline_pay_option]:checked').length > 0) {
        off_pg_type = $('input:radio[name=rdo_offline_pay_option]:checked').val();

        if (off_pg_type == 'eazypay') {
            var data = JSON.stringify({ 'pg_type': off_pg_type });

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/installment_create_online_payment",
                async: false,
                data: data,
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        var result = JSON.parse(data.d);

                        if (result["status"] == 'True') {
                            if (off_pg_type == 'eazypay') {
                                //var eazypay_url = result["message"]["eazypay_return_url"].toString();
                                //document.forms[0].action = eazypay_url;
                                //document.forms[0].method = 'POST';
                                //document.forms[0].submit();
                            }
                        }
                        else {
                            bootbox.alert(result["message"]);
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        else if (off_pg_type == 'icici') {//icici
            //window.open('Fees_installment_pay_in_slip.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
            $('#hdn_download_icici').click();
            return false;
        }
        else if (off_pg_type == 'kotak') {
            //window.open('Fees_installment_pay_in_slip_kotak.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
            return false;
        }
        //else if (off_pg_type == 'yes') {06 03 2020 Email Mahroofbhai Stops
        //    //bootbox.alert('Please Transfer your fees to \"' + $('#hdn_yes_virtual_acc').val() + '\" using NEFT');
        //    $('#hdn_download').click();
        //}
    }
}

function pg_change(ele_id)
{
    $('.cls_pg_charges').css('display', 'none');
    if (ele_id == 'online_eazypay')
    {
        $('#online_pay').css('display', 'block');
    }
    else
    {
        $('#' + ele_id).css('display', 'block');
    }
    

    $('#spn_online_pay_option').css('display', 'none');
    $('#spn_offline_pay_option').css('display', 'none');
}


function get_dynamic_fees_date() {

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_dynamic_fees_installment_date",
        data: "",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data)
        {
            if (data.d != '' && data.d != '[]')
            {
                var get_fees_date = JSON.parse(data.d);
                installment_date = get_fees_date;
            }
        },
        Error: function (data) {
            //alert(data.d);
        }
    });

}