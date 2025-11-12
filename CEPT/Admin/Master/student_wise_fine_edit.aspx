<%@ Page Title="Student Fine Modification" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_wise_fine_edit.aspx.cs" Inherits="Admin_Master_student_wise_fine_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">

        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();
            student_wise_fine_report();

            $('#btn_save').on('click', function () {

                var semeter_type = $('#drpsemester').val();
                if (semeter_type == "") {
                    bootbox.alert('Please select Semester')
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    bootbox.alert('Please select Year')
                    $('#drpyear').focus();
                    return false;
                }

                var user_id = $('#txtuserid').val();
                var remarks = $('#txtremark').val();
                var installmentfine = $('#txtinstallmentfine').val();
                var installment_no = $('#txtinstallmentno').val();

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/insert_update_fine_dtl",
                    async: false,
                    data: "{semeter_type : '" + semeter_type + "',year_code:'" + year_code + "',user_id:'" + user_id + "',remarks:'" + remarks + "',installmentfine:'" + installmentfine + "',installment_no:'" + installment_no + "'}",

                    dataType: "json",
                    success: function (data) {
                        var result = JSON.parse(data.d);

                        if (result["status"] != "") {
                            bootbox.alert('Data Saved successfully.');

                        }
                        else {
                            bootbox.alert(result["message"]);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                return false;

            });
            return false;
        });

        function bindsemdata() {

            // $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            var semester = $('#hdn_sem').val();
            if (semester == "S") {
                $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            }
            else {
                $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            }

            //$('#drpsemester').chosen();
        }

        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        //$('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            if (year_data[i]["year_desc"] == $('#hdn_year').val()) {
                                $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                            }
                        }
                        //$('#drpyear').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function student_wise_fine_report() {
            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }
            var user_id = $('#hdn_uid').val();
            var installment_no = $('#installment_no').val();
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    async: false,
                    url: "../../WebService.asmx/get_student_fine_dtl",
                    data: "{semester: '" + semester + "',year_code:'" + year_code + "',user_id:'" + user_id + "',installment_no:'" + installment_no + "'}",
                    dataType: "json",
                    success: function (data) {


                        if (data.d != "") {
                            Display_data(data.d);
                        }
                        else {
                            bootbox.alert('There is No data Found For Selected Semester');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function Display_data(data) {
            var semester_data = JSON.parse(data);
            $("#txtuserid").val(semester_data[0]['user_id']).attr('readonly', true);
            $("#txtinstallmentno").val(semester_data[0]['installment_no']).attr('readonly', true);
            $("#txtinstallmentfine").val(semester_data[0]['installment_fine']);
            $("#txtpaidinstallmentfine").val(semester_data[0]['paid_installment_fine']).attr('readonly', true);
            $("#txtpayslip").val(semester_data[0]['payslip_generated_date']).attr('readonly', true);
            $("#txtremark").val(semester_data[0]['remarks']);

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Fine Modification
            </h1>
        </div>

        <div class="panel panel-default" style="display: none">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Semester
                        </td>
                        <td>
                            <%--<select class="chosen-select" id="drpsemester">
                            </select>--%>
                        </td>
                        <td>Year 
                        </td>
                        <td>
                            <%-- <select class="chosen-select" id="drpyear">
                            </select>--%>
                        </td>
                        <td>
                            <%-- <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>--%>
                        </td>
                    </tr>

                </table>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Fine Details</strong>
            </div>
            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>Year 
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>

                    </tr>
                    <tr>
                        <td>User id
                        </td>
                        <td>
                            <input type="text" id="txtuserid" class="marg-btm" />

                        </td>
                        <td>Installment No
                        </td>
                        <td>
                            <input type="text" id="txtinstallmentno" class="marg-btm" />
                        </td>
                    </tr>
                    <tr>
                        <td>Installment Fine
                        </td>
                        <td>
                            <input type="text" id="txtinstallmentfine" class="marg-btm" />

                        </td>
                        <td>Paid Installment Fine
                        </td>
                        <td>
                            <input type="text" id="txtpaidinstallmentfine" class="marg-btm" />

                        </td>

                    </tr>
                    <tr>
                        <td>Payslip Generate Date
                        </td>
                        <td>
                            <input type="text" id="txtpayslip" class="marg-btm" />
                        </td>
                        <td>Remark
                        </td>
                        <td>
                            <textarea rows="2" cols="10" id="txtremark"></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btn_save">
                                Save
                            </button>
                        </td>

                    </tr>
                </table>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_sem" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_uid" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="installment_no" runat="server" ClientIDMode="Static" />

</asp:Content>

