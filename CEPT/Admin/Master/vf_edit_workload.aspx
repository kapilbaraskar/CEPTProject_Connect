<%@ Page Title="Work Load Mgmt" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="vf_edit_workload.aspx.cs" Inherits="Admin_Master_vf_edit_workload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/vf_edit_workload.js?t=11032025" type="text/javascript"></script><%--29122018--%><%--12072019--%>

    <style type="text/css">
        .cls_hide
        {
            display:none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Work Load & Rate
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <div id="div_course_detail" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="Strong1">Course Detail</strong>
            </div>
            <div style="min-height:110px;">
                <div>
                    <table style="margin: 10px 0px 10px 15px;float:left;">
                        <tr>
                            <td><b>Course Code</b></td>
                            <td>&nbsp;:&nbsp;</td>
                            <td id="td_course_code"></td>
                        </tr>
                        <tr>
                            <td><b>Course Name</b></td>
                            <td>&nbsp;:&nbsp;</td>
                            <td id="td_course_name"></td>
                        </tr>
                        <tr>
                            <td><b>Course Type</b></td>
                            <td>&nbsp;:&nbsp;</td>
                            <td id="td_course_type"></td>
                        </tr>
                        <tr>
                            <td><b>Credits</b></td>
                            <td>&nbsp;:&nbsp;</td>
                            <td id="td_course_credits"></td>
                        </tr>
                    </table>
                </div>

                <div style="padding-left: 50%;">
                    <table id="tbl_load_dtl" style="margin: 10px 0px 10px 15px;">
                        <thead>
                            <tr>
                                <td><b>Instructor</b></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><b>Load</b></td>
                            </tr>
                        </thead>
                        <tbody>
                        
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div class="well" style="background-color: White;clear:both;">

        <div id="div_course_list" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Edit Workload Detail</strong>
            </div>

            <div><%--class="panel-body"--%>
                
                <div id="DataList" style="display: none;overflow:auto;">
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
    </div>
    
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>

    <asp:HiddenField ID="hdn_ccode" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdn_scode" runat="server" ClientIDMode="Static"/>
    <asp:HiddenField ID="hdn_ycode" runat="server" ClientIDMode="Static"/>

</asp:Content>

