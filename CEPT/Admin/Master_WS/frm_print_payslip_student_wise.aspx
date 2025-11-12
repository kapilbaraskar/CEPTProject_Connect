<%@ Page Title="CEPT - Print payslip" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_print_payslip_student_wise.aspx.cs" Inherits="Admin_Master_frm_print_payslip_student_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>
    <script type="text/javascript">


        $(document).ready(function () {


            bindyeardata();
            bindprogrammedata();
            binddepartment();
            //  bindyeardata_for_cross_reg();


            $('#btnreterive').on('click', function () {

                print_payslip();

                return false;

            });

            $('#drpdepartment').on('change', function () {

                if ($('#drpdepartment').val() != '') {
                    if ($('#drpprog').val() != '') {
                        if ($('#drpyear').val() != '') {
                            //                        alert('Change');
                            $('#drpstudent').trigger("liszt:updated");
                            //                        $('#drpstudent').chosen();
                            //                        $('#drpstudent').html("");
                            bindallstudentdataforprintpayslip();
                        }

                    }
                }
                else {

                    $('#drpstudent')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No Student found</option>')
                .val('');
                    $('#drpstudent').chosen();

                    $('#drpstudent').val('').trigger("liszt:updated");
                }

            });

            $('#drpprog').on('change', function () {

                if ($('#drpprog').val() != '') {
                    if ($('#drpdepartment').val() != '') {

                        if ($('#drpyear').val() != '') {
                            //                        alert('Change');
                            $('#drpstudent').trigger("liszt:updated");
                            //                        $('#drpstudent').chosen();
                            //                        $('#drpstudent').html("");
                            bindallstudentdataforprintpayslip();
                        }

                    }
                }
                else {

                    $('#drpstudent')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No Student found</option>')
                .val('');
                    $('#drpstudent').chosen();

                    $('#drpstudent').val('').trigger("liszt:updated");
                }

            });

            $('#drpyear').on('change', function () {

                if ($('#drpyear').val() != '') {
                    if ($('#drpdepartment').val() != '') {
                        if ($('#drpprog').val() != '') {

                            //                        alert('Change');
                            $('#drpstudent').trigger("liszt:updated");
                            //                        $('#drpstudent').chosen();
                            //                        $('#drpstudent').html("");
                            bindallstudentdataforprintpayslip();
                        }

                    }
                }
                else {

                    $('#drpstudent')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No Student found</option>')
                .val('');
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

                bootbox.alert("Please select year of enrolment.");

                return false;
            }

            if ($('#drpstudent').val() == "") {

                bootbox.alert("Please select student.");

                return false;
            }

            //            if ($('#drp_fees').val() == "") {

            //                bootbox.alert("Please select student.");

            //                return false;
            //            }

            $.ajax({
                type: "POST",
                url: "../../WebService_WS.asmx/get_user_data_for_pay_slip_for_manually_student_wise",
                data: "{'user_id':'" + $('#drpstudent').val() + "' , year_code:'" + $('#drpyear').val() + "' , fees_type:'" + $('#drpfees_type').val() + "'}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {

                    if (data.d != "") {
                        
                        var result = JSON.parse(data.d);

                        if (result["status"]) {

                            window.open('frm_print_popup.aspx?student=' + $('#drpstudent').val() + '&amount=' + result["amount"] + '&student_name=' + result["student_name"] + '&trans_id=' + result["transaction_id"] + '&fees_type=' + $('#drpfees_type').val() + '&date=' + result["created_date"], 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                        }
                        else {

                            bootbox.alert(result["message"]);
                            return false;
                        }


                        //   bootbox.alert(data.d);
                        return false;



                    }
                    else {

                        bootbox.alert("Problem in retrieve user data");

                    }

                },

                Error: function (data) {

                    alert(data.d);
                }

            });


            return false;

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
                        <td>
                            Student :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpstudent" />
                        </td>
                        <td>
                            Fees type :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpfees_type">
                                <option value="manually">Manually</option>
                                <option value="online">Online</option>
                            </select>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Print
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
