<%@ Page Title="Registerd priority student wise" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_registered_priority_student_wise.aspx.cs" Inherits="Admin_Report_frm_registered_priority_student_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

            binddepartment();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {

                //total_selected_course
                Registerd_priority_course_wise();

                return false;

            });



            return false;

        });

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

              var dept_code = $('#drpdepartment').val();
            //  var year_Code = $("#drpyear").val();

            $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/get_priority_registration_report_student_wise",

        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
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
              //  "sDom": 't',
                // "sScrollX": '700px',
                //  "sScrollY": '700px',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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

                        { "sTitle": "Student code", "mData": "user_id", "bSortable": false },
                            { "sTitle": "Student name", "mData": "user_name", "bSortable": false },
                       { "sTitle": "P1", "mData": "P1", "bSortable": false },
                        { "sTitle": "P2", "mData": "P2", "bSortable": false },
                        { "sTitle": "P3", "mData": "P3", "bSortable": false },
                        { "sTitle": "P4", "mData": "P4", "bSortable": false },
                        { "sTitle": "P5", "mData": "P5", "bSortable": false }

           ]

            });

            $('#DataList').css('display', 'block');
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Registerd priority student wise
            </h1>
        </div>
    </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong> Filter Criteria </strong>
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
                               Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
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
            <div id="DataList" class="panel panel-default" style="display: none">
                <div class="panel-heading">
                    <strong>Registerd priority student wise</strong>
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

