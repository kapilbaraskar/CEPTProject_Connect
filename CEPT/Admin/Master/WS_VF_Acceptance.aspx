<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_VF_Acceptance.aspx.cs" Inherits="Admin_Master_WS_VF_Acceptance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
       <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Acceptance
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
                                <td>
                                    Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    Year 
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                   <td>
                                    Department
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment">
                                    </select>
                                </td>
                                
                            </tr>
                            <tr>
                              <%-- <td>
                                    Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>--%>
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
        
        <div id="div_course_list" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">VF Detail</strong>
            </div>

            <div><%--class="panel-body"--%>
                
                <div id="DataList" style="display: none;">
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

        <div id="submitBtnDiv" style="text-align: center;margin:10px;display:none;">
            <input type="button" id="btn_accept" value="Save" class="btn btn-primary"/>
        </div>
    </div>
    
    <script type="text/javascript">
        var oTable;
        var course_detail;
        var rate_band;
        var workload_detail;
        var action = 'S';
        var default_text = 'It is construed that the faculty has accepted his appointment at CEPT University.';


        $(document).ready(function () {

            bindsemdata();
            bindyeardata_for_cross_reg();
            //bindprogramme();
            //bindproglevel();
            get_fauser_detail();
            $('#btnreterive').on('click', function () {
                get_authorize_detail();
                return false;
            });

            //setCurrentSemester();
        });


        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

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

        function get_fauser_detail() {

            var url_dept = "";

            if ($('#hdnusertype').val() == 'FA') {
                url_dept = "../../WebService.asmx/get_ws_department_wise_user_dtl";
            }
            else {
                url_dept = "../../WebService.asmx/Get_department_data";
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dept,
                    async: false,
                    data: "{}",
                    dataType: "json",
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

                            $('#btnreterive').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var semester = '';
        var year_code = '';
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

            prog_code = $('#drpdepartment').val();
            if ($('#hdnusertype').val() == 'FA')
            {
                if (prog_code == '') {
                    bootbox.alert("Please Select Department");
                    return false;

                }
            } 
            prog_level_code = "";

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                //url: "../../WebService.asmx/get_acceptance_detail",
                    url: "../../WebService.asmx/WS_get_authorize_detail_vf_acceptance_new",
                //async: false,
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {

                        workload_detail = JSON.parse(data.d);

                        display_get_vf_personal_detail(data.d);

                        $('#div_course_list').css('display', 'block');
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
                    "sTitle": "<center><input type='checkbox' id='chk_select_all_student' onchange='select_all_student()' /> Select</center>", "mData": null, "bSortable": false, mRender: function (data)
                    {
                        
                        var row_value = data.instructor_code;
                       return '<center><input type="checkbox"  name="check_all_student" value="1" class="chk_course" id="' + row_value + '" /></center>';
                    }
                },

                            { "sTitle": "Instructor Code", "mData": "instructor_code" },
                            //{ "sTitle": "Instructor Name", "mData": "instructor_name" },
                            //{"sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false, mRender: function (ddata) {
                            {"sTitle": "Instructor Name", "mData": null, "bSortable": false, mRender: function (ddata) {
                                if (ddata.is_tutorial == 'Y') {
                                    return ddata.instructor_name + ' (T)';
                                }
                                else {
                                    return ddata.instructor_name;
                                }
                            }
                            },
                            { "sTitle": "Course Code", "mData": "course_code" },
                            //{ "sTitle": "Contact hrs", "mData": null, "bSortable": false, fnRender: function (data) {
                            //    if (data.aData.total_contact_hrs) {
                            //        return parseFloat(data.aData.total_contact_hrs).toFixed(2);
                            //    }
                            //    else return '';
                            //}
                            //},
                            //{ "sTitle": "Preparatory hrs", "mData": null, "bSortable": false, fnRender: function (data) {
                            //    if (data.aData.total_preparation_hrs != '') {
                            //        return parseFloat(data.aData.total_preparation_hrs).toFixed(2);
                            //    }
                            //    else return '';
                            //}
                            //},
                            //{ "sTitle": "Total Weeks", "mData": "total_weeks" },
                            {"sTitle": "Pay Band", "mData": "rate_band" },
                            { "sTitle": "Total Amount Paid", "mData": "total_amount_paid" },
                            //{ "sTitle": "Justification", "mData": "justification" },
                            {"sTitle": "Justification", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.justification == '') {
                                    return 'NA';
                                }
                                else return data.justification;
                            }
                            },
                            //{ "sTitle": "Personal Detail Approval", "mData": null, "bSortable": false, fnRender: function (data) {
                            //    if (data.aData.personal_dtl_approved == 'Y') {
                            //        return 'Approved';
                            //    }
                            //    else return '';
                            //}
                            //},
                            //{ "sTitle": "Rateband Approval", "mData": null, "bSortable": false, fnRender: function (data) {
                            //    if (data.aData.rateband_approved == 'Y') {
                            //        return 'Approved';
                            //    }
                            //    else return '';
                            //}
                            //},
                            //{ "sTitle": "Workload Approval", "mData": null, "bSortable": false, fnRender: function (data) {
                            //    if (data.aData.workload_approved == 'Y') {
                            //        return 'Approved';
                            //    }
                            //    else return '';
                            //}
                            //},
                            {"sTitle": "Authorized", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.hr_approved == 'Y') {
                                    return 'Authorized';
                                }
                                else return '';
                            }
                            },
                            { "sTitle": "Default Acceptance", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.acceptance == 'Y') {
                                    //return "<center><input type='checkbox' class='cls_chk_accept' onchange='return checkedChange();' checked='checked'/></center>";
                                    if (data.acceptance_type == 'D') {
                                        return "<center><input type='radio' name='rdo_acceptance_" + data.instructor_code + "_" + data.is_tutorial + "_" + data.course_code + "' value='D' onchange='return checkedChange(this);' checked='checked' /></center>";
                                    }
                                    else {
                                        return "<center><input type='radio' name='rdo_acceptance_" + data.instructor_code + "_" + data.is_tutorial + "_" + data.course_code + "' value='D' onchange='return checkedChange(this);' /></center>";
                                    }
                                }
                                else return "<center><input type='radio' name='rdo_acceptance_" + data.instructor_code + "_" + data.is_tutorial + "_" + data.course_code + "' value='D' onchange='return checkedChange(this);' /></center>";
                            }
                            },
                            { "sTitle": "Acceptance", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.acceptance == 'Y') {
                                    //return "<center><input type='checkbox' class='cls_chk_accept' onchange='return checkedChange(this);' checked='checked'/></center>";
                                    if (data.acceptance_type == 'A') {
                                        return "<center><input type='radio' name='rdo_acceptance_" + data.instructor_code + "_" + data.is_tutorial + "_" + data.course_code + "' value='A' onchange='return checkedChange(this);' checked='checked' /></center>";
                                    }
                                    else {
                                        return "<center><input type='radio' name='rdo_acceptance_" + data.instructor_code + "_" + data.is_tutorial + "_" + data.course_code + "' value='A' onchange='return checkedChange(this);' /></center>";
                                    }
                                }
                                //else return "<center><input type='checkbox' class='cls_chk_accept' onchange='return checkedChange(this);'/></center>";
                                else return "<center><input type='radio' name='rdo_acceptance_" + data.instructor_code + "_" + data.is_tutorial + "_" + data.course_code + "' value='A' onchange='return checkedChange(this);' /></center>";
                            }
                            },
                            { "sTitle": "Justification", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.acceptance == 'Y') {
                                    if (data.acceptance_type == 'D') {
                                        return "<center><input type='text' value='" + data.acceptance_justification + "' class='inline_input' style='width:200px;margin-top:2px;'/>" +
                                            "<input type='file' name='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' id='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' onchange='javascript:return UploadProfilePhoto(this);' style='width: 95px;display:none;'/>" +
                                            "<span id='spn_image_acceptance_" + data.instructor_code + "_" + data.course_code + "' style='display:none;'></span></center>";
                                    }
                                    else if (data.acceptance_type == 'A') {
                                        return "<center><input type='text' value='' class='inline_input' style='width:200px;margin-top:2px;display:none;'/>" +
                                            "<input type='file' name='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' id='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' onchange='javascript:return UploadProfilePhoto(this);' style='width: 95px;'/>" +
                                            "<span id='spn_image_acceptance_" + data.instructor_code + "_" + data.course_code + "'>" + data.acceptance_justification + "</span></center>";
                                    }
                                    else {
                                        return "<center><input type='text' value='" + data.acceptance_justification + "' class='inline_input' style='width:200px;margin-top:2px;display:none;'/>" +
                                        "<input type='file' name='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' id='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' onchange='javascript:return UploadProfilePhoto(this);' style='width: 95px;display:none;'/>" +
                                        "<span id='spn_image_acceptance_" + data.instructor_code + "_" + data.course_code + "' style='display:none;'>" + data.acceptance_justification + "</span></center>";
                                    }
                                }
                                else {
                                    return "<center><input type='text' value='" + data.acceptance_justification + "' class='inline_input' style='width:200px;margin-top:2px;display:none;'/>" +
                                        "<input type='file' name='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' id='imageUpload_acceptance_" + data.instructor_code + "_" + data.course_code + "' onchange='javascript:return UploadProfilePhoto(this);' style='width: 95px;display:none;'/>" +
                                        "<span id='spn_image_acceptance_" + data.instructor_code + "_" + data.course_code + "' style='display:none;'>" + data.acceptance_justification + "</span></center>";
                                }
                            }
                            },
                            { "sTitle": "Date", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.acceptance == 'Y' && data.acceptance_date != '') {
                                    var temp_date = new Date(data.acceptance_date);
                                    return "<center><input type='text' value='" + temp_date.format("dd/MM/yyyy") + "' class='inline_input cls_acceptance_date' style='width:100px;margin-top:2px;display:block;'/></center>";
                                }
                                else return "<center><input type='text' value='' class='inline_input cls_acceptance_date' style='width:100px;margin-top:2px;display:block;'/></center>";
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
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
   //             "oTableTools": {
   //                 "aButtons": [
   //                 //"copy",
			//	"print",
   //         	{
   //         	    "sExtends": "collection",
   //         	    "sButtonText": 'Export',
   //         	    "aButtons": ["xls"]
   //         	}
			//]
   //             },

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');

            if ($._data($('#btn_accept').get(0), 'events') == undefined || $._data($('#btn_accept').get(0), 'events').click.length <= 0)
            {
               
            }

            if ($('#hdnusertype').val() == 'FA') {
                $('#submitBtnDiv').css('display', 'block');
            }

            $('#example thead tr')[0].children[1].style.display = 'none';
            $('#example thead tr')[0].children[7].style.display = 'none';

            $("#example tbody tr").each(function (i) {
                $(this).children().eq(1)[0].style.display = 'none';
                $(this).children().eq(7)[0].style.display = 'none';
            });

            $('.cls_acceptance_date').datepicker({ dateFormat: 'dd/mm/yy' });
        }


        $('#btn_accept').on('click', function () {
            debugger;
            var status = 'false';
            var All_instructor_workload_data = [];
            
            $("#example tbody tr").each(function (i)
            {
                if ($(this).find(".chk_course").is(':checked'))
                {
                    status = 'true';
                var instructor_workload_data = { 'instructor_code': '', 'course_code': '', 'acceptance': '', 'acceptance_justification': '', 'acceptance_type': '', 'acceptance_date': '', 'is_tutorial': '' };

                instructor_workload_data.instructor_code = $(this).children()[1].innerHTML;

                instructor_workload_data.course_code = $(this).children()[3].innerHTML;

                instructor_workload_data.is_tutorial = oTable.fnGetData(this)['is_tutorial'];

                var rdo_acceptance = $('input[name=' + $(this).children().eq(8)[0].children[0].children[0].name + ']:checked').val();

                if (rdo_acceptance == undefined) {
                    instructor_workload_data.acceptance = 'N';
                }
                else {
                    instructor_workload_data.acceptance = 'Y';
                    instructor_workload_data.acceptance_type = rdo_acceptance;

                    //if ($(this).children().eq(7)[0].children[0].children[0].checked) {
                    if (rdo_acceptance == 'D') {
                        instructor_workload_data.acceptance_justification = $(this).children().eq(10)[0].children[0].children[0].value;
                    }
                    else if (rdo_acceptance == 'A') {
                        instructor_workload_data.acceptance_justification = $(this).children().eq(10)[0].children[0].children[2].innerHTML;
                    }
                }

                var temp_date = [];
                    //if ($(this).children().eq(10)[0].children[0].children[0].value != '') {
                        temp_date = $(this).children().eq(11)[0].children[0].children[0].value.split('/');
                    //}
                if (temp_date.length == 3) {
                    instructor_workload_data.acceptance_date = temp_date[1] + '/' + temp_date[0] + '/' + temp_date[2];
                }

                    All_instructor_workload_data.push(instructor_workload_data);
                }
            });

            if (status == 'false') {

                bootbox.alert("Please Select Check Box");
                return false;
            }
            var All_instructor_data = [All_instructor_workload_data, action];
            var json_All_instructor_data = JSON.stringify(All_instructor_data);

            if (json_All_instructor_data.search("'") != -1) {
                json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/WS_save_acceptance_detail",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',All_table_course_data: '" + json_All_instructor_data + "'}",
                    dataType: "json",
                    success: function (data) {
                        bootbox.alert(data.d, function () { location.reload(); });
                        //get_authorize_detail();
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        });





        function select_all_student() {
            if ($('#chk_select_all_student')[0].checked) {
                $("input[name='check_all_student']").attr('checked', 'checked');
            }
            else {
                $("input[name='check_all_student']").removeAttr('checked');
            }
        }

        function checkedChange(cur_element) {
            var cur_element_val = $('input[name='+cur_element.name+']:checked').val();
            if (cur_element_val == 'D') {
                cur_element.closest('td').nextElementSibling.nextElementSibling.children[0].children[1].style.display = 'none';
                cur_element.closest('td').nextElementSibling.nextElementSibling.children[0].children[2].style.display = 'none';
                cur_element.closest('td').nextElementSibling.nextElementSibling.children[0].children[0].style.display = 'block';
                if (cur_element.closest('td').nextElementSibling.nextElementSibling.children[0].children[0].value == '') {
                    cur_element.closest('td').nextElementSibling.nextElementSibling.children[0].children[0].value = default_text;
                }
            }
            else if (cur_element_val == 'A') {
                cur_element.closest('td').nextElementSibling.children[0].children[0].style.display = 'none';
                cur_element.closest('td').nextElementSibling.children[0].children[1].style.display = 'block';
                cur_element.closest('td').nextElementSibling.children[0].children[2].style.display = 'block';
            }
        }


        function UploadProfilePhoto(cur_element) {
            try {
                element_id = cur_element.id;

                //var fileToUpload = GetFileNameFromPath($('#imageUpload').val());
                var fileToUpload = GetFileNameFromPath($('#' + element_id).val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/WSVFAcceptanceUpload.ashx',
                                secureuri: false,
                                //fileElementId: 'imageUpload',
                                fileElementId: element_id,
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            //$('#imageUpload').val("");

                                            //FileName = data.upfile;
                                            $('#' + element_id)[0].parentElement.children[2].innerHTML = 'WS_'+ data.upfile;
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
                    alert('Invalid File Type. Please upload .jpeg file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        //Get File Name From Path
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

        //Check User Photo Extension
        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'jpg':
                    case 'jpeg':
                    case 'JPG':
                    case 'JPEG':
                    case 'PNG':
                    case 'png':
                    case 'PDF':
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

    </script>
</asp:Content>

