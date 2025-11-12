<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_course_budget_dtl.aspx.cs" Inherits="Admin_Master_ws_course_budget_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>
     <script type="text/javascript">
         var user_type = ('<%= Session["User_Type"] %>');
         var minmum_student = 0;
         var number_of_tutors = 1;
         var contact_hours_per_tutor = 0;
         var additional_hours_for_the_course = 0;
         var total_hours_per_tutor = 0;
         var total_tutor_hours_all_tutors = 0;
         $(document).ready(function () {
             GetMasterBudgetDtl();
             GetBudgetDtl();
             checkTutorHours();
             $("#btnsave").on("click", function () {

                 var course_code = $('#hdn_course_code').val();
                 var semester_type = $('#hdn_sem').val();
                 var year_semester = $('#hdn_year').val();
                 var saveJsonObj = {};
                 var savetatutor = {};
                 for (var i = 0; i < window.Header_Data.length; i++) {
                     var cstypeArr = [];
                     var cstypeid = window.Header_Data[i]['cs_type_id'];
                     var paraArr = [];
                     if (cstypeid === "D") {
                         // Helper function for cleaner code
                         function addIfNotEmpty(label, value, subtype, srno) {
                             if (value !== null && value !== "") {
                                 paraArr.push({
                                     "course_code": course_code,
                                     "Details": label,
                                     "value": value,
                                     "cs_sub_type_id": subtype,
                                     "sr_no": srno
                                 });
                             }
                         }

                         addIfNotEmpty($('.D001').text().trim(), $('#D001').val(), "D001", "1");
                         addIfNotEmpty($('.D002 input').val(), $('#D002').val(), "D002", "2");
                         addIfNotEmpty($('.D003 input').val(), $('#D003').val(), "D003", "3");
                         addIfNotEmpty($('.D004 input').val(), $('#D004').val(), "D004", "4");
                         addIfNotEmpty($('.D005 input').val(), $('#D005').val(), "D005", "5");
                         addIfNotEmpty($('.D006 input').val(), $('#D006').val(), "D006", "6");
                     }
                     else {

                         $('.' + cstypeid + 'type .section3 .row.mb-2').each(function () {
                             var $row = $(this);
                             var srNo = $(this).attr('data-srno');
                             var subtypeid = $(this).attr('data-subtypeid');
                             var labelText = $row.find('label').text().trim() || "";
                             var inputId = $row.find('input').attr('id') || "";
                             var inputValue = $row.find('input').val() || "";

                             var objPara = {
                                 "course_code": course_code,
                                 "Details": labelText,
                                 "value": inputValue,
                                 "cs_sub_type_id": subtypeid, //inputId
                                 "sr_no": srNo,
                                 //"cs_sub_type_id_main": subtypeid
                             };
                             paraArr.push(objPara)
                         });

                         var TATutorDataSave = [];
                         if (cstypeid == "A") {
                             $(".TATutorTable tbody tr").each(function () {
                                 var name = $(this).find("td:eq(0)").text().trim();
                                 var rate = $(this).find("td:eq(1) input").val();
                                 var hours = $(this).find("td:eq(2) input").val();
                                 var designation = $(this).find("td:eq(3) input").val();
                                 var detailsRate = `Rate of ${designation} - ${name}`;
                                 var detailsHour = `Total Hours of ${designation} - ${name}`;
                                 
                                 var objPara_rate = {
                                     "course_code": course_code,
                                     "Details": detailsRate,
                                     "value": rate,
                                     "cs_sub_type_id": 'A006',
                                     "sr_no": 1,
                                 };
                                 paraArr.push(objPara_rate)

                                 var objPara_hour = {
                                     "course_code": course_code,
                                     "Details": detailsHour,
                                     "value": hours,
                                     "cs_sub_type_id": 'A006',
                                     "sr_no": 2
                                     
                                 };
                                 paraArr.push(objPara_hour)

                             });
                         }


                     }
                     saveJsonObj[cstypeid] = paraArr;
                 }


                 var courseInfo = {
                     "semester_type": semester_type,
                     "year_semester": year_semester,
                     "course_code": $('.course_code').text().trim(),
                     "course_title": $('.course_title').text().trim(),
                     "course_type": $('.course_type').val(),
                     "course_level": $('.course_level').val(),
                     "course_credit": $('.course_credit').val(),
                     "type_of_course": $('.type_of_course').val(),
                     "FeesPerCredit": $('.FeesPerCredit').val(),
                     "min_student": $('.min_student').val(),
                     "dec_min_student": $('.dec_min_student').val(),
                     "total_expected_fees": $('.total_expected_fees').val(),
                     "University_Component": $('.University_Component').val(),
                     "Faculty_Component": $('.Faculty_Component').val(),
                     "TotalExpenses": $('.TotalExpenses').val(),
                     "surplusvalue": $('.surplusvalue').val(),
                     "SurplusStatus": $('.SurplusStatus').text().trim(),
                     "nooftutor": $('.nooftutor').text().trim()
                 };

                 saveJsonObj["CourseInfo"] = [courseInfo];

                 var instructor_details = [];

                 $(".TATutorTable tbody tr").each(function (index) {
                     var name = $(this).find("td:eq(0)").text().trim();
                     var rate = $(this).find("td:eq(1) input").val();
                     var hours = $(this).find("td:eq(2) input").val();
                     var designation = $(this).find("td:eq(3) input").val();
                     var instructor_code = $(this).find("td:eq(4) input").val();

                     instructor_details.push({
                         course_code: course_code,
                         name: instructor_code,
                         instructor_name: name,
                         rate: rate,
                         hours: hours,
                         designation: designation,
                         cs_sub_type_id: 'A006',
                         semester_type: semester_type,
                         year_semester: year_semester,
                         sr_no: index + 1
                     });
                 });
                 saveJsonObj["instructor_details"] = instructor_details;
                 console.log(saveJsonObj);

                 $.ajax({
                     type: "POST",
                     url: "../../WebService.asmx/save_budget_data",
                     data: JSON.stringify({ data: saveJsonObj }),
                     contentType: "application/json",
                     dataType: "json",
                     success: function (data) {
                         if (data.d === "success") {
                             alert("Data saved Successfully");
                         } else {
                             alert("Error occurred");
                         }
                     },
                     error: function (xhr, status, error) {
                         alert("Error: " + error);
                     }
                 });



             });

             $("#btnapprove").on("click", function () {

                 if ($('#hdnusertype').val() == 'PC') {
                     alert("Only instructors are allowed to submit details for the course budget.");
                     return false;
                 }
                 else {
                 if (validateForm()) {
                     alert("Form is valid, proceeding to submit...");
                     var course_code = $('#hdn_course_code').val();
                     var semester_type = $('#hdn_sem').val();
                     var year_semester = $('#hdn_year').val();
                     var saveJsonObj = {};
                     for (var i = 0; i < window.Header_Data.length; i++) {
                         var cstypeArr = [];
                         var cstypeid = window.Header_Data[i]['cs_type_id'];
                         var paraArr = [];

                         if (cstypeid === "D") {
                             // Helper function for cleaner code
                             function addIfNotEmpty(label, value, subtype, srno) {
                                 if (value !== null && value !== "") {
                                     paraArr.push({
                                         "course_code": course_code,
                                         "Details": label,
                                         "value": value,
                                         "cs_sub_type_id": subtype,
                                         "sr_no": srno
                                     });
                                 }
                             }

                             addIfNotEmpty($('.D001').text().trim(), $('#D001').val(), "D001", "1");
                             addIfNotEmpty($('.D002 input').val(), $('#D002').val(), "D002", "2");
                             addIfNotEmpty($('.D003 input').val(), $('#D003').val(), "D003", "3");
                             addIfNotEmpty($('.D004 input').val(), $('#D004').val(), "D004", "4");
                             addIfNotEmpty($('.D005 input').val(), $('#D005').val(), "D005", "5");
                             addIfNotEmpty($('.D006 input').val(), $('#D006').val(), "D006", "6");
                         }
                         else {

                             $('.' + cstypeid + 'type .section3 .row.mb-2').each(function () {
                                 var $row = $(this);
                                 var srNo = $(this).attr('data-srno');
                                 var subtypeid = $(this).attr('data-subtypeid');
                                 var labelText = $row.find('label').text().trim() || "";
                                 var inputId = $row.find('input').attr('id') || "";
                                 var inputValue = $row.find('input').val() || "";

                                 var objPara = {
                                     "course_code": course_code,
                                     "Details": labelText,
                                     "value": inputValue,
                                     "cs_sub_type_id": subtypeid, //inputId
                                     "sr_no": srNo,
                                     //"cs_sub_type_id_main": subtypeid
                                 };
                                 paraArr.push(objPara)
                             });
                             var TATutorDataSave = [];
                             if (cstypeid == "A") {
                                 $(".TATutorTable tbody tr").each(function () {
                                     var name = $(this).find("td:eq(0)").text().trim();
                                     var rate = $(this).find("td:eq(1) input").val();
                                     var hours = $(this).find("td:eq(2) input").val();
                                     var designation = $(this).find("td:eq(3) input").val();
                                     var detailsRate = `Rate of ${designation} - ${name}`;
                                     var detailsHour = `Total Hours of ${designation} - ${name}`;
                                     //TATutorDataSave.push({
                                     //    name: name,
                                     //    rate: rate,
                                     //    hours: hours,
                                     //    designation: designation
                                     //});
                                     var objPara_rate = {
                                         "course_code": course_code,
                                         "Details": detailsRate,
                                         "value": rate,
                                         "cs_sub_type_id": 'A006', //inputId
                                         "sr_no": 1,
                                         //"cs_sub_type_id_main": subtypeid
                                     };
                                     paraArr.push(objPara_rate)

                                     var objPara_hour = {
                                         "course_code": course_code,
                                         "Details": detailsHour,
                                         "value": hours,
                                         "cs_sub_type_id": 'A006', //inputId
                                         "sr_no": 2
                                         //"cs_sub_type_id_main": subtypeid
                                     };
                                     paraArr.push(objPara_hour)

                                 });
                             }

                         }
                         saveJsonObj[cstypeid] = paraArr;
                     }


                     var courseInfo = {
                         "semester_type": semester_type,
                         "year_semester": year_semester,
                         "course_code": $('.course_code').text().trim(),
                         "course_title": $('.course_title').text().trim(),
                         "course_type": $('.course_type').val(),
                         "course_level": $('.course_level').val(),
                         "course_credit": $('.course_credit').val(),
                         "type_of_course": $('.type_of_course').val(),
                         "FeesPerCredit": $('.FeesPerCredit').val(),
                         "min_student": $('.min_student').val(),
                         "dec_min_student": $('.dec_min_student').val(),
                         "total_expected_fees": $('.total_expected_fees').val(),
                         "University_Component": $('.University_Component').val(),
                         "Faculty_Component": $('.Faculty_Component').val(),
                         "TotalExpenses": $('.TotalExpenses').val(),
                         "surplusvalue": $('.surplusvalue').val(),
                         "SurplusStatus": $('.SurplusStatus').text().trim(),
                         "nooftutor": $('.nooftutor').text().trim()
                     };

                     saveJsonObj["CourseInfo"] = [courseInfo];
                     var instructor_details = [];
                     $(".TATutorTable tbody tr").each(function (index) {
                         var name = $(this).find("td:eq(0)").text().trim();
                         var rate = $(this).find("td:eq(1) input").val();
                         var hours = $(this).find("td:eq(2) input").val();
                         var designation = $(this).find("td:eq(3) input").val();
                         var instructor_code = $(this).find("td:eq(4) input").val();

                         instructor_details.push({
                             course_code: course_code,
                             name: instructor_code,
                             instructor_name: name,
                             rate: rate,
                             hours: hours,
                             designation: designation,
                             cs_sub_type_id: 'A006',
                             semester_type: semester_type,
                             year_semester: year_semester,
                             sr_no: index + 1
                         });
                     });
                     saveJsonObj["instructor_details"] = instructor_details;

                     console.log(saveJsonObj);
                     $.ajax({
                         type: "POST",
                         url: "../../WebService.asmx/submit_budget_data",
                         data: JSON.stringify({ data: saveJsonObj}),
                         contentType: "application/json",
                         dataType: "json",
                         success: function (data) {
                             if (data.d === "success") {
                                 alert("Data submitted Successfully");

                                 $(".copyright").hide();

                             } else {
                                 alert("Error occurred");
                             }
                         },
                         error: function (xhr, status, error) {
                             alert("Error: " + error);
                         }
                     });

                 }
                 }
             });

             function checkTutorHours() {
                 var totalHours = 0;
                 var ta_index = 0;
                 var totalcost = 0;
                 $(".TATutorTable tbody tr").each(function (index) {
                     var designation = $(this).find("td:eq(3) input").val();
                     var hours = parseInt($(this).find("td:eq(2) input").val()) || 0;
                     var rateand = parseInt($(this).find("td:eq(1) input").val()) || 0
                     var totalpaytutor = hours * rateand;
                     totalcost = totalcost + totalpaytutor;
                     if (designation !== "TA") {
                         $('#B002_' + index).val(totalpaytutor);
                         totalHours += hours;
                     }
                     else if (designation == "TA")
                     {
                         $('#B003_' + ta_index).val(totalpaytutor);
                         ta_index++;
                     }
                     extracost = $('#B004').val() || 0;
                     $('#B001').val(parseFloat(extracost) + parseFloat(totalcost));
                     //$('.TotalExpenses').val(parseFloat($('#B001').val() || 0) + parseFloat($('#C001').val() || 0) + parseFloat($('#D001').val() || 0));

                     var c001 = parseFloat($('#C001').val()) || 0;
                     var d001 = parseFloat($('#D001').val()) || 0;
                     var b001 = parseFloat($('#B001').val()) || 0;
                     var grandTotal = b001 + c001 + d001;
                     $('.TotalExpenses').val(grandTotal.toFixed(2));
                 });

                 var expectedHours = parseInt($("#A005").val()) || 0;

                 
                 $("#validationMsg").remove();

                 if (totalHours === expectedHours) {
                     $(".TATutorTable").after('<div id="validationMsg" style="color:green; font-weight:bold;"> Check Total hours of tutors : OK </div>');
                 } else {
                     $(".TATutorTable").after('<div id="validationMsg" style="color:red; font-weight:bold;"> Check Total hours of tutors : CHECK TOTAL</div>');
                 }
                
             }
             //$(".TATutorTable").on("input", "tbody tr td:nth-child(3) input", function () {
             //    checkTutorHours();
             //})
             $(".TATutorTable").on("input", "tbody tr td:nth-child(2) input, tbody tr td:nth-child(3) input", function () {
                 checkTutorHours();
             });

             window.checkTutorHours = checkTutorHours;

             GetSavedData(); 
             updateTotalTravelExpenses();
             TotalCalculation(); 
             updateOtherTravelExpenses();
             if ($('#hdnusertype').val() == 'A1' || $('#hdnusertype').val() == 'D' || $('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'A') {
                 $('.fa_hide').css('display', '')
             }
             else { $('.fa_hide').css('display', 'none') }
             GetCourseCodePublishDetails();

             $("#btnprevious").on("click", function () {
                 window.location.href = "ws_coursemaster_add.aspx?c=" + $('#hdn_course_code').val() + "&s=" + $('#hdn_sem').val() + "&y=" + $('#hdn_year').val();

             });

             $(".rate-band-input").each(function () {
                 if ($('#hdnusertype').val() === "I2") {
                     $(this).prop("readonly", true);
                 } else {
                     $(this).prop("readonly", false);
                 }
             });


             return false;
         });

         $(document).on("input change", ".other_expence_value", function () {
             //alert("Value changed:", $(this).val());
             updateOtherTravelExpenses();
             TotalCalculation();
         });

         function updateOtherTravelExpenses() {
             var total = 0;
             $(".other_expence_value").each(function () {
                 total += parseFloat($(this).val()) || 0;
             });
             $(".total-other-expense").val(total.toFixed(2));
             var c001 = parseFloat($('#C001').val()) || 0;
             var d001 = parseFloat($('#D001').val()) || 0;
             var b001 = parseFloat($('#B001').val()) || 0;
             var grandTotal = b001 + c001 + d001;
             $('.TotalExpenses').val(grandTotal.toFixed(2));
             TotalCalculation();

         }

         function GetCourseCodePublishDetails() {
             var course_code = $('#hdn_course_code').val();
             var semester_type = $('#hdn_sem').val();
             var year_semester = $('#hdn_year').val();

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/GetCourseCodePublishDetails",
                 data: "{course_code : '" + course_code + "',semester_type: '" + semester_type + "',year_semester:'" + year_semester + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     if (data.d != "") {
                         if (data.d[0] != '' && data.d[0] != null) {
                             var HeaderData = JSON.parse(data.d[0]);
                             if (HeaderData[0].is_publish == 'Y') {
                                 $("#btnprevious").css('display', 'none');
                             }
                             else {
                                 $("#btnprevious").css('display', 'block');
                             }

                         }
                     }

                 },
                 error: function (result) {
                     alert(result);
                 }
             });

             return false;
         }

         $(document).on("input change", ".expense-input", function () {

             updateTotalTravelExpenses();
         });
         $(document).on("input", ".only-numbers", function () {
             this.value = this.value.replace(/[^0-9]/g, '');
         });

         function updateTotalTravelExpenses() {
             var total = 0;
             $(".expense-input").each(function () {
                 total += parseFloat($(this).val()) || 0;
             });
             $(".total-expense").text(total.toFixed(2));

             var c001 = parseFloat($('#C001').val()) || 0;
             var d001 = parseFloat($('#D001').val()) || 0;
             var b001 = parseFloat($('#B001').val()) || 0;
             var grandTotal = b001 + c001 + d001;
             $('.TotalExpenses').val(grandTotal.toFixed(2));
             TotalCalculation();
         }


         $(document).on('input change', '.section3 input', function () {
             var section = $(this).closest('.section3');

             var total = 0;

             section.find('input').not('#B001').each(function () {
                 var val = parseFloat($(this).val()) || 0;
                 total += val;
             });

             section.find('#B001').val(total);

             var c001 = parseFloat($('#C001').val()) || 0;
             var d001 = parseFloat($('#D001').val()) || 0;
             var b001 = parseFloat($('#B001').val()) || 0;
             var grandTotal = b001 + c001 + d001;
             $('.TotalExpenses').val(grandTotal.toFixed(2));
             TotalCalculation();
             
         });
         function calculateAccommodationTotal(section) {
             var total = 0;
             section.find('input[id^="C005_"]').each(function () {
                 var index = this.id.split('_')[1]; // get index (0,1,2,...)
                 var perDay = parseFloat($(this).val()) || 0;
                 var days = parseFloat($('#C006_' + index).val()) || 0;

                 total += perDay * days;
             });
             section.find('#C004').val(total);
             calculateTotalexp(section);

             var c001 = parseFloat($('#C001').val()) || 0;
             var d001 = parseFloat($('#D001').val()) || 0;
             var b001 = parseFloat($('#B001').val()) || 0;
             var grandTotal = b001 + c001 + d001;
             $('.TotalExpenses').val(grandTotal.toFixed(2));
             TotalCalculation();
             
         }
         $(document).on('input change', '#C005_0, #C005_1, #C005_2, [id^="C005_"], [id^="C006_"]', function () {
             calculateAccommodationTotal($(this).closest('.section3'));

             var c001 = parseFloat($('#C001').val()) || 0;
             var d001 = parseFloat($('#D001').val()) || 0;
             var b001 = parseFloat($('#B001').val()) || 0;
             var grandTotal = b001 + c001 + d001;
             $('.TotalExpenses').val(grandTotal.toFixed(2));
             TotalCalculation();
         });

         function calculatePerDiem(section) {
             var FIXED_PER_DIEM = 6000; // constant per day amount

             section.find('input[id^="C006_"]').each(function () {
                 var index = this.id.split('_')[1]; // tutor index (0,1,2,...)
                 var days = parseFloat($(this).val()) || 0;

                 // calculate per diem value
                 var perDiemValue = FIXED_PER_DIEM * days;

                 // update C007_x field
                 $('#C007_' + index).val(perDiemValue);
             });

             var c001 = parseFloat($('#C001').val()) || 0;
             var d001 = parseFloat($('#D001').val()) || 0;
             var b001 = parseFloat($('#B001').val()) || 0;
             var grandTotal = b001 + c001 + d001;
             $('.TotalExpenses').val(grandTotal.toFixed(2));
             TotalCalculation();
         }

         $(document).on('input change', '[id^="C006_"]', function () {
             calculatePerDiem($(this).closest('.section3'));
         });
         function calculateTotalexp(section) {
             var total = 0;

             section.find('input[id^="C002_"]').each(function () {
                 total += parseFloat($(this).val()) || 0;
             });

             section.find('input[id^="C003_"]').each(function () {
                 total += parseFloat($(this).val()) || 0;
             });
             section.find('input[id^="C007_"]').each(function () {
                 total += parseFloat($(this).val()) || 0;
             });

             total += parseFloat($('#C004').val()|| 0);

             $('#C001').val(total || 0);  // update total

             var c001 = parseFloat($('#C001').val()) || 0;
             var d001 = parseFloat($('#D001').val()) || 0;
             var b001 = parseFloat($('#B001').val()) || 0;
             var grandTotal = b001 + c001 + d001;
             $('.TotalExpenses').val(grandTotal.toFixed(2));
             TotalCalculation();

         }


         $(document).on('input change', 'input[id^="C002_"], input[id^="C003_"],input[id^="C007_"]', function () {
             calculateTotalexp($(this).closest('.section3'));
         });


         function validateForm() {
             var isValid = true;

             $("input[type='text']:not([readonly])").not(".Dtype input").each(function () {
                 if ($(this).val().trim() === "") {
                     isValid = false;
                     $(this).addClass("is-invalid");
                 } else {
                     $(this).removeClass("is-invalid");
                 }
             });

             if (!isValid) {
                 alert("Please fill all required fields!");

             }
             return isValid;
         }


         function GetBudgetDtl() {
             var course_code = $('#hdn_course_code').val();
             var semester_type = $('#hdn_sem').val();
             var year_semester = $('#hdn_year').val();

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/GetSWSCourseBudgetDtl",
                 data: "{course_code : '" + course_code + "',semester_type: '" + semester_type + "',year_semester:'" + year_semester + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     if (data.d != "") {
                         // HEADER DATA
                         if (data.d[0] != '' && data.d[0] != null) {
                             var HeaderData = JSON.parse(data.d[0]);
                             //$('.year_data').text(HeaderData[0].year_semester);
                             $('.course_code').text(HeaderData[0].course_code);
                             $('.course_title').text(HeaderData[0].course_name);
                             $('.course_type').val(HeaderData[0].course_type);
                             $('.course_level').val('UG');
                             $('.course_credit').val(HeaderData[0].course_credits);
                             $('.type_of_course').val(HeaderData[0].category_location_wise);
                             $('.FeesPerCredit').val(HeaderData[0].Student_Fees_per_Credit);
                             $('.min_student').val(HeaderData[0].min);
                             $('.dec_min_student').val(HeaderData[0].max);
                             minmum_student = HeaderData[0].max;
                             $('.total_expected_fees').val(HeaderData[0].Student_Fees_per_Credit * $('.dec_min_student').val() * HeaderData[0].course_credits);
                             $('.University_Component').val((HeaderData[0].Student_Fees_per_Credit * $('.dec_min_student').val() * HeaderData[0].course_credits) * 0.5);
                             $('.Faculty_Component').val(
                                 (HeaderData[0].Student_Fees_per_Credit * $('.dec_min_student').val() * HeaderData[0].course_credits) -
                                 (HeaderData[0].Student_Fees_per_Credit * $('.dec_min_student').val() * HeaderData[0].course_credits) * 0.5
                             );
                             //$('.nooftutor').text(HeaderData[0].total_instructors_involved);
                             $('.nooftutor').text(HeaderData[0].total_instructors_involved);
                             $("#courseImage").attr("src", "../../WSCourseImageUpload/" + HeaderData[0].image_name);

                         }

                         // TA/TUTOR DETAILS
                         if (data.d[1] != '' && data.d[1] != null) {
                            //var TATutorDetails = JSON.parse(data.d[1]);

                             if (data.d[5] && data.d[5] !== "") {
                                 TATutorDetails = JSON.parse(data.d[5]);
                             } else if (data.d[1] && data.d[1] !== "") {
                                 TATutorDetails = JSON.parse(data.d[1]);
                             }

                             // TA Tutor Table
                             var tbody = $(".TATutorTable tbody");
                             tbody.empty();
                             $.each(TATutorDetails, function (index, detail) {
                                 var row = `
                            <tr>
                               <td>${detail.instructor_name}</td>
                                    <td><input class="form-control rate-band-input" type="text" value="${detail.rate_band}" readonly /></td>
                                <td><input class="form-control only-numbers" type="text" value="${detail.TotalHrs}" /></td>
                                <td style="display:none;"><input class="form-control" type="text" value="${detail.designation}" /></td>
                                <td style="display:none;"><input class="form-control" type="text" value="${detail.instructor_code}" /></td>
                            </tr>`;
                                 tbody.append(row);
                             });

                             // Accommodation Tutor Table
                             tbody = $(".AccommdationTutorTable tbody");
                             tbody.empty();
                             $.each(TATutorDetails, function (index, detail) { 
                                 var row = `
                            <tr>
                                <td>${detail.instructor_name}</td>
                                <td><input class="form-control rate-band-input" type="text" value="${detail.rate_band}" readonly /></td>
                                <td><input class="form-control only-numbers" type="text" value="${detail.TotalHrs}" /></td>
                            </tr>`;
                                 tbody.append(row);
                             });

                             // Expenses Calculate
                             var container = $(".expensescalculate");
                             container.empty();
                             var totalSum = 0;

                             $.each(TATutorDetails, function (index, item) {
                                 var row = $('<div class="row mb-2"></div>');
                                 row.append('<label class="col-sm-6">' + item.instructor_name + '</label>');

                                 var colValue = $('<div class="col-sm-6"></div>');
                                 if (item.typedata === "text") {
                                     colValue.append('<strong>' + item.TotalRateband + '</strong>');
                                 } else if (item.typedata === "input") {
                                     colValue.append('<input type="text" class="form-control" value="' + item.TotalRateband + '" />');
                                 }
                                 row.append(colValue);
                                 container.append(row);

                                 totalSum += parseFloat(item.TotalRateband) || 0;
                                 $('.addtotalcost').text(totalSum);

                                 if (index === TATutorDetails.length - 1) {
                                     var extraRow = $('<div class="row mb-2 bg-light fw-bold"></div>');
                                     extraRow.append('<label class="col-sm-6">Payment for any other resource</label>');
                                     extraRow.append('<div class="col-sm-6"><input type="text" class="form-control" value="0" /></div>');
                                     container.append(extraRow);
                                 }
                             });

                             // Travel Expenses
                             container = $(".TravelExpenses");
                             container.empty();
                             $.each(TATutorDetails, function (index, item) {
                                 var row1 = $('<div class="row mb-2"></div>');
                                 row1.append('<label class="col-sm-6">Travel Tickets - ' + item.instructor_name + ':</label>');
                                 row1.append('<div class="col-sm-6"><input type="text" class="form-control expense-input" value="' + item.TotalRateband + '" /></div>');
                                 container.append(row1);

                                 var row2 = $('<div class="row mb-2"></div>');
                                 row2.append('<label class="col-sm-6">Local Travel - ' + item.instructor_name + ':</label>');
                                 row2.append('<div class="col-sm-6"><input type="text" class="form-control expense-input" value="0" /></div>');
                                 container.append(row2);

                                 var row3 = $('<div class="row mb-2"></div>');
                                 row3.append('<label class="col-sm-6">Per Diem - ' + item.instructor_name + ':</label>');
                                 row3.append('<div class="col-sm-6"><input type="text" class="form-control expense-input" value="0" /></div>');
                                 container.append(row3);
                             });

                             // HEADER + BODY DATA Mapping
                             var HeaderData1 = JSON.parse(data.d[4]);
                             var BodyData = JSON.parse(data.d[3]);

                             window.Header_Data = JSON.parse(data.d[4]);
                             window.Body_Data = JSON.parse(data.d[3]);

                             for (var i = 0; i < HeaderData1.length; i++) {
                                 var result = alasql('SELECT * FROM ? WHERE cs_type_id = ?', [BodyData, HeaderData1[i].cs_type_id]);

                                 $.each(result, function (j, p) {
                                     if (p.labletype != 'headers') {
                                         if (p.labletype != 'subchild') {
                                             $('#' + p.cs_sub_type_id).val();
                                         }
                                         else {
                                             if (HeaderData1[i].cs_type_id === 'B') {

                                                 if (p.cs_sub_type_id === "B002") {
                                                     var filteredTutors = TATutorDetails.filter(function (tutor) {
                                                         return !tutor.designation || tutor.designation.toUpperCase() !== "TA";
                                                     });
                                                     $.each(filteredTutors, function (index, tutor) {
                                                         $('#' + p.cs_sub_type_id + '_' + index).val(tutor.TotalRateband);
                                                     });
                                                 } else if (p.cs_sub_type_id === "B003") {
                                                     var filteredTAs = TATutorDetails.filter(function (tutor) {
                                                         return tutor.designation && tutor.designation.toUpperCase() === "TA";
                                                     });
                                                     $.each(filteredTAs, function (index, tutor) {
                                                         $('#' + p.cs_sub_type_id + '_' + index).val(tutor.TotalRateband);
                                                     });
                                                 }


                                                 $('.section3').each(function () {
                                                     var total = 0;
                                                     $(this).find('input').not('#B001').each(function () {
                                                         var val = parseFloat($(this).val()) || 0;
                                                         total += val;
                                                     });
                                                     $(this).find('#B001').val(total);
                                                 });
                                             }
                                             else {
                                                 var filteredTutors = TATutorDetails.filter(function (tutor) {
                                                     return !tutor.designation || tutor.designation.toUpperCase() !== "TA";
                                                 });
                                                 $.each(filteredTutors, function (index, tutor) {
                                                     $('#' + p.cs_sub_type_id + '_' + index).val();
                                                 });
                                             }
                                         }
                                     }
                                 });
                             }
                         }

                         //PARAMETER DETAILS
                         if (data.d[2] != '' && data.d[2] != null) {
                             var ParameterDetails = JSON.parse(data.d[2]);
                             
                             $('#A001').val(ParameterDetails[0].number_of_tutors);
                             $('#A002').val(ParameterDetails[0].contact_hours_per_tutor);
                             $('#A003').val(ParameterDetails[0].additional_hours_for_the_course);
                             $('#A004').val(ParameterDetails[0].total_hours_per_tutor);
                             $('#A005').val(ParameterDetails[0].total_tutor_hours_all_tutors);
                             number_of_tutors = ParameterDetails[0].number_of_tutors;
                             contact_hours_per_tutor = ParameterDetails[0].contact_hours_per_tutor;
                             additional_hours_for_the_course = ParameterDetails[0].additional_hours_for_the_course;
                             total_hours_per_tutor = ParameterDetails[0].total_hours_per_tutor;
                             total_tutor_hours_all_tutors = ParameterDetails[0].total_tutor_hours_all_tutors;

                         }

                     } else {
                         bootbox.alert('There is No data Found For Selected Semester or Year');
                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             });

             return false;
         }

         function TotalCalculation() {
             var manposercost = $('#B001').val() | 0;
             var TravelCost = $('#C001').val() | 0;
             var TotalCostOther = $('#D001').val() | 0;
             var TotalExpense = manposercost + TravelCost + TotalCostOther;
             $('.TotalExpenses').val(manposercost + TravelCost + TotalCostOther);
             var FacultyComponent = $('.Faculty_Component').val() | 0;
             var Total = TotalExpense | 0;

             if ((FacultyComponent - Total) > 0) {
                 $('.surplusvalue').val('Surplus');
             }
             else if ((FacultyComponent - Total) == 0) {
                 $('.surplusvalue').val('Break Even');
             }
             else {
                 $('.surplusvalue').val('Deficit');
             }


             if ((Total / FacultyComponent) <= 1) {
                 $('.SurplusStatus').text('Yes');
             }
             else if ((Total / FacultyComponent) <= 1.2) {
                 $('.SurplusStatus').text('Special Approval');
             }
             else {
                 $('.SurplusStatus').text('No');
             }



         }



         function GetMasterBudgetDtl() {
             var course_code = $('#hdn_course_code').val();
             var semester_type = $('#hdn_sem').val();
             var year_semester = $('#hdn_year').val();
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/GetSWSCourseBudgetMasterDtl",
                 data: "{course_code : '" + course_code + "',semester_type: '" + semester_type + "',year_semester:'" + year_semester + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {
                     if (data.d != "") {
                         if (data.d[0] != '') {
                             var HeaderData = JSON.parse(data.d[0]);
                             $(".setdata").empty();
                             for (var i = 0; i < HeaderData.length; i++) {

                                 var panel = $('<div class="panel panel-default"></div>');

                                 panel.append('<div class="panel-heading"><b>' + HeaderData[i].cs_type_id + '. ' + HeaderData[i].cs_type_name + '</b></div>');

                                 var row = $('<div class="row ' + HeaderData[i].cs_type_id + 'type"></div>');

                                 var col1 = $('<div class="col-md-6 section3 "></div>');

                                 if (data.d[1] != null) {
                                     var BodyData = JSON.parse(data.d[1]);
                                     var result = alasql('SELECT * FROM ? WHERE cs_type_id = ?', [BodyData, HeaderData[i].cs_type_id]);

                                     $.each(result, function (j, p) {
                                         if (HeaderData[i].cs_type_id === 'D') {
                                             var rowNumber = j + 1;
                                             var labelText = p.cs_sub_type_name && p.cs_sub_type_name.trim() !== ""
                                                 ? p.cs_sub_type_name
                                                 : "No " + rowNumber;

                                             var rowHtml = `<div class="form-row mb-2"><div class="col-md-2 d-flex align-items-center font-weight-bold ${p.cs_sub_type_id}">${labelText}</div>`;

                                             if (p.cs_sub_type_id === "D001") {
                                                 rowHtml += `<div class="col-md-4 ${p.cs_sub_type_id}">
                                                    <input type="text" class="form-control total-other-expense only-numbers" id="${p.cs_sub_type_id}" value="" readonly/> </div >`;
                                             }
                                             else {
                                                 rowHtml += `<div class="col-md-4 ${p.cs_sub_type_id}">
                                                    <input type="text" class="form-control" value="" />
                                                </div>
                                                <div class="col-md-4">
                                                    <input type="text" class="form-control other_expence_value only-numbers" id="${p.cs_sub_type_id}" value="" />
                                                </div>
                                                        </div>`;
                                             }

                                             col1.append(rowHtml);
                                         }

                                         else if (p.labletype != 'headers') {
                                             if (p.labletype != 'subchild') {
                                                 var readonlyAttr = (p.cs_sub_type_id === "B001" || p.cs_sub_type_id === "C001" || p.cs_sub_type_id === "C004" || p.cs_sub_type_id === "A001" || p.cs_sub_type_id === "A002" || p.cs_sub_type_id === "A003" || p.cs_sub_type_id === "A004" || p.cs_sub_type_id === "A005") ? " readonly" : "";
                                                 var htmbind = '<div class="row mb-2 ' + p.cs_sub_type_id + '" data-srno="' + p.sr_no + '" data-subtypeid="' + p.cs_sub_type_id + '">' +
                                                     '<label class="col-sm-6">' + p.cs_sub_type_name + '</label>' +
                                                     '<div class="col-sm-6"><input type="text" class="form-control only-numbers" id="' + p.cs_sub_type_id + '" value="" ' + readonlyAttr + '/></div>' +
                                                     '</div>';
                                                 col1.append(htmbind);
                                             }
                                             else {

                                                 if (HeaderData[i].cs_type_id === 'B') {

                                                     if (p.cs_sub_type_id === "B002") {
                                                         if (data.d[2] && data.d[2] !== '') {
                                                             var TATutorDetails = JSON.parse(data.d[2]);

                                                             var filteredTutors = TATutorDetails.filter(function (tutor) {
                                                                 return !tutor.designation || tutor.designation.toUpperCase() !== "TA";
                                                             });

                                                             if (filteredTutors.length > 0) {
                                                                 var labelRow = '<div class="row mb-2 ' + p.cs_sub_type_id + '" data-srno="' + p.sr_no + '" data-subtypeid="' + p.cs_sub_type_id + '">' +
                                                                     '<label class="col-sm-6" style="color:blue;"><b>' + p.cs_sub_type_name + '</b></label></div>';
                                                                 col1.append(labelRow);

                                                                 $.each(filteredTutors, function (index, tutor) {
                                                                     var displayIndex = index + 1;
                                                                     var tutorRow = '<div class="row mb-2 ' + p.cs_sub_type_id + ' ' + p.cs_sub_type_id + '_' + index + '" data-srno="' + displayIndex + '" data-subtypeid="' + p.cs_sub_type_id + '">' +
                                                                         '<div class="col-sm-6"><label class="mb-0">' + p.cs_sub_type_name + ' of tutor ' + displayIndex + ' -' + tutor.instructor_name + '</label></div>' +
                                                                         '<div class="col-sm-6"><input type="text" class="form-control only-numbers" value="" id="' + p.cs_sub_type_id + '_' + index + '" readonly/></div>' +
                                                                         '</div>';
                                                                     col1.append(tutorRow);
                                                                 });
                                                             }
                                                         }
                                                     }

                                                     else if (p.cs_sub_type_id === "B003") {
                                                         if (data.d[2] && data.d[2] !== '') {
                                                             var TATutorDetails = JSON.parse(data.d[2]);

                                                             var filteredTAs = TATutorDetails.filter(function (tutor) {
                                                                 return tutor.designation && tutor.designation.toUpperCase() === "TA";
                                                             });

                                                             if (filteredTAs.length > 0) {
                                                                 var labelRow = '<div class="row mb-2 ' + p.cs_sub_type_id + '" data-srno="' + p.sr_no + '" data-subtypeid="' + p.cs_sub_type_id + '">' +
                                                                     '<label class="col-sm-6" style="color:blue;"><b>' + p.cs_sub_type_name + '</b></label></div>';
                                                                 col1.append(labelRow);

                                                                 $.each(filteredTAs, function (index, tutor) {
                                                                     var displayIndex = index + 1;
                                                                     var tutorRow = '<div class="row mb-2 ' + p.cs_sub_type_id + ' ' + p.cs_sub_type_id + '_' + index + '" data-srno="' + displayIndex + '" data-subtypeid="' + p.cs_sub_type_id + '">' +
                                                                         '<div class="col-sm-6"><label class="mb-0">' + p.cs_sub_type_name + ' of tutor ' + displayIndex + ' -' + tutor.instructor_name + '</label></div>' +
                                                                         '<div class="col-sm-6"><input type="text" class="form-control only-numbers" value="" id="' + p.cs_sub_type_id + '_' + index + '" readonly/></div>' +
                                                                         '</div>';
                                                                     col1.append(tutorRow);
                                                                 });
                                                             }
                                                         }
                                                     }

                                                 }
                                                 else {

                                                     if (data.d[2] && data.d[2] !== '') {
                                                         var TATutorDetails = JSON.parse(data.d[2]);

                                                         // Filter only Tutors (exclude TAs)
                                                         var filteredTutors = TATutorDetails.filter(function (tutor) {
                                                             return !tutor.designation || tutor.designation.toUpperCase() !== "TA";
                                                         });

                                                         // Only append label and rows if we have at least one Tutor
                                                         if (filteredTutors.length > 0) {
                                                             // Append label
                                                             var labelRow = '<div class="row mb-2 ' + p.cs_sub_type_id + '" data-srno="' + p.sr_no + '" data-subtypeid="' + p.cs_sub_type_id + '">' +
                                                                 '<label class="col-sm-6" style="color:blue;"><b>' + p.cs_sub_type_name + '</b></label></div>';
                                                             col1.append(labelRow);

                                                             // Append each Tutor row with numbered class/id
                                                             $.each(filteredTutors, function (index, tutor) {
                                                                 var displayIndex = index + 1;
                                                                 var tutorRow = '<div class="row mb-2 ' + p.cs_sub_type_id + ' ' + p.cs_sub_type_id + '_' + index + '" data-srno="' + displayIndex + '" data-subtypeid="' + p.cs_sub_type_id + '">' +
                                                                     '<div class="col-sm-6"><label class="mb-0">' + p.cs_sub_type_name + ' of tutor ' + displayIndex + ' -' + tutor.instructor_name + '</label></div>' +
                                                                     '<div class="col-sm-6"><input type="text" class="form-control only-numbers" value="" id="' + p.cs_sub_type_id + '_' + index + '" /></div>' +
                                                                     '</div>';
                                                                 col1.append(tutorRow);
                                                             });
                                                         }
                                                     }
                                                 }

                                             }
                                         }

                                     });
                                 }

                                 

                                 if (HeaderData[i].cs_type_id != 'B' && HeaderData[i].cs_type_id != 'D' && HeaderData[i].cs_type_id != 'C') {
                                     var col2 = $('<div class="col-md-6 section4"></div>');
                                     col2.append('<div class="section-heading">Tutors/TA</div>');

                                     var table = $('<table class="table table-bordered sub-table TATutorTable"></table>');
                                     var thead = '<thead class="thead-light"><tr><th>Name</th><th>Rate</th><th>Total hour</th><th style="display:none">Designation</th><th style="display:none">instructor_code</th></tr></thead>';
                                     var tbody = $('<tbody></tbody>'); // Empty

                                     table.append(thead).append(tbody);
                                     col2.append(table);



                                     row.append(col1).append(col2);
                                     panel.append(row);


                                 }
                                 else {
                                     row.append(col1);
                                     panel.append(row);
                                 }


                                 // Add to container
                                 $(".setdata").append(panel);
                             }

                         }

                         if (data.d[1] != '') {
                             var TATutorDetails = JSON.parse(data.d[1]);

                         }



                     }
                     else {
                         bootbox.alert('There is No data Found');
                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             });

             return false;
         }

         function GetSavedData() {
             var course_code = $('#hdn_course_code').val();
             var semester_type = $('#hdn_sem').val();
             var year_semester = $('#hdn_year').val();
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/GetSavedCourseBudgetDtl",
                 data: "{course_code : '" + course_code + "',semester_type:'" + semester_type + "',year_semester:'" + year_semester + "',coursetype:'" + $('.course_type').val() + "'}",
                 dataType: "json",
                 async: false,
                 success: function (data) {

                     if (data.d != "") {

                         if (data.d[0] && data.d[0] !== '') {
                             var ParameterData = JSON.parse(data.d[0]);
                             for (var i = 0; i < ParameterData.length; i++) {
                                 var subTypeId = ParameterData[i].cs_sub_type_id;
                                 var value = ParameterData[i].value;

                                 $("#" + subTypeId).val(value);
                             }

                             $('#A001').val(number_of_tutors);
                             $('#A002').val(contact_hours_per_tutor);
                             $('#A003').val(additional_hours_for_the_course);
                             $('#A004').val(total_hours_per_tutor);
                             $('#A005').val(total_tutor_hours_all_tutors);

                             checkTutorHours();
                         }

                         if (data.d[1] && data.d[1] !== '') {
                             var ExpenceData = JSON.parse(data.d[1]);

                             // Track occurrence of each cs_sub_type_id for subchild inputs
                             var typeCounter = {};

                             $.each(ExpenceData, function (_, item) {
                                 var $mainInput = $('#' + item.cs_sub_type_id);

                                 // Check if the input exists and is a main input
                                 if ($mainInput.length && $('.' + item.cs_sub_type_id).length === 1) {
                                     // Only one element with that cs_sub_type_id => main input
                                     $mainInput.val(item.value);
                                 } else {
                                     // Subchild inputs
                                     if (!typeCounter[item.cs_sub_type_id]) {
                                         typeCounter[item.cs_sub_type_id] = 0;
                                     }
                                     var index = typeCounter[item.cs_sub_type_id];

                                     var $subInput = $('#' + item.cs_sub_type_id + '_' + index);
                                     if ($subInput.length) {
                                         $subInput.val(item.value);
                                     }

                                     typeCounter[item.cs_sub_type_id]++;
                                 }
                             });
                         }

                         if (data.d[2] && data.d[2] !== '') {
                             var TravelData = JSON.parse(data.d[2]);

                             // Track occurrence of each cs_sub_type_id for subchild inputs
                             var typeCounter = {};

                             $.each(TravelData, function (_, item) {
                                 var $mainInput = $('#' + item.cs_sub_type_id);

                                 // Check if the input exists and is a main input
                                 if ($mainInput.length && $('.' + item.cs_sub_type_id).length === 1) {
                                     // Only one element with that cs_sub_type_id => main input
                                     $mainInput.val(item.value);
                                 } else {
                                     // Subchild inputs
                                     if (!typeCounter[item.cs_sub_type_id]) {
                                         typeCounter[item.cs_sub_type_id] = 0;
                                     }
                                     var index = typeCounter[item.cs_sub_type_id];

                                     var $subInput = $('#' + item.cs_sub_type_id + '_' + index);
                                     if ($subInput.length) {
                                         $subInput.val(item.value);
                                     }

                                     typeCounter[item.cs_sub_type_id]++;
                                 }
                             });
                         }

                         if (data.d[3] && data.d[3] !== '') {
                             var OtherData = JSON.parse(data.d[3]);
                             $('#D001').val(OtherData[0]["value"]);

                             for (var i = 1; i < OtherData.length; i++) {
                                 var item = OtherData[i];

                                 if (item && item.cs_sub_type_id) {
                                     var detailsSelector = '.' + item.cs_sub_type_id + ' input';
                                     var valueSelector = '#' + item.cs_sub_type_id;
                                     if ($(detailsSelector).length > 0 && $(valueSelector).length > 0) {
                                         $(detailsSelector).val(item.details || '');
                                         $(valueSelector).val(item.value || '');
                                     }
                                 }
                             }

                         }

                         if (data.d[4] && data.d[4] !== '') {
                             var CourseData = JSON.parse(data.d[4]);
                            // $('.course_type').val(CourseData[0]["course_type"]);
                             //$('.course_level').val(CourseData[0]["course_level"]);
                             //$('.course_credit').val(CourseData[0]["course_credits"]);
                             $('.type_of_course').val(CourseData[0]["type_of_course"]);
                             $('.min_student').val(CourseData[0]["min_student_suggest"]);
                             //$('.dec_min_student').val(CourseData[0]["min_student_decided"]);
                             $('.dec_min_student').val(minmum_student);
                             //$('.FeesPerCredit').val(CourseData[0]["fees_per_credit"]);
                             //$('.total_expected_fees').val(CourseData[0]["total_expected_fees"]);
                             //$('.University_Component').val(CourseData[0]["uni_component"]);
                             //$('.Faculty_Component').val(CourseData[0]["fac_componet"]);
                             $('.TotalExpenses').val(CourseData[0]["total_expenses"]);
                             $('.surplusvalue').val(CourseData[0]["budget_status"]);
                             $('.SurplusStatus').text(CourseData[0]["budget_approve_status"]);

                             
                             if (user_type == "D" && CourseData[0]["dean_status"] == 'Y')
                             {
                                 $(".statusforbudget").css('display','');
                                 $(".copyright").hide();
                             }
                             else if ((user_type == "A1" || user_type == "A") && CourseData[0]["ugpg_status"] == 'Y')
                             {
                                 $(".statusforbudget").css('display', '');
                                 $(".copyright").hide();
                             }
                             else if (user_type == "FA" && CourseData[0]["FA_status"] == 'Y') 
                             {
                                 $(".statusforbudget").css('display', '');
                                 $(".copyright").hide();
                             }
                             else if (user_type == "I2" && CourseData[0]["is_submit"] == 'Y')
                             {
                                 $(".statusforbudget").css('display', '');
                                 $(".copyright").hide();
                             }
                             else if (user_type == "A")
                             {
                                 $("#btnapprove").css('display', 'none');
                             }
                             else if (CourseData[0]["status_data"] != "E")
                             {
                                 $("#btnapprove").css('display', 'none');
                             }

                         }

                     }

                 },
                 error: function (result) {
                     alert(result);
                 }
             });

             return false;
         }
          
     </script>

     <style>
         .setdata .panel:last-child {
    margin-bottom: 80px!important;
}
        .container{
            width:1090px!important;
        }
        .budget-header {
            background-color: #222;
            color: white;
            padding: 10px 20px;
            font-weight: bold;
        }

        .section-title {
            font-size: 16px;
            margin: 20px 0 10px;
        }
        .is-invalid {
            border: 2px solid red !important;
            background-color: #ffe6e6;
        }
        .warning-text {
            color: red;
            font-size: 12px;
        }

        .card-box {
            border: 2px solid #cfcece;
            padding: 10px 15px;
            margin-bottom: 20px;
            background-color: #fff;
        }

        .budget-box {
            border: 2px solid #cfcece;
            padding: 10px 15px;
            margin-bottom: 20px;
            background-color: #fff;
        }

        .deficit-line {
            border-top: 2px dotted red;
            margin: 15px 0;
        }

        .section-heading {
            background: #c7c7c7;
            padding: 5px 10px;
            font-weight: bold;
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }

        .sub-table td {
            vertical-align: middle;
        }

        .sub-table input {
            width: 100%;
        }

        .mb-2 {
            margin-bottom: 0.05rem !important;
        }
        input[type="text"]{
            height:33px;
        }

        .bordered-box {
           border: 1px solid #989a9c;
           border-radius: 10px;
           padding: 10px 15px;
           margin: 20px 0;
           background-color: #b1b6ba;
        }
        .section3{
           padding-left: 33px;
           margin-top: 10px;
           flex: 0 0 48%!important;
        }
        .section4{
           padding-left: 25px;
           margin-top: 10px;
           flex: 0 0 48%!important;
        }
       .section1 {
           padding-left: 33px;
           margin-top: 10px;
       }

        .section2 {
            padding-left: 10px;
            margin-top: 10px;
        }

        .course-image-box {
            width: 93%;
            background-color: #eee;
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            margin-bottom: 10px;
        }
         .status-label {
            display: inline-block;
            width: 100%;
            background-color: #dc3545; 
            color: white;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 500;
            margin-top:10px;
        }
         .section5{
             margin-bottom:80px!important;
         }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container mt-3">


    <div class="text-muted mb-1">Summer Winter <span class="year_data"></span></div>
    <div class="bordered-box text-center">
            <h5 class="mb-0">Course Budget - <span class="course_code"></span></h5>
        </div>
          <div class="panel panel-default">
    <div class="panel-heading"><b>Course Title - <span class="course_title"></span></b></div>
    <div class="row d-flex">
        <!-- Left: Course Info -->
        <div class="col-md-9"><p class="statusforbudget" style="color:red;display:none;padding-left: 20px;padding-top: 10px;">Course budget submitted successfully. For any changes, please contact the Admin.</p></div>

        <div class="col-md-9 section1">
            <div class="form-row">
                <div class="form-group col-md-4">
                    <label>Course Type</label>
                    <input type="text" class="form-control course_type" readonly>
                </div>
                <div class="form-group col-md-4">
                    <label>Course Level</label>
                    <input type="text" class="form-control course_level" readonly>
                </div>
                <div class="form-group col-md-4">
                    <label>Course Credits</label>
                    <input type="text" class="form-control course_credit" readonly>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col-md-4">
                    <label>Type of Course</label>
                    <input type="text" class="form-control type_of_course" readonly>
                </div>
                <div class="form-group col-md-4">
                    <label>Min. Students (suggested)</label>
                    <input type="text" class="form-control min_student" value="0" readonly>
                </div>
                <div class="form-group col-md-4">
                    <label>Decide Min Students</label>
                    <input type="text" class="form-control dec_min_student" value="0" readonly>
                </div>
            </div>

            <div class="form-group">
                <label>Student Fees per Credit</label>
                <input type="text" class="form-control FeesPerCredit" readonly>
            </div>
        </div>

        <!-- Right: Course Image -->
        <div class="col-md-3 section4">
            <div class="course-image-box border text-center py-4">
                <img id="courseImage" src="" alt="Course image" style="height: inherit;">
            </div>
            <strong><span class="course_title"></span></strong>
        </div>
    </div>
