<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="credits_detail_year_wise_edit.aspx.cs" Inherits="Admin_Master_credits_detail_year_wise_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        table td:nth-child(3)
        {
            padding-left: 40px;
        }
    </style>

    <script type="text/javascript">
        var oTable;

        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindprogrammedata();
            binddepartment();
            bindproglevel();
            get_credit_detail_year_wise();
        });

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

        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
            
            $('#drpprog').chosen();
        }

        function binddepartment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var sem_data = JSON.parse(data.d);

                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }

                        $('#drpdepartment').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindproglevel() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }

                        $('#drpproglevel').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_credit_detail_year_wise() {
            if ($('#hdn_y').val() != '' && $('#hdn_p').val() != '' && $('#hdn_d').val() != '') {
                $.ajax({
                    type: "POST",
                    url: "../../WebService.asmx/get_credit_detail_year_wise_edit",
                    data: "{year_code:'" + $('#hdn_y').val() + "',prog_code:'" + $('#hdn_p').val() + "',dept_code:'" + $('#hdn_d').val() + "',prog_level_code:'" + $('#hdn_pl').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != '' && data.d != '[]') {
                            var credit_dtl = JSON.parse(data.d);

                            $('#drpyear').val(credit_dtl[0]['year_code']);
                            $('#drpprog').val(credit_dtl[0]['prog_code']);
                            $('#drpdepartment').val(credit_dtl[0]['dept_code']);
                            $('#drpproglevel').val(credit_dtl[0]['prog_level_code']);
                            $('#txt_total_credits').val(credit_dtl[0]['total_credits']);
                            $('#txt_mandatory_credits').val(credit_dtl[0]['mandatory_credits']);
                            $('#txt_elective_credits').val(credit_dtl[0]['elective_credits']);
                            $('#txt_sws_credits').val(credit_dtl[0]['sws_credits']);

                            $('#drpyear').trigger('liszt:updated');
                            $('#drpprog').trigger('liszt:updated');
                            $('#drpdepartment').trigger('liszt:updated');
                            $('#drpproglevel').trigger('liszt:updated');
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });

                $('#div_button').html('<input type="button" id="btn_save" value="Save" class="btn btn-primary btn-small" onclick="return saveCreditsDetail(\'E\');" />');
            }
            else { 
                $('#div_button').html('<input type="button" id="btn_add" value="Add" class="btn btn-primary btn-small" onclick="return saveCreditsDetail(\'A\');" />');
            }
        }

        function saveCreditsDetail(action) {
            if ($('#drpyear').val() == '' || $('#drpprog').val() == '' || $('#drpdepartment').val() == '' || $('#txt_total_credits').val() == '' || $('#txt_mandatory_credits').val() == '' || $('#txt_elective_credits').val() == '' || $('#txt_sws_credits').val() == '') {
                bootbox.alert('Please Enter all mandatory fields');
                return false;
            }

            if (parseInt($('#txt_total_credits').val()) != (parseInt($('#txt_mandatory_credits').val()) + parseInt($('#txt_elective_credits').val()) + parseInt($('#txt_sws_credits').val()))) {
                bootbox.alert('Total Credits should be same as total of mandatory, elective and sws credits');
                return false;
            }

            var credit_data = { 'action': action, 'year_code': $('#drpyear').val(), 'prog_code': $('#drpprog').val(), 'dept_code': $('#drpdepartment').val(), 'prog_level_code': $('#drpproglevel').val(), 'total_credits': $('#txt_total_credits').val(), 'mandatory_credits': $('#txt_mandatory_credits').val(), 'elective_credits': $('#txt_elective_credits').val(), 'sws_credits': $('#txt_sws_credits').val(), 'old_year_code': $('#hdn_y').val(), 'old_prog_code': $('#hdn_p').val(), 'old_dept_code': $('#hdn_d').val(), 'old_prog_level_code': $('#hdn_pl').val() };

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/save_credit_detail_year_wise",
                data: "{credit_data:'" + JSON.stringify(credit_data) + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        bootbox.alert(data.d, function () {
                            location.href = 'credits_detail_year_wise.aspx';
                        });
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                //if (parseInt($(document.activeElement).val()) > 10) {
                //    return false;
                //}
                //else if (parseInt($(document.activeElement).val()) == 10) {
                //    if (keyCode != 48) {
                //        return false;
                //    }
                //}

                return true;
            }
            else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid" style="margin-top:10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Credits Detail Year Wise
            </h1>
        </div>
    </div>

    <div id="pnl_choose_credits" class="panel panel-default" style="margin-bottom:50px;">
        <div class="panel-heading">
            <strong>Edit Credits Detail</strong>
        </div>
        
        <div class="panel panel-body" align="center">
            <table cellpadding="10">
                <tr>
                    <td>Enrollment Year&nbsp;<span style="color: Red;">*</span></td>
                    <td>
                        <select id="drpyear"></select>
                    </td>
                    <td>Program&nbsp;<span style="color: Red;">*</span></td>
                    <td>
                        <select id="drpprog"></select>
                    </td>
                </tr>
                <tr>
                    <td>Department&nbsp;<span style="color: Red;">*</span></td>
                    <td>
                        <select id="drpdepartment"></select>
                    </td>
                    <td>Program Level</td>
                    <td>
                        <select id="drpproglevel"></select>
                    </td>
                </tr>
                <tr>
                    <td>Total Credits&nbsp;<span style="color: Red;">*</span></td>
                    <td>
                        <input type="text" id="txt_total_credits" onkeypress='return IsNumeric(event);' />
                    </td>
                    <td>Mandatory Credits&nbsp;<span style="color: Red;">*</span></td>
                    <td>
                        <input type="text" id="txt_mandatory_credits" onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>
                <tr>
                    <td>Elective Credits&nbsp;<span style="color: Red;">*</span></td>
                    <td>
                        <input type="text" id="txt_elective_credits" onkeypress='return IsNumeric(event);' />
                    </td>
                    <td>SWS Credits&nbsp;<span style="color: Red;">*</span></td>
                    <td>
                        <input type="text" id="txt_sws_credits" onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>
            </table>

            <div id="div_button">
            </div>
        </div>
    </div>

    <asp:HiddenField ID="hdn_y" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_p" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_d" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_pl" runat="server" ClientIDMode="Static" />
</asp:Content>

