<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Print.aspx.cs" Inherits="Authenticated_Pages_NFA_AMENDEMENT_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Time Table Print - CEPT</title>
    <link href="../DesignCss/fullcalendar.css" rel="stylesheet" type="text/css" />
    <%--  <link href="../DesignCss/fullcalendar.print.css" rel="stylesheet" type="text/css"
        media="print" />--%>
    <script src="../DesignJS/jquery.min.js" type="text/javascript"></script>
    <script src="../DesignJS/fullcalendar.min.js" type="text/javascript"></script>
    <style>
        .fc-header-title
        {
            /* prevents dragging outside of widget */
            display: none;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var exp;
        var time_table_data;
        var oprand;

     
     
        
    </script>
</head>
<body>
    <div class="row-fluid">
        <!--PAGE CONTENT BEGINS HERE-->
     
        <div class="span11" style="margin-top: 10px">
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
                    <%--  <div>
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
                        async:false,
                        contentType: "application/json",
                        datatype: "json",
                        success: function (data) {

                            if (data.d != "") {
                                time_table_data = JSON.parse(data.d);


                                var events = [];

                                var one_day = (24 * 60 * 60 * 1000);


                                for (var i = 0; i < time_table_data.length; i++) {


                                    var from_time = time_table_data[i]["from_time"].split(".");
                                    var to_time = time_table_data[i]["to_time"].split(".");



                                    for (loop = start.getTime(); loop < end.getTime(); loop = loop + one_day) {

                                        var column_date = new Date(loop);



                                        if (column_date.getDay() == time_table_data[i]["day_code"]) {
                                            // we're in Moday, create the event
                                            events.push
                                            ({
                                                title: time_table_data[i]["course_name"] + "\n(Room Code : " + time_table_data[i]["room_id"] + " )",
                                                start: new Date(column_date.setHours(from_time[0], from_time[1])),
                                                end: new Date(column_date.setHours(to_time[0], to_time[1])),
                                                allDay: false,
                                                borderColor: 'black',
                                                backgroundColor: 'SlateBlue',
                                                textColor: 'black'
                                            });

                                        }

                                    } // for loop

                                    // return events generated

                                }


                            }


                            callback(events);

                        },

                        Error: function (data) {

                            alert(data.d);
                        }

                    });







                },
                editable: false,
                droppable: true, // this allows things to be dropped onto the calendar !!!

                drop: function (date, allDay) { // this function is called when something is dropped

                    // retrieve the dropped element's stored Event Object
                    var originalEventObject = $(this).data('eventObject');
                    var $extraEventClass = $(this).attr('data-class');


                    // we need to copy it, so that multiple events don't have a reference to the same object
                    var copiedEventObject = $.extend({}, originalEventObject);

                    // assign it the date that was reported
                    copiedEventObject.start = date;
                    copiedEventObject.allDay = allDay;
                    if ($extraEventClass) copiedEventObject['className'] = [$extraEventClass];

                    // render the event on the calendar
                    // the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
                    $('#calendar').fullCalendar('renderEvent', copiedEventObject, true);

                    // is the "remove after drop" checkbox checked?
                    if ($('#drop-remove').is(':checked')) {
                        // if so, remove the element from the "Draggable Events" list
                        $(this).remove();
                    }

                }
		,
                selectable: false,
                selectHelper: true



            });


            window.print();

        })

        
    </script>

   <script type="text/javascript">
    
   </script>
</body>
</html>
