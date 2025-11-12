<%@ Page Title="Report - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="faculty_wise_total_course_report.aspx.cs" Inherits="Admin_Report_faculty_wise_total_course_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="../../Js/reports.js" type="text/javascript"></script>
 <script type="text/javascript">
     $(document).ready(function () {

         get_faculty_wise_total_course();
         get_faculty_type_wise_total_course();


     });
 
 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> FACULTY WISE NUMBER OF COURSES AND CREDITS
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
                     <tfoot style="background-color:#f3f3f3">
                        <tr>
                            <th>
                                Total:
                            </th>
                            <th style="text-align: left">
                            </th>
                            <th style="text-align: left">
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
              <div class="page-header position-relative"></div>

             <div id="DataList1" style="display: none; margin-top:20px">
                <table cellpadding="0" cellspacing="0" border="0" id="example1" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                       <tfoot style="background-color:#f3f3f3">
                        <tr>
                            <th>
                                Total:
                            </th>
                            <th style="text-align: left">
                            </th>
                            <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                             <th style="text-align: left">
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
           
        </div>
    
    </div>
</asp:Content>

