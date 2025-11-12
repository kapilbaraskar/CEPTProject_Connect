<%@ Page Title="VF Authorize Rate Band" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="studio_proposal_authorize.aspx.cs" Inherits="Admin_Master_studio_proposal_authorize" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

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
        var message_type = 'Studio Proposal and Rate Band Authorized Successfully';
        var inst_profile_pic = [];
        $(document).ready(function () {
            user_type = $('#hdn_user_type').val();
            bindsemdata();
            bindyeardata_for_cross_reg();
            binddepartment();
            bindproglevel();
            bindleveldata();
            bindtypedata();
            bindprogrammedata();

            $('#btnreterive').on('click', function () {
                get_studio_detail();
                return false;
            });
            $('#btndownloadpic').on('click', function () {
                downloadimage();
                return false;
            });
            $('#btnsendmail').on('click', function () {
                Send_mail_select_checkbox();
                return false;
            });
        });
        //function rowClick_download(row) {
        //    $('#hdn_file_name').val(row.id);
        //    $("#btnDownloadvideo").click();

        //}

        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("Y").html("Authorized"));
            $('#drptype').append($("<option></option>").val("R").html("Rejected"));


            $('#drptype').chosen();

        }

        $(document).on("click", ".authorize", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["user_id"];
            var instructor_name = aData["full_name"];
            var email = aData["mail"];
            var inst_designation = aData["inst_designation"];
            var cpop_user_flag = aData["cpop_user_status"];
            var details = aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_A';
            var remark_id = aData["user_id"] + '_' + aData["studio_code"];
            var reject_remark = $('#' + remark_id).val();
            var TA_user = aData["TA_user"];


            var remark_details = "";
            remark_details =
            {
                "instructor_code": aData["user_id"],
                "instructor_name": aData["full_name"],
                "email": aData["mail"],
                "inst_designation": aData["inst_designation"],
                "cpop_user_flag": aData["cpop_user_status"],
                "details": aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_A',
                "remark_id": aData["user_id"] + '_' + aData["studio_code"],
                "reject_remark": $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "rateband": aData["rate_band"],
            };

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

            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }


            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_total_contact_hrs",
                    data: "{inst_code:'" + aData["user_id"] + "',year_code:'" + year_code + "',sem_code:'" + semester + "',studio_code:'" + aData["studio_code"]+"'}",
                    async: false,
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            var json_dtl = JSON.parse(data.d);
                            if (json_dtl[0].contact_hrs > 40) {
                                bootbox.confirm({
                                    message: "Are you sure to approve rate band of this tutor who already completed or greater than 40 hours in courses/studios ? Approved hours : " + json_dtl[0].total_contact_hrs + " Remaining hours: " + json_dtl[0].remening_hrs +"",
                                    buttons: {
                                        confirm: {
                                            label: 'Yes',
                                            className: 'btn-success'
                                        },
                                        cancel: {
                                            label: 'No',
                                            className: 'btn-danger'
                                        }
                                    },
                                    callback: function (result) {
                                        if (result == true) {
                                            $.ajax(
                                                {
                                                    type: "POST",
                                                    contentType: "application/json; charset=utf-8",
                                                    url: "../../WebService.asmx/update_studio_detail",
                                                    //data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'" + reject_remark + "'}",
                                                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'',interested_remark_data: '" + json_submit_data + "'}",
                                                    dataType: "json",
                                                    success: function (data) {
                                                        debugger;
                                                        if (data.d != "" && data.d != "[]") {
                                                            if (data.d == "true") {
                                                                if (cpop_user_flag == 'Y') {
                                                                    if (inst_designation == 'temp') {
                                                                        convert_VF_Type(instructor_code, instructor_name, email, TA_user);
                                                                    }
                                                                }
                                                                else {
                                                                    message_type = 'Studio Proposal Authorized Successfully ';
                                                                }
                                                                bootbox.alert(message_type);
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
                                        else
                                        {

                                        }
                                    }
                                });
                            }
                            else
                            {
                                $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        url: "../../WebService.asmx/update_studio_detail",
                                        //data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'" + reject_remark + "'}",
                                        data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'',interested_remark_data: '" + json_submit_data + "'}",
                                        dataType: "json",
                                        success: function (data) {
                                            if (data.d != "" && data.d != "[]") {
                                                if (data.d == "true") {
                                                    if (cpop_user_flag == 'Y') {
                                                        if (inst_designation == 'temp') {
                                                            convert_VF_Type(instructor_code, instructor_name, email, TA_user);
                                                        }
                                                    }
                                                    else {
                                                        message_type = 'Studio Proposal Authorized Successfully ';
                                                    }
                                                    bootbox.alert(message_type);
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


           


            return false;
        });


         

        $(document).on("click", ".auth_sendmail", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["user_id"];
            var instructor_name = aData["full_name"];
            var email = aData["mail"];
            var inst_designation = aData["inst_designation"];
            var cpop_user_flag = aData["cpop_user_status"];
            var details = aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_A';
            var remark_id = aData["user_id"] + '_' + aData["studio_code"];
            var reject_remark = $('#' + remark_id).val();


            var remark_details = "";
            remark_details =
            {
                "instructor_code": aData["user_id"],
                "instructor_name": aData["full_name"],
                "email": aData["mail"],
                "inst_designation": aData["inst_designation"],
                "cpop_user_flag": aData["cpop_user_status"],
                "details": aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_A',
                "remark_id": aData["user_id"] + '_' + aData["studio_code"],
                "reject_remark": $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
            };

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

            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/authorized_inst_send_mail",
                    //data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'" + reject_remark + "'}",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'',interested_remark_data: '" + json_submit_data + "'}",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true")
                            {
                                bootbox.alert("Mail Send Successfully")
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


            return false;
        });

        function authorized_studio()
        {
           
        }

        function rowClick_edit(row) {
            var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor";
            window.open(url, "_blank");
        }
        function select_all_student() {
            if ($('#chk_select_all_student')[0].checked) {
                $("input[name='check_all_student']").attr('checked', 'checked');
            }
            else {
                $("input[name='check_all_student']").removeAttr('checked');
            }
        }

        function Send_mail_select_checkbox() {
            var oSettings = oTable.fnSettings();

            for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                oSettings.aoPreSearchCols[iCol].sSearch = '';
            }

            oSettings.oPreviousSearch.sSearch = '';
            oTable.fnDraw();

            var flag = "N";

            var datalist = [];
            $("#example tbody tr").each(function (i) {
                var obj = {}; 
                if ($(this).find(".chk_course").is(':checked'))
                {
                    flag = 'Y';
                    obj = {};
                    obj["user_id"] = $(this).children().eq(0)[0].children[0].childNodes[0].id;
                    datalist.push(obj);
                }
            });

            if (flag == "Y") {
                var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val() });

                $.ajax({ 
                    type: "POST",
                    url: "../../WebService.asmx/Sendmail_checkbox_checked_inst",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "Problem in save data") {
                                bootbox.alert("Problem in save data");
                                return false;
                            }
                            bootbox.alert("Mail Send Successfully");
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
            else
            {
                bootbox.alert("Please Checked Checkbox");
                return false;
            }
        }

        //function rowClick_approve(row) {
        //    semester = $('#drpsemester').val();
        //    if (semester == "") {
        //        bootbox.alert('Please select semester');
        //        $('#drpsemester').focus();
        //        return false;
        //    }

        //    year_code = $('#drpyear').val();
        //    if (year_code == "") {
        //        bootbox.alert('Please select Year');
        //        $('#drpyear').focus();
        //        return false;
        //    }

        //    $.ajax(
        //        {
        //            type: "POST",
        //            contentType: "application/json; charset=utf-8",
        //            url: "../../WebService.asmx/update_studio_detail",
        //            data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + row.id + "'}",
        //            dataType: "json",
        //            success: function (data) {
        //                if (data.d != "" && data.d != "[]") {
        //                    if (data.d == "true")
        //                    {
        //                       // convert_VF_Type();
        //                        bootbox.alert("Successfully Authorized Instructor");
        //                        get_studio_detail();
        //                    }
        //                }
        //                else {
        //                    bootbox.alert('Problem in Data');
        //                    return false;
        //                }
        //            },
        //            error: function (result) {
        //                alert(result);
        //            }
        //        });

        //}


        function convert_VF_Type(instructor_code, instructor_name, email, TA_user) {
            var user_type = "";
            if (TA_user == "TA") {
                user_type = "TA";
            }
            else { user_type = "VF"; }
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/change_instructor_mst_new_only_ta_vf",
                async: false,
                data: "{instructor_code : '" + instructor_code + "',instructor_name:'" + instructor_name + "',email:'" + email + "',flag:'S',user_type:'" + user_type+"',des_letter:'',instructor_first_name:'',instructor_last_name:''}",
                dataType: "json",
                success: function (data) {
                    var result = JSON.parse(data.d);

                    if (result["status"] != "") {
                        //bootbox.alert('Data Saved / Update successfully.');
                        message_type = 'Studio Proposal,Rate Band and VF Authorized and Submit Successfully';
                    }
                    else {
                        bootbox.alert(result["message"]);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        //function rowClick_edit(row) {

        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Interested_Program.aspx?studio_code=" + row.id + "", '_blank');
        //}

        //function rowClick_brief_edit(row) {
        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?studio_code=" + row.id + "", '_blank');
        //}

        //function rowClick_edit_course_saved(row, sem_code, year_code) {
        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + row.id + "&s=" + sem_code + "&y=" + year_code + "", '_blank');
        //}

        //function rowClick_edit_course(row, sem_code, year_code) {
        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + row.id + "&s=" + sem_code + "&y=" + year_code + "", '_blank');
        //}

        //function rowClick_brief_edit_saved(row) {
        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?c=" + row.id + "", '_blank');
        //}

        //function rowClick_add_course(row, sem_code, year_code) {
        //    var origion = window.location.origin + '/';
        //    window.open(origion + "Admin/Master/Studio_Brief_Details.aspx?studio_code=" + row.id + "&s=" + sem_code + "&y=" + year_code + "", '_blank');
        //}
        //function rowClick_brief_approve(row) {
        //    semester = $('#drpsemester').val();
        //    if (semester == "") {
        //        bootbox.alert('Please select semester');
        //        $('#drpsemester').focus();
        //        return false;
        //    }

        //    year_code = $('#drpyear').val();
        //    if (year_code == "") {
        //        bootbox.alert('Please select Year');
        //        $('#drpyear').focus();
        //        return false;
        //    }

        //    $.ajax(
        //        {
        //            type: "POST",
        //            contentType: "application/json; charset=utf-8",
        //            url: "../../WebService.asmx/update_studio_brief_dtl",
        //            data: "{semester:'" + semester + "',year:'" + year_code + "',course_code:'" + row.id + "'}",
        //            dataType: "json",
        //            success: function (data) {
        //                if (data.d != "" && data.d != "[]") {
        //                    if (data.d == "Update Data") {
        //                        bootbox.alert("Studio Brief Approved successfully");
        //                        get_studio_detail();
        //                    }
        //                }
        //                else {
        //                    bootbox.alert('Problem in Data');
        //                    return false;
        //                }
        //            },
        //            error: function (result) {
        //                alert(result);
        //            }
        //        });
        //}
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


        $(document).on("click", ".portfolio_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var portfolio_file_name = aData["portfolio_file_name"];
            //var ppt_video = aData["ppt_video"];
            $('#hdn_file_name').val(portfolio_file_name);
            $("#btnDownloadportfolio").click();
            return false;
        });

        $(document).on("click", ".proposal_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            //var portfolio_file_name = aData["portfolio_file_name"];
            var ppt_video = aData["ppt_video"];
            $('#hdn_file_name').val(ppt_video);
            $("#btnDownloadproposal").click();
            return false;
        });

        $(document).on("click", ".cv_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var cv_file_name = aData["cv_file_name"];
            $('#hdn_file_name').val(cv_file_name);
            $("#btnDownloadcv").click();
            return false;
        });


        $(document).on("click", ".pdf_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            //var instructor_code = aData["user_id"];
            var instructor_code = aData['user_id']
            var instructor_name = aData["instructor_name"];
            var cv_file_name = aData["cv_file_name"];
            var portfolio_file_name = aData["portfolio_file_name"];
            if (instructor_code == '') {
                if (cv_file_name != '') {
                    var myArr = cv_file_name.split("_");
                    instructor_code = myArr[0];
                }
                if (portfolio_file_name != '') {
                    var myArr = cv_file_name.split("_");
                    instructor_code = myArr[0];

                }
            }



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
                url: "../../WebService.asmx/Download_Document_new",
                data: "{'instructor_code':'" + instructor_code + "','cv_file_name':'" + cv_file_name + "','portfolio_file_name':'" + portfolio_file_name + "'}",
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
            var tutor_type = $('#instructortype').val();
            var type = $('#drptype').val();
            var url_dtl = '';
            if (type == 'Y') {
                url_dtl = '../../WebService.asmx/shortlist_instructor_authorized';
            }
            else if (type == 'R') {
                url_dtl = '../../WebService.asmx/shortlist_instructor_Reject_dtl';
            }
            else {
                url_dtl = '../../WebService.asmx/shortlist_instructor_authorize';
            }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dtl,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',dept_code:'" + dept_code_ + "',tutor_type:'" + tutor_type + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]") {
                            inst_profile_pic = [];
                            var remove_duplicate = [];
                            display_studio_proposal_detail(data.d);
                            $('#div_studio_proposal_dtl').css('display', 'inline-block');
                            var json_data = JSON.parse(data.d);
                            for (var i = 0; i < json_data.length; i++)
                            {
                                var pic_name = 'profile_' + json_data[i]['user_id'] + '.jpg';
                                //var pic_name = json_data[i]['user_id'];
                                remove_duplicate.push(pic_name.trim());

                            }
                           
                            for (var i = 0, l = remove_duplicate.length; i < l; i++)
                                if (inst_profile_pic.indexOf(remove_duplicate[i]) === -1 && remove_duplicate[i] !== '')
                                    inst_profile_pic.push(remove_duplicate[i]);
                          
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
        function display_studio_proposal_detail(data) {
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
                "columnDefs": [

                    { 'visible': false, 'targets': [4, 5, 6, 7, 8, 9,10] }
                ],
                "aaData": JSON.parse(data),



                "aoColumns": [
                    { "sTitle": "Studio Code", "mData": "studio_code" },
                    {
                        "sTitle": "<center><input type='checkbox' id='chk_select_all_student' onchange='select_all_student()' /> Select</center>", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.approved == 'Y' && data.mailsendstatus != 'Y')
                            {
                                var row_value = data.user_id + '_' + data.studio_code;
                                return '<center><input type="checkbox"  name="check_all_student" value="1" class="chk_course" onchange="user_select_change(this)" id="' + row_value + '" /></center>';
                            }
                            else {
                                return '';
                            }

                        }

                    },
                    { "sTitle": "Instructor Code", "mData": "user_id" },
                    { "sTitle": "Instructor Name", "mData": "full_name" },
                    { "sTitle": "VF code", "mData": "VF_code" },
                    { "sTitle": "Date of Birth", "mData": "dob" },
                    { "sTitle": "Blood Group", "mData": "blood_group" },
                    { "sTitle": "Mobile Number", "mData": "mobile_no" },
                    { "sTitle": "Emergency Contact Number", "mData": "emergency_contact_number" },
                    {
                        "sTitle": "Address", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.address;

                            if (row_value != '') {
                                var split_data = row_value.split('@#');
                                if (split_data != undefined) {
                                    row_value = split_data[0].replace('@#', ' ');
                                    row_value = row_value.replace('@c#', ' ');
                                    row_value = row_value.replace('#', ' ');

                                } else {
                                    row_value = row_value.replace('@#', ' ');
                                    row_value = row_value.replace('@c#', ' ');
                                    row_value = row_value.replace('#', ' ');
                                }

                                return row_value.replace('@', ' ');
                            }
                            else {
                                return "";
                            }


                        }
                    },
                    {
                        "sTitle": "Permanent Address", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.permanent_address;
                            if (row_value != '') {
                                row_value = row_value.replace('@#', ' ');
                                row_value = row_value.replace('#', ' ');
                                return row_value.replace('@', ' ');
                                //  return row_value;
                            }
                            else {
                                return "";
                            }


                        }
                    },

                    { "sTitle": "Email", "mData": "mail" },
                    { "sTitle": "Nationality", "mData": "country_name" },
                    { "sTitle": "Instructor Type", "mData": "inst_designation" },
                    { "sTitle": "Title of Studio", "mData": "studio_title" },
                    { "sTitle": "No of Tutor", "mData": "no_of_tutor" },
                    { "sTitle": "Mode of Teaching", "mData": "teaching_mode" },
                    { "sTitle": "Level", "mData": "studio_level" },
                    { "sTitle": "Faculty Name", "mData": "dept_name" },
                    { "sTitle": "Total Experiance", "mData": "total_experiance" },
                    { "sTitle": "Rate Band", "mData": "rate_band" },

                    //{
                    //    "sTitle": "Tutor Type", "mData": null, "bSortable": false, mRender: function (data) {

                    //        if (data.tutor_type_inst.trim() == "T") {
                    //            return '<center>Lead Tutor</center>';
                    //        }
                    //        else if (data.tutor_type_inst.trim() == "CT") {
                    //            return '<center>Co-Tutor</center>';
                    //        }
                    //        else {
                    //            return "";
                    //        }



                    //    }
                    //},


                    {
                        "sTitle": "Personal Details", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.user_id;
                            return '<center><button type="button" id=' + row_value + ' onclick="rowClick_edit(this)" class="per_edit">Edit</button></center>';

                        }
                    },
                    {
                        "sTitle": "Studio Description", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.studio_description != "") {
                                // return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                                return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
                            }
                            else return '';
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

                        "sTitle": "Portfolio", "mData": null, "sClass": "cls_action", mRender: function (data) {

                            if (data.portfolio_file_name != '') {
                                // return 'Y';
                                return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download(this)" id=' + data.portfolio_file_name + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                            }
                            return '';

                        }
                    },
                    {
                        "sTitle": "Personal Document", "mData": null, "sClass": "cls_action", mRender: function (data) {

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
                        "sTitle": "PC/Dean Shortlist Status ", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.shortlist_status == "A") {

                                return "<center style='color: green'>Submitted</center>";
                            }
                            else return "<center style='color: blue'>Pending</center>";
                        }
                    },
                    {
                        "sTitle": "Personal Detail Submit", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.admin_approved == "Y") {

                                return "<center style='color: green'>Submitted</center>";
                            }
                            else return "<center style='color: blue'>Pending</center>";
                        }
                    },
                    //{
                    //    "sTitle": "Rateband Submit", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if (data.rateband_approved == "Y") {
                    //            return "<center style='color: green'>Submitted</center>";
                    //        }
                    //        else return "<center style='color: blue'>Pending</center>";
                    //    }
                    //},
                    //{
                    //    "sTitle": "Workload Submit", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if (data.instructor_workload_admin_approved == "Y") {

                    //            return "<center style='color: green'>Submitted</center>";
                    //        }
                    //        else return "<center style='color: blue'>Pending</center>";
                    //    }
                    //},
                    //{
                    //    "sTitle": "Dean/PC Authorized", "mData": null, "bSortable": false, mRender: function (data) {

                    //        if (data.instructor_workload_hr_approved == "Y") {
                    //            return "<center style='color: green'>Authorized</center>";
                    //        }
                    //        else return "<center style='color: blue'>Pending</center>";
                    //    }
                    //},

                    {
                        "sTitle": "Remark", "mData": null, "bSortable": false, mRender: function (data) {
                            var remark_id = data.user_id + '_' + data.studio_code;

                            if ($('#drptype').val() == 'R') {
                                return '<textarea id=' + remark_id + ' name="remark" rows="4" cols="50">' + data.hr_remark_new + '';
                            }
                            else if ($('#drptype').val() == 'Y') {
                                if (data.hr_remark != "") {
                                    return '<textarea id=' + remark_id + ' name="remark" rows="4" cols="50">' + data.hr_remark + '';
                                }
                                else return '<textarea id=' + remark_id + ' name="remark" rows="4" cols="50">';
                            }
                            else {

                                if (data.hr_remark1 != "") {
                                    return '<textarea id=' + remark_id + ' name="remark" rows="4" cols="50">' + data.hr_remark1 + '';
                                }
                                else if (data.hr_remark != "") {
                                    return '<textarea id=' + remark_id + ' name="remark" rows="4" cols="50">' + data.hr_remark + '';
                                }
                                else return '<textarea id=' + remark_id + ' name="remark" rows="4" cols="50">';

                            }

                        }
                    },


                    {
                        "sTitle": "HR Authorize", "mData": null, "bSortable": false, mRender: function (data) {
                            
                            if ($('#drptype').val() != 'R')
                            {
                                if (data.approved == "N")
                                {
                                    if (data.cpop_user_status == "N")
                                    {
                                        return '';
                                    }
                                    else
                                    {
                                        var row_value = data.user_id + '_' + data.studio_code;
                                        if ($('#drptype').val() == '')
                                        {
                                            if (data.hr_cancel_flag == '')
                                            {
                                                return '<center>Rejected</center>'
                                            }
                                            else
                                            {
                                                return '<center><button type="button" id=' + row_value + ' onclick="rowClick_approve(this)" class="authorize">Authorize</button></center>';
                                            }
                                        }
                                        else {
                                            return '<center><button type="button" id=' + row_value + ' onclick="rowClick_approve(this)" class="authorize">Authorize</button></center>';
                                        }

                                    }

                                }

                                else if (data.approved == "Y") {//
                                    return "<center style='color: green'>Authorized</center>";
                                }
                                else { return "<center style='color: blue'>Pending</center>"; }

                            }
                            else {
                                return "<center></center>";
                            }
                        }
                    },

                    // reject colum disable from HR as per their request: Closed by nitin on 22-02-2023
                    //{
                    //    "sTitle": "Reject", "mData": null, "bSortable": false, mRender: function (data) {

                    //        if ($('#drptype').val() == '') {
                    //            if (data.hr_cancel_flag == '') {
                    //                return "<center></center>";
                    //            }
                    //            else {
                    //                if (data.approved == 'Y') {
                    //                    var row_value = data.user_id + '_' + data.studio_code;
                    //                    return '<center><button type="button" id=' + row_value + ' class="reject" disabled>Reject</button></center>';

                    //                }
                    //                else if (data.hr_status == "" && data.inst_designation == 'VF' || data.inst_designation == 'temp') {

                    //                    var row_value = data.user_id + '_' + data.studio_code;
                    //                    return '<center><button type="button" id=' + row_value + ' class="reject">Reject</button></center>';
                    //                }
                    //                else if (data.hr_status == "R") {//
                    //                    return 'Rejected';
                    //                }
                    //                else {
                    //                    var row_value = data.user_id + '_' + data.studio_code;
                    //                    return '<center><button type="button" id=' + row_value + ' class="reject">Reject</button></center>';
                    //                }
                    //            }
                    //        }
                    //        else if ($('#drptype').val() != 'R') {
                    //            if (data.approved == 'Y') {
                    //                var row_value = data.user_id + '_' + data.studio_code;
                    //                return '<center><button type="button" id=' + row_value + ' class="reject" disabled>Reject</button></center>';

                    //            }
                    //            else if (data.hr_status == "" && data.inst_designation == 'VF' || data.inst_designation == 'temp') {

                    //                var row_value = data.user_id + '_' + data.studio_code;
                    //                return '<center><button type="button" id=' + row_value + ' class="reject">Reject</button></center>';
                    //            }
                    //            else if (data.hr_status == "R") {//
                    //                return 'Rejected';
                    //            }
                    //            else {
                    //                var row_value = data.user_id + '_' + data.studio_code;
                    //                return '<center><button type="button" id=' + row_value + ' class="reject">Reject</button></center>'; }
                    //        }
                    //        else { return ''; }

                    //    }
                    //},
                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {

                            if ($('#drptype').val() == '') {
                                if (data.cpop_user_status == 'Y') {
                                    if (data.hr_cancel_flag != '')
                                    {
                                        var row_value = data.user_id + '_' + data.studio_code;
                                        //if (data.hr_remark1 == "")
                                        //{
                                            return '<center><button type="button" id=' + row_value + ' class="sendmail">Remark</button></center>';
                                        //}
                                        //else { return ''; }
                                        
                                    }
                                    else { return ''; }
                                }
                                else { return ''; }

                            }
                            else { return ''; }

                        }
                    },

                    {
                        "sTitle": "Send Mail", "mData": null, "bSortable": false, mRender: function (data) {

                            
                            if (data.approved == 'Y' && data.mailsendstatus != 'Y')
                                { var row_value = data.user_id + '_' + data.studio_code;
                                  return '<center><button type="button" id=' + row_value + ' class="auth_sendmail">Send Mail</button></center>';
                                }
                                else
                                {
                                    return '';
                                }
                           

                        }
                    }




                    //{
                    //    "sTitle": "Edit Proposal", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if (data.is_submit == 'Y') {
                    //            return "<center>Submitted</center>";
                    //        }
                    //        else {

                    //            return '<center><button type="button" id=' + data.studio_code + ' onclick="rowClick_edit(this)">Edit</button></center>';
                    //        }
                    //    }
                    //},


                    //{
                    //    "sTitle": "Status", "bSortable": false, "mData": null, "mRender": function (data) {

                    //        if (data.studio_brief_status == 'Y') {
                    //            return "<center>Under Process</center>";
                    //        }
                    //        else if (data.studio_brief_status == 'A') {
                    //            return "<center>Submitted</center>";
                    //        }
                    //        else { return "<center></center>"; }
                    //    }
                    //}

                ],
                fnRowCallback: function (nRow, aData, iDisplayIndex, iDisplayIndexFull)
                {
                    if (aData.edit_workload == "Y") {
                        $('td', nRow).css('background-color', 'Orange');
                    }
                    else {
                        //$('td', nRow).css('background-color', 'C78D5D');
                    }
                },
            }).rowGrouping();

            //if (oTable != null) {
            //    oTable.fnDestroy();
            //    $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            //}
            //
            //oTable = $("#example").dataTable({
            //
            //    "bPaginate": false,
            //    "bSortable": false,
            //    "bSort": false,
            //    "iDisplayLength": 60,
            //    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            //    "aaData": JSON.parse(data),
            //    "aoColumns": columns
            //
            //});

            $('#DataList').css('display', 'block');
        }


        $(document).on("click", ".reject", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["user_id"];
            var instructor_name = aData["full_name"];
            var email = aData["mail"];
            var inst_designation = aData["inst_designation"];
            var cpop_user_flag = aData["cpop_user_status"];
            var details = aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_R';
            var remark_id = aData["user_id"] + '_' + aData["studio_code"];
            var reject_remark = $('#' + remark_id).val();
            var TA_user = aData["TA_user"];

            var remark_details = "";
            remark_details =
            {
                "instructor_code": aData["user_id"],
                "instructor_name": aData["full_name"],
                "email": aData["mail"],
                "inst_designation": aData["inst_designation"],
                "cpop_user_flag": aData["cpop_user_status"],
                "details": aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_R',
                "remark_id": aData["user_id"] + '_' + aData["studio_code"],
                "reject_remark": $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "rateband": aData["rate_band"],
            };


            if (reject_remark == "") {
                bootbox.alert('Please Enter Remark');
                $('#' + aData["studio_code"]).focus();
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
            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_studio_detail",

                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'',interested_remark_data: '" + json_submit_data + "'}",
                    // data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'" + reject_remark+"'}",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert('Studio Proposal Rejected Successfully');
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


            return false;
        });




        $(document).on("click", ".sendmail", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["user_id"];
            var instructor_name = aData["full_name"];
            var email = aData["mail"];
            var inst_designation = aData["inst_designation"];
            var cpop_user_flag = aData["cpop_user_status"];
            var details = aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_M';
            var remark_id = aData["user_id"] + '_' + aData["studio_code"];
            var reject_remark = $('#' + remark_id).val();
            var TA_user = aData["TA_user"];
            var remark_details = "";
            remark_details =
            {
                "instructor_code": aData["user_id"],
                "instructor_name": aData["full_name"],
                "email": aData["mail"],
                "inst_designation": aData["inst_designation"],
                "cpop_user_flag": aData["cpop_user_status"],
                "details": aData["user_id"] + '_' + aData["studio_code"] + '_' + inst_designation + '_' + cpop_user_flag + '_M',
                "remark_id": aData["user_id"] + '_' + aData["studio_code"],
                "reject_remark": $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "rateband": aData["rate_band"],
            };



            if (reject_remark == "") {
                bootbox.alert('Please Enter Remark');
                $('#' + aData["studio_code"]).focus();
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


            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_studio_detail",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + details.trim() + "',remark:'',interested_remark_data: '" + json_submit_data + "'}",
                    // data: "{interested_remark_data: '" + json_submit_data + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert('Remark Successfully');
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


            return false;
        });

        var entityMap = { "'": '&#39;' };
        //function rowClick_reject(row) {
        //    debugger;
        //    var status = 'R';
        //    var split_studiocode = row.id.split("_");
        //    var remark = $('#' + split_studiocode[1]).val();
        //    if (remark == "") {
        //        bootbox.alert('Please Enter Remark');
        //        $('#remark').focus();
        //        return false;
        //    }


        //    semester = $('#drpsemester').val();
        //    if (semester == "") {
        //        bootbox.alert('Please select semester');
        //        $('#drpsemester').focus();
        //        return false;
        //    }

        //    year_code = $('#drpyear').val();
        //    if (year_code == "") {
        //        bootbox.alert('Please select Year');
        //        $('#drpyear').focus();
        //        return false;
        //    }

        //    $.ajax(
        //        {
        //            type: "POST",
        //            contentType: "application/json; charset=utf-8",
        //            url: "../../WebService.asmx/insert_short_list_instractor",
        //            data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + row.id + "',remark:'" + remark + "',status:'" + status + "'}",
        //            dataType: "json",
        //            success: function (data) {
        //                if (data.d != "" && data.d != "[]") {
        //                    if (data.d == "true") {
        //                        bootbox.alert("Successfully Rejected");
        //                        get_studio_detail();
        //                    }
        //                }
        //                else {
        //                    bootbox.alert('Problem in Data');
        //                    return false;
        //                }
        //            },
        //            error: function (result) {
        //                alert(result);
        //            }
        //        });

        //}

        function downloadimage() {
            if (inst_profile_pic.length > 0 || $('#example tbody tr').length > 0)
            {
                var All_table_course_data = [inst_profile_pic];
                var json_All_table_course_data = JSON.stringify(All_table_course_data);

                if (json_All_table_course_data.search("'") != -1) {
                    json_All_table_course_data = json_All_table_course_data.replace(/\'/g, '\\\'');
                }
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/inst_pic_download",
                        data: "{'type':'image','json_All_table_course_data':'" + json_All_table_course_data + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                
                                if (data.d == "2")
                                {
                                    bootbox.alert("Profile Pic Not Found");
                                    return false;
                                }
                                else
                                {
                                    var origin = window.location.origin;
                                    window.open(origin + '/' + 'UserPersonalPhoto' + '/' + 'UserPersonalPhoto.zip'); return false;
                                }
                                return false;
                            }
                            else
                            {
                            bootbox.alert('No data found for selected criteria');
                            return false;
                        }
                        },
                error: function (result) {
                    alert(result);
                }
                    });

                   return false;
            }
            
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i><span id="title_name">VF Authorize Rate Band</span>
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <%--well--%>
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
                <a target="_blank" href="studio_proposal_authorize_tb.aspx" class="panel-headingfont" style="float: right;"><u>View as Without Tabular</u></a>
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
                                <td>Instructor Type
                                </td>
                                <td>
                                    <select class="chosen-select" id="instructortype">
                                        <option value="">--- Please Select Type ---</option>
                                        <option value="VF">VF</option>
                                        <option value="TA">Teaching Assistant</option>
                                        <option value="AA">Academic Associate</option>
                                        <option value="TEA">Teaching Associate </option>
                                        <option value="temp">Temp TA / Tutor</option>
                                        <option value="core">Core</option>
                                    </select>
                                </td>

                                <td id="type">Type :</td>
                                <td id="type_desc">
                                    <select class="chosen-select" id="drptype">
                                    </select>
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

                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btndownloadpic">Download Image</button>
                                </td>
                                <td></td>
                                <td></td>
                                <td></td>
                                  <td>
                                    <button class="btn btn-primary" id="btnsendmail" title="only Authorized Studio Send Mail" >Send Mail</button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_studio_proposal_dtl" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">VF Authorize Rate Band</strong>
            </div>
            <div id="DataList" style="display: none; overflow: auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        </div>
        <div id="ifrm_outline" style="display: none;"></div>
        <asp:HiddenField ID="hdn_file_name" runat="server" ClientIDMode="Static" />
        <asp:Button ID="btnDownloadcv" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadcv_Click" />
        <asp:Button ID="btnDownloadportfolio" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadportfolio_Click" />
        <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadExcelDocuments_Click" />
    </div>

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

