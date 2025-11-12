<%@ Page Title="Report - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_registered_priority_report_course_wise.aspx.cs"
    Inherits="Admin_Report_frm_priority_report_course_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">

        var oTable;
        $(document).ready(function () {

            //               bindyeardata();
            //               bindsemdata();
            //               binddepartment();

            bind_ws_semdata();

            //   binddepartment();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {

                //total_selected_course
                Registerd_priority_course_wise();

                return false;

            });

            $('#btn_send_email').on('click', function () {

                //total_selected_course
                send_test_email();

                return false;

            });

            return false;

        });

        function send_test_email() {

            $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/send_test_email",

        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {



                //  display_Registerd_priority_course_wise(data.d);
            }
            else {
                //  bootbox.alert('There is No data Found For Selected Semester or Year');
            }

        },
        error: function (result) {
            alert(result);
        }
    });
        }

        function Registerd_priority_course_wise() {
            $('#DataList').css('display', 'none');

            debugger;
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

            //  var dept_code = $('#drpdepartment').val();
            //  var year_Code = $("#drpyear").val();

            $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/get_priority_registration_report_course_wise",

        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: ''}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {



                display_Registerd_priority_course_wise(data.d);
            }
            else {
                bootbox.alert('There is No data Found For Selected Semester or Year');
            }

        },
        error: function (result) {
            alert(result);
        }
    });

            return false;
        }


        function display_Registerd_priority_course_wise(data) {


            $('#DataList').css('display', 'block');


            debugger;


            if (oTable != null) {
                oTable.fnDestroy();


                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bStateSave": false,
                "iDisplayLength": 60,
                "bSort": false,
                //"sDom": 't',
                // "sScrollX": '700px',
                "sScrollX": '400px',
                "sScrollY": '700px',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
               // "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //        "oLanguage": {
                //            "sSearch": "Search all columns with Space:"
                //        },
        //        "oTableTools":
        //{
        //    "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls"]
        //							}
        //						]
        //},

                "aaData": JSON.parse(data),
                "aoColumns": [

                        { "sTitle": "Course", "mData": "course", "bSortable": false },
                        { "sTitle": "P1 Code", "mData": "p1", "bSortable": false },
                        { "sTitle": "P1 Name", "mData": "p1_name", "bSortable": false },
                        { "sTitle": "P2 Code", "mData": "p2", "bSortable": false },
                        { "sTitle": "P2 Name", "mData": "p2_name", "bSortable": false },
                        { "sTitle": "P3 Code", "mData": "p3", "bSortable": false },
                        { "sTitle": "P3 Name", "mData": "p3_name", "bSortable": false },
                        { "sTitle": "P4 Code", "mData": "p4", "bSortable": false },
                        { "sTitle": "P4 Name", "mData": "p4_name", "bSortable": false },
                        { "sTitle": "P5 Code", "mData": "p5", "bSortable": false },
                        { "sTitle": "P5 Name", "mData": "p5_name", "bSortable": false },
                        { "sTitle": "p6 Code", "mData": "p6", "bSortable": false },
                        { "sTitle": "p6 Name", "mData": "p6_name", "bSortable": false },
                        { "sTitle": "p7 Code", "mData": "p7", "bSortable": false },
                        { "sTitle": "p7 Name", "mData": "p7_name", "bSortable": false },
                        { "sTitle": "p8 Code", "mData": "p8", "bSortable": false },
                        { "sTitle": "p8 Name", "mData": "p8_name", "bSortable": false }

           ]

            });

            $('#DataList').css('display', 'block');
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Registerd priority course student wise
            </h1>
        </div>
        </div>
        <div>
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
                            <td style="display: none;">
                                <button class="btn btn-primary" type="submit" id="btn_send_email">
                                    Test Email
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="panel panel-default" id="DataList" style="display: none">
                 <div class="panel-heading">
                <strong>Registerd priority course student wise</strong>
            </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    
</asp:Content>
