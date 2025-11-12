<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="KotakPaymentStatus.aspx.cs" Inherits="Student_KotakPaymentStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('#btnreterive').on('click', function () {
                var reference_no = $('#reference_no').val();
                if (reference_no == "") {
                    bootbox.alert('Please enter reference no')
                    $('#reference_no').focus();
                    return false;
                }

                var order_no = $('#order_no').val();
                if (order_no == "") {
                    bootbox.alert('Please enter order no')
                    $('#order_no').focus();
                    return false;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/check_payment_status",
                    async: false,
                    data: "{reference_no :'" + reference_no + "',order_no :'" + order_no + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var result = JSON.parse(data.d);

                            if (result["status"] == 'True') {
                                debugger;
                                submitFormKotakNeftRtgs(result["message"]);
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

                return false;
            });
            function submitFormKotakNeftRtgs(param1) {
                    location.href = 'KotakRequestHandlerNR.aspx'; 
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" style="margin-top: 10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Payment Status
            </h1>
        </div>
    </div>
    <div id="div_fees_type" class="panel-body">
        <table border="0" cellpadding="5" cellspacing="5">
            <tr>
                <td>Reference No :
                </td>
                <td>
                    <input type="text" id="reference_no" />
                </td>
                <td>Order No :
                </td>
                <td>
                    <input type="text" id="order_no" />
                </td>
                <td colspan="6" align="center">
                    <button class="btn btn-primary" type="submit" id="btnreterive" style="border: 0px solid;">
                        Check Status
                    </button>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

