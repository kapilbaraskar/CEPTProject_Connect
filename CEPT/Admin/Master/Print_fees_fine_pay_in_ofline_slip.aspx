<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print_fees_fine_pay_in_ofline_slip.aspx.cs" Inherits="Admin_Master_Print_fees_fine_pay_in_ofline_slip" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Print Fine Payslip</title>
    <script src="../../DesignJS/jquery.min.js" type="text/javascript"></script>
    <%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">--%>
    <script type="text/javascript">
        var installment_data = [];
        var trans_data = [];
        var installment_no = '';
        var today_date = '';

        $(document).ready(function () {

            var student = getParameterByName('student');
            var sem_code = getParameterByName('semester');
            var year_code = getParameterByName('year_code');
            installment_no = getParameterByName('installment_no');
            var url_data = '';
            var perameter = '';
            $('.cls_bank_img').attr('src', '../../image/icicibanglogo.png');
            
            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_fine_fees_installment_dtl_offline_all",
                data: "{sem_code:'" + sem_code + "', year_code:'" + year_code + "', installment_no:'" + installment_no + "'}",
                contentType: "application/json",
                async: false,
                cache: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        installment_data = JSON.parse(data.d);
                    }
                    else {
                        alert('No Data Found');
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            var currentDate = new Date();
            var day = currentDate.getDate();
            var month = currentDate.getMonth() + 1;
            var year = currentDate.getFullYear();
            var today_date = day.toString().length == 1 ? '0' + day : day.toString() + ('00' + month).substring(1) + year.toString().substring(2);

            var add_yaer = currentDate.getFullYear() + 1;
            var res = add_yaer.toString().substring(2);

            createPaySlip(sem_code, year_code);

            if (installment_data.length > 0) {

                var css = '@page { size: landscape; }',
                    head = document.head || document.getElementsByTagName('head')[0],
                    style = document.createElement('style');

                style.type = 'text/css';
                style.media = 'print';

                if (style.styleSheet) {
                    style.styleSheet.cssText = css;
                } else {
                    style.appendChild(document.createTextNode(css));
                }

                head.appendChild(style);

                window.print();

                window.onfocus = function () { window.close(); }
            }
            //window.close();
        });

        function createPaySlip(sem_code, year_code) {
            for (var i = 0; i < installment_data.length; i++) {
                var desc;

                $('#div_temp_payslip').html($('#div_blank_payslipp').html());

                var fees_data = installment_data[i];
                var user_id = fees_data["user_id"];

                $('#div_temp_payslip .cls_StudentName td:nth-child(2)').text(fees_data["user_name"]);

                if (fees_data["prog_desc"] == "") {
                    var obj_stud_detail = fees_data;
                    desc = get_prog_desc(obj_stud_detail);
                    $('#div_temp_payslip .cls_ProgramName td:nth-child(2)').text(desc);
                }
                else {
                    $('#div_temp_payslip .cls_ProgramName td:nth-child(2)').text(fees_data["prog_desc"]);
                }

                $('#div_temp_payslip .cls_TransactionId td:nth-child(2)').text(fees_data["dd_no"]);
                //$('#div_temp_payslip .cls_DateofPayement td:nth-child(2)').text(": " + fees_data["created_date"]);
                var return_date = splitdate(fees_data["date_of_dd"]);
                $('#div_temp_payslip .cls_DateofPayement td:nth-child(2)').text(return_date);

                //if (fees_data["Citrus_TxGateway"] == "Yes Bank") {
                //    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text(fees_data["Citrus_TxGateway"]);
                //}
                //else if (fees_data["Citrus_TxGateway"] == "Kotak") {
                //    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text(fees_data["Citrus_TxGateway"]);
                //}
                //else if (fees_data["Citrus_TxGateway"] == "HDFC") {//16072019 For HDFC
                //    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text(fees_data["Citrus_TxGateway"]);
                //}
                //else {
                //    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text("ICICI");
                //}

                 if (fees_data["bank_name"] != '') {
                    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text(fees_data["bank_name"]);
                }
                //else{}

                if (sem_code == 'S') {
                    $('.s_type').text("Spring");
                }
                else {
                    $('.s_type').text("Monsoon");
                }

                $('.y_code').text(year_code);

                if (fees_data["no_of_installment"] == '1') {
                    $('#div_temp_payslip .payment').text("Full Payment");
                }
                else {
                    $('#div_temp_payslip .payment').text("Partial Payment");
                }

                if (fees_data["installment_status"] != 'Y' && fees_data["installment_status"] != 'N') {
                }
                else {
                    setCellData('cls_StudentCode', user_id);

                    //var total_fees_paid = 0;

                    //if (fees_data["installment_fine"] != "") {
                    //    total_fees_paid = parseInt(fees_data["installment" + installment_no]) + parseInt(fees_data["installment_fine"]);
                    //} else {
                    //    total_fees_paid = fees_data["installment" + installment_no];
                    //}
                    var rupees = '';
                    var rupees_fine = '';

                    //if (installment_data.length == 1) {
                    //    $('#div_temp_payslip .cls_Amount td:nth-child(2)').text(fees_data["installment" + installment_no] + "/-");
                    //    rupees = 'Rupees ' + convert_number(fees_data["installment" + installment_no]) + ' Only';
                    //}
                    //else if (installment_data.length > 1) {
                    //    $('#div_temp_payslip .cls_Amount td:nth-child(2)').text(fees_data["amount"] + "/-");
                    //    rupees = 'Rupees ' + convert_number(fees_data["amount"]) + ' Only';
                    //}


                        $('#div_temp_payslip .cls_Amount td:nth-child(2)').text(fees_data["installment_fine"] + "/-");
                        rupees = 'Rupees ' + convert_number(fees_data["installment_fine"]) + ' Only'; 
                        
                        $('#div_temp_payslip .cls_FineAmount td:nth-child(2)').text(fees_data["paid_installment_fine"] + "/-");
                        rupees_fine = 'Rupees ' + convert_number(fees_data["paid_installment_fine"]) + ' Only';

                    //$('#div_temp_payslip .cls_Amount td:nth-child(2)').text(": " + total_fees_paid + "/-");



                    $('#div_temp_payslip .cls_AmountInWords td:nth-child(2)').html("");
                    for (var j = 0; j < rupees.length; j++) {
                        //if (j != 0 && j % 37 == 0) $('#div_temp_payslip .cls_AmountInWords td:nth-child(2)').append('<br/>');

                        $('#div_temp_payslip .cls_AmountInWords td:nth-child(2)').append(rupees[j]);
                    }
                $('#div_temp_payslip .cls_AmountInWords_fine td:nth-child(2)').html("");
                    for (var j = 0; j < rupees_fine.length; j++) {
                        //if (j != 0 && j % 37 == 0) $('#div_temp_payslip .cls_AmountInWords td:nth-child(2)').append('<br/>');

                        $('#div_temp_payslip .cls_AmountInWords_fine td:nth-child(2)').append(rupees_fine[j]);
                    }
                }

                $('#div_payslip_all').append($('#div_temp_payslip').html());
                $('#div_temp_payslip').html('');
            }
        }

        function splitdate(paydate) {
            debugger
            if (paydate == null) {
                return;
            }
            var date = paydate.split('/');

            switch (parseInt(date[0])) {
                case 1:
                    date[0] = "JAN";
                    break;
                case 2:
                    date[0] = "FEB";
                    break;
                case 3:
                    date[0] = "MAR";
                    break;
                case 4:
                    date[0] = "APR";
                    break;
                case 5:
                    date[0] = "MAY";
                    break;
                case 6:
                    date[0] = "JUN";
                    break;
                case 7:
                    date[0] = "JUL";
                    break;
                case 8:
                    date[0] = "AUG";
                    break;
                case 9:
                    date[0] = "SEP";
                    break;
                case 10:
                    date[0] = "OCT";
                    break;
                case 11:
                    date[0] = "NOV";
                    break;
                case 12:
                    date[0] = "DEC";
                    break;
                default:
                    date[0] = "";
                    break;
            }
            date = date[1] + " " + date[0] + " " + date[2];
            return date;



        }
        function setCellData(trClass, cellValue) {
            $('#div_temp_payslip .' + trClass + ' td:nth-child(' + (2) + ')').html(cellValue);
        }

        function get_prog_desc(obj_stud_detail) {
            var str_program = '';
            var stud_year_code = obj_stud_detail["year_code"];
            if (obj_stud_detail["year_code"] == 'Y1') stud_year_code = 'Y2013';

            if (obj_stud_detail["prog_desc"] == 'Landscape Architecture') {
                str_program = 'MASTERS PROGRAM IN LANDSCAPE ARCHITECTURE';
            }
            else if (obj_stud_detail["prog_desc"] == 'Landscape Design') {
                str_program = 'MASTERS PROGRAM IN LANSCAPE DESIGN';
            }
            else if (obj_stud_detail['dept_code'] == '2' && obj_stud_detail['prog_code'] == '1') { // FD UG
                str_program = 'BACHELOR OF INTERIOR DESIGN';
            }
            else if (obj_stud_detail['dept_code'] == '4' && obj_stud_detail['prog_code'] == '1' && stud_year_code >= 'Y2016') { // FP UG
                str_program = 'BACHELOR OF URBAN DESIGN';
            }
            else if (obj_stud_detail['dept_code'] == '4' && obj_stud_detail['prog_code'] == '2' && stud_year_code == 'Y2014') { // FP PG
                str_program = 'MASTER OF PLANNING';
            }
            else if (obj_stud_detail['dept_code'] == '4' && obj_stud_detail['prog_code'] == '2' && stud_year_code >= 'Y2015') { // FP PG
                str_program = 'MASTER OF URBAN AND REGIONAL PLANNING';
            }
            else if (obj_stud_detail['dept_code'] == '5' && obj_stud_detail['prog_code'] == '1' && stud_year_code <= 'Y2012') { // FT UG
                str_program = 'BACHELOR OF TECHNOLOGY(HONS. CIVIL-CONSTRUCTION)';
            }
            else if (obj_stud_detail['dept_code'] == '5' && obj_stud_detail['prog_code'] == '1' && stud_year_code >= 'Y2013') { // FT UG
                str_program = 'BACHELOR OF CONSTRUCTION TECHNOLOGY';
            }
            else if (obj_stud_detail['dept_code'] == '5' && obj_stud_detail['prog_code'] == '2' && obj_stud_detail['prog_level_code'] == 'PT1') { // FT PG
                str_program = 'MASTER OF TECHNOLOGY (CONSTRUCTION ENGINEERING & MANAGEMENT)';
            }
            else if (obj_stud_detail['dept_code'] == '5' && obj_stud_detail['prog_code'] == '2' && obj_stud_detail['prog_level_code'] == 'PT2') { // FT PG
                str_program = 'MASTER OF TECHNOLOGY (GEOMATICS)';
            }
            else if (obj_stud_detail['dept_code'] == '5' && obj_stud_detail['prog_code'] == '2' && obj_stud_detail['prog_level_code'] == 'PT3') { // FT PG
                str_program = 'MASTER OF TECHNOLOGY (INFRASTRUCTURE ENGINEERING DESIGN)';
            }
            else if (obj_stud_detail['dept_code'] == '5' && obj_stud_detail['prog_code'] == '2' && obj_stud_detail['prog_level_code'] == 'PT4') { // FT PG
                str_program = 'MASTER OF TECHNOLOGY (STRUCTURAL ENGINEERING DESIGN)';
            }
            else if (obj_stud_detail['dept_code'] == '5' && obj_stud_detail['prog_code'] == '2' && obj_stud_detail['prog_level_code'] == 'PT5') { // FT PG
                str_program = 'MASTER OF TECHNOLOGY (BUILDING ENERGY PERFORMANCE)';
            }
            else if (obj_stud_detail["prog_level_name"] == '') {
                switch (obj_stud_detail["prog_code"]) {
                    case "1": str_program = "BACHELOR OF " + obj_stud_detail["dept_name"]; break;
                    case "2": str_program = "MASTER OF " + obj_stud_detail["dept_name"]; break;
                }
            }
            else {
                str_program = obj_stud_detail["prog_level_name"];
            }

            if (obj_stud_detail["name_of_the_degree"] != '') {
                str_program = obj_stud_detail["name_of_the_degree"];
            }

            return str_program;
        }

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
                res += (((res == "") ? "" : " ") + convert_number(kn) + " Lakhs");
            }
            if (Hn > 0) {
                res += (((res == "") ? "" : " ") + convert_number(Hn) + " Thousand");
            }

            if (Dn) {
                res += (((res == "") ? "" : " ") + convert_number(Dn) + " hundred");
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

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
    </script>

    <style type="text/css">
        body {
            /*width: 20.05cm;*/
            margin: 0 auto;
            font-size: 12px;
            padding-top: 20px;
            padding-left: 10px;
            font-family: Calibri;
        }

        .div_container {
            border: 1px solid black;
            height: 9.02cm;
        }

        .div_left {
            float: left;
            width: 58%;
        }

        .div_right {
            float: left;
            width: 41%;
            border-left: 1px solid black;
        }

        table tr td {
            /*border-left: 1px solid black;*/
            border-bottom: 1px solid #C0C0C0 !important;
            min-width: 15px;
            border-spacing: 0px !important;
            /*border: none;*/
            /*vertical-align: baseline;*/
        }

            table tr td:first-child {
                border-left: 0px;
            }

            table tr td:last-child {
                /*border-right: 1px solid black;*/
            }

        .table_left tr td:nth-child(2) {
            border-bottom: 1px !important;
        }

        .table_left tr:last-child td:nth-child(2) {
            border-bottom: 1px solid black !important;
        }

        table tr td:nth-child(2) {
            font-family: Consolas !important;
        }

        .table_left tr td {
            text-align: center;
        }

            .table_left tr td:first-child, .cls_StudentName td:nth-child(3), .cls_AmountInWords td:nth-child(3), .cls_Amount td:nth-child(3), .cls_AmountInWords_fine td:nth-child(3), .cls_FineAmount td:nth-child(3) {
                text-align: left;
            }

        .table_right tr td {
            font-size: 12px;
        }

        .table_right tr:first-child td, .table_right tr:nth-child(2) td {
            line-height: 14px;
        }

        .bottom_zero {
            border-bottom: 0px !important;
        }

        .right_zero {
            border-right: 0px !important;
        }

        .font12 {
            font-size: 12px !important;
        }

        .set_padding td {
            padding: 0 1px;
        }

        .marg_top {
            margin-top: 20px;
        }

        .cls_StudentName td:nth-child(3) {
            text-transform: capitalize;
            max-width: 280px;
        }

        cls_NameOfBranch td:nth-child(3), .cls_StudentName td:nth-child(3) {
            height: 22px;
        }

        .cls_Amount td:nth-child(3) {
            height: 19px;
        }

        #div_payslip_all table tbody tr td:first-child {
            padding-left: 0;
        }
    </style>
