<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Temp_Dashboard.aspx.cs" Inherits="Admin_Master_Temp_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

        .active_on {
            background-color: #ccc;
        }

        .active_off {
            background-color: #ccc;
        }

        /*  .actives {
            width: 52.6% !important;
        }

        .activee {
            width: 29.7% !important;
        }*/

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
    </style>
    <style>
        body {
            font-family: Arial;
        }

        /* Style the tab */
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
        }

            /* Style the buttons inside the tab */
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

                /* Change background color of buttons on hover */
                .tab a:hover {
                    background-color: #ddd;
                }

                /* Create an active/current tablink class */
                .tab a.active {
                    background-color: #ccc;
                }

        /* Style the tab content */
        .tabcontent {
            display: none;
            padding: 6px 12px;
            /*border: 1px solid #ccc;*/
            border-top: none;
        }
         #pdclick:hover {
    text-decoration: underline;
}
    </style>
    <script>
        var block = false;
        var oTable_studio;
        var oTable_TA;
        $(document).ready(function ()
        {
            $("#sd").css('display', 'none');
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

            $("#i22d06md_new_4").remove();

            if ($("#hdn_user_type").val() == "I2" || $("#hdn_user_type").val() == "PC") {
                //style = "position: absolute; top: 118px; height: 500px; width: 980px; left: 0px;"
                //$("#i22d06md").css('top', '173px');20022021
                $("#i22d06md").css('top', '132%');
                $("#Div22").css('top', '98%');
                //$("#Div22").css('top', '162px');
                $("#for_I2").css('display', '');//commented 03012021
                //$("#for_I2").css('display', 'none');//uncommented 03012021
                //$("#i22d06md_new").css('display', 'none');//uncommented 03012021
                //$("#i22d06md_new_2").css('display', 'none');//uncommented 03012021
                //$("#i22d06md_new_3").css('display', 'none');//uncommented 03012021
                call_for_studio_status_track();
            } else {
                $("#Div22").css('top', '-115px');
                //$("#i22d06md_new").remove();
                //$("#i22d06md_new_2").remove();
                //$("#i22d06md_new_3").remove();
            }

            if ($("#hdn_tutor_type").val() == "temp") {
                $("#bank_tutor").addClass("inactive");
                $("#bank_tutor").removeClass("active");
                $("#tutor_disabled").prop("disabled", true);
                //$("#for_tutor").remove();
            } else {
                $("#for_call_for_studio").remove();
            }
            TA_dtl();
            studio_dtl();
            

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

            function TA_dtl() {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Get_Save_Ta_Application_dtl",
                        async: false,
                        data: "{user_id :''}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                display_TA_dtl(data.d);
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                return false;
            }

            function studio_dtl() {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Get_studio_proposal_dtl_dashboard",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                display_studio_dtl(data.d);
                            }
                            //else {
                            //    display_student_dtl_empty();
                            //}

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                return false;
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
                        //{
                        //    "sTitle": "Action", "bSortable": false, "mData": null, "mRender": function (data) {
                        //        if (data.is_submit == 'Y') {
                        //            return "<center>Submitted</center>";
                        //        }
                        //        else {
                        //            return '<center><a id=' + data.studio_code + ' onclick="rowClick_edit(this)">Edit</a></center>';
                        //        }
                        //        //return '<center><a style="cursor:pointer" class="course_student" onclick="rowClick(this,oTable2)">View List</a></center>';
                        //    }
                        //}
                        {
                            "sTitle": "Studio Proposal", "bSortable": false, "mData": null, "mRender": function (data)
                            {
                                if (data.pc_status_new == 'R') {
                                    return '<center></center>';
                                }
                                else if (data.hr_status_new == 'R') {
                                    return '<center></center>';
                                }

                                else if (data.is_submit == 'Y' && data.studio_brief_status == 'Y')
                                {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.is_submit == 'Y')
                                {
                                    return "<center>Submitted</center>";
                                }
                                else {
                                    return '<center><a id=' + data.studio_code + ' onclick="rowClick_edit(this)">Edit</a></center>';
                                }

                            }
                        },
                        {
                            "sTitle": "Bank Details", "bSortable": false, "mData": null, "mRender": function (data) {

                                if (data.studio_brief_status == 'Y')
                                {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.studio_brief_status == 'A')
                                {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.pc_status_new == 'R')
                                {
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

                                if ($('#hdnusertype').val() == 'I2')
                                {
                                    if (data.is_submit == 'Y' && data.approved == 'Y') {
                                        $("#sd").css('display', 'block');
                                    }
                                    if (data.studio_brief_status == 'Y')
                                    {
                                        //return "<center>Under Process</center>";   //change Nitinbhai 20042021
                                        //return "<center>Submitted</center>";
                                        return "<center><a onclick='ViewBrief(" + '"' + data.new_course_code + '","' + data.semester_type + '","' + data.year_semester + '"' + ")'>View</a></center>";
                                    }
                                    else if (data.studio_brief_status == 'A') {
                                        //return "<center>Submitted</center>";
                                        return "<center><a onclick='ViewBrief(" + '"' + data.new_course_code + '","' + data.semester_type + '","' + data.year_semester + '"' + ")'>View</a></center>";
                                    }

                                    //else if (data.is_submit == 'Y' && data.approved == 'Y')
                                    else if (data.is_submit == 'Y' && data.approved == 'Y' && data.brief_edit_status == 'Y')
                                    {
                                       // var studio_c = "";
                                       // if (data.new_course_code != '') {
                                       //     studio_c = data.new_course_code;
                                       // }
                                       // else { studio_c = data.studio_code;}
                                        var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status + "_" + data.brief_edit_status;
                                         
                                        return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">Edit</a></center>';
                                        return '<center></center>';
                                    }
                                    else {
                                        return '<center></center>';
                                    }
                                }
                                else
                                {
                                    if (data.studio_brief_status == 'Y') {
                                        //return "<center>Under Process</center>";   //change Nitinbhai 20042021
                                        //return "<center>Submitted</center>";
                                        return "<center><a onclick='ViewBrief(" + '"' + data.new_course_code + '","' + data.semester_type + '","' + data.year_semester + '"' + ")'>View</a></center>";
                                    }
                                    else if (data.studio_brief_status == 'A') {
                                        //return "<center>Submitted</center>";
                                        return "<center><a onclick='ViewBrief(" + '"' + data.new_course_code + '","' + data.semester_type + '","' + data.year_semester + '"' + ")'>View</a></center>";
                                    }

                                    //else if (data.is_submit == 'Y' && data.approved == 'Y')
                                    else if (data.is_submit == 'Y' && data.approved == 'Y') {
                                        //var studio_c = "";
                                        //if (data.new_course_code != '') {
                                        //    studio_c = data.new_course_code;
                                        //}
                                        //else { studio_c = data.studio_code; }
                                        //var data_dtl = studio_c + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status;
                                        var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status;

                                        return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">Edit</a></center>';
                                        return '<center></center>';
                                    }
                                    else {
                                        return '<center></center>';
                                    }
                                }
                                

                            }
                        },
                        {
                            "sTitle": "To be Decided", "bSortable": false, "mData": null, "mRender": function (data) {

                                if (data.pc_status_new == 'R')
                                {
                                    return '<center></center>';
                                }
                                else if (data.hr_status_new == 'R')
                                {
                                    return '<center></center>';
                                }

                                else if (data.is_submit == 'Y' && data.brief_edit_status == 'Y')
                                {
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

                            if (data.hr_status_new == 'R')
                            {
                                if (data.hr_remark_new != '') {
                                    return "<center>HR-(" + data.hr_remark_new + ")</center>";
                                }
                                else { return "<center></center>";}
                                
                            }

                            if (data.pc_status_new == 'R')
                            {
                                if (data.pc_remark_new != '') {
                                    return "<center>PC-(" + data.pc_remark_new + ")</center>";
                                }
                                else { return "<center></center>"; }

                            }


                            if (data.hr_remark_new != '')
                            {
                                return "<center>HR-(" + data.hr_remark_new + ")</center>";
                            }
                            if (data.pc_remark_new != '')
                            {
                                return "<center>PC-(" + data.pc_remark_new + ")</center>";
                            }

                            if (data.status == 'A' && data.studio_inst == 'N' && data.hr_status == '')
                            {
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

           

            function display_TA_dtl(data) {
                $('#ta_studio').css('display', 'none');

                if (oTable_TA != null) {
                    oTable_TA.fnDestroy();
                    $("#ta_studio").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="ta_tbl_studio" width="100%"><thead></thead><tbody> </tbody></table>');
                }

                oTable_TA = $("#ta_tbl_studio").dataTable({
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

                        { "sTitle": "Name", "mData": "inst_name" },

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
                        { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                        {
                            "sTitle": "Studio Title", "bSortable": false, "mData": null, "mRender": function (data) {
                                if (data.studio_title != '') {
                                    return '<center>' + data.studio_title + '</center>';
                                }
                                else {
                                    return '';
                                }

                            }
                        },
                        {
                            "sTitle": "Selected By", "bSortable": false, "mData": null, "mRender": function (data) {
                                if (data.full_name != '') {
                                    return '<center>' + data.full_name+'</center>';
                                }
                                else {
                                    return '';
                                }

                            }
                        },
                        {
                            "sTitle": "HR Remark", "bSortable": false, "mData": null, "mRender": function (data) {
                                if (data.remark != '') {
                                    return '<center>' + data.remark + '</center>';
                                }
                                else {
                                    return '';
                                }

                            }
                        },

                        {
                            "sTitle": "HR Status", "bSortable": false, "mData": null, "mRender": function (data) {
                                if (data.hr_approved == 'Y') {
                                    return '<center>Approved</center>';
                                }
                                if (data.hr_approved == 'R') {
                                    return '<center>Rejected</center>';
                                }
                                else {
                                    return '';
                                }

                            }
                        },

                        {
                            "sTitle": "Status", "bSortable": false, "mData": null, "mRender": function (data) {

                                if (data.is_submit == 'Y') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.is_submit == 'N') {

                                    var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status + "_" + data.brief_edit_status;
                                    return '<center><a id=' + data_dtl + ' onclick="edit_ta_application(this)">Edit</a></center>';
                                }
                                else {
                                    return '<center></center>';
                                }

                            }
                        }
                    ]
                });

                $('#ta_studio').css('display', 'block');
            }


            openCity(event, 'London');
        });

      

        function ViewBrief(CourseCode, semester, year) {
            semester = semester;
            year_code = year;
            $('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/OutLinePDF.aspx?course_id=' + CourseCode + '&sem_code=' + semester + '&year_code=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
        }
    </script>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_user_type" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_tutor_type" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_is_submit" value="" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row" style="margin-top: 11px; width: 64.3%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: block;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Apply As TA 
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue; display:none;"><a href="Studio_Proposal_dtl_new.aspx">View Submitted Proposal</a></span>
            <%--<span style="font-size: 10pt; float: right; margin-right: 0.8%; text-shadow: 0 0 slateblue;">|</span>
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a></span>--%>
        </h5>
        <div style="margin-left: 1%; border-top: 1px solid #717070; width: 97.8%;"></div>
        <ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px; width: 100%; margin-bottom: 10px; margin-top: 5px;">
            <%--<span style="font-size: 10pt; text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a>: If you are proposing a new studio, <a href="Interested_Program.aspx">click here</a> to submt your proposal.</span></br></br>
            <span style="font-size: 10pt; text-shadow: 0 0 slateblue;"><a href="Existing_Interested_Program.aspx">Existing Studio Brief</a>: If you are proposing an existing CAC approved studio unit from the previous semesters, <a href="Existing_Interested_Program.aspx">click here</a> to retrieve/add/edit and submit the brief with no change/ minor change (changing site location or order of exercises.</span></br></br>--%>
            <li class="col-md-3 active" id="pd" style="width: 27.7% !important"><%--18--%> <%--If you are proposing to run and existig studio unit that you have already offered in a previous semester to submit the detailed studio brief --%>
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong></strong></h5>
                       <p id="pdclick" style="color: black;">Apply As TA</p>
                        

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="ip" style="width: 28% !important; display:block;" ><%--18--%>
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-book"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong></strong></h5>
                        <a id="lp_disabled" style="color: black;">Apply As Tutor</a>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="sd" style="width: 28% !important; display:none;"><%--25--%>
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
            <%--   <li class="col-md-3 active" id="bank_tutor" style="width: 18% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 4:</strong></h5>
                        <p id="bdclick" style="color: black;">Bank Details</p>
                    </div>
                </div>
            </li>--%>
        </ol>
    </div>

    <div style="position: absolute; top: 217px; height: 500px; width: 980px; left: 0px;"
        class="s9" id="for_tutor">
        <div id="PAGES_CONTAINERscreenWidthBackground" class="s9screenWidthBackground" style="width: 1349px; left: -185px;">
        </div>
        <div id="PAGES_CONTAINERcenteredContent" class="s9centeredContent">
            <div id="PAGES_CONTAINERbg" class="s9bg">
            </div>
            <div id="PAGES_CONTAINERinlineContent" class="s9inlineContent">
                <div style="position: absolute; top: 76px; height: 488px; width: 682px; left: 0px; border: 1px solid #cccccc; box-shadow: 0 1px 4px rgb(0 0 0 / 60%);"
                    class="s10" id="SITE_PAGES">
                    <div style="position: absolute; top: 7px; height: 500px; width: 980px; left: 8px;"
                        class="s11" id="mainPage">
                        <%-- <div id="mainPagebg" class="s11bg">
                        </div>--%>

                        <div class="tab" style="width: 36%; display:none;">
                            <a id="s" class="tablinks" onclick="openCity(event, 'London')" style="border-right: 1px solid #cccccc;">Studio Proposal Details</a>
                            <a id="p" class="tablinks" onclick="openCity(event, 'Paris')">My Proposal</a>
                        </div>

                        <div id="mainPageinlineContent" class="s11inlineContent">
                            <div id="London" class="tabcontent">
                                <div style="position: absolute; height: 250px; width: 665px; left: 0px; top: 10px;" class="s12" id="i22d06md_new">
                                    <div id="i22d06mdbg_new" style="top: -4px; box-shadow: 0 0px 1px rgb(0 0 0 / 60%);" class="s12bg">
                                    </div>
                                    <div id="i22d06mdinlineContent_new" class="s12inlineContent">
                                        <%--<div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new">
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
                                    </div>--%>
                                        <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new">
                                            <p style="font-size: 18px;" class="font_8">
                                                <span style="font-size: 18px;">TA Application:</span>
                                            </p>
                                        </div>
                                        <div id="divblanktable_new" style="top: 16%; position: absolute; width: 98%; padding-left: 1%;">
                                         <div id="ta_data" class="tab-pane" style="height: 297px; overflow: auto;">
                                            <div id="ta_studio" style="display: none; padding-left: 1%; padding-right: 1%;">
                                                <table cellpadding="0" cellspacing="0" border="0" id="ta_tbl_studio" class="display table table-striped table-bordered table-hover"
                                                    width="100%">
                                                    <thead>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        </div>

                                        <div id="instructorcourse_new" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">
                                        </div>
                                        <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px; border-bottom: 1px solid #717070;" class="s13" id="i22dbl7s_new">
                                        </div>
                                    </div>
                                </div>
                                <div style="position: absolute; top: 55.5%; height: 140px; width: 666px; left: 0px;" class="s12" id="i22d06md_new_2">
                                    <div id="i22d06mdbg_new_2" style="box-shadow: 0 0px 1px rgb(0 0 0 / 60%);" class="s12bg">
                                    </div>
                                    <div id="i22d06mdinlineContent_new_2" class="s12inlineContent">
                                        <%--<div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new_2">
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
                                    </div>--%>
                                        <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new_2">
                                            <p style="font-size: 18px;" class="font_8">
                                                <span style="font-size: 18px;">Call For Tutor Studio:</span>
                                            </p>
                                        </div>
                                        <div id="divblanktable_new_2" style="top: 20%; position: absolute; width: 98%; padding-left: 1%;">
                                            <div id="studio_data" class="tab-pane" style="margin-top: 16px; height: 297px; overflow: auto;">
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
                                        </div>
                                        <div id="instructorcourse_new_2" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">
                                        </div>
                                        <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px; border-bottom: 1px solid #717070;" class="s13" id="i22dbl7s_new_2">
                                        </div>
                                    </div>
                                </div>
                                <div style="position: absolute; top: 77%; height: 100px; width: 681px; left: 1px;" class="s12" id="i22d06md_new_4">
                                    <div id="i22d06mdbg_new_4" class="s12bg">
                                    </div>
                                    <div id="i22d06mdinlineContent_new_4" class="s12inlineContent">
                                        <%--<div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new_2">
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
                                    </div>--%>
                                        <div style="position: absolute; top: 5px; width: 98%; left: 7px;" class="s1" id="i22cwf5i_new_2">
                                            <p style="font-size: 18px;" class="font_8">
                                                <span style="font-size: 18px;">References to prepare Studio Brief (for CAC shortlisted/approved studios) :</span>
                                            </p>
                                        </div>
                                        <div id="divblanktable_new_4" style="top: 35%; position: absolute; width: 98%; padding-left: 1%;">
                                            <div style="margin-top: 1%;" id="">
                                                <div style="float: left; width: 50%;">1. Sample Studio Brief [pdf]</div>
                                                <a href="../../StudioDetails/Sample Studio Brief.pdf" download>Download</a>
                                            </div>
                                            <div style="margin-top: 1%;" id="">
                                                <div style="float: left; width: 50%;">2. Studio Brief template [doc]</div>
                                                <a href="../../StudioDetails/Studio Brief Template.pdf" download>Download</a>
                                            </div>
                                        </div>
                                        <div id="instructorcourse_new_4" class="tab-pane" style="margin-top: 40px; height: 284px; overflow: auto;">
                                        </div>
                                        <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px; border-bottom: 1px solid #717070;" class="s13" id="i22dbl7s_new_4">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="Paris" class="tabcontent">
                                <div style="position: absolute; top: 11.7%; height: 343px; width: 664px; left: 1px;"
                                    class="s12" id="studio_prop">
                                    <div id="studio_pro" style="box-shadow: 0 0px 1px rgb(0 0 0 / 60%);" class="s12bg">
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
                                       <%-- <div id="studio_data" class="tab-pane" style="margin-top: 40px; height: 297px; overflow: auto;">
                                            <div id="dtl_studio" style="display: none; padding-left: 1%; padding-right: 1%;">
                                                <table cellpadding="0" cellspacing="0" border="0" id="tbl_studio" class="display table table-striped table-bordered table-hover"
                                                    width="100%">
                                                    <thead>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>--%>
                                        <div style="position: absolute; top: 33px; height: 5px; width: 98%; left: 7px; border-bottom: 1px solid #717070;" class="s13"
                                            id="data">
                                            <div id="dataline" class="s13line">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--<div style="position: absolute; top: 110%; height: 100px; width: 681px; left: 1px;" class="s12" id="i22d06md_new_3">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="Div3" class="s9inlineContent">
        <div style="position: absolute; top: 16%; height: 500px; width: 345px; left: 715px;"
            class="s10" id="Div4">
            <div style="position: absolute; top: 0px; height: 500px; width: 345px; left: 0px;"
                class="s11" id="Div7">

                <div id="Div11" class="s11inlineContent">
                    <div style="position: absolute; top: 54px; height: 250px; width: 345px; left: 1px;"
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
                        <div style="position: absolute; top: 6px; width: 345px; left: 4px; text-align: center;" class="s1" id="Div15">
                            <p style="font-size: 18px;" class="font_8">
                                <span style="font-size: 18px; margin-left: 3px; text-align: center;">Help</span>
                            </p>
                        </div>
                        <div style="position: absolute; top: 30px; height: 5px; width: 97%; left: 7px;" class="s13"
                            id="Div16">
                            <div style="margin-top: 2%;" id="">
                                <%--<span style="font-size: 18px;font-size: 15px;margin-top:10px;"> References to prepare Studio Brief (for CAC shortlisted/approved studios) </span>--%>
                                <span style="font-size: 18px; font-size: 15px; margin-top: 10px;">References to prepare mp4 video from Presentation slide: </span>
                            </div>
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 86%;">1. How to make mp4 video from power-point presentation</div>
                                <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a>
                            </div>
                            <div style="margin-top: 10%;" id="">
                                <div style="float: left; width: 86%;">2. How to make a narrated PowerPoint video</div>
                                <a href="https://www.youtube.com/watch?v=Y5dgwwa5XRA&amp;t=3s" target="_blank">View</a>
                            </div>  
                            <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 86%;">3. Connect guide to submit new proposal</div>
                                <a href="https://connect.cept.ac.in//Help//Connect guide to submit new proposal.pdf" target="_blank">View</a>
                            </div>
                             <div style="margin-top: 2%;" id="">
                                <div style="float: left; width: 86%;">4. Connect guide to submit the existing brief</div>
                                <a href="https://connect.cept.ac.in//Help//Connect guide to submit the existing brief.pdf" target="_blank">View</a>
                            </div>
                            <div id="Div17" class="s13line">
                            </div>
                        </div>
                      <%--  <div style="position: absolute; top: 250px; width: 345px; left: 4px; text-align: center;" class="s1" id="Div15">	
                            <p style="font-size: 18px;" class="font_8">	
                                <span style="font-size: 18px; margin-left: 3px; text-align: center;">Timeline</span>	
                            </p>	
                           </div>	
						   	
					    <div style="position: absolute; top: 280px; height: 5px; width: 97%; left: 7px;" class="s13"	
                            id="Div16">	
                            <div style="margin-top: 2%;" id="">	
                                    <span style="font-size: 18px; font-size: 15px; margin-top: 10px;">Studio Proposal Timeline Details: </span>	
                            </div>	
							 <div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 1. Submission of 150 Words  : </td><td> <b>6th March to 20th March</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							 <div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 2. Notification to shortlisted studios  : </td><td> <b>11th April</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							 <div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 3. Uploading Detailed brief for new tutors  : </td><td> <b>11th April- 7th May</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							<div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 4. Uploading Detailed brief for CEPT full time and Adjunct faculty members  : </td><td> <b>28th March- 24th Apri</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							<div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 5. Studio selection process for students  : </td><td> <b>25th-30th July</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							<div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 6. Monsoon semester starts  : </td><td> <b>1st August 22</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
						   </div>--%>

                        <div style="position: absolute; top: 250px; width: 345px; left: 4px; text-align: center;" class="s1" id="Div15">	
                            <p style="font-size: 18px;" class="font_8">	
                                <span style="font-size: 18px; margin-left: 3px; text-align: center;">Timeline</span>	
                            </p>	
                           </div>	
						   	
						<div style="position: absolute; top: 280px; height: 5px; width: 97%; left: 7px;" class="s13" id="Div16">	
                            <div style="margin-top: 2%;" id="">	
                                    <span style="font-size: 18px; font-size: 15px; margin-top: 10px;">Studio Proposal Timeline Details: </span>	
                            </div>	
							 <div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 1. Submission of 150 Words  : </td><td> <b>26th Aug- 25th Sept</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							 <div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 2. Notification to shortlisted studios  : </td><td> <b>8th Oct</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							 <div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 3. Uploading Detailed brief for new tutors  : </td><td> <b>8th Oct- 15th Oct</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							<div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 4. Uploading Detailed brief for CEPT full time and Adjunct faculty members  : </td><td> <b>26th Sept- 15th Oct</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							<div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 5. Studio selection process for students  : </td><td> <b>2nd-6th Jan</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
							<div style="margin-top: 2%;" id="">	
                                <div style="float: left; width: 86%;"><table><td width="70%"> 6. Monsoon semester starts  : </td><td> <b>9th Jan 2023</b></td></div>	
                             <!--   <a href="https://support.microsoft.com/en-us/office/record-a-slide-show-with-narration-and-slide-timings-0b9502c6-5f6c-40ae-b1e7-e47d8741161c" target="_blank">View</a> -->	
                            </div>	
						   </div>


                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="ifrm_outline" style="display: none;"></div>

    <script>
        function openCity(evt, cityName) {
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

    <script type="text/javascript">
        $('#pdclick').click(function (e) {

            var url = "TA_Application.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
            window.open(url, "_self");
        });
        $('#bdclick').click(function (e) {
            if ($("#hdn_tutor_type").val() == "temp") {
                return false;
            } else {
                var url = "TA_Application.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
                window.open(url, "_self");
            }
        });
        $('#tutor_disabled').click(function (e) {
            if ($("#hdn_tutor_type").val() == "temp") {
                return false;
            }
        });
        $('#sp_disabled').click(function (e) {
            //if (block) {
            //    return false;
            //}
        });
        $('#lp_disabled').click(function (e) {
            
            var url = "Studio_Proposal_Dashboard.aspx";
            window.open(url, "_self");
            //href="Studio_Proposal_Dashboard.aspx?c=TU"
            //if (block) {
            //    return false;
            //}
        });
        function rowClick_edit(row) {
            var origion = window.location.origin + '/';
            window.open(origion + "Admin/Master/Interested_Program.aspx?studio_code=" + row.id + "", '_blank');
        }
        function rowClick_studio_brief(row) {
            debugger;
            var split_data = row.id.split('_');
            var origion = window.location.origin + '/';
            if (split_data[3] != 'S') {
                //window.open(origion + "Admin/Master/Add_bank_detl.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
                //window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
                window.open(origion + "Admin/Master/Add_bank_detl.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "&b=" + split_data[4] + "", '_blank');
            }
            else {
                var sem_dt = split_data[1] + split_data[2];
                //window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
                window.open(origion + "Admin/Master/Add_bank_detl.aspx?c=" + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "&b=" + split_data[4] + "", '_blank');
                // window.open(origion + "Admin/Master/Add_bank_detl.aspx?c=" + + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
            }

        }

        function edit_ta_application(row) {
            var origion = window.location.origin + '/';
            window.open(origion + "Admin/Master/TA_Application.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor", '_blank');
        }
        function rowClick_to_be_decided(row) {


            var split_data = row.id.split('_');
            var origion = window.location.origin + '/';

            window.open(origion + "Admin/Master/Tobedecided_inst_dtl.aspx?c=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
            // window.open(origion + "Admin/Master/Add_bank_detl.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');


        }
        function rowClick_delete(row) {
            bootbox.confirm('Are you sure you want to delete this Studio Proposal?', function (result) {

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

