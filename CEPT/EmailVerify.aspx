<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmailVerify.aspx.cs" Inherits="EmailVerify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Verification</title>
    <link href='https://fonts.googleapis.com/css?family=Lato:300,400|Montserrat:700' rel='stylesheet' type='text/css'>
    <style>
        @import url(//cdnjs.cloudflare.com/ajax/libs/normalize/3.0.1/normalize.min.css);
        @import url(//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css);
    </style>
    <link rel="stylesheet" href="https://2-22-4-dot-lead-pages.appspot.com/static/lp918/min/default_thank_you.css">
    <script src="https://2-22-4-dot-lead-pages.appspot.com/static/lp918/min/jquery-1.9.1.min.js"></script>
    <script src="https://2-22-4-dot-lead-pages.appspot.com/static/lp918/min/html5shiv.js"></script>

    <script>
        $(document).ready(function () {

            function GetQueryStringParams(sParam) {
                var sPageURL = window.location.search.substring(1);
                var sURLVariables = sPageURL.split('&');
                for (var i = 0; i < sURLVariables.length; i++) {
                    var sParameterName = sURLVariables[i].split('=');
                    if (sParameterName[0] == sParam) {
                        return sParameterName[1];
                    }
                }
            }

            var mail = GetQueryStringParams('UN');
            var verification_token = GetQueryStringParams('VT');

            if (mail != undefined && verification_token != undefined) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/VerifyUserDetails",
                    data: "{ mail: '" + mail + "', verification_token : '" + verification_token + "'}",
                    dataType: "json",
                    success: function (data) {
                        var dataa = JSON.parse(data.d);
                        if (dataa.status == "0") {
                            //alert(dataa.message);
                            $("#success").css('display','');
                            //var url = "Login.aspx";
                            //window.open(url, '_self');
                        } else {
                            //alert(dataa.message);
                            $("#error_msg").text(dataa.message);
                            $("#unsuccess").css('display', '');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        });
    </script>
    <style>
        body {
            background-color: #eee;
        }
    </style>
</head>
<body>
    <div style="display:none;" id="success">
        <header class="site-header" id="header">
            <h1 class="site-header__title" data-lead-id="site-header-title">THANK YOU!</h1>
        </header>

        <div class="main-content">
            <i class="fa fa-check main-content__checkmark" id="checkmark"></i>
            <p class="main-content__body" data-lead-id="main-content-body">Welcome to CEPT University! Email Verification Successful.</p>
            <p class="lead">
                <a class="btn btn-primary btn-sm" href="Login.aspx" role="button">Goto LOG IN</a>
            </p>
        </div>
    </div>
    <div style="display:none;" id="unsuccess">
        <header class="site-header" id="header">
            <h1 class="site-header__title" data-lead-id="site-header-title">Oops!</h1>
        </header>

        <div class="main-content">
            <span style='font-size:100px;'>&#10008;</span>
            <p class="main-content__body" data-lead-id="main-content-body" id="error_msg"></p>
            <p class="lead">
                <a class="btn btn-primary btn-sm" href="Login.aspx" role="button">Goto LOG IN</a>
            </p>
        </div>
    </div>
    <footer class="site-footer" id="footer" style="padding: 83px 0 25px;">
		<p class="site-footer__fineprint" id="fineprint">Copyright ©2020 | All Rights Reserved | CEPT University</p>
	</footer>
</body>
</html>
