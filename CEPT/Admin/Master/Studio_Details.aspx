<%@ Page Title="Studio Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Studio_Details.aspx.cs" Inherits="Admin_Master_Studio_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable_studio;
        $(document).ready(function () {
            var sem = '';
            var year = '';
            var FileName = '';
            var FileNameBrief = '';
            var block = false;
            //getCurrentSemYearCallForStudio();
            //GetInstructorStudioProposalDetails();
            //call_for_studio_status_track();
            studio_dtl();
            var studio_code = getQueryStringValue('studio_code');
            function call_for_studio_status_track() {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/call_for_studio_status_track",
                        //async: false,
                        data: "{studio_code:'" + getQueryStringValue('studio_code') + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                var track_call_for_studio = JSON.parse(data.d);
                                if (track_call_for_studio[0]["value"] == "Y") {
                                    $("#pd").css('background-color', 'white');
                                } else {
                                    $("#pd").css('background-color', 'grey');
                                    block = true; //uncomment this line to work logic of stop going next button - Mahroofbhai - 14 10 2020
                                    //$("#ip").addClass("active");
                                    //$("#ip").removeClass("inactive");
                                    //$("#sd").addClass("inactive");
                                    //$("#sd").removeClass("active");
                                }
                                if (track_call_for_studio[1]["value"] == "Y") {
                                    $("#ip").css('background-color', 'white');
                                } else {
                                    $("#ip").css('background-color', 'grey');
                                }
                                if (track_call_for_studio[2]["value"] == "Y") {
                                    $("#sd").css('background-color', 'white');
                                } else {
                                    $("#sd").css('background-color', 'white');
                                }
                                if (track_call_for_studio[3]["value"] == "Y") {
                                    $("#bank_tutor").css('background-color', 'white');
                                } else {
                                    $("#bank_tutor").css('background-color', 'grey');
                                }
                                if (track_call_for_studio[4]["value"] == "Y") {
                                    block = false;
                                }
                                if (track_call_for_studio[5]["value"] == "Y" && track_call_for_studio[1]["value"] == "Y" && track_call_for_studio[4]["value"] == "Y") {//Core
                                    $("#btn_submit").removeAttr('disabled');
                                }
                                if (track_call_for_studio[5]["value"] == "Y" && track_call_for_studio[1]["value"] == "Y" && track_call_for_studio[0]["value"] == "Y") {//temp
                                    $("#btn_submit").removeAttr('disabled');
                                }
                                if (track_call_for_studio[6]["value"] == "Y") {
                                    $("#btn_prev").css('', '');
                                    $("#btn_submitted").css('display', '');
                                    $("#btn_submit").css('display', 'none');
                                    $("#studio_proposal").remove();
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
            function getCurrentSemYearCallForStudio() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/getCurrentSemYearCallForStudio",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var sem_year_data = JSON.parse(data.d)
                            sem = sem_year_data[0]["sem_code"];
                            year = sem_year_data[0]["year_code"];
                            if (sem == "S") {
                                $(".semdesc").text("Spring " + year + " Semester");
                            } else if (sem == "M") {
                                $(".semdesc").text("Monsoon " + year + " Semester");
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            function GetInstructorStudioProposalDetails(studio_code) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetInstructorStudioProposalDetails",
                    data: "{studio_code: '" + studio_code + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var studio_details = JSON.parse(data.d)
                            if (studio_details.length > 0) {
                                $("#lbl_port_file_name").text(studio_details[0]["ppt_video"]);
                                //$("#lbl_brief_file_name").text(studio_details[0]["studio_brief"]);
                            }
                        }
                        else {
                            alert("Please fill Step 2 Details");
                            var url = "Interested_Program.aspx";
                            window.open(url, "_self");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
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
        });
        function studio_dtl() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_studio_proposal_dtl_dashboard_v2",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != []) {
                            display_studio_dtl(data.d);
                        }

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
                    {
                        "sTitle": "Studio Proposal", "bSortable": false, "mData": null, "mRender": function (data) {

                            if (data.is_submit == 'Y' && data.studio_brief_status == 'Y') {
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
                        "sTitle": "Studio Brief", "bSortable": false, "mData": null, "mRender": function (data) {

                            if ($('#hdnusertype').val() == 'I2') {
                                if (data.studio_brief_status == 'Y') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.studio_brief_status == 'A') {
                                    return "<center>Submitted</center>";
                                }

                                else if (data.is_submit == 'Y' && data.approved == 'Y' && data.brief_edit_status == 'Y') {
                                    var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status + "_" + data.brief_edit_status;
                                    return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">Edit</a></center>';
                                }
                                else {
                                    return '<center></center>';
                                }
                            }
                            else
                            {
                                if (data.studio_brief_status == 'Y') {
                                    return "<center>Submitted</center>";
                                }
                                else if (data.studio_brief_status == 'A') {
                                    return "<center>Submitted</center>";
                                }

                                else if (data.is_submit == 'Y' && data.approved == 'Y') {
                                    var data_dtl = data.studio_code + "_" + data.semester_type + "_" + data.year_semester + "_" + data.studio_brief_status + "_" + data.brief_edit_status;
                                    return '<center><a id=' + data_dtl + ' onclick="rowClick_studio_brief(this)">Edit</a></center>';
                                }
                                else {
                                    return '<center></center>';
                                }
                            }
                        }
                    },
                    {
                        "sTitle": "Delete", "bSortable": false, "mData": null, "mRender": function (data) {
                            var bind_data = data.semester_type + "_" + data.year_semester + "_" + data.user_id + "_" + data.studio_code;
                            if (data.is_submit == 'Y') {
                                return "<center></center>";
                            }
                            else {
                                return '<center><a id=' + bind_data + ' onclick="rowClick_delete(this)">Delete</a></center>';
                            }
                        }
                    },
                    {
                        "sTitle": "Status", "bSortable": false, "mData": null, "mRender": function (data) {

                            //if (data.status == 'A' && data.approved == 'N' && data.hr_status == '') {
                            if (data.status == 'A' && data.studio_inst == 'N' && data.hr_status == '') {
                                return "<center>HR Yet Not Authorized</center>";
                            }
                            else if (data.status == 'R') {
                                return "<center>" + data.remark + "</center>";
                            }
                            else if (data.hr_status == 'R') {
                                return "<center>" + data.hr_remark + "</center>";
                            }

                            else if (data.studio_brief_status == 'Y') {
                                return "<center>Under Process</center>";
                            }
                            else if (data.studio_brief_status == 'A') {
                                return "<center>Submitted</center>";
                            }
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
        function rowClick_studio_brief(row)
        {
            var split_data = row.id.split('_');
            var origion = window.location.origin + '/';
            if (split_data[3] != 'S') {
                
                //window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
                window.open(origion + "Admin/Master/Add_bank_detl.aspx?studio_code=" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "&b=" + split_data[4] +"", '_blank');
            }
            else {
                var sem_dt = split_data[1] + split_data[2];
                //window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "", '_blank');
                window.open(origion + "Admin/Master/Add_bank_detl.aspx?c=" + sem_dt + "_" + split_data[0] + "&s=" + split_data[1] + "&y=" + split_data[2] + "&b=" + split_data[4] + "", '_blank');
            }
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
    <style type="text/css">
        .style_prevu_kit {
            /*display: inline-block;*/
            padding: 15px;
            border: 0;
            width: 170px;
            height: 26px;
            position: relative;
            border-radius: 5px 10px;
            -webkit-transition: all 200ms ease-in;
            -webkit-transform: scale(1);
            -ms-transition: all 200ms ease-in;
            -ms-transform: scale(1);
            -moz-transition: all 200ms ease-in;
            -moz-transform: scale(1);
            transition: all 200ms ease-in;
            transform: scale(1);
            color: #b5e6e3;
            font-weight: 300;
            font-size: 20px;
            font-family: 'Roboto';
            margin-top: 10px;
            margin-left: 10px;
            float: left;
        }

            .style_prevu_kit:hover {
                box-shadow: 0px 0px 150px #000000;
                z-index: 2;
                -webkit-transition: all 200ms ease-in;
                -webkit-transform: scale(1.5);
                -ms-transition: all 200ms ease-in;
                -ms-transform: scale(1.5);
                -moz-transition: all 200ms ease-in;
                -moz-transform: scale(1.5);
                transition: all 200ms ease-in;
                transform: scale(1);
            }

        .arrow {
            border: solid white;
            border-width: 0 3px 3px 0;
            display: inline-block;
            padding: 3px;
        }

        .down {
            transform: rotate(45deg);
            -webkit-transform: rotate(45deg);
        }
    </style>
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
        }
         #pdclick:hover {
    text-decoration: underline;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row" style="margin-top: 11px; width: 100%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: block;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Call for Studio Tutor
            <span style="font-size:10pt;float:right;margin-right:1.2%;text-shadow: 0 0 slateblue;"><a href="Studio_Proposal_dtl.aspx">View Submitted Proposal</a></span>
            <%--<span style="font-size:10pt;float:right;margin-right:0.8%;text-shadow: 0 0 slateblue;">|</span>
            <span style="font-size:10pt;float:right;margin-right:1.2%;text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a></span>--%>
        </h5>
        <div style="margin-left: 1%; border-top: 1px solid #c2c2c2ab; width: 97.8%;"></div>
        <ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px;width:100%;margin-bottom:10px;margin-top:5px;">
            <%-- <span style="font-size: 10pt;text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a>: If you are proposing a new studio, <a href="Interested_Program.aspx">click here</a> to submt your proposal.</span></br></br>
            <span style="font-size: 10pt;text-shadow: 0 0 slateblue;"><a href="Existing_Interested_Program.aspx">Existing Studio Brief</a>: If you are proposing to run and existig studio unit that you have already offered in a previous semester, <a href="Existing_Interested_Program.aspx">click here</a> to submit the detailed studio brief.</span></br></br>--%>
            <li class="col-md-3 active" id="pd" style="width: 27.5% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 1:</strong></h5>
                       <p id="pdclick" style="color:black;">Personal Details</p>
                       

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="ip"style="width: 28% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-book"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 2:</strong></h5>
                        <a href="Interested_Program.aspx" id="lp_disabled" style="color:black;">Studio Proposal</a>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="sd" style="width: 28% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 3:</strong></h5>
                        <a href="Studio_Details.aspx" id="sp_disabled" style="color:black;">Studio Brief</a>

                    </div>
                </div>
            </li>
           
        </ol>
    </div>
   

     <div class="panel panel-default" style="margin-top: 1%; padding: 0px 0px 9px 0px;width: 100%;">

        <div class="panel-heading">
            <b>Studio Brief Details</b>
        </div>
         <div id="studio_data" class="tab-pane" style="margin-top: 11px; overflow: auto;">
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
        
           

   <%--  <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="div_button" class="controls" style="text-align: center">
                    <table style="width: 100%">
                        <tbody>
                            <tr>
                                <td align="center" style="width: 42%;">
                                    <button id="btn_prev" type="button" style="display: block; margin-right: -75%;" class="btn btn-primary"><< Previous</button>
                                    
                                </td>
                                <td align="" style="width: 20%;">
                                    <button id="btn_submit" type="button" style="display: block; float: center;" class="btn btn-primary"><i class="icon-save bigger-160"></i>Final Submit</button>
                                    
                                </td>
                                <td align="center" style="width: 40%;">
                                    <button id="btn_submitted" type="button" style="margin-left: -183%;background-color: #f81616 !important;border-color: black !important;height: 43px;border: 1px solid;display:none;" class="btn btn-primary" disabled="disabled">Submitted</button>
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            
        </div>
        
    </div> --%>    
    <script type="text/javascript">

        var studio_code = getQueryStringValue('studio_code');

        $('#btn_prev').on('click', function () {
            var url = "Interested_Program.aspx?studio_code=" + studio_code;
            window.open(url, "_self");
        });

        $('#btn_submit').on('click', function () {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/submit_call_for_studio",
                data: "{studio_code:'" + studio_code + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        res = JSON.parse(data.d)
                        if (res['status'] == "1") {
                            send_mail();
                            alert(res['message']);
                            var url = "Studio_Details.aspx?studio_code=" + studio_code;
                            window.open(url, "_self");
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            //window.open(url, "_self");
        });

        function GetFileNameFromPath(strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }

        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                   // case 'pptx':
                    //case 'ppt':
                    case 'mp4':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function CheckStudioBriefExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'doc':
                    case 'docx':
                    case 'pdf':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function getQueryStringValue(key) {
            return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }

        function UploadStudioProposal() {
            try {
                var fileToUpload = GetFileNameFromPath($('#studio_proposal').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    var studio_code_new = getQueryStringValue('studio_code');

                    if (filename != "" && filename != null) {
                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/Instructor_Studio_Proposal.ashx',
                                secureuri: false,
                                data: { 'UploadType': 'studio_proposal', 'studio_code': studio_code_new, 'Extension': fileToUpload.substr((fileToUpload.lastIndexOf('.') + 1)) },
                                fileElementId: 'studio_proposal',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#studio_proposal').val("");
                                            $('#lbl_port_file_name').html('<b>' + fileToUpload + '</b>');
                                            FileName = data.upfile;
                                            alert('Studio Proposal Uploaded Successfully.');
                                            window.location.reload();
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    $('#studio_proposal').val('');
                    alert('Invalid File Type. Please upload .mp4 format file.');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        
        function send_mail() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/send_email_user_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {

                        //res = JSON.parse(data.d)
                        //if (res['status'] == "1")
                        //{
                        //    alert(res['message']);
                        //    var url = "Studio_Details.aspx?studio_code=" + studio_code;
                        //    window.open(url, "_self");
                        //}
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }

    </script>
    <script type="text/javascript">

</script>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_tutor_type" value="" />
</asp:Content>

