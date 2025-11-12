<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_vf_edit_workload.aspx.cs" Inherits="Admin_Master_ws_vf_edit_workload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script src="../../Js/vf_edit_workload.js?t=06072022" type="text/javascript"></script>--%>
    <%--29122018--%><%--12072019--%>

    <style type="text/css">
        .cls_hide {
            display: none;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var course_detail;
        var rate_band;
        var workload_detail;
        var action = 'N';

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 46) {
                if (e.currentTarget.value == '') {
                    e.currentTarget.value = '0';
                }
                else if (e.currentTarget.value.indexOf('.') != -1) {
                    return false;
                }
            }

            if (keyCode == 8 || keyCode == 46 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                //if (parseInt($(document.activeElement).val()) > 10) {
                //    return false;
                //}
                //else if (parseInt($(document.activeElement).val()) == 10) {
                //    if (keyCode != 48) {
                //        return false;
                //    }
                //}

                return true;
            }
            else {
                return false;
            }
        }

        function IsNumeric2(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 46) {
                return false;
            }

            if (keyCode == 8 || keyCode == 46 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                return true;
            }
            else {
                return false;
            }
        }

        $(document).ready(function () {

            //get_rate_band();

            //changes RateBand 02102021
            //get_vf_additional_rates();

            get_vf_course_wise_workload_detail();

            //if ($('#hdnusertype').val() == 'FA') {
            //var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
            //    "<i class='icon-save bigger-160'></i>Save</button></td> " +
            //    "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
            //    "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
            //$('#submitBtnDiv').html(str);
            //}
        });

        function get_rate_band() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_rate_band",
                //async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        var obj_rate_band = JSON.parse(data.d);
                        rate_band = '';
                        for (var i = 0; i < obj_rate_band.length; i++) {
                            rate_band = rate_band + "<option>" + obj_rate_band[i]['rate_band'] + "</option>";
                        }
                    }
                },
                error: function (result) {
                    debugger;
                    alert(result);
                }
            });
        }

        var obj_additional_rates = [];
        function get_vf_additional_rates() {

            semester = $('#hdn_scode').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#hdn_ycode').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_vf_additional_rates",
                    async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            obj_additional_rates = JSON.parse(data.d);
                        }
                    },
                    error: function (result) {
                        debugger;
                        alert(result);
                    }
                });
        }

        var course = '';
        var semester = '';
        var year_code = '';
        function get_vf_course_wise_workload_detail() {
            $('#DataList').css('display', 'none');
            $('#div_btn').html('');
            var url_sem_wise = '';
            var data_sem_wise = '';
            course = $('#hdn_ccode').val();
            if (course == "") {
                bootbox.alert('No Course Found to Edit Workload');
                return false;
            }

            semester = $('#hdn_scode').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#hdn_ycode').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            var type = $('#hdn_type').val();
            if (type == "") {
                bootbox.alert('Please select CourseType');
                //$('#drpyear').focus();
                return false;
            }
            url_sem_wise = "../../WebService.asmx/GetInstructorDataForWSCourse";
            data_sem_wise = "{sem_code:'" + semester + "',year_code:'" + year_code + "',course:'" + course + "',type:'" + type + "'}";
            

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_sem_wise,
                    //async: false,
                    data: data_sem_wise,
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            
                            course_detail = JSON.parse(data.d)[0];
                            workload_detail = JSON.parse(data.d);
                            if ($('#hdnusertype').val() == 'FA' && workload_detail[0].admin_approved == "N") {
                                BindButtons();
                            }
                            else if ($('#hdnusertype').val() == 'D' && workload_detail[0].hr_approved == "N") {
                                BindButtons();
                            }
                            // CALL CHANGES 30092024
                            else if ($('#hdnusertype').val() == 'A1')
                            {
                                BindButtons();
                            }

                            //else if (workload_detail[0].All_hr_approved == "N") {
                            //    BindButtons();
                            //}
                            display_get_vf_course_wise_workload_detail(data.d);
                            $('#div_course_list').css('display', 'block');
                            setDataTableHeaderFooter('example');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            if ($('#hdnusertype').val() != 'PC') {
                                $('#div_course_list').css('display', 'none');
                            }
                        }
                    },
                    error: function (result) {
                        debugger;
                        alert(result);
                    }
                });

            return false;
        }

        function set_table_columns(row) {
            var columns = [];

            for (var attr in row) {
                columns.push({ "sTitle": attr, "mData": attr });
            }

            columns[4] = {
                "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false, mRender: function (ddata) {
                    return "<center><input type='text' value='" + ddata + "' class='inline_input' style='width:40px;' onkeypress='return IsNumeric(event);'/></center>";
                }
            };

            columns[5] = {
                "sTitle": "Total Contact Hrs", "mData": "total_contact_hrs", "bSortable": false, mRender: function (ddata) {
                    return "<center><input type='text' value='" + parseFloat(ddata).toFixed(2) + "' class='inline_input' style='width:40px;' onkeypress='return IsNumeric(event);'/></center>";
                }
            };

            return columns;
        }

        function BindButtons() {
            var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                "<i class='icon-save bigger-160'></i>Save</button></td> " +
                "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
            $('#submitBtnDiv').html(str);

            $('#btnapprove').on('click', function () {

                action = 'Y';
                $('#btnsave').click();
               
            });
            $('#btnsave').on('click', function () {
                if ($('#hdn_ccode').val() == '') {
                    bootbox.alert('No Course to update');
                    action = 'N';
                    return false;
                }
                var InstructorData = [];
                var work_load_status = false;
                $("#example tbody tr").each(function () {
                    var Instructor = new Object();
                    Instructor.InstructorCode = this.children[0].innerHTML;
                    Instructor.VFCode = this.children[1].innerHTML;
                    Instructor.InstructorName = this.children[2].innerHTML;
                    Instructor.InstructorDesignation = this.children[3].innerHTML;
                    Instructor.ContactHours = this.children[4].children[0].children[0].value;
                    Instructor.AdditionalHours = this.children[5].children[0].children[0].value;
                    Instructor.TotalHours = this.children[6].children[0].children[0].value;
                    Instructor.ExperienceMonths = this.children[7].innerHTML;
                    Instructor.HighestQualification = this.children[8].innerHTML;
                    Instructor.RateBand = this.children[9].innerHTML;
                    if (this.children[9].innerHTML == "") {
                        work_load_status = true;
                        

                    }
                    Instructor.YearCode = $('#hdn_ycode').val();
                    Instructor.Semester = $('#hdn_scode').val();
                    Instructor.Course = $('#hdn_ccode').val();
                    Instructor.Action = action;
                    Instructor.Faculty_Action = action;
                    Instructor.Type = this.children[10].innerHTML;
                    Instructor.courseselecttype = $('#hdn_type').val();
                    InstructorData.push(Instructor);
                });
                if (work_load_status == true) {
                    //alert("Please Fill Personal Details Then Save and Submit Work Load");
                    //return false;

                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    // url: "../../WebService.asmx/save_vf_course_wise_workload_detail",
                    url: "../../WebService.asmx/SaveWSInstructorDetail",
                    async: false,
                    data: "{ All_table_course_data: '" + JSON.stringify(InstructorData) + "' }",
                    dataType: "json",
                    success: function (data) {

                        if (data.d == 'Data Saved Successfully') {
                            if (action == 'Y') {
                                bootbox.alert('RateBand Save/Submitted Successfully', function () {
                                    window.location = "ws_vf_work_load_mgmt.aspx";
                                });
                            }
                            else {
                                bootbox.alert(data.d, function () {
                                    location.reload();
                                });
                            }
                        }
                        else if (data.d != "") {
                            debugger;
                            alert(data.d);
                        }
                    },
                    error: function (result) {
                        debugger;
                        alert(result);
                    }
                });
                InstructorData = [];

            });
            
        }

       

        //function addRow(row) {
        //    row.closest("tr").append("<tr><td>1</td></tr>");

        //    //    var rowId = row.parentElement.parentElement;
        //    //    row.parentElement.parentElement.insertRow(0);
        //}

        function CalculateTotalHours(E) {
            debugger;
            var Id = E.id.split('_')[1];
            $("#TotalHrs_" + Id).val((!isNaN($("#ContactHrs_" + Id).val()) && $("#ContactHrs_" + Id).val() != null && $("#ContactHrs_" + Id).val() != '' ? parseInt($("#ContactHrs_" + Id).val()) : 0) + (!isNaN($("#AdditionalHrs_" + Id).val()) && $("#AdditionalHrs_" + Id).val() != null && $("#AdditionalHrs_" + Id).val() != '' ? parseInt($("#AdditionalHrs_" + Id).val()) : 0));
        }

        function display_get_vf_course_wise_workload_detail(data)
        {
            var columns = [{ "sTitle": "Instructor Code", "mData": "instructor_code" },
            { "sTitle": "Code", "mData": "VF_code" },
            //{ "sTitle": "Instructor Name", "mData": "instructor_name" },
            {
                "sTitle": "Instructor Name", "mData": "instructor_name"
            },
            //{ "sTitle": "Designation", "mData": "designation" },
            { "sTitle": "Grade", "mData": "designation" },
            {
                "sTitle": "Contact Hrs", "mData": null, "bSortable": false, "fnRender": function (data) {
                    //if (data.aData['hr_approved'] == "N") {
                    return "<center><input type='text' value='" + parseFloat(data.aData['Contact_Hrs']) + "' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);' onchange='CalculateTotalHours(this)' id='ContactHrs_" + data.aData['instructor_code'] +"'/></center>";
                    //}
                    //else {
                    //    return "<center>" + parseFloat(data.aData['Contact_Hrs']) + "</center>";
                    //}
                }
                },
                {
                    "sTitle": "Addition Contact Hrs", "mData": null, "bSortable": false, "fnRender": function (data) {
                        if (data.aData['hr_approved'] == "N")
                        {
                            if (data.aData['additional_hours'] != '') {
                                return "<center><input type='text' value='" + parseFloat(data.aData['additional_hours']) + "' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);' onchange='CalculateTotalHours(this)' id='AdditionalHrs_" + data.aData['instructor_code'] + "'/></center>";
                            }
                            else
                            {
                                return "<center><input type='text' value='' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);' onchange='CalculateTotalHours(this)' id='AdditionalHrs_" + data.aData['instructor_code'] + "'/></center>";
                            }
                            
                        }
                        else {
                            return "<center><input type='text' value='" + parseFloat(data.aData['additional_hours']) + "' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);' onchange='CalculateTotalHours(this)' id='AdditionalHrs_" + data.aData['instructor_code'] + "'/></center>";
                            //return "<center>" + parseFloat(data.aData['additional_hours']) + "</center>";
                        }
                    }
                },
                {
                    "sTitle": "Total Contact Hrs", "mData": null, "bSortable": false, "fnRender": function (data) {
                        // if (data.aData['hr_approved'] == "N") {

                        if (data.aData['total_contact_hrs'] != "")
                        {
                            return "<center><input type='text' value='" + parseFloat(data.aData['total_contact_hrs']) + "' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);' id='TotalHrs_" + data.aData['instructor_code'] + "' disabled='disabled'/></center>";
                        }
                        return "<center><input type='text' value='' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);' id='TotalHrs_" + data.aData['instructor_code'] + "' disabled='disabled'/></center>";
                        
                        // }
                        // else {
                        //     return "<center>" + parseFloat(data.aData['Contact_Hrs']) + "</center>";
                        // }
                    }
                },
            { "sTitle": "Total Experience Months", "mData": "total_experiance" },
            { "sTitle": "Highest Qualification", "mData": "highest_qualification" },
                { "sTitle": "Rate Band", "mData": "rate_band" },
                

                
                { "sTitle": "Type", "mData": "Type" },

                {
                    "sTitle": "Action", "mData": null, "bSortable": false, "fnRender": function (data) {
                        // if (data.aData['hr_approved'] == "N") {

                        if (data.aData['All_hr_approved'] != "N") {
                            return "<center><button id='" + data.aData['instructor_code'] + "' type='button' onclick='update_after_submit(this)'>Update</button></center>";
                        }
                        else {
                            return "";
                        }


                        // }
                        // else {
                        //     return "<center>" + parseFloat(data.aData['Contact_Hrs']) + "</center>";
                        // }
                    }
                },
                //{ "sTitle": "Rate Band", "mData": "calculated_rate_band" }
                //{"sTitle": "Alternate Band", "mData": "alternate_band", "bSortable": false, mRender: function (ddata) {
                //    if (ddata != '')
                //        return "<center><input type='text' value='" + parseFloat(ddata) + "' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);'/></center>";
                //    else
                //        return "<center><input type='text' value='' class='inline_input cls_alternate_band' style='width:30px;' onkeypress='return IsNumeric2(event);'/></center>";
                //}
                //},


            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
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

                "aoColumns": columns

            });

            //if (workload_detail.length > 0) {
            //    $("#example tbody tr").each(function (i) {
            //        if (workload_detail[i].alternate_band != '') {
            //            $(this).children().eq(11)[0].children[1].children[0].value = workload_detail[i].alternate_band;
            //            $(this).children().eq(11)[0].children[2].children[0].value = workload_detail[i].justification;
            //        }
            //    });
            //}

            //$('#panel_head').html(course_detail['course_code'] + ' - ' + course_detail['course_name']);
            $('#td_course_code').html(course_detail['course_code']);
            $('#td_course_name').html(course_detail['course_name']);
            // $('#td_course_type').html(course_detail['type_name']);
            $('#td_course_credits').html(course_detail['course_credits']);

            approve_cnt = 0;
            $('#DataList').css('display', 'block');
            $('#div_course_detail').css('display', 'block');

            $('#example thead tr')[0].children[0].style.display = 'none';

            $("#example tbody tr").each(function (i) {
                $(this).children().eq(0)[0].style.display = 'none';
            });

            //$("#example thead tr")[0].lastChild.style.display = 'none';

            $("#example tbody tr").each(function (i) {
               // this.lastChild.style.display = 'none';
            });

            $('.cls_alternate_band').on('change', function () {
                if (this.value == '') {
                    $(this).closest('tr').find('.cls_justification').val('');
                }
            });

            $(function () {
                $(".addRows").click(function () {
                    var row_data = "";
                    row_data = "<tr><td style='display:none;'>" + $(this).closest('tr')[0]["childNodes"][0]["innerHTML"] + "</td><td></td><td></td><td></td>";
                    row_data += "<td><center><input type='text' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'></center></td>";
                    row_data += "<td><center><input type='text' class='inline_input' style='width:30px;' onchange='return inputChange();' onkeypress='return IsNumeric(event);'></center></td>";
                    row_data += "<td class='cls_hide'></td><td class='cls_hide'></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td><a class='del_row'>Delete</a></td><td class='cls_hide'></td></tr>";
                    $(this).closest('tr').after(row_data);
                });
            });

        }


        $(".del_row").live('click', function (e) {
            if (confirm('Are you sure you want to delete this workload ?')) {
                $(this).closest('tr').remove();
            } else {
                // Do nothing!
            }
        });

        function update_after_submit(id_dt)
        {
            var inst_code = id_dt.id;
            var course_code = $('#hdn_ccode').val();
            var semester = $('#hdn_scode').val();
            var year_code = $('#hdn_ycode').val();
            var contac_hrs = $('#ContactHrs_' + inst_code).val();
            var add_hourse = $('#AdditionalHrs_' + inst_code).val();
            var total_hrs = $('#TotalHrs_' + inst_code).val();
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ws_update_rateband",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code:'" + course_code + "',inst_code:'" + inst_code + "',contac_hrs:'" + contac_hrs + "',add_hourse:'" + add_hourse + "',total_hrs:'" + total_hrs +"'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            if (data.d == 'Data Saved Successfully') {
                                bootbox.alert("Rate Band Data Update Successfully");
                                return false;

                            }
                        }
                        else
                        {
                        //    bootbox.alert('No data Found For Selected Semester and Year');
                        }
                    },
                    error: function (result) {
                        debugger;
                        alert(result);
                    }
                });

            return false;


        }
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Work Load & Rate
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div id="div_course_detail" class="panel panel-default" style="display: none;margin-bottom:0px">
            <div class="panel-heading">
                <strong id="Strong1">Course Detail</strong>
            </div>
            <div style="min-height: 45px;">
                <div>                    
                    <table style="margin: 10px 0px 10px 15px; float: left;">
                        <tr>
                            <td><b>Course Code : </b></td>                            
                            <td id="td_course_code"></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><b>Course Name : </b></td>                            
                            <td id="td_course_name"></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><b>Credits : </b></td>                            
                            <td id="td_course_credits"></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <%--<tr>
                            <td><b>Course Name</b></td>
                            <td>&nbsp;:&nbsp;</td>
                            <td id="td_course_name"></td>
                        </tr>
                        <tr>
                            <td><b>Course Type</b></td>
                            <td>&nbsp;:&nbsp;</td>
                            <td id="td_course_type"></td>
                        </tr>
                        <tr>
                            <td><b>Credits</b></td>
                            <td>&nbsp;:&nbsp;</td>
                            <td id="td_course_credits"></td>
                        </tr>--%>
                    </table>
                </div>

                <div style="padding-left: 50%;">
                    <%--<table id="tbl_load_dtl" style="margin: 10px 0px 10px 15px;">
                        <thead>
                            <tr>
                                <td><b>Instructor</b></td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td><b>Load</b></td>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>--%>
                </div>
            </div>
        </div>
    </div>

    <div class="well" style="background-color: White; clear: both;">

        <div id="div_course_list" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Edit Workload Detail</strong>
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
    </div>

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>

    <asp:HiddenField ID="hdn_ccode" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_scode" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_ycode" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_type" runat="server" ClientIDMode="Static" />

</asp:Content>
