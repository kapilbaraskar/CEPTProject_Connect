<%@ Page Title="Block Information" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="user_wise_block_dtl.aspx.cs" Inherits="Admin_Master_user_wise_block_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=19062021" type="text/javascript"></script>
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
            type();
            reporttype();
            bindyeardata();

            $('#btnreterive').on('click', function () {
                enable_disable_data();
                return false;
            });

            return false;
        });

        function type() {
            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Block Type --"));
            $('#drptype').append($("<option></option>").val("project").html("Project Disable"));
            $('#drptype').append($("<option></option>").val("feesnotpaid").html("Feesnot Paid Disable"));
            $('#drptype').append($("<option></option>").val("feedbackdisable").html("Feedback Disable"));
            $('#drptype').append($("<option></option>").val("fees").html("Fees Disable"));
            $('#drptype').append($("<option></option>").val("blockregistration").html("Block Registration Disable"));

            $('#drptype').chosen();
        }

        function reporttype() {
            $('#repdrptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#repdrptype').append($("<option></option>").val("D").html("Disable"));
            $('#repdrptype').append($("<option></option>").val("E").html("Enable"));

            $('#repdrptype').chosen();
        }
        function enable_disable_data() {
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

            var year_allocation = $('#drpyear_alo').val();
            if (year_allocation == "") {
                bootbox.alert('Please select Year Allocation')
                $('#drpyear_alo').focus();
                return false;
            }


            var block_type = $('#drptype').val();
            if (block_type == "") {
                bootbox.alert('Please select Block Type')
                $('#drptype').focus();
                return false;
            }

            var report_type = $('#repdrptype').val();
            if (report_type == "") {
                bootbox.alert('Please select Report Type')
                $('#repdrptype').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Block_user_list",
                data: "{sem_code: '" + semester + "',year_code:'" + year_code + "',year_allocation:'" + year_allocation + "',block_type:'" + block_type + "',report_type:'" + report_type + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Display_block_report(data.d);
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


        function Display_block_report(data) {
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
                    { "sTitle": "Student Id", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "name", "bSortable": false },
                    { "sTitle": "Email Id", "mData": "mail", "bSortable": false },
                    // { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    {
                        "sTitle": "Course Code", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.course_code != "") {
                                //
                                return data.course_code;
                            }
                            else {
                                if ($('#drptype').val() == 'project') {
                                    return "<textarea id='coursecode_" + data.user_id + "' rows='1' cols='25'></textarea>";
                                }
                                //return "<textarea id='" + data.user_id + "' rows='1' cols='25'></textarea>";
                            }

                            return '';
                        }
                    },
                    {
                        "sTitle": "Remarks", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.remark != "") {//project
                                return "<textarea id='" + data.user_id + "' rows='1' cols='25'>" + data.remark + "</textarea>";
                            }
                            else {
                                return "<textarea id='" + data.user_id + "' rows='1' cols='25'></textarea>";
                            }

                            return '';
                        }
                    },
                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            if ($('#repdrptype').val() == "D") {
                                return '<center><button type="button" id=' + data.user_id + ' onclick="rowClick_enable(this)">Enable</button></center>';
                            }
                            else {
                                return '<center><button type="button" id=' + data.user_id + ' onclick="rowClick_disable(this)">Disable</button></center>';
                            }


                            //return '';
                        }
                    }
                ]
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }


        function bindyeardata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",

                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)
                        $('#drpyear_alo').empty().append($("<option></option>").val("").html("-- Please Select Year --"));

                        for (var i = 0; i < year_data.length; i++) {


                            $('#drpyear_alo').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));

                        }

                        $('#drpyear_alo').chosen();
                        // $('#drp_year_allocation').chosen();
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function rowClick_enable(row) {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Enable_block_user",
                    data: "{user_id:'" + row.id + "',sem_code:'" + $('#drpsemester').val() + "',year_code:'" + $('#drpyear').val() + "',block_type:'" + $('#drptype').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Enable Successfully");
                                enable_disable_data();
                            }
                            else {
                                bootbox.alert('Problem in Data');
                            }
                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

        function rowClick_disable(row) {


            var course_code = '';
            if ($('#drptype').val() == "project")
            {
                course_code = $('#coursecode_' + row.id).val();
                if (course_code == '')
                {
                    bootbox.alert("Please Insert Couse Code");
                    return false;
                }
            }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Disable_block_user",
                    data: "{user_id:'" + row.id + "',sem_code:'" + $('#drpsemester').val() + "',year_code:'" + $('#drpyear').val() + "',block_type:'" + $('#drptype').val() + "',course_code:'" + course_code + "',remark:'" + $('#' + row.id).val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Disable Successfully");
                                enable_disable_data();
                            }
                            else {
                                bootbox.alert('Problem in Data');
                            }
                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Block Information
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
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
                        <td>Year Allocation :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear_alo" />
                        </td>
                    </tr>
                    <tr>
                        <td>Block Type :
                        </td>
                        <td>
                            <select class="chosen-select" id="drptype" />
                        </td>
                        <td>Type :
                        </td>
                        <td>
                            <select class="chosen-select" id="repdrptype" />
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

        <div id="DataList" class="panel panel-default" style="display: none; margin-bottom: 40px;">
            <div class="panel-heading">
                <strong id="panel_head">Block Information</strong>
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

