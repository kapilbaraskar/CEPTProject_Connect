<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Blood_Group.aspx.cs" Inherits="Student_Blood_Group" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            getBloodGroup();

            function getBloodGroup() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/check_user_by_user_id",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var student_data = JSON.parse(data.d)
                            if (student_data[0]["blood_group"] == "") {
                                $(".saved").css('display', 'none');
                            } else {
                                $(".unsaved").css('display', 'none');
                                $("#saved_blood_group").text(student_data[0]["blood_group"]);
                                $("#blood_group").val(student_data[0]["blood_group"]);
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            $('#btn_save').on('click', function () {
                saveData();
            });

            function saveData() {
                if ($("#blood_group").val() == "") {
                    alert("Please Select Blood Group");
                    return false;
                }
                var blood_group_data = $("#blood_group").val();

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Update_blood_group",
                    data: "{ blood_group : '" + blood_group_data + "'}",
                    async: false,
                    datatype: "json",
                    success: function (data) {
                        if (data.d != '' && data.d != '[]') {
                            var res = JSON.parse(data.d);
                            if (res["status"] == 'True') {
                                alert(res['message']);
                                getBloodGroup();
                            } else {
                                alert(res['message']);
                            }
                        }
                    },
                    Error: function (data) {
                        alert(data.d);
                    }
                });
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="div_blood_group">
        <h3 style="text-align: center;"><u>Blood Group Details</u></h3>
        <p style="text-align: center;">(<b>Note :</b> This information will be included in the university ID Card)</p>
        <h5 style="width: 100%;" class="saved">	• Your Blood Group is <b><span id="saved_blood_group" style="color: blue;"></span></b>.</h5>
        <h5 style="width: 100%;" class="unsaved"> • Your Blood Group is not selected yet. Please Submit Blood Group.</h5>
    </div>
    <br />
    <div style="">
        <div style="float: left;">
            <h5 style="width: 100%;" class="">• If this is not your correct blood group, select to change : &nbsp;&nbsp;</h5>
        </div>
        <div style="float: left; margin-top: 7px; width: 17%;">
            <select id="blood_group" style="width: 100%;">
                <option value="">-- Select Blood Group --</option>
                <option value="A+">A+ (A Positive)</option>
                <option value="A-">A- (A Negative)</option>
                <option value="B+">B+ (B Positive)</option>
                <option value="B-">B- (B Negative)</option>
                <option value="O+">O+ (O Positive)</option>
                <option value="O-">O- (O Negative)</option>
                <option value="AB+">AB+ (AB Positive)</option>
                <option value="AB-">AB- (AB Negative)</option>
            </select>
        </div>
    </div>
    <div id="div_button" style="text-align: center; float: none; margin-top: 5%;" class="blood_group_form">
        <input type="button" id="btn_save" value="Submit" class="btn btn-primary" />
    </div>
</asp:Content>

