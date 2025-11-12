<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="PaypalPayment.aspx.cs" Inherits="Student_PaypalPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

        });

        function SubmitAndPayApplication() {
            debugger;
            //  alert('hi');

            this.aspnetForm.action = "https://www.sandbox.paypal.com/webscr";
            this.aspnetForm.method = 'POST';
            this.aspnetForm.submit();
        }


    </script>
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" name="cmd" value="_cart" />
    <input type="hidden" name="add" value="5" />
    <input type="hidden" name="business" value="rutul@aarin.in" />
    <input type="hidden" name="item_name" value="My Cart Item 1" />
    <input type="hidden" name="amount" value="15.00" />
    <input type="hidden" name="currency_code" value="INR" />
    <input type="hidden" name="tx" value="123456"> 
    <input type="hidden" name="at" value="YourIdentityToken"> 
    <input type="hidden" name="shopping_url" value="http://localhost:3657/CEPT/Student/shoppingpage.html" />
    <input type="hidden" name="return" value="http://localhost:3657/CEPT/Student/success.html" />
    <input type="hidden" name="cancel_return" value="http://localhost:3657/CEPT/Student/cancel.html" />


    <asp:Button ID="btnSubmitAndPay" Text="Submit and Pay" runat="server" 
        OnClientClick="return SubmitAndPayApplication(this)" 
        />

      <%-- <script async="async" src="https://www.paypalobjects.com/js/external/paypal-button.min.js?merchant=rutul@aarin.in"
        data-button="buynow" data-name="Product1" data-quantity="1" data-amount="5.00"
        data-currency="USD" data-shipping="0.75" data-tax="3.50" data-callback="http://localhost:15707/CEPT/Student/shoppingpage.html"
        data-env="sandbox">--%>
    </script>
</asp:Content>
