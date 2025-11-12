<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="sws_course_selection_hs.aspx.cs" Inherits="Student_sws_course_selection_hs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var oTable;
        
        var status = 'S';
        var datalist_array = [];
        var ob_array = {};
        var course_combination = '1';
        var time_zone = false;
        $(document).ready(function () {
           
            get_course_dtl();

            $('#btn_reg').on('click', function ()
            {
                $('#btn_reg').prop('disabled', true);
                status = 'R';
                $('#btnsave').click();
            });
            $('#btnsave').on('click', function ()
            {

                
                if ($('.cls_chk_course_select:checked').length === 0) {
                    alert('Please select at least one course.');
                    return false; 
                }

                var datalist = [];
                var course_count_datalist = [];
                var priority_one_count = [];
                $("#example tbody tr").each(function (i)
                {
                    if ($(this).find("select[name='drp_count']").val() != undefined && $(this).find("select[name='drp_count']").val() != 'undefined')
                    {

                        var aPos = oTable.fnGetPosition(this);
                        var a = oTable.fnGetData(aPos);
                        if ($('#cls_chk_course_select_' + a["course_code"] + ':checked').length > 0)
                        {
                            var ob = {};
                            ob["course_code"] = a["course_code"];
                            ob["priority"] = $(this).find(".cls_prio" + '_' + a["credit_combination"]).val();
                            ob["course_credits"] = a["course_credits"];
                            ob["course_type"] = a["course_type"];
                            ob["status"] = status;
                            ob["credit_combination"] = a["credit_combination"];
                            course_count_datalist.push(ob);
                        }
                        
                    }

                    if ($(this).find("select[name='drp_count']").val() != '' && $(this).find("select[name='drp_count']").val() != undefined && $(this).find("select[name='drp_count']").val() != 'undefined') {
                        var aPos = oTable.fnGetPosition(this);
                        var a = oTable.fnGetData(aPos);
                        var ob = {};

                        if ($('#cls_chk_course_select_' + a["course_code"] + ':checked').length > 0)
                        {
                            ob["course_code"] = a["course_code"];
                            ob["priority"] = $(this).find(".cls_prio" + '_' + a["credit_combination"]).val();
                            ob["course_credits"] = a["course_credits"];
                            ob["course_type"] = a["course_type"];
                            ob["status"] = status;
                            ob["credit_combination"] = a["credit_combination"];
                            datalist.push(ob);
                        }
                    }
                });
                var count_course = parseInt(course_combination) * parseInt(8);
                 
                for (var q = 1; q <= course_combination; q++)
                {
                    

                    var priority_one = $.grep(datalist, function (v) {
                        return v.credit_combination == q && v.priority == '1';
                    });
                    if (priority_one != undefined && priority_one.length != 0) {

                        var ob_one = {};
                        ob_one["count"] = '1';
                        priority_one_count.push(ob_one);
                    }

                    var found_count = $.grep(datalist, function (v) {
                        return v.credit_combination == q;
                    });

                    var course_count = $.grep(course_count_datalist, function (v) {
                        return v.credit_combination == q;
                    });
                    if (course_count.length > 2) {

                        if (found_count.length < 3) {
                            bootbox.alert("Minimum 1 & Maximum 3 Preferences to complete the SW Course Registration for each course choice");
                            return false;

                        }
                    }
                }

                if (course_combination != priority_one_count.length)
                {
                    bootbox.alert("You Have to select priority 1 in each course combination");
                    return false;
                }
                for (var p = 1; p <= course_combination; p++)
                {
                    for (var k = 1; k <= 3; k++)
                    {
                        var obj = datalist.filter(o => o.priority == k);
                        if (obj.length > 1)
                        {
                            for (var w = 0; w < obj.length; w++) {
                                var obj_course_p = obj.filter(o => o.course_code == obj[w]['course_code']);
                                if (obj_course_p.length > 1)
                                {
                                    alert("You Can Not Give Same Preference multiple Time In Same Course");
                                    return false;
                                }
                            }
                            
                            
                        }
                    }
                    
                }
                

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_sws_course_reg_data_HS",
                    async: false,
                    data: "{ws_course_data : '" + JSON.stringify(datalist) + "',status : '" + status + "'}",
                    dataType: "json",
                    success: function (data)
                    {
                        if (data.d == "Time") {
                            alert('The window for submitting preferences will be between 10 AM to 5PM on each day during the registration period');
                            return false;
                        }
                        else if (data.d == "Course Save Successfully")
                        {
                            var dt = new Date();
                            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
                            if (status == 'R')
                            {
                                alert("SW Course Preference Successfully Submitted with the timestamp : " + time);
                            }
                            else
                            {
                                alert("SW Course Preference Successfully Saved");
                            }
                            return false;
                            
                        }
                        else if (data.d == "Combination Problem")
                        {
                            alert("Minimum 3 & Maximum 8 Preferences to complete the SW Course Registration for each course choice");
                            return false;
                        }
                        else {
                            bootbox.alert(data.d);
                        } 
                        return false;
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

            //$('#btnprev').on('click', function () {
            //    var origin = window.location.origin;
            //    window.location.replace(origin + "/Student/" + "sws_credit_choice.aspx");
            //    return false;
            //});

            return false;
        });
        function drp_select_change(cur_ele) {
           
            var pre = '';
            for (var i = 0; i < datalist_array.length; i++) {
                if (cur_ele.id == datalist_array[i]['course_id'])
                {
                    pre = datalist_array[i]['course_pri'];
                    datalist_array.splice(i, 1);
                    break;
                }
            }
            ob_array = {};
            ob_array["course_id"] = cur_ele.id;
            ob_array["course_pri"] = $('#' + cur_ele.id).val();
            datalist_array.push(ob_array);

            var optio_id = cur_ele.id;
            $('#' + optio_id).removeClass('hide');
            var optio_class = cur_ele.className;
            var option = $('#' + optio_id).val();
            $('.' + optio_class + ' option[value=' + option + ']').addClass('hide');
            $('#' + optio_id + ' option[value=' + option + ']').removeClass('hide');
            $('.' + optio_class + ' option[value=' + pre + ']').removeClass('hide');
        }

        

        function get_course_dtl() {

            $('#DataList').css('display', 'none');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_SWS_Course_dtl_hs",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    //if (data.d[2] != "" && data.d[2] != null)
                    //{
                    //    var course_com = JSON.parse(data.d[2]);
                    //    course_combination = course_com.length;
                    //}
                    if (data.d[0] != "" && data.d[0] != null)
                    {
                        display_student_Course(data.d[0]);
                    }
                    if (data.d[1] != "" && data.d[1] != null)
                    {
                        var reg_data = JSON.parse(data.d[1]);
                        if (reg_data[0]['status'] == 'R') {
                    
                            $('#btn_reg').css('display', 'none');
                            $('#btnsave').css('display', 'none');
                            $('#btnprev').css('display', 'none');
                            var origin = window.location.origin;
                            window.location.replace(origin + "/Student/" + "sws_payment_dtl_hs.aspx");
                            // window.location.replace(origin + "/Student/" + "sws_credit_choice.aspx");
                            return false;
                        }
                        for (var i = 0; i < reg_data.length; i++)
                        {
                            
                            $('#cls_chk_course_select_' + reg_data[i]['course_code']).attr('checked', 'checked');
                            //$('.' + optio_class + ' option[value=' + reg_data[i]['priority'] + ']').addClass('hide');
                        
                            ob_array = {};
                            $('#cls_prio_' + reg_data[i]['course_code'] + '_' + reg_data[i]['credit_combination']).val(reg_data[i]['priority']);
                            var optio_class = 'cls_prio_' + reg_data[i]['credit_combination'];
                    
                            $('.' + optio_class + ' option[value=' + reg_data[i]['priority'] + ']').addClass('hide');
                            $('#cls_prio_' + reg_data[i]['course_code'] + '_' + reg_data[i]['credit_combination'] + ' option[value=' + reg_data[i]['priority'] + ']').removeClass('hide');
                            
                    
                            ob_array["course_id"] = 'cls_prio_' + reg_data[i]['course_code'] + '_' + reg_data[i]['credit_combination'];
                            ob_array["course_pri"] = reg_data[i]['priority'];
                            datalist_array.push(ob_array);
                    
                        }                       
                    }

                    else {
                        
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function display_student_Course(data) {
            var prio_option = '';
            prio_option += '<option value="">Please Select Priority</option>';
            prio_option += '<option value="1">1</option>';
            prio_option += '<option value="2">2</option>';
            prio_option += '<option value="3">3</option>';
            
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"columnDefs": [

                //    { 'visible': false, 'targets': [2, 3, 13] }
                    
                //],
                //"columnDefs": [{
                //    "className": 'cls_title',
                //    "targets": 0,
                //    "render": function (data, type, row) {
                //        return '';
                //    }
                //}],
                "rowCallback": function (row, data) {

                    $('tr .group').css('color', 'blue');
                    if (data.new_credit != "") {
                        //$(this).css('color', 'blue');
                        //    $('td:eq(0)', row).html('<b>A</b>');
                    }
                },

                //"aaData": ModifiedData,
                "aaData": JSON.parse(data),
                "aoColumns": [
                   // { "sTitle": "CreditCourse Name", "mData": "new_credit", "bSortable": false, "bVisible": false, "className": 'cls_title1' },
                    {
                        "sTitle": "Select ", "mData": null, "bSortable": false, mRender: function (data) {
                            return '<input type="checkbox" id="cls_chk_course_select_' + data.course_code +'" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                    
                        }
                    },
                    {
                        "sTitle": "Select priority", "mData": null, "bSortable": false, mRender: function (data) {


                            return '<select name= drp_count id=cls_prio_' + data.course_code + '_' + data.credit_combination + ' onchange="drp_select_change(this)"  class = cls_prio_' + data.credit_combination + '>' + prio_option + '</select>';

                        }
                    },
                    //
                    
                    { "sTitle": "Course Credit", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Course combination", "mData": "credit_combination", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Course Category", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Start Date", "mData": "start_date", "bSortable": false },
                    { "sTitle": "End Date", "mData": "end_date", "bSortable": false },

                    //{ "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    //{ "sTitle": "Total Seats", "mData": "available_seat", "bSortable": false },
                    //{ "sTitle": "Available Seats", "mData": "remaning_seats", "bSortable": false },
                    { "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },

                    { "sTitle": "Course Type", "mData": "course_type", "bSortable": false }
                    //{ "sTitle": "Student Faculty", "mData": "dept_name", "bSortable": false },
                    //{ "sTitle": "Student Program", "mData": "prog_name", "bSortable": false },
                    //{ "sTitle": "Student Program Level", "mData": "prog_level_code", "bSortable": false },
                    //{ "sTitle": "GPA / Non GPA", "mData": "gpa_nongpa", "bSortable": false },
                    //{ "sTitle": "Course Credits", "mData": "course_credits", "bSortable": false },
                    //{ "sTitle": "Priority", "mData": "priority", "bSortable": false },
                    //{ "sTitle": "Selection Type", "mData": "studio_type", "bSortable": false }
                ]
            });
            //.rowGrouping()
            $('#DataList').css('display', 'block');

            $(".cls_title").css('color', 'blue');

        }

        

       
        
    </script>

    <style>
        .cls_title {
            font-weight: bold !important;
            color: blue !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">

            <h1>
                <i class="icon-desktop"></i>SW Course Selection
            </h1>
        </div>
    </div>
    <div>
        <div id="credit_section">
            <div id="DataList" style="display: none; overflow: auto;" class="panel panel-default">
                <div class="panel-heading">
                    <strong id="panel_head">SW Elective Registration Preference Details</strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <div align="center" id="div_button">
                <%--<button class="btn btn-primary" id="btnprev">Previous</button>--%>
                <button class="btn btn-primary" id="btnsave">Save</button>
                <button class="btn btn-primary" id="btn_reg">Submit</button>
                
            </div>
        </div>

    </div>

</asp:Content>

