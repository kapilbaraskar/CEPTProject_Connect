<%@ Page Title="Hostel Fees Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="hostel_fees_dtl.aspx.cs" Inherits="Admin_Report_hostel_fees_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=21092019" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {


            

            $('#from_date').datepicker();

            $('#to_date').datepicker();

            $('#btnreterive').on('click', function () {


                hostel_fees_report_dtl();

                return false;

            });

            return false;

        });

        function hostel_fees_report_dtl() {

            //  alert('hi');
            $('#DataList').css('display', 'none');


            var start_date = $('#from_date').val(); // '2014-03-05';
            if (start_date == "") {
                bootbox.alert('Please select Start Date')
                $('#from_date').focus();
                return false;
            }

            var end_date = $('#to_date').val(); //'2014-10-01';
            if (end_date == "") {
                bootbox.alert('Please select End Date')
                $('#to_date').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Hostel_fees_dtl",

                    data: "{start_date: '" + start_date + "',end_date:'" + end_date + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "") {

                            Display_hostel_fees_report_dtl(data.d);

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


        function Display_hostel_fees_report_dtl(data) {

            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();


                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                
                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Email Id", "mData": "mail", "bSortable": false },
                    { "sTitle": "Mobile No", "mData": "mobile_no", "bSortable": false },
                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                    {
                        "sTitle": "Block Name", "mData": null, "bSortable": false, "mRender": function (data)
                        {
                            if (data.block_name == "GS") {
                                return "Srishti";
                            }
                            else if (data.block_name == "GF") {
                                return "Block-F";
                            }
                            else if (data.block_name == "BH") {
                                return "Block-H";
                            }
                            else if (data.block_name == "BI") {
                                return "Block-I";
                            }
                            else { return ''; }
                        }
                    },
                    { "sTitle": "Renew", "mData": "renew", "bSortable": false },
                    { "sTitle": "Current Room", "mData": "cur_room", "bSortable": false },
                    { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Payment Transaction Reference Id", "mData": "payment_transaction_reference_id", "bSortable": false },
                    { "sTitle": "Payment Response Msg", "mData": "payment_response_msg", "bSortable": false },
                    { "sTitle": "Citrus PaymentMode", "mData": "Citrus_PaymentMode", "bSortable": false },
                    { "sTitle": "Citrus TxGateway", "mData": "Citrus_TxGateway", "bSortable": false },
                    { "sTitle": "Amount", "mData": "amount", "bSortable": false },
                    { "sTitle": "Payment Received Status", "mData": "status_is_payment_received", "bSortable": false },
                    {
                        "sTitle": "Download Doc", "mData": null, "bSortable": false, "mRender": function (data) {
                            if (data.DocName != "") {
                                return '<center><a href="' + window.location.origin + '/HostelFeesDoc/' + data.DocName + '" download style="text-decoration:none;" class="cv_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';;
                            }
                            else { return ''; }
                        }
                    }
                ]

            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {
                asInitVals[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Hostel Fees Report
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Start Date :
                            </td>
                            <td>
                                <input type=text id="from_date" />
                            </td>
                            <td>
                               End Date :
                            </td>
                            <td>
                                <input type=text id="to_date" />
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="DataList" style="display: none;overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            
        </div>
    
    </div>

</asp:Content>

