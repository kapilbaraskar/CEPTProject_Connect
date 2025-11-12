<%@ Page Title="Student Fine Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_wise_fine_dtl.aspx.cs" Inherits="Admin_Master_student_wise_fine_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">   
     var oTable1;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            $('#btnreterive').on('click', function () {
                student_wise_fine_report();
                return false;
            });
           
            return false;
        });

         function rowClick(row, objtable) {

                var rowId = objtable.fnGetData($(row).closest('tr')[0])['user_id'];
                var sem = objtable.fnGetData($(row).closest('tr')[0])['semester_type'];
             var year = objtable.fnGetData($(row).closest('tr')[0])['year_semester'];
             var installment_no = objtable.fnGetData($(row).closest('tr')[0])['installment_no'];
             window.location = "student_wise_fine_edit.aspx?c=" + rowId + "&s=" + sem + "&y=" + year + "&i=" + installment_no;
            }
        function student_wise_fine_report() {
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
            var user_id = "";
            var installment_no = "";
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    url: "../../WebService.asmx/get_student_fine_dtl",
                    data: "{semester: '" + semester + "',year_code:'" + year_code + "',user_id:'" + user_id + "',installment_no:'" + installment_no +"'}",
                    dataType: "json",
                    success: function (data) {

                        
                        if (data.d != "")
                        {
                            Display_student_fine_dtl_data(data.d);
                           
                        }
                        else
                        {
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
        function Display_student_fine_dtl_data(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable1 = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //        //"copy",
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
                    { "sTitle": "User Id", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Installment No", "mData": "installment_no", "bSortable": false },
                    { "sTitle": "Installment Fine", "mData": "installment_fine", "bSortable": false },
                    { "sTitle": "Paid Installment Fine", "mData": "paid_installment_fine", "bSortable": false },
                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            return '<center><button type="button" onclick="rowClick(this,oTable1)">Edit</button></center>';
                        }
                    }
                ]
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
                <i class="icon-desktop"></i> Student Fine Details
            </h1>
        </div>

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
                            Year 
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

        <div id="DataList" class="panel panel-default" style="display:none;overflow:auto;">
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

