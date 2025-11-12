var inststring = '';
var inststringWithPersonal = '';
var levelstatus = 'N'
var FacultyStatus = 'N';
$(document).ready(function () {
    GetInst();
    GetData();
    

    var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
        "<i class='icon-save bigger-160'></i>Save</button></td> " +
        "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
        "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
    $('#submitBtnDiv').html(str);


    $('#personal_dtl_dob_0, #travel_dtl_date_0, #travel_dtl_fromdate_0, #travel_dtl_todate_0,#taxi_dtl_date_0, #Accommodation_dtl_outdatetime_0, #Accommodation_dtl_indatetime_0').datepicker({
        format: "dd/mm/yyyy",   // Correct date format
        autoclose: true        // Close the picker after selection
             
    });
    $('#Accommodation_dtl_intime_0').timepicker({
        timeFormat: 'HH:mm',       // Use HH:mm for 24-hour format
        interval: 15,              // Set the minute interval (adjustable)
        minTime: '01:00',          // Minimum time (10:00 AM)
        maxTime: '23:00',          // Maximum time (6:00 PM in 24-hour format)
        defaultTime: '11:00',      // Default time to show
        startTime: '10:00',        // Start time for the dropdown
        dynamic: false,
        dropdown: true,
        scrollbar: true
    });
    $('#Accommodation_dtl_outtime_0').timepicker({
        timeFormat: 'HH:mm',       // Use HH:mm for 24-hour format
        interval: 15,              // Set the minute interval (adjustable)
        minTime: '01:00',          // Minimum time (10:00 AM)
        maxTime: '23:00',          // Maximum time (6:00 PM in 24-hour format)
        defaultTime: '11:00',      // Default time to show
        startTime: '10:00',        // Start time for the dropdown
        dynamic: false,
        dropdown: true,
        scrollbar: true
    });


    //$('#taxi_dtl_pickuptime_0').datetimepicker({
    //    format: 'hh:mm:ss'
    //});


    $('#btnsave').click(function (e) {
        var urlParams = new URLSearchParams(window.location.search);
        var sentValue = urlParams.get('doc');
        var FormStatus = sentValue;
        var otherdata = []
        var details_other =
        {
            name: $('#txt_name').val(),
            email: $('#txt_mail').val(),
            mobile: $('#txt_contact').val(),
            faculty: $('#res_faculty').val(),
            destinationFrom: $('#txt_destFrom').val(),
            destinationTo: $('#txt_destTo').val(),
            purposeOfTraveling: $('#txt_purposeoftraveling').val(),
            expenseType: $('#res_ExpenseType').val(),
            expenseHead: $('#res_ExpenseHead').val(),
            arrangeBook: $('#res_Arrangebook').val(),
            paymentMode: $('#res_PaymentMode').val(),
            modeOfTravel: $('#res_ModeOfTravel').val(),
            ProjectName: $('#txt_projectname').val(),
        };

        otherdata.push(details_other);
        var personalData = [];
        $('#tbl_personal_activity tbody tr').each(function (index)
        {
            if ($(this).find('select, input, textarea').length > 0) {
                var row = $(this);
                debugger;
                var instname = '';
                var instcode = '';
                if (row.find('select[name="InstName"]').val() == undefined) {
                    instcode = 'noncept';
                    instname = row.find('input[id^="personal_dtl_name"]').val();
                }
                else {
                    instcode = row.find('select[name="InstName"]').val();
                    instname = row.find('select[name="InstName"] option:selected').text();
                }

                var personalDetails = {

                   
                    instcode: instcode,
                    name: instname,
                    dob: row.find('input[id^="personal_dtl_dob"]').val(),     
                    gender: row.find('select[name="Gender"]').val(),          
                    address: row.find('textarea[id^="personal_dtl_address"]').val(),  
                    contact: row.find('input[id^="personal_dtl_contact"]').val(),     
                    id_no: row.find('input[id^="personal_dtl_id"]').val(),      
                    mealrequest: row.find('select[name="personal_dtl_mealrequest"]').val()
                };
                personalData.push(personalDetails); 
            }
        });

        var travelData = [];
        $('#tbl_Travel_activity tbody tr').each(function (index) {
            
            if ($(this).find('input, select').length > 0) {
                var row = $(this);

                var travelDetails = {
                    date_of_travel: row.find('input[id^="travel_dtl_date"]').val(),  
                    from_date: row.find('input[id^="travel_dtl_fromdate"]').val(),   
                    to_date: row.find('input[id^="travel_dtl_todate"]').val(),       
                    travel_option: row.find('select[name="travel"]').val(),          
                    preferable_timing: row.find('input[id^="travel_dtl_preferabletime"]').val() 
                };
                travelData.push(travelDetails); 
            }
        });

        var taxiData = [];
        $('#tbl_taxi_activity tbody tr').each(function (index)
        {
            if ($(this).find('input, textarea').length > 0) {
                var row = $(this);

                var taxiDetails = {
                    date: row.find('input[id^="taxi_dtl_date"]').val(),               
                    pickup_address: row.find('textarea[id^="taxi_dtl_pickupaddress"]').val(), 
                    pickup_time: row.find('input[id^="taxi_dtl_pickuptime"]').val(),  
                    drop_time: row.find('input[id^="taxi_dtl_droptime"]').val()       
                };

                taxiData.push(taxiDetails); 
            }
        });

        var accommodationData = [];
        $('#tbl_Accommodation_activity tbody tr').each(function (index) {
            if ($(this).find('input, textarea, select').length > 0) {
                var row = $(this);

                var accommodationDetails = {
                    place: row.find('input[id^="Accommodation_dtl_place"]').val(),               
                    hotel_name: row.find('textarea[id^="Accommodation_dtl_hotelname"]').val(),   
                    accommodation: row.find('input[id^="Accommodation_dtl_Accommodation"]').val(),
                    in_date: row.find('input[id^="Accommodation_dtl_indatetime"]').val(),        
                    out_date: row.find('input[id^="Accommodation_dtl_outdatetime"]').val(),      
                    in_time: row.find('input[id^="Accommodation_dtl_intime"]').val(),            
                    out_time: row.find('input[id^="Accommodation_dtl_outtime"]').val(),          
                    payment_mode: row.find('select[id^="Accommodation_dtl_paymentmode"]').val()  
                };

                accommodationData.push(accommodationDetails); 
            }
        });

        var student_details_save_data = [];
        student_details_save_data.push(otherdata, personalData, travelData, taxiData, accommodationData);
        var json_submit_data = JSON.stringify(student_details_save_data);
        if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
        if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }
        
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/SaveSubmitFacultyTravelDtl",
            async: false,
            data: "{details_other : '" + json_submit_data + "',userid:'" + $('#hdnuserid').val() + "',status:'" + levelstatus + "',FormStatus:'" + FormStatus +"'}",
            dataType: "json",
            success: function (data)
            {
                var message = '';
                if (data.d == 'true')
                {
                    if (levelstatus == 'Y')
                    {
                        message = 'Data Submitted successfully!';
                    }
                    else { message = 'Data saved successfully!';}


                    if (FormStatus == 'new')
                    {
                        Swal.fire({

                            text: message,
                            icon: "info",
                            buttonsStyling: false,
                            confirmButtonText: "Ok, got it!",
                            customClass: {
                                confirmButton: "btn btn-primary"
                            }
                        }).then((result) => {
                            if (result.isConfirmed)
                            {
                                var url = "../Report/TravelDetails.aspx";
                                //window.open(url);
                                window.location.href = url;

                            }
                        });

                        return false;
                       
                    }
                    
                }
                else
                {
                    message = 'Data not saved';
                }
                Swal.fire({
                    
                    text: message,
                    icon: "info",
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn btn-primary"
                    }
                }).then((result) => {
                    if (result.isConfirmed)
                    {
                        if (message == 'Data Submitted successfully!')
                        {
                            var url = "../Report/TravelDetails.aspx";
                            window.location.href = url;
                        }
                    }
                })
                return false;

            },
            error: function (result) {
                Swal.fire({
                    text: result,
                    icon: "info",
                    buttonsStyling: false,
                    confirmButtonText: "Ok, got it!",
                    customClass: {
                        confirmButton: "btn btn-primary"
                    }
                });
            }
        });

    });

    $('#btnapprove').click(function (e) {
        e.preventDefault(); // Prevent form submission
       
        let isValid = true;

        // Validate Name
        if ($('#txt_name').val().trim() === '') {
            $('#name-validation').text('Name is required').show();
            $('#txt_name').addClass('error').focus();
            isValid = false;
        }

        // Validate Mail Id
        if ($('#txt_mail').val().trim() === '') {
            $('#mail-validation').text('Mail Id is required').show();
            $('#txt_mail').addClass('error').focus();
            isValid = false;
        }

        // Validate Mobile No
        if ($('#txt_contact').val().trim() === '') {
            $('#contact-validation').text('Mobile No is required').show();
            $('#txt_contact').addClass('error').focus();
            isValid = false;
        }

        if ($('#res_faculty').val().trim() === '') {
            $('#faculty-validation').text('Please Select Faculty').show();
            $('#res_faculty').addClass('error').focus();
            isValid = false;
        }

        if ($('#txt_destFrom').val().trim() === '') {
            $('#contact-destFrom').text('Destination From is required').show();
            $('#txt_destFrom').addClass('error').focus();
            isValid = false;
        }
        if ($('#txt_destTo').val().trim() === '') {
            $('#contact-destTo').text('Destination To is required').show();
            $('#txt_destTo').addClass('error').focus();
            isValid = false;
        }


        if ($('#txt_purposeoftraveling').val().trim() === '') {
            $('#contact-purposeoftraveling').text('Purpose of Traveling is required').show();
            $('#txt_purposeoftraveling').addClass('error').focus();
            isValid = false;
        }

        if ($('#res_ExpenseType').val().trim() === '') {
            $('#ExpenseType-validation').text('Please Select Expense Type').show();
            $('#res_ExpenseType').addClass('error').focus();
            isValid = false;
        }
        if ($('#res_ExpenseHead').val().trim() === '') {
            $('#ExpenseHead-validation').text('Please Select Expense Head').show();
            $('#res_ExpenseHead').addClass('error').focus();
            isValid = false;
        }
        if ($('#res_Arrangebook').val().trim() === '') {
            $('#Arrangebook-validation').text('Please Select Arrange Book').show();
            $('#res_Arrangebook').addClass('error').focus();
            isValid = false;
        }
        if ($('#res_PaymentMode').val().trim() === '') {
            $('#PaymentMode-validation').text('Please Select Payment Mode').show();
            $('#res_PaymentMode').addClass('error').focus();
            isValid = false;
        }
        if ($('#res_ExpenseHead').val().trim() == 'CRDF')
        {
            if ($('#txt_projectname').val().trim() == '')
            {
                $('#contact-projectname').text('Please Enter Project Name').show();
                $('#txt_projectname').addClass('error').focus();
                isValid = false;
            }
            
        }



        if ($('#res_ModeOfTravel').val().trim() === '') {
            $('#ModeOfTravel-validation').text('Please Select Mode of Travel').show();
            $('#res_ModeOfTravel').addClass('error').focus();
            isValid = false;
        }

        if ($('#tbl_personal_activity tbody tr').length > 0) {
            for (var i = 0; i < $('#tbl_personal_activity tbody tr').length; i++) {
                if ($('#personal_dtl_dob_' + i).val() === '') {
                    $('#personal_dtl_dob_' + i + '-validation').text('Please Enter DateOfbirth').show();
                    $('#personal_dtl_dob_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#personal_dtl_address_' + i).val() === '') {
                    $('#personal_dtl_address_' + i + '-validation').text('Please Enter Address').show();
                    $('#personal_dtl_address_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#personal_dtl_contact_' + i).val() === '') {
                    $('#personal_dtl_contact_' + i + '-validation').text('Please Enter Contact').show();
                    $('#personal_dtl_contact_' + i).addClass('error').focus();
                    isValid = false;
                }
                if ($('#personal_dtl_id_' + i).val() === '') {
                    $('#personal_dtl_id_' + i + '-validation').text('Please Enter Aadhar Card/Pan Card').show();
                    $('#personal_dtl_id_' + i).addClass('error').focus();
                    isValid = false;
                }
            }

        }

        if ($('#tbl_Travel_activity tbody tr').length > 0) {
            for (var i = 0; i < $('#tbl_Travel_activity tbody tr').length; i++) {
                if ($('#travel_dtl_date_' + i).val() === '') {
                    $('#travel_dtl_date_' + i + '-validation').text('Please Enter Travel Date').show();
                    $('#travel_dtl_date_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#travel_dtl_fromdate_' + i).val() === '') {
                    $('#travel_dtl_fromdate_' + i + '-validation').text('Please Enter Travel From Date').show();
                    $('#travel_dtl_fromdate_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#travel_dtl_todate_' + i).val() === '') {
                    $('#travel_dtl_todate_' + i + '-validation').text('Please Enter Travel To Date').show();
                    $('#travel_dtl_todate_' + i).addClass('error').focus();
                    isValid = false;
                }
                if ($('#travel_dtl_option_' + i).val() === '') {
                    $('#travel_dtl_option_' + i + '-validation').text('Please Select Travel Option').show();
                    $('#travel_dtl_option_' + i).addClass('error').focus();
                    isValid = false;
                }
                if ($('#travel_dtl_preferabletime_' + i).val() === '') {
                    $('#travel_dtl_preferabletime_' + i + '-validation').text('Please Enter Preferable Time').show();
                    $('#travel_dtl_preferabletime_' + i).addClass('error').focus();
                    isValid = false;
                }
            }

        }

        if ($('#tbl_taxi_activity tbody tr').length > 0) {
            for (var i = 0; i < $('#tbl_taxi_activity tbody tr').length; i++) {
                if ($('#taxi_dtl_date_' + i).val() === '') {
                    $('#taxi_dtl_date_' + i + '-validation').text('Please Enter Taxi Date').show();
                    $('#taxi_dtl_date_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#taxi_dtl_pickupaddress_' + i).val() === '') {
                    $('#taxi_dtl_pickupaddress_' + i + '-validation').text('Please Enter Pick Up Address').show();
                    $('#taxi_dtl_pickupaddress_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#taxi_dtl_pickuptime_' + i).val() === '') {
                    $('#taxi_dtl_pickuptime_' + i + '-validation').text('Please Enter Pick Up Time').show();
                    $('#taxi_dtl_pickuptime_' + i).addClass('error').focus();
                    isValid = false;
                }
                if ($('#taxi_dtl_droptime_' + i).val() === '') {
                    $('#taxi_dtl_droptime_' + i + '-validation').text('Please Enter Drop Time').show();
                    $('#taxi_dtl_droptime_' + i).addClass('error').focus();
                    isValid = false;
                }
            }

        }


        if ($('#tbl_Accommodation_activity tbody tr').length > 0) {
            for (var i = 0; i < $('#tbl_Accommodation_activity tbody tr').length; i++) {
                if ($('#Accommodation_dtl_place_' + i).val() === '') {
                    $('#Accommodation_dtl_place_' + i + '-validation').text('Please Enter Place').show();
                    $('#Accommodation_dtl_place_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#Accommodation_dtl_hotelname_' + i).val() === '') {
                    $('#Accommodation_dtl_hotelname_' + i + '-validation').text('Please Enter Hotel Name').show();
                    $('#Accommodation_dtl_hotelname_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#Accommodation_dtl_Accommodation_' + i).val() === '') {
                    $('#Accommodation_dtl_Accommodation_' + i + '-validation').text('Please Enter Accommodation').show();
                    $('#Accommodation_dtl_Accommodation_' + i).addClass('error').focus();
                    isValid = false;
                }
                if ($('#Accommodation_dtl_indatetime_' + i).val() === '') {
                    $('#Accommodation_dtl_indatetime_' + i + '-validation').text('Please Enter In date Time').show();
                    $('#Accommodation_dtl_indatetime_' + i).addClass('error').focus();
                    isValid = false;
                }

                if ($('#Accommodation_dtl_outdatetime_' + i).val() === '') {
                    $('#Accommodation_dtl_outdatetime_' + i + '-validation').text('Please Enter out date Time').show();
                    $('#Accommodation_dtl_outdatetime_' + i).addClass('error').focus();
                    isValid = false;
                }
                if ($('#Accommodation_dtl_paymentmode_' + i).val() === '') {
                    $('#Accommodation_dtl_paymentmode_' + i + '-validation').text('Please Select Payment Mode').show();
                    $('#Accommodation_dtl_paymentmode_' + i).addClass('error').focus();
                    isValid = false;
                }
            }

        }

        //var iduser = $('#hdnuserid').val();
        //var status = checkSelectedOptionInDropdownsByName(iduser);

        //if (!status)
        //{
        //    Swal.fire({
        //        text: " Can you please add personal details for this user? The instructor code is " + $('#hdnuserid').val(),
        //        icon: "info",
        //        buttonsStyling: false,
        //        confirmButtonText: "Ok, got it!",
        //        customClass: {
        //            confirmButton: "btn btn-primary"
        //        }
        //    });
        //    return;
        //}

        if (isValid)
        {
            levelstatus = 'Y';
            $('#btnsave').click();
        }

    });


    function checkSelectedOptionInDropdownsByName(valueToCheck)
    {

        let dropdowns = document.querySelectorAll("#tbl_personal_activity select");
        let getvalue = dropdowns[0];
        let found = false;

        dropdowns.forEach(function (getvalue)
        {
            let dropdownName = getvalue.getAttribute("name");

            if (dropdownName === 'InstName')
            {
                let selectedValue = getvalue.value;
                if (selectedValue == valueToCheck)
                {
                    found = true;
                    
                }
            }
        });

        return found;
    }

    $(document).on('input', '.validate', function () {
        $(this).removeClass('error'); // Remove error border
        $(this).next('.validation-msg').hide(); // Hide validation message
    });

    $(document).on('change', 'input[type="text"].validate', function () {
        let inputValue = $(this).val();
        // Basic date format check - you can add more complex date validation if needed
        if (inputValue !== '') {
            $(this).removeClass('error'); // Remove error border
            $(this).next('.validation-msg').hide(); // Hide validation message
        }
    });

    $('#res_faculty').on('change', function () {
        $(this).removeClass('error'); // Remove error border from dropdown
        $('#faculty-validation').hide(); // Hide validation message for the dropdown
    });
    $('#res_ExpenseType').on('change', function () {
        $(this).removeClass('error'); // Remove error border from dropdown
        $('#ExpenseType-validation').hide(); // Hide validation message for the dropdown
    });
    $('#res_ExpenseHead').on('change', function () {
        $(this).removeClass('error'); // Remove error border from dropdown
        $('#ExpenseHead-validation').hide(); // Hide validation message for the dropdown
    });
    $('#res_Arrangebook').on('change', function () {
        $(this).removeClass('error'); // Remove error border from dropdown
        $('#Arrangebook-validation').hide(); // Hide validation message for the dropdown
    });
    $('#res_PaymentMode').on('change', function () {
        $(this).removeClass('error'); // Remove error border from dropdown
        $('#PaymentMode-validation').hide(); // Hide validation message for the dropdown
    });
    $('#res_ModeOfTravel').on('change', function () {
        $(this).removeClass('error'); // Remove error border from dropdown
        $('#ModeOfTravel-validation').hide(); // Hide validation message for the dropdown
    });
    $('#travel_dtl_option_0').on('change', function () {
        $(this).removeClass('error'); // Remove error border from dropdown
        $('#ModeOfTravel-validation').hide(); // Hide validation message for the dropdown
    });
    
    //
    $(document).on('change', 'select[name="InstName"]', function ()
    {
        var instructorCode = $(this).val();
        var getid = $(this)[0].id
        getid = getid.split('_');
        var idno = getid[getid.length - 1]
        if (inststringWithPersonal != '')
        {
            FilterData(inststringWithPersonal, idno, instructorCode);
        }
    });


    $(document).on('change', 'select[name="res_Expense_Head"]', function () {
        var instructorCode = $(this).val();
        var getid = $(this)[0].id
        if ("CRDF" == instructorCode) {
            $('#txt_projectname').val('');
            $('#projectname').css('display', '');
            

        }
        else
        {
            $('#txt_projectname').val('');
            $('#projectname').css('display', 'none');
        }
        
        return false;
        
    });


    function updateURLParameter(param, value) {
        var url = new URL(window.location.href); // Get the current URL
        url.searchParams.set(param, value); // Update the parameter value
        window.history.replaceState({}, '', url); // Update the browser's URL without reloading
    }

});

