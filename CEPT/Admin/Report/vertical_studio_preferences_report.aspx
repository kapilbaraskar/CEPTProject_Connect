<%@ Page Title="Vertical Studio Preferences Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="vertical_studio_preferences_report.aspx.cs" Inherits="Admin_Report_vertical_studio_preferences_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var course_code = '';
        var oTable;
        var course_name = '';
        var dep_name = '';
        var prg_name = '';
        var asInitVals = new Array();
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            binddepartment();
            bindprogrammedata();
            bindleveldata();
            // bind_instructor_course();
            $('#btnreterive').on('click', function () {
               
                get_details_data();
                return false;
            });

            $("#drpyear").change(function ()
            {
                $('#drpcode').find('option').remove().end().append('<option value="">No Course found</option>').val('');
                $('#drpcode').chosen();
                $('#drpcode').val('').trigger("liszt:updated");
                bind_course();
            });

            $("#drpsemester").change(function () {

                $('#drpcode').find('option').remove().end().append('<option value="">No Course found</option>').val('');
                $('#drpcode').chosen();
                $('#drpcode').val('').trigger("liszt:updated");
                $('#drpyear').val('').trigger("liszt:updated");
                $('#drplevel').val('').trigger("liszt:updated");
                
            });
            $("#drpdepartment").change(function () {

                $('#drpcode').find('option').remove().end().append('<option value="">No Course found</option>').val('');
                $('#drpcode').chosen();
                $('#drpcode').val('').trigger("liszt:updated");
                bind_course();
                //bind_instructor_course_dtl();
            });

            $("#drplevel").change(function () {

                bind_course();
               
            });

            $("#drpprog").change(function () {

                $('#drpcode').find('option').remove().end().append('<option value="">No Course found</option>').val('');
                $('#drpcode').chosen();
                $('#drpcode').val('').trigger("liszt:updated");
                bind_course();
                //bind_instructor_course_dtl();
            });
        });

        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function bindleveldata() {
            $('#drplevel').empty().append($("<option></option>").val("").html("-- Please Select level --"));

            $('#drplevel').append($("<option></option>").val("L2").html("L2"));
            $('#drplevel').append($("<option></option>").val("L3").html("L3"));
            $('#drplevel').append($("<option></option>").val("L4").html("L4"));

            $('#drplevel').chosen();
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
        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();

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

        function get_details_data() {
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
            } //drpcode
            course_name = $("#drpcode option:selected").text();
            course_code = $('#drpcode').val();
            if (hdn_user_type == 'I2') {
                if (course_code == "") {
                    bootbox.alert('Please select Course');
                    $('#drpcode').focus();
                    return false;
                }
            }
            dep_name = $('#drpdepartment').val();
            prg_name = $('#drpprog').val();
            var sub_category_id = $('#drplevel').val();
           
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_semester_wise_preference_report",
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:'" + course_code + "',dep_name:'" + dep_name + "',prg_name:'" + prg_name + "',sub_category_id:'" + sub_category_id +"'}",
                    dataType: "json",
                    success: function (data) {
                        debugger
                        if (data.d != "" && data.d != "[]") {
                            semester_wise_list(data.d);
                          


                            $('#div_preference_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            $('#div_preference_list').css('display', 'none');


                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }


        function semester_wise_list(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "aaData": JSON.parse(data),
                //"columnDefs": [
                //    {
                //        "targets": [1, 2],
                //        "visible": false,
                //        "searchable": false
                //    }
                //],
                buttons: [
                    {
                        extend: 'csv',
                        footer: false,
                        exportOptions: {
                            columns: [1, 2,3,5,6,7,8,9,10]
                        }

                    }
                ],
                "columnDefs": [
                    {
                        "targets": [1],
                        "visible": false,
                        "searchable": false
                    }
                ],

                "aoColumns": [

                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Code - Name", "mData": "course_name_code", "bSortable": false },
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Short List", "mData": "shortlist_student_status", "bSortable": false },
                    { "sTitle": "Allocation Status", "mData": "status", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Email Id", "mData": "mail", "bSortable": false },
                    { "sTitle": "Mobile No", "mData": "mobile_no", "bSortable": false },
                    //{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    //{ "sTitle": "Unit", "mData": "sub_category_id", "bSortable": false  },
                    //{ "sTitle": "Course Type", "mData": "course_type", "bSortable": false  },
                    //{ "sTitle": "GPA/NGPA", "mData": "gpa_nongpa", "bSortable": false  },
                    { "sTitle": "Remark", "mData": "remarks", "bSortable": false }

                ]
            }).rowGrouping();


            //var thead = $('<tr class="dt"></tr>');
            //$('#example thead th').each(function (i, r) {
            //    var nm = $('#example thead th').eq($(this).index()).text();
            //    thead.append('<th></th>');
            //});
            //$('#example thead').append(thead);
            //
            ////adding input box in thead second row 
            //for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
            //    var title = $('#example thead th').eq(i).text();
            //    $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            //};
            //
            //$("thead input").keyup(function () {
            //    /* Filter on the column (the index) of this element */
            //    oTable.fnFilter(this.value, $("thead input").index(this));
            //});
            //
            //$("thead input").each(function (i) {
            //    asInitVals[i] = this.value;
            //});
            //
            //$("thead input").focus(function () {
            //    if (this.className == "search_init") {
            //        this.className = "";
            //        this.value = "";
            //    }
            //});
            //
            //$("thead input").blur(function (i) {
            //    if (this.value == "") {
            //        this.className = "search_init";
            //        this.value = asInitVals[$("thead input").index(this)];
            //    }
            //});


            $('#DataList').css('display', 'block');
            //$("#example tbody tr").each(function (i) {
            //    var temp_tr = $('#example tbody tr:nth-child(' + (i + 1) + ')');
            //    $('td.group.' + temp_tr[0].textContent.toLowerCase()).css('font-weight', 'bold');
            //    $('td.group.' + (i + 1)).text('Students with Priority ' + (i + 1));
            //    $('td.group.' + (i + 1)).css('font-weight', 'bold');
            //});

            //var html_data = $('#DataList tbody')[0];
            //var new_row = '';
            //if (course_code != '') {
            //    new_row = '<tr colspan=7><td style="color:blue;font-weight:bold;">' + course_code + '</td></tr>';
            //}
            //else {
            //    new_row = '<tr colspan=7><td style="color:blue;font-weight:bold;"></td></tr>';
            //}
            //
            //
            //html_data = new_row + html_data.innerHTML;
            //html_data =  html_data.innerHTML;
            //$('#DataList tbody').html(html_data);
        }


        function bind_course() {
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
            dep_name = $('#drpdepartment').val();
            prg_name = $('#drpprog').val();
            course_code = '';
            var sub_category_id = $('#drplevel').val();
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_semester_wise_vertical_studio_course_for_instructor",
                async: true,
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dep_name:'" + dep_name + "',prg_name:'" + prg_name + "',sub_category_id:'" + sub_category_id +"'}",

                dataType: "json",
                success: function (data) {
                    
                    if (data.d != "") {

                        var course_code = JSON.parse(data.d)

                        $('#drpcode').empty().append($("<option></option>").val("").html("-- Please Select Course Code --"));
                        for (var i = 0; i < course_code.length; i++) {
                            $('#drpcode').append($("<option></option>").val(course_code[i]["course_code"]).html(course_code[i]["course_code"] + ' - ' + course_code[i]["course_name"]));
                        }
                        $('#drpcode').chosen();
                        $('#drpcode').trigger("liszt:updated");
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
                <i class="icon-desktop"></i>&nbsp; Vertical Studio Preferences Report
            </h1>
        </div>

        <div>
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
                            <td>Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drplevel" />
                            </td>


                            <td>Course :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpcode">
                                </select>
                            </td>
                            
                        </tr>
                        <tr><td>
                                <button class="btn btn-primary" id="btnreterive">
                                    Retrieve
                                </button>
                            </td></tr>
                    </table>

                </div>
            </div>
        </div>

        <div id="div_preference_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Vertical Studio Preferences Report</strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow:auto;">
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
    <input type="hidden" id="hdn_user_type" runat="server" clientidmode="Static" />
</asp:Content>

