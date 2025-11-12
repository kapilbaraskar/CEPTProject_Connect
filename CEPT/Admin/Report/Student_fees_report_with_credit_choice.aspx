<%@ Page Title="Student Fees Credit Choice Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_fees_report_with_credit_choice.aspx.cs" Inherits="Admin_Report_Student_fees_report_with_credit_choice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="../../Js/StudentFees.js?t=28082019" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
 <style>
 .input
 {
 }
 </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-rupee"></i>Student Fees Credit Choice Report
            </h1>
        </div>
        <div class="space">
        </div>
        <div>
        <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                          Current semester for fees : 
                          
                        </td>
                         <td>
                           <label style="color: Red;" id="lbl_current_sem" runat="server">
                            </label>
                         </td>
                    </tr>
                    </table>
            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                   
                    <tr>
                        
                        <td>
                            Department
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            <td>
                                Year of enrollment
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                                Programme
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive_fees_report">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
            </div>
        </div>
        <div style="margin-top: 25px; display: none; width: 100%" class="row-fluid" id="DataList">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="example" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
        
    </div>
</asp:Content>

