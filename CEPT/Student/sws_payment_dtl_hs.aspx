<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="sws_payment_dtl_hs.aspx.cs" Inherits="Student_sws_payment_dtl_hs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var status = false;
        var oTable1;
        var oTable2;
        var oTable3;
        var mandatory_popup_status = false;
        var totalamount = '';
        $(document).ready(function ()
        {
            //check_payment_resopnse(); //23052024
            databind();
            $('#btnpaynow').on('click', function () {
                pay_sws_fees();
            });

            //$('#btn_submit').on('click', function ()
            //{

            //    winthout_pay_sws_fees();

            //});

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
                url: "../WebService.asmx/sws_connect_fees_payment_hs",
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
                url: "../../WebService.asmx/Get_sws_Payment_page_dtl_hs",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    var str = ''; 
                    
                    if (data.d[0] != "" && data.d[0] != null)
                    {
                        display_student_Course_reg(data.d[0]);
                    }
                    if (data.d[1] != "" && data.d[1] != null)
                    {
                        var total_amount = 0;
                        var gststatus = false;
                        var gstamount = 0;
                        var fees_data = JSON.parse(data.d[1]);

                        if (data.d[0] != "" && data.d[0] != null)
                        {
                            var TotalCourseData = JSON.parse(data.d[0]);
                            for (var i = 0; i < TotalCourseData.length; i++)
                            {
                                var result = alasql('SELECT * FROM ? WHERE course_code = ?', [fees_data, TotalCourseData[i]['course_code']]);

                                if (result[0]['gst'] == 'Y')
                                {
                                    gstamount = result[0]['gstamount']
                                    total_amount += parseFloat(result[0]['withgstamount']);
                                }
                                else
                                {
                                    total_amount += parseFloat(result[0]['amount']);
                                }
                                
                                totalamount = total_amount;
                            }
                            str = '';
                             // str = '</br><p><b><span style=Color:blue;>Total CREDITS : </span> ' + newcredits_dtl[0]['RegisteredCredits'] + '';
                        //str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Waiver CREDITS : </span> ' + newcredits_dtl[0]['WaiverCredit'] + '</b> ';
                            str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Paid Fees : </span> ' + total_amount + '</b> ';
                        //str += ' &nbsp;&nbsp; <b><span style=Color:blue;>Total Allocate CREDITS : </span> ' + newcredits_dtl[0]['ProvisionallyAllocatedCredits'] + '</b></p> ';

                            
                        }
                       
                        if (totalamount != '') {
                            var amountInWords = convertNumberToWords(totalamount);
                            $('#credits_dtl').html(str + ' (<b>' + amountInWords + ' </b>)');
                            $('#credits_dtl').css('display', '');
                            $('#paymentsection').css('display', '');
                        }
                       
                    }
                    if (data.d[2] != "" && data.d[2] != null)
                    {
                        $('#paymentsection').css('display', 'none');
                        $('#status_fees').text("Payment Submitted Successfully");

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

        function convertNumberToWords(amount) {
            var words = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
                "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
                "Seventeen", "Eighteen", "Nineteen", "Twenty", "Thirty", "Forty", "Fifty",
                "Sixty", "Seventy", "Eighty", "Ninety"];

            function numToWords(num) {
                if (num <= 20) return words[num];
                if (num < 100) return words[18 + Math.floor(num / 10)] + (num % 10 ? " " + words[num % 10] : "");
                if (num < 1000) return words[Math.floor(num / 100)] + " Hundred" + (num % 100 ? " " + numToWords(num % 100) : "");
                if (num < 100000) return numToWords(Math.floor(num / 1000)) + " Thousand" + (num % 1000 ? " " + numToWords(num % 1000) : "");
                if (num < 10000000) return numToWords(Math.floor(num / 100000)) + " Lakh" + (num % 100000 ? " " + numToWords(num % 100000) : "");
                return numToWords(Math.floor(num / 10000000)) + " Crore" + (num % 10000000 ? " " + numToWords(num % 10000000) : "");
            }

            var parts = amount.toString().split(".");
            var integerPart = parseInt(parts[0]);
            var decimalPart = parts.length > 1 ? parseInt(parts[1]) : 0;

            var result = numToWords(integerPart) + " Rupees";
            if (decimalPart > 0) {
                result += " and " + numToWords(decimalPart) + " Paise";
            }
            return result + " Only";
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


     <div class="well" style="background-color: White;">

        <div class="panel panel-default" style="display: block;">
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

                        <div style="padding-left:10px; padding-top:25px; display:none;" id="credits_dtl">
                         
                    </div>
                        <div style="display:none; padding-left:48%; padding-bottom:10px;" id="paymentsection">
                            <button class="btn btn-primary" id="btnpaynow">Pay and Register</button>
                        </div>

                       <%-- <div style="display:none; padding-left:48%; padding-bottom:10px;" id="submit_without_payment">
                            <button class="btn btn-primary" id="btn_submit">Register</button>
                        </div>--%>

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

