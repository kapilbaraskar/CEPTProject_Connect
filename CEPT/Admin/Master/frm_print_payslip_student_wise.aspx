<%@ Page Title="CEPT - Print payslip" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_print_payslip_student_wise.aspx.cs" Inherits="Admin_Master_frm_print_payslip_student_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata();
            bindprogrammedata();
            binddepartment();
            //bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                print_payslip();
                return false;
            });

            $('#btn_retrieve').on('click', function () {
                print_payslip_new();
                return false;
            });

            $('#drpdepartment').on('change', function () {
                if ($('#drpdepartment').val() != '') {
                    if ($('#drpprog').val() != '') {
                        if ($('#drpyear').val() != '') {
                            //alert('Change');
                            $('#drpstudent').trigger("liszt:updated");
                            //$('#drpstudent').chosen();
                            //$('#drpstudent').html("");
                            bindallstudentdataforprintpayslip();
                        }
                    }
                }
                else {
                    $('#drpstudent').find('option').remove().end().append('<option value="">No Student found</option>').val('');
                    $('#drpstudent').chosen();
                    $('#drpstudent').val('').trigger("liszt:updated");
                }
            });

            $('#drpprog').on('change', function () {
                if ($('#drpprog').val() != '') {
                    if ($('#drpdepartment').val() != '') {
                        if ($('#drpyear').val() != '') {
                            //alert('Change');
                            $('#drpstudent').trigger("liszt:updated");
                            //$('#drpstudent').chosen();
                            //$('#drpstudent').html("");
                            bindallstudentdataforprintpayslip();
                        }
                    }
                }
                else {
                    $('#drpstudent').find('option').remove().end().append('<option value="">No Student found</option>').val('');
                    $('#drpstudent').chosen();
                    $('#drpstudent').val('').trigger("liszt:updated");
                }
            });

            $('#drpyear').on('change', function () {
                if ($('#drpyear').val() != '') {
                    if ($('#drpdepartment').val() != '') {
                        if ($('#drpprog').val() != '') {
                            //alert('Change');
                            $('#drpstudent').trigger("liszt:updated");
                            //$('#drpstudent').chosen();
                            //$('#drpstudent').html("");
                            bindallstudentdataforprintpayslip();
                        }
                    }
                }
                else {
                    $('#drpstudent').find('option').remove().end().append('<option value="">No Student found</option>').val('');
                    $('#drpstudent').chosen();
                    $('#drpstudent').val('').trigger("liszt:updated");
                }
            });

            return false;
        });

        function print_payslip() {
            if ($('#drpdepartment').val() == "") {
                bootbox.alert("Please select department.");
                return false;
            }

            if ($('#drpprog').val() == "") {
                bootbox.alert("Please select program.");
                return false;
            }

            if ($('#drpyear').val() == "") {
                bootbox.alert("Please select year of enrollement.");
                return false;
            }

            if ($('#drpstudent').val() == "") {
                bootbox.alert("Please select student.");
                return false;
            }

            if ($('#drp_fees').val() == "") {
                bootbox.alert("Please select student.");
                return false;
            }

            window.open('frm_print_popup.aspx?student=' + $('#drpstudent').val() + '&fees=' + $('#drp_fees').val() + '&amount=' + $('#txt_amount').val(), 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

            return false;
        }

        function print_payslip_new() {
            var dept_code = $('#drpdepartment').val();
            if ($('#drpdepartment').val() == "") {
                bootbox.alert("Please select Department.");
                return false;
            }

            var prog_code = $('#drpprog').val();
            if ($('#drpprog').val() == "") {
                bootbox.alert("Please select Program.");
                return false;
            }

            var year_code = $('#drpyear').val();
            if ($('#drpyear').val() == "") {
                bootbox.alert("Please select Year of Enrollment.");
                return false;
            }

            var stud_code = $('#drpstudent').val();
            if ($('#drpstudent').val() == "") {
                bootbox.alert("Please select Student.");
                return false;
            }

            //var installment_no = $('#drp_installment').val();
            //if (installment_no == "") {
            //    bootbox.alert('Please select Installment')
            //    $('#drp_installment').focus();
            //    return false;
            //}

            $('#hdn_drp_value').val(JSON.stringify({ dept_code: dept_code, prog_code: prog_code, year_code: year_code, stud_code: stud_code, installment_no: '', amount: $('#txt_amount').val() }));

            $('#hdn_download_icici').click();

            return false;
        }

        function IsNumeric(e) {
            //alert(e.which + " : " + e.keyCode);
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Print Payslip</h1>
        </div>
        <div class="space">
        </div>
        <div>
            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                            Department
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            Programme 
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                        <td>
                            Year of Enrollment
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                    </tr>

                    <tr style="display:none;">
                        <%--<td>
                            Student
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>--%>
                        <td>
                            Fees Type
                        </td>
                        <td>
                            <select class="chosen-select" id="drp_fees">
                                <option value="H">Half Fees</option>
                                <option value="F">Full Fees</option>
                            </select>
                        </td>
                        <%--<td>
                            Or Amount 
                        </td>
                        <td>
                            <input type="text" id="txt_amount" onkeypress='return IsNumeric(event);'/>
                        </td>--%>
                        <%--<td>
                            <button class="btn btn-primary" type="button" id="btnreterive">
                                Print
                            </button>
                        </td>--%>
                    </tr>
                    
                    <tr>
                        <td>
                            Student
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>
                        <td style="display:none;">
                            Installment
                        </td>
                        <td style="display:none;">
                            <select class="chosen-select" id="drp_installment">
                                <option value="1">Full / Half Fees / Installment 1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                            </select>
                        </td>
                        <td>
                            Amount(Optional)
                        </td>
                        <td>
                            <input type="text" id="txt_amount" onkeypress='return IsNumeric(event);'/>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btn_retrieve">
                                Print Pay-in slip
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    
    <div style="display: none;">
        <input type="hidden" runat="server" clientidmode="Static" id="hdn_drp_value" value="" />
        <asp:Button ID="hdn_download_icici" runat="server" ClientIDMode="Static" OnClick="Download_ICICI_Payslip" />
    </div>
</asp:Content>
