<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BTG_Registration.aspx.cs"
    Inherits="BTG_BTG_Registration" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Responsive HTML template for Your company">
    <meta name="author" content="Oskar Żabik (oskar.zabik@gmail.com)">
    <!-- Le styles -->
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/typica-login.css" rel="stylesheet" type="text/css" />
    <link href="../DesignJS/Spinner/ladda-themeless.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/Validation.css" rel="stylesheet" />
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le favicon -->
    <link rel="shortcut icon" href="../favicon.ico">
    <style type="text/css">
        
    </style>
</head>
<body>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <h2>
                    <span class="hidden-phone" style="">
                        <img src="../image/capture.png" height="500px" />
                        <span style="font-size: small"></span></span>
                </h2>
            </div>
        </div>
    </div>
    <div class="container" style="margin-bottom: 0px;">
        <div id="signupbox" style="margin-top: 0px; margin-left: 0px;" class="mainbox col-md-12 col-md-offset-3 col-sm-8 col-sm-offset-2">
            <div class="panel panel-info" style="margin-top: 20px;    border-color: #08c;" >
                <div class="panel-heading" style="background-color: #08c; border-color: #08c;">
                    <div class="panel-title">
                        Register</div>
                </div>
                <div class="panel-body">
                    <form id="frm_btg_registration" style="padding-top: 10px;" runat="server">
                    <asp:ScriptManager ID="ScriptManager11" runat="server">
                        <Services>
                            <asp:ServiceReference Path="~/WebService.asmx" />
                        </Services>
                    </asp:ScriptManager>
                    <div class="row">
                        <div class="form-group col-sm-10">
                            <div class="form-group col-sm-3">
                                No of Team members <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <select id="drp_no_of_team" name="drp_no_of_team" class="form-control">
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-sm-10">
                            <table id="tbl_team_member" style="margin-left: 10px;" class="display table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>
                                            Sr No
                                        </th>
                                        <th>
                                            Name
                                        </th>
                                        <th>
                                            Email
                                        </th>
                                        <th>
                                            Mobile No
                                        </th>
                                        <th>
                                            College
                                        </th>
                                        <th>
                                            Department
                                        </th>
                                        <th>
                                            Year
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group col-sm-12" style="margin-top: 10px;">
                            <div align="center">
                                <button type="button" id="btnSave" onclick="return Register();" class="btn btn-success" style="background-image: linear-gradient(to bottom,#08c,#08c); background-color: #08c;    border-left-color: #08c;">
                                    Register
                                </button>
                            </div>
                           <%-- <div align="center" style="color: Red; margin-top: 5px;">
                                Clicking on the register button will redirect you to a payment gateway
                            </div>--%>
                                <div align="center" style="color: Black; margin-top: 5px;">
                              Note: Your entry is accepted for BTG 2016. Kindly take the print of the registration page and contact Venkat Doshi on +91 8980962096

                            </div>

                        </div>
                    </div>
                    <input type="hidden" id="returnUrl" name="returnUrl" value="" />
                    <input type="hidden" id="secSignature" name="secSignature" value="" />
                    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
                    <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId"
                        value="" />
                    <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount"
                        value="" />
                    <input style="display: none" type="text" id="currency" class="text" name="currency"
                        value="INR" />
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../DesignJS/bootstrap.min.js" type="text/javascript"></script>
    <%--<script src="../DesignJS/backstretch.min.js" type="text/javascript"></script>--%>
    <%--<script src="../DesignJS/typica-login.js" type="text/javascript"></script>--%>
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="../DesignJS/Spinner/spin.min.js" type="text/javascript"></script>
    <script src="../DesignJS/Spinner/ladda.min.js" type="text/javascript"></script>
    <script src="../DesignJS/bootbox.min.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        $(document).ready(function () {

            $('#tbl_team_member tbody').html('');

            var var_tbl_team_member = "<tr>" +
             "<td class='sr_no'>1</td>" +
                                     "<td><input name='txt_name'  style='width: 150px;' type='text' class='txt_name'/></td>" +
                                     "<td><input name='txt_email' style='width: 150px;' type='text' class='txt_email'/></td>" +
                                     "<td><input name='txt_mobile' maxlength=10 style='width: 150px;' type='text' class='txt_mobile' onkeypress='return IsNumeric(event);'/></td>" +
                                     "<td><input style='width: 200px;' type='text' class='txt_college'/></td>" +
                                     "<td><input style='width: 150px;' type='text' class='txt_department'/></td>" +
                                     "<td><input style='width: 100px;' maxlength='4' type='text' class='txt_year' onkeypress='return IsNumeric(event);'/></td></tr>";

            $('#tbl_team_member tbody').append(var_tbl_team_member);

            $('#drp_no_of_team').on('change', function () {
                debugger;

                var datalist = [];
                $("#tbl_team_member tbody tr").each(function (i) {

                    var obj = {};

                    obj["name"] = $(this).find('.txt_name').val().trim();
                    obj["email_id"] = $(this).find('.txt_email').val().trim();
                    obj["mobile_no"] = $(this).find('.txt_mobile').val().trim();
                    obj["college"] = $(this).find('.txt_college').val().trim();
                    obj["department"] = $(this).find('.txt_department').val().trim();
                    obj["year"] = $(this).find('.txt_year').val().trim();

                    datalist.push(obj);
                });

                $('#tbl_team_member tbody').html('');

                for (var i = 0; i < $('#drp_no_of_team').val(); i++) {

                    $('#tbl_team_member tbody').append(var_tbl_team_member);
                }

                $("#tbl_team_member tbody tr").each(function (i) {

                    $(this).find('.sr_no').html((i + 1));
                    if (datalist.length > i) {
                        $(this).find('.txt_name').val(datalist[i]["name"]);
                        $(this).find('.txt_email').val(datalist[i]["email_id"]);
                        $(this).find('.txt_mobile').val(datalist[i]["mobile_no"]);
                        $(this).find('.txt_college').val(datalist[i]["college"]);
                        $(this).find('.txt_department').val(datalist[i]["department"]);
                        $(this).find('.txt_year').val(datalist[i]["year"]);
                    }
                });
            });
        });

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 37 || keyCode == 38 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                return true;
            }
            else {
                return false;
            }
        }

        var reg_res;
        var err;
        var uc;
        var method;
        function Register() {


            var flag = 'N';
            var datalist = [];
            $("#tbl_team_member tbody tr").each(function (i) {
                debugger;
                if ($(this).find('.txt_name').val().trim() == "") {

                    bootbox.alert('Please Enter Name of Team Member ' + (i + 1));
                    flag = 'Y';
                    return false;
                }

                if ($(this).find('.txt_email').val().trim() == "") {

                    bootbox.alert('Please Enter Email of Team Member ' + (i + 1));
                    flag = 'Y';
                    return false;
                }
                else {
                    var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;

                    if (!testEmail.test($(this).find('.txt_email').val())) {
                        bootbox.alert("Enter Valid Email of Team Member " + (i + 1));
                        flag = 'Y';
                        return false;
                    }
                }


                if ($(this).find('.txt_mobile').val().trim() == "") {

                    bootbox.alert('Please Enter Mobile of Team Member ' + (i + 1));
                    flag = 'Y';
                    return false;
                }
                else {
                    if ($(this).find('.txt_mobile').val().length != 10) {
                        bootbox.alert('Please Enter 10 digit Mobile of Team Member ' + (i + 1));
                        flag = 'Y';
                        return false;
                    }
                }
                if ($(this).find('.txt_college').val().trim() == "") {

                    bootbox.alert('Please Enter College of Team Member ' + (i + 1));
                    flag = 'Y';
                    return false;
                }


                if ($(this).find('.txt_department').val().trim() == "") {

                    bootbox.alert('Please Enter Department of Team Member ' + (i + 1));
                    flag = 'Y';
                    return false;
                }

                if ($(this).find('.txt_year').val().trim() == "") {
                    bootbox.alert('Please Enter Year of Team Member ' + (i + 1));
                    flag = 'Y';
                    return false;
                }
                else {
                    if ($(this).find('.txt_year').val().length != 4) {
                        bootbox.alert('Please Enter 4 digit Year of Team Member ' + (i + 1));
                        flag = 'Y';
                        return false;
                    }
                }
            });

            if (flag == "N") {


                var BTG_datalist = [];
                $("#tbl_team_member tbody tr").each(function (i) {
                    
                    var BTG_obj = {};

                    BTG_obj["sr_no"] = (i + 1);
                    BTG_obj["name"] = $(this).find('.txt_name').val().trim();
                    BTG_obj["email_id"] = $(this).find('.txt_email').val().trim();
                    BTG_obj["mobile_no"] = $(this).find('.txt_mobile').val().trim();
                    BTG_obj["college"] = $(this).find('.txt_college').val().trim();
                    BTG_obj["department"] = $(this).find('.txt_department').val().trim();
                    BTG_obj["year"] = $(this).find('.txt_year').val().trim();

                    BTG_datalist.push(BTG_obj);
                });

                var register_data = { no_of_team_member: $('#drp_no_of_team').val(), teamd_data: BTG_datalist };
                WebService.payment_BTG_registration(JSON.stringify(register_data), OnCallComplete, OnCallError);
            }
        }

        function OnCallComplete(res, methodName) {
            reg_res = res;
            method = methodName;

            var result = JSON.parse(res);
            if (result["status"]) {
                generateHMAC(result);
                //bootbox.alert("Data Saved successfully");
            }
            else {
                alert(result["message"]);
                return false;
            }
        }

        function OnCallError(error, userContext, methodName) {
            err = error;
            uc = userContext;
            method = methodName;
            if (error !== null) {
                alert(error.get_message());
                //Ladda.stopAll();
                return false;
            }
        }

        function generateHMAC(param1) {

            document.getElementById("orderAmount").value = param1["amount"];
            document.getElementById("merchantTxnId").value = param1["transaction_id"];
            document.getElementById("currency").value = param1["currency"];
           // document.getElementById("returnUrl").value = param1["return_url"];
            document.getElementById("returnUrl").value = "https://connect.cept.ac.in/BTG/PaymentResponseNetBankingTechnology.aspx";
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

    </script>
</body>
</html>
