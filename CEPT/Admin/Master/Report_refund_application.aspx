<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Report_refund_application.aspx.cs" Inherits="Admin_Report_refund_application" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/Refund_application_report.js"></script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Refund Application
            </h1>
        </div>
        <div class="row-fluid">
             <div id="DataList" style="display: none; overflow: auto;" >
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
     <div style="display: none;">
        <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="Download_Student_RefundForm" />
    </div>
    <input type="hidden" id="hdn_userid" runat="server" clientidmode="Static" />
</asp:Content>

