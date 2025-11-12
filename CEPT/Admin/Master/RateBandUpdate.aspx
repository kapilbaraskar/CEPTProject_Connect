<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="RateBandUpdate.aspx.cs" Inherits="Admin_Master_RateBandUpdate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/admin_report.js?t=17072025" type="text/javascript"></script><%--08022019--%>

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
            $('#btnreterive').on('click', function () {
                GetRateBandDetails();
                return false;
            });

            return false;
        });
        function GetRateBandDetails() {
            $('#DataList').css('display', 'none');

            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
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
                url: "../../WebService.asmx/GetRateBandDetailsNew",
                async: false,
                data: "{sem_code:'" + semester + "' ,year_code:'" + year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Display_rateband_data(data.d);

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

        function Display_rateband_data(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sScrollY": '600px',
                "scrollX": true,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                    {
                        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, mRender: function (data) {

                            return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                        }
                    },
                    { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
                    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "TotalExperiance", "mData": "TotalExperiance", "bSortable": false },
                    { "sTitle": "CurrentExperiance", "mData": "CurrentExperiance", "bSortable": false },
                    { "sTitle": "Designation", "mData": "designation", "bSortable": false },
                    { "sTitle": "Rate Band", "mData": "rate_band", "bSortable": false }
                ]
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            $(window).trigger('resize');
        }

        function select_all_change() {
            if ($('#chk_select_all')[0].checked) {
                $('.cls_chk_course_select').attr('checked', 'checked');
            }
            else {
                $('.cls_chk_course_select').removeAttr('checked');
            }
        }

        function course_select_change(cur_ele) {

            if (cur_ele.checked) {
                if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
                    $('#chk_select_all')[0].checked = true;
            }
            else {
                $('#chk_select_all')[0].checked = false;
            }
        }

        function submit_all() {


            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year = $('#drpyear').val();
            if (year == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            bootbox.confirm('Are you sure you want to Submit RateBand?', function (result) {
                if (result == true) {
                    if (oTable != undefined) {
                        if (oTable.fnGetData().length > 0) {
                            var obj_selected_course = $('.cls_chk_course_select:checked');
                            if (obj_selected_course.length > 0) {
                                var commit_data = [];
                                for (var i = 0; i < obj_selected_course.length; i++) {
                                    var row_data = oTable.fnGetData(obj_selected_course[i].closest('tr'));
                                    commit_data.push(row_data['instructor_code']);
                                }

                                if (commit_data.length > 0) {

                                    var str_commit_data = JSON.stringify(commit_data);

                                    $.ajax({
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "../../WebService.asmx/SaveRateBandNew",
                                        data: "{commit_data:'" + str_commit_data + "',sem_code:'" + semester + "',year_code:'" + year + "'}",
                                        dataType: "json",
                                        success: function (data) {
                                            if (data.d != "" && data.d != "[]") {
                                                var res = data.d;
                                                if (res == 'RateBand Submitted Successfully') {
                                                    $('.cls_chk_course_select:checked').each(function () {
                                                        var row = $(this).closest('tr')[0]; 
                                                        oTable.fnDeleteRow(row);
                                                    });
                                                    bootbox.alert("RateBand Submitted Successfully", function () {
                                                        //$('#btnreterive').trigger('click');

                                                    });
                                                }
                                                else {
                                                    bootbox.alert(res);
                                                }

                                            }
                                            else {
                                                bootbox.alert(data.d);
                                            }
                                        },
                                        error: function (result) {
                                            alert(result);
                                        }
                                    });
                                }
                                else {
                                    bootbox.alert('No Instructor Selected Please select Instructor');
                                }
                            }
                            else {
                                bootbox.alert('No Instructor Selected Please select Instructor');
                            }
                        }
                    }
                    //    }
                    //});
                }
            });

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Update RateBand
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
                            Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
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
                <strong id="panel_head">Update RateBand</strong>
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
        <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
            <div class="container">
                <div class="row-fluid">
                    <div id="submitBtnDiv" class="controls" style="text-align: right;width:50%;">
                        <button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="submit_all()">Submit</button>
                    </div>
                </div>
                <!--/row-fluid-->
            </div>
            <!--/container-->
        </div>
    </div>
</asp:Content>

