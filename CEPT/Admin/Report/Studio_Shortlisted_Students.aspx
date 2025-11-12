<%@ Page Title="Short Listed Student" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Studio_Shortlisted_Students.aspx.cs" Inherits="Admin_Report_Studio_Shortlisted_Students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/admin_report.js?t=28082019" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var user_status;
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
          //  bindyeardata();
            bindsemdata();
            binddepartment()

            ///// Returned By Ananth ////
            bindprogrammedata();
            bindproglevel();

            $('#btnreterive').on('click', function () {

                Shortlist_course_dtl();

                return false;

            });

            $('#drpproglevel').on('change', function () {
                if ($('#drpyear').val() != '' && $('#drpsemester').val() != '' && $('#drpdepartment').val() != '' && $('#drpprog').val() != '' && $('#drpproglevel').val() != '') {
                    bind_student_course_allocated_report();  
                }
            });

            $('#btn_assign').on('click', function () {
                return false;
            });
            return false;
        });
        function Shortlist_course_dtl() {

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
            var prog_code = $('#drpprog').val();
            var prog_level_code = $('#drpproglevel').val();
            var course_code = $("#drcourses").val();


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/shortlist_student_report",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',course_code:'" + course_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        user_status = JSON.parse(data.d);
                        user_status = user_status[0]["user_status"];

                        display_student_Course_allocation(data.d);
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

        function display_student_Course_allocation(data) {
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
                    { "sTitle": "Course Code", "mData": "new_course_code", "bSortable": false, "bVisible": false },
                    //{ "sTitle": "Course Name", "mData": "course_name","bSortable": false, "bVisible": false },
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                    { "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Studio Level", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Email Id", "mData": "mail", "bSortable": false, "sClass": "cls_hide" },
                    { "sTitle": "Mobile Number", "mData": "mobile_no", "bSortable": false, "sClass": "cls_hide" }
                    //{ "sTitle": "Priority", "mData": "priority", "bSortable": false }
                ]
            }).rowGrouping();

            $('#DataList').css('display', 'block');
            if (user_status == 'E')
            { $('.cls_hide').css('display', 'none'); }
            
           
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">

            <h1>
                <i class="icon-desktop"></i> Short Listed Student
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
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                              <td>
                                Year of allocation :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <%--<td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>--%>
                            <td>
                               Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>
                          
                        </tr>
                        <tr>
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
                        </tr>
                        <tr>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="DataList" style="display: none">
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

