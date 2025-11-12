<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="StudentAccountLedgerReport.aspx.cs" Inherits="Admin_Report_StudentAccountLedgerReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
  <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    
    <script src="../../Js/loder.js" type="text/javascript"></script>


    <script type="text/javascript">
    var oTable;
    var oTable1;
    $(document).ready(function () {

        binddepartment();
        bindprogrammedata();
        
        $("#drpdepartment").change(function () {
            if ($('#drpprog').val() == '') {
                alert("Please Select Program");
                return false;
            }
            bindstudent();

        });

        $("#drpprog").change(function () {
            if ($('#drpdepartment').val() == '') {
                alert("Please Select Department");
                return false;
            }
            bindstudent();

        });

        $('#btnreterive').on('click', function () {
            Apply_Get_Data();
            return false;
        });
        return false;

    });
        function Apply_Get_Data() {

        if ($('#drp_student_code').val() == '')
        {
            bootbox.alert("Please Select Student Code");
            return false;

        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/StudentAccountLedger",
            data: "{Student_Code: '" + $('#drp_student_code').val() + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {

                    var datauser = JSON.parse(data.d);
                    if (datauser.length > 0) {
                        $('#studentCode').text($('#drp_student_code').val());
                        $('#studentName').text(datauser[0]['full_name']);
                        $('#studentFaculty').text(datauser[0]['dept_name']);
                        Display_report(data.d);
                    }
                    else {
                        $('#DataList').css('display', 'none');
                        $('#studentCode').text('');
                        $('#studentName').text('');
                        $('#studentFaculty').text('');

                    }
                    

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
                { "sTitle": "Semester", "mData": "semester", "bSortable": false },
                { "sTitle": "Date", "mData": "CreatedDate", "bSortable": false },
                { "sTitle": "Description", "mData": "Description", "bSortable": false },
                { "sTitle": "Reference", "mData": "REFERENCE", "bSortable": false },
                { "sTitle": "Amount", "mData": "Credit", "bSortable": false }
            ]
        }).rowGrouping();

       // updateFooter(oTable);
        $('#DataList').css('display', 'block');
    }

        function updateFooter(oTable) {
            // Remove the formatting to get the raw data for total calculation
            var intVal = function (i) {
                return typeof i === 'string' ?
                    i.replace(/[\$,]/g, '') * 1 :
                    typeof i === 'number' ?
                        i : 0;
            };

            // Get all the data from the table using fnGetData (works with older versions)
            var allData = oTable.fnGetData();

            // Calculate the total sum of the entire dataset
            var total = allData.reduce(function (a, b) {
                return intVal(parseFloat(a.Credit || 0)) + intVal(parseFloat(b.Credit || 0)); // Use "Credit" as the column name
            }, 0);

            // Get only the current page data
            var currentPageData = oTable.fnGetNodes();  // Get nodes for current page

            // Calculate the sum for this page only
            var pageTotal = $(currentPageData).map(function () {
                return intVal($(this).find('td:eq(4)').text());  // Adjust index if needed
            }).get().reduce(function (a, b) {
                return a + b;
            }, 0);

            // Update the footer with the total for the current page and overall total
            $(oTable.fnSettings().aoColumns[4].nTf).html(
                '$' + pageTotal + ' ( $' + total + ' total )'
            );
        }

        function bindstudent() {
            $('#drp_student_code').empty().append($("<option></option>").val("").html("-- Select Student Code --"));
            $('#drp_student_code').chosen();
            $('#drp_student_code').val('').trigger("liszt:updated");
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_student_report_list_prog",
                data: "{dept_code: '" + $('#drpdepartment').val() + "',prog_code: '" + $('#drpprog').val() + "'}",
                dataType: "json",
                aSync: false,
                success: function (data) {
                    if (data.d != "") {
                        var stud_data = JSON.parse(data.d)

                       // $('#drp_student_code').empty().append($("<option></option>").val("").html("-- Select Student Code --"));
                        for (var i = 0; i < stud_data.length; i++) {
                            $('#drp_student_code').append($("<option></option>").val(stud_data[i]["user_id"]).html(stud_data[i]["user_id"]));
                        }
                        $('#drp_student_code').chosen();
                        $('#drp_student_code').val('').trigger("liszt:updated");
                       
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function binddepartment() {
            var user_url = '../../WebService.asmx/Get_department_data';
            if ($('#hdnusertype').val() == 'FA') {
                user_url = '../../WebService.asmx/Get_cur_FA_department_wise_data'
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: user_url,
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var sem_data = JSON.parse(data.d)

                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));

                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }

                        $('#drpdepartment').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
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
                            Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                             <td>
                            Program :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog" />
                        </td>

                            <td>
                              Student Code : </td>
                            <td>
                                <select class="chosen-select" id="drp_student_code" />
                            </td>
                        </tr><tr>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>

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
</asp:Content>

