<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="FeesReminderReport.aspx.cs" Inherits="Admin_Report_FeesReminderReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=28082019" type="text/javascript"></script>
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

            $('#btnreterive').on('click', function () {
                retrieve_Data();
                return false;
            });
        });


        function retrieve_Data() {
            $('#DataList').css('display', 'none');

            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            var installment = $('#drpinstallment').val();
            if (installment == "") {
                bootbox.alert('Please select Year');
                $('#drpinstallment').focus();
                return false;
            }

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_fees_reminder_mail_report_data",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "', installment : '" + installment + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_Student_Data(data.d);
                        $('#div_data_list').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester or Year or Installment');
                        $('#div_data_list').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function display_Student_Data(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]

                //        }
                //    ]
                //},

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Programme", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Installment 1 Fine", "mData": "installment1_fine", "bSortable": false }, /// Retured By Ananth///
                    { "sTitle": "Installment 2 Fine", "mData": "installment2_fine", "bSortable": false },
                    { "sTitle": "Installment 3 Fine", "mData": "installment3_fine", "bSortable": false },
                    { "sTitle": "Fees Type", "mData": "fees_type", "bSortable": false },
                    { "sTitle": "Installment Status", "mData": "installment_status", "bSortable": false },
                    { "sTitle": "No of Installment", "mData": "no_of_installment", "bSortable": false },
                    { "sTitle": "Fees Amount", "mData": "fees_amount", "bSortable": false },
                    //{
                    //    "sTitle": "Installment 1", "mData": "installment1", "bSortable": false, "fnRender": function (data) {
                    //        var ws_passed = 0;
                    //        if (data.aData.ws_M_Passed != '') ws_passed += parseFloat(data.aData.ws_M_Passed);
                    //        if (data.aData.ws_E_Passed != '') ws_passed += parseFloat(data.aData.ws_E_Passed);
                    //        return ws_passed;
                    //    }
                    //},
                    { "sTitle": "Installment 2", "mData": "installment2", "bSortable": false },
                    { "sTitle": "Installment 3", "mData": "installment3", "bSortable": false },
                    { "sTitle": "Installment 4", "mData": "installment4", "bSortable": false },
                    { "sTitle": "Installment 5", "mData": "installment5", "bSortable": false },
                    { "sTitle": "Installment 1 Paid", "mData": "is_installment1_paid", "bSortable": false },
                    { "sTitle": "Installment 2 Paid", "mData": "is_installment2_paid", "bSortable": false },
                    { "sTitle": "Installment 3 Paid", "mData": "is_installment3_paid", "bSortable": false },
                    { "sTitle": "Installment 4 Paid", "mData": "is_installment4_paid", "bSortable": false },
                    { "sTitle": "Installment 5 Paid", "mData": "is_installment5_paid", "bSortable": false }
                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Download)
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
                <i class="icon-desktop"></i>&nbsp; Fees Reminder Mail Report
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div> <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                     Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester" style="width: 199px !important;">
                                    </select>
                                </td>
                                <td>
                               Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear" style="width: 199px !important;">
                                    </select>
                                </td>
                                <td>
                               Installment :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpinstallment" style="width: 199px !important;margin-top: 10px;">
                                        <option value="1">Installment 1</option>
                                        <option value="2">Installment 2</option>
                                        <option value="3">Installment 3</option>
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
            </div>

        </div>

        <div id="div_data_list" class="panel panel-default" style="display:none;">
            
            <div class="panel-heading">
                <strong>Data List</strong>
                <span style="float:right;">
                    <%--<asp:Button ID="btn_download_all" class="btn btn-primary" runat="server" Text="Download All" OnClick="Button1_Click" style="height: 40px;margin-top: -10px;"/>--%>
                </span>
            </div>

            <div> <%--class="panel-body"--%>
                <div id="DataList" style="display: none;overflow:auto;">
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

