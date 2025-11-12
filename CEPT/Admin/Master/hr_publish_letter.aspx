<%@ Page Title="Publish Letters" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="hr_publish_letter.aspx.cs" Inherits="Admin_Master_hr_publish_letter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/hr_publish_letter.js?t=17062022" type="text/javascript"></script><%--29122018--%><%--04072019--%><%--28012020--%>
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    
    <style type="text/css">
        .cls_hide
        {
            display:none;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Publish Letters
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
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
                                    Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    Programme :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                   <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                                <td>
                                    Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                                </tr>
                            <tr>
                                <td colspan="8">
                                    <button class="btn btn-primary" id="btnreterive"> Retrieve</button>
                                    <button class="btn btn-primary" id="btngenerateletter">Generate Letter</button>
                                    <button class="btn btn-primary" id="btn_print_letter_all" onclick="update_letter()"> Update Letter</button>
                                    <button class="btn btn-primary" id="btndownload"> Download</button>
                                   
                                </td>
                                <%--<td>
                                    <input id="cb" type="checkbox" >
                                </td>--%>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Publish Letters</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
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
    </div>
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center; display: none;">
                    <table style='width: 100%'>
                        <tr>
                            <td align='right' style='padding-left: 20px;'>
                                <%--<asp:Button ID='btn_print_letter_all' class="btn btn-primary" runat="server" Text="Update"
                                    OnClick="Btn_Print_Letters_All_Click" Style="height: 40px;" />--%>
                                <button type="button" id="btn_print_letter_all" class="btn btn-primary"
                                    onclick="update_letter()" >
                                    Update Letter</button>
                            </td>
                            <td align='left' style='padding-left: 40px;'>
                            <%--<td align='center'>--%>
                                <%--<asp:Button ID="Button1" class="btn btn-primary" runat="server" Text="Send it to All" OnClick="Btn_Send_Mail_All_Click" style="height: 40px;"/>--%>
                                <%--<button type="button" id="btn_send_mail_all" class="btn btn-primary" style="height: 40px;"--%>
                                <button type="button" id="btn_send_mail_all" class="btn btn-primary"
                                    onclick="send_it_to_all()">
                                    Send it to All</button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>
    <div style="display: none;">
        <input type="hidden" id="hdn_instructor" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_instructor_name" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_All_instructor" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_dept" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_tea_letter" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_usrType" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_prog_code" runat="server" clientidmode="Static" />
        <asp:Button ID="hdn_print_letter" runat="server" ClientIDMode="Static" OnClick="Btn_Print_Letter_Click" />
        <asp:Button ID="hdn_send_mail" runat="server" ClientIDMode="Static" OnClick="Btn_Send_Mail_Click" />
    </div>
</asp:Content>
