<%@ Page Title="Cross Allocation Mandatory" Language="C#" AutoEventWireup="true" MasterPageFile="~/AdminCEPT.master" CodeFile="frm_course_cross_Faculty_student_wise_mandatory_report.aspx.cs" Inherits="Admin_Report_frm_course_cross_Faculty_student_wise_mandatory_report" %>

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

            debugger;
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

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_cross_Faculty_student_wise_mandatory",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {
                        display_Student_Data(data.d);
                        $('#div_data_list').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester or Year');
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
                    { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "FA-UG", "mData": "Architecture_UG", "bSortable": false },
                    { "sTitle": "FA-PG", "mData": "Architecture_PG", "bSortable": false },
                    { "sTitle": "FA-PHD", "mData": "Architecture_Doctoral", "bSortable": false },
                    { "sTitle": "FD-UG", "mData": "Design_UG", "bSortable": false },
                    { "sTitle": "FD-PG", "mData": "Design_PG", "bSortable": false },
                    { "sTitle": "FM-PG", "mData": "Management_PG", "bSortable": false },
                    { "sTitle": "FP-UG", "mData": "Planning_UG", "bSortable": false },
                    { "sTitle": "FD-PG", "mData": "Planning_PG", "bSortable": false },
                    { "sTitle": "FD-PHD", "mData": "Planning_Doctoral", "bSortable": false },
                    { "sTitle": "FT-UG", "mData": "Technology_UG", "bSortable": false },
                    { "sTitle": "FT-PG", "mData": "Technology_PG", "bSortable": false }


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
                <i class="icon-desktop"></i>&nbsp; Cross Allocation Mandatory
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
                <div id="DataList" style="display: none;">
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
