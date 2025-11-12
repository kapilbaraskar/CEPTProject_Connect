<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login_old.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>CEPT UNIVERSITY</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="CEPT UNIVERSITY">

    <!-- Le styles -->
    <link href="DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="DesignCss/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
  
    <link href="DesignCss/typica-login.css" rel="stylesheet" type="text/css" />

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le favicon -->
    <link rel="shortcut icon" href="favicon.ico">
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager11" runat="server" EnablePageMethods="true" ScriptMode="Release">
            <Services>
            </Services>
        </asp:ScriptManager>
        <div class="navbar navbar-fixed-top">
            <div class="navbar-inner">
                <div class="container">
                    <h2>
                        <span class="hidden-phone" style="">Cept University</span></h2>
                    <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"><span
                        class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                    </a><a class="brand" href="Home.aspx"></a>
                </div>
            </div>
        </div>
        <div class="container">
            <div id="login-wraper">
                <form class="form login-form">
                    <legend>Sign in<span class="blue"></span></legend>
                    <div class="body">
                        <label>
                            Username</label>
                        <input type="text"  />
                        <input type="hidden" id="hiddensessionid" />
                        <label>
                            Password</label>
                        <input type="password"  />
                    </div>
                    <div class="footer">
                        <label class="checkbox inline">
                            <input type="checkbox" id="inlineCheckbox1" value="option1" />
                            Remember me
                        </label>
                        <button type="submit" class="btn btn-success" id="btnlogin" style="display:none;">
                            Login</button>
                         <asp:Button ID="Button1" runat="server" CssClass="btn btn-large btn-success" Text="Log In" />
                    </div>
                </form>
            </div>
        </div>
        <footer class="white navbar-fixed-bottom">
            <a href="#" class="btn btn-black">Forgot Password</a>
        </footer>
        <!-- Le javascript
    ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
       

        <script src="DesignJS/jquery.min.js" type="text/javascript"></script>
    <script src="DesignJS/bootstrap.min.js" type="text/javascript"></script>
    <script src="DesignJS/backstretch.min.js" type="text/javascript"></script>
    <script src="DesignJS/typica-login.js" type="text/javascript"></script>
        <script type="text/javascript">
        
        
        </script>
    </form>
</body>
</html>
