<%@ Page Title="Bank Account Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="BankAccountDetails.aspx.cs" Inherits="Admin_Profile_BankAccountDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
       
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="bank-account-details-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                            <i class="fas fa-university me-2" style="font-size: 1rem;"></i>
                            Bank Account Details - For Internal Purpose
                        </h5>
                    </div>
                </div>

                <!-- Bank Account Form -->
                <div class="card mb-4" id="bankAccountForm">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-credit-card me-2" style="font-size: 0.85rem;"></i>
                            Account Information
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label required">Beneficiary Name</label>
                                <input type="text" id="beneficiary_name" name="beneficiary_name" class="form-control" placeholder="Enter beneficiary name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Bank Account Number</label>
                                <input type="text" id="bank_account_no" name="bank_account_no" class="form-control" placeholder="Enter account number" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Account Type</label>
                                <select id="account_type" name="account_type" class="form-select" required>
                                    <option value="" selected disabled>Select Account Type</option>
                                    <option value="Savings">Savings</option>
                                    <option value="Current">Current</option>
                                    <option value="Fixed Deposit">Fixed Deposit</option>
                                    <option value="Recurring Deposit">Recurring Deposit</option>
                                    <option value="Salary">Salary</option>
                                    <option value="NRI">NRI</option>
                                    <option value="Joint">Joint</option>
                                    <option value="Minor">Minor</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">IFSC Code</label>
                                <input type="text" id="ifsc_code" name="ifsc_code" class="form-control" placeholder="Enter IFSC code" required>
                                <small class="text-muted">Format: ABCD0123456</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Bank Name</label>
                                <input type="text" id="bank_name" name="bank_name" class="form-control" placeholder="Enter bank name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Branch Name</label>
                                <input type="text" id="branch_name" name="branch_name" class="form-control" placeholder="Enter branch name" required>
                            </div>
                            <div class="col-md-12" style="padding-top: 15px;">
                                <button type="button" id="btnClearForm" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-times me-2"></i>
                                    Clear Form
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Navigation Buttons -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <button type="button" id="btnPrevious" class="btn btn-secondary btn-sm">
                                    <i class="fas fa-arrow-left me-2"></i>
                                    Previous
                                </button>
                            </div>
                            <div>
                                <button type="button" id="btnSaveBankAccount" class="btn btn-success btn-sm me-2">
                                    <i class="fas fa-save me-2"></i>
                                    Save Bank Account Details
                                </button>
                                <button type="button" id="btnNext" class="btn btn-primary btn-sm">
                                    <i class="fas fa-arrow-right me-2"></i>
                                    Next
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .personal-details-container {
            font-size: 13px;
            padding: 20px;
            background-color: #f8f9fa;
            min-height: 100vh;
        }

        .card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .card-header {
            padding: 12px 16px;
            margin-bottom: 0;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            border-radius: 8px 8px 0 0;
        }

        .card-header h5 {
            font-size: 0.95rem;
            color: black;
            margin: 0;
        }

        .card-body {
            padding: 16px;
        }

        .form-label {
            font-size: 12px;
            font-weight: 500;
            margin-bottom: 6px;
            color: #495057;
        }

        .form-label.required::after {
            content: " *";
            color: #dc3545;
        }

        .form-control, .form-select {
            padding: 8px 12px;
            font-size: 13px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            background-color: #fff;
        }

        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn {
            padding: 6px 12px;
            font-size: 12px;
            border-radius: 4px;
            border: 1px solid transparent;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-sm {
            padding: 5px 10px;
            font-size: 11px;
            border-radius: 3px;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007bff 0%, #0056b3 100%);
            border-color: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #0056b3 0%, #004085 100%);
            border-color: #0056b3;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0, 123, 255, 0.3);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
            border-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #5a6268 0%, #495057 100%);
            border-color: #5a6268;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(108, 117, 125, 0.3);
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
            
            .btn-sm {
                padding: 4px 8px;
                font-size: 10px;
            }
        }
    </style>

    <script>
        $(document).ready(function () {
            // Save bank account button click handler
            $('#btnSaveBankAccount').click(function () {
                saveBankAccountDetails();
            });

            // Clear form button click handler
            $('#btnClearForm').click(function () {
                clearForm();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Next button click handler
            $('#btnNext').click(function () {
                navigateToNextMenu();
            });

            // IFSC code validation
            $('#ifsc_code').on('input', function () {
                validateIFSCCode();
            });

            // Load existing bank account details
            loadBankAccountDetails();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'beneficiary_name', 'bank_account_no', 'account_type',
                'ifsc_code', 'bank_name', 'branch_name'
            ];

            requiredFields.forEach(function (fieldId) {
                var field = $('#' + fieldId);
                if (!field.val()) {
                    field.addClass('is-invalid');
                    isValid = false;
                } else {
                    field.removeClass('is-invalid');
                }
            });

            return isValid;
        }

        function validateIFSCCode() {
            var ifscCode = $('#ifsc_code').val();
            var ifscPattern = /^[A-Z]{4}0[A-Z0-9]{6}$/;

            if (ifscCode && !ifscPattern.test(ifscCode)) {
                $('#ifsc_code').addClass('is-invalid');
                showErrorMessage('IFSC code format is invalid. Format: ABCD0123456');
                return false;
            } else {
                $('#ifsc_code').removeClass('is-invalid');
                return true;
            }
        }

        function saveBankAccountDetails() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            if (!validateIFSCCode()) {
                return;
            }

            $('#btnSaveBankAccount').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            var bankAccountData = {
                beneficiary_name: $('#beneficiary_name').val(),
                bank_account_no: $('#bank_account_no').val(),
                account_type: $('#account_type').val(),
                ifsc_code: $('#ifsc_code').val(),
                bank_name: $('#bank_name').val(),
                branch_name: $('#branch_name').val()
            };

            $.ajax({
                url: '../../WebService.asmx/SaveBankDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ formDataJson: JSON.stringify(bankAccountData) }),
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'Bank account details saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save bank account details');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save bank account details');
                    }
                },
                error: function (xhr, status, error) {
                    showErrorMessage('Error saving bank account details: ' + error);
                    console.error('AJAX Error:', xhr.responseText);
                },
                complete: function () {
                    $('#btnSaveBankAccount').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save Bank Account Details');
                }
            });
        }

        function loadBankAccountDetails() {
            $.ajax({
                url: '../../WebService.asmx/GetBankDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            bindBankAccountData(result);
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading bank account details:', error);
                }
            });
        }

        function bindBankAccountData(data) {
            $('#beneficiary_name').val(data[0].beneficiary_name || '');
            $('#bank_account_no').val(data[0].bank_account_no || '');
            $('#account_type').val(data[0].account_type || '');
            $('#ifsc_code').val(data[0].ifsc_code || '');
            $('#bank_name').val(data[0].bank_name || '');
            $('#branch_name').val(data[0].branch_name || '');
        }

        function clearForm() {
            $('#beneficiary_name').val('');
            $('#bank_account_no').val('');
            $('#account_type').val('');
            $('#ifsc_code').val('');
            $('#bank_name').val('');
            $('#branch_name').val('');

            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function navigateToPreviousMenu() {
            // Navigate to previous page (Experience Details)
            window.location.href = 'ExperienceDetails.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (if any)
            showTopRightMessage('Bank account details completed!');
        }

        function showTopRightMessage(message) {
            // Remove existing messages
            $('.top-right-message').remove();

            // Create new message
            var messageHtml = `
                <div class="top-right-message alert alert-success alert-dismissible fade show" 
                     style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                    <i class="fas fa-check-circle me-2"></i>
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            `;

            $('body').append(messageHtml);

            // Auto-remove after 5 seconds
            setTimeout(function () {
                $('.top-right-message').fadeOut();
            }, 5000);
        }

        function showErrorMessage(message) {
            // Remove existing messages
            $('.error-message').remove();

            // Create new message
            var messageHtml = `
                <div class="error-message alert alert-danger alert-dismissible fade show" 
                     style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; min-width: 300px; box-shadow: 0 4px 6px rgba(0,0,0,0.1);">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            `;

            $('body').append(messageHtml);

            // Auto-remove after 5 seconds
            setTimeout(function () {
                $('.error-message').fadeOut();
            }, 5000);
        }
    </script>

</asp:Content>

