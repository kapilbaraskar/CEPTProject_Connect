<%@ Page Title="COURSES - CEPT " Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="total_course_offered_report.aspx.cs" Inherits="Admin_Report_total_course_offered_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <script src="../../Js/reports.js" type="text/javascript"></script>
 <script type="text/javascript">
     $(document).ready(function () {

         get_total_offered_course();

     });
 
 </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative" >
            <h1>
                <i class="icon-desktop"></i> COURSES AT CEPT UNIVERSITY
            </h1>
        </div>
        <div>
            
            <div id="DataList" style="display: none; margin-top:20px">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
           
        </div>
    
    </div>
</asp:Content>