function FilterData(setdata, idno, instructorCode)
{

    var data = JSON.parse(setdata)
    var result = alasql('SELECT * FROM ? WHERE instructor_code = ?', [data, instructorCode]);
    if (result.length > 0)
    {

    
    $('#personal_dtl_dob_' + idno).val(result[0].dob);
    $('#personal_dtl_gender_' + idno).val(result[0].gender);
    $('#personal_dtl_contact_' + idno).val(result[0].mobile_no);
    if (result[0].aadhaar_no != '')
    {
        //$('#personal_dtl_id_' + idno).val(result[0].aadhaar_no);
    }
    else
    {
        //$('#personal_dtl_id_' + idno).val(result[0].pan_card_no);
    }
    var row_value = result[0].address;
    if (result[0].address != '') {
        var split_data = row_value.split('@#');
        if (split_data != undefined) {
            row_value = split_data[0].replace('@#', ' ');
            row_value = row_value.replace('@c#', ' ');
            row_value = row_value.replace('#', ' ');
        }
        else {
            row_value = row_value.replace('@#', ' ');
            row_value = row_value.replace('@c#', ' ');
            row_value = row_value.replace('#', ' ');
        }
        $('#personal_dtl_address_' + idno).val(row_value);
    }
    else {
        $('#personal_dtl_address_' + idno).val('');
    }

        if (instructorCode == $('#hdnuserid').val())
        {
            $('#txt_name').val(result[0].instructor_name);
            $('#txt_mail').val(result[0].mail);
            $('#txt_contact').val(result[0].mobile_no);
        }
    }
}

