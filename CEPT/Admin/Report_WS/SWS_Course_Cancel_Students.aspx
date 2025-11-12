<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SWS_Course_Cancel_Students.aspx.cs" Inherits="Admin_Report_WS_SWS_Course_Cancel_Students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">

        var oTable;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            //binddepartment();
            //bindprogramme();
            bindtypedata();
            get_page_load_dtl();
            //$('#btnreterive').on('click', function () {
            //    get_reg_student_dtl();
            //    return false;

            //});

            return false;
        });

        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
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

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            $('#drpsemester').chosen();
        }

        function bindtypedata() {
            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("O").html("Offered"));
            $('#drptype').append($("<option></option>").val("E").html("Expired"));
            $('#drptype').append($("<option></option>").val("A").html("Accept"));
            $('#drptype').append($("<option></option>").val("R").html("Reject"));
            $('#drptype').chosen();
        }

        function get_page_load_dtl() {
            debugger;
            $('#DataList').css('display', 'none');
            var sem_code = $('#hdn_s').val();
            var year_code = $('#hdn_y').val();
            var course_code = $('#hdn_c').val();

            $("#CC").html("<b>" + course_code + "</b>");

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cancel_seat_students_details",
                data: "{sem_code :'" + sem_code + "',year_code : '" + year_code + "',course_code:'" + course_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d != "") {
                            Display_Data(data.d);
                            $('#DataList').css('display', 'block');
                        }
                        else {
                            if (data.d == "") {
                                bootbox.alert('There is No data Found');
                                return false;
                            }

                        }
                    }
                    else {

                        bootbox.alert('There is No data Found');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function get_reg_student_dtl() {

            $('#DataList').css('display', 'none');
            var sem_code = $('#drpsemester').val();
            if (sem_code == "") {
                bootbox.alert('Please select Semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }
            var type = $('#drptype').val();
            var cancel_seat_number = '';

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Ws_student_wise_course_timer_dtl",
                data: "{sem_code :'" + sem_code + "',year_code : '" + year_code + "',type: '" + type + "',cancel_seat_number:'" + cancel_seat_number +"'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d != "") {
                            Display_Data(data.d);
                            $('#DataList').css('display', 'block');
                        }
                        else {
                            if (data.d == "") {
                                bootbox.alert('There is No data Found');
                                return false;
                            }

                        }
                    }
                    else {

                        bootbox.alert('There is No data Found');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function Display_Data(data) {

            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();


                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    {
                        "sTitle": "Course Type", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.course_type == "E") {
                                return '<center>Elective</center>';
                            }
                            else if (data.course_type == "M") {
                                return '<center>Mandatory</center>';
                            }
                        }
                    },
                    {
                        "sTitle": "GPA/NGPA", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.gpa_nongpa == "G") {
                                return '<center>GPA</center>';
                            }
                            else if (data.gpa_nongpa == "N") {
                                return '<center>NGPA</center>';
                            }
                        }
                    },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.status == "S") {
                                return '<center>Saved</center>';
                            }
                            else if (data.status == "R") {
                                return '<center>Registered</center>';
                            }
                            else if (data.status == "A") {
                                return '<center>Allocated</center>';
                            } else {
                                return '<center></center>';
                            }
                        }
                    }
                    ]

            });

            $('#DataList').css('display', 'block');
        }


    
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;SWS Course Cancel Students List
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default" style="display:none;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="5" cellspacing="5">
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
                    </tr>
                    <tr>
                        <td>Type :
                        </td>
                        <td>
                            <select class="chosen-select" id="drptype">
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

        <div id="DataList" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Course : <span id="CC"></span></strong>
            </div>
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
    <input type="hidden" id="hdn_c" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_s" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_y" runat="server" clientidmode="Static"/>
</asp:Content>

