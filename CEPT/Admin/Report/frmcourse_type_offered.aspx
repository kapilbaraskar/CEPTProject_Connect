<%@ Page Title="Report - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frmcourse_type_offered.aspx.cs" Inherits="Admin_Report_frmcourse_type_offered" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/reports.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            get_course_type_offered_report();
            get_course_type_and_credits_offered_report();
            get_course_type_credits_offered_report();


        });
 
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Course Offered
            </h1>
        </div>
        <div>
            <div id="DataList" style="display: none; margin-top: 20px">
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

              <div class="page-header position-relative" style="color: #2679b5;">
            <h3>
                <i class="icon-desktop"></i> COURSE TYPES BY VARIOUS FACULTY  
            </h3>
        </div>

               <div id="DataList1" style="display: none; margin-top: 20px">
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

                 <div class="page-header position-relative" style="color: #2679b5;">
            <h3>
                <i class="icon-desktop"></i> COURSE TYPES AND CREDITS OFFERED BY FACULTY  
            </h3>
        </div>

             <div id="DataList2" style="display: none; margin-top: 20px">
                <table cellpadding="0" cellspacing="0" border="0" id="example2" class="display table table-striped table-bordered table-hover"
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
