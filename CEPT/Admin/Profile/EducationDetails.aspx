<%@ Page Title="Education Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="EducationDetails.aspx.cs" Inherits="Admin_Profile_EducationDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
    <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="education-details-tab" role="tabpanel">
                <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                        <i class="fas fa-graduation-cap me-2" style="font-size: 1rem;"></i>
                        Education Details
                    </h5>
                </div>

        <form id="educationDetailsForm" class="personal-details-form">
            <!-- Add New Education Section -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                        Add New Education
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label required">Program</label>
                            <select id="program" name="program" class="form-select" required>
                                <option value="" selected disabled>Select Program</option>
                                <option value="1">UG</option>
                                <option value="2">PG</option>
                                <option value="3">Doctoral</option></select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Degree</label>
                            <input type="text" id="degree" name="degree" class="form-control" placeholder="Enter degree" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Specialization/Field (if applicable)</label>
                            <input type="text" id="specialization" name="specialization" class="form-control" placeholder="Enter specialization or field">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">University/Institute</label>
                            <input type="text" id="university" name="university" class="form-control" placeholder="Enter university or institute" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label required">Start Date</label>
                            <input type="date" id="start_date" name="start_date" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label required">End Date</label>
                            <input type="date" id="end_date" name="end_date" class="form-control" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label required">Percentage/CGPA</label>
                            <select id="percentage_cgpa" name="percentage_cgpa" class="form-select" required>
                                <option value="" selected disabled>Select Type</option>
                                <option value="Percentage">Percentage</option>
                                <option value="CGPA">CGPA</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Percentage/Division</label>
                            <input type="text" id="percentage_division" name="percentage_division" class="form-control" placeholder="Enter percentage or division" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label required">Mode</label>
                            <select id="mode" name="mode" class="form-select" required>
                                <option value="" selected disabled>Select Mode</option>
                                <option value="Regular">Regular (Full-time)</option>
                                <option value="Part-time">Part-time</option>
                                <option value="Distance Learning">Distance Learning</option>
                            </select>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Marksheet/Grade File Upload</label>
                            <div class="file-upload-container">
                                <input type="file" id="marksheet_file" name="marksheet_file" class="form-control" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" style="display: none;">
                                <div class="file-upload-display">
                                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="document.getElementById('marksheet_file').click()">
                                        <i class="fas fa-upload me-2"></i>
                                        Choose File
                                    </button>
                                    <span id="file-name" class="file-name-display">No file chosen</span>
                                </div>
                                <small class="text-muted">Supported formats: PDF, JPG, PNG, DOC, DOCX (Max 5MB)</small>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <button type="button" id="btnAddEducation" class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-2"></i>
                                Add Education
                            </button>
                            <button type="button" id="btnUpdateEducation" class="btn btn-warning btn-sm" style="display: none;">
                                <i class="fas fa-edit me-2"></i>
                                Update Education
                            </button>
                            <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                <i class="fas fa-times me-2"></i>
                                Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Education Records List -->
            <div class="card mb-4">
                <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                    <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                        <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                        Education Records
                    </h5>
                </div>
                <div class="card-body">
                    <div id="educationRecordsList">
                        <!-- Education records will be dynamically added here -->
                        <div class="text-center text-muted py-4">
                            <i class="fas fa-graduation-cap fa-2x mb-3"></i>
                            <p>No education records added yet. Add your first education record above.</p>
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

        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            border-color: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
            border-color: #e0a800;
            transform: translateY(-1px);
        }

        .education-record {
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 15px;
            margin-bottom: 12px;
            background: #fff;
            transition: all 0.2s ease;
        }

        .education-record:hover {
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            border-color: #007bff;
        }

        .education-record-header {
            display: flex;
            justify-content: between;
            align-items: center;
            margin-bottom: 10px;
        }

        .education-record-title {
            font-weight: 600;
            color: #495057;
            font-size: 14px;
            margin: 0;
        }

        .education-record-actions {
            display: flex;
            gap: 8px;
        }

        .education-record-details {
            font-size: 12px;
            color: #6c757d;
            line-height: 1.4;
        }

        .education-record-details .detail-item {
            margin-bottom: 4px;
        }

        .education-record-details .detail-label {
            font-weight: 500;
            color: #495057;
        }

        .table {
            font-size: 12px;
            margin-bottom: 0;
        }

        .table th {
            border-top: none;
            border-bottom: 2px solid #dee2e6;
            padding: 12px 8px;
            background-color: #f8f9fa;
            color: #495057;
            font-weight: 600;
        }

        .table td {
            padding: 10px 8px;
            vertical-align: middle;
            border-bottom: 1px solid #dee2e6;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .table-hover tbody tr:hover {
            background-color: rgba(0, 123, 255, 0.1);
        }

        .btn-group .btn {
            padding: 4px 8px;
            margin: 0 2px;
        }

        .btn-group .btn i {
            font-size: 10px;
        }

        .d-flex.gap-2 {
            gap: 8px !important;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 11px;
            border-radius: 4px;
            font-weight: 500;
        }

        .btn-sm i {
            font-size: 10px;
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

        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            border-color: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333 0%, #bd2130 100%);
            border-color: #c82333;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(220, 53, 69, 0.3);
        }

        .table-responsive {
            border-radius: 6px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
        }

        .file-upload-container {
            border: 2px dashed #ced4da;
            border-radius: 6px;
            padding: 15px;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }

        .file-upload-container:hover {
            border-color: #007bff;
            background-color: #f0f7ff;
        }

        .file-upload-display {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 8px;
        }

        .file-name-display {
            font-size: 12px;
            color: #6c757d;
            font-style: italic;
        }

        .file-name-display.has-file {
            color: #28a745;
            font-weight: 500;
        }

        .file-upload-container .btn-outline-secondary {
            border-color: #6c757d;
            color: #6c757d;
        }

        .file-upload-container .btn-outline-secondary:hover {
            background-color: #6c757d;
            border-color: #6c757d;
            color: white;
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
        var educationRecords = [];
        var editingIndex = -1;

        $(document).ready(function () {
            // Form validation
            $('#educationDetailsForm').on('submit', function (e) {
                e.preventDefault();
                validateForm();
            });

            // Save button click handler
            $('#btnSave').click(function () {
                saveAllEducationDetails();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Add education button click handler
            $('#btnAddEducation').click(function () {
                addEducationRecord();
            });

            // Update education button click handler
            $('#btnUpdateEducation').click(function () {
                updateEducationRecord();
                //saveAllEducationDetails();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Date validation
            $('#start_date, #end_date').change(function () {
                validateDates();
            });

            // File upload handler
            $('#marksheet_file').change(function () {
                handleFileUpload(this);
            });

            // Load existing education records
            loadEducationRecords();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'program', 'degree', 'university', 'start_date', 'end_date', 
                'percentage_cgpa', 'percentage_division', 'mode'
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

            // Validate dates
            if (!validateDates()) {
                isValid = false;
            }

            return isValid;
        }

        function validateDates() {
            var startDate = $('#start_date').val();
            var endDate = $('#end_date').val();
            var isValid = true;

            if (startDate && endDate) {
                var start = new Date(startDate);
                var end = new Date(endDate);

                if (start >= end) {
                    $('#end_date').addClass('is-invalid');
                    showErrorMessage('End date must be after start date');
                    isValid = false;
                } else {
                    $('#end_date').removeClass('is-invalid');
                }
            }

            return isValid;
        }

        function saveEducationDetails() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var formData = {
                program: $('#program').val(),
                degree: $('#degree').val(),
                specialization: $('#specialization').val(),
                university: $('#university').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                percentage_cgpa: $('#percentage_cgpa').val(),
                percentage_division: $('#percentage_division').val(),
                mode: $('#mode').val()
            };

            // Show loading state
            $('#btnSave').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-2"></span>Saving...');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/SaveEducationDetails",
                data: JSON.stringify({ formDataJson: JSON.stringify(formData) }),
                dataType: "json",
                success: function (response) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');

                    if (response && response.d) {
                        var result = response.d;
                        if (result.success) {
                            showTopRightMessage(result.message || 'Education details saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save education details');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save education details');
                    }
                },
                error: function (xhr, status, error) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');
                    console.error('AJAX Error:', error);
                    showErrorMessage('An error occurred while saving education details');
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
            // Navigate to previous page (Contact Details)
            window.location.href = 'ContactDtl.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (Experience Details)
            window.location.href = 'ExperienceDetails.aspx';
        }

        function addEducationRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var educationData = {
                program: $('#program').val(),
                degree: $('#degree').val(),
                specialization: $('#specialization').val(),
                university: $('#university').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                percentage_cgpa: $('#percentage_cgpa').val(),
                percentage_division: $('#percentage_division').val(),
                mode: $('#mode').val(),
                marksheet_file: window.uploadedFileName || null,
                marksheet_file_path: window.uploadedFilePath || null,
                id: Date.now() // Temporary ID for client-side management
            };

            educationRecords.push(educationData);
            displayEducationRecords();
            clearForm();
            
            // Clear uploaded file info
            window.uploadedFileName = null;
            window.uploadedFilePath = null;
            
            showTopRightMessage('Education record added successfully!');
        }

        function updateEducationRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            var educationData = {
                program: $('#program').val(),
                degree: $('#degree').val(),
                specialization: $('#specialization').val(),
                university: $('#university').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                percentage_cgpa: $('#percentage_cgpa').val(),
                percentage_division: $('#percentage_division').val(),
                mode: $('#mode').val(),
                marksheet_file: window.uploadedFileName || educationRecords[editingIndex].marksheet_file,
                marksheet_file_path: window.uploadedFilePath || educationRecords[editingIndex].marksheet_file_path,
                id: educationRecords[editingIndex].id
            };

            educationRecords[editingIndex] = educationData;
            displayEducationRecords();
            clearForm();
            cancelEdit();
            
            // Clear uploaded file info
            window.uploadedFileName = null;
            window.uploadedFilePath = null;
            
            showTopRightMessage('Education record updated successfully!');
        }

        function editEducationRecord(index) {
            var record = educationRecords[index];
            
            // Fill form data
            $('#program').val(record.program);
            $('#degree').val(record.degree);
            $('#specialization').val(record.specialization);
            $('#university').val(record.university);
            var dateObj = new Date(record.start_date);
            var formattedDate = dateObj.toISOString().split('T')[0];
            $('#start_date').val(formattedDate);
            var dateObjto = new Date(record.end_date);
            var toattedDate = dateObjto.toISOString().split('T')[0];
            $('#end_date').val(toattedDate);
            $('#percentage_cgpa').val(record.percentage_cgpa);
            $('#percentage_division').val(record.percentage_division);
            $('#mode').val(record.mode);
            
            // Handle file display (since we can't set file input value)
            if (record.marksheet_grade_file) {
                $('#file-name').text(record.marksheet_grade_file).addClass('has-file');
            } else {
                $('#file-name').text('No file chosen').removeClass('has-file');
            }
            
            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddEducation').hide();
            $('#btnUpdateEducation').show();
            $('#btnCancelEdit').show();
            
            // Highlight the form section
            var formCard = $('#program').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');
            
            // Remove highlight after 3 seconds
            setTimeout(function() {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', '');
            }, 3000);

           
            try {
                // Method 1: Direct element scroll
                var programField = document.getElementById('program');
                if (programField) {
                    programField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } catch (e) {
                try {
                
                    $('html, body').animate({
                        scrollTop: $('#program').offset().top - 100
                    }, 1000);
                } catch (e2) {
                    // Method 3: Simple scroll to top
                    window.scrollTo(0, 0);
                }
            }
            
            
            showTopRightMessage('Education record loaded for editing!');
        }

        function deleteEducationRecord(index) {
            if (confirm('Are you sure you want to delete this education record?')) {
                educationRecords.splice(index, 1);
                displayEducationRecords();
                showTopRightMessage('Education record deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddEducation').show();
            $('#btnUpdateEducation').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#program').val('');
            $('#degree').val('');
            $('#specialization').val('');
            $('#university').val('');
            $('#start_date').val('');
            $('#end_date').val('');
            $('#percentage_cgpa').val('');
            $('#percentage_division').val('');
            $('#mode').val('');
            $('#marksheet_file').val('');
            $('#file-name').text('No file chosen').removeClass('has-file');
            
            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function handleFileUpload(input) {
            var file = input.files[0];
            var fileNameDisplay = $('#file-name');
            
            if (file) {
                // Validate file size (5MB limit)
                if (file.size > 5 * 1024 * 1024) {
                    showErrorMessage('File size must be less than 5MB');
                    input.value = '';
                    fileNameDisplay.text('No file chosen').removeClass('has-file');
                    return;
                }
                
                // Validate file type
                var allowedTypes = ['application/pdf', 'image/jpeg', 'image/jpg', 'image/png', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
                if (!allowedTypes.includes(file.type)) {
                    showErrorMessage('Please select a valid file format (PDF, JPG, PNG, DOC, DOCX)');
                    input.value = '';
                    fileNameDisplay.text('No file chosen').removeClass('has-file');
                    return;
                }
                
                // Upload file to server
                Uploadweekimagpdf(input.id);
            }
            else
            {
                fileNameDisplay.text('No file chosen').removeClass('has-file');
            }
        }

        function displayEducationRecords() {
            var container = $('#educationRecordsList');
            
            if (educationRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-graduation-cap fa-2x mb-3"></i>
                        <p>No education records added yet. Add your first education record above.</p>
                    </div>
                `);
                return;
            }

            var html = `
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-light">
                            <tr>
                                <th style="font-size: 12px; font-weight: 600;">S.No</th>
                                <th style="font-size: 12px; font-weight: 600;">Program</th>
                                <th style="font-size: 12px; font-weight: 600;">Degree</th>
                                <th style="font-size: 12px; font-weight: 600;">Specialization</th>
                                <th style="font-size: 12px; font-weight: 600;">University/Institute</th>
                                <th style="font-size: 12px; font-weight: 600;">Start Date</th>
                                <th style="font-size: 12px; font-weight: 600;">End Date</th>
                                <th style="font-size: 12px; font-weight: 600;">Percentage/CGPA</th>
                                <th style="font-size: 12px; font-weight: 600;">Mode</th>
                                <th style="font-size: 12px; font-weight: 600;">Marksheet</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            educationRecords.forEach(function(record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">${record.program}</td>
                        <td style="font-size: 12px;">${record.degree}</td>
                        <td style="font-size: 12px;">${record.specialization || '-'}</td>
                        <td style="font-size: 12px;">${record.university}</td>
                        <td style="font-size: 12px;">${formatDate(record.start_date)}</td>
                        <td style="font-size: 12px;">${formatDate(record.end_date)}</td>
                        <td style="font-size: 12px;">${record.percentage_division} (${record.percentage_cgpa})</td>
                        <td style="font-size: 12px;">${record.mode}</td>
                        <td style="font-size: 12px;">
                            ${record.marksheet_file ?
                                `<div class="d-flex align-items-center gap-2">
                                    <span class="badge bg-success"><i class="fas fa-file me-1"></i>${record.marksheet_file}</span>
                                    ${record.marksheet_file_path ?
                        `<button type="button" class="btn btn-outline-primary btn-sm" onclick="downloadFile('${record.marksheet_file_path}', '${record.marksheet_file}')" title="Download File">
                                            <i class="fas fa-download"></i>
                                        </button>` : ''
                                    }
                                </div>` : 
                                `<span class="badge bg-secondary"><i class="fas fa-times me-1"></i>No File</span>`
                            }
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editEducationRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteEducationRecord(${index})" title="Delete Record">
                                    <i class="fas fa-trash me-1"></i>
                                    Delete
                                </button>
                            </div>
                        </td>
                    </tr>
                `;
            });

            html += `
                        </tbody>
                    </table>
                </div>
            `;

            container.html(html);
        }

        function formatDate(dateString) {
            if (!dateString) return '';
            
            var date = new Date(dateString);
            if (isNaN(date.getTime())) {
                return dateString; // Return original if can't parse
            }
            
            // Format as dd-MM-yyyy
            var day = String(date.getDate()).padStart(2, '0');
            var month = String(date.getMonth() + 1).padStart(2, '0');
            var year = date.getFullYear();
            
            return day + '-' + month + '-' + year;
        }

        function saveAllEducationDetails() {
            if (educationRecords.length === 0) {
                showErrorMessage('Please add at least one education record');
                return;
            }

            // Show loading state
            $('#btnSave').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-2"></span>Saving...');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/SaveEducationDetails",
                data: JSON.stringify({ formDataJson: JSON.stringify(educationRecords) }),
                dataType: "json",
                success: function (response) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');

                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.success) {
                            showTopRightMessage(result.message || 'All education details saved successfully!');
                            $('#btnNext').prop('disabled', false);
                        } else {
                            showErrorMessage(result.message || 'Failed to save education details');
                            if (result.error) {
                                console.error('Error details:', result.error);
                            }
                        }
                    } else {
                        showErrorMessage('Failed to save education details');
                    }
                },
                error: function (xhr, status, error) {
                    $('#btnSave').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save');
                    console.error('AJAX Error:', error);
                    showErrorMessage('An error occurred while saving education details');
                }
            });
        }

        function loadEducationRecords() {
            // Load existing education records from server
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetEducationDetails",
                data: "{}",
                dataType: "json",
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            educationRecords = result;
                            displayEducationRecords();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading education records:', error);
                }
            });
        }


        function Uploadweekimagpdf(fileInputId) {
            try {
                var fileInput = $('#' + fileInputId);
                var file = fileInput[0].files[0];
                
                if (!file) {
                    showErrorMessage('Please select a file to upload');
                    return false;
                }

                // Validate file size (5MB limit)
                if (file.size > 5 * 1024 * 1024) {
                    showErrorMessage('File size must be less than 5MB');
                    fileInput.val('');
                    return false;
                }

                // Validate file type
                var allowedTypes = ['application/pdf', 'image/jpeg', 'image/jpg', 'image/png', 'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
                if (!allowedTypes.includes(file.type)) {
                    showErrorMessage('Please select a valid file format (PDF, JPG, PNG, DOC, DOCX)');
                    fileInput.val('');
                    return false;
                }

                // Show upload progress
                showUploadProgress();

                // Create FormData for file upload
                var formData = new FormData();
                formData.append('file', file);
                formData.append('documentType', $("#program option:selected").text());
                formData.append('userId', getCurrentUserId());

                $.ajax({
                    url: '../../Handler/UserUploadFile.ashx',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    xhr: function() {
                        var xhr = new window.XMLHttpRequest();
                        xhr.upload.addEventListener("progress", function(evt) {
                            if (evt.lengthComputable) {
                                var percentComplete = evt.loaded / evt.total * 100;
                                updateUploadProgress(percentComplete);
                            }
                        }, false);
                        return xhr;
                    },
                    success: function(response) {
                        hideUploadProgress();
                        var responsedata = JSON.parse(response);
                        if (responsedata && responsedata.error == '') {
                            // Upload successful
                            $('#file-name').text(responsedata.upfile).addClass('has-file');
                            showTopRightMessage('File uploaded successfully: ' + file.name);
                            
                            // Store file information for later use
                            window.uploadedFileName = responsedata.upfile;
                            window.uploadedFilePath = responsedata.upfile || responsedata.upfile;
                            
                            return true;
                        } else {
                            // Upload failed
                            showErrorMessage('File upload failed: ' + (responsedata.error || 'Unknown error'));
                            fileInput.val('');
                            $('#file-name').text('No file chosen').removeClass('has-file');
                            return false;
                        }
                    },
                    error: function(xhr, status, error) {
                        hideUploadProgress();
                        showErrorMessage('File upload error: ' + error);
                        fileInput.val('');
                        $('#file-name').text('No file chosen').removeClass('has-file');
                        return false;
                    }
                });
            }
            catch (e) {
                hideUploadProgress();
                showErrorMessage('Exception occurred: ' + e.message);
                return false;
            }
        }

        function showUploadProgress() {
            var progressHtml = `
                <div id="uploadProgress" class="alert alert-info" style="position: fixed; top: 20px; right: 20px; z-index: 9999; min-width: 300px;">
                    <div class="d-flex align-items-center">
                        <div class="spinner-border spinner-border-sm me-2" role="status">
                            <span class="visually-hidden">Uploading...</span>
                        </div>
                        <div class="flex-grow-1">
                            <div class="progress" style="height: 6px;">
                                <div class="progress-bar" role="progressbar" style="width: 0%" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                            <small>Uploading file... 0%</small>
                        </div>
                    </div>
                </div>
            `;
            
            $('body').append(progressHtml);
        }

        function updateUploadProgress(percent) {
            if ($('#uploadProgress').length > 0) {
                $('#uploadProgress .progress-bar').css('width', percent + '%');
                $('#uploadProgress small').text(`Uploading file... ${Math.round(percent)}%`);
            }
        }

        function hideUploadProgress() {
            $('#uploadProgress').remove();
        }

        function getCurrentUserId() {
            // Try to get user ID from various sources
            if (typeof window.userId !== 'undefined') {
                return window.userId;
            }
            
            // Check session storage
            if (sessionStorage.getItem('userId')) {
                return sessionStorage.getItem('userId');
            }
            
            // Check hidden field
            if ($('#userIdField').length) {
                return $('#userIdField').val();
            }
            
            // Default fallback
            return '1';
        }

        function downloadFile(filePath, fileName) {
            if (!filePath) {
                showErrorMessage('File path not available');
                return;
            }

            // Create a temporary link to download the file
            var link = document.createElement('a');
            link.href = '../../Handler/Exercises_Upload.ashx?action=download&filePath=' + encodeURIComponent(filePath) + '&fileName=' + encodeURIComponent(fileName);
            link.download = fileName;
            link.target = '_blank';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
            showTopRightMessage('Download started: ' + fileName);
        }
    </script>
</asp:Content>

