<%@ Page Title="Studen Allow In SWS Course" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_allow_in_sws.aspx.cs" Inherits="Admin_Master_Studen_allow_in_sws" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=21092019" type="text/javascript"></script>
  
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
     <link href="../../Style/csvstyle.css" rel="stylesheet" />

     <script type="text/javascript">
    $(document).ready(function () {
      
        bindsemdata();
        bindstudent();
         binddepartment();
         bindyeardata_for_cross_reg();

        $('#btnreterive').on('click', function ()
        {
            total_selected_user();
             return false;
        });

        $('#btnsave').on('click', function ()
        {
            save_data();
             return false;
         });



         return false;

    });
         function total_selected_user() {
            
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

             $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "../../WebService.asmx/get_ws_request_base_registration_dtl",
                     data: "{student_code:'',semester:'" + semester + "' , year :'" + year_code + "'}",
                     dataType: "json",
                     success: function (data) {
                         if (data.d != "") {
                             display_sw_data(data.d);
                         }
                         else {
                             bootbox.alert('There is no data found for selected semester');
                         }
                     },
                     error: function (result) {
                         alert(result);
                     }
                 });

             return false;
         }

         function display_sw_data(data) {
             if (oTable != null) {
                 oTable.fnDestroy();
                 $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
             }

             oTable = $("#example").dataTable({
                 "bPaginate": false,
                 "bStateSave": false,
                 "bSort": false,
                 "iDisplayLength": 60,
                 "sDom": 'b',
                 "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                 "oLanguage": {
                     "sSearch": "Search all columns with Space:"
                 },
                 "aaData": JSON.parse(data),
                 "aoColumns": [
                     { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                     { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                     { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                     { "sTitle": "Program Name", "mData": "prog_name", "bSortable": false }
                 ]
             });

             

             //$('#demo').before(oTableTools.dom.container);
             $('#DataList').css('display', 'block');
             $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
         }

         function bindstudent() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/Get_student_report_list",
                 data: "{}",
                 dataType: "json",
                 aSync: false,
                 success: function (data) {
                     if (data.d != "") {
                         var stud_data = JSON.parse(data.d)

                         $('#drp_student_code').empty().append($("<option></option>").val("").html("-- Select Student Code --"));
                         for (var i = 0; i < stud_data.length; i++) {
                             $('#drp_student_code').append($("<option></option>").val(stud_data[i]["user_id"]).html(stud_data[i]["user_id"]));
                         }

                         $('#drp_student_code').chosen();
                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             });
         }

         function save_data() {
             //
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

             var student_code = $('#drp_student_code').val();
             if (student_code == "") {
                 bootbox.alert('Please select Student Code')
                 $('#drp_student_code').focus();
                 return false;
             }

             $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "../../WebService.asmx/save_student_allow_sws",
                     data: "{Student_Code:'" + student_code +"',semester:'" + semester + "' , year :'" + year_code + "'}",
                     dataType: "json",
                     success: function (data) {
                         if (data.d == true) {
                             total_selected_user();
                             bootbox.alert('Data Saved Successfully');
                         }
                         else if (data.d == "Already Data Exists") {
                             total_selected_user();
                             bootbox.alert("Already This Student (" + student_code +") Allow In SWS Course ");
                         }
                         else {
                             bootbox.alert('There is no data found for selected semester');
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Student Allow In SWS
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Save And Update Data</strong>
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
                            </tr>
                   <tr>
                            <td>
                              Student Code :
                            </td>
                            <td>
                                <select class="chosen-select" id="drp_student_code" />
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                       <td>
                                <button class="btn btn-primary" type="submit" id="btnsave">
                                    Save
                                </button>
                            </td>
                        </tr>
                    </table>
            </div>
        </div>
        
        <div id="DataList" class="panel panel-default" style="display:none;margin-bottom:40px;">
            <div class="panel-heading">
                <strong id="panel_head">Student Allow In SWS</strong>
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


</asp:Content>

