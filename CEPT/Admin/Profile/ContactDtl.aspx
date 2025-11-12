<%@ Page Title="Contact Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="ContactDtl.aspx.cs" Inherits="Admin_Profile_ContactDtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="contact-details-tab" role="tabpanel">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-map-marker-alt me-2" style="font-size: 1rem;"></i>
                        Contact Details
                    </h5>
                </div>

        <form id="contactDetailsForm" class="personal-details-form">
            <!-- Permanent Address Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-home me-2" style="font-size: 0.85rem;"></i>
                        Permanent Address
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label required">Permanent Address</label>
                            <textarea id="permanent_address" name="permanent_address" class="form-control" rows="3" placeholder="Enter permanent address" required></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Address Line 1</label>
                            <input type="text" id="address_line_1" name="address_line_1" class="form-control" placeholder="Enter address line 1" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Address Line 2</label>
                            <input type="text" id="address_line_2" name="address_line_2" class="form-control" placeholder="Enter address line 2">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label required">Permanent Country</label>
                           <%-- <input type="text" id="permanent_country" name="permanent_country" class="form-control" placeholder="Enter country" required>--%>

                            <select id="permanent_country" name="permanent_country" class="form-select" required>
                            <option value="" selected disabled>Select Country</option></select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label required">Permanent State</label>
                            <%--<input type="text" id="permanent_state" name="permanent_state" class="form-control" placeholder="Enter state" required>--%>
                            <select id="permanent_state" name="permanent_state" class="form-select" required>
                            <option value="" selected disabled>Select State</option></select>

                        </div>
                        <div class="col-md-4">
                            <label class="form-label required">Permanent City</label>
                            <%--<input type="text" id="permanent_city" name="permanent_city" class="form-control" placeholder="Enter city" required>--%>
                            <select id="permanent_city" name="permanent_city" class="form-select" required>
                            <option value="" selected disabled>Select City</option></select>
                        </div>
                        
                        
                    </div>
                </div>
            </div>

            <!-- Residing Address Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-building me-2" style="font-size: 0.85rem;"></i>
                        Residing Address
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-12"> 
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="sameAsPermanent" name="sameAsPermanent" style="margin-left:5px;">
                                <label class="form-check-label" for="sameAsPermanent" style="font-size: 12px; color: #495057;">
                                    <i class="fas fa-copy me-2"></i>
                                    Same as Permanent Address
                                </label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label required">Residing Address</label>
                            <textarea id="residing_address" name="residing_address" class="form-control" rows="3" placeholder="Enter residing address" required></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Residing Address Line 1</label>
                            <input type="text" id="residing_address_line_1" name="residing_address_line_1" class="form-control" placeholder="Enter residing address line 1" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Residing Address Line 2</label>
                            <input type="text" id="residing_address_line_2" name="residing_address_line_2" class="form-control" placeholder="Enter residing address line 2">
                        </div>
                         <div class="col-md-4">
                            <label class="form-label required">Residing County</label>
                            <select id="residing_county" name="residing_county" class="form-select" required>
                            <option value="" selected disabled>Select Residing Country</option></select>

                        </div>
                        <div class="col-md-4">
                            <label class="form-label required">Residing State</label>
                            
                            <select id="residing_state" name="residing_state" class="form-select" required>
                            <option value="" selected disabled>Select Residing State</option></select>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label required">Residing City</label>
                            <select id="residing_city" name="residing_city" class="form-select" required>
                            <option value="" selected disabled>Select Residing City</option></select>
                        </div>
                        
                       
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="card">
                <div class="card-body">
                    <div class="d-flex justify-content-between align-items-center">
                        <button type="button" id="btnPrevious" class="btn btn-outline-secondary btn-sm" onclick="navigateToPreviousMenu()">
                            <i class="fas fa-arrow-left me-2"></i>
                            Previous
                        </button>
                        <div class="action-buttons">
                            <button type="button" id="btnSave" class="btn btn-success btn-sm me-3">
                                <i class="fas fa-save me-2"></i>
                                Save
                            </button>
                            <button type="button" id="btnNext" class="btn btn-primary btn-sm" onclick="navigateToNextMenu()">
                                Next
                                <i class="fas fa-arrow-right ms-2"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
            </div>
        </div>
    </div>

   <style>
        .personal-details-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 15px;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            font-size: 13px;
        }

        .tab-content {
            width: 100%;
        }

        .tab-pane {
            display: block !important;
            opacity: 1 !important;
        }

        .tab-pane.fade.show.active {
            display: block !important;
            opacity: 1 !important;
        }

        .card-header {
            background-color: #f8f9fa !important;
            border-color: #dee2e6 !important;
            border-bottom: 1px solid #dee2e6;
            padding: 12px 16px;
            margin-bottom: 15px;
            border-radius: 6px 6px 0 0;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        }

        .card-header h5 {
            color: #495057;
            font-weight: 600;
            font-size: 1rem;
            margin: 0;
            display: flex;
            align-items: center;
        }

        .card-header h5 i {
            color: #007bff;
            font-size: 0.9rem;
            margin-right: 6px;
        }

        .card {
            border: 1px solid #e9ecef;
            border-radius: 6px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
            transition: all 0.2s ease;
            margin-bottom: 12px;
        }

        .card:hover {
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.12);
            border-color: #007bff;
        }

        .card-body {
            padding: 16px;
            font-size: 13px;
        }

        .card.mb-4 {
            margin-bottom: 12px !important;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 6px;
            display: block;
            font-size: 12px;
        }

        .form-label.required::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
            font-size: 12px;
        }

        .form-control, .form-select {
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 8px 12px;
            font-size: 13px;
            transition: all 0.2s ease;
            background-color: #fff;
            height: auto;
        }

        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            background-color: #fff;
        }

        .form-control::placeholder {
            color: #6c757d;
            font-size: 12px;
        }

        .form-check {
            padding-left: 0;
        }

        .form-check-input {
            margin-top: 0.2rem;
            margin-right: 8px;
            width: 16px;
            height: 16px;
        }

        .form-check-label {
            font-size: 12px;
            color: #495057;
            cursor: pointer;
            display: flex;
            align-items: center;
        }

        .form-check-label i {
            color: #007bff;
            font-size: 11px;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            border-radius: 4px;
            font-weight: 500;
            padding: 6px 12px;
            transition: all 0.2s ease;
            border: 1px solid transparent;
            font-size: 12px;
        }

        .btn-lg {
            padding: 8px 16px;
            font-size: 13px;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 11px;
            border-radius: 3px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border-color: #007bff;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #004085 100%);
            border-color: #0056b3;
            transform: translateY(-1px);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            border-color: #28a745;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #1e7e34 0%, #155724 100%);
            border-color: #1e7e34;
            transform: translateY(-1px);
        }

        .btn-outline-secondary {
            color: #6c757d;
            border-color: #6c757d;
            background-color: transparent;
        }

        .btn-outline-secondary:hover {
            background-color: #6c757d;
            border-color: #6c757d;
            transform: translateY(-2px);
        }

        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .personal-details-container {
                margin: 10px;
                padding: 15px;
            }

            .card-body {
                padding: 12px;
            }

            .action-buttons {
                flex-direction: column;
                width: 100%;
            }

            .btn {
                width: 100%;
                margin-bottom: 10px;
            }
        }
    </style>

    <script>
        $(document).ready(function () {
            // Form validation
            GetCountry();


            $("#permanent_country").change(function () {
                let country = $(this).val();
                $.ajax({
                    url: "https://countriesnow.space/api/v0.1/countries/states",
                    method: "POST",
                    data: JSON.stringify({ country }),
                    contentType: "application/json",
                    success: function (res) {
                        $("#permanent_state").empty();
                        $.each(res.data.states, function (i, state) {
                            $("#permanent_state").append(`<option value="${state.name}">${state.name}</option>`);
                        });
                    }
                });
            });

           
            $("#permanent_state").change(function () {
                let country = $("#permanent_country").val();
                let state = $(this).val();
                $.ajax({
                    url: "https://countriesnow.space/api/v0.1/countries/state/cities",
                    method: "POST",
                    data: JSON.stringify({ country, state }),
                    contentType: "application/json",
                    success: function (res) {
                        $("#permanent_city").empty();
                        $.each(res.data, function (i, city) {
                            $("#permanent_city").append(`<option value="${city}">${city}</option>`);
                        });
                    }
                });
            });


            $("#residing_county").change(function () {
                let country = $(this).val();
                $.ajax({
                    url: "https://countriesnow.space/api/v0.1/countries/states",
                    method: "POST",
                    data: JSON.stringify({ country }),
                    contentType: "application/json",
                    success: function (res) {
                        $("#residing_state").empty();
                        $.each(res.data.states, function (i, state) {
                            $("#residing_state").append(`<option value="${state.name}">${state.name}</option>`);
                        });
                    }
                });
            });
            $("#residing_state").change(function () {
                let country = $("#residing_county").val();
                let state = $(this).val();
                $.ajax({
                    url: "https://countriesnow.space/api/v0.1/countries/state/cities",
                    method: "POST",
                    data: JSON.stringify({ country, state }),
                    contentType: "application/json",
                    success: function (res) {
                        $("#residing_city").empty();
                        $.each(res.data, function (i, city) {
                            $("#residing_city").append(`<option value="${city}">${city}</option>`);
                        });
                    }
                });
            });
            $('#contactDetailsForm').on('submit', function (e) {
                e.preventDefault();
                validateForm();
            });
            $('#btnSave').click(function () {
                saveContactDetails();
            });
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });
            $('#sameAsPermanent').change(function () {
                if ($(this).is(':checked')) {
                    copyPermanentToResiding();
                } else {
                    clearResidingAddress();
                }
            });
        });

        function GetCountry() {
            $.get("https://countriesnow.space/api/v0.1/countries", function (response) {
                let countries = response.data;
                $.each(countries, function (i, country) {
                    $("#permanent_country").append(`<option value="${country.country}">${country.country}</option>`);
                    $("#residing_county").append(`<option value="${country.country}">${country.country}</option>`);
                });
                
                console.log('Countries loaded, total options:', $("#permanent_country option").length);
                
                // After countries are loaded, load contact details to bind dropdown values
                setTimeout(function() {
                    loadContactDetails();
                }, 200);
            });
        }

        function bindDropdownValue(selector, value) {
            console.log('bindDropdownValue called:', selector, value);
            if (value) {
                var $select = $(selector);
                console.log('Select element found:', $select.length);
                console.log('Total options in dropdown:', $select.find('option').length);
                
                // Try multiple approaches to bind the value
                var success = false;
                
                // Method 1: Direct value match
                var $option = $select.find('option[value="' + value + '"]');
                if ($option.length > 0) {
                    $select.val(value);
                    console.log('Successfully set ' + selector + ' to:', value, '(by value)');
                    success = true;
                }
                
                // Method 2: Text match
                if (!success) {
                    var $optionByText = $select.find('option').filter(function() {
                        return $(this).text().trim().toLowerCase() === value.trim().toLowerCase();
                    });
                    
                    if ($optionByText.length > 0) {
                        $optionByText.prop('selected', true);
                        console.log('Successfully set ' + selector + ' to:', value, '(by text)');
                        success = true;
                    }
                }
                
                // Method 3: Partial text match
                if (!success) {
                    var $optionByPartialText = $select.find('option').filter(function() {
                        return $(this).text().trim().toLowerCase().indexOf(value.trim().toLowerCase()) !== -1;
                    });
                    
                    if ($optionByPartialText.length > 0) {
                        $optionByPartialText.prop('selected', true);
                        console.log('Successfully set ' + selector + ' to:', value, '(by partial text)');
                        success = true;
                    }
                }
                
                if (!success) {
                    console.warn('Could not bind value for ' + selector + ':', value);
                    console.log('Available options:', $select.find('option').map(function () { 
                        return { value: this.value, text: $(this).text() }; 
                    }).get());
                }
            }
        }
        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'permanent_address', 'address_line_1', 'permanent_city', 'permanent_state', 'permanent_country',
                'residing_address', 'residing_address_line_1', 'residing_city', 'residing_state', 'residing_county'
            ];

            requiredFields.forEach(function (fieldId) {
                var field = $('#' + fieldId);
                if (!field.val() || field.val().trim() === '') {
                    field.addClass('is-invalid');
                    isValid = false;
                } else {
                    field.removeClass('is-invalid');
                }
            });

            return isValid;
        }

        function saveContactDetails() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var formData = {
                permanent_address: $('#permanent_address').val(),
                address_line_1: $('#address_line_1').val(),
                address_line_2: $('#address_line_2').val(),
                permanent_city: $('#permanent_city').val(),
                permanent_state: $('#permanent_state').val(),
                permanent_country: $('#permanent_country').val(),
                residing_address: $('#residing_address').val(),
                residing_address_line_1: $('#residing_address_line_1').val(),
                residing_address_line_2: $('#residing_address_line_2').val(),
                residing_city: $('#residing_city').val(),
                residing_state: $('#residing_state').val(),
                residing_county: $('#residing_county').val()
            };

            // Show loading state
            $('#btnSave').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-2"></span>Saving...');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/SaveContactDetails",
                data: JSON.stringify({ formDataJson: JSON.stringify(formData) }),
                dataType: "json",
                success: function (response) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');

                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'Contact details saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save contact details');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save contact details');
                    }
                },
                error: function (xhr, status, error) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');
                    console.error('AJAX Error:', error);
                    showErrorMessage('An error occurred while saving contact details');
                }
            });
        }

        function showErrorMessage(message) {
            // Create and show error modal
            var modalHtml = `
                <div class="modal fade" id="errorModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header bg-danger text-white">
                                <h5 class="modal-title">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Error
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <p class="mb-0">${message}</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            `;
            
            $('#errorModal').remove();
            $('body').append(modalHtml);
            $('#errorModal').modal('show');
        }

        function showTopRightMessage(message) {
            // Create and show success message in top right corner
            var alertHtml = `
                <div class="alert alert-success alert-dismissible fade show position-fixed" 
                     style="top: 20px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);">
                    <i class="fas fa-check-circle me-2"></i>
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            `;
            
            $('.alert-success').remove();
            $('body').append(alertHtml);
            
            // Auto remove after 5 seconds
            setTimeout(function() {
                $('.alert-success').fadeOut();
            }, 5000);
        }

        function navigateToPreviousMenu() {
            // Navigate to previous page (Personal Details)
            window.location.href = 'PersonalDetails.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (Education Details)
            window.location.href = 'EducationDetails.aspx';
        }

        function copyPermanentToResiding() {
            // Copy permanent address data to residing address fields
            $('#residing_address').val($('#permanent_address').val());
            $('#residing_address_line_1').val($('#address_line_1').val());
            $('#residing_address_line_2').val($('#address_line_2').val());
            
            // Copy dropdown values and trigger cascading updates
            var permanentCountry = $('#permanent_country').val();
            var permanentState = $('#permanent_state').val();
            var permanentCity = $('#permanent_city').val();
            
            // Set residing country
            if (permanentCountry) {
                $('#residing_county').val(permanentCountry);
                
                // Trigger state loading for residing address
                if (permanentState) {
                    // Load states for residing country
                    $.ajax({
                        url: "https://countriesnow.space/api/v0.1/countries/states",
                        method: "POST",
                        data: JSON.stringify({ country: permanentCountry }),
                        contentType: "application/json",
                        success: function (res) {
                            $("#residing_state").empty();
                            $.each(res.data.states, function (i, state) {
                                $("#residing_state").append(`<option value="${state.name}">${state.name}</option>`);
                            });
                            
                            // Set the residing state
                            $('#residing_state').val(permanentState);
                            
                            // Trigger city loading for residing address
                            if (permanentCity) {
                                $.ajax({
                                    url: "https://countriesnow.space/api/v0.1/countries/state/cities",
                                    method: "POST",
                                    data: JSON.stringify({ country: permanentCountry, state: permanentState }),
                                    contentType: "application/json",
                                    success: function (res) {
                                        $("#residing_city").empty();
                                        $.each(res.data, function (i, city) {
                                            $("#residing_city").append(`<option value="${city}">${city}</option>`);
                                        });
                                        
                                        // Set the residing city
                                        $('#residing_city').val(permanentCity);
                                    }
                                });
                            }
                        }
                    });
                }
            }
            
            // Show success message
            showTopRightMessage('Residing address copied from permanent address');
        }

        function clearResidingAddress() {
            // Clear all residing address fields
            $('#residing_address').val('');
            $('#residing_address_line_1').val('');
            $('#residing_address_line_2').val('');
            
            // Clear dropdown values and reset to default options
            $('#residing_county').val('').prop('selectedIndex', 0);
            $('#residing_state').empty().append('<option value="" selected disabled>Select Residing State</option>');
            $('#residing_city').empty().append('<option value="" selected disabled>Select Residing City</option>');
            
            // Show info message
            showTopRightMessage('Residing address fields cleared');
        }

        function loadContactDetails() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetContactDetails",
                data: '{}',
                dataType: "json",
                success: function (response) {
                   
                    processContactDetailsResponse(response);
                },
                error: function (xhr, status, error) {
                    console.error('Error loading contact details:', error);
                }
            });
        }

        function processContactDetailsResponse(response) {
            try {
                if (response && response.d) {
                    var result = JSON.parse(response.d);
                    var data = result;
                    if (Array.isArray(data) && data.length > 0) {
                        data = data[0];
                    }
                    bindContactDetailsData(data);
                }
                else {
                    console.log('No contact details data received from server');
                }
            } catch (e) {
                console.error('Error processing contact details response:', e);
            }
        }

        function bindContactDetailsData(data) {
            console.log('Binding contact details data:', data);
            console.log('Permanent country value:', data.pcountry);
            console.log('Permanent state value:', data.pstate);
            console.log('Permanent city value:', data.pcity);
            console.log('Residing county value:', data.rcountry);
            console.log('Residing state value:', data.rstate);
            console.log('Residing city value:', data.rcity);

            // Permanent Address
            if (data.permanent_address) $('#permanent_address').val(data.permanent_address);
            if (data.address_line_1) $('#address_line_1').val(data.address_line_1);
            if (data.address_line_2) $('#address_line_2').val(data.address_line_2);

            // Bind permanent country first, then trigger cascading
            if (data.pcountry) {
                bindDropdownValue('#permanent_country', data.pcountry);
                if (data.pstate) {
                    $.ajax({
                        url: "https://countriesnow.space/api/v0.1/countries/states",
                        method: "POST",
                        data: JSON.stringify({ country: data.pcountry }),
                        contentType: "application/json",
                        success: function (res) {
                            $("#permanent_state").empty();
                            $.each(res.data.states, function (i, state) {
                                $("#permanent_state").append(`<option value="${state.name}">${state.name}</option>`);
                            });
                            
                            // Bind state value
                            bindDropdownValue('#permanent_state', data.pstate);
                            if (data.pcity) {
                                $.ajax({
                                    url: "https://countriesnow.space/api/v0.1/countries/state/cities",
                                    method: "POST",
                                    data: JSON.stringify({ country: data.pcountry, state: data.pstate }),
                                    contentType: "application/json",
                                    success: function (res) {
                                        $("#permanent_city").empty();
                                        $.each(res.data, function (i, city) {
                                            $("#permanent_city").append(`<option value="${city}">${city}</option>`);
                                        });
                                        
                                        // Bind city value
                                        bindDropdownValue('#permanent_city', data.permanent_city);
                                    }
                                });
                            }
                        }
                    });
                }
            }

            // Residing Address
            if (data.residing_address) $('#residing_address').val(data.residing_address);
            if (data.raddress_line_1) $('#residing_address_line_1').val(data.raddress_line_1);
            if (data.raddress_line_2) $('#residing_address_line_2').val(data.raddress_line_2);

            // Bind residing country first, then trigger cascading
            if (data.rcounty) {
             
                bindDropdownValue('#residing_county', data.rcounty);
                
                // Load states for residing country and bind state
                if (data.rstate) {
                    $.ajax({
                        url: "https://countriesnow.space/api/v0.1/countries/states",
                        method: "POST",
                        data: JSON.stringify({ country: data.rcounty }),
                        contentType: "application/json",
                        success: function (res) {
                            $("#residing_state").empty();
                            $.each(res.data.states, function (i, state) {
                                $("#residing_state").append(`<option value="${state.name}">${state.name}</option>`);
                            });
                            
                            // Bind state value
                            bindDropdownValue('#residing_state', data.rstate);
                            
                            // Load cities for residing state and bind city
                            if (data.rcity) {
                                $.ajax({
                                    url: "https://countriesnow.space/api/v0.1/countries/state/cities",
                                    method: "POST",
                                    data: JSON.stringify({ country: data.rcounty, state: data.rstate }),
                                    contentType: "application/json",
                                    success: function (res) {
                                        $("#residing_city").empty();
                                        $.each(res.data, function (i, city) {
                                            $("#residing_city").append(`<option value="${city}">${city}</option>`);
                                        });
                                        bindDropdownValue('#residing_city', data.rcity);
                                    }
                                });
                            }
                        }
                    });
                }
            }

            console.log('Contact details form data bound successfully');
        }
    </script>
</asp:Content>

