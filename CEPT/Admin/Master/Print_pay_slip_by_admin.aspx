<%@ Page Title="Print Payslip - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="Print_pay_slip_by_admin.aspx.cs" Inherits="Admin_Master_Print_pay_slip_by_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            //bindyeardata();
            ////bindprogrammedata();
            ////binddepartment();

            bindsemdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
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

                var installment_no = $('#drp_installment').val();
                if (installment_no == "") {
                    bootbox.alert('Please select Installment')
                    $('#drp_installment').focus();
                    return false;
                }

                //var dept_code = $('#drpdepartment').val();
                //if (dept_code == "") {
                //    bootbox.alert('Please select department')
                //    $('#drpdepartment').focus();
                //    return false;
                //}

                //var prog = $('#drpprog').val();
                //if (prog == "") {
                //    bootbox.alert('Please select programme')
                //    $('#drpprog').focus();
                //    return false;
                //}

                //var student = $('#drpstudent').val();
                //if (student == "") {
                //    bootbox.alert('Please select student');
                //    $('#drpstudent').focus();
                //    return false;
                //}

                //window.open('Print_pay_in_slip_new_by_admin.aspx?student=' + student + '&department=' + dept_code + '&program=' + prog, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

                //window.open('Print_pay_in_slip_new_by_admin.aspx?semester=' + semester + '&year_code=' + year_code, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

                //$('#hdn_drp_value').val(JSON.stringify({ semester: semester, year_code: year_code, installment_no: installment_no }));

                //$('#hdn_download_icici').click();

                window.open('Print_fees_installment_pay_in_slip_admin.aspx?semester=' + semester + '&year_code=' + year_code + '&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

                return false;
            });

            $('#drpdepartment').on('change', function () {
                if ($('#drpdepartment').val() != '') {
                    if ($('#drpprog').val() != '') {
                        //alert('Change');
                        $('#drpstudent').trigger("liszt:updated");
                        //$('#drpstudent').chosen();
                        //$('#drpstudent').html("");
                        bindallstudentdata();
                    }
                }
            });

            $('#drpprog').on('change', function () {
                if ($('#drpprog').val() != '') {
                    if ($('#drpdepartment').val() != '') {
                        //alert('Change');
                        $('#drpstudent').trigger("liszt:updated");
                        //$('#drpstudent').chosen();
                        //$('#drpstudent').html("");
                        bindallstudentdata();
                    }
                }
            });

            return false;
        });
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Print Payslip
            </h1>
        </div>
        <div class="space">
        </div>
        <div>
            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <%-- <td>
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
                            Student :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>--%>
                        <td>
                            Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>
                            Year Of Allocation :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td>
                            Installment
                        </td>
                        <td>
                            <select class="chosen-select" id="drp_installment">
                                <option value="1">Full / Half Fees / Installment 1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">
                            <button class="btn btn-primary" type="submit" id="btnreterive">
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
