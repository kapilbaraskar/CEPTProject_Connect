<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print_pay_in_slip_other.aspx.cs"
    Inherits="Student_Print_pay_in_slip_other" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../DesignJS/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var user_data;
        var waiver_installmant_data = '';
        $(document).ready(function () {


            //            var today = new Date();
            //            var dd = today.getDate();
            //            var mm = today.getMonth() + 1; //January is 0!

            //            var yyyy = today.getFullYear();
            //            if (dd < 10) { dd = '0' + dd } if (mm < 10) { mm = '0' + mm } today = mm + '/' + dd + '/' + yyyy;


            debugger;


        


            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_user_data_for_pay_slip",
                data: "{}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {

                    if (data.d != "") {

                        user_data = JSON.parse(data.d);

                        $('#lbl_name').text(user_data[0]["full_name"]);

                    }
                    else {

                    }

                },

                Error: function (data) {

                    alert(data.d);
                }

            });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_fees_amount_status",
                data: "{}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {

                    var result = JSON.parse(data.d);

                    if (result["status"]) {


                         $('#lblamount1').text(result["amount"]);
                        var rupees = convert_number(result["amount"]);

                         $('#lbltotalrs1').text(rupees + ' ' + 'Only');

                        $('#form1').css('display', 'block');
                    }
                    else {

                        alert(result["message"]);

                        $('#form1').css('display', 'none');

                        return false;

                    }

                },

                Error: function (data) {

                    alert(data.d);
                }

            });


          



            //            var currentDate = new Date()
            //            var day = currentDate.getDate()
            //            var month = currentDate.getMonth() + 1
            //            var year = currentDate.getFullYear()



            //            var today_date = day + "/" + month + "/" + year;

            //            $('#lbldate1').text(today_date);
            //            $('#lbldate2').text(today_date);
            //            $('#lbldate3').text(today_date);


            //            var add_yaer = currentDate.getFullYear() + 1;


            //            var res = add_yaer.toString().substring(2)


            //            $('#lblyear1').text(year + ' - ' + res);
            //            $('#lblyear2').text(year + ' - ' + res);
            //            $('#lblyear3').text(year + ' - ' + res);

            //  var characters = add_yaer[add_yaer.length - 1];

            window.print();

        });

        function convert_number(number) {
            if ((number < 0) || (number > 999999999)) {
                return "Number is out of range";
            }
            var Gn = Math.floor(number / 10000000);  /* Crore */
            number -= Gn * 10000000;
            var kn = Math.floor(number / 100000);     /* lakhs */
            number -= kn * 100000;
            var Hn = Math.floor(number / 1000);      /* thousand */
            number -= Hn * 1000;
            var Dn = Math.floor(number / 100);       /* Tens (deca) */
            number = number % 100;               /* Ones */
            var tn = Math.floor(number / 10);
            var one = Math.floor(number % 10);
            var res = "";

            if (Gn > 0) {
                res += (convert_number(Gn) + " Crore");
            }
            if (kn > 0) {
                res += (((res == "") ? "" : " ") +
            convert_number(kn) + " Lakhs");
            }
            if (Hn > 0) {
                res += (((res == "") ? "" : " ") +
            convert_number(Hn) + " Thousand");
            }

            if (Dn) {
                res += (((res == "") ? "" : " ") +
            convert_number(Dn) + " hundred");
            }


            var ones = Array("", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eightteen", "Nineteen");
            var tens = Array("", "", "Twenty", "Thirty", "Fourty", "Fifty", "Sixty", "Seventy", "Eigthy", "Ninety");

            if (tn > 0 || one > 0) {
                if (!(res == "")) {
                    res += " and ";
                }
                if (tn < 2) {
                    res += ones[tn * 10 + one];
                }
                else {

                    res += tens[tn];
                    if (one > 0) {
                        res += ("-" + ones[one]);
                    }
                }
            }

            if (res == "") {
                res = "zero";
            }
            return res;
        }

    </script>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style2
        {
            padding: 1px 4px;
            width: 1035px;
            height: 646px;
            border-right-style: solid;
            border-right-width: 0px;
        }
        .style11
        {
        }
        .style20
        {
            width: 295px;
        }
        .style21
        {
            width: 214px;
        }
        .style38
        {
        }
        .style41
        {
            font-size: medium;
            font-weight: bold;
        }
        .style46
        {
            font-size: medium;
        }
        .style56
        {
            padding: 1px 4px;
            width: 370px;
            border-right-style: solid;
            border-right-width: 1px;
        }
        .style58
        {
            width: 264px;
        }
        .style59
        {
            font-size: medium;
            font-weight: bold;
            width: 167px;
        }
        .style60
        {
            height: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <p>
            Dear <strong><b>
                <label id="lbl_name" style="font-size: medium">
                </label>
            </b></strong>,
        </p>
        <p>
            Please find the bank details for online transaction. Request you to send us the
            cyber
            <br />
            receipt of the payment made after doing payment at <a href="mailto:summerwinterschool@cept.ac.in">
                <strong><em>summerwinterschool@cept.ac.in</em></strong></a>
        </p>
        <p>
            Please do not forget to click on the register button after payment of fees.
        </p>
        <table border="1" cellspacing="0" cellpadding="0" width="606">
            <tbody>
                <tr>
                    <td width="171">
                        BANK NAME
                    </td>
                    <td width="435">
                        ICICI BANK
                    </td>
                </tr>
                <tr>
                    <td>
                        BANK ADDRESS
                    </td>
                    <td width="435">
                        AHMEDABAD BRANCH.
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td width="435">
                        JMC HOUSE,OPP PARIMAL GARDEN
                    </td>
                </tr>
                <tr>
                    <td>
                        Account Name
                    </td>
                    <td width="435">
                        CEPT UNIVERSITY
                    </td>
                </tr>
                <tr>
                    <td>
                        Account Number
                    </td>
                    <td width="435">
                        002401039324
                    </td>
                </tr>
                <tr>
                    <td>
                        BRANCH NAME
                    </td>
                    <td width="435">
                        AHMEDABAD BRANCH.
                    </td>
                </tr>
                <tr>
                    <td>
                        SWIFT CODE
                    </td>
                    <td width="435">
                        ICICINBBXXX
                    </td>
                </tr>
                <tr>
                    <td>
                        IFSC
                    </td>
                    <td width="435">
                        ICIC0000024
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td width="435">
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        FEES
                    </td>
                    <td width="435">
                        <b>
                            <label id="lblamount1" style="font-size: medium">
                            </label>
                        </b>(INDIAN RUPEES)
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td width="435">
                        (<b><label id="lbltotalrs1" style="font-size: medium">
                        </label>
                        </b>)
                    </td>
                </tr>
            </tbody>
        </table>
        <p>
            In case of any queries please contact us at <a href="mailto:summerwinterschool@cept.ac.in">
                <strong><em>summerwinterschool@cept.ac.in</em></strong></a> <strong><em></em>
            </strong>
        </p>
        <p>
            Regards
        </p>
    </div>
    </form>
</body>
</html>
