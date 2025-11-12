<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="StudentApaarId.aspx.cs" Inherits="Admin_Report_StudentApaarId" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Student ApaarId Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">

        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>

                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>Department
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                </tr>
                            <tr>
                                <td>
                            Year of allocation :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Student ApaarId Report</strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow: auto;">
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
    </div>


    <script type="text/javascript">
        var oTable;
        var course_detail;
        var rate_band;
        var workload_detail;
        var action = 'S';
        var inst_profile_pic = [];
        var inst_profile_name_ = [];


        $(document).ready(function () {
            bindprogramme();
            binddepartment();
            bindyeardata_for_cross_reg();
            //get_student_detail();
            $('#btnreterive').on('click', function () {
                get_student_detail();
                return false;
            });
        });





        function bindprogramme() {

            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                $('#drpprog').empty();

                                for (var i = 0; i < user_data.length; i++) {

                                    if (user_data[i]['prog_code'] == "1") {
                                        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "2") {
                                        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "3") {
                                        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                    }
                                }

                            }
                            else {
                                $('#drpprog').val('1');
                                $("#drpprog").attr('disabled', 'disabled');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if ($('#hdnusertype').val() == 'PC') {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_programme_coordinator_dtl",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                $('#drpprog').empty();

                                for (var i = 0; i < user_data.length; i++) {
                                    if (user_data[i]['prog_code'] == "1") {
                                        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "2") {
                                        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "3") {
                                        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                    }
                                }
                                //$('#drpprog').val(user_data[0]['prog_code']);
                            }
                            else {
                                $('#drpprog').val('1');
                                $("#drpprog").attr('disabled', 'disabled');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else {

                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

                if ($("#hdnusertype").val() != 'PC' && $("#hdnusertype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }
        function binddepartment()
        {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data)
                {
                    if (data.d != "")
                    {

                        var sem_data = JSON.parse(data.d)
                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                        for (var i = 0; i < sem_data.length; i++)
                        {
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

        var dept_options = [];


        var dept_code = '';
        var prog_code = '';

        function get_student_detail() {
            $('#DataList').css('display', 'none');

            dept_code = '';
            dept_code = $('#drpdepartment').val();
            prog_code = $('#drpprog').val();


            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetStudentApaarIdNew",
                    //async: false,
                    data: "{dept_code:'" + dept_code + "',prog_code: '" + prog_code + "',year_code: '" + $('#drpyear').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            display_get_vf_personal_detail(data.d);


                            $('#div_course_list').css('display', 'block');
                            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';

                        }
                        else {
                            bootbox.alert('No data Found For Selected Department and Program');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }


        function display_get_vf_personal_detail(data) {

            //var columns = set_table_columns(JSON.parse(data)[0]);

            var columns = [
                { "sTitle": "Studetn Code", "mData": "user_id" },
                { "sTitle": "Student Name", "mData": "full_name" },
                { "sTitle": "Mail Id", "mData": "mail" },
                { "sTitle": "University Code", "mData": "university_register_id" },
                { "sTitle": "Apaar ID", "mData": "apaar_id" }];


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
                "aoColumns": columns
            });

            $('#DataList').css('display', 'block');




        }


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











    </script>

</asp:Content>

