<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reset_password.aspx.cs" Inherits="reset_password" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Reset Password - CEPT</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Responsive HTML template for Your company">
    <meta name="author" content="Oskar Żabik (oskar.zabik@gmail.com)">
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
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager11" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <a href="#" id="button" style="display: none" class="ui-state-default ui-corner-all">
        Run Effect</a>
    <div id="main-content">
        <div id="chkalert" align="center" class="alert alert-block alert-success" style="color: Red;
            display: none">
            <button type="button" class="close" data-dismiss="alert" id="btnclose">
                <i class="icon-remove"></i>
            </button>
            <i class="icon-ok green"></i><strong class="White">Problem in reset password </strong>
        </div>
        <div id="chkalert1" align="center" class="alert alert-block alert-success" style="color: Red;
            display: none">
            <button type="button" class="close" data-dismiss="alert" id="btnclose1">
                <i class="icon-remove"></i>
            </button>
            <i class="icon-ok green"></i><strong class="White">Please enter your new password or
                confirm password</strong>
        </div>
        <div id="chkalert2" align="center" class="alert alert-block alert-success" style="color: Red;
            display: none">
            <button type="button" class="close" data-dismiss="alert" id="btnclose2">
                <i class="icon-remove"></i>
            </button>
            <i class="icon-ok green"></i><strong class="White">New password is not match with Confirm
                passwprd</strong>
        </div>
    </div>
    </form>

    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <h2><span class="hidden-phone" style=""><img src="image/capture.png" /></span></h2>
                <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                    <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </a>
                <a class="brand" href="index.html"></a>
            </div>
        </div>
    </div>

    <div class="container">
        <div id="login-wraper" style="height: 295px">
            <form class="form login-form">
            <legend>Reset Password<span class="blue"></span></legend>
            <div class="body">
                <label>New Password</label>
                <input type="password" id="txtPwd">

                <label>Confirm Password</label>
                <input type="password" id="txtconfirmpwd">
            </div>
            <div class="footer">
                <%--<button onclick="return check();" type="submit" class="btn btn-success">Reset</button>--%>
                <button class="btn btn-success ladda-button" id="btntest" data-style="zoom-in" onclick="return check();">
                    <span class="ladda-label">Reset</span></button>
            </div>
            </form>
        </div>
    </div>

    <footer class="white navbar-fixed-bottom">
        <%--<a href="#myModal" class="btn btn-black">Forgot Password</a>--%>
        <%--<b> @2013 Aarin Technology</b>  <button onclick="return checkforgot();" type="submit" class="btn btn-black">
                    Forgot Password</button>--%>
        <b> @2019 CEPT university</b>
    </footer>

    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
    <%--<script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/backstretch.min.js"></script>
    <script src="js/typica-login.js"></script>--%>

    <script src="Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    
    <%--<script src="DesignJS/jquery.min.js" type="text/javascript"></script>--%>
    
    <script src="DesignJS/bootstrap.min.js" type="text/javascript"></script>
    <script src="DesignJS/backstretch.min.js" type="text/javascript"></script>
    <script src="DesignJS/typica-login.js" type="text/javascript"></script>
    <script src="Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="DesignJS/Spinner/spin.min.js" type="text/javascript"></script>
    <script src="DesignJS/Spinner/ladda.min.js" type="text/javascript"></script>
    <script src="DesignJS/bootbox.min.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

  
   

        $(function () {
            // run the currently selected effect
            function runEffect() {
               

                var options = {}; 
               
                $("#login-wraper").toggle("shake", complete);

            }
            $("#button").click(function () {

                runEffect();

            });
              $("#btnclose").click(function () {
                $("#chkalert").hide();
                return false;

            });
              $("#btnclose1").click(function () {
                $("#chkalert1").hide();
                return false;

            });
           
            $("#btnclose2").click(function () {
                $("#chkalert2").hide();
                return false;

            });

           


        });
        // set effect from select menu value

        function complete()
         {
            $("#login-wraper").show();
        }
        function check() 
        {

            var l = Ladda.create(document.querySelector('#btntest'));
            l.start();

          var password = document.getElementById("txtPwd").value;   
           var confirm_pass = document.getElementById("txtconfirmpwd").value;   
          
          if (password == '') {
    
               $("#chkalert1").show();
                 $("#chkalert2").hide();
                   $("#chkalert").hide();
               $("#button").click();
                  Ladda.stopAll();
                return false;
                
            }
            
          if (confirm_pass == '') {
    
               $("#chkalert1").show();
                $("#chkalert2").hide();
                 $("#chkalert").hide();
               $("#button").click();
                  Ladda.stopAll();
                return false;
                
            }

            if (password != confirm_pass ) {
                
               $("#chkalert2").show();
                $("#chkalert1").hide();
                 $("#chkalert").hide();
               $("#button").click();
                  Ladda.stopAll();
                return false;
              }

           WebService.Change_password(password, "" , "" , OnCallSumComplete, OnCallSumError);
           
           return false;

        }
        function OnCallSumComplete(res, methodName) 
        {
           debugger;
              
            if (res == "same") {
                 bootbox.alert('Old Password and New password is same.please enter other');
                document.getElementById("txtPwd").value = '';
                 Ladda.stopAll();
                return false;
            }
            if (res == "student") {

                bootbox.alert("Password reset successfully");
                window.location.href = "<%= Page.ResolveClientUrl("~/Student/Dashboard.aspx") %>";

            }
            else if (res == "Alumni") {

                window.location.href = "<%= Page.ResolveClientUrl("~/Alumni/Alumni_Dashboard.aspx") %>";
                return false;
            }
            else if (res == "foren") {

                bootbox.alert("Password reset successfully");
                window.location.href = "<%= Page.ResolveClientUrl("~/Student/Fees_dashboard.aspx") %>";
            }

            else if (res == "it") {
                bootbox.alert("Password reset successfully");
                window.location.href = "<%= Page.ResolveClientUrl("~/IT/IT_dashboard.aspx") %>";

            }

            else if (res == "adminmaster") {
                window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/Home.aspx") %>";
            }
            else if (res == "Password changed successfully") {
                window.location.href = "<%= Page.ResolveClientUrl("~/Login.aspx") %>";
            }
            else
            {

             Ladda.stopAll();

                $("#chkalert").show();
                $("#chkalert1").hide();
                $("#chkalert2").hide();
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

        function checkforgot()
         {
            // bootbox.alert('hi');

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
