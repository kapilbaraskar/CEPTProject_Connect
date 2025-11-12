<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="sws_mandatory_course_dtl.aspx.cs" Inherits="Student_sws_mandatory_course_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            
            //bindyeardata();

            //$('#btn_submit').on('click', function () {
            //    save_data_mad();
            //    return false;
            //});


            $('#btnpaynow').on('click', function () {
                pay_sws_fees();
            });
            $('#btn_submit_1').on('click', function () {
                winthout_pay_sws_fees();
            });

            $('#btn_submit').on('click', function () {

                var datalist = [];
                $("#example tbody tr").each(function (i) {
                    
                    if ($(this).find(".chk_course").is(':checked'))
                    {
                        
                    //if ($(this).find("select[name='drp_count']").val() != '' && $(this).find("select[name='drp_count']").val() != undefined && $(this).find("select[name='drp_count']").val() != 'undefined') {
                        var aPos = oTable.fnGetPosition(this);
                        var a = oTable.fnGetData(aPos);
                        var ob = {};
                        ob["course_code"] = a["course_code"];
                        ob["priority"] = "";
                        ob["course_credits"] = a["course_credits"];
                        ob["course_type"] = 'M';
                        ob["status"] = 'R';
                        ob["credit_combination"] = "";
                        datalist.push(ob);
                    }
                });
                if (datalist.length == 0) {
                    alert("Please Select At Least One Course");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_sws_course_reg_data",
                    async: false,
                    data: "{ws_course_data : '" + JSON.stringify(datalist) + "',status : 'R'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "Course Save Successfully")
                        {
                            alert("SW Course Submitted Successfully ");
                            return false;
                        }
                        else if (data.d == "AlreadyMandatory") {
                            bootbox.alert("Already Applying for Mandatory Course");
                            return false;
                        }
                        else
                        {
                            bootbox.alert(data.d);
                        }
                        return false;
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });


            course_wise_student_dtl();

            $('.paynowclick').on('click', function () {
                var origin = window.location.origin;
                window.location.replace(origin + "/Student/" + "sws_payment_dtl.aspx");
                return false;
            });
            


           
            return false;
        });


        function pay_sws_fees() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/sws_connect_fees_payment",
                // data: "{student_selection:'" + stud_selection + "',cur_room:'" + cur_room + "'}",
                data: "",
                dataType: "json",
                success: function (data) {

                    if (data.d != "" && data.d != "[]") {
                        if (data.d == 'Online SWS Course fees payment option is currently closed. Please contact SWS office.') {
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
                url: "../WebService.asmx/SWS_Mandatory_Course_withoutpay",
                // data: "{student_selection:'" + stud_selection + "',cur_room:'" + cur_room + "'}",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {

                    if (data.d != "" && data.d != "[]") {
                        if (data.d == 'Course Save Successfully') {
                            alert('Course Registered Successfully');
                            return false;
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

        function course_wise_student_dtl() {
            $('#DataList').css('display', 'none');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_mandatory_course_dtl",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        Display_report(data.d);
                        var data_save = JSON.parse(data.d);
                       
                        var paymentstatus = 1;
                        var paymentGet = false;
                        for (var i = 0; i < data_save.length; i++)
                        {
                            if (data_save[i]["payment_response_code"] == '0')
                            {
                                paymentstatus = 0;
                                $('#btnpaynow').css('display', 'none');
                                $('#btn_submit_1').css('display', 'none');
                                $('#btn_submit').css('display', 'none');
                                $('#status_fees').text("Payment Submitted Successfully");
                                break;
                            }
                            else if (data_save[i]["status"] == 'R' || data_save[i]["status"] == 'A')
                            {
                                if (data_save[0]["Paymentcredit"] == '0.00') {
                                    $('#btn_submit_1').css('display', 'block');
                                    $('#btnpaynow').css('display', 'none');
                                }
                                else {
                                    paymentGet = true;
                                    $('#btnpaynow').css('display', 'block');
                                    $('#btn_submit_1').css('display', 'none');
                                }
                                
                                $('#paynowclick').css('display', 'none');
                                $('#btn_submit').css('display', 'none');
                                $('.chk_course').css('display', 'none');
                               break;
                            }
                        }
                        if (data_save[0]["status"] == 'R' || data_save[0]["status"] == 'A')
                        {
                            $('#btn_submit').css('display', 'none');
                            GetpaymentDetails(paymentstatus, paymentGet);
                        }

                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }
        function Display_report(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                    {
                        "sTitle": "Select", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.status == 'R') {
                                return 'Submitted';
                            }
                            else if (data.status == 'A')
                            {
                                return 'Allocated';
                            }
                            return '<center><input type="checkbox"  name="check_all_student" value="1" class="chk_course" onchange="user_select_change(this)" id="' + data.course_code + '" /></center>';
                        }

                    },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Credit", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Course Category", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "start_date", "bSortable": false },
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false }
                ]
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
        function save_data_mad()
        {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_mandatory_course_dtl",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        //Display_report(data.d);
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }
        function user_select_change(cur)
        {
            //if ($("#" + cur.id).is(':checked')) {
            //    $("#" + cur.id).attr("disabled", false);
            //    $(".chk_course").attr("checked", false);
            //    $("#" + cur.id).attr("checked", true);
            //
            //    $(".chk_course").attr("disabled", true);
            //    $("#" + cur.id).attr("disabled", false);
            //}
            //else
            //{
            //    $(".chk_course").attr("disabled", false);
            //}


            //OLD Code

            //$("#" + cur.id).attr('checked', 'checked');
            

            // else {
            //     $("input[name='check_all_student']").removeAttr('checked');
            // }
        }


        function GetpaymentDetails(paymentstatus, paymentGet) {
            //$('#DataList').css('display', 'none');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetFeesCalculationAndVerificationCreditWise",
                data: "{sem_code : '',year_code : '',userid : '" + $('#hdnuserid').val()+"'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "")
                    {
                        var data_save = JSON.parse(data.d);
                        $('#TotalElactiveCredit').html(data_save[0].AllocatedCredits);
                        $('#TotalWavierCredit').html(data_save[0].fees_waiver_credits);
                        $('#TotalRemaningWavierCredit').html(data_save[0].RemaningWavierCredit);
                        $('#TotalPerCredit').html(data_save[0].ParCreditFees);
                        $('#TotalPMANCredit').html(data_save[0].ApplyManditoryCourseCredit);
                        $('#PaidFess').html(data_save[0].GetRemainingPaymentWithFees);
                        if (paymentstatus == '1') {
                            if (data_save[0].GetRemainingPaymentWithFees != 0) {
                                $('#btnpaynow').css('display', 'block');
                                $('#btn_submit_1').css('display', 'none');
                            }
                            else if (data_save[0].GetRemainingPaymentWithFees == 0)
                            {
                                $('#btn_submit_1').css('display', 'block');
                                $('#btnpaynow').css('display', 'none');
                            }
                            else
                            {
                                $('#btn_submit_1').css('display', 'none');
                                $('#btnpaynow').css('display', 'none');
                            }
                        }
                        else if (paymentstatus == '0')
                        {
                            $('#btn_submit_1').css('display', 'none');
                            $('#btn_submit').css('display', 'none');
                            $('#btnpaynow').css('display', 'none');
                            $('#status_fees').text("Payment Submitted Successfully");
                        }
                    }
                    else
                    {
                        GetNotApplyElectiveCourse(paymentstatus,paymentGet);
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function GetNotApplyElectiveCourse(paymentstatus,paymentGet) {
            //$('#DataList').css('display', 'none');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_No_Apply_For_Elective_Course_user",
                data: "",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var data_save = JSON.parse(data.d);
                        $('#TotalElactiveCredit').html('0');
                        $('#TotalWavierCredit').html(data_save[0].FeesWaiverCredit);
                        $('#TotalRemaningWavierCredit').html('0');
                        $('#TotalPerCredit').html(data_save[0].PerCreditPrice);
                        $('#TotalPMANCredit').html(data_save[0].ApplyTotalCredit);
                        $('#PaidFess').html(data_save[0].TotalAmount);
                        if (paymentstatus == '0')
                        {
                            $('#btnpaynow').css('display', 'none');
                            $('#btn_submit_1').css('display', 'none');
                        }
                        else if (paymentGet == true) {
                            $('#btnpaynow').css('display', 'block');
                            $('#btn_submit_1').css('display', 'none');
                        }
                        else {
                            $('#btnpaynow').css('display', 'none');
                            $('#btn_submit_1').css('display', 'block');
                        }
                    }
                    else
                    {
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
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

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Mandatory Course Registration</strong>
            </div>
            <%--<div style="padding-left: 10px;">
                <div style="height:100px;">
                    <h2><b style="color: darkred;">Mandatory Course Registration Will be Started Shortly.</b> </h2>
                </div>
            </div>--%> 
            <div id="DataList" class="panel panel-default" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>

            </div>
            <div id="paymentblock" style="padding-left:10px;">
                <p><b><span style=Color:blue;>Total Elective Credit : <span id="TotalElactiveCredit"></span></span></b> &nbsp&nbsp&nbsp&nbsp <b><span style=Color:blue;>Total Mandatory Credit : <span id="TotalPMANCredit"></span></span></b>
                 &nbsp&nbsp&nbsp&nbsp <b><span style=Color:blue;>Total Wavier Credit : <span id="TotalWavierCredit"></span></span></b></p>
                <p><b><span style=Color:blue;>Per Credit Amount : <span id="TotalPerCredit"></span></span></b></p>
                <p><b><span style=Color:blue;>Required To Pay : <span id="PaidFess"></span></span></b></p>
                <span id="status_fees" style="color:red;padding-left:10px;font-size: 21px;font-weight: bold; padding-bottom:10px;"></span>
            </div>

            <div style="padding-top:15px;padding-bottom:10px; padding-left:43%;">
                <button class="btn btn-primary" style="display:block;" type="submit" id="btn_submit"><i class="icon-save bigger-160"></i> Submit </button>
                <%--<button class="btn btn-primary paynowclick" style="display:none;" id="btnpay">Payment Process</button>--%>
                <button class="btn btn-primary" style="display:none;" id="btnpaynow">Pay and Register</button>
                <button class="btn btn-primary" style="display:none;" id="btn_submit_1">Register</button>
                          
               

            </div>
        </div>
    </div>
</asp:Content>

