<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_Course_wise_avg_marks.aspx.cs" Inherits="Admin_Master_WS_Course_wise_avg_marks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;WS Course Wise Grade Range
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
                        <td>
                            <button class="btn btn-primary" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    
        <div id="div_course_list" class="panel panel-default" style="display:none;">
            <div class="panel-heading">
                <strong>Calculated Grade Range</strong>
                <span style="float:right;">
                    <input type="button" class="btn btn-primary" value="Submit Grade" onclick="Submit_grade_range()" style="height: 40px;margin-top: -10px;"/>
                </span>
            </div>

            <div>
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

    <script type="text/javascript">
        var oTable;
        var sem = '';
        var year = '';

        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                course_wise_avg_marks();
                return false;
            });

            setCurrentSemester();
        });

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_current_grade_semester",
                //async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            $('#btnreterive').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

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

        //function rowClick(row) {
        //    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
        //    window.location = "Student_wise_marks.aspx?c=" + rowId;
        //    //window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
        //}

        function Submit_grade_range() {
            var obj_grade_dtl = [];
            var selected_course = "";

            if ($("#example_filter :input").val() != '') {
                bootbox.alert("Please Remove Course Code in Search Box then Submit");
                return false;
            }

            var ALL_Course = false;

            if ($(".chk_selection_all_course_code").is(':checked')) {
                ALL_Course = true;
            }
            var ind_select = false;

            $('#example tbody tr').each(function (d)
            {
                if ($(this).find(".chk_selection_course_code").is(':checked'))
                {
                    ind_select = true;
                    if (d == 0) {
                        selected_course = $(this).find('td:nth-child(2)').html();
                    } else {
                        if (selected_course == "") {
                            selected_course = $(this).find('td:nth-child(2)').html();
                        } else {
                            selected_course += '#' + $(this).find('td:nth-child(2)').html();
                        }
                    }
                }

                obj_grade_dtl.push({ 'course_code': $(this).find('td:nth-child(2)').html(), 'grade_type': $(this).find('.cls_grade_type').val() });

            });

            if (ind_select || ALL_Course) {

            } else {
                bootbox.alert("Please select any Course Grade Range");
                return false;
            }
            //$('#example tbody tr').each(function (d)
            //{
            //    if ($(this).find(".chk_selection_course_code").is(':checked'))
            //    {
            //        //obj_grade_dtl.push({ 'course_code': $(this).find('td:first-child').html(), 'grade_type': $(this).find('.cls_grade_type').val() });
            //        obj_grade_dtl.push({ 'course_code': $(this).find('td:nth-child(2)').html(), 'grade_type': $(this).find('.cls_grade_type').val() });
            //    }
                
            //});

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_submit_course_wise_grade_range_new",
                //async: false,
                //data: "{sem_code:'" + sem + "',year_code:'" + year + "',course_grade_type:'" + JSON.stringify(obj_grade_dtl) + "'}",
                data: "{sem_code:'" + sem + "',year_code:'" + year + "',course_grade_type:'" + JSON.stringify(obj_grade_dtl) + "',selected_course:'" + selected_course + "', ALL_Course:" + ALL_Course + " }",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        bootbox.alert("Grade Range for selected Courses Submitted Successfully.");//bootbox.alert(data.d);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function course_wise_avg_marks() {
            $('#DataList').css('display', 'none');

            sem = $('#drpsemester').val();
            if (sem == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year = $('#drpyear').val();
            if (year == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_course_wise_avg_sd_range",
                //async: false,
                data: "{sem_code:'" + sem + "',year_code:'" + year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        var result = JSON.parse(data.d);

                        if (result['status'] == 'True' && result['message']['ws_course_grade_detail'] != null) {
                            course_wise_avg_marks_list(result['message']);
                            $('#div_course_list').css('display', 'block');
                        }
                        else if (result['status'] == 'False') {
                            bootbox.alert(result['message']);
                            $('#div_course_list').css('display', 'none');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            $('#div_course_list').css('display', 'none');
                        }
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester and Year');
                        $('#div_course_list').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        var absolute_range;
        function course_wise_avg_marks_list(data) {
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
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                    //"copy",
				        "print",
            	        {
            	            "sExtends": "collection",
            	            "sButtonText": 'Export',
            	            "aButtons": ["xls"]
            	        }//,"select"
			        ]
                },
                //"aaData": JSON.parse(data),
                "aaData": data['ws_course_grade_detail'],
                "aoColumns": [
                    {
                        "sTitle": "Select <center><input type='checkbox' name='cc' class='chk_selection_all_course_code' ></center>", "mData": null, "bSortable": false, mRender: function (data) {
                            return '<center><input type="checkbox" name="substudio_user" class="chk_selection_course_code" ></center>';
                        }
                    },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },

                    { "sTitle": "Grade Type", "mData": null, "bSortable": false, fnRender: function (data) {
                        return '<select class="cls_grade_type" style="width:90px;"><option value="A">Absolute</option><option value="R">Relative</option></select>' +
                                '<input type="hidden" class="cls_hdn_grade_type" value="' + data.aData.grade_type + '" />';
                    }
                    },

                    { "sTitle": "Average Marks", "mData": "Average", "bSortable": false, fnRender: function (data) { return parseFloat(data.aData.Average).toFixed(2); } },

                    { "sTitle": "Standard Deviation", "mData": "SD", "bSortable": false, fnRender: function (data) { return parseFloat(data.aData.SD).toFixed(2); } },

                    { "sTitle": "A+", "mData": "A_plus_to", "bSortable": false, "sClass": "cls_A_plus", fnRender: function (data) { return data.aData.A_plus_from + ' - ' + data.aData.A_plus_to; } },

                    { "sTitle": "A", "mData": "A_to", "bSortable": false, "sClass": "cls_A", fnRender: function (data) { return data.aData.A_from + ' - ' + data.aData.A_to; } },

                    { "sTitle": "A-", "mData": "A_minus_to", "bSortable": false, "sClass": "cls_A_minus", fnRender: function (data) { return data.aData.A_minus_from + ' - ' + data.aData.A_minus_to; } },

                    { "sTitle": "B+", "mData": "B_plus_to", "bSortable": false, "sClass": "cls_B_plus", fnRender: function (data) { return data.aData.B_plus_from + ' - ' + data.aData.B_plus_to; } },

                    { "sTitle": "B", "mData": "B_to", "bSortable": false, "sClass": "cls_B", fnRender: function (data) { return data.aData.B_from + ' - ' + data.aData.B_to; } },

                    { "sTitle": "B-", "mData": "B_minus_to", "bSortable": false, "sClass": "cls_B_minus", fnRender: function (data) { return data.aData.B_minus_from + ' - ' + data.aData.B_minus_to; } },

                    { "sTitle": "C+", "mData": "C_plus_to", "bSortable": false, "sClass": "cls_C_plus", fnRender: function (data) { return data.aData.C_plus_from + ' - ' + data.aData.C_plus_to; } },

                    { "sTitle": "C", "mData": "C_to", "bSortable": false, "sClass": "cls_C", fnRender: function (data) { return data.aData.C_from + ' - ' + data.aData.C_to; } },

                    { "sTitle": "C-", "mData": "C_minus_to", "bSortable": false, "sClass": "cls_C_minus", fnRender: function (data) { return data.aData.C_minus_from + ' - ' + data.aData.C_minus_to; } },

                    { "sTitle": "D+", "mData": "D_plus_to", "bSortable": false, "sClass": "cls_D_plus", fnRender: function (data) { return data.aData.D_plus_from + ' - ' + data.aData.D_plus_to; } },

                    { "sTitle": "D", "mData": "D_to", "bSortable": false, "sClass": "cls_D", fnRender: function (data) { return data.aData.D_from + ' - ' + data.aData.D_to; } },

                    { "sTitle": "D-", "mData": "D_minus_to", "bSortable": false, "sClass": "cls_D_minus", fnRender: function (data) { return data.aData.D_minus_from + ' - ' + data.aData.D_minus_to; } },

                    {
                        "sTitle": "Submitted", "mData": null, "bSortable": false, "sClass": "", fnRender: function (data) {
                            debugger;
                            if (data.aData.grade_submitted == "Y") {
                                return "<center>Yes</center>";
                            } else {
                                return "<center>No</center>";
                            }
                        }
                    },

                    { "sTitle": "Submission Date-Time", "mData": null, "bSortable": false, "sClass": "sub_date", fnRender: function (data) { return "<center>" + data.aData.grade_submitted_date_time + "</center>"; } }
                ]
            });

            $(".cls_hover").hover(
                function () {
                    $(this).next()[0].style.display = "block";
                }, function () {
                    $(this).next()[0].style.display = "none";
                }
            );

            //changes 02062022
            $('.chk_selection_all_course_code').change(function () {
                if (this.checked) {
                    $("input:checkbox.chk_selection_course_code").prop('checked', this.checked);
                } else {
                    $("input:checkbox.chk_selection_course_code").prop('checked', false);
                }
            });

            $('.chk_selection_course_code').change(function () {
                if (this.checked) {
                    //
                } else {
                    $("input:checkbox.chk_selection_all_course_code").prop('checked', false);
                }
            });

            absolute_range = data['absolute_grade_range'][0];
            for (var i = 0; i < $('#example tbody tr').length; i++) {
                var temp_tr = $('#example tbody tr:nth-child(' + (i + 1) + ')');

                if (temp_tr.find('.cls_hdn_grade_type').val() == 'R') {
                    temp_tr.find('.cls_grade_type').val('R');
                }
                else {
                    temp_tr.find('.cls_A_plus').html(absolute_range.A_plus_from + ' - ' + absolute_range.A_plus_to);
                    temp_tr.find('.cls_A').html(absolute_range.A_from + ' - ' + absolute_range.A_to);
                    temp_tr.find('.cls_A_minus').html(absolute_range.A_minus_from + ' - ' + absolute_range.A_minus_to);
                    temp_tr.find('.cls_B_plus').html(absolute_range.B_plus_from + ' - ' + absolute_range.B_plus_to);
                    temp_tr.find('.cls_B').html(absolute_range.B_from + ' - ' + absolute_range.B_to);
                    temp_tr.find('.cls_B_minus').html(absolute_range.B_minus_from + ' - ' + absolute_range.B_minus_to);
                    temp_tr.find('.cls_C_plus').html(absolute_range.C_plus_from + ' - ' + absolute_range.C_plus_to);
                    temp_tr.find('.cls_C').html(absolute_range.C_from + ' - ' + absolute_range.C_to);
                    temp_tr.find('.cls_C_minus').html(absolute_range.C_minus_from + ' - ' + absolute_range.C_minus_to);
                    temp_tr.find('.cls_D_plus').html(absolute_range.D_plus_from + ' - ' + absolute_range.D_plus_to);
                    temp_tr.find('.cls_D').html(absolute_range.D_from + ' - ' + absolute_range.D_to);
                    temp_tr.find('.cls_D_minus').html(absolute_range.D_minus_from + ' - ' + absolute_range.D_minus_to);
                }
            }

            $('#DataList').css('display', 'block');
        }

        $(document).on('change', '.cls_grade_type', function () {
            var temp_tr = $(this).closest('tr');

            if ($(this).val() == 'R') {
                var row_data = oTable.fnGetData(temp_tr[0]);

                temp_tr.find('.cls_A_plus').html(row_data.A_plus_to);
                temp_tr.find('.cls_A').html(row_data.A_to);
                temp_tr.find('.cls_A_minus').html(row_data.A_minus_to);
                temp_tr.find('.cls_B_plus').html(row_data.B_plus_to);
                temp_tr.find('.cls_B').html(row_data.B_to);
                temp_tr.find('.cls_B_minus').html(row_data.B_minus_to);
                temp_tr.find('.cls_C_plus').html(row_data.C_plus_to);
                temp_tr.find('.cls_C').html(row_data.C_to);
                temp_tr.find('.cls_C_minus').html(row_data.C_minus_to);
                temp_tr.find('.cls_D_plus').html(row_data.D_plus_to);
                temp_tr.find('.cls_D').html(row_data.D_to);
                temp_tr.find('.cls_D_minus').html(row_data.D_minus_to);
            }
            else {
                temp_tr.find('.cls_A_plus').html(absolute_range.A_plus_from + ' - ' + absolute_range.A_plus_to);
                temp_tr.find('.cls_A').html(absolute_range.A_from + ' - ' + absolute_range.A_to);
                temp_tr.find('.cls_A_minus').html(absolute_range.A_minus_from + ' - ' + absolute_range.A_minus_to);
                temp_tr.find('.cls_B_plus').html(absolute_range.B_plus_from + ' - ' + absolute_range.B_plus_to);
                temp_tr.find('.cls_B').html(absolute_range.B_from + ' - ' + absolute_range.B_to);
                temp_tr.find('.cls_B_minus').html(absolute_range.B_minus_from + ' - ' + absolute_range.B_minus_to);
                temp_tr.find('.cls_C_plus').html(absolute_range.C_plus_from + ' - ' + absolute_range.C_plus_to);
                temp_tr.find('.cls_C').html(absolute_range.C_from + ' - ' + absolute_range.C_to);
                temp_tr.find('.cls_C_minus').html(absolute_range.C_minus_from + ' - ' + absolute_range.C_minus_to);
                temp_tr.find('.cls_D_plus').html(absolute_range.D_plus_from + ' - ' + absolute_range.D_plus_to);
                temp_tr.find('.cls_D').html(absolute_range.D_from + ' - ' + absolute_range.D_to);
                temp_tr.find('.cls_D_minus').html(absolute_range.D_minus_from + ' - ' + absolute_range.D_minus_to);
            }
        });
    </script>
</asp:Content>
