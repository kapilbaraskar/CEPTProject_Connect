<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="hostel_fees_payment.aspx.cs" Inherits="Student_hostel_fees_payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style type="text/css">
        table tr td:first-child
        {
            width: 40%;
            font-weight: bold;
        }
        input[type=radio]
        {
            vertical-align: bottom;
        }
        #lbl_fess_Cert_file_name {
            color: blue;
            cursor: pointer;
            text-decoration: underline;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            get_student_dtl_for_hostel();

            $('#btn_pay_fees').on('click', function () {
                pay_hostel_fees();
            });

            $('input[name=rdo_apply_dtl]').on('change', function () {
                $('#tr_room').css('display', 'none');

                if ($('input[name=rdo_apply_dtl]:checked').length > 0)
                {
                    if ($('input[name=rdo_apply_dtl]:checked')[0].value == 'R') {
                        $('#tr_room').css('display', '');

                        if ($('#gender').text().toLowerCase() == 'f') {
                            $('#tr_room_g').css('display', '');
                        }
                        else if ($('#gender').text().toLowerCase() == 'm') {
                            $('#tr_room_b').css('display', '');
                        }
                    }
                    else {
                        $('#tr_room_g').css('display', 'none');
                        $('#tr_room_b').css('display', 'none');
                    }
                }
            });

            $('#lbl_fess_Cert_file_name').on('click', function () {

                var result = [{
                    docname: $('#lbl_fess_Cert_file_name').text(),
                    docurl: window.location.origin + '/HostelFeesDoc/' + $('#lbl_fess_Cert_file_name').text() // URL to the document file
                }];
                var tempLink = document.createElement('a');
                tempLink.href = result[0]['docurl'];
                tempLink.download = result[0]['docname'];

                tempLink.click();
            });
        });

        function get_student_dtl_for_hostel() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/get_student_dtl_for_hostel",
                data: '{}',
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        var result = JSON.parse(data.d);

                        $('#cls_td_stud_name').html(result[0]['full_name']);
                        $('#cls_td_dept').html(result[0]['dept_name']);
                        $('#cls_td_user_id').html(result[0]['user_id']);
                        $('#cls_td_prog').html(result[0]['prog_name']);
                        $('#cls_td_email').html(result[0]['mail']);
                        $('#gender').html(result[0]['gender']);
                        $('#lbl_fess_Cert_file_name').text(result[0]['docname']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function pay_hostel_fees() {
            if ($('input[name=rdo_apply_dtl]:checked').length > 0) {
                var stud_selection = $('input[name=rdo_apply_dtl]:checked')[0].value;
                var cur_room = $('#txt_room_num').val();

                if ($('#lbl_fess_Cert_file_name').text() == '') {
                    bootbox.alert('Please Upload Document');
                    return false;
                }

                if (stud_selection == 'R' && cur_room == '')
                {
                    bootbox.alert('Please enter your room number');
                    return false;
                }
                if (stud_selection == 'F') {
                    $('#drp_b').val('');
                    $('#drp_f').val('');
                    $('#txt_room_num').val('');
                }
                var block_name = "";
                if ($('#gender').text().toLowerCase() == 'f' && stud_selection == 'R')
                {
                    if ($('#drp_f').val() != '') {
                        block_name = $('#drp_f').val();
                    }
                    else
                    {
                        alert("Please Select Type");
                        return false;
                    }
                    
                }
                else if ($('#gender').text().toLowerCase() == 'm' && stud_selection == 'R')
                {
                    if ($('#drp_b').val() != '') {
                        block_name = $('#drp_f').val();
                    }
                    else {
                        alert("Please Select Type");
                        return false;
                    }
                    block_name = $('#drp_b').val();
                }
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/hostel_fees_payment",
                    data: "{student_selection:'" + stud_selection + "',cur_room:'" + cur_room + "',block_name:'" + block_name + "',docname:'" + $('#lbl_fess_Cert_file_name').text() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var result = JSON.parse(data.d);

                            if (result["status"]) {
                                //generateHMAC(result);
                                submitFormKotak(result["message"]);
                            }
                            else {
                                alert(result["message"]);
                                return false;
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            else {
                bootbox.alert('Please select whether you want to renew or want to apply fresh.');
                return false;
            }
        }

        function generateHMAC(param1) {
            document.getElementById("orderAmount").value = param1["amount"];
            document.getElementById("merchantTxnId").value = param1["transaction_id"];
            document.getElementById("currency").value = param1["currency"];
            document.getElementById("returnUrl").value = param1["return_url"];

            if (window.XMLHttpRequest) {
                reqObj = new XMLHttpRequest();
            } else {
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
            document.forms[0].action = merchantURLPart;
            document.forms[0].method = 'POST';
            document.forms[0].submit();

            //document.aspnetForm.action = merchantURLPart;
            //document.aspnetForm.method = 'POST';
            //document.aspnetForm.submit();
        }

        function submitFormKotak(param1) {
            location.href = 'KotakRequestHandler.aspx';
        }

        function Uploadfeesslip() {
            try {
                //var d = new Date();
                var fileToUpload = GetFileNameFromPath($('#uploadhostelpdf').val());
                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/HostelFessDocument.ashx',
                                secureuri: false,
                                fileElementId: 'uploadhostelpdf',
                                data: { 'ICODE': $("#hdnuserid").val(), 'FNAME': 'HostelFees', 'LNAME': 'HostelFees' },
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#uploadhostelpdf').val("");
                                            $('#lbl_fess_Cert_file_name').html('<b>' + data.upfile + '</b>');
                                            bootbox.alert("Hostel Fees Document Upload Successfully");
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    alert('Invalid File Type. Please Upload PDF File');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }

        }

        function GetFileNameFromPath(strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }
        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {

                    case 'pdf':
                    case 'PDF':

                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }
       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid" style="margin-top:10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Hostel Fees Payment
            </h1>
        </div>
    </div>
    
    <div id="pnl_pay_type" class="panel panel-default">
        <div class="panel-heading">
            <strong>Personal Detail</strong>
        </div>
        
        <div class="panel-body">
            <table class="table table-bordered">
                <tr>
                    <td>Student Name</td>
                    <td id="cls_td_stud_name"></td>
                </tr>
                <tr>
                    <td>Department</td>
                    <td id="cls_td_dept"></td>
                </tr>
                <tr>
                    <td>Code Number</td>
                    <td id="cls_td_user_id"></td>
                </tr>
                <tr>
                    <td>Program</td>
                    <td id="cls_td_prog"></td>
                </tr>
                <tr>
                    <td>Email ID</td>
                    <td id="cls_td_email"></td>
                </tr>
                <tr>
                    <td>Upload Document<span style="color:red;">*</span></td>
                    <td><label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                    <span><strong>Choose File</strong></span>
                                                    <input type="file" name="uploadhostelpdf" id="uploadhostelpdf" onchange="javascript:return Uploadfeesslip();" style="display: none;" >
                                                </label>
                                                <span id="lbl_fess_Cert_file_name" style="vertical-align: super;"></span>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        <input type="radio" name="rdo_apply_dtl" value="R" />&nbsp;&nbsp;I Would like to renew the hostel accommodation<br />
                        <input type="radio" name="rdo_apply_dtl" value="F" />&nbsp;&nbsp;I Would like to apply fresh
                    </td>
                </tr>
                <tr id="tr_room" style="display:none;">
                    <td>Room Number</td>
                    <td><input type="text" id="txt_room_num" /></td>
                </tr>
                <tr id="tr_room_b" style="display:none;">
                    <td>Type</td>
                    <td><select id="drp_b"><option value="">Select Type </option><option value="BH">Block-H </option><option value="BI">Block-I</option></select></td>
                </tr>
                <tr id="tr_room_g" style="display:none;">
                    <td>Type</td>
                    <td><select id="drp_f"><option value="">Select Type </option><option value="GS">Srishti</option><option value="GF">Block-F</option></select></td>
                </tr>
            </table>
            <br />
            <div align="center">
                <input type="button" id="btn_pay_fees" class="btn btn-primary btn-small" value="Pay Now" />
            </div>
        </div>
    </div>

    <input type="hidden" id="returnUrl" name="returnUrl" value="" />
    <input type="hidden" id="secSignature" name="secSignature" value="" />
    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
    <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
    <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
    <input style="display: none" type="text" id="currency" class="text" name="currency" value="INR" />
    <input type="hidden" id="gender" name="gender" value="" />
</asp:Content>

