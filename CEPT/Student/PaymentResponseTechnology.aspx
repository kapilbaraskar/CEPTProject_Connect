<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="PaymentResponseTechnology.aspx.cs" Inherits="Student_PaymentResponseTechnology" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../Scripts/knockout-3.1.0.js" type="text/javascript"></script>
    <script src="../Scripts/knockout.mapping-latest.js" type="text/javascript"></script>
    <script src="../Scripts/PaymentResponse.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            onReady();
            ko.applyBindings(ViewModel);
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="templates" runat="server">
    </div>
    <div class="row">
        <div data-bind="template: {name:status,data:data}" class="col-md-8 col-md-offset-2" style="margin-left: 90px;">
        </div>
    </div>
    <asp:HiddenField ID="data" runat="server" ClientIDMode="Static" />
</asp:Content>
