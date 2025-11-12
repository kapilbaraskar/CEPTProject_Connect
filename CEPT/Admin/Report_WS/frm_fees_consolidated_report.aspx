<%@ Page Title="Fees Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_fees_consolidated_report.aspx.cs" Inherits="Admin_Report_frm_fees_consolidated_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>
       <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">

        var oTable;
        $(document).ready(function () {

            //bindyeardata();
            //bindsemdata();
            //binddepartment();

            bind_ws_semdata();

            //binddepartment();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                //total_selected_course
                Fees_consolidated_data();
                return false;
            });

            return false;
        });

        function Fees_consolidated_data() {
            $('#DataList').css('display', 'none');

            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            //var dept_code = $('#drpdepartment').val();
            //var year_Code = $("#drpyear").val();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/get_fees_consolidated_report",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_fees_consolidated_data(data.d);
                    }
                    else {
                        bootbox.alert('There is no data found for selected semester or Year');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function display_fees_consolidated_data(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": 'b',
                //"sScrollX": '700px',
               // "sScrollY": '700px',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
           //     "oTableTools":
           //     {
           //         "aButtons": [
        			//	"copy",
        			//	"print",
        			//	{
        			//		"sExtends": "collection",
        			//		"sButtonText": 'Export',
        			//		"aButtons": ["xls"]
        			//	}
        			//]
           //     },
                "aaData": JSON.parse(data),
                "aoColumns": [
                        { "sTitle": "Student Code", "mData": "code", "bSortable": false },
                        { "sTitle": "Student Name", "mData": "name", "bSortable": false },
                        { "sTitle": "Email Id", "mData": "mail", "bSortable": false },
                        { "sTitle": "Mobile No", "mData": "mobile_no", "bSortable": false },
                        { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                        { "sTitle": "Department", "mData": "department_name", "bSortable": false },
                        { "sTitle": "Program", "mData": "program", "bSortable": false },
                        { "sTitle": "Year of Enrollment", "mData": "year_desc", "bSortable": false },
                        { "sTitle": "Credit choice", "mData": "credit_choice", "bSortable": false },
                        { "sTitle": "Non Paying Credits", "mData": "waiver_credits", "bSortable": false },
                        { "sTitle": "Fees Waiver Credits", "mData": "fees_waiver_credits", "bSortable": false },
                        { "sTitle": "Allocate Credits", "mData": "allocate_credits", "bSortable": false },
                        { "sTitle": "Amount", "mData": "fees_status", "bSortable": false },
                        { "sTitle": "Type of Payment", "mData": "payment_mode", "bSortable": false },
                        { "sTitle": "Transaction Id", "mData": "transaction_id", "bSortable": false, "sClass": "cls_transaction_id" },
                        { "sTitle": "New Transaction Id", "mData": "new_transaction_id", "bSortable": false},
                        { "sTitle": "Citrus Txn Id", "mData": "Citrus_TxRefNo", "bSortable": false },
                        { "sTitle": "Allocate Course", "mData": "allocate_course", "bSortable": false },
                        //{ "sTitle": "Created Date", "mData": "fees_date", "bSortable": false }
                ]
            });

            $('#example tbody tr').each(function (i) {
                var temp_data = $(this).find('.cls_transaction_id').html();
                temp_data = temp_data.substring(2, temp_data.length - 1);
                $(this).find('.cls_transaction_id').html(temp_data);
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
                <i class="icon-desktop"></i> Fees Consolidated Report
            </h1>
        </div>

        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
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

            <div id="DataList" style="display: none; overflow:auto;">
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

