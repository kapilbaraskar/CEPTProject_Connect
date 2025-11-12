<%@ Page Title="Online Payment Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frm_online_payment_report.aspx.cs" Inherits="Admin_Report_frm_online_payment_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();

            $('#btnreterive').on('click', function () {
                online_payment_report_data();
                return false;
            });

            return false;
        });

        function online_payment_report_data() {
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

            var dept_code = $('#drpdepartment').val();
            //if (dept_code == "") {
            //    bootbox.alert('Please select department')
            //    $('#drpdepartment').focus();
            //    return false;
            //}

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_online_payment_data",
                data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Display_online_payment_report_data(data.d);
                        //display_student_password_data(data.d);
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

        function Display_online_payment_report_data(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                //"sDom": 't',
                //"sScrollY": '400px',
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
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "Transaction No", "mData": "transaction_id", "bSortable": false },
                    { "sTitle": "Amount Paid", "mData": "amount", "bSortable": false },
                    { "sTitle": "Date of Payment", "mData": "created_date", "bSortable": false },
                    { "sTitle": "Mode of Payment", "mData": "Citrus_PaymentMode", "bSortable": false }
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
                <i class="icon-desktop"></i>Online Payment Report
            </h1>
        </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Filter Criteria</strong>
                </div>

                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year of allocation
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                                Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="DataList" class="panel panel-default" style="display: none; overflow: auto;">
                <%--<div class="panel-heading">
                    <strong>Online Payment Detail</strong>
                </div>--%>

                <div>
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
