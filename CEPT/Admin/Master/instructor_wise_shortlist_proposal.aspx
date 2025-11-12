<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="instructor_wise_shortlist_proposal.aspx.cs" Inherits="Admin_Master_instructor_wise_shortlist_proposal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />--%> 

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel='stylesheet' href='https://cdn.datatables.net/s/ju/dt-1.10.10,b-1.1.0,fc-3.2.0,r-2.0.0,sc-1.4.0/datatables.min.css'>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>

    <style>
        th, td {
            white-space: nowrap;
        }

        div.dataTables_wrapper {
            /* width: 800px;*/
            /*margin: 0 auto;*/
            overflow: auto;
        }

        .ui-widget-header {
            background: none !important;
        }

        #example td:first-child {
            background: url('https://datatables.net/examples/resources/details_open.png') no-repeat center center;
            cursor: pointer;
        }

        #example tr.shown td:first-child {
            background: url('https://datatables.net/examples/resources/details_close.png') no-repeat center center;
        }

        table#bind_sub td:first-child {
            background: none !important;
        }

        table#bind_sub tr.shown td:first-child {
            background: none !important;
        }
    </style>

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
        var types = '';
        var to_be_decided_status = false;
        var shortlist = false;
        var non_shortlist = false;
        var to_be_decided_status_new = false;
        var TBD_Status = false;
        var table = "";
        var json_dtl = "";
        var json_dtl_new = "";
        $(document).ready(function () {

            user_type = $('#hdn_user_type').val();
            bindsemdata();
            bindyeardata_for_cross_reg();
            binddepartment();
            bindproglevel();
            bindleveldata();
            bindtypedata();
            bindprogrammedata();
            $('#example').on('preDraw.dt', function (e, settings) {
                settings._iDisplayLength = 300;
            });
            $('#btnreterive').on('click', function () {
               
                get_studio_detail_public();
                get_studio_detail();
                
                return false;
            });
            //$(document).on("click", ".cv_download", function (event) {
            //
            //    var row = $(this).closest("tr").get(0);
            //    var aData = oTable.fnGetData(row);
            //    var cv_file_name = aData["cv_file_name"];
            //    $('#hdn_file_name').val(cv_file_name);
            //    $("#btnDownloadcv").click();
            //    return false;
            //});
        });

        function showLoader() {
            Swal.fire({
                title: 'Generating Data...',
                text: 'Please wait while the List is being generated.',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
        }

        function hideLoader() {
            Swal.close();
        }

        //function rowClick_cv_download() {
        //
        //}

        function rowClick_cv_download(row_id) {

            $('#hdn_file_name').val(row_id.id);
            $("#btnDownloadcv").click();
            return false;

        }

        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("Y").html("ShortListed"));
            $('#drptype').append($("<option></option>").val("Tobe").html("Non ShortList"));
            $('#drptype').append($("<option></option>").val("TBD").html("Tutor Added Later"));

            $('#drptype').chosen();

        }
        //rowClick_approve

        function rowClick_approve_tobedecided(row) {
            var status = 'A';
            var split_studiocode = row.id.split("_");
            var remark = $('#' + split_studiocode[1]).val();
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
                    url: "../../WebService.asmx/to_be_later_inst_shortlist",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + row.id + "',remark:'" + remark + "',status:'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Successfully ShortListed Instructor");
                                get_studio_detail_public();
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

        function rowClick_approve(row)
        {
            var bindUserId = '';
            bindUserId = $(row).attr("data-bind-userid");
            console.log(bindUserId);
            var status = 'A';
            var split_studiocode = row.id.split("_");
            var remark = $('#' + split_studiocode[1]).val();
            if (remark == undefined) {
                remark = "";
            }
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
                    url: "../../WebService.asmx/insert_short_list_instractor",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + row.id + "',remark:'" + remark + "',status:'" + status + "',bindUserId:'" + bindUserId + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true")
                            {
                                bootbox.alert("Successfully ShortListed Instructor", function () {
                                    $('#' + row.id).attr('disabled', true);
                                    //get_studio_detail();
                                });
                                //cahnges by nitinbhai 28022023
                                //bootbox.alert("Successfully ShortListed Instructor");

                                
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


        function rowClick_reject(row) {

            var bindUserId = $(row).attr("data-bind-userid");
            var status = 'R';
            var split_studiocode = row.id.split("_");
            var remark = $('#' + split_studiocode[1]).val();
            if (remark == "") {
                bootbox.alert('Please Enter Remark');
                $('#remark').focus();
                return false;
            }


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
                    url: "../../WebService.asmx/insert_short_list_instractor",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + row.id + "',remark:'" + remark + "',status:'" + status + "',bindUserId:'" + bindUserId + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                //bootbox.alert("Successfully Rejected");
                                bootbox.alert("Successfully Rejected", function () {
                                    $('#' + row.id).attr('disabled', true);
                                });
                                //get_studio_detail();
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



        function rowClick_view(row) {

            var res = row.id.split('_');
            semester = res[0];

            year_code = res[1];

            var course_code = res[2];
            //var course_code = "S2020_CT1704";
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

        //$(document).on("click", ".portfolio_download", function (event) {
        //    alert('ssdfdsaf');
        //    var row = $(this).closest("tr").get(0);
        //    var aData = oTable.fnGetData(row);
        //    var portfolio_file_name = aData["portfolio_file_name"];
        //    //var ppt_video = aData["ppt_video"];
        //    $('#hdn_file_name').val(portfolio_file_name);
        //    $("#btnDownloadportfolio").click();
        //    return false;
        //});

        function rowClick_portfolio_download_old(row_id) {

            $('#hdn_file_name').val(row_id.id);
            $("#btnDownloadportfolio").click();
            return false;

        }
        $(document).on("click", "#weekly_download", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var weekly_excercises_path = aData["weekly_excercises_path"];
            $('#hdn_weekly_file_name').val(weekly_excercises_path);
            $("#btnDownloadweekly").click();
            return false;
        });




        $(document).on("click", ".pdf_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            var instructor_code = '';
            var weekly_excercises_path = aData["weekly_excercises_path"];
            var instructor_name = aData["instructor_name"];
            var cv_file_name = aData["cv_file_name"];
            var portfolio_file_name = aData["portfolio_file_name"];
            if (cv_file_name != '') {
                var myArr = cv_file_name.split("_");
                instructor_code = myArr[0];
            }
            if (portfolio_file_name != '') {
                var myArr = cv_file_name.split("_");
                instructor_code = myArr[0];

            }
            //instructor_code = aData["instructor_code"];
            var ppt_video = aData["ppt_video"];
            var studio_brief = aData["studio_brief"];
            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var dep_name = "";

            if (semester == 'S') {
                semester = 'Spring';
            }
            else {
                semester = 'Monsoon';
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Download_Document",
                data: "{'instructor_code':'" + instructor_code + "','cv_file_name':'" + cv_file_name + "','portfolio_file_name':'" + portfolio_file_name + "','ppt_video':'" + ppt_video + "','studio_brief':'" + studio_brief + "','weekly_excercises_path':'" + weekly_excercises_path + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "1") {
                            $("#btnDownloadExcelDocuments").click();
                            return false;
                        }
                        else {
                            bootbox.alert('Document Not Found');
                        }
                        return true;
                    }
                    else {
                        bootbox.alert('Document Not Found');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        });

        function bindprogrammedata() {
            //$('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            //$('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            //$('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            //$('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            //$('#drpprog').chosen();
            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                $('#drpprog').empty();

                                for (var i = 0; i < user_data.length; i++) {

                                    if (user_data[i]['prog_code'] == "1") {
                                        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "2") {
                                        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "3") {
                                        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                    }
                                }

                            }
                            else {
                                $('#drpprog').val('1');
                                $("#drpprog").attr('disabled', 'disabled');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else {

                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

                if ($("#hdnusertype").val() != 'PC' && $("#hdnusertype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }

        function get_studio_detail() {
            $('#DataList').css('display', 'none');

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
            //prog_level = $('#drpproglevel').val();
            //studio_level = $('#drlevel').val();
            prog_code = $('#drpprog').val();

            var type = $('#drptype').val();
            var url_dtl = '';
            if (type == 'Y') {
                table = '';
                $('#example').dataTable().fnDestroy();
                url_dtl = '../../WebService.asmx/Get_shortlist_detail';
                //shortlist = true; 
                shortlist = false;
                to_be_decided_status = false;
                to_be_decided_status_new = true;
                non_shortlist = false;
                TBD_Status = false;

            }
            else if (type == 'Tobe') {
                table = '';
                $('#example').dataTable().fnDestroy();
                url_dtl = '../../WebService.asmx/Get_instructor_wise_shortlist_to_be_decided_details';
                to_be_decided_status = true;
                shortlist = false;
                non_shortlist = false;
                to_be_decided_status_new = false;
                TBD_Status = false;
            }
            else if (type == 'TBD') {
                table = '';
                $('#example').dataTable().fnDestroy();
                url_dtl = '../../WebService.asmx/Get_studio_dtl_TBD';
                to_be_decided_status = false;
                shortlist = false;
                non_shortlist = false;
                to_be_decided_status_new = false;
                TBD_Status = true;
            }
            else {
                table = '';
                $('#example').dataTable().fnDestroy();
                url_dtl = '../../WebService.asmx/Get_instructor_wise_shortlist_detail';
                non_shortlist = true;
                to_be_decided_status = false;
                shortlist = false;
                to_be_decided_status_new = false;
            }
            showLoader();
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dtl,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',dept_code:'" + dept_code_ + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]") {
                            json_dtl = JSON.parse(data.d);
                            if (to_be_decided_status == true)
                            {
                                var data = JSON.parse(data.d)
                                if ($('#drpstudiolevel').val() != '') {
                                    var result = alasql('SELECT * FROM ? WHERE studio_level = ?', [data, $('#drpstudiolevel').val()]);
                                    display_studio_proposal_detail_new(result);
                                }
                                else
                                {
                                display_studio_proposal_detail_new(data);
                                }
                                
                                
                               
                            }
                            else
                            {
                                var data = JSON.parse(data.d);
                                if ($('#drpstudiolevel').val() != '') {
                                    var result = alasql('SELECT * FROM ? WHERE studio_level = ?', [data, $('#drpstudiolevel').val()]);
                                    display_studio_proposal_detail(result);
                                }
                                else {
                                    display_studio_proposal_detail(data);
                                }



                                //display_studio_proposal_detail(data.d);
                               
                            }

                            $('#div_studio_proposal_dtl').css('display', 'block');
                            $('div#example_length.dataTables_length').css('display', 'none');

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

            //return false;
        }


        function get_studio_detail_public() {
            $('#DataList').css('display', 'none');

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

            prog_code = $('#drpprog').val();

            var type = $('#drptype').val();
            var url_dtl = '';

            url_dtl = '../../WebService.asmx/Get_instructor_wise_shortlist_to_be_decided_details';



            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dtl,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',dept_code:'" + dept_code_ + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]") {
                            json_dtl_new = JSON.parse(data.d);

                        }
                        else {
                            // bootbox.alert('No data Found For Selected Semester and Year');
                            //return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            //return false;
        }


        function display_studio_proposal_detail_old(data) {
            var columns = [
                //{ "sTitle": "Instructor Code", "mData": "user_id" },
                { "sTitle": "Instructor Name", "mData": "full_name" },
                { "sTitle": "Mail", "mData": "mail" },
                { "sTitle": "Title of Studio", "mData": "studio_title" },
                {
                    "sTitle": "Studio Description", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_description != "") {
                            // return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                            return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
                        }
                        else return '';
                    }
                },
                { "sTitle": "Studio Code", "mData": "studio_code" },
                { "sTitle": "No of Tutor", "mData": "no_of_tutor" },
                { "sTitle": "Mode of Teaching", "mData": "teaching_mode" },
                { "sTitle": "Level", "mData": "studio_level" },
                { "sTitle": "Faculty Name", "mData": "dept_name" },
                { "sTitle": "Total Experience", "mData": "total_experiance" },
                {
                    "sTitle": "Designation", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.designation != null) {
                            return data.designation;
                        }
                        return '';

                    }
                },
                {
                    "sTitle": "Work Designation", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.work_designation != null) {
                            return data.work_designation;
                        }
                        return '';

                    }
                },
                {
                    "sTitle": "Current Organization", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.work_institute != null) {
                            return data.work_institute;
                        }
                        return '';

                    }
                },
                { "sTitle": "Rate Band", "mData": "rate_band" },
                { "sTitle": "Contact", "mData": "mobile_no" },
                {
                    "sTitle": "Location", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.city != null) {
                            return data.city;
                        }
                        return '';

                    }
                },

                {
                    "sTitle": "CV", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.cv_file_name != '') {
                            // return 'Y';
                            return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + data.cv_file_name + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                        }
                        return '';

                    }
                },

                {
                    "sTitle": "Proposal", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.ppt_video != '') {
                            // return 'Y';
                            return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_proposal_download(this)" id=' + data.ppt_video + ' class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                        }
                        return '';

                    }
                },
                {

                    "sTitle": "Portfolio", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.portfolio_file_name != '') {
                            // return 'Y';
                            return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + data.portfolio_file_name + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                        }
                        return '';

                    }
                },
                {

                    "sTitle": "Weekly Excercises", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        if (data.weekly_excercises_path != '') {
                            // return 'Y';
                            return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_weekly_download(this)" id="weekly_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                        }
                        return '';

                    }
                },
                {
                    "sTitle": "Download ALL", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

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
                { "sTitle": "New Course Code", "mData": "course_code" },
                {
                    "sTitle": "Previous Semester Brief View", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.previous_sem_course_code != "") {
                            var row_dtl = data.previous_sem_code + '_' + data.previous_year_code + '_' + data.previous_sem_course_code;
                            return '<center><button type="button" id=' + row_dtl + ' onclick="rowClick_view(this)">View</button></center>';
                        }

                        else {
                            return "";
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
                },
                {
                    "sTitle": "Remark Reject", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.remark != "") {
                            // return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                            return '<textarea id=' + data.studio_code + ' name="w3review" rows="4" cols="50">' + data.remark + '';
                        }
                        else return '<textarea id=' + data.studio_code + ' name="remark" rows="4" cols="50">';
                    }
                },

                {
                    "sTitle": "Short List", "mData": null, "bSortable": false, mRender: function (data) {
                        if (to_be_decided_status != true) {
                            if (data.shortlist_status == "R" || data.shortlist_status == "") {

                                var row_value = data.user_id + '_' + data.studio_code;
                                return '<center><button type="button" id=' + row_value + ' onclick="rowClick_approve(this)" data-bind-userid = ' + data.user_id +'> ShortList</button></center>';
                            }
                            else if (data.shortlist_status == "A") {// 
                                return 'Shortlisted';
                            }
                            else return '';
                        }
                        else {
                            if (data.shortlist == "" && data.approved == "N") {

                                var row_value = data.instructor_code + '_' + data.studio_code;
                                return '<center><button type="button" id=' + row_value + ' onclick="rowClick_approve_tobedecided(this)">ShortList</button></center>';
                            }
                            else if (data.shortlist == "Y") {//
                                return 'Shortlisted';
                            }
                            else return '';

                        }

                    }
                },
                {
                    "sTitle": "Reject", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.shortlist_status == "R")
                        {
                            return 'Rejected';
                        }
                        else if (data.approved == 'Y') {
                            var row_value = data.user_id + '_' + data.studio_code;
                            return '<center><button type="button" id=' + row_value + ' onclick="rowClick_reject(this)" data-bind-userid = ' + data.user_id +' class="cls_btn_pdf btn btn-primary btn-small">Reject</button></center>';
                        }
                        else if (data.shortlist_status == "")
                        {
                            var row_value = data.user_id + '_' + data.studio_code;
                            return '<center><button type="button" id=' + row_value + ' onclick="rowClick_reject(this)" data-bind-userid = ' + data.user_id +' class="cls_btn_pdf btn btn-primary btn-small">Reject</button></center>';
                        }
                        
                        else return '';
                    }
                }];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 300,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns

            });

            $('#DataList').css('display', 'inline-block');
        }


        function viewPDF(filePath) {
            $("#pdfFrame").attr("src", filePath);
            $("#pdfModal").modal("show");
        }

        function display_studio_proposal_detail(data) {

            var str = "";
            var status_bind = false;
            if (table != "") {
                table.destroy();
            }
            //var data_dtl = JSON.parse(data);
            var data_dtl = data;
            var duplicate_studio_code = '';
            for (var i = 0; i < data_dtl.length; i++) {
                if (i == 0) {
                    duplicate_studio_code = data_dtl[i]['studio_code'];
                    status_bind = true
                }
                else {
                    if (duplicate_studio_code != data_dtl[i]['studio_code']) {
                        duplicate_studio_code = data_dtl[i]['studio_code'];
                        status_bind = true;
                    }

                }
                if (status_bind) {
                    str += "<tr>";
                    str += "<td class='sorting_1'></td>";
                    str += "<td>" + data_dtl[i]['studio_code'] + "</td>";
                    str += "<td>" + data_dtl[i]['studio_title'] + "</td>";
                    str += "<td><textarea id='topic' name='topic' rows='4' cols='50'>" + data_dtl[i]['studio_description'] + "</textarea></td>";
                    str += "<td>" + data_dtl[i]['no_of_tutor'] + "</td>";
                    str += "<td>" + data_dtl[i]['teaching_mode'] + "</td>";
                    str += "<td>" + data_dtl[i]['studio_level'] + "</td>";
                    str += "<td>" + data_dtl[i]['dept_name'] + "</td>";
                    str += "<td><textarea id='" + data_dtl[i]['studio_code'] + "' name='remark' rows='4' cols='50'>" + data_dtl[i]['remark'] + "</textarea></td>";
                   
                    if (to_be_decided_status == false)
                    {
                        
                        if (to_be_decided_status != true)
                        {
                            if (data_dtl[i]['shortlist_status'] == "") {
                                str += "<td><button type='button' onclick='rowClick_approve(this)' id=" + data_dtl[i]['user_id'] + '_' + data_dtl[i]['studio_code'] + " class='cls_btn_pdf btn btn-primary btn-small' data-bind-userid = " + data_dtl[i]['user_id'] +">ShortList</button></td>";
                               // str += "<td></td>";

                            }
                            else if (data_dtl[i]['shortlist_status'] == "A") {
                                str += "<td>Shortlisted</td>";
                            }
                            else str += "<td></td>"; '';
                        }
                        else 
                        {
                            if (data_dtl[i]['shortlist'] == "" && data_dtl[i]['approved'] == "N")
                            {

                                var row_value = data_dtl[i]['instructor_code'] + '_' + data_dtl[i]['studio_code'];
                                str += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_approve_tobedecided(this)" class="cls_btn_pdf btn btn-primary btn-small">ShortList</button></center></td>';
                            }
                            else if (data.shortlist == "Y") {//
                                str += '<td>Shortlisted</td>';
                            }
                            else str += '<td></td>';

                        }

                        if (data_dtl[i]['shortlist_status'] == "R") {
                            str += '<td>Rejected</td>';
                        }
                        else if (data_dtl[i]['approved'] == 'Y') {
                            var row_value = data_dtl[i]['user_id'] + '_' + data_dtl[i]['studio_code'];
                            str += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_reject(this)"  data-bind-userid = ' + data_dtl[i]['user_id'] +' class="cls_btn_pdf btn btn-primary btn-small">Reject</button></center></td>';

                        }
                        else if (data_dtl[i]['shortlist_status'] == "") {

                            var row_value = data_dtl[i]['user_id'] + '_' + data_dtl[i]['studio_code'];
                            str += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_reject(this)" data-bind-userid = ' + data_dtl[i]['user_id'] +' class="cls_btn_pdf btn btn-primary btn-small">Reject</button></center></td>';
                        }
                        
                        else str += '<td></td>';
                    }
                    else
                    {
                        str += "<td></td><td></td>";
                    }
                    str += "</tr>";
                    status_bind = false;
                }
            }
            $('#Bind_data').html(str);
            table = '';
            //table = $('#example').DataTable();


            table = $('#example').DataTable({
                destroy: true,
                initComplete: function () {
                    hideLoader();
                }
            });

            if (shortlist == true) {

            }
            else if (non_shortlist == true) {

                $("#example tbody tr").each(function (j) {
                    if (table != "") {
                        if (non_shortlist == true) {
                            var tr = $(this).closest('tr');
                            var rowId = $(this).closest('tr').children('td:eq(1)').text();
                            var row = table.row(tr);
                            var test = ShowStudioWiseTutorDetails(rowId);
                            if (test != "") {
                                row.child(test).show();
                                row.child.isShown()
                                tr.addClass('shown');

                            }
                        }



                    }

                });
                 
                $('#example').on('draw.dt', function () {

                    $("#example tbody tr").each(function (j) {

                        if (table != "") {
                            if (non_shortlist == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = ShowStudioWiseTutorDetails(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown()
                                    tr.addClass('shown');

                                }

                            }
                        }

                    });
                });

                $('#example tbody').off().on('click', 'td:first-child', function () {

                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    if (row.child.isShown()) {
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        var test = ShowStudioWiseTutorDetails(rowId);
                        row.child(test).show();
                        tr.addClass('shown');
                    }
                });
            }
            else if (to_be_decided_status == true) {
                $("#example tbody tr").each(function (j) {

                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    var test = to_be_decided_details(rowId);
                    if (test != "") {
                        row.child(test).show();
                        row.child.isShown();
                        tr.addClass('shown');


                    }

                });

                $('#example').on('draw.dt', function () {
                    $("#example tbody tr").each(function (j) {

                        if (table != "") {
                            if (to_be_decided_status == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = to_be_decided_details(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown();
                                }
                            }


                        }



                    });
                });

                $('#example tbody').off().on('click', 'td:first-child', function () {

                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    if (row.child.isShown()) {
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        var test
                        if (to_be_decided_status_new == true) {
                            test = to_be_decided_details_new(rowId);
                        }
                        else if (TBD_Status == true)
                        {
                            test = TBD_List(rowId);
                        }
                        else { test = to_be_decided_details(rowId); }

                        row.child(test).show();
                        tr.addClass('shown');
                        tr.removeClass('shown')
                    }
                });
            }
            else if (to_be_decided_status_new == true) {

                $("#example tbody tr").each(function (j) {

                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    var test = to_be_decided_details_new(rowId);
                    if (test != "") {
                        row.child(test).show();
                        row.child.isShown();
                        tr.addClass('shown');

                    }

                });

                $('#example').on('draw.dt', function () {

                    $("#example tbody tr").each(function (j) {
                        if (table != "") {

                            if (to_be_decided_status_new == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = to_be_decided_details_new(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown();
                                    tr.addClass('shown');
                                }
                            }


                        }



                    });
                });


            }
            else if (TBD_Status == true) {

                $("#example tbody tr").each(function (j) {

                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    var test = TBD_List(rowId);
                    if (test != "") {
                        row.child(test).show();
                        row.child.isShown();
                        tr.addClass('shown');

                    }

                });

                $('#example').on('draw.dt', function () {

                    $("#example tbody tr").each(function (j) {
                        if (table != "") {

                            if (to_be_decided_status_new == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = TBD_List(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown();
                                    tr.addClass('shown');
                                }
                            }


                        }



                    });
                });
            }


            //$('#DataList').css('display', 'block');
            $('#DataList').css('display', 'inline-block');
        }


        function display_studio_proposal_detail_new(data) {

            var str = "";
            var status_bind = false;
            if (table != "") {
                table.destroy();
            }
            //var data_dtl = JSON.parse(data);
            var data_dtl = data;
            var duplicate_studio_code = '';
            for (var i = 0; i < data_dtl.length; i++) {
                if (i == 0) {
                    duplicate_studio_code = data_dtl[i]['studio_code'];
                    status_bind = true
                }
                else {
                    if (duplicate_studio_code != data_dtl[i]['studio_code']) {
                        duplicate_studio_code = data_dtl[i]['studio_code'];
                        status_bind = true;
                    }

                }
                if (status_bind) {

                    if (data_dtl[i]['shortlist_status'] == "") {
                        str += "<tr>";
                        str += "<td class='sorting_1'></td>";
                        str += "<td>" + data_dtl[i]['studio_code'] + "</td>";
                        str += "<td>" + data_dtl[i]['studio_title'] + "</td>";
                        str += "<td><textarea id='topic' name='topic' rows='4' cols='50'>" + data_dtl[i]['studio_description'] + "</textarea></td>";
                        str += "<td>" + data_dtl[i]['no_of_tutor'] + "</td>";
                        str += "<td>" + data_dtl[i]['teaching_mode'] + "</td>";
                        str += "<td>" + data_dtl[i]['studio_level'] + "</td>";
                        str += "<td>" + data_dtl[i]['dept_name'] + "</td>";
                        str += "<td><textarea id='" + data_dtl[i]['studio_code'] + "' name='remark' rows='4' cols='50'>" + data_dtl[i]['remark'] + "</textarea></td>";

                        //if (to_be_decided_status != true)
                        //{
                        //    if (data_dtl[i]['shortlist_status'] == "R" || data_dtl[i]['shortlist_status'] == "") {
                        //        str += "<td><button type='button' onclick='rowClick_approve(this)' id=" + data_dtl[i]['user_id'] + '_' + data_dtl[i]['studio_code'] + " class='cls_btn_pdf btn btn-primary btn-small'>ShortList</button></td>";
                        //
                        //    }
                        //    else if (data_dtl[i]['shortlist_status'] == "A") {
                        //        str += "<td>Shortlisted</td>";
                        //    }
                        //    else str += "<td></td>"; '';
                        //}
                        //else {
                        //    if (data_dtl[i]['shortlist'] == "" && data_dtl[i]['approved'] == "N") {
                        //
                        //        var row_value = data_dtl[i]['instructor_code'] + '_' + data_dtl[i]['studio_code'];
                        //        str += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_approve_tobedecided(this)">ShortList</button></center></td>';
                        //    }
                        //    else if (data.shortlist == "Y") {//
                        //        str += '<td>Shortlisted</td>';
                        //    }
                        //    else str += '<td></td>';
                        //
                        //}

                        var row_value = data_dtl[i]['instructor_code'] + '_' + data_dtl[i]['studio_code'];
                        str += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_approve(this)" class="cls_btn_pdf btn btn-primary btn-small" data-bind-userid = ' + data_dtl[i]['instructor_code'] +'>ShortList</button></center></td>';
                        if (data_dtl[i]['shortlist_status'] == "R")
                        {
                            str += '<td>Rejected</td>';
                        }
                        else if (data_dtl[i]['approved'] == 'Y')
                        {
                            var row_value = data_dtl[i]['instructor_code'] + '_' + data_dtl[i]['studio_code'];
                            str += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_reject(this)" data-bind-userid = ' + data_dtl[i]['instructor_code'] +' class="cls_btn_pdf btn btn-primary btn-small">Reject</button></center></td>';

                        }
                        else if (data_dtl[i]['shortlist_status'] == "") {

                            var row_value = data_dtl[i]['instructor_code'] + '_' + data_dtl[i]['studio_code'];
                            str += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_reject(this)" data-bind-userid = ' + data_dtl[i]['instructor_code'] +' class="cls_btn_pdf btn btn-primary btn-small">Reject</button></center></td>';
                        }

                        else str += '<td></td>';

                        str += "</tr>";
                        status_bind = false;
                    }
                }
            }
            $('#Bind_data').html(str);
            table = '';
            //table = $('#example').DataTable();

            table = $('#example').DataTable({
                destroy: true,
                initComplete: function () {
                    hideLoader();
                }
            });

            if (shortlist == true) {

            }
            else if (non_shortlist == true) {

                $("#example tbody tr").each(function (j) {
                    if (table != "") {
                        if (non_shortlist == true) {
                            var tr = $(this).closest('tr');
                            var rowId = $(this).closest('tr').children('td:eq(1)').text();
                            var row = table.row(tr);
                            var test = ShowStudioWiseTutorDetails(rowId);
                            if (test != "") {
                                row.child(test).show();
                                row.child.isShown();
                                tr.addClass('shown');
                            }
                        }



                    }

                });

                $('#example').on('draw.dt', function () {

                    $("#example tbody tr").each(function (j) {
                        if (table != "") {
                            if (non_shortlist == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = ShowStudioWiseTutorDetails(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown()
                                    tr.addClass('shown');
                                }

                            }
                        }

                    });
                });

                $('#example tbody').off().on('click', 'td:first-child', function () {

                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    if (row.child.isShown()) {
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        var test = ShowStudioWiseTutorDetails(rowId);
                        row.child(test).show();
                        tr.addClass('shown');
                    }
                });
            }
            else if (to_be_decided_status == true) {
                $("#example tbody tr").each(function (j) {
                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    var test = to_be_decided_details(rowId);
                    if (test != "") {
                        row.child(test).show();
                        row.child.isShown();
                        //tr.removeClass('shown');
                        tr.addClass('shown');

                    }

                });

                $('#example').on('draw.dt', function () {
                    $("#example tbody tr").each(function (j) {
                        if (table != "") {
                            if (to_be_decided_status == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = to_be_decided_details(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown();
                                    tr.addClass('shown');
                                }
                            }


                        }



                    });
                });

                $('#example tbody').off().on('click', 'td:first-child', function () {
                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    if (row.child.isShown()) {
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        var test;
                        if (to_be_decided_status_new == true) {
                            test = to_be_decided_details_new(rowId);
                        }
                        else { test = to_be_decided_details(rowId); }

                        row.child(test).show();

                        tr.addClass('shown');
                    }
                });
            }


            else if (to_be_decided_status_new == true) {

                $("#example tbody tr").each(function (j) {
                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    var test = to_be_decided_details_new(rowId);
                    if (test != "") {
                        row.child(test).show();
                        row.child.isShown()

                    }

                });

                $('#example').on('draw.dt', function () {

                    $("#example tbody tr").each(function (j) {
                        if (table != "") {
                            if (to_be_decided_status_new == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = to_be_decided_details_new(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown();
                                }
                            }


                        }



                    });
                });


            }

            else if (TBD_Status == true) {

                $("#example tbody tr").each(function (j) {
                    if (table != "") {
                        if (non_shortlist == true) {
                            var tr = $(this).closest('tr');
                            var rowId = $(this).closest('tr').children('td:eq(1)').text();
                            var row = table.row(tr);
                            var test = TBD_List(rowId);
                            if (test != "") {
                                row.child(test).show();
                                row.child.isShown();
                                tr.addClass('shown');
                            }
                        }



                    }

                });

                $('#example').on('draw.dt', function () {

                    $("#example tbody tr").each(function (j) {
                        if (table != "") {
                            if (non_shortlist == true) {
                                var tr = $(this).closest('tr');
                                var rowId = $(this).closest('tr').children('td:eq(1)').text();
                                var row = table.row(tr);
                                var test = TBD_List(rowId);
                                if (test != "") {
                                    row.child(test).show();
                                    row.child.isShown()
                                    tr.addClass('shown');
                                }

                            }
                        }

                    });
                });

                $('#example tbody').off().on('click', 'td:first-child', function () {

                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    if (row.child.isShown()) {
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        var test = TBD_List(rowId);
                        row.child(test).show();
                        tr.addClass('shown');
                    }
                });
            }

            $('#DataList').css('display', 'inline-block');
        }

        //not use this funcation 
        function ShowStudioWiseTutorDetails_new(d) {
            var stringdata = "";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_instructor_wise_shortlist_to_be_decided_details_studiocode_wise_v1",
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',dept_code:'" + dept_code_ + "',studio_code:'" + d + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {

                        var json_data = JSON.parse(data.d);

                        if (table != "") {

                        }
                        stringdata += '<table cellpadding="5" cellspacing="0" border="0" id="bind_sub" class="table table-striped table-bordered display">' +
                            '<tr>' +
                            '<th>Name</th>' +
                            '<th>Mail </th>' +
                            '<th>Total Experience </th>' +
                            '<th>Designation</th>' +
                            '<th>Work Designation</th>' +
                            '<th>Current Organization</th>' +
                            '<th>Rate Band</th>' +
                            '<th>Contact</th>' +
                            '<th>Location</th>' +
                            '<th>CV</th>' +
                            '<th>Proposal</th>' +
                            '<th>Portfolio</th>' +
                            //'<th>Download ALL</th>' +
                            '<th>Shortlist</th>' +

                            '</tr > ';
                        debugger;
                        for (var i = 0; i < json_data.length; i++) {
                            stringdata += '<tr>';
                            if (json_data[i]['instructor_code'].substring(0, 4) == 'TBD_') {
                                stringdata += '<td>' + json_data[i]['instructor_code'] + '</td>';
                            }
                            else {
                                stringdata += '<td>' + json_data[i]['full_name'] + '</td>';
                            }

                            stringdata += '<td>' + json_data[i]['mail'] + '</td>' +
                                '<td>' + json_data[i]['total_experiance'] + '</td>' +
                                '<td>' + json_data[i]['designation'] + ' </td>' +
                                '<td>' + json_data[i]['work_designation'] + ' </td>' +
                                '<td>' + json_data[i]['work_institute'] + ' </td>' +
                                '<td>' + json_data[i]['rate_band'] + ' </td>' +
                                '<td>' + json_data[i]['mobile_no'] + ' </td>' +
                                '<td>' + json_data[i]['city'] + ' </td>';
                            if (json_data[i]['cv_file_name'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + json_data[i]['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }


                            if (json_data[i]['ppt_video'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_proposal_download(this)" id=' + json_data[i]['ppt_video'] + ' class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }

                            if (json_data[i]['portfolio_file_name'] != "") {
                                '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + json_data[i]['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }

                            // stringdata += '<td><center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center></td>';


                            if (json_data[i]['shortlist'] == 'Y') {
                                stringdata += '<td>Shortlisted</td>';
                            }
                            else {
                                stringdata += "<td><button type='button' onclick='rowClick_approve(this)' id=" + json_data[i]['user_id'] + '_' + json_data[i]['studio_code'] + " class='cls_btn_pdf btn btn-primary btn-small' data-bind-userid = " + json_data[i]['user_id'] +">ShortList</button></td>";
                            }
                            // if (json_data[i]['cancel_flag'] == 'N') {
                            //     stringdata += '<td>Allocated</td>' +
                            //         '<td><button type="button" onclick="rowClick_deallocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + ' class="cls_btn_pdf btn btn-primary btn-small">Deallocate</button></td>';
                            // }
                            // else if (json_data[i]['cancel_flag'] == 'Y') {
                            //     stringdata += '<td>Deallocated</td>' +
                            //         '<td><button type="button" onclick="rowClick_allocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + '  class="cls_btn_pdf btn btn-primary btn-small">Allocate</button></td>';
                            // }
                            stringdata += '</tr>';
                        }
                        stringdata += '</table>';
                        return stringdata;
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
            return stringdata;
            // return false;
        }

        function ShowStudioWiseTutorDetails(d) {
            var stringdata = "";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_instructor_wise_shortlist_to_be_decided_details_studiocode_wise",
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',dept_code:'" + dept_code_ + "',studio_code:'" + d + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {

                        var json_data = JSON.parse(data.d);

                        if (table != "") {

                        }
                        debugger;
                        stringdata += '<table cellpadding="5" cellspacing="0" border="0" id="bind_sub" class="table table-striped table-bordered display">' +
                            '<tr>' +
                            '<th>Name</th>' +
                            '<th>Mail </th>' +
                            '<th>Total Experience </th>' +
                            '<th>Designation</th>' +
                            '<th>Work Designation</th>' +
                            '<th>Current Organization</th>' +
                            '<th>Rate Band</th>' +
                            '<th>Contact</th>' +
                            '<th>Location</th>' +
                            '<th>CV</th>' +
                            '<th>Proposal</th>' +
                            '<th>Portfolio</th>' +
                            '<th>New Course Code</th>' +
                            '</tr> ';
                        //'<th>Download ALL</th>' +


                        for (var i = 0; i < json_data.length; i++) {
                            stringdata += '<tr>';
                            if (json_data[i]['instructor_code'].substring(0, 4) == 'TBD_') {
                                stringdata += '<td>' + json_data[i]['instructor_code'] + '</td>';
                            }
                            else {
                                stringdata += '<td>' + json_data[i]['full_name'] + '</td>';
                            }

                            stringdata += '<td>' + json_data[i]['mail'] + '</td>' +
                                '<td>' + json_data[i]['total_experiance'] + '</td>' +
                                '<td>' + json_data[i]['designation'] + ' </td>' +
                                '<td>' + json_data[i]['work_designation'] + ' </td>' +
                                '<td>' + json_data[i]['work_institute'] + ' </td>' +
                                '<td>' + json_data[i]['rate_band'] + ' </td>' +
                                '<td>' + json_data[i]['mobile_no'] + ' </td>' +
                                '<td>' + json_data[i]['city'] + ' </td>';
                           
                            if (json_data[i]['cv_file_name'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + json_data[i]['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }


                            if (json_data[i]['ppt_video'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_proposal_download(this)" id=' + json_data[i]['ppt_video'] + ' class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }

                            if (json_data[i]['portfolio_file_name'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + json_data[i]['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }

                            stringdata += '<td>' + json_data[i]['course_code'] + '</td>';

                            //'<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + json_data[i]['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>' +
                            //'<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_proposal_download(this)" id=' + json_data[i]['ppt_video'] + ' class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>' +
                            //'<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + json_data[i]['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>' +
                            //stringdata += '<td></td>';

                            // if (json_data[i]['cancel_flag'] == 'N') {
                            //     stringdata += '<td>Allocated</td>' +
                            //         '<td><button type="button" onclick="rowClick_deallocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + ' class="cls_btn_pdf btn btn-primary btn-small">Deallocate</button></td>';
                            // }
                            // else if (json_data[i]['cancel_flag'] == 'Y') {
                            //     stringdata += '<td>Deallocated</td>' +
                            //         '<td><button type="button" onclick="rowClick_allocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + '  class="cls_btn_pdf btn btn-primary btn-small">Allocate</button></td>';
                            // }
                            stringdata += '</tr>';
                        }
                        stringdata += '</table>';
                        return stringdata;
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
            return stringdata;
            // return false;
        }


        function to_be_decided_details(studio_code) {

            var stringdata = "";
            if (table != "") {

            }
            stringdata += '<table cellpadding="5" cellspacing="0" border="0" id="bind_sub" class="table table-striped table-bordered display">' +
                '<tr>' +
                '<th>Name</th>' +
                '<th>Mail </th>' +
                '<th>Total Experience </th>' +
                '<th>Designation</th>' +
                '<th>Work Designation</th>' +
                '<th>Current Organization</th>' +
                '<th>Rate Band</th>' +
                '<th>Contact</th>' +
                '<th>Location</th>' +
                '<th>CV</th>' +
                '<th>Proposal</th>' +
                '<th>Portfolio</th>' +
                //'<th>Download ALL</th>' +
                '<th>New Course Code</th>' +
                '<th>Short List</th>' +
                '<th>Reject</th>' +

                '</tr > ';

            for (var i = 0; i < json_dtl.length; i++) {
                if (json_dtl[i]['studio_code'] == studio_code) {
                    stringdata += '<tr>';
                    if (json_dtl[i]['instructor_code'] != undefined) {
                        if (json_dtl[i]['instructor_code'].substring(0, 4) == 'TBD_') {
                            stringdata += '<td>' + json_data[i]['instructor_code'] + '</td>';
                        }
                        else {
                            stringdata += '<td>' + json_dtl[i]['full_name'] + '</td>';
                        }

                    }
                    else {
                        stringdata += '<td>' + json_dtl[i]['full_name'] + '</td>';

                    }

                    stringdata += '<td>' + json_dtl[i]['mail'] + '</td>' +
                        '<td>' + json_dtl[i]['total_experiance'] + '</td>' +
                        '<td>' + json_dtl[i]['designation'] + ' </td>' +
                        '<td>' + json_dtl[i]['work_designation'] + ' </td>' +
                        '<td>' + json_dtl[i]['work_institute'] + ' </td>' +
                        '<td>' + json_dtl[i]['rate_band'] + ' </td>' +
                        '<td>' + json_dtl[i]['mobile_no'] + ' </td>' +
                        '<td>' + json_dtl[i]['city'] + ' </td>';
                    //data.cv_file_name != ''
                    if (json_dtl[i]['cv_file_name'] != '') {
                        stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + json_dtl[i]['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                    }
                    else {
                        stringdata += '<td></td>';
                    }
                    stringdata += '<td></td>';
                    if (json_dtl[i]['portfolio_file_name'] != '') {
                        stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + json_dtl[i]['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                    }
                    else {
                        stringdata += '<td></td>';
                    }
                    //stringdata += '<td></td>' +
                    stringdata += '<td>' + json_dtl[i]['course_code'] + '</td>';

                    stringdata += '<td></td>';
                    stringdata += '<td></td>';
                    stringdata += '</tr>';


                }

            }
            stringdata += '</table>';
            return stringdata;
        }


        function to_be_decided_details_new(studio_code) {

            var stringdata = "";
            if (table != "") {

            }
            stringdata += '<table cellpadding="5" cellspacing="0" border="0" id="bind_sub" class="table table-striped table-bordered display">' +
                '<tr>' +
                '<th>Name</th>' +
                '<th>Mail </th>' +
                '<th>Total Experience </th>' +
                '<th>Designation</th>' +
                '<th>Work Designation</th>' +
                '<th>Current Organization</th>' +
                '<th>Rate Band</th>' +
                '<th>Contact</th>' +
                '<th>Location</th>' +
                '<th>CV</th>' +
                '<th>Proposal</th>' +
                '<th>Portfolio</th>' +
                //'<th>Download ALL</th>' +
                '<th>New Course Code</th>' +
                '<th>Short List</th>' +
                '<th>Reject</th>' +

                '</tr > ';

            for (var i = 0; i < json_dtl_new.length; i++) {
                if (json_dtl_new[i]['studio_code'] == studio_code) {
                    stringdata += '<tr>';
                    if (json_dtl_new[i]['instructor_code'] != undefined) {
                        if (json_dtl_new[i]['instructor_code'].substring(0, 4) == 'TBD_') {
                            stringdata += '<td>' + json_data[i]['instructor_code'] + '</td>';
                        }
                        else {
                            stringdata += '<td>' + json_dtl_new[i]['full_name'] + '</td>';
                        }

                    }
                    else {
                        stringdata += '<td>' + json_dtl_new[i]['full_name'] + '</td>';

                    }

                    stringdata += '<td>' + json_dtl_new[i]['mail'] + '</td>' +
                        '<td>' + json_dtl_new[i]['total_experiance'] + '</td>' +
                        '<td>' + json_dtl_new[i]['designation'] + ' </td>' +
                        '<td>' + json_dtl_new[i]['work_designation'] + ' </td>' +
                        '<td>' + json_dtl_new[i]['work_institute'] + ' </td>' +
                        '<td>' + json_dtl_new[i]['rate_band'] + ' </td>' +
                        '<td>' + json_dtl_new[i]['mobile_no'] + ' </td>' +
                        '<td>' + json_dtl_new[i]['city'] + ' </td>';
                    //data.cv_file_name != ''
                    if (json_dtl_new[i]['cv_file_name'] != '') {
                        stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + json_dtl_new[i]['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                    }
                    else {
                        stringdata += '<td></td>';
                    }
                    stringdata += '<td></td>';
                    if (json_dtl_new[i]['portfolio_file_name'] != '') {
                        stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + json_dtl_new[i]['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                    }
                    else {
                        stringdata += '<td></td>';
                    }
                    //stringdata += '<td></td>' +
                    stringdata += '<td>' + json_dtl_new[i]['course_code'] + '</td>';

                    if (json_dtl_new[i]['to_be_later'] == 'Y') {
                        if (json_dtl_new[i]['shortlist'] == "Y")
                        {
                            stringdata += '<td>Shortlisted</td>';
                        }
                        else {
                            var row_value = json_dtl_new[i]['instructor_code'] + '_' + json_dtl_new[i]['studio_code'];
                            stringdata += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_approve_tobedecided(this)" class="cls_btn_pdf btn btn-primary btn-small">ShortList</button></center></td>';
                        }
                    }
                    else if (json_dtl_new[i]['shortlist'] == "Y") {//
                        stringdata += '<td>Shortlisted</td>';
                    }

                    //else if (json_dtl_new[i]['shortlist'] == "" && json_dtl_new[i]['approved'] == "N")
                    //{
                    //    
                    //    var row_value = json_dtl_new[i]['instructor_code'] + '_' + json_dtl_new[i]['studio_code'];
                    //    stringdata += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_approve_tobedecided(this)">ShortList</button></center></td>';
                    //}
                    else { stringdata += '<td></td>'; }

                    stringdata += '<td></td>';
                    stringdata += '</tr>';


                }

            }
            
            stringdata += '</table>';
            return stringdata;
        }



        function TBD_List(d) {
            var stringdata = "";
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_instructor_wise_shortlist_to_be_decided_details_studiocode_wise",
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',dept_code:'" + dept_code_ + "',studio_code:'" + d + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {

                        var json_data = JSON.parse(data.d);

                        if (table != "") {

                        }
                        stringdata += '<table cellpadding="5" cellspacing="0" border="0" id="bind_sub" class="table table-striped table-bordered display">' +
                            '<tr>' +
                            '<th>Name</th>' +
                            '<th>Mail </th>' +
                            '<th>Total Experience </th>' +
                            '<th>Designation</th>' +
                            '<th>Work Designation</th>' +
                            '<th>Current Organization</th>' +
                            '<th>Rate Band</th>' +
                            '<th>Contact</th>' +
                            '<th>Location</th>' +
                            '<th>CV</th>' +
                            '<th>Proposal</th>' +
                            '<th>Portfolio</th>' +
                            '<th>Shortlist</th>' +
                            '<th>New Course Code</th>' +
                            '</tr> ';
                        //'<th>Download ALL</th>' +


                        for (var i = 0; i < json_data.length; i++) {
                            stringdata += '<tr>';
                            if (json_data[i]['instructor_code'].substring(0, 4) == 'TBD_') {
                                stringdata += '<td>' + json_data[i]['instructor_code'] + '</td>';
                            }
                            else {
                                stringdata += '<td>' + json_data[i]['full_name'] + '</td>';
                            }

                            stringdata += '<td>' + json_data[i]['mail'] + '</td>' +
                                '<td>' + json_data[i]['total_experiance'] + '</td>' +
                                '<td>' + json_data[i]['designation'] + ' </td>' +
                                '<td>' + json_data[i]['work_designation'] + ' </td>' +
                                '<td>' + json_data[i]['work_institute'] + ' </td>' +
                                '<td>' + json_data[i]['rate_band'] + ' </td>' +
                                '<td>' + json_data[i]['mobile_no'] + ' </td>' +
                                '<td>' + json_data[i]['city'] + ' </td>';
                            
                            if (json_data[i]['cv_file_name'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + json_data[i]['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }


                            if (json_data[i]['ppt_video'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_proposal_download(this)" id=' + json_data[i]['ppt_video'] + ' class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }

                            if (json_data[i]['portfolio_file_name'] != "") {
                                stringdata += '<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + json_data[i]['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>';
                            }
                            else {
                                stringdata += '<td></td>';
                            }
                            if (json_data[i]['to_be_later'] == 'Y' && json_data[i]['instructor_code'].substring(0, 4) != 'TBD_' && json_data[i]['shortlist_status'] == 'A')
                            {
                                if (json_data[i]['shortlist'] == "Y")
                                {
                                    stringdata += '<td>Shortlisted</td>';
                                }
                                else
                                {
                                    var row_value = json_data[i]['instructor_code'] + '_' + json_data[i]['studio_code'];
                                    stringdata += '<td><center><button type="button" id=' + row_value + ' onclick="rowClick_approve_tobedecided(this)" class="cls_btn_pdf btn btn-primary btn-small">ShortList</button></center></td>';
                                }
                            }
                            else
                            {
                                //Not Shortlist User
                                stringdata += '<td></td>';
                            }





                            stringdata += '<td>' + json_data[i]['course_code'] + '</td>';

                            //'<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + json_data[i]['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>' +
                            //'<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_proposal_download(this)" id=' + json_data[i]['ppt_video'] + ' class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>' +
                            //'<td><center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download_old(this)" id=' + json_data[i]['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center> </td>' +
                            //stringdata += '<td></td>';

                            // if (json_data[i]['cancel_flag'] == 'N') {
                            //     stringdata += '<td>Allocated</td>' +
                            //         '<td><button type="button" onclick="rowClick_deallocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + ' class="cls_btn_pdf btn btn-primary btn-small">Deallocate</button></td>';
                            // }
                            // else if (json_data[i]['cancel_flag'] == 'Y') {
                            //     stringdata += '<td>Deallocated</td>' +
                            //         '<td><button type="button" onclick="rowClick_allocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + '  class="cls_btn_pdf btn btn-primary btn-small">Allocate</button></td>';
                            // }
                            stringdata += '</tr>';
                        }
                        stringdata += '</table>';
                        return stringdata;
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
            return stringdata;
            // return false;
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i><span id="title_name">Instructor Wise Shortlist Studio Proposal </span>
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
                                <td id="type">Type :</td>
                                <td id="type_desc">
                                    <select class="chosen-select" id="drptype">
                                    </select>
                                </td>
                                <td>Studio Level :</td>
                                <td id="studio_level">
                                    <select class="chosen-select" id="drpstudiolevel">
                                        <option value="">Please Select Studio Level</option>
                                        <option value="L2">L2</option>
                                        <option value="L3">L3</option>
                                        <option value="L4">L4</option>
                                    </select>
                                </td>
                                </tr>
                            <tr>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                                <%--<td>Program Level :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>--%>
                                <%--<td>Level :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drlevel">
                                    </select>
                                </td>--%>
                            </tr>
                            <tr>
                                <%--<td id="type">Type :</td>
                                <td id="type_desc">
                                    <select class="chosen-select" id="drptype">
                                    </select>
                                </td>--%>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <%--<div id="div_studio_proposal_dtl" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Shortlist Studio Proposal</strong>
            </div>
            <div id="DataList" style="display: none; overflow: auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        </div>--%>

        <div>
        </div>


        <div id="ifrm_outline" style="display: none;"></div>
    </div>

    <div id="DataList" style="display: none; overflow: hidden;" class="panel panel-default">
        <%--margin-left: -129px;--%>
        <div class="panel-heading">
            <strong id="panel_head">Instructor Wise Shortlist Studio Proposal</strong>
        </div>
        <table id="example" class="display table table-striped table-bordered table-hover" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th></th>
                    <th>Studio Code </th>
                    <th>Studio Title </th>
                    <th>Studio Description</th>
                    <th>No of Tutor</th>
                    <th>Mode of Teaching</th>
                    <th>Level</th>
                    <th>Faculty Name</th>
                    <th>Remark</th>
                    <th>Shortlist</th>
                    <th>Reject</th>
                </tr>
            </thead>
            <tbody id="Bind_data"></tbody>
        </table>
    </div>
   <%-- <div id="pdfModal" class="modal fade" tabindex="-1">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-body">
        <iframe id="pdfFrame" src="" width="100%" height="600px"></iframe>
      </div>
    </div>
  </div>
</div>--%>
    <asp:Button ID="btnDownloadportfolio" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadportfolio_Click" />
    <asp:Button ID="btnDownloadproposal" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadproposal_Click" />
    <asp:Button ID="btnDownloadcv" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadcv_Click" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadExcelDocuments_Click" />
    <asp:Button ID="btnDownloadweekly" runat="server" Text="Button" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadweekly_Click" />
    <asp:HiddenField ID="hdn_file_name" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_weekly_file_name" runat="server" ClientIDMode="Static" />



    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='https://cdn.datatables.net/s/ju/dt-1.10.10,b-1.1.0,fc-3.2.0,fh-3.1.0,r-2.0.0,sc-1.4.0/datatables.min.js'></script>

    <style>
        body {
            overflow: auto;
        }

        #main-container {
            padding: 10px;
            width: max-content;
        }
    </style>
    
</asp:Content>

