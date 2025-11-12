<%@ Page Title="Non-CEPT Student Registered" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Non_cept_student_registered.aspx.cs" Inherits="Admin_Report_Non_cept_student_registered" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>
 <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

      <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

       <script type="text/javascript">
           $(document).ready(function () {

               //               bindyeardata();
               //               bindsemdata();
               //               binddepartment();

               bind_ws_semdata();

               binddepartment();
               bindyeardata_for_cross_reg();

               $('#btnreterive').on('click', function () {

                   //total_selected_course
                   Non_cept_registered_student();

                   return false;

               });



               return false;

           });



    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
  <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Non-CEPT Student Registered
            </h1>
        </div>
        </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Filter</strong>
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
                           <%-- <td>
                             Course Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>--%>
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
                    <strong>Non CEPT Student Details</strong>
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

