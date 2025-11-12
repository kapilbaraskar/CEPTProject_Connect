<%@ Page Title="SID Payment Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="sid_payment_report.aspx.cs" Inherits="SID_sid_payment_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_sid_payment_dtl",
                data: {},
                contentType: "application/json",
                datatype: "json",
                success: function (data) {

                    if (data.d != "") {

                        DisplayData(data.d);

                        $('#DataList').css('display', 'block');
                        $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
                    }
                    else {

                        bootbox.alert("There is no data found");

                        $('#DataList').css('display', 'none');
                    }

                    return false;
                }
            });

        });

        function DisplayData(data) {
            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"sDom": 't',
                
                //"sScrollY": "400px",
                "iDisplayLength": 30,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
//                "oTableTools": {
//                    "aButtons": [
//                    							"copy",
//                    							"print",
//                    							{
//                    							    "sExtends": "collection",
//                    							    "sButtonText": 'Export',
////                    							    "aButtons": ["csv", "xls", "pdf"]
//                    							    "aButtons": ["xls"]
//                    							}
//						]
//                },

                "aaData": JSON.parse(data),
                "aoColumns": [
         { "sTitle": "Code", "mData": "user_id", "bSortable": false },
          { "sTitle": "Name", "mData": "name", "bSortable": false },
          { "sTitle": "Transaction No", "mData": "transaction_id", "bSortable": false },
           { "sTitle": "Profession", "mData": "profession", "bSortable": false },
           { "sTitle": "Organisation", "mData": "organisation", "bSortable": false },
             { "sTitle": "Website", "mData": "website", "bSortable": false },
             { "sTitle": "Address", "mData": "address", "bSortable": false },
               { "sTitle": "City", "mData": "city", "bSortable": false },
                 { "sTitle": "State", "mData": "state", "bSortable": false },
                   { "sTitle": "Pin", "mData": "pin", "bSortable": false },
                    { "sTitle": "Email Id", "mData": "email_id", "bSortable": false },
                    { "sTitle": "Contact No", "mData": "contact_no", "bSortable": false },
                      { "sTitle": "Payment Status", "mData": "Citrus_TxStatus", "bSortable": false },
                      { "sTitle": "Amount", "mData": "amount", "bSortable": false }
            ]


            });

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-header position-relative">
        <h1>
            <i class="icon-rupee"></i>SID Payment Report
        </h1>
    </div>
    <div style="margin-top: 25px; display: none; width: 100%; overflow: auto;" class="row-fluid"
        id="DataList">
        <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
            border="0" id="example" width="100%">
            <tbody>
            </tbody>
        </table>
    </div>
</asp:Content>