function add_row(tbl) {
    if (tbl == 'add_personal_dtl') {
        let rowCount = 0;
        var table_length = $('#tbl_personal_activity tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        rowCount = table_length;
        let str_row = `
                                 <tr>
                                     <td><select name ="InstName" class='validate marg-btm' id="personal_dtl_name_${rowCount}">${inststring.options}</select>
                                         <span class="validation-msg" id="personal_dtl_name_${rowCount}-validation"></span>
                                     </td>
                                     <td><input type="text" class="validate marg-btm" id="personal_dtl_dob_${rowCount}" placeholder='dd/mm/yyyy' />
                                         <span class="validation-msg" id="personal_dtl_dob_${rowCount}-validation"></span>
                                     </td>
                                     <td><select name ="Gender" class='validate marg-btm' id="personal_dtl_gender_${rowCount}">
                                         <option value="M">Male</option><option value="F">Female</option></select>
                                         <span class="validation-msg" id="personal_dtl_gender_${rowCount}-validation"></span>
                                     </td> 
                                     <td><textarea id='personal_dtl_address_${rowCount}' class='validate marg-btm' rows='1' cols='60'></textarea>
                                         <span class="validation-msg" id="personal_dtl_address_${rowCount}-validation"></span>
                                     </td>
                                     <td><input type="text" class="validate marg-btm" id="personal_dtl_contact_${rowCount}"/>
                                         <span class="validation-msg" id="personal_dtl_contact_${rowCount}-validation"></span>
                                     </td>
                                     <td><input type="text" class="validate marg-btm" id="personal_dtl_id_${rowCount}" />
                                         <span class="validation-msg" id="personal_dtl_id_${rowCount}-validation"></span>
                                     </td>
                                    <td><select name ="personal_dtl_mealrequest" class='validate marg-btm' id="personal_dtl_mealrequest_${rowCount}">
                                         <option value="Y">Yes</option><option value="N">No</option></select>
                                         <span class="validation-msg" id="personal_dtl_mealrequest_${rowCount}-validation"></span>
                                     </td>

                                     <td><center><i class='icon-trash icon-2x text-blue ' style='cursor:pointer;'></i></center></td>
                                 </tr>`;
        $('#tbl_personal_activity tbody').append(str_row);

        $(`#personal_dtl_dob_${rowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });
    }
    else if (tbl == 'add_Travel_dtl') {
        let rowCount = 0;
        var table_length = $('#tbl_Travel_activity tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        rowCount = table_length;
        let str_row = `
                                 <tr id="row_${rowCount}">
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_date_${rowCount}" placeholder='dd/mm/yyyy' />
                    <span class="validation-msg" id="travel_dtl_date_${rowCount}-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_fromdate_${rowCount}" placeholder='dd/mm/yyyy' />
                    <span class="validation-msg" id="travel_dtl_fromdate_${rowCount}-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_todate_${rowCount}" placeholder='dd/mm/yyyy' />
                    <span class="validation-msg" id="travel_dtl_todate_${rowCount}-validation"></span>
                </td>
                <td>
                    <select name="travel" class="validate marg-btm" id="travel_dtl_option_${rowCount}">
                        <option value="F">Flight</option>
                        <option value="T">Train</option>
                        <option value="TX">Taxi</option>
                    </select>
                    <span class="validation-msg" id="travel_dtl_option_${rowCount}-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_preferabletime_${rowCount}" placeholder='HH:MM' />
                    <span class="validation-msg" id="travel_dtl_preferabletime_${rowCount}-validation"></span>
                </td>
                <td>
                    <center><i class='icon-trash icon-2x text-blue remove-row' style='cursor:pointer;'></i></center>
                </td>
            </tr>`;
        $('#tbl_Travel_activity tbody').append(str_row);

        $(`#travel_dtl_date_${rowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });

        $(`#travel_dtl_fromdate_${rowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });


        $(`#travel_dtl_todate_${rowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });
    }
    else if (tbl == 'add_taxi_dtl') {
        let taxiRowCount = 0;
        var table_length = $('#tbl_taxi_activity tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        taxiRowCount = table_length;
        let str_row = `
                                 <tr id="row_${taxiRowCount}">
                                    <td>
                                <input type="text" class="validate marg-btm" id="taxi_dtl_date_${taxiRowCount}" placeholder='dd/mm/yyyy' />
                                <span class="validation-msg" id="taxi_dtl_date_${taxiRowCount}-validation"></span>
                            </td>
                            <td>
                                <textarea class='validate marg-btm' id='taxi_dtl_pickupaddress_${taxiRowCount}' rows='1' cols='60'></textarea>
                                <span class="validation-msg" id="taxi_dtl_pickupaddress_${taxiRowCount}-validation"></span>
                            </td>
                            <td>
                                <input type="text" class="validate marg-btm" id="taxi_dtl_pickuptime_${taxiRowCount}" placeholder='HH:mm:ss' />
                                <span class="validation-msg" id="taxi_dtl_pickuptime_${taxiRowCount}-validation"></span>
                            </td>
                            <td>
                                <input type="text" class="validate marg-btm" id="taxi_dtl_droptime_${taxiRowCount}" placeholder='HH:mm:ss' />
                                <span class="validation-msg" id="taxi_dtl_droptime_${taxiRowCount}-validation"></span>
                            </td>
                            <td>
                                <center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;' onclick="removeRow(this);"></i></center>
                            </td>
            </tr>`;
        $('#tbl_taxi_activity tbody').append(str_row);

        $(`#taxi_dtl_date_${taxiRowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });
    }
    else if (tbl == 'add_Accommodation_dtl') {
        let accommodationRowCount = 0;
        var table_length = $('#tbl_Accommodation_activity tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        accommodationRowCount = table_length;
        let str_row = `
                                 <tr><td>
            <input type="text" class="validate marg-btm" id="Accommodation_dtl_place_${accommodationRowCount}" placeholder='Place' />
            <span class="validation-msg" id="Accommodation_dtl_place_${accommodationRowCount}-validation"></span>
        </td>
        <td>
            <textarea class='validate marg-btm' id='Accommodation_dtl_hotelname_${accommodationRowCount}' rows='1' cols='20' placeholder='Name of the Hotel' ></textarea>
            <span class="validation-msg" id="Accommodation_dtl_hotelname_${accommodationRowCount}-validation"></span>
        </td>
        <td>
            <input type="text" class="validate marg-btm" id="Accommodation_dtl_Accommodation_${accommodationRowCount}" placeholder='Accommodation' />
            <span class="validation-msg" id="Accommodation_dtl_Accommodation_${accommodationRowCount}-validation"></span>
        </td>
        <td>
            <input type="text" class="validate marg-btm" id="Accommodation_dtl_indatetime_${accommodationRowCount}" placeholder='In date' />
            <span class="validation-msg" id="Accommodation_dtl_indatetime_${accommodationRowCount}-validation"></span>
        </td>
           
        <td>
            <input type="text" class="validate marg-btm" id="Accommodation_dtl_outdatetime_${accommodationRowCount}" placeholder='Out date ' />
            <span class="validation-msg" id="Accommodation_dtl_outdatetime_${accommodationRowCount}-validation"></span>
        </td>
 <td>
            <input type="text" class="validate marg-btm" id="Accommodation_dtl_intime_${accommodationRowCount}" placeholder='In Time' />
            <span class="validation-msg" id="Accommodation_dtl_intime_${accommodationRowCount}-validation"></span>
        </td>
<td>
            <input type="text" class="validate marg-btm" id="Accommodation_dtl_outtime_${accommodationRowCount}" placeholder='In Time' />
            <span class="validation-msg" id="Accommodation_dtl_outtime_${accommodationRowCount}-validation"></span>
        </td>
        <td>
            <select name="paymentmode" class='validate marg-btm' id="Accommodation_dtl_paymentmode_${accommodationRowCount}">
                <option value="O">Online</option>
                <option value="C">Cash</option>
                <option value="CA">Card</option>
            </select>
            <span class="validation-msg" id="Accommodation_dtl_paymentmode_${accommodationRowCount}-validation"></span>
        </td>
        <td>
            <center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;' onclick="removeRow(this);"></i></center>
        </td></tr>`;

        $('#tbl_Accommodation_activity tbody').append(str_row);
        $(`#Accommodation_dtl_indatetime_${accommodationRowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });
        $(`#Accommodation_dtl_outdatetime_${accommodationRowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });


        $(`#Accommodation_dtl_intime_${accommodationRowCount}`).timepicker({
            timeFormat: 'HH:mm',       // Use HH:mm for 24-hour format
            interval: 15,              // Set the minute interval (adjustable)
            minTime: '01:00',          // Minimum time (10:00 AM)
            maxTime: '23:00',          // Maximum time (6:00 PM in 24-hour format)
            defaultTime: '11:00',      // Default time to show
            startTime: '10:00',        // Start time for the dropdown
            dynamic: false,
            dropdown: true,
            scrollbar: true
        });
        $(`#Accommodation_dtl_outtime_${accommodationRowCount}`).timepicker({
            timeFormat: 'HH:mm',       // Use HH:mm for 24-hour format
            interval: 15,              // Set the minute interval (adjustable)
            minTime: '01:00',          // Minimum time (10:00 AM)
            maxTime: '23:00',          // Maximum time (6:00 PM in 24-hour format)
            defaultTime: '11:00',      // Default time to show
            startTime: '10:00',        // Start time for the dropdown
            dynamic: false,
            dropdown: true,
            scrollbar: true
        });

    }
    else if (tbl == 'add_nonceptfaculty_dtl') {
        let rowCount = 0;
        var table_length = $('#tbl_personal_activity tbody tr').length;
        table_length = (parseInt(table_length) - parseInt(1));
        if (table_length == '-1')
        {
            table_length = 0;
        }
        rowCount = table_length;
        let str_row = `
                                 <tr>
                                     <td>
                                    <input type="text" class="validate marg-btm" id="personal_dtl_name_${rowCount}" placeholder='Name' />
                                    <span class="validation-msg" id="personal_dtl_name_${rowCount}-validation"></span>
                                     </td>
                                     <td><input type="text" class="validate marg-btm" id="personal_dtl_dob_${rowCount}" placeholder='dd/mm/yyyy' />
                                         <span class="validation-msg" id="personal_dtl_dob_${rowCount}-validation"></span>
                                     </td>
                                     <td><select name ="Gender" class='validate marg-btm' id="personal_dtl_gender_${rowCount}">
                                         <option value="M">Male</option><option value="F">Female</option></select>
                                         <span class="validation-msg" id="personal_dtl_gender_${rowCount}-validation"></span>
                                     </td> 
                                     <td><textarea id='personal_dtl_address_${rowCount}' class='validate marg-btm' rows='1' cols='60'></textarea>
                                         <span class="validation-msg" id="personal_dtl_address_${rowCount}-validation"></span>
                                     </td>
                                     <td><input type="text" class="validate marg-btm" id="personal_dtl_contact_${rowCount}"/>
                                         <span class="validation-msg" id="personal_dtl_contact_${rowCount}-validation"></span>
                                     </td>
                                     <td><input type="text" class="validate marg-btm" id="personal_dtl_id_${rowCount}" />
                                         <span class="validation-msg" id="personal_dtl_id_${rowCount}-validation"></span>
                                     </td>
                                    <td><select name ="personal_dtl_mealrequest" class='validate marg-btm' id="personal_dtl_mealrequest_${rowCount}">
                                         <option value="Y">Yes</option><option value="N">No</option></select>
                                         <span class="validation-msg" id="personal_dtl_mealrequest_${rowCount}-validation"></span>
                                     </td>

                                     <td><center><i class='icon-trash icon-2x text-blue ' style='cursor:pointer;'></i></center></td>
                                 </tr>`;
        $('#tbl_personal_activity tbody').append(str_row);

        $(`#personal_dtl_dob_${rowCount}`).datepicker({
            format: "dd/mm/yyyy",
            autoclose: true
        });
    }

    return false;
}

$('#tbl_personal_activity tbody tr td i.icon-trash').live('click', function (e) {
    var thisdata = $(this).closest("tr");
    confirmdialog('Are u sure you want to remove this?', thisdata);
});

$('#tbl_Travel_activity tbody tr td i.icon-trash').live('click', function (e) {
    var thisdata = $(this).closest("tr");
    confirmdialog('Are u sure you want to remove this?', thisdata);
});

$('#tbl_taxi_activity tbody tr td i.icon-trash').live('click', function (e) {
    var thisdata = $(this).closest("tr");
    confirmdialog('Are u sure you want to remove this?', thisdata);
});
$('#tbl_Accommodation_activity tbody tr td i.icon-trash').live('click', function (e) {
    var thisdata = $(this).closest("tr");
    confirmdialog('Are u sure you want to remove this?', thisdata);
});
function confirmdialog(message, currentdata) {
    Swal.fire({
        title: message,
        text: "",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, remove it!"
    }).then((result) => {
        if (result.isConfirmed) {
            //var thisdata = $(this).closest("tr");
            currentdata.remove();
            Swal.fire({
                title: "Deleted!",
                text: "Your Data has been deleted.",
                icon: "success"
            });
        }
    });
}

function GetInst() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_faculty_data_new",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d[4] != '')
            {
                inststring = JSON.parse(data.d[4])[0];
                $('#personal_dtl_name_0').append(inststring.options);
            }
            if (data.d[2] != '') {
                inststringWithPersonal = data.d[2];
                FilterData(inststringWithPersonal, 0, $('#hdnuserid').val());
                $('#personal_dtl_name_0').val($('#hdnuserid').val());
                
            }
            if (data.d[3] != '')
            {
                var MasterData = JSON.parse(data.d[3]);
                for (var m = 0; m < MasterData.length; m++)
                {
                    $('#res_faculty').append('<option value=' + MasterData[m]['FacultyCode'] + '>' + MasterData[m]['FacultyName']+'</option>');
                    $('#res_ExpenseHead').append('<option value=' + MasterData[m]['FacultyCode'] + '>' + MasterData[m]['FacultyName']+'</option>');
                }

            }
            if (data.d[5] != '')
            {
                var FAinststring_data = JSON.parse(data.d[5]);
                var FAinststring = alasql('SELECT * FROM ? WHERE user_id = ?', [FAinststring_data, $('#hdnuserid').val()]);
                if (FAinststring.length > 0 && FAinststring[0].user_id == $('#hdnuserid').val())
                {
                    $('#txt_name').val(FAinststring[0].instructor_name);
                    $('#txt_mail').val(FAinststring[0].mail);
                    $('#txt_contact').val(FAinststring[0].mobile_no);
                }
                
            }
        },
        error: function (result)
        {
            Swal.fire({
                text: result,
                icon: "info",
                buttonsStyling: false,
                confirmButtonText: "Ok, got it!",
                customClass: {
                    confirmButton: "btn btn-primary"
                }
            });
        }
    });

}

