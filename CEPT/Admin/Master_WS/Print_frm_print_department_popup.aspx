<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print_frm_print_department_popup.aspx.cs" Inherits="Admin_Master_WS_Print_frm_print_department_popup" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=us-ascii">
    <meta name="ProgId" content="Excel.Sheet">
    <meta name="Generator" content="Microsoft Excel 12">
    <link rel="File-List" href="page1_files/filelist.xml">
    <!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
x\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
    <title>Print In Payslip</title>
    <script src="../../DesignJS/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var user_data = "";
        var trans_data;
        var installment_data = "";

        $(document).ready(function () {

            var dept_code = getParameterByName('dept_code');
            var prog_code = getParameterByName('prog_code');
            var sem_code = getParameterByName('semester');
            var year_code = getParameterByName('year_code');
            var year_code_alloc = getParameterByName('year_code_alloc');
            var fees_type = getParameterByName('fees_type');
            var all_data = "";
            var student = "";


            var currentDate = new Date();
            var day = currentDate.getDate();
            var month = currentDate.getMonth() + 1;
            var year = currentDate.getFullYear();
            var today_date = day.toString().length == 1 ? '0' + day : day.toString() + ('00' + month).substring(1) + year.toString().substring(2);

            var add_yaer = currentDate.getFullYear() + 1;
            var res = add_yaer.toString().substring(2);

            $('#div_print').html('');

            if (fees_type == 'online') {

                $.ajax({
                    type: "POST",
                    url: "../../WebService_WS.asmx/get_online_payment_transaction_id",
                    data: "{'dept_code':'" + dept_code + "',prog_code:'" + prog_code + "','year_code':'" + year_code + "',sem_code:'" + sem_code + "', year_code_alloc:'" + year_code_alloc + "'}",
                    contentType: "application/json",
                    datatype: "json",
                    async: false,
                    success: function (data) {
                        
                        if (data.d != "") {
                            trans_data = JSON.parse(data.d);

                            var currentDate = new Date();
                            var day = currentDate.getDate();
                            var month = currentDate.getMonth() + 1;
                            var year = currentDate.getFullYear();
                            var today_date = day.toString().length == 1 ? '0' + day : day.toString() + ('00' + month).substring(1) + year.toString().substring(2);

                            var add_yaer = currentDate.getFullYear() + 1;
                            var res = add_yaer.toString().substring(2);

                            createPaySlip(trans_data, sem_code, year_code_alloc);

                            if (trans_data.length > 0) {
                                window.print();
                            }
                            //window.close();

                            // alert(trans_data[0]['transaction_id']);


                            //if (trans_data != '') {

                            //    for (var i = 0; i < trans_data.length; i++) {



                            //        // alert(trans_data[i]['created_date']);
                            //        $('.lbldateofdeposit').text(trans_data[i]['created_date']);

                            //        $('.lbl_trans_id').text(trans_data[i]['transaction_id']);
                            //        $('.lbl_trans_name').text('Transaction Id');
                            //        $('.lbl_student_name').text(trans_data[i]["user_name"]);
                            //        $('.lbl_student_code').text(trans_data[i]["user_id"]);
                            //        $('.lbl_pan_no').text('AAAJC0452C');
                            //        // $('.lbl_sem_code').text(user_data[0]["semester_code"]);
                            //        $('.lbl_bank_code').text('0036SLFEECOL');
                            //        $('.lbl_name_of_institute').text('FCCUVY');
                            //        $('.lbl_course_section').text('');



                            //        $('#main_fees').css('display', 'block');

                            //        $('.lbl_amount1').text(trans_data[i]["amount"]);
                            //        var rupees = convert_number(trans_data[i]["amount"]);
                            //        $('.lbl_amount_in_word1').text(rupees + ' ' + 'Only');


                            //        all_data = all_data + $('#div_fees').html();
                            //    }

                            //    $('#div_print').append(all_data);
                            //}

                        }
                        else {
                            //No data found
                            alert('No Data Found');
                            window.close();
                        }

                    },

                    Error: function (data) {

                        alert(data.d);
                    }

                });


            }
            else {

                $.ajax({
                    type: "POST",
                    url: "../../WebService_WS.asmx/Get_all_student_data_for_manually_printpayslip",
                    data: "{'dept_code':'" + dept_code + "',prog_code:'" + prog_code + "','year_code':'" + year_code + "'}",
                    contentType: "application/json",
                    datatype: "json",
                    async: false,
                    success: function (data) {

                        if (data.d != "") {
                            
                            user_data = JSON.parse(data.d);



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

                if (user_data != "") {

                    for (var i = 0; i < user_data.length; i++) {

                        student = user_data[i]["user_id"];
                        $.ajax({
                            type: "POST",
                            url: "../../WebService_WS.asmx/get_user_data_for_pay_slip_for_manually_student_wise",
                            data: "{'user_id':'" + student + "' , year_code:'" + year_code + "' , fees_type:'" + fees_type + "'}",
                            contentType: "application/json",
                            datatype: "json",
                            async: false,
                            success: function (data) {

                                if (data.d != "") {
                                    if (student == 'W1415000276' || student == 'W1415000207' || student == 'W1415000228' || student == 'W1415000215') {
                                        
                                    }

                                    var result = JSON.parse(data.d);

                                    if (result["status"]) {

                                        var currentDate = new Date()
                                        var day = currentDate.getDate()
                                        var month = currentDate.getMonth() + 1
                                        var year = currentDate.getFullYear()



                                        var today_date = day + "/" + month + "/" + year;

                                        $('.lbldateofdeposit').text(today_date);

                                        //                                        $('.lbl_trans_id').text(trans_data[i]['transaction_id']);
                                        //                                        $('.lbl_trans_name').text('Transaction Id');
                                        $('.lbl_student_name').text(result["student_name"]);
                                        $('.lbl_student_code').text(student);
                                        $('.lbl_pan_no').text('AAAJC0452C');
                                        // $('.lbl_sem_code').text(user_data[0]["semester_code"]);
                                        $('.lbl_bank_code').text('0036SLFEECOL');
                                        $('.lbl_name_of_institute').text('CEPT University');
                                        $('.lbl_course_section').text('FCCUVY');



                                        $('#main_fees').css('display', 'block');

                                        $('.lbl_amount1').text(result["amount"]);
                                        var rupees = convert_number(result["amount"]);
                                        $('.lbl_amount_in_word1').text(rupees + ' ' + 'Only');


                                        all_data = all_data + $('#div_fees').html();
                                    }
                                    else {


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
                    }

                    $('#div_print').append(all_data);
                }

            }


            //window.print();


        });

        function createPaySlip(trans_data, sem_code, year_code_alloc) {
            var installment_data = trans_data;
            for (var i = 0; i < installment_data.length; i++) {
                var desc;

                $('#div_temp_payslip').html($('#div_blank_payslipp').html());
                
                var fees_data = installment_data[i];
                var user_id = fees_data["user_id"];

                $('#div_temp_payslip .cls_StudentName td:nth-child(2)').text(": " + fees_data["user_name"]);

                if (fees_data["prog_desc"] == "") {
                    var obj_stud_detail = fees_data;
                    //desc = get_prog_desc(obj_stud_detail);
                    $('#div_temp_payslip .cls_ProgramName td:nth-child(2)').text(": " + desc);
                }
                else {
                    $('#div_temp_payslip .cls_ProgramName td:nth-child(2)').text(": " + fees_data["prog_desc"]);
                }

                $('#div_temp_payslip .cls_TransactionId td:nth-child(2)').text(": " + fees_data["transaction_id"]);
                $('#div_temp_payslip .cls_DateofPayement td:nth-child(2)').text(": " + fees_data["created_date"]);

                if (fees_data["Citrus_TxGateway"] == "Yes Bank") {
                    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text(": " + fees_data["Citrus_TxGateway"]);
                }
                else if (fees_data["Citrus_TxGateway"] == "Kotak") {
                    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text(": " + fees_data["Citrus_TxGateway"]);
                }
                else {
                    $('#div_temp_payslip .cls_BankName td:nth-child(2)').text(": ICICI");
                }

                if (sem_code == 'S') {
                    $('.s_type').text("Summer");
                }
                else {
                    $('.s_type').text("Winter");
                }

                $('.y_code').text(year_code_alloc);

                //if (fees_data["no_of_installment"] == '1') {
                    $('#div_temp_payslip .payment').text("Full Payment");
                //}
                //else {
                //    $('#div_temp_payslip .payment').text("Partial Payment");
                //}

                
                    setCellData('cls_StudentCode', ": " + user_id);

                    $('#div_temp_payslip .cls_Amount td:nth-child(2)').text(": " + fees_data["amount"] + "/-");

                    var rupees = 'Rupees ' + convert_number(fees_data["amount"]) + ' Only';

                    $('#div_temp_payslip .cls_AmountInWords td:nth-child(2)').html("&nbsp;&nbsp;");
                    for (var j = 0; j < rupees.length; j++) {
                        //if (j != 0 && j % 37 == 0) $('#div_temp_payslip .cls_AmountInWords td:nth-child(2)').append('<br/>');

                        $('#div_temp_payslip .cls_AmountInWords td:nth-child(2)').append(rupees[j]);
                    }
                
                $('#div_payslip_all').append($('#div_temp_payslip').html());
                $('#div_temp_payslip').html('');
            }
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

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>
    <style type="text/css">
        body
        {
            /*width: 20.05cm;*/
            margin: 0 auto;
            font-size: 20px;
            padding-top: 20px;
            padding-left: 17px;
            font-family: Calibri;
        }.div_container
        {
            border: 1px solid black;
            height: 9.02cm;
        }

        .div_left
        {
            float: left;
            width: 58%;
        }

        .div_right
        {
            float: left;
            width: 41%;
            border-left: 1px solid black;
        }

        table tr td
        {
            border-left: 1px solid black;
            border-bottom: 1px solid black;
            min-width: 15px;
            border: none;
            vertical-align: baseline;
        }

            table tr td:first-child
            {
                border-left: 0px;
            }

            table tr td:last-child
            {
                /*border-right: 1px solid black;*/
            }

        .table_left tr td:nth-child(2)
        {
            border-bottom: 0px !important;
        }

        .table_left tr:last-child td:nth-child(2)
        {
            border-bottom: 1px solid black !important;
        }

        .table_left tr td
        {
            text-align: center;
        }

            .table_left tr td:first-child, .cls_StudentName td:nth-child(3), .cls_AmountInWords td:nth-child(3), .cls_Amount td:nth-child(3)
            {
                text-align: left;
            }

        .table_right tr td
        {
            font-size: 12px;
        }

        .table_right tr:first-child td, .table_right tr:nth-child(2) td
        {
            line-height: 14px;
        }

        .bottom_zero
        {
            border-bottom: 0px !important;
        }

        .right_zero
        {
            border-right: 0px !important;
        }

        .font12
        {
            font-size: 12px !important;
        }

        .set_padding td
        {
            padding: 0 1px;
        }

        .marg_top
        {
            margin-top: 20px;
        }

        .cls_StudentName td:nth-child(3)
        {
            text-transform: capitalize;
            max-width: 280px;
        }

        cls_NameOfBranch td:nth-child(3), .cls_StudentName td:nth-child(3)
        {
            height: 22px;
        }

        .cls_Amount td:nth-child(3)
        {
            height: 19px;
        }

        #div_payslip_all table tbody tr td:first-child
        {
            padding-left: 0;
        }
    </style>
</head>
<body>
    
<div id="div_payslip_all"></div>
<div id="div_temp_payslip"></div>

<div id="div_blank_payslipp" style="display: none;">
        <div>
            <div style="width: 47%; float: left; padding: 1%; border-right: 1px solid black;">
                <div>
                    <div style="width: 50%; float: left;">
                        <img src="../../image/Capture.PNG" />
                    </div>
                    <div style="width: 50%; float: right; text-align: right;">
                        ELECTRONIC RECEIPT
                        <div>Student Copy</div>
                    </div>
                </div>
                <div style="clear: both;"></div>
                <div>
                    <p>
                        CEPT University, Kasturbhai Lalbhai Campus, University Road,
                        Navrangpura, Ahmedabad‐380009, Gujarat India
                        <br />
                        <br />
                        PAN: AAAJC0452C
                    </p>
                </div>
                <div>
                    <table cellpadding="5">
                        <tr class="cls_StudentCode">
                            <td style="width:155px;">Student Code</td>
                            <td></td>
                        </tr>
                        <tr class="cls_StudentName">
                            <td>Student Name</td>
                            <td></td>
                        </tr>
                        <%--<tr>
                            <td>Father’s Name &nbsp;&nbsp;&nbsp;&nbsp;:
                            </td>
                            <td>LORIUM
                            </td>
                        </tr>--%>
                        <tr class="cls_ProgramName" style="display:none;">
                            <td>Program Name</td>
                            <td></td>
                        </tr>
                        <tr class="cls_Amount">
                            <td>A sum of Rs</td>
                            <td></td>
                        </tr>
                        <tr class="cls_AmountInWords">
                            <td></td>
                            <td style="font-style: italic;"></td>
                        </tr>
                        <tr>
                            <td>Payment Mode</td>
                            <td>: Online
                            </td>
                        </tr>
                        <tr class="cls_TransactionId">
                            <td>Transaction ID</td>
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
                <div>
                    Received On account of Tuition Fee for <span class="s_type"></span> School
                    <span class="y_code"></span> 
                    <%--being <span class="payment"></span>--%>
                    <div style="font-style: italic;">Fee once paid is not Refundable</div>
                </div>
                <br />
                <div>
                    This is a computer generated fee Receipt, hence authorized
                    signature not required.
                </div>
                <br />
                <div style="font-style: italic; text-align: justify;">
                    Students agree conduct themselves within the ambits of CEPT IT policy in force.
                    Students agree that only software with appropriate licenses will be installed and/or
                    used and/or stored on their computer systems/tablets/mobile phones allotted to
                    them and in their control, or on their personal devices which use any University
                    resources. Any liability arising out of any unauthorized usage will solely be of the
                    student, and not of the university. The university may take appropriate actions
                    against students found violating CEPT IT Policy.
                </div>
            </div>

            <div style="width: 47%; float: left; padding: 1%;">
                <div>
                    <div style="width: 50%; float: left;">
                        <img src="../../image/Capture.PNG" />
                    </div>
                    <div style="width: 50%; float: right; text-align: right;">
                        ELECTRONIC RECEIPT
                        <div>Institution Copy</div>
                    </div>
                </div>
                <div style="clear: both;"></div>
                <div>
                    <p>
                        CEPT University, Kasturbhai Lalbhai Campus, University Road,
                        Navrangpura, Ahmedabad‐380009, Gujarat India
                        <br />
                        <br />
                        PAN: AAAJC0452C
                    </p>
                </div>
                <div>
                    <table cellpadding="5">
                        <tr class="cls_StudentCode">
                            <td style="width:155px;">Student Code</td>
                            <td></td>
                        </tr>
                        <tr class="cls_StudentName">
                            <td>Student Name</td>
                            <td></td>
                        </tr>
                        <%--<tr>
                            <td>Father’s Name &nbsp;&nbsp;&nbsp;&nbsp;:
                            </td>
                            <td>LORIUM
                            </td>
                        </tr>--%>
                        <tr class="cls_ProgramName" style="display:none;">
                            <td>Program Name</td>
                            <td></td>
                        </tr>
                        <tr class="cls_Amount">
                            <td>A sum of Rs</td>
                            <td></td>
                        </tr>
                        <tr class="cls_AmountInWords">
                            <td></td>
                            <td style="font-style: italic;"></td>
                        </tr>
                        <tr>
                            <td>Payment Mode</td>
                            <td>: Online
                            </td>
                        </tr>
                        <tr class="cls_TransactionId">
                            <td>Transaction ID</td>
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
                <div>
                    Received On account of Tuition Fee for <span class="s_type"></span> School
                    <span class="y_code"></span> 
                    <%--being <span class="payment"></span>--%>
                    <div style="font-style: italic;">Fee once paid is not Refundable</div>
                </div>
                <br />
                <div>
                    This is a computer generated fee Receipt, hence authorized
                    signature not required.
                </div>
                <br />
                <div style="font-style: italic; text-align: justify;">
                    Students agree conduct themselves within the ambits of CEPT IT policy in force.
                    Students agree that only software with appropriate licenses will be installed and/or
                    used and/or stored on their computer systems/tablets/mobile phones allotted to
                    them and in their control, or on their personal devices which use any University
                    resources. Any liability arising out of any unauthorized usage will solely be of the
                    student, and not of the university. The university may take appropriate actions
                    against students found violating CEPT IT Policy.
                </div>
            </div>
        </div>

        <div style="clear: both;"></div>

        <div style="page-break-after: always;"></div>
    </div>

<div id="div_print">


</div>

<div id="div_fees" style="display:none">
<%-- <div id="main_fees" align="center" x:publishsource="Excel" style="display: none">--%>
 <div id="main_fees"  align="center" x:publishsource="Excel" style="display: block; page-break-after: always;">
        <table border="0" cellpadding="0" cellspacing="0" width="1454" class="xl6512954"
            style='border-collapse: collapse; width: 1091pt; table-layout: fixed'>
            <col class="xl6512954" width="148" style='mso-width-source: userset; mso-width-alt: 5412;
                width: 111pt'>
            <col class="xl6512954" width="16" span="4" style='mso-width-source: userset; mso-width-alt: 585;
                width: 12pt'>
            <col class="xl6512954" width="15" style='mso-width-source: userset; mso-width-alt: 548;
                width: 11pt'>
            <col class="xl6512954" width="16" span="8" style='mso-width-source: userset; mso-width-alt: 585;
                width: 12pt'>
            <col class="xl6512954" width="21" style='mso-width-source: userset; mso-width-alt: 768;
                width: 16pt'>
            <col class="xl6512954" width="99" style='mso-width-source: userset; mso-width-alt: 3620;
                width: 74pt'>
            <col class="xl6512954" width="145" style='mso-width-source: userset; mso-width-alt: 5302;
                width: 109pt'>
            <col class="xl6512954" width="16" span="5" style='mso-width-source: userset; mso-width-alt: 585;
                width: 12pt'>
            <col class="xl6512954" width="19" style='mso-width-source: userset; mso-width-alt: 694;
                width: 14pt'>
            <col class="xl6512954" width="16" span="5" style='mso-width-source: userset; mso-width-alt: 585;
                width: 12pt'>
            <col class="xl6512954" width="21" style='mso-width-source: userset; mso-width-alt: 768;
                width: 16pt'>
            <col class="xl6512954" width="25" style='mso-width-source: userset; mso-width-alt: 914;
                width: 19pt'>
            <col class="xl6512954" width="20" style='mso-width-source: userset; mso-width-alt: 731;
                width: 15pt'>
            <col class="xl6512954" width="90" style='mso-width-source: userset; mso-width-alt: 3291;
                width: 68pt'>
            <col class="xl6512954" width="175" style='mso-width-source: userset; mso-width-alt: 6400;
                width: 131pt'>
            <col class="xl6512954" width="16" span="13" style='mso-width-source: userset; mso-width-alt: 585;
                width: 12pt'>
            <col class="xl6512954" width="13" style='mso-width-source: userset; mso-width-alt: 475;
                width: 10pt'>
            <col class="xl6512954" width="16" span="2" style='mso-width-source: userset; mso-width-alt: 585;
                width: 12pt'>
            <col class="xl6512954" width="0" span="3" style='display: none; mso-width-source: userset;
                mso-width-alt: 0'>
            <col class="xl6512954" width="50" style='mso-width-source: userset; mso-width-alt: 2596;
                width: 53pt'>
            <tr class="xl6512954" height="16" style='height: 12.0pt'>
                <td colspan="16" height="16" class="xl10212954" width="475" style='height: 12.0pt;
                    width: 356pt'>
                    <center>
                        Student/Applicant copy</center>
                </td>
                <td colspan="16" class="xl10212954" width="480" style='border-left: none; width: 361pt'>
                    <center>
                        Institution Copy</center>
                </td>
                <td colspan="16" style='border-left: none; width: 374pt; padding-left: 102;'>
                    <center>
                        Bank's Copy</center>
                </td>
            </tr>
            <tr class="xl6512954" height="21" style='mso-height-source: userset; height: 16.35pt'>
                <td rowspan="3" height="51" class="xl10312954" style='height: 40.05pt'>
                    <%--<img style="margin-top: 2px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />--%>
                    <img style="margin-top: 2px" src="<%= Page.ResolveClientUrl("~/image/Capture.png") %>" />
                </td>
                <td colspan="14" style="padding-left: 18px;" class="xl6612954">
                    CEPT UNIVERSITY
                </td>
                <td rowspan="3" height="51" width="99" style='height: 40.05pt; width: 74pt' align="left"
                    valign="top" class="style56">
                    <![if !vml]><span style='mso-ignore: vglayout; position: absolute; z-index: 1; margin-left: 2px;
                        margin-top: 7px; width: 94px; height: 29px'>
                        <img style="margin-top: 7px; margin-left: -33px;" src="<%= Page.ResolveClientUrl("~/image/icicibanglogo.png") %>" />
                    </span><![endif]><span style='mso-ignore: vglayout2'>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td rowspan="3" height="51" class="xl10412954" width="99" style='height: 40.05pt;
                                    width: 74pt'>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </span>
                </td>
                <td rowspan="3" class="xl10312954">
                    <%--<img style="margin-top: 2px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />--%>
                    <img style="margin-top: 2px" src="<%= Page.ResolveClientUrl("~/image/Capture.png") %>" />
                </td>
                <td colspan="14" style="padding-left: 18px;">
                    CEPT UNIVERSITY
                </td>
                <td rowspan="3" height="51" width="90" style='height: 40.05pt; width: 68pt' align="left"
                    valign="top" class="style56">
                    <![if !vml]><span style='mso-ignore: vglayout; position: absolute; z-index: 2; margin-left: 2px;
                        margin-top: 8px; width: 85px; height: 29px'>
                        <img style="margin-top: 7px; margin-left: -33px;" src="<%= Page.ResolveClientUrl("~/image/icicibanglogo.png") %>" />
                    </span><![endif]><span style='mso-ignore: vglayout2'>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td rowspan="3" height="51" class="xl10412954" width="90" style='height: 40.05pt;
                                    width: 68pt'>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </span>
                </td>
                <td rowspan="3" class="xl10312954">
                    <%--<img style="margin-top: 2px" src="<%= Page.ResolveClientUrl("~/image/cept_lates_payslip_logo.png") %>" />--%>
                    <img style="margin-top: 2px" src="<%= Page.ResolveClientUrl("~/image/Capture.png") %>" />
                </td>
                <td colspan="14" style="padding-left: 18px;">
                    CEPT UNIVERSITY
                </td>
                <td colspan="6" rowspan="3" height="51" width="103" style='height: 40.05pt; width: 77pt'
                    align="left" valign="top">
                    <![if !vml]><span style='mso-ignore: vglayout; position: absolute; z-index: 3; margin-left: 5px;
                        margin-top: 4px; width: 84px; height: 29px'>
                        <img style="margin-top: 7px; margin-left: -33px;" src="<%= Page.ResolveClientUrl("~/image/icicibanglogo.png") %>" />
                    </span><![endif]><span style='mso-ignore: vglayout2'>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td colspan="6" rowspan="3" height="51" class="xl6612954" width="103" style='height: 40.05pt;
                                    width: 77pt'>
                                </td>
                            </tr>
                        </table>
                    </span>
                </td>
            </tr>
            <tr class="xl6512954" height="15" style='mso-height-source: userset; height: 11.85pt'>
                <td colspan="14" rowspan="2" height="30" class="xl10712954" style='height: 23.7pt;
                    padding-left: 40;'>
                    Ahmedabad
                </td>
                <td colspan="14" rowspan="2" class="xl10712954" style="padding-left: 40;">
                    Ahmedabad
                </td>
                <td colspan="14" rowspan="2" class="xl10712954" style="padding-left: 40;">
                    Ahmedabad
                </td>
            </tr>
            <tr class="xl6512954" height="15" style='mso-height-source: userset; height: 11.85pt'>
            </tr>
            <tr class="xl6512954" height="20" style='mso-height-source: userset; height: 15.0pt'>
                <td height="20" class="style2" style='height: 15.0pt'>
                    Branch Sol Id
                </td>
                <td colspan="15" class="style56" style='border-left: none'>
                    &nbsp;
                </td>
                <td height="20" class="style2" style='height: 15.0pt'>
                    Branch Sol Id
                </td>
                <td colspan="15" class="style56" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="style2">
                    Branch Sol Id
                </td>
                <td colspan="15">
                    &nbsp;
                </td>
            </tr>
            <tr height="21" style='mso-height-source: userset; height: 15.75pt'>
                <td height="21" class="style2" style='height: 15.75pt; border-top: none'>
                    Name of Branch
                </td>
                <td class="style56" colspan="15" style='border-top: none; border-left: none'>
                    <label class="lbl_name_of_branch">
                    </label>
                </td>
                <td height="21" class="style2" style='height: 15.75pt; border-top: none'>
                    Name of Branch
                </td>
                <td class="style56" colspan="15" style='border-top: none; border-left: none'>
                    <label class="lbl_name_of_branch">
                    </label>
                </td>
                <td class="style2">
                    Name of Branch
                </td>
                <td colspan="15">
                    <label class="lbl_name_of_branch">
                    </label>
                </td>
            </tr>
            <tr height="16" style='height: 12.0pt'>
                <td height="16" class="style2" style='height: 12.0pt'>
                    Date of Deposit
                </td>
                <td class="style56" colspan="15">
                    <label class='lbldateofdeposit'>
                    </label>
                </td>
                <td class="style2">
                    Date of Deposit
                </td>
                <td class="style56" colspan="15">
                    <label class='lbldateofdeposit'>
                    </label>
                </td>
                <td class="style2">
                    Date of Deposit
                </td>
                <td colspan="18">
                    <label class='lbldateofdeposit'>
                    </label>
                </td>
            </tr>
            <%--<tr height="16" style='height: 12.0pt'>
                <td height="16" class="xl7512954" style='height: 12.0pt'>
                    &nbsp;
                </td>
                <td colspan="15"  class="style56">
                    D<span style='mso-spacerun: yes'>&nbsp; </span>D/M<span style='mso-spacerun: yes'>&nbsp;
                    </span>M/Y<span style='mso-spacerun: yes'>&nbsp;&nbsp; </span>Y
                </td>
                <td class="xl7212954">
                </td>
                
               <td colspan="15"  class="style56">
                    D<span style='mso-spacerun: yes'>&nbsp; </span>D/M<span style='mso-spacerun: yes'>&nbsp;
                    </span>M/Y<span style='mso-spacerun: yes'>&nbsp;&nbsp; </span>Y
                </td>
               <td class="xl7212954">
                </td>
                <td colspan="15" >
                    D<span style='mso-spacerun: yes'>&nbsp; </span>D/M<span style='mso-spacerun: yes'>&nbsp;
                    </span>M/Y<span style='mso-spacerun: yes'>&nbsp;&nbsp; </span>Y
                </td>
                
            </tr>--%>
            <tr height="16" style='height: 12.0pt'>
                <td height="16" class="style2" style='height: 12.0pt'>
                    PAN No. of Institution
                </td>
                <td class="style56" colspan="15">
                    <label class="lbl_pan_no">
                    </label>
                </td>
                <td class="style2">
                    PAN No. of Institution
                </td>
                <td class="style56" colspan="15">
                    <label class="lbl_pan_no">
                    </label>
                </td>
                <td class="style2">
                    PAN No. of Institution
                </td>
                <td colspan="15">
                    <label class="lbl_pan_no">
                    </label>
                </td>
            </tr>
            <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
                <td height="22" class="style2" style='height: 16.5pt'>
                    Account to be credited
                </td>
                <td colspan="15" class="style56">
                    <label class="lbl_bank_code">
                    </label>
                </td>
                <td class="style2">
                    Account to be credited
                </td>
                <%--  <td class="xl7212954">
                </td>--%>
                <td colspan="15" class="style56">
                    <label class="lbl_bank_code">
                    </label>
                </td>
                <td class="style2">
                    Account to be credited:
                </td>
                <td colspan="15">
                    <label class="lbl_bank_code">
                    </label>
                </td>
            </tr>
            <tr height="32" style='mso-height-source: userset; height: 24.0pt'>
                <td height="32" class="style2">
                    1. Institution Name
                </td>
                <td class="style56" colspan='15'>
                    <label class="lbl_name_of_institute">
                    </label>
                </td>
                <td height="32" class="style2">
                    1. Institution Name
                </td>
                <td class="style56" colspan='15'>
                    <label class="lbl_name_of_institute">
                    </label>
                </td>
                <td class="style2" width="175" style='width: 131pt'>
                    1. Institution Name
                </td>
                <td colspan='15'>
                    <label class="lbl_name_of_institute">
                    </label>
                </td>
            </tr>
            <tr height="23" style='mso-height-source: userset; height: 17.25pt'>
                <td height="23" class="style2" width="148" style='height: 17.25pt; width: 111pt'>
                    2.Student Name<span style='mso-spacerun: yes'>&nbsp;</span>
                </td>
                <td class="style56" colspan='15'>
                    <label class="lbl_student_name">
                    </label>
                </td>
                <td height="23" class="style2" width="148" style='height: 17.25pt; width: 111pt'>
                    2.Student Name<span style='mso-spacerun: yes'>&nbsp;</span>
                </td>
                <td class="style56" colspan='15'>
                    <label class="lbl_student_name">
                    </label>
                </td>
                <td class="style2" width="148" style='border-left: none; width: 131pt'>
                    2.Student Name :
                </td>
                <td colspan="15">
                    <label class="lbl_student_name">
                    </label>
                </td>
            </tr>
            <tr height="25" style='mso-height-source: userset; height: 18.75pt'>
                <td height="25" class="style2">
                    3. Roll No./Student Id
                </td>
                <td class="style56" colspan='15'>
                    <label class="lbl_student_code">
                    </label>
                </td>
                <td class="style2">
                    3. Roll No./Student Id
                </td>
                <td class="style56" colspan='15'>
                    <label class="lbl_student_code">
                    </label>
                </td>
                <td class="style2">
                    3. Roll No./Student Id
                </td>
                <td colspan='15'>
                    <label class="lbl_student_code">
                    </label>
                </td>
            </tr>
            <tr>
                <td height="17" class="style2">
                    4. Class/Sem/Year
                </td>
                <td class="style56" colspan='15'>
                    <lable class="lbl_sem_code"></lable>
                </td>
                <td height="17" class="style2">
                    4. Class/Sem/Year
                </td>
                <td class="style56" colspan='15'>
                    <lable class="lbl_sem_code"></lable>
                </td>
                <td class="style2">
                    4. Class/Sem/Year
                </td>
                <td colspan='15'>
                    <lable class="lbl_sem_code"></lable>
                </td>
            </tr>
            <tr height="19" style='mso-height-source: userset; height: 14.25pt'>
                <td height="19" class="style2">
                    5. Course /Section
                </td>
                <td class="style56" colspan="15">
                    <label class="lbl_course_section">
                    </label>
                </td>
                <td height="19" class="style2">
                    5. Course /Section
                </td>
                <td class="style56" colspan="15">
                    <label class="lbl_course_section">
                    </label>
                </td>
                <td class="style2" width="175" style='width: 131pt'>
                    5. Course /Section
                </td>
                <td colspan="18">
                    <label class="lbl_course_section">
                    </label>
                </td>
            </tr>
            <tr height="17" style='mso-height-source: userset; height: 12.75pt'>
                <td height="17" class="style2">
                    6. Amount
                </td>
                <td colspan="15" class="style56">
                    <label class="lbl_amount1">
                    </label>
                </td>
                <td height="17" class="style2">
                    6. Amount
                </td>
                <td colspan="15" class="style56">
                    <label class="lbl_amount1">
                    </label>
                </td>
                <td height="17" class="style2">
                    6. Amount
                </td>
                <td colspan="18">
                    <label class="lbl_amount1">
                    </label>
                </td>
            </tr>
            <tr height="26" style='mso-height-source: userset; height: 19.5pt'>
                <td height="26" class="style2">
                    7. Amount in words
                </td>
                <td colspan="15" class="style56">
                    <lable class='lbl_amount_in_word1'></lable>
                </td>
                <td height="26" class="style2">
                    7. Amount in words
                </td>
                <td colspan="15" class="style56">
                    <lable class='lbl_amount_in_word1'></lable>
                </td>
                <td class="style2">
                    7. Amount in words
                </td>
                <td colspan="18" class="xl8412954" width="237" style='width: 178pt'>
                    <lable class='lbl_amount_in_word1'></lable>
                </td>
            </tr>
            <tr height="28" style='mso-height-source: userset; height: 21.0pt'>
                <td height="28" class="style2">
                    8. Cash Details
                </td>
                <td class="style56" colspan="15">
                </td>
                <td height="28" class="style2">
                    8. Cash Details
                </td>
                <td class="style56" colspan="15">
                </td>
                <td class="style2">
                    8. Cash Details
                </td>
                <td colspan="18">
                </td>
            </tr>
            <tr height="21" style='mso-height-source: userset; height: 15.75pt'>
                <td height="21" class="style2" style='height: 15.75pt'>
                    Denomination
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    Amount
                </td>
                <td colspan="7">
                </td>
                <td class="style2">
                    Denomination
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    Amount
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2">
                    Denomination
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    Amount
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
                <td height="20" class="style2" width="148" style='height: 15.0pt; border-top: none;
                    width: 111pt'>
                    1000 X<span style='mso-spacerun: yes'>&nbsp;</span>
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" width="145" style='border-top: none; width: 109pt'>
                    1000 X<span style='mso-spacerun: yes'>&nbsp;</span>
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" width="175" style='border-top: none; width: 131pt'>
                    1000 X<span style='mso-spacerun: yes'>&nbsp;</span>
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="17" style='mso-height-source: userset; height: 12.75pt'>
                <td height="17" class="style2" style='height: 12.75pt; border-top: none'>
                    500<span style='mso-spacerun: yes'>&nbsp; </span>X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    500<span style='mso-spacerun: yes'>&nbsp; </span>X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    500<span style='mso-spacerun: yes'>&nbsp; </span>X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="18" style='mso-height-source: userset; height: 13.5pt'>
                <td height="18" class="style2" style='height: 13.5pt; border-top: none'>
                    100 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    100 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    100 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="14" style='mso-height-source: userset; height: 10.5pt'>
                <td height="14" class="style2" style='height: 10.5pt; border-top: none'>
                    50<span style='mso-spacerun: yes'>&nbsp; </span>X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    50<span style='mso-spacerun: yes'>&nbsp; </span>X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    50<span style='mso-spacerun: yes'>&nbsp; </span>X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="15" style='mso-height-source: userset; height: 11.25pt'>
                <td height="15" class="style2" style='height: 11.25pt; border-top: none'>
                    20 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    20 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    20 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
                <td height="20" class="style2" style='height: 15.0pt; border-top: none'>
                    10 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    10 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    10 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
                <td height="20" class="style2" style='height: 15.0pt; border-top: none'>
                    5 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    5 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    5 X
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="22" style='mso-height-source: userset; height: 16.5pt'>
                <td height="22" class="style2" style='height: 16.5pt; border-top: none'>
                    Total
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="style56" width="99" style='width: 74pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    Total
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="21" style='width: 16pt'>
                </td>
                <td class="xl8412954" width="25" style='width: 19pt'>
                </td>
                <td class="xl8412954" width="20" style='width: 15pt'>
                </td>
                <td class="style56" width="90" style='width: 68pt'>
                </td>
                <td class="style2" style='border-top: none'>
                    Total
                </td>
                <td colspan="8" class="style2" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="13" style='width: 10pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="16" style='width: 12pt'>
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="0">
                </td>
                <td class="xl8412954" width="71" style='width: 53pt'>
                </td>
            </tr>
            <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
                <td height="20" class="style2" width="148" style="height: 15.0pt; border-top: none;
                    width: 111pt; font-size: 15px">
                    9.Depositor Contact No.
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="style56">
                    &nbsp;
                </td>
                <td class="style2" width="145" style='border-top: none; width: 109pt; font-size: 15px'>
                    9.Depositor Contact No.
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="style56">
                    &nbsp;
                </td>
                <td class="style2" width="145" style='border-top: none; width: 131pt; font-size: 15px'>
                    9.Depositor Contact No.
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-top: none; border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7112954" style='border-left: none'>
                    &nbsp;
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7412954">
                    &nbsp;
                </td>
            </tr>
            <tr height="30" style='mso-height-source: userset; height: 22.5pt'>
                <td height="30" class="style2" width="148" style='height: 22.5pt; border-top: none;
                    width: 111pt'>
                    Cheque / Payorder / DD No.
                </td>
                <td colspan="4" class="xl9012954">
                    &nbsp;
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl9112954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9012954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl9212954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="style56" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="style2" width="145" style='width: 109pt'>
                    Cheque / Payorder / DD No.
                </td>
                <td colspan="4" class="xl9012954">
                    &nbsp;
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl9112954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9012954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl9212954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="style56" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="style2" width="175" style='width: 131pt'>
                    Cheque / Payorder / DD No.
                </td>
                <td colspan="4" class="xl9012954">
                    &nbsp;
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl9112954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9012954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl9212954">
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9312954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9012954" style='border-top: none'>
                    &nbsp;
                </td>
                <td class="xl9512954">
                    &nbsp;
                </td>
            </tr>
            <tr height="21" style='mso-height-source: userset; height: 15.75pt'>
                <td height="21" class="style2" width="148" style='height: 15.75pt; border-top: none;
                    width: 111pt'>
                    Payable At Branch:
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl9612954">
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="style56">
                    &nbsp;
                </td>
                <td class="style2">
                    Payable At Branch:
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl9812954">
                    <u style='visibility: hidden; mso-ignore: visibility'>&nbsp;</u>
                </td>
                <td class="xl9912954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="style56">
                    &nbsp;
                </td>
                <td class="style2">
                    Payable At Branch:
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl9812954">
                    <u style='visibility: hidden; mso-ignore: visibility'>&nbsp;</u>
                </td>
                <td class="xl9912954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl9712954">
                    &nbsp;
                </td>
                <td class="xl10012954">
                    &nbsp;
                </td>
            </tr>
            <tr height="46" style='mso-height-source: userset; height: 34.5pt'>
                <td height="46" class="style2" width="148" style='height: 34.5pt; border-top: none;
                    width: 111pt'>
                    Transaction ID (Mandatorily filled by Bank Officials)
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="style56">
                    &nbsp;
                </td>
                <td class="style2" width="145" style='width: 109pt'>
                    Transaction ID (Mandatorily filled by Bank Officials)
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="style56">
                    &nbsp;
                </td>
                <td class="style2" width="175" style='width: 131pt'>
                    Transaction ID (Mandatorily filled by Bank Officials)
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7312954">
                    &nbsp;
                </td>
                <td class="xl7412954">
                    &nbsp;
                </td>
            </tr>
            <tr height="20" style='mso-height-source: userset; height: 15.0pt'>
                <td height="20" class="style2" width="148" style='height: 15.0pt; border-top: none;
                    width: 111pt'>
                    &nbsp;
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="style56">
                </td>
                <td class="style2" width="145" style='width: 109pt'>
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="style56">
                </td>
                <td class="style2" width="145" style='width: 131pt'>
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7412954">
                    &nbsp;
                </td>
            </tr>
            <tr height="16" style='height: 12.0pt'>
                <td height="16" class="style2" width="148" style='height: 12.0pt; border-top: none;
                    width: 111pt'>
                    Signature/ Stamp
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td>
                </td>
                <td class="style56" colspan="4">
                    Signature of Depositor
                </td>
                <td class="style2">
                    Signature/ Stamp
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="style56" colspan="4">
                    Signature of Depositor
                </td>
                <td class="style2">
                    Signature/ Stamp
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954" colspan="9" style='border-right: .5pt solid black'>
                    Signature of Depositor
                </td>
            </tr>
            <tr height="16" style='height: 12.0pt'>
                <td height="16" class="style2" width="148" style='height: 12.0pt; border-top: none;
                    width: 111pt'>
                    ICICI Bank Ltd
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="style56">
                </td>
                <td class="style2">
                    ICICI Bank Ltd
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="style56">
                </td>
                <td class="style2">
                    ICICI Bank Ltd
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7212954">
                </td>
                <td class="xl7412954">
                    &nbsp;
                </td>
            </tr>
            <tr height="40" style='mso-height-source: userset; height: 30.0pt'>
                <td colspan="16" height="40" width="475" style='height: 30.0pt; width: 356pt' class="style56">
                    * must be drawn payable at the centre of deposit of the instrument i.e. outstation<span
                        style='mso-spacerun: yes'>&nbsp; </span>instruments not acceptable
                </td>
                <td colspan="16" width="480" style='width: 361pt' class="style56">
                    * must be drawn payable at the centre of deposit of the instrument i.e. outstation<span
                        style='mso-spacerun: yes'>&nbsp; </span>instruments not acceptable
                </td>
                <td colspan="18" width="412" style='width: 309pt'>
                    * must be drawn payable at the centre of deposit of the instrument i.e. outstation<span
                        style='mso-spacerun: yes'>&nbsp; </span>instruments not acceptable
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl6512954">
                </td>
                <td class="xl6512954">
                </td>
            </tr>

            <tr height="0" id="online_trans" style="mso-height-source: userset; height: 30.0pt">
                <td width="148" style='width: 111pt'>
                  <label class="lbl_trans_name"></label>
                </td>
                <td colspan="15" width="16" style='width: 12pt'>
                    <label class="lbl_trans_id">
                    </label>
                </td>
                <td width="148" style='width: 111pt'>
                     <label class="lbl_trans_name"></label>
                </td>
                <td colspan="15" width="16" style='width: 12pt'>
                    <label class="lbl_trans_id">
                    </label>
                </td>
                <td width="148" style='width: 111pt'>
                    <label class="lbl_trans_name"></label>
                </td>
                <td colspan="15" width="16" style='width: 12pt'>
                    <label class="lbl_trans_id">
                    </label>
                </td>
            </tr>
                 <%--<tr  style="height: 12.0pt; display:none" id="online_trans">
            
                <td colspan="15" width="16" style='width: 12pt'>
                    Transaction Id: <label class="lbl_trans_id">
                    </label>
                </td>
                <td colspan="15" width="16" style='width: 12pt'>
                    Transaction Id: <label class="lbl_trans_id">
                    </label>
                </td>
                 <td colspan="15" width="16" style='width: 12pt'>
                    Transaction Id: <label class="lbl_trans_id">
                    </label>
                </td>
            </tr>--%>
            

            <![endif]>
        </table>
    </div>
    </div>
    

</body>
</html>
