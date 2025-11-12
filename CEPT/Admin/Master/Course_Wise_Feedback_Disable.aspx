<%@ Page Title="Course Wise Feedbcak Disable" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Course_Wise_Feedback_Disable.aspx.cs" Inherits="Admin_Master_Course_Wise_Feedback_Disable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <style>
        .mrgnleft {
            margin-left: 5px;
        }
    </style>
    <script type="text/javascript">
        {
            $(document).ready(function () {
                bindsemdata();
                binddepartment();
                bindprogrammedata();
                bindyeardata_for_cross_reg();
                bindtype();
                //
                $('#btnreterive').on('click', function () {

                    get_data_for_enable_course();
                    return false;
                });

                $('#btnsave,#btnsave_1').on('click', function () {
                    var status_flage = false;
                    $("#example tbody tr").each(function (i)
                    {
                        var obj = {};
                        if ($(this).find(".chk_course").is(':checked'))
                        {
                            status_flage = true;
                        }
                    });
                    if (status_flage == true) {
                        save_data_for_feedback();
                        return false;

                    }
                    else {
                        bootbox.alert("Please Select Course");
                        return false;
                    }
                });

                $('#btnenble,#btnenble_1').on('click', function () {
                    var status_flage = false;
                    $("#example tbody tr").each(function (i) {
                        var obj = {};
                        if ($(this).find(".chk_course").is(':checked')) {
                            status_flage = true;
                        }
                    });
                    if (status_flage == true) {
                        Enble_data_for_feedback();
                        return false;

                    }
                    else {
                        bootbox.alert("Please Select Course");
                        return false;
                    }
                });
            });

            function bindtype() {
                $('#drtype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));

                $('#drtype').append($("<option></option>").val("E").html("Course Wise Feedback Enable"));
                $('#drtype').append($("<option></option>").val("D").html("Course Wise Feedback Disable"));

                $('#drtype').chosen();
            }


            function get_data_for_enable_course() {
                $('#DataList').css('display', 'none');
                $('.copyright').css('display', 'none');
                $('#btnsave').css('display', 'none');
                $('.btn_save').css('display', 'none')

                var semester = $('#drpsemester').val();
                if (semester == "") {
                    bootbox.alert('Please select semester')
                    $('#drpsemester').focus();
                    return false;
                }
                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    bootbox.alert('Please select Year of assign')
                    $('#drpyear').focus();
                    return false;
                }

                var dept_code = $('#drpdepartment').val();
                if (dept_code == "") {
                    bootbox.alert('Please select department')
                    $('#drpdepartment').focus();
                    return false;
                }

                var prog_code = $('#drpprog').val();
                if (prog_code == "") {
                    bootbox.alert('Please select programme')
                    $('#drpprog').focus();
                    return false;
                }
                var prog_level_code = '';
                var staus_flage = $('#drtype').val();
                if (staus_flage == "") {
                    bootbox.alert('Please select Type')
                    $('#drtype').focus();
                    return false;
                }


                //          
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Get_reg_feedback_course_dtl",
                        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code:'" + prog_level_code + "',staus_flage:'" + staus_flage + "'}",
                        dataType: "json",
                        success: function (data) {
                            old_allocate_data = '';

                            if (data.d != null && data.d != '') {
                                Display(data.d);
                                if (staus_flage == 'D') {
                                    $('#btnsave').css('display', 'none');
                                    $('.btn_save').css('display', 'none')
                                    $('#btnenble').css('display', 'block');
                                    $('.btn_enble').css('display', 'block');
                                    //$('#example thead tr')[0].children[0].style.display = 'none';
                                    //$("#example tbody tr").each(function (i) {
                                    //$('#example tbody tr')[i].children[0].style.display = 'none';
                                    // });
                                }
                                else if (staus_flage == 'E') {
                                    $('#btnsave').css('display', 'block');
                                    $('.btn_save').css('display', 'block')
                                    $('#btnenble').css('display', 'none');
                                    $('.btn_enble').css('display', 'none');
                                }
                            }
                            else {
                                bootbox.alert('There is No data Found');
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;
            }





            function Display(data) {
                if (oTable != null) {
                    oTable.fnDestroy();
                    $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" style="width:100%;"><thead></thead><tbody> </tbody></table>');
                }

                oTable = $("#example").dataTable({
                    "bPaginate": false,
                    "bSortable": false,
                    "bSort": false,
                    //"sDom": 't',
                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    // "oTableTools":
                    // {
                    //     "aButtons": [
                    //     
                    // 	]
                    // },
                    "aaData": JSON.parse(data),
                    "aoColumns": [
                        //{ "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_course" onchange="user_select_change(this)" ></center>' },
                        {
                            "sTitle": "Select", "mData": null, "bSortable": false, mRender: function (oObj) {
                                return '<input type="checkbox"  name="check1" value="1" class="chk_course" onchange="user_select_change(this)" id="' + oObj["course_code"] + '" />';
                            }

                        },
                        { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                        { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                        { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false }
                    ]
                });


                $('#DataList').css('display', 'block');
                $('.copyright').css('display', 'block');
                $('#btnsave').css('display', 'block');
                $('.btn_save').css('display', 'block')
            }

            function save_data_for_feedback() {
                var oSettings = oTable.fnSettings();

                for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                    oSettings.aoPreSearchCols[iCol].sSearch = '';
                }

                oSettings.oPreviousSearch.sSearch = '';
                oTable.fnDraw();

                var flag = "N";

                var datalist = [];
                $("#example tbody tr").each(function (i) {
                    var obj = {};
                    if ($(this).find(".chk_course").is(':checked')) {
                        obj["course_code"] = $(this).children().eq(1).html();
                        obj["cancel_flag"] = "N";
                        datalist.push(obj);

                    }


                });

                if (flag == "N") {
                    var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), feedback_disable_type: 'FCD' });

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/Feedback_Disable_Enable_dtl",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Problem in save data") {
                                    bootbox.alert("Problem in save data");
                                    return false;
                                }
                                get_data_for_enable_course();
                                bootbox.alert("Data Saved Successfully");
                                //return false;
                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });
                }
            } function Enble_data_for_feedback()
            {
                var oSettings = oTable.fnSettings();

                for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++)
                {
                    oSettings.aoPreSearchCols[iCol].sSearch = '';
                }

                oSettings.oPreviousSearch.sSearch = '';
                oTable.fnDraw();

                var flag = "N";

                var datalist = [];
                $("#example tbody tr").each(function (i)
                {
                    var obj = {};
                    if ($(this).find(".chk_course").is(':checked'))
                    {
                        obj["course_code"] = $(this).children().eq(1).html();
                        obj["cancel_flag"] = "Y";
                        datalist.push(obj);

                    }


                });

                if (flag == "N") {
                    var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), feedback_disable_type: 'FCD' });

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/Enable_Feedback_course_dtl",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Problem in Update data") {
                                    bootbox.alert("Problem in Update data");
                                    return false;
                                }
                                get_data_for_enable_course();
                                bootbox.alert("Data Update Successfully");
                                //return false;
                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });
                }
            }

        }
    </script>
    <style type="text/css">
        tfoot {
            display: table-header-group;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Courses Wise Feedback Enable / Disable
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>Semester Type :
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
                            <%-- <td>
                                Course of Assign :
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>--%>
                            <td>Student Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                        </tr>
                        <tr>

                            <td>Student Programme
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                            <td>Type
                            </td>
                            <td>
                                <select class="chosen-select" id="drtype">
                                </select>
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnsave" style="display: none;">
                                    Disable
                                </button>
                                <button class="btn btn-primary" type="submit" id="btnenble" style="display: none;">
                                    Enable
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="DataList" style="display: none;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px; display: none;">
                <div class="container">
                    <div class="row-fluid">
                        <div class="span11" style="margin-top: 10px">
                            <table style="width: 100%" align="center" border="0" cellpadding="3" cellspacing="5">
                                <tr>
                                    <td align="center">
                                       <%-- <button id="btnsave" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                            <i class="icon-save bigger-160"></i>Save
                                        </button>--%>

                                        <button class="btn btn-primary btn_save" type="submit" id="btnsave_1" style="display: none;">
                                    Disable
                                </button>
                                <button class="btn btn-primary btn_enble" type="submit" id="btnenble_1" style="display: none;">
                                    Enable
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
            
    </div>
</asp:Content>

