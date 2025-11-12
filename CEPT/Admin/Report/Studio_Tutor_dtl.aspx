<%@ Page Title="Studio Tutor Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Studio_Tutor_dtl.aspx.cs" Inherits="Admin_Report_Studio_Tutor_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
        <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            binddepartment();
            bindproglevel();
            bindleveldata();
            bindprogrammedata();
            bindtypedata();
            // bindfocuslevel();


            $('#btnreterive').on('click', function () {
                get_studio_dtl();
                return false;
            });

            $("#drlevel").change(function () {
                var values = $("#drlevel").val();
                if (values == 'L2') {
                    bindfocuslevel();
                }
                else {
                    $('#drpfocus').find('option').remove().end().append('<option value="">No Focus found</option>').val('');
                    $('#drpfocus').chosen();
                    $('#drpfocus').val('').trigger("liszt:updated");
                }

            });
           

        });

        function rowClick_view(row) {
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

        function rowClick_view_preview(row) {
            
            var res = row.id.split('_');
            semester = res[0];

            year_code = res[1];

            var course_code = res[2];
            
            $('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester + '&year_code=' + year_code + '&new_tab=Y" width="1" height="1"></iframe>');
        }

        function rowClick(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[5].childNodes[0].nodeValue;
            var pageURL = $(location).attr("href");
            pageURL = pageURL.replace("Report", "Master");
            pageURL = pageURL.replace("Studio_Tutor_dtl.aspx", "vf_edit_personal_detail.aspx?ic=" + rowId);
            window.open(pageURL, target = "_blank");
            // window.location = pageURL;
        }

        function app_rowClick(row) {
            var instructor_code = row.parentElement.parentElement.parentElement.childNodes[5].childNodes[0].nodeValue;
            var instructor_name = row.parentElement.parentElement.parentElement.childNodes[12].childNodes[0].nodeValue;

            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var r = confirm("Are you sure you want to approve instructor '" + instructor_name + "' ?");
            if (r == true) {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/approve_call_for_studio",
                    data: "{'instructor_code':'" + instructor_code + "','semester':'" + semester + "','year_code':'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "1") {

                                get_studio_dtl();

                                return false;
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                            }
                            return true;
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            else {

            }
            return false;

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

        $(document).on("click", "#weekly_download", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var weekly_excercises_path = aData["weekly_excercises_path"];
            $('#hdn_weekly_file_name').val(weekly_excercises_path);
            $("#btnDownloadweekly").click();
            return false;
        });



        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var level_code = '';
        var focus_code = '';
        var oTable;


        $(document).on("click", ".pdf_download", function (event) {
             
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var weekly_excercises_path = aData["weekly_excercises_path"];
            var instructor_code = aData["instructor_code"];
            var instructor_name = aData["instructor_name"];
            var cv_file_name = aData["cv_file_name"];
            var portfolio_file_name = aData["portfolio_file_name"];
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
                        if (data.d == "1")
                        {
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


        function get_studio_dtl() {
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

            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();
            var level_code = $('#drlevel').val();
            var focus_code = $('#drpfocus').val();
            var type_code = $('#drptype').val();
            if (type_code == '-')
            {
                type_code = '';
            }


            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_studio_dtl",
                    //async: false,
                    data: "{semester:'" + semester + "',year:'" + year_code + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',level_code:'" + level_code + "',focus_code:'" + focus_code + "',type:'" + type_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            
                            display_studio_detail(data.d);

                            $('#div_studio_list').css('display', 'inline-block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function set_table_columns(row) {
            var columns = [];

            
         /*   columns.push({ "sTitle": "Instructor Code", "mData": "instructor_code", "sClass": "cls_hide" });*/
            columns.push({ "sTitle": "studio code ", "mData": "studio_code" });
            columns.push({ "sTitle": "Instructor Name", "mData": "instructor_name" });

            columns.push({
                "sTitle": "Email Id", "mData": null, "sClass": "cls_action", mRender: function (data) {


                    if (data.mail != null) {
                        return data.mail;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Cotutor Name", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.co_tutor_type != null) {
                        return data.co_tutor_type;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Single/Dual Tutor", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.no_of_tutor != null) {
                        return data.no_of_tutor;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Tutor Type", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.new_tutor_type != '')
                    {
                        if (data.new_tutor_type == 'CT')
                        {
                            return 'Co Tutor';
                        }
                        else { return 'Lead Tutor';}
                        
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Total years of experience", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.total_experiance != null) {
                        return data.total_experiance;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Highest qualification", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.highest_qualification != null) {
                        return data.highest_qualification;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Designation", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.work_designation != null) {
                        return data.work_designation;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Current Organization", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.work_institute != null) {
                        return data.work_institute;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Faculty", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.dept_name != null) {
                        return data.dept_name;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Program", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.prog_level_name != null) {
                        return data.prog_level_name;
                    }
                    return '';

                }
            });
            columns.push({ "sTitle": "Studio Level", "mData": "studio_level" });
            columns.push({
                "sTitle": "Focus Studio", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.focus_studio != null) {
                        return data.focus_studio;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Secondary Focus Studio", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.secondary_focus_studio != null) {
                        return data.secondary_focus_studio;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Mode", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.mode != null) {
                        return data.mode;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Title", "mData": null, "sClass": "cls_action", mRender: function (data) {
                    //
                    if (data.studio_title != null) {
                        return data.studio_title;
                    }
                    return '';

                }
            });

            columns.push({
                "sTitle": "Studio SubTitle", "mData": null, "sClass": "cls_action", mRender: function (data) {
                    //
                    if (data.studio_subtitle != null) {
                        return data.studio_subtitle;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Studio Description", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.studio_description != "") {
                        // return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                        return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
                    }
                    else return '';
                }
            });
            
            columns.push({ "sTitle": "Contact", "mData": "mobile_no" });
            columns.push({
                "sTitle": "Location", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.city != null) {
                        return data.city;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "CV", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data['cv_file_name'] != '') {
                        // return 'Y';
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + data['cv_file_name'] + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            });
            //columns.push({
            //    "sTitle": "Portfolio Status", "mData": null, "sClass": "cls_action", mRender: function (data) {
            //        if (data['portfolio_file_name'] != '') {
            //            return 'Y';
            //        }
            //        return '';

            //    }
            //});
            columns.push({
                "sTitle": "Proposal", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data['ppt_video'] != '') {
                        // return 'Y';
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_proposal_download(this)" id=' + data['ppt_video'] + ' class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            });
            columns.push({

                "sTitle": "Portfolio", "mData": null, "sClass": "cls_action", mRender: function (data) {
                    
                    if (data['portfolio_file_name'] != '') {
                        // return 'Y';
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_portfolio_download(this)" id=' + data['portfolio_file_name'] + ' class="portfolio_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            });

            columns.push({

                "sTitle": "Weekly Excercises", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data['weekly_excercises_path'] != '')
                    {
                        return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_weekly_download(this)" id="weekly_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return '';

                }
            });

            columns.push({
                "sTitle": "Download ALL", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

                }
            });
            columns.push({
                "sTitle": "Brief View", "mData": null, "sClass": "cls_action", mRender: function (data)
                {

                    if (data.course_code != "") {
                        return '<center><button type="button" id=' + data.course_code + ' onclick="rowClick_view(this)">View</button></center>';
                    }
                    return '';
                    

                }
            });
            columns.push({
                "sTitle": "Previous Semester", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.previous_sem_code == "S") {
                        return 'Spring';
                    }
                    else if (data.previous_sem_code == "M") {
                        return 'Monsoon';
                    }
                    else { return '';}
                    


                }
            });

            columns.push({
                "sTitle": "Previous Year", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.previous_year_code != "") {
                        return data.previous_year_code;
                    }
                    else { return ''; }



                }
            });

            columns.push({
                "sTitle": "Previous Semester Course Code", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.previous_sem_course_code != "") {
                        return data.previous_sem_course_code;
                    }
                    else { return ''; }



                }
            });

            columns.push({
                "sTitle": "Course Code", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.course_code != "") {
                        return data.course_code;
                    }
                    else { return ''; }



                }
            });

            columns.push({
                "sTitle": "New Course Code", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.new_course_code != "") {
                        return data.new_course_code;
                    }
                    else { return ''; }



                }
            });

            columns.push({
                "sTitle": "PC Remrk", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.pc_remark != null) {
                        return data.pc_remark;
                    }
                    return '';

                }
            });

            columns.push({
                "sTitle": "HR Remrk", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.hr_remark != null) {
                        return data.hr_remark;
                    }
                    return '';

                }
            });


            columns.push({
                "sTitle": "Previous Semester Brief View", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.previous_sem_course_code != "") {
                        var row_dtl = data.previous_sem_code + '_' + data.previous_year_code + '_' + data.previous_sem_course_code;
                        return '<center><button type="button" id=' + row_dtl + ' onclick="rowClick_view_preview(this)">View</button></center>';
                    }

                    else {
                        return "";
                    }

                }
            });

            columns.push({
                "sTitle": "Dean/PC Shortlist", "bSortable": false, "mData": null, "mRender": function (data) {

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

                   else if (data.iwss_Status == 'A')
                    {
                        return "<center style='color: green'>Shortlisted</center>";
                    }
                    else
                    {
                        return "<center style='color: blue'>Pending</center>";
                    }
                }
            });

            columns.push({
                "sTitle": "Personal Detail Submit", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.im_admin_approved == "Y") {
                        return "<center style='color: green'>Submitted</center>";
                    }
                    else { return "<center style='color: blue'>Pending</center>"; }
                }
            });
            //columns.push({
            //    "sTitle": "Rateband Submit", "mData": null, "bSortable": false, mRender: function (data) {
            //        if (data.im_rateband_approved == "Y") {
            //            return "<center style='color: green'>Submitted</center>";
            //        }
            //        else { return "<center style='color: blue'>Pending</center>"; }
            //    }
            //});
            //columns.push( {
            //    "sTitle": "Workload Submit", "mData": null, "bSortable": false, mRender: function (data) {
            //        if (data.iwd_admin_approved == "Y") {

            //            return "<center style='color: green'>Submitted</center>";
            //        }
            //        else { return "<center style='color: blue'>Pending</center>"; }
            //    }
            //});
            columns.push( {
                "sTitle": "Dean/PC Authorized", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.iwd_hr_approved == "Y") {
                        return "<center style='color: green'>Authorized</center>";
                    }
                    else { return "<center style='color: blue'>Pending</center>"; }
                }
            });

            columns.push( {
                "sTitle": "HR Authorized", "bSortable": false, "mData": null, "mRender": function (data) {

                    if (data.approved == 'Y') {
                        return "<center style='color: green'>Authorized</center>";
                    }
                    else { return "<center style='color: blue'>Pending</center>"; }
                }
            });
            columns.push({
                "sTitle": "Personal Details", "mData": null, "bSortable": false, mRender: function (data) {

                    var row_value = data.instructor_code;
                    if ($('#hdnusertype').val() == 'FA') {
                        return '<center><button type="button" id=' + row_value + ' onclick="rowClick_edit(this)" class="per_edit">Edit</button></center>';
                    }
                    else {
                        return '';
                    }
                    

                }
            });








            columns.push({ "sTitle": "Created Date", "mData": "created_date" });
            columns.push({
                "sTitle": "Last Modified Data", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    if (data.last_modified_date != null) {
                        return data.last_modified_date;
                    }
                    return '';

                }
            });
            //return '<center><button type="button" id=' + row_value + ' onclick="rowClick_approve(this)"> ShortList</button></center>';
           

            columns.push({
                "sTitle": "Mail Status", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    var studio_code_inst = data.instructor_code + '_' + data.studio_code + '_' + data.new_tutor_type;
                    if (data.iwss_Status == 'A' && data.approved == 'Y') {
                        if ($('#hdnuserid').val() == 'admin.asc@cept.ac.in') {
                            if ($('#drptype').val() == 'SPC') {
                                if (data.mailstatus == 'N') {
                                    return '<center><button type="button" id=' + studio_code_inst + ' onclick="rowClick_mailsend(this)"> SendMail</button></center>';
                                }
                                return data.mailstatus;
                            }
                            else { return ''; }
                        }
                        else { return ''; }
                    }
                    else { return '';}
                    
                    
                    

                }
            });



            //columns.push({ "sTitle": "CV File Name", "mData": "cv_file_name", "sClass": "cls_hide" });
            //columns.push({ "sTitle": "Portfolio File Name", "mData": "portfolio_file_name", "sClass": "cls_hide" });
            //columns.push({ "sTitle": "PPT File Name", "mData": "ppt_video", "sClass": "cls_hide" });
            //columns.push({ "sTitle": "Studio File Name", "mData": "studio_brief", "sClass": "cls_hide" });

            return columns;
        }

        function display_studio_detail(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

            if ($('#drptype').val() == '-') {
                var data_save = JSON.parse(data);
                var result = alasql('SELECT * FROM ? WHERE studio_code = ?', [data_save, '']);
                data = result;
            }
            else { data = JSON.parse(data);}

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"oTableTools": {
                //    "aButtons": [
                //        //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ] 
                //},

                "aaData": data,

                "aoColumns": columns

            }).rowGrouping();

            $('#DataList').css('display', 'block');

            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
           // $('#example thead tr')[0].children[24].style.display = 'none';
           // $('#example thead tr')[0].children[25].style.display = 'none';
           // $('#example thead tr')[0].children[26].style.display = 'none';
           // $('#example thead tr')[0].children[27].style.display = 'none';
           // $('#example thead tr')[0].children[28].style.display = 'none';
           // 
           // $("#example tbody tr").each(function (i) {
           //     $('#example tbody tr')[i].children[24].style.display = 'none';
           //     $('#example tbody tr')[i].children[25].style.display = 'none';
           //     $('#example tbody tr')[i].children[26].style.display = 'none';
           //     $('#example tbody tr')[i].children[27].style.display = 'none';
           //     $('#example tbody tr')[i].children[28].style.display = 'none';
           //     //$(this).children().eq(0)[0].style.display = 'none';
           //     //$(this).children().eq(0)[1].style.display = 'none';
           //     //$(this).children().eq(0)[2].style.display = 'none';
           //     //$(this).children().eq(0)[3].style.display = 'none';
           // 
           // });
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
            //bindfocuslevel();
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
        function bindfocuslevel() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_focus_of_studio",
                data: "{focus_studio_level :'L2'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var focus_data = JSON.parse(data.d);

                        $('#drpfocus').empty().append($("<option></option>").val("").html("-- Please Select Focus --"));

                        for (var i = 0; i < focus_data.length; i++) {
                            $('#drpfocus').append($("<option></option>").val(focus_data[i]["focus_area_code"]).html(focus_data[i]["focus_area_name"]));
                        }
                        $('#drpfocus').chosen();
                        $('#drpfocus').trigger("liszt:updated");

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("-").html("Studio proposal Saved"));
            $('#drptype').append($("<option></option>").val("P").html("Studio Proposal Submitted"));
            $('#drptype').append($("<option></option>").val("PC").html("Studio Proposal Rejected By PC"));
            $('#drptype').append($("<option></option>").val("SPC").html("Studio Proposal ShortList By PC"));
            $('#drptype').append($("<option></option>").val("HR").html("Studio Proposal Rejected By HR"));
            $('#drptype').append($("<option></option>").val("Y").html("Studio Brief Submitted"));
            $('#drptype').append($("<option></option>").val("S").html("Studio Brief Saved"));

            $('#drptype').chosen();

        }
        //$(document).on("click", ".cv_download", function (event) {
        //    debugger;
        //    var row = $(this).closest("tr").get(0);
        //    var aData = oTable.fnGetData(row);

        //    var instructor_code = aData["instructor_code"];
        //    var instructor_name = aData["instructor_name"];
        //    var cv_file_name = aData["cv_file_name"];
        //    var portfolio_file_name = aData["portfolio_file_name"];
        //    var ppt_video = aData["ppt_video"];
        //    var studio_brief = aData["studio_brief"];
        //    var semester = $('#drpsemester').val();
        //    var year_code = $('#drpyear').val();
        //    var dep_name = "";

        //    if (semester == 'S') {
        //        semester = 'Spring';
        //    }
        //    else {
        //        semester = 'Monsoon';
        //    }

        //    //$.ajax({
        //    //    type: "POST",
        //    //    contentType: "application/json; charset=utf-8",
        //    //    url: "../../WebService.asmx/Download_Document",
        //    //    data: "{'instructor_code':'" + instructor_code + "','cv_file_name':'" + cv_file_name + "','portfolio_file_name':'" + portfolio_file_name + "','ppt_video':'" + ppt_video + "','studio_brief':'" + studio_brief + "'}",
        //    //    dataType: "json",
        //    //    success: function (data) {
        //    //        if (data.d != "") {
        //    //            if (data.d == "1") {
        //    //                $("#btnDownloadExcelDocuments").click();
        //    //                return false;
        //    //            }
        //    //            else {
        //    //                bootbox.alert('Document Not Found');
        //    //            }
        //    //            return true;
        //    //        }
        //    //        else {
        //    //            bootbox.alert('Document Not Found');
        //    //        }
        //    //    },
        //    //    error: function (result) {
        //    //        alert(result);
        //    //    }
        //    //});
        //    return false;
        //});



        $(document).on("click", ".cv_download", function (event) {
            
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var cv_file_name = aData["cv_file_name"];
            $('#hdn_file_name').val(cv_file_name);
            $("#btnDownloadvideo_cv").click();
            return false;
        });


        //function rowClick_cv_download(row) {
        //    debugger;
        //    var rows = $(this).closest("tr").get(0);
        //    var aData = oTable.fnGetData(rows);
        //    $('#hdn_file_name').val(row.id);
        //    $("#btnDownloadvideo_cv").click();
        //}

        $(document).on("click", ".proposal_download", function (event) {
           
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            //var portfolio_file_name = aData["portfolio_file_name"];
             var ppt_video = aData["ppt_video"];
            $('#hdn_file_name').val(ppt_video);
            $("#btnDownloadvideo_pro").click();
            return false;
        });
        $(document).on("click", ".portfolio_download", function (event) {
        
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var portfolio_file_name = aData["portfolio_file_name"];
             //var ppt_video = aData["ppt_video"];
            $('#hdn_file_name').val(portfolio_file_name);
            $("#btnDownloadvideo").click();
            return false;
        });
        //function rowClick_proposal_download(row) {
        //    $('#hdn_file_name').val(row.id);
        //    $("#btnDownloadvideo_pro").click();
        //}
        //function rowClick_portfolio_download(row) {

        //    $('#hdn_file_name').val(row.id);
        //    $("#btnDownloadvideo").click();
        //}
        function rowClick_edit(row) {
            var path = window.location.origin;
            window.open(path + '/Admin/Master/vf_edit_personal_detail.aspx?ic=' + row.id, "_blank");
            //var url = "Admin/Master/vf_edit_personal_detail.aspx?ic=" + row.id ;
           // window.open(url, "_blank");
        }

        function rowClick_mailsend(row) {
            
            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/insert_short_list_mail",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + row.id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Mail Send Successfully");

                                //bootbox.alert("Successfully ShortListed Instructor");
                            }
                            else if (data.d == "false") {
                                bootbox.alert("Mail Not Send ");
                            }
                            else { bootbox.alert(data.d);}
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
       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Studio Proposal Report
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
                                <td>Level :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drlevel">
                                    </select>
                                </td>
                                <td>Focus :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpfocus">
                                    </select>
                                </td>
                                   </tr>
                            <tr>
                                <td>Type :
                                </td>
                                <td>
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

        
    </div>

    <div id="div_studio_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Studio Proposal Report</strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow: auto">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>

    <asp:HiddenField ID="exDocuments" runat="server" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadExcelDocuments_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadvideo_cv" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadvideo_cv_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadvideo_pro" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadvideo_pro_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadvideo" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadvideo_Click" ClientIDMode="Static" />
     <asp:Button ID="btnDownloadweekly" runat="server" Text="Button" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadweekly_Click"/>
    <asp:HiddenField ID="hdn_file_name" runat="server" ClientIDMode="Static" />
    <div id="ifrm_outline" style="display: none;"></div>
    <asp:HiddenField ID="hdn_weekly_file_name" runat="server" ClientIDMode="Static" />

    <style>
        body {
            overflow: auto;
        }
        #main-container {
            padding: 10px;
            width:max-content;
        }
    </style>

</asp:Content>

