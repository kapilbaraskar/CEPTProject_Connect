<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="New_semester_pc_entry.aspx.cs" Inherits="Admin_Master_New_semester_pc_entry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=24062021" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
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

            $('#btnreterive').on('click', function () {
                $('#DataList').css('display', 'none');
                Display_data_dtl();
                return false;
            });
            $('#btncopypast').on('click', function () {
                var check_table = oTable;
                if (check_table != undefined) {
                    //var data = oTable.fnGetData();
                    copy_paste();
                }
                else {
                    bootbox.alert('Please Reterview Previous Semester Data');
                    return false;

                }
                return false;
            });

            $('#btnadd').on('click', function () {
                var check_table = oTable;
                if (check_table != undefined) {
                    //var data = oTable.fnGetData();

                    manully_add();
                    return false;


                }
                else {
                    bootbox.alert('Please Reterview Previous Semester Data');
                    return false;

                }
                return false;
            });




            $('#checkbox1').change(function () {
                if (this.checked) {
                    var returnVal = true;
                    $(this).prop("checked", returnVal);
                    $('#new_sem').css('display', 'block');
                    bindsemdatas();
                    bindyeardata_new_sem();
                }
                else {
                    $(this).prop("checked", false);
                    $('#new_sem').css('display', 'none');
                }

            });

            $('#checkbox2').change(function () {
                if (this.checked) {
                    var returnVal = true;
                    $(this).prop("checked", returnVal);
                    $('#manully').css('display', 'block');
                    bindsemdatas_man();
                    bindyeardata_new_sem_man();
                    binduserdata();
                    binddepartment();
                    bindprogrammedata();
                    bindproglevel();
                }
                else {
                    $(this).prop("checked", false);
                    $('#manully').css('display', 'none');
                }

            });


            function bindsemdatas() {
                $('#drpsemesters').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                $('#drpsemesters').append($("<option></option>").val("M").html("Monsoon"));
                $('#drpsemesters').append($("<option></option>").val("S").html("Spring"));


                $('#drpsemesters').chosen();
            }
            function bindsemdatas_man() {
                $('#drpsemesters_man').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                $('#drpsemesters_man').append($("<option></option>").val("M").html("Monsoon"));
                $('#drpsemesters_man').append($("<option></option>").val("S").html("Spring"));


                $('#drpsemesters_man').chosen();
            }
            function bindyeardata_new_sem() {
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

                            $('#drpyears').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                            for (var i = 0; i < year_data.length; i++) {
                                $('#drpyears').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                            }
                            $('#drpyears').chosen();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function bindyeardata_new_sem_man() {
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

                            $('#drpyears_man').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                            for (var i = 0; i < year_data.length; i++) {
                                $('#drpyears_man').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                            }
                            $('#drpyears_man').chosen();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            return false;
        });


        function copy_paste() {

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

            var new_sem_code = $('#drpsemesters').val();
            if (new_sem_code == "") {
                bootbox.alert('Please select Semester')
                $('#drpsemesters').focus();
                return false;
            }
            var new_year_code = $('#drpyears').val();

            if (new_year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyears').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/previous_semester_data_pc",
                async: false,
                data: "{sem_code: '" + sem_code + "',year_code:'" + year_code + "',new_sem_code:'" + new_sem_code + "',new_year_code:'" + new_year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

                        bootbox.alert(data.d);
                        return false;

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function Display_data_dtl() {
            $('#DataList').css('display', 'none');

            var sem_code = $('#drpsemester').val();
            if (sem_code == "") {
                bootbox.alert('Please select Semester')
                $('#drpsemester').focus();
                return false;
            }
            var year = $('#drpyear').val();

            if (year == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/semester_wise_pc_details",
                data: "{sem_code: '" + sem_code + "',year_code:'" + year + "'}",
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
                    { "sTitle": "Doc No", "mData": "doc_no", "bSortable": false },
                    { "sTitle": "Faculty Id", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Faculty Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Department Code", "mData": "dept_code", "bSortable": false },
                    { "sTitle": "Program Code", "mData": "prog_code", "bSortable": false },
                    { "sTitle": "Program level Code", "mData": "prog_level_code", "bSortable": false },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program Name", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "Program level Desc", "mData": "prog_level_desc", "bSortable": false },
                    { "sTitle": "Letter Label", "mData": "letter_label", "bSortable": false },
                    { "sTitle": "Semester", "mData": "semester_type", "bSortable": false },
                    { "sTitle": "Year", "mData": "year_semester", "bSortable": false },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.cancel_flag == "Y") {
                                return '<center>Disable</center>';
                            }
                            else { return '<center>Enable</center>' }


                        }
                    },
                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.cancel_flag == "Y") {
                                var status = 'N';
                                return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_click(this, \'' + status + '\')">Enable</button></center>';
                            }
                            else {
                                var status = 'Y';
                                return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_click(this, \'' + status + '\')">Disable</button></center>'
                            }


                        }
                    }
                ]
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function rowClick_click(row, status) {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Enable_Disable_pc",
                    data: "{doc_no:'" + row.id + "',sem_code:'" + $('#drpsemester').val() + "',year_code:'" + $('#drpyear').val() + "',flag:'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            bootbox.alert(data.d);
                            Display_data_dtl();
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


        function binduserdata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Non_student_details",
                data: "{}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {
                        var user_data = JSON.parse(data.d);
                        $('#drpuser').empty().append($("<option></option>").val("").html("-- Please Select User --"));
                        for (var i = 0; i < user_data.length; i++) {
                            $('#drpuser').append($("<option></option>").val(user_data[i]["user_id"]).html(user_data[i]["user_id"] + '-' + user_data[i]["full_name"]));
                        }
                        $('#drpuser').chosen();

                    }



                },
                error: function (result) {
                    alert(result);
                }
            });

        }



        function manully_add() {

            var sem_code = $('#drpsemesters_man').val();
            if (sem_code == "") {
                bootbox.alert('Please select Semester')
                $('#drpsemesters_man').focus();
                return false;
            }
            var year_code = $('#drpyears_man').val();

            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyears_man').focus();
                return false;
            }

            var dept_code = $('#drpdepartment').val();
            if (dept_code == "") {
                bootbox.alert('Please select Department')
                $('#drpdepartment').focus();
                return false;
            }
            var prog_code = $('#drpprog').val();

            if (prog_code == "") {
                bootbox.alert('Please select Program')
                $('#drpprog').focus();
                return false;
            }

            var inst_id = $('#drpuser').val();

            if (inst_id == "") {
                bootbox.alert('Please select User Id')
                $('#drpuser').focus();
                return false;
            }
            var prog_level_code = $('#drpproglevel').val();

            //String user_id,String inst_id, String dept_code, String prog_code, String prog_level_code,String sem_code, String year_code


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/insert_data_in_pc",
                async: false,
                data: "{inst_id: '" + inst_id + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',sem_code:'" + sem_code + "',year_code:'" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

                        bootbox.alert(data.d);
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
                <i class="icon-desktop"></i>&nbsp;Semester Wise PC Details 
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
                            <select class="chosen-select" id="drpsemester" />
                        </td>
                        <td>Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                        <td>
                            <input type="checkbox" id="checkbox1" style="margin-bottom: 6px;" /><span id="check"><b> New Semester Entry</b></span></td>
                        <td>
                            <input type="checkbox" id="checkbox2" style="margin-bottom: 6px;" /><span id="check"><b> Manual Entry</b></span></td>
                    </tr>

                </table>
            </div>

            <div id="manully" style="display: none;">

                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td><b>
                            <ul>Add Manully PC</ul>
                        </b></td>
                    </tr>
                    <tr>
                        <td>Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemesters_man" />
                        </td>
                        <td>Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyears_man" />
                        </td>

                        <td>Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                    </tr>
                    <tr>
                        <td>Program :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog" />
                        </td>
                        <td>Program Level :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpproglevel" />
                        </td>
                        <td>User id :</td>
                        <td>
                            <select class="chosen-select" id="drpuser" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnadd">
                                Add
                            </button>
                        </td>
                    </tr>

                </table>

            </div>


            <div id="new_sem" style="display: none;">

                <table border="0" cellpadding="10" cellspacing="5">

                    <tr>
                        <td><b>
                            <ul>Copy And Paste</ul>
                        </b></td>
                    </tr>
                    <tr>
                        <td>Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemesters" />
                        </td>
                        <td>Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyears" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btncopypast">
                                Copy and Past
                            </button>
                        </td>
                    </tr>

                </table>

            </div>
        </div>

        <div id="DataList" class="panel panel-default" style="display: none; margin-bottom: 40px;">
            <div class="panel-heading">
                <strong id="panel_head">Semester Wise PC Details</strong>
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

