<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_wise_scholarship_dtl.aspx.cs" Inherits="Admin_Report_Student_wise_scholarship_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/fixedcolumns/3.2.6/css/fixedColumns.dataTables.min.css" />
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();

            $('#btnreterive').on('click', function () {
                scholarship_report_data();



                return false;
            });

            return false;
        });


        function scholarship_report_data() {
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

            $.ajax(

                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_Scholarship_Report_dtl",

                    data: "{sem_code: '" + semester + "',year_code:'" + year_code + "',dept_code: '" + dept_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "")
                        {
                            Display_scholarship_report_data(data.d);
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



        function Display_scholarship_report_data(data) {
            
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
                    { "sTitle": "Year of Enrollment", "mData": "year_code", "bSortable": false },
                    { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                    { "sTitle": "Total Fees", "mData": "fees_amount", "bSortable": false },
                    { "sTitle": "Installment 1 Amount", "mData": "installment1", "bSortable": false },
                    { "sTitle": "Installment 2 Amount", "mData": "installment2", "bSortable": false },
                    { "sTitle": "Installment 3 Amount", "mData": "installment3", "bSortable": false },
                    { "sTitle": "Installment 4 Amount", "mData": "installment4", "bSortable": false },
                    { "sTitle": "Installment 1", "mData": "installment1_paid", "bSortable": false },
                    { "sTitle": "Installment 2", "mData": "installment2_paid", "bSortable": false },
                    { "sTitle": "Installment 3", "mData": "installment3_paid", "bSortable": false },
                    { "sTitle": "Installment 4", "mData": "installment4_paid", "bSortable": false },

                    { "sTitle": "Scholar Ship Percentage", "mData": "scholarship_percentage", "bSortable": false },
                    { "sTitle": "Apprve Scholarship Amount", "mData": "apprve_scholarship_amount", "bSortable": false },
                    { "sTitle": "Approve Date", "mData": "approve_date", "bSortable": false },
                    { "sTitle": "Carry Forward Amount", "mData": "carry_forward_amount", "bSortable": false },
                    { "sTitle": "Referance No", "mData": "ref_no", "bSortable": false },
                    { "sTitle": "Remark", "mData": "remark", "bSortable": false },


                    { "sTitle": "Semester", "mData": "semester_type", "bSortable": false },
                    { "sTitle": "Year", "mData": "year_semester", "bSortable": false },
                    
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Scholar Ship Report
            </h1>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>Year of allocation
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td>Department
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
</asp:Content>

