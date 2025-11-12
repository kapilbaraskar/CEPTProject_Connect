<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="sws_payment_dtl.aspx.cs" Inherits="Student_sws_payment_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var status = false;
        var oTable1;
        var oTable2;
        var oTable3;
        var mandatory_popup_status = false;
        $(document).ready(function ()
        {
            //check_payment_resopnse(); //23052024
            databind();
            $('#btnpaynow').on('click', function () {
                //if (mandatory_popup_status == false) {

                //    var r = confirm("Do you Want to select Mandatory Course ?");
                //    if (r == true) {

                //        var origin = window.location.origin;
                //        window.location.replace(origin + "/Student/" + "sws_mandatory_course_dtl.aspx");
                //        return false;
                //    }
                //    else
                //    {
                //        pay_sws_fees();
                //    }
                //}
                //else { pay_sws_fees(); }

                pay_sws_fees();
            });

            $('#btn_submit').on('click', function () {
                //if (mandatory_popup_status == false) {

                //    var r = confirm("Do you Want to select Mandatory Course ?");
                //    if (r == true) {

                //        var origin = window.location.origin;
                //        window.location.replace(origin + "/Student/" + "sws_mandatory_course_dtl.aspx");
                //        return false;
                //    }
                //    else {
                //        winthout_pay_sws_fees();
                //    }
                //}
                //else {
                //    winthout_pay_sws_fees();
                //}

                winthout_pay_sws_fees();

            });

            $(document).on("click", ".offline_download", function (event) {
               
                var installment_no = 1;
               // window.open('../Admin/Master/Sw_Print_fees_slip.aspx?semester=S &year_code=2023&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                window.open('../Admin/Master/Sw_Print_fees_slip.aspx?installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
              return false;
                
            });

        });

       
        function pay_sws_fees()
        {
          
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/sws_connect_fees_payment",
                // data: "{student_selection:'" + stud_selection + "',cur_room:'" + cur_room + "'}",
                data: "",
                dataType: "json",
                success: function (data) {
                  
                    if (data.d != "" && data.d != "[]") {
                        if (data.d == 'Online SWS Course fees payment option is currently closed. Please contact SWS office.')
                        {
                            alert('Online SWS Course fees payment option is currently closed. Please contact SWS office.');
                            return false;
                        }
                        else if (data.d == 'Time') {
                            alert('The payment window will be open each day from 10AM to 8PM.');
                            return false;
                        }
                        var result = JSON.parse(data.d);

                        if (result["status"]) {
                            submitFormKotak(result["message"]);
                        }
                        else {
                            alert(result["message"]);
                            return false;
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });


        }


        function winthout_pay_sws_fees() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/sws_course_allocation_dtl_new",
                // data: "{student_selection:'" + stud_selection + "',cur_room:'" + cur_room + "'}",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {

                    if (data.d != "" && data.d != "[]")
                    {
                        if (data.d == 'Course Save Successfully') {
                            alert('Course Registered Successfully');
                            return false;
                        }
                        else
                        {
                            alert(result["message"]);
                            return false;
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });


        }


        function check_payment_resopnse() {
            var isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
            if (isMobile) {
                browserType = "Mobile";
            } else {
                browserType = "Web";
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_payment_status_page_load",
                async: false,
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d[0] != "" && data.d[0] != null) {
                        
                    }
                },
                error: function (result) {
                   // alert(result);
                }
            });
        }

        function databind()
        {
            var with_waiver_credits = 0;
            var fees_waiver_credits = 0;
            var isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
            if (isMobile) {
                browserType = "Mobile";
            } else {
                browserType = "Web";
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_sws_Payment_page_dtl",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    // Check mandatory course Select
                    if (data.d[4] != "" && data.d[4] != null)
                    {
                        mandatory_popup_status = true;
                    }
                    if (data.d[0] != "" && data.d[0] != null)
                    {
                        var first_step_data = JSON.parse(data.d[0]);
                        display_student_Course_reg(data.d[0]);

                        if (data.d[2] != "" && data.d[2] != null)
                        {
                            display_student_Course_man(data.d[2]);
                            if (data.d[3] != "" && data.d[3] != null)
                            {
                                var json_parse = JSON.parse(data.d[2])
                                var credits_dtl = JSON.parse(data.d[3]);
                                var newcredits_dtl = JSON.parse(data.d[5]);
                                if (credits_dtl != null) {
                                    var fees_amount = 0;
                                    fees_waiver_credits = 0;
                                    with_waiver_credits = 0;
                                    if (credits_dtl[0]['fees_waiver_credits'] != '')
                                    {
                                        fees_waiver_credits = parseInt(credits_dtl[0]['fees_waiver_credits']);
                                        with_waiver_credits = parseInt(credits_dtl[0]['fees_waiver_credits']);
                                        
                                        if (fees_waiver_credits != '0')
                                        {
                                            with_waiver_credits = parseInt(credits_dtl[0]['total_allocated_credit']);
                                            if (json_parse[0]['status'] != 'A')
                                            {
                                                with_waiver_credits = parseInt(parseInt(credits_dtl[0]['fees_waiver_credits']) - parseInt(credits_dtl[0]['total_allocated_credit']));
                                            }
                                            
                                        }
                                        
                                    }
                                    var str = '</br><p><b><span style=Color:blue;>Total CREDITS : </span> ' + newcredits_dtl[0]['RegisteredCredits'] + '';
                                    str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Waiver CREDITS : </span> ' + newcredits_dtl[0]['WaiverCredit'] + '</b> ';
                                    str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Paid Fees CREDITS : </span> ' + newcredits_dtl[0]['PaidFeesCredit'] + '</b> ';
                                    str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Allocate CREDITS : </span> ' + newcredits_dtl[0]['ProvisionallyAllocatedCredits'] + '</b></p> ';

                                    var calculatecredit = parseInt(credits_dtl[0]['Total_credits'] - fees_waiver_credits - (credits_dtl[0]['total_credit_pay'] == '' ? 0 : credits_dtl[0]['total_credit_pay']));

                                    if (credits_dtl[0]['payment_response_code'] != '0')
                                    {
                                        //str += '<p><b><span style=Color:blue;>Credits Calculation : </span> ' + credits_dtl[0]['Total_credits'] + ' - ' + fees_waiver_credits + ' - ' + (credits_dtl[0]['total_credit_pay'] == '' ? 0 : credits_dtl[0]['total_credit_pay']) + ' =  ' + (calculatecredit) + ' </b> ';
                                        str += '<p><b><span style=Color:blue;>Credits Calculation : </span> ' + credits_dtl[0]['Total_credits'] + ' - ' + fees_waiver_credits + ' - ' + (credits_dtl[0]['total_credit_pay'] == '' ? 0 : credits_dtl[0]['total_credit_pay']) + ' =  ' + (calculatecredit) + ' </b> ';
                                    }
                                    

                                    str += '<p><b><span style=Color:blue;>Per Credits Fees Amount : </span> ' + credits_dtl[0]['fees_amount'] + '</b> ';
                                    
                                    if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'S')
                                    {
                                        str += '<p><b><span style=Color:blue;>GST : </span>18%</b> ';
                                    }
                                    else if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'P')
                                    {
                                        str += '<p><b><span style=Color:blue;>GST : </span>18%</b> ';
                                    }
                                    
                                    if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'S')
                                    {
                                        if (credits_dtl[0]['total_credit_pay'] != '')
                                        {
                                            //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment'])));
                                            fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));

                                        }
                                        else
                                        {
                                            //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment'])));
                                            fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));
                                        }
                                        var gst_amount = parseInt(parseInt(fees_amount * 18) / 100);
                                        fees_amount = parseInt(fees_amount) + parseInt(gst_amount);
                                        if (fees_amount <= 0)
                                        {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> 0 </b> ';
                                        }
                                        else
                                        {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> ' + fees_amount + '</b> ';
                                        }

                                    }
                                    else if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'P')
                                    {
                                        if (credits_dtl[0]['total_credit_pay'] != '')
                                        {
                                            //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment'])));
                                            fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));
                                        }
                                        else
                                        {
                                            //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment'])));
                                            fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));
                                        }

                                        
                                        var gst_amount = parseInt(parseInt(fees_amount * 18) / 100);
                                        fees_amount = parseInt(fees_amount) + parseInt(gst_amount);
                                        if (fees_amount <= 0) {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> 0 </b> ';
                                        }
                                        else {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> ' + fees_amount + '</b> ';
                                        }

                                    }
                                    else if (credits_dtl[0]['user_type'] == 'S')
                                    {
                                        if (credits_dtl[0]['total_credit_pay'] != '')
                                        {

                                            //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment'])));
                                            fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));
                                           
                                        }
                                        else
                                        {
                                            //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment'])));
                                            fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));
                                            
                                        }

                                        
                                         if (fees_amount < 0) {
                                             str += '</br><p><b><span style=Color:blue;>Total Fees : </span> 0 </b> ';
                                         }
                                         else
                                         {
                                             if (credits_dtl[0]['total_credit_pay'] != '')
                                             {
                                                // str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment']))) + '</b> ';
                                                 str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay']))) + '</b> ';
                                             
                                             }
                                             else {
                                                 //str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits_remaning_payment']))) + '</b> ';
                                                 str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay']))) + '</b> ';
                                             
                                             }
                                             
                                         }

                                     }


                                    $('#credits_dtl').html(str);
                                    $('#credits_dtl').css('display', '');
                                    

                                    if (json_parse[0]['status'] == 'A')
                                    {
                                      
                                        if (credits_dtl[0]['Payment_button_status'] == 'True' && credits_dtl[0]['payment_response_code'] == '0') {
                                            $('#paymentsection').css('display', 'none');
                                            $('#section_download').css('display', '');
                                            $('#status_fees').text("Payment Submitted Successfully");
                                        }
                                        else if (credits_dtl[0]['Total_credits_remaning_payment'] == '0')
                                        {
                                            $('#submit_without_payment').css('display', 'block');
                                        }
                                        else 
                                        {
                                            
                                            $('#paymentsection').css('display', 'block');
                                            $('#submit_without_payment').css('display', 'none');
                                        }
                                        return false;
                                    }

                                    else if (credits_dtl[0]['payment_response_code'] == '0')
                                    {
                                        $('#status_fees').text("Payment Submitted Successfully");
                                        
                                        if (credits_dtl[0]['Payment_button_status'] == 'True' && credits_dtl[0]['payment_response_code'] == '0') {
                                            $('#paymentsection').css('display', 'none');
                                        }
                                        else if (credits_dtl[0]['Total_credits_remaning_payment'] == '0')
                                        {
                                            $('#submit_without_payment').css('display', 'block');
                                        }
                                        else
                                        {
                                            $('#paymentsection').css('display', 'block');
                                            $('#submit_without_payment').css('display', 'none');
                                        }
                                        
                                        return false;
                                    }
                                    if (fees_amount > 0)
                                    {
                                        $('#paymentsection').css('display', '');
                                        
                                    }
                                    else
                                    {
                                        if (credits_dtl[0]['Payment_button_status'] == 'True' && credits_dtl[0]['payment_response_code'] == '0')
                                        {
                                          
                                            $('#paymentsection').css('display', 'none');
                                        }
                                        else if (credits_dtl[0]['Total_credits_remaning_payment'] == '0')
                                        {
                                            $('#submit_without_payment').css('display', 'block');
                                        }
                                        else
                                        {
                                         $('#paymentsection').css('display', 'block');
                                        }

                                    }
                                }
                            }

                        }
                        else if (data.d[1] != "" && data.d[1] != null) {
                            var credits_dtl = JSON.parse(data.d[1]);
                            if (credits_dtl != null) {
                                var fees_amount = 0;
                                var fees_waiver_credits = 0;
                                var newcredits_dtl = JSON.parse(data.d[5]);
                                if (credits_dtl[0]['fees_waiver_credits'] != '') {
                                    fees_waiver_credits = parseInt(credits_dtl[0]['fees_waiver_credits']);
                                }
                                var str = '</br><p><b><span style=Color:blue;>Total CREDITS : </span> ' + newcredits_dtl[0]['RegisteredCredits'] + '';
                                str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Waiver CREDITS : </span> ' + newcredits_dtl[0]['WaiverCredit'] + '</b> ';
                                str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Paid Fees CREDITS : </span> ' + newcredits_dtl[0]['PaidFeesCredit'] + '</b></p> ';



                                var calculatecredit = parseInt(credits_dtl[0]['Total_credits'] - fees_waiver_credits - (credits_dtl[0]['total_credit_pay'] == '' ? 0 : credits_dtl[0]['total_credit_pay']));
                                if (credits_dtl[0]['payment_response_code'] != '0')
                                {
                                    str += '<p><b><span style=Color:blue;>Credits Calculation : </span> ' + credits_dtl[0]['Total_credits'] + ' - ' + fees_waiver_credits + ' - ' + (credits_dtl[0]['total_credit_pay'] == '' ? 0 : credits_dtl[0]['total_credit_pay']) + ' =  ' + (calculatecredit) + ' </b> ';
                                }
                                

                                str += '<p><b><span style=Color:blue;>Per Credits Fees Amount : </span> ' + credits_dtl[0]['fees_amount'] + '</b> ';
                                //if (credits_dtl[0]['user_type'] != 'S')
                                if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'S') {
                                    str += '<p><b><span style=Color:blue;>GST : </span>18%</b> ';
                                }
                                else if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'P')
                                {
                                    str += '<p><b><span style=Color:blue;>GST : </span>18%</b> ';
                                }

                                

                                if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'S')
                                {
                                    if (credits_dtl[0]['total_credit_pay'] != '')
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['total_credit_pay'])));
                                    }
                                    else
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(fees_waiver_credits)));
                                    }

                                   // fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(fees_waiver_credits)));
                                    var gst_amount = parseInt(parseInt(fees_amount * 18) / 100);
                                    fees_amount = parseInt(fees_amount) + parseInt(gst_amount);
                                    if (fees_amount <= 0) {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> 0 </b> ';
                                    }
                                    else {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> ' + fees_amount + '</b> ';
                                    }

                                }
                                else if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'P') {

                                    if (credits_dtl[0]['total_credit_pay'] != '')
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['total_credit_pay'])));
                                    }
                                    else
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(fees_waiver_credits)));
                                    }

                                    
                                    var gst_amount = parseInt(parseInt(fees_amount * 18) / 100);
                                    fees_amount = parseInt(fees_amount) + parseInt(gst_amount);
                                    if (fees_amount <= 0) {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> 0 </b> ';
                                    }
                                    else {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> ' + fees_amount + '</b> ';
                                    }

                                }
                                else if (credits_dtl[0]['user_type'] == 'S') {
                                   
                                    if (credits_dtl[0]['total_credit_pay'] != '')
                                    {
                                        //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['total_credit_pay'])));
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));
                                    }
                                    else
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(newcredits_dtl[0]['RequiredToPay'])));
                                        //fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(fees_waiver_credits)));
                                    }

                                    
                                    if (fees_amount <= 0) {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees : </span> 0 </b> ';
                                    }
                                    else
                                    {
                                        if (credits_dtl[0]['total_credit_pay'] != '')
                                        {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(credits_dtl[0]['amount']) + '</b> ';
                                        }
                                        else
                                        {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(fees_waiver_credits))) + '</b> ';
                                        }
                                        
                                    }

                                }

                                
                                $('#credits_dtl').html(str);
                                $('#credits_dtl').css('display', '');

                                if (first_step_data[0]['status'] == 'A')
                                {
                                    if (credits_dtl[0]['Payment_button_status'] == 'True' && credits_dtl[0]['payment_response_code'] == '0')
                                    {
                                        
                                        $('#paymentsection').css('display', 'none');
                                        $('#section_download').css('display', '');
                                        $('#status_fees').text("Payment Submitted Successfully");
                                    }
                                    else if (credits_dtl[0]['Total_credits_remaning_payment'] == '0')
                                    {
                                        $('#submit_without_payment').css('display', 'block');
                                    }
                                    else
                                    {
                                        
                                        $('#paymentsection').css('display', 'block');
                                        $('#submit_without_payment').css('display', 'none');
                                    }
                                    return false;
                                }

                               else if (credits_dtl[0]['payment_response_code'] == '0')
                                {
                                    $('#section_download').css('display', '');
                                    if (credits_dtl[0]['Payment_button_status'] == 'True' && credits_dtl[0]['payment_response_code'] == '0') {
                                        $('#status_fees').text("Payment Submitted Successfully");
                                        $('#submit_without_payment').css('display', 'none');
                                        $('#paymentsection').css('display', 'none');
                                    }
                                    else if (credits_dtl[0]['Total_credits_remaning_payment'] == '0')
                                    {
                                        $('#submit_without_payment').css('display', 'block');
                                    }
                                    else { $('#paymentsection').css('display', 'block'); }
                                    
                                    return false;
                                }
                                else if (credits_dtl[0]['parameter_value'] == 'D')
                                {
                                    $('#status_fees').text("Online SWS Course fees payment option is currently closed. Please contact SWS office.");
                                    if ($('#hdnuserid').val() == 'ucadmin')
                                    {
                                        $('#paymentsection').css('display', '');
                                    }
                                    else
                                    {

                                        $('#paymentsection').css('display', 'none');
                                        $('#submit_without_payment').css('display', 'none');
                                    }
                                    
                                    return false;
                                }
                                
                                if (fees_amount > 0)
                                {
                                    $('#paymentsection').css('display', '');
                                }
                                else
                                {
                                    $('#paymentsection').css('display', 'none');
                                    $('#submit_without_payment').css('display', 'block');    
                                }
                        }
                        return false;
                    }
                    }

                    else if (data.d[2] != "" && data.d[2] != null)
                    {
                        display_student_Course_man(data.d[2]);
                        if (data.d[3] != "" && data.d[3] != null) {
                            var json_parse = JSON.parse(data.d[2])
                            var credits_dtl = JSON.parse(data.d[3]);
                            var newcredits_dtl = JSON.parse(data.d[5]);
                            if (credits_dtl != null) {
                                var fees_amount = 0;
                                var fees_waiver_credits = 0;
                                var with_waiver_credits = 0;
                                if (credits_dtl[0]['fees_waiver_credits'] != '') {
                                    fees_waiver_credits = parseInt(credits_dtl[0]['fees_waiver_credits']);
                                    with_waiver_credits = parseInt(credits_dtl[0]['fees_waiver_credits']);

                                    if (fees_waiver_credits != '0') {
                                        with_waiver_credits = parseInt(credits_dtl[0]['total_allocated_credit']);
                                        if (json_parse[0]['status'] != 'A') {
                                            with_waiver_credits = parseInt(parseInt(credits_dtl[0]['fees_waiver_credits']) - parseInt(credits_dtl[0]['total_allocated_credit']));
                                        }

                                    }

                                }


                                var str = '</br><p><b><span style=Color:blue;>Total CREDITS : </span> ' + newcredits_dtl[0]['RegisteredCredits'] + '';
                                str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Waiver CREDITS : </span> ' + newcredits_dtl[0]['WaiverCredit'] + '</b> ';
                                str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Paid Fees CREDITS : </span> ' + newcredits_dtl[0]['PaidFeesCredit'] + '</b> ';
                                str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Allocate CREDITS : </span> ' + newcredits_dtl[0]['ProvisionallyAllocatedCredits'] + '</b></p> ';

                                var calculatecredit = parseInt(credits_dtl[0]['Total_credits'] - fees_waiver_credits - (credits_dtl[0]['total_credit_pay'] == '' ? 0 : credits_dtl[0]['total_credit_pay']));
                                if (credits_dtl[0]['payment_response_code'] != '0')
                                {
                                    str += '<p><b><span style=Color:blue;>Credits Calculation : </span> ' + credits_dtl[0]['Total_credits'] + ' - ' + fees_waiver_credits + ' - ' + (credits_dtl[0]['total_credit_pay'] == '' ? 0 : credits_dtl[0]['total_credit_pay']) + ' =  ' + (calculatecredit) + ' </b> ';
                                }
                                

                                str += '<p><b><span style=Color:blue;>Per Credits Fees Amount : </span> ' + credits_dtl[0]['fees_amount'] + '</b> ';

                                if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'S')
                                {
                                    str += '<p><b><span style=Color:blue;>GST : </span>18%</b> ';
                                }
                                else if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'P')
                                {
                                    str += '<p><b><span style=Color:blue;>GST : </span>18%</b> ';
                                }
                                
                                if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'S')
                                {
                                    if (credits_dtl[0]['total_credit_pay'] != '')
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['total_credit_pay'])));
                                    }
                                    else {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(with_waiver_credits)));
                                    }

                                    var gst_amount = parseInt(parseInt(fees_amount * 18) / 100);
                                    fees_amount = parseInt(fees_amount) + parseInt(gst_amount);
                                    if (fees_amount <= 0)
                                    {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> 0 </b> ';
                                    }
                                    else
                                    {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> ' + fees_amount + '</b> ';
                                    }

                                }
                                else if (credits_dtl[0]['student_user_type'] == 'E' && credits_dtl[0]['prof_details'] == 'P')
                                {
                                    if (credits_dtl[0]['total_credit_pay'] != '')
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['total_credit_pay'])));
                                    }
                                    else
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(with_waiver_credits)));
                                    }
                                    
                                    var gst_amount = parseInt(parseInt(fees_amount * 18) / 100);
                                    fees_amount = parseInt(fees_amount) + parseInt(gst_amount);
                                    if (fees_amount <= 0) {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> 0 </b> ';
                                    }
                                    else {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees with GST : </span> ' + fees_amount + '</b> ';
                                    }

                                }
                                else if (credits_dtl[0]['user_type'] == 'S')
                                {
                                    if (credits_dtl[0]['total_credit_pay'] != '')
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['total_credit_pay'])));
                                    }
                                    else
                                    {
                                        fees_amount = parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(with_waiver_credits)));
                                    }
                                    
                                    if (fees_amount < 0)
                                    {
                                        str += '</br><p><b><span style=Color:blue;>Total Fees : </span> 0 </b> ';
                                    }
                                    else
                                    {

                                        if (credits_dtl[0]['total_credit_pay'] != '')
                                        {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['total_credit_pay']))) + '</b> ';
                                        }
                                        else {
                                            str += '</br><p><b><span style=Color:blue;>Total Fees : </span> ' + parseInt(parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(credits_dtl[0]['Total_credits'])) - parseInt(parseInt(credits_dtl[0]['fees_amount']) * parseInt(with_waiver_credits))) + '</b> ';
                                        }


                                       
                                    }

                                }

                                $('#credits_dtl').html(str);
                                $('#credits_dtl').css('display', '');

                                if (json_parse[0]['status'] == 'A') {

                                    if (credits_dtl[0]['Payment_button_status'] == 'True' && credits_dtl[0]['payment_response_code'] == '0')
                                    {
                                        $('#paymentsection').css('display', 'none');
                                    }
                                    else if (credits_dtl[0]['Total_credits_remaning_payment'] == '0') {
                                        $('#submit_without_payment').css('display', 'block');
                                    }
                                    else
                                    {
                                     
                                        $('#paymentsection').css('display', 'block');
                                    }
                                    $('#submit_without_payment').css('display', 'none');
                                    if (credits_dtl[0]['payment_response_code'] == '0') {
                                        $('#section_download').css('display', '');
                                        $('#status_fees').text("Payment Submitted Successfully");
                                    }
                                    return false;
                                }

                                else if (credits_dtl[0]['payment_response_code'] == '0')
                                {
                                    $('#status_fees').text("Payment Submitted Successfully");
                                    if (credits_dtl[0]['Payment_button_status'] == 'True' && credits_dtl[0]['payment_response_code'] == '0')
                                    {
                                        $('#paymentsection').css('display', 'none');
                                    }
                                    else if (credits_dtl[0]['Total_credits_remaning_payment'] == '0') {
                                        $('#submit_without_payment').css('display', 'block');
                                    }
                                    else {
                                        
                                        $('#paymentsection').css('display', 'block');
                                    }
                                    $('#submit_without_payment').css('display', 'none');
                                    return false;
                                }
                                if (fees_amount > 0)
                                {
                                    $('#paymentsection').css('display', '');

                                }
                                else
                                {
                                    $('#paymentsection').css('display', 'none');
                                    $('#submit_without_payment').css('display', 'block');

                                }
                            }
                        }

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function generateHMAC(param1) {
            document.getElementById("orderAmount").value = param1["amount"];
            document.getElementById("merchantTxnId").value = param1["transaction_id"];
            document.getElementById("currency").value = param1["currency"];
            document.getElementById("returnUrl").value = param1["return_url"];

            if (window.XMLHttpRequest) {
                reqObj = new XMLHttpRequest();
            } else {
                reqObj = new ActiveXObject("Microsoft.XMLHTTP");
            }

            merchantURLPart = param1["merchant_id"];

            if (merchantURLPart.lastIndexOf("/") != -1) {
                vanityURLPart = merchantURLPart.substring(merchantURLPart.lastIndexOf("/") + 1)
            }

            var orderAmount = document.getElementById("orderAmount").value;
            var merchantTxnId = document.getElementById("merchantTxnId").value;
            var currency = document.getElementById("currency").value;

            var param = "merchantId=" + vanityURLPart + "&orderAmount=" + orderAmount + "&merchantTxnId=" + merchantTxnId + "&currency=" + currency;
            reqObj.onreadystatechange = process;

            reqObj.open("POST", param1["hmac_url"] + "?" + param, false);
            reqObj.send(null);
        }

        function process() {
            if (reqObj.readyState == 4) {
                document.getElementById("secSignature").value = reqObj.responseText;
                submitForm();
            }
        }

        function submitForm() {
            document.forms[0].action = merchantURLPart;
            document.forms[0].method = 'POST';
            document.forms[0].submit();
        }
        function submitFormKotak(param1) {
            location.href = 'KotakRequestHandler.aspx';
        }

        function display_student_Course_reg(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataListreg").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_reg" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable1 = $("#example_reg").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
             //  "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                   { "sTitle": "Course Heding", "mData": "new_credit", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Category", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "start_date", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Registration Time", "mData": "created_date", "bSortable": false },
                    {
                        "sTitle": "course Type", "mData": null, "bSortable": false, mRender: function (data) {
                            
                            if (data.course_type == 'M')
                            {
                                return 'Mandatory';
                            }
                            else if (data.course_type == 'E')
                            {
                                return 'Elective';
                            }
                            else
                            {
                                return '';
                            }
                        }
                    },

                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.course_type == 'M' && data.status == 'A')
                            {
                                return '<span style=color:darkblue;><b>Sws Mandatory Final Allocated Course</b></span>';
                            }
                            if (data.course_type == 'M' && data.status == 'R') {
                                return '<span style=color:darkblue;><b>Submitted</b></span>';
                            }
                            else if (data.course_type == 'E' && data.status == 'A') {
                                return '<span style=color:darkblue;><b>Final Allocated Course</b></span>';
                            }
                            else if (data.course_type == 'E' && data.course_drop_status == 'Y') {
                                return '<span style=color:darkblue;><b>Course Dropped </b></span>';
                            }
                            else if (data.course_type == 'E' && data.status == 'P') {
                                return '<span style=color:darkblue;><b>Provisionally Allocated Course</b></span>';
                            }
                            else if (data.course_type == 'E' && data.status == 'S') {
                                return '<span style=color:orenge;><b>Preference Saved</b></span>';
                            }
                            else if (data.course_type == 'E' && data.status == 'R') {
                                return '<span style=color:#5cb85c;><b>Preference Submitted</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    }
                    //{
                    //    "sTitle": "Payment Status", "mData": null, "bSortable": false, mRender: function (data) {

                    //        if ( data.status == 'A') {
                    //            return 'Paid';
                    //        }
                    //        else {
                    //            return '';
                    //        }
                    //    }
                    //}

                ]
            }).rowGrouping();

            $('#DataListreg').css('display', 'block');
            

        }


        function display_student_Course_man(data) {
            if (oTable3 != null) {
                oTable3.fnDestroy();
                $("#DataListreg").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_reg_man" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable3 = $("#example_reg_man").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //  "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    /* { "sTitle": "Course Heding", "mData": "new_credit", "bSortable": false },*/
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Category", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "start_date", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Registration Time", "mData": "created_date", "bSortable": false },
                    {
                        "sTitle": "course Type", "mData": null, "bSortable": false, mRender: function (data) {
                            
                            if (data.course_type == 'M') {
                                return 'Mandatory';
                            }
                            else if (data.course_type == 'E') {
                                return 'Elective';
                            }
                            else {
                                return '';
                            }
                        }
                    },

                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.course_type == 'M' && data.status == 'A') {
                                return '<span style=color:darkblue;><b>Sws Mandatory Final Allocated Course</b></span>';
                            }
                            else if (data.course_type == 'E' && data.status == 'A') {
                                return '<span style=color:darkblue;><b>Sws Elective Final Allocated Course</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    },
                    {
                        "sTitle": "Payment Status", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.status == 'A') {
                                return 'Paid';
                            }
                            else {
                                return '';
                            }
                        }
                    }

                ]
            });

            $('#manually_course_section').css('display', 'none');
            $('#DataListreg').css('display', 'block');


        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="well" style="background-color: White;">

        <div class="panel panel-default" style="display: block;">
            <%--<div class="panel-heading">
                <strong>Course Details Details</strong> <span id="waiver_credits" style="float:right; font-weight:bold; color:blue;"></span>
            </div>--%>
            <div>
               
                    <div id="DataListreg" style="display: none; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_reg">Payment Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>

                        <div id="manually_course_section" style="display:none;">
                        <div class="panel-heading">
                            <strong id="panel_head_reg_man">Manually Course Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg_man" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                            </div>

                        <div style="padding-left:10px; display:none;" id="credits_dtl">
                         
                    </div>
                        <div style="display:none; padding-left:48%; padding-bottom:10px;" id="paymentsection">
                            <button class="btn btn-primary" id="btnpaynow">Pay and Register</button>
                        </div>

                        <div style="display:none; padding-left:48%; padding-bottom:10px;" id="submit_without_payment">
                            <button class="btn btn-primary" id="btn_submit">Register</button>
                        </div>

                        <div style="padding-bottom:10px;">
                            <div style="float:right;padding-bottom:10px;padding-right:10px;display:none;" id="section_download"> 
                                <button class="btn btn-primary offline_download" style="display:block;" id="offline_download">Download Fees Receipt</button>

                            </div>
                            <span id="status_fees" style="color:red;padding-left:10px;font-size: 21px;font-weight: bold; padding-bottom:10px;"></span></div>
                        
                   <%-- </div>--%>
                    </div>
                
            </div>

        </div>
         <input type="hidden" id="secSignature" name="secSignature" value="" />
    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
    <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
    <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
    <input style="display: none" type="text" id="currency" class="text" name="currency" value="INR" />
    </div>
</asp:Content>

