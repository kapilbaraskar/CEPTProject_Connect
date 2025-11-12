<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="course_wise_attendance_dtl.aspx.cs" Inherits="Admin_Report_course_wise_attendance_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=03022022" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        var semester = "";
        var year_code = "";
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindprogrammedata();
            bindproglevel();

            $('#btnreterive').on('click', function () {
                student_attendance_dtl();
                return false;
            });
            return false;
        });

        function student_attendance_dtl() {

            $('#DataList').css('display', 'none');

             semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

             year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }
            //var dept_code = $('#drpdepartment').val();
            //var prog_code = $('#drpprog').val();
            //var prog_level_code = $('#drpproglevel').val();
            //var course_code = $("#drcourses").val();


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_wise_attendance_dtl",
                //data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',course_code:'" + course_code + "'}",
                data: "{course_code:'' ,sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_course_wise_attendance_dtl(data.d);
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

        function display_course_wise_attendance_dtl(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": true },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "No Of Session Held", "mData": "no_of_session_held", "bSortable": false },
                    {
                        "sTitle": "View", "mData": null, "bSortable": false, mRender: function (data) {

                            return '<center><button type="button" onclick="rowClick(this)">View</button></center>';


                        }
                    },
                    
                    {
                        "sTitle": "PDF", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.doc_pdf != '') {
                                return '<center><button type="button" id=' + data.doc_pdf +' onclick="rowClick_pdf(this)">View PDF</button></center>';
                            }
                            else { return ""; }
                            


                        }
                    },
                    {
                        "sTitle": "Attendance", "mData": null, "bSortable": false, mRender: function (data) {

                            return '<center><button type="button" onclick="rowClick_excel(this)">Download Excel</button></center>';

                        }
                    },

                    {
                        "sTitle": "Attendance Percentage", "mData": null, "bSortable": false, mRender: function (data) {

                            return '<center><button type="button" onclick="rowClick_download(this)">Download</button></center>';


                        }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function rowClick(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

            window.open("student_attendance_report.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code, "_blank");
            
        }
        function rowClick_pdf(row)
        {
            debugger;
            var file_path = location.origin + "/AttendancePdfUpload/" + row.id;
            window.open(file_path, "_blank");
            
        }

        function rowClick_download(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            $('#hdn_code').val(rowId);
            $('#hdn_semester').val(semester);
            $('#hdn_year').val(year_code);
            $("#btnDownloadExcelDocuments").click();

        }
        function rowClick_excel(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            $('#hdn_code').val(rowId);
            $('#hdn_semester').val(semester);
            $('#hdn_year').val(year_code);
            $("#btndownloadattendancestatus").click();

        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">

            <h1>
                <i class="icon-desktop"></i> Course Wise Attendance Report
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
                        <td>Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>Year :
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
        <div>


            <div id="DataList" style="display: none; overflow: auto;" class="panel panel-default">
                <div class="panel-heading">
                    <strong id="panel_head">Course Wise Attendance Report</strong>
                </div>
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
    <input type="hidden" id="hdn_code" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_semester" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Style="display: none;"  Text="Button" OnClick="btnDownloadExcelDocuments_Click" ClientIDMode="Static" />
    <asp:Button ID="btndownloadattendancestatus" runat="server" Style="display:none;" Text="Button" ClientIDMode="Static" OnClick="btndownloadattendancestatus_Click"  />

</asp:Content>

