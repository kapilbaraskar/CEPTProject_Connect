<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="select_program.aspx.cs" Inherits="Student_select_program" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

<script type="text/javascript">

    function check() {
        var return_false = false;
        bootbox.confirm("Are you sure you want to save?", function (result) {
            return_false = result;
        });

        if (!return_false)
            return return_false;
    }
</script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="span8" style="margin-left: 60px">
            <div class="row">
                <div>
                    <div class="widget-box">
                        <div class="widget-header widget-header-flat">
                            <h4 class="smaller">
                            </h4>
                            <%--   <div class="widget-toolbar">
                                            <label>
                                                <small class="green"><b>Horizontal</b> </small>
                                                <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                                <span class="lbl"></span>
                                            </label>
                                        </div>--%>
                        </div>
                        <div class="widget-body">
                            <div style="font-size: 17px" class="widget-main">
                                <table>
                                    <tr>
                                        <td>
                                            You have been selected for the following program/s. Please save the program you
                                            wish to pay fees for. Please note that you may not be able to change your choice
                                            once you save the data. (You will be logged out and need to login again to pay the
                                            fees)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                </table>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:HiddenField ID="hdn_mail" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td id="drp_program" runat="server" clientidmode="Static">
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Button ID="btn_save_program" Width="100px" runat="server" class="btn btn-lg btn-primary"
                                                Text="Save" OnClientClick="return confirm('Are you sure you want to save?');" OnClick="btn_save_program_Click" />
                                                <%--  <asp:Button ID="btn_save_program" Width="100px" runat="server" class="btn btn-lg btn-primary"
                                                Text="Save" OnClientClick="return check();" OnClick="btn_save_program_Click" />--%>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="space-6">
            </div>
        </div>
    </div>
</asp:Content>
