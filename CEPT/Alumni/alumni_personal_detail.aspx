<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAlumini.master" AutoEventWireup="true"
    CodeFile="alumni_personal_detail.aspx.cs" Inherits="Alumni_alumni_personal_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            bindyeardata();
            bindprogdata();
            bindcountrydata();
            bindstatedata();

            get_alumni_personal_data();

            $('#btn_save').on('click', function () {
                save_alumni_personal_data();
            });

            $('#drpprog').on('change', function () {
                if ($('#drpprog').val() == 'O') {
                    $('#tr_txt_other_prog').css('display', '');
                }
                else {
                    $('#tr_txt_other_prog').css('display', 'none');
                }
            });

            $('#txt_work_country').on('change', function () {
                if ($('#txt_work_country').val() == 'IN') {
                    $('#drp_work_state_chzn').css('display', '');
                    $('#txt_work_state').css('display', 'none');
                }
                else {
                    $('#drp_work_state_chzn').css('display', 'none');
                    $('#txt_work_state').css('display', '');
                }
            });

            $('#txt_home_country').on('change', function () {
                if ($('#txt_home_country').val() == 'IN') {
                    $('#drp_home_state_chzn').css('display', '');
                    $('#txt_home_state').css('display', 'none');
                }
                else {
                    $('#drp_home_state_chzn').css('display', 'none');
                    $('#txt_home_state').css('display', '');
                }
            });
        });

        function bindyeardata() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_alumini_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d);
                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindprogdata() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_alumini_prog_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d);
                        $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpprog').append($("<option></option>").val(year_data[i]["prog_level_code"]).html(year_data[i]["prog_level_name"]));
                        }

                        $('#drpprog').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindcountrydata() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_country_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var country_data = JSON.parse(data.d);

                        $('#txt_home_country').empty().append($("<option></option>").val("").html("-- Please Select Country --"));
                        $('#txt_work_country').empty().append($("<option></option>").val("").html("-- Please Select Country --"));

                        for (var i = 0; i < country_data.length; i++) {
                            $('#txt_home_country').append($("<option></option>").val(country_data[i]["id"]).html(country_data[i]["name"]));
                            $('#txt_work_country').append($("<option></option>").val(country_data[i]["id"]).html(country_data[i]["name"]));
                        }

                        $('#txt_home_country').chosen();
                        $('#txt_work_country').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindstatedata() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_state_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var country_data = JSON.parse(data.d);

                        $('#drp_home_state').empty().append($("<option></option>").val("").html("-- Please Select State --"));
                        $('#drp_work_state').empty().append($("<option></option>").val("").html("-- Please Select State --"));

                        for (var i = 0; i < country_data.length; i++) {
                            $('#drp_home_state').append($("<option></option>").val(country_data[i]["state_code"]).html(country_data[i]["state_name"]));
                            $('#drp_work_state').append($("<option></option>").val(country_data[i]["state_code"]).html(country_data[i]["state_name"]));
                        }

                        $('#drp_home_state').css('display', '');
                        $('#drp_work_state').css('display', '');
                        $('#drp_home_state').chosen();
                        $('#drp_work_state').chosen();
                        $('#drp_home_state_chzn').css('display', 'none');
                        $('#drp_work_state_chzn').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                return true;
            }
            else {
                return false;
            }
        }

        function add_more_email() {
            $('#tbl_invite_friend tbody').append('<tr><td style="width:20%;"></td><td style="width:30%;"><input type="text" class="txt_invite_friend" /></td><td style="width:20%;"></td><td style="width:30%;"></td></tr>');
        }

        function get_alumni_personal_data() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/get_alumni_personal_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var response = JSON.parse(data.d);

                        $('#txt_user_name').val(response[0].user_name);
                        $('#txt_first_name').val(response[0].first_name);
                        $('#txt_middle_name').val(response[0].middle_name);
                        $('#txt_last_name').val(response[0].last_name);
                        $('#drpprog').val(response[0].prog_level_code);
                        $('#drpyear').val(response[0].year_code);
                        $('#txt_roll_no').val(response[0].user_id);
                        $('#txt_occupation').val(response[0].occupation);
                        $('#txt_title').val(response[0].title);
                        $('#txt_organisation').val(response[0].organisation);
                        $('#login_email').val($('#hdn_login_email').val());
                        $('#alternate_email').val(response[0].alternate_mail);

                        $('#txt_home_address').val(response[0].home_address);
                        $('#txt_home_city').val(response[0].home_city);
                        $('#txt_home_country').val(response[0].home_country);
                        if (response[0].home_country == "IN") {
                            $('#drp_home_state').val(response[0].home_state);
                            $('#drp_home_state_chzn').css('display', '');
                            $('#txt_home_state').css('display', 'none');
                        }
                        else {
                            $('#txt_home_state').val(response[0].home_state);
                        }

                        $('#txt_work_address').val(response[0].work_address);
                        $('#txt_work_city').val(response[0].work_city);
                        $('#txt_work_country').val(response[0].work_country);
                        if (response[0].work_country == "IN") {
                            $('#drp_work_state').val(response[0].work_state);
                            $('#drp_work_state_chzn').css('display', '');
                            $('#txt_work_state').css('display', 'none');
                        }
                        else {
                            $('#txt_work_state').val(response[0].work_state);
                        }

                        $('#txt_phone_no').val(response[0].phone_no);
                        $('#txt_mobile_no').val(response[0].mobile_no);

                        if (response[0].prog_level_code == 'O')
                            $('#tr_txt_other_prog').css('display', '');

                        if (response[0].subscribe_newsletter == "Y") $('#chk_subscribe')[0].checked = true;
                        else $('#chk_subscribe')[0].checked = false;

                        $('#drpprog').trigger("liszt:updated");
                        $('#drpyear').trigger("liszt:updated");
                        $('#txt_home_country').trigger("liszt:updated");
                        $('#txt_work_country').trigger("liszt:updated");
                        $('#drp_home_state').trigger("liszt:updated");
                        $('#drp_work_state').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function save_alumni_personal_data() {

            var obj_data = {};

            obj_data.roll_no = $('#txt_roll_no').val();
            obj_data.user_name = $('#txt_user_name').val();
            obj_data.first_name = $('#txt_first_name').val();
            obj_data.middle_name = $('#txt_middle_name').val();
            obj_data.last_name = $('#txt_last_name').val();
            obj_data.prog_level_code = $('#drpprog').val();

            if ($('#drpprog').val() == 'O') {
                if ($('#txt_other_prog').val() == '') {
                    bootbox.alert("Please Enter Program Title");
                    return;
                }

                obj_data.other_prog = $('#txt_other_prog').val();
            }

            obj_data.year_code = $('#drpyear').val();
            obj_data.occupation = $('#txt_occupation').val();
            obj_data.title = $('#txt_title').val();
            obj_data.organisation = $('#txt_organisation').val();
            obj_data.alternate_mail = $('#alternate_email').val();

            obj_data.home_address = $('#txt_home_address').val();
            obj_data.home_city = $('#txt_home_city').val();
            obj_data.home_country = $('#txt_home_country').val();
            obj_data.home_state = '';
            if ($('#txt_home_country').val() == "IN") obj_data.home_state = $('#drp_home_state').val();
            else obj_data.home_state = $('#txt_home_state').val();

            obj_data.work_address = $('#txt_work_address').val();
            obj_data.work_city = $('#txt_work_city').val();
            obj_data.work_country = $('#txt_work_country').val();
            obj_data.work_state = '';
            if ($('#txt_work_country').val() == "IN") obj_data.work_state = $('#drp_work_state').val();
            else obj_data.work_state = $('#txt_work_state').val();

            obj_data.phone_no = $('#txt_phone_no').val();
            obj_data.mobile_no = $('#txt_mobile_no').val();

            //obj_data.invite_friend = $('#txt_invite_friend').val();
            obj_data.invite_friend = '';
            if ($('.txt_invite_friend').length > 0) {
                for (var i = 0; i < $('.txt_invite_friend').length; i++) {
                    if ($('.txt_invite_friend')[i].value != '') {
                        if (i != 0) obj_data.invite_friend = obj_data.invite_friend + '~';
                        obj_data.invite_friend = obj_data.invite_friend + $('.txt_invite_friend')[i].value;
                    }
                }
            }

            obj_data.subscribe_newsletter = "N";
            if ($('#chk_subscribe')[0].checked) obj_data.subscribe_newsletter = "Y";

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/save_alumni_personal_data",
                async: false,
                data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var response = JSON.parse(data.d);

                        if (response['status'] == 'True') {
                            bootbox.alert(response['message'], function () {
                                location.reload();
                            });
                        }
                        else if (response['status'] == 'False') {
                            bootbox.alert(response['message']);
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function send_alumni_invite_friend_mail() {

            var obj_data = {};

            obj_data.roll_no = $('#txt_roll_no').val();
            obj_data.user_name = $('#txt_user_name').val();

            obj_data.invite_friend = '';
            if ($('.txt_invite_friend').length > 0) {
                for (var i = 0; i < $('.txt_invite_friend').length; i++) {
                    if ($('.txt_invite_friend')[i].value != '') {
                        if (i != 0) obj_data.invite_friend = obj_data.invite_friend + '~';
                        obj_data.invite_friend = obj_data.invite_friend + $('.txt_invite_friend')[i].value;
                    }
                }
            }

            if (obj_data.invite_friend == '') {
                bootbox.alert('Please enter your friends Email Id to send invitation');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/send_alumni_invite_friend_mail",
                async: false,
                data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var response = JSON.parse(data.d);
                        bootbox.alert(response['message']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Personal Detail
            </h1>
        </div>
        <div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Personal Detail</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_personal_detail1" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">
                                First Name
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_first_name" />
                            </td>
                            <td style="width: 20%;">
                                Middle Name
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_middle_name" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">
                                Last Name
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_last_name" />
                            </td>
                            <td style="width: 20%;">
                                Name
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_user_name" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Year of Commencement
                            </td>
                            <td>
                                <select id="drpyear">
                                </select>
                            </td>
                             <td>
                                Roll No.
                            </td>
                            <td>
                                <input type="text" id="txt_roll_no" disabled />
                            </td>
                            
                        </tr>
                        <tr id="tr_txt_other_prog" style="display: none;">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <input type="text" id="txt_other_prog" />
                            </td>
                        </tr>
                        <tr>
                        <td style="width: 20%;">
                                Program Title
                            </td>
                            <td style="width: 30%;">
                                <select id="drpprog">
                                </select>
                            </td>
                            <td>
                                Occupation
                            </td>
                            <td>
                                <input type="text" id="txt_occupation" />
                            </td>
                            
                        </tr>
                        <tr>
                        <td>
                                Title
                            </td>
                            <td>
                                <input type="text" id="txt_title" />
                            </td>
                            <td>
                                Company/Organisation
                            </td>
                            <td>
                                <input type="text" id="txt_organisation" />
                            </td>
                           
                        </tr>
                    </table>
                </div>
            </div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Communication Preferences</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_communication_preferences" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">
                                Email Id
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="login_email" disabled />
                            </td>
                            <td style="width: 20%;">
                                Alternate Email Id
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="alternate_email" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>Home Address</td>
                            <td>
                                <input type="text" id="txt_home_address" />
                            </td>
                            <td>Home City</td>
                            <td>
                                <input type="text" id="txt_home_city" />
                            </td>
                        </tr>--%>
                        <tr>
                            <td>
                                Home Address
                            </td>
                            <td colspan="3">
                                <textarea id="txt_home_address" rows="2" style="width: 86%"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Home City
                            </td>
                            <td>
                                <input type="text" id="txt_home_city" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Home Country
                            </td>
                            <td>
                                <%--<input type="text" id="txt_home_country" />--%>
                                <select id="txt_home_country">
                                </select>
                            </td>
                            <td>
                                Home State
                            </td>
                            <td>
                                <input type="text" id="txt_home_state" />
                                <select id="drp_home_state" style="display: none;">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>
                        <%--<tr>
                            <td>Work Address</td>
                            <td>
                                <input type="text" id="txt_work_address" />
                            </td>
                            <td>Work City</td>
                            <td>
                                <input type="text" id="txt_work_city" />
                            </td>
                        </tr>--%>
                        <tr>
                            <td>
                                Work Address
                            </td>
                            <td colspan="3">
                                <textarea id="txt_work_address" rows="2" style="width: 86%"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Work City
                            </td>
                            <td>
                                <input type="text" id="txt_work_city" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Work Country
                            </td>
                            <td>
                                <%--<input type="text" id="txt_work_country" />--%>
                                <select id="txt_work_country">
                                </select>
                            </td>
                            <td>
                                Work State
                            </td>
                            <td>
                                <input type="text" id="txt_work_state" />
                                <select id="drp_work_state" style="display: none;">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Phone No
                            </td>
                            <td>
                                <input type="text" id="txt_phone_no" onkeypress="return IsNumeric(event);" />
                            </td>
                            <td>
                                Mobile No
                            </td>
                            <td>
                                <input type="text" id="txt_mobile_no" onkeypress="return IsNumeric(event);" />
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-top: 10px;" colspan="4">
                                <input type="checkbox" id="chk_subscribe" />&nbsp;&nbsp;I would like to subscribe
                                to the newsletter
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Invite your friends</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_invite_friend" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">
                                Enter Email ID
                            </td>
                            <td style="width: 30%;">
                                <%--<input type="text" id="txt_invite_friend" />--%>
                                <input type="text" class="txt_invite_friend" />
                            </td>
                            <td style="width: 20%;">
                                <button id="btn_add_more" type="button" class="btn btn-lg btn-primary" style="margin-left: -60px;"
                                    onclick="add_more_email()">
                                    Add More</button>
                                <button id="btn_send_email" type="button" class="btn btn-lg btn-primary" style="margin-left: 10px;"
                                    onclick="return send_alumni_invite_friend_mail()">
                                    Send</button>
                            </td>
                            <td style="width: 30%;">
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="margin-top: 30px;" align="center">
                <button id="btn_save" type="button" class="btn btn-lg btn-primary" style="margin-left: -60px;">
                    Submit</button>
            </div>
        </div>
    </div>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_login_email" />
</asp:Content>
