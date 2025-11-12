<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="course_allocate_dtl.aspx.cs" Inherits="Student_course_allocate_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var status = false;
        var oTable1;
        var oTable2;
        var oTable3;
        var time_zone = false;
        $(document).ready(function () {
            databind();
        });

       

        function databind() {
            var isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
            if (isMobile) {
                browserType = "Mobile";
            } else {
                browserType = "Web";
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/SWs_after_allocated_dtl",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if ($('#hdnusertype').val() == 'S' || $('#hdnusertype').val() == 'E') {
                        if (data.d[0] != "" && data.d[0] != null) {
                            display_student_Course_reg(data.d[0]);
                        }
                        else { $('#DataListreg').css('display', 'none');}
                        if (data.d[2] != "" && data.d[2] != null) {
                            display_student_Course_man(data.d[2]);
                        }
                        else { $('#manually_course_section').css('display', 'none'); }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        

      


        function display_student_Course_reg(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataListreg").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_reg" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable1 = $("#example_reg").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //  "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Course Heding", "mData": "new_credit", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Category", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "start_date", "bSortable": false },
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Registration Time", "mData": "created_date", "bSortable": false },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.course_drop_status == 'Y') {
                                return '<span style=color:red;><b>DROPPED</b></span>';
                            }
                            else if (data.status == 'A') {
                                return '<span style=color:Green;><b>Allocated</b></span>';
                            }
                            else if (data.status == 'R' && data.cancel_flag == 'Y') {
                                return '<span style=color:darkblue;><b>Expired</b></span>';
                            }
                            else if (data.status == 'E' && data.cancel_flag == 'Y') {
                                return '<span style=color:darkblue;><b>Expired</b></span>';
                            }
                            else if (data.status == 'R') {
                                return '<span style=color:darkblue;><b>Submitted</b></span>';
                            }
                            else if (data.status == 'P') {
                                return '<span style=color:blue;><b>Provisionally Allocated</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    }

                ]
            }).rowGrouping();

            $('#DataListreg').css('display', 'block');
            // $('#btnpay').css('display', 'block');


        }

        function display_student_Course_man(data) {
            if (oTable3 != null) {
                oTable3.fnDestroy();
                $("#DataListreg").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_reg_man" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable3 = $("#example_reg_man").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //  "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    /* { "sTitle": "Course Heding", "mData": "new_credit", "bSortable": false },*/
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Category", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "start_date", "bSortable": false },
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Registration Time", "mData": "created_date", "bSortable": false },
                    {
                        "sTitle": "course Type", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.course_type == 'M') {
                                return 'Mandatory';
                            }
                            else if (data.course_type == 'E') {
                                return 'Elective';
                            }
                            else {
                                return '';
                            }
                        }
                    },

                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.course_type == 'M' && data.status == 'A') {
                                return '<span style=color:darkblue;><b>Sws Mandatory Final Allocated Course</b></span>';
                            }
                            else if (data.course_type == 'M' && data.status == 'R') {
                                return '<span style=color:darkblue;><b>Submitted</b></span>';
                            }
                            else if (data.course_type == 'E' && data.status == 'A') {
                                return '<span style=color:darkblue;><b>Sws Elective Final Allocated Course</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    }
                    //{
                    //    "sTitle": "Payment Status", "mData": null, "bSortable": false, mRender: function (data) {

                    //        if (data.status == 'A') {
                    //            return 'Paid';
                    //        }
                    //        else {
                    //            return '';
                    //        }
                    //    }
                    //}

                ]
            });

            $('#manually_course_section').css('display', 'block');
            


        }
       

        


        

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="well" style="background-color: White;">

        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Credits Selected Details</strong> <span id="waiver_credits" style="float: right; font-weight: bold; color: blue;"></span>
            </div>
            <div>
                <div id="reg_section" style="display: block">
                    <div class="panel panel-default">
                        <div style="padding-left: 10px;" id="credits_dtl">
                        </div>
                    </div>

                   <%-- <div id="DataListpre" style="display: none; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_pre">SW Elective Provision Allocated Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_pre" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>

                        <div id="manually_course_section" style="display: block;">
                            <div class="panel-heading">
                                <strong id="panel_head_reg_man">Manually Course Details</strong>
                            </div>
                            <table cellpadding="0" cellspacing="0" border="0" id="example_reg_man" class="display table table-striped table-bordered table-hover" width="100%">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>

                        <div style="padding-top: 15px; padding-bottom: 10px; padding-left: 43%;">
                            <button class="btn btn-primary paynowclick" style="display:none;" id="btnpay">Payment Process</button>
                        </div>

                    </div>--%>


                    <div id="DataListreg" style="display: block; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_reg">SW Elective Registration Preference Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>

                     <div id="manually_course_section" style="display:none; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_reg_man">Mandatory Course Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg_man" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                            </div>

                </div>


            </div>
        </div>

    </div>
</asp:Content>

