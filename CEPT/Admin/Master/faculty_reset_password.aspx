<%@ Page Title="Student List" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="faculty_reset_password.aspx.cs" Inherits="Admin_Master_faculty_reset_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {

            bindyeardata();
            bindType();
            //Display_data_dtl();
            $('#btnreterive').on('click', function () {
                $('#DataList').css('display', 'none');
                Display_data_dtl();
                return false;
            });
            
            return false;
        });

        function Display_data_dtl() {
            $('#DataList').css('display', 'none');
            var year_allocation = '';
            year_allocation = $('#drpyear_alo').val();
            //if (year_allocation == "") {
            //    bootbox.alert('Please select Year Allocation')
            //    $('#drpyear_alo').focus();
            //    return false;
            //}
            var type = $('#drptype').val();

            if (type == "") {
                bootbox.alert('Please select Type')
                $('#drptype').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Student_List_year_wise",
                data: "{year_code: '" + year_allocation + "',type:'"+type+"'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Display_block_report(data.d);
                    }
                    else {
                        bootbox.alert('There is No data Found');
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
                    { "sTitle": "Faculty Id", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Faculty Name", "mData": "name", "bSortable": false },
                    { "sTitle": "Email Id", "mData": "mail", "bSortable": false },
                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {

                            return '<center><button type="button" id=' + data.user_id + ' onclick="rowClick_reset_password(this)">Reset Password</button></center>';

                        }
                    }
                ]
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function bindType() {
            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("F").html("Faculty"));
            $('#drptype').append($("<option></option>").val("S").html("Student"));
            

            $('#drptype').chosen();
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

        

        function rowClick_reset_password(row) {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Resset_Passwod",
                    data: "{student_id:'" + row.id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Reset Password Successfully and Your Password is : admin1");
                                Display_data_dtl();
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
                <i class="icon-desktop"></i>&nbsp;Reset Password
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
                        <td>Type :
                        </td>
                        <td>
                            <select class="chosen-select" id="drptype" onchange="change_year()" />
                        </td>
                        <td id="year">Year :
                        </td>
                        <td id="year_a">
                            <select class="chosen-select" id="drpyear_alo" />
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
                <strong id="panel_head">Reset Password</strong>
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

