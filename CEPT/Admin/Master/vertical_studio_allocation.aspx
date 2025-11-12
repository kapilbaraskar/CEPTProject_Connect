<%@ Page Title="Studio Unit Allocation" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="vertical_studio_allocation.aspx.cs" Inherits="Admin_Master_vertical_studio_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style type="text/css">
        #div_student_list table thead th:first-child
        {
            width:10%;
        }
        #div_student_list table thead th:nth-child(2)
        {
            width:23%;
        }
        #div_student_list table thead th:nth-child(3)
        {
            width:11%;
        }
        #div_student_list table thead th:nth-child(4),#div_student_list table thead th:nth-child(5)
        {
            width:12%;
        }
        #div_student_list table thead th:last-child
        {
            width:32%;
        }
        #div_student_list table tbody td:nth-child(3)
        {
            text-align:center;
        }
        .cls_ele_width
        {
            width:96%;
        }
        .cls_seats
        {
            display:none;
        }

        .panel_pdf {
        /*padding-bottom:8px;*/
        padding: 10px;
        
        }

        /*table#rr tbody th tr td {
            border-collapse: collapse !important;
            width: 50% !important;
            border: 1px solid black !important;
        }*/
 
      
    </style>

    <script type="text/javascript">
        var semester = '';
        var year = '';
        var course_code = '';
        var arr_course_data = [];

        var all_data = [];
        var selected_course = '';
        var course_dtl = "";
        var studiomode = "";
        var course_count_data = '';

        $(document).ready(function () {
            bind_instructor_course();

            $('#btn_retrieve').on('click', function () {
                get_Total_seat_Count();
                get_student_data_for_course();
               // Get_Check_box_eable_disable();
                get_available_seat_data();
               

            });

            $('#btn_pdf').on('click', function () {
                 
                all_dataa = JSON.parse(all_data["d"]);
                var obj_prio = all_dataa.map(function (d) { return d.priority });
                var max_prio = obj_prio.reduce(function (a, b) { return Math.max(a, b) });
                var dis_course_code = '';
                var str_html = '';
                for (var i = 1; i <= max_prio; i++) {
                    
                    dis_course_code = '<h3>Course Code:' + selected_course + '</h3>';
                    str_html += '<div class="panel_pdf" style="padding:5px;"><div class="panel-heading"><strong>Students with Priority ' + i + '</strong></div><div>';
                    //str_html += '<table class="table table-bordered" id="rr" style="margin-bottom:0px !important;border:1px solid #ddd;"><thead><tr><th>Student Code</th><th style="padding-left: 120px;">Student Name</th><th style="padding-left: 60px;"> Gender </th></tr></thead><tbody>';
                    str_html += '<table class="table" id="rr" style="width:100%;border-collapse: collapse;border:1px solid #ddd;"><thead><tr style="border:1px solid #ddd;"><th style="border:1px solid #ddd;text-align: center;">Student Code</th><th style="border:1px solid #ddd;text-align: center;">Student Name</th><th style="border:1px solid #ddd;text-align: center;"> Gender </th></tr></thead><tbody>';

                    var obj_student_prio_data = $.grep(all_dataa, function (d) { return d.priority == i.toString() });

                    if (obj_student_prio_data.length > 0) {
                        for (var j = 0; j < obj_student_prio_data.length; j++) {

                            var link = "https://portfolio.cept.ac.in/units/" + $('#drp_course').val();
                            str_html += '<tr style="border:1px solid #ddd;"><td class="cls_user_id" style="border:1px solid #ddd;padding-left: 5px;">' + obj_student_prio_data[j]['user_id'] + '</td>';
                            str_html += '<td style="padding-left: 20px;border:1px solid #ddd;">' + obj_student_prio_data[j]['user_name'] + '</td>';
                            str_html += '<td style="padding-left: 50px;border:1px solid #ddd;">' + obj_student_prio_data[j]['gender']  + '</td>';
                            
                        }
                    }
                    else
                    {
                        str_html += '<tr style="border:1px solid #ddd;"><td class="cls_user_id" style="border:1px solid #ddd;"> No Students Data </td>';
                        
                    }

                    

                    str_html += '</tbody></table></div></div>';

                    //$('#div_student_list').append(str_html);
                }
               //var divContents = $("#dvContainer").html();
                var printWindow = window.open('', '', 'height=800,width=1200');
                printWindow.document.write(dis_course_code);
               //printWindow.document.write(str_tbl_head);
               //printWindow.document.write('</head><body >');
                printWindow.document.write(str_html);
               //printWindow.document.write(divContents);
                printWindow.document.close();
                printWindow.print();
            });

            $("#drp_course").on('change', function ()
            {
                studiomode = $(this).find('option:selected').attr('id');
                //alert($(this).find('option:selected').attr('id'));
            });

            $('#btn_short_list_onetime').on('click', function () {
              
                var flag_status = 'N';
                var datalist = [];
                $("#example tbody tr").each(function (i) {
                    var obj = {};
                    if ($(this).find(".chk_course").is(':checked')) {
                        
                        flag_status = 'Y';
                        var data_inst = $(this).children().eq(0)[0].children[0].id.split('_')
                        obj["user_id"] = data_inst[0];  
                        datalist.push(obj);
                    }
                });
                var course_code = $('#drp_course').val();
                if (flag_status == 'Y') {
                    var data = JSON.stringify({ manually_data: JSON.stringify(datalist), course_code: $('#drp_course').val() });
                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/Bulk_shortlist_vertical_studio",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Problem in data") {
                                    bootbox.alert("Problem in ShortList, Please try again.");
                                    return false;
                                }
                                else if (data.d == "Successfully ShortListed Student") {
                                    alert("Successfully ShortListed Student");
                                    $('#drp_course').val(course_code);
                                    $("#drp_course").trigger("liszt:updated");

                                    $('#btn_retrieve').click();
                                    //location.reload();
                                }

                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });

                }
                else {
                    bootbox.alert("Please Select Check Box");
                    return false;
                }

            });

        });

        function bind_instructor_course() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_vertical_studio_course_for_instructor",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var course_data = JSON.parse(data.d);
                        course_dtl = course_data;

                        $('#drp_course').empty().append($("<option></option>").val("").html("-- Please Select Course --"));

                        for (var i = 0; i < course_data.length; i++)
                        {       //28122020
                                $('#drp_course').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"] + ' - ' + course_data[i]["course_name"]));
                        }

                        $('#drp_course').chosen();
                        $('#drp_course_chzn').css('width','260px');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_student_data_for_course() {
            
            $('#div_student_list').parent().css('display', 'none');
            $('#div_student_list').html('');
            $('.cls_seats').css('display', 'none');

            course_code = $('#drp_course').val();
            if (course_code == "") {
                bootbox.alert('Please Select Course')
                $('#drp_course').focus();
                $('#btn_pdf').css("display", "none");
                $('#btn_short_list_onetime').css("display", "none");
                return false;
            }
            selected_course = $("#drp_course option:selected").text();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_data_for_vertical_course",
                data: "{course_code: '" + course_code + "',semester: '" + semester + "',year_code:'" + year + "'}",
                dataType: "json",
                //async: true,
                success: function (data) {
                    all_data = data;
                    if (data.d != "")
                    {
                        disp_student_data_for_course(JSON.parse(data.d));

                        $("#btn_pdf").css("display", "block");
                       // $("#btn_short_list_onetime").css("display", "none");
                    }
                    else {
                        bootbox.alert('No data Found For Selected Course');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function disp_student_data_for_course(data) {
            var block_select_all = false;
            arr_course_data = data;
            var short_list_count = arr_course_data[0]["short_list_count"];
            var obj_prio = data.map(function (d) { return d.priority });
            var max_prio = obj_prio.reduce(function (a, b) { return Math.max(a, b) });
            var str_tbl_head_prio = '<thead><tr><th style = width:5px;>select<br><input type="checkbox" style="display:block;" id="chk_select_all" onchange="select_all_change()"></th><th style = width:10px;>Student Code</th><th style = width:10px;>Student Name</th><th style = width:10px;display:none;>PDF Link</th><th style = width:10px;>Selection Type </th><th style = width:10px;>Short List (' + short_list_count + ')</th><th style = width:10px;>Allocate Course</th><th style = width:10px;>Course Type</th><th style = width:10px;>GPA/NGPA</th><th style = width:10px;>Remarks</th></tr></thead>';
            var str_tbl_head = '<thead><tr><th style = width:10px;>Student Code</th><th style = width:10px;>Student Name</th><th style = width:10px;display:none;>PDF Link</th><th style = width:10px;>Selection Type </th><th style = width:10px;>Short List </th><th style = width:10px;>Allocate Course</th><th style = width:10px;>Course Type</th><th style = width:10px;>GPA/NGPA</th><th style = width:10px;>Remarks</th></tr></thead>';
            var data_count = '0';
            for (var i = 1; i <= max_prio; i++) {
                var str_html = '';
                var id_count = 'count_student_' + i;
                str_html += '<div class="panel panel-default"><div class="panel-heading"><strong>Students with Priority ' + i + " <span style='color:blue;' id=" + id_count+"></span>" + '</strong></div><div>';
                if (i == 1) {
                    str_html += '<table id="example" class="table table-bordered" style="margin-bottom:0px !important">' + str_tbl_head_prio + '<tbody>';
                }
                else {
                    str_html += '<table class="table table-bordered" style="margin-bottom:0px !important">' + str_tbl_head + '<tbody>';
                }
                var obj_student_prio_data = $.grep(data, function (d) { return d.priority == i.toString() });
                //if (obj_student_prio_data.length == 0) {
                //    str_html = str_html.replace(id_count, '');
                //}
                //else { str_html = str_html.replace(id_count, '( Total Student :  ' + obj_student_prio_data.length + ' )');}

                for (var j = 0; j < obj_student_prio_data.length; j++) {
                    
                    var user_name = obj_student_prio_data[j]['user_name'];
                    user_name = user_name.replace(/ /g, '-');
                    var link = "https://portfolio.cept.ac.in/student/" + user_name + "-" + obj_student_prio_data[j]['user_id'];
                    var prolink = obj_student_prio_data[j]['portfolio_link'];
                    str_html += '<tr>';
                    if (obj_student_prio_data[j]['priority'] == '1')
                    {
                        if (obj_student_prio_data[j]['shortlist_student_status'] == 'Y')
                        {
                            str_html += '<td></td>';
                        }
                        else {
                            if (obj_student_prio_data[j]['checkbox_true_false'] == "True")
                            {
                                str_html += '<td><input type="checkbox" style="display:block"; id=' + obj_student_prio_data[j]['user_id'] + ' class="chk_course" /></td>';
                                $("#btn_short_list_onetime").css("display", "block");
                                block_select_all = true;
                                
                            }
                            else {
                                str_html += '<td></td>';
                                

                            }
                            
                        }
                        
                    }
                    str_html += '<td class="cls_user_id">' + obj_student_prio_data[j]['user_id'] + '</td>';
                    //str_html += '<td>' + obj_student_prio_data[j]['user_name'] + '</td>';
                    str_html += '<td><a href =' + link + ' target="_blank">' + obj_student_prio_data[j]['user_name'] + '</td>';
                    if (obj_student_prio_data[j]['portfolio_link'] != "" && obj_student_prio_data[j]['portfolio_link'] != null) {
                        str_html += '<td style = display:none;><a href =' + prolink + ' target="_blank">PDF</td>';
                    }
                    else
                    {
                        str_html += '<td style = display:none;></td>';
                    }

                    str_html += '<td>' + obj_student_prio_data[j]['studio_type'] + '</td>';

                    if (obj_student_prio_data[j]['priority'] == '1')
                    {

                        if (obj_student_prio_data[j]['shortlist_student_status'] == 'Y')
                        {
                            str_html += '<td>YES</td>';//<input type="button" class="btn btn-primary btn-small cls_allocate" value="ShortList" onclick="shortlist_student(this)" disabled />
                        }
                        else
                        {
                           // if (obj_student_prio_data[j]['priority_status'] != 'D')
                            //{
                                str_html += '<td><input type="button" class="btn btn-primary btn-small cls_allocate" value="Short List" onclick="shortlist_student(this)" /></td>';
                            //}
                            //else
                            //{
                            //    str_html += '<td></td>';
                            //}
                            
                        }
                        
                    }
                    else
                    {
                        str_html += '<td></td>';//<input type="button" class="btn btn-primary btn-small cls_allocate" value="Short List" onclick="shortlist_student(this)" disabled />
                    }
                    
                    if (obj_student_prio_data[j]['parameter_status'] != 'D' && obj_student_prio_data[j]['priority_status'] != 'D')
                    {
                        if (obj_student_prio_data[j]['shortlist_student_status'] == 'Y' && obj_student_prio_data[j]['priority'] == '1' )
                        {
                            str_html += '<td><input type="button" class="btn btn-primary btn-small cls_allocate" value="Allocate" onclick="allocate_course(this)" /></td>';
                        }
                        else
                        {
                            if (obj_student_prio_data[j]['priority'] == '1')
                            {
                                str_html += '<td></td>';//<input type="button" class="btn btn-primary btn-small cls_allocate" value="Allocate" onclick="allocate_course(this)" disabled />
                            }
                            else
                            {
                                str_html += '<td><input type="button" class="btn btn-primary btn-small cls_allocate" value="Allocate" onclick="allocate_course(this)" /></td>';
                            }
                            
                        }

                    }
                    else
                    {
                        if (obj_student_prio_data[j]['priority_status'] != 'D')
                        {
                            str_html += '<td><input type="button" class="btn btn-primary btn-small cls_allocate" value="Allocate" onclick="allocate_course(this)" disabled /></td>';
                        }
                        else
                        {
                            str_html += '<td><Span><b>Priority ' + obj_student_prio_data[j]['priority'] +' Courses Are Not Enable </b></Span></td>';
                        }
                        
                    }
                    
                    str_html += '<td><select class="cls_ele_width cls_course_type"><option value="">Select</option><option value="M">Mandatory</option><option value="E">Elective</option></select></td>';
                    str_html += '<td><select class="cls_ele_width cls_gpa"><option value="">Select</option><option value="G">GPA</option><option value="N">Non GPA</option></select></td>';
                    str_html += '<td><input type="text" class="cls_ele_width cls_remarks" /></td></tr>';
                }

                str_html += '</tbody></table></div></div>';

                $('#div_student_list').append(str_html);
            }

            $('#div_student_list').parent().css('display', 'block');
            if (block_select_all == false) {
                $('#chk_select_all').css('display', 'none');
            }
            
            for (var i = 0; i < course_dtl.length; i++) {
                if ($('#drp_course').val() == course_dtl[i]["course_code"]) {
                    $('.cls_course_type').val(course_dtl[i]["course_type"]);
                    $('.cls_gpa').val(course_dtl[i]["gpa_ngpa"]);
                }
            }
            if (course_count_data.length != null) {
                for (var k = 0; k < course_count_data.length; k++) {
                    if (course_count_data[k]["priority"] == '1') {
                        $('#count_student_' + (k + 1)).text('( Total Student :  ' + course_count_data[k]["TotalStudent"] + ' ,Total Shortlist :  ' + course_count_data[k]["Totalshortliststudent"] + ' ,Total Allocated :  ' + course_count_data[k]["TotalAllocate"] + ' )');
                    }
                    else {
                        $('#count_student_' + (k + 1)).text('( Total Student :  ' + course_count_data[k]["TotalStudent"] + ' ,Total Allocated :  ' + course_count_data[k]["TotalAllocate"] + ' )');
                    }

                }
            }
        }

        function get_available_seat_data() {
            course_code = $('#drp_course').val();

            if (course_code != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_vertical_studio_allocation_status",
                    async: true,
                    data: "{page_no:1,course_code:'" + course_code + "',dept_code:'',sub_cat_id:''}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var course_data = JSON.parse(data.d);

                            if (course_data['message'] != '')
                            {
                                $('#spn_total_seats').html(course_data['message'][0]['available_seat']);
                                $('#spn_remaining_seats').html(course_data['message'][0]['remaining_seats']);
                                $('.cls_seats').css('display', 'inline-block');
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }

        function get_Total_seat_Count() {
            course_code = $('#drp_course').val();

            if (course_code != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_Studio_total_count_dtl",
                    async: true,
                    data: "{course_code:'" + course_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            course_count_data = JSON.parse(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }


        function allocate_course(cur_ele) {
            var cur_tr = $(cur_ele).closest('tr');
            var course_type = cur_tr.find('.cls_course_type').val();
            var gpa_ngpa = cur_tr.find('.cls_gpa').val();

            if (course_type == '') {
                bootbox.alert('Please select Course Type to allocate course');
                return false;
            }

            if (gpa_ngpa == '' && course_type != 'M') {
                bootbox.alert('Please select GPA/NGPA to allocate course');
                return false;
            }

            bootbox.confirm('Are you Sure ?', function (is_confirm) {
                if (is_confirm) {
                    var user_id = cur_tr.find('.cls_user_id').html();
                    var remarks = cur_tr.find('.cls_remarks').val();

                    var obj_stud_data = $.grep(arr_course_data, function (d) { return d.user_id == user_id });

                    if (obj_stud_data.length > 0) {
                        obj_stud_data[0]['remarks'] = remarks;
                        obj_stud_data[0]['course_type'] = course_type;
                        obj_stud_data[0]['gpa_ngpa'] = gpa_ngpa;

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService.asmx/allocate_vertical_studio_course",
                            data: "{student_data: '" + JSON.stringify(obj_stud_data[0]) + "'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "" && data.d != null) {
                                    var res = JSON.parse(data.d);

                                    if (res['status'] == 'True') {
                                        bootbox.alert('Course Allocated Succesfully');
                                        $('#drp_course').val(course_code);
                                        $("#drp_course").trigger("liszt:updated");

                                        //get_student_data_for_course();
                                        $('#btn_retrieve').click();
                                    }
                                    else if (res['status'] == 'False2') {
                                        bootbox.alert(res['message']);
                                        return false;
                                    }
                                    else {
                                        bootbox.alert('Problem in Allocation. Please try again.');
                                        return false;
                                    }
                                }
                                else {
                                    bootbox.alert('Problem in Allocation. Please try again.');
                                    return false;
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                    }
                }
            });
        }


        function shortlist_student(cur_ele) {
            var cur_tr = $(cur_ele).closest('tr');

            var user_id = cur_tr.find('.cls_user_id').html();
            var course_code = $('#drp_course').val();
            var sem_code = '';
            var year_code = '';

            bootbox.confirm('Are you sure you want to Shortlist this student ?', function (is_confirm) {
                if (is_confirm) {
                    $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService.asmx/shortlist_student",
                            data: "{course_code: '" + course_code + "',student_code: '" + user_id + "',sem_code: '" + sem_code + "',year_code: '" + year_code + "'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "" && data.d != null) {
                                    //var res = JSON.parse(data.d);

                                    if (data.d == 'Successfully ShortListed Student') {
                                        bootbox.alert('Student Shortlisted Succesfully');
                                        $('#drp_course').val(course_code);
                                        $("#drp_course").trigger("liszt:updated");

                                        $('#btn_retrieve').click();
                                    }
                                    else if (data.d == 'Problem in ShortList, Please try again.') {
                                        bootbox.alert('Problem in ShortList, Please try again.');
                                        return false;
                                    }
                                    else if (data.d == 'Only 20 Student short Listed ') {
                                        bootbox.alert('You can Shortlist upto 20 Students Only.');
                                    }
                                    else if (data.d == 'Only 25 Student short Listed ') {
                                        bootbox.alert('You can Shortlist upto 25 Students Only.');
                                    }
                                    else {
                                        bootbox.alert('Problem in ShortList. Please try again.');
                                        return false;
                                    }
                                }
                                else {
                                    bootbox.alert('Problem in ShortList. Please try again.');
                                    return false;
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                }
            });
        }
        function Get_Check_box_eable_disable() {
            course_code = $('#drp_course').val();

            if (course_code != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Check_Checkbox_enable_disable",
                    async: true,
                    data: "{course_code:'" + course_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var course_data = JSON.parse(data.d);

                            if (course_data[0]['Checkbox'] == 'True')
                            {
                               //$('.chk_course').attr('disabled', true);
                                $('.chk_course').css('display', 'block');
                                //$('#chk_select_all').attr('disabled', true);
                                $('#chk_select_all').css('display', 'block');
                                //$('#btn_short_list_onetime').attr('disabled', true);
                                $('#btn_short_list_onetime').css('display', 'block');
                                
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }
        function select_all_change() {
            if ($('#chk_select_all')[0].checked) {
                $('.chk_course').attr('checked', 'checked');
            }
            else {
                $('.chk_course').removeAttr('checked');
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Studio Unit Allocation
            </h1>
        </div>

        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Filter Criteria</strong>
                </div>

                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Course
                            </td>
                            <td>
                                <select class="chosen-select" id="drp_course">
                                </select>
                            </td>
                            <td>
                                <input type="button" id="btn_retrieve" class="btn btn-primary" value="Retrieve" />
                            </td>
                            <td class="cls_seats">
                                 <span style="font-weight: bold"> Total Seats : </span><span id="spn_total_seats"></span>
                            </td>
                            <td class="cls_seats">
                                 <span style="font-weight: bold"> Remaining Seats : </span><span id="spn_remaining_seats"></span>
                            </td>
                             <td>
                                <input type="button" style="display:none" id="btn_pdf" class="btn btn-primary" value="PDF" />
                            </td>
                             <td>
                                <input type="button" style="display:none" id="btn_short_list_onetime" class="btn btn-primary" value="Shortlist" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div class="panel panel-default" style="display:none;">
                <div class="panel-heading">
                    <strong>Priority Wise Student List</strong>
                </div>
                
                <div style="margin-top:10px;margin-left:12px;">
                <b><i>* Click on the student name to view their portfolio on <a href="https://portfolio.cept.ac.in" target="_blank"> portfolio.cept.ac.in </a> Click on the PDF link to open/download their "Full Portfolio" document.</i></b>
                </div>
               
                <div id="div_student_list" class="panel-body">
                    
                </div>
            </div>
        </div>
        <input type="hidden" id="hdn_user_type" runat="server" clientidmode="Static" />
    </div>
</asp:Content>