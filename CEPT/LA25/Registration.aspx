<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="LA25_Registration" %>

<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>Register</title>
    <%--<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Responsive HTML template for Your company">
    <meta name="author" content="Oskar Żabik (oskar.zabik@gmail.com)">--%>
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
                        <span style="font-size: small"></span>
                    </span>
                </h2>
            </div>
        </div>
    </div>

    <div class="container" style="margin-bottom: 0px;">
        <div id="signupbox" style="margin-top: 0px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
            <div class="panel panel-info" style="margin-top: 20px;">
                <div class="panel-heading">
                    <div class="panel-title">Register</div>
                </div>
                <div class="panel-body">
                    <form id="frm_LA25_registration" style="padding-top: 10px;" runat="server">
                        <asp:ScriptManager ID="ScriptManager11" runat="server">
                            <Services>
                                <asp:ServiceReference Path="~/WebService.asmx" />
                            </Services>
                        </asp:ScriptManager>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Name <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_name" name="txt_name" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Profession <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <%--<input type="text" id="Text1" class="form-control" style="height:30px;width:100%;" />--%>
                                    <select id="drp_profession" name="drp_profession" class="form-control" style="width:100%;">
                                        <option value="">-- Select Profession --</option>
                                        <%--<option value="CS">CEPT Student</option>--%>
                                        <%--<option value="S">Outside Student</option>--%>
                                        <option value="A">CEPT Landscape Alumni</option>
                                        <option value="AS">CEPT Landscape Alumni + Spouse</option>
                                        <%--<option value="P">Professional</option>--%>
                                    </select>
                                    <%--<span id="spn_amount" style="vertical-align:super;margin-left:2px;"></span>--%>
                                </div>
                            </div>
                            <div id="div_spouse_name" class="form-group col-sm-12" style="display:none;">
                                <div class="form-group col-sm-3">
                                    Spouse Name <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_spouse_name" name="txt_spouse_name" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Organisation <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_organisation" name="txt_organisation" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <%--<div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Website
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_website" name="txt_website" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>--%>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Address <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_address" name="txt_address" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    City <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_city" name="txt_city" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Country <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_country" name="txt_country" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    PIN <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_pin" name="txt_pin" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Email Id <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_email" name="txt_email" class="form-control" style="height:30px;width:100%;" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Contact No <span class="required">*</span>
                                </div>
                                <div class="form-group col-sm-7">
                                    <input type="text" id="txt_phone" name="txt_phone" class="form-control" maxlength=10 style="height:30px;width:100%;" onkeypress="return IsNumeric(event);" />
                                </div>
                            </div>
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3">
                                    Year of Joining CEPT (Landscape Program) <%--<span class="required">*</span>--%>
                                </div>
                                <div class="form-group col-sm-7">
                                    <select id="drp_year_of_joining" name="drp_year_of_joining" class="form-control">
                                        <option value="">-- Select Year --</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    
                        <div class="row">
                            <div class="control-group col-sm-12" style="margin-top: 10px;">
                                <%--<div class="control-group col-sm-12">
                                    <input type="radio" id="rdo_cept" name="rdo_reg_fees" style="vertical-align: sub;" disabled/>&nbsp;None (For CEPT Students)
                                </div>--%>
                                <%--<div class="control-group col-sm-12">
                                    <input type="radio" id="rdo_student" name="rdo_reg_fees" style="vertical-align: sub;" disabled/>&nbsp;Rs. 1000/- (For Outside Students)
                                </div>--%>
                                <div class="control-group col-sm-12">
                                    <input type="radio" id="rdo_alumni" name="rdo_reg_fees" style="vertical-align: sub;" disabled/>&nbsp;Rs. 1500/- (For CEPT Landscape Alumni)
                                </div>
                                <div class="control-group col-sm-12">
                                    <input type="radio" id="rdo_alumni_spouse" name="rdo_reg_fees" style="vertical-align: sub;" disabled/>&nbsp;Rs. 2500/- (For CEPT Landscape Alumni + Spouse of Alumni)
                                </div>
                                <%--<div class="control-group col-sm-12">
                                    <input type="radio" id="rdo_professional" name="rdo_reg_fees" style="vertical-align: sub;" disabled/>&nbsp;Rs. 2000/- (For Professionals)
                                </div>--%>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group col-sm-12" style="margin-top:10px;">
                                <div align="center">
                                    <button type="button" id="btnSave" onclick="return Register();" class="btn btn-success">
                                        Register
                                    </button>
                                </div>
                                <div align="center" style="color:Red;margin-top:5px;">
                                    Clicking on the register button will redirect you to a payment gateway
                                </div>
                            </div>
                        </div>

                        <input type="hidden" id="returnUrl" name="returnUrl" value="" />
                        <input type="hidden" id="secSignature" name="secSignature" value="" />
                        <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
                        <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
                        <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
                        <input style="display: none" type="text" id="currency" class="text" name="currency" value="INR" />
                    </form>
                </div>
            </div>
        </div>
    </div>

    <%--<footer class="white navbar-fixed-bottom">
      
    </footer>--%>
    
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

            for (var i = 1960; i <= (new Date()).getFullYear(); i++) {
                $('#drp_year_of_joining').append('<option value="' + i + '">' + i + '</option>');
            }

            $('#drp_profession').on('change', function () {
                $('#div_spouse_name').css('display', 'none');

                switch ($('#drp_profession').val()) {
                    case "CS":
                        //$('#rdo_cept')[0].checked = true;
                        break;
                    case "S":
                        //$('#rdo_student')[0].checked = true;
                        break;
                    case "A":
                        $('#rdo_alumni')[0].checked = true;
                        break;
                    case "AS":
                        $('#rdo_alumni_spouse')[0].checked = true;
                        $('#div_spouse_name').css('display', 'block');
                        break;
                    case "P":
                        //$('#rdo_professional')[0].checked = true;
                        break;
                    case "":
                        //$('#rdo_cept')[0].checked = false;
                        //$('#rdo_student')[0].checked = false;
                        $('#rdo_alumni')[0].checked = false;
                        //$('#rdo_professional')[0].checked = false;
                        break;
                }
            });

            $("#frm_LA25_registration").validate({
                rules: {
                    txt_name: {
                        required: true
                    },
                    drp_profession: {
                        required: true
                    },
                    txt_organisation: {
                        required: true
                    },
                    //txt_website: {
                    //    required: true
                    //},
                    txt_address: {
                        required: true
                    },
                    txt_city: {
                        required: true
                    },
                    txt_country: {
                        required: true
                    },
                    txt_pin: {
                        required: true
                    },
                    txt_email: {
                        required: true,
                        email: true
                    },
                    txt_phone: {
                        required: true,
                        digits: true,
                        minlength: 10,
                        maxlength: 10
                    }
                    //drp_year_of_joining: {
                    //    required: true
                    //}
                },
                messages: {
                    txt_name: {
                        required: "Please Enter Your Name"
                    },
                    drp_profession: {
                        required: "Please Select Profession"
                    },
                    txt_organisation: {
                        required: "Please Enter Organisation"
                    },
                    //txt_website: {
                    //    required: "Please Enter Website"
                    //},
                    txt_address: {
                        required: "Please Enter Address"
                    },
                    txt_city: {
                        required: "Please Enter City"
                    },
                    txt_country: {
                        required: "Please Enter Country"
                    },
                    txt_pin: {
                        required: "Please Enter PIN"
                    },
                    txt_email: {
                        required: "Please Enter Your EmailID",
                        email: "Enter valid Email"
                    },
                    txt_phone: {
                        required: "Please Enter Phone Number",
                        minlength: "Enter 10 Digit Phone Number",
                        maxlength: "Enter 10 Digit Phone Number"
                    }
                    //drp_year_of_joining: {
                    //    required: "Please Enter Year of Joining CEPT"
                    //}
                }
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
            var result = $('#frm_LA25_registration').valid();
            if (result) {
                if ($('#drp_profession').val() == 'AS' && $('#txt_spouse_name').val() == '') {
                    alert('Please Enter Spouse Name');
                    return false;
                }

                var register_data = { name: $('#txt_name').val(), profession: $('#drp_profession').val(), spouse_name: $('#txt_spouse_name').val(), organisation: $('#txt_organisation').val(), address: $('#txt_address').val(), city: $('#txt_city').val(), country: $('#txt_country').val(), pin: $('#txt_pin').val(), email: $('#txt_email').val(), phone: $('#txt_phone').val() };

                WebService.payment_LA25_registration(JSON.stringify(register_data), OnCallComplete, OnCallError);
            }
        }

        function OnCallComplete(res, methodName) {
            reg_res = res;
            method = methodName;

            var result = JSON.parse(res);
            if (result["status"]) {
                generateHMAC(result);
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

    </script>
</body>
</html>
