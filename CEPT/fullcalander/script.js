
	var Calendar = {};
	Calendar.defaultEventColor = '#3366CC';

	$(document).ready(function() {

		Calendar.openCalendar = function(cal_id) {
			//$('#calendar').fullCalendar({
			//	events: "command/cal_events.php?action=get&cal_id=" + cal_id
			//});

			$('#calendar').fullCalendar('removeEvents');
			$('#calendar').fullCalendar('addEventSource', "command/cal_events.php?action=get&cal_id=" + cal_id );

			$.ajax({
				type: "POST",
				url: "command/cal_events.php?action=get_cal&cal_id=" + cal_id,
				//data: dataString,
				dataType: 'json',
				success:function(result){

					if(result.calendar_type == 'booking') {
						$('#booking').show();
						$('#dragdrop_events').hide();
					} else {
						$('#booking').hide();
						$('#dragdrop_events').show();
					}
				}
	        });
		};
		var applyToObject = function(event, result) {
			event.start 		= result.start;
			event.end 			= result.end;
			event._start 		= result.start;
			event._end 			= result.end;
			event._id 			= result.id;
			event.time_start  	= result.time_start;
			event.time_end  	= result.time_end;
			event.color		  	= result.color;
       		event.allDay		= result.allDay;

       		return event;
		};

		$('#timepicker_starttime').timepicker({
			showPeriodLabels: false,
			hourText: Lang.Popup.TimepickerHourtext,
    		minuteText: Lang.Popup.TimepickerMinutetext,
    		showCloseButton: true,       						// shows an OK button to confirm the edit
		    closeButtonText: Lang.Popup.TimepickercloseButtonText,      // Text for the confirmation button (ok button)
		    showNowButton: true,         						// Shows the 'now' button
		    nowButtonText: Lang.Popup.TimepickernowButtonText,
    		hours: {
		        starts: Calendar.timePickerMinHour,                		// First displayed hour
		        ends: Calendar.timePickerMaxHour                  		// Last displayed hour
		    },
		    minutes: {
		        starts: 0,                					// First displayed minute
		        ends: 55,                 					// Last displayed minute
		        interval: Calendar.timePickerMinuteInterval               // Interval of displayed minutes
		    }
		});
		$('#timepicker_endtime').timepicker({
			showPeriodLabels: false,
			hourText: Lang.Popup.TimepickerHourtext,
    		minuteText: Lang.Popup.TimepickerMinutetext,
    			showCloseButton: true,       						// shows an OK button to confirm the edit
		    closeButtonText: Lang.Popup.TimepickercloseButtonText,      // Text for the confirmation button (ok button)
		    showNowButton: true,         						// Shows the 'now' button
		    nowButtonText: Lang.Popup.TimepickernowButtonText,
    		hours: {
		        starts: Calendar.timePickerMinHour,                		// First displayed hour
		        ends: Calendar.timePickerMaxHour                  		// Last displayed hour
		    },
		    minutes: {
		        starts: 0,                					// First displayed minute
		        ends: 55,                 					// Last displayed minute
		        interval: Calendar.timePickerMinuteInterval               // Interval of displayed minutes
		    }
		});

		$( "#datepicker_startdate" ).datepicker({
			dateFormat: 'dd/mm/yy'
		});

		$( "#datepicker_enddate" ).datepicker({
			dateFormat: 'dd/mm/yy'
		});

		$('#ColorPicker1').empty().addColorPicker({
			clickCallback: function(elem,c) {
				$('#ColorSelectionTarget1').css('background-color',c);
				Calendar.defaultEventColor = elem.attr('color');
			}
		});
		$('#ColorSelectionTarget1').css('background-color',Calendar.defaultEventColor);

		var calAlert = function() {
			$( "#dialog:ui-dialog" ).dialog( "destroy" );
			$( "#dialog-message" ).dialog({
				modal: true,
				buttons: {
					Ok: function() {
						$( this ).dialog( "close" );
					}
				}
			});
		};
		var disableTimeCombos = function() {
			$('#timepicker_starttime').attr('disabled', 'disabled');
			$('#timepicker_endtime').attr('disabled', 'disabled');
		};
		var enableTimeCombos = function() {
			$('#timepicker_starttime').removeAttr('disabled');
			$('#timepicker_endtime').removeAttr('disabled');
		};
		$('#allday_checkbox').click(function(t){
			if(t.currentTarget.checked == false) {
				$('#timepicker_starttime').removeAttr('disabled');
				$('#timepicker_endtime').removeAttr('disabled');
			} else {
				$('#timepicker_starttime').attr('disabled', 'disabled');
				$('#timepicker_endtime').attr('disabled', 'disabled');
			}
		});
		var addEvent = function(start, end) {
			var title = $('#edited_title')[0].value;
			if (title) {
        // is a date selected in the datepickers, then use those dates
				var dp_startdate 	= $( "#datepicker_startdate" ).datepicker('getDate');
				var dp_enddate 		= $( "#datepicker_enddate" ).datepicker('getDate');

				if(dp_startdate !== null && dp_enddate !== null) {
					start = dp_startdate;
					end = dp_enddate;
				}
				
				if($('#allday_checkbox').is(':checked')) {
					var startdate = Date.parse(start) / 1000;
					var enddate = Date.parse(end) / 1000;
				} else {
					var startdate 	= Date.parse(start.format('mm/dd/yyyy')+ ' ' + $('#timepicker_starttime')[0].value + ':00') / 1000;
			    	var enddate 	= Date.parse(end.format('mm/dd/yyyy')+ ' ' + $('#timepicker_endtime')[0].value + ':00') / 1000;

				}
        
        var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
        startdate = startdate - offsetClientToGMT;
        enddate = enddate - offsetClientToGMT;
      
				if(startdate <= enddate  ) {
				    // opslaan in db
					var dataString = 'title='+ title +'&date_start='+ startdate + '&date_end='+ enddate + '&color=' + Calendar.defaultEventColor;
		            $.ajax({
						type:"POST",
						url:"command/cal_events.php?action=add",
						data: dataString,
						dataType: 'json',
						success:function(result){
							result.event._id = result.event.id;
							$('#calendar').fullCalendar('refetchEvents');
						}
			        });
			    } else {
					
					$('#error_message').html(Lang.Alert.TimesNotCorrect);
			    }
			}
		};

		var updateEvent = function(event) {

			var title = $('#edited_title')[0].value;
			if(title != null && title != '') {
				event.title = title;
        
        // is a date selected in the datepickers, then use those dates
				var dp_startdate 	= $( "#datepicker_startdate" ).datepicker('getDate');
				var dp_enddate 		= $( "#datepicker_enddate" ).datepicker('getDate');

				if(dp_startdate !== null && dp_enddate !== null) {
					event.start = dp_startdate;
					event.end = dp_enddate;
				}
				
				if($('#allday_checkbox').is(':checked')) {
					var startdate = Date.parse(event.start) / 1000;
					var enddate = event.end !== null ? Date.parse(event.end) / 1000 : startdate;
					event.allDay = 1;
				} else {
					var startdate 	= Date.parse(event.start.format('mm/dd/yyyy')+ ' ' + $('#timepicker_starttime')[0].value + ':00') / 1000;
			    	var enddate 	= event.end === null ? Date.parse(event.start.format('mm/dd/yyyy')+ ' ' + $('#timepicker_endtime')[0].value + ':00') / 1000 : Date.parse(event.end.format('mm/dd/yyyy')+ ' ' + $('#timepicker_endtime')[0].value + ':00') / 1000;
					event.allDay = 0;
				}
        
        var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
        startdate = startdate - offsetClientToGMT;
        enddate = enddate - offsetClientToGMT;
        
				if(startdate <= enddate  ) {
					// opslaan in db
					var dataString = 'event_id='+ event.event_id + '&allDay=' + event.allDay  + '&title='+ event.title + '&date_start='+startdate+'&date_end='+enddate+ '&color=' + Calendar.defaultEventColor;

		            $.ajax({
			             type:"POST",
			             url:"command/cal_events.php?action=update",
			             data: dataString,
			             dataType: 'json',
						 success:function(result){
							event = applyToObject(event, result.event);

							$('#calendar').fullCalendar('updateEvent', event);
			             }
			        });
			          return true;
				} else {       
				     $('#error_message').html(Lang.Alert.TimesNotCorrect);
                     return false;
              // 	alert(Lang.Alert.TimesNotCorrect);
				}

			}
		};

		var onEventDropEvent = function(event) {
			var startdate 	= Date.parse(event.start) / 1000;
			if(event.end === null) {
	        var enddate = startdate;
	    } else {
	        var enddate 	= Date.parse(event.end) / 1000;
	    }
      var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
      startdate = startdate - offsetClientToGMT;
      enddate = enddate - offsetClientToGMT;
      
      event.allDay = event.allDay ? 1 : 0;
            // opslaan in db
      var dataString = 'event_id='+event.id + '&color=' + event.color + '&allDay=' + event.allDay +'&title='+ event.title+'&date_start='+startdate+'&date_end='+enddate;
          $.ajax({
              type:"POST",
              url:"command/cal_events.php?action=update",
              data: dataString
			});
		};
		var onSelectEvent = function(start, end, allDay) {
			$("#dialog:ui-dialog").dialog( "destroy" );
			$('#edited_title')[0].value = '';

      $( "#datepicker_startdate" ).datepicker('setDate', start); 
			$( "#datepicker_enddate" ).datepicker('setDate', end);

			var curr_hour = start.getHours();
			var curr_min = start.getMinutes();

			if(curr_hour == 0 && curr_min == 0) {
				var now = new Date();
				$('#timepicker_starttime')[0].value = dateFormat(now,'HH:00');
				$('#timepicker_endtime')[0].value	= dateFormat(now,'HH:00');
			} else {
				$('#timepicker_starttime')[0].value = dateFormat(start,'HH:MM');
				$('#timepicker_endtime')[0].value 	= dateFormat(end,'HH:MM');
			}

			// default
			$('#allday_checkbox').attr('checked', true);

			disableTimeCombos();


			$( "#dialog-message" ).dialog({
				modal: true,
				title: Lang.Popup.Title,
				height: 400,
				width: 285,
				buttons: [{
			        text: Lang.Popup.saveButtonText,
			        click: function (a,b) {
			        	var title = $('#edited_title')[0].value;
						if(title != null && title != '') {
							$( this ).dialog( "close" );
							addEvent(start, end);
						} else {
							$('#error_message').html('Text is required!');
						}

			        }
			    }, {
			        text: Lang.Popup.closeButtonText,
			        click: function () {
			            $( this ).dialog( "close" );
			        }
			    }]
			});
			$('#wholeday_label_id').html(Lang.Popup.allDayLabel);
            $('#month_label_id').html(Lang.Popup.MonthLabel );
            $('#time_label_id').html(Lang.Popup.TimeLabel );

			$('#calendar').fullCalendar('unselect');
		};

		var onMouseoverEvent = function(me, event) {
    	if(event.editable && !me.hasClass('fc-agendaList-item')) {
				/*
				 *	SHOW DELETE ICON, ALSO POSSIBLE TO SHOW AN EDIT ICON HERE
				 */
				var layer =	'<div id="events-layer" class="fc-transparent" style="position:absolute; width:100%; height:100%; top:-1px; text-align:right; z-index:100">'
							+ '<a><img src="images/delete.png" title="delete" width="14" id="delbut'+event.id+'" border="0" style="padding-right:5px; padding-top:2px;" /></a>'
							+ '</div>';

				me.append(layer);
				$("#delbut"+event.id).hide();
				$("#delbut"+event.id).fadeIn(200);
				$("#delbut"+event.id).click(function() {
					if(event.id) {
					// opslaan in db
						var dataString = 'event_id='+ event.id ;
			            $.ajax({
				             type:"POST",
				             url:"command/cal_events.php?action=del",
				             data: dataString,
				             success:function(html){}
				        });
						$('#calendar').fullCalendar('removeEvents', event.id);
					}
				});
			}
		};

		var onClickEvent = function(event) {
			if(!event.editable) {
			
				alert(Lang.Alert.NotAllowedToEdit);
			} else {

        var startdate = event.start;
        if(event.end === null) {
        	var enddate = startdate;
        } else {
        	var enddate = event.end
        }
	            
				$( "#dialog:ui-dialog" ).dialog( "destroy" );
				$('#edited_title')[0].value = event.title;

        $( "#datepicker_startdate" ).datepicker('setDate', dateFormat(Date.parse(startdate),'dd/mm/yy')); // or dateFormat(event._start,'dd/mm/yyyy')
				$( "#datepicker_enddate" ).datepicker('setDate', dateFormat(Date.parse(enddate),'dd/mm/yy'));

				$('#timepicker_starttime')[0].value = event.time_start.substring(0,5);
				$('#timepicker_endtime')[0].value = event.time_end.substring(0,5);

				if(event.allDay ) {
					$('#allday_checkbox').attr('checked', true);
					disableTimeCombos();
				} else {
					$('#allday_checkbox').attr('checked', false);
					enableTimeCombos();
				}
         		if(event.color === '') {
					event.color = Calendar.defaultEventColor;
				}
				$('#ColorSelectionTarget1').css('background-color',event.color);
				Calendar.defaultEventColor = event.color;

				$( "#dialog-message" ).dialog({
					modal: true,
					title: Lang.Popup.Title,
					height: 400,
					width: 285,
					buttons: [{
				        text: Lang.Popup.updateButtonText,
				        click: function () {
				            var title = $('#edited_title')[0].value;
						    
                        	if(title != null && title != '') {
								var bln_correct = updateEvent(event);
								if(bln_correct) {
                                    $( this ).dialog( "close" );
                                    $('#error_message').html('');
                                }
							} else {
							    $('#error_message').html('text is required!');
						    }
				        }
				    }, {
				        text: Lang.Popup.closeButtonText,
				        click: function () {
				            $( this ).dialog( "close" );
				        }
				    }]
				});
				$('#wholeday_label_id').html(Lang.Popup.allDayLabel);
               	$('#month_label_id').html(Lang.Popup.MonthLabel );
               	$('#time_label_id').html(Lang.Popup.TimeLabel );

			}
		};

		var onResizeEvent = function(event) {
			var startdate = Date.parse(event.start) / 1000;
				if(event.end === null) {
	            var enddate = startdate;
	        } else {
	            var enddate 	= Date.parse(event.end) / 1000;
	        }
      var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
      startdate = startdate - offsetClientToGMT;
      enddate = enddate - offsetClientToGMT;
      
	        // opslaan in db
			var dataString = 'event_id='+ event.event_id + '&date_start='+startdate+'&date_end='+enddate;
            $.ajax({
				type:"POST",
				url:"command/cal_events.php?action=update",
				data: dataString,
				dataType: 'json',
				success:function(result){
					event = applyToObject(event, result.event);

		       		$('#calendar').fullCalendar('updateEvent', event);
	      	    }
			});
		};

		/* initialize the external events
		-----------------------------------------------------------------*/

		$('#external-events div.external-event').each(function() {

			// create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
			// it doesn't need to have a start or end
			var eventObject = {
				title: $.trim($(this).text()) // use the element's text as the event title
			};

			// store the Event Object in the DOM element so we can get to it later
			$(this).data('eventObject', eventObject);

			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});

		});

		/* initialize the calendar
		-----------------------------------------------------------------*/

		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'list,month,agendaWeek,agendaDay,agendaList'
			},
			//showAgendaButton: true,
      editable: true,
			selectable: true,
			firstDay: 1,
			timeFormat: 'H:mm{ - H:mm} ',
			axisFormat: 'H:mm',
			monthNames: 		Lang.Fullcalendar.monthNames,
			monthNamesShort: 	Lang.Fullcalendar.monthNamesShort,
			dayNames: 			Lang.Fullcalendar.dayNames,
			dayNamesShort: 		Lang.Fullcalendar.dayNamesShort,
			buttonText: {
				prev: '&nbsp;&#9668;&nbsp;',
				next: '&nbsp;&#9658;&nbsp;',
				//prev: '<',
				//next: '>',
				prevYear: 		'&nbsp;&lt;&lt;&nbsp;',
				nextYear: 		'&nbsp;&gt;&gt;&nbsp;',
				today: 			Lang.Fullcalendar.buttonText.today,
				month: 			Lang.Fullcalendar.buttonText.month,
				week: 			Lang.Fullcalendar.buttonText.week,
				day: 			Lang.Fullcalendar.buttonText.day
			},
			timeline: true,
			
			droppable: true, // this allows things to be dropped onto the calendar !!!
			drop: function(date, allDay) { // this function is called when something is dropped

				// retrieve the dropped element's stored Event Object
				var originalEventObject = $(this).data('eventObject');

				// we need to copy it, so that multiple events don't have a reference to the same object
				var copiedEventObject = $.extend({}, originalEventObject);

				// assign it the date that was reported
				copiedEventObject.start = Date.parse(date) / 1000;
				copiedEventObject.allDay = allDay;

        if(copiedEventObject.title === undefined) {
             return false;
        }

        var offsetClientToGMT = new Date().getTimezoneOffset() * 60;
        startdate = copiedEventObject.start - offsetClientToGMT;
        
			    // save to db
				var dataString = 'title='+ copiedEventObject.title +'&date_start='+startdate;
	            $.ajax({
					type:"POST",
					url:"command/cal_events.php?action=add",
					data: dataString,
					dataType: 'json',
					success:function(result){
						result.event._id = result.event.id;


						// the last `true` argument determines if the event "sticks" (http://arshaw.com/fullcalendar/docs/event_rendering/renderEvent/)
						$('#calendar').fullCalendar('refetchEvents');
					}
		        });

				// is the "remove after drop" checkbox checked?
				if ($('#drop-remove').is(':checked')) {
					// if so, remove the element from the "Draggable Events" list
					$(this).remove();
				}

			},
			events: "command/cal_events.php?action=start",
			eventDrop: function(event, delta) {
				onEventDropEvent(event);
			},
	        selectHelper: true,
			select: function(start, end, allDay) {
				onSelectEvent(start, end, allDay);
			},
	        loading: function(bool) {
	            if (bool) {
	            	$('#loading').show();
	            } else {
	            	$('#loading').hide();
	            }
	        },
	        eventMouseover: function(event, jsEvent, view) {
				onMouseoverEvent($(this), event);
			},
			eventMouseout: function(calEvent, domEvent) {
				$("#events-layer").remove();
			},
	        eventClick: function(event, element) {
				onClickEvent(event);
			},
	        eventResize: function(event,dayDelta,minuteDelta,revertFunc) {
				onResizeEvent(event);
			 },
		    allDayDefault: false,
		    weekNumbers: true
		});
	});