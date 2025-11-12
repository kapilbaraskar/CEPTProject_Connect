<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="change_after_course_allocation.aspx.cs" Inherits="Admin_Master_change_after_course_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script src="../../Js/admin_report.js" type="text/javascript"></script>
<script src="../../Js/change_after_allocation.js" type="text/javascript"></script>
   <script type="text/javascript">


       $(document).ready(function () {


           //  bindyeardata();
           bindprogrammedata();
           binddepartment();


           $('#btnreterive').on('click', function () {

               get_allocate_data();

               return false;

           });

           $('#btnsave').on('click', function () {

               save_changes();
               return false;

           });

           $('#drpdepartment').on('change', function () {

               if ($('#drpdepartment').val() != '') {
                   if ($('#drpprog').val() != '') {

                       //                        alert('Change');
                       $('#drpstudent').trigger("liszt:updated");
                       //                        $('#drpstudent').chosen();
                       //                        $('#drpstudent').html("");
                       bindallstudentdata();

                   }
               }

           });

           $('#drpprog').on('change', function () {

               if ($('#drpprog').val() != '') {
                   if ($('#drpdepartment').val() != '') {

                       //                        alert('Change');
                       $('#drpstudent').trigger("liszt:updated");
                       //                        $('#drpstudent').chosen();
                       //                        $('#drpstudent').html("");
                       bindallstudentdata();

                   }
               }

           });


           return false;

       });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Change After Allocation
            </h1>
        </div>
        <div class="space">
        </div>
        <div>
            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                            Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            Programme :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                          <td>
                            Student :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                    <tr>
                      
                    </tr>
                </table>
            </div>
        </div>
      
        <div style="margin-top: 5px; display: none; width: 100%" class="row-fluid" id="datalist_saved">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="datatable_saved" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
         <div style="width: 100%; float: left; margin-top: 15px;">
            <table width="100%">
                <tr>
                    <td align="center">
                        <button id="btnsave" style="display: none" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Save
                        </button>
                    </td>
                </tr>
            </table>
        </div>
     
    </div>
</asp:Content>

