<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="WO_FormulaLIST.aspx.cs" Inherits="WO_FormulaLIST" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="DesignCss/daterangepicker.css" rel="stylesheet" type="text/css" />
    <script src="DesignJS/moment.min.js" type="text/javascript"></script>
    <script src="DesignJS/daterangepicker.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var oTable;
        var oTable1;
        var exp_table;
        var expressiontable;
        $(document).ready(function () {
            fun();
//            $('#id-date-range-picker-1').daterangepicker({
//                format: 'DD/MM/YYYY',
//                showDropdowns: true
//            },
//            function (start, end) {
//               // alert('A date range was chosen: ' + start.format('DD/MM/YYYY') + ' to ' + end.format('DD/MM/YYYY'));
//            }).prev().on(ace.click_event, function () {
//                $(this).next().focus();
//            });
        });
        function fun() {
            var userid = '<%= Session["UserId"].ToString() %>';
            WebService.GETWOnumber(userid, OnSuccess, OnFailure);

            return false;

        }

        function OnSuccess(response) {


            DisplayData(response);



        }
        function OnFailure(response) {

            alert("Error:" + response._message);

        }

        function DisplayData(data) {




            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="display" id="table1"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#table1").dataTable({
                "bFilter": false,
                "bPaginate": false,
                "binfo": false,
                "sDom": 't',
                "aaData": JSON.parse(data),
                "aoColumns": [
                { "sTitle": "WO Number", "mData": "po_so_number", "bSortable": false}]

            });
        }

        $("#table1 tbody tr").live("click", function (event) {

            var row = $(this).closest("tr").get(0);
            var dtt = $('#id-date-range-picker-1').val();
          //  alert(dtt);
            var aData = oTable.fnGetData(row);
            //  alert(aData['po_so_number']);
            $('#lblwono').text("WO Number :-" + aData['po_so_number']);
            WebService.GetSoformulawowise(aData['po_so_number'], onsucc, onfailed);

            return false;

        });
        function onsucc(response) {
            //   alert(response);
            DisplayData1(response);
        }
        function onfailed(response) {

        }
        function DisplayData1(data) {




            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
                $('#lblwono').text("WO Number :-");
            }

            oTable1 = $("#example").dataTable({
                "bFilter": false,
                "bPaginate": false,
                "binfo": false,
                "sDom": 't',
                "aaData": JSON.parse(data),
                "aoColumns": [
                { "sTitle": "Activity", "mData": "Activity", "bSortable": false },
                { "sTitle": "Descripation", "mData": "ShortText", "bSortable": false },
                { "sTitle": "Expression", "mData": "Expression", "bSortable": false}]

            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                Work Order List
            </h1>
        </div>
       <%-- <div class="row-fluid">
            <label for="id-date-range-picker-1">
                Date Range Picker</label>
        </div>
        <div class="control-group">
            <div class="row-fluid input-prepend">
                <span class="add-on"><i class="icon-calendar"></i></span>
                <input class="span10" type="text" name="date-range-picker" id="id-date-range-picker-1"  />
            </div>
        </div>--%>
        <div id="DataList" class="span12" style="width: 15%; float: left;">
            <table cellpadding="0" cellspacing="0" border="0" id="table1" class="display table table-striped table-bordered table-hover">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <div id="DataList1" class="span12" style="width: 75%; float: right;">
            <label class="control-label" for="form-field-1" id="lblwono">
            </label>
            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
