<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="UserListForModification.aspx.cs" Inherits="Admin_Master_UserListForModification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../DesignCss/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>

    <script type="text/javascript" src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/printcsv.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <script type="text/javascript">
        var oTable;
        var asInitVals = new Array();        
        $(document).ready(function () {
            $("#header").css("display", "none");            
            binddepartment();
            bindyeardata();
            bindprogrammedata();
            bindproglevel();
            bindstudent();
            $('#btnreterive').on('click', function () {

                $('#DataList').css('display', 'none');

                var stud_code = $('#drp_student_code').val();
                var dept_code = "";
                var year_code = "";
                var prog_code = "";
                dept_code = $('#drpdepartment').val();
                year_code = $('#drpyear').val();
                prog_code = $('#drpprog').val();
                var prog_lvl_code = "";
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetStudentListForModification",
                    data: "{dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',year_code:'" + year_code + "',stud_code:'" + stud_code + "',prog_lvl_code:'" + prog_lvl_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            display_student_data(data.d);
                        } else {
                            alert("Student Details Not Found");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });


                return false;
            });
        });
        function Edit(studentCode, DeptCode, YearCode, ProgCode) {
            window.open('User_Modification.aspx?studentCode=' + btoa(studentCode) + '&DeptCode=' + btoa(DeptCode) + '&YearCode=' + btoa(YearCode) + '&ProgCode=' + btoa(ProgCode), '_blank');
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

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        $('#drp_year_semester').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                            $('#drp_year_semester').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();
                        $('#drp_year_semester').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function binddepartment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                aSync: false,
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
                        var prog_level_data = JSON.parse(data.d);

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

        function bindstudent() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_all_student_data_for_modification",
                async: false,
                data: "{'dept_code':'','prog_code':'','year_code':''}",
                dataType: "json",
                aSync: false,
                success: function (data) {
                    if (data.d != "") {
                        var stud_data = JSON.parse(data.d)

                        $('#drp_student_code').empty().append($("<option></option>").val("").html("-- Select Student Code --"));
                        for (var i = 0; i < stud_data.length; i++) {
                            $('#drp_student_code').append($("<option></option>").val(stud_data[i]["user_id"]).html(stud_data[i]["user_id"]));
                        }

                        $('#drp_student_code').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function display_student_data(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"  width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 30,                
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Mail", "mData": "mail", "bSortable": false },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Year", "mData": "Y_code", "bSortable": false },
                    { "sTitle": "Program Level", "mData": "prog_level_code", "bSortable": false },
                    { "sTitle": "Student Status", "mData": "user_status_flag", "bSortable": false },
                    { "sTitle": "Login Status", "mData": "status", "bSortable": false },
                    {
                        "sTitle": "Edit", "bSortable": false, "mData": null, mRender: function (data) {
                            return '<Input type="button" onclick="Edit(' + "'" + data["user_id"] + "'" + ',' + "'" + data["dept_code"] + "'" + ',' + "'" + data["year_code"] + "'" + ',' + "'" + data["prog_code"] + "'" + ')" value="Edit"/>';
                        }
                    }
                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {
                asInitVals[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });

            $('#DataList').css('display', 'block');
            $('#Student_Profile').css('display', 'none');
            $("#header").css("display", "block");
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
    </script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Student List
            </h1>
        </div>
        <div class="space">
        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div class="panel-body">
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>Department
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>Year of enrollment
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Programme
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                        <td>Program Level :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpproglevel" />
                        </td>
                    </tr>
                    <tr style="display: none;">
                        <td>Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester" />
                        </td>
                        <td>Year Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drp_year_semester">
                            </select>
                        </td>
                        <td>Modified On
                        </td>
                        <td>
                            <input type="text" id="txt_modified_on" class="marg-btm" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>OR</b>
                        </td>
                    </tr>
                    <tr>
                        <td>Student Code
                        </td>
                        <td>                            
                            <select class="chosen-select" id="drp_student_code" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="panel panel-default" id="header">
            <div class="panel-heading">
                <strong>Student Detail</strong>
            </div>

            <div style="display: none; width: 100%; overflow: auto;" class="row-fluid" id="DataList">
                <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                    border="0" id="example" width="100%">
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
