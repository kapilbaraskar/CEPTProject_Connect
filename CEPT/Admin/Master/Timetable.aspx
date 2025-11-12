<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Timetable.aspx.cs" Inherits="Admin_Master_Timetable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script type='text/javascript'>

        var cal_FA;
        var cal_FD;
        var cal_FM;
        var cal_FP;
        var cal_FT;

        $(document).ready(function () {

            //$('#tbl_main table td').css('border-style', 'none');

            var date = new Date();
            var d = date.getDate();
            var m = date.getMonth();
            var y = date.getFullYear();

            cal_FA = $('#calendar_FA').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'agendaWeek,agendaDay'
                },
                slotMinutes: 15,
                //editable: true,
                defaultView: 'agendaDay',
                isRTL: false,
                events: [
				{
				    title: 'Humanizing Cities (Sem)',
				    //resourceId: 1,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'History & Theory -I (Sem)',
				    //resourceId: 2,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Parking Management (L)',
				    //resourceId: 3,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Regional Planning and Development (L)',
                    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 13, 30),
                    end: new Date(y, m, d, 14, 30),
                    allDay: false
                },

			]
            });


//            cal_FA = $('#calendar_FA').fullCalendar({
//                header: {
//                    left: 'prev,next today',
//                    center: 'title',
//                    right: 'month,resourceAgendaWeek,resourceAgendaDay agendaWeek,agendaDay'
//                },
//                slotMinutes: 15,
//                //editable: true,
//                defaultView: 'resourceAgendaDay',
//                isRTL: false,
//                resources: [
//				{
//				    id: 1,
//				    orderIndex: 1,
//				    title: 'FA',
//				    start: new Date(y, m, d, 8, 0),
//				    end: new Date(y, m, d, 20, 0),
//				    allDay: true
//				},
//				{
//				    id: 2,
//				    orderIndex: 2,
//				    title: 'FD',
//				    start: new Date(y, m, d, 8, 0),
//				    end: new Date(y, m, d, 20, 0),
//				    allDay: true
//				},
//				{
//				    id: 3,
//				    orderIndex: 10,
//				    title: 'FM',
//				    start: new Date(y, m, d, 8, 0),
//				    end: new Date(y, m, d, 20, 0),
//				    allDay: true
//				},
//				{
//				    id: 4,
//				    orderIndex: 10,
//				    title: 'FP',
//				    start: new Date(y, m, d, 8, 0),
//				    end: new Date(y, m, d, 20, 0),
//				    allDay: true
//				},
//				{
//				    id: 5,
//				    orderIndex: 10,
//				    title: 'FT',
//				    start: new Date(y, m, d, 8, 0),
//				    end: new Date(y, m, d, 20, 0),
//				    allDay: true
//				},
//			],
//                events: [
//				{
//				    title: 'Humanizing Cities (Sem)',
//				    resourceId: 1,
//				    start: new Date(y, m, d, 8, 30),
//				    end: new Date(y, m, d, 9, 30),
//				    allDay: false
//				},
//				{
//				    title: 'History & Theory -I (Sem)',
//				    resourceId: 2,
//				    start: new Date(y, m, d, 8, 30),
//				    end: new Date(y, m, d, 9, 30),
//				    allDay: false
//				},
//				{
//				    title: 'Parking Management (L)',
//				    resourceId: 3,
//				    start: new Date(y, m, d, 8, 30),
//				    end: new Date(y, m, d, 9, 30),
//				    allDay: false
//				},
//				{
//				    title: 'Regional Planning and Development (L)',
//				    resourceId: 4,
//				    start: new Date(y, m, d, 8, 30),
//				    end: new Date(y, m, d, 9, 30),
//				    allDay: false
//				},
//                {
//                    title: 'Industrial Ecology (L)',
//                    resourceId: 4,
//                    start: new Date(y, m, d, 8, 30),
//                    end: new Date(y, m, d, 9, 30),
//                    allDay: false
//                },
//                {
//                    title: 'Integrated Energy Management (L)',
//                    resourceId: 4,
//                    start: new Date(y, m, d, 8, 30),
//                    end: new Date(y, m, d, 9, 30),
//                    allDay: false
//                },
//				{
//				    title: 'Regional Planning and Development (L)',
//				    resourceId: 4,
//				    start: new Date(y, m, d, 8, 30),
//				    end: new Date(y, m, d, 9, 30),
//				    allDay: false
//				},
//                {
//                    title: 'Industrial Ecology (L)',
//                    resourceId: 4,
//                    start: new Date(y, m, d, 8, 30),
//                    end: new Date(y, m, d, 9, 30),
//                    allDay: false
//                },
//                {
//                    title: 'Integrated Energy Management (L)',
//                    resourceId: 4,
//                    start: new Date(y, m, d, 8, 30),
//                    end: new Date(y, m, d, 9, 30),
//                    allDay: false
//                },

