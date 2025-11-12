<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Print_multiple_payslip_with_manually_amount.aspx.cs" Inherits="Admin_Master_Print_multiple_payslip_with_manually_amount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
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

        });

          

           

        function print_payslip() {

            debugger;

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

               if ($('#txt_acount_credited').val().trim() == "") {

                bootbox.alert("Please enter Account to be credited ");

                return false;
            }

            if ($('#txt_institute_name').val().trim() == "") {

                bootbox.alert("Please Enter Institute Name.");

                return false;
            }

            if ($('#txt_amount').val().trim() == "") {

                bootbox.alert("Please Enter Ammount.");

                return false;
            }

            window.open('frm_print_multiple_payslip_popup.aspx?department=' + $('#drpdepartment').val() + '&program=' + $('#drpprog').val() + '&year=' +$('#drpyear').val()  + '&Account='+ $('#txt_acount_credited').val() + '&Institute='+ $('#txt_institute_name').val() + '&amount=' + $('#txt_amount').val(), 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

            return false;
        }

        function IsNumeric(e) {

            debugger;
            //alert(e.which + " : " + e.keyCode);
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {

                //        if (parseInt($(document.activeElement).val()) > 10) {
                //            return false;
                //        }
                //        else if (parseInt($(document.activeElement).val()) == 10) {
                //            if (keyCode != 48) {
                //                return false;
                //            }
                //        }

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
                            year of enrolment
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Account to be credited
                        </td>
                        <td>
                            <input id="txt_acount_credited" type="text" />
                        </td>
                        <td>
                            Institution Name
                        </td>
                        <td>
                            <input id="txt_institute_name" type="text" />
                        </td>
                        <td>
                            Amount
                        </td>
                        <td>
                            <input type="text" id="txt_amount" onkeypress='return IsNumeric(event);' />
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
