<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="course_status_report.aspx.cs" Inherits="Admin_Report_course_status_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var cur_sem;
        var cur_year;
        var prog_code;
        var prog_level_code;
        var dept_code;
        var oTable;

        $(document).ready(function () {
            bindprogrammedata();
            bindyeardata_for_cross_reg();
            bindproglevel();
            bind_program_level_code();
            binddepartment();
            $('#drpdepartment').on('change', function () {
                bind_program_level_code();
            });

            $('#drpprog').on('change', function () {
                bind_program_level_code();
            });
            $('#btnreterive').on('click', function () {
                if ($('#drpyear').val() == "")
                {
                    bootbox.alert('please select year.');
                    return false;
                }
                cur_sem = $('#drpsem').val()
                cur_year = $('#drpyear').val();
                prog_code = $('#drpprog').val();
                prog_level_code = $('#drpproglevel').val();
                dept_code = $('#drpdepartment').val();
                get_course_status_dtl();
                return false;
            });
        });
        function bind_program_level_code() {
            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();

            if (dept_code == '' && prog_code == '') {

                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_programme_level_dept_wise",
                data: "{dept_code : '" + dept_code + "',prog_code:'" + prog_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Program level Code course --"));

                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(year_data[i]["prog_level_code"]).html(year_data[i]["prog_level_desc"]));
                        }

                        $('#drpproglevel').chosen();
                        $('#drpproglevel').trigger("liszt:updated");
                    }
                    else {
                        $('#drpproglevel')
                            .find('option')
                            .remove()
                            .end()
                            .append('<option value="">No Program level found</option>')
                            .val('');
                        $('#drpproglevel').chosen();

                        $('#drpproglevel').val('').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function binddepartment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                async: false,
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
        function bindproglevel() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }
                        $('#drpproglevel').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bindprogrammedata() {

            if ($('#hdn_utype').val() == 'FA') {
                $('.cls_dept_prog').css('display', 'none');

                $.ajax({
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

            else if ($('#hdn_utype').val() == 'PC') {
                $.ajax({
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

                if ($("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA')
                {
                    $('#drpprog').chosen();
                }
            }
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

        function get_course_status_dtl() {
            $('#div_studio_list').css('display', 'block');
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_course_status",
                    data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {

                            display_course_detail(data.d);

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Course Code", "mData": "course_code", "sClass": "cls_hide" });
            columns.push({ "sTitle": "Course Name", "mData": "title", "sClass": "cls_hide" });
            columns.push({ "sTitle": "Course Type", "mData": "course_type", "sClass": "cls_hide" });
            columns.push({ "sTitle": "Faculty", "mData": "faculty", "sClass": "cls_hide" });
            columns.push({ "sTitle": "Semester", "mData": "semester", "sClass": "cls_hide" });
            columns.push({ "sTitle": "Faculty Approval Status", "mData": "faculty_approval", "sClass": "cls_hide" });
            columns.push({ "sTitle": "Program Coordinator Approval Status", "mData": "progcoord_approval", "sClass": "cls_hide" });
            columns.push({ "sTitle": "UGPG Approval Status", "mData": "ugpg_approval", "sClass": "cls_hide" });
    
            return columns;
        }

        function display_course_detail(data) {
            debugger;
            var columns = set_table_columns(JSON.parse(data)[0]);

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
    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 
   <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Course Status Details
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
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsem">
                            <option value="M">Monsoon</option>
                            <option value="S">Spring</option>
                        </select>
                                </td>
                                <td>
                                    Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                        </select>
                                </td>

                                <td>
                                    Faculty :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment">
                        </select>
                                </td>
                               
                                </tr>
                             <tr>
                                <td>
                                    Program :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                        </select>
                                </td>
                                <td>
                                     Program Level :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
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
        
        <div id="div_studio_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Course Status</strong>
            </div>
            <div>    
                <div id="DataList" style="display: none;overflow:auto">
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

       <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
</asp:Content>