//			]
//            });


            date = new Date();
            d = date.getDate();
            m = date.getMonth();
            y = date.getFullYear();

            cal_FD = $('#calendar_FD').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                slotMinutes: 15,
                //editable: true,
                defaultView: 'agendaDay',
                isRTL: false,
                events: [
				{
				    title: 'Humanizing Cities (Sem)',
				    //resourceId: 1,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'History & Theory -I (Sem)',
				    //resourceId: 2,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Parking Management (L)',
				    //resourceId: 3,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 13, 30),
                    end: new Date(y, m, d, 14, 30),
                    allDay: false
                },

			]
            });

            date = new Date();
            d = date.getDate();
            m = date.getMonth();
            y = date.getFullYear();

            cal_FP = $('#calendar_FP').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,resourceAgendaWeek,resourceAgendaDay agendaWeek,agendaDay'
                },
                slotMinutes: 15,
                //editable: true,
                defaultView: 'agendaDay',
                isRTL: false,
                events: [
				{
				    title: 'Humanizing Cities (Sem)',
				    //resourceId: 1,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'History & Theory -I (Sem)',
				    //resourceId: 2,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Parking Management (L)',
				    //resourceId: 3,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 13, 30),
                    end: new Date(y, m, d, 14, 30),
                    allDay: false
                },

			]
            });

            date = new Date();
            d = date.getDate();
            m = date.getMonth();
            y = date.getFullYear();

            cal_FM = $('#calendar_FM').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,resourceAgendaWeek,resourceAgendaDay agendaWeek,agendaDay'
                },
                slotMinutes: 15,
                //editable: true,
                defaultView: 'agendaDay',
                isRTL: false,
                events: [
				{
				    title: 'Humanizing Cities (Sem)',
				    //resourceId: 1,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'History & Theory -I (Sem)',
				    //resourceId: 2,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Parking Management (L)',
				    //resourceId: 3,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 13, 30),
                    end: new Date(y, m, d, 14, 30),
                    allDay: false
                },

			]
            });

            date = new Date();
            d = date.getDate();
            m = date.getMonth();
            y = date.getFullYear();

            cal_FT = $('#calendar_FT').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                slotMinutes: 15,
                //editable: true,
                defaultView: 'agendaDay',
                isRTL: false,
                events: [
				{
				    title: 'Humanizing Cities (Sem)',
				    //resourceId: 1,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'History & Theory -I (Sem)',
				    //resourceId: 2,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Parking Management (L)',
				    //resourceId: 3,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
				{
				    title: 'Regional Planning and Development (L)',
				    //resourceId: 4,
				    start: new Date(y, m, d, 8, 30),
				    end: new Date(y, m, d, 9, 30),
				    allDay: false
				},
                {
                    title: 'Industrial Ecology (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 8, 30),
                    end: new Date(y, m, d, 9, 30),
                    allDay: false
                },
                {
                    title: 'Integrated Energy Management (L)',
                    //resourceId: 4,
                    start: new Date(y, m, d, 13, 30),
                    end: new Date(y, m, d, 14, 30),
                    allDay: false
                },

			]
            });
        });

    </script>--%>

    <script type='text/javascript'>
        var t_data;
        var t_data_FA;
        var t_data_FD;
        var t_data_FM;
        var t_data_FP;
        var t_data_FT;

        $(document).ready(function () {
            //$('#tbl_main table td').css('border-style', 'none');

            bindsemdata();
            bindyeardata_for_cross_reg();

            //$('#btn_print').on('click', function () {
            //    var mywindow = window.open('', 'print_data', 'height=600,width=800');

            //    mywindow.document.write('<html><head><title>print_data</title>');
            //    //mywindow.document.write(' <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
            //                            

            //    mywindow.document.write('</head><body>');
            //    mywindow.document.write($('#div_tbl_main').html());
            //    mywindow.document.write('</body></html>');

            //    //////mywindow.document.write('<html>' + $('html').html() + '</html>');

            //    mywindow.print();
            //    //mywindow.close();

            //    return false;
            //});
        });

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

        function retrieveClick() {
            if ($('#drpsemester').val() == '') {
                bootbox.alert('Please select Semester');
                return false;
            }

            if ($('#drpyear').val() == '') {
                bootbox.alert('Please select Year');
                return false;
            }

            get_timetableData();
        }

        function get_timetableData() {
            clearTables();

            // Returned By Ananth ////
            if ($("#drpdepartment").val() != '') {
                if ($("#drp_prog").val() == '') {
                    bootbox.alert("Please Select Program");
                    clearTables();
                    return false;
                }
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_timetableData",
                data: "{sem_code:'" + $('#drpsemester').val() + "',year_code:'" + $('#drpyear').val() + "',prog_code :'" + $('#drp_prog').val() + "'}",
                dataType: "json",
                success: function (data) {
                    debugger;
                    if (data.d != "") {
                        t_data = JSON.parse(data.d);
                        if (t_data['timetable_data_FA'] != "") t_data_FA = JSON.parse(t_data['timetable_data_FA']);
                        else t_data_FA = "";

                        if (t_data['timetable_data_FD'] != "") t_data_FD = JSON.parse(t_data['timetable_data_FD']);
                        else t_data_FD = "";

                        if (t_data['timetable_data_FM'] != "") t_data_FM = JSON.parse(t_data['timetable_data_FM']);
                        else t_data_FM = "";

                        if (t_data['timetable_data_FP'] != "") t_data_FP = JSON.parse(t_data['timetable_data_FP']);
                        else t_data_FP = "";

                        if (t_data['timetable_data_FT'] != "") t_data_FT = JSON.parse(t_data['timetable_data_FT']);
                        else t_data_FT = "";

                        setData();
                        if (data.d == "") {
                            clearTables();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function setData() {

            if ($('#drpdepartment').val() == "") {

                setData_alltimetables();
            }
            else {
                $("#all_dept_timetable").css("display", "block");

                $("#fa_time_tbl").css("display", "none");
                $("#fd_time_tbl").css("display", "none");
                $("#fm_time_tbl").css("display", "none");
                $("#fp_time_tbl").css("display", "none");
                $("#ft_time_tbl").css("display", "none");
                switch ($('#drpdepartment').val()) {
                    case 'FA':
                        setData_FA();
                        break;
                    case 'FD':
                        setData_FD();
                        break;
                    case 'FM':
                        setData_FM();
                        break;
                    case 'FP':
                        setData_FP();
                        break;
                    case 'FT':
                        setData_FT();
                        break;
                }
            }
        }

        function setData_FA() {
            clearTables();
            for (var i = 0; i < t_data_FA.length; i++) {
                var day='';
                switch (t_data_FA[i]['day_code']) {
                    case '1': day = 'mon'; break;
                    case '2': day = 'tue'; break;
                    case '3': day = 'wed'; break;
                    case '4': day = 'thu'; break;
                    case '5': day = 'fri'; break;
                    case '6': day = 'sat'; break;
                }
                var time = parseInt(t_data_FA[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FA[i]['course_name'] + "</td><td>" + t_data_FA[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FA[i]['total_hours']); j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FA[i]['course_name'] + "</td><td>" + t_data_FA[i]['room_id'] + "</td></tr>");
                }
            }
        }

        function setData_FD() {
            clearTables();
            for (var i = 0; i < t_data_FD.length; i++) {
                var day = '';
                switch (t_data_FD[i]['day_code']) {
                    case '1': day = 'mon'; break;
                    case '2': day = 'tue'; break;
                    case '3': day = 'wed'; break;
                    case '4': day = 'thu'; break;
                    case '5': day = 'fri'; break;
                    case '6': day = 'sat'; break;
                }
                var time = parseInt(t_data_FD[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FD[i]['course_name'] + "</td><td>" + t_data_FD[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FD[i]['total_hours']); j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FD[i]['course_name'] + "</td><td>" + t_data_FD[i]['room_id'] + "</td></tr>");
                }
            }
        }

        function setData_FM() {
            clearTables();
            for (var i = 0; i < t_data_FM.length; i++) {
                var day = '';
                switch (t_data_FM[i]['day_code']) {
                    case '1': day = 'mon'; break;
                    case '2': day = 'tue'; break;
                    case '3': day = 'wed'; break;
                    case '4': day = 'thu'; break;
                    case '5': day = 'fri'; break;
                    case '6': day = 'sat'; break;
                }
                var time = parseInt(t_data_FM[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FM[i]['course_name'] + "</td><td>" + t_data_FM[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FM[i]['total_hours']); j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FM[i]['course_name'] + "</td><td>" + t_data_FM[i]['room_id'] + "</td></tr>");
                }
            }
        }

        function setData_FP() {
            clearTables();
            for (var i = 0; i < t_data_FP.length; i++) {
                var day = '';
                switch (t_data_FP[i]['day_code']) {
                    case '1': day = 'mon'; break;
                    case '2': day = 'tue'; break;
                    case '3': day = 'wed'; break;
                    case '4': day = 'thu'; break;
                    case '5': day = 'fri'; break;
                    case '6': day = 'sat'; break;
                }
                var time = parseInt(t_data_FP[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FP[i]['course_name'] + "</td><td>" + t_data_FP[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FP[i]['total_hours']); j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FP[i]['course_name'] + "</td><td>" + t_data_FP[i]['room_id'] + "</td></tr>");
                }
            }
        }

        function setData_FT() {
            clearTables();
            for (var i = 0; i < t_data_FT.length; i++) {
                var day = '';
                switch (t_data_FT[i]['day_code']) {
                    case '1': day = 'mon'; break;
                    case '2': day = 'tue'; break;
                    case '3': day = 'wed'; break;
                    case '4': day = 'thu'; break;
                    case '5': day = 'fri'; break;
                    case '6': day = 'sat'; break;
                }
                var time = parseInt(t_data_FT[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FT[i]['course_name'] + "</td><td>" + t_data_FT[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FT[i]['total_hours']); j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FT[i]['course_name'] + "</td><td>" + t_data_FT[i]['room_id'] + "</td></tr>");
                }
            }
        }

        function clearTables() {
            for (var i = 830; i <= 1930; i = i + 100) {
                $('#mon_' + i + ' tbody').html('');
                $('#tue_' + i + ' tbody').html('');
                $('#wed_' + i + ' tbody').html('');
                $('#thu_' + i + ' tbody').html('');
                $('#fri_' + i + ' tbody').html('');
                $('#sat_' + i + ' tbody').html('');
            }
        }

        function setData_alltimetables() {
            debugger;
            clearTables();

            $("#all_dept_timetable").css("display", "none");

            $("#fa_time_tbl").css("display", "block");
            $("#fd_time_tbl").css("display", "block");
            $("#fm_time_tbl").css("display", "block");
            $("#fp_time_tbl").css("display", "block");
            $("#ft_time_tbl").css("display", "block");

            for (var i = 0; i < t_data_FA.length; i++) {
                var day = '';
                switch (t_data_FA[i]['day_code']) {
                    case '1': day = 'fa_mon'; break;
                    case '2': day = 'fa_tue'; break;
                    case '3': day = 'fa_wed'; break;
                    case '4': day = 'fa_thu'; break;
                    case '5': day = 'fa_fri'; break;
                    case '6': day = 'fa_sat'; break;
                }
                var time = parseInt(t_data_FA[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FA[i]['course_name'] + "</td><td>" + t_data_FA[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FA[i]['total_hours']) ; j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FA[i]['course_name'] + "</td><td>" + t_data_FA[i]['room_id'] + "</td></tr>");
                }
            }

            for (var i = 0; i < t_data_FD.length; i++) {
                var day = '';
                switch (t_data_FD[i]['day_code']) {
                    case '1': day = 'fd_mon'; break;
                    case '2': day = 'fd_tue'; break;
                    case '3': day = 'fd_wed'; break;
                    case '4': day = 'fd_thu'; break;
                    case '5': day = 'fd_fri'; break;
                    case '6': day = 'fd_sat'; break;
                }
                var time = parseInt(t_data_FD[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FD[i]['course_name'] + "</td><td>" + t_data_FD[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FD[i]['total_hours']) ; j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FD[i]['course_name'] + "</td><td>" + t_data_FD[i]['room_id'] + "</td></tr>");
                }
            }

            for (var i = 0; i < t_data_FM.length; i++) {
                var day = '';
                switch (t_data_FM[i]['day_code']) {
                    case '1': day = 'fm_mon'; break;
                    case '2': day = 'fm_tue'; break;
                    case '3': day = 'fm_wed'; break;
                    case '4': day = 'fm_thu'; break;
                    case '5': day = 'fm_fri'; break;
                    case '6': day = 'fm_sat'; break;
                }
                var time = parseInt(t_data_FM[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FM[i]['course_name'] + "</td><td>" + t_data_FM[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FM[i]['total_hours']) ; j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FM[i]['course_name'] + "</td><td>" + t_data_FM[i]['room_id'] + "</td></tr>");
                }
            }

            for (var i = 0; i < t_data_FP.length; i++) {
                var day = '';
                switch (t_data_FP[i]['day_code']) {
                    case '1': day = 'fp_mon'; break;
                    case '2': day = 'fp_tue'; break;
                    case '3': day = 'fp_wed'; break;
                    case '4': day = 'fp_thu'; break;
                    case '5': day = 'fp_fri'; break;
                    case '6': day = 'fp_sat'; break;
                }
                var time = parseInt(t_data_FP[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FP[i]['course_name'] + "</td><td>" + t_data_FP[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FP[i]['total_hours']) ; j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FP[i]['course_name'] + "</td><td>" + t_data_FP[i]['room_id'] + "</td></tr>");
                }
            }

            for (var i = 0; i < t_data_FT.length; i++) {
                var day = '';
                switch (t_data_FT[i]['day_code']) {
                    case '1': day = 'ft_mon'; break;
                    case '2': day = 'ft_tue'; break;
                    case '3': day = 'ft_wed'; break;
                    case '4': day = 'ft_thu'; break;
                    case '5': day = 'ft_fri'; break;
                    case '6': day = 'ft_sat'; break;
                }
                var time = parseInt(t_data_FT[i]['Replaced']);
                $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FT[i]['course_name'] + "</td><td>" + t_data_FT[i]['room_id'] + "</td></tr>");

                for (var j = parseInt(t_data_FT[i]['total_hours']) ; j > 1; j--) {
                    time = time + 100;
                    $('#' + day + '_' + time + ' tbody').append("<tr><td>" + t_data_FT[i]['course_name'] + "</td><td>" + t_data_FT[i]['room_id'] + "</td></tr>");
                }
            }

        }

    </script>
    <style type="text/css">
        .table-striped>tbody>tr:nth-of-type(odd)
        {
            background-color:#f9f9f9;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;&nbsp;Timetable
            </h1>
        </div>
    </div>
    <%--<div id="div_tab" class="tabbable" style="display: none; width: 100%; margin-bottom: 20px;">
        <div id="div_myTab">
            <ul class="nav nav-tabs" id="myTab">
                <li class="active"><a data-toggle="tab" href="#div_calendar_FA">FA&nbsp;</a></li>
                <li><a data-toggle="tab" href="#div_calendar_FD">FD &nbsp; </a></li>
                <li><a data-toggle="tab" href="#div_calendar_FM">FM &nbsp; </a></li>
                <li><a data-toggle="tab" href="#div_calendar_FP">FP &nbsp; </a></li>
                <li><a data-toggle="tab" href="#div_calendar_FT">FT &nbsp; </a></li>
            </ul>
        </div>
        <div class="tab-content">
            <div id="div_calendar_FA" class="tab-pane in active">
                <div id='calendar_FA'>
                </div>
            </div>
            <div id="div_calendar_FD" class="tab-pane">
                <div id='calendar_FD'>
                </div>
            </div>
            <div id="div_calendar_FM" class="tab-pane">
                <div id='calendar_FM'>
                </div>
            </div>
            <div id="div_calendar_FP" class="tab-pane">
                <div id='calendar_FP'>
                </div>
            </div>
            <div id="div_calendar_FT" class="tab-pane">
                <div id='calendar_FT'>
                </div>
            </div>
        </div>
    </div>--%>

    <div class="panel panel-default">
        <div class="panel-heading"><b>Department Selection</b></div>
        <div class="panel-body">
            <%--<div class="row">
                <div class="form-group col-md-10">
                    <div class="col-sm-2 col-xs-3" style="padding:0 0 0 0;">Department</div>
                    <div class="col-sm-8 col-xs-8" style="padding:0 0 0 0;">
                        <select class="chosen-select" id="drpdepartment">
                            <option value="FA">Architecture</option>
                            <option value="FD">Design</option>
                            <option value="FM">Management</option>
                            <option value="FP">Planning</option>
                            <option value="FT">Technology</option>
                        </select>
                    </div>
                </div>
            </div>--%>

            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div class="form-group col-md-4">
                        <div class="col-md-3" style="padding:0 0 0 0;">Semester</div>
                        <div class="col-md-9" style="padding:0 0 0 0;">
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-4">
                        <div class="col-md-3" style="padding:0 0 0 0;">Year</div>
                        <div class="col-md-9" style="padding:0 0 0 0;">
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </div>
                    </div>
                </div>
                
                <div class="row" style="margin-top:15px;">
                    <div class="form-group col-md-4">
                        <div class="col-md-3" style="padding:0 0 0 0;">Department</div>
                        <div class="col-md-9" style="padding:0 0 0 0;">
                            <select class="chosen-select" id="drpdepartment">
                                <option value="">-- Please Select Department --</option>
                                <option value="FA">Architecture</option>
                                <option value="FD">Design</option>
                                <option value="FM">Management</option>
                                <option value="FP">Planning</option>
                                <option value="FT">Technology</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group col-md-4">
                        <div class="col-md-3" style="padding:0 0 0 0;">Program</div>
                        <div class="col-md-9" style="padding:0 0 0 0;">
                            <select class="chosen-select" id="drp_prog">
                            <option value="">-- Please Select Program --</option>
                            <option value="1">UG</option>
                            <option value="2">PG</option>
                            <option value="3">Doctoral</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group col-md-4">
                        <button class="btn btn-primary" type="button" id="btnRetrieve" onclick="retrieveClick()">
                            <i class="icon-calendar"></i>&nbsp; Retrieve
                        </button>
                        <%--<button class="btn btn-primary" type="button" id="btn_print" style="margin-left:30px;">
                            <i class="icon-print"></i>&nbsp; Print
                        </button>--%>
                    </div>

                </div> 
            </div>
        </div>
    </div>

    <div class="panel panel-default" id="all_dept_timetable" style="overflow:auto">
        <div class="panel-heading"><b>TimeTable</b></div>
        
        <div id="div_tbl_main">
        <table id="tbl_main" class="table table-bordered">
            <tbody>
                <tr>
                    <th></th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                </tr>
                <tr>
                    <td>
                        8:30-9:30
                    </td>
                    <td>
                        <table id="mon_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        9:30-10:30
                    </td>
                    <td>
                        <table id="mon_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        10:30-11:30
                    </td>
                    <td>
                        <table id="mon_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        11:30-12:30
                    </td>
                    <td>
                        <table id="mon_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        12:30-13:30
                    </td>
                    <td>
                        <table id="mon_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        13:30-14:30
                    </td>
                    <td>
                        <table id="mon_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        14:30-15:30
                    </td>
                    <td>
                        <table id="mon_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        15:30-16:30
                    </td>
                    <td>
                        <table id="mon_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        16:30-17:30
                    </td>
                    <td>
                        <table id="mon_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        17:30-18:30
                    </td>
                    <td>
                        <table id="mon_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        18:30-19:30
                    </td>
                    <td>
                        <table id="mon_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="tue_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="wed_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="thu_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fri_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="sat_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
        </table>
        </div>

        <%--<table id="Table1" style="border-style: solid;border-width: 2px;text-align: center;">--%>
        <%--<table id="Table1" class="table table-bordered table-striped">--%>
        <%--<table id="tbl_main" class="table table-bordered">
            <tr>
                <th></th>
                <th>Monday</th>
                <th>Tuesday</th>
                <th>Wednesday</th>
                <th>Thursday</th>
                <th>Friday</th>
                <th>Saturday</th>
            </tr>
            <tr>
                <td>
                    8:30-9:30
                </td>
                <td>
                    <table id="mon_830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                
                <td>
                    <table id="tue_830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    9:30-10:30
                </td>
                <td>
                    <table id="mon_930">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_930">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_930">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_930">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_930">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_930">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    10:30-11:30
                </td>
                
                <td>
                    <table id="mon_1030">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1030">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1030">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1030">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1030">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1030">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    11:30-12:30
                </td>
                
                <td>
                    <table id="mon_1130">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1130">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1130">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1130">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1130">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1130">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    12:30-13:30
                </td>
                
                <td>
                    <table id="mon_1230">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1230">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1230">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1230">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1230">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1230">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    13:30-14:30
                </td>
                
                <td>
                    <table id="mon_1330">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1330">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1330">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1330">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1330">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1330">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    14:30-15:30
                </td>
                
                <td>
                    <table id="mon_1430">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1430">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1430">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1430">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1430">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1430">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    15:30-16:30
                </td>
                
                <td>
                    <table id="mon_1530">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1530">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1530">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1530">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1530">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1530">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    16:30-17:30
                </td>
                
                <td>
                    <table id="mon_1630">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1630">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1630">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1630">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1630">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1630">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    17:30-18:30
                </td>
                
                <td>
                    <table id="mon_1730">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1730">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1730">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1730">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1730">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1730">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    18:30-19:30
                </td>
                
                <td>
                    <table id="mon_1830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="tue_1830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="wed_1830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="thu_1830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="fri_1830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table id="sat_1830">
                        <tr>
                            <td>Course</td>
                            <td>#101</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>--%>
    </div>

    <div class="panel panel-default" id="fa_time_tbl" style="overflow:auto;display:none;height:625px;">
        <div class="panel-heading"><b>TimeTable for Faculty of Architecture</b></div>
            <div id="div_fa_tbl_main">
                <table id="fa_tbl_main" class="table table-bordered">
                    <tbody>
                <tr>
                    <th></th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                </tr>
                <tr>
                    <td>
                        8:30-9:30
                    </td>
                    <td>
                        <table id="fa_mon_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        9:30-10:30
                    </td>
                    <td>
                        <table id="fa_mon_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        10:30-11:30
                    </td>
                    <td>
                        <table id="fa_mon_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        11:30-12:30
                    </td>
                    <td>
                        <table id="fa_mon_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        12:30-13:30
                    </td>
                    <td>
                        <table id="fa_mon_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        13:30-14:30
                    </td>
                    <td>
                        <table id="fa_mon_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        14:30-15:30
                    </td>
                    <td>
                        <table id="fa_mon_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        15:30-16:30
                    </td>
                    <td>
                        <table id="fa_mon_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        16:30-17:30
                    </td>
                    <td>
                        <table id="fa_mon_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        17:30-18:30
                    </td>
                    <td>
                        <table id="fa_mon_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        18:30-19:30
                    </td>
                    <td>
                        <table id="fa_mon_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_tue_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_wed_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_thu_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_fri_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fa_sat_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
                </table>
            </div>
	    </div>

    <div class="panel panel-default" id="fd_time_tbl" style="overflow:auto;display:none;height:625px;">
        <div class="panel-heading"><b>TimeTable for Faculty of Design</b></div>
            <div id="div_fd_tbl_main">
                <table id="fd_tbl_main" class="table table-bordered">
                    <tbody>
                <tr>
                    <th></th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                </tr>
                <tr>
                    <td>
                        8:30-9:30
                    </td>
                    <td>
                        <table id="fd_mon_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        9:30-10:30
                    </td>
                    <td>
                        <table id="fd_mon_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        10:30-11:30
                    </td>
                    <td>
                        <table id="fd_mon_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        11:30-12:30
                    </td>
                    <td>
                        <table id="fd_mon_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        12:30-13:30
                    </td>
                    <td>
                        <table id="fd_mon_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        13:30-14:30
                    </td>
                    <td>
                        <table id="fd_mon_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        14:30-15:30
                    </td>
                    <td>
                        <table id="fd_mon_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        15:30-16:30
                    </td>
                    <td>
                        <table id="fd_mon_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        16:30-17:30
                    </td>
                    <td>
                        <table id="fd_mon_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        17:30-18:30
                    </td>
                    <td>
                        <table id="fd_mon_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        18:30-19:30
                    </td>
                    <td>
                        <table id="fd_mon_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_tue_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_wed_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_thu_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_fri_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fd_sat_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
                </table>
            </div>
	    </div>

    <div class="panel panel-default" id="fm_time_tbl" style="overflow:auto;display:none;height:625px;">
        <div class="panel-heading"><b>TimeTable for Faculty of Management</b></div>
            <div id="div_fm_tbl_main">
                <table id="fm_tbl_main" class="table table-bordered">
                    <tbody>
                <tr>
                    <th></th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                </tr>
                <tr>
                    <td>
                        8:30-9:30
                    </td>
                    <td>
                        <table id="fm_mon_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        9:30-10:30
                    </td>
                    <td>
                        <table id="fm_mon_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        10:30-11:30
                    </td>
                    <td>
                        <table id="fm_mon_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        11:30-12:30
                    </td>
                    <td>
                        <table id="fm_mon_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        12:30-13:30
                    </td>
                    <td>
                        <table id="fm_mon_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        13:30-14:30
                    </td>
                    <td>
                        <table id="fm_mon_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        14:30-15:30
                    </td>
                    <td>
                        <table id="fm_mon_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        15:30-16:30
                    </td>
                    <td>
                        <table id="fm_mon_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        16:30-17:30
                    </td>
                    <td>
                        <table id="fm_mon_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        17:30-18:30
                    </td>
                    <td>
                        <table id="fm_mon_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        18:30-19:30
                    </td>
                    <td>
                        <table id="fm_mon_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_tue_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_wed_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_thu_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_fri_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fm_sat_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
                </table>
            </div>
	    </div>

    <div class="panel panel-default" id="fp_time_tbl" style="overflow:auto;display:none;height:625px;">
        <div class="panel-heading"><b>TimeTable for Faculty of Planning</b></div>
            <div id="div_fp_tbl_main">
                <table id="fp_tbl_main" class="table table-bordered">
                    <tbody>
                <tr>
                    <th></th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                </tr>
                <tr>
                    <td>
                        8:30-9:30
                    </td>
                    <td>
                        <table id="fp_mon_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        9:30-10:30
                    </td>
                    <td>
                        <table id="fp_mon_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        10:30-11:30
                    </td>
                    <td>
                        <table id="fp_mon_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        11:30-12:30
                    </td>
                    <td>
                        <table id="fp_mon_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        12:30-13:30
                    </td>
                    <td>
                        <table id="fp_mon_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        13:30-14:30
                    </td>
                    <td>
                        <table id="fp_mon_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        14:30-15:30
                    </td>
                    <td>
                        <table id="fp_mon_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        15:30-16:30
                    </td>
                    <td>
                        <table id="fp_mon_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        16:30-17:30
                    </td>
                    <td>
                        <table id="fp_mon_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        17:30-18:30
                    </td>
                    <td>
                        <table id="fp_mon_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        18:30-19:30
                    </td>
                    <td>
                        <table id="fp_mon_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_tue_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_wed_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_thu_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_fri_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="fp_sat_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
                </table>
            </div>
	    </div>

    <div class="panel panel-default" id="ft_time_tbl" style="overflow:auto;display:none;height:625px;">
        <div class="panel-heading"><b>TimeTable for Faculty of Technology</b></div>
            <div id="div_ft_tbl_main">
                <table id="ft_tbl_main" class="table table-bordered">
                    <tbody>
                <tr>
                    <th></th>
                    <th>Monday</th>
                    <th>Tuesday</th>
                    <th>Wednesday</th>
                    <th>Thursday</th>
                    <th>Friday</th>
                    <th>Saturday</th>
                </tr>
                <tr>
                    <td>
                        8:30-9:30
                    </td>
                    <td>
                        <table id="ft_mon_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        9:30-10:30
                    </td>
                    <td>
                        <table id="ft_mon_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_930">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        10:30-11:30
                    </td>
                    <td>
                        <table id="ft_mon_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1030">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        11:30-12:30
                    </td>
                    <td>
                        <table id="ft_mon_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1130">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        12:30-13:30
                    </td>
                    <td>
                        <table id="ft_mon_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1230">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        13:30-14:30
                    </td>
                    <td>
                        <table id="ft_mon_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1330">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        14:30-15:30
                    </td>
                    <td>
                        <table id="ft_mon_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1430">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        15:30-16:30
                    </td>
                    <td>
                        <table id="ft_mon_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1530">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        16:30-17:30
                    </td>
                    <td>
                        <table id="ft_mon_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1630">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        17:30-18:30
                    </td>
                    <td>
                        <table id="ft_mon_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1730">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        18:30-19:30
                    </td>
                    <td>
                        <table id="ft_mon_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_tue_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_wed_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_thu_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_fri_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                    <td>
                        <table id="ft_sat_1830">
                            <tbody>
                            </tbody>
                        </table>
                    </td>
                </tr>
            </tbody>
                </table>
            </div>
	    </div>
</asp:Content>
