<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="NADReport.aspx.cs" Inherits="Admin_Report_NADReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script><%--01012021--%>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
     <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            binddepartment()
            bindprogrammedata();
            bindyeardata();
            $('#btnreterive').on('click', function () {
                GetNADReport();
                return false;
            });            
            return false;
        });

         function bindyeardata() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/Get_year_data",
                 async: false,
                 data: "{}",
                 dataType: "json",
                 success: function (data) {
                     if (data.d != "") {
                         var year_data = JSON.parse(data.d);

                         $('#drpsemyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                         for (var i = 0; i < year_data.length; i++) {
                             $('#drpsemyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                         }

                         $('#drpsemyear').chosen();
                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             }); 
         }
         function GetNADReport() {

             $('#DataList').css('display', 'none');

             var year_code = $('#drpsemyear').val();
             if (year_code == "") {
                 bootbox.alert('Please select Year')
                 $('#drpsemyear').focus();
                 return false;
             }

             
             var dept_code = $('#drpdepartment').val();
             var prog_code = $('#drpprog').val();
             var semestertype = $('#drpsemester').val();
             var yearsemester = $('#drpyear').val();

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/GetNADReportDetails",
                 data: "{programcode : '" + prog_code + "',admissionyear: '" + year_code + "',dept_code:'" + dept_code + "',semestertype:'" + semestertype + "',yearsemester:'" + yearsemester + "'}",
                 dataType: "json",
                 success: function (data) {
                     if (data.d != "") {
                        display_NAD_Data(data.d[0]);
                     }
                     else {
                         bootbox.alert('There is No data Found For Selected Semester or Year');
                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             });

             return false;
         }
      
         function display_NAD_Data(data) {
             if (oTable != null) {
                 oTable.fnDestroy();
                 $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody></tbody></table>');
             }

             var ModifiedData = JSON.parse(data);
             var firstRow = ModifiedData[0] || {};
             var aoColumns = Object.keys(firstRow).map(function (key) {
                 return {
                     sTitle: key.replace(/_/g, " ").replace(/\b\w/g, l => l.toUpperCase()), // Format title
                     mData: key,
                     bSortable: false
                 };
             });

             oTable = $("#example").dataTable({
                 bPaginate: true,
                 bSortable: false,
                 bSort: false,
                 iDisplayLength: 200,
                 sDom: "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                 oLanguage: {
                     sSearch: "Search all columns with Space:"
                 },
                 aaData: ModifiedData,
                 aoColumns: aoColumns
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
                <i class="icon-desktop"></i> NAD Report
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
                                Admission Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemyear">
                                </select>
                            </td>
                            <td>
                               Program :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog" />
                            </td>
                            <td>
                               Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>
                            </tr>
                        <tr>
                            <td>
                               Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                    <option value ="">--Please Select Semester--</option>
                                    <option value ="M">Monsoon</option>
                                    <option value ="S">Spring</option>
                                    
                                    </select>
                            </td>

                            <td>
                               year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear" />
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
            <div >

         
            <div id="DataList" style="display: none; overflow:auto;" class="panel panel-default">
                 <div class="panel-heading">
                <strong id="panel_head">Course Allocation Report</strong>
            </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <table width="100%" border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td align="center">
                        <button class="btn btn-primary" style="display: none" type="submit" id="btn_assign">
                            Assign Course
                        </button>
                    </td>
                </tr>
            </table>
                   </div>
        </div>
</asp:Content>

