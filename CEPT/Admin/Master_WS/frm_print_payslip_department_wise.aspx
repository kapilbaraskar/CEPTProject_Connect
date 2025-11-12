<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_print_payslip_department_wise.aspx.cs" Inherits="Admin_Master_frm_print_payslip_department_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            bindwssemdata();
            //bindwsyeardata();
            bindyeardata();
            bindAllocationYear();
            bindprogrammedata();
            binddepartment();
            //bindyeardata_for_cross_reg();
            bindfeestype();
            function bindfeestype() {
                $('#drpfees_type').empty().append($("<option></option>").val("").html("-- Please Select Fees Type --"));
                $('#drpfees_type').append($("<option></option>").val("manually").html("Manually"));
                $('#drpfees_type').append($("<option></option>").val("online").html("Online"));
                $('#drpfees_type').chosen();
            }
            
            $('#btnreterive').on('click', function () {
                print_payslip();
                return false;
            });

            function bindwssemdata() {
                $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
                $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

                $('#drpsemester').chosen();
            }

            //            $('#drpdepartment').on('change', function () {

            //                if ($('#drpdepartment').val() != '') {
            //                    if ($('#drpprog').val() != '') {
            //                        if ($('#drpyear').val() != '') {
            //                            //                        alert('Change');
            //                            $('#drpstudent').trigger("liszt:updated");
            //                            //                        $('#drpstudent').chosen();
            //                            //                        $('#drpstudent').html("");
            //                            bindallstudentdataforprintpayslip();
            //                        }

            //                    }
            //                }
            //                else {

            //                    $('#drpstudent')
            //                .find('option')
            //                .remove()
            //                .end()
            //                .append('<option value="">No Student found</option>')
            //                .val('');
            //                    $('#drpstudent').chosen();

            //                    $('#drpstudent').val('').trigger("liszt:updated");
            //                }

            //            });

            //            $('#drpprog').on('change', function () {

            //                if ($('#drpprog').val() != '') {
            //                    if ($('#drpdepartment').val() != '') {

            //                        if ($('#drpyear').val() != '') {
            //                            //                        alert('Change');
            //                            $('#drpstudent').trigger("liszt:updated");
            //                            //                        $('#drpstudent').chosen();
            //                            //                        $('#drpstudent').html("");
            //                            bindallstudentdataforprintpayslip();
            //                        }

            //                    }
            //                }
            //                else {

            //                    $('#drpstudent')
            //                .find('option')
            //                .remove()
            //                .end()
            //                .append('<option value="">No Student found</option>')
            //                .val('');
            //                    $('#drpstudent').chosen();

            //                    $('#drpstudent').val('').trigger("liszt:updated");
            //                }

            //            });

            //            $('#drpyear').on('change', function () {

            //                if ($('#drpyear').val() != '') {
            //                    if ($('#drpdepartment').val() != '') {
            //                        if ($('#drpprog').val() != '') {

            //                            //                        alert('Change');
            //                            $('#drpstudent').trigger("liszt:updated");
            //                            //                        $('#drpstudent').chosen();
            //                            //                        $('#drpstudent').html("");
            //                            bindallstudentdataforprintpayslip();
            //                        }

            //                    }
            //                }
            //                else {

            //                    $('#drpstudent')
            //                .find('option')
            //                .remove()
            //                .end()
            //                .append('<option value="">No Student found</option>')
            //                .val('');
            //                    $('#drpstudent').chosen();

            //                    $('#drpstudent').val('').trigger("liszt:updated");
            //                }

            //            });

            return false;
        });

        function print_payslip() {
            if ($('#drpdepartment').val() == "") {
                bootbox.alert("Please select department.");
                $('#drpdepartment').focus();
                return false;
            }
            if ($('#drpfees_type').val() == "") {
                bootbox.alert("Please select fees type.");
                $('#drpfees_type').focus();
                return false;
            }

            //if ($('#drpprog').val() == "") {
            //    bootbox.alert("Please select program.");
            //    return false;
            //}

            //if ($('#drpyear').val() == "") {
            //    bootbox.alert("Please select year of enrolment.");
            //    return false;
            //}

            if ($('#drpfees_type').val() == "manually") {
                if ($('#drpyear').val() == "") {
                    bootbox.alert("Please select year of enrolment.");
                    return false;
                }
            } else {

                if ($('#drpsemester').val() == "") {

                    bootbox.alert("Please select semester.");
                    $('#drpsemester').focus();
                    return false;
                }
                if ($('#drpyearallo').val() == "") {

                    bootbox.alert("Please select year of allocation.");
                    $('#drpyearallo').focus();
                    return false;
                }
            }
            if ($('#drpfees_type').val() == "manually") {
                window.open('frm_print_department_popup.aspx?dept_code=' + $('#drpdepartment').val() + '&prog_code=' + $('#drpprog').val() + '&year_code=' + $('#drpyear').val() + '&fees_type=' + $('#drpfees_type').val(), 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
            } else if ($('#drpfees_type').val() == "online") {
                debugger;
                window.open('Print_frm_print_department_popup.aspx?semester=' + $('#drpsemester').val() + '&year_code_alloc=' + $('#drpyearallo').val() + '&dept_code=' + $('#drpdepartment').val() + '&prog_code=' + $('#drpprog').val() + '&year_code=' + $('#drpyear').val() + '&fees_type=' + $('#drpfees_type').val(), 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
            }

            return false;

        }

        function bindAllocationYear() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/Get_year_data",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpyearallo').empty().append($("<option></option>").val("").html("-- Please Select Year --"));

                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyearallo').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyearallo').chosen();
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
    <div class="clearfix">
<%--<p>kamlesh</p>
<p>Nada</p>--%>
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Print Payslip</h1>
        </div>
        <div class="space">
        </div>
        <div>
          <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div style="padding: 2%;">
                <table border="0" cellpadding="3" cellspacing="5">
                    <tr>
                        <td>
                            Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            Programme :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                        <td>
                            year of enrolment:
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <%--<td>
                            Student :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>--%>
                        <td>
                            Fees type :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpfees_type">
                            </select>
                        </td>
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
                            <select class="chosen-select" id="drpyearallo">
                            </select>
                        </td>
                    </tr>
                </table>
                <div style="text-align: center;margin-top: 2%;">
                       <button class="btn btn-primary" type="submit" id="btnreterive" style="line-height:30px;">
                                Print Payslip
                            </button>
                </div>
            </div>
              </div>
        </div>
    </div>
</asp:Content>

