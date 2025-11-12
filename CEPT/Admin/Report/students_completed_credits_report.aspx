<%@ Page Title="Students Completed Credits" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="students_completed_credits_report.aspx.cs" Inherits="Admin_Report_students_completed_credits_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script>
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
            get_fauser_detail();
            bindprogramme();
            bindproglevel();
            bindEnrollmentyeardata();

            $('#btnreterive').on('click', function () {
                retrieve_Data();
                return false;
            });
        });

        function get_fauser_detail() {

            var url_dept = "";

            if ($('#hdnusertype').val() == 'FA') {
                url_dept = "../../WebService.asmx/Get_cur_FA_department_wise_data";
            }
            if ($('#hdnusertype').val() == 'PC') {
                url_dept = "../../WebService.asmx/Get_cur_prog_coord_dtl_department_wise_data";
            }
            if ($('#hdnusertype').val() != 'FA' && $('#hdnusertype').val() != 'PC') {
                url_dept = "../../WebService.asmx/Get_department_data";
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dept,
                    async: false,
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

        function bindprogramme() {
            if ($('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'PC') {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_FA_and_PC_program_dtl",
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

        function bindproglevel() {

            var url_prog_level = "../../WebService.asmx/Get_program_level_data_rights_wise";

            if ($('#hdnusertype').val() != 'FA' && $('#hdnusertype').val() != 'PC') {
                url_prog_level = "../../WebService.asmx/Get_program_level_data";
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: url_prog_level,
                async: false,
                data: "{}",
                dataType: "json",
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

        function bindEnrollmentyeardata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {

                        var year_data = JSON.parse(data.d);

                        $('#drpenrollmentyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpenrollmentyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpenrollmentyear').chosen();
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function retrieve_Data() {

            $('#DataList').css('display', 'none');

            var dept_code = $('#drpdepartment').val();
            //if (dept_code == "") {
            //    bootbox.alert('Please select Department');
            //    $('#drpdepartment').focus();
            //    return false;
            //}

            var prog_code = $('#drpprog').val();
            //if (prog_code == "") {
            //    bootbox.alert('Please select Programme');
            //    $('#drpprog').focus();
            //    return false;
            //}

            var prog_level_code = $('#drpproglevel').val();
            //if (prog_level_code == "") {
            //    bootbox.alert('Please select Programme Level');
            //    $('#drpproglevel').focus();
            //    return false;
            //}

            var ReportType = $('#drpreporttype').val();
           if (ReportType == "") {
               bootbox.alert('Please select Report Type');
               $('#drpreporttype').focus();
               return false;
           }

            var enroll_year_flag = false;

            var enrollment_year = $('#drpenrollmentyear').val();
            if (enrollment_year == "") {

            } else {
                enroll_year_flag = true;
            }

            if (!enroll_year_flag) {
                var semester = $('#drpsemester').val();
                if (semester == "") {
                    bootbox.alert('Please select Semester and Year OR only Enrollment Year');
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    bootbox.alert('Please select Semester and Year OR only Enrollment Year');
                    $('#drpyear').focus();
                    return false;
                }
                enrollment_year = "";
            }

            if (enroll_year_flag) {
                $('#drpsemester').val('');
                $('#drpyear').val('');
                $("#drpsemester").trigger("liszt:updated");
                $("#drpyear").trigger("liszt:updated");
                semester = "";
                year_code = "";
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_students_completed_credits_report_data",
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "', dept_code : '" + dept_code + "', prog_code : '" + prog_code + "', prog_level_code : '" + prog_level_code + "', enrollment_year : '" + enrollment_year + "', ReportType : '" + ReportType + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            display_Student_Data(data.d);
                            $('#div_data_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester or Year');
                            $('#div_data_list').css('display', 'none');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function display_Student_Data(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]

                //        }
                //    ]
                //},

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program Level", "mData": "prog_level_code1", "bSortable": false },

                    {
                        "sTitle": "Total Credits Passed", "mData": null, "bSortable": false, "mRender": function (datad)
                        {
                            var total_credits = 0;
                            if (datad.M_Passed != "")
                            {
                                total_credits += parseInt(datad.M_Passed);
                            }
                            if (datad.E_Passed != "")
                            {
                                total_credits += parseInt(datad.E_Passed);
                            }
                            if (datad.ws_M_Passed != "")
                            {
                                total_credits += parseInt(datad.ws_M_Passed);
                            }
                            if (datad.ws_E_Passed != "")
                            {
                                total_credits += parseInt(datad.ws_E_Passed);
                            }
                            return total_credits;

                        }
                    },
                    {
                        "sTitle": "Total Credits Allocated", "mData": null, "bSortable": false, "mRender": function (datad) {
                            var total_credits_allocated = 0;
                            if (datad.mandatory_allocated != "") {
                                total_credits_allocated += parseInt(datad.mandatory_allocated);
                            }
                            if (datad.elective_allocated != "") {
                                total_credits_allocated += parseInt(datad.elective_allocated);
                            }
                            if (datad.sws_mandatory_allocated != "") {
                                total_credits_allocated += parseInt(datad.sws_mandatory_allocated);
                            }
                            if (datad.sws_elective_allocated != "") {
                                total_credits_allocated += parseInt(datad.sws_elective_allocated);
                            }
                            return total_credits_allocated;
                        }
                    },
                    { "sTitle": "Mandatory Credit Allocated", "mData": "mandatory_allocated", "bSortable": false },
                    { "sTitle": "Elective Credit Allocated", "mData": "elective_allocated", "bSortable": false },

                    { "sTitle": "Mandatory Credit Passed", "mData": "M_Passed", "bSortable": false },
                    { "sTitle": "Elective Credit Passed", "mData": "E_Passed", "bSortable": false },
                    { "sTitle": "Mandatory Credit Failed", "mData": "M_Failed", "bSortable": false },
                    { "sTitle": "Elective Credit Failed", "mData": "E_Failed", "bSortable": false },

                    //{ "sTitle": "SWS Allocated credits", "mData": "sws_allocated", "bSortable": false }, /// Retured By Ananth///
                    { "sTitle": "SWS Mandatory Credit Allocated", "mData": "sws_mandatory_allocated", "bSortable": false }, /// Retured By Mayur///
                    { "sTitle": "SWS Elective Credit Allocated", "mData": "sws_elective_allocated", "bSortable": false }, /// Retured By Mayur///

                    { "sTitle": "SWS Mandatory Credit Passed", "mData": "ws_M_Passed", "bSortable": false }, /// Retured By Mayur///
                    { "sTitle": "SWS Elective Credit Passed", "mData": "ws_E_Passed", "bSortable": false }, /// Retured By Mayur///
                    { "sTitle": "SWS Mandatory Credit Failed", "mData": "ws_M_Failed", "bSortable": false }, /// Retured By Mayur///
                    { "sTitle": "SWS Elective Credit Failed", "mData": "ws_E_Failed", "bSortable": false } /// Retured By Mayur///

                    //{ "sTitle": "SWS Credit Passed", "mData": "ws_M_Passed", "bSortable": false },
                    //{ "sTitle": "SWS Credit Passed", "mData": "ws_E_Passed", "bSortable": false },
                    //{"sTitle": "SWS Credit Passed", "mData": "ws_M_Passed", "bSortable": false, "fnRender": function (data) {
                    //    var ws_passed = 0;
                    //    if (data.aData.ws_M_Passed != '') ws_passed += parseFloat(data.aData.ws_M_Passed);
                    //    if (data.aData.ws_E_Passed != '') ws_passed += parseFloat(data.aData.ws_E_Passed);
                    //    return ws_passed;
                    //}
                    //}
                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Download)
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

            $('#example_wrapper').css('overflow', 'auto');

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; Students Completed Credits
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">

            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td class="cls_dept_prog">Department
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>

                                <td>Report Type
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpreporttype">
                                        <option value="OLD">Old Report</option>
                                        <option value="NEW">New Report</option>
                                    </select>
                                </td>

                            </tr>
                            <tr>
                                <td colspan="6"><b>OR</b>
                                    <br />
                                    Note: If <span style="color: red;">Enrollment Year</span> is selected then Report gets Completed Credits of whole Academic Year for selected Enrollment Year.</td>
                            </tr>
                            <tr>
                                <td>Enrollment Year
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpenrollmentyear">
                                    </select>
                                </td>
                                <%-- <td>
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>--%>
                            </tr>
                            <tr style="text-align: center;">
                                <td colspan="6">
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>

        <div id="div_data_list" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong>Data List</strong>
                <span style="float: right;">
                    <%--<asp:Button ID="btn_download_all" class="btn btn-primary" runat="server" Text="Download All" OnClick="Button1_Click" style="height: 40px;margin-top: -10px;"/>--%>
                </span>
            </div>

            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
    <input type="hidden" id="hdnusertype" runat="server" clientidmode="Static" />
</asp:Content>

