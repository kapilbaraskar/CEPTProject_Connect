<%@ Page Title="My Calendar" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="MyCalendar.aspx.cs" Inherits="Admin_Master_MyCalander" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../fullcalander/fullcalendar_new.css" rel="stylesheet" type="text/css" />
    <link href="../../fullcalander/agendalist_new.css" rel="stylesheet" type="text/css" />
    <link href="../../fullcalander/fullcalendar_new.print.css" rel="stylesheet" type="text/css" />
    <%--  <script src='../../fullcalander/moment.min.js'></script>--%>
    <script src="../../fullcalander/fullcalendar_new.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <link href="../../DesignCss/ui.easytree.css" rel="stylesheet" type="text/css" />
    <%-- <script src="../../fullcalander/gcal.js" type="text/javascript"></script>--%>
    <%--   <link href="../../DesignCss/fullcalendar.css" rel="stylesheet" type="text/css" />
    <script src='<%= Page.ResolveClientUrl("~/DesignJS/fullcalendar.min.js") %>' type="text/javascript"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<div class="expandContent">
        <a href="#">Click Here to Display More Content</a>
 </div>
<div class="showMe" style="display:none">
        This content was hidden, but now shows up
</div>--%>
    <div class="modal hide fade" id="popupfornewevent" style="left: 56%; width: 33%;">
        <div class="modal-header" style="border-bottom: 0">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h4>
                <span id="calpolineitemdesc"></span>
                <input type="hidden" id="hdn_start_date" /><input type="hidden" id="hdn_start_time" />
                <input type="hidden" id="hdn_end_date" /><input type="hidden" id="hdn_end_time" />
                <input type="hidden" id="hdn_user_id" />
                <input type="hidden" id="hdneventdocnumber" />
                <input type="hidden" id="hdn_view" value="month" />
                <input type="hidden" id="hdn_view_month" />
            </h4>
        </div>
        <div class="modal-body">
            When : <b><span id="spn_new_event_data"></span></b>
            <br />
            <br />
            What :
            <%-- <textarea id="txt_new_event" cols="20" rows="2" style="width: 75%;"></textarea>--%>
            <select id="drp_event">
            </select>
            &nbsp; <span>
                <input type="checkbox" id="chk_repeat" name="Repeat" />
                <b>Repeat</b> </span>
            <br />
            <input type="text" id="txt_new_event" style="width: 55%; margin-left: 41px; display: none;" />
            <br />
            <div id="div_repeat" style="display: none">
                Start Date :
                <input type="text" id="txt_start_date" placeholder="dd/mm/yyyy" style="width: 20%;" />
                &nbsp; End Date :
                <input type="text" id="txt_end_date" style="width: 20%;" />
                <br />
                Repeat on : <span style="margin-left: 4px;">
                    <input type="checkbox" id="chk_mon" />
                    <b style="vertical-align: bottom;">M</b> </span><span style="margin-left: 4px;">
                        <input type="checkbox" id="chk_tue" />
                        <b style="vertical-align: bottom;">T</b> </span><span style="margin-left: 4px;">
                            <input type="checkbox" id="chk_wed" />
                            <b style="vertical-align: bottom;">W</b> </span><span style="margin-left: 4px;">
                                <input type="checkbox" id="chk_thu" />
                                <b style="vertical-align: bottom;">T</b> </span><span style="margin-left: 4px;">
                                    <input type="checkbox" id="chk_fri" value />
                                    <b style="vertical-align: bottom;">F</b> </span><span style="margin-left: 4px;">
                                        <input type="checkbox" id="chk_sat" value />
                                        <b style="vertical-align: bottom;">S</b> </span><span style="margin-left: 4px;">
                                            <input type="checkbox" id="chk_sun" value />
                                            <b style="vertical-align: bottom;">S</b> </span>
            </div>
            <br />
            <div class="modal-footer">
                <a href="#" id="btncalendarsave" class="btn btn-primary">Create Event </a><a href="#"
                    id="btndeleteevent" style="display: none" class="btn btn-primary">Delete Event
                </a><a href="#" id="btnClose" class="btn btn-primary" data-dismiss="modal">Close</a>
            </div>
        </div>
    </div>
    <div class="modal hide fade" id="popupdeleteimportantevent" style="left: 56%; width: 33%;">
        <div class="modal-header" style="border-bottom: 0">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h4>
                <span id="Span1"></span>
                <input type="hidden" id="Hidden1" /><input type="hidden" id="Hidden2" />
                <input type="hidden" id="Hidden3" /><input type="hidden" id="Hidden4" />
                <input type="hidden" id="Hidden5" />
                <input type="hidden" id="Hidden6" />
                <input type="hidden" id="Hidden7" value="month" />
                <input type="hidden" id="Hidden8" />
            </h4>
        </div>
        <div class="modal-body">
            <input type="hidden" id="hdn_important_start_date" />
            <input type="hidden" id="hdn_important_end_date" />
            <input type="hidden" id="hdn_important_course_code" />
            <input type="hidden" id="hdn_important_day_code" />
            <div id="div3">
                <b>Start Date :</b> <span id="spn_start_event_date"></span>
                <br />
                <b>End Date :</b> <span id="spn_end_event_date"></span>
                <br />
                <b>Event name :</b> <span id="spn_event_name"></span>
            </div>
            <br />
            <div class="modal-footer">
                <a href="#" id="btn_delete_important_event" style="display: inline-block" class="btn btn-primary">
                    Delete Event </a><a href="#" id="A3" class="btn btn-primary" data-dismiss="modal">Close</a>
            </div>
        </div>
    </div>
    <div class="row-fluid">
        <!--PAGE CONTENT BEGINS HERE-->
        <button style="float: right;" type="submit" id="btn_print">
            Print
        </button>
        <div class="widget-box" id="student_wise_course" style="display: block; border-bottom: 0;">
            <div class="widget-box" id="div_student_wise_course_upload" style="display: none;
                border-bottom: 0;">
                <asp:FileUpload ID="google_upload" runat="server" />
            </div>
            <div>
                <span style="font-weight: bold; font-family: tahoma, arial, helvetica;">Add Google ICAL
                    link : </span>
                <input type="text" id="txt_google_link" />
                <button id="btn_save_googlelink" type="button" style="margin-top: -9px;">
                    Save
                </button>
            </div>
        </div>
        <div class="row-fluid">
            <div class="span2" style="float: left; width: 15.529915%; margin-top: 60px;">
                <ul class="ui-easytree easytree-container easytree-focused">
                    <li><span id="_st_node_3433_1" class="easytree-node  easytree-ico-cf easytree-exp-c easytree-active">
                        <span class="easytree-expander" onclick="return tree_menu_click(this);"></span><span
                            class="easytree-title" onclick="return tree_menu_click(this);" style="margin-left: 0px;
                            padding-left: 0px; font-size: 14px;">My Calendar</span> </span>
                        <ul class="" style="display: none;">
                            <div style="margin-top: 5px; display: block; width: 100%; overflow: hidden;" class="row-fluid"
                                id="Div1">
                                <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                                    border="0" id="Table1" width="100%">
                                    <tbody>
                                        <tr>
                                            <td>
                                                My Calendar
                                            </td>
                                            <td>
                                                <center>
                                                    <input type="checkbox" name="check1" value="1" class="chk_mycalendar"></center>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Uploaded Calendar
                                            </td>
                                            <td>
                                                <center>
                                                    <input type="checkbox" name="check1" value="1" class="chk_uploaded"></center>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </ul>
                    </li>
                    <li style="margin-top: 10px;"><span id="_st_node_3433_2" class="easytree-node  easytree-ico-cf easytree-exp-c easytree-active">
                        <span class="easytree-expander" onclick="return tree_menu_click(this);"></span><span
                            class="easytree-title" onclick="return tree_menu_click(this);" style="margin-left: 0px;
                            padding-left: 0px; font-size: 14px;">Other Calendar</span> </span>
                        <ul class="" style="display: none; white-space: normal;">
                            <div style="margin-top: 5px; display: none; width: 100%; height: 632px; overflow: hidden;"
                                class="row-fluid" id="datalist_instructor">
                                <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                                    border="0" id="datatable_instructor" width="100%">
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </ul>
                    </li>
                </ul>
            </div>
            <div id="print_data" class="span10" style="float: right; margin-left: 0px;">
                <div class="space">
                </div>
                <div id="calendar" class="fc fc-ltr">
                </div>
            </div>
            <div class="span3">
                <div class="widget-box transparent">
                </div>
            </div>
        </div>
        <!--PAGE CONTENT ENDS HERE-->
    </div>
    <script type="text/javascript">
        var Calendar = {};
        var oTable;
        var pattern = /(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d/;

        $(document).ready(function () {

            get_event_mst_data();
            getinstructor();

            $('#txt_start_date').datepicker({
                dateFormat: "dd/mm/yy"
            });

//            $('.expandContent').click(function(){
//                $('.showMe').toggle();
//            });

            $('#txt_end_date').datepicker({
                dateFormat: "dd/mm/yy"
            });

            $('#btn_print').on('click',function(){

            window.open('Print_MyCalendar.aspx?current_view='+ $("#calendar").fullCalendar('getView').name +'&current_date=' + $.fullCalendar.formatDate($("#calendar").fullCalendar('getDate'), 'MM-dd-yyyy'), 'PrintMe', 'height=600px,width=700px,scrollbars=1');
           
        // 
        //
//         $.ajax({
//                        type: "POST",
//                        url: "../../WebService.asmx/get_excel",
//                        data: "{}",
//                        contentType: "application/json",
//                        datatype: "json",
//                        success: function (data) {

//                           
//                            //                            callback(events);
//                        },

//                        Error: function (data) {

//                            alert(data.d);
//                        }

//                    });

               return false;
          });

//             $('#calendar').fullCalendar({

//             events:{
////                googleCalendarApiKey: "AIzaSyB5HuWYa4OzyfGTYc7KeBeNipho37TM8RA",
//                 googleCalendarApiKey: "AIzaSyDcnW6WejpTOCffshGDDb4neIrXVUA1EAE",
//                 googleCalendarId: "usa__en@holiday.calendar.google.com",
//                 dataType:'gcal'
//                }
//    });

            if ('<%= Session["UserId"] %>' != '') {
                $('#hdn_user_id').val('<%= Session["UserId"] %>');
            }

           fullcalendarload();

            $("#drp_event").on('change', function () {

                if ($("#drp_event").val() == "E5") {

                    $('#txt_new_event').css('display', 'block');

                }
                else {

                    $('#txt_new_event').css('display', 'none');
                }

            });


            $("#chk_repeat").on('click', function () {

                if ($("#chk_repeat").prop('checked') == true) {
                    $('#div_repeat').css('display', 'block');
                }
                else {


                    repeat_days_false();
                    $('#div_repeat').css('display', 'none');
                }

            });

            $("#btncalendarsave").on('click', function () {

                save_new_uodate_event('N');

            });

            $("#btndeleteevent").on('click', function () {

                save_new_uodate_event('Y');
            });

            $("#btn_delete_important_event").on('click', function () {


             save_deleted_timetable_event();
               
            });

            
            
            $("#btn_save_googlelink").on('click',function(){

            var link = $('#txt_google_link').val().trim();

            if (link == '') {
                bootbox.alert("Please Enter your google ICAL link");
                return false;
            }

            if (link.search('ics') != -1) {
                
            }
            else
            {
                  bootbox.alert("Please check your google ICAL link format");
                  return false;
            }

              $.ajax({
                type: "POST",
                url: "../../WebService.asmx/Save_google_link",
                data: "{'google_link' : '" + link + "'}",
                async: false,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                    bootbox.alert(data.d);

                     if ($("#calendar").fullCalendar('getDate') != '') {
                         $('#hdn_view_month').val($.fullCalendar.formatDate($("#calendar").fullCalendar('getDate'), 'MM-dd-yyyy'));
                       }

                     $('#hdn_view').val($("#calendar").fullCalendar('getView').name); 

                    fullcalendarload();

                     if ($('#hdn_view_month').val() != '') {
                     var a = $('#hdn_view_month').val().split('-');
                            $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    }
                    else
                    {
                          var a = $('#hdn_view_month').val().split('-');

                           $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    
                    }

                },
                error: function (msg) { bootbox.alert(msg.d); }
            });

            return false;
            });

             $("#" + '<%=google_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/google_calendar.ashx',
                'buttonText': 'Google Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
                    
                    FileName = file.name;
                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Event Saved/Updated Successfully") {
                        bootbox.alert("Google calendar event saved successfully.");

                        fullcalendarload();

                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                    }
                    else
                    {
                        bootbox.alert(data);
                    }
                    
                    //   alert(FileName);
                }
            });

            $(document).on("click", ".chk_full_parent", function (event) {
            debugger;
        var $this = $(this), $table = $this.closest("table"), $madaniya = null;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        if (this.checked == false) {
            $table.find(".chk_instructor").prop("checked", this.checked).change();
        }
       
    }).on("click", ".chk_instructor", function () {

    debugger;
        var $this = $(this), $table = $this.closest("table"), $madaniya = null; $madaniya = null, checkedLength = 0;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        $madaniya = $table.find(".chk_instructor");
        checkedLength = $madaniya.filter(":checked").length;
       // $table.find(".chk_full_parent").prop({ "indeterminate": checkedLength && checkedLength !== $madaniya.length, "checked": checkedLength === $madaniya.length });
        $table.find(".chk_full_parent").prop({ "checked": checkedLength && checkedLength !== $madaniya.length, true: checkedLength === $madaniya.length });
    }).on("change", ".chk_instructor", function () {
        if (this.checked) {
            //  addSelection(this.value);
        } else {
            // removeSelection(this.value);
        }
    });

        });

        function tree_menu_click(this_node) {
        
            var parent_class = this_node.parentElement.classList;
            var status;
            
            if (this_node.parentElement.classList.contains('easytree-exp-c')) status = false;
            else if (this_node.parentElement.classList.contains('easytree-exp-e')) status = true;
            
            if (status) {
                this_node.parentElement.classList.remove('easytree-exp-e');
                this_node.parentElement.classList.add('easytree-exp-c');
                this_node.parentElement.nextElementSibling.style.display = 'none';
            }
            else {
                this_node.parentElement.classList.remove('easytree-exp-c');
                this_node.parentElement.classList.add('easytree-exp-e');
                this_node.parentElement.nextElementSibling.style.display = 'block';
            }
        }

        function fullcalendarload() {

            $('#calendar').fullCalendar('destroy');

           

            var calendar = $('#calendar').fullCalendar({

                //                buttonText: {
                //                    prev: '<i class="icon-chevron-left"></i>',
                //                    next: '<i class="icon-chevron-right"></i>'
                //                },

                header: {
                    left: 'today,prev,next',
                    center: 'title',
                    right: 'list,month,agendaWeek,agendaDay'
                    //                    right: 'list,month,agendaWeek,agendaDay,agendaList'
                },
                //                aspectRatio: 1, 
                defaultView: $('#hdn_view').val(), // add for display first Week part on page load
                allDaySlot: true,
                //                // firstHour: 2,
                //                slotMinutes: 30,
                //                firstDay: 1,
                //                minTime: 8,
                //                columnFormat: {
                //                    week: "dddd"
                //                },
                //                maxTime: '19:30',
                //                eventColor: '#378006',
                axisFormat: 'HH:mm',
                timeFormat: {
                    agenda: 'H:mm{ - HH:mm}',
                    '': 'HH:mm'
                },
                
//                eventSources: [
//            {
//                googleCalendarApiKey: "AIzaSyB5HuWYa4OzyfGTYc7KeBeNipho37TM8RA",
//                googleCalendarId: "usa__en@holiday.calendar.google.com"
//            }
//        ],

                events: function (start, end, callback) {
                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/get_calander_event_data",
                        data: "{'start_date':'" + $.fullCalendar.formatDate(start, 'MM-dd-yyyy') + "','end_date':'" + $.fullCalendar.formatDate(end, 'MM-dd-yyyy') + "'}",
                        contentType: "application/json",
                        datatype: "json",
                        success: function (data) {
                        debugger;
                            if (data.d != "") 
                            {

                                var events = [];

                                if (data.d[0] != null) {

                                    time_table_data = JSON.parse(data.d[0]);

                                    var one_day = (24 * 60 * 60 * 1000);

                                    for (var i = 0; i < time_table_data.length; i++) {
                                         
                                        var allday = false;
                                        var edit = false;
                                        var bcolor = "#E3E3FF";
                                        var bordercolor = "#A9ABFE";

                                        var from_date = new Date(time_table_data[i]["from_date"]);
                                        var to_date = new Date(time_table_data[i]["to_date"]);



                                        var start_date = from_date.getFullYear() + '/' + (from_date.getMonth() + 1) + '/' + from_date.getDate() + ' ' + time_table_data[i]["from_time"] + ':00';
                                        var end_date = to_date.getFullYear() + '/' + (to_date.getMonth() + 1) + '/' + to_date.getDate() + ' ' + time_table_data[i]["to_time"] + ':00';

                                        if (time_table_data[i]["from_time"] == time_table_data[i]["to_time"]) {
                                            allday = true;
                                            edit = true;
                                        }

                                        if (time_table_data[i]["user_id"] != $("#hdn_user_id").val()) {
                                            bcolor = "#E0F7ED";
                                            bordercolor = "#E0F7ED";
                                        }

                                        if (time_table_data[i]["is_repeated"] != 'Y') {

                                            events.push({
                                                start: start_date,
                                                end: end_date,
                                                id1: time_table_data[i]["doc_no"] + '~' + time_table_data[i]["user_id"] + '~' + time_table_data[i]["event_code"],
                                                allDay: allday,
                                                borderColor: time_table_data[i]["bordercolor"],
                                                is_repeated: time_table_data[i]["is_repeated"],
                                                repeated_days: time_table_data[i]["repeated_days"],
                                                repeated_start_date: from_date,
                                                repeated_end_date: to_date,
                                                //  editable: edit,
                                                textColor: 'black',
                                                backgroundColor: time_table_data[i]["color"],
                                                title: time_table_data[i]["eventname"]
                                            });
                                        }
                                        else if (time_table_data[i]["is_repeated"] == 'Y') {

                                            var from_dt = new Date(from_date);
                                            var to_dt = new Date(to_date);

                                            for (loop = start.getTime(); loop < end.getTime(); loop = loop + one_day) {

                                                var column_date = new Date(loop);
                                                var loop_date = (column_date.getMonth() + 1) + '/' + column_date.getDate() + '/' + column_date.getFullYear();

                                                if ((time_table_data[i]["repeated_days"].search(column_date.getDay()) != -1)) {

                                                    for (var check = from_dt.getTime(); check <= to_dt.getTime(); check = check + one_day) {

                                                        var check_day = new Date(check);

                                                        var startdate = check_day.getFullYear() + '/' + (check_day.getMonth() + 1) + '/' + check_day.getDate() + ' ' + time_table_data[i]["from_time"] + ':00';

                                                        var enddate = check_day.getFullYear() + '/' + (check_day.getMonth() + 1) + '/' + check_day.getDate() + ' ' + time_table_data[i]["to_time"] + ':00';
                                                        var date1 = (check_day.getMonth() + 1) + '/' + check_day.getDate() + '/' + check_day.getFullYear();
                                                        // we're in Moday, create the event

                                                        if ((time_table_data[i]["repeated_days"].search(check_day.getDay()) != -1) && (loop_date == date1)) {


                                                            events.push
                                                                                ({
                                                                                    start: startdate,
                                                                                    end: enddate,
                                                                                    id1: time_table_data[i]["doc_no"] + '~' + time_table_data[i]["user_id"] + '~' + time_table_data[i]["event_code"],
                                                                                    allDay: allday,
                                                                                    borderColor: time_table_data[i]["bordercolor"],
                                                                                    is_repeated: time_table_data[i]["is_repeated"],
                                                                                    repeated_days: time_table_data[i]["repeated_days"],
                                                                                    repeated_start_date: from_date,
                                                                                    repeated_end_date: to_date,
                                                                                    repeated_start_time:time_table_data[i]["from_time"] ,
                                                                                    repeated_end_time: time_table_data[i]["to_time"],
                                                                                    //  editable: edit,
                                                                                    textColor: 'black',
                                                                                    backgroundColor: time_table_data[i]["color"],
                                                                                    title: time_table_data[i]["eventname"]
                                                                                });
                                                        }
                                                    }

                                                }

                                            }

                                        }

                                    }
                                }

                                if (data.d[1] != null) {
                                     
                                    var course_time_data = JSON.parse(data.d[1]);

                                    if (course_time_data != '') 
                                    {
                                            
                                        var one_day = (24 * 60 * 60 * 1000);


                                        for (var i = 0; i < course_time_data.length; i++) 
                                        {

                                            var bcolor = "#FFAD46";
                                            var bordercolor = "#FFAD46";

                                            var from_time = course_time_data[i]["from_time"].split(".");
                                            var to_time = course_time_data[i]["to_time"].split(".");

                                            if (course_time_data[i]["instructor_code"] != $("#hdn_user_id").val()) 
                                            {
                                                bcolor = "#E68200";
                                                bordercolor = "#E68200";

                                            }

                                            for (loop = start.getTime(); loop < end.getTime(); loop = loop + one_day) 
                                           {
                                                
                                                var column_date = new Date(loop);
                                                var flag = 'N';

                                                
                                                 if (data.d[5] != null) 
                                                 {
                                                        var deleted_timetable_data = JSON.parse(data.d[5]);

                                                        if (deleted_timetable_data != '') 
                                                        {
                                                            
                                                            for (var de = 0; de < deleted_timetable_data.length; de++) 
                                                            {
                                                                var deleted_date = new Date(deleted_timetable_data[de]["from_date"]);

                                                                if (deleted_date.toLocaleDateString() == column_date.toLocaleDateString() && course_time_data[i]["course_code"] == deleted_timetable_data[de]["course_code"])
                                                                {
                                                                       flag = 'Y';   
                                                                       
                                                                       break;              
                                                                }
                                                               
                                                            }
                                                        }
                                                 }
                                                 if (  flag == 'N') {
    

                                                    if (column_date.getDay() == course_time_data[i]["day_code"]) 
                                                    {
                                                            events.push
                                                                                ({
                                                                                    id1: 'timetable',
                                                                                    instructorcode : course_time_data[i]["instructor_code"],
                                                                                    coursecode : course_time_data[i]["course_code"],
                                                                                    title: course_time_data[i]["course_name"],
                                                                                    start: new Date(column_date.setHours(from_time[0], from_time[1])),
                                                                                    end: new Date(column_date.setHours(to_time[0], to_time[1])),
                                                                                    allDay: false,
                                                                                    borderColor: bcolor,
                                                                                    backgroundColor: bordercolor
                                                                                });
                                                    }
                                                }
                                            
                                            }

                                        }


                                    }

                                }

                                 if (data.d[2] != null) {

                                    time_table_data = JSON.parse(data.d[2]);

                                    var one_day = (24 * 60 * 60 * 1000);

                                    for (var i = 0; i < time_table_data.length; i++) {

                                        var allday = false;
                                        var edit = false;
//                                        var bcolor = "#D6BADE";
//                                        var bordercolor = "#D6BADE";

                                        var bcolor = "#FF9178";
                                        var bordercolor = "#FF9178";

                                        var event="(No title)";

                                        var from_date = new Date(time_table_data[i]["from_date"]);
                                        var to_date = new Date(time_table_data[i]["todate"]);

                                        var start_date = from_date.getFullYear() + '/' + (from_date.getMonth() + 1) + '/' + from_date.getDate() + ' ' + time_table_data[i]["from_time"] + ':00';
                                        var end_date = to_date.getFullYear() + '/' + (to_date.getMonth() + 1) + '/' + to_date.getDate() + ' ' + time_table_data[i]["to_time"] + ':00';

                                            if (time_table_data[i]["from_time"] == time_table_data[i]["to_time"]) {
                                            allday = true;
                                            edit = true;
                                        }

//                                        if (time_table_data[i]["user_id"] != $("#hdn_user_id").val()) {
//                                            bcolor = "#EAE6E6";
//                                            bordercolor = "#EAE6E6";
//                                        }

                                        if (time_table_data[i]["event"].search('birthday') != -1) {
//                                            bcolor = "#FAFFBA";
//                                            bordercolor = "#FAFFBA";

                                            bcolor = "#10FFE4";
                                            bordercolor = "#10FFE4";
                                        }

                                        if (time_table_data[i]["event"].trim() != '') {
                                            event =  time_table_data[i]["event"];
                                        }


                                        if (time_table_data[i]["is_repeated"] != 'Y') {


                                            events.push({
                                                start: start_date,
                                                end: end_date,
                                                id1: time_table_data[i]["uid"] + '~' + time_table_data[i]["user_id"],
                                                allDay: allday,

                                                is_repeated: time_table_data[i]["is_repeated"],
                                                repeated_days: time_table_data[i]["repeated_days"],
                                                repeated_start_date: from_date,
                                                repeated_end_date: to_date,
                                                //  editable: edit,
                                                textColor: 'black',
                                                borderColor: bordercolor,
                                                backgroundColor: bcolor,
                                                title: event
                                            });
                                        }
                                        else if (time_table_data[i]["is_repeated"] == 'Y') 
                                        {
                                       
                                            var frequency = time_table_data[i]["frequency"];
                                            var occurence = time_table_data[i]["occurrences_count"];
                                            var interval = time_table_data[i]["interval"];
                                            var bymonthday = time_table_data[i]["bymonthday"]; 
                                            var offset = time_table_data[i]["offeset"]; 
                                           
                                            var from_dt =new Date(from_date);
                                            var to_dt;

                                            if (time_table_data[i]["end_never"] == "Y") {
                                          
                                               to_dt = new Date(end);
                                            }
                                            else
                                            {
                               
                                               to_dt = new Date(to_date);
                                            }
                                      
                                            var occurence_count = 0;

//                                            for (loop = start.getTime(); loop < end.getTime(); loop = loop + one_day) {

//                                                var column_date = new Date(loop);
//                                                var loop_date = (column_date.getMonth() + 1) + '/' + column_date.getDate() + '/' + column_date.getFullYear();

//                                                if ((time_table_data[i]["repeated_days"].search(column_date.getDay()) != -1)) {

                                                    for (var check = from_dt.getTime(); check <= to_dt.getTime(); check = check + one_day) {

                                                         var final_event_flag="N";

                                                        var check_day = new Date(check);

                                                        var startdate = check_day.getFullYear() + '/' + (check_day.getMonth() + 1) + '/' + check_day.getDate() + ' ' + time_table_data[i]["from_time"] + ':00';

                                                        var enddate = check_day.getFullYear() + '/' + (check_day.getMonth() + 1) + '/' + check_day.getDate() + ' ' + time_table_data[i]["to_time"] + ':00';
                                                        var date1 = (check_day.getMonth() + 1) + '/' + check_day.getDate() + '/' + check_day.getFullYear();
                                                        // we're in Moday, create the event


                                                        if (frequency == "Weekly" || frequency == "Daily") 
                                                        {
                                                            if ((time_table_data[i]["repeated_days"].search(check_day.getDay()) != -1) )
                                                            // if ((time_table_data[i]["repeated_days"].search(check_day.getDay()) != -1) && (loop_date == date1)) 
                                                            {
                                                                final_event_flag="Y";
                                                            }

                                                        }
                                                        else if (frequency == "Monthly") 
                                                        {


                                                                if (bymonthday != '') 
                                                                {
                                                                    if (check_day.getDate() == bymonthday) 
                                                                    {
                                                                      final_event_flag="Y";
    
                                                                    }
                                                                }
                                                                else if(offset != 0)
                                                                {
                                                                    if ((time_table_data[i]["repeated_days"].search(check_day.getDay()) != -1) )
                                                                    {
                                                                        var check_offset_val = parseInt(check_day.getDate()) / 7;

                                                                        if ((parseFloat(offset)- 1) <= check_offset_val && parseFloat(offset) >=  parseFloat(check_offset_val) ) 
                                                                        {
                                                                            final_event_flag = "Y";
                                                                        }
                                                                    }
                                                                }
                                                        }
                                                        else if (frequency == "Yearly") 
                                                        {
                                                             if (check_day.getDate() == from_date.getDate() && check_day.getMonth() == from_date.getMonth()) 
                                                             {
                                                                final_event_flag="Y";
                                                             }
                                                        }

                                                        
                                                             if (final_event_flag == "Y") 
                                                             {
                                                                    if (occurence != 0) 
                                                                    {
                                                                        occurence_count = parseInt(occurence_count) + parseInt(1);

                                                                        if (parseInt(occurence_count) <= parseInt(occurence)) 
                                                                        {
                                                                            events.push
                                                                            ({
                                                                                start: startdate,
                                                                                end: enddate,
                                                                                id1: time_table_data[i]["uid"] + '~' + time_table_data[i]["user_id"],
                                                                                allDay: allday,

                                                                                is_repeated: time_table_data[i]["is_repeated"],
                                                                                repeated_days: time_table_data[i]["repeated_days"],
                                                                                repeated_start_date: from_date,
                                                                                repeated_end_date: to_date,
                                                                                repeated_start_time: time_table_data[i]["from_time"],
                                                                                repeated_end_time: time_table_data[i]["to_time"],
                                                                                //  editable: edit,
                                                                                textColor: 'black',
                                                                                borderColor: bordercolor,
                                                                                backgroundColor: bcolor,
                                                                                title: event
                                                                            });
                                                                        }
                                                                    }
                                                                    else
                                                                    {
                                                                        events.push
                                                                        ({
                                                                            start: startdate,
                                                                            end: enddate,
                                                                            id1: time_table_data[i]["uid"] + '~' + time_table_data[i]["user_id"],
                                                                            allDay: allday,

                                                                            is_repeated: time_table_data[i]["is_repeated"],
                                                                            repeated_days: time_table_data[i]["repeated_days"],
                                                                            repeated_start_date: from_date,
                                                                            repeated_end_date: to_date,
                                                                            repeated_start_time: time_table_data[i]["from_time"],
                                                                            repeated_end_time: time_table_data[i]["to_time"],
                                                                            //  editable: edit,
                                                                            textColor: 'black',
                                                                            borderColor: bordercolor,
                                                                            backgroundColor: bcolor,
                                                                            title: event
                                                                        });
                                                                    }
                                                              }
                                                    }

                                                }
                                    }
                                }

                                if (data.d[3] != null) {
                                           
                                    var uploaded_calendar = JSON.parse(data.d[3]);

                                    if (uploaded_calendar != '') {
                                            
                                            if (uploaded_calendar.mycalendar == "Y") 
                                            {
                                                  $(".chk_mycalendar").prop('checked', true);
                                            }
                                              if (uploaded_calendar.uploaded_calendar == "Y") 
                                            {
                                                  $(".chk_uploaded").prop('checked', true);
                                            }
                                    }
                                }

                                if (data.d[4] != null) {
                                    
                                    var google_link_data = JSON.parse(data.d[4]);

                                    if (google_link_data != '') {
                                    
                                    $('#txt_google_link').val(google_link_data[0]["link"]);
                                    
                                    }
                                }

                            }
                             
                            callback(events);
                            //                            callback(events);
                        },

                        Error: function (data) {

                            alert(data.d);
                        }

                    });

                },
                editable: true,

                eventRender: function (event, element, view, ui) {
                
                if (event.title.search('birthday') != -1) {
    
                    element.find("div.fc-event-inner").prepend("<img src='../../image/cake.gif' width='12' height='12'>");
                }
               
                },
                select: function (start, end, allDay, jsEvent, view) {
                debugger;
               
//                 var check = $.fullCalendar.formatDate(start,'yyyy-MM-dd');
//    var today = $.fullCalendar.formatDate(new Date(),'yyyy-MM-dd');
//    if(check < today)
//    {
//        revertFunc();
//    }
                
                    $("#chk_repeat").prop('checked', false);

                    $('#div_repeat').css('display', 'none');

                    repeat_days_false();

                    $('#drp_event').val('E1');

                    $('#txt_new_event').css('display', 'none');

                    $('#txt_start_date').val($.fullCalendar.formatDate(start, 'dd/MM/yyyy'));
                    $('#txt_end_date').val($.fullCalendar.formatDate(end, 'dd/MM/yyyy'));

                    $('#hdn_view').val(view.name);
                    $('#hdn_view_month').val($.fullCalendar.formatDate(view.start, 'MM-dd-yyyy'));

                    $('#btndeleteevent').css('display', 'none');

                    $('#txt_new_event').val('');
                    $('#spn_new_event_data').html('');
                    $("#hdneventdocnumber").val('');

                    $('#btncalendarsave').text('Create Event');

                    select_edit_event(start, end);

                },
                eventClick: function (calEvent, jsEvent, view) {

                debugger;
                
                                $('#spn_start_event_date').text('');
                                $('#spn_end_event_date').text('');
                                $('#spn_event_name').text('');

                                $('#hdn_important_start_date').val('');
                                $('#hdn_important_end_date').val('');
                                $('#hdn_important_course_code').val('');
                                $('#hdn_important_day_code').val('');

                    $('#hdn_view').val(view.name);
                    $('#hdn_view_month').val($.fullCalendar.formatDate(view.start, 'MM-dd-yyyy'));
                    $('#btndeleteevent').css('display', 'inline-block');
 
                    var n = calEvent.id1.split('~');
                    if (n.length > 2) {
                        $('#txt_new_event').val('');
                        $('#spn_new_event_data').html('');
                        $("#hdneventdocnumber").val('');

                        if (n[1] == $("#hdn_user_id").val()) {

                            $("#hdneventdocnumber").val(n[0]);
                            $("#drp_event").val(n[2]);
                            if (n[2] == "E5") {
                                $('#txt_new_event').val(calEvent.title);
                                $('#txt_new_event').css('display', 'block');
                            }
                            else {
                                $('#txt_new_event').val('');
                                $('#txt_new_event').css('display', 'none');
                            }
                            $('#btncalendarsave').text('Update Event');

                            repeat_days_false();

                            if (calEvent.is_repeated == "Y") {

                                $("#chk_repeat").prop('checked', true);

                                $('#div_repeat').css('display', 'block');

                                var rep_days = calEvent.repeated_days.split(',');

                                $('#txt_start_date').val($.fullCalendar.formatDate(calEvent.repeated_start_date, 'dd/MM/yyyy'));
                                $('#txt_end_date').val($.fullCalendar.formatDate(calEvent.repeated_end_date, 'dd/MM/yyyy'));

                                for (var i = 0; i < rep_days.length; i++) {

                                    if (rep_days[i] == "0") {

                                        $("#chk_sun").prop('checked', true);
                                    }
                                    else if (rep_days[i] == "1") {
                                        $("#chk_mon").prop('checked', true);
                                    }
                                    else if (rep_days[i] == "2") {
                                        $("#chk_tue").prop('checked', true);
                                    }
                                    else if (rep_days[i] == "3") {
                                        $("#chk_wed").prop('checked', true);
                                    }
                                    else if (rep_days[i] == "4") {
                                        $("#chk_thu").prop('checked', true);
                                    }
                                    else if (rep_days[i] == "5") {
                                        $("#chk_fri").prop('checked', true);
                                    }
                                    else if (rep_days[i] == "6") {
                                        $("#chk_sat").prop('checked', true);
                                    }

                                }
                            }
                            else {

                                $('#txt_start_date').val($.fullCalendar.formatDate(calEvent.start, 'dd/MM/yyyy'));
                                if (calEvent.end == null) {
                                    $('#txt_end_date').val($.fullCalendar.formatDate(calEvent.start, 'dd/MM/yyyy'));
                                }
                                else {
                                    $('#txt_end_date').val($.fullCalendar.formatDate(calEvent.end, 'dd/MM/yyyy'));
                                }

                                $("#chk_repeat").prop('checked', false);

                                $('#div_repeat').css('display', 'none');

                            }

                            var start = calEvent.start;
                            var end;
                            if (calEvent.end == null) {

                                end = start;
                            }
                            else {
                                end = calEvent.end;
                            }

                            select_edit_event(start, end);
                        }
                        else {

                         

                        }
                    }
                    else
                    {
                     if (n[0] == "timetable" && $('#hdnuserid').val() ==  calEvent.instructorcode) {
                          $('#popupdeleteimportantevent').modal('show');
                                
                                
                            var start = calEvent.start;
                            var end;
                            if (calEvent.end == null) {

                                end = start;
                            }
                            else {
                                end = calEvent.end;
                            }

                                $('#spn_start_event_date').text($.fullCalendar.formatDate(start, 'dd-MM-yyyy'));
                                $('#spn_end_event_date').text($.fullCalendar.formatDate(end, 'dd-MM-yyyy'));
                                $('#spn_event_name').text(calEvent.title);

                                $('#hdn_important_start_date').val($.fullCalendar.formatDate(start, 'MM-dd-yyyy'));
                                $('#hdn_important_end_date').val($.fullCalendar.formatDate(end, 'MM-dd-yyyy'));
                                
                                $('#hdn_important_course_code').val(calEvent.coursecode);

                                $('#hdn_important_day_code').val(start.getDay());
                                
                           }
                    }

                    // alert(calEvent);
                },
//                eventDragStart:function( event, jsEvent, ui, view ) {
//                 
//                 },
                eventDrop: function (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, view) {
                     
                    //    return revertFunc();

//                    if (!allDay) {
//                        return revertFunc();
//                    }

                    if (event.is_repeated == 'Y') {

                        if (dayDelta == 0) 
                        {
                           if (event.repeated_start_time != event.repeated_end_time) 
                            {
    
                            } 
                             else
                            {
                                return  revertFunc();
                            }
                        }
                        else
                        {
                            return revertFunc();
                        }
                    }

                    $('#hdn_view').val(view.name);
                    $('#hdn_view_month').val($.fullCalendar.formatDate(view.start, 'MM-dd-yyyy'));
                    var n = event.id1.split('~');

                    if (n.length > 2) {
                        $('#txt_new_event').val('');
                        $('#spn_new_event_data').html('');
                        $("#hdneventdocnumber").val('');

                        $("#drp_event").val(n[2]);


                        if (n[1] == $("#hdn_user_id").val()) {

                            $("#hdneventdocnumber").val(n[0]);

                            if (n[2] == "E5") {
                                $('#txt_new_event').val(event.title);
                                $('#txt_new_event').css('display', 'block');
                            }
                            else {
                                $('#txt_new_event').val('');
                                $('#txt_new_event').css('display', 'none');
                            }

                            save_event(event);
                        }
                        else {

                            revertFunc();
                        }
                    }
                    else {
                        revertFunc();
                    }

                },
                eventResize: function (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view) {
                     
                    //return revertFunc();

                    var flag ='N';

                    if (event.is_repeated == 'Y') {
                         if (dayDelta == 0) 
                        {
                           if (event.repeated_start_time != event.repeated_end_time) 
                            {
    
                            } 
                           
                        }
                        else
                        {
                            return revertFunc();
                        }
                    }

//                  
//                    if (event.start.toLocaleDateString() != event.end.toLocaleDateString()) {

//                     if (event.start.toTimeString() !=event.end.toLocaleString() ) {

//                     if (event.end.getHours() == 0 && event.end.getMinutes() == 0 ) {
//    
//}
//else
//{
// flag ='Y';
//}
//    
//}
//                        
//                    }

//                    if (flag =='Y') {
//    return revertFunc();
//}

                    $('#hdn_view').val(view.name);
                    $('#hdn_view_month').val($.fullCalendar.formatDate(view.start, 'MM-dd-yyyy'));

                    var n = event.id1.split('~');

                    if (n.length > 2) {

                        $('#txt_new_event').val('');
                        $('#spn_new_event_data').html('');
                        $("#hdneventdocnumber").val('');

                        $("#drp_event").val(n[2]);

                        if (n[1] == $("#hdn_user_id").val()) {

                            $("#hdneventdocnumber").val(n[0]);

                            if (n[2] == "E5") {
                                $('#txt_new_event').val(event.title);
                                $('#txt_new_event').css('display', 'block');
                            }
                            else {
                                $('#txt_new_event').val('');
                                $('#txt_new_event').css('display', 'none');
                            }

                            save_event(event);
                        }
                        else {

                            revertFunc();
                        }
                    }
                    else {
                        revertFunc();
                    }

                },
                selectable: true,
                selectHelper: false


            });

          //   $('.fc-past').css('pointer-events', 'none');
        }

          function save_deleted_timetable_event() {
          debugger;
            var event_data = { 'doc_no': '', 'from_date': '', 'to_date': '', 'from_time': '', 'to_time': '', 'course_code': '', 'cancel_flag': 'Y','day_code':'' };

            if ($('#hdn_important_start_date').val().trim() == '') {
                alert('Event start date is blank');
                return false;
            }

            if ($('#hdn_important_end_date').val().trim() == '') {
                alert('Event end date is blank');
                return false;
            }

            if ($('#hdn_important_course_code').val().trim() == '') {
                alert('Event course code is blank');
                return false;
            }

            event_data.from_date = $('#hdn_important_start_date').val();
            event_data.to_date = $('#hdn_important_end_date').val();

            event_data.course_code = $('#hdn_important_course_code').val();

            event_data.day_code = $('#hdn_important_day_code').val();

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/Save_deleted_timetable_event",
                data: "{'event_data' : '" + JSON.stringify(event_data) + "'}",
                async: false,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                    bootbox.alert(data.d);
                    $('#popupdeleteimportantevent').modal('hide');

                    var a = $('#hdn_view_month').val().split('-')
                     
                    fullcalendarload();

                    $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);

                },
                error: function (msg) { bootbox.alert(msg.d); }
            });
        
        }

        function select_edit_event(start, end) {

            var start_date = start.toDateString();
            var start_get_hours = start.getHours();

            if (start_get_hours == 0) {
                start_get_hours = start_get_hours + '0';
            }

            var start_get_minuts = start.getMinutes();
            if (start_get_minuts == 0) {
                start_get_minuts = start_get_minuts + '0';
            }

            var end_date = end.toDateString();

            var end_get_hours = end.getHours();

            if (end_get_hours == 0) {
                end_get_hours = end_get_hours + '0';
            }
            var end_get_minuts = end.getMinutes();
            if (end_get_minuts == 0) {
                end_get_minuts = end_get_minuts + '0';
            }

            if (start.toLocaleString() == end.toLocaleString()) {

                $('#spn_new_event_data').html($.fullCalendar.formatDate(start, 'ddd, dd MMM yyyy'));
            }
            else {
                if (start.toLocaleDateString() == end.toLocaleDateString()) {

                    $('#spn_new_event_data').html($.fullCalendar.formatDate(start, 'ddd, dd MMM yyyy') + ' , ' + start_get_hours + ':' + start_get_minuts + ' - ' + end_get_hours + ':' + end_get_minuts);
                }
                else {
                    if (start_get_hours != end_get_hours) {
                        $('#spn_new_event_data').html($.fullCalendar.formatDate(start, 'ddd, dd MMM yyyy') + ' , ' + start_get_hours + ':' + start_get_minuts + ' - ' + $.fullCalendar.formatDate(end, 'ddd, dd MMM yyyy') + ' , ' + end_get_hours + ':' + end_get_minuts);
                    }
                    else {
                        $('#spn_new_event_data').html($.fullCalendar.formatDate(start, 'ddd, dd MMM yyyy') + ' - ' + $.fullCalendar.formatDate(end, 'ddd, dd MMM yyyy'));
                    }
                }
            }

            $('#hdn_start_date').val($.fullCalendar.formatDate(start, 'MM-dd-yyyy'));
            $('#hdn_end_date').val($.fullCalendar.formatDate(end, 'MM-dd-yyyy'));

            $('#hdn_start_time').val(start_get_hours + ':' + start_get_minuts);
            $('#hdn_end_time').val(end_get_hours + ':' + end_get_minuts);


            $('#popupfornewevent').modal('show');

        }

        function save_event(event) {

            var start = event.start;
            var end;
            if (event.end == null) {

                end = start;

            }
            else {
                end = event.end;
            }

            var start_date = start.toDateString();
            var start_get_hours = start.getHours();

            if (start_get_hours == 0) {
                start_get_hours = start_get_hours + '0';
            }

            var start_get_minuts = start.getMinutes();
            if (start_get_minuts == 0) {
                start_get_minuts = start_get_minuts + '0';
            }

            var end_date = end.toDateString();

            var end_get_hours = end.getHours();

            if (end_get_hours == 0) {
                end_get_hours = end_get_hours + '0';
            }
            var end_get_minuts = end.getMinutes();
            if (end_get_minuts == 0) {
                end_get_minuts = end_get_minuts + '0';
            }


            var event_data = { 'doc_no': '', 'from_date': '', 'to_date': '', 'from_time': '', 'to_time': '', 'event': '', 'cancel_flag': 'N', 'event_code': '', 'is_repeated': '', 'repeated_days': '' };

            if ($('#hdneventdocnumber').val().trim() != '') {
                event_data.doc_no = $('#hdneventdocnumber').val().trim();
            }

            event_data.from_date = $.fullCalendar.formatDate(start, 'MM-dd-yyyy');
            event_data.to_date = $.fullCalendar.formatDate(end, 'MM-dd-yyyy');

            event_data.from_time = start_get_hours + ':' + start_get_minuts;
            event_data.to_time = end_get_hours + ':' + end_get_minuts;

            event_data.event = $('#txt_new_event').val();
            event_data.event_code = $('#drp_event').val();

            event_data.is_repeated = 'N';

             
            if ($("#chk_repeat").prop('checked') == true) {

              if ($('#txt_start_date').val().trim() == '') {
                    bootbox.alert('Please enter repeat start date.');
                    return false;
                }

                if (!pattern.test($('#txt_start_date').val())) {
                    bootbox.alert("Please enter valid repeat start date in dd/mm/yyyy format.");
                    return false;
                }

                if ($('#txt_end_date').val().trim() == '') {
                    bootbox.alert('Please enter repeat end date.');
                    return false;
                }

                 if (!pattern.test($('#txt_end_date').val())) {
                    bootbox.alert("Please enter valid repeat end date in dd/mm/yyyy format.");
                    return false;
                }

                var repeat_start_date = $('#txt_start_date').val().split('/');

                event_data.from_date = repeat_start_date[1] + '-' + repeat_start_date[0] + '-' + repeat_start_date[2];

                var repeat_end_date = $('#txt_end_date').val().split('/');

                event_data.to_date = repeat_end_date[1] + '-' + repeat_end_date[0] + '-' + repeat_end_date[2];

                event_data.is_repeated = 'Y';

                var rep_days = '';

                if ($("#chk_mon").prop('checked') == true) {

                    rep_days = '1';
                }
                if ($("#chk_tue").prop('checked') == true) {

                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '2';
                    }
                    else {
                        rep_days = '2';
                    }

                }
                if ($("#chk_wed").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '3';
                    }
                    else {
                        rep_days = '3';
                    }
                }
                if ($("#chk_thu").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '4';
                    }
                    else {
                        rep_days = '4';
                    }
                }
                if ($("#chk_fri").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '5';
                    }
                    else {
                        rep_days = '5';
                    }
                }
                if ($("#chk_sat").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '6';
                    }
                    else {
                        rep_days = '6';
                    }
                }
                if ($("#chk_sun").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '0';
                    }
                    else {
                        rep_days = '0';
                    }
                }

                if (rep_days == '') {
                    alert('Please select Repeat day.');
                    return false;
                }

                event_data.repeated_days = rep_days;

            }

            $('#hdn_end_date').val($.fullCalendar.formatDate(end, 'MM-dd-yyyy'));

            save_ajax_method(event_data);
        }

        function save_new_uodate_event(cancel_flag) {

            var event_data = { 'doc_no': '', 'from_date': '', 'to_date': '', 'from_time': '', 'to_time': '', 'event': '', 'cancel_flag': 'N', 'event_code': '', 'is_repeated': '', 'repeated_days': '' };

            if ($('#hdn_start_date').val().trim() == '') {
                alert('Event start date is blank');
                return false;
            }

            if ($('#hdn_end_date').val().trim() == '') {
                alert('Event end date is blank');
                return false;
            }

            if ($('#hdn_start_time').val().trim() == '') {
                alert('Event start time is blank');
                return false;
            }

            if ($('#hdn_end_time').val().trim() == '') {
                alert('Event end time is blank');
                return false;
            }

            if ($('#drp_event').val() == "E5") {

                if ($('#txt_new_event').val().trim() == '') {
                    alert('Please enter other event.');
                    return false;
                }
            }

            if ($('#hdneventdocnumber').val().trim() != '') {
                event_data.doc_no = $('#hdneventdocnumber').val().trim();
            }

            event_data.from_date = $('#hdn_start_date').val();
            event_data.to_date = $('#hdn_end_date').val();

            event_data.from_time = $('#hdn_start_time').val();
            event_data.to_time = $('#hdn_end_time').val();

            event_data.event = $('#txt_new_event').val().trim();

            event_data.cancel_flag = cancel_flag;

            event_data.event_code = $('#drp_event').val();

            event_data.is_repeated = 'N';

            if ($("#chk_repeat").prop('checked') == true) {

                if ($('#txt_start_date').val().trim() == '') {
                    bootbox.alert('Please enter repeat start date.');
                    return false;
                }

                if (!pattern.test($('#txt_start_date').val())) {
                    bootbox.alert("Please enter valid repeat start date in dd/mm/yyyy format.");
                    return false;
                }

                if ($('#txt_end_date').val().trim() == '') {
                    bootbox.alert('Please enter repeat end date.');
                    return false;
                }

                 if (!pattern.test($('#txt_end_date').val())) {
                    bootbox.alert("Please enter valid repeat end date in dd/mm/yyyy format.");
                    return false;
                }

                var repeat_start_date = $('#txt_start_date').val().split('/');

                event_data.from_date = repeat_start_date[1] + '-' + repeat_start_date[0] + '-' + repeat_start_date[2];

                var repeat_end_date = $('#txt_end_date').val().split('/');

                event_data.to_date = repeat_end_date[1] + '-' + repeat_end_date[0] + '-' + repeat_end_date[2];

                event_data.is_repeated = 'Y';

                var rep_days = '';

                if ($("#chk_mon").prop('checked') == true) {

                    rep_days = '1';
                }
                if ($("#chk_tue").prop('checked') == true) {

                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '2';
                    }
                    else {
                        rep_days = '2';
                    }

                }
                if ($("#chk_wed").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '3';
                    }
                    else {
                        rep_days = '3';
                    }
                }
                if ($("#chk_thu").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '4';
                    }
                    else {
                        rep_days = '4';
                    }
                }
                if ($("#chk_fri").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '5';
                    }
                    else {
                        rep_days = '5';
                    }
                }
                if ($("#chk_sat").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '6';
                    }
                    else {
                        rep_days = '6';
                    }
                }
                if ($("#chk_sun").prop('checked') == true) {
                    if (rep_days != '') {

                        rep_days = rep_days + ',' + '0';
                    }
                    else {
                        rep_days = '0';
                    }
                }

                if (rep_days == '') {
                    alert('Please select Repeat day.');
                    return false;
                }

                event_data.repeated_days = rep_days;

            }

            save_ajax_method(event_data);
        }

        function repeat_days_false() {

            $("#chk_mon").prop('checked', false);
            $("#chk_tue").prop('checked', false);
            $("#chk_wed").prop('checked', false);
            $("#chk_thu").prop('checked', false);
            $("#chk_fri").prop('checked', false);
            $("#chk_sat").prop('checked', false);
            $("#chk_sun").prop('checked', false);
        }

        function save_ajax_method(event_data) {

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/Save_event",
                data: "{'event_data' : '" + JSON.stringify(event_data) + "'}",
                async: false,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                    bootbox.alert(data.d);
                    $('#popupfornewevent').modal('hide');

                    var a = $('#hdn_view_month').val().split('-')
                     
                    fullcalendarload();



                    $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);


                },
                error: function (msg) { bootbox.alert(msg.d); }
            });

        }


        function get_event_mst_data() {

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_calendar_event_mst",
                data: "{}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {

                    if (data.d != "") {


                        var event_data = JSON.parse(data.d)

                        for (var i = 0; i < event_data.length; i++) {

                            $('#drp_event').append($("<option></option>").val(event_data[i]["event_code"]).html(event_data[i]["event_name"]));
                        }

                    }

                },

                Error: function (data) {

                    alert(data.d);
                }

            });

        }

        function getinstructor() {

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_all_Instructor",
                data: "{}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {

                    if (data.d != "") {

                        display_instructor_data(data.d);

                    }

                },

                Error: function (data) {

                    alert(data.d);
                }

            });

        }

        function display_instructor_data(data) {


            if (oTable != null) {
                oTable.fnDestroy();

                $("#datalist_instructor").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_instructor"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#datatable_instructor").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "iDisplayLength": 60,
                "bSort": false,
                "sDom": 't',
               //    "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": ""
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [

          { "sTitle": "Instructor Name", "mData": "user_name", "bSortable": false },

             { "sTitle": "<center><input type='checkbox' name='checkheader1'  class='chk_full_parent'></input></center>",
                 "mData": null,
                 "bSortable": false,
                 "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_instructor" ></center>'
             }

            ]


            });

            $('#datalist_instructor').css("display", "block");

            var flag = "N";

            $("#datatable_instructor tbody tr").each(function (i) {

                var aPos = oTable.fnGetPosition(this);
                var a = oTable.fnGetData(aPos);


                if (a["other_user_id"] == a["user_id"]) {

                    $(this).find(".chk_instructor").prop('checked', true);
                     
                     flag = "Y";
                }

            });

            if (flag == "Y") {
                $(".chk_full_parent").prop('checked', true);
            }

        }

         $(document).on("click", ".chk_mycalendar,.chk_uploaded", function (event) {
         
          var ob = {};

           ob["other_user_id"] = $("#hdn_user_id").val();

           ob["mycalendar"] = "N";
            if ($('.chk_mycalendar').prop('checked')) {
                ob["mycalendar"] = "Y";
           }

           ob["uploaded_calendar"] = "N";
           if ($('.chk_uploaded').prop('checked')) {
                ob["uploaded_calendar"] = "Y";
           }

       
           ob["cancel_flag"] = "N";
          

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/Save_calendar_selected_user",
                data: "{'selected_user' : '" + JSON.stringify(ob) + "'}",
                async: false,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                      
                       if ($("#calendar").fullCalendar('getDate') != '') {
                         $('#hdn_view_month').val($.fullCalendar.formatDate($("#calendar").fullCalendar('getDate'), 'MM-dd-yyyy'));
                       }

                     $('#hdn_view').val($("#calendar").fullCalendar('getView').name); 
               
                    fullcalendarload();

                    if ($('#hdn_view_month').val() != '') {
                     var a = $('#hdn_view_month').val().split('-');
                            $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    }
                    else
                    {
                          var a = $('#hdn_view_month').val().split('-');

                          $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    }
                  

                },
                error: function (msg) { bootbox.alert(msg.d); }
            });

         });


         $(document).on("click", ".chk_full_parent", function (event) {

         debugger;

         if (this.checked == false) 
        {
              $.ajax({
                type: "POST",
                url: "../../WebService.asmx/remove_other_calendar",
                data: "{}",
                async: false,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                 if (data.d == "true") {
    

                      
                     if ($("#calendar").fullCalendar('getDate') != '') {
                         $('#hdn_view_month').val($.fullCalendar.formatDate($("#calendar").fullCalendar('getDate'), 'MM-dd-yyyy'));
                      }

                     $('#hdn_view').val($("#calendar").fullCalendar('getView').name); 
               
                    fullcalendarload();


                    if ($('#hdn_view_month').val() != '') {
                     var a = $('#hdn_view_month').val().split('-');
                            $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    }
                    else
                    {
                          var a = $('#hdn_view_month').val().split('-');

                           $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    
                    }
                    }
                    else
                    {
                        bootbox.alert("some problem found for deselect other calendar user.");
                    }
                  

                },
                error: function (msg) { bootbox.alert(msg.d); }
            });
        }

        });

        $(document).on("click", ".chk_instructor", function (event) {

          
            var checkbox = this;

            var ob = {};
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            ob["other_user_id"] = aData["user_id"];

            ob["mycalendar"] = "Y";
            ob["uploaded_calendar"] = "Y";

            if (this.checked) {
                ob["cancel_flag"] = "N";
            }
            else {
                ob["cancel_flag"] = "Y";
            }

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/Save_calendar_selected_user",
                data: "{'selected_user' : '" + JSON.stringify(ob) + "'}",
                async: false,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                      
                     if ($("#calendar").fullCalendar('getDate') != '') {
                         $('#hdn_view_month').val($.fullCalendar.formatDate($("#calendar").fullCalendar('getDate'), 'MM-dd-yyyy'));
                      }

                     $('#hdn_view').val($("#calendar").fullCalendar('getView').name); 
               
                    fullcalendarload();


                    if ($('#hdn_view_month').val() != '') {
                     var a = $('#hdn_view_month').val().split('-');
                            $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    }
                    else
                    {
                          var a = $('#hdn_view_month').val().split('-');

                           $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);
                    
                    }
                  

                },
                error: function (msg) { bootbox.alert(msg.d); }
            });

        });
       

    </script>
</asp:Content>
