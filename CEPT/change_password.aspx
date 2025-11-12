<%@ Page Title="Change Password - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="change_password.aspx.cs" Inherits="change_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            $('#btnsave').on('click', function () {

                var oldpass = $('#txt_oldpass').val();

                var newpass = $('#txt_newpass').val();

                var confirm_pass = $('#txt_confirmpass').val();

                if (oldpass == '') {

                    bootbox.alert('Please enter Old password');
                    return false;
                }
                if (newpass == '') {

                    bootbox.alert('Please enter New password');
                    return false;
                }

                if (confirm_pass == '') {

                    bootbox.alert('Please enter Confirm password');
                    return false;

                }
                if (newpass == oldpass) {
                    bootbox.alert('old Password and New Password is same.please enter other password');
                    return false;
                }
                if (newpass != confirm_pass) {
                    bootbox.alert('New Password is not match with Confirm Password');
                    return false;
                }
                var data = {};
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebService.asmx/save_changed_password",

                    data: "{oldPassword:'" + oldpass + "' , Password :'" + newpass + "'}",
                    dataType: "json",
                    success: function (data) {
                        bootbox.alert(data.d);

                        $('#txt_oldpass').val('');

                        $('#txt_newpass').val('');

                        $('#txt_confirmpass').val('');
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
                return false;
            });

        });
     
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Change Password
            </h1>
        </div>
        <div class="container">
            <div class="col-sm-10 span4" style="margin-left: 350px">
                <div class="widget-box">
                    <div class="widget-header widget-header-flat">
                        <h4 class="smaller">
                            <i class=""></i>Change Password
                        </h4>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main">
                            <table width="100%" border="0" cellpadding="2" cellspacing="5">
                                <tr>
                                    <td align="center">
                                        <label>
                                            Old Password</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <input type="password" id="txt_oldpass">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <label>
                                            New Password</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <input type="password" id="txt_newpass">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <label>
                                            Confirm Password</label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <input type="password" id="txt_confirmpass">
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center">
                                        <button class="btn btn-primary" style="display: block" type="submit" id="btnsave">
                                            <i class="icon-save bigger-160"></i>Change
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <table width="100%" border="0" cellpadding="10" cellspacing="5">
            <tr>
                <td align="right">
                    <button class="btn btn-primary" style="display: none" type="submit" id="btn_assign">
                        <i class="icon-save bigger-160"></i>Assign Course
                    </button>
                </td>
                <td align="left">
                    <button class="btn btn-primary" style="display: none" type="submit" id="btn_remove">
                        <i class="icon-save bigger-160"></i>Remove Old Allocation
                    </button>
                </td>
            </tr>
        </table>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>
