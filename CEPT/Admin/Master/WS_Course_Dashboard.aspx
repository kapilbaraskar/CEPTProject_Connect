<%@ Page Title=" WS Course Information" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_Course_Dashboard.aspx.cs" Inherits="Admin_Master_media_WS_Course_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     
    <%--<script src="../../Js/admin_report.js" type="text/javascript"></script>--%>
    <script src="../../Js/ws_course_dashboard_09082017.js?t=02092024" type="text/javascript"></script>
    
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <style type="text/css">
    </style>

    <script type="text/javascript">

        $(document).ready(function () {
            if (getParameterByName("iel") == 'true') {
                bootbox.alert('You can not enter more than one course.', function (result) {
                    window.location.replace('WS_Course_Dashboard.aspx');
                });
            }
            //bindsemdata();
            //bindyeardata_for_cross_reg();
            //setCurrentSemester();
            
            //$('#btn_print_modal_view').on('click', function () {
            //    //var mywindow = window.open('ws_course_info_print.htm', 'print_data');
            //    //                
            //    //setTimeout(function () {
            //    //    for (var i = 0; i < 15; i++) { mywindow.document.head.innerHTML += $('link')[i].outerHTML; }
            //    //    setTimeout(function () {
            //    //        mywindow.document.body.innerHTML = $('#mynewModal_view .modal-body').html().replace(/col-md/g, 'col-xs');
            //    //        setTimeout(function () {
            //    //            mywindow.print();
            //    //            mywindow.close();
            //    //        }, 0);
            //    //    }, 0);
            //    //}, 0);
            //    mywindow = window.open('ws_course_info_print.htm', 'print_data');
            //    for (var i = 0; i < 15; i++) { mywindow.document.head.innerHTML += $('link')[i].outerHTML; }
            //    mywindow.document.body.innerHTML = $('#mynewModal_view .modal-body').html().replace(/col-md/g, 'col-xs');
            //    mywindow.print();
            //    mywindow.close();
            //    return false;
            //});
        });

        function btn_print_modal_view_click() {
            //var mywindow = window.open('ws_course_info_print.htm', 'print_data');
            //                
            //setTimeout(function () {
            //    for (var i = 0; i < 15; i++) { mywindow.document.head.innerHTML += $('link')[i].outerHTML; }
            //    setTimeout(function () {
            //        mywindow.document.body.innerHTML = $('#mynewModal_view .modal-body').html().replace(/col-md/g, 'col-xs');
            //        setTimeout(function () {
            //            mywindow.print();
            //            mywindow.close();
            //        }, 0);
            //    }, 0);
            //}, 0);

            mywindow = window.open('ws_course_info_print.htm', 'print_data');

            for (var i = 0; i < 15; i++) { mywindow.document.head.innerHTML += $('link')[i].outerHTML; }

            mywindow.document.body.innerHTML = $('#mynewModal_view .modal-body').html().replace(/col-md/g, 'col-xs');

            mywindow.print();
            mywindow.close();

            return false;
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            $('#drpsemester').chosen();
        }
        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'ws_course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            get_acuser_detail();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>
                            Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>
                            Year of allocation :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td class="cls_dept_prog" style="display:none;">
                            Department :
                        </td>
                        <td class="cls_dept_prog" style="display:none;">
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                    <%--<tr>
                        <td class="cls_dept_prog">
                            Department :
                        </td>
                        <td class="cls_dept_prog">
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            Programme :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>--%>
                </table>
            </div>
        </div>

        <div id="div_tab" class="tabbable" style="display:block;width: 100%; margin-bottom: 20px;">
            <div id="div_myTab">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a data-toggle="tab" href="#offeredcourse">Offered Courses&nbsp;</a></li>
                    <li><a data-toggle="tab" href="#approvedcourses">Approved Courses&nbsp;</a></li>
                    <li class ="initial_pending" style="display:none;"><a data-toggle="tab" href="#pendinginitial">Pending Initial&nbsp;</a></li>
                    <li class="cls_tabs" style="display:none;"><a data-toggle="tab" href="#sendedforreview">Sent for Review&nbsp;</a></li>
                    <li class="cls_tabs_rej" style="display:none;"><a data-toggle="tab" href="#rejectedcourses">Rejected Courses&nbsp;</a></li>
                </ul>
            </div>
            <div class="tab-content">
                <div id="offeredcourse" class="tab-pane in active">
                    <div id="DataList_offeredcourses" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_offeredcourses" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="approvedcourses" class="tab-pane">
                    <div id="DataList_approvedcourses" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_approvedcourses" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>

                    <div id="div_save_course_code" align="center">
                        
                    </div>
                </div>

                <div id="pendinginitial" class="tab-pane">
                    <div id="DataList_pendinginitial" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_pendinginitial" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div id="sendedforreview" class="tab-pane">
                    <div id="DataList_sendedforreview" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_sendedforreview" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div id="rejectedcourses" class="tab-pane">
                    <div id="DataList_rejectedcourses" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_rejectedcourses" class="display table table-striped table-bordered table-hover" width="100%">
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
    
    <div style="display:none;">
        <input id="btn_show_modal_sendforreview" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal_sendforreview" value="Add Exam" style="height: 40px;margin-top: -10px;display:none;"/>
        <input id="btn_show_modal_reject" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal_reject" value="Add Exam" style="height: 40px;margin-top: -10px;display:none;"/>
        <input id="btn_show_modal_view" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal_view" value="Add Exam" style="height: 40px;margin-top: -10px;display:none;"/>
        <input id="btn_show_modal_view_poster" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal_view_poster" style="height: 40px;margin-top: -10px;display:none;"/>
        <select id="drp_instructor_list"></select>
    </div>
    
    <div class="modal fade" id="mynewModal_sendforreview" style="display:none;top:5%;width:575px;left:48%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H1">Send for Review </h4>
                    <span style="color:red;">(Not allowed Special characters -',$,#,*,&,(,),! etc.)</span>
                </div>

                <div class="modal-body">
                    <table style="width:100%;">            
                        <tr>
                            <td><b>Course Title</b></td>
                            <td><b>&nbsp;:&nbsp;</b></td>
                            <td id='td_send_course_name'></td>
                        </tr>
                        <tr>
                            <td><b>Subject</b></td>
                            <td><b>&nbsp;:&nbsp;</b></td>
                            <td><input type="text" id="txt_send_mail_subject" disabled /></td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top;"><b>Mail Body</b></td>
                            <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                            <td><textarea id="txt_send_mail_body" rows="6"></textarea></td>
                        </tr>
                    </table>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close_sendforreview" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button id="btn_modal_save_sendforreview" type="button" class="btn btn-primary" onclick="sendMail_sendforreview()">Send</button>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="mynewModal_reject" style="display:none;top:5%;width:575px;left:48%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H2">Reject</h4>
                    <span style="color:red;">(Not allowed Special characters -',$,#,*,&,(,),! etc.)</span>
                </div>

                <div class="modal-body">
                    <table style="width:100%;">
                        <tr>
                            <td><b>Course Title</b></td>
                            <td><b>&nbsp;:&nbsp;</b></td>
                            <td id='td_reject_course_name'></td>
                        </tr>
                        <tr>
                            <td><b>Subject</b></td>
                            <td><b>&nbsp;:&nbsp;</b></td>
                            <td><input type="text" id="txt_reject_mail_subject" disabled /></td>
                        </tr>
                        <tr>
                            <td style="vertical-align: top;"><b>Mail Body</b></td>
                            <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                            <td><textarea id="txt_reject_mail_body" rows="6"></textarea></td>
                        </tr>
                    </table>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close_reject" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button id="btn_modal_save_reject" type="button" class="btn btn-primary" onclick="sendMail_reject()">Send</button>
                </div>

            </div>
        </div>
    </div>

    <div class="modal fade" id="mynewModal_view" style="display:none;top:5%;width:900px;left:37%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H3">Course Detail</h4>
                    <div style="text-align: right;margin-top: -20px;"><input type="button" id="btn_print_modal_view" value="Print" onclick="return btn_print_modal_view_click();" /></div>
                </div>

                <div class="modal-body">
                    
                    <div class="panel panel-default ">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Course Proposal</span></strong>
                        </div>
                        <div style="padding: 10px;overflow:visible;" id="div_progcoord_panel" class="panel-collapse collapse in">

                            <table style="width:100%;display:none;">
                                
                                <tr>
                                    <td><b>Course Title</b></td>
                                    <td><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_course_name'></td>
                                </tr>
                                <tr>
                                    <td><b>Methodology</b></td>
                                    <td><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_methodology'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Inhabitation</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_inhabitation'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Category Location Wise</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_category_location_wise'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Location</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_location'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Intake Capacity</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_intake_capacity'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Course Credits</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_credits'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Description</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_description'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Course Image</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_course_image'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Image Source</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_image_source'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Prequisite</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_prequisite'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Is It Open For Professional</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_is_it_open_for_professional'></td>
                                </tr>
                                <tr id='tr_view_professional_prerequisite'>
                                    <td style="vertical-align: top;"><b>Professional Prerequisite</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_professional_prerequisite'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Start Date</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_start_date'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>End Date</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_end_date'></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top;"><b>Course Outputs</b></td>
                                    <td style="vertical-align: top;"><b>&nbsp;:&nbsp;</b></td>
                                    <td id='td_view_course_outputs'></td>
                                </tr>
                            </table>

                             <div class="row" style="margin-top:15px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Course Code</b>
                                </div>
                                <div class="form-group col-md-9">
                                    <span id="spn_course_code"></span>
                                </div>

                             </div>
                            <div class="row" style="margin-top:15px;">
                                
                                <div class="form-group col-md-2 color-blue">
                                    <b>Course Title</b>
                                </div>
                                <div class="form-group col-md-9">
                                    <span id="spn_course_title"></span>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 10px;margin-bottom: 15px;">
                                <div class="form-group col-md-6" style="padding-left: 0px;">
                                    <div class="form-group col-md-4 color-blue" style="display:none;">
                                        <b>Methodology</b>
                                    </div>
                                    <div class="form-group col-md-6" style="display:none;">
                                        <span id="spn_methodology"></span>
                                    </div>
                                    <div class="form-group col-md-4 color-blue" style="margin-top:15px;">
                                        <b>Inhabitation</b>
                                    </div>
                                    <div class="form-group col-md-6" style="margin-top:15px;">
                                        <span id="spn_inhabitation"></span>
                                    </div>
                                    <div class="form-group col-md-4 color-blue" style="margin-top:15px;">
                                        <b>Category Location Wise</b>
                                    </div>
                                    <div class="form-group col-md-6" style="margin-top:15px;">
                                        <span id="spn_category_location_wise"></span>
                                    </div>
                                    <%--<div class="form-group col-md-4 color-blue" style="margin-top:3px;"></div>
                                    <div class="form-group col-md-2 color-blue" style="margin-top:3px;">
                                        Min : <span id="spn_min"></span>
                                    </div>
                                    <div class="form-group col-md-2" style="margin-top:3px;">
                                        Max : <span id="spn_max"></span>
                                    </div>--%>
                                    <div class="form-group col-md-4 color-blue" style="margin-top:15px;">
                                        <b>Location</b>
                                    </div>
                                    <div class="form-group col-md-6" style="margin-top:15px;">
                                        <span id="spn_location"></span>
                                    </div>
                                </div>
                                <div class="form-group col-md-4 color-blue" style="padding-left:45px;">
                                    <div class="row-fluid" id="dataList_instructor" style="float: left;width: 90%; display: block;">
                                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor">
                                            <thead>
                                                <tr>
                                                    <th style="width: 65%;">Instructor</th>
                                                    <th>Contact hrs</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="row" style="margin-top:15px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Intake Capacity</b>
                                </div>
                                <div class="form-group col-md-4">
                                    <span id="spn_available_seats"></span>
                                </div>
                                <div class="form-group col-md-1 color-blue">
                                    <b>Credits</b>
                                </div>
                                <div class="form-group col-md-3">
                                    <span id="spn_credits"></span>
                                </div>
                            </div>

                            <div class="row" style="margin-top:15px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>GPA Status</b>
                                </div>
                                <div class="form-group col-md-4">
                                    <span id="spn_gpa_status"></span>
                                </div>
                            </div>
                    
                            <div class="row" style="margin-top:15px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Course Description</b>
                                </div>
                                <b style="position: absolute;">:</b>
                                <div class="form-group col-md-9">
                                    <span id="spn_course_description"></span>
                                </div>
                            </div>
                
                            <div class="row" style="margin-top:10px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Course Image</b>
                                </div>
                                <div class="form-group col-md-4">
                                    <span id="spn_courseimage_file_name" style="vertical-align: super;"></span>
                                </div>
                                <div class="form-group col-md-1 color-blue">
                                    <b>Image Source</b>
                                </div>
                                <div class="form-group col-md-3">
                                    <span id="spn_image_source"></span>
                                </div>
                            </div>
                
                            <div class="row" style="margin-top:10px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Prerequisite For Students</b>
                                </div>
                                <div class="form-group col-md-9">
                                    <span id="spn_course_prerequisite"></span>
                                </div>
                            </div>

                            <div class="row" style="margin-bottom: 15px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Is it open for Professionals</b>
                                </div>
                                <div class="form-group col-md-4">
                                    <span id="spn_is_for_professional"></span>
                                </div>
                            </div>

                            <div class="row" id="div_professional_prerequisite" style="display:none;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Professionals Prerequisite</b>
                                </div>
                                <div class="form-group col-md-4">
                                    <span id="spn_professional_prerequisite"></span>
                                </div>
                            </div>

                            <div class="row" style="margin-top: 10px;">
                                <div class="form-group col-md-2 color-blue">
                                    <b>Start Date</b>
                                </div>
                                <div class="form-group col-md-4">
                                    <span id="spn_start_date"></span>
                                </div>
                                <div class="form-group col-md-1 color-blue">
                                    <b>End Date</b>
                                </div>
                                <div class="form-group col-md-3">
                                    <span id="spn_end_date"></span>
                                </div>
                            </div>
                            
                            <%--<div class="row" style="margin-top: 10px;margin-bottom: 15px;">
                                <div class="form-group col-md-2 color-blue" style="margin-top: 10px;">
                                    <b>Course Outputs</b>
                                </div>
                                <div class="form-group col-md-4" style="margin-top: 10px;">
                                    <b class="cls_colon" style="float: left;">:</b>
                                    <ul id="ul_course_output" style="list-style-type:square;float:left;margin-left: 15px;">
                                    </ul>
                                </div>
                            </div>--%>

                            <div class="panel panel-default" style="margin-top: 10px;margin-bottom: 15px;">
                                <div class="panel-heading">
                                    <b>Course Outputs</b>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <table class="form-group col-md-11" style="margin-left: 15px;">
                                            <tr>
                                                <td><input type="checkbox" id="Installations" name="chk_course_output" disabled /> Installations</td>
                                                <td><input type="checkbox" id="Models" name="chk_course_output" disabled /> Models</td>
                                                <td><input type="checkbox" id="Presentation" name="chk_course_output" disabled /> Presentation</td>
                                                <td><input type="checkbox" id="Products" name="chk_course_output" disabled /> Products</td>
                                            </tr>
                                            <tr>
                                                <td><input type="checkbox" id="Reports" name="chk_course_output" disabled /> Reports (Soft Copy as well)</td>
                                                <td><input type="checkbox" id="Posters" name="chk_course_output" disabled /> Posters (Soft Copy as well)</td>
                                                <td><input type="checkbox" id="Booklet" name="chk_course_output" disabled /> Booklet (Soft Copy as well)</td>
                                                <td><input type="checkbox" id="Photos" name="chk_course_output" disabled /> Photos (Soft Copy as well)</td>
                                            </tr>
                                            <tr id="tr_other_course_output" style="display:none;">
                                                
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="panel panel-default" style="margin-top: 10px;">
                                <div class="panel-heading">
                                    <b>Instructor Details</b>
                                </div>
                                <div class="panel-body">
                                    <div class="panel panel-default" id="div_desc_faculty1" style="margin-top:15px;display:none;">
                                        <div class="panel-heading">
                                            <b id="phead_desc_faculty1">Faculty1</b>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="form-group col-md-2 color-blue">
                                                    <%--Description of <span id="lbl_desc_faculty1"> <br/> (Max. 100 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                                    Description of <span id="lbl_desc_faculty1"> <br/> </span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                                                </div>
                                                <div class="form-group col-md-9">
                                                    <%--<textarea id="txt_desc_faculty1" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty1','spn_desc_faculty1_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty1');"></textarea>--%>
                                                    <textarea id="txt_desc_faculty1" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty1','spn_desc_faculty1_words');" onkeypress="return charcount(event,'txt_desc_faculty1','Instructor');"></textarea>
                                                    <%--<span id="spn_desc_faculty1_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                                    <span id="spn_desc_faculty1_words" style="float:right;margin-bottom:10px;">Total Character : 0</span>
                                                </div>
                                            </div>

                                            <%--<div class="row">
                                                <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                                                    <%--<div class="row" id="div_based_in_ahmedabad1" style="display:none;">--%>
                                                    <div class="row div_based_in_ahmedabad" style="display:block;margin-top:10px;">
                                                        <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                                                        <div class="form-group col-md-5"><select id="drp_based_in_ahmedabad1" onchange="based_in_ahmedabad_change(2,1)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation1" style="margin-top:10px;display:none;">
                                                        <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                                                        <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                                                        <div class="form-group col-md-3"><select id="drp_is_travel_based_course1" onchange="travel_based_course_change(1)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                    
                                                        <div id="div_is_travel_based_course1" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Source Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_from1" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_from1"></span>
                                                            </div>
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Dest. Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_to1" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_to1"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation1" style="margin-top:10px;display:none;">
                                                        <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                                                        <div class="form-group col-md-3"><select id="drp_accommodation_needed1" onchange="accomodation_needed_change(1)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>

                                                        <div id="div_is_accomodation_needed1" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">From Date</div>
                                                                <%--<input type="text" id="txt_accomodation_from_date1" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(1)" />--%>
                                                                <span id="txt_accomodation_from_date1"></span>
                                                            </div>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">To Date</div>
                                                                <%--<input type="text" id="txt_accomodation_to_date1" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(1)" />--%>
                                                                <span id="txt_accomodation_to_date1"></span>
                                                            </div>
                                                            <%--<div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;"></div>--%>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">Total Days</div>
                                                                <%--<input type="text" id="txt_accomodation_total_days1" class="marg-btm col-md-7" disabled />--%>
                                                                <span id="txt_accomodation_total_days1"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                        
                                                <%--</div>
                                            </div>--%>
                                        </div>
                                    </div>
                
                                    <div class="panel panel-default" id="div_desc_faculty2" style="margin-top:15px;display:none;">
                                        <div class="panel-heading">
                                            <b id="phead_desc_faculty2">Faculty2</b>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="form-group col-md-2 color-blue">
                                                    <%--Description of <span id="lbl_desc_faculty2"> <br/> (Max. 75 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                                    Description of <span id="lbl_desc_faculty2"> <br/> </span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                                                </div>
                                                <div class="form-group col-md-9">
                                                    <%--<textarea id="txt_desc_faculty2" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty2','spn_desc_faculty2_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty2');"></textarea>--%>
                                                    <textarea id="txt_desc_faculty2" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="400" onkeyup="return keyup_charcount(event,'txt_desc_faculty2','spn_desc_faculty2_words');" onkeypress="return charcount(event,'txt_desc_faculty2','Instructor');"></textarea>
                                                    <%--<span id="spn_desc_faculty2_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                                    <span id="spn_desc_faculty2_words" style="float:right;margin-bottom:10px;">Total Character : 0</span>

                                                </div>
                                            </div>
                        
                                            <%--<div class="row">
                                                <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                                                    <%--<div class="row" id="div_based_in_ahmedabad2" style="display:none;">--%>
                                                    <div class="row div_based_in_ahmedabad" style="display:block;margin-top:10px;">
                                                        <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                                                        <div class="form-group col-md-5"><select id="drp_based_in_ahmedabad2" onchange="based_in_ahmedabad_change(2,2)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation2" style="margin-top:10px;display:none;">
                                                        <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                                                        <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                                                        <div class="form-group col-md-3"><select id="drp_is_travel_based_course2" onchange="travel_based_course_change(2)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                    
                                                        <div id="div_is_travel_based_course2" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Source Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_from2" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_from2"></span>
                                                            </div>
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Dest. Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_to2" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_to2"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation2" style="margin-top:10px;display:none;">
                                                        <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                                                        <div class="form-group col-md-3"><select id="drp_accommodation_needed2" onchange="accomodation_needed_change(2)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>

                                                        <div id="div_is_accomodation_needed2" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">From Date</div>
                                                                <%--<input type="text" id="txt_accomodation_from_date2" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(2)" />--%>
                                                                <span id="txt_accomodation_from_date2"></span>
                                                            </div>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">To Date</div>
                                                                <%--<input type="text" id="txt_accomodation_to_date2" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(2)" />--%>
                                                                <span id="txt_accomodation_to_date2"></span>
                                                            </div>
                                                            <%--<div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;"></div>--%>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">Total Days</div>
                                                                <%--<input type="text" id="txt_accomodation_total_days2" class="marg-btm col-md-7" disabled />--%>
                                                                <span id="txt_accomodation_total_days2"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                        
                                                <%--</div>
                                            </div>--%>
                                        </div>
                                    </div>
                
                                    <div class="panel panel-default" id="div_desc_faculty3" style="margin-top:15px;display:none;">
                                        <div class="panel-heading">
                                            <b id="phead_desc_faculty3">Faculty3</b>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="form-group col-md-2 color-blue">
                                                    <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                                    Description of <span id="lbl_desc_faculty3"> <br/> </span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                                                </div>
                                                <div class="form-group col-md-9">
                                                    <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                                    <textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="250" onkeyup="return keyup_charcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return charcount(event,'txt_desc_faculty3','Instructor');"></textarea>
                                                    <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                                    <span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Character : 0</span>
                                                </div>
                                            </div>
                        
                                            <%--<div class="row">
                                                <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                                                    <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                                                    <div class="row div_based_in_ahmedabad" style="display:block;margin-top:10px;">
                                                        <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                                                        <div class="form-group col-md-5"><select id="drp_based_in_ahmedabad3" onchange="based_in_ahmedabad_change(2,3)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation3" style="margin-top:10px;display:none;">
                                                        <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                                                        <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                                                        <div class="form-group col-md-3"><select id="drp_is_travel_based_course3" onchange="travel_based_course_change(3)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                    
                                                        <div id="div_is_travel_based_course3" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Source Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_from3" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_from3"></span>
                                                            </div>
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Dest. Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_to3" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_to3"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation3" style="margin-top:10px;display:none;">
                                                        <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                                                        <div class="form-group col-md-3"><select id="drp_accommodation_needed3" onchange="accomodation_needed_change(3)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>

                                                        <div id="div_is_accomodation_needed3" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">From Date</div>
                                                                <%--<input type="text" id="txt_accomodation_from_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />--%>
                                                                <span id="txt_accomodation_from_date3"></span>
                                                            </div>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">To Date</div>
                                                                <%--<input type="text" id="txt_accomodation_to_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />--%>
                                                                <span id="txt_accomodation_to_date3"></span>
                                                            </div>
                                                            <%--<div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;"></div>--%>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">Total Days</div>
                                                                <%--<input type="text" id="txt_accomodation_total_days3" class="marg-btm col-md-7" disabled />--%>
                                                                <span id="txt_accomodation_total_days3"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                        
                                                <%--</div>
                                            </div>--%>
                                        </div>
                                    </div>
                                
                                
                                
                                <%--//kapil--%>
                                
                                <div class="panel panel-default" id="div_desc_faculty4" style="margin-top:15px;display:none;">
                                        <div class="panel-heading">
                                            <b id="phead_desc_faculty4">Faculty4</b>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="form-group col-md-2 color-blue">
                                                    <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                                    Description of <span id="lbl_desc_faculty4"> <br/> </span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                                                </div>
                                                <div class="form-group col-md-9">
                                                    <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                                    <textarea id="txt_desc_faculty4" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty4','spn_desc_faculty4_words');" onkeypress="return charcount(event,'txt_desc_faculty4','Instructor');"></textarea>
                                                    <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                                    <span id="spn_desc_faculty4_words" style="float:right;margin-bottom:10px;">Total Character : 0</span>
                                                </div>
                                            </div>
                        
                                            <%--<div class="row">
                                                <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                                                    <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                                                    <div class="row div_based_in_ahmedabad" style="display:block;margin-top:10px;">
                                                        <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                                                        <div class="form-group col-md-5"><select id="drp_based_in_ahmedabad4" onchange="based_in_ahmedabad_change(2,4)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation4" style="margin-top:10px;display:none;">
                                                        <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                                                        <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                                                        <div class="form-group col-md-3"><select id="drp_is_travel_based_course4" onchange="travel_based_course_change(4)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                    
                                                        <div id="div_is_travel_based_course4" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Source Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_from3" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_from4"></span>
                                                            </div>
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Dest. Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_to3" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_to4"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation4" style="margin-top:10px;display:none;">
                                                        <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                                                        <div class="form-group col-md-3"><select id="drp_accommodation_needed4" onchange="accomodation_needed_change(4)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>

                                                        <div id="div_is_accomodation_needed4" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">From Date</div>
                                                                <%--<input type="text" id="txt_accomodation_from_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />--%>
                                                                <span id="txt_accomodation_from_date4"></span>
                                                            </div>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">To Date</div>
                                                                <%--<input type="text" id="txt_accomodation_to_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />--%>
                                                                <span id="txt_accomodation_to_date4"></span>
                                                            </div>
                                                            <%--<div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;"></div>--%>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">Total Days</div>
                                                                <%--<input type="text" id="txt_accomodation_total_days3" class="marg-btm col-md-7" disabled />--%>
                                                                <span id="txt_accomodation_total_days4"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                        
                                                <%--</div>
                                            </div>--%>
                                        </div>
                                    </div>
                                
                                
                                
                                
                                <div class="panel panel-default" id="div_desc_faculty5" style="margin-top:15px;display:none;">
                                        <div class="panel-heading">
                                            <b id="phead_desc_faculty5">Faculty5</b>
                                        </div>
                                        <div class="panel-body">
                                            <div class="row">
                                                <div class="form-group col-md-2 color-blue">
                                                    <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                                    Description of <span id="lbl_desc_faculty5"> <br/> </span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                                                </div>
                                                <div class="form-group col-md-9">
                                                    <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                                    <textarea id="txt_desc_faculty5" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty5','spn_desc_faculty5_words');" onkeypress="return charcount(event,'txt_desc_faculty5','Instructor');"></textarea>
                                                    <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                                    <span id="spn_desc_faculty5_words" style="float:right;margin-bottom:10px;">Total Character : 0</span>
                                                </div>
                                            </div>
                        
                                            <%--<div class="row">
                                                <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                                                    <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                                                    <div class="row div_based_in_ahmedabad" style="display:block;margin-top:10px;">
                                                        <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                                                        <div class="form-group col-md-5"><select id="drp_based_in_ahmedabad5" onchange="based_in_ahmedabad_change(2,5)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation5" style="margin-top:10px;display:none;">
                                                        <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                                                        <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                                                        <div class="form-group col-md-3"><select id="drp_is_travel_based_course5" onchange="travel_based_course_change(5)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>
                                    
                                                        <div id="div_is_travel_based_course5" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Source Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_from3" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_from5"></span>
                                                            </div>
                                                            <div class="form-group col-md-12 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-3 color-blue">Dest. Location</div>
                                                                <%--<input type="text" id="txt_is_travel_based_course_to3" class="marg-btm col-md-7" style="" />--%>
                                                                <span id="txt_is_travel_based_course_to5"></span>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row cls_travel_accomodation5" style="margin-top:10px;display:none;">
                                                        <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                                                        <div class="form-group col-md-3"><select id="drp_accommodation_needed5" onchange="accomodation_needed_change(5)"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>

                                                        <div id="div_is_accomodation_needed5" class="form-group col-md-9 color-blue" style="padding-right:0px;display:none;">
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">From Date</div>
                                                                <%--<input type="text" id="txt_accomodation_from_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />--%>
                                                                <span id="txt_accomodation_from_date5"></span>
                                                            </div>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">To Date</div>
                                                                <%--<input type="text" id="txt_accomodation_to_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />--%>
                                                                <span id="txt_accomodation_to_date5"></span>
                                                            </div>
                                                            <%--<div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;"></div>--%>
                                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                                <div class="form-group col-md-4 color-blue">Total Days</div>
                                                                <%--<input type="text" id="txt_accomodation_total_days3" class="marg-btm col-md-7" disabled />--%>
                                                                <span id="txt_accomodation_total_days5"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                        
                                                <%--</div>
                                            </div>--%>
                                        </div>
                                    </div>


                                
                                
                                </div>
                            </div>

                            <div class="panel panel-default ">
                                <div class="panel-heading">
                                    <b>Expenses to be taken care by CEPT for the Course</b>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="form-group col-md-3 color-blue"><b>Materials for Work Shop</b></div>
                                        <div class="form-group col-md-2"><span id="spn_material_for_workshop"></span></div>
                        
                                        <div class="form-group col-md-3 color-blue"><b>Hall, Equipment, Other Outside Services Rent</b></div>
                                        <div class="form-group col-md-2"><span id="spn_outside_service_rent"></span></div>
                                    </div>
                        
                                    <div class="row" style="margin-top: 15px;display:none;">
                                        <div class="form-group col-md-3 color-blue"><b>Travel arrangements needed to be done</b></div>
                                        <%--<div class="form-group col-md-3"><select id="drp_travel_arrangement_needed" onchange="travel_arrangement_change()"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>--%>
                                        <div class="form-group col-md-2"><span id="spn_travel_arrangement_needed"></span></div>

                                        <div id="div_travel_arrangement_needed" class="form-group col-md-6 color-blue" style="padding-left:0px;padding-right:0px;display:none;">
                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                <div class="form-group col-md-3 color-blue"><b>From</b></div>
                                                <span id="spn_travel_arrangement_needed_from"></span>
                                            </div>
                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                <div class="form-group col-md-2 col-md-pull-1 color-blue"><b>To</b></div>
                                                <span id="spn_travel_arrangement_needed_to"></span>
                                            </div>
                                        </div>
                                    </div>
                        
                                    <div class="row" style="margin-top: 15px;display:none;">
                                        <div class="form-group col-md-3 color-blue"><b>Travel based Course</b></div>
                                        <%--<div class="form-group col-md-3"><select id="drp_is_travel_based_course" onchange="travel_based_course_change()"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>--%>
                                        <div class="form-group col-md-2"><span id="spn_is_travel_based_course"></span></div>
                        
                                        <div id="div_is_travel_based_course" class="form-group col-md-6 color-blue" style="padding-left:0px;padding-right:0px;display:none;">
                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                <div class="form-group col-md-3 color-blue"><b>From</b></div>
                                                <span id="spn_is_travel_based_course_from"></span>
                                            </div>
                                            <div class="form-group col-md-6 color-blue" style="padding-left: 0px;padding-right: 0px;">
                                                <div class="form-group col-md-2 col-md-pull-1 color-blue"><b>To</b></div>
                                                <span id="spn_is_travel_based_course_to"></span>
                                            </div>
                                        </div>
                                    </div>
                        
                                    <div class="row" style="margin-top: 15px;display:none;">
                                        <div class="form-group col-md-3 color-blue"><b>Accommodation Needed</b></div>
                                        <%--<div class="form-group col-md-3"><select id="drp_accommodation_needed"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>--%>
                                        <div class="form-group col-md-2"><span id="spn_accommodation_needed"></span></div>
                        
                                        <div class="form-group col-md-3 color-blue"><b>Hotel Accommodation Needed for Travel based Course</b></div>
                                        <%--<div class="form-group col-md-3"><select id="drp_hotel_accommodation"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>--%>
                                        <div class="form-group col-md-2"><span id="spn_hotel_accommodation"></span></div>
                                    </div>

                                    <div class="row" style="margin-top: 15px;">
                                        <div class="form-group col-md-3 color-blue"><b>Printing & Stationary (INR)</b></div>
                                        <div class="form-group col-md-2"><span id="spn_printing_stationary"></span></div>
                        
                                        <div class="form-group col-md-3 color-blue"><b></b></div>
                                        <div class="form-group col-md-2"><span></span></div>
                                    </div>

                                    <div class="row" style="margin-top: 15px;">
                                        <div class="form-group col-md-3 color-blue"><b>Contract to be done with any institute</b></div>
                                        <%--<div class="form-group col-md-3"><select id="drp_contract_to_be_done" onchange="contract_to_be_done_change()"><option value="">-- Select --</option><option value="Y">Yes</option><option value="N">No</option></select></div>--%>
                                        <div class="form-group col-md-2"><span id="drp_contract_to_be_done"></span></div>
                        
                                        <div class="form-group col-md-3 color-blue"><b>Any other major expense</b></div>
                                        <div class="form-group col-md-2"><span id="spn_other_major_expense"></span></div>
                                    </div>

                                    <div id="div_contract_to_be_done" class="row" style="margin-top: 10px;display:none;">
                                        <div class="form-group col-md-3 color-blue"></div>
                                        <div class="form-group col-md-2"><span id="spn_contract_to_be_done"></span></div>
                                    </div>
                                </div>
                            </div>

                            <div class="panel panel-default ">
                                <div class="panel-heading">
                                    <b>Expense related to course for students</b>
                                </div>
                                <div class="panel-body" style="padding-bottom: 0px;">
                                    <div class="row">
                                        <div class="form-group col-md-2 color-blue"><b>Material Cost</b></div>
                                        <div class="form-group col-md-1"><span id="spn_material_cost"></span></div>
                                        <div class="form-group col-md-2 color-blue"><b>Food Stay</b></div>
                                        <div class="form-group col-md-1"><span id="spn_food_stay"></span></div>
                                        <div class="form-group col-md-2 color-blue"><b>Local Travel</b></div>
                                        <div class="form-group col-md-1"><span id="spn_local_travel"></span></div>
                                    </div>
                                    <div class="row" style="margin-top:15px;">
                                        <div class="form-group col-md-2 color-blue" style="height: 40px;"><b>Total approx. expense</b></div>
                                        <div class="form-group col-md-1"><span id="spn_total_approx_expense"></span></div>
                                        <div class="form-group col-md-2 color-blue" style="display:none;"><b>Travel Expense</b></div>
                                        <div class="form-group col-md-1" style="display:none;"><span id="spn_travel_expense"></span></div>
                                        <div class="form-group col-md-2 color-blue" style="display:none;"><b>Total Expense</b></div>
                                        <div class="form-group col-md-1" style="display:none;"><b><span id="spn_total_expense"></span></b></div>
                                    </div>
                                </div>
                            </div>
                
                        </div>
                    </div>
                    
                    <div class="panel panel-default ">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Workplan</span></strong>
                        </div>
                        <div style="padding: 10px;overflow:visible;" id="div_workplan" class="panel-collapse collapse in">
                            <table id="tbl_workplan" class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Day no.</th>
                                        <th>Date</th>
                                        <th>Time</th>
                                        <th style="display:none;">Topic Covered</th>
                                        <th>Topic Covered</th>
                                        <th>Number of Hours</th>
                                        <th>Faculty Involve</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>

                            <div>
                                <table id="tbl_workplan_faculty_total">
                                    <thead>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                Total of Contact Hrs
                                            </td>
                                            <td>
                                                &nbsp;:&nbsp;
                                            </td>
                                            <td id="td_total_contact_hrs">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Duration in Days
                                            </td>
                                            <td>
                                                &nbsp;:&nbsp;
                                            </td>
                                            <td id="td_duration_in_days">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>


                      <div class="panel panel-default ">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Learning Outcomes</span></strong>
                        </div>
                        <div style="padding: 10px;overflow:visible;" id="div_learning_out" class="panel-collapse collapse in">
                        </div>
                    </div>

                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close_view" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    
    <div class="modal fade" id="mynewModal_view_poster" style="display:none;top:5%;width:935px;left:36%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H4">Poster</h4>
                </div>

                <div class="modal-body">
                    <div style="width: 885px;height: 625px;background: white;margin-top: 20px;text-align: initial;">
	                    <div style="width: 20.3%;height: 100%;background: #58595B;float: left;">
                            <div style="width: 100%;height: 13.6%;">
    	
		                    </div>
	
                            <table id="tbl_poster_dtl" style="width: 96%;">
                                <tr><td class="cls_td_title">COURSE NUMBER</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_code"></td></tr>

                                <tr><td class="cls_td_title">CREDITS</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_credits"></td></tr>
                                
                                <tr><td class="cls_td_title">FEES</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_fees"></td></tr>
                                
                                <tr><td class="cls_td_title">DATES</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_dates"></td></tr>
                                
                                <tr><td class="cls_td_title">DURATION</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_duration"></td></tr>
                                
                                <tr><td class="cls_td_title">NO. OF STUDENTS</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_no_of_students"></td></tr>
                                
                                <tr><td class="cls_td_title">OPEN FOR PROFESSIONALS</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_open_for_professional"></td></tr>
                                
                                <tr><td class="cls_td_title">PREREQUISITES FOR PROFESSIONALS</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_prerequisite_professional"></td></tr>
                                
                                <tr><td class="cls_td_title">FEES FOR PROFESSIONALS</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_professional_fees"></td></tr>
                                
                                <tr><td class="cls_td_title">PREREQUISITES FOR STUDENTS</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_prerequisite_student"></td></tr>
                                
                                <tr><td class="cls_td_title">LOCATION</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_location"></td></tr>
                                
                                <tr><td class="cls_td_title">EXPENSE</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_expense"></td></tr>
                                
                                <tr><td class="cls_td_title">STUDENTS DELIVERABLES</td></tr>
                                <tr><td class="cls_td_course_dtl" id="td_course_students_deliverables"></td></tr>
                                
                                <%--<tr><td class="cls_td_title">FACULTY OF </td></tr>--%>
                                <tr><td class="cls_td_title" id="td_course_faculty"></td></tr>
                            </table>
	                    </div>

	                    <div style="width: 79.7%;height: 100%;float: left;">
		                    <div style="width: 100%;height: 13.6%;background: #E6C63F;">
    	                        <div id="div_course_title" style="padding: 15px;">
    	                        
		                        </div>
		                    </div>
	
		                    <div style="width: 94%;height: 71.7%;padding: 2.8% 3% 0 3%;">
			                    <div style="width: 100%;height: 58%;">
				                    <div style="width: 57%;height: 96%;float: left;">
                                        <input type="image" id="img_course_image" src="" style="max-height: 100%;" />
				                    </div>

			    	                <div style="width: 40%;height: 100%;float: left;padding-left: 3%;">								
                                        <div style="width: 100%;height: 40%;">
                                            <input type="image" id="img_instructor_image1" src="../../WSCourseImageUpload/instructor1.png" style="width:32%;height: 100%;display:inline-block;" />
                                            <input type="image" id="img_instructor_image2" src="../../WSCourseImageUpload/instructor2.png" style="width:32%;height: 100%;display:inline-block;" />
                                            <input type="image" id="img_instructor_image3" src="../../WSCourseImageUpload/instructor3.png" style="width:32%;height: 100%;display:inline-block;" />
					                    </div>

					                    <div style="width: 100%;height: 60%;overflow: hidden;">
                                            <div id="div_instructor_dtl" style="font-size:10px;color:#B49A5E;line-height:12px;">
                                                
                                            </div>
					                    </div>
				                    </div>
			                    </div>

			                    <div style="width: 100%;height: 42%;overflow:hidden;">
                                    <div id="div_course_desc" style="font-size:10px;color:Black;line-height:12px;">
                                        
                                    </div>
			                    </div>
		                    </div>
	
		                    <div style="width: 100%;height: 11.6%;background: #E6C63F;">
    	
		                    </div>      
	                    </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close_view_poster" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <%--<button id="btn_modal_save_view_poster" type="button" class="btn btn-primary" onclick="sendMail_view()">Send</button>--%>
                </div>
                 <a href="#" id="Link" style="display:none;" download="outline.pdf">Download</a>
            </div>
        </div>
    </div>
</asp:Content>

