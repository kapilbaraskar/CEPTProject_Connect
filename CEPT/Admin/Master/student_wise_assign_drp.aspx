<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_wise_assign_drp.aspx.cs" Inherits="Admin_Master_student_wise_assign_drp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <style>
        #counter td {
            width: 20%;
        }

        td#total_set {
            color: red;
        }

        td#funded_set {
            color: red;
        }

        td#unfunded_set {
            color: red;
        }

        td#rem_funded_set {
            color: red;
        }

        td#rem_unfunded_set {
            color: red;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var oTable1;
        var semester = '';
        var year_code = '';
        var course_code = '';
        var drp_topic_code = '';
        var tempData = [];
        var data_value = { 'user_id': '', 'course_code': '', 'seats': null, 'drp_code': '', 'semester_type': null, 'year_semester': null };
        var status = true;
        var second_status = '';
        var previous;
        var select_prev_value;
        var pdf_path = '';
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            //17072021
            bindproglevel();
            bindstudentyeardata();
            $('#btnreterive').on('click', function () {
                $("#div_tab").css('display', 'block');
                var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#drp_student'>DRP student</a></li>" +
                    "<li><a data-toggle='tab' href='#drp_stu_allocated'>Allocated DRP student&nbsp; </a></li></ul>";
                $("#div_myTab").html(strHtml);
                $("#drp_student").addClass("in active");
                get_drp_data();
                get_drp_data_details();
                return false;
            });
            $("#drpyear").change(function () {
                $('#drpcode').find('option').remove().end().append('<option value="">No Course found</option>').val('');
                $('#drpcode').chosen();
                $('#drpcode').val('').trigger("liszt:updated");

                $('#drptopic').find('option').remove().end().append('<option value="">No DRP Topic found</option>').val('');
                $('#drptopic').chosen();
                $('#drptopic').val('').trigger("liszt:updated");
                bind_course();
                $('#div_course_list').css('display', 'none');
            });
            $("#drpcode").change(function () {

                bind_drp_topic();
                $('#div_course_list').css('display', 'none');
            });
            $("#drptopic").change(function () {
                $('#div_course_list').css('display', 'none');
            });
            $("#drpsemester").change(function () {

                $('#drpcode').find('option').remove().end().append('<option value="">No Course found</option>').val('');
                $('#drpcode').chosen();
                $('#drpcode').val('').trigger("liszt:updated");

                $('#drptopic').find('option').remove().end().append('<option value="">No DRP Topic found</option>').val('');
                $('#drptopic').chosen();
                $('#drptopic').val('').trigger("liszt:updated");
                $('#drpyear').val('').trigger("liszt:updated");
                $('#div_course_list').css('display', 'none');
            });
            
        });
        function click_value(e) {

            previous = e.value;
            select_prev_value = e.id;
        }
        function change_value(e) {
            var funded_count = 0;
            var unfunded_count = 0;
            for (var i = 0; i < $('#example tbody tr').length; i++) {
                var seat_type = $('#example tbody tr:nth-child(' + (i + 1) + ')').find('.cls_drp_type').val();
                if (seat_type == "F") {
                    funded_count = parseInt(funded_count) + 1;
                }
                else if (seat_type == "UF") {
                    unfunded_count = parseInt(unfunded_count) + 1;
                }
            }
            if (parseInt($('#funded_set').html()) >= parseInt(funded_count)) {
                $('#rem_funded_set').html(parseInt($('#funded_set').html()) - parseInt(funded_count));
            }
            else {
                bootbox.alert('No more funded seats are available.');
                $('#' + select_prev_value + '').val(previous);
                return false;
            }
            if (parseInt($('#unfunded_set').html()) >= parseInt(unfunded_count)) {
                $('#rem_unfunded_set').html(parseInt($('#unfunded_set').html()) - parseInt(unfunded_count));
            }
            else {
                bootbox.alert('No more unfunded seats are available.');
                $('#' + select_prev_value + '').val(previous);
                return false;
            }

        }
        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_current_grade_semester",
                //async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            $('#btnreterive').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();

        }
        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)
                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }
                        $('#drpyear').chosen();


                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bind_course() {
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            course_code = '';


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_user_wise_drp_course",
                async: true,

                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

                        var course_code = JSON.parse(data.d)

                        $('#drpcode').empty().append($("<option></option>").val("").html("-- Please Select Course Code --"));
                        for (var i = 0; i < course_code.length; i++) {
                            $('#drpcode').append($("<option></option>").val(course_code[i]["course_code"]).html(course_code[i]["course_code"]));
                        }
                        $('#drpcode').chosen();
                        $('#drpcode').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });


        }
        function bind_drp_topic() {
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            course_code = $('#drpcode').val();



            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_user_wise_drp_course",
                async: true,

                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:'" + course_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var course_code = JSON.parse(data.d)

                        $('#drptopic').empty().append($("<option></option>").val("").html("-- Please Select DRP Topic --"));
                        for (var i = 0; i < course_code.length; i++) {
                            $('#drptopic').append($("<option></option>").val(course_code[i]["drp_code"]).html(course_code[i]["topic"]));
                        }
                        $('#drptopic').chosen();
                        $('#drptopic').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    bootbox.alert(result);
                }
            });

        }
        function get_drp_data()
        {
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            drp_topic_code = $('#drptopic').val();
            if (drp_topic_code == "") {
                bootbox.alert('Please select DRP Topic');
                $('#drptopic').focus();
                return false;
            }
            course_code = $('#drpcode').val();
            if (course_code == "") {
                bootbox.alert('Please select Course Code');
                $('#drpcode').focus();
                return false;
            }
            var student_year_code = $('#drp_student_enroll_year').val();
            var prog_level = $('#drpproglevel').val();
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_course_wise_drp_student",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:'" + course_code + "',drp_code:'" + drp_topic_code + "',student_year_code:'" + student_year_code + "',prog_level:'" + prog_level+"'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var user_dtl = JSON.parse(data.d);
                            course_wise_student_list(data.d);
                            drp_value_count();
                            $('#div_course_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            $('#div_course_list').css('display', 'none');

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function drp_value_count() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_total_funded_unfunded_set",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:'" + course_code + "',drp_code:'" + drp_topic_code + "',dept_code:'',prog_code:''}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var values_drp = JSON.parse(data.d)
                            $("#topic_name").html(values_drp[0]['topic']);
                            $('#total_set').html(values_drp[0]['vacant_seats']);
                            $('#funded_set').html(values_drp[0]['funded_seats']);
                            $('#unfunded_set').html(values_drp[0]['unfunded_seats']);
                            $('#rem_funded_set').html(values_drp[0]['fund_rem_set']);
                            $('#rem_unfunded_set').html(values_drp[0]['unfund_rem_set']);
                            if (values_drp[0]['doc_path'] != '') {
                                $('.av_pdf').css('display', 'block');
                                $('.no_pdf').css('display', 'none');
                                pdf_path = '../../DRPTopicBriefDocs/' + values_drp[0]['doc_path'];
                                $("#link").attr('href', pdf_path);
                            }
                            else {
                                $('.av_pdf').css('display', 'none');
                                $('.no_pdf').css('display', 'block');
                            }
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');


                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }
        function course_wise_student_list(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Student Code ", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    {
                        "sTitle": "DRP Topic Assign Staus", "mData": null, "bSortable": false, fnRender: function (data)
                        {
                            //if (data.aData.status1 == 'A') {
                            if (data.aData.drp_code != '') {
                                //return '<b>' + data.aData.topic + '</b>';//"YES";
                                return "YES";
                            }
                            else
                            {
                                return "<b>NO</b>";
                            }
                        }
                    },
                    {
                        "sTitle": "Seats", "mData": null, "bSortable": false, fnRender: function (data) {
                            return '<select onchange="change_value(this)" onclick="click_value(this)" id ="' + data.aData.user_id + '" class="cls_drp_type" style="width:170px;"><option value="">--Select Seats--</option><option value="F">Funded</option><option value="UF">Unfunded</option></select>' +

                                '<input type="hidden" class="cls_hdn_drp_type" value="' + data.aData.seat_type + '" />';
                        }
                    }
                ]
            });
            for (var i = 0; i < $('#example tbody tr').length; i++) {
                var temp_tr = $('#example tbody tr:nth-child(' + (i + 1) + ')');

                temp_tr.find('.cls_drp_type').val(temp_tr.find('.cls_hdn_drp_type').val());

            }
            $('#DataList').css('display', 'block');

        }
        function submit_drp()
        {
            $("#example tbody tr").each(function (i) {

                data_value.user_id = $(this).children().eq(0).html();
                data_value.seats = $(this).children().eq(3)[0].children[0].value;// changes 04122020

                data_value.course_code = $('#drpcode').val();
                data_value.drp_code = $('#drptopic').val();

                data_value.semester_type = $('#drpsemester').val();
                data_value.year_semester = $('#drpyear').val();

                tempData.push(data_value);
                data_value = { 'user_id': '', 'course_code': '', 'seats': null, 'drp_code': '', 'semester_type': null, 'year_semester': null };

            });

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_all_drp_value",

                    data: "{student_drp_Data:'" + JSON.stringify(tempData) + "'}",
                    dataType: "json",
                    success: function (data) {
                        tempData = [];
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'Data Saved Successfully') {
                                get_drp_data();
                                bootbox.alert("Data Saved Successfully");

                            }
                            else {
                                bootbox.alert(data.d);
                            }
                        }
                        //course_wise_exam();
                    },
                    error: function (result) {
                        tempData = [];
                        bootbox.alert(result);
                    }
                });

        }


        function bindstudentyeardata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drp_student_enroll_year').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drp_student_enroll_year').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drp_student_enroll_year').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function bindproglevel()
        {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d);

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }
                        $('#drpproglevel').chosen();
                       
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_drp_data_details() {
            $('#DataList1').css('display', 'none');

            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            drp_topic_code = $('#drptopic').val();
            if (drp_topic_code == "") {
                bootbox.alert('Please select DRP Topic');
                $('#drptopic').focus();
                return false;
            }
            course_code = $('#drpcode').val();
            if (course_code == "") {
                bootbox.alert('Please select Course Code');
                $('#drpcode').focus();
                return false;
            }
            var student_year_code = $('#drp_student_enroll_year').val();
            var prog_level = $('#drpproglevel').val();

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_drp_student_dtl",
                    async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',drp_code:'" + drp_topic_code + "', course_code:'" + course_code + "',student_year_code:'" + student_year_code + "',prog_level:'" + prog_level+"'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {

                            display_DRP_Student_dtl(data.d);

                            //$('#div_course_list').css('display', 'block');
                        }
                        else {
                           // bootbox.alert('No data Found For DRP Details');
                           // return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function display_DRP_Student_dtl(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approve" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example_approve").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 30,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                "aaData": JSON.parse(data),

                "aoColumns": columns

            });
            // $("table thead tr th:nth-child(1)").css("width","70%");
            //$('.dt-button.buttons-csv.buttons-html5')[1].innerText = 'Excel';
            $('#DataList1').css('display', 'block');
        }

        function set_table_columns(row) {
            var columns = [];
            
            columns.push({ "sTitle": "Course Code", "mData": "course_code" });
            columns.push({ "sTitle": "Student Code", "mData": "student_id" });
            columns.push({ "sTitle": "Studnet Name", "mData": "full_name" });
            columns.push({ "sTitle": "Seat Type", "mData": "seat_type" });
           
            return columns;
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Wise Assign DRP
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>Course :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpcode">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                
                                  <td>Student Enrollment Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drp_student_enroll_year">
                                    </select>
                                </td>
                                <td>DRP Topic : 
                                </td>
                                <td>
                                    <select class="chosen-select" id="drptopic">
                                    </select>
                                </td>

                                <td>
                               Program Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
                            </td>
                               
                            </tr>
                            <tr>
                                 <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>DRP Topic Name : <span id="topic_name" style="color:blue"></span></strong>
            </div>
            <div id="div_myTab">
                <%--<ul class="nav nav-tabs" id="myTab">
                <li class="active"><a data-toggle="tab" href="#pendingthesis">Thesis Pending for Approval&nbsp;</a>
                </li>
                <li><a data-toggle="tab" href="#thesisinfo">Thesis Approve/Reject &nbsp; </a></li>
                </ul>--%>
            </div>

               <div class="tab-content">

                   <div id="drp_student" class="tab-pane">
            <div class="panel panel-default" id="counter">
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td><b>Total Vacant Seats : </b></td>
                        <td id="total_set"></td>
                        <td><b>Total Funded Seats : </b></td>
                        <td id="funded_set"></td>
                        <td><b>Total Unfunded Seats : </b></td>
                        <td id="unfunded_set"></td>
                    </tr>
                    <tr>
                        <td><span><b>DRP Topic Brief Details: </b></span></td>
                        <td><span><a id="link" class="av_pdf" style="display: none;" href="" download>Download PDF</a> </span><span class="no_pdf" style="display: none;">PDF Not Available</span></td>
                        <td><b>Remaining Funded Seats : </b></td>
                        <td id="rem_funded_set"></td>
                        <td><b>Remaining Unfunded Seats : </b></td>
                        <td id="rem_unfunded_set"></td>
                    </tr>
                </table>
            </div>
            <div>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div>
                <table style="width: 62%; margin-left: 15%;">
                    <tr>
                        <td align="center">
                            <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_drp()">Submit</button>
                        </td>
                    </tr>
                </table>
            </div>
                       </div>
                    <div id="drp_stu_allocated" class="tab-pane">
                        <div id="DataList1" style="display: none; overflow: auto">
                            <table cellpadding="0" cellspacing="0" border="0" id="example_approve" class="display table table-striped table-bordered table-hover"
                                width="100%">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>


                   </div>
        </div>


    </div>
    <input type="hidden" class="drp_value" value="" />
    <input type="hidden" class="drp_second_value" value="" />
</asp:Content>

