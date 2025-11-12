<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="StudentAccountLedger.aspx.cs" Inherits="Admin_Report_StudentAccountLedger" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../Js/loder.js" type="text/javascript"></script>

    <style>
      .group-footer {
    font-weight: bold;
    background-color: #f9f9f9;
}

.grand-total {
    font-weight: bold;
    background-color: #d9edf7; /* Light blue background for grand total */
}
    </style>
<script type="text/javascript">
    var oTable;
    var oTable1;
    $(document).ready(function () {

        Apply_Get_Data();
        Apply_student_certificate_dtl();
        return false;

    });
    function Apply_Get_Data() {

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/StudentAccountLedger",
            data: "{Student_Code: '" + $('#hdn_userid').val() + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {

                    var datauser = JSON.parse(data.d);
                    $('#studentCode').text($('#hdn_userid').val());
                    $('#studentName').text(datauser[0]['full_name']);
                    $('#studentFaculty').text(datauser[0]['dept_name']);
                    Display_report(data.d);

                }
                else {
                    bootbox.alert('There is No data Found For Selected Semester');
                    return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });

        return false;
    }

    function Display_report(data) {
        $('#DataList').css('display', 'block');

        if (oTable != null) {
            oTable.fnDestroy();
            $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody><tfoot><tr><th colspan="4" style="text-align:right">Total:</th><th></th></tr></tfoot></table>');
        }

        oTable = $("#example").dataTable({
            "bPaginate": false,
            "bStateSave": false,
            "bSort": false,
            "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            "aaData": JSON.parse(data),
            "aoColumns": [
                { "sTitle": "Semester", "mData": "semester", "bSortable": false },
                { "sTitle": "Date", "mData": "CreatedDate", "bSortable": false },
                { "sTitle": "Description", "mData": "Description", "bSortable": false },
                { "sTitle": "Reference", "mData": "REFERENCE", "bSortable": false },
                { "sTitle": "Payment Details", "mData": "Credit", "bSortable": false }
            ]}).rowGrouping();
        updateFooter(oTable);
        $('#DataList').css('display', 'block');
    }

    function updateFooter(oTable) {
        var api = oTable.api();

        // Remove the formatting to get the raw data for total calculation
        var intVal = function (i) {
            return typeof i === 'string' ?
                i.replace(/[\$,]/g, '') * 1 :
                typeof i === 'number' ?
                    i : 0;
        };

        // Calculate the total sum of the entire dataset
        var total = api
            .column(4)
            .data()
            .reduce(function (a, b) {
                return intVal(a) + intVal(b);
            }, 0);

        // Calculate the sum for this page only
        var pageTotal = api
            .column(4, { page: 'current' })
            .data()
            .reduce(function (a, b) {
                return intVal(a) + intVal(b);
            }, 0);

        // Update the footer with the total for the current page
        $(api.column(4).footer()).html(
            '$' + pageTotal + ' ( $' + total + ' total )'
        );
    }


</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Student Account Ledger
            </h1>
        </div>
          </div>
        
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Filter Criteria</strong>
                </div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Student Code :
                            </td>
                            <td>
                                <b><span id="studentCode"></span></b>
                            </td>
                             <td>
                                Student Name  :
                            </td>
                            <td>
                                <b><span id="studentName"></span></b>
                            </td>
                            <td>
                                Faculty  :
                            </td>
                            <td>
                                <b><span id="studentFaculty"></span></b></td>
                            <%--<td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>--%>
                        </tr>
                    </table>
                </div>
            </div>

    <div id="DataList" class="panel panel-default" style="display: none">
                <div class="panel-heading">
                    <strong>Student Account Ledger Details</strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>


           <input type="hidden" runat="server" clientidmode="Static" id="hdn_userid" value="" />
</asp:Content>

