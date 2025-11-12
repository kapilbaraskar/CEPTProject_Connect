<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Fees_Status.aspx.cs" Inherits="Student_Fees_Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

        <style>
        .fees-status-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 20px;
            margin: 20px 0;
        }

        .fees_status {
            width: 100% !important;
            border-collapse: separate;
            border-spacing: 0;
            margin: 0;
        }

        .fees_status thead th {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: #ffffff;
            font-weight: 600;
            padding: 15px;
            border-bottom: 2px solid #dee2e6;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 0.8px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
        }

        .fees_status tbody td {
            padding: 12px 15px;
            vertical-align: middle;
            border-bottom: 1px solid #dee2e6;
            color: #212529;
        }

        .fees_status tbody tr:hover {
            background-color: #f8f9fa;
        }

        .btnCheckOrderStatus {
            background: #007bff;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }

        .btnCheckOrderStatus:hover {
            background: #0056b3;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .panel-heading {
            background: #f8f9fa !important;
            border-bottom: 1px solid #dee2e6;
            padding: 15px 20px;
            border-radius: 8px 8px 0 0;
        }

        .panel-heading strong {
            color: #495057;
            font-size: 1.1rem;
        }
        .table thead th {
            background: linear-gradient(135deg, #2b6cb0 0%, #4299e1 100%);
            color: #ffffff;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.875rem;
            letter-spacing: 0.05em;
            border: none;
            padding: 1rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
    </style>

    <script>
        var semester = '';
        var year = '';
        var currenr_install_no = 0;

        $(document).ready(function () {

            get_fees_payment_dtl('');

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
                        if (data.d != '' && data.d != '[]') {
                            var fees_detail = JSON.parse(data.d);
                            debugger;
                            if (fees_detail["status"] == 'True') {
                                var user_fees_choice = fees_detail['message']['user_fees_choice'];
                                var user_fees_installment_dtl = fees_detail['message']['user_fees_installment_dtl'];
                                var user_fees_status = fees_detail['message']['user_fees_status'];
                                var user_credits_dtl = fees_detail['message']['user_credits_dtl'];

                                if (user_fees_choice != null) {
                                    if (user_fees_choice[0]['fees_status'] == 'F') {

                                        if (user_fees_installment_dtl != null) {
                                            var fees_data = user_fees_installment_dtl[0];

                                            semester = fees_data["semester_type"].toString();
                                            year = fees_data["year_semester"].toString();

                                            var sem = '';
                                            if (semester == 'M') sem = 'Monsoon';
                                            else if (semester == 'S') sem = 'Spring';

                                            var cur_installment = '';
                                            var no_of_installment = parseInt(fees_data["no_of_installment"].toString());
                                            for (var i = 1; i <= no_of_installment; i++) {
                                                if (fees_data["is_installment" + i + "_paid"] != "Y") {
                                                    cur_installment = i.toString();
                                                    break;
                                                }
                                            }

                                            currenr_install_no = cur_installment;
                                        }
                                    }
                                }
                            }
                        }
                    },
                    Error: function (data) {
                        alert(data.d);
                    }
                });
            }

            Get_fees_payment_pending_transaction(currenr_install_no);

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
                                //str = '<tr><td>0</td><td>1</td><td class="t_id">FCCFARUG1904181P2122113494</td><td>31250</td><td>2020-12-18</td><td><a class="btn btn-primary btn-small btnCheckOrderStatus">Check</a></td></tr>';
                                for (var k = 0; k < pending_transaction["message"].length; k++) {
                                    str += "<tr><td>" + (k + 1) + "</td>";
                                    str += "<td>" + cur_inst + "</td>";
                                    if (pending_transaction["message"][k]["user_id"] == "ucadmin") {
                                        str += "<td class='t_id'>FCCFARDAM01211P2122113765</td>";
                                    } else {
                                        str += "<td class='t_id'>" + pending_transaction["message"][k]["transaction_id"] + "</td>";
                                    }
                                    str += "<td>" + pending_transaction["message"][k]["amount"] + "</td>";
                                    str += "<td>" + pending_transaction["message"][k]["created_date"] + "</td>";
                                    str += "<td><a class='btn btn-primary btn-small btnCheckOrderStatus'>Check</a></td></tr>";
                                }

                                $(".fees_status tbody").append(str);
                                $(".divCheckOrderStatus").css('display', '');
                            } else {
                                //bootbox.alert(pending_transaction["message"]);
                                //str = '<tr><td>0</td><td>1</td><td class="t_id">FCCPFTucadmin4P2021083819</td><td>36000</td><td>2020-12-14 00:07:09.8270000</td><td><a class="btn btn-primary btn-small btnCheckOrderStatus">Check</a></td></tr>';

                                $(".fees_status tbody").append(str);
                                $(".divCheckOrderStatus").css('display', 'none');
                            }
                        }
                    },
                    Error: function (data) {
                        alert(data.d);
                    }
                });
            }

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

                        if (data.d == "ICICI Paymetn Success") {
                            
                            bootbox.alert("Paymetn Status Successfully Saved");
                            get_fees_payment_dtl('');
                        } 
                        else if (data.d != "") {
                            var res_api = data.d;
                            if (res_api == "Error") {
                                bootbox.alert("Error while Getting Fees Status. Please try again later.");
                            } else {
                                var res = res_api.split("&");
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
                        }
                        //if (data.d != '' && data.d != '[]') {
                        //    var request_object = JSON.parse(data.d);
                        //    if (request_object["status"] == 'True') {
                        //        request_data = request_object["message"];
                        //    } else {
                        //        call_api = false;
                        //        bootbox.alert(request_object["message"]);
                        //    }
                        //}
                    },
                    Error: function (data) {
                        alert(data.d);
                    }
                });

                //if (call_api) {
                //    $.ajax({
                //        type: "POST",
                //        //url: "https://logintest.ccavenue.com/apis/servlet/DoWebTrans",
                //        url: "https://login.ccavenue.com/apis/servlet/DoWebTrans",
                //        data: request_data,
                //        success: function (data) {
                //            if (data != "") {
                //                var res = data.split("&");
                //                var order_status_success = true;
                //                for (var i = 0; i < res.length; i++) {
                //                    if (res[i] == "status=1") {
                //                        order_status_success = false;
                //                        res[1] = res[1].replace("enc_response=", "");
                //                        bootbox.alert("Error while Getting Fees Status : <b>" + res[1] + "</b>");
                //                        //DecryptResponseandMakePaymentSuccess(enc_response);
                //                    }
                //                }

                //                if (order_status_success) {
                //                    //Decrypt Response
                //                    enc_response = res[1].replace("enc_response=", "");
                //                    console.log(enc_response);
                //                    $("#KotakAPIEncReponse").val(enc_response);
                //                    $('#hdn_send_response').click();
                //                    //DecryptResponseandMakePaymentSuccess(enc_response);
                //                }
                //            }
                //        },
                //        error: function (msg) { alert(msg.d); }
                //    });
                //}

            });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" style="margin-top: 10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Fees Status
            </h1>
        </div>
    </div>

    <div class="panel panel-default divCheckOrderStatus" style="display: none;">
        <div class="panel-heading">
            <strong>Fees Status</strong>
        </div>
        <div style="margin: 10px 0px 10px 10px;">
            <table class="table table-bordered cls_align_center fees_status" style="width: 70%; text-align: center;">
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

    <div style="display: none;">
        <asp:Button ID="hdn_send_response" runat="server" ClientIDMode="Static" OnClick="Send_Response" />
    </div>
    <input type="hidden" id="KotakAPIEncReponse" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="fees_sem" runat="server" clientidmode="Static" value="" />
    <input type="hidden" id="fees_year" runat="server" clientidmode="Static" value="" />
</asp:Content>

