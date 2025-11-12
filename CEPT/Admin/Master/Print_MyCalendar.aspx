<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print_MyCalendar.aspx.cs"
    Inherits="Admin_Master_Print_MyCalendar" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../DesignJS/jquery.min.js" type="text/javascript"></script>
    <link href="../../fullcalander/fullcalendar_new.css" rel="stylesheet" type="text/css" />
    <link href="../../fullcalander/agendalist_new.css" rel="stylesheet" type="text/css" />
    <link href="../../fullcalander/fullcalendar_new.print.css" rel="stylesheet" type="text/css" />
    <script src="../../fullcalander/fullcalendar_new.js" type="text/javascript"></script>
    <%--<script src="../../fullcalander/gcal.js" type="text/javascript"></script>--%>
    <style>
        .fc-header-left
        {
            display: none;
        }
        .fc-header-right
        {
            display: none;
        }
        .fc-event .ui-resizable-handle
        {
            display: none !important;
        }
    </style>
</head>
<body style="margin: 0">
    <div class="row-fluid">
        <input type="hidden" id="hdn_user_id" />
        <!--PAGE CONTENT BEGINS HERE-->
        <div class="row-fluid">
            <div id="print_data" class="span12" style="width: 850px; margin-left: 50px;">
                <div class="space">
                </div>
                <div id="calendar" class="fc fc-ltr">
                </div>
            </div>
        </div>
        <!--PAGE CONTENT ENDS HERE-->
    </div>
    <script type="text/javascript">
        var Calendar = {};
        var oTable;

        var current_view = '';

        $(document).ready(function () {

            current_view = getParameterByName('current_view');

            var current_date = getParameterByName('current_date');

            if ('<%= Session["UserId"] %>' != '') {
                $('#hdn_user_id').val('<%= Session["UserId"] %>');
            }
            
            fullcalendarload();

            var a = current_date.split('-');

            $('#calendar').fullCalendar('gotoDate', a[2], parseInt(a[0]) - parseInt(1), a[1]);

            window.print();

        });

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
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
                    right: 'list,month,agendaWeek,agendaDay,agendaList'
                    //                    right: 'list,month,agendaWeek,agendaDay,agendaList'
                },
                //                aspectRatio: 1, 
                defaultView: current_view, // add for display first Week part on page load
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


                    //  $('#hdn_view_month').val($.fullCalendar.formatDate(start, 'MM-dd-yyyy'));

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/get_calander_event_data",
                        data: "{'start_date':'" + $.fullCalendar.formatDate(start, 'MM-dd-yyyy') + "','end_date':'" + $.fullCalendar.formatDate(end, 'MM-dd-yyyy') + "'}",
                        contentType: "application/json",
                        datatype: "json",
                        async: false,
                        success: function (data) {

                            if (data.d != "") {


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
                                                                                    repeated_start_time: time_table_data[i]["from_time"],
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

                                    if (course_time_data != '') {

                                        var one_day = (24 * 60 * 60 * 1000);

                                        for (var i = 0; i < course_time_data.length; i++) {

                                            var bcolor = "#FFAD46";
                                            var bordercolor = "#FFAD46";

                                            var from_time = course_time_data[i]["from_time"].split(".");
                                            var to_time = course_time_data[i]["to_time"].split(".");

                                            if (course_time_data[i]["instructor_code"] != $("#hdn_user_id").val()) {
                                                bcolor = "#E68200";
                                                bordercolor = "#E68200";

                                            }

                                            for (loop = start.getTime(); loop < end.getTime(); loop = loop + one_day) {

                                                var column_date = new Date(loop);

                                                if (column_date.getDay() == course_time_data[i]["day_code"]) {

                                                    events.push
                                                                                ({
                                                                                    id1: 'timetable',
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

                                                                    var event = "(No title)";

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
                                                                        event = time_table_data[i]["event"];
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
                                                                    else if (time_table_data[i]["is_repeated"] == 'Y') {

                                                                        var frequency = time_table_data[i]["frequency"];
                                                                        var occurence = time_table_data[i]["occurrences_count"];
                                                                        var interval = time_table_data[i]["interval"];
                                                                        var bymonthday = time_table_data[i]["bymonthday"];
                                                                        var offset = time_table_data[i]["offeset"];

                                                                        var from_dt = new Date(from_date);
                                                                        var to_dt;

                                                                        if (time_table_data[i]["end_never"] == "Y") {

                                                                            to_dt = new Date(end);
                                                                        }
                                                                        else {

                                                                            to_dt = new Date(to_date);
                                                                        }

                                                                        var occurence_count = 0;

                                                                        //                                            for (loop = start.getTime(); loop < end.getTime(); loop = loop + one_day) {

                                                                        //                                                var column_date = new Date(loop);
                                                                        //                                                var loop_date = (column_date.getMonth() + 1) + '/' + column_date.getDate() + '/' + column_date.getFullYear();

                                                                        //                                                if ((time_table_data[i]["repeated_days"].search(column_date.getDay()) != -1)) {

                                                                        for (var check = from_dt.getTime(); check <= to_dt.getTime(); check = check + one_day) {

                                                                            var final_event_flag = "N";

                                                                            var check_day = new Date(check);

                                                                            var startdate = check_day.getFullYear() + '/' + (check_day.getMonth() + 1) + '/' + check_day.getDate() + ' ' + time_table_data[i]["from_time"] + ':00';

                                                                            var enddate = check_day.getFullYear() + '/' + (check_day.getMonth() + 1) + '/' + check_day.getDate() + ' ' + time_table_data[i]["to_time"] + ':00';
                                                                            var date1 = (check_day.getMonth() + 1) + '/' + check_day.getDate() + '/' + check_day.getFullYear();
                                                                            // we're in Moday, create the event


                                                                            if (frequency == "Weekly" || frequency == "Daily") {
                                                                                if ((time_table_data[i]["repeated_days"].search(check_day.getDay()) != -1))
                                                                                // if ((time_table_data[i]["repeated_days"].search(check_day.getDay()) != -1) && (loop_date == date1)) 
                                                                                {
                                                                                    final_event_flag = "Y";
                                                                                }

                                                                            }
                                                                            else if (frequency == "Monthly") {


                                                                                if (bymonthday != '') {
                                                                                    if (check_day.getDate() == bymonthday) {
                                                                                        final_event_flag = "Y";

                                                                                    }
                                                                                }
                                                                                else if (offset != 0) {
                                                                                    if ((time_table_data[i]["repeated_days"].search(check_day.getDay()) != -1)) {
                                                                                        var check_offset_val = parseInt(check_day.getDate()) / 7;

                                                                                        if ((parseFloat(offset) - 1) <= check_offset_val && parseFloat(offset) >= parseFloat(check_offset_val)) {
                                                                                            final_event_flag = "Y";
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                            else if (frequency == "Yearly") {
                                                                                if (check_day.getDate() == from_date.getDate() && check_day.getMonth() == from_date.getMonth()) {
                                                                                    final_event_flag = "Y";
                                                                                }
                                                                            }


                                                                            if (final_event_flag == "Y") {
                                                                                if (occurence != 0) {
                                                                                    occurence_count = parseInt(occurence_count) + parseInt(1);

                                                                                    if (parseInt(occurence_count) <= parseInt(occurence)) {
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
                                                                                else {
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
                                                                debugger;
                                                                var uploaded_calendar = JSON.parse(data.d[3]);

                                                                if (uploaded_calendar != '') {

                                                                    if (uploaded_calendar.mycalendar == "Y") {
                                                                        $(".chk_mycalendar").prop('checked', true);
                                                                    }
                                                                    if (uploaded_calendar.uploaded_calendar == "Y") {
                                                                        $(".chk_uploaded").prop('checked', true);
                                                                    }
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

                eventRender: function (event, element, view, ui) 
                {
                    if (event.title.search('birthday') != -1) {

                        element.find("div.fc-event-inner").prepend("<img src='../../image/cake.gif' width='12' height='12'>");
                    }
                },
                viewRender: function (view) {
                    $("#calendar").fullCalendar("option", "contentHeight", (view.name === "month") ? NaN : 9999);
                },
                select: function (start, end, allDay, jsEvent, view) {


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

                    $('#hdn_view').val(view.name);
                    $('#hdn_view_month').val($.fullCalendar.formatDate(view.start, 'MM-dd-yyyy'));
                    $('#btndeleteevent').css('display', 'inline-block');


                    var n = calEvent.id1.split('~');
                    if (n.length > 1) {
                        $('#txt_new_event').val('');
                        $('#spn_new_event_data').html('');
                        $("#hdneventdocnumber").val('');

                        if (n[1] == $("#hdn_user_id").val()) 
                        {

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

                        if (dayDelta == 0) {
                            if (event.repeated_start_time != event.repeated_end_time) {

                            }
                            else {
                                return revertFunc();
                            }
                        }
                        else {
                            return revertFunc();
                        }
                    }

                    $('#hdn_view').val(view.name);
                    $('#hdn_view_month').val($.fullCalendar.formatDate(view.start, 'MM-dd-yyyy'));
                    var n = event.id1.split('~');

                    if (n.length > 1) {
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

                    var flag = 'N';

                    if (event.is_repeated == 'Y') {
                        if (dayDelta == 0) {
                            if (event.repeated_start_time != event.repeated_end_time) {

                            }

                        }
                        else {
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

                    if (n.length > 1) {

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
        }

 
        
    

  
        

    </script>
</body>
</html>
