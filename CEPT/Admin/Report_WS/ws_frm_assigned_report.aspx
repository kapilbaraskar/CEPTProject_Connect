<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_frm_assigned_report.aspx.cs" Inherits="Admin_Report_WS_ws_frm_assigned_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=28082019" type="text/javascript"></script><%--08022019--%>

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
            bindsemdata_ws();
            binddepartment();
            bindproglevel();
            $('#btnreterive').on('click', function () {
                total_assigned_report_data_new();
                return false;
            });

            return false;
        });

        function bindsemdata_ws() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

            //for (var i = 0; i < sem_data.length; i++) {
            //    $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));
            //}

            $('#drpsemester').chosen();
        }
        function total_assigned_report_data_new() {
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
            var prog_level_code = $('#drpproglevel').val();
            //    if (dept_code == "") {
            //        bootbox.alert('Please select department')
            //        $('#drpdepartment').focus();
            //        return false;
            //    }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_assigned_report_data",
                data: "{dept_code: '" + dept_code + "',semester: '" + semester + "',year_code:'" + year_code + "',prog_level_code:'" + prog_level_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Display_Assigned_report(data.d);
                        //display_student_password_data(data.d);
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

        function Display_Assigned_report(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                //"sDom": 't',
                //"sScrollY": '600px',
                "scrollX": true,
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"oTableTools":
                //{
                //    "aButtons": [
                //		"copy",
                //		"print",
                //		{
                //		    "sExtends": "collection",
                //		    "sButtonText": 'Export',
                //		    "aButtons": ["xls"]
                //		}
                //    ]
                //},
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "code", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "name", "bSortable": false },

                    { "sTitle": "Student Mail", "mData": "mail", "bSortable": false },
                    { "sTitle": "Student Contact No", "mData": "applicant_mobile_no", "bSortable": false },

                    { "sTitle": "Student Level", "mData": "student_level", "bSortable": false },
                    //{ "sTitle": "Program Level", "mData": "prog_level_name", "bSortable": false },
                    { "sTitle": "Program Description", "mData": "prog_level_desc", "bSortable": false },
                    { "sTitle": "Student Faculty", "mData": "student_faculty", "bSortable": false },
                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                    { "sTitle": "Mandatory Course", "mData": "mandatory_course", "bSortable": false },
                    { "sTitle": "Mandatory Credits", "mData": "mandatory_credits", "bSortable": false },
                    { "sTitle": "Elective Course", "mData": "elective_course", "bSortable": false },
                    { "sTitle": "Elective Credits", "mData": "elective_credits", "bSortable": false }
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
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            $(window).trigger('resize');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;WS Assigned Report
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
                        <td>
                            Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>
                            Year of allocation :
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
                               Program Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
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
        
        <div id="DataList" class="panel panel-default" style="display:none;margin-bottom:40px;">
            <div class="panel-heading">
                <strong id="panel_head">WS Assigned Report</strong>
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

