<%@ Page Title="Calculated Commit Grade" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Calculated_Commit_Grade.aspx.cs" Inherits="Admin_Master_Calculated_Commit_Grade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/calculated_commit_grade.js?t=17012022" type="text/javascript"></script><%--13082020--%>
    <script src="../../Scripts/AjaxFileupload.js" type="text/javascript"></script>
    <style type="text/css">
        .inline_input {
            width: 35px;
            margin: 0;
        }
        .hide {
            display:none;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Calculated Commit Grade
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            
            <div class="panel-heading">
                <strong><span id="spn_course_name" class="panel-headingfont"></span> </strong>
                <span style="float:right;">
                    
                </span>
            </div>
            
            <div>
                <div id="DataList" style="display: none;">
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

        <table style="width: 50%;margin-left: 23%;">
            <tr id='tbl_tr_btn'>
                <td align="center">
                    <button id="commit_grade" type="button" class="btn btn-lg btn-primary">Commit Grade</button>
                </td>
            </tr>
        </table>

    </div>

    <input type="hidden" id="hdn_c" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_s" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_y" runat="server" clientidmode="Static" />
    <asp:HiddenField ID="hdnusertype" runat="server" ClientIDMode="Static" />
</asp:Content>

