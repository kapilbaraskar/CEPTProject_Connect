<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_wise_drop_course_dtl.aspx.cs" Inherits="Admin_Report_Student_wise_drop_course_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>
        .cls_hide {
            color:blue;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
      

            bind_semdata();

            binddepartment();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {

                Drop_course_by_popup_after_allocation();

                return false;
            });

           

            return false;

        });
        function bind_semdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();

        }

        function binddepartment() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",

                data: "{}",
                dataType: "json",
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

        function bindyeardata_for_cross_reg() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",

                data: "{}",
                dataType: "json",
                success: function (data)
                {
                    if (data.d != "") {

                        var year_data = JSON.parse(data.d);
                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++)
                        {
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


        function Drop_course_by_popup_after_allocation() {
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
                    url: "../../WebService.asmx/Student_wise_drop_dtl",

                    data: "{semester_type:'" + semester + "' , year_type : '" + year_code + "',dept_code: '" + dept_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            display_Drop_course(data.d);
                        }
                        else {
                            bootbox.alert('There is no data found for selected semester or year');
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }






        function display_Drop_course(data) {


            if (oTable != null) {
                oTable.fnDestroy();


                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Course Code", "mData": "course_code", "sClass": "cls_hide", "bSortable": false },
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Date", "mData": "date", "bSortable": false },
                    { "sTitle": "Time", "mData": "time", "bSortable": false }


                ]


            }).rowGrouping();

            $('#DataList').css('display', 'block');

            $("#example tbody tr").each(function (i) {
                //$('#example tr td .cls_hide').css('color', 'blue');
               // $('#example td:first-child : contains(-)').css('color', 'blue');
                
            });
        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Student Wise Drop Course
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
                                Semester:
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
                            </tr>
                        <tr>
                            <td>
                              Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
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
            <div id="DataList" class="panel panel-default" style="display: none;overflow: auto;" >
                <div class="panel-heading">
                <strong id="panel_head">Drop Course Details</strong>
            </div>
                <div>
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
</asp:Content>

