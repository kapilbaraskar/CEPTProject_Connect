<%@ Page Title="Dashboard - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>
        .show-grid [class^=col-] {
            padding-top: 10px;
            padding-bottom: 10px;
            border: 1px solid #ddd;
            border: 1px solid rgba(86,61,124,.2);
            list-style: none;
        }

        .glyphicon {
            margin-top: 5px;
            margin-bottom: 10px;
            font-size: 35px;
        }

        .inactive {
            color: #ccc;
            background-color: #fafafa;
        }

        .active, .inactive {
            width: 19.6% !important;
        }

        #for_I2 {
            z-index: 1;
            position: absolute;
        }

        #PAGES_CONTAINERinlineContent {
            display: flex;
            flex-direction: column;
        }

        #SITE_PAGES {
            order: 1
        }

        #Div18 {
            order: 2
        }

        table#tbl_studio thead tr th {
            text-align: center;
        }
          .tab {                    
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
        }

            .tab a {
                background-color: inherit;
                float: left;
                border: none;
                outline: none;
                cursor: pointer;
                padding: 14px 16px;
                transition: 0.3s;
                font-size: 17px;
            }

                
                .tab a:hover {
                    background-color: #ddd;
                }

                .tab a.active {
                    background-color: #ccc;
                }

        
        .tabcontent {
            display: none;
            padding: 6px 12px;
            border-top: none;
        }



        #pdclick:hover {
            text-decoration: underline;
        }
    </style>
    <script type="text/javascript">
        var oTable2, oTable_ws;
        var oTable_student, oTable_ws_student;
        var oTable_student_new;
        var oTable;
        var oTable_studio;
        var oTable_studio1;
        var oTable_studio2;
        var asInitVals = new Array();
        var block = false;
        $(document).ready(function () {
            if (getParameterByName("param") == "true" && $('#hdn_msg').val() != '') {
                bootbox.alert($('#hdn_msg').val(), function () {
                    location.replace('Home.aspx');
                });
            }

            if ($("#hdn_is_submit").val() == "Y") {
                $("#pd").css('background-color', 'white');
                block = false;
            } else {
                block = true; //uncomment this line to work logic of stop going next button - Mahroofbhai - 14 10 2020
                $("#pd").css('background-color', 'grey');
                $("#ip").addClass("inactive");
                $("#ip").removeClass("active");
                $("#sd").addClass("inactive");
                $("#sd").removeClass("active");
            }

            var url_dtl = getUrlVars();
            if (url_dtl["i"] != null && url_dtl["i"] != undefined && url_dtl["i"] != "") {
                disable_div();

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_student_course_data_for_admin_dashboard",
                        async: true,
                        data: "{course_code : '" + url_dtl["i"] + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                display_student_dtl(data.d);
                                //$('#DataList1').css('display', 'block');
                            }
                            else {
                                display_student_dtl_empty();
                            }

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });


                return false;

            }

            if (url_dtl["w"] != null && url_dtl["w"] != undefined && url_dtl["w"] != "") {
                disable_div();

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/ws_get_student_course_data_for_admin_dashboard",
                        //async: false,
                        data: "{course_code : '" + url_dtl["w"] + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                $('#allocate_ws_student_data').modal('hide');

                                //display_ws_allocate_student(data.d);
                                display_ws_student_dtl(data.d);
                            }
                            else {
                                //  bootbox.alert('No Courses Found for Pending Approval');
                                $('#allocate_ws_student_data').modal('hide');
                                display_ws_student_dtl_empty();

                            }

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;


            }


            get_instructor_course_data();

            studio_dtls(); //changes by Aashitha 10262023
            pending_dtls();


            $('#btn_print_outline').on('click', function () {
                var mywindow = window.open('', 'print_data', 'height=500,width=700');
                //mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
                mywindow.document.write('');
                //mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
                //mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
                mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
                /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
                mywindow.document.write('</head><body>');
                mywindow.document.write($('#my_print_outline').html());
                mywindow.document.write('</body></html>');

                mywindow.print();
                mywindow.close();

                return false;
            });
            var announcement;
            get_announcement_dtl();

            if ($("#hdn_user_type").val() == "I2" || $("#hdn_user_type").val() == "PC") {
                //style = "position: absolute; top: 118px; height: 500px; width: 980px; left: 0px;"
                //$("#i22d06md").css('top', '173px');20022021
                $("#i22d06md").css('top', '11.7%');
                $("#Div19").css('top', '-122%');
                //$("#Div22").css('top', '98%');
                //$("#Div22").css('top', '162px');
                //$("#for_I2").css('display', '');
                //call_for_studio_status_track();
                studio_dtl();
            } else {
                $("#Div22").css('top', '-265px');
                $("#Div18").css('top', '168%');
                $("#SITE_PAGES_2").css('top', '54px');
                $("#i22d06md").css('top', '12%');

                //$("#i22d06md_new").remove();
                //$("#i22d06md_new_2").remove();
                //$("#i22d06md_new_3").remove();
                $("#studio_prop").remove();
            }

            if ($("#hdn_tutor_type").val() == "temp") {
                $("#bank_tutor").addClass("inactive");
                $("#bank_tutor").removeClass("active");
                $("#tutor_disabled").prop("disabled", true);
                $("#for_tutor").remove();
            } else {
                $("#for_call_for_studio").remove();
            }



            function studio_dtls() {         //changes by Aashitha 10262023

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_course_instructor_data_for_admin_dashboard",
                        async: true,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            //    if (data.d != "") {
                            //        display_studio_dtls(data.d);
                            //    }

                            //},
                            if (data.d[0] != "") {
                                $('#instructorcourse').css('display', 'block');
                                $('#divblanktable').css('display', 'none');

                                display_course(data.d[0]);
                            }
                            else {
                                //bootbox.alert('No Courses Found for Pending Approval');
                                $('#divblanktable').css('display', 'block');
                                $('#instructorcourse').css('display', 'none');
                            }

                            if (data.d[1] != "") {
                                //$('#instructorcourse').css('display', 'block');
                                $('#dtl_ws_course').css('display', 'block');
                                display_ws_course(data.d[1]);
                            }
                            else {
                                //bootbox.alert('No Courses Found for Pending Approval');
                                //$('#divblanktable').css('display', 'block');
                                $('#dtl_ws_course').css('display', 'none');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                return false;
            }



            function pending_dtls() {             //changes by Aashitha 10262023

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Get_pending_course_details",
                        async: true,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                display_pending_dtls(data);
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                return false;
            }



            function display_pending_dtls(data) {         //changes by Aashitha 10262023

                $('#dtl_studio_2').css('display', 'none');

                if (oTable_studio2 != null) {
                    oTable_studio2.fnDestroy();
                    $("#dtl_studio_2").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_studio_2" width="100%"><thead></thead><tbody> </tbody></table>');
                }

                oTable_studio2 = $("#tbl_studio_2").dataTable({
                    "bPaginate": true,
                    "bSortable": false,
                    "bSort": false,
                    "iDisplayLength": 60,
                    "sDom": 't',
                    "oLanguage": {
                        "sSearch": "Search all columns with Space:"
                    },
                    "oTableTools": {
                        "aButtons": [
                            //"copy",
                            "print",
                            {
                                "sExtends": "collection",
                                "sButtonText": 'Export',
                                "aButtons": ["xls"]
                            }
                        ]
                    },
                    "aaData": JSON.parse(data.d),
                    "aoColumns": [


                        {
                            "sTitle": "Course Code", "bSortable": false, "mData": "course_code"
                        },

                        { "sTitle": "Course Name", "bSortable": false, "mData": "course_name" },

                        {
                            "sTitle": "Status", "bSortable": false, "mData": null, mRender: function (data) {

                                if (data.user_type == 'I2' && data.designation == 'VF') {
                                    if (data.hr_approved == 'Y' && data.uso_hr_approved == 'Y' && data.admin_approved == 'Y') {
                                        return "Approved";
                                    }
                                    else {
                                        return "pending";
                                    }
                                }
                                else { return ""; }
                            }
                        },
                        {
                            "sTitle": "Edit", "mData": null, "bSortable": false, mRender: function (data) {

                                var edit_button_id = data.course_code;
                                if (data.user_type == 'I2' && data.designation == 'VF') {
                                    if (data.remark == 'NULL') {
                                        return "<center></center>";
                                    }
                                    else {
                                        return "<center><button type='button' id='" + edit_button_id + "' class='cls_btn_pdf btn btn-primary btn-small' onclick='myFunction(this.id)'>Edit</button></center>"
                                    }
                                }
                                else { return "<center></center>"; }
                            }
                        }

                    ],
                });

                $('#dtl_studio_2').css('display', 'block');
            }

            openCity(event, 'London');
            openCity(event, 'Paris');


        });


        function studio_dtl() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_studio_proposal_dtl_dashboard",
                    async: true,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "") {

                            display_studio_dtl(data.d);
                        }
                        else {

                            $("#studio_prop").remove();
                            $("#SITE_PAGES_2").css('top', '54px');
                            $("#Div22").css('top', '-334px');
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            return false;
        }

        function get_announcement_dtl() {

            var user_type = $("#hdnusertype").val();
            //ws_get_news_announcement_dtl
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_news_announcement_dtl_userwise",
                    //async: false,
                    data: "{user_type:'" + user_type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            announcement = JSON.parse(data.d);
                            display_announcement_dtl(announcement);
                        }
                        else {
                            //bootbox.alert('No News and Announcement Found');
                            var str_no = '<marquee behavior="scroll" direction="up"  scrollamount="3" style="background-color:#f7f7f7;height: 268px;width: 335px;margin-top: 5px;" id="marq" onmouseover="this.stop();" onmouseout="this.start();"></marquee>';
                            $("#div_marq").html(str_no);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function call_for_studio_status_track() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/call_for_studio_status_track",
                    //async: false,
                    data: "{studio_code:''}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var track_call_for_studio = JSON.parse(data.d);
                            //if (track_call_for_studio[0]["value"] == "Y") {
                            //    $("#pd").css('background-color', 'white');
                            //} else {
                            //    $("#pd").css('background-color', 'grey');
                            //    block = true;
                            //    $("#ip").addClass("inactive");
                            //    $("#ip").removeClass("active");
                            //    $("#sd").addClass("inactive");
                            //    $("#sd").removeClass("active");
                            //}
                            if (track_call_for_studio[1]["value"] == "Y") {
                                $("#ip").css('background-color', 'white');
                            } else {
                                $("#ip").css('background-color', 'grey');
                            }
                            if (track_call_for_studio[2]["value"] == "Y") {
                                $("#sd").css('background-color', 'white');
                            } else {
                                $("#sd").css('background-color', 'grey');
                            }
                            if (track_call_for_studio[3]["value"] == "Y") {
                                $("#bank_tutor").css('background-color', 'white');
                            } else {
                                $("#bank_tutor").css('background-color', 'grey');
                            }
                            if (track_call_for_studio[4]["value"] == "Y") {
                                block = false;
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

        function display_announcement_dtl(announcement) {
            var origin = window.location.origin;
            $("#div_marq").html("");
            var str = '<marquee behavior="scroll" direction="up"  scrollamount="3" style="background-color:#f7f7f7;height: 268px;width: 335px;margin-top: 5px;" id="marq" onmouseover="this.stop();" onmouseout="this.start();">';

            for (i = 0; i < announcement.length; i++) {
                str += "<p align='justify' style='text-align:justify,font-family: Lato, sans-serif;letter-spacing: 0.05em;'>";
                str += "<img src='../../image/point_left.png' style='width: 25px;height: 22px;position: absolute;'></img>&emsp;";
                str += "<a href='" + location.origin + "\\WSNewsImageUpload\\" + announcement[i]["news_image"] + "' target='_blank' style='font-size: 14px;color: #666;text-justify: inter-character; text-decoration:none;margin-left:17px;font-family: Lato, sans-serif;letter-spacing: 0.05em;'>" + announcement[i]["title"] + "&nbsp;&nbsp;<span style='color:blue;font-family: Lato, sans-serif;letter-spacing: 0.1em;'>" + modify(announcement[i]["date"]) + "</span></a>"
                str += "</p><br/>";
            }
            str += '</marquee>';

            $("#div_marq").html(str);
        }

        function modify(data) {
            var str = data.replace(/-/g, ' ');
            return str;
        }

        function get_instructor_course_data() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_course_instructor_data_for_admin_dashboard",
                    //async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d[0] != "") {
                            $('#instructorcourse').css('display', 'block');
                            $('#divblanktable').css('display', 'none');

                            display_course(data.d[0]);
                        }
                        else {
                            //bootbox.alert('No Courses Found for Pending Approval');
                            $('#divblanktable').css('display', 'block');
                            $('#instructorcourse').css('display', 'none');
                        }

                        if (data.d[1] != "") {
                            //$('#instructorcourse').css('display', 'block');
                            $('#dtl_ws_course').css('display', 'block');
                            display_ws_course(data.d[1]);
                        }
                        else {
                            //bootbox.alert('No Courses Found for Pending Approval');
                            //$('#divblanktable').css('display', 'block');
                            $('#dtl_ws_course').css('display', 'none');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }

        function display_course(data) {
            $('#dtl_course').css('display', 'none');

            if (oTable2 != null) {
                oTable2.fnDestroy();
                $("#dtl_course").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_course" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable2 = $("#tbl_course").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Name", "mData": "course_name", "bSortable": false },
                    {
                        "sTitle": "Outline", "bSortable": false, "mData": null, "mRender": function () {
                            return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
                        }
                    },
                    {
                        "sTitle": "Student", "bSortable": false, "mData": null, "mRender": function () {
                            return '<center><a style="cursor:pointer" class="course_student" onclick="rowClick(this,oTable2)">View List</a></center>';
                        }
                    }
                ]
            });

            $('#dtl_course').css('display', 'block');
        }

        $(document).on("click", ".course_outlin_oTable2", function (event) {
            //$('#my_outline').modal('hide');

            //$('#txtcourse_outline').html('');
            //$('#txt_week1').html('');
            //$('#txt_week2').html('');
            //$('#txt_week3').html('');
            //$('#txt_week4').html('');
            //$('#txt_week5').html('');
            //$('#txt_week6').html('');
            //$('#txt_week7').html('');
            //$('#txt_week8').html('');
            //$('#txt_week9').html('');
            //$('#txt_week10').html('');
            //$('#txt_week11').html('');
            //$('#txt_week12').html('');
            //$('#txt_week13').html('');
            //$('#txt_week14').html('');
            //$('#txt_week15').html('');
            //$('#txt_week16').html('');

            //$('#txtcourse_structure').html('');
            //$('#txt_course_code').html('');

            //$('#txt_reference').html('');
            //$('#txt_eval_method').html('');

            var row = $(this).closest("tr").get(0);
            var aData = oTable2.fnGetData(row);

            //var flag = 'N';

            var course_code = aData["course_code"];
            var semester_type = aData["semester_type"];
            var year_semester = aData["year_semester"];

            window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester_type + '&year_code=' + year_semester + '&new_tab=N', "_newtab");

            //$('#txtcourse_outline').html(aData["course_outline"]);

            //$('#txt_week1').html(aData["week1"]);
            //$('#txt_week2').html(aData["week2"]);
            //$('#txt_week3').html(aData["week3"]);
            //$('#txt_week4').html(aData["week4"]);
            //$('#txt_week5').html(aData["week5"]);
            //$('#txt_week6').html(aData["week6"]);
            //$('#txt_week7').html(aData["week7"]);
            //$('#txt_week8').html(aData["week8"]);
            //$('#txt_week9').html(aData["week9"]);
            //$('#txt_week10').html(aData["week10"]);
            //$('#txt_week11').html(aData["week11"]);
            //$('#txt_week12').html(aData["week12"]);
            //$('#txt_week13').html(aData["week13"]);
            //$('#txt_week14').html(aData["week14"]);
            //$('#txt_week15').html(aData["week15"]);
            //$('#txt_week16').html(aData["week16"]);

            //$('#txt_course_code').html(course_code);

            //$('#spn_prog_level_code').html(aData.program_level_code);
            //$('#spn_instructor').html(aData["instructor"]);
            //$('#txtcourse_structure').html(aData["course_structure"]);
            //$('#spn_faculty').html(aData.faculty);

            //var semester = '';

            ////if ($('#drpsem').val() == 'M') {
            ////    semester = 'Monsoon';
            ////}
            ////else {
            ////    semester = 'Spring';
            ////}

            //if (aData["semester_type"] == 'M') {
            //    semester = 'Monsoon';
            //}
            //else {
            //    semester = 'Spring';
            //}

            //$('#spn_semester').html(semester);
            //$('#spn_year').html(aData["year_semester"]);

            //if (aData["remark"] != "") {
            //    $('#txt_reference').html(aData["remark"]);
            //}
            //else {
            //    //$('#txt_reference').html('NA');
            //}

            //if (aData["eval_method1"] != "") {
            //    $('#txt_eval_method').html(aData["eval_method1"]);
            //}
            //else {
            //    //$('#txt_eval_method').html('NA');
            //}

            //if (aData["prerequisite"] != "") {
            //    var data = get_prerequisite(aData["prerequisite"]);

            //    if (data != "") {
            //        $('#txt_Prerequisite').html(data);
            //    }
            //    else {
            //        //$('#txt_Prerequisite').html('NA');
            //    }
            //}

            //$('#my_outline').modal('show');

            //if (aData.course_structure != '') {
            //    $('#div_weekly_plan').css('display', 'none');
            //    $('#div_course_structure').css('display', 'block');
            //}
            //else if (aData.week1 != '' || aData.week2 != '' || aData.week3 != '' || aData.week4 != '' || aData.week5 != '' || aData.week6 != '' || aData.week7 != '' || aData.week8 != '' || aData.week9 != '' || aData.week10 != '' || aData.week11 != '' || aData.week12 != '' || aData.week13 != '' || aData.week14 != '' || aData.week15 != '' || aData.week16 != '') {
            //    $('#div_weekly_plan').css('display', 'block');
            //    $('#div_course_structure').css('display', 'none');
            //}
            //else {
            //    $('#div_weekly_plan').css('display', 'none');
            //    $('#div_course_structure').css('display', 'none');
            //}

            //if (aData.week_reference1 != '') {
            //    $('#txt_reference1').html(aData.week_reference1);
            //    $('#div_reference1').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference1').html('NA');
            //    $('#div_reference1').css('display', 'none');
            //}

            //if (aData.week_reference2 != '') {
            //    $('#txt_reference2').html(aData.week_reference2);
            //    $('#div_reference2').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference2').html('NA');
            //    $('#div_reference2').css('display', 'none');
            //}

            //if (aData.week_reference3 != '') {
            //    $('#txt_reference3').html(aData.week_reference3);
            //    $('#div_reference3').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference3').html('NA');
            //    $('#div_reference3').css('display', 'none');
            //}

            //if (aData.week_reference4 != '') {
            //    $('#txt_reference4').html(aData.week_reference4);
            //    $('#div_reference4').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference4').html('NA');
            //    $('#div_reference4').css('display', 'none');
            //}

            //if (aData.week_reference5 != '') {
            //    $('#txt_reference5').html(aData.week_reference5);
            //    $('#div_reference5').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference5').html('NA');
            //    $('#div_reference5').css('display', 'none');
            //}

            //if (aData.week_reference6 != '') {
            //    $('#txt_reference6').html(aData.week_reference6);
            //    $('#div_reference6').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference6').html('NA');
            //    $('#div_reference6').css('display', 'none');
            //}

            //if (aData.week_reference7 != '') {
            //    $('#txt_reference7').html(aData.week_reference7);
            //    $('#div_reference7').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference7').html('NA');
            //    $('#div_reference7').css('display', 'none');
            //}

            //if (aData.week_reference8 != '') {
            //    $('#txt_reference8').html(aData.week_reference8);
            //    $('#div_reference8').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference8').html('NA');
            //    $('#div_reference8').css('display', 'none');
            //}

            //if (aData.week_reference9 != '') {
            //    $('#txt_reference9').html(aData.week_reference9);
            //    $('#div_reference9').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference9').html('NA');
            //    $('#div_reference9').css('display', 'none');
            //}

            //if (aData.week_reference10 != '') {
            //    $('#txt_reference10').html(aData.week_reference10);
            //    $('#div_reference10').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference10').html('NA');
            //    $('#div_reference10').css('display', 'none');
            //}

            //if (aData.week_reference11 != '') {
            //    $('#txt_reference11').html(aData.week_reference11);
            //    $('#div_reference11').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference11').html('NA');
            //    $('#div_reference11').css('display', 'none');
            //}

            //if (aData.week_reference12 != '') {
            //    $('#txt_reference12').html(aData.week_reference12);
            //    $('#div_reference12').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference12').html('NA');
            //    $('#div_reference12').css('display', 'none');
            //}

            //if (aData.week_reference13 != '') {
            //    $('#txt_reference13').html(aData.week_reference13);
            //    $('#div_reference13').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference13').html('NA');
            //    $('#div_reference13').css('display', 'none');
            //}

            //if (aData.week_reference14 != '') {
            //    $('#txt_reference14').html(aData.week_reference14);
            //    $('#div_reference14').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference14').html('NA');
            //    $('#div_reference14').css('display', 'none');
            //}

            //if (aData.week_reference15 != '') {
            //    $('#txt_reference15').html(aData.week_reference15);
            //    $('#div_reference15').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference15').html('NA');
            //    $('#div_reference15').css('display', 'none');
            //}

            //if (aData.week_reference16 != '') {
            //    $('#txt_reference16').html(aData.week_reference16);
            //    $('#div_reference16').css('display', 'block');
            //}
            //else {
            //    //$('#txt_reference16').html('NA');
            //    $('#div_reference16').css('display', 'none');
            //}

            ////if (aData["course_typology"] == '') {
            ////    $('#div_weekly_plan').css('display', 'none');
            ////    $('#div_course_structure').css('display', 'none');
            ////}
            ////else if (aData["course_typology"] == '3' || aData["course_typology"] == '4' || aData["course_typology"] == '6' || aData["course_typology"] == '8') {
            ////    $('#div_weekly_plan').css('display', 'block');
            ////    $('#div_course_structure').css('display', 'none');
            ////}
            ////else {
            ////    $('#div_weekly_plan').css('display', 'none');
            ////    $('#div_course_structure').css('display', 'block');
            ////}

            //return false;
        });

        function get_prerequisite(data) {
            var str_return = '';
            var obj_prerequisite;
            if (data != "") {
                try {
                    obj_prerequisite = JSON.parse(data);
                }
                catch (e) {
                    return data;
                }

                if (obj_prerequisite["chkbox"] != "") {
                    var split_chk_data = obj_prerequisite["chkbox"].split('~');

                    for (var i = 0; i < split_chk_data.length; i++) {
                        if (split_chk_data[i] != 'chk_pre10') {
                            if (str_return != '') str_return = str_return + ', ';

                            switch (split_chk_data[i]) {
                                case 'chk_pre1':
                                    str_return = str_return + 'None'; break;
                                case 'chk_pre2':
                                    str_return = str_return + 'Completed 3rd year FA'; break;
                                case 'chk_pre3':
                                    str_return = str_return + 'Completed 3rd year FD'; break;
                                case 'chk_pre4':
                                    str_return = str_return + 'Completed 3rd year FP'; break;
                                case 'chk_pre5':
                                    str_return = str_return + 'Completed 3rd year FT'; break;
                                case 'chk_pre6':
                                    str_return = str_return + 'Completed UG Architecture'; break;
                                case 'chk_pre7':
                                    str_return = str_return + 'Completed UG Planning'; break;
                                case 'chk_pre8':
                                    str_return = str_return + 'Completed UG Design'; break;
                                case 'chk_pre9':
                                    str_return = str_return + 'Completed UG Technology/ Engineering'; break;
                            }
                        }
                    }
                }

                if (obj_prerequisite["other"] != "") {
                    if (str_return != '') str_return = str_return + ', ';
                    str_return = str_return + obj_prerequisite["other"];
                }
            }
            return str_return;
        }

        $(document).on("click", ".course_student", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable2.fnGetData(row);

            var course_code = aData["course_code"];

            $('#spn_course').text(course_code);

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_student_course_data_for_admin_dashboard",
                    //async: false,
                    data: "{course_code : '" + course_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            //$('#allocate_student_data').modal('show');
                            $('#allocate_student_data').modal('hide');
                            //display_allocate_student(data.d);

                        }
                        else {
                            //bootbox.alert('No Courses Found for Pending Approval');
                            $('#allocate_student_data').modal('hide');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        });

        $(document).on("click", ".ws_course_student", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable_ws.fnGetData(row);

            var course_code = aData["course_code"];

            $('#spn_ws_course').text(course_code);

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ws_get_student_course_data_for_admin_dashboard",
                    //async: false,
                    data: "{course_code : '" + course_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            $('#allocate_ws_student_data').modal('hide');

                           display_ws_allocate_student(data.d);
                        }
                        else {
                            //  bootbox.alert('No Courses Found for Pending Approval');
                            $('#allocate_ws_student_data').modal('hide');

                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        });

        function display_allocate_student(data) {
            if (oTable_student != null) {
                oTable_student.fnDestroy();
                $("#dtl_allocate_student").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_allocate_student" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable_student = $("#tbl_allocate_student").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls", "pdf"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Phone no", "mData": "mobile_no", "bSortable": false }
                ]
            });

            //$('#dtl_course').css('display', 'block');
        }

        function display_ws_course(data) {
            $('#dtl_ws_course').css('display', 'none');

            if (oTable_ws != null) {
                oTable_ws.fnDestroy();
                $("#dtl_ws_course").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_ws_course" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable_ws = $("#tbl_ws_course").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Name", "mData": "course_name", "bSortable": false },
                    {
                        "sTitle": "Student", "bSortable": false, "mData": null, "mRender": function () {
                            return '<center><a style="cursor:pointer" class="ws_course_student" onclick="rowClick_ws(this,oTable_ws)" >View Link</a></center>';
                        }
                    }
                ]
            });

            $('#dtl_ws_course').css('display', 'block');
        }

        function display_ws_allocate_student(data) {
            if (oTable_ws_student != null) {
                oTable_ws_student.fnDestroy();
                $("#dtl_ws_allocate_student").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_ws_allocate_student" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable_ws_student = $("#tbl_ws_allocate_student").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Phone no", "mData": "mobile_no", "bSortable": false }
                ]
            });
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        //kapil
        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }

        function rowClick(row, objtable)
        {
            var rowId = objtable.fnGetData($(row).closest('tr')[0])['course_code'];
            window.open("StudentList.aspx?i=" + rowId, '_blank');
        }

        function rowClick_ws(row, objtable) {

            var rowId = objtable.fnGetData($(row).closest('tr')[0])['course_code'];
           // window.open("Home.aspx?w=" + rowId, '_blank');
            window.open("StudentList.aspx?w=" + rowId, '_blank');


        }

        function display_student_dtl(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Phone no", "mData": "mobile_no", "bSortable": false },
                    { "sTitle": "Selection Type", "mData": "studio_type", "bSortable": false }

                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Download)
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {

                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {

                asInitVals[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });

            //$('#example_wrapper').css('overflow', 'auto');

            $('#DataList1').css('display', 'block');
            $('#student_view_list').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function display_ws_student_dtl(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList2").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="ws_example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#ws_example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Phone no", "mData": "mobile_no", "bSortable": false }

                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#ws_example thead th').each(function (i, r) {
                var nm = $('#ws_example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#ws_example thead').append(thead);

            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Download)
            for (var i = 0; i < $("#ws_example tr:nth-child(2) th").length; i++) {

                var title = $('#ws_example thead th').eq(i).text();
                $('#ws_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {

                asInitVals[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });

            //$('#example_wrapper').css('overflow', 'auto');

            $('#DataList2').css('display', 'block');
            $('#student_view_list').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function display_ws_student_dtl_empty() {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList2").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="ws_example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#ws_example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                //"aaData": JSON.parse(""),
                "aoColumns": [

                    { "sTitle": "", "mData": "DataNotFound", "bSortable": false }


                ]
            });



            //$('#example_wrapper').css('overflow', 'auto');

            $('#DataList2').css('display', 'block');
            $('#student_view_list').css('display', 'block');

        }

        function display_student_dtl_empty() {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "", "mData": "user_id", "bSortable": false }


                ]
            });


            $('#DataList1').css('display', 'block');
            $('#student_view_list').css('display', 'block');

        }

        function disable_div() {
            $('#i22d06md').css('display', 'none');
            $('#Div21').css('display', 'none');
            $('#Div12').css('display', 'none');
            $('#Div3').css('display', 'none');
            $('#Div1').css('display', 'none');
            $('#mainPage').css('display', 'none');
            $('#SITE_PAGES').css('display', 'none');
            $('#Div18').css('display', 'none');
            $('.s9').css('display', 'none');
            $("#studio_id").css("display", "none");
            $("#temp_id").css("display", "none");
            $("#reference_id").css("display", "none");
            $("div#for_call_for_studio").css("top", "19%");
        }

        function rowClick_edit(row) {
            var origion = window.location.origin + '/';
            window.open(origion + "Admin/Master/Interested_Program.aspx?studio_code=" + row.id + "", '_blank');
        }
        function rowClick_studio_brief(row) {
            ////Studio_Brief_Details.aspx?studio_code=CFSC2122000017&s=S&y=2021

            var split_data = row.id.split('_');
            var origion = window.location.origin + '/';
            if (split_data[3] != 'S') {
                //S2021_

                //window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
                window.open(origion + "Admin/Master/Add_bank_detl.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "&b=" + split_data[4] + "", '_blank');
                // window.open(origion + "Admin/Master/Add_bank_detl.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
            }
            else {
                var sem_dt = split_data[1] + split_data[2];
                //window.open(origion + "Admin/Master/Add_bank_detl.aspx?c=" + + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
                window.open(origion + "Admin/Master/Add_bank_detl.aspx?c=" + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "&b=" + split_data[4] + "", '_blank');
                //window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
            }

        }


        function rowClick_to_be_decided(row) {


            var split_data = row.id.split('_');
            var origion = window.location.origin + '/';

            window.open(origion + "Admin/Master/Tobedecided_inst_dtl.aspx?c=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
            // window.open(origion + "Admin/Master/Add_bank_detl.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');


        }


        function display_studio_dtl(data) {
            $('#dtl_studio').css('display', 'none');

            if (oTable_studio != null) {
                oTable_studio.fnDestroy();
                $("#dtl_studio").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_studio" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable_studio = $("#tbl_studio").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": 't',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [

                    //{ "sTitle": "Studio Level", "mData": "studio_level" },

                    {
                        "sTitle": "Studio Level", "bSortable": false, "mData": "studio_level", "mRender": function (data) {
                            if (data == "L2") {
                                return "Level 2";
                            }
                            else if (data == "L3") {
                                return "Level 3";
                            }
                            else if (data == "L4") {
                                return "Level 4";
                            }

                            else if (data == "L1") { return "Level 1"; }

                        }
                    },

                    { "sTitle": "Title of Studio", "mData": "studio_title" },

                    {
                        "sTitle": "Semester", "bSortable": false, "mData": "semester_type", "mRender": function (data) {
                            if (data == "S") {
                                return "Spring";
                            }
                            else {
                                return "Monsoon";
                            }

                        }
                    },
                    { "sTitle": "Year", "mData": "year_semester", "bSortable": false },
                    {
                        "sTitle": "Studio Proposal", "bSortable": false, "mData": null, "mRender": function (data) {

                            if (data.pc_status_new == 'R') {
                                return '<center></center>';
                            }
                            else if (data.hr_status_new == 'R') {
                                return '<center></center>';
                            }

                            else if (data.is_submit == 'Y' && data.studio_brief_status == 'Y') {
                                return "<center>Submitted</center>";
                            }
                            else if (data.is_submit == 'Y') {
                                return "<center>Submitted</center>";
                            }
                            else {
                                return '<center><a id=' + data.studio_code + ' onclick="rowClick_edit(this)">Edit</a></center>';
                            }

                        }
                    },

                    {
                        "sTitle": "Bank Details", "bSortable": false, "mData": null, "mRender": function (data) {

                            if (data.studio_brief_status == 'Y') {
                                return "<center>Submitted</center>";
                            }
                            else if (data.studio_brief_status == 'A') {
                                return "<center>Submitted</center>";
                            }
                            else if (data.pc_status_new == 'R') {
                                return '<center></center>';
                            }
                            else if (data.hr_status_new == 'R') {
                                return '<center></center>';
                            }

                            else if (data.is_submit == 'Y' && data.approved == 'Y') {
                                var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status + "_" + data.brief_edit_status;
                                return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">View/Edit</a></center>';
                            }
                            else {
                                return '<center></center>';
                            }

                        }
                    },
                     
                    {
                        "sTitle": "Studio Brief", "bSortable": false, "mData": null, "mRender": function (data) {

                            if ($('#hdnusertype').val() == 'I2') {
                                if (data.studio_brief_status == 'Y') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.studio_brief_status == 'A') {
                                    return "<center>Submitted</center>";
                                }

                                // else if (data.is_submit == 'Y' && data.approved == 'Y') {
                                else if (data.is_submit == 'Y' && data.approved == 'Y' && data.brief_edit_status == 'Y') {
                                    var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status + "_" + data.brief_edit_status;
                                    //return "<center>Submitted</center>"; 
                                    return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">Edit</a></center>';
                                }
                                else {
                                    return '<center></center>';
                                }
                            }
                            else if ($('#hdnusertype').val() == 'PC')
                            {
                                if (data.studio_brief_status == 'Y') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.studio_brief_status == 'A') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.is_submit == 'Y' && data.approved == 'Y') {
                                    var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status;
                                    return '<center></center>';
                                    //return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">Edit</a></center>';//nitinbhai changes 22082025 chat and call 
                                }
                                else {
                                    return '<center></center>';
                                }

                            }
                            else {
                                if (data.studio_brief_status == 'Y') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.studio_brief_status == 'A') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.is_submit == 'Y' && data.approved == 'Y') {
                                    var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status;
                                    //return "<center>Submitted</center>"; 
                                    return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">Edit</a></center>';
                                }
                                else {
                                    return '<center></center>';
                                }
                            }



                        }
                    },
                    {
                        "sTitle": "To be Decided", "bSortable": false, "mData": null, "mRender": function (data) {

                            if (data.pc_status_new == 'R') {
                                return '<center></center>';
                            }
                            else if (data.hr_status_new == 'R') {
                                return '<center></center>';
                            }

                            else if (data.is_submit == 'Y' && data.brief_edit_status == 'Y') {
                                var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status;

                                return '<center><a id=' + data_dtl + ' onclick="rowClick_to_be_decided(this)">View/Edit</a></center>';
                            }
                            else {
                                return '<center></center>';
                            }





                        }
                    },
                    {
                        "sTitle": "Delete", "bSortable": false, "mData": null, "mRender": function (data) {
                            var bind_data = data.semester_type + "_" + data.year_semester + "_" + data.user_id + "_" + data.studio_code;

                            if (data.pc_status_new == 'R') {
                                return '<center></center>';
                            }
                            else if (data.hr_status_new == 'R') {
                                return '<center></center>';
                            }

                            else if (data.is_submit == 'Y') {
                                return "<center></center>";
                            }
                            else {
                                return '<center><a id=' + bind_data + ' onclick="rowClick_delete(this)">Delete</a></center>';
                            }

                            //return '<center><a style="cursor:pointer" class="course_student" onclick="rowClick(this,oTable2)">View List</a></center>';

                        }
                    },
                    {
                        "sTitle": "Status", "bSortable": false, "mData": null, "mRender": function (data) {

                            //if (data.status == 'A' && data.approved == 'N' && data.hr_status == '') {
                            if (data.hr_status_new == 'R') {
                                if (data.hr_remark_new != '') {
                                    return "<center>HR-(" + data.hr_remark_new + ")</center>";
                                }
                                else { return "<center></center>"; }

                            }

                            if (data.pc_status_new == 'R') {
                                if (data.pc_remark_new != '') {
                                    return "<center>PC-(" + data.pc_remark_new + ")</center>";
                                }
                                else { return "<center></center>"; }

                            }

                            if (data.hr_remark_new != '') {
                                return "<center>HR-(" + data.hr_remark_new + ")</center>";
                            }
                            if (data.pc_remark_new != '') {
                                return "<center>PC-(" + data.pc_remark_new + ")</center>";
                            }

                            if (data.status == 'A' && data.studio_inst == 'N' && data.hr_status == '') {
                                return "<center>HR Yet Not Authorized</center>";
                            }
                            //else if (data.status == 'R') {
                            //    return "<center>" + data.remark + "</center>";
                            //}
                            //else if (data.hr_status == 'R') {
                            //    return "<center>" + data.hr_remark + "</center>";
                            //}

                            else if (data.studio_brief_status == 'Y') {
                                return "<center>Under Process</center>";
                            }
                            else if (data.studio_brief_status == 'A') {
                                return "<center>Submitted</center>";
                            }
                            //else if (data.approved == 'N' && data.is_submit == 'Y' && data.studio_brief_status == 'N') {
                            else if (data.studio_inst == 'N' && data.is_submit == 'Y' && data.studio_brief_status == 'N') {
                                return "<center>PC Yet Not Shortlisted </center>";
                            }
                            else { return "<center></center>"; }

                        }
                    }
                ]
            });

            $('#dtl_studio').css('display', 'block');
        }


        function rowClick_delete(row) {
            bootbox.confirm('Are you sure you want to remove this?', function (result) {
                if (result == true) {
                    $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService.asmx/studio_user_delete",
                            data: "{detalis:'" + row.id + "'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "" && data.d != "[]") {
                                    if (data.d == true) {
                                        location.reload();
                                        bootbox.alert("Proposal Delete successfully");

                                        return false;
                                    }
                                }
                                else {
                                    bootbox.alert('Problem in Data');
                                    return false;
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">



    <div class="modal hide fade" id="my_outline" style="margin-left: -500px; width: 70%; overflow: auto; height: 82%;">
        <button style="float: right" class="btn btn-lg btn-primary" id="btn_print_outline">
            Print outline</button>
        <div class="panel panel-default " id="my_print_outline">
            <div class="panel-body">
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        Faculty of <span id="spn_faculty"></span>, CEPT University
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        <span id="spn_semester"></span>Semester, <span id="spn_year"></span>
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        Program : <span id="spn_prog_level_code"></span>
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        <b style="font-size: 18px;"><span id="txt_course_code"></span></b>
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        Instructors : <span id="spn_instructor"></span>
                    </div>
                </div>
                <div class=" row" style="margin-top: 10px;">
                    <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 color-blue">
                        <b>Prerequisites : </b>
                    </div>
                </div>
                <div class=" row">
                    <div class="form-group col-md-11 color-blue">
                        <div style="text-align: justify; font-family: arial;" id="txt_Prerequisite">
                        </div>
                    </div>
                </div>
                <div class=" row" style="margin-top: 15px;">
                    <div style="font-size: 15px; font-family: arial;" class="form-group col-md-2 color-blue">
                        <b>Introduction : </b>
                    </div>
                </div>
                <div class=" row">
                    <div class="form-group col-md-11">
                        <div style="text-align: justify; font-family: arial;" id="txtcourse_outline">
                        </div>
                    </div>
                </div>
                <div id="div_weekly_plan" style="display: none; margin-top: 15px;">
                    <div class="cls_font row">
                        <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 color-blue">
                            <b>Detailed Outline & Schedule </b>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 1 :</b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week1">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference1">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference1">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 2 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week2">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference2">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference2">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 3 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week3">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference3">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference3">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 4 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week4">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference4">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference4">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 5 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week5">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference5">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference5">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 6 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week6">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference6">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference6">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 7 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week7">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference7">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference7">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 8 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week8">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference8">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference8">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 9 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week9">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference9">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference9">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 10 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week10">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference10">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference10">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 11 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week11">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference11">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference11">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 12 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week12">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference12">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference12">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 13 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week13">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference13">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference13">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 14 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week14">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference14">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference14">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 15 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week15">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference15">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference15">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 16 :</b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week16">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference16">
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference16">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="div_course_structure" style="margin-top: 10px; display: none;">
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Course Structure : </b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txtcourse_structure">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 15px;">
                    <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                        <b>References/Reading :</b>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-11 color-blue">
                        <div style="text-align: justify; font-family: arial;" id="txt_reference">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 15px;">
                    <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                        <b>Evaluation Method :</b>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-11 color-blue">
                        <div style="text-align: justify; font-family: arial;" id="txt_eval_method">
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <%-- <div class="modal hide fade" id="allocate_student_data" style="margin-left: -342px;
        width: 50%; overflow: auto; height: 82%;">
        <div style="clear: both; margin-left: 45%;">
            <b>Course Code : </b><span id="spn_course"></span>
        </div>
        <div id="divstudentdata" class="tab-pane" style="margin-top: 3px; overflow: auto;">
           
            <div id="dtl_allocate_student" style="display: block; padding-left: 1%;">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_allocate_student" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>--%>

    <div class="modal hide fade" id="allocate_ws_student_data" style="margin-left: -342px; width: 50%; overflow: auto; height: 82%;">
        <div style="clear: both; margin-left: 45%;">
            <b>Course Code : </b><span id="spn_ws_course"></span>
        </div>
        <div id="div27" class="tab-pane" style="margin-top: 3px; overflow: auto;">
            <%-- in active">--%>
            <div id="dtl_ws_allocate_student" style="display: block; padding-left: 1%;">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_ws_allocate_student" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="row" style="margin-top: 11px; width: 64.3%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: none;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Call for Studio Tutor 
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Studio_Proposal_dtl.aspx">View Submitted Proposal</a></span>
            <span style="font-size: 10pt; float: right; margin-right: 0.8%; text-shadow: 0 0 slateblue;">|</span>
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a></span>
        </h5>
        <div style="margin-left: 1%; border-top: 1px solid black; width: 97.8%;"></div>
        <ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px; width: 100%; margin-bottom: 10px; margin-top: 5px;">
            <li class="col-md-3 active" id="pd" style="width: 18% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 1:</strong></h5>
                        <p id="pdclick" style="color: black;">Personal Details</p>


                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="ip" style="width: 18% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-book"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 2:</strong></h5>
                        <a href="Interested_Program.aspx" id="lp_disabled" style="color: black;">Studio Proposal</a>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="sd" style="width: 25% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 3:</strong></h5>
                        <a href="Studio_Details.aspx" id="sp_disabled" style="color: black;">Studio Brief</a>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="bank_tutor" style="width: 18% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 4:</strong></h5>
                        <p id="bdclick" style="color: black;">Bank Details</p>
                    </div>
                </div>
            </li>
        </ol>
    </div>

    <div style="position: absolute; top: 118px; height: 500px; width: 980px; left: 0px;"
        class="s9" id="for_tutor">
        <div id="PAGES_CONTAINERscreenWidthBackground" class="s9screenWidthBackground" style="width: 1349px; left: -185px;">
        </div>
        <div id="PAGES_CONTAINERcenteredContent" class="s9centeredContent">
            <div id="PAGES_CONTAINERbg" class="s9bg">
            </div>
            <div id="PAGES_CONTAINERinlineContent" class="s9inlineContent">
                <div style="position: absolute; top: 0px; height: 500px; width: 980px; left: 0px;"
                    class="s10" id="SITE_PAGES">
                    <div style="position: absolute; top: 0px; height: 500px; width: 980px; left: 0px;"
                        class="s11" id="mainPage">
                        <div id="mainPagebg" class="s11bg">
                        </div>
                        <div id="mainPageinlineContent" class="s11inlineContent">
                            <%--<div style="position: absolute; top: 35%; height: 173px; width: 681px; left: 1px;" class="s12" id="i22d06md_new">
                                <div id="i22d06mdbg_new" class="s12bg">
                                </div>
                                <div id="i22d06mdinlineContent_new" class="s12inlineContent">
                                    <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new">
                                        <p style="font-size: 18px;" class="font_8">
                                            <span style="font-size: 18px;">Studio Unit Framework:</span>
                                        </p>
                                    </div>
                                    <div id="divblanktable_new" style="top: 25%; position: absolute; width: 98%; padding-left: 1%;">
                                        
                                        <h6 style="color: blue;">Materials on Studio Teaching at CEPT University: Please go through the references before making the proposal.</h6>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">1. Introduction to Studio Unit Framework [pdf] </div>
                                            <a href="../../StudioDetails/Introduction to Studio Unit Framework.pdf" download>Download</a>
                                        </div>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">2. Note on L2/L3 Studios [pdf] </div>
                                            <a href="../../StudioDetails/Note on L2-L3 Studio-1-1.pdf" download>Download</a>
                                        </div>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">3. Note on Learning Outcomes' [pdf] </div>
                                            <a href="../../StudioDetails/Note on Learning Outcomes.pdf" download>Download</a>
                                        </div>
                                    </div>
                                    <div id="instructorcourse_new" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">
                                    </div>
                                    <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px;" class="s13" id="i22dbl7s_new">
                                    </div>
                                </div>
                            </div>
                            <div style="position: absolute; top: 72%; height: 180px; width: 681px; left: 1px;" class="s12" id="i22d06md_new_2">
                                <div id="i22d06mdbg_new_2" class="s12bg">
                                </div>
                                <div id="i22d06mdinlineContent_new_2" class="s12inlineContent">
                                    <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new_2">
                                        <p style="font-size: 18px;" class="font_8">
                                            <span style="font-size: 18px;">References to prepare Studio Proposal:</span>
                                        </p>
                                    </div>
                                    <div id="divblanktable_new_2" style="top: 20%; position: absolute; width: 98%; padding-left: 1%;">
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">1. Handbook for Unit Tutors</div>
                                            <a href="../../StudioDetails/Handbook for Unit tutors.pdf" download>Download</a>
                                        </div>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">2. Sample Presentation – Level 2 Studio [pdf]</div>
                                            <a href="../../StudioDetails/Sample Presentation- L2.pdf" download>Download</a>
                                        </div>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">3. Studio Proposal Template [ppt] – Level 2 </div>
                                            <a href="../../StudioDetails/Studio Presentation Template  - L2.pptx" download>Download</a>
                                        </div>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">4. Studio Proposal Template [ppt] – Level 3 </div>
                                            <a href="../../StudioDetails/Studio Presentation Template  - L3.pptx" download>Download</a>
                                        </div>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">5. Studio Proposal Template [ppt] – Level 4 </div>
                                            <a href="../../StudioDetails/Studio Presentation Template - L4.pptx" download>Download</a>
                                        </div>
                                    </div>
                                    <div id="instructorcourse_new_2" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">
                                    </div>
                                    <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px;" class="s13" id="i22dbl7s_new_2">
                                    </div>
                                </div>
                            </div>
                            <div style="position: absolute; top: 110%; height: 100px; width: 681px; left: 1px;" class="s12" id="i22d06md_new_3">
                                <div id="i22d06mdbg_new_3" class="s12bg">
                                </div>
                                <div id="i22d06mdinlineContent_new_3" class="s12inlineContent">
                                    <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new_3">
                                        <p style="font-size: 18px;" class="font_8">
                                            <span style="font-size: 18px;">References to prepare Studio Brief (for CAC shortlisted/approved studios)</span>
                                        </p>
                                    </div>
                                    <div id="divblanktable_new_3" style="top: 35%; position: absolute; width: 98%; padding-left: 1%;">
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">1. Sample Studio Brief [pdf]</div>
                                            <a href="../../StudioDetails/Sample Studio Brief.pdf" download>Download</a>
                                        </div>
                                        <div style="margin-top: 1%;" id="">
                                            <div style="float: left; width: 50%;">2. Studio Brief template [doc]</div>
                                            <a href="../../StudioDetails/Studio Brief Template.pdf" download>Download</a>
                                        </div>
                                    </div>
                                    <div id="instructorcourse_new_3" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">
                                    </div>
                                    <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px;" class="s13" id="i22dbl7s_new_3">
                                    </div>
                                </div>
                            </div>--%>
                            <div style="position: absolute; top: 10.5%; height: 313px; width: 681px; left: 1px;"
                                class="s12" id="studio_prop">
                                <div id="studio_pro" class="s12bg">
                                </div>
                                <div id="studio_pro_dtl" class="s12inlineContent">



                                    <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="studio_body">


                                        <p style="font-size: 18px;" class="font_8">
                                            <span style="font-size: 18px;">My Proposal</span>
                                        </p>
                                    </div>
                                    <div id="dtl" style="top: 31px; position: absolute; width: 98%; padding-left: 1%;">
                                        <%--<table class="display table table-striped table-bordered table-hover">
                                          
                                        </table>--%>
                                    </div>
                                    <div id="studio_data" class="tab-pane" style="margin-top: 40px; height: 261px; overflow: auto;">
                                        <div id="dtl_studio" style="display: none; padding-left: 1%; padding-right: 1%;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="tbl_studio" class="display table table-striped table-bordered table-hover"
                                                width="100%">
                                                <thead>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px;" class="s13"
                                        id="data">
                                        <div id="dataline" class="s13line">
                                        </div>
                                    </div>
                                </div>
                            </div>
                         <%--   <div style="position: absolute; top: 76%; height: 313px; width: 681px; left: 1px;"
                                class="s12" id="i22d06md">
                                <div id="i22d06mdbg" class="s12bg">
                                </div>
                                <div id="i22d06mdinlineContent" class="s12inlineContent">
                                    <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i">
                                        <p style="font-size: 18px;" class="font_8">
                                            <span style="font-size: 18px;">My Courses</span>
                                        </p>
                                    </div>
                                    <div id="divblanktable" style="top: 31px; position: absolute; width: 98%; padding-left: 1%;">
                                        <table class="display table table-striped table-bordered table-hover">
                                            <tr>
                                                <td>Course
                                                </td>
                                                <td>Name
                                                </td>
                                                <td>Outline
                                                </td>
                                                <td>Students
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div id="instructorcourse" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">--%>
                                        <%-- in active">--%>
                                       <%-- <div id="dtl_course" style="display: none; padding-left: 1%; padding-right: 1%;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="tbl_course" class="display table table-striped table-bordered table-hover"
                                                width="100%">
                                                <thead>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px;" class="s13"
                                        id="i22dbl7s">
                                        <div id="i22dbl7sline" class="s13line">--%>
                            
                          <%-- changes by Aashitha 10262023--%>
                            <div style="position: absolute; top: 395px; height: 488px; width: 682px; left: 0px; border: 1px solid #cccccc; box-shadow: 0 1px 4px rgb(0 0 0 / 60%);"
                                class="s10" id="SITE_PAGES_2">     
                                <div style="position: absolute; top: 7px; height: 500px; width: 980px; left: 8px;"
                                    class="s11" id="mainPage_2">
                                    <div class="tab" style="width: 30%;">
                                        <a id="p" class="tablinks" onclick="openCity(event, 'Paris')" style="border-right: 1px solid #cccccc;">My Courses</a>
                                        <a id="s" class="tablinks" onclick="openCity(event, 'London')">Pending Courses</a>
                                    </div>

                                    <div id="mainPageinlineContent_2" class="s11inlineContent">
                                        <div id="London" class="tabcontent">
                                            <div style="position: absolute; top: 11.7%; height: 343px; width: 664px; left: 1px;"
                                                class="s12" id="studio_prop_2">
                                                <div id="studio_pro_2" style="box-shadow: 0 0px 1px rgb(0 0 0 / 60%);" class="s12bg">
                                                </div>
                                                <div id="studio_pro_dtl_2" class="s12inlineContent">

                                                    <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="studio_body_2">

                                                        <p style="font-size: 18px;" class="font_8">
                                                            <span style="font-size: 18px;">Pending Courses</span>
                                                        </p>
                                                    </div>
                                                    <div id="dtl_1" style="top: 31px; position: absolute; width: 98%; padding-left: 1%;">
                                                    </div>
                                                    <div id="studio_data_2" class="tab-pane" style="margin-top: 40px; height: 370px; overflow: auto;">
                                                        <div id="dtl_studio_2" style="display: none; padding-left: 1%; padding-right: 1%;">
                                                            <table cellpadding="0" cellspacing="0" border="0" id="tbl_studio_2" class="display table table-striped table-bordered table-hover"
                                                                width="100%">
                                                                <thead>
                                                                </thead>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px; border-bottom: 1px solid #717070;" class="s13"
                                                        id="data_2">
                                                        <div id="dataline_2" class="s13line">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="Paris" class="tabcontent">
                                              <div style="position: absolute; top: 76% ; height: 313px; width: 667px; left: 0px;"
                                                class="s12" id="i22d06md">
                                                <div id="i22d06mdbg" class="s12bg">
                                                </div>
                                                <div id="i22d06mdinlineContent" class="s12inlineContent">
                                                    <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i">
                                                        <p style="font-size: 18px;" class="font_8">
                                                            <span style="font-size: 18px;">My Courses</span>
                                                        </p>
                                                    </div>
                                                    <div id="divblanktable" style="top: 31px; position: absolute; width: 98%; padding-left: 1%;">
                                                        <table class="display table table-striped table-bordered table-hover">
                                                            <tr>
                                                                <td>Course
                                                                </td>
                                                                <td>Name
                                                                </td>
                                                                <td>Outline
                                                                </td>
                                                                <td>Students
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div id="instructorcourse" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">
                                                        <div id="dtl_course" style="display: none; padding-left: 1%; padding-right: 1%;">
                                                            <table cellpadding="0" cellspacing="0" border="0" id="tbl_course" class="display table table-striped table-bordered table-hover"
                                                                width="100%">
                                                                <thead>
                                                                </thead>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px;" class="s13"
                                                        id="i22dbl7s">
                                                        <div id="i22dbl7sline" class="s13line">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>     <%--last changes by Aashitha 10262023--%>


                                        </div>
                                    </div>
                                </div>
                            </div>
                          
                            <div style="position: absolute; top: 305%; height: 500px; width: 980px; left: 0px;"
                                class="s10" id="Div18">
                                <div style="position: absolute; top: 0px; height: 500px; width: 980px; left: 0px;"
                                    class="s11" id="Div19">
                                    <div id="Div20" class="s11bg">
                                    </div>
                                    <div id="Div21" class="s11inlineContent">
                                        <div style="position: absolute; top: 0px; height: 313px; width: 681px; left: 1px;"
                                            class="s12" id="Div22">
                                            <div id="Div23" class="s12bg">
                                            </div>
                                            <div id="Div24" class="s12inlineContent">
                                                <div style="position: absolute; top: 0; width: 98%; left: 7px;" class="s1" id="Div25">
                                                    <p style="font-size: 18px;" class="font_8">
                                                        <span style="font-size: 18px;">Summer / Winter School</span>
                                                    </p>
                                                </div>
                                                <div id="instructor_ws_course" class="tab-pane" style="margin-top: 26px; height: 284px; overflow: auto;">
                                                    <div id="dtl_ws_course" style="display: none; padding-left: 1%; padding-right: 1%;">
                                                        <table cellpadding="0" cellspacing="0" border="0" id="tbl_ws_course" class="display table table-striped table-bordered table-hover"
                                                            width="100%">
                                                            <thead>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                                <div style="position: absolute; top: 22px; height: 5px; width: 98%; left: 7px;" class="s13"
                                                    id="Div29">
                                                    <div id="Div30" class="s13line">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <%--<div style="position: absolute; top: 166%; height: 500px; width: 980px; left: 0px;"
                    class="s10" id="Div18">
                    <div style="position: absolute; top: 0px; height: 500px; width: 980px; left: 0px;"
                        class="s11" id="Div19">
                        <div id="Div20" class="s11bg">
                        </div>
                        <div id="Div21" class="s11inlineContent">
                            <div style="position: absolute; top: 0px; height: 313px; width: 681px; left: 1px;"
                                class="s12" id="Div22">
                                <div id="Div23" class="s12bg">
                                </div>
                                <div id="Div24" class="s12inlineContent">
                                    <div style="position: absolute; top: 0; width: 98%; left: 7px;" class="s1" id="Div25">
                                        <p style="font-size: 18px;" class="font_8">
                                            <span style="font-size: 18px;">Summer / Winter School</span>
                                        </p>
                                    </div>
                                    <div id="instructor_ws_course" class="tab-pane" style="margin-top: 26px; height: 284px; overflow: auto;">
                                        <div id="dtl_ws_course" style="display: none; padding-left: 1%; padding-right: 1%;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="tbl_ws_course" class="display table table-striped table-bordered table-hover"
                                                width="100%">
                                                <thead>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div style="position: absolute; top: 22px; height: 5px; width: 98%; left: 7px;" class="s13"
                                        id="Div29">
                                        <div id="Div30" class="s13line">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
        <div id="Div3" class="s9inlineContent">
            <div style="position: absolute; top: 0px; height: 500px; width: 345px; left: 715px;"
                class="s10" id="Div4">
                <div style="position: absolute; top: 0px; height: 500px; width: 345px; left: 0px;"
                    class="s11" id="Div7">
                    <div id="Div10" class="s11bg" style="text-align: right;">
                        <a href="http://14.139.122.150/" target="_blank" class="btn btn-sm btn-primary"><span
                            class="bigger-50">Smart Card</span><i class="icon-on-right icon-arrow-right"></i>
                        </a>
                    </div>
                    <div id="Div11" class="s11inlineContent">
                        <div style="position: absolute; top: 54px; height: 313px; width: 345px; left: 1px;"
                            class="s12" id="Div12">
                            <div id="Div13" class="s12bg">
                            </div>
                            <%--    <div id="Div14" class="s12inlineContent">
                                    <div style="position: absolute; top: 28px; width: 345px; left: 4px;" class="s1" id="Div15">
                                        <p style="font-size: 18px; text-align: center;" class="font_8">
                                            <span style="font-size: 18px;">Announcements/Important dates </span>
                                        </p>
                                        <p class="font_8">
                                            &nbsp;</p>
                                        <p class="font_8">
                                            These are normally academic announcements related to deadlines of course catalog,
                                            feedback grades etc.</p>
                                        <p class="font_8">
                                            &nbsp;</p>
                                        <p class="font_8">
                                            The screen rights are associated with the Academic Office.</p>
                                    </div>
                                    <div style="position: absolute; top: 52px; height: 5px; width: 97%; left: 7px;" class="s13"
                                        id="Div16">
                                        <div id="Div17" class="s13line">
                                        </div>
                                    </div>
                                </div>--%>
                            <div style="position: absolute; top: 6px; width: 345px; left: 4px;" class="s1" id="Div15">
                                <p style="font-size: 18px; text-align: center;" class="font_8">
                                    <span style="font-size: 18px;">Announcements/Important dates </span>
                                </p>
                            </div>
                            <div style="position: absolute; top: 33px; height: 5px; width: 97%; left: 7px;" class="s13"
                                id="Div16">
                                <div id="Div17" class="s13line">
                                </div>
                            </div>

                        
                            <div id="div_marq" class="s12inlineContent" style="margin-top: 10%; margin-left: 5px;">
                                <%--<marquee behavior="scroll" direction="up"  scrollamount="20" style="height: 274px;width: 335px;" id="marq" onmouseover="this.stop();" onmouseout="this.start();">
                                     
                                     </marquee>--%>
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="display: block;" id="Div35" class="s9inlineContent">
            <div id="Div26" style="top: 396px;left: 717px;height: 334px;width: 352px;" class="s12bg">
                            </div>
            <div style="position: absolute; top: 0px; height: 500px; width: 215px; left: 764px;" class="s1" id="Div2">              
                <div id="Div5" class="s11inlineContent">
                 <div style="position: absolute; top: 396px; height: 313px; width: 215px; left: 1px;"
                        class="s1" id="Div6">
                     
                            <div style="position: absolute; top: 0; width: 349px; left: -45px;" class="s1" id="Div9">
                  
                            <div style="margin-top: 2%;" id=""><span style="font-size: 18px; font-size: 15px; margin-top: 10px;"><b>Studio Proposal Timeline Details: </b></span></div>
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 100%;">
                                    <table>
                                        <td width="70%">1. Submission of 200 Words and personal details:</td>
                                        <td width="40%"><b>25th September</b></td>
                                </div>
                                <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->
                            </div>
                            <!-- Nitin on 04-09-2023 <div style="margin-top: 2%;" id="">                                    <div style="float: left; width: 100%;"><table><td width="74%"> 2. Notification to shortlisted studios  : </td><td><b>16th October</b></td></div>                                    <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a>                             </div>    -->
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 100%;">
                                    <table>
                                        <td width="70%">2. Uploading detailed studio brief by new tutors : </td>
                                        <td><b>16th -28th October</b></td>
                                </div>
                                <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->
                            </div>
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 100%;">
                                    <table>
                                        <td width="70%">3. Uploading detailed studio brief by CEPT full-time/Adjunct tutors  : </td>
                                        <td><b>2nd -28th October</b></td>
                                </div>
                                <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->
                            </div>
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 100%;">
                                    <table>
                                        <td width="72%">4. Notification of Studio Approval  : </td>
                                        <td><b>2nd December</b></td>
                                </div>
                                <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->
                            </div>
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 100%;">
                                    <table>
                                        <td width="71%">5. Studio selection process : </td>
                                        <td><b>1st -6th January</b></td>
                                </div>
                                <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->
                            </div>
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 100%;">
                                    <table>
                                        <td width="77%">6. Spring-24 semester begins : </td>
                                        <td><b>8th January</b></td>
                                </div>
                                <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->
                            </div>
                    
                               
                            </div>
                          
                      
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div style="position: absolute; top: 40%; height: 500px; width: 64.3%; left: 0px; padding: 1px;" id="for_call_for_studio">
        <%--<div class="row-fluid" style="margin-top: 2%;">
            <h4>Download <span style="color: red;">*</span></h4>
            <h6>(<span class="semdesc"></span>)</h6>
            <br />
        </div>--%>
        <%--<div style="border: 1px solid black; padding: 10px;">
            <h5>Studio Unit Framework:</h5>
            <h6 style="color: blue;">Materials on Studio Teaching at CEPT University: Please go through the references before making the proposal.</h6>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">1. Introduction to Studio Unit Framework [pdf] </div>
                <a href="../../StudioDetails/Introduction to Studio Unit Framework.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">2. Note on L2/L3 Studios [pdf] </div>
                <a href="../../StudioDetails/Note on L2-L3 Studio-1-1.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">3. Note on Learning Outcomes' [pdf] </div>
                <a href="../../StudioDetails/Note on Learning Outcomes.pdf" download>Download</a>
            </div>
        </div>--%>
        <div style="border: 1px solid black; padding: 10px;" id="studio_id">
            <h5>Studio Unit Framework:</h5>
            <h6 style="color: blue;">Materials on Teaching and Learning in Studio Units at CEPT University: Please go through the references before making the proposal.</h6>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">1. Pedagogic Philosophy </div>
                <a href="../../StudioDetails/1 - Pedagogic Philosophy.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">2. Program Structure </div>
                <a href="../../StudioDetails/2 - Program Structure.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">3. Teaching Framework for Studio units </div>
                <a href="../../StudioDetails/3 - Teaching Framework for Studio units.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">4. Studio Units Framework & Preparation </div>
                <a href="../../StudioDetails/4 - Studio Unit Framework & Preparation.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">5. Handbook for Unit Tutors </div>
                <a href="../../StudioDetails/Handbook for Unit Tutors.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">6. Mode of Teaching </div>
                <a href="../../StudioDetails/Mode of Teaching.pdf" download>Download</a>
            </div>
        </div>
        <br />
        <%--<div style="border: 1px solid black; padding: 10px;">
            <h5>References to prepare Studio Proposal:</h5>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">1. Handbook for Unit Tutors</div>
                <a href="../../StudioDetails/Handbook for Unit tutors.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">2. Sample Presentation – Level 2 Studio [pdf]</div>
                <a href="../../StudioDetails/Sample Presentation- L2.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">3. Studio Proposal Template [ppt] – Level 2 </div>
                <a href="../../StudioDetails/Studio Presentation Template  - L2.pptx" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">4. Studio Proposal Template [ppt] – Level 3 </div>
                <a href="../../StudioDetails/Studio Presentation Template  - L3.pptx" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">5. Studio Proposal Template [ppt] – Level 4 </div>
                <a href="../../StudioDetails/Studio Presentation Template - L4.pptx" download>Download</a>
            </div>
        </div>--%>
        <div style="border: 1px solid black; padding: 10px;" id="temp_id">
            <h5>Templates/Samples For Studio Brief:</h5>
            <%--   <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">1. Level 2 studio proposal presentation template </div>
                <a href="../../StudioDetails/Level 2 studio proposal presentation template.pptx" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">2. Level 3 studio proposal presentation template </div>
                <a href="../../StudioDetails/Level 3 studio proposal presentation template.pptx" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">3. Level 4 studio proposal presentation template </div>
                <a href="../../StudioDetails/Level 4 studio proposal presentation template.pptx" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">4. Sample studio proposal </div>
                <a href="../../StudioDetails/Sample studio proposal.pdf" download>Download</a>
            </div>--%>

            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">1. L2/L3/L4 Studio Brief Template</div>
                <a href="../../StudioDetails/Level 2 studio proposal presentation template.pptx" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">2. Sample Studio Weekly Exercises </div>
                <a href="../../StudioDetails/Level 3 studio proposal presentation template.pptx" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">3. Sample Studio Brief-As seen by Students </div>
                <a href="../../StudioDetails/Level 4 studio proposal presentation template.pptx" download>Download</a>
            </div>

            <%--      <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">5. Studio Proposal Template [ppt] – Level 4 </div>
                <a href="../../StudioDetails/Studio Presentation Template - L4.pptx" download>Download</a>
            </div> --%>
        </div>
        <br />

        <%--<div style="border: 1px solid black; padding: 10px;">
            <h5>References to prepare Studio Brief (for CAC shortlisted/approved studios):</h5>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">1. Sample Studio Brief [pdf]</div>
                <a href="../../StudioDetails/Sample Studio Brief.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">2. Studio Brief template [doc]</div>
                <a href="../../StudioDetails/Studio Brief Template.pdf" download>Download</a>
            </div>
        </div>--%>

        <div style="border: 1px solid black; padding: 10px;" id="reference_id">
            <h5>References to prepare Studio Brief (for CAC shortlisted/approved studios) : </h5>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">1. Sample Studio Brief [pdf]</div>
                <a href="../../StudioDetails/Sample Studio Brief.pdf" download>Download</a>
            </div>
            <div style="margin-top: 1%;" id="">
                <div style="float: left; width: 50%;">2. Studio Brief template [doc]</div>
                <a href="../../StudioDetails/Studio Brief Template.pdf" download>Download</a>
            </div>
        </div>

        <div id="student_view_list" style="display: none">
            <div style="background-color: White;">
                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <strong>Student Details</strong>
                    </div>

                    <div id="DataList1" style="display: none">
                        <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div id="DataList2" style="display: none">
                        <table cellpadding="0" cellspacing="0" border="0" id="ws_example" class="display table table-striped table-bordered table-hover"
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
        </div> <%--changes by Aashitha 10262023--%>

        <input type="hidden" runat="server" clientidmode="Static" id="hdn_msg" value="" />
        <input type="hidden" runat="server" clientidmode="Static" id="hdn_user_type" value="" />
        <input type="hidden" runat="server" clientidmode="Static" id="hdn_tutor_type" value="" />
        <input type="hidden" runat="server" clientidmode="Static" id="hdn_is_submit" value="" />

     <script>   /*changes by Aashitha 10262023*/
         function openCity(evt, cityName) {
             debugger;
             var i, tabcontent, tablinks;
             tabcontent = document.getElementsByClassName("tabcontent");
             for (i = 0; i < tabcontent.length; i++) {
                 tabcontent[i].style.display = "none";
             }
             tablinks = document.getElementsByClassName("tablinks");
             for (i = 0; i < tablinks.length; i++) {
                 //if (cityName == "Paris") {
                 tablinks[i].className = tablinks[i].className.replace(" active_on", "");
                 //} else {
                 //    tablinks[i].className = tablinks[i].className.replace(" active", "");
                 //}
             }
             document.getElementById(cityName).style.display = "block";
             //if (cityName == "Paris") {
             evt.currentTarget.className += " active_on";
             //} else {
             //    evt.currentTarget.className += " actives";
             //}
         }
     </script>
        <script>
            function myFunction(course_code) {
                debugger;
                var rowId = course_code;
                // var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor&icc=" + rowId + "";
                var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor&per=p&icc=" + rowId + "";
                window.open(url, "_self");
            }
        </script>


      <script type="text/javascript">

          $('#pdclick').click(function (e) {
              var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
              window.open(url, "_self");
          });
          $('#bdclick').click(function (e) {
              if ($("#hdn_tutor_type").val() == "temp") {
                  return false;
              } else {
                  var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
                  window.open(url, "_self");
              }
          });
          $('#tutor_disabled').click(function (e) {
              if ($("#hdn_tutor_type").val() == "temp") {
                  return false;
              }
          });
          $('#sp_disabled').click(function (e) {
              if (block) {
                  return false;
              }
          });
          $('#lp_disabled').click(function (e) {
              if (block) {
                  return false;
              }
          });
      </script>
</asp:Content>
