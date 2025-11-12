<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="test_login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Login - CEPT</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Le styles -->
    <link rel="icon" href="image/favicon.ico" type="image/x-icon">
    <link href="DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="DesignCss/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="DesignCss/typica-login.css" rel="stylesheet" type="text/css" />
    <link href="DesignJS/Spinner/ladda-themeless.min.css" rel="stylesheet" type="text/css" />
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le favicon -->
    <link rel="shortcut icon" href="favicon.ico">
    <style>
        #btnsignup:hover {
        background-color:black;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager11" runat="server">
            <Services>
                <asp:ServiceReference Path="~/WebService.asmx" />
            </Services>
        </asp:ScriptManager>

        <a href="#" id="button" style="display: none" class="ui-state-default ui-corner-all">Run Effect</a>
    
        <div id="main-content">
            <div id="chkalert" align="center" class="alert alert-block alert-success" style="color: Red;
                display: none">
                <button type="button" class="close" data-dismiss="alert" id="btnclose">
                    <i class="icon-remove"></i>
                </button>
                <i class="icon-ok green"></i><strong class="White">Please Check User Name And Password
                </strong>
            </div>
        </div>
    </form>
    
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <h2>
                    <%--<span class="hidden-phone" style="">Cept University</span></h2>--%>
                    <span class="hidden-phone" style="">
                        <img src="image/capture.png" height="500px" /><span style="font-size: small"> </span>
                        <%--<button class="btn ladda-button" id="btnsignup" style="margin-left:0;float:right;font-size:10pt;margin-top:1.2%;background-image: linear-gradient(to bottom,#d710e4,#029af3);color: #fff;text-shadow: 0 -1px 0 rgba(0,0,0,0.25);" data-style="zoom-in" onclick="return openSignUp();">
                        <span class="ladda-label">Call for Studio Tutor</span></button>--%>
                </h2>
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </a>
            </div>
        </div>
    </div>

    <div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h3 id="myModalLabel">Please Enter Email Id</h3>
        </div>
        <div class="modal-body">
            <div class="controls">
                <input type="text" id="txtemail" placeholder="Enter Email" />
            </div>
        </div>
        <div class="modal-footer">
            <button class="btn" id="close_btn" data-dismiss="modal" aria-hidden="true">Close</button>
            <%--<button class="btn btn-primary" id="btn_sendmail">
                Send Mail
            </button>--%>
            <button class="btn btn-success ladda-button" id="btn_sendmail" data-style="zoom-in">
                <span class="ladda-label">Send Mail</span></button>
        </div>
    </div>
    
    <%--<div id="chkalert" align="center" class="alert alert-block alert-success" style="color: Red;
        display: none">
        <button type="button" class="close" data-dismiss="alert" id="btnclose">
            <i class="icon-remove"></i>
        </button>
        <i class="icon-ok green"></i><strong class="White">Please Check User Name And Password
        </strong>
    </div>--%>

    <div class="container">
        <div style="height: 173px;top: 45%;left: 57%;padding: 0;width: 299px;background: rgba(255,255,255,0);" id="login-wraper">
            <%--<span style="color:Red; font-weight:bold;">CEPT Registration portal will be in maintenance from 25 June 12.00 PM till 27th
                June ​12.00 PM.</span>--%>
            <form class="form login-form">
                <legend style="margin-top: 0;margin-bottom: 10px;padding-bottom: 10px;font-weight:500;border-bottom:0px;"><%--Sign in<span class="blue"></span>--%></legend>
                <div class="body" style="padding-bottom: 0;border-bottom:0px;">
                    <%--<label style="font-weight:500;">Username</label>--%>
                    <input type="text" id="txtlogin" placeholder="Username / Email" />
                    <%--<label style="font-weight:500;">Password</label>--%>
                    <input type="password" id="txtPwd" placeholder="Password" />
                </div>
                <div class="footer" style="margin-top:15px;">
                    <label class="checkbox inline" style="font-weight:500;display:none;">
                        <input type="checkbox" id="inlineCheckbox1" value="option1" />
                        Remember me
                    </label>
                    <button class="btn btn-success ladda-button" id="btntest" style="margin-left:0;" data-style="zoom-in" onclick="return check();">
                        <span class="ladda-label">Login</span></button>
                  <%--  <div style="margin-top:6%;">
                        <span style="color: #000000;padding:3px;font-family: PT Sans;text-shadow: 0 0 black;background-color: #b5b5b59e;border-radius: -30px;border: 1px solid #adadad;border-radius: 8px;">Call for Studio | <a href="Registration.aspx" style="color: #000000;background-color: 0 0 white;text-shadow: 0 0 black;">New Tutor Registration</a></span>
                    </div>--%>
                </div>
            </form>
        </div>
        <div style="height: 50px;top: 85%;left: 57%;padding: 0;width: 299px;background: rgba(255,255,255,0);" id="login-wraper">
            <form class="form login-form">
                <div class="footer" style="margin-top:15px;">
                    <div style="margin-top:4%;">
                        <span style="color: #000000;padding:3px;font-family: PT Sans;text-shadow: 0 0 black;background-color: #afacacd9;border-radius: -45px;border: 1px solid #adadad;border-radius: 8px;">Call for Studio | <a href="Registration.aspx" style="color: #000000;background-color: 0 0 white;text-shadow: 0 0 black;">New Tutor Registration</a></span>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <footer class="white navbar-fixed-bottom">
        <%--<a href="#myModal" class="btn btn-black">Forgot Password</a>--%>
        <%-- <b> @2013 Aarin Technology</b>  <button onclick="return checkforgot();" type="submit" class="btn btn-black">Forgot Password</button>--%>
        <b> &copy; 2021 CEPT university</b>  <a href="#myModal" role="button" class="btn btn-black" data-toggle="modal">Forgot Password</a>
		<p style="margin-top:6px;"><b> If you face any issues, Please write to <a href="mailto:connect.help@cept.ac.in">connect.help@cept.ac.in</a></b>
    </footer>

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <%-- <script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/backstretch.min.js"></script>
    <script src="js/typica-login.js"></script>--%>

    <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>

    <%--<script src="DesignJS/jquery.min.js" type="text/javascript"></script>--%>

    <script src="DesignJS/bootstrap.min.js" type="text/javascript"></script>

    <script src="DesignJS/backstretch.min.js" type="text/javascript"></script>

    <script src="DesignJS/typica-login.js?t=27072018" type="text/javascript"></script>

    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>

    <%--<script src="DesignJS/bootbox.min.js" type="text/javascript"></script>--%>

    <script src="DesignJS/Spinner/spin.min.js" type="text/javascript"></script>

    <script src="DesignJS/Spinner/ladda.min.js" type="text/javascript"></script>

    <script src="DesignJS/bootbox.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">


    $(document).ready(function(){
        //window.history.forward(1);
        if('<%= Session["UserId"] %>' != '')
            WebService.login_redirect(OnCallSumComplete, OnCallSumError);
    });
    
        $(function () {
            // run the currently selected effect
            function runEffect() {
                // get effect type from
                // most effect types need no options passed by default
                // some effects have required parameters

                var options = {};
                // run the effect
                $("#login-wraper").toggle("shake", complete);
            }

            $("#button").click(function () {
                runEffect();
            });
            
            $("#btnclose").click(function () {
                $("#chkalert").hide();
                return false;
            });

            $('#btn_sendmail').on('click', function () {
                var l = Ladda.create(document.querySelector('#btn_sendmail'));
                l.start();
                
                var email = $('#txtemail').val();
                if (email == "") {
                    bootbox.alert("Please Enter Email");
                    $('#txtemail').focus();
                      Ladda.stopAll();
                    return false;
                }

                var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
                if (testEmail.test(email)) {
                }
                else {
                   bootbox.alert("Please Enter Valid Email");
                    $('#txtemail').focus();
                      Ladda.stopAll();
                    return false;
                }

                WebService.send_forgot_password(email,onsuc,onfail)

                return false;
            });
        });

        // set effect from select menu value
        function onsuc(msg,methodName)
        {
            bootbox.alert(msg);
            $('#close_btn').click();
            Ladda.stopAll();
        }

        function onfail(error,methodName)
        {
            if (error !== null) {
                bootbox.alert(error.get_message());
                    Ladda.stopAll();
                return false;
            }
        }

        function complete() {
            $("#login-wraper").show();
        }

        function check() {
            var username = document.getElementById("txtlogin").value;
            var password = document.getElementById("txtPwd").value;            
            var chk_remember = $('#inlineCheckbox1').prop('checked');
            var l = Ladda.create(document.querySelector('#btntest'));
            l.start();

            WebService.LoginCheck(username, password,chk_remember, OnCallSumComplete, OnCallSumError);
           
            return false;
        }

        function openSignUp() {
            var url = "Registration.aspx";
            window.open(url, '_self');
        }

        function OnCallSumComplete(res, methodName) {
            //expandall("imgdiv1");
            debugger;
            if (res == "Student Current Sem Detail not found in systems") {
                bootbox.alert('You can not login.your Current Semester Detail not found in systems');
                Ladda.stopAll();
                return false;
            }

            if (res == "student") {
                window.location.href = "<%= Page.ResolveClientUrl("~/Student/Dashboard.aspx") %>";
                return false;
                //window.location.href = "<%= Page.ResolveClientUrl("~/Student/Feedback_dashboard.aspx") %>";
            }
            else if (res == "external") {
                window.location.href = "<%= Page.ResolveClientUrl("~/Student_WS/Feedback_dashboard.aspx") %>";
                return false;
            }
            else if (res == "Alumni") {
                window.location.href = "<%= Page.ResolveClientUrl("~/Alumni/Alumni_Dashboard.aspx") %>";
                return false;
            }
            else if (res == "multiple_mail") {
                window.location.href = "<%= Page.ResolveClientUrl("~/Student/select_program.aspx") %>";
            }
            else if (res == "foren") {
                //window.location.href = "<%= Page.ResolveClientUrl("~/Student/student_dashboard.aspx") %>";
                window.location.href = "<%= Page.ResolveClientUrl("~/Student/Fees_dashboard.aspx") %>";
            }
            else if(res == "admin")
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if(res == "admin1")
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if( res == "admin2")
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if( res == "fianance")
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if(res == "it")
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/IT/IT_dashboard.aspx") %>";
            }
            else if (res == "change_password") 
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/reset_password.aspx") %>";
            }
            else if (res == "progcoord") 
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if (res == "instructor") 
            {
                //window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/admin_dashboard.aspx") %>";
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if (res == "dean") 
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if (res == "FA" || res == "CW" || res == "HR" || res == "WSA" || res == "AO")
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if (res == "HOME") 
            {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else {
                Ladda.stopAll();
                $("#chkalert").show();
                $("#button").click();

                return false;
            }
            //Show the result in txtresult
        }

        function OnCallSumError(error, userContext, methodName) {
            debugger;
            if (error !== null) {
                bootbox.alert(error.get_message());
                Ladda.stopAll();
                return false;
            }
        }

        function checkforgot() {
            bootbox.dialog({
                message: "I am a custom dialog",
                title: "Custom title",
                buttons: {
                    success: {
                        label: "Success!",
                        className: "btn-success",
                        callback: function () {
                            bootbox.alert("great success");
                        }
                    }
                }
            });

            return false;
        }
    </script>
</body>
</html>
