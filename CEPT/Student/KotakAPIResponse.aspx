<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KotakAPIResponse.aspx.cs" Inherits="Student_KotakAPIResponse" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kotak - API Response</title>
    <script src="../Scripts/knockout-3.1.0.js" type="text/javascript"></script>
    <script src="../Scripts/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="../Scripts/PaymentResponse.js" type="text/javascript"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            onReady();
            debugger;
            ko.applyBindings(ViewModel);
        });
    </script>
    <style>
        body {
            text-align: center;
            padding: 10px 0;
            background: #EBF0F5;
        }

        h1 {
            color: #88B04B;
            font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
            font-weight: 900;
            font-size: 40px;
            margin-bottom: 10px;
        }

        p {
            color: #404F5E;
            font-family: "Nunito Sans", "Helvetica Neue", sans-serif;
            font-size: 15px;
            margin: 0;
        }

        i {
            color: #9ABC66;
            font-size: 100px;
            line-height: 200px;
            margin-left: -15px;
        }

        .card {
            background: white;
            padding: 60px;
            border-radius: 4px;
            box-shadow: 0 2px 3px #C8D0D8;
            display: inline-block;
            margin: 0 auto;
        }
    </style>
</head>
<body>
    <form runat="server">
        <div id="templates" runat="server">
        </div>
        <div class="row">
            <div data-bind="template: { name: status, data: data }" class="col-md-8 col-md-offset-2" style="margin-left: 90px;">
            </div>
        </div>

        <asp:HiddenField ID="data" runat="server" ClientIDMode="Static" />
    </form>
</body>
</html>

