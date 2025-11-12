<%@ Page Title="Instructor Master" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_instructor_mst.aspx.cs" Inherits="Admin_Master_frm_instructor_mst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/instructor_mst_11042017.js?t=21062022" type="text/javascript"></script><%--15042020--%>
    <%--05102019--%>
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <style type="text/css">
        .img-thumbnail {
            display: inline-block;
            max-width: 100%;
            height: auto;
            padding: 4px;
            line-height: 1.42857143;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            -webkit-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }

        .file-upload input {
            position: absolute;
            top: 0;
            left: 0;
            margin: 0;
            font-size: 10pt;
            opacity: 0;
        }

        .wysiwyg_viewer_skins_button_BasicButtonb1-link {
            border-radius: 0px;
            position: absolute;
            top: 0px;
            bottom: 0px;
            left: 0px;
            right: 0px;
            background-color: rgb(102, 102, 102);
            transition: border-color 0.4s ease 0s, background-color 0.4s ease 0s;
            -webkit-transition: border-color 0.4s ease 0s, background-color 0.4s ease 0s;
            box-shadow: rgba(0, 0, 0, 0.6) 0px 1px 4px 0px;
        }

        .wysiwyg_viewer_skins_button_BasicButtonb1-label {
            font: normal normal normal 13px/1.3em arial, 'ｍｓ ｐゴシック', 'ms pgothic', 돋움, dotum, helvetica, sans-serif;
            transition: color 0.4s ease 0s;
            -webkit-transition: color 0.4s ease 0s;
            color: rgb(255, 255, 255);
            white-space: nowrap;
            margin: 0px;
            display: inline-block;
            position: relative;
        }

        .required {
            color: Red;
        }

        .add_update_label {
            vertical-align: top;
        }

        .add_update_input {
            padding-left: 0;
            padding-right: 0;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-header position-relative">
        <h1>
            <i class="icon-desktop"></i>&nbsp;Instructor Master
        </h1>
    </div>

    <div id="div_add_new" class="panel panel-default" style="display: none;">
        <div class="panel-heading">
            <strong>Add/Update Instructor</strong>
        </div>

        <div>
            <table cellpadding="10">
                <tr>
                    <td class="add_update_label">
                        <span class="lable_name">Add new Instructor</span>
                    </td>
                    <td class="add_update_input">
                        <input type="text" id="txt_instructor_name" />
                        <input type="hidden" id="hdn_instructor_code" />
                    </td>
                    <td class="add_update_label">
                        <span>Login Email</span>
                    </td>
                    <td class="add_update_input">
                        <input type="text" id="txt_mail" />
                    </td>
                    <td class="add_update_label">
                        <span>User Type</span>
                    </td>
                    <td class="add_update_input">
                        <select id="drp_user_type">
                            <option value="I2">Instructor</option>
                            <option value="PC">Program Coordinator</option>
                            <option value="D">Dean</option>
                            <option value="VF">VF</option>
                            <option value="AA">AA</option>
                            <option value="AUVF">AUVF</option>
                            <%--<option value="TA">TA</option>--%>
                            <option value="TEA">TEA</option>
                            <option value="temp">Temp</option>
                        </select>
                    </td>
                    <td style="padding-right: 0;">
                        <button class="btn btn-primary" type="submit" id="btn_save">Save</button>
                    </td>
                   <%-- <td>
                        <button class="btn btn-primary" type="submit" id="btn_reset">Reset</button>
                    </td>--%>
                </tr>
                <tr id="tea_id">
                    <td colspan="7">
                        <%--<input type="checkbox" id="tea_value" value="tea_data" />--%>
                        <input type="checkbox" id="tea_status" style="margin-bottom: 5px; margin-left: 6px;" /> Teaching Associate
                    </td>
                    <%--<td><span style="margin-left: -62px;">Teaching Associate</span></td>--%>
                </tr>
            </table>
        </div>
    </div>

    <div id="div_instructor_dtl" class="panel panel-default" style="display: block; margin-bottom: 30px;">
        <div class="panel-heading">
            <strong>Instructor Detail</strong>
        </div>
        <div id="DataList" style="display: none;">
            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>






<%--<%@ Page Title="Instructor Master" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_instructor_mst.aspx.cs" Inherits="Admin_Master_frm_instructor_mst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/instructor_mst_11042017.js" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="page-header position-relative">
        <h1>
            <i class="icon-desktop"></i>&nbsp;Instructor Master
        </h1>
    </div>

    <div class="panel panel-default ">
        <div class="panel-heading">
            <strong>Add / Update Instructor</strong>
        </div>

        <div>
            <table style="width:80%;" cellpadding="10">
                <tr>
                    <td>
                        <span class="lable_name">Add new Instructor</span>
                    </td>
                    <td>
                        <input type="text" id="txt_instructor_name" />
                        <input type="hidden" id="hdn_instructor_code" />
                    </td>
                    <td>
                        <span>Login Email</span>
                    </td>
                    <td>
                        <input type="text" id="txt_mail" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>User Type</span>
                    </td>
                    <td>
                        <select id="drp_user_type">
                            <option value="I2">Instructor</option>
                            <option value="PC">Program Coordinator</option>
                            <option value="D">Dean</option>
                            <option value="VF">VF</option>
                            <option value="AA">AA</option>
                            <option value="AUVF">AUVF</option>
                            <option value="TA">TA</option>
                        </select>
                    </td>
                    <td>
                        <button class="btn btn-primary" type="submit" id="btn_save">Save</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button class="btn btn-primary" type="submit" id="btn_reset">Reset</button>
                        <%--<asp:Button id="btn" runat="server" onclick="btn_Click"/>--%
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div class="panel panel-default ">
        <div class="panel-heading">
            <strong>Instructor Detail</strong>
        </div>

        <div id="DataList" style="display:none;">
            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
--%>