</head>

<body>
    <div id="div_payslip_all">
    </div>

    <div id="div_temp_payslip">
    </div>

    <div id="div_blank_payslipp" style="display: none;">
        <div>
            <div style="width: 45%; float: left; padding: 1%;">
                <div class="row">
                    <div>
                        <div style="width: 50%; float: left;">
                            <img src="../../image/Capture.PNG" />
                        </div>
                        <div style="width: 50%; float: right; text-align: right; font-size: 13px; font-weight: bold;">
                            ELECTRONIC RECEIPT
                        <div style="font-weight: normal">Student Copy</div>
                        </div>
                    </div>
                    <div style="clear: both;"></div>
                    <div style="width: 50%; float: left; font-size: 13.8px;">
                        <p>
                            Kasturbhai Lalbhai Campus,<br />
                            University Rd, Navrangpura,<br />
                            Ahmedabad‐380009,<br />
                            Gujarat India
                        </p>
                    </div>
                    <div style="clear: both;"></div>
                </div>
                <div style="font-size: 18px;">
                    <table cellpadding="5" style="border-spacing: 0px !important; width: 100%;">
                        <tr class="cls_StudentCode">
                            <td style="width: 155px;">Student Code</td>
                            <td></td>
                        </tr>
                        <tr class="cls_StudentName">
                            <td>Student Name</td>
                            <td></td>
                        </tr>
                        <tr class="cls_ProgramName">
                            <td>Program Name</td>
                            <td></td>
                        </tr>
                        <tr class="cls_Amount">
                            <td style="border-bottom: none !important;">Fine Amount</td>
                            <td style="border-bottom: none !important;"></td>
                        </tr>
                        <tr class="cls_AmountInWords">
                            <td></td>
                            <td style="font-size: 14px !important;"></td>
                        </tr>
                        <tr class="cls_FineAmount">
                            <td style="border-bottom: none !important;">Paid Fine Amount</td>
                            <td style="border-bottom: none !important;"></td>
                        </tr>
                        
                         <tr class="cls_AmountInWords_fine">
                            <td></td>
                            <td style="font-size: 14px !important;"></td>
                        </tr>
                        <tr>
                            <td>Payment Mode</td>
                            <td>Offline
                            </td>
                        </tr>
                        <tr class="cls_TransactionId">
                            <td>Transaction NO</td>
                            <td></td>
                        </tr>
                        <tr class="cls_DateofPayement">
                            <td>Date of Payment</td>
                            <td></td>
                        </tr>
                        <tr class="cls_BankName">
                            <td>Bank Name</td>
                            <td></td>
                        </tr>
                    </table>
                </div>
                <br />
                <div style="font-size: 15px; display:none;">
                    Received On account of Tuition Fee for <span class="s_type"></span>Semester of year
                    <span class="y_code"></span>being <span class="payment"></span><span>. Fee once paid is not Refundable</span>

                </div>
                <br />
                <div style="display:none;">
                    (This is a computer‐generated fee Receipt, hence authorized signature not required)
                </div>
                <br />
                <div style="font-style: normal; text-align: justify;display:none;">
                    Students agree to conduct themselves within the ambits of CEPT IT policy in force. Students 
                    agree that only software with appropriate licenses will be installed and/or used and/or 
                    stored on their computer systems/tablets/mobile phones allotted to them and in their 
                    control, or on their personal devices which use any University resources. Any liability arising 
                    out of any unauthorized usage will solely be of the student, and not of the university. The 
                    university may take appropriate actions against students found violating CEPT IT Policy. 
                </div>
            </div>

            <div style="width: 45%; float: right; padding: 1%;">
                <div>
                    <div style="width: 50%; float: left;">
                        <img src="../../image/Capture.PNG" />
                    </div>
                    <div style="width: 50%; float: right; text-align: right; font-size: 13px; font-weight: bold">
                        ELECTRONIC RECEIPT
                        <div style="font-weight: normal">Institution Copy</div>
                    </div>
                </div>
                <div style="clear: both;"></div>
                <div style="font-size: 13.8px;">
                    <p>
                        Kasturbhai Lalbhai Campus,<br />
                        University Rd, Navrangpura,<br />
                        Ahmedabad‐380009,<br />
                        Gujarat India
                    </p>
                </div>
                <div style="font-size: 18px;">
                    <table cellpadding="5" style="border-spacing: 0px !important; width: 100%; padding-right: 2px;">
                        <tr class="cls_StudentCode">
                            <td style="width: 155px;">Student Code</td>
                            <td></td>
                        </tr>
                        <tr class="cls_StudentName">
                            <td>Student Name</td>
                            <td></td>
                        </tr>
                        <tr class="cls_ProgramName">
                            <td>Program Name</td>
                            <td></td>
                        </tr>
                        <tr class="cls_Amount">
                            <td style="border-bottom: none !important;">Fine Amount</td>
                            <td style="border-bottom: none !important;"></td>
                        </tr>
                        <tr class="cls_AmountInWords">
                            <td></td>
                            <td style="font-size: 14px !important;"></td>
                        </tr>
                         <tr class="cls_FineAmount">
                            <td style="border-bottom: none !important;">Paid Fine Amount</td>
                            <td style="border-bottom: none !important;"></td>
                        </tr>
                        
                        <tr class="cls_AmountInWords_fine">
                            <td></td>
                            <td style="font-size: 14px !important;"></td>
                        </tr>
                        <tr>
                            <td>Payment Mode</td>
                            <td>OffLine
                            </td>
                        </tr>
                        <tr class="cls_TransactionId">
                            <td>Transaction NO</td>
                            <td></td>
                        </tr>
                        <tr class="cls_DateofPayement">
                            <td>Date of Payment</td>
                            <td></td>
                        </tr>
                        <tr class="cls_BankName">
                            <td>Bank Name</td>
                            <td></td>
                        </tr>
                    </table>
                </div>
                <br />
                <div style="font-size: 15px; display:none;">
                    Received On account of Tuition Fee for <span class="s_type"></span>Semester of year
                    <span class="y_code"></span>being <span class="payment"></span><span>. Fee once paid is not Refundable</span>
                    <%--<div>Fee once paid is not Refundable</div>--%>
                </div>
                <br />
                <div style="display:none;">
                    (This is a computer‐generated fee Receipt, hence authorized signature not required)
                </div>
                <br />
                <div style="text-align: justify; display:none;">
                    Students agree to conduct themselves within the ambits of CEPT IT policy in force. Students 
                    agree that only software with appropriate licenses will be installed and/or used and/or 
                    stored on their computer systems/tablets/mobile phones allotted to them and in their 
                    control, or on their personal devices which use any University resources. Any liability arising 
                    out of any unauthorized usage will solely be of the student, and not of the university. The 
                    university may take appropriate actions against students found violating CEPT IT Policy.
                </div>
            </div>
        </div>

        <div style="clear: both;"></div>

        <div style="page-break-after: always;"></div>
    </div>
</body>
</html>
