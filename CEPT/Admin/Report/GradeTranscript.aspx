<%@ Page Title="GradeTranscript" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="GradeTranscript.aspx.cs" Inherits="Admin_Report_GradeTranscript" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=28082019" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {

            bootbox.alert("Please ensure that you have submitted the latest Grade Range from \"Course Wise Grade Range\".");
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            // bindprogrammedata();
            bindproglevel();
            bindprogramme();
            bindEnrollmentyeardata();
            get_fauser_detail();
            $("#hdn_check").val("false");
            $('input[type="checkbox"]').click(function(){
            if($(this).prop("checked") == true){
                //alert("Checkbox is checked.");
                $("#hdn_check").val("true");
            }
            else if($(this).prop("checked") == false){
                //alert("Checkbox is unchecked.");
                $("#hdn_check").val("false");
            }
        });

            $('#btnreterive').on('click', function () {
                retrieve_Student_Data();
                return false;
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Provisional Transcript
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
                <div style="float:right;">
                <input type="checkbox" name="vehicle" style="margin-bottom:5px;"><b> Old Version</b>
                    </div>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    First Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    First Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td class="cls_dept_prog">
                                    Department :
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Programme :
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
                                    Enrollment Year
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpenrollmentyear">
                                    </select>
                                </td>
                            </tr>
                            <tr style="text-align: center;">
                                <td colspan="6">
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                               <%-- <td style="float: right;">
                                   <input type="checkbox" name="vehicle">Old Version 
                                </td>--%>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_stud_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Student List</strong> <span style="float: right;">
                    <%--<asp:Button ID="btn_download_all" class="btn btn-primary" runat="server" Text="Download All" OnClick="Button1_Click" style="height: 40px;margin-top: -10px;"/>--%>
                </span>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none;">
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
    <div id="ifrm_outline" style="display:none;"></div>
    <input type="hidden" id="hdn_filter" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_check" runat="server" clientidmode="Static" />
    <div style="display: none;">
        <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="Download_Student_Grade_Report" />
    </div>
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var prog_level_code = '';
        var asInitVals = new Array();

        function get_fauser_detail() {
            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_department_wise_user_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);
                            $('#drpdepartment').val(user_data[0]['dept_code']);
                            //$('#drpprog').val(user_data[0]['prog_code']);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }

        function retrieve_Student_Data() {
            $('#DataList').css('display', 'none');

            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            dept_code = $('#drpdepartment').val();
            if (dept_code == "") {
                bootbox.alert('Please select Department');
                $('#drpdepartment').focus();
                return false;
            }

            prog_code = $('#drpprog').val();
            if (prog_code == "") {
                bootbox.alert('Please select Programme');
                $('#drpprog').focus();
                return false;
            }

            prog_level_code = $('#drpproglevel').val();
            year_of_enrollment = $('#drpenrollmentyear').val();

            var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code, prog: prog_code };
            $('#hdn_filter').val(JSON.stringify(filter_criteria));

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_transcript_student_data",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code:'" + prog_level_code + "',year_of_enrollment:'" + year_of_enrollment + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {
                        display_Student_Data(data.d);
                        $('#div_stud_list').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester or Year');
                        $('#div_stud_list').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
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
                //"sScrollY": '400px',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_name", "bSortable": false },
                //{ "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
                //{ "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },
                //{ "sTitle": "Course Credits", "mData": "course_credits", "bSortable": false }
                    {
                        "sTitle": "View", "mData": null, "bSortable": false, "mRender": function (course_code)
                        {
                            return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                        }
                     },
                    {"sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) {
                        //alert(course_code);
                        return '<center><button type="button" onclick="rowClick(this)">Download</button></center>';
                    }
                },
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
            for (var i = 0; i < 4; i++) {
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
        }

        function rowClick(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

            var filter_criteria =
            {
                sem_code: semester, year: year_code, dept: dept_code, prog: prog_code, student_code: rowId
            };
            $('#hdn_filter').val(JSON.stringify(filter_criteria));

            $('#hdn_download').click();
        }


        function rowClick_view(row) {
            debugger;
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

            var filter_criteria =
            {
                sem_code: semester, year: year_code, dept: dept_code, prog: prog_code, student_code: rowId
            };
            
            var status = $('#hdn_check').val();
            if (status == 'true') {
                if (prog_code == '1') {
                    $('#ifrm_outline').html('<iframe src="' + location.origin + '/Admin/Report/GradeTranscriptPDF_UG_10sem.aspx?uid=' + rowId + '&sem=' + semester + '&year=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
                }
                else {
                    $('#ifrm_outline').html('<iframe src="' + location.origin + '/Admin/Report/GradeTranscriptPDF_PG.aspx?uid=' + rowId + '&sem=' + semester + '&year=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
                }
            }
            else {
                $('#ifrm_outline').html('<iframe src="' + location.origin + '/Admin/Report/ProvisionalTranscript.aspx?uid=' + rowId + '&sem=' + semester + '&year=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
            }
        }

        //$('#ifrm_outline').html('<iframe src="' + location.origin + '/Admin/Report/New_GradeTranscriptPDF_UG_10sem.aspx?uid=' + rowId + '&sem=' + semester + '&year=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
        // $('#ifrm_outline').html('<iframe src="' + location.origin + '/Admin/Report/ProvisionalTranscript.aspx?uid=' + rowId + '&sem=' + semester + '&year=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
    </script>
</asp:Content>
