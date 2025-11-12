<%@ Page Title="Add selected old course" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_course_add_selected.aspx.cs" Inherits="Admin_Master_frm_course_add_selected" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        var oTable;

        var cur_sem;
        var cur_year;

        $(document).ready(function () {

            bindyeardata_for_cross_reg();

            $('#drpsem,#drpyear').on('change', function () {
                $('#DataList,#btnoffer').css('display', 'none');
            });

            $('#btnRetrieve').on('click', function () {

                if ($('#drpyear').val() == "") {
                    bootbox.alert('please select year.');
                    return false;
                }

                cur_sem = $('#drpsem').val()
                cur_year = $('#drpyear').val();

                course_list();

            });

            $('#btnoffer').on('click', function () {

                var offer_course_datalist = [];
                var oSettings = oTable.fnSettings();
                for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                    oSettings.aoPreSearchCols[iCol].sSearch = '';
                }

                oSettings.oPreviousSearch.sSearch = '';
                oTable.fnDraw();

                $("#tbl_offer_course tbody tr").each(function (i) {

                    if ($(this).find(".chk_course").is(':checked')) {

                        var obj = {};
                        obj["course_code"] = $(this).children().eq(1).html();
                        offer_course_datalist.push(obj);
                    }
                });
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_selected_data_from_old_semester",
                    async: false,
                    data: "{selected_course :'" + JSON.stringify(offer_course_datalist) + "',semester:'" + $('#drpsem').val() + "',year:'" + $('#drpyear').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            bootbox.alert(data.d);
                            $('#DataList,#btnoffer').css('display', 'none');

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
                return false;
            });

        });

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

        function course_list() {
            $('#DataList,#btnoffer').css('display', 'none');

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_selected_course_list_for_insert",
                //async: false,
                data: "{sem_code :'" + cur_sem + "',year_code :'" + cur_year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        display_course_list(data.d);
                    }
                    else {
                        bootbox.alert('No Courses Found');
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function display_course_list(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_offer_course" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#tbl_offer_course").dataTable({

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
            	}
			]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                { "sTitle": "Select",
                    "mData": null,
                    "bSortable": false,

                    "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_course" ></center>'
                },
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
                //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
                //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            {"sTitle": "Instructor", "mData": "instructor", "bSortable": false },
                //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
                //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            {"sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },

            { "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                return get_prerequisite(data);
            }
            },

            { "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
                //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            {"sTitle": "Intake", "mData": "intake", "bSortable": false }
                // { "sTitle": "Remark", "mData": "remark", "bSortable": false },
        ]
            });

            $('#DataList,#btnoffer').css('display', 'block');
        }

        function get_prerequisite(data) {
            var str_return = '';
            var obj_prerequisite;
            if (data != "") {
                try {
                    obj_prerequisite = JSON.parse(data);
                } catch (e) {
                    return data;
                }

                if (obj_prerequisite["chkbox"] != "") {
                    var split_chk_data = obj_prerequisite["chkbox"].split('~');

                    for (var i = 0; i < split_chk_data.length; i++) {
                        if (split_chk_data[i] != 'chk_pre10') {
                            if (str_return != '') str_return = str_return + ', ';

                            switch (split_chk_data[i]) {
                                case 'chk_pre1':
                                    str_return = str_return + 'None'; break;
                                case 'chk_pre2':
                                    str_return = str_return + 'Completed 3rd year FA'; break;
                                case 'chk_pre3':
                                    str_return = str_return + 'Completed 3rd year FD'; break;
                                case 'chk_pre4':
                                    str_return = str_return + 'Completed 3rd year FP'; break;
                                case 'chk_pre5':
                                    str_return = str_return + 'Completed 3rd year FT'; break;
                                case 'chk_pre6':
                                    str_return = str_return + 'Completed UG Architecture'; break;
                                case 'chk_pre7':
                                    str_return = str_return + 'Completed UG Planning'; break;
                                case 'chk_pre8':
                                    str_return = str_return + 'Completed UG Design'; break;
                                case 'chk_pre9':
                                    str_return = str_return + 'Completed UG Technology/ Engineering'; break;
                            }
                        }
                    }
                }

                if (obj_prerequisite["other"] != "") {
                    if (str_return != '') str_return = str_return + ', ';
                    str_return = str_return + obj_prerequisite["other"];
                }
            }
            return str_return;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Retrieve Course Data</span></strong></div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Semester :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpsem">
                            <option value="M">Monsoon</option>
                            <option value="S">Spring</option>
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Year :
                    </div>
                    <div id="div_cur_sem_course" class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpyear">
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button class="btn btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_tab" style="display: block; width: 100%; margin-bottom: 60px; overflow: auto;">
            <div id="pendingcourse">
                <%-- in active">--%>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="tbl_offer_course" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1084px;">
            <div class="container">
                <div class="row-fluid">
                    <div id="submitBtnDiv" class="controls" style="text-align: center">
                        <table style="width: 1084px;">
                            <tr>
                                <td align="center">
                                    <button id="btnoffer" type="button" style="display: none" class="btn btn-lg btn-primary">
                                        <i class="icon-save bigger-160"></i>Offer
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <!--/row-fluid-->
            </div>
            <!--/container-->
        </div>
    </div>
</asp:Content>
