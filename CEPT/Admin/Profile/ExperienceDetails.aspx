<%@ Page Title="Experience Details" Language="C#" MasterPageFile="~/PersonalDetails.master" AutoEventWireup="true" CodeFile="ExperienceDetails.aspx.cs" Inherits="Admin_Profile_ExperienceDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="HeadContent" Runat="Server">
     <div class="personal-details-container">
        <div class="tab-content">
            <div class="tab-pane fade show active" id="experience-details-tab" role="tabpanel">
                
                <!-- Main Header -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color: #f8f9fa; border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 1.1rem; color: black;">
                            <i class="fas fa-briefcase me-2" style="font-size: 1rem;"></i>
                            Experience Details
                        </h5>
                    </div>
                </div>

                <!-- Experience Summary Section -->
                <div class="card mb-4" id="experienceSummarySection">
                    <div class="card-header" style="background-color: #e3f2fd; border-color: #2196f3;">
                        <h5 class="mb-0" style="font-size: 1rem; color: #1565c0;">
                            <i class="fas fa-chart-line me-2" style="font-size: 0.9rem;"></i>
                            Experience Summary
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <!-- Department Dropdown -->
                            <div class="col-md-6">
                                <label class="form-label required">Department</label>
                                <select id="department" name="department" class="form-select" required>
                                    <option value="" selected disabled>Loading Departments...</option>
                                </select>
                            </div>
                            
                            <!-- Designation Dropdown -->
                            <div class="col-md-6">
                                <label class="form-label required">Designation</label>
                                <div class="input-group">
                                    <select id="designation" name="designation" class="form-select" required>
                                        <option value="" selected disabled>Loading Designations...</option>
                                    </select>
                                    <button type="button" class="btn btn-outline-secondary" id="btnRefreshDesignations" title="Refresh Designations">
                                        <i class="fas fa-sync-alt"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Total Experience -->
                            <div class="col-md-6">
                                <label class="form-label required">Total Experience</label>
                                <div class="row">
                                    <div class="col-6">
                                        <input type="number" id="total_experience_years" name="total_experience_years" class="form-control" placeholder="Years" min="0" max="50" required>
                                        <small class="text-muted">Years</small>
                                    </div>
                                    <div class="col-6">
                                        <input type="number" id="total_experience_months" name="total_experience_months" class="form-control" placeholder="Months" min="0" max="11" required>
                                        <small class="text-muted">Months</small>
                                    </div>
                                </div>
                                <div class="invalid-feedback" id="totalExperienceError" style="display: none;">
                                    Please enter at least some total experience (Years or Months)
                                </div>
                            </div>
                            
                            <!-- Total Teaching Experience -->
                            <div class="col-md-6">
                                <label class="form-label">Total Teaching Experience</label>
                                <div class="row">
                                    <div class="col-6">
                                        <input type="number" id="total_teaching_years" name="total_teaching_years" class="form-control" placeholder="Years" min="0" max="50">
                                        <small class="text-muted">Years</small>
                                    </div>
                                    <div class="col-6">
                                        <input type="number" id="total_teaching_months" name="total_teaching_months" class="form-control" placeholder="Months" min="0" max="11">
                                        <small class="text-muted">Months</small>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Total Industry Experience -->
                            <div class="col-md-6">
                                <label class="form-label">Total Industry Experience</label>
                                <div class="row">
                                    <div class="col-6">
                                        <input type="number" id="total_industry_years" name="total_industry_years" class="form-control" placeholder="Years" min="0" max="50">
                                        <small class="text-muted">Years</small>
                                    </div>
                                    <div class="col-6">
                                        <input type="number" id="total_industry_months" name="total_industry_months" class="form-control" placeholder="Months" min="0" max="11">
                                        <small class="text-muted">Months</small>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Total Research Experience -->
                            <div class="col-md-6">
                                <label class="form-label">Total Research Experience</label>
                                <div class="row">
                                    <div class="col-6">
                                        <input type="number" id="total_research_years" name="total_research_years" class="form-control" placeholder="Years" min="0" max="50">
                                        <small class="text-muted">Years</small>
                                    </div>
                                    <div class="col-6">
                                        <input type="number" id="total_research_months" name="total_research_months" class="form-control" placeholder="Months" min="0" max="11">
                                        <small class="text-muted">Months</small>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Auto Calculate Button - Hidden -->
                            <div class="col-md-6" style="display: none;">
                                <label class="form-label">&nbsp;</label>
                                <div class="d-grid">
                                    <button type="button" id="btnAutoCalculate" class="btn btn-info btn-sm">
                                        <i class="fas fa-calculator me-2"></i>
                                        Auto Calculate from Records
                                    </button>
                                </div>
                            </div>
                            
                            <!-- Calculated Summary Display - Always Visible -->
                            <div class="col-md-12">
                                <div id="calculatedSummaryDisplay" class="mt-3">
                                    <div class="alert alert-info">
                                        <h6 class="mb-3"><i class="fas fa-chart-bar me-2"></i>Experience Summary</h6>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="text-center">
                                                    <div class="h5 text-primary mb-1" id="totalMonthsDisplay">0</div>
                                                    <small class="text-muted">Total Experience Months</small>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="text-center">
                                                    <div class="h5 text-success mb-1" id="teachingMonthsDisplay">0</div>
                                                    <small class="text-muted">Total Teaching Months</small>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="text-center">
                                                    <div class="h5 text-warning mb-1" id="industryMonthsDisplay">0</div>
                                                    <small class="text-muted">Total Industry Months</small>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="text-center">
                                                    <div class="h5 text-info mb-1" id="researchMonthsDisplay">0</div>
                                                    <small class="text-muted">Total Research Months</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Add New Experience Form -->
                <div class="card mb-4" id="experienceForm">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-plus-circle me-2" style="font-size: 0.85rem;"></i>
                            Add New Experience
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="form-label required">Organization Name</label>
                                <input type="text" id="organization_name" name="organization_name" class="form-control" placeholder="Enter organization name" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Designation</label>
                                <input type="text" id="designation_record" name="designation_record" class="form-control" placeholder="Enter designation" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Experience Type</label>
                                <select id="experience_type" name="experience_type" class="form-select" required>
                                    <option value="" selected disabled>Select Experience Type</option>
                                    <option value="Teaching">Teaching</option>
                                    <option value="Industry">Industry</option>
                                    <option value="Research">Research</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Mode of Experience</label>
                                <select id="mode_of_experience" name="mode_of_experience" class="form-select" required>
                                    <option value="" selected disabled>Select Mode</option>
                                    <option value="Full Time">Full Time</option>
                                    <option value="Part Time">Part Time</option>
                                    <option value="Contract">Contract</option>
                                    <option value="Freelance">Freelance</option>
                                    <option value="Internship">Internship</option>
                                    <option value="Consulting">Consulting</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label required">Start Date</label>
                                <input type="date" id="start_date" name="start_date" class="form-control" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">End Date</label>
                                <input type="date" id="end_date" name="end_date" class="form-control">
                                <small class="text-muted">Leave empty if currently working</small>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Total Hours per Week</label>
                                <input type="number" id="total_hours_in_week" name="total_hours_in_week" class="form-control" placeholder="Enter hours per week" min="1" max="168">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Total Years/Months Count</label>
                                <input type="text" id="total_year_months_counts" name="total_year_months_counts" class="form-control" placeholder="Auto-calculated" readonly>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label">Experience Document Upload</label>
                                <div class="file-upload-container">
                                    <input type="file" id="experienced_document_ref" name="experienced_document_ref" class="form-control" accept=".pdf,.jpg,.jpeg,.png,.doc,.docx" style="display: none;">
                                    <div class="file-upload-display">
                                        <button type="button" class="btn btn-outline-secondary btn-sm" onclick="document.getElementById('experienced_document_ref').click()">
                                            <i class="fas fa-upload me-2"></i>
                                            Choose File
                                        </button>
                                        <span id="exp-file-name" class="file-name-display">No file chosen</span>
                                    </div>
                                    <small class="text-muted">Supported formats: PDF, JPG, PNG, DOC, DOCX (Max 5MB)</small>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <button type="button" id="btnAddExperience" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-2"></i>
                                    Add Experience
                                </button>
                                <button type="button" id="btnUpdateExperience" class="btn btn-warning btn-sm" style="display: none;">
                                    <i class="fas fa-edit me-2"></i>
                                    Update Experience
                                </button>
                                <button type="button" id="btnCancelEdit" class="btn btn-secondary btn-sm" style="display: none;">
                                    <i class="fas fa-times me-2"></i>
                                    Cancel
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Experience Records List -->
                <div class="card mb-4">
                    <div class="card-header" style="background-color:#f8f9fa;border-color: #dee2e6;">
                        <h5 class="mb-0" style="font-size: 0.95rem; color: black;">
                            <i class="fas fa-list me-2" style="font-size: 0.85rem;"></i>
                            Experience Records List
                        </h5>
                    </div>
                    <div class="card-body">
                        <div id="experienceRecordsList">
                            <div class="text-center text-muted py-4">
                                <i class="fas fa-briefcase fa-2x mb-3"></i>
                                <p>No experience records added yet. Add your first experience record above.</p>
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
                                <button type="button" id="btnSaveAll" class="btn btn-success btn-sm me-2">
                                    <i class="fas fa-save me-2"></i>
                                    Save All
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

        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #e0a800 100%);
            border-color: #ffc107;
            color: #212529;
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e0a800 0%, #d39e00 100%);
            border-color: #e0a800;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(255, 193, 7, 0.3);
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

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #1e7e34 100%);
            border-color: #28a745;
            color: white;
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #1e7e34 0%, #155724 100%);
            border-color: #1e7e34;
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(40, 167, 69, 0.3);
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

        .d-flex.gap-2 {
            gap: 8px !important;
        }

        .btn-sm i {
            font-size: 10px;
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

        .badge {
            font-size: 10px;
            padding: 4px 8px;
        }

        /* Experience Summary Section Styles */
        #experienceSummarySection .card-header {
            background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%);
            border-color: #2196f3;
        }

        #experienceSummarySection .form-label {
            font-weight: 600;
            color: #1565c0;
            font-size: 12px;
        }

        #experienceSummarySection .form-label.required::after {
            content: " *";
            color: #d32f2f;
            font-weight: bold;
        }

        #experienceSummarySection .form-control,
        #experienceSummarySection .form-select {
            border-color: #e3f2fd;
            background-color: #fafafa;
            transition: all 0.3s ease;
        }

        #experienceSummarySection .form-control:focus,
        #experienceSummarySection .form-select:focus {
            border-color: #2196f3;
            box-shadow: 0 0 0 0.2rem rgba(33, 150, 243, 0.25);
            background-color: #fff;
        }

        #experienceSummarySection .btn-info {
            background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
            border: none;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        #experienceSummarySection .btn-info:hover {
            background: linear-gradient(135deg, #138496 0%, #117a8b 100%);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
        }

        #experienceSummarySection .row .col-6 {
            padding-left: 5px;
            padding-right: 5px;
        }

        #experienceSummarySection small.text-muted {
            font-size: 10px;
            font-weight: 500;
            color: #666 !important;
        }

        /* Summary Update Animation */
        .summary-updated {
            background-color: rgba(40, 167, 69, 0.1) !important;
            border: 1px solid rgba(40, 167, 69, 0.3) !important;
            transition: all 0.5s ease !important;
        }

        /* Calculated Summary Display Styles */
        #calculatedSummaryDisplay .h5 {
            font-weight: 600;
            transition: all 0.3s ease;
        }

        #calculatedSummaryDisplay .h5:hover {
            transform: scale(1.05);
        }

        /* Required field indicator */
        .required::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }

        /* Validation error styling */
        .is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25) !important;
        }

        .invalid-feedback {
            color: #dc3545;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        /* Input Group Styling */
        .input-group .form-select {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        .input-group .btn {
            border-top-left-radius: 0;
            border-bottom-left-radius: 0;
            border-left: 0;
        }

        .fa-spin {
            animation: fa-spin 1s infinite linear;
        }

        @keyframes fa-spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
        var experienceRecords = [];
        var editingIndex = -1;
        var calculationTimeout;
        var currentUploadedFile = null; // Track currently uploaded file

        $(document).ready(function () {
            loadDepartments();
            loadDesignations();
            $('#btnRefreshDesignations').click(function() {
                $(this).find('i').addClass('fa-spin');
                loadDesignations();
                setTimeout(function() {
                    $('#btnRefreshDesignations i').removeClass('fa-spin');
                }, 2000);
            });
            $('#btnAutoCalculate').click(function () {
                autoCalculateExperienceSummary();
            });
            $('#total_experience_years, #total_experience_months, #total_teaching_years, #total_teaching_months, #total_industry_years, #total_industry_months, #total_research_years, #total_research_months').on('change input keyup', function () {
                calculateAndDisplaySummary();
            });
            $('#total_experience_years, #total_experience_months').on('change input keyup', function () {
                validateTotalExperience();
            });
            loadExperienceRecords();
            loadExperienceSummary();
            setTimeout(function() {
                initializeSummaryDisplay();
            }, 1000);

            // Add experience button click handler
            $('#btnAddExperience').click(function () {
                addExperienceRecord();
            });

            // Update experience button click handler
            $('#btnUpdateExperience').click(function () {
                updateExperienceRecord();
            });

            // Cancel edit button click handler
            $('#btnCancelEdit').click(function () {
                cancelEdit();
            });

            // Save all button click handler
            $('#btnSaveAll').click(function () {
                saveAllExperienceDetails();
            });

            // Previous button click handler
            $('#btnPrevious').click(function () {
                navigateToPreviousMenu();
            });

            // Next button click handler
            $('#btnNext').click(function () {
                navigateToNextMenu();
            });

            // Date validation and calculation
            $('#start_date, #end_date').change(function () {
                calculateTotalMonths();
                validateDates();
            });

            // File upload handler
            $('#experienced_document_ref').change(function () {
                handleFileUpload(this);
            });

            // Load existing experience records
            loadExperienceRecords();
        });

        function validateForm() {
            var isValid = true;
            var requiredFields = [
                'organization_name', 'designation_record', 'experience_type',
                'start_date', 'mode_of_experience'
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

        function validateDates() {
            var startDate = $('#start_date').val();
            var endDate = $('#end_date').val();

            if (startDate && endDate) {
                var start = new Date(startDate);
                var end = new Date(endDate);

                if (end < start) {
                    showErrorMessage('End date cannot be before start date');
                    $('#end_date').addClass('is-invalid');
                    return false;
                } else {
                    $('#end_date').removeClass('is-invalid');
                }
            }

            return true;
        }

        function calculateTotalMonths() {
            var startDate = $('#start_date').val();
            var endDate = $('#end_date').val();

            if (startDate) {
                var start = new Date(startDate);
                var end = endDate ? new Date(endDate) : new Date();

                var years = end.getFullYear() - start.getFullYear();
                var months = end.getMonth() - start.getMonth();

                if (months < 0) {
                    years--;
                    months += 12;
                }

                var totalMonths = years * 12 + months;
                
                // Only show total months
                $('#total_year_months_counts').val(totalMonths);
            }
        }

        function addExperienceRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            // Get the uploaded file name - use currentUploadedFile variable which has the server response
            var documentRef = currentUploadedFile || null;
            
            // Fallback: check the display text if currentUploadedFile is null
            if (!documentRef) {
                var uploadedFileName = $('#exp-file-name').text();
                var hasFile = $('#exp-file-name').hasClass('has-file');
                if (hasFile && uploadedFileName !== 'No file chosen' && uploadedFileName !== 'Upload failed' && uploadedFileName !== 'Uploading...') {
                    documentRef = uploadedFileName;
                }
            }
            
            var experienceData = {
                organization_name: $('#organization_name').val(),
                designation: $('#designation_record').val(),
                experience_type: $('#experience_type').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                mode_of_experience: $('#mode_of_experience').val(),
                total_hours_in_week: $('#total_hours_in_week').val(),
                total_year_months_counts: $('#total_year_months_counts').val(),
                experienced_document_ref: documentRef,
                id: Date.now()
            };

            console.log('Adding experience record with document:', documentRef);
            console.log('Experience Data:', experienceData);

            experienceRecords.push(experienceData);
            displayExperienceRecords();
            clearForm();
            showTopRightMessage('Experience record added successfully!');
        }

        function updateExperienceRecord() {
            if (!validateForm()) {
                showErrorMessage('Please fill in all required fields');
                return;
            }

            // Use uploaded file name if new file was uploaded, otherwise keep existing
            var documentRef;
            
            // First check if a new file was uploaded
            if (currentUploadedFile) {
                documentRef = currentUploadedFile;
                console.log('Using newly uploaded file:', documentRef);
            } else {
                // No new file, check display text
                var uploadedFileName = $('#exp-file-name').text();
                var hasFile = $('#exp-file-name').hasClass('has-file');
                
                if (hasFile && uploadedFileName !== 'No file chosen' && uploadedFileName !== 'Upload failed' && uploadedFileName !== 'Uploading...') {
                    documentRef = uploadedFileName;
                    console.log('Using file from display:', documentRef);
                } else {
                    // Keep existing file reference
                    documentRef = experienceRecords[editingIndex].experienced_document_ref;
                    console.log('Keeping existing file:', documentRef);
                }
            }
            
            var experienceData = {
                organization_name: $('#organization_name').val(),
                designation: $('#designation_record').val(),
                experience_type: $('#experience_type').val(),
                start_date: $('#start_date').val(),
                end_date: $('#end_date').val(),
                mode_of_experience: $('#mode_of_experience').val(),
                total_hours_in_week: $('#total_hours_in_week').val(),
                total_year_months_counts: $('#total_year_months_counts').val(),
                experienced_document_ref: documentRef,
                id: experienceRecords[editingIndex].id
            };

            console.log('Updating experience record with document:', documentRef);
            console.log('Experience Data:', experienceData);

            experienceRecords[editingIndex] = experienceData;
            displayExperienceRecords();
            clearForm();
            cancelEdit();
            showTopRightMessage('Experience record updated successfully!');
        }

        function editExperienceRecord(index) {
            var record = experienceRecords[index];

            // Fill form data
            $('#organization_name').val(record.organization_name);
            $('#designation_record').val(record.designation);
            $('#experience_type').val(record.experience_type);
            var dateObj = new Date(record.start_date);
            var formattedDate = dateObj.toISOString().split('T')[0];

            $('#start_date').val(formattedDate);
            var dateObjto = new Date(record.end_date);
            var toattedDate = dateObjto.toISOString().split('T')[0];
            $('#end_date').val(toattedDate);
            $('#mode_of_experience').val(record.mode_of_experience);
            $('#total_hours_in_week').val(record.total_hours_in_week);
            $('#total_year_months_counts').val(record.total_year_months_counts);

            // Handle file display
            if (record.experienced_document_ref) {
                $('#exp-file-name').text(record.experienced_document_ref).addClass('has-file');
            } else {
                $('#exp-file-name').text('No file chosen').removeClass('has-file');
            }

            // Show update buttons, hide add button
            editingIndex = index;
            $('#btnAddExperience').hide();
            $('#btnUpdateExperience').show();
            $('#btnCancelEdit').show();

            // Highlight the form section
            var formCard = $('#organization_name').closest('.card');
            formCard.addClass('border-primary');
            formCard.css('box-shadow', '0 0 15px rgba(0, 123, 255, 0.3)');

            // Remove highlight after 3 seconds
            setTimeout(function () {
                formCard.removeClass('border-primary');
                formCard.css('box-shadow', '');
            }, 3000);

            // Scroll to the edit section
            try {
                var organizationField = document.getElementById('organization_name');
                if (organizationField) {
                    organizationField.scrollIntoView({ behavior: 'smooth', block: 'center' });
                }
            } catch (e) {
                try {
                    $('html, body').animate({
                        scrollTop: $('#organization_name').offset().top - 100
                    }, 1000);
                } catch (e2) {
                    window.scrollTo(0, 0);
                }
            }

            showTopRightMessage('Experience record loaded for editing!');
        }

        function deleteExperienceRecord(index) {
            if (confirm('Are you sure you want to delete this experience record?')) {
                experienceRecords.splice(index, 1);
                displayExperienceRecords();
                showTopRightMessage('Experience record deleted successfully!');
            }
        }

        function cancelEdit() {
            editingIndex = -1;
            $('#btnAddExperience').show();
            $('#btnUpdateExperience').hide();
            $('#btnCancelEdit').hide();
            clearForm();
        }

        function clearForm() {
            $('#organization_name').val('');
            $('#designation_record').val('');
            $('#experience_type').val('');
            $('#start_date').val('');
            $('#end_date').val('');
            $('#mode_of_experience').val('');
            $('#total_hours_in_week').val('');
            $('#total_year_months_counts').val('');
            $('#experienced_document_ref').val('');
            $('#exp-file-name').text('No file chosen').removeClass('has-file');
            currentUploadedFile = null; // Reset uploaded file tracking

            // Remove validation classes
            $('.form-control, .form-select').removeClass('is-invalid');
        }

        function handleFileUpload(input) {
            var file = input.files[0];
            var fileNameDisplay = $('#exp-file-name');

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

                // Show loading state
                fileNameDisplay.text('Uploading...').addClass('has-file');
                
                // Upload file to server
                uploadFileToServer(file, function(success, uploadedFileName) {
                    if (success) {
                        currentUploadedFile = uploadedFileName; // Store the uploaded file name
                        fileNameDisplay.text(uploadedFileName).addClass('has-file');
                        showTopRightMessage('File uploaded successfully!');
                    } else {
                        currentUploadedFile = null;
                        fileNameDisplay.text('Upload failed').removeClass('has-file');
                        input.value = '';
                        showErrorMessage('Failed to upload file. Please try again.');
                    }
                });
            } else {
                fileNameDisplay.text('No file chosen').removeClass('has-file');
            }
        }

        function uploadFileToServer(file, callback) {
            var formData = new FormData();
            formData.append('file', file);
            formData.append('documentType', 'ExperienceDocuments'); // Folder for experience documents
            
            console.log('=== Uploading File to Server ===');
            console.log('File name:', file.name);
            console.log('File size:', file.size);
            console.log('Document type:', 'ExperienceDocuments');
            
            $.ajax({
                url: '../../Handler/UserUploadFile.ashx',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    console.log('Upload response received:', response);
                    console.log('Response type:', typeof response);
                    
                    try {
                        // Response might be JSON or plain text
                        var result = typeof response === 'string' ? JSON.parse(response) : response;
                        console.log('Parsed result:', result);
                        
                        if (result && result.error == '') {
                            var fileName = result.fileName || result.filename || result.FileName || file.name;
                            console.log('✓ Upload successful! File name:', fileName);
                            callback(true, fileName);
                        } else {
                            console.error('✗ Upload failed:', result.message || result.error);
                            callback(false, null);
                        }
                    } catch (e) {
                        console.log('Response is not JSON, treating as plain text');
                        // If response is just the filename (plain text)
                        if (response && response.trim() !== '') {
                            console.log('✓ Upload successful! File name (plain text):', response.trim());
                            callback(true, response.trim());
                        } else {
                            console.error('✗ Error parsing upload response:', e);
                            callback(false, null);
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.error('✗ File upload AJAX error:', error);
                    console.error('Status:', status);
                    console.error('Response:', xhr.responseText);
                    callback(false, null);
                }
            });
        }

        function displayExperienceRecords() {
            var container = $('#experienceRecordsList');

            if (experienceRecords.length === 0) {
                container.html(`
                    <div class="text-center text-muted py-4">
                        <i class="fas fa-briefcase fa-2x mb-3"></i>
                        <p>No experience records added yet. Add your first experience record above.</p>
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
                                <th style="font-size: 12px; font-weight: 600;">Organization</th>
                                <th style="font-size: 12px; font-weight: 600;">Designation</th>
                                <th style="font-size: 12px; font-weight: 600;">Experience Type</th>
                                <th style="font-size: 12px; font-weight: 600;">Start Date</th>
                                <th style="font-size: 12px; font-weight: 600;">End Date</th>
                                <th style="font-size: 12px; font-weight: 600;">Mode</th>
                                <th style="font-size: 12px; font-weight: 600;">Duration</th>
                                <th style="font-size: 12px; font-weight: 600;">Document</th>
                                <th style="font-size: 12px; font-weight: 600;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
            `;

            experienceRecords.forEach(function (record, index) {
                html += `
                    <tr>
                        <td style="font-size: 12px;">${index + 1}</td>
                        <td style="font-size: 12px;">${record.organization_name}</td>
                        <td style="font-size: 12px;">${record.designation}</td>
                        <td style="font-size: 12px;">${record.experience_type}</td>
                        <td style="font-size: 12px;">${formatDate(record.start_date)}</td>
                        <td style="font-size: 12px;">${record.end_date ? formatDate(record.end_date) : 'Present'}</td>
                        <td style="font-size: 12px;">${record.mode_of_experience}</td>
                        <td style="font-size: 12px;">${record.total_year_months_counts || '-'}</td>
                        <td style="font-size: 12px;">
                            ${record.experienced_document_ref ?
                        `<span class="badge bg-success"><i class="fas fa-file me-1"></i>${record.experienced_document_ref}</span>` :
                        `<span class="badge bg-secondary"><i class="fas fa-times me-1"></i>No File</span>`
                    }
                        </td>
                        <td style="font-size: 12px;">
                            <div class="d-flex gap-2">
                                <button type="button" class="btn btn-primary btn-sm" onclick="editExperienceRecord(${index})" title="Edit Record">
                                    <i class="fas fa-edit me-1"></i>
                                    Edit
                                </button>
                                <button type="button" class="btn btn-danger btn-sm" onclick="deleteExperienceRecord(${index})" title="Delete Record">
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
            if (!dateString) return '-';
            var date = new Date(dateString);
            var day = String(date.getDate()).padStart(2, '0');
            var month = String(date.getMonth() + 1).padStart(2, '0');
            var year = date.getFullYear();
            return day + '-' + month + '-' + year;
        }

        function saveAllExperienceDetails() {
            // Validate experience summary first
            if (!validateExperienceSummary()) {
                return;
            }

            $('#btnSaveAll').prop('disabled', true).html('<i class="fas fa-spinner fa-spin me-2"></i>Saving...');

            // Save experience summary first (always required)
            saveExperienceSummary().then(function(summarySuccess) {
                if (summarySuccess) {
                    // If there are experience records, save them too
                    if (experienceRecords.length > 0) {
                        saveExperienceRecords().then(function(recordsSuccess) {
                            if (recordsSuccess) {
                                showTopRightMessage('Experience summary and records saved successfully!');
                            } else {
                                showErrorMessage('Experience summary saved but records failed to save');
                            }
                            $('#btnNext').prop('disabled', false);
                        }).catch(function(error) {
                            showErrorMessage('Error saving experience records: ' + error);
                        }).finally(function() {
                            $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                        });
                    } else {
                        showTopRightMessage('Experience summary saved successfully!');
                        $('#btnNext').prop('disabled', false);
                        $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                    }
                } else {
                    showErrorMessage('Failed to save experience summary');
                    $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                }
            }).catch(function(error) {
                showErrorMessage('Error saving experience summary: ' + error);
                $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
            });
        }

      

        function saveExperienceSummary() {
            return new Promise(function(resolve, reject) {
                var summaryData = getExperienceSummaryData();
                
                $.ajax({
                    url: '../../WebService.asmx/SaveExperienceSummary',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ 
                        formDataJson: JSON.stringify(summaryData)
                    }),
                    dataType: 'json',
                    success: function(response) {
                        try {
                            console.log('Raw response from SaveExperienceSummary:', response);
                            
                            var result = typeof response.d !== 'undefined' ? response.d : response;
                            
                            // Handle both string and object responses
                            if (typeof result === 'string') {
                                result = JSON.parse(result);
                            }
                            
                            console.log('Parsed result:', result);
                            
                            if (result.success) {
                                console.log('Experience summary saved successfully');
                                resolve(true);
                            } else {
                                console.error('Failed to save experience summary:', result.message);
                                reject(result.message || 'Failed to save experience summary');
                            }
                        } catch (e) {
                            console.error('Error parsing experience summary response:', e);
                            console.error('Response that failed to parse:', response);
                            reject('Error parsing response: ' + e.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('AJAX Error saving experience summary:', {
                            status: status,
                            error: error,
                            responseText: xhr.responseText,
                            statusCode: xhr.status
                        });
                        reject('AJAX Error: ' + error + ' (Status: ' + xhr.status + ')');
                    }
                });
            });
        }


        function saveExperienceRecords() {
            return new Promise(function (resolve, reject) {
                // Log what we're sending to the server
                console.log('=== Saving Experience Records to Database ===');
                console.log('Number of records:', experienceRecords.length);
                console.log('Experience Records Data:', experienceRecords);
                
                // Check each record for document reference
                experienceRecords.forEach(function(record, index) {
                    console.log('Record ' + index + ' document:', record.experienced_document_ref);
                });
                
                var dataToSend = JSON.stringify({ formDataJson: JSON.stringify(experienceRecords) });
                console.log('JSON Data being sent:', dataToSend);
                
                $.ajax({
                    url: '../../WebService.asmx/SaveExperienceDetails',
                    type: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: dataToSend,
                    dataType: 'json',
                    success: function (response) {
                        if (response && response.d) {
                            var result = response.d;
                            result = JSON.parse(result);
                            if (result.success) {
                                showTopRightMessage(result.message || 'Experience details saved successfully!');
                                $('#btnNext').prop('disabled', false);
                            } else {
                                showErrorMessage(result.message || 'Failed to save experience details');
                                if (result.error) {
                                    console.error('Error details:', result.error);
                                }
                            }
                        } else {
                            showErrorMessage('Failed to save experience details');
                        }
                    },
                    error: function (xhr, status, error) {
                        showErrorMessage('Error saving experience details: ' + error);
                        console.error('AJAX Error:', xhr.responseText);
                    },
                    complete: function () {
                        $('#btnSaveAll').prop('disabled', false).html('<i class="fas fa-save me-2"></i>Save All');
                    }
                });
            });
        }

        function loadExperienceRecords() {
            $.ajax({
                url: '../../WebService.asmx/GetExperienceDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function (response) {
                    if (response && response.d) {
                        var result = response.d;
                        result = JSON.parse(result);
                        if (result.length > 0) {
                            experienceRecords = result;
                            displayExperienceRecords();
                        }
                    }
                },
                error: function (xhr, status, error) {
                    console.error('Error loading experience records:', error);
                }
            });
        }

        function loadDepartments() {
            $.ajax({
                url: '../../WebService.asmx/Get_department_data',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        result = JSON.parse(result);
                        
                        $('#department').empty();
                        $('#department').append('<option value="" selected disabled>Select Department</option>');
                        
                        if (result.length > 0) {
                            result.forEach(function(dept) {
                                $('#department').append('<option value="' + dept.dept_code + '">' + dept.dept_name + '</option>');
                            });
                        }
                        else
                        {
                            loadDefaultDepartments();
                        }
                    } catch (e) {
                        console.error('Error loading departments:', e);
                        loadDefaultDepartments();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load departments:', error);
                    loadDefaultDepartments();
                }
            });
        }

        function loadDefaultDepartments() {
            var defaultDepartments = [
                { value: 'CS', text: 'Computer Science' },
                { value: 'IT', text: 'Information Technology' },
                { value: 'ECE', text: 'Electronics & Communication' },
                { value: 'ME', text: 'Mechanical Engineering' },
                { value: 'CE', text: 'Civil Engineering' },
                { value: 'EE', text: 'Electrical Engineering' },
                { value: 'CHE', text: 'Chemical Engineering' },
                { value: 'AE', text: 'Aerospace Engineering' },
                { value: 'BME', text: 'Biomedical Engineering' },
                { value: 'MGT', text: 'Management' },
                { value: 'HUM', text: 'Humanities' },
                { value: 'MATH', text: 'Mathematics' },
                { value: 'PHY', text: 'Physics' },
                { value: 'CHEM', text: 'Chemistry' },
                { value: 'OTHER', text: 'Other' }
            ];
            
            $('#department').empty();
            $('#department').append('<option value="" selected disabled>Select Department</option>');
            
            defaultDepartments.forEach(function(dept) {
                $('#department').append('<option value="' + dept.value + '">' + dept.text + '</option>');
            });
        }

        function loadDesignations() {
           
            $('#designation').empty();
            $('#designation').append('<option value="" selected disabled>Loading Designations...</option>');
            $('#designation').prop('disabled', true);
            
            $.ajax({
                url: '../../WebService.asmx/GetDesignationMasterDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                timeout: 10000, 
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        $('#designation').empty();
                        $('#designation').append('<option value="" selected disabled>Select Designation</option>');
                        if (result && result.length > 0) {
                            result.sort(function(a, b) {
                                return a.designation_name.localeCompare(b.designation_name);
                            });
                            
                            result.forEach(function(desig) {
                                if (desig.designation_code && desig.designation_name) {
                                    $('#designation').append('<option value="' + desig.designation_code + '">' + desig.designation_name + '</option>');
                                }
                            });
                        }
                        else
                        {
                            console.warn('No designations returned from Web Service, using defaults');
                           // loadDefaultDesignations();
                        }
                    } catch (e) {
                        console.error('Error parsing designation response:', e);
                        console.error('Raw response:', response);
                       // loadDefaultDesignations();
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX Error loading designations:', {
                        status: status,
                        error: error,
                        responseText: xhr.responseText,
                        statusCode: xhr.status
                    });
                    //loadDefaultDesignations();
                },
                complete: function() {
                    $('#designation').prop('disabled', false);
                }
            });
        }

        function loadDefaultDesignations() {
            console.log('Loading default designations as fallback');
            
            var defaultDesignations = [
                
                { value: 'OTHER', text: 'Other' }
            ];
            
            $('#designation').empty();
            $('#designation').append('<option value="" selected disabled>Select Designation</option>');
            
            // Sort default designations alphabetically
            defaultDesignations.sort(function(a, b) {
                return a.text.localeCompare(b.text);
            });
            
            defaultDesignations.forEach(function(desig) {
                $('#designation').append('<option value="' + desig.value + '">' + desig.text + '</option>');
            });
            
            console.log('Loaded ' + defaultDesignations.length + ' default designations');
        }

        function loadExperienceSummary() {
            $.ajax({
                url: '../../WebService.asmx/GetDesignationSaveDetails',
                type: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: '{}',
                dataType: 'json',
                success: function(response) {
                    try {
                        var result = typeof response.d !== 'undefined' ? response.d : response;
                        if (typeof result === 'string') {
                            result = JSON.parse(result);
                        }
                        
                        if (result && result.length > 0) {
                            var summary = result[0];
                            if (summary.dept_code) {
                                $('#department').val(summary.dept_code);
                            }
                            if (summary.designation_code) {
                                $('#designation').val(summary.designation_code);
                            }
                            if (summary.total_experience_years !== undefined) {
                                $('#total_experience_years').val(summary.total_experience_years);
                            }
                            if (summary.total_experience_months !== undefined) {
                                $('#total_experience_months').val(summary.total_experience_months);
                            }
                            
                            if (summary.total_teaching_years !== undefined) {
                                $('#total_teaching_years').val(summary.total_teaching_years);
                            }
                            if (summary.total_teaching_months !== undefined) {
                                $('#total_teaching_months').val(summary.total_teaching_months);
                            }
                            if (summary.total_industry_years !== undefined) {
                                $('#total_industry_years').val(summary.total_industry_years);
                            }
                            if (summary.total_industry_months !== undefined) {
                                $('#total_industry_months').val(summary.total_industry_months);
                            }
                            
                            if (summary.total_research_years !== undefined) {
                                $('#total_research_years').val(summary.total_research_years);
                            }
                            if (summary.total_research_months !== undefined) {
                                $('#total_research_months').val(summary.total_research_months);
                            }
                            setTimeout(function() {
                                calculateAndDisplaySummary();
                            }, 500);
                        }
                    } catch (e) {
                        console.error('Error parsing experience summary response:', e);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Failed to load experience summary:', error);
                }
            });
        }

        function autoCalculateExperienceSummary() {
            if (experienceRecords.length === 0) {
                showErrorMessage('No experience records available for calculation');
                return;
            }

            var totalExperience = { years: 0, months: 0 };
            var teachingExperience = { years: 0, months: 0 };
            var industryExperience = { years: 0, months: 0 };
            var researchExperience = { years: 0, months: 0 };

            experienceRecords.forEach(function(record) {
                var totalMonths = parseInt(record.total_year_months_counts) || 0;
                var years = Math.floor(totalMonths / 12);
                var months = totalMonths % 12;

               
                totalExperience.months += months;
                totalExperience.years += years;

                // Categorize by experience type
                var designation = record.designation.toLowerCase();
                var organization = record.organization_name.toLowerCase();

                // Teaching experience (includes academic positions)
                if (designation.includes('professor') || designation.includes('lecturer') || 
                    designation.includes('teacher') || designation.includes('instructor') ||
                    organization.includes('university') || organization.includes('college') ||
                    organization.includes('school') || organization.includes('institute')) {
                    teachingExperience.months += months;
                    teachingExperience.years += years;
                }
                // Research experience
                else if (designation.includes('research') || designation.includes('scientist') ||
                         designation.includes('analyst') || designation.includes('consultant')) {
                    researchExperience.months += months;
                    researchExperience.years += years;
                }
                // Industry experience (everything else)
                else {
                    industryExperience.months += months;
                    industryExperience.years += years;
                }
            });

            // Normalize months (convert to years if >= 12)
            function normalizeExperience(exp) {
                while (exp.months >= 12) {
                    exp.years++;
                    exp.months -= 12;
                }
                return exp;
            }

            totalExperience = normalizeExperience(totalExperience);
            teachingExperience = normalizeExperience(teachingExperience);
            industryExperience = normalizeExperience(industryExperience);
            researchExperience = normalizeExperience(researchExperience);

            // Update form fields
            $('#total_experience_years').val(totalExperience.years);
            $('#total_experience_months').val(totalExperience.months);
            $('#total_teaching_years').val(teachingExperience.years);
            $('#total_teaching_months').val(teachingExperience.months);
            $('#total_industry_years').val(industryExperience.years);
            $('#total_industry_months').val(industryExperience.months);
            $('#total_research_years').val(researchExperience.years);
            $('#total_research_months').val(researchExperience.months);
            displayCalculatedMonths(totalExperience, teachingExperience, industryExperience, researchExperience);
            validateTotalExperience();

            showTopRightMessage('Experience summary calculated successfully!');
        }

        function initializeSummaryDisplay() {
            calculateAndDisplaySummary();
            if (experienceRecords.length > 0) {
                autoCalculateExperienceSummary();
            }
        }

        function calculateAndDisplaySummary() {
            clearTimeout(calculationTimeout);
            calculationTimeout = setTimeout(function() {
                var totalYears = parseInt($('#total_experience_years').val()) || 0;
                var totalMonths = parseInt($('#total_experience_months').val()) || 0;
                var teachingYears = parseInt($('#total_teaching_years').val()) || 0;
                var teachingMonths = parseInt($('#total_teaching_months').val()) || 0;
                var industryYears = parseInt($('#total_industry_years').val()) || 0;
                var industryMonths = parseInt($('#total_industry_months').val()) || 0;
                var researchYears = parseInt($('#total_research_years').val()) || 0;
                var researchMonths = parseInt($('#total_research_months').val()) || 0;

               
                var totalExperience = { years: totalYears, months: totalMonths };
                var teachingExperience = { years: teachingYears, months: teachingMonths };
                var industryExperience = { years: industryYears, months: industryMonths };
                var researchExperience = { years: researchYears, months: researchMonths };

               
                displayCalculatedMonths(totalExperience, teachingExperience, industryExperience, researchExperience);
            }, 300); 
        }

        function displayCalculatedMonths(totalExp, teachingExp, industryExp, researchExp) {
            // Calculate total months for display
            var totalMonths = (totalExp.years * 12) + totalExp.months;
            var teachingMonths = (teachingExp.years * 12) + teachingExp.months;
            var industryMonths = (industryExp.years * 12) + industryExp.months;
            var researchMonths = (researchExp.years * 12) + researchExp.months;
            
            $('#totalMonthsDisplay').fadeOut(100).text(totalMonths).fadeIn(200);
            $('#teachingMonthsDisplay').fadeOut(100).text(teachingMonths).fadeIn(200);
            $('#industryMonthsDisplay').fadeOut(100).text(industryMonths).fadeIn(200);
            $('#researchMonthsDisplay').fadeOut(100).text(researchMonths).fadeIn(200);
            if (totalMonths > 0 || teachingMonths > 0 || industryMonths > 0 || researchMonths > 0) {
                $('#calculatedSummaryDisplay').addClass('summary-updated');
                setTimeout(function() {
                    $('#calculatedSummaryDisplay').removeClass('summary-updated');
                }, 1000);
            }
        }

        function validateTotalExperience() {
            var totalYears = parseInt($('#total_experience_years').val()) || 0;
            var totalMonths = parseInt($('#total_experience_months').val()) || 0;
            var hasTotalExperience = totalYears > 0 || totalMonths > 0;

            if (hasTotalExperience) {
                $('#total_experience_years').removeClass('is-invalid');
                $('#total_experience_months').removeClass('is-invalid');
                $('#totalExperienceError').hide();
            } else {
                // Only show validation error if user has interacted with the fields
                var yearsField = $('#total_experience_years');
                var monthsField = $('#total_experience_months');
                
                if (yearsField.is(':focus') || monthsField.is(':focus') || 
                    yearsField.val() !== '' || monthsField.val() !== '') {
                    $('#total_experience_years').addClass('is-invalid');
                    $('#total_experience_months').addClass('is-invalid');
                    $('#totalExperienceError').show();
                }
            }
        }

        function validateExperienceSummary() {
            var department = $('#department').val();
            
            if (!department) {
                showErrorMessage('Please select a department');
                $('#department').addClass('is-invalid');
                return false;
            } else {
                $('#department').removeClass('is-invalid');
            }

            var designation = $('#designation').val();
            
            if (!designation) {
                showErrorMessage('Please select a designation');
                $('#designation').addClass('is-invalid');
                return false;
            } else {
                $('#designation').removeClass('is-invalid');
            }

            // Validate Total Experience is mandatory
            var totalYears = parseInt($('#total_experience_years').val()) || 0;
            var totalMonths = parseInt($('#total_experience_months').val()) || 0;
            var hasTotalExperience = totalYears > 0 || totalMonths > 0;

            if (!hasTotalExperience) {
                showErrorMessage('Total Experience is mandatory. Please enter at least some total experience (Years or Months)');
                $('#total_experience_years').addClass('is-invalid');
                $('#total_experience_months').addClass('is-invalid');
                $('#totalExperienceError').show();
                return false;
            } else {
                $('#total_experience_years').removeClass('is-invalid');
                $('#total_experience_months').removeClass('is-invalid');
                $('#totalExperienceError').hide();
            }

            return true;
        }

        function getExperienceSummaryData() {
            var totalYears = parseInt($('#total_experience_years').val()) || 0;
            var totalMonths = parseInt($('#total_experience_months').val()) || 0;
            var teachingYears = parseInt($('#total_teaching_years').val()) || 0;
            var teachingMonths = parseInt($('#total_teaching_months').val()) || 0;
            var industryYears = parseInt($('#total_industry_years').val()) || 0;
            var industryMonths = parseInt($('#total_industry_months').val()) || 0;
            var researchYears = parseInt($('#total_research_years').val()) || 0;
            var researchMonths = parseInt($('#total_research_months').val()) || 0;

            return {
               
                user_id: '', 
                dept_code: $('#department').val(),
                designation_code: $('#designation').val(),
                total_experience_years: totalYears,
                total_experience_months: totalMonths,
                total_experience_total_months: (totalYears * 12) + totalMonths,
                total_teaching_years: teachingYears,
                total_teaching_months: teachingMonths,
                total_teaching_total_months: (teachingYears * 12) + teachingMonths,
                total_industry_years: industryYears,
                total_industry_months: industryMonths,
                total_industry_total_months: (industryYears * 12) + industryMonths,
                total_research_years: researchYears,
                total_research_months: researchMonths,
                total_research_total_months: (researchYears * 12) + researchMonths,
                created_date: new Date().toISOString(),
                updated_date: new Date().toISOString()
            };
        }

        

        function navigateToPreviousMenu() {
            // Navigate to previous page (Education Details)
            window.location.href = 'EducationDetails.aspx';
        }

        function navigateToNextMenu() {
            // Navigate to next page (if any)
            showTopRightMessage('Experience details completed!');
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

