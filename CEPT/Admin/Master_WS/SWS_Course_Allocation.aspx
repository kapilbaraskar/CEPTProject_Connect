<%@ Page Title="SWS Course Allocation Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SWS_Course_Allocation.aspx.cs" Inherits="Admin_Master_WS_SWS_Course_Allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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


            $('#btnreterive').on('click', function () {
                get_allocation_dtl();
                return false;

            });

            $('#btnsave').on('click', function () {
                save_ws_data_for_allocation();
                return false;

            });
            $('#btnpublish').on('click', function () {
                publish_allocation_data();
                return false;

            });

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
        function get_allocation_dtl() {

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
                url: "../../WebService_WS.asmx/Get_course_wise_allocation_dtl",
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
                            if (data.registered_students != '0') {
                                return '<center><input type="checkbox"  name="check1" value="1" class="chk_course" ></center>';
                            }
                            else {
                                return '';
                            }

                        }
                    },

                    //{ "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_course" ></center>' },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Faculty", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Available Seat", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "No of Registered/Allocated Students", "mData": "elective", "bSortable": false },
                    { "sTitle": "No of Registered Students", "mData": "registered_students", "bSortable": false },
                    { "sTitle": "No of Allocated Students", "mData": "final_allocation_status", "bSortable": false },
                    //{ "sTitle": "Allocated Student Id", "className": "blue", "mData": "allocated_user_id", "bSortable": false }
                    {
                        "sTitle": "Allocated Student Id", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.allocated_user_id != '') {
                                return '<center><span style= "color: blue;">' + data.allocated_user_id + '</span></center>';
                            }
                            else {
                                return '';
                            }

                        }
                    }
                ]

            });

            $('#DataList').css('display', 'block');
        }

        function save_ws_data_for_allocation() {
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
                bootbox.alert('Please Select CheckBox');
                return false;
            }

            if (flag == "N") {
                var data = JSON.stringify({ course_code: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year: $('#drpyear').val() });

                $.ajax({
                    type: "POST",
                    url: "../../WebService_WS.asmx/SWS_Course_allocation",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "error on course") {
                                bootbox.alert("Data Not Found ??");
                                $('.copyright').css('display', 'none');
                                return false;
                            }
                            if (data.d == "Data Saved Successfully") {
                                bootbox.alert("SWS Course Allocation Data Saved Successfully");
                                get_allocation_dtl();
                            }
                            else {
                                bootbox.alert("Problem In Data");
                                return false;
                            }

                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
        }


        function publish_allocation_data() {
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

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/publish_allocation_data",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var split_data = data.d.split(":");

                        if (data.d == "already") {
                            bootbox.alert('Course Allocation is already published for this semester and year');
                            return false;
                        }
                        bootbox.alert(data.d);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;SWS Course Allocation Details
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
                <div class="span11" style="margin-top: 10px">
                    <table style="width: 100%" align="center" border="0" cellpadding="3" cellspacing="5">
                        <tr>
                            <td align="center" style="width: 40%;">
                                <button id="btnsave" style="display: block; line-height: inherit; margin-right: -56%;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Final Course Allocation 
                                </button>

                            </td>
                            <td style="width: 40%;">
                                    <button id="btnpublish" style="display: block; float: center; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Publish Allocation
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

