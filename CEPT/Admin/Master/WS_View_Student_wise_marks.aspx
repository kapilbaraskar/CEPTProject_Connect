<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_View_Student_wise_marks.aspx.cs" Inherits="Admin_Master_WS_View_Student_wise_marks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <style>
        .inline_input
        {
            width:35px;
            margin:0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Wise Marks
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            
            <div class="panel-heading">
                <strong><span id="spn_course_name" class="panel-headingfont"></span> </strong>
                <span style="float:right;">
                    <%--<input id="btn_add_exam" type="button" class="btn btn-primary" value="Add Assessment" style="height: 40px;margin-top: -10px;" onclick="addModalData()"/>
                    <input id="btn_show_modal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal" value="Add Exam" style="height: 40px;margin-top: -10px;display:none;"/>--%>
                </span>
            </div>
            
            <div <%--class="panel-body"--%>>
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
        </div>

        <table style="width: 50%;margin-left: 20%;">
            <tr id='tbl_tr_btn'>
                <%--<td align="center">
                    <button id="btn_calc_grade" type="button" class="btn btn-lg btn-primary" onclick="send_for_review()">Send for Review</button>
                </td>
                <td align="left">
                    <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_grade()">Submit</button>
                </td>--%>
            </tr>
        </table>

    </div>


    <input type="hidden" id="hdn_c" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_s" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_y" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_pc" runat="server" clientidmode="Static"/>

   <script type="text/javascript">
        var oTable;
        var editor1 = { 'doc_no': '', 'student_code': '', 'course_code': '', 'attendance': null, 'exam_1': null, 'exam_2': null, 'exam_3': null, 'exam_4': null, 'exam_5': null, 'exam_6': null, 'exam_7': null, 'exam_8': null, 'exam_9': null, 'exam_10': null, 'absent_exam_1': '', 'absent_exam_2': '', 'absent_exam_3': '', 'absent_exam_4': '', 'absent_exam_5': '', 'absent_exam_6': '', 'absent_exam_7': '', 'absent_exam_8': '', 'absent_exam_9': '', 'absent_exam_10': '', 'sem_code': null, 'year_code': null };
        var course_exams = [];
        var table_headers;
        var sem = '';
        var year = '';
        var tempData = [];
        var student_marks;
        var course_detail;

        $(document).ready(function () {

            sem = $('#hdn_s').val();
            year = $('#hdn_y').val();

            get_course_detail();

            course_wise_exam();

            if ($('#hdnusertype').val() == 'PC') {
                if ($('#hdn_pc').val() != 'PCI2') {
                    $('#tbl_tr_btn').html('<td align="center"><button id="btn_calc_grade" type="button" class="btn btn-lg btn-primary" onclick="send_for_review()">Send for Review</button></td>' +
                            '<td align="left"><button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_course_grade()">Submit</button></td>');
                }
            }
            else if ($('#hdnusertype').val() == 'A1') {
                $('#tbl_tr_btn').html('<td align="center"><button id="btn_calc_grade" type="button" class="btn btn-lg btn-primary" onclick="send_for_review()">Send for Review</button></td>');
            }
            else if ($('#hdnusertype').val() == 'D') {
                $('#tbl_tr_btn').html('<td align="center"><button id="btn_calc_grade" type="button" class="btn btn-lg btn-primary" onclick="send_for_review()">Send for Review</button></td>');
            }
            else if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A') {
                $('#tbl_tr_btn').html('<td align="center"><button id="btn_calc_grade" type="button" class="btn btn-lg btn-primary" onclick="send_for_review()">Send for Review</button></td>');
            }
        });

        function submit_course_grade() {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_submit_course_grade",
                //async: false,
                data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "', page:'VIEW'}",
                dataType: "json",
                success: function (data) {
                    tempData = [];
                    if (data.d != "" && data.d != "[]") {
                        if (data.d == 'Data Saved Successfully') {
                            bootbox.alert('Course submitted successfully', function (result) {
                                window.location = "Course_wise_entered_marks.aspx";
                            });
                        }
                        else {
                            bootbox.alert(data.d);
                        }
                    }
                    //course_wise_exam();
                },
                error: function (result) {
                    tempData = [];
                    alert(result);
                }
            });
        }


        function send_for_review() {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_send_for_review",
                //async: false,
                data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        bootbox.alert(data.d, function () {
                            location.replace('WS_Course_wise_entered_marks.aspx');
                        });
                    }
                },
                error: function (result) {
                    tempData = [];
                    alert(result);
                }
            });
        }


        function get_course_detail() {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_course_detail",
                //async: false,
                data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        course_detail = JSON.parse(data.d);
                        $('#spn_course_name').html('' + course_detail[0]['course_code'] + ' - ' + course_detail[0]['course_name']);
                        $('#H1').html('' + course_detail[0]['course_code'] + ' - ' + course_detail[0]['course_name']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }



        function course_wise_exam() {
            //$('#DataList').css('display', 'none');

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_course_wise_exam_list",
                //async: false,
                data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                dataType: "json",
                success: function (data) {

                    table_headers = [
                    //{ "sTitle": "Doc No", "mData": "doc_no", "bSortable": false, "bVisible": false },       
                                            {"sTitle": "Student Code", "mData": "student_code", "bSortable": false },
                                            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false }
                                        ];
                    if (data.d != "" && data.d != "[]") {

                        table_headers.push({ "sTitle": "Attendance", "mData": "attendance", "bSortable": false });

                        //course_wise_exam_weightage_list(data.d);
                        course_exams = JSON.parse(data.d);

                        for (var i = 0; i < course_exams.length; i++) {
                            var header_def = { "sTitle": course_exams[i].exam_title + ' (' + course_exams[i].weightage + '%)', "mData": course_exams[i].exam_code, "bSortable": false };

                            //                    var header_def = { "sTitle": course_exams[i].exam_title + ' (' + course_exams[i].weightage + '%)', "mData": course_exams[i].exam_code, "bSortable": false, mRender: function (ddata) {
                            //                        return "<input type='text' value='" + ddata + "' class='inline_input' onkeypress='return IsNumeric(event);'/>" +
                            //                                "<select class='cls_absent' style='width: 46px;margin-top: 5px;padding:0px;'>" +
                            //	                                "<option value=''>--</option>" +
                            //  	                                "<option value='AB'>AB</option>" +
                            //  	                                "<option value='NA'>NA</option>" +
                            //                                "</select>";
                            //                    }
                            //                    };

                            //table_headers.push(header_def);
                        }

                        //table_headers.push({ "sTitle": "Total Marks", "mData": "subject_marks", "bSortable": false });
                        table_headers.push({ "sTitle": "Student Grade", "mData": "course_grade", "bSortable": false });

                    }

                    //table_headers.push({ "sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) { return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>'; } });

                    course_wise_student_marks();

                },
                error: function (result) {
                    alert(result);
                }
            });

            //return false;
        }


        function course_wise_student_marks() {
            //$('#DataList').css('display', 'none');
            var ajax_url = "../../WebService.asmx/ws_get_student_wise_grade";

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                //url: "../../WebService.asmx/ws_course_wise_student_marks_list",
                url: ajax_url,
                //async: false,
                data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                dataType: "json",
                success: function (data) {
                     
                    if (data.d != "" && data.d != "[]") {
                        //course_wise_exam_weightage_list(data.d);
                        //course_exams = JSON.parse(data.d);
                        student_marks = JSON.parse(data.d);

                        student_wise_marks_list(student_marks);
                    }
                    else if (data.d == "") {
                        student_wise_marks_list(data.d);
                    }
                    else if (data.d == "[]") {
                        if (ajax_url == "../../WebService.asmx/ws_get_student_wise_grade") {
                            bootbox.alert('Grade Range not Found for given marks');
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            //return false;
        }


        function student_wise_marks_list(data) {

            for (var i = 0; i < data.length; i++) {
                if (data[i].absent_exam_1 == 'AB' || data[i].absent_exam_1 == 'NA') data[i].exam_1 = data[i].absent_exam_1;
                if (data[i].absent_exam_2 == 'AB' || data[i].absent_exam_2 == 'NA') data[i].exam_2 = data[i].absent_exam_2;
                if (data[i].absent_exam_3 == 'AB' || data[i].absent_exam_3 == 'NA') data[i].exam_3 = data[i].absent_exam_3;
                if (data[i].absent_exam_4 == 'AB' || data[i].absent_exam_4 == 'NA') data[i].exam_4 = data[i].absent_exam_4;
                if (data[i].absent_exam_5 == 'AB' || data[i].absent_exam_5 == 'NA') data[i].exam_5 = data[i].absent_exam_5;
                if (data[i].absent_exam_6 == 'AB' || data[i].absent_exam_6 == 'NA') data[i].exam_6 = data[i].absent_exam_6;
                if (data[i].absent_exam_7 == 'AB' || data[i].absent_exam_7 == 'NA') data[i].exam_7 = data[i].absent_exam_7;
                if (data[i].absent_exam_8 == 'AB' || data[i].absent_exam_8 == 'NA') data[i].exam_8 = data[i].absent_exam_8;
                if (data[i].absent_exam_9 == 'AB' || data[i].absent_exam_9 == 'NA') data[i].exam_9 = data[i].absent_exam_9;
                if (data[i].absent_exam_10 == 'AB' || data[i].absent_exam_10 == 'NA') data[i].exam_10 = data[i].absent_exam_10;
            }

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
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sDom": 't',
               // "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                   // "aButtons": [
                    //"copy",
				//"print",
            	//{
            	    //"sExtends": "collection",
            	    //"sButtonText": 'Export',
            	    //"aButtons": ["xls"]
            	//}
			//]
               // },

                "aaData": data,

                "aoColumns": table_headers

            });

            $('#DataList').css('display', 'block');
        }

   </script> 

</asp:Content>

