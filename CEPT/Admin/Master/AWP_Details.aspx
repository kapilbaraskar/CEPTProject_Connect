<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="AWP_Details.aspx.cs" Inherits="Admin_Master_AWP_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
          <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
    <link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <%--<script src="https://cdn.jsdelivr.net/npm/alasql@1.5.5/dist/alasql.min.js"></script>--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

   <style>
        [id^="awp_T"] {
  width: 100%;
  table-layout: fixed; /* Ensures columns have a fixed layout and don't auto-expand */ 
  border-collapse: collapse;
}

/* Style for all td elements */
[id^="awp_T"] td {
  padding: 10px;
  max-width: 300px;  /* Set your max width for each td */
  width: 25%; /* This ensures the width is flexible based on the number of columns, but will never exceed max-width */
  box-sizing: border-box;
  display: table-cell;  /* Maintain standard table cell behavior */
}

/* Flexbox for form controls inside td */
[id^="awp_T"] td > div {
  display: flex;
  /*flex-wrap: wrap;*/
  flex-wrap: nowrap;
  justify-content: flex-start;
  gap: 4px; /* 10px Add spacing between inputs */
  width: 100%;
}

/* Make sure inputs and textareas do not exceed max width */
[id^="awp_T"] .form-control {
  max-width: 100%; /* Ensure input fields do not exceed the max width of td */
  /*flex: 1 1 15%;*/ /* Each input takes at least 20% of available space but can shrink */
  box-sizing: border-box;
  height:30px;
}
[id^="awp_T"] .form-control.total-hours{
    flex: 0 1 8%; /* These inputs take 8% of the width and can shrink */
  max-width: 9%;
}

/* Special case for total hours and hours (8% width) */

[id^="awp_T"] .form-control.hours {
  flex: 0 1 8%; /* These inputs take 8% of the width and can shrink */
  max-width: 40%; /*8%*/
}
[id^="awp_T"] .form-control.selecttutor{
    flex: 0 1 10%; /* These inputs take 8% of the width and can shrink */
    max-width: 36%;  /*40%*/
}

[id^="awp_T"] .form-control.coursename{
    flex: 0 1 11%; /* These inputs take 8% of the width and can shrink */
    max-width: 62%; /*38% 49% 11%*/
}
[id^="awp_T"] .form-control.selectdataforhours{
    flex: 0 1 11%; /* These inputs take 8% of the width and can shrink */
    max-width: 23%; /*38% 49% 11%*/
}

/* Textarea specific styles */
[id^="awp_T"] .form-control.remark {
  /*flex: 1 1 20%;*/  /* Let textarea grow to take full width */
  width: 100%;
  overflow-x:hidden;
  resize:vertical;
  height: 30px;

}

/* Button style */
[id^="awp_T"] .remove-subrow {
  /*flex: 0 0 auto;*/ /* Button takes only as much space as it needs */
  /*margin-top: 10px;*/
      height: 35px;
}
.is-invalid {
    border: 2px solid #dc3545 !important; 
    background-color: #fff0f0;
    border-radius: 4px;
}
.hours-remark-group {
  /*display: flex;*/
  flex-direction: column;
  gap: 5px;
  /*margin-bottom: 15px;*/
}

/*.hours-remark-group .form-control {
  width: 100%;
}*/
.remove-subrow:focus:not(:focus-visible) {
  outline: none;
  box-shadow: none;
}
.section-header-row {
    cursor: pointer;
}

.section-header-row:hover {
    background-color: #f9f9f9;
}
.collapsible-header {
  background-color: #f5f5f5;
  padding: 10px;
  font-weight: bold;
  color: blue;
  cursor: pointer;
  user-select: none;
  border: 1px solid #ddd;
}

.collapsible-content {
  padding: 10px;
  border: 1px solid #ddd;
  border-top: none;
  display: none; /* Hidden by default */
}
.fa-chevron-down{
    color:blue !important;
}
.fa-chevron-up{
    color:blue !important;
}
tr.subchild-row > td {
  border-bottom: 1px solid #ccc;
}
[id^="awp_T"] tr[id^="S"] {
  border-bottom: 1px solid #ccc;
}

