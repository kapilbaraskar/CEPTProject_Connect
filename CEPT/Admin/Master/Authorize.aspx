<%@ Page Title="Authorization Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Authorize.aspx.cs" Inherits="Admin_Master_Authorize" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Authorization Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div>
	<p><b style="color:blue;"> Note:</b> For View the status of Tutors of <b>NOT Published Course/Studios</b>, Please select the filter criteria : <b>Semester, Year and Publish Status only.</b></p><br>
	</div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year of allocation 
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                            </tr>
                            <tr class="cls_dept_prog" style="display: none;">
                                <td>Department
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                            </tr>
                            <tr>
                                <td>Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
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
                                        <option value="Temp">Temp </option>
                                    </select>
                                </td>

                                <td>Publish Status
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpcourse_type">
                                        <option value="">--- Please Select Type ---</option>
                                        <option value="N">Not Published Course</option>
                                        <option value="">Published</option>
                                    </select>
                                </td>
                                </tr>
                            <tr>
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
                            </tr>
                         <%--   <tr>
                                <td colspan="5">
                                    <input type="checkbox" class="check_img" value="1" id="VF_img" /> VF Image 
                                &nbsp;&nbsp;<input type="checkbox" class="check_img" value="2" id="TA_img"  /> TA Image 
                                &nbsp;&nbsp;<input type="checkbox" class="check_img" value="3" id="AA_img" /> AA Image 
                                </td>
                            </tr>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Authorize Report</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none; overflow: auto;">
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
        <div id="submitBtnDiv" style="text-align: center; margin: 10px; display: none;">
            <input type="button" id="btn_authorize" value="Authorize" class="btn btn-primary" />
        </div>
        <div style="display: none;">
            <input type="hidden" id="hdn_instructor" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_instructor_name" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_All_instructor" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_dept" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
            <asp:Button ID="hdn_print_letter" runat="server" ClientIDMode="Static" OnClick="Btn_Print_Letter_Click" />
        </div>
    </div>
    <script type="text/javascript">
        var oTable;
        var course_detail;
        var rate_band;
        var workload_detail;
        var action = 'S';
        var inst_profile_pic = [];
        var inst_profile_name_ = [];
        

        $(document).ready(function () {

            bindsemdata();
            bindyeardata_for_cross_reg();
            bindprogramme();
            bindproglevel();

            //if ($('#hdnusertype').val() == 'AC') {
                binddepartment();
            //}

            $('#btnreterive').on('click', function () {
                get_authorize_detail();
                return false;
            });

            setCurrentSemester();
            $('#btndownloadpic').on('click', function () {
                downloadimage();
                return false;
            });
        });

        function downloadimage()
        {
            if (inst_profile_pic.length > 0 || $('#example tbody tr').length > 0) {
                //var All_table_course_data = [inst_profile_pic];
                var All_table_course_data = [inst_profile_pic, inst_profile_name_];
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

                            if (data.d == "2") {
                                bootbox.alert("Profile Pic Not Found");
                                return false;
                            }
                            else {
                                var origin = window.location.origin;
                                //window.open(origin + '/' + 'UserPersonalPhoto' + '/' + 'UserPersonalPhoto.zip'); return false;
                                //window.open(origin + '/' + 'UserPersonalPhoto' + '/' + 'UserPersonalPhoto.zip'); return false;
                                window.open(origin + '/' + 'Image_Rename' + '/' + 'UserPersonalPhoto.zip'); return false;
                            }
                            return false;
                        }
                        else {
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


        function bindproglevel() {

            //    $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            //    $('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
            //    $('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }

                        // if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                        $('#drpproglevel').chosen();
                        //  }

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

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

        function bindprogramme() {

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
            else if ($('#hdnusertype').val() == 'PC') {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_programme_coordinator_dtl",
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
                                //$('#drpprog').val(user_data[0]['prog_code']);
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

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            if ($('#hdnusertype').val() == 'AC') {
                                get_acuser_detail();
                            }

                            $('#btnreterive').click();
                        }
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
                async: false,
                success: function (data) {
                    if (data.d != "") {

                        var sem_data = JSON.parse(data.d)
                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }
                        $('.cls_dept_prog').css('display', '');
                        $('#drpdepartment').chosen();

                        get_acuser_detail();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var dept_options = [];
        function get_acuser_detail() {
            if ($('#hdnusertype').val() == 'AC') {

                dept_options = $('#drpdepartment').children();

                semester = $('#drpsemester').val();

                year_code = $('#drpyear').val();

                if (semester == "" || year_code == "") {
                    return false;
                }

                $('#drpdepartment').html('');
                $('#drpdepartment').append(dept_options[0]);
                $('#drpdepartment').trigger("liszt:updated");

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_semyearwise_department_user_dtl",
                        async: false,
                        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                for (var i = 0; i < user_data.length; i++) {
                                    for (var j = 0; j < dept_options.length; j++) {
                                        if (user_data[i]['dept_code'] == dept_options[j].value) {
                                            $('#drpdepartment').append(dept_options[j]);
                                        }
                                    }

                                }

                                $('#drpdepartment').val('');

                                $('#drpdepartment').trigger("liszt:updated");
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
        }

        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var prog_level_code = '';

        function get_authorize_detail() {
            $('#DataList').css('display', 'none');
            $('#div_btn').html('');
            $('#submitBtnDiv').css('display', 'none');

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

            dept_code = '';
            if ($('#drpdepartment').val() != "") {
                dept_code = $('#drpdepartment').val();
            }

            prog_code = $('#drpprog').val();
            prog_level_code = $('#drpproglevel').val();
            var course_type = $('#drpcourse_type').val();

            var instructor_type = $('#instructortype').val();

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_authorize_detail_new",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code:'" + prog_level_code + "',instructor_type:'" + instructor_type + "',type:'',course_type:'" + course_type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            inst_profile_pic = [];
                            inst_profile_name = [];
                            inst_profile_name_ = [];
                            var remove_duplicate = [];
                            workload_detail = JSON.parse(data.d);

                            display_get_vf_personal_detail(data.d);
                            var json_data = JSON.parse(data.d);
                            for (var i = 0; i < json_data.length; i++) {
                                var inst_code_name = 'profile_' + json_data[i]['instructor_name'].trim() + '_' + json_data[i]['instructor_code'] + '.jpg';
                                var pic_name = 'profile_' + json_data[i]['instructor_code'] + '.jpg';
                                remove_duplicate.push(pic_name.trim());
                                inst_profile_name.push(inst_code_name.trim());

                            }

                            for (var i = 0, l = remove_duplicate.length; i < l; i++) {
                                if (inst_profile_pic.indexOf(remove_duplicate[i]) === -1 && remove_duplicate[i] !== '') {
                                    inst_profile_pic.push(remove_duplicate[i]);
                                    inst_profile_name_.push(inst_profile_name[i]);
                                }
                            }


                            $('#div_course_list').css('display', 'block');
                            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';

                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            if ($('#hdnusertype').val() != 'PC') {
                                $('#div_course_list').css('display', 'none');
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }


        function display_get_vf_personal_detail(data) {

            //var columns = set_table_columns(JSON.parse(data)[0]);

            var columns = [

                {
                    
                    "sTitle": "Select", "mData": null, "bSortable": false, mRender: function (ddata) {
                        if ($('#hdnusertype').val() != 'HR')
                        {
                            if (ddata.workload_approved == 'Y' && ddata.rateband_approved == 'Y' && ddata.personal_dtl_approved == 'Y')
                            {
                                if (ddata.hr_approved == 'Y')
                                {
                                    return "";
                                }
                                else
                                {
                                    var new_id = ddata.instructor_code + '@@' + ddata.course_code;
                                    return '<input type="checkbox" id=' + new_id +' class="chk_course" />';
                                }
                            }
                            else { return ""; }
                        }
                        else { return ""; }
                    }
                },
                {
                "sTitle": "Type", "mData": "designation", "bSortable": false, fnRender: function (ddata) {
                   
                    if (ddata.aData.designation_letter == 'TEA') return "Teaching Associate";
                    else if (ddata.aData.designation == 'VF') return ddata.aData.designation;
                    else if (ddata.aData.designation == 'TA') return "Teaching Assistant";
                    else if (ddata.aData.designation == 'AA') return "Academic Associate";
                    else return "";
                }
            },
                { "sTitle": "VF Code", "mData": "VF_code" },
                { "sTitle": "Instructor Code", "mData": "instructor_code" },
            //{ "sTitle": "Instructor Name", "mData": "instructor_name" },
            {
                "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false, fnRender: function (ddata) {
                    if (ddata.aData.is_tutorial == 'Y') return ddata.aData.instructor_name + ' (T)';
                    else return ddata.aData.instructor_name;
                }
            },
                {
                    "sTitle": "Highest Qualification", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.highest_qualification == '') {
                            return '';
                        }
                        else return data.highest_qualification;
                    }
                },
                {
                    "sTitle": "Nationality", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.country == '') {
                            return '';
                        }
                        else return data.country;
                    }
                },
                { "sTitle": "Date of Birth", "mData": "dob" },
                { "sTitle": "Blood Group", "mData": "blood_group" },
                {
                    "sTitle": "Address", "mData": null, "bSortable": false, mRender: function (data) {

                        
                        var row_value = data.address;
                      
                        if (row_value != '') {
                            var split_data = row_value.split('@#');
                            if (split_data != undefined)
                            {
                                row_value = split_data[0].replace('@#', ' ');
                                row_value = row_value.replace('@c#', ' ');
                                row_value = row_value.replace('#', ' ');

                            } else
                            {
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
                        }
                        else {
                            return "";
                        }


                    }
                },
                { "sTitle": "Mobile No", "mData": "mobile_no" },
                { "sTitle": "Emergency Contact Number", "mData": "emergency_contact_number" },

                {
                    "sTitle": "Total years of Experience", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.total_experiance == '') {
                            return '';
                        }
                        else return data.total_experiance;
                    }
                },
                //{
                //    "sTitle": "Total Month of Experience", "mData": null, "bSortable": false, mRender: function (data)
                //    {
                //        if (data.total_experiance_months == '') {
                //            return '';
                //        }
                //        else return data.total_experiance_months;
                //    }
                //},
                //{
                //    "sTitle": "Total Experience Month ", "mData": null, "bSortable": false, mRender: function (data) {
                //        if (data.total_experiance != '') {
                //            if (data.total_experiance_months != '') {
                //                return parseInt(parseInt(data.total_experiance * 12) + parseInt(data.total_experiance_months));
                //            }
                //            else
                //            {
                //                return parseInt(parseInt(data.total_experiance * 12));
                //            }
                //            
                //        }
                //        else return data.total_experiance_months;
                //    }
                //},
                {
                    "sTitle": "Highest Qualification Completion Year", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.year_of_completion == '') {
                            return '';
                        }
                        else return data.year_of_completion;
                    }
                },

                {
                    "sTitle": "Aadhar No", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.aadhaar_no == '') {
                            return '';
                        }
                        else return data.aadhaar_no;
                    }
                },
                {
                    "sTitle": "Passport No", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.passport_no == '') {
                            return '';
                        }
                        else return data.passport_no;
                    }
                },
                {
                    "sTitle": "PAN Card No", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.pan_card_no == '') {
                            return '';
                        }
                        else return data.pan_card_no;
                    }
                },

                {
                    "sTitle": "CV", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.cv_file_name == '') {
                            return '';
                        }
                        else return '<center><a href="#" style="text-decoration:none;" class="pdf_download" id="' + data.cv_file_name +'" title="Download PDF"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
                    }
                },
                {
                    "sTitle": "Portfolio", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.portfolio_file_name == '') {
                            return '';
                        }
                        else return '<center><a href="#" style="text-decoration:none;" class="port_download" id="' + data.portfolio_file_name + '" title="Download PDF"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
                    }
                },
                {
                    "sTitle": "Image", "mData": null, "sClass": "cls_action", mRender: function (data)
                    {
                        if (data.profile_photo != "")
                        {
                            
                            return '<center><a href="#" style="text-decoration:none;" class="imag_download" id="' + data.profile_photo + '" title="Download Image"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
                        }
                        return "";

                    }
                },
                {
                    "sTitle": "Personal Document", "mData": null, "sClass": "cls_action", mRender: function (data) {

                        return '<center><a href="#" style="text-decoration:none;" class="pdf_download_doc" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

                    }
                },
            { "sTitle": "Course Code", "mData": "course_code" },
            {
                "sTitle": "Contact hrs", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.total_contact_hrs) {
                        return parseFloat(data.total_contact_hrs).toFixed(2);
                    }
                    else return '';
                }
            },
            //{ "sTitle": "Preparatory hrs", "mData": null, "bSortable": false, fnRender: function (data) {
            //    if (data.aData.total_preparation_hrs != '') {
            //        return parseFloat(data.aData.total_preparation_hrs).toFixed(2);
            //    }
            //    else return '';
            //}
            //},
            { "sTitle": "Total Weeks", "mData": "total_weeks" },
            { "sTitle": "Additional Hours", "mData": "additional_hours" },
            { "sTitle": "Pay Band", "mData": "rate_band" },
            { "sTitle": "Total Amount Paid", "mData": "total_amount_paid" },
            //{ "sTitle": "Justification", "mData": "justification" },
            {
                "sTitle": "Justification", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.justification == '') {
                        return 'NA';
                    }
                    else return data.justification;
                }
            },
            {
                "sTitle": "Personal Detail Submit", "mData": null, "bSortable": false, mRender: function (data)
                {
                    
                    
                    //if (data.designation == 'VF' && data.user_type == 'I2'  && data.per_doc != '' && data.course_typology == '24')
                    //{
                    //    return 'Submitted';
                    //}
                    //changes by nitinbhai 08012024

                    //changes by nitinbhai 13022024 Change TA VF AA TEmp Personal Details Status

                    if (data.personal_details_status == 'true' && data.designation == 'TA') {
                        return 'Submitted';
                    }
                    else if (data.personal_details_status == 'true' && data.designation == 'VF') {
                        return 'Submitted';
                    }
                    else if (data.personal_details_status == 'true' && data.designation == 'AA') {
                        return 'Submitted';
                    }
                    //else if (data.personal_dtl_approved == 'Y' && data.designation == 'AA') {
                    //    return 'Submitted';
                    //}

                    else if (data.personal_details_status == 'true' && data.designation == 'temp') {
                        return 'Submitted';
                    }
                    //else if (data.personal_dtl_approved == 'Y' && data.course_typology != '24')
                    //{
                    //    //return 'Approved';
                    //    return 'Submitted';
                    //}


                    //if (data.designation == 'TA' && data.user_type == 'I2' && data.per_doc != '' && data.course_typology == '24') {
                    //    return 'Submitted';
                    //}
                    else return '';
                }
            },
            //{
            //    "sTitle": "Rateband Submit", "mData": null, "bSortable": false, mRender: function (data) {
            //        if (data.rateband_approved == 'Y') {
            //            //return 'Approved';
            //            return 'Submitted';
            //        }
            //        else return '';
            //    }
            //}, //Nitinbhai 08112023
            {
                "sTitle": "Workload Submit", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.workload_approved == 'Y') {
                        //return 'Approved';
                        return 'Submitted';
                    }
                    else return '';
                }
            },
            {
                "sTitle": "Dean/PC Authorized", "mData": null, "bSortable": false, mRender: function (data) {
                    
                    if (data.instructor_code == 'I2223002979') {
                        var ss = "";

                    }
                    if (data.hr_approved == 'Y') {
                        return 'Authorized';
                    }
                    else return '';
                }
                },
                {
                    "sTitle": "Personal Details", "mData": null, "bSortable": false, mRender: function (data) {
                       // debugger;
                        var row_value = data.instructor_code;
                        var course_code = data.course_code;
                        
                        if (data.designation == 'VF' && data.user_type == 'I2' && data.course_typology == '24')
                        {
                            return '<center><button type="button" id=' + row_value + ' data-coursecode=' + course_code + ' onclick="rowClick_edit(this)" class="per_edit">Edit</button></center>';
                        }
                        if (data.designation == 'VF' && data.user_type == 'I2' && data.course_typology == '23' && data.dept_name == 'CEPT Foundation Program') {
                            return '<center><button type="button" id=' + row_value + ' data-coursecode=' + course_code + ' onclick="rowClick_edit(this)" class="per_edit">Edit</button></center>';
                        }
                        else
                        {
                            return '<center><button type="button" id=' + row_value + ' data-coursecode=' + course_code + ' onclick="rowClick_edit_new(this)" class="per_edit">Edit</button></center>';
                        }
                        

                    }
                }
                //                            { "sTitle": "Acceptance", "mData": null, "bSortable": false, fnRender: function (data) {
                //                                if (data.aData.acceptance == 'Y') {
                //                                    return 'Accepted';
                //                                }
                //                                else return '';
                //                            }
                //                            },
                //                            { "sTitle": "Acceptance Justification", "mData": "acceptance_justification" }
            ];

            if ($('#hdnusertype').val() == 'HR')
            {
                columns.push({
                    "sTitle": "HR Authorized", "mData": null, "bSortable": false, mRender: function (data)
                    {
                        //if (data.designation == 'VF')
                        //{
                        //    if (data.hr_approved == 'Y')
                        //    {
                        //        return "Authorized (VF)";
                        //    } else
                        //    {
                        //        return "";
                        //    }
                        //}
                        //else if (data.uso_hr_approved == 'Y')
                        //{
                        //    return "Authorized";
                        //}
                        //else if (data.uso_hr_approved != 'Y' && data.hr_approved == 'Y')
                        //{
                        //    return "<center><button type='button' onclick='rowClick_Hr_Authorized(this)' class='cls_btn_pdf btn btn-primary btn-small'>Authorize</button></center>";
                        //}
                        //else return "";
                        
                        if (data.personal_dtl_approved != 'Y')
                        {
                            return " Personal Details Not Submitted ";
                        }
                        else if (data.rateband_approved != 'Y') {
                            return " Rateband Not Submitted ";
                        }
                        else if (data.workload_approved != 'Y') {
                            return " FA Not Submitted RateBand";
                        }
                       else if (data.hr_approved != 'Y')
                        {
                            return " PC Dean Not Authorized RateBand ";
                        }
                        else if (data.uso_hr_approved != 'Y')
                        {
                             // Removed Authorized button from report as on 22-02-2023
                            return "";
                            //return "<center><button type='button' onclick='rowClick_Hr_Authorized(this)' class='cls_btn_pdf btn btn-primary btn-small'>Authorize</button></center>";
                        }
                        else if (data.uso_hr_approved == 'Y')
                        {
                            return "Authorized";
                        }
                        else return "";


                       // if (data.uso_hr_approved != 'Y' && data.hr_approved == 'Y') 
                       // {
                       //     return "<center><button type='button' onclick='rowClick_Hr_Authorized(this)' class='cls_btn_pdf btn btn-primary btn-small'>Authorize</button></center>";
                       // }
                       // else if (data.uso_hr_approved == 'Y')
                       // {
                       //     return "Authorized";
                       // }
                       // else return "";
                    }
                });
            }
            else {
                columns.push({
                    "sTitle": "HR Authorized", "mData": null, "bSortable": false, mRender: function (data) {
                        //if (data.designation == 'VF')
                        //{
                        //    if (data.hr_approved == 'Y')
                        //    {
                        //        return "Authorized (VF)";
                        //    } else {
                        //        return "";
                        //    }
                           
                        //}
                        //else if (data.uso_hr_approved == 'Y') {
                        //    return "Authorized";
                        //}
                        //else return "";
                        
                        if (data.uso_hr_approved == 'Y')
                        {
                            return "Authorized";
                        }
                        else
                        {
                            return "";
                        }

                    }
                });
            }

            if ($('#hdnusertype').val() == 'AC' || $('#hdnusertype').val() == 'F') {
                columns.push({
                    "sTitle": "Print Letter", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.instructor_code != '' && data.hr_approved == 'Y') {
                            //return "<center><button type='button' onclick='rowClick(\"" + data.aData.instructor_code + "\")'>Download</button></center>";
                            return "<center><button type='button' onclick='rowClick(this)' class='cls_btn_pdf btn btn-primary btn-small'>Download</button></center>";
                        }
                        else return "";
                    }
                });
            }

            columns.push({
                "sTitle": "Update New RateBand", "mData": null, "bSortable": false, mRender: function (data) {
                   
                    if (data.uso_hr_approved != 'Y' && $('#hdnusertype').val() == 'HR')
                    {
                       // if (data.designation != 'temp') {
                            return "<center><button type='button' onclick='rowClick_newrateband(this)' class='cls_btn_pdf btn btn-primary btn-small'>New RateBand</button></center>";
                        //}
                        //return "";
                    }
                    else return "";
                    
                }
            });


            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "columnDefs": [

                    { 'visible': false, 'targets': [7, 8, 9, 10,11,12] }
                ],
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
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

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');

            $('#btn_authorize').on('click', function ()
            {
                var oSettings = oTable.fnSettings();

                for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++)
                {
                    oSettings.aoPreSearchCols[iCol].sSearch = '';
                }
                oSettings.oPreviousSearch.sSearch = '';
                oTable.fnDraw();
                var flag_status = 'N';
                var datalist = [];
                $("#example tbody tr").each(function (i)
                {
                    var obj = {};
                    if ($(this).find(".chk_course").is(':checked'))
                    {
                        flag_status = 'Y';
                        var data_inst = $(this).children().eq(0)[0].children[0].id.split('@@')
                        obj["inst_code"] = data_inst[0];  //$(this).children().eq(0)[0].children[0].id;
                        obj["course_code"] = data_inst[1];
                        obj["course_code_combination"] = '(' + data_inst[0] + ',' + data_inst[1] + ')';
                        datalist.push(obj);
                    }
                }); 

                if (flag_status == 'Y') {
                    var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val() });
                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/save_authorize_detail_v2",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Problem in Update data")
                                {
                                    bootbox.alert("Problem in Authorized data");
                                    return false;
                                }
                                else if (data.d == "Update Data") {
                                    //alert("Data Authorized Successfully");
                                    Swal.fire({
                                        text: "Data Authorized Successfully !",
                                        icon: "success",
                                        buttonsStyling: false,
                                        confirmButtonText: "Ok, got it!",
                                        customClass: {
                                            confirmButton: "btn btn-primary"
                                        }
                                    }).then((result) => {
                                        if (result.isConfirmed) {
                                            location.reload();
                                        }
                                    });

                                   
                                }
                               
                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });

                }
                else {
                    bootbox.alert("Please Select Check Box");
                    return false;
                }
                //$.ajax(
                //    {
                //        type: "POST",
                //        contentType: "application/json; charset=utf-8",
                //        url: "../../WebService.asmx/save_authorize_detail",
                //        //async: false,
                //        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                //        dataType: "json",
                //        success: function (data) {
                //            bootbox.alert(data.d);
                //            if (data.d != "" && data.d != "[]") {

                //            }
                //            else {
                //                //bootbox.alert('No data Found For Selected Semester and Year');
                //            }
                //        },
                //        error: function (result) {
                //            alert(result);
                //        }
                //    });
            });

            if ($('#hdnusertype').val() == 'D' || $('#hdnusertype').val() == 'PC') {
                $('#submitBtnDiv').css('display', 'block');
            }
        }

        //function course_select_change(cur_ele)
        //{
        //    var row = element.closest('tr');
        //    var row_data = oTable.fnGetData(row);

        //    //if (cur_ele.checked)
        //    //{
        //    //    if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
        //    //        $('#chk_select_all')[0].checked = true;
        //    //}
        //    //else {
        //    //    $('#chk_select_all')[0].checked = false;
        //    //}
        //}


        function rowClick(element) {
            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);

            $('#hdn_instructor').val(row_data['instructor_code'].toString());
            $('#hdn_instructor_name').val(row_data['instructor_name'].toString());
            $('#hdn_dept').val(row_data['dept_name'].toString());
            $('#hdn_sem').val(semester);
            $('#hdn_year').val(year_code);
            $('#hdn_print_letter').click();
        }

        $(document).on("click", ".pdf_download_doc", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            //var instructor_code = aData["user_id"];
            var instructor_code = aData['instructor_code']
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
                            return false;
                        }
                        return true;
                    }
                    else {
                        bootbox.alert('Document Not Found');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        });

        function rowClick_newrateband(element) {
            debugger;
            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);

            var semester_type = $('#drpsemester').val();
            var year_semester = $('#drpyear').val();
            var a_course_code = row_data['course_code'].toString();
            var a_instructor_code = row_data['instructor_code'].toString();
            var TA_user = row_data["designation"].toString();
            var rate_band = row_data["rate_band"].toString();
            //if (TA_user == "temp") {
            //    return false;
            //}

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Uso_Hr_Update_RateBand",
                    //async: false,
                    data: "{instructor_code:'" + a_instructor_code + "', sem_code:'" + semester_type + "',year_code:'" + year_semester + "',course_code:'" + a_course_code + "',user_type_ta :'" + TA_user+"',rate_band :''}",
                    dataType: "json",
                    success: function (data) {
                        bootbox.alert(data.d);
                       // get_authorize_detail();

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }



        function rowClick_Hr_Authorized(element) {
            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);

            var semester_type = $('#drpsemester').val();
            var year_semester = $('#drpyear').val();
            var a_course_code = row_data['course_code'].toString();
            var a_instructor_code = row_data['instructor_code'].toString();
            var TA_user = row_data["designation"].toString();
            var rate_band = row_data["rate_band"].toString();

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Uso_Hr_Authorized",
                    //async: false,
                    data: "{instructor_code:'" + a_instructor_code + "', sem_code:'" + semester_type + "',year_code:'" + year_semester + "',course_code:'" + a_course_code + "',user_type_ta :'',rate_band :''}",
                    dataType: "json",
                    success: function (data)
                    {
                        bootbox.alert(data.d);
                        get_authorize_detail();

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }

        $(document).on("click", ".pdf_download", function (event) {
          
            var row = $(this).closest("tr").get(0);
            var file_name = event.currentTarget.id;
            var root = window.location.origin;
            //alert(root);
            window.open(root + '/' + 'InstructorCVUpload' + '/' + file_name, '_blank');
        });
        $(document).on("click", ".port_download", function (event) {
            var row = $(this).closest("tr").get(0); //
            var file_name = event.currentTarget.id;
            var root = window.location.origin;
            //alert(root);
            window.open(root + '/' + 'InstructorPortfolioUpload' + '/' + file_name, '_blank');
        });
        $(document).on("click", ".imag_download", function (event) {
            var row = $(this).closest("tr").get(0); //
            var file_name = event.currentTarget.id;
            var root = window.location.origin;
            //alert(root);
            document.getElementById('Link').download = file_name;
            document.getElementById('Link').href = window.location.origin + "\\UserPersonalPhoto" + "\\" + file_name;
            document.getElementById('Link').click();
        });
        function rowClick_edit(row) {
            var instructorCode = row.id;
            var courseCode = row.getAttribute("data-coursecode");

            var url = "vf_edit_personal_detail.aspx?ic=" + instructorCode + "&type=tutor&per=p&icc=" + courseCode + "";
            //var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor";
            window.open(url, "_blank");
        }
        function rowClick_edit_new(row) {
            var instructorCode = row.id;
            var courseCode = row.getAttribute("data-coursecode");

            var url = "vf_edit_personal_detail.aspx?ic=" + instructorCode + "&type=tutor&per=p&icc=" + courseCode + "";
            //var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor";

            //var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor&per=p&icc=" + courseCode + "";
            window.open(url, "_blank");
        }
    </script>
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadExcelDocuments_Click"/>
    <a href="#" id="Link" Style="display: none;"  download="outline.pdf">Download</a>
</asp:Content>
