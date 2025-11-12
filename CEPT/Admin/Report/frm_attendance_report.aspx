<%@ Page Title="Attendance Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frm_attendance_report.aspx.cs" Inherits="Admin_Report_frm_attendance_report" %>

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


            $('#start_date').datepicker({
                dateFormat: "dd/mm/yy"
            });

            $('#end_date').datepicker({
                dateFormat: "dd/mm/yy"
            });

            $('#btnreterive').on('click', function () {


                var start_date = $('#start_date').val(); // '2014-03-05';
                if (start_date == "") {
                    bootbox.alert('Please select Start Date')
                    $('#start_date').focus();
                    return false;
                }

                var end_date = $('#end_date').val(); //'2014-10-01';
                if (end_date == "") {
                    bootbox.alert('Please select End Date')
                    $('#end_date').focus();
                    return false;
                }

                $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_attendance_report_data",

        data: "{start_date: '" + start_date + "',end_date:'" + end_date + "'}",
        dataType: "json",
        success: function (data) {
            $('#DataList').css('display', 'none');
            if (data.d != "") {

                display_data(data.d);

            }
            else {
                bootbox.alert('There is No data Found For Selected date');
                return false;
            }

        },
        error: function (result) {
            alert(result);
        }
    });



                return false;

            });


        });


        function display_data(data) {

            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();


                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": 'b',
                //  "sScrollY": '400px',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //        "oLanguage": {
                //            "sSearch": "Search all columns with Space:"
                //        },
        //        "oTableTools":
        //{
        //    "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls"]
        //							}
        //						]
        //},

                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Date", "mData": "punch_date", "bSortable": false },
                      { "sTitle": "Entry Time", "mData": "entrytime", "bSortable": false },
                        { "sTitle": "Exit Time", "mData": "exittime", "bSortable": false },
                          { "sTitle": "Total Time", "mData": "total_time", "bSortable": false },
                         { "sTitle": "Entry Ip", "mData": "entry_ip", "bSortable": false },
                           { "sTitle": "Exit Ip", "mData": "exit_ip", "bSortable": false },
                            { "sTitle": "Entry Computer Name", "mData": "entry_com_name", "bSortable": false },
                               { "sTitle": "Exit Computer Name", "mData": "exit_com_name", "bSortable": false }
                //                    ,
//                    ,
//                    { "sTitle": "Program Type", "mData": "Program Type", "bSortable": false },
//                    { "sTitle": "Year", "mData": "year_code", "bSortable": false },
//                    { "sTitle": "Category", "mData": "Category", "bSortable": false },
//                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
//                    { "sTitle": "Fees Paid", "mData": "amount", "bSortable": false },
//                    { "sTitle": "Date of Payment", "mData": "Date of Payment", "bSortable": false },
//                    { "sTitle": "Payment Mode", "mData": "Payment Mode", "bSortable": false },
//                    { "sTitle": "Payment Reference", "mData": "transaction_id", "bSortable": false }
           ]

            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        
        
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Attendance Report
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <%-- <td>
                                Programme :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprogramme">
                                    <option value=''> --- select --- </option>
                                    <option value='UG'>UG</option>
                                    <option value='PG'>PG</option>
                                    <option value='PhD'>PhD</option>
                                </select>
                            </td>--%>
                            <td>
                                Start Date :
                            </td>
                            <td>
                                <input type="text" id="start_date" />
                            </td>
                            <td>
                                End Date :
                            </td>
                            <td>
                                <input type="text" id="end_date" />
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
            <div id="DataList" style="display: none">
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
