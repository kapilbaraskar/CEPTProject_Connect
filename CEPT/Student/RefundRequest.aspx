<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="RefundRequest.aspx.cs" Inherits="Student_RefundRequest" %>

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
        var time_zone = false;
        $(document).ready(function () {
            databind();
            $('.nextclick').on('click', function ()
            {    
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ws_apply_refund_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "true") {
                            bootbox.alert("Refund applied successfully.")
                            return false;
                        }
                        
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });
            $('#btnsave').on('click', function () {
                save_data('Y');
                return false;
            });
        });

        function databind() {
            var isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);
            if (isMobile) {
                browserType = "Mobile";
            } else {
                browserType = "Web";
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/SWs_after_allocated_dtl",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if ($('#hdnusertype').val() == 'S' || $('#hdnusertype').val() == 'E') {
                        if (data.d[3] != "" && data.d[3] != null) 
                        {
                            display_student_Course_reg(data.d[3]);
                        }
                        else
                        {
                            $('#DataListreg').css('display', 'none');
                        }
                        if (data.d[4] != "" && data.d[4] != null)
                        {
                            var jsondata = JSON.parse(data.d[4])
                            
                            display_student_Course_man(data.d[4]);
                            $('#eligible').css('display', 'none');
                            $('#AccountNumber').val(jsondata[0]['AccountNumber']);
                            $('#AccountHolderName').val(jsondata[0]['AccountHolderName']);
                            $('#IFSCCODE').val(jsondata[0]['IFSCCode']);
                            $('#bankName').val(jsondata[0]['BankName']);
                            $('#branch_name').val(jsondata[0]['BranchName']);
                            $('#branch_city').val(jsondata[0]['BranchCity']);
                            $('#branch_state').val(jsondata[0]['BranchState']);
                            //$("#address").val(jsondata[0]['BankAddress']);
                            if (jsondata[0]['BANK_STATUS'] == 'False') {
                                $('.button_div').css('display', 'none');
                            }
                            else { $('#btnsave').css('display', 'none');}

                            if (jsondata[0]['STUDENTSTATUS'] == 'Y')
                            {
                                $('.button_div').css('display', 'none');
                                $('#changetext').text('You have already applied for a refund request. Please Check Status');
                                $('#eligible').css('display', '');
                            }
                        }
                        else
                        {
                            $('#manually_course_section').css('display', 'none');
                            $('#btnsave').css('display', 'none');
                            $('#eligible').css('display', 'block');
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
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
                    
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Category", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "start_date", "bSortable": false },
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Registration Time", "mData": "created_date", "bSortable": false },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.course_drop_status == 'Y') {
                                return '<span style=color:red;><b>DROPPED</b></span>';
                            }
                            else if (data.status == 'A') {
                                return '<span style=color:Green;><b>Allocated</b></span>';
                            }
                            else if (data.status == 'R' && data.cancel_flag == 'Y') {
                                return '<span style=color:darkblue;><b>Expired</b></span>';
                            }
                            else if (data.status == 'E' && data.cancel_flag == 'Y') {
                                return '<span style=color:darkblue;><b>Expired</b></span>';
                            }
                            else if (data.status == 'R') {
                                return '<span style=color:darkblue;><b>Submitted</b></span>';
                            }
                            else if (data.status == 'P') {
                                return '<span style=color:blue;><b>Provisionally Allocated</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    }

                ]
            });

            $('#DataListreg').css('display', 'block');
            // $('#btnpay').css('display', 'block');


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
                    { "sTitle": "Total Allocated Credit", "mData": "AllocatedCredit", "bSortable": false },
                    //{ "sTitle": "Fees Waiver Credits", "mData": "fees_waiver_credits", "bSortable": false },
                    {
                        "sTitle": "Fees Waiver Credits","mData": "fees_waiver_credits","bSortable": false,
                        "mRender": function (data, type, row)
                        {
                            return data === '' ? '0' : data;
                        }
                    },
                    { "sTitle": "Per Credit Fees", "mData": "PerCreditFees", "bSortable": false },
                    { "sTitle": "Paid Fees Amount", "mData": "TotalAmount", "bSortable": false },
                    { "sTitle": "Refund Amount", "mData": "ReFundPayment", "bSortable": false },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.ADMINSTATUS == 'Y' && data.ACCOUNTSTATUS == 'Y') {
                                return '<span style=color:red;><b>Approved</b></span>';
                            }
                            else if (data.STUDENTSTATUS == 'Y')
                            {
                                return '<span style=color:red;><b>Submitted By Student</b></span>';
                            }
                            else {
                                return '<span style=color:red;><b>Pending By Student</b></span>';
                            }
                        }
                    },
                    {
                        "sTitle": "SW Office Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.ADMINSTATUS == 'Y') {
                                return '<span style=color:red;><b>verified</b></span>';
                            }

                            else {
                                return '<span style=color:red;><b>Pending</b></span>';
                            }
                        }
                    },
                    {
                        "sTitle": "Account Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.ACCOUNTSTATUS == 'Y') {
                                return '<span style=color:red;><b>verified</b></span>';
                            }
                            
                            else {
                                return '<span style=color:red;><b>Pending</b></span>';
                            }
                        }
                    },
                    


                ]
            });

            $('#manually_course_section').css('display', 'block');
            $('#eligible').css('display', 'none');
            


        }
      
        function save_data(type_submit)
        {
           
                if ($('#AccountNumber').val() == "")
                {
                    alert("Please Enter Account Number");
                    return false;
                }
                if ($('#AccountHolderName').val() == "") {
                    alert("Please Enter Account Holder Name");
                    return false;
                }
                if ($('#IFSCCODE').val() == "") {
                    alert("Please Enter IFSC CODE");
                    return false;
                }
                if ($('#bankName').val() == "") {
                    alert("Please Enter Bank Name");
                    return false;
                }
                //if ($('#address').val() == "") {
                //    alert("Please Enter Bank Adress");
                //    return false;
                //}

            if ($('#branch_name').val() == "") {
                alert("Please Enter Bank Branch Name");
                return false;
            }

            if ($('#branch_city').val() == "") {
                alert("Please Enter Bank Branch City");
                return false;
            }

            if ($('#branch_state').val() == "") {
                alert("Please Enter Bank Branch State");
                return false;
            }

         
            var entityMap = { "'": '&#39;', '"': '&#34;', "@": '&#64;', "&": '&#38;', "<": '&#60;', ">": '&#62;', "/": '&#47;' };
            var student_details_save = "";
            student_details_save = {
                "AccountNumber": $('#AccountNumber').val(),
                "AccountHolderName": $('#AccountHolderName').val(),
                "IFSCCODE": $('#IFSCCODE').val(),
                "bankName": $('#bankName').val(),
                "branch_name": $('#branch_name').val(),
                "branch_city": $('#branch_city').val(),
                "branch_state": $('#branch_state').val(),
               // "address": $("#address").val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; })
                
            };

            var student_details_save_data = [];
            student_details_save_data.push(student_details_save);
            var json_submit_data = JSON.stringify(student_details_save_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_student_Bank_dtl",
                data: "{details_stu:'" + json_submit_data + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == 'true') {
                            $('.button_div').css('display', '');
                            alert("Bank Details Saved Successfully");
                        }
                        return false;
                    }
                    else {
                        $('.button_div').css('display', 'none');
                        return false;
                    }
                },
                error: function (result) {
                    $('.button_div').css('display', 'none');
                    alert(result);
                }
            });
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="well" style="background-color: White;">

        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Credits Selected Details</strong> <span id="waiver_credits" style="float: right; font-weight: bold; color: blue;"></span>
            </div>
            <div>
                <div id="reg_section" style="display: block">
                    <div class="panel panel-default">
                        <div style="padding-left: 10px;" id="credits_dtl">
                        </div>
                    </div>
                    <div id="DataListreg" style="display: block; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_reg">SW Course Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>


                    <div id="manually_course_section" style="display:none; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_reg_man">Refund Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg_man" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                          <div class="button_div" style="padding-left:40%; padding-bottom:10px; display:block;">
                    <button style="align-items:center;" class="btn btn-primary nextclick" id="btnnext">Apply For Refund</button>
                </div>
                            </div>
                    <div id="main_div" style="margin-top: 15px; margin-bottom: 40px;" class="panel panel-default">

            <div class="panel-heading">
                <strong>Account Detail</strong>
            </div>
            <div style="padding-top: 15px;">
                <table border="0" cellpadding="2" cellspacing="2" style="width: 100%;" align="center">

               
                    
                    <tr>
                          <td style="padding-left: 15px;">
                            <b>Account Number</b>
                        </td>
                        <td>
                            
                            <input type="text" id="AccountNumber" /> 
                        </td>
                        
                          <td >
                            <b>Account Holder Name</b>
                        </td>
                        <td>
                            
                            <input type="text" id="AccountHolderName"/> 
                        </td>
                        
                       

                        
                    </tr>
                    <tr>
                        <td style="padding-left: 15px;">
                            <b> IFSC Code </b>
                        </td>
                        <td>
                            
                            <input type="text" id="IFSCCODE" /> 
                        </td>
                        <td>
                            <b>Bank Name</b>
                        </td>
                        <td>
                            
                            <input type="text" id="bankName" /> 
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 15px;">
                            <b> Branch Name </b>
                        </td>
                        <td>
                            
                            <input type="text" id="branch_name" /> 
                        </td>
                        <td>
                            <b>Branch City</b>
                        </td>
                        <td>
                            
                            <input type="text" id="branch_city" /> 
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-left: 15px;">
                            <b> Branch State </b>
                        </td>
                        <td>
                            
                            <input type="text" id="branch_state" /> 
                        </td>
                       
                    </tr>



                  
                  
                    <tr>
                        
                        
                        <td style="padding-left: 15px;">
                            <button class="btn btn-primary" id="btnsave">Save</button>
                        </td>

                    </tr>
                    <br /><br />
                    <tr><td colspan="6"><span style="Color:blue;font-size: 21px;padding-left:10px;">Please save the bank details and then apply for a refund...........</span></td></tr>
                </table>

                

            </div>
            <br />

        </div>

                    <div id="eligible" style="display:none; padding:10px;">
                        <p><b><span style="Color:blue;font-size: 21px;" id="changetext">You Are Not Eligible For A Refund Request...</span></b></p>
                    </div>
                </div>


            </div>
        </div>

    </div>
</asp:Content>

