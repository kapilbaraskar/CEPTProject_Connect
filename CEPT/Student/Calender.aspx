<%@ Page Title="Time Table - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="Calender.aspx.cs" Inherits="Calender" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        var oTable;
        var exp;
        var time_table_data;
        var oprand;

        $(document).ready(function () {
            $('#btn_print').on('click', function () {
                //Session["ctrl"] = $('#conpanel');

                window.open('Print.aspx', 'PrintMe', 'height=600px,width=730px,scrollbars=1');

                //$('#calendar').css('width', '6.5in');
                //$('.fc-content .fc-state-highlight').css('background', '#ccc');
                //$('#calendar').fullCalendar('render');
                //bdhtml = window.document.body.innerHTML;
                //sprnstr = "0";
                //eprnstr = "<!--endprint-->";
                //prnhtml = bdhtml.substr(bdhtml.indexOf(sprnstr) + 17);
                //prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr));
                //window.document.body.innerHTML = prnhtml;
                //window.print();
                return false;
            });
        });
       
    </script>

    <style type="text/css">
        .fc-header-title
        {
            /* prevents dragging outside of widget */
            display: none;
        }
    </style>
    
    <link href="../DesignCss/fullcalendar.print.css" rel="stylesheet" type="text/css" media="print" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <!--PAGE CONTENT BEGINS HERE-->
        <div class="page-header position-relative">
            <h1>
                <i class="icon-time"></i>Time Table
            </h1>
        </div>
        <div class="span11" style="margin-top: 1px">
            <table width="100%" align="center" border="0" cellpadding="3" cellspacing="5">
                <tr>
                    <td align="right">
                        <button id="btn_print" style="height: 35px" class="btn btn-sm btn-primary">
                            <i class="icon-print bigger-160"></i>Print</button>
                    </td>
                </tr>
            </table>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <div class="space">
                </div>
                <div id="calendar" class="fc fc-ltr">
                </div>
            </div>
            <div class="span3">
                <div class="widget-box transparent">
                    <%--<div>
                        <label class="control-label" for="txtwonumber">
                            WO Number</label>
                        <div>
                             <input type="text" id="txtwonumber1" placeholder="WO Number" class="autosuggest" />
                            <select class="chosen-select" id="txtwonumber1" data-placeholder="Choose a WO...">
                            </select>
                        </div>
                    </div>--%>
                    
                    <%--<div class="widget-main" style="height: 400px; overflow: auto; z-index: 200;">
                        <div id="external-events">
                            <label>
                                <input type="checkbox" class="ace-checkbox" id="drop-remove">
                                <span class="lbl">Remove after drop</span>
                            </label>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
        <!--PAGE CONTENT ENDS HERE-->
    </div>
    <script type="text/javascript">
        $(function () {
            /* initialize the external events
            -----------------------------------------------------------------*/

            /* initialize the calendar
            -----------------------------------------------------------------*/

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            var test = [{ "start": "2013/07/11", "end": "2013/07/11", "className": "label-purple", "title": "SHIFT & LAY RCC  NP4 HUMEPIPE 1000MM DIA" }, { "start": "2013/07/13", "end": "2013/07/13", "className": "label-success", "title": "Escalation agnst increase in Fuel Price" }, { "start": "2013/07/18", "end": "2013/07/18", "className": "label-yellow", "title": "Lay&Instal of MS Pipeline,600mm" }, { "start": "2013/07/20", "end": "2013/07/20", "className": "label-important", "title": "Prvd,Lay&Jnt NP4 Hume Pipe,600mm"}];

            var calendar = $('#calendar').fullCalendar({
                buttonText: {
                    prev: '<i class="icon-chevron-left"></i>',
                    next: '<i class="icon-chevron-right"></i>'
                },
                header: {
                    left: '',
                    center: 'title',
                    right: ''
                },
                aspectRatio: 1,
                defaultView: 'agendaWeek', // add for display first Week part on page load
                allDaySlot: false,
                // firstHour: 2,
                slotMinutes: 30,
                firstDay: 1,
                minTime: 8,
                columnFormat: {
                    week: "dddd"
                },
                maxTime: '19:30',
                eventColor: '#378006',
                events: function (start, end, callback) {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/Get_time_table_data_for_student",
                        data: {},
                        contentType: "application/json",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                time_table_data = JSON.parse(data.d);
                                var events = [];
                                var one_day = (24 * 60 * 60 * 1000);
                                for (var i = 0; i < time_table_data.length; i++) {
                                    //var from_time = time_table_data[i]["from_time"].split(":");
                                    //var to_time = time_table_data[i]["to_time"].split(":");

                                    var from_time = time_table_data[i]["from_time"].split(".");
                                    var to_time = time_table_data[i]["to_time"].split(".");

                                    for (loop = start.getTime(); loop < end.getTime(); loop = loop + one_day) {
                                        var column_date = new Date(loop);

                                        if (column_date.getDay() == time_table_data[i]["day_code"]) {
                                            events.push
                                            ({
                                                title: time_table_data[i]["course_name"] + "\n(Room Id : " + time_table_data[i]["room_id"] + " )",
                                                start: new Date(column_date.setHours(from_time[0], from_time[1])),
                                                end: new Date(column_date.setHours(to_time[0], to_time[1])),
                                                allDay: false,
                                                borderColor: 'black',
                                                backgroundColor: 'SlateBlue'
                                            });
                                        }
                                    }// for loop
                                    // return events generated
                                }
                            }

                            callback(events);
                        },
                        Error: function (data) {
                            alert(data.d);
                        }
                    });

                    //$.ajax({
                    //    type: "POST",
                    //    url: 'WebService.asmx/GetFieldActivityHeader',
                    //    dataType: 'json',
                    //    contentType: "application/json",
                    //    data: {
                    //},
                    //success: function (doc) {
                    //    // alert(doc);
                    //    // alert(start);
                    //    var Result = JSON.parse(doc.d);
                    //    var events = [];
                    //    for (var i = 0; i < Result.length; i++) {

                    //        events.push(Result[i]);

                    //    }
                    //    callback(events);
                    //},
                    //Error: function (doc) {

                    //    alert(doc);
                    //}
                    //});
                },
                editable: false,
                droppable: true, // this allows things to be dropped onto the calendar !!!
                drop: function (date, allDay) { // this function is called when something is dropped
                    //alert('hi');
                    //retrieve the dropped element's stored Event Object
                    var originalEventObject = $(this).data('eventObject');
                    var $extraEventClass = $(this).attr('data-class');

                    //we need to copy it, so that multiple events don't have a reference to the same object
                    var copiedEventObject = $.extend({}, originalEventObject);

                    //assign it the date that was reported
                    copiedEventObject.start = date;
                    copiedEventObject.allDay = allDay;
                    if ($extraEventClass) copiedEventObject['className'] = [$extraEventClass];

                    //render the event on the calendar
                    //the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                    $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

                    //is the "remove after drop" checkbox checked?
                    if ($('#drop-remove').is(':checked')) {
                        // if so, remove the element from the "Draggable Events" list
                        $(this).remove();
                    }
                }
		,
                selectable: false,
                selectHelper: true

                //                select: function (start, end, allDay) {
                //                    alert(start);
                //                    alert(end);
                //                    bootbox.prompt("New Event Title:", function (title)
                //      {
                ////                        if (title !== null) 
                ////                        {
                ////                            calendar.fullCalendar('renderEvent',
                ////						{
                ////						    title: title,
                ////						    start: start,
                ////						    end: end,
                ////						    allDay: allDay
                ////						},
                ////						true // make the event "stick"
                ////					);
                //                        }
                //                    });


                //                    calendar.fullCalendar('unselect');

                //                }
                //		,
                //                eventClick: function (calEvent, jsEvent, view) {
                //                }
            });
        })
    </script>
</asp:Content>
