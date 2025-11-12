<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="DecryptPassword.aspx.cs" Inherits="Admin_Master_DecryptPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('#btnreterive').on('click', function () {

                var pass = $('#txt_password').val();

                if (pass == '') {

                    bootbox.alert('Please Enter Encrypt password');
                    return false;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_decrypt_password",
                    async: false,
                    data: "{enc_password : '" + $('#txt_password').val() + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "") {




                            $('#lbl_dec_password').text(data.d);


                            return false;


                        }
                        else {


                        }


                    },
                    error: function (result) {
                        alert('error');
                    }
                });
                return false;
            });

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table cellpadding="3" cellspacing="5">
            <tr>
                <td>
                    Enter Encrypt Password :
                </td>
                <td>
                    <input type="text" id="txt_password" />
                </td>
                <td>
                     <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Get Password
                                </button>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
                <td>
                    Your Password is :

                </td>
                <td>
                 <label id="lbl_dec_password">
                    </label>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