function GetData() {
    var urlParams = new URLSearchParams(window.location.search);
    var sentValue = urlParams.get('doc');
    if (sentValue != 'new') {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/GetTRFAllData",
        async: false,
        data: "{doc_no:'" + sentValue+"'}",
        dataType: "json",
        success: function (data) {
            if (data.d[0] != '')
            {
                var OtherDetails = JSON.parse(data.d[0]);
                var Facultytype = OtherDetails[0].FacultyType.trim();
                FacultyStatus = OtherDetails[0].FacultyStatus;
                $('#res_faculty').val(Facultytype);
                
                $('#txt_destFrom').val(OtherDetails[0].DestinationFromPlace);
                $('#txt_destTo').val(OtherDetails[0].DestinationToPlace);
                $('#txt_purposeoftraveling').val(OtherDetails[0].PurposeOfTravel);
                $('#res_ExpenseType').val(OtherDetails[0].ExpenseType);
                $('#res_ExpenseHead').val(OtherDetails[0].ExpenseHead);
                $('#res_Arrangebook').val(OtherDetails[0].ArrageToBook);
                $('#res_PaymentMode').val(OtherDetails[0].PaymentMode);
                $('#res_ModeOfTravel').val(OtherDetails[0].ModeOfTravel);
                if (OtherDetails[0].FacultyStatus == 'Y')
                {
                    $('#submitBtnDiv').css('display', 'none');
                    $('#txtmessage').text('This Application Already Submitted');
                }
                if ($('#res_ExpenseHead').val() == 'CRDF')
                {
                    $('#projectname').css('display', '');
                    $('#txt_projectname').val(OtherDetails[0].ProjectName);

                }
                else
                {
                    $('#txt_projectname').val('');
                    $('#projectname').css('display', 'none');
                }
            }
            if (data.d[1] != '')
            {
                var PersonalDetails = JSON.parse(data.d[1]);

                var otherDetailsRow = '';
                var PersonalDetailsRow = '';

                if (data.d[0] != '')
                {
                    var OtherDetails = JSON.parse(data.d[0]);
                    otherDetailsRow = alasql('SELECT * FROM ? WHERE UserId = ?', [OtherDetails, $('#hdnuserid').val()]);
                }

                if (otherDetailsRow.length == '0' && FacultyStatus == 'N')
                {
                    PersonalDetailsRow = alasql('SELECT * FROM ? WHERE UserId = ?', [PersonalDetails, $('#hdnuserid').val()]);
                    if (PersonalDetailsRow.length > 0) {
                        var statusEditRights = PersonalDetailsRow[0].EditRights;
                        if (statusEditRights == 'Y')
                        {
                            $('#submitBtnDiv').css('display', '');
                        }
                        else
                        {
                            $('#submitBtnDiv').css('display', 'none');
                        }

                    }
                }
                

                for (var i = 0; i < PersonalDetails.length; i++)
                {

                    

                    if (i != 0)
                    {
                        if (PersonalDetails[i].UserId == 'noncept')
                        {
                            add_row("add_nonceptfaculty_dtl");
                            $('#personal_dtl_name_' + i).val(PersonalDetails[i].Name);
                        }
                        else
                        {
                            add_row("add_personal_dtl");
                            $('#personal_dtl_name_' + i).val(PersonalDetails[i].UserId);
                        }
                        

                        
                        $('#personal_dtl_dob_' + i).val(PersonalDetails[i].Dob);
                        $('#personal_dtl_gender_' + i).val(PersonalDetails[i].Gender);
                        $('#personal_dtl_address_' + i).val(PersonalDetails[i].Address);
                        $('#personal_dtl_contact_' + i).val(PersonalDetails[i].ContactNo);
                        $('#personal_dtl_id_' + i).val(PersonalDetails[i].Id_no);
                        $('#personal_dtl_mealrequest_' + i).val(PersonalDetails[i].MealRequest);
                    }
                    else
                    {

                        if (PersonalDetails[i].UserId == 'noncept')
                        {
                            
                            if (i == 0)
                            {
                                $('#tbl_personal_activity tbody tr:eq(1)').remove();
                                add_row("add_nonceptfaculty_dtl");
                            }
                            
                            $('#personal_dtl_name_0').val(PersonalDetails[i].Name);
                        }
                        else {
                            
                            
                            $('#personal_dtl_name_0').val(PersonalDetails[0].UserId);
                        }
                       
                        $('#personal_dtl_dob_0').val(PersonalDetails[0].Dob);
                        $('#personal_dtl_gender_0').val(PersonalDetails[0].Gender);
                        $('#personal_dtl_address_0').val(PersonalDetails[0].Address);
                        $('#personal_dtl_contact_0').val(PersonalDetails[0].ContactNo);
                        $('#personal_dtl_id_0').val(PersonalDetails[0].Id_no);
                        $('#personal_dtl_mealrequest_0').val(PersonalDetails[0].MealRequest);
                    }
                }
            }
            if (data.d[2] != '')
            {
                var TravelDetails = JSON.parse(data.d[2]);
                for (var i = 0; i < TravelDetails.length; i++) {
                    if (i != 0) {
                        add_row("add_Travel_dtl");

                        $('#travel_dtl_date_' + i).val(TravelDetails[i].TravalDate);
                        $('#travel_dtl_fromdate_' + i).val(TravelDetails[i].TravalFromDate);
                        $('#travel_dtl_todate_' + i).val(TravelDetails[i].TravalToDate);
                        $('#travel_dtl_option_' + i).val(TravelDetails[i].Travel);
                        $('#travel_dtl_preferabletime_' + i).val(TravelDetails[i].PreferableTime);
                    }
                    else {
                        $('#travel_dtl_date_0').val(TravelDetails[0].TravalDate);
                        $('#travel_dtl_fromdate_0').val(TravelDetails[0].TravalFromDate);
                        $('#travel_dtl_todate_0').val(TravelDetails[0].TravalToDate);
                        $('#travel_dtl_option_0').val(TravelDetails[0].Travel);
                        $('#travel_dtl_preferabletime_0').val(TravelDetails[0].PreferableTime);
                    }
                }

            }
            if (data.d[3] != '')
            {
                var TaxiDetails = JSON.parse(data.d[3]);
                for (var i = 0; i < TaxiDetails.length; i++) {
                    if (i != 0) {
                        add_row("add_taxi_dtl");

                        $('#taxi_dtl_date_' + i).val(TaxiDetails[i].Date);
                        $('#taxi_dtl_pickupaddress_' + i).val(TaxiDetails[i].PickUpAddress);
                        $('#taxi_dtl_pickuptime_' + i).val(TaxiDetails[i].PickUpTime);
                        $('#taxi_dtl_droptime_' + i).val(TaxiDetails[i].DropTime);
                    }
                    else {
                        $('#taxi_dtl_date_0').val(TaxiDetails[0].Date);
                        $('#taxi_dtl_pickupaddress_0').val(TaxiDetails[0].PickUpAddress);
                        $('#taxi_dtl_pickuptime_0').val(TaxiDetails[0].PickUpTime);
                        $('#taxi_dtl_droptime_0').val(TaxiDetails[0].DropTime);
                    }
                }

            }
            if (data.d[4] != '')
            {
                var add_Accommodation_dtl = JSON.parse(data.d[4]);
                for (var i = 0; i < add_Accommodation_dtl.length; i++) {
                    if (i != 0) {
                        add_row("add_Accommodation_dtl");

                        $('#Accommodation_dtl_place_' + i).val(add_Accommodation_dtl[i].Place);
                        $('#Accommodation_dtl_hotelname_' + i).val(add_Accommodation_dtl[i].HotelName);
                        $('#Accommodation_dtl_Accommodation_' + i).val(add_Accommodation_dtl[i].Accommodation);
                        $('#Accommodation_dtl_indatetime_' + i).val(add_Accommodation_dtl[i].InDate);
                        $('#Accommodation_dtl_outdatetime_' + i).val(add_Accommodation_dtl[i].OutDate);
                        $('#Accommodation_dtl_intime_' + i).val(add_Accommodation_dtl[i].Intime);
                        $('#Accommodation_dtl_outtime_' + i).val(add_Accommodation_dtl[i].Outtime);
                        $('#Accommodation_dtl_paymentmode_' + i).val(add_Accommodation_dtl[i].PaymentMode);
                    }
                    else {
                        $('#Accommodation_dtl_place_0').val(add_Accommodation_dtl[0].Place);
                        $('#Accommodation_dtl_hotelname_0').val(add_Accommodation_dtl[0].HotelName);
                        $('#Accommodation_dtl_Accommodation_0').val(add_Accommodation_dtl[0].Accommodation);
                        $('#Accommodation_dtl_indatetime_0').val(add_Accommodation_dtl[0].InDate);
                        $('#Accommodation_dtl_outdatetime_0').val(add_Accommodation_dtl[0].OutDate);
                        $('#Accommodation_dtl_intime_0').val(add_Accommodation_dtl[0].Intime);
                        $('#Accommodation_dtl_outtime_0').val(add_Accommodation_dtl[0].Outtime);
                        $('#Accommodation_dtl_paymentmode_0').val(add_Accommodation_dtl[0].PaymentMode);
                    }
                }
            }
           
        },
        error: function (result) {
            Swal.fire({
                text: result,
                icon: "info",
                buttonsStyling: false,
                confirmButtonText: "Ok, got it!",
                customClass: {
                    confirmButton: "btn btn-primary"
                }
            });
        }
    });
    }
}






