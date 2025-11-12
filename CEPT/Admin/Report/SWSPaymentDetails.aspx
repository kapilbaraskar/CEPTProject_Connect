<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SWSPaymentDetails.aspx.cs" Inherits="Admin_Report_SWSPaymentDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../Js/loder.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
           
            bind_ws_semdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                course_wise_student_dtl();
                return false;
            });
          

           // return false;
        });

        function bind_ws_semdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            $('#drpsemester').chosen();

        }

        function bindyeardata_for_cross_reg() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/Get_year_data",

                data: "{}",
                dataType: "json",
                success: function (data) {




                    if (data.d != "") {


                        var year_data = JSON.parse(data.d)



                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {


                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function publish_allocation_data(status_data) {
            var statusdata = status_data;
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

            var course_type = $('#drpcoursetype').val();
            if (course_type == "") {
                bootbox.alert('Please Course Type')
                $('#drpcoursetype').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/sw_publish_allocation_data",
                //data: "{sem_code :'" + semester + "' , year_code : '" + year_code + "', status :'" + statusdata +"' }",
                data: "{status :'" + statusdata + "',course_type :'" + course_type + "' }",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        bootbox.alert(data.d);
                        course_wise_student_dtl();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }
        function course_wise_student_dtl() {
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

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetFeesCalculationAndVerificationCreditWise",
                data: "{sem_code: '" + semester + "',year_code:'" + year_code + "',userid:''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

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
                    { "sTitle": "Total Allocated Credits", "mData": "AllocatedCredits", "bSortable": false },
                    { "sTitle": "Fees Waiver Credits", "mData": "fees_waiver_credits", "bSortable": false },
                    { "sTitle": "Payment Recived Credit", "mData": "PaymentRecivedCredit", "bSortable": false },
                    { "sTitle": "Remaning Wavier Credit", "mData": "RemaningWavierCredit", "bSortable": false },
                    { "sTitle": "Credit Wise Payment", "mData": "PaymentGet", "bSortable": false },
                    { "sTitle": "Recived Payment", "mData": "PaymentGetApplication", "bSortable": false },
                    { "sTitle": "Status", "mData": "Status", "bSortable": false }
                    
                ],
                "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    // Check the Status value and apply the color
                    if (aData.Status == "Less Payment") {
                        $(nRow).css('background-color', 'Red'); // Light red for "Less Than"
                    } else if (aData.Status == "Equal") {
                        $(nRow).css('background-color', '#dff0d8'); // Light green for "Equal"
                    } else {
                        $(nRow).css('background-color', '#fcf8e3'); // Light yellow for "Not Equal"
                    }
                }
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Check Payment Status
            </h1>
        </div>
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
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                             <td>
                                Year of Allocation :
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
            
            <div id="DataList" class="panel panel-default" style="display: none">
                <div class="panel-heading">
                    <strong>Check Payment Details</strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            
        </div>

</asp:Content>