[id^="awp_T"] tr[id^="TYPE"] {
  border-bottom: 1px solid #ccc;
}

    </style>
    <script type="text/javascript">
        var GetAWPStandardInstitutionalHour = '';
        var GetAwpSubTypeWorkMasterDetailsDtl = null;
        var typologywisecontacthrs = null;
        var datasavestatus = 'N';
        var addrowstatus = 'N';
        var GetAwpTypeMasterData_master = '';
        var GetAwpRationaleData_master = [];
        var GetAwpRationaleData_dtl = '';
        var year_code_data = '';
        $(document).ready(function () {
            GetCpopUserData();

            $('#BindPlammedOP').append('<option value="">----Select Planned----</option>');
            $('#BindPlammedOP').append('<option value=FullYear> Full Year Proposed/Planned</option>');
            $('#BindPlammedOP').append('<option value=ActualJuneToDec> Actual June to Dec</option>');
            $('#BindPlammedOP').append('<option value=ActualJanToJune> Actual Jan to June</option>');
            //$('#BindPlammedOP').append('<option value=' + GetAWpMainMasterDetails[i]['awp_plan_code'] + '>' + GetAWpMainMasterDetails[i]['awp_plan_name'] + ' ' + '( ' + GetAWpMainMasterDetails[i]['aws_desc'] + ' )' + '</option>')
            $(document).on('click', '.btngetdata', function ()
            {
                var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                    "<i class='icon-save bigger-160'></i>Save</button></td> " +
                    "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                    "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
                $('#submitBtnDiv').html(str);


                GetAWPTypeMaster();
                totalhoursCalculation();

                

                
                
                $('.collapsible-header').children().first().click();

                $('.collapsible-header').first().find('i').removeClass('fa-chevron-down').addClass('fa-chevron-up');

                $('tr[data-parent="S014"] input').prop('disabled', true);
               $('tr label.total-hours').prop('disabled', true);
                AddRowClick_DefaultRow('S010');
                AddRowClick_DefaultRow('S011');
                AddRowClick_DefaultRow('S013');
                AddRowClick_DefaultRow('S014');
                AddRowClick_DefaultRow('S012');




                var $nextRow = $('.subchild-row[data-parent="S010"]').next('tr.addrow-holder');
                if ($nextRow.length) {
                    $nextRow.hide();
                }
                var $nextRow = $('.subchild-row[data-parent="S011"]').next('tr.addrow-holder');
                if ($nextRow.length) {
                    $nextRow.hide();
                }
                var $nextRow = $('.subchild-row[data-parent="S014"]').next('tr.addrow-holder');
                if ($nextRow.length) {
                    $nextRow.hide();
                }
                var $nextRow = $('.subchild-row[data-parent="S012"]').next('tr.addrow-holder');
                if ($nextRow.length) {
                    $nextRow.hide();
                }
                if (GetAwpTypeMasterData_master != '' && GetAwpTypeMasterData_master.length > 0) {
                    for (var m = 0; m < GetAwpTypeMasterData_master.length; m++)
                    {
                        $('#' + GetAwpTypeMasterData_master[m].awp_type_code).prepend('<p style="color:#8f2808;"><b>' + GetAwpTypeMasterData_master[m].remarks_note + '</b></p>');
                    }
                }
                
                $('#S010 .btnclick').hide();
                $('#S011 .btnclick').hide();
                $('tr.subchild-row[data-parent="S011"] .hours').prop('disabled', true);

                if ($('#BindPlammedOP').val() == 'ActualJuneToDec' || $('#BindPlammedOP').val() == 'ActualJanToJune') {
                    $('tr.subchild-row[data-parent="S010"] .hours').prop('disabled', true);
                }

                if ($('#BindPlammedOP').val() == 'ActualJuneToDec' || $('#BindPlammedOP').val() == 'ActualJanToJune')
                {
                    $('table tr').each(function ()
                    {
                        $(this).find('.hours').first().prop('disabled', true);
                    });
                }

            });

            $(document).on('input change', 'input.hours,textarea[placeholder="Description"], select', function () {
                const $field = $(this);
                const val = $field.val().trim();
                const isNumberField = $field.hasClass('total-hours') || $field.hasClass('hours');

                if (val === '' || (isNumberField && isNaN(val))) {
                    $field.addClass('is-invalid');
                } else {
                    $field.removeClass('is-invalid');
                }
            });
            
            $(document).on('click', '.collapsible-header', function () {
                const targetId = $(this).data('target'); // "#T005"
                const content = this.nextElementSibling;

                var icon = $(this).find('i');
                icon.toggleClass('fa-chevron-down fa-chevron-up');
                $('.collapsible-header').not(this).find('i').removeClass('fa-chevron-up').addClass('fa-chevron-down');
                if (content.style.display === "none" || content.style.display === "") {
                    content.style.display = "block"; 
                }
                else
                {
                    content.style.display = "none";
                }

            });



        });


        function GetCpopUserData() {
            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/GetAWPCpopSuperviserDetails",
                data: "",
                contentType: "application/json",
                async: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != "") {
                        var GetAWPCpopSuperviserDetails = JSON.parse(data.d);
                        if (GetAWPCpopSuperviserDetails != null && GetAWPCpopSuperviserDetails.length > 0) {
                            var supervisor_name = GetAWPCpopSuperviserDetails[0]['supervisor_name'] || '';
                            var designation = GetAWPCpopSuperviserDetails[0]['designation'] || '';
                            var department = GetAWPCpopSuperviserDetails[0]['department'] || '';
                            var email = GetAWPCpopSuperviserDetails[0]['email'] || '';
                            var contact = GetAWPCpopSuperviserDetails[0]['contact'] || '';

                            $('#txt_name').text(supervisor_name);
                            $('#txt_designation').text(designation);
                            $('#txt_faculty').text(department);
                            $('#txt_name').text(supervisor_name);
                            $('#txt_email').text(email);
                            $('#txt_mobile').text(contact);

                        }
                        
                    }
                    else {
                        $('.btngetdata').hide();

                        bootbox.alert("This page is accessible only to CPOP users");
                        return false;

                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }

        function GetAWPTypeMaster() {
            if ($('#BindPlammedOP').val() == "") {
                bootbox.alert("Please Select Planned");
                return false;
            }
            var semesteryear = '';
            var semester = '';
            var planned = $('#BindPlammedOP').val();
            var action = "";//$('#BindActionOP').val();
            var SplitSemesterYear = "";//$('#BindSemesterOP').val().split('_');

            var parametername = '';
            if ($('#BindPlammedOP').val() == 'FullYear') {
                parametername = 'Proposed_Planned';
            }
            else if ($('#BindPlammedOP').val() == 'ActualJuneToDec') {
                parametername = 'Actual_June_to_Dec';
            }
            else if ($('#BindPlammedOP').val() == 'ActualJanToJune') {
                parametername = 'Actual_Jan_to_June';
            }

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/Get_AWP_Data",
                data: "{Planned:'" + planned + "',Semester:'" + semester + "',semesteryear:'" + semesteryear + "',year:'2025-2026',Action:'" + action + "',parametername:'" + parametername + "'}",
                contentType: "application/json",
                async: false,
                datatype: "json",
                success: function (data) {
                    $('#bindhtmldata').css('display', '');
                    $('#submitBtnDiv').css('display', '');

                    if (data.d[19] != "" && data.d != '[]')
                    {
                        var CurrentYear = JSON.parse(data.d[19]);
                        $('#year_self').text(CurrentYear[0].year_code);
                        $('#th4').html(CurrentYear[0].plan1);
                        $('#th5').html(CurrentYear[0].plan2);
                        year_code_data = CurrentYear[0].year_code;

                    }

                    if (data.d[18] != "" && data.d != '[]')
                    {
                        var parameterdata = JSON.parse(data.d[18]);
                        if (parameterdata[0].parameter_value == 'D')
                        {
                            $('#bindhtmldata').css('display', 'none');
                            $('#submitBtnDiv').css('display', 'none');
                            bootbox.alert(parameterdata[0].disable_message);
                            return false;
                        }
                        else if (parameterdata[0].Is_Today_In_Range == 'FALSE')
                        {
                            $('#bindhtmldata').css('display', 'none');
                            $('#submitBtnDiv').css('display', 'none');
                            bootbox.alert(parameterdata[0].disable_message);
                            return false;
                        }
                    }
                    if (data.d != '' && data.d != '[]') {
                        var AWPTypeMaster = JSON.parse(data.d[0]);
                        if (AWPTypeMaster[0].personal_html != '') {
                            var html_text = '';

                            for (var i = 0; i < AWPTypeMaster.length; i++) {
                                html_text += AWPTypeMaster[i].personal_html;

                            }
                            $('#bindhtmldata').html(html_text);
                            let $target = $('#bindhtmldata');
                            let matchingDivs = $target.prevAll('div[id^="workload_header_section"]');

                            if (matchingDivs.length > 0) {
                                matchingDivs.remove();
                            }
                            populateBindHtmlData();
                        }

                    }
                    if (data.d[19] != "" && data.d != '[]') {
                        var CurrentYear = JSON.parse(data.d[19]);
                        $('#year_self').text(CurrentYear[0].year_code);
                        $('#th4').html(CurrentYear[0].plan1);
                        $('#th5').html(CurrentYear[0].plan2);

                    }
                    if (data.d[1] != "") {
                        var AWPSubTypeMaster = JSON.parse(data.d[1]);
                        for (var i = 0; i < AWPSubTypeMaster.length; i++) {
                            var html_text = '';
                            html_text = '';
                            html_text = AWPSubTypeMaster[i].awp_sub_dtl;
                            $('#awp_' + AWPSubTypeMaster[i].awp_type_code).append(html_text);
                        }
                    }
                    if (data.d[2] != "")
                    {
                        var GetAwpSubTypeWorkMasterDetails = JSON.parse(data.d[2]);
                        var checkdata = '';
                        for (var i = 0; i < GetAwpSubTypeWorkMasterDetails.length; i++) {
                            var html_text = '';
                            html_text = '';
                            html_text = GetAwpSubTypeWorkMasterDetails[i].awp_sub_dtl;
                            $('#awp_' + GetAwpSubTypeWorkMasterDetails[i].awp_type_code).append(html_text);
                        }
                    }

                    if (data.d[4] != "") {
                        var GetCourseDetailAwp = JSON.parse(data.d[4]);
                        if (GetCourseDetailAwp != null && GetCourseDetailAwp.length > 0) {
                            AddRowClick(GetCourseDetailAwp, '');

                        }
                        
                    }


                    if (data.d[6] != "") {
                        var GetAWpMainMasterDetails = JSON.parse(data.d[6]);
                        if (GetAWpMainMasterDetails != null && GetAWpMainMasterDetails.length > 0)
                        {
                            for (var i = 0; i < GetAWpMainMasterDetails.length; i++)
                            {
                                //  $('#BindPlammedOP').append('<option value=' + GetAWpMainMasterDetails[i]['awp_plan_code'] + '>' + GetAWpMainMasterDetails[i]['awp_plan_name'] + ' ' + '( ' + GetAWpMainMasterDetails[i]['aws_desc'] + ' )' + '</option>')
                            }

                        }
                    }

                    if (data.d[7] != "") {
                        var GetAWPCpopSuperviserDetails = JSON.parse(data.d[7]);
                        if (GetAWPCpopSuperviserDetails != null && GetAWPCpopSuperviserDetails.length > 0) {
                            var supervisor_name = GetAWPCpopSuperviserDetails[0]['supervisor_name'] || '';
                            var designation = GetAWPCpopSuperviserDetails[0]['designation'] || '';
                            var department = GetAWPCpopSuperviserDetails[0]['department'] || '';
                            var email = GetAWPCpopSuperviserDetails[0]['email'] || '';
                            var contact = GetAWPCpopSuperviserDetails[0]['contact'] || '';

                            $('#txt_name').text(supervisor_name);
                            $('#txt_designation').text(designation);
                            $('#txt_faculty').text(department);
                            $('#txt_name').text(supervisor_name);
                            $('#txt_email').text(email);
                            $('#txt_mobile').text(contact);

                        }
                    }

                    if (data.d[9] != "") {
                        GetAWPStandardInstitutionalHour = JSON.parse(data.d[9]);
                    }

                    if (data.d[8] != "") {
                        GetAwpSubTypeWorkMasterDetailsDtl = JSON.parse(data.d[8]);

                        // AddRowClick('', GetAwpSubTypeWorkMasterDetailsDtl);
                    }


                    if (data.d[17] != "") {
                        var GetAwpRationaleData = JSON.parse(data.d[17]);
                        if (GetAwpRationaleData && GetAwpRationaleData.length > 0) {
                            GetAwpRationaleData_dtl = GetAwpRationaleData;
                        }
                    }

                    if (data.d[10] != "") {
                        var GetAwpotherDetailsDtl = JSON.parse(data.d[10]);
                        if (GetAwpotherDetailsDtl != null && GetAwpotherDetailsDtl.length > 0) {
                            for (var t = 0; t < GetAwpotherDetailsDtl.length; t++) {
                                var parentId = GetAwpotherDetailsDtl[t]["work_type_code"];
                                var subtype = GetAwpotherDetailsDtl[t]["SubType"];
                                var deptcode = GetAwpotherDetailsDtl[t]["awp_hour_code"];
                                var Totalhrs = GetAwpotherDetailsDtl[t]["TotalHours"];
                                var hours_1 = GetAwpotherDetailsDtl[t]["Proposed_jun_dec"];
                                var hours_2 = GetAwpotherDetailsDtl[t]["Proposed_jan_jun"];
                                if (['TYPE001', 'TYPE002', 'TYPE003'].includes(parentId)) {

                                    var result = alasql('SELECT * FROM ? WHERE work_type_code = ?', [GetAwpSubTypeWorkMasterDetailsDtl, parentId]);

                                    if (result && result.length > 0) {
                                        var dropdown = '';
                                        for (var i = 0; i < result.length; i++) {
                                            dropdown += `<option value="${result[i]['sub_work_code']}">${result[i]['sub_work_name']}</option>`;
                                        }
                                        AddRowClick_select_data(GetAwpSubTypeWorkMasterDetailsDtl, dropdown, parentId, subtype, deptcode, Totalhrs, hours_1, hours_2);
                                        hideandshowdropdown();
                                    }
                                }
                            }
                        }
                        
                    }

                    if (data.d[11] != "") {
                        var GetAwpSaveDataStatusDetails = JSON.parse(data.d[11]);
                        if (GetAwpSaveDataStatusDetails != null && GetAwpSaveDataStatusDetails.length > 0)
                        {
                            var result = '';
                            if (parametername == 'Proposed_Planned')
                            {
                                result = alasql('SELECT * FROM ? WHERE awp_plan_code = ?', [GetAwpSaveDataStatusDetails, 'PLA001']);
                            }
                            else if (parametername == 'Actual_June_to_Dec') {
                                result = alasql('SELECT * FROM ? WHERE awp_plan_code = ?', [GetAwpSaveDataStatusDetails, 'ACT001']);
                            }
                            else if (parametername == 'Actual_Jan_to_June') {
                                result = alasql('SELECT * FROM ? WHERE awp_plan_code = ?', [GetAwpSaveDataStatusDetails, 'ACT002']);
                            }
                            
                            if (result != '')
                            {                           
                                if ($('#hdnusertype').val() == 'I2' && result[0].faculty_status == 'Y')
                                {
                                    $('#submitBtnDiv').css('display', 'none');
                                    $('#statusrow').css('display', '');
                                    $('#pdfbtn').css('display', 'block');
                                    $('.btnclick').css('display', 'none');
                                    $('#pdfbtn_submit').css('display', 'block');
                                }
                                else {
                                    $('#submitBtnDiv').css('display', '');
                                    $('#statusrow').css('display', 'none');
                                    $('#pdfbtn').css('display', 'none');
                                    $('#pdfbtn_submit').css('display', 'none');
                                }
                            }
                        }

                    }

                    if (data.d[12] != "") {
                        var GetAwptypologywisecontacthrsDetails = JSON.parse(data.d[12]);
                        if (GetAwptypologywisecontacthrsDetails != null && GetAwptypologywisecontacthrsDetails.length > 0) {
                            typologywisecontacthrs = GetAwptypologywisecontacthrsDetails;
                        }

                    }

                    if (data.d[13] != "") {
                        var GetAwpTypeMasterData = JSON.parse(data.d[13]);
                        if (GetAwpTypeMasterData != null && GetAwpTypeMasterData.length > 0) {
                             GetAwpTypeMasterData_master = GetAwpTypeMasterData;
                        }

                    }

                    if (data.d[15] != "") {
                        var GetAwpPlaneCreditdtl = JSON.parse(data.d[15]);
                        if (GetAwpPlaneCreditdtl != null && GetAwpPlaneCreditdtl.length > 0) {
                            
                            $('#td3').text(GetAwpPlaneCreditdtl[0]["total_hours"]);
                            $('#td4').text(GetAwpPlaneCreditdtl[0]["plan_one"]);
                            $('#td5').text(GetAwpPlaneCreditdtl[0]["plan_two"]);
                            var GetAWPBenchTimesaveData = JSON.parse(data.d[16]);
                            if (GetAWPBenchTimesaveData == null)
                            {
                                var row = $("tr.subchild-row[data-parent='S010']");
                                row.find("label.total-hours").text(GetAwpPlaneCreditdtl[0]["bench_hours"].toString().replace("-", ""));
                                row.find("input.hours").eq(0).val(GetAwpPlaneCreditdtl[0]["bench_hours"] / 2);
                                row.find("input.hours").eq(1).val(GetAwpPlaneCreditdtl[0]["bench_hours"] / 2);
                            }
                            

                        }

                    }

                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }

        function AddRowClick(RowCourseDetails, GetAwpSubTypeWorkMaster) {
            if (RowCourseDetails.length > 0) {
                //for (var i = 0; i < RowCourseDetails.length; i++) {
                for (var i = RowCourseDetails.length - 1; i >= 0; i--) {
                    var parentId = RowCourseDetails[i]['SubType'];
                    var courseName = RowCourseDetails[i]['CourseFullName'] || '';
                    var tutorType = '';//RowCourseDetails[i]['TutorType'] || '';
                    var totalHours = RowCourseDetails[i]['TotalHours'] || '0.00';
                    var hours1 = RowCourseDetails[i]['Proposed_jun_dec'] || '';
                    var hours2 = RowCourseDetails[i]['Proposed_jan_jun'] || '';
                    var remark1 = RowCourseDetails[i]['remarks_note_jun_dec'] || '';
                    var remark2 = RowCourseDetails[i]['remarks_note_jan_jun'] || '';

                    if (parentId == 'S005') {

                        var subChildRow = `
       <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;"><div style="display: flex;flex-wrap: nowrap;max-width: 100%;gap: 5px;">
        
 <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;" name="Description">${courseName}</textarea>
        

        
<label class="form-control total-hours" placeholder="Total Hours"
             style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;">${totalHours}</label>

<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours" 
            value="${hours1}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)'  style="display: inline-block; margin-right: 5px;" />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours"
            value="${hours2}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)' style=" display: inline-block; margin-right: 5px;" />

 
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
        <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div>
    </td>
</tr>`;
                        $('#' + RowCourseDetails[i]['SubType']).after(subChildRow);
                    }
                    else {
                        var subChildRow = `
         <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;"><div style="display: flex;flex-wrap: nowrap;max-width: 100%;gap: 5px;">
        
 <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;" name="Description">${courseName}</textarea>
        

        <label class="form-control total-hours" placeholder="Total Hours"
             style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;">${totalHours}</label>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours" 
            value="${hours1}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)'  style="display: inline-block; margin-right: 5px;" />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours"
            value="${hours2}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)' style=" display: inline-block; margin-right: 5px;" />

 
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
        <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div>
    </td>
</tr>`;
                        $('#' + RowCourseDetails[i]['SubType']).after(subChildRow);

                        if (parentId == 'S010' || parentId == 'S011' || parentId == 'S013' || parentId == 'S014' || parentId == 'S012') {
                            var allSubRows = $(`tr[data-parent='${parentId}']`);
                            allSubRows.find('.remove-subrow').show();
                            allSubRows.first().find('.remove-subrow').hide();
                            if (parentId == 'S013') {
                                //allSubRows.second().find('.remove-subrow').hide();
                                allSubRows.eq(1).find('.remove-subrow').hide();
                            }


                        }
                    }
                }
            }
            if (GetAwpSubTypeWorkMaster.length > 0) {
                for (var i = 0; i < GetAwpSubTypeWorkMaster.length; i++) {
                    var result = alasql('SELECT * FROM ? WHERE sub_work_code = ?', [GetAWPStandardInstitutionalHour, GetAwpSubTypeWorkMaster[i]['sub_work_code']]);
                    var BindDropdownDtl = '';
                    if (result.length > 0) {
                        for (var k = 0; k < result.length; k++) {
                            BindDropdownDtl += result[k]['BindDropDown'];
                        }

                    }
                    var parentId = GetAwpSubTypeWorkMaster[i]['sub_work_code'] + '_' + GetAwpSubTypeWorkMaster[i]['sub_order_no'];
                    var courseName = GetAwpSubTypeWorkMaster[i]['sub_work_name'] || '';
                    var tutorType = '';
                    var totalHours = '0.00';
                    var hours1 = '';
                    var hours2 = '';
                    var subChildRow = '';
                    subChildRow = `
       <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;">
<div style="display: flex; flex-wrap: nowrap; max-width: 100%; gap: 5px; align-items: flex-start;">
        <div style="gap: 5px;">
        <textarea class="form-control" placeholder="Description" style="flex: 0 0 60%; height: 30px;" name="Description">${courseName}</textarea>
        
        <select class="form-control selectdataforhours" style="flex: 0 0 40%;height: 30px;">
            <option value="">-- Please Select Option --</option>
            ${BindDropdownDtl}
        </select>
</div>
        
</label class="form-control total-hours" name="TotalHours" placeholder="Total Hours"
           style="flex: 3 -1 -2%; height: 30px;">${totalHours}</label>
<div class="hours-remark-group" style=" flex-direction: column; flex: 0 0 21%; gap: 5px;">
        <input type="text" class="form-control hours" name="Hourse1" placeholder="Hours"
            value="${hours1}" style=" display: inline-block; margin-right: 5px;" />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style=" flex-direction: column; flex: 0 0 21%; gap: 5px;">
        <input type="text" class="form-control hours" name="Hourse2" placeholder="Hours"
            value="${hours2}" style="display: inline-block; margin-right: 5px;" />
         
         <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
        <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div>
    </td>
</tr>`;
                    $('#' + GetAwpSubTypeWorkMaster[i]['work_type_code']).after(subChildRow);
                }
            }
        }

        $(document).on('click', '.btnclick', function () {
            addrowstatus = 'Y';
            $('#btnsave').click();
            var parentRow = $(this).closest('tr');
            let parentId = '';
            let $prevRow = $(this).closest('tr').prev();
            if ($prevRow.is('[data-parent]')) {
                parentId = $prevRow.attr('data-parent');
            } else if ($prevRow.is('[id]')) {
                parentId = $prevRow.attr('id');
            }

            var parentTable = $(this).closest('table');
            var tableId = parentTable.attr('id');
            var dropdown = '';
            if (tableId == 'awp_T001') {
                addRow(parentId, parentRow, tableId);
            }
            else if (parentId == 'TYPE001') {
                var typeselectedData = [];
                $('#TYPE001').nextUntil('tr[id^="TYPE"]', '.subchild-row').each(function () {
                    var coursenameVal = $(this).find('.coursename').val();
                    var hoursVal = $(this).find('.selectdataforhours').val();
                    if (coursenameVal) {
                        typeselectedData.push(coursenameVal);
                    }

                });
                dropdown = '';
                var result1 = '';
                var result = alasql('SELECT * FROM ? WHERE work_type_code = ?', [GetAwpSubTypeWorkMasterDetailsDtl, 'TYPE001']);
                if (typeselectedData.length > 0) {
                    var placeholders = typeselectedData.map(() => '?').join(',');
                    var sql = 'SELECT * FROM ? WHERE work_type_code = ? AND sub_work_code IN (' + placeholders + ')';
                    result1 = alasql(sql, [GetAwpSubTypeWorkMasterDetailsDtl, 'TYPE001', ...typeselectedData]);

                }

                if (result != null) {
                    for (var i = 0; i < result.length; i++) {
                        dropdown += `<option value ="${result[i]['sub_work_code']}">${result[i]['sub_work_name']}</option>`
                    }

                    AddRowClick_data(GetAwpSubTypeWorkMasterDetailsDtl, dropdown, 'TYPE001');
                    hideandshowdropdown();

                }
            }
            else if (parentId == 'TYPE002') {

                var typeselectedData = [];
                $('#TYPE002').nextUntil('tr[id^="TYPE"]', '.subchild-row').each(function () {
                    var coursenameVal = $(this).find('.coursename').val();
                    var hoursVal = $(this).find('.selectdataforhours').val();
                    if (coursenameVal) {
                        typeselectedData.push(coursenameVal);
                    }

                });
                dropdown = '';
                var result = alasql('SELECT * FROM ? WHERE work_type_code = ?', [GetAwpSubTypeWorkMasterDetailsDtl, 'TYPE002']);
                if (typeselectedData.length > 0) {
                    var placeholders = typeselectedData.map(() => '?').join(',');
                    var sql = 'SELECT * FROM ? WHERE work_type_code = ? AND sub_work_code NOT IN (' + placeholders + ')';

                }

                if (result != null) {
                    for (var i = 0; i < result.length; i++) {
                        dropdown += `<option value ="${result[i]['sub_work_code']}">${result[i]['sub_work_name']}</option>`
                    }
                    AddRowClick_data(GetAwpSubTypeWorkMasterDetailsDtl, dropdown, 'TYPE002');
                    hideandshowdropdown();
                }


            }
            else if (parentId == 'TYPE003') {
                var typeselectedData = [];
                $('#TYPE003').nextUntil('tr[id^="TYPE"]', '.subchild-row').each(function () {
                    var coursenameVal = $(this).find('.coursename').val();
                    var hoursVal = $(this).find('.selectdataforhours').val();
                    if (coursenameVal) {
                        typeselectedData.push(coursenameVal);
                    }

                });
                dropdown = '';
                var result = alasql('SELECT * FROM ? WHERE work_type_code = ?', [GetAwpSubTypeWorkMasterDetailsDtl, 'TYPE003']);
                if (typeselectedData.length > 0) {
                    var placeholders = typeselectedData.map(() => '?').join(',');
                    var sql = 'SELECT * FROM ? WHERE work_type_code = ? AND sub_work_code NOT IN (' + placeholders + ')';

                }

                if (result != null) {
                    for (var i = 0; i < result.length; i++) {
                        dropdown += `<option value ="${result[i]['sub_work_code']}">${result[i]['sub_work_name']}</option>`
                    }
                    AddRowClick_data(GetAwpSubTypeWorkMasterDetailsDtl, dropdown, 'TYPE003');
                    hideandshowdropdown();

                }
            }
            else { addRow(parentId, parentRow, tableId); }

            if ($('#BindPlammedOP').val() == 'ActualJuneToDec' || $('#BindPlammedOP').val() == 'ActualJanToJune') {
                $('table tr').each(function () {
                    $(this).find('.hours').first().prop('disabled', true);
                });
            }
            return false;
        });
        let isBootboxOpen = false;

        $(document).on('click', '.remove-subrow', function (e) {
            e.preventDefault();

            if (isBootboxOpen) return;
            isBootboxOpen = true;

            const $row = $(this).closest('tr');

            bootbox.confirm({
                title: "Confirm Deletion",
                message: "Are you sure you want to delete this row?",
                buttons: {
                    confirm: {
                        label: 'Yes',
                        className: 'btn-danger'
                    },
                    cancel: {
                        label: 'No',
                        className: 'btn-secondary'
                    }
                },
                callback: function (result) {
                    if (result) {
                        $row.remove();
                        totalhoursCalculation();
                    }
                    isBootboxOpen = false; // Reset the lock after dialog is closed
                }
            });
        });


        function addRow(parentId, parentRow, tableId) {
            var setdropdown = '';
            if (tableId == 'awp_T001') {

                setdropdown = `<option value="">Please Select Tutor</option>
                    <option value="Single">Single</option>
                    <option value="Dual">Dual</option>
                    <option value="Multiple">Multiple</option>`;


                var subRow = `
        <tr class="subchild-row" data-parent="${parentId}">
            <td colspan="5" style="padding-left: 40px;">
                <div style="display: flex; flex-wrap: nowrap; max-width: 100%;gap: 5px;">`;
                if (parentId == 'S001') {
                    subRow += ` <div style="gap: 5px;"><textarea class="form-control" placeholder="Description" style=" width:40.5%;display: inline-block; margin-right: 5px;"></textarea> <select class="form-control selecttutor" style=" display: inline-block; margin-right: 5px;">
                    ${setdropdown}
                </select></div>

<label class="form-control total-hours" placeholder="TotalHours" style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;" name="TotalHours"></label>
`;
                }
                else {
                    subRow += ` <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;display: inline-block; margin-right: 5px;" name="Description"></textarea>

<label class="form-control total-hours" placeholder="TotalHours" style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;" name="TotalHours"></label>
`;
                }

                subRow += `
            
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style="display: inline-block; margin-right: 5px;" name="Hours1" />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1"></textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style=" display: inline-block; margin-right: 5px;" name="Hours2" />
                
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2"></textarea>
</div>
                <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div>
            </td></tr>`;

                // Append after last subchild
                var lastSub = $(`tr[data-parent='${parentId}']`).last();
                if (lastSub.length > 0) {
                    lastSub.after(subRow);
                } else {
                    parentRow.before(subRow);
                }
            }
            if (tableId == 'awp_T004') {

                setdropdown = `<option value="">Please Select Tutor</option>
                    <option value="Single">Single</option>
                    <option value="Dual">Dual</option>
                    <option value="Multiple">Multiple</option>`;

                if (parentId == 'S005' || parentId == 'S006' || parentId == 'S007' || parentId == 'S008' || parentId == 'S009') {
                    var subRow = `
        <tr class="subchild-row" data-parent="${parentId}">
            <td colspan="5" style="padding-left: 40px;">
                <div style="display: flex; flex-wrap: nowrap; max-width: 100%;gap: 5px;">
                
                <textarea class="form-control" placeholder="Description"  style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;"></textarea>
              
<label class="form-control total-hours" placeholder="Total Hours" style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;"></label>

<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style=" display: inline-block; margin-right: 5px;" name="Hours1" />
  <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark1"></textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style=" display: inline-block; margin-right: 5px;" name="Hours2" />
              
                <textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark2"></textarea>
</div>
               <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div>
            </td></tr>`;

                    // Append after last subchild
                    var lastSub = $(`tr[data-parent='${parentId}']`).last();
                    if (lastSub.length > 0) {
                        lastSub.after(subRow);
                    } else {
                        parentRow.before(subRow);
                    }

                }
                else {
                    var subRow = `
        <tr class="subchild-row" data-parent="${parentId}">
            <td colspan="5" style="padding-left: 40px;">
                <div style="display: flex; flex-wrap: nowrap; max-width: 100%;gap: 5px;">
                
                <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;"></textarea>
                    <select class="form-control" style=" display: inline-block; margin-right: 5px;">
                    ${setdropdown}
                </select>
              <label class="form-control total-hours" placeholder="Total Hours" style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;"></label>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style=" display: inline-block; margin-right: 5px;" name="Hours1" />
 <textarea class="form-control remark" placeholder="Remark" style=" display: inline-block; margin-right: 5px;" name="remark1"></textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style=" display: inline-block; margin-right: 5px;" name="Hours2" />
               
                <textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark2"></textarea>
</div>
               <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div>
            </td></tr>`;

                    // Append after last subchild
                    var lastSub = $(`tr[data-parent='${parentId}']`).last();
                    if (lastSub.length > 0) {
                        lastSub.after(subRow);
                    } else {
                        parentRow.before(subRow);
                    }
                }

            }
            if (tableId == 'awp_T005') {

                setdropdown = `<option value="">Please Select Tutor</option>
                    <option value="Single">Single</option>
                    <option value="Dual">Dual</option>
                    <option value="Multiple">Multiple</option>`;


                var subRow = `
        <tr class="subchild-row" data-parent="${parentId}">
            <td colspan="5" style="padding-left: 40px;">
                <div style="display: flex; flex-wrap: nowrap;max-width: 100%;gap: 5px;"><textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;"></textarea>`;

                subRow += `
          <label class="form-control total-hours" placeholder="Total Hours" style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;"></label>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style=" display: inline-block; margin-right: 5px;" name="Hours1" />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1"></textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
<input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style=" display: inline-block; margin-right: 5px;" name="Hours2" />
                
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2"></textarea>
</div>
                <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button>
</div>
            </td></tr>`;

                // Append after last subchild
                var lastSub = $(`tr[data-parent='${parentId}']`).last();
                if (lastSub.length > 0) {
                    lastSub.after(subRow);
                } else {
                    parentRow.before(subRow);
                }
            }

            if (tableId == 'awp_T006') {

                var subRow = `
        <tr class="subchild-row" data-parent="${parentId}">
            <td colspan="5" style="padding-left: 40px;">
                <div style="display: flex; flex-wrap: nowrap; max-width: 100%;gap: 5px;">
                <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;"></textarea>`;

                subRow += `
                <label class="form-control total-hours" placeholder="Total Hours" style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;"></label>
                <div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style="display: inline-block; margin-right: 5px; " name="Hours1" />
                <textarea class="form-control remark" placeholder="Remark" style="display: inline-block; margin-right: 5px; max-width:100%;" name="remark1"></textarea>
                </div>
                <div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}" ,this)' placeholder="Hours" style="display: inline-block; margin-right: 5px; " name="Hours2" />
                <textarea class="form-control remark" placeholder="Remark" style="display: inline-block; margin-right: 5px; max-width:100%;" name="remark2"></textarea>
                </div>
                <button type="button" class="btn btn-danger btn-sm remove-subrow" style="border-radius: 6px;"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="margin-top: 50%;"></i></button></div></td></tr>`;

                // Append after last subchild
                var lastSub = $(`tr[data-parent='${parentId}']`).last();
                if (lastSub.length > 0) {
                    lastSub.after(subRow);
                } else {
                    parentRow.before(subRow);
                }

            }

        }

        function AddRowClick_data(GetAwpSubTypeWorkMaster, dropdown, subchildid) {
            if (GetAwpSubTypeWorkMaster.length > 0) {
                var subChildRow = '';
                subChildRow = `
       <tr class="subchild-row" data-parent="${subchildid}">
    <td colspan="5" style="padding-left: 40px;"><div style="flex-wrap: nowrap;max-width: 100%;gap: 5px;">
 <div style="gap: 5px;">
        <select class="form-control coursename" style="flex: 0 0 52%;height: 30px;">
            <option value="">-- Please Select Option --</option>
            ${dropdown}
        </select>
        
        <select class="form-control selectdataforhours" style="flex: 0 0 40%; height: 30px;">
            <option value="">-- Please Select Option --</option>
        </select>
<p class="rationale-text" style="color:black;"></p>
</div>
<label class="form-control total-hours" name="TotalHours" placeholder="Total Hours"
        value="" style="flex: 3 -1 -2%;height: 30px;margin-right: 8px;"></label>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;gap: 5px;">
        <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${subchildid}" ,this)' name="Hourse1" placeholder="Hours"
        value="" style="display: inline-block; margin-right: 5px;" />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1"></textarea>
</div>
<div class="hours-remark-group" style=" flex-direction: column; flex: 0 0 21%; gap: 5px;">
        <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${subchildid}" ,this)' name="Hourse2" placeholder="Hours"
        value="" style="display: inline-block; margin-right: 5px;" />
 
                <textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark2"></textarea>
</div>
        <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div></td></tr>`;


                var lastSub = $(`tr[data-parent='${subchildid}']`).last();
                if (lastSub.length > 0) {
                    lastSub.after(subChildRow);
                }
                else {
                    //parentRow.after(subRow);
                    $('#' + subchildid).after(subChildRow);
                }
                //

            }
        }


        function AddRowClick_select_data(GetAwpSubTypeWorkMaster, dropdown, subchildid, selectedValue = '', dept_code = '', Totalhrs = '', hours_1 = '', hours_2 = '') {
            if (GetAwpSubTypeWorkMaster.length > 0) {
                var subChildRow = `
        <tr class="subchild-row" data-parent="${subchildid}">
            <td colspan="5" style="padding-left: 40px;">
<div style="flex-wrap: nowrap;max-width: 100%;gap: 5px;">
<div style="gap: 5px;">

                <select class="form-control coursename" style="flex: 0 0 52%;height: 30px;">
                    <option value="">-- Please Select Option --</option>
                    ${dropdown}
                </select>
                
                <select class="form-control selectdataforhours" style="flex: 0 0 40%; height: 30px;">
                    <option value="">-- Please Select Option --</option>
                </select>
<p class="rationale-text" style="color:black;"></p>
</div>
                <label class="form-control total-hours" name="TotalHours" placeholder="Total Hours"
        value="" style="flex: 3 -1 -2%;height: 30px;margin-right: 8px;"></label>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' 
                    onInput='edValueKeyPress("${subchildid}" ,this)' name="Hourse1" placeholder="Hours"
                    value="" style="display: inline-block; margin-right: 5px;" />
 <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark1"></textarea>
</div>
<div class="hours-remark-group" style=" flex-direction: column; flex: 0 0 21%; gap: 5px;">
                <input type="text" class="form-control hours" onkeypress='return IsNumeric_istructor(event);' 
                    onInput='edValueKeyPress("${subchildid}" ,this)' name="Hourse2" placeholder="Hours"
                    value="" style="display: inline-block; margin-right: 5px;" />
               
                <textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark2"></textarea>
</div>
                <button type="button" class="btn btn-danger btn-sm remove-subrow" style="
    border-radius: 6px;
"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="
    margin-top: 50%;
"></i></button></div>
            </td>
        </tr>`;

                $('#' + subchildid).after(subChildRow);

                // Set selected value and trigger change
                var $lastRow = $('#' + subchildid).next('.subchild-row');
                var $coursenameSelect = $lastRow.find('.coursename');
                if (selectedValue !== '') {
                    $coursenameSelect.val(selectedValue).trigger('change');
                }

                var $rationaleSelect = $lastRow.find('.rationale-text');
                var match = GetAwpRationaleData_master.find(x => x.sub_work_code === selectedValue);
                if (match) {
                    rationaleText = match.rationale || '';
                    $rationaleSelect.val(rationaleText).trigger('change');
                }




                var $datadeptcode = $lastRow.find('.selectdataforhours');
                if (dept_code !== '') {
                    $datadeptcode.val(dept_code).trigger('change');
                }


                var $datatotalhours = $lastRow.find('.total-hours');
                if (Totalhrs !== '') {
                    //$datatotalhours.val(Totalhrs);
                    $datatotalhours.text(Totalhrs);
                }

                var $datatotalhours_1 = $lastRow.find('[name="Hourse1"]');
                if (hours_1 !== '') {
                    $datatotalhours_1.val(hours_1);
                }

                var $datatotalhours_2 = $lastRow.find('[name="Hourse2"]');
                if (hours_2 !== '') {
                    $datatotalhours_2.val(hours_2);
                }
            }
        }

        $(document).on('change', '.selectdataforhours', function () {
            if (GetAWPStandardInstitutionalHour != null && GetAWPStandardInstitutionalHour.length > 0) {
                var selectedValue = $(this).val();
                var $row = $(this).closest('tr');
                var result = alasql('SELECT * FROM ? WHERE awp_hour_code = ?', [GetAWPStandardInstitutionalHour, selectedValue]);
                $row.find('input[name="TotalHours"]').val(result[0]['total_hours']);
                $row.find('input[name="Hourse1"]').val(result[0]['t1_hours']).removeClass('is-invalid');
                $row.find('input[name="Hourse2"]').val(result[0]['t2_hours']).removeClass('is-invalid');
                $(this).removeClass('is-invalid');
            }

        });
        $(document).on('change', '.coursename', function () {
            var selectedValue = $(this).val();
            var $row = $(this).closest('tr');

            var $rationaleText = $row.find('.rationale-text');
            GetAwpRationaleData_master = GetAwpRationaleData_dtl;
            var match = GetAwpRationaleData_master.find(x => x.sub_work_code === selectedValue);

            if (match && match.rationale) {
                $rationaleText.text(match.rationale);
            } else {
                $rationaleText.text(''); 
            }
            var $setDropdown = $row.find('.selectdataforhours');
            $setDropdown.empty();

            if (selectedValue === '') {
                $setDropdown.append('<option value="">-- Please Select Option --</option>');
                //return;
            }
            else {
                var result = alasql('SELECT * FROM ? WHERE sub_work_code = ?', [GetAWPStandardInstitutionalHour, selectedValue]);
                var BindDropdownDtl = '';
                if (result.length > 0) {
                    for (var k = 0; k < result.length; k++) {
                        BindDropdownDtl += result[k]['BindDropDown'];
                    }
                }
                $setDropdown.append('<option value="">-- Please Select option --</option>');
                $setDropdown.append(BindDropdownDtl);
                $setDropdown.removeClass('is-invalid');
            }
            hideandshowdropdown();


        });



        function hideandshowdropdown() {
            $('.coursename').each(function () {
                var $this = $(this);
                var currentVal = $this.val();
                $this.find('option').show();
                $('.coursename').not($this).each(function () {
                    var otherVal = $(this).val();
                    if (otherVal) {
                        $this.find(`option[value="${otherVal}"]`).hide();
                    }
                });
            });
        }

        function populateBindHtmlData() {
            var bindDiv = document.getElementById("bindhtmldata");

            // Insert header HTML before inserting data
            var bindWidth = bindDiv.offsetWidth + "px";

            var headerHTML = `

                <div class="panel panel-default" id="workload_header_section" style="
                    position: sticky;
                    top: 0;
                    background-color: white;
                    z-index: 10;
                    margin: auto;
                    margin-bottom: 20px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                ">
                
                <table class="table" style="width: 100%;border:none;text-align: center;" cellpadding="10" cellspacing="20">

                    <tr style="background-color: #f0f0f0;">
                        <th colspan="4" id="th1" style="border:none;"></th>
                        <th  id="th3" style="border:none;padding-left: 4%;text-wrap:nowrap;">As Per Plan</th>
                        <th  id="th4" style="border:none;padding-left: 4%;">Proposed M25<br><small>(Proposed/Plan for June to Dec)</small></th>
                        <th  id="th5" style="border:none;padding-right: 20px;">Proposed S26<br><small>(Proposed/Plan for Jan to June)</small></th>

                    </tr>
                    <tr>
                        <td  id="td1" style="border:none;width:25%;">Total Annual Workload</td>
                        <td  id="td3" style="border:none;padding-left: 20%;"><b>1920</b></td>
                        <td  id="td4" style="border:none;padding-left: 28%;"><b>960</b></td>
                        <td  id="td5" style="border:none;padding-left: 45%;"><b>960</b></td>

                    </tr>

            </table>

        </div>
`;

            bindDiv.insertAdjacentHTML('beforebegin', headerHTML);

        }

        function validateSubChildRows() {
            let isValid = true;

            $('.subchild-row').each(function () {
                const $row = $(this);

                $row.find('input.hours,textarea[placeholder="Description"], select').each(function () {
                    const $field = $(this);
                    const val = $field.val().trim();

                    const isNumberField = $field.hasClass('total-hours') || $field.hasClass('hours');

                    if (
                        val === '' ||
                        (isNumberField && isNaN(val))
                    ) {
                        $field.addClass('is-invalid');
                        isValid = false;
                    } else {
                        $field.removeClass('is-invalid');
                    }
                });
            });

            return isValid;
        }


        function IsNumeric_istructor(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                var dInput = this.value;
                console.log(dInput);
                return true;
            }
            else {
                return false;
            }
        }
        function edValueKeyPress(rowId, elem) {
            var $row = $(elem).closest('tr');
            var total = 0;
            if (rowId != 'S014') {
                $row.find('.hours').each(function () {
                    var val = parseFloat($(this).val());
                    if (!isNaN(val)) {
                        total += val;
                    }
                });
                //$row.find('.total-hours').val(total.toFixed(2));
                $row.find('.total-hours').text(total.toFixed(2));
                totalhoursCalculation();
            }
        }


        $(document).on('change', '.selecttutor', function () {
            var selectedValue = $(this).val();
            var $row = $(this).closest('tr');
            var $setDropdown = $row.find('.selecttutor');
            if (selectedValue == "Single") {
                selectedValue = '1';
            }
            else { selectedValue = '2'; }

            var result = alasql('SELECT * FROM ? WHERE no_of_tutor = ?', [typologywisecontacthrs, selectedValue]);
            //$(this).closest('td').find('.total-hours').val(result[0]['TotalHours']);
            $(this).closest('td').find('.total-hours').text(result[0]['TotalHours']);
            $(this).closest('td').find('input[name="Hours1"]').val(result[0]['TotalHours']);
            $(this).closest('td').find('input[name="Hours2"]').val('0');

            var $hours1 = $row.find('input[name="Hours1"]');
            var $hours2 = $row.find('input[name="Hours2"]');
            $hours1.val(result[0]['TotalHours']).removeClass('is-invalid');
            $hours2.val('0').removeClass('is-invalid');
            $(this).removeClass('is-invalid');

        });

        function getAllRowsGroupedByParent(activestatus) {
            var groupedResult = {};

            $('.subchild-row').each(function () {
                var $row = $(this);
                var parentId = $row.data('parent');
                var inputs = $row.find('.form-control');
                var description = $(inputs[0]).val() || '';
                var status_flag = activestatus;
                var tutor = '';
                if (parentId == 'TYPE001' || parentId == 'TYPE002' || parentId == 'TYPE003' || parentId == 'TYPE004') {
                    tutor = $row.find('.selectdataforhours').first().val();
                }
                else { tutor = $row.find('select').first().val(); }
                //var totalHours = $row.find('.total-hours').val() || '0';
                var totalHours = $row.find('.total-hours').text() || '0';

                var hours = [];
                $row.find('.hours').each(function () {
                    var val = parseFloat($(this).val());
                    hours.push(isNaN(val) ? 0 : val);
                });

                var remark = [];
                $row.find('.remark').each(function () {
                    var remark_val = $(this).val();
                    remark.push(remark_val);
                });

                if (!groupedResult[parentId]) {
                    groupedResult[parentId] = [];
                }

                groupedResult[parentId].push({
                    description: description,
                    tutor: tutor,
                    totalHours: totalHours,
                    hours: hours,
                    remark: remark
                });
            });
            var finalResult = [];
            $.each(groupedResult, function (parentId, items) {
                items.forEach(function (item, index) {
                    finalResult.push({
                        parentId: parentId,
                        sr_no: index + 1,
                        description: item.description,
                        tutor: item.tutor,
                        totalHours: item.totalHours,
                        hours: item.hours,
                        remark: item.remark,
                        status_flag: activestatus
                    });
                });
            });

            return finalResult;
        }

      
        $(document).on('click', '#btnapprove', function () {
            if (validateSubChildRows()) {
                bootbox.confirm({
                    title: "Confirm Submission",
                    message: "Are you sure you want to Submit this data?",
                    buttons: {
                        confirm: {
                            label: 'Yes, Submit',
                            className: 'btn-success'
                        },
                        cancel: {
                            label: 'Cancel',
                            className: 'btn-secondary'
                        }
                    },
                    callback: function (result) {
                        if (result) {
                            datasavestatus = 'Y';
                            $('#btnsave').click();
                        }
                    }
                });
            }
            else {
                bootbox.alert("Please correct the highlighted fields.");
                return false;

            }
        });

        $(document).on('click', '#pdfbtn', function () {

            var parametername = '';
            if ($('#BindPlammedOP').val() == 'FullYear') {
                parametername = 'Proposed_Planned'; 
            }
            else if ($('#BindPlammedOP').val() == 'ActualJuneToDec') { 
                parametername = 'Actual_June_to_Dec';
            }
            else if ($('#BindPlammedOP').val() == 'ActualJanToJune') {
                parametername = 'Actual_Jan_to_June';
            }
            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/AWP_PDF_Data_New",
                data: "{user_id:'" + $('#hdnuserid').val() + "',plantype:'" + parametername + "'}",
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    if (data.d && data.d !== '[]') {
                        if (data.d == "true") 
                        {
                        const pdfUrl = window.location.origin + '/AWPPDF/' + $('#hdnuserid').val() + '_' + year_code_data + '_' + parametername + '.pdf';
                        const link = document.createElement('a');
                        link.href = pdfUrl;
                        link.download = 'AWPPDF.pdf'; 
                        link.style.display = 'none';
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);
                        }
                        else {
                           // bootbox.alert("Problem in Data");
                            return false;
                        }

                    }
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            }); 
             
        });


        $(document).on('click', '#pdfbtn_submit', function () {

            var parametername = '';
            if ($('#BindPlammedOP').val() == 'FullYear') {
                datasavestatus = 'Y';
                $('#btnsave').click();
                parametername = 'Proposed_Planned';
            }
        });


        $(document).on('click', '#btnsave', function () {
            var totalEven = 0;
            var totalOdd = 0;
            var Totalhours = [];
            for (var i = 1; i <= 10; i++) {
                totalEven = 0;
                totalOdd = 0;
                $('#T00' + i + ' table tr.subchild-row input.hours').each(function (index) {
                    var val = parseFloat($(this).val()) || 0;

                    if (index % 2 === 0) {
                        totalEven += val;
                    }
                    else {
                        totalOdd += val;
                    }
                });

                var awp_code = 'T00' + i;
                var Totalhoursarray = [];
                Totalhoursarray.push(totalEven);
                Totalhoursarray.push(totalOdd);

                Totalhours.push({ awp_type_code: awp_code, hours_Data: Totalhoursarray });
            }
            var totalhours = Totalhours;
            var resultdata = getAllRowsGroupedByParent(datasavestatus);

            var parametername = '';
            if ($('#BindPlammedOP').val() == 'FullYear') {
                parametername = 'Proposed_Planned';
            }
            else if ($('#BindPlammedOP').val() == 'ActualJuneToDec') {
                parametername = 'Actual_June_to_Dec';
            }
            else if ($('#BindPlammedOP').val() == 'ActualJanToJune') {
                parametername = 'Actual_Jan_to_June';
            }
             
            
            

            if (resultdata.length > 0)
            {
                $.each(resultdata, function (index, item)
                {
                    if (item.description) {
                        item.description = item.description.replace(/[^a-zA-Z0-9\s]/g, '');
                    }
                });

                var dataparse = JSON.stringify(resultdata);
                $.ajax({
                    type: "POST",
                    url: "../../WebService.asmx/insert_awp_data",
                    data: "{jsondata:'" + dataparse + "',totalhours:'" + JSON.stringify(totalhours) + "',status:'" + datasavestatus + "',plantype:'" + parametername + "'}",
                    contentType: "application/json",
                    dataType: "json",
                    success: function (data) {
                        if (data.d && data.d !== '[]') {
                            if (data.d == true) {
                                if (addrowstatus == 'N') {
                                    bootbox.alert("Data Save Successfully");
                                    return false;
                                }
                                else {
                                    addrowstatus = 'N';
                                    return false;
                                }

                            }
                            else if (data.d == 'Submit') {
                                if (addrowstatus == 'N') {

                                    $('#submitBtnDiv').css('display', 'none');
                                    bootbox.alert("Data Submitted Successfully");
                                    return false;
                                }
                                else {
                                    addrowstatus = 'N';
                                    return false;
                                }
                            }
                            else {
                                bootbox.alert("Problem in Data");
                                return false;
                            }

                        }
                    },
                    error: function (xhr, status, error) {
                        alert("Error: " + error);
                    }
                });
            }
        });

        function totalhoursCalculation() {
            var totalEven = 0;
            var totalOdd = 0;
            var Totalhours = [];
            for (var i = 1; i <= 10; i++) {
                totalEven = 0;
                totalOdd = 0;
                $('#T00' + i + ' table tr.subchild-row input.hours').each(function (index) {
                    var val = parseFloat($(this).val()) || 0;

                    if (index % 2 === 0) {
                        totalEven += val;
                    }
                    else {
                        totalOdd += val;
                    }
                });

                var awp_code = 'T00' + i;
                var Totalhoursarray = [];
                Totalhoursarray.push(totalEven);
                Totalhoursarray.push(totalOdd);

                Totalhours.push({ awp_type_code: awp_code, hours_Data: Totalhoursarray });
            }
            if (Totalhours.length > 0) {
                var totalhourstT1ToT4 = '0';
                var totalhourstT1ToT4_h1 = '0';
                var totalhourstT1ToT4_h2 = '0';

                var totalhourstT1ToT6 = '0';
                var totalhourstT1ToT6_h1 = '0';
                var totalhourstT1ToT6_h2 = '0';

                for (var p = 0; p < Totalhours.length; p++) {
                    if (Totalhours[p].awp_type_code == 'T001' || Totalhours[p].awp_type_code == 'T002' || Totalhours[p].awp_type_code == 'T003' || Totalhours[p].awp_type_code == 'T004') {
                        totalhourstT1ToT4 = parseFloat(totalhourstT1ToT4 + (Totalhours[p].hours_Data[0] + Totalhours[p].hours_Data[1]));
                        totalhourstT1ToT4_h1 = parseFloat(totalhourstT1ToT4_h1 + Totalhours[p].hours_Data[0]);
                        totalhourstT1ToT4_h2 = parseFloat(totalhourstT1ToT4_h2 + Totalhours[p].hours_Data[1]);

                        //$('#total_' + Totalhours[p].awp_type_code).text(Totalhours[p].hours_Data[0] + Totalhours[p].hours_Data[1]);
                        //$('#hours1_' + Totalhours[p].awp_type_code).text(Totalhours[p].hours_Data[0]);
                        //$('#hours2_' + Totalhours[p].awp_type_code).text(Totalhours[p].hours_Data[1]);

                        let h0 = parseFloat(Totalhours[p].hours_Data[0] || 0);
                        let h1 = parseFloat(Totalhours[p].hours_Data[1] || 0);

                        $('#total_' + Totalhours[p].awp_type_code).text((h0 + h1).toFixed(2));
                        $('#hours1_' + Totalhours[p].awp_type_code).text(h0.toFixed(2));
                        $('#hours2_' + Totalhours[p].awp_type_code).text(h1.toFixed(2));
                    }
                    else if (Totalhours[p].awp_type_code == 'T005') {
                        //$('#total_' + Totalhours[p].awp_type_code).text(totalhourstT1ToT4);
                        //$('#hours1_' + Totalhours[p].awp_type_code).text(totalhourstT1ToT4_h1);
                        //$('#hours2_' + Totalhours[p].awp_type_code).text(totalhourstT1ToT4_h2);

                        $('#total_' + Totalhours[p].awp_type_code).text(parseFloat(totalhourstT1ToT4 || 0).toFixed(2));
                        $('#hours1_' + Totalhours[p].awp_type_code).text(parseFloat(totalhourstT1ToT4_h1 || 0).toFixed(2));
                        $('#hours2_' + Totalhours[p].awp_type_code).text(parseFloat(totalhourstT1ToT4_h2 || 0).toFixed(2));

                        var banchtotalhours = 0;
                        var banchtotalhours_1 = 0;
                        var banchtotalhours_2 = 0;
                        $('tr.subchild-row[data-parent="S010"]').each(function () {

                            banchtotalhours_1 = $(this).find('input.hours').eq(0).val();
                            banchtotalhours_2 = $(this).find('input.hours').eq(1).val();
                            banchtotalhours = $(this).find('.total-hours').text();
                            console.log(banchtotalhours_1);
                            let hours1 = parseFloat(banchtotalhours_1) || 0;
                            let hours2 = parseFloat(banchtotalhours_2) || 0;
                            totalhourstT1ToT4_h1 += hours1;
                            totalhourstT1ToT4_h2 += hours2;
                            totalhourstT1ToT4 += hours1 + hours2;

                        });

                        $('tr.subchild-row[data-parent="S012"]').each(function () {

                            banchtotalhours_1 = $(this).find('input.hours').eq(0).val();
                            banchtotalhours_2 = $(this).find('input.hours').eq(1).val();
                            banchtotalhours = $(this).find('.total-hours').text();
                            console.log(banchtotalhours_1);
                            let hours1 = parseFloat(banchtotalhours_1) || 0;
                            let hours2 = parseFloat(banchtotalhours_2) || 0;
                            totalhourstT1ToT4_h1 += hours1;
                            totalhourstT1ToT4_h2 += hours2;
                            totalhourstT1ToT4 += hours1 + hours2;

                        });


                        $('tr.subchild-row[data-parent="S011"]').each(function ()
                        {
                            var remainingH1_ = ($('#td4').text() - totalhourstT1ToT4_h1);
                            var remainingH2_ = ($('#td5').text() - totalhourstT1ToT4_h2);
                            var remainingTotal_ = ($('#td3').text() - totalhourstT1ToT4);


                            
                            $(this).find('input.hours').eq(0).val(($('#td4').text() - totalhourstT1ToT4_h1).toString().replace("-", ""));
                            $(this).find('input.hours').eq(1).val(($('#td5').text() - totalhourstT1ToT4_h2).toString().replace("-", ""));
                            $(this).find('.total-hours').text(($('#td3').text() - totalhourstT1ToT4).toString().replace("-", ""));

                            if (remainingTotal_ < 0)
                            {
                                console.log(remainingTotal_);
                                $(this).find('.total-hours').css("color", "red");
                            }

                            if (remainingH1_ < 0) {
                                $(this).find("input.hours").eq(0).css("color", "red");
                            }
                            if (remainingH2_ < 0) {
                                $(this).find("input.hours").eq(1).css("color", "red");
                            }
                        });

                        //$('tr.subchild-row[data-parent="S012"]').each(function () {
                        //    var remainingH1_ = ($('#td4').text() - totalhourstT1ToT4_h1);
                        //    var remainingH2_ = ($('#td5').text() - totalhourstT1ToT4_h2);
                        //    var remainingTotal_ = ($('#td3').text() - totalhourstT1ToT4);
                        //    $(this).find('input.hours').eq(0).val(($('#td4').text() - totalhourstT1ToT4_h1).toString().replace("-", ""));
                        //    $(this).find('input.hours').eq(1).val(($('#td5').text() - totalhourstT1ToT4_h2).toString().replace("-", ""));
                        //    $(this).find('.total-hours').text(($('#td3').text() - totalhourstT1ToT4).toString().replace("-", ""));
                        //
                        //    if (remainingTotal_ < 0) {
                        //        console.log(remainingTotal_);
                        //        $(this).find('.total-hours').css("color", "red");
                        //    }
                        //
                        //    if (remainingH1_ < 0) {
                        //        $(this).find("input.hours").eq(0).css("color", "red");
                        //    }
                        //    if (remainingH2_ < 0) {
                        //        $(this).find("input.hours").eq(1).css("color", "red");
                        //    }
                        //});


                        totalhourstT1ToT4 = 0;
                        totalhourstT1ToT4_h1 = 0;
                        totalhourstT1ToT4_h2 = 0;

                        totalhourstT1ToT6 = Totalhours[p].hours_Data[0] + Totalhours[p].hours_Data[1];
                        totalhourstT1ToT6_h1 = Totalhours[p].hours_Data[0];
                        totalhourstT1ToT6_h2 = Totalhours[p].hours_Data[1];
                    }
                    else if (Totalhours[p].awp_type_code == 'T006')
                    {
                        //$('#total_' + Totalhours[p].awp_type_code).text($('#td3').text() - $('#total_T005').text());
                        //$('#hours1_' + Totalhours[p].awp_type_code).text($('#td4').text() - $('#hours1_T005').text());
                        //$('#hours2_' + Totalhours[p].awp_type_code).text($('#td5').text() - $('#hours2_T005').text());
                        let total = (parseFloat($('#td3').text()) || 0) - (parseFloat($('#total_T005').text()) || 0);
                        let hours1 = (parseFloat($('#td4').text()) || 0) - (parseFloat($('#hours1_T005').text()) || 0);
                        let hours2 = (parseFloat($('#td5').text()) || 0) - (parseFloat($('#hours2_T005').text()) || 0);

                        $('#total_' + Totalhours[p].awp_type_code).text(total.toFixed(2));
                        $('#hours1_' + Totalhours[p].awp_type_code).text(hours1.toFixed(2));
                        $('#hours2_' + Totalhours[p].awp_type_code).text(hours2.toFixed(2));


                        var SumTotalUnallocated_h1 = 0;
                        var SumTotalUnallocated_h2 = 0;
                        $("tr.subchild-row[data-parent='S013']").each(function ()
                        {
                            var h1 = parseFloat($(this).find("input.hours").eq(0).val()) || 0;
                            var h2 = parseFloat($(this).find("input.hours").eq(1).val()) || 0;
                            SumTotalUnallocated_h1 = SumTotalUnallocated_h1 + h1;
                            SumTotalUnallocated_h2 = SumTotalUnallocated_h2 + h2;

                        });
                        console.log(SumTotalUnallocated_h1);
                        var row = $("tr.subchild-row[data-parent='S014']");
                        //var remainingTotal = totalhourstT1ToT6 - (SumTotalUnallocated_h1 + SumTotalUnallocated_h2);
                        //var remainingH1 = totalhourstT1ToT6_h1 - SumTotalUnallocated_h1;
                        //var remainingH2 = totalhourstT1ToT6_h2 - SumTotalUnallocated_h2;

                        var remainingTotal = $('#total_T006').text() - (SumTotalUnallocated_h1 + SumTotalUnallocated_h2);
                        var remainingH1 = $('#hours1_T006').text() - SumTotalUnallocated_h1;
                        var remainingH2 = $('#hours2_T006').text() - SumTotalUnallocated_h2;


                        row.find("label.total-hours").text(remainingTotal);
                        row.find("input.hours").eq(0).val(remainingH1.toString());
                        //row.find("input.hours").eq(1).val(remainingH2.toString().replace("-", ""));
                        row.find("input.hours").eq(1).val(remainingH2.toString());
                        if (remainingTotal < 0)
                        {
                            //row.find("label.total-hours").text(remainingTotal.toString().replace("-", ""));
                            row.find("label.total-hours").css("color", "red");
                        }
                        else
                        {
                            row.find("label.total-hours").css("color", "black");
                        }
                        //row.find("input.hours").eq(0).val(remainingH1.toString().replace("-", ""));
                        if (remainingH1 < 0) {
                            row.find("input.hours").eq(0).css("color", "red");
                        }
                        else {
                            row.find("input.hours").eq(0).css("color", "black");
                        }
                        
                        
                        //row.find("input.hours").eq(1).val(remainingH2.toString().replace("-", ""));
                        if (remainingH2 < 0) {
                            row.find("input.hours").eq(1).css("color", "red");
                        }
                        else {
                            row.find("input.hours").eq(1).css("color", "black"); 
                        }
                        remainingTotal = 0;
                        remainingH1 = 0;
                        remainingH2 = 0;
                        SumTotalUnallocated = 0;
                        SumTotalUnallocated_h1 = 0;
                        SumTotalUnallocated_h2 = 0;
                    }
                    else {
                        //$('#total_' + Totalhours[p].awp_type_code).text(Totalhours[p].hours_Data[0] + Totalhours[p].hours_Data[1]);
                        //$('#hours1_' + Totalhours[p].awp_type_code).text(Totalhours[p].hours_Data[0]);
                        //$('#hours2_' + Totalhours[p].awp_type_code).text(Totalhours[p].hours_Data[1]);

                        let h0 = parseFloat(Totalhours[p].hours_Data[0] || 0);
                        let h1 = parseFloat(Totalhours[p].hours_Data[1] || 0);

                        $('#total_' + Totalhours[p].awp_type_code).text((h0 + h1).toFixed(2));
                        $('#hours1_' + Totalhours[p].awp_type_code).text(h0.toFixed(2));
                        $('#hours2_' + Totalhours[p].awp_type_code).text(h1.toFixed(2));

                    }

                }

            }
        }

        function AddRowClick_DefaultRow(parentId) {
            var parentId = parentId;
            var courseName = '';
            var tutorType = '';
            var totalHours = '0.00';
            var hours1 = '';
            var hours2 = '';
            var remark1 = '';
            var remark2 = '';

            if (parentId == 'S010' && $(`tr[data-parent="${parentId}"]`).length == 0) {

                var subChildRow = `
       <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;"><div style="display: flex;flex-wrap: nowrap;max-width: 100%;gap: 5px;">
        
 <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;" name="Description">${courseName}</textarea>
        

        
<label class="form-control total-hours" placeholder="Total Hours"
             style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;">${totalHours}</label>

<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours" 
            value="${hours1}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)'  style="display: inline-block; margin-right: 5px;" disabled />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours"
            value="${hours2}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)' style=" display: inline-block; margin-right: 5px;" disabled/>

 
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
       </div>
    </td>
</tr>`;
                $('#' + parentId).after(subChildRow);
            }
            else if (parentId == 'S011' && $(`tr[data-parent="${parentId}"]`).length == 0) {

                var subChildRow = `
       <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;"><div style="display: flex;flex-wrap: nowrap;max-width: 100%;gap: 5px;">
        
 <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;" name="Description">${courseName}</textarea>
        

        
<label class="form-control total-hours" placeholder="Total Hours"
             style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;">${totalHours}</label>

<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours" 
            value="${hours1}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)'  style="display: inline-block; margin-right: 5px;" disabled />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours"
            value="${hours2}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)' style=" display: inline-block; margin-right: 5px;" disabled/>

 
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
       </div>
    </td>
</tr>`;
                $('#' + parentId).after(subChildRow);
            }
            else if (parentId == 'S013' && $(`tr[data-parent="${parentId}"]`).length == 0) {
                
                for (var i = 0; i < 2; i++) {
                    if (i == 0) {
                        courseName = 'Juries';
                    }
                    else { courseName = 'CRDF'; }
                    var subChildRow = '';
                    subChildRow = `
       <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;"><div style="display: flex;flex-wrap: nowrap;max-width: 100%;gap: 5px;">
        
 <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;" name="Description" disabled>${courseName}</textarea>
        

        
<label class="form-control total-hours" placeholder="Total Hours"
             style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;" >${totalHours}</label>

<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours" 
            value="${hours1}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)'  style="display: inline-block; margin-right: 5px;" disabled />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours"
            value="${hours2}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)' style=" display: inline-block; margin-right: 5px;" disabled/>

 
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
       </div>
    </td>
</tr>`;
                    $('#' + parentId).after(subChildRow);
                }
            }
            else if (parentId == 'S014' && $(`tr[data-parent="${parentId}"]`).length == 0) {

                var subChildRow = `
       <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;"><div style="display: flex;flex-wrap: nowrap;max-width: 100%;gap: 5px;">
        
 <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;" name="Description">${courseName}</textarea>
        

        
<label class="form-control total-hours" placeholder="Total Hours"
             style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;">${totalHours}</label>

<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours" 
            value="${hours1}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)'  style="display: inline-block; margin-right: 5px;" disabled />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours"
            value="${hours2}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)' style=" display: inline-block; margin-right: 5px;" disabled/>

 
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
       </div>
    </td>
</tr>`;
                $('#' + parentId).after(subChildRow);
            }
            else if (parentId == 'S012' && $(`tr[data-parent="${parentId}"]`).length == 0) {

                var subChildRow = `
       <tr class="subchild-row" data-parent="${parentId}">
    <td colspan="5" style="padding-left: 40px;"><div style="display: flex;flex-wrap: nowrap;max-width: 100%;gap: 5px;">
        
 <textarea class="form-control" placeholder="Description" style=" flex: 0 0 33%;max-width: 100%;display: inline-block; margin-right: 5px;" name="Description">${courseName}</textarea>
        

        
<label class="form-control total-hours" placeholder="Total Hours"
             style="flex: 3 -1 -2%;display: inline-block; margin-right: 5px;margin-left:8%;">${totalHours}</label>

<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;max-width: 100%;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours" 
            value="${hours1}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)'  style="display: inline-block; margin-right: 5px;" disabled />
<textarea class="form-control remark" placeholder="Remark" style="max-width:100%; display: inline-block; margin-right: 5px;" name="remark1">${remark1}</textarea>
</div>
<div class="hours-remark-group" style="flex-direction: column;flex: 0 0 21%;min-width: 100px;gap: 5px;">
        <input type="text" class="form-control hours" placeholder="Hours"
            value="${hours2}" onkeypress='return IsNumeric_istructor(event);' onInput='edValueKeyPress("${parentId}",this)' style=" display: inline-block; margin-right: 5px;" disabled/>

 
                <textarea class="form-control remark" placeholder="Remark" style=" max-width:100%;display: inline-block; margin-right: 5px;" name="remark2">${remark2}</textarea>
</div>
       </div>
    </td>
</tr>`;
                $('#' + parentId).after(subChildRow);
            }
        }



        function parameterCheck() {
            if ($('#BindPlammedOP').val() == "") {
                bootbox.alert("Please Select Planned");
                return false;
            }

            
            
            var parametername = '';
            if ($('#BindPlammedOP').val() == 'FullYear')
            {
                parametername = 'Proposed_Planned';
            }
            else if ($('#BindPlammedOP').val() == 'ActualJuneToDec')
            {
                parametername = 'Actual_June_to_Dec';
            }
            else if ($('#BindPlammedOP').val() == 'ActualJanToJune')
            {
                parametername = 'Actual_Jan_to_June';
            }
            
            

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/AWPParameterData",
                data: "{parameter_name:'" + parametername + "'}",
                contentType: "application/json",
                async: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        var AWPparameter = JSON.parse(data.d);
                        if (AWPparameter.parameter_value == 'D')
                        {
                            bootbox.alert(AWPparameter.disable_message);
                            return false;
                        }
                        else if (AWPparameter.Is_Today_In_Range == 'FALSE') {
                            bootbox.alert(AWPparameter.disable_message);
                            return false;
                        }


                    }

                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid" id="for_other" style="display: none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Annual Work Plan
            </h1>
        </div>
    </div>

    <div class="panel panel-default ">
        <div class="panel-heading">
            <b>Annual Work Plan Details</b>

            <span style="padding-left: 64%; color: #8f2808;"><b>Annual Work Plan Year : <span id="year_self" style="color:blue;"></span></b></span>
        </div>
        <div style="color: blue; padding: 10px;">
            <table style="width: 45%;" cellpadding="10" cellspacing="20">
                <tr>
                    <td>Planned : </td>
                    <td><select class="chosen-select" id="BindPlammedOP"></select></td>
                    <td><input type="button" class='btn btn-primary btn-small btngetdata' value="Get Details"/></td>
                    <td></td>
                    
                </tr>
                
            </table>
        </div>

    </div>

    
        <div class="panel panel-default ">
        <div class="panel-heading">
            <b>Personal Details</b>
        </div>
        <div style="padding: 10px; overflow: visible;" id="div_personal_detail" class="panel-collapse collapse in">


            <table style="width: 100%;" cellpadding="10" cellspacing="20">
                <tr>
                    <span id="statusrow" style="color:darkred; display:none;">You have already submitted this data</span>
                </tr>
                <tr>
                    <td class="pad-top">Name : </td>
                    <td>
                        <b><label id="txt_name" style="font-weight: bold";></label></b>
                    </td>
                    <td class="pad-top">Designation : </td>
                    <td>
                        <b><label id="txt_designation" style="font-weight: bold"; class="marg-btm"></label></b>
                    </td>
                    <td class="pad-top">Faculty : </td>
                    <td>
                        <b><label id="txt_faculty"  style="font-weight: bold"; class="marg-btm"></label></b>
                    </td>

                </tr>
                <tr>
                    <td class="pad-top">Email : </td>
                    <td>
                        <b><label id="txt_email" style="font-weight: bold";></label></b>
                    </td>
                    <td class="pad-top">Mobile No : </td>
                    <td>
                        <b><label id="txt_mobile" class="marg-btm" style="font-weight: bold";></label></b>
                    </td>

                </tr>

                <tr>
                <td align='left'><button id='pdfbtn' type='button' style='display: none' class='btn btn-primary'>    
                    <i class='icon-save bigger-160'></i>Download PDF</button></td>

              <%--<td align='left'><button id='pdfbtn_submit' type='button' style='display: none' class='btn btn-primary'>    
                    <i class='icon-save bigger-160'></i>Submit</button></td>--%>
                    </tr>
            </table>
        </div>

    </div>
    <div id="bindhtmldata">
    </div>
    <br />
    <br />
    <br />
    <br />
    <br />
       <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                </div>
            </div> 
        </div>
    </div>

</asp:Content>





