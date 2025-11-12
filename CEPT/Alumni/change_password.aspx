<%@ Page Language="C#" AutoEventWireup="true" CodeFile="change_password.aspx.cs" 
    Inherits="Alumni_change_password" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <title>Change Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Responsive HTML template for Your company">
    <meta name="author" content="Oskar Żabik (oskar.zabik@gmail.com)">
    <!-- Le styles -->
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/typica-login.css" rel="stylesheet" type="text/css" />
    <link href="../DesignJS/Spinner/ladda-themeless.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/Validation.css" rel="stylesheet" />
    <link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css" />
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
    <form id="frm_sid_registration" style="padding-top: 10px;" runat="server">
    <div class="container" id="div_save_credential" style="margin-bottom: 0px; display: block;">
        <div id="Div1" style="margin-top: 0px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
            <div class="panel panel-info" style="margin-top: 20px;">
                <div class="panel-heading">
                    <div class="panel-title">
                        create your alumni account</div>
                </div>
                <asp:ScriptManager ID="ScriptManager11" runat="server">
                    <Services>
                        <asp:ServiceReference Path="~/WebService.asmx" />
                    </Services>
                </asp:ScriptManager>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Email <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input runat="server" type="text" id="txt_email" name="txt_email" class="form-control"
                                    style="height: 30px; width: 100%;" />
                                <span id="email_check_status" style="color: #b94a48 !important;"></span>
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Create Password <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="password" id="txt_password" name="txt_password" class="form-control"
                                    style="height: 30px; width: 100%;" />
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Re-type Password <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="password" id="txt_retype_password" name="txt_retype_password" class="form-control"
                                    style="height: 30px; width: 100%;" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group col-sm-12" style="margin-top: 10px;">
                            <div align="center">
                                <button type="button" id="btn_save_credential_detail" onclick="return save_credential();"
                                    class="btn btn-success ladda-button">
                                    Save Credentials
                                </button>
                            </div>
                            <%--  <div align="center" style="color:Red;margin-top:5px;">
                                    Clicking on the register button will redirect you to a payment gateway
                                </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="hdn_user_id" />
    </form>
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

        $('#txt_email').on('blur',function(){
        if ( $('#txt_email').val() != "") {
   
          $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/check_alumni_email",

                data: "{email : '"+  $('#txt_email').val() +"'}",
                dataType: "json",
                success: function (data) {
                debugger;
              if (data.d != "") {
    

                            var data1 = JSON.parse(data.d);

            if (data1["status"] == "True") {
           
            }
            else
            {
                $('#email_check_status').text(data1["message"]);
            }
                
                }
                else
                {
                     $('#email_check_status').text("");
                }
                },
                error: function (result) {
                    alert(result);
                }
            });
            }
            else
            {
                 $('#email_check_status').text('');
            }

        });

            $("#frm_sid_registration").validate({
                rules: {
                
                        txt_password: {
                        required: true
                        },
                        txt_retype_password: {
                        required: true,
                        equalTo: "#txt_password"
                        },
                        txt_email: {
                        required: true,
                         email: true
                        }
                    },
                    messages: {
                        txt_password: {
                            required: "Please enter password",
                        },
                        txt_retype_password: {
                            required: "Please enter re type password",
                            equalTo: "Password is not match"
                        },
                         txt_email: {
                            required: "Please enter email",
                            email: "Enter valid Email"
                        }
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
        
         function save_credential() {
            var result = $('#frm_sid_registration').valid();
            if (result) {
                debugger;
                 var l = Ladda.create(document.querySelector('#btn_save_credential_detail'));
                l.start();
                var register_data = {email : $('#txt_email').val(), password :$('#txt_password').val()};

                WebService.update_alumini_credential(JSON.stringify(register_data), OnCallComplete_credential, OnCallError_credential);
            }
        }

         function OnCallComplete_credential(res, methodName) {
            debugger;

            var data = JSON.parse(res);

            if (data["status"] == "True") {
             Ladda.stopAll();
                window.location.href = "alumni_personal_detail.aspx";
                return false;
            }
            else
            {
                Ladda.stopAll();
                bootbox.alert(data["message"]);
            }
        }

        function OnCallError_credential(error, userContext, methodName) {
            err = error;
            uc = userContext;
            method = methodName;
            if (error !== null) {
             Ladda.stopAll();
                alert(error.get_message());
                //Ladda.stopAll();
                return false;
            }
        }

    </script>
</body>
</html>
