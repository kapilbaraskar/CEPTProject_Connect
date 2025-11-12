<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_user_passport_download.aspx.cs" Inherits="Admin_Report_frm_user_passport_download" %>

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
         
     
         bind_ws_semdata();

         binddepartment();
         bindyeardata_for_cross_reg();

         $('#btnreterive').on('click', function () {

             //total_selected_course
             Passport_data();

             return false;

         });



         return false;

     });

     function Passport_data() {

         $('#DataList').css('display', 'none');

         debugger;
         var dept_code = $('#drpdepartment').val();
        
         $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/get_student_passport_detail",

        data: "{dept_code: '"+ dept_code +"'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {



                display_data(data.d);
            }
            else {
                bootbox.alert('There is no data found.');
            }

        },
        error: function (result) {
            alert(result);
        }
    });

         return false;


     }

     function display_data(data) {

         $('#DataList').css('display', 'block');

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
            
            // "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
             "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
             //        "oLanguage": {
             //            "sSearch": "Search all columns with Space:"
             //        },
        //     "oTableTools":
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

                        { "sTitle": "Student ID", "mData": "user_id", "bSortable": false },
                        { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                         { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                        { "sTitle": "Name as per passport", "mData": "name_as_per_passport", "bSortable": false },
                        { "sTitle": "Passport Number", "mData": "passport_number", "bSortable": false },
                         { "sTitle": "Passport scan copy",
                             "mData": null,
                             "bSortable": false,
                             mRender: function (oObj) {

                                 if (oObj.passport_scan_copy != '') {
                                     return '<a class="fancybox" target="_blank" rel="group" download href="../../UserPassport/' + oObj.passport_scan_copy + '">Download</a>';
                                 }
                                 else {
                                     return "";
                                 }
                             }
                         }
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
                <i class="icon-desktop"></i> Passport Details
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
                            <%--<td>
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
                            </td>--%>
                            <td>
                              Department :
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
                    <strong> Passport Details</strong>
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