</div>


    <!-- Remaining Sections -->
  

<div class="panel panel-default">
    <div class="panel-heading"><b>Surplus/Deficit</b></div>
    <div class="row d-flex">
        <!-- Left: Budget Info -->
        <div class="col-md-9 section3">
            <div class="form-group row align-items-center mb-2 fa_hide">
                <label class="col-sm-5 col-form-label">Total Expected Fees</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control total_expected_fees" readonly />
                </div>
            </div>
            <div class="form-group row align-items-center mb-2 fa_hide">
                <label class="col-sm-5 col-form-label">- University Component</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control University_Component" readonly />
                </div>
            </div>
            <div class="form-group row align-items-center mb-2 fa_hide">
                <label class="col-sm-5 col-form-label">- Faculty Component</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control Faculty_Component" readonly />
                </div>
            </div>
            <div class="form-group row align-items-center mb-2 fa_hide">
                <label class="col-sm-5 col-form-label">Total Expenses</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control TotalExpenses" value="0" readonly />
                </div>
            </div>
            <div class="form-group row align-items-start">
                <label class="col-sm-5 col-form-label">Surplus / Deficit</label>
                <div class="col-sm-7">
                    <input type="text" class="form-control mb-2 surplusvalue" value="" readonly />
                
                </div>
            </div>

            <div class="form-group row align-items-start mb-2">
                <label class="col-sm-5 col-form-label">Budget Approval </label>
                <div class="col-sm-7">
                    <label class="status-label text-center SurplusStatus">No</label>
                </div>
            </div>
        </div>

        <!-- Right: Optional Visual Section -->
       
    </div>
</div>



<div class="setdata"><p>test</p></div>
<div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
    <div class="container">
        <div class="row-fluid">
            <div id="submitBtnDiv" class="controls" 
                 style="display: flex; justify-content: center; gap: 5px; padding: 10px;">
                 
                <!-- Previous button -->
                <button id="btnprevious" type="button" class="btn btn-primary" style="display:block">
                    << Previous
                </button>

                <!-- Save button -->
                <button id="btnsave" type="button" class="btn btn-primary">
                    <i class="icon-save bigger-160"></i> Save
                </button>

                <!-- Submit button -->
                <button id="btnapprove" type="button" class="btn btn-primary">
                    <i class="icon-save bigger-160"></i> Submit
                </button>

            </div>
        </div> 
    </div>
</div>



</div>
     <asp:HiddenField ID="hdn_course_code" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_sem" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static" />
<!-- Bootstrap 4.6 JS -->

</asp:Content>

