<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SWS_Course_Cancel.aspx.cs" Inherits="Admin_Master_WS_SWS_Course_Cancel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">

        var oTable;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            setCurrentSemester();

            $('#btnreterive').on('click', function () {
                get_cancel_course_dtl();
                return false;

            });

            $('#multiple_course_cancel').on('click', function () {
                save_ws_cancel_course();
                return false;

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

            function bindsemdata() {
                $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
                $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
                $('#drpsemester').chosen();
            }

            function get_cancel_course_dtl() {

                $('#DataList').css('display', 'none');
                var sem_code = $('#drpsemester').val();
                if (sem_code == "") {
                    bootbox.alert('Please select Semester')
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    bootbox.alert('Please select Year')
                    $('#drpyear').focus();
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService_WS.asmx/Get_course_cancel_dtl",
                    data: "{sem_code :'" + sem_code + "',year_code : '" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != null) {
                            if (data.d != "") {
                                Display_Data(data.d);
                                $('#DataList').css('display', 'block');
                                $('.copyright').css('display', 'block');
                            }
                            else {
                                if (data.d == "") {
                                    bootbox.alert('There is No data Found');
                                    $('.copyright').css('display', 'none');
                                    return false;
                                }
                            }
                        }
                        else {
                            $('.copyright').css('display', 'none');
                            bootbox.alert('There is No data Found');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                return false;
            }

            function Display_Data(data) {

                debugger;
                $('#DataList').css('display', 'block');

                if (oTable != null) {
                    oTable.fnDestroy();


                    $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
                }

                oTable = $("#example").dataTable({

                    "bPaginate": false,
                    "bStateSave": false,
                    "bSort": false,
                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    "oLanguage": {
                        "sSearch": "Search all columns with Space:"
                    },

                    "aaData": JSON.parse(data),
                    "aoColumns": [

                        {
                            "sTitle": "Select", "mData": null, "bSortable": false, mRender: function (data) {
                                if (parseInt(data.minimum_seat) > parseInt(data.registered_seat)) {
                                    return '<center><input type="checkbox"  name="check1" value="1" class="chk_course" ></center>';
                                }
                                else {
                                    return '';
                                }

                            }
                        },
                        { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                        { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                        { "sTitle": "Course Faculty", "mData": "dept_name", "bSortable": false },
                        { "sTitle": "Available Seat", "mData": "available_seat", "bSortable": false },
                        { "sTitle": "Minimum Seat", "mData": "minimum_seat", "bSortable": false },
                        { "sTitle": "No of Registered/Allocated Students", "mData": "registered_seat", "bSortable": false }
                        //,
                        //{
                        //    "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                        //        if (parseInt(data.minimum_seat) > parseInt(data.registered_seat)) {
                        //            return '<center><a onclick="cancel_course(' + data.course_code + ')">Cancel</button></a></center>';
                        //        }
                        //        else {
                        //            return '';
                        //        }

                        //    }
                        //}
                    ]

                });

                $('#DataList').css('display', 'block');
            }

            function save_ws_cancel_course() {
                
                if ($("#example_filter :input").val() != '') {
                    bootbox.alert("Please Remove Course Code in Search Box then Cancel Course");
                    return false;
                }

                var oSettings = oTable.fnSettings();

                for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                    oSettings.aoPreSearchCols[iCol].sSearch = '';
                }

                oSettings.oPreviousSearch.sSearch = '';
                oTable.fnDraw();

                var flag = "Y";
                var datalist = [];

                $("#example tbody tr").each(function (i) {
                    var obj = {};

                    if ($(this).find(".chk_course").is(':checked')) {
                        obj["course_code"] = $(this).children().eq(1).html();
                        datalist.push(obj);
                        flag = "N";
                    }
                });

                if (datalist.length == 0) {
                    bootbox.alert('Please select any course to cancel');
                    return false;
                }

                if (flag == "N") {
                    var data = JSON.stringify({ publish_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val() });

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/SWS_Course_cancel",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            debugger;
                            var res = JSON.parse(data.d);

                            if (res.status == "True") {
                                bootbox.alert(res.message);
                                get_cancel_course_dtl();
                                return false;
                            }
                            else if (res.status == "False") {
                                bootbox.alert(res.message);
                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });
                }
            }

            function setCurrentSemester() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_cept_current_sem_data",
                    //async: false,
                    data: "{type:'ws_course'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            cur_grade_sem = JSON.parse(data.d);

                            if (cur_grade_sem.length > 0) {
                                $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                                $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                                $('#drpsemester').trigger("liszt:updated");
                                $('#drpyear').trigger("liszt:updated");
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        });

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;SWS Cancel Course 
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="5" cellspacing="5">
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
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="DataList" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">SWS Course Allocation Details</strong>
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

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px; display: none;">
        <div class="container">
            <div class="row-fluid">
                <div class="span11">
                    <table style="width: 100%" align="center" border="0" cellpadding="3" cellspacing="5">
                        <tr>
                            <td align="center" style="width: 40%;">
                                <button id="multiple_course_cancel" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Cancel Course
                                </button>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

