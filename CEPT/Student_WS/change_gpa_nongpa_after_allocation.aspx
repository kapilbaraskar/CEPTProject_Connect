<%@ Page Title="Change GPA/Non-GPA - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="change_gpa_nongpa_after_allocation.aspx.cs" Inherits="Student_change_gpa_nongpa_after_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

  <script src="../Js/change_after_allocation_new.js" type="text/javascript"></script>
  <script src="../Js/google_analytics_code.js" type="text/javascript"></script>
 
   <script type="text/javascript">


       $(document).ready(function () {

           get_allocate_data_for_gpa_nongpa();


           $('#btnsave').on('click', function () {

               save_gpa_non_gpa_changes();
               return false;

           });


           return false;

       });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Change GPA / Non-GPA
            </h1>
        </div>
        <div class="space">
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

