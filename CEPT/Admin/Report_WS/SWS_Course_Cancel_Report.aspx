<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SWS_Course_Cancel_Report.aspx.cs" Inherits="Admin_Report_WS_SWS_Course_Cancel_Report" %>

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
            //bindtypedata();

            $('#btnreterive').on('click', function () {
                get_cancel_seat_details();
                return false;
            });
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

        function get_cancel_seat_details() {

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

            //var type = $('#drptype').val();
           
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cancel_seat_details",
                data: "{sem_code :'" + sem_code + "',year_code : '" + year_code +  "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d != "") {
                            Display_Data(data.d);
                            $('#DataList').css('display', 'block');
                        }
                        else {
                            if (data.d == "") {
                                bootbox.alert('No data Found.');
                                return false;
                            }
                        }
                    }
                    else {
                        bootbox.alert('No data Found.');
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
                    { "sTitle": "Course Code", "mData": "ws_course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Credits", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Available Seat", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Minimum Seat", "mData": "minimum_seat", "bSortable": false },
                    {
                        "sTitle": "GPA/NGPA", "mData": null, "bSortable": false, mRender: function (data)
                        {
                            if (data.gpa_status == "G") {
                                return '<center>GPA</center>';
                            }
                            else if (data.gpa_status == "N") {
                                return '<center>NGPA</center>';
                            }
                        }
                    },
                    {
                        "sTitle": "Students", "mData": null, "bSortable": false, mRender: function (data)
                        {
                            return '<center><button type="button" id=' + data.ws_course_code + ' onclick="rowClick_view(this)">View</button></center>';
                        }
                    }]

            });

            $('#DataList').css('display', 'block');
        }

        function rowClick_view(row) {
            var c = row.id;
            window.open("SWS_Course_Cancel_Students.aspx?c=" + c + "&s=" + $('#drpsemester').val() + "&y=" + $('#drpyear').val(), "_blank");
        }
    
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;SWS Course Cancel Report
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default">
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
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                    <%--<tr>
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
                    </tr>--%>
                </table>
            </div>
        </div>

        <div id="DataList" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Cancel Seat Details</strong>
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


</asp:Content>

