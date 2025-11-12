<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaymentResponseNetBankingDesign.aspx.cs" Inherits="SID_PaymentResponseNetBankingDesign" %>

<html>
<head>
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/typica-login.css" rel="stylesheet" type="text/css" />
    <link href="../DesignJS/Spinner/ladda-themeless.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/Validation.css" rel="stylesheet" />

    <script src="../Scripts/knockout-3.1.0.js" type="text/javascript"></script>
    <script src="../Scripts/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="../Scripts/PaymentResponse.js" type="text/javascript"></script>
    
    <script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../DesignJS/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="../DesignJS/Spinner/spin.min.js" type="text/javascript"></script>
    <script src="../DesignJS/Spinner/ladda.min.js" type="text/javascript"></script>
    <script src="../DesignJS/bootbox.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            onReady();
            ko.applyBindings(ViewModel);
        });
    </script>
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
        <div id="signupbox" style="margin-top: 40px" class="mainbox col-md-11 col-md-offset-1 col-sm-11">
            <form id="form1" runat="server">
                <div id="templates" runat="server">
                </div>
                <div class="row">
                    <div data-bind="template: {name:status,data:data}" class="col-md-8 col-md-offset-2" style="margin-left: 90px;">
                    </div>
                </div>
                <asp:HiddenField ID="data" runat="server" ClientIDMode="Static" />
            </form>
        </div>
    </div>
</body>
</html>
