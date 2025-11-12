<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="sws_credit_choice.aspx.cs" Inherits="Student_sws_credit_choice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
        $(document).ready(function ()
        {
            status = 'false';

           // check_payment_resopnse(); //23052024
            databind();
            $("#select_course").bind('keyup mouseup', function () {
                if ($('#credit_no').val() == '') {
                    bootbox.alert('Please Enter number of Credits');
                    return false;
                }
                var str = '';
                for (var i = 0; i < $("#select_course").val(); i++) {
                    str += '<p><b>Credit choice for Course ' + (i + 1) + '';
                    str += ' : </b>  <input type="number" style="width:60px;" id="credit_' + (i + 1) + '"';
                    str += ' name="Credit" min="2" max="10"></p> ';
                   // str += '<select id="select_drp_type_' + (i + 1) + '" style="width:120px;" class="marg-btm"><option value = "" > --Select Type--</option><option value=E>Elective</option><option value=M>Mandatory</option></select><p>';
                }
                $('#bind_data').html(str);
            });
            $('#btnsave').on('click', function ()
            {

                //$('#btnsave').prop('disabled', true);
               // $('#btnsave').css('pointer-events', none);
                if ($('#credit_no').val() == '' && parseInt($('#credit_no').val()) > 10) {
                    status = 'false';
                    bootbox.alert("Please Select Course Credit");
                    return false;
                }
                if ($('#select_course').val() == '') {
                    status = 'false';
                    bootbox.alert("Please SELECT NO. OF COURSES");
                    return false;
                }
                if ($('#select_course').val() > 5 || $('#select_course').val() == 0) {
                    status = 'false';
                    bootbox.alert("Please SELECT NO. OF COURSES (max.3 and min.1)");
                    return false;
                }

                if ($('#credit_no').val() > 10 || $('#credit_no').val() == 0 || $('#credit_no').val() == 1) {
                    status = 'false';
                    bootbox.alert("Please Enter number of Credits you wish to enroll for (max. 10, min. 2)");
                    return false;
                }
                var mand_status = '';
                var total_credit_count = 0;
                for (var check = 1; check <= $('#select_course').val(); check++) {
                    if ($('#credit_' + check).val() == '') {
                        total_credit_count = 0;
                        status = 'false';
                        bootbox.alert("Please SELECT Course Credit");
                        return false;
                    }
                    else {
                        total_credit_count = parseInt(total_credit_count) + parseInt($('#credit_' + check).val());
                    }

                }
                if (total_credit_count != $('#credit_no').val()) {
                    status = 'false';
                    bootbox.alert("Please Enter Correct CREDIT COMBINATION");
                    return false;
                }
                //if (mand_status == '')
                //{
                //    bootbox.alert("Please select one course Mandatory");
                //    return false;
                //}

                var datalist = [];
                var ws_combination_datalist = [];
                var ob = {};
                var ob_combination = {};

                var obj_req = { semester_code: $('#drp_semester').val(), dept_code: $('#drpdepartment').val(), prog_code: $('#drpprog').val(), prog_level_code: $('#drpproglevel').val(), semester: '', year_code: '' };


                ob["waiver_credits"] = $('#waiverno').val();
                ob["user_id"] = $(this).find(".cls_user_id").val();
                ob["total_credits"] = $('#credit_no').val();
                ob["no_of_course"] = $('#select_course').val();
                ob["credits_combination"] = $(this).children().eq(7).html();
                datalist.push(ob);
                for (var j = 1; j <= $('#select_course').val(); j++) {
                    ob_combination = {};
                    ob_combination["no_of_credits"] = $('#credit_' + j).val();
                    ob_combination["no_of_combination"] = $('#select_course').val();
                    ob_combination["credit_combination"] = j;
                    ob_combination["select_drp_type"] = 'E';
                    ws_combination_datalist.push(ob_combination);
                    //$('#select_drp_type_' + j).val();
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_sws_credit_data",
                    async: false,
                    data: "{credit_data_dtl : '" + JSON.stringify(datalist) + "',credit_combination_data : '" + JSON.stringify(ws_combination_datalist) + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "Time")
                        {
                            //$('#btnsave').prop('disabled', false);
                            
                            alert('The window for submitting preferences will be between 10 AM to 5PM on each day during the registration period');
                            return false;
                        }
                         
                        else if (data.d == "Course Credit Save Successfully")
                        {
                            alert("Course Credit Saved Successfully");
                            status = 'true';
                            //bootbox.alert(data.d, function () {
                            //   //window.location.reload();
                            //});
                        }
                        else
                        {
                            
                          
                            bootbox.alert("Problem In Data");
                        }
                      
                        return false;
                    },
                    error: function (result) {
                        
                        alert(result);
                    }
                });

            });

            $('.nextclick').on('click', function () {

                //var time_status = checktime();
                //if (!time_zone) {
                //    alert("The window for submitting preferences will be between 10 AM to 5PM on each day during the registration period");
                //    return false;
                //}
                $('#btnsave').click();
                if (status == 'true') {

                    status = 'false';
                    var origin = window.location.origin;
                    window.location.replace(origin + "/Student/" + "sws_course_selection.aspx");
                    return false;
                   
                    //var url = "sws_course_selection.aspx";
                    //window.open(url, '_self');
                }
                else {
                    status = 'false';
                    //bootbox.alert("Please save Course Credits");
                    return false;
                }


            });

            $('.paynowclick').on('click', function ()
            {
             var origin = window.location.origin;
             window.location.replace(origin + "/Student/" + "sws_payment_dtl.aspx");
             return false;
            });
        });

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
                url: "../../WebService.asmx/SWs_credit_data_get",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if ($('#hdnusertype').val() == 'S')
                    {
                        if (data.d[2] != "" && data.d[2] != null) {
                            alert("Your Registration Process has been blocked. Please contact SWS office.");
                            return false;
                        }
                        else if (data.d[3] == "" || data.d[3] == null)
                        {
                            if ($('#hdnuserid').val() == 'UG180527' || $('#hdnuserid').val() == 'UIR20181')
                            {

                            }
                            else
                            {
                                alert("Your Registration Process has been blocked. Please contact SWS office.");
                                return false;
                            }
                            
                        }
                        else if (data.d[4] != "" && data.d[4] != null)
                        {
                            var waiver_credits_dtl = JSON.parse(data.d[4]);
                            $('#waiver_credits').html('Fees Waiver Credits : ' + waiver_credits_dtl[0]['fees_waiver_credits']);
                            $('#waiverno').val(waiver_credits_dtl[0]['fees_waiver_credits']);
                        }
                    }

                    if (data.d[6] != "" && data.d[6] != null)
                    {
                        //display_student_Course_man(data.d[6]);
                    }


                    if (data.d[1] != "" && data.d[1] != null) {
                        display_student_Course_reg(data.d[1]);
                        if (data.d[5] != "" && data.d[5] != null)
                        {
                            var json_alloc = JSON.parse(data.d[5]);
                            if (json_alloc[0]['enable_allocation'] == 'Y')
                            {
                               // display_student_Provision_allocated_course(data.d[5]);
                            }
                            
                        }
                        
                        var credits_dtl = JSON.parse(data.d[0]);
                         if (credits_dtl != null) {

                            var str = '</br><p><b><span style=Color:blue;>Total CREDITS  : </span> ' + credits_dtl[0]['credit_choice'] + '</b> ';
                            str += '<b> &nbsp&nbsp&nbsp<span style=Color:blue;>SELECT NO. OF COURSES  : </span> ' + credits_dtl[0]['no_of_combination'] + '</b></p>';
                            for (var p = 0; p < credits_dtl.length; p++) {
                                str += '<p><b><span style=Color:blue;> Credit choice for Course ' + credits_dtl[p]['credit_combination'] + ' : </span>' + credits_dtl[p]['no_of_credits'] + '</b></p>';
                            }

                            $('#credits_dtl').html(str);
                            $('#reg_section').css('display', '');
                        }
                    }
                    //else
                    if (data.d[0] != "" && data.d[0] != null)
                    {
                        if (data.d[9] != "" && data.d[9] != null) {
                            $('#credit_div').css('display', 'none');
                        }
                        else
                        {
                            $('#credit_div').css('display', 'block');
                        }
                        
                        status = 'true';
                        var check_credits_dtl_paymnet = JSON.parse(data.d[7]);
                       if (check_credits_dtl_paymnet != null && check_credits_dtl_paymnet[0]['created_date'] == '' && parseInt(check_credits_dtl_paymnet[0]['remaning_credits']) <= 0 || parseInt(check_credits_dtl_paymnet[0]['remaning_credits']) == 0)
                      
                        {
                            
                            if (check_credits_dtl_paymnet[0]['created_date'] == '27-03-2025') {
                            
                            }
                            else
                            {
                                if ($('#hdnuserid').val() != 'PAT23120')
                                {
                                    after_payment_display_data(data.d[8]);
                                    //$('#btnnext').css('display', 'none');
                                    //$('#btnnext').remove();
                                    //$('#btnsave').css('display', 'none')
                                    //$('#btnsave').remove();
                                }
                            
                            }
                            //$('#btnnext').css('display', 'none');
                            //$('#btnsave').css('display', 'none');
                        }

                        if (check_credits_dtl_paymnet != null && check_credits_dtl_paymnet[0]['created_date'] == '')
                        {
                            after_payment_display_data(data.d[8]);
                        }

                        else if (check_credits_dtl_paymnet != null  && check_credits_dtl_paymnet[0]['status'] == 'P') {
                            after_payment_display_data(data.d[8]);
                            //display_data(data.d[0]);
                        }

                        else if (data.d[0] != "" && data.d[0] != null)
                        {
                            display_data(data.d[0]);
                        }
                        
                        return false;
                    }
                    else
                    {
                        $('#credit_div').css('display', 'block');
                        $('#reg_section').css('display', 'none');
                        status = 'false';
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function display_data(data) {
            var str = '';
            var data_row = JSON.parse(data);
            if (data_row != '') {
                for (var k = 0; k < data_row.length; k++)
                {
                    $('#credit_no').val(data_row[0]['credit_choice']);
                    $('#select_course').val(data_row[0]['no_of_combination']);

                    str += '<p><b>Credit choice for Course ' + (k + 1) + '';
                    str += ' : </b>  <input type="number" style="width:60px;" id="credit_' + (k + 1) + '"';
                    str += ' name="Credit" min="2" max="10" value=' + data_row[k]['no_of_credits'] + '> </p>';
                    //str += '<select id="select_drp_type_' + (k + 1) + '" style="width:120px;" class="marg-btm"><option value = "" > --Select Type--</option><option value=E>Elective</option><option value=M>Mandatory</option></select>';
                    str += '<p>';
                }
                
                $('#bind_data').html(str);
            }
        }

        function after_payment_display_data(data) {
            
            var str = '';
            var data_row = JSON.parse(data);
            if (data_row != '')
            {
                $('#credit_no').val(data_row[0]['credits']);
               // $('#credit_no').val(data_row[0]['remaning_credits']);

                //if (data_row[0]['credits'] == '0')
                //{
                //    $('#credit_no').attr('disabled', 'disabled');
                //    $('#btnnext').css('display', 'none');
                //    $('#btnnext').remove();
                //    $('#btnsave').css('display', 'none')
                //    $('#btnsave').remove();
                //}
                //else
                //{
                    if (data_row[0]['ProvisionallyAllocatedCredits'] == '0')
                    {
                        $('#credit_no').attr('disabled', 'disabled');
                        $('#btnnext').css('display', 'none');
                        $('#btnnext').remove();
                        $('#btnsave').css('display', 'none')
                        $('#btnsave').remove();
                    }
                    else if (data_row[0]['ProvisionallyAllocatedCredits'] > 0)
                    {
                        $('#credit_no').attr('disabled', 'disabled');
                        $('#btnnext').css('display', '');
                        $('#btnsave').css('display', '');
                    } 
                    
                //}

                //if (data_row[0]['status'] == 'P')
                //{
                //    if (data_row[0]['user_id'] != 'PAT23120')
                //    {
                //        $('#credit_no').attr('disabled', 'disabled');
                //    }
                //
                //}
                //else
                //{
                //    $('#credit_no').attr('disabled', 'disabled');
                //}

            }
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
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Registration Time", "mData": "created_date", "bSortable": false },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.course_drop_status == 'Y')
                            {
                                return '<span style=color:red;><b>DROPPED</b></span>';
                            }
                           else if (data.status == 'A') {
                                return '<span style=color:Green;><b>Allocated</b></span>';
                            }
                            else if (data.status == 'R')
                            {
                                return '<span style=color:darkblue;><b>Submitted</b></span>';
                            }
                            else if (data.status == 'P')
                            {
                                return '<span style=color:blue;><b>Provisionally Allocated</b></span>';
                            }
                            else
                            {
                                return '';
                            }
                        }
                    }

                ]
            }).rowGrouping();

            $('#DataListreg').css('display', 'block');
           // $('#btnpay').css('display', 'block');


        }

        function display_student_Provision_allocated_course(data) {
            $('#btnpay').css('display', 'none');
            if (oTable2 != null) {
                oTable2.fnDestroy();
                $("#DataListreg").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_pre" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable2 = $("#example_pre").dataTable({
                "bPaginate": false,
                "bSortable": false, 
                "bSort": false,
                "iDisplayLength": 60,
               // "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    { "sTitle": "Registration Time", "mData": "created_date", "bSortable": false },
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.status == 'P') {
                                return '<span style=color:blue;><b>Provisionally Allocated</b></span>';
                            }
                            else if (data.status == 'A')
                            {
                                return '<span style=color:green;><b>Allocated</b></span>';
                            }
                            else {
                                return '';
                            }
                        }
                    },
                    {
                        "sTitle": "Drop Course", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.drop_option != 'D')
                            {
                                if (data.status != 'A')
                                {
                                    return '<center><button type="button" class=' + data.doc_no + ' id=' + data.course_code + ' onclick="rowClick_drop(this)">Drop Course</button></center>';
                                } else {
                                    return '';
                                }
                                
                            }
                            else {
                                return '';
                            }
                        }
                    }

                ]
            }).rowGrouping();

            $('#DataListpre').css('display', 'block');
            $('#btnpay').css('display', 'block');


        }
        function rowClick_drop(drp) {
            var r = confirm("Are u sure you want to Drop this?");
            if (r == true)
            {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Drop_sws_course",
                    async: false,
                    data: "{course_code : '" + drp.id + "',doc_no : '" + drp.className + "'}",
                    dataType: "json",
                    success: function (data)
                    {
                        if (data.d == true)
                        {
                            bootbox.alert('Course Drop Successfully', function ()
                            {
                             window.location.reload();

                           });
                        }
                        else
                        {
                            bootbox.alert("Problem In Data");
                        }
                        return false;
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
          
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
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false },
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

            $('#manually_course_section').css('display', 'block');
            $('#DataListpre').css('display', 'block');
            $('#btnpay').css('display', 'block');


        }


        function checktime() {
            $.ajax({
                url: "http://worldtimeapi.org/api/timezone/Asia/Kolkata",
                method: "GET",
                async: false,
                success: function (response) {
                    // Extract the datetime from the API response
                    var currentDatetime = response.datetime;
                    var today = new Date(currentDatetime).getHours();
                    if (today >= 10 && today <= 17) {
                        time_zone = true;
                        return true;
                        
                    } else {
                        return false;
                    }
                },
                error: function () {
                    return false;

                }
            });
            
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

 
        

    <div class="well" style="background-color: White;">

        
        <div class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>General Process</strong>
            </div>
            <div style="padding-left: 10px;"><b style="color:blue"><br />SW Elective Course Registration Instructions :</b></br> </br> <p>Set Course Preferences (you have to give total 8-course preferences for each course-credit combination)</br></br>
                After Completing the course Preference process confirm your choices and click on the Submit button. The moment a student clicks on the SUBMIT button, their course preferences will be registered with the time stamp.</br></br>
Courses will be allocated Provisionally after the registration process is completed, based on the student’s selected course preferences and the registered timestamp.</br></br>
Students will be able to view the courses provisionally allocated to them in the SW Elective Registration page on the connect portal.</br></br>
Students must pay the fees within the specified timeline to confirm the course allocation. The auto calculation of fees and the waiver credit (if any) will be done on the payment page. If the fee remains unpaid after the deadline, the provisional allocation will be cancelled and the course offered to the next student in line.</br></br>
Once the student successfully completes the Payment, the final allocation of the course will be done, and the student will be able to view the allocated course on the connect portal.</br></br>
Step by step instructions for course selection are given in the following pages.</p> 

            </div>
            

            </div>

        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Elective Credit Selection Details</strong> <span id="waiver_credits" style="float:right; font-weight:bold; color:blue;"></span>
            </div>
            <div>
                 <div id="reg_section" style="display: none">
                    <div class="panel panel-default">
                        <div style="padding-left:10px;" id="credits_dtl">
                        
                    </div>
                    </div>
                    
                     <div id="DataListpre" style="display: none; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_pre">SW Elective Provision Allocated Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_pre" class="display table table-striped table-bordered table-hover" width="100%">
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

                         <div style="padding-top:15px;padding-bottom:10px; padding-left:43%;">
                            <%-- <button class="btn btn-primary paynowclick" style="display:none;" id="btnpay">Payment Process</button>--%>
                         </div>
                          
                    </div>


                    <div id="DataListreg" style="display: none; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_reg">SW Elective Registration Preference Details</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="credit_div" style="display: none">
                   

                    <div style="padding-left: 10px;">
                        <p><b>
                            <h2>STEP 1 - ENTER ELECTIVE CREDITS</h2>
                        </b></p>
                        <p>
                            <b>Enter number of Credits you wish to enroll for (max. 10, min. 2) : </b>
                            <input type="number" style="width: 60px;" id="credit_no" name="Credit" min="2" max="10">
                            <label>Your fee would be calculated based on credits you enter.</label>

                        </p>
                        <br />
                        <br />

                        <p><b>
                            <h2>STEP 2 - SELECT NO. OF COURSES</h2>
                        </b></p>
                        <p>
                            <b>Select number of Courses you wish to enroll (max. 5, min. 1) : </b>
                            <input type="number" style="width: 60px;" id="select_course" name="course_no" min="1" max="5">
                        </p>

                        <br />
                        <br />
                        <p>
                            <b>
                                <h2>STEP 3 - ENTER CREDIT COMBINATION </h2>
                            </b>
                            <label id="bind_data"></label>

                        </p>
                        <br />
                        <p>
                            <button class="btn btn-primary" id="btnsave">Save</button>
                            <button class="btn btn-primary nextclick" id="btnnext">Next</button>
                        </p>
                    </div>
                </div>




               
            </div>
        </div>

    </div>
    <input type="text" id="waiverno" style="display:none;" />
</asp:Content>

