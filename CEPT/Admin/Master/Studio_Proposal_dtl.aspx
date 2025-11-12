<%@ Page Title="Studio Proposal Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Studio_Proposal_dtl.aspx.cs" Inherits="Admin_Master_Studio_Proposal_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var oTable;
        var oTable1;
        var oTable2;
        var user_type = '';
        var dept_code_ = '';
        var prog_level = '';
        var studio_level = '';
        var prog_code = '';
var types='';

        $(document).ready(function () {
            user_type = $('#hdn_user_type').val();
            bindsemdata();
            bindyeardata_for_cross_reg();
            binddepartment();
            bindproglevel();
            bindleveldata();
            bindtypedata();
            bindprogrammedata();

            if (user_type == "I2") {
                $('#title_name').text(" Submitted Studio");
                $('#panel_head').text(" Submitted Studio");
            }
            else {
                $('#title_name').text(" Studio Proposal Submitted");
                $('#panel_head').text(" Studio Proposal Submitted");
            }
            if(user_type != "A1")
            {  
                $('td#type_desc').css('display','none')
                $('td#type').css('display','none')
              //$('#drptype').attr('disabled',false);
              //$('div#drptype_chzn').attr('disabled','disabled');                   
            }
            

            $('#btnreterive').on('click', function () {
                get_studio_detail();
                return false;
            });
        });
        function rowClick_download(row) {
            $('#hdn_file_name').val(row.id);
            $("#btnDownloadvideo").click();

        }
        function rowClick_approve(row) {
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/studio_dtl_update",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + row.id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "Update Data") {
                                bootbox.alert("Proposal Approved successfully");
                                get_studio_detail();
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
        function rowClick_edit(row) {

            var origion = window.location.origin + '/';
            window.open(origion + "Admin/Master/Interested_Program.aspx?studio_code=" + row.id + "", '_blank');
        }

        //function rowClick_brief_edit(row) {
        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?studio_code=" + row.id + "", '_blank');
        //}

        function rowClick_edit_course_saved(row, sem_code, year_code) {
            var origion = window.location.origin + '/';
            window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + row.id + "&s=" + sem_code + "&y=" + year_code + "", '_blank');
        }

        function rowClick_edit_course(row, sem_code, year_code) {
            var origion = window.location.origin + '/';
            window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + row.id + "&s=" + sem_code + "&y=" + year_code + "", '_blank');
        }

        //function rowClick_brief_edit_saved(row) {
        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + row.id + "", '_blank');
        //}

        function rowClick_add_course(row, sem_code, year_code) {
            var origion = window.location.origin + '/';
            window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?studio_code=" + row.id + "&s=" + sem_code + "&y=" + year_code + "", '_blank');
        }

        function rowClick_brief_approve(row)
                {
                semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_studio_brief_dtl",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',course_code:'" + row.id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "Update Data") {
                                bootbox.alert("Studio Brief Approved successfully");
                                get_studio_detail();
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
        function rowClick_view(row)
        {
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }
            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            var course_code = row.id;
            //var course_code = "S2020_CT1704";
            $('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester + '&year_code=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
        }

        function rowClick_view_preview(row)
        {
            var res = row.id.split('_');
            semester = res[0];

            year_code = res[1];
            var course_code = res[2];
            $('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester + '&year_code=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
        }
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
        function binddepartment() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                aSync: false,
                success: function (data) {
                    if (data.d != "") {
                        var sem_data = JSON.parse(data.d)

                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }
                        $('#drpdepartment').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bindproglevel() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d);

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }
                        $('#drpproglevel').chosen();

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bindleveldata() {
            $('#drlevel').empty().append($("<option></option>").val("").html("-- Please Select Level --"));
            $('#drlevel').append($("<option></option>").val("L2").html("Level 2"));
            $('#drlevel').append($("<option></option>").val("L3").html("Level 3"));
            $('#drlevel').append($("<option></option>").val("L4").html("Level 4"));

            $('#drlevel').chosen();
        }
        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function get_studio_detail() {
            $('#DataList').css('display', 'none');
            $('#DataList_user_wise').css('display', 'none');
            $('#DataList_pc_user').css('display', 'none');
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            dept_code_ = $('#drpdepartment').val();
            prog_level = $('#drpproglevel').val();
            studio_level = $('#drlevel').val();
            prog_code = $('#drpprog').val();
            if (user_type == 'D' || user_type == 'A') 
                {
                $('#DataList').css('display', 'block');
                $('#DataList_user_wise').css('display', 'none');

            }
            if(user_type == 'A1')
            {
                   types =$('#drptype').val();
            }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_studio_proposal_dtl",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',dept_code:'" + dept_code_ + "',prog_level:'" + prog_level + "',studio_level:'" + studio_level + "',type:'"+types+"',prog_code:'"+prog_code+"'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]") 
                          {
                            if (user_type == "I2")
                            {
                                $('#DataList_user_wise').css('display', 'none');
                                $('#DataList_pc_user').css('display', 'none');
                                display_studio_proposal_detail(data.d);
                            }
                            else if (user_type.toLowerCase() == "pc")
                            {
                                $('#DataList_user_wise').css('display', 'none');
                                $('#DataList').css('display', 'none');
                                display_studio_proposal_detail_pc_user(data.d);
                            }
                            else
                            {
                                $('#DataList').css('display', 'none');
                                $('#DataList_pc_user').css('display', 'none');
                                display_studio_proposal_detail_user_wise(data.d);
                            }

                            $('#div_studio_proposal_dtl').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function display_studio_proposal_detail(data)
        {
            var columns = [
                { "sTitle": "Title of Studio", "mData": "studio_title" },
                { "sTitle": "Faculty", "mData": "dept_name" },
                { "sTitle": "Program", "mData": "prog_level_name" },
                { "sTitle": "Level", "mData": "studio_level" },
                {
                    "sTitle": "Tutor Type", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.tutor_type == "CT") {
                            return 'Co Tutor';
                        }
                        else if (data.tutor_type.trim() == 'T') {
                            return 'Lead Tutor';
                        }

                        else { return '';}
                    }
                },
                {
                    "sTitle": "Download", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.ppt_video != "") {
                            return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                        }
                        else return '';
                    }
                },
                {
                    "sTitle": "Edit Proposal", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.is_submit == 'Y') {
                            return "<center>Submitted</center>";
                        }
                        else {

                            return '<center><button type="button" id=' + data.studio_code + ' onclick="rowClick_edit(this)">Edit</button></center>';
                        }
                    }
                },
                //{
                //    "sTitle": "Approval Status", "mData": null, "bSortable": false, mRender: function (data) {
                //        if (data.approved == 'Y') {
                //            return "<center>Approved</center>";
                //        }
                //        else {
                //            return "<center>Pending</center>";
                //        }
                //    }
                //},
                {
                    "sTitle": "Edit Brief", "mData": null, "bSortable": false, mRender: function (data)
                    {
                        var desig = $('#hdn_designation_type').val();
                        if (data.brief_edit_status == "Y") {
                            if (data.approved == 'Y' && desig != 'temp' && data.studio_brief_status == "N") {
                                return '<center><button type="button" id=' + data.studio_code + ' onclick="rowClick_add_course(this, \'' + data.semester_type + '\',\'' + data.year_semester + '\')">Edit</button></center>';
                            }
                            else if (data.approved == 'Y' && desig != 'temp' && data.studio_brief_status == "S") {
                                return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_edit_course_saved(this, \'' + data.semester_type + '\',\'' + data.year_semester + '\')">Edit</button></center>';
                            }
                            else if (data.approved == 'Y' && desig != 'temp' && (data.studio_brief_status == "A" || data.studio_brief_status == "Y")) {
                                return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_view(this)">View</button></center>';
                            }
                            else {
                                return '<center></center>';
                            }
                        }
                        else {
                            if (data.approved == 'Y' && desig != 'temp' && (data.studio_brief_status == "A" || data.studio_brief_status == "Y")) {
                                return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_view(this)">View</button></center>';
                            }
                            else { return '<center></center>';}
                        }
                       // return '<center></center>';
                    }
                },
                {
                    "sTitle": "Studio Brief", "mData": null, "bSortable": false, mRender: function (data)
                    {
                        
                            if (data.studio_brief_status == "Y") {
                                return "<center>Submitted</center>";
                            }
                            else if (data.studio_brief_status == "N") {
                                return "<center>Yet To Submit</center>";
                            }
                            else if (data.studio_brief_status == "S") {
                                return "<center>Saved</center>";
                            }
                            else if (data.studio_brief_status == "A") {
                                return "<center>Approved</center>";
                            }
                            else
                            {
                                return "";
                            }
                        
                        
                    }
                },
{
                        "sTitle": "Status", "bSortable": false, "mData": null, "mRender": function (data) {

                            if (data.studio_brief_status == 'Y')
                            {
                                return "<center>Under Process</center>";
                            }
                            else if (data.studio_brief_status == 'A')
                            {
                                return "<center>Submitted</center>";
                            }
                            else{return "<center></center>";}
                        }
                },

                {
                    "sTitle": "Dean/PC Shortlist", "bSortable": false, "mData": null, "mRender": function (data) {

                        //if (data.iwss_Status == 'A')
                        //{
                        //    return "<center style='color: green'>Shortlisted</center>";
                        //}
                        //else { return "<center style='color: blue'>Pending</center>"; }

                        if (data.to_be_later == 'Y')
                        {
                            if (data.shortlist == 'Y')
                            {
                                return "<center style='color: green'>Shortlisted</center>";

                            }
                            else {
                                return "<center style='color: blue'>Pending</center>";
                            }
                        }

                        else if (data.iwss_Status == 'A') {
                            return "<center style='color: green'>Shortlisted</center>";
                        }
                        else {
                            return "<center style='color: blue'>Pending</center>";
                        }
                    }
                },

                {
                    "sTitle": "Personal Detail Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.im_admin_approved == "Y") {
                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Rateband Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.im_rateband_approved == "Y") {
                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Workload Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.iwd_admin_approved == "Y") {

                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Dean/PC Authorized", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.iwd_hr_approved == "Y") {
                            return "<center style='color: green'>Authorized</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },

                {
                    "sTitle": "HR Authorized", "bSortable": false, "mData": null, "mRender": function (data) {

                        if (data.approved == 'Y') {
                            return "<center style='color: green'>Authorized</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                }

            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');
        }


        function display_studio_proposal_detail_user_wise(data) {
            var columns = [

                { "sTitle": "Instructor", "mData": "user_name" },
                { "sTitle": "Faculty", "mData": "dept_name" },
                { "sTitle": "Program", "mData": "prog_level_name" },
                { "sTitle": "Level", "mData": "studio_level" },
                { "sTitle": "Studio Title", "mData": "studio_title" },
               // { "sTitle": "Studio Description", "mData": "studio_description" },

                {
                    "sTitle": "Studio Description", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_description != "") {
                           // return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                            return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description +'';
                        }
                        else return '';
                    }
                },
                {
                    "sTitle": "Proposal", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.ppt_video != "") {
                            return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                        }
                        else return '';
                    }
                },

                //{
                //    "sTitle": "Initial Approval", "mData": null, "bSortable": false, mRender: function (data) {
                //        if (data.approved == 'Y') {
                //            return "<center>Approved</center>";
                //        }
                //        else {
                //            var row_value = data.user_id + '_' + data.dept_code + '_' + data.prog_code + '_' + data.prog_level_code + '_' + data.studio_level + '_' + data.studio_code;
                //            return '<center><button type="button" id=' + row_value + ' onclick="rowClick_approve(this)">Approve</button></center>';;
                //        }
                //    }
                //},

                {
                    "sTitle": "Final Approval", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_brief_status == "Y") {
                            return "<center>Submitted</center>";
                        }
                        else if (data.studio_brief_status == "N") {
                            return "<center>Yet to Submit</center>";
                        }
                        else if (data.studio_brief_status == "S") {
                            return "<center>Saved by Tutor</center>";
                        }
                        else if (data.studio_brief_status == "A") {
                            return "<center>Approved</center>";
                        }
                        else {
                            return "";
                        }

                    }
                },
                {
                    "sTitle": "Brief View", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_brief_status == "Y" || data.studio_brief_status == "S" || data.studio_brief_status == "A")
                        {
                            return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_view(this)">View</button></center>';
                        }
                        //else if (data.studio_brief_status == "S")
                        //{
                        //    return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_view(this)">View</button></center>';
                        //}
                        //else if (data.studio_brief_status == "A")
                        //{
                        //    return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_view(this)">View</button></center>';
                        //}
                        else {
                            return "";
                        }

                    }
                },
                {
                    "sTitle": "Brief Status", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_brief_status == "Y")
                        {
                            return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_brief_approve(this)">Approve</button></center>';
                        }
                        else if(data.studio_brief_status == "A")
                        {
                        return "<center>Approved</center>";
                        }
                        else {
                            return "<center>PC yet not Submitted</center>";
                        }

                    }
                },
                {
                    "sTitle": "Previous Semester", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.previous_sem_code != "") {
                            if (data.previous_sem_code == "S") {
                                return '<center>Spring</center>';
                            }
                            else { return '<center>Monsoon</center>'; }

                        }

                        else return '';
                    }
                },

                {
                    "sTitle": "Previous Year", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.previous_year_code != "") {

                            return '<center>' + data.previous_year_code + '</center>';


                        }

                        else return '';
                    }
                },
                {
                    "sTitle": "Previous Semester Course Code", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.previous_sem_course_code != "") {

                            return '<center>' + data.previous_sem_course_code + '</center>';


                        }

                        else return '';
                    }
                },
                {
                    "sTitle": "Previous Semester Brief View", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.previous_sem_course_code != "") {
                            var row_dtl = data.previous_sem_code + '_' + data.previous_year_code + '_' + data.previous_sem_course_code;
                            return '<center><button type="button" id=' + row_dtl + ' onclick="rowClick_view_preview(this)">View</button></center>';
                        }

                        else {
                            return "";
                        }

                    }
                },

                { "sTitle": "Course Code", "mData": "course_code" },
                {
                    "sTitle": "Dean/PC Shortlist", "bSortable": false, "mData": null, "mRender": function (data) {

                        if (data.iwss_Status == 'A') {
                            return "<center style='color: green'>Shortlisted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },

                {
                    "sTitle": "Personal Detail Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.im_admin_approved == "Y")
                        {
                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Rateband Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.im_rateband_approved == "Y")
                        {
                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Workload Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.iwd_admin_approved == "Y") {

                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Dean/PC Authorized", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.iwd_hr_approved == "Y")
                        {
                            return "<center style='color: green'>Authorized</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                
                {
                    "sTitle": "HR Authorized", "bSortable": false, "mData": null, "mRender": function (data) {

                        if (data.approved == 'Y') {
                            return "<center style='color: green'>Authorized</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                }

            ];

            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList_user_wise").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_user_wise" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example_user_wise").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns

            });

            $('#DataList_user_wise').css('display', 'block');
        }

        function display_studio_proposal_detail_pc_user(data) {
            var columns = [
                { "sTitle": "Instructor Name", "mData": "user_name" },
                { "sTitle": "Title of Studio", "mData": "studio_title" },
                { "sTitle": "Faculty", "mData": "dept_name" },
                { "sTitle": "Program", "mData": "prog_level_name" },
                { "sTitle": "Level", "mData": "studio_level" },
                {
                    "sTitle": "Proposal", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.ppt_video != "") {
                            return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                        }
                        else return '';
                    }
                },
                {
                    "sTitle": "View", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.course_code != "") {
                            return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_view(this)">View</button></center>';
                        }
                        else return '';
                    }
                },
                {
                    "sTitle": "Initial Approval", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.approved == 'Y') {
                           return "<center>Approved</center>";
                        }
                        else {
                            //var row_value = data.user_id + '_' + data.dept_code + '_' + data.prog_code + '_' + data.prog_level_code + '_' + data.studio_level + '_' + data.studio_code;
                            //return '<center><button type="button" id=' + row_value + ' onclick="rowClick_approve(this)">Approve</button></center>';
                            return '';
                        }
                    }
                },
                {
                    "sTitle": "Studio Brief", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_brief_status == "Y") {
                            return "<center>Submitted</center>";
                        }
                        else if (data.studio_brief_status == "N") {
                            return "<center>Yet to Submit</center>";
                        }
                        else if (data.studio_brief_status == "S") {
                            return "<center>Saved by Tutor</center>";
                        }
                        else if (data.studio_brief_status == "A") {
                            return "<center>Approved</center>";
                        }
                        else {
                            return "";
                        }

                    }
                },
                {
                    "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_brief_status == 'Y') {
                            //return "<center></center>";
                            return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_edit_course(this, \'' + data.semester_type + '\',\'' + data.year_semester + '\');">Add Course</button></center>';
                        } if (data.studio_brief_status == 'A' && data.progcoordinate_approved != "Y") {
                            //return "<center></center>";
                            return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_edit_course(this, \'' + data.semester_type + '\',\'' + data.year_semester + '\');">Edit Course</button></center>';
                        } else {
                            return "<center></center>";
                        }
                        //else {
                        //    var row_value = "";
                        //    if (data.course_code != '') {
                        //        row_value = data.course_code;
                        //        return '<center><button type="button" id=' + row_value + ' onclick="rowClick_edit_course(this, \'' + data.semester_type + '\',\'' + data.year_semester + '\');">Add Course</button></center>';
                        //    }
                        //    else {
                        //        row_value = data.studio_code;
                        //        sem = data.semester_type;
                        //        year = data.year_code;
                        //        return '<center><button type="button" id=' + row_value + ' onclick="rowClick_add_course(this, \'' + data.semester_type + '\',\'' + data.year_semester + '\');">Edit Course</button></center>';
                        //    }
                        //}
                    }
                },
                {
                    "sTitle": "Dean/PC Shortlist", "bSortable": false, "mData": null, "mRender": function (data) {

                        if (data.iwss_Status == 'A') {
                            return "<center style='color: green'>Shortlisted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },

                {
                    "sTitle": "Personal Detail Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.im_admin_approved == "Y") {
                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Rateband Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.im_rateband_approved == "Y") {
                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Workload Submit", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.iwd_admin_approved == "Y") {

                            return "<center style='color: green'>Submitted</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },
                {
                    "sTitle": "Dean/PC Authorized", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.iwd_hr_approved == "Y") {
                            return "<center style='color: green'>Authorized</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                },

                {
                    "sTitle": "HR Authorized", "bSortable": false, "mData": null, "mRender": function (data) {

                        if (data.approved == 'Y') {
                            return "<center style='color: green'>Authorized</center>";
                        }
                        else { return "<center style='color: blue'>Pending</center>"; }
                    }
                }
                //{
                //    "sTitle": "Final Approval", "mData": null, "bSortable": false, mRender: function (data) {
                //        if (data.studio_brief_status == "Y") {
                //            return "<center>Submitted</center>";
                //        }
                //        else if (data.studio_brief_status == "N") {
                //            return "<center>Yet To Submit</center>";
                //        }
                //        else if (data.studio_brief_status == "S") {
                //            return "<center>Saved By Tutor</center>";
                //        }
                //        else if (data.studio_brief_status == "A") {
                //            return "<center>Approved</center>";
                //        }
                //        else {
                //            return "";
                //        }
                //    }
                //}
            ];
            if (oTable2 != null) {
                oTable2.fnDestroy();
                $("#DataList_pc_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_pc_user" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable2 = $("#example_pc_user").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns
            });
            $('#DataList_pc_user').css('display', 'block');
        }
        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("Y").html("Submitted"));
            $('#drptype').append($("<option></option>").val("S").html("Saved"));

            $('#drptype').chosen();

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i><span id="title_name">Studio Proposal Details </span>
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>Faculty :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Program :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>Program Level :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                                <td>Level :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drlevel">
                                    </select>
                                </td>

                            </tr>
                            <tr>
                                <td id="type">Type :</td>
                                <td id="type_desc">
                                    <select class="chosen-select" id="drptype">
                                    </select>
                                </td>

                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_studio_proposal_dtl" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Studio Proposal Detail</strong>
            </div>
            <div id="DataList" style="display: none; overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <div id="DataList_user_wise" style="display: none;overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example_user_wise" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <div id="DataList_pc_user" style="display: none;overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example_pc_user" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        </div>

    </div>
    <asp:Button ID="btnDownloadvideo" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadvideo_Click" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_file_name" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_designation_type" runat="server" ClientIDMode="Static" />
    <div id="ifrm_outline" style="display: none;"></div>
</asp:Content>

