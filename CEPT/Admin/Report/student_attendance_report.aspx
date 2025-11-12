<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_attendance_report.aspx.cs" Inherits="Admin_Report_student_attendance_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=03022022" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        var status = false;
        $(document).ready(function ()
        {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindprogrammedata();
            bindproglevel();
           
            course_code = hdn_code.value;
            sem = hdn_semester.value;
            year = hdn_year.value;

            $('#btnreterive').on('click', function () {
                status = true;
                hdn_code.value = "";
                hdn_semester.value = "";
                hdn_year.value = "";
                student_attendance_dtl();
                return false;
            });
            if (hdn_code.value != "" && hdn_semester.value != "" && hdn_year.value != "") {
                student_attendance_dtl();
                return false;
            }

            
            return false;
        });

        function student_attendance_dtl() {

            var semester = "";
            var year_code = "";
            var course_code = "";
            $('#DataList').css('display', 'none');

            if (hdn_code.value != "" && hdn_semester.value != "" && hdn_year.value != "") {
                semester = hdn_semester.value;
                year_code = hdn_year.value;
                course_code = hdn_code.value;
            }
            else 
            {
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
                course_code = "";
            }
           
            //var dept_code = $('#drpdepartment').val();
            //var prog_code = $('#drpprog').val();
            //var prog_level_code = $('#drpproglevel').val();
            //var course_code = $("#drcourses").val();


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_stubmit_attendance_dtl",
                //data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',course_code:'" + course_code + "'}",
                data: "{course_code:'" + course_code +"' ,sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_student_attendance_dtl(data.d);
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

        function display_student_attendance_dtl(data) {
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
                   { "sTitle": "Course Code", "mData": "held", "bSortable": false, "bVisible": false },
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "No Of Session Attended", "mData": "no_of_session_attended", "bSortable": false },
                    { "sTitle": "Attendance Percentage", "mData": "attendance_percentage", "bSortable": false }
                ]
            }).rowGrouping();

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">

            <h1>
                <i class="icon-desktop"></i> Student Wise Attendance Report
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
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <%--<td>
                               Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>--%>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>
                               Program :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog" />
                            </td>
                            <td>
                               Program Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
                            </td>
                            <td>
                               Course Code :
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses" />
                            </td>
                        </tr>--%>
                    </table>
                </div>
            </div>
            <div >

         
            <div id="DataList" style="display: none; overflow:auto;" class="panel panel-default">
                 <div class="panel-heading">
                <strong id="panel_head">Student Wise Attendance Report</strong>
            </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
          <%--  <table width="100%" border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td align="center">
                        <button class="btn btn-primary" style="display: none" type="submit" id="btn_assign">
                            Assign Course
                        </button>
                    </td>
                </tr>
            </table>--%>
                   </div>
        </div>
    <input type="hidden" id="hdn_code" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_semester" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
</asp:Content>

